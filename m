Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19E1D00B8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgELVX0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgELVX0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DDC061A0C;
        Tue, 12 May 2020 14:23:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z80so9736621qka.0;
        Tue, 12 May 2020 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=X4fXdAWhojbxrpWwGIfQWlHhfLTmVqHl5gL0tZf73us=;
        b=WrQo85PM41OMEET8F7B3uRk+ivjJIkQIH5Me0WKlLok+ZkVJapIVGaoLsCWkxL/lsT
         uTJQoaMgunZ/Hrl8+BTg7V6J/kXWz8BUKpDR+NleQXE/KxnpS+uLgHynW5QSGSzFtqtP
         9IZpxaAtXRNNFh9k8PqrMF5POwzh5KkdrOWzpBDFOMc5RVUDLcbYP7B+DQxkroP+9K02
         9PpkUqjz82bcKzvGsRPSDRNAlPjh4a/T09GcASDqQpswH7d2qLhym9bs2g4HghRGO9Nc
         9aZ/UVRAa86GRJxd/WQ6dAkX5pW2F2rqtO7yVZa/JOpDsrY6nY3UEB4tl4/Jcgd+pnbh
         aXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=X4fXdAWhojbxrpWwGIfQWlHhfLTmVqHl5gL0tZf73us=;
        b=DFtr2yYQ3FckqCsVTFm2Ai0SKHdS6a0RivN3I9tRnSuZN8lsz8Urz+P/WKwKa54CMd
         XS/DfArZI6zRdHqTr2CGrL4hniIHIZQ9FqPt/MLcRqW9tfbVIg3zc14Rz2HtRvNlmFPJ
         A1r7g5Av8g6ZFCd7mUupjpcZGicZfnIhIAvgbRK+LJ8CLnvmpELvQmoWyqLOuuCv7ui0
         fF079Gar0UvwMqtPH9qxZuAJ7x0pP2otam/LPLTW2KaTzjNpLi6HzR2NY52dE0bkukGQ
         F9TXVcu38X/ayHIaTt6DjD5wqrgx2Jxb2MzoHEX4ydrXEAG7J/zcbeAbRA/nAk2T/ND3
         xc8w==
X-Gm-Message-State: AGi0Pub1lPcfEWrCnPi1MbqbgmZIubcS/byaIY+z+/SeD2LcyCieqSY1
        YTbCCEQdqkYXZ6MnY42c4XcCEgZi
X-Google-Smtp-Source: APiQypL/OEJwLx81cTpHqL6Ymc2CwyMB2/ogoCWlFg6mWGDov4thES/Jes+ytxAmSxVp06/5QgcQAw==
X-Received: by 2002:a05:620a:490:: with SMTP id 16mr22533198qkr.203.1589318605141;
        Tue, 12 May 2020 14:23:25 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h13sm13473015qti.32.2020.05.12.14.23.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:23:24 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLNNk4009919;
        Tue, 12 May 2020 21:23:23 GMT
Subject: [PATCH v2 15/29] SUNRPC: Remove "#include <trace/events/skb.h>"
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:23:23 -0400
Message-ID: <20200512212323.5826.47423.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Commit 850cbaddb52d ("udp: use it's own memory accounting
schema") removed the last skb-related tracepoint from svcsock.c, so
it is no longer necessary to include trace/events/skb.h.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index cf4bd198c19d..1c4d0aacc531 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -45,7 +45,6 @@
 #include <net/tcp_states.h>
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
-#include <trace/events/skb.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/clnt.h>

