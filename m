Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAF57BD8A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jul 2022 20:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiGTSPO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jul 2022 14:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGTSPN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jul 2022 14:15:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A695AA
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 11:15:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k7so11350017qkj.2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jul 2022 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :references:to:cc:from:in-reply-to:content-transfer-encoding;
        bh=4EZy7E6qyPaNnOXDUL9pWElVuoeYpKTH6HptmqLE6i0=;
        b=WiOD9OA/12lCAOeg3a0O4m1KwijIbnxh9LKfSIsMJehVi8WlxXC0xrnZ449xBq4ISa
         01Egi//PEBvRzJWWE4/ZQ7bio8yiZ0CiSUoT/cgsu6Yvxvj2P3Y0aNfhyplik6vN7na7
         FrG7mawWythIdorSNW5VCdZvpLES17/SfZMVIz1RzmqbV56zrL25iArVad+U3ohb4lzT
         8SDChfQ1aUS5HuvoeNMCbfysSg6aIuG4loynTTCAZPY4uV1dvU38tglZkSWEeYopf+74
         9MMK3cbbxVV6vJXQcY8j/cJwaDxrza720eKiILcMB1ga0SExWEZ7wsPC/CNSEEUeIXG/
         J2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:references:to:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=4EZy7E6qyPaNnOXDUL9pWElVuoeYpKTH6HptmqLE6i0=;
        b=KJbSHFTSGtP3vIwgQWAxtYDB39fBOiCfwGQWeYTmc3pT/M7+na0G2fDhkJi/TxpWtN
         rpNL9WEmObFhVUfbezMaPuFoNdLGVH2vDGWSpa/Zz7hluGXLSPAAt+yWt04ycFy5B+mL
         G7QWy+LcitxoubxXjRSkmncyxopGxr4z5QtYTxVBc/Hwk93uvABxhpqLzr+KD7g9zmOh
         qWakglNAL+N1xZ7v2rO4AGIAdR9roZqyqOl7zIWs4A8eCvSo/y9M9Fr64VW0FVGMl1QQ
         b2YrN0kKh6VBPNqwI7ZVYiotAl73JCwnOVAdsy+UWUbQva10ONVBVtUo5JT5PUv9ckYh
         TEnw==
X-Gm-Message-State: AJIora8IGmzwa57/iWdjk1anbIIwkni5xTKmQsEEmgz9oPhKq4rXW9TK
        EUCs2pDuZ+uaZNSOy31RVFfZgHL2eU/rUw==
X-Google-Smtp-Source: AGRyM1sYiSs06qM949DrH+bE0lrFZKGdn7v5U+CPDfKwekbaJHZBBz6/UK7h7efsbZFB7rTwccrSrA==
X-Received: by 2002:a05:620a:1a84:b0:6b6:30b:b6b5 with SMTP id bl4-20020a05620a1a8400b006b6030bb6b5mr5844912qkb.440.1658340910305;
        Wed, 20 Jul 2022 11:15:10 -0700 (PDT)
Received: from [10.251.207.238] ([65.112.10.194])
        by smtp.gmail.com with ESMTPSA id x6-20020a05620a258600b006a65c58db99sm17989290qko.64.2022.07.20.11.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:15:09 -0700 (PDT)
Message-ID: <2137f6f2-6b40-dfa5-8556-3eec6cf6dfcb@cfa.harvard.edu>
Date:   Wed, 20 Jul 2022 14:15:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: ibtirpc connect deadlock (part 1)
Content-Language: en-US
References: <866ee543-95f9-9830-f124-b7b3afd918d6@cfa.harvard.edu>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
In-Reply-To: <866ee543-95f9-9830-f124-b7b3afd918d6@cfa.harvard.edu>
X-Forwarded-Message-Id: <866ee543-95f9-9830-f124-b7b3afd918d6@cfa.harvard.edu>
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

Hi,

We are using the tirpc library in an MT environment. We are experiencing 
occasional deadlocks when calling clnt_create_timed() concurrently from 
multiple threads. When this happens, all connect threads hang, with each 
thread taking up 100% CPU.

I was peeking at the code (release 1.3.2), and some potential problems I 
see is how waiting / signaling is implemented on cu->cu_fd_lock.cv in 
clnt_dg.c and clnt_vc.c.

1. In cnlt_dg_freeres() and clnt_vc_freeres(), cond_signal() is called 
after unlocking the mutex (clnt_fd_lock). The manual of 
pthread_cond_signal() allows that, but mentions that for consistent 
scheduling, cond_signal() should be called with the waiting mutex 
locked.  (i.e. lock -> signal -> unlock, rather than lock -> unlock -> 
signal).

One of the dangers of signaling with the unlocked mutex, is that in MT, 
another thread can lock the mutex before the signal call is made, and 
potentially destroy the condition variable (e.g. an asynchronous call to 
clnt_*_destroy()). Thus, by the time the signal() is called in 
clnt*_freeres(), both the condition may be invalid.

The proper sequence here should be:

	[...]
	mutex_lock(&clnt_fd_lock);
	while (ct->ct_fd_lock->active)
		cond_wait(&ct->ct_fd_lock->cv, &clnt_fd_lock);
	xdrs->x_op = XDR_FREE;
	dummy = (*xdr_res)(xdrs, res_ptr);
	thr_sigsetmask(SIG_SETMASK, &(mask), NULL);
	cond_signal(&ct->ct_fd_lock->cv);
	mutex_unlock(&clnt_fd_lock);


2. Similar issue in the macro release_fd_lock() in both the vc and dg 
sources. Here again the sequence ought to be:

#define release_fd_lock(fd_lock, mask) {	\
	mutex_lock(&clnt_fd_lock);	\
	fd_lock->active = FALSE;	\
	thr_sigsetmask(SIG_SETMASK, &(mask), (sigset_t *) NULL); \
	cond_signal(&fd_lock->cv);	\
	mutex_unlock(&clnt_fd_lock);	\
}


3. The use of cond_wait() in clnt_dg.c and clnt_vc.c is also unprotected 
against the asynchronous destruction of the condition variable, since 
cond_wait() releases the mutex as it enters the waiting state. So, when 
it is called again in the while() loop, the condtion might no longer 
exist. Thus, before calling cond_wait(), one should check that the 
client is valid (not destroyed) inside the wait loop.


I'm not sure if these particular issues are the cause of the deadlocks 
we see, but I think they are problematic enough on their own, and 
perhaps should be fixed in the next release.

Thanks,

-- Attila
