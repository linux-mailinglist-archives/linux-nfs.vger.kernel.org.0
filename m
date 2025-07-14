Return-Path: <linux-nfs+bounces-13057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536CB045E9
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 18:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F7016806C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C1260578;
	Mon, 14 Jul 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG/f4Gdw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D3260568
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511659; cv=none; b=UccuACNXMccWQJyNIeE8MJ2DfrWucj9wOGdK+rXTcD5+oiSEuXKVmttQb0hA0SD4/XbiDBRTREirHea1jQH+5DDNMHliNHO32sdQAp+UbXyGBplO1T9ekf1WwBVtcCbNZFK2UzfWjWWkS1ZLhtWMr8/9oBvQN8SXgv/+FusyAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511659; c=relaxed/simple;
	bh=JIEp9aOWFSLK81pppMaZknBjhEbuP88AzmAidgrsO6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1sYQq20jNH9Lm6KSqVi75SFVP36kPW80YoDFC/aheBUUaKXtN3B6A4bOLQDfFSx/g9ouLOTBIVPX/vuLOk7F/Dw3kd4kLyv8RFCZL987+5WbKo/qeUAuenBZL4LytVMHbt6FgS5F5U5vjXttalDXawRqBzkxl4NfIcTLLwNwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG/f4Gdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91E5C4CEED;
	Mon, 14 Jul 2025 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752511659;
	bh=JIEp9aOWFSLK81pppMaZknBjhEbuP88AzmAidgrsO6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG/f4Gdw7CdLtlzIVp4HyzB32cXcK34VPSwFvxd2y0B7Su6R2D1PJI+GEwQ0F1qAQ
	 IntVMiYmOktivH9hlz3DuJqxz9T55CCWoN9VFwi+wjturn7C0StuqIJIhqD1kmzfQd
	 ymOJGhoxFpe0zweHV8s37msoc+fK3SQlV+Fq3RzSrc3du4Ao0FFTawSpd397wd1nIL
	 b5nK8sZMxfmHmwt+4us4wiJm3Zk5tPjkN+ZVX6jM28alsnwU6MEzJKgwT9sdenxodC
	 0x7P+IIXb/HP4GaeSe+Qur0NBWvVgluIw8P+2HWz0jbFyiYq9bujOYJLbo+bt1TjrV
	 Q6e1xs5qZZk7Q==
Date: Mon, 14 Jul 2025 12:47:37 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 6/8] NFSD: add io_cache_read controls to debugfs
 interface
Message-ID: <aHU0qcrxvmcp0hom@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-7-snitzer@kernel.org>
 <e5a0d1e435196c55acbdc491b43b6380cbef5599.camel@kernel.org>
 <6a05d14f-dbf6-4786-ba08-c57f8f4c64e6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a05d14f-dbf6-4786-ba08-c57f8f4c64e6@oracle.com>

