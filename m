Return-Path: <linux-nfs+bounces-15322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6378BE6B09
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 08:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101AD62447D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86A30DED0;
	Fri, 17 Oct 2025 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mzUT6FR3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6s5vHzo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCC2D97AF
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682163; cv=none; b=h0zo4JtoTSVuRqslN/G/pwEOvBMqRNHn52/5lDztL9gJPD7IBNep5OKF9/CzSS0BSaix0CDgceQv1PEQrRVIw2iclrkQ7Bxf9CaJTfU/YN0cEmk0AwhRhuxKrk1VixNe8lGw8tGIR4/IAMprIMPjAdI1bK6GnzBSy2o6YaxEYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682163; c=relaxed/simple;
	bh=P1xpF3JXoLosJPzB3z25/zlwdaFO34uc1aGXN166/q0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EWwaPAfn6tSsxX5hdswc5KVrJfx8nsSMae24x1NFT4TTDj3KYvevpjbKNLl/0OddPy5YT1MUBJMNuN429LeMP76xaGvqf88O7ewiBfBW8T149wcN95sbLJT8C/k8bvIDtZZ4FK5E1/6hoCdyd2i223fqj8dLGqjBxTUev48M7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mzUT6FR3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6s5vHzo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 668BCEC0114;
	Fri, 17 Oct 2025 02:22:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 17 Oct 2025 02:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760682159; x=1760768559; bh=nUKze6HQ8lKwHzGfRAgy6j0htuBzCK/ZFF/
	jNsKPKjA=; b=mzUT6FR3CQaRJTGYQDSXncQAS4jsuEXn253E5Gj1ViqTbx2GGiV
	AK5HKWWoRvdeMTFW7u5mVhGrnlPIZ++12OEMiQ4BkN+63W06XodsZlTBd6zlnD1A
	h4InTGJL/CbgU88ynd9GH6PMYtg6Av22mHkhKnPnkQ4q6b67yqe95y8oZsLjY7cE
	dCtoZNMl1TME6s6EykNjK04YuoWMcQvl6JiyGGL2bGbV5tZXQ6hvJkuSOGzL2kgt
	1bbzZ9GjOPnv81GjfeYTWfZkpl7CYgs6Yg/4wcd+K9aPkcuHqltOAr7erfDulXd9
	14WcsSILf9O76skVpjlSFGcFBNPEGXSVANA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760682159; x=
	1760768559; bh=nUKze6HQ8lKwHzGfRAgy6j0htuBzCK/ZFF/jNsKPKjA=; b=P
	6s5vHzo5w0bELvlNOrVFRxBLGRpCwdXYWBKwFRyfquejLWX6xpgYHn61a5PM8PHc
	7y2jLOK97TcJ0gMXZbDprej+2UMLbRXlP5anTxY2+FGtMLsWPJxawoTrbCflRINX
	KZOl7GvCZxI5VWKz1csGer69kOVfipsy4tLbVEzdbQY5Vpp1Vll/2KecUKNGPuyJ
	MsQeOXG+U3T5ZWMR8fCz0x5ueh3ROFUdt9dbXfChjqiniWN2KuATm8XRdFBCed/d
	XEw2QjZiiGzCME+nMJOksaJ7wyHazDznYI60ain1t29Tvadbz5hqetdCgrJYCSwQ
	WwR6XDNzTTPW0GHQnGHsQ==
X-ME-Sender: <xms:r-DxaM-BUNOijiK_S44n_XsNjP8UqeI2tVKEfWNDMUAkGPJrIyhRMg>
    <xme:r-DxaDw6JAnX0YW2H8war8db1UDRG6759mpkdaSnyN7ieGxCqvqlmInMMUBmoCJPI
    y75b6lwOQ39YXmVnAJdOtsmaOMR53ATrDYBt1FubDZBmRC3lg>
X-ME-Received: <xmr:r-DxaINxm7vnHbWuv2FJUNHOexUnkY8Ttm3CtOr2DUDHu_BLFhmq8igoceSZ0KnGg6DS9YRneTyel6XQ2mUM14ZM6dZtbtgNTkTFhk4SJtjy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:r-DxaI8k2DxMaNDTEiE1h64-pUQsrRtPt5ML8GmHsO0TFCzHuxPMZQ>
    <xmx:r-DxaF6Z8vaWcRG_gmbSd-2ycrID2nbeue57snef5m_Q6gG8zw-6cQ>
    <xmx:r-DxaO6-deJoofXa3lCIbi7h0sQX0F_Iy9f6fASfHC56IMghZNK5dA>
    <xmx:r-DxaOpv1x8uQpOIRX_UXmaMYmH5ATNWuEUAHucH1QXsEMlsgDVz5w>
    <xmx:r-DxaEjBDFswsPS_EGrgae1RaMZVJmfXX64ifFQmbSjWIxsa9lkZLYC->
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 02:22:36 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <cel@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS clients
In-reply-to: <138caf9b98325952919d37119c1d2938a8f4f950.camel@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>,
 <aO_RmCNR8rg9EtlP@kernel.org>,
 <c95b46b6-5db4-4588-ac79-4f6d38df0ae2@kernel.org>,
 <138caf9b98325952919d37119c1d2938a8f4f950.camel@kernel.org>
Date: Fri, 17 Oct 2025 17:22:33 +1100
Message-id: <176068215301.1793333.15890172978403788855@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 16 Oct 2025, Jeff Layton wrote:
> 
> Somewhat related question:
> 
> Since we're on track to deprecate NFSv2 support soon, should we be
> looking at deprecating the "async" export option too? v2 was the main
> reason for it in the first place, after all.

Are we?  Is that justified?

We at SUSE had a customer who had some old but still perfectly
functional industrial equipment which wrote logs using NFSv2.
So we had to revert the nfs-utils changes which disabled NFSv2.
It would be nice if we/they didn't have to do that to the kernel was
well.

What is the down-side of continuing v2 support?  The test matrix isn't
that big.  Of course we need to revert the nfs-utils changes to continue
testing.  I'd be in favour of that anyway.

And async can still have a place for the hobbyist.  If a human is
overseeing a process and is prepared to deal with a server crash if it
happens, but doesn't want to be slowed down by the cost of being careful
just-in-case, then async is a perfectly rational choice.

I'm not in favour of deprecating things that work.

NeilBrown


