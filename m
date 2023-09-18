Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52D7A4BFF
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbjIRPYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbjIRPYR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:24:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE0FD
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D0C116A5;
        Mon, 18 Sep 2023 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045511;
        bh=i63og+Oy8QoX7wqXUkTyTGKqBSbru6EW6mxAYEBZppk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qx3jSaHPnrVbZmfzB32gcDwI/XvQQHg/Y26K6ZGLEeyxWIJKP90dAUPpHJ+S5Go8z
         FY3aS4vJgQu7t3NaiL4ta8BmxVbh9dWrnqwXAx2UCkcnsSJdbggX2SdJs44NobHdrn
         vIRSim2Li65wTpOoT0XmbM9yrtpww9OhXqicuHzM/9zShVGVu393AQN2nEJkiCkSGD
         t4IVeGqrlRCKIlCXTt+Xltroxm8mVNGCDa6fI5gHxu6QbxbGPJ6LKn7rty1/CUT+U3
         Ihdd0GIJaq1lbNWGcaldEPsti8iUrc5uukMO/BaodvpcAh/NKeWAdpkJ8TtUXjAfXH
         k/+6wLuzjKxfA==
Subject: [PATCH v1 16/52] NFSD: Add nfsd4_encode_nfsace4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:30 -0400
Message-ID: <169504551010.133720.3074976241793989767.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor the ACE encoding helper so that it can eventually be reused
for encoding OPEN results that contain delegation ACEs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   36 +++++++++++++++++++++---------------
 fs/nfsd/xdr4.h    |    3 +++
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6604763bd96c..89d3b276a494 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2783,16 +2783,29 @@ static __be32 nfsd4_encode_fs_locations(struct xdr_stream *xdr,
 	return 0;
 }
 
-static inline __be32
-nfsd4_encode_aclname(struct xdr_stream *xdr, struct svc_rqst *rqstp,
-		     struct nfs4_ace *ace)
+static __be32 nfsd4_encode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqstp,
+				   struct nfs4_ace *ace)
 {
+	__be32 status;
+
+	/* type */
+	status = nfsd4_encode_acetype4(xdr, ace->type);
+	if (status != nfs_ok)
+		return nfserr_resource;
+	/* flag */
+	status = nfsd4_encode_aceflag4(xdr, ace->flag);
+	if (status != nfs_ok)
+		return nfserr_resource;
+	/* access mask */
+	status = nfsd4_encode_acemask4(xdr, ace->access_mask & NFS4_ACE_MASK_ALL);
+	if (status != nfs_ok)
+		return nfserr_resource;
+	/* who */
 	if (ace->whotype != NFS4_ACL_WHO_NAMED)
 		return nfs4_acl_write_who(xdr, ace->whotype);
-	else if (ace->flag & NFS4_ACE_IDENTIFIER_GROUP)
+	if (ace->flag & NFS4_ACE_IDENTIFIER_GROUP)
 		return nfsd4_encode_group(xdr, rqstp, ace->who_gid);
-	else
-		return nfsd4_encode_user(xdr, rqstp, ace->who_uid);
+	return nfsd4_encode_user(xdr, rqstp, ace->who_uid);
 }
 
 static inline __be32
@@ -3288,15 +3301,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		*p++ = cpu_to_be32(args.acl->naces);
 
 		for (ace = args.acl->aces; ace < args.acl->aces + args.acl->naces; ace++) {
-			p = xdr_reserve_space(xdr, 4*3);
-			if (!p)
-				goto out_resource;
-			*p++ = cpu_to_be32(ace->type);
-			*p++ = cpu_to_be32(ace->flag);
-			*p++ = cpu_to_be32(ace->access_mask &
-							NFS4_ACE_MASK_ALL);
-			status = nfsd4_encode_aclname(xdr, rqstp, ace);
-			if (status)
+			status = nfsd4_encode_nfsace4(xdr, args.rqstp, ace);
+			if (status != nfs_ok)
 				goto out;
 		}
 	}
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 488ecdacc4c6..f0866a55fd91 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -90,6 +90,9 @@ nfsd4_encode_uint32_t(struct xdr_stream *xdr, u32 val)
 	return nfs_ok;
 }
 
+#define nfsd4_encode_aceflag4(x, v)	nfsd4_encode_uint32_t(x, v)
+#define nfsd4_encode_acemask4(x, v)	nfsd4_encode_uint32_t(x, v)
+#define nfsd4_encode_acetype4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_nfs_lease4(x, v)	nfsd4_encode_uint32_t(x, v)
 
 /**


