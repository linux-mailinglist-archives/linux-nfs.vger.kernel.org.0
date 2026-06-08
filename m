Return-Path: <linux-nfs+bounces-22348-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bmEECknCJmp0kAIAu9opvQ
	(envelope-from <linux-nfs+bounces-22348-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 15:23:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F965696A
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 15:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=L839VF9G;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22348-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22348-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AB3030A0453
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30F33D6F0;
	Mon,  8 Jun 2026 13:13:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835925B08C
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 13:13:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924437; cv=none; b=hWyMcEAd3Har79RuEG7HfIEzbRuU0PK7ZwXgvGfDD8BVUe3RlAC+90evlZoGVidztRDmXMMOzn8p0ApUxOFnv+OLTLqbJsZW9uqogdg0a0Sd85uU+mtrq+gfpFCkVB/NW0Thfv85gwzNKbQL2GW6FlnYn613/2dwZDdjWSsDaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924437; c=relaxed/simple;
	bh=0DjFNWgbLBeE5DTot4hLhaRt6SjvteFihkgnFXemGCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/gKdjFZ1MRdU5CmANfCqA/agfZricw586Hxo/kmE2nEbEftu/W92Ezq8cfH2qK648yG4A3N9nNPUNZ4wyEEQygW2/m1TIHzcuQNmN4VN0lTwUbJCOcAF0DMS8rz498wSWDtsQe6hqcgsLk5RnfAhnmWPZNCn2f8rCG5hMbTt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L839VF9G; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780924435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PYsZ3TeTpUzj3/zZ915TwI1ffcL83lnScvv76rJmJdk=;
	b=L839VF9GPed9b5f/NCAtOQ/CNuJQB/mSmupitI4jZRQTVxbQkgA6apin8waCj8q8kx2z4x
	xfLKUzyC+HlfZ7Nb1dvPY2vTtowDk0A6hurdphXnXT8CO/1EX1t2Q9JpWmZ2X06nEu7xo7
	v/noy06hIrnQa42HzyQh/MrO3/EOafE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-9DMZgr-4PfaBc5NFgSEF2Q-1; Mon,
 08 Jun 2026 09:13:53 -0400
X-MC-Unique: 9DMZgr-4PfaBc5NFgSEF2Q-1
X-Mimecast-MFC-AGG-ID: 9DMZgr-4PfaBc5NFgSEF2Q_1780924432
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E2311800BD2
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 13:13:52 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B2FB19560A3;
	Mon,  8 Jun 2026 13:13:52 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 22BDD918329;
	Mon, 08 Jun 2026 09:13:51 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] nfsd: don't assume service is running when setting thread count to 0
Date: Mon,  8 Jun 2026 09:13:51 -0400
Message-ID: <20260608131351.95211-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:steved@redhat.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22348-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 634F965696A

Newer kernels return -EIO if you try to write to /proc/fs/nfsd/threads
and there are no active listeners.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsd/nfsd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index 365e145d..c95d32f4 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -311,12 +311,16 @@ main(int argc, char **argv)
 				argv[0], count);
 			count = 1;
 		} else if (count == 0) {
-			/*
-			 * don't bother setting anything else if the threads
-			 * are coming down anyway.
-			 */
-			socket_up = 1;
-			goto set_threads;
+			if (nfssvc_inuse()) {
+				/*
+				 * don't bother setting anything else if the threads
+				 * are coming down anyway.
+				 */
+				socket_up = 1;
+				goto set_threads;
+			} else {
+				goto out;
+			}
 		}
 	}
 
-- 
2.54.0


