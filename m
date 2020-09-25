Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F28F27914A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgIYTDr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYTDr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 15:03:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03775C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 12:03:46 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d190so4031896iof.3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=w3u9dmXR5tXkbo1Dw1ayQo71KiH6eoum8XaQ0vn8Fww=;
        b=B8UxaZ6m0T7ypl/qXGwE6BfmUqr6lOnr5Rd3FMRZM/3AzOwC6JkvjHlwsZFaAgTHvY
         GL4qygHil7xT9xYi80YMBQv9Th1ejUNMfldKLo7z3W4BLeemqlgSpISWjVYzgK3XDVxk
         0ysiYCXUukeYRClPzQSkq6ZtylRdSXsb4rsXLUwhpO+fYuXT/CwMlf4S5iQUxccroabZ
         hKPPTKnalXxnsXcU001oHfFO7p03vZlM7ylwMP7n4o8quP+pv5wN1gQhRLbJQJUo2VOI
         HRremrpXZHT8JhY3BaZwNTfua2SxOw62qZvc6/rA0jwIr21ugDiNzLsY6ysPBejrO8r7
         HR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=w3u9dmXR5tXkbo1Dw1ayQo71KiH6eoum8XaQ0vn8Fww=;
        b=PmMPD8/WwvE5GOTd5HYL5ISxM9WrTqOiCHFnd1pYeRuf9am6VVaYMD+VEkPaGSFAD2
         L1fWi16fSAAtH0/H8JU33Bqp3Ery3qGz0tbU0p53glvCVUTF0RsVNmq82KF8h3aS+Mz7
         aZ2Lkp9b1Bk+Uti5jvXiUM8M+8GpC7V3av6tzCJaIicCds/8bePeheP+1sKJTK1ggzWg
         ltDmEP51HpZ6xUpoHhzH8h6Z2DDS+Qe2lBsvC+MSbkjhvrSuFwqpvdibDisezrjdh0fI
         8cGuG/1tUVBedMGIyw4lkEstgLF2xTG8aSEVypeB2I37vdXMTekJhJpCreZ4ebrYOkib
         x/sw==
X-Gm-Message-State: AOAM530QyLQQhWc/HWh+j2SMJkilg8jpLJmC7qsjfo2NtGeJ5Wy52E/6
        DYJ+Pk02cXKuy1658rCWUI1aTCeNumrhow==
X-Google-Smtp-Source: ABdhPJxzO600UCGj7VQqq1tJ8AIgXAsKMrs8LCBuE+xXio7sNTtHCe9HD2CKM2tOBFM9NDe7j6+S5Q==
X-Received: by 2002:a5d:8188:: with SMTP id u8mr29108ion.66.1601060625842;
        Fri, 25 Sep 2020 12:03:45 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 2sm1515914iow.4.2020.09.25.12.03.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:03:45 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PJ3gBB014753;
        Fri, 25 Sep 2020 19:03:43 GMT
Subject: [PATCH] nfsd: rq_lease_breaker cleanup
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 15:03:42 -0400
Message-ID: <160106058240.10141.2317053300018495103.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: J. Bruce Fields <bfields@redhat.com>

Since only the v4 code cares about it, maybe it's better to leave
rq_lease_breaker out of the common dispatch code?

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    3 +++
 fs/nfsd/nfs4xdr.c   |    1 +
 fs/nfsd/nfssvc.c    |    2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

Hey Bruce-

This seems to work a little better than the patch you sent me
this morning.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8b08a1ea58fe..8899342f2eb7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4637,6 +4637,9 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	if (!i_am_nfsd())
 		return NULL;
 	rqst = kthread_data(current);
+	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
+		return NULL;
 	if (!rqst->rq_lease_breaker)
 		return NULL;
 	clp = *(rqst->rq_lease_breaker);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 758d8154a5b3..2a374231bd1c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5173,6 +5173,7 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 			__func__, svc_addr(rqstp), be32_to_cpu(rqstp->rq_xid));
 		return 0;
 	}
+	rqstp->rq_lease_breaker = NULL;
 	args->p = p;
 	args->end = rqstp->rq_arg.head[0].iov_base + rqstp->rq_arg.head[0].iov_len;
 	args->pagelist = rqstp->rq_arg.pages;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index eb07bbd565d7..2117cc70b493 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1022,8 +1022,6 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	if (nfs_request_too_big(rqstp, proc))
 		goto out_too_large;
 
-	rqstp->rq_lease_breaker = NULL;
-
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)


