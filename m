Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77D42C15B5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKWUHR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWUHQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:16 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84ECC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:16 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so18280649qke.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9Zur4rLgsmsi+76cQ7Dymuzv8Z04tb3Sv3g444mU0HI=;
        b=CruwXpllkk420eRzqpcHrKZDDCS3O8aWIy9oiy+vDWSJBRrTT6R0GTFDHEeBePKN65
         trfv8aq98GLQGj0SDJTZBBUNAKuMOYGqgpg6nAmZ5/uAMUq9Y3hHy45ZDtSjB8HNsEDo
         zPj90aYrQInFeyyjuF/hkIf+VQr8PPL/I6S+0ez6QglwDtm5Hu6+9h5AgZyTdM1Yz2i2
         QtvRyMLnnOEaoXFOA/zwFmJGebgmHPkcDam4BHL9OU3Qo9+Z0SbevCC/yLQcfI3Phksw
         JAlxqJrgPVUem8g1SyVOUrV1aHMeO4BlW9296X4gk3mBwoqI/Y53H81LRzRQwemscVYb
         ZgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9Zur4rLgsmsi+76cQ7Dymuzv8Z04tb3Sv3g444mU0HI=;
        b=LRUr+iUgTLwKh1NoCXVThqvbIYXs+bcZ5oDoCHQK3jTtb1QgImDY2z3UMH2NS3idQS
         mJFTMFINi9ubE5jv5BHzCMkELRD9GH3qkEMtjV8OGN+oiS8d/DkzB78nUxbkvHcCH8Rv
         XoMtFjb6wpOph79Y2U7Ck6G6RH26wyuHHB1RWzpwO488xzU2786m1NyltSI6T8vxeEYZ
         GSyBFwGjctSC6c45WZQb1viBZCng81fBpEBOdRGE6DvrGMnDPfceXLAsSV/WJc19ZYRs
         wmORagHWDwRH20SmVkiZyOvNG/i1nDKbA9KDqPwSG3lAleu68mZ4KP2yN/HaG48QRYgR
         v/XQ==
X-Gm-Message-State: AOAM532QOdgACaRNfWvGQmW6Hq4HVDJCjNU8aMtYVcJOVcL41xnssTHI
        BjaTR/zmsT/Q6ql1ohoOYKpH0cNVQs4=
X-Google-Smtp-Source: ABdhPJzUdpBrZ4GW6B6eJJ9C57lqJjLjJuFut/3lhTABdVpsFR5k5eHZ5fq2EL5uOBbkbZO8FKHjHg==
X-Received: by 2002:a37:9b06:: with SMTP id d6mr1241179qke.116.1606162035748;
        Mon, 23 Nov 2020 12:07:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 9sm9806308qty.30.2020.11.23.12.07.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:15 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7EU5010379
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:14 GMT
Subject: [PATCH v3 37/85] NFSD: Replace READ* macros in nfsd4_decode_open()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:14 -0500
Message-ID: <160616203402.51996.6916215265413569824.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index efd8ae108b2d..fc244661b048 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1124,7 +1124,7 @@ nfsd4_decode_open_claim4(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {
-	DECODE_HEAD;
+	__be32 status;
 	u32 dummy;
 
 	memset(open->op_bmval, 0, sizeof(open->op_bmval));
@@ -1132,28 +1132,24 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	open->op_openowner = NULL;
 
 	open->op_xdr_error = 0;
-	/* seqid, share_access, share_deny, clientid, ownerlen */
-	READ_BUF(4);
-	open->op_seqid = be32_to_cpup(p++);
-	/* decode, yet ignore deleg_when until supported */
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_seqid) < 0)
+		return nfserr_bad_xdr;
+	/* deleg_want is ignored */
 	status = nfsd4_decode_share_access(argp, &open->op_share_access,
 					   &open->op_deleg_want, &dummy);
 	if (status)
-		goto xdr_error;
+		return status;
 	status = nfsd4_decode_share_deny(argp, &open->op_share_deny);
 	if (status)
-		goto xdr_error;
-	READ_BUF(sizeof(clientid_t));
-	COPYMEM(&open->op_clientid, sizeof(clientid_t));
-	status = nfsd4_decode_opaque(argp, &open->op_owner);
+		return status;
+	status = nfsd4_decode_state_owner4(argp, &open->op_clientid,
+					   &open->op_owner);
 	if (status)
-		goto xdr_error;
+		return status;
 	status = nfsd4_decode_openflag4(argp, open);
 	if (status)
 		return status;
-	status = nfsd4_decode_open_claim4(argp, open);
-
-	DECODE_TAIL;
+	return nfsd4_decode_open_claim4(argp, open);
 }
 
 static __be32


