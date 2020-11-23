Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E402C1609
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgKWUKj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbgKWUKc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:32 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F082C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:31 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id e10so6901063qte.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q2pp9LrvrvncE6V6e0DEkbDl/hzigtwMQF76yr2cgwU=;
        b=dTEcNYA/L2VD4a2708V+ORAMM7eABxINmBFUF2VhZlz+VC+7BgOUbFU5IFc+VUWHUX
         nNH+AjGkQRs0GO4pYjW0AnC91iftvdaMqvI6+KLzvFVdoKZqrCboX49loPuDTWewjfOx
         hKHGdAiUyTzGGn6UtzOwROd+H9zd30N1x8+czTMv5g74D6CvA2dLlFpjBSidYwFIiJPY
         +nm/Hq1LRD7aFJ/x+r5Vx/P3SGFOd3xk51QT0/W76v1p2LDe9wXZnuFJLwpnUEKZe/U5
         gw9rkn+q9nP9oyGqHMLy8+J9uKCnO3B2zFlinLH76JxaX39yPkTrRsPz4ZsOin4UMXfb
         wZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Q2pp9LrvrvncE6V6e0DEkbDl/hzigtwMQF76yr2cgwU=;
        b=eabZlF8EPCqQCSkRK4fMMotRKFkAOYDo/PFeATsNS0lO5W1HtNWuoyh0ODjp1NnISg
         1iTna55NFW40bmwsmFdOuOUEW6Uo/zoRCdGe+3ZV7Cnjad6J1J8Syt07Rshiu/a3uPOY
         Rigb0f5j9Wp23I0AWlrA8vGcMUQ1L3TgphSmFYMAB6Trnl2AINhosQnQhCANCg/l3h7X
         Ohthv0B3yo9OqXMY+yg6ceqQ0rJT1wDY/KaVOS05+kWR0aCbWeTEL4UuvO0uT50j2ygk
         rW3PCC9xF1RnuPFtJwyyIA3Vwd4+h5t01OQ+0/KQs/VFBLSantwX9HXIoYhC84dBgvr7
         hsgg==
X-Gm-Message-State: AOAM533Tepx6BN8nptX+w4LX51Cy9E4LxK/28MrhCtAgdfIYMX0+rtir
        Ou2MjiCZ2Qs6zIyP2CrNwIm0KKKMdyw=
X-Google-Smtp-Source: ABdhPJzVvFTvzt2AvLC29sZpj6xzaKupN+ezwE1AdAslUuscDA9wUrL5Rxa6sVvw36lTkrhCDw6hbQ==
X-Received: by 2002:ac8:7642:: with SMTP id i2mr891937qtr.256.1606162230322;
        Mon, 23 Nov 2020 12:10:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d140sm10152271qke.59.2020.11.23.12.10.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:29 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKASDC010506
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:28 GMT
Subject: [PATCH v3 74/85] NFSD: Replace READ* macros in
 nfsd4_decode_nl4_server()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:28 -0500
Message-ID: <160616222865.51996.16658480268883778047.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cfdf41599cef..6870a2ecce3b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1941,36 +1941,42 @@ nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
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


