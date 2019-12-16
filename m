Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C76121C78
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 23:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfLPWNZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 17:13:25 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42457 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLPWNZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 17:13:25 -0500
Received: by mail-yw1-f68.google.com with SMTP id x138so1122973ywd.9
        for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2019 14:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+jXCihMy6bUBGDVPdFb+21RKQoHcS3L891Ku9N4I3cY=;
        b=FRlZ5sxbHmzPKtZjuMu7bQEL7jBy0K1R4rHkPGiFMhtZGdhYyYDDvfZjw/FDCUe+nE
         7IMDlyy/c5PHeofY04PfMsgUrXA+c544at4yHphvO0XJC1BAdCLfQKeBPprLVecU18Qi
         9JpuVLS6EoAeCEIfm1BwkO3RKIETbDRWqTjxG0UrbKB89Ho9eBlzzTFQC31AXAfgSgmK
         sZx0EGuOstMKOBqSTF4Alm+2LxRfAFkRLs12L+KNDb4T41zTZv/OyzyXOP/l5MD4hb7z
         go7L2tHy1c1w4HYd+U3pZqw+Qx0sGhCAUCjheIbnu8E7DzIMA0R05n8bb5XTg4HQ/vdJ
         te7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+jXCihMy6bUBGDVPdFb+21RKQoHcS3L891Ku9N4I3cY=;
        b=tBd63ChuF+5fcmyq4t5sn3tfrmFVh6ynyQ3vASdwVRLpj0MnwYKTg548iUFathvxOT
         XuxsyAro9cRjRynygzt4wPLFcbKt+GeouNI6nvAiBk9ZMvHd9+zYeP04wLEY5IA122zX
         cRdZTKCuJfdpWyYRdym8oXswoWeZeDGdfsBkaI7lP9dY0AdDtZyk7l0H8918Rg4so7Nr
         aVY/G03nQCNyp8U3shsvJURZYbKVL2DK0OW8yyeVlioYtlR9hHLkAmGxQzxEG8kufRVQ
         nc1/p5fM5A7ITMqsO7B3KAp8hl2NiCsO0Om+G1Gp6iNelZiOjrCNv2/DZ5aQfZptbyom
         7PSQ==
X-Gm-Message-State: APjAAAWCuFEe48kwb0tjxVigjVCcbtrY48RtoFA0OM34+QzqU14fR74T
        Zqq/QaVYy9/bSnNs+G32QlCj4E7v
X-Google-Smtp-Source: APXvYqxWU9OoGx7qnfW+Uv0c3vpW85h8H216VdwI4HZLb+8+p5YF+4a6ODAcnAzJdkBLfcQt7evXhw==
X-Received: by 2002:a81:1292:: with SMTP id 140mr13897009yws.108.1576534404667;
        Mon, 16 Dec 2019 14:13:24 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id w138sm5487626ywd.89.2019.12.16.14.13.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Dec 2019 14:13:23 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.x recover from pre-mature loss of openstateid
Date:   Mon, 16 Dec 2019 17:13:04 -0500
Message-Id: <20191216221304.25782-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Ever since the commit 0e0cb35b417f, it's possible to lose an open stateid
while retrying a CLOSE due to ERR_OLD_STATEID. Once that happens,
operations that require openstateid fail with EAGAIN which is propagated
to the application then tests like generic/446 and generic/168 fail with
"Resource temporarily unavailable".

Instead of returning this error, initiate state recovery when possible to
recover the open stateid and then try calling nfs4_select_rw_stateid()
again.

Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c  | 3 +++
 fs/nfs/nfs4state.c | 2 +-
 fs/nfs/pnfs.c      | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d37161409a..66f9631ba012 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3239,6 +3239,8 @@ static int _nfs4_do_setattr(struct inode *inode,
 		nfs_put_lock_context(l_ctx);
 		if (status == -EIO)
 			return -EBADF;
+		else if (status)
+			goto out;
 	} else {
 zero_stateid:
 		nfs4_stateid_copy(&arg->stateid, &zero_stateid);
@@ -3251,6 +3253,7 @@ static int _nfs4_do_setattr(struct inode *inode,
 	put_cred(delegation_cred);
 	if (status == 0 && ctx != NULL)
 		renew_lease(server, timestamp);
+out:
 	trace_nfs4_setattr(inode, &arg->stateid, status);
 	return status;
 }
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 34552329233d..8686451893a6 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1064,7 +1064,7 @@ int nfs4_select_rw_stateid(struct nfs4_state *state,
 		 * choose to use.
 		 */
 		goto out;
-	ret = nfs4_copy_open_stateid(dst, state) ? 0 : -EAGAIN;
+	ret = nfs4_copy_open_stateid(dst, state) ? 0 : -NFS4ERR_BAD_STATEID;
 out:
 	if (nfs_server_capable(state->inode, NFS_CAP_STATEID_NFSV41))
 		dst->seqid = 0;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index cec3070ab577..11d646bbd2cb 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1998,7 +1998,7 @@ pnfs_update_layout(struct inode *ino,
 			trace_pnfs_update_layout(ino, pos, count,
 					iomode, lo, lseg,
 					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
-			if (status != -EAGAIN)
+			if (status != -EAGAIN && status != -NFS4ERR_BAD_STATEID)
 				goto out_unlock;
 			spin_unlock(&ino->i_lock);
 			nfs4_schedule_stateid_recovery(server, ctx->state);
-- 
2.18.1

