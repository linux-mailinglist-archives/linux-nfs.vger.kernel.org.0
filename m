Return-Path: <linux-nfs+bounces-7237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A019A2600
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE22868A3
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5401DED6E;
	Thu, 17 Oct 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEnJRzv5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866611DED6D
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177441; cv=none; b=MtMslAvYly0wmOXVx2DEffgNbtv4Wwoa77ROmEygKV7h7TlJq1WSAsU8PI48NnB9kx9LCEQo5XzyAkyaUy0A9Mw9683rIHRZDTUVMtger19S1CJ/P4xuw2eDB7CcLmBMtuWAS9AzOyOolACxx6h4ua1AYi7uvRDw4Z4sd1uZnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177441; c=relaxed/simple;
	bh=OYxx9BDWeo+jHQmDuw1sabm5pu8LTpLF+upjXunWnIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCOs3Ty+dFJ5a6YOrPM4bTuEfLTKz/kXzUPGSeqCQyOO+7hemY/gPIDsGlTBELYGhdKG2S4R0qZW/4e6baBc4daVTInp1CBOVXTZUDrMde99b///k4MfCNMWEvzaHOzkZv1K1IHSPNav5lCBRrxNfcRs9q8HrxKeZO105HqrJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEnJRzv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C22C4CEC3;
	Thu, 17 Oct 2024 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177441;
	bh=OYxx9BDWeo+jHQmDuw1sabm5pu8LTpLF+upjXunWnIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEnJRzv5XRlkyG+j+yBr/rWEqMCwid8ksoMAt4ske0MWFgx3jN8DzOT0nhVZI9f4p
	 8bzt2A2uoVFYMNyFLqwUZv7qxOkDzwk55F1fhWr9c+JJvcMKMDjoLuK5EvK3KXGY0V
	 rj/zEN9NBonO2DkIL6q5uTFjTEO6Edg32tLf0hwHq/gfyNQ5+8HtuCB2nAOnB1AlXW
	 Xz8pIEaZ0/sjAzminseAKJ/4ClVfZxclPJ8UG3mfqc9gFR2UhMS0J8sVqEPylP9iem
	 2EK9s9ixNVGIxyQTp8lUWZQ1LNtCHLvE59TsX0vOFd/oBNIzbh6l71JfSC2FMwDkT+
	 yt9RLwqZAW/WA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/6] NFSD: Remove a never-true comparison
Date: Thu, 17 Oct 2024 11:03:52 -0400
Message-ID: <20241017150349.216096-10-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017150349.216096-8-cel@kernel.org>
References: <20241017150349.216096-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=chuck.lever@oracle.com; h=from:subject; bh=FgFqs/GUCoBBeu6K4CNpdYJOHQzsoTY0ajJm02PuNwQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnESdbUs+qrDCnnv1ATy3Ljc1A+DUpHXk99Zj2t m6DpsynLT2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxEnWwAKCRAzarMzb2Z/ l83aD/kBcBTfdIPU/ZtyPjpCImyaHpHD58L5lPoKVkYdrL/WLYMdPuIEN9l1ma5DGMhJQDPQHtr TjmCeYg8xM49fDHHR4rDzh8lzMqA8JafMI5t47z2Nc8ncAxHJ1yKsgKeWodoeVhvWzX9v+tMGxd r5mh36rHghj3DGcvMKbM3r3ciM2c+XCpYRu67v0gPLqzd8Hx4ZcAF3KeSlYj/qAIiCgyyBUnS1C qs8gM0EEuJwIgyvzcMXa20VM+DmKGsJwEFk7tpH7LH5ezyoCzAwsf0nIgvjOXlNzZWvaQO1I+Av aIuTyk+L8woom6xQZxcsFeiXFVtpM81ZNBAIhYH8IQSEV6zoXKG02B9i7rtGQUCLx7gFnqPOn3+ US0tiaHQtGxtqDxRVCHKON7/iHcXcgMjUZqHiVg0sdvCDh3WVMFFH6NcIegiKLNkQ8S+FzO3UQ+ 0q8AhjzjbPK5H8yPxuYEGq/ZhGuInXYm6VYAHuLeSWSITff4/tqyCjKpySBLr8vXeUyMcdlkdbd 5cGNpXLQ/hTEO+8ptR/jFolvsYBPvOWc3eIWheXmcQei44X3KEWQAetWydBRxJaHX5eoCS8iymh IS0/ZDrogTWncEPbMfYvh1dKYWOgmHMLEr/Fedk3Gp5uzC5ELwz3FR9PSCDlqYE4zrKBTv9IxWW KspKJokkWyHnacA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

fh_size is an unsigned int, thus it can never be less than 0.

Fixes: d8b26071e65e ("NFSD: simplify struct nfsfh")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4c5deea0e953..641dfe54fb59 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -773,7 +773,7 @@ char * SVCFH_fmt(struct svc_fh *fhp)
 	struct knfsd_fh *fh = &fhp->fh_handle;
 	static char buf[2+1+1+64*3+1];
 
-	if (fh->fh_size < 0 || fh->fh_size> 64)
+	if (fh->fh_size > 64)
 		return "bad-fh";
 	sprintf(buf, "%d: %*ph", fh->fh_size, fh->fh_size, fh->fh_raw);
 	return buf;
-- 
2.46.2


