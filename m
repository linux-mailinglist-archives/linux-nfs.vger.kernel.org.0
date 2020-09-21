Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0052731A2
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgIUSMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUSMA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F9C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:00 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id u6so16425040iow.9
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PeS4CmtyoSqQras4chO+iDlp+IGupAivoXMmfOKCDO0=;
        b=mjRQ3+QG5RjBNtHM3hZ8QVUgQXEf5B9lMTm8oHWQEok//fo6xpqOyPc6qMu1JO5lyx
         vVru+qdQCrw57cBa/Ef7kDISBRhKxo4vUUc5w5BsTOj5lOgCiBozxArtzdhjHZdycPTF
         B28PRdeltBdumLDgA+Gu/S4mkAWVyOlZs47L6HT5lpZTFwJexFGdBrK2KLmxjV2mDUNK
         utPBCqIY18gdh3rkCOTR8MLF9V1KHFLMsE0P3JVXtzamUewEso6eeZzZ4RPlDfWZuMJ2
         Pro0YZxp1O0DMcaVI3db3O2ib3QNKY2AWiRplfLPEhsryYeVrpyO7ivcMVL/x5UYRjYI
         ndFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PeS4CmtyoSqQras4chO+iDlp+IGupAivoXMmfOKCDO0=;
        b=XjWhhVweAQcivajHHpuMLZwQKR3FC8XpjBtbLyw1liAB63hcE+0dX7U4bLAGq7Avoq
         GwhfWkaxAdiazDkb6M5bLpOx+j5x2VC8CEa5ZMkuAepavAxxYUaD9JondmVaSGU/9b/U
         cJ2M42sgdlE34igTpJL2k2kosfQ8EZNbx2sWDhYBt4Aoq0btru0S58c5kVyMBs8M89Ka
         Nxa510YyNxHgAmRbiFAqgEHY5fX8hqCxkIMi63aiOYslRiyUs4Xci9iVHz3b67JLwxab
         5EF9x/3Wut6gGDhiPHvDvU9EGXKL9XO2WSy8m31I9vpKoTF8SIYGXNZkzKZ8uH79YiWl
         DChA==
X-Gm-Message-State: AOAM531liMl8WWEZLc8zPm9YNyGaecF166nNUj4NGxKFvvzXOFkku0gz
        dMw46jV+7kX0akgjwWHdEauURtBBoOg=
X-Google-Smtp-Source: ABdhPJxRrYL+IvPm16arYf5kyTIMom4CN9bkEBH7cmipLrrjaPJH+gWysd6lT1BKb6N1NOCnexJuYw==
X-Received: by 2002:a05:6602:2a4b:: with SMTP id k11mr488333iov.85.1600711919939;
        Mon, 21 Sep 2020 11:11:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 15sm7517895ilz.66.2020.09.21.11.11.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:59 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBwj3003881;
        Mon, 21 Sep 2020 18:11:58 GMT
Subject: [PATCH v2 13/27] NFSD: Add tracepoint for nfsd_access()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:58 -0400
Message-ID: <160071191856.1468.8300898542888761435.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is possible to use this tracepoint for several purposes,
including troubleshooting export permission problems and auditing
accesses to files.

nfsd-1025  [002]   256.807403: nfsd_permission:      xid=0x12147d7a \
	type=REG access=WRITE|SATTR|OWNER_OVERRIDE owner=1046/100 \
	user=1046/100 name=.clang-format status=OK

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h           |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c             |    1 +
 include/trace/events/fs.h |   10 ++++++++++
 3 files changed, 56 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b4c773530aa8..15b97275b3b4 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -10,6 +10,7 @@
 
 #include <linux/tracepoint.h>
 #include <trace/events/fs.h>
+#include <trace/events/nfs.h>
 
 #include "export.h"
 #include "nfsfh.h"
@@ -30,6 +31,50 @@
 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
 		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
 
+TRACE_EVENT(nfsd_access,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct dentry *dentry,
+		int access,
+		__be32 status
+	),
+	TP_ARGS(rqstp, dentry, access, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(unsigned long, type)
+		__field(unsigned long, access)
+		__field(uid_t, owner)
+		__field(gid_t, owner_group)
+		__field(uid_t, user)
+		__field(gid_t, user_group)
+		__field(int, status)
+		__dynamic_array(unsigned char, name, dentry->d_name.len + 1)
+	),
+	TP_fast_assign(
+		const struct inode *inode = d_inode(dentry);
+
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->type = inode->i_mode & S_IFMT;
+		__entry->access = access;
+		__entry->owner = __kuid_val(inode->i_uid);
+		__entry->owner_group = __kgid_val(inode->i_gid);
+		__entry->user = __kuid_val(current_fsuid());
+		__entry->user_group = __kgid_val(current_fsgid());
+		__entry->status = be32_to_cpu(status);
+		memcpy(__get_str(name), dentry->d_name.name,
+		       dentry->d_name.len);
+		__get_str(name)[dentry->d_name.len] = '\0';
+	),
+	TP_printk("xid=0x%08x type=%s access=%s owner=%u/%u user=%u/%u name=%s status=%s",
+		__entry->xid,
+		show_inode_type(__entry->type),
+		show_nfsd_may_flags(__entry->access),
+		__entry->owner, __entry->owner_group,
+		__entry->user, __entry->user_group,
+		__get_str(name), show_nfs_status(__entry->status)
+	)
+);
+
 TRACE_EVENT(nfsd_setattr_args,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a311593ac976..0d354531ed19 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -687,6 +687,7 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 			sresult |= map->access;
 
 			err2 = nfsd_permission(rqstp, export, dentry, map->how);
+			trace_nfsd_access(rqstp, dentry, map->how, err2);
 			switch (err2) {
 			case nfs_ok:
 				result |= map->access;
diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
index 2b185d81d9a5..49d3dde471ad 100644
--- a/include/trace/events/fs.h
+++ b/include/trace/events/fs.h
@@ -165,3 +165,13 @@
 		{ ATTR_OPEN,		"OPEN" }, \
 		{ ATTR_TIMES_SET,	"TIMES_SET" }, \
 		{ ATTR_TOUCH,		"TOUCH" })
+
+#define show_inode_type(x) \
+	__print_symbolic(x, \
+		{ S_IFIFO,		"FIFO" }, \
+		{ S_IFCHR,		"CHR" }, \
+		{ S_IFDIR,		"DIR" }, \
+		{ S_IFBLK,		"BLK" }, \
+		{ S_IFREG,		"REG" }, \
+		{ S_IFLNK,		"LNK" }, \
+		{ S_IFSOCK,		"SOCK" })


