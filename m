Return-Path: <linux-nfs+bounces-22041-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDfJL2SXGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22041-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:28:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1983D5F7103
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C2B30F74A1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5AA3FCB15;
	Thu, 28 May 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PRMywOFN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D284028E6
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996166; cv=none; b=edz8ss3MFOMgPAQuNvTURVsYRjchYdw7zGIcj3/jPIyOV1e+oJwOb0PYvjSgouDLzLtIYzLQ42+73e0XJASJFH+Qa2+GJ2iHKzZTZ7fYTQC0CJh2pCuxb2O9jXhYYg9PXbwLzSltGSUvbpX/tk8Sz018LJcH+w3w1Czfcz8kOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996166; c=relaxed/simple;
	bh=3E+fdtlqzc6r3vN6yhSVg7JxTYzkxjEhDjS4EH0A5XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLYIGBoSQHvxDD5tXCWmvF0G3jnug42illmJVZ8qimvVsg3Q+/e4oQyZvbXcALUOhW0S2xYICpQa52yrzUv0YIVtPSFNHNb9CkeV5ntdYx544cvoL/liZEifaoFtRpEIYUeRonqvPmJuunpvnh9cXdKjP7az5Zaq1EtCKelobSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PRMywOFN; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de7dc85b74so12146598a34.2
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779996164; x=1780600964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JmKJ1PjReK7YbYNeH9An3dPVC6qsgBwl3uGOHwtbo1U=;
        b=PRMywOFNoU1vpTPQ9ONCdZivQYSYxp6EHYiHsPTNvsdDjakmG2yguznVIlI7MY9mTy
         90ZKFz1LelfxFDKcFHMFyVib6MQkRkSTlEe5tVyJaVMuSEkOQR6XT9fgCEkwUc8WqeY4
         XYCrDNwrpyhZPGV+CQs6XmornFDP8UxQnkEDVOdJ+lWlHypI+ksz8eIyEOsZXcMTn8X1
         kNcYlTcUTeDUmDE/3u53SdclmxJB8Sn24AGNYJpAB/xwt1Abi+w/+vq1kbuZ5TZkzEMC
         je1kQJS25sJJt1KjdTbsEe1XndAZoERtQY7xM80vmsqypl1BxNe83HysgtqSCLsfx0lO
         ksfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996164; x=1780600964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmKJ1PjReK7YbYNeH9An3dPVC6qsgBwl3uGOHwtbo1U=;
        b=LjBYt5hq8hsSsa5+guX5wiIVJtKzbpBK/x0luLuZ9rg9g4Q/N8lZykEuQXUqIiSldd
         M0mZHRk8ZcLZzHBY0lIEbdel97hWUDKH8tVaY7PJNkIglj1MXgKwMMqFGm2FVSv+ln/A
         RNb3NdDKcveuxrmsCDP1SoV3hfTKiJUYYzTWFhM0+TLI1s8gio5XUffNaM/CFM+rvznK
         tDHsNCtvSHlewBDTpBsOhYqmLhMI8rwNK5UTF4YOmADkeR9m1bzmjtZoRXcTB++lefpZ
         mkoN0QlbDhVjuQlBt/lMFHYE9QG1pBsFwi6XEr4VBoaBB+6L1aqCx0Xzg4tYwmuy5Y2P
         WfoA==
X-Gm-Message-State: AOJu0YwlWxMpLa4Hik6IIZxfWaEoB8Pll+g2rITxm0ICOGP9XwNfKvW3
	9ARcyflJlN1NSwHrt6KU1bXxbpCij/R30opjHFmA6Swk75by41UwqCCnYqIHNJapOkJt3qqrvTD
	oXHHN
X-Gm-Gg: Acq92OH6ZnTXq9Qg8ugMnzpZ7Wae65CeSd0Cby1pWnISvWyZdpH0Y+XMOOJSxcWhiXG
	1/k08yHgWKBgBBuy4xlAH2oLTNGNsmRFXswyrKPfp/Ra3Tgad4mEX3q9DjQVIE0mapVHo2vZdlQ
	Mh3HdRzxETvtbqtZUdxskkcGkhM5vDcAzyJkE7hSNRS5T/cP1wKzDAYOvwwqB1e29FiY4lW0UOJ
	rJ/X1nrR9UJ5LvrVTiUoxz0G7znAjkyyLWYlaSc619tjRAe7EnWv0HF+WRBk++xTUL8inTVmPFg
	0d0GrS8TkHovZgJFrkRYB7UabtsjjbW2OQXBstTW2bFw4d2ADpR/jQIMjVi0Hy6fkgUOAvmsXv1
	ckw53DqNEIlfmII2ytwwj9UiN/5lND+yPyDwyof7J0oh0fQd/xeKZTGI/5LuDjHnR/zLqGXb3XD
	O4ruHoj4Q5UvFShr3koUd/igyUFec/1zY2K08/BwzPW2SPRO0zr2zmMAXLftNmfJunkvJA5A==
X-Received: by 2002:a05:6830:6403:b0:7e3:7697:9b5a with SMTP id 46e09a7af769-7e5fef04f28mr17401222a34.18.1779996164172;
        Thu, 28 May 2026 12:22:44 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6064aa0bbsm15006127a34.12.2026.05.28.12.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:22:43 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Client optimize away CB_RECALL for write delegation
Date: Thu, 28 May 2026 15:22:41 -0400
Message-ID: <cover.1779995818.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22041-lists,linux-nfs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1983D5F7103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A client holding a write delegation that performs a SETATTR that would
remove the client's write access can expect the server to recall that
delegation.  The following patch addresses the simplest case to dectect this
and then preemptively return the delegation rather than have server recall
it.

Benjamin Coddington (1):
  nfs: return a write delegation when a SETATTR drops our write access

 fs/nfs/nfs4proc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.53.0


