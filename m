Return-Path: <linux-nfs+bounces-23102-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /IZcImHcS2pUbgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23102-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 18:48:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CF7137D2
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 18:48:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=E8vwcT7j;
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23102-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23102-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9AC2304707C
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E023B19BC;
	Mon,  6 Jul 2026 16:05:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A883ABD8C
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 16:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353954; cv=none; b=Vmkyje01UorQFypVeB9m4iPjiPXyS0NRF51ZhooyxhURsR5pMvxxI+nxDxtZbmdShoWZWmqKHw8Gomz21HhyoeHkBp3KKzy9LWZ1cY1DcufQ2pmuQYBa8Pco694/CQ/qN43u9hN+y2gHW4GA/R8oDQuHdeZrXqVMumPeTVMBZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353954; c=relaxed/simple;
	bh=qWe53X1lFC1ssUPxFQ12xn2Gk79QM4DqyQFirq4yWnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvhcqEBp29nqJkPbx+HezPrnbhiLdsLHK524x0S0fFzULQdSTF3ca0DQ68d+/CeYDLV8NrfLixUqCftaDIaH2z1QQKx0myvsyEGQ9mO2VEORc0RfGNfu87K20pj+Qqw1C69+tEMKR5f7ZYYDlnthUgGjqPy9ey2toD4ul/i2ZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=E8vwcT7j; arc=none smtp.client-ip=209.85.221.178
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59e23d70dfaso1440217e0c.2
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jul 2026 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1783353951; x=1783958751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a4hRh2dxYEdxH4xJe+DcNxPcIhIgd93vbgkGk1FadTA=;
        b=E8vwcT7jqRCxEA23attoPfCtuiSqrdRs5NaYYyQM2XutnhUPuF/eeQbkWyUkfKmJkg
         ny/6a4LxaYs+3+ie8tFxpiYJAg+sT/6/8JhEchPHZ0meAmz/3DP0/1Ifzg3sev2qYUQ0
         CAmYETAUlHlg5w5qNN07mM0w05KEmOdc/HMN9lWQnym+S/usPJHVaipgtZFG1xhx3IiT
         fBFFcordoGjy89+i5/bvHqgmxFc0stl0y+bGVlDYeB1h4egYUPTtbu+u+hZYgoYAcQXw
         6BmNc00ax0OWxM3n0GHxG8ZbVI2/r8lP1kKiNceNjpiRU+i8EngcmKVXslnFVdwV3xxx
         Foeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353951; x=1783958751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4hRh2dxYEdxH4xJe+DcNxPcIhIgd93vbgkGk1FadTA=;
        b=X+FV+NiIMT2GifM3Lzh4vT6gxxWTTxFFbKWhs08Vs+CfZkd3O+es0rOyObWW0zBx5u
         YiOFLEDZo/0Jw7Bt5HwTAYsk11kRlTJYXNMxLBQI0i9rmbsVKIK4pLogzo6lwzqwp1SX
         fz3DbY/0EIB4ZDKwXQx1ItEzdghxB4w2d+04Sn7vkKHWDLwI/+0jxYONXo/wAwtAbEpL
         Tw0x2dVlg1QCwIJRW6Abb4QgsS49u08sWOZAwwsLv49SSMDugbeVvI0kP0XdSmgFU+5o
         MGbnIH9DGFhUQYOazIYKD5gdvgKpjK0dM5fofenHffUSTHVl7zmxo3nhUZz38bxdoAw2
         FX/w==
X-Forwarded-Encrypted: i=1; AHgh+RoxA9y8HoI6aRnZFTUR3iDCLPDkrl9cw2Qi+KzgwFv6RQn79tjZR4wN8UJXqwy50nZLLc7TPMrX9OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRLcIl+2RC1+N3R1K8qKvzI2jL85QnJJvipbktl/ok8ICxNjs
	nwuYgiziLeL/j0sLOfuNt+5r5kh+4I9eUYGLtfM0iH+ZV9z6fj3w6fJqUwWxg6gtxMc=
X-Gm-Gg: AfdE7ck2nmVdi+VKBERCDb71Ii9ML54aHfQKwNg4N3KJw8SxM46koMHnAmz1miYoGPp
	YZ9UcqzGhzjhQWYSS4k7Sor44LcjppSgXTViSYNfCwLFNya96QTGG/LhVziWSS0zKE9bmQsK4aK
	xm/a9umyXzv1KhINxPNUntuFRf7Rkr/8n5lithR9QGxjvZWQsCg4cgR5gPOtOM4bs8wGflr2iA5
	unkUfNHofOx7pDo/6uQb7s03xGA2IBh75i70HD1Zsthx3LQ7Q7CstqcpN7FfeOojGsM2sjzdEv3
	YThu7nLbm6vp8FF4r+Gao1639jLylrkS/03iDdQWz2ROOTFOHpEd3cvfEZ4MboH3Vq2f1A/1FGI
	0x8LqFGwzhbnBZ1uEXVAk1lAPz0H7vrB9wpsclNa47IhPYSKU6ugLrljue9jR4kdfKTAICJAdPc
	+exGXbYhV3sqMIxhgg6CvrKZJz9+eGUX1mNV+dWzCflpPv/ovb8SIfQeqdeFuAjQi8YJCsAEQ82
	FwOHhmgfAOweGgI
