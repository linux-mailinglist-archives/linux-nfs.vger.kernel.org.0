Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB441E2FC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Sep 2021 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbhI3VHx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Sep 2021 17:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhI3VHx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Sep 2021 17:07:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4591B61037;
        Thu, 30 Sep 2021 21:06:10 +0000 (UTC)
Subject: [PATCH v1 0/2] NFSD: Clean ups for recent XDR work
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 30 Sep 2021 17:06:09 -0400
Message-ID: <163303585936.5125.6042907247616993649.stgit@klimt.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

As we discussed, here are a couple of minor improvements for the
xdr_stream_subsegment() API added when the NFSv4 XDR functions were
recently overhauled. Notably, the second patch changes the NFSv2 and
NFSv3 decoders to work like the NFSv4 one.

---

Chuck Lever (2):
      SUNRPC: xdr_stream_subsegment() must handle non-zero page_bases
      NFSD: Have legacy NFSD WRITE decoders use xdr_stream_subsegment()


 fs/nfsd/nfs3proc.c         |  3 +--
 fs/nfsd/nfs3xdr.c          | 12 ++----------
 fs/nfsd/nfs4proc.c         |  3 +--
 fs/nfsd/nfsproc.c          |  3 +--
 fs/nfsd/nfsxdr.c           |  9 +--------
 fs/nfsd/xdr.h              |  2 +-
 fs/nfsd/xdr3.h             |  2 +-
 include/linux/sunrpc/svc.h |  3 +--
 net/sunrpc/svc.c           | 11 ++++++-----
 net/sunrpc/xdr.c           | 32 +++++++++++++++++---------------
 10 files changed, 32 insertions(+), 48 deletions(-)

--
Chuck Lever

