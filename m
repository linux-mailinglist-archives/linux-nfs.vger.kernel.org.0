Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2D2BB778
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbgKTUj4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbgKTUj4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:39:56 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA148C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:55 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so10273432qkf.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7EhqnswBN7VhEEUvBRTc+ME7wDXI1qjtedrZmN50LRk=;
        b=TwNFurLt6W99MXLrj7E6bPIYltWQFF/T9rFvQwjxbOjhV5yFNruQeBRgjNT6b0fguK
         VPJZqPhaklxw+ydgUg5A75N22RJOpqQUGzQhvwqwYU0fBmuFs5meZ+THEb6IekBp2W5E
         hadO0ciXjT1HR3UBhDvO0Cenr1tJQrkKlvOwt+9ULzwqD4HFXE9B1G7hjiC9NJ4FXZV5
         zu9oZz48JrC4qHIZjP/neCv+tCoLX1CjApaEsoPEEfHm+/PnskmtnUmPBQUrlT9FgOI8
         OjhvL2UcaLKyS01uf4qJM0OSDAM2YssCfRInVUuWoWoqaeVWiMWRX2RIpQQRG59Hq4QT
         DycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7EhqnswBN7VhEEUvBRTc+ME7wDXI1qjtedrZmN50LRk=;
        b=DzGRMO+h+4l9yF67PtUp3FuOjNh0jmOjL1os2AGtnrScZogAHvGDhcyZvXJJLwfdiG
         giWIADZOykmXolAjnTkeQLs39xnCJENS/fXDsxdL0Efg0O1m7FH/S2g5gnE4hP7VFv2z
         536rMEticOfChw9FJhZ8ERncJymFz3dsjtO/wKKuvQNzeyL2lizPJYZ4LZ4dbNz4s5Pg
         +0oBr1hD4qjgMUuHd52iwnxqRk5f9sEXvE8ZnIecW2zcCWLLr++AX2+Ft8/DM36pr+dD
         9F1Myb4IlItHpjRQIqhcPxHE5m5vsZs7iMliZkd035To+o3ucAUj3fGfHwh5b61Hi+Sh
         2s9Q==
X-Gm-Message-State: AOAM530n6IX6VgD7OVzUqBaPrGyRKXhSTpSDEnCJmQY9oRSneYS1WTqv
        NC6OuSjh/1sNCUetdEE7mMsuungGZ3s=
X-Google-Smtp-Source: ABdhPJxaPCx4TuvyOPOZsrrJPST3FI42AFzUmY29bbrJ/lMjkgV8ZgZJ6GalwHbLoHBkxZnr4zKyYQ==
X-Received: by 2002:a37:6287:: with SMTP id w129mr10194170qkb.261.1605904794825;
        Fri, 20 Nov 2020 12:39:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c199sm2822441qke.111.2020.11.20.12.39.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:39:54 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKdruB029410
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:39:53 GMT
Subject: [PATCH v2 069/118] NFSD: Replace READ* macros in
 nfsd4_decode_destroy_clientid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:39:53 -0500
Message-ID: <160590479311.1340.834493651502484558.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c6301393c422..6bfc9f69c660 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1679,16 +1679,6 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
-static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp, struct nfsd4_destroy_clientid *dc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(8);
-	COPYMEM(&dc->clientid, 8);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_reclaim_complete(struct nfsd4_compoundargs *argp, struct nfsd4_reclaim_complete *rc)
 {
 	DECODE_HEAD;
@@ -1848,6 +1838,12 @@ nfsd4_decode_test_stateid(struct nfsd4_compoundargs *argp, struct nfsd4_test_sta
 	return nfs_ok;
 }
 
+static __be32 nfsd4_decode_destroy_clientid(struct nfsd4_compoundargs *argp,
+					    struct nfsd4_destroy_clientid *dc)
+{
+	return nfsd4_decode_clientid4(argp, &dc->clientid);
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


