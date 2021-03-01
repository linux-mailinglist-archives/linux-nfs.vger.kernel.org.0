Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBAC329429
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 22:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbhCAVuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 16:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244085AbhCAVrw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 16:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614635185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V1kZ9slYFH2ZLdEjAd+QvsWxv/j+FYrEiw5ModdOrSg=;
        b=EX6S73feIqUe0qOhmFmUQMsFoEo5iIp2Ldy2eIIgWleobl/oa/ICwRO3UT+gUbd/P4K0SK
        nxoGRrhHRSN2sUyJAdSRkv3l0dMSEKkkmgahVGWFA6gVT6OtBbc8brvgAk5L4YwC1Mp8XR
        pQ2tzFSe84yYZJB5RSFHG4ozcZJp1Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-jliidWA2OFa0mrtPfwD5mg-1; Mon, 01 Mar 2021 16:46:24 -0500
X-MC-Unique: jliidWA2OFa0mrtPfwD5mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A9441005501
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 21:46:23 +0000 (UTC)
Received: from farnsworth.lan (ovpn-112-73.rdu2.redhat.com [10.10.112.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C64335D9E4;
        Mon,  1 Mar 2021 21:46:22 +0000 (UTC)
From:   Jacob Shivers <jshivers@redhat.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] nfs-utils: Add flag and boolean to control SETENV behavior for $HOME in rpc.gssd
Date:   Mon,  1 Mar 2021 16:46:21 -0500
Message-Id: <20210301214622.829462-1-jshivers@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A deadlock can occur when accessing NFS home directories when $HOME is
unmodified as Kerberos routines will attempt to access $HOME, but will be
inaccessible due to a lack of a Kerberos ticket. It would then check for the
existence of $HOME/.k5identity, but could not access the file due to not having
a TGT.

The issue was originally reported in:
https://bugzilla.redhat.com/show_bug.cgi?id=1052902

This patch allows for user control of this behavior granting users who do not
have Kerberized home directories access to their .k5identity file.

This addresses the following bugzilla:
https://bugzilla.redhat.com/show_bug.cgi?id=1868087

Jacob Shivers (1):
  gssd: Add options to rpc.gssd to allow for the use of
    $HOME/.k5identity files

 nfs.conf             |  1 +
 systemd/nfs.conf.man |  3 ++-
 utils/gssd/gssd.c    | 28 ++++++++++++++++++++--------
 utils/gssd/gssd.man  | 19 ++++++++++++++++++-
 4 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.29.2

