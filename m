Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5832B1E19
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgKMPFU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPFU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:05:20 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663E0C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:19 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id z17so4678376qvy.11
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AATQi/3PHsNcqlmpzDs0L1GRz6dLwEwqH36LOnZSN30=;
        b=UuZeIFKJ82bxCL1sfZPe9qikuYICeKiip4CD01GJYbdUrONuXJmeKsj5twSqShhYRP
         SJkpfWGW3/VWyzeNqBVIuiKaVeiznPt0CrAeC7EVuNCVUTG57cOlj25xfZfXGWW248lP
         +tBV/Oee32Kki5qpBA2qGhXJcYeefOEnpjjkr23JUcIEwxVj2L1AmJnk8eFUAoxmA4CV
         F0w1xVejzF4WHBuL97u+dYD9T5vSsQvdm4pqlswyE3OeBjYsa46bXBjOrA9QKjeaXi6C
         qJ0bGFMg1RZylWNGSnaEU+9J68o+lQI9bm/Y++V611XFS3x4mM+4FW9z37gz4DbMHEJU
         9pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AATQi/3PHsNcqlmpzDs0L1GRz6dLwEwqH36LOnZSN30=;
        b=PgG/Lw5i5HslxD5rUOb3kq7T04a9KAQGXfotvq8UqEjR6GOG76rvKtIeu8sZwPbCle
         hmTkcpfG4XGwY7v6kP0P5Zhu1mLyNlwCRiOHPVdQFA9l1SfV0TarrdEuIMVN30R8hjO/
         jG+xT+gFaXUi9e7Q2qN0PN7AKtYt97slae367pb4drsyvPMLUjX8imlNbYbXdNRKwTyX
         qB8FKYsPSFhijHASUTwlbk9lSiK6g/d1ViaZ2sykNTtgZfjFJ/c0TiT73J6YumCoDvec
         WII/lZQIPk03QkiGvQmIoW8icqeA++EcZEe0Ssic9XtvY//7Osp6yWeEdbRVqmWUGGj8
         L/Fg==
X-Gm-Message-State: AOAM530tdeMAlAhye3AsfBp8eHIseBBmOcuH3jpH0up1LCI4yQpR8l4d
        bResc7Js5IWxeKqOM5d8TtoQWuNu2AE=
X-Google-Smtp-Source: ABdhPJxuarLo4AIqkaX4mnRzwF31M64EU8OX1s7XAk0Va4yKB71zyOkEEvIzR9wvdI3F5h4cVz6VsA==
X-Received: by 2002:ad4:524d:: with SMTP id s13mr2764938qvq.19.1605279918285;
        Fri, 13 Nov 2020 07:05:18 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a3sm6679591qtp.63.2020.11.13.07.05.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:05:17 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF5GZI032736
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:05:16 GMT
Subject: [PATCH v1 33/61] NFSD: Replace READ* macros in
 nfsd4_decode_release_lockowner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:05:16 -0500
Message-ID: <160527991682.6186.3164857695766265038.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index db63cd46b9b1..4a71346dcd9a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1413,20 +1413,24 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
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
+		goto out;
 
 	if (argp->minorversion && !zero_clientid(&rlockowner->rl_clientid))
-		return nfserr_inval;
-	DECODE_TAIL;
+		goto inval_arg;
+
+	status = nfs_ok;
+out:
+	return status;
+inval_arg:
+	return nfserr_inval;
 }
 
 static __be32


