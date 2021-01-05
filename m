Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C552EAE80
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbhAEPdI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbhAEPdH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:07 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA2BC061795
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:26 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z20so21056735qtq.3
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S8lZyaF5q5GnNU8MedRayrJcC/pOoyE3fWkHFZYR7QA=;
        b=AGV68fj5R91xRVwKOLSobRdbcYOa7CanOh2acQJX1UW9AHuz2RbiLTTFok7JkDPOpl
         zYLOUaomO6w/tMtVY2PSJvXm+evBWrbkzVJ4fIOM5SauNXYJ73jz9LOSCsN6aNdLLXkr
         gyVnQsuI/8IHbVbRw3keEFyfrF/ssfLEH7igGqO3OVbRvA4ItWsIgWlmSMWRbADvKMbb
         56nG2Tu0d0W6qclHpK3tIjuYFE+1zEvvwVGL+XozBiXhXxaJ3g58vK5OTI8x+T9Tim/s
         2KPk0riQl4O85R7l0hj0YmscGHngKyrWp0GdnXKoYlZ6eEBRifLkkGQFSKfvzINZfjaP
         +pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=S8lZyaF5q5GnNU8MedRayrJcC/pOoyE3fWkHFZYR7QA=;
        b=Y1PcIfOnJyElppi4bBg9JRl2nAmcK9KbDIq9op9IBpG6Q0lO3uWa1Q18WtCxtyA3IO
         tTiil4E6+LD8iv9mTKusp9jyz7nCAUz7qUNZq/t0VUj6yTr4figzsWDXLjsSOtja5E90
         v9HvSUzT21eCsPHbnQS8zvqCVgDdqmTmgaNBs4N700Fkj322yn2ckE2YkQcGEDt9N34G
         ZpCExjt8iFEhsYSRGOjsOOZmOriXkWML3TAC3BF8nX4yyGqaI1hgr1qic+4dZCQ0apaX
         PWFMpnC2cujMWUODPrDjmxdH+MQNOSPpCxYYQVNzXNKPEkn/NB7ViKwPMbfVOEzJZBaK
         /iRQ==
X-Gm-Message-State: AOAM532P+dt1lZ/S/fNJZ1sGMrzprHhmU2gpz4gHeZK+VRWj0XSrh+vB
        W3geBsNVlXaZBLbhLMB6h8JpMRa+Zj8=
X-Google-Smtp-Source: ABdhPJzhD6fBzxya5VwNxgrxUhygORp/7BhDjhZlm3lIFkxxw99g9qf/ZbIEJgI+H2HtxvIdChiotQ==
X-Received: by 2002:ac8:7510:: with SMTP id u16mr32285qtq.139.1609860745916;
        Tue, 05 Jan 2021 07:32:25 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j142sm133879qke.117.2021.01.05.07.32.24
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:25 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FWOlW020913
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:24 GMT
Subject: [PATCH v1 31/42] NFSD: Update the NFSv2 CREATE argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:24 -0500
Message-ID: <160986074438.5532.3292569454405268867.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 6c87ea8f3876..2e2806cbe7b8 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -401,14 +401,12 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_createargs *args = rqstp->rq_argp;
 
-	if (   !(p = decode_fh(p, &args->fh))
-	    || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-	p = decode_sattr(p, &args->attrs, nfsd_user_namespace(rqstp));
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs(xdr, &args->fh,
+				       &args->name, &args->len) &&
+		svcxdr_decode_sattr(rqstp, xdr, &args->attrs);
 }
 
 int


