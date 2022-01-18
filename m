Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8B493083
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 23:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiARWNr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 17:13:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50492 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343663AbiARWNq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 17:13:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79C5A1F37E;
        Tue, 18 Jan 2022 22:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642544024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAHvca2bpoYeHXHo+BMAx7zj5Lkev8D5VT+5PlIT8ec=;
        b=OT4sSt4GojfmivoxgbSzf3kcx6BhT9Wz2GnqgxB5rHsSgMVnm709x6CX+f1f2/1JNNI7ge
        wcQpayQRI7np0jcvd5N1znxArTQPEq1aebZRoE6hmMHE4FXEgDU6utOkmEErOtmE3C8jN6
        p4IHVPqvH1enkMxyGjjlJa68Ww8alDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642544024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAHvca2bpoYeHXHo+BMAx7zj5Lkev8D5VT+5PlIT8ec=;
        b=4r/8QtGnoQrcptONNaqaCvzG/YBhIRAQhKGym1kxw0LQ0vRdSv6bliofXkqQt1N9mpWOvm
        brZbD4LXD9rdcuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E83E13AD9;
        Tue, 18 Jan 2022 22:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y6sfB5U752HnGQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jan 2022 22:13:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Nikita Yushchenko" <nikita.yushchenko@virtuozzo.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Steve Dickson" <SteveD@redhat.com>, ltp@lists.linux.it,
        kernel@openvz.org
Subject: Re: LTP nfslock01 test failing on NFS v3 (lockd: cannot monitor 10.0.0.2)
In-reply-to: <a35ebb8b-6e61-8445-cf19-285bf2f875ad@virtuozzo.com>
References: <YebcNQg0u5cU1QyQ@pevik>,
 <a35ebb8b-6e61-8445-cf19-285bf2f875ad@virtuozzo.com>
Date:   Wed, 19 Jan 2022 09:13:35 +1100
Message-id: <164254401568.24166.883582030601071761@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 19 Jan 2022, Nikita Yushchenko wrote:
> 18.01.2022 18:26, Petr Vorel wrote:
> > Hi all,
> >=20
> > this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfsl=
ock01
> > looks to be failing on NFS v3:
> >=20
> > "not unsharing /var makes AF_UNIX socket for host's rpcbind to become ava=
ilable
> > inside ltpns. Then, at nfs3 mount time, kernel creates an instance of loc=
kd for
> > ltpns, and ports for that instance leak to host's rpcbind and overwrite p=
orts
> > for lockd already active for root namespace. This breaks nfs3 file lockin=
g."
>=20
> What exactly happens is:
>=20
> Test runs 'mount' in non-root netns, trying to mount a directory from root =
netns of the same host via nfsv3
>=20
> (Part of) call chain inside the kernel
>=20
> nfs_try_get_tree()
>   nfs3_create_server()
>    nfs_create_server()
>     nfs_init_server()
>      nfs_start_lockd()
>       nlmclnt_init()
>        lockd_up()
>         svc_bind()
>          svc_rpcb_setup()
>           rpcb_create_local()
>=20
> ... and at this point it tries AF_UNIX connection to /var/run/rpcbind.sock
>=20
> AF_UNIX is not netns-aware.
> So it connects to host's rpcbind.
> And overwrites ports registered in host's rpcbind by lockd instance for roo=
t namespace. Since this=20
> point, lockd instance for root namespace becomes no longer accessible (it s=
till listens but nobody can=20
> learn the ports). Thus nfs locks don't work.
>=20
> I'm not sure what is the correct behavior here.
>=20
> Maybe rpcb_create_local() shall detect that it is not in root netns, and on=
ly try AF_INET connection to=20
> localhost in that case.

That would be simple and might be sensible.  IF changing the AF_UNIX
path to "/run/rpcbind.sock" isn't sufficient, then testing for the
root_ns is probably the best second option.

Thanks,
NeilBrown
