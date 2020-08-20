Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB224AD1B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 04:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHTC6c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Aug 2020 22:58:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTC6b (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 Aug 2020 22:58:31 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0188A24B8655BD6CAFB;
        Thu, 20 Aug 2020 10:58:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 10:58:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] nfsd: Convert to use the preferred fallthrough macro
Date:   Wed, 19 Aug 2020 22:57:18 -0400
Message-ID: <20200820025718.51244-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro. Please see
commit 294f69e662d1 ("compiler_attributes.h: Add 'fallthrough' pseudo
keyword for switch/case use") for detail.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/nfsd/nfs4callback.c | 2 +-
 fs/nfsd/nfs4proc.c     | 2 +-
 fs/nfsd/nfs4state.c    | 2 +-
 fs/nfsd/nfsfh.c        | 2 +-
 fs/nfsd/vfs.c          | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 7fbe9840a03e..052be5bf9ef5 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1119,7 +1119,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		break;
 	case -ESERVERFAULT:
 		++session->se_cb_seq_nr;
-		/* Fall through */
+		fallthrough;
 	case 1:
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a527da3d8052..eaf50eafa935 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -428,7 +428,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				goto out;
 			open->op_openowner->oo_flags |= NFS4_OO_CONFIRMED;
 			reclaim = true;
-			/* fall through */
+			fallthrough;
 		case NFS4_OPEN_CLAIM_FH:
 		case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
 			status = do_open_fhandle(rqstp, cstate, open);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 81ed8e8bab3f..2f77f4b66cbc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3117,7 +3117,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		break;
 	default:				/* checked by xdr code */
 		WARN_ON_ONCE(1);
-		/* fall through */
+		fallthrough;
 	case SP4_SSV:
 		status = nfserr_encr_alg_unsupp;
 		goto out_nolock;
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 37bc8f5f4514..a0a8d27539ae 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -469,7 +469,7 @@ static bool fsid_type_ok_for_exp(u8 fsid_type, struct svc_export *exp)
 	case FSID_UUID16:
 		if (!is_root_export(exp))
 			return false;
-		/* fall through */
+		fallthrough;
 	case FSID_UUID4_INUM:
 	case FSID_UUID16_INUM:
 		return exp->ex_uuid != NULL;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7d2933b85b65..aba5af9df328 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1456,7 +1456,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 					*created = true;
 				break;
 			}
-			/* fall through */
+			fallthrough;
 		case NFS4_CREATE_EXCLUSIVE4_1:
 			if (   d_inode(dchild)->i_mtime.tv_sec == v_mtime
 			    && d_inode(dchild)->i_atime.tv_sec == v_atime
@@ -1465,7 +1465,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 					*created = true;
 				goto set_attr;
 			}
-			/* fall through */
+			fallthrough;
 		case NFS3_CREATE_GUARDED:
 			err = nfserr_exist;
 		}
-- 
2.19.1

