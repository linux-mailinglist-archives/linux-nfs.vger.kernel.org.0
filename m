Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952E87F0AAB
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 03:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjKTCyh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 21:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTCyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 21:54:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2D5129
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 18:54:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B22FD1F750;
        Mon, 20 Nov 2023 02:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700448870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2aZuR3UnzsxHas4qugGKgZw4qsOmkgWq64VLQccv5I=;
        b=V7SoWkNOl8JRYHIzmu3aXC9r1vkGpHnWkYHgixynNbe0WNRsLzLjtPXiiZK6sfo9Tfm7wI
        c76PaaV1GPZl4C0EN4iq3DDdlmAanwFqz3d/qgeczwW6mtpITGWboswWbMmHvn5BnIMldx
        Xcfg0Ji1+aQIj8FYYDcHyvVVWKJZ/fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700448870;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2aZuR3UnzsxHas4qugGKgZw4qsOmkgWq64VLQccv5I=;
        b=U0is7A2zvrzFML1llHjDKcZ4tQBYbePNTNoCdFn/PU3eHuz321SkmhReC9IkbxWcychsea
        69g7aY+BliE2uaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C777A138E3;
        Mon, 20 Nov 2023 02:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +ZGwHmXKWmXPQQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Nov 2023 02:54:29 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] conffile: allow /usr/etc to provide any config files expected in /etc
Date:   Mon, 20 Nov 2023 13:52:28 +1100
Message-ID: <20231120025354.17511-3-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120025354.17511-1-neilb@suse.de>
References: <20231120025354.17511-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 8.40
X-Spamd-Result: default: False [8.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_TWO(0.00)[2];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If any config file is configured to be in /etc, also read from /usr/etc.
This followed a growing trend of moving as much as possible out of /
and into /usr.

See https://en.opensuse.org/openSUSE:Packaging_UsrEtc

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/nfs/conffile.c         | 27 ++++++++++++++++-----------
 support/nfsidmap/idmapd.conf.5 | 15 ++++++++++++++-
 systemd/nfs.conf.man           | 23 ++++++++++++++---------
 systemd/nfs.systemd.man        | 10 +++++++++-
 utils/mount/nfsmount.conf.man  | 19 ++++++++++---------
 5 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 6b813dd95147..884eca9e6b42 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -763,19 +763,24 @@ conf_init_file(const char *conf_file)
 	if (conf_file == NULL)
 		conf_file = NFS_CONFFILE;
 
-	/*
-	 * First parse the give config file
-	 * then parse the config.conf.d directory
-	 * (if it exists)
+	/* If the config file is in /etc (normal) then check
+	 * /usr/etc first.  Also check config.conf.d for files
+	 * names *.conf.
+	 *
+	 * Content or later files always over-rides earlier
+	 * files.
 	 */
+	if (strncmp(conf_file, "/etc/", 5) == 0) {
+		char *usrconf = NULL;
+
+		asprintf(&usrconf, "/usr%s", conf_file);
+		if (usrconf) {
+			conf_load_file(usrconf);
+			conf_init_dir(usrconf);
+			free(usrconf);
+		}
+	}
 	conf_load_file(conf_file);
-
-	/*
-	 * When the same variable is set in both files
-	 * the conf.d file will override the config file.
-	 * This allows automated admin systems to
-	 * have the final say.
-	 */
 	conf_init_dir(conf_file);
 }
 
diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
index 87e39bb41ab1..58c2d97752f6 100644
--- a/support/nfsidmap/idmapd.conf.5
+++ b/support/nfsidmap/idmapd.conf.5
@@ -37,7 +37,7 @@ Configuration file for libnfsidmap.  Used by idmapd and svcgssd to map NFSv4 nam
 .SH DESCRIPTION
 The
 .B idmapd.conf
-configuration file consists of several sections, initiated by strings of the
+configuration files consists of several sections, initiated by strings of the
 form [General] and [Mapping].  Each section may contain lines of the form
 .nf
   variable = value
@@ -398,6 +398,19 @@ LDAP_base = dc=org,dc=domain
 .\" Additional sections
 .\" -------------------------------------------------------------------
 .\"
