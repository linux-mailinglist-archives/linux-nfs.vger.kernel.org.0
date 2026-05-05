Return-Path: <linux-nfs+bounces-21398-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMg9IKhn+mnwOgMAu9opvQ
	(envelope-from <linux-nfs+bounces-21398-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 23:56:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AEF4D4217
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 23:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E6D9309C330
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C04A2E06;
	Tue,  5 May 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="joTgGrgY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301C4ADD81
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018140; cv=none; b=oSS0+3eHJaaCYAboAggJb5ghsYyH7zEdk/6IY0DAdBP0IVw8wHWDr5eZ76vdO8u2iTL/GK90tRIeTU76hp7IFeWkikFHQkpAn6woAb8Tc8lSZQaoW0LKiRs+e6kIWJh8MHh+1q9czr2jNhy4zWhFJ4blu4NNj0oBpaGp+1jJJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018140; c=relaxed/simple;
	bh=o9HsSpd1Npc9kmwlSyoxWaH/HeK7D1RhckpyhcdjRwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4/LvAbR2ov/oYZI61ZimCR6cz6sY7e1dnJQr3hTUUeh6xGAohid7VRzpGCRBa2aKIroYUFWVYZ/XeQ2akRNs5A4ITl/RI2BV3juZQf5b2uMZInHsdePoW15RDPj29pHq5oRRb9KSfGYTrfTK0KnNxTe1LwUgHkPxlG5/QZ1YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=joTgGrgY; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb40149037so560674885a.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 May 2026 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1778018136; x=1778622936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wCvZPbkIb3XBh7p/8DazAR2eYdvHEMK2oAao6TbZE/M=;
        b=joTgGrgYZo46KLFHG3cs6jC0q6uozNH9Sid8K5YZE1RHqCl9uSHcF0jwh90odQEFEp
         e8dUvcu62eIUV2e0Te20Y8RjI0FkeprqfHUE1BewjHHU3WKXz7qyQyVYWVx3TVkhqrv+
         6fF8QZAIVYpgyMdVYkPjRHA4HZaCyzlBP7kmdPNb4h0D+mau6qLD3vGFIQsLQu785lfy
         Vw0lQyXHfPGRNn4ftR/MUMvtWi5rdL11W4zH4fPOu1oFely1/xMUpVzaalmZYWthKUQc
         2NR1aZHXpo/OXosb40zyFtxXA7BA7FlCyuzfOdW2C3ooa+Gr5PZIyH3MJ8zz+ZhQMh5C
         ELow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018136; x=1778622936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCvZPbkIb3XBh7p/8DazAR2eYdvHEMK2oAao6TbZE/M=;
        b=Y0OXiii6E1DdhqnRgJnG3Gf3fvm4LZiN7u9WX0m5MoavQdoCwPQsfeetdUNP6zZfJm
         zUMEEZg4akosSXCrobf/+rPDdZEZH5o2OpSW0n9e4TJPeXPsDq5mDXjQmLzFTFRgUNl6
         xB2QpPSqDy14LMpOZHgrhLAfc7rqH5zZBtvYtm7ZF3wAfTlZNqESdz2gXePpTGpJ9CGg
         eO5QConTHhphtx5msPXp7iePcpz9BRvu3nl3M80h9fXsz06ekyi0kJcOmjxW/SPPLLSn
         hXYCtiyymvAv1nqJR3thr5Sq2SRLM+hnG+LZpqASbxVBPtNoEThAyAgskq6AqyEPFwcR
         GCBg==
X-Gm-Message-State: AOJu0Yz9BVQBc0BY7Ievj7XOftoaz4VI+5mWAhOId5WZQ/SOJy065ucX
	mgHKtVRjGjQwjrmdRTC9K/SrJJ8gKWMZKqBLRRjtZxJxZm4Ayb1k8tIIIVxu37NNHA6pYZOcLlS
	36GwE
X-Gm-Gg: AeBDieu3vD2p+Ie8ApiQdVdGqW6xugB2as+vQxPz4yO6jax79unVZ0ZvYFOKne9PhRk
	iHTzzsR4Fr98Bzev9YBr5GiCiCnoazTjsb+CoDy0eAQW7gChW+whrzbwP0bdJWUN5H4iSoJGNty
	hc9nGJpBBxjNDbnoUkYjQWvtH8eEwa4kiBmeCN4J/kqG0KfE/fTjssvG9TQvPAlavebZ3yII0Hl
	v/hrteT8Oz8XfdWFJf1gjgDiOAjVYkNZuxZB6VkVtOhgTgWfBu3r7RmU9JFly31rALE0w6Idncu
	m/ai5RvV4WKZTTI2cwJjWFz5mDCmPmgfy5Qkgkl5XqyAfhPsUd12F2BZ68Kta9aAWrL+8SZlOmD
	zIY+xz0maygC3SYLFnLso9mNXOAEOqhU4A0yjszEXwmqz3dFNhHUz7vERsNaF8Ckzs6SnFF4nJk
	q3IomWf0u7NjYP1zlTg3riYcMGsibVhQDc9eeGz4wtFsl6JgHFLQug84ayHm7Yx0TnM+4PskEhx
	ggN55pem8kHke908wYD+luyhWs=
X-Received: by 2002:a05:620a:2a10:b0:8cd:8ad9:c893 with SMTP id af79cd13be357-904d3eaf2e3mr149263185a.6.1778018136375;
        Tue, 05 May 2026 14:55:36 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm1600314985a.36.2026.05.05.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:55:36 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	ben.coddington@hammerspace.com,
	jonathan.flynn@hammerspace.com
Subject: [RFC PATCH 0/2] svcrdma: avoid OOM due to unbounded sc_send_ctxts cache
Date: Tue,  5 May 2026 17:55:33 -0400
Message-ID: <20260505215535.68412-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 39AEF4D4217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21398-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:dkim,claude.md:url]

