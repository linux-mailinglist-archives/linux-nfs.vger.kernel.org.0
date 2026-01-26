Return-Path: <linux-nfs+bounces-18472-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gx6FuRvd2m8gAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18472-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:45:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AFE890BA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E24305A6C6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949C329E5C;
	Mon, 26 Jan 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiogmgMP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWJ5Pk+e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567233A710
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434639; cv=none; b=KI99SVD2pF+OAqOSbwVx5zjbfdjL84z5bjC03EdbGCTLrkVRQ3pOOl3WBNUjXCF0FMs9Iv7gtxvKssIsU1Czb/PaAl+jYUueAn03b2RRgm6ZrzrVqffEMHcG6Mm/K1/ueEvX7gcxrDjHq31y8ISsm83+94NXCRPECD42+aVQntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434639; c=relaxed/simple;
	bh=HXvJ20SYYESgx2QNyij5S/zvMbtN/kZ+R+N9kiaAUBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLMMlrbL7IjwCrR0HYjWEh9S9iyHrDJJ7wqrXTxcBBCip4H1+x6cGwD6ZZcCbWMsHl70lItf7dWpCnFUz53DI5PTBy+oT5imhxJ4OkPL2ifpLCelKd8ngilCdMwLNGLE20rI+QyrD7Sjz7CyCeIDhc3zkyxRM9BjWP+ELGMSfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiogmgMP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWJ5Pk+e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769434636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szfZNAki7zua2PW1Pglk9Nn9BF//YpRllb4rQ6W4HtA=;
	b=HiogmgMPjHbYGgJMmSZM/7J4SJF7jGAB5bXf8AWC/EwXkCrbNgBarZpdAQfpRiqOLCSdUk
	nMJh4ZgEFkjL3SbfruaMYZbqmVQHVRC+8MS2csXtQks912gLd0pD3e/q/oUt0iwA7QDYrb
	5knSvwaasOQ7hIBBAPvkmI/dI+HDOx0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-eT2apLSNMEeGzZAmokaVkw-1; Mon, 26 Jan 2026 08:37:15 -0500
X-MC-Unique: eT2apLSNMEeGzZAmokaVkw-1
X-Mimecast-MFC-AGG-ID: eT2apLSNMEeGzZAmokaVkw_1769434634
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-502ab2494e3so130835741cf.3
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 05:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769434634; x=1770039434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szfZNAki7zua2PW1Pglk9Nn9BF//YpRllb4rQ6W4HtA=;
        b=ZWJ5Pk+e5yNRtryz9S15/KgfVSNlpmqUnGapxhDT/y9LM/AEzjxJN7eimgDjZgkLer
         7v0YAMv0twxC8IhW090o28niMivjOtcnUU6ajYRn1cjopfzbA94qYXGbjj6TUrAuHUUO
         i7/wJLu0gNdlQMVwUuevvOC58JQ92yE0uDC69cuP2B9WrILNVBY5Hd6N/QeEv6SgxfLa
         nbZjlvhMdiSdhLPyOxGlLIieGlZR4Hr0+gZ/jROyHX2J09bck2nmThtYEf+hTITTVqH+
         obPNBS+cK1PPKf42N4U9xbNQ+SdYUJQpgrNtX75iTgVT5GCjsFk5sr7+gooEu7PwXPrU
         B8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434634; x=1770039434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szfZNAki7zua2PW1Pglk9Nn9BF//YpRllb4rQ6W4HtA=;
        b=SIsXnkpd2xJZEhYhzXVJVV+FqdRnue9LnoJg5lHy9+Y1XofJtvlXGAfuXDLb9iMydE
         A6z38izIFWKCfA/tMrY+OA5LSiHPrskrTwK6gQKYARSe9TtuRGvnBddE2T0a08xTC0t8
         7m52TxLnWzDdTv7E3g2GlRHkaRXSSkQCX0K1J3Hn4c0hlq02QIvGJzmcQHLSp05wtC8A
         8Qjh4tN9CQ4998MS0KWMpoZBqlC7RhynJLq/YSY2UTWcRPcvJN6dRCWivyAi0gfGCxw1
         XguZSA27jgvE3AJSevCqpDMxoYykO9e93xbeNyhv+GKwmMl7CWlwz85pvJpqwmupVhC7
         Joqw==
X-Forwarded-Encrypted: i=1; AJvYcCXSckNcG839PBTtLPhaCz929qeTH1oZyfyUmwlegZM+CgJF9dqccDFTY9/G0qwFceiR4U0/rvI/eKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyueQgwKIeNEasX4zyn9sxZYTkqZSU9+s3DTuVlZQ5jaxy0dnVq
	qazdq1QIkQl4neqPQcIbIUMUmoUJ3W4bJH/+KvBY/6gRc7oTM2TnRF4hPWMjQWsiUkxdoWMbpeq
	wFbrGibJadbTSPTKCIH2sOMid9pZH85Rj7rC2CJguGiKviwOneYTQrCN6fA8BEA==
X-Gm-Gg: AZuq6aLMbFe+pgGvDh0eLYzjCumELu4wAxwVkwZ58ED8tM1+fIsuB4v/6dAvCrd8tse
	EtF7wE4YZRNUW/8S0LHBZrHqSWDumj2yfGCLwYyAgx0uORR2UHLL5LbEYMjOygSe6Vfkh5fMsHZ
	TxcBMhZ4SzPsYK2/u51BdsmPU9O4vYf297GuNR/l7fx6s65yseu1F1sDj9MA8jnNQC/Zh2Cz67U
	uMhlAikRGtpuZQ3VFepv1OZ8isMDhqbASn19PSjLRgMq5g3b3jYturo86FbSwbM4QBcRsorD32z
	kaBzMW6bu/jh12infQ/4SKEB4Cg8piqedGZmzd1O1AmdOht1TSyq5e9Ah/1HW6c+M5ZkEO+Xc1i
	nMM45Ah/U
