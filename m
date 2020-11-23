Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E622C159C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgKWUFJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgKWUFJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:09 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D035C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:08 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i199so4774546qke.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jxOyeZahZWSY/Hxf4QXHLYVx5g9HfKAFTcAru2xkFsA=;
        b=AI8eWPqzT0IjCA+YxJAV9ej86pIc23LmUmiJ69p0vYY0J/mh5V9fbAetQECgZzfiw0
         Wew87Hui1a8gCFH3M5ltpXkOxSLzIi/RsaM9bwEk1LLc9zU/H0dNebIdglHd6mlpTLUC
         fv6r9/Db4rtR8DEuVIEaJcJzojsrO1witalcIkVbHzIaP5PvFFUzVmCrI5s0urU7xaQ7
         3cBwzLlUxnPj7l7Jakw3ZvvsbvMujj8QJCVIYPUn1tTgH+7uDp8/B5erHwb7HPo67kaw
         V2BJVBENJO5zp+OuetQ8y8G+U4W/eAszO1lMF7RwSYJX1WCD7AsgSaq5e5GjlyebGRaf
         d8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jxOyeZahZWSY/Hxf4QXHLYVx5g9HfKAFTcAru2xkFsA=;
        b=RhPB4Db1WEU62D+ck/LkPa7csSOYBwqWo3qX4xU14S6yUmLR9gz55/ieu9ZnimI+HT
         cTFWJaB5AIEepAWAiqHkgmWnXPrKuYo7ITwwz+j2PNi14ZTAvz+Ui3lglhHWFkyh3Ba/
         /ocv3zp00DYZGZpTOKdEj54wdPlTZ6plz7CcVg9bCLdJzM+8p9c72YapKqQHgZjDvG0o
         4ROfnFY5r6ZU4Kl2M8OcMX67F0HSF6jW3emPCbnN4ow9jmLKDKJhf8dd3EYngysEe7G5
         BjZR4WPx92EMCdtFinz37yhjTqWo09/WRJPu8BWA3MFUrdt+x53eEjJgSnZzMF4rvw2e
         fnSg==
X-Gm-Message-State: AOAM531mvcRjsIxWlPYQDKTSgNWweJi89RmehNckvCYMIonZ7LM85m9n
        zvER7cmI1+n812a8hDGha1ATdqNMYwI=
X-Google-Smtp-Source: ABdhPJykUXXKBI8WlrDoj0jdipsKvgNQSXOoDydWNmg3TqoFXtJuhD7uaroGASxD/kFhn4xo5fFRxw==
X-Received: by 2002:a37:6594:: with SMTP id z142mr1222063qkb.115.1606161904273;
        Mon, 23 Nov 2020 12:05:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r14sm10482556qtu.25.2020.11.23.12.05.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK522f010304
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:02 GMT
Subject: [PATCH v3 12/85] NFSD: Replace READ* macros that decode the fattr4
 acl attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:02 -0500
Message-ID: <160616190235.51996.16689530413211925078.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity and to move infrequently-used code out of line.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  107 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ec47efd68c72..273d5f849df8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -245,6 +245,70 @@ nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
 	DECODE_TAIL;
 }
 
+static __be32
+nfsd4_decode_nfsace4(struct nfsd4_compoundargs *argp, struct nfs4_ace *ace)
+{
+	__be32 *p, status;
+	u32 length;
+
+	if (xdr_stream_decode_u32(argp->xdr, &ace->type) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &ace->flag) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &ace->access_mask) < 0)
+		return nfserr_bad_xdr;
+
+	if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, length);
+	if (!p)
+		return nfserr_bad_xdr;
+	ace->whotype = nfs4_acl_get_whotype((char *)p, length);
+	if (ace->whotype != NFS4_ACL_WHO_NAMED)
+		status = nfs_ok;
+	else if (ace->flag & NFS4_ACE_IDENTIFIER_GROUP)
+		status = nfsd_map_name_to_gid(argp->rqstp,
+				(char *)p, length, &ace->who_gid);
+	else
+		status = nfsd_map_name_to_uid(argp->rqstp,
+				(char *)p, length, &ace->who_uid);
+
+	return status;
+}
+
+/* A counted array of nfsace4's */
+static noinline __be32
+nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl)
+{
+	struct nfs4_ace *ace;
+	__be32 status;
+	u32 count;
+
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+
+	if (count > xdr_stream_remaining(argp->xdr) / 20)
+		/*
+		 * Even with 4-byte names there wouldn't be
+		 * space for that many aces; something fishy is
+		 * going on:
+		 */
+		return nfserr_fbig;
+
+	*acl = svcxdr_tmpalloc(argp, nfs4_acl_bytes(count));
+	if (*acl == NULL)
+		return nfserr_jukebox;
+
+	(*acl)->naces = count;
+	for (ace = (*acl)->aces; ace < (*acl)->aces + count; ace++) {
+		status = nfsd4_decode_nfsace4(argp, ace);
+		if (status)
+			return status;
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		   struct iattr *iattr, struct nfs4_acl **acl,
@@ -281,46 +345,9 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		iattr->ia_valid |= ATTR_SIZE;
 	}
 	if (bmval[0] & FATTR4_WORD0_ACL) {
-		u32 nace;
-		struct nfs4_ace *ace;
-
-		READ_BUF(4);
-		nace = be32_to_cpup(p++);
-
-		if (nace > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))
-			/*
-			 * Even with 4-byte names there wouldn't be
-			 * space for that many aces; something fishy is
-			 * going on:
-			 */
-			return nfserr_fbig;
-
-		*acl = svcxdr_tmpalloc(argp, nfs4_acl_bytes(nace));
-		if (*acl == NULL)
-			return nfserr_jukebox;
-
-		(*acl)->naces = nace;
-		for (ace = (*acl)->aces; ace < (*acl)->aces + nace; ace++) {
-			READ_BUF(16);
-			ace->type = be32_to_cpup(p++);
-			ace->flag = be32_to_cpup(p++);
-			ace->access_mask = be32_to_cpup(p++);
-			dummy32 = be32_to_cpup(p++);
-			READ_BUF(dummy32);
-			READMEM(buf, dummy32);
-			ace->whotype = nfs4_acl_get_whotype(buf, dummy32);
-			status = nfs_ok;
-			if (ace->whotype != NFS4_ACL_WHO_NAMED)
-				;
-			else if (ace->flag & NFS4_ACE_IDENTIFIER_GROUP)
-				status = nfsd_map_name_to_gid(argp->rqstp,
-						buf, dummy32, &ace->who_gid);
-			else
-				status = nfsd_map_name_to_uid(argp->rqstp,
-						buf, dummy32, &ace->who_uid);
-			if (status)
-				return status;
-		}
+		status = nfsd4_decode_acl(argp, acl);
+		if (status)
+			return status;
 	} else
 		*acl = NULL;
 	if (bmval[1] & FATTR4_WORD1_MODE) {


