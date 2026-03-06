Return-Path: <linux-nfs+bounces-19833-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AWSNIjiqmkTYAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19833-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 15:19:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809D52227E7
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3656B30E9DA2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F523469E7;
	Fri,  6 Mar 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il8W8Q5C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F098292B44;
	Fri,  6 Mar 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806113; cv=none; b=gEafP0H8Mldsb1Np0YUWbzfcEzbvyvJne8yvZO/oiAFIWxaIa4AH9nHSOomg9WIqtTuWgfiWwDHDKCPCJeL/ao5pcNTSJhYkB1La/JlINdteHCPLmZvSNcmbwp87BEYRYw/xsXSgX4SQitv+76tYtjrgeurq0VscGYETmV3vSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806113; c=relaxed/simple;
	bh=4MdGIbdndDFCXfwOf0TVp8VdxUpp+s5KJh5cTZCa4y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=uPFn0wY3tYxlnHlkoMR8rFoydLYmJe6HMlNGoS0dU2EgPYGJzpMORFuYMdra92wLyBtcnunevc6oOQkWpwsctb21la73LJ8Lf3Bj2ho09CcCbnHNx4WNAQhJ1TTFwkLP+XTvZLVDCzO9Xf2XcXh/my4ya7IodPKBxsLdZWFEXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il8W8Q5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38C8C2BC86;
	Fri,  6 Mar 2026 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772806113;
	bh=4MdGIbdndDFCXfwOf0TVp8VdxUpp+s5KJh5cTZCa4y4=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:From;
	b=Il8W8Q5CS7L7P0bqo7Us0iIYS+WhXJUOEb6CER6p4507+nweqA6pmTUkrTmWKCZYn
	 OcMUvncMKjCPahYcsW24aDEqyWlWu3DzoJtoi5MRomgR/HzTR6VX3O/tBeVLMrwKrY
	 j9b+uiS/Kwojk05jNdKZtMdJbv6/1KhgO+h4IQunQvYBLez6uqQUX5IEL07z+iNiir
	 1jgUYbWkiYKuJHWUfPbP0AWg0LSS5lQyVXjyZbtEbdk5J9JFKqVQWbXsG5WKIEMiFq
	 SzBVSkbHuDK9UsrqBOaU3Le1NLR/mdH5shVNxcd6RGbDQ4Lpby7lVEjcBR7F7+AIzM
	 d7momE3le035w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 15:07:31 +0100
Subject: [PATCH] kthread: remove kthread_exit()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKLfqmkC/yWMQQ7CIBBFr2JYi4FpC+hVjAsYphar1AxVmzS9u
 60u389/bxaFOFERp90smN6ppCGvoPc7gZ3PV5IprixAgVGVMvIzcC974kx3SVMaJZBr45EAwWu
 xak+mNk2/5Pny5/IKN8Jx62yP4AvJwD5jt00PX0biA2plrWvQkovBh6hRu0ppr7Ey0NR1aKwz4
 EAsyxdp09x5tgAAAA==
X-Change-ID: 20260306-work-kernel-exit-2e8fd9e2c2a1
In-Reply-To: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
To: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-1404c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4745; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4MdGIbdndDFCXfwOf0TVp8VdxUpp+s5KJh5cTZCa4y4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuun9zi3BDvPhGva7N9jzc0WLt//ImTHJ6mbiAa1Jii
 onw4sTFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5xczIsFX3ReLthQdXXuNI
 CpVK9/mw6GnZgm27IpN0cq2Sudb43Gb475566W5uru1bmY1O95xfbrj57apDYsOxuz2sZkqRSr3
 C3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 809D52227E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19833-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,google.com,atomlin.com,oracle.com,brown.name,redhat.com,talpey.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,arm.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In 28aaa9c39945 ("kthread: consolidate kthread exit paths to prevent use-after-free")
we folded kthread_exit() into do_exit() when we fixed a nasty UAF bug.
We left kthread_exit() around as an alias to do_exit(). Remove it
completely.

