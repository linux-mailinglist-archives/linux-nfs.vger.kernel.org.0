Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A722B1E2F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgKMPGu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKMPGt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98668C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id n63so6845515qte.4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hfj040fWupN2i7Qivvf5j0G5fwFfGL93AFleM83oz08=;
        b=T3MckAw+V5MXUL/09cnvfvH9uPj9R6kn8LfcGYIg2ygEoWD9hrDDjJKWklJfPWm4iN
         JcS+jkZCSKY1Bd9ceYku1CRJR82pXUZAmVS19hqP46PtcbAMDgB0sjUaCcvakMiPZYGi
         jBJgYVh4YsYNmi836UAR9ZKX6iByYgaEoCd2yEa0/qVRtp0A25Jd3VpdsWtNUBlz1Sqw
         dRBoDby9MO4Z0fSnXqh+ZiPOtcBIE4G9JbBHT9Xp4AaA9V9qGSjBmPTA32hvDFEO6PKZ
         pdDKiCpA4ZWblQWZBlkTKZyihKGP8Pa/9qm21ztHTFrmctVStlMW1kiXRKANMjIGyxm1
         kMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hfj040fWupN2i7Qivvf5j0G5fwFfGL93AFleM83oz08=;
        b=IjnFa6nbSL9B3ePj1tJ+HOM8dSx0pZbN0QMXdpiqGmT+DrKM7ur64fmmGFPggKgL2q
         Fu9xC+Cvpzy06q/vQnsOOlfU2NsUkNW4txQhKoyDIe3CmIVK+kVy4NEYcMojlc882gta
         QKh6Xb+Xn5rMwRUKqm4wT/F3l7IYO7HnI9ihH3elf+ciVOLJJgYt8M3Vdxsi/Vi8fw81
         dyHR+GzPrLWAUbEwDA1QgeCS+mWqPNedJGkBzRWbmGOwlwAJIS6+GgWpj6ofWGnntIZf
         xxEOtgLtQfq+IZ3FiBkowxSZ2x/EvQNdwUC6PQv7FM8xTaliLILFrnujN6vviNJl4Lk+
         GqpQ==
X-Gm-Message-State: AOAM5329Xk9QtQ986NYWTPxnYv+nkT4S6LvKuAJ+mxp9qQCbyLncA93l
        OTskLNjEILNbO1ziErQ/35sNW9TFmpQ=
X-Google-Smtp-Source: ABdhPJy1DaAP6ZUmNvxZpW5A7lAmJWCTSDbxAB/Lr7h5FemFOkJTsw+cZxU5dJt7hGMD8IRTSDc04Q==
X-Received: by 2002:aed:3943:: with SMTP id l61mr2356609qte.195.1605280008460;
        Fri, 13 Nov 2020 07:06:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l3sm7323350qkj.114.2020.11.13.07.06.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:47 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6kJ8000319
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:46 GMT
Subject: [PATCH v1 50/61] NFSD: Replace READ* macros in
 nfsd4_decode_test_stateid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:46 -0500
Message-ID: <160528000624.6186.10743817554360851924.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   67 +++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7b4f7f8c44da..4e9f911366ef 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1698,42 +1698,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
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
-		status = nfsd4_decode_stateid4(argp, &stateid->ts_id_stateid);
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
@@ -1957,6 +1921,37 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 	return nfserr_bad_xdr;
 }
 
+static __be32
+nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
+{
+	struct nfsd4_test_stateid_id *stateid;
+	__be32 status;
+	u32 i;
+
+	if (xdr_stream_decode_u32(argp->xdr, &test_stateid->ts_num_ids) < 0)
+		goto xdr_error;
+
+	INIT_LIST_HEAD(&test_stateid->ts_stateid_list);
+	for (i = 0; i < test_stateid->ts_num_ids; i++) {
+		stateid = svcxdr_tmpalloc(argp, sizeof(*stateid));
+		if (!stateid)
+			goto nomem;
+		INIT_LIST_HEAD(&stateid->ts_id_list);
+		list_add_tail(&stateid->ts_id_list, &test_stateid->ts_stateid_list);
+		status = nfsd4_decode_stateid4(argp, &stateid->ts_id_stateid);
+		if (status)
+			goto out;
+	}
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserrno(-ENOMEM);
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


