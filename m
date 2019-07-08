Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C96294E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391663AbfGHTYs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:48 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:39579 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391658AbfGHTYs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:48 -0400
Received: by mail-io1-f47.google.com with SMTP id f4so22356105ioh.6
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j4mW/8OmzRmXM+ufLvtFbCF367tp/PDFgRYcUVIHLSc=;
        b=BBPjV1Ltk+wYqzSmAIf2CIzbnW+22auh7F/cNllpSAuAzN1JbnQII72SA1M8RKsTYl
         HYGesKR+KyuJMMpBoEtcxq+oSJLeHDQpBi8UOyvq31lMemKvOoeIibDShIy4HaxkqUGe
         6+OTBgDn00QfD37AoWWYwo7+r98Cw0pPV51ePIY1yRrwd4ae2/VPXvw/flACGgtqCWwb
         qhRGcY7jM9qZDJ7NvQ9t44ERJH4dzqVDpllKVAeRgrd6Qvc1dD8aRdekIHD1dXG5aF9m
         Pm68gZw52Z04Juh+Bpf4/iBWSy1o8KDg9nDP7ixtQrV6XneXb4TCrI1Jxky96bTVIhl3
         hIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j4mW/8OmzRmXM+ufLvtFbCF367tp/PDFgRYcUVIHLSc=;
        b=Llz5SAuF5dwgeB3ZHYatLKGr07I2IgcudWYgj9MmQg6melkQmqXO+ovvVr9t2ouSMv
         OIiStIPFqvTp/Mi6QdQQa9DuUWW9UXo5QSCVKE96TjrK+i0WoYmZfF2Puk4Tg/yc068J
         J6oWKbtjH91ORveISMGLW7y7NPjCngxiKerN7vTvSR8zA2oIkjxwrMbuzU96Ceyi1kuN
         htWUyOOizaGLz/5lDqv5dIKRJIQLgYwgJ02D88LhPMWHr4Wm93L4BzFjdOuWdCAcf3G1
         Gj0ZFXo8/ZIG6hcSA0jH1AO3z9CnkrN97IctnUxNZ2YeNUevHTfYAQcICN9Z5fBNl3FI
         PjzA==
X-Gm-Message-State: APjAAAU4rWMFxAIXQ/Z2wNmbwbWneyQIImKzZeu1mCaDtG0w+cjFCFAC
        Y3Kz1kaJhjOZdtJB1vcSRs8=
X-Google-Smtp-Source: APXvYqyXmtUAKotR6GO99eeyXA3Imtkn/gDsB8A+slk6QJbUU+TwixU15/kldopGwG+LpfrXGu+rqA==
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr12841471iof.6.1562613887298;
        Mon, 08 Jul 2019 12:24:47 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:46 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 05/12] NFS: skip recovery of copy open on dest server
Date:   Mon,  8 Jul 2019 15:24:37 -0400
Message-Id: <20190708192444.12664-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
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
index ff1cd600f07f..d49fc19361d2 100644
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
index aab4d48764a7..5ef3c12bb54b 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -348,6 +348,7 @@ nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
 	if (ctx->state == NULL)
 		goto out_stateowner;
 
+	set_bit(NFS_SRV_SSC_COPY_STATE, &ctx->state->flags);
 	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
 	memcpy(&ctx->state->open_stateid.other, &stateid->other,
 	       NFS4_STATEID_OTHER_SIZE);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index e2e3c4f04d3e..045af569835c 100644
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
2.18.1

