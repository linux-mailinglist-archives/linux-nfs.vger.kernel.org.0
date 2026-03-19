Return-Path: <linux-nfs+bounces-20272-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOYsHkUIvGkArgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20272-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:29:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B42442CCD35
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40A1301221E
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477FC33C1AD;
	Thu, 19 Mar 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlpL6J2m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A07311950
	for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929938; cv=none; b=FZ8Af/MfxhKHq5X7Zw2pFahzvr95bhEzKEk9es7crl5a3Wx1wgderLswtoNM19FLGjqHaFfv8mNVj4y8vmWoftvrxNM9LD5BsUm1wyBj3olIfNj53jpKhFlhtKw8HqS4Nx4uGS5xyprPyng3X4GckAVeqALN7n3c+RK/1ea/EOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929938; c=relaxed/simple;
	bh=cXaB6onOcmhtlbEQzAjZenJRjBF6efrCAwAQVv+cJrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqDkRodR+fq2ju45sENip0LIROPIKwVGkoBqt6W9qafu4P5PGJO7emgGV5Dtiho0O6U/3jXVkra9wB/9xNqHeC49IueZfLw3m7laKnwJzdozHN1GpRJ5HL9+3XmPMPwnavT+ywayPQaQXqRZBGmsJSVoOVOLfEA/AQ9jB8WUpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlpL6J2m; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso533245a91.3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929936; x=1774534736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxDBjr6/ReCHWPKHk/iZN3r3a0nWe4360PPKYwY4WSo=;
        b=PlpL6J2mZyXlwQrAL7LGkl2fiVlbtleLQusEvdmonectOxd9FkxSMKFGajV6p2a8Qm
         jSeV2sE5Y3gec0TdFKZ6IxNRg2dB+I1pdAX6AdT7HUzFCUeIHl2fxbGC3qFrv9sVxicQ
         gVoSDrBL+btS9igXxepsRx/fkrDRZpRMb/asadw71h4pYDSvMSvruBmsXHuptyFKv6As
         Vk5tSvXem2rDp0GIMPsPDAGYCyMHY3J0W+C2AGuKoZy7HThjSalbhCMDYGR/cwySPh/t
         svHVWgnsVjRa6Mpna38rwFuKgTOs0tMK2QN/m/FIShkt55WnzP85pY0gl+hxA0ihWZkz
         Veow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929936; x=1774534736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxDBjr6/ReCHWPKHk/iZN3r3a0nWe4360PPKYwY4WSo=;
        b=eokY3NGyHRyB44MUV5M8JqUeU7mfKykcI9984YA78xfqlN6iJRJ/h3gaCmEzRX/Xk3
         GdA7/qQGuLOxpc9GXXeQyp3Ra9LpLIcZUzzaacbdTuyMSXpKcYuksjM2wzDuavlse9KY
         XSh03ffdNJkRGRfj0ki4dYwIaDpq6Z0dsu4z6lNar1kyQChvcF6Tym2mCj6ctpyp2BG6
         nMybHnqFS2IDl8Lizp0I5K+XJIh2UM1QBXViKUH3Xu3iN+UvygeHR/PumKmrMSxT1Pdw
         OCt9vMHzdBaOD2EfYeGXGIBcX/+kPzz3KLSQAa2Fs3QSGr3mhPpSYrMDuAK22Ho0UrRP
         g+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3SOc3twNkIuAHiVlqWZACMOfiLjA0EvM36QAGNQqW+eK4fyT8HopJUxBXsOLrzAXahXDdScVglJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNOlGj0EppNViBs13gcRhAWH5zetkzA++0VFB5XCZM5lc7grN
	RYIb5AkG83SlCPEWdUHV1h9EjFrBbHNNt0h18jdTGnvxScRfn4zxERZW
X-Gm-Gg: ATEYQzxHHm+hO80HZjxX/iETJ4SKR7CFeZPTTBkdzI7ejLA7teJgXOVCsoBnQ0p9QRd
	cubEsUq5Sl9kmG1UCPH4uG54VV451s/fGjZaTn1sXLLJ+YKnxvrLx7S7iom/UcoJfbJm4VdbIYu
	V+qP4Z1ijri2SM4OBMVTeWj1QIRbRc6ES4v9eMxEH9NM23FuzIHjxZq6rkKwVHXtwyCxDGYSvzJ
	H+NxI6BVwZ+A++qfKp9QhtBo/C/d+vRs0dzg/TH/lmdO7CjeuwO9G/+Jm30/o1/rULq1EmrWTg5
	rXX+ayFAHUY68fTetvncO0Yyvla8YRrP3OX+f2k8DK3gUeHVEnumNp1ikv+52KR+4vnERjpTw28
	gfz9PK6SKMmBdbsdaMPJRvZ+Seni6yyI64pkpGRhxgMbnrqqscnNVn2egYCjT8LSV9cnn9nFSi0
	qoQRcgPB0xdcEF8NvxWQ/2rnOyOawIAby0Sq1uEAequLkyhzxstATr3cflYtRICuLSNYMnRsI=
X-Received: by 2002:a17:90b:3d8e:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35bb9e456a3mr6473116a91.4.1773929936315;
        Thu, 19 Mar 2026 07:18:56 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm2695321a91.17.2026.03.19.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:18:55 -0700 (PDT)
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
Subject: [PATCH v3 0/3] sunrpc/nfs: cleanup redundant debug checks and refactor macros
Date: Thu, 19 Mar 2026 22:18:43 +0800
Message-Id: <20260319141846.78222-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20272-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.726];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B42442CCD35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards 
across sunrpc, nfsd, and lockd, as these checks are already handled 
within the dprintk macros.

Additionally, it refactors the nfs_errorf() macros into a safer 
do-while(0) pattern and removes unused nfs_warnf() macros to improve 
code maintainability.

v3:
- Added nfs_errorf refactoring and removed unused nfs_warnf macros.
- Split sunrpc and nfsd changes for better clarity.

v2:
 - Follow reversed xmas tree order for variables in svc_rdma_transport.c
   as requested by Andy Shevchenko.
 - Polish commit message: use dprintk() and remove redundant file list.
 - Correct the technical claim about dprintk() type checking.

Sean Chang (3):
  nfsd/lockd: Remove redundant debug checks
  svcrdma: remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
  nfs: refactor nfs_errorf macros and remove unused ones

 fs/lockd/svclock.c                       |  7 ------
 fs/nfs/internal.h                        | 28 +++++++++++-------------
 fs/nfsd/nfsfh.c                          |  8 +++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 ++++++++++-----------
 4 files changed, 27 insertions(+), 41 deletions(-)

-- 
2.34.1


