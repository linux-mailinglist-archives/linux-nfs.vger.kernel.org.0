Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9B46877
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFNUAZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32953 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNUAZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:25 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so8491154iop.0
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROsyrUrzMQt/Oc+LCfDJWUL1BbL0jN8hgvBqttV5vxg=;
        b=Xfb1750zfXF53LNhlin25ggqMNUv9dalTUUThc6uV9VM4+lRlblcZ1rV/8DcIqaGJM
         H/PKcjnv+wF2u3TX6rv8sMnceKZvHEdQwe+BBZuG/cKUR5WwPlymsA54HFhrB4KLmVwL
         zH37gAALlPnHYI2C+VhIwoR2Q2La5DvSuWw1oRLnGORbeho01aFMVspWNDhsWQBHClw1
         i1fqUH0nwS36Ud7nGnI4IE2fnKiaEL9w8w0hUGp24CJsghsl3LGweoTs2b4ADN8qgDBU
         TycLPEEvrjKv5yARvkcq6vkN6by19ootkZbj62MCl61I7AhTo1yEQ1MLLk2cAplxVoQH
         SdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROsyrUrzMQt/Oc+LCfDJWUL1BbL0jN8hgvBqttV5vxg=;
        b=ZeNE3qhmXpTxDbhGk9Fg9EG0EG/ftXphXLJKukxFTKnADiPy/aw5WpP1In33rQheBI
         5tjj9vAfLgrF12Ds8k9dSo4pcnAx3G7+WP9BGd/Th1a2m3yvMAGScX9z6oi7OioYUfTK
         xllCsQH3fMHsPal0z9vwYI08l7yf0yGPzt5Bng7q9wk8jVtT3dW+eBlELgpTrO7AwEtL
         3TvG491k16y/nh1RxSXGz6JyL3qKkFNjNXIl2evlj/4HDaLPwhKWMAD7g5r2eQ2ROI8c
         eDqs4Cm+sMj1mMa/B0JxDtqyxlrDsTp1hhM3pvJ2qot/cCyIlBKz9fWizX4I9W4k/RvJ
         Zg3g==
X-Gm-Message-State: APjAAAV0xtRDA37KfRUNUdzsVEbJJBLG61bnS4v3mpoj3aG067DDz4eG
        4bi8oQynRL+fj+QWBkn6jGY=
X-Google-Smtp-Source: APXvYqwwyLZvLPT+hL1wgZNG60iyrDyoH9iNGXVV5wx1tTcjHSA7EfmF1qoeD2EI9oJ1X5u5waHnqw==
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr56125775jai.39.1560542424276;
        Fri, 14 Jun 2019 13:00:24 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:23 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 06/11] NFS: skip recovery of copy open on dest server
Date:   Fri, 14 Jun 2019 16:00:11 -0400
Message-Id: <20190614200016.12348-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
References: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Mark the open created for the source file on the destination
server. Then if this open is going thru a recovery, then fail
the recovery as we don't need to be recoving a "fake" open.
We need to fail the ongoing READs and vfs_copy_file_range().

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4_fs.h   |  1 +
 fs/nfs/nfs4file.c  |  1 +
 fs/nfs/nfs4state.c | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index ff1cd60..d49fc19 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -168,6 +168,7 @@ enum {
 	NFS_STATE_CHANGE_WAIT,		/* A state changing operation is outstanding */
 #ifdef CONFIG_NFS_V4_2
 	NFS_CLNT_DST_SSC_COPY_STATE,    /* dst server open state on client*/
+	NFS_SRV_SSC_COPY_STATE,		/* ssc state on the dst server */
 #endif /* CONFIG_NFS_V4_2 */
 };
 
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index aab4d48..5ef3c12 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -348,6 +348,7 @@ struct file *
 	if (ctx->state == NULL)
 		goto out_stateowner;
 
+	set_bit(NFS_SRV_SSC_COPY_STATE, &ctx->state->flags);
 	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 	memcpy(&ctx->state->open_stateid.other, &stateid->other,
 	       NFS4_STATEID_OTHER_SIZE);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index e2e3c4f..045af56 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1607,6 +1607,9 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 {
 	struct nfs4_state *state;
 	int status = 0;
+#ifdef CONFIG_NFS_V4_2
+	bool found_ssc_copy_state = false;
+#endif /* CONFIG_NFS_V4_2 */
 
 	/* Note: we rely on the sp->so_states list being ordered 
 	 * so that we always reclaim open(O_RDWR) and/or open(O_WRITE)
@@ -1626,6 +1629,13 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 			continue;
 		if (state->state == 0)
 			continue;
+#ifdef CONFIG_NFS_V4_2
+		if (test_bit(NFS_SRV_SSC_COPY_STATE, &state->flags)) {
+			nfs4_state_mark_recovery_failed(state, -EIO);
+			found_ssc_copy_state = true;
+			continue;
+		}
+#endif /* CONFIG_NFS_V4_2 */
 		refcount_inc(&state->count);
 		spin_unlock(&sp->so_lock);
 		status = __nfs4_reclaim_open_state(sp, state, ops);
@@ -1672,6 +1682,10 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 	}
 	raw_write_seqcount_end(&sp->so_reclaim_seqcount);
 	spin_unlock(&sp->so_lock);
+#ifdef CONFIG_NFS_V4_2
+	if (found_ssc_copy_state)
+		return -EIO;
+#endif /* CONFIG_NFS_V4_2 */
 	return 0;
 out_err:
 	nfs4_put_open_state(state);
-- 
1.8.3.1

