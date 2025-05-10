Return-Path: <linux-nfs+bounces-11654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846BAB2532
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 21:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F74189CCE4
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683A1CAA9C;
	Sat, 10 May 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/tq7gfD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0A1917F4
	for <linux-nfs@vger.kernel.org>; Sat, 10 May 2025 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746907080; cv=none; b=IyfI/8pDy/2G6Dpx56BzVRDP8MkrFOoMuFTdrjgJrxA4UQyVGPCKZuYHahDQQ9yn4TPbFE6c5klr6OIQT7OXKiTk7YdhQ+Xl8qYKMpKYLpw8GjqoEOeOdb+et/4tucHgWMxVtRCbOKDPD8joF7ZwakV86zUXGbhn1KGFCjTYJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746907080; c=relaxed/simple;
	bh=HyUK9j+3XiZIe2fuIEaRIUaRANjBX0zQVv/G0xoBLLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edlJCd7gjH4vxxfVFZlHNJGAF35iAaMotqjCoZ18550X3HtNALsQwvUuAAMyv+/K1AFI04NouJM6R2xw/bs2dhOVzyNplhzv0ZZcV062dJy1B5uU9K5woCMWq5RQo0BAq/vKj6qVKfx4aaE9jcBD9Y9tHWYD0u84SCJ/1SJu1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/tq7gfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EABC4CEE2;
	Sat, 10 May 2025 19:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746907079;
	bh=HyUK9j+3XiZIe2fuIEaRIUaRANjBX0zQVv/G0xoBLLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/tq7gfD2/f3TaiMP97LJPT+CjuoUcDVsEBd2dqd5wzKIaHqvxdN2PC/uxvWecooy
	 Y1gnCGHU2M5jj3hOkk78CjE3nnymJGvX/bNWR6PfgBJ7fBQKd+AM9KWJDk3jk/H9rv
	 h0YhrJvO2J8dyORdpJlWZ9+KMPGc5T29YkXi38GLpn5xXF5U9SRw3vlk8BE5LwJ2Rg
	 9mXH0ZJdAD8sKi1CJzljLd4xxPwJjIlQ9ELH6yuxXfaELDv0uuawclL+TCCLUiJaWX
	 XzfYQQI2DT5MfJ8hS+cWbAWg0LU83UyKFUJd2Hcz48+0Vmp8CwHPsQB4VcO+x705cf
	 R41qN2CJ2l2Fw==
Date: Sat, 10 May 2025 15:57:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from
 older compilers
Message-ID: <aB-vxtKNKxpPnkz2@kernel.org>
References: <20250509004852.3272120-1-neil@brown.name>
 <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>
 <174684611546.78981.17530209113609371873@noble.neil.brown.name>
 <8c8ded94-ea5e-4b12-af2b-72004a988ad5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8ded94-ea5e-4b12-af2b-72004a988ad5@oracle.com>

On Sat, May 10, 2025 at 12:02:27PM -0400, Chuck Lever wrote:
> On 5/9/25 11:01 PM, NeilBrown wrote:
> > On Sat, 10 May 2025, Chuck Lever wrote:
> >> [ adding Paul McK ]
> >>
> >> On 5/8/25 8:46 PM, NeilBrown wrote:
> >>> This is a revised version a the earlier series.  I've actually tested
> >>> this time and fixed a few issues including the one that Mike found.
> >>
> >> As Mike mentioned in a previous thread, at this point, any fix for this
> >> issue will need to be applied to recent stable kernels as well. This
> >> series looks a bit too complicated for that.
> >>
> >> I expect that other subsystems will encounter this issue eventually,
> >> so it would be beneficial to address the root cause. For that purpose, I
> >> think I like Vincent's proposal the best:
> >>
> >> https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr/raw
> >>
> >> None of this is to say that Neil's patches shouldn't be applied. But
> >> perhaps these are not a broad solution to the RCU compilation issue.
> > 
> > Do we need a "broad solution to the RCU compilation issue"?
> 
> Fair question. If the current localio code is simply incorrect as it
> stands, then I suppose the answer is no. Because gcc is happy to compile
> it in most cases, I thought the problem was with older versions of gcc,
> not with localio (even though, I agree, the use of an incomplete
> structure definition is somewhat brittle when used with RCU).
> 
> 
> > Does it ever make sense to "dereference" a pointer to a structure that is
> > not fully specified?  What does that even mean?
> > 
> > I find it harder to argue against use of rcu_access_pointer() in that
> > context, at least for test-against-NULL, but sparse doesn't complain
> > about a bare test of an __rcu pointer against NULL, so maybe there is no
> > need for rcu_access_pointer() for simple tests - in which case the
> > documentation should be updated.
> 
> For backporting purposes, inventing our own local RCU helper to handle
> the situation might be best. Then going forward, apply your patches to
> rectify the use of the incomplete structure definition, and the local
> helper can eventually be removed.
> 
> My interest is getting to a narrow set of changes that can be applied
> now and backported as needed. The broader clean-ups can then be applied
> to future kernels (or as subsequent patches in the same merge window).
> 
> My 2 cents, worth every penny.

