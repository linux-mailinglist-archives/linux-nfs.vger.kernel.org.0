Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97462B1E03
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMPEI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMPEI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:08 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD00C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:02 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id v143so9047433qkb.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mga2qOkdVNPuU9dbeDx1AezGJDWlQxIZQZM6LJ2fy5Q=;
        b=WuIaXYa1AOc1bvIqwaS7T4uOnJh6QwJ/TL1dp2mM4cIgHK+t4h/ZrtL4ItmGHcvIGF
         RfPt3ayHY16QOSA6kdZRVBt4xn0pA/q8crtdQxc5qEt6fVkCYmTNJkKnID//4XPvaxkf
         VUHaQKhq/+3vHSRMJCAfkCV4EhdJEPLA9JYzMGRKdzLwCSHrw0jAV2OjG8xiMKkBC18x
         Rc6ucUKE0B2Z16p8HE4CXJTZkd4gFYnQgHcZFsPPProSkpnvBCqBdnwoleiV9PKRTpZ/
         mtu5h16B+Nb+2IN/2GSKIPfy69MYpD27dZxBxefzxFPP2UobSimdDvBgb85b4c8oyJZB
         kqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mga2qOkdVNPuU9dbeDx1AezGJDWlQxIZQZM6LJ2fy5Q=;
        b=S+l88k25Mj2ccungY8JOAC7o0si/Q+3UEj9NVZakueuHuF7DvNOElVzaQmkceHHmFH
         c6qoG6CmHWeetZzY8eYX95dqAb9l/cplPFCZ/2Hj6/6QRav06w7qoL6PjUI1KqZEaphV
         Lg68VsXBCrz0ujUYFoACUe6kq2Z4NYB/DEYyGzmUYQUj6itOkOq3fCrtRwMc6DTq4EpX
         cCuo5eEXZirXzaW30+YxhjVREJGy1aseTbS2XgwhqwvkCzTFouck1n9fsKfgpSm47Xmk
         q46xtZwhEDL7dKUSjngqxodbDruu6VjK0z/J+qK2B9+38ZU+uLgtwNoJwClQXL8Jw6XR
         RZLA==
X-Gm-Message-State: AOAM531jmB1y+9RBZ4v5wbx9iQJRw1yzXniXmeIhHw7bMcFo27vNObWj
        9iYZJBJgNDz52m56ZpuOl0itQ28jXTk=
X-Google-Smtp-Source: ABdhPJyl9h9qBknsxI7X4wyzsx3oLxGW+e/WF1DE9Kpu/MWm54H84l6TqK/UZuoEbiUvcmC87XZtxA==
X-Received: by 2002:a37:4c15:: with SMTP id z21mr2428863qka.349.1605279839881;
        Fri, 13 Nov 2020 07:03:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm2865438qki.2.2020.11.13.07.03.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3v5N032691
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:57 GMT
Subject: [PATCH v1 18/61] NFSD: Replace READ* macros in nfsd4_decode_fattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:57 -0500
Message-ID: <160527983767.6186.11558132351326954796.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  187 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 108 insertions(+), 79 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 69ff666a5695..9a6116cee94b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -307,17 +307,15 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval,
 }
 
 static __be32
-nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
-		   struct iattr *iattr, struct nfs4_acl **acl,
-		   struct xdr_netobj *label, int *umask)
+nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
+		    struct iattr *iattr, struct nfs4_acl **acl,
+		    struct xdr_netobj *label, int *umask)
 {
-	int expected_len, len = 0;
-	u32 dummy32;
-	char *buf;
+	u32 dummy32, expected_len, len;
+	__be32 *p, status;
 
-	DECODE_HEAD;
 	iattr->ia_valid = 0;
-	status = nfsd4_decode_bitmap4(argp, bmval, 3);
+	status = nfsd4_decode_bitmap4(argp, bmval, bmlen);
 	if (status)
 		goto out;
 
@@ -329,21 +327,25 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		return nfserr_attrnotsupp;
 	}
 
