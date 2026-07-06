Return-Path: <linux-nfs+bounces-23105-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QIlxKFLwS2pndQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23105-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 20:13:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475B7145B1
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 20:13:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="jE/U3rrJ";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23105-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23105-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35BB1AF382
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6543149A;
	Mon,  6 Jul 2026 16:05:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B041DEDC
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 16:05:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353957; cv=none; b=GlEJqSJl9hBhrjLnPMM36ml7KyHJSsuWuJggTXALk3m5L0HLMS+3nY3BokUkizP/oEvvK2DKMmFNpAc2BVOuL4XiEq9hxabm73TC1L6DN32Si5LmGipd2WMWbPkmDouQz6NhelWgpZ0ZTJx767aWT3yabbWtzJ1MzDTa9iucSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353957; c=relaxed/simple;
	bh=ACzcVGDYSJuzaDUQuQIag8MEwcX91Rrj/dOcweV6HFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RehOfMR54lQNKIEufPFdcFUvm8+RGvHqB56CcNrgpjkjtivllroHMgMPraPWksrBLMGVcnB7wpmI9GcPaSKS/ZUDBW2Qeoaj46rPhnMgAH8L+ViOrZ1JOm/YLdmxJUKx3kQ5jJDB0i/RquCIfqIpEw5adTGL8c+IFXOVO4dnop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=jE/U3rrJ; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92c7a0a701aso155810185a.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jul 2026 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1783353954; x=1783958754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yA4tNnR4FWDpGrF2NbmCjZfAtdGZHns+9C239dVF80=;
        b=jE/U3rrJA9vj2EkRWj95QlD6rqzt2zVE1RIr5u1z4IfLKxaZmOUrRhjWaEGyAo+JNX
         +dmlHM9CDm8nM0n9GffDWQWG2BHF7rZAsOCq4bbpRNNlAue75waFBZbehJCkv+WTS+dT
         Ur766RMqSsInnNhiOIomFJi0WYAlL+lcjAPGTIS6uqf51X4S1z8WlC13XNL6WJ0oC/6W
         jubHwpa4htHv+P3fJhsT4wV5Psygf4k1SCKGAp29d+BmSiGwdRnpTdll85aiqxOWWkns
         GaK2hAKOMdiZ3CFHAMushpjjJRM5iwjx/wgIRlcpZlKpX4flcnz91l848aZfGXoCsiKo
         H3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353954; x=1783958754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yA4tNnR4FWDpGrF2NbmCjZfAtdGZHns+9C239dVF80=;
        b=V+bqy7f8LLNxUgkUyz2aKTXaUAMMkk6WNT9UjIXTyCnKPORQNIeSTiCm5cdMOSeKsc
         JrFYMMk+zdpC3iYMWxwKmugQeKvRNF5Cvh8DDOz6Htpl4moAjImGrb3QMAJBzHh7z/Yn
         Y69WMFT2jl4tb+3aVJyTguoPVvBBtMJj2GOjrEglZ4ehJdpD4Mae5QJRpFETICVzA5mZ
         LliB0iBdLS/HXgy0HXEGea9rRROGxwQADHzeqLwsgZkeT5T1mFbu6oIN2QfjIC05ZTM9
         6Ond0xLoHcVwh88mRSUazdXPa7hCypILT3+Dq+abFD0Ln9Ancjyc+CgHSPQwDixSOvny
         Mz/w==
X-Forwarded-Encrypted: i=1; AHgh+RrYarIhMFEF8grTRYdELZq83KtjKk69xcnK2DFLOZ/NiB+76aZiesi6+AgdAVJgImsQpQx9ZZf4r5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzITqizpqJg4zlx5ZSbpa43Y/RWKY/VGXQI4JGibd2yPuNUXO9g
	CGKJ0oXbZCqen6SvM1srxP+LGT+T81RVglE8ofV4kdq7r3cvGtSJOXMVBHY05jtD+0E=
