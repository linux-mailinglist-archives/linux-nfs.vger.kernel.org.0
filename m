Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8432B1E00
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKMPDz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgKMPDz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:55 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330BAC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:45 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so9021055qkd.5
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=J7AqVh71RZj2ejlzrSQPwoCvFZG1dyKB9yUnpjupjtU=;
        b=ErXviicww9zgjRf49Q54h4P0hC8t1KwBXqr96rDQmjhq7iK+EUEWt0eQZerXZbBbKb
         1MjlNq1BfMHXft3B1PmTUDjcPqcKzaQX8RdcMceolz4NNUPsEHkXgDtXu9uPuEwK8tSV
         P0QFRoS7PFzN3JxDjeO6UDMRptl81NuPFZtclXKB2LuRSKPwNwx7uuGul5hmQRbKfiFc
         /1JfM0YJCAiLTkfn+HoRqgd2QQeFquEgZq1kzzMVKBgD04mnR2bT4csvcib7szXuIq5J
         eW5pHITwTSfhdx7E7bpiywGqBR1MFproBvXWTE2g0uC7CyUlx+5gg7crJn6G7LQbshY1
         Y+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=J7AqVh71RZj2ejlzrSQPwoCvFZG1dyKB9yUnpjupjtU=;
        b=Lj8CRGQJuy8aRSZlnadrYgawUTx/dDkUTi5e85ewQ7yDb1F6ZnQ3+1diJAkzbvXc5c
         icMIzZDtlTUtvosT0pbbQRbVFq+r8dUTzKa9NOgjzezviyhFwmvuHgU+SQiU1CQxeCC9
         hJSkChMOYEN5gMUXj+F0YI5OXKR/BRYRh9uZfK30i5MNjFvEVRbxsiE0U32xWDXByoDa
         VvELJxPwKrNzUDlCfBrmTEroW1w7jORbd5uE/UX57fVie2SQdFajsUogZFWyrIXVK5lF
         X27lGMRx6EGTIMZY6svGQlXtnAs5Ny1z+tBrQyWQht0HMeimuMAvDLFmbNYDvdI22GqG
         jyjA==
X-Gm-Message-State: AOAM5304iD3HHkkNMlQQ/fN2xvurKN5NgGWUS64fFFFwweYJnjSrmzdt
        rCdspcFTxaoP2qZenfXbLleile6M34M=
X-Google-Smtp-Source: ABdhPJzqRCxUehE0W0ToJc3lOJTTmJW9fN4vWSxsxTHTHj5a+kV6inTDnmBHQvD1BZnjLyaaoddrOA==
X-Received: by 2002:a37:bfc4:: with SMTP id p187mr2305175qkf.417.1605279823921;
        Fri, 13 Nov 2020 07:03:43 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c53sm7530704qta.36.2020.11.13.07.03.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:43 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3g3v032682
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:42 GMT
Subject: [PATCH v1 15/61] NFSD: Replace READ* macros in nfsd4_decode_locku()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:42 -0500
Message-ID: <160527982223.6186.1602052473605619044.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3c4777cb4d38..88a8d002303c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -826,21 +826,27 @@ nfsd4_decode_lockt(struct nfsd4_compoundargs *argp, struct nfsd4_lockt *lockt)
 static __be32
 nfsd4_decode_locku(struct nfsd4_compoundargs *argp, struct nfsd4_locku *locku)
 {
-	DECODE_HEAD;
+	__be32 status;
 
-	READ_BUF(8);
-	locku->lu_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_type) < 0)
+		goto xdr_error;
 	if ((locku->lu_type < NFS4_READ_LT) || (locku->lu_type > NFS4_WRITEW_LT))
 		goto xdr_error;
-	locku->lu_seqid = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &locku->lu_seqid) < 0)
+		goto xdr_error;
 	status = nfsd4_decode_stateid4(argp, &locku->lu_stateid);
 	if (status)
-		return status;
-	READ_BUF(16);
-	p = xdr_decode_hyper(p, &locku->lu_offset);
-	p = xdr_decode_hyper(p, &locku->lu_length);
+		goto out;
+	if (xdr_stream_decode_u64(argp->xdr, &locku->lu_offset) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u64(argp->xdr, &locku->lu_length) < 0)
+		goto xdr_error;
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32


