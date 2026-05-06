Return-Path: <linux-nfs+bounces-21412-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBIOJA1e+2kuaQMAu9opvQ
	(envelope-from <linux-nfs+bounces-21412-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 17:28:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0C4DD33E
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 17:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66422303C012
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357B48C405;
	Wed,  6 May 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIvinFcB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51448AE3C;
	Wed,  6 May 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081235; cv=none; b=anaN1vDernzaDVmQ7hz1dkFECX7c5AH8v/ZTsAYTPesiIxWd/SfcO85CchdVxKT0+0xny5vAuhd41th9uynMEMVo+NVVmwLbAS5jFBBa2QTRmTRPLmq0dM9ryVnZICIXxcfbndRTvpbFRmxFv3GtLlvmiOOIGyEFggm0A/PLcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081235; c=relaxed/simple;
	bh=YMv12MKCUotljeEmq3yy6FYGBu6y57Tjb4/tOO0yhho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmZt5JUUti9NcjjPDZcofHPV0fmrFMCFEztZofLuvndB6QPgNQWbAMzgTE9HDbGctWoeT0vP/2/KNIAWwad0JNNK/FAUXZAiuqExfNmjLPVRfipyK/d95Iu9Vu9EDDrg5LZyjxvH33dIt6Qx/fNwziUbXvJ5QW8n+ob5vUyFqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIvinFcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80151C2BCC7;
	Wed,  6 May 2026 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081235;
	bh=YMv12MKCUotljeEmq3yy6FYGBu6y57Tjb4/tOO0yhho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DIvinFcBeSNhNeVUM5Q1IJJZnJsGM83+2cwkoto6M4DWpygqaG7P+tcxlE/J8Kqws
	 EoYaPjVMRnU80AdoyJl8EjprvKI8smFtR+p0h87I4onqVFpEujycMOHWutep1ky5cf
	 uJEF1+VOY9XsF3/KJb08qAcfZe7Bs7hTcAqrKqLFlbRTvOQ+T8jgQiVpydo7IjnI/U
	 N8ULYudnIDF4SbWbFDPIjYGA+SitguKcrEX9hIXlz3EQ/LRBxOUyAx7dvXKtjO1WMv
	 ImPpiXK6NP569E8zQ0MMg+IYPBQXGXhQd9WGuQORN7xe+vmBO4qxX0n7odIOiXeIF/
	 Ob2FBDKe9BSpA==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 06 May 2026 11:26:50 -0400
Subject: [PATCH 1/2] svcrdma: Release write chunk resources without
 re-queuing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-svcrdma-next-v1-1-915fce8c4fbb@oracle.com>
References: <20260506-svcrdma-next-v1-0-915fce8c4fbb@oracle.com>
In-Reply-To: <20260506-svcrdma-next-v1-0-915fce8c4fbb@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2636;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ECmb6MeKMmCqyRPIiBLqjVVBP5PeF5lYeMllSdmUVnY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp+13MdEhz3kXlVp+l3lsVgZvRr4Y2dS0PgbQoO
 ZdcPGYoLZ+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaftdzAAKCRAzarMzb2Z/
 l2MkD/9upE8dZUy+eH9hPZZx/VOBjsqW3LH+hUzJmSQv9K2x2Q3r23ZExhpsuCBT8tWUPdLm+Dn
 YOfG89VJOOwdq6EhSMNjCO/jTU8niRXljqD+sHJvZ3KeqZu3wneJnfcFaAu9t1ggwPjWFWKIjDG
 vQqSVOzjyLNZ/g1y5jdj1G7/f6j+derp5dBF1M92Hs3bquuT0T45kXRItGnG9eKiIfktFj2AtrR
 rbGmNW8u4TICJiSNyx8z+NUomVL9SbNj8KV1hhdjbMdAUTYQk8Ka3fpP0AOEiKOoIRSiDhGUtS9
 DV4hjoAZIYvluCTOtbkgqN2U3TX7FUAfP6UfFt1reydjg1EB0/y0mLuuMxJsE9yKqyF7C6nQ7fT
 gU/CYGWjupk+PlqOdM2PE1KBfj1VelKoYthuyPATAZwhUSJQeeaxx9n/QAPaHkxoX+X1NzBZmSZ
 4Jwbskp8FX+OtUGmXwivmNeZAozhM07zU8zfiGWjW1iadMnt+HSc1yrbTCJcSkaSObD6q0v+49W
 YSsdiZ0WnWuxIXCmx33WsiYDCbHDgvMsnv31sjIuHzivTGz23IKlq5CW/H7nBFgn3Se4hYCzYms
 oyN3xxaXK3twnkCLqxlal9VHbRZWSIuO7iOUbMwgeXRRMEB9nLrOmINbNWJ3GAXVVViitFAVsqe
 EtfTZO7ZEpL5nzA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: BFD0C4DD33E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21412-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

Each RDMA Send completion triggers a cascade of work items on the
svcrdma_wq unbound workqueue:

  ib_cq_poll_work (on ib_comp_wq, per-CPU)
    -> svc_rdma_send_ctxt_put -> queue_work    [work item 1]
      -> svc_rdma_write_info_free -> queue_work [work item 2]

Every transition through queue_work contends on the unbound
pool's spinlock. Profiling an 8KB NFSv3 read/write workload
over RDMA shows about 4% of total CPU cycles spent on this
lock, with the cascading re-queue of write_info release
contributing roughly 1%.

The initial queue_work in svc_rdma_send_ctxt_put is needed to
move release work off the CQ completion context (which runs on
a per-CPU bound workqueue). However, once executing on
svcrdma_wq, there is no need to re-queue for each write_info
structure. svc_rdma_reply_chunk_release already calls
svc_rdma_cc_release inline from the same svcrdma_wq context,
and svc_rdma_recv_ctxt_put does the same from nfsd thread
context.

Release write chunk resources inline in
svc_rdma_write_info_free, removing the intermediate
svc_rdma_write_info_free_async work item and the wi_work
field from struct svc_rdma_write_info.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h   |  1 -
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 13 ++-----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index df6e08aaad57..14eb9d52742e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -230,7 +230,6 @@ struct svc_rdma_write_info {
 	unsigned int		wi_next_off;
 
 	struct svc_rdma_chunk_ctxt	wi_cc;
-	struct work_struct	wi_work;
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 402e2ceca4ff..cca8ec973de4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -236,19 +236,10 @@ svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 	return info;
 }
 
-static void svc_rdma_write_info_free_async(struct work_struct *work)
-{
-	struct svc_rdma_write_info *info;
-
-	info = container_of(work, struct svc_rdma_write_info, wi_work);
-	svc_rdma_cc_release(info->wi_rdma, &info->wi_cc, DMA_TO_DEVICE);
-	kfree(info);
-}
-
 static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 {
-	INIT_WORK(&info->wi_work, svc_rdma_write_info_free_async);
-	queue_work(svcrdma_wq, &info->wi_work);
+	svc_rdma_cc_release(info->wi_rdma, &info->wi_cc, DMA_TO_DEVICE);
+	kfree(info);
 }
 
 /**

-- 
2.53.0


