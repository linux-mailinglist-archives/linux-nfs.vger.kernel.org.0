Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2F32C6C8
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390852AbhCDA37 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:33192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346978AbhCCWa0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Mar 2021 17:30:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A473CADDB;
        Wed,  3 Mar 2021 22:28:39 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Thu, 04 Mar 2021 09:28:35 +1100
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] nfs-utils: provide audit-logging of NFSv4 access
In-Reply-To: <6ddbe801-d107-5cbd-7362-c3e84321f203@RedHat.com>
References: <161422077024.28256.15543036625096419495.stgit@noble>
 <6ddbe801-d107-5cbd-7362-c3e84321f203@RedHat.com>
Message-ID: <87pn0fhnxo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02 2021, Steve Dickson wrote:

> Hey!
>
> A couple comments...=20
>
> On 2/24/21 9:42 PM, NeilBrown wrote:
>> When NFSv3 is used mountd provides logs of successful and failed mount
>> attempts which can be used for auditing.
>> When NFSv4 is used there are no such logs as NFSv4 does not have a
>> distinct "mount" request.
>>=20
>> However mountd still knows about which filesysytems are being accessed
>> from which clients, and can actually provide more reliable logs than it
>> currently does, though they must be more verbose - with periodic "is
>> being accessed" message replacing a single "was mounted" message.
>>=20
>> This series adds support for that logging, and adds some related
>> improvements to make the logs as useful as possible.
>>=20
>> NeilBrown
>>=20
>> ---
>>=20
>> NeilBrown (5):
>>       mountd: reject unknown client IP when !use_ipaddr.
>>       mountd: Don't proactively add export info when fh info is requeste=
d.
>>       mountd: add logging for authentication results for accesses.
> I wonder if we should mention setting "debug=3Dauth" enables
> this logging in the mountd manpage=20

That is already in the mountd man page :-)

>
>>       mountd: add --cache-use-ipaddr option to force use_ipaddr
>>       mountd: make default ttl settable by option
> These two probably need to be put into the nfs.conf file=20
> and the nfs.conf man page since the conf_get_num()
> and conf_get_bool() calls were added.

That's done now too.

>
> Finally, I'll add this to my plate, but I'm thinking
> the new log-auth and ttl flags probably should be=20
> introduce into nfsv4.exported.
>

I'll add that to my patches before resubmitting.

> I didn't port over the use-ipaddr flag to exportd,
> since I though it was only used in the v3 mount path
> but may that was an oversight on my part.=20

use-ipaddr it not at all v3 specific.
It was originally introduced to handle the fact that a single host could
be in a large number of netgroups, and concatenating the names of all
those netgroups could produce a "domain" name that is too long.
The new option to force it on is useful for access logging, particularly
with NFSv4.

I'll add that to my patches too.

Thanks,
NeilBrown


>
> Thoughts?
>
> steved.
>>=20
>>=20
>>  support/export/auth.c      |  4 +++
>>  support/export/cache.c     | 32 +++++++++++------
>>  support/export/v4root.c    |  3 +-
>>  support/include/exportfs.h |  3 +-
>>  support/nfs/exports.c      |  4 ++-
>>  utils/mountd/mountd.c      | 29 +++++++++++++++-
>>  utils/mountd/mountd.man    | 70 ++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 130 insertions(+), 15 deletions(-)
>>=20
>> --
>> Signature
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBADZMOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmktw/+Mc3JJcKpDD5QKTTwG24dQZYNK251QvPKxA5n
CVA9Iev6l4ZaLp4J3ffriPswW77sSJ4vuoAAXJmTLbABeT8KetkmcpQ+xblgj5ZW
gqlLKObyXwFqVFz0lxYuEIoSAqRv95W5J6vxJsHqj6cPxDZj6UfqmzmqP/kb2qn/
dsuCA2VqlDqDwa269kM5AavcSVu3hbu27NTo9MD7naklviAB3XoT3NoN2J5W/k00
Z0e4ncsjiphdl5zfynKqWGYMorA+EHJXnyQYeT+cDCly3G8kq+zxR5gwKFsEIQhy
YgBpji8Nvs5mdx7WSscQGNjAkZSah7/u9VnVAiOGisgQ8yHTYULoHyPtrBtMVsvb
HFCAPtsQf/LKJyRr7L0UR4x62CTssJEyjXCpc/rznlzUx6rLT2Tj4V3FZC6VPLuF
/OSfP2eBNEdo1qURsF0/VJZ0cg2HJX66aprxXjq80siAtXrXepJ812mscZ65Mwa6
bvhuRxHm9PRGXv37jrVpFHZ008KXFOTFAWBy/SlxwgnMLqDVBtMfgM9AQGyrK9JZ
vbItMhNkWwtKqONnvwPAstZOZDqQscsTiVHnkGtCt4j7yM5qQm9frYIPH0diaueB
pV13XA6Pl5xRUUGTvdv+jT9TWSIf9oNJQvfak5Rd72yVKwNR+BpH7Vju3mzr2dJH
A6KuVl8=
=Qjw5
-----END PGP SIGNATURE-----
--=-=-=--
