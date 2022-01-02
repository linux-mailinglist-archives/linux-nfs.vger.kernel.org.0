Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053B1482C68
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiABRgG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiABRgG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:36:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F3C061761
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 09:36:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F24B80D95
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1719C36AEB;
        Sun,  2 Jan 2022 17:36:02 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 08/10] NFSD: Clean up the nfsd_net::nfssvc_boot field
Date:   Sun,  2 Jan 2022 12:36:01 -0500
Message-Id:  <164114496159.7344.7632968111470947824.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
References:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5145; h=from:subject:message-id; bh=UFDhw2jXgiVuxRpsd3yYxrnpLx4irk+DXhhUAzm/eBQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eKBCBqbUXcQRWMTrOzrnWxiUF0tNx7cri3osHAs rQ7NTwiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHigQAKCRAzarMzb2Z/lwq6D/ 4iN9M4XDHzjsdw/jrETTkHmAU0wTjy3gTjO/K3xRp6+f1y0ObZB1BhkuT3U1gbYD+K9t88DB5gMZ+/ Vq2sAwmSyb+3yNla6EWwc41wKPTRRtqjlbDKiMRwVWoKzi0jBwTD83RRShHO7zvnufoBtUhI7XMj+7 Ws3ap9FAE4kdVtVM+q08E398i/UEn0bbwK1CtGnMJPSuV++gBudtRp2wYsn5YTHpoWBCl0y7fwrwUk zWyx9cvRSzY5+5DoexX0+TNiYpE5Naoyd/lgy+1roFhhgYC7id78R4K0/lohapJtNDeneDxtpqmPDb apaZMWrfDDY9QZ4vKoxGRcbClc49kqZBDoL3tOoaxe+HJkSBgAjn9Gw/KuEgKVCVuy1rEhh1VI9Q4/ 8I/hiX6q7FankO4VH7XnqFDN911pt/RcS2tETv8zypLLurTg9nuSmR7wWIG+mp3uEAOIdanXO7XXN6 EkLYmbPjM+2jvnq0hqtu/ih+bWMgNMqR/lgeqwoxwYEyoIhxhV9UoeEMt2sYk/6gR0jvsU2Q+ai+Sj PuK03GKc+pMdXPfi4uBqR81o/Rh8ZSPK1GP7khu5X+A4/BF1DRJ3WA9lFve1UdSTHO1lKuNm6ZJMTA yyHQKpXF26TPjL3ZOGr6sGi/pouxRlgIgYB3fvCg+pJ1DZ4DPHBWKUQkTbtA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are two boot-time fields in struct nfsd_net: one called
boot_time and one called nfssvc_boot. The latter is used only to
form write verifiers, but its documenting comment declares:

        /* Time of server startup */

Since commit 27c438f53e79 ("nfsd: Support the server resetting the
boot verifier"), this field can be reset at any time; it's no
longer tied to server restart. So that comment is stale.

Also, according to pahole, struct timespec64 is 16 bytes long on
x86_64. The nfssvc_boot field is used only to form a write verifier,
which is 8 bytes long.

Let's clarify this situation by manufacturing an 8-byte verifier
in nfs_reset_boot_verifier() and storing only that in struct
nfsd_net.

We're grabbing 128 bits of time, so compress all of those into a
64-bit verifier instead of throwing out the high-order bits.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h  |    7 ++++---
 fs/nfsd/nfsctl.c |    3 ++-
 fs/nfsd/nfssvc.c |   51 ++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9e8b77d2a3a4..c879d80d5449 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -11,6 +11,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <linux/percpu_counter.h>
+#include <linux/siphash.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -108,9 +109,9 @@ struct nfsd_net {
 	bool nfsd_net_up;
 	bool lockd_up;
 
-	/* Time of server startup */
-	struct timespec64 nfssvc_boot;
-	seqlock_t boot_lock;
+	seqlock_t writeverf_lock;
+	unsigned char writeverf[8];
+	siphash_key_t siphash_key;
 
 	/*
 	 * Max number of connections this nfsd container will allow. Defaults
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a8ad71567fc7..b9f27fbcd768 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1483,7 +1483,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->clientid_counter = nn->clientid_base + 1;
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
 
-	seqlock_init(&nn->boot_lock);
+	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
+	seqlock_init(&nn->writeverf_lock);
 
 	return 0;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6eccf6700250..81d47049588f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/fs_struct.h>
 #include <linux/swap.h>
+#include <linux/siphash.h>
 
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/svcsock.h>
@@ -344,33 +345,57 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
 	return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
 }
 
+/**
+ * nfsd_copy_boot_verifier - Atomically copy a write verifier
+ * @verf: buffer in which to receive the verifier cookie
+ * @nn: NFS net namespace
+ *
+ * This function provides a wait-free mechanism for copying the
+ * namespace's boot verifier without tearing it.
+ */
 void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
 {
 	int seq = 0;
 
 	do {
-		read_seqbegin_or_lock(&nn->boot_lock, &seq);
-		/*
-		 * This is opaque to client, so no need to byte-swap. Use
-		 * __force to keep sparse happy. y2038 time_t overflow is
-		 * irrelevant in this usage
-		 */
-		verf[0] = (__force __be32)nn->nfssvc_boot.tv_sec;
-		verf[1] = (__force __be32)nn->nfssvc_boot.tv_nsec;
-	} while (need_seqretry(&nn->boot_lock, seq));
-	done_seqretry(&nn->boot_lock, seq);
+		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
+		memcpy(verf, nn->writeverf, sizeof(*verf));
+	} while (need_seqretry(&nn->writeverf_lock, seq));
+	done_seqretry(&nn->writeverf_lock, seq);
 }
 
 static void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
 {
-	ktime_get_raw_ts64(&nn->nfssvc_boot);
+	struct timespec64 now;
+	u64 verf;
+
+	/*
+	 * Because the time value is hashed, y2038 time_t overflow
+	 * is irrelevant in this usage.
+	 */
+	ktime_get_raw_ts64(&now);
+	verf = siphash_2u64(now.tv_sec, now.tv_nsec, &nn->siphash_key);
+	memcpy(nn->writeverf, &verf, sizeof(nn->writeverf));
 }
 
+/**
+ * nfsd_reset_boot_verifier - Generate a new boot verifier
+ * @nn: NFS net namespace
+ *
+ * This function updates the ->writeverf field of @nn. This field
+ * contains an opaque cookie that, according to Section 18.32.3 of
+ * RFC 8881, "the client can use to determine whether a server has
+ * changed instance state (e.g., server restart) between a call to
+ * WRITE and a subsequent call to either WRITE or COMMIT.  This
+ * cookie MUST be unchanged during a single instance of the NFSv4.1
+ * server and MUST be unique between instances of the NFSv4.1
+ * server."
+ */
 void nfsd_reset_boot_verifier(struct nfsd_net *nn)
 {
-	write_seqlock(&nn->boot_lock);
+	write_seqlock(&nn->writeverf_lock);
 	nfsd_reset_boot_verifier_locked(nn);
-	write_sequnlock(&nn->boot_lock);
+	write_sequnlock(&nn->writeverf_lock);
 }
 
 static int nfsd_startup_net(struct net *net, const struct cred *cred)