X-Received: by 2002:a05:622a:1993:b0:4f4:e14b:8039 with SMTP id d75a77b69052e-50314c7338dmr63588261cf.54.1769434634335;
        Mon, 26 Jan 2026 05:37:14 -0800 (PST)
X-Received: by 2002:a05:622a:1993:b0:4f4:e14b:8039 with SMTP id d75a77b69052e-50314c7338dmr63587921cf.54.1769434633914;
        Mon, 26 Jan 2026 05:37:13 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949dcf5c5asm76240246d6.36.2026.01.26.05.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 05:37:13 -0800 (PST)
Message-ID: <8b479852-69af-4b4e-836c-17b9622df576@redhat.com>
Date: Mon, 26 Jan 2026 08:37:12 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] Rename CONFIG_NFSV41 to CONFIG_BLKMAPD and
 disable by default
To: Scott Mayhew <smayhew@redhat.com>
Cc: hch@infradead.org, carnil@debian.org, linux-nfs@vger.kernel.org
References: <aWc5dO3fP4J67x0H@infradead.org>
 <20260114145435.826165-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260114145435.826165-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18472-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Queue-Id: C0AFE890BA
X-Rspamd-Action: no action



On 1/14/26 9:54 AM, Scott Mayhew wrote:
> pNFS block layout is deprecated in favor of pNFS SCSI layout, which
> doesn't require the use of blkmapd.
> 
> Since CONFIG_NFSV41 (enabled by default, but can be disabled via
> --disable-nfsv41) is only used to enable blkmapd, let's rename it to
> CONFIG_BLKMAPD and change the default to disabled.
> 
> Distributions that wish to continue to include blkmapd can do so by
> adding --enable-blkmapd to their configure script invocation.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-5-rc2)

steved.

> ---
>   configure.ac        | 22 +++++++++++-----------
>   systemd/Makefile.am |  2 +-
>   utils/Makefile.am   |  2 +-
>   3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 6da23915..bcbf0d69 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -85,22 +85,22 @@ AC_ARG_ENABLE(nfsv4,
>   	AC_SUBST(enable_nfsv4)
>   	AM_CONDITIONAL(CONFIG_NFSV4, [test "$enable_nfsv4" = "yes"])
>   
> -AC_ARG_ENABLE(nfsv41,
> -	[AS_HELP_STRING([--disable-nfsv41],[disable support for NFSv41 @<:@default=no@:>@])],
> -	enable_nfsv41=$enableval,
> -	enable_nfsv41=yes)
> -	if test "$enable_nfsv41" = yes; then
> +AC_ARG_ENABLE(blkmapd,
> +	[AS_HELP_STRING([--enable-blkmapd],[enable support for blkmapd @<:@default=no@:>@])],
> +	enable_blkmapd=$enableval,
> +	enable_blkmapd=no)
> +	if test "$enable_blkmapd" = yes; then
>   		if test "$enable_nfsv4" != yes; then
> -			AC_MSG_WARN([NFS v4 is not enabled. Disabling NFS v4.1])
> -			enable_nfsv41=no
> +			AC_MSG_WARN([NFS v4 is not enabled. Disabling blkmapd.])
> +			enable_blkmapd=no
>   		fi
>   		BLKMAPD=blkmapd
>   	else
> -		enable_nfsv41=
> +		enable_blkmapd=
>   		BLKMAPD=
>   	fi
> -	AC_SUBST(enable_nfsv41)
> -	AM_CONDITIONAL(CONFIG_NFSV41, [test "$enable_nfsv41" = "yes"])
> +	AC_SUBST(enable_blkmapd)
> +	AM_CONDITIONAL(CONFIG_BLKMAPD, [test "$enable_blkmapd" = "yes"])
>   
>   AC_ARG_ENABLE(gss,
>   	[AS_HELP_STRING([--disable-gss],[disable client support for rpcsec_gss @<:@default=no@:>@])],
> @@ -398,7 +398,7 @@ else
>     enable_nfsdcltrack="no"
>   fi
>   
> -if test "$enable_nfsv41" = yes; then
> +if test "$enable_blkmapd" = yes; then
>     AC_CHECK_LIB([devmapper], [dm_task_create], [LIBDEVMAPPER="-ldevmapper"], AC_MSG_ERROR([libdevmapper needed]))
>     AC_CHECK_HEADER(libdevmapper.h, , AC_MSG_ERROR([Cannot find devmapper header file libdevmapper.h]))
>     AC_CHECK_HEADER(sys/inotify.h, , AC_MSG_ERROR([Cannot find header file sys/inotify.h]))
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index 5e481421..9cc940dc 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -32,7 +32,7 @@ unit_files += \
>       nfsv4-server.service
>   endif
>   
> -if CONFIG_NFSV41
> +if CONFIG_BLKMAPD
>   unit_files += \
>       nfs-blkmap.service
>   endif
> diff --git a/utils/Makefile.am b/utils/Makefile.am
> index e5cb81e7..bfa12081 100644
> --- a/utils/Makefile.am
> +++ b/utils/Makefile.am
> @@ -11,7 +11,7 @@ if CONFIG_NFSV4SERVER
>   OPTDIRS += exportd
>   endif
>   
> -if CONFIG_NFSV41
> +if CONFIG_BLKMAPD
>   OPTDIRS += blkmapd
>   endif
>   


