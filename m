Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8002D35FA5E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDNSKq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 14:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351771AbhDNSJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 14:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618423723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6JwzPyMYRjGmDE4WTbGVV2rH9Z1up3XLMY9LoXzkwok=;
        b=A3WX0jEyq7xqzgzJ8cRR/YeDxhKyKC3HlAVftwPBFGldw/Cl63CRw7/Rze08lc4YNuBnpg
        J+MVNTBUPd9SzbvqrOEn7BqDriV88+Jjg7o5iYypJdYLUWf5W86nbqBCGnVnTE2LMQ5aNS
        mKTfgpZTlHrh1M7FvMNseGD0F39C2xE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-UzZh5XdXPveI58do-FQjBw-1; Wed, 14 Apr 2021 14:08:33 -0400
X-MC-Unique: UzZh5XdXPveI58do-FQjBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 925D89126D
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:32 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F96160862
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:32 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 0/3] Enable the setting of a kernel module parameter from nfs.conf
Date:   Wed, 14 Apr 2021 14:10:37 -0400
Message-Id: <20210414181040.7108-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a tweak of the patch set Alice Mitchell posted last July [1].
It enables the setting of the nfs4_unique_id kernel module 
parameter from /etc/nfs.conf. 

Things I tweaked:

    * Introduce a new [kernel] section in nfs.conf which only
      contains the nfs4_unique_id setting... For now... 

    * nfs4_unique_id can be set to two different values
    
        - nfs4_unique_id = ${machine-id} will use /etc/machine-id
            as the unique id.
        - nfs4_unique_id = ${hostname} will use the system's hostname
            as the unique id.

    * The new nfs-config systemd service need to be enabled for the
      /etc/modprobe.d/nfs.conf file to be created with 
      the "options nfs nfs4_unique_id=" set. 
  
I see this patch set is not a way to set the nfs4_unique_id 
module parameter... I see it as a beginning of a way to set 
all module parameters from /etc/nfs.conf, which I think
is a good thing... 

[1] https://www.spinics.net/lists/linux-nfs/msg78658.html

Alice Mitchell (3):
  nfs-utils: Enable the retrieval of raw config settings without
    expansion
  nfs-utils: Add support for further ${variable} expansions in nfs.conf
  nfs-utils: Update nfs4_unique_id module parameter from the nfs.conf
    value

 configure.ac                  |   1 +
 nfs.conf                      |   4 +-
 support/include/conffile.h    |   1 +
 support/nfs/conffile.c        | 283 ++++++++++++++++++++++++++++++++--
 systemd/Makefile.am           |   3 +
 systemd/nfs-client.target     |   3 +
 systemd/nfs-conf-export.sh    |  28 ++++
 systemd/nfs-config.service.in |  18 +++
 systemd/nfs.conf.man          |  19 ++-
 tools/nfsconf/nfsconf.man     |  10 +-
 tools/nfsconf/nfsconfcli.c    |  22 ++-
 11 files changed, 372 insertions(+), 20 deletions(-)
 create mode 100755 systemd/nfs-conf-export.sh
 create mode 100644 systemd/nfs-config.service.in

-- 
2.30.2

