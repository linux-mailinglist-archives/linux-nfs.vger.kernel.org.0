Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A09280ABF
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgJAXA2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbgJAXAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 19:00:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F4C0613E2
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 16:00:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v123so7798336qkd.9
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JXbHXUtV11JMQr/XtVPPKc1StT+HAkVWoDref1f9ArQ=;
        b=Q7fOXd3GefUrEQUvDpHaG4gKEy83aatM1Ta/DgOVWm6mPYehvVt20IKKKyq16K8SPb
         LJT8pOTmW1egNZOvLKnhjYMshzNracoOraCPVm0Kewcmjn4KzbTT7Vt9CPNA6wdN9t/1
         /KC8AEae7OOFjGwUPnS4XEwrK1yrqAlfXF8DEPR7pH/6p9iswuX6VrS1EV0wD08kceAY
         JXDr95vUUi4/myzdaVs3zNtMYJm3GqvQsu7B7IiU3hAM5wxVAFLVZsnS15M0X9K2Ln0m
         KhFweGQMwQcIzuIuvfcaNlzR7quo3SxDjC5tdpNKp9IHCk7VVT447zixZkFYDqGT6P4O
         jJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JXbHXUtV11JMQr/XtVPPKc1StT+HAkVWoDref1f9ArQ=;
        b=fUtm8kdT5iajUPjXGdoW/JGV9XbCgSR5jPZ0o1dJoPqhDsdP4q1ByW6RAWLoMp0iPg
         VROO+OcKirSTrjOIPgq4fuhztXBz+Pwim3ey92/OV1Mfs+Vhqg/4y6/6wM/3GgkPs2n3
         MTIk7QHCS+Vl0An7gXU5DpJLpyZOTwV8Mxux0qdRDN0PPJbeSp24U6BzOHGoQyjPoBsO
         aceQmT3WevvrmXjHnnJKNs9WqYBNPQWRigHZCQQz+wlQBwgb24J+d7ugpbSuaasD0ibo
         nuzMKmHi1hV2V8O23jiwvg48FF7GTI+hvKNH0hogpQWwshizj6ETPvzCbKiFel9lnPsC
         cc6A==
X-Gm-Message-State: AOAM532SMMgdrdhaPIXsyAjlN6gAuJS/8wP519L/P9FTscEQVRiGZjBP
        EVBp9XRjqSf4U5dNe9MwDC+e5yLVTOJb8g==
X-Google-Smtp-Source: ABdhPJy5FIDH0YHF6qls8BA0+tEwer/fkpg+KUoEHAzJTR5FFbmOIaq1Z4Vc6zD5DOeHRSeHXMY7nA==
X-Received: by 2002:a05:620a:12f4:: with SMTP id f20mr9940079qkl.312.1601593201682;
        Thu, 01 Oct 2020 16:00:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s5sm8469726qtj.25.2020.10.01.16.00.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 16:00:01 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091N003p032604;
        Thu, 1 Oct 2020 23:00:00 GMT
Subject: [PATCH v3 14/15] NFSD: Map nfserr_wrongsec outside of nfsd_dispatch
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 19:00:00 -0400
Message-ID: <160159319999.79253.17056285986114769297.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Handle this NFS version-specific mapping in the only
place where nfserr_wrongsec is generated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c |    2 +-
 fs/nfsd/nfssvc.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index cb777fe82988..21e404e7cb68 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1002,7 +1002,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
-	return nfserr_wrongsec;
+	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
 }
 
 /*
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 4aa8db879ca2..beb3875241cb 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -964,8 +964,6 @@ static __be32 map_new_errors(u32 vers, __be32 nfserr)
 {
 	if (nfserr == nfserr_jukebox && vers == 2)
 		return nfserr_dropit;
-	if (nfserr == nfserr_wrongsec && vers < 4)
-		return nfserr_acces;
 	return nfserr;
 }
 


