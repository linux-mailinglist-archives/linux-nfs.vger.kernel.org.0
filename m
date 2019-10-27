Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D385E6A3F
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2019 00:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfJ0Xte (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Oct 2019 19:49:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:43522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbfJ0Xte (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 27 Oct 2019 19:49:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71D49AEAC;
        Sun, 27 Oct 2019 23:49:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Date:   Mon, 28 Oct 2019 10:49:26 +1100
Cc:     linux-nfs@vger.kernel.org
Subject: Re: uncollected nfsd open owners
In-Reply-To: <20191026213606.GA11394@fieldses.org>
References: <87mudpfwkj.fsf@notabene.neil.brown.name> <20191025152047.GB16053@pick.fieldses.org> <20191026213606.GA11394@fieldses.org>
Message-ID: <87h83tg35l.fsf@notabene.neil.brown.name>
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

On Sat, Oct 26 2019, J. Bruce Fields wrote:

> On Fri, Oct 25, 2019 at 11:20:47AM -0400, J. Bruce Fields wrote:
>> On Fri, Oct 25, 2019 at 12:22:36PM +1100, NeilBrown wrote:
>> >  I have a coredump from a machine that was running as an NFS server.
>> >  nfs4_laundromat was trying to expire a client, and in particular was
>> >  cleaning up the ->cl_openowners.
>> >  As there were 6.5 million of these, it took rather longer than the
>> >  softlockup timer thought was acceptable, and hence the core dump.
>> >=20
>> >  Those open owners that I looked at had empty so_stateids lists, so I
>> >  would normally expect them to be on the close_lru and to be removed
>> >  fairly soon.  But they weren't (only 32 openowners on close_lru).
>> >=20
>> >  The only explanation I can think of for this is that maybe an OPEN
>> >  request successfully got through nfs4_process_open1(), thus creating =
an
>> >  open owner, but failed to get to or through nfs4_process_open2(), and
>> >  so didn't add a stateid.  I *think* this can leave an openowner that =
is
>> >  unused but will never be cleaned up (until the client is expired, whi=
ch
>> >  might be too late).
>> >=20
>> >  Is this possible?  If so, how should we handle those openowners which
>> >  never had a stateid?
>> >  In 3.0 (which it the kernel were I saw this) I could probably just put
>> >  the openowner on the close_lru when it is created.
>> >  In more recent kernels, it seems to be assumed that openowners are on=
ly
>> >  on close_lru if they have a oo_last_closed_stid.  Would we need a
>> >  separate "never used lru", or should they just be destroyed as soon as
>> >  the open fails?
>>=20
>> Hopefully we can just throw the new openowner away when the open fails.
>>=20
>> But it looks like the new openowner is visible on global data structures
>> by then, so we need to be sure somebody else isn't about to use it.
>
> But, also, if this has only been seen on 3.0, it may have been fixed
> already.  It sounds like kind of a familiar problem, but I didn't spot a
> relevant commit on a quick look through the logs.
>
I guess I shouldn't expect you to remember something from 8 years ago.
This seems a perfect fit for what I see:

commit d29b20cd589128a599e5045d4effc2d7dbc388f5
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Thu Oct 13 15:12:59 2011 -0400

    nfsd4: clean up open owners on OPEN failure
=20=20=20=20
    If process_open1() creates a new open owner, but the open later fails,
    the current code will leave the open owner around.  It won't be on the
    close_lru list, and the client isn't expected to send a CLOSE, so it
    will hang around as long as the client does.
=20=20=20=20
    Similarly, if process_open1() removes an existing open owner from the
    close lru, anticipating that an open owner that previously had no
    associated stateid's now will, but the open subsequently fails, then
    we'll again be left with the same leak.
=20=20=20=20
    Fix both problems.

I wonder if this is safe to backport ... 3.2 is fairly close to 3.0, but
there have been lots of changes to the code since then ... maybe there
are more bug fixes.
I'll work something out.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl22LQYACgkQOeye3VZi
gbmiNw/+IMJFmxW197DzKRHNtMKS0TVPKrfaDGaPe0D47cMZpzKOewrPlsAmVc+b
4PDlWiZMoeYOuan/Io1OfRa26li43f2hc9fapbY3PXFfxSXvt6pWzNSeEgTum+Wz
U34yxBAEhzxprZ+me9b8Bd929ghzAjAcf9id9wJsLBXPngCm8A2mYtDXX+v6sXXx
g8jFl2NhasOs3VnddsO5gMFEyEFUiAOmFbFb2/pTAj+qMKPwSn5JskSNCuBGfC3l
uW6JiwXgef45onkYg0QROXm8WRoOs9mdLm4LDmD6/g7zGyjW9TyEcbxVx96lg4LA
9u84CIAssjKDHjAC0f/99IMsiMsyu23A64cAZO6N0R5OcelCOBcSGqSdDTrt4dq9
0GJZdsYWncBBRLJeItqzkgHiGgtx+yoFvXrpcv/u/S3cXHEfT1+ynGMR+5Ky/8Lr
5aH//zjtfQjNNOXMlQLG3IXaWo9er+kzhidLb/m7waXGs6UaaAGX/3TYvI/mDGKJ
lufx5TMklpXUlyVpKRgyuZLn8ye67qadq7xopzTo2xcdvmi18vlVbFRLfW5ngoev
QD79hImLEArUF3jPRUQm9QY01r4A6HY1mHOHw+6wM8KwWi9GJQw/ZCnsIsU2MsJq
llej+NkVfdwGO0PTUcoTwsqrXaT2FS05F1r9+t0wpbsvtMsOXZc=
=wkIV
-----END PGP SIGNATURE-----
--=-=-=--
