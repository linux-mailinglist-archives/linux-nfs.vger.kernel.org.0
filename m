Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0B1C7510
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2020 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgEFPg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 May 2020 11:36:59 -0400
Received: from fieldses.org ([173.255.197.46]:47704 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFPg7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 6 May 2020 11:36:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 918B71507; Wed,  6 May 2020 11:36:58 -0400 (EDT)
Date:   Wed, 6 May 2020 11:36:58 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Message-ID: <20200506153658.GA21307@fieldses.org>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
 <20200501182154.GG5462@mtj.thefacebook.com>
 <20200505021514.GA43625@pick.fieldses.org>
 <20200505210118.GC27966@fieldses.org>
 <20200505210956.GA3350@mtj.thefacebook.com>
 <20200505212527.GA1265@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505212527.GA1265@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 05, 2020 at 05:25:27PM -0400, J. Bruce Fields wrote:
> On Tue, May 05, 2020 at 05:09:56PM -0400, Tejun Heo wrote:
> > It's not the end of the world but a bit hacky. I wonder whether something
> > like the following would work better for identifying worker type so that you
> > can do sth like
> > 
> >  if (kthread_fn(current) == nfsd)
> >         return kthread_data(current);
> >  else
> >         return NULL;     
> 
> Yes, definitely more generic, looks good to me.

This is what I'm testing with.

If it's OK with you, could I add your Signed-off-by and take it through
the nfsd tree? I'll have some other patches that will depend on it.

--b.


commit 379bfe5257b6
Author: Tejun Heo <tj@kernel.org>
Date:   Tue May 5 21:26:07 2020 -0400

    kthread: save thread function
    
    It's handy to keep the kthread_fn just as a unique cookie to identify
    classes of kthreads.  E.g. if you can verify that a given task is
    running your thread_fn, then you may know what sort of type kthread_data
    points to.
    
    We'll use this in nfsd to pass some information into the vfs.  Note it
    will need kthread_data() exported too.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8bbcaad7ef0f..c00ee443833f 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -57,6 +57,7 @@ bool kthread_should_stop(void);
 bool kthread_should_park(void);
 bool __kthread_should_park(struct task_struct *k);
 bool kthread_freezable_should_stop(bool *was_frozen);
+void *kthread_fn(struct task_struct *k);
 void *kthread_data(struct task_struct *k);
 void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..b87c4a9ba91d 100644
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
@@ -152,6 +153,20 @@ bool kthread_freezable_should_stop(bool *was_frozen)
 }
 EXPORT_SYMBOL_GPL(kthread_freezable_should_stop);
 
+/**
+ * kthread_fn - return the function specified on kthread creation
+ * @task: kthread task in question
+ *
+ * Returns NULL if the task is not a kthread.
+ */
+void *kthread_fn(struct task_struct *task)
+{
+	if (task->flags & PF_KTHREAD)
+		return to_kthread(task)->threadfn;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kthread_fn);
+
 /**
  * kthread_data - return data value specified on kthread creation
  * @task: kthread task in question
@@ -164,6 +179,7 @@ void *kthread_data(struct task_struct *task)
 {
 	return to_kthread(task)->data;
 }
+EXPORT_SYMBOL_GPL(kthread_data);
 
 /**
  * kthread_probe_data - speculative version of kthread_data()
@@ -244,6 +260,7 @@ static int kthread(void *_create)
 		do_exit(-ENOMEM);
 	}
 
+	self->threadfn = threadfn;
 	self->data = data;
 	init_completion(&self->exited);
 	init_completion(&self->parked);
