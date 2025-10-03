Return-Path: <linux-nfs+bounces-14941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A8BB6043
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 08:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0D184E7A86
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9061F5617;
	Fri,  3 Oct 2025 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MvvPvf1Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3440207A32;
	Fri,  3 Oct 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474710; cv=none; b=ZGfEHXZT7Sr2Z3C41JA/gJ1KFzwl90vhbvt2AEqWdVq5Z/0i9J50elLrK1FHGeJ5OPfHk/zPtCXFpH/oRsi4LTePT1d8Z6lXKxk8A5p+oUk03r25/GPVGQQb/GDjKKrMUnhe5P/UK8dw67ZDsiZmGF+j8wv3KZkpeufgaT1XZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474710; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCaydqJV5mMW7Tt9U5FRQHF+ViPYl9ZJrUy9I0ROlPdBlJTduzEC9VmCe8RMxkKY3JKu4b6b8ksM8/Eit37PeVjOcNSXzPJtJ8tX7icI1vUrac6y2GNSnHBp8mvqsIuaLO3wSMv+OAz08zWED5mnSdntoDh7HQ+UimV8niClVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MvvPvf1Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MvvPvf1QCH9hE8kQvspHwoCpsW
	OwEcCA2IKOxdN3Ei8Rg9Xpo6SzXh+xYeZqSaYnYplTT/u9wJFBfjWfW649PzMwSrhFgAvgpiuMU/q
	wUjMdf4Lli9lwbqVBvDdNxkrPWTOPa5R7/QdG5UKuGCwY2sknzaI7w2/gVHSa2tvuAsH6eu3YpEFy
	gZvr/w4+CwLhXm10i4ZNWr4FPr3V3DraSa07RXFcUk7U3gAlfwCvXI5eQR9/VDn51eAgQymtaLbYL
	ardBONbPP6DGpITVBET0nSH9cKFaY7zD707aZnP2CCVug91ze1VlLtgZnLfYDzg/XpQV3CxY2Kmhp
	gw6bh6ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4ZkJ-0000000Bljm-1p0g;
	Fri, 03 Oct 2025 06:58:27 +0000
Date: Thu, 2 Oct 2025 23:58:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] NFSD/blocklayout: Support multiple extents per
 LAYOUTGET
Message-ID: <aN90E6VRSLb4mOZR@infradead.org>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
 <20251002203121.182395-5-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002203121.182395-5-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


