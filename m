Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602442BB71E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgKTUeV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgKTUeV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8D1C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:20 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so10158593qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=meH4fCLXyngkR+1OJ/A3X63+mI0F3gkdAnX+tussGLQ=;
        b=bR/S5KkWWxkLWgKg1e0XJLM76xmI8uKedGgBmV3T75j4IidG1zMYVTKG//oPuNpUmr
         uJITjgvMsE6i2K9CVvqTZOWEYC6lqhQFmw4eXt2GSyudAr/YKp3Yzq0O3apjcUluIabl
         eer4kVoiuDXJGG9pf4jCD0+Y9B6mmvzS5rlrsuMy65aAjFCLrNDDtXTXIlXTtjVxl7ZY
         +wJRMGWEb2LbZ/VyoIkgRLb2Xjym1bkH0b5bpvJc5tfQXgLgNP82xcz0aZgfj43SC7Kk
         M5iPwELNIFbXfKWM2Or3tOUcK81Q6360CW4PFcN5k3CakFp4fmI1IW11IxGMxsyMUH27
         AUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=meH4fCLXyngkR+1OJ/A3X63+mI0F3gkdAnX+tussGLQ=;
        b=GCzgaZFYrIyX2eTDaQkMekDvA9UxeTIbhw2/CyTh7iLtzY6AOAElQ39lcrekozJAI2
         S2bHwS4hfoFS79pI5ZbG4qiBZMXeefQXS3FNDQSfZigX9W16rL12+7DbalL2nTCr6jmd
         xmvSwzP/tDLD0y61ZlDt9q4IyXbQctsP8YdRia2+gb0sp3fCYxUtN2Xff1jr8W+b0r/R
         0sh9Dayb/ewpGYd5hFQdnFte75eL/+MIsMk15HmO8tzggwOqD/jwaNjGtCHDSS6Oz44H
         BUOp91Zt7ivO0M9ZaNNvJgXBoDfyXEtOVNmJM4d3Ec3m7nni2hBBKSLvCc5O0C/6tQJJ
         2swg==
X-Gm-Message-State: AOAM532ycSC83R6e4TItH7bDHdYhhwUOjtPJM0dniWddQaExxtcedUva
        o7bfzxjhzA8ia4PGSl0DKIW5FMt3I2E=
X-Google-Smtp-Source: ABdhPJzD3TwCNa+1jxtUL9mYcI6gv2jzCTD+oIruzCTfssbKoErLbqMHWAXLBHTOo0PQ5rGo9J8DtA==
X-Received: by 2002:a37:517:: with SMTP id 23mr19171382qkf.333.1605904459743;
        Fri, 20 Nov 2020 12:34:19 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p188sm2804106qkb.60.2020.11.20.12.34.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:34:18 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKYITm029220
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:34:18 GMT
Subject: [PATCH v2 006/118] NFSD: Replace READ* macros in
 nfsd4_decode_access()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:34:18 -0500
Message-ID: <160590445804.1340.14356465427456109514.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 26265d649c39..5ef14c41fabe 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -437,17 +437,6 @@ nfsd4_decode_stateid(struct nfsd4_compoundargs *argp, stateid_t *sid)
 	DECODE_TAIL;
 }
 
-static __be32
-nfsd4_decode_access(struct nfsd4_compoundargs *argp, struct nfsd4_access *access)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	access->ac_req_access = be32_to_cpup(p++);
-
-	DECODE_TAIL;
-}
-
 static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_cb_sec *cbs)
 {
 	DECODE_HEAD;
@@ -529,6 +518,19 @@ static __be32 nfsd4_decode_cb_sec(struct nfsd4_compoundargs *argp, struct nfsd4_
 	DECODE_TAIL;
 }
 
+/*
+ * NFSv4 operation argument decoders
+ */
+
+static __be32
+nfsd4_decode_access(struct nfsd4_compoundargs *argp,
+		    struct nfsd4_access *access)
+{
+	if (xdr_stream_decode_u32(argp->xdr, &access->ac_req_access) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
+}
+
 static __be32 nfsd4_decode_backchannel_ctl(struct nfsd4_compoundargs *argp, struct nfsd4_backchannel_ctl *bc)
 {
 	DECODE_HEAD;


