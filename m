Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB462EB9D5
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfJaWnW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:22 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34741 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id z144so1171053ywd.1
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qYeYsKsnEQ5L5JWo5ALncCCNlaTcoUQISGF0Hj9ravQ=;
        b=aKyv7pmFC9cflyqMwx2k/RjI3vKB+mVV0qgpPltswl0Zd4Wf5sjO8O5m+aU4Ng7E7C
         F3gQQLt1hguzS32Pdm61/kGHCFXqboTwavNRyFCaKgH+tynAUvowq1N4+nEcjssAVkZJ
         1QVQF6GMGX02l+QnpcN5ThRUO8zbAXpS25vAuhQQOYAaxpkhFpxKVZEgH6HYGPpEtibn
         61O+pkgkjRn7fYyBHLmfLBR9upJ5+eUIjlPfpEhLr3SYZ5/Po03pJb54h+o5Iy7/vqZ+
         0onIEijGRXN2+u/FbYf+CuhA5BpnEzlTVImNNWstDgHZmQ6GJiRCL/+gRxIM4KmqV6q7
         abDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYeYsKsnEQ5L5JWo5ALncCCNlaTcoUQISGF0Hj9ravQ=;
        b=kq2nYjnEV9d77qYjoFLBL9E99NLhs8rhe/QxVeW9pmY/iJXUGSO05s07mtSWiOma5E
         FeiECurZ+9CCJyFFgPSeS5g2HLWpHzIvHMoDM+Xwt4EKfFFMoElYIIvQ6SL3Dfl/Pzxh
         R2H6XiDZiKP8x5y0LTdCziS5NowdKEuw2a8vbS1rVQVCJaip7sHJNvUWxTK0/13xzp6M
         8ABhZlBGq9xLfZXsL+ZKjEucLIeSuZNUoxk3uCu0DuzOqf+PPViHlulYeeVEZnmhhsL+
         u9ddisI50Us1I32XZDbOAA8TRhE2eIA7fAYBZeqouxGffdt9ViiABuBjD4VQXEWcCRC3
         3idQ==
X-Gm-Message-State: APjAAAUXwOUeEzS5w8S8TBwuVkgYLcXdwU11bxdgqLWO1P4n/c43au06
        V0K0O+EqcqhDzQQq8fsBzX058Ew=
X-Google-Smtp-Source: APXvYqw6d7QIT9lUXU2IRHFEnDM1ceCf4Gz9GeO+6il2+qqO5T8r4lO+doDywpo8P/SeqAAbim7wnw==
X-Received: by 2002:a81:6305:: with SMTP id x5mr6390327ywb.312.1572561801290;
        Thu, 31 Oct 2019 15:43:21 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.20
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:20 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/20] NFSv4: Ignore requests to return the delegation if it was revoked
Date:   Thu, 31 Oct 2019 18:40:44 -0400
Message-Id: <20191031224051.8923-14-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-13-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
 <20191031224051.8923-8-trond.myklebust@hammerspace.com>
 <20191031224051.8923-9-trond.myklebust@hammerspace.com>
 <20191031224051.8923-10-trond.myklebust@hammerspace.com>
 <20191031224051.8923-11-trond.myklebust@hammerspace.com>
 <20191031224051.8923-12-trond.myklebust@hammerspace.com>
 <20191031224051.8923-13-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the delegation was revoked, or is already being returned, just
clear the NFS_DELEGATION_RETURN and NFS_DELEGATION_RETURN_IF_CLOSED
flags and keep going.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 8c176c921554..ebd83e4db300 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -476,8 +476,6 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 {
 	bool ret = false;
 
-	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
-		goto out;
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) && !ret) {
@@ -489,7 +487,10 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 			ret = true;
 		spin_unlock(&delegation->lock);
 	}
-out:
+	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
+	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
+		ret = false;
+
 	return ret;
 }
 
-- 
2.23.0

