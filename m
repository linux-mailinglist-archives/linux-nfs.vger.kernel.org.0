Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA922C15DC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgKWUJE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbgKWUJB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1FBC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:01 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so18286836qke.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8Hq2wwl8KrlV94eaiQ+/wCr3qLRV8KmQzSAeoZGdKCg=;
        b=rbN7VgusDY6AoUr6SNXKp7NMiSDBWJpihMuUrUUqD8rn/l3spS8TTI4s3e0fSvnhn7
         xvjqPTsZ0m2LLLogBPR4n51nP8LYPYDakDwFXcDsH9PtB43WomwRa3FPfy9By0lsmWqI
         iAaNUnqbjv/iL+y4yvTl9m7D/wuoy/lHokKWULAOQfqtKkO2VmqpQxJL14WMQcwHcJ+W
         Vg4EuXuck03Eqj+6c9yxq7Hv8OEaQQgCWZvgUMqXicUr7oVEUtzPnmxJMHSfj65J02nI
         axQpcqjtMUNPBcpx8HYJTf9YSkm+ugXqY65nr/Faxj5usTA73rYA2nKCcooGgzItv/eg
         kmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=8Hq2wwl8KrlV94eaiQ+/wCr3qLRV8KmQzSAeoZGdKCg=;
        b=kp19CwpNurlLzMnCWAmceHIeG9WbotOft+q1zaKM50IKocf5jce69D6yzr2GCrwpAO
         lFCQho8sPFlDFbpMCxfCR5i/rdaCPpvKw5MfnT60FX3huEc9Epqr7+/PljAJon030NTg
         SGuU4fz48sQiNkBc+vyi76Vn9Xb294hVwBK0n0h+J9deRtyxoEIN/OPey7I6gX8xSftT
         REEOwm/mlKThY6HTtOrcPvkEtYkc2a2/2FzcGxC8q+0mzt3gGRfrD2FRHlCWrItRxKgC
         zMzNZks6hT/Sg+j1MXU7lISRA1XdI3BJ/qEcBAQ0grfiK/kUHcpCdOnR8+IVSkM/Uzli
         6JrQ==
X-Gm-Message-State: AOAM532mMYZ1JI85it8jxZHy0pyNHsm5idHXJhLST5luVW7QcctI9xU/
        MaP3/Z877Hx4Gb8od4ttfvzWRxhhj7s=
X-Google-Smtp-Source: ABdhPJyFeM8R8CUvOgn4Q+cwBjJyHzH69ztw6Tm5g8T3r/BMsbrwkXtgaUE64lkerycTknVn5bI0Xg==
X-Received: by 2002:a37:358:: with SMTP id 85mr1176297qkd.303.1606162140717;
        Mon, 23 Nov 2020 12:09:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e4sm7956328qtc.54.2020.11.23.12.08.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:00 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8x1Y010447
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:59 GMT
Subject: [PATCH v3 57/85] NFSD: Add a separate decoder for ssv_sp_parms
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:59 -0500
Message-ID: <160616213922.51996.16126304189462578034.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   70 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 165591c435bc..86147f53f5e7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1488,12 +1488,54 @@ nfsd4_decode_state_protect_ops(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+/*
+ * This implementation currently does not support SP4_SSV.
+ * This decoder simply skips over these arguments.
+ */
+static noinline __be32
+nfsd4_decode_ssv_sp_parms(struct nfsd4_compoundargs *argp,
+			  struct nfsd4_exchange_id *exid)
+{
+	u32 count, window, num_gss_handles;
+	__be32 status;
+
+	/* ssp_ops */
+	status = nfsd4_decode_state_protect_ops(argp, exid);
+	if (status)
+		return status;
+
+	/* ssp_hash_algs<> */
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+	while (count--) {
+		status = nfsd4_decode_ignored_string(argp, 0);
+		if (status)
+			return status;
+	}
+
+	/* ssp_encr_algs<> */
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+	while (count--) {
+		status = nfsd4_decode_ignored_string(argp, 0);
+		if (status)
+			return status;
+	}
+
+	if (xdr_stream_decode_u32(argp->xdr, &window) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &num_gss_handles) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)
 {
-	int dummy, tmp;
 	DECODE_HEAD;
+	int dummy;
 
 	READ_BUF(NFS4_VERIFIER_SIZE);
 	COPYMEM(exid->verifier.data, NFS4_VERIFIER_SIZE);
@@ -1517,33 +1559,9 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			return status;
 		break;
 	case SP4_SSV:
-		/* ssp_ops */
-		status = nfsd4_decode_state_protect_ops(argp, exid);
+		status = nfsd4_decode_ssv_sp_parms(argp, exid);
 		if (status)
 			return status;
-
-		/* ssp_hash_algs<> */
-		READ_BUF(4);
-		tmp = be32_to_cpup(p++);
-		while (tmp--) {
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			p += XDR_QUADLEN(dummy);
-		}
-
-		/* ssp_encr_algs<> */
-		READ_BUF(4);
-		tmp = be32_to_cpup(p++);
-		while (tmp--) {
-			READ_BUF(4);
-			dummy = be32_to_cpup(p++);
-			READ_BUF(dummy);
-			p += XDR_QUADLEN(dummy);
-		}
-
-		/* ignore ssp_window and ssp_num_gss_handles: */
-		READ_BUF(8);
 		break;
 	default:
 		goto xdr_error;


