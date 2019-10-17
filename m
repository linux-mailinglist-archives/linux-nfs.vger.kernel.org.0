Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C5DDB62F
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404552AbfJQSba (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 14:31:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45084 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSb3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 14:31:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so4984450qtj.12;
        Thu, 17 Oct 2019 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tg+NkdbkgiRH9rURMmOHWE9wg09lS+D0EM34LImt5Zc=;
        b=Mw7uz7kJ/EPMNk2obrHeVOc8jYLtLXsG94FYBO3fyurEbCni6othi6/R8DsVvzyU2X
         2yXokeIlKrF7bl6nISGkuL79VDhnehhA87xvfWr6fKYo6siss7TwlrhkvaEIgP50Qjg1
         l8vpHWUj/SIihzc+cQfl8vkcan6aIKZDRtOx9w65pQFxyl/yYA/nudHpYnd9M7aUKCNj
         jVClJvVu9cW3RD3moNiw3i1KK0ikFp6In02MIAh9QZVyJIvrC3FM4PCkcA8yJKLOnlV2
         EyrZaC5n/evNbbVcPIA3NOHDuVi7VN3g//qeNbBsKBznm51ILbzEP8FLlV4BVk9rXLpm
         uL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tg+NkdbkgiRH9rURMmOHWE9wg09lS+D0EM34LImt5Zc=;
        b=uXQQuTM30AffUEAKDHCddomrU2WbJ4RNwKefIRWP4epcTcvpJZEo87hYS4xVKj6m6d
         UWoHG/wEDrhFfgpWAOYIlE+gtN6m4Sz0GB/+9jk60dcT1h6/YqkIHJQ6ZSv014BCpRXJ
         QRzRfxqeEfRuoh0op6IRD2qXpb95J0fGrQgEC1/xJ0ytwfzMZGvUWjR1GYnMDKrlZGCB
         lIglkfBJm3IPjBN7Zfemc5OrTDLFjApZLLNWkkD91K3TNXlXqrvOvvO09vXW4AI/ahvd
         J9yAcxkBbvHX9KsXkIi3aJWSmsXI+L91aBy2TxGhmNmO+u7ttV4L9mNtNjoAME/3gzxO
         zg0Q==
X-Gm-Message-State: APjAAAX5Pr8kQLcu6cVN9gTBBUyzHpDMrl9FliJyj6eMVS2DjA1SoUOV
        9PIaRN8QTIA/C+6yaRioSllp+mqt
X-Google-Smtp-Source: APXvYqxRE5YuEBKE6QW1nt6M0YM2uFFxG84sBysU2ExniLqXweB5x0Id447urK4eZcTGAa73gEWaFw==
X-Received: by 2002:ac8:6c4:: with SMTP id j4mr5349748qth.235.1571337088825;
        Thu, 17 Oct 2019 11:31:28 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id p36sm2492111qtc.0.2019.10.17.11.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:31:28 -0700 (PDT)
Subject: [PATCH v1 3/6] xprtrdma: Remove rpcrdma_sendctx::sc_device
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 14:31:27 -0400
Message-ID: <20191017183127.2517.53756.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: Save eight bytes in a frequently allocated
structure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    4 ++--
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 7b13582..1941b22 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -564,6 +564,7 @@ static void rpcrdma_sendctx_done(struct kref *kref)
  */
 void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 {
+	struct rpcrdma_regbuf *rb = sc->sc_req->rl_sendbuf;
 	struct ib_sge *sge;
 
 	if (!sc->sc_unmap_count)
@@ -575,7 +576,7 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 	 */
 	for (sge = &sc->sc_sges[2]; sc->sc_unmap_count;
 	     ++sge, --sc->sc_unmap_count)
-		ib_dma_unmap_page(sc->sc_device, sge->addr, sge->length,
+		ib_dma_unmap_page(rdmab_device(rb), sge->addr, sge->length,
 				  DMA_TO_DEVICE);
 
 	kref_put(&sc->sc_req->rl_kref, rpcrdma_sendctx_done);
@@ -625,7 +626,6 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	 */
 	if (!rpcrdma_regbuf_dma_map(r_xprt, rb))
 		goto out_regbuf;
-	sc->sc_device = rdmab_device(rb);
 	sge_no = 1;
 	sge[sge_no].addr = rdmab_addr(rb);
 	sge[sge_no].length = xdr->head[0].iov_len;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 4897c09..0e5b7f3 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -221,7 +221,6 @@ enum {
 struct rpcrdma_sendctx {
 	struct ib_send_wr	sc_wr;
 	struct ib_cqe		sc_cqe;
-	struct ib_device	*sc_device;
 	struct rpcrdma_req	*sc_req;
 	unsigned int		sc_unmap_count;
 	struct ib_sge		sc_sges[];

