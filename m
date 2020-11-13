Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC962B1E09
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKMPER (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgKMPER (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:17 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3FDC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:17 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so3247871qtw.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tN0VXUzvfOn1IsGyxe61OZ/fZfxUb40B1aG2GEluqwE=;
        b=rW2HpzioVktLGtQkLz3xd+fzdBccZeEpv2r05YR7Loejt9PM5TiFhQpG89lQKvfV7p
         gi430TIl9e8DwkZg1Bd79xsRIM080kLt2KupeXwbYyAdQLLoONyWejoyURlMuMMVsNI9
         41422fQJjLnVEiVoSh9p0R+CBAKQZf816Kj7XFplvfsmPBRVub+Qiic41s6cK3Irg3DB
         64qKC4ZvFrIL+crcU54h342brNui3GrSoia5BFZ+gaz1TA4f6Gf9tCOuQTPCs2spSe4v
         dVwRJCZY3y959Qe/UBslB9FKZT1zfdxVNbZR6t+kK22ciAsxyDIWXD6cRAFR950yqecA
         eKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tN0VXUzvfOn1IsGyxe61OZ/fZfxUb40B1aG2GEluqwE=;
        b=jE6aSeKNslkXpNiFCUCJH4m/eL0CeoPsMtdfvOZP2Y1WqGFuD/STWJJRruxhVNTcXL
         4GDwbj8KnqNwGc59Y0i09zDIuHmysVscHPi1My2U1RdAwyfkk6lJ+i5v+8nUkt5r9LgL
         XRWVsjsRyiZmvQRX4JaaXLYAtRnvSh/p9LXTUOXj+Zb8dG32/kkrFNDuvoG4rY3nEjWH
         WuFTzNxNMWx95Tj9o85uskTN8rsf2DMsgWf65Saliw9ZLU2YcAbS/lpiJo1QhCNZuTh0
         QQ0BeQ6YcmiQzp2BASdbreOakOMPiU/IPGpuUZQNbjFH3wPcXIKq730gMm1ShlIQ4Mf/
         MuTw==
X-Gm-Message-State: AOAM531aM2tQ0X9T7JjekNtTluld7NEvyiN6nqRFJkA/8GOjF3ZZJfnO
        +GF8FOUqZhotyklEULLYUPZeZuaT7z4=
X-Google-Smtp-Source: ABdhPJwxNxlx4fAjxNYpDqeArNVoPlleMaVCyFZ3sXaZbFCiGqpgxkJ2t/3ubZYbL76PXozneL1tPw==
X-Received: by 2002:ac8:3499:: with SMTP id w25mr2418738qtb.44.1605279855188;
        Fri, 13 Nov 2020 07:04:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p6sm6671118qkh.105.2020.11.13.07.04.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:14 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4DJ5032700
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:13 GMT
Subject: [PATCH v1 21/61] NFSD: Replace READ* macros in
 nfsd4_decode_open_downgrade()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:13 -0500
Message-ID: <160527985353.6186.18423382803060328673.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b4f23d1fd85e..c7e7854b5e19 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1121,21 +1121,26 @@ nfsd4_decode_open_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_open_con
 static __be32
 nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_downgrade *open_down)
 {
-	DECODE_HEAD;
-		    
+	__be32 status;
+
 	status = nfsd4_decode_stateid4(argp, &open_down->od_stateid);
 	if (status)
-		return status;
-	READ_BUF(4);
-	open_down->od_seqid = be32_to_cpup(p++);
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &open_down->od_seqid) < 0)
+		goto xdr_error;
 	status = nfsd4_decode_share_access(argp, &open_down->od_share_access,
 					   &open_down->od_deleg_want, NULL);
 	if (status)
-		return status;
+		goto out;
 	status = nfsd4_decode_share_deny(argp, &open_down->od_share_deny);
 	if (status)
-		return status;
-	DECODE_TAIL;
+		goto out;
+
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


