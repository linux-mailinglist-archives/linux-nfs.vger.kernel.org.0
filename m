Return-Path: <linux-nfs+bounces-18049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C20A3D388E3
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A3FF30183A3
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F9306B0A;
	Fri, 16 Jan 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxFyOg5l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A02301004;
	Fri, 16 Jan 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600179; cv=none; b=JhR31dM3h6mKeI8vy8o/dxm/3W2Eopc59oCuRmHvHNJi9ajoYMYauVaPOwCE3hn69AdClGqBrolvCN1WAjVWnJdDWHrURg1xs5XDfZOzW4lXxgBBlw9ciYDf3IQHBtwEx4rKpYNzQTpVD67lfN3ggrFGi6DzvF28EKXDTXRtJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600179; c=relaxed/simple;
	bh=V4Z1YjzfcfPOXECNNLD7426cyFb4hwdvDUWsIjkBzCE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gERgv4JGmaJjsyDDJ9lH7otqVTwa0zi5CiK4HW4aMZATNEVh+aSgWsy54aTnoonTta/AF64jVZ5HKnVsW6D/l+HStikTzn9pSfh4i4RiI/nLJm878ccsws2bWF/KWOkqRiJXRcp4Hv/M2zx2zyXpufNXGfofjDSYM3JnhhLwkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxFyOg5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6E3C116C6;
	Fri, 16 Jan 2026 21:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600179;
	bh=V4Z1YjzfcfPOXECNNLD7426cyFb4hwdvDUWsIjkBzCE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CxFyOg5lDcPZ5dSLU1tp5b9KgetLhlLMJ1/Vv1L6ErK24+h/JjTpgl8mM01BpP+Pw
	 /k7E4V4mJMpupfmMLqDY3q7tn82sdKYx18P9LyijbHnj4p2VfENTH8rR7yjgyeTFpG
	 8pFeyoCKmhonSKAUu+zPunmGbGgtdI5lqsBRN9SfhyzutPsTwlwhUSs0mfzSUovfYZ
	 b2Mkt/nR74H2q2cYjZnsF+aKQa0YO0zaDTISabFDY31tgYhlxEL6N53nh1AKowaAe8
	 Wdv0SwANZFd3f5xduNFePAeGPsheDBhM8g0eBGu8I8I5Q4aUEVtOfRV8uxDsHG5q4o
	 kQDUE4K8SXkRg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 87C81F40068;
	Fri, 16 Jan 2026 16:49:37 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 16:49:37 -0500
X-ME-Sender: <xms:cbJqaYlRdQeZYXpMkEYLvgQob_mDgyHUzlPIGAavOpzm8Q8ia38anQ>
    <xme:cbJqaSqhD2iXZye4kUAtogeNvRpUkcjnR9muqcpkc0CZLQrSC4hpznKLRf6qDdb3N
    JBgqmLJQAXMBVylv-aW3hdYYvByCLSq2vEQJcTil9IOyPoobCXVF5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedttdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cbJqaYKn2kyhRdqYb8ZDLF-N_f2V7I8I7bDm1KUpwksqZRq_Wq6C6Q>
    <xmx:cbJqaUDxVEra_CFnqOTU4EzEpVKnLjLPzKmjFIRIsc-4F0Wtu07eyQ>
    <xmx:cbJqaVtTta1aneAL1_TMmfgXRcNKQMou5lLOns3wxAZEgwnRkx2rGg>
    <xmx:cbJqaaSqLV7z2T0cQP32Q5Kmf6ImCrHQDp5DNPkERZqVqMbdwsZw2Q>
    <xmx:cbJqaUI5QnATgImkq6REZEzM3msBZj3w1nt63qZNkkYOSPR7WBa2ljru>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 672EB780070; Fri, 16 Jan 2026 16:49:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJuicIy6M5dZ
Date: Fri, 16 Jan 2026 16:49:06 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Leon Romanovsky" <leon@kernel.org>, "Christoph Hellwig" <hch@lst.de>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <bad1a0d2-6408-4d0b-a421-f1e35265ac28@app.fastmail.com>
In-Reply-To: <20260116212425.GJ14359@unreal>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org> <20260115155334.GB14083@lst.de>
 <20260116212425.GJ14359@unreal>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 4:24 PM, Leon Romanovsky wrote:
> On Thu, Jan 15, 2026 at 04:53:34PM +0100, Christoph Hellwig wrote:
>> > +static int rdma_rw_init_single_wr_bvec(struct rdma_rw_ctx *ctx,
>> > +		struct ib_qp *qp, const struct bio_vec *bvec, u32 offset,
>> > +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
>> > +{
>> > +	struct ib_device *dev = qp->pd->device;
>> > +	struct ib_rdma_wr *rdma_wr = &ctx->single.wr;
>> > +	struct bio_vec adjusted = *bvec;
>> > +	u64 dma_addr;
>> > +
>> > +	ctx->nr_ops = 1;
>> > +
>> > +	if (offset) {
>> > +		adjusted.bv_offset += offset;
>> > +		adjusted.bv_len -= offset;
>> > +	}
>> 
>> Hmm, if we need to split/adjust bvecs, it might be better to
>> pass a bvec_iter and let the iter handle the iteration?
>
> It would also be worthwhile to support P2P scenarios in this flow.

I can add some code to this series to do that, but I don't believe
I have facilities to test it.

-- 
Chuck Lever

