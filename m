Return-Path: <linux-nfs+bounces-16797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC90C94485
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC1F3A5028
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2121DF963;
	Sat, 29 Nov 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFP8aK42"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE411D86FF
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435282; cv=none; b=AcRHuzr/nbHJxx8KAL+mecgudR7Q98+SKCXSlF65nlQpro4OlnlnED19cQRQkWkEC9g3q0zwLDLM52US5RXCakH/xun4btw1Kn1/C/0ARy+FOFGF5UaYBLlbuvXbUJkpr86EjPivNZKxNz4nbHzJX0t+FP4dI23xVdIiljS7M/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435282; c=relaxed/simple;
	bh=ZgeEiGdUzNBEU6VP/to7bHqli/aJoNIV3NvbJb1pUnA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zd6B7nZb6TQGGQnnGufNmVMjYjmvQjHEC3fWvlGQ8ku1O1RT/rQIPkSXX+U9yfYZwEgfHk05A8VMhLvt5EqYmzeHR2twNkCtkoqXvRTBjJ8QKn6rnx4UeoxFN+xV9xnf5jm5gihkG262mB5Af6ogVpbeLOLXfpkveP4O6djjNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFP8aK42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E92C116C6;
	Sat, 29 Nov 2025 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764435281;
	bh=ZgeEiGdUzNBEU6VP/to7bHqli/aJoNIV3NvbJb1pUnA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YFP8aK42xAsx615Nz8JmQtNw+T7hz09Eq3EL+vVrWI3YLjFkLRJLYYTGQpPupH1uy
	 Cc2BT/m8TDF3jRm7wdL7vHaMlx9erphmP/DuQGuHHWmlsPAF2cgefKzMhTGqndMVnI
	 wQoQozwGWt80enRfmyUFuvYjIOpbDQlvkMGOumydRDMQhnSfUtol7sGUypwZsRVmzc
	 nZeMw14QgX/AuEKKXAyYrbcMJLpOTil6NKYSPyPNtUvgRt5IOR5bHudNcMlTt1Wboq
	 x1KczAAcTSG4Lx7U9O7rXz2z19yCGQqKWjd4AtaIoIBDTewzX9tYN4Quxhl1BiSFII
	 K6z2+NEyeYK5Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3CAF6F40080;
	Sat, 29 Nov 2025 11:54:40 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 29 Nov 2025 11:54:40 -0500
X-ME-Sender: <xms:UCUraSKKC8jVvTIj8EMhCx74SQQ-b7WWD10vITMqY59UsJK5_CwpEw>
    <xme:UCUraU8w6zmVd5JxPapsVnh_bs0DbZCabRbbtYNktbPrtwZQfgL9ep_6nm0fXpTsn
    YnN1DORHXyPF-x-YYlbX04ApmSxmAfvDhijMiRHBXpmWMIcolaTBkYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkh
    drlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghilhhiohhpsehsuhhs
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:UCUraawKMrw73_8u27RrHqTsBV_iFQOvyPCkzSUKwDQfMUfrV9QbTQ>
    <xmx:UCUraUEhle651tMqx2gJSClgu0n1FB1C0pDb5Sahl0xjAV48s4T1dQ>
    <xmx:UCUraWzEjETcVyEcZs1P2iWuXrKn6eLXlznxSsBUrPRaiF0TawlGfQ>
    <xmx:UCUradv3jrL6Bl9Y_fibdmsLBidw4dALY0x5CGASHnjComA8-0viIA>
    <xmx:UCUrab1dXWmF7zhZwLHmrIPLpBCz6lNr47h5RY3R3VwG19ArMeSJJZD0>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E367D780054; Sat, 29 Nov 2025 11:54:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AieIdV2Ewi8g
Date: Sat, 29 Nov 2025 11:54:15 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Anthony Iliopoulos" <ailiop@suse.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <84abc156-0839-4ba4-935f-783b51274301@app.fastmail.com>
In-Reply-To: <aSoSJcYIXDEi3kvJ@technoir>
References: <20251127175753.134132-1-ailiop@suse.com>
 <20251127175753.134132-2-ailiop@suse.com>
 <388da717-eb5a-4497-99f7-6a6f34405b58@app.fastmail.com>
 <aSoSJcYIXDEi3kvJ@technoir>
