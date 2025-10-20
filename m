Return-Path: <linux-nfs+bounces-15408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F43BF1B6C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AEBC34CEF3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE83191DA;
	Mon, 20 Oct 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LNh7/lT6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4A2F6563
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969118; cv=none; b=pCzqeEu3Po/xDjD7qLIh04xom9tIcfBF3SmrqEGL4hQbDyRbZac6B+6Ex4jnPV4KPdcw7VVVZsd1DV8tc9FnOZxdomMDkSClH7ipSn2CbNP9Z3gRgKlQ/VqcX9m/rB53ZQjJRZdYGpZreG+sYgncZ8mAxp0laLwZEcc8RJGQqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969118; c=relaxed/simple;
	bh=ulEIJE9PdmsAbbnVqTB1cQDBXy3HikqUS+1TgXZnXUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncZ60zIjvEK7VSh7JhtudKLS6U8S+N/TymGful45Nm+6F/CzwT3TdWyCcM1CfgmfY3Iy7MlXFuXX6HcedqbPzTwmeTAHT0xpWo5J85xVo4qwSkRc/RcZXV+b/w8zDP6LUkECw8Nv729NtH9Nryawy86HHf0hg8Q3s4T9l5JY9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LNh7/lT6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Te78FUGl5HLZxGutkZroe+MntakvvlwKzFpAP++OYmw=; b=LNh7/lT6+Jl4L14lMHxxWfNyjm
	7faLF3RnPCt7n5L8QNVvEwxWUKhVr0uwYhxcUyRnM1tvAwMzEMAbGmLkUYGTMr5ODy9KSIEIx876Y
	4YsoVpD6L/qijFAWDD6p5WgovtS97ifF1dYYgm/ovdzrsiN7X2FPVA7XQQigqBQfQLKhzjHvJn99A
	WDJGBCkAK4doCfOo61WDey18DHBF4BoDmmr7KTrckjHozjjWkjZPIHQEDp4+zpUdRas/UOwff9U/K
	t3b45bTezM8pGvsA+vk/wbDrfKOhbdBWvjPhtE+2JGVEg61W+Tpz+8ZBey38ms22jdggKsmiUqu74
	daoxeU+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAqVa-0000000DtWy-2YdQ;
	Mon, 20 Oct 2025 14:05:10 +0000
Date: Mon, 20 Oct 2025 07:05:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPZBlgnhlocDA6Ps@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
 <67e3763c-d20c-4e1c-b7ff-62b59c385210@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e3763c-d20c-4e1c-b7ff-62b59c385210@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 09:56:02AM -0400, Chuck Lever wrote:
> I tend to agree that I expect an alignment failure will rarely if ever
> happen if we've done our job well.

It should never happen if the job was done properly.  But when -EINVAL
happens it can be just as likely any other mismatched condition.


