Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD828C988
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Oct 2020 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390405AbgJMHq3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Oct 2020 03:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390404AbgJMHq3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Oct 2020 03:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602575187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=NJOvFVZgrH0MpuJsjXa6Yrjzs7iCoXs/ppoHGbwLOt8=;
        b=RdcRfAbt+h1J9UlbMB+LsUUrTr0Siv4prlSz/W/xNP3fYFFvpA1CffoI2fSIgz+eHGKlcN
        Ur6MRitWPqbxKvie5hmMhZqBIM5kshJebzhhm7Iio/PcINUhDQkA3HzxScNV5vKZkYkAxJ
        pTV9tSEo0QWCappnTeQ+ARerNiGgwUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-WY8SnqwbNn2K7CHRQpD6wA-1; Tue, 13 Oct 2020 03:46:25 -0400
X-MC-Unique: WY8SnqwbNn2K7CHRQpD6wA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FF06835B8D
        for <linux-nfs@vger.kernel.org>; Tue, 13 Oct 2020 07:46:24 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 694FB76643
        for <linux-nfs@vger.kernel.org>; Tue, 13 Oct 2020 07:46:24 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5FC831832FC1;
        Tue, 13 Oct 2020 07:46:24 +0000 (UTC)
Date:   Tue, 13 Oct 2020 03:46:24 -0400 (EDT)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Red Hat INTERNAL-ONLY kernel discussion list 
        <rhkernel-list@redhat.com>
Message-ID: <200195397.3817648.1602575184327.JavaMail.zimbra@redhat.com>
In-Reply-To: <566011876.3817284.1602574913869.JavaMail.zimbra@redhat.com>
Subject: Help with config change for CIFS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.54.103, 10.4.195.15]
Thread-Topic: Help with config change for CIFS
Thread-Index: lESGCTfFCuYlGcaG6ipMbBUn7Wj2FA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi List,

I have some issues with a config change can not find what else I need to do to fix this.

I tried to enable RDMA support in the cifs client, by simply doing :
diff --git a/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT b/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
index 849bffb38ecd..88e746ddab11 100644
--- a/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
+++ b/redhat/configs/generic/CONFIG_CIFS_SMB_DIRECT
@@ -1 +1 @@
-# CONFIG_CIFS_SMB_DIRECT is not set
+CONFIG_CIFS_SMB_DIRECT=y


But this fails with the brew build with:
Depmod failure
+ '[' -s depmod.out ']'
+ echo 'Depmod failure'
+ cat depmod.out
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_free_cq_user
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol __ib_alloc_pd
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_resolve_addr
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_dereg_mr_user
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_event_msg
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_disconnect
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_alloc_mr_user
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_resolve_route
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_create_qp
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_map_mr_sg
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol __ib_alloc_cq_any
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_destroy_qp
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_connect
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol rdma_destroy_id
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol __rdma_create_id
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_drain_qp
depmod: WARNING: /builddir/build/BUILDROOT/kernel-4.18.0-240.2.el8.rdma2.x86_64/./lib/modules/4.18.0-240.2.el8.rdma2.x86_64+debug/kernel/fs/cifs/cifs.ko needs unknown symbol ib_dealloc_pd_user
+ exit 1
RPM build errors:

These symbols should be available already in the infiniband module, so I am a little at loss.
Does anyone know what else I need to chang eto get this config change to compile in brew?

regards
ronnie sahlberg

