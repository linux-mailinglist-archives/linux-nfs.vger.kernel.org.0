Return-Path: <linux-nfs+bounces-7227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB949A240E
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4628C2AA
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB791DE3B7;
	Thu, 17 Oct 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGJh66kR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E181DDC09
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172200; cv=none; b=rUF9MMNJvqq1h+5iWylpC7LDKo1KqGvb2wzGBKA4ob7t1NA4GF2+kApaQRtLZAkx5D5/S9vbo9c/7PezgI0L9C8yd3km/gVOMPqyzmKQ5iuTqez2KOt8uzejuYSo89tUy62yi9eAUBuNddrgWHORC3kDOd2/tcyrcU5XJYXm2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172200; c=relaxed/simple;
	bh=RICdl1H+4mLMX4ZJNGjIA0pKMOWWkCj4salfc/LMce8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slQ1CtaY8MTS+jDk9+bFPsmkyOCL7IHKDN03I1e0FTIfCm+YT7FWIiMeIZff5HPyJYL/D7XcIJRTdh9GUXlQeqVtBHNghBTGFV2+ZfPeLZ4N8auRh/hoDao7S02tII0Xds2Yx2QYIYGOagg4aSWSx3nwOMhwHflUThCymQcfZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGJh66kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE5BC4CEC5;
	Thu, 17 Oct 2024 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172200;
	bh=RICdl1H+4mLMX4ZJNGjIA0pKMOWWkCj4salfc/LMce8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGJh66kRQY6vFLj0mdW2Mm7fcPObrKf1lKDkFMCTW+T4TER6ZznWPHnF7X10VsIyb
	 4Og5PUocsJQi1OX4pYBp9488sr/ibKBicWrhh3sI7cLbDyRlSDaP/9+nJPlUxGY/Go
	 6k7ZCeS+UyJzSzC7M0z7poPaaSTFmztoTIsUIb1Bc2yfUxItrICHMLc8xj+zfzrK81
	 0Wv1pH8bjjRBtLWNY8K0VLrYIcbscwdsqEOxGnDn4cowZyM3aUP2QvyA/mcd2Oeoe3
	 DptnDYMxgp4+DDHzNiOhy+pZNt7EdvdJqntbE47jhkh/KIcrIy73hRuPkTDld/RoT/
	 syZMgrxnqTIjA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 4/5] lockd: Remove unused parameter to nlmsvc_testlock()
Date: Thu, 17 Oct 2024 09:36:30 -0400
Message-ID: <20241017133631.213274-5-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017133631.213274-1-cel@kernel.org>
References: <20241017133631.213274-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This parameter has been unused since commit 09802fd2a8ca ("lockd:
rip out deferred lock handling from testlock codepath").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c         | 3 ++-
 fs/lockd/svclock.c          | 2 +-
 fs/lockd/svcproc.c          | 3 ++-
 include/linux/lockd/lockd.h | 6 +++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 1d0400d94b3d..2cb603013111 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -108,7 +108,8 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	test_owner = argp->lock.fl.c.flc_owner;
 	/* Now check for conflicting locks */
-	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
+	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
+				       &resp->lock);
 	if (resp->status == nlm_drop_reply)
 		rc = rpc_drop_reply;
 	else
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 1f2149db10f2..33e1fd159934 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -609,7 +609,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 __be32
 nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		struct nlm_host *host, struct nlm_lock *lock,
-		struct nlm_lock *conflock, struct nlm_cookie *cookie)
+		struct nlm_lock *conflock)
 {
 	int			error;
 	int			mode;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index d959a5dbe0ae..f53d5177f267 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -130,7 +130,8 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	test_owner = argp->lock.fl.c.flc_owner;
 
 	/* Now check for conflicting locks */
-	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
+	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host,
+						   &argp->lock, &resp->lock));
 	if (resp->status == nlm_drop_reply)
 		rc = rpc_drop_reply;
 	else
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 61c4b9c41904..c8f0f9458f2c 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -278,9 +278,9 @@ __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
 			      struct nlm_host *, struct nlm_lock *, int,
 			      struct nlm_cookie *, int);
 __be32		  nlmsvc_unlock(struct net *net, struct nlm_file *, struct nlm_lock *);
-__be32		  nlmsvc_testlock(struct svc_rqst *, struct nlm_file *,
-			struct nlm_host *, struct nlm_lock *,
-			struct nlm_lock *, struct nlm_cookie *);
+__be32		  nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
+			struct nlm_host *host, struct nlm_lock *lock,
+			struct nlm_lock *conflock);
 __be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct nlm_lock *);
 void		  nlmsvc_retry_blocked(struct svc_rqst *rqstp);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
-- 
2.46.2


