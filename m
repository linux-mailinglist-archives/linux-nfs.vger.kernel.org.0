Return-Path: <linux-nfs+bounces-12407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A1AD8292
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 07:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FD17AD722
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 05:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29101EB5E5;
	Fri, 13 Jun 2025 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IY9wBSAV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA72AD04
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792927; cv=none; b=kUwxvi8Zrgi3a2AOjhzOEYFLAGAoIu98U1LGkPSjLdUbERur+xW+nrLdX72PKq4R9CenLCD+gQ5B+ioj90W4453KrNdk1A+Jo2OUd3BUOx3B/TsXpRSN42O/v+sAp0mPBxYBXBrsCqKDY5oBEyF17LW/1W2Luyn56u79wdpeGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792927; c=relaxed/simple;
	bh=j3pklmel/qWMKfRzw5t9TQhOTb+8yI9Q1Rp/vDzoGmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTrKvKj99R6CU2ExgCzLVfMhTdfCKMjuo10FPYxFYn0+dARJgZ39DWt/RNO93Dl89BoVrL7BiT0915O/sJZUFjYRdThTnXRSzdsv6aXBX6U7Snh29AZc4D3M5ZZreQQBXrcOir6iipT6qciPVMHlej/qxiioBUlwaFXu19FE9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IY9wBSAV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z0AvBqdh7s60Fu67EjVpIHXRWsxlomygePbgLLEZItI=; b=IY9wBSAVm33bBjgKR2/mjuPrS7
	WKdVCuAA3eQmKEI2Gnk3oukxGc4gQffWiKxEqabBfXR9X/qnMdohsIVFo4PZAeXgo7Mh8a+EUZ3ov
	kF7IOQtPFxhq7Psd4hcB52qEO7mmEh4ONwq3Q54HgEFGbS0kGhUE6eD2CTkPziIf66iJwJGJxUQp+
	8kIfWU0kXPqnE1f8gvRmaA07BCv2389dnHmWQivJcpqa+N5j7u+JPf8tmuwPfBIdRi8+qUnyeg+Ve
	n2vFZXi53p6vtydhz7BcJI9RT0FA7e9i8W8CYG909h1r0UPruhLpdmabuWt3Vhh6EbQD3mayxVbRm
	qBMXvSlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPx4V-0000000FOGg-3NPf;
	Fri, 13 Jun 2025 05:35:23 +0000
Date: Thu, 12 Jun 2025 22:35:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] NFSD: Use vfs_iocb_iter_read()
Message-ID: <aEu4m02hW6AZ8drd@infradead.org>
References: <20250613003653.532114-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613003653.532114-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 12, 2025 at 08:36:53PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Refactor: Enable the use of RWF_ flags to control individual I/O
> operations.

The IOCB_ ones, really.

> +	host_err = kiocb_set_rw_flags(&kiocb, 0, READ);
> +	if (host_err) {
> +		*count = 0;
> +		goto out;
> +	}

And if you don't want to explicitly convert from RWF_* flags, this
is pointless.  Just drop it for now and explicitly set the IOCB_
flags we want once we add some.


