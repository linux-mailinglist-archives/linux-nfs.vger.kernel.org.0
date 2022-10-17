Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDB0601721
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 21:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiJQTNx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 15:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiJQTNu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 15:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FF8760EF
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666034027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZgdZ6AuL5euPfbBpv5BSGxr6zuCg22kNmsSkcCKxMM=;
        b=CDUCuiPZhkKfsJcZHgjxIyvH24SGeDY4pQEuHkUSA5LpJLYCTxEb2as/um6FcopLhgOsxD
        J6QfisWigmE8mx9MRo4xZYVqeg3uaZv8ZbgkyKV7YujQrPvD22cbtDO4ZesefrLV+CAndL
        zXRFShGjIjRyJMC8OYGlcI87adNS7Mg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-p_xbYDVDNqec1pyoevzDkw-1; Mon, 17 Oct 2022 15:13:45 -0400
X-MC-Unique: p_xbYDVDNqec1pyoevzDkw-1
Received: by mail-qt1-f199.google.com with SMTP id bz12-20020a05622a1e8c00b0039ae6e887ffso9052978qtb.8
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 12:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZgdZ6AuL5euPfbBpv5BSGxr6zuCg22kNmsSkcCKxMM=;
        b=yVOyPr51dfKmyqg9PCpMenqFA26KvY9InSGkZGMpa5fE6UhqvKPoNvUMBSlggwS72K
         S9jn2IkPa5gpHfk9LaVstYWvsPg1c4M7GZx8NhzBJ6o8Q+7I/2IIJwFWHY1h81JF9InI
         J4UPUNWB4mJnBCK/SBcee9at32R/2gFZr6L5QWLWh+5sTJO3pBFlDZm3CusloR7obFjY
         5Ttg24xhuOUHk84Ek5vqpxp56RiELBrdMegjvDJZZInfOSdT1TRiebtT3jLeDIveNjM0
         SDuBE+TqQZq0XGCufYr6x9mslqsjT6iVIwSzqF3GuB1eduM8fihnT4vKrPj29z1W57ij
         nO/g==
X-Gm-Message-State: ACrzQf3wjYMXLGAgfCpKkZCV62FdVagtA3W/6NXlIvRIlTcQhpkPWaNH
        /kesQ5vJwS9QDMycrHqabxi2MVijfYEem7XjLUIFi9ghY25cMeDjUbh5DwbxRowYzSPUWi+vQmE
        oAPz3r+E8Tda8lfhimEiS
X-Received: by 2002:a05:6214:4013:b0:4b4:3f86:b1c with SMTP id kd19-20020a056214401300b004b43f860b1cmr9540488qvb.36.1666034025205;
        Mon, 17 Oct 2022 12:13:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pgRHrggcgXtio5KRP8N4gmXmP9NWuL8sFbRm9qDsKH1/Km/mSm8xPHvzPjv1EgRGCFBx/Pg==
X-Received: by 2002:a05:6214:4013:b0:4b4:3f86:b1c with SMTP id kd19-20020a056214401300b004b43f860b1cmr9540466qvb.36.1666034024876;
        Mon, 17 Oct 2022 12:13:44 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.253.248])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a132600b006ee7923c187sm442806qkj.42.2022.10.17.12.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 12:13:44 -0700 (PDT)
Message-ID: <a8719dab-b693-fc78-a05e-2054388eb033@redhat.com>
Date:   Mon, 17 Oct 2022 15:13:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH nfs-utils] Allow 'debug' configuration option to accept
 '0' and '1'
Content-Language: en-US
To:     Frank Sorenson <sorenson@redhat.com>, linux-nfs@vger.kernel.org
References: <20221004174015.1362841-1-sorenson@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221004174015.1362841-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 10/4/22 1:40 PM, Frank Sorenson wrote:
> In the example /etc/nfs.conf file, most sections include
> a commented-out 'debug = 0' line, suggesting that '0' is
> the default.  In addition, the manpages for some of the
> utilities state that debugging can be enabled by setting
> 'debug = 1' in the nfs.conf file.
> 
> However, neither '0' nor '1' is accepted as a valid option
> for 'debug' while parsing the nfs.conf file.
> 
> Add '0' and '1' to the valid strings when parsing 'debug',
> with '0' not changing any debugging settings, and '1'
> enabling all debugging.
> 
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Committed!!

steved.

> ---
>   support/nfs/xlog.c   | 7 +++++--
>   systemd/nfs.conf.man | 6 ++++++
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/support/nfs/xlog.c b/support/nfs/xlog.c
> index e5861b9d..fa125cef 100644
> --- a/support/nfs/xlog.c
> +++ b/support/nfs/xlog.c
> @@ -46,11 +46,13 @@ int export_errno = 0;
>   
>   static void	xlog_toggle(int sig);
>   static struct xlog_debugfac	debugnames[] = {
> +	{ "0",		0, },
>   	{ "general",	D_GENERAL, },
>   	{ "call",	D_CALL, },
>   	{ "auth",	D_AUTH, },
>   	{ "parse",	D_PARSE, },
>   	{ "all",	D_ALL, },
> +	{ "1",		D_ALL, },
>   	{ NULL,		0, },
>   };
>   
> @@ -119,13 +121,14 @@ xlog_sconfig(char *kind, int on)
>   {
>   	struct xlog_debugfac	*tbl = debugnames;
>   
> -	while (tbl->df_name != NULL && strcasecmp(tbl->df_name, kind))
> +	while (tbl->df_name != NULL && strcasecmp(tbl->df_name, kind))
>   		tbl++;
>   	if (!tbl->df_name) {
>   		xlog (L_WARNING, "Invalid debug facility: %s\n", kind);
>   		return;
>   	}
> -	xlog_config(tbl->df_fac, on);
> +	if (tbl->df_fac)
> +		xlog_config(tbl->df_fac, on);
>   }
>   
>   void
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index e74083e9..b95c05a6 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -98,6 +98,12 @@ value, which can be one or more from the list
>   .BR parse ,
>   .BR all .
>   When a list is given, the members should be comma-separated.
> +The values
> +.BR 0
> +and
> +.BR 1
> +are also accepted, with '0' making no changes to the debug level, and '1' equivalent to specifying 'all'.
> +
>   .TP
>   .B general
>   Recognized values:

