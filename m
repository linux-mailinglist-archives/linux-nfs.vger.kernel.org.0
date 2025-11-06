Return-Path: <linux-nfs+bounces-16155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE5C3D55B
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 21:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 527254E12FF
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0A2E7193;
	Thu,  6 Nov 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+WNJDQX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACC2E6CD0
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460242; cv=none; b=oIJmgEAIzazkKL40jJi5f7SOBZTB2zKiv5WM2KzcC66UQvXybiu8VznKzcs1roFdXo6ebRvi4DUe5mWATCVdaYFOQWJGiZFMnHPdFlOaMf7o12+zfgbStiTE2Jjr51KkUmxBB11iTQtBZ+F7PDbqScl6QNbbDrAa8XYS7icyprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460242; c=relaxed/simple;
	bh=OZtL5kAOLmam0tXq1YWknNY8uKXU/Lmaovlpf1V3g94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Cgc6EosuJUt9Dqs7qDqul35n4d5EvWjdPynF9bwADnNvVhLm+wjIEyD5EDC+slctLMRGVa+E9j4msiu1bepM97Q+wOBekheRe6rkUF8kvcOuDBr3PKAkWKmen/p9Mppt4DsCqlabE8S2FF7Dkvs6j0LDFeFDf7KONgbiIJeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+WNJDQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F626C4CEFB;
	Thu,  6 Nov 2025 20:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762460241;
	bh=OZtL5kAOLmam0tXq1YWknNY8uKXU/Lmaovlpf1V3g94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+WNJDQXgx/JpKE5Pn6MY/jqwUkpA8ti+fGRSqHSQpms5aBLm0tuWXMrthJkHF+FN
	 e2ZHm9lMOHQDb0WUeY3O3eZN4j3K22aUYgkdFrqMhmnh9HiDZpx5owyc35g80Heiso
	 3x6omT6tip058NcE0O6dBEcNCEbzB7+C9tFerN8CwMF9ga/aEUe22Rei7P9Ajjf4Kh
	 A6q/EXdKbwqAYX9Aq2IQXqULyzzf17d3RNjtIoqioyuqK02vhG9BVELppBtJlqiJ10
	 mVA7aWv9XME+F1ujfE2/2hYHP5Ejz3rCydCUnK/UyN/LA6tUazjzyVCN1DoeYabgyj
	 /v2rj2OqoTovQ==
Date: Thu, 6 Nov 2025 15:17:20 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
Message-ID: <aQ0CUPcYYg6-5IJ1@kernel.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
 <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>

