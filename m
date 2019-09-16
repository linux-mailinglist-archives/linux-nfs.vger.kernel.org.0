Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4560B42C2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391496AbfIPVOC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:02 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:41892 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391481AbfIPVOC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:02 -0400
Received: by mail-io1-f53.google.com with SMTP id r26so2427494ioh.8
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TywW2nZeTmjCJvvuYq8EMw8fV30prBCgTawZutPeTms=;
        b=CTDSCxYQLtkf8041+TdY3XzY1GuxN69dyymnJyXzi+iltH99I0KG0oVECPb81AyLqT
         boMz5aqGqTwZh+7S4BbzKbGtQGHB67SzsHn+mGqNowhrI2yyueoWBbJoQQdTOtyV5d9U
         RvRWqyBGQo4v4WHt6psxcLzIKBgo+udpSN+4GFfBqSujIXek4eNQ1aPMmUYNbaZ88AEw
         VxvH9XIm3qowAvt3lYo4txCWgBx3WusAHUKItt6RasZOVkk9LKEECA7vaZlgqC+a6H0p
         bm68GawtKQ0cLJyhS66F9YQXMDe8AIJYFcHMvN/uDdjtJaVGwWgRBedAxsPjX849/0WT
         UArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TywW2nZeTmjCJvvuYq8EMw8fV30prBCgTawZutPeTms=;
        b=SkqGRWgmaj+e+/OaKdS4paJflXWXaYkhjuTJhBNnvfhJqnEDL03Rlx/sAgQ6fkZf+Z
         Vnn1cgldeCgqIfXjNiUlx/Cyq8bRfqhJyxMkOsj4r38mkNKBZETte3S0arrNHRtYd+YP
         A4va11Q3xeF2uR4N2Cx30vRI9JQD1D+A5rcS1X81FsZF3dJ3K9iMU3NjqAaWyrikvm6V
         KfW/MQHmFeXRj3Wfo8pawtiJuNgW5swOCW8bQPR0nWJiWjpjfC7wh/OdqfKl56fQZ7Nf
         5VtgF7IygUcUZDtk8eM90nIhO4j/ijAnfvET1+u/D36s+5TN8zSZM+xJc9bFusK/tXM9
         m3xw==
X-Gm-Message-State: APjAAAUmS+OHdB17glpLtH8m/KAQyqgyBsZ/x5ZJKyBey6t8gdypTopT
        5BGCwWeKzXxYi3y3H5hf1dnNOg5D
X-Google-Smtp-Source: APXvYqwqTVS5O/BirzQZH3vZK8D3yJm4P3ZW7MpI5RKGVZh7ei1Vv9ehO3DDXkO0yjiLjgGxCvnR0A==
X-Received: by 2002:a5d:964f:: with SMTP id d15mr375990ios.230.1568668441698;
        Mon, 16 Sep 2019 14:14:01 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:01 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 06/19] NFS: skip recovery of copy open on dest server
Date:   Mon, 16 Sep 2019 17:13:40 -0400
Message-Id: <20190916211353.18802-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
index 8b9f039..f1a7f40 100644
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
index d9ca8af..b0dbb59 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -352,6 +352,7 @@ struct file *
 	if (ctx->state == NULL)
 		goto out_stateowner;
 
+	set_bit(NFS_SRV_SSC_COPY_STATE, &ctx->state->flags);
 	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 	memcpy(&ctx->state->open_stateid.other, &stateid->other,
 	       NFS4_STATEID_OTHER_SIZE);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9afd051..e06a63f 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1606,6 +1606,9 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 {
 	struct nfs4_state *state;
 	int status = 0;
+#ifdef CONFIG_NFS_V4_2
+	bool found_ssc_copy_state = false;
+#endif /* CONFIG_NFS_V4_2 */
 
 	/* Note: we rely on the sp->so_states list being ordered 
 	 * so that we always reclaim open(O_RDWR) and/or open(O_WRITE)
@@ -1625,6 +1628,13 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
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
@@ -1671,6 +1681,10 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
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

