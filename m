Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11ED2BB723
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgKTUem (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbgKTUem (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:42 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1813BC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:42 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 9so1114354qvk.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gRYU3FM2wrIg300WHn2tfdyIL3e6BWrxRnRdZlzzgnA=;
        b=aZAv1+ofA5htfp66swZ2Dxi8o2UhD8U1UgBk7XfZ+yylFuxUmffFDrYTYvx+uOslLe
         ip2SWHecgilQF4kUHebuNFyJrL+SngJPKfBsSq2qI90t+/WuRTRQMTnpK8h15+489gWe
         5VsStbznbx3vb1bmEkc9FvaRuj0Jd/CMHpVcMEKNOPpOz5IcyCosva/hqjiWiXspTaaf
         Ge+lHkZuGuD8sFyJq5GKFPO9pkLuCzsHPhG6TwTXCtzvNZTV41jiLrfT//PsHpTr9LRL
         73fBrfw3JZHXtxlCqsGNOuc0W5biHIaRj/ZaGvSnKLhBV01F3/6eCs6ObkRcKCmHSaJV
         cJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=gRYU3FM2wrIg300WHn2tfdyIL3e6BWrxRnRdZlzzgnA=;
        b=rDO6tYnGbP67Tr8xAs8j/UgTQIgU7WhcguFFA75gpnkrq5KIhdX+G5IgKBIHj5v2tC
         Ud9E1AaMlZ8kd//Gum+KZEG2ev9IYFP9RYrXSrjywbuVDZnDYs/W6Rf9i4SE7kaTHXsz
         YwL2Jp16N3t5HRp1PInSvn40IXVeccuw8+Q2zYN+1C8IaEne16JZc2a7oBr5iLgq+ZdA
         fHIfI3PIuWX+lZwBltS3W30NmAunfX6w5URq9INoCYtM8BedlfU4t+4wssV5Iezuz6yD
         5RAgpv+fTfSb2M3nVwzrKWdzJ+ZgRJcHVPVsIe15j4zXZoyM79YBH8kUgs3QBTru+uyO
         kZuw==
X-Gm-Message-State: AOAM53032mZkyPnoEbSUdJviknZ9l1VHgvJzpO/EpvZ+ZGsbqpCMoycw
        bThgAb6U+1VgKQgJAyHParWjeO8s/48=
X-Google-Smtp-Source: ABdhPJxfaX27c987Y2YSamlDQrptkwzWunQvH5cBXj509gJYmYT9ctxQ/q627CrJqflA/DT0Npy9hg==
X-Received: by 2002:ad4:4051:: with SMTP id r17mr13822942qvp.39.1605904480953;
        Fri, 20 Nov 2020 12:34:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 9sm2516281qty.30.2020.11.20.12.34.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:40 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYdvm029232
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:39 GMT
Subject: [PATCH v2 010/118] NFSD: Change the way the expected length of a
 fattr4 is checked
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:39 -0500
Message-ID: <160590447910.1340.2131975329375069529.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Because the fattr4 is now managed in an xdr_stream, all that is
needed is to store the initial position of the stream before
decoding the attribute list. Then the actual length of the list
is computed using the final stream position, after decoding is
complete.

No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d4b98bd8a859..a076bb42e98a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -248,7 +248,8 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		   struct iattr *iattr, struct nfs4_acl **acl,
 		   struct xdr_netobj *label, int *umask)
 {
-	int expected_len, len = 0;
+	unsigned int starting_pos;
+	u32 attrlist4_count;
 	u32 dummy32;
 	char *buf;
 
@@ -265,12 +266,12 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		return nfserr_attrnotsupp;
 	}
 
-	READ_BUF(4);
-	expected_len = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &attrlist4_count) < 0)
+		return nfserr_bad_xdr;
+	starting_pos = xdr_stream_pos(argp->xdr);
 
 	if (bmval[0] & FATTR4_WORD0_SIZE) {
 		READ_BUF(8);
-		len += 8;
 		p = xdr_decode_hyper(p, &iattr->ia_size);
 		iattr->ia_valid |= ATTR_SIZE;
 	}
@@ -278,7 +279,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		u32 nace;
 		struct nfs4_ace *ace;
 
-		READ_BUF(4); len += 4;
+		READ_BUF(4);
 		nace = be32_to_cpup(p++);
 
 		if (nace > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))
