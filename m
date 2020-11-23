Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0352C15BA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgKWUHp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgKWUHo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:44 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D99C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:43 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so14312225qte.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Sr3uwFR9iosTze7hdR8yTyexnyjD0P0CfGcmiL2mevw=;
        b=FiiAjPHpFKR1/suomOof9Y3xD2477AOxOQJ4OwZ3F8NF1QLXYwOxL1061PD8cuExK4
         NMAHIx+S4wps7EHD8O/pdi/wQZmyBJQpiPGhHBh/LhoD3OsHR/vW/C8uFTdXQ5bBPycn
         Qd/Q/7TkyNwZMQ9U1s/PbRV5pSmzEfwr7NRE+XZGtrIsH1tog/Npvgi6sxZsFs+IFWEH
         2epCKvK8HzaJZF8IA/5LdgorRqSb/7JMuvpBRE/i5FcwAp+ZoT2p5fTY21PZfyU6rA9U
         CVqpGuY4r+7KnFmHOtHc1dIw5tG28dhxCJmb+zK2b7kKWQnSvffExh0lenMsNBTNLRJE
         uxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Sr3uwFR9iosTze7hdR8yTyexnyjD0P0CfGcmiL2mevw=;
        b=DUIRbNYdY3GULIMeT46yAGx1B7nfg2ljOQSu1FuV/mzTXNi4ie7ui0DLSgR88VaH+y
         Fq5SbAB9wwKdNeS899FFEnuzwVGapFtcj39PvzjYLYnlgaWtGsE5GKmo0Nq/MVnWyS9q
         9w7q2BuVOnbvHqXWZpgchsRBz6zODarqjXg+u2QLj5R/nj3Cz3h9A/IOBQWpLhmFI8vS
         Z2sfWNBdwvBhVW/TX2Qdj8g/Sno5jxD6uBoPeEsSb0dJQ5CDIpS8WNPA2JF8GivbcYDs
         AU4anVTLLogo3AQ8WDHIB7IU9PV/OzQaczAybPfRjNQaM2GvAEvndCjAP+qjppf5L1V9
         vlIw==
X-Gm-Message-State: AOAM5304nKUTHq1M9AcAAwB7/vWj0Kr0IDk24ReYGlGrJhefNBX6v5nD
        lNz6vzHjxcUKnw6qxzT6FkqY4Oqpm+k=
X-Google-Smtp-Source: ABdhPJzb5UmgkL6W3Hlh45ZB9DWNwbN5qNrTUM0ko+qYiklBXO66tgx02t8lHPxbdkw0unf0mgpSZg==
X-Received: by 2002:a05:622a:294:: with SMTP id z20mr814041qtw.321.1606162062029;
        Mon, 23 Nov 2020 12:07:42 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 97sm2773835qte.34.2020.11.23.12.07.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:41 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK7eLY010394
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:40 GMT
Subject: [PATCH v3 42/85] NFSD: Replace READ* macros in nfsd4_decode_readdir()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:40 -0500
Message-ID: <160616206035.51996.3142711628398562358.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 804c0ee4c308..6f10692452cf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1234,17 +1234,22 @@ nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 static __be32
 nfsd4_decode_readdir(struct nfsd4_compoundargs *argp, struct nfsd4_readdir *readdir)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(24);
-	p = xdr_decode_hyper(p, &readdir->rd_cookie);
-	COPYMEM(readdir->rd_verf.data, sizeof(readdir->rd_verf.data));
-	readdir->rd_dircount = be32_to_cpup(p++);
-	readdir->rd_maxcount = be32_to_cpup(p++);
-	if ((status = nfsd4_decode_bitmap(argp, readdir->rd_bmval)))
-		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &readdir->rd_cookie) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_verifier4(argp, &readdir->rd_verf);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &readdir->rd_dircount) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &readdir->rd_maxcount) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_uint32_array(argp->xdr, readdir->rd_bmval,
+					   ARRAY_SIZE(readdir->rd_bmval)) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


