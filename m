Return-Path: <linux-nfs+bounces-22829-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 12S0NY0GPWryvwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22829-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 12:44:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 957306C4C59
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 12:44:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D0fpngk0;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22829-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22829-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DD9B3045817
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148DE3D8133;
	Thu, 25 Jun 2026 10:43:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2673CE481;
	Thu, 25 Jun 2026 10:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384217; cv=none; b=XIG1PgeW8MWQ9lT4IzJ3szHyZ4GVocQwHgCAabIrslbrMdd++ty8tfOlSoptIhC12g2SapDmFR06COQ/0hkzN0OPC4RyWVi7jIfVni0gdaPiiaNyR61mtbUldl6/0Woy2jURJo7XUXa5Ks6/CpAZReTGWdhbvEB5AGspKG0dpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384217; c=relaxed/simple;
	bh=3eOu9RllypV894kRW0oTPEZC6/tDvaMAlp0sWUEqrd0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sd6WgqHgG+Md4XeWioE62JGYke0KJAkh8JVfmQcLnBBM9aKLCSKFERbzAJf/fL2wAiBtQrIHWR1R7nmQyBmkowJWVumr1jnhnv420OeAtECPTbnkyNVZHdZ/uojvUOFYtTxl829JZXAQ3mDUOT+LVJj9W/pYCTg7InSM7wxB3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0fpngk0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DB81F000E9;
	Thu, 25 Jun 2026 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384214;
	bh=So56zEOdEfiZU+vXcUQqeRQSzEvYq6PmDku1aeJMKLs=;
	h=Date:From:To:Cc:Subject:References;
	b=D0fpngk0P6IaMUg/fv2JW/n3Umw6ehE2vavcoRCFZVGOIYdkkIKj8QrcaqmMsrBL1
	 80qZCqxSYMgGZDTaiQ4H9rlKsdQm5bLEqtfC9vn2+eCJ9ByNXKH8vpy1s3XuZyRw5m
	 TkjWReQzGL+Fa0dZ4SCdpdGSLsSLfztcwkWwgEq+D4OEX4No/2vy6nWwoguvgcgzmq
	 8oI8elnVnl438BD2vtSae8+F4shF/u1y+HbsNg3OPf67HtVJQINCf7jkbgjo9/SY6q
	 NKZa1fGonzzRLrf8mzvB/6utE1xf+YCDXwQnw54Z6fduPScgik9Awd8H3pqa+5zcZJ
	 4QSlIX2Ku/s0w==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wchYw-00000002WA7-0nb8;
	Thu, 25 Jun 2026 06:44:02 -0400
Message-ID: <20260625104402.064484896@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 25 Jun 2026 06:40:08 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org,
 linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org,
 kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 1/2] tracing: Move non-trace_printk prototypes into trace_controls.h
References: <20260625104007.041432666@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22829-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,vger.kernel.org,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,goodmis.org:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 957306C4C59

From: Steven Rostedt <rostedt@goodmis.org>

Remove the prototypes of the code that is not associated with
trace_printk() from trace_printk.h.

These control functions as well as ftrace_dump() and trace_dump_stack()
are used in cases where things go wrong.  The main use case is to do a
trace_dump_stack(); tracing_off(); ftrace_dump(); in a place that detected
that something went wrong, whereas, trace_printk() is added to normal code
during debugging and removed before committing upstream. The dump code is
fine to keep in production.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v3: https://patch.msgid.link/20260624081948.147764194@kernel.org

- Move include out of #if statement in rcu.h
  kernel test robot found other configs that could require the
  control functions in rcu.h. Just always include it in that file.

 arch/powerpc/xmon/xmon.c         |  1 +
 arch/s390/kernel/ipl.c           |  1 +
 arch/s390/kernel/machine_kexec.c |  1 +
 drivers/gpu/drm/i915/i915_gem.h  |  1 +
 drivers/tty/sysrq.c              |  1 +
 include/linux/trace_controls.h   | 54 ++++++++++++++++++++++++++++++++
 include/linux/trace_printk.h     | 51 ------------------------------
 kernel/debug/debug_core.c        |  1 +
 kernel/panic.c                   |  1 +
 kernel/rcu/rcu.h                 |  1 +
 kernel/rcu/rcutorture.c          |  1 +
 kernel/trace/trace.h             |  1 +
 kernel/trace/trace_benchmark.c   |  1 +
 lib/sys_info.c                   |  1 +
 14 files changed, 66 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/trace_controls.h

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cb3a3244ae6f..2135f319e0dd 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -27,6 +27,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/debugfs.h>
+#include <linux/trace_controls.h>
 
 #include <asm/ptrace.h>
 #include <asm/smp.h>
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 3c346b02ceb9..baac66cc4de4 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -22,6 +22,7 @@
 #include <linux/debug_locks.h>
 #include <linux/vmalloc.h>
 #include <linux/secure_boot.h>
