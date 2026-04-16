Return-Path: <linux-nfs+bounces-20878-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JljOgwe4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20878-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:36:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC6E412DB1
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B161330227E1
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E0366806;
	Thu, 16 Apr 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK1C1xFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6F33B97A;
	Thu, 16 Apr 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360942; cv=none; b=oDXSamsmejLzzDh+aBpQA9Uk+2FmEs6NIAnFfcrwVEygccsHDHQvLz4+dkcuAaL4/O1FdOPFU/oO7e65pLGk1tGCd82duQsPp4vXIpo/k8N6rFyoNA8YcRpyp3DdtVo4yCuF55/ZGOyy9/R8cD56k1Efa5fcdxMemI28lOBGbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360942; c=relaxed/simple;
	bh=QYnTQk4yeAHXc+6yMFnWPX8zgPoiv5NdKWBT0A6sQOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZI9WU0beypkduusEF+h71bkJID7P5dhWOe0PVjVdJ7S5QvxgWOl0NWZU6IYuVIUXXNrDEAt2bfAgKRS9gBaGRc5/LbMnghI/5Q/E/y7S/l3Zi7KKXcG4145K+Q/KaWIrSIExrrk+h969lq/NIPNPkThriBibydleQM3nXpUH12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK1C1xFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E01C2BCC6;
	Thu, 16 Apr 2026 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360942;
	bh=QYnTQk4yeAHXc+6yMFnWPX8zgPoiv5NdKWBT0A6sQOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KK1C1xFDFVfxhthGtdt04dTxbQLSwZjuz81cWkz5UdOhXQqKwqR0t87P81DtaVnYk
	 66Bvh5BYw4c6nyZ5dRFEgCFWgv7Ml/u3nHjGbhzzUsZDcmvuGIxvLHqxiCPO67o/58
	 VINpCqwl4YFPQSC5FA3FjQWKG70rQzMjeTnr7fH2mr3Lu5Y7+5E+jAWoQdB7qgUZga
	 2AiI5+JrtPe24LGE360HDSbAKFaELfrTcrA0SMq+QYAKBUaXmlBtz76h55DlaY4NRC
	 a7lUEleO3IerkfnBtrdZRMbXj1lRqJ5vDfxVZMecmE6RVPrjOHkeHpCKBBgXzIT8nR
	 sWRA2FM58AZqg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:07 -0700
Subject: [PATCH v2 06/28] fsnotify: add fsnotify_modify_mark_mask()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-6-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QYnTQk4yeAHXc+6yMFnWPX8zgPoiv5NdKWBT0A6sQOA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3ihTEuKBrx6WNpP3fQWXnzu0yHuC/VFlE/O
 cKT03kNObGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4gAKCRAADmhBGVaC
 FTS/D/95o0I08Ue8Lw7PdFJMjiMu1Acf31Ou3RkhXPUyV58k0YSaHBS1o2mtgx7Chss4xv604jK
 YavPerg6aIxMPEtGXG73k61H8I6Y8REvKjpPDQWGFRyudfkceBP4OBwpEGyoWG2JX2xGt+hvf13
 U+eRv2VHg+kRKUnP/pykkOOhjoeLb3UdAVGtCM9krsNKW06xtJZhCEUen+6N08EKO2bHt3VxLVi
 frGOsocZRzJVd8U665c97WWtZ1OogQOX29vAvAXRUELIcd127BXsX66/l57yD2oF/O3lVlg3ju7
 tyakBsWZMgNwJ6rA8RTBcxt5qMbF34Ti2i9TO6klBthOo27/WVcQghvFN49aQ1HExmvK4JnApQ1
 UCjm02sGz4rV7533REzVUzH39owKCyENr8JTJo9yHEUWDvzO7Y1oDLMcgPA5383T00ZWsmsmcFy
 gMcDO6aTnbKZTuDExGqHQgh+b0BU8lIafN9OxtK5IS9Txt4qx19WTBU6+mBV/pCmCsT03Njid20
 qsyHs8SFJ+BtBjErV73hymS/qptKVfCe6yHO1VedI0s/LawDgeYbdzFPNxs8OWaJCEUZW/ZQf5s
 KnAdjZbXSebDtY1t8VbfF8ixsn7GsOeBG6RfpDaz0JVdLBgS+mnwOEM2+hg6BgLC/H0Df6+c/xy
 JBmPI3g2/8G9aUA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20878-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 9DC6E412DB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd needs to be able to modify the mask on an existing mark when new
directory delegations are set or unset. Add an exported function that
allows the caller to set and clear bits in the mark->mask, and does
the recalculation if something changed.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/notify/mark.c                 | 29 +++++++++++++++++++++++++++++
 include/linux/fsnotify_backend.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c2ed5b11b0fe..b1e73c6fd382 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -310,6 +310,35 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
+/**
+ * fsnotify_modify_mark_mask - set and/or clear flags in a mark's mask
+ * @mark: mark to be modified
+ * @set: bits to be set in mask
+ * @clear: bits to be cleared in mask
+ *
+ * Modify a fsnotify_mark mask as directed, and update its associated conn.
+ * The caller is expected to hold a reference to the mark.
+ */
+void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
+{
+	bool recalc = false;
+	u32 mask;
+
+	WARN_ON_ONCE(clear & set);
+
+	spin_lock(&mark->lock);
+	mask = mark->mask;
+	mark->mask |= set;
+	mark->mask &= ~clear;
+	if (mark->mask != mask)
+		recalc = true;
+	spin_unlock(&mark->lock);
+
+	if (recalc)
+		fsnotify_recalc_mask(mark->connector);
+}
+EXPORT_SYMBOL_GPL(fsnotify_modify_mark_mask);
+
 /* Free all connectors queued for freeing once SRCU period ends */
 static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 95985400d3d8..66e185bd1b1b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -917,6 +917,7 @@ extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
+extern void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear);
 
 static inline void fsnotify_init_event(struct fsnotify_event *event)
 {

-- 
2.53.0


