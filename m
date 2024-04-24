Return-Path: <linux-nfs+bounces-2981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B438A8B0795
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2BA1C2302D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Apr 2024 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8A91428F9;
	Wed, 24 Apr 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Zsw7YpMD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72F1598EC
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955357; cv=none; b=hbVze8dsHe4+nre8ClVQPiGaSg8B0oSnaqBjUtXKjQtWpNBOrR9vWiqV3sHhYZsQtszHYA0qD1VwQvg4HgtVa/Yebhz1RmxYdo0t+M4cYNuuoCEuwr+1vuf+wQXAuBoUHxXA2JNQ0cREFoDst21A/fLeiMJXYWsKiO5/mS30js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955357; c=relaxed/simple;
	bh=E+PxfHVWGnXN3PvLMj2IPQkgGHbi6RwJRPrI2INgD+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcCV3dWk+BfVVJpBQbN8Re7QSpdXNb4fCA3sFu7gvD77NWc3qqdTOv2ypO75Zn1/3BjaG9uGYOwe00GuEN0HNnGXoWrQuVil6kkQHj82k6wXA4HZQIFKkarTcX8SeGmJPGEhtlq0utEx3YfZ74JjG1pvEuqZqDDS0SbClvwKL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Zsw7YpMD; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713955355; x=1745491355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E+PxfHVWGnXN3PvLMj2IPQkgGHbi6RwJRPrI2INgD+g=;
  b=Zsw7YpMDiwgHe8JbyeRXJka0WZiogO7tonBTlvqCxNshfRFlec9oqKuv
   py2Bh7yo5eCDaVNnRQPEeqJb5lkSirZSSatibMvgHiQuc/GlMD7AFnA1s
   vQLYZ/ukk0XDyhaCCWcmiGOWa5CZgPT1zuuGUzX88c3lqMwPVBVT2n7rg
   Pk80RdNVB7IC/SSbV+ALTeo+idHQ2ponzRYDRHBqy/86aOVf+bZVjF8fI
   zI6xmVTNOD29T4ieYE1AYtqa2cLzxfLYoy0bpQzw1ChhC+w1vB2wygyBN
   t6GjyZfSo6v2e4ePtr/xEidWY2TInAhtOnlTSHuYD2MJ6RsIHM57vx7Pk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="135936848"
X-IronPort-AV: E=Sophos;i="6.07,225,1708354800"; 
   d="scan'208";a="135936848"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 19:41:24 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 41026E8DAE
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 19:41:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7AB6FBDC8B
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 19:41:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1AC30202CE13B
	for <linux-nfs@vger.kernel.org>; Wed, 24 Apr 2024 19:41:20 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id EC6F41A000A;
	Wed, 24 Apr 2024 18:41:18 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: rpc_show_tasks: add an empty list check
Date: Wed, 24 Apr 2024 18:41:12 +0800
Message-Id: <20240424104112.1053-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28340.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28340.006
X-TMASE-Result: 10-0.263900-10.000000
X-TMASE-MatchedRID: Dkfyeyxtv0ZSuJfEWZSQfEhwlOfYeSqxTSz0JdEAJbT5OKw7VsktYORg
	EMvCxuZnIvrftAIhWmLy9zcRSkKatXbph30JxFrnJmbrB1j4Xwp9LQinZ4QefCP/VFuTOXUT3n8
	eBZjGmUzkwjHXXC/4I8ZW5ai5WKly+s4IRxSS3WIy3ndzvFBLAKCtPMjzuBGdbA6yU3ub6+6DRf
	Cc+NtErSQ8n/8r1yBTFajIpKPW47CSL1SZY9zFQN0BJZs18LwsEWW0bEJOTAVAdUD6vW8Z1mZAM
	QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

add an empty list check, so we can get rid of some useless
list iterate or spin locks.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 net/sunrpc/clnt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 28f3749f6dc6..749317587bb3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3345,8 +3345,13 @@ void rpc_show_tasks(struct net *net)
 	int header = 0;
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 
+	if (list_empty(&sn->all_clients))
+		return;
+
 	spin_lock(&sn->rpc_client_lock);
 	list_for_each_entry(clnt, &sn->all_clients, cl_clients) {
+		if (list_empty(&clnt->cl_tasks))
+			continue;
 		spin_lock(&clnt->cl_lock);
 		list_for_each_entry(task, &clnt->cl_tasks, tk_task) {
 			if (!header) {
-- 
2.39.1


