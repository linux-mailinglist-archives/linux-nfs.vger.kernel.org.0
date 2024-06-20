Return-Path: <linux-nfs+bounces-4125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC690FC26
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4D9285DD5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F502224DC;
	Thu, 20 Jun 2024 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DInd9be8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A921628
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860715; cv=none; b=jGAlQZGg6Ad9Qdb405FAFvsP2kLm6/BJeMsFv535kIA2t9J6XcDsePM9x+tm0C4F23omAb9vyf87RFmqvU2ls8ABMS7ugc3qyUQbNGAq2phwmyw9Xcy5P0ytG67i/UEcSyzXNv58XRtcUY725C8e7gy2BuvhsxukPnIrlF8QLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860715; c=relaxed/simple;
	bh=HMWT1oGtvkoxpE4co8Z1UluZIu57FnJ+XqdaLiFydjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uecviGqtI1P/Oo3r8KliNfk7hw82zCf2lSpudupbUmwF0HoxYUzm48Ui8BAAWbSs123aeLARMwupa9svQHRyuHWMnUSfu7/cEQ4mh6Llf3ZQK0puyv7sSpm2SOJ8fudl5sCABDjpMiLCRsfpjPLnTYUiLpmPwkIeaF/yVzvSJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DInd9be8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ltte392IfiZI+5AcN0Ntb/KNhDy3FGBgxBT+w5BVL4w=; b=DInd9be8M8XJOzHNJDo+D09axI
	l1/0As4ow1q3hBcA2O/pligkz6touNGYJbC4y/AbPLPRC3elc1+97546XGXwi5ztECU57zkAkenpk
	ZTgxlHOXZYRgIUpHGAr5U2BPSBcFOxTxSXNre7Ndi5+vPEsM6KQhOoMHLYZNgPbO4SQy3G2FjP0ol
	R9CuRr1VkA4Gsvvw4BlbouU65bxkrY2sJZst5u2peOakVJhr3tHYdzcIvwyBRdm1OcRcz38kzmAMH
	WMxr7AuG9kRHbA8Gg7op053DDulYT0cfRqROHm8z6VsGjQQgcuBXOtSHWlj7+zfa8vAayO7fqkJ2g
	wul4KWsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKABt-00000003fD1-1sJr;
	Thu, 20 Jun 2024 05:18:33 +0000
Date: Wed, 19 Jun 2024 22:18:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Message-ID: <ZnO7qeNoOzFI3loq@infradead.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <ZnJxTsUuAkenmvWP@infradead.org>
 <171878101003.14261.1089014272023335768@noble.neil.brown.name>
 <ZnMb7NxuXnIikSQK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnMb7NxuXnIikSQK@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 01:57:00PM -0400, Mike Snitzer wrote:
> > Going through the IETF process for something that is entirely private to
> > Linux seems a bit more than should be necessary..
> 
> I have to believe Christoph didn't appreciate this LOCALIO protocol is
> an entirely private implementation detail to Linux (that allows client
> and server handshake).  I've clarified that in Documentation (for v6).

Well, it still has XDR and code point registrations.


