Return-Path: <linux-nfs+bounces-17570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AFCFEAC7
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FB0B3015D07
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19543016F2;
	Wed,  7 Jan 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g739Mgzx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2738E5C4
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799851; cv=none; b=XOqyEIoffn/VvoPbVqWePNIHxufDJqIdPtYGd4XXq8h5PBDf+NVuMAeRnqAR0wIhQBnuBpNvkNGE9rPs5TrV4I2cPRZth71xc4YTLS6OWsF/OHFh4JkKDerO0ncTFmRvHzxSeTwDRgE5YJi9iFg7CQPc0Znb4gMmpl3XZ4XqHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799851; c=relaxed/simple;
	bh=7cSmkhOeAHyj9gLhtUsS5O3yJxZZafu27kcsCGB4Bwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVLb5gYJsiLdtp9dy8eGVcBUYzb4Z0cGru6EQ3fSsqyF7Oz3R8/XzDFCMVMRTO9O9zn8UV6Nfl+HhDq93sDgClVzhLerk2qO4NiMV5KvBOyrs52/+M+aqyRnedMntOWQk286gMwzSOpELOJydOcG5IGTFvZJBNVb13cziSlOoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g739Mgzx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RJq7nI2t0Y/JvV7wiPLkhzBIeEgQIKRKIYYB0WbC2o4=; b=g739MgzxKccEQlbGUIt2+1U0BL
	LTXHNmUCKiOAm5SKoNTqDdWos8EfkY+K4/aH+XGGHw5ghaos26DGtvwhj8EKsFDHEGLT77Ds0069g
	uoP5otaxz+OW525DVpZAuoGv2T4XAFJhO9OkZZSTXDPj/LA4Imdcx2izxc4zkH74wuRENa5xgQ0Dp
	WwtkKZPNtsp2oM/NID+FwC13TgRgakxqPCsQDhhEpIPZWvCh6YUX9t3bQuwwHbp56EN/9RVqtoS4J
	iNcLX2xc5J9le1yDbfKyxmyk3pF4W0oCVhT5H5y6fy+Ry4x67xLUHBFr7zAqjjd+F7MczRtHt8E+r
	scD7weAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVUm-0000000FB2N-2GS9;
	Wed, 07 Jan 2026 15:30:48 +0000
Date: Wed, 7 Jan 2026 07:30:48 -0800
From: "hch@infradead.ori" <hch@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: "hch@infradead.ori" <hch@infradead.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <aV58KBha24bpbLUf@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org>
 <aUnq_d93Wo9e-oUD@infradead.org>
 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
 <aVyp3SIddHB5sMhp@infradead.org>
 <1df4bb7ff3e6fd607c1811d75fcd6dcb860e320e.camel@kernel.org>
 <aV3ttYmT2vAtPDws@infradead.org>
 <d8ddd23a18985ae360855931f185d0e24c466310.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ddd23a18985ae360855931f185d0e24c466310.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 07, 2026 at 10:07:55AM -0500, Trond Myklebust wrote:
> Thanks for doing all this testing, Christoph. I really appreciate it.
> The previous patch was incomplete. This is incremental to yesterday's
> patch, but I'll squash them together in the testing branch, since
> they're both about blocking state recovery in the non-regular file
> case.

This fixes generic/633.  I've kicked off a full xfstests run and will
report back.


