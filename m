Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776CD2731A8
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgIUSM1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUSM1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:27 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEFC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z13so16455955iom.8
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=F38pABahs1RzyFKfk/sIiqwVHK1+CjoJmpKlCoXyhGw=;
        b=YEayq8tNLoSnGzujzc3SEv+Zjw5NNx/yg16sps3MlBMCnWPDwFiVX8UX4cYI1K2zdt
         On7RcQAW5+BQTUN1ZJspUH4dIOzXfW1N3u6diJBcRMMeXI4rTYDXpAR2dHnTSOqX5yGI
         zfIuBaLgAmR5lJea5Strxo4KKc55UPsQEHjc5Duwl3+G34COH9usVAU+tFVsciAsptbs
         2dpBrNCQ1aqAOK8nXjlgcpCzqd9eu1ksTfuzp6gcDGy/7Gn9em0chkCWUbRx8aYJDGja
         stFGLq6CAG9zoXdTCCPgu8SfT4c+x/xbD8aqyi/G68ujesmi/7MRinyOVC+KMKZYicMS
         B1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=F38pABahs1RzyFKfk/sIiqwVHK1+CjoJmpKlCoXyhGw=;
        b=SA0ISL/1AgsOG2QSZ/VDxRghV5xeSoRQ+978zWjqxfWYcUuWOB09ooaLsSda1q4dDI
         7EkbHqRba3c54B0KSAIm1eBtjYbKQgq8q3kqiDM28A+KwJztkuMvWyKF0HAyqRR4q+Ro
         Ku8mOCnzuW1Yio890dNcbL6uLEQKpGIQrA11371kZracL7iz3OdiEtftVJ855fsxQyPl
         Umtvx7fev7S2PuYOgH9X7L09CB/pfw4MSqxTsNnpBNbYOgFr/VSm7WqQaUgNBsDumg6N
         px6MDFG4H06bPo8EWJidl2iHOrI2b9fTYJgXzBmhhqJobPu1+1bPX+l3uG5E8pwrTAWi
         EXlQ==
X-Gm-Message-State: AOAM530DkY+IRLUuObniDk58ihE66FJmxk2CjTjdkby+k75zDX1aiBWx
        pQZSFrSVNuzjQICczCSt9rA=
X-Google-Smtp-Source: ABdhPJwmJnapSDa4OA2CTEWKypg56fhHC/xG8QAapw2l2faXe2O6kMYHy5O4Z0FXqE82dkcI8sE4JA==
X-Received: by 2002:a02:780e:: with SMTP id p14mr1064333jac.144.1600711946555;
        Mon, 21 Sep 2020 11:12:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b207sm6191250iof.37.2020.09.21.11.12.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:25 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LICPx9003896;
        Mon, 21 Sep 2020 18:12:25 GMT
Subject: [PATCH v2 18/27] NFSD: Add GETATTR tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:25 -0400
Message-ID: <160071194499.1468.9118433794604497687.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record the set of attributes requested by an NFSv4 client in an
NFSv4 GETATTR request.

nfsd-1034  [002]   164.067026: nfsd_get_fattr4:      xid=0xcb4c4e33 bm[0]=TYPE|CHANGE|SIZE|FSID|FILEID bm[1]=MODE|NUMLINKS|OWNER|OWNER_GROUP|RAWDEV|SPACE_USED|TIME_ACCESS|TIME_METADATA|TIME_MODIFY|MOUNTED_ON_FILEID bm[2]=

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c         |    2 +
 fs/nfsd/trace.h            |   26 +++++++++++++++
 include/trace/events/nfs.h |   75 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e378aa91ba46..065ed5930250 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -706,6 +706,8 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_getattr *getattr = &u->getattr;
 	__be32 status;
 
+	trace_nfsd4_getattr(rqstp, getattr->ga_bmval);
+
 	status = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_NOP);
 	if (status)
 		return status;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c2e72b880e6a..4fb668257ce2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -564,6 +564,32 @@ TRACE_EVENT(nfsd4_fh_current,
 	)
 );
 
