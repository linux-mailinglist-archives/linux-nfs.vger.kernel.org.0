Return-Path: <linux-nfs+bounces-7212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678469A110D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 19:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827201C256C5
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901D206E86;
	Wed, 16 Oct 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewJNKFZD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462D212EF9
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101381; cv=none; b=JiZR5EKPvum6+/h0xUn4H3kuDGToSVdJmrVAi0r2bCm/R4RGGb9j8TxznrYRxlr6C+qLUds/rp7cg03Mgij9a0INwwjcx/yDnXWDxEVIVblXnbs2Dq5WM5AGCSOEqOTfUIDGKy9bZnSeXW0DPOaotTboIQF1TUSQwyYSEzgE9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101381; c=relaxed/simple;
	bh=70fDOF9G0nwb9sYbotwGV8LTkdzLZgj9E1ijFyPKGxc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n35dCxvByc6JcIGsCbTBbLvKOhHbmSGFBHtpHd7IIrE4XyyW8z3CeCoTj8vGtB5ZcyDb28b1GmH7CkTy5o37+Bal6iCFg5AozoIu2c8WOuuvhB1sOUL2Q8Aq9NaBzbzsMWh0A/RhcfZU+smhR9b7ns2odaQioE+XrPmxWbF1Sec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewJNKFZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729101375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh8jAxybqfvnHPLsGB16g1z8ZHWn+Es0P/xZjPhXxV4=;
	b=ewJNKFZD7eHKbQz9sfa4hilq4iPeLExNczCjVR7/McMHCfQkeMmS8hp9c1XgH6cArdq/xV
	zx2VM0ThpAD9H+IkkuO7r6ZzHzvk+KaWmFsp7lWVPblcyVunX4Do51cEiCQLwCzSYRbqTI
	wyca5tfjh9UIKJqn4QUZtmz3fL/7AU0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-qR1PvseuOs6VnIQ70HcUMw-1; Wed, 16 Oct 2024 13:56:14 -0400
X-MC-Unique: qR1PvseuOs6VnIQ70HcUMw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84ffd8ea8a8so36982241.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 10:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101374; x=1729706174;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh8jAxybqfvnHPLsGB16g1z8ZHWn+Es0P/xZjPhXxV4=;
        b=XBItoOBwI3K5Jt9t5hFyA6x/CvAZJeuZSFiQM+4zEyvlBtnz9ozPI4T2wjD9x8h+Hb
         z0hDIACa2TiJU5IH/V3Jcb6ip/pxQTQPvstqwpU5lbJ02RoeW4a7dE8Tck2ufxkM8tVX
         T/hVoCj+DGBOtsyqJnODCj9EZ4s0o8u881Wmg5db7P2cVcEUJUS44t4OlS0VLjym7mBZ
         SxBQMPsqeAuqVZSZXiMQ4ltVOvZG6Mh0SanXtxjr/PRkcUE1T9Dh1u/qgC4GTNugGq3E
         zN0z0jpmw5rXQjTpCMJ1buMSONWlmej7iQD7k5g5ye3kc6HSv7flPRZfamnhEIFeCF7k
         OF/w==
X-Gm-Message-State: AOJu0YwgqiBrKGZKBgwadXbxd8jwmXGMZoGncnkI3EIguYx4kO1Y/V0f
	kgv9jA66JNQ3zcninMuhgayEU37J1Ig5rqXulAmooNuf+Au9F69EcPikB9haEfL0ytHxKFthEDA
	FxQ4ZIXTc2z2C3a9VTNmJpN8XDdJtht/zrU8PlEJqwJdI5hayeAIc9Ycj8A==
X-Received: by 2002:a05:6122:2a55:b0:50d:6d53:fedf with SMTP id 71dfb90a1353d-50d8d61e33dmr4435011e0c.8.1729101373703;
        Wed, 16 Oct 2024 10:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKJ5nXWu9Bqkw9hMsO5ibI9iiVIVx/b1H1hRPvvIJkTfLcU1UtOqkoeQP075zptYdA03kgAw==
X-Received: by 2002:a05:6122:2a55:b0:50d:6d53:fedf with SMTP id 71dfb90a1353d-50d8d61e33dmr4434990e0c.8.1729101373327;
        Wed, 16 Oct 2024 10:56:13 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136397252sm211631785a.80.2024.10.16.10.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 10:56:12 -0700 (PDT)
Message-ID: <3e93a8e7-a199-4b25-96e5-061e9a30837b@redhat.com>
Date: Wed, 16 Oct 2024 13:56:11 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure.ac: Using autoupdate updated to the latest
 autoconf macros
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20241016175121.85450-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20241016175121.85450-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

My only question I have is how backward compatible
are these new macros... if that even matters.

steved.

