Return-Path: <linux-nfs+bounces-11527-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D74AAC946
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C8C3BF4B3
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766072836BE;
	Tue,  6 May 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4Wj9aUj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45590283691;
	Tue,  6 May 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544846; cv=none; b=s95Q21ueQu364NMOPeN21QgCULEu9m/8tt/lQPFBmEvQ4OdmKOOxvHrTXmMYLUj01AuMwvzSjRgyOYuISB/rzBnWdVEU9hQfPCcmrBCm26Prg++YtAQzph7FjhgvnXic+8iGs8F7Q5qoumThWevowTEXJfLUpprY/ahqaAQYi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544846; c=relaxed/simple;
	bh=F1CKbzDS7VbAxMkQnbzbaJ04YSxiq+uitpiJ/DjJdtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qA+6ILI5IKsRUHDBMcGTjv7QRxU/kutK9rh/ADIhSnVT1pDnmkum5SjBkRbfPLARgQYwUy/rGQIFJjdQIWRVppBgIYbtsDxA1jHYOzKRr+tW6v8lN8XHXvEbZNuqR/4XfD6XvMHgK3Ow+9QJK9ISlA/1LF7lM7cEWw/EXsa1Tqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4Wj9aUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CBAC4CEE4;
	Tue,  6 May 2025 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746544846;
	bh=F1CKbzDS7VbAxMkQnbzbaJ04YSxiq+uitpiJ/DjJdtk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F4Wj9aUjypOOxp7XDgnYlmuYoTmv1/7A6NfF4sVWo4qC7h7TDjJ1z3EobbSwwTkrD
	 5cwMy8CIoQJ5u1r+UV+pG+rmzSpk2JYt3Wu1W7yaIFYFFak7pn0jD/URPvKQaVVLhV
	 SsfOnWHIu95JSl9a4yh+3JIKdqSnK5kw41T5GVMSYG0LKvQDeP804DlwPlBzpIz6KV
	 iCKXYjku6JVLH5L79txa4mEbciiHBzAxBZpOf5ukiiCmxwXTDlj1h2pP3CQe3RL7vK
	 LCWCg1hyRUQxGUR4ib/n61yciBc4xgJzxV7FH/S4iJuwLMjyIajF+n8iBfVj4Tcbbp
	 Irra4n5FsXCeQ==
Message-ID: <72c3106e-4c2e-41f5-b8bd-3053ebb51f37@kernel.org>
Date: Tue, 6 May 2025 11:20:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] svcrdma: Adjust the number of entries in
 svc_rdma_recv_ctxt::rc_pages
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-9-cel@kernel.org> <aBoPGNyGg0YPenm4@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aBoPGNyGg0YPenm4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 9:31 AM, Christoph Hellwig wrote:
> On Mon, Apr 28, 2025 at 03:36:56PM -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Allow allocation of more entries in the rc_pages[] array when the
>> maximum size of an RPC message is increased.
> 
> Can we maybe also look into a way to not allocate the pages in the
> rqst first just to free them when they get replaced with those from the
> RDMA receive context?  Currently a lot of memory is wasted and pointless
> burden is put on the page allocator when using the RDMA transport on
> the server side.

You're talking about specifically:

1. svcrdma issues RDMA Read WRs from an svc_rqst thread context. It
   pulls the Read sink pages out of the svc_rqst's rq_pages[] array, and
   then svc_alloc_arg() refills the rq_pages[] array before the thread
   returns to the thread pool

2. When the RDMA Read completes, it is picked up by an svc_rqst thread.
   svcrdma frees the pages in the thread's rq_pages[] array, and
   replaces them with the Read's sink pages.

I've looked at this several times over the years. It's a tough problem
to balance against things like preventing a denial of service. For
example, an attempt was made to handle the RDMA Read synchronously in
the same thread that receives the RDMA Receive. Had to be reverted
because if the client is slow to furnish the Read payload, that ties
up the svc_rqst thread. That is a DoS vector.

One idea would be for NFSD to maintain a pool of these pages. But I'm
not convinced that we could invent anything that's less latent than the
generic bulk page allocator: release_pages() and alloc_bulk_pages().


-- 
Chuck Lever

