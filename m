Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16482E9527
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 13:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhADMn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 07:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbhADMnU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 07:43:20 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6F2C061574
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 04:42:40 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h4so23215776qkk.4
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IYyJNqQPu8bZ7zSMy0OU0FQ75YRPurhSwgyBRdXme5k=;
        b=sj0N9phj5w+31Jz4NNS/EIHRkfAywa+ppn0sQvUp0k+OGGoT85lTdM+qkxLyAyy59x
         G3Y71SK4IcYa/aHuGOKXAiVjBYcmOUb3fafOBh4KgTfOU6VxThtiVFnLpXe9obEk6wfY
         Z+ztXDtKdtPbvhD5dikrCnqfr3eYUCimS+I3Ds4XHoItUA/6QYNaT368s/ukcW9XaRVb
         0+AKw8STU/BEBrt0o2nfse0PyHocfBFJXMD556dQp7UDI8XYbMX9jmmfQnyrhMbP+Bnq
         pbY6nwJhOcYaZY9AiQPT38lYPDlLSgcpcWmajyHPk0go3+lipmvR35wmp2OYUWjNJYVM
         vBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IYyJNqQPu8bZ7zSMy0OU0FQ75YRPurhSwgyBRdXme5k=;
        b=MTz1a1LVnt84TvF5mPZq1ZfYxRMZr023Gwcqh+HMyROJCI2n9blyWzH2yyuPgQuFfV
         u5+eTry4OGDjiyCp3BiJs8aEyesCh5SV6mXXtDrY9GlBrQ+3fVJ7JHgb8ZtnqNBycjPW
         oaaGmU0z/+Ynq3CiqCsEssSoFWLoH6ErsIa1ZxNEd8hGH2KUmk1WwDGgOZ+IOS0WeD7C
         KS5jgeluJ2tWuk84pOOKui9myYuqKAPg9pnURz53WaMYlRWgtG1NsQu9rL1f6Ny5GxvD
         nt8Xwpbx0MqRfSh03uH4o1OyUQUUERLuFx0DxZAt1yxr3AK34WQ0KChEp52Qc3WIdM9n
         AiYA==
X-Gm-Message-State: AOAM531d7TnOL5Wc25q5JUnb9JWA2CeQLph59yr6HM6reifBxeMRWnRy
        Tga15OQab6mNm+is5YM5Pe90AMNXwEI=
X-Google-Smtp-Source: ABdhPJyFKiFle+1Ss/gXoZYoqfrpB2Ug35clpFNzXx2pTXQOkH1cGADoA0ZCImcbdt5ck0d+1zUVRA==
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr71580451qkf.88.1609764159017;
        Mon, 04 Jan 2021 04:42:39 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f59sm36997208qtd.84.2021.01.04.04.42.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 04:42:38 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 104CgbFB017706
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jan 2021 12:42:37 GMT
Subject: [PATCH] NFSD: Restore NFSv4 decoding's SAVEMEM functionality
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Jan 2021 07:42:37 -0500
Message-ID: <160976412038.1233.502071259496733128.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While converting the NFSv4 decoder to use xdr_stream-based XDR
processing, I removed the old SAVEMEM() macro. This macro wrapped
a bit of logic that avoided a memory allocation by recognizing when
the decoded item resides in a linear section of the Receive buffer.
In that case, it returned a pointer into that buffer instead of
allocating a bounce buffer.

The bounce buffer is necessary only when xdr_inline_decode() has
placed the decoded item in the xdr_stream's scratch buffer, which
disappears the next time xdr_inline_decode() is called with that
xdr_stream. That happens only if the data item crosses a page
boundary in the receive buffer, an exceedingly rare occurrence.

Allocating a bounce buffer every time results in a minor performance
regression that was introduced by the recent NFSv4 decoder overhaul.
Let's restore the previous behavior. On average, it saves about 1.5
kmalloc() calls per COMPOUND.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

Hi-

I intend to include this with the first NFSD v5.11-rc pull request.


diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 20178f60f612..eaaa1605b5b5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -147,6 +147,25 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
 	return p;
 }
 
