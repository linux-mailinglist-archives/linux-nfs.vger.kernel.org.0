Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B340A9512B
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfHSWwM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:52:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37091 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWwM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:52:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id b25so2632858oib.4;
        Mon, 19 Aug 2019 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XrEdW8AMlQpqsqIQf8IMdqgYvv8EcJ1wwexhKa1n9xE=;
        b=WxqFndBn57xHAtgEYnjGe/vywndmOIag0QWMQ99o6nShwbt0Hi+ybraZqHw2mPrccI
         3VkOxDNVS+zmt1awXsMWM7cMO0vyZik1DTN7QB3vRCUaq1/7TSomVRstZrAk+Kn9aM2C
         7z2u4rjhSEUdM6XpFQPEYvFGx1v8Sd+bMTHmTIjXzMpBte8PPKfw9q7l9qJk+3Ilh1jX
         0qeULHBzWJJfLwPMxauazwxaai8NFeiGu6sbrp7aDb9pA9YZ6grZpJVtFMs3RJEhhfn8
         fC0pCO5a0po36q3BO5WcXXvlvaPdHPzwxxBCt2tM/gFciKS+EtYtMZE4EW0aEt4SDULg
         Hp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=XrEdW8AMlQpqsqIQf8IMdqgYvv8EcJ1wwexhKa1n9xE=;
        b=d3lV/Csb7dwTKCLH7kagDVZtk8C2eNhuu8rVFjpfglf35HZVTrRHeAmba4UOHXBhiT
         jAPIzs/5wYWaoQagKzq9KkKOsWjSvZNU4ylfzVbooMSfeLxpvHy8NaGgGK6H+Y+8+AfK
         J3KeDjjbHuo4K83VlfY64Upj3eOO2+KXKjLGQodL7OqG+svMhSf5TtXn/q4ZEyXVQPIO
         VXmFf8I2j8snj03fTPXam3NH5MU6689psg0H9flLaYmKKd2QLm8hh8BHQFp7l9jM9cKJ
         CbKKf5Y+xcUFJTMw8BCdcVUmWPD5TCNLbc+y4RyeThrbwme7/EtdNczklgBAvMz1gRH3
         8YuA==
X-Gm-Message-State: APjAAAVw8gyv/BEgMdEZ+Htcwpg5/RrMHhLtP2020S+coWx7C3ACY53s
        bwxnWlhRzeMruakZ49cFixCqZTn8
X-Google-Smtp-Source: APXvYqw5PFOKtgIUITMaymkDfEgHAbJJqWo2WcrMvJDhUipwniayzGr11OVe/BHS6gXPgGoi6FFrOQ==
X-Received: by 2002:aca:ea0b:: with SMTP id i11mr14175212oih.102.1566255131200;
        Mon, 19 Aug 2019 15:52:11 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id c15sm5737736otf.35.2019.08.19.15.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:52:10 -0700 (PDT)
Subject: [PATCH v2 21/21] xprtrdma: Optimize rpcrdma_post_recvs()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:51:49 -0400
Message-ID: <156625508978.8161.1876379934869374429.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: In rpcrdma_post_recvs, since commit e340c2d6ef2a
("xprtrdma: Reduce the doorbell rate (Receive)"), the common case is
to return without doing anything. Found with perf.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index db90083ed35b..ac2abf4578b9 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1465,7 +1465,7 @@ rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	count = 0;
 
 	needed = buf->rb_credits + (buf->rb_bc_srv_max_requests << 1);
-	if (ep->rep_receive_count > needed)
+	if (likely(ep->rep_receive_count > needed))
 		goto out;
 	needed -= ep->rep_receive_count;
 	if (!temp)

