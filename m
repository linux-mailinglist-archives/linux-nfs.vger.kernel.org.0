Return-Path: <linux-nfs+bounces-1725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A8847E09
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 02:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A4CB24691
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 01:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ABA7F4;
	Sat,  3 Feb 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OEghnonZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbgdxkcD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2210FA;
	Sat,  3 Feb 2024 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922289; cv=none; b=OftlrajeXHf5NiDaVr1vhZmDHRtMiveYOp9Abjj+SdPrdto5ett9T1mxwmMPd5AohxCU6Olwub7MX1zeUbULuQ8jLm8a+lSpyQl5Qt0JnVkQR3hQMRRD67UYU4jl55AU+kHMcjaUlQYOhMPGDeNWoJGpj6PpnYEaoP+yG312/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922289; c=relaxed/simple;
	bh=CWmA9yn2XRvwgn+8ejKivBP0f6x1dBdQbw6ZwthDTc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwYDDdjpP1gccPOu+ySsGeX5uY7Ba3Ig8NMR21O7zY2vxM8KQr9cAskrSuAadhWOrSSYc8B/7LKn6E/GZ3kkdAZG82y1/V+DcSRyXLJptfx8KfQYytT0YwVvNDq/8Xv2r7UD1U7xPzcpXa4+OLWiR4QyreTJGI8sY/aiGmNfMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OEghnonZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbgdxkcD; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id BAF993200A44;
	Fri,  2 Feb 2024 20:04:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Feb 2024 20:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706922285;
	 x=1707008685; bh=f9lUpdnh2JAZeIyrtkQFsdT6DGrcuuvrAYz2wQIJ6UE=; b=
	OEghnonZJsWXfL4XEEi6EP8bN8LbFPyJGcKaGIv3zuerNHsobMmtt0jzkPAuo437
	BO4s82MsFfPTb4w4tDtfDpni8ZHGVBoNExybTs8BzzxjEiCIp3PT9WT4vC+4fRIR
	riBaqBIpMGBG1l4cEM9XhEHuSvpeqDWmuOxrEA77EMeCF9HhLcnrwfRqxbBsHVED
	bv+6XfTcGBpX1O3S1Pq/k8IbblBfwxLijlVSvC9CZtKfAFTyshJ7EZO7hmdm4o4h
	UYYe26xB8Sl/ZolXUJ1PHkPtasck9k+M9i7qXvWiSI+kXN0+jc3eOTa9PL2Bn6kZ
	v1NMTqVOFXLTgg4oOivb4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706922285; x=
	1707008685; bh=f9lUpdnh2JAZeIyrtkQFsdT6DGrcuuvrAYz2wQIJ6UE=; b=I
	bgdxkcDPh9UtuUay8P8/5hvSNmyDRVb9dMEsNZCL+BI6oE7cQClviTY8lfje31Nw
	APNUDtuzzPmIBSoO5WebGeDCoi4KTUGJ8F1HC+DIHW/9RprAVDgP/PSzWqO1vmUa
	/6Ssg5PcG4djQmYNTA9+dt0pfYubMQJKTYrSfDvS0lPdEK/2D6gsDLEOJhENMrNZ
	4ud5U2DGo2lKgjhda8pMU+FlZF1rQ2ytwR+6uvQ9m5ysYgHr5nZfsTcQx+HKUewZ
	ZVBCX6ACEOLkSnm13T12n5uKkDhvFh2kxFfn1aTNeZlqhLPrVQljYBr+G5znpOv9
	qyM/6L32vRYKF1BchNb6g==
X-ME-Sender: <xms:LJG9ZTaAqp5UVv6mZEkZqQtLol6F8SKUOezgqd_EDQrKdcM_V5ts6Q>
    <xme:LJG9ZSY3hwtEnrTzJL6CVDvbFOyk-k3nlptExkJjroiqFJOecxw5huxvF-GDyrT0g
    obBXG3MeyF3Gg>
X-ME-Received: <xmr:LJG9ZV_3hiabN4vih3lZA5CcIC85o6cK7wadcygCTkEC7aFDgKJTJXqSVdzf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgke
    ffieefieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:LJG9ZZoZLlwPf6dBhzfapY0Rxw6Nga5etr8h9iKTmtUdPNzICMeDDg>
    <xmx:LJG9ZeoG3QwGBclnmRhqnPKiqRRtRr48Di7KEMpOR1WT2s5ZOC-pjA>
    <xmx:LJG9ZfTJ8NqC24Yr08i1eE6ruudg36S5MQ98o53u9RJIqWZJi5uBcQ>
    <xmx:LZG9Zd3UxDpzhfklYPwLZglPIoPUPlIWXjEmgg67ZJ82hoMorT-Vgg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 20:04:44 -0500 (EST)
Date: Fri, 2 Feb 2024 17:04:43 -0800
From: Greg KH <greg@kroah.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: linux-stable <stable@vger.kernel.org>, Chuck Lever <cel@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 0/3] Fix RELEASE_LOCKOWNER
Message-ID: <2024020226-aviation-enviably-2f87@gregkh>
References: <170681433624.15250.5881267576986350500.stgit@klimt.1015granger.net>
 <170682628772.13976.3551007711597007133@noble.neil.brown.name>
 <FF7C90E0-251D-48D2-908B-E2145B0B9BAE@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF7C90E0-251D-48D2-908B-E2145B0B9BAE@oracle.com>

On Fri, Feb 02, 2024 at 02:12:11PM +0000, Chuck Lever III wrote:
> 
> 
> > On Feb 1, 2024, at 5:24 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Fri, 02 Feb 2024, Chuck Lever wrote:
> >> Passes pynfs, fstests, and the git regression suite. Please apply
> >> these to origin/linux-5.4.y.
> > 
> > I should have mentioned this a day or two ago but I hadn't quite made
> > all the connection yet...
> > 
> > The RELEASE_LOCKOWNER bug was masking a double-free bug that was fixed
> > by
> > Commit 47446d74f170 ("nfsd4: add refcount for nfsd4_blocked_lock")
> > which landed in v5.17 and wasn't marked as a bugfix, and so has not gone to
> > stable kernels.
> 
> Then, instructions to stable@vger.kernel.org:
> 
> Do not apply the patches I just sent for 5.15, 5.10, and 5.4. I will
> apply 47446d74f170, run the tests again, and resend.

Thanks for letting us know, I've dropped them from my review queue.

greg k-h

