Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1A2C8FD7
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbgK3VUa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgK3VUa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 16:20:30 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A34C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 13:19:50 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so6370347qvb.3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 13:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WUuu3niy0a46vL6lKIp4jenyi6JzxW4d95oFEmoMdi8=;
        b=Fo6gus4T5MGxgY1lMOk24ezZlElX7hW6xa6y85v5jbEJa30nSeKRLRScVk5auSotva
         X1QcV86Z7BCTTLArRtR98D/jjzlC4iA/ChJTuauursXs7YvkNXlpIDrQKNTp7YI0tJR4
         x9WFauFsRFkfOyIpLp1oj9QC4M53BLl1rNg754G/VguDDmrNlq65dVLmx6wHTL8dJcdB
         Xc3w5wZmX1s7pyfaCHbIQKdH8VAIPPS05bpR1+K12Nt10TGG43TB1cGu9d/Ve+CBEC26
         re93dfeJMG4ZosnNhfxHPzimoxfS68GzsYLJ/HujIRbohh63jotC+MSx4ngNZhwhkt1j
         EEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WUuu3niy0a46vL6lKIp4jenyi6JzxW4d95oFEmoMdi8=;
        b=BOU+xNihKgtbZSl7gdmvQQxBvsDzJLrCtJKvnTi9wdnGutpPL2HOLPX3pXuzzHFbPY
         y7oLriVQK9zdycJYY1ap6StDfBluqfBJ6f2i8kXd2FPrjkb3vs/wAZ1mFpmY2WZFssJq
         XFCPolsElHipJvtlfzAhRbs6pnLhJtsddMSK0QChdfM0mItqHoGB3snLXuX4Lkg9ZPiN
         i72iS+AzGSfhRMljqBDWaGzzAgE9Qa2yJf/rrkN1NPvc1OC3RWdvvH1vP3h3w+gj4ui7
         MF56UWDQ3RQtypekY3ZBWtIN2reLep3yXjiOo6AdSUCm3OoSMA+2zidGArZIHQ8tLOj6
         4Nmw==
X-Gm-Message-State: AOAM5320nFwDq4ZcqhkilLdlGchyrF2JWrbghIP2LpjMqm8WX6hYP6xO
        0WDSOd1jT98POevBKzooEV4lK3Y6hys=
X-Google-Smtp-Source: ABdhPJyfMlUwOxKo3oXZbsGPJF78EZ7ExwmIbILoK3TCFZpggTvqinUbxBYwBfUhyUehM3dd9rOp4Q==
X-Received: by 2002:a0c:b79f:: with SMTP id l31mr24848880qve.32.1606771189299;
        Mon, 30 Nov 2020 13:19:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v15sm16782511qto.74.2020.11.30.13.19.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:19:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AULJlex029492
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 21:19:47 GMT
Subject: [PATCH v1] NFSD: Fix sparse warning in nfs4proc.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 30 Nov 2020 16:19:47 -0500
Message-ID: <160677118711.395023.5957938985402771446.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

linux/fs/nfsd/nfs4proc.c:1542:24: warning: incorrect type in assignment (different base types)
linux/fs/nfsd/nfs4proc.c:1542:24:    expected restricted __be32 [assigned] [usertype] status
linux/fs/nfsd/nfs4proc.c:1542:24:    got int

Clean-up: The dup_copy_fields() function returns only zero, so make
it return void for now, and get rid of the return code check.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 73e717609213..4727b7f03c5b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1425,7 +1425,7 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 	return status;
 }
 
-static int dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
+static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 {
 	dst->cp_src_pos = src->cp_src_pos;
 	dst->cp_dst_pos = src->cp_dst_pos;
@@ -1444,8 +1444,6 @@ static int dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
 	memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
 	dst->ss_mnt = src->ss_mnt;
-
-	return 0;
 }
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
@@ -1539,9 +1537,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		refcount_set(&async_copy->refcount, 1);
 		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid,
 			sizeof(copy->cp_stateid));
-		status = dup_copy_fields(copy, async_copy);
-		if (status)
-			goto out_err;
+		dup_copy_fields(copy, async_copy);
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
 		if (IS_ERR(async_copy->copy_task))


