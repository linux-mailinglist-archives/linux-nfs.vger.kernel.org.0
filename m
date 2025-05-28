Return-Path: <linux-nfs+bounces-11957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE1AC70DD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 20:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C483BE02B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994328E561;
	Wed, 28 May 2025 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm6NlCxb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660921EE7B7;
	Wed, 28 May 2025 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456707; cv=none; b=mdVfVDhB81QmVBynbn2trAbf564azOcTiMj8Y5LJCtVp977tuBaYoDMA5z4NKCD16j4OegShKABpKHj51zo/Y2s2V+uUT8bmVp/6/smfwI8F7s9dolrPCmVnq37jFuqmzCC7lo8w6esfWLMiMFH6LGDPhW84RkxkRecwWKtQE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456707; c=relaxed/simple;
	bh=9R7rQjswLIJrPgJWl6lP8SrIEa2p86XfG8Anl84D21U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEXbjy1D4ncB4JQ+BQY/Ud94SxQL/Brf7+9txqymDITR32wOedAA5BEvwvfl/MRBeO+E2mbmByr6Yahu43H3NTO3sqrqSw6MrH8SZ9cVoo+ZUVkpyKldKErwQH6vgQzXVx4vch97BXDTSJTm4wjT9WRzjJd4tp22hi3NCFEslyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm6NlCxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B4DC4CEEB;
	Wed, 28 May 2025 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748456706;
	bh=9R7rQjswLIJrPgJWl6lP8SrIEa2p86XfG8Anl84D21U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lm6NlCxb4vJfwwDcN3M2IJMcH6XVEBaOsoyVhSjaFO6iaP8Fvlf+oxupHzRawfPff
	 Q8hd7RaxLTWOMi4ZI3RPk2rdJUrOd4tDzZjbV5Ni4ETaLsyBGIWHbitCyhJFG0+3tw
	 cY2PQXrv743zvL+0Ey9h0Aoe0I8PTQRCspi2+YABHXwzqRv5qp59euZuZFvV9PJWdT
	 sr2uPrzcpf7DhWTlvHAJJpeE44NYZxC6iPI1nYibsBO2wRTG9VL5imJ9f8FJg3E68B
	 ZY2oA7BKjVHApGbiHAjegPoQiaFpANf3Uf1q9IHnSFY5R72sX1uIA303KVUJeYVKTe
	 J5pBf/3lIn1Cg==
Message-ID: <b8061efa-83ef-4a7a-a39e-0475dce42614@kernel.org>
Date: Wed, 28 May 2025 14:25:04 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nfsd: use threads array as-is in netlink thread set
 interface
To: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <174845587080.200069.9203268802136145057.b4-ty@oracle.com>
 <298ef5505e7abb9a0ca5f151090a42f8bf330c43.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <298ef5505e7abb9a0ca5f151090a42f8bf330c43.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/25 2:22 PM, Jeff Layton wrote:
> On Wed, 2025-05-28 at 14:11 -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> On Tue, 27 May 2025 20:12:46 -0400, Jeff Layton wrote:
>>> The first patch is probably appropriate for stable. It should fix
>>> problems when someone sets the pool_mode to pernode, without userland
>>> sending down a fully-populated thread array.
>>>
>>> The second patch just adds a couple of new tracepoints that I ended up
>>> using to track this down.
>>>
>>> [...]
>>
>> Applied to nfsd-testing, thanks!
>>
>> [1/2] nfsd: use threads array as-is in netlink interface
>>       commit: b2a9a114a3c7f5abfa2875b70ce9b73525a74291
>> [2/2] sunrpc: new tracepoints around svc thread wakeups
>>       commit: 65b8babe551bddf00aac69bc905f88a4e0371766
>>
> 
> My apologies, Chuck. Patch #2 has a bug in it:
> 
> +       trace_svc_pool_thread_noidle(pool, rqstp->rq_task->pid);
> 
> In the call above, the rqstp will be undefined. That should be:
> 
> +       trace_svc_pool_thread_noidle(pool, 0);
> 
> You can fix that up in tree, or I can resend if you prefer.

Fixed.


-- 
Chuck Lever

