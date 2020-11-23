Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC92C15F2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgKWUJu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgKWUJt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:49 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4117AC061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:49 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so18216782qkc.12
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=P+qpi3cGFXou6Kf66J1L1VKL4vJuQ963lSpVMW2TZ+A=;
        b=Wvr6uL29sb2fceIDT4XXJ8WCHIg5NmxcbvDM4pb96Y0ifhAyFVoDo+qzRdh3NXX/I0
         IyUaS8hYgDDMg9K6s+IzZneFiDpvtfLaY5gdEnfPkMCvALhMUNQ1RaQhTD3kGuAxUPj7
         FfqvXgIOvQtaSagE6ECPNWL7fBmRjBc7N0adaUFXYzwgq4GszJwvLu5BD45+iMeRTYHs
         GOEGyClGBgnF3se3D08xEBC1dT4giaLxD+rNSuBPX5m8qQ7YznIPq9QKW3Sb/oxK4gni
         8XN4jdo6oBUUp3/fJtqwGaeBLcgFAg26xsqMyJIGUucT2rEPkMSrDcqStMXs601CbUad
         oy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=P+qpi3cGFXou6Kf66J1L1VKL4vJuQ963lSpVMW2TZ+A=;
        b=Uurp1+osSqbsm9BIbop6/0PieToXXHap/tl25uN5UO+Rvm8Z+5VPecJyC4QRSKi6rn
         8QhS8XO12SEmcitvjG20OiSq93bECL0lGGh7mDXj1DLgRcrJx78y5I5t6QATi7hcWJE1
         yHVgvnASR0eIDk/18JXpK9tl+dgzJ/UBV7FfoQP7KIiYB5X7Js8dULlO8a2PHgsH7WIB
         BT+QVGBb+qjMcZLdpbBZ08myWNTF3q4cV/Hl062+f3U6SGONBlFrtWXZ5gkPq1v9pts7
         EXjgALgcNXxhqmELQm1VpGLu9i75i3nFL2qxOA68LDjzNBQrcIdPYMknF88nbQc1mKvy
         zmRw==
X-Gm-Message-State: AOAM530NfZzXBMUqoEvP2WgMnXtDvm8T2MuPhsEicHM5NEteXx/NhRTu
        4eWy9dTVUMXrJ4XDiUWKm6ScAgB6Jvc=
X-Google-Smtp-Source: ABdhPJwnhlCAEi7hcIuT8RXc2JtAf9E8ZrtaYVFHpbUofCqek0X/xdPTnfJSZkG9E43I5n6STUgrbA==
X-Received: by 2002:a37:2790:: with SMTP id n138mr1165583qkn.324.1606162188210;
        Mon, 23 Nov 2020 12:09:48 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n9sm5513807qti.75.2020.11.23.12.09.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:47 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9kZY010474
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:46 GMT
Subject: [PATCH v3 66/85] NFSD: Replace READ* macros in
 nfsd4_decode_layoutget()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:46 -0500
Message-ID: <160616218659.51996.9574327474130071630.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4xdr.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index febdc4b10e13..89b5b919beab 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1844,24 +1844,27 @@ static __be32
 nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 		struct nfsd4_layoutget *lgp)
 {
-	DECODE_HEAD;
-
-	READ_BUF(36);
-	lgp->lg_signal = be32_to_cpup(p++);
-	lgp->lg_layout_type = be32_to_cpup(p++);
-	lgp->lg_seg.iomode = be32_to_cpup(p++);
-	p = xdr_decode_hyper(p, &lgp->lg_seg.offset);
-	p = xdr_decode_hyper(p, &lgp->lg_seg.length);
-	p = xdr_decode_hyper(p, &lgp->lg_minlength);
+	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &lgp->lg_sid);
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_signal) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_layout_type) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_seg.iomode) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_seg.offset) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_seg.length) < 0)
+		return nfserr_bad_xdr;
+	if (xdr_stream_decode_u64(argp->xdr, &lgp->lg_minlength) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_stateid4(argp, &lgp->lg_sid);
 	if (status)
 		return status;
+	if (xdr_stream_decode_u32(argp->xdr, &lgp->lg_maxcount) < 0)
+		return nfserr_bad_xdr;
 
-	READ_BUF(4);
-	lgp->lg_maxcount = be32_to_cpup(p++);
-
-	DECODE_TAIL;
+	return nfs_ok;
 }
 
 static __be32


