Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FEE31F299
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 23:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBRWyz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 17:54:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhBRWyy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 17:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613688808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eSID1shUUi7BSb5vgdfJ221ik/vRKK3tr9gtvuoi2xo=;
        b=PzzWfJJaHqyhEpzjdisV2X14couyCQZm45UoOWWjudwKYiEyYLFUAP/GVe+7tKUAcjsELa
        RKQ3XjB7ZTWq+XuXLLWDv3m/8rEYFChSlqX4bPI7TqINcJyZjSA62L++2dQAdl1/bBJ4IG
        PxoWG4QxmGURhDwTOwIU3VmggRYzrSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-Ikj0EJ2INgSuHL5e-9-WKA-1; Thu, 18 Feb 2021 17:53:14 -0500
X-MC-Unique: Ikj0EJ2INgSuHL5e-9-WKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AE731966320
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 22:53:13 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B94560BE5
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 22:53:13 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/6 V3] The NFSv4 only mounting daemon.
Date:   Thu, 18 Feb 2021 17:54:44 -0500
Message-Id: <20210218225450.674466-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
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

V3: Changed the name from exportd to nfsv4.exportd

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
 systemd/Makefile.am                       |   4 +-
 systemd/nfs.conf.man                      |  10 +
 systemd/nfsv4-exportd.service             |  12 +
 systemd/nfsv4-server.service              |  31 +++
 utils/Makefile.am                         |   1 +
 utils/exportd/Makefile.am                 |  65 +++++
 utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
 utils/exportd/exportd.man                 |  81 +++++++
 utils/exportfs/exportfs.c                 |  21 +-
 utils/exportfs/exportfs.man               |   7 +-
 utils/mountd/Makefile.am                  |   5 +-
 21 files changed, 587 insertions(+), 19 deletions(-)
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

