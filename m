Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28BE2EAE7C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbhAEPcw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbhAEPcv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:51 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B5C061796
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:11 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id g24so21035410qtq.12
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3nFJIYWhVtrrUM/ZdvK/2KGGilj1b7V6qT33oh6eBgI=;
        b=XdoDGy4Hy12myG2u1CNeqtoAlRLYdbgVO2pt9CFA4I4GYj23fDdnXqO9u0BiVaumu6
         Uy29QO7alBAgg5064lOxZLR+oMk2VG4P5Jh3SKG7DvTA9C6nKd2GE35wLoAm+nx2sBst
         i2S0azXEj3VhylttUQwpK/WI3Kvf+xSOuG9enZIldD/+tAPdmhfWY6v3P8/2BfXFCe+R
         fzNnAYrUWkZggE9bTJB2wBG8wS8HTOtEjRBqOUhjUBCOU7HC9BFkLSIS2WCFxvhgMIY/
         9NC8wqglIQKBMqnVIMPhArID31AruFAhV3qbCHzW3PwACFq2p3HlZXTaoZrrrlJQfyuG
         MlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3nFJIYWhVtrrUM/ZdvK/2KGGilj1b7V6qT33oh6eBgI=;
        b=Fm18tjFVDNh8IjXiDfNFdzma8cltwwHxsjdpQzAKOJc0MD0Be6WUObfQsEL19V942w
         03zS0rlDY1m7VnL4tFxCvq6HzllsjeP6kUhr3+h5v953hUAt9oppH7ZM+OlVT8l4PeyY
         L2NxcroodVlSja86HqVsjzxkuX0g2QeeiwKos/eCTbxmmV/+y9xvwEwmiBKO+8pDlm2V
         FTMkRCP988l+IcTdsNRzfeEvtbJnI/z8r+c6yGEFVR/2yaOQw+nTnF71HHF0b6Lqq9V5
         htG7NRLYvisExk2w0ZoS9c3D/zVds4/G0GMEFvL8kC827yxicYBcrmlHGH1FR+ZOmjZ4
         2NRQ==
X-Gm-Message-State: AOAM533xyRq//dQlerYJc7MCYnApc1lQbCCDp8Jc60JkqwOpId3eVi0g
        kddwW09od4VM0Zp4hJpnAhJuHr4fkac=
X-Google-Smtp-Source: ABdhPJzI2tyGwcAOxBAyWLlSfDDLfFR4wVYwUcH9d1M1M2YATWTpw+Ni/YVcQgtj0BXliGyLv/Ddcg==
X-Received: by 2002:ac8:6910:: with SMTP id e16mr8123qtr.329.1609860730292;
        Tue, 05 Jan 2021 07:32:10 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 127sm150138qkj.51.2021.01.05.07.32.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:09 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FW8Nh020904
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:08 GMT
Subject: [PATCH v1 28/42] NFSD: Update the NFSv2 RENAME argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:08 -0500
Message-ID: <160986072853.5532.3411194354875648394.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 00a7db8548eb..d4f4729c7b1c 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -344,15 +344,13 @@ nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_renameargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->ffh))
-	 || !(p = decode_filename(p, &args->fname, &args->flen))
-	 || !(p = decode_fh(p, &args->tfh))
-	 || !(p = decode_filename(p, &args->tname, &args->tlen)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs(xdr, &args->ffh,
+				       &args->fname, &args->flen) &&
+		svcxdr_decode_diropargs(xdr, &args->tfh,
+					&args->tname, &args->tlen);
 }
 
 int


