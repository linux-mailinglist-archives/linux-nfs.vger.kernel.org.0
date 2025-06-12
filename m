Return-Path: <linux-nfs+bounces-12350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCCBAD680D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 08:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E317BE4E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 06:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4216B1F0E2D;
	Thu, 12 Jun 2025 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r9ht3Ich"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6F14A8B
	for <linux-nfs@vger.kernel.org>; Thu, 12 Jun 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710015; cv=none; b=nAl5DABcWRmvRmcjIt74GdutmvbR7xP1aLNbL1gRW/YmxPoWUb2tteIOp2mWSkibk2HZ90B5nUg0kIX9MnEE48jHRJx5VaxQ0HmRZxNjDxgWbfWg3xEmj0KpCFrRyyOw728egfKEpGQVX20oU5XummVPKzRR3J3+BpTT6QUSUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710015; c=relaxed/simple;
	bh=rSBekkHQEhO7F+VrAhfiB9+MFlvjVXpfuCkqIwqyISo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r64Qq312KLB4Q5siskFkme6yOXFkwHrfK8OQpGABlTFAlkOCDxSc9LCusoo1qOOZEMWl6u6Tc0RWaSDS3OauPFG1frC9JOZUDAVJ1+Qx8YbmfmAmjRaf0qrG4UxInBl3xUPP3qYSyxkvdL/o/heOHHw23iyDEHbjaGxnaIdoeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r9ht3Ich; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RyLMuPw4ZcGXjOyqy9by47Bqfw4WwcmBdRsfHQI02XY=; b=r9ht3Ich58nbeg6B+Kc/bPoR6J
	f9ZEcpv8Sr8r0tVefvvFOcMnMywVI6nsoChMoS3FdzVsEbbjoKc7/RZvaHTp3qqGsG92Yi12x5wHh
	rMaVAVKITen+7udorEM1kr3H9zPFcsCyhHjdKiQMg3UWkwiwcgGlWjrRElSq+hxV4bsqdHRbfTsQg
	EWDyOicuUvW+cACog7LZQdnq8R30kbsT87fSJtH7maMsjeduFUlV0Ktb9ggj0iNsD4zb22deF6bNv
	MnTH4PH8oO7HtWT9AOfFaQgqgELgsldwrJ3aqWa0k0/umyTi9ESHvTz3aIDV04rsWOcAWCcwh9Mu4
	agMac1cQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPbV9-0000000CKD6-3CyK;
	Thu, 12 Jun 2025 06:33:27 +0000
Date: Wed, 11 Jun 2025 23:33:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	"J . Bruce Fields" <bfields@fieldses.org>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <aEp0t2i3KXAsqvv6@infradead.org>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
 <aEBeJ2FoSmLvZlSc@infradead.org>
 <uegslxlqscbgc2hkktaavrc5fjoj5chlmfdxhltgv5idzazm3h@irvki3iijaw4>
 <aEfE-r2dkuDRUKsq@infradead.org>
 <75iqhi3to6gohuo2o4h3cewslcjzsfyrl7l7x2x3qyiaaecjci@uwoeqjubvqft>
 <aEkoTdJttLesPv6M@infradead.org>
 <tt5y3k7rnnrwwbejkkjubfat334syb2rrdm5rchdui3nwd5dmc@kc3l7wygg6rd>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tt5y3k7rnnrwwbejkkjubfat334syb2rrdm5rchdui3nwd5dmc@kc3l7wygg6rd>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 03:19:29PM +0300, Sergey Bashirov wrote:
> > Normal operation should not cause that, what did you see there?
> 
> I think, this is not an NFS implementation issue, but rather a question
> of how to properly implement the client fencing. In a distributed
> storage system, there is a delay between the time NFS server requests
> a blocking of writes to a shared volume for a particular client and the
> time that blocking takes effect. If we choose an optimistic approach and
> assume that fencing is done by simply sending a request (without waiting
> for actual processing by the underlying storage system), then we might
> end up in the following situation.

I guess this is using block layout and your own fencing?  Because
with the SCSI layout we fence right from the kernel path before
force returning the layout.  The fact that block layout can't do
reliable fencing is the reason why I came up with the SCSI layout,
that can.



