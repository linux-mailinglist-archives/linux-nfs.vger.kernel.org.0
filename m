Return-Path: <linux-nfs+bounces-8918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC35A01B61
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 19:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627A4161BC3
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0814A4DF;
	Sun,  5 Jan 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RObkK/y9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F37DA95
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736102165; cv=none; b=EmatjJGwxBfPmG8mUPsYsLcMVhNclneGRCBCptWBkz82b4MyhnBHpmJu7tZWUivp7vsVByK1hh1O+CgZd3duh8TAn0YBo7PPoYlmVZeDZGnlBs+EsqBbVCZbbEXhJ3krIWQGHH0ZugVAkoT5dWWOagS/rK8S/A5mGgicbyUOC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736102165; c=relaxed/simple;
	bh=z4RmRcAr9KuiwZRPfozbbQI0VKC6Mx6EdZuAboUy2gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmBQlIXgSPa9jEmC6jYCgabomwJtKiPTDn5xA+XHiuxrj1+BS3WeeC0acZ56kkLD6NhTu8DZ33pqHma8ZTlet3DWkUi9pAq2/1u7X6jAxPYj7tZtpc9RO1+SwkBtCZklbSpNBBfXuP9C0JS8XAoHOHEVM/EuJTFpFpRiFZw8Cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RObkK/y9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736102162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CReKvsr+woekyyU6G6tfpy4NbPJcrniIlSPo3bMbasU=;
	b=RObkK/y9zD106NO16rIcECkFsaqFvuj3VR4t4YtlnMCtJK2+zxn8ygEQQ3oQ0zv6gs53y3
	vUQQu3OpJeqk2LaQjF52PFhW1Pint0lmUpqlKNDO/YU67D2b7n+qKzCB2PemlJLAWzz5Bq
	ad8zyjh3egncbhwQC9udVX7OvJpLayQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-s2x-pLzPPPaU9OUGgwKiaQ-1; Sun, 05 Jan 2025 13:36:00 -0500
X-MC-Unique: s2x-pLzPPPaU9OUGgwKiaQ-1
X-Mimecast-MFC-AGG-ID: s2x-pLzPPPaU9OUGgwKiaQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e178d4f8so1296756385a.3
        for <linux-nfs@vger.kernel.org>; Sun, 05 Jan 2025 10:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736102159; x=1736706959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CReKvsr+woekyyU6G6tfpy4NbPJcrniIlSPo3bMbasU=;
        b=VYAevw+hHzRhHG2nz0Hmd/mxnwGOa+yCwdqPfYOrNrMutfdaVbUk/G5RvJki+vJR97
         y1W4uaeH1Ud20ngaXl78qQhyNgvStRIFG7lY2zwN2edi/7mQg5RtNoAE7b50AXpQme2Z
         bQUVUroWPPCOtWlqhzR1XdIzGlQtpHMGFpRIbKI/L1Xg9tdJ+dzfuwEomvWgbY/kB32n
         7+Coc65SObDNRAW8yVtiiklKk4YM33+7wYUaue/dnmJv8aqGjraIhuV47Hz63byJlmMA
         +hBXqcPj+fKNuzhed0I73f7ddAwhR+qGnR2RAE1X33KsM3La1T3g9LvOqQz1BMoSFUjV
         reqw==
X-Gm-Message-State: AOJu0YwtOxtTqhdZTrZXSQ8SPmb/y9YoO5JkzH9pJnucazq+SXJzX9N4
	X9FgjiNKMAq451lTBl8IM1831vACCbRJV1dxV/hbcFnzsK3gGPdT2m3X1f2A1bMa9dUzVJU/8Ve
	TrPuTkWM4Iqejc+IFFQiKQQ4LccU5dzE2hdPY4mg8q/CgOs5MelLlMEIo/HjXIMMq/Q==
X-Gm-Gg: ASbGncs5xN8qFfHm4Wi/O3JCxwgC8P1MIh3YWXf/9DXgWADTF0FKjQrzkOZgnU5Yxwc
	ylOp3Fwes0eEq2RGWWWMKooM3PAC9XOgFg1U+XYAxPlvclNFNR+0GHpGLX7yzXE/l8lRuoMWNKU
	ybPca3bKZrMbO/uhUwyz8yG0anSRTysyQHy+mMhzzDPNBRTXiaofAHCbkTCrcpKnKVkOwXMr/g1
	pxb74+Etp4L6vzfjLQh64cKxBqkWJFObJlB2Dysw/EaTh4uptM60eTx
