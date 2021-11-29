Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0646207B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 20:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhK2Tcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 14:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhK2Tax (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 14:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638214055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YbEkcOsJzMQhAPcvuHw+gEfFNv0crTf/R4YcIBXiaQA=;
        b=W8aMdjhsbbHcMwBUTxaQhkc9NOq/K/mXo92htPXFMNTtFwF6aaRctjhPVa78otzg87PPxD
        iuyYTCW5bJHZNXRmohUi/oYwOkMLlGYwlJe0ZqjklH6p4cXU58RPBkpJgahqw48KyQAjM4
        VwLSCTLcgytIxDKqDX0YFMIZdPmUcU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-dLMkS7LMNgqf5eYInHAuxA-1; Mon, 29 Nov 2021 14:27:33 -0500
X-MC-Unique: dLMkS7LMNgqf5eYInHAuxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A89E384E256
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 19:27:32 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-112-138.phx2.redhat.com [10.3.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F4E79452
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 19:27:32 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH RFC 0/3] Remove NFS v2 support from the client and server
Date:   Mon, 29 Nov 2021 14:27:28 -0500
Message-Id: <20211129192731.783466-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

So I just decided to make all V2 mounts fail with
EOPNOTSUPP, with no way of turn them back on.

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
 utils/mount/stropts.c     |  3 +++
 utils/nfsd/nfsd.c         |  2 --
 utils/nfsd/nfsd.man       |  4 ++--
 9 files changed, 13 insertions(+), 27 deletions(-)

-- 
2.31.1

