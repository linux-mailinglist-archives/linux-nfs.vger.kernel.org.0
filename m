Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A436837930D
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhEJPwq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhEJPwn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:52:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21B7C6100A;
        Mon, 10 May 2021 15:51:38 +0000 (UTC)
Subject: [PATCH RFC 00/21] NFSD callback and lease management observability
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:51:36 -0400
Message-ID: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Happy Monday.

I've hacked together some improvements to the tracepoints that record
server callback and lease management activity. I'm interested in
review comments and testing. I'm sure I've missed your favorite edge
case, so please let me know what it is!

---

Chuck Lever (21):
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
      NFSD: Add nfsd_clid_cred_mismatch tracepoint
      NFSD: Add nfsd_clid_verf_mismatch tracepoint
      NFSD: Remove nfsd_clid_inuse_err
      NFSD: Add nfsd_clid_confirmed tracepoint
      NFSD: Add nfsd_clid_destroyed tracepoint
      NFSD: Add a couple more nfsd_clid_expired call sites
      NFSD: Rename nfsd_clid_class
      NFSD: Add tracepoints to observe clientID activity


 fs/nfsd/nfs4callback.c |  45 ++++----
 fs/nfsd/nfs4proc.c     |   1 +
 fs/nfsd/nfs4state.c    |  56 +++++++---
 fs/nfsd/nfsfh.h        |   7 +-
 fs/nfsd/trace.h        | 227 ++++++++++++++++++++++++++++++++++-------
 5 files changed, 254 insertions(+), 82 deletions(-)

--
Chuck Lever

