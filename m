Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC41E918A
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgE3N27 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N26 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:28:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18EEC03E969;
        Sat, 30 May 2020 06:28:58 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r2so5206657ila.4;
        Sat, 30 May 2020 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WhwomO42XDAEJPW2/cr+MUt5RrB/mfN0Bet2spmrCJc=;
        b=uGofrnRhPzjYFyZBFPj67+KDeo9Jahr6+u6+WLOWzQzSyVWefH7RsyTY8GslZ8wguu
         RE3mHIsgUskZOBdcPdADBhyH1uvsAbXaumLpwyhJMySu6jhBI4tHjB3YwOOqUjqd8p03
         fzpxQ0pmQKGcqJZu84pfdku7qZ4RxGpfMLqltgRXufhMMVpl/lDKCnMUOBkrQUFBvyU0
         WRZ+rSmaIRqR35+ea11c7mJQZyQQxgdSwRkbSodZ2FmyrlgkC0oTTxHWhQ3VjT1zDBC2
         fLU8P9eT8q2x2Q/kQ2HBFlaysHgGhhppLnlDRmMjnoBQzK/XLCl3DYr99iartAj/pyO4
         P3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WhwomO42XDAEJPW2/cr+MUt5RrB/mfN0Bet2spmrCJc=;
        b=pCQGsIAcGI5xbjstmTKUxZUysyN301Vb2ZpRtb6euJBuilJXZ8q6GyLiWp0MGTE78E
         lkmv+i1oUVsNDIQ8kYfYr8ozkhEoZJpAQah5iTAq1/b1hp5BvR6kIrkq7xQGWKoALKxO
         D4ZSn+JSojkH1Or4r6wRvh16zdTzGeqi2zjnFqYbx0vnFqtFwMhbsY2qf71h2Fqnn2WV
         8vXkpdgDd1vU9p5JWbR++jygWuQRKQftYI6XtaSY4niJsDtBmw0BVogFosjbW+0ldwyy
         MIo8IS5j/nKu0XqbnZLFtBGPIQw/4KqkwWz9JbKBOT81BtguevoftFpfwoyyyWPi4YCZ
         cGvw==
X-Gm-Message-State: AOAM532mc9IhvjgwQyzECoRXGDzyNMLLJ9meSnBYbU4XQEzNSQZQdnBg
        JBb0OY5wokNWMHWImpG363e3GEno
X-Google-Smtp-Source: ABdhPJw9g3cK+A3mXsjm4YkRBpgUH6ZlIqlteccfqcwfLUQ468jpgkmPzouv4XP3zynqEH/e4kYe9A==
X-Received: by 2002:a05:6e02:128c:: with SMTP id y12mr10010684ilq.291.1590845338186;
        Sat, 30 May 2020 06:28:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s15sm6419675iln.49.2020.05.30.06.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:28:57 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDSvM7001414;
        Sat, 30 May 2020 13:28:57 GMT
Subject: [PATCH v4 10/33] svcrdma: Remove the SVCRDMA_DEBUG macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:28:57 -0400
Message-ID: <20200530132857.10117.14287.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Commit d21b05f101ae ("rdma: SVCRMDA Header File")
introduced the SVCRDMA_DEBUG macro, but it doesn't seem to have been
used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 8518c3f37e56..7ed82625dc0b 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -48,7 +48,6 @@
 #include <linux/sunrpc/rpc_rdma.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
-#define SVCRDMA_DEBUG
 
 /* Default and maximum inline threshold sizes */
 enum {

