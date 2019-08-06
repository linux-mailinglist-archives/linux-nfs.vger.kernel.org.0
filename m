Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20552835C9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbfHFPxt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:53:49 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38743 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfHFPxs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:53:48 -0400
Received: by mail-oi1-f182.google.com with SMTP id v186so67288190oie.5;
        Tue, 06 Aug 2019 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JQcc2Brp9EZjuJEPqTpaVKnALxszwbxxkwtGW+5cOQ4=;
        b=PiPfpao3hAggZGittoQsHIyab4qCf/jQXZJHAKMdm44foR6JSZLO/xD7qxD1FOLxa1
         jjB8BJ7wg+7aQE5cby6shQ3gpGtkk8QpxUsqXNQCIll0CTNWAtsdFd+zwC1yaiujRSrf
         zzB92Y9aATLPrb1Va5veTayw8k+slerefYVlTKysULNcIrtwoYJMeZlSe2q+rA8AkMvR
         KW5/bwhYlGg9TI7WRZaxZFCK9j/wpO3qYqhzzOYvf8zci1EZzTb1MiizmMwbIh/jywza
         wwgTk0h0YWeLUWtic0RVomITmORs/0dViQpYrQss+0Ks6+GBkG8hYhpz8ZR+JTgpiHI3
         HTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JQcc2Brp9EZjuJEPqTpaVKnALxszwbxxkwtGW+5cOQ4=;
        b=POiBB9RayNp2mhAAfxxPJWTNoehstlHwoa1+yDPPapz1ck0p3Zu77NpvMVK75oum8R
         o3ZEqVqqggRDJTVqaZqwC8DSEKe1UDFMcSAPMLbC73AbdxVl2KTq/TpQZc+HZ+nrvEvw
         aT4/fkNPG81c9CiSD9zrIwsb5P9h+GXYPvLD7yfbxkx1Pp3VjwyDjOUUaIQFw4Dd5ZiH
         BalPpq/+DB7zc9Ldh6OTMYn/WC/c8FVArMoCmNlfAgZtd935HECWZGIaRZyNiUJir177
         Roffk61JLiz66zwx+0L2cuJpRbXrr8DXOQ2UR+gY68IhHlDHGacLL7qZCnzG96HLAG9J
         6e3g==
X-Gm-Message-State: APjAAAXALtTU821llBuldwFKqyTcgQeJCf6RhEMAW/Rf1/QZGP0tSLYx
        c7mZn2IGygr8ywrlnaW4dzhzLd1r
X-Google-Smtp-Source: APXvYqwSx/xHTPOWikhkdHR75ZOBk082XQi03rcul6/IKst5DlJepCRvqzfoKTICTbxUbtEV0XnckQ==
X-Received: by 2002:a02:cb4b:: with SMTP id k11mr4819853jap.109.1565106827548;
        Tue, 06 Aug 2019 08:53:47 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y20sm72072518ion.77.2019.08.06.08.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:53:47 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FrkGT011511;
        Tue, 6 Aug 2019 15:53:46 GMT
Subject: [PATCH v1 00/18] NFS/RDMA patches
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:53:46 -0400
Message-ID: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For review: a set of optimizations, clean-ups, and bug fixes for
v5.4.

---

Chuck Lever (18):
      xprtrdma: Refresh the documenting comment in frwr_ops.c
      xprtrdma: Fix calculation of ri_max_segs again
      xprtrdma: Boost maximum transport header size
      xprtrdma: Boost client's max slot table size to match Linux server
      xprtrdma: Rename CQE field in Receive trace points
      xprtrdma: Rename rpcrdma_buffer::rb_all
      xprtrdma: Toggle XPRT_CONGESTED in xprtrdma's slot methods
      xprtrdma: Simplify rpcrdma_mr_pop
      xprtrdma: Combine rpcrdma_mr_put and rpcrdma_mr_unmap_and_put
      xprtrdma: Move rpcrdma_mr_get out of frwr_map
      xprtrdma: Ensure creating an MR does not trigger FS writeback
      xprtrdma: Cache free MRs in each rpcrdma_req
      xprtrdma: Remove rpcrdma_buffer::rb_mrlock
      xprtrdma: Use an llist to manage free rpcrdma_reps
      xprtrdma: Clean up xprt_rdma_set_connect_timeout()
      xprtdma: Fix bc_max_slots return value
      xprtrdma: Inline XDR chunk encoder functions
      xprtrdma: Optimize rpcrdma_post_recvs()


 include/linux/sunrpc/xprtrdma.h   |    4 -
 include/trace/events/rpcrdma.h    |   88 ++++++++++++--
 net/sunrpc/xprtrdma/backchannel.c |    4 -
 net/sunrpc/xprtrdma/frwr_ops.c    |  131 +++++++--------------
 net/sunrpc/xprtrdma/rpc_rdma.c    |   63 +++++++---
 net/sunrpc/xprtrdma/transport.c   |   12 +-
 net/sunrpc/xprtrdma/verbs.c       |  226 +++++++++++++++----------------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |   49 ++++----
 8 files changed, 290 insertions(+), 287 deletions(-)

--
Chuck Lever
