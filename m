Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391061750EE
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgCAXZR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:17 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43719 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAXZQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:16 -0500
Received: by mail-yw1-f67.google.com with SMTP id u78so4672619ywf.10
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds3vP0pr/vApQsOppNkATvBSjNkIOcY6j7wOViIDBOE=;
        b=H26CeLc0sUsga0syMXZMYXJ92gaZFBIxooXue+sTXJvM5DSd8YLkpmU3qvU2nxU+2e
         KHwfdmv1EMPdfYMUUX78a0kDxkuHI6XOtNlzJz8ZotM3FcDtMSk9d+JDI4HPj2b6mMpI
         eBh2+P9wWHo/iTyZ0Cglmn2ZT8C7eTp1SluvLL0O+iiopipTfpXcUlWFYgiKbm02CIu0
         M1vrMhalgdRaZ8TA/f1XEVL+KBUb6MEtRIJ+Q/XaF4pMwwz4j+Hd/2RKtrp9Kyr5zPyd
         KSA+xqRFcnnMMDsKUlVtTvRJkatg9FeIV6LUA55qiKmLKhNx84BA/oikh9X1pvig/N+D
         yw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds3vP0pr/vApQsOppNkATvBSjNkIOcY6j7wOViIDBOE=;
        b=PskLJIqy/IcBsElVCaPclJwWKbJxsh1BsSu9tIxhUZonxmZeb5/7qXFlqwmovewfRf
         o2UG8b9yFFPfQWV+v7l3SRwDlgdIzFoOZGBqPFBPsg2jWZFcXoGJVQw89QFlo1Y+0Bf8
         DhsAe6KcmwgBv5wVOGzZ+a2RkHAAbhkgTOJzFbup5G6IBimliR3VFn6LV0chVNM/59nD
         OTRqzgKx/6FDAeE38LnELYFDfA5F6X39A/wBWGxI7zoG4NTblaoxkX6lQexN4ztnz1sF
         uvwkRJqvyoXVpeP7O/MCbjZKogXo6mTXJUq94XWrhc1IgUJXVxpTQxB8aJHegNG0Iqty
         5r4A==
X-Gm-Message-State: APjAAAUt7pHqNkBJiB5GM7qwfoZkDjTFVCYdhf0K/5Est7hfm9wsKTub
        J55MygE6odkXepaTYZfPnQ==
X-Google-Smtp-Source: APXvYqzl39T8JSRAq1wQN06caINNSaqI71oUCCi5AFECRHz0e/06XWd7l5PeIKI7RpeqkWjEvjKAug==
X-Received: by 2002:a0d:ebc9:: with SMTP id u192mr14379842ywe.360.1583105115924;
        Sun, 01 Mar 2020 15:25:15 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:15 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/8] nfsd: Add tracing to nfsd_set_fh_dentry()
Date:   Sun,  1 Mar 2020 18:21:39 -0500
Message-Id: <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add tracing to allow us to figure out where any stale filehandle issues
may be originating from.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsfh.c | 13 ++++++++++---
 fs/nfsd/trace.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index b319080288c3..37bc8f5f4514 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -14,6 +14,7 @@
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_FH
 
@@ -209,11 +210,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	}
 
 	error = nfserr_stale;
-	if (PTR_ERR(exp) == -ENOENT)
-		return error;
+	if (IS_ERR(exp)) {
+		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp, PTR_ERR(exp));
+
+		if (PTR_ERR(exp) == -ENOENT)
+			return error;
 
-	if (IS_ERR(exp))
 		return nfserrno(PTR_ERR(exp));
+	}
 
 	if (exp->ex_flags & NFSEXP_NOSUBTREECHECK) {
 		/* Elevate privileges so that the lack of 'r' or 'x'
@@ -267,6 +271,9 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		dentry = exportfs_decode_fh(exp->ex_path.mnt, fid,
 				data_left, fileid_type,
 				nfsd_acceptable, exp);
+		if (IS_ERR_OR_NULL(dentry))
+			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
+					dentry ?  PTR_ERR(dentry) : -ESTALE);
 	}
 	if (dentry == NULL)
 		goto out;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 06dd0d337049..9abd1591a841 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -50,6 +50,36 @@ TRACE_EVENT(nfsd_compound_status,
 		__get_str(name), __entry->status)
 )
 
+DECLARE_EVENT_CLASS(nfsd_fh_err_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh	*fhp,
+		 int		status),
+	TP_ARGS(rqstp, fhp, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->status = status;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x status=%d",
+		  __entry->xid, __entry->fh_hash,
+		  __entry->status)
+)
+
+#define DEFINE_NFSD_FH_ERR_EVENT(name)		\
+DEFINE_EVENT(nfsd_fh_err_class, nfsd_##name,	\
+	TP_PROTO(struct svc_rqst *rqstp,	\
+		 struct svc_fh	*fhp,		\
+		 int		status),	\
+	TP_ARGS(rqstp, fhp, status))
+
+DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
+DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
+
 DECLARE_EVENT_CLASS(nfsd_io_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
-- 
2.24.1