On Wed, Nov 05, 2025 at 01:49:29PM -0500, Chuck Lever wrote:
> On 11/5/25 12:42 PM, Mike Snitzer wrote:
> > NFSD_IO_DIRECT_WRITE_FILE_SYNC is direct IO with stable_how=NFS_FILE_SYNC.
> > NFSD_IO_DIRECT_WRITE_DATA_SYNC is direct IO with stable_how=NFS_DATA_SYNC.
> > 
> > The stable_how associated with each is a hint in the form of a "floor"
> > value for stable_how.  Meaning if the client provided stable_how is
> > already of higher value it will not be changed.
> > 
> > These permutations of NFSD_IO_DIRECT allow to experiment with also
> > elevating stable_how and sending it back to the client.  Which for
> > NFSD_IO_DIRECT_WRITE_FILE_SYNC will cause the client to elide its
> > COMMIT.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/debugfs.c |  7 ++++++-
> >  fs/nfsd/nfsd.h    |  2 ++
> >  fs/nfsd/vfs.c     | 46 ++++++++++++++++++++++++++++++++++------------
> >  3 files changed, 42 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > index 7f44689e0a53..8538e29ed2ab 100644
> > --- a/fs/nfsd/debugfs.c
> > +++ b/fs/nfsd/debugfs.c
> > @@ -68,7 +68,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
> >  	case NFSD_IO_DIRECT:
> >  		/*
> >  		 * Must disable splice_read when enabling
> > -		 * NFSD_IO_DONTCACHE.
> > +		 * NFSD_IO_DONTCACHE and NFSD_IO_DIRECT.
> >  		 */
> >  		nfsd_disable_splice_read = true;
> >  		nfsd_io_cache_read = val;
> > @@ -90,6 +90,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
> >   * Contents:
> >   *   %0: NFS WRITE will use buffered IO
> >   *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> > + *   %2: NFS WRITE will use direct IO with stable_how=NFS_UNSTABLE
> > + *   %3: NFS WRITE will use direct IO with stable_how=NFS_DATA_SYNC
> > + *   %4: NFS WRITE will use direct IO with stable_how=NFS_FILE_SYNC
> >   *
> >   * This setting takes immediate effect for all NFS versions,
> >   * all exports, and in all NFSD net namespaces.
> > @@ -109,6 +112,8 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
> >  	case NFSD_IO_BUFFERED:
> >  	case NFSD_IO_DONTCACHE:
> >  	case NFSD_IO_DIRECT:
> > +	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
> > +	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
> >  		nfsd_io_cache_write = val;
> >  		break;
> >  	default:
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index e4263326ca4a..10eca169392b 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -161,6 +161,8 @@ enum {
> >  	NFSD_IO_BUFFERED,
> >  	NFSD_IO_DONTCACHE,
> >  	NFSD_IO_DIRECT,
> > +	NFSD_IO_DIRECT_WRITE_DATA_SYNC,
> > +	NFSD_IO_DIRECT_WRITE_FILE_SYNC,
> >  };
> >  
> >  extern u64 nfsd_io_cache_read __read_mostly;
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index a4700c917c72..1b61185e96a9 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1367,15 +1367,45 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
> >  		args->flags_buffered |= IOCB_DONTCACHE;
> >  }
> >  
> > +static void
> > +nfsd_init_write_kiocb_from_stable(u32 stable_floor,
> > +				  struct kiocb *kiocb,
> > +				  u32 *stable_how)
> > +{
> > +	if (stable_floor < *stable_how)
> > +		return; /* stable_how already set higher */
> > +
> > +	*stable_how = stable_floor;
> > +
> > +	switch (stable_floor) {
> > +	case NFS_FILE_SYNC:
> > +		/* persist data and timestamps */
> > +		kiocb->ki_flags |= IOCB_DSYNC | IOCB_SYNC;
> > +		break;
> > +	case NFS_DATA_SYNC:
> > +		/* persist data only */
> > +		kiocb->ki_flags |= IOCB_DSYNC;
> > +		break;
> > +	}
> > +}
> > +
> >  static noinline_for_stack int
> >  nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
> >  		  unsigned long *cnt, struct kiocb *kiocb)
> >  {
> > +	u32 stable_floor = NFS_UNSTABLE;
> >  	struct nfsd_write_dio_args args;
> >  	ssize_t host_err;
> >  	unsigned int i;
> >  
> > +	if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_FILE_SYNC)
> > +		stable_floor = NFS_FILE_SYNC;
> > +	else if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_DATA_SYNC)
> > +		stable_floor = NFS_DATA_SYNC;
> > +	if (stable_floor != NFS_UNSTABLE)
> > +		nfsd_init_write_kiocb_from_stable(stable_floor, kiocb,
> > +						  stable_how);
> >  	args.nf = nf;
> >  	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb, *cnt, &args);
> >  
> > @@ -1461,18 +1491,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  		stable = NFS_UNSTABLE;
> >  	init_sync_kiocb(&kiocb, file);
> >  	kiocb.ki_pos = offset;
> > -	if (likely(!fhp->fh_use_wgather)) {
> > -		switch (stable) {
> > -		case NFS_FILE_SYNC:
> > -			/* persist data and timestamps */
> > -			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
> > -			break;
> > -		case NFS_DATA_SYNC:
> > -			/* persist data only */
> > -			kiocb.ki_flags |= IOCB_DSYNC;
> > -			break;
> > -		}
> > -	}
> > +	if (likely(!fhp->fh_use_wgather))
> > +		nfsd_init_write_kiocb_from_stable(stable, &kiocb, stable_how);
> >  
> >  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> >  
> > @@ -1482,6 +1502,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  
> >  	switch (nfsd_io_cache_write) {
> >  	case NFSD_IO_DIRECT:
> > +	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
> > +	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
> >  		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
> >  					     nvecs, cnt, &kiocb);
> >  		stable = *stable_how;
> 
> 
> I asked for the use of a file_sync export option because we need to test
> the BUFFERED cache mode as well as DIRECT. So, continue to experiment
> with this one, but I don't plan to merge it for now.

