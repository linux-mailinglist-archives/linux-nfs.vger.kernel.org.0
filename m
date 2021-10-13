Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E641542C3D5
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhJMOsz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJMOsy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:48:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9FCC61130;
        Wed, 13 Oct 2021 14:46:50 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v1 0/6] Deprecate dprintk in svcrdma
Date:   Wed, 13 Oct 2021 10:46:49 -0400
Message-Id:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; h=from:subject:message-id; bh=YCGRb8xHZS5yWGnC34bFblYTFkDnp8mHiEec8qmMvaQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvFZwREFiAh2kPMkywXWLxxVabdVPMMUDQj2U2bC EgLlnL+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbxWQAKCRAzarMzb2Z/lypUEA C8o9F4fJbOXcXAIF9//TuKWYyQP9lvY+3wfO/X7jV8TxysboI6bJxe6e9Fa1oe0MVrWq1+NEXV58Al 0yFdAYI+DRSPUcuDhGzOmdiMS9i4gnbxAvHBjy8AXFR0saHsNz0D2jh97mGUdpuwKrA27nU8+TdIk8 Z6hloZPwfUK7uitM41/Eq6uufRTEaOR1TPg1sM36cUrF/geDQ4f8E3k+IwiXKXXdD2vMAbKp2FyuBb Flz6UUUO/Z20yU3X6oTW/RJi7M9z9kUVJynjQTXASelRokbyI0HrKIpAQx2Bu/24mYJN+KhJJpw1W1 qQT86iyrv7Vm3yoZIOZmjcVyMuAxTUrZNAYnJRPQTARLvHBMHFVHYNcGxvW60Id29NJlREmYZo8Y4Z b4NuvWZZT8j7EktFNghaQBHhvLUt3borRizIaqLj7NsrvhyJopmg3hsvMilfKDyjjbP0wVMPtdxJ+H r/hjjbGDqx6GEg7FwHRlgzSL7X9wiOx7Bu3Kc4W9YyIfKKDYGJX5YZN28IKBEo3o6RCSkJXUAgvHQQ JnHtQfCra+d0nnizCL+tFeGoYD5z851nG48uP8xWXxuR6t2eCy6Pd000iKKO8JZ+2m0t9DUfsBq1rM sixUiHG3g5rBiviulhen131JYI5XBvnIeG1AWWe2A5h+kzNqU1aup2BTupwg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch series moves forward with the removal of dprintk in
SUNRPC in favor of tracepoints. This is the last step for the
svcrdma component.

---

Chuck Lever (6):
      svcrdma: Remove dprintk() call sites in module handlers
      svcrdma: Remove dprintk call site in svc_rdma_create_xprt()
      svcrdma: Remove dprintk call site in svc_rdma_parse_connect_private()
      svcrdma: Remove dprintk call sites during QP creation
      svcrdma: Remove dprintk call sites during accept
      svcrdma: Remove include/linux/sunrpc/debug.h


 net/sunrpc/xprtrdma/svc_rdma.c           |  9 ------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  1 -
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  1 -
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 37 ++----------------------
 4 files changed, 3 insertions(+), 45 deletions(-)

--
Chuck Lever
