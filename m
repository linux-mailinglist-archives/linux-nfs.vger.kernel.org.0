Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037371AFF0D
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 02:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDTAC6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 20:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgDTAC5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 20:02:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51D2C061A0C;
        Sun, 19 Apr 2020 17:02:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g74so8823204qke.13;
        Sun, 19 Apr 2020 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B7xhq+APf45x2wvg9KIt4Ho6+03Chcke1iwq0BwwM+M=;
        b=MscsKhTEA6Jnkt8Ng2/gx2Arr179frr1l9cNMNP71SdbeHVAWRGTZaD9FbnSOu5uhr
         xhCjjFsRkkIJuVCdT6fhtKfh2XTFtHG+GOP7r6o3la6oRTweSy7TtNUNMqiZzMKQHG7v
         VlOkNaXPUxCLdjIMzWoLAlTAoPML2KLybCHhE6jJStU+2iSmsnkeoTq0aGcTKeS+P1oD
         WnC2L2pe4+JNlwzYlEDBHNuANRuDF+CcAfR7ZWMeB1zoHeSr1tyQg5fJxqBhHOGxlu9Q
         SlJUMHQAJp9KjtZMQhXCxffDtibVVncFBst04AW7Xl/exNJlTM1FR/v3gQyU2YApHS89
         xYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B7xhq+APf45x2wvg9KIt4Ho6+03Chcke1iwq0BwwM+M=;
        b=BF/Mbqkfqi8+upjxYpuxe8/LnXTQhFLnuJVbP7L6kVYch3RsMi44yzZkKuC9k0wTGG
         DlpebsjOny48iR5bVUS5IId8W8+/TW6tWeH/HQ6s9E4miegiTo9kFuH5bDImJmyZxC3i
         L/iISyNdMZZ/Ieqi07ZE5GFzG8D5i2p2sEo4BFLsHQFw2fGH0RtfpzcgxFl82gTvXQzT
         Xy4jXDQRd3FXMEz59ZIxjdeeXv4JQyAsm55MbwA2qD8DFRTfI7EIuFYKWrfPYAoIAj0+
         9D076uko4fGFnzgATpbKpIyeLFVo3X6wDY8Lno2IJrbEw0LDv9aC2bWOxUV12cCoxCAP
         ep5A==
X-Gm-Message-State: AGi0PuYaLRdbKxZN1nqWIu/JGMFuawRuYZWWJfV81udSMI7DYErO0lv8
        j5Crk3HEk5mmhHfhR4LQq1c4lqOO
X-Google-Smtp-Source: APiQypIbwA2jcpLiZ0M7FZU1gj+i3IUO+DwedgVWGEjmMbkPPfjFDDljXe7qBU+N/NIIJBBKxr1DLg==
X-Received: by 2002:ae9:ef93:: with SMTP id d141mr13783889qkg.311.1587340976769;
        Sun, 19 Apr 2020 17:02:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o43sm6087979qtc.23.2020.04.19.17.02.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 17:02:56 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K02sIh016690;
        Mon, 20 Apr 2020 00:02:54 GMT
Subject: [PATCH v1 0/3] NFS/RDMA client patches for v5.7-rc
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 20:02:54 -0400
Message-ID: <20200420000223.6417.32126.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

Patches 1 and 3 fix problems introduced in v5.7, and patch 2
addresses a potential crasher that's been around for a while.

Please consider these for 5.7-rc. Thanks!

---

Chuck Lever (3):
      xprtrdma: Restore wake-up-all to rpcrdma_cm_event_handler()
      xprtrdma: Fix trace point use-after-free race
      xprtrdma: Fix use of xdr_stream_encode_item_{present,absent}


 include/trace/events/rpcrdma.h |   12 ++++--------
 net/sunrpc/xprtrdma/rpc_rdma.c |   15 +++++++++++----
 net/sunrpc/xprtrdma/verbs.c    |    3 ++-
 3 files changed, 17 insertions(+), 13 deletions(-)

--
Chuck Lever
