Return-Path: <linux-nfs+bounces-15199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B0BD4E06
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E9580F05
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55FB309DB1;
	Mon, 13 Oct 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJLZow83"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13BE312823
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370093; cv=none; b=FZ6UIaM6fryQAhN6mCwNgHqV/pVdtdDJIve9HX3+rOD5QcmMVVT/n4qdBCFCLwVj8dVqfjyo1NZRshXUaTsUJfZ+2jcg7PDDUKRAZnMKkMtBqxa6egRk1cfmRtz9RV1O2Ot5kga6b/q6mjRWHj25gB6svWOjir354yiq9hq6htE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370093; c=relaxed/simple;
	bh=8eCRen5I4pCzdAZv1JDwo1xANn7FjP8Gs3XEWvHjRaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz9jNcwH+24stwJs4LKG/pSDBSmze3AONOZrdybkZ97uch0CVf06uhfGMqH4Il/3/APbF1eDSmSXnrMQ/MLVvN6hRaU+DvKXTrG0zS/uCaXT4ck0pH08+uj1LALKzVHaWg9F20U3PMcMiN/ijtA9tc8UXy6bqpcxcXtMAeGQR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJLZow83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52760C4CEE7;
	Mon, 13 Oct 2025 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760370093;
	bh=8eCRen5I4pCzdAZv1JDwo1xANn7FjP8Gs3XEWvHjRaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJLZow83MpL8LjvDI9F5Qfa99/pDO0xUjNGl9uWdCXXBIfq2OQhJRcmmZwzAx+f+8
	 F6WKgQFWIwlQ1Z7I6Hc3/7YMa904RlJZvA0MYpSm5PzwV08EVEoxMeHXHtVpZY6jyp
	 qJHaJccvXS10elbegTTiftBu76L/GUIMgNMVXeenlgPATE3z5VMzdc7UgQ8zT4xwFa
	 dTAmYnlIEjgwALbPZv5tX4WDoyN4IZTD8lkcC4fYJT9XlBWHFq0gzw2CnM/dStrA7i
	 FJ4f879f3dxy4901BIf9Q1fsPEFsuqpNZq+MKVICNVgu1LYrWUMcVZgf6QsmN+mSlC
	 X58wSD4nUlxKQ==
Date: Mon, 13 Oct 2025 11:41:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aO0drJGxjyRLwNCK@kernel.org>
References: <aOa0ijW1h-1tynWD@kernel.org>
 <338ffe90-19ee-4185-9668-41e3a79d8851@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338ffe90-19ee-4185-9668-41e3a79d8851@kernel.org>

Hi Chuck,

On Thu, Oct 09, 2025 at 01:46:34PM -0400, Chuck Lever wrote:
> On 10/8/25 2:59 PM, Mike Snitzer wrote:
> > +
> > +static noinline_for_stack int
> > +nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +		  struct nfsd_file *nf, loff_t offset, unsigned int nvecs,
> > +		  unsigned long *cnt, struct kiocb *kiocb)
> > +{
> > +	struct nfsd_write_dio write_dio;
> > +
> > +	/* Any buffered IO issued here will be misaligned, use
> > +	 * IOCB_SYNC to ensure it has completed before returning.
> > +	 */
> > +	kiocb->ki_flags |= IOCB_SYNC;
> > +	/* Check if IOCB_DONTCACHE should be used when issuing buffered IO;
> > +	 * if so, it will be ignored for any DIO issued here.
> > +	 */
> > +	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> > +		kiocb->ki_flags |= IOCB_DONTCACHE;
> > +
> > +	if (nfsd_is_write_dio_possible(offset, *cnt, nf, &write_dio)) {
> > +		trace_nfsd_write_direct(rqstp, fhp, offset, *cnt);
> > +		return nfsd_issue_write_dio(rqstp, fhp, nf, offset, nvecs,
> > +					    cnt, kiocb, &write_dio);
> > +	}
> > +
> > +	return nfsd_buffered_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
> > +}
> 
> Handful of initial comments:
> 
> The current NFSv3 code path, and perhaps NFSv4 too, doesn't support
> changing a WRITE marked as UNSTABLE to FILE_SYNC. I'm not seeing that
> rectified in this patch. I have a patch that enables changing the
> "stable_how" setting, but it's on a system at home. I'll post it in
> a couple of days and we can build on that.

Just a quick follow-up to see if you might have time to either share
your patch and/or rebase NFSD Direct WRITE ontop of it?

> In nfsd_direct_write we're setting IOCB_SYNC early. When falling back to
> BUFFERED_IO, that setting is preserved, and the fallback buffered path
> is now always FILE_SYNC. We should discuss whether the fallback in this
> case should be always FILE_SYNC or should allow UNSTABLE.

Probably makes sense to only set IOCB_SYNC _and_ IOCB_DONTCACHE if
nfsd_is_write_dio_possible() returns true.  So inverting
nfsd_direct_write()'s flow as such:

   if (!nfsd_is_write_dio_possible())
      return nfsd_buffered_write()

   // could push the setting these flags into nfsd_issue_write_dio?
   kiocb->ki_flags |= IOCB_SYNC;
   if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
      kiocb->ki_flags |= IOCB_DONTCACHE;

   trace_nfsd_write_direct(rqstp, fhp, offset, *cnt);
   return nfsd_issue_write_dio()

But the devil is in the details in conjunction with needing to rebase
to deal with your change to pass stable_how by reference, etc.

> Nit: I'd rather use the normal kernel comment style here, where an
> initial "/*" appears on a line by itself.

OK, will use that in general moving forward.

Thanks,
Mike

