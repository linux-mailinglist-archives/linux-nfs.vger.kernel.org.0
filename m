Return-Path: <linux-nfs+bounces-20641-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ih4GsNb0GkA7AYAu9opvQ
	(envelope-from <linux-nfs+bounces-20641-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:30:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF349399552
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8EA3017C06
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 00:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5791F099C;
	Sat,  4 Apr 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiwPK8OR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E3223DE5
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262656; cv=none; b=qdQTtWL8AAVqjB4KaPfdHK3X2GwUwCu91ZYIphxaJQcwFaLy0IhIoJRUuIfgWfP4RrUG6pfWx3aq3LaiS8lSMAiblvUJJT2ZfpAatTw5x7d+AYiP94xECwW50qrv+r4nm0lhS97USa34dAHsYN3LrehjU1ABaebbknXIDWx1iY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262656; c=relaxed/simple;
	bh=wWvKEPrrqOD/8I9pWLgczrqKjQ2cX5d0ZIPWRhhZhqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvzZCpZxEk/AQz1qX8FF0wwCA96QIYZ8Wc0yR5F0KVPUVJpFXx7RS4rvwkN+Q1d4He/1W5U6fXCQXlkfPMoLPFO9gOAMjL7V0VDoF0lIy1bPjnEiFFb0IaIJk1N3arlAUqUVcspct84a+rdWUnrflHhj/GcJh8FC5Y/ffjTFCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiwPK8OR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775262654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfQxVxcMjauUXCJ+0k8+KZnxQpiifo9CFqeX4zdZSXA=;
	b=JiwPK8ORlS5NI5DGjkDDbaOrSy5rsuVhL/nXmtMr9Tty2JXWddnPO8bb7bxt1NFIt47aZq
	zejHAcNIVjDNcLY879y/A6xAGVDgcWLD5Xd7RWEFa9sjd+7IlvPRmg51/xZy0P7mfm8yIM
	S08wswawsl5aNKHGqveT+DR4J4t2Y7s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-aw3Z0PGKOW6OjM-bK2c4NA-1; Fri,
 03 Apr 2026 20:30:53 -0400
X-MC-Unique: aw3Z0PGKOW6OjM-bK2c4NA-1
X-Mimecast-MFC-AGG-ID: aw3Z0PGKOW6OjM-bK2c4NA_1775262652
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AD0C18002FD;
	Sat,  4 Apr 2026 00:30:52 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15DD01955D84;
	Sat,  4 Apr 2026 00:30:52 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 059A9749EAE;
	Fri, 03 Apr 2026 20:30:51 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/5] pynfs: _testCbGetattr() should check the delegation that was received
Date: Fri,  3 Apr 2026 20:30:48 -0400
Message-ID: <20260404003050.1560149-4-smayhew@redhat.com>
In-Reply-To: <20260404003050.1560149-1-smayhew@redhat.com>
References: <20260404003050.1560149-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20641-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF349399552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It currently assumes that if it requested an attribute delegation, then
that's what it received.  Better to actually check it instead.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 nfs4.1/server41tests/st_delegation.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index 934e558..754b56c 100644
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


