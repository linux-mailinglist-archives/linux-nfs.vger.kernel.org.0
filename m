Return-Path: <linux-nfs+bounces-20650-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K7fLc5w0Gmo7gYAu9opvQ
	(envelope-from <linux-nfs+bounces-20650-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 04:00:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E225399935
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 04:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5274C3006152
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 02:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013CA277C96;
	Sat,  4 Apr 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWLRJ/EX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CC3FFD
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775268043; cv=none; b=Plt2oCWw99QkRoMLYj43EPmc4hH1XYzAKwEOVvyw55cfSYmk94X/gazZC73nHEMq4XL47TXUvQAJq4hlWW61HT2o+BmmhaAGnqpcLiw7f7qKJ7C0ah3PtmQPT5cu/HW5Pe+m+B9kM0ICzy4SGlyQcQ832HQ97+o3qk9Uwr9Ngrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775268043; c=relaxed/simple;
	bh=xwE5t0LG/3F20TNNrUtGY613jux+lpvRpheRVJYPn+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsLEOsAzWHSM0jqRKvpub2n6SSk83G3keixDCPlwQbWtz67T6eL+Lr4DljxcFdkS3uAAey690ptEs1EfLainIME6p0ZoYBYhevlApikoM222S3rqpuCge/nye5rX6YAdSqhfp4HkWp0OFvvVMurUc928xHFpDAJp4huB6PMUfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWLRJ/EX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89cc71f4311so32155496d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Apr 2026 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775268041; x=1775872841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nna7XikjSIt8v38EvLKlFvQXyQgfQaOAHmwwtVCsG/8=;
        b=hWLRJ/EXn/1tAjQOg963jjsfgHXbWzeWHQTQPL7bqmcId7VWgX9EXYesozgO3/iGPY
         ZslA9wfKXPv2YTVzfmxlM7sZLMHm6+EnYwcLflRcazi5scOIbJ2wWkh9FkAXNqwEokIh
         4bFl+r9PkRDarA/4mavR78vnFYABDtxVkmx4fqSKwDgZAY9ngi2sjeMm6vEWzHO0dxSx
         qJbHEu6BKYsOXmiNmBZXF5hZrXiSIaHejkzZNuXXQqbRi9bO026js3zKcPd6DYSygvNx
         xovUJuccHspS5bC0ruwopIoVG+f4HIkqTJ0/GDAhpZGeVAe5jE/4+mUuuEzfHUJLBqa3
         9oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775268041; x=1775872841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nna7XikjSIt8v38EvLKlFvQXyQgfQaOAHmwwtVCsG/8=;
        b=pqY4Czh/YuoZSYhREOxaK6RZwuxOppqjuysqpX2vYkiCyHQv1lfHmzzffqFGraGvAt
         bHHqLJfS8SLGPuq7AhC5eMRfo11EHKPIS4gHmZMd+tknEfCqeRl09xgAas5Jp2RbLpju
         rtdVARUgLWsDivJo7wRPoNHPwIvMwwlXNNsIlEFalawhdzh52NLBtTMeHGkl6TSYc34n
         0jgiAb8MxUbpUbvdxls89R92KfUNK+mlkOlq/rOiAikzM8N1OLwDkPfh0qj8gjlZV0Ug
         YsaRObblF5TnRo9VKrtM7qBwf3drn6DRpK4223hXQZ/eKTafSwkDjOrMT6mT2XPR7Rfm
         9erQ==
X-Gm-Message-State: AOJu0YzjVOtH2+IeWGb2/kJuYEm3hiDXkcBjiT2JOACgJKWHi8KVweEq
	lQ32TmqkbnNwUDBbb+L30s9PLtUsfBLJnXx6Lxq0EXn1/1zVKf8UM8/U
X-Gm-Gg: AeBDievyp3jhpraqPmxi/Bvk421UNShOLb8Oo+p+nBrXs24Y7zR32lQOrcH4V3dThuE
	5A7tnjnPT8FtCzjP0GBYt8MI8GKXLDIJCJit94IAJnQEYBgvQJkKIe61PkUlcmI2I4e7BrnxjLB
	AvpFMI9u8M9mzc94zUF1CySTeJp6d4xHeYWly52JHh4noDnG3vb3hJG5XIMczrcdnsTvPW2ofUo
	2Fqkso0BGWuXUDpD0fUupmSGcRSEsT/AM00FTiBr5gleG/7wfTGfICfVMSnu8jSXgf/ISdfPGiK
	irOrzf2l7SknthPIWJx7wVSsqpM4fkZ/Z4BjLh+uaF4ztZwClv0CV6GE2QVIYZd0my9qB0G3ivU
	xpNtEEFkQJjVJApetvMe1ofxfeaI1tO7nQNvfb4GZrxtD0GeemW+EBnQbYZtgOE3j1+f4mqR4cj
	tE/1Aox983FwqK4d9HLO9wYwY6XWp+iKGfn/Re9vGErY8=
X-Received: by 2002:ac8:7dc2:0:b0:4ee:13d0:d02b with SMTP id d75a77b69052e-50d62c8a32cmr75557921cf.50.1775268041390;
        Fri, 03 Apr 2026 19:00:41 -0700 (PDT)
Received: from desktop.. ([2607:fea8:d681:2400:aac2:af07:379d:ffaa])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b8a8f38sm57316941cf.24.2026.04.03.19.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 19:00:40 -0700 (PDT)
From: Tushar Sariya <tushar.sariya77@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tushar Sariya <tushar.97@hotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: Apply session size limits on clone path
Date: Fri,  3 Apr 2026 23:30:25 -0230
Message-ID: <20260404020027.3327248-2-tushar.sariya77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404020027.3327248-1-tushar.sariya77@gmail.com>
References: <20260404020027.3327248-1-tushar.sariya77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20650-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,hotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tusharsariya77@gmail.com,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E225399935
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tushar Sariya <tushar.97@hotmail.com>

nfs4_clone_server() builds a child nfs_server for same-server
automounted submounts but never calls nfs4_session_limit_rwsize()
or nfs4_session_limit_xasize() after nfs_clone_server(). This means
the child mount can end up with rsize/wsize values that exceed the
negotiated session channel limits, causing NFS4ERR_REQ_TOO_BIG and
EIO on servers that enforce tight max_request_size budgets.

Top-level mounts go through nfs4_server_common_setup() which calls
these limiters after nfs_probe_server(). Apply the same clamping on
the clone path for consistency.

Fixes: 2b092175f5e3 ("NFS: Fix inheritance of the block sizes when automounting")
Cc: stable@vger.kernel.org
Signed-off-by: Tushar Sariya <tushar.97@hotmail.com>
---
 fs/nfs/internal.h   | 2 ++
 fs/nfs/nfs4client.c | 4 ++--
 fs/nfs/nfs4proc.c   | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 63e09dfc27a8..0338603e9674 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -253,6 +253,8 @@ extern struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 					     u32 minor_version);
 extern struct rpc_clnt *nfs4_find_or_create_ds_client(struct nfs_client *,
 						struct inode *);
