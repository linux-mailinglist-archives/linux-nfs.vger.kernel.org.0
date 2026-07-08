Return-Path: <linux-nfs+bounces-23162-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NO7HFAUBTmojBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23162-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 09:49:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C973722D28
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 09:49:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="MMx/J6Vh";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23162-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23162-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA1E30087BE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D83E169E;
	Wed,  8 Jul 2026 07:45:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D313ED5DB
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 07:44:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496703; cv=none; b=jCui8nVNqHBfFQRAQd/DVPpPRtY+0SwvPq2B5oSLOxiFg/eSUznmdNU+LKttCa4G+RuZFC7M5WPKcW8WTdJ5a025PLUIGJLr4M9fbjGlXh7Vx3neuAbX6VYx8Do7f+y7ayrdSf8hR/XEPfPzyw8RhM2ddAmBOj3zudOIZx8GrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496703; c=relaxed/simple;
	bh=LQ/dEUntNAi6A4i297iAqCAH3eW4im8cEOXclYrMnKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff1QcPuvyGCk8KeSt5MaoAhAYGuAB6NECuh6RIf8WDupYmLZh/ibsyPfuDyBH30oSLl7ca4mu//FkZiUqCmPxfq2F2fyh2uCqr1AE7rxwTsp5nsXDBp36AqbPtQ+Fn7rbmcWx9Xm7JFzDIGPUonCDlyqt/gLBFmEJIa8fiyMuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMx/J6Vh; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so3433825ad.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2026 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496694; x=1784101494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJdJ0m7Cc+Fwhhsv9XXuNhV7QMVj8eMr9JnM9lmqwEA=;
        b=MMx/J6VhOyh6VNt5FZoooNRtetZ7tOmsuWbR5SgsR+S4z2ixIgKyZFMtqII4lb2wze
         69MR5ia+MLFBOIrY1WRUeUGCWYG+iiTkiV1/fZTNIrCJ7WmS3Xr8phIvVQYjZfBgtF5f
         gjd+wn2SvxV2sxVTaLaG+vctPMFGkK14gMvlHkvrU/Kl7+8tiTcOWOwaPDlQn/RILLUL
         JCBQNHvgXWllcpaxx91nQlZDf9ptd7+aOA5/l9YwBUAFXZTtDcqGQ7APRIHn0VoAS2oJ
         b8mKHf6S+USReQFF4suECpGPkxmMZTdbAybzEIzjrYci/J7k0gc8+1N4olVnOrKkmv8r
         CoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496694; x=1784101494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJdJ0m7Cc+Fwhhsv9XXuNhV7QMVj8eMr9JnM9lmqwEA=;
        b=VotUroY8WB+2oJwA+/XfB/j8OvXkyRm/wzStsH3m6DUjSqynP2IPzDajU5kUdav6mn
         0n4Vd69Y+VLT9r2r6FxiUWqSE4y9AhiIJcl7UpqgnGpYbIBxggHGveg70OzcMt+RelrY
         F4kRiKHd5WXHEhR0gYf+H6DYfd2cgZ3F0qAVxiaEADNJeTy5t/B6ZB7y5i5Ao0+fDy//
         hL6ETshSpXyTrQb6pFNFJITQCkvlf8iz9ySkFRguSxITxMIz8QHPxg8BQgH9MxHWeCCN
         maWGZU78WwYSt827ofLMNIJSWI77ZBtyFNIccNxUrT3HFm6hPHOo4Fv2YrV8/6arAso+
         DWfg==
X-Gm-Message-State: AOJu0Yy6fJPKxzZsfXgkiAzIcIL6hybYgdLNDLSI1MqufOvv3JBonVzq
	dtj/1FmHgj6lzRI/WC+ivavIQJZBfG4F1Q4LFo1ltsdDO3NNzlhxWszk
X-Gm-Gg: AfdE7ckHhqGvH4zAV1esJNrcNiRGKh1GuzzReJUOLOlXdNPSxAWMif9nOWsH2IW8oXk
	HrJQeLeVFvdA6cGH+poR3GO2hhKZ9OQxuVnUfMxgZJR4iH27qYkMDFUoP0NbvhqIBCZ+O5vq5x3
	zAR0ROUjD0hJjfMijqmF7vrXK7HqF66rH2aDc3/Jse/Gz7jbr/LvJlJAF3dYK/foBilxnnmGumM
	CzL653nAGw1Z+1N5ZOl0+qauKkY738MX59/h1Cj0dRbAF+23UpQVCBdveiSIJR5jXmmmqrncGfi
	Y0rXw8Q7BFbBO8oH2Y04F3lSXxUW4UdSA3UmfuKSHOk89auowD7k1O91Bjgp0EcYXBsIb9m9jsE
	Ktlh0kYnVsu5/fJqYzusi0rYdDYNFHbxc/JBUn2D7eypLQMQEc9FAvRjwzkDm5xlLZyag3gkDeo
	8ed4ixdAN/b566+5yMbdV6
