Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC332BB756
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgKTUiP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgKTUiP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:15 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD2C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:14 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so10246848qke.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PzeILBtKxTimLUUwEXm6EIWPTMyjs7SG/SmKUwtVW4w=;
        b=pmnHt6G/Lsd42Ht6gHRP7ATjEBtjmodkItu1xT9vY/oVlNxR/4nEkstzm34kFsiaiQ
         YqTY5C7+MjmrPXYVVUwjhu/eOQp4UpQehLNrKsxZxSyr/zmdYrBXiUsT4V0c0xZU7Sbr
         wt4PdL5P98dJPnDAG6WxWMhev8KPHaWlSRk/RET9s0nuGHurQKl+fQcbt12QxOs4iFyx
         DQngfKIDY0lKDwiY9kq+T/e1+6WL5/eo+pMxxG5v9UM2du1knKYWZT3O1bywBIhSYy+P
         9ggmxzYLLZqoBy+aYpqRBLNx3U62jc2pVLtvXgT/sFKLZg3s65zy0YJi8zVr+fOFYzm4
         Zokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PzeILBtKxTimLUUwEXm6EIWPTMyjs7SG/SmKUwtVW4w=;
        b=HRniv6LjOgpGP33qFLpEDem2peCAsmhB0tUHllqfAOeWJf5U0q7mmJ/g5XIhkMc2k0
         0O0pK7SxOQOqgeXNiZVTUrpdvWFCZiRTN5inELHfvn2r+fjSqSDhr8o9I7AZYxnmZA4H
         Kgvm6pVNXyA56cnpkJZZrhw6rp6kCTcIKw+0oRGJyEhA0aN6u2hoopQ5pflHzl4RgYFb
         6PSy6hmVJksT6hgpReQ6FJqYS0BYhvddsDDu9grW4XreCIUeWEJ4IQN0AXFZcsSVxO8o
         e6ToaWfPrx7UQjHMReOzKHWAtpwnqOr1YvBt5rqOm/ZslFBaUVvBxf83aTWaBFmke9aO
         NDEg==
X-Gm-Message-State: AOAM533NqAuQJ6teIvLEbFwfCiZ5aFKp+P8XDhe6L3ab7cvyNJpcDZbE
        FvG46t2xUlvIZsxgLmKhZUs1hghXZko=
X-Google-Smtp-Source: ABdhPJzZY7XvVT0M7KtaWbHKXsM+tR8F0vJ4W6spTePawYLWOUuzFeAzgAFDg0IueEob4aU0C9f5Sw==
X-Received: by 2002:a37:8f47:: with SMTP id r68mr15119235qkd.262.1605904693949;
        Fri, 20 Nov 2020 12:38:13 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r125sm2623023qke.129.2020.11.20.12.38.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:13 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcCdk029352
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:12 GMT
Subject: [PATCH v2 050/118] NFSD: Replace READ* macros in
 nfsd4_decode_release_lockowner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:12 -0500
Message-ID: <160590469227.1340.13786920560754843823.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 65c34bb52d16..8e2609658904 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1363,20 +1363,20 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 static __be32
 nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_release_lockowner *rlockowner)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	READ_BUF(12);
-	COPYMEM(&rlockowner->rl_clientid, sizeof(clientid_t));
-	rlockowner->rl_owner.len = be32_to_cpup(p++);
-	READ_BUF(rlockowner->rl_owner.len);
-	READMEM(rlockowner->rl_owner.data, rlockowner->rl_owner.len);
+	status = nfsd4_decode_state_owner4(argp, &rlockowner->rl_clientid,
+					   &rlockowner->rl_owner);
+	if (status)
+		return status;
 
 	if (argp->minorversion && !zero_clientid(&rlockowner->rl_clientid))
 		return nfserr_inval;
-	DECODE_TAIL;
+
+	return nfs_ok;
 }
 
 static __be32


