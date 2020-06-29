Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E238B20E61C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2020 00:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgF2Voe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgF2Shq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 14:37:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B8C02F029;
        Mon, 29 Jun 2020 07:58:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e12so13012895qtr.9;
        Mon, 29 Jun 2020 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MrY/qbha8c9/eEYWRFFYPrJw6U5ree3zucPgmNlTI3o=;
        b=YK3e1PDSkcKmhK+JlAYIl0xg8tKlC79mfjWF4wXhcOk8tnb+rz5KqJiJg7NMo527EM
         EEI0iRyqe+bxarqHZGdaPutY6PpJnCRotLBcEyVcwRcX5SHD8MW7yDKSbk58tco13M57
         xBRKn6V3/DCuhuysFNTlKZuZbSTbYcGNMYhXeEQlC13vCv0wvbOflqyXoccqJqFlDH5a
         0MtU59iI0JxMy3r7kVPo7DWkLSqcev8x/8kGSATjjF6WoYNYw+lc++upws7k/1yo/Et5
         9iZnumnXM5sPL93uwau/Z96Ha/WBzDw2wMSl6QOBz5cH9TYjAu2tYXwuVmAWOt78Y9Vv
         AKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MrY/qbha8c9/eEYWRFFYPrJw6U5ree3zucPgmNlTI3o=;
        b=n/bTJ476LypfDa2vA9zXNMgznuFvkjG3GtHoeTOKDbhbvqBqb2SSRvxcqHxslcQL/H
         VoojGdBHR8WOuXAF2i/3V8FUDsFkaSRNjt87j5vXOh7ebGloA7k6l0x50k+xaGuHQB5Y
         hlZIvSgaU9IE7Kb7BQSGgf1851xcuee/0QjewbUvyPGNeGcTFwbhzDAFi23M9CNGe4I5
         Z2GEooOS58+G2/Ht6/YaZkwfUGk7bB/GSBJXrMGRRbqicjJApQdhZEfbDAn3/+s4u7bX
         JzLA2lBVSuQUDP/qECB1MQj3Heyx7gIKqIS+8tMn+ihOzssSpfOvGDbcMSFPrOJyLk+p
         Bx8w==
X-Gm-Message-State: AOAM5335QlIVQ0d5HvyER/Xd91jKKy+BA8bZtY0pE33z7tMxmZM+5nKX
        LfVz6k0YgVSDbGwG9quC0v1n5c4y
X-Google-Smtp-Source: ABdhPJzIQdz/NxfPTTn7hWlc3c28hhIUcG6SNc+JL98upEpkWXzmWbE363xNi/nK1/VyZz+nhjuXGQ==
X-Received: by 2002:ac8:32cf:: with SMTP id a15mr16651067qtb.241.1593442715262;
        Mon, 29 Jun 2020 07:58:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q189sm53424qke.21.2020.06.29.07.58.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:58:34 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEwXBG006239;
        Mon, 29 Jun 2020 14:58:34 GMT
Subject: [PATCH v1 0/6] Server-side completion IDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:58:33 -0400
Message-ID: <20200629145528.15100.77805.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'd like to remove the display and storage of kernel memory
addresses from the RPC/RDMA transport's tracepoints. This reduces
the size of trace records and closes a (possibly minor) security
exposure.

This series is a down payment on that effort. A similar series is
in the works for the client side transport implementation.

---

Chuck Lever (6):
      svcrdma: Introduce infrastructure to support completion IDs
      svcrdma: Introduce Receive completion IDs
      svcrdma: Record Receive completion ID in svc_rdma_decode_rqst
      svcrdma: Introduce Send completion IDs
      svcrdma: Record send_ctxt completion ID in trace_svcrdma_post_send()
      svcrdma: Display chunk completion ID when posting a rw_ctxt


 include/linux/sunrpc/svc_rdma.h            |   9 +-
 include/trace/events/rpcrdma.h             | 161 +++++++++------------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  27 ++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  14 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  26 +++-
 6 files changed, 128 insertions(+), 111 deletions(-)

--
Chuck Lever
