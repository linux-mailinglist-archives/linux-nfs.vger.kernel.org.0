Return-Path: <linux-nfs+bounces-22893-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9AcTB6DsQ2qHlgoAu9opvQ
	(envelope-from <linux-nfs+bounces-22893-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 18:19:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE3F6E65E6
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 18:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hBxfrmlf;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22893-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22893-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA24D300C02F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406D2416CFD;
	Tue, 30 Jun 2026 16:14:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48E2FD69D
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 16:14:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836047; cv=none; b=Es6YGfBZvUhMQiAazpifp/T/O3d6RiivGn/PHRjpNxZwuVNNGRzWKnYAe2lTsX0PcYPkKsgwzhoCQwhz3FkINJPX+JKrxbJj/FpwLVP/CB65N578cdKLfsSTxmiFhfKtnCbYq2ndmwvixtV6gz1p3kgTNVbQQ4xjQXaTWv24j9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836047; c=relaxed/simple;
	bh=3NN3UmyWPGY82p4vLqoXAMsjXGHpDgdsqmksosVKgY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9F4lfhdEllBxyaqjMO/M7JlN5O501C5H0DjP8T2uTTXbilzO17rKWKnqT00F9lDQVpitftnxoYnnmOh031sy9mU69rWXFXZACg8aU4E0UkLp2foHXs+G1/TJ0hvl7bOi4TXrDs6rzWAsomSnMMxvkMcf3r0G9rI4kQgwKwkXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBxfrmlf; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782836044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7MsnXiGcuuRbYD8OmGvhNbc0G4MGkQju+EXuR3l+7Dg=;
	b=hBxfrmlfB2cz0HHICXd9X7tSOvRawIBsOKZ/cq0dW2wcri23csU1g4HJOtMco+L6GV/qfc
	p3+fDjwqA4smyhCHhMyOLWnptg2nAxukzLQ5ZjDSgTFA2x1wuz7aluK4891zqIA64V97J9
	3+NWf7ZjYFsr5jksSRe6WBIZygUsTGc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-emQDw5iWPNynohtfLCuEyw-1; Tue,
 30 Jun 2026 12:14:03 -0400
X-MC-Unique: emQDw5iWPNynohtfLCuEyw-1
X-Mimecast-MFC-AGG-ID: emQDw5iWPNynohtfLCuEyw_1782836042
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BD87180131C
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 16:14:02 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.65.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47A131800747;
	Tue, 30 Jun 2026 16:14:02 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (localhost [IPv6:::1])
	by smayhew-thinkpadp1gen4i.remote.csb (Postfix) with ESMTP id 81DB84C698DF;
	Tue, 30 Jun 2026 12:14:01 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] rpcbind: fix leak of nconf in main()
Date: Tue, 30 Jun 2026 12:13:58 -0400
Message-ID: <20260630161358.133351-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22893-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steved@redhat.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EE3F6E65E6

Before reusing nconf in the getnetconfig() loop, we need to free the
memory that was previously allocated via getnetconfigent().  Fixes the
following leak reported by valgrind:

==9031== 1,136 (136 direct, 1,000 indirect) bytes in 1 blocks are definitely lost in loss record 63 of 67
==9031==    at 0x485183E: malloc (vg_replace_malloc.c:447)
==9031==    by 0x4879D1F: getnetconfigent (in /usr/lib64/libtirpc.so.3.0.0)
==9031==    by 0x4004336: main (rpcbind.c:271)

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 src/rpcbind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/rpcbind.c b/src/rpcbind.c
index 4212377..c39df97 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -282,6 +282,7 @@ main(int argc, char *argv[])
 	rpc_control(RPC_SVC_CONNMAXREC_SET, &maxrec);
 
 	init_transport(nconf);
+	freenetconfigent(nconf);
 
 	while ((nconf = getnetconfig(nc_handle))) {
 		if (nconf->nc_flag & NC_VISIBLE)
-- 
2.54.0


