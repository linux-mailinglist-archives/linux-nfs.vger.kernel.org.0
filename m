Return-Path: <linux-nfs+bounces-7598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05A39B7BDD
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F63282384
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69119F110;
	Thu, 31 Oct 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPiLnvPg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5313D886
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382015; cv=none; b=OIx2XRrKZXlKLe2FmYuodm9mivqvxkF2ohTmbIPbjSdQPWECAZaKpb1R5hiBGoyAMEv4ayIqqqeTOB5XXBCzv8YlkHWdSOJS8fVAtM3WNOSpwg4xfYGVIrgpQj7HcUaxxZv8SKnxuwR5Q1rfQK8auK7tOOrmUKiqJjTNV7UWgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382015; c=relaxed/simple;
	bh=HfR3QCu5pj0pSXZ4OQzd8xq8bQ6fJkqcG/9EvwYWiys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqtFJ4WUVyyfkv/HKOp1GUe/MWPz+Q0PFGgEqh7LvcIfYgl4kZArNQxhFUgJ5TEbKQ42CQhfIGlDiNk4WE7KFDk2S38hpD+S6sFMEYqgWUA0JBTPQR7Pf4J5zsksqsMOk8C6KIeVf95k81LTFT+jupZAD4I58T42oiZ98w/ZBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPiLnvPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101E3C4AF10;
	Thu, 31 Oct 2024 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382014;
	bh=HfR3QCu5pj0pSXZ4OQzd8xq8bQ6fJkqcG/9EvwYWiys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPiLnvPgkHiPo0R1HS9ZdXWqkDfn765b5n4Yyl8pVn69Hxz/c3I6GCz1tk1D0c5jk
	 avUxyD2LSxq4b0WZnYFO7gI0FA18NlxxZAme6wKpr5ILgnPB0yw0EDBo0V23gzs9WD
	 IuG/sV87hLrkzU4iV8OZswlMofN/oRrzeYPWpOog9tH9y6wNiQyvxNOQv9oEEFYGjB
	 3Pw/TxTBQvBqB5LpI+xtjrjZBrnn1dUyavku9PNsBUrYPDM6XYohZC79/Mh6gETyGn
	 8LXgf5bc7BPdDNL/lXKemkcBabumPq4aj63WfGZiyw6I3ocnjAXDL8OuRBJbe5+8N3
	 Z5qgUAz1zt3iQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 4/8] NFSD: Handle an NFS4ERR_DELAY response to CB_OFFLOAD
Date: Thu, 31 Oct 2024 09:40:05 -0400
Message-ID: <20241031134000.53396-14-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=chuck.lever@oracle.com; h=from:subject; bh=F4Gz3kuuKWspdsZMwJ3nKDesQ4+c3xnUivyumfWdfUI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i36vFfp1xfuTSnfdtu7qileUThf9wzinzPd qMKGhJ2+huJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItwAKCRAzarMzb2Z/ lyNeD/9nZm9acHgYm9TXVXpOJMoIik0GGq5/EjeQtnBVg9Orgxrr54ZJgHKtpjs20FJP6eNYSFA EX9MVeGPW3T6wscDtcNAZ0wsXGT4qp7LPxiPF5BWbsIKtHgQCf4tNFcadfhNwcfVm0QNtPljFRj naSRQdIcjDtS1TDbv+aQm2AK3pOo9lJwCpjg1sBnlhI4bdEgvqzuGi+KsZJJkAD3y/Qk/LUl8M6 hH7l5LHGDS7PzNq6DdneOtYbXtnUri+L2OinxqAFfL8uan4W3vDn9kOPdD0E3HIO7lNa1vBzCk6 TEi9x22PNGTLxyxBK3L1xigTsSXFP+Ar6XKkl9PeYZrtrvJByhDTcrvgUOc3aEuvsFLf0myZrsC KkD71tj/QSJYXQtQqDbYq/8mF6GrRs/2SPQTHxXnji1tLaX13VYcu8sM9DiV+tYz/5m6KfJDxfs CNYK1H77t94WV8eSevdpFlpw+/yV3d/p81qdVMtl2Iv7UyDYgofcW7xL5FvzxYjLO8nVzy2cqL/ QG8LygFcsYtd2Cp6w1+JLgsVY2ivl2yDRKiYKdV+y+atUWQ99I2vMlirXzBv6PgNu6E8K3Oe6nS CkUChWMo4kc1Nl39QyRwiGdGpZqw9pqNg8ft2hv+w69/A7lUFQXhrfbity3W56/2KBuwP0mGTCA zbpXN51li6ZaqDA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 permits callback services to respond to CB_OFFLOAD with
NFS4ERR_DELAY. Currently NFSD drops the CB_OFFLOAD in that case.

To improve the reliability of COPY offload, NFSD should rather send
another CB_OFFLOAD completion notification.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 8 ++++++++
 fs/nfsd/xdr4.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 39e90391bce2..0918d05c54a1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1617,6 +1617,13 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
 		container_of(cb, struct nfsd4_cb_offload, co_cb);
 
 	trace_nfsd_cb_offload_done(&cbo->co_res.cb_stateid, task);
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		if (cbo->co_retries--) {
+			rpc_delay(task, 1 * HZ);
+			return 0;
+		}
+	}
 	return 1;
 }
 
@@ -1745,6 +1752,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
 	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
 	cbo->co_nfserr = copy->nfserr;
+	cbo->co_retries = 5;
 
 	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
 		      NFSPROC4_CLNT_CB_OFFLOAD);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index dec29afa43f3..cd2bf63651e3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -675,6 +675,7 @@ struct nfsd4_cb_offload {
 	struct nfsd4_callback	co_cb;
 	struct nfsd42_write_res	co_res;
 	__be32			co_nfserr;
+	unsigned int		co_retries;
 	struct knfsd_fh		co_fh;
 };
 
-- 
2.47.0


