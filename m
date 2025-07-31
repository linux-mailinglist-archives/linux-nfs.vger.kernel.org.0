Return-Path: <linux-nfs+bounces-13342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA5B17600
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 20:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB881643E1
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 18:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364111E32D7;
	Thu, 31 Jul 2025 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2eHDl20"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042B4689
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985540; cv=none; b=LaaSKIoQwCqKQoHHT0NPvEcvBmCffsdx3Zukgheme+RKGO6TiLRMG8NQVEuQ9b2LDZqQ+1MCZvv4IGZimogC6yT1fQUAEnr4fR7l3TMbk31VAL89QZpTKpkDU4D2mDTLOtUepiCbSMUD33kJkkcAUiAFLhYLakH+weyihZi5UJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985540; c=relaxed/simple;
	bh=UVaL+/JXdCGELP3tKLkssjRnDuEiLUazxfCyhxZ61Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HasUT+4o2F5oKN2VbSkIRNN7xpp2BtW/JM3PjxaqjNeC0kH9VUEY5CSh6jZ9RxzAgmIi7lE0dReHmuh+nMqP7+Tokbe7JtMpo+HfzQARhvTF9z3BLuNRim7ZB1c278JyTFM0LS03E437yZEMLzSeKTHzctl7DVwyIDCRQXz4piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2eHDl20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD48BC4CEEF;
	Thu, 31 Jul 2025 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753985539;
	bh=UVaL+/JXdCGELP3tKLkssjRnDuEiLUazxfCyhxZ61Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2eHDl201++0lpSYHaQt7MElF+7eBeFsesPyLos0Eg4+LErsDxrQepQqXX5CZXab5
	 nqY+JsHddka9gCs7fmnUEUSdHmxbUZQxeKJ5GtBjzFfOOTBVLvbJydkujKn8FWoLC3
	 ZJ6v8tuBRea5pWyNefwftKoahXKL3Vsu0hiucOY534uGn2hMzJE36SjYmCkoAc+jsP
	 UIfT+mVYgJWQGY/mP8QKivHRUEOLi5QN5dSmQz1rBsUSEjwSzb8UiDaC0CWxBKWPmU
	 UnnlNcyjKm8nhjYi7NGYmwqF0nvwRwEW1sQl9AVOcKvANIlKqD0Rm3nJk66ZjFNfR5
	 +E8c8yUnXPudQ==
Date: Thu, 31 Jul 2025 14:12:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 1/3] NFSD: rename and update nfsd_read_vector_dio trace
 event to nfsd_analyze_dio
Message-ID: <aIuyAblu9tSDb2Ae@kernel.org>
References: <20250730230524.84976-1-snitzer@kernel.org>
 <20250730230524.84976-2-snitzer@kernel.org>
 <19f157f743681fe8bb28279747248b0c3ca7b81c.camel@kernel.org>
 <aIuiK06UZpIlklFN@kernel.org>
 <bc045a5f-c99f-47f2-8d48-ffce7befc7ab@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc045a5f-c99f-47f2-8d48-ffce7befc7ab@oracle.com>

On Thu, Jul 31, 2025 at 02:10:09PM -0400, Chuck Lever wrote:
> On 7/31/25 1:04 PM, Mike Snitzer wrote:
> > On Thu, Jul 31, 2025 at 11:31:29AM -0400, Jeff Layton wrote:
> >> On Wed, 2025-07-30 at 19:05 -0400, Mike Snitzer wrote:
> >>> From: Mike Snitzer <snitzer@hammerspace.com>
> >>>
> >>> Rename nfsd_read_vector_dio trace event to nfsd_analyze_dio and update
> >>> it so that it provides useful tracing for both READ and WRITE.  This
> >>> prepares for nfsd_vfs_write() to also make use of it when handling
> >>> misaligned WRITEs.
> >>>
> >>> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> >>> ---
> >>>  fs/nfsd/trace.h | 37 ++++++++++++++++++++++++-------------
> >>>  fs/nfsd/vfs.c   | 11 ++++++-----
> >>>  2 files changed, 30 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> >>> index 55055482f8a8..51b47fd041a8 100644
> >>> --- a/fs/nfsd/trace.h
> >>> +++ b/fs/nfsd/trace.h
> >>> @@ -473,41 +473,52 @@ DEFINE_NFSD_IO_EVENT(write_done);
> >>>  DEFINE_NFSD_IO_EVENT(commit_start);
> >>>  DEFINE_NFSD_IO_EVENT(commit_done);
> >>>  
> >>> -TRACE_EVENT(nfsd_read_vector_dio,
> >>> +TRACE_EVENT(nfsd_analyze_dio,
> >>>  	TP_PROTO(struct svc_rqst *rqstp,
> >>>  		 struct svc_fh	*fhp,
> >>> +		 u32		rw,
> >>
> >> I would do this a bit differently. You're hardcoding READ and WRITE
> >> into both tracepoints. I would turn this trace event into a class a'la
> >> DECLARE_EVENT_CLASS, and then just define two different tracepoints
> >> (maybe trace_nfsd_analyze_read/write_dio). Then you can just drop the
> >> above u32 field, and it'll still be evident whether it's a read or
> >> write in the log.
> > 
> > Seems overkill to me, and also forces the need for user to enable
> > discrete tracepoints.
> 
> Users can enable trace points with globs, so that's not a big deal in
> most cases. What is more important is that, when you define individual
> trace points, you can enable tracing for only reads or only writes.
> 
> The common trope is to define a class, as Jeff suggested. The I/O
> direction is then recorded in the trace point and the extra field
> is no longer necessary.

OK, I'll fix it up, thanks.

