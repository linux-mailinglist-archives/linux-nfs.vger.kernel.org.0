Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AFEAC0C3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392361AbfIFTql (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45901 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIFTql (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:41 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so15340625iog.12
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67LNqASa/4OalrIFRXKZ3VWKnxUt0Iof65Y5SdHMQ6w=;
        b=CE0zowZyXGXFO7ACiVpuinIZg4fk74WgVYXanDUsh40ReVJqxo0DJF2n3XAl4Tbeg9
         dq8ajpHGRJJe4whAUGB0fMEWpsi4Txdc9O8P7afVsY997NfwaYiDj9Xi+gjNEBMNNUl9
         OlOCzTGoFlbnjIWGkEd+T3FSdU9JvIZM8svUF3HBNJYWbU8DwtxRboTCAuPe1VnQQ5+t
         tLonv0YrsZY6nipP/M/sBVHn+Nx+4yBOIgRe5x2DvTt2dko0c/GMefwiBjLfpHA4/7rP
         ZVEBIiO6mKE6YBf5TuFWdTxZGYo1HvxVEPmNn2Sfgywz7HXc93X3At52pZq6xpXduUf+
         /suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67LNqASa/4OalrIFRXKZ3VWKnxUt0Iof65Y5SdHMQ6w=;
        b=dHHF8IeKdoOV1z3nmM+u754rCwIIgB4JuIhy+Fj5rx7QPsisdOxR9uLKED56+Gw/Xa
         pdEBSkLpw80HJjxK11VoLHzMjN1Y2pL3EAQb0uM6bI4TyurCxRHXVgUpfvmvcKgsAuid
         2kdrrLEhdqyYoJvBLiYyQ3Dy7fTnpf1bZxqOn9ahwueEIcrKr93lx7GPzLRuhqy1wkNn
         AP195ZZz8a+pwfBcy1Hxp7b6uY4t/cXW1q9pBh4VaYAW6DpBTQLj1o4ldpkVmR0e8DNC
         bLHFeWbcTDrREqXxFTdqYkR02cmJRQG4rXJKN0dT5W7+/JXl5+1A2j8O7YUqzQM1NP0Z
         j2Zw==
X-Gm-Message-State: APjAAAW9+4kXMPkx8AUOQB3tVgGEIonHa+7lr2wIMxf1DNSqFLcHFYIS
        tyuu0FQ5rc9RqPbiz+nS6TA=
X-Google-Smtp-Source: APXvYqz/0y+Hhrv/xrvSbaWXuuLn6F5GWt9Dk7txNiEiUl6YCVR0d2275LWDIasBA1/1U2jUYhcuFQ==
X-Received: by 2002:a02:c546:: with SMTP id g6mr11999268jaj.59.1567799200144;
        Fri, 06 Sep 2019 12:46:40 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:39 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 06/19] NFS: skip recovery of copy open on dest server
Date:   Fri,  6 Sep 2019 15:46:18 -0400
Message-Id: <20190906194631.3216-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
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
index 5f27942..814674f 100644
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
index 1898262a..a932fc9 100644
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
index e239451..f205037 100644
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
1.8.3.1

