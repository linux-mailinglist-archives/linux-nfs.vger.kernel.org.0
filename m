Return-Path: <linux-nfs+bounces-11371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76000AA4A08
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 13:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BD21C06B2C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A96150997;
	Wed, 30 Apr 2025 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cx7sg5Y4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4E20C00C
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012523; cv=none; b=gYSR1OQCsitcwyYXfghVPGfApqyil5FdwKmQX42bUEbqwEbBJTy5GOeZaitT/y+UlB5vxmxl0G1iokDETQSyQcwPqYb/x9o2Xh8PKP/BwTnlRmI9Fi43eTVWbvPtsGAhR/mxrFk+qgqX+hKOQ1WIr0JyHVaHuC58/pg6iV02z3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012523; c=relaxed/simple;
	bh=LnmsUGrRKAfLHu3WqLJRNX4A/bp81dWr4LVO7Mn3UmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ad62bac5WQY/8PGNTFSdnJp8kchWLvCFCcTfk3nTA0z34OuGUWo8M5RgjeNJ3iWr/Srd7JLo3Uydb6Lbok4GrKvbG9gdo17hIeKklItcp6oC9nIyxbyu67kBY28FkUQTNzpw5TVJtd0+D87sP2/azMGUScrFO4h0B11T7VldbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cx7sg5Y4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746012520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bb2yr3qjCOKF//BifsiGwrCRpLka7Bd2yBDiEBASFh4=;
	b=Cx7sg5Y4aXc2BDkXBwUKIZLop+z+42VyrG08BRW+6ir50VjtU1uJ3+mzno9KlmbfTPuP6+
	QmR55n1UC3/kT+jx7JlAIuEbdIeE3VMvcmGIwBa7ztP8E8+daxoVEOEynZWGE0BQo5iPxE
	XOFvh4ebYoARsamsQQ+zX68BtAfU8H4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-Y1U1nnEqNEC7z1QAOl4pNw-1; Wed,
 30 Apr 2025 07:28:36 -0400
X-MC-Unique: Y1U1nnEqNEC7z1QAOl4pNw-1
X-Mimecast-MFC-AGG-ID: Y1U1nnEqNEC7z1QAOl4pNw_1746012515
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C06B119560A7;
	Wed, 30 Apr 2025 11:28:35 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.153])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F91119560AF;
	Wed, 30 Apr 2025 11:28:35 +0000 (UTC)
Received: from aion.. (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 75F37344E3F;
	Wed, 30 Apr 2025 07:12:29 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Don't check for OPEN feature support in v4.1
Date: Wed, 30 Apr 2025 07:12:29 -0400
Message-ID: <20250430111229.4114991-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

fattr4_open_arguments is a v4.2 recommended attribute, so we shouldn't
be sending it to v4.1 servers.

Fixes: cb78f9b7d0c0 ("nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..2eb2d750a5f1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3967,8 +3967,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		     FATTR4_WORD0_CASE_INSENSITIVE |
 		     FATTR4_WORD0_CASE_PRESERVING;
 	if (minorversion)
-		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT |
-			     FATTR4_WORD2_OPEN_ARGUMENTS;
+		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
+	if (minorversion > 1)
+		bitmask[2] |= FATTR4_WORD2_OPEN_ARGUMENTS;
 
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
-- 
2.48.1