+#include <linux/trace_controls.h>
 #include <asm/asm-extable.h>
 #include <asm/machine.h>
 #include <asm/diag.h>
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index baeb3dcfc1c8..33f9a89eb3ad 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/ftrace.h>
+#include <linux/trace_controls.h>
 #include <linux/debug_locks.h>
 #include <linux/cpufeature.h>
 #include <asm/guarded_storage.h>
diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
index 20b3cb29cfff..1da8fb61c09e 100644
--- a/drivers/gpu/drm/i915/i915_gem.h
+++ b/drivers/gpu/drm/i915/i915_gem.h
@@ -116,6 +116,7 @@ int i915_gem_open(struct drm_i915_private *i915, struct drm_file *file);
 #endif
 
 #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GEM)
+#include <linux/trace_controls.h>
 #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
 #define GEM_TRACE_ERR(...) do {						\
 	pr_err(__VA_ARGS__);						\
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699a..d3f72dc430b8 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -324,6 +324,7 @@ static const struct sysrq_key_op sysrq_showstate_blocked_op = {
 };
 
 #ifdef CONFIG_TRACING
+#include <linux/trace_controls.h>
 #include <linux/ftrace.h>
 
 static void sysrq_ftrace_dump(u8 key)
diff --git a/include/linux/trace_controls.h b/include/linux/trace_controls.h
new file mode 100644
index 000000000000..995b97e963b4
--- /dev/null
+++ b/include/linux/trace_controls.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TRACE_CONTROLS_H
+#define _LINUX_TRACE_CONTROLS_H
+
+
+/*
+ * General tracing related utility functions - trace_printk(),
+ * tracing_on/tracing_off and tracing_start()/tracing_stop
+ *
+ * Use tracing_on/tracing_off when you want to quickly turn on or off
+ * tracing. It simply enables or disables the recording of the trace events.
+ * This also corresponds to the user space /sys/kernel/tracing/tracing_on
+ * file, which gives a means for the kernel and userspace to interact.
+ * Place a tracing_off() in the kernel where you want tracing to end.
+ * From user space, examine the trace, and then echo 1 > tracing_on
+ * to continue tracing.
+ *
+ * tracing_stop/tracing_start has slightly more overhead. It is used
+ * by things like suspend to ram where disabling the recording of the
+ * trace is not enough, but tracing must actually stop because things
+ * like calling smp_processor_id() may crash the system.
+ *
+ * Most likely, you want to use tracing_on/tracing_off.
+ */
+enum ftrace_dump_mode {
+	DUMP_NONE,
+	DUMP_ALL,
+	DUMP_ORIG,
+	DUMP_PARAM,
+};
+
+#ifdef CONFIG_TRACING
+void tracing_on(void);
+void tracing_off(void);
+int tracing_is_on(void);
+void tracing_snapshot(void);
+void tracing_snapshot_alloc(void);
+void tracing_start(void);
+void tracing_stop(void);
+void trace_dump_stack(int skip);
+void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
+#else
+static inline void tracing_start(void) { }
+static inline void tracing_stop(void) { }
+static inline void tracing_on(void) { }
+static inline void tracing_off(void) { }
+static inline int tracing_is_on(void) { return 0; }
+static inline void tracing_snapshot(void) { }
+static inline void tracing_snapshot_alloc(void) { }
+static inline void trace_dump_stack(int skip) { }
+static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
+#endif
+
+#endif /* _LINUX_TRACE_CONTROLS_H */
diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index 3d54f440dccf..a488ea9e9f85 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -7,43 +7,7 @@
 #include <linux/stddef.h>
 #include <linux/stringify.h>
 
