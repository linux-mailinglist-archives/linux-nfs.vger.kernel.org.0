Return-Path: <linux-nfs+bounces-20948-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFhFORKo5GncXwEAu9opvQ
	(envelope-from <linux-nfs+bounces-20948-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 12:01:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86640423972
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDC3F30078A2
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF733BBD1;
	Sun, 19 Apr 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCcE7EhC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8733A70A
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776592899; cv=none; b=q2CJfq/224hj9GWw6k22yUbCYx1m1sENuyOgJbGqXFchPvhHHNlZ0pyTFk9Yt9wajwxkeAzlTMO/QsxOW+Hd0nUTBzF/lNTUeeFI6iUyWMNPcEZfUvE4dkyvFBFJOGRuivY5UxONRd6p17/eyAx6RwNv2LQ+D0/VyLaZNHn8MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776592899; c=relaxed/simple;
	bh=z7JTUZp4LcU47Ad0vEqEDrnBx2l3Hyr1Uu4aEgLGfWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwOiKEopJhOvDaf1XsjQtk1aYOwXqzCtp4jBBatr4VVIYIdBHENlm43zRvyPJEIzzQnSs3vjMGn565vYeoGmLENxb5XGUcPAd/0ATYstjI3AtW26hMlebx+EEbVn9fJ64vL4YoSTm0tXwvg/8jtsEVPt7PvrKOkW9SFRi1h+u/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCcE7EhC; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1093408a91.3
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776592897; x=1777197697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnrtODt+brqKChju/hWvOZFsJWLerfJ2s7y5kIXWfqk=;
        b=BCcE7EhCoD5f43Wxx0YTPhfy5vTfJBmitUA1eo8z4f+stdbEaHryMUTzqSlOkGm9O2
         /sfPFmlLGW8DO/buJhnIODRzkhFyS/iyAWrRfGfk2IDxfoxKznpESrlv1mUpfa+U1Hv1
         tdL7BfXDcD2rhXRKpluBIRdLeo6AkerohsB8N7Sv4stqXVIvRZVrkqbPSTeOc8jMX2Bg
         omBma5Wv39KyRVfFeOxnvpR3Rw/kZKSUNeMfkNh5dCcbEqvZpTmwn6ue/vo7CNmurEs/
         0XIgEuZA2MmCOgiOYw294Occ+CmSMRSd6651VtaIZs3C/UWSVS/iQ10JOmXJP09UvP/7
         kp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592897; x=1777197697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnrtODt+brqKChju/hWvOZFsJWLerfJ2s7y5kIXWfqk=;
        b=nF3K9UO9ozB2I3Jt2XylhJ1UHBE6TLni7CkUorhj+vVvQA86KtzkVIj43V0hYdS4bj
         swGI79OjWImo4c//cyclyyKz2N9bC77dIDAP+PfqL9IYSVAn5ZbqlYyzkvsgP011wUU0
         lIFcDmtB/Y7JAtMc2dcC8gxII569/+eCIFnTeXsL38NawIxCgdygbvGPg16ZViM5IYt4
         GnnpJKjlFD03StVM62N31SK0vhpdv5NddGmuoVgP8dl+rmTOCTYvkhIOXVdCxtBLvwwV
         uXh9Xvs239rgENGX2tyLyDmpJQ9Z6hNwIVkzaw1HuILuXpwOBfqOtfEfq3hVg4h9zDgM
         Bmfg==
X-Forwarded-Encrypted: i=1; AFNElJ9JxiUTaghxzIdaR16FlwnAibpDLp+90ZnkFjgTfvI3kh72Eb8Ad4mlg9OE8jFi1M0Sh4nuCjunnRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jAIySjCOXi/Js+I0JDMSFFG9FUQ5iIrU1RlsIXTD0aoR4ORe
	wOEtuLBR7hDQhR2ovqenSOUsj36Cs8BfV3L96MyRvQsMUl4Fh5JIrO+Q
X-Gm-Gg: AeBDiev/n7dyEWNgp0jUJ1bUSp36n58tjTRK5unAMailt+dlMUwNo5JOR260NkKKS6s
	XaLmzsYXTWsJCQ/76urqDAQ1Bo8WVgASC0Vvgm7kmlGifS9UlxHjLtdr/j9Ktvxv8pMXpgxZ3EL
	PjTBoXsejvr51MSzQF7ToQGQsfCyLQMut/u41URsjtn1twDW5Q/4pjm+HcqIiVF56zJCoP94Zmt
	4e59ec3M0o4y5IBKrv+b+Pn79xB/nbX8eRcPpUc7dVqzhuhqQ9F+UczWhlNjyMkFXiKDK43Zl+m
	42L9+R84h/Cw/uDkWWD9cPdONEE0KsDYdy1cPakguMedIBjymAdW7f3tjhIEDcRo9ELTdaCEAWe
	2TzdXU9ncZZIwE9jQ7UoxDoeAgyU9VqE0/mOST8MrqLDmf2gVV/l17EuVamzlxt7Ue0rNa70fif
	r4JxWToOKVZylXzZKN4csrYMXd0Gl9UV8+PMsKXN7tcx8Da1ekF2Gh6+UP7m4MgHbSH0PtkaAso
	8KUZv2lOSX+JPCiq6NVatdpJnYaWDWzDuDp0Z0I
X-Received: by 2002:a17:90b:53c3:b0:35d:a38a:a117 with SMTP id 98e67ed59e1d1-361404745f7mr10149942a91.15.1776592897328;
        Sun, 19 Apr 2026 03:01:37 -0700 (PDT)
Received: from localhost.localdomain (1-160-233-238.dynamic-ip.hinet.net. [1.160.233.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410bafa9sm7114296a91.15.2026.04.19.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 03:01:37 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 2/2] NFS: Fix RCU dereference of cl_xprt in nfs_compare_super_address
Date: Sun, 19 Apr 2026 18:01:28 +0800
Message-ID: <20260419100128.20546-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419100128.20546-1-seanwascoding@gmail.com>
References: <20260419100128.20546-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20948-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 86640423972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cl_xprt pointer in struct rpc_clnt is marked as __rcu. Accessing
it directly in nfs_compare_super_address() is unsafe and triggers
Sparse warnings.

Fix this by wrapping the access with rcu_read_lock() and using
rcu_dereference() to safely retrieve the transport pointer. This
ensures the xprt structure remains memory-safe during the comparison
of network namespaces and addresses.

Additionally, add a check for the XPRT_CONNECTED state bit. While RCU
guarantees the memory remains valid, checking XPRT_CONNECTED ensures
the transport is still logically active, preventing operations on a
transport that is already undergoing teardown.

Fixes: 7e3fcf61abde ("nfs: don't share mounts between network namespaces")
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/super.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a318581f85b..c9044d9d64cc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1166,12 +1166,23 @@ static int nfs_set_super(struct super_block *s, struct fs_context *fc)
 static int nfs_compare_super_address(struct nfs_server *server1,
 				     struct nfs_server *server2)
 {
+	struct rpc_xprt *xprt1, *xprt2;
 	struct sockaddr *sap1, *sap2;
-	struct rpc_xprt *xprt1 = server1->client->cl_xprt;
-	struct rpc_xprt *xprt2 = server2->client->cl_xprt;
+
+	rcu_read_lock();
+
+	xprt1 = rcu_dereference(server1->client->cl_xprt);
+	xprt2 = rcu_dereference(server2->client->cl_xprt);
+
+	if (!xprt1 || !xprt2 ||
+	    !test_bit(XPRT_CONNECTED, &xprt1->state) ||
+	    !test_bit(XPRT_CONNECTED, &xprt2->state))
+		goto out_unlock;
 
 	if (!net_eq(xprt1->xprt_net, xprt2->xprt_net))
-		return 0;
+		goto out_unlock;
+
+	rcu_read_unlock();
 
 	sap1 = (struct sockaddr *)&server1->nfs_client->cl_addr;
 	sap2 = (struct sockaddr *)&server2->nfs_client->cl_addr;
@@ -1203,6 +1214,10 @@ static int nfs_compare_super_address(struct nfs_server *server1,
 	}
 
 	return 1;
+
+out_unlock:
+	rcu_read_unlock();
+	return 0;
 }
 
 static int nfs_compare_userns(const struct nfs_server *old,
-- 
2.43.0


