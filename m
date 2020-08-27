Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1D253E3F
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Aug 2020 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0Gzo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 02:55:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726123AbgH0Gzo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 27 Aug 2020 02:55:44 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DFD823B5D9A068DABFBF;
        Thu, 27 Aug 2020 14:55:41 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 14:55:40 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsd: don't call trace_nfsd_deleg_none() if read delegation is given
Date:   Thu, 27 Aug 2020 15:02:37 +0800
Message-ID: <20200827070237.19942-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Don't call trace_nfsd_deleg_none() if read delegation is given,
else two exclusive traces will be printed:

    nfsd_deleg_open: client 5f45b854:e6058001 stateid 00000030:00000001
    nfsd_deleg_none: client 5f45b854:e6058001 stateid 0000002f:00000001

Fix it by calling trace_nfsd_deleg_none() directly in appropriate
places instead of calling it by checking the value of op_delegate_type.

Also remove the unnecessary assignment "status = nfs_ok", because
we can ensure status will be nfs_ok after the call of
nfs4_inc_and_copy_stateid().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/nfsd/nfs4state.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c09a2a4281ec9..2e6376af701ff 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5131,6 +5131,8 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 	nfs4_put_stid(&dp->dl_stid);
 	return;
 out_no_deleg:
+	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
+
 	open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE;
 	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
 	    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
@@ -5232,7 +5234,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
 			open->op_why_no_deleg = WND4_NOT_WANTED;
-			goto nodeleg;
+			trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
+			goto out;
 		}
 	}
 
@@ -5241,9 +5244,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* OPEN succeeds even if we fail.
 	*/
 	nfs4_open_delegation(current_fh, open, stp);
-nodeleg:
-	status = nfs_ok;
-	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
 out:
 	/* 4.1 client trying to upgrade/downgrade delegation? */
 	if (open->op_delegate_type == NFS4_OPEN_DELEGATE_NONE && dp &&
-- 
2.25.0.4.g0ad7144999

