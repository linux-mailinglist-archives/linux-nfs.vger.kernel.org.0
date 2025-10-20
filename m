Return-Path: <linux-nfs+bounces-15397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D087BEF8E6
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 09:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A803E0CBC
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112462D780C;
	Mon, 20 Oct 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W1nxuBbK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809229E0F6
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943599; cv=none; b=lcOw71r6c5/pQOkxe2pxvSEuLTwu7SNTbN4qvfxIJQKExuKwKoEN5UgEfFZNvjYNeYBBkIf25ualmpk2M2tJgn/IY44w2spQUvjU6rYG9Boq/p2L/VL6EmwQdfPmPaSM6cJxLbirGeHdp529fSeOSYfijdcIo765YyD5yW0aroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943599; c=relaxed/simple;
	bh=sg+79778mwu0cSt6ixp3DbMPo8VM05r0Hk3hj521ZNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9xCORsJjSnq6yZ2V6UC8JPSBS26lria2EmU74NQfipi4rOrM+YbuQdGzSZt1q9EYeJ39NqWf1SDkRa+MKu4cA5VRpNo6xHmMs2HZVA3V9Q4ql5loXxP+UsjIOvZbs8416cyM5RzteTh4JGZ41rFSHZeDSkiM9kJxTd8ppV41sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W1nxuBbK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ss0lPe4lk9vFM3U09x1QtTuwZ+Pxz4NSwCPMRQsQuwU=; b=W1nxuBbKvyMJ2ztbdk5ewiW4BO
	znJT8a8daRBdHo2BfEdyZcpYLNNGhqgpCX/nSM0On14UE1Y/vqBC4lYzpCFoxPHbk5YBEghpSW8mM
	/dyvd/o9zUnHKv+vqBVjITarzfOlw+NUGvzSVc/b2zjKeeQoNBsk6Al/qVFGoLU7Om9aBUAso+9yI
	+ZtYH5zwtk5NWZTbwBaEKou8PVwZeZSnauuOPY7M0J9bFA+BNgQDkX9ak9I8U/80SlofnH/1D4lZH
	7hGV2Jy3IG/rCegRTk/gz3E6bMZ3qOanKhx64A6YHDHJrwFfYBGCqJuyKQJjlb4KohLpXoDV2JiDy
	pG1ya/Cw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAjs2-0000000C7im-0Qwk;
	Mon, 20 Oct 2025 06:59:55 +0000
Date: Sun, 19 Oct 2025 23:59:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
Message-ID: <aPXd6pBQ60yF5tof@infradead.org>
References: <20251013190113.252097-1-cel@kernel.org>
 <aPHBLFrRXwPaasdb@infradead.org>
 <86a22a17-e12f-4f08-8d9d-89b1b97ae2af@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a22a17-e12f-4f08-8d9d-89b1b97ae2af@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 17, 2025 at 09:27:03AM -0400, Chuck Lever wrote:
> On 10/17/25 12:08 AM, Christoph Hellwig wrote:
> > On Mon, Oct 13, 2025 at 03:01:13PM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> >> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
> >> not need a subsequent COMMIT operation, saving a round trip and
> >> allowing the client to dispense with cached dirty data as soon as
> >> it receives the server's WRITE response.
> > 
> > What's the subsequent patch doing?  Having the actual behavior change
> > in the same series would really help to understand what is going on
> > here.
> The subsequent patch is:
> 
>   https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
> 
> We haven't put the two together yet.

Ah, that was a bit confused.  Not helped by reading it at the airport
after an overnight flight :)


