Return-Path: <linux-nfs+bounces-16800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CBEC953DA
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Nov 2025 20:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A899F34285E
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Nov 2025 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B122BEC5A;
	Sun, 30 Nov 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbY4foRz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7D2BE625
	for <linux-nfs@vger.kernel.org>; Sun, 30 Nov 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764530775; cv=none; b=GVtC9UrEK4+3FjP66jUe76KMHkikvtzpp/jLdTSucPCa0Wyy8JXuClVbw9EtP678OufQmXdQbStl16B2FSRqc/0UP42a9i1Bj8pT2QTd+1d593/LWsjmuJj21108fO+b03TSXVFOAwHUdadp2FturwZ2O8ie3nFe6H81ngBlq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764530775; c=relaxed/simple;
	bh=vhCbmgJYORssY5WFDie2tmQiMCbWxZlOvHAMv0AMDVQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mbFwg0A87O4bTduAiRV4RNe6/IBA+tZRvcC5dTw/GRqmAK2KuChbSzFGHAEPM8yE6sx1Dt2phV9S6wDk0amDzxZfot2DikKjqPBvc2VnVbkFgLmZ1S4wLxtSVS01CN6peVFDVaet4rgDct6Bte/VD/CU7s/L5BYEU0kgY7fI1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbY4foRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130CDC116B1
	for <linux-nfs@vger.kernel.org>; Sun, 30 Nov 2025 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764530775;
	bh=vhCbmgJYORssY5WFDie2tmQiMCbWxZlOvHAMv0AMDVQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DbY4foRzV4wSlyRUEyhnjAIuII07nS2YeMoIXIIA65QJSM1B0qvfULQWhIbp3Xw0P
	 wsz2RpPo5KN++RA05jn31rD6oEMPPbeWrSJWdjvW61FQij3+T8xY8E2V7K9Owg6Y5K
	 lMiDi8FAVeYaXI4F1AsF6WnclWYm8H4swl5eAobHWolhOh7B3WobPw/Ss7KPB2apz1
	 h0RnShkgTGHlWY+hQO1v2DCnhcVUz7/Ro8niHWjCsrbJVf/RDKVdgdAOOu4/TvbqFd
	 LYAkiXJD/amjxwEQGh6qDnsRMSPLQvQiu4XYbvUwjGORWQ2+iC8jTMDre8YmWFTDGp
	 E4NkmyqCgbZNA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 15A4EF4006E;
	Sun, 30 Nov 2025 14:26:14 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 30 Nov 2025 14:26:14 -0500
X-ME-Sender: <xms:VZosaReKzwfq4SmKe2S1YCS4Dm0cvYWvvPsoHiebX7HPziNVID9Gvw>
    <xme:VZosaaBJMeRhpNUACooaXcR04W8lPRy455GgqIJvX2wt-zzpsglTkGNQbuE2oHkNT
    QaQh8GaAArDcTLZPupkFZ6CjbPxGFXRSh80qc-S_fILOe3gE4y9gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheehieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VZosadFb6JyZnbDxOsYsMv56MB7WFkL6_WmkFbtSaydNktlWss0u8w>
    <xmx:VZosaQLsOE2ygflbAaRxIYqPqzB4LVdZCm1HyteQ16Lx6LE_P7PL0A>
    <xmx:VZosaZl-XwBOvdSQMGUupfaYqa9MvpQ8h9PhlhSht_45mgqsmRIM1A>
    <xmx:VZosaQSrCKbnDmSUwznvbD5CXX5X9JA-P_oR223K1A_8PHDCrQFwHQ>
    <xmx:VposaTJ88SIL51VrUQaw_AJI6C1KDn7_Dh70xDE8AL723saEWxoIdJKh>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CC626780054; Sun, 30 Nov 2025 14:26:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AieIdV2Ewi8g
Date: Sun, 30 Nov 2025 14:25:53 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Anthony Iliopoulos" <ailiop@suse.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <543969a2-6bb4-4673-9688-a9a8b7e1681d@app.fastmail.com>
In-Reply-To: <84abc156-0839-4ba4-935f-783b51274301@app.fastmail.com>
References: <20251127175753.134132-1-ailiop@suse.com>
 <20251127175753.134132-2-ailiop@suse.com>
 <388da717-eb5a-4497-99f7-6a6f34405b58@app.fastmail.com>
 <aSoSJcYIXDEi3kvJ@technoir>
 <84abc156-0839-4ba4-935f-783b51274301@app.fastmail.com>
