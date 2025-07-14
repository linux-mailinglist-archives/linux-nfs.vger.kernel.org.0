Return-Path: <linux-nfs+bounces-13022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A145EB03512
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05141898692
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED551DDA34;
	Mon, 14 Jul 2025 03:56:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3426DDC5
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752465377; cv=none; b=GhYEQw96iBesMti9m/t58tvjbh8am5CPKtUBUt7nWr2G5Qhi9Z7O6bOVI3Pp6Jxl6qylVc68ROT4JQYJphHDJ8TVtsEinLsqXPs98rNcsy7/3ZoIbRRyVNH8dCbR9KXPBiw+CxWDid7+a3f+m8Ao4wbc26AAyP2EV2H4+B087Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752465377; c=relaxed/simple;
	bh=NGrjx84HzvBnO7zcdXgaJyYVPs9sFknPcrdQnupbCQc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=WZog6kJUUSWWJrgtf74BOl0TpMPxCWc7bZrAQ520+7PSdBlin+F4GGrxKcrOlzIhx/J934D4Ho9YR5923vh5b0EIhTzax7q6V1j9inQy71sU2cmGuggHwdn9OVk9mSOwjHuh5WMzxQJdnqitPO5PuU7jCaqRGyNiOz4w8oQ5mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubAIV-001wbt-Hq;
	Mon, 14 Jul 2025 03:56:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
 Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: [PATCH] nfslocalio: use correct wait address in nfs_uuid_put()
Date: Mon, 14 Jul 2025 13:56:13 +1000
Message-id: <175246537302.2234665.6977010546892567896@noble.neil.brown.name>


This wait_var_event_spinlock() in nfs_uuid_put() is waiting for the
wakeup signalled at the end of nfs_close_local_fh().  That
wake_up_var_locked() uses &nfl->nfs_uuid, so the waiter must use the
same address, else nfs_uuid_put() could wait indefinitely causing
various problems.

Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nf=
s_close_local_fh()")
Reported-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs_common/nfslocalio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 05c7c16e37ab..bc8dcfb256a3 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -177,7 +177,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			/* nfs_close_local_fh() is doing the
 			 * close and we must wait. until it unlinks
 			 */
-			wait_var_event_spinlock(nfl,
+			wait_var_event_spinlock(&nfl->nfs_uuid,
 						list_first_entry_or_null(
 							&nfs_uuid->files,
 							struct nfs_file_localio,
--=20
2.49.0


