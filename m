Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF946D836
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhLHQec (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:34:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhLHQec (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638981060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H0+CaiFBqQo4KDbPwA8rgfBsf87FuBnVYTHdgssuYDU=;
        b=fLxqg1Wr3woZ6vxqEuivdq57CFESRKaK5zRGVWF6m9gMSP4WOWz7wRAOIEvCr9ZPsKVuuG
        2rAXyx5McfhVzLv2n0GF9awH5gq8QU1fD5wntON5crDA6HWBbG5PeBBGllno6Kttbn0odd
        wbEQoYZqlfejgjLj7Jdt07AcqAzpNUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-KReA7qj3M5Gq0rU1CEtejA-1; Wed, 08 Dec 2021 11:30:59 -0500
X-MC-Unique: KReA7qj3M5Gq0rU1CEtejA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30E0381E245
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:58 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.2.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9A2B45D76
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:57 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH v2 0/3]  Remove NFS v2 support from the client and server
Date:   Wed,  8 Dec 2021 11:30:54 -0500
Message-Id: <20211208163057.954500-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches will remove the all references and 
support of NFS v2 in both the server and client.

On server side the support has been off, by default, 
since 2013 (6b4e4965a6b). With this server patch the
ability to enable v2 will be remove.

Currently even with CONFIG_NFS_V2 not set
v2 mounts are still tied (over-the-wire). I looked at creating 
a kernel parameter module so support could re-enabled 
but that got ugly quick.

On the client, the -o v2 option is still a 
valid option because unknown mount options 
are passed to the kernel which will cause an 
actual mount to happen. 

But the option has been removed from the man
pages will cause the mount to fail with
"NFS version is not supported"

I guess the only question left is does there
need some type compilation flag or config flag
that would re-enable the support. I'm thinking not.

Steve Dickson (3):
  nfsd: Remove the ability to enable NFS v2.
  nfs.man: Remove references to NFS v2 from the man pages
  mount: Remove NFS v2 support from mount.nfs

 nfs.conf                  |  1 -
 utils/mount/configfile.c  |  2 +-
 utils/mount/mount.nfs.man |  2 +-
 utils/mount/network.c     |  4 ++--
 utils/mount/nfs.man       | 20 +++-----------------
 utils/mount/nfsmount.conf |  2 +-
 utils/mount/stropts.c     | 10 +++++++++-
 utils/nfsd/nfsd.c         |  2 --
 utils/nfsd/nfsd.man       |  4 ++--
 9 files changed, 19 insertions(+), 28 deletions(-)

-- 
2.31.1

