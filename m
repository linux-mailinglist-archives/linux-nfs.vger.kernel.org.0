Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33632B1E12
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMPEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPEx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:53 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58BC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:53 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so9050221qkb.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=B1MpHXz09YNUUnQLdTm8YbHDT6KMUv02pXKtadIKbKI=;
        b=JM4WdC7bSPHq9VPg747oh3FXyfhIwT2AdZv+sLzyEZ2hl07xeCdPA7iki97CnxxycG
         f6b3a7Oiuo4oas4QqBYD5bAvKqJUX4t1kqmH8xHQ+WP0h+G8CX4BG29lxMuc3mjjKFRq
         +VLsahZm8RzWehRDM4ZX7og43u3tVGtBqgg8TomFKcaowsObxUq17KCut47PjeC8aUiM
         ciSZdxYDv/zP97nPu24xywCgc0h4A2Ctvy4zGGcAPOXQayyZei6L1f+K9yThqDmQrW5P
         iMCgbDT/9Y1x+Hkk0R+pVOZ3skiUgEP3qWf0tSeKPzevntmsyuhcsksnbOMd3IM/owSW
         A4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=B1MpHXz09YNUUnQLdTm8YbHDT6KMUv02pXKtadIKbKI=;
        b=LFsA6jiwsK3AHzChNq0VY9mX1nXI6ETzMvwBEnijYhQkSwknm3VE5YakzGWbjPtR0O
         dQvBFI5NhDrYhxxdaM0NoYLVOKBwV9a1i2u5yY3SAst+8466XWCRm2sl3W5Q29aFcf5L
         acaCUQsplJpkif/yQy+coXLU1E5k4SEJZsT3uZz+pQ+S5/wrxVVDxfJAaPHhKPpWYqkF
         OOm66jWXRbkaWSEmPk2HusT0pRK7MJ8twrU/LwIx5qbWYo/HD6oapDb3QL3vIrpp3XPG
         5w6j9a2ltJEMgiNEYsJMpIa9Gz/J50GOOBB58WMM0s6JaEBwiOQ9xW4WFNXGkuq/xvRS
         I8MA==
X-Gm-Message-State: AOAM5325EKOBpWkiMaJNo0qb+1WqqDnEq6mBLayoBDw+nF8M5zBanJQM
        YkTW9KPHryqOOBdzw4bsaWckBwZaKOM=
X-Google-Smtp-Source: ABdhPJxv3wKsbDnD/ksppO6a/RVcpGpOI87XSiD/uW5vEm5VbUH/Rjy+bdPKYGVsInb2W7ETnQ7ttw==
X-Received: by 2002:a37:4953:: with SMTP id w80mr2264819qka.35.1605279892191;
        Fri, 13 Nov 2020 07:04:52 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h4sm7267673qkh.93.2020.11.13.07.04.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:51 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4oWJ032721
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:50 GMT
Subject: [PATCH v1 28/61] NFSD: Replace READ* macros in nfsd4_decode_secinfo()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:50 -0500
Message-ID: <160527989049.6186.7791382861982563259.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e7b43bc69af9..bbae2b1726ac 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1253,16 +1253,7 @@ static __be32
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


