Return-Path: <linux-nfs+bounces-14976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BDFBB895B
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Oct 2025 06:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7773F4E227B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Oct 2025 04:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31009D2FB;
	Sat,  4 Oct 2025 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tUTFtmyQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE6C2E0
	for <linux-nfs@vger.kernel.org>; Sat,  4 Oct 2025 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759551742; cv=none; b=s982W6D3Y7TCocGqe6NSpWzskm/f2TohS2jz9evzSC78a8aFWN/xhJdWzh0Y/gYqkWHVT/7/xGdz3wIdDX5V9pDn1GiD3LsOyVrxQWXukCBv9hqWV9kbEcXDiGPdUrqObZw2n7dhaMrZbijKJtCm3WFw4yjJpqoY4I9pJVxK3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759551742; c=relaxed/simple;
	bh=P06AOqxexWba71kxGWu7zCw8/yeihjU4sn+zzDmWsFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RENSSfpyNiiF3uGlxRdJfjk7MprmfuEfUqcYfWuUQ+JTDrM9RLbGe8OUh31s4AMgGKvC1jDx4qJdIO6WB195svCmF+lU1/zBAklTf1+n8kvmbBy+VxRKCLMN1BB6Ctma964YSZf+w9d/TZadV3e6wl6RvjKEuVLY35m1P8BAYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tUTFtmyQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P06AOqxexWba71kxGWu7zCw8/yeihjU4sn+zzDmWsFw=; b=tUTFtmyQDwm++56zobi+8pHdXd
	eVh0jw84lQEkva2gBFgYXvDE2JSN0Tet+L37HUjYx5qubvkeUTiyRspR1iBURlNJq7T6pQeqTM69s
	Ytq856mXeqmx45Q81BVazPtOF+dz+J48EmVlmmeX+vgHTsFmKrZCrVBm3fRKptHnvXn8ZfayTpNi0
	Nj/AD3X8gWLsXJU09FpNvOq1QR0BuT7bziurPMxdEbmsOFs7Dq0ckQuksdUfruV02y/xo8QTQzaU1
	hZj5MocQUuMsAAJSHE+RSCvXSUz+4MzZNkrl6Jyh4gcmnTkbGeFTej1D8tUCZaOvRRsob8wwGG5LD
	WO76UCsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4tmj-0000000DRks-27jL;
	Sat, 04 Oct 2025 04:22:17 +0000
Date: Fri, 3 Oct 2025 21:22:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] NFSD/blocklayout: Fix minlength check in
 proc_layoutget
Message-ID: <aOCg-YF0v_soB2zS@infradead.org>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
 <20251002203121.182395-2-sergeybashirov@gmail.com>
 <aN9zNZ7n4KwhIZrJ@infradead.org>
 <3137a3d5-1377-49e3-a86e-e41c1afc9666@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3137a3d5-1377-49e3-a86e-e41c1afc9666@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 03, 2025 at 10:11:15AM -0400, Chuck Lever wrote:
> As author of the pNFS block layout code and the related specifications,
> and a frequent reviewer, would you be interested in being added as an
> official NFSD subsystem reviewer? If so, please post a patch that
> updates MAINTAINERS as you would like it to appear.

Will do.


