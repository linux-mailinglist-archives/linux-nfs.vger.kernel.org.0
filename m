Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6317742A8EB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 17:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhJLP7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 11:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234892AbhJLP7S (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Oct 2021 11:59:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03E3160F3A;
        Tue, 12 Oct 2021 15:57:16 +0000 (UTC)
Subject: [PATCH v1 0/2] Update synopsis of .pc_decode callback
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 Oct 2021 11:57:15 -0400
Message-ID: <163405415790.4278.17099842754425799312.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

As we discussed many moons ago, here are clean-up patches that
modernize the .pc_decode callback's synopsis, based on the
recent XDR overhaul work.

---

Chuck Lever (2):
      SUNRPC: Replace the "__be32 *p" parameter to .pc_decode
      SUNRPC: Change return value type of .pc_decode


 fs/lockd/svc.c             |   3 +-
 fs/lockd/xdr.c             | 123 +++++++++++++---------------
 fs/lockd/xdr4.c            | 124 ++++++++++++++--------------
 fs/nfsd/nfs2acl.c          |  36 ++++----
 fs/nfsd/nfs3acl.c          |  26 +++---
 fs/nfsd/nfs3xdr.c          | 163 +++++++++++++++++--------------------
 fs/nfsd/nfs4xdr.c          |  28 +++----
 fs/nfsd/nfsd.h             |   3 +-
 fs/nfsd/nfssvc.c           |  11 ++-
 fs/nfsd/nfsxdr.c           |  92 ++++++++++-----------
 fs/nfsd/xdr.h              |  21 ++---
 fs/nfsd/xdr3.h             |  31 +++----
 fs/nfsd/xdr4.h             |   2 +-
 include/linux/lockd/xdr.h  |  19 +++--
 include/linux/lockd/xdr4.h |  19 ++---
 include/linux/sunrpc/svc.h |   3 +-
 16 files changed, 334 insertions(+), 370 deletions(-)

--
Chuck Lever

