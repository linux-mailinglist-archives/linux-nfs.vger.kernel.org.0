Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657841A01B3
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 01:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDFX2d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 19:28:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgDFX2d (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Apr 2020 19:28:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F455ABEA;
        Mon,  6 Apr 2020 23:28:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jan Kara <jack@suse.cz>
Date:   Tue, 07 Apr 2020 09:28:19 +1000
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 - v2] MM: Discard NR_UNSTABLE_NFS, use NR_WRITEBACK instead.
In-Reply-To: <20200403094220.GA29920@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87sghmyd8v.fsf@notabene.neil.brown.name> <87pncqyd7k.fsf@notabene.neil.brown.name> <20200402151009.GA14130@infradead.org> <87h7y1y0ra.fsf@notabene.neil.brown.name> <20200403094220.GA29920@quack2.suse.cz>
Message-ID: <87k12sw5ws.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Apr 03 2020, Jan Kara wrote:
>
> So I don't think we can just remove lines from procfs files like this. That
> has a high potential of breaking some userspace app that is not careful
> enough when parsing the file. So I think that we need to leave there the
> format string and just replace K(node_page_state(pgdat, NR_UNSTABLE_NFS))
> with 0.

OK.  I assume changing the static trace points isn't a problem though?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6LuxQACgkQOeye3VZi
gbnfBQ//YmR4QcCtxB8I35791ntzSvFx751DsikAAi8zGSqNKdH1bEf5602n4pAE
b4aMLG9qPDPGYpAYwae65k2Rg+JHbiPJC8gzpcisA9BMQnmH1Yj3z4t0tYoxR+7z
1t/KpJftRVscqSsYhWkzG0Qmo7zveFKcuKh238HAIGC6afP05ZS16SDAcg6O4D7S
EntFueWyu4kKBgnwPvciVoMTHHEpijIOX84eRB1sz6I33e1/TuX88y+uTdKNGjzZ
rBdNxX5J0GMdARgKKCdkg4wunAqordQOZGkAM0cGCeTxR0IEuyWbIK4DT03jzrTQ
asy/NjfBCMXQEpbeBMZncT3Mtd1m1rfOt3CnrnwmvCjIuJPdcFQvUeQirOYepwm5
r3qd/rYzdFqqlijeYNNEuwaJZb7+jK5HVcPXkxwJ5meSb03S2zKeI2j5I44AmDXd
TNOqZzRzp1WAeQrE7RhN1zMez2mBwV6TK426bPe50wTsXdj4pBfJhGNUiCcdbrkl
7+zJb+HW5LP6QFl+QYfxUtqWhIKduwIvQsuqmu7UCHegHclqeYSPxEdI8ai1atHQ
lpFBcVZv3rNkS/pEC6CJ6Aig9hObJpR0A29xSvD1IOlIRuwDwfzKYwA7+HfF16ci
VjtstzOpFoAdyHp1fttsztwQiYl3GtTrcSTVXjVFv45AlA9e1Pg=
=qYtq
-----END PGP SIGNATURE-----
--=-=-=--
