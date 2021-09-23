Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD45416363
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Sep 2021 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhIWQf4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 12:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhIWQf4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 12:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632414864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klbbNiQ6boC9cmFxj08yPGuVBVZQR+/ca9GXOQNBdSc=;
        b=VpTt2Gwc5DK7F7pD+FuVcXxgjtps/lcOfK1MKbTCV/ZJpH++5vFXlheVyvEauzzCMgZcEc
        IpOPZtgi5a+QGd36SuPXpwGzfrbKXZISjUQIVZjha1tFkkCr5AaAol8Wa5YoRoAsljEncB
        u087Dv4zm2ShoSpRuySp/zsayU1oNN0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-1nClJiSXPsGAkkrImInaXw-1; Thu, 23 Sep 2021 12:34:22 -0400
X-MC-Unique: 1nClJiSXPsGAkkrImInaXw-1
Received: by mail-qk1-f197.google.com with SMTP id bl32-20020a05620a1aa000b004330d29d5bfso19311575qkb.23
        for <linux-nfs@vger.kernel.org>; Thu, 23 Sep 2021 09:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=klbbNiQ6boC9cmFxj08yPGuVBVZQR+/ca9GXOQNBdSc=;
        b=vCqG7X73kXf+kIUeMPnt/AFXo4MJN9dD9QVKNXzkjJtMLdvwxCpVivPGdIVo3FsyfC
         Qn1fVBHyMre3+E09Dx3c2JQ8qRsSmx2CATnt+ySl6YFd/RmOeDSkvdqo7NzdqgNfh8sR
         2H6zsimtsIMs0pIcpdT87QWCLKmH1f4jwjPhwIuep1tl446icB/CwoXKPwsWkAmXq0yv
         zP70CmR83fkDKxjVR2BnJjgzRNDHxWQLxa/EZPQlFcRljQ/HZZoFkL/LRYDO3ep6td8T
         26KlBmD3LVmAJ7CPCNcPwY6EGhYnX4qOLCaaS5f6d4AqhahnQK4gMv7jAYtNqG4TuVqK
         Z9nw==
X-Gm-Message-State: AOAM5332q7uTNRjtEGKgH2OGbMOZNMZjP+yh49Beg8uIhEAKAoAVW886
        f1bqqRrpzPxgXSNJwae7clCeHD3bfYu4vkPyvOFDpN6nhT09tOkrsG7kPhH4zyiDMP3PDw+0IK+
        uOMFxDLmIfQXioH5RAoImrsxr29DLGMhyIZBt6qey7jrJWYKPJ/RgVZn4gQW45jcf4/O7Bg==
X-Received: by 2002:a05:622a:283:: with SMTP id z3mr5517931qtw.324.1632414862098;
        Thu, 23 Sep 2021 09:34:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX9SRiHiGKd5ndXYZBIz+ywAFfp1hOQVekZMbTgjrDdPxPDE9tqF1z+fAo665Cgb39+lF6QA==
X-Received: by 2002:a05:622a:283:: with SMTP id z3mr5517898qtw.324.1632414861651;
        Thu, 23 Sep 2021 09:34:21 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.105.255.190])
        by smtp.gmail.com with ESMTPSA id a3sm3103745qkh.67.2021.09.23.09.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:34:21 -0700 (PDT)
Subject: Re: [PATCH] gssd: fix crash in debug message.
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210610150825.396565-1-steved@redhat.com>
 <627209c3-21dd-312e-c2dc-cc810108f7d1@redhat.com>
 <163116618506.12570.5744024691858636230@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <c4aeddc9-f2c1-d5dd-dc51-0db72f460ed9@redhat.com>
Date:   Thu, 23 Sep 2021 12:34:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <163116618506.12570.5744024691858636230@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/9/21 1:43 AM, NeilBrown wrote:
> 
> A recent cleanup of debug messages added func and tid format specifiers
> to a debug message (when full hostname was different), but the func name
> and tid were NOT added as arguments.
> 
> Consequently there weren't enough args, random bytes of the stack were
> interpreted as a pointer, and rpc.gssd crashed (when -v was specified).
> 
> Fixes: b538862a5135 ("gssd: Cleaned up debug messages")
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-5-5-rc3)

Thanks for the clean up!!

steved.
> ---
>   utils/gssd/krb5_util.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index 6d059f332881..e3f270e948ac 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -673,8 +673,8 @@ get_full_hostname(const char *inhost, char *outhost, int outhostlen)
>   	    *c = tolower(*c);
>   
>   	if (get_verbosity() && strcmp(inhost, outhost))
> -		printerr(1, "%s(0x%0lx): inhost '%s' different than outhost'%s'\n",
> -			inhost, outhost);
> +		printerr(1, "%s(0x%0lx): inhost '%s' different than outhost '%s'\n",
> +			 __func__, tid, inhost, outhost);
>   
>   	retval = 0;
>   out:
> 

