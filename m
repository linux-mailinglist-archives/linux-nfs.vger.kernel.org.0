Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681C648B647
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 19:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350307AbiAKS7Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 13:59:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56334 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiAKS7X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 13:59:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 059D5616DB;
        Tue, 11 Jan 2022 18:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F53C36AE3;
        Tue, 11 Jan 2022 18:59:22 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-trace-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH RFC 0/2] Introduce variable-length sockaddr trace fields
Date:   Tue, 11 Jan 2022 13:59:20 -0500
Message-Id:  <164192738510.1149.7614903005271825552.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; h=from:subject:message-id; bh=kmgF3zW+NGHsj4Blbc3iCRBJ8JEzGlBCSzsmaKQ8rjg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh3dOD8s4D1wXX4sJQzpc3QgWDOwOp3MSNoxPnEW6j 8dWsO5CJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYd3TgwAKCRAzarMzb2Z/l/u0D/ 99uZztIYVMhpUr4VKU7Zmy/LeFO4aoxV9q1RQ+9x9fn3GIJeY1FgOwf3drHHO/5kxSOlDvLMS1klyQ fXeR+DCr6woqUmKrrn6qRbi0NDD8+vNwi7k9ZuE/NwR4lPgnHmfGfx5OTJcn7AgE2SSweBs7tym6jW cdZNTUdvh4kv/YUKtbvYwHiR1QWs73E7Pjxcc+3lzS5AozTzZOi4K1Djf8vLgUfEXjPs45oichtC2y A5ZQ4xT+xaF43IDtcIIQ52xRHM4lbaSex6Sd6aN16/sdoOfk8LYW/J3QCXBvkhCzLJfO8a8RA0M0U1 p+6JlWyeDWyg9XXQK8TSk2968oMaDTXjnA28KZvlu4B+7HPQ+LexugdV95FJ4SAzwG/8vjim2dFEWc sQP56OpvhgfKiRrkCNqGighoEXNFLGPCL31OMUWI0u8ZWk+Tnu1I+veLqd3GlKC1n3Bp8YsyJcu6dr vvsmqIriQZK07hCcKYJC5GPepEJ1IUYwXutPQXiM5VEBC/NmvQiZDNDpyX+xIqYTjQpZu4VVqu9XYM PaJpk3ixQ5es44c/R6nesXX0yRykJipEM9JQNrzVrNsGYGJJiHTfkhmYP29n4akp3MsLBKWqSw3r6s HmXjnbiaLYRh9bi235RymmNTtFHJ0arHGS0bM0BF8fi0GrPAiw6PIVKZXVmA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here's my naive first pass. Tested with a modified libtraceevent.

            nfsd-1006  [000]   615.380178: nfsd_cb_args:         addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 prog=1073741824 ident=1
            nfsd-1006  [000]   615.380242: nfsd_cb_probe:        addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 state=UNKNOWN
    kworker/u8:5-79    [002]   615.380307: nfsd_cb_setup:        addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 proto=tcp flavor=sys
    kworker/u8:4-78    [001]   615.380459: nfsd_cb_state:        addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 state=UP
            nfsd-1006  [000]   615.380599: nfsd_cb_args:         addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 prog=1073741824 ident=1
            nfsd-1006  [000]   615.380661: nfsd_cb_state:        addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 state=UNKNOWN
            nfsd-1006  [000]   615.380661: nfsd_cb_probe:        addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 state=UNKNOWN
    kworker/u8:4-78    [000]   615.380715: nfsd_cb_setup:        addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 proto=tcp flavor=sys
    kworker/u8:4-78    [000]   615.380865: nfsd_cb_state:        addr=192.168.2.67:38673 client 61ddcfcf:54b96b71 state=UP

And in the raw:

            nfsd-1006  [000]   615.380178: nfsd_cb_args:          cl_boot=61ddcfcf cl_id=54b96b71 prog=1073741824 ident=1 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
            nfsd-1006  [000]   615.380242: nfsd_cb_probe:         state=0x1 cl_boot=61ddcfcf cl_id=54b96b71 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
    kworker/u8:5-79    [002]   615.380307: nfsd_cb_setup:         cl_boot=61ddcfcf cl_id=54b96b71 authflavor=0x1 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00] netid=tcp
    kworker/u8:4-78    [001]   615.380459: nfsd_cb_state:         state=0x0 cl_boot=61ddcfcf cl_id=54b96b71 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
            nfsd-1006  [000]   615.380599: nfsd_cb_args:          cl_boot=61ddcfcf cl_id=54b96b71 prog=1073741824 ident=1 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
            nfsd-1006  [000]   615.380661: nfsd_cb_state:         state=0x1 cl_boot=61ddcfcf cl_id=54b96b71 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
            nfsd-1006  [000]   615.380661: nfsd_cb_probe:         state=0x1 cl_boot=61ddcfcf cl_id=54b96b71 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]
    kworker/u8:4-78    [000]   615.380715: nfsd_cb_setup:         cl_boot=61ddcfcf cl_id=54b96b71 authflavor=0x1 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00] netid=tcp
    kworker/u8:4-78    [000]   615.380865: nfsd_cb_state:         state=0x0 cl_boot=61ddcfcf cl_id=54b96b71 addr=ARRAY[02, 00, 97, 11, c0, a8, 02, 43, 00, 00, 00, 00, 00, 00, 00, 00]

Comments welcome.

---

Chuck Lever (2):
      trace: Introduce helpers to safely handle dynamic-sized sockaddrs
      NFSD: Use __sockaddr field to store socket addresses


 fs/nfsd/trace.h              | 79 ++++++++++++++++++------------------
 include/trace/bpf_probe.h    |  3 ++
 include/trace/perf.h         |  3 ++
 include/trace/trace_events.h | 18 ++++++++
 4 files changed, 63 insertions(+), 40 deletions(-)

--
Chuck Lever
