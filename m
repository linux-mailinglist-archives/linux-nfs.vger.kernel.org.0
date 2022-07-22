Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C457E82E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiGVUS7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiGVUS7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955EE7F50A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3481D61FFB
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FA2C341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:18:57 +0000 (UTC)
Subject: [PATCH v1 00/11] Put struct nfsd4_copy on a diet
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:18:56 -0400
Message-ID: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
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

I'm not yet totally convinced this series never orphans memory, but
it does reduce the size of nfsd4_compoundargs to just over 4KB. This
is still due to struct nfsd4_copy being almost 500 bytes. I don't
see more low-hanging fruit there, though.

---

Chuck Lever (11):
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


 fs/nfsd/nfs4callback.c |  37 +++++----
 fs/nfsd/nfs4proc.c     | 165 +++++++++++++++++++++--------------------
 fs/nfsd/nfs4xdr.c      |  30 +++++---
 fs/nfsd/state.h        |   1 -
 fs/nfsd/xdr4.h         |  54 ++++++++++----
 5 files changed, 163 insertions(+), 124 deletions(-)

--
Chuck Lever