Subject: Re: [PATCH 1/2] nfsd: never defer requests during idmap lookup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Nov 28, 2025, at 4:20 PM, Anthony Iliopoulos wrote:
> On Fri, Nov 28, 2025 at 11:09:52AM -0500, Chuck Lever wrote:
>> 
>> 
>> On Thu, Nov 27, 2025, at 12:57 PM, Anthony Iliopoulos wrote:
>> > During v4 request compound arg decoding, some ops (e.g. SETATTR) can
>> > trigger idmap lookup upcalls. When those upcall responses get delayed
>> > beyond the allowed time limit, cache_check() will mark the request for
>> > deferral and cause it to be dropped.
>> 
>> The RFCs mandate that NFSv4 servers MUST NOT drop requests. What
>> nfsd_dispatch() does in your case is return RPC_GARBAGE_ARGS to
>> the client, which is distinct behavior from "dropping" a request.
>
> It actually does drop the request, as pc_decode doesn't fail when this
> happens.

Anthony, thanks for clarifying. So, pc_decode returns true, but
it has set op->status to something other than nfs_ok.


> For example in one instance of this issue which occurs while decoding a
> SETATTR op that has FATTR4_WORD1_OWNER/GROUP set, nfsd4_decode_setattr
> returns with status set to nfserr_badowner. This is set in op->status in
> nfsd4_decode_compound, which will stop decoding further ops, but stil
> returns true.
>
> During nfsd4_decode_setattr, nfsd_map_name_to_[ug]id will end up calling
> cache_check in idmap_lookup. What that does is basically:
>
> - issue the upcall
> - wait for completion with a short timeout
> - attempt to defer the request if the upcall hasn't updated the cache entry
>   in the meantime
>
> That happens by calling svc_defer which will set RQ_DROPME on the
> rqstp->rq_flags, causing nfsd_dispatch to return through the
> out_update_drop, and in turn there will be no response sent out by
> svc_process.
>
>> > Fix this by making sure that the RQ_USEDEFERRAL flag is always clear during
>> > nfs4svc_decode_compoundargs(), since no v4 request should ever be deferred.
>> 
>> Help me understand how the upcall failure during XDR decoding is
>> handled later? What server response is returned? Is it possible
>> for the proc function to execute anyway with incorrect uid and
>> gid values?
>
> Without the next patch in this series, if the request isn't deferred it
> will send back the NFS4ERR_BADOWNER status, which the nfs client will
> map to -EINVAL and return to userspace.
>
> With the next patch, it will return NFS4ERR_DELAY so that the client
> will keep retrying the request until the id mapping completes.

I agree that nfserr_delay is a much better server response than
nfserr_badowner when idmapping experiences a temporary failure.

Clearing USEDEFERRAL during pc_decode seems a bit expedient,
though. Probably this is a good initial fix because it can be
backported cleanly. But it's a brittle fix IMHO and leaves a
lot of technical debt.

[ Review action: I'm thinking of taking this fix because it can
be applied to LTS kernels -- I see that the idmapper calls have
been in the pc_decode path since day zero. But please add more
of this nice detail to the patch description. ]

In the longer term, one thing that might improve matters is to
move all idmapping calls out of the pc_decode path. That would
include both nfsd4_decode_fattr4 and nfsd4_decode_nfsace4.


> In either case, even when the request is being dropped, the proc
> function is never executed. While nfsd_dispatch will proceed to call the
> pc_func, nfsd4_proc_compound checks for the op->status which was set in
> the decoding stage, and jumps to nfsd4_encode_operation without calling
> the op_func.

OK, but how does that improve the situation with the in-use
session slot? Are there other cases where COMPOUND decoding
sets a non-nfs_ok status and leaves an in-use slot?

This is what worries me in the longer run.


> In the particular instance of the SETATTR op, the encoder
> will encode an empty attrsset bitmap to indicate the inability to set
> any attributes.


-- 
Chuck Lever

