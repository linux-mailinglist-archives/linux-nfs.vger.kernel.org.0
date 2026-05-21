Return-Path: <linux-nfs+bounces-21776-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPgVBVSbD2qCNwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21776-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:55:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF345AD22B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB8D430CD1A3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189E37E2E4;
	Thu, 21 May 2026 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUvP+dMs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8DF384CD1
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407255; cv=none; b=OdNsj964GbFp7GPGoSfVAg8zcWONUcUH/DtgyBK1iaiNKWf37auJWDNsqWjUURX3s7C4EwtAHyQhRVnNsqI1hlgL3wDfZCPZVLhB3y/SCpV9plfNA64Hl1WhcpkXOgPsUZ/IxuXCIFhx9Mz/Z+Nsepy/fu+3MAjr+DoJ+psca0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407255; c=relaxed/simple;
	bh=Zsfns5yageqa2hRtQ0s9ipO/g+wqPK5ms74nhsLgcDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuCf1+alY3ie9qHjYXuLBzaO0cZSRMkRc8O3PS4RVx9948mFwvLPmgHvRUUC517ewbFbFo+IwHA4gKSfrZWqp2TL8p4R9UEZHzTmvQpW8o/6Vym3WwfvnYoznBx2grKRP9hDU5FFRbIqruR1dZ46NqKkDjsptT6mpP1rdGnexkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUvP+dMs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779407245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yns77acNqewMqJg3IM0H00/6G4bWEPzaTzbRwpBkVac=;
	b=WUvP+dMsjluyD0YenyuZXMsw3RzF41PkyYIqPj6xOWMDow6W5FW/C4JIUA2rY1qnoAbb7Q
	0Wqp39YsV2tvjchOUvBjKtur9kiUk5Ei8RtyOwGggTjCXbnFF/9JqXOshz5p41ZG1Hq3FG
	co/MmsgVYx4TaHTJ4aU+802BxKJ+HCU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-KLHqH12ON6u572VDbxc1jQ-1; Thu,
 21 May 2026 19:47:22 -0400
X-MC-Unique: KLHqH12ON6u572VDbxc1jQ-1
X-Mimecast-MFC-AGG-ID: KLHqH12ON6u572VDbxc1jQ_1779407241
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D42A1956089
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04F2E1956053;
	Thu, 21 May 2026 23:47:21 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 344B88A8682;
	Thu, 21 May 2026 19:47:20 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] rpcbind: fix memory leak in init_transport()
Date: Thu, 21 May 2026 19:47:18 -0400
Message-ID: <20260521234720.818996-2-smayhew@redhat.com>
In-Reply-To: <20260521234720.818996-1-smayhew@redhat.com>
References: <20260521234720.818996-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21776-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7FF345AD22B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once a service registration has been added to list_rbl via
rbllist_add(), we no longer need the value stored in taddr.addr.buf.
Free it before we leave init_transport().  Fixes memory leaks such as:

==8754== 19 bytes in 1 blocks are definitely lost in loss record 28 of 93
==8754==    at 0x484C826: malloc (vg_replace_malloc.c:447)
==8754==    by 0x40AAD3: init_transport.isra.0 (rpcbind.c:726)
==8754==    by 0x405CB8: main (rpcbind.c:284)

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 src/rpcbind.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/rpcbind.c b/src/rpcbind.c
index bf7b499..4212377 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -893,10 +893,14 @@ got_socket:
 
 	if (res != NULL)
 		freeaddrinfo(res);
+	if (taddr.addr.buf != NULL)
+		free(taddr.addr.buf);
 	return (0);
 error:
 	if (res != NULL)
 		freeaddrinfo(res);
+	if (taddr.addr.buf != NULL)
+		free(taddr.addr.buf);
 	close(fd);
 	return (1);
 }
-- 
2.54.0


