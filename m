Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414F123D2FA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 22:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHEU0k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 16:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHEU0k (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Aug 2020 16:26:40 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0EFB22B42
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 20:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659199;
        bh=SNIwSAArg8ZICmFa9PpKHz0Jro0pjiLrIkBnphZaOAk=;
        h=From:To:Subject:Date:From;
        b=0dZAXpRER01UOnFfO4G8IMPlxYLdy3x6DQS21Gm9PtkB2zCb0d7dmeYUNOX182Ew1
         3Efp3upHiv2Pl1byPHYuTDKijrKJkuTI9Se0gxXBDS0SRBaH4ijUpyDe4Te2Ra7NoX
         aEBBFRGgLwKPH2OBVx3PWX1fmf62IzJM1reybPKA=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] Don't do pNFS I/O when not holding a layout
Date:   Wed,  5 Aug 2020 16:24:29 -0400
Message-Id: <20200805202431.627013-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We recently discovered a couple of issues in the pNFS client that can
cause it to return a layout while some of the layout segments being
returned are still in use for I/O.

The following 2 patches will add appropriate tests to ensure this
cannot happen, and that the layoutreturn call is delayed until
the outstanding I/O is finished.

Trond Myklebust (2):
  NFS: Don't move layouts to plh_return_segs list while in use
  NFS: Don't return layout segments that are in use

 fs/nfs/pnfs.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

-- 
2.26.2

