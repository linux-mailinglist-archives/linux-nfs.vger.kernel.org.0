Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB22C15C3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgKWUIU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgKWUIT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:19 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1AAC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:19 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i199so4786325qke.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uSaKTNGyVvz9qB9EnCPC7QEhGTyah1g1SJV8G5WXcWA=;
        b=e55K4dDdIPd8FXzGlQnaMKgAhXeSs9zRPRNNVSbmVA4VkxR6uqSzMDQcg66BFqrEpP
         w5PsZ1nGzi+RnccHfKacKAsXQ5bdN+hOHU1XUTcvY7X4+sDQVwt51Ix7hE/cAVXo3M5J
         x6fzJr5gbpRPUhxhLycCA+A544QeIZ3jMf9W/ECNs8tRMTl7rCYeKoar9Ex8tXrgqdVk
         uRBtbfETsLTjYz1/bmqCVCf0UO7FpLBO/a4Exklqj2wRKSbGIs8ADfvTPRGLFbJu93FK
         d3ur6EBRK+NCgZj6bml3Y9lCnkzVx4CHpu3MPsHNiBYe6X4WYeimz05Om7mZJYF73NaG
         mcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=uSaKTNGyVvz9qB9EnCPC7QEhGTyah1g1SJV8G5WXcWA=;
        b=fb3OQWb/TMg3h6zoVytdMRPFnISZw7Qdz6ZLCrDklxjKYcXShScSp4mvxwJIWuSHlK
         i+3wMcUamOh5Xxi4EJUzNkmdz4imjUf2ZQPxa91laEJb5pWawBOg1C1ee7teCGog2GKW
         y/l5A8OmZ7NH+O8EuTQ3rjWyPs0B69YK5UInaKxJwLi+JEFV9rI3+I6ms/8auDY1ZzRx
         Soin6WRBX97pHt3TQmwo2Zyv6klJpNBYpBbaDmhVa8PlLueOg38zQG5Q2Gz8Myq8SGC+
         pzSA6ofCLHB56phpUnf6pmjtj7FgymWikpSWoeDPwlnavLHbSGrJKOc4cGMuhTmp64F3
         9yIg==
X-Gm-Message-State: AOAM531YKCnjRAikfL5iE3Ves0ZlzCdcgIz+Tnz3xao9mw5UOuMG6Zb5
        iPrOsPpAbc+pEKS+Vf/3ZAPj59qOrCU=
X-Google-Smtp-Source: ABdhPJxOMmdkK4aKblvhVlY9uEwLMe1zAQ9vd1nP3OzZg/fLxr/ayTTiqHeo4SwSHmUQiatZ5WTXeQ==
X-Received: by 2002:a05:620a:790:: with SMTP id 16mr1249832qka.169.1606162098675;
        Mon, 23 Nov 2020 12:08:18 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k4sm10316105qtp.5.2020.11.23.12.08.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:18 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8GWC010423
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:16 GMT
Subject: [PATCH v3 49/85] NFSD: Replace READ* macros in
 nfsd4_decode_setclientid_confirm()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:16 -0500
Message-ID: <160616209692.51996.9637955274935350198.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 550d38ee926d..6a6659e07eec 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1355,16 +1355,15 @@ nfsd4_decode_setclientid(struct nfsd4_compoundargs *argp, struct nfsd4_setclient
 static __be32
 nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_setclientid_confirm *scd_c)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	READ_BUF(8 + NFS4_VERIFIER_SIZE);
-	COPYMEM(&scd_c->sc_clientid, 8);
-	COPYMEM(&scd_c->sc_confirm, NFS4_VERIFIER_SIZE);
-
-	DECODE_TAIL;
+	status = nfsd4_decode_clientid4(argp, &scd_c->sc_clientid);
+	if (status)
+		return status;
+	return nfsd4_decode_verifier4(argp, &scd_c->sc_confirm);
 }
 
 /* Also used for NVERIFY */


