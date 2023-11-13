Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676477EA1AA
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjKMRGT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjKMRGT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 12:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4E18D
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 09:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699895129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pnLp6QGli7cotvDCRb4rDI6eB7hd2qD32UPE34GvA8=;
        b=GiurK5wg+2DFgglU00+ms1J/2XL2iHA4k9dvf/7lzE6GUUiVnjyOwBsVOkUuVsL+8rGS/9
        MPCVC0isJDODVYs45/R/DtwsD229webtbEPfCiei4ZukyJTky2PsxpPZzjV5NYTVJldgEo
        /UCr6n6Fek5t81uzvZ7loDZNPpPDIAg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-rIc1J0Z5MKKTWxcu6PUwGQ-1; Mon, 13 Nov 2023 12:05:27 -0500
X-MC-Unique: rIc1J0Z5MKKTWxcu6PUwGQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66fd88c39f6so7160286d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 09:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699895127; x=1700499927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pnLp6QGli7cotvDCRb4rDI6eB7hd2qD32UPE34GvA8=;
        b=J5ObFpErtBaImUJ2l4k9a/tcx3OFU3DDqYiSYNHpxHNuN5kvdDD+p85KRUSSlfLp9+
         dgY+MjB4SFZAl5+jPZ3dNIjASI+WfB0EKFBRIuEmeSDlr78r1eIQd2ItJ+Bk/Dx8hBop
         3FsRi+ka+SK3fvact68fMJRX4HZlv43qNMKxsc57Zx01LYK4oqzwTer3Xobstoj1ae/E
         PD78VmiqzJoxzc9NvRXyFkTYKTotztX4jsT6aT0BRce7irYJRgvFxhvnIynm3KH+MjPe
         Uigk02RoHCrBxDqybh9mGh+vgaZlv6zICcllRMdxiW13u7i4uBAPyPU8uNQAcV0Ai4lM
         0R2w==
X-Gm-Message-State: AOJu0YxlGTMOzpsiFEWwESoQ73CtKvIVL667wGAGHfHyx5b/x3eMjTI4
        0aYGeGze+0FiB+g4lv1P1HfnX6Wmv1fdwdqDIcfrcYwRbbAB25mqoXajNvEtlwlwm3CCXW0AdAC
        Co2eQJXZxj/Mhz2uUEWHX
X-Received: by 2002:a05:6214:a44:b0:66a:d2c1:992d with SMTP id ee4-20020a0562140a4400b0066ad2c1992dmr7533391qvb.0.1699895127190;
        Mon, 13 Nov 2023 09:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN6RySbpWVf0pKEECzmQIce8vEfXqDdXl0GI4NQd1xge6ShPp1TrqY+8DVWbJwupKk7O+ScA==
X-Received: by 2002:a05:6214:a44:b0:66a:d2c1:992d with SMTP id ee4-20020a0562140a4400b0066ad2c1992dmr7533366qvb.0.1699895126861;
        Mon, 13 Nov 2023 09:05:26 -0800 (PST)
Received: from [172.31.1.12] ([70.105.251.235])
        by smtp.gmail.com with ESMTPSA id k6-20020ad44206000000b0067079ecca05sm2177989qvp.108.2023.11.13.09.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 09:05:25 -0800 (PST)
Message-ID: <900689ef-3f63-4c54-b986-f612c4b2109c@redhat.com>
Date:   Mon, 13 Nov 2023 12:05:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libtirpc: Add detection for new rpc_gss_sec members
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>
References: <20231025180141.416189-1-pvorel@suse.cz>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20231025180141.416189-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 10/25/23 2:01 PM, Petr Vorel wrote:
> From: Petr Vorel<petr.vorel@gmail.com>
> 
> 4b272471 started to use struct rpc_gss_sec member minor_status, which
> was added in new libtirpc 1.3.4. Add check for the member to prevent
> failure on older libtirpc headers.
> 
> Fixes: 4b272471 ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials")
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   aclocal/libtirpc.m4 | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> index bddae022..dd351722 100644
> --- a/aclocal/libtirpc.m4
> +++ b/aclocal/libtirpc.m4
> @@ -25,6 +25,10 @@ AC_DEFUN([AC_LIBTIRPC], [
>                            [AC_DEFINE([HAVE_LIBTIRPC_SET_DEBUG], [1],
>                                       [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
>                            [${LIBS}])])
> +     AS_IF([test "$enable_gss" = "yes"],
> +           [AC_CHECK_MEMBER(struct rpc_gss_sec.minor_status,,
> +                         [AC_MSG_ERROR([Missing rpc_gss_sec.minor_status in <rpc/auth_gss.h>, update libtirpc or run with --disable-gss])],
> +                         [#include <rpc/auth_gss.h>])])
>   
>     AC_SUBST([AM_CPPFLAGS])
>     AC_SUBST(LIBTIRPC)
> -- 2.42.0
> 
This does not work... since it is looking at that gssrpc/auth_gss.h
instead of the tirpc/rpc/auth_gss.h so the check fails

I like the idea of having the check, but I'm not sure on
how to point it in the right direction.

steved.