+static void *
+svcxdr_savemem(struct nfsd4_compoundargs *argp, __be32 *p, u32 len)
+{
+	__be32 *tmp;
+
+	/*
+	 * The location of the decoded data item is stable,
+	 * so @p is OK to use. This is the common case.
+	 */
+	if (p != argp->xdr->scratch.iov_base)
+		return p;
+
+	tmp = svcxdr_tmpalloc(argp, len);
+	if (!tmp)
+		return NULL;
+	memcpy(tmp, p, len);
+	return tmp;
+}
+
 /*
  * NFSv4 basic data type decoders
  */
@@ -183,11 +202,10 @@ nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
 	p = xdr_inline_decode(argp->xdr, len);
 	if (!p)
 		return nfserr_bad_xdr;
-	o->data = svcxdr_tmpalloc(argp, len);
+	o->data = svcxdr_savemem(argp, p, len);
 	if (!o->data)
 		return nfserr_jukebox;
 	o->len = len;
-	memcpy(o->data, p, len);
 
 	return nfs_ok;
 }
@@ -205,10 +223,9 @@ nfsd4_decode_component4(struct nfsd4_compoundargs *argp, char **namp, u32 *lenp)
 	status = check_filename((char *)p, *lenp);
 	if (status)
 		return status;
-	*namp = svcxdr_tmpalloc(argp, *lenp);
+	*namp = svcxdr_savemem(argp, p, *lenp);
 	if (!*namp)
 		return nfserr_jukebox;
-	memcpy(*namp, p, *lenp);
 
 	return nfs_ok;
 }
@@ -1200,10 +1217,9 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 	p = xdr_inline_decode(argp->xdr, putfh->pf_fhlen);
 	if (!p)
 		return nfserr_bad_xdr;
-	putfh->pf_fhval = svcxdr_tmpalloc(argp, putfh->pf_fhlen);
+	putfh->pf_fhval = svcxdr_savemem(argp, p, putfh->pf_fhlen);
 	if (!putfh->pf_fhval)
 		return nfserr_jukebox;
-	memcpy(putfh->pf_fhval, p, putfh->pf_fhlen);
 
 	return nfs_ok;
 }
@@ -1318,24 +1334,20 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 	p = xdr_inline_decode(argp->xdr, setclientid->se_callback_netid_len);
 	if (!p)
 		return nfserr_bad_xdr;
-	setclientid->se_callback_netid_val = svcxdr_tmpalloc(argp,
+	setclientid->se_callback_netid_val = svcxdr_savemem(argp, p,
 						setclientid->se_callback_netid_len);
 	if (!setclientid->se_callback_netid_val)
 		return nfserr_jukebox;
-	memcpy(setclientid->se_callback_netid_val, p,
-	       setclientid->se_callback_netid_len);
 
 	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_addr_len) < 0)
 		return nfserr_bad_xdr;
 	p = xdr_inline_decode(argp->xdr, setclientid->se_callback_addr_len);
 	if (!p)
 		return nfserr_bad_xdr;
-	setclientid->se_callback_addr_val = svcxdr_tmpalloc(argp,
+	setclientid->se_callback_addr_val = svcxdr_savemem(argp, p,
 						setclientid->se_callback_addr_len);
 	if (!setclientid->se_callback_addr_val)
 		return nfserr_jukebox;
-	memcpy(setclientid->se_callback_addr_val, p,
-	       setclientid->se_callback_addr_len);
 	if (xdr_stream_decode_u32(argp->xdr, &setclientid->se_callback_ident) < 0)
 		return nfserr_bad_xdr;
 
@@ -1375,10 +1387,9 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 	p = xdr_inline_decode(argp->xdr, verify->ve_attrlen);
 	if (!p)
 		return nfserr_bad_xdr;
-	verify->ve_attrval = svcxdr_tmpalloc(argp, verify->ve_attrlen);
+	verify->ve_attrval = svcxdr_savemem(argp, p, verify->ve_attrlen);
 	if (!verify->ve_attrval)
 		return nfserr_jukebox;
-	memcpy(verify->ve_attrval, p, verify->ve_attrlen);
 
 	return nfs_ok;
 }
@@ -2333,10 +2344,9 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 		p = xdr_inline_decode(argp->xdr, argp->taglen);
 		if (!p)
 			return 0;
-		argp->tag = svcxdr_tmpalloc(argp, argp->taglen);
+		argp->tag = svcxdr_savemem(argp, p, argp->taglen);
 		if (!argp->tag)
 			return 0;
-		memcpy(argp->tag, p, argp->taglen);
 		max_reply += xdr_align_size(argp->taglen);
 	}
 