Doesn't the client have the ability to control NFS_UNSTABLE,
NFS_DATA_SYNC and NFS_FILE_SYNC already?  What experiment are you
looking to run?

If just looking to compare NFS_FILE_SYNC performance of
NFSD_IO_BUFFERED versus NFSD_IO_DIRECT then using the client control
is fine right?

Anyway, maybe I'm just being overly concerned about the permanence of
an export option.  I thought it best to avoid export for now given we
do seem to have adequate controls for a NFS_FILE_SYNC performance
bakeoff.

Here is a rebased patch that applies ontop of Christoph's cleanup and
my incremental Documentation patch.  I would appreciate us exposing
this NFSD stable_how "floor" control so others can try.  But if this
still isn't OK, due it to being in terms of NFSD_IO_DIRECT debugfs
knobs, then I can pursue a generic export option that works for all
NFS IO modes.

Thanks,
Mike

From: Mike Snitzer <snitzer@kernel.org>
Date: Thu, 30 Oct 2025 17:53:09 -0400
Subject: [PATCH v4 rebased] NFSD: add new NFSD_IO_DIRECT variants that may override stable_how

NFSD_IO_DIRECT_WRITE_FILE_SYNC is direct IO with stable_how=NFS_FILE_SYNC.
NFSD_IO_DIRECT_WRITE_DATA_SYNC is direct IO with stable_how=NFS_DATA_SYNC.

The stable_how associated with each is a hint in the form of a "floor"
value for stable_how.  Meaning if the client provided stable_how is
already of higher value it will not be changed.

These permutations of NFSD_IO_DIRECT allow to experiment with also
elevating stable_how and sending it back to the client.  Which for
NFSD_IO_DIRECT_WRITE_FILE_SYNC will cause the client to elide its
COMMIT.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 .../filesystems/nfs/nfsd-io-modes.rst         |  6 ++-
 fs/nfsd/debugfs.c                             |  7 ++-
 fs/nfsd/nfsd.h                                |  2 +
 fs/nfsd/vfs.c                                 | 54 +++++++++++++------
 4 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
index e3a522d09766..a2194ec45c76 100644
--- a/Documentation/filesystems/nfs/nfsd-io-modes.rst
+++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
@@ -23,11 +23,13 @@ Based on the configured settings, NFSD's IO will either be:
 - cached using page cache (NFSD_IO_BUFFERED=0)
 - cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
 - not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
+- not cached stable_how=NFS_DATA_SYNC (NFSD_IO_DIRECT_WRITE_DATA_SYNC=3)
+- not cached stable_how=NFS_FILE_SYNC (NFSD_IO_DIRECT_WRITE_FILE_SYNC=4)
 
-To set an NFSD IO mode, write a supported value (0 - 2) to the
+To set an NFSD IO mode, write a supported value (0 - 4) to the
 corresponding IO operation's debugfs interface, e.g.:
   echo 2 > /sys/kernel/debug/nfsd/io_cache_read
-  echo 2 > /sys/kernel/debug/nfsd/io_cache_write
+  echo 4 > /sys/kernel/debug/nfsd/io_cache_write
 
 To check which IO mode NFSD is using for READ or WRITE, simply read the
 corresponding IO operation's debugfs interface, e.g.:
diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 7f44689e0a53..8538e29ed2ab 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -68,7 +68,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
 	case NFSD_IO_DIRECT:
 		/*
 		 * Must disable splice_read when enabling
-		 * NFSD_IO_DONTCACHE.
+		 * NFSD_IO_DONTCACHE and NFSD_IO_DIRECT.
 		 */
 		nfsd_disable_splice_read = true;
 		nfsd_io_cache_read = val;
