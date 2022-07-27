Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888E85832EC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiG0THZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiG0TGy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449FE52FF1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F1F6197E
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33222C433D6
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:39:58 +0000 (UTC)
Subject: [PATCH v2 00/13] Put struct nfsd4_copy on a diet
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:39:57 -0400
Message-ID: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While testing NFSD for-next, I noticed svc_generic_init_request()
was an unexpected hot spot on NFSv4 workloads. Drilling into the
perf report, it shows that the hot path in there is:

1208         memset(rqstp->rq_argp, 0, procp->pc_argsize);
1209         memset(rqstp->rq_resp, 0, procp->pc_ressize);

For an NFSv4 COMPOUND,

	procp->pc_argsize = sizeof(nfsd4_compoundargs),

struct nfsd4_compoundargs on my system is more than 17KB! This is
due to the size of the iops field:

	struct nfsd4_op                 iops[8];

Each struct nfsd4_op contains a union of the arguments for each
NFSv4 operation. Each argument is typically less than 128 bytes
except that struct nfsd4_copy and struct nfsd4_copy_notify are both
larger than 2KB each.

Changes since v1:
- Fix a compile-time bug spotted by the kernel 0-day robot
- Fix a crasher reported by Dai, then by Olga
- Add two more clean-up patches

---

Chuck Lever (13):
      NFSD: Fix strncpy() fortify warning
      NFSD: nfserrno(-ENOMEM) is nfserr_jukebox
      NFSD: Shrink size of struct nfsd4_copy_notify
      NFSD: Shrink size of struct nfsd4_copy
      NFSD: Reorder the fields in struct nfsd4_op
      NFSD: Make nfs4_put_copy() static
      NFSD: Make boolean fields in struct nfsd4_copy into atomic bit flags
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
      NFSD: Refactor nfsd4_do_copy()
      NFSD: Remove kmalloc from nfsd4_do_async_copy()
      NFSD: Add nfsd4_send_cb_offload()
      NFSD: Move copy offload callback arguments into a separate structure


 fs/nfsd/nfs4callback.c  |  37 +++++----
 fs/nfsd/nfs4proc.c      | 169 ++++++++++++++++++++--------------------
 fs/nfsd/nfs4xdr.c       |  33 +++++---
 fs/nfsd/state.h         |   1 -
 fs/nfsd/xdr4.h          |  54 +++++++++----
 include/linux/nfs_ssc.h |   2 +-
 6 files changed, 167 insertions(+), 129 deletions(-)

--
Chuck Lever

