Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F590A5BAC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Sep 2019 19:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfIBRG2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Sep 2019 13:06:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37164 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfIBRG2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Sep 2019 13:06:28 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so15074104iop.4
        for <linux-nfs@vger.kernel.org>; Mon, 02 Sep 2019 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvuAQX80ApjXEKs6gpQsSKgCH/ycoY0ktnhdV2EAR0Y=;
        b=Q68KP2C/1HHj3Q2M1b7JC8hwlJCywjk7JjUhcssgkmkSttgw0CDarePHYkgfMeNi11
         4Nbiduu++AXn4lFFThsWE/wFeaYPKMzXNQFyU3gI73kpa/LviaDB6MR07s+ckJUtfbsa
         VUsG3wY2dqAHkWjt96xcal1QFKujqA6829fODuy/nJwaaKtUCsmVbTNXM/Js0iKWyBqQ
         iSBmtiJU+DGD5gBby+xFdCrVN8r17Xc+R22HkTHGEQMLhZJfoRxQ2HGMrviAsQE992Wi
         tAxpTnosjcXVFTy5nLKjLTI+GnJnIFKIq6ZPLNMQ94t08POS3IsSDK1796TbE6DEysDM
         ZOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvuAQX80ApjXEKs6gpQsSKgCH/ycoY0ktnhdV2EAR0Y=;
        b=PuBUOBwD9jDB52TLebSXLE8C0UCwHjU0qUdJOWu1vXXJontlrqShIF9PF4I1YoLEAS
         7VdfxGtV4O/860gOxBxbIrhZe8xAJjPiABzb3M+oilmaal85tMvTdz9ji3H3woj5drbP
         EWtH+4btA4nYB0y0NfUku/3HBOWxGuP7gBLlCRjUYWc2zkkIsMomcXSsBkgbFoeHMMWO
         qylcfR/820taR8q8+CLrnDy3qgYk9DqeOcoxfNskdo7NPv7e6NfwQG2WIOrtHFmh8rKV
         9NIRCuNDxBxeytIv6kJ+TllgE3791KQ0Rdw/L5chjySC3qfNUyzD3Q+pwuoocwoTENsF
         JWmA==
X-Gm-Message-State: APjAAAUaAvKS1btmAM1EkJ5+/bMWr5l2riyckgst+IhrGHRYVZuAUWkf
        jMND9b7laODpyS+PcnOYFXXYtEWb5Q==
X-Google-Smtp-Source: APXvYqzRdMQE13nI0kDE0VY1ZCn+C6pn+oUDTG/X8hE687n6Ii7+OVGuN6wGVwvX78XPudY25k6Tew==
X-Received: by 2002:a5d:9c0b:: with SMTP id 11mr557932ioe.192.1567443986954;
        Mon, 02 Sep 2019 10:06:26 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o3sm7655322iob.64.2019.09.02.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 10:06:26 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J.Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/4] nfsd: Support the server resetting the boot verifier
Date:   Mon,  2 Sep 2019 13:02:56 -0400
Message-Id: <20190902170258.92522-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902170258.92522-2-trond.myklebust@hammerspace.com>
References: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
 <20190902170258.92522-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add support to allow the server to reset the boot verifier in order to
force clients to resend I/O after a timeout failure.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
---
 fs/nfsd/netns.h    |  4 ++++
 fs/nfsd/nfs3xdr.c  | 13 +++++++++----
 fs/nfsd/nfs4proc.c | 14 ++++----------
 fs/nfsd/nfsctl.c   |  1 +
 fs/nfsd/nfssvc.c   | 31 ++++++++++++++++++++++++++++++-
 5 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index bdfe5bcb3dcd..9a4ef815fb8c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -104,6 +104,7 @@ struct nfsd_net {
 
 	/* Time of server startup */
 	struct timespec64 nfssvc_boot;
+	seqlock_t boot_lock;
 
 	/*
 	 * Max number of connections this nfsd container will allow. Defaults
@@ -179,4 +180,7 @@ struct nfsd_net {
 extern void nfsd_netns_free_versions(struct nfsd_net *nn);
 
 extern unsigned int nfsd_net_id;
+
+void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn);
+void nfsd_reset_boot_verifier(struct nfsd_net *nn);
 #endif /* __NFSD_NETNS_H__ */
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index fcf31822c74c..86e5658651f1 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -27,6 +27,7 @@ static u32	nfs3_ftypes[] = {
 	NF3SOCK, NF3BAD,  NF3LNK, NF3BAD,
 };
 
+
 /*
  * XDR functions for basic NFS types
  */
@@ -751,14 +752,16 @@ nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	__be32 verf[2];
 
 	p = encode_wcc_data(rqstp, p, &resp->fh);
 	if (resp->status == 0) {
 		*p++ = htonl(resp->count);
 		*p++ = htonl(resp->committed);
 		/* unique identifier, y2038 overflow can be ignored */
-		*p++ = htonl((u32)nn->nfssvc_boot.tv_sec);
-		*p++ = htonl(nn->nfssvc_boot.tv_nsec);
+		nfsd_copy_boot_verifier(verf, nn);
+		*p++ = verf[0];
+		*p++ = verf[1];
 	}
 	return xdr_ressize_check(rqstp, p);
 }