-/*
- * General tracing related utility functions - trace_printk(),
- * tracing_on/tracing_off and tracing_start()/tracing_stop
- *
- * Use tracing_on/tracing_off when you want to quickly turn on or off
- * tracing. It simply enables or disables the recording of the trace events.
- * This also corresponds to the user space /sys/kernel/tracing/tracing_on
- * file, which gives a means for the kernel and userspace to interact.
- * Place a tracing_off() in the kernel where you want tracing to end.
- * From user space, examine the trace, and then echo 1 > tracing_on
- * to continue tracing.
- *
- * tracing_stop/tracing_start has slightly more overhead. It is used
- * by things like suspend to ram where disabling the recording of the
- * trace is not enough, but tracing must actually stop because things
- * like calling smp_processor_id() may crash the system.
- *
- * Most likely, you want to use tracing_on/tracing_off.
- */
-
-enum ftrace_dump_mode {
-	DUMP_NONE,
-	DUMP_ALL,
-	DUMP_ORIG,
-	DUMP_PARAM,
-};
-
 #ifdef CONFIG_TRACING
-void tracing_on(void);
-void tracing_off(void);
-int tracing_is_on(void);
-void tracing_snapshot(void);
-void tracing_snapshot_alloc(void);
-
-extern void tracing_start(void);
-extern void tracing_stop(void);
-
 static inline __printf(1, 2)
 void ____trace_printk_check_format(const char *fmt, ...)
 {
@@ -149,8 +113,6 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
 extern int __trace_bputs(unsigned long ip, const char *str);
 extern int __trace_puts(unsigned long ip, const char *str);
 
-extern void trace_dump_stack(int skip);
-
 /*
  * The double __builtin_constant_p is because gcc will give us an error
  * if we try to allocate the static variable to fmt if it is not a
@@ -173,19 +135,7 @@ __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
 
 extern __printf(2, 0) int
 __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
-
-extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
 #else
-static inline void tracing_start(void) { }
-static inline void tracing_stop(void) { }
-static inline void trace_dump_stack(int skip) { }
-
-static inline void tracing_on(void) { }
-static inline void tracing_off(void) { }
-static inline int tracing_is_on(void) { return 0; }
-static inline void tracing_snapshot(void) { }
-static inline void tracing_snapshot_alloc(void) { }
-
 static inline __printf(1, 2)
 int trace_printk(const char *fmt, ...)
 {
@@ -196,7 +146,6 @@ ftrace_vprintk(const char *fmt, va_list ap)
 {
 	return 0;
 }
-static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #endif /* CONFIG_TRACING */
 
 #endif
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b276504c1c6b..f9c83a470c98 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -27,6 +27,7 @@
 
 #define pr_fmt(fmt) "KGDB: " fmt
 
+#include <linux/trace_controls.h>
 #include <linux/pid_namespace.h>
 #include <linux/clocksource.h>
 #include <linux/serial_core.h>
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..1415e910371d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -9,6 +9,7 @@
  * This function is used through-out the kernel (including mm and fs)
  * to indicate a major problem.
  */
+#include <linux/trace_controls.h>
 #include <linux/debug_locks.h>
 #include <linux/sched/debug.h>
 #include <linux/interrupt.h>
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1..735a80df0b30 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,6 +12,7 @@
 
 #include <linux/slab.h>
 #include <trace/events/rcu.h>
+#include <linux/trace_controls.h>
 
 /*
  * Grace-period counter management.
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 882a158ada7b..76bf0184b267 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -39,6 +39,7 @@
 #include <linux/srcu.h>
 #include <linux/slab.h>
 #include <linux/trace_clock.h>
+#include <linux/trace_controls.h>
 #include <asm/byteorder.h>
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..2537c33ddd49 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -22,6 +22,7 @@
 #include <linux/ctype.h>
 #include <linux/once_lite.h>
 #include <linux/ftrace_regs.h>
+#include <linux/trace_controls.h>
 #include <linux/llist.h>
 
 #include "pid_list.h"
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index e19c32f2a938..69cc39008c36 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/trace_clock.h>
+#include <linux/trace_controls.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace_benchmark.h"
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..e3c9ca05601b 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
+#include <linux/trace_controls.h>
 #include <linux/string.h>
 #include <linux/sysctl.h>
 
-- 
2.53.0