+TRACE_EVENT(nfsd4_getattr,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const u32 *bitmask
+	),
+	TP_ARGS(rqstp, bitmask),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(unsigned long, bm0)
+		__field(unsigned long, bm1)
+		__field(unsigned long, bm2)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->bm0 = bitmask[0];
+		__entry->bm1 = bitmask[1];
+		__entry->bm2 = bitmask[2];
+	),
+	TP_printk("xid=0x%08x bm[0]=%s bm[1]=%s bm[2]=%s",
+		__entry->xid,
+		show_nfs4_fattr4_bm_word0(__entry->bm0),
+		show_nfs4_fattr4_bm_word1(__entry->bm1),
+		show_nfs4_fattr4_bm_word2(__entry->bm2)
+	)
+);
+
 #include "state.h"
 #include "filecache.h"
 #include "vfs.h"
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
index a152ed94e538..19f7444e4bb2 100644
--- a/include/trace/events/nfs.h
+++ b/include/trace/events/nfs.h
@@ -388,3 +388,78 @@ TRACE_DEFINE_ENUM(SP4_SSV);
 		{ NFS4_CDFC4_BACK,			"BACK" }, \
 		{ NFS4_CDFC4_FORE_OR_BOTH,		"FORE_OR_BOTH" }, \
 		{ NFS4_CDFC4_BACK_OR_BOTH,		"BACK_OR_BOTH" })
