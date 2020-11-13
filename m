Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3837A2B1E0B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKMPE1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKMPE0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:26 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8812C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:26 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 63so4710856qva.7
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2jm3lyNLNNzdxiWcwWPLElpEZNMysKxdpGBRD2WvOPU=;
        b=bONI3v7bR7jApb5MRLZX2veCe8Lnb/c1Lz5gH/i7bGSTwJChdR1l/+wj/DLuj+c1v2
         dtvxA+cmyWOv6LOrtvPORN4VqBZ6Dj94DI6NKMNDU6DVHJJhycPZD4daFmf0XhW0MINm
         UpR2ylmSAMxy++3xNbGtMbApNiMYRRByEnoHN1xn5aySdCBWUFuuAciMpDCorWZx5woq
         e1pHx5WndhmnWx4Ft1Z8P2kFaLqB8Hv6vQp2wHwuSlGfFsDSJ+SbQVe/COlxHZMbsEA0
         U0d7FtioGQEz4osz8BaDRh3b946V1RPN94SqzPR/AHJ6f85FVcbJNEpBnxVpjWwswolp
         d4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2jm3lyNLNNzdxiWcwWPLElpEZNMysKxdpGBRD2WvOPU=;
        b=FGKIZ3UsZXk0q1eMQPS/BPvA0Ny+KGuQW1PaW/4wOJrRH+wjZ76z/RpSDDDJ+0E/58
         7cvvneUYETKyhexwH5MUa7vWXa/HTw5+JJfhTb/QN06/taDU3mweB7TpIBSdQ4fkXNpt
         NNrwBIiwxf9VJ/vbdHGJoli7GsFfrz37fHZ8TWdIkWfQcZHFKdgqluQ56IjwhU8rg4kr
         hHEGRiuUsTchxd2Qge5lYjDcFwnjC3pnTe0JIfX/rKlWDBSDwrPdHurlO6WjI8Srz8/a
         nGoWrXVX7In7RaL4hE5soJtpChWSEfiEkx5oSOZPucc9mUBTWT0BPWSmhSn1Pg6035qL
         9ByQ==
X-Gm-Message-State: AOAM532rD4Pys5r/aNCVBBStcCxQewKTkRweHREDzDKYTDML0+EAjvL8
        LmoiKKFLrNXCwy0lr4IoQvTcWOgDnXw=
X-Google-Smtp-Source: ABdhPJxOOHZ22CMZEC4JQjlgcd9g4YOQzcq4EQwHKacOHisRflt7TzUInNXeDCYbMBj35cQ5JcptXw==
X-Received: by 2002:a0c:e0c9:: with SMTP id x9mr2832613qvk.56.1605279865588;
        Fri, 13 Nov 2020 07:04:25 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t60sm6429360qtd.65.2020.11.13.07.04.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:24 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4OYr032706
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:24 GMT
Subject: [PATCH v1 23/61] NFSD: Replace READ* macros in nfsd4_decode_read()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:24 -0500
Message-ID: <160527986410.6186.10864335028888611330.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c7f4040efd40..1f00fe6febf9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1177,16 +1177,21 @@ nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
 	if (status)
-		return status;
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &read->rd_offset);
-	read->rd_length = be32_to_cpup(p++);
+		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &read->rd_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &read->rd_length) < 0)
+		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


