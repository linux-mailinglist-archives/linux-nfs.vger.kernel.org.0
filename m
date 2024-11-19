Return-Path: <linux-nfs+bounces-8133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 210579D301B
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82591F23246
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 21:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145B1D2715;
	Tue, 19 Nov 2024 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KrZZVL33"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E813E03E
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732052635; cv=none; b=YXNmR4oZGcaxzXwZk0bae4tJqE9KUqEvpscgTZVrUj+S+kkVWsjm/HmWn4xMpUm04O1altRofK6081Lesn/G2vxhj/AzLRvn20ui7GAgMkV6mLoHEgE6eLwAIiHPxyEv01CtjfkllrgQOOGqBc4M7XP7AsLKdt4kw4ym7tOfKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732052635; c=relaxed/simple;
	bh=Yz8I6QjoKne6LUyPqIdDwzhmlzAbVZgvXk42TZOaqnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UgTp1mA9qFgnXmhy9mLU1X5Gnz00HuZRgntH831C/Ff13EGdrp/1OalPx7y6MTJexYG6lVhvTc606xHaZkuvnaUddXdlyz3xjny9nUgdoiXIt082lavozjbyRVR63u76waJXYDfB/7skb8oONj/RRKY1kWRxTFcPBEKEJZX6a6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KrZZVL33; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLYkRR023719;
	Tue, 19 Nov 2024 21:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=mww2/Pb2jYyvwWlz8IPDSfSH5j2edBcptS16AROd1+I=; b=
	KrZZVL33cm3wHGO18eKAvoRzmhPdmSsYnlZZCgqrWL3E1MbGZZi58g3v3lfSM+3r
	k1xvdXs4N5/+dAegkqfY/JjyEwJ2HwWZ1qIHCUCOj+3lbKv02sPFJHX/SWPQn7uT
	tvH63mjSN6+WMzcMm7XqJOSsUcDan+hmcwWSN5srVAhdautUu3RdCTAFiI4dPTXh
	ssOjmE0PNekponYrlk2lG7mQ2SRU1itd67wOJvOCcy1T7VB+YHArI//wFe+JSOKp
	FiNK/TVef8zd2rYrJWh3gOvGTsCHSTiWvvWMdU37bysK+7a1oxTWX19VqA7s9Teq
	5DsMVJl53yDBb0nzyQoCmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyye3k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 21:43:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLIZGf037914;
	Tue, 19 Nov 2024 21:43:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9bxrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 21:43:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AJLg8Tg036080;
	Tue, 19 Nov 2024 21:43:44 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42xhu9bxr4-2;
	Tue, 19 Nov 2024 21:43:44 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@hammerspace.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: display total RPC tasks for RPC client
Date: Tue, 19 Nov 2024 13:43:23 -0800
Message-Id: <1732052603-28539-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732052603-28539-1-git-send-email-dai.ngo@oracle.com>
References: <1732052603-28539-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_13,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190157
X-Proofpoint-ORIG-GUID: foXNU6WQ8FyTSjLF-tQoAJPVt-lCqO6z
X-Proofpoint-GUID: foXNU6WQ8FyTSjLF-tQoAJPVt-lCqO6z
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Display the total number of RPC tasks, including tasks waiting
on workqueue and wait queues, for rpc_clnt.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 net/sunrpc/clnt.c    | 7 +++++--
 net/sunrpc/debugfs.c | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cc5014b58e3b..79956948ae9d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3327,8 +3327,11 @@ bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_has_addr);
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-static void rpc_show_header(void)
+static void rpc_show_header(struct rpc_clnt *clnt)
 {
+	printk(KERN_INFO "clnt[%pISpc] RPC tasks[%d]\n",
+	       (struct sockaddr *)&clnt->cl_xprt->addr,
+	       atomic_read(&clnt->cl_task_count));
 	printk(KERN_INFO "-pid- flgs status -client- --rqstp- "
 		"-timeout ---ops--\n");
 }
@@ -3360,7 +3363,7 @@ void rpc_show_tasks(struct net *net)
 		spin_lock(&clnt->cl_lock);
 		list_for_each_entry(task, &clnt->cl_tasks, tk_task) {
 			if (!header) {
-				rpc_show_header();
+				rpc_show_header(clnt);
 				header++;
 			}
 			rpc_show_task(clnt, task);
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index a176d5a0b0ee..e4a4c547c70c 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -74,6 +74,9 @@ tasks_stop(struct seq_file *f, void *v)
 {
 	struct rpc_clnt *clnt = f->private;
 	spin_unlock(&clnt->cl_lock);
+	seq_printf(f, "clnt[%pISpc] RPC tasks[%d]\n",
+		   (struct sockaddr *)&clnt->cl_xprt->addr,
+		   atomic_read(&clnt->cl_task_count));
 }
 
 static const struct seq_operations tasks_seq_operations = {
-- 
2.43.5


