Return-Path: <linux-nfs+bounces-18103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A019DD3ACA0
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75BF83081768
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jan 2026 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615E937BE7E;
	Mon, 19 Jan 2026 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHIUYhRG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12A35BDCD
	for <linux-nfs@vger.kernel.org>; Mon, 19 Jan 2026 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833477; cv=none; b=IOe2yQnURp6O/tEQzTCZ8D0/WTY46mJPAEADQJ7Bl833lY/X4R5TCJ9PiF4U+Sz+fKK7r2icwi01a2sUijnYtWfkEsqphYVT2hR0PjkP5ddx310yEI3lJrQolUL1ldxYdCmLFlndpRva7xrcZCRdI8MDDTiHQ7zVTK4X56D7VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833477; c=relaxed/simple;
	bh=iIU4pivrb99XPex6iS4SIDLMh4eAmP+7YrfqxQZHbMU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nr3p2iMfnBo3rZ8qU9llITEYYQLeGty7+QCQXDByRkP8gZpV9FfkREaaiWbjKGsHRSzNfeCzb+4YZm8UAlDEVsbdBDlvZOVkzQoz1zFoVgWLhwSthGdUIoulU7vlAx+3YaqkeobABZ3dQwDuvTclAtHYztvXBAqYa3EirCplzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHIUYhRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B297C116C6;
	Mon, 19 Jan 2026 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833476;
	bh=iIU4pivrb99XPex6iS4SIDLMh4eAmP+7YrfqxQZHbMU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EHIUYhRGW8F/vYmOYU7GzEhoqxs0NMD84+NOs0/e76CjI3VIu9zZ9G0G/624ECUWz
	 YP0QGRvJQ5RfGV4ilEMOD7J7cy7MBXI9RADyeFYVk2GnQS0a3VUiqKKbo67i4BZ+gJ
	 S7mZlmNoP0kxmGIekY3vCpUMprH051VpfgAg3DrVOT/KnLBfba0EWSD33d3oJOgSQ6
	 hFYnn1jLu4/groWGpemUUdhlcvao5QRu8eyG8KqXEeEzzgG94cWoq06EPiLDMntwj8
	 QrwH9iBevz4Dprob9VvVkc+UjRW77YOePk8EpND1sR1tcxK2Pe3QAMw36CZ4/OAddJ
	 HjlvrRSlrwVcA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id ADE73F40068;
	Mon, 19 Jan 2026 09:37:55 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 19 Jan 2026 09:37:55 -0500
X-ME-Sender: <xms:w0FuaYd0t3KiJb2Pel2KewGMULqkzhW9JO6JctenshI8k-Iwz2uphw>
    <xme:w0FuaVC70AQb8-nexI2moDmNHdcMkqEe2We_afKMHJZoQV5gTyIzWuosx5bVGzyEB
    pyfxqxfIwTAwRzFdaWH-Sw-gQY4kiEGj9sb5PPV6KBZ8IT2XnvRDCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthht
    ohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrh
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepnhgvihhlsgesohifnhhmrghilhdrnhgvthdprhgtphhtthhope
    hokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhm
X-ME-Proxy: <xmx:w0FuaUDaiJbfBaMa0j_U1OqWcVcuG0kh5zWxISpvcPGajf2T3WceSA>
    <xmx:w0FuaSZAP7Y2ETiXECEqDwORnp17j268rlH6DlehFeavq1nhR4HzMw>
    <xmx:w0FuaUmPY1Ne5STr3wC0wFxJMvFWYbAODqhxf6RuuLcmgE457Mrn9g>
    <xmx:w0FuafoCnRaVn6H0OZp2I9r-YslL9ig1DWYsC-JA2XeWb0PIlkpaqw>
    <xmx:w0FuaeAZUARzdN-OMfKDd1Rp3LowwJ2ZnIPwtYvWRiff3J5W5YCj1Yo1>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D5B0780070; Mon, 19 Jan 2026 09:37:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJuicIy6M5dZ
Date: Mon, 19 Jan 2026 09:37:20 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Leon Romanovsky" <leon@kernel.org>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <b8001e1b-9cca-46fd-80fe-b8243fb74ae2@app.fastmail.com>
In-Reply-To: <20260119120311.GA23572@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org> <20260115155334.GB14083@lst.de>
 <20260116212425.GJ14359@unreal>
 <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>
 <20260119065212.GA1423@lst.de> <20260119102857.GI13201@unreal>
 <20260119120311.GA23572@lst.de>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Jan 19, 2026, at 7:03 AM, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 12:28:57PM +0200, Leon Romanovsky wrote:
>> > > I can add some code to this series to do that, but I don't believe
>> > > I have facilities to test it.
>> > 
>> > Please don't add untested code.  If Leon wants the P2P support and
>> > volunteers to test it, sure.
>> 
>> I can do it with the help of how to setup the system.
>> 
>> > But let's not merge it without being tested.  And at least for NFS I don't
>> > really see how P2P would easily fit in anyway.
>> 
>> Chuck is proposing a new IB/core API that will also be used by NVMe too.
>
> Hopefully eventually, yes.  Not in this series, though.

I can understand that P2P is not in the narrow scope of the
existing series. I have a patch now, but I'll postpone it
until later. Obviously it's not something I would feel
comfortable merging without testing.


-- 
Chuck Lever

