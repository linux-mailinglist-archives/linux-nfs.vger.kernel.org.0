Return-Path: <linux-nfs+bounces-8449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D879E9019
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 11:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14352162E66
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E4216611;
	Mon,  9 Dec 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxIjkTxt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A952165E2
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740004; cv=none; b=k21hRs+FBR0ccOeacv2sRub/p4fNZo6SYrdOPBiSMzFql/wtIC82tU1fzdbN8A3SBRaV7DXo/4bm9G6gjqeZI5d+s/Q5HnHowJJoCItOAK4vQAaGvOh1iFbKXW12H8Pfvfb2tl03DBTNE/svDaOVOuN86TO4ViAWbbJ1DQLfsmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740004; c=relaxed/simple;
	bh=/0pTM20BZHT1olcI4lvFA40wTOg1xqiurea77ooF29E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiNDCUCYjcF3GOHqSHsUCVbJoF8KpsaxTJjkQfRdrcgm64H2HbTo6rLdWeeQCt378RCA0IGpXixUS5SeQ7U83+Ommjtk5Ptb2xLUBYhsnsMs9/CTUBmu7/ke7G9eqOCjrlORV756FxoT7p5WMVuy5QCofClsNcaDWf3CIz9mDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxIjkTxt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733740001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKESPPnp20OsgjQmgxVeB7/vPjNXrXgdPCdkkNB/TrQ=;
	b=SxIjkTxtpeAXY5neEfaUuU4WE15Co0LSabsqlacawPjtLRmWHuKivmBj2Q0awebAWs5f3e
	6Hfe8M8F6BgCt/YXgS83MJb4EDVvMe8uYixPbxHnxSDP5ghEHpKg3QpUlYHNfeTRTiWObk
	loI7Yw4EOwhykGFlDQ7nXA9CMunY2EI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-lCW3zLxxMki1incQgqdtWw-1; Mon, 09 Dec 2024 05:26:38 -0500
X-MC-Unique: lCW3zLxxMki1incQgqdtWw-1
X-Mimecast-MFC-AGG-ID: lCW3zLxxMki1incQgqdtWw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d884999693so68784016d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Dec 2024 02:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733739997; x=1734344797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKESPPnp20OsgjQmgxVeB7/vPjNXrXgdPCdkkNB/TrQ=;
        b=pvi6xRfurGHlDb7ipWuEdRiqsId+cUWL5P8KgIPd7x0Ds1KmA6b0UcWxnOdCYBtBV0
         Y6+aPzXMV7EHQsBEGRnDkEMH2v2kDEKRvLqi4vcuzI2dmjd8oPPzAoxj00ODhMuqTNJK
         /XU7esTONlWshILjrgPcXnCHCYpMmy5LTVpnkMpSgAl8kJD45CeKzH3OgUtmxUDRBgAL
         QhVL+T8kF/S/ujmn39kJnf4hGZVhFeVMwiP5Wr9n7BTbFMknVSUEqL8dllFxNz1ceqlM
         frKLJHIJFTngHdGYNa0C8dmmx+Wywfjgx4JNq10BYni5lVjiqr7dd2y0g6BL+GKCtw6a
         L5kw==
X-Gm-Message-State: AOJu0Yz1egMrTgo8+tuQ0FQczn0G3AoBMtImry3WDCiRm2oZ32NpjcMo
	Yv55XIOZLr4C9SyCBkOS7luk5jJGs9CuBQtMdq2HoZcL6/ZT2CR+3XVGndwHJf+egXHc6su6iTG
	CA/tKuhQhVO4A2nBafeL4hN8ynZvp7o6bM/A1Eucgi7aDw6gqVCzXN2hh9dwq9hBLhw==
X-Gm-Gg: ASbGncs59VKWvXDkduLLbzX+msd9kGdGWCXVQFTXHV6hswiDEKkscoRQaqJWhYFNlub
	NDiM9PdCRu9oi/UWQeAot8eN3Fu9o3yKHcZFL92wke/VNJhF7PvX/9AusM8HiuWQZYXrmXMyXm7
	Q9gHjgp8dNIX+X05ipbLOntEOJPWKnis0I0HyMVo2X997Z9t/BHv0VtJvZ1CuX5+WV8R+hKUJYy
	IFwBqGOekPLFANQJejgk366M+BJeIGbNOYvIV5R+IuiVVsfxg==
X-Received: by 2002:a05:6214:500f:b0:6d8:9e64:c9d3 with SMTP id 6a1803df08f44-6d8e72046e6mr178441376d6.30.1733739997444;
        Mon, 09 Dec 2024 02:26:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH9M1/yEk759iFs85ZW/IqKOwX4tr8UD5f1qiYY8nDE6w4n6xs5BtXXRfTBiHf2HavFfa4rQ==
X-Received: by 2002:a05:6214:500f:b0:6d8:9e64:c9d3 with SMTP id 6a1803df08f44-6d8e72046e6mr178441276d6.30.1733739997179;
        Mon, 09 Dec 2024 02:26:37 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fe794sm47513876d6.85.2024.12.09.02.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 02:26:36 -0800 (PST)
Message-ID: <67d37048-25a7-4c86-b5e5-06d4bbb9442e@redhat.com>
Date: Mon, 9 Dec 2024 05:26:35 -0500
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



On 12/2/24 3:30 PM, Scott Mayhew wrote:
> Commit 15dc0bea ("exportd: Moved cache upcalls routines into
> libexport.a") caused write_fsloc() to be elided when junction support is
> disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
> that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
> be around actual junction code).
> 
> Fixes: 15dc0bea ("exportd: Moved cache upcalls routines into libexport.a")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed (tag: nfs-utils-2-8-2-rc4)

steved.

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


