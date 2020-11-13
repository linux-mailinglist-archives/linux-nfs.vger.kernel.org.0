Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEEF2B1E15
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgKMPFF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPFF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:05 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB27C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:05 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so4700736qvb.6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=y+sqOxjjHz6lV4tJ+S4LbUVcKfzNZhK3aN28Y5pPQr0=;
        b=lsLc5oqSgr+AKbGZwt48uEo8qRdDB175VSiPS2qW1r+7oaVLACdafrl5i96OhoYNZt
         DjLY8cTm0/HN6AztTIg1dk65L7ns9PkCBYmebHUB+fDXNk8R6sDdXAY04vZjJm0cyhNO
         sAiAaO2w0mhxOI+wU4wb2DSGsx6yyOVuKe4oB6tQRMmyBm2iewze6surgQy+v9WJPshA
         NuPqty3ealIIx6xdOAdrwJUR+Tq6fJoVoGYgj1chMKrmkBhN2HOn74/f49ugdlVCUwV2
         Do76pOIbLB/oSMaZhMIxlbGrafjVaGGIdFrRPnbuPvQN0pU/Xtz+52R4hnkh7QLXeUvv
         mt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=y+sqOxjjHz6lV4tJ+S4LbUVcKfzNZhK3aN28Y5pPQr0=;
        b=QdxU+7siCUIAXszYx2J3ucR7Giz7004xCIoWojt7/c4sfyvXXD46H54+nkx1QZPfq+
         8JcEkf6YPGoPuhE43xjL5ThEPkNei96QeP9nUBiBJJB9bWw1W4Zsofk2YMcOygqPpCqp
         FiacCtFDieSLHJ070buIt+rOuGybjnXPv2BczV8ANC3Jrz6jZ7asikVVt2vTC2LYN6KR
         D4p3WlnkQgamxzAh5F6G0y53kOJfKrl1p0k6WE3jPcoG0np3lsHnZdu7ENYt1hGVeEyz
         VHY+8OnHxA/Q4CLVcBkRrBw4IdjC/nqb3+yLGwixcKqRkQ6pJtMw4gtUApVFsjE0HINr
         Vttw==
X-Gm-Message-State: AOAM533mkDNboW3UvtLMfkHKLbqhbgBkibNwtg47r7dcoQJit2sw1A5J
        qQKJd+llqO7GIXYL/jzAeTU/CEYF5ew=
X-Google-Smtp-Source: ABdhPJxBtXC/CzQoAvxjYA/Ks6kQZmlkTXkU8RMh+xZSbZRjETkI5yxN4h+MN1ddGkQQyU7s+5AKJw==
X-Received: by 2002:a0c:fe0f:: with SMTP id x15mr2744228qvr.11.1605279902626;
        Fri, 13 Nov 2020 07:05:02 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m25sm6741222qka.107.2020.11.13.07.05.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:01 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF51x8032727
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:01 GMT
Subject: [PATCH v1 30/61] NFSD: Replace READ* macros in
 nfsd4_decode_setclientid_confirm()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:01 -0500
Message-ID: <160527990118.6186.9734990977907558861.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 82d599887f92..a6d6f999433c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1335,16 +1335,21 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 static __be32
 nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid_confirm *scd_c)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	READ_BUF(8 + NFS4_VERIFIER_SIZE);
-	COPYMEM(&scd_c->sc_clientid, 8);
-	COPYMEM(&scd_c->sc_confirm, NFS4_VERIFIER_SIZE);
+	status = nfsd4_decode_clientid4(argp, &scd_c->sc_clientid);
+	if (status)
+		goto out;
+	status = nfsd4_decode_verifier4(argp, &scd_c->sc_confirm);
+	if (status)
+		goto out;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
 }
 
 /* Also used for NVERIFY */


