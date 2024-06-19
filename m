Return-Path: <linux-nfs+bounces-4052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D901D90E2E0
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25341C23613
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 05:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E148788;
	Wed, 19 Jun 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/Aa1AHF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE2224D2
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776144; cv=none; b=ii6pn9YiEBZiv7QLUxGUAkDjvI/j3Qc5g8LBIbP2JJJjmoh2XYD+YfC1zqhs0Ykdfg1fNV6x1dTLlhbNSACiky48LFV9sxBZhup9pP5Tx+29SEyyBydrqAM7xKi6sEfxky+HuIfD4bkhPeIZ5b4VJ4jJBabNyMYmP4nYvamXevc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776144; c=relaxed/simple;
	bh=W73dxHGT2SpdwPdu01UWBRykOKpnTQF3flKU3L6YRhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b13R/XkKAFfI1u/00rVf2uc2zv+tqZdkoy70frd6m4336ndUV28hvaJ3rQsQYfloQ11g9PxmdakyuB9y9CaAT3AMuNNQmV8LZBZXV3VLJg9kAcl+pBUgltmxOOmfscPkopZbVkWe/HvdiXKW8oF6r9wf8+oUiUl3udcPJySkWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W/Aa1AHF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W73dxHGT2SpdwPdu01UWBRykOKpnTQF3flKU3L6YRhw=; b=W/Aa1AHFad3I3lzKXS9L1UJFEr
	HToO9E++irVaKTrVkmM0r74Vi3X8v37gTmbjEbZXtw5SsSeddSMgpCd/YmCsCUrjI4hRp1nQBWnV6
	JoR9i+B7yD7XvGvS2Fi3GqYTLFLikU883v7G4MbUvXCb0Je3HqjMVfSTa2r5y+KMbcw5+U+8QqYzi
	ekMAk5Xc26M2lRvXm+75GyJMuvLx334yLCiVX9FzvZULlYUn4A98BaEPyPDEtYx/t7xgjiUFGhzFj
	q0MFFYbbQCVp3eH1O41O6U1c6izIPskL+cLC0lDOm2RaGo8M48PXfyZzdUtfudTzq/ON5ZZc9Cuc5
	QSoMGdjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJoBq-0000000HYx6-1zRu;
	Wed, 19 Jun 2024 05:49:02 +0000
Date: Tue, 18 Jun 2024 22:49:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Message-ID: <ZnJxTsUuAkenmvWP@infradead.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618201949.81977-1-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

What happened to the requirement that all protocol extensions added
to Linux need to be standardized in IETF RFCs?


