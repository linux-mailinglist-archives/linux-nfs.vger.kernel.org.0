Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A436E2C15B9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKWUHi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWUHh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:37 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE791C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:37 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id g17so14371154qts.5
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OdlCDg1wYos791JCDgyhUGhBlCvZo0/tQZxahymaM3E=;
        b=b5HgUDepj4iCcuiJlgGnYLraoqAXS819MNSZx6fLmXujOUCbIm/4VMZNAyK4UTnrRB
         ot8UUbXTwz1hKA9gc3CyJReQNoE+GvrfCtf8k/YPJF0aXn5pVMHGu+K/5QDW7eyieJiZ
         k7dff48k0f7vf4kjoENCSIfLRQ2a4/L+SwxxzZXkeAcbm6jFsY1vM/nWMo0AFzaaZSyA
         VNg0UCoShCgKMu832GphOGADo9Ukk9I7zx8GZknv5jOvZQ3gqU0bKSxwXVQCa51LZ762
         WMszfWUZKu21o0k5UFYbnwNMYvz2YI2Io+5LEnovCiC+8n943pX54W7h5b203fwixOdy
         nG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=OdlCDg1wYos791JCDgyhUGhBlCvZo0/tQZxahymaM3E=;
        b=WG1gG7tm66g59bO2P/a9Xf77XkVr0tzKDdR50QRkccCZYrvRND20hm54yPt/W/V4XN
         Lai/PSRma/oJ0Ft+QqZeIfhgNk5ZuB8M6oSMiIAxN0+JsOukPc78mms3S9fgpDv0ak34
         uZbPc8cNJUdaT2yahnejnyLhn9/pRIgsK1z7GujuFtp/Dp7YLXZDlTszWmRg+/WUpPV/
         V20bEg+q5DlE/DpnfWJnmjiMV168B5IvImu5vtQ07O7HNpoDqa2H63gG7bmIftD4rS8T
         Smy5NSWnZjY12MyQFsBCuKbHg357Tw03p6kwLhS8HpPVQOPIEOKx/1hoK9B4w62kBazC
         Jc1w==
X-Gm-Message-State: AOAM533IIgfBdLF55wfQvf9qohEQZ5H6tZ0hxhPYQ9VF0pNW17ie/GYX
        R6ziz12ylSoeKnoaCHhWE9o1v9zVRng=
X-Google-Smtp-Source: ABdhPJxhsIDVuwNlGUBAWZby7odm8SZye7VIAIOjZcDSW//uOwF5BkMk2dkujirUhobGDAPQIvP+SA==
X-Received: by 2002:ac8:724d:: with SMTP id l13mr836651qtp.373.1606162056744;
        Mon, 23 Nov 2020 12:07:36 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o125sm10137793qke.56.2020.11.23.12.07.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:36 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7Zm3010391
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:35 GMT
Subject: [PATCH v3 41/85] NFSD: Replace READ* macros in nfsd4_decode_read()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:35 -0500
Message-ID: <160616205507.51996.6277809172160199601.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 876334eb4d72..804c0ee4c308 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1218,16 +1218,17 @@ nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &read->rd_stateid);
+	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
 	if (status)
 		return status;
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &read->rd_offset);
-	read->rd_length = be32_to_cpup(p++);
+	if (xdr_stream_decode_u64(argp->xdr, &read->rd_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &read->rd_length) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


