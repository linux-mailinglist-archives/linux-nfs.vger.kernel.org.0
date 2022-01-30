Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049BB4A3864
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jan 2022 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiA3TGS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jan 2022 14:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbiA3TGS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jan 2022 14:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643569577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d5oly9nmsFQ7QMk6hl6BDPsL2vg6UnvvOqDcPxXhV0s=;
        b=iGJKC2NhHulmeFtzPFny29f9DGXXW2Rgxwnkh3ckvvDL7AbOnRaB8wVZ9Vci/aetYMAz7j
        OQ8P3hJE0K0YNc9KuBmEY/MAUE4GyGnQP8Uq55mBg2EtBMp3rRNs237P04eNd+ilA+QVmJ
        hfJD12QEcQFWEAZXJb322wPCPIuG+Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-jgykxxFdO5iKCuD_Kucvlw-1; Sun, 30 Jan 2022 14:06:14 -0500
X-MC-Unique: jgykxxFdO5iKCuD_Kucvlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B541006AA0;
        Sun, 30 Jan 2022 19:06:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (unknown [10.2.16.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C13C60854;
        Sun, 30 Jan 2022 19:06:12 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Bill Baker <webbaker@gmail.com>,
        Calum Mackay <calum.mackay@oracle.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/5] Flight Data Recorder Update
Date:   Sun, 30 Jan 2022 14:06:06 -0500
Message-Id: <20220130190611.12292-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here a few updates to the FDR package that
will allow it to work out of the box when
the RPM is install... Kinda. 

When the rpm is installed, the daemon is not enable or
started and the config file is not enabled. But it 
makes much easier set a tracepoint.  Uncomment
the needed tracepoint and start the fdrd daemon.
Then do tail -f on /var/log/nfs.log.

The package is very light weight: one daemon, two config 
files and one example file. The config file that is installed
has all of the nfs,nfsv4 and sunrpc tracepoints, commented
out. 

The first 4 patches are clean up... Making things work
right out of the box and conforming to current
presidencies. The last patch, installing an nfsall.conf
config, could be questionable. Do the maintainers want
to maintain config files or have the distros do it?

I guess the bottom line is this. At the last bakeathon
we talked about moving away from rpcdebug setting 
dprintks to tracepoints (which is a good thing IMHO).
Now, it is not clear how it can be done, but I'm
hoping this is the first step in that direction.


Steve Dickson (5):
  Makefile: cleaned up the usage of RPMBUILD_DIR
  fdr.spec: logrotate clean up
  systemd: rename service file.
  saveto verb: Document updated
  configs: Add an nfsall.conf config file

 Makefile                    |   8 +-
 buildrpm/1.3/fdr.spec       |  25 ++-
 configs/nfsall.conf         | 319 ++++++++++++++++++++++++++++++++++++
 fdrd.man                    |   9 +-
 fdr.service => fdrd.service |   0
 samples/nfs                 |   2 +
 6 files changed, 349 insertions(+), 14 deletions(-)
 create mode 100644 configs/nfsall.conf
 rename fdr.service => fdrd.service (100%)

-- 
2.34.1

