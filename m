Return-Path: <linux-nfs+bounces-12857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4DAF5F04
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 18:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B82F172E41
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF12FC3DC;
	Wed,  2 Jul 2025 16:47:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5072600;
	Wed,  2 Jul 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474873; cv=none; b=dSznHsPX27IU+iXDqkM3mhvxL1ndUpGhiE15wBWpuKhECXOcN/B9HkVp/hk8nUYtKalj9MXBwKiqGEWdfv1kmN7jegoiH3onRpgoQ2SqDS5HqSEDVnEjxCKbVQKGUn35t9/MLn2oHfLuiT2iPKO+K8Ybm8l9jovV1fpZvOH06kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474873; c=relaxed/simple;
	bh=kdtzP1DOdxUyE0j4okOCKRrjES3jFyJi9K58SvycYIg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=n2hFvEb43UptHzyK4go1crmlToCyEOFnv17zJyyRm1pOxnfQ7ub9rjpPTTANWXwKcNLUPZkjvnQ6QLAV/p9joCxwvQmeoQcfxm+tb+8B29FoHIFJnheizRoV9GLMs+/qGCISPkFa98OQNeDLsTe6oqu2/UT2wXLGUhIZCt3j2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.129.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 2 Jul
 2025 19:47:37 +0300
Message-ID: <8244b3f4-ea69-46ee-9ba2-6711f516f00b@omp.ru>
Date: Wed, 2 Jul 2025 19:47:36 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
CC: <linux-kernel@vger.kernel.org>
References: <f769ad67-fc6b-4101-8bdc-8b41eba73a21@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <f769ad67-fc6b-4101-8bdc-8b41eba73a21@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/02/2025 16:33:19
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194502 [Jul 02 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.129.136 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.129.136 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.129.136
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/02/2025 16:36:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/2/2025 2:58:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 7/1/25 11:35 PM, Sergey Shtylyov wrote:

> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
> field is multiplied by HZ -- that might overflow before being implicitly
> cast to *unsigned long*. Actually, there's no need to multiply by HZ at all
> the call sites of nfs4_set_lease_period() -- it makes more sense to do that
> once, inside that function, calling check_mul_overflow() and capping result
> at ULONG_MAX on actual overflow...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org
> 
> ---
> The patch is against the master branch of Trond Myklebust's linux-nfs.git repo.
> 
> Changes in version 2:
> - made use of check_mul_overflow() instead of mul_u32_u32();
> - capped the multiplication result at ULONG_MAX instead of returning -ERANGE,
>   keeping nfs4_set_lease_period() *void*;
> - rewrote the patch description accordingly.

   Forgot to say that I had to adjust the patch description to make it clear
that the overflow happens on 64-bit arches as well...

[...]

MBR, Sergey


