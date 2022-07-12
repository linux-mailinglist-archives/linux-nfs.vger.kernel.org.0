Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F6572775
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 22:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiGLUjV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 16:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiGLUjU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 16:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E33E019
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657658353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AheYqmclPSt7pWFS39I0E/AtYF+C1GpEeY0+8oy+rbs=;
        b=gzKHA6X+QC+XxWcFw175aiA0+7QtJ3A3YfS6M0KjjEQzU4NI0y72650SaejBkdigwnP2Lo
        btcij8OvHgV1qQ4d7H3CnBtussySFf8vpFOew6FjQd1xALAAF3FWncowNnLaFL4Qoqo7C9
        Yq9MolUR+N+zoJAjoLCAAaxfMiauuxw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-ee_69x_jN2mKU5mTJEdU_w-1; Tue, 12 Jul 2022 16:39:05 -0400
X-MC-Unique: ee_69x_jN2mKU5mTJEdU_w-1
Received: by mail-qk1-f197.google.com with SMTP id bq33-20020a05620a46a100b006b579909e2eso7491302qkb.17
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 13:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AheYqmclPSt7pWFS39I0E/AtYF+C1GpEeY0+8oy+rbs=;
        b=VaEvjyK9PnQbcb0SpBKOyJiHB2TltH1nXfCznYhN3WfS1tZca8gCNz58fp/Jj/PJHB
         KT8bZ4N+liNSOZv8CXk6uwx2JRVzw3EGkWMGtSYrQ6kIZNUS0XiKUV4zZa0kDcZgQIZv
         935Q4uwVuutkmI8yYq8o1kvspr3iTd9+HRxy46EsrzpT7GjVPvS5k3hat/17F00qQShR
         X9+uTa8VNTcbgkuEfvZAJDaU9lc1uCOkuIyfXVM14MUnjppMOuzxTh/hcWk1417M2ycU
         YcUqQ3kT+aw3GUK8ZuoXOqtHabAAgSjiEGF55HGRPGYrLvh4rbV7HjBuDO+kNSU21M/1
         g6Tg==
X-Gm-Message-State: AJIora8UfshpXHJ4Or83M5Yyop7vZJlLaRdCO4v5SkB2ynXI+VYqTz6q
        5hS+D6j2V49jUcPv10h3cPlwgeVvRocq3v4he+rxgRmKeeNMMnpg3ciQ6CwFaSL8YwediRPN/DW
        7Nj/WBBybJByoUk7I/0gQ
X-Received: by 2002:ac8:5cc7:0:b0:31e:ac2b:63f3 with SMTP id s7-20020ac85cc7000000b0031eac2b63f3mr15063382qta.597.1657658345283;
        Tue, 12 Jul 2022 13:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vF3WEaJ2BRAn0EiCA15Z5e+ENZhRRG1+ZOrv4rRQyJvQQc7FHb5AVQxRpb8jWeqrBy9ODRhA==
X-Received: by 2002:ac8:5cc7:0:b0:31e:ac2b:63f3 with SMTP id s7-20020ac85cc7000000b0031eac2b63f3mr15063362qta.597.1657658345037;
        Tue, 12 Jul 2022 13:39:05 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:db8c:7bbd:f449:802d? (2603-6000-d605-db00-db8c-7bbd-f449-802d.res6.spectrum.com. [2603:6000:d605:db00:db8c:7bbd:f449:802d])
        by smtp.gmail.com with ESMTPSA id dm29-20020a05620a1d5d00b006ab91fd03fasm10553669qkb.19.2022.07.12.13.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:39:04 -0700 (PDT)
Message-ID: <d5006f96-0f90-9b50-76ef-b0f505dfb8ff@redhat.com>
Date:   Tue, 12 Jul 2022 15:39:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rpcbind] autotools/systemd: call rpcbind with -w only on
 enabled warm starts
Content-Language: en-US
To:     Bastian Krause <bst@pengutronix.de>, linux-nfs@vger.kernel.org
References: <20210611122803.24747-1-bst@pengutronix.de>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20210611122803.24747-1-bst@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/11/21 7:28 AM, Bastian Krause wrote:
> If rpcbind is configured with --disable-warmstarts it responds on -w
> with its usage string. This is not helpful in a systemd service, so pass
> -w conditionally.
> 
> Signed-off-by: Bastian Krause <bst@pengutronix.de>
This did fall of my radar... In the future feel free
to ping me privately...

Committed! (tag  rpcbind-1_2_7-rc2)

steved.
> ---
>   configure.ac               | 6 ++++++
>   systemd/rpcbind.service.in | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c0ef896..c2069a2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -20,6 +20,12 @@ AM_CONDITIONAL(LIBSETDEBUG, test x$lib_setdebug = xyes)
>   AC_ARG_ENABLE([warmstarts],
>     AS_HELP_STRING([--enable-warmstarts], [Enables Warm Starts @<:@default=no@:>@]))
>   AM_CONDITIONAL(WARMSTART, test x$enable_warmstarts = xyes)
> +AS_IF([test x$enable_warmstarts = xyes], [
> +	warmstarts_opt=-w
> +], [
> +	warmstarts_opt=
> +])
> +AC_SUBST([warmstarts_opt], [$warmstarts_opt])
>   
>   AC_ARG_ENABLE([rmtcalls],
>     AS_HELP_STRING([--enable-rmtcalls], [Enables Remote Calls @<:@default=no@:>@]))
> diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
> index 7b1c74b..c892ca8 100644
> --- a/systemd/rpcbind.service.in
> +++ b/systemd/rpcbind.service.in
> @@ -12,7 +12,7 @@ Wants=rpcbind.target
>   [Service]
>   Type=notify
>   # distro can provide a drop-in adding EnvironmentFile=-/??? if needed.
> -ExecStart=@_sbindir@/rpcbind $RPCBIND_OPTIONS -w -f
> +ExecStart=@_sbindir@/rpcbind $RPCBIND_OPTIONS @warmstarts_opt@ -f
>   
>   [Install]
>   WantedBy=multi-user.target

