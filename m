Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE52554B5
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH1G4F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Aug 2020 02:56:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgH1G4E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 28 Aug 2020 02:56:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 463806935457D326170D;
        Fri, 28 Aug 2020 14:56:02 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 14:55:58 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] nfsd: rename delegation related tracepoints to make them less confusing
Date:   Fri, 28 Aug 2020 15:02:55 +0800
Message-ID: <20200828070255.141460-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
In-Reply-To: <6F61F417-95DA-4CD7-A81A-FA8C6299CF40@oracle.com>
References: <6F61F417-95DA-4CD7-A81A-FA8C6299CF40@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now when a read delegation is given, two delegation related traces
will be printed:

    nfsd_deleg_open: client 5f45b854:e6058001 stateid 00000030:00000001
    nfsd_deleg_none: client 5f45b854:e6058001 stateid 0000002f:00000001

Although the intention is to let developers know two stateid are
returned, the traces are confusing about whether or not a read delegation
is handled out. So renaming trace_nfsd_deleg_none() to trace_nfsd_open()
and trace_nfsd_deleg_open() to trace_nfsd_deleg_read() to make
the intension clearer.

The patched traces will be:

    nfsd_deleg_read: client 5f48a967:b55b21cd stateid 00000003:00000001
    nfsd_open: client 5f48a967:b55b21cd stateid 00000002:00000001

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
v1: https://marc.info/?l=linux-nfs&m=159851134513236&w=2

 fs/nfsd/nfs4state.c | 4 ++--
 fs/nfsd/trace.h     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c09a2a4281ec9..0525acfe31314 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5126,7 +5126,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
-	trace_nfsd_deleg_open(&dp->dl_stid.sc_stateid);
+	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
 	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
 	nfs4_put_stid(&dp->dl_stid);
 	return;
@@ -5243,7 +5243,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	nfs4_open_delegation(current_fh, open, stp);
 nodeleg:
 	status = nfs_ok;
-	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
+	trace_nfsd_open(&stp->st_stid.sc_stateid);
 out:
 	/* 4.1 client trying to upgrade/downgrade delegation? */
 	if (open->op_delegate_type == NFS4_OPEN_DELEGATE_NONE && dp &&
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1861db1bdc670..99bf07800cd09 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -289,8 +289,8 @@ DEFINE_STATEID_EVENT(layout_recall_done);
 DEFINE_STATEID_EVENT(layout_recall_fail);
 DEFINE_STATEID_EVENT(layout_recall_release);
 
-DEFINE_STATEID_EVENT(deleg_open);
-DEFINE_STATEID_EVENT(deleg_none);
+DEFINE_STATEID_EVENT(open);
+DEFINE_STATEID_EVENT(deleg_read);
 DEFINE_STATEID_EVENT(deleg_break);
 DEFINE_STATEID_EVENT(deleg_recall);
 
-- 
2.25.0.4.g0ad7144999

