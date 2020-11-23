Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380192C1610
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKWUKx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgKWUKw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:52 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405CC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:52 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id g19so9466916qvy.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/8/EwMyYU1c697kymcsdwy5Nls59q5He/x/uaLp6JHc=;
        b=k1Fpf3R4HyFU79klGVeSyIrebiBGv7VK2dIpcdSeODo9msK302YaGeNbAwN76NVfw5
         BfxPE4vYCnLfyNyTPdnKfmL/tgeKSbTr2z902+Q1M6j0Tr6vaEjtM7ad2QW2hVpliNS6
         13A2YbSnXT0Xg9h2cZUHlfcCmteQj4iLmMqhGJfAc2d2y6w2Yysz30pVXqKzZokENVy+
         /v2zism4ayrKmTb7IA9lSlOzdTf1vWFIeXXATB9aQBbRV7Z2P4U2Ln1cKWgxL26sI9AC
         vnHjkBCZgNreiEUkqEJ7FKD0Jh7o+Z1piVsPEkrPD2G4TFbWeatHyBTuCQTas+br9PDk
         q2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/8/EwMyYU1c697kymcsdwy5Nls59q5He/x/uaLp6JHc=;
        b=XZuTwd/yJPHZ8jo+JD7kuOPwQ2UnabNJaZ+hZ2ozDR+cfJReoK87P/u3Z7eI3hNdW1
         XKB/jv7KGd8yzJ8WH7P1m9oL44fhOyuwIj3CKC+TA9Mbm43aRkHEQr2sPI3i/W7r/Q31
         0b+Vdg+9z3nXjpqZxHMOQaMr9y6dmsNwsmp2mz8HZ0Z8dpjDVQp6TkYONEM6LFWD5Sgd
         txK72WWSbp+l9y4M+L4Xgt6DQXuRWOiW+0u5G82+hTpST8VXIqWsyvrleYQ2k87D+Wur
         deeJzhkg9fu3usKYWFt77bTYgjil7UFUnMyH/HNfKp55pwvBxqLTtsJ+hPM6bklOKS9q
         Ge/Q==
X-Gm-Message-State: AOAM5335W3nSKh4QQp/BwlKNgJnzdlU+CBJbiz+8KNEjGDevKenKzVKO
        lqan2CE1x/tvG7/yEdGaIwjOyOemaA0=
X-Google-Smtp-Source: ABdhPJzWUBVU7E0aQYsdKQoqHyPC92iz3KS7wot8bg2taOyf2sDOdSbiXUKfK9hQZFtOIwrGNZlQFA==
X-Received: by 2002:ad4:4b01:: with SMTP id r1mr1047186qvw.51.1606162250956;
        Mon, 23 Nov 2020 12:10:50 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t51sm9719557qtb.11.2020.11.23.12.10.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:50 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKAnAZ010518
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:49 GMT
Subject: [PATCH v3 78/85] NFSD: Replace READ* macros in nfsd4_decode_seek()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:49 -0500
Message-ID: <160616224936.51996.10291659309003838910.stgit@klimt.1015granger.net>
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
index 0c8c2a3f389d..1401ca744d95 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2054,17 +2054,17 @@ nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &seek->seek_stateid);
+	status = nfsd4_decode_stateid4(argp, &seek->seek_stateid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &seek->seek_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &seek->seek_whence) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(8 + 4);
-	p = xdr_decode_hyper(p, &seek->seek_offset);
-	seek->seek_whence = be32_to_cpup(p);
-
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 /*


