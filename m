Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3462B1E36
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKMPHS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgKMPHR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:17 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C0C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:17 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id l2so9058984qkf.0
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fHbm716OIddML+oaM5igvI2/l5zK5hH6CRVMkQnNjiI=;
        b=C+WL5m/WprDcDwtWG1IQLoahkBdicXWzfknhapjgnwcGKm5XkIDzbmNwXerr+2tR8q
         z3+tZjGykh5+DMZs6f765o6+x7lgRudwFyiAHfbH+lbdpBi31wlcuCR8CKcdXquq9LV4
         WwepoUFVkfu30RK0FV6fttj2/USTrhiHmXeiUgnYnanHAfWYzf1BpV0/KJngbKIXulZn
         y9gCYn1L1ipi67NWJet8lYY9L4ty5hcFro20bX8t4mKStW3+wTyHNuXbcNeCP5ACg+dr
         wUe+DM2uRhQ5NeTbOdVq1FelVwWJPzfgTdNiQnu0t7BOBY3wkDqawJp2JSsn3bEbrq94
         vlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=fHbm716OIddML+oaM5igvI2/l5zK5hH6CRVMkQnNjiI=;
        b=EJQuMdsnVQUWivf08FTYK7uAI7d7csazyH+A1Cko7N/zRYGoOY4Y2KFuZglUE0OlhK
         j5W5CJ7eFax12eyy7aDQvbmWRfGI+bsRXXqpDOCinSgd2uS9Ztrt8xpfbLGfai20R2xM
         /eL3JC9j+R44JHCkkrJVPMdlS/UJ3oLDGzX6DqCM/FNDRGhG9h3GaWAW+GIb7FBxrERw
         DWRyMPrB7HXCWEYOBJWwUwTZJGKqP2GJ732FBMamyMf/WYwTk3txIZHDXDVhXtOGxpOl
         YAzz5Y/1Uw4DJQrtScRpVK9AaTi+9Gvw4dV8z0vmD5NK3FBW6QklUjBkcvdzNBkEP8j8
         pk+w==
X-Gm-Message-State: AOAM5325dD130ADfr2Kk4zPA7mkKkTIsXOLKDfhj2ND8yVVHF5/VyAIc
        eHwVHVIfGEY899OF6whPTxDJMUDLJgk=
X-Google-Smtp-Source: ABdhPJx5ZXMgiHpHABErlT88dIbF+RLQCR7VnepU49e8hFMet3mAAdRej8qzVjnoY3b6DpvZGOvXVg==
X-Received: by 2002:a37:7c04:: with SMTP id x4mr2245680qkc.441.1605280034709;
        Fri, 13 Nov 2020 07:07:14 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t133sm7082909qke.82.2020.11.13.07.07.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:14 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF7Dmu000334
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:13 GMT
Subject: [PATCH v1 55/61] NFSD: Replace READ* macros in nfsd4_decode_copy()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:13 -0500
Message-ID: <160528003304.6186.14520651807274321599.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7e969f04f62f..408da2625dba 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1993,43 +1993,51 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
 static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 				      struct nl4_server *ns)
 {
-	DECODE_HEAD;
 	struct nfs42_netaddr *naddr;
+	__be32 *p;
 
-	READ_BUF(4);
-	ns->nl4_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &ns->nl4_type) < 0)
+		goto xdr_error;
 
 	/* currently support for 1 inter-server source server */
 	switch (ns->nl4_type) {
 	case NL4_NETADDR:
 		naddr = &ns->u.nl4_addr;
 
-		READ_BUF(4);
-		naddr->netid_len = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &naddr->netid_len) < 0)
+			goto xdr_error;
 		if (naddr->netid_len > RPCBIND_MAXNETIDLEN)
 			goto xdr_error;
 
-		READ_BUF(naddr->netid_len + 4); /* 4 for uaddr len */
-		COPYMEM(naddr->netid, naddr->netid_len);
+		p = xdr_inline_decode(argp->xdr, naddr->netid_len);
+		if (!p)
+			goto xdr_error;
+		memcpy(naddr->netid, p, naddr->netid_len);
 
-		naddr->addr_len = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &naddr->addr_len) < 0)
+			goto xdr_error;
 		if (naddr->addr_len > RPCBIND_MAXUADDRLEN)
 			goto xdr_error;
 
-		READ_BUF(naddr->addr_len);
-		COPYMEM(naddr->addr, naddr->addr_len);
+		p = xdr_inline_decode(argp->xdr, naddr->addr_len);
+		if (!p)
+			goto xdr_error;
+		memcpy(naddr->addr, p, naddr->addr_len);
 		break;
 	default:
 		goto xdr_error;
 	}
-	DECODE_TAIL;
+
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
-	DECODE_HEAD;
 	struct nl4_server *ns_dummy;
+	__be32 *p, status;
 	int i, count;
 
 	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
@@ -2039,7 +2047,9 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	if (status)
 		return status;
 
-	READ_BUF(8 + 8 + 8 + 4 + 4 + 4);
+	p = xdr_inline_decode(argp->xdr, sizeof(__be64) * 3 + sizeof(__be32) * 3);
+	if (!p)
+		goto xdr_error;
 	p = xdr_decode_hyper(p, &copy->cp_src_pos);
 	p = xdr_decode_hyper(p, &copy->cp_dst_pos);
 	p = xdr_decode_hyper(p, &copy->cp_count);
@@ -2057,7 +2067,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	/* decode all the supplied server addresses but use first */
 	status = nfsd4_decode_nl4_server(argp, &copy->cp_src);
 	if (status)
-		return status;
+		goto out;
 
 	ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
 	if (ns_dummy == NULL)
@@ -2071,8 +2081,11 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	}
 	kfree(ns_dummy);
 intra:
-
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


