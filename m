Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9524C81B9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 04:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiCADon (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 22:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCADom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 22:44:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F30061A1F
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 19:44:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DBFD8219A6;
        Tue,  1 Mar 2022 03:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646106240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWqzKCfzxz3sHOyyf3gGRmfhR9Z6tAnI1OJD5qFwojk=;
        b=s9+xjrCJmE1ihxUyptYcN6GRhAq/q6s7U5300OYGBS9QYPOlFeoi/ZHc4LFP271Bi8v6kc
        X/mFxmB9Ejhg9L/UEHzgk53E3i0R2JiMeWVTgUYfs0Dy5U34VZYi8KkD1PkKjqSRbyMMul
        GPlzoY4N/yaeqHS+HhvbWftGl8hx8Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646106240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWqzKCfzxz3sHOyyf3gGRmfhR9Z6tAnI1OJD5qFwojk=;
        b=0NguVe2PnEIqmvU2n9NBvQ+SrLZU2DsFfZKSZU0KdEDD/3qZWC0VPawtwZIwyK8TEyo4DI
        Mzxf5qSmyHf8srAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D6C513AF5;
        Tue,  1 Mar 2022 03:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hlEZE3+WHWIxbQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 01 Mar 2022 03:43:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs.man: document requirements for NFS mounts in a container
In-reply-to: <164505339057.10228.4638327664904213534@noble.neil.brown.name>
References: <cover.1644515977.git.bcodding@redhat.com>, =?utf-8?q?=3C9c04664?=
 =?utf-8?q?8bfd9c8260ec7bd37e0a93f7821e0842f=2E1644515977=2Egit=2Ebcodding?=
 =?utf-8?q?=40redhat=2Ecom=3E=2C?=
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>,
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>,
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>,
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>,
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>,
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>,
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>,
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>,
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>,
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>,
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>,
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>,
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>,
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>,
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>,
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>,
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>
Date:   Tue, 01 Mar 2022 14:43:56 +1100
Message-id: <164610623626.24921.6124450559951707560@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


When mounting NFS filesystems in a network namespace using v4, some care
must be taken to ensure a unique and stable client identity.
Add documentation explaining the requirements for container managers.

Signed-off-by: NeilBrown <neilb@suse.de>
---

NOTE I originally suggested using uuidgen to generate a uuid from a
container name.  I've changed it to use the name as-is because I cannot
see a justification for using a uuid - though I think that was suggested
somewhere in the discussion.
If someone would like to provide that justification, I'm happy to
include it in the document.

Thanks,
NeilBrown


 utils/mount/nfs.man | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index d9f34df36b42..4ab76fb2df91 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -1844,6 +1844,69 @@ export pathname, but not both, during a remount.  For =
example,
 merges the mount option
 .B ro
 with the mount options already saved on disk for the NFS server mounted at /=
mnt.
+.SH "NFS IN A CONTAINER"
+When NFS is used to mount filesystems in a container, and specifically
+in a separate network name-space, these mounts are treated as quite
+separate from any mounts in a different container or not in a
+container (i.e. in a different network name-space).
+.P
+In the NFSv4 protocol, each client must have a unique identifier.
+This is used by the server to determine when a client has restarted,
+allowing any state from a previous instance can be discarded.  So any two
+concurrent clients that might access the same server MUST have
+different identifiers, and any two consecutive instances of the same
+client SHOULD have the same identifier.
+.P
+Linux constructs the identifier (referred to as=20
+.B co_ownerid
+in the NFS specifications) from various pieces of information, three of
+which can be controlled by the sysadmin:
+.TP
+Hostname
+The hostname can be different in different containers if they
+have different "UTS" name-spaces.  If the container system ensures
+each container sees a unique host name, then this is
+sufficient for a correctly functioning NFS identifier.
+The host name is copied when the first NFS filesystem is mounted in
+a given network name-space.  Any subsequent change in the apparent
+hostname will not change the NFSv4 identifier.
+.TP
+.B nfs.nfs4_unique_id
+This module parameter is the same for all containers on a given host
+so it is not useful to differentiate between containers.
+.TP
+.B /sys/fs/nfs/client/net/identifier
+This virtual file (available since Linux 5.3) is local to the network
+name-space in which it is accessed and so can provided uniqueness between
+containers when the hostname is uniform among containers.
+.RS
+.PP
+This value is empty on name-space creation.
+If the value is to be set, that should be done before the first
+mount (much as the hostname is copied before the first mount).
+If the container system has access to some sort of per-container
+identity, then a command like
+.RS 4
+echo "$CONTAINER_IDENTITY" \\
+.br
+   > /sys/fs/nfs/client/net/identifier=20
+.RE
+might be suitable.  If the container system provides no stable name,
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
+a random one to ensure uniqueness would be best
+.RS 4
+uuidgen > /sys/fs/nfs/client/net/identifier
+.RE
+.RE
 .SH FILES
 .TP 1.5i
 .I /etc/fstab
--=20
2.35.1

