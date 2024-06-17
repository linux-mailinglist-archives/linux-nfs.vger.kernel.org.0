Return-Path: <linux-nfs+bounces-3948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1890BFB5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 01:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E068F1C214B4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 23:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98A190056;
	Mon, 17 Jun 2024 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KDljzpGI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD218F2D1;
	Mon, 17 Jun 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666286; cv=none; b=XVzht4Y95pj05SHpiBPX/t1a2Yc3rkZqAPxjX70+Nr5HaNYTsZKP6SgbwMVtyUijxa03UeGQoOoac3Pd8l7Tdo2nXl4ymeudTIBExhv1lZOSZnXdw+zsSrOS0ZUEK8SNE8D/Ukiwz1yhBbthZuPlSBNkaSFVY3gatJN6nzf+4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666286; c=relaxed/simple;
	bh=8UMxBI1EToWTR5tZasVuwJS9G+8oe6NZxI1MQ4ilcvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INuFRr4xBhck3Fycrn3930ULYUWGpIOr9mm1Cn3A7XO55AwEuJHp4ts/UvlY0UWXTRNgWGlHLmtrR5AlCdyPIZsK6BO9Ri0TkxfCW2muphhIBx3pDKGtUCNTNFIPzvvZ9eUGNODORKIUyF2nDxGdiVy7iCjfOaosQSjwzMrqR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KDljzpGI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y9Jd7sTiklQCLsza9lamlBiQHn1JuoBWARVrfGvMzy4=; b=KDljzpGIzUgr80m/yNUNNxDC9t
	O2nUqAqzuTqkx1KYhj4a/SQA5xnK5fvRRpIjOYfuW2pUwObzaz1Z8KRL+DUxA8qBMowOsoIQymk6p
	f81wPG3efQ65zmp8A5ahZ/aocXo8A6R9Z8uZnDFzq8gz+gk3zZ5kZsmnjB+0oRrIRtU534aIA8VzH
	g/hjsNgItbPANKCOgcrGO5znrXUU/9hpCK6EKaWZbo5TFUmkiSX9FmYtICwTaGuUEi6ZrKKzgINrF
	ldWQaYL079cjnE/vdvX808gZTS2A8nmR9p3yPkhuHd5boSGNvdZi8pizW/aWkMli8TFmyFL533uwR
	6PgFwKFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJLbl-00000002Ykl-3nan;
	Mon, 17 Jun 2024 23:17:53 +0000
Date: Tue, 18 Jun 2024 00:17:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	sfrench@samba.org, Barry Song <v-songbaohua@oppo.com>,
	Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@suse.de>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Jeff Layton <jlayton@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] nfs: fix the incorrect assertion in nfs_swap_rw()
Message-ID: <ZnDEIV3zG2hyunoa@casper.infradead.org>
References: <20240617220135.43563-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617220135.43563-1-21cnbao@gmail.com>

On Tue, Jun 18, 2024 at 10:01:35AM +1200, Barry Song wrote:
> +++ b/fs/nfs/direct.c
> @@ -141,7 +141,7 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	ssize_t ret;
>  
> -	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
> +	VM_WARN_ON(iov_iter_count(iter) != iov_iter_npages(iter, INT_MAX) * PAGE_SIZE);

Why not just delete the assertion like Christoph did?