I really would prefer we just use this patch as the stop-gap for 6.14
and 6.15 (which I have been carrying for nearly a year now because I
need to support an EL8 platform that uses gcc 8.5):

https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=kernel-6.12.24/nfs-testing&id=f9add5e4c9b4629b102876dce9484e1da3e35d1f

Then we work through getting Neil's patchset to land for 6.16 and
revert the stop-gap (dummy nfsd_file) patch.

> > (of course rcu_dereference() doesn't actually dereference the pointer,
> >  despite its name.  It just declared that there is an imminent intention
> >  to dereference the pointer.....)
> > 
> > NeilBrown

Rather than do a way more crazy stop-gap like this (which actually works):

 fs/nfs/localio.c           |  6 +++---
 fs/nfs_common/nfslocalio.c |  8 +++----
 include/linux/nfslocalio.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 73dd07495440..fedc07254c00 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -272,7 +272,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 
 	new = NULL;
 	rcu_read_lock();
-	nf = rcu_dereference(*pnf);
+	nf = rcu_dereference_opaque(*pnf);
 	if (!nf) {
 		rcu_read_unlock();
 		new = __nfs_local_open_fh(clp, cred, fh, nfl, mode);
@@ -281,11 +281,11 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		rcu_read_lock();
 		/* try to swap in the pointer */
 		spin_lock(&clp->cl_uuid.lock);
-		nf = rcu_dereference_protected(*pnf, 1);
+		nf = rcu_dereference_opaque_protected(*pnf, 1);
 		if (!nf) {
 			nf = new;
 			new = NULL;
-			rcu_assign_pointer(*pnf, nf);
+			rcu_assign_opaque_pointer(*pnf, nf);
 		}
 		spin_unlock(&clp->cl_uuid.lock);
 	}
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 6a0bdea6d644..213862ceb8bb 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -285,14 +285,14 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 		return;
 	}
 
-	ro_nf = rcu_access_pointer(nfl->ro_file);
-	rw_nf = rcu_access_pointer(nfl->rw_file);
+	ro_nf = rcu_access_opaque(nfl->ro_file);
+	rw_nf = rcu_access_opaque(nfl->rw_file);
 	if (ro_nf || rw_nf) {
 		spin_lock(&nfs_uuid->lock);
 		if (ro_nf)
-			ro_nf = rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
+			ro_nf = rcu_dereference_opaque_protected(xchg(&nfl->ro_file, NULL), 1);
 		if (rw_nf)
-			rw_nf = rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
+			rw_nf = rcu_dereference_opaque_protected(xchg(&nfl->rw_file, NULL), 1);
 
 		/* Remove nfl from nfs_uuid->files list */
 		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 9aa8a43843d7..c6e86891d4b5 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -15,6 +15,58 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfs.h>
 #include <net/net_namespace.h>
+#include <linux/rcupdate.h>
+
+/*
+ * RCU methods to allow fs/nfs_common and fs/nfs LOCALIO code to avoid
+ * dereferencing pointer to 'struct nfs_file' which is opaque outside fs/nfsd
+*/
+#define __rcu_access_opaque_pointer(p, local, space) \
+({ \
+	typeof(p) local = (__force typeof(p))READ_ONCE(p); \
+	rcu_check_sparse(p, space); \
+	(__force __kernel typeof(p))(local); \
+})
+
+#define rcu_access_opaque(p) __rcu_access_opaque_pointer((p), __UNIQUE_ID(rcu), __rcu)
+
+#define __rcu_dereference_opaque_protected(p, local, c, space) \
+({ \
+	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_opaque_protected() usage"); \
+	rcu_check_sparse(p, space); \
+	(__force __kernel typeof(p))(p); \
+})
+
+#define rcu_dereference_opaque_protected(p, c) \
+	__rcu_dereference_opaque_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
+
+#define __rcu_dereference_opaque_check(p, local, c, space) \
+({ \
+	/* Dependency order vs. p above. */ \
+	typeof(p) local = (__force typeof(p))READ_ONCE(p); \
+	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_opaque_check() usage"); \
+	rcu_check_sparse(p, space); \
+	(__force __kernel typeof(p))(local); \
+})
+
+#define rcu_dereference_opaque_check(p, c) \
+	__rcu_dereference_opaque_check((p), __UNIQUE_ID(rcu), \
+				       (c) || rcu_read_lock_held(), __rcu)
+
+#define rcu_dereference_opaque(p) rcu_dereference_opaque_check(p, 0)
+
+#define RCU_INITIALIZER_OPAQUE(v) (typeof((v)) __force __rcu)(v)
+
+#define rcu_assign_opaque_pointer(p, v)					      \
+do {									      \
+	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
+	rcu_check_sparse(p, __rcu);					      \
+									      \
+	if (__builtin_constant_p(v) && (_r_a_p__v) == (uintptr_t)NULL)	      \
+		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
+	else								      \
+		smp_store_release(&p, RCU_INITIALIZER_OPAQUE((typeof(p))_r_a_p__v)); \
+} while (0)
 
 struct nfs_client;
 struct nfs_file_localio;

