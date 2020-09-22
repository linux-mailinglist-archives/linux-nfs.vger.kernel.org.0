Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6D42748ED
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVTP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 15:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgIVTP4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 15:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600802155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdz9zJIsKhK20eDJMe62K7afKAWp0i6orrxBsn+rnUI=;
        b=KuECqbP/WL1m3ElhWFrwrmyaAJO64jXiQuAo4VUo8gJ7AZMOb8QMIuqfKyzEoyNIXXa3Bg
        Jrms+Im+5UQFORF8HnEF0SWQhi4mSyMnRGK7QBusqMxXJ+ygebZhRwdyachnsScBsasSaM
        U6ASnGdENvuHlcH6sMMiFmhS/9nPWFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-2b9yaW8XN3-osWEAfsuFyQ-1; Tue, 22 Sep 2020 15:15:51 -0400
X-MC-Unique: 2b9yaW8XN3-osWEAfsuFyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11EE5801AEA;
        Tue, 22 Sep 2020 19:15:50 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C8D10013D7;
        Tue, 22 Sep 2020 19:15:49 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 6138E10C1261; Tue, 22 Sep 2020 15:15:49 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2 v2] NFSv4: cleanup unused zero_stateid copy
Date:   Tue, 22 Sep 2020 15:15:49 -0400
Message-Id: <df0b660cb13db18d1119bae41b800fbd647a19f5.1600801124.git.bcodding@redhat.com>
In-Reply-To: <cover.1600801124.git.bcodding@redhat.com>
References: <cover.1600801124.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index 4bf10792cb5b..06bbe19c8b2c 100644
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

