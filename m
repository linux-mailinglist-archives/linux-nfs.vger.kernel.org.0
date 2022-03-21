Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61CA4E1F7D
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Mar 2022 05:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbiCUEUf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 00:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiCUEUd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 00:20:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C218FD3E
        for <linux-nfs@vger.kernel.org>; Sun, 20 Mar 2022 21:19:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 115CF210E4;
        Mon, 21 Mar 2022 04:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647836343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DuLgIuI3RIkq3o/iMtvIKFBzenyLq2zQWa7eP006qf8=;
        b=l0B5BDd6nWla6BSfWLkvRgYZtAjv220Qqby5A/JBKZNTlBANi9K9P7nVGoC/uqbeM5T4BK
        VPTmidS2VwSjbq0FKs0z0Tc/8zDmMKbLZoItck9qCo6pQWeiGew23VWdnq38E3AR/ozEIL
        +c3HUpr1t5fa3IfbZnItZDpC7LmyPms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647836343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DuLgIuI3RIkq3o/iMtvIKFBzenyLq2zQWa7eP006qf8=;
        b=4iWbwO0CaZRkt3rDSjOhoWs1LxfaBsnB+v5+JchR09Y4W3lsDWnwHD2zJo04DKDJXgdqAl
        +tZg/P5j0e/2AEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC03913A04;
        Mon, 21 Mar 2022 04:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cesDGrX8N2LyYgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 21 Mar 2022 04:19:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: update documentation for the nfs4_unique_id parameter
Date:   Mon, 21 Mar 2022 15:18:56 +1100
Message-id: <164783633625.6096.14575868633417140042@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


The documentation for nfs4_unique_id is out-of-date.  In particular it
claim that when nfs4_unique_id is set, the host name is not used.  since
Commit 55b592933b7d ("NFSv4: Fix nfs4_init_uniform_client_string for net
namespaces") both the unique_id AND the host name are used.

Update the documentation to match the code.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/admin-guide/nfs/nfs-client.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/nfs/nfs-client.rst b/Documentation/adm=
in-guide/nfs/nfs-client.rst
index 6adb6457bc69..c34b8484a9ac 100644
--- a/Documentation/admin-guide/nfs/nfs-client.rst
+++ b/Documentation/admin-guide/nfs/nfs-client.rst
@@ -36,10 +36,9 @@ administrative requirements that require particular behavi=
or that does not
 work well as part of an nfs_client_id4 string.
=20
 The nfs.nfs4_unique_id boot parameter specifies a unique string that can be
-used instead of a system's node name when an NFS client identifies itself to
-a server.  Thus, if the system's node name is not unique, or it changes, its
-nfs.nfs4_unique_id stays the same, preventing collision with other clients
-or loss of state during NFS reboot recovery or transparent state migration.
+used together with  a system's node name when an NFS client identifies itsel=
f to
+a server.  Thus, if the system's node name is not unique, its
+nfs.nfs4_unique_id can help prevent collisions with other clients.
=20
 The nfs.nfs4_unique_id string is typically a UUID, though it can contain
 anything that is believed to be unique across all NFS clients.  An
@@ -53,8 +52,9 @@ outstanding NFSv4 state has expired, to prevent loss of NFS=
v4 state.
=20
 This string can be stored in an NFS client's grub.conf, or it can be provided
 via a net boot facility such as PXE.  It may also be specified as an nfs.ko
-module parameter.  Specifying a uniquifier string is not support for NFS
-clients running in containers.
+module parameter.  This uniquifier string will be the same for all NFS clien=
ts
+running in containers.  These clients can be given further uniqueness using
+/sys/fs/nfs/net/nfs_client/identifier.
=20
=20
 The DNS resolver
--=20
2.35.1

