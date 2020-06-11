Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C546E1F708E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2020 00:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFKWrA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 18:47:00 -0400
Received: from mail-eopbgr670046.outbound.protection.outlook.com ([40.107.67.46]:13728
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgFKWq7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Jun 2020 18:46:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLdJtI6JvZ9uj9ZZTHvjTFH27dM7KbBL2hZWMUoOwXVnrmhj+h1Dfd/Y+LksTRUfqYoDB1UByYtGwtmFVr9sJM9tbkzAibIciQfkOu0GTJkL3v28nEMSceEU/eWtsjSDLBUqfLacltozvc+LiPkVPKwCxHyIBFftvJ2L1rqmJx94E947tOAvgtJTNbAyplYMq8/TBOzfPp3qcYongAblNgIiScbEidrfCLZGk/rT5wuuFuWz9lc5EZp1n2FglcBdOCgvVT3gO0OJy4dWuW56RZu0cSVWnJD0q9ruFJsWt9xC+DNBE8qc1BXnhYhsx5xSpsBDOnzCBKAXcFNnRn6PfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuLW3XeUVhy2H9FcKnl4Tti0hD+MPFvuMyZrR81u9ek=;
 b=Do0m/CbzPoSJSpc85+ufTCh7W7Q+M1WEAfClPRhb3cgfbn24lUi7TWo7LI0FA7e+oF9AFYwEtLdVUP4dDAhjSdmsjoLuIVHoXLuVMxyLYBfftDQvQlgEoxPv3IiRMGxT44quDU1ZuJbW0KhHVX+S6+gSSG8wKYsptdWyXlfhVAL9HDPYDhmPkqLFJnV6VVgSH5C8WIy0KvbUZlpmG6PKkvx9V/c1yghhAqs1PyrjlsWr4Efo97IOQuEvFzWD/XN6KxhIz4MXQscjd46i4PFB9mhstTXapvjnwkWo9Rjop7jDbY+NntFxypQAjuZMRtp9WSaIRNupty/hN5mO2omprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuLW3XeUVhy2H9FcKnl4Tti0hD+MPFvuMyZrR81u9ek=;
 b=hSFwW7+5gtTVnFbjDZ5Lpuxyy7R7rcfOL7w3KFrmA6hdIh3NAW8fe4jvKSqbm8JJfXPq6JIJJiZfdMibn/utbDKw2cqXiaPJkisfpc4JrRQH1Wo394HfSKEKrXbCU5yWBnOyd9E7WwU9pvTWfslD9fRhfaowixBpi+c5sGObgmjwIhTKau3YMAgL7BARp1rrvtgKtkGdP7JkhG0IYaqJKvPOCpevNHZFLbYaiJptIleLob4YZ403iZinirtIFRveBPLhECV8v4GROjl7aQEKuBo7lWJSETIPimd9IBNVR5tj75BmDBBX5B6hpCMc38FKAMteJoneSo7zKotP2ZgoKw==
Received: from QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:38::14)
 by QB1PR01MB3073.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 11 Jun
 2020 22:46:56 +0000
Received: from QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::60f3:4ca2:8a4a:1e91]) by QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::60f3:4ca2:8a4a:1e91%7]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 22:46:56 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>
CC:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "steved@redhat.com" <steved@redhat.com>
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Topic: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Index: AQHWQCye07Z/EMkfKU+tN6sJacNgAKjUBAfe
Date:   Thu, 11 Jun 2020 22:46:56 +0000
Message-ID: <QB1PR01MB3364702A2312C166B68CF0F2DD800@QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
 <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
 <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
 <14cad1ec0a9080ce2ac064ff9a7ae76464e09aee.camel@netapp.com>,<20200611200919.GF16376@fieldses.org>
