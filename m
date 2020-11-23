Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA22C160C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgKWUKq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732324AbgKWUKn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:43 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA70C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:43 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id e10so6901650qte.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3GpMEjrnKig0wjvJlpaKRWzsuz4tiNSE6tOiAQiPL9I=;
        b=rWUpabHaLh/WT+fEfzltU2D1x2gLwD3Lb21/dfVImaB+jM6lt9iHpwhKg2svhGWwwv
         RQHvE2spllWTn66tu7nC6bnKaT/m9hMKlhKCfGACHaLLDWH5uCl4eQdK4U8d9zCR8twl
         AbaUBC6g5kOUOfcl/PSSOGu975floWD+meuVMTHk3eH14zMYELHClqjkpQAVyIubzdLx
         2egGSKWFrDldDnkQQNLpcXDOyPtVAxY2tk62tPUi5G1VeT+diQanQtW2k4N3x8bxTu96
         mNtev1n9cKiySiMS28e3kstjs/yewMN+TAxBvORwy1mbkq6J3yT0O+iDUIjCNYCHaObe
         ELiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3GpMEjrnKig0wjvJlpaKRWzsuz4tiNSE6tOiAQiPL9I=;
        b=cm+gojS0xgdXQRx9RnMjes7CusmVZdU63opm+OZt3alkoFhHavEN07WALNjYNeH/Nh
         gY87LFyOCSCj64rCxlFkfwf1vO3NgoMiFbp13h6AamM8F72v4RKU3/bnRhI7DQNUgA+p
         /NgU1yTiv+uoTtRZWGYv16MHhYvjhTTxmVs/ke/CNpsfKJBRCNtGaAG7jQ/MrQf+nKvL
         SBse25N4OYvKVUeAJXn9d2OWG7iX41FktRBPHrJojPq684W/IfxjpK/NKKDaaBxIX8eQ
         Gk1KWIW8zUmI+lorsG1Te+hIZciuvMtGsFkCJfHdjWkjJPQRlpynvAmKkyrSxIg2PwDj
         gChg==
X-Gm-Message-State: AOAM533SgYe+18JvElmReLdoUD/62q41rwB9OE/JxYeBYhFy5DmyJbJB
        rqMGJgsuW6viLwtYaZnZ9j/V1IGRF+s=
X-Google-Smtp-Source: ABdhPJxnHCLWM0yil166UUk072ScIYAIwNqWnJo3mJBntcWBupXMpcQOOhnxZycofFUaNVlpAiBrfQ==
X-Received: by 2002:ac8:5304:: with SMTP id t4mr899400qtn.77.1606162242773;
        Mon, 23 Nov 2020 12:10:42 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n9sm5516233qti.75.2020.11.23.12.10.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:42 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKAde1010512
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:39 GMT
Subject: [PATCH v3 76/85] NFSD: Replace READ* macros in
 nfsd4_decode_copy_notify()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:39 -0500
Message-ID: <160616223900.51996.7580313898551643348.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 501a2c3a55e3..196bb9bded3e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2032,25 +2032,25 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
-			    struct nfsd4_offload_status *os)
-{
-	return nfsd4_decode_stateid(argp, &os->stateid);
-}
-
 static __be32
 nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 			 struct nfsd4_copy_notify *cn)
 {
 	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &cn->cpn_src_stateid);
+	status = nfsd4_decode_stateid4(argp, &cn->cpn_src_stateid);
 	if (status)
 		return status;
 	return nfsd4_decode_nl4_server(argp, &cn->cpn_dst);
 }
 
+static __be32
+nfsd4_decode_offload_status(struct nfsd4_compoundargs *argp,
+			    struct nfsd4_offload_status *os)
+{
+	return nfsd4_decode_stateid(argp, &os->stateid);
+}
+
 static __be32
 nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 {


