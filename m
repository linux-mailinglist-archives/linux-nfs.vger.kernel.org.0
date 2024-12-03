Return-Path: <linux-nfs+bounces-8317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FACF9E11A8
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 04:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCAB21B00
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 03:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB01537FF;
	Tue,  3 Dec 2024 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LICWg17j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC9364AE
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195984; cv=none; b=ZoGQd9WoKPqzzqYpoI7SYj87Hji9bp0zXjjXnbZhzWTICicS44nmO67gKQgTgJw0VV2sGKWjohDaD/Jvxq4KbiGjScjHuvqkNU+oVYfAKewxSvocG9my6UCKt4v1ljZ8TSZCYoL78crJ3k8Y7X/vdjDHYbLWD+fxRT3RW62db3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195984; c=relaxed/simple;
	bh=qXoGydrsAGb+hb2Kn/LJabu4hGpuhzDGw7YD3tNbQOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thu3DQx/FGuaxK3dfnAZR1tEeAP8tC7dE7CVwkn1+p0lYlxmKsQqNw0ZI5kI3vOCcnO8GaQaRiUK95KVHQZJCqGJV21zhwRLi+4zCQUaFmuPTs4CAGBmn8n2U9/u7kPQvjz0lYtDwxS8EYBz8rxmtjufDAJEAaAHOA31LSMTngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LICWg17j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733195981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVSVoWZtw2RiDdyZ5i4FulOJrB8Xpn/gweFKr06EWcc=;
	b=LICWg17jvpf7bag5wMWfdSx2MvvU3hXFipOOzF5knjkSUWl3/G18CuGRaWnAoeJlH9fRQ2
	eSTI9fmOfls1/DlB8NSUopSbGWE6GJe+hGkB7uhdFCRMJ/asnPDdo0f68LZCnGcG0GGtvj
	ScwJC7TSd2VCpGp+1uZ+OqEOLOXrYIQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-DPYPpq5KPB6V1Z0REUNvsQ-1; Mon, 02 Dec 2024 22:19:40 -0500
X-MC-Unique: DPYPpq5KPB6V1Z0REUNvsQ-1
X-Mimecast-MFC-AGG-ID: DPYPpq5KPB6V1Z0REUNvsQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668f208ff7so87685911cf.0
        for <linux-nfs@vger.kernel.org>; Mon, 02 Dec 2024 19:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733195978; x=1733800778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVSVoWZtw2RiDdyZ5i4FulOJrB8Xpn/gweFKr06EWcc=;
        b=R/8srIOOIq/cXZmBGMTaaLRfJCQyKYxt5CUVjWnRSiJBxRlakuOBRDo+qle7TBSr9z
         RScdnL3NrhwhaLzefDZW+Q9tC3LewlnyWbw9WrvpfWuilVaqOJhH2vcY5qKe245piEbZ
         ZE2tw0zhy07OTaaXtPF1WUo1v/EGL4iS96AsBGKqw0lPSkSoAZsrPzzYh7d/l5W/OjVk
         9LuTV+zdN5SCK2JCnAbzhvBLtNxi+fHKnxpwIrfutgWoqzVqZv/tpSHuUomP3gnbxn0w
         B8xxQi5vDLJ7AhPzJSR688vu+Lmv87hQYnS1o5iw397iUwSeEoWE3QlROaMD784eHZvo
         6mSQ==
X-Gm-Message-State: AOJu0YwsohrIJfoQcqd4rEJgCMZZY1ttteJPDFfxObEXP+aG1VJnRtRR
	OZU1j6tDLcr4mWabrFuUYQEKp76+XWSeJhex9/L/p/Dd4GRgLKu5zfO72Hp4M9pwdJd8kNBYR0D
	a8HiTSWoCeyWV0tiFgIEg9/x+BONE2unQUPEhOnVcXCI2JG2QzOux44W9Tt/Rd0b+RA==
X-Gm-Gg: ASbGnctG5/8iOsNGSwj3WSyE5anW1q1DRK6BCo7ySQbiWeiaCmCuuxKbpg3nZEYKc4/
	kR70QuNX/FTONsgs1B0957c21JRuorMo13vgFjfM69YfX0GrHuxjP6vb2gi+mNLFI3VQsf51b3g
	grUYOss5wP8fX0AJDZun2NPHYSx1+fgb7dQH7tf/aEzS3BYmdf0KlfHIzHYX4/m8+4RZ271Umyg
	60BUo3o5YymI9pGDMoJAT7svc75dhGh1fnkURRR3ncH7W9xAg==
X-Received: by 2002:ac8:5955:0:b0:466:9f3c:47d7 with SMTP id d75a77b69052e-4670c731d38mr18049281cf.10.1733195978663;
        Mon, 02 Dec 2024 19:19:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT6cLo7YmZJ1mvH093Q4/gAUkgv7fmb/befmj+AF6lC5HK4BVPnVDyzVXmEfEKgkpmtRL48w==
X-Received: by 2002:ac8:5955:0:b0:466:9f3c:47d7 with SMTP id d75a77b69052e-4670c731d38mr18049041cf.10.1733195978351;
        Mon, 02 Dec 2024 19:19:38 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249ee9sm56584111cf.73.2024.12.02.19.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 19:19:37 -0800 (PST)
Message-ID: <6b8990cc-ec29-4e01-acd6-8c7ec6487d99@redhat.com>
Date: Mon, 2 Dec 2024 22:19:35 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <20241202203046.1436990-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241202203046.1436990-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

On 12/2/24 3:30 PM, Scott Mayhew wrote:
> Commit 15dc0bea ("exportd: Moved cache upcalls routines into
> libexport.a") caused write_fsloc() to be elided when junction support is
> disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
> that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
> be around actual junction code).
Why not just take the enable_junction config variable
out of configure.ac as well?

If we want junctions/referrals (which are the same)
IMHO... on all the time... Lets not be able to
turn them off at all?

Point being... if we are going remove 3 of the 4
HAVE_JUNCTION_SUPPORT ifdefs... let get ride of
all of them.

steved.
> 
> Fixes: 15dc0bea ("exportd: Moved cache upcalls routines into libexport.a")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>   support/export/cache.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 6c0a44a3..3a8e57cf 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -34,10 +34,7 @@
>   #include "pseudoflavors.h"
>   #include "xcommon.h"
>   #include "reexport.h"
> -
> -#ifdef HAVE_JUNCTION_SUPPORT
>   #include "fsloc.h"
> -#endif
>   
>   #ifdef USE_BLKID
>   #include "blkid/blkid.h"
> @@ -999,7 +996,6 @@ static void nfsd_retry_fh(struct delayed *d)
>   	*dp = d;
>   }
>   
> -#ifdef HAVE_JUNCTION_SUPPORT
>   static void write_fsloc(char **bp, int *blen, struct exportent *ep)
>   {
>   	struct servers *servers;
> @@ -1022,7 +1018,6 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
>   	qword_addint(bp, blen, servers->h_referral);
>   	release_replicas(servers);
>   }
> -#endif
>   
>   static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask, int extra_flag)
>   {
> @@ -1120,9 +1115,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
>   		qword_addint(&bp, &blen, exp->e_anongid);
>   		qword_addint(&bp, &blen, fsidnum);
>   
> -#ifdef HAVE_JUNCTION_SUPPORT
>   		write_fsloc(&bp, &blen, exp);
> -#endif
>   		write_secinfo(&bp, &blen, exp, flag_mask, do_fsidnum ? NFSEXP_FSID : 0);
>   		if (exp->e_uuid == NULL || different_fs) {
>   			char u[16];


