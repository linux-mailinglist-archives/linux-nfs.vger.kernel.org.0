Return-Path: <linux-nfs+bounces-16589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC0FC71695
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 00:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E83E34B267
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCE244684;
	Wed, 19 Nov 2025 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ROO4/vr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsE5qoDH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84956327C15
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593382; cv=none; b=HN3RXHGoHBeeXDpZG29QON8WySYRcaWAIXKAGPzNYVGpUy6wsSgeZwCVV9iADWfCoixu6Wo4us8lspAkLZaioItTGvDsJ/oTCBHalv6Eh6EVM4sYoikhEibBBLDhVGm5UGevY+1/5boK3YOuraeMhdmVCL+2wOhi5jN6CezqTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593382; c=relaxed/simple;
	bh=Awie/KRO4E/EMMZ7IZgsSS4vLR4YN9gkfbWp/feWrzc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LmIq9Fe5xMzSOw49Yo9Oey+moSE2jzUgDd0WuzaqsWAlVegwXofPzkG8y3u8hmFuums7CYTUYeRBJy5ZlX91Dd38KSZLEbRhryuLrifGiEqBTaF72iLYZsbCubT8dttHhraHkoVePW0cJfvP5CjdsX7HQdf3fMpRork4BooXQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ROO4/vr6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsE5qoDH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83F25140020C;
	Wed, 19 Nov 2025 18:02:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 18:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763593379; x=1763679779; bh=opUOZRzsAwiviTZNIHb7/sPHMVRgiVE/Px2
	0Gav3eEs=; b=ROO4/vr6JDmp36qYmw3Fxo0GC+dyppGyJtGMx2roRRM2z8IQycB
	OYN/zty/hwq4iPiJCZcN3Z+f0BIxwzD1tHy+55r1pkIvVJsf4TqX3YajujoCSkzX
	nVXptTpLyPinFTZMj09ZCB16+ayepos6BfTYzoHbIYcvfQKmJ5xHgqzSWGNFw/pp
	ZMM55aUQjgLNdXaSY0ISd1yKNyW2i2TdcXKuu8lp0l4+cEto8iiwULUtChcFeDho
	qMvgkrLa+2hg4sW6UStWFQuHyxFcP1J/2Nz9OsJh2Z6yiQzw1xkVLJKU11Yzzn69
	qfoMShTfD2m1Gd2Ux7CNAsfkomqrLBzJpqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763593379; x=
	1763679779; bh=opUOZRzsAwiviTZNIHb7/sPHMVRgiVE/Px20Gav3eEs=; b=C
	sE5qoDHDcApLQVKlfJ7s6VikzipkokunN80CQv60uMZo0fG74e1gB1Y4zfeRDvth
	KR1mBK2wWs31ssHhSKLOEhPzJecWXKQjjj33zZ83xKfjv7ezrBmEQoZ1zI0/RJyM
	/ER9AmTMyPrYchrhMFcqh/Q2klRxZPx6L2L8zUHqgOfgEBeYXcnkJx9NpInuDGP2
	zWM3XEb9IP6Wfvr1he6Ubj55wSsh5xcjXMJPLUJ99SSHmsHfLlfFoabwZWGHvf08
	dAbFUU0p4WG7DvlayVvluFquncgqOLR0Mh1Ew0c6Dp4n8cRy4BQRcCLcCAXOACMI
	a8bD+BGEYasFjbMuG+5/w==
X-ME-Sender: <xms:o0weaS0skdmhsGDCcUQR6MxPHHs8EXcm5at6B-e6XfKHKLV2DLJFgg>
    <xme:o0weaYx-bccSvyxE6P3lvqVWTIHOnQyVjJ1o-XNR_K5JYWlOiPA8k8T42JduovhQy
    YTqzec_Gv-AfMjFN0dDdz-WQE0u91FXxYLLVuzH-19IXrRJqw>
X-ME-Received: <xmr:o0weaUsEJKNhwv4gqA4pheDlFkHVfiO9QLG29a3bO2zafDiYapCeHxDbicsPoy4AUt3PCQmztpqaJ4SgDWe1bS2BXMiuqoQwJ139B1keJEBt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:o0weaaylQrUVf05LJeXZ4kGkAuY_Apyi_7QNp_vFQa_WI7pVO8PDWQ>
    <xmx:o0weaXDhPldT7c7aodvY77LaKvJGPoedJrSxLsC5JwTnYAjyA2cTpQ>
    <xmx:o0weaYe7wCbPy8dSbfd3WHZ6yFYt4tg2hjJvK_mSie0pbfSg-givpw>
    <xmx:o0weaRmZB6mtvUIXqi-GK99KOjNRUcDAIatuDDtA-UD-kOlCxXIl-g>
    <xmx:o0weaYUXTIe61-AwDGm9aDYh7wkHBmOgmUmem7zMLqEn9PTbE1U-xxSq>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 18:02:57 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc/cache: improve RCU safety in cache_list walking.
In-reply-to: <f7701fcd-c71e-4d51-a36c-f99cdd981bb8@oracle.com>
References: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>,
 <27844685-0132-4f65-b8cf-3ea058d783ae@oracle.com>,
 <176082518104.1793333.5226398922398910122@noble.neil.brown.name>,
 <e33efa39-2a6f-4724-8fa0-bf881dca01a7@oracle.com>,
 <f7701fcd-c71e-4d51-a36c-f99cdd981bb8@oracle.com>
Date: Thu, 20 Nov 2025 10:02:45 +1100
Message-id: <176359336575.634289.17426520458835763022@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 20 Nov 2025, Chuck Lever wrote:
> On 10/19/25 11:01 AM, Chuck Lever wrote:
> > On 10/18/25 6:06 PM, NeilBrown wrote:
> >>>> I was looking at this code a while back while hunting for a bug that
> >>>> turned out to be somewhere else.
> >>>> I notice point 1 and 2 above and thought that while of little
> >>>> significance, I may as well fix them.  While examining the code more
> >>>> closely as part of preparing the patch I noticed point 3 which is a
> >>>> little more significant - clearly a bug but not particularly serious (I
> >>>> think).
> >>>>
> >>>> NeilBrown
> >>> I wonder if this patch should be split for better bisectability.
> >>> Are the changes to the *ppos calculations dependent on the RCU changes?
> >> There is no dependency between the various changes.
> >> Did you just want the *ppos split out, or did you want the 1, 2, 3 also
> >> split apart.  I considered that but wasn't convinced it was worth it.
> > 
> > Ideally, since you had listed three items in the patch description,
> > there should be three independent patches. But if you think that isn't
> > worth it, I'd be happy with the *ppos changes in a separate patch.
> > 
> > 
> 
> Following up...

Yes, this is still on my todo list - thanks.

But given my recent success rate, I'm not going to rush it just now :-(

NeilBrown

