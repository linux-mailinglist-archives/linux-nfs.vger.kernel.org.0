Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7B49BBA1
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiAYS43 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 13:56:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55548 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiAYS4T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 13:56:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F72DCE0AC3
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB82C340E0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:13 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] Simple NFSD reply cache clean-ups
Date:   Tue, 25 Jan 2022 13:56:11 -0500
Message-Id:  <164313689644.3172.6086810615126935434.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=443; h=from:subject:message-id; bh=G7kQwOKYGPY3yFulY80laUuR5jUEPuT82LON9WXyet4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8EfG42ZWEjGBGf3zg8OLGI9w2jVk788uF6H9sO2K ud80GXCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfBHxgAKCRAzarMzb2Z/lx4OD/ sE9ZxYznLzcFy+Zk3DTgcwL+WdJpyaYU4/uoPqdu6KlwMZuMwCQn9j1MV1xCuI7SunAzGTnmCEF8kl 91aOHdfKX0bjr3MVe/0n08UZYrGvkZbudO8NzVA0YZrLlw9+aldpyoqIfSDxXSZ8sWgJCEALviIRpW S6wkyvSxT2IyLsnQmyR8htmLhy4muKPUB+XivR2p3vqZwns7dYTZ68m2t1w2Jj/gv8OnLAC5fVrZpb SYMvplJAc72JqkOj1ebi/wB2zBmXcI2ZRe4XyzU8iV8cKbnO3MEC2M8xIXA9uX7hF8jqwQnC+k8/FP BEXSWVAYKthcut7Bx3FnmAvmatJcV0gZpKruQEjeQFBi5Gc9qlOrcZlYcnxlKZ6dsRdB3xuOXW47vl JCz8CUmww/e9XSHpnw+3/T98e5sAvR0F8UBz/b9A678yZffftx/LBGcmYYz2Ua8Des2ZkRW/gM8Z8G 5/0W8HzIMYZUPtgT6BUgImFC8asLZnbtL94hR1x5vba7aS9hBdoTbObUHFLb+sFOJY1VQdyqu7gOjL +7ldOLCz1Vo7e5CeqgPhu2Zru28UuPl1Kpm0zFMAZlDCt6iN2YB205WmNgTHNWd9/VWQ4XsdSMPkkD 7ffcDbzNdLWinEnxDNZUMhKiKQYwwgkltkjY9cJFILh1jYxcHMiCRnDhMSEA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm not sure I've posted these for review yet. These are simple
clean-ups I noticed while playing with a per-bucket Bloom filter.

---

Chuck Lever (3):
      NFSD: De-duplicate hash bucket indexing
      NFSD: Skip extra computation for RC_NOCACHE case
      NFSD: Streamline the rare "found" case


 fs/nfsd/nfscache.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

--
Chuck Lever
