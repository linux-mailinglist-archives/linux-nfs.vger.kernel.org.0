Return-Path: <linux-nfs+bounces-17001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF7CAE42E
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 22:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C103014AF8
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCA027874F;
	Mon,  8 Dec 2025 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trW9q2KK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF626ED4F
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765230362; cv=none; b=GHKD1i2M8FRSHCCCoMwvlUwCIBggRG0Jp15Iorzb6uoPnP2o3FehgIOv3tVsg4xMLYqqyaHUgK2GEfzPekFi6yY33EKhlj4Cfa+ndJ/35+KT+aNEohAZfiZljlFjynLzHf/c+S1kn0HL1zCOAWjlAVj3H7czNL0NZUE000pqIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765230362; c=relaxed/simple;
	bh=ezwhdrSqu/0G+UaIIAeRPOq3nnhylnnIfv6JIwfbsTM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GTxcaU+6Qvqvn4L2h1In2DvOav6DWouEzgtcRvXEIaE5IqVJfgAvGw04gcQqLQ/4rioyAtfZLndjaCGF+k4mKaPiIEyITP5b7nq058BxrI9mSqdz7vz+SiDMUIFR50rlbIuN0TOOKubo7ZRtrNM0nFKtcqiAC8+FND8P0TSYZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trW9q2KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE746C113D0;
	Mon,  8 Dec 2025 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765230362;
	bh=ezwhdrSqu/0G+UaIIAeRPOq3nnhylnnIfv6JIwfbsTM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=trW9q2KKHM6vJ6kbXTDcDFI6/na78YkSYF8jy9ixI6Cw1uVIx457DJQOz2vISuiHT
	 FVr+ddufFTQTihvhKN1+LOz4Dak0jHXJ30iugWlkksHpMI68DqxVsOWvbpAcuZPc98
	 ZcqBq+UgBlnbh0ZVTvWx8mzwkJNxn5MRpUKzBkfWoIrc9dtJuoyVErEDLKtA/h0yyi
	 dkt0Ew7OvADXunr/BcAPrxFhIk/xdGxCutP4EbVQX22JQwQU3F6V0PM7xxC4lfq1W6
	 UnGuJdpXZiyRVrP6PiXFs0lJBUEesRyfao2rMYmxJuNrXj6Z8Gq0vT/R9IWGih6x7i
	 V3BlZ1RVg5aWw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E1BA4F4007F;
	Mon,  8 Dec 2025 16:46:00 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Dec 2025 16:46:00 -0500
X-ME-Sender: <xms:GEc3aUTBNg8NwWqvUays_DXx3oNQxXBAuX3Ss-ilFfRjSdoEvtTA_Q>
    <xme:GEc3ack1MqrezKk0D4l-MCHq-ppDZzSAQYxvidRmpMY0I2dW_tcBnTDn9Aomk7dYW
    GET_r0sLWZMm9V3DBcm83fdKVFFLL-nmUpbhFQQU35YCzjpWBvIIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:GEc3aan-yRJCpRM8MohH1o7WneW7me4q4MNgsXmD0E-UJwUwyyX8BQ>
    <xmx:GEc3ab1hgkEf1wiQylffDuN5atKamgL81aBGnAvLxA1W0_ExnByhTA>
    <xmx:GEc3afT5zTDL4gdXlFIN7MLmsKArFWWLxP6SiPgbHX9zKxfhBRrXsw>
    <xmx:GEc3acyi7LuETfEqT4JQpnLUxHp-FVxjxb4HigLi0Mi_UZmxxy5MoA>
    <xmx:GEc3aXDp1xyqXWJyvXQFHhi3FoWQqq-FoPOYRgXmb6B1JTdXMgP6LlBp>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BFBE4780054; Mon,  8 Dec 2025 16:46:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A76hygnRXIHN
Date: Mon, 08 Dec 2025 16:45:06 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Message-Id: <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>
In-Reply-To: <176522973244.16766.13514511634601889702@noble.neil.brown.name>
References: <20251208194428.174229-1-cel@kernel.org>
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 8, 2025, at 4:35 PM, NeilBrown wrote:
> On Tue, 09 Dec 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> In NFSD's pNFS flexfile layout implementation, struct pnfs_ff_layout
>> defines a struct nfs_fh field. This comes from <linux/nfs.h> :
>> 
>> > /*
>> >  * This is the kernel NFS client file handle representation
>> >  */
>> > #define NFS_MAXFHSIZE           128
>> > struct nfs_fh {
>> >         unsigned short          size;
>> >         unsigned char           data[NFS_MAXFHSIZE];
>> > };
>> 
>> But NFSD has an equivalent struct, knfsd_fh.
>> 
>> To reduce cross-subsystem header dependencies, avoid using a struct
>> defined by the kernel's NFS client implementation in NFSD's flexfile
>> layout implementation.
>
> linux/nfs.h appears to be mostly generic-nfs stuff, rather than being
> client specific.
> If this change allowed us to remove "#include <linux/nfs.h>" from nfsd
> code, then it would be a good change, but I don't see that it does.

This change is part of a longer series I'm working on that enables
the removal of linux/nfs.h from parts of the NFSD code base. The
other two spots that need attention are localio and server-to-server
copy. I'm not planning to do anything to localio.


> Now that "struct knfsd_fh" doesn't encode info about the fh format that
> knfsd uses, would it instead make sense to discard it and use "struct
> nfs_fh" throughout NFSD?

Based on the effort I've already put into dealing with just ssc, I
think that would be a monumental change, and I'm not convinced it's
worth the cost.

What's more, it would move in the wrong direction. Stapling the client
and server implementations together by using the same headers makes
the code more difficult to modify without touching both trees in a
rather invasive way.

What I'm trying to do right at the moment is convert NFSD's NFSv2 and
NFSv3 implementations over to use xdrgen. Getting rid of linux/nfs.h
and other such dependencies is a firm pre-requisite for that.


-- 
Chuck Lever

