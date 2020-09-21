Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548A2721C6
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIULEr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 07:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgIULEq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 07:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600686285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFYos9rOFIGRHRfgHYoo9w4m4ixFvuLw5bCs6Nh/tAQ=;
        b=U4d+86IU7hDhkx5C8g//WmmaNQNallmCgKklnKCSXUekLPqV5dMDYbW/Yumx5xw2Q1o5ZH
        tLNXUMl1P3kP7ED7wQcCQkv/LVLP/uAOq3KS/XjP09p2PAYhY3yGPjdhnUbA5NoF3xdRM1
        fUFjbfgp9pex9IS6IXKCmZkV+2lIPsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-MZF29sGsOW6RnTmTCqfARQ-1; Mon, 21 Sep 2020 07:04:43 -0400
X-MC-Unique: MZF29sGsOW6RnTmTCqfARQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C139664080;
        Mon, 21 Sep 2020 11:04:42 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4E178823;
        Mon, 21 Sep 2020 11:04:42 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id E3D1610C1261; Mon, 21 Sep 2020 07:04:41 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4: cleanup unused zero_stateid copy
Date:   Mon, 21 Sep 2020 07:04:41 -0400
Message-Id: <469888e8990e53fefbff77d71b6e814237333dc8.1600686204.git.bcodding@redhat.com>
In-Reply-To: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit d9aba2b40de6 ("NFSv4: Don't use the zero stateid with
layoutget") the zero stateid will never be used.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4state.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a8dc25ce48bb..fe2d11ce3fa4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1018,18 +1018,14 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 bool nfs4_copy_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
 {
 	bool ret;
-	const nfs4_stateid *src;
 	int seq;
 
 	do {
 		ret = false;
-		src = &zero_stateid;
 		seq = read_seqbegin(&state->seqlock);
-		if (test_bit(NFS_OPEN_STATE, &state->flags)) {
-			src = &state->open_stateid;
+		if (test_bit(NFS_OPEN_STATE, &state->flags))
 			ret = true;
-		}
-		nfs4_stateid_copy(dst, src);
+		nfs4_stateid_copy(dst, &state->open_stateid);
 	} while (read_seqretry(&state->seqlock, seq));
 	return ret;
 }
-- 
2.20.1