@@ -90,6 +90,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
  * Contents:
  *   %0: NFS WRITE will use buffered IO
  *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
+ *   %2: NFS WRITE will use direct IO with stable_how=NFS_UNSTABLE
+ *   %3: NFS WRITE will use direct IO with stable_how=NFS_DATA_SYNC
+ *   %4: NFS WRITE will use direct IO with stable_how=NFS_FILE_SYNC
  *
  * This setting takes immediate effect for all NFS versions,
  * all exports, and in all NFSD net namespaces.
@@ -109,6 +112,8 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
 	case NFSD_IO_BUFFERED:
 	case NFSD_IO_DONTCACHE:
 	case NFSD_IO_DIRECT:
+	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
+	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
 		nfsd_io_cache_write = val;
 		break;
 	default:
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index e4263326ca4a..10eca169392b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -161,6 +161,8 @@ enum {
 	NFSD_IO_BUFFERED,
 	NFSD_IO_DONTCACHE,
 	NFSD_IO_DIRECT,
+	NFSD_IO_DIRECT_WRITE_DATA_SYNC,
+	NFSD_IO_DIRECT_WRITE_FILE_SYNC,
 };
 
 extern u64 nfsd_io_cache_read __read_mostly;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 326cf6f717b3..101c18d79208 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1353,16 +1353,47 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 	return 1;
 }
 
+static void
+nfsd_init_write_kiocb_from_stable(u32 stable_floor,
+				  struct kiocb *kiocb,
+				  u32 *stable_how)
+{
+	if (stable_floor < *stable_how)
+		return; /* stable_how already set higher */
+
+	*stable_how = stable_floor;
+
+	switch (stable_floor) {
+	case NFS_FILE_SYNC:
+		/* persist data and timestamps */
+		kiocb->ki_flags |= IOCB_DSYNC | IOCB_SYNC;
+		break;
+	case NFS_DATA_SYNC:
+		/* persist data only */
+		kiocb->ki_flags |= IOCB_DSYNC;
+		break;
+	}
+}
+
 static noinline_for_stack int
 nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  struct nfsd_file *nf, unsigned int nvecs,
+		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
 		  unsigned long *cnt, struct kiocb *kiocb)
 {
+	u32 stable_floor = NFS_UNSTABLE;
 	struct file *file = nf->nf_file;
 	struct nfsd_write_dio_seg segments[3];
 	unsigned int nsegs = 0, i;
 	ssize_t host_err;
 
+	if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_FILE_SYNC)
+		stable_floor = NFS_FILE_SYNC;
+	else if (nfsd_io_cache_write == NFSD_IO_DIRECT_WRITE_DATA_SYNC)
+		stable_floor = NFS_DATA_SYNC;
+	if (stable_floor != NFS_UNSTABLE)
+		nfsd_init_write_kiocb_from_stable(stable_floor, kiocb,
+						  stable_how);
+
 	nsegs = nfsd_write_dio_iters_init(nf, rqstp->rq_bvec, nvecs,
 			kiocb, *cnt, segments);
 
@@ -1445,18 +1476,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		stable = NFS_UNSTABLE;
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
-	if (likely(!fhp->fh_use_wgather)) {
-		switch (stable) {
-		case NFS_FILE_SYNC:
-			/* persist data and timestamps */
-			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
-			break;
-		case NFS_DATA_SYNC:
-			/* persist data only */
-			kiocb.ki_flags |= IOCB_DSYNC;
-			break;
-		}
-	}
+	if (likely(!fhp->fh_use_wgather))
+		nfsd_init_write_kiocb_from_stable(stable, &kiocb, stable_how);
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 
@@ -1466,8 +1487,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	switch (nfsd_io_cache_write) {
 	case NFSD_IO_DIRECT:
-		host_err = nfsd_direct_write(rqstp, fhp, nf, nvecs,
-					     cnt, &kiocb);
+	case NFSD_IO_DIRECT_WRITE_DATA_SYNC:
+	case NFSD_IO_DIRECT_WRITE_FILE_SYNC:
+		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
+					     nvecs, cnt, &kiocb);
+		stable = *stable_how;
 		break;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
-- 
2.43.0


