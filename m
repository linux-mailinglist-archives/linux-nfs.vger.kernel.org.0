Return-Path: <linux-nfs+bounces-5146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223093F907
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9661A1C221C9
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D34114830F;
	Mon, 29 Jul 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XaDqnHQ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7115539F
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265473; cv=none; b=UuWOjbrH9MV2vXnXvPWsWC+f1eUtDJEBOEE0bBbOE4Cj8ItYzN1ZZtPVaf9FumpBgNzpzQSa+QQ2NG76vT4E/UNJTJGzhAC7Teebvv/a/ktX+e6XUfEWZvoLF580AENX54QOkZFIZRGtElBRx2B1JEVyZfrlNlo0gMb6IhpgggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265473; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYLNBhnMUUA4wTS4aWHLM702o2G3LWC0NosX6/mxmSzduE1/6B9SckwAZdz9AUXskT9cOuH/RNWgVFcbmesapyY8qm2GWgyaYYxVLgDBdNQ+88eHA+4jBIk8dp/TEvbEYx2PB8g/vH551zetcrF3H/otdbj6m49ewvWDEUt7qXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XaDqnHQ1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XaDqnHQ1Jq/EWyIA41n60Bt2o9
	uCmX+MBfgUbWlL+p+aCec9bLTj3PvfYMzgpWaAmdhhMJeaK6at6767ocqQh/ZRSevWa1EZX4kBfsJ
	g3GdjasA3pu1o31Mz0AywG7cCk4Z1ABA6SAniYRk1zatr2oPxc0kbExlnuZKAiqYY7O3+ZzWeGk6j
	1u3rXg6ZXZgWIovfnHeas5IPzN8WXRdV1WdDJkVgvWRmKlaJT1O+PmHeJtwkpue8ZBEb0qlYYGyz9
	lxqkFeu5DXnSi6wztfMzOBvCUvigg+qIqcQmM+mA4UnpoUiL6wJdLf+8ZvqiAqlk1+GbN+WVlr1lp
	H6tmqCSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRvM-0000000BnoG-07UO;
	Mon, 29 Jul 2024 15:04:32 +0000
Date: Mon, 29 Jul 2024 08:04:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/3] nfsd: Move error code mapping to per-version proc
 code.
Message-ID: <Zqevf73tcGxqTChY@infradead.org>
References: <20240729014940.23053-1-neilb@suse.de>
 <20240729014940.23053-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729014940.23053-2-neilb@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

