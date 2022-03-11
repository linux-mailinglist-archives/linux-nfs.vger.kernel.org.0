Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA534D68E3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 20:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350245AbiCKTHj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 14:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351026AbiCKTHi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 14:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 098DF1AE66C
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 11:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5WYkCapJcg41PfIySIH3qxCTv6VznYmg5KiXMXL3IY0=;
        b=A76UgdQB8ECzSdcWiDY3rnOSDbS3nLDvDQTsPpMeGIiBN1OqXiBGaipDaYPb+g8mQRH55W
        zbljRo9xY8SjbGau2WeXBEDveFtY6AEzccwWgf0jsoa5l7EEPzNIAK0x4OJ/TDWhK8G9AC
        mllOu9Iz3oVRn/1pj32waeZgzHDV/90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-VbP5CgP5P2i3pv3mWNNOvw-1; Fri, 11 Mar 2022 14:06:30 -0500
X-MC-Unique: VbP5CgP5P2i3pv3mWNNOvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 964F41091DA0;
        Fri, 11 Mar 2022 19:06:29 +0000 (UTC)
Received: from nyarly.rlyeh.local (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC8F660BF4;
        Fri, 11 Mar 2022 19:06:25 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [RFC v2 PATCH 0/7] Introduce nfs-readahead-udev
Date:   Fri, 11 Mar 2022 16:06:10 -0300
Message-Id: <20220311190617.3294919-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Thiago Becker (7):
  Create nfs-readahead-udev
  readahead: configure udev
  readahead: create logging facility
  readahead: only set readahead for nfs devices.
  readahead: create the configuration file
  readahead: add mountpoint and fstype options
  readahead: documentation

 .gitignore                                    |   6 +
 configure.ac                                  |   4 +
 tools/Makefile.am                             |   2 +-
 tools/nfs-readahead-udev/99-nfs_bdi.rules.in  |   1 +
 tools/nfs-readahead-udev/Makefile.am          |  26 +++
 tools/nfs-readahead-udev/config_parser.c      |  25 +++
 tools/nfs-readahead-udev/config_parser.h      |  14 ++
 tools/nfs-readahead-udev/list.h               |  48 ++++
 tools/nfs-readahead-udev/log.h                |  16 ++
 tools/nfs-readahead-udev/main.c               | 211 ++++++++++++++++++
 .../nfs-readahead-udev/nfs-readahead-udev.man |  47 ++++
 tools/nfs-readahead-udev/parser.y             |  85 +++++++
 tools/nfs-readahead-udev/readahead.conf       |  15 ++
 tools/nfs-readahead-udev/scanner.l            |  19 ++
 tools/nfs-readahead-udev/syslog.c             |  47 ++++
 15 files changed, 565 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfs-readahead-udev/99-nfs_bdi.rules.in
 create mode 100644 tools/nfs-readahead-udev/Makefile.am
 create mode 100644 tools/nfs-readahead-udev/config_parser.c
 create mode 100644 tools/nfs-readahead-udev/config_parser.h
 create mode 100644 tools/nfs-readahead-udev/list.h
 create mode 100644 tools/nfs-readahead-udev/log.h
 create mode 100644 tools/nfs-readahead-udev/main.c
 create mode 100644 tools/nfs-readahead-udev/nfs-readahead-udev.man
 create mode 100644 tools/nfs-readahead-udev/parser.y
 create mode 100644 tools/nfs-readahead-udev/readahead.conf
 create mode 100644 tools/nfs-readahead-udev/scanner.l
 create mode 100644 tools/nfs-readahead-udev/syslog.c

-- 
2.35.1

