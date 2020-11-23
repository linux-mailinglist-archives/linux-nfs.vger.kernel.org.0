Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF312C1608
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKWUKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbgKWUKg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:36 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B245C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:36 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f27so4803650qtv.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1iuOnJBz5vXpYGYlvSLmlNOuFzGXcvE7+eiNI+Hzfw8=;
        b=vEkG67hsROWPEsNES9lRAz+ICKM614POO7cmUHUpnSpDBwUaNzn9Z1Utt3UbtO94V7
         WcOjuuk8pwNkv6fz2EXVWCBrniQfWuFmAC0j1N1oeKF7UU1ZsRICzythqajW1+X6/nmI
         RnCCeUQVXk1jZrosnE6Zps8ip8lgfK2NfOw7GbheYmjGqOdniTCfEZ/dZBwkVn5OsAHV
         V3UPxt7NXZ36A2aD+ZQtKt1jzlOLp0BgktVwMcnGfcdfl1ctrZKrMFbPDQPVK4kXRK1s
         +sUzv+VqjvBU36nnqUnoRHAfLOyMJcwtWx74eDqj2qWE7uYlk3YG4mGl11eqM7vIKkLo
         5Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1iuOnJBz5vXpYGYlvSLmlNOuFzGXcvE7+eiNI+Hzfw8=;
        b=I/7o2exezzTF3CA0OQrS3yoUlSUXsqe2p0hy0Er627HfSnwzgsSd+7udehRDRBvQtR
         C8CtezN3ud5magqZhMjzeYzwHkWDff9miJtVytd7h/VFsvy+YpRueNbQm80R4Ev+ljlb
         v7VkXOpLDw+syWsOUrNLpsQORRGYOHHnyLmYXoNZZuSA2tL2IjAUt9UoVyJxT3koCqbc
         7Vd2LZ0TcVwG+zQqMtN4z7/BRysssr8aG4xqF4e53RGs8i8O//bd9Aq7BiWO8Kz5Bdq4
         sA3baTHXu6ATYmM1KtB37e0ncBDT+sgeI+oQrOQ8q2cEX7e3sTtnRdggJxZxLu2UwM5z
         gKvg==
X-Gm-Message-State: AOAM5330TEob6lQDA+Ru/v5Bn5kSFIH1zDBeFlU26umxfTDrcBFs8E24
        d0+a7d76PNHhaGbxalBORq1uWWNHiLI=
X-Google-Smtp-Source: ABdhPJw/egDWiaNkzdF7/eaUI5wjQbN9oFg0aUJbmXnwTvNVb5Kh/2H23q+uG7/nv9IhMMoJwMAT9w==
X-Received: by 2002:ac8:7749:: with SMTP id g9mr897376qtu.303.1606162235320;
        Mon, 23 Nov 2020 12:10:35 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r190sm10266256qkf.101.2020.11.23.12.10.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:34 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKAXX7010509
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:33 GMT
Subject: [PATCH v3 75/85] NFSD: Replace READ* macros in nfsd4_decode_copy()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:33 -0500
Message-ID: <160616223394.51996.6464657919629252433.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   41 ++++++++++++++++++++++-------------------
 fs/nfsd/xdr4.h    |    2 +-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6870a2ecce3b..501a2c3a55e3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1982,40 +1982,44 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
-	DECODE_HEAD;
 	struct nl4_server *ns_dummy;
-	int i, count;
+	u32 consecutive, i, count;
+	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &copy->cp_src_stateid);
+	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
 	if (status)
 		return status;
-	status = nfsd4_decode_stateid(argp, &copy->cp_dst_stateid);
+	status = nfsd4_decode_stateid4(argp, &copy->cp_dst_stateid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &copy->cp_src_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &copy->cp_dst_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &copy->cp_count) < 0)
+		return nfserr_bad_xdr;
+	/* ca_consecutive: we always do consecutive copies */
+	if (xdr_stream_decode_u32(argp->xdr, &consecutive) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &copy->cp_synchronous) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(8 + 8 + 8 + 4 + 4 + 4);
-	p = xdr_decode_hyper(p, &copy->cp_src_pos);
-	p = xdr_decode_hyper(p, &copy->cp_dst_pos);
-	p = xdr_decode_hyper(p, &copy->cp_count);
-	p++; /* ca_consecutive: we always do consecutive copies */
-	copy->cp_synchronous = be32_to_cpup(p++);
-
-	count = be32_to_cpup(p++);
-
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
 	copy->cp_intra = false;
 	if (count == 0) { /* intra-server copy */
 		copy->cp_intra = true;
-		goto intra;
+		return nfs_ok;
 	}
 
-	/* decode all the supplied server addresses but use first */
+	/* decode all the supplied server addresses but use only the first */
 	status = nfsd4_decode_nl4_server(argp, &copy->cp_src);
 	if (status)
 		return status;
 
 	ns_dummy = kmalloc(sizeof(struct nl4_server), GFP_KERNEL);
 	if (ns_dummy == NULL)
-		return nfserrno(-ENOMEM);
+		return nfserrno(-ENOMEM);	/* XXX: jukebox? */
 	for (i = 0; i < count - 1; i++) {
 		status = nfsd4_decode_nl4_server(argp, ns_dummy);
 		if (status) {
@@ -2024,9 +2028,8 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 		}
 	}
 	kfree(ns_dummy);
-intra:
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32
@@ -4781,7 +4784,7 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 	__be32 *p;
 
 	nfserr = nfsd42_encode_write_res(resp, &copy->cp_res,
-			copy->cp_synchronous);
+					 !!copy->cp_synchronous);
 	if (nfserr)
 		return nfserr;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 232529bc1b79..facc5762bf83 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -554,7 +554,7 @@ struct nfsd4_copy {
 	bool			cp_intra;
 
 	/* both */
-	bool		cp_synchronous;
+	u32			cp_synchronous;
 
 	/* response */
 	struct nfsd42_write_res	cp_res;