On 10/16/24 1:51 PM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>   configure.ac | 54 +++++++++++++++++++---------------------------------
>   1 file changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index ee2433f..bd099ff 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,4 +1,4 @@
> -AC_INIT(libtirpc, 1.3.5)
> +AC_INIT([libtirpc],[1.3.5])
>   AM_INIT_AUTOMAKE([silent-rules])
>   AM_SILENT_RULES([yes])
>   AC_CONFIG_SRCDIR([src/auth_des.c])
> @@ -35,7 +35,7 @@ AC_SUBST([LT_VERSION_INFO])
>   AC_CHECK_HEADER([gssapi/gssapi.h], [HAVE_GSSAPI_H=yes], [HAVE_GSSAPI_H=no])
>   
>   AC_ARG_ENABLE(gssapi,
> -	[AC_HELP_STRING([--disable-gssapi], [Disable GSSAPI support @<:@default=no@:>@])],
> +	[AS_HELP_STRING([--disable-gssapi],[Disable GSSAPI support @<:@default=no@:>@])],
>         [],[enable_gssapi=yes])
>   AM_CONDITIONAL(GSS, test "x$enable_gssapi" = xyes)
>   
> @@ -62,7 +62,7 @@ if test "x$enable_gssapi" = xyes; then
>   fi
>   
>   AC_ARG_ENABLE(authdes,
> -	[AC_HELP_STRING([--enable-authdes], [Enable AUTH_DES support @<:@default=no@:>@])],
> +	[AS_HELP_STRING([--enable-authdes],[Enable AUTH_DES support @<:@default=no@:>@])],
>         [],[enable_authdes=no])
>   AM_CONDITIONAL(AUTHDES, test "x$enable_authdes" = xyes)
>   if test "x$enable_authdes" != xno; then
> @@ -70,7 +70,7 @@ if test "x$enable_authdes" != xno; then
>   fi
>   
>   AC_ARG_ENABLE(ipv6,
> -	[AC_HELP_STRING([--disable-ipv6], [Disable IPv6 support @<:@default=no@:>@])],
> +	[AS_HELP_STRING([--disable-ipv6],[Disable IPv6 support @<:@default=no@:>@])],
>   	[],[enable_ipv6=yes])
>   AM_CONDITIONAL(INET6, test "x$enable_ipv6" != xno)
>   if test "x$enable_ipv6" != xno; then
> @@ -78,7 +78,7 @@ if test "x$enable_ipv6" != xno; then
>   fi
>   
>   AC_ARG_ENABLE(symvers,
> -	[AC_HELP_STRING([--disable-symvers], [Disable symbol versioning @<:@default=no@:>@])],
> +	[AS_HELP_STRING([--disable-symvers],[Disable symbol versioning @<:@default=no@:>@])],
>         [],[enable_symvers=maybe])
>   
>   if test "x$enable_symvers" = xmaybe; then
> @@ -113,63 +113,48 @@ esac
>   
>   
>   AC_MSG_CHECKING(for SOL_IP)
> -AC_TRY_COMPILE([#include <netdb.h>], [
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netdb.h>]], [[
>       int ipproto = SOL_IP;
> -], [
> +]])],[
>       AC_MSG_RESULT(yes)
>       AC_DEFINE(HAVE_SOL_IP, 1, [Have SOL_IP])
> -], [
> +],[
>       AC_MSG_RESULT(no)
>   ])
>   
>   AC_MSG_CHECKING(for SOL_IPV6)
> -AC_TRY_COMPILE([#include <netdb.h>], [
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netdb.h>]], [[
>       int ipproto = SOL_IPV6;
> -], [
> +]])],[
>       AC_MSG_RESULT(yes)
>       AC_DEFINE(HAVE_SOL_IPV6, 1, [Have SOL_IPV6])
> -], [
> +],[
>       AC_MSG_RESULT(no)
>   ])
>   
>   AC_MSG_CHECKING(for IPPROTO_IP)
> -AC_TRY_COMPILE([#include <netinet/in.h>], [
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netinet/in.h>]], [[
>       int ipproto = IPPROTO_IP;
> -], [
> +]])],[
>       AC_MSG_RESULT(yes)
>       AC_DEFINE(HAVE_IPPROTO_IP, 1, [Have IPPROTO_IP])
> -], [
> +],[
>       AC_MSG_RESULT(no)
>   ])
>   
>   AC_MSG_CHECKING(for IPPROTO_IPV6)
> -AC_TRY_COMPILE([#include <netinet/in.h>], [
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netinet/in.h>]], [[
>       int ipproto = IPPROTO_IPV6;
> -], [
> +]])],[
>       AC_MSG_RESULT(yes)
>       AC_DEFINE(HAVE_IPPROTO_IPV6, 1, [Have IPPROTO_IPV6])
> -], [
> +],[
>       AC_MSG_RESULT(no)
>   ])
>   AC_MSG_CHECKING([for IPV6_PKTINFO])
> -AC_TRY_COMPILE([#include <netdb.h>], [
> -  int opt = IPV6_PKTINFO;
> -], [
> -  AC_MSG_RESULT([yes])
> -], [
> -AC_TRY_COMPILE([#define __APPLE_USE_RFC_3542
> -            #include <netdb.h>], [
> -  int opt = IPV6_PKTINFO;
> -], [
> -  AC_MSG_RESULT([yes with __APPLE_USE_RFC_3542])
> -  AC_DEFINE([__APPLE_USE_RFC_3542], [1], [show IPV6_PKTINFO internals on macos])
> -], [
> -  AC_MSG_RESULT([no])
> -])
> -])
>   
>   AC_CONFIG_HEADERS([config.h])
> -AC_PROG_LIBTOOL
> +LT_INIT
>   AC_HEADER_DIRENT
>   AC_PREFIX_DEFAULT(/usr)
>   AC_CHECK_HEADERS([arpa/inet.h fcntl.h libintl.h limits.h locale.h
> @@ -182,6 +167,7 @@ AC_CHECK_FUNCS([getpeereid getrpcbyname getrpcbynumber setrpcent endrpcent getrp
>   AC_CHECK_TYPES(struct rpcent,,, [
>         #include <netdb.h>])
>   AC_CONFIG_FILES([Makefile src/Makefile man/Makefile doc/Makefile])
> -AC_OUTPUT(libtirpc.pc)
> +AC_CONFIG_FILES([libtirpc.pc])
> +AC_OUTPUT
>   
>   


