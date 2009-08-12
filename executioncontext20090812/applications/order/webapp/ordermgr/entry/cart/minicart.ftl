<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#assign shoppingCart = sessionAttributes.shoppingCart?if_exists>
<#if shoppingCart?has_content>
    <#assign shoppingCartSize = shoppingCart.size()>
<#else>
    <#assign shoppingCartSize = 0>
</#if>

<div id="minicart">
    <h3>${uiLabelMap.OrderCartSummary}</h3>
    <div>
        <#if (shoppingCartSize > 0)>
          <#if hidetoplinks?default("N") != "Y">
            <ul>
              <li><a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="buttons">${uiLabelMap.OrderViewCart}</a></li>
              <li><a href="<@ofbizUrl>checkoutoptions</@ofbizUrl>" class="buttons">${uiLabelMap.OrderCheckout}</a></li>
              <li><a href="<@ofbizUrl>quickcheckout</@ofbizUrl>" class="buttons">${uiLabelMap.OrderCheckoutQuick}</a></li>
              <li><a href="<@ofbizUrl>onePageCheckout</@ofbizUrl>" class="buttons">${uiLabelMap.EcommerceOnePageCheckout}</a></li>
              <li><a href="<@ofbizUrl>googleCheckout</@ofbizUrl>" class="buttons">${uiLabelMap.EcommerceCartToGoogleCheckout}</a></li>
            </ul>
          </#if>
          <table>
            <thead>
              <tr>
                <th>${uiLabelMap.OrderQty}</th>
                <th>${uiLabelMap.OrderItem}</th>
                <th>${uiLabelMap.CommonSubtotal}</th>
              </tr>
            <thead>
            <tbody>
            <#list shoppingCart.items() as cartLine>
              <tr>
                <td>${cartLine.getQuantity()?string.number}</td>
                <td>
                  <#if cartLine.getProductId()?exists>
                      <#if cartLine.getParentProductId()?exists>
                          <a href="<@ofbizUrl>product?product_id=${cartLine.getParentProductId()}</@ofbizUrl>" class="linktext">${cartLine.getName()}</a>
                      <#else>
                          <a href="<@ofbizUrl>product?product_id=${cartLine.getProductId()}</@ofbizUrl>" class="linktext">${cartLine.getName()}</a>
                      </#if>
                  <#else>
                    <b>${cartLine.getItemTypeDescription()?if_exists}</b>
                  </#if>
                </td>
                <td><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=shoppingCart.getCurrency()/></td>
              </tr>
              <#if cartLine.getReservStart()?exists>
                <tr><td>&nbsp;</td><td colspan="2">(${cartLine.getReservStart()?string("yyyy-MM-dd")}, ${cartLine.getReservLength()} <#if cartLine.getReservLength() == 1>${uiLabelMap.CommonDay}<#else/>${uiLabelMap.CommonDays}</#if>)</td></tr>
              </#if>
            </#list>
            </tbody>
            <tfoot>
            <tr>
              <th colspan="3">
                ${uiLabelMap.OrderTotal}: <@ofbizCurrency amount=shoppingCart.getDisplayGrandTotal() isoCode=shoppingCart.getCurrency()/>
              </th>
            </tr>
            </tfoot>
          </table>
          <#if hidebottomlinks?default("N") != "Y">
            <ul>
              <li><a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="buttons">${uiLabelMap.OrderViewCart}</a></li>
              <li><a href="<@ofbizUrl>checkoutoptions</@ofbizUrl>" class="buttons">${uiLabelMap.OrderCheckout}</a></li>
              <li><a href="<@ofbizUrl>quickcheckout</@ofbizUrl>" class="buttons">${uiLabelMap.OrderCheckoutQuick}</a></li>
              <li><a href="<@ofbizUrl>onePageCheckout</@ofbizUrl>" class="buttons">${uiLabelMap.EcommerceOnePageCheckout}</a></li>
              <li><a href="<@ofbizUrl>googleCheckout</@ofbizUrl>" class="buttons">${uiLabelMap.EcommerceCartToGoogleCheckout}</a></li>
            </ul>
          </#if>
        <#else>
          <p>${uiLabelMap.OrderShoppingCartEmpty}</p>
        </#if>
    </div>
</div>
