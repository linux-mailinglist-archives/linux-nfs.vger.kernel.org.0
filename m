Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C616131958
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgAFU1f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:35 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43469 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFU1f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:35 -0500
Received: by mail-yb1-f193.google.com with SMTP id v24so22617490ybd.10
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOYjnXKvMR2Gy515cExSrZS0OY98LvNhpkak+KdJAw0=;
        b=N0Gp5hR1Wv6AXz7wdP8djzpg0N2mQPxcaBRfFyHS3agUpDdTM5sYPMEcR4fyX3zqSv
         DFRXymtijMJr5IraBKZTziYCW32+pogvoG2oF5Q8avvI0A030E+6ZTrkL0y3k3rKuBeF
         dbV7fbMs7xVsdsVqIcE73fbNLiWJ7HYHnG8eJKWgD2xVmCgUtaMoz8eacBTqfv0ELW0N
         GqvW0z46ERFI4kEp23F5pyZF+ustIXiP8tThbPRy4p70SBk/JveBwLMRpNcUwdp1eAq8
         5myuLXd+7OAz2j2RCET4mbvR9JTvwhBDZ7Sx0vWzLcrT1elEammlNuNZbQXROPUhoh6Y
         wYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOYjnXKvMR2Gy515cExSrZS0OY98LvNhpkak+KdJAw0=;
        b=TkW4rBN4XyHYC8SYoVssrjwPt1+30mVDDiWkR/XQLoP4b03t5BS85MDDQtPGHAczDN
         Egsust9hD92qPG7DIomp0oKrij76P8MXxaQNacEUaQim6s9RDjE3Ao+qx5EQdKWZZzNZ
         Od8nCZk2ew2l7O/QMeLPRwD3L8xZ6wTLj+H5cpNWDmwHLGGDweJ9/eASX67dpjRwSz+V
         N4kgmI8AeHFVECYXWSmYYGvWwCd3jGF8JfzWqf9QMetAH5PCVJ5wcC/57qypH9LnI8UO
         vMn0iKEWgCkvqamlCDE1iN2SSzwIBktgXSPxp1/mXFTFo+Yjtuxcw5NDyQDAydn1luL8
         2PNg==
X-Gm-Message-State: APjAAAVnsHGgAejholCJI8B3TVky85/ZzhSa6YfZGTXAemXdjjH/gT05
        kqCz4DKnsoZys3b72Zfyxg==
X-Google-Smtp-Source: APXvYqz4fDBtJP53AcnaT0eNwBaqRSko2noZR5679CFAaYN9QVX78VAtn+oFQlIEq58QA2bqtPRO3w==
X-Received: by 2002:a25:18c4:: with SMTP id 187mr51959184yby.468.1578342454030;
        Mon, 06 Jan 2020 12:27:34 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:33 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/15] NFS: Fix fix of show_nfs_errors
Date:   Mon,  6 Jan 2020 15:25:06 -0500
Message-Id: <20200106202514.785483-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-7-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Casting a negative value to an unsigned long is not the same as
converting it to its absolute value.

Fixes: 96650e2effa2 ("NFS: Fix show_nfs_errors macros again")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4trace.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index a3155b7f8063..a291877c0c32 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -352,7 +352,7 @@ DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		),
 
 		TP_fast_assign(
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__assign_str(dstaddr, clp->cl_hostname);
 		),
 
@@ -432,7 +432,8 @@ TRACE_EVENT(nfs4_sequence_done,
 			__entry->target_highest_slotid =
 					res->sr_target_highest_slotid;
 			__entry->status_flags = res->sr_status_flags;
-			__entry->error = res->sr_status;
+			__entry->error = res->sr_status < 0 ?
+					-res->sr_status : 0;
 		),
 		TP_printk(
 			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
@@ -640,7 +641,7 @@ TRACE_EVENT(nfs4_state_mgr_failed,
 		),
 
 		TP_fast_assign(
-			__entry->error = status;
+			__entry->error = status < 0 ? -status : 0;
 			__entry->state = clp->cl_state;
 			__assign_str(hostname, clp->cl_hostname);
 			__assign_str(section, section);
@@ -659,7 +660,7 @@ TRACE_EVENT(nfs4_xdr_status,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
 			u32 op,
-			int error
+			u32 error
 		),
 
 		TP_ARGS(xdr, op, error),
@@ -849,7 +850,7 @@ TRACE_EVENT(nfs4_close,
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)state->state;
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(args->stateid.seqid);
 			__entry->stateid_hash =
@@ -914,7 +915,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 		TP_fast_assign(
 			const struct inode *inode = state->inode;
 
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
 			__entry->type = request->fl_type;
 			__entry->start = request->fl_start;
@@ -986,7 +987,7 @@ TRACE_EVENT(nfs4_set_lock,
 		TP_fast_assign(
 			const struct inode *inode = state->inode;
 
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->cmd = cmd;
 			__entry->type = request->fl_type;
 			__entry->start = request->fl_start;
@@ -1164,7 +1165,7 @@ TRACE_EVENT(nfs4_delegreturn_exit,
 		TP_fast_assign(
 			__entry->dev = res->server->s_dev;
 			__entry->fhandle = nfs_fhandle_hash(args->fhandle);
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(args->stateid->seqid);
 			__entry->stateid_hash =
@@ -1204,7 +1205,7 @@ DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 		TP_fast_assign(
 			const struct inode *inode = state->inode;
 
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
@@ -1306,7 +1307,7 @@ TRACE_EVENT(nfs4_lookupp,
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->ino = NFS_FILEID(inode);
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 		),
 
 		TP_printk(
@@ -1342,7 +1343,7 @@ TRACE_EVENT(nfs4_rename,
 			__entry->dev = olddir->i_sb->s_dev;
 			__entry->olddir = NFS_FILEID(olddir);
 			__entry->newdir = NFS_FILEID(newdir);
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__assign_str(oldname, oldname->name);
 			__assign_str(newname, newname->name);
 		),
@@ -1433,7 +1434,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_event,
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(stateid->seqid);
 			__entry->stateid_hash =
@@ -1489,7 +1490,7 @@ DECLARE_EVENT_CLASS(nfs4_getattr_event,
 			__entry->valid = fattr->valid;
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			__entry->fileid = (fattr->valid & NFS_ATTR_FATTR_FILEID) ? fattr->fileid : 0;
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 		),
 
 		TP_printk(
@@ -1536,7 +1537,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_callback_event,
 		),
 
 		TP_fast_assign(
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (!IS_ERR_OR_NULL(inode)) {
 				__entry->fileid = NFS_FILEID(inode);
@@ -1593,7 +1594,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 		),
 
 		TP_fast_assign(
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (!IS_ERR_OR_NULL(inode)) {
 				__entry->fileid = NFS_FILEID(inode);
@@ -1912,7 +1913,7 @@ TRACE_EVENT(nfs4_layoutget,
 			__entry->iomode = args->iomode;
 			__entry->offset = args->offset;
 			__entry->count = args->length;
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
 			__entry->stateid_hash =
-- 
2.24.1

