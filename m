Return-Path: <linux-nfs+bounces-23103-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id erzuJlnuS2qydAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23103-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 20:05:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 838C8714432
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 20:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=irPQXOsd;
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23103-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23103-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64AD32C61ED
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480673FE644;
	Mon,  6 Jul 2026 16:05:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332A39EF20
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 16:05:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353955; cv=none; b=nsm0ayIWTPV90obVx/WbP9ttLuXpE4JYzYdJZuIPvG05N0UgXzTT++ZRTVldUQqqDMIO6Ft6qSvVUJc2aQbX0cbB7rNeIAfqCMPO8fKeETprMH8XZBIKkiizQkkqkVC+nle9Zt9JdwI+6uWt8RMV0cWc/bpZ0CSghHS3ub4Nq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353955; c=relaxed/simple;
	bh=5W1x3Tmofi1YHzDhhfwCxYHyvG+Xwa1/RP8lO532kg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLXZingpsocbunDrLfCZytR7Lp5fd89zqcHuSGjbeM2Io5D7EjGfCfxNqHixRCE6DXiLtMpbvKc8h0NJQfDlSBgtRZ+kmHCqlSd9yDMOplyyrUX9HkuhTtSQkYHLkaa+a4TVaS6ZWi9ktxBI/1NeeN5eruVZeZ98z+AA/WP934c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=irPQXOsd; arc=none smtp.client-ip=209.85.161.53
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a17e36fa79so987240eaf.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jul 2026 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1783353952; x=1783958752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FZowS0iSpc4rvn0U3rbdVSCSJU6ZpVqbXB9rgP8nEk=;
        b=irPQXOsd1Uo8S0gk3H8Vyl+DKeE6PsUcWUkHaPOFvwNT2myyLeTxP4TEZZAho6v8CV
         NfsaqfM7O/LqJneJD3vbtOjkhVOIpaKpt02mVeSaQwT/La61bq+36Y5UXcYJ7dlBHZ4S
         82ww3LhxY/zxaicNBUMeBMDyVmuhqX9D7mlW0aUzP6OIsm4djwpAxMsEAkhUK++jOtk9
         BIV4N0rsAZYLB9On2fyUMBEhio/zQdOxcEVuYz7CIK55Vu9EOy2lP8eCgnhH5qGlbxdp
         ITLUaDhPWneZ3k6KfIQzI0PLePvDGVWXgvMS4ktnt0BcjcfIlTy+dECADW3HwqXV8Ef6
         Bwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353952; x=1783958752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FZowS0iSpc4rvn0U3rbdVSCSJU6ZpVqbXB9rgP8nEk=;
        b=d824dAWeCqKlZHlbDE6NUkzkNWZPtyczGUfLi/FFAVfjkjv9BS93TK4d1J6FsDMDKt
         WKHTjYgFcoM8lNZJr4ril9b+6MbiVkG84j6r+ETc4SATzLTYWAQ15duL8umDqFo0JXb7
         K88y4zC5PezgXf+gq+Tpikk5wmcz45L1dNU0kuoCUNbo4YR5D3TZ9rPKh51FOoS3aVvV
         n8Lsj1OP43J7Ud4LzZm/HY6NbyqiAf/wJ8MwWnIEyF51UPTVMmt/jDyCRPSEvnXDX73U
         mSyclFqc5tKVCuVWD8RqOlp3iocUAlnxWiD8Y7VRricY2W5c6uN0dLfVO7aWOLFt4N2L
         RVlw==
X-Forwarded-Encrypted: i=1; AFNElJ8sPujyfxwzg/ubUNMTnIKkBRcERgfGVBnFIWV7qkzpHX4JoZ7LBf0vGwvIxRo7zoL1GBCeHQsgqaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMryAZtcBMwyMMmDu1Ks07AJACpM+6xyxz7l2/gLt+DhiiP6QS
	cH4qPlFglpSBZlznjrscPR5tYyuT+qR5o4WP5ndbTyKrBbfj16DLZttR9HLdANVyGnHxXhKAI0N
	7PDIk
