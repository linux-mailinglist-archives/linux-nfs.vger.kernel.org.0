Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE993521A7
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhDAVcR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 17:32:17 -0400
Received: from mail-eopbgr660089.outbound.protection.outlook.com ([40.107.66.89]:48224
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233588AbhDAVcN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Apr 2021 17:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgP3EOfhvayjDSKTdMVBTKAP5CgQjsqHkY3xJKqSR3POxJkuUcU+usIceV+uSSwdEmDQsFdnCjoT7lWfytFbwTushXjxNMHvBud199zhMa170rXP21BH3ghFr97VxyhuAVyjE3b6RZfd2Y72VmFEgi5g8on1ucJiwka0rIUnKFz1uHPIqm6dYhrAUgQqIhVCFzFGz/Vin+1PGYbTTTUlL3PdsewA5oTK9VcCNaPbX1AezTTOFtZ8P+eFXjI8AcfVQRx445xWHEm/ZALlFEGrgcxDvMgbrBJ5Xjy0ng/hd1VWusGpDL1DF5dzd19Vnc6ER51MKnypbKfwWTW9EbykXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLH23qXEQUaSOEOmOruhqJOFvDHEcSHy6JNwVYM5rF0=;
 b=fZ1zp5arYsRMSkhGLmfmt0nl7xOtRiSo75caH9XqX/wjALZ4PP3LG3CJbsBEViMvV931NfiY6M3IbwrdBwmQS2ZiFh8Ivxa5By+jYCP7D4/0tn7GDmo1APiTlZTo1KsC5ZKxxeRiErDCTrXQXGgOC+GM0C9HM+DuOpFkjP44yCyDph6yz1UGVeLKwOiizv651CV8xHOxGeYRCzmXMO4IqEC/U8GmeG6vFYLUGjlcAuyXtEtqqcqR6G6e6EG/bteGCzyDdGBO/Sh9T5YFKwZEfdPTPDG5vIgLd8e2QEBvqM3oT1XpqiPyo6HURY+ABAOJLlQu3ifm53z0bhSsbaVIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLH23qXEQUaSOEOmOruhqJOFvDHEcSHy6JNwVYM5rF0=;
 b=Mq2MD3nO0jj80R0/icX7F7UFDwXLM6WOE9qsmK+dXVIlv0y6xl/lMOviY0yVGVBa6EQDILWsmZsxHch1+CMA2Z5YJsm9buWj/THuEGZiZq9TIkGFkb+8uGlsfQz9FDSrei4WkX2S3jz9eUPMRUzDOBG9okwCPwg2Yn3qhSlyR51kHE7AP7hw+C6kBONt9jeHki4ggt3KSB2FLCIBPX5eelAokkd/a0a5u6AD4+evR9ebtdWzPU4/5SZalHUcdWswap18CXmX4KfJDYvqSYhBjuMqo7Uqrs/R0cVuD7N3jSJe3l7MYVlc1muU3V7HZNCIA9X3LEwm9GTkCy80hGt8tA==
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:19::29) by YQXPR01MB3911.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:52::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Thu, 1 Apr
 2021 21:32:05 +0000
Received: from YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e]) by YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1c05:585a:132a:f08e%4]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 21:32:05 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within the
 last hole
Thread-Topic: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within
 the last hole
