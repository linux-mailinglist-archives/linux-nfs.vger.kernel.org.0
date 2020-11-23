Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51D52C15A3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgKWUFn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKWUFn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:43 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7B5C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:42 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id 7so14374876qtp.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5EyXRboDgcDSU80VZZr3ghNnhuDa+k9qaNIjsxtQUZE=;
        b=kPg0G50mvhNYO+4hUQ2R2S8Ihd5chW4eGR0ub88qmxnsDoI57GTGztnDIKTLdrkiHB
         9LoBIowOfLAs43Kbt475QKme0w9IYQCKA0gDCqmpvDa2t5tDwXhG/TwNOYycyLkX88Sb
         G95RdGOLD65mtvr3di1ly/H32S1IC88BtUI4VDu23p/nl23eYxMu+anTZY7LzwMF83Xz
         I4f4RDOdMVz6LrTIN+guwbyNV8jDbBTnPzRoruDEil6JIygS2GyCVMAPsB2J17X/lpjA
         Bxcu+y3KumJsWVPrmFGQMaBgbLy3VqeW/NjLLEdHJkkFyvlUErZlFlxJ6lbzncM4Gez1
         XZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5EyXRboDgcDSU80VZZr3ghNnhuDa+k9qaNIjsxtQUZE=;
        b=rtVBDRsL1H9poITBn3yPg97mS4qX4SDux2ig1yuxBlg2TZAmD6hrQq+uHqZ2hSR4zk
         6X1TfI17e674+kTcqnbhdWq/WMuxBH+4wK4DremwOybeFdmSs0/GUveRbPZlpxzIONSp
         NIaR/uWQerav2ghT8hqIZ9iuROLvl5u3sNmbAALkeTGISyz34s31Pb0cQWmjn5n9iCHp
         Lt7HoXUFGZia57kwPohhjxEyT6zGIIwQ/YwkYWN1Gw6B5YhDJuDf+IOQFbiyEeNb37py
         WjpoxEZ32SwIl8oBRJkNCLjIskTpwloH/O6wzCuq+st4tCmzuEqwG7rJNdJd0hPRsi6Y
         bKKA==
X-Gm-Message-State: AOAM530UZavKHK/42AMUktO2g7DlzjCNsNhPuHfi6NAU4k3n5AJ9dJYN
        4iTIP6wEGnKemNykxguJPkVr/cAJfUM=
X-Google-Smtp-Source: ABdhPJxLFKZwv/R5N/ATiwsOUOi/gACxEJD2duZC9UviY+DARK5KzVYC6Lqq9GNBa3hPs3oQtFrwbQ==
X-Received: by 2002:aed:3b5d:: with SMTP id q29mr846779qte.91.1606161940629;
        Mon, 23 Nov 2020 12:05:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m62sm4102167qkb.91.2020.11.23.12.05.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:39 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5cFC010325
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:38 GMT
Subject: [PATCH v3 19/85] NFSD: Replace READ* macros in nfsd4_decode_fattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:38 -0500
Message-ID: <160616193897.51996.12609995444933822837.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Let's be more careful to avoid overrunning the memory that backs
the bitmap array. This requires updating the synopsis of
nfsd4_decode_fattr().

Bruce points out that a server needs to be careful to return nfs_ok
when a client presents bitmap bits the server doesn't support. This
includes bits in bitmap words the server might not yet support.

The current READ* based implementation is good about that, but that
requirement hasn't been documented.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   82 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 54481804a096..9b295c810ef3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -260,6 +260,46 @@ nfsd4_decode_bitmap(struct nfsd4_compoundargs *argp, u32 *bmval)
 	DECODE_TAIL;
 }
 
