Return-Path: <linux-nfs+bounces-20946-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y086BgSo5GncXwEAu9opvQ
	(envelope-from <linux-nfs+bounces-20946-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 12:01:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE442395B
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E61573014C66
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263626290;
	Sun, 19 Apr 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCuQIAIS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC340DFBD
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776592895; cv=none; b=mI4YxaxMnhaifI2ym0x3BsLTn7yDB5s9ItXjXGfOYQYLibJX4dXNOhT0GgR+x1L6mKo9K5Lyr8yX5+YFughjic+X2nfvckNiVChgq/Yyg66kHbk0XNnJU9dZQu52novvYtTqfiT3DbiEV8ECkfbSbbQJehziryGjTACiM2MKkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776592895; c=relaxed/simple;
	bh=bWOzYnwtpJPFfcCzAqzyrLcOkcqhlEuyq58SsmiOSKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Woh5EPmhubDQBo+uIUxBoQ9h3N0HLRKsDNAyteQjg5UeoJDVWlhsTmVya4uDan0vSQQ5U4sClRzRYDq6WHQjPHmUCrI8u75FkTcIHbo7We3eNrAaan/GD0Z551E5sBfna0gpxK1MmnlP2c+Zr58Cd1VkyMvLTQoDGQYyjkO0nQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCuQIAIS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso1527350a91.1
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776592894; x=1777197694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNm0h4QX/EhfLoWOBnAijFBFXAhdw8Hwyw3K3XZpPes=;
        b=pCuQIAIS9/gliZAj3BByBvloABmdD3Nc6GnKAnrj3miuK0381WxXFkauLuZUoRBdmS
         dbn0OtCOUWq3T7vqHxAv2QouSayGcqOGho81+WKddN2ftYtTZ/HExqJch1wQIdhu35f1
         7uEwwoW3zqmkC4OgODmfv0WA9AptE6STh13J0YJ34NWOx3WuEKdKBu7sMxIHSowBbxdT
         VF0JQMKSPmVRMqZ971dS3ZduYve9jrOr3WaZvn1EmzRPr6xTBeVNgEWdai7M7mgdJxSW
         WQMISlg2R0xt6ZKXVebHJ8ATP1WKd8z9s5levH3O3BkFY1Hv54UIX38PV+KCohfKyZnc
         /ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592894; x=1777197694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNm0h4QX/EhfLoWOBnAijFBFXAhdw8Hwyw3K3XZpPes=;
        b=HjpFf1E8U4dcaOw/rTi923Jws9xKNCjEj1QVKz3iDT53P3UeUY+77k4DLE2BfgNo6d
         WQnfRaVsEww2nvM+Pdl4+ryt4D+xnN+ByydMPknVGmj+c147GdDqyM6+bxEmxqXnLyhW
         nX/Zsvg72JUkZoA8X8/Kc9aIyrUzAPiFzZ7F6qPXym8j9mgCB/IN0l8fjmXpRjpK1Q/j
         Ffx/jL1JcvW6hdbKbsTzf1AebRALvjU9ZgL7y0507ll7R3z+7w9xk86t+KbFSdpNuBuf
         0tMFmLP73ybucOTKFmw/j2kFowtSws9d5pU/xKhDEn/pARp7qWnvJov8Q9TKz3PXhhlO
         tkQA==
X-Forwarded-Encrypted: i=1; AFNElJ+14e5fOgn9d2OQ9GTVgIEqwi/7vrgVhK5ezqCBmBpYcBX+Q2IE70CIJAeRhBEykemi0E8F1d16lEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWBZB8uz9ZEtyhuyyhLF40wpT/AdX/tuWdC3p5HTpjk6YiAXrj
	ge0+WmRsEPlyqiZuqHnxnaC42+GA/GSGxKzNh6P72+x2NrelShpPpIqS
X-Gm-Gg: AeBDieuRNvbZHPw2o5ykLIwsPSS1FD5QLXd7uO5QE+FIZbGLo9T3xJXbkDhpRJoG81h
	tLM+HZLGigZy0P3at8ZwjbJppNjMD4QaB5p/7VzE0nDKJi5fec/MM20S5kf3FlVZQD/EEMfDCgB
	hlgC0hQd7nMNXU3oaiJV3VttZNYfUYePzxmdvm5GZCb41sO2Mq6xWvp4WnwZGvPdfKU/jWeeKRh
	NosZrnnZ1XczVUtDHgOIoVgaSV4QEH0+lBtlZ8+4mBxCBEOl06QZe/1JMs7Y68HvBHRotuVzZ+W
	iJI4M3rFpFHSCwrZg5bPAq7CiYPRPuL5Kmv0axE+h2r4/tpdEiVkomEyUUlmvyfEExnWM7xqAJH
	mNbRP6iWUoiyM2vaLrRwN9aAru8W2gkY4+i4OmS8zbx4HRpU4MpI6fvWtb7l5LYENjD8tG8pu1F
	w+uYyRZXIpt7WLKO+qceO2o1Aw1Cy2SX4nxSndek+haPf5pMYaHcrz00Wjn/uK7LE7PUoQus1fk
	tdHZLj9Vp+JPu4cc1hjtslORQvqPA==
X-Received: by 2002:a17:90a:d0f:b0:361:45df:114 with SMTP id 98e67ed59e1d1-36145df0462mr4986723a91.19.1776592893758;
        Sun, 19 Apr 2026 03:01:33 -0700 (PDT)
Received: from localhost.localdomain (1-160-233-238.dynamic-ip.hinet.net. [1.160.233.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410bafa9sm7114296a91.15.2026.04.19.03.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 03:01:33 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 0/2] NFS: fix RCU and tracing pointer safety
Date: Sun, 19 Apr 2026 18:01:26 +0800
Message-ID: <20260419100128.20546-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20946-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7FBE442395B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses two Sparse static analysis warnings in the NFS
client related to RCU safety and pointer attributes.

The first patch resolves a "dereferencing noderef expression" warning 
within the nfs_page_class tracepoint by removing a redundant __private 
attribute that was causing Sparse to complain during trace-buffer 
assignments.

The second patch fixes an RCU-unsafe dereference in nfs_compare_super_address.
It wraps cl_xprt access with rcu_read_lock() and rcu_dereference(). 
Following reviewer feedback, the RCU critical section is kept minimal, 
covering only the transport and network namespace checks. An additional 
check for XPRT_CONNECTED is included to ensure the transport is logically 
active during the comparison.

v2:
  - Patch 1: Instead of changing the 'req' field type to unsigned long (as in v1),
    simply remove the redundant __private attribute. This resolves the
    Sparse warning while preserving the original pointer type.
  - Patch 2: Reduced RCU read-side critical section scope to cover only
    the necessary transport/net-ns checks, as suggested by reviewers.

Sean Chang (2):
  NFS: remove redundant __private attribute from nfs_page_class
  NFS: Fix RCU dereference of cl_xprt in nfs_compare_super_address

 fs/nfs/nfstrace.h |  2 +-
 fs/nfs/super.c    | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.43.0