Hi,

I drew the short-straw by having to take a hand-off from Ben on work
he started with Claude yesterday in response to a really crazy OOM
situation that hits like a freight train at one large customer's
install that currently has 121 NFS clients and 9 NFS servers, all
connected with RDMA networking.  Working with Jon Flynn, to bound the
problem a bit more we later scaled the testing down to 15 clients
reading from 1 server using 16K O_DIRECT reads.

So I imported Ben's CLAUDE.md that he handed off and carried on, with
patch 1/2 we're able to avoid OOM killing the NFS servers (each with
128GB) -- with the 16K test workload memory use would grow from ~12GB
to exhaustion (128GB) within ~10 seconds of starting the test.

The 2nd patch in this series provides a diagnostic svcrdma-wq-lag.bt
bpf script that Claude suggested -- I just dropped it in
Documentation/filesystems/nfs/ but it isn't intended to go upstream.

Chuck,
Patch 1/2 is marked RFC because ultimately we suspect you'll have a
better way to skin this cat... but Claude was pretty great at helping
us cut through this nasty OOM situation with RDMA.

Please feel free to ask follow-up questions and we'll fill in any
details as best we can.

Thanks,
Mike

Benjamin Coddington (1):
  svcrdma: bound per-xprt sc_send_ctxts cache and apply backpressure on _get

Mike Snitzer (1):
  for diagnostic use only: add svcrdma_wq lag diagnostic

 .../filesystems/nfs/svcrdma-wq-lag.bt         | 146 ++++++++++++++++++
 include/linux/sunrpc/svc_rdma.h               |   1 +
 include/trace/events/rpcrdma.h                |   2 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c         |  41 ++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c      |   1 +
 5 files changed, 185 insertions(+), 6 deletions(-)
 create mode 100755 Documentation/filesystems/nfs/svcrdma-wq-lag.bt

-- 
2.44.0


