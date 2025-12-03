Return-Path: <linux-nfs+bounces-16863-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CEC9D93B
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 03:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15B163497D3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7BC139D;
	Wed,  3 Dec 2025 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="O2ABt2wQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKHLcumH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C836D507
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764729110; cv=none; b=GflI28B+qW7HkbxuuI2XOD4/f2hwEbasPH0cdQYzv1pu4YQDwyf4hByBA0bD2nyaPwvoHRvYzvsWzIPN8gLcbFw5lK0WcAPA2ClXeHGNz9cNJrGpdrTIs7D583gu8XX61nEcXOx1r757cqlxYRLAxSJttiO3QhxPioezFYu2tYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764729110; c=relaxed/simple;
	bh=AF9hJAWSkJtku1LssoQ7+2jwyvVvL+qLihlK3OKLa6I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=H6FpLwppWJ9VEO6/VKBQKGL3m1N8+AUX4NnFjYHfN+L9HSR3ItXZmTkHY1IGIZ8JAv5xShki3CmvbgH68Mj3dtf6xjLct87MZfE5ypNers/V2RROlBLk3jM7KOmxvsMBlolzpfexNLYA38wfhgfdgGpLYMG2fkOy5eDRdu9kxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=O2ABt2wQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKHLcumH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 70690EC01A8;
	Tue,  2 Dec 2025 21:31:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 21:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764729106; x=1764815506; bh=Pyi89XKTTeRjlPsax/w2W+j/+wzIZWCvfs7
	quIUtzVU=; b=O2ABt2wQ0IwwD523YcQfLSC7zefwBfW/XfG6KTQXrcnftCt8IDJ
	5+jaO41nfn6U2OcTW3GEnaTSKgDsYnTwWrlC6r47kT/SQHiOfh1XkSfaDYUS6Tep
	qmjZjpMO4Z///6SpuP8hgt7U7YvKeeU9nwcrSbthXPuzumIwFDBkZ9aht5jDqjZN
	xb9tnvsBgrbZ52nSo7HTLMhS/Nmo6J4qXcdsjR6nP4k7aYYKIbz4Hnz+AJjxTtZU
	TbVpe4waqkqNDJC1nG45vlHaijNilgo59URK6ZIWJ8944yK9VLW9CA2GOePfGxbB
	qxJmztMzoPqRiZPytmlC6CFF33kDf6siyag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764729106; x=
	1764815506; bh=Pyi89XKTTeRjlPsax/w2W+j/+wzIZWCvfs7quIUtzVU=; b=h
	KHLcumHL8ctse2mNwkGrdlHKBWsZkzEAijTJhs68vSEfLxTbqXbi2Ze+/4jJ03fW
	duhfVFkm78dsXfXlnkjgj1Wb1RcEy+npZf2DkMVurxZFJRlmtAGgS/HAxhF3JDnH
	h1V1fUNXHhd9H8Ev/kGZaLYInSpj0MINCCl88ARLxaMpFomxiYoLf78YE8OxCstU
	d6OlTCP92hRCMjmkcQvVXngC2bCwPF2i+zEYOBithloyW+A1XzSEiSV2bw1om1Wd
	BSCGwLZ2tz6kHfBu4aRUviBtkTN4gNlEPizBIyDC0DMmSrr8ajdk7KX+QIYDYngQ
	Ht9v1UUTnQMTBf2MzA3nw==
X-ME-Sender: <xms:EaEvafsFBelmx3e0sVyHQrCapFQDCrSGBcF_McJ9vC4z8-c_1HaKYg>
    <xme:EaEvaSsSteY1rba2AxvIgoSvb9W_IyE08EC8T9seD0tprBxBGV8EzfHfNQUweNXz4
    hrVDTWid5MompVnPwpPrzbCIop0RWMaJ73nay52LA9T-k4mnQ>
X-ME-Received: <xmr:EaEvaVA6U97TKxIucsAak4G-GcYnbXFAQ6RwPioZhwsDzO0L8RcdRwcNJbeXa4pSkywg_P0GmqsmkY8jYsoXp_S3pnuJ29TPD0AhgUauiCc7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    eptgfgggfhvfevufgjfhffkfhrsehtkeertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepvd
    fhgfehkeekiedtleefhefhkeevvdegfffhgfduffeiveelffehlefhfeehveetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrd
    gtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EaEvaUMiQyDDKQeA3UKs3VAZdqDzvxCyDmGzzv6It2u4-UH6o2slMA>
    <xmx:EaEvaeyc1gT-AZz2WOqD322AmL17oWLM5QZ6NqkDk8LuqpMGVWkY3A>
    <xmx:EaEvaUU4OoQBIi23iogzsnWMbg5gTmpdldwil2Whxdlnl3tyPGkQ7A>
    <xmx:EaEvaQNPzsQFnNbcGC0Tc_BHi3x9dEGsBeOmdadnhdifqOi-2CJgjg>
    <xmx:EqEvaaa7c9omS1H5qG_Zdn2jdsFA3DfoLLV0P7mRlR8LKooV6v0pHrxn>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 21:31:43 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/2] nfsd: prevent write delegations when client has
 existing opens