+/**
+ * nfsd4_decode_bitmap4 - Decode an NFSv4 bitmap4
+ * @argp: NFSv4 compound argument structure
+ * @bmval: pointer to an array of u32's to decode into
+ * @bmlen: size of the @bmval array
+ *
+ * The server needs to return nfs_ok rather than nfserr_bad_xdr when
+ * encountering bitmaps containing bits it does not recognize. This
+ * includes bits in bitmap words past WORDn, where WORDn is the last
+ * bitmap WORD the implementation currently supports. Thus we are
+ * careful here to simply ignore bits in bitmap words that this
+ * implementation has yet to support explicitly.
+ *
+ * Return values:
+ *   %nfs_ok: @bmval populated successfully
+ *   %nfserr_bad_xdr: the encoded bitmap was invalid
+ */
+static __be32
+nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
+{
+	u32 i, count;
+	__be32 *p;
+
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+	/* request sanity */
+	if (count > 1000)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, count << 2);
+	if (!p)
+		return nfserr_bad_xdr;
+	i = 0;
+	while (i < count)
+		bmval[i++] = be32_to_cpup(p++);
+	while (i < bmlen)
+		bmval[i++] = 0;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_nfsace4(struct nfsd4_compoundargs *argp, struct nfs4_ace *ace)
 {
@@ -352,17 +392,18 @@ nfsd4_decode_security_label(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
-		   struct iattr *iattr, struct nfs4_acl **acl,
-		   struct xdr_netobj *label, int *umask)
+nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
+		    struct iattr *iattr, struct nfs4_acl **acl,
+		    struct xdr_netobj *label, int *umask)
 {
 	unsigned int starting_pos;
 	u32 attrlist4_count;
+	__be32 *p, status;
 
-	DECODE_HEAD;
 	iattr->ia_valid = 0;
-	if ((status = nfsd4_decode_bitmap(argp, bmval)))
-		return status;
+	status = nfsd4_decode_bitmap4(argp, bmval, bmlen);
+	if (status)
+		return nfserr_bad_xdr;
 
 	if (bmval[0] & ~NFSD_WRITEABLE_ATTRS_WORD0
 	    || bmval[1] & ~NFSD_WRITEABLE_ATTRS_WORD1
@@ -490,7 +531,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
 		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32
@@ -690,9 +731,10 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 	if ((status = check_filename(create->cr_name, create->cr_namelen)))
 		return status;
 
-	status = nfsd4_decode_fattr(argp, create->cr_bmval, &create->cr_iattr,
-				    &create->cr_acl, &create->cr_label,
-				    &create->cr_umask);
+	status = nfsd4_decode_fattr4(argp, create->cr_bmval,
+				    ARRAY_SIZE(create->cr_bmval),
+				    &create->cr_iattr, &create->cr_acl,
+				    &create->cr_label, &create->cr_umask);
 	if (status)
 		goto out;
 
@@ -941,9 +983,10 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 		switch (open->op_createmode) {
 		case NFS4_CREATE_UNCHECKED:
 		case NFS4_CREATE_GUARDED:
-			status = nfsd4_decode_fattr(argp, open->op_bmval,
-				&open->op_iattr, &open->op_acl, &open->op_label,
-				&open->op_umask);
+			status = nfsd4_decode_fattr4(argp, open->op_bmval,
+						     ARRAY_SIZE(open->op_bmval),
+						     &open->op_iattr, &open->op_acl,
+						     &open->op_label, &open->op_umask);
 			if (status)
 				goto out;
 			break;
@@ -956,9 +999,10 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 				goto xdr_error;
 			READ_BUF(NFS4_VERIFIER_SIZE);
 			COPYMEM(open->op_verf.data, NFS4_VERIFIER_SIZE);
-			status = nfsd4_decode_fattr(argp, open->op_bmval,
-				&open->op_iattr, &open->op_acl, &open->op_label,
-				&open->op_umask);
+			status = nfsd4_decode_fattr4(argp, open->op_bmval,
+						     ARRAY_SIZE(open->op_bmval),
+						     &open->op_iattr, &open->op_acl,
+						     &open->op_label, &open->op_umask);
 			if (status)
 				goto out;
 			break;
@@ -1194,8 +1238,10 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 	status = nfsd4_decode_stateid(argp, &setattr->sa_stateid);
 	if (status)
 		return status;
-	return nfsd4_decode_fattr(argp, setattr->sa_bmval, &setattr->sa_iattr,
-				  &setattr->sa_acl, &setattr->sa_label, NULL);
+	return nfsd4_decode_fattr4(argp, setattr->sa_bmval,
+				   ARRAY_SIZE(setattr->sa_bmval),
+				   &setattr->sa_iattr, &setattr->sa_acl,
+				   &setattr->sa_label, NULL);
 }
 
 static __be32


