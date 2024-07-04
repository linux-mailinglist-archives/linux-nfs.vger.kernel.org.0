Return-Path: <linux-nfs+bounces-4618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF74926F1D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 07:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C6B1C2288A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C391A00FA;
	Thu,  4 Jul 2024 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2v/d5qmy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97C157A43
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072174; cv=none; b=W53fKMfQkEEtvqSUbFyFLLmF5AXay5hZK2sPuACwwqBOs6cJ5vQhuiuO8z0t9+UkWY74Fy8oaHeE3zoA3LhU35rPxyOk5xlBL5w+XWFFqryo7Ykr9n5183vECRG9MMS7Y75rGuQGWwqjiF9B4EyRcuHGlzhzMDryNt+9c1K0J8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072174; c=relaxed/simple;
	bh=n0MXUxDCDfo0QyLKOaEUZHMJNWX95WPMjmrUEww0goY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqja7E86u1VHVClvMhG39jZI1KIGks9pUFDYwmcf/8kNKvSOO9YDypSlOLM8m+28/RP3F3nLq018hymYtYF3DrPY9Xqk5yjqfXfDHHGeSiTK06ei7qMhcmhq34M0Xk11m/qiwq1Ax179FHq+TAM7wum4V3Cc58Br7WO68EG7KPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2v/d5qmy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OBwgM9s655yV/TZAP/vwr2a07TaMhe4FdmTi1O1FnAQ=; b=2v/d5qmySZhVu+8pGqfYMYd7c8
	VOogIeKWJi/kOFRAkcL6BNiG6iX2pm5B1T98nVpzVBH/pq+4L1KwpEAn328khdOzL5Yq56YWsCBOL
	GccjsdxH/vaeDb+bqZSF6vPGvYZ5fum6ObSS2Lpa1GreFu8Z+xLmMDAKEnvfno2s5hAUNJmg4vSM/
	6P5LVlL2477EOHPoD3ppsr+cacPSkxHO8fF96OgBqiVIDC8iGPXMeY7dV7CFVOHsTb7zSynbfppNr
	55yTFfXHfCWM1bakkBDXQctXS/Jm+98JZpaKD76L7q5TFk/hRZSfE+7yYKZPC51wE5ck5LVaVvmOh
	ugSeEuKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFLY-0000000CGCS-10M5;
	Thu, 04 Jul 2024 05:49:32 +0000
Date: Wed, 3 Jul 2024 22:49:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoY37A9g1erSD779@infradead.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <ZoVrMBmOS9BalBXO@infradead.org>
 <ZoVuN1YbbxA8w0aF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVuN1YbbxA8w0aF@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 11:28:55AM -0400, Mike Snitzer wrote:
> Containers is a significant usecase, but also any client that might
> need to access local storage efficiently (e.g. GPU service running NFS
> client that needs to access NVMe on same host).

Please explain that in terms of who talks to whom concretely using
the actual Linux and/or NFS entities.  The last sentence just sound
like a AI generated marketing whitepaper.

> I can tighten that up in the Documentation.

Please write up a coherent document for the use case and circle it
around.  It's kinda pointless do code review if we don't have a
problem statement and use case.

> Using pNFS layout isn't viable because NFSv3 is very much in the mix
> (flexfiles layout) for Hammerspace.

Again, why and how.  We have a codebase that works entirely inside the
Linux kernel, and requires new code to be merged.  If we can't ask
people to use a the current protocol (where current means a 14 year
old RFC!), we have a problem.

