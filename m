Return-Path: <linux-nfs+bounces-13334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B5B17563
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0726544A8A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0651DE8A8;
	Thu, 31 Jul 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aELc4JH6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832F72637
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981485; cv=none; b=VAe8Zp47VTx34X284OuWfkzwqqJphzj/D/UW+bwn9Lfa6pyKqEvZL9pvM10YGH/vsKAcEfQb1ij8HxOiRlcqNMqF7SGCMWLeBd9kqfKVUGk7zJNqTGZYCs0sgMUQpV8WQqPWmo/BCjaPa4GmtAp89XcHz8iLQ0JtfZQWJdR5FtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981485; c=relaxed/simple;
	bh=n8Qdtkc2uaQ3V/P1xf5ScOY3vxjdEbsxY/wA4OTqP7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0J1bwvUjn6lVuLQcwbUMgnAyOg9x5HLlCpVfzOVYGeyH6Kw5UEkxEpgxcxo+Z+KOo5PPbB3cqsPHB7Onk/rknszSHHF7YGviyQnnGaSkbsviLUrwrjnXhRUn/0NRRD83pvakLgkhmrBLePK6QGVTM1EzH+cpKD49P8lbtstHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aELc4JH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19E4C4CEEF;
	Thu, 31 Jul 2025 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753981485;
	bh=n8Qdtkc2uaQ3V/P1xf5ScOY3vxjdEbsxY/wA4OTqP7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aELc4JH6otbPCJ36+o2SV+r66ua0dY/vwTrAszQnUiQcTWG351KMv6HGlgrNN/J5m
	 jeaMh7RCyVyZ9FoueHTWWnc4x6eYZBvK6H9mrEdcOJTji+zj6yaHWGlJN6u8qtfuiF
	 H9B4rbGHY+0pTP3lk1WhmGXaf9cem4zuMer7dDErSn5nViGcl8E/7DHfEYoaeIu3RQ
	 I2DVo9PWNhyCTSK9zCGHeaecV91qADbun7IlM1lDwQrrMRcKKXZTpAMdmGnYeECET1
	 Ca88Wp0pdjm2myEiD/SPWuuv3JCWqgxZr4fVD5zb8xrk9N4ii+zJIa42BvbTsCze+9
	 SNS2ElqhKE8jw==
Date: Thu, 31 Jul 2025 13:04:43 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] NFSD: rename and update nfsd_read_vector_dio trace
 event to nfsd_analyze_dio
Message-ID: <aIuiK06UZpIlklFN@kernel.org>
References: <20250730230524.84976-1-snitzer@kernel.org>
 <20250730230524.84976-2-snitzer@kernel.org>
 <19f157f743681fe8bb28279747248b0c3ca7b81c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f157f743681fe8bb28279747248b0c3ca7b81c.camel@kernel.org>

On Thu, Jul 31, 2025 at 11:31:29AM -0400, Jeff Layton wrote:
> On Wed, 2025-07-30 at 19:05 -0400, Mike Snitzer wrote:
> > From: Mike Snitzer <snitzer@hammerspace.com>
> > 
> > Rename nfsd_read_vector_dio trace event to nfsd_analyze_dio and update
> > it so that it provides useful tracing for both READ and WRITE.  This
> > prepares for nfsd_vfs_write() to also make use of it when handling
> > misaligned WRITEs.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> > ---
> >  fs/nfsd/trace.h | 37 ++++++++++++++++++++++++-------------
> >  fs/nfsd/vfs.c   | 11 ++++++-----
> >  2 files changed, 30 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 55055482f8a8..51b47fd041a8 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -473,41 +473,52 @@ DEFINE_NFSD_IO_EVENT(write_done);
> >  DEFINE_NFSD_IO_EVENT(commit_start);
> >  DEFINE_NFSD_IO_EVENT(commit_done);
> >  
> > -TRACE_EVENT(nfsd_read_vector_dio,
> > +TRACE_EVENT(nfsd_analyze_dio,
> >  	TP_PROTO(struct svc_rqst *rqstp,
> >  		 struct svc_fh	*fhp,
> > +		 u32		rw,
> 
> I would do this a bit differently. You're hardcoding READ and WRITE
> into both tracepoints. I would turn this trace event into a class a'la
> DECLARE_EVENT_CLASS, and then just define two different tracepoints
> (maybe trace_nfsd_analyze_read/write_dio). Then you can just drop the
> above u32 field, and it'll still be evident whether it's a read or
> write in the log.

Seems overkill to me, and also forces the need for user to enable
discrete tracepoints.  Could be good, could be bad.

But if I should be taking your feedback as: "do what Jeff suggested",
that's fine too, happy to do so! ;)

Thanks,
Mike

