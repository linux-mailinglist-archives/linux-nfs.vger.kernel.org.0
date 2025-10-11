Return-Path: <linux-nfs+bounces-15145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD5BCED75
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 02:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2A53B7057
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 00:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078F29CE1;
	Sat, 11 Oct 2025 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Hgkqkwnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+hEARiI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB722BD11
	for <linux-nfs@vger.kernel.org>; Sat, 11 Oct 2025 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760144162; cv=none; b=Ui05TfPwxej3TCm5XWBza5qG+1Cd+MIkal76y1DGUNA9xvLMx4JEyGFtRqYN0rbWyxB/tx5CWj8D3IwBVGnbFnC3k+3oUmbYANwqSH6J98qwGadb3TUIWwnoNK0HPUBj9rZeWASatEnP1RGjy4PsUmB0+H6YpRQo0m+3G4dZdbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760144162; c=relaxed/simple;
	bh=ehM6ci6NnlKBVB+JUVhnS9JJWbi+v2HkOJ4opxeDHqA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UIlQU7iM6LRJou7kyGS0+IVv5tgsUfjQWjrznEoK8lyjQx/7UuaDbYLS8/71egb3yTvGF3VIniMfo7WqoRf6NhLdJb176wdr6+PGH0Gnv3FOjVHlfJ3Vao7Eta6p37UciMZCcxoSCsC2iLieVy69llFryqW1NbDsPQzBcqpg/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Hgkqkwnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+hEARiI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EE8FA1D0014F;
	Fri, 10 Oct 2025 20:55:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 20:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760144158; x=1760230558; bh=ToifpW+PsBEOtdjYo6ghXDAEzjGg0v7j8uO
	vagjWaGE=; b=Hgkqkwndw9xhNVqDEQa0vGDtGAxlLyilsNQ2jOju34HfyWtSQrr
	St/0Ydwqmzhx2yZvqa+xF11KiuSaIOVgiMucUAZKfCfhuaP6SvMy9kmUAJ1Bla96
	rNGtAIJCLzjif0MgnOnOtgxZaYamM1kqez6MpgEB1sobJqtUEsNZfSNBc3f6N1SJ
	2HYjc8SG2DvCg3KSuBb8uGm3pcQOCGbjCNVFPHk5lD/mF1PjFJRcKoqbT2LDhTbE
	Gcckkm/hCQdWynhN7iaLOoBVNsg/S18dY8McH9b5h0RBZWhl9+yxB4JGtU2Jxfr0
	ke8gUmaeQV1gkJ1p7VV3ouHGOjIuRiym4FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760144158; x=
	1760230558; bh=ToifpW+PsBEOtdjYo6ghXDAEzjGg0v7j8uOvagjWaGE=; b=v
	+hEARiIb0htyKoI+DnWM8a+Y6DaLmhnJ2fAvLAU7QMOlDXDBScgsVXJDFj1zK684
	KSRiEzcGI/6B3IRMy1Cqf7TEV75G3REOnjmpMKrzkOuvgIx6XG35DPItcRLuru/f
	aBGsWLF6UOpuw9f6d3Lp801renGXq5sVMQMd38wZvrBaKj312MO2yxqMAF/VFh18
	gCz+UON3F1UHobdm9YsRR5vxNgGE+BbhVp3rL/fbKLx4a4DHxCmkUAArCgvxe2N6
	CwTp/Mwi08syYGTf6f2HisoUQ1yCs/TXimCshlVaJropalBQ3SXexJpFjuF7D5VB
	L3nuc21GLuHp7tVe3BNig==
X-ME-Sender: <xms:HqvpaJZGHjq-a3IE_kEaXDgWW1zoeJtZZ5Oe1JNHM_yM2iYzY_3_Kw>
    <xme:HqvpaCrWZBeAhX5-e66Im5b-DVj4PzQ9mHsxMAQz0o2D3vMMV3i2E7jK-GGUQjKlj
    PTk2_4egphUCc3OOEfu6OAz8PRxf9CNyfY59SN2so04NE0jqzg>
