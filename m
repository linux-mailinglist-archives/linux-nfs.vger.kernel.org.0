Return-Path: <linux-nfs+bounces-12602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2023EAE2684
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 01:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902F45A3EB0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9582417C3;
	Fri, 20 Jun 2025 23:39:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46430E844
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462752; cv=none; b=WckP+FNr7mQeHW4hul7fCbdxFIhMCOF8ARXqgFZP1i/JYPvUCS6g1WouEpL8iXjIq51jCMWDTDZdoNPZBrkXev2onUoOSphf0QEVWlInJGUPWseGt11JH/1PV205G32KNweVYl5SuPIrIA47uyhKo87K2FUjHpT4oJ/ZBfRLltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462752; c=relaxed/simple;
	bh=JGhi8IumXL09MwKa6/j6LyHt/7/tbeaYnk1eY93yWW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9ZkGE8+ukNDfnytrK+prin/Vr8b922DP/03kFGFIThPbuhRzkmUQ23/D4X0jmA22z0Sb3+6N+pxRANTRv21I8JdBK94gSUNs/jBp7stiRZLZ+aox1gnuChqbe0PssYDb20DoppVHQR6fuW+0hCDjcz19UJyQhWIYcxMA0pimyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uSlJy-0023qJ-VA;
	Fri, 20 Jun 2025 23:38:58 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 1/3] nfsd: provide proper locking for all write_ function
Date: Sat, 21 Jun 2025 09:33:24 +1000
Message-ID: <20250620233802.1453016-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620233802.1453016-1-neil@brown.name>
References: <20250620233802.1453016-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_foo functions are called to handle IO to files in /proc/fs/nfsd/.
They can be called at any time and so generally need locking to ensure
they don't happen at an awkward time.

Many already take nfsd_mutex and check if nfsd_serv has been set.  This
ensures they only run when the server is fully configured.

write_filehandle() does *not* need locking.  It interacts with the
export table which is set up when the netns is set up, so it is always
valid and it has its own locking.  write_filehandle() is needed before
the nfs server is started so checking nfsd_serv would be wrong.

The remaining files which do not have any locking are
write_v4_end_grace(), write_unlock_ip(), and write_unlock_fs().
None of these make sense when the nfs server is not running and there is
evidence that write_v4_end_grace() can race with ->client_tracking_op
setup/shutdown and cause problems.

This patch adds locking to these three and ensures the "unlock"
functions abort if ->nfsd_serv is not set.  It uses
    guard(mutex)(&nfsd_mutex);
so there is no need to ensure we unlock on every patch.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsctl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..0e7e89dc730b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -221,6 +221,12 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	size_t salen = sizeof(address);
 	char *fo_path;
 	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	guard(mutex)(&nfsd_mutex);
+	if (!nn->nfsd_serv)
+		/* There cannot be any files to unlock */
+		return -EINVAL;
 
 	/* sanity check */
 	if (size == 0)
@@ -259,6 +265,12 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	struct path path;
 	char *fo_path;
 	int error;
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+
+	guard(mutex)(&nfsd_mutex);
+	if (!nn->nfsd_serv)
+		/* There cannot be any files to unlock */
+		return -EINVAL;
 
 	/* sanity check */
 	if (size == 0)
@@ -1053,6 +1065,7 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 }
 #endif
 
+
 /*
  * write_v4_end_grace - release grace period for nfsd's v4.x lock manager
  *
@@ -1077,6 +1090,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 {
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
+	guard(mutex)(&nfsd_mutex);
 	if (size > 0) {
 		switch(buf[0]) {
 		case 'Y':
-- 
2.49.0


