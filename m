Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64506266866
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKSr5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKSr4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Sep 2020 14:47:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1D3C061573
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:47:56 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so10089240qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5v4DY0Ii1ZZbMCFEDtf37Lx0oQgQAcbuz4MOmcCwAVA=;
        b=toji0IhSoExezXBVWiKQLDlojZ46tVRM2tz7N4+PVnMyy9T8f6eL4UCWq9Dbr4PJz6
         SwB8bqVv+rG1Gi31nS+D5zZddkBiUF/PpgXUppDFTDJEqkyH9pMAXksBQQ8wPTouDW+9
         nRbznDKABDonO0vMfqyKaH9vy9KYRjruMUKM+rhisYWzkXra7QBzYhft+wFN76G8hYsG
         D2CU9o04nhs4rV+c/VVaGC28UBLL0Qn/rQSr357C3YhFh44vuRiYMdLUTjMwCyPyhMAG
         t3nQkFIXlz0le7flkoZD9NX75VTl3sla08E2XG5X4U3r3u1cHzMrtHyUMNtLReKTt7H/
         qGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5v4DY0Ii1ZZbMCFEDtf37Lx0oQgQAcbuz4MOmcCwAVA=;
        b=ilk6I/Ap7vTjoVjePmzpjei49rqlqArz69cKttFNf7jX0L5754Ltecw+kLaDBtSMrG
         3qnmV1QvYo0MI5i+ihzSdH5jI8BW1YdXDCfjLxrsf00Yuc7JZ7ePfpI2Kdg3ijS43mfg
         XWE3SsKLULc16RtfjJMs117rE9wPIXn1T0Q5/+h704CPU6GulH0aslrWjgFnRmL9LfyF
         I240cBQgaPz2eW/us1o9Is1xv7YwvnZ90gJZb4KHEs0Mw3cvT3KmQkIcnkrMqpwRlPKN
         OBqb9iGiU/nM25Wwg0pFgIbicgmKMoWlJFxNPR/7XbrkAfaJTRTSEpChHH2VNYYg9SLG
         omnA==
X-Gm-Message-State: AOAM533jCcfuz+4HBkDiWdGMhXROCpo5rvjJhULApYDfm2Ux/4+Bf2Zx
        5EU34Lsg2CYK5aM2bUrNptQ=
X-Google-Smtp-Source: ABdhPJxJobEr1P7yUO4gAsssO5Z+WulZJ8HwmdJVqRlvA42VnAttyfruijMpckcNetQ0NW/XHD0cOA==
X-Received: by 2002:a37:9d8:: with SMTP id 207mr2708428qkj.465.1599850075392;
        Fri, 11 Sep 2020 11:47:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w44sm3980789qth.9.2020.09.11.11.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:47:54 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08BIlrB1000612;
        Fri, 11 Sep 2020 18:47:53 GMT
Subject: [PATCH 2/3] NFSD: Correct type annotations in user xattr XDR
 functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 11 Sep 2020 14:47:53 -0400
Message-ID: <159985007369.2942.4863257585974158408.stgit@klimt.1015granger.net>
In-Reply-To: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
References: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Squelch some sparse warnings:

/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4692:24: warning: incorrect type in return expression (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4692:24:    expected int
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4692:24:    got restricted __be32 [usertype]
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4702:32: warning: incorrect type in return expression (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4702:32:    expected int
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4702:32:    got restricted __be32 [usertype]
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4739:13: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4739:13:    expected restricted __be32 [usertype] err
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4739:13:    got int
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4891:15: warning: incorrect type in assignment (different base types)
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4891:15:    expected unsigned int [assigned] [usertype] count
/home/cel/src/linux/linux/fs/nfsd/nfs4xdr.c:4891:15:    got restricted __be32 [usertype]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f4..400b41b86595 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4679,7 +4679,7 @@ nfsd4_encode_noop(struct nfsd4_compoundres *resp, __be32 nfserr, void *p)
 /*
  * Encode kmalloc-ed buffer in to XDR stream.
  */
-static int
+static __be32
 nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
 {
 	u32 cplen;
@@ -4795,7 +4795,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 	u32 xdrlen, offset;
 	u64 cookie;
 	char *sp;
-	__be32 status;
+	__be32 status, tmp;
 	__be32 *p;
 	u32 nuser;
 
@@ -4888,8 +4888,8 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 	cookie = offset + count;
 
 	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
-	count = htonl(count);
-	write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, 4);
+	tmp = cpu_to_be32(count);
+	write_bytes_to_xdr_buf(xdr->buf, count_offset, &tmp, 4);
 out:
 	if (listxattrs->lsxa_len)
 		kvfree(listxattrs->lsxa_buf);


