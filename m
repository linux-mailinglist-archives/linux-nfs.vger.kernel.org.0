Return-Path: <linux-nfs+bounces-17950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D993D27BA9
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 19:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AECD53065975
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4F3C0080;
	Thu, 15 Jan 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASQojbZP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE22D948A;
	Thu, 15 Jan 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501812; cv=none; b=fkcLXhuEr5QHHQaQeP6hPtYJUvt7C2wVEUO+GgIov9jV98MMvSYehbk9JR4IxZS7fJQwEe1/5nCq3vib1yKwfzklNg5ijstUQsGtQnuPFXqy4c3FKMC67QVRnACueJZHsCQhkdVH7q/4w8B7XFtfjBGUdXl3bwFFy6OAgYhaEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501812; c=relaxed/simple;
	bh=D/cyD+UjPBaw5gPSvQNi/7c1SdeoE2VveN1I1UXAVBo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=STIPQ3vSXs+t8boWfmSB+vUKz3RKqwRYuJ16ELOpWfPvWCKqGhWn52B/Lbjo169jGFJvkiYvu4q/bcvU2uqRrKsBZa+LbuFdGuXTfJVFsObCrqAoa76uj2tsf/bCS3hurLmCGelva2GnPpKS+nVdecRm02NxUdUyFsf+R9oCYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASQojbZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E04C116D0;
	Thu, 15 Jan 2026 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768501812;
	bh=D/cyD+UjPBaw5gPSvQNi/7c1SdeoE2VveN1I1UXAVBo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ASQojbZPxfa8rtYN+qckEbufJvSlgPd3rdWRAtno9nCX9LsDJiO46YUIU++xOtNxd
	 bHri3X7o9gPC24bG6aEgKJwiQMmo4VzbRO0MMmA/5ThIw2lpA23BnZVpY7oeCISJ8a
	 rLJVzmAoZuzB6XaAa8jhtN89Lq0FO2EBK5VVkuYZbai5EvcCAshkjkWNG6j9c+W4Bm
	 eHssSsJ7QTHmIXFUSob3aMyvmNHNkJzdSj4ooeTDiODDeMl9KS8kf1Jn32YM/Jrqc8
	 DiftKDiMyfvTZHAwyU/FzRHQVJDRZhf4sY8q0DtdVX/0dG4jbDP9JAH/vNJ7uF9+Kw
	 5aiJhN+9eB6nw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C3217F4006A;
	Thu, 15 Jan 2026 13:30:10 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 13:30:10 -0500
X-ME-Sender: <xms:MjJpacDzWE66h8HQ61g_NmEzskrnf1VSLT780nvGM3OrHsXMBp0jAQ>
    <xme:MjJpaZUcbVftJBHKvRNV1bbg0xvUx0lt33LmJtsKeTuOo1M4jBnh0djk6sfVgRUFP
    cGPPH_Jjh1ggU_NAtt7sBoZVUgPamY0vWqk0htQjzlGjifpZt883kE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeijeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MjJpaQuS4neq3Xe55V6KggiZeZTFndTNE4Eoj2xto6SjGrbTIZKhgg>
    <xmx:MjJpacornZZr2neYxTXK5y_mKqgYUHc9NUAXJeK6ZUkT8R1t_8hlEA>
    <xmx:MjJpaeeLrJ1yCJ84OP-Zn_YDukDQBwmSK9m1aWOcxaccjmzbZfKFUw>
    <xmx:MjJpaclUbju8burk9DPlozF_3Zfob0hvh09v5qKNMj3LsXXzDZx7Xg>
    <xmx:MjJpadbsIBiEXaqQIA4H6CdUTPN7ydLVuTucQ2dWOyR5rMOqKyjnPT_F>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A2B93780075; Thu, 15 Jan 2026 13:30:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AytU4w2KIidk
Date: Thu, 15 Jan 2026 13:29:41 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
 NeilBrown <neilb@ownmail.net>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <e85b5f0f-dbe1-4b4a-8e1c-56ecfe5853ea@app.fastmail.com>
In-Reply-To: <20260115162929.GC17257@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-5-cel@kernel.org> <20260115162929.GC17257@lst.de>
Subject: Re: [PATCH v1 4/4] svcrdma: use bvec-based RDMA read/write API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jan 15, 2026, at 11:29 AM, Christoph Hellwig wrote:
> On Wed, Jan 14, 2026 at 09:39:48AM -0500, Chuck Lever wrote:
>> The structure size reduction is significant: the previous inline
>> scatterlist array of RPCSVC_MAXPAGES entries (4KB or more) is
>> replaced with a pointer to a dynamically allocated bvec array,
>> bringing the fixed structure size down to approximately 100 bytes.
>
> Can you explain why this switches to the dynamic allocation?
> To me that seems like a separate trade-off to bvec vs scatterlist.

The current implementation keeps a "default size" SGL in the
context, and chains more on if a larger SGL size is needed.
This keeps the size of the context reasonable while still
enabling large requests.

For bvec support, there's no concept of bvec array chaining.
We always have to allocate the exact size of the bvec array
that is needed for the request, otherwise we'd have to keep
a maximum-sized biovec array in every context.

Now, I suppose that later on we will be able to adopt the use of
the rqstp->rq_bvec, when the full NFSD stack supports biovecs,
and this allocation could be replaced, at least in some cases.


>>   * Each WR chain handles a single contiguous server-side buffer,
>> - * because scatterlist entries after the first have to start on
>> + * because bio_vec entries after the first have to start on
>>   * page alignment. xdr_buf iovecs cannot guarantee alignment.
>
> For both the old and new version, can you explain they have to
> start on a page boundary?  Because that's not how scatterlists or
> bvecs work in general.  I guess this just documents the sunrpc
> limits, but somehow projects it to these structures?

It's historic, and probably related to the sunrpc implementation.
I didn't question it when doing the conversion, so I'll have to
try to remember exactly why.

-- 
Chuck Lever

