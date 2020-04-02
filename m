Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C119BB3B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 06:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDBE6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 00:58:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:47634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgDBE6I (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 00:58:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2602AD46;
        Thu,  2 Apr 2020 04:58:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Hillf Danton <hdanton@sina.com>
Date:   Thu, 02 Apr 2020 15:57:56 +1100
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <20200402042644.17028-1-hdanton@sina.com>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <20200402042644.17028-1-hdanton@sina.com>
Message-ID: <87mu7uxz57.fsf@notabene.neil.brown.name>
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

On Thu, Apr 02 2020, Hillf Danton wrote:

> On Thu, 02 Apr 2020 10:53:20 +1100 NeilBrown wrote:
>>=20
>> PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in the
>> loop block driver, where a daemon needs to write to one bdi in
>> order to free up writes queued to another bdi.
>>=20
>> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
>> pages, so that it can still dirty pages after other processses have been
>> throttled.
>>=20
>> This approach was designed when all threads were blocked equally,
>> independently on which device they were writing to, or how fast it was.
>> Since that time the writeback algorithm has changed substantially with
>> different threads getting different allowances based on non-trivial
>> heuristics.  This means the simple "add 25%" heuristic is no longer
>> reliable.
>>=20
>> This patch changes the heuristic to ignore the global limits and
>> consider only the limit relevant to the bdi being written to.  This
>> approach is already available for BDI_CAP_STRICTLIMIT users (fuse) and
>> should not introduce surprises.  This has the desired result of
>> protecting the task from the consequences of large amounts of dirty data
>> queued for other devices.
>>=20
>> This approach of "only consider the target bdi" is consistent with the
>> other use of PF_LESS_THROTTLE in current_may_throttle(), were it causes
>> attention to be focussed only on the target bdi.
>>=20
>> So this patch
>>  - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
>>  - remove the 25% bonus that that flag gives, and
>>  - imposes 'strictlimit' handling for any process with PF_LOCAL_THROTTLE
>>    set.
>
> 	/*
> 	 * The strictlimit feature is a tool preventing mistrusted filesystems
> 	 * from growing a large number of dirty pages before throttling. For
>
> Based on the comment snippet, I suspect it is applicable to IO flushers
> unless they are likely generating tons of dirty pages. If they are,
> however, cutting their bonuses seem questionable.

The purpose of the strictlimit feature was to isolate one filesystem
(bdi) from all others, so that the one cannot create dirty pages which
unfairly disadvantage the others - this is what that comment says.
But the implementation appears to focus on the isolation, not the
specific purpose, and isolation works both ways.  It protects the others
from the one, and the one from the others.

fuse needs to be isolated so it doesn't harm others.
nfsd and loop need to be isolate so they aren't harmed by others.
I'm less familiar with IO flushers but I suspect that have exactly the
same need as nfsd and loop - they need to be isolated from dirty pages
other than on the device they are writing to.
The 25% bonus was never about giving them a bonus because they need it.
It was about protecting them from excess usage elsewhere.  I strongly
suspect that my change will provide a conceptually better service for IO
flushers. (whether it is better in a practical measurable sense I cannot
say, but I'd be surprised if it was worse).

One possible problem with strictlimit isolation is suggested by the
comment

	 *
	 * In strictlimit case make decision based on the wb counters
	 * and limits. Small writeouts when the wb limits are ramping
	 * up are the price we consciously pay for strictlimit-ing.
	 *

This suggests that starting transients may be worse in some cases.
I haven't noticed any problems in my (limited) testing so while I
suspect there is a genuine difference here, I don't expect it to be problem=
atic.

>
>>=20
>> Note that previously realtime threads were treated the same as
>> PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
>> real-time threads, so it is now different from the behaviour of nfsd and
>> loop tasks.  I don't know what is wanted for realtime.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> =3D2D--
>
> Hrm corrupted delivery?

No, that's just normal email quotation for a multi-part message (needed
for crypto-signing which I do by default)
'git am', for example, is quite capable of coping with it.

Thanks,
NeilBrown

>
>>  drivers/block/loop.c  |  2 +-
>>  fs/nfsd/vfs.c         |  9 +++++----
>>  include/linux/sched.h |  2 +-
>>  kernel/sys.c          |  2 +-
>>  mm/page-writeback.c   | 10 ++++++----
>>  mm/vmscan.c           |  4 ++--
>>  6 files changed, 16 insertions(+), 13 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6FcNQACgkQOeye3VZi
gblDmw/+NLPz80exgMWUF374oK1wARIqZr+wHTPVkaibovw8bomzXDLuPfLjOvMZ
8H/U228VytpbSzhPCT82Ief8GaHb7uARwHEvxIJSCcNyPt+oyKbLJgRbp3Zu5z5h
GD9in0nS4+TG5cEImhK8318jKBdCsEpX48Xe8YyW4bvIDWRyJHIuV8W6VYVSW/kF
WWTgtJ7OLPhNGk1Ob/Gcx7gHnTGZv8tCo9EmDzBw87ZJDIP5hCG7fHeETNCf22jj
GzZirbPR96Gvnur45qGfth2xbIMTiBmUwho0j1lRFE2R8Cz92c7m33UChQ72Z0v2
1O8gLh6xlFhgD9GqbBLgVsNV3i3JOL6TLPQF2k6V6GC3POjNx3ohVV8S0p21F9Y+
WUw5F+1XCkuoXUbOyPp4cD/chxzNZ/rE50T4YCD7GYE98qkLUXN9+4tmWkAcQUx2
zINCbge4dsrUIJKzHberVtWeRpqIp1f2eoUWWZTmw/cHSGr4GkmKeTSKFCa8CWja
lqjCsbz6FvB2TVHeDOBCI1F9A6CceD0AlbQ3jHU1If63QPVjrtmC1XkhQlcve+bK
6eivYhInXZWR8JMe3VEogT2v0XHRzLlOEcK26UVFKb4WEDVrhnjC6HS3YTuVGC22
gk27jBoVuQjCavat0iPBWrMaj4sNe5t37Z/4l6kfC1XXDU1o/60=
=oqvq
-----END PGP SIGNATURE-----
--=-=-=--
