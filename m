Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC10FD29D7
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfJJMqb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36041 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfJJMqb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:31 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so13349610iof.3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RSgNzoy3u3Erm4dktIG0xJ/U54xZxUEXHfZZn0m200U=;
        b=bhtrq5wJEWuJrc0esHQ8kpTOlH/BQWQPsRD+KZYn2O8aMnUSXkee8UcWz+fzTlAlPo
         nEnK4qkWNyt3Cx0KdJOJlT9zDKB250FafLdRvRTc5MOTCrgvEIcWwOMnntEVAbwhOB5A
         VFkVWrdcmjcWdC7ybEe4BUUpt+L7q5u7zQR2ATuI3p3cuW+pJWkDifuyYwfcP+bYSrh6
         wzvwIOffbV45kFZsdZfkdGmPbMXhgL5f0yC8XWRlHCmRz6hTXwGkqSHTEGOhkqsInXKL
         Z8pahe/X2jOLJYhurVJq4s6EWY4zoo33/wci81jCBV0wp23MvCon6TjSXayCKbK+q3ZE
         4XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RSgNzoy3u3Erm4dktIG0xJ/U54xZxUEXHfZZn0m200U=;
        b=YE8/1/VDM9UN4F5OMM1bSQbH4GdVnzB6LN6NIrBb3MPYdRiXm6lMv+XrgRIAcerOd3
         4InlfB9ENHA6JkbQpqeVzQwOxy3ez3JAicMF3D1//Dm60HVwNKCy9sVFMo/MBK7Q5YGi
         yYHEm7o3rA3zJ8ZxPhDGAnOD5qexHHEGn/+VAfhBFUUIFQPVjI6jqtu5xajwbej5uL6I
         7g+fQHq7V2UfeFI1BrIG8otl8MbDqk0BUwSlQ1E/L2QVZF96jhCOQI74FNAmuejeV1tm
         JjBDf1WAQ4aB0v6swyV/TwqPOIQv8YQ0F6lWXpYHgXmCRYFY+rEKBpOYAjsUaL9s5Kul
         ysaQ==
X-Gm-Message-State: APjAAAWAVnWOvfupwHsrMELvGcbTYT7wIJt69LdXXm/zSlUdlu6Dbt5F
        PHFMDePaq6XbDFFRj+DFrbeGpM6J
X-Google-Smtp-Source: APXvYqw3/R9ZMrYMDGQ2dVWY+3fYmc5fic09RSYgBaxOZUdkEUwfJMrskBMdef6Qq2IDMhU6q4J43Q==
X-Received: by 2002:a92:38c9:: with SMTP id g70mr13678ilf.88.1570711590912;
        Thu, 10 Oct 2019 05:46:30 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:30 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 05/20] NFS: skip recovery of copy open on dest server
Date:   Thu, 10 Oct 2019 08:46:07 -0400
Message-Id: <20191010124622.27812-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
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
index 0c6d53d..c45b300 100644
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

