Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58FB2BB740
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbgKTUgj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKTUgj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:39 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFBBC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:38 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q22so10212052qkq.6
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TKdLiWy1rsc4avKu1TeH1lCAs05UgXfb3Iyd5eYnPCk=;
        b=GVU2vNxcJQpU171VCD43iUB/EUTtmhS56VGapMygC0KP8PGIgDWcJmL/Lp2dnONwRD
         5s3l8mvMpigEViSU6ZtR/ipCc5QE9GSzXpco86bUmej0Kpg7bXVGiKlg6rbPlq1hRnLq
         vtflkROJkQLQEQIUo/7nF4BK5hM8z21OhnyUL9rxDW/eQJMCwedo1LLsKudDJzqOWSXl
         8gujalIJNYkHoVCO2aG1uPiRL4Ax3mSraDY2OHasWfwnvckXRdfKe789AfsOKg6TJ0pF
         qShbHa4qkuGFi0WJeJX3i+V3yLZoYT7PlLc0nBroHGGbA7+B+MGDLk52VhfLM78eTNkR
         0V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TKdLiWy1rsc4avKu1TeH1lCAs05UgXfb3Iyd5eYnPCk=;
        b=nJoKv5JoEW6H8WmMj/wk97SmUFCJBSmURowzDl+AvT6V8CfePU28nVMmGsNIyAvcPA
         HHNPIEGHXI5NgLKKhw3W4LYAJJMiSTUP3B1HDlQ/Y8x4czrxfwem2zPleD+cRu/OCQ8S
         oJhWhRXYAEIQ0nMmoZZLNh6W+W8D0a66iroj5xczAdYvD8NnwwMGcnS/M0XYF9/0jDCx
         RmfLrEsRIccrqCJokJn8j1UiqA0RmIXbMnUa2ouqL4wbq+Du8A7/3PX/kgK3au4tmYMU
         IHujl6JslXe3mEWnf4SNwqINoZarvH96YY5ZfHL9uhDECCMDyGGPzlZc1vQLkttwsN8M
         xNsw==
X-Gm-Message-State: AOAM533th6zvqnF65r8KEe6lI+FruLHBet80AxLIqwlckMUaec6JSjuG
        pYWIajSvm+iYjWmVn4O0etq3akEXk6c=
X-Google-Smtp-Source: ABdhPJzNEniEp11ub8bUsh8LkCw+TInP4gMNTtcPN754MKeOJay8kyvqvOtS6k38yodgivwvgPxagA==
X-Received: by 2002:a37:a4c3:: with SMTP id n186mr17992720qke.495.1605904597909;
        Fri, 20 Nov 2020 12:36:37 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j13sm3087945qtc.81.2020.11.20.12.36.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:37 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKaarX029298
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:36 GMT
Subject: [PATCH v2 032/118] NFSD: Add helper to decode OPEN's openflag4
 argument
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:36 -0500
Message-ID: <160590459624.1340.697626830303772303.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e8646f1e0b6a..608cb5e38c63 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -935,6 +935,28 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_openflag4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_create) < 0)
+		return nfserr_bad_xdr;
+	switch (open->op_create) {
+	case NFS4_OPEN_NOCREATE:
+		break;
+	case NFS4_OPEN_CREATE:
+		status = nfsd4_decode_createhow4(argp, open);
+		if (status)
+			return status;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)
 {
 	__be32 *p;
@@ -1029,19 +1051,9 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	status = nfsd4_decode_opaque(argp, &open->op_owner);
 	if (status)
 		goto xdr_error;
-	READ_BUF(4);
-	open->op_create = be32_to_cpup(p++);
-	switch (open->op_create) {
-	case NFS4_OPEN_NOCREATE:
-		break;
-	case NFS4_OPEN_CREATE:
-		status = nfsd4_decode_createhow4(argp, open);
-		if (status)
-			return status;
-		break;
-	default:
-		goto xdr_error;
-	}
+	status = nfsd4_decode_openflag4(argp, open);
+	if (status)
+		return status;
 
 	/* open_claim */
 	READ_BUF(4);


