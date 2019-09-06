Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71FAC32F
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393111AbfIFXgT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36783 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbfIFXgT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:19 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so16657318iof.3
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3xKBrZ1qMgxUVyHn2ZV7MzAjOrnrqMeI7u8Lz+bojyo=;
        b=CH7izRm5CvLvr53OF/w65MYzMqHZxvO9DvE+hjSbCEdq01m/IoIeMTN3EOJj+nVEzD
         o0L3pzPX7q8bEBOjEutVKIsPgSjx84x6NenQEJGWwmc0r1nGmmct3a7jn/UkCJGjZ8vQ
         CscKyaNzKNN5vUPw4/+b7oy1HO7bvtHavo1wIBGbthQ2fFRDrvXC8H0vpWKK9EeO7UIH
         Vw+wzaSjrLT45hfJ+o1GZMR3iuy1F4kCcVh+n2TUVSFXBWuB0qgy0ogUeFBB9Zp2u0Gd
         427R6FG8873tVlMPYVEfUCmtJd10JiHah3pMeV/kGq46kt4l0OumbGgrGObmLZjdsBU9
         nsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xKBrZ1qMgxUVyHn2ZV7MzAjOrnrqMeI7u8Lz+bojyo=;
        b=hT5wdnkOTFNJe9mr0fYYz3GUN5weS95y2d2OEBLmIm75+r12j7vomOewhkzh49kAmo
         D+amckoZRI2zTv209mVGVaA+ym46qKCNDdv45RI5cK62HpUSKWq3OV5EMPKuRcfj/pmT
         vjahiVMOyjTVn8rd9Zul5f9eOPzNHdU+kFgs8ME2bq77NaFn9z2FwOonMtUTTxjF8NVZ
         U42sIHxhzpX6ko6K9GhcWXHzMjKWidrDmtorn6ushMcKwZEkbL9/C0w0OWButs7Aj7Ob
         vVUEMv1bLTlNFItmiEnUO3h3oLpbv+DNkvMfMDvNLle191iiXDWcGCxs+HBipGWzlqtU
         uO0w==
X-Gm-Message-State: APjAAAW9Li4a/OxVUpU9XccwQPvWstLun3slAkG39XtC/Wx3r330h+U3
        guR0LwSsbT69zP6vqWlLBlUKJ3PHTzg=
X-Google-Smtp-Source: APXvYqzyWVLvVQB6G1LvDG/ai91vaOM+jK1+YRHd9PRTO17H0w0FgpFZN9dSIq2p6hI6APR8QIGwHQ==
X-Received: by 2002:a5e:c311:: with SMTP id a17mr2517556iok.140.1567812978366;
        Fri, 06 Sep 2019 16:36:18 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 05/21] NFS: skip recovery of copy open on dest server
Date:   Fri,  6 Sep 2019 19:35:55 -0400
Message-Id: <20190906233611.4031-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
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
index 5f279425ee77..814674f073a1 100644
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
index 1898262a2cb1..a932fc9ca9c4 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -352,6 +352,7 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 	if (ctx->state == NULL)
 		goto out_stateowner;
 
+	set_bit(NFS_SRV_SSC_COPY_STATE, &ctx->state->flags);
 	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 	memcpy(&ctx->state->open_stateid.other, &stateid->other,
 	       NFS4_STATEID_OTHER_SIZE);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index e23945174da4..f205037fc1c5 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1609,6 +1609,9 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 	struct nfs4_state *state;
 	unsigned int loop = 0;
 	int status = 0;
+#ifdef CONFIG_NFS_V4_2
+	bool found_ssc_copy_state = false;
+#endif /* CONFIG_NFS_V4_2 */
 
 	/* Note: we rely on the sp->so_states list being ordered 
 	 * so that we always reclaim open(O_RDWR) and/or open(O_WRITE)
@@ -1628,6 +1631,13 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
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
@@ -1682,6 +1692,10 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
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
2.18.1

