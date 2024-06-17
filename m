Return-Path: <linux-nfs+bounces-3885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48990A363
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 07:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0221F20FF9
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 05:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FC1E888;
	Mon, 17 Jun 2024 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZBgsWff"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3217F5
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602726; cv=none; b=WpjZcBoNdc3OqhHPegqscA6g13o14o32clbuAm3SftP+d/plM+mfhsfT7KGaJs3awaJhJKQs6ZJkAxE2nmMEjtosF8bayFFKCzG3tPt02OdqlAKAtNHSICDy7aAJhS9JTgkNLeFJ4Ha73wKGXuBNr4k8sa/Rq0WfWx5/o9cCvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602726; c=relaxed/simple;
	bh=hM0kUBja1DRxQwiLO7eNGZmo1mpuWtT4YeY+fjOdN0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzTN4f4/MLDPMoSgSNEyUpeTbejnogggZI2Xb3eRmQrR6MH1x/fV2S6Y4EBKeYRzefOsjUgViUtfuxCOwm03otM4F5plYHuDmZROmtxrw9NCP041jrgZRMCuIoZqj3gKlbJL/QQvCOFnb5/5k8u+A1sEls/v+8ToXjdpvt7hlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DZBgsWff; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4aJqaQenTKCH71p7jkaKnK0NE9bwLOJpTCjOTFjWdh8=; b=DZBgsWffzDx/E7F+AGx5qvBrjN
	Ap6ercE5sJGjAXuDPIQ3fFHyv+6Q7BkMN1LYy6nIvU++QmENNmcNGJXYA6ruG9AkgGHrGFfSb/nLB
	lclCKLtLKlSIK7T9OFXYu1mtKEXu0LewjOAkk3+jwe4AOdtaVJyLRACaYoCFJlyCf/5uXjADXcJq0
	VKla8Xsaje5AF2/IUkrSoqzVLU5AA7QZF8aghg14HvISZdpM+cz+TsBI0DeBVZjoo+bUFCLtoy8Cv
	ldfYDKNTXyaCRC0lela0+czkt1iTFd7rMSFPUFid0RIXLKX0tRCbw1AYGqoRnuqDD2IvV6+ObQj9Z
	CLsbumaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ54l-00000009EyI-2lIN;
	Mon, 17 Jun 2024 05:38:43 +0000
Date: Sun, 16 Jun 2024 22:38:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: reservation errors during fstests on pNFS block
Message-ID: <Zm_L48Z8-3fpWZXU@infradead.org>
References: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
 <Zmxx-H2KrT5QpJ-g@infradead.org>
 <C02C8230-4ACA-4F2D-AC28-B9583ADCADA5@oracle.com>
 <ZmyLSZGWDeaIXdx4@infradead.org>
 <ED7EB3B3-F56A-451F-A639-D30BBA125EE6@oracle.com>
 <3B61FCDD-2684-4E5E-9790-2CEFDF69539D@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B61FCDD-2684-4E5E-9790-2CEFDF69539D@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 15, 2024 at 06:09:20PM +0000, Chuck Lever III wrote:
> 
> nfs4_find_get_deviceid() tries to be clever and do a lookup without
> the spin lock first.
> 
> If it can't find a matching deviceid, it creates a new device_info
> (which calls bl_alloc_deviceid_node, and that registers the device's
> PR key).
> 
> Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
> If it finds it this time, bl_find_get_deviceid() frees the spare
> (new) device_info, which unregisters the PR key for the same device.
> 
> Any subsequent I/O from this client on that device gets EBADE.
> 
> The umount later unregisters the device's PR key again.
> 
> Seems like PR key registration should be done from a more
> idempotent context...?

Yes.  Or at least not do this optimistic reservation.

