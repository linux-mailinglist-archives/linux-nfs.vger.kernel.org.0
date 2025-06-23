Return-Path: <linux-nfs+bounces-12620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77793AE33D4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CF516D677
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331DE3D984;
	Mon, 23 Jun 2025 03:00:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5A1F941
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647645; cv=none; b=Qxz1/Aj1e5Eq9J8smT+3onVdkMnzradLI/lgHN/DLBP0GE9vLbBCICmrp0Hz5A/tkBBSO/OcpSaQxzxf6bXZnvA9mgej8VqaVQAnm+oT/smOtoci2pl7uVzH0aVYeTp0jXll5KMAapt+WZozylRos4Nxamx3Cfbfvta01utGgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647645; c=relaxed/simple;
	bh=IXGLT2C5hwXTVV5/qbb3VgEqLRWoGDepXd9m/Tl98DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiY8AICjeyyB0vHPgHQQnIY5dtTyLSiDQ0utyHbo1o+dpRE2itCRksCGM1jVDCzytOrJISf9U5dSwQEV5mvJR3PExD6bLKoalMWtNFyD0PzOaxh5c2J3pr5wiy8u9jX1ovWjNib58e6eUbM+vnL7GZF8wYUAyJxJO2Bcm0cdRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTXQE-0036aP-0v;
	Mon, 23 Jun 2025 03:00:38 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 1/4] nfsd: provide proper locking for all write_ function
Date: Mon, 23 Jun 2025 12:47:13 +1000
Message-ID: <20250623030015.2353515-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623030015.2353515-1-neil@brown.name>
References: <20250623030015.2353515-1-neil@brown.name>
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
functions abort if ->nfsd_serv is not set.

Reported-and-tested-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsctl.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..6b0cad81b5fa 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -214,13 +214,18 @@ static inline struct net *netns(struct file *file)
  *			returns one if one or more locks were not released
  *	On error:	return code is negative errno value
  */
-static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
+static ssize_t __write_unlock_ip(struct file *file, char *buf, size_t size)
 {
 	struct sockaddr_storage address;
 	struct sockaddr *sap = (struct sockaddr *)&address;
 	size_t salen = sizeof(address);
 	char *fo_path;
 	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	if (!nn->nfsd_serv)
+		/* There cannot be any files to unlock */
+		return -EINVAL;
 
 	/* sanity check */
 	if (size == 0)
@@ -240,6 +245,16 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	return nlmsvc_unlock_all_by_ip(sap);
 }
 
+static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
+{
+	ssize_t ret;
+
+	mutex_lock(&nfsd_mutex);
+	ret = __write_unlock_ip(file, buf, size);
+	mutex_unlock(&nfsd_mutex);
+	return ret;
+}
+
 /*
  * write_unlock_fs - Release all locks on a local file system
  *
@@ -254,11 +269,16 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
  *			returns one if one or more locks were not released
  *	On error:	return code is negative errno value
  */
-static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
+static ssize_t __write_unlock_fs(struct file *file, char *buf, size_t size)
 {
 	struct path path;
 	char *fo_path;
 	int error;
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+
+	if (!nn->nfsd_serv)
+		/* There cannot be any files to unlock */
+		return -EINVAL;
 
 	/* sanity check */
 	if (size == 0)
@@ -291,6 +311,16 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	return error;
 }
 
+static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
+{
+	ssize_t ret;
+
+	mutex_lock(&nfsd_mutex);
+	ret = __write_unlock_fs(file, buf, size);
+	mutex_unlock(&nfsd_mutex);
+	return ret;
+}
+
 /*
  * write_filehandle - Get a variable-length NFS file handle by path
  *
@@ -1082,10 +1112,14 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 		case 'Y':
 		case 'y':
 		case '1':
-			if (!nn->nfsd_serv)
+			mutex_lock(&nfsd_mutex);
+			if (!nn->nfsd_serv) {
+				mutex_unlock(&nfsd_mutex);
 				return -EBUSY;
+			}
 			trace_nfsd_end_grace(netns(file));
 			nfsd4_end_grace(nn);
+			mutex_unlock(&nfsd_mutex);
 			break;
 		default:
 			return -EINVAL;
-- 
2.49.0


