Return-Path: <linux-nfs+bounces-11935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA28AC5E12
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C2C9E62AD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 00:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232093595D;
	Wed, 28 May 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9P/AtNv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A433086;
	Wed, 28 May 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391180; cv=none; b=YnHkTMi79k1O1aSYUzZNo1gnDwpkB85MtLtjSUHjm2Wh2r+6ZFa47E880Pfw2Npe/rUyxU28e+vQqrfOqy/v7GSF35tz/uAOxTYhsRCfKPaTHoQLhj95TH16t2H5BKSNCjf/WHgpanR3vFLk2+KnEx+Cb3t6iRHZj6kqI37e1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391180; c=relaxed/simple;
	bh=5ONDFZ4LVaUcmaKvgoHjy+Uh+SRtmvFLfkPbbIhSqWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jtJ1B4J//z/F2sW+cuNTkxofvhoY09azRRfXTAtwg2s8EWfrZg/WLgTviNCqV2nKLCCZ9JIgykR8cYICpAqmXUSJnpNQsfa98TQ2NS197GErHd19X9ZtLsSwgQVUwtd2js0LdvZ5l/6iMJiWxS/va1bcXIe2F7FeT7lX4CMPOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9P/AtNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B077EC4CEED;
	Wed, 28 May 2025 00:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748391178;
	bh=5ONDFZ4LVaUcmaKvgoHjy+Uh+SRtmvFLfkPbbIhSqWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H9P/AtNvYE8uOVA1jTwO6GUexHt7YXpFBA1NpG5Oilog3II7QWIfitV8enoAI3BDj
	 rtZO0Wan2kGWnICAf8LiyfgDaK0z6LCu/Povum0ai/O+f0QZ/C/d02YUZnOYccjZQn
	 GRyxgiJeqzb1mJRjvtNtPtAPuuPQZ7QW0/fv3BA8f36Lj5rhgt3kqswChee2GnFRJ6
	 x7hF0VxmNjjxCXEenwet8pTIcQ4Hx9X5a2o0lvex25D3csWU4M8WLiSBPD6LLbDchU
	 A7+n03WaAAz9IEjUTTJ7enJ9UtNHhMmc/H/tgAHOHcYJ/YejWt6EV8cMIt0lXPYlRH
	 JWdJyi6YgtISQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 May 2025 20:12:47 -0400
Subject: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
In-Reply-To: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5ONDFZ4LVaUcmaKvgoHjy+Uh+SRtmvFLfkPbbIhSqWM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNlUG9Nr7KJW3ldEnKQqvXsJQ9cNpLE27W3MwA
 97XNMGS5gSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDZVBgAKCRAADmhBGVaC
 Fdj+EACFgjx+In/2Hqjpy58mWpT3o4UT296dFvTPnytPs8ok3FLiSCzbph+WPkwQZB3NjDJvA/l
 2guqhrfWiySmpff7yzEf7BQY/alGoRj+5suwRr4eGyOWawxyoXjqhb2MSph9HyRKraKskKHFvPN
 vXtzNJ7TOoMkOOMPTPsQVXz0xIc5ax6CsyYZ+sNpHxIF6767/qz1ur1JcO27jGtJuP2APHigwhc
 pfMnLha4Xq+79bbjjDXHMzvocuqCvrwG9iHV2wRomJ2j/ZTOsFfOVMXfLZ5eYEXtJ6qdwkSSCs6
 kDntgcNM3GUMRlnAOzxmZ45fj1E1fv7PQtri4R31UmEv0u7W2wa2LAdgOCDqvnEFyfV3BWUbI/f
 yoZherDGaMaKWLp/KDmhh4xrmiqWaEmAAfgPfT177X1DDeOhTBOeYwcZ/iMsgeevsoDqGLS61Tb
 S0WP+FixQ7WMyEd867RxXMio3CxOZ/TjWWb5H1skn14bon2wDVDEinAJey2cPjarI2teCSu+xqW
 LKCt2aCYrmI83WYyLXscxTruOmISp4lj40u26L79usyyxdvq/5itpS6JLulq+X66y1NV5qiGTeu
 RmqHmGv5KMUjyNsQk8L0kdRweBxLH/GiNsZwp9Py7CdfXQHyHFdCvfcDlEjQcX3hBig22X4kdQ1
 WbqN2erF7pphajw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The old nfsdfs interface for starting a server with multiple pools
handles the special case of a single entry array passed down from
userland by distributing the threads over every NUMA node.

The netlink control interface however constructs an array of length
nfsd_nrpools() and fills any unprovided slots with 0's. This behavior
defeats the special casing that the old interface relies on.

Change nfsd_nl_threads_set_doit() to pass down the array from userland
as-is.

Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts via netlink")
Reported-by: Mike Snitzer <snitzer@kernel.org>
Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.org/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80350668e94c395058bc228b08e64 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
  */
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
+	int *nthreads, nrpools = 0, i, ret = -EOPNOTSUPP, rem;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	const struct nlattr *attr;
@@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	/* count number of SERVER_THREADS values */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
 		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
-			count++;
+			nrpools++;
 	}
 
 	mutex_lock(&nfsd_mutex);
 
-	nrpools = max(count, nfsd_nrpools(net));
 	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
 	if (!nthreads) {
 		ret = -ENOMEM;

-- 
2.49.0


