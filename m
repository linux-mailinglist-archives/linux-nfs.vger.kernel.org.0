Return-Path: <linux-nfs+bounces-15311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B52BE6439
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559C3622B20
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 04:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1B830DEBA;
	Fri, 17 Oct 2025 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhENtrsU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7630C623
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674096; cv=none; b=sBaRwgnvbUu0cbWtjc/5nCPH8+jURTb04xNRTyyxVa+KxYkJcVYERRIrqL23BV8fnBK7+cmJYHs0v87YeGPPsgeJRF3t28rdhL0W7cQ+vY3muqZGm/obXSVOqWUAUpCyFkfXeFrDX4YN7VxuicbbZ9ZnoBWl/LdiJPq7YrzKnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674096; c=relaxed/simple;
	bh=cMfVVDV9wXtMQWl7yX/WJjBlqlplyrvybFpVqfKFQdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcLfhyvMqEfnmMAAMNLfPSvzgIBG5JXJGKzN3Qxy8qmtGlY8T1U9fqgDlTeYZ/ebZM/xagY/tx8zARkzjcKp24H7t2kDakaOzsMENS34Eeef1oH6DspSpMhEaLrePU9WaxPpuTEVEmbJXt9en3ji/kC0cH2UMvLV1GTL/DALM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZhENtrsU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3AJF7CtadI45lccRQxse7gs1WSs0xPye/A/IN1vNlw0=; b=ZhENtrsUR97YkKFW1EYH/H/S9d
	JZadLxyzjnlQBuQ1ZU7+8S18iwBQnHxqDLvB73X3xD7UG5iMMl2ZxQVm3OBUhsNZ4J+y6QtJ8wcyQ
	GfE+mcECa5sZmk4co6dyAHWe83l5w1Fh39fpXZtymJim+4farBDHSoUMypvtgpdaABM4RU5qgcF1e
	e6bhyDwtT87C4mRchCChbiBwDED/yu+zvWy76DujLcUGM9oC/5eGZQ0p/vtt/iPO414DgMtxK0MqY
	0mGZbLJoqH1WWw5ZWLBaRdqulnKU0WkstkxYX0AcprU1uTfWnzf8vrCvSBC9VFEXHZMKvvdrw/Ew1
	MZgf/V8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9blE-00000006Ust-2C0k;
	Fri, 17 Oct 2025 04:08:12 +0000
Date: Thu, 16 Oct 2025 21:08:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
Message-ID: <aPHBLFrRXwPaasdb@infradead.org>
References: <20251013190113.252097-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013190113.252097-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 13, 2025 at 03:01:13PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
> not need a subsequent COMMIT operation, saving a round trip and
> allowing the client to dispense with cached dirty data as soon as
> it receives the server's WRITE response.

What's the subsequent patch doing?  Having the actual behavior change
in the same series would really help to understand what is going on
here.


