Return-Path: <linux-nfs+bounces-22977-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NANXB6rmR2pXhQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22977-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 18:43:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F407045E0
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 18:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=C0LD++7Q;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22977-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22977-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1DD83048F3C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D682E2DF2;
	Fri,  3 Jul 2026 16:40:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBC3090C5
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 16:39:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096800; cv=none; b=k3k0xsVUR1QwKjT0h+liPPYhGQqzkOdWDRdutosMmHVAOmcTiLYtaDA21PuqBm+2My8bykK0e80vhcKd9VtMiWYAP7y7ci9Lakep57yUdliSUjd0WE93AmDw0648s7dg+QNJUQeLs8Rc9wGw6Hm92Ivp+JFrrEnu+DWds6TWnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096800; c=relaxed/simple;
	bh=6OTf5w/v9YBNOiEnhDQBwwEjnKh123TDNq4u+xakj+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IB+Zp3M/UNlSWrWhMgZ7k9DRswEJpy409L/MnlLAk+XGoh5AX3zrDpiWkex2Y7li054QG7Pl45XVLzslSk1JDrcVzFBtg9rtM8LGxgLbeMwpX+6uUGcnWFY8mfvZi16YVi1BU9drcSWkL+5gfc3b+iRGp3xYmPlUoLVkqNHb380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0LD++7Q; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783096798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Yr5Dc+PW05yp0dNGtbvFKSqrttocjaOlg/5pRrTy+Y=;
	b=C0LD++7QsbzZAr2H5qZcN9+lP03FUBgUYdrmzPUp9dFLJv7RHSL5e8ReTZ5UARE9a7S4lz
	FftdtE6M6ouTjBUMAOqxSfjP05BG6EKDNiBvpeOhRxvfC+o+6OJueQXkEVFBGMKUKXfjDX
	DgEHzOJe0tHGiaxn59UknCQn3CjPW9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-GJMc9628NJy2S88qNgFJRw-1; Fri,
 03 Jul 2026 12:39:55 -0400
X-MC-Unique: GJMc9628NJy2S88qNgFJRw-1
X-Mimecast-MFC-AGG-ID: GJMc9628NJy2S88qNgFJRw_1783096795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 074001863B25
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 16:39:55 +0000 (UTC)
Received: from tbecker-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD7911800846;
	Fri,  3 Jul 2026 16:39:53 +0000 (UTC)
From: tbecker@redhat.com
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	Thiago Becker <tbecker@redhat.com>
Subject: [PATCH 2/2] rpc.gssd: Call pthread_attr_destroy before returning from start_upcall_thread
Date: Fri,  3 Jul 2026 13:39:45 -0300
Message-ID: <20260703163946.2185163-3-tbecker@redhat.com>
In-Reply-To: <20260703163946.2185163-1-tbecker@redhat.com>
References: <20260703163946.2185163-1-tbecker@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22977-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:steved@redhat.com,m:tbecker@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tbecker@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tbecker@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77F407045E0

From: Thiago Becker <tbecker@redhat.com>

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 utils/gssd/gssd_proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 27b6fe4f..d59c8a19 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -984,6 +984,7 @@ start_upcall_thread(void (*func)(struct clnt_upcall_info *), struct clnt_upcall_
 	tinfo->timeout.tv_sec += upcall_timeout;
 	TAILQ_INSERT_TAIL(&active_thread_list, tinfo, list);
 	pthread_mutex_unlock(&active_thread_list_lock);
+	pthread_attr_destroy(&attr);
 
 	return ret;
 }
-- 
2.54.0


