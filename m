Return-Path: <linux-nfs+bounces-20210-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KGzDL4huGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20210-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:29:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D029C5A8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64A2D30576CC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22FD3A6F0F;
	Mon, 16 Mar 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq9bwA59"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7D3A6EF0
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674225; cv=none; b=JfoiNRd4HNa/ASiIi40j/o8kfzv3k+iS6+cWOptAA7pqLH6X8G3MdlF8ffmZh+KceNXx/52/Fwk/hgceB5PoStL7Wgs5Jaqez2rpBukkm48StLQ7CKgH/ocsazR77HdW9q6eP/6Iaw20FxRXPnV97RUDKUmEKjozOODFZpFaNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674225; c=relaxed/simple;
	bh=GMF33ofp6pSKP2m8yzzs35fgzAnIqwa6hdtFyXJZBVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWjh+iZ6vTnwA+Iax5kk7a7UHu+zG3ZF6FD39QZQFSWL/awr80qNorCClgPfPLG8HgsaV6drQ14izFlO2RRYWMvsMnvmHaRXfP3rsdb0UrVAE3aASURzKu6hNN8WweP3tq5fK1ecXkixmd2F0v3WQ6n4eAUHSTu/p+VJzR60S5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq9bwA59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF47C19425;
	Mon, 16 Mar 2026 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674225;
	bh=GMF33ofp6pSKP2m8yzzs35fgzAnIqwa6hdtFyXJZBVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dq9bwA59wbWbBxcPgiHPapjGJ0UhHKc5Gke62zj2+eblkfcqZwnsVwXIV4eImJfmo
	 +uflwASZGV7ZoPhlCjsaHeLqD6iAowZD55p5gdb0P5BGwwHPzFA/mEH24egVIMSNuk
	 YRewpAc53ZiUcnP/vaatnP9IXhjfd6aoa7UVyelYzq8grFzoVQQ+Hg0YsIPYGqHIai
	 wTQzAzQZMBdW04KRsJuih2o6MnIHqYru3xjocqWnU7vUcCGp/khrJPMw9aUkCaH3gD
	 CrO0JmGBqhuJnFgsxlfLsZoXQolm2KbhnZ7jwO6shmg99UCywrIrnPHQMw1sveVr6X
	 88ACo6KwbpIdQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:49 -0400
Subject: [PATCH nfs-utils 11/17] mountd/exportd: only use /proc interfaces
 if netlink setup fails
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-11-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GMF33ofp6pSKP2m8yzzs35fgzAnIqwa6hdtFyXJZBVE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7iy9YeQ/ZdxPl/7t8+u5gh1H5nMcJbOCjuM
 nv+rS0iG/+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4gAKCRAADmhBGVaC
 FfvUEADT2PaI2BeIHJoqZSzZihafPi1IcegSKGebVAZ6dhMHeTfrg5Az6SmJirrt7k9SkN4X7wx
 ZQKH70ywzGE2+tdCBqb6fgMmpNf16nmdRuB8Hpw1rsNcPp3CRWNUFjOA30RFQZePBM+Pz5gcCSG
 8Jano/VfSMy/fDlO3zdQJl7fxIgO9G+IqFRAiX3s49XGm95Aolx5OJtXeV/zPaS/n7wfzm1y6zC
 bToNHC/KzGso7R5Fo9hlKyg41ub4XiNwVCQ4FibC9ggJVNsnIRsvaUz5cpo1LMEoP3ZhUOYLThj
 XC1RmOub0G2J+oji9DRWr2/djwEuzuk2q2pgnOtoNjDZD6EA+7S/NgpfmcqdKofcFsLze2mEdxZ
 Bg+Nl0mDN6wWZATkLQp1T4DqPFw4eRtbSOHj4KWMjnPKuYGtvC13waKoY0XvR8yCIWCbMipS78m
 R/Znb/Y3JtbQTElSqQpPZpQ8o3T1ltNJpFgfngHeiPUNFRNVEC7sUArDDLf/yn7svjSDAyR/DrP
 DeEzTipDUv/ojUMYT4saFQn7l1KbdyE0ZooihJWixSA0VMLf7WO4njHSWScDUFiwEKkvWcDuN2z
 p7GHHR6xblLXsxQoVcPHYPqUNcXPH7Xk9MlnpXksu9HriKXIhf3MaNjX/IJ2yTtqF1L8DGLD8AN
 B7EhA9peYc4ZlDg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20210-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B59D029C5A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all of the exportd upcalls are converted to use netlink,
don't bother opening /proc channel files if that succeeds.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 43cb16079da867e6633b9cc6436689ab0e156e44..19cfbf6594b0a51d85814460f3153add89aa3a8a 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -3013,6 +3013,16 @@ void cache_open(void)
 {
 	int i;
 
+	if (cache_nfsd_nl_open() == 0) {
+		if (cache_sunrpc_nl_open() == 0)
+			return;
+		xlog(L_NOTICE, "sunrpc netlink family unavailable, falling back to /proc");
+		nl_socket_free(nfsd_nl_notify_sock);
+		nfsd_nl_notify_sock = NULL;
+		nl_socket_free(nfsd_nl_cmd_sock);
+		nfsd_nl_cmd_sock = NULL;
+	}
+
 	for (i=0; cachelist[i].cache_name; i++ ) {
 		char path[100];
 		if (!manage_gids && cachelist[i].cache_handle == auth_unix_gid)
@@ -3020,8 +3030,6 @@ void cache_open(void)
 		sprintf(path, "/proc/net/rpc/%s/channel", cachelist[i].cache_name);
 		cachelist[i].f = open(path, O_RDWR);
 	}
-	cache_nfsd_nl_open();
-	cache_sunrpc_nl_open();
 }
 
 /**

-- 
2.53.0