X-Received: by 2002:a05:620a:1aa0:b0:7b6:73f5:2868 with SMTP id af79cd13be357-7b9ba7eaeb4mr7561785485a.42.1736102159323;
        Sun, 05 Jan 2025 10:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjCIAuZre7EcTCssqnmrJiKPZDCgVhuvFKA9t7wOkHKQUUzp/Up9qKYRU1VSh+3Hq0gD/0pA==
X-Received: by 2002:a05:620a:1aa0:b0:7b6:73f5:2868 with SMTP id af79cd13be357-7b9ba7eaeb4mr7561783585a.42.1736102158991;
        Sun, 05 Jan 2025 10:35:58 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30e816sm1443062185a.64.2025.01.05.10.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 10:35:57 -0800 (PST)
Message-ID: <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
Date: Sun, 5 Jan 2025 13:35:56 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: Christopher Bii <christopherbii@hyub.org>
Cc: linux-nfs@vger.kernel.org, Yongcheng Yang <yongcheng.yang@gmail.com>,
 Neil Brown <neilb@suse.de>
References: <20241206221202.31507-1-christopherbii@hyub.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241206221202.31507-1-christopherbii@hyub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 12/6/24 5:11 PM, Christopher Bii wrote:
> Hello,
> 
> It is hinted in the configuration files that an attacker could gain access
> to arbitrary folders by guessing symlink paths that match exported dirs,
> but this is not the case. They can get access to the root export with
> certainty by simply symlinking to "../../../../../../../", which will
> always return "/".
> 
> This is due to realpath() being called in the main thread which isn't
> chrooted, concatenating the result with the export root to create the
> export entry's final absolute path which the kernel then exports.
> 
> PS: I already sent this patch to the mailing list about the same subject
> but it was poorly formatted. Changes were merged into a single commit. I
> have broken it up into smaller commits and made the patch into a single
> thread. Pardon the mistake, first contribution.
First of all thank you this contribution... but :-)
the patch makes an assumption that is incorrect.
An export directory has to exist when exported.

The point being... even though the export does not
exist when exported... it can in the future due
to mounting races. This is a change NeilBrown
made a few years back...

Which means the following fails which does not
with the original code

exportfs -ua
exportfs -vi *:/not_exist
exportfs: Failed to stat /not_exist: No such file or directory
(which is a warning, not an error meaning /not_exist is still exported)

With these patches this valid export fails
exportfs -vi *:/export_test fails with
exportfs: nfsd_realpath(): unable to resolve path /not_exist

because /not_exist is exported (aka in /var/lib/nfs/etab)
so the failure is not correct because /not_exist could
exist in the future.

Thank you Yongcheng Yang for this test which points
out the problem.

Here is part of the patch that needs work
in getexportent:

  	/* resolve symlinks */
-	if (realpath(ee.e_path, rpath) != NULL) {
-		rpath[sizeof (rpath) - 1] = '\0';
-		strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
-		ee.e_path[sizeof (ee.e_path) - 1] = '\0';
-	}
+	if (nfsd_realpath(ee.e_path, rpath) == NULL) {
+                xlog(L_ERROR, "nfsd_realpath(): unable to resolve path 
%s", ee.e_path);
+                goto out;
+        };

the current code ignores the realpath() failure... your patch does not.


I would like to fix the symlink vulnerability you have pointed
out... but stay with the assumptions of the original code.
I'll be more than willing to work with you to make this happen!

steved.
> 
> Thanks
> 
> Christopher Bii (5):
>    nfsd_path.h - nfsd_path.c: - Configured export rootdir must now be an
>      absolute path - Rootdir is into a global variable what will also be
>      used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is
>      simplified with nfsd_path_rootdir   which returns the global var
>      rather than reprobing config for rootdir   entry
>    nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
>    nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, const
>      char*) -> nfsd_path_prepend_root(const char*)
>    NFS export symlink vulnerability fix - Replaced dangerous use of
>      realpath within support/nfs/export.c with   nfsd_realpath variant
>      that is executed within the chrooted thread   rather than main
>      thread. - Implemented nfsd_path.h methods to work securely within
>      chrooted thread   using nfsd_run_task() helper
>    support/nfs/exports.c - Small changes
> 
>   support/export/export.c     |  17 +-
>   support/include/nfsd_path.h |   9 +-
>   support/misc/nfsd_path.c    | 362 ++++++++++++------------------------
>   support/nfs/exports.c       |  49 ++---
>   4 files changed, 151 insertions(+), 286 deletions(-)
> 


