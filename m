Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E5E55C45F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiF0OgA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbiF0Of7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 10:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E65941208F
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656340554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ru8uC19uvFAlVSSLkrj/zrf6YX7BXkROOegJTLrz5fk=;
        b=h+CXudsvCDlvL6AvEiT4guIJJrwilYtn4pgZZFCFEAURIs3m/GZGLq9Q1PF8B1DdL/Jj1q
        XeNlBd0F6ALTTaS6CDB1YB1c8Jp4bMSmRxG7ZX+Ps9gYAwk1ZCx2LSST+ccTzAbiZJURBr
        juIhS1yU/S2w5QmdiKEvag8/DzpLmMY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-KPWgWI0mOO6Qrb4NZ1MtaA-1; Mon, 27 Jun 2022 10:35:52 -0400
X-MC-Unique: KPWgWI0mOO6Qrb4NZ1MtaA-1
Received: by mail-qk1-f197.google.com with SMTP id 186-20020a3708c3000000b006af306eb272so2389929qki.18
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 07:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ru8uC19uvFAlVSSLkrj/zrf6YX7BXkROOegJTLrz5fk=;
        b=6ZKovRuQ8nMye6KDJQ8uLYwPshVTI8XMOr95KJDY6gFZez43GUmKbguhQKnP24sc17
         QcIwqsFO4AznLFmTU8nKlgO8iSorWV//zTf//o6hHtdmBx3wRh9AAi93IvGQEm3jvq7s
         +1gNnE1EwjBkLV6PLf7YyaQWoNJ9n6xVvK6fqWrPIaIebkjumCLPztq4a/JejI1Nnnik
         pI9EVD21x4UMHLMXqB/C5aFkQP2BnnCf1flmb5BJmUCMX81VtjQJ4ZWhnz0GWrFNcj30
         5xwI4sVaxZ9ADLopyLfZffgA48ZRuBnr+dRWx7tFyIOj5/2yjG5NzhRyR1LTryU9F4y2
         zsMA==
X-Gm-Message-State: AJIora9ZUcjqL+gArCwLGrx3r8B1w9z4vLDpQq1LICpzbaItA2tgC80r
        886M+XJV3fICmbI5jNI8aJwyjARQ/n60C+Drao3H5CK5hKnU0Xg7qoDrvUljnXebbOj16yQgKdf
        zktAMPhgquwZyDAz7wD50
X-Received: by 2002:ae9:e852:0:b0:6ae:e737:d8e1 with SMTP id a79-20020ae9e852000000b006aee737d8e1mr8209430qkg.268.1656340552131;
        Mon, 27 Jun 2022 07:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vTsk3C54IdQJBheteheXfirysKTAMY27aY1PeEJspRn5Wg3rT7ZArPnNbrrbIh3iQ1pWsGlg==
X-Received: by 2002:ae9:e852:0:b0:6ae:e737:d8e1 with SMTP id a79-20020ae9e852000000b006aee737d8e1mr8209402qkg.268.1656340551816;
        Mon, 27 Jun 2022 07:35:51 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.186.229])
        by smtp.gmail.com with ESMTPSA id o19-20020a05622a045300b00304ecf35b50sm7597341qtx.97.2022.06.27.07.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:35:51 -0700 (PDT)
Message-ID: <81c6a673-3bd3-387a-a4cc-0a96cc0ab4b4@redhat.com>
Date:   Mon, 27 Jun 2022 10:35:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH nfs-utils] configure: make modprobe.d directory
 configurable.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
References: <165594889671.4786.9612372524810600367@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <165594889671.4786.9612372524810600367@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 6/22/22 9:48 PM, NeilBrown wrote:
> 
> Debian seems to prefer /lib/modprobe.d - at lease sometimes.
> 
> So allow
>    ./configure --with-modprobedir=/lib/modprobe.d
> to work, but default to /usr/lib/modprobe.d
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-6-2-rc8)

steved.

> ---
>   configure.ac        | 12 ++++++++++++
>   systemd/Makefile.am |  6 ++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index a13f36915a35..4403335bcaa9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -71,6 +71,18 @@ AC_ARG_WITH(systemd,
>   	AM_CONDITIONAL(INSTALL_SYSTEMD, [test "$use_systemd" = 1])
>   	AC_SUBST(unitdir)
>   
> +modprobedir=/usr/lib/modprobe.d
> +AC_ARG_WITH(modprobedir,
> +	[AS_HELP_STRING([--with-modprobedir@<:@=modprobe-dir-path@:>@],[install modprobe config files @<:@Default: /usr/lib/modprobe.d@:>@])],
> +	if test "$withval" != "no" ; then
> +		modprobedir=$withval
> +	else
> +		modprobedir=
> +	fi
> +	)
> +	AM_CONDITIONAL(INSTALL_MODPROBEDIR, [test -n "$modprobedir"])
> +	AC_SUBST(modprobedir)
> +
>   AC_ARG_ENABLE(nfsv4,
>   	[AS_HELP_STRING([--disable-nfsv4],[disable support for NFSv4 @<:@default=no@:>@])],
>   	enable_nfsv4=$enableval,
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index 63a50bf2c07e..7b5ab84bd793 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -82,5 +82,7 @@ install-data-hook: $(unit_files) $(modprobe_files)
>   else
>   install-data-hook: $(modprobe_files)
>   endif
> -	mkdir -p $(DESTDIR)/usr/lib/modprobe.d
> -	cp $(modprobe_files) $(DESTDIR)/usr/lib/modprobe.d/
> +if INSTALL_MODPROBEDIR
> +	mkdir -p $(DESTDIR)$(modprobedir)
> +	cp $(modprobe_files) $(DESTDIR)$(modprobedir)
> +endif

