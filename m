Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8157E03F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiGVKuC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbiGVKuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 06:50:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7BAF95E
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 03:49:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x11so3180810qts.13
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=k0jk954N+39CPcspYFStLxJWi35OB5hgpGIhVk4Mx4c=;
        b=T+rDNVTJHGxiH35BG5WoPlexHaojrAETimerDjvsbKznjAAAyJaP6tZHQiBWvrNQv6
         Pay/RPcb0Ik6LaLJyrmXLIacv6m8OjmZMasaIX/ykEJmxJ2SHBkt9pg7QIDM//6XZAM9
         GIvyUNf1yXB4kkDy8HOJC65B6eTl1wqXNMGcZdXUEpE6UdHe+jDnlpMhktFqRjAb/NAB
         n1UHEaDhumnzQ+qMxPO7Y+NWdafJom33c3QSaP7Z1ELIX6aqEOfabAItL6sn/Bi1ruLu
         poKSTatFtrA0SYDPkisWS72FLdKw+kYZpupyp8WfwpT/ZAkP6Hmwkvw8TN+5pfGni2UK
         tLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=k0jk954N+39CPcspYFStLxJWi35OB5hgpGIhVk4Mx4c=;
        b=FpQaE1Gen/rQBwgRHEcCVhDMv+LEsliFStI9LEAcvkB3nj5gzvnBdBULAsG3xU6uqL
         WKDhGRyo8rfWb6T59nJVkdZYiYOJWSIk2a3aHaBRYqPh+rpjasswIuX7L7Tybw+YX51G
         J9TBlOYe+vegLjTNzd/wqHp7z64guMrJT1CtV+dk+tddKn9ocklft5rvzlJcNy/WGiTR
         XCPX7kvCSMGj6+QuGxSoYuMAZZ9a+0Wkzos5/Pnv0O40hQh1HCRDccYKKjhpSFO8uIVX
         eeZ48bRke7SMweJL0B2BXzSQRBV8wZfE7Q+UlnXAiGxq0hxHlYmZ1qQIHk+vn9EXRWcL
         0PzA==
X-Gm-Message-State: AJIora+L76zTu1ZDNOSw34lH5v4enytC733ISfPLYgIpJJ5zXnHTxB/A
        WJeIvQvIakDFxZPjIbXuVD910ptXtaNVvw==
X-Google-Smtp-Source: AGRyM1sDz98QDpMY29C/QNYQiBscZvgIsh5KnxfTy5BmpRaPlELZqTHXUSZhFKg43917Gfy6RXUZnw==
X-Received: by 2002:ac8:5c4e:0:b0:31e:f6e6:c62 with SMTP id j14-20020ac85c4e000000b0031ef6e60c62mr2500345qtj.460.1658486998421;
        Fri, 22 Jul 2022 03:49:58 -0700 (PDT)
Received: from [192.168.0.156] (pool-72-70-58-62.bstnma.fios.verizon.net. [72.70.58.62])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a2a1500b006b249cc505fsm3318911qkp.82.2022.07.22.03.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 03:49:57 -0700 (PDT)
Message-ID: <b64e8bbc-d5a3-310e-a1c8-728f890ea777@cfa.harvard.edu>
Date:   Fri, 22 Jul 2022 06:49:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2 1/1]: Thread safe client destruction
Content-Language: en-US
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
In-Reply-To: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve et al.,


Correction to the last patch I submitted. That one unfortunately created 
a new potential deadlock in itself while trying to fix a potential stack 
corruption. Here is some more explanation of the bug the earlier patch 
introduced and the how the updated patch gets around it:

clnt_*.c have a number of functions that wait on a condition variable to 
be signaled. The signaling wakes up (at least) one of the threads 
blocked on that condition, but not all of them. So, it is up to each 
waiting call to cascade the signal to the next blocked thread, so they 
can wake up as appropriate to process the notification.

