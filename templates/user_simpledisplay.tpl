{ajaxheader modname=AddressBook filename=addressbook.js}

{if $preferences.use_img}
{ajaxheader lightbox=true}
{/if}

<div class="adr_display z-form">
    <input type="hidden" name="ot" value="{$ot|varprepfordisplay}" />
    <input type="hidden" name="private" value="{$private|varprepfordisplay}" />
    <input type="hidden" name="category" value="{$category|varprepfordisplay}" />
    <fieldset>
        {if $address.cat_id}
        {category_path id=$address.cat_id field="display_name" assign="category_name"}
        {/if}
        {if $address.prefix && $preferences.use_prefix==1}
        {category_path id=$address.prefix field="display_name" assign="prefix_name"}
        {/if}
        <legend>{if isset($category_name)}{gt text="Category" domain="module_addressbook"}: {$category_name.$lang|varprepfordisplay}{/if}</legend>
        <div class="z-clearfix">
            <div class="z-formrow">
                {if $prefix_name && $preferences.use_prefix==1}
                <span class="z-formlist">{$prefix_name.$lang|varprepfordisplay}</span>
                {/if}
                <label>{gt text="Name" domain="module_addressbook"}:</label>
                <span><strong>
                    {if $address.fname && $address.lname}
                    {$address.fname|varprepfordisplay} {$address.lname|varprepfordisplay}
                    {elseif $address.lname}
                    {$address.fname|varprepfordisplay}{$address.lname|varprepfordisplay}
                    {/if}
                </strong></span>
            </div>

            {if $address.title|varprepfordisplay}
            <div class="z-formrow">
                {if !$address.lname && !$address.fname}<strong>{/if}
                    <label>{gt text="Title" domain="module_addressbook"}:</label>
                    <span>{$address.title|varprepfordisplay}</span>
                {if !$address.lname && !$address.fname}</strong>{/if}
            </div>
            {/if}

            {if $address.company|varprepfordisplay}
            <div class="z-formrow">
                {if !$address.lname && !$address.fname}<strong>{/if}
                    <label>{gt text="Company" domain="module_addressbook"}:</label>
                    <span>{$address.company|varprepfordisplay}</span>
                {if !$address.lname && !$address.fname}</strong>{/if}
            </div>
            {/if}

            <div class="z-formrow">
                <label>{gt text="Address" domain="module_addressbook"}:</label>
                {if $address.address1}<div class="z-formlist">{$address.address1|varprepfordisplay}</div>{/if}
                {if $address.address2}<div class="z-formlist">{$address.address2|varprepfordisplay}</div>{/if}
                {if $address.zip || $address.city}<div class="z-formlist">{$address.zip|varprepfordisplay} {$address.city|varprepfordisplay}</div>{/if}
                {if $address.state}<div class="z-formlist">{$address.state|varprepfordisplay}</div>{/if}
                {if $address.country}<div class="z-formlist">{$address.country|varprepfordisplay}</div>{/if}
            </div>
            {if $address.img && $preferences.use_img==1}
            <div class="z-formnote">
                <a href="{$address.img|addressbook_img:org}" rel="lightbox"><img src="{$address.img|addressbook_img:tmb}" alt="" /></a>
            </div>
            {/if}
        </div>
    </fieldset>

    <fieldset>
        <legend>{gt text="Contact" domain="module_addressbook"}</legend>
        {if $address.contact_1}
        <div class="z-formrow">
            <label>{getvaluebyid table="addressbook_labels" field="name" id=$address.c_label_1}:{if $address.c_main==0}<span class="z-mandatorysym">*</span>{/if}</label>
            <span>{$address.contact_1|contact}</span>
        </div>
        {/if}
        {if $address.contact_2}
        <div class="z-formrow">
            <label>{getvaluebyid table="addressbook_labels" field="name" id=$address.c_label_2}:{if $address.c_main==1}<span class="z-mandatorysym">*</span>{/if}</label>
            <span>{$address.contact_2|contact}</span>
        </div>
        {/if}
        {if $address.contact_3}
        <div class="z-formrow">
            <label>{getvaluebyid table="addressbook_labels" field="name" id=$address.c_label_3}:{if $address.c_main==2}<span class="z-mandatorysym">*</span>{/if}</label>
            <span>{$address.contact_3|contact}</span>
        </div>
        {/if}
        {if $address.contact_4}
        <div class="z-formrow">
            <label>{getvaluebyid table="addressbook_labels" field="name" id=$address.c_label_4}:{if $address.c_main==3}<span class="z-mandatorysym">*</span>{/if}</label>
            <span>{$address.contact_4|contact}</span>
        </div>
        {/if}
        {if $address.contact_5}
        <div class="z-formrow">
            <label>{getvaluebyid table="addressbook_labels" field="name" id=$address.c_label_5}:{if $address.c_main==4}<span class="z-mandatorysym">*</span>{/if}</label>
            <span>{$address.contact_5|contact}</span>
        </div>
        {/if}
    </fieldset>

    {if $preferences.custom_tab}
    <fieldset>
        <legend>{$preferences.custom_tab}</legend>
        {foreach item=cusfield from=$customfields}
        {assign_concat 1="custom_" 2=$cusfield.id name="fieldname"}
        {if $cusfield.type=="tinyint default NULL"}
        <br />
        {elseif $cusfield.type=="smallint default NULL"}
        <hr />
        {elseif $cusfield.type=="date default NULL"}
        <div class="z-formrow">
            <label>{$cusfield.name|varprepfordisplay}:</label>
            <span>{$address.$fieldname|varprepfordisplay|date_format}</span>
        </div>
        {elseif $cusfield.type=="decimal(10,2) default NULL"}
        <div class="z-formrow">
            <label>{$cusfield.name|varprepfordisplay}:</label>
            <span>{$address.$fieldname|varprepfordisplay|formatnumber}</span>
        </div>
        {else}
        <div class="z-formrow">
            <label>{$cusfield.name|varprepfordisplay}:</label>
            <span class="z-formlist">{$address.$fieldname|varprephtmldisplay}</span>
        </div>
        {/if}
        {/foreach}
    </fieldset>
    {/if}

    {if $address.note}
    <fieldset class="z-linear">
        <legend>{gt text="Note" domain="module_addressbook"}</legend>
        <div class="z-formrow">{$address.note|varprephtmldisplay}</div>
    </fieldset>
    {/if}

    {if (($preferences.google_api_key) && ($address.geodata))}
    <fieldset class="z-linear">
        <legend>{gt text="Map" domain="module_addressbook"}</legend>
        <script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key={$preferences.google_api_key|varprepfordisplay}"></script>
        <div id="googlemap{$address.id|varprepfordisplay}" class="map" style="width: 100%; height: 200px"></div>
        <script type="text/javascript">
            //<![CDATA[
            Event.observe(window, 'load',
            function() { googlemap.showMap({$address.id}, "{$address.geodata|varprepfordisplay}", "{$preferences.google_zoom|varprepfordisplay}"); },
            false);
            //]]>
        </script>
    </fieldset>
    {/if}

</div>