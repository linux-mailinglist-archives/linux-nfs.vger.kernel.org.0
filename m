Return-Path: <linux-nfs+bounces-17967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDCD28E8D
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 22:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED86A30727FE
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D6A32B9BB;
	Thu, 15 Jan 2026 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv7Q8I8w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAF3191C3
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768514034; cv=none; b=Ry+KrXDsyQSszQMs1vWFkGFgE/oS09+9oHNA8ttzW7oRomlVYcLhyuNBfDvZ4/cbEwXAaT6UhYCa5hQqNSq/9peWhEZRsjzbTMoNZaOruPW16CsGR/x7fsM9XlKqbE+zIvJHUc0qnRr/tYxJxlPbgKzn8s4zBiN9MRqAs+zOTbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768514034; c=relaxed/simple;
	bh=ziqJB/fhwv78zYQ2tamt/EB/9Di22lcX/GNWwBm01c8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S/R36MLvyt+udXy9TcnzXI30Y3+UldKvDP5ZQt/WAWhkPodPs2xLriCwp+TfpTjo2jSbn3UaPfwc6maJUX/eDTzW+9oJtYay1J/M6YE/rLghu0eDMEQRzMHMJ/9iPlg9nSGoNSr7WOV+qWg7/8txjfDpFRDI5tOm3Ai0FujbjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv7Q8I8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3284C4AF09;
	Thu, 15 Jan 2026 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768514034;
	bh=ziqJB/fhwv78zYQ2tamt/EB/9Di22lcX/GNWwBm01c8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dv7Q8I8wpHInP+n8CzH3RU7dXEuHG1BEaubxQ1lzPvmTviy6+jX3GoeTha6Q+Q6hz
	 eXSsiaBC5iq+gJIlCSPltgqNR2Vdxffci9PXtJNi2bsq7zd7M6dE6FWJrB+1uUHPPD
	 gof3VJwYPwmnLO5pgh20Wm8RqXl22VzZZckFXxcF2/CjDtWW43Y3eUlr7Bpr56kCt7
	 1ipA/RNYPFRxF/ukC1h64bTT6Sgv+d4JQD8QDMXYX8IytzbURV0LIgqkNqOJkkAJrX
	 +DXvEa7ZBMFGf4G0rNLIiTLqqj0kDZaQ+DiU2XwDSQKMI3ruvDbjWyX1972Lk+KHK+
	 UzjkVjZuFaOqg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E9C06F40069;
	Thu, 15 Jan 2026 16:53:52 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 16:53:52 -0500
X-ME-Sender: <xms:8GFpaZT1c7bRv7__cG0c8LcOEeHwiM9-wLrMkSj8ylyJ08_zNvbmEA>
    <xme:8GFpadlbAXaoesxW_iRadj0Nz0oFIgeKV0ceyfPF_vEC-0JZkS_oVfaRpXZo7CRYf
    rvO49v_D5OS1sf084wBIYQtpPeNhv5yuxjSlRL3PNozASakpCv5NGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejudelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8GFpae2Eh-VxKb6YfavrOX779bS0oURLO77NWIm6zJGNeAbNrFUBtw>
    <xmx:8GFpac9ZgYMnuu_4c0PTdSM4h4SqFxFcCfCABi0M19FxKDTq3BnTjg>
    <xmx:8GFpaT5SYlEby0dDKAEDJqr_7CF4vezdUFLpfu1xNYzHdNSopezKKQ>
    <xmx:8GFpaUsjGk9suwY7HLzB51SJ8FJO7_XCNvcPNg9bYJ2r407DEbY-hQ>
    <xmx:8GFpaV2iS4WBO77SNHZVxlIdJ7MtmzmEHreecnuBiGBZr0QjA6vOMwah>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1966780070; Thu, 15 Jan 2026 16:53:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AytU4w2KIidk
Date: Thu, 15 Jan 2026 16:53:23 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
 NeilBrown <neilb@ownmail.net>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <bdcf6391-5d92-4bec-b351-f8fe75b1ea43@app.fastmail.com>
In-Reply-To: <e85b5f0f-dbe1-4b4a-8e1c-56ecfe5853ea@app.fastmail.com>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-5-cel@kernel.org> <20260115162929.GC17257@lst.de>
 <e85b5f0f-dbe1-4b4a-8e1c-56ecfe5853ea@app.fastmail.com>
Subject: Re: [PATCH v1 4/4] svcrdma: use bvec-based RDMA read/write API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jan 15, 2026, at 1:29 PM, Chuck Lever wrote:
> On Thu, Jan 15, 2026, at 11:29 AM, Christoph Hellwig wrote:
>> On Wed, Jan 14, 2026 at 09:39:48AM -0500, Chuck Lever wrote:
>>>   * Each WR chain handles a single contiguous server-side buffer,
>>> - * because scatterlist entries after the first have to start on
>>> + * because bio_vec entries after the first have to start on
>>>   * page alignment. xdr_buf iovecs cannot guarantee alignment.
>>
>> For both the old and new version, can you explain they have to
>> start on a page boundary?  Because that's not how scatterlists or
>> bvecs work in general.  I guess this just documents the sunrpc
>> limits, but somehow projects it to these structures?
>
> It's historic, and probably related to the sunrpc implementation.
> I didn't question it when doing the conversion, so I'll have to
> try to remember exactly why.

These are contiguous because the xdr_buf "pages" field is an array
of "struct page *" pointers. So these don't have per-entry offsets.
There is one "page_offset" field in the xdr_buf that applies only
to the first entry in that array.

Therefore the payload buffer starts at an offset of zero or greater
in the first page in that array, but after that, the buffer continues
across the boundaries of each page from offset 4095 on page N to
byte 0 of page N+1, for all N.

The comment is a little misleading -- it documents an assumption
that is due to each entry of the xdr_buf pages array being "struct
page *" and there not being an offset field for each entry.

We can certainly clarify that as part of this bvec conversion series.
And (much) later on, when the head, tail, and pages fields in "struct
xdr_buf" are replaced with a single bio_vec array, this issue goes
away completely.

-- 
Chuck Lever

