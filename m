Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F495127
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfHSWuj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:50:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40496 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWuj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:50:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so3244198otb.7;
        Mon, 19 Aug 2019 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QtZX51bpSlxp8tlege0urIMMQj34aAPxmb0sf5uCYXM=;
        b=oIw1/8UEGIxajiHg1UCPkV4cItEpw6oYHjHFsGLPyZ/b+w4n6AGOJN66MwdA2wfNlX
         026K/4knO4J0Hx1tX0oomDjmomje2hhN6sIuoI3R4MO2nNKlPFDqLMwhY9ZEq7GlB1CF
         VWIcnCL+FMhXO7ObFk28L1naMyZqWemcZaWujndftCLFxRH9oyCaJg6hPdcaYj08OBL2
         GV2rf4WQZ2mbTdlvHiByvFGopjQiFkIORzm6uPpRUUMp9xmIDXaAfvMjC1dwgdg5Y++a
         3ob1wmlP87bezeNgiuXykYrFsqI2jfAJpo8hcTtp60QCONU0UH/2mQVLYJoXoIA3588X
         NGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QtZX51bpSlxp8tlege0urIMMQj34aAPxmb0sf5uCYXM=;
        b=IKeV/S3ddJwGDv0DzvXc8m4kbCQkqM9jhWN3zWInUw424to/7QMwxxQEELK6BywvRC
         RQsT+gseIHuLACqifg/WJfdKtWJZj/1Gq2N2cP3VPVx5o0HCEhKWcL1eqXH+M0EJJzyA
         UX/F02MdY85F7AfDMCYQN4I6OHBptri5j6OJS6ezf9laCQBW4xenzRmRoovkWaBA1Wkj
         HIV+1lZdWzr8/5Q5nfbIs122jtfUfDDz95EGEKBxujS8xRqFqP7pvPFt6EHtiLGsXEfk
         /U/BzhBisR2ylPdt1us3ZxdeixCI05puBvfrgpUqeaxoObl0ESpGK7UcH+D6pfyo5Le6
         YEtw==
X-Gm-Message-State: APjAAAVt8nKHf1qLVY5xLNptiT8WnHTjtjN2ZkI+UVy3w7UD0/tdeoPk
        M6B68wTzbTNtQnu1BRkNCf/qFu3m
X-Google-Smtp-Source: APXvYqxfLChYNY3Dhx0o7TaSJ8oIEBkd0TN61/5xsGIMHvaGnYT9YgrGmVDbwHs4ZdRngej30RLs/w==
X-Received: by 2002:a05:6830:1085:: with SMTP id y5mr19068922oto.214.1566255038223;
        Mon, 19 Aug 2019 15:50:38 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id w18sm5977745otk.22.2019.08.19.15.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:50:37 -0700 (PDT)
Subject: [PATCH v2 19/21] xprtrdma: Fix bc_max_slots return value
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:50:16 -0400
Message-ID: <156625499660.8161.16372104759177233644.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For the moment the returned value just happens to be correct because
the current backchannel server implementation does not vary the
number of credits it offers. The spec does permit this value to
change during the lifetime of a connection, however.

The actual maximum is fixed for all RPC/RDMA transports, because
each transport instance has to pre-allocate the resources for
processing BC requests. That's the value that should be returned.

Fixes: 7402a4fedc2b ("SUNRPC: Fix up backchannel slot table ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 59e624b1d7a0..50e075fcdd8f 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -54,9 +54,7 @@ size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *xprt)
 
 unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *xprt)
 {
-	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
-
-	return r_xprt->rx_buf.rb_bc_srv_max_requests;
+	return RPCRDMA_BACKWARD_WRS >> 1;
 }
 
 static int rpcrdma_bc_marshal_reply(struct rpc_rqst *rqst)

