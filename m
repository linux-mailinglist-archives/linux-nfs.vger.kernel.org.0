Return-Path: <linux-nfs+bounces-16862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09724C9D83C
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 02:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511D43A9442
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7BC226CFE;
	Wed,  3 Dec 2025 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/jEtV7r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFE21ADA7
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726276; cv=none; b=cBCnqwqi6hvzk7c4qMDKo6II2/yZRRV2SEmbUwOAL5aHKHciwTAkNg00GL/d7PvJWkySngpSHRzHTbpk5JU3l9MM/fSM7puXlnNOm7pCi7bUmMTHCC5wl7Ed4s9RjvyTWxG5/6Oag1mdqq4T7ArPh3Dtrngnrcb6NKy9cqc4/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726276; c=relaxed/simple;
	bh=isx2lUYQrVaRfu50CefVB6RyWVxeM+cogSel2psbI9Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ahjPUnyct7IOeEQXf0bCJSfVge8Arn7aKDVgAiYXj3b2RRpfRMldaW4xsTgY1TMA9d72VOFn7ulJ5OEDTXEo3wyW2Lhap+3RQxgUbmdKopEUz3L8HBaZ23EW5m5PrL7j4zlpVny8k+uSjSKTMY3SAR6MAe2BtNgDLmD0ps1PM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/jEtV7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A003C4CEF1;
	Wed,  3 Dec 2025 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764726275;
	bh=isx2lUYQrVaRfu50CefVB6RyWVxeM+cogSel2psbI9Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=t/jEtV7rCJxitmviH08hPC0yXBoiEYG+OKL9OKdtNDtSxFW7DQWqzviLSv9aAf5Qv
	 411kXMNAz7zezCi35Ephk89n9pbJK9WXEC0ymHS82Hw/+3S7onzyVN0RVZSXbatAE9
	 KRGIO5ay1T/rJtMzxI3Mwx2ISRs1CJ4aNkyYLSCoReb9IDw89VoD7GPrwgcDoop1c1
	 kFl0E8A2F198zJTr3jaQ0Kfdo+2wOGzaNrc8D7nwyejfNOdtvdc6jyWOf9I8gskqCJ
	 iZQ196G0//lH/IptrED3GDcAfPBl1crhKhoVnuMjtxkjkYcQHEO3LQO0UdXS/NSLzQ
	 +6Pzz9p35BTkA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AAAC1F40079;
	Tue,  2 Dec 2025 20:44:34 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 02 Dec 2025 20:44:34 -0500
X-ME-Sender: <xms:ApYvaUQ56U6KzLj1R2CbCBLuN4RGOdAKrGg2iGfI0Zqdbgydw2iaWA>
    <xme:ApYvaclN_8BLdt4MB5qrkEv28SY1VFcxEnFu0ZBQ3geAIJLeO64PCdavDOkpdCv7g
    HTXAR-hA6d1We1BmoUIpgzqXsEfJNAbPz4NstHVOqDtCCurtotc4Rgx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgr
    lhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:ApYvaTLMvmBcNvbFwkUsVeQDezHrkzIHsLOWzhstxmHDqEuOXFgnVw>
    <xmx:ApYvaX1LecWjTubQ9SqiD9u8jIxUD_7iRuUlqSjwWMQZa_dh1mQyVg>
    <xmx:ApYvaZ5GaFPrylXsYi_J86caCtObY9at-uThhc7mdlwebKzDQlyWqA>
    <xmx:ApYvaQ9lzaLf6Y_qMBEkkVpnECpXD4nYJRY4pvBXm9G0PaJEd--IBw>
    <xmx:ApYvaQXd7XnpaPX4MdklAB0ls32STs_UL-Ktrqs5yLySOTmKt-Ia956z>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 69D33780054; Tue,  2 Dec 2025 20:44:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW-f6n96Aybc
Date: Tue, 02 Dec 2025 20:43:48 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <dc25626e-fae0-401b-93ed-1c4fdf34186c@app.fastmail.com>
In-Reply-To: <176471811359.16766.18131279195615642514@noble.neil.brown.name>
References: <20251202224208.4449-1-cel@kernel.org>
 <176471811359.16766.18131279195615642514@noble.neil.brown.name>
Subject: Re: [PATCH v2 1/2] nfsd: prevent write delegations when client has existing
 opens
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Dec 2, 2025, at 6:28 PM, NeilBrown wrote:
> On Wed, 03 Dec 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> When a client holds an existing OPEN stateid for a file and then
>> requests a new OPEN that could receive a write delegation, the
>> server must not grant that delegation. A write delegation promises
>> the client it can handle "all opens" locally, but this promise is
>> violated when the server is already tracking open state for that
>> same client.
>
> Can you please spell out how the promise is violated?
> Where RFC 8881, section 10.4 says
>
>    An OPEN_DELEGATE_WRITE delegation allows the client to handle, on i=
ts
>    own, all opens.=20
>
> I interpret that to mean that all open *requests* from the application=
 can
> now be handled without reference to the server.
> I don't think that "all opens" can reasonably refer to "all existing or
> future open state for the file".  Is that how you interpret it?

It is: as long as a client holds a write delegation stateid, that=E2=80=99=
s a
promise that the server will inform that client when any other client
wants to open that file. In other words, an NFS server can=E2=80=99t off=
er a
write delegation to a client if there is another OPEN on that file.

The issue here is about an OPEN that occurred in the past and is still
active, not a future OPEN. NFSD was checking for OPENs that other
clients had for a file before offering a write delegation, but it does n=
ot
currently check if the /requesting client/ itself has an OPEN stateid for
that file.

The scenario I observed is that the requesting client held an OPEN
for SHARED_ACCESS_READ on the file. The code in
nfsd4_add_rdaccess_to_wrdeleg() assumes that if NFSD is about
to set up a write delegation, the pointer in fi_fds[O_RDONLY] is NULL.
That assumption isn=E2=80=99t true if that client still holds the S_A_R =
OPEN
state id, and fi_fds[O_RDONLY] for that file then gets overwritten and
the nfsd_file it previously referenced is orphaned.


--=20
Chuck Lever

