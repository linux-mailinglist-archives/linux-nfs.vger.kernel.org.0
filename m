Return-Path: <linux-nfs+bounces-15799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A64C21039
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 16:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99D424E8920
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BA1F4CBE;
	Thu, 30 Oct 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B/6NC/5L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7E37A3BC
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839147; cv=none; b=o7iYAKKjTllNt9MW+sWM5F+nR7iH+BX6OUXN8kNqV0o1EBFVTA+HCU+J+5NRu+889322acATLZxU546DpGAJy7d0Pt+hLFFxAsn63xko9ScasJlvFQ97Ubm2Dh2WAnwj0D0xqPqks67eSwAwjajt/AvTcQAjmGyFwZ5LfYrZzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839147; c=relaxed/simple;
	bh=CvSsSFLJ8lznithJTimZf8GhH+UdCns8VpuiWpG+BSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akc1MhGKhoHQryR6EzWGUdwe4Q5jZQjoEaLnCRlUIGDwT9au8I3n5BMK0sVxPMxC/UPi8ZCSOg7ETDNBj2bMkZBtsq9hCfyG8cMqq8WKjmH61OcgoFHotaBgBKMWGFIf+fjgnNuuWu78ybtIguWU7WO9P9+auBRppNs8wRAxui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B/6NC/5L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HnwdtFIYOPHkbjpVufRxE1grCs4XYVDiA3GWNKq2K48=; b=B/6NC/5LkNqsDJ/nQyFnPNUOPh
	upm7i0rfWsfjFoqLhvqADdPmAC5L675AU++eHAm0c4SGbzXX3x8TrykTg0y1j4sWxwPtaL45cv/JY
	0Kd1jAlhD+WYYSlTnIslwUZGy9YLTJ+3ZOP/+csbz3ClbMiVwRFKMzlTuSFkss2BrOfIrcs3c+E5b
	5mTbje32wl9wTG26OFanElpvdJyWhojwDm4ybU/wsT/9mdL5Lbu8N0HXjiLJp2XyUh1oc0zp6+qH8
	LQhsliCGVU4M8kmIQv50+BP+YqvokNuc04PxfccUx+q4A41kxSNEeN1f8C4Ydgxu8/aRMN2VE4COu
	6+1C6vIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEUqM-00000004PHi-3rz3;
	Thu, 30 Oct 2025 15:45:42 +0000
Date: Thu, 30 Oct 2025 08:45:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Add a "file_sync" export option
Message-ID: <aQOIJtjQvLjBNk3G@infradead.org>
References: <20251030125638.128306-1-cel@kernel.org>
 <aQN0Er33HIVmhBWh@infradead.org>
 <aQOFLMJzUZuwj_K7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQOFLMJzUZuwj_K7@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 30, 2025 at 11:33:00AM -0400, Mike Snitzer wrote:
> Sure, but not all modern networks have the same level of performance
> either.  When the NVMe is faster than the network we don't see nearly
> as much MM pressure.  But that implies the network is the bottleneck, so
> reducing network operations (like COMMIT) should reduce network
> traffic (even if marginally).

There is a lot of code between the network and the storage, and they
tend to be slower than either for many common workloads :)

> Once the network is as fast or faster than the NVMe devices, that's
> when we've seen VM writeback/reclaim with buffered IO become
> detrimental (when the working set exceeds system memory by a factor of
> 3:1).  And that's where NFSD_IO_DIRECT mode has proven best.

I bet that getting VM writeback out of the stack helps at lot.  But as
mentioned I doubt forcing stable writes helps, and in fact for most
workloads will actually make it slower.  But that's just my experience
from similar but not the same things, so I'd love to see numbers if
you suspect something else.  Either way we're much better off changing
one variable at a time instead of forcing two totally unrelated changes
to go together.

> Christoph, if you have canned benchmarks that do a solid job of
> showcasing overwrites (which you expect to really benefit from _not_
> having DSYNC or DSYNC|SYNC set) please let me know.

None with nfs in the loop.  For an older benchmark with purely
local I/O, 3460cac1ca76215a60acb086ebe97b3e50731628 has an example,
which should be pretty representative for modern workloads, even if
the overall numbers for each case would improve a lot.


