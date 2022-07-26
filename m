Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC10581502
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiGZOVM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 10:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiGZOVK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 10:21:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD04415FFC
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 07:21:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i13so10701655qvo.3
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUev4aVqJ5kVJbWbmM/RDsUFZ/tOjyhFiv32RH06njk=;
        b=AeTi8kiIURrOjxL10vvu4A0RfLLpLnN33JH5nkxhk9tRKUn0Gnx75oSBAIo1ir3qT0
         GO2YsJcOir+suz56U/Ojn3r9HgP8eiT5n1gk/opNBT/7w4kiYQBbkb6GqSUM0Hf61AUU
         oQD+XnODoAiJ7idrZ7VYDe1d9syoHPtmuSQDFiVSJY6ClRt2cRu62Fli9p/nm2Rr9pMZ
         LMOZlPXpIjLDX83AwCZU7reAXdm3WQNb8Wc/yWABf1vTLsAi/glS8LfRvdy4h580cUdQ
         T2LnE3GY5Y2CeulVQ07geEgvRd+g3fXOXWKv0GJCeHBOBYUZ9FEjAMP5YUurxyCwkV5C
         EClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUev4aVqJ5kVJbWbmM/RDsUFZ/tOjyhFiv32RH06njk=;
        b=AcGHHI4D7LtH56x8FYHo0AZrB+q+vBTT3LAriBoMRE6x3wn+SI9ESbLy+/KWLa6UOv
         KsygaFONFZ0q5d9giA5MCqE2/8KxJdhKmtsV/YWayvGbAURxnqJ6iWJ9jf37O8mzTMrr
         R5pYsvV2U5ivgXzsn/h4CnS/vh5YDiz8RzlldBKRirU4ROMKasqPvUiP5QFIKDj6cjXG
         jz4qbESofl9V3KdnrI2I5u8SNnWbQ6p7sQJoPG58VAryzJ6YP5AM6GsYK9pP5muuyws6
         IiokZHwYhi4Aai70C40Uv/2KxmuGNettRNNPXzVlKeQn+xS3B7vx8JL9uvKcQRPVhHYb
         rcjQ==
X-Gm-Message-State: AJIora8IyObJfMxxwWzymHyYfAv1Rtdp8nWT7rKstzUIX0uP5/dH6CRw
        jwIQKFxJZR8DVZhjk2XTX31vZi3ytPOX1g==
X-Google-Smtp-Source: AGRyM1t1p4UvfIWlT5OPoMpJczH5HNz9HkPHYHm/HsDcICGS2nVhcNQ6bdNeyZYj3iPtbEBry/tXSw==
X-Received: by 2002:a0c:dc0f:0:b0:474:1c35:1fbc with SMTP id s15-20020a0cdc0f000000b004741c351fbcmr15052651qvk.78.1658845268458;
        Tue, 26 Jul 2022 07:21:08 -0700 (PDT)
Received: from pihe (dhcp-131-142-152-103.cfa.harvard.edu. [131.142.152.103])
        by smtp.gmail.com with ESMTPSA id i67-20020a375446000000b006a6a6f148e6sm11263873qkb.17.2022.07.26.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:21:08 -0700 (PDT)
Received: from pihe (localhost [127.0.0.1])
        by pihe (8.17.1/8.17.1) with ESMTPS id 26QEL74Q069151
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 10:21:07 -0400
Received: (from pumukli@localhost)
        by pihe (8.17.1/8.17.1/Submit) id 26QEL7Od069101;
        Tue, 26 Jul 2022 10:21:07 -0400
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] thread safe clnt destruction.
Date:   Tue, 26 Jul 2022 10:19:06 -0400
Message-Id: <20220726141906.69023-2-attila.kovacs@cfa.harvard.edu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726141906.69023-1-attila.kovacs@cfa.harvard.edu>
References: <20220726141906.69023-1-attila.kovacs@cfa.harvard.edu>
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

