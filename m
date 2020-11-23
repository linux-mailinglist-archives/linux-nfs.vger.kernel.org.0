Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032022C15BC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgKWUHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgKWUHx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:53 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B054C061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:53 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d9so18228135qke.8
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LyJTjgmV9SIQVKG5T1vVOXWk0Lgaki3Q255iyHvcfMY=;
        b=CR9sGLiFINtOc2QGUXUWLXn5/446sYhHih0KYqUBMq69qEPY7lSZuBHDoeYQPJzJ94
         xN7P4y6aYqz7X6eHbDgDhP41jCqgjZNr2rhOGMwsN5S+Mjbleo7MNpGvnPamg+Uea4Cm
         UmCS+LpfA1QWCV+J2bgKAlktmuKt4M56BnxjGUd1EmLBhjTBHjULqThDVuHrfyMdL/r6
         6v01aFm9tGEhencpdd/etLw0/wDv8rL+AHZCqONYEPESSooM5jRMgM/wGnRWEim43DZt
         zu2A+6blr6q+WZdHeGzwobOlmbzrJBUb5328uFFtDr7GzeRiWlLY7e1ir1EAP6uql3yF
         bgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=LyJTjgmV9SIQVKG5T1vVOXWk0Lgaki3Q255iyHvcfMY=;
        b=Wh/Jksh4SHKp1pCV+Bl3zPf6R1ZdL1/ON9wjATQ4FgJN8elCVr7pyvTUwTScdL80ys
         B6WP6KA4dFVXZJcOEKnF58sRpDFMlOikjrGaLcfjP13KL2TlYoY5mRv24g1NVcBGs5kN
         hXTlcqp5PiAsDFZJZTk/vccvBPxHZQ6J8V/pWXKlMRCiwEmvMg8mEjvZ4wz0QN+d3CAE
         i5We1OndWbAKl/bv78N2CVP6uDYLEkLha8Y28Ro+6NXUQCitYO5Gs8TUgMSNAmjnR630
         JWAbHJxNj7UjZhCqdwMVHV/verAn6VUMP8NYShccWN6fplGqE/CM7VNVJMUXrEgJj1Jc
         tlpA==
X-Gm-Message-State: AOAM530B54+uHEaF8PxEfw6AYcsIE+SD9cjf6nnXHj3mJ1FBXJEp0HFD
        hws+NuAP5fNOFODEPP+iOSewkIYfhng=
X-Google-Smtp-Source: ABdhPJy0MnwS+rf8tM1246FL7cslr5G2wlKvO9ET5XXKLXvdRbwba4m+TJrpStPxXCSxYDSd/LFihQ==
X-Received: by 2002:a37:610:: with SMTP id 16mr1248916qkg.214.1606162072579;
        Mon, 23 Nov 2020 12:07:52 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t15sm8779739qkm.114.2020.11.23.12.07.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:51 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7opI010400
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:50 GMT
Subject: [PATCH v3 44/85] NFSD: Replace READ* macros in nfsd4_decode_rename()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:50 -0500
Message-ID: <160616207092.51996.17310784381514228708.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cdec94ae81fc..ea687ea78c18 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1261,22 +1261,12 @@ nfsd4_decode_remove(struct nfsd4_compoundargs *argp, struct nfsd4_remove *remove
 static __be32
 nfsd4_decode_rename(struct nfsd4_compoundargs *argp, struct nfsd4_rename *rename)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(4);
-	rename->rn_snamelen = be32_to_cpup(p++);
-	READ_BUF(rename->rn_snamelen);
-	SAVEMEM(rename->rn_sname, rename->rn_snamelen);
-	READ_BUF(4);
-	rename->rn_tnamelen = be32_to_cpup(p++);
-	READ_BUF(rename->rn_tnamelen);
-	SAVEMEM(rename->rn_tname, rename->rn_tnamelen);
-	if ((status = check_filename(rename->rn_sname, rename->rn_snamelen)))
-		return status;
-	if ((status = check_filename(rename->rn_tname, rename->rn_tnamelen)))
+	status = nfsd4_decode_component4(argp, &rename->rn_sname, &rename->rn_snamelen);
+	if (status)
 		return status;
-
-	DECODE_TAIL;
+	return nfsd4_decode_component4(argp, &rename->rn_tname, &rename->rn_tnamelen);
 }
 
 static __be32


