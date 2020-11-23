Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0082C15A1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgKWUFc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgKWUFc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:32 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13458C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:31 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id l7so8049375qtp.8
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=V82GSOh6+vlstoU+jnFTV5cu0MbSSQ2SDtB7TRi2Ocw=;
        b=av0ii5+UsbIaqoIxAjMGVbivHkTzzF8+gmy3IjwpJEGCPCwm1N3PJCEvg9aIN5sR5k
         2S0IIiIdZjDn2LnXTqSSHzP6Cjs9/LOogCpmpoqTgtQnRcILLtCUycckHQHTnspncqk3
         pEKRPE4px28owmNt9EjCTsTZupY/FvZHLBU/vJSwA6ZGNBKG/AuuN689s+wSfdRIGUS+
         D+y6NZJD9z+3+x9Ajo/RuGpB6MnkGv8webSIuwXoKvxI5AsG8eSASG3xD2KUyuyWszmA
         8PqIpgkllmcgHdx8kmyYgWzJ3xTvicTqxkeeTldZh5drNFWr9YQMlMOXjKWb6UrxcDG6
         05Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=V82GSOh6+vlstoU+jnFTV5cu0MbSSQ2SDtB7TRi2Ocw=;
        b=pv5nhPGPGloZzEVX3DrTWs5msdln33UXlLhoYe3f/xfol3oGbyixD4c7gdrfaqjEX5
         mK5YS9ilbGcG5Wp/hCqxIRP5gdKDf2pqAo9MuinB2ogce/eFr2Ztz5j0sH9fNNUxXdx3
         DkOXJwJMej1uIof274JymGoIMqYgkXPq1DYwnW4lN18DDaP1ekjphCzI4DvKvKRpq6Bl
         2QOBPRA+CqJFs04cpH/GPgCVGlkpMg3aXXm4GQa7mlkezU3dt6Yp8KiX9D0/fno7xxL4
         xbU9JOiT5qhKUB5DIrmVhYbUleTnHq6Xg/KA2ED5nQEEftUrxLpIDodH3xKeDC1ZGtS0
         lozg==
X-Gm-Message-State: AOAM530IkdGZCiKUpmjcDG2DxZs8izySe3UuCVozeIvyfM5QHnzvP08N
        LJm1aV9cRIA39OpVRPAcXvK9EhzlcCs=
X-Google-Smtp-Source: ABdhPJylnNC/hMVV71hCtlbWHbigp7X0RMSysBtBWp9PiLBYZMLQMz2yRwD+OzY3mFDZNpdurSJjzQ==
X-Received: by 2002:ac8:6651:: with SMTP id j17mr919544qtp.176.1606161930022;
        Mon, 23 Nov 2020 12:05:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b64sm10352407qkg.19.2020.11.23.12.05.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:29 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5SLY010319
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:28 GMT
Subject: [PATCH v3 17/85] NFSD: Replace READ* macros that decode the fattr4
 security label attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:28 -0500
Message-ID: <160616192862.51996.1062624442478508351.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2668c150042e..3844bbb7aaa3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -324,6 +324,33 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl)
 	return nfs_ok;
 }
 
+static noinline __be32
+nfsd4_decode_security_label(struct nfsd4_compoundargs *argp,
+			    struct xdr_netobj *label)
+{
+	u32 lfs, pi, length;
+	__be32 *p;
+
+	if (xdr_stream_decode_u32(argp->xdr, &lfs) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &pi) < 0)
+		return nfserr_bad_xdr;
+
+	if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+		return nfserr_bad_xdr;
+	if (length > NFS4_MAXLABELLEN)
+		return nfserr_badlabel;
+	p = xdr_inline_decode(argp->xdr, length);
+	if (!p)
+		return nfserr_bad_xdr;
+	label->len = length;
+	label->data = svcxdr_dupstr(argp, p, length);
+	if (!label->data)
+		return nfserr_jukebox;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		   struct iattr *iattr, struct nfs4_acl **acl,
@@ -332,7 +359,6 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	unsigned int starting_pos;
 	u32 attrlist4_count;
 	u32 dummy32;
-	char *buf;
 
 	DECODE_HEAD;
 	iattr->ia_valid = 0;
@@ -440,24 +466,12 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			return nfserr_bad_xdr;
 		}
 	}
-
 	label->len = 0;
 	if (IS_ENABLED(CONFIG_NFSD_V4_SECURITY_LABEL) &&
 	    bmval[2] & FATTR4_WORD2_SECURITY_LABEL) {
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++); /* lfs: we don't use it */
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++); /* pi: we don't use it either */
-		READ_BUF(4);
-		dummy32 = be32_to_cpup(p++);
-		READ_BUF(dummy32);
-		if (dummy32 > NFS4_MAXLABELLEN)
-			return nfserr_badlabel;
-		READMEM(buf, dummy32);
-		label->len = dummy32;
-		label->data = svcxdr_dupstr(argp, buf, dummy32);
-		if (!label->data)
-			return nfserr_jukebox;
+		status = nfsd4_decode_security_label(argp, label);
+		if (status)
+			return status;
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
 		if (!umask)


