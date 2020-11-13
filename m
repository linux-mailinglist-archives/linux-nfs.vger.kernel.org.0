Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F802B1E25
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgKMPGC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPGB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2AC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:01 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d28so8996016qka.11
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sJ35GwTAQwEcbcZUdgGWqf+cH8j/KL4wcQmWrxVGlBk=;
        b=Nbb5GUv5x+5Yw7DieWtw1z5Q6ne+WGSJwWhXPe/XS8rBRV2y/fm9I2EpYDOAyonTw1
         45d7QL9oohqS033n4P81znk3vkTaPOku3WzRp0G/J7uMmMYJrBYdXCjDWUQUg5V8+iJC
         1ifj4ohFP4hkZPMFnO1YKAXbri88v/oQJS33OWxNJVroMX3qxXvAHEBMtVMkRcxI4XkH
         VqltZckZ08uUThJk1Iw4ZNhdeArbeQuXJWGfFuZI/TTfy4PKoK4SRbx3CPiJr/MEVYna
         6wUAwKRDye4e8pj/LhcxOawjgbwA1AqPmwOTQ95S65EkkHijQi6vGtzKhRku1+rw30tQ
         o3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sJ35GwTAQwEcbcZUdgGWqf+cH8j/KL4wcQmWrxVGlBk=;
        b=Smgw19pL1ne442DehFjzyEa1lChS4DNck7EbZoFBCKcgf/rU+01xWBuzHxgwdkp/rF
         TnU0zGZn080WdVO22xx4M9hkrVfzyPAe9/tqYvEbbS+dFo7LtdA/sk68/QY3K6pC+zZT
         GNli9tFaKlp8FCB4SCQgP8rVsjkSZwYNFjhHxvDkmQXhiXQSBa+4/uiHbwh8o9rK3IIc
         dkV5Sr084UwaqIhsUXKOEksQCUn0vHQIMB1nXmgobrp3KKzCiz19oP9lgvwG4EaxEKQK
         TkN8cE7XZLRwekPjf16hBGNqfPrxo9bd/v5yK6c3g5Ca8IbzqDtDS3k4+5pBGQgk7a9f
         wkLQ==
X-Gm-Message-State: AOAM531Wirl3Nh5v6RunVohoXG4FueQTiAZtcFnlIqPqDZoD4nkI+jeC
        ygXqbnSa7dFTe6E887D3l6bjVeiSkeM=
X-Google-Smtp-Source: ABdhPJxAffjyaSzRfN55JZ8iLnBsyez/HhkPaiB7P3hFOOYTO11OpC9o44t8XFI3oykNGgihzQr6vw==
X-Received: by 2002:a37:8d6:: with SMTP id 205mr2311980qki.279.1605279960298;
        Fri, 13 Nov 2020 07:06:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w1sm5431919qta.34.2020.11.13.07.05.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:59 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5wN0032760
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:58 GMT
Subject: [PATCH v1 41/61] NFSD: Replace READ* macros in
 nfsd4_decode_create_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:58 -0500
Message-ID: <160527995867.6186.18155965437034920174.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6897078bde82..dfd2008db299 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1617,15 +1617,20 @@ static __be32
 nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_create_session *sess)
 {
-	DECODE_HEAD;
+	__be32 *p, status;
 
-	READ_BUF(16);
-	COPYMEM(&sess->clientid, 8);
-	sess->seqid = be32_to_cpup(p++);
-	sess->flags = be32_to_cpup(p++);
+	status = nfsd4_decode_clientid4(argp, &sess->clientid);
+	if (status)
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->seqid) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->flags) < 0)
+		goto xdr_error;
 
 	/* Fore channel attrs */
-	READ_BUF(28);
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32) * 7);
+	if (!p)
+		goto xdr_error;
 	p++; /* headerpadsz is always 0 */
 	sess->fore_channel.maxreq_sz = be32_to_cpup(p++);
 	sess->fore_channel.maxresp_sz = be32_to_cpup(p++);
@@ -1634,15 +1639,17 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 	sess->fore_channel.maxreqs = be32_to_cpup(p++);
 	sess->fore_channel.nr_rdma_attrs = be32_to_cpup(p++);
 	if (sess->fore_channel.nr_rdma_attrs == 1) {
-		READ_BUF(4);
-		sess->fore_channel.rdma_attrs = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &sess->fore_channel.rdma_attrs) < 0)
+			goto xdr_error;
 	} else if (sess->fore_channel.nr_rdma_attrs > 1) {
 		dprintk("Too many fore channel attr bitmaps!\n");
 		goto xdr_error;
 	}
 
 	/* Back channel attrs */
-	READ_BUF(28);
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32) * 7);
+	if (!p)
+		goto xdr_error;
 	p++; /* headerpadsz is always 0 */
 	sess->back_channel.maxreq_sz = be32_to_cpup(p++);
 	sess->back_channel.maxresp_sz = be32_to_cpup(p++);
@@ -1651,17 +1658,24 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 	sess->back_channel.maxreqs = be32_to_cpup(p++);
 	sess->back_channel.nr_rdma_attrs = be32_to_cpup(p++);
 	if (sess->back_channel.nr_rdma_attrs == 1) {
-		READ_BUF(4);
-		sess->back_channel.rdma_attrs = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &sess->back_channel.rdma_attrs) < 0)
+			goto xdr_error;
 	} else if (sess->back_channel.nr_rdma_attrs > 1) {
 		dprintk("Too many back channel attr bitmaps!\n");
 		goto xdr_error;
 	}
 
-	READ_BUF(4);
-	sess->callback_prog = be32_to_cpup(p++);
-	nfsd4_decode_cb_sec(argp, &sess->cb_sec);
-	DECODE_TAIL;
+	if (xdr_stream_decode_u32(argp->xdr, &sess->callback_prog) < 0)
+		goto xdr_error;
+	status = nfsd4_decode_cb_sec(argp, &sess->cb_sec);
+	if (status)
+		goto out;
+
+	status = nfs_ok;
+out:
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


