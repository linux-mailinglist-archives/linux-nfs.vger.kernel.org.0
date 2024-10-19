Return-Path: <linux-nfs+bounces-7308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ACA9A4DCA
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DDE286930
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB51E04AE;
	Sat, 19 Oct 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffuZSvvv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AA1DE887
	for <linux-nfs@vger.kernel.org>; Sat, 19 Oct 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729340823; cv=none; b=oQ5G9oKjZHW44u2zR2eojXozCQSpC1K6G/nC65nG/SeMw0rq3rDh7DjXV1aZuLVFhpPqnjxnJd28/cvQADIJ/TOvErvRTUeDJ9pACs3O36G/bGIrqSiIoidgApJB5bALZ1Fto0gsCCxJQiSS3azUBorAYCUfWjVoHBAEH7rRBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729340823; c=relaxed/simple;
	bh=gUultVwMJtCiSq0rO2ntZENtGW02hpy5bOjqB824whM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjUaw60Y9QNNRNvNusKM8qaspSXV4XeoWLSm/5hj4KT/Ea+CtQrPLDIWA+Zxdh1CA3/uDtyR2+UwZm5evjKgPIej/cpF3CO0065e3hhWgCLF177P/qmj5eeEJX+1jzk2lLPqQqaYOyD+wp8MdqQQA+EhFjr0s56nxQCqdcoOrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffuZSvvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729340820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+vUAxPfF4G+FOWTiOLsSnMb/BrpaiWhjc4dp7N0/rw=;
	b=ffuZSvvvC9ukQ1fwl5tlLV0pP1WbKsIacgDUKGExDde7cRMRfeaBYztcPseO7JAK4tXw2p
	rvihyB+SWLhr4Hixo9mlBtJhd0q2gKh2njqP46RKMWQqC8332DswC7dsEAWasE87tljKa5
	6+Q32ph1Vo8uMtgPuZHBurfO1X4u2Ro=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-zsVPw8mrMqS5CEDAbdR5NQ-1; Sat, 19 Oct 2024 08:26:58 -0400
X-MC-Unique: zsVPw8mrMqS5CEDAbdR5NQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbd2cb2f78so68420246d6.0
        for <linux-nfs@vger.kernel.org>; Sat, 19 Oct 2024 05:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729340818; x=1729945618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+vUAxPfF4G+FOWTiOLsSnMb/BrpaiWhjc4dp7N0/rw=;
        b=uXB8f9DqgNq/eaBNpauB5YpO3oA9S/LcxM24zhFXPyRDCRC0W/sPnq1Djn2fYyhXJD
         eQHVb0ZPAfZ8KXP2Roa0SU9MPN/PilJ7behMypsilVxjruv0sbDyTiQRtbzOrtQpBtGD
         7TRdiIqx3Is2wqIBcv0XYAQ/ZK2DzYeAl67ZARfIj034H9BxCXBs9lRkmLg2BOeifIAY
         Ib6OwPs2GRHSPsPEW+eTQqFXo9jh+PVXceztfm6cZ5xficEuwNXEWyp2gbvIageCNzRE
         wUNGcNjAzyHf7cv6Xvwn+lAAzlUFAkjGv2lYZaLY8BJHC9ljt2C4Mabc4gVkuvq9GA8U
         Zabw==
X-Forwarded-Encrypted: i=1; AJvYcCVlbAKdkVIqED+RS0NSprpFY6pWIdPXkfJnWx2RqpIiZf60s1PP2cbluWetJL6ye4d30qKrKw7BfX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+iRM4/A55vHn2xIbHhzbyvFAqpPc1G3G5h+1ljULlI8x2lE/
	JX+lArkd5ENLNVmW+puAZ612Ng/mQismOf7jhOHWrhrpy4GGioh6tlCKcCmunJy40HMoEJCHxXN
	YvVF7pPUaAAQvQoO7ZJfDLP3Gb9+wGDtUDhIdY6mMlyxJOYdpk7MT3QLl8g==
X-Received: by 2002:ad4:5c68:0:b0:6cb:c892:8c17 with SMTP id 6a1803df08f44-6cc378cef31mr172868766d6.22.1729340817911;
        Sat, 19 Oct 2024 05:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9upmB1Nckzw1Sr8t5tnP5KnlTJCTIO9P3dXCFPIZy4lN0zXgjSz5pGhzxtoOqOPKx4ymB4Q==
X-Received: by 2002:ad4:5c68:0:b0:6cb:c892:8c17 with SMTP id 6a1803df08f44-6cc378cef31mr172868506d6.22.1729340817512;
        Sat, 19 Oct 2024 05:26:57 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.244.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1179295sm17439646d6.66.2024.10.19.05.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 05:26:56 -0700 (PDT)
Message-ID: <eb27c102-e53f-4f6f-9776-119728d62b55@redhat.com>
Date: Sat, 19 Oct 2024 08:26:55 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
To: Ian Kent <raven@themaw.net>, linux-nfs@vger.kernel.org
Cc: Charles Hedrick <hedrick@rutgers.edu>
References: <20241019052340.28225-1-raven@themaw.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241019052340.28225-1-raven@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/19/24 1:23 AM, Ian Kent wrote:
> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
> these functions are not thread safe.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
Committed... Thanks for the quick turn around.

steved.
> ---
>   utils/gssd/gssd_proc.c | 34 ++++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
> index 2ad84c59..01331485 100644
> --- a/utils/gssd/gssd_proc.c
> +++ b/utils/gssd/gssd_proc.c
> @@ -489,7 +489,10 @@ success:
>   static int
>   change_identity(uid_t uid)
>   {
> -	struct passwd	*pw;
> +	struct passwd  pw;
> +	struct passwd *ppw;
> +	char *pw_tmp;
> +	long tmplen;
>   	int res;
>   
>   	/* drop list of supplimentary groups first */
> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>   		return errno;
>   	}
>   
> +	tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
> +	if (tmplen < 0)
> +		tmplen = 16384;
> +
> +	pw_tmp = malloc(tmplen);
> +	if (!pw_tmp) {
> +		printerr(0, "WARNING: unable to allocate passwd buffer\n");
> +		return errno ? errno : ENOMEM;
> +	}
> +
>   	/* try to get pwent for user */
> -	pw = getpwuid(uid);
> -	if (!pw) {
> +	res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
> +	if (!ppw) {
>   		/* if that doesn't work, try to get one for "nobody" */
> -		errno = 0;
> -		pw = getpwnam("nobody");
> -		if (!pw) {
> +		res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
> +		if (!ppw) {
>   			printerr(0, "WARNING: unable to determine gid for uid %u\n", uid);
> -			return errno ? errno : ENOENT;
> +			free(pw_tmp);
> +			return res ? res : ENOENT;
>   		}
>   	}
>   
> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>   	 * other threads. To bypass this, we have to call syscall() directly.
>   	 */
>   #ifdef __NR_setresgid32
> -	res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, pw->pw_gid);
> +	res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>   #else
> -	res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw->pw_gid);
> +	res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>   #endif
> +	free(pw_tmp);
>   	if (res != 0) {
> -		printerr(0, "WARNING: failed to set gid to %u!\n", pw->pw_gid);
> +		printerr(0, "WARNING: failed to set gid to %u!\n", pw.pw_gid);
>   		return errno;
>   	}
>   


