Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00A334271A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 21:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCSUoY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 16:44:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhCSUnw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 16:43:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA6C8AC23;
        Fri, 19 Mar 2021 20:43:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Sat, 20 Mar 2021 07:43:46 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] mountd/exportd: only log confirmed clients, and poll
 for updates
In-Reply-To: <20210319141508.GB31533@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
 <87sg4rerta.fsf@notabene.neil.brown.name>
 <20210319141508.GB31533@fieldses.org>
Message-ID: <87o8feeuwt.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 19 2021, J. Bruce Fields wrote:

> On Fri, Mar 19, 2021 at 02:38:25PM +1100, NeilBrown wrote:
>>=20
>> It is possible (and common with the Linux NFS client) for the nfs server
>> to receive multiple SET_CLIENT_ID or EXCHANGE_ID requests when starting
>> a connection.  This results in some clients appearing in
>>  /proc/fs/nfsd/clients
>> which never get confirmed.  mountd currently logs these, but they aren't
>> really helpful.
>>=20
>> If the kernel supports the reporting of the confirmation status of
>> clients, we can suppress the message until a client is confirmed.
>>=20
>> With this patch we:
>>  - record if the client is confirmed, assuming it is if the status is
>>     not reported
>>  - don't log unconfirmed clients
>>  - check all unconfirmed clients each time any event is processed,
>>  - if there are unconfirmed clients, we request a wakeup after a
>>    exponentially decreasing time, and check again
>
> increasing not decreasing, I think.

or frequency, not time??  Thanks.

>
> Is there any better way to let userland know when the contents of a
> virtual file have changed?

i had thought of using sysfs_notify_dirent(), though the file isn't in
sysfs (or kernfs), so extra work might be needed.  And I didn't want to
hold the file descriptor open, as then I would need to worry about where
the available fds could be exhausted.

>
> Looks at inofity man page....  There's an "IN_MODIFY" event.  I think we
> could add an fsnotify_inode(inode, FS_MODIFY); at the end of
> move_to_confirmed().  (I'm not sure what's the best way to get the inode
> of the info file there.)
>
> Would that help?

Yes, that is a much better idea.
We could pass an array of dentry pointers to nfsd_client_mkdir and
thence to nfsdfs_create_files.
Then create_client could grab the required dentry and stash it next to
cl_nfsd_dentry.  Then use fsnotify_dirent() which is better than _inode
as the file name gets included in the event.

I might give that a try.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBVDQIOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbl9qxAAhzKzfjYY0m9F3c/b8XrriR1OBTn2hIbdxqDo
oc1ApwJvxyBKc1SJGVEIibCuN+/no1XGRZE3wricKG6tAIDLwKX2eczRU5SkG0uC
JFMf88Np72SmOJM1mrePE/gQ7TzhxG4N5BT1tMxTHsjCWJuiQ6Ph4YdesSN/uk8a
BBcFHACFB5aD0RLn2nUmgqwwZMNxkYludfgU1h+H9FrfQIBgiDpspSdvNhygSzM5
NDPNIxHvpZd/it4QtvpkYI07ZTgxEXNKU0vA3G9jlFH2CVB/wv2e+jUqwpZ0PfgO
lhEDyet+5dNkZz/Lr8S0xUh86mKsBVjkOMMRi4Q08qPgu6O/vIs52yoGVyJa9f0s
EEWu2QYf1MEkryKI0suOB3M56GFY2BCIeUv1xeVTbiiktbAMhDAjELYZeVcxvnoI
ZPtRkm8e72z6yItJ13ERzC49OhhbWiJu58HGutOmTWlZQStEiIB6n/6Kl8JClSmE
csLhg+S1LN+qgScpm4MXZj7+Rg5RiluPvANEo9j2ccByI249r2sCsVkUBh4XzoMA
ja/D7vylm7wxwr0o2H23RVAz4vMC0/bygCWZDxXqHbUFMjeEs7LBX0q36oSElVC0
SlDpnLKnuWg8obI1DxRk0vnO372EvGYi9Z5grgxP2txfZVFnlDxm/Gw63Dxes47p
LRCTBv8=
=sT04
-----END PGP SIGNATURE-----
--=-=-=--
