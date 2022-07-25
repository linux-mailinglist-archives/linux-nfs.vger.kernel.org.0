Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFA5805E0
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 22:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiGYUmf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiGYUmf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 16:42:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25322BE8
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 13:42:34 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z18so9320097qki.2
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUev4aVqJ5kVJbWbmM/RDsUFZ/tOjyhFiv32RH06njk=;
        b=TGNccJHyXhTG4ei5lVYklvsVkmYzPmGaVdc5RPQSxeewkol6O6kKKT+XuyJl7tiyh1
         KDuIm+qYvPLAXMaTcjKdwTWqzsiec9WchqT6LAsvjw6GxbhytKxIxSePxpovoZBKbGet
         +RJREzf5lpZcGs3pyC9Y052MM/EiS/MufMRveBgZNsXs0Hw4VMWmGJrY96lzWXKvBuov
         CqKi90rWl2guYFCO/V+9UuUavFUTxV0Y5u/r72Z7jL1ofInn0rcobPLe4tXhayqvNXpo
         USJUTysZl0BsYkGjyBreXjicgt/YLgXxujpBppqfyANSixXRpypfkhsd/TRJt/3Vg3FH
         /ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUev4aVqJ5kVJbWbmM/RDsUFZ/tOjyhFiv32RH06njk=;
        b=jh2UeYU5jwMYEqu5arH7rHWSk7UV3SmYo9x91GettpAhsrESUVF+KVbrbxewz6DyhI
         N/l53vU5De+qZQAVukmO1vRDRwatsCFMnq5Dh4hjezY52u50AnyQ/q73HQwwoOvB2mjV
         cAxkOKkQa/7mYnVkocKTBSYX1IygYs9UGUx/sg3Sj01xrGyfEetZKMeiz8tgKNOzOexO
         VRwVWd2DEdgrM3F9T6obMkuioKz2BSkB8WFbMDsiyePxPdl/g3/iZriKSR4UsDDhFjGt
         7OKv7O4l7TpBU0babdP0Z3q7C+kzxM9jsqPYPQrXVtX0mi3NvXZrD1qEw76tiuuXlmzA
         7AcA==
X-Gm-Message-State: AJIora+EX/0108TTOPkrv7BgwuDL46Gqk4C2edS+FtV0xKKX2OjjG98+
        Ti+943vvEVm5YAy5vlflDu+FwCVAscKAnw==
X-Google-Smtp-Source: AGRyM1u1GstvecG7qBqGLB2mX4uS7/1SGY6prDnDSs/QkinEbEeLYMi+T0sKegVz+XZXTOiJYSer3w==
X-Received: by 2002:a05:620a:1907:b0:6a6:2fac:462f with SMTP id bj7-20020a05620a190700b006a62fac462fmr10162573qkb.213.1658781753171;
        Mon, 25 Jul 2022 13:42:33 -0700 (PDT)
Received: from pihe ([65.112.10.207])
        by smtp.gmail.com with ESMTPSA id a187-20020ae9e8c4000000b006b4689e3425sm9275434qkg.129.2022.07.25.13.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:42:32 -0700 (PDT)
Received: from pihe (localhost [127.0.0.1])
        by pihe (8.17.1/8.17.1) with ESMTPS id 26PG8ovj015839
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 12:08:50 -0400
Received: (from pumukli@localhost)
        by pihe (8.17.1/8.17.1/Submit) id 26PG8oph015747;
        Mon, 25 Jul 2022 12:08:50 -0400
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] thread safe clnt destruction.
Date:   Mon, 25 Jul 2022 12:06:46 -0400
Message-Id: <20220725160646.15610-2-attila.kovacs@cfa.harvard.edu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220725160646.15610-1-attila.kovacs@cfa.harvard.edu>
References: <20220725160646.15610-1-attila.kovacs@cfa.harvard.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Attila Kovacs <attipaci@gmail.com>

If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other blocked 
operations pending (such as clnt_*_call(), clnt_*_control(), or 
clnt_*_freeres()) but no active operation currently being executed, then the 
client gets destroyed. Then, as the other blocked operations get subsequently 
awoken, they will try operate on an invalid client handle, potentially causing 
unpredictable behavior and stack corruption. 

Signed-off-by: Attila Kovacs <attipaci@gmail.com>
---
 src/clnt_dg.c       | 13 ++++++++++++-
 src/clnt_fd_locks.h |  2 ++
 src/clnt_vc.c       | 13 ++++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index b2043ac..166af63 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -101,6 +101,7 @@ extern mutex_t clnt_fd_lock;
 #define	release_fd_lock(fd_lock, mask) {	\
 	mutex_lock(&clnt_fd_lock);	\
 	fd_lock->active = FALSE;	\
+	fd_lock->pending--;		\
 	thr_sigsetmask(SIG_SETMASK, &(mask), NULL); \
 	cond_signal(&fd_lock->cv);	\
 	mutex_unlock(&clnt_fd_lock);    \