@@ -295,13 +296,12 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 
 		(*acl)->naces = nace;
 		for (ace = (*acl)->aces; ace < (*acl)->aces + nace; ace++) {
-			READ_BUF(16); len += 16;
+			READ_BUF(16);
 			ace->type = be32_to_cpup(p++);
 			ace->flag = be32_to_cpup(p++);
 			ace->access_mask = be32_to_cpup(p++);
 			dummy32 = be32_to_cpup(p++);
 			READ_BUF(dummy32);
-			len += XDR_QUADLEN(dummy32) << 2;
 			READMEM(buf, dummy32);
 			ace->whotype = nfs4_acl_get_whotype(buf, dummy32);
 			status = nfs_ok;
@@ -320,17 +320,14 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		*acl = NULL;
 	if (bmval[1] & FATTR4_WORD1_MODE) {
 		READ_BUF(4);
-		len += 4;
 		iattr->ia_mode = be32_to_cpup(p++);
 		iattr->ia_mode &= (S_IFMT | S_IALLUGO);
 		iattr->ia_valid |= ATTR_MODE;
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER) {
 		READ_BUF(4);
-		len += 4;
 		dummy32 = be32_to_cpup(p++);
 		READ_BUF(dummy32);
-		len += (XDR_QUADLEN(dummy32) << 2);
 		READMEM(buf, dummy32);
 		if ((status = nfsd_map_name_to_uid(argp->rqstp, buf, dummy32, &iattr->ia_uid)))
 			return status;
@@ -338,10 +335,8 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	}
 	if (bmval[1] & FATTR4_WORD1_OWNER_GROUP) {
 		READ_BUF(4);
-		len += 4;
 		dummy32 = be32_to_cpup(p++);
 		READ_BUF(dummy32);
-		len += (XDR_QUADLEN(dummy32) << 2);
 		READMEM(buf, dummy32);
 		if ((status = nfsd_map_name_to_gid(argp->rqstp, buf, dummy32, &iattr->ia_gid)))
 			return status;
@@ -349,11 +344,9 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
 		READ_BUF(4);
-		len += 4;
 		dummy32 = be32_to_cpup(p++);
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			len += 12;
 			status = nfsd4_decode_time(argp, &iattr->ia_atime);
 			if (status)
 				return status;
@@ -368,11 +361,9 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	}
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
 		READ_BUF(4);
-		len += 4;
 		dummy32 = be32_to_cpup(p++);
 		switch (dummy32) {
 		case NFS4_SET_TO_CLIENT_TIME:
-			len += 12;
 			status = nfsd4_decode_time(argp, &iattr->ia_mtime);
 			if (status)
 				return status;
@@ -390,18 +381,14 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	if (IS_ENABLED(CONFIG_NFSD_V4_SECURITY_LABEL) &&
 	    bmval[2] & FATTR4_WORD2_SECURITY_LABEL) {
 		READ_BUF(4);
-		len += 4;
 		dummy32 = be32_to_cpup(p++); /* lfs: we don't use it */
 		READ_BUF(4);
-		len += 4;
 		dummy32 = be32_to_cpup(p++); /* pi: we don't use it either */
 		READ_BUF(4);
-		len += 4;
 		dummy32 = be32_to_cpup(p++);
 		READ_BUF(dummy32);
 		if (dummy32 > NFS4_MAXLABELLEN)
 			return nfserr_badlabel;
-		len += (XDR_QUADLEN(dummy32) << 2);
 		READMEM(buf, dummy32);
 		label->len = dummy32;
 		label->data = svcxdr_dupstr(argp, buf, dummy32);
@@ -412,15 +399,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		if (!umask)
 			goto xdr_error;
 		READ_BUF(8);
-		len += 8;
 		dummy32 = be32_to_cpup(p++);
 		iattr->ia_mode = dummy32 & (S_IFMT | S_IALLUGO);
 		dummy32 = be32_to_cpup(p++);
 		*umask = dummy32 & S_IRWXUGO;
 		iattr->ia_valid |= ATTR_MODE;
 	}
-	if (len != expected_len)
-		goto xdr_error;
+
+	/* request sanity: did we get the right number of words? */
+	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
+		return nfserr_bad_xdr;
 
 	DECODE_TAIL;
 }


