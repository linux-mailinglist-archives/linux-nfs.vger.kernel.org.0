Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3627247790
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgHQTuP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbgHQPTd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 11:19:33 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E8C061389;
        Mon, 17 Aug 2020 08:19:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a5so17870352ioa.13;
        Mon, 17 Aug 2020 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8BH4RpVFeN8HQQw+sm8fZ6BSx4qaDJ2dPNkdDHJsfsg=;
        b=fHLgGOcNsijUKicuPTFAQrCAQz3n3tk5iF/XFx9O+G+knGxJjfNWbvh2Y7oBevCbws
         caewExV0Gzyc+c29bVF4yUBi0R9b97WxKk2Y8GzAY4GeN/nKAUZk7Q6JVfIMQrICk5yq
         n1TqxBh3pLlx6H5O1aAUSAD6sMiNDmQeFpkJok87tyw1tqy17z4aFoF3BP+b6HhrrRZs
         ABgV8a2F+Z+WL3VA1qyt3q64btRjstbJbygPt+2KvwtYWfsrXvd1JHeXLfxYQRl8XTUa
         PgZBxgMuT/uXdNsMN/TxQpFr2zVX1cGkbATj0R19DXLuCniLFKHLfAb96Ms825pCD6si
         uMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8BH4RpVFeN8HQQw+sm8fZ6BSx4qaDJ2dPNkdDHJsfsg=;
        b=jm/XAdSRBn+CEBlQ4i6affIbWehuwE8QYhb9ZXi6HSlJDGFnN6DuNKg/5VThoEc0/j
         lfp2cz03kOFwrk72EPyidTnZPtc/oLSEpFXssXikdi4eYulcGDru4YUtIoOZ9LPXYzFy
         hQXE5R4LYPSN2lTETLyT3ZgMMz6tP8IXnAa9aOzNjnVcioGL2DPFy1CjINcrdRTu4/Eb
         zsgKLKqCNEhnSQLLQrjJL8/cZlwS6dypuWnJfeHEt0fHlmaExRnsrQ3q3DGsXDa9lpxV
         ru4bkvbYOOjJr8hyDADgfeIGrHbadHE08X7eEQ1BipLN3IjSZBYgRGgw3xumo31BIudV
         tnYw==
X-Gm-Message-State: AOAM533GQsPqWhtKeQXQCu0EAVgFpcVHTsdVJPnfY34u9u6Q/i9pqwwD
        WRURuyXpEiW8YnwZ6a4n0gtXO3c9yFN1UA==
X-Google-Smtp-Source: ABdhPJwgFPXtwXsesZlIrxRT7QtiIii1KMjENrl88rCLm2HCEgZ3JlQ6uwDBy8p+4guv9bqvl193Mg==
X-Received: by 2002:a6b:3bcf:: with SMTP id i198mr12965996ioa.194.1597677569534;
        Mon, 17 Aug 2020 08:19:29 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t14sm9205736ios.18.2020.08.17.08.19.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 08:19:28 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07HFJQcR004835;
        Mon, 17 Aug 2020 15:19:27 GMT
Subject: [PATCH RFC] xprtrdma: Release in-flight MRs on disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dan@kernelim.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 17 Aug 2020 11:19:26 -0400
Message-ID: <159767751439.190071.13659900216337230912.stgit@manet.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dan Aloni reports that when a server disconnects abruptly, a few
memory regions are left DMA mapped. Over time this leak could pin
enough I/O resources to slow or even deadlock an NFS/RDMA client.

I found that if a transport disconnects before pending Send and
FastReg WRs can be posted, the to-be-registered MRs are stranded on
the req's rl_registered list and never released -- since they
weren't posted, there's no Send completion to DMA unmap them.

Reported-by: Dan Aloni <dan@kernelim.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    2 ++
 1 file changed, 2 insertions(+)

Hi Dan, does this help?


diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 95c66a339e34..53962e41896d 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -936,6 +936,8 @@ static void rpcrdma_req_reset(struct rpcrdma_req *req)
 
 	rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
 	rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
+
+	frwr_reset(req);
 }
 
 /* ASSUMPTION: the rb_allreqs list is stable for the duration,


