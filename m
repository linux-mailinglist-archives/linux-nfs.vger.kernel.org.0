Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4445F42C39F
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhJMOm6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236692AbhJMOm5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:42:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28F6661100;
        Wed, 13 Oct 2021 14:40:54 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 0/3] Update synopsis of .pc_encode callback
Date:   Wed, 13 Oct 2021 10:40:52 -0400
Message-Id:  <163413598146.5966.14139533676554616065.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; h=from:subject:message-id; bh=hRPr58ygxKEeyNoLD0UoMMJ0R/62wBa1/b7ewvzYM2w=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZu/uvjOL3SJABjxls3VpLIJr4hFhAXVPPt1WNWvl fks8xMmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbv7gAKCRAzarMzb2Z/l7IDEA COEhXZcqfFno9zmK+pSnnnTKpsAeSZjNC7xTXe7VZNBgMoh9MSxyPgvwT7vVrSHMnYoEHrRhxnuoSo Ytid83rkN+EI2PNiGrNOb4e8C2uoF1kcOQTdRePDvMd3ATofdhhAus3gZ22Wot2FmamqIk1yGU92SS 8v8B5+yUQepAv2zWksajbJYZyeck4Nm4b+mCjgsb6X4mR1xT42uewKoTslS9O/zF3FGhq43iGJcNzr gqMIOEV2E/YIM//MSrXJKLbnBmF4PkpwMauJiKSVeKzWSlmuR0Y3o8t4KGyuNvA0A0LAzoShgsFags CF1sYI3V5Lly80cSslqZHBLt9Bxm/3zov8lpHs9CzTuTk2i3Kkrc5ukpsyl835KQp/g3NFjEbHVSe5 r9HhBZGLr42p0iglQcvm/rGaDjtsh29vcl3i+FWNU2arA3Qo5NrLBGK1+KLCMlIsutki4FX5sSThYu +ly6VU61AaaAjtzUJpjuvlHFg9Y1oD0xEHqqPDnvd6ISN1nby/cj94U+NXzEsAYdDAEhYzxhCm6SyM dIKEZTIvtewl+azF5VBVOm7zBnLkzbelv3o4H/gnMHsNBzTpuuLQmE8h6MJcOgVbnugOg1lK1xo5mf 8wXi03aMMTOzmtrfpb8Q9WvZn55S39ext0DpAysHrdv+GTTXqG7Xcx8Re8sg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

Similar changes to the encode side.

---

Chuck Lever (3):
      NFSD: Save location of NFSv4 COMPOUND status
      SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
      SUNRPC: Change return value type of .pc_encode


 fs/lockd/svc.c             |   3 +-
 fs/lockd/xdr.c             |  29 +++--
 fs/lockd/xdr4.c            |  29 +++--
 fs/nfs/callback_xdr.c      |   4 +-
 fs/nfsd/nfs2acl.c          |   8 +-
 fs/nfsd/nfs3acl.c          |  22 ++--
 fs/nfsd/nfs3xdr.c          | 210 +++++++++++++++++--------------------
 fs/nfsd/nfs4proc.c         |   2 +-
 fs/nfsd/nfs4xdr.c          |  20 ++--
 fs/nfsd/nfsd.h             |   3 +-
 fs/nfsd/nfssvc.c           |  15 ++-
 fs/nfsd/nfsxdr.c           |  82 +++++++--------
 fs/nfsd/xdr.h              |  14 +--
 fs/nfsd/xdr3.h             |  30 +++---
 fs/nfsd/xdr4.h             |   5 +-
 include/linux/lockd/xdr.h  |   8 +-
 include/linux/lockd/xdr4.h |   8 +-
 include/linux/sunrpc/svc.h |   3 +-
 18 files changed, 237 insertions(+), 258 deletions(-)

--
Chuck Lever
