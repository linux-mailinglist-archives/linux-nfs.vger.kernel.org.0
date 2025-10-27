Return-Path: <linux-nfs+bounces-15686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C76C0E9DB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 286FF4F7EF3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0212620A5DD;
	Mon, 27 Oct 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7xMSSUo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2DEACE
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576362; cv=none; b=NkxSmUzsV1+MDR6CxCVU0Ti6DANKOkY9kwJFBMmIUbhR+0h+VhpauFdxmXCmg4Dkv3aaaL9YntKP0PpgR5klTQZPTTrKu/0bJB7fYipkCxICkSq3noU+v8NIc6ka2w4fKn6bqUNxhqe0fuKxruY/PjT8Qf+vusSLLYVS0FgWgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576362; c=relaxed/simple;
	bh=I2Qo54OiSDZ4lA/Ja4+tXvcG2rpuyFNYmgvdsFxeUeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4162Y5yFGQyrJF/UcytfvGpXn3YD/SUchHHGiYasHFKj5Qi5CUS+syLnVlbTyHM94AMqISIInb5NFQDaXz1o1ifU9Dc7nrP0y3wSSyEuDm90H2I8jv7lXcLCktYIUh8+LuvapmYR1vTvC63gzH33RvzaaDrgB09p3ITUfwxBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K7xMSSUo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hKP9skxL+Q+/pUSqZcc9o6atGchfhkL0/IuZyGmyiJI=; b=K7xMSSUocfVxXnRFioEc0eiHM+
	J5wcxrxiNIgIS0lOh9qFAecFzzL3Dxe+JP+se3AxGlOSiZOzhr3vXg0fQ1Xqbdhq6eYdZ0iVuFwTf
	IXWsLTxEdmyT2abWqyzWG6pLRKKkGWTnY/z007PScCFKl9xIWUNFqmQiH/9JEU87iTNWpnIA08Fnt
	INQMG/4r6CtszxMhaj0D6GoSC2mLHtlg0UdbHZOFmuCIoIvsFv/Wm4GSXVpVQHw+HTXtvPXvI2Hwm
	6qVIyDVY6iOlMJC9Q6oYXN+PatKbDJkTh6b0a36gIpS57R2/O2vVKzAa3T7TrhzcbZ716rV8/AVkG
	y4HtU/Vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDOTv-0000000E9oL-0J8B;
	Mon, 27 Oct 2025 14:45:59 +0000
Date: Mon, 27 Oct 2025 07:45:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [v6.18-rcX PATCH 2/3] nfs/localio: add refcounting for each iocb
 IO associated with NFS pgio header
Message-ID: <aP-Fp09OEgktqYu2@infradead.org>
References: <aPZ-dIObXH8Z06la@kernel.org>
 <20251027130833.96571-3-snitzer@kernel.org>
 <aP9xVCiY5mYowEoN@infradead.org>
 <aP95wjsM2LndIY1X@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP95wjsM2LndIY1X@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 09:55:14AM -0400, Mike Snitzer wrote:
> I already tried that, in terms of frontend fs/nfs/direct.c and then
> supporting fs/nfs/pagelist.c changes; ended up being pretty nasty (and
> overdone because in general the NFS client doesn't need to do this
> extra work if its not using LOCALIO).
> 
> We only need this misaligned DIO splitting for LOCALIO's benefit
> because in general the NFS client is perfectly happy handling
> misaligned DIO (and sending it out over the wire).

Ok.  Maybe stick that into a comment?

