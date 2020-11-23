Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824222C15B2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKWUHB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKWUHA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:00 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ABC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:00 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id d5so5319681qtn.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iN/sh8i2iCDijW27Jc/LaAyoKa7EvmxTyzzCXonMtz4=;
        b=cLjlvtUo4+3OoGHkBTlhTyOeWd7i6Gjxynt9/O+gxjjnRMZK7F3PTAtXLCA87palsy
         7uzai/zMmjW9n3Jzo/Bvnb26POtAt9UXAIrYsJ+ULIOpt/DpTVbcGr2QElB3d7cP8YtR
         e+qrsYGy+wYZmFkLUyy1QqdbBULE2Le2IyIitDxxvLoq7IqR2GLHUhn1c+IAWLQ6tcMu
         bhaMczNs8Nn/vs/R2gCff0zA2kHvR81HhUqqOCf/O+XVjGSpxrIhAUb6lWj/MbPIXuCI
         yAd3LeIxwXsFNo6VxgElo1RVtHS0W2nvytyLIaUZWo1Xd2XRGkeOWZw03DqBCXQPY3iJ
         0XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=iN/sh8i2iCDijW27Jc/LaAyoKa7EvmxTyzzCXonMtz4=;
        b=PAa/Yy78a/sywskUYcGUNOi5xxI0W9STgsz7opbmiSEF8n07dwmCiLn0mLqynLehVr
         J1DQHp8qoTyNELeRdMP6jPcqGEoBlT5tTifHEyYicXEAhikSwboF4aXGxJWjoKPlMkaX
         aj813bByae1pjaw5LfqreipN1kFmFZQkN5Chl8CXrLNeL2q3EVXq7BjCsKtkEQY5HbSe
         CCJR097p8wPISNFMipHyKt1bJexXdrX/iL7B1DPZoQ5sFEU7c9HoSi6NXPgAOcP7IZPl
         X/p9mldwhoQuzM8vitLxhSMb0n4Nye3Tf53GxbmYEh32sA1X0Gg2/v5HndMkGmfGPZNS
         lx/A==
X-Gm-Message-State: AOAM532a8Q9yi/BXM7Ry8QNJiINqus9MFO6oM3e84Nq4SHTsFRy2YOHr
        +hb0rlxM2XY39ZHFWR9xyj7PkEVCkI8=
X-Google-Smtp-Source: ABdhPJwLWa4FgmHKg+If1kWQXc2SLX0b9ocL2+oMUI7QcoBfGdZPadsoOOsGp8EflX/oJHO4mFDDmw==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr911089qta.158.1606162019663;
        Mon, 23 Nov 2020 12:06:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y3sm3991768qkl.110.2020.11.23.12.06.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:06:59 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK6wUL010370
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:06:58 GMT
Subject: [PATCH v3 34/85] NFSD: Replace READ* macros in
 nfsd4_decode_share_access()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:06:58 -0500
Message-ID: <160616201825.51996.13280386626905277864.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 192bce6d359a..b1a4d3b85900 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1012,11 +1012,10 @@ nfsd4_decode_openflag4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)
 {
-	__be32 *p;
 	u32 w;
 
-	READ_BUF(4);
-	w = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &w) < 0)
+		return nfserr_bad_xdr;
 	*share_access = w & NFS4_SHARE_ACCESS_MASK;
 	*deleg_want = w & NFS4_SHARE_WANT_MASK;
 	if (deleg_when)
@@ -1059,7 +1058,6 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 	      NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED):
 		return nfs_ok;
 	}
-xdr_error:
 	return nfserr_bad_xdr;
 }
 


