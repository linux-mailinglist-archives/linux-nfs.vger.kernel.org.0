Return-Path: <linux-nfs+bounces-13102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4558DB07474
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9853E16EB09
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F6B2F2C6C;
	Wed, 16 Jul 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="evQmNqMg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260C20110B;
	Wed, 16 Jul 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664571; cv=none; b=TwMIS02eTMPowL4L57Fp486khL73e6gtBPrrPvmwc0alfeR0jMcXScDlVy2ytJZU6f853/TmEa15kD8SZLekFoR6jh/iPBlHzdWQr45OS7BhdSdouRMmmgRFXNgLCTzON9JZ66ynxY9apVU9xDFvOImge1NMUwjINuKxhBPRl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664571; c=relaxed/simple;
	bh=zfVd6uudPT0A2mWCOPL2otPWAe4O+N/A7eamPtvDlnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoNfzJ7TO4lGvSGlJMivN5vBcb06SV/B6r12CesIb1I4ASPtpvLqnwlfwpQqE1PHpoOHgtzZe21pLB5W26afx+QnhH2dGwBV1nk2w7apEMwBDxwPLEmcqbmfNu1A8esZYjekgDPwdAd5CV9d6oo2/xFbgHJyH+mSHnZvIVTCIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=evQmNqMg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pwB6+KuLXmX8sTFJGRhIzkrahYUso5mNqentXsJrQV0=; b=evQmNqMgOcYBmpTsyQr8cCnZss
	RxamGrtqdo59DzGHGL8ArPKN9PLAW5DimQROcRhvjJC0qBfT8U6ReUVeaQtNgQ+e2ftvzMgGwQr2S
	O0qIbNXgGtyGiXbheLTs3uJXu6ixGT/dGxbVuWb/HQ7PrjpLiqRDyC4BWt1r5zZiciq5nKTRywfPb
	xjXCX7/3BFd+tyEL9I4am1lMLZgR6eEJRP6IC08AiXLb3hDAQkm7+msVtXUMvfimbfew9IoZGGrHo
	oUoaMDEFCkmzd2HUliynoUtRvNyrkJnki8hBd98RMTvtr2uAVK86VQcgs6OPK189Duoc7y2mMwpbK
	14KdCkTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc07L-00000007XCH-4AFm;
	Wed, 16 Jul 2025 11:16:07 +0000
Date: Wed, 16 Jul 2025 04:16:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2 2/3] NFSD: Fix last write offset handling in
 layoutcommit
Message-ID: <aHeJ9zBd3msrwOGf@infradead.org>
References: <20250715153319.37428-1-sergeybashirov@gmail.com>
 <20250715153319.37428-3-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715153319.37428-3-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 15, 2025 at 06:32:19PM +0300, Sergey Bashirov wrote:
> The data type of loca_last_write_offset is newoffset4 and is switched
> on a boolean value, no_newoffset, that indicates if a previous write
> occurred or not. If no_newoffset is FALSE, an offset is not given.
> This means that client does not try to update the file size. Thus,
> server should not try to calculate new file size and check if it fits
> into the segment range. See RFC 8881, section 12.5.4.2.
> 
> Sometimes the current incorrect logic may cause clients to hang when
> trying to sync an inode. If layoutcommit fails, the client marks the
> inode as dirty again.
> 
> Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")
> 
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>

Nit: The tag should directly follow the Fixes line without whitespaces.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

