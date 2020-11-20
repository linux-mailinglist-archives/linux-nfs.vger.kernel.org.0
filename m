Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00F2BB746
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgKTUhM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbgKTUhM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:12 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F0C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:10 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id q7so5286965qvt.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mZ2D2E5bsx6w6oiDBSBCBu9VySnYX5U7grH9GcNeQzc=;
        b=OFB7lYBV9owt+oqIqjH1jYY0Hsy/bRkudyKvy35yAWEe+Rje4K62R83U8Lcqjc85H6
         LfVGK5XD+zjlXcXF/tzaTCSLAn/41X3ueFKUWSmIohmzgjFj4MtsAyuHbue2EBW+yKN7
         EDd/x9oC/yHLoCdHNnsS6mvKIrwSTKu5YpYyGihbomUNgZ4L46ETcc6YPDrmmilhebvW
         OFKs4ZeJJDyWt1Yy4ZD4sN5FMkG0VdGjYYDEHY4dB87bAECQGw27vw3/Gt7sCbnxIPde
         CxocPDJp7+TQSU+HKGQDyXew3b/KOB+m8WBrGBIM1rZPX7ldLkOcDBOiuqE7DCYM1y/+
         q2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=mZ2D2E5bsx6w6oiDBSBCBu9VySnYX5U7grH9GcNeQzc=;
        b=ZS+CZdKOVB+M7aIKXUJap75tU/isi0hLWqenPgkTprMYZRhYSiO8Hl4rAaVeIozw+P
         JjSJqehHKMxAQMDJXGAgiof9HbmIuPLCcIZiM7lQVAtDx/8JzFGbtszycLg05lDDCc4Q
         yw0JDqXLtaiHm2Pw5NOmE5UgZKJO+1v2FlBjR3UhSQ5M1mPJje2+BSPqvCoWOm76vmUX
         frJZ03XsfU5Z8yvuZ88Ns34RkyNN/iFuBUiZxrW4mjuBWaFHX+UtwzERGQfmuB3dZl8d
         Su+vuIrb6K6QBuvSDTW9tkukN3PwfkXSYqzB+w3pojtBslONeDSgDMoYYU0vCJkUgloj
         2t2A==
X-Gm-Message-State: AOAM531qmRFm9WwcL1pCiZHcD/L9Yeixfi61QoDPHyeJ2F+ShPge396o
        MLpsqTxB0+CTkcu7pmpF8jbfTzX+63w=
X-Google-Smtp-Source: ABdhPJwxAq29EwCDSB9m21d53iYUIVFZXvAvyO0DvSZ6k6fMCZWCpbr1CYsazvIHoNIE4HD51zk9/w==
X-Received: by 2002:a0c:a544:: with SMTP id y62mr18676854qvy.11.1605904629671;
        Fri, 20 Nov 2020 12:37:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q20sm2718399qke.0.2020.11.20.12.37.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:09 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKb7Ml029316
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:07 GMT
Subject: [PATCH v2 038/118] NFSD: Replace READ* macros in
 nfsd4_decode_open_downgrade()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:07 -0500
Message-ID: <160590462795.1340.9636735539087512954.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ad3f392de382..fdc6ba702132 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1119,21 +1119,18 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 static __be32
 nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_downgrade *open_down)
 {
-	DECODE_HEAD;
-		    
+	__be32 status;
+
 	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
 	if (status)
 		return status;
-	READ_BUF(4);
-	open_down->od_seqid = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &open_down->od_seqid) < 0)
+		return nfserr_bad_xdr;
 	status = nfsd4_decode_share_access(argp, &open_down->od_share_access,
 					   &open_down->od_deleg_want, NULL);
 	if (status)
 		return status;
-	status = nfsd4_decode_share_deny(argp, &open_down->od_share_deny);
-	if (status)
-		return status;
-	DECODE_TAIL;
+	return nfsd4_decode_share_deny(argp, &open_down->od_share_deny);
 }
 
 static __be32


