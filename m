Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB83142FB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhBHW2b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 17:28:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:49076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231235AbhBHW2W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Feb 2021 17:28:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91CADACF4;
        Mon,  8 Feb 2021 22:27:33 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Tue, 09 Feb 2021 09:27:29 +1100
Subject: Re: [PATCH 2/2] mountd: Add debug processing from nfs.conf
In-Reply-To: <66fbe743-aa9d-ca60-8955-c2859d9ab9df@RedHat.com>
References: <20210201230147.45593-1-steved@redhat.com>
 <20210201230147.45593-2-steved@redhat.com>
 <87y2fzcsfc.fsf@notabene.neil.brown.name>
 <66fbe743-aa9d-ca60-8955-c2859d9ab9df@RedHat.com>
Message-ID: <87sg66ci0e.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08 2021, Steve Dickson wrote:

> On 2/7/21 7:30 PM, NeilBrown wrote:
>> On Mon, Feb 01 2021, Steve Dickson wrote:
>>=20
>>> Signed-off-by: Steve Dickson <steved@redhat.com>
>>> ---
>>>  nfs.conf              | 2 +-
>>>  utils/mountd/mountd.c | 3 +++
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/nfs.conf b/nfs.conf
>>> index 186a5b19..9fcf1bf0 100644
>>> --- a/nfs.conf
>>> +++ b/nfs.conf
>>> @@ -30,7 +30,7 @@
>>>  # udp-port=3D0
>>>  #
>>>  [mountd]
>>> -# debug=3D0
>>> +# debug=3D"all|auth|call|general|parse"
>>>  # manage-gids=3Dn
>>>  # descriptors=3D0
>>>  # port=3D0
>>> diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
>>> index 988e51c5..a480265a 100644
>>> --- a/utils/mountd/mountd.c
>>> +++ b/utils/mountd/mountd.c
>>> @@ -684,6 +684,9 @@ read_mount_conf(char **argv)
>>>  	if (s && !state_setup_basedir(argv[0], s))
>>>  		exit(1);
>>>=20=20
>>> +	if ((s =3D conf_get_str("mountd", "debug")) !=3D NULL)
>>> +		xlog_sconfig(s, 1);
>>> +
>>=20
>> Why is this needed?
>> A few lines higher up is
>>   	xlog_from_conffile("mountd");
>> which calls
>>  	kinds =3D conf_get_list(service, "debug");
>> and passes each word that it finds to xlog_sconfig()
>> ??
>>=20
>> I just tested setting "debug=3Dall" in the mountd section of nfs.conf,
>> and it seems to work without this patch.
> No it is not... I didn't realize xlog_from_conffile() process
> the debug config variable... maybe we should change the name
> to something like xlog_debug_conffile()... something more
> descriptive as to what it does.
>
> I will clean it up... in a bit.

Thanks.  I agree that including "debug" in that function name would
help. Maybe "conffile_set_debug()", or your suggestion.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCAAuFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmAhutEQHG5laWxAYnJv
d24ubmFtZQAKCRA57J7dVmKBuXcTEACoZJXrmp2B+ruTDCThBg37IhG3c8MpGFyU
PeV7gvK9wm0Cnps2K2mREAgfcmpfeITpVFeFdTmpnEwyzLGw3PdC/iPjP+Lt3Dz+
vdTien4r82aQkzZYNSloUlOxj3sxBdUKpI0TNA7zjU7hW2MymOrzfdJzHvTPTqq5
oV7E9e04v+9gXjOmKbO8taO1Y+oQBVNdVv5TXMpN6/ptKEx4C1/9G+w3hMNo5Mjy
hGoSSNgJFXjJgOCKP83JNuyxgfHh5Hi4viIhz4kNIjXTbR4vhzDMkfbvMqugqtgC
gDAbTjzrL6UFizh+B3/U4Scfs52HF8F4bLWDAywu0qB1UXyXJ0QYV4kjEzKIiSXe
3Om5B3JPN0lNpOgspPlIhhD0zKg0AMYMM5d8q20oKU/yJVh67l6Tt9MGPKVzLVJE
gVQRxse22YJ4RxPOYVWcHSGut0VVBG2gxrYiZsmTnrSATHH5OjlFFZl74ZLZr4O7
siEHN9s235VJB8bmnY4GrIFMEFCsOQFdgEcnlv4skHefZg6/4O7OFWLXxw3CVKyt
mFyd7EquoIKdta1lAswRUhWblm+LWDP6ysaWsaNd5ohpOMEOLgAZVj7ViHk7eOcp
S1C/iH9OlFtJ39TQOttTdWmVi8YsxZu/x3TO5bzHNEA8yYQutSvPfQGAb5BvhfEI
knSZxqj6Qg==
=/YU1
-----END PGP SIGNATURE-----
--=-=-=--
