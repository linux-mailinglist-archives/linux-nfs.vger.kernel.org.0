Return-Path: <linux-nfs+bounces-20890-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDo/NA0h4WmapQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20890-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:49:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA42F413477
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAF9830FD8AE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66A3E5599;
	Thu, 16 Apr 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB3+94mJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF63E557A;
	Thu, 16 Apr 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360952; cv=none; b=TChMVJU43Hr7NMYsrG/ZjMcKJNrKdPxizMSt6MKTHU43y9HbkYu7UvQSV4nPxn+2gjs8h4MCOXNikZ0DtTrtHvOcA42BGSl6ZcVUDWmlDX0cGUpgXIpYnbBFYgR+gC0gxx5D+I+jyuIxooKmGK9T71Gm6QUgzQxMn+RoHqVhmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360952; c=relaxed/simple;
	bh=mM6Q+CFzomu9wRc4F8gC1OVwVa/b0/30OWI+ofx9eGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Um6hJVEZiVfpO9XG2cpR5CV51H/Go1ZGj3wGo+plDyvjnqqifzAw5OXeQg00M21jDyWu/n0Mt96q2Zu97JXt4kmhV+9ZIRhaWRNQyJTRF5qocK6bcBNPZOVxU5RoCsITc/dIu4p5BcZV6arblQ3dPH2wiHghd6p++xIYQ5Wgmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB3+94mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6D8C2BCB5;
	Thu, 16 Apr 2026 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360952;
	bh=mM6Q+CFzomu9wRc4F8gC1OVwVa/b0/30OWI+ofx9eGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NB3+94mJlNEmUib9JIMANr+fqOJnpKLM45sfDRnoNb3JFP80JEsGFakkN/ecZeh9z
	 mjP/SH15M18nMTjw3/NJKtPXjvF8zdUYubmKie95kB6VJv73xsGETvN+0N3UeVImM2
	 We1uC9wxra/u+47GdhMBsZIYTZyHL+Wg9lZY7XiNa2qECAR1llZ0VYXvH991xwBLs9
	 8a2nSteHXBGovzkm6WzN4wernxj2tH04EjbZaKKH0mJJ94S777bgOH2lqzuxwKxEes
	 e6BHn3jndMjHICBCLIdSpuo1xFewRmxfukRuAAKMaNbN9za+LXVbO37yGmeeEq1w+K
	 hCpybMhewAhmQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:19 -0700
Subject: [PATCH v2 18/28] nfsd: add tracepoint to dir_event handler
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-18-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mM6Q+CFzomu9wRc4F8gC1OVwVa/b0/30OWI+ofx9eGs=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGnhHeagZg/j66Nm0reQL3vFTIff90GlFS9fJZFD7JKVCU5Tp
 IkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJp4R3mAAoJEAAOaEEZVoIVbmwQAIr9
 c3JEz4qGZn3cW03fQyr6wP7A/mh4axVGypgUMFerUCl1DZ8ABHciwXjYOksT9uhFqJX4k4x3MQe
 vUOaM/OLrM5+jS9r7cPhZ8uFwguNEhermoOEFYGIoxjsholeKzCfWcSFNek/8x8N6nn9SVFKNqo
 0sbRPCeZ4FHDRxAlVgt6drOsT/CIQkUZCZpiFpx2Z0+Kl9GqrMyROgQH3k7wDDdOFWMMo4s/7fp
 +FC+SCBZGQ/y32SHQ7FgEPMYfjWIZUsbgQ+7ML+o6BKV/Ww3r4g/Ka8Bbc537bCs7dCaUczS5kN
 /RCuNoySlbIsDhCDyYg+7e1COppfvhkhoRvtX2epR0V8sCZmPx7m7x8ZvusFCcbNiX6ZMxeMgqY
 eQADms0BpHfw58MDKY+Jky4erP55/dcjO6CccFp7AEb/mO66mO7kLesWEqw82gomuOWeAqXnj40
 i9PryqUyTvhVMXG6r8ux/QfqNgMirL0KXFH+owmxVyzArVWLJo0ZgLF03RNNF1pg65N0ti7Ug90
 zT3ZlXQSbFplZdvpai7nevkINpq2QnispMekxX762tLOqzT8eovWHhNDmSLPhODKeqXbgUB3bE/
 vMvOks850/34P1DLc10I4DJb//6POrcWf+Aqj2x2Egt1UmM9m0Ofh8QMT8DaJm+5R1rh0sQVDs7
 p9y0V
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20890-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: CA42F413477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add some extra visibility around the fsnotify handlers.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.h     | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f4d0e64be544..eba6da1072c0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9995,6 +9995,8 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 	struct file_lock_core *flc;
 	struct nfsd_notify_event *evt;
 
+	trace_nfsd_handle_dir_event(mask, dir, name);
+
 	/* Normalize cross-dir rename events to create/delete */
 	if (mask & FS_MOVED_FROM) {
 		mask &= ~FS_MOVED_FROM;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 60cacf64181c..b9119ff4253a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -12,6 +12,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
 #include <trace/misc/fs.h>
+#include <trace/misc/fsnotify.h>
 #include <trace/misc/nfs.h>
 #include <trace/misc/sunrpc.h>
 
@@ -1377,6 +1378,27 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 
+TRACE_EVENT(nfsd_handle_dir_event,
+	TP_PROTO(u32 mask, const struct inode *dir, const struct qstr *name),
+	TP_ARGS(mask, dir, name),
+	TP_STRUCT__entry(
+		__field(u32, mask)
+		__field(dev_t, s_dev)
+		__field(ino_t, i_ino)
+		__string_len(name, name->name, name->len)
+	),
+	TP_fast_assign(
+		__entry->mask = mask;
+		__entry->s_dev = dir->i_sb->s_dev;
+		__entry->i_ino = dir->i_ino;
+		__assign_str(name);
+	),
+	TP_printk("inode=0x%x:0x%x:0x%lx mask=%s name=%s",
+			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+			__entry->i_ino, show_fsnotify_mask(__entry->mask),
+			__get_str(name))
+);
+
 DECLARE_EVENT_CLASS(nfsd_file_gc_class,
 	TP_PROTO(
 		const struct nfsd_file *nf

-- 
2.53.0


