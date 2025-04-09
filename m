Return-Path: <linux-nfs+bounces-11051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51092A82800
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BAC3A1417
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C0266B4D;
	Wed,  9 Apr 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw7H59LA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0E266584;
	Wed,  9 Apr 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209182; cv=none; b=YaZymQ6E2OwIdGIB3zTxydh2wjC+cqdCSOuHgA5SMbo5Anw49hQOuvrttx0TxTPDNaj3QZ+tRSDvK6+Mx1dX03frQv1WYTrhM17jlL9fz3q9go8gYW+jw46muS7rFpPyjGDPG7Cp0jIF70xIQUlneZoZCjEKQ5nkdi/CA5sXMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209182; c=relaxed/simple;
	bh=E7QNRTRZgMzovilvGjUe96foTOP4l/DqVeSstrQ0OdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4hI1YglP/b1JpuX2En9m4UZdC3O5u6vT8AHyW4s4bI37gpz9Oi2j187sv9RbakAXXmCfxQiXctfBUy6YaiXQCqlUiDb8jr4mXA7st00WuPQtdk73GVFduSbMp5Srbs1vSPJK6HHqDGKwG1t/jO7qXj/TYsnk1vs2r8i9CcUi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw7H59LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40706C4CEE7;
	Wed,  9 Apr 2025 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209182;
	bh=E7QNRTRZgMzovilvGjUe96foTOP4l/DqVeSstrQ0OdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jw7H59LALM2j5acvPFKRohh7JfhbXcfJC4P2RhqeSc8+4Ea/kHEoFCiesJccqCXdx
	 UDoviazqUTiZ+u+9h3NR78KcHivLFRJJElUOUWS592WWv3lQiRgNGgup2p6reuPC/D
	 ZvOjrodLZsviNOKBC2oq3BD6Z3VahyJxNToQK4VU66QL39T6dy3iOi9YnRF7kQmNea
	 CkjJ2zMktTfi1Suezb4t8E/IXihP233nAT5zF4DZOai8MRY9AeTvE6ZbxB01A1f50+
	 mk8y+UuvytlH2tznh0RuyO/TyrC60zR5+vrUu9S/ngXcqUn7OLZkAL74sXmuTJs+fo
	 ZME/yiL8puaVA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:23 -0400
Subject: [PATCH v2 01/12] nfsd: add commit start/done tracepoints around
 nfsd_commit()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-1-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=E7QNRTRZgMzovilvGjUe96foTOP4l/DqVeSstrQ0OdE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUZjDk+vB9WDaDcc/Ifikg3yiu5RKEOUjwVb
 sDSGiEun1OJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGQAKCRAADmhBGVaC
 FdMbEACUnuFUV962mU6f0uSf4ilXmue2k0dk9hSd+PT88G1GsAmkArhPsyY1RcfSi/TtOiwws5d
 QAViQsco1LZw8dULCBPF9LfsbW9AHZ5wCDVn9CWgmJ94YHk+vdYUA7ircEzSjCVyEyi4fktAOVj
 DnF+FOoIouNrTpL5LTrPIZX8DZLvOcQ37lGbtaVH4jtFQZtz5kwia7fPtbrP+eORGqrG7ZwSXbr
 dhFVZ1OBqPiU+4SIW5+lVE+YTS1nF+lBqNv9mAT7l9HrkEMlrAammCx6uLvi3JAG4t9bmima4Dz
 p9dWDzD1aIIctstBPbHiEF3QMo9U5W9vRPSUFt1F+nGndXO4XmL9rHKpTLbjVlWf/AH79YH5bsY
 cbk4PjWbch+ep104ZTeYnFsSpKHzVDdwCMr9oj9y13of61X7ArucjvjjHizQmqwe0o4NINFzmFE
 REGSfgcmDv+M6EyiKKnCQHXZXYX5U41PslQJiB9Jn9FBIIq5xEl/MAXIQjDx6EBZJ+uRz8C7rBx
 zH3sMIliJaSKigBLfYecCOFakWv0eho/Z82J1l306+hqOjLRK3mO68cFl2Pc4buzsH3pVJB0vqg
 kGdBnjokeRd64vYWgviVCZI0fy2IkoRjJXG4rMYbdT2cFtYV3LSf1GkQmKpP13lzhYqXWjdiSyn
 04PdyjqQZD1zjmg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Very useful for gauging how long the vfs_fsync_range() takes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 2 ++
 fs/nfsd/vfs.c   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a7630e9f657776a9335ba68ad223641e3ed9121a..0d49fc064f7273f32c93732a993fd77bc0783f5d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -451,6 +451,8 @@ DEFINE_NFSD_IO_EVENT(write_start);
 DEFINE_NFSD_IO_EVENT(write_opened);
 DEFINE_NFSD_IO_EVENT(write_io_done);
 DEFINE_NFSD_IO_EVENT(write_done);
+DEFINE_NFSD_IO_EVENT(commit_start);
+DEFINE_NFSD_IO_EVENT(commit_done);
 
 DECLARE_EVENT_CLASS(nfsd_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 86e199a758f6c69c508151fb14886f4b5da9c080..d1156a18a79579bf427fe5809dc93d06e241201e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1366,6 +1366,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	loff_t			start, end;
 	struct nfsd_net		*nn;
 
+	trace_nfsd_commit_start(rqstp, fhp, offset, count);
+
 	/*
 	 * Convert the client-provided (offset, count) range to a
 	 * (start, end) range. If the client-provided range falls
@@ -1404,6 +1406,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	} else
 		nfsd_copy_write_verifier(verf, nn);
 
+	trace_nfsd_commit_done(rqstp, fhp, offset, count);
 	return err;
 }
 

-- 
2.49.0


