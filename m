Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9485927D074
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgI2ODt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgI2ODp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:03:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA2C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:03:44 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so4927446ion.3
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d1yDBXQS21Lezp0DekytB6nItiT1WP4runGCxzB8XUg=;
        b=jMvcFuKTVhK43Di+DJQajgjIg3+yVeHRlZ/72iIn75vdk2o0AMBYF/tQfSraUBNQdM
         O8Di4VofbskiD0Oeolw49w7uno2TTr7agS4SZ5x8WzeGUgLDh0S5hNgGrneJ1mA5Iy17
         jo5v7tWWrsy13WyPgtdukviy7KS/3egdTQWp4N7kAKLA1U2r1ao1Od1GhbIlZ6afxQmW
         b2vMsW1GrY5lNXBq7azQwtGcL6bC4dNIFuVOmGAYbOn6BwNQq+gv0mL7/1Pe0jzDZJzu
         Zf7QJ2rq2z1VvZ1JFUWnU7XfYEFGbUJppVcgxiLI45JPrxY/r5/8n1ZXn25o8YIS+9IV
         yxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=d1yDBXQS21Lezp0DekytB6nItiT1WP4runGCxzB8XUg=;
        b=Ef1oSBZ7OZ/BvqHdRodkhZ3rFbGdtfWNjBWjzaEZDhfgY3wJCn33IN5JEN+h4G6Vw5
         cVdqejmy6FdjjV1DsmgYdbT2JjKyTlZ2eYPf7IzUYEtSmPthjg/7NcNxwSBzm0TuSw2r
         XLdJRaS4ZWWVLDVlycwstFM+Lh89xhtEjlj4FEdyPcKHmND/MvA+4CsS8fgb3XSiFx5P
         U7GmBR0xs3/+ImPqFjuSuwPeWeQ8qNqwXRWyx0SGSu6lsZpYkszeynmyeKuya9Xx3isy
         zfwkklDcw2lGOcPLtOlXaP7XnPn83KZLRLM3cQRZ8L/zCAMATtvyxAQhHiUGdzIcWKxJ
         9DxA==
X-Gm-Message-State: AOAM53248xtW+VjoSl/6SUo0PvBmLKdXAgd/McMKQTSIr0nwI8yL6mB7
        9saFTWcvy9vQ3QQstT8fxnI=
X-Google-Smtp-Source: ABdhPJxWkmUmrQWTeVsQ0u+RBAhv8SbGqvmU/pK0cNZOoseIEzn9c/oZ47L9bp6kd93wqOzi7pBBWw==
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr2589642ioq.182.1601388224151;
        Tue, 29 Sep 2020 07:03:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o12sm2423353ilh.49.2020.09.29.07.03.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:03:43 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE3grb026415;
        Tue, 29 Sep 2020 14:03:42 GMT
Subject: [PATCH v2 01/11] nfsd: rq_lease_breaker cleanup
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:03:42 -0400
Message-ID: <160138822239.2558.8296960298766443554.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
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
---
 fs/nfsd/nfs4state.c |    3 ++-
 fs/nfsd/nfssvc.c    |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 767dc1b27e91..603c0a227a64 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4601,7 +4601,8 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	if (!i_am_nfsd())
 		return NULL;
 	rqst = kthread_data(current);
-	if (!rqst->rq_lease_breaker)
+	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
 		return NULL;
 	clp = *(rqst->rq_lease_breaker);
 	return dl->dl_stid.sc_client == clp;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f7f6473578af..f6bc94cab9da 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1016,7 +1016,6 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		*statp = rpc_garbage_args;
 		return 1;
 	}
-	rqstp->rq_lease_breaker = NULL;
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)


