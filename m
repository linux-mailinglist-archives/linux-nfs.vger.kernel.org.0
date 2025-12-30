Return-Path: <linux-nfs+bounces-17351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F055CE9E56
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 15:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780A23017394
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E79253F07;
	Tue, 30 Dec 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMKNrOIw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15D22FE0E
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103997; cv=none; b=c3CPaC6l7eRoU5beVn0AlZoYsrLXe4oIKuU1mnV6LlC2+WOCBrjiSxtTzyc/2iPVmPE4xf+PFq15lKPenETNah5FpWXSPvUcA4MHW1kY1373i+BZS2mo8nXHE+Z1ogUgy+Iy8pRj/FUNxsFgp30IrbdCLHr5s81PYRqmXBB3+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103997; c=relaxed/simple;
	bh=tDU6zy1IUS5op0nMfPe4lGzUOae3nbxzn1ysze3sRPw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r4OZsDABIsvtjq/UczMPuc/U0c7mXMQPh68C0ag1DGnUn5VryJqYgEy7UW9RFpMIXhYbMU/9WoUuM6PIwYU1jrp/m3wE4gfKwaOQL76epBIN/BpH+zPCgiLxTK1nEnYqnhuPBiPm//xRQk5n0q7rFGUUlz12S3+b4JagLDjouaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMKNrOIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342BFC4AF0B;
	Tue, 30 Dec 2025 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767103995;
	bh=tDU6zy1IUS5op0nMfPe4lGzUOae3nbxzn1ysze3sRPw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dMKNrOIw0cO/S7f242zdoR0A2tEBDBdWLodnl/OZA/KSmZ/lsVPNgUBm5ZYvtpeJ3
	 1AY0Nf65sbd6Zi9ltIUhZA1RnSyIHXTkJ7o5/8I9ev8AKsI0iX7+5PcybWucKNFm3I
	 0A3C7YG+JdLHU+5nsHYrKpmc9T4SrAyTr0AsfB4Qy2Ddq5DPyF3PLDJfTjlqNHW3FR
	 JSm1JKV6YOZ3FSnNRNXInB+Moj35C+0uP6fWjiPPprGFsa83oESLYCb4Rp1K51smJa
	 bpnnrno8ybIX+3QsiMZ+/J1CIv4w95jrap1bDjHq2kMcUybIqY48w/1LReEIveSbto
	 dgpqbU/sQ33Ew==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3C7F8F40068;
	Tue, 30 Dec 2025 09:13:14 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 30 Dec 2025 09:13:14 -0500
X-ME-Sender: <xms:-t1TaSMtLk14yYg0e59RVQkK6NWLEyihmQKLqN1kkAAFK1BBQQpw5Q>
    <xme:-t1Tabx9CStHHDsPylftoYXkcd35kAs-7oS1n6hhw_4KyonLW9100lwIMWjdIPaYG
    GUbxWshBfLRoO5_o3fdKrazUb67_OlMa4YpXxFzYMDkcukRRz4vP0Tx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgeehudeiieevveehleehleeugefhhfdttdehlefhuddttdehieelteekleevtdejnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpe
    epkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrg
    hmvgdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhope
    gurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghv
    vghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-t1Tabiu7BZ0WDphQzZYBZPnXrB6LQQmJVe8ynZTT2PlGJkiHl8h5A>
    <xmx:-t1TaSDSSH77yb8mKTXl4IrFia7miS5qI_gbMe8N14d0g3SHj9vrgA>
    <xmx:-t1TaRvGiM_LsTLikRvq2FglFLlVv8kSdNKetNwYiiDcS0D8FlsGNA>
    <xmx:-t1TaWeZ1CpJX9pWaNzZQrT5HHacHSTKapNo7hId_wOF3nfBii79hQ>
    <xmx:-t1TaW8rD341axLCqN_7bvj8xRCjzkamm8rZHGCjAL9lNTwOFV7H4dPY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1B915780054; Tue, 30 Dec 2025 09:13:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2uuH-1PIZ3B
Date: Tue, 30 Dec 2025 09:12:53 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Message-Id: <5b1a04ad-c4b5-4b44-ba54-b2ba1bce6ef2@app.fastmail.com>
In-Reply-To: <20251229150831.2c6af85f@phoenix.local>
References: <20251229150831.2c6af85f@phoenix.local>
Subject: Re: Fw: [Bug 220921] New: nfs bug , mountig nfs volume
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Dec 29, 2025, at 6:08 PM, Stephen Hemminger wrote:
> Begin forwarded message:
>
> Date: Mon, 29 Dec 2025 23:01:41 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 220921] New: nfs bug , mountig nfs volume
>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220921
>
>             Bug ID: 220921
>            Summary: nfs bug , mountig nfs volume
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: walter.moeller@moeller-it.net
>         Regression: No
>
> # 1. Bug-Report an LKML/kernel.org:
> # Titel: "NFS: EPERM on dangling symlinks to unmounted NFS volumes bre=
aks
> userspace (Portage)"
> # Details:
> # - Kernel 6.19-rc3 vanilla-sources
> # - Symlink zu nicht-gemounteten NFS-Volume
> # - emerge/Portage schl=C3=A4gt fehl mit "Operation not permitted"
> # - Regression von 6.18.2
>
> # 2. Tempor=C3=A4rer Workaround:
> # - Link umbenennen (hast du gemacht =E2=9C=93)
> # - Oder NFS-Volume mounten
> # - Oder bei 6.18.2 bleiben
>
>
> Kernel-Regression best=C3=A4tigt:
>
> 6.18.2: Ignoriert Links auf nicht-gemountete NFS-Volumes
> 6.19-rc3: Wirft "Operation not permitted" und bricht ab
>
> Das ist ein Kernel-Bug der gefixt werden muss!
>
> Regards walter m=C3=B6ller
> ps: uahc kernel 6.18-rc3 !!!
>
> --=20
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are the assignee for the bug.

Stephen, can you assign this bug to:

Product: Filesystem
Component: NFS

I'd like the NFS client folks to take a look at this one.


--=20
Chuck Lever

