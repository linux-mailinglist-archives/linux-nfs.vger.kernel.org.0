Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D152BB729
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgKTUfO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgKTUfO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:14 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E483C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:14 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so8072806qtb.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2D6wigp8z+q3FRMJJM47VSb1/PHwjQaLfBSUtZmYVyA=;
        b=MPvtmSLkOkx7p/ZGvWBZ8BpmO/yKdaKRbIh4CGrGkoy5g2uiqy3fyeR2jlWTaQvlJl
         GtJW33KTxWsMyN8NkRZlLRpihtGDEUnUMpJ/XNLJF/0QFQ9Qy4MgxGkM64J+hQV7b+FU
         Hk1YgjbLsb0SCBoOhu9uULK1wJh1ZSdD3I+gAupKc2+gxjXTiitL4pqwYFSE802tfy4+
         +CsGdZdZyGuqDA+IWjOYy3Tj0Ig7t502hWj+RXE/ly1EwIMzroDnX9kQnISZtdisituO
         HUARosUnuBP9bIEcvB89O+IAZx33NwGP/2TzYb8lFyzAxy2gxYb9VjaMNR5h224G6iE4
         ZWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2D6wigp8z+q3FRMJJM47VSb1/PHwjQaLfBSUtZmYVyA=;
        b=NmEkAtqd2OhgwtX4nhlTgrTO5xjwhtNZjhVwbE9dJ7o7eQ7QLRkgwZRk6mFcqT4kIv
         O9ketgCaw+p/LJrI7UUJGL1T560BgL3zXSYkKdBr894gP5qXQ/vsPJfDUXmBYk2E30Q0
         H+17DOJS/WubqUTp1blOuwXhXcylSQe91W57K7WjaeZ2ueVqpahKH2tRDVqo0+dWbDhY
         7U3NJi3xAuQteL8yFvnmLvmc9d3mvF6rRpSKTuKe3oOL84xDqtsPiVFJJqcY6E1I1HQw
         6rNAxk8IcdCuDXK1cCjemx8WbmiQF+rLO7pZ+A5fHAcmMHLOgaVg8+fOTxCjojoB9i2S
         P7yA==
X-Gm-Message-State: AOAM5302VJuU3SnfnVIv2NMhHRcvyTraeY4GPqwzJoqTAQC6keUZ7GLH
        1BP5nA7ntG/y1JjDKoNNClrd4qGwX1A=
X-Google-Smtp-Source: ABdhPJzXQWwzb/E2lnZM+ozCGX70JBvKR6my8OTj7dR3HQNH32nHOoQ8xIVkqwZxpGhTOZwKxvvoLw==
X-Received: by 2002:ac8:7c9a:: with SMTP id y26mr17562189qtv.287.1605904512874;
        Fri, 20 Nov 2020 12:35:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p73sm2809479qka.79.2020.11.20.12.35.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:12 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZBUw029250
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:11 GMT
Subject: [PATCH v2 016/118] NFSD: Replace READ* macros that decode the fattr4
 time_set attributes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:11 -0500
Message-ID: <160590451112.1340.10988510511242299987.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 53cd69ff54f7..16aded9bcf3a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -217,6 +217,21 @@ nfsd4_decode_time(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 	DECODE_TAIL;
 }
 
+static __be32
+nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, XDR_UNIT * 3);
+	if (!p)
+		return nfserr_bad_xdr;
+	p = xdr_decode_hyper(p, &tv->tv_sec);
+	tv->tv_nsec = be32_to_cpup(p++);
+	if (tv->tv_nsec >= (u32)1000000000)
+		return nfserr_inval;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
 {
@@ -386,11 +401,13 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		iattr->ia_valid |= ATTR_GID;
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		switch (dummy32) {
+		u32 set_it;
+
+		if (xdr_stream_decode_u32(argp->xdr, &set_it) < 0)
+			return nfserr_bad_xdr;
+		switch (set_it) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			status = nfsd4_decode_time(argp, &iattr->ia_atime);
+			status = nfsd4_decode_nfstime4(argp, &iattr->ia_atime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
@@ -399,15 +416,17 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			iattr->ia_valid |= ATTR_ATIME;
 			break;
 		default:
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		}
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		switch (dummy32) {
+		u32 set_it;
+
+		if (xdr_stream_decode_u32(argp->xdr, &set_it) < 0)
+			return nfserr_bad_xdr;
+		switch (set_it) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			status = nfsd4_decode_time(argp, &iattr->ia_mtime);
+			status = nfsd4_decode_nfstime4(argp, &iattr->ia_mtime);
 			if (status)
 				return status;
 			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
@@ -416,7 +435,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			iattr->ia_valid |= ATTR_MTIME;
 			break;
 		default:
-			goto xdr_error;
+			return nfserr_bad_xdr;
 		}
 	}
 


