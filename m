Return-Path: <linux-nfs+bounces-15721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C863DC12A00
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 03:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F5F5E2A13
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2286353;
	Tue, 28 Oct 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eNCvq00U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejPrPfTk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA7F50F
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617064; cv=none; b=tg/4E4SyzZ1WE6EI7ujeixVmMCGYg5NS8CVmOZFNq7tYOGAwmn4hoSQWTrPvuvDQQx3EfBR+aitdkRltECOK0XZbHcR0CGr/EL0mF6U3O/vb7ch2zqFdsmsfJKEbikKgZHzwsMMc4wWPVFTGGZin1NdeLBkxdOnJuujUMujnOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617064; c=relaxed/simple;
	bh=eTjiM3JkgjcA1pKTXJ888RYwrhXgtDGryfToNfVJf+o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fdJDAfxlyDJjTTj/4XXGOrmm/dYkdTl+vzF5ex8u+iu4XpBE79RImOkc3WRWFstnCZcuEgWZTIRvxfhlsBtuZ4Z8gnw+2mQVGcGv0b1lfnf+HlEXdsCoBFdwiM5Q74Y3iXvjVuDtc3Qd4oUkiY2wfxvmwb5AKwf2nfgRQp18IMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eNCvq00U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejPrPfTk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 18BE6EC0452;
	Mon, 27 Oct 2025 22:04:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 27 Oct 2025 22:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761617062; x=1761703462; bh=vZGcLkgSv40WTUnYjDPpe1fvUibiSYnN6DE
	OAJpqXMc=; b=eNCvq00UPLPutWInIuASWnnH+M52ukl5AFP/ZncT9LE1tn2VEnb
	bkiNJ5jbSbwkp3HDB+FXLkOU6Xnj5a2xKwcfQQBuUb6mH4XScFyAkZGVInl+fJoJ
	TTY6uyY7WixMlwX4I9/mdGHyZlfjlUJh7pztUHbUrOAEMksR0/QVIo4MfuR26vO5
	zCIpL23DgUbxVasjV54pK9QVBkhsi7jsEsSP2KynXY74TD0D/WIp+EJwJTA929+T
	zr1Y2pbMi23klua7L35XVtotdvUop6gfvSIJjQ93tKK5YOPYP9qakgWYFXxxKiTO
	UW98YNu806ZNZa/C7EhCX7uFWXV5HzENhdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761617062; x=
	1761703462; bh=vZGcLkgSv40WTUnYjDPpe1fvUibiSYnN6DEOAJpqXMc=; b=e
	jPrPfTkyJVEdGsVXqumqLCBDzdn5eZQWMMP3SysI+5J9ZAHUoJ620kqBwf249aml
	bU63MRkez6ZGck5svyWuB+RiLOQ8P5wiqYmX3c7G9y2hlwNWNMMeuEcpbM3wUdUn
	88KTX7XEYA/h8PpqUq6PkXc2WZGMNUkBhugWs0RezRdxBEaJBUP2c79eKpPPHObJ
	q/c1ccr1/jDySmmBi8Lw16GE8PJmyErbSfRo3bRhGcr+7NVYZ1bdKSlV9bIQvxhB
	qPG957Ynca6JkDVo2hKXhhCGNnO7TOvVs/2ge42rJD80veAbJPeZ1s1jhwWPd3qG
	SwbpudnxScBHYP53YwQgA==
X-ME-Sender: <xms:pSQAacTtkRnJJjRQJOGuiDLT_IT-85MRt5yX1yh27UygOTkcc-7h3g>
    <xme:pSQAadeV4R5Qt7IKeghRgwnf8bvEYk-op3PoCc3cw2NfbeWBLIxyYl0UFxaKmmY51
    dDzn5NChrZ8H6KPqQyZvJy-O_Zs8COHzhVlFLy54CJutWdoCQ>
