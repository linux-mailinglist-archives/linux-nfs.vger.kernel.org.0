Return-Path: <linux-nfs+bounces-17015-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 451EFCB17AB
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 01:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F214530647A4
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 00:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1317A309;
	Wed, 10 Dec 2025 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="wLEUGIb1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IG4M5VGY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95367322A
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326340; cv=none; b=TsLlRfXF6VIIgmsN8raUmcxdlXOWJi9xGYoy3HdELJquvR/iVm+xckNYK6bLpQN8JU+wSQbUNcToYrm31XF0OK3oxnVZYo3bVsaDaMdu0aguUCp84nhPuaWz9644Fp/VWurSg0wbkURIgR7vy8nz2MVmEp0X0atEKOADcOE3YOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326340; c=relaxed/simple;
	bh=QYiE/fsegBZFiN/RHwJFxt7RjA7MK86YLk2bkhpId48=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oij5VlPaK3stu4xvZ7okKjPSZrlUh2WnjfmOud4A5wFh26TccHJOoNHFYqGKVEWVODM/UsZU4ITSmQAhLATAScKfy+i+/3JqdjmXK1koErU25rV1UQOLgfiuPmVNVjA9In26Rh2z8ICJYnTVbmV4bap2zd/qf5vLegbMi7sRofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=wLEUGIb1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IG4M5VGY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 948661D0012B;
	Tue,  9 Dec 2025 19:25:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 09 Dec 2025 19:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765326336; x=1765412736; bh=iKmwKvBknkYni1yuZ/eFeAKAhN1u+5mvOti
	q8ztiptE=; b=wLEUGIb1Hr4J2Y9HLQviQAyECUEvUtpyUouu4uA6sJOwBK0kwnK
	5M2nQ4P4Q+HDUoo5UPmVEfftqcjMiOLUd6zoyH0sc8jkJs0fg50/22SU1466Y3HG
	ejgPevWYLF7J0Z3uE68KlI2M5e5tLZEJzGLJMVXWedqduXwOJOMLnoCPnwKxBk8M
	NEgK5TrWnIJQ4fHQJGtbdPOx6NKMHZlvY2GxDronugKRNQR0v5Ov9uQu21aiIiHl
	iFbS1oGbyj5W3THiymVkktiX9ZrZArO6faflX8gaFAddopgiVWE9PN3Q21NCdzCL
	8A6l78NT7CPWP7fkVjhEE8rGs6VPYpyC6cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765326336; x=
	1765412736; bh=iKmwKvBknkYni1yuZ/eFeAKAhN1u+5mvOtiq8ztiptE=; b=I
	G4M5VGY9IvKNGMPzbXKqM7j++ofxLWwOdFwLis22sq5aBoz84++1g6dymIqhwZXb
	tGNCyHhq1gSs5qfxs3sKMYjOBA1/d/AFg0pg6Knd5mDxZ3jARxbRWucSuzmfPnB4
	IflernHmTANGESxtggytvuPw9rpC6uLHYpvsMLKHbWwfaB6VZdYju9ZIEiJIKAa8
	+HFUDkdouhOiOkWtqA5niT+srGdm5+q6hOO0BQUoc7SMWs1NLjoIngN8bdmvvhdr
	7T+Y9gGXsc+1rkM9gAcuoMqVkKQ8q7ywDSPdYb8bqXny8ZXbLBwwe4wadLSWSqPT
	/Wqshxbdh0z68ktIkdxeg==
X-ME-Sender: <xms:_704aSexA8vi1990UZEQOdp8MTFrUHg0Fn7StPa1ck7H_kS7u1cvwg>
    <xme:_704abRyGHJPY-QKvMOffEjjyuzuIfATaqHvlmkxkOthTEKGhyh-VHq-JT9SyN7ye
    y26ceZMb91Nka9r4vwstqoPnLaOuwL242zprWdihAKbO1WqCw>
X-ME-Received: <xmr:_704aZtM8_STD2qL-8FX2pci2J_X4yh8O7Y_pZGiJuZuHWJbp5nqbnkk1-LcbNy_BEQ9tS-vNrsrtJ-ceJVbaDx_vduRE4rtQrPrwCKHqHmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhghhihrheshhgrmhhmvghrshhp
    rggtvgdrtghomh
X-ME-Proxy: <xmx:_704acf9N2BAxqKlpiT5ES6IXt2pFH-gAQ6pLIv-_D5VJqb9fxtL_Q>
    <xmx:_704aTZmivMHdX4Ld3RaERd2cn3wWxEiMGm0kyalxRBKJvHoYqbIew>
    <xmx:_704aeYGQvgxLCtI1EoPuD8LMM4swNCBASX-gVrbSpe7qB4x7ewDzg>
    <xmx:_704aYLkGlkYSfaM-RrLXdBiv4hCaNPJMjJTgXAStJSXc8op_1jlbg>
    <xmx:AL44aRIFvHREn2h-SvM5-XOXqGzScMJow4Omnat_m2hVOlpoRv3M7c26>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 19:25:33 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
In-reply-to: <d6640c19-5849-4e52-94be-ff5ce81756c8@app.fastmail.com>
References: <20251208194428.174229-1-cel@kernel.org>,
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>,
 <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>,
 <176523482003.16766.5991961928943612885@noble.neil.brown.name>,
 <1510f19f-6bfa-47c4-a7fb-0f6fa8f723a1@app.fastmail.com>,
 <88a43961-144f-4e11-ab35-2957f00067e8@app.fastmail.com>,
 <176531654526.16766.8587255373456590272@noble.neil.brown.name>,
 <d6640c19-5849-4e52-94be-ff5ce81756c8@app.fastmail.com>
