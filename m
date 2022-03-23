Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC97B4E59C5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Mar 2022 21:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbiCWUUz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Mar 2022 16:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiCWUUy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Mar 2022 16:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA7B41F608
        for <linux-nfs@vger.kernel.org>; Wed, 23 Mar 2022 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648066763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4WjIFYPYYr7HjXVjEDRv4oz08cl5gveTsATjw52Amg=;
        b=F0J4XMqmc/DhbMlgjbJNTD4OoX/d19LtJY5wWvoc945ZxaI8ucQ2skX8BX8krJiOay55D1
        tUkAje1xW+ZM73UhLgJ1dII2KjTcwASmSGoX9N063Kwtj1MusOpJgVN40KCI+DGb/xdZer
        zYbNGFIqtMdcaliETjv7/Ff5IT8/qoA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-8TutiKXLMk-fcC3WlvWycA-1; Wed, 23 Mar 2022 16:19:20 -0400
X-MC-Unique: 8TutiKXLMk-fcC3WlvWycA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2799729ABA28;
        Wed, 23 Mar 2022 20:19:20 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-121.gru2.redhat.com [10.97.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A42F1401E24;
        Wed, 23 Mar 2022 20:19:16 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [PATCH RFC v3 6/6] nfsrahead: User documentation
Date:   Wed, 23 Mar 2022 17:18:41 -0300
Message-Id: <20220323201841.4166549-7-tbecker@redhat.com>
In-Reply-To: <20220323201841.4166549-1-tbecker@redhat.com>
References: <20220323201841.4166549-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add the man page for nfsrahead, and add the new section to nfs.conf.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 systemd/nfs.conf.man          | 11 ++++++
 tools/nfsrahead/Makefile.am   |  2 +
 tools/nfsrahead/nfsrahead.man | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 tools/nfsrahead/nfsrahead.man

diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index be487a11..e74083e9 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -294,6 +294,17 @@ Only
 .B debug=
 is recognized.
 
+.TP
+.B nfsrahead
+Recognized values:
+.BR nfs ,
+.BR nfsv4 ,
+.BR default .
+
+See
+.BR nfsrahead (5)
+for deatils.
+
 .SH FILES
 .TP 10n
 .I /etc/nfs.conf
diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index d0b5d170..7342dcba 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -3,6 +3,8 @@ nfsrahead_SOURCES = main.c
 nfsrahead_LDFLAGS= -lmount
 nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
 
+man5_MANS = nfsrahead.man
+
 udev_rulesdir = /etc/udev/rules.d
 udev_rules_DATA = 99-nfs_bdi.rules
 
diff --git a/tools/nfsrahead/nfsrahead.man b/tools/nfsrahead/nfsrahead.man
new file mode 100644
index 00000000..5488f633
--- /dev/null
+++ b/tools/nfsrahead/nfsrahead.man
@@ -0,0 +1,72 @@
+.\" Manpage for nfsrahead.
+.nh
+.ad l
+.TH man 5 "08 Mar 2022" "1.0" "nfsrahead man page"
+.SH NAME
+
+nfsrahead \- Configure the readahead for NFS mounts
+
+.SH SYNOPSIS
+
+nfsrahead [-F] [-d] <device>
+
+.SH DESCRIPTION
+
+\fInfsrahead\fR is a tool intended to be used with udev to set the \fIread_ahead_kb\fR parameter of NFS mounts, according to the configuration file (see \fICONFIGURATION\fR). \fIdevice\fR is the device number for the NFS backing device as provided by the kernel.
+
+.SH OPTIONS
+.TP
+.B -F
+Send messages to 
+.I stderr 
+instead of
+.I syslog
+
+.TP
+.B -d
+Increase the debugging level.
+
+.SH CONFIGURATION
+.I nfsrahead
+is configured in
+.IR /etc/nfs.conf ,
+in the section titled
+.IR nfsrahead .
+It accepts the following configurations.
+
+.TP
+.B nfs=<value>
+The readahead value applied to NFSv3 mounts.
+
+.TP
+.B nfs4=<value>
+The readahead value applied to NFSv4 mounts.
+
+.TP
+.B default=<value>
+The default configuration when none of the configurations above is set.
+
+.SH EXAMPLE CONFIGURATION
+[nfsrahead]
+.br
+nfs=15000              # readahead of 15000 for NFSv3 mounts
+.br
+nfs4=16000             # readahead of 16000 for NFSv4 mounts
+.br
+default=128            # default is 128
+
+.SH SEE ALSO
+
+.BR mount.nfs (8),
+.BR nfs (5),
+.BR nfs.conf (5),
+.BR udev (7),
+.BR bcc-readahead (8)
+
+.SH BUGS
+
+No known bugs.
+
+.SH AUTHOR
+
+Thiago Rafael Becker <trbecker@gmail.com>
-- 
2.35.1

