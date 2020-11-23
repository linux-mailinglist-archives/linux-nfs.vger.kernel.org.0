Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5862C1613
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgKWUK7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgKWUK5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:10:57 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A0C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:57 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id e60so5146806qtd.3
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aW7NIpPvrrUNJmbjwvgOufNyaxmC5aRPCQRaBdxds+w=;
        b=QxSXRT/kN/m1i4/pD4ecoDMa7Y42l9QQCwprhS+xyKqoxl5N8OYwr3N18+n4o2UcDY
         ju6jF2wTrP+R5k3WtjT+mApdBaizs0CR4+jTejv/nL192kd/W+bQlwUzNtRLHZ0qxGk0
         MTCYSZRxQpll2b7vIvRbi2hpmxmnzCrdTZtz1MoVaB0ih+2jy3MRe5zE6sZWGX5ps8GT
         nRuCJaZoGI2VuBO5J7k1WPFcAlZivrJSTnmpOKvb8Toc92TZ7pTXhJ/ipKPNouna4VTx
         8HE7Q0qXhbo3oRPLgF6cXrf7Qo/z0hoxDWGznOcTEAiHNrl+ITqgOLGts+Khud6opfO8
         Kr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=aW7NIpPvrrUNJmbjwvgOufNyaxmC5aRPCQRaBdxds+w=;
        b=rUZmGYoK4vkzO4GPUquY6PpyZZ3cxa6N0w5q2qW9au/mvwIz6VyeLoXcGPMywVbA2N
         zWnz51ZrIdTLmhrLX70I84sSA/CMGf4YOEd20ewf5yITPN/5mFe5xBdDKaEn+Oj/yY2I
         dqJAbHBcolaOIJXDh6pb64eazw7CnGg91pkCbr7JE5ZfAWCwqpTgUiUK3bt4fekcojuV
         NsCx1PjYtGph2IZYe7rwMCKuc7JPyd3bfRN46gOlggfgcDY7e/ypuvfmb8k2e5NHmu6+
         GoCczZqOZgxDNwwldgmTXIcEG7RTRoEemSy3LVMTLapGcGIN5HFELF052zf2A55otAGf
         pWeg==
X-Gm-Message-State: AOAM5312UEB5HgqthVLZEnIrzruM3FCPUzD0w7gT9J6FFh1uYifG7V7b
        iZYrkYJh2M5gVDfoY/HPJ47GfnE4Mtg=
X-Google-Smtp-Source: ABdhPJxbRSqsmPTAitLDYv71bVtu33w7gdTU65/dDMfCaiylEgSDEUEE7K1mucDdiRs19G7ClcQZ2g==
X-Received: by 2002:ac8:6f42:: with SMTP id n2mr909420qtv.17.1606162256101;
        Mon, 23 Nov 2020 12:10:56 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z30sm10549096qtc.15.2020.11.23.12.10.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:10:55 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKAsu4010521
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:10:54 GMT
Subject: [PATCH v3 79/85] NFSD: Replace READ* macros in nfsd4_decode_clone()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:10:54 -0500
Message-ID: <160616225464.51996.16399846881165369712.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   52 +++++++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1401ca744d95..493168608815 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -575,18 +575,6 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_stateid(struct nfsd4_compoundargs *argp, stateid_t *sid)
-{
-	DECODE_HEAD;
-
-	READ_BUF(sizeof(stateid_t));
-	sid->si_generation = be32_to_cpup(p++);
-	COPYMEM(&sid->si_opaque, sizeof(stateid_opaque_t));
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_stateid4(struct nfsd4_compoundargs *argp, stateid_t *sid)
 {
@@ -1919,25 +1907,6 @@ nfsd4_decode_fallocate(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
-{
-	DECODE_HEAD;
-
-	status = nfsd4_decode_stateid(argp, &clone->cl_src_stateid);
-	if (status)
-		return status;
-	status = nfsd4_decode_stateid(argp, &clone->cl_dst_stateid);
-	if (status)
-		return status;
-
-	READ_BUF(8 + 8 + 8);
-	p = xdr_decode_hyper(p, &clone->cl_src_pos);
-	p = xdr_decode_hyper(p, &clone->cl_dst_pos);
-	p = xdr_decode_hyper(p, &clone->cl_count);
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 				      struct nl4_server *ns)
 {
@@ -2067,6 +2036,27 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_clone(struct nfsd4_compoundargs *argp, struct nfsd4_clone *clone)
+{
+	__be32 status;
+
+	status = nfsd4_decode_stateid4(argp, &clone->cl_src_stateid);
+	if (status)
+		return status;
+	status = nfsd4_decode_stateid4(argp, &clone->cl_dst_stateid);
+	if (status)
+		return status;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_src_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_dst_pos) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &clone->cl_count) < 0)
+		return nfserr_bad_xdr;
+
+	return nfs_ok;
+}
+
 /*
  * XDR data that is more than PAGE_SIZE in size is normally part of a
  * read or write. However, the size of extended attributes is limited


