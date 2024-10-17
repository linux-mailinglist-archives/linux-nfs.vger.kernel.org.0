Return-Path: <linux-nfs+bounces-7228-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC39A240F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC40B231F9
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637EF1DE3BC;
	Thu, 17 Oct 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3m70ktx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F481DDC09
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172201; cv=none; b=G7ai4mWMXTG5RY7PJfZ8vDXi4Xltl4x6c8Sf8HcPsoj6yHeaW2hCk4xrxX4EN3VAMmECO2QdJOyDtVOXqDy28+ggOBJxombJQqp1ZdeIj/SuzJ3GLf+JbQ7gEid8Q/6rKCEG4UNOXL9Kj9hp/2eOFK6P6C6Pm52jX79zS78diEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172201; c=relaxed/simple;
	bh=AtB1uZOHYnTXzqHqoo9ViXeSOx3KXI11OZZOzkeKAKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOkjkUxgD9cwpVgipyQBmZ4UAFvPQTmnq81skmaVu7M4RCMpHRPYY6uQ6VpHm2v9hiD96+7YIqR3KYtr7BI2c1jVFFNQpP7sS7WGrCPyuyQ8rSIS6GXgYopYOjLMjvJ6NJE+pCSh4f3N1EFdReYUU84q2zIw8d+9e75118jCEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3m70ktx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660CCC4CEC7;
	Thu, 17 Oct 2024 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172201;
	bh=AtB1uZOHYnTXzqHqoo9ViXeSOx3KXI11OZZOzkeKAKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3m70ktxhpzO/yQqXYlOaF3/UAW5Ffn2j0/3BSoCil9pEmUCaHb7lhiEu8yO4ybp1
	 /PjCl063hBZDJUlABauc7S/hOWmLj2E0Qu275J+gLwGJg6VFlffq1nl5i84iCx4fuA
	 v0nxccJuEISK4bHHM7Nc8MutE/nfmkmKgyhkRS6dibsfr+NwOl4lM5nVfJT9izMm92
	 kc8/w4sGybdnFb7N9FC63Dg6rsVM78orYAkN/Yko4Y0CvTLEEX3FG+p6//bnm//O+M
	 ObFSSHs3rfkz4lEcsdKIsO7JDG3vp98S9aBcX4FF2JZ9Z6Lg8Wn395WtgXIcZTID6R
	 s0lVOg4NGBGhg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5/5] lockd: Remove unneeded initialization of file_lock::c.flc_flags
Date: Thu, 17 Oct 2024 09:36:31 -0400
Message-ID: <20241017133631.213274-6-cel@kernel.org>
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

Since commit 75c7940d2a86 ("lockd: set missing fl_flags field when
retrieving args"), nlmsvc_retrieve_args() initializes the flc_flags
field. svcxdr_decode_lock() no longer needs to do this.

This clean up removes one dependency on the nlm_lock:fl field. No
behavior change is expected.

Analysis:

svcxdr_decode_lock() is called by:

nlm4svc_decode_testargs()
nlm4svc_decode_lockargs()
nlm4svc_decode_cancargs()
nlm4svc_decode_unlockargs()

nlm4svc_decode_testargs() is used by:
- NLMPROC4_TEST and NLMPROC4_TEST_MSG, which call nlmsvc_retrieve_args()
- NLMPROC4_GRANTED and NLMPROC4_GRANTED_MSG, which don't pass the
  lock's file_lock to the generic lock API

nlm4svc_decode_lockargs() is used by:
- NLMPROC4_LOCK and NLM4PROC4_LOCK_MSG, which call nlmsvc_retrieve_args()
- NLMPROC4_UNLOCK and NLM4PROC4_UNLOCK_MSG, which call nlmsvc_retrieve_args()
- NLMPROC4_NM_LOCK, which calls nlmsvc_retrieve_args()

nlm4svc_decode_cancargs() is used by:
- NLMPROC4_CANCEL and NLMPROC4_CANCEL_MSG, which call nlmsvc_retrieve_args()

nlm4svc_decode_unlockargs() is used by:
- NLMPROC4_UNLOCK and NLMPROC4_UNLOCK_MSG, which call nlmsvc_retrieve_args()

All callers except GRANTED/GRANTED_MSG eventually call
nlmsvc_retrieve_args() before using nlm_lock::fl.c.flc_flags. Thus
this change is safe.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 5 +++--
 fs/lockd/xdr4.c     | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 2cb603013111..109e5caae8c7 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -46,14 +46,15 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	if (filp != NULL) {
 		int mode = lock_to_openmode(&lock->fl);
 
+		lock->fl.c.flc_flags = FL_POSIX;
+
 		error = nlm_lookup_file(rqstp, &file, lock);
 		if (error)
 			goto no_locks;
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
-		lock->fl.c.flc_flags = FL_POSIX;
-		lock->fl.c.flc_file  = file->f_file[mode];
+		lock->fl.c.flc_file = file->f_file[mode];
 		lock->fl.c.flc_pid = current->tgid;
 		lock->fl.fl_start = (loff_t)lock->lock_start;
 		lock->fl.fl_end = lock->lock_len ?
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 60466b8bac58..e343c820301f 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -89,7 +89,6 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 		return false;
 
 	locks_init_lock(fl);
-	fl->c.flc_flags = FL_POSIX;
 	fl->c.flc_type  = F_RDLCK;
 	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
 	return true;
-- 
2.46.2


