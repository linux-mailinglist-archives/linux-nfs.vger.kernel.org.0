Return-Path: <linux-nfs+bounces-14009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B32ABB42600
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315FB7A2111
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941B628D8CC;
	Wed,  3 Sep 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPRsoo6O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4128CF6F
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914825; cv=none; b=nJq4Ni4ymxcYcKGMkmOZKO0zQCjO1cMpzuVTjzixdAF1vB4+IoPhknzsUw/tycUZSwSjfJ2U7qAJBPSoAqoNNvW8NRTvFTGj47hjKilAjf5Bc+Tzcnz9OB993hSVbhO+auddWsrSuGeZbz/MtMDNwzHYaqcepAWf6Qr2g0MA3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914825; c=relaxed/simple;
	bh=LSQbt0AXxvWCd05aEXnLfCkFV+eE7nMmpTrvmcJSJew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jodNmVXmPdnKfbyGktH2GKFg36XX8pDk5NeUPrAtxp17EYVcHQCwE9LMnnWZyelOpRDOeYbxk6YnafDjhOjw9Vi6SHzPRuaFywprsWtmdrcO/24L4R4N6BflMFnS8J4uiljp0ri8IXcwlE2iFxje37j0CXA6W/hBB1c1IDqH+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPRsoo6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ABDC4CEE7;
	Wed,  3 Sep 2025 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914825;
	bh=LSQbt0AXxvWCd05aEXnLfCkFV+eE7nMmpTrvmcJSJew=;
	h=From:To:Cc:Subject:Date:From;
	b=RPRsoo6OjbHrQ3j9Yuz7pfMbDc5BpFCrKC4Bge6+85AZ6FOpev0S+884ExkUSQO19
	 MHAvXsab086Y5ezVj/0kdKDVjVPq9uPSs9nkE+u45/A5ohXJmjDwDwCj8LORoy1cXE
	 J6kRfRMs9a4e7FArLMlk6wpDa64zvIOaoxWh3fPZpOtJDHAhEepgME4OBceKdOKgo/
	 829+tJklo0ykQoQooNPAFJPDcrusM9SqHX1YJOhknYMe2Y4F50Y8FQc39vURbiTcwQ
	 WMEvmwwf+H3HhVSlRRGtecYuV0N4Xbx0aMJdd+U0Uwyv+gQsJvbRJhO4jRhizeHq3d
	 q1vidX+5J/OHg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v1] svcrdma: Release transport resources synchronously
Date: Wed,  3 Sep 2025 11:53:35 -0400
Message-ID: <20250903155335.1558-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSD has always supported added network listeners. The new netlink
protocol now enables the removal of listeners.

Olga noticed that if an RDMA listener is removed and immediately
re-added, the deferred __svc_rdma_free() function might not have
run yet, so some or all of the old listener's RDMA resources
linger, which prevents a new listener on the same address from
being created.

Also, svc_xprt_free() does a module_put() just after calling
->xpo_free(). That means if there is deferred work going on, the
module could be unloaded before that work is even started,
resulting in a UAF.

Neil asks:
> What particular part of __svc_rdma_free() needs to run in order for a
> subsequent registration to succeed?
> Can that bit be run directory from svc_rdma_free() rather than be
> delayed?
> (I know almost nothing about rdma so forgive me if the answers to these
> questions seems obvious)

The reasons I can recall are:

 - Some of the transport tear-down work can sleep
 - Releasing a cm_id is tricky and can deadlock

We might be able to mitigate the second issue with judicious
application of transport reference counting.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c                    |  1 +
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8b1837228799..8526bfc3ab20 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -168,6 +168,7 @@ static void svc_xprt_free(struct kref *kref)
 	struct svc_xprt *xprt =
 		container_of(kref, struct svc_xprt, xpt_ref);
 	struct module *owner = xprt->xpt_class->xcl_owner;
+
 	if (test_bit(XPT_CACHE_AUTH, &xprt->xpt_flags))
 		svcauth_unix_info_release(xprt);
 	put_cred(xprt->xpt_cred);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3d7f1413df02..b7b318ad25c4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -591,12 +591,18 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
 	rdma_disconnect(rdma->sc_cm_id);
 }
 
-static void __svc_rdma_free(struct work_struct *work)
+/**
+ * svc_rdma_free - Release class-specific transport resources
+ * @xprt: Generic svc transport object
+ */
+static void svc_rdma_free(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
-		container_of(work, struct svcxprt_rdma, sc_work);
+		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct ib_device *device = rdma->sc_cm_id->device;
 
+	might_sleep();
+
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
@@ -629,15 +635,6 @@ static void __svc_rdma_free(struct work_struct *work)
 	kfree(rdma);
 }
 
-static void svc_rdma_free(struct svc_xprt *xprt)
-{
-	struct svcxprt_rdma *rdma =
-		container_of(xprt, struct svcxprt_rdma, sc_xprt);
-
-	INIT_WORK(&rdma->sc_work, __svc_rdma_free);
-	schedule_work(&rdma->sc_work);
-}
-
 static int svc_rdma_has_wspace(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
-- 
2.50.0


