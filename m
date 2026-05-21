Return-Path: <linux-nfs+bounces-21775-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KItSJ0+cD2qCNwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21775-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:59:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5645AD2A1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B111C30CCDAE
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 23:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FCB37D13C;
	Thu, 21 May 2026 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4NpTem2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0137E31D
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407254; cv=none; b=VnCtj8+JOPQRhDIWs+NHxQOrMufZQQVDTOUtsdNuoDXKcobz5XzqL54Gvp8pewmENtqjH90m00lN4s/1YKbc4FqcwSrBfOFD5XIbIjoPHSeLMUp9yXy3m/XoEvHdDUyJLm+njcWhUe9YPT0arpr2kU8kKtdRMXBiwmBR0sRMu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407254; c=relaxed/simple;
	bh=egfRbE1rrfPBDhKTeY3NWt81ocUvBovus2o8275DUzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIu0xLLUeVBMMSd0lklVupX00uFF74youi2/SLQWo2409YjC4ctVYGA5XPfVunrXYhIJlG1y4byuUMWMMePMS+ltHnMVENuk9TM8YOz2Q/23d45ApNYPRkvKy1M+de4y38Vn3cntkiohygFIirYWQ6HB311hxasK6OwFkGQ7lgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4NpTem2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779407244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j3Ccf8lLXXmCuylMQ28G9wExr+ZLuciF+leAch/R3c0=;
	b=S4NpTem22Mrm9w3ntF2ji54nrThRr9Nift7wLM/UjVe/+/W8qwaORROhxI8hdy9tKXiClP
	CbLqiYPJj/nkFDD/sFt+uVaXRsLHiZiXw74ApucPPc7TBEyhlNrJiSjTPdGs5pOW30HyIH
	8v7d8oFqDbgjOd043g8YadU33WqS+NY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-b5Y7WF87N_-TblZX9ZkdDQ-1; Thu,
 21 May 2026 19:47:21 -0400
X-MC-Unique: b5Y7WF87N_-TblZX9ZkdDQ-1
X-Mimecast-MFC-AGG-ID: b5Y7WF87N_-TblZX9ZkdDQ_1779407241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34B8419560B2
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 001411800591;
	Thu, 21 May 2026 23:47:20 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 271048A8681;
	Thu, 21 May 2026 19:47:20 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] rpcbind: fix a few memory leaks
Date: Thu, 21 May 2026 19:47:17 -0400
Message-ID: <20260521234720.818996-1-smayhew@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-21775-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E5645AD2A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a handful of leaks reported by valgrind.

Scott Mayhew (3):
  rpcbind: fix memory leak in init_transport()
  rpcbind: fix memory leaks in network_init()
  rpcbind: fix memory leak in read_warmstart()

 src/rpcbind.c   | 4 ++++
 src/util.c      | 3 +++
 src/warmstart.c | 3 +++
 3 files changed, 10 insertions(+)

-- 
2.54.0


