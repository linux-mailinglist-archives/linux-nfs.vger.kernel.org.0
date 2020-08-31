Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA87257E51
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgHaQLu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 12:11:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726249AbgHaQLu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 12:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598890309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IKXY7bOK05OUUK3ZunjuUUl3v/d+LwupA+h7FhhkHss=;
        b=X7myR5T0FmZyoonOQUyoVx9V2NrZEvK/CiwnsPKJH04+3lMZkC2dwVy0S8GQimj20YwtJv
        QLWr5x2vCbQgRBiTOMB0EsdG+rmDLWcBEhrtDUTAm58fvM3v4OhMR7H4GmUN1bINIx3k1W
        LNuHf0kKAU2jAH7cNEIlGi+bDfluFfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-QQzMp_WaMz-r_BDr7aht6g-1; Mon, 31 Aug 2020 12:11:38 -0400
X-MC-Unique: QQzMp_WaMz-r_BDr7aht6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51CB01009444
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 16:11:37 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-190.phx2.redhat.com [10.3.113.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1275B1A885
        for <linux-nfs@vger.kernel.org>; Mon, 31 Aug 2020 16:11:36 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc.gssd: munmap_chunk(): invalid pointer
Date:   Mon, 31 Aug 2020 12:11:35 -0400
Message-Id: <20200831161135.146867-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Removed an errant call to gss_release_oid()
to try and deal with memory leaks

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/gssd/gssd_proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 2a8b618..e830f49 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -687,7 +687,6 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *srchost,
 	} else {
 		get_hostbased_client_buffer(gacceptor, mech, &acceptor);
 		gss_release_name(&min_stat, &gacceptor);
-		gss_release_oid(&min_stat, &mech);
 	}
 
 	/*
-- 
2.26.2

