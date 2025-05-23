Return-Path: <linux-nfs+bounces-11869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CEEAC1DCC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B14E58E8
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452220F080;
	Fri, 23 May 2025 07:41:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE51A76BB
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986087; cv=none; b=bOhQRGWZy2x7BQybIG8NMz4TRsY67n6FineYoFRMU6iz2V5nhghQfiHEee1BXzSF+o8gvy/0hG4gXAMUwaCwVZKKjrkHXJ7L9omJu93FZXOcoXBGvPSydqueFTOG1xXP11vRhRZ6KN85bVhMajDN34MicuXzvEpAt7JEeqhCBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986087; c=relaxed/simple;
	bh=iWeQipN8jAlZKyMVzxLiWLJ78fqNYLNcRmwYxy7z574=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=mv5OMJmZc3dTvo/i/N3ym9RsrMxoMTeWBfKYM6BH5/K0VHY3VWcX0iYmA1o3XcZQ0tW4dLDbrJ05VJfoJW1mrJfKLdEVtAsebtS8Q1cHyU488Y67dg9/Pa/q0/TP8l2vC230SFR2KCr5w5tJz4IpZYICK9O1THyTl6xDWl+vlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uIN1r-008s8R-Lt;
	Fri, 23 May 2025 07:41:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: openembedded-core@lists.openembedded.org
Cc: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH OE-core] nfs-utils: don't use signals to shut down nfs server.
Date: Fri, 23 May 2025 17:41:19 +1000
Message-id: <174798607948.608730.16248811831567380472@noble.neil.brown.name>


Since Linux v2.4 it has been possible to stop all NFS server by running

   rpc.nfsd 0

i.e.  by requesting that zero threads be running.  This is preferred as
it doesn't risk killing some other process which happens to be called
"nfsd".

Since Linux v6.6 - and other stable kernels to which

  Commit: 390390240145 ("nfsd: don't allow nfsd threads to be
  signalled.")

has been backported - sending a signal no longer works to stop nfs server
threads.

This patch changes the nfsserver script to use "rpc.nfsd 0" to stop
server threads.

Signed-off-by: NeilBrown <neil@brown.name>
---
 .../nfs-utils/nfs-utils/nfsserver             | 28 +++----------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver b/meta/r=
ecipes-connectivity/nfs-utils/nfs-utils/nfsserver
index cb6c1b4d08d8..99ec280b3594 100644
--- a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
+++ b/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
@@ -89,34 +89,14 @@ start_nfsd(){
 	start-stop-daemon --start --exec "$NFS_NFSD" -- "$@"
 	echo done
 }
-delay_nfsd(){
-	for delay in 0 1 2 3 4 5 6 7 8 9=20
-	do
-		if pidof nfsd >/dev/null
-		then
-			echo -n .
-			sleep 1
-		else
-			return 0
-		fi
-	done
-	return 1
-}
 stop_nfsd(){
-	# WARNING: this kills any process with the executable
-	# name 'nfsd'.
 	echo -n 'stopping nfsd: '
-	start-stop-daemon --stop --quiet --signal 1 --name nfsd
-	if delay_nfsd || {
-		echo failed
-		echo ' using signal 9: '
-		start-stop-daemon --stop --quiet --signal 9 --name nfsd
-		delay_nfsd
-	}
+	$NFS_NFSD 0
+	if pidof nfsd
 	then
-		echo done
-	else
 		echo failed
+	else
+		echo done
 	fi
 }
=20
--=20
2.49.0