X-Received: by 2002:a05:6122:6e0f:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5be9071c985mr664909e0c.4.1783353950982;
        Mon, 06 Jul 2026 09:05:50 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b804c1sm969257585a.5.2026.07.06.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:05:50 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] NFS/localio: issue IO inline when not reclaiming memory
Date: Mon,  6 Jul 2026 12:05:46 -0400
Message-ID: <20260706160549.97580-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23102-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:from_mime,hammerspace.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D3CF7137D2

Hi,

Every NFS LOCALIO read, write and commit is currently issued indirectly: it
is queued onto the dedicated !WQ_MEM_RECLAIM nfslocaliod_workqueue rather
than being submitted to the underlying filesystem in the calling context.
That intermediate hop was introduced by commit b9f5dd57f4a5 ("nfs/localio:
use dedicated workqueues for filesystem read and write") because:
LOCALIO submits IO directly into a stacked local filesystem (e.g. XFS)
which may in turn flush its own !WQ_MEM_RECLAIM workqueue. Doing so from a
WQ_MEM_RECLAIM worker -- most importantly writeback's wb_workfn running on
bdi_wq -- or from an explicit PF_MEMALLOC reclaim task trips
check_flush_dependency() and risks a forward-progress deadlock.

However, that hazard only exists when the submitting context is itself a
memory-reclaim context.  For ordinary application/task submission -- e.g.
O_DIRECT, or an fsync-driven commit -- the workqueue hop buys nothing: it
just adds a context switch and scheduling latency per IO and throws away the
NFS client's inherent application-context parallelism.

This series makes the hop conditional.  It adds a small workqueue-core
helper, current_is_workqueue_mem_reclaim(), that reports whether %current is
a WQ_MEM_RECLAIM worker using exactly the predicate check_flush_dependency()
warns on.  LOCALIO uses it (together with the existing PF_MEMALLOC test) in a
new nfs_local_defer_io() helper to decide per-IO whether it must defer to
nfslocaliod_workqueue or may issue the IO inline.  Reclaim contexts still
defer and are unaffected; everything else runs inline.

  Patch 1 adds current_is_workqueue_mem_reclaim() and applies the gating to
          the read and write paths.
  Patch 2 removes never-taken FLUSH_SYNC handling from nfs_local_commit()
          (every caller supplies a FLUSH_SYNC-stripped "how"), which also
          drops the sole user of the ctx->done completion plumbing and the
          now-unused "how" argument.  No functional change.
  Patch 3 extends the same gating to the commit (fsync) path.  Note the
          writeback-triggered commit does reach here in reclaim context --
          nfs_write_inode() (the ->write_inode super_op) runs under wb_workfn
          on the WQ_MEM_RECLAIM bdi_wq -- so that case correctly keeps
          deferring; only app-context commits run inline.

Patch 1 touches the workqueue core (kernel/workqueue.c, include/linux/
workqueue.h), hence the Cc to Tejun Heo, Lai Jiangshan and LKML.  The new
export mirrors the existing current_is_workqueue_rescuer()/current_work()
context-introspection helpers.

Additional note for reviewers:
 - The inline path now stacks the NFS pgio path plus the underlying
   filesystem's ->write_iter/->read_iter (and vfs_fsync_range) in task
   context.  The reclaim-context stack-depth concern of b9f5dd57f4a5 (2) is
   avoided for the deferred paths; feedback on inline stack headroom under
   deeply-stacking filesystems (XFS especially) is welcome.

All review appreciated, thanks.
Mike

Mike Snitzer (3):
  NFS/localio: issue IO inline when not in a memory-reclaim context
  NFS/localio: remove dead FLUSH_SYNC handling from nfs_local_commit
  NFS/localio: issue commit inline when not in a memory-reclaim context

 fs/nfs/internal.h         |  4 +--
 fs/nfs/localio.c          | 56 ++++++++++++++++++++++++++++++---------
 fs/nfs/write.c            |  2 +-
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 24 +++++++++++++++++
 5 files changed, 71 insertions(+), 16 deletions(-)

-- 
2.44.0


