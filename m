Return-Path: <linux-nfs+bounces-15997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFEC30D59
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 12:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93334604E2
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF012E3373;
	Tue,  4 Nov 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOiNhHwQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD112DEA71
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257308; cv=none; b=owDMWo0SnxOxR/ejiH+VvoKOeEDV0RIj29VKrFnjf073y21YjmS8YJGC2vYeDCDpQSjfhw7Q5Nwk0dwlv6DbiFAioaRZ28xpAgBbY1Ok1uK3tvDCYsQ/A6coDqo7N2usk/7z0kSSqoyht61R1cKn/OG1HncVVm3crZ03Ut9/0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257308; c=relaxed/simple;
	bh=yh42PHP7TZtkvlDaYTl52cE0YvZ/F1TVC+weLZoFFYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcA4GgjQ/lp7L+PMwOD581IHYyCCsvyQPRkbc6Uu9HLFhFzYtNm9MyKK64AHosOfTqKyv6w4pAKGSxszHCpS0ILGmcdxor/5oue19dJpCpL0drY/0fLB40GdARQNYmglmmliJ4Na/DmPefmTFRH88iI1b3NxZuanHq0R28oXEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VOiNhHwQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BZysN9XnSaNnYn/fKUquLN1b/LaQ00a+m6rznmE15Lw=; b=VOiNhHwQ2svlG8X0CT/M36PgYj
	soqikfR7TbYglJW6LwWxeMVaX7BNIC3tdPUf68P2JefFeJX1B/L1HJMws202wty/L6YsmwCmk6RIq
	QtHfo1bgrZI7Rd/GfWdQvxBFuJIlMyqfP/8Y7b3/cHRLIi9+ulVcSZYFa+OAA0p7fHeV7zQqRgedy
	4l7nBAp5xuot/BgTZ767IMkDt6Qu0gOMdyG4uyrM9RT2AsVyePd+kfcm+n50FcSX9MKRTSAUv5ki7
	UPMBF+uootzMPZtVJUvbxpoeH9enPuXTFUUkaIyEHngBh54tQ9mnHHObYV5S0etSWezrzYKS88UYw
	PEkh/aqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFct-0000000BkKJ-3kp9;
	Tue, 04 Nov 2025 11:55:03 +0000
Date: Tue, 4 Nov 2025 03:55:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 10/12] NFSD: Handle kiocb->ki_flags correctly
Message-ID: <aQnpl-vGN_kdUtoP@infradead.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-11-cel@kernel.org>
 <176221099980.1793333.459150691694156959@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176221099980.1793333.459150691694156959@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 10:03:19AM +1100, NeilBrown wrote:
> > So, observe the existing setting of ki_flags rather than forcing
> > persistence unconditionally, and ensure that DONTCACHE is not set
> > for IOCB_DIRECT writes.
> 
> Of the write has no prefix or suffix and so is entirely O_DIRECT, then
> we get DATASYNC for free do we not?

No.  O_DIRECT still needs IOCB_DSYNC for datasync semantics.