Reported-by: Christian Loehle <christian.loehle@arm.com>
Link: https://lore.kernel.org/1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/kthread.h    | 1 -
 include/linux/module.h     | 2 +-
 include/linux/sunrpc/svc.h | 2 +-
 kernel/bpf/verifier.c      | 1 -
 kernel/kthread.c           | 8 ++++----
 kernel/module/main.c       | 2 +-
 lib/kunit/try-catch.c      | 2 +-
 7 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index a01a474719a7..37982eca94f1 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -116,7 +116,6 @@ void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
-#define kthread_exit(result) do_exit(result)
 void kthread_complete_and_exit(struct completion *, long) __noreturn;
 int kthreads_update_housekeeping(void);
 void kthread_do_exit(struct kthread *, long);
diff --git a/include/linux/module.h b/include/linux/module.h
index 14f391b186c6..79ac4a700b39 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -855,7 +855,7 @@ static inline int unregister_module_notifier(struct notifier_block *nb)
 	return 0;
 }
 
-#define module_put_and_kthread_exit(code) kthread_exit(code)
+#define module_put_and_kthread_exit(code) do_exit(code)
 
 static inline void print_modules(void)
 {
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4dc14c7a711b..c86fc8a87eae 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -338,7 +338,7 @@ static inline void svc_thread_init_status(struct svc_rqst *rqstp, int err)
 {
 	store_release_wake_up(&rqstp->rq_err, err);
 	if (err)
-		kthread_exit(1);
+		do_exit(1);
 }
 
 struct svc_deferred_req {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401d6c4960ec..8db79e593156 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25261,7 +25261,6 @@ BTF_ID(func, __x64_sys_exit_group)
 BTF_ID(func, do_exit)
 BTF_ID(func, do_group_exit)
 BTF_ID(func, kthread_complete_and_exit)
-BTF_ID(func, kthread_exit)
 BTF_ID(func, make_task_dead)
 BTF_SET_END(noreturn_deny)
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 791210daf8b4..1447c14c8540 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -323,7 +323,7 @@ void __noreturn kthread_complete_and_exit(struct completion *comp, long code)
 	if (comp)
 		complete(comp);
 
-	kthread_exit(code);
+	do_exit(code);
 }
 EXPORT_SYMBOL(kthread_complete_and_exit);
 
@@ -395,7 +395,7 @@ static int kthread(void *_create)
 	if (!done) {
 		kfree(create->full_name);
 		kfree(create);
-		kthread_exit(-EINTR);
+		do_exit(-EINTR);
 	}
 
 	self->full_name = create->full_name;
@@ -435,7 +435,7 @@ static int kthread(void *_create)
 		__kthread_parkme(self);
 		ret = threadfn(data);
 	}
-	kthread_exit(ret);
+	do_exit(ret);
 }
 
 /* called from kernel_clone() to get node information for about to be created task */
@@ -738,7 +738,7 @@ EXPORT_SYMBOL_GPL(kthread_park);
  * instead of calling wake_up_process(): the thread will exit without
  * calling threadfn().
  *
- * If threadfn() may call kthread_exit() itself, the caller must ensure
+ * If threadfn() may call do_exit() itself, the caller must ensure
  * task_struct can't go away.
  *
  * Returns the result of threadfn(), or %-EINTR if wake_up_process()
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c3ce106c70af..340b4dc5c692 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -228,7 +228,7 @@ static int mod_strncmp(const char *str_a, const char *str_b, size_t n)
 void __noreturn __module_put_and_kthread_exit(struct module *mod, long code)
 {
 	module_put(mod);
-	kthread_exit(code);
+	do_exit(code);
 }
 EXPORT_SYMBOL(__module_put_and_kthread_exit);
 
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index d84a879f0a78..99d9603a2cfd 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -18,7 +18,7 @@
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
 {
 	try_catch->try_result = -EFAULT;
-	kthread_exit(0);
+	do_exit(0);
 }
 EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 

---
base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
change-id: 20260306-work-kernel-exit-2e8fd9e2c2a1


