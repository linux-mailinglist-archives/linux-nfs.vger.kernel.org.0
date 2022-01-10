Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA957489CE0
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 16:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiAJP4w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 10:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJP4w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 10:56:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6EAC06173F;
        Mon, 10 Jan 2022 07:56:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F31860F4D;
        Mon, 10 Jan 2022 15:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30C8C36AE5;
        Mon, 10 Jan 2022 15:56:50 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-trace-devel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix sockaddr handling in NFSD trace points
Date:   Mon, 10 Jan 2022 10:56:49 -0500
Message-Id:  <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; h=from:subject:message-id; bh=l4mdA8AJreUadXPEp3nbQK3sxiIGWISMwjctXd9Zdzo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh3Fc6cKwmgerSRbnXJ5YRf1tpurE2QO8qmSwcJoBh tQ0UwteJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYdxXOgAKCRAzarMzb2Z/ly2RD/ 9+zcKJAi5NQyASbCFFOjGZnCDeN0HzXBAj+TGn413QVz47dJQB+nszwz9nxL8NLJNzPcnjgAlHOhBo 3iHirnMvVJr4mmkhLO9uh7vD4GfqLo16XGPAX/Hq/WKu6njsjo4yC4lwlFrIbU1rOJEm5A0g0GMHyx DH1SmZkwogxhXs/aua7HRsslhLnwPSJw9icDonMf5bu5I3s3Y2JtR32Fv4Yul7oo7MjnOJD3Z+a1WD jGUQdVdJbnau0iHdIuSsc41QMFOQPHo3IHTZaiRe9d82Q3tjGgoYsRj2E/6meemI8pikggSB/JOiz+ OVpjufnaMHvxqV8XZ/ep5PHyHgH/W6ManLZi451R0ZwCIUFrnvorI0xc6o/iwuJGbFuX3bN5zHYukc pRunI2DB1/6F4E7WXtOuGkUD3m/6FqfbFRBLVXJCnTxZBGSUdHepssptzsVbrkcZBpSgKG+WjTfvDe DXnEKPPy+03pEW1kxIYQZqkPOmf+APoFz/JLAewgYz89uQ/TpdqY7lqBcvXhtyJ0Ns6ag2SMEq+fVy +YIk6zJGU9bCChLtB8qdrapk4R7GxHxIzv4kQb5vcauRV7OMABP6gfVo12CNPhfpIBSRgffbpTeh4i xFMgMetwfi2tbqR+fzFWa47MK5U1ay3FYIRA3fpr5352ILmV6JUf1t4Z8y5g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The patches in this series address a simple buffer over-read bug in
the Linux NFS server.

However I was thinking it would be nice to have trace helpers to
deal safely with generic socket addresses. I'd like to be able to
treat them the same way we currently treat strings. So for example:


#define field_sockaddr(field, len)  __dynamic_array(u8, field, len)
#define assign_sockaddr(dest, src, len)  memcpy(__get_dynamic_array(dest), src, len)
#define __get_sockaddr(field)  ((struct sockaddr *)__get_dynamic_array(field))

TRACE_EVENT(sockaddr_example,
        TP_PROTO(
                const struct sockaddr *sap,
                size_t salen
        ),  
        TP_ARGS(sap, salen),
        TP_STRUCT__entry(
                __field_sockaddr(addr, salen)
        ),  
        TP_fast_assign(
                __assign_sockaddr(addr, sap, salen);
        ),  
        TP_printk("addr=%pIS", __get_sockaddr(addr))
);


should be able to store any address family in a dynamically-sized
array field (addr).

I haven't quite been able to figure out how to handle the 
TP_printk() part of this equation. `trace-cmd report` displays
something like "addr=ARG TYPE NOT FIELD BUT 7". 

Thoughts or advice appreciated.

---

Chuck Lever (2):
      SUNRPC: Fix sockaddr handling in the svc_xprt_create_error trace point
      SUNRPC: Fix sockaddr handling in svcsock_accept_class trace points


 include/trace/events/sunrpc.h | 13 +++++++------
 net/sunrpc/svc_xprt.c         |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

--
Chuck Lever
