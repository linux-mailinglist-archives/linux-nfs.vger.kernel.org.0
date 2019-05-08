Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB717AB1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEHNfi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31305 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHNfi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AAC72D6E68
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:38 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14FA71724D
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:37 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 00/19] Covertity Scan: Removed resources leaks
Date:   Wed,  8 May 2019 09:35:17 -0400
Message-Id: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 08 May 2019 13:35:38 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Red Hat is now requiring covertity scans 
to be run against all RHEL 8 packages. 

These patches removed the majority of the 
resource leaks that were flagged by the scan.

Most of the leaks were in return and error
paths as well as some obvious problems like
checking the wrong point to be NULL. 

There are still a few resources leaks 
and used_after_freed being flagged but
I am thinking they false-positives 
because I just don't see the problem. 

I've tested these patches for a couple
days and they seem stable... but whenever
free()s are added... So is risk of freeing
that is still being used. Plus they will
get a good workout at the upcoming Bakeathon.

Steve Dickson (19):
  Removed resource leaks from junction/path.c
  Removed resource leaks from nfs/exports.c
  Removed a resource leak from nfs/mydaemon.c
  Removed a resource leak from nfs/rpcmisc.c
  Removed a resource leak from nfs/svc_socket.c
  Removed bad frees from nfs/xcommon.c
  Removed resource leaks from nfs/xlog.c
  Removed resource leaks from nfsidmap/libnfsidmap.c
  Removed resource leaks from nfsidmap/static.c
  Removed a resource leak from nsm/file.c
  Removed resource leaks from systemd/rpc-pipefs-generator.c
  Removed resource leaks from blkmapd/device-discovery.c
  Removed resource leaks from gssd/krb5_util.c
  Removed a resource leak from mount/configfile.c
  Removed a resource leak from mount/nfsmount.c
  Removed a resource leak from mount/stropts.c
  Removed resource leaks from mountd/cache.c
  Removed a resource leak from mountd/fsloc.c
  Removed a resource leak from nfsdcltrack/sqlite.c

 support/junction/path.c          |  6 +++++-
 support/nfs/exports.c            |  2 ++
 support/nfs/mydaemon.c           |  1 +
 support/nfs/rpcmisc.c            |  1 +
 support/nfs/svc_socket.c         |  1 +
 support/nfs/xcommon.c            | 14 ++++++++++----
 support/nfs/xlog.c               |  6 +++++-
 support/nfsidmap/libnfsidmap.c   | 10 ++++++++--
 support/nfsidmap/static.c        | 10 ++++++++++
 support/nsm/file.c               |  1 +
 systemd/rpc-pipefs-generator.c   | 10 ++++++++--
 utils/blkmapd/device-discovery.c | 22 +++++++++++++++++++++-
 utils/gssd/krb5_util.c           |  9 ++++++++-
 utils/mount/configfile.c         |  2 +-
 utils/mount/nfsmount.c           |  1 +
 utils/mount/stropts.c            |  5 ++++-
 utils/mountd/cache.c             |  5 +++--
 utils/mountd/fsloc.c             |  1 +
 utils/nfsdcltrack/sqlite.c       |  2 ++
 19 files changed, 93 insertions(+), 16 deletions(-)

-- 
2.20.1