Originally, all waiting calls checked for the 'active' condition to 
decide whether to proceed. If there was an active operation ongoing, all 
these blocked calls went back into waiting, without cascading the 
signal. This was perfectly fine, because none of the calls could 
potentially do anything while the client's lock was 'active'.

With the safe client destruction fix, however, the clnt_*_destroy() call 
is now checking on a different condition (really it needs to check 
simply if there are any pending operations waiting to complete before 
the client can be closed). However, even if the destruction must wait, 
another pending operation on the client could (and should) proceed 
still, if there the lock is not 'active' during wake-up. Thus, 
clnt_*_destroy() must cascade the notification to other blocked calls if 
the 'active' state is not set before going back to waiting.


-------------------------------------------------------

diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index 7c5d22e..166af63 100644
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
@@ -311,6 +312,7 @@ clnt_dg_call(cl, proc, xargs, argsp, xresults, 
resultsp, utimeout)
  	sigfillset(&newmask);
  	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
  	mutex_lock(&clnt_fd_lock);
+	cu->cu_fd_lock->pending++;
  	while (cu->cu_fd_lock->active)
  		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
  	cu->cu_fd_lock->active = TRUE;
@@ -571,11 +573,12 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
  	sigfillset(&newmask);
  	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
  	mutex_lock(&clnt_fd_lock);
+	cu->cu_fd_lock->pending++;
  	while (cu->cu_fd_lock->active)
  		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
-	cu->cu_fd_lock->active = TRUE;
  	xdrs->x_op = XDR_FREE;
  	dummy = (*xdr_res)(xdrs, res_ptr);
+	cu->cu_fd_lock->pending--;
  	thr_sigsetmask(SIG_SETMASK, &mask, NULL);
  	cond_signal(&cu->cu_fd_lock->cv);
  	mutex_unlock(&clnt_fd_lock);
@@ -603,6 +606,7 @@ clnt_dg_control(cl, request, info)
  	sigfillset(&newmask);
  	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
  	mutex_lock(&clnt_fd_lock);
+	cu->cu_fd_lock->pending++;
  	while (cu->cu_fd_lock->active)
  		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
  	cu->cu_fd_lock->active = TRUE;
@@ -743,8 +747,14 @@ clnt_dg_destroy(cl)
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
@@ -180,6 +181,7 @@ fd_lock_t* fd_lock_create(int fd, fd_locks_t 
*fd_locks) {
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
@@ -357,6 +358,7 @@ clnt_vc_call(cl, proc, xdr_args, args_ptr, 
xdr_results, results_ptr, timeout)
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

-------------------------------------------------------


Signed-off-by: Attila Kovacs <attila.kovacs@cfa.harvard.edu>


On 7/21/22 14:41, Attila Kovacs wrote:
> Hi again,
> 
> 
> I found yet more potential MT flaws in clnt_dg.c and clnt_vg.c.
> 
> 1. In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, 
> with no corresponding clearing when the operation (*xdr_res() call) is 
> completed. This would leave other waiting operations blocked 
> indefinitely, effectively deadlocked. For comparison, clnt_vd_freeres() 
> in clnt_vc.c does not set the active state to TRUE. I believe the vc 
> behavior is correct, while the dg behavior is a bug.
> 
> 2. If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other 
> blocked operations pending (such as clnt_*_call(), clnt_*_control(), or 
> clnt_*_freeres()) but no active operation currently being executed, then 
> the client gets destroyed. Then, as the other blocked operations get 
> subsequently awoken, they will try operate on an invalid client handle, 
> potentially causing unpredictable behavior and stack corruption.
> 
> The proposed fix is to introduce a simple mutexed counting variable into 
> the client lock structure, which keeps track of the number of pending 
> blocking operations on the client. This way, clnt_*_destroy() can check 
> if there are any operations pending on a client, and keep waiting until 
> all pending operations are completed, before the client is destroyed 
> safely and its resources are freed.
> 
> Attached is a patch with the above fixes.
> 
> -- A.
