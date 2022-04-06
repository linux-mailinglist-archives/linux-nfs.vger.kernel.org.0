Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD84F6E15
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiDFWxj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiDFWxh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:53:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24894200364
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:51:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED4481F859;
        Wed,  6 Apr 2022 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649285497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhK5Rfv2kcs1ZiPzQNwVHN8uE9kMtHwkhGh0+DpfRWs=;
        b=UJks10Hi0OMRIcB1Z1hWIU/GPOPI9HnCOCF0CwjtHwyJJBhD17+HpdlWIsZSyQpVvzVmtl
        DmKwAgNGaS4HKvfSu1HLxGSg5kyJ6REt0IZfpRnaGrDjwlxYq+tlkb1JbeGBU6BT6N2sXr
        GADQop9tGHgaeruzl+6uIh9WzM2WWdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649285497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhK5Rfv2kcs1ZiPzQNwVHN8uE9kMtHwkhGh0+DpfRWs=;
        b=2NjCJ1WylrYiIohPjsVmVWNlqoXI8ELHqFmq0kl3q+j+dbqERi+yp3qnKw8Llzz4cAZeHP
        YEX4aRZdkWEiOGAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E953139F5;
        Wed,  6 Apr 2022 22:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0QSyB3gZTmIAVQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 06 Apr 2022 22:51:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Benjamin Coddington" <bcodding@redhat.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] mount.nfs: handle EADDRINUSE from mount(2)
In-reply-to: <852313a3-005e-2771-8be1-888891370533@redhat.com>
References: <164816808982.6096.11435363819568479436@noble.neil.brown.name>,
 <852313a3-005e-2771-8be1-888891370533@redhat.com>
Date:   Thu, 07 Apr 2022 08:51:32 +1000
Message-id: <164928549280.10985.16998885406899511034@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 07 Apr 2022, Steve Dickson wrote:
> Hey!
>=20
> My apologies for taking so long to get to this....

Better late than never !! :-)

>=20
> On 3/24/22 8:28 PM, NeilBrown wrote:
> >=20
> > [[This is the followup to the kernel patch I recently posted.
> >    It changes the behaviour of incorrectly configured containers to
> >    get unique client identities - so lease stealing doesn't happen
> >    so data corruption is avoided - but does not provide stable
> >    identities, so reboot recovery is not ideal.
> Which patch are you referring to and did it make it in?
>=20

https://lore.kernel.org/all/164816787898.6096.12819715693501838662@noble.neil=
.brown.name/

It hasn't landed, and I didn't expect it to (yet).  It is a basis for
discussion and experimentation.


> >    What is best to do when configuration is wrong?  Provide best service
> >    possible despite it not being perfect, or provide no service so the
> >    config will not get fixed.  I could be swayed either way.
> > ]]
> Maybe a little both? :-) Flag the broken config and continue on
> if possible... but flagging the broken config is more critical... IMHO.

I tend to agree, but it isn't clear how best to flag something in a way
that the flag will actually be seen.

>=20
> >=20
> > When NFS filesystems are mounted in different network namespaces, each
> > network namespace must provide a different hostname (via accompanying
> > UTS namespace) or different identifier (via sysfs).
> >=20
> > If the kernel finds that the identity that it constructs is already in
> > use in a different namespace it will fail the mount with EADDRINUSE.
> >=20
> > This patch catches that error and, if the sysfs identifier is unset,
> > writes a random string and retries.  This allows the mount to complete
> > safely even when misconfigured.  The random string has 128 bits of
> > entropy and so is extremely likely to be globally unique.
> >=20
> > A lock is taken on the identifier file, and it is only updated if no
> > identifier is set.  Thus two concurrent mount attempts will not generate
> > different identities.  The mount is retried in any case as a race may
> > have updated the identifier while waiting for the lock.
> >=20
> > This is not an ideal solution as an unclean restart of the host cannot
> > be detected by the server except by a lease timeout.  If the identifier
> > is configured correctly and is stable across restarts, the server can
> > detect the restart immediately.  Consequently a warning message is
> > generated to encourage correct configuration.
> Just curious... How did you test this patch? I would like
> to build an env to generate this type of error.

ip netns add foo
ip netns exec foo  ip link set dev lo up
ip link add veth0 type veth peer name veth1
ip link set veth1 netns foo

ip netns exec foo ifconfig veth1 10.1.1.1/24 up
ifconfig veth0 10.1.1.2/24 up

ip netns exec foo ip route add default via 10.1.1.2
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -j SNAT --to-source 10.0.2.15 -s 10.1.1.0/24

## At this point we have a separate network namespace which has network
## connectivity to anything the host can reach.
## The "--to-source" address is the IP address of the host - a qemu
## instance in this case.

# mount in the primary namespace
mount -o vers=3D4.1 server:/path /mnt

# attempt to mount in the alternate name space
ip netns exec foo mount -o vers=3D4.1 server:/path /mnt2

Note that "ip netns exec" creates a temporary mount namespace, so when
it exits, /mnt2 will no longer be mounted.  If you want to do more than
one thing you might need to
   ip netns exec foo /bin/sh my-shell-script
or
   ip netns exec foo /bin/bash -i
   # in a separate terminal window.

NeilBrown
