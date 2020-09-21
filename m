Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9502731A1
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgIUSLz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgIUSLz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:11:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC63C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g7so16402355iov.13
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FADvt6A/YCk82UfIN1q3TC0MPSikLP+fAtYvDB0+w68=;
        b=kSVVa2HeJd0NwoIJUMPxIghNjlPTBGL69JyHyHdxzo5zPea/AvsEcOuKPlmMzaT5Mr
         AwUI78yoZCoM8IxW39359y/VI511kZDUn3rCYFHrP1aIeWrFvP1k5puhwehERNAPDCiF
         EefyPJi6LAcEdhtvHF+szlbcKY9QJqUQNjyA2f63NdjranD9xDH3JyhFU4aO9bOb2sE1
         C5G1Xyc60WEaykaOx0dfDjMAp1usD28eFQ1fi9LkK/612/T8+Ni3P0yyIdDcK7S/kbAS
         1g4zY9gNhil8zPN42dnR1eXytss2VHBDyiBpFX4Jwn4lmE7OA2PFgYYX7PO4FvBEI66u
         z6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=FADvt6A/YCk82UfIN1q3TC0MPSikLP+fAtYvDB0+w68=;
        b=MirOU3xFigD31Z2ww1dJfPDdL+cFwZWNjM5EwIlhlcUvHWzMh3oCF/Blxyoiv0+lO6
         I5Q1ugQgEnoiWtDIoXCz94ztAfNNcv+pyEIuJGC3Cwv7znhvM098cjdu7xUrbFtsEfJ/
         rFWnzsBr0AED73R7UfPHmq5cmgyohKaIXvpmv2iISRxICuJ+dOehe4rY0G6uEuG3DmaN
         Y+OJkCnBfOaeI6/NTInyfkA3f7PypMY0kSZGBl+MVQ+MrYsWC8us+9q58Xs+rjcmu1vk
         XYaY2VjYJQbGWOfzTeEnaSUxBpSqRfpkbEtfetCTH9DVkt+sHsvIt0sasDg/56/po61m
         ibFw==
X-Gm-Message-State: AOAM5335bah98iHS5OgZtJRGkO905ziaxav3wQ2rQ4Sj+vr4zmVqJ71v
        HVdIUHXVIKdJhvuwdtG5sXXXncF6FbU=
X-Google-Smtp-Source: ABdhPJy9YpCoqP3BI1Nhrk34j2oH9rZZCMWavZMurFK5VzPJpoQFZoP9nu8ULW4cPKfTqjS4FlPpnA==
X-Received: by 2002:a05:6638:248d:: with SMTP id x13mr1039993jat.39.1600711914880;
        Mon, 21 Sep 2020 11:11:54 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b12sm7450779ilq.53.2020.09.21.11.11.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:11:54 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIBrVC003878;
        Mon, 21 Sep 2020 18:11:53 GMT
Subject: [PATCH v2 12/27] NFSD: Add tracepoint in nfsd_setattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:11:53 -0400
Message-ID: <160071191326.1468.16608972172945152910.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Capture especially the XID, file handle, and attr mask for
troubleshooting. So for example:

nfsd-1025  [002]   256.807363: nfsd_setattr:         xid=0x12147d7a fh_hash=0x6085d6fb valid=MODE|ATIME|MTIME

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h           |   24 ++++++++++++++++++++++++
 fs/nfsd/vfs.c             |    2 ++
 include/trace/events/fs.h |   20 ++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 62bf57a8d03c..b4c773530aa8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -9,6 +9,7 @@
 #define _NFSD_TRACE_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/fs.h>
 
 #include "export.h"
 #include "nfsfh.h"
@@ -29,6 +30,29 @@
 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
 		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
 
+TRACE_EVENT(nfsd_setattr_args,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		unsigned int valid
+	),
+	TP_ARGS(rqstp, fhp, valid),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(unsigned long, valid)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->valid = valid;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x valid=%s",
+		__entry->xid, __entry->fh_hash,
+		show_attr_valid_flags(__entry->valid)
+	)
+);
+
 TRACE_EVENT(nfsd_compound,
 	TP_PROTO(const struct svc_rqst *rqst,
 		 u32 args_opcnt),
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1ecaceebee13..a311593ac976 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -375,6 +375,8 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 
+	trace_nfsd_setattr_args(rqstp, fhp, iap->ia_valid);
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype = S_IFREG;
diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
index 8ea0e84e425a..2b185d81d9a5 100644
--- a/include/trace/events/fs.h
+++ b/include/trace/events/fs.h
@@ -145,3 +145,23 @@
 		{ LOOKUP_NO_XDEV,	"NO_XDEV" }, \
 		{ LOOKUP_BENEATH,	"BENEATH" }, \
 		{ LOOKUP_IN_ROOT,	"IN_ROOT" })
+
+#define show_attr_valid_flags(x) \
+	__print_flags(x, "|", \
+		{ ATTR_MODE,		"MODE" }, \
+		{ ATTR_UID,		"UID" }, \
+		{ ATTR_GID,		"GID" }, \
+		{ ATTR_SIZE,		"SIZE" }, \
+		{ ATTR_ATIME,		"ATIME" }, \
+		{ ATTR_MTIME,		"MTIME" }, \
+		{ ATTR_CTIME,		"CTIME" }, \
+		{ ATTR_ATIME_SET,	"ATIME_SET" }, \
+		{ ATTR_MTIME_SET,	"MTIME_SET" }, \
+		{ ATTR_FORCE,		"FORCE" }, \
+		{ ATTR_KILL_SUID,	"KILL_SUID" }, \
+		{ ATTR_KILL_SGID,	"KILL_SGID" }, \
+		{ ATTR_FILE,		"FILE" }, \
+		{ ATTR_KILL_PRIV,	"KILL_PRIV" }, \
+		{ ATTR_OPEN,		"OPEN" }, \
+		{ ATTR_TIMES_SET,	"TIMES_SET" }, \
+		{ ATTR_TOUCH,		"TOUCH" })


