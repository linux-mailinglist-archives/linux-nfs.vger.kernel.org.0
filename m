Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC6380A64
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 15:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhENNb7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 09:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhENNb7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 09:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620999047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=RT63x1lnqRUL9qcZ1UJuKuc0yzcOR0Cb4UBxcjqZGDg=;
        b=OpbYQWAq7xp+iaJQTtgpIG+Tp+rFAweJUd16j7xd3iFEET9vTXbGMNcNS6iOL/t8YOnTGW
        WsVP5wKsvBhKOfzpQp//3WNKc+nFykwDLPSmpDvezovWwG6Gtjwi2RUQTJ4Y27CPs61Bzu
        y3k+X7zGlbkCG3O+cPqv1a55t3Ve6A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-da_VPCF3ONObLhM4JCqw2g-1; Fri, 14 May 2021 09:30:44 -0400
X-MC-Unique: da_VPCF3ONObLhM4JCqw2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0A978186E5;
        Fri, 14 May 2021 13:30:43 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D6AD60CC6;
        Fri, 14 May 2021 13:30:42 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] Add callback address and state to nfsd client info
Date:   Fri, 14 May 2021 09:30:40 -0400
Message-Id: <1620999041-9341-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For troubleshooting, it is useful to show the callback address and state,
even though we do have this equivalent info inside Chuck's ftrace patches.
Note there is a show_cb_state() inside fs/nfsd/trace.h and this code
has a similar function.  It may be better to consolidate these two
if these additions are ok for nfsd client info, but not sure where
a good header is to place it - do we need a new file, maybe
fs/nfsd/nfs4callback.h?

Dave Wysochanski (1):
  nfsd4: Expose the callback address and state of each NFS4 client

 fs/nfsd/nfs4state.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
1.8.3.1

