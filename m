Return-Path: <linux-nfs+bounces-15114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66A5BCB323
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 01:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF894275FB
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6952882DF;
	Thu,  9 Oct 2025 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="qsaQOCYy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+nHI23V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127032882CC
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052561; cv=none; b=phBOxU/wiltNzH3bZhBe8yg3bx/hfOlaqeFXo4/i/A90XuYFvLba2S8J/o7gPSMpNnPic0dp7a/W4+yBkmYIdd6pE0p+oBUWVLEsec73VkOkzXYMjHF33zXjbOSQ/Fa24hPjQHS72TZBLLdG+pFuzNbgmKl2sn5uih6n0JmIFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052561; c=relaxed/simple;
	bh=jU2E7IHrDkc6eqpEggxmCU1pJ7Bhfz+yw8AXhDKK1/M=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jvJvQdoR4A7CRoCk4GZAOoyt86JD2ifwa5O+ybCIXTFvJMAqQ0h68SjkHvR+Q4ROrdpIMwExI/rOELpzGU6N0usbxwhOWXrDkTOiMnZewWLfdjW8GUXz20Tc/AdloNFHFkMAVyedoEVhK++bdC0zRItzud/P2XlqJjmLwCXjW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=qsaQOCYy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+nHI23V; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DE21EC0032;
	Thu,  9 Oct 2025 19:29:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 19:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760052558; x=1760138958; bh=FjXI3h62vb/pboC7S3h3S1Cf+k9EZnoDf5n
	iQ7Bj9oY=; b=qsaQOCYyvXfWE1hy+w2Dh1gO/syPYR80O5WMF6eFdcaEIQ1bp95
	2uRLIIt9fXPAXJHMebo1+0wYY1UAy84qDIvidlhhM2xHDnycAYoa/VeLGxQlRaVN
	qRni5k+RQYveEqovXxszDeKNyIPdRHv+4FA5EdTBbkW19a+1AbNmieVHQQ1V9pry
	E4MN37WARnokZQ1GIjcvqactAfia8xPToUa54ZyB0qaKq8XFDWddIDOUf+Qo1xBg
	xeOp0DBBaW9xggtHyTc9oNZx4tJ5K1/rZCfqhPT79YjzwsQaaFuzMn8J8UyMErxK
	1QlaQo6fbP7S9SD8KC7+pq594ilPEMXpgog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760052558; x=
	1760138958; bh=FjXI3h62vb/pboC7S3h3S1Cf+k9EZnoDf5niQ7Bj9oY=; b=o
	+nHI23VBaqSfgU7vBakNea2YEVgUkYhSGS26DBKKFKkg+bqRfR3OzDG5THcVhIOo
	ogdM/z19YULgYqg42+lbdOh7njfuinCFV5stfHCcfVRwGOm1aJQSxb/OmTIzA+qo
	n5Xs1vZRYOR3Js1zSllNjh2rnZLhqACIIJaiLcGhBM2nY0iMlsaoCj3AhUdHIV5S
	Ox0e5VC/JL4LJcY2p7T2o9ntgLQVFhzGqs6vIry2z+0aTy+hYINvrERa5eKwO8Dw
	3otwPZsfRxSymSgKIRglHSPAKTv3iGLhvamCmnTPlisfLwL3yUeUtHLIBC/wxPTS
	kNkhHsNf2QnIWJ/7ERzNQ==
X-ME-Sender: <xms:TUXoaD0nkT1NjE7zC5s89FlEBkGz2Sk8C1iJlnZesAovgzO7bIdJgA>
    <xme:TUXoaEWHGLHCtT-5go4xdeNG-FAzIWZvVGzgnUI9lXWv-a6V8ZL5jYC5YTbUsYmth
    HMbPvjiBJCMSh8mlewcXbcjFM1J8ZVvFkq81KXEVHH5CpozYwY>
