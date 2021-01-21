Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0A2FF6AF
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 22:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbhAUVCW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 16:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbhAUVCS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 Jan 2021 16:02:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF2FA23A5A;
        Thu, 21 Jan 2021 20:53:00 +0000 (UTC)
Subject: [PATCH v1 0/2] Two small NFSD/RDMA scalability enhancements
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 Jan 2021 15:52:59 -0500
Message-ID: <161126216710.8979.7145432546367265892.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following series reduces the work done by the NFS/RDMA server-
side Receive completion handler in two ways. Details are in the
patch descriptions.

The Receive completion handler is single-threaded per transport. The
less work the handler has to do per completion, the better the
server's receive code scales.

---

Chuck Lever (2):
      svcrdma: Reduce Receive doorbell rate
      svcrdma: DMA-sync the receive buffer in svc_rdma_recvfrom()


 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--
Chuck Lever

