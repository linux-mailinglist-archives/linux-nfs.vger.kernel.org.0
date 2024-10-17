Return-Path: <linux-nfs+bounces-7217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D529A1BF0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245541F2361E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC391B81CC;
	Thu, 17 Oct 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoaHp24w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC91B6CF2
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151311; cv=none; b=SslsrfX/W0LdYVXZ0qdyI01VvrMk4/SEgdi7r77uKhLLlW6VuL00yqCowlVKmuWD0cxAUsySZW0a7TQ8ZXlpVNAAb2eE+vI0svZh53Bk40KfHaAkBCjzt6cu0cVGWmSIEFaWcpyA1pV8V3mSq37n0130eDzzDJSiFVeGV7lJCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151311; c=relaxed/simple;
	bh=FKa4aiuBFlI7bCJPlrWxzgBouG30mPJoxOJDSbr+nrk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iV2S4uKs1G/YFSlTdiuT2/nHQTRJ7uMiQxBxMiVJm92hjVZbb9KdhHgL+7C+wWLpnvvZ5FEkKW4Rvw9/xgh9IVQLCz1hLxzKLBmZGtVhmfBHcpmcxoom8kKbmH9Pzm33nw3edyiY1sEOkUnMYY2YRdchY+PbFl3a+rg2BisJKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoaHp24w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729151306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VonlG7l4VAJpixQvsPWrTfmx3NAIOCUvt8pdNPU/pWg=;
	b=NoaHp24wrG34G58aUCtQwLALvaNfKzr/VD9eI7EVmnvMqC+XtD5egNQ7CvuNRmsaJA29Hp
	zVdoz9xJ6FayoEwpSXDICH/dxy4xWfq0w+oTwjG3X33hkmsh7Ab/emJxtZ00DsdwKyjt/n
	uxr6qf9kPC+cTKBbaWy0jzpvl3qsaBE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-brzz2KCKM8eD-3cm_8D6jg-1; Thu, 17 Oct 2024 03:48:25 -0400
X-MC-Unique: brzz2KCKM8eD-3cm_8D6jg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe6ad0154so12330196d6.0
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 00:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729151303; x=1729756103;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VonlG7l4VAJpixQvsPWrTfmx3NAIOCUvt8pdNPU/pWg=;
        b=rEOVx9Ez50b7zUzo+wARXb3WHupxyK0wGjseJZgXZbn+GJZX7z+/S+J4d2XW/T908H
         8sUyMmKoUq+1d7mJkeFfjL5SupnwfUwR6LW/gkhyop0bQiHeVYBiZ4sC4Hi9J/izqsG+
         VIsboOCIMqKMEymhqhRv0g7O5OFgW8skBE5Lujr0b+2KWImPf2qZZ40sEE2AZNWbB9mk
         Dnn5/YrHBsUdgN2+bEdKXVUCBywIKvJ09I1Hwn0oseLHNzAQF4ylSWq9Agcn67KeNNYR
         1itTyX0bI8lj70nAcBYOKQ7BPCgXyXZXWUJcUn1Qkj3NF9nXCRhoJwTOeWGI56IfvY9k
         XdLA==
X-Gm-Message-State: AOJu0Yw0IXMnswyDgNz5ULMAZWEXuK7VqZmZAv0DMno9YuGDtpCn8+Wj
	/XXjdpCVSsug5D8vIVtK5yCHR+dpWpulJ6gDifl/5Cb7xiX9TBMknYjAlNKQn0D/OzNeoC+08uh
	6RfmBhxUQqbwEQghI4TXNb746nx1ydZ+tHpu5kEZ5nSzCSkHxq7YCFQ/Vi+Kq/MWcwQ==
X-Received: by 2002:a05:6214:5a02:b0:6cb:4b65:950f with SMTP id 6a1803df08f44-6cbf9e9683cmr218064156d6.50.1729151303297;
        Thu, 17 Oct 2024 00:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeCAvQmIbaLgYXh8eBmQYuhH6kj0WJE72kOK4yjM37PvEUsTtc6SxM8a0L5Xm1+hJFgh62oA==
X-Received: by 2002:a05:6214:5a02:b0:6cb:4b65:950f with SMTP id 6a1803df08f44-6cbf9e9683cmr218064076d6.50.1729151303016;
        Thu, 17 Oct 2024 00:48:23 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2292293asm25866136d6.53.2024.10.17.00.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 00:48:22 -0700 (PDT)
Message-ID: <e9775c8b-a43e-460a-858d-441def9b03e4@redhat.com>
Date: Thu, 17 Oct 2024 03:48:20 -0400
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



On 10/16/24 1:51 PM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed..

steved.

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


