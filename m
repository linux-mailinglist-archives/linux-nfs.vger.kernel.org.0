Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA0A2C159D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgKWUFL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbgKWUFL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:11 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93695C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:10 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so18200072qkc.12
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=59G1dPFQw0SbnN96ZTNX0IHLXP/fiJbjJC2aXfhzPRs=;
        b=mrFoHYlEl95S+CT+sr5bl+CQC3eUzdbBvimi2ZiLN2Xfu98iqt9Ap/BztOgn52uOU1
         xTU9lIjbshKAER5cn7co2G95NPzZudZrlAKNDRpGZFaP222nUKKzQeZ94oq8AztRPGC1
         cZQX1/tJ7cMEGRbvMCVIzN113Hf3sOQVO6M+yl4Nu+eJGBXkzVA4VGKHISG8romexyoV
         JCJHicZUioLA+tNopDz3nzQZwuyv2tVibiYVdg1CMWsmOJsOliUyiFigahMsdEL8svqn
         TICFitqOz90wVa4HAm2fQcjdlJSnx9H84ajkP0ko2nVz1nkB1bA/0ecZg6h6nMnV2pfv
         fYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=59G1dPFQw0SbnN96ZTNX0IHLXP/fiJbjJC2aXfhzPRs=;
        b=Lu8tH1Bz6ONopnw7gruR1EYIrc0MrwFsTSlX2X7NUqDima3Hh3wSqK99tC5qCHx5dH
         PzuHd8CTJuJ58GUaMdiavmkC7E1DF462SYeJhO5TjdOLgM36XAOIJTGM1gdfMqV0I0We
         M9B8o3mHXSbNLAs+8An1FznHTAEDLp37wZwJtlgTyDXBemztP6uxkd6wTdblQ3WC7zLr
         764cIHsyJbtllk5iyTsnwu9iB00ZHC6DmQ6WDg50k4ITd0a6QNzgFYxP4mUlHv17kghc
         jP/0XvPdfiYqTc2Nb6UE6b3zsf+iPsw+0kM5fJEFIdeiJvLib1Lu2/O6idaJehBSz/nU
         /qjg==
X-Gm-Message-State: AOAM531wGVxUxBuVVwiqVUzUdJGnSsJ2WU9T+9wL2hc77Y+nURXAmKth
        1KPucC/kBVfNexTQsXPeR7/kGW2LruM=
X-Google-Smtp-Source: ABdhPJw02AQ4n4cCnjaefJm8rqDuy9etGaKVqAD7dH/sUu7pQ27QvRi96RpgUXUIQcJwA2YG6+x2ng==
X-Received: by 2002:a05:620a:2e8:: with SMTP id a8mr1322460qko.144.1606161909440;
        Mon, 23 Nov 2020 12:05:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t56sm9479411qth.27.2020.11.23.12.05.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:08 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK573F010307
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:07 GMT
Subject: [PATCH v3 13/85] NFSD: Replace READ* macros that decode the fattr4
 mode attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:07 -0500
Message-ID: <160616190770.51996.16267066264499044512.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 273d5f849df8..597da7cb28af 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -351,8 +351,11 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 	} else
 		*acl = NULL;
 	if (bmval[1] & FATTR4_WORD1_MODE) {
-		READ_BUF(4);
-		iattr->ia_mode = be32_to_cpup(p++);
+		u32 mode;
+
+		if (xdr_stream_decode_u32(argp->xdr, &mode) < 0)
+			return nfserr_bad_xdr;
+		iattr->ia_mode = mode;
 		iattr->ia_mode &= (S_IFMT | S_IALLUGO);
 		iattr->ia_valid |= ATTR_MODE;
 	}