+extern void nfs4_session_limit_rwsize(struct nfs_server *server);
+extern void nfs4_session_limit_xasize(struct nfs_server *server);
 extern struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 			const struct sockaddr_storage *ds_addr, int ds_addrlen,
 			int ds_proto, unsigned int ds_timeo,
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index c211639949c2..71c271a1700a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -855,7 +855,7 @@ EXPORT_SYMBOL_GPL(nfs4_set_ds_client);
  * Limit the mount rsize, wsize and dtsize using negotiated fore
  * channel attributes.
  */
-static void nfs4_session_limit_rwsize(struct nfs_server *server)
+void nfs4_session_limit_rwsize(struct nfs_server *server)
 {
 	struct nfs4_session *sess;
 	u32 server_resp_sz;
@@ -878,7 +878,7 @@ static void nfs4_session_limit_rwsize(struct nfs_server *server)
 /*
  * Limit xattr sizes using the channel attributes.
  */
-static void nfs4_session_limit_xasize(struct nfs_server *server)
+void nfs4_session_limit_xasize(struct nfs_server *server)
 {
 #ifdef CONFIG_NFS_V4_2
 	struct nfs4_session *sess;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743..655617ffca8d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10618,6 +10618,9 @@ static struct nfs_server *nfs4_clone_server(struct nfs_server *source,
 	if (IS_ERR(server))
 		return server;
 
+	nfs4_session_limit_rwsize(server);
+	nfs4_session_limit_xasize(server);
+
 	error = nfs4_delegation_hash_alloc(server);
 	if (error) {
 		nfs_free_server(server);
-- 
2.43.0


