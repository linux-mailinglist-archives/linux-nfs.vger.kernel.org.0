Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C007B2C159A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgKWUEz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgKWUEz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:55 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F35C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:55 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i199so4773767qke.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z84HjOvQPeCK6o4R4Yv7RajFvqsaAPyLXqsH/7l+Ckk=;
        b=sFgarIsWPAVdNlEM/LYewJ0MDRmOUQKGtl5+itt64JtPQcb1BEoRtD2q4FGQsS17qI
         gatVkocKzU9oX0E6J3+oo0RMDzERVQbj2I46KJUAohesebjOXSgoN9frLr45kN+m4+Dy
         KCBbqIdsgw64EbfOvos0LA+yBhZEsrkoYBPhtzrmH6a/6eW1j9maY+QVnNsRz/8bai73
         DOc4ungxYLUB8ivEBKni+GRS+UuUo9NxqLxM5yHw9LbBun3H/WZZGClMb8jAFguaN8L2
         eratZgTIt4lVM86J0axJSgn9hrTvePSN273aZMCIDYRLp54uTm7/xpdNPAsZFgao71E4
         yHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Z84HjOvQPeCK6o4R4Yv7RajFvqsaAPyLXqsH/7l+Ckk=;
        b=kHNfdz9KL1Zve9YQGa69Urnyy7X/LJw0gUPoulf3Z8OWnGQDz+FUwdmK1BTfsjVoSk
         A90CgFJBfoGdy5Y5e0M9KshLpW0rXbka+Be7SKpVoAK6/ohrH/PYFHr0xu8fz5UGg9YV
         zAYm2c1Dkl6m1HxCJVA2KCT6SrXzD/0tmGsXsgwFVqF5WV9UUZyDp5WBPoTxkYRn/75J
         EYtSmIXMrb5u6f5YjZa1A3Q9M3U6bySyekgoHnSK+2m20X7XhN1u6wan3k/gKYCwo7bb
         G+XY6MeOEJTiewCKn5N8UCLLJYef6Yl01vZ6kaiBaXUYvUeyx3030/TJbczOnNWz6r24
         zrhw==
X-Gm-Message-State: AOAM531zdN6mnEnJ9LgenJP26f98kw61mwdnXtq0CP9KSjw6Hk1xS62j
        2KAL89mIT3vsnLf2DlcUWgT3B2xAnds=
X-Google-Smtp-Source: ABdhPJw8D10E7rOrNpzGB2e29nkVEsim0ZcHFtFkB7mLS/A8Bn3RIo2BIys++y5SzdJtwW6A/x4mwg==
X-Received: by 2002:a37:b505:: with SMTP id e5mr1219529qkf.309.1606161893803;
        Mon, 23 Nov 2020 12:04:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o127sm9484479qkf.135.2020.11.23.12.04.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:52 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK4pTp010298
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:51 GMT
Subject: [PATCH v3 10/85] NFSD: Change the way the expected length of a fattr4
 is checked
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:51 -0500
Message-ID: <160616189193.51996.3348726953277601601.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index de7408adb7c6..6dae8b0a5f0f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -250,7 +250,8 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		   struct iattr *iattr, struct nfs4_acl **acl,
 		   struct xdr_netobj *label, int *umask)
 {
-	int expected_len, len = 0;
+	unsigned int starting_pos;
+	u32 attrlist4_count;
 	u32 dummy32;
 	char *buf;
 
@@ -267,12 +268,12 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
@@ -280,7 +281,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		u32 nace;
 		struct nfs4_ace *ace;
 
-		READ_BUF(4); len += 4;
+		READ_BUF(4);
 		nace = be32_to_cpup(p++);
 
 		if (nace > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))
@@ -297,13 +298,12 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 
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
@@ -322,17 +322,14 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
@@ -340,10 +337,8 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
@@ -351,11 +346,9 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
@@ -370,11 +363,9 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
@@ -392,18 +383,14 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
@@ -414,15 +401,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
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
+	/* request sanity: did attrlist4 contain the expected number of words? */
+	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
+		return nfserr_bad_xdr;
 
 	DECODE_TAIL;
 }


