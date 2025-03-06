Return-Path: <linux-nfs+bounces-10505-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C0A54AE5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6FE1891902
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AD20D519;
	Thu,  6 Mar 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRMcV0gN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477720D50F;
	Thu,  6 Mar 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264713; cv=none; b=dUziqDZHBSMWU5S2D6qZ+oZPFRxtKtxpdsguXWVnRUt4e8A1FvB8GiEb1D091KWavlTZomDSLKQ+efuUO4MuJzEEq+hoBGaC+3gW0iz2IQpFqrt3vWELhwsH9gUCdlJaLZHqXwqKyDttCq5ApVDC4UWnDzPxKvgYjHjjnDxvT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264713; c=relaxed/simple;
	bh=jC3vud5pWlNnQwn60QUYW6ELssAqnVz/RrhPdDsIdB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbOLYmPcct1dz34ztlpmER15MEbWItt1ceMJku9b1Sgi5gRz07t9ook2KDwlsRg9t/S6In+3xdEANmXwAQtCOdrro0US2nZYyFGc82HjOZuMEMIKsiYA5Erddu6f9pouKq65z00CLC0UdPV53MMTNfGkZ4zehJjEzqc1TEm2iOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRMcV0gN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8643AC4CEE9;
	Thu,  6 Mar 2025 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741264712;
	bh=jC3vud5pWlNnQwn60QUYW6ELssAqnVz/RrhPdDsIdB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qRMcV0gNE41eSWDfRYkj+RK8JyMBMLxxs+WPB5qNE4W09bYzDMCRefZoEg0vU979N
	 Tt1i5SKkDnJRKvvJtPFc7Gk7Ve1mSzgmZK1DGD0ws93hTsr0QhBwmW/oPmWM2vSslf
	 UFmOYPen3Mnu9A+bgFsyfcIwSATTJwuFThgcbHStoOmQchhaSatQibm4wGVHCUJ0JJ
	 m1JzSXNZbft+FRn+QvDmkYvfkhspxqPLaw3XI7dBRmX/yoLN9NiuXfwRm0AgkE2rLm
	 Wn1pBln9eQtvDY2JVoyx8ECRxqpqZkqTD8KbJYMcJH0fbzFeBuwy4gxTyjVpEZNDjz
	 /GpK0nVPH3Ndg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 06 Mar 2025 07:38:13 -0500
Subject: [PATCH 1/4] nfsd: add commit start/done tracepoints around
 nfsd_commit()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-nfsd-tracepoints-v1-1-4405bf41b95f@kernel.org>
References: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
In-Reply-To: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jC3vud5pWlNnQwn60QUYW6ELssAqnVz/RrhPdDsIdB8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnyZdEsBEAaQ9XGT3DT0LweJSDPazX8z3WXmN6d
 g3qji72m72JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8mXRAAKCRAADmhBGVaC
 FZ8eD/wNnEC4wACUFFzIZMDDbYuYrOg8sECNsSWAu2Qapf64rlGVUQ/p2mJNKRwGVcbLRmp1qZn
 x+dh0sKNXfRYxuPS97VwCmQQLLZzX+gu618bDv644pKLxAD1WPGX3WRZAHdG3qZ+LKoytdIKOsC
 x505327L7uxZ1McZ9Zsokw1kE07QN9QYos6EeXp1aNb8+M2qBT0NcZ41dzA+ms+IKrTdEyRM3qt
 wXMdobK5LWsRBpHdTZJ0DEh/61um58HU/V0RjBq3BZu4dd81+O0HZaRj82yyjKfEigVeXEbCewc
 3L95hTb9IIduCA5ocEQYvwIb+CIVcK3iCy8iOcyZXIpaQUaEkoeuZVlj/AEWmZZcQ8RO2Dj65an
 A7oX5vNWb8aCWX8VGNGnsUIh11ORvWM+8U/Q25IrS7TEl+NMK4RFI6EQt96ia2tlklxdSau9fEY
 H1A7xPUM1IumnItxQjmzMqJHLyOFAVLsXxi+syTHA4ib1/31Y0xBgs4BgcGRs0PvR4WpYj0/N7N
 bD2ux01R6KHt4aIuCnO4LC52fpyJzixABsorgnDQvcR+fzmlYqI2mcg4XVbWhxlE8QadWCnBhZg
 2lr0Q18B99SOZzS62lKc834Yw3qhXfz3Swm4rvBsTghp0drkBnRKotCrr6BpB4LlFRYrz3EGN/V
 1vtGv4ZkAAVMcig==
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
index 4021b047eb1804f0058f6fb511d3fdfc03a42bf3..390ddfb169083535faa3a2413389e247bdbf4a73 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1339,6 +1339,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	loff_t			start, end;
 	struct nfsd_net		*nn;
 
+	trace_nfsd_commit_start(rqstp, fhp, offset, count);
+
 	/*
 	 * Convert the client-provided (offset, count) range to a
 	 * (start, end) range. If the client-provided range falls
@@ -1377,6 +1379,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	} else
 		nfsd_copy_write_verifier(verf, nn);
 
+	trace_nfsd_commit_done(rqstp, fhp, offset, count);
 	return err;
 }
 

-- 
2.48.1


