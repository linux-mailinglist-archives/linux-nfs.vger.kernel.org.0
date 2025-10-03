Return-Path: <linux-nfs+bounces-14940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0593BB6025
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 08:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FE1AE0027
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E612E21B9F5;
	Fri,  3 Oct 2025 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onlZArFe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CC21CC62;
	Fri,  3 Oct 2025 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474636; cv=none; b=AV+R+NYgqq3xSXIeba5GLretcaGu9ndq0HJksRLKzV0q4fYt0LfoaTbaMB4fY0ju6ACKFDDyClAox3rvhOrn9AWD3S6JLgdpvfLWHREOexiRDP3kEfDx5RLyWgeClvaZV8Eqrqsk/j2IUf22SGBC5f3kezKjx3a/g8N5sIr0zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474636; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7ap6+X+81/abLf/U/RDw5zwJYdFNQie6iQEKGxO8/M/FuBN9iC30oJYz0bqqL90ePlJE86nDJp0D2VlsU3H9XK6kE39gfTvPLLG2VqN1YOOjKAfbSgk+96hriFUTr+BEDxm0w9RA93glpj/GR3vwhMflN0WwNm1v69aeiVUet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=onlZArFe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=onlZArFeUy0VfyocOt/aiuYLWF
	hn4uT8bkX7LxPu4tkR+UkG2ECcoQ5NEiXRP2QojcSJJ2Ua+45tAAlGrXhlnXeMTEaTiOztOWcDs1Y
	kNg49+msYggwMOOT0Tqx4M/TDyz75Lf3MYnUP4Vxnj72EtOtNslinoVjxdp5Hvj+4K22fR2p/yUJI
	64CVYdP/SPZ5bU2aiwRhHNrl2ICX0y7UEDbEdN1Me3ylWwQ7z9b5sD0lINLv9gf894jc9RgVI2q1b
	ZeAvWwybVW9gBKP0DTx+TDtXnPc87fk7GkvqwqHx8v/tSpOGvv4quN9wHAhc8v2Z7Dr11TEVHFPaJ
	9R0SGK0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Zj7-0000000BlV8-17WD;
	Fri, 03 Oct 2025 06:57:13 +0000
Date: Thu, 2 Oct 2025 23:57:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] NFSD/blocklayout: Introduce layout content
 structure
Message-ID: <aN9zyVUqoeLYSGaU@infradead.org>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
 <20251002203121.182395-4-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002203121.182395-4-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


