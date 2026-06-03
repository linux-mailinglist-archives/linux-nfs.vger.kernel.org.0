Return-Path: <linux-nfs+bounces-22238-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ELAGwpOIGro0gAAu9opvQ
	(envelope-from <linux-nfs+bounces-22238-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:53:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242563972C
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=ArkKdqfJ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22238-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22238-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624A0321A3A3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E723AE6E2;
	Wed,  3 Jun 2026 15:09:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A83C276B
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 15:09:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499391; cv=none; b=ibULiCtS+val2+qv8ZyddshfeVDm7mzMnCOdp7P8G0NNIn9aIX0e8OMqkreWSEZ7gv2j8lq71iksxGeWPR5mf1dSyuyAgqv/K8AXwzsh6sABXtEm+lX0MFsw8/es1+QqpjD+2Euu9ibeOGjErl3bX893UaoDVerf0NcLeYprSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499391; c=relaxed/simple;
	bh=LiSk6gVHsqX9Ky8mhLRMYSYqqNVphfCtpjgQCaJQJWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYRFyeM9P52upzvXig8GJzJt4fotnz9nRsNeD931kwy52hIyY1uXaSjapZhwXVZ3CqCKW/zUUliMZx+cdaifpQDSFscmIKqUHNKfNZetC0YVdBT2WSpcEtJOkKSYhLt4AlcLJqL3k5AbKjQySCPEdTv/rnHPZiuJG2JPHXII5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ArkKdqfJ; arc=none smtp.client-ip=209.85.160.41
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43d3454f643so981765fac.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780499389; x=1781104189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK3tHd0VkYgjnshPNtawtXwIer7MYfRaCPk8DA0hqnQ=;
        b=ArkKdqfJlQMNqnsI2iVM9Mi1CNM+hJrL+R0EFXCh+lZnq9g9GCUg/4U1LMcw6H90uI
         b05dPjRytaVXpdnA/s2KHwP4ZRBcj72fuGsaxLJBwidMBoNSiIH0Bdk8XkhXNvk3OYBm
         zFUa2FwMMZ+NmLHRxNozssaQrq7B/x6KxjjGLFmn5ri+n1d8UwM7LbfGYMysR0Laf4aP
         IEPp6bW5o+45L2wM2EMr1gKt6nlkIKuRt4gt0qSbX6Ae9VXzdu6I1487Xi29ST/MYLvM
         mLDSRQYVjdPjtmmrTKm1kOjprmLY0phoJ7sMuIgUMU5g19DTPaaIH2hkvEGrSch5tG5h
         0MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499389; x=1781104189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EK3tHd0VkYgjnshPNtawtXwIer7MYfRaCPk8DA0hqnQ=;
        b=mtTzc6nxGxnw3wIwqGuJS8UbhD/Mh1ONxzcLyyQAHyiXRYIECO81iTOAVMnPpN5Ewz
         on+6l7VvE26l0JTQZjz+zko/rJu0dMaXjOaOF4fk8r1mUyqHFKFgDWgeYDRl7O/3+PHN
         +poodUEWaSOkd8VAqybJu9PqkAZNn7FbWKOKHrm8AqElswGhU1i1DIxlTr3ll9wWnR/a
         6GgtxptZ3R26IM2wNWrCl/6jEGjr5SXS29VXle5GDBOcAVWz57vd5CgJWbBHQVTs2U76
         tz0LEqKMGDzBvies+jDkeqje5jMg7wBGwxr6Lx0AyFqmilp8Gf52Dn1u4GRK0lDgRThA
         NM7g==
X-Gm-Message-State: AOJu0YxdLED8eGK/5WGC2Hno2wSpFZDQH9uhhtXecKa3OK6skOeUrnUp
	WeCLYzuz8JjHvqqyAd9FRjOqZ9+I1/zIUIKlYn0Vtdx7c5E7rd/3iIunj1n3gxfgWtE=
X-Gm-Gg: Acq92OFhOrMBtbccVWE7BRNlHs3p23qNyg2z6/ONvIpPD3aosBjnm1KJEXCaahVp3mg
	biVklObdUY5nqPfkCcKCQCj4pLRCGNPyszHBM4gL2/nDR/R2yz05qHpwFUG5fIU6KrWhjZ3Wbxr
	hv7Kj4p7Hy4lb/83mUiY9xlmC78hRUmcdMFdf9cCj2OaJvF6Iqnq8Oh2dK0JwnwEqvUqy3meWXa
	HQ24vUYb0mQxUGQ1TAANeGAhHnYWrPRnvPok5q67/qjf6Vvgdz4sTCd/tdG1LMB1J3mlzFSHfqt
	SNmaOMm3yBauCDx6nANMr24W7ESnxH6DXClEC1lHR6nd1RWFHPOygNQWogT0GYg/3sSw8kiZyQx
	7AOmPGopU/67V1jwocfmzkcZ6X0fiX6DW9ZLn1NQ9+WZklCl0QztVERE7vUttD/BZiLRfUYJ7y2
	hlXllhQyFJ0TFr0W8jbtJaxQyyY/t46350jp/yF3e1Qd0TThW1rZy9fy0JOtesXUAmZQ5ALQ==
X-Received: by 2002:a05:6871:2b15:b0:43b:973f:185a with SMTP id 586e51a60fabf-440db78c1b5mr2431882fac.19.1780499388903;
        Wed, 03 Jun 2026 08:09:48 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84c0ce2sm2917634fac.16.2026.06.03.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:09:48 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: linux-nfs@vger.kernel.org,
	Daire Byrne <daire@brahma.io>
Subject: [PATCH RFC 3/4] nfsd: add a fairq module parameter
Date: Wed,  3 Jun 2026 11:09:41 -0400
Message-ID: <93347e4eac42588a9533b37e09c28b4b53a55413.1780498019.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780498019.git.bcodding@hammerspace.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
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
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:linux-nfs@vger.kernel.org,m:daire@brahma.io,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22238-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:from_mime,hammerspace.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9242563972C

Add nfsd.fairq (bool, default off).  When set, nfsd enables the sunrpc
per-client fair-queue dispatcher for its service via svc_set_fairq() at
service creation, so that a client cannot increase its share of nfsd
threads simply by opening more connections.  The parameter is read when
the service is created, so a change takes effect at the next nfsd start
(thread count 0 -> N).

With fair queueing enabled and no upper-layer identity stamped on a
transport, clients are distinguished by source address, which already
gives per-client fairness for NFSv3.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
---
 fs/nfsd/nfssvc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 551d3cf51036..3abe4d2aec5a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -36,6 +36,18 @@
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
 atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
+
+/*
+ * Per-client fair-queue dispatch.  When set, ready connections are scheduled
+ * round-robin per client (NFSv4.1 clientid, else source address) rather than
+ * per transport, so a client cannot grab a larger share of nfsd threads by
+ * opening more connections.  Read at service creation, so a change takes
+ * effect at the next nfsd start (thread count 0 -> N).
+ */
+static bool			nfsd_fairq;
+module_param_named(fairq, nfsd_fairq, bool, 0644);
+MODULE_PARM_DESC(fairq, "schedule nfsd service fairly per client (default off)");
+
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static int			nfsd_acl_rpcbind_set(struct net *,
@@ -635,6 +647,13 @@ int nfsd_create_serv(struct net *net)
 		return -ENOMEM;
 	}
 
+	error = svc_set_fairq(serv, nfsd_fairq);
+	if (error) {
+		svc_destroy(&serv);
+		percpu_ref_exit(&nn->nfsd_net_ref);
+		return error;
+	}
+
 	error = svc_bind(serv, net);
 	if (error < 0) {
 		svc_destroy(&serv);
-- 
2.53.0


