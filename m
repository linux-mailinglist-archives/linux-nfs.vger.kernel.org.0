Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70044EF799
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiDAQLY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349532AbiDAQI4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 12:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0CB71A2A34
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648827157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fcjZlfxucPJ7FKgcNGZ3x/MCsoP3RaotjbqiTYdTASs=;
        b=ZjtOICLbPTYSkgO/yJ/TJRyDukEm1PvXxOqbrdzJd/k50MOPliUY786nt9yige4MELeLv/
        T85pruqQ1Hcjg/1FrA+LSnopuyKy1OP6XexzQ1Uu3xkMbs9RrBUcEDjS04DmBV1mAC5sz+
        cWR5lfnWST4ewbyYxREH6V4Sm32ahK0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-U00_d2E8OsqcF8HOeoP0zA-1; Fri, 01 Apr 2022 11:32:25 -0400
X-MC-Unique: U00_d2E8OsqcF8HOeoP0zA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 964573802139;
        Fri,  1 Apr 2022 15:32:24 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-139.gru2.redhat.com [10.97.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CE8E2D444;
        Fri,  1 Apr 2022 15:32:17 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH v4 0/7] Intruduce nfsrahead
Date:   Fri,  1 Apr 2022 12:32:01 -0300
Message-Id: <20220401153208.3120851-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Recent changes in the linux kernel caused NFS readahead to default to
128 from the previous default of 15 * rsize. This causes performance
penalties to some read-heavy workloads, which can be fixed by
tuning the readahead for that given mount.

Specifically, the read troughput on a sec=krb5p mount drops by 50-75%
when comparing the default readahead with a readahead of 15360.

Previous discussions:
https://lore.kernel.org/linux-nfs/20210803130717.2890565-1-trbecker@gmail.com/
I attempted to add a non-kernel option to mount.nfs, and it was
rejected.

https://lore.kernel.org/linux-nfs/20210811171402.947156-1-trbecker@gmail.com/
Attempted to add a mount option to the kernel, rejected as well.

I had started a separate tool to set the readahead of BDIs, but the
scope is specifically for NFS, so I would like to get the community
feeling for having this in nfs-utils.

This patch series introduces nfs-readahead-udev, a utility to
automatically set NFS readahead when NFS is mounted. The utility is
triggered by udev when a new BDI is added, returns to udev the value of
the readahead that should be used.

The tool currently supports setting read ahead per mountpoint, nfs major
version, or by a global default value.

v2:
    - explain the motivation

v3:
    - adopt already available facilities
    - nfsrahead is now configured in nfs.conf

v4:
    - retry getting the device if it fails
    - assorted fixes and improvements

Thiago Becker (7):
  Create nfsrahead
  nfsrahead: configure udev
  nfsrahead: only set readahead for nfs devices.
  nfsrahead: add logging
  nfsrahead: get the information from the config file.
  nfsrahead: User documentation
  nfsrahead: retry getting the device if it fails.

 .gitignore                      |   2 +
 configure.ac                    |   1 +
 systemd/nfs.conf.man            |  11 ++
 tools/Makefile.am               |   2 +-
 tools/nfsrahead/99-nfs.rules.in |   1 +
 tools/nfsrahead/Makefile.am     |  16 +++
 tools/nfsrahead/main.c          | 183 ++++++++++++++++++++++++++++++++
 tools/nfsrahead/nfsrahead.man   |  72 +++++++++++++
 8 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfsrahead/99-nfs.rules.in
 create mode 100644 tools/nfsrahead/Makefile.am
 create mode 100644 tools/nfsrahead/main.c
 create mode 100644 tools/nfsrahead/nfsrahead.man

-- 
2.35.1

