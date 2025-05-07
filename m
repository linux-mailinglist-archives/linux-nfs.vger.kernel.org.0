Return-Path: <linux-nfs+bounces-11579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AEAAE30F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FA546364A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6928981F;
	Wed,  7 May 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fds/vJ7V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93124281369;
	Wed,  7 May 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627905; cv=none; b=kuSBq4pDDp0yvzTW1VhGo7zFealxItIOfxMKqKRhnvhZYiuuLtS27iqzO+eQtxvuUAvDzAAgbux80OgAylPzCuyutBSUHkNgsPZfHc45JPnzlsrhpuN+fr/R8YBXAPONURMmsFf9d5fbbzUdBMLBaEQrDmQRRKf3UPj09qIqS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627905; c=relaxed/simple;
	bh=VWD7WqVDPeXj9twUcUFapIRynqKgAhDd6ooWQ/9Di0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lC5gfkHnNAn2YwcqoD3aHXE2gmVToT/L4AxKPI+cFzIRklnLYT3LIJJZaDSSz2aV4SOzVvAR7ekhlvJ9KbH12Iiut9+3pq8wogawwKvUnRQx9wrRyEv1MLEF6UDnsekvzAA5UsUz5PM0lNz2xD+mONVSdKhaalBHzHpltyh/P3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fds/vJ7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3154AC4CEE2;
	Wed,  7 May 2025 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746627905;
	bh=VWD7WqVDPeXj9twUcUFapIRynqKgAhDd6ooWQ/9Di0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fds/vJ7V06A7HlNn3H3ZjvOB8u9lUFpjg6cX11BHRg1MBg933JgQk1PArkgS8nTmg
	 AXNiguvL6VmU1UKgeOybpdyKrVl1sAA0D8Kbqy1XXh7vNEPp+JKLd6SOXU+YqpQkxy
	 21qc9dAXtBUnd0F1f+FgZQXmgH7hQq5kxKELMKIa3MPHWTRsTKTURSSc4LzLMPSQqb
	 Jc9KSDCWnXziVCAU5NOZsiVbLBA23K7m+mokL2HBNj3L7XQL/ZknKCA732eQO4S9kR
	 Y188ry4xsfHkxW+5eyyQ4p1cIPxQtDNMYnJ9/znI50eDC8WQ+gRAr1qNwAQl42UbGR
	 7AEvykn5yrJLw==
Message-ID: <c92cddd9-9099-4ccf-87c3-6bb427342794@kernel.org>
Date: Wed, 7 May 2025 10:25:03 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] SUNRPC: Bump the maximum payload size for the
 server
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-15-cel@kernel.org> <aBoP249KZ5G9hU81@infradead.org>
 <390ac9ce-d32d-4534-a406-52288f79ab0c@kernel.org>
 <aBsO28mbIZrU2HHD@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aBsO28mbIZrU2HHD@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 3:42 AM, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 09:52:06AM -0400, Chuck Lever wrote:
>>> Are you going to wire this up to a config file in nfs-utils that
>>> gets set before the daemon starts?
>>
>> That's up to SteveD -- it might be added to /etc/nfs.conf.
> 
> Well, you should be talking to him or even include a patch.

On this list, we post nfs-utils patches separately, once the kernel API
is nailed. Steve doesn't pull such changes until the kernel changes
have been merged.

But see below: I'm still not convinced this is a tunable that is worth
going to that level of trouble for.


>>> Because otherwise this is a pretty horrible user interface.
>>
>> This is an API that has existed forever.
> 
> Huh?  It is a brand new file added by this patch.

/proc/fs/nfsd/max_block_size was added by commit 596bbe53eb3a ("[PATCH]
knfsd: Allow max size of NFSd payload to be configured") in 2006.

Or are you referring to something else?


>> I don't even like that this maximum can be tuned. After a period of
>> experimentation, I was going to set the default to a higher value and
>> be done with it, because I can't think of a reason why it needs to be
>> shifted up or down after that.
> 
> Why not?  A tiny desk NAS box has very different resources available
> compared to say a multi-socket enterprise AI data server.

I don't believe system memory size is a concern.

a. max_block_size is automatically reduced on small memory systems. See
   nfsd_get_default_max_blksize().

b. The extra memory allocation is per thread, so a smaller server can
   reduce the standing memory requirements by lowering the number of
   nfsd threads.

c. we're now removing rq_vec, so there's already less memory to allocate
   than before.


-- 
Chuck Lever

