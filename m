Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8143056E
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhJPWs2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWs2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44BEC6101E;
        Sat, 16 Oct 2021 22:46:19 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 00/14] Some RPC server dprintk clean up
Date:   Sat, 16 Oct 2021 18:46:17 -0400
Message-Id:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163; h=from:subject:message-id; bh=6GFSoH/+tqtZ+RBxqgmZuDD3MqMDyIEwPIqvy6IxpE4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1Y011tHAWJGS5kdtPuAt4qL6+munVtSpbadXSE7 dpXnmxaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWNAAKCRAzarMzb2Z/l1CYD/ sHDC4CMWyTziwFIknxvz+KfQXXjXFfMcP9ROBLnfaxNeZBT+Xpk4YeLjjHhH38rNgThyDdRHwXbiNo Nk6nnj5a5SzGNpdvArc53Mn8nLVletfq+SRvdHESLqSx7B7UdYXKZ2tD+dLHa1X2FPnE3vjSX6KdOE 7FErpbZAbA7xOxYzHWNatgmyegtvBLE3XQ2UG3m7hmHHBRB8xlpcjLtR2tFGmrvrrAimrKMeeYNNQS C0RDbRsJRFrI3jI/1dIferfaxHPTH3JoqGIhRoZR3hEHwzKq+IvxwzT2VjPWBrpLfzw2s8N/GSmgQH 31zMzjgimWffus0399uzTZvk6GcSKYvTAAfn53c07qHj687GJq2Fx68IHa00naXYBuB7s39NR92/HV XENhGr4MJwZmKVT4IX+QcjEfAyiSWorULePHKnTBcCZBuVM9UkP4DPYJrohHp4YwKfUCpbFPWPOvHZ kGzWrozR6oTvpBlzFzAbPOCtABVGfRSlrgiehWtSURLgaQhd8hffKz9bSg0UC1qSfxXXtbH8sNAD4i ZzERcfUsS+odVd8RKGGmPy/apIGgaMcMSfQ0b0HMV7xfAcbNIz00uqLV5iXNzQFtciq2q3ZmYcG21+ TcXSsgzmX+9esy8tBrk85xoO8CF9tuysi7D6NbbW20Z4sNTIQysC1d2pvAqA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

Here are some random scribblings I did over the past week to start
cleaning up dprintk call sites in the kernel RPC server
implementation.

As I stated before, it's my opinion (and not at all a NACK) that
because we've never left single dprintk call sites in place for
deprecated DEBUG failicities, we don't need to do it here. My
preference is simply to deal with this in rpcdebug if we think there
is a strong need. I'd rather see a warning note come out of the
administrative interface immediately upon attempted use, instead of
to see nothing and then see a kernel warning at some point much
later (or not at all if the only remaining call site for that
facility is never encountered).

I know others have different opinions about this. We had only a few
minutes to discuss it during the BAT, and the issue might still be
without consensus. There's still opportunity to work it out on list.

---

Chuck Lever (14):
      SUNRPC: Update the show_svc_xprt_flags() macro
      SUNRPC: Remove dprintk call sites from svcauth_unix.c
      SUNRPC: Remove dprintk call site from svc_authenticate()
      SUNRPC: Clean up svc_destroy()
      SUNRPC: Remove dprintk call site from __svc_create()
      SUNRPC: Remove dprintk call site from bc_svc_process()
      SUNRPC: Remove redundant dprintk call sites from svc_process_common()
      SUNRPC: Report short RPC messages via a tracepoint
      SUNRPC: Report RPC messages with unknown programs via a tracepoint
      SUNRPC: Report RPC messages with unknown versions via a tracepoint
      SUNRPC: Report RPC messages with unknown procedures via a tracepoint
      SUNRPC: Report RPC messages that can't be decoded via a tracepoint
      SUNRPC: Fix kdoc comment for svc_unregister()
      SUNRPC: Yank some low-value dprintk call sites


 include/trace/events/sunrpc.h | 156 ++++++++++++++++++++++++++++++----
 net/sunrpc/svc.c              |  78 ++++-------------
 net/sunrpc/svc_xprt.c         |  19 -----
 net/sunrpc/svcauth.c          |   4 -
 net/sunrpc/svcauth_unix.c     |   4 -
 5 files changed, 155 insertions(+), 106 deletions(-)

--
Chuck Lever
