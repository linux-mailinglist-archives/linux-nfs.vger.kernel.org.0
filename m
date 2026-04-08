Return-Path: <linux-nfs+bounces-20773-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GjvHBCs1mmZHAgAu9opvQ
	(envelope-from <linux-nfs+bounces-20773-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:27:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2123C3001
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 21:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4C6A3219CBA
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587532692B;
	Wed,  8 Apr 2026 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQiauDW8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446333AE712
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674820; cv=none; b=cJ2Sq8avIMW/QhzSQ0e+jhe1SmwyCYUE/V0iUFV3qfpNH4tkWhLnyafh2Xqi2hs9UyOazQo5BJMpwVliMZPWFgKoKlzXJjZhSAIru3/rGrZGc/DESPjpdfIS6YM5hQJs1t6+lp2Be8etkCkIQ0tZWt1P36JRy8a6NrokWbV6SqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674820; c=relaxed/simple;
	bh=dpGkM3GQXgBGNquth3AICHJ+FGEBrvTGB7HLwMqwm6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/nJs7RYqehCmlCjnta3JcoxrP1R/KC17W6i0PfNxDcecBsZsBwOH1jmSrkTK9mztsyzUPARBUDZiGVd7IUOnmuN+Qd4g3z7Zrx5OiGhql/Ho+7dyRyp6060qBACWwv/0HUx132QljlYbNbu1QBOeXZECABvzUxVNHXXt/q6aHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQiauDW8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775674818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6JBa5l/gisijVlmlbFEeGhVeYkUFQGskyFQOqq+rBUs=;
	b=aQiauDW8JptXsUh+4uvnUg7z4huOXCyp6MctnWmGKG64PxCJj9yRAww3VdEa26kBX9E1HZ
	tY7D1JqR5EDTCn9OkSBREE1y+ZqjLEi8tLSMAiYH1gGWTRiTEdNojy80BMqahNxaiHbc5f
	l/nnWE9A8aQ6S7iRRxMlTHW4xLSeviA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-U4vRfMrXPqO49ihAscolrg-1; Wed,
 08 Apr 2026 15:00:12 -0400
X-MC-Unique: U4vRfMrXPqO49ihAscolrg-1
X-Mimecast-MFC-AGG-ID: U4vRfMrXPqO49ihAscolrg_1775674810
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAD1C195608C;
	Wed,  8 Apr 2026 19:00:10 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.138])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E86A300019F;
	Wed,  8 Apr 2026 19:00:09 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2 0/3] nfsd update mtime/ctime on CLONE/COPY with delegated attritutes
Date: Wed,  8 Apr 2026 15:00:05 -0400
Message-ID: <20260408190008.85082-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20773-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C2123C3001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

generic/407 is failing in presence of delegated attributes and this patch series
explores the solution where the CLONE compound returns updated mtime/ctime
in the GETATTR op in the compound.

It's broken into several pieces as I consider asynchronous copy update the trickest
because the copy thread currently have no dentry to call notify_change() on. And
if we are going to keep a copy of it while the copy is running we probably need to
take a reference on it (which I attempt to do).

-- Changes
v2:
patch1: added ATTR_DELEG and doing update if status is successful
patch2: doing update if we copied positive number of bytes copied
patch3: dput on error is done based on non-null d_dst, update is done before
callback call and if positive number of bytes copied

Olga Kornievskaia (3):
  nfsd: update mtime/ctime on CLONE in presense of delegated attributes
  nfsd: update mtime/ctime on synchronous COPY with delegated attributes
  nfsd: update mtime/ctime on asynchronous COPY with delegated
    attributes

 fs/nfsd/nfs4proc.c | 41 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h     |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.52.0


