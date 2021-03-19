Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531FE342724
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCSUsv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 16:48:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhCSUsu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 16:48:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDC0BAD8A;
        Fri, 19 Mar 2021 20:48:48 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Sat, 20 Mar 2021 07:48:44 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
In-Reply-To: <20210319132820.GA31533@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <20210319132820.GA31533@fieldses.org>
Message-ID: <87lfaieuoj.fsf@notabene.neil.brown.name>
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

> On Fri, Mar 19, 2021 at 02:36:24PM +1100, NeilBrown wrote:
>> On Mon, Mar 01 2021, J. Bruce Fields wrote:
>>=20
>> > On Tue, Mar 02, 2021 at 02:01:36PM +1100, NeilBrown wrote:
>> >> On Mon, Mar 01 2021, J. Bruce Fields wrote:
>> >>=20
>> >> > I've gotten requests for similar functionality, and intended to
>> >> > implement it using directory notifications on /proc/fs/nfsd/clients.
>> >>=20
>> >> I've been exploring this a bit.
>> >> When I mount a filesystem, 2 clients get created.
>> >> With NFSv4.0, the second client is immediately deleted, and the first
>> >> client is deleted one grace period after the filesystem is unmounted.
>> >> With NFSv4.1 and 4.2, the first client is immediately deleted, and the
>> >> second client is deleted immediately after the unmount.
>> >
>> > Yeah, internally it's creating an "unconfirmed client" on SETCLIENTID
>> > (or EXCHANGE_ID) and then a new "confirmed client" on
>> > SETCLIENTID_CONFIRM (or CREATE_SESSION).
>> >
>> > I'm not sure why the ordering's a little different between the 4.0/4.1+
>> > cases.
>>=20
>> The multiple clients are not really nfsd's "fault".  The Linux NFS
>> client sends multiple EXCHANGE_ID or SET_CLIENT_ID requests, so NFSD
>> really does need to create multiple clients.
>>=20
>> For NFSv4.0, when nfsd gets a repeat SET_CLIENT_ID, it keeps the old one
>> and discards the new.
>> For NFSv4.1, the spec requires that it keep the new one and discard the
>> old.
>> This explains the different ordering.
>
> Hm, is this the client's trunking-detection logic?

Yes.

>
> In which case, it's not just unconfirmed clients.

For NFSv4.1, only the EXCHANGE_ID is duplicate.  There is only one
CREATE_SESSION, and that is where the client is confirmed.  So only one
confirmed client.

For NFSv4.0 bother SETCLIENTID and SETCLIENDID_CONFIRM are duplicate.
So maybe both clients get confirmed.  I should check that.

>
>> So the clean up the logging, mountd needs to be able to see the
>> confirmation status.
>
> That sounds fine.
>
> (The other possibility might be to just not expose clients till they're
> confirmed.  I don't know if unconfirmed clients are really that
> interesting.  But I guess I'd rather err on the side of exposing more
> information here.)

That was my feeling to: expose all the info, and filter out the
uninteresting bits a point of use.

Thanks,
NeilBrown

>
>> Following this reply will be a patch to nfsd to provide this status, and
>> a patch to mountd/exportd to use this status.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBVDiwOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblNTBAApFclraFDenLozCrvOfMA5KK4rhNt2PHWUpjR
uzcudGlckKUceBL5bewDCnLNhaUUg6nHavQxc9hIepHYc6SHF7VHwbmJI3o3PDxC
LbThfOm1B7ntEURyYv98pt+C/AZxEUGcWa8rKQa3dK0iGZxbkXRL8nUrf9ZfUCsm
dE7XuU5a2l/n1dlLtyvodCGfItprlBKA5XAdfCrHP0EK5qryi6TOj/hVBOasGR3e
YEDS8giiHGPKSQydmINlATrlUOQrSc1Yk6mgJfOXUTLhnVPULHDagsjOyzMyrydt
h6Si0kMe5+UwVmnRnkW4v9FEqtpG3+NYAL82UNnX5MghStZHwCHC75Nj0OJcwyId
clFjtsSNE/53J5iCdX5s9mF+hxvxiRCrk74UXYQiBG7auigvwl+Flo12FMtBLYGJ
3HCW0SoAjcD51o2gwVX8S47ZGB5i27x6co7cUWZzLT3O2DBclWvPN4Am9PLKvueQ
wd2j85xJ8kdAGvib+nXi4FdJfPwZH600YPAzt6p2yYMHbT4ypq+iRTxjQgMqP6VE
udXn6hb3l8G5LnF6/ET/uXdolBq5X6rBxGmtpPS9yx8TyKVp4pMw55yfSWSFiDRX
71RZDlsqGY0too6nUlB9HvNNtqPcaMF/iWtyjNj+snWflW8dopIgegcjK86/Co+s
72+BVls=
=Kt/c
-----END PGP SIGNATURE-----
--=-=-=--
