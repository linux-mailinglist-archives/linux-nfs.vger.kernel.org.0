Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D936F603
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Apr 2021 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhD3G46 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Apr 2021 02:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229638AbhD3G46 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Apr 2021 02:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619765770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hUytt9bgys3mcT1YIQqkYuIX5CCUBxZeon13iyJuvDM=;
        b=JuxtnzLeLsmTvJNYWxFFKTgti1jixUtgAsUyUU2QmsPzPKUQZYX9OKvEtQG/Pf8tQrss5S
        NL/x2+L+7lLfXP74lnPht2VSh4yb0P3cmngxZ+7ZApsPLQJcqLVUx1lIERkgfpVWIvfu95
        smSGs3di3KmGwViyTQo0P1HpHz4sT60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-ZVbMKgc7N0CECQduFHqs3Q-1; Fri, 30 Apr 2021 02:56:07 -0400
X-MC-Unique: ZVbMKgc7N0CECQduFHqs3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AF7E107ACCA
        for <linux-nfs@vger.kernel.org>; Fri, 30 Apr 2021 06:56:06 +0000 (UTC)
Received: from localhost (unknown [10.66.61.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 054641B46B;
        Fri, 30 Apr 2021 06:56:05 +0000 (UTC)
From:   Yongcheng Yang <yoyang@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        Yongcheng Yang <yoyang@redhat.com>,
        Petr Pisar <ppisar@redhat.com>
Subject: [PATCH] systemd: nfs-server.service add "Wants" dependency on rpc-rquotad.service
Date:   Fri, 30 Apr 2021 14:56:01 +0800
Message-Id: <20210430065601.16523-1-yoyang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The RPC quota service was part of nfs-utils and started together
with nfs-server before it was splitting out from nfs-utils.

It would be convenient to preserve the behavior: Let nfs-server
start rpc-rquotad automatically.

Signed-off-by: Petr Pisar <ppisar@redhat.com>
Signed-off-by: Yongcheng Yang <yoyang@redhat.com>
---
Hi,

The rpc-rquotad.service contains "WantedBy=nfs-server.service" but it only
takes effect after "systemctl enable rpc-rquotad":

"A symbolic link is created in the .wants/ directory of each of the listed
units when this unit is installed by systemctl enable"

This is different with the previous behavior when it's not splitted.

Test logs:
~~~~~~~~~~
[root@rhel-latest ~]# systemctl is-enabled rpc-rquotad
disabled
[root@rhel-latest ~]# systemctl start nfs-server
[root@rhel-latest ~]# systemctl status rpc-rquotad
* rpc-rquotad.service - Remote quota server
   Loaded: loaded (/usr/lib/systemd/system/rpc-rquotad.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:rpc.rquotad(8)
[root@rhel-latest ~]#
[root@rhel-latest ~]# systemctl enable rpc-rquotad
Created symlink /etc/systemd/system/multi-user.target.wants/rpc-rquotad.service -> /usr/lib/systemd/system/rpc-rquotad.service.
Created symlink /etc/systemd/system/nfs-server.service.wants/rpc-rquotad.service -> /usr/lib/systemd/system/rpc-rquotad.service.
[root@rhel-latest ~]# systemctl restart nfs-server
[root@rhel-latest ~]# systemctl status rpc-rquotad
* rpc-rquotad.service - Remote quota server
   Loaded: loaded (/usr/lib/systemd/system/rpc-rquotad.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2021-04-30 02:17:33 EDT; 6s ago
     Docs: man:rpc.rquotad(8)
 Main PID: 5821 (rpc.rquotad)
    Tasks: 1 (limit: 7971)
   Memory: 12.7M
   CGroup: /system.slice/rpc-rquotad.service
           `-5821 /usr/sbin/rpc.rquotad

Apr 30 02:17:33 rhel-latest systemd[1]: Starting Remote quota server...
Apr 30 02:17:33 rhel-latest systemd[1]: Started Remote quota server.
[root@rhel-latest ~]#

Thanks,
Yongcheng

 systemd/nfs-server.service | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index b432f910..16eca3f9 100644
--- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -3,7 +3,8 @@ Description=NFS server and services
 DefaultDependencies=no
 Requires=network.target proc-fs-nfsd.mount
 Requires=nfs-mountd.service
-Wants=rpcbind.socket network-online.target
+Wants=network-online.target
+Wants=rpcbind.socket rpc-rquotad.service
 Wants=rpc-statd.service nfs-idmapd.service
 Wants=rpc-statd-notify.service
 Wants=nfsdcld.service
-- 
2.20.1

