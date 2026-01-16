Return-Path: <linux-nfs+bounces-18012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 564ABD330A8
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FBFD3018D76
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FDC335541;
	Fri, 16 Jan 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvqrtzSZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE5288C25
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575512; cv=none; b=fmnI3mpT0k7Sy44bgIAd2hkRHRgkHEdfV+USgi4zdb9nzahVl5yGrdPIikPny457ljBhWZ4ecPlHFuBNuEchoZYh7CEfAvPzX7sEtLrjSW5dVabcwILOkZqpdBJBHvYgKGrT/wR2Vx9ZIzq8AhsUa1mxFOC5t0acpU2Ink42z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575512; c=relaxed/simple;
	bh=zds2+Imn+qxToQHLavCojXaVLGoJQxloN7i8hAnWuhc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BxjxMzCPWV4VhbRXvihSTbgzK3h2ujL3ztyEXzI5Z9Waguma80gKp7cS1FsqKNBxXwhcJUK84FRrrw4gnVpedRf09tkBgV9L4s4hZuYWorGsb6FpUoZwOmPjNCylzW5N66pFC0RXlsV1c8nTNap664s6v8U5dWLNBzU8+Y1voQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvqrtzSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0F6C4AF0B;
	Fri, 16 Jan 2026 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575512;
	bh=zds2+Imn+qxToQHLavCojXaVLGoJQxloN7i8hAnWuhc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tvqrtzSZUhLq9yuOsOTmtw/tAMzksSaCDcCW2dCbsgMiFXc6AluCCENzXxpURm4W9
	 L5evyzrAlUdUt34iruIexz8GGb56LucF7uv8ldzzls0r/udVauTEKdVUstJw3z/th2
	 u1TIM/KueQtsk6C/eqUlelaSkvxv7M4go2FaGjgGRRvyI8MuycRCxEhHB4PwA9I5yk
	 OFVHYm3n1b74CPme+4vfOythd8l5P+1Ay5HwmSOVKjrNlIhI9TsFdMkLoOSSf3ygMk
	 goOARXCbrSS9kZK7tE+qo95f58q2IIZis4hwwsa8z8RdWcMlql8eHMrJXVl9XJ2VC9
	 B6AhTiy4b28Gw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D53FEF4006C;
	Fri, 16 Jan 2026 09:58:30 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 09:58:30 -0500
X-ME-Sender: <xms:FlJqaaaL2qjgmo2f8Zp7hRtbzcxRBpUSXeXmO3js3hKJdegC8ncXQg>
    <xme:FlJqaYNtG8tnJgG7Z5kylNdwe2CtNUdxYY9aJvC55PF2tcu52P3AO2QSIxbj-EjWX
    kHADkzKCnH3tLw3yOh5uSSHYrytGXkALLitSPetOJGkoOXIyIXb6Cc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelvdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:FlJqaT-tAy6245Qb-52oUDch5UPFdHghSyqj4a1NbxHlQG12Oqgl2A>
    <xmx:FlJqabkwMDQfVpymJBC2bzdCFAiW1uBAX98Rk91tjx0fGNocUxScOQ>
    <xmx:FlJqaeAPoqyc7VZqS2Jx9HJTmfkbqll2CcOWKHBWfc9h2NP98_Y1ag>
    <xmx:FlJqaUVt9boUey9E3ghRKj5l4WBY067cgKut7JQr8qGxTnHE89_YSw>
    <xmx:FlJqac-9mHQZIVhjplvAkRjdB1gTM8R1p81Hx1Y45HqD11gh6KmLOR9p>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2073780070; Fri, 16 Jan 2026 09:58:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJuicIy6M5dZ
Date: Fri, 16 Jan 2026 09:57:57 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Leon Romanovsky" <leon@kernel.org>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <19c34c0c-5391-477b-892c-00ab124e543b@app.fastmail.com>
In-Reply-To: <20260116145206.GB16842@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org>
 <20260114143948.3946615-2-cel@kernel.org> <20260115155334.GB14083@lst.de>
 <20260116113310.GF14359@unreal> <20260116145206.GB16842@lst.de>
Subject: Re: [PATCH v1 1/4] RDMA/core: add bio_vec based RDMA read/write API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 9:52 AM, Christoph Hellwig wrote:
> On Fri, Jan 16, 2026 at 01:33:10PM +0200, Leon Romanovsky wrote:
>> > Much of this seems to duplicate rdma_rw_init_map_wrs.  I wonder if
>> > having a low-level helper that gets either a scatterlist or bvec array
>> > (or bvec_iter) and just has different inner loops for them would
>> > make more sense?  If not we'll just need to migrate everyone off
>> > the scatterlist version ASAP :)
>> 
>> I had short offline discussion with Jason about this series and both of
>> us would be more than happy to get rid of "scatterlist version".
>
> nvmet_rdma_rw_ctx_init is used by isert, srpt, nvmet, ksmbd and
> the sunrpc server side.  I don't think any of them should be
> super complicated to work, but it will need a fair amount of testing
> resources.

My preference is to keep the scope of this series narrow --
introduce the new API, and add one consumer for it. The other
conversions can then each be done by domain experts as they
have time.

I have no strong feeling for or against eventually removing
SGL support entirely from rw.c.

-- 
Chuck Lever

