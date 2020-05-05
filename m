Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274F01C62A6
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2020 23:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgEEVKB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 May 2020 17:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgEEVKB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 May 2020 17:10:01 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888BDC061A0F;
        Tue,  5 May 2020 14:09:59 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ck5so1788275qvb.11;
        Tue, 05 May 2020 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gxAlApzzt5Fr2H0K0z2Ers4SPsXxQpIbe0gDV+IiJdk=;
        b=ZlG07WlUkAyur6dQ7aip9K3opgyw/I5mnWql1zI3HeSEU7nbUhBt2lsaZGx3VMayp2
         xzo83Oj5Jh1zKx0mQyCEN8VYFFajXjc+hf+8KPdeCMnfe9Z7xpsBzd4JJwcakBInOPVZ
         9Z1gMFw+OtfuB/7gbwJRxua5SlKm2nKvUuwM4Dm+H2WfxUBZZd9Rr/8NCgRxUgTiSNyM
         dkopESb2AeeDUZ2C3UzJ7x9j2LCbDIxd1yzgtCWLL35jLo7sgkyMKtyIhn7j16evOKbo
         kY7GM9DNyd586Cg2Ge9xHqaKxkVfVb7YNP+L3fM5IpykrP7IXbMGMJHrl9r13TnWzi07
         RTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gxAlApzzt5Fr2H0K0z2Ers4SPsXxQpIbe0gDV+IiJdk=;
        b=D4xU3Ts0yHU2lgdPM+Tv9+5WXc/DSFp4Gr3DqjAUJWQSgLDc9/Si1fM4mEuCfRpUOv
         uXfchdBl5RnfdscI6OlwZRUVXpktfJ0pLtK1It00AbdKQx6gAktw16aumAkg8DxzcB+7
         ZM9S5Mzp01QlZD30VzM+NM0AFyOLsBJq7sytGhcwbK/gl3t/P1iBTC/T06XdHWHCvct5
         e2HXM3GQHbQMghioAh84yqFmw5PZK6eC4VtkmlIspPhJSmAywa9YV0EJQ7HSJogx2mPO
         ILuq3B2ZvMc2M3xx0DaLtPW1Ps4JklHnbBiune0C0t8o3NQ1iX4XEYiY8HIK6k5W4yGU
         CLvA==
X-Gm-Message-State: AGi0Pual3tSta5p3RRpBSwWTzrg679gnV3qtl3kVZjeqlavb+GLGhN+4
        NXDjA4jB3cGxAZC4C6dL6NUcT0MEkqI=
X-Google-Smtp-Source: APiQypKA728Pg2MgizEDYb92QcuJxH1yoE0zafaProJrjubchOTsCxZq92aUE19dCNx9WJcJMZi7lw==
X-Received: by 2002:ad4:4f86:: with SMTP id em6mr4980156qvb.218.1588712998509;
        Tue, 05 May 2020 14:09:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8365])
        by smtp.gmail.com with ESMTPSA id i42sm3059938qtc.83.2020.05.05.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 14:09:57 -0700 (PDT)
Date:   Tue, 5 May 2020 17:09:56 -0400
From:   Tejun Heo <tj@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200505210956.GA3350@mtj.thefacebook.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
 <20200505210118.GC27966@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505210118.GC27966@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On Tue, May 05, 2020 at 05:01:18PM -0400, J. Bruce Fields wrote:
> On Mon, May 04, 2020 at 10:15:14PM -0400, J. Bruce Fields wrote:
> > Though now I'm feeling greedy: it would be nice to have both some kind
> > of global flag, *and* keep kthread->data pointing to svc_rqst (as that
> > would give me a simpler and quicker way to figure out which client is
> > conflicting).  Could I take a flag bit in kthread->flags, maybe?
> 
> Would something like this be too hacky?:

It's not the end of the world but a bit hacky. I wonder whether something
like the following would work better for identifying worker type so that you
can do sth like

 if (kthread_fn(current) == nfsd)
        return kthread_data(current);
 else
        return NULL;     

Thanks.

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..4f3ab9f2c994 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -46,6 +46,7 @@ struct kthread_create_info
 struct kthread {
 	unsigned long flags;
 	unsigned int cpu;
+	int (*threadfn)(void *);
 	void *data;
 	struct completion parked;
 	struct completion exited;
@@ -152,6 +153,13 @@ bool kthread_freezable_should_stop(bool *was_frozen)
 }
 EXPORT_SYMBOL_GPL(kthread_freezable_should_stop);
 
+void *kthread_fn(struct task_struct *task)
+{
+	if (task->flags & PF_KTHREAD)
+		return to_kthread(task)->threadfn;
+	return NULL;
+}
+
 /**
  * kthread_data - return data value specified on kthread creation
  * @task: kthread task in question
@@ -244,6 +252,7 @@ static int kthread(void *_create)
 		do_exit(-ENOMEM);
 	}
 
+	self->threadfn = threadfn;
 	self->data = data;
 	init_completion(&self->exited);
 	init_completion(&self->parked);

-- 
tejun
