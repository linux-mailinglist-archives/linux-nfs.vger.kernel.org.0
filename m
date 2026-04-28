Return-Path: <linux-nfs+bounces-21230-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMeUKH9f8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21230-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:19:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A000147EABF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD67330612F0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025463C3443;
	Tue, 28 Apr 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCDdEYmo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC43AC0F5;
	Tue, 28 Apr 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360304; cv=none; b=McPsfo6v5XCAoU+g1ulQGbb5vGKOlkQozn7xfF+/urniVM4UUZF43S09vdSwczitmgF8migYZAqhOYcUXin920AEkIm6CT9rbWjDUMu5Qclos249O6n/P0Cep3ALgB6MWs+8L3nAkUuzhxIqZTjXz7zdGuaRxRUa9l1it+OP8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360304; c=relaxed/simple;
	bh=PbrSbsGDzBILK48DxjomAYyp/zp1sNlXie6EEkLW5gU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkFttJzkZjB6OJc21LujDWP3RD7U9xJEyCwypgh8OTDZiqXcj3LOSQX//PolBNrm3//ty8hzM3s6Lk4UJtcqeBw2mXm2qXeQ3TSWFMHWCHzD7YV0Eb/IYew6BEDGSjd01Pw9/rvLYhIyf0h4JUou5HAL7YpFM+/2innb0dIcyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCDdEYmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D8CC2BCB6;
	Tue, 28 Apr 2026 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360304;
	bh=PbrSbsGDzBILK48DxjomAYyp/zp1sNlXie6EEkLW5gU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mCDdEYmoh3j+8ogRcEtMqVt8hNrZniK/TyhuRdKAK7ravoJFjYAygJGz1n3CENdX/
	 nRf1uN+ZoskjAqTnJLCIusUWkgzi2ik+EJsV3CGVu3JsHaHdYFacuSONjBDxYmRCrJ
	 X2KaqjT24CvKgrKoGtWhPcof699A6ORdm/50dJW2INyfUW80FmWZou/aPY+Fv6oU/6
	 bvlrlMiawCc9Pwr72fCN+92vGaYLkhZzv+EQw24fVK++p+ZNwYMdyzz8ytMDT7vrEx
	 uWm7xYTDNAoeay5TT0dov8uAFFYoT9illb4KYwUQNmwscdjQgIAIIztb/XU6y+w041
	 jNdVR96Mtmt3w==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:10:02 +0100
Subject: [PATCH v3 18/28] nfsd: add tracepoint to dir_event handler
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-18-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
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
 h=from:subject:message-id; bh=PbrSbsGDzBILK48DxjomAYyp/zp1sNlXie6EEkLW5gU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1S5lm/Zy5ablNM/wbgAJGSpljpuzYaUsAcq
 6aob0spJIyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUgAKCRAADmhBGVaC
 FXlvEADIjxo5rAg9wcEBnJtkn3ArC/GIL9FcB3U46u0IFp6PY79oIeNGUqGYDb0P26Tn/j0UQwz
 FCdVEdKMdC9OULR47Kw0F91nAwdG2c1QNKoFkZItnHSIk9VJUowvn+5IH1X/U5TPvfGEV2arBQF
 kY0gudx/2Co4y80RlkRY+TesSbUfiphdCKfTPzG+cpdG+VuYGE4m7DyKqeOy3GSGVb8b/feb6WU
 CjDLya8YhRKcEMuI2l9w4ADaSBZB1xsN/x86KL/dUGaYKy+E5X1HPCow0vbqFErJXGuiFNSPati
 8N4n+D/Dz08YF3gcAT7sAX/Ket+P3S1iOzj6coPqljA3bO4xuKJcVJopyNsZOQBCyZnLhjeSMwk
 rme3Xd0DgS+7WaHARvxG7XadRqwA5aIoig39jeEqN1qXb7EgcqYOMNtHpWG3kseF1ITQcBc+HFX
 bZPXYgwe6LGnxdV+nW2B7DWSHzYqh2zhHTfusq6V/xOsP9+PamuV9uf3DcKkggEgQYVS62DCGvf
 gshEoaKbb2yqdKq+ddALaXVu/5EoXTCtTMAm4fk8wjF1cXTNw01OZOR5fOzysqZeVhsSpKqwB6/
 veSigUVmoPbaP0ibxK7HGVmO1UUSJ/i7bEfJXyryV7GUAF7FUE4RdymslBPo6pPi3PuooN7lEZg
 H80mDR+knBlOk8A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: A000147EABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21230-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add some extra visibility around the fsnotify handlers.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.h     | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2b711443281e..f00aba95753c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9996,6 +9996,8 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
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
2.54.0


