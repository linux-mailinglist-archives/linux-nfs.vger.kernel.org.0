Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7218B2BB748
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgKTUhW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbgKTUhV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:37:21 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707DEC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:21 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so8073143qte.11
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GPhmJsGKzDUodUdVm/UjifD+Jhuy6o1walNgIr5fpcE=;
        b=JSdW+diZ/rhKLLJKcKdrHjj7CHP4CPWYqunoTGUPd7cK52dEKRxgpA/TGQkaasOE1o
         x4UKZiXt5FbWlMZvmOVXtk6QbNk4HvXQKICVISblDFyujDBUpWJf8SJHiOQ8gkkkP/qS
         HPh9wdZ7NotwyzKTh4qwS0ud/ugpE2RkaOml34CJKz94JhHbv8cbV6jrKyXsjUrJ4ZcK
         jyaxXiMUa8uvIHh9qrd2KOHhQq1L+ppovHMT+tlqREuvYxL77YahZOZN1CkYKuu5gjai
         GBtlbK2rt7E19fRBRJZ7BPftTo4a/tGAqSHVcWWdO2T57tm8i7CRB+DIXBy7Z5xor8sy
         BDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=GPhmJsGKzDUodUdVm/UjifD+Jhuy6o1walNgIr5fpcE=;
        b=hbQ0DR5MuOcIVz/K9Ff6BdZCt6fmqC179JXMXogvZyNwKjHjiaGUKr1f2UKtuTv92R
         RPIv/1eOz6c+UPTzW8Ksi+0gqT5L/PsxQ2NI7e+ZovPcnlTzrHNHTxu1QfxC42H3m/E1
         9djG6YSRTUEs4K/u4RqWj7TsenTESLRzQW6CjTGiQ3k28R9HADh7FbC7Su9xDV9d6vEz
         oAAUcmkZRuyxDq+C07UMFB5k3ROmcHSCaY/qDH58porfJiFwPdKRJqi7812l2NnzQvcQ
         jE0TDY3yVYdLMBMc1m2ZrI1+LWcqLTv/jPqssLR+P+Y5LZqum3dGTohQ1hJH56dRgARE
         Gnwg==
X-Gm-Message-State: AOAM532MggAyYtD/XNZZ5ZtCb5ntbH7UIq++z9nVkSgMLO0AUX7ZMjNQ
        XAJ3gjvHx9O8adENWGXhK+02mQ0le+k=
X-Google-Smtp-Source: ABdhPJx/mJTuSKFZ2defYkYC0oBEXmRpWWJ68GBxk3SC2oTi7AcjtRrIyFwdrf739Kxfy9hhRcyHOg==
X-Received: by 2002:ac8:5a04:: with SMTP id n4mr17696931qta.21.1605904640431;
        Fri, 20 Nov 2020 12:37:20 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n93sm2778505qtd.7.2020.11.20.12.37.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:37:19 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKbIAY029322
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:37:18 GMT
Subject: [PATCH v2 040/118] NFSD: Replace READ* macros in nfsd4_decode_read()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:37:18 -0500
Message-ID: <160590463866.1340.12761184072054399647.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1f06101a3b36..ecc922cd5d29 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1164,16 +1164,17 @@ nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
-	DECODE_HEAD;
+	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &read->rd_stateid);
 	if (status)
 		return status;
-	READ_BUF(12);
-	p = xdr_decode_hyper(p, &read->rd_offset);
-	read->rd_length = be32_to_cpup(p++);
+	if (xdr_stream_decode_u64(argp->xdr, &read->rd_offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &read->rd_length) < 0)
+		return nfserr_bad_xdr;
 
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