Date: Wed, 10 Dec 2025 11:25:29 +1100
Message-id: <176532632929.16766.13595576322961529286@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 10 Dec 2025, Chuck Lever wrote:
>=20
> On Tue, Dec 9, 2025, at 4:42 PM, NeilBrown wrote:
> > On Tue, 09 Dec 2025, Chuck Lever wrote:
> >>=20
> >> On Mon, Dec 8, 2025, at 6:13 PM, Chuck Lever wrote:
> >> > On Mon, Dec 8, 2025, at 6:00 PM, NeilBrown wrote:
> >> >> On Tue, 09 Dec 2025, Chuck Lever wrote:
> >> >>> On Mon, Dec 8, 2025, at 4:35 PM, NeilBrown wrote:
> >> >>> > Now that "struct knfsd_fh" doesn't encode info about the fh format=
 that
> >> >>> > knfsd uses, would it instead make sense to discard it and use "str=
uct
> >> >>> > nfs_fh" throughout NFSD?
> >> >>>=20
> >> >>> Based on the effort I've already put into dealing with just ssc, I
> >> >>> think that would be a monumental change, and I'm not convinced it's
> >> >>> worth the cost.
> >> >>>=20
> >> >>> What's more, it would move in the wrong direction. Stapling the clie=
nt
> >> >>> and server implementations together by using the same headers makes
> >> >>> the code more difficult to modify without touching both trees in a
> >> >>> rather invasive way.
> >>=20
> >> OK. If we want to go the other way (replace knfsd_fh with nfs_fh
> >> throughout NFSD) then I'd rather keep only the struct and the
> >> CRC hash function in a single header to avoid pulling in a lot
> >> of junk that only a few consumers need.
> >
> > This thing that I keep thinking of the is "enum nfs_stat".  I don't
> > think we want two copies of that in the kernel.  It is currently in
> > uapi/nfs.h and so in nfs.h
>=20
> Yes, and fs/nfsd/nfsd.h defines a bunch of little-endian
> equivalents too. There are already multiple copies. Eventually
> there should be Only One (tm), and I'd like that one to be
> defined directly by the protocol specification.
>=20
>=20
> >> However there is still the problem of how large to make the
> >> structure's data field. Right now it's NFS4_FHSIZE, but that means
> >> you have to somehow include the header that defines NFS4_FHSIZE,
> >> and that pulls in a lot more stuff than we really need or want.
> >> It's difficult to separate the file handle structure from the rest
> >> of the protocol.
> >
> > "128".
> > I don't think this *needs* to be NFS4_FHSIZE (though it will have the
> > same value).
> >
> > #define NFS_MAXFHSIZE		128
> >
> > works for me.
>=20
> Note that lockd uses "struct nfs_fh" as well, but in this case, the
> 128 bytes is overkill because NLM uses NFSv2 and NFSv3 file handles
> only, which are 64 bytes at most.
>=20
> I might be inclined to define an nlm_fh for this purpose.
>=20
>=20
> >> NFS3_FHSIZE, for instance, would be defined in both linux/nfs3.h
> >> and include/linux/sunrpc/xdrgen/nfs3.h .
> >
> > Ok, I think this might be getting close to a central issue.
> > I think you want the .x file to become the source for all the various
> > constants and types with the generated .h files included where needed
> > and, significantly, any existing .h files which define the same name NOT
> > included in those places.
> >
> > That sounds like a good long-term goal, but it isn't clear to me that we
> > want to jump straight there.
> >
> > In the first instance, I think the main value of generating code from
> > xdr is the code - not the declarations.
>=20
> I don't agree with that. The .h files contain:
>=20
> - Protocol definitions, using the same names as the RFC
> - Function declarations for encoder and decoder functions
> - Size constants for each on-the-wire data item for buffer
>   length computations
>=20
> IMO the .h files add critical value to the generated code. It's
> boilerplate code that is straightforward to machine-generate in
> either a C flavor or a Rust flavor, and human coders can get these
> wrong.
>=20
>=20
> > What barriers are there to NOT using the .h files generated by xdrgen?
>=20
> A significant portion of what is in the human-generated .h files
> would be dead code. We still need to include .h files that define
> the XDR arguments and results structs, and they would need to be
> based on the human-generated protocol headers.
>=20
> That seems pretty messy.
>=20
>=20
> >  linux/nfs3.h includes
> >> uapi/linux/nfs3.h. And fs/nfsd/nfsd.h includes linux/nfs.h,
> >> linux/nfs3.h, and linux/nfs4.h, so there's no escape from the
> >> uapi headers. (I'm not sure why NFS uapi headers have the
> >> protocol bits in them; shouldn't they have only the admin UI
> >> APIs?).
> >>=20
> >> I don't think any of this would be terribly obvious to reviewers
> >> even if the series had more patches. You basically have to go
> >> spelunking to discover it.
> >>=20
> >> A different way to slice this would be to make the subsystem-
> >> agnostic NFS file handle merely a size and pointer to a buffer
> >> (like struct xdr_netobj). Then both the client and server
> >> implementations can use either static arrays or dynamically
> >> allocated buffers, and they can get their maximum size
> >> constants from wherever they like.
> >
> > I don't think the extra indirection of using the xdr_netobj approach for
> > filehandle is a good idea.
>=20
> I'm talking about only the places where the client and server need
> to communicate via local procedure call, like fs/nfs_common/nfs_ssc.c
> or lockd. This would leave both sides to use their preferred storage
> and internal API structures.
>=20
> We have the same problem with nfs4_stateid versus stateid_t, and it
> is also pretty convenient to shove those into an xdr_netobj to make
> a function call between the client and server.
>=20

This all brings me back to something I said earlier.

I don't think I can properly review this patch without the context of
the follow-on work which appears to be the primary justification.

Thanks,
NeilBrown

