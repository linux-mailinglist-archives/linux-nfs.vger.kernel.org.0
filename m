Return-Path: <linux-nfs+bounces-17751-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B94D13437
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A86306CDA2
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F12701CF;
	Mon, 12 Jan 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZknK8K1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21924BBFD
	for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228700; cv=none; b=IOPtswTVYvWAo0jVo/6zBLUZ3TCEFUkpV0eEjZpUwlhlBPwXaS4UUwJiKWEkldcZm1PloTaGWl4HmEyDIBhhdm1o42DNEYJbeG120DcWBZPNvCUxfcDz5pebKPiR3O5+JVcvU0kUPcaK1NN49tO2lluYREHL4rYAsK9xj8GLDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228700; c=relaxed/simple;
	bh=rKLvcERsBJ4zpdksZXzLU7auq/Wn8M6LOBhi2U8GWYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0dVuKTxcZayj1EFPEukAkOKVUxPR7hUs2VT6phAVqLP3KLrVrFTEA05OtOKcfuXcg7BLChg1LB0rqp+Eet5TaIfP2w+rBbyt4mZrQy1KyO78avFxunLtlkbWyciTBflyLiOyjI0DsMeMsPaYHN702rcebUw3ocBN6IrP/0b6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZknK8K1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E91AC19421;
	Mon, 12 Jan 2026 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228700;
	bh=rKLvcERsBJ4zpdksZXzLU7auq/Wn8M6LOBhi2U8GWYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NZknK8K1hewsUuSF6mTjMMfDvF8rmFXVnZ+4jpro5YuP0oxWGmDJwvPOY0xcKvq47
	 fbPC0sXhqIq3RmbfeJd3oARTHBD2SEk1gtS865Ghrl66iKBtwBSj9pKceWQWf62oki
	 dcwtGb4FmBwN31Ha6gxmoIH+yF9V95/QaVGgaAtV1fFVweAB56fpXH5zmEgi7NMzM+
	 Cqgbjhv1C587BWWcjqtAj/Pdgqzk6JzjDh2+FcAgOgUlvI5duFpI2cXWJoVbHTZTzZ
	 Vy2CjL7zPkLIMiZQv7Hz+0aZacdn3Kj/GjcHTRwxkWt/omBIpGCh3RUgz7SbEMqYn9
	 Y5XiZOso8TqMw==
Message-ID: <ffebecde-a979-475b-a838-6b17df4d33b7@kernel.org>
Date: Mon, 12 Jan 2026 09:38:13 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] NFSD: Add asynchronous write throttling support
 for UNSTABLE WRITEs
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260109215613.25250-1-cel@kernel.org>
 <176802301025.16766.5819430775313248993@noble.neil.brown.name>
 <63566a53-ed5a-4c0b-920d-22219c750354@app.fastmail.com>
 <176808109160.2462021.5788018456330144196@noble.neil.brown.name>
 <eaac3112-eafc-4bc5-974f-752edf868788@app.fastmail.com>
 <176819131921.16766.16091990973366244227@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <176819131921.16766.16091990973366244227@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 11:15 PM, NeilBrown wrote:
>>> What exactly is "the memory problem"?  Do you have specific symptoms you
>>> are trying to address?  Have you had NFS server run out of memory and
>>> grind to a halt?
>> Review the past 9 months of Mike's work on direct I/O, published on
>> this mailing list. Hammerspace has measured this misbehavior and
>> experienced server melt-down. Their solution is to avoid using the
>> page cache entirely.
> I didn't pay very close attention but I thought the assessment was that
> adding lots of single-use pages to the page cache, and then having to
> clean them out later, caused a lot of unnecessary work that was best
> avoided, and that drop-behind addressed this.

Drop-behind is too inefficient to be used here. This is why direct I/O
is also an option. Direct I/O is measurably superior to drop-behind.


> Are you trying to find another way to address the same problem?

Yes. I don't think we can backport direct I/O, for example, to LTS
kernels. I expect it will be important to have an alternative to the
new I/O caching modes for this reason alone.


-- 
Chuck Lever