In-Reply-To: <20200611200919.GF16376@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71b940a9-7330-408b-00b4-08d80e595826
x-ms-traffictypediagnostic: QB1PR01MB3073:
x-microsoft-antispam-prvs: <QB1PR01MB3073712E6647C889B8A1C97CDD800@QB1PR01MB3073.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCcZVfqkkQDueKF7knc+4mqZUK3p2/Ig2jvASeGKTy0M7TYjLOE/Kay7OxfK/GlUJeJHEako5xDUdQv6lWkiuBp7IAcGVgJSkT5knMTijdc9v98xA1n8+onTDjSGrgCU2dQt+G6yWdGHOkXeQPR3DeCZ10pn+fs45gTIpG0mbOP9lVS62E41GcVfO6Km990hg8yv1OOnpGAJq6rcRTwzblm2HKXor43z3fIJY2RjDHRXFcEh5eGzq0QZWwUGObOi/gkDEN1MIb8GrgNMYmGhYy/7+i9X5WqPTucpqZoSxEENh4fbbNt3eekckOH7w3Jy9QDB8v5Gf0kdfEon9Zcv0lgLMep8WSa4aZLr+YXiI8L0o8BnV1Dgc3+zRTDTIeAg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB3364.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(316002)(6506007)(55016002)(186003)(53546011)(8936002)(71200400001)(54906003)(83380400001)(86362001)(786003)(9686003)(110136005)(478600001)(8676002)(33656002)(66476007)(66556008)(66946007)(91956017)(66446008)(64756008)(76116006)(5660300002)(4326008)(2906002)(52536014)(7696005)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MxK3WYu/zna4nphi2X+f9PxfJpfwWQqaKyAst65PDrKtl1ecPBid7o3a2h683qM5CKz1Wr2y7rQBOvpkwJN+ynvk/Ejt8+TW8/NaOzgMyqE3isLRJaMrVz756WoZ+YqgFoIwynensOrgS/RMfWGeum9+E8Nt4wuRztl2qtq5ujnp+MLpogbEauxn6ng+YR0i4L/m7196ouvckMngyDmtkTX7dPg+TDNZp4gvswY8mfytDD2+NnDfgGaBnvFvvdYCXfhactE/4xAcTfaa0uXUAM13eT4sHpC1pez32MuerYZVOd/ofcsCdAZhlxdpKxxSvbZyPyf4p/tE/VxXIn0BfXx+EZAWMIIS8Glfg9893XgERAm49l3LOr6tulkleFnBJrY3bcX1JZCtcYLvf1oRo2xVggnkAcBS3mrIe7XqOLEEod9BJSturkazF+qR073aBXdq6n4138Koow1zOf8NtRn0jtEr4jr3Ba9Q6loE/xbQ1SUeUq3qVpquv5rBggQPMV/T22MIjEh3qlW2+a5FJcrTZkfKYrSw7dnVxs92nshlCkCVJG4zkchgOByfchB3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b940a9-7330-408b-00b4-08d80e595826
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 22:46:56.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1t/ennl7pkPQWuORK7qSbfZ2ZLui95gEKvewYGhhSvXjrQ+O0FXX1UIyMuuROibQ/Va35KJjE4dAguvGPAh8MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3073
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


________________________________________
From: linux-nfs-owner@vger.kernel.org <linux-nfs-owner@vger.kernel.org> on =
behalf of J. Bruce Fields <bfields@fieldses.org>
Sent: Thursday, June 11, 2020 4:09 PM
To: Schumaker, Anna
Cc: olga.kornievskaia@gmail.com; trondmy@hammerspace.com; linux-nfs@vger.ke=
rnel.org; steved@redhat.com
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0

CAUTION: This email originated from outside of the University of Guelph. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe. If in doubt, forward suspicious emails to IThelp@uo=
guelph.ca


On Fri, Jan 17, 2020 at 09:16:54PM +0000, Schumaker, Anna wrote:
> On Fri, 2020-01-17 at 21:14 +0000, Trond Myklebust wrote:
> > On Fri, 2020-01-17 at 21:09 +0000, Schumaker, Anna wrote:
> > > Hi Olga,
> > >
> > > On Thu, 2020-01-16 at 14:08 -0500, Olga Kornievskaia wrote:
> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > Have you done any testing with nconnect and the v4.0 replay caches? I
> > > did some
> > > digging on the mailing list and found this in one of the cover
> > > letters from
> > > Trond: "The feature is only enabled for NFSv4.1 and NFSv4.2 for now;
> > > I don't
> > > feel comfortable subjecting NFSv3/v4 replay caches to this treatment
> > > yet."
> > >
> >
> > That comment should be considered obsolete. The current code works hard
> > to ensure that we replay using the same connection (or at least the
> > same source/dest IP+ports) so that NFSv3/v4.0 DRCs work as expected.
> > For that reason we've had NFSv3 support since the feature was merged.
> > The NFSv4.0 support was just forgotten.
>
> Thanks for the explanation! I'll add the patch.

What happened to this patch?  As far as I can tell, the conclusion of
this thread was that it should be applied.

--b.

>
> Anna
>
> >
> > > Thanks,
> > > Anna
> > >
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > ---
> > > >  fs/nfs/nfs4client.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > > index 460d625..4df3fb0 100644
> > > > --- a/fs/nfs/nfs4client.c
> > > > +++ b/fs/nfs/nfs4client.c
> > > > @@ -881,7 +881,7 @@ static int nfs4_set_client(struct nfs_server
> > > > *server,
> > > >
> > > >         if (minorversion =3D=3D 0)
> > > >                 __set_bit(NFS_CS_REUSEPORT, &cl_init.init_flags);
> > > > -       else if (proto =3D=3D XPRT_TRANSPORT_TCP)
> > > > +       if (proto =3D=3D XPRT_TRANSPORT_TCP)
> > > >                 cl_init.nconnect =3D nconnect;
> > > >
> > > >         if (server->flags & NFS_MOUNT_NORESVPORT)
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >

