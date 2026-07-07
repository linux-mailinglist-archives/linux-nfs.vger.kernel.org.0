Return-Path: <linux-nfs+bounces-23128-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 219GMMeMTGppmAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23128-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 07:21:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7187176D5
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 07:21:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rg7QkQtg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23128-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23128-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11BD03016039
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21633DED9;
	Tue,  7 Jul 2026 05:21:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5C42087D
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 05:21:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401667; cv=none; b=JTHwfzL6GoG8g1j38/DaNMF8jzdeqw56/v5lNLxXF/rm0xRHDLsVzhDKG1o3tlkDoT5HB7SLCY08g7yVhIKutv13TBEyr3bSOijOiaTRZ29UJeI2GcZWmNwOT6fI0QOFRYpjqrNC0BPN0SfFOGTeGBWemdPo4jsXtGY6aiTGN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401667; c=relaxed/simple;
	bh=qXIWHSLyD+fTq5CYIL5RdrArR1kMbF2BZZFtbn1U3K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGQOoa6lS2ut7+MXgCSrHAVWI/Khk5AXgithAu+StXSaeMKz5RH3exOh4CQb3ceVkYsHjK30B90WQ2mqGsC57GII4alK+XZpnJk74AY7Mdm6fxvMyJPYxFClK5+8boESW72OxWegDclzb2EUmm43Q90BFPTl5srgWZueipsbelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg7QkQtg; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso5072576a91.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jul 2026 22:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783401666; x=1784006466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Blyrj+ntsWafQiuA8MTgFjvm/6Vjz++htzHBsCCdax8=;
        b=Rg7QkQtgjI8Nm7+44hbGHGJGJulxcf6jPFHQ/1LJpWv+N67+zcoi1as/Z+cE8hy71D
         BoLDbR1QV35x/a3Teznw8eXH9Yio/WEpMtZomgXOnrSZ6tDWl07uhRnMFqqHTFp896Dz
         crWOVfzqcC27WosYJrRIBjU/3MpgNp0WPpKlvwjWqxkfBAPaGcirR73A4aIZMt6L1ky3
         8AQFrbr9caACBtoG+PYjVBsg9pqzpjtVISGisaXTvTd8/mmQhno8dRCImmrCAFuWpBt4
         YGMojhaeXJx5ZR4qcukfD3ApYPPPTxMFob6YU9xgfyfC2/q8dDNmiTQ1UsloixmnwpPn
         gUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401666; x=1784006466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Blyrj+ntsWafQiuA8MTgFjvm/6Vjz++htzHBsCCdax8=;
        b=N/2EXN8wJUiO9DSPz3uTi/nhh5spWWoxVBBlrbFJZatvtT48NMCNfhe1oJH54EU7aQ
         w5NUwR3Me+YnXMREM9pBaA6fzp2o+E64sacAEZ9MxiNyZEnxzfAxGz8SfByK1PWQaJ6O
         IFD8nc4OnXVNgRAgb6PFhyBNCpkOFaiE77T0d7x5dKNyD6MwAbvyvqOATQwnhrypZc8D
         +I0s5AAcil4QrjYP+PJN67+sBVmdnJfLztCM+vUmEZdCgX15x+Z4a1UVTuCxRqGQk4LA
         0WK7zPDfZRnJypthVGiUyWzj5A1rRSC99SAru5INL7lMx2WvkJS2GrauXpNjNc9nxg2G
         /9LQ==
X-Gm-Message-State: AOJu0YwXABXEbjhSY1YCRQHJ/ZpZOsNaXAnO2ojmd3zYyeDMuQ/G0Udj
	pSZHHbvl0+sp41OCoxCVrhwQCbLCFEbMj0+3ugjJ57bUe5p93XlpQdqVjB6i+xLncSw=
