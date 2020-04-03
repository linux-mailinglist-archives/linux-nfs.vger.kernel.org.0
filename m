Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31019E071
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 23:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgDCVk1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Apr 2020 17:40:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgDCVk1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Apr 2020 17:40:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 511B1ACED;
        Fri,  3 Apr 2020 21:40:25 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Date:   Sat, 04 Apr 2020 08:40:17 +1100
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <20200403151534.GG22681@dhcp22.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87sghmyd8v.fsf@notabene.neil.brown.name> <20200403151534.GG22681@dhcp22.suse.cz>
Message-ID: <878sjcxn7i.fsf@notabene.neil.brown.name>
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

> On Thu 02-04-20 10:53:20, Neil Brown wrote:
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
>
> While I understand that you want to have per bdi throttling for those
> "special" files I am still missing how this is going to provide the
> additional room that the additnal 25% gave them previously. I might
> misremember or things have changed (what you mention as non-trivial
> heuristics) but PF_LESS_THROTTLE really needed that room to guarantee a
> forward progress. Care to expan some more on how this is handled now?
> Maybe we do not need it anymore but calling that out explicitly would be
> really helpful.

The 25% was a means to an end, not an end in itself.

The problem is that the NFS server needs to be able to write to the
backing filesystem when the dirty memory limits have been reached by
being totally consumed by dirty pages on the NFS filesystem.

The 25% was just a way of giving an allowance of dirty pages to nfsd
that could not be consumed by processes writing to an NFS filesystem.
i.e. it doesn't need 25% MORE, it needs 25% PRIVATELY.  Actually it only
really needs 1 page privately, but a few pages give better throughput
and 25% seemed like a good idea at the time.

per-bdi throttling focuses on the "PRIVATELY" (the important bit) and
de-emphasises the 25% (the irrelevant detail).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6HrUIACgkQOeye3VZi
gbmw9RAAqwZBhuc0mji+8z77xXmpuIRdxZtz5yjKjpurelYayyVuKTquw4+aO+ib
7ragLhHuVIc9JV15Zu4vrbajDiy7uQhJdISTNE4b+JZ9FblQ9+2bqBYJwu8GZ+sn
an6XpC3bWHKroN5m+eJSeArrhsT8uXbMUYqx7MJVGXzOAwfxzxOKXRQnGsRlgUZp
DLs4OtI0cPbkQ5+3FBNkhznS29o33dRVLiuiVhBflHek5eHAFctq5zeOx9cDlGvt
d7Dk/XmXHqR4952XLCCCxCk37FxiXqiiQd4xs/ZbTbkRhd4RBLFBahirTHAbbFEu
Ntrso2lvM3fnan7JmuO+vanChCCZ+Ggactvkrdz4CvmGouJ1Ln5XO1h1iX00NBvM
5GxDvL9DSBlINl4cdN6xaVjQOhWSNoRejOG19VF4pn2opWJjB9KXEDtzc5qDwtK7
Eq1FlzEQ8EwJB7wK5Hyv3VmrICQU96h+eh+jBqnpaxq3Fz3Trojdgh3VcY25P1T8
RXOfD7wGdvYk2FZhjxBOQHcikAw3jl5LGyI77VAQf3eiROphl0+Q1kLp9Ugniaso
0tna59vfaEdFeZogPtQ7piy91l1bvtj1SoP7BODnI/PQ8hEyCGaA9IFKg0dpsTVW
k/7TZMXpTi866D9ct+/sLG2Lc6u7QKwhclHSAh2Waw/6m7d0wlg=
=XeBp
-----END PGP SIGNATURE-----
--=-=-=--
