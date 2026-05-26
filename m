Return-Path: <linux-nfs+bounces-21975-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPqJJ+y5FWroYwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21975-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:19:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A375D886C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88AE4302C761
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840B403E97;
	Tue, 26 May 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt+gpR3/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D934028DF;
	Tue, 26 May 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807537; cv=none; b=DaCMIBQRxZ490YsXmB59PR1b2OP84dHMUcxbPLIRd9M75r0F5pYE7TH/nPdjFhJ2NoFsMVnhbwHs5ZtJVoZDjLb9wHFrPnefCpeghFSiPyt+OtCdNHT049ec3NTQS7UGdWeSlZ9IMyeVLG2rkf57sHT+cuaCYMa7BQmjq3buYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807537; c=relaxed/simple;
	bh=feABfp32+2wbuy1/ktQJ1OMjTTsdjBJY/98hOfBCTUs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d2gIS+zyL0Do7WuesPFd/7xVs4L8mqfW+Y/3xviJEQZkwL6ZTgwd9O71Sbj5KQ9NqreqSjTlGoc/X+2vOogU2t6gfMcWC2Egeu7sZD+QfLXTmD1CWdJmWBgRUcWT60BgGM1EzCVVnTqv4RyuZr3jJrV8sFskTzvZd39ICFCQjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt+gpR3/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA311F00A3C;
	Tue, 26 May 2026 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807532;
	bh=KIYDRT3QzgwVn0RR98KUMD4+qSaqJm8Ya3I0WlRSI7I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Pt+gpR3/Foo76DEjbTnmsrAdFzTpnKQ9iun5BDmy8iqDWTg8yBMeI5c1f9lOL8cv2
	 hzRRBFZ5WVPwCBqH9rtudnc0Y/zj0khKa6qsdNDdR4wf3tfMkcpDDkq6K06epzPvXX
	 uBqBk5fI0+Y4WFWApc64lPY8I8Dm4+77CTuULSmqmySgKalG3COP395kwivLD6l2TE
	 8uSmrc9T9ff9pjj8LXlYirsSCAvSGxGDdKInMARHKubBuyiwaRENiOIPktx3myIm8M
	 KAQSxXUbB5oMekLAeanzCYiHP45VAlAhx07HvIsJQT0DdF37J8pSy6YdrxaNPxX3Na
	 rR4IIQp7YKKvQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6403DF4006B;
	Tue, 26 May 2026 10:58:51 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 26 May 2026 10:58:51 -0400
X-ME-Sender: <xms:K7UVanmdBSNEC920C3WHsZfANbZTChoOzYfHuG-RR9qL4sUjaUxdZw>
    <xme:K7UValqW-ekIVdmksX-_RY2eoktPom4UCcZxfbMNI8rxANkDO8tB8jp68jpa2Nj18
    V-kvx4mrahhhdh4WpUIhRRIOz4AeZi_KlwvTNeXcbKsnX9sUjJCxw>
X-ME-Proxy-Cause: dmFkZTEKyfd86x+E8bQXfNTwS9U/2NPaQ4E5J5yOXupfzdRi8vtt5d4KO4aA35eypqiWY9
    SLUaFYTm5+b5mCm8uZD6iqvMjNdqs40WYSKVfHcJwmv7WgeOk/AE5a/WEMTyQi//F18ITp
    s+84PBIMKfhtnCLzdV3OOINsj9uT6oll832LDBLpqNaoECaqnPDmxd0/mmY6vlcQyBLfIb
    ml0Cv7BPiwY2HMxvsrXiLqEwG10glJUACpGnQ0ogzMHCA53E1Fuh9eBqbnQcnPwaRYQ5yi
    lWRAW81yh5ETEBj8GoUbe1+2qQIVFp8iPT9j67DNEDFUU6ynXQSM5viqzM1OZOXpLPBQnJ
    wvaQNM6VX+34QCL5mjJwulknjVc8UYazl+2k2/yIe8hk9ZDCIKzeMsLWMU0m43/A0JZ9Oq
    R1GYJGH7UZlykecVR9KMegcfg04bd+PI+kGUB9Du2qJagOstl4dpv13o7DcDqWYk7o6PJs
    CaxKraxKI2C+DI3uNwHzIhPt8q4mNcK0NewKDyjKftWKgASK9Fjw71dDwH41vhx9rcyAgU
    pCv2zupuqnkFToOvtn6cng2sfsa4r3KsHadWDZvC2AQS3oRx2+fSiiqyg/zlXQ1FKoCsOi
    MwK/dFaUIiKK/umX0QQmemmyTwCUzeeD+iEF7onmRZAnm8TWmjGeYcFA39MA
