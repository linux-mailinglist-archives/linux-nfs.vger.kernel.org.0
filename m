Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B438278F3B
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgIYRAB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgIYRAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 13:00:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D597C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y2so3055581ila.0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uZ/CQ4M1aMHrxw4j9JXxadjCM4BZldeBJtMRnoTtIb0=;
        b=YzMxdg0Wc40pwIkn3TO841clAu+A5Pe/RKzCbOmjhBcZwRoAm+ADWl4giv+zI+ldhf
         P/Syl7CYnm/zO4DyO5zccsbcGYuJlnAJB7ENuFEVDCgno12bHmt+tyEtthTpfiG+RvB3
         l5WSZUTVkW5CDdfcEiSUbK+EqQ+KgeV+fXQXsyNCfX6WPE1yfi9GyhJLc6BdOOazWsTm
         IborB/lNAIkzSOrpHj4izrxmMxoScSQJcqYtvT9mMk8DDVcpRwF56LPGx0mzezVlJfD4
         gVsiDmSQLd1teQFJfyRDGnm3XPTMQCyIttr3vSUJD9U02SoLbIvwChc8aCuQ2LbikJQX
         10wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=uZ/CQ4M1aMHrxw4j9JXxadjCM4BZldeBJtMRnoTtIb0=;
        b=VvWRFjnuHXXdZl+6i7cVevqO3SfP8HAFViqBt6uv7K6NhDhZZKgKaJwXgJ06ba0QXi
         d0tn6G/YBE/EwmZqyTNVxI2TXWxreeF2Udv3MSOq7tnWiXSuiMXLXZgh4UocUK/lGNTt
         er2NZtTAwnOJ4FozFxwm9blcas1/JLwa6uiaCTounc0nXvkXxW9ax9F2sOwPeslovjXG
         mE8veNINE9NhKH4QEt/INpNv+QMpNg2gfh7HMfKEA7FGVC59nK6Cr5vF5ppwiikQMLDS
         lJWfYis61hLRQaTtcyJ3669m2kDnJSYXK7JGeD0jUEQIAM9Zuwr5KyNmyej4NIWWY/Th
         I5zg==
X-Gm-Message-State: AOAM532JzNzX+CqBBZ9F5Gy78AJteTube5dUkEkboeFnX6cmmTLhHsuD
        0AmJ2Yi7qvPTz//nWTvCjeoBDDFLAlYPjA==
X-Google-Smtp-Source: ABdhPJx1YokNG+S2uo9kQYBToheU5OL6BXhIFvB5OhspsTGxy89KaYRkgEv3Sh7nnmlxpjRVOYPViQ==
X-Received: by 2002:a05:6e02:cc4:: with SMTP id c4mr966867ilj.152.1601053200421;
        Fri, 25 Sep 2020 10:00:00 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z15sm1705890ilb.73.2020.09.25.09.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:59:59 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PGxwIJ014511;
        Fri, 25 Sep 2020 16:59:58 GMT
Subject: [PATCH 1/9] nfsd: rq_lease_breaker cleanup
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:59:58 -0400
Message-ID: <160105319858.19706.8351588171501305958.stgit@klimt.1015granger.net>
In-Reply-To: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
References: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfssvc.c    |    1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c09a2a4281ec..d9325dea0b74 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4596,6 +4596,9 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 
 	if (!i_am_nfsd())
 		return NULL;
+	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
+		return NULL;
 	rqst = kthread_data(current);
 	if (!rqst->rq_lease_breaker)
 		return NULL;
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