Subject: Re: [PATCH 1/2] nfsd: never defer requests during idmap lookup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Nov 29, 2025, at 11:54 AM, Chuck Lever wrote:
> On Fri, Nov 28, 2025, at 4:20 PM, Anthony Iliopoulos wrote:
>> On Fri, Nov 28, 2025 at 11:09:52AM -0500, Chuck Lever wrote:
>>> 
>>> 
>>> On Thu, Nov 27, 2025, at 12:57 PM, Anthony Iliopoulos wrote:
>>> > During v4 request compound arg decoding, some ops (e.g. SETATTR) can
>>> > trigger idmap lookup upcalls. When those upcall responses get delayed
>>> > beyond the allowed time limit, cache_check() will mark the request for
>>> > deferral and cause it to be dropped.
>>> 
>>> The RFCs mandate that NFSv4 servers MUST NOT drop requests. What
>>> nfsd_dispatch() does in your case is return RPC_GARBAGE_ARGS to
>>> the client, which is distinct behavior from "dropping" a request.
>>
>> It actually does drop the request, as pc_decode doesn't fail when this
>> happens.
>
> Anthony, thanks for clarifying. So, pc_decode returns true, but
> it has set op->status to something other than nfs_ok.
>
>
>> For example in one instance of this issue which occurs while decoding a
>> SETATTR op that has FATTR4_WORD1_OWNER/GROUP set, nfsd4_decode_setattr
>> returns with status set to nfserr_badowner. This is set in op->status in
>> nfsd4_decode_compound, which will stop decoding further ops, but stil
>> returns true.
>>
>> During nfsd4_decode_setattr, nfsd_map_name_to_[ug]id will end up calling
>> cache_check in idmap_lookup. What that does is basically:
>>
>> - issue the upcall
>> - wait for completion with a short timeout
>> - attempt to defer the request if the upcall hasn't updated the cache entry
>>   in the meantime
>>
>> That happens by calling svc_defer which will set RQ_DROPME on the
>> rqstp->rq_flags, causing nfsd_dispatch to return through the
>> out_update_drop, and in turn there will be no response sent out by
>> svc_process.
>>
>>> > Fix this by making sure that the RQ_USEDEFERRAL flag is always clear during
>>> > nfs4svc_decode_compoundargs(), since no v4 request should ever be deferred.
>>> 
>>> Help me understand how the upcall failure during XDR decoding is
>>> handled later? What server response is returned? Is it possible
>>> for the proc function to execute anyway with incorrect uid and
>>> gid values?
>>
>> Without the next patch in this series, if the request isn't deferred it
>> will send back the NFS4ERR_BADOWNER status, which the nfs client will
>> map to -EINVAL and return to userspace.
>>
>> With the next patch, it will return NFS4ERR_DELAY so that the client
>> will keep retrying the request until the id mapping completes.
>
> I agree that nfserr_delay is a much better server response than
> nfserr_badowner when idmapping experiences a temporary failure.
>
> Clearing USEDEFERRAL during pc_decode seems a bit expedient,
> though. Probably this is a good initial fix because it can be
> backported cleanly. But it's a brittle fix IMHO and leaves a
> lot of technical debt.
>
> [ Review action: I'm thinking of taking this fix because it can
> be applied to LTS kernels -- I see that the idmapper calls have
> been in the pc_decode path since day zero. But please add more
> of this nice detail to the patch description. ]
>
> In the longer term, one thing that might improve matters is to
> move all idmapping calls out of the pc_decode path. That would
> include both nfsd4_decode_fattr4 and nfsd4_decode_nfsace4.

After more analysis, I can see that the idmapping calls in the
NFSv4 operation decoders are the only risks here. Clearing
RQ_USEDEFERRAL seems like a good fix, and I will look into
moving the idmapping calls themselves sometime down the road.

I would ask for a few changes to your patches:

1. Clear RQ_USEDEFERRAL in nfs4svc_decode_compoundargs(), and
   precede the clear_bit() with a loud comment that explains
   why this is done. Something like:

        * NFSv4 operation decoders can invoke svc cache lookups
        * that trigger svc_defer() when RQ_USEDEFERRAL is set,
        * setting RQ_DROPME. This creates two problems:
        *
        * 1. Non-idempotency: Compounds make it too hard to avoid
        *    problems if a request is deferred and replayed.
        *
        * 2. Session slot leakage (NFSv4.1+): If RQ_DROPME is set
        *    during decode but SEQUENCE executes successfully, the
        *    session slot will be marked INUSE. The request is then
        *    dropped before encoding, so the slot is never released,
        *    rendering it permanently unusable by the client.

2. Remove subsequent set_bit(RQ_USEDEFERRAL) calls in NFSv4. There
   doesn't seem to be any reason to re-enable that bit again during
   NFSv4 COMPOUND processing. (Feel free to do your own analysis
   here and check me if I'm wrong).

3. Add full kdoc comments in front of nfsd_map_name_to_[ug]id()
   that note the deferral risk. Something like:

 * This function may be called during NFSv4 COMPOUND decoding while
 * processing SETATTR, CREATE, or OPEN operations that set owner or
 * ACL attributes. The idmap lookup below triggers an upcall that
 * invokes cache_check().
 *
 * The caller must ensure RQ_USEDEFERRAL is cleared before calling to
 * prevent cache_check() from setting RQ_DROPME via svc_defer(). If
 * RQ_DROPME is set during decode, NFSv4.1 session slots can be
 * orphaned. See nfs4svc_decode_compoundargs().

   Now, we might also put a test_bit() in here with a
   WARN_ON_ONCE, but that is probably overkill.


-- 
Chuck Lever

