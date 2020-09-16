Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB626CE59
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgIPWIM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgIPWH7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:07:59 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A703C061A30
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y2so269399ilp.7
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1WJK/KvRSZWksK8GCJOggEZuMj4piQ+8Bp8DYLB3E7w=;
        b=sDYBCcZIBJ5KgUeN+c1x3mC8lt/+ZUEtHBUfNJ1F//2TCsjr//DKl0Up1Ru5q1AJ4e
         ngCuJ8JBlMaQU1e1y1z2adERUWG6Pg3iLP40XrQCjwH/uTcw7+pSizUnqXWMguE7Q83J
         cn91Y1L+n2e2OjlYOI/BF3GFTqQKB2n02d7MOevLOUiPdbBpTQ8nKw2V1gHLpnoePJ6R
         GmRTgU/ZFYR/+tOJW0kOfvRWxIUd95lkJVD7h3cX8ynEqC5BJHJph8mQDGYQLArD7V+L
         Xu204ujUSdtD9i+QzvElDlXBfd7wLZAJ/DbstyV0iSu9Va5acx6NpmJArGqrC/J8/spn
         rA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1WJK/KvRSZWksK8GCJOggEZuMj4piQ+8Bp8DYLB3E7w=;
        b=QrauN1gqg7Trw9pXlGxWimG9hdMRK36jAeoDU6ICSot/JxTE16LtWk5CtXGJL5LpIx
         JNRpPOYDdADlPTFMsWn4lb16RxuI6Qwe94cY2NlqwL1d5olkEXJNu/OMbCHP/JBA8q5D
         zDrfqJdhfFXmcPh7Yvuf34/lTuGJ1wPRfFIZBocMgn/uN0ZFYXUHea0ntDgw/75+SZ1X
         noa4ZLeFLtqnKAh7ePEVVeCrMEgRJTcPUJH0GQh27n65I+5jVXpvkK53lNNZ2xJDbvVc
         IMSuqdU7+36fXU9QvkzU7LQFylHzPfM1EVVt/U2mihXD5SnCYgML8tksKP1Xf19XhqH5
         WHaw==
X-Gm-Message-State: AOAM533C3yfJ0YGFGYYWie1UjL40HfghpmCs7uqr1Z8+7rWPHAsxjBKn
        V6f0NGLQ8h2HoY1EZKjwLug=
X-Google-Smtp-Source: ABdhPJyRQXvoPuEOi1SbdOWxT8g6/2gwi44PjAk+E3ScjQm2azz+hXuP8tti6/3BAEAqrQjLIi88vQ==
X-Received: by 2002:a92:6a0c:: with SMTP id f12mr21145223ilc.213.1600292576695;
        Wed, 16 Sep 2020 14:42:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a21sm9673054ioh.12.2020.09.16.14.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:42:56 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLgtak023002;
        Wed, 16 Sep 2020 21:42:55 GMT
Subject: [PATCH RFC 08/21] NFSD: Add tracepoint for nfsd_access()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:42:55 -0400
Message-ID: <160029257508.29208.10177582417317460106.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
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

nfsd-1025  [002]   256.807403: nfsd_permission:      xid=0x12147d7a type=REG access=WRITE|SATTR|OWNER_OVERRIDE owner=1046/100 user=1046/100 name=.clang-format status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.c |    2 ++
 fs/nfsd/trace.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c   |    1 +
 3 files changed, 47 insertions(+)

diff --git a/fs/nfsd/trace.c b/fs/nfsd/trace.c
index f008b95ceec2..e6857b8bdf2b 100644
--- a/fs/nfsd/trace.c
+++ b/fs/nfsd/trace.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/nfs4.h>
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77b7e8a45776..4167726fe835 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -511,6 +511,50 @@ TRACE_EVENT(nfsd_clid_inuse_err,
 		__entry->cl_boot, __entry->cl_id)
 )
 
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
+	TP_printk("xid=0x%08x type=%s access=%s owner=%u/%u user=%u/%u name=%s status=%d",
+		__entry->xid,
+		show_inode_type(__entry->type),
+		show_perm_flags(__entry->access),
+		__entry->owner, __entry->owner_group,
+		__entry->user, __entry->user_group,
+		__get_str(name), __entry->status
+	)
+);
+
 /*
  * from fs/nfsd/filecache.h
  */
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


