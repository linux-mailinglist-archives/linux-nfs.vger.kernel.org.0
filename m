Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978212BB2D9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 19:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgKTS0f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 13:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgKTS0f (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Nov 2020 13:26:35 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67702224C;
        Fri, 20 Nov 2020 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896794;
        bh=o44rxYz07qY5iicaWYINSD1h0xz85jFmVrcs/FkZ3Fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+zo2l5ZOB4HjwYEZaCNpb7w7RAlH8TN1043XUTV/1BuQ1tr6Ua7cM8z/DdLQ6wlF
         1/ofi0echZs+v98JCEjLkYZOaGepy49A2mgkeXq+Qm5oCaGl4WfKxTyqPFAXE4oKj9
         EPgHJreoOBKqQbAVRGB18z8GmMxHoVNxfoZ99QcU=
Date:   Fri, 20 Nov 2020 12:26:40 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 016/141] nfsd: Fix fall-through warnings for Clang
Message-ID: <0669408377bdc6ee87b214b2756465a6edc354fc.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding a couple of break statements instead of
just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/nfsctl.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d7f27ed6b794..cdab0d5be186 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3113,6 +3113,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_nolock;
 		}
 		new->cl_mach_cred = true;
+		break;
 	case SP4_NONE:
 		break;
 	default:				/* checked by xdr code */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f6d5d783f4a4..9a3bb1e217f9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1165,6 +1165,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_fop = &simple_dir_operations;
 		inode->i_op = &simple_dir_inode_operations;
 		inc_nlink(inode);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

