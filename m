Return-Path: <linux-nfs+bounces-5257-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F286394A7B7
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2024 14:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9BEB291D0
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2024 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F81E213D;
	Wed,  7 Aug 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s5mBTaE9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA941C7B84
	for <linux-nfs@vger.kernel.org>; Wed,  7 Aug 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033813; cv=none; b=cPfaF8PIbETcR95tLIeQ9FLMBjFOZxaa6Tb7qRvJoS1SAm0CznFH9dXUgJi4BCVKpTd3nefK/9EVh11ma/JtZhvWWxnFSkrOwgjRBJC4ZfLoU2zuVl/KGHS2hnFan30RVScQ7b5lH96OlU9X/pVtr+8yI1alA3vY926/QOYnXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033813; c=relaxed/simple;
	bh=Og6Tem/RE53e9lDJZsKhh6chmbSIBaBW7YoGkf/rphM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWg6nF/6GxuNt5THXldd59GAtz1/c9COPHJdoS7jWMkAIoUaHeIdjGA2zjsq0YSXVrQDBZF/y5fv7TFU3m2Yk9LT/RLAkOGUxy9kDhJuWUxGD80TmxmdyRlGnUMXIJoTPxQMajh82AUrGWVyh54r28xaUHrgSjKNkXPjbvCBkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s5mBTaE9; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34c91f30-bc4c-d142-038c-2ed8cd2469dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723033807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Og6Tem/RE53e9lDJZsKhh6chmbSIBaBW7YoGkf/rphM=;
	b=s5mBTaE9+oiHIAisftwRgjlIMGy3hyiTiC56DXGyqyt978WC5axwAPhn1maXzb4GqcJgSb
	Xc54xFDAKyMM7zXSi+3ZmS9xyOPAu7oZAs62BEJ5ijmFCUSofBXsI0Gt9mzoqtdBq+jBRY
	QZAyYRTRaPjdJ7esDPYbN72bjsGRu5o=
Date: Wed, 7 Aug 2024 20:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nfsd: remove unnecessary cache_put from idmap_lookup
To: NeilBrown <neilb@suse.de>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
References: <20240805105715.11660-1-guoqing.jiang@linux.dev>
 <172298871466.6062.17538058852164217892@noble.neil.brown.name>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <172298871466.6062.17538058852164217892@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Neil,

On 8/7/24 07:58, NeilBrown wrote:
> On Mon, 05 Aug 2024, Guoqing Jiang wrote:
>> It is not needed given cache_check already calls cache_put on failure,
>> otherwise we call cache_put twice in case of -ETIMEDOUT.
> cache_check() was called on a different *item.
>
> This cache_put() puts the *item returned by lookup_fn() two lines
> earlier.
>
> The current code is correct.

Thanks for point it out! So this cache_put is paired with lookup_fn which
calls cache_get on a new item.

BTW, I checked idmap_id_to_name which didn't put cache if there is no
enough buffer, not sure if we need it here.

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 7a806ac13e31..7abddf7d8f6d 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -594,8 +594,10 @@ static __be32 idmap_id_to_name(struct xdr_stream *xdr,
         ret = strlen(item->name);
         WARN_ON_ONCE(ret > IDMAP_NAMESZ);
         p = xdr_reserve_space(xdr, ret + 4);
-       if (!p)
+       if (!p) {
+               cache_put(&item->h, nn->idtoname_cache);
                 return nfserr_resource;
+       }
         p = xdr_encode_opaque(p, item->name, ret);
         cache_put(&item->h, nn->idtoname_cache);
         return 0;

Thanks,
Guoqing

