Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199A546D838
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhLHQed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:34:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236960AbhLHQed (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638981060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bIx0Q3iBNKWJj2cLrtduTOqXLir4GsCceMH1L6xJFY=;
        b=efupJbIKgCN4Buhw28bob6R2n2SHAemKDsEmxZN7pZRB5gvqnZzCuHS+wyPzFgjKu85j6W
        CGKMXnQxKSI6RohCKEj9cuvaq5SnNUosWssigupHnmAdC0gB8FM1qPgNZvMu3VrpsceXh1
        4aOHnb5IasEInJizTzxwS556U6Nbc8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-j-tEjJLTMwKdIQ-vXRT0xg-1; Wed, 08 Dec 2021 11:30:59 -0500
X-MC-Unique: j-tEjJLTMwKdIQ-vXRT0xg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A883481E238
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:58 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.2.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1752B178
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:58 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/3] nfsd: Remove the ability to enable NFS v2.
Date:   Wed,  8 Dec 2021 11:30:55 -0500
Message-Id: <20211208163057.954500-2-steved@redhat.com>
In-Reply-To: <20211208163057.954500-1-steved@redhat.com>
References: <20211208163057.954500-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs.conf            | 1 -
 utils/nfsd/nfsd.c   | 2 --
 utils/nfsd/nfsd.man | 4 ++--
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 8c714ff7..21d3e7b2 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -68,7 +68,6 @@
 # lease-time=90
 # udp=n
 # tcp=y
-# vers2=n
 # vers3=y
 # vers4=y
 # vers4.0=y
diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
index b0741718..4016a761 100644
--- a/utils/nfsd/nfsd.c
+++ b/utils/nfsd/nfsd.c
@@ -226,7 +226,6 @@ main(int argc, char **argv)
 				}
 				/* FALLTHRU */
 			case 3:
-			case 2:
 				NFSCTL_VERUNSET(versbits, c);
 				break;
 			default:
@@ -251,7 +250,6 @@ main(int argc, char **argv)
 					minorvers = minorversset = minormask;
 				/* FALLTHRU */
 			case 3:
-			case 2:
 				NFSCTL_VERSET(versbits, c);
 				break;
 			default:
diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
index 2701ba78..716f538b 100644
--- a/utils/nfsd/nfsd.man
+++ b/utils/nfsd/nfsd.man
@@ -57,7 +57,7 @@ This option can be used to request that
 .B rpc.nfsd
 does not offer certain versions of NFS. The current version of
 .B rpc.nfsd
-can support major NFS versions 2,3,4 and the minor versions 4.0, 4.1 and 4.2.
+can support major NFS versions 3,4 and the minor versions 4.0, 4.1 and 4.2.
 .TP
 .B \-s " or " \-\-syslog
 By default,
@@ -84,7 +84,7 @@ This option can be used to request that
 .B rpc.nfsd
 offer certain versions of NFS. The current version of
 .B rpc.nfsd
-can support major NFS versions 2,3,4 and the minor versions 4.0, 4.1 and 4.2.
+can support major NFS versions 3,4 and the minor versions 4.0, 4.1 and 4.2.
 .TP
 .B \-L " or " \-\-lease-time seconds
 Set the lease-time used for NFSv4.  This corresponds to how often
-- 
2.31.1

