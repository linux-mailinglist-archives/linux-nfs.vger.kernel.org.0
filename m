Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5330B315
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 00:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBAXBw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Feb 2021 18:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhBAXBv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Feb 2021 18:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612220425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YddAvujJE0Oc3mbX/q/yNCxMSi/jA6/q0nTO+0voCyo=;
        b=IwvENExC78gPvcVCpoSCTdIHPJ9htvymq/glleHLan6rIvEYCMxUDuWTAQdQGc856+WEHF
        xliSkAD4/M2M0eklq0aVpP+/oX3Tqfn9TAikvjacQuMKr4ffjjtJICEZt0Y5qLuvcnRyy5
        3Gy0qMyUphyNHbbisAJQuVtZreNTlYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-xcqEweKzP4iFqlGxFFiU0g-1; Mon, 01 Feb 2021 18:00:23 -0500
X-MC-Unique: xcqEweKzP4iFqlGxFFiU0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2FC515720
        for <linux-nfs@vger.kernel.org>; Mon,  1 Feb 2021 23:00:22 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-114-86.phx2.redhat.com [10.3.114.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF60460BF3
        for <linux-nfs@vger.kernel.org>; Mon,  1 Feb 2021 23:00:22 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] mountd: Add debug processing from nfs.conf
Date:   Mon,  1 Feb 2021 18:01:47 -0500
Message-Id: <20210201230147.45593-2-steved@redhat.com>
In-Reply-To: <20210201230147.45593-1-steved@redhat.com>
References: <20210201230147.45593-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs.conf              | 2 +-
 utils/mountd/mountd.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/nfs.conf b/nfs.conf
index 186a5b19..9fcf1bf0 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -30,7 +30,7 @@
 # udp-port=0
 #
 [mountd]
-# debug=0
+# debug="all|auth|call|general|parse"
 # manage-gids=n
 # descriptors=0
 # port=0
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 988e51c5..a480265a 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -684,6 +684,9 @@ read_mount_conf(char **argv)
 	if (s && !state_setup_basedir(argv[0], s))
 		exit(1);
 
+	if ((s = conf_get_str("mountd", "debug")) != NULL)
+		xlog_sconfig(s, 1);
+
 	/* NOTE: following uses "nfsd" section of nfs.conf !!!! */
 	if (conf_get_bool("nfsd", "udp", NFSCTL_UDPISSET(_rpcprotobits)))
 		NFSCTL_UDPSET(_rpcprotobits);
-- 
2.29.2

