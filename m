Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443E720D907
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgF2Tnb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbgF2Tmn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:42:43 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295DCC02F01D;
        Mon, 29 Jun 2020 07:53:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m8so3539048qvk.7;
        Mon, 29 Jun 2020 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=F0gM+nSyRIELjs1Eq2e1R2aAYmpFyLwTPIYoLEf22MM=;
        b=P4YCNscRLKsOIbhE8ca1Z/ar/neh80kHj5BGWQwrmS/9MqkQ0Nz9yoVKzbd73FYqCa
         fe73AuJHyCnIiezNyKT2CqfZspwCxntqMnYjP0w3c7+oRZwET3q3LqNxSTtQQA88E57f
         4Ts4FYQpOn8rLvtdMkzBa20/JLKZVC+CcUdH/0H88DRa3QywTXneJtqu6K//NigAhP8t
         JwXPo1wTGURNoclbTMRxGH2+X1Gih9+3X2KvQjnEdmKhfV5RJmUTxjd+H8xpEJOZ3lcI
         KYrK4EHMlIc4J1Zg3NYSUk5xJ9JAcJCT1uVjyCfh9P1klzEH2plPHMdatFDZ8SjlhCRX
         OjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=F0gM+nSyRIELjs1Eq2e1R2aAYmpFyLwTPIYoLEf22MM=;
        b=f0NofJLBZm9AAlflhwdoc1I9gYgitiRyfey4PbLcvOfu50SGcZ6i4pF2V79liIldtA
         Hydg2gch9d0x1px2529fE0P5+Cg8WaNH2yR0A259ljzDRnkDryZJt7WxCPnPOG1Kbldo
         GgkcUZrjULt8h0OuwTHA83rnKYgnoigMv9A/Yhqkih6dYjDbAFAigUOwW1SzqqLYYSGp
         75qoO8y2r4WCP+uCnQpGeMdZlI1rv3s4oSnORCBMjcOUiQFhLXlEyPNGfu5tVkQ6KuyQ
         jklU/mxHYPRVFuSsBYhusJwTORdDjPFIti3Z5gkmnHNzhQrWBc4NO6ZJ7PsAkofwn0wS
         0y/w==
X-Gm-Message-State: AOAM532QhvBsWWo4+mivquMTJpgdfl5YgnkiuFAWV2ynY9GvxVCgF05A
        /q9q7JwrXwNRZuBlMsxCuGmaKdW0
X-Google-Smtp-Source: ABdhPJygca+LpWwWUoJZujsTeW5NS9HNIzilJHDrxMgCAAZKoW6A3CdSZ+yvJO6h43WVSE5C+pZbUA==
X-Received: by 2002:a0c:8cc8:: with SMTP id q8mr15361154qvb.36.1593442409269;
        Mon, 29 Jun 2020 07:53:29 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d135sm7075qkg.117.2020.06.29.07.53.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:53:28 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TErSnF006221;
        Mon, 29 Jun 2020 14:53:28 GMT
Subject: [PATCH v1 0/4] More code de-duplication
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:53:27 -0400
Message-ID: <20200629145150.15063.29447.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make the client and server use the same XDR utility functions for
encoding and decoding RPC/RDMA transport headers.

---

Chuck Lever (4):
      svcrdma: Remove declarations for functions long removed
      SUNRPC: Add helpers for decoding list discriminators symbolically
      svcrdma: Add common XDR decoders for RDMA and Read segments
      svcrdma: Add common XDR encoders for RDMA and Read segments


 include/linux/sunrpc/rpc_rdma.h          | 74 ++++++++++++++++++++++++
 include/linux/sunrpc/xdr.h               | 26 +++++++++
 net/sunrpc/xprtrdma/frwr_ops.c           |  1 -
 net/sunrpc/xprtrdma/rpc_rdma.c           | 31 ++++------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 21 +++----
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 37 +++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  9 +--
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  1 -
 8 files changed, 137 insertions(+), 63 deletions(-)

--
Chuck Lever
