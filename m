Return-Path: <linux-nfs+bounces-21436-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B0BMniO/GmlRQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21436-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 15:07:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3EC4E8E44
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0443305B08F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB73F23B3;
	Thu,  7 May 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a6m3YLsJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C93E958D
	for <linux-nfs@vger.kernel.org>; Thu,  7 May 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158892; cv=none; b=BMjr7C/OtE+vzGsV2BJnvGC2ej3EPXxLy9GEJ3uT3UfSORr0eUUFPn0GeaHy3mLfa5Ik+VDTXAExr0/ZrlJAp6gd2nVlWX4W564sS1b3o3WnfmPqF3ReEQaRwd5jHVKogga3cZhl6spCWD+XatcITObB1kVmDLEjwPqtSDRWxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158892; c=relaxed/simple;
	bh=UTbyedDRTeUVV1pdrTTRSss/23YRKWL9BXtSBu7D7xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aYVVtli4TBnh1qlQ3xK0JEMXWH3XFbIbGiUsdfYEpUV3Gz65ZKAkFfYBcRGv9ufiaU/aDMi1rUrUQxg4jE9nQMvlMsdYe+htfg+Awf3eoL79N3QL/gjLVKRXbI3ygpjdn+Z/rmVG8Zo6xtzBHZ+WNz1Z/WuHKzzzjoJ7MIdLr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a6m3YLsJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f97c626aaso145070266b.2
        for <linux-nfs@vger.kernel.org>; Thu, 07 May 2026 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778158889; x=1778763689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKh6RuNwI3PSAF3V5smXaq0tngEj6fdP/FsqX2SYb5o=;
        b=a6m3YLsJjdxCWHX3Ki7d8glV3hRZQWTA7eTekZojK133TGn8INupmrv+t6/VNIMea2
         p3DfmgtDVKZae5Xibjxl6eUstniZSzSSQThsNr5STVQRzLcZnI3OHVDOZ27+4wwDXUb4
         hImTUZJ3vcP9tAXOuy9tBMN7i2L8Klo2SUoTGU01imhiSok1ubkcrjTXLz+bCX2Hppbi
         /2m+O71H0ZnjVUtmRwybjzfNadEfhu/Lm+oF394f4M6arf+WKmz9FLwc7VbdeeD2fkVa
         BXUI5iSaGzy5UzEi5zgFrlXi0COEo1b7OsMVE/z3j41isKBogYVY3M54LDAtzO5+SSun
         LXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158889; x=1778763689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKh6RuNwI3PSAF3V5smXaq0tngEj6fdP/FsqX2SYb5o=;
        b=bNv/U3Fqtmz2XQbhh8dPwyaw0D54P21IaXUFtCDVlAKAt4oXwYqSSraQ6hHqbkdjKq
         m9lAX2E9xcj6ZQEuCrtUxdjoCO06380fwPLvaA6B7zIpbLIXwiU+VswTBUUs1vyNGP8r
         2GmrsIAyl7XNBAoKnIPsn+4MRM+QN0LLqmUb+ObvELiczTqc9rVFj3eQgc+tVEoeHJgO
         HZeUFf/B7dS/hVZcnyHCsgpLp1Zrjic9xOJAoOk3vUrtS3ZMT6Py8khdxnt/398oWTPO
         AuHhigkHsawM2GMYLYVrJs4xBJBicA8yQs72OCYqTxhp/seDLNhvYQAplfbGjac0FfbS
         sjnA==
X-Forwarded-Encrypted: i=1; AFNElJ91t9DK0WCMHE36tZEhDj+xx0eZuj4gQyh0RDx+ab4fh5sSFHPZPtDAfHAQb4faZvVvGmkskL1+5Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLnW+Y+pbLbyHG9kiZcNF8o4/OzqSwh/xjfx/Df0TTI0Fm40m
	fjUeL5TU9I7yqAe99fILh1Mzr26LWQbSsorHID8hPJ8HypI1RTCokNQF/NUSZc1uLxU=
X-Gm-Gg: AeBDieskeAKI42rLPsRRE1EJ6HW1Xvj7yWq1QLz9tWnxAvgFh2/Sh8Gngfc9LjNpHTN
	BuHwrvuqMLZ563ku8UuHNOjXac3MJ1lYoyDZLtEmlnwWyjLuNCuP7KkGX9gYXsCWyCrENw7KPqP
	OWXUiAPBiCbuLSVFGXiKflyz+aAQDDd1OqlwcRP+D9xW4so2tLCKDJAZat6hf5XWPib623LsGyb
	7JK4CM7ro44uLVMbNBNSkn259w4aKdcO2hNb01JaSayxiEGbFDFj9ZxmtMxTPltMmGGYgDjOPU2
	ePlSOz1IqSNWIjYVFLhLfb7riv29L2HZqh+L48pLGZ46/HezcQzfoJRvJOJH1E/0JBzMoVdhXml
	6oXcaVyszwJ17a2j/CuefR/5MUZDVMF24bMRqvWuTA7w0e/omaqAnwGgGaNw9QynR5H1WkytXOs
	1xezF4r7dyVW7U9andrdaOcG9bCY3VDZW18HADOMLpxDB+ppt0Zs/h7VOWbTJkrS8ghJ0Q
X-Received: by 2002:a17:906:6296:b0:bc6:5f97:8f90 with SMTP id a640c23a62f3a-bc65f979012mr319165266b.3.1778158888881;
        Thu, 07 May 2026 06:01:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm19303795f8f.7.2026.05.07.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:01:28 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2] xprtrdma: Move long delayed work on system_dfl_long_wq
Date: Thu,  7 May 2026 15:01:17 +0200
Message-ID: <20260507130117.252825-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E3EC4E8E44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21436-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- Commit log improvements

- Rebase on v7.1-rc2

Link to v1: https://lore.kernel.org/all/20260430085412.96961-1-marco.crivellari@suse.com/

 net/sunrpc/xprtrdma/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 61706df5e485..1a54993f7ffb 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -484,7 +484,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
 	trace_xprtrdma_op_connect(r_xprt, delay);
-	queue_delayed_work(system_long_wq, &r_xprt->rx_connect_worker, delay);
+	queue_delayed_work(system_dfl_long_wq, &r_xprt->rx_connect_worker,
+			   delay);
 }
 
 /**
-- 
2.53.0


