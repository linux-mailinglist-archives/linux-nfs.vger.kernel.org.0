Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463F357D669
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiGUWAV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiGUWAU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:00:20 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD064CE
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:00:18 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j11so2263468qvt.10
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O+5q7oRfV/F4GhPWsxo5AZAi1Mdi1UfsDi0lqy9DBC0=;
        b=eaWf/IqcOGZQqWJ331AlDS1BTH9OUUa7CXvvQvuSdtXLItRdM3+zw5zQ2JzZcxUPVD
         uYFNLNXh9VUs3l7DgjkqHJAe9G4vd01p7uQr+joZHkn8q2BXYj4oiGrxTwLPrRGmeG81
         WvSb1PgYDtmegeHMXbpFiQDO9DCvNiN0iBix0xnlUg9bKviSHDoq+Dzi1y0lN8s2h5YC
         3e6JBmKILsY5Ux/8NifpziYWLl4di7yFfsSjZvT7d59vNgsB1sSmGwnQV4/CpNdCrnAj
         ef8jyGVvsz18RJOrh/iF8JDbVotKlSIHYuAf/MYdg4n2QYmMZpl2dvQWechsFfcpUZ6a
         rfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O+5q7oRfV/F4GhPWsxo5AZAi1Mdi1UfsDi0lqy9DBC0=;
        b=EHYM/x1FTlShRJBbzrmSxoawYSInddIOKJRai+1DQkspjHH3GjipNij6OSB1ZVodHW
         OVfNPxrGOSJHuF3EivDFEVGzFmPCbvOKCfT0J7nz20CbAABcwTcSVCbC2qa2X7xXH+6u
         rQ/kShyaALIG+W7CvEY/pjb0/v3j+RghTtnGDdiOmfJD/sQrrnW7k3vgW2vIv5FyXUuN
         J6U1EiYThRbGbYfZbw/gE1EVh/8s2bSvCn0MSvelPTZ7aWNNFOEE5fssatxMftAw71JQ
         sfCGy0AunNcljZc3Ko0abri+3nETRAuigsw/5XIF2WXo73GRVr9LbI4INuCIvtoURgb3
         6HaA==
X-Gm-Message-State: AJIora8awICYCpxI4JFTTcasdpmjn++5MKOZbu+KDxPC5zHV4k1Gf7ON
        7Cruf34YuOOSzecL3zsaiHLnjJRtTZrZ7w==
X-Google-Smtp-Source: AGRyM1vhXkwGKSl8vNNpucBdkNI304n0ZB6UbvjBq2iUqN9D3GT5aw9OHtTWmo9ih8fCY/dZTFU3Yw==
X-Received: by 2002:a05:6214:d8c:b0:473:5a78:cdd3 with SMTP id e12-20020a0562140d8c00b004735a78cdd3mr570486qve.105.1658440817543;
        Thu, 21 Jul 2022 15:00:17 -0700 (PDT)
Received: from [192.168.0.156] (pool-72-70-58-62.bstnma.fios.verizon.net. [72.70.58.62])
        by smtp.gmail.com with ESMTPSA id o9-20020a05620a15c900b006b5869c1525sm2021861qkm.21.2022.07.21.15.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:00:17 -0700 (PDT)
Message-ID: <2195e7f8-4d19-909d-f15c-ed1ef56a3372@cfa.harvard.edu>
Date:   Thu, 21 Jul 2022 18:00:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Thread safe client destruction
Content-Language: en-US
To:     Steve Dickson <steved@redhat.com>,
        libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
References: <53af8ec6-4ece-09b2-9499-d46d0fdfaa15@cfa.harvard.edu>
 <3c506b75-30c1-5cc4-595d-0656d05a7a9b@redhat.com>
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
In-Reply-To: <3c506b75-30c1-5cc4-595d-0656d05a7a9b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

Yes, the two patches affect the same code area, so if they are both 
relative to master (which is how I submitted them originally) then they 
conflict.

Here is the second patch as a clean incremental on the first.

-- A.

-----------------------------------------------------------------------

diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index 7c5d22e..24c825b 100644
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
@@ -743,7 +747,7 @@ clnt_dg_destroy(cl)
  	sigfillset(&newmask);
  	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
  	mutex_lock(&clnt_fd_lock);
-	while (cu_fd_lock->active)
+	while (cu_fd_lock->active || cu_fd_lock->pending > 0)
  		cond_wait(&cu_fd_lock->cv, &clnt_fd_lock);
  	if (cu->cu_closeit)
  		(void)close(cu_fd);
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
index 3c73e65..7610b4a 100644
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
@@ -655,7 +660,7 @@ clnt_vc_destroy(cl)
  	sigfillset(&newmask);
  	thr_sigsetmask(SIG_SETMASK, &newmask, &mask);
  	mutex_lock(&clnt_fd_lock);
-	while (ct_fd_lock->active)
+	while (ct_fd_lock->active || ct_fd_lock->pending > 0)
  		cond_wait(&ct_fd_lock->cv, &clnt_fd_lock);
  	if (ct->ct_closeit && ct->ct_fd != -1) {
  		(void)close(ct->ct_fd);

-------------------------------------------------------------



On 7/21/22 17:38, Steve Dickson wrote:
> Hello,
> 
> On 7/21/22 2:41 PM, Attila Kovacs wrote:
>> Hi again,
>>
>>
>> I found yet more potential MT flaws in clnt_dg.c and clnt_vg.c.
>>
>> 1. In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to 
>> TRUE, with no corresponding clearing when the operation (*xdr_res() 
>> call) is completed. This would leave other waiting operations blocked 
>> indefinitely, effectively deadlocked. For comparison, 
>> clnt_vd_freeres() in clnt_vc.c does not set the active state to TRUE. 
>> I believe the vc behavior is correct, while the dg behavior is a bug.
>>
>> 2. If clnt_dg_destroy() or clnt_vc_destroy() is awoken with other 
>> blocked operations pending (such as clnt_*_call(), clnt_*_control(), 
>> or clnt_*_freeres()) but no active operation currently being executed, 
>> then the client gets destroyed. Then, as the other blocked operations 
>> get subsequently awoken, they will try operate on an invalid client 
>> handle, potentially causing unpredictable behavior and stack corruption.
>>
>> The proposed fix is to introduce a simple mutexed counting variable 
>> into the client lock structure, which keeps track of the number of 
>> pending blocking operations on the client. This way, clnt_*_destroy() 
>> can check if there are any operations pending on a client, and keep 
>> waiting until all pending operations are completed, before the client 
>> is destroyed safely and its resources are freed.
>>
>> Attached is a patch with the above fixes.
> There is a problem here... This patch does contain the first patch
> you posted. So when I apply this patch it fails.
> 
> So Please apply your first patch, then apply the fixes from
> your second patch... test... then when all is good...
> Resent the second patch which will apply, cleanly,
> with the first patch.
> 
> steved.
> 
>>
>> -- A.
> 