X-ME-Received: <xmr:TUXoaGJy2eVlCjd-wLr4gGX8lFgIxMRApArA2J55knEsByjOAYk5eLwyTD38U8nr8DgeU0H18toxE66gEpfF5re7KTVUjFLJ0TnOWj17-Q3D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TUXoaO0tYTeIdklFiSETcRuJKoLzZGTr4DJEH3epQeaUacY_6NhuKg>
    <xmx:TUXoaE5Q1AfN99N1ynPeTH3AkMMXW2JFBGKPNDsWWPJNvmZaqCbDaw>
    <xmx:TUXoaP-kwRPUg7BNTM0d-D639lkSkdh3v-Tw3j7a2lVSo2O16lqGxQ>
    <xmx:TUXoaDW2nhR7C4PlcP9GKA1XQQOgvtaM_usuI68rrPnyeKpBfvyfTw>
    <xmx:TkXoaEDVeJ7ImKOkJyV24pmqBzJWlMR4E6Px7e3iJj37ulDu8QeO0OqB>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 19:29:15 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] NFSD: Do not cache solo SEQUENCE operations
In-reply-to: <468cdcfe-971b-4ed7-a7ef-b1d70117a579@oracle.com>
References: <20251007160413.4953-1-cel@kernel.org>,
 <20251007160413.4953-4-cel@kernel.org>,
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>,
 <175987517335.1793333.17851849438303159693@noble.neil.brown.name>,
 <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>,
 <175996099762.1793333.16836310191716279044@noble.neil.brown.name>,
 <468cdcfe-971b-4ed7-a7ef-b1d70117a579@oracle.com>
Date: Fri, 10 Oct 2025 10:29:11 +1100
Message-id: <176005255127.1793333.10926466897571153606@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 09 Oct 2025, Chuck Lever wrote:
> On 10/8/25 6:03 PM, NeilBrown wrote:
> > On Thu, 09 Oct 2025, Chuck Lever wrote:
> >> On 10/7/25 6:12 PM, NeilBrown wrote:
> >>> On Wed, 08 Oct 2025, Chuck Lever wrote:
> >>>> On 10/7/25 12:04 PM, Chuck Lever wrote:
> >>>>>  RFC 8881 Section 2.10.6.1.3 says:
> >>>>>
> >>>>>> On a per-request basis, the requester can choose to direct the
> >>>>>> replier to cache the reply to all operations after the first
> >>>>>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
> >>>>>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
> >>>>> RFC 8881 Section 2.10.6.4 further says:
> >>>>>
> >>>>>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
> >>>>>> cache a reply except if an error is returned by the SEQUENCE or
> >>>>>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
> >>>>> This suggests to me that the spec authors do not expect an NFSv4.1
> >>>>> server implementation to ever cache the result of a SEQUENCE
> >>>>> operation (except perhaps as part of a successful multi-operation
> >>>>> COMPOUND).
> >>>>>
> >>>>> NFSD attempts to cache the result of solo SEQUENCE operations,
> >>>>> however. This is because the protocol does not permit servers to
> >>>>> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
> >>>>> always caches solo SEQUENCE operations, then it never has occasion
> >>>>> to return that status code.
> >>>>>
> >>>>> However, clients use solo SEQUENCE to query the current status of a
> >>>>> session slot. A cached reply will return stale information to the
> >>>>> client, and could result in an infinite loop.
> >>>>
> >>>> The pynfs SEQ9f test is now failing with this change. This test:
> >>>>
> >>>> - Sends a CREATE_SESSION
> >>>> - Sends a solo SEQUENCE with sa_cachethis set
> >>>> - Sends the same operation without changing the slot sequence number
> >>>>
> >>>> The test expects the server's response to be NFS4_OK. NFSD now returns
> >>>> NFS4ERR_SEQ_FALSE_RETRY instead.
> >>>>
> >>>> It's possible the test is wrong, but how should it be fixed?
> >>>>
> >>>> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
> >>>> COMPOUND containing a solo SEQUENCE?
> >>>>
> >>>> When reporting a retransmitted solo SEQUENCE, what is the correct stat=
us
> >>>> code?
> >>>
> >>> Interesting question....
> >>> To help with context: you wrote:
> >>>
> >>>    However, clients use solo SEQUENCE to query the current status of a
> >>>    session slot.  A cached reply will return stale information to the
> >>>    client, and could result in an infinite loop.
> >>>
> >>> Could you please expand on that?  What in the reply might be stale, and
> >>> how might that result in an infinite loop?
> >>>
> >>> Could a reply to a replayed singleton SEQUENCE simple always return the
> >>> current info, rather than cached info?
> >>
> >> If a cached reply is returned to the client, the slot sequence number
> >> doesn't change, and neither do the SEQ4_STATUS flags.
> >=20
> > Why is that a problem?  And importantly: how can it result in an
> > infinite loop?
>=20
> My remark was "could result in an infinite loop" -- subjunctive, meaning
> we haven't seen that behavior in this specific case, but there is a
> risk, if the client has a bug, for example. I can drop that remark, if
> it vexes.

