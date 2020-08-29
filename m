Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914B125694A
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Aug 2020 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgH2RQH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Aug 2020 13:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgH2RQG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Aug 2020 13:16:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379A2C061236
        for <linux-nfs@vger.kernel.org>; Sat, 29 Aug 2020 10:16:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w3so3289028ilh.5
        for <linux-nfs@vger.kernel.org>; Sat, 29 Aug 2020 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9QsjdaYdmKKRe2Ubr4K0SnQe/Bx7wvIbuB/qOFSLEtU=;
        b=ZhvnZ5JnWNfQXsrNV93iCuZN0ll+qUcBsaBP+CtsiP2fbhNa7yzkz+/ZkAP28XCgBQ
         mSji3EBvi3tbhpcUhcIi6sdCMDXdAinjx0pL6LBsxcjBwKNV+sBuPhSSameWRBOoaOgm
         EsIgW8GPfHOGZBGVvqUZBfuNrO1cUStqpQqMdrNP7YP7M9cBg63eqXHQmTeVamVMwLLX
         qY9tMBRuVGJWkbSD44hzRRzLo69OwO735wxBFAbKFD1bDHUX7caNOIpJ2jnbZNPlZphc
         vOtiS2I9PJLCCNMAG9Fb2uu7P3i9zVmjkv2pQRQMNlgKbRZT2wNXHe9WZ+9k4gVJp+OE
         Z75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9QsjdaYdmKKRe2Ubr4K0SnQe/Bx7wvIbuB/qOFSLEtU=;
        b=LVvso5sH2A2NzNSqXocDD1ZHcI2/nLAJPpKRnNEj0MHxPNk0YAdDD+5gMFvX4AyhZM
         zzCvcZAKhlZB11Cdcg+qZ5BpsdUuCKuI/qAR4ON5tNNCfpAV1mf0NuLHXUsM96blRqgt
         d8Gka8QS+NFRFABn8f+UnkDodgazPM06WZg4Ul2XgM+ozTM+VYJXVtXbLfMgJF+8GXcn
         iu49VgB7xRXYMDvR5WsXTLKhKN5ZbN+m6Rt5m0a8Gt+wPmIbe2HQjR2OcbZdIZ9VvmRe
         bUD1qrjlfr1TMCRrlrr8lTly+U3TZmgnJ+ZBJOewiH4sd4f2anrN6Ctw6JlDyedb/HDc
         3P7w==
X-Gm-Message-State: AOAM530jZmwkvl4wp3vRTXyAKFsnbKXvnX7jpDTJB1+nJ+QFYoXUaGau
        7864scxCdeqwtf3Pt7zWJ3f58CIV1RY=
X-Google-Smtp-Source: ABdhPJyiSM+UlfQ9EFuYACdx40qtve9DA5TAYi5FCn3RNeBjyscvDOJODfe7E49Y7FfisrXo9xgjuA==
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr3297162ilg.8.1598721364991;
        Sat, 29 Aug 2020 10:16:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p124sm1416920iof.19.2020.08.29.10.16.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2020 10:16:03 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07THG1ur004839;
        Sat, 29 Aug 2020 17:16:02 GMT
Subject: [PATCH v2] NFS: Zero-stateid SETATTR should first return delegation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Sat, 29 Aug 2020 13:16:01 -0400
Message-ID: <159872131590.1096729.3952588635826859724.stgit@manet.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a write delegation isn't available, the Linux NFS client uses
a zero-stateid when performing a SETATTR.

NFSv4.0 provides no mechanism for an NFS server to match such a
request to a particular client. It recalls all delegations for that
file, even delegations held by the client issuing the request. If
that client happens to hold a read delegation, the server will
recall it immediately, resulting in an NFS4ERR_DELAY/CB_RECALL/
DELEGRETURN sequence.

Optimize out this pipeline bubble by having the client return any
delegations it may hold on a file before it issues a
SETATTR(zero-stateid) on that file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4proc.c |    2 ++
 1 file changed, 2 insertions(+)

Changes since v1:
- Return the delegation only for NFSv4.0 mounts

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dbd01548335b..bca7245f1e78 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3314,6 +3314,8 @@ static int _nfs4_do_setattr(struct inode *inode,
 			goto zero_stateid;
 	} else {
 zero_stateid:
+		if (server->nfs_client->cl_minorversion == 0)
+			nfs4_inode_return_delegation(inode);
 		nfs4_stateid_copy(&arg->stateid, &zero_stateid);
 	}
 	if (delegation_cred)


