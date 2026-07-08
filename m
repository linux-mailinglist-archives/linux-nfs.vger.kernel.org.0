Return-Path: <linux-nfs+bounces-23161-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wu1iIwYCTmpJBgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23161-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 09:53:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF28722D7B
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 09:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FIPr7LUV;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23161-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23161-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D333430B7851
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4B3F8706;
	Wed,  8 Jul 2026 07:44:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F973F0AA9
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2026 07:44:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496698; cv=none; b=LX+heqLKR5OX2PoHd5paSWQsxNdW7Z0WuIxTgrjcgiZvjXnYUVK2z8ZdlKw/nKnc6H1ocYbzooyuP1v1Cf6TP4eOHIbBy2aU3sUojC1LYKN3yVir4lJu8DIYStYfzh/7NUp7b1XJ369tlKu4+m3wFRW2fqEJqyy3uNXs2D7H6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496698; c=relaxed/simple;
	bh=5wgIhcz5dUbyLc6gsqkJDqa86lbI69k4eZmdDL38RUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBckfFl84M5hGbcQi6fFtzVMI6g4Mjntn8Oo5ZGluk792p3D9+Gv439rMRX5WDBJ8MDL33Wi6w9xct6O+WPreHBQIpv6wTqVlbu5Yg1aLD3rpj4Ct9zFoqPx5m24mxHfuix1EIXphyo6PghJyochlITtIQxtXiiwC+Njuj29+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIPr7LUV; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so3870235ad.3
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2026 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496691; x=1784101491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+AAszIXf7+JKb0b1PUUMxwKBwibCloV+wRATKmETRY=;
        b=FIPr7LUVeqE7CN3jGi0tes4o3OEcoeLKZKASLSgLciDPEG2PzWKu7YqJoWC0CoFew/
         B9HTcB6KpSdD3hTPQStT5smu5ZI2PxwLGEg0XIDPVoNlQ1eLerZwPEBtwBJ/tL2qQ4x6
         BFfgI8Hn/E5v/tXajy53vTla29A3Wg9wpPxTuOBJ65qbk6lYNMkIz90Xh0ZUz6Ce4/ly
         YHX/42yT8SbFjPJ/82DEQkFvRv395w8uNx0BOrYsbW9Z5V9aaGBvb4CtedSxIA9tROs6
         +Qpn6XdDtoaSCTzNKVlGf3p6cHj+V+Us7zbsvKiGlpLRAlQ6WjYQ5nzvpZOvk/WyMSr4
         Y/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496691; x=1784101491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+AAszIXf7+JKb0b1PUUMxwKBwibCloV+wRATKmETRY=;
        b=fywOsXPyiiiAtkgmjZUFxKDpqbUHH4/6QiluFopUm9aZGNiH7K0gO5DZ188Zuji4Zq
         Etu+ZTh8Y5t1qtkSSUoyEZc8zXuChEAotpwf+dTsThggG20RDW9ozTIWoUKTTZCeLQxi
         /94llhBo1hrce9yTQTK/4jLLYrqz1N8G2D6OMlrSSheazueGUh/nU3BlECG71rCa21Dz
         eZAe9hK+lU/qhAoFvUEmcHH2j6Nooea6I7fPhbw1CLBNzQb97CMQP4p1a0J6lqxHLpch
         IqIL3JwpMn7WlRwryOSkTA13bx67w42Mc2oXpuSuUi6IuvVTbbcfqDPwTiEPqrbujRrL
         352g==
X-Gm-Message-State: AOJu0Yx4U8ewoQF/Y0OO3xxTj7Un78eODoDbizTafVnOmPNPmmzUMSlh
	h33AMeJsofIMu2eRdGz/OKy04EdP4R4oZKjFPYAxeEq3jWvr8nnGtQKB
X-Gm-Gg: AfdE7clDtGLpRyroLfS6WW+WN6hw9GE9/yVQAZl4jrPki6EK7Lt4IrhIbtT42uxS8WV
	nM+Q/otVVWL8Sts9YTf+KxK/c03nIwPBLeblHw66plKg1u96Rd8+njvby84sNdaVRehnaGPOiLs
	NrF3mQouad1wfRB2uKpM1DObCdwy8Vupnt3OOlHGD5Dhv+j65xMQ1r9sNHz9GrT3hnFkTIgR+bm
	+EoDpF4xiaNe/v5pWiirF4uud78s7JWm0R9BJzUBOi27pfWxcRAaNeBoY7WIhF8RXgAxhFGRGYO
	cuF5pnzgyWThPydjr8cwz5T5n+QPa6sNbj/NBVR16LfZ41HWSrHeADrNCH+dcGgTmkWT/dyl9OW
	wPtFVbIvfUDo+mwLGIxTJwZn3XKFjy/0HD4Ly7KWE54bnqu7cD7E8tS6Mn9LYHJTJVmKnVG0GdJ
	nsYhQovhsxjx62pFK8cPVu
X-Received: by 2002:a17:902:f550:b0:2ca:ed57:8586 with SMTP id d9443c01a7336-2ccea45aa02mr16102925ad.23.1783496691089;
        Wed, 08 Jul 2026 00:44:51 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm23932035ad.31.2026.07.08.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:44:50 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	hui81.qi@samsung.com,
	j-young.choi@samsung.com,
	peng.yun@samsung.com,
	qian01.li@samsung.com,
	xing1.he@samsung.com,
	jeuk20.kim@samsung.com
Subject: [PATCH 0/2] NFSv4/flexfiles: support loosely coupled data servers
Date: Wed,  8 Jul 2026 16:44:31 +0900
Message-ID: <20260708074433.390161-1-jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-23161-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tigran.mkrtchyan@desy.de,m:hui81.qi@samsung.com,m:j-young.choi@samsung.com,m:peng.yun@samsung.com,m:qian01.li@samsung.com,m:xing1.he@samsung.com,m:jeuk20.kim@samsung.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jeuk20kim@gmail.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jeuk20kim@gmail.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,samsung.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDF28722D7B

RFC 8435 allows a flexfiles data server to be loosely coupled, i.e. an
NFS server that does not advertise EXCHGID4_FLAG_USE_PNFS_DS via
EXCHANGE_ID. The client currently ignores the ffdv_tightly_coupled flag
and treats every DS as tightly coupled, so NFSv4.1+ I/O to a loosely
coupled DS fails during DS setup.

Patch 2 threads the decoded tightly_coupled flag down to the DS connect
path and, when it is false, skips the NFS_CS_PNFS flag and the
is_ds_client() check.

Patch 1 fixes pre-existing NFSv4.0 DS crashes on the same path (the DS
client has no session).

Jeuk Kim (2):
  NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers
  NFSv4/flexfiles: support loosely coupled data servers

 fs/nfs/filelayout/filelayoutdev.c         |  2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c    |  3 ++-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  3 ++-
 fs/nfs/internal.h                         |  3 ++-
 fs/nfs/nfs4client.c                       |  5 +++--
 fs/nfs/nfs4session.c                      | 21 ++++++++++++++-------
 fs/nfs/nfs4session.h                      |  3 ++-
 fs/nfs/pnfs.h                             |  3 ++-
 fs/nfs/pnfs_nfs.c                         | 14 +++++++++-----
 9 files changed, 37 insertions(+), 20 deletions(-)

-- 
2.43.0


