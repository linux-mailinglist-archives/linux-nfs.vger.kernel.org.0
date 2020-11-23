Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7902E2C15FB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgKWUKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbgKWUKK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:10 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCDEC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:10 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so14378559qts.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NVkvmfIF14WvCPapVrQjASHKw0LWR/Wj5JOWXNp8nL8=;
        b=Al5F7+9cY30fMqEXte1O2w2nQ/NYDHjppNgBQ5lJtEH1t8/xHQsrHbxQj4CbwKZl58
         E716j3vQzOVucCZii4uxw9t8jr7MURt9ODTo9jVMx0aB2xmuvw0/o9ZA2A9QDRKkRILT
         vkCgc4XHuXwlffoMwhj7ZjJ/zVpf1bOVSL4K4bFzqU1fpJOerFlWm4qCShIyOPQh6V9O
         KMFrBXaP+ys+/vaPNki8l74OFC1PmRsVDzw7kEcuBDJM9Ecm/aW/Z5glWgmLgkNjxzk/
         WGQ+w+erwyQiVq4k6VITiHKB1SxigXb4OuBgL1fXJh+7PCjM1Ur3Dxpdo5tqpHKHoUlH
         MMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NVkvmfIF14WvCPapVrQjASHKw0LWR/Wj5JOWXNp8nL8=;
        b=rjuNOKfgS9KVusp1Z7vmQVj2sxyYSae8XztuMDor1kc2v0WRSdu/wyaaRsoAOe4cPB
         Wp/F1Y44HPIb+8aFdgJeb7Bszvec+695cr4lR1KTCARTcWCcSArrkMpUWzhewk2N6S2+
         EVW4B9F4kRjrKpLN3EEiU37YxIjoHEyuRzoy+XoZt4wzpgypeoiEOCPi6nIS0+t3pU2H
         RnRxMWyVekBNF/HEZ+Md0qqLl8os+9vbrpwGgbPOPzQsM9tvPPRj6lBOclgqlywMLo5n
         X7XzweJa3oyz6Tj/aWqe7800p6l+7v9+who99ggeGBsGkiEQG+6x2oMM0JOoZQbFCuLr
         ngEw==
X-Gm-Message-State: AOAM533HkCpO70YIgo0EVUqjM4kEYokh9+624ev6l2OgtnaZqSvWz1mC
        YFFd6nO7IH5sO1vHRfaoi4MJM4fuUQc=
X-Google-Smtp-Source: ABdhPJyfPxoSJs2PT6pAlGnJSShg+v1FErPNmt5FE8G2Rqwbj2cEPiKfFCaKyESqIWW7We+zxAT9IQ==
X-Received: by 2002:aed:3768:: with SMTP id i95mr975512qtb.0.1606162209339;
        Mon, 23 Nov 2020 12:10:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u15sm10022318qkj.122.2020.11.23.12.10.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:08 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKA7Nw010494
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:07 GMT
Subject: [PATCH v3 70/85] NFSD: Replace READ* macros in
 nfsd4_decode_test_stateid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:07 -0500
Message-ID: <160616220773.51996.12741311743431409245.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   61 ++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 04f2a9941972..937f5262d619 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1738,42 +1738,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32
-nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
-{
-	int i;
-	__be32 *p, status;
-	struct nfsd4_test_stateid_id *stateid;
-
-	READ_BUF(4);
-	test_stateid->ts_num_ids = ntohl(*p++);
-
-	INIT_LIST_HEAD(&test_stateid->ts_stateid_list);
-
-	for (i = 0; i < test_stateid->ts_num_ids; i++) {
-		stateid = svcxdr_tmpalloc(argp, sizeof(*stateid));
-		if (!stateid) {
-			status = nfserrno(-ENOMEM);
-			goto out;
-		}
-
-		INIT_LIST_HEAD(&stateid->ts_id_list);
-		list_add_tail(&stateid->ts_id_list, &test_stateid->ts_stateid_list);
-
-		status = nfsd4_decode_stateid(argp, &stateid->ts_id_stateid);
-		if (status)
-			goto out;
-	}
-
-	status = 0;
-out:
-	return status;
-xdr_error:
-	dprintk("NFSD: xdr error (%s:%d)\n", __FILE__, __LINE__);
-	status = nfserr_bad_xdr;
-	goto out;
-}
-
 static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp, struct nfsd4_destroy_clientid *dc)
 {
 	DECODE_HEAD;
@@ -1919,6 +1883,31 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
+{
+	struct nfsd4_test_stateid_id *stateid;
+	__be32 status;
+	u32 i;
+
+	if (xdr_stream_decode_u32(argp->xdr, &test_stateid->ts_num_ids) < 0)
+		return nfserr_bad_xdr;
+
+	INIT_LIST_HEAD(&test_stateid->ts_stateid_list);
+	for (i = 0; i < test_stateid->ts_num_ids; i++) {
+		stateid = svcxdr_tmpalloc(argp, sizeof(*stateid));
+		if (!stateid)
+			return nfserrno(-ENOMEM);	/* XXX: not jukebox? */
+		INIT_LIST_HEAD(&stateid->ts_id_list);
+		list_add_tail(&stateid->ts_id_list, &test_stateid->ts_stateid_list);
+		status = nfsd4_decode_stateid4(argp, &stateid->ts_id_stateid);
+		if (status)
+			return status;
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


