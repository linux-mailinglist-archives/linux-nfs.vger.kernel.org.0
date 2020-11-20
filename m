Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8912BB72F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgKTUfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgKTUfa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:35:30 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEEC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:30 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so8137773qtp.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wXGqYk1Wmp5D9SNUetrzCSyiQfx+pQFcxJFauaq/ods=;
        b=MvWBNo+1+dP4pd+c03XQoSdI6VtEN5RxWab5t9X3uBSOgPJMxdUI3EfJohtbSPy/JP
         gfDlTBrpps6ourNKVuBeN+CkD+PN6rT3xlPeZEBJh4kw7DboNVV4KqrLjcJ8LuW5cNWG
         vsn19s4QBZI+Ll/Hh2fnEZB8Zd2NIh7GgxSQQDaQzFAANpMcaCGeUP4Pud3eRvXo8fuT
         0NN6ugPDoS0LFw8S4iMLXejHwgXbtSNg6QeAnVz4pRg84yhwMEeDqyzii6wfSveLC9Am
         iiKCShYoF43gZnxMlk5/ccMXACxuSFy8guLW5Jyn4Qsq1IwgsbtrdUjBDT2lhYCdiWCx
         xoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=wXGqYk1Wmp5D9SNUetrzCSyiQfx+pQFcxJFauaq/ods=;
        b=Zbq3VGMaEsni5I3tdhC/DMrlvyJWjXi0KglL92h109vLMlJoqrOhOWUElNNz45bgoz
         1O2KE1Q3kuCFcb4xc9x5hAFzQLdsxRsmVb/x6vyMV5AqjT7UDJhStbGI6KFJC+ASCY4V
         dv9SkYyKjuW2kklfa9fJ8uAsn+bkgIMkd36jYA0cujO+EhtoEbpxRZgPEmySCFbljklC
         06GD3oswWdcinUm9chbHbcTvP33xFGpJJgs63uWeFJzbmXPfMLJ6vXoEy+Wf4Owev5ky
         Bd/ZPQaIJrPnYOUiPMf91SBZYS4P7BS82Yb9OHT6Fx5l16yFWDBNSmaVcb/FSb2gqB5d
         PBfA==
X-Gm-Message-State: AOAM530WbnlAUg9S9q8J/bwTbZTspvA0kcZtXR36Wqek81+CuhfdOzjV
        c1gWThGMiKe24rn01EZQ2kDgVNkZEis=
X-Google-Smtp-Source: ABdhPJxKSaDA2QuqFaOLo9PCCkLo8xOh2nO1kqvvVCjxEC9rwpTstXC6xrEAc2uNijSWva/MN4oE6w==
X-Received: by 2002:ac8:46cf:: with SMTP id h15mr16036709qto.99.1605904529052;
        Fri, 20 Nov 2020 12:35:29 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x4sm3001351qtm.48.2020.11.20.12.35.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:35:28 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKZRko029259
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:35:27 GMT
Subject: [PATCH v2 019/118] NFSD: Replace READ* macros in nfsd4_decode_fattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:35:27 -0500
Message-ID: <160590452734.1340.16262869614648652550.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 046fe62bfa29..c7f14f0db432 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -350,17 +350,17 @@ nfsd4_decode_seclabel(struct nfsd4_compoundargs *argp,
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
+	if (xdr_stream_decode_uint32_array(argp->xdr, bmval, bmlen) < 0)
+		return nfserr_bad_xdr;
 
 	if (bmval[0] & ~NFSD_WRITEABLE_ATTRS_WORD0
 	    || bmval[1] & ~NFSD_WRITEABLE_ATTRS_WORD1
@@ -488,7 +488,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
 		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32
@@ -676,9 +676,10 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
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
 
@@ -927,9 +928,10 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
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
@@ -942,9 +944,10 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
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
@@ -1180,8 +1183,10 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 	status = nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
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


