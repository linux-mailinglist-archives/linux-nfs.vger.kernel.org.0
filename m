Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE86405DE8
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhIIUOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhIIUOl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D1DC06175F
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:31 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t4so3247045qkb.9
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2utUcaXAd/i/w9V0u3PglG1Wj0eW6eEYlOzXf46pLKk=;
        b=PNOdwT1jtwXkpQHFi8GzjvxGr83M7WEFKtafLmB1kpgi6dp5vxhXCtzqBiAuDlP/3x
         5BuwdJQM2O9mp+MVQZiAMBPgBUHOrLky+fRr4oQFkMzNoN3KXLhI3c8U1btUC+frN66r
         uZQlPqth2VNj0SRIdeM5hoDu5g4ZdPrSS9kO5hUiwqD+mSkBPNcRWijhprg7YmTRQwZs
         H8qh1YOqvkiRjm1k5oc7y2f1aM7ks1u5Tz9ukAdB9k2SJYz1GqMsewnWJIuR3vtxQy5q
         EQ+R9ujLX2RTOIMy1R2WzoxsmzwMDAvg2paliP0Yd0wFEdMqvoZkS1kMALNHfJglpSDF
         /b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2utUcaXAd/i/w9V0u3PglG1Wj0eW6eEYlOzXf46pLKk=;
        b=aN39EF6NK86msiRO784DbrMfPG11FWGwkRCFA8s3HDTRnf9BTGUJZ+IQkCdvr8nbe2
         fok73sM8JEOrqGG1X+wVZcQLVyvXysoPISJZJMeL1wp87Rk8r+hYDi6o1zWfQKrf8WTa
         9V0XwtHc5a56/WVLAgjTT4gXv078gDnTlmEQkHrguVHhxeByjMTfVe95D1jBfsHsIa/s
         1W3NsJ65TcAQzZsvhVSTkt3h8bLY+gyUr16tvSte/qTtp1Aaiabhcba16Hj/k6rrDbrS
         Qrpg6T6O5nRtEUWKHVrrufdsr16wxinMSRpNl1u6xo5AoNQbL5VXPBBdRc2hSck75eU1
         bZXQ==
X-Gm-Message-State: AOAM532yj7gVp+i0FvKfTPhEKrdjvPOgkb5ZN4ukFn9q9caYMynMEAc4
        gEoNGvttOQN1WWbWm+isZLpDDk2p0RY=
X-Google-Smtp-Source: ABdhPJw7XFzqzMAhM0LOV8RdyXL600jJhqpNozFgan+c4Zys425aBt5rfeCcvvBgMx5yFqP90lWMHg==
X-Received: by 2002:ae9:f701:: with SMTP id s1mr4621353qkg.223.1631218410861;
        Thu, 09 Sep 2021 13:13:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:30 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 04/14] NFS: Remove the nfs4_label from the nfs4_link_res struct
Date:   Thu,  9 Sep 2021 16:13:17 -0400
Message-Id: <20210909201327.108759-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Again, use the fattr's label field instead.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c       | 16 +++-------------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  1 -
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 06569a35a6df..fed15eafc03b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4791,7 +4791,6 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 	};
 	struct nfs4_link_res res = {
 		.server = server,
-		.label = NULL,
 	};
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_LINK],
@@ -4800,18 +4799,12 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 	};
 	int status = -ENOMEM;
 
-	res.fattr = nfs_alloc_fattr();
+	res.fattr = nfs_alloc_fattr_with_label(server);
 	if (res.fattr == NULL)
 		goto out;
 
-	res.label = nfs4_label_alloc(server, GFP_KERNEL);
-	if (IS_ERR(res.label)) {
-		status = PTR_ERR(res.label);
-		goto out;
-	}
-
 	nfs4_inode_make_writeable(inode);
-	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.label), inode,
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.fattr->label), inode,
 				NFS_INO_INVALID_CHANGE);
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
@@ -4820,12 +4813,9 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 		nfs4_inc_nlink(inode);
 		status = nfs_post_op_update_inode(inode, res.fattr);
 		if (!status)
-			nfs_setsecurity(inode, res.fattr, res.label);
+			nfs_setsecurity(inode, res.fattr, res.fattr->label);
 	}
 
-
-	nfs4_label_free(res.label);
-
 out:
 	nfs_free_fattr(res.fattr);
 	return status;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 98594a97529d..4ce6d2430ff1 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6331,7 +6331,7 @@ static int nfs4_xdr_dec_link(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_restorefh(xdr);
 	if (status)
 		goto out;
-	decode_getfattr_label(xdr, res->fattr, res->label, res->server);
+	decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
 out:
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 5aba81b74c98..d55bf3fd5167 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1079,7 +1079,6 @@ struct nfs4_link_res {
 	struct nfs4_sequence_res	seq_res;
 	const struct nfs_server *	server;
 	struct nfs_fattr *		fattr;
-	struct nfs4_label		*label;
 	struct nfs4_change_info		cinfo;
 	struct nfs_fattr *		dir_attr;
 };
-- 
2.33.0

