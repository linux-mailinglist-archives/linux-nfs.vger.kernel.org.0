Return-Path: <linux-nfs+bounces-6931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4AC995094
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4F31F25546
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E71DF74E;
	Tue,  8 Oct 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9mlzSJ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40113959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395260; cv=none; b=MfYEHfe8MAYlHg7PbstONPLephB/WKAAOdh6kgEHi+lcsSy4Jt/4utH+xTp/zqw97eTJYTOgZ0AOzcjrUa8kqqlVlyz+tFFwnmMzr9y1KPQNKZNRIo8/tTQVu1s3DjvXDi/VYawLziuRIiiH3YUeu1OImo2z9TrBZS3JqUV6e3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395260; c=relaxed/simple;
	bh=UO3Ijkcb2D6amcPFfIdr+M+0dhnixPQGtn7OVb983mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFGCcIv9Q2HPFb5rBuu5MM/1B4+5JnI+HyP/PouH99SV7IJoSiLWfkp8lBnZngyBxr/VyAQshopxQ+Rk7RL2B/LTdJIc4Xxsgg0236Mp0i7vS+itqwdWy3fqdEPMgve7b1qACeZYUQ0zMSv95RQNPm6q1sfa8pg/+VSuYHljhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9mlzSJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FE8C4CECE;
	Tue,  8 Oct 2024 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395260;
	bh=UO3Ijkcb2D6amcPFfIdr+M+0dhnixPQGtn7OVb983mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9mlzSJ63dZa5ae1FBol5DZZwm2Z8hdOdSUERklsO/a4OMCPbP0mmTkAwcHkDLBPQ
	 8/elDlwcUgRVg0rzFtlQzGzmLLNeCl34ylKQYxSbiUCUwKG447q4ZVdmujoO60Iytb
	 srgPZhrnw1z3i+/rIzp0Yep8j9jPinyLw+igBa4PzlBx8m4ViqIyG2Jr/1QHUpPfpf
	 EvMzjkCJJLNb5ZuH7gjcFp+q/0RtYkhT1ICkCG1P5xRDfsZJNiYkX0Q3Tw9PoeoVpf
	 v1FX3f7a0avJrRtfOAy1xuIB6vyM6rJ6+YAj5m9/0b8QSKo5AiLG0VKQbbEmkBT770
	 4bkMcSB+T1Fxg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/9] NFSD: Handle an NFS4ERR_DELAY response to CB_OFFLOAD
Date: Tue,  8 Oct 2024 09:47:22 -0400
Message-ID: <20241008134719.116825-14-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=chuck.lever@oracle.com; h=from:subject; bh=Ka++gHgUIUzafsIgfC4Xq2XQF8GGbX8s118CqdOApNM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfy3X6McosSqKuvQxLpnn3gQXCxoc1asENae hhxuKzwFiqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38gAKCRAzarMzb2Z/ l//dEACSrjdU0UUORvOGshj8/MmKlGnowF2vDPs9V85bC6etDNVirtmn/ig9Ib1ItFjLu8DX+Hc IHWQ5P3IFt29olzUZQ99yvcyJM2DfKUO2gNYys/DeEjGbQBi9pyrTYifAuK6gNxgJPz7ptixL5e kRBjrA2ylTjOeM83G90jQvuFtFKV2iWSZyYt/F8DjUTVUSm6Wg6MdBHTp7UiyHIxfYxxKj/YNnK zh6dWXWZpRTtGBLsvF886aAFMHX/APMa6HUr08hq+stt3PDE2SBk9vxZpkN2vBr8cwwJVsAGPpv VaAaMDw/yXrVDTkXdooq0NJ85U6PBQXAmPf+WyZydnsHpvTlMkIKZYv1jafZd2AlLPIoVu7kY4R lggEDb23q6FDqJ+wrD14iJJUHv5FKdh01/E4oLBIPktoCa6U6lsJFtgQRCNUg4LBitZd22ByRiO h2OLXhJKTwekXcQC6sFRKOcZfX37pgCo6kpEU3os46h0OjBTCHxZ72CKkr+L/bYnHuUp1D2lTBu XHvfJKpzr9YhbTJeCWYXeP7OUYRPvlAlrqJyk6qww+Fb4Zs4j61yH8bPFXNTtxE0OJ8FNZT6koC crE7Co/J6PBNu8YzTWfgrdJ9HGKYWoydDh8M3I4i5Bk6M0d0eNjW3kUNYYsGjSz3b1PzJvYWc0Y BXUP00Ex2mosSEw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 permits callback services to respond to CB_OFFLOAD with
NFS4ERR_DELAY. Currently NFSD drops the CB_OFFLOAD in that case.

To improve the reliability of COPY offload, NFSD should rather send
another CB_OFFLOAD completion notification.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 8 ++++++++
 fs/nfsd/xdr4.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a3c564a9596c..02e73ebbfe5c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1613,6 +1613,13 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
 		container_of(cb, struct nfsd4_cb_offload, co_cb);
 
 	trace_nfsd_cb_offload_done(&cbo->co_res.cb_stateid, task);
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		if (cbo->co_retries--) {
+			rpc_delay(task, 1 * HZ);
+			return 0;
+		}
+	}
 	return 1;
 }
 
@@ -1742,6 +1749,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
 	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
 	cbo->co_nfserr = copy->nfserr;
+	cbo->co_retries = 5;
 
 	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index dec29afa43f3..cd2bf63651e3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -675,6 +675,7 @@ struct nfsd4_cb_offload {
 	struct nfsd4_callback	co_cb;
 	struct nfsd42_write_res	co_res;
 	__be32			co_nfserr;
+	unsigned int		co_retries;
 	struct knfsd_fh		co_fh;
 };
 
-- 
2.46.2


