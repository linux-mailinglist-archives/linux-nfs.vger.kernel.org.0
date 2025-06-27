Return-Path: <linux-nfs+bounces-12806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16345AEB53A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 12:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBE41894D57
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FE425F78A;
	Fri, 27 Jun 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmn9ZdjX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372C1F866B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021049; cv=none; b=gVfz7Oqv7wTQQfvL+NDsaLzm+8WEx8KIQ4Ev/s+bUtAisCOdg5BHr+NzsL+YFV1xa01arKhpEJehWHEt2cwN56HVZaSGRNSkOJ6ExX7kYBjDosMEcZXYqQUDeDnKnYWwrF7282h2mB6QRekr274DK5fabWWKhqSC+DNv1mtDsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021049; c=relaxed/simple;
	bh=r/D20hrArXMBG8E23whhjub2uaUj264kFu9a7ht2Fd8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PNl4GFBCWOgV5yD4B3x3B2f1BfMQBIElhVcREpzAOQf3bS90/PiHoLRR8tYuOM5nrGkvhKd99vUBLEADwzkUQrezzuIaogPDQD10g+AUiwD55V/kynm1LfPvehM6UI1chnDhngqIh3EE2jIgd4bj5Uua40MEQzrjygpymH/JBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tmn9ZdjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AywoBfZYs0hgxR16cR9oz35TiDrwPR3AVxV88uEK+TA=;
	b=Tmn9ZdjXDAWfGROnNTjRoisoMFeIHWaLP9EoybbYiPn64CcCiTs56HAO+I78DyBaz7wMNz
	0GUHyEo6TH+UwMmMQec1tXxlyRAu+3F3YBaeJC3d7A1Y/2wLofIfkd0FovvQ7W1IxB5Sct
	8KUN5rh/S1aITun9C//mVpadkPlOrQ8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-R90C-sf9MP23XPohsh10Gg-1; Fri, 27 Jun 2025 06:44:05 -0400
X-MC-Unique: R90C-sf9MP23XPohsh10Gg-1
X-Mimecast-MFC-AGG-ID: R90C-sf9MP23XPohsh10Gg_1751021044
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d40f335529so443944985a.0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 03:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021044; x=1751625844;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AywoBfZYs0hgxR16cR9oz35TiDrwPR3AVxV88uEK+TA=;
        b=iuOmrTiRU8Cjt3Nq/Obxi1Ca+Brs3E2uiO8IHBK9NQtAsXjIOZZ7klMaApjTIDJcp4
         E15wb8IH9QSRPKIyetDMewNyCLfBMsFZpCv6hnq7y/YLzbBzHXmUJCDPJTfnXxld5KWl
         +u9EPqAPZIM8pynGBJNRmzUU95nCucdO0kSu/uZoLdCAiH64m6ZeTTICbOlXOYJ7CCmf
         9R2U2dKCpi6yhMMpFIwwXsY3eJhYV6yX7A57+TkvTYi+tox86jt5/IY8eE5zf/16Gzek
         A+Anhmo0GacfZ2sUlL28sD+vFTByOM0YdKmiOQWmo/vUoUZfrjp+DXD9kvd1uDmLZ2v1
         gXhQ==
X-Gm-Message-State: AOJu0YzjXBvKPlfp6t5f0NnCmChxMcjz1Ll/uNsR/HTrAubS6Mlo6Zx0
	RegDJ6SR2nk6VXp8HjmGrbsgiP28oyBUSRRTOkGpUo4RPudlrRRTfyVhpHMzBtFsAjyS8J+mVZq
	goX1VKKv1hAvgMOh8RVU7Za+5/VN72pLUaDaFzwBa2C6/JiXrey/dgTgM5GL+JlKTKW8R3l5OTD
	qY5rf2VD1w4uGWEqd8HIXcom1li0FqndQUlIoy9cNY5B8=
X-Gm-Gg: ASbGncvebGyrU4i3oSeEtYA8ptG0GJ82wTADj3OPOiW8lyALVziIjiVukJpoF0EHDlM
	48uh8vrkqTXjH3FA9ti/lGfNNrEo4TNkUl2924mucziggCK1dtFEEQ1U5Tu5ffg9E2L89RVgnRO
	RY7T/h4neCZN5DcBaxctQLHIYkxDR0n7aZHAOR8PaVDhuWt4WocgTEi8KJ5zCn9PdNDiNBqb2nP
	JVjoUtQ015Y5BTPP+cU5iGgkzQSl/ESzpmfa8V6/ROLaj+Rmihs/vyUZAqtGfHA/mzHwfVVrNGG
	uK57XRmrGOA9GP3ccV7VjNk0FXDf6zc0NBuE8eXGK5xnoEbvgCWAmlIl2ERYm9enfEVbgA==
X-Received: by 2002:a05:620a:2549:b0:7d4:3c38:7da5 with SMTP id af79cd13be357-7d43c387f0emr894397385a.14.1751021043893;
        Fri, 27 Jun 2025 03:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLULUitaDfYexGw/AeaKYb8Dqe5GJQjgOGoMTQzxN42zx1hbI8yuJOY0sNIFTr18AbhSO2lw==
X-Received: by 2002:a05:620a:2549:b0:7d4:3c38:7da5 with SMTP id af79cd13be357-7d43c387f0emr894394485a.14.1751021043383;
        Fri, 27 Jun 2025 03:44:03 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:2067:3372:85b3:36fe? ([2603:6000:d605:db00:2067:3372:85b3:36fe])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc5ad5ffsm9734721cf.75.2025.06.27.03.44.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 03:44:02 -0700 (PDT)
Message-ID: <e007eaf1-ff4b-4271-9ff4-82404b6e4688@redhat.com>
Date: Fri, 27 Jun 2025 06:44:01 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix build with glibc-2.42
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20250627100658.102342-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20250627100658.102342-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/27/25 6:06 AM, Steve Dickson wrote:
> From: Yaakov Selkowitz <yselkowi@redhat.com>
> 
> exportfs.c: In function ‘release_lockfile’:
> exportfs.c:83:17: error: ignoring return value of ‘lockf’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
>     83 |                 lockf(_lockfd, F_ULOCK, 0);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> exportfs.c: In function ‘grab_lockfile’:
> exportfs.c:77:17: error: ignoring return value of ‘lockf’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
>     77 |                 lockf(_lockfd, F_LOCK, 0);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> lockf is now marked with attribute warn_unused_result:
> 
> https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=f3c82fc1b41261f582f5f9fa12f74af9bcbc88f9
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: nfs-utils-2-8-4-rc3)

steved.
> ---
>   utils/exportfs/exportfs.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index b03a047b..748c38e3 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -74,13 +74,19 @@ grab_lockfile(void)
>   {
>   	_lockfd = open(lockfile, O_CREAT|O_RDWR, 0666);
>   	if (_lockfd != -1)
> -		lockf(_lockfd, F_LOCK, 0);
> +		if (lockf(_lockfd, F_LOCK, 0) != 0) {
> +			xlog_warn("%s: lockf() failed: errno %d (%s)",
> +			__func__, errno, strerror(errno));
> +		}
>   }
>   static void
>   release_lockfile(void)
>   {
>   	if (_lockfd != -1) {
> -		lockf(_lockfd, F_ULOCK, 0);
> +		if (lockf(_lockfd, F_ULOCK, 0) != 0) {
> +			xlog_warn("%s: lockf() failed: errno %d (%s)",
> +			__func__, errno, strerror(errno));
> +		}
>   		close(_lockfd);
>   		_lockfd = -1;
>   	}


