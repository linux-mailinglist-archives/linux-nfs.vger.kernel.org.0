Return-Path: <linux-nfs+bounces-15014-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2625BC175E
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 15:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF581189D87F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4322DF15B;
	Tue,  7 Oct 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5CHOMis"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC091DF982
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843022; cv=none; b=XbSOAhrU9TP7v/8yH6iDQQun6+bye8eFdHCX61wgBRgPJLYrMXRLMqCJhdxHY8DKyZLeommd5p18kvL4vFG6zOR53oLjAhgFQ5D0HFrUToesWNkGMnzeDxzXqzFUb/asHUpVObium6brESpcijPv6Kwk8Gc1yeU4RtmVKqx/cPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843022; c=relaxed/simple;
	bh=+UJkT+stGGBAmt0+WskkBRCocYkm0fZzhGdP1EJC+pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQQeRWnBAEsC0NCTRcaIpDIB1EWUt4lQdFEHiXCPV/FKYN+h0V+F49kduOdLNxpDYiSsp1vJlIg84i70P7MYs5ldzoP7tdbDYA+WiUCxmrw5snLzkqZnCcp25KIgjX3jtgb7gzpCEKJ2veIST1jj++HO9r7JX8llt0HT8CGk4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5CHOMis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D434EC4CEF1;
	Tue,  7 Oct 2025 13:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759843021;
	bh=+UJkT+stGGBAmt0+WskkBRCocYkm0fZzhGdP1EJC+pM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M5CHOMissmjCHI0dk8ldptLkBBJBwQ9Y3IP+jA82yZ4tAxr8bweF6Epm2sRkL/i+X
	 wix3Qc46Qlmx58eRhrpwowe0zMnz7XxQZw98JHQ90/P838YI2mkmNcj/YDFGkM7uOP
	 W+sIZUVsx/ySs6TS7Dxm4PeJVX6JOsO1TcF6qylH5Uhu/QTuelK1HR38p5R5dvPUU8
	 mgygByYgmEJWDYsfhXMWF/+JNRvPENX1rKUu+W4qToBM0n/RU6O9IGpWT/aTyxM6pM
	 GYmyxfTYfq1i1ZglmA8EZxl7XJP1pFVU/iOw52+vHJj6oLnD8QY2aRrap0Avq2sAKD
	 vxWhbeEuwg4mQ==
Message-ID: <c6844b75-7875-4741-a8fd-fd807c086736@kernel.org>
Date: Tue, 7 Oct 2025 09:16:57 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Fix unwanted memory overwrites
To: Tom Talpey <tom@talpey.com>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251006184502.1414-1-cel@kernel.org>
 <f0b5acc6-0e67-4736-833c-4af16c05ef74@talpey.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <f0b5acc6-0e67-4736-833c-4af16c05ef74@talpey.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 8:45 AM, Tom Talpey wrote:
> On 10/6/2025 2:45 PM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> <rtm@csail.mit.edu> reported some memory overwrites that can be
>> triggered by NFS client input. I was able to observe overwrites
>> by enabling KASAN and running his reproducer [1].
>>
>> NFSD caches COMPOUNDs containing only a single SEQUENCE operation
>> whether the client requests it to or not, in order to work around a
>> deficiency in the NFSv4.1 protocol. However, the predicate that
>> identifies solo SEQUENCE operations was incorrect.
> 
> I'm not sure why a SEQUENCE should be ever be cached, apart from
> recognizing it as one of the operations in a prior request. The
> idea from a protocol perspective is that the sequence is just a
> ind of clock that ticks once per time it's executed, and it only
> ticks when the sender sends something new.
> 
> IOW from a responder (server) perspective, caching it seems wrong.
> Can you elaborate on your interpretation of RFC8881?
I'm basing my remarks about the protocol on this old comment that is
near the code repaired by this series.

/*
 * The session reply cache only needs to cache replies that the client
 * actually asked us to.  But it's almost free for us to cache compounds
 * consisting of only a SEQUENCE op, so we may as well cache those too.
 * Also, the protocol doesn't give us a convenient response in the case
 * of a replay of a solo SEQUENCE op that wasn't cached
 * (RETRY_UNCACHED_REP can only be returned in the second op of a
 * compound).
 */


>> (Based on my reading of RFC 8881, I'm not sure NFSD should cache
>> solo SEQUENCE operations that fail, but that is perhaps for a
>> different day). 

The 2009 commit that broke this removed the logic that prevented caching
failed solo SEQUENCE operations. It might be more sensible to simply
revert that commit entirely.

Or, further, if it seems utterly broken to cache even successful solo
SEQUENCE operations, then I would consider removing the solo SEQUENCE
caching logic.

RFC 8881 Section 2.10.6.1.3 opens with:

> On a per-request basis, the requester can choose to direct the replier
> to cache the reply to all operations after the first operation
> (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or csa_cachethis fields
> of the arguments to SEQUENCE or CB_SEQUENCE.
That suggests the spec authors expected servers not to cache a
COMPOUND's SEQUENCE result at all.


-- 
Chuck Lever

