Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29231D09B3
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2020 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgEMHQm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 May 2020 03:16:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgEMHQl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 May 2020 03:16:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8867B1DD;
        Wed, 13 May 2020 07:16:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jan Kara <jack@suse.cz>
Date:   Wed, 13 May 2020 17:16:32 +1000
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2 V3] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <20200422124600.GH8775@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87ftdgw58w.fsf@notabene.neil.brown.name> <87wo6gs26e.fsf@notabene.neil.brown.name> <87tv1ks24t.fsf@notabene.neil.brown.name> <20200416151906.GQ23739@quack2.suse.cz> <87zhb5r30c.fsf@notabene.neil.brown.name> <20200422124600.GH8775@quack2.suse.cz>
Message-ID: <871rnob8z3.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain


I thought about this some more and come up with another "simple"
approach that didn't require me understanding too much code, but does -
I think - address your concerns.

I've changed the heuristic to avoid any throttling on PF_LOCAL_THROTTLE
task if:
 - the global dirty count is below the global free-run threshold.  The
   code did this already.
 - (or) the per-wb dirty count is below the per-wb free-run threshold.
   This is the change.

This means that:
 - in a steady stated, all bdis will be throttled based on their (steady
   state) throughput, which is equally appropriate for PF_LOCAL_THROTTLE
   tasks.
 - a PF_LOCAL_THROTTLE task will never be *completely* blocked by dirty
   pages queued for other devices.  This means no deadlock, and that is
   the primary purpose of PF_LOCAL_THROTTLE.
 - when writes through the PF_LOCAL_THROTTLE task start up from idle -
   when there is no current throughput estimate - the PF_LOCAL_THROTTLE
   can be expected to get a fair share of the available memory, just as
   much as any other writer.  This was the possible problem with
   treating PF_LOCAL_THROTTLE just like BDI_CAP_STRICTLIMIT.

So I think this is a good solution.  Thoughts?
Patches follow - I've address the comment formatting issue.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl67ntAACgkQOeye3VZi
gbkPqRAAtxj9x2Nnc8sDId77c2gR7zMDpFPEY6g07dqJpWw0yBr6dWPypKbUpsso
4kqJpJDxKpM/zo6ysnkDPJJmNmgIS5n6s3vQCsumP7+TF3PpnMtAqG2GnvxVOLkN
VPIb4HCghdI0mGS9xeR1OBPHsK8I0HvHg0CGWAo5rCCICRmDAQXCYL5QdGqfLuxj
B/55yI4jzKfH6OaArJrrKWvWVdI825oGSn/bdffz/GighPP1QdLbNz4iWS5ab43O
0tR4m9JjGQIB7RjxnNXp0knc3+2hVqKY6dallTpOpn4fE0n7TeSFu7lvI6wRL7F/
OKLBlY9ca7jeIOcrCwBan5GFOh9Ou0IFvX41ehrFEFUc6dTb4836b8T9HunKP95d
dwL3v1gpFI06IZwb+K0YGrf9MWDSZQeZ/tPyHM2VDFb2Jl3hx+3aVxhhY9bgPtjZ
Mf3cbYBiGWU+xoZwPYKKw4ghNgJDTOZd0ohTTfM0c9TuGp7+NZUtU/3/9J9/Cw91
P4ZNnN4AyW20Jh2ucfACOesx3LorjbvXIwRPaJJ8hLHQVUZ66RJoIs3QJ+5lpbQc
pO6kQ8uTynnSHa5Gt39CnQVjAz2AoXsrU/sKFRQ/HAZd8hyzDXrgnn+EAdy6KwO1
EF92Wa5AIVLDF4qfCuYsLDH4gAUrtRxFqoER4NWMxIJtX8nrChU=
=vbJX
-----END PGP SIGNATURE-----
--=-=-=--
