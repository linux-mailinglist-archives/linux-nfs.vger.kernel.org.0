Return-Path: <linux-nfs+bounces-16777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7184C92788
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 16:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68BBB4E1218
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FF23370F;
	Fri, 28 Nov 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWeWly+S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00C1A9F93
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764344699; cv=none; b=oI6F+vbDFbBbQfMsalvK8Z1BQ2C4zigmoXArz5ILpRMBjbzleAQ9jX+p7u+AxvFFKsp+ty+y2HEsPIit5xka15qSVu1fJtKBB/GdULewWNl/QqouYMrehhY2yNRDSerlb4UiKQs1TWbaHQYXouwAhsHI1OCXzAcVnRVM1bF90Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764344699; c=relaxed/simple;
	bh=zKAr03CGQvMl6cFkOglwgaFPpnC1pqYokPO9usNWNJw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YGqECsRpxCGQfvnP+EOxxnTWGd03JupxfGImCrJGpM05BntdjrWhajP9W4NVK5CEP/nM43cAB7oeqnAXHhGYDgSezMmot9o36ZUcH9UZaW0zvhB3vqZthHnV+rv0yjpxm0NyycDMRAwzpNo+LhCwZgxqMTZcQt87gh5CIn0Y/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWeWly+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0222EC4CEFB
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764344699;
	bh=zKAr03CGQvMl6cFkOglwgaFPpnC1pqYokPO9usNWNJw=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=mWeWly+SP0dYWV0eTvG8DbZdGe000u169XcHj6h7fmH09ZqNtAsH6RR9lBAy5hNtd
	 ZLMjln6n29o2pGTD2TLChKXn8g6NYfKi67OKKxPalTIZ7NSvOEQIzQDJp3eM/0etXa
	 TVDm+n3vPTd0cCK3Lon3CKMLcyx+le8FNbdrgd0Jf6zFoYm46lJMEQlZTrT9NhaMFI
	 HVnd7lCIIGU4nYpj444d+5niVtJ50bMh+l+mYTZRmFO8a6wafp/YpY3vwc3wjlgk4D
	 /JXCZQKDjYzdLum8wQczOLnNQrtrRuksC7v6qv3dBqmRnFGMF9NFH78tn9zI3Skw/H
	 olgUdoEy60nUw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E1AFF4006B;
	Fri, 28 Nov 2025 10:44:58 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 28 Nov 2025 10:44:58 -0500
X-ME-Sender: <xms:ecMpafLV_tmiamfDgazFw41C3ozeXeGH0vxo6Efe6RWxUYb9B8ekOQ>
    <xme:ecMpad9XX7hYpiwzg7U2ldQFS9NiJVVgZBLowK9bNAmsFS5YaIa97SEv9Ebe6Kp4X
    mavGQQ7DwmSDvd_O13WnyhjKsEc2rAxMMJFN7X3aFBUFE_jMZoa26iT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephefgvdetffdugfdvtdetieeiudffuefhleeuffdvgeduueehffffveejteeuhfdunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegruhhrvghlihgvnhdrtghouhguvghrtgdvtddtvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ecMpaZ2dUgTAGlQMxyNo8pbpYs60_0auxADbJEdLwhiHn-NVxc5p3w>
    <xmx:ecMpaeByXqsy-lJIcnLs8MbcrMqNizCgeO1QZWMSUQGbbXsJl6BlfQ>
    <xmx:ecMpaRensuIp1VqsKWgVoIeY8ykwxRYFEhA1Xb9KXRlHdniMx3hVKQ>
    <xmx:ecMpaTi6-6DkBeQqieAd1-1dR7Q2J9tWd-oxEpHYFnY29xtmhaPCDA>
    <xmx:esMpaZpMscuQD7kc0uOtgdYN6ibmxSDfslzzaSmHCl4CUSmGTXdIFkj4>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0174780054; Fri, 28 Nov 2025 10:44:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwX2CI0UG88J
Date: Fri, 28 Nov 2025 10:44:00 -0500
From: "Chuck Lever" <cel@kernel.org>
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>,
 linux-nfs@vger.kernel.org
Message-Id: <49f3ae79-bbe1-470c-a247-68c942fc2f7d@app.fastmail.com>
In-Reply-To: 
 <CA+1jF5o5tiYfvqPKnf7_teMNOnOwig38epUywfsFLXsXVm=NmQ@mail.gmail.com>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net>
 <CA+1jF5o5tiYfvqPKnf7_teMNOnOwig38epUywfsFLXsXVm=NmQ@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Nov 27, 2025, at 4:12 PM, Aur=C3=A9lien Couderc wrote:
> On Sun, Nov 23, 2025 at 4:46=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
>>
>> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aur=C3=A9lien Couderc wrote:
>> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org=
> wrote:
>> > >
>> > > From: Chuck Lever <chuck.lever@oracle.com>
>> > >
>> > > An NFSv4 client that sets an ACL with a named principal during fi=
le
>> > > creation retrieves the ACL afterwards, and finds that it is only a
>> > > default ACL (based on the mode bits) and not the ACL that was
>> > > requested during file creation. This violates RFC 8881 section
>> > > 6.4.1.3: "the ACL attribute is set as given".
>> > >
>> > > The issue occurs in nfsd_create_setattr(), which calls
>> > > nfsd_attrs_valid() to determine whether to call nfsd_setattr().
>> > > However, nfsd_attrs_valid() checks only for iattr changes and
>> > > security labels, but not POSIX ACLs. When only an ACL is present,
>> > > the function returns false, nfsd_setattr() is skipped, and the
>> > > POSIX ACL is never applied to the inode.
>> > >
>> > > Subsequently, when the client retrieves the ACL, the server finds
>> > > no POSIX ACL on the inode and returns one generated from the file=
's
>> > > mode bits rather than returning the originally-specified ACL.
>> > >
>> > > Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.co=
m>
>> > > Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
>> > > Cc: Roland Mainz <roland.mainz@nrubsig.org>
>> > > X-Cc: stable@vger.kernel.org
>> > > Signed-off-by: Chuck Lever <cel@kernel.org>
>> >
>> > As said the patch works, but are there any tests in the Linux NFS
>> > testsuite which cover ACLs with multiple users and groups, at OPEN =
and
>> > SETATTR time?
>>
>> I developed several new pynfs [1] tests while troubleshooting this
>> issue. I'll post them soon.
>
> Thank you
>
> My point however was if pynfs can take a list of users@domain,
> groups@domain as input parameters, which are then used for
> FATTR4_OWNER, FATTR4_OWNER_GROUP, FATTR4_ACL and FATTR4_DACL tests.

pynfs tests are not parametrized, but we can choose specific
combinations of arguments to exercise, and then add a new test
for each of those cases.


> Some of the ACL issues only happen for specific ACL combinations, thus
> such two lists with parameter input would be useful.

I have additional pynfs tests which aren't quite ready yet that
exercise the relationship between OWNER@, GROUP@, and named
principals.

There are some complications with the NFSv4 <-> POSIX translation
adding a DENY ACE when it doesn't recognize that a named principal
is the same as OWNER@ or GROUP@. In that specific case a user can
set an ACL that locks the file owner out of the file unintentionally.


--=20
Chuck Lever

