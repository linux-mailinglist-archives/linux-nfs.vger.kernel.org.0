Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F50780511
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 06:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357837AbjHRERu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 00:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357847AbjHRERr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 00:17:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F0A3A89
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 21:17:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6887918ed20so460769b3a.2
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 21:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692332263; x=1692937063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzp8o6UVJ89VPkesQr5UYvC4BZNN7PmnH0yRN5wQzOY=;
        b=P1GBev/HuDrl1xjHX/tUjSgVcWYLjOrOl2gLQktwERatrrSj0nSyB3sy6xi3nZ1FEk
         kVNiBOq31f6A9AUOho6oXUGkLrym+9uAh1WbakRR6Yk8F20NnoPRaOLidAqrQf72hdXA
         yxY9MToP4JM5znfm8woDAelQMI3wRx2QQtJgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692332263; x=1692937063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzp8o6UVJ89VPkesQr5UYvC4BZNN7PmnH0yRN5wQzOY=;
        b=ReAfdChSDXqy0VRwmDBd7heZHwjAfVC20K1nqn2QfEJkOhhiCp9kSLOh1JSA/B+ZaJ
         F13bNnjFzNZ5jMO73+3j5FB/lbMiXJIQDDymS6suiEG1fn3xiVNvWvoxFxa4bfNTS7BR
         U7xVsoLnPCHRrbY8L+D7JkgxFGUl/SGpTDRuYeRmUJWqBMO6GvOJaS0hbJsK9juiXTA0
         efHvCpqKJc5ucDvIULdZ4WDybolYWRDUZc4e23dmrMzVGeaJ9qAahWeW08B22OMeaYgw
         rXj9BaLso1PrBYRMr9qNwvYYOnmFZ18lGi8TkGnKhT69oMiORciUaqHLWjMZPILwZJ4Q
         wUBA==
X-Gm-Message-State: AOJu0Yz9WnoDPR83aJb7W6uRW+nF8bwDsH7pl4sEOKWvRUEGCUdT/EWw
        ghgfVybdPfxpVV3n/jcLvpJTMA==
X-Google-Smtp-Source: AGHT+IE66JR3uF9G+6hcM/yWjaiQ9USFm/rzMs+hAp8EYk6TzUEu01etOchOC0NfF1Vsh+aOOkQc5w==
X-Received: by 2002:a05:6a00:2314:b0:67b:2eba:bed4 with SMTP id h20-20020a056a00231400b0067b2ebabed4mr1833081pfh.14.1692332263184;
        Thu, 17 Aug 2023 21:17:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b0068783a2dfdasm543927pfn.104.2023.08.17.21.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 21:17:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2] creds: Convert cred.usage to refcount_t
Date:   Thu, 17 Aug 2023 21:17:41 -0700
Message-Id: <20230818041740.gonna.513-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9969; i=keescook@chromium.org;
 h=from:subject:message-id; bh=P/gn9IgZypDJ5qwwLhQ+xDx4moQ5ZSbGFbT+n4eucKs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3vDk6rSsQ/jFsjnairlrUT16tGA2jg31CZMgK
 qPEhf0iaJCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN7w5AAKCRCJcvTf3G3A
 JseuD/sFXdKJv4DiiwAp1ck5kvFAusJjPnJj/mmKDke5s6XIUv6ZN/7Rpv9U3ixpfIWvqAdGfU+
 UfUVj6KOziQXGaMXmvon8PaTvU5XkqcgN4C5FuUYQ+fc2Ep9pto0cl0gHA0/HVwoA0AQGcsLlzn
 H/fZbxxSuAPxrKm3hQaYbNEfGgzk3AHJ/npoqLcfsMTIiVhNKjaywNtrekvb5WNF2gHaYlofj9M
 taxPm6qE/tJJwS4Gb2sUu/TXMt7w54vg6+w/b2vNm9idmD0JvD0N35ES9Yu4iP4oCJDW4BknIRb
 RM35arC8ZYi81og2lNdCkvaqpgxZYXIY/VOGHSWUIigNtjWEqQJG4665brLN3/jsgsbThIOPSIg
 k6/bLqJ/980bu07yHdSREmJX6nI/jCViGPHQZ04n0szVi4jAdQlIsIZdg7qYM/DnRj+Y0dKM84j
 /wemkLxmLvniG3KKMiLxixiAsCN4lBRLwt9tWUug8V2alizNFS0OVQrutgxRBSWxj+aw0TV32gp
 IzjOgKydleHLKRmNaxZ6bBRpcGYRcNrR0jA71embhtEg6xhy3QS5tGVdHT0tfFUN2KX6NLFTKT/
 i0cLPsk9sjzhPhE7lPtQh4I8HmjzhD82vl6dXt2MdxZQzJbZ7iLRwzf7uySAEnefSomaAKNx98R
 0NQ19p/ AqOA4Ybg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Elena Reshetova <elena.reshetova@intel.com>

