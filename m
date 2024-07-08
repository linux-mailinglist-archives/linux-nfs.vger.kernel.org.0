Return-Path: <linux-nfs+bounces-4707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96500929F6A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 11:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70AC1C23860
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6374E73466;
	Mon,  8 Jul 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kAoCo4/M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4B3307B
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431659; cv=none; b=D4BYdTpZo7XTLSiJvlXjKOzkdlpoIp6GDacffZZrJy06AiYHd2lL2hyV6T+gmY+rcKcYCSHIQgWb82whUyZfnZV3JdnOIQNk4m0FM7XfQN/6o1j3ulPvrvomRVcUtKWjZwzKLsuu75A19PExbwB+1tUgr6tdM7Bla6dRlOj0Jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431659; c=relaxed/simple;
	bh=/FLmZn4Ozz7rfDSLd66Slb9fecQj82aDvPOfgaxYTpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFp7NEWDUssD3EefbJMsFaY6GHwuhws5t4Mocpmu23EYsbIotppowHpMeuM1M3wVqTAN7DB9kvvPa8jnpQDn8tOVEDd4S+zgwsFwqFE97DRU5ffbvUUQ4/dj4hgMyaHzhT5DDiFdp9Ajb5WdKuQnD4xhiVBCvn+lDJlv4MgiFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kAoCo4/M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KBU+gVq0qCbw5RpRZUYatRJFgo72oOVv8p5vFtM+Mzk=; b=kAoCo4/MXx6ISTcxrF5Sh7uXhh
	bPqAoyieGqqujB9aa/F6lJDEBEkObFvlI8dJD2yDquApCqxcEo/AFKfm9iBi4fqZOuV3osjPxSbxn
	ZrvdT+bMQBtpnuQNjX9bqoSCZLg5s1ztgLGpNXgcjnXsbFm1qF+LWUkLaC96jT8OTiMaGG25tV9y1
	fxbOg1VX7qnKIcihxINsRqI583w79yr0UsBXTqB6JxjL4xkxB8CCf3mJNdp2dEvlI2igPOtOsEmw5
	hYOcTodSyhgq3GTZlz8cPYMiK87EFC2tx2DkYGIfx+ZBKl7tGZXjh7K5D8e7Ob5x8iouwhm9q83fS
	etOdjaxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkrg-00000003KxF-39q2;
	Mon, 08 Jul 2024 09:40:56 +0000
Date: Mon, 8 Jul 2024 02:40:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <Zou0KFzlvUdH9bxx@infradead.org>
References: <Zojd6fVPG5XASErn@infradead.org>
 <172024784245.11489.13308466638278184214@noble.neil.brown.name>
 <ZojnVdrEtmbvNXd-@infradead.org>
 <CCC79F21-93A6-4483-A0B8-62E062BE4E6A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CCC79F21-93A6-4483-A0B8-62E062BE4E6A@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jul 06, 2024 at 05:15:08PM +0000, Chuck Lever III wrote:
> In an earlier email Mike mentioned that Hammerspace isn't
> interested in providing a centrally managed directory of
> block devices that could be utilized by the MDS to simply
> inform the client of local devices. I don't think that's
> the only possible solution for discovering the locality of
> storage devices.

Btw, no matter what Hammerspace feels (and why that matters for Linux),
the block layout is not a good idea for bypassing the network between
supposedly isolated containers.  It completely bypasses the NFS
security model, which is an spectacularly bad idea if the clients aren't
fully trusted.  I've mentioned this before, but I absolutely do not
advocate for using the block layout as a network bypass here.

The concept to do local file I/O from the client in cases where we
can do it is absolutely sensible.  I just don't think doing it is
a magic unmanaged layer is a good idea, and figuring out how to
pass the opened file from nfsd to the client without risking security
problems and creating painful layering violations needs to be solved.


