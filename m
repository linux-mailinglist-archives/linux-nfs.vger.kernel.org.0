Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1B2B1E28
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKMPGV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPGU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:20 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D8EC0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d28so8997139qka.11
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d9Ct7s9MV0J75HNDOU83LHMye3sc0YuxBImDqDiLbho=;
        b=cbKMPcwtFmaTS6okTIQTartUrgmA/cRz+SFcuR8nMygNxqlhpzNW7SqbUt3sefqORZ
         L/akRv4ibb3O+cAW1JtdiHx1hnMYRoSJ0AhME/eFpEI23uDMOWmaGftJmxy+AD16PBWE
         UiOXl2HuGhWH/CICvmZZO4FcnandCa5LL2NvkOj24hNq24HH2M6VailvfYcoV7AqT7vS
         waBT8mqUVp36dOy/5F6VwPeSNxbf934j4ATx2EHr9DZC0AJmtP/XagHgGlRnIuIU+KDh
         tJJIIg6CL9aUv/tzelVRVh0AdQ7/cINbGgHXPFigOpb5V9+khipyNHoCJ5zLYHU5+SzK
         SABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=d9Ct7s9MV0J75HNDOU83LHMye3sc0YuxBImDqDiLbho=;
        b=Z1W0juCZe5LhH/o5Hn3oLojtUPcUudhiSIQ4R5yZFLuJfzNvnqYCf+85XCCUnd5AP6
         xPjyQPK4rRrouzatgqW1n8FhN6FB1IUvROrQv5l778IrrvYt+A4kt69MBVwiIZEC7Eti
         Zq3D2L5mM20MNud0KVdnTn0wqRTyDWEKFKu9y85qIl0XaOiZmbUhijd9sjPHtSekXwtZ
         dxid3EV+NDEod6VM2iY56ipkjugkIEOg789r3cansdH46RPQ3wIYORVd3GPbjRfE8uoJ
         rZQCGYohKiJ0uu21GL/ILpKXvyDk1v6ilmrn0KiXrDskNue/W4V12XNEj/QdLwuQNszv
         412A==
X-Gm-Message-State: AOAM531rdRxshbabAyYLE7/7C2sSw0WbBKNTMNRemx83hv9LrOjXkfKr
        FltKCk6Ge1tsF+exosMefw1le//nDO8=
X-Google-Smtp-Source: ABdhPJw90OntBbuHzTUvB9C+Xh8gRS5Ou/5RWYFEggROLGuwHkLUQrbFbM1LVeFLiSE04tLdiqJLJQ==
X-Received: by 2002:a37:de02:: with SMTP id h2mr2114870qkj.99.1605279976139;
        Fri, 13 Nov 2020 07:06:16 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b197sm6544161qkg.65.2020.11.13.07.06.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:15 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6EdZ000301
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:14 GMT
Subject: [PATCH v1 44/61] NFSD: Replace READ* macros in
 nfsd4_decode_getdeviceinfo()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:14 -0500
Message-ID: <160527997453.6186.18349513612608306144.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   56 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c752924e2cdf..44ffcaac3c8e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -570,6 +570,23 @@ nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	return nfserr_bad_xdr;
 }
 
+#ifdef CONFIG_NFSD_PNFS
+static __be32
+nfsd4_decode_deviceid4(struct nfsd4_compoundargs *argp,
+		       struct nfsd4_deviceid *devid)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_DEVICEID4_SIZE);
+	if (!p)
+		goto xdr_error;
+	memcpy(devid, p, sizeof(*devid));
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+#endif /* CONFIG_NFSD_PNFS */
+
 static __be32 nfsd4_decode_sessionid(struct nfsd4_compoundargs *argp,
 				     struct nfs4_sessionid *sessionid)
 {
@@ -1769,27 +1786,24 @@ static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
 		struct nfsd4_getdeviceinfo *gdev)
 {
-	DECODE_HEAD;
-	u32 num, i;
-
-	READ_BUF(sizeof(struct nfsd4_deviceid) + 3 * 4);
-	COPYMEM(&gdev->gd_devid, sizeof(struct nfsd4_deviceid));
-	gdev->gd_layout_type = be32_to_cpup(p++);
-	gdev->gd_maxcount = be32_to_cpup(p++);
-	num = be32_to_cpup(p++);
-	if (num) {
-		if (num > 1000)
-			goto xdr_error;
-		READ_BUF(4 * num);
-		gdev->gd_notify_types = be32_to_cpup(p++);
-		for (i = 1; i < num; i++) {
-			if (be32_to_cpup(p++)) {
-				status = nfserr_inval;
-				goto out;
-			}
-		}
-	}
-	DECODE_TAIL;
+	__be32 status;
+
+	status = nfsd4_decode_deviceid4(argp, &gdev->gd_devid);
+	if (status)
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_layout_type) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &gdev->gd_maxcount) < 0)
+		goto xdr_error;
+	status = nfsd4_decode_bitmap4(argp, &gdev->gd_notify_types, 1);
+	if (status)
+		goto out;
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


