Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD62869D8
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgJGVJ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 17:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbgJGVJ3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 17:09:29 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70702083B;
        Wed,  7 Oct 2020 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602104969;
        bh=k6WD9WRPOcIPSsOYINzks2XQ5dY7Uqc3NtHXPd2hBzo=;
        h=From:To:Cc:Subject:Date:From;
        b=zSvy3o5NMKzsXaW3+Kcb3u4yhg148+URerW2ef/DTTkEtRaEmsSnDh7W3Tki9WutO
         bVk1OEMFuUKpP+ezDxQssO6YmMbSpMuegt0pg1Zvqy6OSiWu6QpTYnktG6zpDYLpy4
         GlDBG6v+zruWadTaSZ5notCfHb9Y5Ujs5D5l3p78=
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Give containers a unique client id
Date:   Wed,  7 Oct 2020 17:07:18 -0400
Message-Id: <20201007210720.537880-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This series adds the missing patches to allow a container to set a
unique client id using /sys/fs/nfs/net/nfs_client/identifier, and
have NFS use that for any new NFS mounts that are initiated by that
container.

Trond Myklebust (2):
  NFSv4: Clean up initialisation of uniquified client id strings
  NFSv4: Use the net namespace uniquifier if it is set

 fs/nfs/nfs4proc.c | 90 ++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

-- 
2.26.2