-	READ_BUF(4);
-	expected_len = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &expected_len) < 0)
+		goto xdr_error;
+	len = 0;
 
 	if (bmval[0] & FATTR4_WORD0_SIZE) {
-		READ_BUF(8);
-		len += 8;
-		p = xdr_decode_hyper(p, &iattr->ia_size);
+		p = xdr_inline_decode(argp->xdr, sizeof(__be64));
+		if (!p)
+			goto xdr_error;
+		len += sizeof(__be64);
+		xdr_decode_hyper(p, &iattr->ia_size);
 		iattr->ia_valid |= ATTR_SIZE;
 	}
 	if (bmval[0] & FATTR4_WORD0_ACL) {
 		u32 nace;
 		struct nfs4_ace *ace;
 
-		READ_BUF(4); len += 4;
-		nace = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &nace) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
 
 		if (nace > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))
 			/*
@@ -355,72 +357,83 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 
 		*acl = svcxdr_tmpalloc(argp, nfs4_acl_bytes(nace));
 		if (*acl == NULL)
-			return nfserr_jukebox;
+			goto nomem;
 
 		(*acl)->naces = nace;
 		for (ace = (*acl)->aces; ace < (*acl)->aces + nace; ace++) {
-			READ_BUF(16); len += 16;
+			p = xdr_inline_decode(argp->xdr, sizeof(__be32) * 4);
+			if (!p)
+				goto xdr_error;
+			len += sizeof(__be32) * 4;
 			ace->type = be32_to_cpup(p++);
 			ace->flag = be32_to_cpup(p++);
 			ace->access_mask = be32_to_cpup(p++);
-			dummy32 = be32_to_cpup(p++);
-			READ_BUF(dummy32);
-			len += XDR_QUADLEN(dummy32) << 2;
-			READMEM(buf, dummy32);
-			ace->whotype = nfs4_acl_get_whotype(buf, dummy32);
+			dummy32 = be32_to_cpup(p);
+			p = xdr_inline_decode(argp->xdr, dummy32);
+			if (!p)
+				goto xdr_error;
+			len += xdr_align_size(dummy32);
+			ace->whotype = nfs4_acl_get_whotype((char *)p, dummy32);
 			status = nfs_ok;
 			if (ace->whotype != NFS4_ACL_WHO_NAMED)
 				;
 			else if (ace->flag & NFS4_ACE_IDENTIFIER_GROUP)
 				status = nfsd_map_name_to_gid(argp->rqstp,
-						buf, dummy32, &ace->who_gid);
+						(char *)p, dummy32, &ace->who_gid);
 			else
 				status = nfsd_map_name_to_uid(argp->rqstp,
-						buf, dummy32, &ace->who_uid);
+						(char *)p, dummy32, &ace->who_uid);
 			if (status)
 				return status;
 		}
 	} else
 		*acl = NULL;
 	if (bmval[1] & FATTR4_WORD1_MODE) {
-		READ_BUF(4);
-		len += 4;
-		iattr->ia_mode = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
+		iattr->ia_mode = dummy32;
 		iattr->ia_mode &= (S_IFMT | S_IALLUGO);
 		iattr->ia_valid |= ATTR_MODE;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER) {
-		READ_BUF(4);
-		len += 4;
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		len += (XDR_QUADLEN(dummy32) << 2);
-		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_uid(argp->rqstp, buf, dummy32, &iattr->ia_uid)))
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
+		p = xdr_inline_decode(argp->xdr, dummy32);
+		if (!p)
+			goto xdr_error;
+		len += xdr_align_size(dummy32);
+		status = nfsd_map_name_to_uid(argp->rqstp, (char *)p, dummy32,
+					      &iattr->ia_uid);
+		if (status)
 			return status;
 		iattr->ia_valid |= ATTR_UID;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER_GROUP) {
-		READ_BUF(4);
-		len += 4;
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		len += (XDR_QUADLEN(dummy32) << 2);
-		READMEM(buf, dummy32);
-		if ((status = nfsd_map_name_to_gid(argp->rqstp, buf, dummy32, &iattr->ia_gid)))
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
+		p = xdr_inline_decode(argp->xdr, dummy32);
+		if (!p)
+			goto xdr_error;
+		len += xdr_align_size(dummy32);
+		status = nfsd_map_name_to_gid(argp->rqstp, (char *)p, dummy32,
+					      &iattr->ia_gid);
+		if (status)
 			return status;
 		iattr->ia_valid |= ATTR_GID;
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
-		READ_BUF(4);
-		len += 4;
-		dummy32 = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			len += 12;
 			status = nfsd4_decode_nfstime4(argp, &iattr->ia_atime);
 			if (status)
 				return status;
+			len += sizeof(__be64) + sizeof(__be32);
 			iattr->ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
 			break;
 		case NFS4_SET_TO_SERVER_TIME:
@@ -431,15 +444,15 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		}
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
-		READ_BUF(4);
-		len += 4;
-		dummy32 = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			len += 12;
 			status = nfsd4_decode_nfstime4(argp, &iattr->ia_mtime);
 			if (status)
 				return status;
+			len += sizeof(__be64) + sizeof(__be32);
 			iattr->ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
 			break;
 		case NFS4_SET_TO_SERVER_TIME:
@@ -453,40 +466,51 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	label->len = 0;
 	if (IS_ENABLED(CONFIG_NFSD_V4_SECURITY_LABEL) &&
 	    bmval[2] & FATTR4_WORD2_SECURITY_LABEL) {
-		READ_BUF(4);
-		len += 4;
-		dummy32 = be32_to_cpup(p++); /* lfs: we don't use it */
-		READ_BUF(4);
-		len += 4;
-		dummy32 = be32_to_cpup(p++); /* pi: we don't use it either */
-		READ_BUF(4);
-		len += 4;
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
+		/* lfs is ignored */
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
+		/* pi is ignored */
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
 		if (dummy32 > NFS4_MAXLABELLEN)
 			return nfserr_badlabel;
