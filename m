Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C0D2C15A2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKWUFg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKWUFg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:05:36 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B41FC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:36 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id e10so6886734qte.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xafRn5urN93n9LRvMuxvvqgG7plRSgQmc2iMcxZO/wY=;
        b=O7GP10zZoXQ3p4XP/3xp135RncMCAhpR2Ptj/mk2oMuR2bgRgcuDHKU0Si7TXgyz2V
         LnR70gQINwft4UCvMbmMxhVEohMqRqUyoTpdmPVrv1fs3N0q7HBnAjTR/dtVbIMm6/EH
         KGkEc/YJHo0KNdVpXEnb7W7Eq4984SinuLjaiieu6Fd2MBkxMluMIKLlEBvTCdbBFiE/
         ahaXkLzb34NggvRWSsgtafePjD7WMq3K+mkH4NM/NIqTbQ285zSqzZIOCBq+6NqSdb32
         TKo/3XmvrRTfEbMFws/ZPGng23tsjFQW1NZ5i1XDUB0oTC4DL3WUwmOFOw18VvUiZvE7
         yx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=xafRn5urN93n9LRvMuxvvqgG7plRSgQmc2iMcxZO/wY=;
        b=qcJSQy66y56g13cc3i42vRvYwfVfJfeO3gtPSJx+qVabLqIDCFkHSCdB0N08tITJbr
         N2+qFQNENHtcXi/NFgZsnIQsIlAFVo4fw/tL4uvk+QTYYbNRlM2Z2ePDkU1qdkK2iwRG
         BkAooAvb1aMy+OpFpVHQ3Mw7vedBkYiuKamjaFwTB0z5PgfcJmwmim0xjn0xZd2ONj3+
         Z+mjvoXR0J74lDbfcHaI5KVbg77hQQEQehdIt+TRK8q5HdH1tZaGTFHLNlxzV77Uo0nm
         L0SQEpKx2XyONlc3ww55MckAe19KzNz1diTP1CGh/PdJUKke4D3BnU+CBiKwl79Ce71G
         hFUg==
X-Gm-Message-State: AOAM530+FQ3MzDJpfUXXJt62i/yerXsIFDoi6UYdQ6vMMj6+dGdZTlnD
        os+ddWvdNbqYpfKcNUsOqZV2/y5lj8E=
X-Google-Smtp-Source: ABdhPJxmszNDXjgomehHr5ZADQrG+exndiq1JGj1SyobWv7fZCfg41JKrrHGnmh3jlwi8FQJ/9VaiQ==
X-Received: by 2002:ac8:47d0:: with SMTP id d16mr862424qtr.125.1606161935309;
        Mon, 23 Nov 2020 12:05:35 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j17sm10103278qtn.2.2020.11.23.12.05.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:05:34 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK5X57010322
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:05:33 GMT
Subject: [PATCH v3 18/85] NFSD: Replace READ* macros that decode the fattr4
 umask attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:05:33 -0500
Message-ID: <160616193368.51996.3435896308145544488.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3844bbb7aaa3..54481804a096 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -358,7 +358,6 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 {
 	unsigned int starting_pos;
 	u32 attrlist4_count;
-	u32 dummy32;
 
 	DECODE_HEAD;
 	iattr->ia_valid = 0;
@@ -474,13 +473,16 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 			return status;
 	}
 	if (bmval[2] & FATTR4_WORD2_MODE_UMASK) {
+		u32 mode, mask;
+
 		if (!umask)
-			goto xdr_error;
-		READ_BUF(8);
-		dummy32 = be32_to_cpup(p++);
-		iattr->ia_mode = dummy32 & (S_IFMT | S_IALLUGO);
-		dummy32 = be32_to_cpup(p++);
-		*umask = dummy32 & S_IRWXUGO;
+			return nfserr_bad_xdr;
+		if (xdr_stream_decode_u32(argp->xdr, &mode) < 0)
+			return nfserr_bad_xdr;
+		iattr->ia_mode = mode & (S_IFMT | S_IALLUGO);
+		if (xdr_stream_decode_u32(argp->xdr, &mask) < 0)
+			return nfserr_bad_xdr;
+		*umask = mask & S_IRWXUGO;
 		iattr->ia_valid |= ATTR_MODE;
 	}
 


