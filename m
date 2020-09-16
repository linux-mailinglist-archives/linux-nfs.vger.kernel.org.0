Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217B726CEB1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIPWXo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIPWXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A31C0698C1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:24 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id u18so230641iln.13
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xnim2Q4YvX+w1VQp9KT2rA97PP0KL+1kSWsKdOfhxT0=;
        b=FWFmUKyyaWtVku/s4VEUhxOBniwbGsEBt7B+tRlh13NYfA4M8DMGnR7HPDZMM8jfOa
         weEkA8nyxrNwTLyr2fyevmWNUz56BD7ukL6Mt5KO9+LwIm6kXzFRxZrcBBSVwUfiVBE/
         F3+dBFQfQ5Fl7Oo05/9wV1FPbxqaSyQBueWxO++KXx9T44QkdsHeeOcQna1X5RtewERF
         XyX3hAi9T2vD4TL/ebl47M+NI2dnMOPpxzRWITqjqDUAE4u5iaYCVSvkJUYUrlRJfOOF
         qZL6Y0Tm4PRoqzNouSPhPIHpTrCR4LBejoFMSL8GVOEu9T2aQJxpx9qqx+qIXcfuW1i4
         hH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xnim2Q4YvX+w1VQp9KT2rA97PP0KL+1kSWsKdOfhxT0=;
        b=A3+DB7W8JKeY5yYDN34OUZG7KKmRZxZFbnB4tQzIPQa/iX/gOEbyBrEvzBN/lJistc
         o2bvqaZsQKNeoirwK6BX5oMvAK+qPgvj+lo4ovVpvc0ixrXc8Iy1iYzghdftJVKbSxP/
         5mfGCTkzPZrtuujHV6revO9I22viDoVoJgnKMl0fIGM+QL+DJBH/8GgRjCyN8pzIuC5k
         iqI+tBnWOjX4AVGf3XM0K+qvIDlXjquzz9Myd/eXvBGJWgeOj+65y/stL31sjZ5XkrMM
         s+2whByCt3shHdjoUbT/1sWN3RBqa3lOUbQFM3qrkLg5mKKUcwXmP9G8z88vK+ASzXWs
         z4qQ==
X-Gm-Message-State: AOAM5310M/whxdTTdIB4VWQFOoPKmzmAxWbLgm1HLH1zHFH2PI15tyee
        y1Vh+VxJN3HCR7+LWvi2mQI0gC867MI=
X-Google-Smtp-Source: ABdhPJz2JLft3OZLRnTiWsKuV4uSJHzD2cADqSccOE8BfGLbo9V5XnuaG5VOMCIrc9fbQ7PxxI2l5g==
X-Received: by 2002:a05:6e02:c07:: with SMTP id d7mr23495753ile.301.1600292603907;
        Wed, 16 Sep 2020 14:43:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s2sm11854112ili.49.2020.09.16.14.43.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:22 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLhLT7023017;
        Wed, 16 Sep 2020 21:43:21 GMT
Subject: [PATCH RFC 13/21] NFSD: Add GETATTR tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:21 -0400
Message-ID: <160029260189.29208.3666127728510734668.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4proc.c |    2 +
 fs/nfsd/trace.h    |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a718097b5330..6206ba7b1ac7 100644
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
index 8da691b642ac..48250610dfa4 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -918,6 +918,149 @@ TRACE_EVENT(nfsd4_fh_current,
 		__entry->xid, __entry->fh_hash, __get_str(name))
 );
 
