Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46E19EECA
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 02:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDFAO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Apr 2020 20:14:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgDFAO3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 5 Apr 2020 20:14:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83147AC2D;
        Mon,  6 Apr 2020 00:14:24 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Michal Hocko <mhocko@kernel.org>, Jan Kara <jack@suse.cz>
Date:   Mon, 06 Apr 2020 10:14:16 +1000
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 - v2] MM: Discard NR_UNSTABLE_NFS, use NR_WRITEBACK instead.
In-Reply-To: <20200403110358.GB22681@dhcp22.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87sghmyd8v.fsf@notabene.neil.brown.name> <87pncqyd7k.fsf@notabene.neil.brown.name> <20200402151009.GA14130@infradead.org> <87h7y1y0ra.fsf@notabene.neil.brown.name> <20200403094220.GA29920@quack2.suse.cz> <20200403110358.GB22681@dhcp22.suse.cz>
Message-ID: <87pnclwjvr.fsf@notabene.neil.brown.name>
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

On Fri, Apr 03 2020, Michal Hocko wrote:

> On Fri 03-04-20 11:42:20, Jan Kara wrote:
> [...]
>> > diff --git a/mm/vmstat.c b/mm/vmstat.c
>> > index 78d53378db99..d1291537bbb9 100644
>> > --- a/mm/vmstat.c
>> > +++ b/mm/vmstat.c
>> > @@ -1162,7 +1162,6 @@ const char * const vmstat_text[] =3D {
>> >  	"nr_file_hugepages",
>> >  	"nr_file_pmdmapped",
>> >  	"nr_anon_transparent_hugepages",
>> > -	"nr_unstable",
>> >  	"nr_vmscan_write",
>> >  	"nr_vmscan_immediate_reclaim",
>> >  	"nr_dirtied",
>>=20
>> This is probably the most tricky to deal with given how /proc/vmstat is
>> formatted. OTOH for this file there's good chance we'd get away with just
>> deleting nr_unstable line because there are entries added to it in the
>> middle (e.g. in 60fbf0ab5da1 last September) and nobody complained yet.
>>=20
>> What do mm people think? How were changes to vmstat counters handled in =
the
>> past?
>
> Adding new counters in the middle seems to be generally OK. I would be
> more worried about removing counters though. So if we can simply print a
> phone value at the very end then this should be a reasonable workaround.

At the very end?
Do you mean not have "nr_unstable 0" appear at all, but having "dummy 0"
appear at the end just so that the number of lines doesn't decrease?
Am I misunderstanding?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6KdFgACgkQOeye3VZi
gbk9eRAAgpuSPME4j7VuvpAzToqgPRWUqCepTVE70zZqQHFCfaVdhSnZZPPW6qhi
vrup/0wKoQBzB3zHQDDX9vEeIiwO5wyC3FTTN4moD8LhJ3i+hsixC3GPBw4Ptr1p
V5scdcdecrGMOsAXcOIV9VFLpHe+Jn1ScakAPPU7mWi7mhUQ34U1vjTBTlPzzOQC
0mWJtmD4i8IIPDwX5W0g6cbDQNRmgFnwmPrNLIw62knSZgOZHb7tjG2MZ4HS73E5
xle7reCfleLezyB7HbJwBY352Oz6kUhb8ogiXcDk2iP8c7CqciUvkp20yPM2IkLB
sjx62r5PKer719o0BdB+ISCJmQJ6IycMHXB9aptLoWi0Xw3JvOwWvY5C/bgDq96E
R6R7Ekb77H8mhZmBNGYjOqJTib9QY19nhrp9PcAzlD8g2/5fw6KI1kW/K11ucaGa
QBErUxFm5dreRivJZklhgLUStMd68i6ALdiNu8XQLoVILfVCGDaLJo5tNK9nWzGr
sJ//OTsSa5/qw522j9EWHju8SB1jDgmG5upoyhxzTbNXhGLYbfwbVRjtZQdEwtU+
HmLHW7w/EGBcK4XaMZHp1uKUClxwwCRR4y+0pj51mNtfu8zZ+KqHXsNo+SZjJ8fX
GQ05sBO9+Iayuy+Todsgcy5MXerd2nETnq0HNJBdo8gpZZkbURk=
=znt9
-----END PGP SIGNATURE-----
--=-=-=--
