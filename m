Return-Path: <linux-nfs+bounces-15540-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A00BFE3F7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2293A80E0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79609274B2E;
	Wed, 22 Oct 2025 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb22GTQz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558621684B0
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167371; cv=none; b=i58ldRx0hPLoMwusRHXOr6x1GKZEFeJn9QtZa3Ul4yvvQ9G+kOzo+7+oLW3gAtfO1QLY8KWqbzY/O7eHUb448RoUzG+QLgEUC4LK6HxPX0oy9WS5GbCoYRoXXoWRefelk+/R0T68tBmfiTipVZpVo9tFowcZTPe+1bwMbvcFqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167371; c=relaxed/simple;
	bh=ZRpPVkA7SQoGuTD+JZ3nt3YulFCU3Qc6LbV47f9/GxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDA/sFYP1T5NMDTCTRi/e9Nzn8yDmocshW21nbOw0NJ8IRN8AbbNLZCb7zS4wTHfikwRRvtjQMEvl6IaoRuJOiKGDRjb6Mji6CEzjC7tlkC//FbiYpgkQPHM20+DJFx0PjSMkTEBOvXw4D5v6nNrwh4mRqojRnDwpZ4382JUWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb22GTQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92EFC4CEE7;
	Wed, 22 Oct 2025 21:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761167371;
	bh=ZRpPVkA7SQoGuTD+JZ3nt3YulFCU3Qc6LbV47f9/GxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pb22GTQz1UGu2nz8dfSrENXf0xWBdaQN3nK9J/4cYgTjrSbSlchkXJORPOQac1GAS
	 MWip1Hj7iTj1D2c9M2ZUCf/V5HKH2iVSU8TeM9LO/+S1786JEnwzPX/WnsraV+nQJt
	 j9BDV+QKB9f+qH8yh5VV7SN5FgV1WZzPg8jpNAdLLS4CtcVlqL7TOF4CmX1lm38Q2u
	 o2hrdu5cFDH2Gth4Jqb/UnFyldoKls4Jiv2JIQ6zwss2auzmJBgRxjK2zR48Kmdy6X
	 mm3WiP+fxilm9kdS+67YyYSnto6c38Lq2uFk9te+DLuT3sz87isMizzYAH7ZK/k7CN
	 g6ANAmtQeBuew==
Date: Wed, 22 Oct 2025 17:09:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPlICU5B-sKftqhu@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org>
 <47c1ef78-4864-49bf-99c3-7a0112bca01e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c1ef78-4864-49bf-99c3-7a0112bca01e@kernel.org>

On Wed, Oct 22, 2025 at 03:27:02PM -0400, Chuck Lever wrote:
> On 10/22/25 3:22 PM, Chuck Lever wrote:
> > @@ -1311,6 +1484,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	if (sb->s_export_op)
> >  		exp_op_flags = sb->s_export_op->flags;
> >  
> > +	/* cel: UNSTABLE buffered WRITEs might want some form of throttling
> > +	 *	as well to prevent clients from pushing writes to us faster
> > +	 *	than they can be flushed onto durable storage */
> >  	if (test_bit(RQ_LOCAL, &rqstp->rq_flags) &&
> >  	    !(exp_op_flags & EXPORT_OP_REMOTE_FS)) {
> >  		/*
> 
> Note: the above is an open question. I don't intend to merge this patch
> with the above comment included.

Such a mechanism would benefit all NFSD_IO modes.

As-is, even NFSD_IO_DIRECT isn't sufficient to ensure client's forward
progress if NFS client application is using buffered IO -- because the
client itself can then enter page reclaim (when it exhausts its memory
because it doesn't get any back pressure).

