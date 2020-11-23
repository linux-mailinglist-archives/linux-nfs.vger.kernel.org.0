Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1215F2C1637
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgKWUM1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbgKWUJ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:59 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136CC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:59 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id e60so5144104qtd.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EG/wCVOkuiphrscXqgnH1HwcG1Je9yojXWv45ccupxA=;
        b=Tz+rz/b2i5KV7RS3zNmdXS5jV85rxgBCSQwemktecb+Z5Bo2TlO9QDTLvQnPokuj2T
         FX+LAAY2t7hBxCbxUValeCVeioR8bptoVRxZHAUryQJ9QTnbEYQSl0hrMm0pRwg7F4ZK
         gZf2rH/U1gu0uAgV4GSO3SIWu6g/0dkHle9ssX0DeGoZ2JBVg7o5zUlUxM8pWajM5gm0
         0aOxJzdf/ONaVnN/e/5luzaVn8iF7tpfp3yBUP+T9fQr9wgFH8saLWlQJc2W3Jr9P/1Z
         i6w2K5xDuvsGTB2p10AoAs+fGtt4azAn5JJXaiHQY2nd+SZYutdosHk/cArkDjU61T8X
         ZWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EG/wCVOkuiphrscXqgnH1HwcG1Je9yojXWv45ccupxA=;
        b=uTKPwmu56ikqLSgH8Ug8s+FGeViHZyjCJUtRCzLxbqv8CWvZZvnS1ZH9FoJDs6XpGS
         lXKDQqdS24JjzrqMLTa3GJOucrVWjNztnPotjl2YLLPQuaIme/igOEe9SNkGZmxa/TvF
         n8SrISI5CC8AiwcG+oHvMJjljafA8VVtGKLI5XWE4H0NU3AoDSASd1+9Hw92WfaI0+d3
         qjNOYeHRZTI1dhc5HXkz8FgHCssXdzAWXEUUf+U6+t8mUx7PyBULjy2LM6CVhcA+deBz
         Yv1Nazlzblif2P1Wj7n2sEOFTi0g5nNYOZ9j94Z78w43BaJ1yhAuW96StRNBjhWd1eFJ
         sSjQ==
X-Gm-Message-State: AOAM533JtHoHOpULSvMgpBqXcc/JflQ84TKYz35Iq1JV8sdFczsTQGIt
        Kp2/2MqLckaQ+tnmChbodkt2ddIsgxE=
X-Google-Smtp-Source: ABdhPJxSDWn8c5HWqu36u0TR7USfdkrEo+Q9qOMuaB2L/x3Ae/VaRue2LPyVl2tJI7cHhvU5lE7qLA==
X-Received: by 2002:ac8:7306:: with SMTP id x6mr917087qto.272.1606162198794;
        Mon, 23 Nov 2020 12:09:58 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v6sm10328697qkh.83.2020.11.23.12.09.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9v41010480
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:57 GMT
Subject: [PATCH v3 68/85] NFSD: Replace READ* macros in
 nfsd4_decode_secinfo_no_name()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:57 -0500
Message-ID: <160616219716.51996.10655963479904967000.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f93a0b9f202f..903abb421e88 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1356,17 +1356,6 @@ nfsd4_decode_secinfo(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_component4(argp, &secinfo->si_name, &secinfo->si_namelen);
 }
 
-static __be32
-nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
-		     struct nfsd4_secinfo_no_name *sin)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	sin->sin_style = be32_to_cpup(p++);
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *setattr)
 {
@@ -1918,6 +1907,14 @@ nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
 }
 #endif /* CONFIG_NFSD_PNFS */
 
+static __be32 nfsd4_decode_secinfo_no_name(struct nfsd4_compoundargs *argp,
+					   struct nfsd4_secinfo_no_name *sin)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &sin->sin_style) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 		       struct nfsd4_fallocate *fallocate)


