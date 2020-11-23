Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9402C15CD
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgKWUIh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgKWUIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:35 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10DFC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:35 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id u23so9455396qvf.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nAoxune6BpDAHqUZufK7mLh7Nw52CQ4hI3jblqiJH+w=;
        b=qoqZZN/xkcs0z+JRnAMTNFWqJjcK3YX9tbdHrQZwp3CrVk2SUWpLfI+Yw/Kj+Cy1Hk
         r/0Qk286YKXo90JYQNm7kFTONFq8n36fji9AFSwEmdQP8Il1UboRNCFF5Ue6Yeb1MZS8
         pQgiG2ESXNLI5k8dydt7Fi0WtkOpGDLfVXRa3PbFqMqLAxZvR3FPbLaRQYcXT4R4e9CV
         2Hm+Jvri6rg74LgcdqJ4bq+91OA+s6VflmoKEgShi+24KJTXgWZwkg8qgm+7NOX6BaRt
         0AkUnaMdL9/dOshxCVS+duEbw7JQrXDTt4RFU4+kS70L8tIntC5jx3jc6Z+3K4VuoUnH
         wpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nAoxune6BpDAHqUZufK7mLh7Nw52CQ4hI3jblqiJH+w=;
        b=jkO3PLBimUe2QAqORvjZXkpjAKzaLtpP1gxW/opudCc4buRcMGpkFamR4v8sD6i6uh
         womnQrdzHaIdAkhv5HiIP/x6SSUnJdvyKA0/qkG4Z/KUEktS33jZ6VlH3htbqqnHgzCk
         cQIWPj7/jva/wFa78tX2ZKPhmj5FHfiF8w8QStCxFwIxQEJb3eUWqD51a0d0IKIonFvV
         Q7tyHKl+SqqF5b2gB15kSqzVY3g5xJigLViA/pvkpTTCCKaoftRmBL3KaKgN3riYtxBA
         bujJ1+VNYnxrtJFuU/dYhn6RrfZlUVcA4xafbeEx6R12fjLQu56qMxQZ1Irc0VUBtpKu
         QzNw==
X-Gm-Message-State: AOAM533J5vHyQSH4TKnFXUNoDwU8WZ3vmqGtpR3TKS4CDPnOyLC078yQ
        lsoqnvOS6Ls84MMhzm/CgohTTB/7PXU=
X-Google-Smtp-Source: ABdhPJyIA9CsU2Ji9yf7Tu05Il62ASIjkuXbxEKtG1Q5tOT1go5IYDRGiFwzUABlS+CCMd1hN4tZtQ==
X-Received: by 2002:a05:6214:a69:: with SMTP id ef9mr1170672qvb.50.1606162114458;
        Mon, 23 Nov 2020 12:08:34 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q20sm10082788qtn.80.2020.11.23.12.08.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:33 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8Wqs010432
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:32 GMT
Subject: [PATCH v3 52/85] NFSD: Replace READ* macros in
 nfsd4_decode_release_lockowner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:32 -0500
Message-ID: <160616211278.51996.10005952551727082844.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 226c37957556..0a2474542309 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1418,20 +1418,20 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 static __be32
 nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_release_lockowner *rlockowner)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	if (argp->minorversion >= 1)
 		return nfserr_notsupp;
 
-	READ_BUF(12);
-	COPYMEM(&rlockowner->rl_clientid, sizeof(clientid_t));
-	rlockowner->rl_owner.len = be32_to_cpup(p++);
-	READ_BUF(rlockowner->rl_owner.len);
-	READMEM(rlockowner->rl_owner.data, rlockowner->rl_owner.len);
+	status = nfsd4_decode_state_owner4(argp, &rlockowner->rl_clientid,
+					   &rlockowner->rl_owner);
+	if (status)
+		return status;
 
 	if (argp->minorversion && !zero_clientid(&rlockowner->rl_clientid))
 		return nfserr_inval;
-	DECODE_TAIL;
+
+	return nfs_ok;
 }
 
 static __be32


