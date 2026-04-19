Return-Path: <linux-nfs+bounces-20954-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNAaCL8D5WlCdQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20954-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:33:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C66424BA4
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12293047536
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19581285CBC;
	Sun, 19 Apr 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeqJ+m/0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D240DFA4
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616312; cv=none; b=ayFo846B4ZGIgKw4alFmO773iJewzSbGXBrLUxio6h3HnJvOe8OMd8W636cxxBawDkRp46VoxKRBGsUrGHG7t2UFKay0VnQA7kYn8fjRFoA1m9KrDK0Adoqq7kLbWe9iCQPj7KnKPb9karNmLUCkHntc9/Q1W8i5A6F1JYlt7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616312; c=relaxed/simple;
	bh=ff8TxayYcJM1Xb+UydnUDsukyJ/CSZYuBMqv05UKuK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS/7exK1PQQ3wCp7ET0pX1Ib/zKjnOqB36xyvouIQ9fxynFPjZQz4Sk7aNESCoLmlfROWoRMr6Q82YZGpwaQKcqstuM80WXafNQuzvHbaNsIoHon18NoHNGrMM9zFwRkVtrr9wIhditatkMC7FrQV++vnzv8MWsbfpo5+ZCWkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeqJ+m/0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so2212968a91.1
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616308; x=1777221108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG+XFyafSRmvtoGWdsZ9aUvZEWjPbX53j6Q6FbiLCsc=;
        b=KeqJ+m/0HPbb73W3Yzk3i8buTW8tF2D+Zy2qM99GHjF1GDp/AgZpWtt5nTywexnE30
         oTLR6pGbNWBfGFV3QkUGyMp4x3+4fuOEK9OErEDMRFyxrZg5Vs/KMX6hKNR3h/yMQ+6W
         0j5HZk+p5t1SyipMGDnO741pM9rCGYn5eh/yFx+hINq80Pz5ERTFfBjTj+G3HP4rjMAJ
         Iy1gQAJo7BWCtoTK5wG1RFi+wEwyI1yXagk+jJP9wQs6hVw4WsE4YHMmAzDPbjZLOErH
         eGKPW1dV/46qRmGKK6UtRk63IiArbKjiuOX81oAVAWyQvZms2u/JAaXk5hEwERWPMcB6
         KlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616308; x=1777221108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG+XFyafSRmvtoGWdsZ9aUvZEWjPbX53j6Q6FbiLCsc=;
        b=WIunM6j1SHbNSJK2oLFRGEbG4iTbgQ+NgWSRG/5AwjlWhjjMlWavg1wiJ/SOnDQPtM
         j9UlACgDt1K2qxXWEnnqmRWJMstBsy81wrSzt9Kfl9Jw6dL3XfjCGUfmQd8yeijABU4R
         em5Nuc+ifokTzZHZxWIZ/QYlliTo5Wrq8wt7dDLHgJ6sBbPJ2yy47laHorHpPG3WxXWc
         zo1rEPp4ZbfhUuh4XnRBykQiCg+HoylLNL0t/1D2KBcyZPHqBhlvdTlLzrC5malCR5bc
         tsx13MvepBoDjdbXUQtBzyzc0axQf2bJG7XtBZtdxkqFgAnTK9tbezX39sssWFTM6VfY
         sZiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vGwOqDgm+Nh6Os0De/CFJ53nX/PfLO5LkTdzTaiXdknyF7kaUbaGrgB+755YRaZHhkRpiGAQ4oKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4+1mdz/w3NfGjQ9dpTd8REGVqvWQ5lm1mDso7oAexRP39V+I
	sbm6Ax2hF2Ppc3eDZ+vz9wIpPsxZYXtisIPGJ+2Ngvvuze+NZfAj9N9a
X-Gm-Gg: AeBDieu7Bz7Ql+SLY8jh1y4z18Oe10mHxQZDU69Oq/wlc4cmdlPXOd/ywbWgS4l09vs
	jrdDLR/ocUT+a2Gw+3aZWMvSmkL06DbkbP/JJ/Q5DOxye6YfaLoCTvXsmFAGZXWD9UONk9LEze4
	q3cH7BSYXD/cZDav0ATeE1pB2z4N9rFd89sdLHFf1lTwPVVdEkllFutl0O29IHQL0nbOgGageI4
	ktwlvZuB3ASceMW+czilkp34DgiQeseEV98Y/XqiLlm8cMvvpASm5Aadx2m2y/TA0Vlmlq9/po2
	/t4Wo9C09yLNt5J9bDourAEJSXaZuCNZEBJhiz6iLdiTlYqAHBQnX679FS6IjdeOLMe7BeL9faT
	0oORnv+YlW0b9aGbBCBAqe+j0prKRci/6SCESeK+HE3dL1yEzfqImrLpmuZ7bgtkxq/1DDfGw37
	Dlxq7q678kIUFNgDd0RsBh1gA6nEwg9F7RqYPrEw8KLQQRZvn3OGWRO+gxqgoKK/5FdyEtoPUzL
	fgrspiaSVQM3KgSJN2jWfEJ41Nz9w==
X-Received: by 2002:a17:90a:d09:b0:361:45df:f5 with SMTP id 98e67ed59e1d1-36145df04afmr6199178a91.16.1776616307905;
        Sun, 19 Apr 2026 09:31:47 -0700 (PDT)
Received: from localhost.localdomain (1-160-233-238.dynamic-ip.hinet.net. [1.160.233.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm7814196a91.0.2026.04.19.09.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 09:31:47 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v3 2/2] NFS: Fix RCU dereference of cl_xprt in nfs_compare_super_address
Date: Mon, 20 Apr 2026 00:31:38 +0800
Message-ID: <20260419163138.26963-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419163138.26963-1-seanwascoding@gmail.com>
References: <20260419163138.26963-1-seanwascoding@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20954-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0C66424BA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cl_xprt pointer in struct rpc_clnt is marked as __rcu. Accessing
it directly in nfs_compare_super_address() is unsafe and triggers
Sparse warnings.

Fix this by using rcu_dereference() within an RCU read-side critical
section to retrieve the transport pointer. This addresses the sparse
warning and ensures atomic access to the pointer, as the transport
can be updated via transport switching even while the superblock
remains active under sb_lock.

Fixes: 7e3fcf61abde ("nfs: don't share mounts between network namespaces")
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfs/super.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a318581f85b..4cd420b14ce3 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1166,12 +1166,18 @@ static int nfs_set_super(struct super_block *s, struct fs_context *fc)
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
 
 	if (!net_eq(xprt1->xprt_net, xprt2->xprt_net))
-		return 0;
+		goto out_unlock;
+
+	rcu_read_unlock();
 
 	sap1 = (struct sockaddr *)&server1->nfs_client->cl_addr;
 	sap2 = (struct sockaddr *)&server2->nfs_client->cl_addr;
@@ -1203,6 +1209,10 @@ static int nfs_compare_super_address(struct nfs_server *server1,
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


