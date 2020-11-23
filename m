Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386A82C1601
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbgKWUKX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732155AbgKWUKU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:20 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F8C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:20 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so14390283qtp.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hltaQvsj5v3TN21OXjnwqowVnB5dD/Ti3b5+ugkTcwM=;
        b=YD/cF8Sv7VvdPtrnwfa6Jg34DMGY+LgOQEVm/tD3TeZTCP8Y1yeMxwv8dpY1YqPj0D
         z4tp+wtqCIwO8q6HfnqOx4+VqWMAguQW7JZjZDjskAoemO7YZxEswNtIqx5fG+cY6FuD
         fBAZFpGF39sdu+9SZLSDs/D3qps0hjar+6Mhj/UqYKHIP8qrGv1PJb7YxI+4h7hOp217
         Frw87DmtbTFTfqBf72qtVKDJ5opP8RX/Nf5DQf60mClBa+r1ueT3lrmEVrMO7aseWF34
         4QXr39f5BHHknv5PfjUBP2e8wbRYemRR7C6ld4gCZMa8UVhBprL94z0w5JWghM1twenQ
         U4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hltaQvsj5v3TN21OXjnwqowVnB5dD/Ti3b5+ugkTcwM=;
        b=i5xHz4ejCUT3G+h3Xxeg3Jc5aTOJTkSCBhfZ9Mf+vIJAWFtcOiH/qucFF/e40Z7VTc
         62fHn5Rg749wtlhrT9fH/IvAPhjx9orD3lYrd3KInZT9bKwfWxU3272hO6Y8UBi5YLIC
         XXNbvnnLsFr1oXokDPKyUE9Uswa+CPEX7odslx+MzwjFPeqFmH8PXL/fYEvenuOUxjLq
         Xn9Sz1mviVTPcKih3a7wtmYuGKtPl8euk0krUeOTALcjgT5rldOyk5EgBurS12DUR5tG
         Dzp3KB321j5SMe5N2hh9pNBRTHeuLLEF6J6dIUepnw+trDlCKeFqE/Atj9uFJ0Frr677
         /pKQ==
X-Gm-Message-State: AOAM531dGh8CChT3GMMnT0YOK7239CRDObE7FquJq7wxzKpZKB2wAUig
        MDbdaocOAhm3lhDfpsAyyxiGCSVM7J4=
X-Google-Smtp-Source: ABdhPJzA/RTmuRQTLPoLRtGXofLLFp69iQR+GanAqLxFRHg0xadgdBpIaNO9VZYGOggX0SXj7qVOsA==
X-Received: by 2002:ac8:67da:: with SMTP id r26mr899394qtp.101.1606162219893;
        Mon, 23 Nov 2020 12:10:19 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t2sm5477056qtr.24.2020.11.23.12.10.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:19 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKAIfn010500
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:18 GMT
Subject: [PATCH v3 72/85] NFSD: Replace READ* macros in
 nfsd4_decode_reclaim_complete()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:18 -0500
Message-ID: <160616221830.51996.17374559850572472217.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8225e3994204..7e54cf0d4147 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1738,16 +1738,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, struct nfsd4_reclaim_complete *rc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	rc->rca_one_fs = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
@@ -1904,6 +1894,14 @@ static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_clientid4(argp, &dc->clientid);
 }
 
+static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp,
+					    struct nfsd4_reclaim_complete *rc)
+{
+	if (xdr_stream_decode_bool(argp->xdr, &rc->rca_one_fs) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


