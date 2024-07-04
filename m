Return-Path: <linux-nfs+bounces-4619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80805926F27
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17DC1C21D8E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 05:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3C157A43;
	Thu,  4 Jul 2024 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVEb6EI9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471661A01D9
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072544; cv=none; b=M317ZiJKtmmak6cAcRZ3d1oafDoGWUkc+FIcH9lfkBsjZrKkecdw/74lS9vXGlQ9duXSQKPLO7LSjNXKzCvg4uhkTD7gPNrS1jMvt3s90zIHd1MZWTo17Q30zTv18h/9DJkswkgRL4dkW7azzyOoHLhd+rtybI++4d+TdTxx8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072544; c=relaxed/simple;
	bh=3ueSGvEZysVDJsEUCdNMC44lkxZFCJpepzsZGVl1AGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fukmGGEdTDSheNmVjOoC4lbA1UMHdpI7G4rTMGHsLCgfG5MD+khByd3U0v/bwKCCJ2rSSmhqA/VVvX1maiBi0mBff9VOR39m/ZujMo+RYv12iIWlc7qtO6uKrygPNUrf/7257dbLCiBPu/6xP3w2WunvSXYD4GuByW5srFHwhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KVEb6EI9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SHNTEBKKn5pPuUsmywUHPS0q2SxG8TFXSpFwV3KITAc=; b=KVEb6EI9ugROOphImD34yx/YJO
	MsZuO6jo24PLmd/5uZ5q9YlNFmobrMxg8CbgIFKa7tkw54cisEtj6ZjX7PxJdbdbcM8XXmBf6g5zs
	0Ipqc+dyAO83DBD/4daKh86Da/BBfb4KjNfsvCH57ojBb0eNctZ9DGusoRHveXvIUmQ80hErEu9S8
	lhjflKp84xCABuSLA/JGpzMyJKIeWj49BfKunjQ+rHh5JZ2J8spyqyfbYsjb44r2+xUGvUi9Rz7YP
	o01Sq16ljkpaVMuR9IQYJazfTdRdfvbfAT06AORVr7YgiuNLu9skKfSWoiakbCScLsi7vPjbwNsvK
	2RmfLfQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFRU-0000000CGl0-0o2F;
	Thu, 04 Jul 2024 05:55:40 +0000
Date: Wed, 3 Jul 2024 22:55:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoY5XKqXUv0ncTef@infradead.org>
References: <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <F5BE7C26-9E43-4514-9E5E-2B6F7B32569D@oracle.com>
 <ZoWgpTJkiPOmJi1L@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoWgpTJkiPOmJi1L@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 03:04:05PM -0400, Mike Snitzer wrote:
> The answer to that is: someone(s) could try that, but there is no
> interest from me or my employer to resort to using block layout with
> centralized mapping of which client and DS are local so that the pNFS
> MDS could handout such pNFS block layouts.

Where did block layout suddenly come from?

> That added MDS complexity can be avoided if the client and server have
> autonomy to negotiate more performant access without a centralized
> arbiter (hence the "localio" handshake).

Doing a localio layout would actually be a lot simpler than the current
mess, so that argument goes the other way around.

> NFS can realize benefits from localio being completely decoupled from
> flexfiles and pNFS.

How about actually listing the benefits?

> There are clear benefits with container use-cases
> that don't use pNFS at all.

Well, the point would be to make them use pNFS, because pNFS is the
well known and proven way to bypass the main server in NFS.

> Just so happens that flexfiles ushers in the use of NFSv3.  Once the
> client gets a flexfiles layout that points to an NFSv3 DS: the client
> IO is issued in terms of NFSv3.  If the client happens to be on the
> same host as the server then using localio is a win.

I have no idea where flexfiles comes in here and why it matters.  The
Linux server does not even support flexfiles layouts.

