Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151AA2CF423
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLDSfF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Dec 2020 13:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgLDSfF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Dec 2020 13:35:05 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F5C061A51
        for <linux-nfs@vger.kernel.org>; Fri,  4 Dec 2020 10:34:24 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ce23so6310046ejb.8
        for <linux-nfs@vger.kernel.org>; Fri, 04 Dec 2020 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vw63I2VlziN/vp5Cl6J+qjR5X41fB/5qX2XUsTD9MNY=;
        b=m/WoTQ0wnMgHo8HbYnKxbDSmVW+FTHYfwhhbW/G0Mm8bivDPgitHsrWu2ng7/mvV1C
         bL78fLwL4Zh8YgjWolY0/zjvK3uvHE5aed74kP9YNwLTlMkEYNlQyWLjHV8QfvcZOpy9
         OkydkqldP5FMfGLZKJbkA4H8TTQddK73/KSzSOuHVf6FOyq5zyZOTd6c2ulUchBRBq3K
         oqQGQVAz+valr4TmyXa0Hm3bbGxD8/RcMEsbfe6gJ+igUIEBxFCBehBeuylrzWWbhWnP
         RNIk2Pgsrt/jFjlE35VUm7nbtS+kK3ouja/eVHDZvJ88bZHPaGC1ezIjtPPo4msfQGI9
         DVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vw63I2VlziN/vp5Cl6J+qjR5X41fB/5qX2XUsTD9MNY=;
        b=FjlMLqe5iyG8gVYmF+haeVZu+0aprGQwHfGiNewgUwSYFVSPaGgnf/xWbpK6pyQFP4
         64i5UErRR39QRBhQXF+LLHEpLBHkZ1yIsTW4ybU/ZxaHXYTc12uwpqMVseAFjS14ehM0
         oABI4ldsU770o2SiEGEd+fPwzR8DR3OBbOP8j9n7pCxJBSqnCGX5x9yIpOzAQg7DBQnL
         EmpPBnQOoS6U9562OjTl4Pf9DysXzHBzv6ur6BvK/xzjgiqtjVYsl9K1xRsdW4BMM4n8
         CMyy5aWuS2kNBsLmZHsjLGUgdCythz/y05dwnS9PJilWzJNLL08Z6J5SARLWB8P8a8R4
         xMwg==
X-Gm-Message-State: AOAM532DFPvN876BGOhTf11p4DGhvhYGfxw4mYoD0oMMM2MOS9Ld0K7/
        1J0S9IGvewALosjG9rGZkB/1g6zLSp+RkXR7
X-Google-Smtp-Source: ABdhPJxz9j1hAwkbxQO6dsU9+XhIfK2prgSoTIsdxOflApafzXzeaVS1/W6D/7GC1AFclNLZjRnXKg==
X-Received: by 2002:a17:906:b08b:: with SMTP id x11mr8364268ejy.302.1607106863162;
        Fri, 04 Dec 2020 10:34:23 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.125.107.115])
        by smtp.gmail.com with ESMTPSA id z22sm3559011eji.91.2020.12.04.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 10:34:22 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH] sunrpc: fix xs_read_xdr_buf for partial pages receive
Date:   Fri,  4 Dec 2020 20:34:19 +0200
Message-Id: <20201204183419.1532347-1-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When receiving pages data, return value 'ret' when positive includes
`buf->page_base`, so we should subtract it similarly to how it is done
for `offset`.

This was discovered on the very rare cases where the server returned a
chunk of bytes that when added to the already received amount of bytes
for the pages happened to match the current `recv.len`, for example
on this case:

     buf->page_base : 258356
     actually received from socket: 1740
     ret : 260096
     want : 260096

In this case neither of the two 'if ... goto out' trigger, and we
continue to tail parsing.

Worth to mention that the ensuing EMSGSIZE from the continued execution of
`xs_read_xdr_buf` may be observed by an application due to 4 superfluous
bytes being added to the pages data.

Fixes: 277e4ab7d53 ("SUNRPC: Simplify TCP receive code by switching to
using iterators")
Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7090bbee0ec5..42b680a60d38 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -436,7 +436,7 @@ xs_read_xdr_buf(struct socket *sock, struct msghdr *msg, int flags,
 		offset += ret - buf->page_base;
 		if (offset == count || msg->msg_flags & (MSG_EOR|MSG_TRUNC))
 			goto out;
-		if (ret != want)
+		if (ret - buf->page_base != want)
 			goto out;
 		seek = 0;
 	} else {
-- 
2.26.2

