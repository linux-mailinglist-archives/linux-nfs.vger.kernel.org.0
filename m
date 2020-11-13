Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF12B1E32
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKMPHB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgKMPHA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:00 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E381DC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:59 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so3254986qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DW/SxJBilg0v4lPpN6/EnkiSPYriPQECQVoS16rFw5A=;
        b=Ei/XZI6yB8swHtBT8QNtv34yFJElmerOS9/w5fIg5W6HCJTuuII4RfkX1HNlbtcv3+
         IGTZFEtJbd6lQRLPiEmaQJDKtOwQ2BPzo3sEM3lgY/uwMerHk/jM/Hz1czeckc2OyDTx
         vUeDD9mSWiJ3j5Hyd8GlRWgDOjANoWLLftUQRZXW5X+Z9YoPqMdMqT8eeCQsWilcb8wp
         KMq8lO0fjERDTLbrYwiJm7chsTB23F3Y0LD3a0B4ErOirVf8Y8XJHURz8ZiyldIAK4gd
         ttgwoanZsAXtx8L4BMXAan8Dhp4E6QMSMq446ifdqNceVOnh7NkNxw07ryKGnFl1RB2l
         h/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DW/SxJBilg0v4lPpN6/EnkiSPYriPQECQVoS16rFw5A=;
        b=gmTdJ51HNAekx/eScAmMWESjtZDW0AXcJ2Y/XN1LUdO3VLTRhtkqdh7leBi65W/NJC
         QJtQc3DVcJyZ4WB3mKoeZstDmvVYnbFHFG5/7ptiMa1VBeDwczq2PLaHD8/ZbgraQh5G
         nyfaxAXnUxrq0ONLEONE+yPHlQp4jiJNRTcHzO/D6qETQtG/lBnq7GzE2TVk+4yH4nY9
         l18D5VKHUSa6rU5y4KPPAD+SF/btISsQZtWum3qASyoQwkTPreP6SwoUIpT36l8YR+Vg
         8Gijvze2gtLDFOuNYeL3pCIbjqUXcm+d/m8pjUdlx2ozhrOO0iw0tBBgbAqzCoyehZQs
         Hpcw==
X-Gm-Message-State: AOAM532wspSar7chreokHqWvDiNIQE1qx3nVHGKikbzHzr2PzJ6kyaIr
        wHvEc//hSwL9q6oJe2z/qd61Avo+AI0=
X-Google-Smtp-Source: ABdhPJxhktwvlyacFzwwnTWnwQTm+lAvzhy+Qg8fTAF8WGzqAhV82jyHQsd3Eo9NfnurEwrR6+RPjw==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr2304904qtp.296.1605280018631;
        Fri, 13 Nov 2020 07:06:58 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k31sm6602317qtd.40.2020.11.13.07.06.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6uMn000325
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:56 GMT
Subject: [PATCH v1 52/61] NFSD: Replace READ* macros in
 nfsd4_decode_reclaim_complete()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:56 -0500
Message-ID: <160528001696.6186.7670929235558400783.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c69dbe8f5ff2..94e96bf09cc1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1698,16 +1698,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, struct nfsd4_reclaim_complete *rc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	rc->rca_one_fs = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
@@ -1947,6 +1937,13 @@ static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp, str
 	return nfsd4_decode_clientid4(argp, &dc->clientid);
 }
 
+static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, struct nfsd4_reclaim_complete *rc)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &rc->rca_one_fs) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