Thread-Index: AQHXJyTCyThckhC0u0WVjmsFImLJ2qqgLJWI
Date:   Thu, 1 Apr 2021 21:32:05 +0000
Message-ID: <YQXPR0101MB0968C9AB372DC12408F496D8DD7B9@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org>,<CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
In-Reply-To: <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36e5f340-54a7-4262-c4dd-08d8f55598d9
x-ms-traffictypediagnostic: YQXPR01MB3911:
x-microsoft-antispam-prvs: <YQXPR01MB39113F6FE54A481FC03D4BFBDD7B9@YQXPR01MB3911.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axUACniszDduJh9MRbQP9GkzBipmuLqENvHDcaZuASMgU7vXzDAS9UKy769+/QS3h7coCXiwz03C3xrYZJVd/+nUJ2WyHfjGrlGxPbzwC0W1/1X3CXtPab/SVpT1E00LeTKDMyVV0sN2b89VXo+Ub6Dh9kczGv8vzQo/6OdKJyk+nNaMJjcoWaIPIgrEKUv6utdiG9mal4qOvL7dwlr+IgZP8daq1NpReNVnf3tDQLSULQ1ZtehlFrQb/nlUuIHXK8KAbKme8eVCkT634NhbiIvvlthUBOaYWG6nxvcDI1IjZ5VoeaGPWcumwCPtVKGJEm5bD6dE6X/GeaNjGAR+WgOTNVIr3BRAEhJ1AD+FnwAgHvM+ZV3Ckc+Bh5JLZcsJd+PgqHuUOZsl7MZLpXa0BmC35utdz3Er00MQPmda/OLav86BwIBkb6eY1QMBqoZElu6bnbRQs0xe682UClnmwwLWxnxlKOXsF2p1XSoSRz48DyXlh/8cPPFGsv3T002GZlrKk6b0gvYP+z+mt0/yEL4xfEVBzZbdPj0dFpPVMb00pdyIooT9qBKEHVHyN+axjdYf53lpwztKwzoPUvGSEJJBPFENXIdxeDFZqODBrwFmqx/2YLMvOQ0u7iasj8hMAhnVPSZwB8kp09+Yu3a3XaGZTy1H5Khbz4oAM3gQHhk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(7696005)(9686003)(76116006)(64756008)(66556008)(66946007)(186003)(6506007)(53546011)(38100700001)(8936002)(4326008)(86362001)(786003)(91956017)(33656002)(478600001)(66476007)(2906002)(5660300002)(66446008)(83380400001)(110136005)(54906003)(52536014)(71200400001)(8676002)(55016002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?NnyIoJpYB+JhKvf9UzB70Ylh0TZxgdzYv6CiERQhPKrbY2u9lCOWaUyiyl?=
 =?iso-8859-1?Q?rB1WFKZ7/QVNqbva31PydHLHSUlvJjN2kTg/EzlATrw+gAkLDVd2Ox3Slx?=
 =?iso-8859-1?Q?EL8kiymBxuSL5FeSyplEvYln8+rrjpn1VyKTIijIfZ5yR1iyq35T7JPul5?=
 =?iso-8859-1?Q?g53DeL6w4kp+Y+uHOWF2p4Gqa9uRbNnYHU7a9w2IVlgkg4sE6aPgJ6orvy?=
 =?iso-8859-1?Q?zI18Y5+y/mKxXL8QImmGZTPPgWAl6/7fxDegRIPSJrRN1lIyh5b007TMcw?=
 =?iso-8859-1?Q?rip8DXbVoM2mYrg1a33IACbpGKQaysSogTaYq39tWUayhfykRbBldBoYS1?=
 =?iso-8859-1?Q?VA8xSpvb0mMAcjqSsHqkpJupHlXdsq1GhIljHF0M6aYwZeCRwIZB0wvfJQ?=
 =?iso-8859-1?Q?ajqFZvlafjh5ERodHu/V5B/0j4zq0tTsgc5zehpyKlRxwOhky0jKtdNDUP?=
 =?iso-8859-1?Q?MGV/fYYFA3No3ke44eLGCqM1Hb3fHRj3T4aD0OshpAk+UKcGHj7OjS2tAD?=
 =?iso-8859-1?Q?iA3HmKxoUAVCcFQcdFaoUbbYnEz56aaGi6Aaon6jDvKK7960QSUotG6W6X?=
 =?iso-8859-1?Q?w11zPcIH0V26ealfEj5xjuoBgJ6uYhaNGB4c6XlfC6iAtsrn1NNcfgK4GE?=
 =?iso-8859-1?Q?Beee4el1eVei3h6hcRmxBEM6l8ldMM0H73XOsylJwmi9+L/zRWIPpthauZ?=
 =?iso-8859-1?Q?E0YP2WpB1U/xA5y6T6bJgeuZWeRetHWNkQPNGmHrFIoIbLeggZh90VVegU?=
 =?iso-8859-1?Q?zpQBRr2341D/z9DVqiYNEwRmoV0sI5Dounp4+z2eXFa14totYzDbUZqBc+?=
 =?iso-8859-1?Q?6NtDTgzKnQTSFIU1scK1JOPZr9XtcDUWUn5mM5K53MQg9Nc+64/rMjtPK1?=
 =?iso-8859-1?Q?qQetqcf91fE82d94hC2NQAMp4U6/HH4rR7o/DsO7EJ5DsscfsSBo3kgZ/K?=
 =?iso-8859-1?Q?PIif+aeHlYiuhewH8EQqSjFV9UWU41gKI2k1JxLGQ710wXTvtwFUi0CmZJ?=
 =?iso-8859-1?Q?hOOB4iIV169g0XqR8O4nOH0esLrgaji85vIhDvaENAb3a24g3gE+XiYUNb?=
 =?iso-8859-1?Q?n7TExOsic+xsYsKqW2MznATDm0E4OzFLj5XRGBfm8gfTwwCwtHgcalVxhv?=
 =?iso-8859-1?Q?K4wiVQRGrGSLyc4nFz3UiOUB7AcDX70ThokMPkf7kVorss+ctHONMBQVLT?=
 =?iso-8859-1?Q?UiCtRv6tFMVdhQlpzV1AgcUEG6R+hrH30OLOveGwg10iNrDgj902hPnQn2?=
 =?iso-8859-1?Q?e0kKUWjOoG5F6oMJQ2eyenonzYj3/nLaH7KoKwmrC7jVVCx+Tev/qqBU2P?=
 =?iso-8859-1?Q?oYxWDEecvkjKHSC+kpHp0J8Y/S31/oUc22RdV3VNJbv9UPOy0smnlhDMyS?=
 =?iso-8859-1?Q?hKFXWeje5ylHqzGiKzsouaGC5R8VN5zVlhDObpZvvMz1k/OiuJkPY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e5f340-54a7-4262-c4dd-08d8f55598d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 21:32:05.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6QpGBcHLe9mi8hzeTm+LtcePWGuvVHvbtE5qDyUHq9BG9OflMudkBbOk67mtGZS7Gh9q9sp0xK8U85jfMTn9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3911
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I discussed this on nfsv4@ietf.org some time ago.=0A=
The problem with "fixing" the server is that it breaks=0A=
the unpatched Linux client.=0A=
=0A=
If the client is careful, it can work correctly for both a Linux=0A=
and RFC5661 conformant server. That's what the FreeBSD=0A=
client tries to do.=0A=
--> I'd suggest that be your main goal.=0A=
=0A=
The FreeBSD server ships "Linux compatible", but there is=0A=
a switch to make it RFC5661 compatible.=0A=
--> I wouldn't make it default the RFC compatible for=0A=
      quite a while after the client that handles RFC compatible=0A=
      ships.=0A=
=0A=
I tried to convince folks to "errata" the RFC to Linux=0A=
compatible (since Linux was the only shipping 4.2 at=0A=
the time, but they did not consider it an "errata").=0A=
=0A=
Just mho, rick=0A=
=0A=
________________________________________=0A=
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>=0A=
Sent: Thursday, April 1, 2021 9:27 AM=0A=
To: J. Bruce Fields=0A=
Cc: Chuck Lever; linux-nfs=0A=
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within =
the last hole=0A=
=0A=
CAUTION: This email originated from outside of the University of Guelph. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe. If in doubt, forward suspicious emails to IThelp@uo=
guelph.ca=0A=
=0A=
=0A=
On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wrote:=
=0A=
>=0A=
> On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:=0A=
> > From: Olga Kornievskaia <kolga@netapp.com>=0A=
> >=0A=
> > According to the RFC 7862, "if the server cannot find a=0A=
> > corresponding sa_what, then the status will still be NFS4_OK,=0A=
> > but sr_eof would be TRUE". If there is a file that ends with=0A=
> > a hole and a SEEK request made for sa_what=3DSEEK_DATA with=0A=
> > an offset in the middle of the last hole, then the server=0A=
> > has to return OK and set the eof. Currently the linux server=0A=
> > returns ERR_NXIO.=0A=
>=0A=
> Makes sense, but I think you can use the return value from vfs_llseek=0A=
> instead of checking the file size again.  E.g.:=0A=
>=0A=
>         seek->seek_pos =3D vfs_llseek(nfs->nf_file, seek->seek_offset, wh=
ence);=0A=
>         if (seek->seek_pos =3D=3D -ENXIO)=0A=
>                 seek->seek_eof =3D true;=0A=
=0A=
I don't believe this is correct. (1) ENXIO doesn't imply eof. If the=0A=
specified seek_offset was beyond the end of the file the server must=0A=
return ERR_NXIO and not OK. and (2) for the same reason I need to=0A=
check if the requested type was looking for data but didn't find it=0A=
because the offset is in the middle of the hole but still within the=0A=
file size (thus the need to check if the seek_offset is within the=0A=
file size). But I'm happy to check specifically if the seek_pos was=0A=
ENXIO (and not the generic negative error) and then also check if=0A=
request was for data and request was within file size.=0A=
=0A=
Also while I'm fixing this and have your attention, Can you tell if=0A=
the "else if" condition in the original code makes sense to you. I=0A=
didn't touch it but I don't think it's correct. "else if=0A=
(seek->seek_pos >=3D i_size_read(file_inode(nf->nf_file)))" I don't=0A=
believe this can ever happen. How can vfs_llseek() ever return a=0A=
position that is greater than the size of the file (or actually even=0A=
equal to it)?=0A=
=0A=
>         else if (seek->seek_pos < 0)=0A=
>                 status =3D nfserrno(seek->seek_pos);=0A=
>=0A=
> --b.=0A=
>=0A=
> >=0A=
> > Fixes: 24bab491220fa ("NFSD: Implement SEEK")=0A=
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>=0A=
> > ---=0A=
> >  fs/nfsd/nfs4proc.c | 10 +++++++---=0A=
> >  1 file changed, 7 insertions(+), 3 deletions(-)=0A=
> >=0A=
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c=0A=
> > index e13c4c81fb89..2e7ceb9f1d5d 100644=0A=
> > --- a/fs/nfsd/nfs4proc.c=0A=
> > +++ b/fs/nfsd/nfs4proc.c=0A=
> > @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,=0A=
> >        *        should ever file->f_pos.=0A=
> >        */=0A=
> >       seek->seek_pos =3D vfs_llseek(nf->nf_file, seek->seek_offset, whe=
nce);=0A=
> > -     if (seek->seek_pos < 0)=0A=
> > -             status =3D nfserrno(seek->seek_pos);=0A=
> > -     else if (seek->seek_pos >=3D i_size_read(file_inode(nf->nf_file))=
)=0A=
> > +     if (seek->seek_pos < 0) {=0A=
> > +             if (whence =3D=3D SEEK_DATA &&=0A=
> > +                 seek->seek_offset < i_size_read(file_inode(nf->nf_fil=
e)))=0A=
> > +                     seek->seek_eof =3D true;=0A=
> > +             else=0A=
> > +                     status =3D nfserrno(seek->seek_pos);=0A=
> > +     } else if (seek->seek_pos >=3D i_size_read(file_inode(nf->nf_file=
)))=0A=
> >               seek->seek_eof =3D true;=0A=
> >=0A=
> >  out:=0A=
> > --=0A=
> > 2.18.2=0A=
> >=0A=
>=0A=
