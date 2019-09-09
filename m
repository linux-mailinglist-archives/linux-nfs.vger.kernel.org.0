Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256B7ADFCE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbfIIUKk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 16:10:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731905AbfIIUKk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Sep 2019 16:10:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECA2810F2E8F;
        Mon,  9 Sep 2019 20:10:39 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC5B600CD;
        Mon,  9 Sep 2019 20:10:37 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id BC4F820AC8; Mon,  9 Sep 2019 16:10:31 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     simo@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] add hash of the kerberos principal to the data being tracked by nfsdcld
Date:   Mon,  9 Sep 2019 16:10:29 -0400
Message-Id: <20190909201031.12323-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Mon, 09 Sep 2019 20:10:40 +0000 (UTC)
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

The second patch actually adds the v2 message, which adds the sha256 hash
of the kerberos principal to the Cld_Create upcall and to the Cld_GraceStart
downcall (which is what loads the data in the reclaim_str_hashtbl).

Changes since v1:
- use the sha256 hash of a principal instead of the principal itself
- prefer the cr_raw_principal (returned by gssproxy) if it exists, then
  fall back to cr_principal (returned by both gssproxy and rpc.svcgssd)

Scott Mayhew (2):
  nfsd: add a "GetVersion" upcall for nfsdcld
  nfsd: add support for upcall version 2

 fs/nfsd/nfs4recover.c         | 388 ++++++++++++++++++++++++++++------
 fs/nfsd/nfs4state.c           |   6 +-
 fs/nfsd/state.h               |   3 +-
 include/uapi/linux/nfsd/cld.h |  41 +++-
 4 files changed, 371 insertions(+), 67 deletions(-)

-- 
2.17.2

