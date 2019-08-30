Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E0A3BEF
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH3Q0g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 12:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3Q0g (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 12:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7D0CA36EE3;
        Fri, 30 Aug 2019 16:26:36 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F7A26092D;
        Fri, 30 Aug 2019 16:26:36 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 2F67920963; Fri, 30 Aug 2019 12:26:31 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] nfsd: add principal to the data being tracked by nfsdcld
Date:   Fri, 30 Aug 2019 12:26:29 -0400
Message-Id: <20190830162631.13195-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 30 Aug 2019 16:26:36 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

At the spring bakeathon, Chuck suggested that we should store the
kerberos principal in addition to the client id string in nfsdcld.  The
idea is to prevent an illegitimate client from reclaiming another
client's opens by supplying that client's id string.

The first patch lays some groundwork for supporting multiple message
versions for the nfsdcld upcalls, adding fields for version and message
length to the nfsd4_client_tracking_ops (these fields are only used for
the nfsdcld upcalls and ignored for the other tracking methods), as well
as an upcall to get the maximum version supported by the userspace
daemon.

The second patch actually adds the v2 message, which adds the principal
(actually just the first 1024 bytes) to the Cld_Create upcall and to the
Cld_GraceStart downcall (which is what loads the data in the
reclaim_str_hashtbl). I couldn't really figure out what the maximum length
of a kerberos principal actually is (looking at krb5.h the length field in
the struct krb5_data is an unsigned int, so I guess it can be pretty big).
I don't think the principal will be that large in practice, and even if
it is the first 1024 bytes should be sufficient for our purposes.

Scott Mayhew (2):
  nfsd: add a "GetVersion" upcall for nfsdcld
  nfsd: add support for upcall version 2

 fs/nfsd/nfs4recover.c         | 332 +++++++++++++++++++++++++++-------
 fs/nfsd/nfs4state.c           |   6 +-
 fs/nfsd/state.h               |   3 +-
 include/uapi/linux/nfsd/cld.h |  37 +++-
 4 files changed, 311 insertions(+), 67 deletions(-)

-- 
2.17.2

