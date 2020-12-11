Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3988A2D7CC9
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395209AbgLKR0e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395175AbgLKR0C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:02 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/15] Fixes for the NFSv4.2 READ_PLUS operation
Date:   Fri, 11 Dec 2020 12:25:06 -0500
Message-Id: <20201211172521.5567-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The patches are divided into two parts:
1) A set of SUNRPC patches to fix and clean up the XDR decoding
operations that are used by READ_PLUS, READ and READDIR. The main focus
is on the operations used to shift data left and right in pages.
2) A set of patches to the NFSv4.2 READ_PLUS client code. These mainly
try to fix issues around bounds checking, but also fix at least one
protocol conformance problem.

--
v2: - Fix corner cases when calling xdr_shrink_bufhead() and
      xdr_shrink_pagelen() with shorter values of buf->len
    - Fix xdr_buf helper functions to take a length parameter so we can
      optimise shorter values of buf->len more easily.
    - Fix issues with sparse pages reported by Tigran
    - Disable use of READ_PLUS in pNFS.
    - Move nfsd patches into a separate series.


Trond Myklebust (15):
  SUNRPC: _shift_data_left/right_pages should check the shift length
  SUNRPC: Fixes for xdr_align_data()
  SUNRPC: Fix xdr_expand_hole()
  SUNRPC: Cleanup xdr_shrink_bufhead()
  SUNRPC: _copy_to/from_pages() now check for zero length
  SUNRPC: Clean up open coded setting of the xdr_stream 'nwords' field
  SUNRPC: Cleanup - constify a number of xdr_buf helpers
  SUNRPC: When expanding the buffer, we may need grow the sparse pages
  NFSv4.2: Ensure we always reset the result->count in
    decode_read_plus()
  NFSv4.2: decode_read_plus_data() must skip padding after data segment
  NFSv4.2: decode_read_plus_hole() needs to check the extent offset
  NFSv4.2: Handle hole lengths that exceed the READ_PLUS read buffer
  NFSv4.2: Don't error when exiting early on a READ_PLUS buffer overflow
  NFSv4.2: Deal with potential READ_PLUS data extent buffer overflow
  NFSv4.2/pnfs: Don't use READ_PLUS with pNFS yet

 fs/nfs/nfs42xdr.c          |  78 ++--
 fs/nfs/nfs4proc.c          |  15 +-
 include/linux/sunrpc/xdr.h |  26 +-
 net/sunrpc/xdr.c           | 735 ++++++++++++++++++++++++-------------
 4 files changed, 554 insertions(+), 300 deletions(-)

-- 
2.29.2

