Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB92C15D5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgKWUIx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgKWUIw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:52 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A4C061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:51 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so18226555qkk.10
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NQSk4okHm8AyzilFeA+KiYrv/j2cBUHm8a6jv1JtyyQ=;
        b=Pjw/XWZZ67zX54LmIlYIVGWSEU1GjIrbHhMhXW98+sDaUnKnMnr0z676eLWPiyqV2v
         +FsvaQV1oytzh0RD2H5xQK/dt0dbK3Qe2FoRwliA/XJrtFTv2TxlZjHm+mn+3pYjIlVF
         Y3JvyOnJ1hy869qSQGU3Tfcf7asuHukuibhrupYXv69wgaZYLNCQtBPL5hzUPRCQqt3A
         XRvrXXj3MR4qga9ABgPg8yTFT1sGXsUN0LgzjunW+wcA1ucdSxLUglx+3P1ejshp0pZ/
         jCjZdsr+Cv7eQgP6HmFijUNHEgxWxHpw12EX6QtSKqFcvZuZMTActg+1dCUiS0ZNuK7Y
         mNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NQSk4okHm8AyzilFeA+KiYrv/j2cBUHm8a6jv1JtyyQ=;
        b=DQ2UbShw7Dxn7lDBSYVWjwYYq/9Pn5qKFGZZSb7WM1175nPthlDB9IdLTTPRDlWoy8
         Jh4M2Bu4WjWUuDOV0/sMR+f/5hm6yAvYwgRJ3kouWTS1D4r3ikKVfy1ct64bZSy0Qx4i
         tw6Jg2MjGFXnFJYWKI+0KkU/WmPoa5VWyHgQ6hLQ9OFyOqzWAN8J4d4czjFK0vaVRcIh
         J8CmeEEd1WtBW3ThgCseMVwk9igHAIPvLUGmM5DBmRNB43oH7bzt+u2ZcFZ368E15aDW
         VE0nta4ZX0lQD9S5TvouAD/ccLXaszScmwYaS82tpUeXpLxWoLWyfvoiGeOtV98u1P9L
         wx2g==
X-Gm-Message-State: AOAM533i1Np8qC70MIXwmSoCBxXX4MPmW1Dwdht6hmZ4invAmTdnhnQh
        HpixYMQTE0DQcf09BdvLmyjz+/KUFDc=
X-Google-Smtp-Source: ABdhPJwjtemikrX55gfUQFzSqXoYMiIQhvPO6cYaCXxLDzGmWzHTytQCeowuTH/vnUs45Mit1IsISg==
X-Received: by 2002:a37:a8c8:: with SMTP id r191mr1233460qke.58.1606162130264;
        Mon, 23 Nov 2020 12:08:50 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g8sm10766095qkk.131.2020.11.23.12.08.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:49 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8mXc010441
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:48 GMT
Subject: [PATCH v3 55/85] NFSD: Replace READ* macros in
 nfsd4_decode_bind_conn_to_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:48 -0500
Message-ID: <160616212863.51996.8575531760483185115.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A dedicated sessionid4 decoder is introduced that will be used by
other operation decoders in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 87a3c0c53945..9989a6dfb2d4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -664,6 +664,19 @@ nfsd4_decode_state_owner4(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_opaque(argp, owner);
 }
 
+static __be32
+nfsd4_decode_sessionid4(struct nfsd4_compoundargs *argp,
+			struct nfs4_sessionid *sessionid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_MAX_SESSIONID_LEN);
+	if (!p)
+		return nfserr_bad_xdr;
+	memcpy(sessionid->data, p, sizeof(sessionid->data));
+	return nfs_ok;
+}
+
 /* Defined in Appendix A of RFC 5531 */
 static __be32
 nfsd4_decode_authsys_parms(struct nfsd4_compoundargs *argp,
@@ -788,18 +801,6 @@ nfsd4_decode_access(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
-static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
-{
-	DECODE_HEAD;
-
-	READ_BUF(NFS4_MAX_SESSIONID_LEN + 8);
-	COPYMEM(bcts->sessionid.data, NFS4_MAX_SESSIONID_LEN);
-	bcts->dir = be32_to_cpup(p++);
-	/* XXX: skipping ctsa_use_conn_in_rdma_mode.  Perhaps Tom Tucker
-	 * could help us figure out we should be using it. */
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_close(struct nfsd4_compoundargs *argp, struct nfsd4_close *close)
 {
@@ -1479,6 +1480,22 @@ static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, stru
 	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
 }
 
+static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
+{
+	u32 use_conn_in_rdma_mode;
+	__be32 status;
+
+	status = nfsd4_decode_sessionid4(argp, &bcts->sessionid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &bcts->dir) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &use_conn_in_rdma_mode) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)