atomic_t variables are currently used to implement reference counters
with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows and
underflows. This is important since overflows and underflows can lead
to use-after-free situation and be exploitable.

The variable cred.usage is used as pure reference counter. Convert it
to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in refcount.h have different
memory ordering guarantees than their atomic counterparts. Please check
Documentation/core-api/refcount-vs-atomic.rst for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in some
rare cases it might matter.  Please double check that you don't have
some undocumented memory guarantees for this variable usage.

For the cred.usage it might make a difference in following places:
 - get_task_cred(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered atomic
   counterpart
 - put_cred(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering on success vs. fully
   ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: rebase
v1: https://lore.kernel.org/lkml/20200612183450.4189588-4-keescook@chromium.org/
---
 include/linux/cred.h |  8 ++++----
 kernel/cred.c        | 42 +++++++++++++++++++++---------------------
 net/sunrpc/auth.c    |  2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 8661f6294ad4..bf1c142afcec 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -109,7 +109,7 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  * same context as task->real_cred.
  */
 struct cred {
-	atomic_t	usage;
+	refcount_t	usage;
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	atomic_t	subscribers;	/* number of processes subscribed */
 	void		*put_addr;
@@ -229,7 +229,7 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
+	refcount_inc(&cred->usage);
 	return cred;
 }
 
@@ -261,7 +261,7 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
-	if (!atomic_inc_not_zero(&nonconst_cred->usage))
+	if (!refcount_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	validate_creds(cred);
 	nonconst_cred->non_rcu = 0;
@@ -285,7 +285,7 @@ static inline void put_cred(const struct cred *_cred)
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (refcount_dec_and_test(&(cred)->usage))
 			__put_cred(cred);
 	}
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index bed458cfb812..33090c43bcac 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -39,7 +39,7 @@ static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
  * The initial credentials for the initial task
  */
 struct cred init_cred = {
-	.usage			= ATOMIC_INIT(4),
+	.usage			= REFCOUNT_INIT(4),
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	.subscribers		= ATOMIC_INIT(2),
 	.magic			= CRED_MAGIC,
@@ -99,17 +99,17 @@ static void put_cred_rcu(struct rcu_head *rcu)
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	if (cred->magic != CRED_MAGIC_DEAD ||
-	    atomic_read(&cred->usage) != 0 ||
+	    refcount_read(&cred->usage) != 0 ||
 	    read_cred_subscribers(cred) != 0)
 		panic("CRED: put_cred_rcu() sees %p with"
 		      " mag %x, put %p, usage %d, subscr %d\n",
 		      cred, cred->magic, cred->put_addr,
-		      atomic_read(&cred->usage),
+		      refcount_read(&cred->usage),
 		      read_cred_subscribers(cred));
 #else
-	if (atomic_read(&cred->usage) != 0)
+	if (refcount_read(&cred->usage) != 0)
 		panic("CRED: put_cred_rcu() sees %p with usage %d\n",
-		      cred, atomic_read(&cred->usage));
+		      cred, refcount_read(&cred->usage));
 #endif
 
 	security_cred_free(cred);
@@ -135,10 +135,10 @@ static void put_cred_rcu(struct rcu_head *rcu)
 void __put_cred(struct cred *cred)
 {
 	kdebug("__put_cred(%p{%d,%d})", cred,
-	       atomic_read(&cred->usage),
+	       refcount_read(&cred->usage),
 	       read_cred_subscribers(cred));
 
-	BUG_ON(atomic_read(&cred->usage) != 0);
+	BUG_ON(refcount_read(&cred->usage) != 0);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(cred) != 0);
 	cred->magic = CRED_MAGIC_DEAD;
@@ -162,7 +162,7 @@ void exit_creds(struct task_struct *tsk)
 	struct cred *cred;
 
 	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       refcount_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	cred = (struct cred *) tsk->real_cred;
@@ -221,7 +221,7 @@ struct cred *cred_alloc_blank(void)
 	if (!new)
 		return NULL;
 
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
@@ -267,7 +267,7 @@ struct cred *prepare_creds(void)
 	memcpy(new, old, sizeof(struct cred));
 
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -356,7 +356,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		get_cred(p->cred);
 		alter_cred_subscribers(p->cred, 2);
 		kdebug("share_creds(%p{%d,%d})",
-		       p->cred, atomic_read(&p->cred->usage),
+		       p->cred, refcount_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
 		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 		return 0;
@@ -450,7 +450,7 @@ int commit_creds(struct cred *new)
 	const struct cred *old = task->real_cred;
 
 	kdebug("commit_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	BUG_ON(task->cred != old);
@@ -459,7 +459,7 @@ int commit_creds(struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(refcount_read(&new->usage) < 1);
 
 	get_cred(new); /* we will require a ref for the subj creds too */
 
@@ -533,13 +533,13 @@ EXPORT_SYMBOL(commit_creds);
 void abort_creds(struct cred *new)
 {
 	kdebug("abort_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(new) != 0);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(refcount_read(&new->usage) < 1);
 	put_cred(new);
 }
 EXPORT_SYMBOL(abort_creds);
@@ -556,7 +556,7 @@ const struct cred *override_creds(const struct cred *new)
 	const struct cred *old = current->cred;
 
 	kdebug("override_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	       refcount_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	validate_creds(old);
@@ -579,7 +579,7 @@ const struct cred *override_creds(const struct cred *new)
 	alter_cred_subscribers(old, -1);
 
 	kdebug("override_creds() = %p{%d,%d}", old,
-	       atomic_read(&old->usage),
+	       refcount_read(&old->usage),
 	       read_cred_subscribers(old));
 	return old;
 }
@@ -597,7 +597,7 @@ void revert_creds(const struct cred *old)
 	const struct cred *override = current->cred;
 
 	kdebug("revert_creds(%p{%d,%d})", old,
-	       atomic_read(&old->usage),
+	       refcount_read(&old->usage),
 	       read_cred_subscribers(old));
 
 	validate_creds(old);
@@ -728,7 +728,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 
 	*new = *old;
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	refcount_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
@@ -843,7 +843,7 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 	printk(KERN_ERR "CRED: ->magic=%x, put_addr=%p\n",
 	       cred->magic, cred->put_addr);
 	printk(KERN_ERR "CRED: ->usage=%d, subscr=%d\n",
-	       atomic_read(&cred->usage),
+	       refcount_read(&cred->usage),
 	       read_cred_subscribers(cred));
 	printk(KERN_ERR "CRED: ->*uid = { %d,%d,%d,%d }\n",
 		from_kuid_munged(&init_user_ns, cred->uid),
@@ -917,7 +917,7 @@ void validate_creds_for_do_exit(struct task_struct *tsk)
 {
 	kdebug("validate_creds_for_do_exit(%p,%p{%d,%d})",
 	       tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       refcount_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	__validate_process_creds(tsk, __FILE__, __LINE__);
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..f9f406249e7d 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -39,7 +39,7 @@ static LIST_HEAD(cred_unused);
 static unsigned long number_cred_unused;
 
 static struct cred machine_cred = {
-	.usage = ATOMIC_INIT(1),
+	.usage = REFCOUNT_INIT(1),
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	.magic = CRED_MAGIC,
 #endif
-- 
2.34.1

