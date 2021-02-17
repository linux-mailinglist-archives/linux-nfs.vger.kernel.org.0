Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2367731DFBF
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Feb 2021 20:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhBQTmd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 14:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbhBQTmd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Feb 2021 14:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613590866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gclTDJG5h62uL+V5q/OhtFFFrPcfAHZKDvJ34Y7giX0=;
        b=JtJI2eZ/iN79sf/6HP85A4zIKQ4Y/XjfO6ULiLlcIcbhNLBzLwBjn0UEbsEwSxLnWj+BDZ
        dOEMHcNEKg12FrAQ9rRR9r5VniukS5fPC3Afres8ua1lRMDl0KvsKZb4MViNMaydkuEEh7
        1Kbuuva3NqU2TNP2vZZSkk0EWf4Xehs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-ZBj_r0G2PF-BZ8-XkSPZ1g-1; Wed, 17 Feb 2021 14:41:04 -0500
X-MC-Unique: ZBj_r0G2PF-BZ8-XkSPZ1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECEEEEC1A0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 19:41:03 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD06C60657
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 19:41:03 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/6 V2] exportd: The NFSv4 only mounting daemon.
Date:   Wed, 17 Feb 2021 14:42:34 -0500
Message-Id: <20210217194240.79915-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

exportd is a daemon that will listen for only v4 mount upcalls.
The idea is to allow distros to build a v4 only package
which will have a much smaller footprint than the
entire nfs-utils package.

exportd uses no RPC code, which means none of the 
code or arguments that deal with v3 was ported, 
this again, makes the footprint much smaller. 

The following options were ported:
    * multiple threads
    * state-directory-path option
    * junction support (not tested)

The rest of the mountd options were v3 only options.

V2:
  * Added two systemd services: nfsv4-exportd and nfsv4-server
  * nfsv4-server starts rpc.nfsd -N 3, so nfs.conf mod not needed.

Steve Dickson (6):
  exportd: the initial shell of the v4 export support
  exportd: Moved cache upcalls routines into libexport.a
  exportd: multiple threads
  exportd/exportfs: Add the state-directory-path option
  exportd: Enabled junction support
  exportd: systemd unit files

 .gitignore                                |   1 +
 configure.ac                              |   1 +
 nfs.conf                                  |   4 +
 support/export/Makefile.am                |   3 +-
 {utils/mountd => support/export}/auth.c   |   4 +-
 {utils/mountd => support/export}/cache.c  |  46 +++-
 support/export/export.h                   |  34 +++
 {utils/mountd => support/export}/fsloc.c  |   0
 {utils/mountd => support/export}/v4root.c |   0
 {utils/mountd => support/include}/fsloc.h |   0
 systemd/nfs.conf.man                      |  10 +
 systemd/nfsv4-exportd.service             |  12 +
 systemd/nfsv4-server.service              |  31 +++
 utils/Makefile.am                         |   1 +
 utils/exportd/Makefile.am                 |  63 +++++
 utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
 utils/exportd/exportd.man                 |  81 +++++++
 utils/exportfs/exportfs.c                 |  25 +-
 utils/exportfs/exportfs.man               |   7 +-
 utils/mountd/Makefile.am                  |   5 +-
 20 files changed, 586 insertions(+), 18 deletions(-)
 rename {utils/mountd => support/export}/auth.c (99%)
 rename {utils/mountd => support/export}/cache.c (98%)
 create mode 100644 support/export/export.h
 rename {utils/mountd => support/export}/fsloc.c (100%)
 rename {utils/mountd => support/export}/v4root.c (100%)
 rename {utils/mountd => support/include}/fsloc.h (100%)
 create mode 100644 systemd/nfsv4-exportd.service
 create mode 100644 systemd/nfsv4-server.service
 create mode 100644 utils/exportd/Makefile.am
 create mode 100644 utils/exportd/exportd.c
 create mode 100644 utils/exportd/exportd.man

-- 
2.29.2

