Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA723222447
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGPNvV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 09:51:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23753 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgGPNvV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 09:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594907480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UDj+9fulZHXd9VmHeYehdUKXLftXppq63h1HG/p3EFE=;
        b=IXZIgcjZJR1kN0Q2GmbUvcsrMMXNbUmKdSg7aYBy8K9CQeKIS0YicenSa2qB3w0HdjR/GP
        h3Lb650AT6CLg9+RkJQMQK9/0CcYfpVevBgZNVubYAvKjRBttNGnDahybe4yfnc75lMJEm
        mcbNpm/hRLuzEpr4qUF7niNR9G5JCFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-TCmHRMHAPCqVeJb-_MHmsg-1; Thu, 16 Jul 2020 09:51:18 -0400
X-MC-Unique: TCmHRMHAPCqVeJb-_MHmsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BD321888AA0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jul 2020 13:51:17 +0000 (UTC)
Received: from ovpn-112-45.ams2.redhat.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFE85100164C;
        Thu, 16 Jul 2020 13:51:16 +0000 (UTC)
Message-ID: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
Subject: [PATCH v2 0/4] nfs-utils: nfs.conf features to enable use of
 machine-id as nfs4_unique_id
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     Steve Dickson <steved@redhat.com>
Date:   Thu, 16 Jul 2020 14:51:15 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch set introduces some additional features to the nfs.conf tool
chain that allows automatic use of /etc/machine-id or other unique
values for setups that otherwise do not have a unique hostname or disk
image and would thus otherwise generate non-unique EXCHANGE_ID and
SETCLIENTID messages. 

v2 Added man page and documentation updates.

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>

---

Alice Mitchell (4):
  Factor out common structure cleanup calls
  Enable the retrieval of raw config settings without expansion
  Add support for futher ${variable} expansions in nfs.conf
  Update nfs4_unique_id module parameter from the nfs.conf value

 nfs.conf                      |   1 +
 support/include/conffile.h    |   1 +
 support/nfs/conffile.c        | 375 +++++++++++++++++++++++++++++-----
 systemd/Makefile.am           |   3 +
 systemd/README                |   5 +
 systemd/nfs-conf-export.sh    |  28 +++
 systemd/nfs-config.service.in |  17 ++
 systemd/nfs.conf.man          |  60 +++++-
 tools/nfsconf/nfsconf.man     |  17 +-
 tools/nfsconf/nfsconfcli.c    |  22 +-
 10 files changed, 458 insertions(+), 71 deletions(-)
 create mode 100755 systemd/nfs-conf-export.sh
 create mode 100644 systemd/nfs-config.service.in

-- 
2.18.1


