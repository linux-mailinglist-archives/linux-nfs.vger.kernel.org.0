Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718622D44B3
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 15:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbgLIOs7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 09:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733204AbgLIOsr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 09:48:47 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/16] Fixes for the NFSv4.2 READ_PLUS operation
Date:   Wed,  9 Dec 2020 09:47:45 -0500
Message-Id: <20201209144801.700778-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The patches are divided into three parts:
1) A set of SUNRPC patches to fix and clean up the XDR decoding
operations that are used by READ_PLUS, READ and READDIR. The main focus
is on the operations used to shift data left and right in pages.
2) A set of patches to the NFSv4.2 READ_PLUS client code. These mainly
try to fix issues around bounds checking, but also fix at least one
protocol conformance problem.
3) A couple of patches for the READ_PLUS server code. These fix issues
when nfsd_readv() returns fewer bytes than the maximum requested, and
when the READ_PLUS gets truncated.

The patches are intended to apply on top of my existing 'testing' branch
in git.linux-nfs.org.

Trond Myklebust (16):
  SUNRPC: _shift_data_left/right_pages should check the shift length
  SUNRPC: Fixes for xdr_align_data()
  SUNRPC: Fix xdr_expand_hole()
  SUNRPC: Cleanup xdr_shrink_bufhead()
  SUNRPC: _copy_to/from_pages() now check for zero length
  SUNRPC: Clean up open coded setting of the xdr_stream 'nwords' field
  SUNRPC: Cleanup - constify a number of xdr_buf helpers
  SUNRPC: Avoid unnecessary copies in xdr_buf_pages_copy_left/right()
  NFSv4.2: Ensure we always reset the result->count in
    decode_read_plus()
  NFSv4.2: decode_read_plus_data() must skip padding after data segment
  NFSv4.2: decode_read_plus_hole() needs to check the extent offset
  NFSv4.2: Handle hole lengths that exceed the READ_PLUS read buffer
  NFSv4.2: Don't error when exiting early on a READ_PLUS buffer overflow
  NFSv4.2: Deal with potential READ_PLUS data extent buffer overflow
  nfsd: Fixes for nfsd4_encode_read_plus_data()
  nfsd: Don't set eof on a truncated READ_PLUS

 fs/nfs/nfs42xdr.c          |  78 +++--
 fs/nfsd/nfs4xdr.c          |  14 +-
 include/linux/sunrpc/xdr.h |  26 +-
 net/sunrpc/xdr.c           | 674 +++++++++++++++++++++++--------------
 4 files changed, 493 insertions(+), 299 deletions(-)

-- 
2.29.2