X-ME-Received: <xmr:HqvpaOPHVFSzZJrE5V0nuPJ4a6Y69u1nbr8O0mS5N0XPBGpZpx0v099OGJnxw1wkPP55bVpSpap96iyIjn7XD3HxmCVpkmx6wE58ea3iVw56>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:HqvpaNp7osE7fcxCMtFbV-r2oQ-V016kJOGegudUATpf2xY8lRmLLw>
    <xmx:HqvpaDdsIe7wSDTHje2BJ2R4NBXtqfO1NZ_2f49ExA5IUovzN63s3A>
    <xmx:HqvpaDTddTIYO8HJKh8Y1fdCJPthhm49iyh9S7lE_moMtzt4_TKdJA>
    <xmx:HqvpaMZCtthJIApWtxKmvWqg-y2qX-5DXXZGn6bO1zaIAs0nUxrimQ>
    <xmx:HqvpaGXUofmwa4i-DHWoHkEXBfEduOfHkVFDhzttYS6pnXkcJoG8Tswt>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 20:55:56 -0400 (EDT)
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
In-reply-to: <c302bfe7-1503-45c6-8388-6c6f1cd1b5f4@oracle.com>
References: <20251007160413.4953-1-cel@kernel.org>,
 <20251007160413.4953-4-cel@kernel.org>,
 <98277504-3d4b-4aff-9810-1847e6bf4030@oracle.com>,
 <175987517335.1793333.17851849438303159693@noble.neil.brown.name>,
 <711bd35a-78b3-4309-9cb7-9e2c7a83a87e@oracle.com>,
 <175996099762.1793333.16836310191716279044@noble.neil.brown.name>,
 <468cdcfe-971b-4ed7-a7ef-b1d70117a579@oracle.com>,
 <176005255127.1793333.10926466897571153606@noble.neil.brown.name>,
 <c302bfe7-1503-45c6-8388-6c6f1cd1b5f4@oracle.com>
Date: Sat, 11 Oct 2025 11:55:49 +1100
Message-id: <176014414963.1793333.15458960142917474536@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 11 Oct 2025, Chuck Lever wrote:
> On 10/9/25 7:29 PM, NeilBrown wrote:
> > On Thu, 09 Oct 2025, Chuck Lever wrote:
> >> On 10/8/25 6:03 PM, NeilBrown wrote:
> >>> On Thu, 09 Oct 2025, Chuck Lever wrote:
> >>>> On 10/7/25 6:12 PM, NeilBrown wrote:
> >>>>> On Wed, 08 Oct 2025, Chuck Lever wrote:
> >>>>>> On 10/7/25 12:04 PM, Chuck Lever wrote:
> >>>>>>>  RFC 8881 Section 2.10.6.1.3 says:
> >>>>>>>
> >>>>>>>> On a per-request basis, the requester can choose to direct the
> >>>>>>>> replier to cache the reply to all operations after the first
> >>>>>>>> operation (SEQUENCE or CB_SEQUENCE) via the sa_cachethis or
> >>>>>>>> csa_cachethis fields of the arguments to SEQUENCE or CB_SEQUENCE.
> >>>>>>> RFC 8881 Section 2.10.6.4 further says:
> >>>>>>>
> >>>>>>>> If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
> >>>>>>>> cache a reply except if an error is returned by the SEQUENCE or
> >>>>>>>> CB_SEQUENCE operation (see Section 2.10.6.1.2).
> >>>>>>> This suggests to me that the spec authors do not expect an NFSv4.1
> >>>>>>> server implementation to ever cache the result of a SEQUENCE
> >>>>>>> operation (except perhaps as part of a successful multi-operation
> >>>>>>> COMPOUND).
> >>>>>>>
> >>>>>>> NFSD attempts to cache the result of solo SEQUENCE operations,
> >>>>>>> however. This is because the protocol does not permit servers to
> >>>>>>> respond to a SEQUENCE with NFS4ERR_RETRY_UNCACHED_REP. If the server
> >>>>>>> always caches solo SEQUENCE operations, then it never has occasion
> >>>>>>> to return that status code.
> >>>>>>>
> >>>>>>> However, clients use solo SEQUENCE to query the current status of a
> >>>>>>> session slot. A cached reply will return stale information to the
> >>>>>>> client, and could result in an infinite loop.
> >>>>>>
> >>>>>> The pynfs SEQ9f test is now failing with this change. This test:
> >>>>>>
> >>>>>> - Sends a CREATE_SESSION
> >>>>>> - Sends a solo SEQUENCE with sa_cachethis set
> >>>>>> - Sends the same operation without changing the slot sequence number
> >>>>>>
> >>>>>> The test expects the server's response to be NFS4_OK. NFSD now retur=
ns
> >>>>>> NFS4ERR_SEQ_FALSE_RETRY instead.
> >>>>>>
> >>>>>> It's possible the test is wrong, but how should it be fixed?
> >>>>>>
> >>>>>> Is it compliant for an NFSv4.1 server to ignore sa_cachethis for a
> >>>>>> COMPOUND containing a solo SEQUENCE?
> >>>>>>
> >>>>>> When reporting a retransmitted solo SEQUENCE, what is the correct st=
atus
> >>>>>> code?
> >>>>>
> >>>>> Interesting question....
> >>>>> To help with context: you wrote:
> >>>>>
> >>>>>    However, clients use solo SEQUENCE to query the current status of a
> >>>>>    session slot.  A cached reply will return stale information to the
> >>>>>    client, and could result in an infinite loop.
> >>>>>
> >>>>> Could you please expand on that?  What in the reply might be stale, a=
nd
> >>>>> how might that result in an infinite loop?
> >>>>>
> >>>>> Could a reply to a replayed singleton SEQUENCE simple always return t=
he
> >>>>> current info, rather than cached info?
> >>>>
> >>>> If a cached reply is returned to the client, the slot sequence number
> >>>> doesn't change, and neither do the SEQ4_STATUS flags.
> >>>
> >>> Why is that a problem?  And importantly: how can it result in an
> >>> infinite loop?
> >>
> >> My remark was "could result in an infinite loop" -- subjunctive, meaning
> >> we haven't seen that behavior in this specific case, but there is a
> >> risk, if the client has a bug, for example. I can drop that remark, if
> >> it vexes.
> >=20
> > I think dropping it would be best.
> >=20
> >>
> >> The actual issue at hand is that the client can set the server up for
> >> a memory overwrite. If CREATE_SESSION does not request a large enough
> >> ca_maxresponsesize_cached, but the server expects to be able to cache
> >> SEQUENCE operations anyway, a solo SEQUENCE will cause the server to
> >> write into a cache that does not exist.
> >=20
> > OK, this looks like an important issue.  Adding that to the commit
> > message would help.
> >=20
> >>
> >> Either NFSD needs to unconditionally reserve the slot cache space for
> >> solo SEQUENCE, if it intends to unconditionally cache those; or it
> >> shouldn't cache them at all.
> >>
> >> The language of the spec suggests that the authors did not expect
> >> servers to cache solo SEQUENCE operations. It states that sa_cachethis
> >> refers to caching COMPOUND operations /after/ the SEQUENCE operation.
> >>
> >>
> >>>> The only real recovery in this case is to destroy the session, which
> >>>> will remove the cached reply.
> >>>
> >>> What "case" that needs to be recovered from?
> >>
> >> When the session slot has become unusable because server and client have
> >> different ideas of what the slot sequence number is.
> >>
> >> The client and server might stop using a slot in that situation.
> >> Destroying the session is the only way to get rid of the slot entirely.
> >>
> >> But IMHO this is a rat hole.
> >=20
> > OK, I think I understand now.
> >=20
> > According to RFC 5661
> >=20
> >   The value of the sa_sequenceid argument relative to the cached
> >    sequence ID on the slot falls into one of three cases.
> >=20
> > of which the second case is
> >=20
> >    o  If sa_sequenceid and the cached sequence ID are the same, this is
> >       a retry, and the server replies with what is recorded in the reply
> >       cache.  The lease is possibly renewed as described below.
> >=20
> > So the server *must* cache the reply for the most recent SEQUENCE in
> > each slot.
> >=20
> > The language in that section seems to suggest the "cached sequence ID"
> > is stored in the slot's reply cache.
> > Our struct nfsd4_slot stores the cached sequence ID not as part of the
> > generic reply "sa_data[]" but as a dedicated field.  We could store the
> > rest of the SEQUENCE reply in dedicated fields and leave sa_data to
> > store the replies to ops 2 onwards.
> >=20
> > The discussion of ca_maxresponsesize_cached always takes about "if
> > sa_cachethis is set" it seems to apply only to those ops where that
> > is relevant - it isn't relevant for SEQUENCE.
> >=20
> > So I think I would be in favour of always having enough space to cache a
> > full SEQUENCE reply.  The decision of whether it goes in sa_data[] or in
> > dedicated fields depends on how clean the code looks.
>=20
> IIUC the protocol requirements are:
>=20
> + solo SEQUENCE that fails MUST NOT be cached. That is currently an NFSD
> bug, because it unconditionally caches solo SEQUENCE. I have a patch to
> be added to this series to address that.

