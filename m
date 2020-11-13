Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7452B1E23
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgKMPFy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPFx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:53 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D091C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:35 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id a15so2545679qvk.5
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YGj5bWKJIkJFlw0NfGjJ9NNND8YbZyUVEdMssQwW4vY=;
        b=dI2+KovC+wK5ZFm+mUAR21WTdfR33PFa84zmB3L3k6ybPoIYgR1BSEffG8abe8ema6
         1z8DvqAif46Xqz9RdSItXv9T6JLtyBK13bJfuFlYbPY2pICVUU33XxohJXgEhmfHL6In
         /q43rJcjVkJkw0QVACkpQrB28B7IoTwJWI5BnGU82kF293GWyofhuKUweg8+cm7kbCKF
         7Dv5SnnJFzOGVz1lpTcKKAmU0R7t5jCQKlTOdgP+tsmzAsJxDh7C6jQHzx406mXPRmPs
         pG8/AI0QnWstI1eFwBbxv2k8CpvMCBY9wv/Jt6v1lZOGdQ8/vbcscQP+7N66BQPhAdoi
         Eztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YGj5bWKJIkJFlw0NfGjJ9NNND8YbZyUVEdMssQwW4vY=;
        b=fr8L6u2hXfXErxKGqV8rOe0VdNUqzfgCdy5ttkPL62wGeL2wv4+fzTrAP+5uxGMj00
         CpjpaY7qtpqCExuj3iMZPU6zkviJthHT5SbtYqWvTfQchqTU5QoqBvW+05TNkRMm+4l2
         IFz7dyJX7nmBTJYShQoPXw6keBNmDm217eNRRj0VuJbYRj5B3fdmqIRflaKNnFoeJ8u9
         36atE9bz/Az48R8zrs+JoOyq+sr+vW3/OL6HN4SbsBdq6trJDCeq93LymY9cxF5x0C08
         qL5cThYb+IDXNUaBhEAFHD8lcdv/Tj0Snid0nkpoCX4k3vcpy66W8KdaYNQr7caBh7Gq
         XRgQ==
X-Gm-Message-State: AOAM5316eBJv7I2z2zbF5mVFWPla27LESDZZcWlGmRkQwHtov8plOCC4
        lk7aO97g5IUAD2FJ8hVQ1N0IVJfAqao=
X-Google-Smtp-Source: ABdhPJy9Ed/SdZqCtBupSHWNOzkWOoqQzu5eztsa4Wh8iLx1qIthyJixjB+vzVWbuaVEUzsxbxnhOg==
X-Received: by 2002:a0c:9004:: with SMTP id o4mr2808935qvo.17.1605279934153;
        Fri, 13 Nov 2020 07:05:34 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q189sm7018021qkd.41.2020.11.13.07.05.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:33 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5WiD032745
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:32 GMT
Subject: [PATCH v1 36/61] NFSD: Replace READ* macros in
 nfsd4_decode_bind_conn_to_session()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:32 -0500
Message-ID: <160527993246.6186.10485335449992679865.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ff466bea0084..73a4b23849e2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -568,6 +568,20 @@ nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	return nfserr_bad_xdr;
 }
 
+static __be32 nfsd4_decode_sessionid(struct nfsd4_compoundargs *argp,
+				     struct nfs4_sessionid *sessionid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_MAX_SESSIONID_LEN);
+	if (!p)
+		goto xdr_error;
+	memcpy(sessionid->data, p, sizeof(sessionid->data));
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 {
 	struct user_namespace *userns = nfsd_user_namespace(argp->rqstp);
@@ -678,18 +692,6 @@ nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access
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
@@ -1448,6 +1450,26 @@ static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, stru
 	return nfserr_bad_xdr;
 }
 
+static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
+{
+	__be32 *p, status;
+
+	status = nfsd4_decode_sessionid(argp, &bcts->sessionid);
+	if (status)
+		goto out;
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32) * 2);
+	if (!p)
+		goto xdr_error;
+	bcts->dir = be32_to_cpup(p);
+	/* ctsa_use_conn_in_rdma_mode is ignored */
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)


