Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E421A2B1E2E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKMPGo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKMPGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:43 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1838C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:43 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so3254317qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dI9sjCAsPMN8X6MICf+BD61shIb6T5TTy7buwadvfg4=;
        b=J80gk3LjpBMHMKxomGFhEMQJWR4QBQO+uVQgynizqSr2lghn68XaJZhK1SQKh5gmYv
         7w5Ett2Sc1+sIEK3d7S6vxy10Wivso/ejvbha4tqXq+2oCCHBZkwwyQ3dK9Vra3BE/DM
         FXKqnHaVtYg7znbSI5sBrJUm3jq26WzzgrPfB4bCeQOp7LRe8z6bz21RI/vihP1EsYaj
         RaF9GKizb+48AHvinp++Yqf3Ei51ikAPz7U4S6mvibS1E54ZfBNFn5VVeRSOICQRTyuG
         XWb5zshvZq/N4VpSRiTSHSYQEAJB6zCGFGj/TVPz/UtSVqX7AZ5ce8RfwErTT1zwZY3X
         AGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dI9sjCAsPMN8X6MICf+BD61shIb6T5TTy7buwadvfg4=;
        b=bLU4Nbcn8pyPNRMgY1sWcB9910J7wu+zgA8HMc3zuWJSLTPinu2KFdMvVDzlzphEUQ
         uYglrvVoQjoVhwycVRyLfS5tvZj/Rvl+2032srCMGMPqyvxTJpluVWiMEorO7OF00lML
         Srk4ulAF4R45MZ2L8Uwv4CIrYT0cC3vkzpa4mk1Xa3FRblHsOPJBtP0mVo726+wqkB5g
         u3yQNJ2zHkgiJHi346++A6ew7LKYOFG9/3edU4LFIDmy8CRrOjPZppERvRxeiLx0DIS+
         mlES3j0KzvdoUxXkPQmq7BHeyvXTSqAVmSKAF70gRF0EDgrHoCdUQfYOEx7dAhdaNdQN
         s3YA==
X-Gm-Message-State: AOAM532/QvOoKnYZFzZ6akhBypJwBL7ZXH9Xm7zAJqnETZAoddSQLyuo
        iW2NVWwVYPNevInnRcY+bjMtJTpOVJE=
X-Google-Smtp-Source: ABdhPJx5KWnE2K6pdocfWwf5d50Z9Iuh5RmVvHkthoKSh+tqJhrm/FGeDjB2MyYo3LKrKcE86YbaqQ==
X-Received: by 2002:ac8:a86:: with SMTP id d6mr2383474qti.22.1605280002610;
        Fri, 13 Nov 2020 07:06:42 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r16sm6348986qta.14.2020.11.13.07.06.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:42 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6eHp000316
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:40 GMT
Subject: [PATCH v1 49/61] NFSD: Replace READ* macros in
 nfsd4_decode_sequence()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:40 -0500
Message-ID: <160528000096.6186.9250319500236956010.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9585cb9febbc..7b4f7f8c44da 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1698,22 +1698,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32
-nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
-		      struct nfsd4_sequence *seq)
-{
-	DECODE_HEAD;
-
-	READ_BUF(NFS4_MAX_SESSIONID_LEN + 16);
-	COPYMEM(seq->sessionid.data, NFS4_MAX_SESSIONID_LEN);
-	seq->seqid = be32_to_cpup(p++);
-	seq->slotid = be32_to_cpup(p++);
-	seq->maxslots = be32_to_cpup(p++);
-	seq->cachethis = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_stateid *test_stateid)
 {
@@ -1949,6 +1933,30 @@ nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
 	return nfserr_bad_xdr;
 }
 
+static __be32
+nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
+		      struct nfsd4_sequence *seq)
+{
+	__be32 *p, status;
+
+	status = nfsd4_decode_sessionid(argp, &seq->sessionid);
+	if (status)
+		goto out;
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32) * 4);
+	if (!p)
+		goto xdr_error;
+	seq->seqid = be32_to_cpup(p++);
+	seq->slotid = be32_to_cpup(p++);
+	seq->maxslots = be32_to_cpup(p++);
+	seq->cachethis = be32_to_cpup(p++);
+
+	status = nfs_ok;
+out:
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