Agreed.

>=20
> + solo SEQUENCE when sa_cachethis is false does not need to be cached,
> but the protocol does not allow REP_UNCACHED_RETRY. This is the only
> reason to cache a solo SEQUENCE reply. Note that the cached response to
> a solo SEQUENCE can be constructed from existing fields in the slot. But
> I can't see such reconstruction being clean, and it is certainly a
> heroic case (ie, not commonly used, if ever).

I disagree.  The text I quoted strongly implies that any SEQUENCE must be
cached so that it can be replayed on a resend.  This is not presented as
optional.
   "the server replies with what is recorded in the reply cache".

The code currently always constructs a new reply using the fields of
'seq' - the request.
This is probably wrong.
When nfsd4_sequence() doesn't detect a resend, it updates=20
   ->maxslots
   ->target_maxslots
   ->status_flags

When a replay is detected, those fields aren't updated so the client
just sees what it send.
The nfsd4_slot doesn't have explicit room to store these.  Maybe it should.

NeilBrown

>=20
> nfsd4_alloc_slot() sets the slot replay cache size to /zero/ when the
> client's ca_maxresponsesize_cached is smaller than ... I think just the
> size of a solo SEQUENCE. I thought that was the bug, originally, but
> then Tom suggested there's truly no reason to cache a solo SEQUENCE.
>=20
> So, we could go with:
>=20
> 0. Fix nfsd_is_solo_sequence (that's 2/4 in this series)
> 1. Fix NFSD to not cache failed solo SEQUENCE
> 2. Increase the minimum size of the slot's replay cache to fit a
> solo SEQUENCE
>=20
>=20
> --=20
> Chuck Lever
>=20


