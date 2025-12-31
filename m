Return-Path: <linux-nfs+bounces-17366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE3CEB08B
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 208863016CE8
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269DF83A14;
	Wed, 31 Dec 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d55lPuyX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019104D8CE
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147533; cv=none; b=Iq2GYQsxBG03KCzkJ7I/CVszMe2cykf2WaKpEJPCRixcJHancot0S/aRy6YyURZBAri4E4j1vd33me8llB9N0uYQnjkl57INUDS+nEf5pfQUY44CZPDK0cBeWfCL39M4UzshPTYWA19Q7icIfvGRkG0jQquus4SG4aaQ40qe2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147533; c=relaxed/simple;
	bh=DenaCsFAddSq6p2zY++BEOtLtOon5WKK5mHjpDaJe8M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JG6L2CixNT8Cm+9zXuQO6Zf2s29hCL2L2TMuu2NJ3CuvcRSrXS4Txgh5EM0j4IiQTIZYP+MIaF04JznnguOqa0K6OFZwpOI/xMnZypy/1c7yIfP1vRK1NQq0bR2HFuROF3XoZUoVDpu8oc7wFso4KP9X9+bSjzaFQNGUAqj5Vsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d55lPuyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EC9C16AAE;
	Wed, 31 Dec 2025 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767147532;
	bh=DenaCsFAddSq6p2zY++BEOtLtOon5WKK5mHjpDaJe8M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=d55lPuyXVTa+cBgpN/czKL62G8bccOBLMheen/eQfa9l/BScA2K5BqJv/H+py152y
	 VztmLLwhLifI4CgXOcGeq2lQiSHVHuoBrl1bXvWXclnXDQLYCB6X0aaqjmp7GEzAaj
	 oE3cqAYmo+T+D0U+wSU2XoJM0JWsYcRFRFhGytiNqDlrJZH9TGznUiOtM8UJ2zqe29
	 8pIRJE9uh6TrzWXpC601QmLiOwyAu85o2bckwXjodJUD5NPlSYzoeeRdqkX+lUIVwR
	 rtvXoBzmbhv+EdB3Hu3zGwk6lthuMGpS2+fu3cjWGNhwA3SowFDRWCaOCQTkkkxFVD
	 rRKaFOBsmW2PQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 437BEF40068;
	Tue, 30 Dec 2025 21:18:51 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 30 Dec 2025 21:18:51 -0500
X-ME-Sender: <xms:C4hUacLdkrBuFNP7ProsmVmOait6NuGDsFxOpmDFVhA8c-mDjWJzhw>
    <xme:C4hUaW-LK6imUpv5pKug2nNPKz72DtmNgLi7vGiwKBINnKKx-CJfXzTPrib6l-Gk5
    xjS14SsFIZDfS7hS5uVpEE0fiNqP1QwdCyPf15rnDaEvegRAVNd_SI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:C4hUaYB_VuC8FrBMrntkwqwMyygbqYZgZtwjI9uTPAuFEHIFWtQxqg>
    <xmx:C4hUabO3EFQiHeuaiouHqVfWQBD57X8QMI9FCOhxIO0TiLMxEegONA>
    <xmx:C4hUaZzd4aqFj5x_xgpIEuvbL-2vjo_FAIMQi5JfqPlCRefa06lo4g>
    <xmx:C4hUaTXjYpVCiZcHtxHuRreLDWQKXYphdUg8S7O0R3L3DHYc8RlEqg>
    <xmx:C4hUaTO38lENY49ipwQ8GThZqvkcCU3rvn5KNffXicRG_xWeao3Q2Vqg>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2172B780054; Tue, 30 Dec 2025 21:18:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ava-Aaqlpe67
Date: Tue, 30 Dec 2025 21:18:27 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <c056c13d-554d-48d7-b085-aa02146c5426@app.fastmail.com>
In-Reply-To: <176714088647.16766.1296067005074563041@noble.neil.brown.name>
References: <20251230141838.2547848-1-cel@kernel.org>
 <176714088647.16766.1296067005074563041@noble.neil.brown.name>
Subject: Re: [PATCH v1 0/5] Automatic NFSv4 state revocation on filesystem unmount
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Dec 30, 2025, at 7:28 PM, NeilBrown wrote:
> On Wed, 31 Dec 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The server also provides no notification to NFS clients when their
>> state becomes invalid due to filesystem removal. Clients continue
>> using stale state until they encounter errors, potentially
>> corrupting data or experiencing mysterious failures long after the
>> underlying storage disappeared.
>
> I don't understand this claim.  You code uses exactly the same internal
> mechanisms, which trigger ADMIN_REVOKED errors to the extent supported
> by the protocol (v4.1 does this better than v4.0).
> How is this para relevant?

The key is =E2=80=9Cdue to filesystem removal=E2=80=9D.

But I suppose there is a chicken-and-egg situation here: umounting doesn=
=E2=80=99t
notify clients today because the unexported filesystem is pinned and can=
not
be unmounted. I=E2=80=99m not sure this paragraph is adding much value.

I=E2=80=99ll digest your other comments and produce a v2. Thanks for hav=
ing a look!

--=20
Chuck Lever