X-Gm-Gg: AfdE7clLTBsXh/MCeyE+KuhoQ251Eu1SJOW0TPSngVmCTJ+URVXZS+7xTvm2sI5KSNS
	n6zy9MA8SbyfMTnDv2YtGCoL5reLYuabWZLUxQSPPT66R1g4aT5bw0DZqlFZJjDGrTKsDpml7VO
	EW6ryfJZeC+Ql57mwuMXfdPj07MATuGKUNpJn4kVuxmsvNfhTmqor70xoeZ8uxyXIkeuobSvgA6
	QJlCSv9IgJJUP3gBS5SJge5hdpOBbBta4eGi3Zq2fzallJo40a4/4VKIGq8UWUvj6DfDSsDWY9f
	oz1b/89RapZNvCeW1R9LtviQ/AQKlUYiwtPkG7ShetI4qAvbMXfuKOakcrGCZt/SbKKDlOuYDVr
	hIy5xnoC8YC+3Yg7j6OqoN4CGpyEl8A6h2WAh2YOThh4sbz/ku2uBU6JmpfByS3tAEaBHEON+8x
	FY9/oBuIpt6sgc4N62u8dabf/X9He8+td9jeT87umxVtnW8aqOphlCyBGFRQ+gQz9MYdZrIQBmi
	+l3/Q==
X-Received: by 2002:a05:620a:4621:b0:92e:87a8:6f15 with SMTP id af79cd13be357-92ebb5c8cd8mr166278685a.69.1783353954377;
        Mon, 06 Jul 2026 09:05:54 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b9db95sm943242485a.14.2026.07.06.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:05:54 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] NFS/localio: issue commit inline when not in a memory-reclaim context
Date: Mon,  6 Jul 2026 12:05:49 -0400
Message-ID: <20260706160549.97580-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260706160549.97580-1-snitzer@kernel.org>
References: <20260706160549.97580-1-snitzer@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23105-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hammerspace.com:from_mime,hammerspace.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2475B7145B1

Extend the memory-reclaim-context test used for LOCALIO reads and writes to
the commit (fsync) path.  As with data IO, bouncing every commit through the
dedicated !WQ_MEM_RECLAIM nfslocaliod_workqueue is only required when the
submitting context is a memory-reclaim context: nfs_local_run_commit() calls
vfs_fsync_range(), which may flush the underlying filesystem's own
!WQ_MEM_RECLAIM workqueue, and doing so from a WQ_MEM_RECLAIM worker or a
PF_MEMALLOC task trips check_flush_dependency().

The writeback path does exercise this: nfs_write_inode() (the ->write_inode
super_op) runs under wb_workfn on the WQ_MEM_RECLAIM bdi_wq and reaches
nfs_local_commit() via __nfs_commit_inode(), so that case must keep
deferring.  Application-context commits -- fsync (nfs_file_fsync), O_DIRECT
(nfs_direct), and copy/clone (nfs42) -- are not in a reclaim context and now
run the fsync inline via nfs_local_defer_io(), avoiding the per-commit
workqueue hop.

Completion (nfs_commit_release_pages -> nfs_commit_end) then runs
synchronously in the submitting context; higher layers already cope with
this, as __nfs_commit_inode() dispatches the commit async and waits for it
separately via wait_on_commit().

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index acbc2bddcf81..f42b6112a613 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -1132,7 +1132,19 @@ int nfs_local_commit(struct nfsd_file *localio,
 	}
 
 	nfs_local_init_commit(data, call_ops);
-	queue_work(nfslocaliod_workqueue, &ctx->work);
+
+	/*
+	 * Run the commit (fsync) inline when not in a memory-reclaim context,
+	 * rather than bouncing through nfslocaliod_workqueue; see
+	 * nfs_local_defer_io().  Completion (nfs_commit_release_pages ->
+	 * nfs_commit_end) then runs synchronously, which higher layers cope
+	 * with: __nfs_commit_inode() dispatches async and waits via
+	 * wait_on_commit().
+	 */
+	if (nfs_local_defer_io())
+		queue_work(nfslocaliod_workqueue, &ctx->work);
+	else
+		nfs_local_fsync_work(&ctx->work);
 
 	return 0;
 }
-- 
2.44.0


