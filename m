Return-Path: <linux-nfs+bounces-12872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51BAF7504
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B923AB523
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003628B516;
	Thu,  3 Jul 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="axoBS5Yu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B9B67A;
	Thu,  3 Jul 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548004; cv=none; b=VzqqRRichjbf+AzjAK/13VDubCRdDrbEzSyJcVAlfkMxQhTHy7nHliusT1sSgF0AnHy8k2lYSOqNwBvi/BxhczqFKDcevnQjQ/QI35Grv63ENft3ul6dYi984rhHEVd5qcjGfLW605fNwzgIP60bx3qHERuyiPqjkcoD75Dmu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548004; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2h1vTGhvotCgL3LmTmG1TOh5avIVs+BU2GGl/MlPOhuljuWnPrUR7f9j8fkdc8jtv/JnC4Rn9PfFb4En9Qw1JG2sdiJLb1p2NvxVMUYPyu9+h6jwJg5Jz7DJ/oso8QJHJP6mcLFQBwhp0/I9GR4QMOp0jZ73g4Mv8URIAq9qIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=axoBS5Yu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=axoBS5Yu26EcYFAumthKnpH0jg
	rBrWHRs6pg++5qUG8BWmYy87yyu1sT+kVtOjLc42jajOQYlzBxSfH/23ZntzhNH2nSLYC8wuOWYDF
	+m9Y8JhETZQ+q8djgN5J42v5nGLAj1UUkwTTgiCKdLno81/UgnX6Wbja4DObA6TxlIFj8J2DL/vR1
	PgsfrAqloJDBZC5eGy/PaJuLu430xs9cSsrhWzaPyCqBeN+J/W/8S0XGnQarLYjOToyIWMZmnebtL
	e6g0G41TJPAem3iN7jEp+hjo1GbnCvRxy4LAn5EQlq/bAAeVGI58soLBTq+tWjraYjDKKVNWMWtwR
	NhCRUxog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJeD-0000000BRBA-2PFB;
	Thu, 03 Jul 2025 13:06:41 +0000
Date: Thu, 3 Jul 2025 06:06:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] pNFS: Fix stripe mapping in block/scsi layout
Message-ID: <aGaAYXgLScdOCj-S@infradead.org>
References: <20250701122341.199112-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701122341.199112-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


