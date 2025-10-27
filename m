Return-Path: <linux-nfs+bounces-15651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF147C0C447
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 741BE34A599
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E422E7BC3;
	Mon, 27 Oct 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Xdchoto"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F82E717B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552961; cv=none; b=fefhFK9yTkmBMvpDh7hayY8aJjKKe8pDI5445ejRBiHHNJN3eVY+PUWU/FwTDVVzApaltJmCtCdE45zCdtewH1LGlt2xHH4Ce+i7/hEK2il6KHs6IF3rqAolhuynyl+i/ns9uzydea05jTz8sN1rSLtCht7Z91Z8xlAvFP0zVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552961; c=relaxed/simple;
	bh=wtDJc1DEyuijRK9N1+gXnj8hcCdiIVA0c7M+oh1DDc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7tDSVC3BCOHNwZRGod49s47hliHkGa40sEJJBX6S8vRq8DBc5JZcJWNP2aN0WeyEtN2WBCyGTY/OLt7mT+f0u6T1A2lNjYOUYXlt3JtjvIpTblqTox4GF9Qjy1MVGX0CkjWYEH7vnLoPu/Ll4SajjrOxecWeVYqorLQKSk7BQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3Xdchoto; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fo8qbTdDoSa6DPAncF9eMdhIyPwpi67FS7U3d8WAwlU=; b=3Xdchoto69/WbgApSIICKswEIV
	2slqa5IDU/UT7qp+vLgWUlnIXzSwUWK5CK6+Jkqw1UJ4uCNNZNjSnLnx0ucTByStoSz4IcJcxr6Qu
	Emg7I0CLuUSHyL4cLmPlnKyhfMmariOiDZjm67j8eF0FNYvmzqAWPbRFWCyaW6DK/8C+a1+IRUC+K
	02Jw5QxL9LjsqL4RnhxpW3JTgUGGu+K7KziSrk+68vUJjH4KElKWqu8gw5taJ99lACIRgnPwzwAav
	oZVFlcGygXA1+btjhKcD/mRr9RUTzzmUFFQnhFvkySoubEulSmNDdnH6gUC7T4Mi6uX4j5fZ0QryI
	0bGKU3SQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIOU-0000000DKmI-349S;
	Mon, 27 Oct 2025 08:15:58 +0000
Date: Mon, 27 Oct 2025 01:15:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP8qPlA7BEN3nlN8@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPwSS9NlfqPFqfn2@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 07:56:59PM -0400, Mike Snitzer wrote:
> Really, even ignoring all the quirkiness of this: that O_DIRECT can
> fallback to buffered, and we need IOCB_DSYNC|IOCB_SYNC for our use of
> buffered IO when NFSD_IO_DIRECT configured to ensure data has hit
> stable storage -- that's enough justification.  Bit circular but
> compelling to prove the need.. albeit wordy and a lot to unpack.

You always need IOCB_DSYNC for data to hit stable storage, both for
buffered and direct I/O.  You need IOCB_SYNC in addition to also sync
out the timestamps, which I think we now agree we need.  I still don't
understand why using direct I/O implies that we want NFS stable writes
and not two-stage writes, though.


