Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48B919FD0B
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 20:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgDFSYL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 14:24:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFSYL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Apr 2020 14:24:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4F3E5BBF4;
        Mon,  6 Apr 2020 18:24:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>
Date:   Mon, 06 Apr 2020 21:58:18 +1000
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <20200406093601.GA1143@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87sghmyd8v.fsf@notabene.neil.brown.name> <20200403151534.GG22681@dhcp22.suse.cz> <878sjcxn7i.fsf@notabene.neil.brown.name> <20200406074453.GH19426@dhcp22.suse.cz> <20200406093601.GA1143@quack2.suse.cz>
Message-ID: <87mu7ox1ut.fsf@notabene.neil.brown.name>
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

On Mon, Apr 06 2020, Jan Kara wrote:

> On Mon 06-04-20 09:44:53, Michal Hocko wrote:
>> On Sat 04-04-20 08:40:17, Neil Brown wrote:
>> > On Fri, Apr 03 2020, Michal Hocko wrote:
>> >=20
>> > > On Thu 02-04-20 10:53:20, Neil Brown wrote:
>> > >>=20
>> > >> PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in t=
he
>> > >> loop block driver, where a daemon needs to write to one bdi in
>> > >> order to free up writes queued to another bdi.
>> > >>=20
>> > >> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dir=
ty
>> > >> pages, so that it can still dirty pages after other processses have=
 been
>> > >> throttled.
>> > >>=20
>> > >> This approach was designed when all threads were blocked equally,
>> > >> independently on which device they were writing to, or how fast it =
was.
>> > >> Since that time the writeback algorithm has changed substantially w=
ith
>> > >> different threads getting different allowances based on non-trivial
>> > >> heuristics.  This means the simple "add 25%" heuristic is no longer
>> > >> reliable.
>> > >>=20
>> > >> This patch changes the heuristic to ignore the global limits and
>> > >> consider only the limit relevant to the bdi being written to.  This
>> > >> approach is already available for BDI_CAP_STRICTLIMIT users (fuse) =
and
>> > >> should not introduce surprises.  This has the desired result of
>> > >> protecting the task from the consequences of large amounts of dirty=
 data
>> > >> queued for other devices.
>> > >
>> > > While I understand that you want to have per bdi throttling for those
>> > > "special" files I am still missing how this is going to provide the
>> > > additional room that the additnal 25% gave them previously. I might
>> > > misremember or things have changed (what you mention as non-trivial
>> > > heuristics) but PF_LESS_THROTTLE really needed that room to guarante=
e a
>> > > forward progress. Care to expan some more on how this is handled now?
>> > > Maybe we do not need it anymore but calling that out explicitly woul=
d be
>> > > really helpful.
>> >=20
>> > The 25% was a means to an end, not an end in itself.
>> >=20
>> > The problem is that the NFS server needs to be able to write to the
>> > backing filesystem when the dirty memory limits have been reached by
>> > being totally consumed by dirty pages on the NFS filesystem.
>> >=20
>> > The 25% was just a way of giving an allowance of dirty pages to nfsd
>> > that could not be consumed by processes writing to an NFS filesystem.
>> > i.e. it doesn't need 25% MORE, it needs 25% PRIVATELY.  Actually it on=
ly
>> > really needs 1 page privately, but a few pages give better throughput
>> > and 25% seemed like a good idea at the time.
>>=20
>> Yes this part is clear to me.
>>=20=20
>> > per-bdi throttling focuses on the "PRIVATELY" (the important bit) and
>> > de-emphasises the 25% (the irrelevant detail).
>>=20
>> It is still not clear to me how this patch is going to behave when the
>> global dirty throttling is essentially equal to the per-bdi - e.g. there
>> is only a single bdi and now the PF_LOCAL_THROTTLE process doesn't have
>> anything private.
>
> Let me think out loud so see whether I understand this properly. There are
> two BDIs involved in NFS loop mount - the NFS virtual BDI (let's call it
> simply NFS-bdi) and the bdi of the real filesystem that is backing NFS
> (let's call this real-bdi). The case we are concerned about is when NFS-b=
di
> is full of dirty pages so that global dirty limit of the machine is
> exceeded. Then flusher thread will take dirty pages from NFS-bdi and send
> them over localhost to nfsd. Nfsd, which has PF_LOCAL_THROTTLE set, will =
take
> these pages and write them to real-bdi. Now because PF_LOCAL_THROTTLE is
> set for nfsd, the fact that we are over global limit does not take effect
> and nfsd is still able to write to real-bdi until dirty limit on real-bdi
> is reached. So things should work as Neil writes AFAIU.

Exactly.  The 'loop' block device follows a similar pattern - there is
the 'loop' bdi that might consume all the allowed dirty pages, and the
backing bdi that we need to write to so those dirty pages can be
cleaned.

The intention for PR_SET_IO_FLUSHER as described in 'man 2 prctl'
is much the same.  The thread that sets this is expected to be working
on behalf of a "block layer or filesystem" such as "FUSE daemons,  SCSI
device  emulation daemons" - each of these would be serving a bdi
"above" by writing to a bdi "below".

I'll add some more text to the changelog to make this clearer.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6LGVwACgkQOeye3VZi
gblH+RAAlcjEy90rucreHhtSxKfL4Fegmm5J2BHk9DCovgq/umVm/vGLLYQABj/A
Aq0bDdE4za3maOg55/3Ee+b9gkZap68lQDaq0l79Jn0agCdzqrfqIT18CywwfxV5
xP5s00MWhRN9mFa3wGi2nKkL00NRmRptnzJHtmMdfnhjoASjir6tfnYIDJe3jrxQ
TKXMr84sVoEfYd8lb7BDoH8OK4Dr8I1gNl2Us6lsLFk7fnBAzKqr7kYmbd4QNwXR
6T928smDKxptyhlOR02pekY1EqIcXZeQUyQ0ubx02iKj6b7z54nwaMo0VehngPZc
MU17ddYmOS7bbbB6mM+reKumrdH3PWjAz8yadb68jisp8RS7DatBtFx4dkHz8AQh
X3W5J4Hq4/8BxR+IEhbw8iSAz/HUQNPf8hNdvRkuxtc2UAfvzQVzmuAeVIGnb2+i
V3pYl4l63BAjmnVO0kbC/zXEbLetzrjXINeII/swLd3rYKbtMibX4TcAVQfzichK
9hlZ61xT4EXAFy7Zf1Mgi8hwcdpf2gJvPHYFkRqaPMr6jLYNCU/jSc+sgzVUPMmo
IFZGhfOywLVvpMCIob7HF8F1eGjElbrhcGgqoUgc/x4s8kh3lDeR98C9R8SKSI2j
JLm9g7NkU/TQIFhb9+v0V11UboteYMGrwZlh2A7UVXKNrThP56Y=
=QtOq
-----END PGP SIGNATURE-----
--=-=-=--
