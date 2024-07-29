Return-Path: <linux-nfs+bounces-5188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0009400C9
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 00:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EBB1F23014
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53137186E29;
	Mon, 29 Jul 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r69Ox+Oy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3861B86D6
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290476; cv=none; b=Xmvk+rsUAhYu3+7xiirP9/OglEzqxwvlZUqAx7nTnFw5cKXtxREG2YyqLvrL4u2maEiGFYUIwG/M/FbznohKc8KNSBtV3KfLHgPWK3UnA8eSIQGdnW9sleA7/QZhAe7C4j5aM0P9x2Ozm1clKJmYrD7nWIho/xw8zbOyhw7NLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290476; c=relaxed/simple;
	bh=NlE+miUjslxTQ218RUD55FTPNHyOFEQ+EhupTljrSHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iABPMZb7WjRIi32zKDQUatO3g1K0xUuFibnPkf7EkcIWvfM42rKGGHPA1+k/3lf8uJ1Dd8B+0zP7xNVeBkEuc7kpmwToGgVXgKnpdtXV3gVzgWaaDwN2jbNGDCu544NCPYWLtGbm/euKCNg78igURvN+Wz58TCDbmNDytRVVii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r69Ox+Oy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uJjZR836f7WCwFa6+ZTuqil6WAH50RCQlF9XcQ+XhAg=; b=r69Ox+OyzRoaL+X4oiUy90xk8v
	WVKC149BJBA6V5hDO2eAbdoyfaEU/CFQKt37d2RsldszJpmA03KzP7/Kxao0aBFghnrzTQBnFS0tP
	tJoJAt/evKoJmGcYDjYidjxbn6eXfwiDNlciQVXgWSVu6OCcZikIPmh6TYE9d3Bv/EiOpXap/t7cx
	fuw922c0eplkx9rgXxLlG7MGhsBDMxJRf6bS3fAPtNYLQLzAsbL/xWitB5exZ3JLI7UFoy7CT1K92
	OERDEPhVe4+VbSa7UKkRVHxfS4lizwinsjF2XXXCMez3TClsP4QXG3ODjjgI7vJw60cJGzMnSkHJG
	7hINP+5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYYQb-0000000CqjY-0GSO;
	Mon, 29 Jul 2024 22:01:13 +0000
Date: Mon, 29 Jul 2024 15:01:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
Message-ID: <ZqgRKU7rYXo4ncEG@infradead.org>
References: <20240729022126.4450-1-neilb@suse.de>
 <Zqeo1c37E6xDDgSA@tissot.1015granger.net>
 <172228724989.18529.183021144838147324@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172228724989.18529.183021144838147324@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 30, 2024 at 07:07:29AM +1000, NeilBrown wrote:
> > Also, 1/2 is From: your brown.name account, but the SoB is your
> > SuSE email. (Maybe that doesn't matter).
> 
> Probably don't matter.  That happened because I wrote that patch on my
> notebook instead of my desktop and they have different defaults.  I'll
> try to remember that for next time.

The signoff is supposed to match the author address.  If you send it
out using a different email account you need to add a separate From:
line to the mail body.  git-send-email will do that automatically for
you.