X-ME-Proxy: <xmx:K7UVav2fG15M45B7DX8lLSYArOIUXVjqAg2wiZlp_E5ZgmOyyaQqRQ>
    <xmx:K7UVaugiXti9lA7tD5Xaq66ADVdvMQLzF3MkVxiFe0Vka7Dn_W5frg>
    <xmx:K7UVaglJWNpskDNWNJoqChWszJbx1omfFP2-ygkLdj-PANXS0XbZow>
    <xmx:K7UVasYVTePx99U7yIias2iZF5cdIDAW3z7vziu5jUL9F36YwmgRXw>
    <xmx:K7UVajFikENEuxJ0oiTjcJbHbTkeqNzb7a4dp3wB2lc_v9XSSmcoC0Lz>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3EAA0780077; Tue, 26 May 2026 10:58:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_Yfn3Pc6r8N
Date: Tue, 26 May 2026 10:58:31 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <f0c2c3ce-cb3b-4156-a2ad-6730e34c403f@app.fastmail.com>
In-Reply-To: 
 <20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v1-1-504a6a7fd9b4@kernel.org>
References: 
 <20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v1-1-504a6a7fd9b4@kernel.org>
Subject: Re: [PATCH] nfsd: don't free session slots that are still in use
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21975-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 57A375D886C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, May 26, 2026, at 10:22 AM, Jeff Layton wrote:
> nfsd4_sequence() can free the very slot it is currently processing.
> When the session shrinker has reduced se_target_maxslots below
> se_fchannel.maxreqs, the shrink path checks three conditions before
> calling free_session_slots():
>
>   1. se_target_maxslots < maxreqs  (shrink was advertised)
>   2. slot->sl_generation == se_slot_gen  (slot is up-to-date)
>   3. seq->maxslots <= se_target_maxslots  (client acknowledges)
>
> However, seq->slotid is never checked against se_target_maxslots.
> A client using a slot in the range [se_target_maxslots, maxreqs) can
> satisfy all three conditions: its slot has the current generation
> (set by a prior SEQUENCE), and it sends sa_highest_slotid <=
> se_target_maxslots to acknowledge the reduction.
>
> free_session_slots() then kfrees every slot at index >=
> se_target_maxslots, including the caller's own slot. The function
> continues to write sl_seqid, sl_flags, sl_generation, and stores the
> dangling pointer in cstate->slot. Later, nfsd4_store_cache_entry()
> copies up to maxresp_cached bytes of the compound reply into the freed
> sl_data[] array, corrupting whatever slab object now occupies that
> address.
>
> This is a remotely triggerable heap use-after-free from any
> authenticated NFSv4.1+ client with an established session, requiring
> only that the kernel memory shrinker has run against nfsd session slots
> (a normal occurrence under memory pressure).
>
> Fix this by adding a check that the current request's slotid is below
> the shrink boundary before allowing the slot reduction to proceed.
>
> Fixes: 8fb77d12c76e ("nfsd: add support for freeing unused session-DRC slots")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d5cbf626ab9b..f90ad8281a95 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4848,7 +4848,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
> 
>  	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
>  	    slot->sl_generation == session->se_slot_gen &&
> -	    seq->maxslots <= session->se_target_maxslots)
> +	    seq->maxslots <= session->se_target_maxslots &&
> +	    seq->slotid < session->se_target_maxslots)
>  		/* Client acknowledged our reduce maxreqs */
>  		free_session_slots(session, session->se_target_maxslots);
> 

The patch guards only against the caller freeing its own slot. It
doesn't guard against freeing a different slot that is concurrently
in use by another thread. Perhaps free_session_slots() should skip
any slot with NFSD4_SLOT_INUSE set. Or the shrink could be deferred
until no high-numbered slots are in use?


-- 
Chuck Lever

