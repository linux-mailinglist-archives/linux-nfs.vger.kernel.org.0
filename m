Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C572633D3F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Nov 2022 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiKVNNJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Nov 2022 08:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiKVNM7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Nov 2022 08:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91BF1403D
        for <linux-nfs@vger.kernel.org>; Tue, 22 Nov 2022 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669122716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTv+o4yZTAgl32c+kR+AWaVr2rTAKK5pjCk87JiFUXA=;
        b=Q0ut0gPhqPrPY3LUaO/QWrF1oTfpUiW9MM+bPEA2FqZLJJt+FEczDoa8g9bpuzHsoATQSo
        zcDSevMD4/IRl2OT5BKfCKt6Z05az1O3h19AWidxULx6xd+blWLCiuKoEkNZhiLVHjh6N4
        xrBIpGaNc2MAfyQ/rhY6uzuotrwdVmU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-214--Lx0DSFQMvaDiapE4v8nrg-1; Tue, 22 Nov 2022 08:11:55 -0500
X-MC-Unique: -Lx0DSFQMvaDiapE4v8nrg-1
Received: by mail-qt1-f200.google.com with SMTP id fz10-20020a05622a5a8a00b003a4f466998cso14591439qtb.16
        for <linux-nfs@vger.kernel.org>; Tue, 22 Nov 2022 05:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTv+o4yZTAgl32c+kR+AWaVr2rTAKK5pjCk87JiFUXA=;
        b=FSJWgLcYAmbFMNzW8UEzs55iYyfwRLx6CuIC4UiWc9F6xijdGoUuELICTAmNCkaF5F
         3YO8hFDU/6PnYWFIVPsTA1BMUkxFNqGNsoIW5OTc7W0my/a0YgahH0kSg/yvYNlI3hDY
         XnracHhHTNs2yG0o32jF3f7qt3ILq5w+OauB1SMm/KJmpWl3cvO+vkJLLjDy+SRQ/0k+
         6+8IyuBhTkIotSsFQ7OVGulZBOFVLLGWtXT5kve1F+C5dDYQaePvFishozYFNjdzgke2
         HIuCzuPkOKnTRraKv9z+N7UVlLQOvTXwDT1z0J73DMjZHCzVkKPTNBnjK3eaBLJ6pjqz
         vtaw==
X-Gm-Message-State: ANoB5pkEjlO4HiaNZDa3R8Nny6DBvkIVt0eEk9N0PhkHsFd12RkcXjO6
        uqr0zIU3Mr331adA3F45Ncpy0FQOGeiPuvxRhaQj2TZ7kuN1AaDrEf12PoElFeiDwXxjrmeKGgu
        ZOOosTw6MOitcMZwU3p3jAL/IUVx4fTcr1dBI6aGDVRi7V4jODCBuW1/E63cj+S0sR2eRnw==
X-Received: by 2002:a05:620a:112d:b0:6fa:26d8:77d with SMTP id p13-20020a05620a112d00b006fa26d8077dmr21274870qkk.354.1669122714536;
        Tue, 22 Nov 2022 05:11:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5HmuUQ+v6MbJ3K/6wlqLxjY97+rSanRBt8yWotPqJSuAVdtCzgdriAPt5KbCR1RA2B7TZsRw==
X-Received: by 2002:a05:620a:112d:b0:6fa:26d8:77d with SMTP id p13-20020a05620a112d00b006fa26d8077dmr21274834qkk.354.1669122714072;
        Tue, 22 Nov 2022 05:11:54 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b006cfaee39ccesm10120863qkb.114.2022.11.22.05.11.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 05:11:53 -0800 (PST)
Message-ID: <692cd1bc-eff1-e207-b682-bfc6ec35f90d@redhat.com>
Date:   Tue, 22 Nov 2022 08:11:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] nfs4_getfacl: Initialize acl pointer to NULL
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20221121191427.132409-1-steved@redhat.com>
In-Reply-To: <20221121191427.132409-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/21/22 2:14 PM, Steve Dickson wrote:
> nfs4_getfacl.c: scope_hint: In function 'print_acl_from_path'
> nfs4_getfacl.c:168:17: warning[-Wmaybe-uninitialized]:
>      'acl' may be used uninitialized in this function
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs4-acl-tools-0.4.3-rc1)

steved.
> ---
>   nfs4_getfacl/nfs4_getfacl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nfs4_getfacl/nfs4_getfacl.c b/nfs4_getfacl/nfs4_getfacl.c
> index 954cf7e..ddb3005 100644
> --- a/nfs4_getfacl/nfs4_getfacl.c
> +++ b/nfs4_getfacl/nfs4_getfacl.c
> @@ -148,7 +148,7 @@ out:
>   
>   static void print_acl_from_path(const char *fpath, enum acl_type type)
>   {
> -	struct nfs4_acl *acl;
> +	struct nfs4_acl *acl = NULL;
>   
>   	switch (type) {
>   	case ACL_TYPE_ACL:

