Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34CD280A9A
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgJAW64 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW64 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:58:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F545C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:58:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j22so671041qtj.8
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d1yDBXQS21Lezp0DekytB6nItiT1WP4runGCxzB8XUg=;
        b=kjkym6tc6iY3fKsr1xF7bn6lxzeELJ1tGeu082/CYMFHZbNbxclRRkSl63O/8vqver
         cuDBw+4qCq8TT8caJmrbIX2jZzrSt8LBRHGVuyOubofGmg8G3/4DXClB/60DA01+NCMX
         lQIKYUh8OKmrlr33Gi6jWPImbF+62EBYFebTCXffFYh3e0Kiysai0r3yMTI1Gx0hcl+K
         s1II6NnM07yTjw9/lLsRM1gbgmvx06xZRfaeJsWTN7cu0ttngqOOHfsP96bFJW/DCJN3
         GvRfFms1qNeh3EQeX+XVNt0HWaccH6AM51YH9hQAAj8aXs+SDAWR85fbwyaaolALXN+l
         ojSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=d1yDBXQS21Lezp0DekytB6nItiT1WP4runGCxzB8XUg=;
        b=tz2nMlq+SYSSPGtt+VPndK8ONtDAJqJ1/QCeDr/LTbGJPAvshVBtnFiczNEBOrMtVw
         pECpTW29hA9yRR69Y7IslQ5wEQ0rUfZYbmHjWhNfUKj9OfIbZyAmL8/icNJhc/TONcQY
         A1wHKtS5SqJ/QcsYlu6tYEHcVhgPS0pBoT0+LEYl/uq2G81LZbU5/RfTfmoVsrp41dyU
         T/+dPIMR+evrvcl1fHBPNMovU77JhAzuYkX0TbGqT8oWFaTVkYB2m+UaWU/eOSKGb7l7
         q/rfnadXrbBo7GzVXG2TpgRQ9mxzd3FJ07enGFYD2X1nsmdQcIuPZJ0jwsgzwsEHVuLr
         nTWA==
X-Gm-Message-State: AOAM532oAmNAZSREmUWvxd/eG0+B7PfO3f5lDRaG/VhWXV4Mq9+mLp/I
        dIKVUdf1L55aK2rEDengxuf8EmGUAEZ6qw==
X-Google-Smtp-Source: ABdhPJwmy/gKJo2uz4dGv98EGCTzMVEvNA5mYqJTCay2IiDBDRcksO8jsJD3hv2GUpLc8W6sJJ0GBw==
X-Received: by 2002:ac8:5c4a:: with SMTP id j10mr1844217qtj.322.1601593133460;
        Thu, 01 Oct 2020 15:58:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 206sm7724025qkk.27.2020.10.01.15.58.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:58:52 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MwpbY032565;
        Thu, 1 Oct 2020 22:58:51 GMT
Subject: [PATCH v3 01/15] nfsd: rq_lease_breaker cleanup
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:58:51 -0400
Message-ID: <160159313183.79253.5459981038625192952.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
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


