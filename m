Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B9E57BD8D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiGTSQV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jul 2022 14:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGTSQU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 14:16:20 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC57558C1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 11:16:20 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i13so451276qvo.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :references:to:cc:from:in-reply-to:content-transfer-encoding;
        bh=jxI6DppbbJPvPi6EG4wCD2k6+eiQ3ZxZgYZxLLmOdlE=;
        b=jh4LaYgBKcqslaVvAn/d3HbPpzGqMFqqAnDaMgXLYEiOgoJ6HDmG7ZukgdirTuzdkK
         LxOW5lEW5WUXI8PEcbLHaP7VDsoeHKc+Tch7KHEp/aXm/jpg1DJ2Jzl1ebvhi4ZWZqF7
         nSwWA67aYVfWfIYFj6HejYyBCe4oEReXflxFheQPBa6MDgim46VkUsgxyCTleW9k84m0
         Df+gJtESu4EEPKCgzKO6FPwOeJCT6L/Hz4XL7hHth+Vig0zWDRMuBZmzL5O/LPy1/SYT
         Rrd0Pa63B8MfWnvHplGYWu/KqNTX7PElAMIj1TPRfQqYFi/J5x1LvB8DMdmaRVegmoP7
         4dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:references:to:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=jxI6DppbbJPvPi6EG4wCD2k6+eiQ3ZxZgYZxLLmOdlE=;
        b=GT3We6jNXJoYLX+niESDRrTNlp5+RHoGAotTjyJuQ2QZItW8+it/BE1LEwiJ4x4zvA
         ZRWD6zx/4ZU+gBayNEMraYuEdqiDZ83K8mpIVmOKryeoELSXcmQr6IRPv6t4yckt7uOX
         nJ3oAxYDfm/aOWtsFidCnRgA2U/q3fUiWRZgOV2RY83sZFqBRYkN6eF2gZ6xZVe3kMfw
         0zWSXlT3sYBallz5lnLHXBFmBr/WE7bz1X1k5Gmx3TVer+ypgHrKKXwRSTwyJAkzVcTl
         7JRB4DK+SK7pTUa5WHRivQXVrpBDC9Jecf6cUyVwpzwM5XPRLw5DJd78IwZNZ4c4CkdS
         Y7vw==
X-Gm-Message-State: AJIora87cw2k6w9PAHR0oOoAI1Swnj1FInACw9QJ+MzCoseuEDYDEEzu
        xwx7jtLVkSMZMWnI+CAiUp9mGw==
X-Google-Smtp-Source: AGRyM1uARwBjd8p4QYqdLqs5tSV8jXvDl3xLEbRyRDekitNd0e2LiF+Ze5qalIOw8Sp9V88SvyikOg==
X-Received: by 2002:a05:6214:c2a:b0:473:7a9a:17ae with SMTP id a10-20020a0562140c2a00b004737a9a17aemr29792367qvd.57.1658340979098;
        Wed, 20 Jul 2022 11:16:19 -0700 (PDT)
Received: from [10.251.207.238] ([65.112.10.194])
        by smtp.gmail.com with ESMTPSA id l4-20020ac81484000000b0031ec9f9e3b1sm12832662qtj.24.2022.07.20.11.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:16:18 -0700 (PDT)
Message-ID: <6b6c9e8b-deb1-f570-a082-2924eb1aef98@cfa.harvard.edu>
Date:   Wed, 20 Jul 2022 14:16:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: libtirpc connect deadlock (part 2)
Content-Language: en-US
References: <76bfebd4-b4cd-4403-8a6d-676705bfdcf9@cfa.harvard.edu>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
In-Reply-To: <76bfebd4-b4cd-4403-8a6d-676705bfdcf9@cfa.harvard.edu>
X-Forwarded-Message-Id: <76bfebd4-b4cd-4403-8a6d-676705bfdcf9@cfa.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


More mutex issues -- this time more likely to do with the connect 
deadlock we see:

in clnt_dg.c, in clnt_dg_create():


clnt_fd_lock is locked on L171, but then not released if jumping to the 
err1 label on an error (L175 and L180). This means that those errors 
will deadlock all further operations that require clnt_fd_lock access.

Same in clnt_vc.c in clnt_vc_create, on lines 215, 222, and 230 
respectively.

-- A.





On 7/20/22 12:09, Attila Kovacs wrote:
> Hi Steve,
> 
> 
> We are using the tirpc library in an MT environment. We are experiencing 
> occasional deadlocks when calling clnt_create_timed() concurrently from 
> multiple threads. When this happens, all connect threads hang, with each 
> thread taking up 100% CPU.
> 
> I was peeking at the code (release 1.3.2), and some potential problems I 
> see is how waiting / signaling is implemented on cu->cu_fd_lock.cv in 
> clnt_dg.c and clnt_vc.c.
> 
> 1. In cnlt_dg_freeres() and clnt_vc_freeres(), cond_signal() is called 
> after unlocking the mutex (clnt_fd_lock). The manual of 
> pthread_cond_signal() allows that, but mentions that for consistent 
> scheduling, cond_signal() should be called with the waiting mutex 
> locked.  (i.e. lock -> signal -> unlock, rather than lock -> unlock -> 
> signal).
> 
> One of the dangers of signaling with the unlocked mutex, is that in MT, 
> another thread can lock the mutex before the signal call is made, and 
> potentially destroy the condition variable (e.g. an asynchronous call to 
> clnt_*_destroy()). Thus, by the time the signal() is called in 
> clnt*_freeres(), both the condition may be invalid.
> 
> The proper sequence here should be:
> 
>      [...]
>      mutex_lock(&clnt_fd_lock);
>      while (ct->ct_fd_lock->active)
>          cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
>      xdrs->x_op = XDR_FREE;
>      dummy = (*xdr_res)(xdrs, res_ptr);
>      thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
>      cond_signal(&ct->ct_fd_lock->cv);
>      mutex_unlock(&clnt_fd_lock);
> 
> 
> 2. Similar issue in the macro release_fd_lock() in both the vc and dg 
> sources. Here again the sequence ought to be:
> 
> #define release_fd_lock(fd_lock, mask) {    \
>      mutex_lock(&clnt_fd_lock);    \
>      fd_lock->active = FALSE;    \
>      thr_sigsetmask(SIG_SETMASK, &(mask), (sigset_t *) NULL); \
>      cond_signal(&fd_lock->cv);    \
>      mutex_unlock(&clnt_fd_lock);    \
> }
> 
> 
> 3. The use of cond_wait() in clnt_dg.c and clnt_vc.c is also unprotected 
> against the asynchronous destruction of the condition variable, since 
> cond_wait() releases the mutex as it enters the waiting state. So, when 
> it is called again in the while() loop, the condtion might no longer 
> exist. Thus, before calling cond_wait(), one should check that the 
> client is valid (not destroyed) inside the wait loop.
> 
> 
> I'm not sure if these particular issues are the cause of the deadlocks 
> we see, but I think they are problematic enough on their own, and 
> perhaps should be fixed in the next release.
> 
> Thanks,
> 
> -- Attila
