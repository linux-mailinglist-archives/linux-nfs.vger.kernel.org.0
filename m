Return-Path: <linux-nfs+bounces-14847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E73BB1AB1
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1991923FDB
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F27276030;
	Wed,  1 Oct 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7Ytx0Ks"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B9246333;
	Wed,  1 Oct 2025 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759349893; cv=none; b=bng5ki8yALDkRefCWkFnhnbz015x00Y6OcsURrFR3g81OCZ9F9OCtLX72fW7ecyr3KJphOg2PWrtVdS1BeTMv7C868FQUMcn28G5bPjb46Qa5aPBg/BTWof+o2fKT8BKraax2ZLpaQrORtf+c0Ier0G6acvx7B+9oNCjuJ8bkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759349893; c=relaxed/simple;
	bh=XKqZ71ZFkeikuPZEgrFrB0WDfHrcuxCy1Lo05b6QUpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5/vwBO47A+haW2Ytq3Hg8U4wOrsd+ncClGK7JDy2P/ROLZhiWD7+HpPJxVQATfqD1Afynk7Vqzg1ylcKo8biJwFqY3cwsMlid93NskWALsn315YwRL92ifsGr0s6Ot1z27XOM0pydqocgFxWKFvrY+QFwBWYZ3NUejFS7iNzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7Ytx0Ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECC5C4CEF1;
	Wed,  1 Oct 2025 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759349892;
	bh=XKqZ71ZFkeikuPZEgrFrB0WDfHrcuxCy1Lo05b6QUpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j7Ytx0KsT3ZjWSq3yP69szSofmLhIvUeNIkfXpSkz9J7TF/VbnZW5RR27sQn1wg79
	 +QKeKc0DlivVjfPjuAUUjMN0lRz42iPi5es7q/kHgPGkJDHDhJ+CHAc2IknxRR/14X
	 amLoKTdfW9wQFXVm5jcO4ynXisyBe48MvRmgp7bIXsodwXMsfBFUdx8GWqNJOwbOPi
	 jo6QXvliNdtqRJWQcmigvWBe03QyeWhvdP5dvmLz+1RTGlIad3f/Co9DdeY06ShnOc
	 dcouT8z5N4sYdr2fo8YPR8hjNoNuhShO9Qjswo14hvh9cVQfsyZ6tkGaE1gaxBurI6
	 OA3g3eHPkvzEQ==
Message-ID: <2cfc0bf3-e1ee-46ab-9fa5-de6d0e39a3db@kernel.org>
Date: Wed, 1 Oct 2025 16:18:10 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] svcrdma: Increase the server's default RPC/RDMA credit
 grant
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250926155235.60924-1-cel@kernel.org>
 <aN2Cnz1TrdOO74vb@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aN2Cnz1TrdOO74vb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 3:35 PM, Mike Snitzer wrote:
> On Fri, Sep 26, 2025 at 11:52:35AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Now that the nfsd thread count can scale to more threads, permit
> 
> Just trying to appreciate which change(s) paved the way for this
> RPCRDMA_MAX_REQUESTS change.
> 
> Are you referring to the netlink interface changes Jeff did earlier
> this year or something else? (thinking "something else" but...)
> 
> Might be useful to update the header to convey which specific
> commit(s) made this change possible.

The svc thread scaling change refers to the commits from

e3274026e2ec ("SUNRPC: move all of xprt handling into svc_xprt_handle()")

to

15d39883ee7d ("SUNRPC: change the back-channel queue to lwq")

all dated about two years ago, merged in v6.7. Just checking,
should the updated description provide more detail than that?


-- 
Chuck Lever

