Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6E9557019
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jun 2022 03:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377187AbiFWBrq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jun 2022 21:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359719AbiFWBrp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jun 2022 21:47:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F8443ACC
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jun 2022 18:47:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64BD221C66;
        Thu, 23 Jun 2022 01:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655948863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I1DqH5K0Sn0dM/JTC6+NRFvJvl9VHcLAqI0Igel49c4=;
        b=KToxm9f+9QjR9kcVVnaCTP0yY5wrtTF/ONWFYMT59VVI+Ge+xTYdc8mK57B+Wyn6UdVlMs
        6B61kyqUXVBmWFk9MqajwEGJ4FN9dGJYiBjfJ0xUKNwx30D5H3imGOnahuijlKhQRp1oyi
        ujP8ZBp39Dlus581CD1LCKs1Aiiy6M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655948863;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I1DqH5K0Sn0dM/JTC6+NRFvJvl9VHcLAqI0Igel49c4=;
        b=1S3NU9/PHMjmR8EwNiPgn6pn9I7Za/774x9kIW1QxdpZX0d3NHijPG2CUF86w2DJWJqHAQ
        3lhdJApzChU6sRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8827013461;
        Thu, 23 Jun 2022 01:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Sg+2ED7Gs2KwWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 23 Jun 2022 01:47:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] modprobe: protect against sysctl errors
Date:   Thu, 23 Jun 2022 11:47:39 +1000
Message-id: <165594885936.4786.14207888490098319610@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If there is an error running sysctl, a modprobe of these modules will
fail.  We probably don't want that - missing a sysctl is unlikely to be
fatal.

A real possibility is that /sbin/sysctl might not exist at all,
such as in a initramfs.  In that case we definitely don't want modprobe
to fail.

So make the scriptlets safe.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 systemd/50-nfs.conf | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/systemd/50-nfs.conf b/systemd/50-nfs.conf
index b56b2d765969..19e8ee734c8e 100644
--- a/systemd/50-nfs.conf
+++ b/systemd/50-nfs.conf
@@ -1,16 +1,16 @@
 # Ensure all NFS systctl settings get applied when modules load
=20
 # sunrpc module supports "sunrpc.*" sysctls
-install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && /sbin=
/sysctl -q --pattern sunrpc --system
+install sunrpc /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && { /sb=
in/sysctl -q --pattern sunrpc --system; exit 0; }
=20
 # rpcrdma module supports sunrpc.svc_rdma.*
-install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && /sb=
in/sysctl -q --pattern sunrpc.svc_rdma --system
+install rpcrdma /sbin/modprobe --ignore-install rpcrdma $CMDLINE_OPTS && { /=
sbin/sysctl -q --pattern sunrpc.svc_rdma --system; exit 0; }
=20
 # lockd module supports "fs.nfs.nlm*" and "fs.nfs.nsm*" sysctls
-install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && /sbin/s=
ysctl -q --pattern fs.nfs.n[sl]m --system
+install lockd /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && { /sbin=
/sysctl -q --pattern fs.nfs.n[sl]m --system; exit 0; }
=20
 # nfsv4 module supports "fs.nfs.*" sysctls (nfs_callback_tcpport and idmap_c=
ache_timeout)
-install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && /sbin/s=
ysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --syst=
em
+install nfsv4 /sbin/modprobe --ignore-install nfsv4 $CMDLINE_OPTS && { /sbin=
/sysctl -q --pattern 'fs.nfs.(nfs_callback_tcpport|idmap_cache_timeout)' --sy=
stem; exit 0; }
=20
 # nfs module supports "fs.nfs.*" sysctls
-install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && /sbin/sysct=
l -q --pattern fs.nfs --system
+install nfs /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && { /sbin/sys=
ctl -q --pattern fs.nfs --system; exit 0; }
--=20
2.36.1

