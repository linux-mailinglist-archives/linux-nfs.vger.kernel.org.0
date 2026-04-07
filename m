Return-Path: <linux-nfs+bounces-20694-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIPHKHIF1WmczgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20694-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB3D3AEFB3
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EDF7302DE2F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2D3B8959;
	Tue,  7 Apr 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/fmlD77"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550D3B8934;
	Tue,  7 Apr 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568158; cv=none; b=i5gjeZkqo7zDfbP6f7LtoJe9qPvYzufWIYUCKxiY52+HHUrvdn0ybDrkddmiBE2XhDBpNH7D4Uy+2rbRxYcZCNaAx1DSdNj6Jor7L68r1zS1XzGlwWKdSce8E+3OsAgssJsgTveoI3RINYhb4KL6O2kyeDJ8LOOPh68BnH5PHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568158; c=relaxed/simple;
	bh=G2sTjncD1ODMIjiC0sw7aDKsTC8PNpiHd3OAW/OSY74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVvbMUmjfPyPT1cnyMrvOSx/rZXeum1hHF2FwgZDMheSOG+lWwza1GkQiBHze9hTllIEMyACdC/P1tUk89JRWDRtvz6E45PE8+TgTH1xagU5Ya5F7mtEO85qT+uMfO8T/ZXADkgKnQiXOsta/it8zS2lpo6j2lVAPrPgAubX4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/fmlD77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B10DC19424;
	Tue,  7 Apr 2026 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568158;
	bh=G2sTjncD1ODMIjiC0sw7aDKsTC8PNpiHd3OAW/OSY74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d/fmlD77hj6y3CQdcRftrUOI6UQG+8/aYiJTB50kcSEAx3lKMiEhBHMnC3tzYrdxQ
	 5//zqJGsKu+pGO4kPcVmm1XI0GAdNvl5QdUvmtpRBa2npsTcWKzZaXQ7rbQMuweRgh
	 stBbcRCch0emVsSqOlQ2z8dcsToN69M2BJGpDlW0XhQsegfzYxiFqDcMzo1mfOiXSV
	 Ra2CeLi46C7+KW1N/YciPVi9DlrDFJ+0nOFEc3mQtTSpSBAhV0jMIiNcF78O0InRZd
	 E4NK2uvY2W1so/Gj9BLg+lcKatIqmKoNfemElI1aRwN2MXI2xr0R28w8lEi2iqRFrS
	 4HTypqhHsfp3g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:20 -0400
Subject: [PATCH 07/24] vfs: add fsnotify_modify_mark_mask()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-7-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=G2sTjncD1ODMIjiC0sw7aDKsTC8PNpiHd3OAW/OSY74=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUFkHA83FdGD+wNMWjDEyVzpvMG34AkOQlK4
 SqWFNP00gSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFBQAKCRAADmhBGVaC
 FcZgEACjYLp79flnHlsvY6rgaXwBjFHjIZSar9TTiUE6odY31z3RM7LSYdNzelfPvyvbB0fcVMx
 f7rJ5VRsYT0UXiSzdSIN5y5qqnNHyq6rLyJ8E2YoPEjDRVftfReQ55ZlfaFZAmOkF+/iggphe8B
 xyLuqfNlG7O/vXU7MI/CyNmpqNaCPWQP4I4JUyi1nMJ5pZ3RBYzTpghxsHRJ+RbqhGfDZhsEQ/W
 N+Ad4U28AfDWQoU25q5aWH/ZmXZA2GDxYabrW9eIwZeLce6GDyKIRH7s28DSVzSxZJgqMNGcKVb
 e/QqKYwxadhn9FOM1lp2eyRIQnEL+n2I2X4j3MleJqG/fW9jKqHEDBX1Syk3Zttyo5iw+av0KML
 mdbEin5C4BpaGnM6vG2tb6nZw5VgRHMm1/fYlycUA0NbY6pAmipGAC2vLA/kT+H2x/FdK2hbZ4+
 QNcwb1KNdfn4QOH7gm/Y1U6qGGZqvd4fS/6rh3/LmwhUz1bQ6HLa772v6ogJO0vuYdaYjvwmpN1
 D5J4RPnvHxWRkM4vPEjfTzjYyxkmTRDV4V0qqo3f+U72qlyuma0ou2RsQ0/gJPIAsj2iv0rnlMX
 6T3XyGUqHe0qn34TKY1xaCgcCKOWEYFxzBe2FRo3S8GZqOIvSnwm1+GpL8qfBg/hRWxaTsi4ak1
 rz444NJ9RaurFUA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20694-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAB3D3AEFB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd needs to be able to modify the mask on an existing mark when new
directory delegations are set or unset. Add an exported function that
allows the caller to set and clear bits in the mark->mask, and does
the recalculation if something changed.

Suggested-by: Jan Kara <jack@suse.cz>
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


