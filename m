Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8632A93B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244632AbhCBSPj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:15:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:49194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444718AbhCBCoT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 21:44:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B079CABF4;
        Tue,  2 Mar 2021 02:26:23 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Yongcheng Yang <yoyang@redhat.com>
Date:   Tue, 02 Mar 2021 13:26:18 +1100
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
In-Reply-To: <20210301034312.GA12690@yoyang-pc.usersys.redhat.com>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301034312.GA12690@yoyang-pc.usersys.redhat.com>
Message-ID: <877dmqi94l.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01 2021, Yongcheng Yang wrote:

> Hi NeilBrown,
>
> Shall we further add these 2 options (cache-use-ipaddr & ttl) with
> their default values to the file /etc/nfs.conf under section [mountd]?
> By which the users can find it easier to configure them.
>
> Also someone may check the mountd "Recognized values" from
> nfs.conf(5), the file systemd/nfs.conf.man may also needs to be
> updated mentioning "cache-use-ipaddr" and "ttl" IMHO.=20

Excellent suggestion, thanks.

I've made those changes and will resend the series.

Thanks,
NeilBrown

>
> Thanks,
> Yongcheng
>
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
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmA9oksOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbljsQ/+P8sYq4w/PVHoJHPSSWBSRrJRiXc14bG7ivlN
EbBRywI1PrhrGUvu5vrTR1EV8PV4HPXYz8ZbSKUZ6oweDy/7n7MaMZTtpvrZIR3V
bz7g8ctjZh6VOb6OxpoDjQgw3fx3ow+X3nQkQCYdYCWnOATlozPvd988XaXtBq7V
mWD3CCb9xQ32YiyhUDTxi0Awdnfo6iM0r8iuy1QfTV7YcluiVCtrZPZdXL7Gl9fk
XnSI29wPQ95TxZMSnVumWF0VPuhufaJaw0dK99LYKVr1zUlORgCWBdLJi1PEDVkG
B+DuqRVR/yPKQsyhEMacOTqmANKooSG/SVL8oRBDpOMqbPSZ/EEA/qLWA+hEpNyy
aAUnnAav6/6X6Ldxo25th+sz0EtiiKJfsn0GZahPuPPpGJh6zpCzHMUJY3N+P/ST
xCC581YOZGSxbb8qiJyqGR8Q8mXlgJnyu5NCFhVOmCiOv45cyAlltizxbZzSD1IX
+rChgis0j8r+VALxvwc06XZYwuk2hezqijj3QQKGJ4vp/m6rkYQhxd6fmyCWGQ8Q
iESGFOjmhgyYwJ0vVacCke4VlxJ86KRvlNNhn5OCk0YWECQ9tsmx5oI2r9cQpKlY
w0npk753dJdLZm1brxjq8wuvsLn8orF5nFVrSCt4kxCFnlXeJ0EhXttnTw96Cbj+
Ff3WHVY=
=H6IU
-----END PGP SIGNATURE-----
--=-=-=--
