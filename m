Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE04B9461
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 00:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiBPXQy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 18:16:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBPXQy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 18:16:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5AB7C42
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 15:16:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5A8C21A95;
        Wed, 16 Feb 2022 23:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645053395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy6oCsRrOORYyivDw7Jc8YHxdL9M1t5sDfWMcfSi81c=;
        b=OJGNJe+2UEF/cqQJGnI+ug6ytpTj69P+nBTcrjdHMmBye3kpYTyIUyjBy44pHwNBVYRmWt
        mQBbOyNbOASguA2JrOugoWlqWDHOfLUXMRKGCSnRcbitmH7cPIaMxVi+rzW+RdGIJ7aGb7
        LOrx4m4JuYv/9V8DCtzerNomtePZA1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645053395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy6oCsRrOORYyivDw7Jc8YHxdL9M1t5sDfWMcfSi81c=;
        b=xYlSbDyUbLSH39oC8Lhhwca8QGI6sHz3QumbK1t6gHYudSZmCDojbdfwtQKGpPMTMz5S+K
        QmVxJokkyanW/GAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C38213B6B;
        Wed, 16 Feb 2022 23:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qtM+OdGFDWInZwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 16 Feb 2022 23:16:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
In-reply-to: <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
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
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
Date:   Thu, 17 Feb 2022 10:16:30 +1100
Message-id: <164505339057.10228.4638327664904213534@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 17 Feb 2022, Benjamin Coddington wrote:
> How can we figure out what we want to do as a community before doing
> it all the ways?

The evidence suggests that we can't.  Maybe we shouldn't.

Or maybe we can take a completely different approach.  As I like to say:
"When in doubt, document."  (OK, I just made that up...)

I propose the following text to be added to nfs(5) or maybe put in a
separate man page - nfs-container(5).


NFS IN A CONTAINER
  When NFS is used to mount filesystems in a container, and specifically
  in a separate network namespace, these mounts are treated as quite
  separate from any mounts in a different container or not in a
  container (i.e. in a different network namespace).

  In the NFSv4.x protocol, each client must have a unique identifier.
  This is used by the server to determine when a client has restarted,
  so any state from a previous instance can be discarded.  So any two
  concurrent clients that might access the same server MUST have
  different identifiers, and any two consecutive instances of the same
  client SHOULD have the same identifier.

  Linux constructs the identifier (referred to as co_ownerid in the NFS
  specifications) from various pieces of information, three of which can
  be controlled by the sysadmin:

  - the hostname.  This can be different in different containers if they
    have different "UTS" namespaces.  If the container system ensures
    each container sees a unique host name, then this is
    sufficient for a correctly functioning NFS identifier.
    The host name is copied when the first NFS filesystem is mounted in
    a given network namespace.  Any subsequent change in the apparent
    hostname will not change the NFSv4 identifier.

  - the value of the nfs.nfs4_unique_id module parameter.  This is the
    same for all containers on a given host so is not useful to
    differentiate between containers.

  - the value stored in /sys/fs/nfs/client/net/identifier.  This virtual
    file is local to the network namespace that it is accessed in and so
    can provided uniqueness between containers when the hostname is
    uniform among containers.

    This value is empty on namespace creation. though there is a pending
    kernel patch which initialises it to a random value.  This would mean
    that containers which currently rely simply on a unique hostname to
    create unique NFS identifiers, will now *not* have a stable
    identifier from one instance to the next.  This may be a regression,
    so the patch should probably be reconsidered.

    If the value is to be set, that should be done before the first
    mount (much as the hostname is copied before the first mount).
    If the container system has access to some sort of per-container
    identity, then a command like
       uuidgen --sha1 --namespace @url -N "nfs:$CONTAINER_ID" \
                 > /sys/fs/nfs/client/net/identifier 

    might be suitable.  If the containre system provides no stable name,
    but does have stable storage, then something like

      [ -s /etc/nfsv4-uuid ] || uuidgen > /etc/nfsv4-uuid && 
          cat /etc/nfsv4-uuid > /sys/fs/nfs/client/net/identifier 

    would suffice.

    If a container has neither a stable name nor stable (local) storage,
    then it is not possible to provide a stable identifer, so providing
    a random one to ensure uniqueness would be best

        uuidgen > /sys/fs/nfs/client/net/identifier


Comments, revisions, etc most welcome.

Thanks
NeilBrown


