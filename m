Return-Path: <linux-nfs+bounces-3461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13DB8D2D2B
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 08:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8396D28922F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4C15B99C;
	Wed, 29 May 2024 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kKKD/m2J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A092F56
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963905; cv=none; b=MtFZynfwswQ/HiRVzQQ0dgzB+1Hk1a2xwJ4mVvZkBkpnmFT5SOktary/ywa1deuzpxYwuLawOEKsofiI1Uylhs1+K1LHTSYc6wimIy+Gxp9DmvCfV8EErLhKr+rGARrPJvOp431E8M4lCyNye/mU5cDH2m5petcf1hJkcLfw9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963905; c=relaxed/simple;
	bh=TxGYw4414FbKDRD3TQdlxZwY3g+Epsl7vecRA72ROSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLf0Dzr5X1a8HvN41Xm/GA04zfaNNu+U/PpexwDD3pQFVyPKklh0NFQCqSbE26aJSv3YfHTCo5XRaTd5AX8Z57KOxQnrf954joVH1OUBul+8Gypo5T6Cju5UdqARSSng1Dlmcw0g2LFbpFA+ugI3FmNrep5LyeEp55oEAZZDBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kKKD/m2J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FFT4isgoVW1D47l7zw+qscE09cuRmGt+qVZaBkGbDSs=; b=kKKD/m2JHleGpc2S4B+iusHtoM
	nNilseM2ghSLpdJNmHudq80H6/q/vNKHWy+khIVO5eWiqTPSodAiV5llKWa1M3XfhGQvWKKS0TZKJ
	wxcBJR48uDtlqWfoQF50zRhhvFftNwrNp01xY121afL3TNNnPb4lGwmv/iM3aU5V5fUM2guhwmn3E
	t5Z1D+Hq196BtnaNIDrr+E88o5pDEQgiBV8lR3xQwMMNFrEa+u+ahoLVPvEMasPYyiX5YYGZ56o6P
	12wax9h1kzWUiGO1arfHdgcBOqKgqCIuPALHsAxialx9nNJuyubSKTwBAhYULvPyMvKblngef3Et6
	c52zv3lQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCkB-000000030A9-1klI;
	Wed, 29 May 2024 06:25:03 +0000
Date: Tue, 28 May 2024 23:25:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.1 filesystem client
 Windows driver binaries for Windows 10/11 for testing, 2024-05-28 ...
Message-ID: <ZlbKPwdKdiHBGCe3@infradead.org>
References: <CAKAoaQm2yrdyvd-U1Q4GztqFuEVpit4epsSpBZRJxR92nn+Fug@mail.gmail.com>
 <CANH4o6MMTiRp-_BVQemh-BAf4PH=Uktk+wZEWh_xxE9QcRK-Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANH4o6MMTiRp-_BVQemh-BAf4PH=Uktk+wZEWh_xxE9QcRK-Hg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 08:20:00AM +0200, Martin Wege wrote:
> Hello,
> 
> Please test the binaries. The client is for Windows 10/11, but
> compatibility feedback for Linux 6.6 stable and 6.8 would be great.

Windows NFS clients are rather off topic for the linux-nfs list.


