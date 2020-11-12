Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F162B10B8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 22:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKLVzk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 16:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgKLVzj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 16:55:39 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986BAC0613D1;
        Thu, 12 Nov 2020 13:55:39 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so5277884qtb.10;
        Thu, 12 Nov 2020 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GWn0+GbGZIotnbwtce5TIF35VRe7pJK6/77dpO85RPs=;
        b=o+73RBnie38DmmXt76AEnHDYy9ElvszQv6F0rXz/qm8lbtkvDYLbn9etwu10NRGNwQ
         9TK7k78o0HX7du6KAVwRQpYbtzXUVeTVG2u9QKpkl55PK8NJGh5NFh7QSzRTlZfqsGfa
         rfQLYjvjg327JSZxnnyJI1MDb/A/FEwzk+aUilcM+b2RMjTZ7EEfYrwD92PuEPWkWHGn
         4VaE2XsIVdUJrxQVeoqLOsbfw3NcjJoUmFqlFw0rgyUUslqsByKNUyCdI6F+lXPmkdRw
         7EVu9NRpiessui0MhnDUeZDi5/4X4Ou+16CW3QAZxK3QVjeYb60ubfawaJ3TiBd+KvQy
         +e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GWn0+GbGZIotnbwtce5TIF35VRe7pJK6/77dpO85RPs=;
        b=hZQUmOupWSJdoW7q6BakFyK8w5iFogM1IIzvlhGdajs/yIPCcBAxxUiK2r7hdtU1v+
         mTWwfXIMu5Ex35VMd0lyzRfewbzpidlSgJTuJ5ELbYF2yZXiQyPrGL+VPnrB3jrRggqN
         pcR6lhEmrZEyFCS14t1IqJ5xtUtHNzw4aLWc1Y09bFw3QIww506uywV5pIhYDFKxc1Ys
         MFh4OuLLYRxggLDcHgnknC70a2PiDZ7Qvyi69XA/H2Tyr0Y8AeMHtCcFTyJUFNHbJyPC
         r04YICQI4iwSNci9jDbvn6bKBiXSopBMTM0VEegTV482lrx5uqW9b4BRoYqphWjAagT+
         E3vQ==
X-Gm-Message-State: AOAM533xmIcUKRYPaN0eXhSjIcKJP8+OnBja/fZCKB8dx1U4AGsT6hbN
        2JNJ2P4T957/7hf5admm5I1YgP1Sw3w=
X-Google-Smtp-Source: ABdhPJwP61O+ETMaQuI3UHdg9vEZK+4H4Rj5xAtJD6quKvrd6NtHTD5uVNxux5aD4ntRWa8awUQepw==
X-Received: by 2002:ac8:6608:: with SMTP id c8mr1340679qtp.145.1605218138532;
        Thu, 12 Nov 2020 13:55:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f61sm5483540qtb.75.2020.11.12.13.55.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 13:55:37 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ACLtZUB030474;
        Thu, 12 Nov 2020 21:55:36 GMT
Subject: [PATCH v1] svcrdma: Catch another Reply chunk overflow case
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 12 Nov 2020 16:55:35 -0500
Message-ID: <160521813593.2742.8423075329083286889.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When space in the Reply chunk runs out in the middle of a segment,
we end up passing a zero-length SGL to rdma_rw_ctx_init(), and it
oopses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 12aa4c53b48f..0b63e1321d74 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -455,6 +455,8 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 			goto out_overflow;
 
 		write_len = min(remaining, seg->rs_length - info->wi_seg_off);
+		if (!write_len)
+			goto out_overflow;
 		ctxt = svc_rdma_get_rw_ctxt(rdma,
 					    (write_len >> PAGE_SHIFT) + 2);
 		if (!ctxt)


