Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05062BB737
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgKTUgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbgKTUgH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:07 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D6C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:07 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so8074922qtb.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nIwximQeRM9GZSSWJcNjVeNCPiTwgf/lgj+uZBeuy6s=;
        b=EUvHBBF5B0v7cgjKbgshr4OOzHPvmd928h2qM2BQC8T8C2udj1p/I6fyhluU/OMent
         HPYHbwqiPazGd2OGzbejU/jHXtIJcCeSF5kpedbewXEcnoE3dztBwAkA+pkDr5O5gMET
         oAIlllv1A0MqL3UwdbHSV+M5KP4lzVWD5G0uVtyP32KIirczg7lrs0q6xUfJ6hX4Sihc
         OgT5y+nbVNDLmwQf5xdpc2HtnIr/oHPoFw+RlqSchO/9/ZOtIxilHAJ9xH1taH4uX6rX
         F5DkotOdcHAgxm42SIb63TDpsx6ZRuO7xPWzznpwhBkuhM2dAmERU0ln8Gjepn24PJs/
         osaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nIwximQeRM9GZSSWJcNjVeNCPiTwgf/lgj+uZBeuy6s=;
        b=knSdQ74GNaquBbZccE9kKeKQIPQAFGTaQs8B/q6prhb9pICt0Z/ij4ccRBoGWWeX0e
         j6KFOWeQ3i+CjWa16srwMQZ3pbIa2DvlbV2j/JoMLT85Q65z+YAL248GIkI6rho1avur
         cyzCuCA7OqH2/9s7cGenPu14QF0LOBGsQG+HrTjCq+PBV2x40fF8Kc75BkdvIpjEmQAG
         YbohvC2lmRDVwIEGTQrrOuNOlUSWSMdHgFqS3+t/kvsyXYSphwlK3VRuwYNky5xfIw/E
         2ELVTtq8L2sxyU83Ho5IZMU/z8dT8/kFb9FXlbDzDMsENFsXE3tbOFYizZJRIeEfBjxz
         q6WQ==
X-Gm-Message-State: AOAM533NuB7MPC/SiStaXgCHB2BOyzGAV6wd7LVugQQJUAyAgqSs9Ndh
        qGSiBlRskgIUjLG8EuRswK45i2ORVXw=
X-Google-Smtp-Source: ABdhPJxXzejPuI8If9SjMOV5OJeRAPTXuXa3IDKM7VWirGAC32F2b/M3UHdYGtfqwkmxW2LZ5O7X6Q==
X-Received: by 2002:ac8:1c28:: with SMTP id a37mr2620519qtk.356.1605904566248;
        Fri, 20 Nov 2020 12:36:06 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j63sm2659789qke.67.2020.11.20.12.36.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:05 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKa4PU029280
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:04 GMT
Subject: [PATCH v2 026/118] NFSD: Replace READ* macros in nfsd4_decode_lock()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:04 -0500
Message-ID: <160590456454.1340.12535304431985619714.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 94219ceb2ea2..83a8f872ae9a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -825,21 +825,17 @@ nfsd4_decode_locker4(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 static __be32
 nfsd4_decode_lock(struct nfsd4_compoundargs *argp, struct nfsd4_lock *lock)
 {
-	DECODE_HEAD;
-
-	/*
-	* type, reclaim(boolean), offset, length, new_lock_owner(boolean)
-	*/
-	READ_BUF(28);
-	lock->lk_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &lock->lk_type) < 0)
+		return nfserr_bad_xdr;
 	if ((lock->lk_type < NFS4_READ_LT) || (lock->lk_type > NFS4_WRITEW_LT))
-		goto xdr_error;
-	lock->lk_reclaim = be32_to_cpup(p++);
-	p = xdr_decode_hyper(p, &lock->lk_offset);
-	p = xdr_decode_hyper(p, &lock->lk_length);
-	status = nfsd4_decode_locker4(argp, lock);
-
-	DECODE_TAIL;
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_bool(argp->xdr, &lock->lk_reclaim) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lock->lk_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lock->lk_length) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_locker4(argp, lock);
 }
 
 static __be32


