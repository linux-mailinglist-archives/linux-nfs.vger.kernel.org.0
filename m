Return-Path: <linux-nfs+bounces-8112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505769D2610
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 13:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35C41F25824
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A01CBA1A;
	Tue, 19 Nov 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KavH8eDS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C479192D77;
	Tue, 19 Nov 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020163; cv=none; b=SN7sutPyLK7XgsAFafwkXbyyXanTk7bd5GRl5xzjGxNymKIMMAQxQUx5iPwIRvGRhNRqiNF8qNeSr84ztRIcwcy/ojd46GEpz04rmOQUSiVOryJK1KAQUWy+QKA8IXCKW7gPPuxzoIscvxsmPVUsBUL3ba3fQe24rOfmX8PiDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020163; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1LF9U8mewxZwiuL96F/0nbiKcmUk4chq8iuYaMXtG2bIo1pM3aug5CvbMiOe7S4URB5+vE9RbAsmzOFeowBJkUNl0scn4uj1rEAifcIMoM+edt8DGu4Xd8uRo2eOCxBGw4DOcOLU0RxTcuBgLTz8n2YLXWGDn9vhgmvg1tpY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KavH8eDS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KavH8eDS1zA6bitLy9Uilt4y4u
	a23mfE0PqK2+dPh0UD8cKlnPTU63Sgr0Hh31FCfLlJ7V2nFqvYR3/x8oY3gdCKORalkUPqQCfTVBF
	x01l1nHzanDrmo04yCh2iQSjMS/QnjHGnR2n8UcYzh24FsWh2Z2Ywo+9XVq1bW+TgXfT97T+CKRMB
	+m9TohNP+IQ+f5uixDkdVsJCHJQDyyzmoV9oo31mG1kXn+qhb2aurXD6x1M2oPpt8U6140lnGx0Hl
	3kv6z4v/kRamWKEyyKx7I0/TgHbheh3HjQ0RVR/ACBLAntmvgsjRDFtUc9WI3xxpOND6ke1P2OVHW
	h2RvHUZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNZ4-0000000COm1-1Mua;
	Tue, 19 Nov 2024 12:42:42 +0000
Date: Tue, 19 Nov 2024 04:42:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs/blocklayout: Limit repeat device registration on
 failure
Message-ID: <ZzyHwtY_ImBSVRcl@infradead.org>
References: <cover.1731969260.git.bcodding@redhat.com>
 <ec3b7c3edf1bbc048e81ba9aa299eb814bb80a65.1731969260.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3b7c3edf1bbc048e81ba9aa299eb814bb80a65.1731969260.git.bcodding@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


