Return-Path: <linux-nfs+bounces-21792-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FEuMIlREGrgWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21792-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:52:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4CA5B485E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A182308A755
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C623A1E96;
	Fri, 22 May 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzicd/NG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBA3A0E8E;
	Fri, 22 May 2026 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452969; cv=none; b=hZR9ZIvMR/Z6TyyZBRomEx9r9d6/tbkUTF0jh6YbDWJMYpbm/z13uXFI7l5L71bYT5KR/2/GI7rIbhCo1pJrVdIit6O9fnyF0j9lfXMby0SmGOsXWMML62P0ars02xrUr4dN30vW73IfulVVbSEUAekYY9GDQnMy9VOZAeKKWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452969; c=relaxed/simple;
	bh=mEnEGZv6+uKTOIKyYYSMR0uBJ9dj3FwKNsNHskjqYZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KB2cZ0yrD5sA/S4zls9FVvWZRtzXtDMYKCjXuJ+cnF2uRdcXXnR/bBzoeaN9Fpxbh1wRIewxHmDW/ecgV89vKuSJvnruL2AUBkaph6jfuaOUjkp+sSxsVTHu+YT8/APLUyF7sTik59W4tRdRPTxw3zgdXcy7I/GUJ8RjmTB8VaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzicd/NG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6861F00A3D;
	Fri, 22 May 2026 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452968;
	bh=8l0fFOViIZQZ408K3lRV+hJ1K9YMUbyGPRzWx26nrTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dzicd/NGO15PRO/tBDi48FkmR7Sfy0r2qCXB4yQWxfeaUnsAVnNgsqXGiYjKZTKVj
	 CzPtFdnwlm0M4hJlV/JlmLhlly9x7E4EmF/wPWwitonSN9urofy1SXwNGYoSLYdeMp
	 aGADFGt5jAK8G6BHDNon8gOc4bsFgPvWWqXmWq4FGx7xY7d14JgW31tN+Fh8jjhItN
	 LTc/T5jLJ6weBU/fR31DI6u4P19v8HNQsVz2vmVarvFD/a5U3lp6Fmrw4IFfhacL/Q
	 Y6XhEdyR8bC6q5t10/q5PqX5PnBgun/kz9Zx03wJkAcopUlxLF3mnWptut35t5iG5v
	 iuDZTuW3QwBDw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:00 -0400
Subject: [PATCH v4 11/21] nfsd: add tracepoint to dir_event handler
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-11-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, 
 "Steven Rostedt (Google)" <rostedt@goodmis.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mEnEGZv6+uKTOIKyYYSMR0uBJ9dj3FwKNsNHskjqYZc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwQQf7iyMobO4tXmgQFWRcrIkwm3g3rf9q/a
 3SMHPkE9JaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEAAKCRAADmhBGVaC
 FaYBD/0f5ueCiWM6knSK1JWo1XquINhmtbzGj3nkxnrSEkxMuHeUSPrrkTTfnRhBn/O8xCIxBpT
 DQYm4MIIEEcHvJle3+xwpXaN0IKEyaTjYirzxz0NpDJr7AbEEhc54ytunDnI2/hcTo4gyD6uRvM
 v8iSs3mHdPlFxofUUzpbtiG2tSV3KE1oPfl+rHQBZoVIlgmbjJwhthTq2tYvmdV6xLA4YAXFroD
 B+1JPiUJTljPrmxW7jSI4YK6wsE7FAnJdQlhTSEuC7fU+eQFxssKDM5ykhdfir+xw+JzgBoQ/SY
 MPWX0jC0PBQl+MirrvOLjW3SGAGfM27yqtcm+giu9s3JOtxMb/lsQjb+HVHk91YpczS92gE1/36
 rpwbjYbfY5u5jN24pgN0H3Epdv8B5YTroMzuiijkQHLLR83HyQczvERGOSPZiDhm10J8HSjBCdw
 n/3/I2CfBAb16/QxEK9W1ssyWshe+X/d9Rf5ipFXmDIExk1AbiPzNgnZzFk28mTILSNW2DLzpj/
 p4EqVqwA7LQciH1PlGfKlLNBwoXxTY4lVbkPxWWCuYw/Anv6UCT5GnrRRZJYJ9vOmIB15+TRagh
 adzA2ppvt5oSzDT9r1MyAmsTa37IBytRv6Rbz0RVwEyemJudsPkCE7p3yid6uk4bn6jytFYeuRp
 IDLkz21aiYzEsBQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21792-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org,goodmis.org];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,goodmis.org:email]
X-Rspamd-Queue-Id: CF4CA5B485E
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
index 3afde2e91efe..8d73203297e5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -10032,6 +10032,8 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 	struct file_lock_core *flc;
 	struct nfsd_notify_event *evt;
 
+	trace_nfsd_handle_dir_event(mask, dir, name);
+
 	/* Normalize cross-dir rename events to create/delete */
 	if (mask & FS_MOVED_FROM) {
 		mask &= ~FS_MOVED_FROM;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ebf5677c4e73..e8e121a52e82 100644
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


