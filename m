Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781F72C15D3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgKWUIq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbgKWUIq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:08:46 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4CC061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:46 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so9450492qvb.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1B8RcYTvrIidCvhnrNz+kUHJjx/EBQgtYfA3y5nP/Lk=;
        b=E4EJHGgzI23UCgpU4UmfBwjFo9Gj9MNwlF5qsmLBsvAAD1coHEWldVpBDb74ICE71Q
         cnz4iFQ0pwEMDKo53a7KOOxi5X10PffROfxd1XNoF7nfFEMAwC2cW8JO7/Eh+ENggB9H
         nbVzvfsgfI+8m7i2b46kisRsxyX6/XuKhm9GcJCRhw0M8FCN/qTbOyes7Vwp8Gv21ANh
         +XGn8+qGOFjT7P3UftiQx59VXT5B/4F2k2Z5UlPTgX8fCA8mmVsq6jV2p77Ny/BOVDgE
         m0hQxNSj/zkc2Y070qUF6JOVKoyr3hR19G/WTANzv96O52U/mlH7ez5kZJz+FD9zNvTH
         9aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1B8RcYTvrIidCvhnrNz+kUHJjx/EBQgtYfA3y5nP/Lk=;
        b=tpCeAd6TXPlaP7XFcBU/Um0fSCgAVAK8mKhacbW14XgFpbHHia+LnKHuoalEgJ8hsV
         aHTVJ1ip719QAK3rfan++XVNlxnsy+CMZEj26VC7eUFOlpJUB+7EiqqjlaXnVmccLOl7
         SmBu2cb8BG9PPInaErHmvBmI9GsdeLp6I+qE6tAYNwLQ1Tqr0nDjgaTV1EXjpnJf+vnt
         ofTw6nRb3lRvilDDFykzdY2Q9DHJaODA1loLYGmm4GnjtXj/K0hCiESyumgvkCs1s/Zz
         kePqxgCD5XrGzdNYgpaVj7IcqVvaZ+DWkxXeSQ3K3krV52DvSdA6j3JCIZ9GPhRuoPux
         gb7Q==
X-Gm-Message-State: AOAM530NGOF4bJBN5IBB6BuNMFU2QfSoACICGggDKifipkR3iN6OLVNy
        aLaNrfuA5nNnC+W8tuLMNMZaWoluMk0=
X-Google-Smtp-Source: ABdhPJzTPOJsQyPvQ+u60R9FQb2jdrvpJwzAaMo/zCU0poxf3wAinV0rAtCadkIIY57xxBN6n55hoQ==
X-Received: by 2002:ad4:4cd0:: with SMTP id i16mr1115936qvz.13.1606162124992;
        Mon, 23 Nov 2020 12:08:44 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d66sm11345046qke.132.2020.11.23.12.08.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:08:44 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK8hlF010438
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:08:43 GMT
Subject: [PATCH v3 54/85] NFSD: Replace READ* macros in
 nfsd4_decode_backchannel_ctl()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:08:43 -0500
Message-ID: <160616212335.51996.575379692286109461.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index acbe461e03ae..87a3c0c53945 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -788,17 +788,6 @@ nfsd4_decode_access(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
-static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	bc->bc_cb_program = be32_to_cpup(p++);
-	nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_bind_conn_to_session(struct nfsd4_compoundargs *argp, struct nfsd4_bind_conn_to_session *bcts)
 {
 	DECODE_HEAD;
@@ -1483,6 +1472,13 @@ nfsd4_decode_release_lockowner(struct nfsd4_compoundargs *argp, struct nfsd4_rel
 	return nfs_ok;
 }
 
+static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &bc->bc_cb_program) < 0)
+		return nfserr_bad_xdr;
+	return nfsd4_decode_cb_sec(argp, &bc->bc_cb_sec);
+}
+
 static __be32
 nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_exchange_id *exid)


