Return-Path: <linux-nfs+bounces-5856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610996251F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C8C1C2108D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED001684B4;
	Wed, 28 Aug 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l2YVCTVn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070C1465AC
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841743; cv=none; b=VH7aZaemKna5iTzy1fO0o8Yq/UNT4cXNqhIuviz/ym/pMOYBQSQSkm1rIaxSSsd6cJ2aSCsiWnq6NqTlNC2uctNDaAl0S5DEWaHvoC3t4HCdIfHU5zFkaxtl2qcqH+TM33mT21HFp/zaSQ6e7hClKG/ZBmtkvTAd4QKWnaqT8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841743; c=relaxed/simple;
	bh=RMcKbGQdKx7LMPuRDj19e5JIRTrD7BFWemy7b75uBGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5RV09QGv/+cdmh1vQw0SxKP7Ljj98pX4FaCRYBN4uXOrh8XhlmDA71xvU4fjnK2aXgCwfSF0MPY0bFHbdtzB5/SWRU/01+RxJobj7PXfUE+vK2+JoZEL/oPr3PFS+AqTu1vxnJnV2dtQyYxuuH8OlTyWz9HVtdXOMYgU0iM3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l2YVCTVn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f69ab98d-3958-98ca-0c37-affe3571b278@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724841739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zTjHGEyUD7C26W/WOeXIJ6c/rt/MU99mAw3azM8zA0=;
	b=l2YVCTVnBqGjTUWHpV/y9wths26Ksn+xPpmpAQDok5hIkT+T5RSSLDrhNN0HJ3U9pPM8If
	ucBQvTM+GvTTRLytI02XGOPgm99cvRO7K0/LOHkutLiGjFtd7MlczLT/WS3ilz7ZViABns
	d+O3f2g+5eq1mbPLvvc744T65SV7I1s=
Date: Wed, 28 Aug 2024 18:42:07 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nfsd: call cache_put if xdr_reserve_space returns NULL
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
References: <20240821140318.7757-1-guoqing.jiang@linux.dev>
 <ZsyzZ47CKquEy9xV@tissot.1015granger.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <ZsyzZ47CKquEy9xV@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/27/24 00:55, Chuck Lever wrote:
> On Wed, 21 Aug 2024 22:03:18 +0800, Guoqing Jiang wrote:
>> If no enough buffer space available, but idmap_lookup have triggered
>> lookup_fn which calls cache_get and returns successfully. Then we
>> missed to call cache_put here which pairs with cache_get.
>>
>>
> I've adjusted some aspects of the patch and added a Fixes: tag.

Thanks for the modification!

Guoqing

> Applied to nfsd-next for v6.12, thanks!
>
> [1/1] nfsd: call cache_put if xdr_reserve_space returns NULL
>        commit: ada7d1ab3aa1266b24d08aa4b3df93360a203924


