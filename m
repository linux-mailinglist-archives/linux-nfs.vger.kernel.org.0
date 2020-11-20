Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85A22BB725
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgKTUex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbgKTUew (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:52 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96515C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:52 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so5316190qvb.6
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bX2hgvPHjRKIZo3eq4e8Pc6e1gIOZIzj2v89v/ca7hw=;
        b=UbLk+juP/pOyhJLJ+uMH1WjKj2fxewiP0BlWBOHdY/OTbJDv1DtMR1wRVDvxz5NBZk
         DNKf0OIzPTG5IHq6W3yIzZiLN3Bcm5656t27oabGB4D59GUdmjCoviPARtxKCdCTQTgq
         CyedSaicegd1MVzXxP4CYX1AKzIgD/lMJw8B/YLHMO6Y+urwR+oOTRJXV3h/d3NQgo0t
         CN9UHl5PThKDAuJPQt/uq9EcOspEBLguSadlmNNrq5cLWdYU/DjpWlXMvtAquI7E4Byj
         M/oJS36Edwuk+lPpJCdWTBJOW/RwC1b8/JPGnVyHDjp0MXbaK+iElM2XaWPVnhm9OBgy
         Y6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bX2hgvPHjRKIZo3eq4e8Pc6e1gIOZIzj2v89v/ca7hw=;
        b=nBLFiLE4vTdcWnlu4jspn2eL7T8dDhP7G2krMYL22cWj/2v/pYDatGtpJ/1R2H7i1P
         QWGjVqXIABuWcHp6+xjUvU9kk9fy2D1SO1VUZNE2G8BdmzJPFFjjwRz94hPwB+aWR/pd
         i/dMDGmun2eoz5Ab8dZCf1xU0bfBbhctgsK/w36eLwywgUf7crFk616yJV7x34BapSW2
         32NMLu0BNMwQ5Qa/lSqZWKSOZ1rUW4U3syXVC44ABMyfLEWRFhYZBiZoZgZlVMOqACTY
         uPeO/x2bni1nDWscskrwZ4sTxBRicDyHJ54GWfgtFVf7TR8mywnzSQg7rbxRzTOCT0BN
         kShg==
X-Gm-Message-State: AOAM531GVJcZIjlGZS2uPueZGI1ByWdWPX9/aQkZRJoZHneYXDWOWp60
        70uXimXk4WPbMm1U075AbQXBUW54gPg=
X-Google-Smtp-Source: ABdhPJwk8H7arb4M3u2s44Y/U4IuTDgmiCKG2iQfi3lwiYcx8fqJTlu/j2rwSowni6hj8GVjWvDMTg==
X-Received: by 2002:a0c:aed2:: with SMTP id n18mr18554287qvd.4.1605904491457;
        Fri, 20 Nov 2020 12:34:51 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x5sm2682413qtx.61.2020.11.20.12.34.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:50 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYnQW029238
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:49 GMT
Subject: [PATCH v2 012/118] NFSD: Replace READ* macros that decode the fattr4
 acl attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:49 -0500
Message-ID: <160590448974.1340.11466087667900075196.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 9f121698aa92..54c553ef35bf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -243,6 +243,70 @@ nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
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
+	if (count > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))
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
@@ -279,46 +343,9 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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


