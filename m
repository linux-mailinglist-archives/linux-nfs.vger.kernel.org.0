Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D252C15B8
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgKWUHf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWUHe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:34 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F16C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:32 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so18302491qkf.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=q96JdHd2+337Gqa0MlwklQMDQGubVtjjUSlxUx6pbOY=;
        b=Uhecs5dvE52cwth9QJmZsPuZazPJaev9oU6kwJJEUztU7j1hjcaw+AuTmdXaz9h+9R
         /dyFr8eJesTxwOrNYexd4wTfpk4zwemGMkU/mLGS/dWaw5Tz5IIy9QDGBFhZpTl+lVuI
         wIQyTS1RVD5QW7zFvppL7ivMSr2XEtqRFKYxb5v2fsFlchmr/3TDF+2E6f994ZIGB4kU
         8AtvXRleXSrJrF6OjPSd6OMWXuFlzReSuDfGxkxsvNjhjApECD3KJOedEVXY+NnxcVgA
         pDYF8qzBmGz9GxcyexgYwSXRmZMXyE6uHMhOJWcPe+YNLbi35k2fmvaM3QidkqdJIHo7
         L4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=q96JdHd2+337Gqa0MlwklQMDQGubVtjjUSlxUx6pbOY=;
        b=bylltWVrvUwpNVSmwvzGZWvtpNy/1MbMHKN/RpYkkoXTJqEJbxuOC0zwRp10KHFABN
         +oprcKbpyIu4JL9y3PST0OL2lN6iTWTT+YxrwHvLAvtxBktXf2P3YySfC9LR0T6/5n8d
         60EcFo1sC3VC9XnqrBUxctJnQNh9FU3O5NuIwrUVodqKhCqiqwLe5A9UvE0a+C3vQKeY
         B9KGJiIr93yyVD3qR5nZGCW0KvKpNok7gRj3u1/jKrybVQt0GUfNRFtn0GkVKiX4pBXm
         PhfDNs7BlwZOeoIKaW0DDzB3nJLrQhvNNOAOW5Ur74hvtfywIPsdbBttG72myyn3PcTu
         Wjnw==
X-Gm-Message-State: AOAM532zwtIKtoGxtT10YaUqSjijpnso+JYIg9GPPIyRRbENVKwMxddu
        Sp4df3V1xNdrvuA9U7VSUzK1e8HfoME=
X-Google-Smtp-Source: ABdhPJyrN2D4hTwEfxXbepkXzAE4ctW87sqFllCjS2cMXbaE5GHC7JREUDrdXrZ5fGHqsKWQin+E/g==
X-Received: by 2002:a37:dc02:: with SMTP id v2mr1158395qki.181.1606162051444;
        Mon, 23 Nov 2020 12:07:31 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l88sm5987106qtd.59.2020.11.23.12.07.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:30 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7TeJ010388
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:29 GMT
Subject: [PATCH v3 40/85] NFSD: Replace READ* macros in nfsd4_decode_putfh()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:29 -0500
Message-ID: <160616204978.51996.5677066489149283026.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 54bde3ac92f1..876334eb4d72 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1190,16 +1190,21 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 static __be32
 nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 {
-	DECODE_HEAD;
+	__be32 *p;
 
-	READ_BUF(4);
-	putfh->pf_fhlen = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &putfh->pf_fhlen) < 0)
+		return nfserr_bad_xdr;
 	if (putfh->pf_fhlen > NFS4_FHSIZE)
-		goto xdr_error;
-	READ_BUF(putfh->pf_fhlen);
-	SAVEMEM(putfh->pf_fhval, putfh->pf_fhlen);
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, putfh->pf_fhlen);
+	if (!p)
+		return nfserr_bad_xdr;
+	putfh->pf_fhval = svcxdr_tmpalloc(argp, putfh->pf_fhlen);
+	if (!putfh->pf_fhval)
+		return nfserr_jukebox;
+	memcpy(putfh->pf_fhval, p, putfh->pf_fhlen);
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


