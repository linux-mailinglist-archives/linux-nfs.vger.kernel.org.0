Return-Path: <linux-nfs+bounces-17004-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5789CAE937
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 02:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C242300CAB2
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23531EFF93;
	Tue,  9 Dec 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZJsMj6a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90720ED
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242376; cv=none; b=MrEs3ph6oyf786us4VOv3quzkE3yRdhxQkq2wdMisjSN/Q7ihH6ABqZmxaZRM82fAR9NKS5x8ulk5nUIhaOPgXvDSFhNP7MWPoVOGb2jgdI9848KEst8+6EnBNKgob5RifKCR9jJjUU2ZIMHusJ19h1nr7hC2yPjWvwNPV4OYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242376; c=relaxed/simple;
	bh=g4Ms+AYPCq4mVFBjPPu2RyAPk0l+/LjNF+RmoBE15rg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m5/MUkZezI4Yvp99Fmm1TMPw6yFj+l44cU/lvNkUaR+GydTmYyxnZGkS6FXN9Wm24xKtCS88anuvMzUiwPCumxXx4d8uB8KwAsGEpHKvUWAe7MUZCGRbIMtg438vuJtxBlwnjdf8XtCUJ7re+SuVL3vtS9qgkBEVKQmICvqt+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZJsMj6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DCAC4CEF1;
	Tue,  9 Dec 2025 01:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765242376;
	bh=g4Ms+AYPCq4mVFBjPPu2RyAPk0l+/LjNF+RmoBE15rg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YZJsMj6arKSzmvTo6iU8HMlgBKf7+0m5GvonC519RcUcr85Fad6nwZhqSi5mT+EFE
	 GUpR4ZXiIFIAA7xk4LDIsNNXjAMR02e7R6G5N1eog/mFmB+UsEcPauEZtdzHumPX2Y
	 /4kpBJZwwgmh8TGubAPBMeuVm3wbUF+94YCIv9LsX9TDiO5q0il4Ztc8t3sJ/LxkHl
	 AOQGDT7RgBKVlJrMuZcagwwq2z49jDwg6/b4hWbhZCGpfpjqjQwUMGCsBMVY3ho+f/
	 QlyaO+ph4WL19+Zdy3cJT9YWriA7Y7MYu5gqaRuh43XY3DQyt1naXru4ZIDaVS8/Ps
	 Nlnb4SXBtJfyA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 20E2EF40069;
	Mon,  8 Dec 2025 20:06:15 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Dec 2025 20:06:15 -0500
X-ME-Sender: <xms:B3Y3aXg5geVvKI4_26WEhUIU9XDjMo38QuurpH-MvZxRO6QFgsLm6A>
    <xme:B3Y3ae0b1re_kc2CS625zOs0tCd2WV2C7t6IPmNLaIIosr6VidTyis0mRrHTNVXhB
    imZRLpwYfjbdjuUwGU6vzCvW1H3UQbOHkgfNPQxA8lero3AbNvezw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheplhhoghhhhihrsehhrg
    hmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhk
    ohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhi
    drtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:B3Y3aR1VG196ejyfFKjpgAQesqwH0zhAivGXqXWF_8fzDJXEbDhklQ>
    <xmx:B3Y3aSFpwB6AyViYhHjJERlzkWiua---yospYnWvh2HNC_sDleh_dQ>
    <xmx:B3Y3aYj3CqeEUrgWXpuOT8W3VtKmDmxkf_D3an86HgLdQi7QXsqRFw>
    <xmx:B3Y3adCSJ_w8z4UrIkHxtS1eh4NjS5cVKS8sHgPgg9cyDrgp_MohxA>
    <xmx:B3Y3aSSzQyWBh4L3m_7TatlkQ65pZxCpDsvAxO4VYMJXqRcenhyw0iTO>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 02BC378006C; Mon,  8 Dec 2025 20:06:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A76hygnRXIHN
Date: Mon, 08 Dec 2025 20:04:59 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Message-Id: <88a43961-144f-4e11-ab35-2957f00067e8@app.fastmail.com>
In-Reply-To: <1510f19f-6bfa-47c4-a7fb-0f6fa8f723a1@app.fastmail.com>
References: <20251208194428.174229-1-cel@kernel.org>
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>
 <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>
 <176523482003.16766.5991961928943612885@noble.neil.brown.name>
 <1510f19f-6bfa-47c4-a7fb-0f6fa8f723a1@app.fastmail.com>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 8, 2025, at 6:13 PM, Chuck Lever wrote:
> On Mon, Dec 8, 2025, at 6:00 PM, NeilBrown wrote:
>> On Tue, 09 Dec 2025, Chuck Lever wrote:
>>> On Mon, Dec 8, 2025, at 4:35 PM, NeilBrown wrote:
>>> > Now that "struct knfsd_fh" doesn't encode info about the fh format that
>>> > knfsd uses, would it instead make sense to discard it and use "struct
>>> > nfs_fh" throughout NFSD?
>>> 
>>> Based on the effort I've already put into dealing with just ssc, I
>>> think that would be a monumental change, and I'm not convinced it's
>>> worth the cost.
>>> 
>>> What's more, it would move in the wrong direction. Stapling the client
>>> and server implementations together by using the same headers makes
>>> the code more difficult to modify without touching both trees in a
>>> rather invasive way.

OK. If we want to go the other way (replace knfsd_fh with nfs_fh
throughout NFSD) then I'd rather keep only the struct and the
CRC hash function in a single header to avoid pulling in a lot
of junk that only a few consumers need.

However there is still the problem of how large to make the
structure's data field. Right now it's NFS4_FHSIZE, but that means
you have to somehow include the header that defines NFS4_FHSIZE,
and that pulls in a lot more stuff than we really need or want.
It's difficult to separate the file handle structure from the rest
of the protocol.

NFS3_FHSIZE, for instance, would be defined in both linux/nfs3.h
and include/linux/sunrpc/xdrgen/nfs3.h . linux/nfs3.h includes
uapi/linux/nfs3.h. And fs/nfsd/nfsd.h includes linux/nfs.h,
linux/nfs3.h, and linux/nfs4.h, so there's no escape from the
uapi headers. (I'm not sure why NFS uapi headers have the
protocol bits in them; shouldn't they have only the admin UI
APIs?).

I don't think any of this would be terribly obvious to reviewers
even if the series had more patches. You basically have to go
spelunking to discover it.

A different way to slice this would be to make the subsystem-
agnostic NFS file handle merely a size and pointer to a buffer
(like struct xdr_netobj). Then both the client and server
implementations can use either static arrays or dynamically
allocated buffers, and they can get their maximum size
constants from wherever they like.

-- 
Chuck Lever

