Return-Path: <linux-nfs+bounces-13790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123CDB2CEA5
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 23:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16BB5803FF
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEAD23B615;
	Tue, 19 Aug 2025 21:39:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069B2EB85C
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639540; cv=none; b=bv31HJO4MKki6G4GuLQbeBsziBGheJD6uLo9uGVeg0NKGclIzcECsREiOb8qNv+c2B70KkQcUYR90xgDvgSITRGl/Lxn9rbTJZyeLcpddk40g6FFuhhkVJezP5EyLJ2fJ+0GY2mHiQ61Bu81O04I9CICd9MsgnJNIlcDf57Dn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639540; c=relaxed/simple;
	bh=HqAFVkWsN1eidcsiHn8AW0Kbic+sZp9PTe1dmarNeKk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=ol766qiWJh9RgE8DWFmQ1wHeFhppvp7W/81wgJtvMNwNdsRYgNdl4pi+JJIKBbl3hRmYjoj2g/Irdpmf8Utx/BKClZGseCU2r1WlojecpSTGqncJ6pn9Iqctc3oazSBEyBZ4dvdyzmhWuC4kvo9Lsfd4rXB+U7D3GknDb4QtmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uoU2Y-006N69-Lz;
	Tue, 19 Aug 2025 21:38:48 +0000
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
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
 Mark Brown <broonie@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: don't fail immediately in rpc_wait_bit_killable()
Date: Wed, 20 Aug 2025 07:38:47 +1000
Message-id: <175563952741.2234665.2783395172093985961@noble.neil.brown.name>


rpc_wait_bit_killable() is called when it is appropriate for a fatal
signal to abort the wait.

If it is called late during process exit after exit_signals() is called
(and when PF_EXITING is set), it cannot receive a fatal signal so
waiting indefinitely is not safe.

However aborting immediately, as it currently does, is not ideal as it
mean that the related NFS request cannot succeed, even if the network
and server are working properly.

One of the causes of filesystem IO when PF_EXITING is set is
acct_process() which may access the process accounting file.  For a
NFS-root configuration, this can be accessed over NFS.

In this configuration LTP test "acct02" fails.

Though waiting indefinitely is not appropriate, aborting immediately is
also not desirable.  This patch aims for a middle ground of waiting at
most 5 seconds.  This should be enough when NFS service is working, but
not so much as to delay process exit excessively when NFS service is not
functioning.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-and-tested-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Link: https://lore.kernel.org/linux-nfs/7d4d57b0-39a3-49f1-8ada-60364743e3b4@=
sirena.org.uk/
Fixes: 14e41b16e8cb ("SUNRPC: Don't allow waiting for exiting tasks")
Signed-off-by: NeilBrown <neil@brown.name>
---
 net/sunrpc/sched.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 73bc39281ef5..92f39e828fbe 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -276,11 +276,15 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
=20
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	if (unlikely(current->flags & PF_EXITING))
-		return -EINTR;
-	schedule();
-	if (signal_pending_state(mode, current))
-		return -ERESTARTSYS;
+	if (unlikely(current->flags & PF_EXITING)) {
+		/* Cannot be killed by a signal, so don't wait indefinitely */
+		if (schedule_timeout(5 * HZ) =3D=3D 0)
+			return -EINTR;
+	} else {
+		schedule();
+		if (signal_pending_state(mode, current))
+			return -ERESTARTSYS;
+	}
 	return 0;
 }
=20
--=20
2.50.0.107.gf914562f5916.dirty


