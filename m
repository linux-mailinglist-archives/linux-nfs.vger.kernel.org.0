Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32402C28AB
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbgKXNu2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 08:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388565AbgKXNu1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:27 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACFD20888
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225827;
        bh=riwhDargQCc8k6XO86aIGZOD9ToDmKRTu7KD2kUQ/wI=;
        h=From:To:Subject:Date:From;
        b=TsG0sQFSyGFbuWOZwuAolHx26bCT0aJu2eh1qzc+YOxb/5BJza+IbszKi5NYYoQLw
         1d/cqBaFrhf5rRuJxs1HgBw2euL6mD23EiS11xtWrcc+CQh1i0Xd+uf39HzAXw5LmC
         /BcyWnLrxs4uDX23FgE/bWJ27oNxnBEwWmOyONM4=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/9] Fix various issues in the SUNRPC xdr code
Date:   Tue, 24 Nov 2020 08:50:16 -0500
Message-Id: <20201124135025.1097571-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When looking at the issues raised by Tigran's testing of the NFS client
updates, I noticed a couple of things in the generic SUNRPC xdr code
that want to be fixed. This patch series replaces an earlier series that
attempted to just fix the XDR padding in the NFS code.

This series fixes up a number of issues w.r.t. bounds checking in the
xdr_stream code. It corrects the behaviour of xdr_read_pages() for the
case where the XDR object size is larger than the buffer page array
length and simplifies the code.

v2:
 - Clean up the handling of page padding in rpc_prepare_reply_pages()
 - Fix up the initial read_plus() page alignment

Trond Myklebust (9):
  NFSv4: Fix the alignment of page data in the getdeviceinfo reply
  SUNRPC: Fix up typo in xdr_init_decode()
  SUNRPC: Clean up helpers xdr_set_iov() and xdr_set_page_base()
  SUNRPC: Fix up xdr_read_pages() to take arbitrary object lengths
  SUNRPC: Clean up the handling of page padding in
    rpc_prepare_reply_pages()
  SUNRPC: Fix up xdr_set_page()
  SUNRPC: Fix open coded xdr_stream_remaining()
  NFSv4: Fix open coded xdr_stream_remaining()
  NFSv4.2: Fix up read_plus() page alignment

 fs/nfs/nfs2xdr.c  |  19 ++++-----
 fs/nfs/nfs3xdr.c  |  29 +++++++------
 fs/nfs/nfs42xdr.c |   4 +-
 fs/nfs/nfs4xdr.c  |  48 ++++++++++++----------
 net/sunrpc/clnt.c |   5 +--
 net/sunrpc/xdr.c  | 101 +++++++++++++++++++++-------------------------
 6 files changed, 103 insertions(+), 103 deletions(-)

-- 
2.28.0

