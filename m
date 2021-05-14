Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8583381121
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhENT4Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232211AbhENT4Y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:56:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14CA961444;
        Fri, 14 May 2021 19:55:11 +0000 (UTC)
Subject: [PATCH v3 00/24] NFSD callback and lease management observability
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:55:11 -0400
Message-ID: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've hacked together some improvements to the tracepoints that record
server callback and lease management activity. I'm interested in
review comments and testing. I'm sure I've missed your favorite edge
case, so please let me know what it is!


Changes since v2:
- Postponed '%.s' fix-ups so the series applies to v5.13-rc1 as-is
- Split up the nfsd_clid_expired tracepoint
- Add nfserr and cp_count to the nfsd_cb_offload tracepoint

Changes since RFC:
- Rebased firmly on v5.13-rc1
- Re-organized the SETCLIENTID/EXCHANGE_ID tracepoints
- Fixed/replaced the use of '%.*s'
- Re-ordered the series so those fixes come first

---

Chuck Lever (24):
      NFSD: Fix TP_printk() format specifier in nfsd_clid_class
      NFSD: Add an RPC authflavor tracepoint display helper
      NFSD: Add nfsd_clid_cred_mismatch tracepoint
      NFSD: Add nfsd_clid_verf_mismatch tracepoint
      NFSD: Remove trace_nfsd_clid_inuse_err
      NFSD: Add nfsd_clid_confirmed tracepoint
      NFSD: Add nfsd_clid_reclaim_complete tracepoint
      NFSD: Add nfsd_clid_destroyed tracepoint
      NFSD: Add a couple more nfsd_clid_expired call sites
      NFSD: Add tracepoints for SETCLIENTID edge cases
      NFSD: Add tracepoints for EXCHANGEID edge cases
      NFSD: Constify @fh argument of knfsd_fh_hash()
      NFSD: Capture every CB state transition
      NFSD: Drop TRACE_DEFINE_ENUM for NFSD4_CB_<state> macros
      NFSD: Add cb_lost tracepoint
      NFSD: Adjust cb_shutdown tracepoint
      NFSD: Remove spurious cb_setup_err tracepoint
      NFSD: Enhance the nfsd_cb_setup tracepoint
      NFSD: Add an nfsd_cb_lm_notify tracepoint
      NFSD: Add an nfsd_cb_offload tracepoint
      NFSD: Replace the nfsd_deleg_break tracepoint
      NFSD: Add an nfsd_cb_probe tracepoint
      NFSD: Remove the nfsd_cb_work and nfsd_cb_done tracepoints
      NFSD: Update nfsd_cb_args tracepoint


 fs/nfsd/nfs4callback.c |  45 ++++----
 fs/nfsd/nfs4proc.c     |   2 +
 fs/nfsd/nfs4state.c    |  88 +++++++++------
 fs/nfsd/nfsfh.h        |   7 +-
 fs/nfsd/trace.h        | 249 +++++++++++++++++++++++++++++++----------
 5 files changed, 270 insertions(+), 121 deletions(-)

--
Chuck Lever