X-ME-Received: <xmr:pSQAaTpRo68pA-oZnfyc1zXVK1OlQReMsZa0_uFwhoit-bjF8ThPw9JdXdHvQx7BYv2fBgAVXyv7a-sy9JJl0sxwSolzgSEhotOJwWKQNLEe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pSQAaW8h6ZRzK5tsybisl9PTGFwIFJUNtqxDHnNCzQ1FoG_0T3KEOA>
    <xmx:pSQAaXfFFlZAPwrOoy_tJkGeo6zIhcuPKDM_9IMahuO4SBMTPs0-rg>
    <xmx:pSQAaYIc_-f6psp5rbMextnPfZNW2IVzsdMM8aZml4iKZmvHVlahJw>
    <xmx:pSQAafhlHA2Wv8QFRBUuav3beEqQZlzU0IBm7rzM0s8MDzxKJ0EW_g>
    <xmx:piQAaTc6FWsLJkJaKteODHqR3nWD7eG9arBMdHYogyuWY_o7aDVOS94l>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 22:04:19 -0400 (EDT)
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH v3 01/10] nfsd: fix current-stateid handling after PUTFH etc.
In-reply-to: <a7d27c56-f250-41f2-83e1-4befa144d5cc@oracle.com>
References: <20251026222655.3617028-1-neilb@ownmail.net>,
 <20251026222655.3617028-2-neilb@ownmail.net>,
 <c79a95a9ae87f22f77a5d144f4d43072bd32ba4b.camel@kernel.org>,
 <a7d27c56-f250-41f2-83e1-4befa144d5cc@oracle.com>
Date: Tue, 28 Oct 2025 13:04:18 +1100
Message-id: <176161705835.1793333.5873591071175553489@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 28 Oct 2025, Chuck Lever wrote:
> On 10/27/25 8:35 AM, Jeff Layton wrote:
> > On Mon, 2025-10-27 at 09:23 +1100, NeilBrown wrote:
> >> From: NeilBrown <neil@brown.name>
> >>
> >> According to RFC 8881 section 16.2.3.1.2 the result of a PUTFH op on the
> >> current stateid is that it should be set to the (all zeros) anonymous
> >> stateid, not treated as invalid.
> >>
> >> Currently if a request contains a PUTFH followed by a READ request using
> >> the "current stateid" special stateid, it will result in an
> >> invalid-stateid error, where as it should behave the same as if the
> >> anonymous stateid were given to the READ request.
>=20
> Wondering if there are implications for pynfs -- either a testing gap,
> or a test that is now passing that will will fail as a result of this
> change.

Actually - this "fix" is wrong.
The RFC says that the current stateid can never be a special stateid.
So setting it to "anon_stateid" effectively makes it invalid, which is
how the current code treats it.

I'll need to revise this series...

Thanks,
NeilBrown

>=20
>=20
> >> This is easily fixed in clear_current_stateid().
> >>
> >> Signed-off-by: NeilBrown <neil@brown.name>
> >> ---
> >>  fs/nfsd/nfs4state.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >> index 35004568d43e..e1c11996c358 100644
> >> --- a/fs/nfsd/nfs4state.c
> >> +++ b/fs/nfsd/nfs4state.c
> >> @@ -9091,7 +9091,7 @@ get_stateid(struct nfsd4_compound_state *cstate, s=
tateid_t *stateid)
> >>  }
> >> =20
> >>  static void
> >> -put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
> >> +put_stateid(struct nfsd4_compound_state *cstate, const stateid_t *state=
id)
> >=20
> > Side note: This function should really be named set_stateid() or
> > something similar. The "put" there makes me think that it's putting a
> > reference, when it's not. If you feel like renaming it as part of this
> > set, I wouldn't complain.
>=20
> Agreed, a get/put pair implies the use of a reference count.
>=20
>=20
> >>  {
> >>  	if (cstate->minorversion) {
> >>  		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> >> @@ -9102,7 +9102,7 @@ put_stateid(struct nfsd4_compound_state *cstate, s=
tateid_t *stateid)
> >>  void
> >>  clear_current_stateid(struct nfsd4_compound_state *cstate)
> >>  {
> >> -	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> >> +	put_stateid(cstate, &zero_stateid);
> >>  }
> >> =20
> >>  /*
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
>=20
> --=20
> Chuck Lever
>=20


