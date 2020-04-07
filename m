Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1CD1A1598
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDGTKz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 15:10:55 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:35433 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTKz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 15:10:55 -0400
Received: by mail-qk1-f181.google.com with SMTP id k134so588860qke.2;
        Tue, 07 Apr 2020 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/4bUw7+wMtjsSD4LYclu/0Z5AW7mD3lXnarzF+2do9w=;
        b=ZEunXeNXNngc7PViZ7ipEXTKwQvGhoj3hUORzakyfwrkjIwtIaQYuz5tVIzCXV5T6I
         OiHFNRHlgNFd9p5t5ZyRCpCvfLX46jDGlotEjyAR1BHnyWAMHyrA2iYHIqV71oHD4zPi
         yi1oBHRPOvLvvmMcAtZyIKng99UsUii5OT6JvDlXEiJlRVQ5budJlDWssMv7HLOVBjT/
         wbb04Tc4yVaNGRL09bywzx681saN2UFngprAzq9LznTlWuOwD2AWZVGOMZSGINUiTXYm
         xdk3rCN/MnKGGtROdLYQy3CiFEvHMaP9adbQxQZUDpmyIbFp7EX7NaxWuPDGvbemVI8a
         iliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/4bUw7+wMtjsSD4LYclu/0Z5AW7mD3lXnarzF+2do9w=;
        b=LX3A3xlzjLSLFD3W5E5BQNbLitls2rHcTDizjyHI+VyEMXA1OnlNac3fh11zCXOQnv
         Ma6UIXtbjJtTeEuVq/adYcMv0uvsYjknX3uWlL7Hjb/6q20qlEWjhenRFPKoHf53JZJh
         bq42tCQTnOwVIMsmj2QBBB7z+rvEZ2ZV32SjIlybiHtXJ4P5STP47tTch5zYIRsyG6RM
         DJIJNvVUUzC8lJvtxEJj5koxeKxWQljyhNY3f+v/hCYHtGBMdJ67t8XdcaZpPbHS0+wO
         eo4TT8rKnCkeJ8//Kg6wHOQy7JEOwnhQq++atMPtrGgrCJ8hPfMTlXBt8RkwHlY7VQ10
         7LRA==
X-Gm-Message-State: AGi0PuZkLc6dlkW8E9oXtKLH9k9PA5C4qJtDjsVpdhwEPb2zdHTkjDwS
        KOTmqKTHlPLBa67MFxWA1GAUy1Q3
X-Google-Smtp-Source: APiQypKN19ji7kr4EbK7g06cHx8DxxAZkTjh43M5BwlNhZiQIlw8Hf+TN5CEN3Hjj68+8JLnEfqfaQ==
X-Received: by 2002:a05:620a:2052:: with SMTP id d18mr3678170qka.362.1586286652565;
        Tue, 07 Apr 2020 12:10:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s32sm59367qth.43.2020.04.07.12.10.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:10:52 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 037JAnGT010255;
        Tue, 7 Apr 2020 19:10:50 GMT
Subject: [PATCH v1 0/3] NFS/RDMA server fixes for 5.7-rc
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 07 Apr 2020 15:10:49 -0400
Message-ID: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-8-g198f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For review, the following three patches address bugs in the Linux
NFS/RDMA server implementation.

---

Chuck Lever (3):
      svcrdma: Fix trace point use-after-free race
      SUNRPC: Remove naked ->xpo_release_rqst from svc_send()
      svcrdma: Fix leak of svc_rdma_recv_ctxt objects


 include/linux/sunrpc/svc_rdma.h          |  1 +
 net/sunrpc/svc_xprt.c                    |  3 ---
 net/sunrpc/svcsock.c                     |  4 ++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 22 ++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 13 +++----------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  5 -----
 6 files changed, 30 insertions(+), 18 deletions(-)

--
Chuck Lever
