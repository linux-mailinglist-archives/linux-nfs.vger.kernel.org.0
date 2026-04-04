Return-Path: <linux-nfs+bounces-20652-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM0dEjMg0WnGFgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20652-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 16:29:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C27F339B60B
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89109300BDAD
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903E29D28F;
	Sat,  4 Apr 2026 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMMmLQMr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B6273D77
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312921; cv=none; b=GmmxX/WrjlSX2+yMFlLZql8TzlZmoO6Xrsq6NIs3JjezpME6h1P/VARsrBVsXOkxBKImt0YlNvvlXCbGyqaTbq+cjeE9foFYoJWFENYgThL31iFMSzSapX+Aluu7CGOpTHZgve8uB1UYdSHfNvoQVkHWnvW5wj1wKhyB5ydCrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312921; c=relaxed/simple;
	bh=2Up/ooB1F1IW8Et3iiWgK6r3LpYS5a02mdN+3AgSDSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxgduEjQ7o+6AZhgW5VMrvOT1+IS4fFNAFt4WWf9LoQ5TzYUXugrim75oh1gDJWWIf+SVg5e2hDd1xB0y7bZwej41kg3Fo4/3NyGK+itx9xRwQzqqilqnxrcBChqFbPptBioIqi4xKJjbfLd16UTSX7HszpAkn3xQ/BOBEa8oeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMMmLQMr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d424af6282so200110785a.0
        for <linux-nfs@vger.kernel.org>; Sat, 04 Apr 2026 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775312919; x=1775917719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QW+xJnpJU8nKA23Wo9lc4Fv12FM04P5h1eCRyd3g/I=;
        b=IMMmLQMr3ZmRkTULLHrj8be+mgaQOA/RBdft9fVTIq8rhDs1fDEL4dUBODuyv2L4Gk
         8olCJsF6zwhk47oBhot3bhoKqsSqFHpABzeeqwdgsXZm/wccwUuetmwi60fpEBX4HZtt
         2bN9RBTvgIuHNPsiEnLg3eUbpipUXuBSNlSNb1G/3rUkIGKOPM/TKQ1KPLjsLZLbLoWZ
         RSR4hnTB+JWhE+h1LWYHxzL5MlSN7ERpwR0ouFypXJGJboKRlY4aGpxCxxXa8hUv2QTQ
         jpx1zzwQ7gpGNWWtHr6LeVPqvE4zRBEBsZAwLGqWK1zUSl2P6jKmjIE+wKgh2fcWae4w
         8eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775312919; x=1775917719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QW+xJnpJU8nKA23Wo9lc4Fv12FM04P5h1eCRyd3g/I=;
        b=H8k3F/bLz6iEb4hOapUIStIyWF3I3636OdYcino+2zQNzZMRPUwoJXY1DaIE+gBvJQ
         bXUneDq5z7eiTaDVeXdv4XY9VEc+SUCXj3MXUElasBtlbV3diui0cU80nIB3S78rWpta
         UA8oyfFP7dyQ3HpmmUIprTSlLgmiwbKvMv6OQDvUroWY/VCwUfkBUa3HSuvHU0FClvFg
         Id9b7aAr8AcxcH8/+P9Au3yIC/TpYphmUbwGHWeK+NlUcIQnWx7o5Z21qhRsjyDzgGw5
         GhKFWKY1WYRM294A5q+UWHZQ1O80yfQjRUAfhoITjalCOEy0JBKHM+NMbnydqTeMwkV4
         T/eQ==
X-Gm-Message-State: AOJu0YyzyGiNw4g4RIqk0RDti5sLumats3nUoQ97bGToB4N/lsa8mOo8
	HYMSHbz3fLp7sbdsxfNGLT+2wFrJx16iKEa+hNETkcY9QHOSkcN4kCYH
X-Gm-Gg: AeBDiesshrbtd7CrAve4ftBRKq7BK9Sw3OGtdcuRi9R31aGcK3TXoc5hvAWvqMNsB4U
	p+PEHrJT+0qavC8ToThVZgJSj6GA+0/YkVkbvg0gB+aguEMVLiKNTqndkMVm0o9Hu9I9pTFQXms
	2muP0xeCqcl1RKyZ3OVa5AqtoxLWzZU751BZ/xqK1hoCS1SdYmu2PUCnFDdwvRJVMBx94QkzsDg
	BZnEdYz3d3AowySATgiR3jYZEI2/rcdtCMeLmX0IqG5N9H4RjV5R2Pqxb4aSSt0iDcgvjJLcxjq
	1wk6edJ297BQH6Z6kFqydYfhCJwnG5kVPdO1+uWvhQTKY14nLOfPCp1EpLL5d0DWGL0MU23OqWa
	0jQSj0rP9Os6SBYTa6/9lZPzwIyRI1751n50Qndjpf5R7CaD0nZRoI3mE3PCTsDug6eF0Lao8j3
	CI981xKgy+5QYbhEOVI5PMeVi5WzcsiO8YoHMamHe/qyM=
X-Received: by 2002:a05:620a:1788:b0:8cf:dfc9:c099 with SMTP id af79cd13be357-8d4185cd9e7mr987243085a.14.1775312918600;
        Sat, 04 Apr 2026 07:28:38 -0700 (PDT)
Received: from desktop.. ([2607:fea8:d681:2400:e8ee:54ba:50d9:dea6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d4b24ea458sm299111085a.9.2026.04.04.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 07:28:37 -0700 (PDT)
From: Tushar Sariya <tushar.sariya77@gmail.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	carnil@debian.org,
	maik.nergert@uni-hamburg.de,
	valentin.samir@magellium.fr,
	regressions@lists.linux.dev,
	Tushar Sariya <tushar.97@hotmail.com>
Subject: [PATCH v2 0/1] NFSv4.1: Apply session size limits on clone path
Date: Sat,  4 Apr 2026 11:58:02 -0230
Message-ID: <20260404142831.3341498-1-tushar.sariya77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177349021750.3039212.10211295677877269201@eldamar.lan>
References: <177349021750.3039212.10211295677877269201@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,debian.org,uni-hamburg.de,magellium.fr,lists.linux.dev,hotmail.com];
	TAGGED_FROM(0.00)[bounces-20652-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tusharsariya77@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C27F339B60B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tushar Sariya <tushar.97@hotmail.com>

The NFS automount clone path (nfs4_clone_server) is missing the
session-size clamping that top-level mounts get in
nfs4_server_common_setup(). This was exposed by 2b092175f5e3 which
changed submounts to no longer unconditionally inherit the parent's
already-clamped rsize/wsize. On servers that enforce tight
max_request_size budgets (reported on Dell EMC Isilon/OneFS), the
child mount ends up with raw unclamped values that exceed the session
channel limits, resulting in NFS4ERR_REQ_TOO_BIG and user-visible EIO.

Note: I was unable to reproduce the exact failure locally as it appears
to require a server that enforces tight max_request_size budgets. The
fix is based on code analysis — the clone path is missing the same
session-limit clamping that top-level mounts apply in
nfs4_server_common_setup(). Tested that the kernel builds and boots
successfully.

Tushar Sariya (1):
  NFSv4.1: Apply session size limits on clone path

 fs/nfs/internal.h   | 2 ++
 fs/nfs/nfs4client.c | 4 ++--
 fs/nfs/nfs4proc.c   | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

--
2.43.0


