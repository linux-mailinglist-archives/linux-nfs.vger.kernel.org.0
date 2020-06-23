Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97C2054DC
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2020 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgFWOfc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbgFWOfa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 10:35:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54157C061573
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2020 07:35:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id AF553923A; Tue, 23 Jun 2020 10:35:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AF553923A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592922928;
        bh=9zVtWXXaVtxfeEtJ9lKoICFco7gyIyxRpuT4dc/nMdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgVNXpHgwoEYRo/CEpAWrBbVeREdd/D74c2c2TrHzt/+aCPxOyLZ5lV6/xPz8mFCU
         ZexFxVA65PjzfPKjRQUCtqCzNtG/QT0U2dGLXabF6pGt6qZoL6iy9h23zZklOdsxDD
         gqWioBNLwbbQ8SR1/8REIliaU0aVoS1hWTSDlDMo=
Date:   Tue, 23 Jun 2020 10:35:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Subject: [PATCH] NFSv4.0 allow nconnect for v4.0
Message-ID: <20200623143528.GA18460@fieldses.org>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
 <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
 <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
 <14cad1ec0a9080ce2ac064ff9a7ae76464e09aee.camel@netapp.com>
 <20200611200919.GF16376@fieldses.org>
 <CAN-5tyFug3h+9Ck2wRfe4ALD-Pf2tzkdGh3ZCfj_zJkVuoe95g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyFug3h+9Ck2wRfe4ALD-Pf2tzkdGh3ZCfj_zJkVuoe95g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

It looks like this "else" is just a typo.  It turns off nconnect for
NFSv4.0 even though it works for every other version.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/nfs4client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

On Fri, Jun 12, 2020 at 09:26:47AM -0400, Olga Kornievskaia wrote:
> I decided not to submit this patch but anybody else is free to add
> that patch to add support for 4.0 nconnect as there is no reason it
> shouldn't be supported.

OK, resending, assuming Trond or Anna haven't already got this.--b.

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 0bd77cc1f639..5726f82bc468 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -880,7 +880,7 @@ static int nfs4_set_client(struct nfs_server *server,
 
 	if (minorversion == 0)
 		__set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
-	else if (proto == XPRT_TRANSPORT_TCP)
+	if (proto == XPRT_TRANSPORT_TCP)
 		cl_init.nconnect = nconnect;
 
 	if (server->flags & NFS_MOUNT_NORESVPORT)
-- 
2.26.2


