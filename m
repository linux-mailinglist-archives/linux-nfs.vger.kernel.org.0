Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519D0D6BB8
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbfJNWgS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Oct 2019 18:36:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:42568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387573AbfJNWgS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 14 Oct 2019 18:36:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0CD8AD46;
        Mon, 14 Oct 2019 22:36:16 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Tue, 15 Oct 2019 09:36:08 +1100
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/3] some nfs-utils patches.
In-Reply-To: <0763ec95-15ff-b31a-8743-eaf5286ee0f1@RedHat.com>
References: <156921267783.27519.2402857390317412450.stgit@noble.brown> <0763ec95-15ff-b31a-8743-eaf5286ee0f1@RedHat.com>
Message-ID: <87lftnq7jb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14 2019, Steve Dickson wrote:

> On 9/23/19 12:26 AM, NeilBrown wrote:
>> These free are largely unrelated.
>> The only connection is that without the second, I get
>> warnings because my /etc/nfs.conf includes /etc/nfs.conf.local - just
>> in case.
>> Then, without the first patch, the open fds get confused and
>> rpc.mountd doesn't listen on all /proc/net/rpc/*/channel
>> properly and nfs doesn't work.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>> ---
>>=20
>> NeilBrown (3):
>>       mountd: Initialize logging early.
>>       conffile: allow optional include files.
>>       statd: take user-id from /var/lib/nfs/sm
> Committed...=20

Thanks a lot Steve!

NeilBrown


>
> steved.
>>=20
>>=20
>>  support/nfs/conffile.c    |   13 ++++++++++---
>>  support/nsm/file.c        |   16 +++++-----------
>>  systemd/nfs.conf.man      |    3 +++
>>  utils/mountd/mountd.c     |    9 +++------
>>  utils/statd/sm-notify.man |   10 +++++++++-
>>  utils/statd/statd.man     |   10 +++++++++-
>>  6 files changed, 39 insertions(+), 22 deletions(-)
>>=20
>> --
>> Signature
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2k+FkACgkQOeye3VZi
gbmNuw/+IPh+LE5sTckDMG2hn7P3b68eu3FkC36rMOpZD6hZoV/whFMy7cYWUtW9
BlPpZIjaihzlcm1nbjhYXgCT61xz8OYxb4KuwtgTeojQ7aTdcmSY+YmOc5XqVZPe
Ib4bJk/gXnVkFIC9kt54W9WBUsxeXzWDpmBWQtm9D7/d5avTyLETmPOoHwf9GY8n
LEbEImOnwPUBlTcf1ZOBEwUxvCy4lAdvRyZk0FC7w4aIm7gjT9272v8JIb0ZutkG
a+CZZ0NXb2XeDeHdgMSR0mLqENzfcpjwMSKxrOvSBsDbcMNGvdClKYBfedOYyDgO
klsSNDz69pWAKLe3VurAbnBBoG1laFiZzTM/vJ044lP5hAJmUF0aoUEFDLpJHNGV
Rrc6ZpYmslAQznB7JoIE9OdMaKYNoIxtWrgPmSA8qic6uhJEZXfOLNBzl3A79bBG
rDzLO26NGn6WMvmyCcGESJtQtE9mRuB82Ntt1GNFDjb3/pGijmdw3JeVwcWz/Qxc
NtCCrjDYakPeHO4yBpW7MktvwwZJaJgV5psy2+00MpHGNTFO83edcDH9IlBQqET8
ySnUViFwI49CSiLSlaIkREbhgHrLzy7rZ6PbbRhA0/87tBVpq/hM25/2Kxyf14fU
4AwVdU/YN7rTUimKgpk0ytCo48Xyb5pM8F/w9MLRkCL6AVaJCW8=
=SOOT
-----END PGP SIGNATURE-----
--=-=-=--
