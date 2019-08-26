Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1279D485
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfHZQxu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 12:53:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40960 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfHZQxu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 12:53:50 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so38911879ioj.8
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74foLEL2Ws3Y+skSR9G/Et8RwoK4+ZlfQg9flyPMOkI=;
        b=Wgb2JMulDnlHP15m+tWAiEpNnAo3gFxTz2rCGepdQbtU6NrHCVgpBXNNi0CWySLEXB
         ig59LkjuUpaJZASX8JhGdbXHQwrtBTIutubxtawII4MY+tIQYUtJ6r14M+ky/ZsCbo7E
         zPmzVw6wvsL7+qD/GSvJMz4X+eHXG3RLmu2gFHHePaX8LnX2xlgBwMEgpC+yXjfuEz8n
         ExnFSK7a/8bG5rRhHkao0RtvRKwnFa5UqKuCUP1JQCvQdTa+cWdxj6bN8TyJgQRl3ON0
         Ye+PxwOWGE43EA8fenoBGUGYanEGmcEejoZ+YpiqpLcboWztIKlXf0PoxRTa6gQ3zq4R
         MIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74foLEL2Ws3Y+skSR9G/Et8RwoK4+ZlfQg9flyPMOkI=;
        b=YzMHnyf/zC2fzpEQkUe6opY/xoymg8N2btCwAe4EOAO2kGPD69dlLivTyyw52Wj58Y
         F3SCbCYDh07srLdelE4M1o1Ab0HsKWXSl5ioZI3W+7o/6nD/OBEVXjUYmq2ShVd2Szp2
         Nd2N729NNWdYBxuOPywx44MwSWRb2oCJX95arI7u5yelzV+aj82vEHxYLHINUo2tAEnU
         ea2cy+MUADq+7YGNDLkrp6OPXg+KqTB5ZO16ELroBQ4KhOBMFJXQAukaCM1kB4tR4TNj
         qC4xv+Zsxlimtp16lENUXB1cJV5HGF8I7/nFngbG9R3nPFrzn0mBmcNcmoaihNVnvrHa
         XdhQ==
X-Gm-Message-State: APjAAAWlfj+jJOyQ/id6YB+vGQe04WH5cbSiOC5zx7+tbtdRwujtqqkP
        rDPKaqTFQxdtIwdSPPkh/QERYyAN/w==
X-Google-Smtp-Source: APXvYqw1SvZd71Szl099J3Xvt5plV1SRLu8/Xvv5QAug9VI1T04uKPH14R28gtFPZ699CM/6WtlZeg==
X-Received: by 2002:a05:6638:348:: with SMTP id x8mr18908688jap.31.1566838429522;
        Mon, 26 Aug 2019 09:53:49 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u24sm10613490iot.38.2019.08.26.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 09:53:49 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] nfsd: Support the server resetting the boot verifier
Date:   Mon, 26 Aug 2019 12:50:20 -0400
Message-Id: <20190826165021.81075-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190826165021.81075-2-trond.myklebust@hammerspace.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826165021.81075-2-trond.myklebust@hammerspace.com>
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
index 13c548733860..c3ac1e000c4a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1478,6 +1478,7 @@ static __net_init int nfsd_init_net(struct net *net)
 
 	atomic_set(&nn->ntf_refcnt, 0);
 	init_waitqueue_head(&nn->ntf_wq);
+	seqlock_init(&nn->boot_lock);
 
 	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
 	if (IS_ERR(mnt)) {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b944553c6927..a597fc34bc40 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -344,6 +344,35 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
 	return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
 }
 
+void nfsd_copy_boot_verifier(__be32 verf[2], struct nfsd_net *nn)
+{
+	int seq;
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

