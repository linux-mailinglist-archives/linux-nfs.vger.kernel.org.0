Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64022BB777
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgKTUjv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbgKTUju (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:50 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86064C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:50 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id l7so1819139qtp.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6DzxY0kXRPTB+jgKQxJshgh1Ters/AyJ8SX4v+Qq8+E=;
        b=EuyfhNwoaCBNtdWUMryh0JIBkEhW3NEF5XkzOSAU8Y5sOR81XDMY4gPAI4iMEKjswZ
         jKMUR0CG6S2uLVCwM2FQh4Rmfo1fgfAWKQ0zlPRtYkAX5pOZMAzph6PJ3VyCMJTWWEEz
         oc7nOVvZbF8oXi/8Axto2G86wdZq0F0HLVAZwPWOyHKdW2ZzGnsAvD29Qm+poxzuZOfe
         rF0TRE91rDv2tUFzlkYNmcCtCRpPDVLukBHDJnL3gTWXbnRtHHVktf3KiMzEGjuTuxaO
         B1LAs4ibTkQeFg+mV47m7N3ZXOB3IguikW3kfhPuZ66ySeYfIr1l1lWsb9EA3nb9xN0P
         fzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6DzxY0kXRPTB+jgKQxJshgh1Ters/AyJ8SX4v+Qq8+E=;
        b=lXB2mxqiaYdpxS61xfQH0fUnJmAXGN5HX2nfklHPJGlAs0V/FQN0ORbzem+Y3BndXC
         qou5CiRIK9A/eH+E0VszQVgSwoOGaK/4jIys3Gtqm2No+kIft8DLaL0pcOCfOWLCaavy
         N3XmjJF+El+iaD4s4LJquXbGfalSsNfG3HULjQeM4yN97IJsA/Nwbqu0SQ0CEAYoOOfz
         poz+U50HO6RD/Spadrkkma4JJsNsxV/HCclnOq6NvIljQ3PyifBIKsa52/ezQQ7pqr3o
         1cNa6MJfGuQZ/8t6yF4KSCcork3nmjnETs91xzo40IOitfgPwEGW00lF21mh/yy4ZDUe
         ROdg==
X-Gm-Message-State: AOAM533QY2IMDwrPaLbI90BpZdgLUj8ZyRzVilHTgK8+8QOqOkFyJAxV
        eQ10ZMtbSem06GPsqU127OyDR7RjjJM=
X-Google-Smtp-Source: ABdhPJx1cuzXMUAe2qEe/O+M+nTQDuls5KoobwP1zerFJ8PHXfeKCPS5Zy8OVDpR+ZXRNIjsu65ILg==
X-Received: by 2002:ac8:5319:: with SMTP id t25mr17041520qtn.351.1605904789456;
        Fri, 20 Nov 2020 12:39:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t126sm2811009qkh.133.2020.11.20.12.39.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdlmd029407
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:47 GMT
Subject: [PATCH v2 068/118] NFSD: Replace READ* macros in
 nfsd4_decode_test_stateid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:47 -0500
Message-ID: <160590478777.1340.13216682588605987274.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 5544e85b8897..c6301393c422 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1679,42 +1679,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
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
@@ -1859,6 +1823,31 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
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


