Return-Path: <linux-nfs+bounces-21218-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGe6Lvhd8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21218-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:12:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8103C47E899
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07D953058307
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6E3AC0CB;
	Tue, 28 Apr 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlRGaUb9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F204964F;
	Tue, 28 Apr 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360247; cv=none; b=twZufm9gFR41LAph24qziayVs+53ceR7REIZbhHApO0v1yCju38u7VpDmCEqRgTzHJaeOddZn1N0CNGh/y/zckI9upnLDBY1w27WSW/HGxGjV7tEkYAjfKdonP/Th+kELArktcZlLg69DKlg79iCzsIUxNdAUVL72HtQiGi4IJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360247; c=relaxed/simple;
	bh=qXmxSNyMZVfebhWWPohdwpJs8hscP/x2dW7xOYsk7FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRUwHNyNU+I6ZbpAJDpzHwYnO3J3O3Qq6MgKgMpC3hWThkj6wye3A2DPINcMnwYc/Qjb+0Qopya37U9tF1Ncxsi1gUTzf83635KbJnYKBkhcOIEcwMQ8QlL/p/TpFq73ap8N2W/jIELBSl5i8WcF1sS46MUt3R61niKr6aHpIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlRGaUb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F78C2BCB8;
	Tue, 28 Apr 2026 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360246;
	bh=qXmxSNyMZVfebhWWPohdwpJs8hscP/x2dW7xOYsk7FI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FlRGaUb92lb2xmiWM3umFl0dFOqupPz8lkhAm5O7eiW/WXl0FuPLkk+2uAdM5GkX+
	 rKtc/gXTNZmORhhKxnxv1Y1dBDZCULFhMOhDXwxpMdFkQuu1PotaBj9CSqB6msoo+Z
	 crYtp7qvvFHuG/hFfhpr7zsufRRk6uNTpcs6GtuFsFPMSlsNBSqOXrhweXL8oyQM7J
	 UBU0Zwk2KoT5kB5Y+JkhdzXIgSVJ0QtcMI5WXJm2lnXBnk8ejWH1aKMlEqcj2mSuH/
	 nqzo8XnhROhbikckRsFy7bImhuiukoV393s2rrY4KRKCuJ+0BQPxrPd9LS/inhsWDW
	 sxpQeuDXBoM4g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:50 +0100
Subject: [PATCH v3 06/28] fsnotify: add fsnotify_modify_mark_mask()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-6-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qXmxSNyMZVfebhWWPohdwpJs8hscP/x2dW7xOYsk7FI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1O2z/3ZM3yxpTY2Zx/Ed5wY2NxZElbjAyvK
 lHoenFQfFGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdTgAKCRAADmhBGVaC
 FXOWD/9/CS7Fqv+If3CgI4XRCQ1EEw7YtkSM8QXLufT/JKhDu+whFFgdSOcJK8E9WfcPfaDjODi
 AcvaDIGdoUuhSY/coSuZQ+eV/GRmq/hnOdS0Q3J35wGLcG60KpYuHttfRarHZXuMixorhK0LkAz
 3+MRiZwTyEaQy6s1Q6LC5ibIJ2hR2SAwYSTdrAh/Pe0u4uvA8GdBEWdlePjNH3Bz1PH4478KNea
 kcFuNmUQ9Ycd/bjZPRj1b3IlZTiy4Jr3PTPNFd5vgFZCqN5EBkVsEuU8rK6DICPOBDdlYFfgel1
 XbQAWcSYDqOWPGKrCsmQTKCGJprlsaQInFCglI60dYc6HtGhmAStMvtFHmTQoND3bF1mCCq6Eep
 pLKvlj7qs3uFBnVXDh1ciac4OKH+d3dSOUn4O80ucwlMOok7Dg56FDJvhv8bXrcXx3c85tXQ/jU
 JpJvxjmZ+ZCLf/uIdHvUZ1KVzHePrX1BGz1pPHX95TPdC//UI0HDM0Z/8HRXEiv7xuqytxYhtLj
 Jc3WiK0K6HNk6JIVxmDhnyLHjZsKhoAcFeQ3kBCibY5J/GNcntWsNQI5hyVjfHuwFUJowt1tLIL
 HwZJRtwgsMb+pmsQO/IwiQ8BfExIGRd7S7cpuP8ZDZtsp1nSSPKrRSl2KhSGmtSMnOPCUuZIdRB
 Y8WppMwwTCeWEQg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 8103C47E899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21218-lists,linux-nfs=lfdr.de];
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
2.54.0


