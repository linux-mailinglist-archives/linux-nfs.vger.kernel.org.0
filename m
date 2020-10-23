Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A113297184
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Oct 2020 16:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750707AbgJWOlP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Oct 2020 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750667AbgJWOlP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Oct 2020 10:41:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D14C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 07:41:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b11so778680qvr.9
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FOFiJAPriTF8XxA58W/09u8AodLsEcvQW4mAYsReqyQ=;
        b=N7ArN6I7b4SgWS14iVvLAKvubp7BurOqzyd1PROcvhQlk1CAiP6oAEB6UO0U4Shdv+
         Xkh4zpGlTTOYGHFtEGwFBOTSLWP8fAK6c2YpBs+7jBg0CD/Wyhhtu0h9PJiUJbHMnbaN
         7UC33eWo2aMJy0up49voEsEGTW0Qd8K8zYFLV0JnU+WbiNWs/pdmMHpQDOzEgFha9rah
         RAiO2ZvyhEG1kEOWyJQJGqUrAKa4Oehsmt1CrdRRMV1LoN6kTqFauy2/ROQGHpJ16hQk
         RdTnRLEP//I0RRYopnY9ZDsFcrx4yKHNDOxwiLUAwNIvce0I3cL9zegvH+SpWkwlC2gi
         h6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FOFiJAPriTF8XxA58W/09u8AodLsEcvQW4mAYsReqyQ=;
        b=AgSpOroBQgGA7u972Q7q6be8GpmczJYsp2KpyfgP2D6QdWUOI1fTpHGvWGC6XX0Ps/
         JNK461mDV0pEqndZwo0OLjv4DzUBmL3cKUo9YamnIzNQQoVPJM+IKPkOxiVP5YmKgX96
         yimxzNMuiHZYgeFwIEeHgjv4gB+V4gyCZH4Zh8frKbRSM//cLM4yYcfgzcXgAYLWMogm
         b5V9lmFAZ7wYDwl3R9UxSeBiei3yLl183nJQIFyviqa0Cux8RdHO1fW4INxUFFfMCOvu
         6rTyLYcgNgPoh03H7C/RKtgaRY9gOy2XZVk1QyKfEtIVR6xqCo8RW8/sGPFSRNOx+JGu
         D6hQ==
X-Gm-Message-State: AOAM530Kc25qFtFI6bJY3MyvjWq2mqm58u6tAnocVuAQXgo7Ql+vj8YI
        rysxHmJ6TrZ/vk9NE38L4s7lePaX8W0=
X-Google-Smtp-Source: ABdhPJxnIEZo3GMSqYUb1ePdfUf4Jtaag4jXtmnxraOWeLtBHVVd5ytlwqLXBFLTci9AimJEubTvSw==
X-Received: by 2002:ad4:59cf:: with SMTP id el15mr2809634qvb.17.1603464074217;
        Fri, 23 Oct 2020 07:41:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id u11sm995233qtk.61.2020.10.23.07.41.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 07:41:13 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09NEfCXW004146;
        Fri, 23 Oct 2020 14:41:12 GMT
Subject: [PATCH] NFSD: MKNOD should return NFSERR_BADTYPE instead of
 NFSERR_INVAL
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Oct 2020 10:41:12 -0400
Message-ID: <160346407256.79082.7549570817445542217.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A late paragraph of RFC 1813 Section 3.3.11 states:

| ... if the server does not support the target type or the
| target type is illegal, the error, NFS3ERR_BADTYPE, should
| be returned. Note that NF3REG, NF3DIR, and NF3LNK are
| illegal types for MKNOD.

The Linux NFS server incorrectly returns NFSERR_INVAL in these
cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 14468613d150..a633044b0dc1 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -316,10 +316,6 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 
-	if (argp->ftype == 0 || argp->ftype >= NF3BAD) {
-		resp->status = nfserr_inval;
-		goto out;
-	}
 	if (argp->ftype == NF3CHR || argp->ftype == NF3BLK) {
 		rdev = MKDEV(argp->major, argp->minor);
 		if (MAJOR(rdev) != argp->major ||
@@ -328,7 +324,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 			goto out;
 		}
 	} else if (argp->ftype != NF3SOCK && argp->ftype != NF3FIFO) {
-		resp->status = nfserr_inval;
+		resp->status = nfserr_badtype;
 		goto out;
 	}
 


