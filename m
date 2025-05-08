Return-Path: <linux-nfs+bounces-11601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C988BAAFCEE
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CD43AB4D9
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D704B1E5E;
	Thu,  8 May 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UeK1cC1d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AA26E17F
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714390; cv=none; b=Ea33qR5F7dDXNvGcVh+20lEY21hmSMc74t5cQ1SeoZIN66Oyi/gSOt+s1E7ur6lMKt7piVDNkY3NK+9W/RUJteNqMUc+iex0NiHPJTumIWdGocsYt6QN0GM8VPPFzRiXqZWOyuAx/R/3wMdB9r/MemPdSEfRxEE0MSYNc1uAgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714390; c=relaxed/simple;
	bh=BkmIaAReIY2FDaQMLN/NCrJsFbaabYdVeKAG2MpfIe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjG6Jrd4k2UD6PKi92WHF1L1NBa5FnpR6/krvcufKCl3+UMjMiPsTH4rUiw4oLal4D5iXKG2ul2hMrTn/GnOhkqmtUky9zCeXJOTpnfQiDP8FKHN3eFsTYrncWKunCisMpBO2soEjcsoIdiuNzBVR2GcM39v7oxhXzP3mr/1h6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UeK1cC1d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OVb4CP+nGhEM25PRQ7KRBPOmUDsITBFCKmbjiYPTslE=; b=UeK1cC1dZu5KwMJaf96oSzEBKH
	7Z5Bix+57899jzZX2ssBtR9fVR60HrC452DUyrGfz0G4LybNErRbBoDrqDeAlgNIRMykzrxvkt3rY
	E27YtS5DyWLhRV5K0jj1xv+49UiSdDOFG5sbhg/1Uq+h/siD/3++LDldlphx5VdeFpbZYKOesovZh
	LvBg+QdtpCAtlIcP0dkkDdAkikpTanJY76njDmgWelG6OtK7FrOOyLZ/Q2U2/ZDt73Px7/IJQ4n8B
	45x+R7P9j4Tfdz9gWKg+5rhHXAapNvYQeJ3Bi/jXwhdmBOXp9IOXjj0MKd1dxL/bP7eVjSpgwNSqF
	DsJ7UvrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD2Cg-00000000ujt-43uC;
	Thu, 08 May 2025 14:26:26 +0000
Date: Thu, 8 May 2025 07:26:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 3/4] NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
Message-ID: <aBy_EuRAYrq-T_hT@infradead.org>
References: <20250507140728.6497-1-cel@kernel.org>
 <20250507140728.6497-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507140728.6497-4-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 07, 2025 at 10:07:27AM -0400, cel@kernel.org wrote:
> + * Fills in @rqstp->rq_bvec, and returns the number of elements it
> + * populated in that array.
>   */
>  unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
>  				   const struct xdr_buf *payload)

The caller can simply use xdr_buf_to_bvec as done in my version of
this and we can kill this helper.


