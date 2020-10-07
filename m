Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37A286AD7
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 00:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgJGW01 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 18:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgJGW01 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 18:26:27 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5CAD2083B;
        Wed,  7 Oct 2020 22:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602109587;
        bh=64u+c42ysjs1XvzyG7e1nHL4Nq4BaJxvqC7RArgejy4=;
        h=From:To:Cc:Subject:Date:From;
        b=U8aZEmtmV5CUQlfgfWRytg6ub06MWvA9Rfp0eEfVIzS+AVMUN7QFK0XoCWc4FS40K
         bTin5vLSqQbuOFnSksMGQLF8DSImWEfXGIiuk/tJEW0wv79SoYO0cG8OfGh9tqw2ts
         FnQ+hkzGt66jEXA8+tJCqTkvWxva7hpi4YpcnUik=
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] Give containers a unique client id
Date:   Wed,  7 Oct 2020 18:24:16 -0400
Message-Id: <20201007222418.604115-1-trondmy@kernel.org>
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

--
v2: Fix a variable initialisation in nfs4_get_uniquifier
    Switch to using preferred strscpy()

Trond Myklebust (2):
  NFSv4: Clean up initialisation of uniquified client id strings
  NFSv4: Use the net namespace uniquifier if it is set

 fs/nfs/nfs4proc.c | 88 +++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

-- 
2.26.2

