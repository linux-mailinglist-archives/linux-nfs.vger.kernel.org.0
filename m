Return-Path: <linux-nfs+bounces-13560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81821B2142F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948EE3E32C7
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500662E285C;
	Mon, 11 Aug 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIlpynNy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7A2E2850
	for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936336; cv=none; b=Ri8mWRmcOWo7eJHnPlrkwSHCsvqM3h2ByveDQcavi4RPbxXkBekeig/sKoY735+mu2cnpKngpdno+CtFvlsNe8qlz7H+A2XUs+ZQ/gh3eSW3UDgr5CHTPuFFedwwVymi36YY98F2pfzgUZDTG4NXiL+2U+MrJOLm0VBPclA+6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936336; c=relaxed/simple;
	bh=gGoMvJarp24Dhi11fzqhcjyt6R7eEH0Onn2XmQqP9Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FI3cTV4BtFa8nr3GY+fVitJcFJ13EDxN0jHdVMfEVKRUjfQBk05TGPE38u3ZEPt1QSY8sxHXGzCc0XEF5fma654hfVI2ys8PqDPodUoVZNrvvaBa78+jJHTD4VTgUDHkzTEaFXw65Q2TCaQh5d1g0EveUwedcDpnRfGKvpUklQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIlpynNy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BPfDBtGjbfOXoP+1XX4mDMB2E16Hz/R0Ch+EUAPQHD8=;
	b=gIlpynNyXx649U+cmGfeKFj+xD717QntHTYJsXDbHTeJbqzLY8znNx6HBCxb5Jv3IZEJoX
	LCKjhPp7W8FulDxTFYSgDcTluDYxLNQqwjvMfHHUAU2nq7Joycguh4A3yoW9sO+Namusoe
	yaiGo39Dz3SG/M6Iw12GShAXeIgf+4E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-kDg7li_tNwSHc-axYz_vCA-1; Mon,
 11 Aug 2025 14:18:51 -0400
X-MC-Unique: kDg7li_tNwSHc-axYz_vCA-1
X-Mimecast-MFC-AGG-ID: kDg7li_tNwSHc-axYz_vCA_1754936330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34D1E180035F;
	Mon, 11 Aug 2025 18:18:50 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50F001955F24;
	Mon, 11 Aug 2025 18:18:49 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@hammerspace.com,
	anna.schumaker@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4: handle ERR_GRACE on delegation recalls
Date: Mon, 11 Aug 2025 14:18:48 -0400
Message-Id: <20250811181848.99275-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

RFC7530 states that clients should be prepared for the return of
NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 341740fa293d..fa9b81300604 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7867,10 +7867,10 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 		return err;
 	do {
 		err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
-		if (err != -NFS4ERR_DELAY)
+		if (err != -NFS4ERR_DELAY && err != -NFS4ERR_GRACE)
 			break;
 		ssleep(1);
-	} while (err == -NFS4ERR_DELAY);
+	} while (err == -NFS4ERR_DELAY || err == -NFSERR_GRACE);
 	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
-- 
2.47.1