@@ -311,6 +312,7 @@ clnt_dg_call(cl, proc, xargs, argsp, xresults, resultsp, utimeout)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
+	cu->cu_fd_lock->pending++;
 	while (cu->cu_fd_lock->active)
 		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
 	cu->cu_fd_lock->active = TRUE;
@@ -571,10 +573,12 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
+	cu->cu_fd_lock->pending++;
 	while (cu->cu_fd_lock->active)
 		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
 	xdrs->x_op = XDR_FREE;
 	dummy = (*xdr_res)(xdrs, res_ptr);
+	cu->cu_fd_lock->pending--;
 	thr_sigsetmask(SIG_SETMASK, &mask, NULL);
 	cond_signal(&cu->cu_fd_lock->cv);
 	mutex_unlock(&clnt_fd_lock);
@@ -602,6 +606,7 @@ clnt_dg_control(cl, request, info)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
+	cu->cu_fd_lock->pending++;
 	while (cu->cu_fd_lock->active)
 		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
 	cu->cu_fd_lock->active = TRUE;
@@ -742,8 +747,14 @@ clnt_dg_destroy(cl)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
-	while (cu_fd_lock->active)
+	/* wait until all pending operations on client are completed. */
+	while (cu_fd_lock->pending > 0) {
+		/* If a blocked operation can be awakened, then do it. */
+		if (cu_fd_lock->active == FALSE)
+			cond_signal(&cu_fd_lock->cv);
+		/* keep waiting... */
 		cond_wait(&cu_fd_lock->cv, &clnt_fd_lock);
+	}
 	if (cu->cu_closeit)
 		(void)close(cu_fd);
 	XDR_DESTROY(&(cu->cu_outxdrs));
diff --git a/src/clnt_fd_locks.h b/src/clnt_fd_locks.h
index 359f995..6ba62cb 100644
--- a/src/clnt_fd_locks.h
+++ b/src/clnt_fd_locks.h
@@ -50,6 +50,7 @@ static unsigned int fd_locks_prealloc = 0;
 /* per-fd lock */
 struct fd_lock_t {
 	bool_t active;
+	int pending;        /* Number of pending operations on fd */
 	cond_t cv;
 };
 typedef struct fd_lock_t fd_lock_t;
@@ -180,6 +181,7 @@ fd_lock_t* fd_lock_create(int fd, fd_locks_t *fd_locks) {
 		item->fd = fd;
 		item->refs = 1;
 		item->fd_lock.active = FALSE;
+		item->fd_lock.pending = 0;
 		cond_init(&item->fd_lock.cv, 0, (void *) 0);
 		TAILQ_INSERT_HEAD(list, item, link);
 	} else {
diff --git a/src/clnt_vc.c b/src/clnt_vc.c
index 3c73e65..5bbc78b 100644
--- a/src/clnt_vc.c
+++ b/src/clnt_vc.c
@@ -153,6 +153,7 @@ extern mutex_t  clnt_fd_lock;
 #define release_fd_lock(fd_lock, mask) {	\
 	mutex_lock(&clnt_fd_lock);	\
 	fd_lock->active = FALSE;	\
+	fd_lock->pending--;		\
 	thr_sigsetmask(SIG_SETMASK, &(mask), (sigset_t *) NULL);	\
 	cond_signal(&fd_lock->cv);	\
 	mutex_unlock(&clnt_fd_lock);    \
@@ -357,6 +358,7 @@ clnt_vc_call(cl, proc, xdr_args, args_ptr, xdr_results, results_ptr, timeout)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
+	ct->ct_fd_lock->pending++;
 	while (ct->ct_fd_lock->active)
 		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
 	ct->ct_fd_lock->active = TRUE;
@@ -495,10 +497,12 @@ clnt_vc_freeres(cl, xdr_res, res_ptr)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
+	ct->ct_fd_lock->pending++;
 	while (ct->ct_fd_lock->active)
 		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
 	xdrs->x_op = XDR_FREE;
 	dummy = (*xdr_res)(xdrs, res_ptr);
+	ct->ct_fd_lock->pending--;
 	thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
 	cond_signal(&ct->ct_fd_lock->cv);
 	mutex_unlock(&clnt_fd_lock);
@@ -533,6 +537,7 @@ clnt_vc_control(cl, request, info)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
+	ct->ct_fd_lock->pending++;
 	while (ct->ct_fd_lock->active)
 		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
 	ct->ct_fd_lock->active = TRUE;
@@ -655,8 +660,14 @@ clnt_vc_destroy(cl)
 	sigfillset(&newmask);
 	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
 	mutex_lock(&clnt_fd_lock);
-	while (ct_fd_lock->active)
+	/* wait until all pending operations on client are completed. */
+	while (ct_fd_lock->pending > 0) {
+		/* If a blocked operation can be awakened, then do it. */
+		if (ct_fd_lock->active == FALSE)
+			cond_signal(&ct_fd_lock->cv);
+		/* keep waiting... */
 		cond_wait(&ct_fd_lock->cv, &clnt_fd_lock);
+	}
 	if (ct->ct_closeit && ct->ct_fd != -1) {
 		(void)close(ct->ct_fd);
 	}
-- 
2.37.1

