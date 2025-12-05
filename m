Return-Path: <linux-nfs+bounces-16954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B35CA6FC0
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Dec 2025 10:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3660539008B8
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Dec 2025 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157834A764;
	Fri,  5 Dec 2025 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghkjRxWu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C50348890
	for <linux-nfs@vger.kernel.org>; Fri,  5 Dec 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921926; cv=none; b=gp8nO6RDEskOH9l7tgZpSypWZOMrZN5UAhACAcW4qv2/LPf6WdulNC17CunpNcCSMZchkdKNhkBdg2OsTNRJqlo0HsOCR2Y2lNLZlWcm8uUSCdAOjd2kAJjSeQnPTpZSEfeBcCHbbYpJ22ctoSfvEuSwBx4uQXdzyapONd+n6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921926; c=relaxed/simple;
	bh=knqG4r7hNaIKepLMwavI2Tn+UkDagwTZ316mr6Hn5HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+FZ7xiS3ioYtamv4h3sFWL7TOqQXN8qxbs6cB70zIhvD03yzI/z1D4WWM+97dGf6z0P86x+eRDCH/IE92r3OgAqnNz8pLezKCA6KMOZf/CV3aZvtrEXIDjLYX5AH3OLOA8LotQazr0XM+EXO0+fZgoXj+ROwvJv13F8tfeYecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ghkjRxWu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fVH5HQMa+WJs+7EOKNAnQz6PevrtPMRX3oqfIZIp0TU=; b=ghkjRxWucTGahdKFcKT9Syzx9Y
	T0KaWZ0Q8PSI0jj3JgcIedZbc+nj2tQX7pi6oSQYZs/IAg69vfE9PhYvxUvLseakMAdMmVcxf+N/t
	X8a0YJaAC2kgHLWyPa3bjDsl9uoW0GcaTQ85e0LjN3yri2buoC5ulGsl0lZSaetv5Gh1hAeydaOgJ
	m8PLfP9JyCLg2mYuhNyDcnLB9Ps7l/PA3plhIcFGZAdMgSMSmPKEvxs+j2VVyy+VdpUf6s7KEySlc
	P+eAd9kRVe0kb7StKt5LsuHiQ4T6m1kgOrxaTlfY4CVl55VzFCjdpmiwW3OBSbl9Z3Kt6HzTxPz4S
	sfcZ9x+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQoN-00000009CRI-3Amz;
	Fri, 05 Dec 2025 08:05:07 +0000
Date: Fri, 5 Dec 2025 00:05:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	Zhou Jifeng <zhoujifeng@kylinsec.com.cn>,
	linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Can the PNFS blocklayout of the Linux nfsd server be used in a
 production environment?
Message-ID: <aTKSMwu9RFGYfNoK@infradead.org>
References: <tencent_780E66F24A209F467917744D@qq.com>
 <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
 <aS6ChyDRx-hALj5V@infradead.org>
 <6b29d6fb-04e8-43da-bc1d-0e78572b5402@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b29d6fb-04e8-43da-bc1d-0e78572b5402@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 04, 2025 at 10:10:39AM -0800, Dai Ngo wrote:
> > So in general I think it should be taken as the same maturity as the
> > SCSI layout at this point.
> 
> How does server fence a client using NVMe layout?

Using the same persistent reservation mechanism as the SCSI layout.
The very minor difference in the registration scope are transparently
handled by the drivers.


