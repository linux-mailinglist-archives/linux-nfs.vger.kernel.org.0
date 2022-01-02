Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA6482C60
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jan 2022 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiABRfL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Jan 2022 12:35:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55230 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiABRfL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Jan 2022 12:35:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2906460F4D
        for <linux-nfs@vger.kernel.org>; Sun,  2 Jan 2022 17:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524DCC36AEB;
        Sun,  2 Jan 2022 17:35:10 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@kernel.org
Subject: [PATCH 00/10] Write verifier fixes and clean-ups
Date:   Sun,  2 Jan 2022 12:35:09 -0500
Message-Id:  <164114486506.7344.16096063573748374893.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; h=from:subject:message-id; bh=J10JekV1NgjB+a1f8j6w/hd8c+onHpbSxCbQFFVksyw=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh0eJNOB2/0uKmcgMrA2myCa9CNhjJV2F0XxLC7e8M E/k9k5WJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdHiTQAKCRAzarMzb2Z/l4+wD/ 9y4+DUR9H1M8WRFTwnfOZ6kkhVh/AL7GAUCVC93b/1ZORBr5NLq6aBvgXU6SigLOlxIyQdSvatK0QI 1lc6rCWOHS/4uVlVBynFLurJbin6+bNxx6hGNBXsXkdWiqqcbmgPBGrRJQ6Mz1Qg58jmIeASg99wHr AC2of6cZK7YH1ACLi5P2Dr9auJN0IMDgdNxPHlBikVlpM8nBwb7u/GIyO1XnxpZGvqILWtqwpdah4p lQqvl+B0J/A18tb89dk5HVF4PlJJck1dxcUS+4GPVDov12HHDF3CrgGWaRnvETMpofQGM7Hl9eii2w 75PxeePSbhAOjV0sD79cdFZCQcHuwEKklizrKv4hHCt5QcLlSJTKKmbqQ7ZdOCEIlIH6x4qmg7N9s7 L5KjstfLI433DRdsZD3QRnOHr3viszwVocoj7cwuAmt05GnQrLsVDNfk2PR4XS/mYc7TZm7o8QdmF/ HyrPcRgZVEZzN0v0AVy5bdNlpWZz9WW0RBJS8Iw7BwUI5LAiv9irCWIV9wZtk5xz0RAmQMpqhC2vzl EZzoCvcDELY1FbMEFg6sFY5jCHKXTk0Utsvvdn8zKu4UcfiTIOyVHwptsy+SGDu8SkHYr7cJ+86NMt mQTY3BXo/IlrlBvFym2FeHA6AtS6IWFrh/zO0qPAOx9y2PfRC6RVv0FRGQTQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

After a little inebriated holiday consideration, I've come to the
conclusion that returning zero verifiers to STABLE WRITE requests
as reported by Rick Macklem here:

https://lore.kernel.org/linux-nfs/YQXPR0101MB096857EEACF04A6DF1FC6D9BDD749@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM/T/

is a regression because at least one NFS client noticed the
behavior and required a code change to continue interoperating
with the Linux NFS server. The behavior also seems contrary to
spec language in RFC 8881 and RFC 1813.

To address this, I propose the following (during v5.17 merge
window):

1. Roll back
  "nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()"
  "nfsd: Replace use of rwsem with errseq_t"

2. Apply
  "NFSD: Fix verifier returned in stable WRITEs" first so
  that it has a greater opportunity to be back-ported cleanly
  to recent kernels

3. Re-apply patches rolled back in step 1 along with additional
  clean-ups.

Review will show that not all of these new clean-ups are necessary,
but they do eliminate some technical debt that has accrued over the
past few years in this area.

I'm interested in review, comments, or objections.

---

Chuck Lever (8):
      NFSD: Fix verifier returned in stable WRITEs
      NFSD: Clean up nfsd_vfs_write()
      NFSD: De-duplicate net_generic(SVC_NET(rqstp), nfsd_net_id)
      NFSD: De-duplicate net_generic(nf->nf_net, nfsd_net_id)
      NFSD: Write verifier might go backwards
      NFSD: Clean up the nfsd_net::nfssvc_boot field
      NFSD: Rename boot verifier functions
      NFSD: Trace boot verifier resets

Trond Myklebust (2):
      nfsd: Replace use of rwsem with errseq_t
      nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()


 fs/nfsd/filecache.c |   3 +-
 fs/nfsd/filecache.h |   1 -
 fs/nfsd/netns.h     |  11 ++---
 fs/nfsd/nfs4proc.c  |  20 +++++----
 fs/nfsd/nfsctl.c    |   3 +-
 fs/nfsd/nfssvc.c    |  61 ++++++++++++++++++--------
 fs/nfsd/trace.h     |  78 +++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c       | 104 ++++++++++++++++++++++----------------------
 fs/nfsd/vfs.h       |   3 +-
 9 files changed, 195 insertions(+), 89 deletions(-)

--
Chuck Lever