In-reply-to: <dc25626e-fae0-401b-93ed-1c4fdf34186c@app.fastmail.com>
References: <20251202224208.4449-1-cel@kernel.org>,
 <176471811359.16766.18131279195615642514@noble.neil.brown.name>,
 <dc25626e-fae0-401b-93ed-1c4fdf34186c@app.fastmail.com>
Date: Wed, 03 Dec 2025 13:31:39 +1100
Message-id: <176472909957.16766.8691035364646019081@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 03 Dec 2025, Chuck Lever wrote:
> 
> On Tue, Dec 2, 2025, at 6:28 PM, NeilBrown wrote:
> > On Wed, 03 Dec 2025, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> When a client holds an existing OPEN stateid for a file and then
> >> requests a new OPEN that could receive a write delegation, the
> >> server must not grant that delegation. A write delegation promises
> >> the client it can handle "all opens" locally, but this promise is
> >> violated when the server is already tracking open state for that
> >> same client.
> >
> > Can you please spell out how the promise is violated?
> > Where RFC 8881, section 10.4 says
> >
> >    An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
> >    own, all opens. 
> >
> > I interpret that to mean that all open *requests* from the application can
> > now be handled without reference to the server.
> > I don't think that "all opens" can reasonably refer to "all existing or
> > future open state for the file".  Is that how you interpret it?
> 
> It is: as long as a client holds a write delegation stateid, that’s a
> promise that the server will inform that client when any other client
> wants to open that file. In other words, an NFS server can’t offer a
> write delegation to a client if there is another OPEN on that file.

Agreed: "other" client and "another" OPEN.

> 
> The issue here is about an OPEN that occurred in the past and is still
> active, not a future OPEN. NFSD was checking for OPENs that other
> clients had for a file before offering a write delegation, but it does not
> currently check if the /requesting client/ itself has an OPEN stateid for
> that file.
> 

I don't see a problem with offering a write delegation when the client
previously had the same file open.
Note that a client only ever has one stateid for any given file.  If it
opens the same file again, it will get the same stateid - with seqid
incremented.  If it closes the stateid, then it will not have that file
open at all any more.

If the client has the file open for READ, then opens again for WRITE,
then it does not get "another" open, it gets "the same" open, but with
different access.  When the client hold a write delegation, then it can
be sure there is only one open stateid for that file - the one that it
holds (it cannot hold two for the same file).

> The scenario I observed is that the requesting client held an OPEN
> for SHARED_ACCESS_READ on the file. The code in
> nfsd4_add_rdaccess_to_wrdeleg() assumes that if NFSD is about
> to set up a write delegation, the pointer in fi_fds[O_RDONLY] is NULL.
> That assumption isn’t true if that client still holds the S_A_R OPEN
> state id, and fi_fds[O_RDONLY] for that file then gets overwritten and
> the nfsd_file it previously referenced is orphaned.

I agree that the current code is flawed.  It needs to allow for the
possibility that the client already had the file open.  I just don't see
the justification for withholding a delegation when an open is upgraded
from read-only to read-write.

If the client already holds a READ delegation, then I see that there
might be a problem.  I don't think there *should* be a problem, but I
cannot see in the RFC how it would be handled.  Would the existing
delegation get upgraded the same way that the OPEN stateid is upgraded? 
Or would a new delegation be issued?  The RFC isn't clear so I don't
think it can happen (safely).

I note that section 10.4 says:

    The following is a typical set of conditions that servers might use
    in deciding whether an OPEN should be delegated: 
     ....
    - There must be no current OPEN conflicting with the requested delegation.

That text seems advisory rather than normative.  Does an OPEN from the
same client conflict with a delegation?  Maybe it depends on your
perspective.

I also note 18.16.3 says:

     If another client has a delegation of the file being opened that
     conflicts with open being done (...), the delegation(s) MUST be
     recalled,

So if the SAME client has a delegation - it doesn't need to be recalled?

and
       In the case of an OPEN_DELEGATE_WRITE delegation, any open by a
       different client will conflict,

Again "different client" - any open by the same client, it would seem,
does not conflict.

Thanks,
NeilBrown

