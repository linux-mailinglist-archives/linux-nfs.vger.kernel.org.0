Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6525A2BB751
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgKTUht (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbgKTUhs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:48 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89216C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:48 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 199so10177733qkg.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yw4KGKLM3O1eAiYXppyFyasPBZICLwwkL3HmexLFWO8=;
        b=DmB/qyM7ZyM0u/Y7SkBSkXUB6yn1xbj4+qSfF+wIOLD1vXEUkp3ZAeXIxVpEWDecSn
         YrIsT3xuy0JVDSfIWO73kXGRjaiYaEGIsnJHIQ58p0f0NKJoXpf2QkyCaj2xk8IeuQvV
         DLiWnBiVPkJEk68B209GbTLF31/2vWYavkB9lXud7kHtfU1SG0vQ/eonz1l9tXysM2m+
         vtc98tfSCAvlP1SVGz9NUKX3GSAZXRa9ClFrESvMYqL1fCG/BLzjtuanRaaBITgFriVO
         67tIdGG146y5VXNc8VS64RT7sBOpeqBgAQyuJjqtNxHVps+TXZywlRsSAEhhdO9Bn1So
         AgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yw4KGKLM3O1eAiYXppyFyasPBZICLwwkL3HmexLFWO8=;
        b=sbO4p9PiCQbfMHrV+O8E6HKV2LsFY3ddzln8dEh49t8aml5MFuQx6JxxaolzC6yMsk
         jb+nYDYpRskBNBAV6XaWTnj8YuTM7MF0r9swClkF4JXuxA60LbUlBAcXGyR/QbovMmgq
         PNy5s0phssyBJnNXY4vpYL6DjHUtnjsOuvOBN877XB9kB445/TC0LGYx7jJE4EUTKQu2
         NzSWHxGjVCIl3xH9/RpzPkif/n2iEBizN6vIPjmfSoC8A/sVW2HLw+MqARA9h1Eepfuf
         c09YkZXGVVsvtr8DUXYPKxAQjvKdyN8GVazzR2yM7DmTuR9kGskSutUaduWR5OMofWW9
         gWSA==
X-Gm-Message-State: AOAM533EVAhQMXB6z4DBjGvCO4zwWZy2ynqv8kuHWP0a2tmVBEU1Ehpw
        oIxuJUEzm19ofOHfYDJwrTCjCaQdSXE=
X-Google-Smtp-Source: ABdhPJwBxPzjDZawV/pJzaLc2YLM19uYBsydjxk5EpeNezYf3RPClPr8VPiYxGn/6/tL2T4dJ4BM/g==
X-Received: by 2002:a37:b8c:: with SMTP id 134mr18467196qkl.483.1605904667449;
        Fri, 20 Nov 2020 12:37:47 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q32sm2782526qtb.71.2020.11.20.12.37.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:46 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbj6X029337
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:45 GMT
Subject: [PATCH v2 045/118] NFSD: Replace READ* macros in
 nfsd4_decode_secinfo()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:45 -0500
Message-ID: <160590466566.1340.13897927208863181747.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 19e8a61c8409..98297182118d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1225,16 +1225,7 @@ static __be32
 nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
 		     struct nfsd4_secinfo *secinfo)
 {
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	secinfo->si_namelen = be32_to_cpup(p++);
-	READ_BUF(secinfo->si_namelen);
-	SAVEMEM(secinfo->si_name, secinfo->si_namelen);
-	status = check_filename(secinfo->si_name, secinfo->si_namelen);
-	if (status)
-		return status;
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
 static __be32


