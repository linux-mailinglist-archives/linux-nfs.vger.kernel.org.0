Return-Path: <linux-nfs+bounces-11399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E80AA8147
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF231980982
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDAB27C867;
	Sat,  3 May 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih04J5dV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7827C860;
	Sat,  3 May 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285114; cv=none; b=EyeoJXEfrwwmNJpdhHgXgabJjtThixWTrxXVDQBW7syH7bGueh7lhHfYcT0G5U6dMRECjWRcszlzdzZ5zQr007LfBJxpdlk1J6Uk8z1XxJTymIxyyI+UvXg+L+RscwKftwMfHvaKQFkpQEpnqaIHJFvtUThhQtp6tdfqisirxio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285114; c=relaxed/simple;
	bh=EVp0KkwQWMT+7bdOoBwsBrqYsKukwQ0eGk8vamKl4jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXS0TbPrpcj3IU8xO9Lg8gxUGiLZiCOq6o38Uv1qjH5IJoTLTwEN9PCHgBFnOppxCAz4aOQAKI3yA72amPfv9TXS/Hy3OKya+IQ2Cn/Hhf2hBt35gPmIjF487Cd5fQaL4722gDek+9D5IL+NWNrzqwmXKOPrcf3VZHoSrD3+ftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih04J5dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E269C4CEEE;
	Sat,  3 May 2025 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285114;
	bh=EVp0KkwQWMT+7bdOoBwsBrqYsKukwQ0eGk8vamKl4jM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ih04J5dVCHvUZYc9KClbdPJANIMMPH9XfztfrG+Jhax/aHqErXnMVXp+FkhlkUOPC
	 /IaYEx3VGot6k8vZFc8vQyWb+/SexfjLufeq8gFYQWXUieWL48EdDS5JDyETAKZ8q9
	 W3DCv3JDuBm1PmwFvUWia5Xnc8cQ2kuoP+YYHm/Dj1/iKi9lG2S8zaIy+pibUaK2Wu
	 p8Kd+9t2LZU5ofPkCFZJbe9lbjRjWl4PhKaReo0kFm1aaWAuT7oin7hDAIxJ7WvXLK
	 hqWPx07rClwga+mA0SQ7nBTGeQM7pGB6R8zs7sX6hBGojFh1GAtLSv9iO0B9ilVoMx
	 ZhxN5qlf8MTIQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:25 -0400
Subject: [PATCH v3 09/17] nfsd: add tracepoint to nfsd_readdir
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-9-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EVp0KkwQWMT+7bdOoBwsBrqYsKukwQ0eGk8vamKl4jM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjItJybWHLQWK/Wp4t5vjWjTXXvRltAXAa844
 agl1LzTVCiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLQAKCRAADmhBGVaC
 FfL3D/9TIXMw1ySz1F/5kTXEXDMhVC/JZh/BlVrvhbcAqBqR7xpTQBz60F2zvkIK2/jn9gQKBEq
 pfXqVrPg9IJenOtYbuOLqRKgFCON7PoTyefZjjmPIwfTxy57nQkuZ/9svH8REFEYohx9Va4fUnM
 r8OSpjO2tafqKiMIZEPg0Lhz7C6plyHP9qpeEuXfrIPfk8x1ZddZiswybRKe3V6oNga53W7fgo2
 w9pQy/UkVQ/qVIk4cBqzDjrhTsssWwB5XnBa2mm22GsBQllw++2pLQJgCOhuPQ+aUYvnk6l05+8
 P9jAEAHgUapCEXfAGjqzZpcrqwGsV0MaYruPTTBNITSVNkTLQHETfnGsdHkvS7231BQrJ0hNEb1
 lKKiVRsZqdUYm+dGUsTS5MLSC7b739bO/zyTsmaVhFv3lW65cHYtundSK/4h8z1FXHFehwj8u+4
 +Mxc1QtIqo0lUVe4IU14Mzr6vmXcMy50Dsq5IFveL1lc36bSiwOjP4ImH6/YgCK+CVwh0pmxjIF
 D2vEO0rM32hVWT9CWzsUOH/zY/UoOOEmDyX3F3DtbbDeiB7fHEXcMFylmAVQQVH3djp8nXEcome
 Y40F49S1wGVInJwQOdKXPRNLMn4lkjDdaG+S0Tvg0Ha2tKvejRJ3XTeqjrxhCnhRLZh09c5yXhc
 sD4SZBRRbRhaXOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 19 +++++++++++++++++++
 fs/nfsd/vfs.c   |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4e873ceca602098d2899c5ff2deee610ddb670a0..6f73ecc6bbf09cc174a93ce1dce12edfff6f60b8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2512,6 +2512,25 @@ TRACE_EVENT(nfsd_vfs_rename,
 		  __entry->xid, __entry->sfh_hash, __entry->tfh_hash,
 		  __get_str(name), __get_str(tgt))
 );
+
+TRACE_EVENT(nfsd_vfs_readdir,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 u64 offset),
+	TP_ARGS(rqstp, fhp, offset),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(u64, offset)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->offset = offset;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=0x%llx",
+		  __entry->xid, __entry->fh_hash, __entry->offset)
+);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9fd5f7d277b452e12a2d5854b9d3ff79418a8818..ec07e5867912bf87497b935d26e3039364596864 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2249,6 +2249,8 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
 	loff_t		offset = *offsetp;
 	int             may_flags = NFSD_MAY_READ;
 
+	trace_nfsd_vfs_readdir(rqstp, fhp, *offsetp);
+
 	err = nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
 	if (err)
 		goto out;

-- 
2.49.0