X-Gm-Gg: AfdE7clPujGcN8YEZpsH7MJMNn8/s7dZXL/NdS6g858D7SKKbEAUmqi6WktVbvcygDK
	3YWJl5dA75QEWN9uZPlqTkx0wxopVNSlYlLxrTTl/LYHnjtj96zz/XOOdE4ZE5K5shqremobYJC
	b33lmkmBbmDEQXD61M8yp04trVQIdbDsQro/rD+m0UH7G3Heu3+UqUzb1y0hloau1RaDqytGyrz
	0dcxMqXTvYSyxgtS0Xw30DZss+HKYymawTOgz+uZomC1lf75C6vOl8IwhhvD9R/jCYl02nos3GV
	iQMsEHuDF+gy7y4CnxFT6R0f7bJJ0IZYd+Yo+PucBcePcbGD1gGsr5BNr+ZXEtJb2HJDIXafTT6
	+Ksm/ENCWBxeNYNRc9seZydRm+dLi+jQW2McEYH2QMBTyig/IMePfUP1KvdPIC7s7p5n+JzBdrv
	SOA+gAEL1GnUQkQFgRurFbng70J8e7AcgirT3ZDQCPgRxZ7xSYHhHrrGfb80Vsx2lxXcdXhiJPi
	+EJWA==
X-Received: by 2002:a05:6820:160f:b0:6a3:1b9a:48db with SMTP id 006d021491bc7-6a3556e518cmr736662eaf.52.1783353952162;
        Mon, 06 Jul 2026 09:05:52 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba4209sm1023460685a.12.2026.07.06.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:05:51 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] NFS/localio: issue IO inline when not in a memory-reclaim context
Date: Mon,  6 Jul 2026 12:05:47 -0400
Message-ID: <20260706160549.97580-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260706160549.97580-1-snitzer@kernel.org>
References: <20260706160549.97580-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23103-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 838C8714432

Every LOCALIO read and write is currently bounced through the dedicated
!WQ_MEM_RECLAIM nfslocaliod_workqueue.  That bounce is only actually
required when the submitting context is a memory-reclaim context: LOCALIO
issues IO directly into a stacked local filesystem (e.g. XFS) which may in
turn flush its own !WQ_MEM_RECLAIM workqueue.  Doing that from a
WQ_MEM_RECLAIM worker (most importantly writeback's wb_workfn on bdi_wq) or
an explicit PF_MEMALLOC reclaim task trips check_flush_dependency() and
risks a forward-progress deadlock, which is why commit b9f5dd57f4a5
("nfs/localio: use dedicated workqueues for filesystem read and write")
introduced the intermediate workqueue.

Outside of reclaim context -- ordinary application/task submission such as
O_DIRECT or fsync-driven writeback -- the workqueue hop buys nothing and
merely adds a context switch and scheduling latency per IO while discarding
the NFS client's inherent application-context parallelism.

Add current_is_workqueue_mem_reclaim(), which reports whether %current is a
WQ_MEM_RECLAIM worker using the same predicate check_flush_dependency()
warns on.  Use it, together with the PF_MEMALLOC check, in the new
nfs_local_defer_io() helper to decide per-IO whether nfs_local_do_read()
and nfs_local_do_write() must defer to nfslocaliod_workqueue or may issue
the IO inline.  Buffered writeback continues to bounce (wb_workfn is a
WQ_MEM_RECLAIM worker); O_DIRECT and app-context submission now run inline.

Running nfs_local_call_write() inline is safe: it already saves and
restores current->flags around the PF_LOCAL_THROTTLE|PF_MEMALLOC_NOIO it
sets and scopes the file opener's creds.  The async O_DIRECT completion
path is likewise unaffected: when the underlying filesystem returns
-EIOCBQUEUED, the kiocb ki_complete callback (nfs_local_read_aio_complete /
nfs_local_write_aio_complete) can run in bottom-half context and so must
still defer the pgio completion (nfs_local_pgio_release -> rpc_call_done) to
nfsiod_workqueue via nfs_local_pgio_aio_complete().  That completion hop is
independent of how the IO was submitted, and this change leaves it as-is;
only the submission side stops unconditionally hopping through
nfslocaliod_workqueue.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c          | 33 +++++++++++++++++++++++++++++++--
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 24 ++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index e55c5977fcc3..d3e480888eb1 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -699,6 +699,29 @@ static void nfs_local_call_read(struct work_struct *work)
 	}
 }
 
