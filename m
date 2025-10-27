Return-Path: <linux-nfs+bounces-15685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4534AC0E9D8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A2314F6E9F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6710025D546;
	Mon, 27 Oct 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xb/Okfwt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97C20ED
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576336; cv=none; b=pka6V+mnwQDsmCKihS5aykNX0raSbpXOzwFraBZnUPGuHp5EY+CGEA/uo2QFRuEcNF0NgJlOs2GeaRfg9gbUinOCukkIQCFiYvaTl1Z+zykA4snJ8FUTX5/HWjExnBycBBU3heUbKr6m93xCxV2j6yYtm1+J+f8X2BQJlkpw87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576336; c=relaxed/simple;
	bh=uwh2o1NZ/WxfKJIYXllYSuIAkkLb2xnj0T7118NSP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNvAO/Fd7kyp3nxL1wkXsCfnGhKotAY8ynUDEqbT6n3reSnvGUUsWvax2WL4/FIvHuQPMsPV6ndfU9/VhU90WgjdLh3MlHrzXCNr/5s3onCVAxN5tKvGaEkfA2aP36osspOr0ZANcms5XauUP6iWPqLBqrXc6lng/JXQkfQocQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xb/Okfwt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1fPpGeDvC+MnNZbh7i2NgDrn3ACsdPzeMfI+W5DU2nc=; b=Xb/OkfwtlaCPzYRz4qaiFeTIdt
	oJsof+tP1zixnGHDyNAPzmcmGqeQYP1v/Dxr+pfHU7ZnDggIMiddm5LqcwMVPRkvZvynGnL0CXVYE
	kd3p/uNZbsZgSPdxeqizgDSo5+K4uSlckHJpCNSrgtL2ppKnaIRkHPU3KbYglLkHPeORy2Wuesv5x
	N7rXb1xO5JE9YmOkGzA+T+1m1cFE3IVbRd5LHKZmAMaKLeKxL2Qrx+mehgJjY+6HKj6OdHhPbAYs8
	06f8lk/zt//KBSP2JExt8KkWZiPmTAzKfQkmXrDKZY9iG93HoUEj0nmES31Sbcc8Da7L6seKYcbFw
	m2HSMJfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDOTT-0000000E9n5-329s;
	Mon, 27 Oct 2025 14:45:31 +0000
Date: Mon, 27 Oct 2025 07:45:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP-Fi1Dg4dxW-22b@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aP8pfpm6jb-Hj92B@infradead.org>
 <07d26450-5a88-41f8-aa5a-32e9d850a2e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d26450-5a88-41f8-aa5a-32e9d850a2e2@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 10:11:28AM -0400, Chuck Lever wrote:
> On 10/27/25 4:12 AM, Christoph Hellwig wrote:
> > On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
> >> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
> >> systems, then it needs an explanatory code comment, which I'm not yet
> >> qualified to write. I don't see any textual material in previous
> >> incarnations of this code that might help get me started.
> > 
> > IOCB_SYNC always needs IOCB_DSYNC as I explained three times now,
> > including a detailed analsys of all users (We really need to rename
> > IOCB_SYNC to __IOCB_SYNC to match __O_SYNC to make this more obvious
> > I guess..)  I still don't understand why we need sync behavior and
> > forced stable writes at all, though.
> > 
> 
> Well the relationship between IOCB_SYNC and IOCB_DSYNC is absent
> from the iocb_flags() helper, which you referred to in email a few
> days ago.
> 
> What would be best, IMHO, would be actual API documentation, since
> there are too many subtleties to expect adequate documentation from
> smart source code alone. Hence my hew and cry for some text I can
> stick in a comment.

The O_DSYNC vs __O_SYNC text is applicable here 1:1.