I think dropping it would be best.

>=20
> The actual issue at hand is that the client can set the server up for
> a memory overwrite. If CREATE_SESSION does not request a large enough
> ca_maxresponsesize_cached, but the server expects to be able to cache
> SEQUENCE operations anyway, a solo SEQUENCE will cause the server to
> write into a cache that does not exist.

OK, this looks like an important issue.  Adding that to the commit
message would help.

>=20
> Either NFSD needs to unconditionally reserve the slot cache space for
> solo SEQUENCE, if it intends to unconditionally cache those; or it
> shouldn't cache them at all.
>=20
> The language of the spec suggests that the authors did not expect
> servers to cache solo SEQUENCE operations. It states that sa_cachethis
> refers to caching COMPOUND operations /after/ the SEQUENCE operation.
>=20
>=20
> >> The only real recovery in this case is to destroy the session, which
> >> will remove the cached reply.
> >=20
> > What "case" that needs to be recovered from?
>=20
> When the session slot has become unusable because server and client have
> different ideas of what the slot sequence number is.
>=20
> The client and server might stop using a slot in that situation.
> Destroying the session is the only way to get rid of the slot entirely.
>=20
> But IMHO this is a rat hole.

OK, I think I understand now.

According to RFC 5661

  The value of the sa_sequenceid argument relative to the cached
   sequence ID on the slot falls into one of three cases.

of which the second case is

   o  If sa_sequenceid and the cached sequence ID are the same, this is
      a retry, and the server replies with what is recorded in the reply
      cache.  The lease is possibly renewed as described below.

So the server *must* cache the reply for the most recent SEQUENCE in
each slot.

The language in that section seems to suggest the "cached sequence ID"
is stored in the slot's reply cache.
Our struct nfsd4_slot stores the cached sequence ID not as part of the
generic reply "sa_data[]" but as a dedicated field.  We could store the
rest of the SEQUENCE reply in dedicated fields and leave sa_data to
store the replies to ops 2 onwards.

The discussion of ca_maxresponsesize_cached always takes about "if
sa_cachethis is set" it seems to apply only to those ops where that
is relevant - it isn't relevant for SEQUENCE.

So I think I would be in favour of always having enough space to cache a
full SEQUENCE reply.  The decision of whether it goes in sa_data[] or in
dedicated fields depends on how clean the code looks.

Thanks,
NeilBrown



>=20
>=20
> >> We've determined that the Linux NFS client never asserts sa_cachethis
> >> when sending a solo SEQUENCE, so the questions above might be academic.
> >=20
> > It would still be nice to have clear agreement on what the spec allows
> > and expects.
> RFC 8881 Section 2.10.6 does not provide any guidance about how a server
> MUST respond either when sa_cachethis is asserted on a solo SEQUENCE,
> nor does it say explicitly how to respond when a client replays such a
> SEQUENCE operation.
>=20
> I can ask on nfsv4@ietf.org, but I suspect we will not get a consensus
> response there either.
>=20
>=20
> --=20
> Chuck Lever
>=20


