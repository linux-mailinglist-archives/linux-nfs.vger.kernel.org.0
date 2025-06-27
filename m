Return-Path: <linux-nfs+bounces-12807-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C33AEC0D2
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 22:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59B81C6330C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EBAC2FB;
	Fri, 27 Jun 2025 20:23:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E58221F31
	for <linux-nfs@vger.kernel.org>; Fri, 27 Jun 2025 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055823; cv=none; b=P3h8wmpXwj2Afrcrgm+m7b1L46WHhGG+vclRxVwl9ScW1VlvxmalnXSQjlc+OvdvRisGD3yvJ2iIgmVBR1C9zKtKapUEUP6TFrxIPJp4YEJra7ZTmINusZD0rK7/qXkHle5fjS1eOrbOo+RmL/10Ay7TWxdwNvK7WUZeUd8wU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055823; c=relaxed/simple;
	bh=ieCYx06r3guWCSz2kV6ZQqbtoJFgArp/xJbXkaOvFWs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Qt6351MsuitxS93hNNxOyHi/f1sgz5p9T1FKSrYrx/u3zHKOoyb1IQ1V/e0UcBEXwc4ntQcHRS64KG6U1funcUs77BlH0wBl27RadX2zydQOywmTxKwEHTY5zjxTCaSGLcCUVmlwOGGijT4GMyo2Hu+lxO5fKFtY7vtqjaEq6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.153.12) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 27 Jun
 2025 23:23:21 +0300
Message-ID: <f86e1071-8b7a-423b-b9e3-617ade534e42@omp.ru>
Date: Fri, 27 Jun 2025 23:23:20 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
References: <4904f32e-a392-803b-9766-4aa2d5cee12b@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <4904f32e-a392-803b-9766-4aa2d5cee12b@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/27/2025 20:08:19
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194401 [Jun 27 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.153.12 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.153.12
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/27/2025 20:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/27/2025 7:10:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 8/23/24 11:32 PM, Sergey Shtylyov wrote:

> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
> field is multiplied by HZ -- that might overflow *unsigned long* on 32-bit
> arches.  Actually, there's no need to multiply by HZ at all the call sites

   As the multiplication by HZ is performed on 32-bit field, the overflow
will occur regardless of 32/64-bitness...

> of nfs4_set_lease_period() -- it makes more sense to do that once, inside
> that function (using mul_u32_u32(), as it produces a better code on 32-bit
> x86 arch), also checking for an overflow there and returning -ERANGE if it
> does happen (we're also making that function *int* instead of *void* and
> adding the result checks to its callers)...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org

[...]

> Index: linux-nfs/fs/nfs/nfs4renewd.c
> ===================================================================
> --- linux-nfs.orig/fs/nfs/nfs4renewd.c
> +++ linux-nfs/fs/nfs/nfs4renewd.c
> @@ -137,15 +137,22 @@ nfs4_kill_renewd(struct nfs_client *clp)
>   * nfs4_set_lease_period - Sets the lease period on a nfs_client
>   *
>   * @clp: pointer to nfs_client
> - * @lease: new value for lease period
> + * @period: new value for lease period (in seconds)
>   */
> -void nfs4_set_lease_period(struct nfs_client *clp,
> -		unsigned long lease)
> +int nfs4_set_lease_period(struct nfs_client *clp, u32 period)
>  {
> +	u64 result = mul_u32_u32(period, HZ);
> +	unsigned long lease = result;
> +
> +	/* First see if period * HZ actually fits into unsigned long... */
> +	if (result > ULONG_MAX)
> +		return -ERANGE;
> +

   Now that I have discovered check_mul_overflow(), I think I'll have to
rewrite this code using it instead...

[...]

MBR, Sergey