+/*
+ * Decide whether LOCALIO must defer submission to the dedicated
+ * !WQ_MEM_RECLAIM nfslocaliod_workqueue rather than issue the IO inline.
+ *
+ * LOCALIO issues IO directly into a stacked local filesystem (e.g. XFS),
+ * which may in turn flush its own !WQ_MEM_RECLAIM workqueue.  Doing so from a
+ * memory-reclaim context -- either a WQ_MEM_RECLAIM worker (most importantly
+ * writeback's wb_workfn running on bdi_wq) or an explicit reclaim task
+ * (PF_MEMALLOC) -- would trip check_flush_dependency() and risks a
+ * forward-progress deadlock; see commit b9f5dd57f4a5 ("nfs/localio: use
+ * dedicated workqueues for filesystem read and write").  In that case defer
+ * to nfslocaliod_workqueue.
+ *
+ * Otherwise (ordinary application/task context, e.g. O_DIRECT or fsync-driven
+ * submission) issue the IO inline: this preserves the NFS client's inherent
+ * application-context parallelism and avoids the per-IO workqueue hop.
+ */
+static inline bool nfs_local_defer_io(void)
+{
+	return (current->flags & PF_MEMALLOC) ||
+		current_is_workqueue_mem_reclaim();
+}
+
 static void nfs_local_do_read(struct nfs_local_kiocb *iocb,
 			      const struct rpc_call_ops *call_ops)
 {
@@ -711,7 +734,10 @@ static void nfs_local_do_read(struct nfs_local_kiocb *iocb,
 	hdr->res.eof = false;
 
 	INIT_WORK(&iocb->work, nfs_local_call_read);
-	queue_work(nfslocaliod_workqueue, &iocb->work);
+	if (nfs_local_defer_io())
+		queue_work(nfslocaliod_workqueue, &iocb->work);
+	else
+		nfs_local_call_read(&iocb->work);
 }
 
 static void
@@ -929,7 +955,10 @@ static void nfs_local_do_write(struct nfs_local_kiocb *iocb,
 	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
 
 	INIT_WORK(&iocb->work, nfs_local_call_write);
-	queue_work(nfslocaliod_workqueue, &iocb->work);
+	if (nfs_local_defer_io())
+		queue_work(nfslocaliod_workqueue, &iocb->work);
+	else
+		nfs_local_call_write(&iocb->work);
 }
 
 static struct nfs_local_kiocb *
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index bc1ccdfbfb1d..3d2e426bcf27 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -659,6 +659,7 @@ extern void workqueue_set_min_active(struct workqueue_struct *wq,
 				     int min_active);
 extern struct work_struct *current_work(void);
 extern bool current_is_workqueue_rescuer(void);
+extern bool current_is_workqueue_mem_reclaim(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 03d9588e16d7..4add75c621da 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6169,6 +6169,30 @@ bool current_is_workqueue_rescuer(void)
 	return worker && worker->rescue_wq;
 }
 
+/**
+ * current_is_workqueue_mem_reclaim - is %current a %WQ_MEM_RECLAIM worker?
+ *
+ * Determine whether %current is a workqueue worker executing on a workqueue
+ * created with %WQ_MEM_RECLAIM.  This mirrors the condition that
+ * check_flush_dependency() warns on: flushing (or otherwise waiting on) a
+ * !WQ_MEM_RECLAIM workqueue from such a context breaks the forward-progress
+ * guarantee and can deadlock.  Callers that may recurse into such a flush --
+ * e.g. NFS LOCALIO submitting into a stacked filesystem that flushes its own
+ * !WQ_MEM_RECLAIM workqueue -- can use this to decide whether they must defer
+ * the work to a !WQ_MEM_RECLAIM workqueue rather than run it inline.
+ *
+ * Return: %true if %current is a %WQ_MEM_RECLAIM worker.  %false otherwise.
+ */
+bool current_is_workqueue_mem_reclaim(void)
+{
+	struct worker *worker = current_wq_worker();
+
+	return worker &&
+		((worker->current_pwq->wq->flags &
+		  (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM);
+}
+EXPORT_SYMBOL_GPL(current_is_workqueue_mem_reclaim);
+
 /**
  * workqueue_congested - test whether a workqueue is congested
  * @cpu: CPU in question
-- 
2.44.0


