Return-Path: <linux-nfs+bounces-15848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F776C253FA
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FCD1A6309E
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDFB169AD2;
	Fri, 31 Oct 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H0Q1rb5o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399834B667
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917009; cv=none; b=OMybtqtuYex2d1cNy+8KUxCOO2gAYJqrAhPsHlyyab+7QUUre46K6KWUY50g/thLKB0UBzXlcg8hBZEm1P0KAB/ce1hgLQoxHW3xmDNj+ApyPo2OH7vsbWDPMweVbS37wQ76rGrpMO02FTGG83nbHxiHtCv1WpUvSw+fYVM7zkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917009; c=relaxed/simple;
	bh=Swpc13vCpOHPvxQbFkQ+dheZogwv8w1x1M0fbz9bo44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqvR7gw6H9hZ+7Vq56Fst+TtaiSHanHv9NM308HseB8nuMNfRJ8BFpgzbs3emOMbKTtzaqzN0kraQvN2gXZMQ4JnWDHPH6S3gNQyPMD7YSznPWRRzIHD4mrAf3TfDIOWRDS08RxwWicIND/+sT2j25j2VzP2GZRia3dIyn3Uo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H0Q1rb5o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C+gZxWEiZkuFlNW3PYlR/SbghwfhTlAa+7lpdPufS3k=; b=H0Q1rb5oIwJo1AA6ENo3UWCDLi
	y3RVTqnExBsZ0OGNuqPXnX0SuZNTareNDJxkDPDT4IBwp7RRGFC/FIeAwakgrRslt7ppTHcl3OVgs
	cSPlzaXEkE6ARhG6V9ct6W4G/dFCJeb0sIxSLArws4/yqLJ0s4MfIpwBcxvwLkSVbadW6ttE21mBi
	bqxknW5loTU6ippZoD1I5nzaQOklsZAgFZ7zPq75znbpPeKyDNG8S0Ih3vYG1++JP1K3uzn7F58Xb
	XtuBkKgKTgk+kL3FJW7NZwy5Jah3KgLOg0xNIzouWpHpEUr35jQM4CldD+2Eix2jtYXG+BDQc9Hx8
	oi7xARLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEp6D-000000069j6-2sF0;
	Fri, 31 Oct 2025 13:23:25 +0000
Date: Fri, 31 Oct 2025 06:23:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment
 for direct I/O
Message-ID: <aQS4TfOJ8WoGBZn-@infradead.org>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-10-cel@kernel.org>
 <aQS3U0bfw6X3J7J2@infradead.org>
 <88535f7a-abc7-4649-a2b4-ba520e9aae0b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88535f7a-abc7-4649-a2b4-ba520e9aae0b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 31, 2025 at 09:21:27AM -0400, Chuck Lever wrote:
> > How likely is that going to happen?  After the first bvec the
> > alignment constrains won't change, so how are we going to succeed
> > then?
> > 
> 
> I was hoping that this algorithm would improve the likelihood of
> finding a middle segment alignment for NFS WRITE on TCP. I'm not
> entirely sure it has been effective.

Maybe I misremember the nfsd buffer management, but didn't you just
rely on the fact that any but the first bvec is page aligned? And
given that we have no holes I don't really see how we'd get better
aligned later.  But I might just be very confused here, sorry.