@@ -1125,13 +1128,15 @@ nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	__be32 verf[2];
 
 	p = encode_wcc_data(rqstp, p, &resp->fh);
 	/* Write verifier */
 	if (resp->status == 0) {
 		/* unique identifier, y2038 overflow can be ignored */
-		*p++ = htonl((u32)nn->nfssvc_boot.tv_sec);
-		*p++ = htonl(nn->nfssvc_boot.tv_nsec);
+		nfsd_copy_boot_verifier(verf, nn);
+		*p++ = verf[0];
+		*p++ = verf[1];
 	}
 	return xdr_ressize_check(rqstp, p);
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index cb51893ec1cd..4e3e77b76411 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -568,17 +568,11 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 static void gen_boot_verifier(nfs4_verifier *verifier, struct net *net)
 {
-	__be32 verf[2];
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	__be32 *verf = (__be32 *)verifier->data;
 
-	/*
-	 * This is opaque to client, so no need to byte-swap. Use
-	 * __force to keep sparse happy. y2038 time_t overflow is
-	 * irrelevant in this usage.
-	 */
-	verf[0] = (__force __be32)nn->nfssvc_boot.tv_sec;
-	verf[1] = (__force __be32)nn->nfssvc_boot.tv_nsec;
-	memcpy(verifier->data, verf, sizeof(verifier->data));
+	BUILD_BUG_ON(2*sizeof(*verf) != sizeof(verifier->data));
+
+	nfsd_copy_boot_verifier(verf, net_generic(net, nfsd_net_id));
 }
 
 static __be32
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3cf4f6aa48d6..33cbe2e5d937 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1477,6 +1477,7 @@ static __net_init int nfsd_init_net(struct net *net)
 
 	atomic_set(&nn->ntf_refcnt, 0);
 	init_waitqueue_head(&nn->ntf_wq);
+	seqlock_init(&nn->boot_lock);
 
 	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
 	if (IS_ERR(mnt)) {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b944553c6927..3caaf5675259 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -344,6 +344,35 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
 	return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
 }
 
+void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
+{
+	int seq = 0;
+
+	do {
+		read_seqbegin_or_lock(&nn->boot_lock, &seq);
+		/*
+		 * This is opaque to client, so no need to byte-swap. Use
+		 * __force to keep sparse happy. y2038 time_t overflow is
+		 * irrelevant in this usage
+		 */
+		verf[0] = (__force __be32)nn->nfssvc_boot.tv_sec;
+		verf[1] = (__force __be32)nn->nfssvc_boot.tv_nsec;
+	} while (need_seqretry(&nn->boot_lock, seq));
+	done_seqretry(&nn->boot_lock, seq);
+}
+
+void nfsd_reset_boot_verifier_locked(struct nfsd_net *nn)
+{
+	ktime_get_real_ts64(&nn->nfssvc_boot);
+}
+
+void nfsd_reset_boot_verifier(struct nfsd_net *nn)
+{
+	write_seqlock(&nn->boot_lock);
+	nfsd_reset_boot_verifier_locked(nn);
+	write_sequnlock(&nn->boot_lock);
+}
+
 static int nfsd_startup_net(int nrservs, struct net *net, const struct cred *cred)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -596,7 +625,7 @@ int nfsd_create_serv(struct net *net)
 #endif
 	}
 	atomic_inc(&nn->ntf_refcnt);
-	ktime_get_real_ts64(&nn->nfssvc_boot); /* record boot time */
+	nfsd_reset_boot_verifier(nn);
 	return 0;
 }
 
-- 
2.21.0

