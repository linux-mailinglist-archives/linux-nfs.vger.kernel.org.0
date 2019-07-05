Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE960B27
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2019 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfGERki (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jul 2019 13:40:38 -0400
Received: from fieldses.org ([173.255.197.46]:35736 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfGERki (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Jul 2019 13:40:38 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A4D0D1D27; Fri,  5 Jul 2019 13:40:37 -0400 (EDT)
Date:   Fri, 5 Jul 2019 13:40:37 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd bugfixes for 5.2
Message-ID: <20190705174037.GA4203@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-2

Two more quick bugfixes for nfsd, fixing a regression causing mount
failures on high-memory machines and fixing the DRC over RDMA.

--b.

Chuck Lever (1):
      svcrdma: Ignore source port when computing DRC hash

Paul Menzel (1):
      nfsd: Fix overflow causing non-working mounts on 1 TB machines

 fs/nfsd/nfs4state.c                      | 2 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
