Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC7553208F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 04:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiEXCBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 22:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiEXCBp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 22:01:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6651EC4A
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 19:01:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3E421F8D6;
        Tue, 24 May 2022 02:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653357698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CjFz3c8w/NeFEBZEQ4dyBMSEmRQL/f2A4D7qKpdZysM=;
        b=vK+aBTSzJryzHr1HaXqdpi4sWv7yrRtKnjRchW+Yss7IloxrHBawrRLMSWvEt3sN13xd9u
        QdBxkubN9f3nKL0jCIOT7YoqNrcQtNY7v1LJ3yXnXwOzBrp6tkRb4h+7Vo1swNjFVvV8wt
        VZt2AngXygIzuekqrpnf4xBEFXu7l0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653357698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CjFz3c8w/NeFEBZEQ4dyBMSEmRQL/f2A4D7qKpdZysM=;
        b=E0PsyOhDTezRmvp4+1rL3c6/ilOJldoN/g+UxxRVNAAEsVVmpIXkMlxmwP0+QPgwkK+Uok
        xnDg3bRkz2XjmDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E33F013487;
        Tue, 24 May 2022 02:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i2ItKIE8jGKQYwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 24 May 2022 02:01:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] Apply all sysctl settings when NFS-related modules
 are loaded.
Date:   Tue, 24 May 2022 12:01:34 +1000
Message-id: <165335769457.22265.5383162992195478413@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


sysctl settings (e.g.  /etc/sysctl.conf and others) are normally loaded
once at boot.  If the module that implements some settings is no yet
loaded, those settings don't get applied.

Various NFS modules support various sysctl settings.  If they are loaded
after boot, they miss out.

So add commands to modprobe.d/50-nfs.conf to apply the relevant settings
when the module is loaded.

I have placed this in the "systemd" directory because it seemed the
least bad choice.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 systemd/50-nfs.conf | 16 ++++++++++++++++
 systemd/Makefile.am | 10 ++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 systemd/50-nfs.conf

diff --git a/systemd/50-nfs.conf b/systemd/50-nfs.conf
new file mode 100644
index 000000000000..b56b2d765969
--- /dev/null
+++ b/systemd/50-nfs.conf
@@ -0,0 +1,16 @@
+# Ensure all NFS systctl settings get applied when modules load
+
+# sunrpc module supports "sunrpc.*" sysctls
+install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && /sbin=
/sysctl -q --pattern sunrpc --system
+
+# rpcrdma module supports sunrpc.svc_rdma.*
+install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && /sb=
in/sysctl -q --pattern sunrpc.svc_rdma --system
+
+# lockd module supports "fs.nfs.nlm*" and "fs.nfs.nsm*" sysctls
+install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && /sbin/s=
ysctl -q --pattern fs.nfs.n[sl]m --system
+
+# nfsv4 module supports "fs.nfs.*" sysctls (nfs_callback_tcpport and idmap_c=
ache_timeout)
+install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && /sbin/s=
ysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --syst=
em
+
+# nfs module supports "fs.nfs.*" sysctls
+install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && /sbin/sysct=
l -q --pattern fs.nfs --system
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index e7f5d818a913..63a50bf2c07e 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -2,6 +2,8 @@
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
+modprobe_files =3D 50-nfs.conf
+
 unit_files =3D  \
     nfs-client.target \
     rpc_pipefs.target \
@@ -51,7 +53,7 @@ endif
=20
 man5_MANS	=3D nfs.conf.man
 man7_MANS	=3D nfs.systemd.man
-EXTRA_DIST =3D $(unit_files) $(man5_MANS) $(man7_MANS)
+EXTRA_DIST =3D $(unit_files) $(modprobe_files) $(man5_MANS) $(man7_MANS)
=20
 generator_dir =3D $(unitdir)/../system-generators
=20
@@ -73,8 +75,12 @@ rpc_pipefs_generator_LDADD =3D ../support/nfs/libnfs.la
=20
 if INSTALL_SYSTEMD
 genexec_PROGRAMS =3D nfs-server-generator rpc-pipefs-generator
-install-data-hook: $(unit_files)
+install-data-hook: $(unit_files) $(modprobe_files)
 	mkdir -p $(DESTDIR)/$(unitdir)
 	cp $(unit_files) $(DESTDIR)/$(unitdir)
 	cp $(rpc_pipefs_mount_file) $(DESTDIR)/$(unitdir)/$(rpc_pipefsmount)
+else
+install-data-hook: $(modprobe_files)
 endif
+	mkdir -p $(DESTDIR)/usr/lib/modprobe.d
+	cp $(modprobe_files) $(DESTDIR)/usr/lib/modprobe.d/
--=20
2.36.1