+
+#define show_nfs4_fattr4_bm_word0(x) \
+	__print_flags(x, "|", \
+		{ FATTR4_WORD0_SUPPORTED_ATTRS,		"SUPPORTED_ATTRS" }, \
+		{ FATTR4_WORD0_TYPE,			"TYPE" }, \
+		{ FATTR4_WORD0_FH_EXPIRE_TYPE,		"FH_EXPIRE_TYPE" }, \
+		{ FATTR4_WORD0_CHANGE,			"CHANGE" }, \
+		{ FATTR4_WORD0_SIZE,			"SIZE" }, \
+		{ FATTR4_WORD0_LINK_SUPPORT,		"LINK_SUPPORT" }, \
+		{ FATTR4_WORD0_SYMLINK_SUPPORT,		"SYMLINK_SUPPORT" }, \
+		{ FATTR4_WORD0_NAMED_ATTR,		"NAMED_ATTR" }, \
+		{ FATTR4_WORD0_FSID,			"FSID" }, \
+		{ FATTR4_WORD0_UNIQUE_HANDLES,		"UNIQUE_HANDLES" }, \
+		{ FATTR4_WORD0_LEASE_TIME,		"LEASE_TIME" }, \
+		{ FATTR4_WORD0_RDATTR_ERROR,		"RDATTR_ERROR" }, \
+		{ FATTR4_WORD0_ACL,			"ACL" }, \
+		{ FATTR4_WORD0_ACLSUPPORT,		"ACLSUPPORT" }, \
+		{ FATTR4_WORD0_ARCHIVE,			"ARCHIVE" }, \
+		{ FATTR4_WORD0_CANSETTIME,		"CANSETTIME" }, \
+		{ FATTR4_WORD0_CASE_INSENSITIVE,	"CASE_INSENSITIVE" }, \
+		{ FATTR4_WORD0_CASE_PRESERVING,		"CASE_PRESERVING" }, \
+		{ FATTR4_WORD0_CHOWN_RESTRICTED,	"CHOWN_RESTRICTED" }, \
+		{ FATTR4_WORD0_FILEHANDLE,		"FILEHANDLE" }, \
+		{ FATTR4_WORD0_FILEID,			"FILEID" }, \
+		{ FATTR4_WORD0_FILES_AVAIL,		"FILES_AVAIL" }, \
+		{ FATTR4_WORD0_FILES_FREE,		"FILES_FREE" }, \
+		{ FATTR4_WORD0_FILES_TOTAL,		"FILES_TOTAL" }, \
+		{ FATTR4_WORD0_FS_LOCATIONS,		"FS_LOCATIONS" }, \
+		{ FATTR4_WORD0_HIDDEN,			"HIDDEN" }, \
+		{ FATTR4_WORD0_HOMOGENEOUS,		"HOMOGENEOUS" }, \
+		{ FATTR4_WORD0_MAXFILESIZE,		"MAXFILESIZE" }, \
+		{ FATTR4_WORD0_MAXLINK,			"MAXLINK" }, \
+		{ FATTR4_WORD0_MAXNAME,			"MAXNAME" }, \
+		{ FATTR4_WORD0_MAXREAD,			"MAXREAD" }, \
+		{ FATTR4_WORD0_MAXWRITE,		"MAXWRITE" })
+
+#define show_nfs4_fattr4_bm_word1(x) \
+	__print_flags(x, "|", \
+		{ FATTR4_WORD1_MIMETYPE,		"MIMETYPE" }, \
+		{ FATTR4_WORD1_MODE,			"MODE" }, \
+		{ FATTR4_WORD1_NO_TRUNC,		"NO_TRUNC" }, \
+		{ FATTR4_WORD1_NUMLINKS,		"NUMLINKS" }, \
+		{ FATTR4_WORD1_OWNER,			"OWNER" }, \
+		{ FATTR4_WORD1_OWNER_GROUP,		"OWNER_GROUP" }, \
+		{ FATTR4_WORD1_QUOTA_HARD,		"QUOTA_HARD" }, \
+		{ FATTR4_WORD1_QUOTA_SOFT,		"QUOTA_SOFT" }, \
+		{ FATTR4_WORD1_QUOTA_USED,		"QUOTA_USED" }, \
+		{ FATTR4_WORD1_RAWDEV,			"RAWDEV" }, \
+		{ FATTR4_WORD1_SPACE_AVAIL,		"SPACE_AVAIL" }, \
+		{ FATTR4_WORD1_SPACE_FREE,		"SPACE_FREE" }, \
+		{ FATTR4_WORD1_SPACE_TOTAL,		"SPACE_TOTAL" }, \
+		{ FATTR4_WORD1_SPACE_USED,		"SPACE_USED" }, \
+		{ FATTR4_WORD1_SYSTEM,			"SYSTEM" }, \
+		{ FATTR4_WORD1_TIME_ACCESS,		"TIME_ACCESS" }, \
+		{ FATTR4_WORD1_TIME_ACCESS_SET,		"TIME_ACCESS_SET" }, \
+		{ FATTR4_WORD1_TIME_BACKUP,		"TIME_BACKUP" }, \
+		{ FATTR4_WORD1_TIME_CREATE,		"TIME_CREATE" }, \
+		{ FATTR4_WORD1_TIME_DELTA,		"TIME_DELTA" }, \
+		{ FATTR4_WORD1_TIME_METADATA,		"TIME_METADATA" }, \
+		{ FATTR4_WORD1_TIME_MODIFY,		"TIME_MODIFY" }, \
+		{ FATTR4_WORD1_TIME_MODIFY_SET,		"TIME_MODIFY_SET" }, \
+		{ FATTR4_WORD1_MOUNTED_ON_FILEID,	"MOUNTED_ON_FILEID" }, \
+		{ FATTR4_WORD1_FS_LAYOUT_TYPES,		"FS_LAYOUT_TYPES" })
+
+#define show_nfs4_fattr4_bm_word2(x) \
+	__print_flags(x, "|", \
+		{ FATTR4_WORD2_LAYOUT_TYPES,		"LAYOUT_TYPES" }, \
+		{ FATTR4_WORD2_LAYOUT_BLKSIZE,		"LAYOUT_BLKSIZE" }, \
+		{ FATTR4_WORD2_MDSTHRESHOLD,		"MDSTHRESHOLD" }, \
+		{ FATTR4_WORD2_SUPPATTR_EXCLCREAT,	"SUPPATTR_EXCLCREAT" }, \
+		{ FATTR4_WORD2_CLONE_BLKSIZE,		"CLONE_BLKSIZE" }, \
+		{ FATTR4_WORD2_CHANGE_ATTR_TYPE,	"CHANGE_ATTR_TYPE" }, \
+		{ FATTR4_WORD2_SECURITY_LABEL,		"SECURITY_LABEL" }, \
+		{ FATTR4_WORD2_MODE_UMASK,		"MODE_UMASK" }, \
+		{ FATTR4_WORD2_XATTR_SUPPORT,		"XATTR_SUPPORT" })


