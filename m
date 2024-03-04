Return-Path: <linux-nfs+bounces-2158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E6870071
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF0CB21008
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC63839F;
	Mon,  4 Mar 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="g6tD9HU7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4eM4PLs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB51B965;
	Mon,  4 Mar 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551912; cv=none; b=XNqDpLobyFYUMsrlCRkvAs8J8XosX1prM/x8ipzNmiOxP37rmBLiJVIZ4NZE+7tBxfudMCsYFNkIfuNlzUobe7CKMmf75pIyB4mInXSDwQUQcdDvG2GRpyOuUMi1FDsBjKZ41asEcZhVwbg3gfdpd9S+GAnOd9oGjFfkXt+O7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551912; c=relaxed/simple;
	bh=pY9uumxUtVhBDuv041CmNCDushgWROjcB0JIuhgLfRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu8wcbp1qnG/TvbstPQeYyzMJsEWhhDRIh9SR4//gScAWMPke0YCRcgLBAqea5dAyR2uF13mNWeZSCx2RSgKn0p3LsxR0AA+fNOayuy2rSpUvPcJ1Ij4N7z4PvRXv3YyclaZI4/yPijbicjAaJlnB/lx2Gq+92qC74opZ2WPYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=g6tD9HU7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4eM4PLs; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 47FD31C00098;
	Mon,  4 Mar 2024 06:31:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 06:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709551908; x=1709638308; bh=7cwuIreNEe
	1jP44N5/XfaiRVQE4xBKtKr6yMh8oyKL4=; b=g6tD9HU7Wh3BfjdWFeILfocYXk
	djy21IxU5l4Dx3NZQrLytkCgXmYHNnm9Hc2vCLp3MsAxC/AfjAYWqK3p6Huqa3S5
	InLhl6m/JO0QDBGMZzFJOuRqlGdGl6FqM3MzMsX6ucu+0SxVB1EoxLrwTcYQ7Ntw
	x7FjSW2SidCwf1bIJRKJcE+Fcm1US6o43Q5ZyztD88XEp4hU6+eYTp+tpqJ6bAbp
	IztIzOaKMBbqzcNhE+auNtbWed3+Aq7vNjX34RZ7gXXtOZRuF3lhQA5PFEC1ZtKg
	WD1brC1vjv+WVupuwXlZCFeGxB/jpV+pt7JTZkwmS39OJwY4Pzp5nbm23VVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709551908; x=1709638308; bh=7cwuIreNEe1jP44N5/XfaiRVQE4x
	BKtKr6yMh8oyKL4=; b=L4eM4PLsgesXQ00hOo4YyIDBsBczM3QgGpqFRV98Vsv+
	JP3g9uxu3TIeAq1EFOcFwAZQUNR0ESHJ0mgHFDsm95O+vkyLyUbFue5zakxsPB8h
	84HxYdK0OqwAwUN9xRVPxGA/+z7UXdCnaJb0b4Koj+E/Z8+cCyOtK+jHmmPkcqnu
	gs6jm9SaWB5Fl1d1jhkUwmnEmFf5w/+iNSUrM77DDYmTUrEl+EWdnY2UPDzwJtr3
	v8cr0LoyTJTOYopd+VkdN76vz3C89eeYR7G8jEisjTr8NP7flUYhm60ULuE3yUoV
	VGXjpk9Kd/GnqJ0qL0k/OhWmIo+WFHNxBLNeOxkCkQ==
X-ME-Sender: <xms:JLHlZSbegqstrXBn2agS4zj6gms1m3jp8lKsN9NeQpX8s5g6JWgftg>
    <xme:JLHlZVbWTKF_uCCPa0647ZeKJs4JC7Ll-5OLJ_WdIYbkO--rBi7A9FF_KqucqezQU
    yZ3KjMLHN4dWw>
X-ME-Received: <xmr:JLHlZc_e8Ni9AAc_5mGlvohXuL9di_wvfhYyi6_1lXmyxJIrFcUsaWUh0YtRysJExrYRzL-LT5IqTENdpenu-3k5enl688tET5C5_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:JLHlZUpEdPRuvNZ-UH4l_JlyoruLaMa5YeRiE5mLj-SFaj4L_KyOMQ>
    <xmx:JLHlZdpTV-efoLmSTnZg9DFBaRCGgiEz--awq8yyKMkiysZRL2352Q>
    <xmx:JLHlZSQsY8_UBmyRxYsmL47WlDmohFxivBwFK0h0Avm_qydXwKAx7g>
    <xmx:JLHlZbifeiev9quQj7FLO1zgyKogUFPAV4jZ3GxwNLyJ0CtDXe1ACTar7Ws>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 06:31:47 -0500 (EST)
Date: Mon, 4 Mar 2024 12:31:45 +0100
From: Greg KH <greg@kroah.com>
To: NeilBrown <neilb@suse.de>
Cc: stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Subject: Re: [PATCH stable 6.1] NFS: Fix data corruption caused by congestion.
Message-ID: <2024030439-exclusion-tanning-b1d9@gregkh>
References: <170907634991.24797.14120500624611379941@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170907634991.24797.14120500624611379941@noble.neil.brown.name>

On Wed, Feb 28, 2024 at 10:25:49AM +1100, NeilBrown wrote:
> 
> when AOP_WRITEPAGE_ACTIVATE is returned (as NFS does when it detects
> congestion) it is important that the page is redirtied.
> nfs_writepage_locked() doesn't do this, so files can become corrupted as
> writes can be lost.
> 
> Note that this is not needed in v6.8 as AOP_WRITEPAGE_ACTIVATE cannot be
> returned.  It is needed for kernels v5.18..v6.7.  From 6.3 onward the patch
> is different as it needs to mention "folio", not "page".
> 
> Reported-and-tested-by: Jacek Tomaka <Jacek.Tomaka@poczta.fm>
> Fixes: 6df25e58532b ("nfs: remove reliance on bdi congestion")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/write.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

All now queued up, thanks.

greg k-h

