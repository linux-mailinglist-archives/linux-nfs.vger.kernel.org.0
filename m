Return-Path: <linux-nfs+bounces-5403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51BF9533C0
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AE21C23DD9
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E221DFDE;
	Thu, 15 Aug 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsfnOjzV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBF19FA7E
	for <linux-nfs@vger.kernel.org>; Thu, 15 Aug 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731523; cv=none; b=GIEe0gz3dLg1EZfa/0NzFQdijkoR8tkmOVU+Coi3JgKLb7CK0D6XU12UbXHmWpn7/l3mXVDn/t8nWZjn+OmVNPthK3M9hAJHuKuAPGEX3R0OJB9JwdPOffWtucj04xPuagNPF26vUQuySkORFUYo83PDxdojvxYEBxOVMG/9aH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731523; c=relaxed/simple;
	bh=81OG2+Dm7lF4a1gggTJOchKCg1z/iunuwoFPjKSX8/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKxVFCM3myu1Rn0US6wHvpKg/ks9x8MXsaa+TLnFJHMLvqUAQLPefFPejaHZwPJuYPG9B9lfW+dekGwf2UQhfgeao/mMwBiXqnD3lMS0YkZgvj2GXRwhvObhr/2asO1/Ouq55Q/Xa3FJYje2T8rnU0Ayurk1sYdcTH7IW+AAgfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsfnOjzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01201C32786;
	Thu, 15 Aug 2024 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723731523;
	bh=81OG2+Dm7lF4a1gggTJOchKCg1z/iunuwoFPjKSX8/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=DsfnOjzVGCOPM10E4fYDmZ6D6jNh4aMQlw1VyJfjnMuEarxBkPKzDhd5h9qvMS/dI
	 zWHeoZ2zqOPEtoiiN56UGDHe+Je34jqqZL0zT+7AnrDZS6ofp2n0LZnE8LClMk17V8
	 AhoXJpMLWAT2mJKtaoZQrtt+7wqmXHtgwhTr11qxga2WHL1IJqxYsMDqP9v2kzcWz1
	 OELtv0yXrQKhhgy1hOBH15GAaA+uBbQBjm6tPUWyI3Ms7opgNDfzIcpMg+nrn0SBJc
	 gjwCio2ghI8bgzmfjmnOgknll0P55D1wkYlJ45fr57Qrs1IKi2VbjAcDyty224HGmB
	 jA9yi6m00B2IA==
From: Jeff Layton <jlayton@kernel.org>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS
Date: Thu, 15 Aug 2024 10:18:41 -0400
Message-ID: <20240815141841.29620-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The client doesn't properly request FATTR4_OPEN_ARGUMENTS in the initial
SERVER_CAPS getattr. Add FATTR4_WORD2_OPEN_ARGUMENTS to the initial
request.

Fixes: 707f13b3d081 (NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8883016c551c..39ad7780986c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3931,7 +3931,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		     FATTR4_WORD0_CASE_INSENSITIVE |
 		     FATTR4_WORD0_CASE_PRESERVING;
 	if (minorversion)
-		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
+		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT | FATTR4_WORD2_OPEN_ARGUMENTS;
 
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
-- 
2.46.0


