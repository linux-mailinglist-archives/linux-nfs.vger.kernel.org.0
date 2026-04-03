Return-Path: <linux-nfs+bounces-20626-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LY9LFvAz2ky0QYAu9opvQ
	(envelope-from <linux-nfs+bounces-20626-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061F3946F9
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC125301A43E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76FC3B8958;
	Fri,  3 Apr 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWde06pY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC803B9DA5
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222869; cv=none; b=E+LOqS6C2X3LCi4RschtzHb4sCpyVrps79fxadtDaUbZyyfXqF4PLaLQLxuR/R9GKa95dt88sqFN2T617Ho6d3WlTBQfQ3ePWo9HSvmaDYlJWyzsDqkbCQ5glJKW4swfkUv7csMxA+pArNTMN0A8VzRgW6sCqpWNm0vaMdm1Txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222869; c=relaxed/simple;
	bh=+GbitvSWk0Ko4CQh+QghTauz0H6g5So4bZk0dgAtYwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8fS4MDv0Sq6h0m2GCs5bp8/5W+GDN2G/f9SG3Uoepxo64Kf/nljKdk4qVfgRgz6nNsNLe2wcqm7JzwBgWDm3SMQA+NXNf+U9tzHhNCCt5SH0iNeKjeDEabOQSqJX/PB9c5zl63REjj2Q3BfSuAtfv3qdTX1TZy5+Mg81seI76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWde06pY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775222866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAZ9k86GR5iHZefNOJKsk30wd2fcIj413eC0HnNOlZ0=;
	b=GWde06pYlPuFMf84DDYRWGBEXwHPoI7ox+qSm2xXN6Izcahv8t9ZsYlFpb831vWWGW5cFx
	ynCpEoOFWKO4vv8ITzPQWkYHQks9EMqEw+x3NegFNeRPoziU3VRjRtZW6j6XGlyG0sgXSy
	m4kzZt9XV7Rv9v+6SVynU48+0j6ZYnY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-nkeOOgTvMraPFkktFJE30w-1; Fri,
 03 Apr 2026 09:27:45 -0400
X-MC-Unique: nkeOOgTvMraPFkktFJE30w-1
X-Mimecast-MFC-AGG-ID: nkeOOgTvMraPFkktFJE30w_1775222864
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EE5F1851063;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C5501800576;
	Fri,  3 Apr 2026 13:27:39 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 524C1749DEF;
	Fri, 03 Apr 2026 09:27:38 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] pynfs: _testCbGetattr() should check the delegation that was received
Date: Fri,  3 Apr 2026 09:27:37 -0400
Message-ID: <20260403132738.1482011-5-smayhew@redhat.com>
In-Reply-To: <20260403132738.1482011-1-smayhew@redhat.com>
References: <20260403132738.1482011-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20626-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2061F3946F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It currently assumes that if it requested an attribute delegation, then
that's what it received.  Better to actually check it instead.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/st_delegation.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 6ed1f5d..2257966 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -351,6 +351,9 @@ def _testCbGetattr(t, env, change=0, size=0):
 
     fh, stateid, deleg = __create_file_with_deleg(sess1, env.testname(t), openmask)
     print("__create_file_with_deleg: ", fh, stateid, deleg)
+    delegtype = deleg.delegation_type
+    if delegtype != OPEN_DELEGATE_WRITE_ATTRS_DELEG and delegtype != OPEN_DELEGATE_WRITE:
+        fail("Didn't get a write delegation.")
     attrs1 = do_getattrdict(sess1, fh, [FATTR4_CHANGE, FATTR4_SIZE,
                                         FATTR4_TIME_ACCESS, FATTR4_TIME_MODIFY])
 
@@ -362,7 +365,7 @@ def _testCbGetattr(t, env, change=0, size=0):
         if size > 0:
             cbattrs[FATTR4_SIZE] = size
 
-    if openmask & 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
+    if delegtype == OPEN_DELEGATE_WRITE_ATTRS_DELEG:
         cbattrs[FATTR4_TIME_DELEG_ACCESS] = attrs1[FATTR4_TIME_ACCESS]
         cbattrs[FATTR4_TIME_DELEG_MODIFY] = attrs1[FATTR4_TIME_MODIFY]
         if change != 0:
-- 
2.53.0


