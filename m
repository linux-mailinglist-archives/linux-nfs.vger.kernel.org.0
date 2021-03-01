Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A6E329475
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhCAWC3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 17:02:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:60996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232890AbhCAWA2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 17:00:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FE74AB8C;
        Mon,  1 Mar 2021 21:59:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Tue, 02 Mar 2021 08:59:37 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
In-Reply-To: <20210301185037.GB14881@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
Message-ID: <87a6rmilh2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01 2021, J. Bruce Fields wrote:

> I've gotten requests for similar functionality, and intended to
> implement it using directory notifications on /proc/fs/nfsd/clients.

Interesting idea.  That could report successful mounts and unmounts but
wouldn't report failed mount attempts or (I think) which export point is
being mounted.

If we could reliably correlate the entry in 'clients' with each auth
request, we could filter out multiple auth refresh requests for the same
client+filesystem.  The only field we could do that on would be IP
address, and that wouldn't be seamless..

Might be worth pursuing if only to report "mount" and "unmount" events
for a client identified by IP, and leave it to the admin to see any
connection between 'mount' events and 'auth' events.

Thanks,
NeilBrown


>
> But this is another way to do it that I hadn't thought of.  That's
> interesting.  I haven't thought about the relative advantages or
> disadvantages.
>
> --b.
>
> On Mon, Mar 01, 2021 at 01:17:15PM +1100, NeilBrown wrote:
>> V1 of this series didn't update the usage() message for mountd,
>> and omited the required ':' after the 'T' sort-option.  This=20
>> series fixes those two omissions.
>>=20
>> Original series comment:
>>=20
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
>>       mountd: add --cache-use-ipaddr option to force use_ipaddr
>>       mountd: make default ttl settable by option
>>=20
>>=20
>>  support/export/auth.c      |  4 +++
>>  support/export/cache.c     | 32 +++++++++++------
>>  support/export/v4root.c    |  3 +-
>>  support/include/exportfs.h |  3 +-
>>  support/nfs/exports.c      |  4 ++-
>>  utils/mountd/mountd.c      | 30 +++++++++++++++-
>>  utils/mountd/mountd.man    | 70 ++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 131 insertions(+), 15 deletions(-)
>>=20
>> --
>> Signature

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmA9Y8kOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigblYZQ/+LM3KD7dZbq/wmdK+cWociURX+swWE98MrdFG
XnNMulvVlALLV74j3oW7meDNe9eHzXUr+iCpKGiBp+hjRxQ7DZHVRkOcBab1dPSM
tHKzjz3AFCCr24s7/cNhj3zxkzDQzybzB/sQj7Vpp0R4v+EbsxTjOgP8fONdiXLU
+zUKv30iPJuKnetjTk/rTUIsHmbIgPeSDidrUYuUprocL2rrLi+XUL1gWvX30MOP
bQAb26oxQ/geLQo8KmlX9AFIjJxCOgIAmmDFaASizPUNxIDdqhYby0WujWhnEIKX
YfeE9wjQcH/0b2GqN5OI6A5KrVjMUpiwXj3sM61Nq1PN26MShQlnG5M8t0ossz1e
Tpxmwk4V7qh+fAbTsYZuiJHURVG6lxvb2997ENdzqTNXLNpwMTHuqW8bB/6pSgVB
8vPFs9pPfImBfnHk1fp7GpTvP/zBbLD+hdrxNvKn8j2vOsMrmP5ORlDkJJxagXuN
r7hRUuwgC0nRehhk1PVMx8nn+g9vlo2qnZmQjLgwy6qvqZuQPuj5oSjOY7p2XxMR
cNeKcSkqZlyOw5S/Qoze9n2wYFJ35K8eJErn6wVKAWMj5OJ2nEUOhSnzNlMH0MAz
2nMURlXO3k/9o7nvvFQfC86T3MqfhicXnTola6uT4JPxNg8ttJ4z1o3r3qWbSmGx
f3cmL6E=
=UJ93
-----END PGP SIGNATURE-----
--=-=-=--
