Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61931596D
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Feb 2021 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhBIW00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 17:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233864AbhBIWJC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Feb 2021 17:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612908421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=taLLLwRVt+OrJ2ugscKx3k1QyDmonfZ/ZD7QCbLcsiw=;
        b=VsWfCslerObqURgnHOa9GQTqmy26vON3ugT4LcFyzC4GvhJJ3Ogc0bIs4SYzB9pGybCuf2
        KlhzsWgMlpgq3+0qPFzvGaXQbkSTyIbwoFNIZIwb90GrT86SSaTw8XUh7STUXGxVokgbeA
        7EkS8jAR8kgxM/18Ou5smu8v8hCZBC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-HYf8FFuHN56PUumQRNO3wA-1; Tue, 09 Feb 2021 16:22:16 -0500
X-MC-Unique: HYf8FFuHN56PUumQRNO3wA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3480C801965
        for <linux-nfs@vger.kernel.org>; Tue,  9 Feb 2021 21:22:15 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-113-50.phx2.redhat.com [10.3.113.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E83C92B394
        for <linux-nfs@vger.kernel.org>; Tue,  9 Feb 2021 21:22:14 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/5 V1] exportd: The NFSv4 only mounting daemon.
Date:   Tue,  9 Feb 2021 16:23:37 -0500
Message-Id: <20210209212342.233111-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Outstanding work that still needs be addressed:
    * Should exportd also process mountd nfs.conf
      sections, that exportd supports? This would 
      make the current nfs.conf sections backward 
      compatible but could cause confusion.

    * How to make the current mountd work injunction
      with exportd. Meaning how to stop mountd from 
      listening for v4 upcalls when exportd is running. 
      This would also allow a v3 only package. It would 
      be nice if this was dynamic verse using a compile 
      switch. Not sure how to do that.

    * Stopping rpc.nfsd from failing when rpc.bind is 
      not running. A nfs.config.d/nfs.conf file was
      used to turned off v3 for testing but that 
      seems a bit clunky.
    
    * The exportd(8) man page could probably used some work.

    * No systemd unit files exists. In theory the only processes
      that would be needed are exportfs, rpc.nfsd and exportd.

Steve Dickson (5):
  exportd: the initial shell of the v4 export support
  exportd: Moved cache upcalls routines into libexport.a
  exportd: multiple threads
  exportd/exportfs: Add the state-directory-path option
  exportd: Enabled junction support

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
 utils/Makefile.am                         |   1 +
 utils/exportd/Makefile.am                 |  63 +++++
 utils/exportd/exportd.c                   | 276 ++++++++++++++++++++++
 utils/exportd/exportd.man                 |  81 +++++++
 utils/exportfs/exportfs.c                 |  25 +-
 utils/exportfs/exportfs.man               |   7 +-
 utils/mountd/Makefile.am                  |   5 +-
 18 files changed, 543 insertions(+), 18 deletions(-)
 rename {utils/mountd => support/export}/auth.c (99%)
 rename {utils/mountd => support/export}/cache.c (98%)
 create mode 100644 support/export/export.h
 rename {utils/mountd => support/export}/fsloc.c (100%)
 rename {utils/mountd => support/export}/v4root.c (100%)
 rename {utils/mountd => support/include}/fsloc.h (100%)
 create mode 100644 utils/exportd/Makefile.am
 create mode 100644 utils/exportd/exportd.c
 create mode 100644 utils/exportd/exportd.man

-- 
2.29.2