On Thu, Jul 10, 2025 at 06:46:37PM -0400, Chuck Lever wrote:
> On 7/10/25 10:06 AM, Jeff Layton wrote:
> > On Tue, 2025-07-08 at 12:06 -0400, Mike Snitzer wrote:
> >> Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
> >> read by NFSD will either be:
> >> - cached using page cache (NFSD_IO_BUFFERED=0)
> >> - cached but removed from the page cache upon completion
> >>   (NFSD_IO_DONTCACHE=1).
> >> - not cached (NFSD_IO_DIRECT=2)
> >>
> >> io_cache_read is 0 by default.  It may be set by writing to:
> >>   /sys/kernel/debug/nfsd/io_cache_read
> >>
> >> If NFSD_IO_DONTCACHE is specified using 1, FOP_DONTCACHE must be
> >> advertised as supported by the underlying filesystem (e.g. XFS),
> >> otherwise all IO flagged with RWF_DONTCACHE will fail with
> >> -EOPNOTSUPP.
> >>
> >> If NFSD_IO_DIRECT is specified using 2, the IO must be aligned
> >> relative to the underlying block device's logical_block_size. Also the
> >> memory buffer used to store the read must be aligned relative to the
> >> underlying block device's dma_alignment.
> >>
> >> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >> ---
> >>  fs/nfsd/debugfs.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
> >>  fs/nfsd/nfsd.h    |  8 +++++++
> >>  fs/nfsd/vfs.c     | 15 ++++++++++++++
> >>  3 files changed, 76 insertions(+)
> >>
> >> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> >> index 84b0c8b559dc..709646af797a 100644
> >> --- a/fs/nfsd/debugfs.c
> >> +++ b/fs/nfsd/debugfs.c
> >> @@ -27,11 +27,61 @@ static int nfsd_dsr_get(void *data, u64 *val)
> >>  static int nfsd_dsr_set(void *data, u64 val)
> >>  {
> >>  	nfsd_disable_splice_read = (val > 0) ? true : false;
> >> +	if (!nfsd_disable_splice_read) {
> >> +		/*
> >> +		 * Cannot use NFSD_IO_DONTCACHE or NFSD_IO_DIRECT
> >> +		 * if splice_read is enabled.
> >> +		 */
> >> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> >> +	}
> >>  	return 0;
> >>  }
> >>  
> >>  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
> >>  
> >> +/*
> >> + * /sys/kernel/debug/nfsd/io_cache_read
> >> + *
> >> + * Contents:
> >> + *   %0: NFS READ will use buffered IO (default)
> >> + *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> >> + *   %2: NFS READ will use direct IO
> >> + *
> >> + * The default value of this setting is zero (buffered IO is
> >> + * used). This setting takes immediate effect for all NFS
> >> + * versions, all exports, and in all NFSD net namespaces.
> >> + */
> >> +
> > 
> > Could we switch this to use a string instead? Maybe
> > buffered/dontcache/direct ?
> 
> That thought occurred to me too, since it would make the API a little
> more self-documenting, and might be a harbinger of what a future
> export option might look like.
> 
> 
> >> +static int nfsd_io_cache_read_get(void *data, u64 *val)
> >> +{
> >> +	*val = nfsd_io_cache_read;
> >> +	return 0;
> >> +}
> >> +
> >> +static int nfsd_io_cache_read_set(void *data, u64 val)
> >> +{
> >> +	switch (val) {
> >> +	case NFSD_IO_DONTCACHE:
> >> +	case NFSD_IO_DIRECT:
> >> +		/*
> >> +		 * Must disable splice_read when enabling
> >> +		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
> >> +		 */
> >> +		nfsd_disable_splice_read = true;
> >> +		nfsd_io_cache_read = val;
> >> +		break;
> >> +	case NFSD_IO_BUFFERED:
> >> +	default:
> >> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
> >> +		break;
> > 
> > I think the default case should leave nfsd_io_cache_read alone and
> > return an error. If we add new values later, and someone tries to use
> > them on an old kernel, it's better to make that attempt error out.
> > 
> > Ditto for the write side controls.
> 
> +1 on both accounts.

I started to implement this just now (so that I can kick v3 of this
patchset out of the nest today) but soon found that debugfs doesn't
provide string-based interface controls.

See simple_attr_open() (which is used by DEFINE_DEBUGFS_ATTRIBUTE).
It only allows u64 to be set/get.

I'll fix the default case to return an error for now though.

Once we graduate from debugfs to a proper per-export control we can
impose string controls/mapping, e.g.:

+static u64 nfsd_io_cache_string_to_mode(const char *nfsd_io_cache_string)
+{
+       u64 val = NFSD_IO_UNKNOWN;
+
+       if (!strncmp(nfsd_io_cache_string, NFSD_IO_BUFFERED_string,
+                    strlen(NFSD_IO_BUFFERED_string)))
+               val = NFSD_IO_BUFFERED;
+       else if (!strncmp(nfsd_io_cache_string, NFSD_IO_DONTCACHE_string,
+                         strlen(NFSD_IO_DONTCACHE_string)))
+               val = NFSD_IO_DONTCACHE;
+       else if (!strncmp(nfsd_io_cache_string, NFSD_IO_DIRECT_string,
+                         strlen(NFSD_IO_DIRECT_string)))
+               val = NFSD_IO_DIRECT;
+
+       return val;
+}
+
+static const char *
+nfsd_io_cache_mode_to_string(const char *nfsd_io_cache_string)
+{
+       char *nfsd_io_cache_string;
+
+       switch (val) {
+       case NFSD_IO_BUFFERED:
+               nfsd_io_cache_string = NFSD_IO_BUFFERED_string;
+               break;
+       case NFSD_IO_DONTCACHE:
+               nfsd_io_cache_string = NFSD_IO_DONTCACHE_string;
+               break;
+       case NFSD_IO_DIRECT:
+               nfsd_io_cache_string = NFSD_IO_DIRECT_string;
+               break;
+       case NFSD_IO_UNKNOWN:
+               nfsd_io_cache_string = NFSD_IO_UNKNOWN_string;
+               break;
+       }
+
+       return nfsd_io_cache_string;
+}

