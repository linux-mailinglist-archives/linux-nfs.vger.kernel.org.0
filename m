Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15973CD737
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhGSONp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 10:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232228AbhGSONp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Jul 2021 10:13:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89DB861003;
        Mon, 19 Jul 2021 14:47:58 +0000 (UTC)
Subject: [PATCH v2 0/6] Ensure RPC_TASK_NORTO is disabled for select
 operations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 19 Jul 2021 10:47:57 -0400
Message-ID: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a set of patches I've been toying with to get better
responsiveness from a client when a transport remains connected but
the server is not returning RPC replies.

The approach I've taken is to disable RPC_TASK_NO_RETRANS_TIMEOUT
for a few particular operations to enable them to time out even
though the connection is still operational. It could be
appropriate to take this approach for any idempotent operation
that cannot be killed with a ^C.

Changes since RFC:
- Dropped changes to async lease renewal and DESTROY_SESSION|CLIENTID
- Cleaned up some tracepoint issues I found along the way

---

Chuck Lever (6):
      SUNRPC: Refactor rpc_ping()
      SUNRPC: Unset RPC_TASK_NO_RETRANS_TIMEOUT for NULL RPCs
      SUNRPC: Remove unneeded TRACE_DEFINE_ENUMs
      SUNRPC: Update trace flags
      SUNRPC: xprt_retransmit() displays the the NULL procedure incorrectly
      SUNRPC: Record timeout value in xprt_retransmit tracepoint


 include/trace/events/sunrpc.h | 51 ++++++++---------------------------
 net/sunrpc/clnt.c             | 33 ++++++++++++++++-------
 2 files changed, 35 insertions(+), 49 deletions(-)

--
Chuck Lever