+/*
+ * from include/linux/nfs4.h
+ */
+#define FATTR4_WORD0_FLAGS					\
+	fattr4_word0_bit(SUPPORTED_ATTRS)			\
+	fattr4_word0_bit(TYPE)					\
+	fattr4_word0_bit(FH_EXPIRE_TYPE)			\
+	fattr4_word0_bit(CHANGE)				\
+	fattr4_word0_bit(SIZE)					\
+	fattr4_word0_bit(LINK_SUPPORT)				\
+	fattr4_word0_bit(SYMLINK_SUPPORT)			\
+	fattr4_word0_bit(NAMED_ATTR)				\
+	fattr4_word0_bit(FSID)					\
+	fattr4_word0_bit(UNIQUE_HANDLES)			\
+	fattr4_word0_bit(LEASE_TIME)				\
+	fattr4_word0_bit(RDATTR_ERROR)				\
+	fattr4_word0_bit(ACL)					\
+	fattr4_word0_bit(ACLSUPPORT)				\
+	fattr4_word0_bit(ARCHIVE)				\
+	fattr4_word0_bit(CANSETTIME)				\
+	fattr4_word0_bit(CASE_INSENSITIVE)			\
+	fattr4_word0_bit(CASE_PRESERVING)			\
+	fattr4_word0_bit(CHOWN_RESTRICTED)			\
+	fattr4_word0_bit(FILEHANDLE)				\
+	fattr4_word0_bit(FILEID)				\
+	fattr4_word0_bit(FILES_AVAIL)				\
+	fattr4_word0_bit(FILES_FREE)				\
+	fattr4_word0_bit(FILES_TOTAL)				\
+	fattr4_word0_bit(FS_LOCATIONS)				\
+	fattr4_word0_bit(HIDDEN)				\
+	fattr4_word0_bit(HOMOGENEOUS)				\
+	fattr4_word0_bit(MAXFILESIZE)				\
+	fattr4_word0_bit(MAXLINK)				\
+	fattr4_word0_bit(MAXNAME)				\
+	fattr4_word0_bit(MAXREAD)				\
+	fattr4_word0_bit_end(MAXWRITE)
+
+#undef fattr4_word0_bit
+#undef fattr4_word0_bit_end
+#define fattr4_word0_bit(x)		TRACE_DEFINE_ENUM(FATTR4_WORD0_##x);
+#define fattr4_word0_bit_end(x)		TRACE_DEFINE_ENUM(FATTR4_WORD0_##x);
+
+FATTR4_WORD0_FLAGS
+
+#undef fattr4_word0_bit
+#undef fattr4_word0_bit_end
+#define fattr4_word0_bit(x)		{ FATTR4_WORD0_##x, #x },
+#define fattr4_word0_bit_end(x)		{ FATTR4_WORD0_##x, #x }
+
+#define show_fattr4_bm_word0(x)	__print_flags(x, "|", FATTR4_WORD0_FLAGS)
+
+#define FATTR4_WORD1_FLAGS					\
+	fattr4_word1_bit(MIMETYPE)				\
+	fattr4_word1_bit(MODE)					\
+	fattr4_word1_bit(NO_TRUNC)				\
+	fattr4_word1_bit(NUMLINKS)				\
+	fattr4_word1_bit(OWNER)					\
+	fattr4_word1_bit(OWNER_GROUP)				\
+	fattr4_word1_bit(QUOTA_HARD)				\
+	fattr4_word1_bit(QUOTA_SOFT)				\
+	fattr4_word1_bit(QUOTA_USED)				\
+	fattr4_word1_bit(RAWDEV)				\
+	fattr4_word1_bit(SPACE_AVAIL)				\
+	fattr4_word1_bit(SPACE_FREE)				\
+	fattr4_word1_bit(SPACE_TOTAL)				\
+	fattr4_word1_bit(SPACE_USED)				\
+	fattr4_word1_bit(SYSTEM)				\
+	fattr4_word1_bit(TIME_ACCESS)				\
+	fattr4_word1_bit(TIME_ACCESS_SET)			\
+	fattr4_word1_bit(TIME_BACKUP)				\
+	fattr4_word1_bit(TIME_CREATE)				\
+	fattr4_word1_bit(TIME_DELTA)				\
+	fattr4_word1_bit(TIME_METADATA)				\
+	fattr4_word1_bit(TIME_MODIFY)				\
+	fattr4_word1_bit(TIME_MODIFY_SET)			\
+	fattr4_word1_bit(MOUNTED_ON_FILEID)			\
+	fattr4_word1_bit_end(FS_LAYOUT_TYPES)
+
+#undef fattr4_word1_bit
+#undef fattr4_word1_bit_end
+#define fattr4_word1_bit(x)		TRACE_DEFINE_ENUM(FATTR4_WORD1_##x);
+#define fattr4_word1_bit_end(x)		TRACE_DEFINE_ENUM(FATTR4_WORD1_##x);
+
+FATTR4_WORD1_FLAGS
+
+#undef fattr4_word1_bit
+#undef fattr4_word1_bit_end
+#define fattr4_word1_bit(x)		{ FATTR4_WORD1_##x, #x },
+#define fattr4_word1_bit_end(x)		{ FATTR4_WORD1_##x, #x }
+
+#define show_fattr4_bm_word1(x)	__print_flags(x, "|", FATTR4_WORD1_FLAGS)
+
+#define FATTR4_WORD2_FLAGS					\
+	fattr4_word2_bit(LAYOUT_TYPES)				\
+	fattr4_word2_bit(LAYOUT_BLKSIZE)			\
+	fattr4_word2_bit(MDSTHRESHOLD)				\
+	fattr4_word2_bit(SUPPATTR_EXCLCREAT)			\
+	fattr4_word2_bit(CLONE_BLKSIZE)				\
+	fattr4_word2_bit(CHANGE_ATTR_TYPE)			\
+	fattr4_word2_bit(SECURITY_LABEL)			\
+	fattr4_word2_bit(MODE_UMASK)				\
+	fattr4_word2_bit_end(XATTR_SUPPORT)
+
+#undef fattr4_word2_bit
+#undef fattr4_word2_bit_end
+#define fattr4_word2_bit(x)		TRACE_DEFINE_ENUM(FATTR4_WORD2_##x);
+#define fattr4_word2_bit_end(x)		TRACE_DEFINE_ENUM(FATTR4_WORD2_##x);
+
+FATTR4_WORD2_FLAGS
+
+#undef fattr4_word2_bit
+#undef fattr4_word2_bit_end
+#define fattr4_word2_bit(x)		{ FATTR4_WORD2_##x, #x },
+#define fattr4_word2_bit_end(x)		{ FATTR4_WORD2_##x, #x }
+
+#define show_fattr4_bm_word2(x)	__print_flags(x, "|", FATTR4_WORD2_FLAGS)
+
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
+		show_fattr4_bm_word0(__entry->bm0),
+		show_fattr4_bm_word1(__entry->bm1),
+		show_fattr4_bm_word2(__entry->bm2)
+	)
+);
+
 TRACE_EVENT(nfsd_setattr_args,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,


