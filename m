Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF2437B90
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhJVRNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhJVRNf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A90C061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id r15so5201323qkp.8
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7178+k9HGwpv06ui7KmehzZMIDhQrwDptPJIvqT4zWc=;
        b=KQLWQ0QnUw4YyOdFoFN2GlcQid3A98e/oQB7CialyZZUtaZusxRpR0iVd4avvj4zkq
         f4P4K88JnZdBkYTCjwHHdqIobdxITnw97Yg93antekKLQO6XmUB5kQhXwYNqPjDUIfkE
         OO3R6NNwV9UuuLeDGe3NwmKISjH3SqmVWHv6pujJMlm/JXKx1lFQnTYWeY2ZXJmbhsJc
         EGEBgitMEcKXWIQCdYVqpd+qckmawspRTqo7wQq0DtNqIq+lVBaifjo913jjZxvJ4DGS
         qC1XPTZWkPlAt1jvwhwKAzkCb90pn0HmC9wqghIXUvbvlxhDFcaHKKJYc5M+GvMxZZ/w
         QEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7178+k9HGwpv06ui7KmehzZMIDhQrwDptPJIvqT4zWc=;
        b=FEdjNsVmhDESHcLTGZpR6uIZt+3Tzhn4QHOmVaeV672/MJCkOsEM46X3jl0GfATg3W
         WFCTxOFnbYd7aubY3nwjh1es+2FY4vQ/SKc3pgHWOuy7Bdyvnqrz+bmB1pFIr16qclVD
         4YipuiKBgJUpYyk/b5EaNjK/Xkp/ipPhl/q1BCXvjUBs2WLF6CU3B9ubmfgjXFJ91XZg
         KDBU3O1ce1MIQlpi08MTL2gAPhC6MLvila/4F0ReBS50DZqB9Hf5ui+L6qf7oDKbziM6
         5DJv4p+NxyzOXymjCpxxxriF8LMKnm85sTvjqAOMJvls2bUPQk6bz1+eZtxM+sDTpNTD
         5jCQ==
X-Gm-Message-State: AOAM532yNapGa81fUPG3SHEgjPt3/qzRwgENjFPCxQi/U+0a8dx21KGT
        XGmK5dznOfOzCjH7nm1sQwU=
X-Google-Smtp-Source: ABdhPJzqIFW8on3+TtJBsESumV2sjoqSsB+omlqLFiK4JzUasPGWckCdSc8Cj2JVwaN35YdEsvCobg==
X-Received: by 2002:a37:b13:: with SMTP id 19mr1099507qkl.430.1634922676854;
        Fri, 22 Oct 2021 10:11:16 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:16 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 04/14] NFS: Remove the nfs4_label from the nfs4_link_res struct
Date:   Fri, 22 Oct 2021 13:11:03 -0400
Message-Id: <20211022171113.16739-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
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
2.33.1

