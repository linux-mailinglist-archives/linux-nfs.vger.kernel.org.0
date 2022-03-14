Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A6A4D790B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 02:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiCNBFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 21:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCNBFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 21:05:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFD646B03
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 18:04:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95D371F388;
        Mon, 14 Mar 2022 01:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647219851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rK43q7toAVcgZi5lde3H3b8IELXYJggISWcFDdWPDaA=;
        b=efRbp5sG4Hd5dKX5RJfX1aJB32RKSVAFrogzmOWWSRT//wFUIKxizHn4XrOYuKwYGMB76+
        mSDRLjMUkp6LInhimv1n4Xby+XVR7K24D970/tm0WsXMXjRxdrVHp776mJJbOBmUOMijfD
        o3YBZ1xkCVJVkl4II2/zRCZ4fPCK5UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647219851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rK43q7toAVcgZi5lde3H3b8IELXYJggISWcFDdWPDaA=;
        b=2N0LKFGJSIKf3MUNQSfaRtJWW8qcxyM6DSgvCbYT4Atcw1Nww1YHYjrGJXGDUFRxRKBN3n
        QzMtTrr5mV2ftFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E93BC13AE1;
        Mon, 14 Mar 2022 01:04:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZhPAKImULmK3YQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 14 Mar 2022 01:04:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Chuck Lever III" <chuck.lever@oracle.com>
cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH v2] nfs.man: document requirements for NFSv4 identity
Date:   Mon, 14 Mar 2022 12:04:06 +1100
Message-id: <164721984672.11933.15475930163427511814@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


When mounting NFS filesystem in a network namespace using v4, some care
must be taken to ensure a unique and stable client identity.  Similar
case is needed for NFS-root and other situations.

Add documentation explaining the requirements for the NFS identity in
these situations.

Signed-off-by: NeilBrown <neilb@suse.de>
---

I think I've address most of the feedback, but please forgive and remind
if I missed something.
NeilBrown

 utils/mount/nfs.man | 109 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index d9f34df36b42..5f15abe8cf72 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -1,7 +1,7 @@
 .\"@(#)nfs.5"
 .TH NFS 5 "9 October 2012"
 .SH NAME
-nfs \- fstab format and options for the
+nfs \- fstab format and configuration for the
 .B nfs
 file systems
 .SH SYNOPSIS
@@ -1844,6 +1844,113 @@ export pathname, but not both, during a remount.  For=
 example,
 merges the mount option
 .B ro
 with the mount options already saved on disk for the NFS server mounted at /=
mnt.
+.SH "NFS CLIENT IDENTIFIER"
+NFSv4 requires that the client present a unique identifier to the server
+to be used to track state such as file locks.  By default Linux NFS uses
+the host name, as configured at the time of the first NFS mount,
+together with some fixed content such as the name "Linux NFS" and the
+particular protocol version.  When the hostname is guaranteed to be
+unique among all client which access the same server this is sufficient.
+If hostname uniqueness cannot be assumed, extra identity information
+must be provided.
+.PP
+Some situations which are known to be problematic with respect to unique
+host names include:
+.IP \- 2
+NFS-root (diskless) clients, where the DCHP server (or equivalent) does
+not provide a unique host name.
+.IP \- 2
+"containers" within a single Linux host.  If each container has a separate
+network namespace, but does not use the UTS namespace to provide a unique
+host name, then there can be multiple effective NFS clients with the
+same host name.
+.IP \=3D 2
+Clients across multiple administrative domains that access a common NFS
+server.  If assignment of host name is devolved to separate domains,
+uniqueness cannot be guaranteed, unless a domain name is included in the
+host name.
+.SS "Increasing Client Uniqueness"
+Apart from the host name, which is the preferred way to differentiate
+NFS clients, there are two mechanisms to add uniqueness to the
+client identifier.
+.TP
+.B nfs.nfs4_unique_id
+This module parameter can be set to an arbitrary string at boot time, or
+when the=20
+.B nfs
+module is loaded.  This might be suitable for configuring diskless clients.
+.TP
+.B /sys/fs/nfs/client/net/identifier
+This virtual file (available since Linux 5.3) is local to the network
+name-space in which it is accessed and so can provided uniqueness between
+network namespaces (containers) when the hostname remains uniform.
+.RS
+.PP
+This value is empty on name-space creation.
+If the value is to be set, that should be done before the first
+mount.  If the container system has access to some sort of per-container
+identity then that identity, possibly obfuscated as a UUID is privacy is
+needed, can be used.  Combining the identity with the name of the
+container systems would also help.  For example:
+.RS 4
+echo "ip-netns:`ip netns identify`" \\
+.br
+   > /sys/fs/nfs/client/net/identifier=20
+.br
+uuidgen --sha1 --namespace @url  \\
+.br
+   -N "nfs:`cat /etc/machine-id`" \\
+.br
+   > /sys/fs/nfs/client/net/identifier=20
+.RE
+If the container system provides no stable name,
+but does have stable storage, then something like
+.RS 4
+[ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid &&=20
+.br
+cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier=20
+.RE
+would suffice.
+.PP
+If a container has neither a stable name nor stable (local) storage,
+then it is not possible to provide a stable identifier, so providing
+a random identifier to ensure uniqueness would be best
+.RS 4
+uuidgen > /sys/fs/nfs/client/net/identifier
+.RE
+.RE
+.SS Consequences of poor identity setting
+Any two concurrent clients that might access the same server must have
+different identifiers for correct operation, and any two consecutive
+instances of the same client should have the same identifier for optimal
+crash recovery.
+.PP
+If two different clients present the same identity to a server there are
+two possible scenarios.  If the clients use the same credential then the
+server will treat them as the same client which appears to be restarting
+frequently.  One client may manage to open some files etc, but as soon
+as the other client does anything the first client will lose access and
+need to re-open everything.
+.PP
+If the clients use different credentials, then the second client to
+establish a connection to the server will be refused access.  For=20
+.B auth=3Dsys
+the credential is based on hostname, so will be the same if the
+identities are the same.  With
+.B auth=3Dkrb
+the credential is stored in=20
+.I /etc/krb5.keytab
+and will be the same only if this is copied among hosts.
+.PP
+If the identity is unique but not stable, for example if it is generated
+randomly on each start up of the NFS client, then crash recovery is
+affected.  When a client shuts down uncleanly and restarts, the server
+will normally detect this because the same identity is presented with
+different boot time (or "incarnation verifier"), and will discard old
+state.  If the client presents a different identifier, then the server
+cannot discard old state until the lease time has expired, and the new
+client may be delayed in opening or locking files that it was
+previously accessing.
 .SH FILES
 .TP 1.5i
 .I /etc/fstab
--=20
2.35.1

