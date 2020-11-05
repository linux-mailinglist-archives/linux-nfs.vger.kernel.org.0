Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE22A81A7
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgKEO4r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 09:56:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730721AbgKEO4r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 09:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604588206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xr7KbYlMV4SPjngLdBH4fJIXTlCFH83h5CqogNUd7HQ=;
        b=e/sRdDYOWeiCbeCmzilJIMoP3eONTnx9q834tBRIsBB/V03GWymWB75vOVt3hsd0rnjVqM
        Dq0xanJLG+teg6YOIYib/AN3c/Kw3pgOyMeH8WOROYZ1lOKxkWNudORm+6h4nVq2EaRPVj
        9DDGrR3ct9yKR4ibypo50CklzJUyuHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-eJS_-2iPNsGWS7l8Q6G_yA-1; Thu, 05 Nov 2020 09:56:45 -0500
X-MC-Unique: eJS_-2iPNsGWS7l8Q6G_yA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383038DF0A3
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:44 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-68.phx2.redhat.com [10.3.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED3D15D9D5
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:43 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/3] manpage: Update nfs.conf and nfsmount.conf manpages
Date:   Thu,  5 Nov 2020 09:56:34 -0500
Message-Id: <20201105145634.98281-4-steved@redhat.com>
In-Reply-To: <20201105145634.98281-1-steved@redhat.com>
References: <20201105145634.98281-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update the man pages to explain how the config.d
directories will be use.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/nfs.conf.man          | 8 ++++++++
 utils/mount/nfsmount.conf.man | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 3f1c726..16e0ec4 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -265,7 +265,15 @@ Only
 is recognized.
 
 .SH FILES
+.TP 10n
 .I /etc/nfs.conf
+Default NFS client configuration file
+.TP 10n
+.I /etc/nfs.conf.d
+When this directory exists and files ending 
+with ".conf" exist, those files will be
+used to set configuration variables. These
+files will override variables set in /etc/nfs.conf
 .SH SEE ALSO
 .BR nfsdcltrack (8),
 .BR rpc.nfsd (8),
diff --git a/utils/mount/nfsmount.conf.man b/utils/mount/nfsmount.conf.man
index 3aa3456..4f8f351 100644
--- a/utils/mount/nfsmount.conf.man
+++ b/utils/mount/nfsmount.conf.man
@@ -88,6 +88,13 @@ the background (i.e. done asynchronously).
 .TP 10n
 .I /etc/nfsmount.conf
 Default NFS mount configuration file
+.TP 10n
+.I /etc/nfsmount.conf.d
+When this directory exists and files ending 
+with ".conf" exist, those files will be
+used to set configuration variables. These
+files will override variables set 
+in /etc/nfsmount.conf
 .PD
 .SH SEE ALSO
 .BR nfs (5),
-- 
2.26.2

