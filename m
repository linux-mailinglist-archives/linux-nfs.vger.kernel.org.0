Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD455F0232
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2019 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbfKEQES (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Nov 2019 11:04:18 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37868 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390117AbfKEQER (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Nov 2019 11:04:17 -0500
Received: by mail-yb1-f196.google.com with SMTP id e13so2726166ybh.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2019 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CAZUPUsfMsbjmf+4MIGGOIiKXIVVntjW8JL88tNIZ5Q=;
        b=mwwNnOJETaorHQcL4AUK6BroAVP8LpfwtIFPV7D6dDkVt4c9u0IinamlskWif8oR9R
         odNvD7rTb6fORsaet1guB7PT+xsTeg2rP8EfquxsOgdusqqR1zSP3uOB8Ideodd/Y5oR
         fysuYMEY6Y+DrUu3F+VI3Q4pwLruEgh+5iur7erjvCl+8FCTxwwTMCnp54AMQlWp3ene
         h2dwpk/P+aIKgCysixbnkAVphPQb9AUpARhtGwIcS27rKKotwasN7t/k3b8+MKZZ9DMZ
         KjbrtTmHgJqVYt1qSrPPIesltyF669QPHABS/iuvkhkdHdYWuVLU73aFFiPptK/0l1eU
         ukKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CAZUPUsfMsbjmf+4MIGGOIiKXIVVntjW8JL88tNIZ5Q=;
        b=F1p8174gd5GKai/gsY1XhXt4FESIYqCK3I8E0aorB/lcPc3qz/Bzb18Wop79baqoYG
         BeMw0DRLvYYsDIhMUByKhmbr7xVj2XTn5ZS+zxSppLHB73iKtLBcVHsE0QXcxLvx3e/N
         wGRD9M9jQ2UkSqbXr/d6TtC1sBM8gBzH3ayhQIVzriTi0YM+nb6ZnMxqMUDPGHw9q6af
         ZL5w9iWYb45piFlYunKert1LpO+3z2GSblry1xLX2dH9v96P/ANVJWjgI0ty0Nmb5J0L
         aMtMnJWDXccs9vUNzpWWfD7NG/tNbdHajZQa3PEErFcvPbZFERTL3wU4gp97CR1PW3mo
         xMXQ==
X-Gm-Message-State: APjAAAWpzLH4DAEIVvop9lbLIpxievv7fsjBcNotCr1fv8H3/65Mi6EM
        2wpbihMhbBYsasgfIzWvbzvHoT6XpLU=
X-Google-Smtp-Source: APXvYqyOGHlxsKzcedL/QaOOYbZZljoNsNRl7/2YqnhxAk/mAfbGlmheEVZseHsQjKi/3L3lQ+859A==
X-Received: by 2002:a25:258a:: with SMTP id l132mr29180058ybl.227.1572969854681;
        Tue, 05 Nov 2019 08:04:14 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z196sm13378726ywz.30.2019.11.05.08.04.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 08:04:14 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xA5G4D1s016751
        for <linux-nfs@vger.kernel.org>; Tue, 5 Nov 2019 16:04:13 GMT
Subject: [PATCH RFC 2/2] NFS4: Trace lock reclaims
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Nov 2019 11:04:13 -0500
Message-ID: <20191105160413.26481.49011.stgit@manet.1015granger.net>
In-Reply-To: <20191105160208.26481.97809.stgit@manet.1015granger.net>
References: <20191105160208.26481.97809.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

One of the most frustrating messages our sustaining team sees is
the "Lock reclaim failed!" message. Add some observability in the
client's lock reclaim logic so we can capture better data the
first time a problem occurs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4_fs.h   |    2 -
 fs/nfs/nfs4state.c |    1 +
 fs/nfs/nfs4trace.h |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 16b2e5cc3e94..935bf335a3c2 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -166,9 +166,7 @@ enum {
 	NFS_STATE_RECOVERY_FAILED,	/* OPEN stateid state recovery failed */
 	NFS_STATE_MAY_NOTIFY_LOCK,	/* server may CB_NOTIFY_LOCK */
 	NFS_STATE_CHANGE_WAIT,		/* A state changing operation is outstanding */
-#ifdef CONFIG_NFS_V4_2
 	NFS_CLNT_DST_SSC_COPY_STATE,    /* dst server open state on client*/
-#endif /* CONFIG_NFS_V4_2 */
 };
 
 struct nfs4_state {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index b69c33c3600c..e72fbc842025 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1594,6 +1594,7 @@ static int __nfs4_reclaim_open_state(struct nfs4_state_owner *sp, struct nfs4_st
 	if (!test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		spin_lock(&state->state_lock);
 		list_for_each_entry(lock, &state->lock_states, ls_locks) {
+			trace_nfs4_state_lock_reclaim(state, lock);
 			if (!test_bit(NFS_LOCK_INITIALIZED, &lock->ls_flags))
 				pr_warn_ratelimited("NFS: %s: Lock reclaim failed!\n", __func__);
 		}
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index a66af56c7eef..046ebc24ac9f 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1057,6 +1057,84 @@
 		)
 );
 
+TRACE_DEFINE_ENUM(LK_STATE_IN_USE);
+TRACE_DEFINE_ENUM(NFS_DELEGATED_STATE);
+TRACE_DEFINE_ENUM(NFS_OPEN_STATE);
+TRACE_DEFINE_ENUM(NFS_O_RDONLY_STATE);
+TRACE_DEFINE_ENUM(NFS_O_WRONLY_STATE);
+TRACE_DEFINE_ENUM(NFS_O_RDWR_STATE);
+TRACE_DEFINE_ENUM(NFS_STATE_RECLAIM_REBOOT);
+TRACE_DEFINE_ENUM(NFS_STATE_RECLAIM_NOGRACE);
+TRACE_DEFINE_ENUM(NFS_STATE_POSIX_LOCKS);
+TRACE_DEFINE_ENUM(NFS_STATE_RECOVERY_FAILED);
+TRACE_DEFINE_ENUM(NFS_STATE_MAY_NOTIFY_LOCK);
+TRACE_DEFINE_ENUM(NFS_STATE_CHANGE_WAIT);
+TRACE_DEFINE_ENUM(NFS_CLNT_DST_SSC_COPY_STATE);
+
+#define show_nfs4_state_flags(flags) \
+	__print_flags(flags, "|", \
+		{ LK_STATE_IN_USE,		"IN_USE" }, \
+		{ NFS_DELEGATED_STATE,		"DELEGATED" }, \
+		{ NFS_OPEN_STATE,		"OPEN" }, \
+		{ NFS_O_RDONLY_STATE,		"O_RDONLY" }, \
+		{ NFS_O_WRONLY_STATE,		"O_WRONLY" }, \
+		{ NFS_O_RDWR_STATE,		"O_RDWR" }, \
+		{ NFS_STATE_RECLAIM_REBOOT,	"RECLAIM_REBOOT" }, \
+		{ NFS_STATE_RECLAIM_NOGRACE,	"RECLAIM_NOGRACE" }, \
+		{ NFS_STATE_POSIX_LOCKS,	"POSIX_LOCKS" }, \
+		{ NFS_STATE_RECOVERY_FAILED,	"RECOVERY_FAILED" }, \
+		{ NFS_STATE_MAY_NOTIFY_LOCK,	"MAY_NOTIFY_LOCK" }, \
+		{ NFS_STATE_CHANGE_WAIT,	"CHANGE_WAIT" }, \
+		{ NFS_CLNT_DST_SSC_COPY_STATE,	"CLNT_DST_SSC_COPY" })
+
+#define show_nfs4_lock_flags(flags) \
+	__print_flags(flags, "|", \
+		{ BIT(NFS_LOCK_INITIALIZED),	"INITIALIZED" }, \
+		{ BIT(NFS_LOCK_LOST),		"LOST" })
+
+TRACE_EVENT(nfs4_state_lock_reclaim,
+		TP_PROTO(
+			const struct nfs4_state *state,
+			const struct nfs4_lock_state *lock
+		),
+
+		TP_ARGS(state, lock),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(unsigned long, state_flags)
+			__field(unsigned long, lock_flags)
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+		),
+
+		TP_fast_assign(
+			const struct inode *inode = state->inode;
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
+			__entry->state_flags = state->flags;
+			__entry->lock_flags = lock->ls_flags;
+			__entry->stateid_seq =
+				be32_to_cpu(state->stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&state->stateid);
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"stateid=%d:0x%08x state_flags=%s lock_flags=%s",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid, __entry->fhandle,
+			__entry->stateid_seq, __entry->stateid_hash,
+			show_nfs4_state_flags(__entry->state_flags),
+			show_nfs4_lock_flags(__entry->lock_flags)
+		)
+)
+
 DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 		TP_PROTO(
 			const struct inode *inode,

