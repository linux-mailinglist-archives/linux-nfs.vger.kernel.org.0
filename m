Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0FDB623
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfJQSbE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 14:31:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33610 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbfJQSbD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 14:31:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so5097310qtd.0;
        Thu, 17 Oct 2019 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=R+R2e7M4AkVWKAQVOisqosE876Dhsx04bqtF3V42h50=;
        b=tCJ3ArmR7tlmrcv9oFmJ27krlqxs8oY4jx75PKrlKbprFBzBfyq2UFqDDrTPlFgnFB
         HCcof//EeQKdaqQxbcZWvaLbI04mvi3Kd01c3scGU8NjXxtF0As018UpbZTuSW9GaQJb
         OzHqO6OZpmBQu2Wq5OcPsHEEm0jIhRv8vA1XL3QOOcfp7WYwGesl8J7ItEI2HBLNoEB3
         gf/ejWILWMUXnWi+LkLeunsUVkbU3m+UCjSbdUDGgeXc1vsBnn1U6Jw+Kc3va2+jf9KC
         IaVZsdwnD+oaJcx2MqXN32T/cw3lQhMaQyQ+UG3LeCgsE7UJQRZlFAOEotfJUKX3yV/8
         G9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=R+R2e7M4AkVWKAQVOisqosE876Dhsx04bqtF3V42h50=;
        b=gmkv+RXcXqRPfEzC5ZraMKLP5oatGi3vCxxoEfu1UfMrokg2+1i3kXLNawuIyrWhyB
         hXH/C/yi2wJ4jQSNqfn7w2niMKJ1MHWMiKd+Z98BHU7PDp4PK9Oe2LFS6RFFGr8qfu0Y
         MxkrSNAueT3Mv/lWiUalFdTwiHTh0o/i1dGNbVoY8GabDqt5RhFEjIPrrbiGD91LXERi
         JSV5die3zxHZMUWrpkVVY6acwZnvFn2sRXnc7Jq1hPvB+2EwFH07mOxwIoDwvcRAeRJe
         xk0t7HJZNIxf/vUBob1I59uapgpcbS9QiMuQGPAieKP94SlpjyIKpVORG/A7Bxi0c5dI
         07Yg==
X-Gm-Message-State: APjAAAUHLq5UlKfSJWmz0LESHl4gKshfgMjeHe07lj4s0FzL8nPZh0xG
        SKhYuJ55WPnIupKF7PMJzQbWf0bJ
X-Google-Smtp-Source: APXvYqzBxImVOpsgr9R3vCaRhWXB8XhIgz/VhpXjCU7sJ7EkgC9iYjqDM5DxSNqtZTxyJRyLsmqxgw==
X-Received: by 2002:ac8:237b:: with SMTP id b56mr5621730qtb.264.1571337062693;
        Thu, 17 Oct 2019 11:31:02 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id x59sm1973858qte.20.2019.10.17.11.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:31:02 -0700 (PDT)
Subject: [PATCH v1 0/6] Sometimes pull up the Send buffer
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 14:31:01 -0400
Message-ID: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series contains several clean-up/refactoring patches, then the
last two patches in the series re-implement buffer pull-up for Send
buffers. After this series is applied, the client may choose between
using DMA-mapped Send buffers and pull-up. Sometimes one of these
methods is strictly more efficient than the other.

---

Chuck Lever (6):
      xprtrdma: Ensure ri_id is stable during MR recycling
      xprtrdma: Remove rpcrdma_sendctx::sc_xprt
      xprtrdma: Remove rpcrdma_sendctx::sc_device
      xprtrdma: Move the rpcrdma_sendctx::sc_wr field
      xprtrdma: Refactor rpcrdma_prepare_msg_sges()
      xprtrdma: Pull up sometimes


 net/sunrpc/xprtrdma/backchannel.c |    2 
 net/sunrpc/xprtrdma/frwr_ops.c    |   25 +--
 net/sunrpc/xprtrdma/rpc_rdma.c    |  352 ++++++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/verbs.c       |   26 +--
 net/sunrpc/xprtrdma/xprt_rdma.h   |   14 -
 5 files changed, 251 insertions(+), 168 deletions(-)

--
Chuck Lever
