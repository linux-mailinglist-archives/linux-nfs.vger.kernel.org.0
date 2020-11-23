Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC472C15F5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgKWUJ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbgKWUJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:54 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD6AC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:54 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so14345244qtw.9
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0/vbsUMIt9/2qb+yufmXMQ9nPbCmEuG07gvMLR2Mjjo=;
        b=p90yBdFqNT7XNXILC51hHLIjcc7TD+afvdyFc3Awa2UYa1ShLHi5ehMIbbtcNknwnj
         Pnm6VTR6YSdrOuYIKWDlOhwL2/GqHmp2xOlxyaPQXCTNPB5U0be9Z23fpuRyMsQxYzSS
         vfgytTJcBmwYzGzf508sWgJVi5+eXlJOrcLQasrkqA5SwcdXp72vI8RSvbhQHUm1nvqP
         krB9ild0cBLyudpiSYTh45yq0/p0VEMddQh41ZtZsw0T/rRxg9CCXpObw4qhiCJKmK7y
         Cj44vARnid95Eiwl1EJpM3Al/gd/uoDxYFsMYnpESTzHPGfr+UbDN3vs4ygLWoEebxiz
         nEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0/vbsUMIt9/2qb+yufmXMQ9nPbCmEuG07gvMLR2Mjjo=;
        b=QhH98OJ/WXzHJRc0tE52YCQqAa0NLq1JIASeaFZP01Ww39lbu65yOTkBVpEP0YpPuW
         86i+20uTi2NVSLFzMXS+c06rlCZ32AITwikxin5HLskAi6bMRnREvX9CDSTVX+LWeilY
         Q/PiQBTDCMgyB46QLWS2RgO+DA/4qWvmg4bBpd7EINXjLXT2lbXmBQWak5ygV0DbiKb0
         0GKuXLZzpDvO2ZbP4NbZOeGDHQR29LhSkVsxTXECbpK6B5yXbKhQxD8cgFu1Be3ueezD
         VyQC2zgZSaU0ZUjRG8IKBYwmZUtD7UV0CB42N6hX/RYsBeByJN97UzD7TGFWoziFiZj4
         RTxQ==
X-Gm-Message-State: AOAM530K1bgatAABNMiE14Y6Mgy0fqm8LrYW2fBLmlIO6xz64pP3NLSU
        XKOURVKDtC380jsa69G5dSChjqj+T0E=
X-Google-Smtp-Source: ABdhPJwsVNnmFUK3a4f8Vb85118mhi5A6+9RqLaxeBK5aHvpSxOsC/fzsMR2pMS47YAp3DuTh7qr8w==
X-Received: by 2002:ac8:3707:: with SMTP id o7mr898240qtb.344.1606162193518;
        Mon, 23 Nov 2020 12:09:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n21sm5260850qke.32.2020.11.23.12.09.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:52 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9psl010477
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:51 GMT
Subject: [PATCH v3 67/85] NFSD: Replace READ* macros in
 nfsd4_decode_layoutreturn()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:51 -0500
Message-ID: <160616219187.51996.1087900867142675882.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   72 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 89b5b919beab..f93a0b9f202f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -660,6 +660,43 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_layoutreturn4(struct nfsd4_compoundargs *argp,
+			   struct nfsd4_layoutreturn *lrp)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_return_type) < 0)
+		return nfserr_bad_xdr;
+	switch (lrp->lr_return_type) {
+	case RETURN_FILE:
+		if (xdr_stream_decode_u64(argp->xdr, &lrp->lr_seg.offset) < 0)
+			return nfserr_bad_xdr;
+		if (xdr_stream_decode_u64(argp->xdr, &lrp->lr_seg.length) < 0)
+			return nfserr_bad_xdr;
+		status = nfsd4_decode_stateid4(argp, &lrp->lr_sid);
+		if (status)
+			return status;
+		if (xdr_stream_decode_u32(argp->xdr, &lrp->lrf_body_len) < 0)
+			return nfserr_bad_xdr;
+		if (lrp->lrf_body_len > 0) {
+			lrp->lrf_body = xdr_inline_decode(argp->xdr, lrp->lrf_body_len);
+			if (!lrp->lrf_body)
+				return nfserr_bad_xdr;
+		}
+		break;
+	case RETURN_FSID:
+	case RETURN_ALL:
+		lrp->lr_seg.offset = 0;
+		lrp->lr_seg.length = NFS4_MAX_UINT64;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 #endif /* CONFIG_NFSD_PNFS */
 
 static __be32
@@ -1871,34 +1908,13 @@ static __be32
 nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutreturn *lrp)
 {
-	DECODE_HEAD;
-
-	READ_BUF(16);
-	lrp->lr_reclaim = be32_to_cpup(p++);
-	lrp->lr_layout_type = be32_to_cpup(p++);
-	lrp->lr_seg.iomode = be32_to_cpup(p++);
-	lrp->lr_return_type = be32_to_cpup(p++);
-	if (lrp->lr_return_type == RETURN_FILE) {
-		READ_BUF(16);
-		p = xdr_decode_hyper(p, &lrp->lr_seg.offset);
-		p = xdr_decode_hyper(p, &lrp->lr_seg.length);
-
-		status = nfsd4_decode_stateid(argp, &lrp->lr_sid);
-		if (status)
-			return status;
-
-		READ_BUF(4);
-		lrp->lrf_body_len = be32_to_cpup(p++);
-		if (lrp->lrf_body_len > 0) {
-			READ_BUF(lrp->lrf_body_len);
-			READMEM(lrp->lrf_body, lrp->lrf_body_len);
-		}
-	} else {
-		lrp->lr_seg.offset = 0;
-		lrp->lr_seg.length = NFS4_MAX_UINT64;
-	}
-
-	DECODE_TAIL;
+	if (xdr_stream_decode_bool(argp->xdr, &lrp->lr_reclaim) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_layout_type) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_seg.iomode) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_layoutreturn4(argp, lrp);
 }
 #endif /* CONFIG_NFSD_PNFS */
 


