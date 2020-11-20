Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D52BB77D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgKTUkS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgKTUkS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:18 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058A7C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:17 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 199so10184948qkg.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=e5Cz+vU5zQOjD0M6LywWumtjWTz+s+1GiM7WbMAQIZY=;
        b=C+INhUC/4TqWYjtcwKO4ISruGvtlPIBmV2L/suGYSQWH0ZGcQQvg6/oMe5Ir8DQWmD
         XXmpME8ab1vE5XQWwQx2Am9xBJP1SHx2DclWFliLE8sViXHc34U3EGFSAHRYPgi8RlkI
         1TO2mmSGtpVZqTTU86NU2mh7/UdualhFtbVreZCV62qh4mfnA9dWFFe5KQ/IohVgi0y1
         G7g9Ci4PHyHrUOaD2exuZDAKRGHFi2ALGUUIvCZXRTgu6vra1CBSw9VMye9P+qZ/lo7U
         JWR6APQvNhoJEcMb6IexdAzZJvMaUwdAD8w25BfJFLs3cqKA9hxsOc7lty1tfJB7k77f
         ezPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=e5Cz+vU5zQOjD0M6LywWumtjWTz+s+1GiM7WbMAQIZY=;
        b=Y+1s6MQlgj8Vtt63JGtaxxDbUhhH7vdSnBnLAEeZgTgdG2L65PBmG6MSm3zsffScrL
         fqBTS92gxjGoFfRnKhEMIdlMWR3rNWq1F9pqrktQp1k2EdttARtmma7d36+HYBaKuYsj
         4NMZhYx9AIoYydgqO7pjc3nFbJj/O947QLzu+79ftA3Ewy7I50p5rurM8Cb0P2kt24kU
         TibWqXL+QijbLBXzFjTMPB99996eLKEFBftLqt40CcZQvJ6/xsbBEWA9TO7o0Srd1fBb
         0PmxTwTjJgM+1O5EwhYHYmxxuCvWaPJCfXwL14DzjeTsJ5IeKdeFYG/4pLmJMskX1MEb
         1thg==
X-Gm-Message-State: AOAM53379OV4hafWA1ECVpX8M7Ls/DUlgZvhPvGolJ34v3HcDZ3DPLm8
        TYWn4Ah8zm3gS1zfy0RNfsc+Fy1OV+g=
X-Google-Smtp-Source: ABdhPJwejHU8ztWhKmLQKbp2cqbg6r8QU/DU3OZU7MxHjSd2tFE03qvffmvlzAJ9pT5MTAgB/LaIXQ==
X-Received: by 2002:a37:9d8:: with SMTP id 207mr4320096qkj.318.1605904815954;
        Fri, 20 Nov 2020 12:40:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y17sm2728105qki.134.2020.11.20.12.40.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:15 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKeEr0029432
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:14 GMT
Subject: [PATCH v2 073/118] NFSD: Replace READ* macros in
 nfsd4_decode_nl4_server()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:14 -0500
Message-ID: <160590481423.1340.11474414605043721718.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ed1e6460b655..6108f8ff36b2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1883,36 +1883,42 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
 static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 				      struct nl4_server *ns)
 {
-	DECODE_HEAD;
 	struct nfs42_netaddr *naddr;
+	__be32 *p;
 
-	READ_BUF(4);
-	ns->nl4_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &ns->nl4_type) < 0)
+		return nfserr_bad_xdr;
 
 	/* currently support for 1 inter-server source server */
 	switch (ns->nl4_type) {
 	case NL4_NETADDR:
 		naddr = &ns->u.nl4_addr;
 
-		READ_BUF(4);
-		naddr->netid_len = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &naddr->netid_len) < 0)
+			return nfserr_bad_xdr;
 		if (naddr->netid_len > RPCBIND_MAXNETIDLEN)
-			goto xdr_error;
+			return nfserr_bad_xdr;
 
-		READ_BUF(naddr->netid_len + 4); /* 4 for uaddr len */
-		COPYMEM(naddr->netid, naddr->netid_len);
+		p = xdr_inline_decode(argp->xdr, naddr->netid_len);
+		if (!p)
+			return nfserr_bad_xdr;
+		memcpy(naddr->netid, p, naddr->netid_len);
 
-		naddr->addr_len = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &naddr->addr_len) < 0)
+			return nfserr_bad_xdr;
 		if (naddr->addr_len > RPCBIND_MAXUADDRLEN)
-			goto xdr_error;
+			return nfserr_bad_xdr;
 
-		READ_BUF(naddr->addr_len);
-		COPYMEM(naddr->addr, naddr->addr_len);
+		p = xdr_inline_decode(argp->xdr, naddr->addr_len);
+		if (!p)
+			return nfserr_bad_xdr;
+		memcpy(naddr->addr, p, naddr->addr_len);
 		break;
 	default:
-		goto xdr_error;
+		return nfserr_bad_xdr;
 	}
-	DECODE_TAIL;
+
+	return nfs_ok;
 }
 
 static __be32


