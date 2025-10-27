Return-Path: <linux-nfs+bounces-15646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE80BC0C390
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C8CD348ADF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57682E6CC3;
	Mon, 27 Oct 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrfX/elG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23B19D065
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552358; cv=none; b=lNtYOboc/73yoVdv1lX1E1LMdPgYlQbnU+CdxrSiMGbHC7zc6Yhy+FvBWmjPG+UbRu9Dv9seQmqolAvZlTnIMdIl9mxUzO2YOC2dsaBKy2M2WLsbpU/8OzFz76Brb7L6kom0r1Uu2ngRrCibR4OJbe1YiyNHWcCWXafdu8zBrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552358; c=relaxed/simple;
	bh=SJ++OcfvomrltxiBo5b+5UYY7NqfGL/AvAGjQEv/1TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuZj1I8ZKhmvyaUPvF7J26v5plwL7qk8s5oQDNTvT5ZGyseAnOTIrUybZQ95+poepiBdM/NBXkDEj2ktj6+i9hU/3YwItAQDXWUVmkdmFH3DR0U7Cqz9BIv5wxD4yiiRt5r4l27R8YjCVL+ZInhKZ5AVa5gtZ2zhCx3UzK1CF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hrfX/elG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BppNUDpE3lLxXbGk/lXbixeIIZK25DhBc83pPS9r1b0=; b=hrfX/elGFNEs6GIgGgnPrNJ17B
	b0tSGdoCmwNa8YUgp8nCLLAZWTUpwTeTZ6p6dGfy3dL+QQpqQmg8KPxQ+2nS8DZpVHbC4Rkuhf1Ih
	ZVeBowEIrh3j/0Co/5hm3t+/6qKZG0tx8T2W4Jh8/mW4hxwY5h7hcoZb8ozXtxTbxeZTT88/joEZb
	KvZ30JPHMAg6W7VXDd/aUb7OZ9Z38n32hTa0+lOk81orWKr6xEBWN4LOZFaNUvsfRhpZz0SQjp0xA
	mqzHkN59bG7MjW41v9zD7330GdM99FLc2HMfdLjNA7AVbMU9Xvy0vqT6d1x+NEPh9FOeko0H17Rug
	HZtVzufw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIEk-0000000DK58-2eok;
	Mon, 27 Oct 2025 08:05:54 +0000
Date: Mon, 27 Oct 2025 01:05:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
Message-ID: <aP8n4iqMPie83nYy@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-6-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 10:42:57AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Clean up: The helpers in the nfsd_direct_write() code path don't set
> stable_how to anything else but NFS_FILE_SYNC. All data writes in
> this code path result in immediately durability.

No doubting the statement of fact for the current patch set, but this
is probably a bad idea.  Direct I/O still has to flush caches on devices
with a volatile write cache (aka consumer grade SSDs), and it still has
to commit a transaction to record metadata changes for most writes.
Being able to batch these in a commit is a good idea even for direct
I/O.