+.SH FILES
+.I /usr/etc/idmapd.conf
+.br
+.I /usr/etc/idmapd.conf.d/*.conf
+.br
+.I /etc/idmapd.conf
+.br
+.I /etc/idmapd.conf.d/*.conf
+.br
+.IP
+Files are read in the order listed.  Later settings override earlier
+settings.
+
 .SH SEE ALSO
 .BR idmapd (8)
 .BR svcgssd (8)
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 866939aa704d..d03fc8872caa 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -2,10 +2,13 @@
 .SH NAME
 nfs.conf \- general configuration for NFS daemons and tools
 .SH SYNOPSIS
+.I /usr/etc/nfs.conf
+.I /usr/etc/nfs.conf.d/
 .I /etc/nfs.conf
+.I /etc/nfs.conf.d/
 .SH DESCRIPTION
 .PP
-This file contains site-specific configuration for various NFS daemons
+These files contain site-specific configuration for various NFS daemons
 and other processes.  Most configuration can also be passed to
 processes via command line arguments, but it can be more convenient to
 have a central file.  In particular, this encourages consistent
@@ -314,15 +317,17 @@ See
 for deatils.
 
 .SH FILES
-.TP 10n
+.I /usr/etc/nfs.conf
+.br
+.I /usr/etc/nfs.conf.d/*.conf
+.br
 .I /etc/nfs.conf
-Default NFS client configuration file
-.TP 10n
-.I /etc/nfs.conf.d
-When this directory exists and files ending 
-with ".conf" exist, those files will be
-used to set configuration variables. These
-files will override variables set in /etc/nfs.conf
+.br
+.I /etc/nfs.conf.d/*.conf
+.br
+.IP
+Various configuration files read in order.  Later settings override
+earlier settings.
 .SH SEE ALSO
 .BR nfsdcltrack (8),
 .BR rpc.nfsd (8),
diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
index 46b476a662c8..df89ddd13b76 100644
--- a/systemd/nfs.systemd.man
+++ b/systemd/nfs.systemd.man
@@ -27,7 +27,9 @@ any command line arguments to daemons so as to configure their
 behavior.  In many case such configuration can be performed by making
 changes to
 .I /etc/nfs.conf
-or other configuration files.  When that is not convenient, a
+or other configuration files (see
+.BR nfs.conf (5)).
+When that is not convenient, a
 distribution might provide systemd "drop-in" files which replace the
 .B ExecStart=
 setting to start the program with different arguments.  For example a
@@ -171,6 +173,12 @@ running, it can be masked with
 /etc/nfsmount.conf
 .br
 /etc/idmapd.conf
+.P
+Also similar files in 
+.B /usr/etc
+and in related
+.I conf.d
+drop-in directories.
 .SH SEE ALSO
 .BR systemd.unit (5),
 .BR nfs.conf (5),
diff --git a/utils/mount/nfsmount.conf.man b/utils/mount/nfsmount.conf.man
index 34879c8d63c7..10287cdfea69 100644
--- a/utils/mount/nfsmount.conf.man
+++ b/utils/mount/nfsmount.conf.man
@@ -115,16 +115,17 @@ All mounts to the '/export/home' export will be performed in
 the background (i.e. done asynchronously).
 .RE
 .SH FILES
-.TP 10n
+.I /usr/etc/nfsmount.conf
+.br
+.I /usr/etc/nfsmount.conf.d/*.conf
+.br
 .I /etc/nfsmount.conf
-Default NFS mount configuration file
-.TP 10n
-.I /etc/nfsmount.conf.d
-When this directory exists and files ending
-with ".conf" exist, those files will be
-used to set configuration variables. These
-files will override variables set
-in /etc/nfsmount.conf
+.br
+.I /etc/nfsmount.conf.d/*.conf
+.br
+.IP
+Default NFS mount configuration files, variables set in the later file
+over-ride those in the earlier file.
 .PD
 .SH SEE ALSO
 .BR nfs (5),
-- 
2.42.0

