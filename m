Return-Path: <linux-nfs+bounces-15871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B79C28C68
	for <lists+linux-nfs@lfdr.de>; Sun, 02 Nov 2025 09:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EF1F4E0614
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Nov 2025 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E5137750;
	Sun,  2 Nov 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DeYW9BTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NK+CpYI3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287E259CAC
	for <linux-nfs@vger.kernel.org>; Sun,  2 Nov 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762073782; cv=none; b=blZTZKhM4AaP10q1/iaX3xL3gUoaSnLqnlznqe5QpAFmYSj9WAyURNsf3+LfQeW0pbmTyl8Iwxr/ksVzyPLCf8lGdwLUITcrieSmb4FgjXLaSY8dnOUXw9oeXk/txt1/iU3foB/x8Ezy6yr5O2QegoN54MELbNQOEIDipP69BCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762073782; c=relaxed/simple;
	bh=YcBFb7tqsps7JL+zqIxjukRouQvS/8t0imoGOfEEwmw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZiJxOlMo/Iigwa93q0XvqNuSxswioUM7VyRbDxroscBoF3uNbiOE0RLyjDKeiddC3X17bx2Jnm42y8kxuC5OrdcH8aqlxvBrbJduz98pMcHURER4PJCSJurBao1QqzdWO3BNGQmaa92kl2dyBOqdw/F3vekrIFVnISBSoLQdJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DeYW9BTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NK+CpYI3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BCFF1D00157;
	Sun,  2 Nov 2025 03:56:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 02 Nov 2025 03:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762073779; x=1762160179; bh=o3bfEmaAQ93LcO8ZRE5hK+0+zQV8dSDYgAT
	4/mKE+sQ=; b=DeYW9BTEFD14+TjiLAe2ee1FvH7YU4S27mwJrhyS2ZCz6/sAH/b
	lgX6yh1UEaYyOQTHxbTiKtu+27/B2PcKA5ki3sFoiSJvkAN22TmvQ08ZKqnZiRtI
	UfJmEsE5fKaYtruTLPnXBYIrJ+lsSQsO1mwGIZZ5t5iZ3WzLdNIEsBQnbWK6DepB
	V8qzWfebj9KXeiniHxh3FsMMsPtjSlNUSE7nN6i7tzLbWi0kR93XaKwkQM0AmFjK
	w7LBOM0+xScUGOk/LC9IgFVp5TPzxOWZMgkOlK83x0xccZNg2y3ewGoJG/k/7TfM
	UZ46uOfajO/s29LH3W5dQw7CXMlN0jqPXbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762073779; x=
	1762160179; bh=o3bfEmaAQ93LcO8ZRE5hK+0+zQV8dSDYgAT4/mKE+sQ=; b=N
	K+CpYI3+YRuI+2mDzs1BCYj/FwWDHHBk5Z8U2m0z82I/nPgf+HBAAFERd3vdZDr4
	Ru2rpALJgVsIIvTzPUmtxWDbtrYf86gqWGAh3BKeDZPpk/Xuu09bTNtHZ398sREN
	KrXfryIgZQEKoUfGeP/qLeTFBmPk3ktkMW95HiHyUyls0QlCaoY6XdhimuFvldc9
	MduzjJ0ycADXKGwiBR+TDsk+kTqnifRu4fBKMAzQwg5PGZWYVkK7KKI0GsgqvyGL
	JIZqJzOhw/s1a/IWgrUzznAnXW2HgZguc5F/miOdnNf6pIZD2qmeo7BQl9J7VpT5
	Q9YbFyvbq9M3161poj3DQ==
X-ME-Sender: <xms:shwHaU4DzaOJpbo3NQvXZIx3p-WOGT5tDEqgLn-2YvUY-W19A29MXQ>
    <xme:shwHaZm9m5a2e7_bQUV6g-yGuaZrC2jsi-QLwETGJhJSR4ghEmiggIPUt7qu6Cgwz
    GG0iY6p5_OeFn_TLmANaYXDhizYDSl4WjrTRK2j8R_R9Oqn5g>
X-ME-Received: <xmr:shwHadSKdszwgvot-9OIStDsoqf0SnLEgr90khaYjWr1wUJAN3qSV8i0zOyXaxWBj-FqL2CDQqNpfDwglF-Z96VNthpVkHLh7jpsoH_Dz3D9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegkeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:shwHaQEEkUYlUoL4eGK-LAOTqnw-I9AtwsOQDV05l3Xa4p40_8tRBA>
    <xmx:shwHaaFpuUqlRwSCbP8Mg2D8w1noVN9QpclE9i0JNvgcBAqdEZZVMg>
    <xmx:shwHaWS-dPPP2Wli9s3zUSb5yGgbD1angVHVZ-eUM520GAxLEZxnfw>
    <xmx:shwHaTJf-9W_GvEcmiGIUx_6S8Wypj08JQBOZsMZ6EjctwCvBimnmg>
    <xmx:sxwHaebBThSfX8-0CSB25AvHWowKlxjNKETWxoG9enT3r8SiVshIqDJc>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 03:56:16 -0500 (EST)
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
Subject: Re: [PATCH v4 04/10] nfsd: clear fh_foreign in fh_put().
In-reply-to: <3da1bf9e-12eb-4f5b-9ece-5433839564d0@oracle.com>
References: <20251031032524.2141840-1-neilb@ownmail.net>,
 <20251031032524.2141840-5-neilb@ownmail.net>,
 <3da1bf9e-12eb-4f5b-9ece-5433839564d0@oracle.com>
Date: Sun, 02 Nov 2025 19:56:14 +1100
Message-id: <176207377498.1793333.4454287004945231736@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 01 Nov 2025, Chuck Lever wrote:
> On 10/30/25 11:16 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > Nothing currently clears fh_foreign, so a PUTFH which sets it followed
> > by a PUTFH which doesn't set it will leave it set.
> > 
> > As we always call fh_put() before installing a new fh, use that function
> > to reliably clear fh_foreign.
> 
> Hi Neil,
> 
> Do you feel this change needs to be backported to LTS kernels?
> 

No.  It is almost without consequence.  If fh_foreign is set when it
shouldn't be, then instead of PUTFH returning NFS4ERR_STALE, a later op
will fail with that error.

I wonder if we ever really want PUTFH to fail.  It is allowed to, but I
wonder if it needs too.

If the other server that is involved in an inter-server copy is not a
Linux server, and if its filehandle format is different from the Linux
format and e.g.  doesn't start with "0x00 0x01", then PUTFH will return
NFS4ERR_BADHANDLE so the fh_foreign flag won't help and the COPY attempt
will fail.

So there might be something worth fixing here.

NeilBrown

