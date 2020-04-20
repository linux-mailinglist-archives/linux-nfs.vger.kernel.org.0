Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709211AFF0E
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 02:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDTADD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 20:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgDTADD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 20:03:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE474C061A0C;
        Sun, 19 Apr 2020 17:03:02 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x2so7177737qtr.0;
        Sun, 19 Apr 2020 17:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JW8xPA8jFX6fPoIXxvq5yOA8ixe8jgG9zEkUFMwINbM=;
        b=cxivn7+XlHI1bUBb0wmWsGjTDaVfuO1Wz7DgqjCS9sYwP18eOy+xrGNAKJJVxZ7ndh
         alxN3L0SvEkgy5NL/McCxKr4E4xNRyaojoo/2sziqv+IZQKTlVtfX8mvoFQzfkJyT+sO
         dENh71Fagv6TVxwec97lO3cGlUljxhoRHHqsHNnyGeJuTcVnxKucmxGW/EureDuYdP7X
         lVyFQlQlOHfBYLP7yaOdpPUO7pOM6JLch+YGbnfVcSbj3vBUathDpX6Wy2cM8E8Xt6Ts
         CTr/lDwD5xhHFXOGskSjSPXS0KBc7oVrbXr1ByE9ZH7As/tyRMJQBM1JtlkMkzDvHsHD
         HFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JW8xPA8jFX6fPoIXxvq5yOA8ixe8jgG9zEkUFMwINbM=;
        b=NkKunMhBzmrDYagXySM3h9yR8FI0Vf0LQ+HvWb0t7Q0nNMvYzGpcxzKSG1Cgf41l0d
         4cWiFTGSIN7E1CbeLcyzUi4QV2A5pHI3Tw4sxotlEz6Z+TUW7sAohFBQhtHpG0ausHJz
         ejbNZYJFiNefQ2LyBwx5k5szkfagZFbfynwOcmfbhECwQcW9aOVu7d1/5K4QquI3Zm0d
         H+DzKzjXNvASikVuRXOe3Rk5ERiY9MdDI9scxMd4MtEBlpxmpIvyKuqZW6Nxl9xWI8vy
         r5/zzCappum0NRejEMUkbcgqEuxbNZ8JxBf6F+WZssMw4YPFTu2U156D1dbICoZm6i8v
         DXaQ==
X-Gm-Message-State: AGi0Pua3FXZyttWiL2tMOKcRvonxbHJlLq5s9+tkzQeOhpz1U7XSZp/B
        si/iltV8c2BeR4pl/9tjN+Q=
X-Google-Smtp-Source: APiQypKrkZiXHW+4TOZf5EDW2VGkqTOiOxshOEDReuTy89YZc+VImfXPsKhicULE0rf/Fmn7p+yUAg==
X-Received: by 2002:ac8:38eb:: with SMTP id g40mr13756691qtc.386.1587340981847;
        Sun, 19 Apr 2020 17:03:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s125sm1292886qkf.9.2020.04.19.17.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 17:03:01 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K030Nw016693;
        Mon, 20 Apr 2020 00:03:00 GMT
Subject: [PATCH 1/3] xprtrdma: Restore wake-up-all to
 rpcrdma_cm_event_handler()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 20:03:00 -0400
Message-ID: <20200420000300.6417.90305.stgit@manet.1015granger.net>
In-Reply-To: <20200420000223.6417.32126.stgit@manet.1015granger.net>
References: <20200420000223.6417.32126.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from
rpcrdma_xprt") erroneously removed a xprt_force_disconnect()
call from the "transport disconnect" path. The result was that the
client no longer responded to server-side disconnect requests.

Restore that call.

Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index cdd84c09df10..29ae982d69cf 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -289,6 +289,7 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 	case RDMA_CM_EVENT_DISCONNECTED:
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
+		xprt_force_disconnect(xprt);
 		return rpcrdma_ep_destroy(ep);
 	default:
 		break;

