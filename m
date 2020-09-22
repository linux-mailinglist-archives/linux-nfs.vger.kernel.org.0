Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27B2748EC
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 21:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVTP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 15:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgIVTPz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 15:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600802155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kTHxYjjMMjd1zufVAcVsjuvE3ib8kV1Z3b5giVcoY98=;
        b=b0FnfKAz4CihOM3DZEA/HtS9/rmiI2cCTkcjuT/vC0s1OQ4OoGu+iYfaZB4+W34Xl/PkZ7
        rYjzXyWIPRn4LF9eoCic5rTnegzIcnyrhQUp2CJ6oSsAfShe2X3cV9v1DApdWcZbUGLov8
        MjvTe+YgGE8lwwEg+erfcqpAvHzWZlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-MjJHfLOaMuqbvYwJH-BZ7g-1; Tue, 22 Sep 2020 15:15:51 -0400
X-MC-Unique: MjJHfLOaMuqbvYwJH-BZ7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 168931017DC3;
        Tue, 22 Sep 2020 19:15:50 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C76A35C1A3;
        Tue, 22 Sep 2020 19:15:49 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 543CB10C311B; Tue, 22 Sep 2020 15:15:49 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2 v2] a stateid race and a cleanup
Date:   Tue, 22 Sep 2020 15:15:47 -0400
Message-Id: <cover.1600801124.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Cover letter this time explaining the v2:  Anna helped me find that the
first version's stable fix was wrong, but was fixed by the refactor patch
that followed.

After putting in the logic to fix the stable version, it was messy enough
that it made more sense to squash the two patches together.  So, this time
the first patch does rewrite nfs_need_update_open_stateid a bit more in
order to handle both cases:
	- where two OPENs race to NFS_OPEN_STATE and the second wins
	- where an OPEN and CLOSE+1 race to update nfs4_state and CLOSE+1 wins

The end result is that these two patches are code-equivalent to the first
three.  (It is still getting one final run through my testing, but I haven't
delayed posting for that).

Benjamin Coddington (2):
  NFSv4: Fix a livelock when CLOSE pre-emptively bumps state sequence
  NFSv4: cleanup unused zero_stateid copy

 fs/nfs/nfs4proc.c  | 27 +++++++++++++++++----------
 fs/nfs/nfs4state.c |  8 ++------
 2 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.20.1