X-Gm-Gg: AfdE7cm2v38V9zOjpilzyF7RqooDWHVN7D9EML4uzWohCiTGJ51t/hcgswxrRlWnTgk
	lWkpvSD9/nNibitNZBGzRUHZXfnmyffUT1zks91SGhtXiZfrxX6VL9eZOm7eArS8gG06DJFdq1n
	YkfdMpu02Z3x6RToK6gq/E9kecgBWkc/RFkCuk74yJ4xPgsvJUg0y3rNocIDM5Q4/2Tgmc1Lg83
	eVVo+E6wcwPQFhARAKFbvhyT+JpseWO1gIn001ow+iw7PvcgzcgvZShk8S55u+vekG7s1BqOxeC
	aGVAmSjT83Ap/T/yzskfH7qLsppaD9UKvC/4T9/o9+SgxLwXW+OOB71OXyI9Lm17D203v7UWD1f
	ew7V5m3YTgAjHH2Y5iFKNUwza3z/bS5uHEWa68Ov/3IPcymRfYXs8EOZQQ4z+KdmiT7+BV/GLhU
	BaCIyE625hSFQqCD4x8PCl1RXP9oeNhGM=
X-Received: by 2002:a17:90b:2688:b0:37f:caeb:69df with SMTP id 98e67ed59e1d1-38758164244mr3838662a91.22.1783401666109;
        Mon, 06 Jul 2026 22:21:06 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([123.114.53.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d15f149bsm419814a91.5.2026.07.06.22.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:21:05 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: cel@kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	fuzhen5@huawei.com,
	yuantan098@gmail.com,
	dstsmallbird@foxmail.com,
	enjou1224z@gmail.com,
	rakukuip@gmail.com
Subject: [PATCH 1/1] sunrpc: fix use-after-free in __rpc_clnt_handle_event and __rpc_clnt_remove_pipedir
Date: Tue,  7 Jul 2026 13:20:47 +0800
Message-ID: <7cc1079bdd86c196d5c714c91df38dfc73aa40b6.1783393213.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1783393213.git.rakukuip@gmail.com>
References: <cover.1783393213.git.rakukuip@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-23128-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,huawei.com,gmail.com,foxmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:fuzhen5@huawei.com,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:enjou1224z@gmail.com,m:rakukuip@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[enjou1224z@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[enjou1224z@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B7187176D5

From: Luxiao Xu <rakukuip@gmail.com>

Normal client creation goes through rpc_setup_pipedir(), which records
clnt->pipefs_sb, but the mount-event path in __rpc_clnt_handle_event()
calls rpc_setup_pipedir_sb() directly and never refreshes that field.
The umount path also removes the directory without clearing
clnt->pipefs_sb.

After a late pipefs mount or any remount, rpc_clnt_remove_pipedir()
compares the current superblock against a stale pipefs_sb pointer and
skips cleanup, leaving pipefs dentries whose inode private data still
points at a freed rpc_clnt, leading to a potential use-after-free during
subsequent rpc_info_open() or rpc_show_info() calls.

Fix this by properly updating clnt->pipefs_sb upon mount events and
clearing it during unmount or failure paths.

Fixes: bfca5fb4e97c ("SUNRPC: Fix RPC client cleaned up the freed pipefs dentries")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
---
 net/sunrpc/clnt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index bc8ca470718b..85fdd8ba94a4 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -96,7 +96,10 @@ static void rpc_unregister_client(struct rpc_clnt *clnt)
 
 static void __rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 {
-	rpc_remove_client_dir(clnt);
+	if (clnt->pipefs_sb) {
+		rpc_remove_client_dir(clnt);
+		clnt->pipefs_sb = NULL;
+	}
 }
 
 static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
@@ -177,19 +180,28 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
 }
 
 static int __rpc_clnt_handle_event(struct rpc_clnt *clnt, unsigned long event,
-				   struct super_block *sb)
+				    struct super_block *sb)
 {
+	int err = 0;
+
 	switch (event) {
 	case RPC_PIPEFS_MOUNT:
-		return rpc_setup_pipedir_sb(sb, clnt);
+		clnt->pipefs_sb = sb;
+		err = rpc_setup_pipedir_sb(sb, clnt);
+		if (err)
+			clnt->pipefs_sb = NULL;
+		break;
 	case RPC_PIPEFS_UMOUNT:
-		__rpc_clnt_remove_pipedir(clnt);
+		if (clnt->pipefs_sb == sb) {
+			__rpc_clnt_remove_pipedir(clnt);
+			clnt->pipefs_sb = NULL;
+		}
 		break;
 	default:
 		printk(KERN_ERR "%s: unknown event: %ld\n", __func__, event);
 		return -ENOTSUPP;
 	}
-	return 0;
+	return err;
 }
 
 static int __rpc_pipefs_event(struct rpc_clnt *clnt, unsigned long event,
-- 
2.43.0

