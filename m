Return-Path: <linux-nfs+bounces-20295-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LEgOVmOvWnY+wIAu9opvQ
	(envelope-from <linux-nfs+bounces-20295-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:13:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D402A2DF3BC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21265302924F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB23E51F4;
	Fri, 20 Mar 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ0ZoYD6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88C3E123C
	for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030248; cv=none; b=i3pQUPQ/JpnEseIJ3kSMlsK5YPEquqxSLzzpllYchsSoNJsqbSv6aW+cizUlpracoYsno74iFbldTVcO4mgoIT95wmH6SnODoYkqsVVLWtM1Vr3lWAncRrN76SvwWAOAW1lwh+uAv30awrwrm2WTibS0d1wfa2M0MYfZv857vp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030248; c=relaxed/simple;
	bh=bUiSWNCV/q5GUTFEbO+pksJYyRD9RwJfg6d89NZyVP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ssGfrKVj+ZzeIDjdu0khtanVFKsGPuIzOyrqH/Ic2K6GK0q/adJ1M9YD2i2QxFxn8DvPZEy3RDqr+F8/pk8OM8Tnj2ZcKvjtE9+RC9DfcJsl6beWbGfu5pmWycpMzTQaHQzyD9AmhrPGanQj7b+HfbKbgF/iJHzvayTX2uNSNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ0ZoYD6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so1199942a91.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030243; x=1774635043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlLjQPOmeaFila1aoTGt7mA4cxCj5RPLrmoLbYLboac=;
        b=KZ0ZoYD61cxyevsY8aNSJncPBT+8tw1VX2NXfdSFeaKpy05cnXzIfSbpg8lV1bnpnp
         wRPTa3B5AWIaBiwRlEnmfQu2vkjlKofsZyEatzVeup8A1VpjT1EAtGeJM78PagAMhHsv
         5+qryXzH3U+Xc9a2veZoPQph6g6csC7WxVGWcV1lFxv/H8W5Zi+3dNhnVW+bVA9051Mu
         Cz+oKWO3bsM2h94QNl52VIl9KA1EdfZAqyLCk6cqfi2CZ2PvoDYDHyG+Vlj3eKfDmh0b
         02YZnVW11RybGH16jnOsbv7jWAhzAVPIqs6XJfBQmHroB+LH48wU63OFe47kDbqYko/8
         ySmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030243; x=1774635043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlLjQPOmeaFila1aoTGt7mA4cxCj5RPLrmoLbYLboac=;
        b=W+wE2mTYJxXAjO5P0MyJ1stLHUz3XsoOClCOgeY0WnmyYr1wh1POs6KiDDh+hEOMOG
         5VjtB7+xmiOfUclGnCD4lNSKlKmBdHrcPMzbbNF0s+H3Xh/wwFwUsl1WjuFtuXsGJ440
         cbQaLvUkVJlnLvAmX9ppBalwjJOdVX+kcm6nY21PTumABggMRdYPJa2ExPingD8duMku
         knSdsjIPNoTEMtP4YgqmiQHV+SIUnAho3d8A14kiBLKL6ewMoWJgK0VEHY9EmFzGEK+5
         4KyvvkJ93Gf6NZVtYTQQsqNrAaU2HmFD43I3DthmvBF79gx6ZHTuywwTG+V4Bco5W4No
         pTnw==
X-Forwarded-Encrypted: i=1; AJvYcCVH1Y6vgfgw7gaTpN6Zr4GTTvS4K0rsnP8BSWD2otRfgFHsamdByUENLRVsLOoXyhTekMGVnbBQ+ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdrrnT1/4tbg6rRZsgN9cJQM931HGtva4I098Fu75jsbom6MA
	G7BfDLSNiYkUwd6JEhKbO0TCQ0Vrub9ieOTyjU6IFbFHWSCgnm6dQckQ
X-Gm-Gg: ATEYQzwnAgRilZFxiYbtQRIW3WWH+12cn0OJKzQZl5YiFyE8pvwbHKFyeYJpj4tx72M
	PpyUgGQplA4SG7mIn3lr3DguUEsF2eeoUYjs15tgYZO/F/M7vP/VSK+Y6FhrorsKcZ2ltbrdhg9
	kl6OcxUe3T1gB3g9ZQDYRHvd0Lbd6GUBQukR86DYmswHgqG2FX1GWrAqauCWOwNN1OcpfUdMpxK
	18oA2q5EYLn61we+pom2mYJEVVhSQIMssiwRa2tDJSuU5QH6sBLVDfgzMkZzkqQQrWLg1Omhowc
	RACHoxOoX5RtFISGxc18tLwDGxzJZC43J5/6+GObFU4lS/plvMoIhx+8y8qU5JwC5opL27UZA4P
	y1wVJnH9k8UuMx6pryZ7+iKWQrDbw+eaKAvFukt133t8IwRCT3mBam1h5ocKTJEFUgxaYnp8ikW
	pPlVLIyLJBhvSZ3A7C7m+qkrqi6fk4WTGWFisSo7NgbzqC1nWAGlwgydrVQt68VyUARGYzai1PB
	BCxM3el3Q==
X-Received: by 2002:a17:90b:17ca:b0:35b:98d7:a67 with SMTP id 98e67ed59e1d1-35bd2d0860bmr3278434a91.31.1774030241779;
        Fri, 20 Mar 2026 11:10:41 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:41 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 0/5] sunrpc/nfs: cleanup redundant debug checks and refactor macros
Date: Sat, 21 Mar 2026 02:09:50 +0800
Message-Id: <20260320180955.150696-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20295-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.861];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D402A2DF3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
across sunrpc, nfsd, and lockd, as these checks are already handled
within the dprintk macros.

Additionally, it refactors the nfs_errorf() macros into a safer
do-while(0) pattern and removes unused nfs_warnf() macros to improve
code maintainability.

v4:
- Add a missing patch to include/linux/sunrpc/debug.h to ensure dprintk()
  properly handles variable referencing via no_printk().
- Remove obsolete __maybe_unused from fs/nfsd/export.c (revert ebae102897e7)
  as suggested by Andy Shevchenko.
- Add Reviewed-by and Tested-by tags from Andy Shevchenko.

v3:
- Added nfs_errorf refactoring and removed unused nfs_warnf macros.
- Split sunrpc and nfsd changes for better clarity.

v2:
 - Follow reversed xmas tree order for variables in svc_rdma_transport.c
   as requested by Andy Shevchenko.
 - Polish commit message: use dprintk() and remove redundant file list.
 - Correct the technical claim about dprintk() type checking.

Sean Chang (5):
  sunrpc: Fix dprintk type mismatch using do-while(0)
  nfsd/lockd: Remove redundant debug checks
  svcrdma: remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
  nfs: refactor nfs_errorf macros and remove unused ones
  nfsd: remove obsolete __maybe_unused from variables

 fs/lockd/svclock.c                       |  7 ------
 fs/nfs/internal.h                        | 28 +++++++++++-------------
 fs/nfsd/export.c                         |  2 +-
 fs/nfsd/nfsfh.c                          |  8 +++----
 include/linux/sunrpc/debug.h             |  8 ++-----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 ++++++++++-----------
 6 files changed, 30 insertions(+), 48 deletions(-)

-- 
2.34.1


