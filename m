Return-Path: <linux-nfs+bounces-3558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4950B8FBE7E
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 00:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD4D1F21FFD
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 22:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0553143744;
	Tue,  4 Jun 2024 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf9NV0u1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDE320C
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538867; cv=none; b=VKJBhojRmQzImdytjWV+R1gUVu4wfyecOygp170jX14d+Io5icdoanb9cE+6Z5MZLFSAF2k5A3+//6FiBrLIT1HkUiBJSkETqjU7vF56Mpko3FyZr/onO18eNt/w+vR6pBUtSn8EH51nh6m6IpRn6k9q3FzfZY7F2s12FxiovxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538867; c=relaxed/simple;
	bh=lYKYMPFfHFQCdQYZ243zPsEk7WfGlGjBQ5vqPkX77Ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5qrBpJVZ+8rLUBCA5I21ilPqg0YJ1zu48GQ5AHkF5WT5tF1WT3Ftpcix/wA+cgXF7x509v3IOiAG/j2/JBD0IyVxITuXCIkvGiJAh/ewO4VV/nYqhATS4Zsh9EmMX1kIUIQI6oQW3hKwjEd5Py6HH2E39TQDMh/CZ1GHDyz2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf9NV0u1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D36C4AF0A;
	Tue,  4 Jun 2024 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717538866;
	bh=lYKYMPFfHFQCdQYZ243zPsEk7WfGlGjBQ5vqPkX77Ck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sf9NV0u1E4Ti/xsQL8hV82Qm3sGhlKyxoQQj3RRMVEFu/bAtQYV7ksAwWvqis98vT
	 jJTycc8Eg1jCyR8WLll6gA2IqpVBzWdkJF2dBpwAJJZhi01+4QK8wqxJMjYPeNLJtp
	 ve1BOLAcaETMm632tvKennWisU9sSjuc8CeqSgQcA464+cXQPNL4TEjJrB3RUiA48E
	 2v91qV1vff67+GCy7lnDZJtaw4bsZJKAxm42xSgZ3kt6lM0q8dgp5TWwd4dtyqi9cj
	 eo251hjp3Y9ULcyQPg0aLDExwX21+MzoWt8ei/4HqgeBolsmyruUCQ2pc2wC9ZkHtX
	 GzU7z/G9wPIAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 04 Jun 2024 18:07:31 -0400
Subject: [PATCH nfs-utils v4 3/3] systemd: use nfsdctl to start and stop
 the nfs server
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nfsdctl-v4-3-a2941f782e4c@kernel.org>
References: <20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org>
In-Reply-To: <20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lYKYMPFfHFQCdQYZ243zPsEk7WfGlGjBQ5vqPkX77Ck=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX5AvaxlJtnqCCv9BXvpNnixev4Ayy4/WAmYkg
 tORVJS2MquJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+QLwAKCRAADmhBGVaC
 FXpcD/9uq3fjmfU2KJ6jjTiJLFN8shLjNnroc+t6SXg6YHrzXqQBzCqxEnrBLKYss7aujj8LDNo
 ddeLJBF1t41Lipw3OYW6EFNTibTGzo0O238YBC0D2P0YcKbOkv2K+2VcOxA/+RnMkFhDXz+km2e
 vXVuHwqSxJSUD95x23N9bjWXd0QPxnN/6em3EUkQpMsImyrfP8Wk26xxYvnAnSfftTKtyvypNAp
 +P75qQckZ781ydz7fk6pOaWtr2faPhuApPoztebQeb4B3H7yo6tsv6P6ycMIWM1iRQBVbcNtVkL
 4H2fOMrrW46D/s/kxc9DyKExPStbppdpaapVsdHb1p/Rrxbf73a9pApGtilif3Xk/V7VbQuaMHr
 JKSarVHuezxNzU+VQ0vR2f+TyNyHbf0hY3jUweaGXjhzmEv1OhDoVFkABS5TZysp29qiHCQN90z
 H+cyJC2plMHz4A4WUkZ55Bu35zDn6WAazqOiEZiHcaWRIbsJmooNipETY+HZTeUUeZQgM9JlXYC
 gJRXksghHXQjQc6IxxeJGG/Bl/vVdzpIuL7WYqsHrybMdIgH70b3caXBKA9AzAK3Zjzr92+Yf7j
 YkAyo8UuvAzyWw2O1ZKR9/q/BSd6bB/jc4w5Wno4hHm6CELkC9edsrByJnEuJvlA0ZyWJe95kdZ
 S6ssrJ3buYnJq0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Attempt to use nfsdctl to start and stop the nfs-server. If that fails
for any reason, use rpc.nfsd to do it instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 systemd/nfs-server.service | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index ac17d5286d3b..8793856aa707 100644
--- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -23,8 +23,8 @@ After=rpc-gssd.service gssproxy.service rpc-svcgssd.service
 Type=oneshot
 RemainAfterExit=yes
 ExecStartPre=-/usr/sbin/exportfs -r
-ExecStart=/usr/sbin/rpc.nfsd
-ExecStop=/usr/sbin/rpc.nfsd 0
+ExecStart=/bin/sh -c '/usr/sbin/nfsdctl autostart || /usr/sbin/rpc.nfsd'
+ExecStop=/bin/sh -c '/usr/sbin/nfsdctl threads 0 || /usr/sbin/rpc.nfsd 0'
 ExecStopPost=/usr/sbin/exportfs -au
 ExecStopPost=/usr/sbin/exportfs -f
 

-- 
2.45.1


