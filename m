Return-Path: <linux-nfs+bounces-23154-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HdibMVpoTWrmzQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23154-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:58:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8A71FA90
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 22:58:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NrpNBPbV;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23154-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23154-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF253024117
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8A30D3EA;
	Tue,  7 Jul 2026 20:58:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE830B529
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 20:57:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783457880; cv=none; b=XnhnrcXOxDwhnZimFsl5Ruv7hqURM6kXkdEr/JPxB5CpjSfD/T2F+ZXIq6aa1HrTOUmA/Acbd8zHLoiX8pZI1TGdA9dyAZh73OMDhbWkGu2WRqa3oIMDS/QUzKCxGTIcFKT8UijHq2MsgRXOvbSnED99psbM4+fkpAcEGmXMnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783457880; c=relaxed/simple;
	bh=weVIrS/3y6NVo4sMV5WWcLapx58lwTamW2cF/2D5omo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYFcAj7sXVIPhT0wXgrUyVGrNlKZLKyGMhYv/VYkVIPX+22n6SwAXEUHK72qDZ42H3OML5ai56XZlAsF03w/gzz1c9gH0y55IQEry1U8gYkBQP7xI0Yal0AivJqcnc18qOs+uHnGWIr4ZJ0fG087WtGBQb7vsV5IEQyAC8o/nEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrpNBPbV; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783457877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/cXec0UB8SxJ0NoWCaBSkg0GuT85+NTisCBVanuLuY4=;
	b=NrpNBPbVNB+7zOQQpAKaB8Dx/bsStlWN59qv7TaIkHS3tGExa/YntsiJCn8hqrhi2LKNDO
	gvB0wutuR+GbjDVdGYPasvQFqCmTXw9l8rqjYXXJPCzBRkyyX2gfsyJc7b3SlLCS2DGXHk
	gA2cyJl2LnhBoIVLzVvVjR/YHvsQteY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-VxW-0TzJMhmt9Q47TyVRHQ-1; Tue,
 07 Jul 2026 16:57:54 -0400
X-MC-Unique: VxW-0TzJMhmt9Q47TyVRHQ-1
X-Mimecast-MFC-AGG-ID: VxW-0TzJMhmt9Q47TyVRHQ_1783457873
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8BFF1955DAF;
	Tue,  7 Jul 2026 20:57:53 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (unknown [10.22.80.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8430A1955D88;
	Tue,  7 Jul 2026 20:57:53 +0000 (UTC)
Received: from smayhew-thinkpadp1gen4i.remote.csb (localhost [IPv6:::1])
	by smayhew-thinkpadp1gen4i.remote.csb (Postfix) with ESMTP id D85F44D4C113;
	Tue, 07 Jul 2026 16:57:52 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 0/3] mountd netlink fixes
Date: Tue,  7 Jul 2026 16:57:49 -0400
Message-ID: <20260707205752.313031-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:steved@redhat.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23154-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,configure.ac:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9E8A71FA90

A handful of fixes for some issues I ran into on Fedora Rawhide.

Scott Mayhew (3):
  configure: update check of system netlink headers
  nfs.conf: add no-netlink option to exportd and mountd stanzas
  mountd/exportd: disable netlink when falling back to /proc

 configure.ac                 | 4 ++--
 nfs.conf                     | 3 +++
 support/export/cache.c       | 7 +++++++
 support/export/cache_flush.c | 1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.55.0


