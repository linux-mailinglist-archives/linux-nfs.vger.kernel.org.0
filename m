Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3449BBB0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiAYTAv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:00:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55590 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiAYTAr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:00:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CB60B81A23
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 19:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FACC340E0;
        Tue, 25 Jan 2022 19:00:39 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     neilb@suse.de
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 0/2] Clean up struct svc_serv_ops
Date:   Tue, 25 Jan 2022 14:00:38 -0500
Message-Id:  <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; h=from:subject:message-id; bh=pCIi3VFJSX0kb3uum2vvD32zgM+RG9g+xMDYU+aY00A=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8EjWfD1HhA0zJrrg7df0tpmif8LGbgDHFB8nJvU0 eSSHxeOJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfBI1gAKCRAzarMzb2Z/l/o4EA Ctq41yswkCB88WdQIlliakSGA0wtvk8cO0QRJt6l8d00gEA0dAIfUJ1+NOBSnhvTs3E9dhpD1NEZ6+ vfv4D5sP65j55sVuByrsc9tOCpeZyt3J52A6rkhq/JHGQp+DtOvzbvWtoo8V5CkqSj1c/6W6rxoqzt jKqls/xfE7X+FoYuIOoK0S0PXGaWgIkPzyZ4lMK7dH61Pz+PyH8IwLnJn7BfASbjP+ie4IB0cIXFqE ZQhjPhP8Y/GSeJlSVh/nPUCVk6Rmk/2v/jOWNSmMspf4TGlytTAzlAkWHnL6NGZRjGABU1JItbVPMy FJ7IZS9MsXApmp186YP5ItN4oWgnMYrDqVQLTOAJStcOtuLq+oibV7wtpPgIGOyYWdyQngGZARCD5L 4QPuNb8V/MderhyzHlMbW/la6+4FQTPSW7L7g6xnNYA6sHqk5hcvaZajdB4JWnjyThT+DcKDuOdXsf OPk5fqphVnUA7YmoyYzspChwo0g0kpN5PNYeAY4oD0H88nFM72r5oofJcVllDoCdl+rooa8U4TpR+o dRnz1fj2TYYmInxXcPp+SS/4y0Yx5BzNNcOoCQep8v8Y4pUnLdpgF6UbG4CPMQ3fdfj2LwViRz6JDZ DPnJgZm3UsYRzie7LJXMEOr5LocUefNBprLW9ir31O20EdkaiwZQGh7TtFeA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've started a series of patches to clean out and remove struct
svc_serv_ops, as suggested by Neil Brown. First two patches remove
svo_enqueue_xprt and svo_shutdown, but I'm not quite sure how to
replace svo_module, so I've stopped there for the moment.

Neil, do you have a suggestion or patch that removes svo_module?

Once that is done we can finish with a patch that hoists
.svo_function into struct svc_serv.

---

Chuck Lever (2):
      SUNRPC: Remove the .svo_enqueue_xprt method
      SUNRPC: Remove svo_shutdown method


 fs/lockd/svc.c                  |  6 ++----
 fs/nfs/callback.c               |  2 --
 fs/nfsd/nfssvc.c                |  3 +--
 include/linux/sunrpc/svc.h      |  6 ------
 include/linux/sunrpc/svc_xprt.h |  1 -
 net/sunrpc/svc.c                |  3 ---
 net/sunrpc/svc_xprt.c           | 10 +++++-----
 7 files changed, 8 insertions(+), 23 deletions(-)

--
Chuck Lever
