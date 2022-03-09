Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25EF4D38CC
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiCIS2j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiCIS2j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:39 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F731206
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:39 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so3892091oos.9
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lxP5JjR6l+J0pR2HXGGt6Vf+g3lu5RyaQf5yPz3l42M=;
        b=eUR+HKD3tN+o4Q2HYS/wywAVDowVo6phftAAAPW06RfI8+VXqiq0wnKXkO8Q3R7PN1
         dmMfXvAOdKOBJZucVHe99Ptx+Imdt7biO45PLdSj8E8VvZJKe2mUPqTXtAUbPEjh+pJr
         amyJWKliejhGW/TtIoD4f3KR45eFy9BlUU4ROeG1EUVwBtlZWzlE3lVRb7h3f/FSTAbx
         7j95KO+pQwp5TKX30tFV0v5oc2EZ/w2pqbov2NfNGYjXgk47aPsCA2EnDY4BOdRWQyoM
         4EsLa0vk/wjCJBf0pT1xtr+imdb1bxnt5hGEIH94jRnxaXba5Iwmx0UU9EgWZwy++lpZ
         2k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lxP5JjR6l+J0pR2HXGGt6Vf+g3lu5RyaQf5yPz3l42M=;
        b=Z3Xy+CBcl2ZRcPLUxI2e24PPpPcCINqJcBC7uPyYwKvEU1pyawmTh/uGzYXg28Y0K1
         b858WqYolNZElKlWta7r8OqLMXQHNx0kBS4vslhOxUsa7qr2IvXQKH+RMx2C5ikFTs8h
         QoiKjVV6wfE1FBzKQsWOJKxRRoIWBdji97CF28FdPMwNZgNikP31YaQkOQ/eKn87MwO9
         tySUvcS00az+13R7b+MGg5wkrx/CX5Ysek/QaaUuesNfQWIq4qlj7ZJMpDh4dKz80jN0
         BNCwdpNKnjG5W9xmCp/UtQlazZplpIuIeK2EDgbqPObqkcO5by626NAAQXQZz0NmE2mG
         MuMg==
X-Gm-Message-State: AOAM533yL25Qg3yDsevwlpc7h9JZd7YJTQJQXAGMHOREs3PfAOqjk9DU
        4d9VWFvOXLK7yvF6QQbUZq/Iy0nWeKQ=
X-Google-Smtp-Source: ABdhPJw7/qzKIEHAuw6IaYTInUDhsMXZCmK5ZViM9uLAQ7Hm5G6d/dImuNh/LzEOoZKFOcIRcT3zKQ==
X-Received: by 2002:a05:6870:6189:b0:d9:aea4:a63 with SMTP id a9-20020a056870618900b000d9aea40a63mr462207oah.154.1646850458782;
        Wed, 09 Mar 2022 10:27:38 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:38 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 7/7] readahead: documentation
Date:   Wed,  9 Mar 2022 15:26:53 -0300
Message-Id: <20220309182653.1885252-8-trbecker@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309182653.1885252-1-trbecker@gmail.com>
References: <20220309182653.1885252-1-trbecker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 tools/nfs-readahead-udev/Makefile.am          |  2 +
 .../nfs-readahead-udev/nfs-readahead-udev.man | 47 +++++++++++++++++++
 tools/nfs-readahead-udev/readahead.conf       | 14 ++++++
 3 files changed, 63 insertions(+)
 create mode 100644 tools/nfs-readahead-udev/nfs-readahead-udev.man

diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
index 010350aa..eaa9b90e 100644
--- a/tools/nfs-readahead-udev/Makefile.am
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -10,6 +10,8 @@ udev_rules_DATA = 99-nfs_bdi.rules
 ra_confdir = $(sysconfdir)
 ra_conf_DATA = readahead.conf
 
+man5_MANS = nfs-readahead-udev.man
+
 99-nfs_bdi.rules: 99-nfs_bdi.rules.in $(builddefs)
 	$(SED) "s|_libexecdir_|@libexecdir@|g" 99-nfs_bdi.rules.in > $@
 
diff --git a/tools/nfs-readahead-udev/nfs-readahead-udev.man b/tools/nfs-readahead-udev/nfs-readahead-udev.man
new file mode 100644
index 00000000..2477d5b3
--- /dev/null
+++ b/tools/nfs-readahead-udev/nfs-readahead-udev.man
@@ -0,0 +1,47 @@
+.\" Manpage for nfs-readahead-udev.
+.nh
+.ad l
+.TH man 5 "08 Mar 2022" "1.0" "nfs-readahead-udev man page"
+.SH NAME
+
+nfs-readahead-udev \- Find the readahead for a given NFS mount
+
+.SH SYNOPSIS
+
+nfs-readahead-udev <device>
+
+.SH DESCRIPTION
+
+\fInfs-readahead-udev\fR is a tool intended to be used with udev to set the \fIread_ahead_kb\fR parameter of NFS mounts, according to the configuration file (see \fICONFIGURATION\fR). \fIdevice\fR is the device number for the NFS backing device as provided by the kernel.
+
+.SH CONFIGURATION
+
+The configuration file (\fI/etc/readahead.conf\fR) contains the readahead configuration, and is formatted as follows.
+
+<LINES> ::= <LINES> <LINE> | <LINE>
+
+<LINE> ::= <TOKENS> <ENDL>
+
+<TOKENS> ::= <TOKENS> <TOKEN> | <TOKEN>
+
+<TOKEN> ::= default | <PAIR>
+
+<PAIR> ::= mountpoint = <mountpoint> | fstype = <nfs|nfs4> | readahead = <readahead>
+
+\fImountpoint\fR is the path in the system where the file system is mounted.
+
+\fIreadahead\fR is an integer to readahead.
+
+\fIfstype\fR is either \fInfs\fR or \fInfs4\fR. 
+
+.SH SEE ALSO
+
+mount.nfs(8), nfs(5), udev(7), bcc-readahead(8)
+
+.SH BUGS
+
+No known bugs.
+
+.SH AUTHOR
+
+Thiago Rafael Becker <trbecker@gmail.com>
diff --git a/tools/nfs-readahead-udev/readahead.conf b/tools/nfs-readahead-udev/readahead.conf
index 988b30c7..bce830f1 100644
--- a/tools/nfs-readahead-udev/readahead.conf
+++ b/tools/nfs-readahead-udev/readahead.conf
@@ -1 +1,15 @@
+# nfs-readahead-udev configuration file.
+#
+# This file configures the readahead for nfs mounts when those are anounced by the kernel.
+# The file is composed on lines that can contain either the default configuration (applied to
+# any nfs mount that does not match any of the other lines) or a combination of
+#   mountpoint=<mountpoint> where mountpoint is the mount point for the file system
+#   fstype=<nfs|nfs4> specifies that this configuration should only apply to a specific nfs
+#     version.
+# Every line must contain a readahead option, with the expected readahead value.
 default				readahead=128
+
+# mountpoint=/mnt		readahead=4194304
+# fstype=nfs			readahead=4194304
+# fstype=nfs4			readahead=4194304
+# mountpoint=/mnt	fstype=nfs4	readahead=4194304
-- 
2.35.1