-		len += (XDR_QUADLEN(dummy32) << 2);
-		READMEM(buf, dummy32);
+		len += sizeof(__be32);
+		p = xdr_inline_decode(argp->xdr, dummy32);
+		if (!p)
+			goto xdr_error;
+		len += xdr_align_size(dummy32);
 		label->len = dummy32;
-		label->data = svcxdr_dupstr(argp, buf, dummy32);
+		label->data = svcxdr_dupstr(argp, p, dummy32);
 		if (!label->data)
-			return nfserr_jukebox;
+			goto nomem;
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
 		if (!umask)
 			goto xdr_error;
-		READ_BUF(8);
-		len += 8;
-		dummy32 = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
 		iattr->ia_mode = dummy32 & (S_IFMT | S_IALLUGO);
-		dummy32 = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &dummy32) < 0)
+			goto xdr_error;
+		len += sizeof(__be32);
 		*umask = dummy32 & S_IRWXUGO;
 		iattr->ia_valid |= ATTR_MODE;
 	}
 	if (len != expected_len)
 		goto xdr_error;
+	status = nfs_ok;
 
-	DECODE_TAIL;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
 }
 
 static __be32 nfsd4_decode_clientid4(struct nfsd4_compoundargs *argp,
@@ -706,9 +730,10 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 					 &create->cr_namelen);
 	if (status)
 		goto out;
-	status = nfsd4_decode_fattr(argp, create->cr_bmval, &create->cr_iattr,
-				    &create->cr_acl, &create->cr_label,
-				    &create->cr_umask);
+	status = nfsd4_decode_fattr4(argp, create->cr_bmval,
+				    ARRAY_SIZE(create->cr_bmval),
+				    &create->cr_iattr, &create->cr_acl,
+				    &create->cr_label, &create->cr_umask);
 	if (status)
 		goto out;
 
@@ -965,9 +990,10 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
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
@@ -980,9 +1006,10 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
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
@@ -1220,8 +1247,10 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
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


