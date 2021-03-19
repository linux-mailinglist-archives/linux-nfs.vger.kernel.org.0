Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060CF341387
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 04:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhCSDg4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 23:36:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233526AbhCSDgb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Mar 2021 23:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49FC6AC1F;
        Fri, 19 Mar 2021 03:36:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 19 Mar 2021 14:36:24 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
In-Reply-To: <20210302032733.GC16303@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
Message-ID: <87y2ejerwn.fsf@notabene.neil.brown.name>
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

> On Tue, Mar 02, 2021 at 02:01:36PM +1100, NeilBrown wrote:
>> On Mon, Mar 01 2021, J. Bruce Fields wrote:
>>=20
>> > I've gotten requests for similar functionality, and intended to
>> > implement it using directory notifications on /proc/fs/nfsd/clients.
>>=20
>> I've been exploring this a bit.
>> When I mount a filesystem, 2 clients get created.
>> With NFSv4.0, the second client is immediately deleted, and the first
>> client is deleted one grace period after the filesystem is unmounted.
>> With NFSv4.1 and 4.2, the first client is immediately deleted, and the
>> second client is deleted immediately after the unmount.
>
> Yeah, internally it's creating an "unconfirmed client" on SETCLIENTID
> (or EXCHANGE_ID) and then a new "confirmed client" on
> SETCLIENTID_CONFIRM (or CREATE_SESSION).
>
> I'm not sure why the ordering's a little different between the 4.0/4.1+
> cases.

The multiple clients are not really nfsd's "fault".  The Linux NFS
client sends multiple EXCHANGE_ID or SET_CLIENT_ID requests, so NFSD
really does need to create multiple clients.

For NFSv4.0, when nfsd gets a repeat SET_CLIENT_ID, it keeps the old one
and discards the new.
For NFSv4.1, the spec requires that it keep the new one and discard the
old.
This explains the different ordering.

So the clean up the logging, mountd needs to be able to see the
confirmation status.
Following this reply will be a patch to nfsd to provide this status, and
a patch to mountd/exportd to use this status.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBUHDkOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbnvnQ//W4SycSzjzHMlv3y4/RCeMoBJQOP2MUxWk3QZ
UzA5WpqsBFwmH00hYJvbAiDKpZ3ywS4rghS0GPq1JoNlTKQb5J359B/BJsMOzM6S
8YuqqAeQNKCqWUeajRCZXa35i2o/zNZZn5Rt/sx3EY++mhihYeaO2R7iVTU05D5Z
qbbHHuJ4SrFuJrXCHP13QssmZ5YVTldYzrWy9bh5PjLrhtfSOCDQUelYL5Jt5+EH
jaS3wAXqxP5TcWCWx1lOqN1jwQiY4MsF5dqGXYyE1Rhia9uTXrdjRnrCHiGocMyg
4rS+HxqPKwEdqSTqFB1y9z/dvdBkSCI1aeTQuXfFwoARjVxKZ6RQWwIT5Y1pqSnL
NBWk1IoVP67/N+Bb4G+h9TDZL2z3yqkji+UquRxz7D0/OSkK5c9ac2D5g/hmt/RC
y0AAfcn10XlqirN+N9rWbTqb49PqX4EFJQSbUnUZh5tyi+cV47S3A1u/aPbWHmq7
wiOn+vCwogtDgSw6rTwQJp5P1XcX0CSa9iUntB5OIUDIfkMr+Af8oTcxc1f2EVHU
vJycSBEixNKcdL9um4mxzXFwW/boYsOSJ8MoLElmho6LbR4nqWkvNmtWVA6G/rWm
1lFseGSz/7uP1f/8iYEtvNbZIRxFUPVJPd8ZxZhZGT0uZ42Z9Z0IEcXa31QbEuju
1vlFPTY=
=ZV5V
-----END PGP SIGNATURE-----
--=-=-=--