X-Received: by 2002:a17:902:f689:b0:2cc:9773:1313 with SMTP id d9443c01a7336-2ccea394249mr14421705ad.11.1783496693778;
        Wed, 08 Jul 2026 00:44:53 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm23932035ad.31.2026.07.08.00.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:44:53 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	hui81.qi@samsung.com,
	j-young.choi@samsung.com,
	peng.yun@samsung.com,
	qian01.li@samsung.com,
	xing1.he@samsung.com,
	jeuk20.kim@samsung.com
Subject: [PATCH 1/2] NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers
Date: Wed,  8 Jul 2026 16:44:32 +0900
Message-ID: <20260708074433.390161-2-jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708074433.390161-1-jeuk20.kim@samsung.com>
References: <20260708074433.390161-1-jeuk20.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-23162-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tigran.mkrtchyan@desy.de,m:hui81.qi@samsung.com,m:j-young.choi@samsung.com,m:peng.yun@samsung.com,m:qian01.li@samsung.com,m:xing1.he@samsung.com,m:jeuk20.kim@samsung.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jeuk20kim@gmail.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jeuk20kim@gmail.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,samsung.com:mid,samsung.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C973722D28

flexfiles accepts NFSv4.0 data servers, but two NFSv4 code paths assume
the data server client has a session. Unlike NFSv4.1+, an NFSv4.0 client
has no session (clp->cl_session is NULL; it uses clp->cl_slot_tbl), so
I/O to a v4.0 flexfiles DS oopses:

  - nfs4_init_ds_session() dereferences clp->cl_session->session_state
    while seeding the DS lease. It also only seeds cl_lease_time when
    NFS4_SESSION_INITING is set; without a session that never happens, so
    cl_lease_time stays 0 and nfs4_renew_state() busy-loops, requeuing
    every 5 seconds. Seed the lease whenever there is no session and
    return before touching session state.

  - ff_layout_async_handle_error_v4() dereferences
    clp->cl_session->fc_slot_table on every DS I/O error. Fall back to the
    v4.0 transport slot table (clp->cl_slot_tbl) when there is no session.

Fixes: a7878ca14008 ("nfs: flexfilelayout: remove v3-only data server limitation")
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |  3 ++-
 fs/nfs/nfs4session.c                   | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index c4aa995026f6..ef26fcab9c10 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1322,7 +1322,8 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 	struct pnfs_layout_hdr *lo = lseg->pls_layout;
 	struct inode *inode = lo->plh_inode;
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, dss_id);
-	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
+	struct nfs4_slot_table *tbl = nfs4_has_session(clp) ?
+		&clp->cl_session->fc_slot_table : clp->cl_slot_tbl;
 
 	switch (op_status) {
 	case NFS4_OK:
diff --git a/fs/nfs/nfs4session.c b/fs/nfs/nfs4session.c
index 5c128957a0a4..993f0db7cf5e 100644
--- a/fs/nfs/nfs4session.c
+++ b/fs/nfs/nfs4session.c
@@ -632,16 +632,22 @@ int nfs4_init_ds_session(struct nfs_client *clp, unsigned long lease_time)
 	int ret;
 
 	spin_lock(&clp->cl_lock);
-	if (test_and_clear_bit(NFS4_SESSION_INITING, &session->session_state)) {
-		/*
-		 * Do not set NFS_CS_CHECK_LEASE_TIME instead set the
-		 * DS lease to be equal to the MDS lease.
-		 */
+	/*
+	 * Do not set NFS_CS_CHECK_LEASE_TIME instead set the
+	 * DS lease to be equal to the MDS lease.
+	 *
+	 * A v4.0 DS has no session, so seed the lease every time.
+	 */
+	if (!session ||
+	    test_and_clear_bit(NFS4_SESSION_INITING, &session->session_state)) {
 		clp->cl_lease_time = lease_time;
 		clp->cl_last_renewal = jiffies;
 	}
 	spin_unlock(&clp->cl_lock);
 
+	if (!session)
+		return 0;
+
 	ret = nfs41_check_session_ready(clp);
 	if (ret)
 		return ret;
-- 
2.43.0


