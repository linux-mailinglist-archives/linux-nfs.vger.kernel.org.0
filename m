Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4CD1C1BEE
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgEARht (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729040AbgEARhs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:37:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D6C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:37:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b1so8500739qtt.1
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=yT4jz0h5ikgqe9bhoAKzrtpqEFyXGZr9jtA51fgAuQs=;
        b=oSh1KPuOlUV2M20ZYac16mkULFHeYf455XeMpkwHEP4ivXUFQmPaIQ4V2JA5qrMVnt
         PUmwy5G5+et6tsRT6nf5MwoAt21gl5DFT7eGxxwdPWoXITQQ+gw1BSDVg1oAQ3pXaq8A
         gFqNUgy+A8N53kxKC35Oe9zlHeVw5uDzNxhfY32ooxKi49pOBEoFDcZCu6NbToLDm3T4
         5kgfRctKKtJyP7BeoH208E2DxhFnTg/S+THFwbP0AafEEGSGpHlhzZqGgAQvBQ5o2hrM
         iwQHeF+x6m97FUxuVfkgyeBoV0tifO7fcA3BaD8ZP9QadgK5kRYaQbGCbOC5RMxYDPxj
         nK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yT4jz0h5ikgqe9bhoAKzrtpqEFyXGZr9jtA51fgAuQs=;
        b=ErFDK4pFdsTzbc7Iu8TS5EFKsWe3yB0EAj9GKK3B+LlUif6XpuxqRt/mff4ScTwljs
         qAITgHNSlAPswUNTnhtljVeRy9SzYsSn8kXHg4odqzQ7O+vieCo7UEv2wBaIGLRfwD3u
         h5xc4TVnmQQUD5XGt8WyTBS8IGZMNOW1HoMqYGqLEYMnVu8iOslRWoCGTQ1tV5Et8cSb
         BN62Sa3qVJuj3+RBrZFrEA6LKYWw4LMbMjXLpN8UaE+GhX/1f7f213M6saCkR9lmit7e
         I0QwVyzkfBaEi/tn78A36SMUJ6qTxa2TNHpeCB/8yHgHHkqOfakqNrnxhJC45CMTX4mk
         GWCw==
X-Gm-Message-State: AGi0PuYOwW/G5DWFShwSDxqLlVrt/1sCDg9ZGp29pd4qQJVsu2HKr7YX
        qd9OpexK82rwYlZVYnvIf42HnHHK
X-Google-Smtp-Source: APiQypJJ1dRYW1pnxjbnnE20jp9SsgzWerUSqJKej6XkO+D6G++NKNDoObROVVwWyYOEkMMGmLziFQ==
X-Received: by 2002:ac8:60d2:: with SMTP id i18mr4962209qtm.244.1588354667076;
        Fri, 01 May 2020 10:37:47 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b42sm3194156qta.29.2020.05.01.10.37.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:37:46 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HbjWR026725
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:37:45 GMT
Subject: [PATCH v1 0/8] NFSD socket send-path changes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:37:45 -0400
Message-ID: <20200501173526.3868.96971.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

(cc: linux-nfs only)

This is a set of patches that change the server-side socket send-
path to use the kernel socket bvec API. This is a pre-requisite
for supporting RPC-on-TLS.

At the same time I've introduced a number of tracepoints that are
specific to the server socket transport code, and performed some
other clean ups in the area.

---

Chuck Lever (8):
      SUNRPC: Remove "#include <trace/events/skb.h>"
      SUNRPC: Add more svcsock tracepoints
      SUNRPC: Replace dprintk call sites in TCP state change callouts
      SUNRPC: Trace server-side rpcbind registration events
      SUNRPC: Clean up: Rename svc_sock::sk_reclen
      SUNRPC: Restructure svc_tcp_recv_record()
      SUNRPC: Refactor svc_recvfrom()
      SUNRPC: Restructure svc_udp_recvfrom()


 include/linux/sunrpc/svc.h     |   1 +
 include/linux/sunrpc/svcsock.h |   6 +-
 include/trace/events/sunrpc.h  | 270 +++++++++++++++++++++++
 net/sunrpc/svc.c               |  15 +-
 net/sunrpc/svcsock.c           | 380 ++++++++++++++++-----------------
 5 files changed, 456 insertions(+), 216 deletions(-)

--
Chuck Lever
