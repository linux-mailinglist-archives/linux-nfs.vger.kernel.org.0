Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59E0275EC4
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 19:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgIWRhY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 13:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbgIWRhY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 13:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600882643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VYQzjHafUbkx94vEGbLkpJSPXHadQ2U3ksMU9tU6eQY=;
        b=Mwlj/YA0A6epk8F0yDUzmqHn6TX0eEV/3hFAVInjCZRzIrDq3ih5p/r1RJSiW9Oy6bvpu5
        pk7KdTp6PQywQrp+NEm4aseW8a1tQ1RaBASPKqzOlhB9h7t9Q4nqoVBh9xwKeJKQPh5Y7J
        B9RU3v9fEXDUkTyLn4zxLjToK9WW5T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-qcxZGhn5PnWIZ8xB0XxuzA-1; Wed, 23 Sep 2020 13:37:19 -0400
X-MC-Unique: qcxZGhn5PnWIZ8xB0XxuzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B26EA1DDE0;
        Wed, 23 Sep 2020 17:37:06 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66C1F6FEE7;
        Wed, 23 Sep 2020 17:37:06 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id EBE1210C311B; Wed, 23 Sep 2020 13:37:05 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2 v3] a stateid race and a cleanup
Date:   Wed, 23 Sep 2020 13:37:03 -0400
Message-Id: <cover.1600882430.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v3: pull out unnecessary state match checks.  V2 cover letter follows:

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

 fs/nfs/nfs4proc.c  | 16 +++++++++-------
 fs/nfs/nfs4state.c |  8 ++------
 2 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.20.1

