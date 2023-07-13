Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BE751ECC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjGMKZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGMKZ6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 06:25:58 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1736119
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qEpDI2Uc2raMZ2D2F7tT4zVoMEFSYHX/nT6GHyE0nEk=; b=dpcVmWFx0DsH59sZxJcCTqZtOK
        TsZqsbu9JcOw6bdfJkcBkI3MpwGt3FWcZG5izNCbY7pAZO/LrMJFQ4PCK5JV7NrazErzqDlMlejX1
        elj1MkFFah239sW0bTgi1w89PallJXUe0W819RKHT82XzcP1caf45cST8wCZZBVuC7taT2EK0ux7H
        31KVy+kTNwTHJXXli9ji8LrdmEi7osf5++usyJFoIJBSU/agtjKoEVkCfDwsgPRqKVAsubBTQXWcv
        wQOjQXGpZDP3RoGDSw9JURFLN4OpilY6nskq7l86UL0dR4IvFUZs9Gy+lcIcPLfTYyaMMVrObLJMY
        b4Mi4J3A==;
Received: from [192.168.12.109] (helo=zeus.local)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qJtWD-00DhAx-Pb; Thu, 13 Jul 2023 12:25:53 +0200
Received: from berto by zeus.local with local (Exim 4.96)
        (envelope-from <berto@igalia.com>)
        id 1qJtWD-000Y6c-24;
        Thu, 13 Jul 2023 12:25:53 +0200
From:   Alberto Garcia <berto@igalia.com>
To:     linux-nfs@vger.kernel.org
Cc:     Alberto Garcia <berto@igalia.com>
Subject: [PATCH] systemd: Ensure that statdpath exists using systemd-tmpfiles
Date:   Thu, 13 Jul 2023 12:25:31 +0200
Message-Id: <20230713102531.131072-1-berto@igalia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFS utils store their state under /var/lib/nfs and they can
generally handle the case where that directory is missing by creating
the appropriate files and directories automatically.

This is not the case of rpc-statd: if sm and sm.bak (under $statdpath,
which also defaults to /var/lib/nfs) are missing the daemon will
refuse to start and will exit with an error.

If nfs-utils is configured with systemd support it can take advantage
of systemd-tmpfiles to ensure that the state directories are always
present and have the appropriate ownership.

This would normally be handled with the StateDirectory directive in
rpc-statd.service, however that method would not be able to change the
ownership of the directories to $statduser because this daemon needs
to be run as root, and only later changes its uid and gid.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 configure.ac              | 1 +
 systemd/Makefile.am       | 5 +++++
 systemd/nfs-utils.conf.in | 4 ++++
 3 files changed, 10 insertions(+)
 create mode 100644 systemd/nfs-utils.conf.in

diff --git a/configure.ac b/configure.ac
index 6fbcb974..fe958ab3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -695,6 +695,7 @@ AC_CONFIG_COMMANDS_PRE([eval eval _rpc_pipefsmount=$rpc_pipefsmount])
 
 AC_CONFIG_FILES([
 	Makefile
+	systemd/nfs-utils.conf
 	systemd/rpc-gssd.service
 	systemd/rpc_pipefs.target
 	systemd/var-lib-nfs-rpc_pipefs.mount
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index b4483222..6127986e 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -5,6 +5,9 @@ MAINTAINERCLEANFILES = Makefile.in
 udev_rulesdir = /usr/lib/udev/rules.d/
 udev_files = 60-nfs.rules
 
+sdtmpfilesdir = /usr/lib/tmpfiles.d/
+sdtmpfiles_files = nfs-utils.conf
+
 unit_files =  \
     nfs-client.target \
     rpc_pipefs.target \
@@ -85,4 +88,6 @@ install-data-hook: $(unit_files) $(udev_files)
 	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
 	mkdir -p $(DESTDIR)/$(udev_rulesdir)
 	cp $(udev_files) $(DESTDIR)/$(udev_rulesdir)
+	mkdir -p $(DESTDIR)/$(sdtmpfilesdir)
+	cp $(sdtmpfiles_files) $(DESTDIR)/$(sdtmpfilesdir)
 endif
diff --git a/systemd/nfs-utils.conf.in b/systemd/nfs-utils.conf.in
new file mode 100644
index 00000000..a44c337e
--- /dev/null
+++ b/systemd/nfs-utils.conf.in
@@ -0,0 +1,4 @@
+# This is a systemd-tmpfiles configuration file
+# type path			mode	uid	gid	age	argument
+d      @statdpath@/sm		0700	@statduser@	:root	-       -
+d      @statdpath@/sm.bak	0700	@statduser@	:root	-	-
-- 
2.39.2

