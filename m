Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56F92C1602
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgKWUK0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbgKWUK0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:26 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ED7C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:26 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id e10so6900798qte.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8qm6AuA4fWlfqFP8HvQtU8t7lhensaoYUkTE+XruJT8=;
        b=Ab0sALcMOYiMrPLQS88MzlpW5yXvYu1SYsa9ni1wsZob98Txvv8FLk4kMdpdyZUAvK
         PjrJczYLeI2uHSzXbvP4X/DqVS6P8cDoyD4OuL9XMTS3dwTPOe7FSd7urJIcuA3Ra0Rl
         QmmPgwN6AizG2GF+/ZMsJ84BPBYb5Hm1hZbVlWUUDzdC1WTT+VmjkhXR0KFYgOb33wLz
         TPggsryhTybfYhzTCTzFxXwbfc7JqzNNwCYYMgBIwKiZhxjxDkBfrYXW2HIL+MUBCuEa
         p3clmkZEG+FquRiSZdS7Q+NTocmhzD6EadpeMbPefybQsju5/J12ZP0fUQXUA8A7ay+x
         AByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=8qm6AuA4fWlfqFP8HvQtU8t7lhensaoYUkTE+XruJT8=;
        b=NhyCbYnMQwPFZsPbBnMh5YCiQc8F7OdSmze7trD6b2NicHK06uuxDedPE9P0KMUt5v
         y01LsKBhWFxZXXcQupM+GSIjIFAJM5o21MaiQHYKj2aIYNdFbphfCKrOGL86Qwg+umKJ
         LK5ItcaWa4TQk5R1tOPdbYcbvE/O4l1jLkUh0Tp971DTI1pM8eUnLzTpVz9nqdJclZ0O
         w3rNbkEsYbWeqzORMYCNXy7OzCZ7ydUxMf8nCwcnAS4VF+ug0NBaGZfQm+sAFHmMUIw4
         TqFkeb18IMylYOCegyynDWl4/XUM5j3JPNnX27tDj2Inpjxcq2mJC3jFSXfDvQXjMNdn
         G+MA==
X-Gm-Message-State: AOAM5308hLnTmehfH61K1OzYqgmyCLrQ+FsN2r+yItKXdmDN4DhZVzDp
        w3KNwuX7mMkWfjZGc149gXTqq7qUKEU=
X-Google-Smtp-Source: ABdhPJwQJhqklXr9vjdPcm1OEMVQEQ52Byn/wr9eqb4p4gRNJS1lCIkBbEQQYeurK09bNNsVS1WtIw==
X-Received: by 2002:ac8:7559:: with SMTP id b25mr894382qtr.51.1606162225002;
        Mon, 23 Nov 2020 12:10:25 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o22sm2087602qto.96.2020.11.23.12.10.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKANVP010503
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:23 GMT
Subject: [PATCH v3 73/85] NFSD: Replace READ* macros in
 nfsd4_decode_fallocate()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:23 -0500
Message-ID: <160616222359.51996.5801979625846189895.stgit@klimt.1015granger.net>
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
index 7e54cf0d4147..cfdf41599cef 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1906,17 +1906,17 @@ static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &fallocate->falloc_stateid);
+	status = nfsd4_decode_stateid4(argp, &fallocate->falloc_stateid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &fallocate->falloc_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &fallocate->falloc_length) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &fallocate->falloc_offset);
-	xdr_decode_hyper(p, &fallocate->falloc_length);
-
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


