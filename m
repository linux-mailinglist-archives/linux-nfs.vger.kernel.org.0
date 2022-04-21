Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79CE50AC96
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Apr 2022 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442655AbiDVABe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Apr 2022 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442188AbiDVABd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Apr 2022 20:01:33 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2040.outbound.protection.outlook.com [40.107.66.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4762A3ED22
        for <linux-nfs@vger.kernel.org>; Thu, 21 Apr 2022 16:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeiErw5q8SkeXwo2HuusRAPS8zEixtyx991utTA3NStWQFMis0iRdAYAoCKurPZOF+DFaMlFpj85zRyG0UY2noDtkjz5Xm+TmtcgY1rvQkmTH3uAKD6GDTRN9m2DV2veZKy8TqJcTx3HgKvnbxy9bMRDsGOMx72YmK2oF0GzRfVmnKNfznBiZovnhfYFF7aDYzb0ycn9ObU31bH3DyvQ9JPWnamoAlccCzw0buLXbCV59ISryWW3Rn7EeS5/KqdqVInKszpp9XePR0u/VHjRP817WTUFKOPlpjPuKC2h4ZYh/y5FJnvs2vndBWta1rfDEArpl/5XaTdg5Fez5WV7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fDGyP7HcuGTdf0qzjUedyuhKyT0e1iBGMkqO/2GIe4=;
 b=gSsJZdZoVpM5sA0HY7tdBPvoVDIvIcICtm1/ej8KHuwfRxK+DYPlFlppvK5L8fGgmJjJKIsIv3xyxEP9AVYuOXhcHVlSc6xpMw8Cz2znBaG8vHJwYX+yRCxhT8uwFiXf6+VaBcvv67M8NdjbrOZZAyZjzdVYbFqIArEc/FxeM0B58Jm6qXeUAWAtaGscDNYvzG1UkGWI58ScIjBInU7BMGwD0PuhHWwI+L/By/XOOXaXBQUdSt2tZL6CTp43LAhfgs3Uj/wi55ZXcSU3HH0+QIGGYaK7FklgU/K6I9k+lDFySKFcX/Fna7HQDx+sjCYrzuOT0GkqmXxsNI8GqMgHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fDGyP7HcuGTdf0qzjUedyuhKyT0e1iBGMkqO/2GIe4=;
 b=G6H4h/AKM7g3huXArCUULF0joSRQpG/9dEhAZP5hE78rD0WNcTLGXVP5zR/BZvNTaMSewLD4Oqq9SDs5jG2P9YLgD0S3ScS++90hjTwa+YR80mFrzBvqa6SWm4eWTLE9H0TRxi3kE8ORxioq2p0YxoZjUIveMHRj+B5zQJPe4QPhOjSTKY4aHTcPDzykVP6nGalBpwyh6r+3hFODrYi9JvmWVU8GGarC3bvu4vzITUUgL4VF2onr1yArS5yHboiNM08+9uAqli6YZ4VVk6lueYJ50Y436KTrcG5oQ2hAEyoBwweqIurqlo61UU9JVzsB3yr6vExC7GB7a7aT8XIKWg==
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::14)
 by YT3PR01MB6163.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 23:58:34 +0000
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003]) by YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003%6]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 23:58:34 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "crispyduck@outlook.at" <crispyduck@outlook.at>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIAABgD6
Date:   Thu, 21 Apr 2022 23:58:34 +0000
Message-ID: <YT2PR01MB973067B9FDA1B5F1B318406FDDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 41341847-0b88-04ab-78c3-910ba4690e37
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa9a708c-169a-4c5b-cb47-08da23f2d871
x-ms-traffictypediagnostic: YT3PR01MB6163:EE_
x-microsoft-antispam-prvs: <YT3PR01MB61636F90013292309D76300EDDF49@YT3PR01MB6163.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6QSUPTkV/VvXEoBrlh3BSSCPfW9v9K3zF6pDMNFdr4Gj8/2Uy4wjO06OEUgi2BbKZ1sZW4appZCo0WfM0tVXax6YPhwsCepSkSvlr30ty0L6DO4bBMvnTIq8qR6EVg1cHYbENYhta1TPQJho5oovweqGnA71OtVQHCau9NVpEpJQWAd3o5fGLwIvqcGsgiB89YTRwSkApykkjUMzfP780STVQ63A/p6USU1hxauzu054SJzhdxJDqKf5yRGZOT76sVAX9uJ+5Cvwvie2qk7wCedNfWtYth/CeEJ3sRGEx/DTXUrnxS0i8cSBng7yX186tcQlITt8vQnPkvBvCbJRdur4esfnlURtaZdCUxW/vOAYY8tW+hE1Azq4mXq1eZdcIlf8jX3BUf36dz21zYXEkQfKPZVdjChB6511FxlBzanz8J1slyWkRyX72S3iIzOwDZb/UD5I8VRB2U+AMuKOMgy2JnEFzwlbRu/6mHE8Bq64+DwRXCJ5WCSS+lmvVYW2TdMLJIK7TGQrYdxFlHZ7dlX/TD59FFv59aVEPF+YXZi/IMHAYInpWpPTP6N0NVgdWIRiWaqV6lLC+a7Bz3qUr8SrbAwA+WuaohGeESzdbAvGSUkw209Bxn7R7tM21raEZ+PdVBVzLWhCbS+cDkckdZmfLLl05voSJJegp5xjtmdmpibmbmHuUW/sf96F5RRoWGeGf47xNQjeyz3VYrBXgdplgFUhEVStev4eklWlWof+hZxpnAgEVdH95B2XOecKtlOu9YBG3esuDmrGbEz6TkGzJFFPN2ETrhdIsxv7MVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(7696005)(26005)(186003)(86362001)(2940100002)(8936002)(53546011)(38070700005)(9686003)(38100700002)(122000001)(4326008)(8676002)(45080400002)(33656002)(52536014)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(55016003)(5660300002)(2906002)(316002)(786003)(71200400001)(54906003)(110136005)(19627235002)(966005)(508600001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Dvb5zE97YbenPQuQl/AGelwqa0ewKamxcXeL/+biU/YIU+Gw8Qj5nyw9k?=
 =?iso-8859-1?Q?ma9qaNx7r2J/Oh4MCfvpmcV4Hp9BPPtvkJpHvmcUDvzzATCtpn/QQRuYYe?=
 =?iso-8859-1?Q?5l7q0/wjO0OcBmJ5hSYKjkUL2WowDNZPWdBDSEKGE43P5vfvyM+KCWDP7t?=
 =?iso-8859-1?Q?ZyPp+xPBACko/jnMRLb1kwBVajzjSEJPAf57vdECyJg4H/G1RtWMxRaQX3?=
 =?iso-8859-1?Q?ar6esH8P/NHzsO6shAKD4gbcxS3K+tM6QuHq+3FoOooCSOwvkppWkBvB2q?=
 =?iso-8859-1?Q?dzFV787iu4Y8BEVqVcc27xlq5qFyaU9QvOw1HecdnwTcvk5afRG1WZIrAH?=
 =?iso-8859-1?Q?KSpS8FgcvcOctBQSjTi9K8UyGtC6Qz0H3ZUXaFFFhWA4Sbk014N5P/0ae+?=
 =?iso-8859-1?Q?TEJ5gCKKc1FcUgYkSGc0OYjtp/MEstJG/xSnUi/GE7f64r/25fO1iDZ7hH?=
 =?iso-8859-1?Q?l833JvDfVL5m1/2ZIPQqJupRb2VtuyHaFmNb3V4bRm72GXbfkTcDjuAujN?=
 =?iso-8859-1?Q?YHZPnJ0KXFfrmn5nHDzRCLmH9Hep/gzZHEd9W54OJmIoIxip/K4HrawonG?=
 =?iso-8859-1?Q?/s0k1tfim4FHMcLLdgq/ZqkHcGnIvKvv0NckYvHGVPCvl2zXXnbF4IGzhc?=
 =?iso-8859-1?Q?z7GWfFAAK8pi2t2yMnePLxulu1L1EZMlp6xUyAoI6XBI3Xo3/GUvqVQ0zo?=
 =?iso-8859-1?Q?wKKSSX/7swHWtnxTBLte5EenmWyOYukg/tlluhpxQkbaMJxUa/NuJzSUR5?=
 =?iso-8859-1?Q?IdvA5cUI2qlIltZyipwL+HXvO//xOkEZlLlOeiKEl7SD/JDRr3rlu6R0yg?=
 =?iso-8859-1?Q?dmVp0UcIw3Lr9sLyKZiJkEGcmmAch8kfZiQwzzg4OPOEEBRLh0nMO9pvqn?=
 =?iso-8859-1?Q?Icxqd+F1qAUetZRM/qRpQQH9/gT/mvfGJo+GE6rmDs95iEpPxkQmIKR+L9?=
 =?iso-8859-1?Q?1Q/GlMDhqupl5h2GhLrp6zhQ8mhwJPw0BjnyiSZlxVxmm8630Quok738EP?=
 =?iso-8859-1?Q?j+RD4j85qXTa07453JuB6RoCr2ryA1vqzKlxtn3fByknPrrv7F3yv/ZoeP?=
 =?iso-8859-1?Q?1iZFv/KmMAFiH3cJkpUQh1KlR0kJjF/tEZ9YiFT+lIeQI4G6jJbrLsKtks?=
 =?iso-8859-1?Q?o6ydOqQE4XmF2RcNjIjLADly0Zfxmmm/MO1Nu3m/pxYujQHPrd6iMPFI44?=
 =?iso-8859-1?Q?4ilGAEkgcCvj3xFRSjEwmD+n9lUeX10UFhRH2vd5IK6bBp9Astnj/iyiRW?=
 =?iso-8859-1?Q?74Gp9Zd5E1V3kqnkhPUKzH2ViFb7Ul9i2AOeAh/jMUAnvcZZhzR+tyCjzI?=
 =?iso-8859-1?Q?eJ8cyRYU/5At0zscKRiDjy5akPIZVT/F31xdsXnHwrLTEAodtToE0C230f?=
 =?iso-8859-1?Q?F7O5Q2RZUYBkWhN2mWiQQH5jz4qPPObIlml3dYJF4OBGE2hJJDMwxX1Gnl?=
 =?iso-8859-1?Q?qbCl6zYYqs5YbWXEoP9GSBabChtsJyFAv6wyOZs5hnwu3zXQ75yjg2MAaI?=
 =?iso-8859-1?Q?Emn73UZDV4X77UrMZ3renh2Iw/mDKn7Bh88VwMX1wcTdY98GJkhUazn2/Q?=
 =?iso-8859-1?Q?nJW6tVxPSO8nc5Nznm6BvUsuXeA+pWPBkStwTS7BtyykaQODyp+K8UslYX?=
 =?iso-8859-1?Q?PmRUxHhRFHJOCuFmm2+/of5SK6EwFZuFrYU782L16m6hPkU+OeVaokAHLF?=
 =?iso-8859-1?Q?CXgciZXqyOHYM91L6x64JT4XYFfe0rGlO8vMpJm10dfE3kXeBWh0ZI44vY?=
 =?iso-8859-1?Q?JpZ9ZPXqBg2p335QBkJMhx4uY+QGlL7oSELe8SnSCCworJQ5gX3LZJ/ISG?=
 =?iso-8859-1?Q?++gipVLNow=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9a708c-169a-4c5b-cb47-08da23f2d871
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 23:58:34.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io1nPgXAeM+9Fxq0WyrcZ5iiDw1ZR1ymxrxv5yaUXxzIhs2rV873Uh+xSkSEj8aUwaKCJIVFMCiCgSW7TdpPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6163
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I looked and both the Rename and Close are done on slotid 0, so
the client does do them in that order.

Also, I should mention that this bug may not be what causes crispyduck's
problem. (It could result in an accumulation of Opens on the server, I thin=
k?)

rick

________________________________________
From: Rick Macklem <rmacklem@uoguelph.ca>
Sent: Thursday, April 21, 2022 7:52 PM
To: J. Bruce Fields; crispyduck@outlook.at
Cc: Chuck Lever III; Linux NFS Mailing List
Subject: Re: Problems with NFS4.1 on ESXi

J. Bruce Fields <bfields@fieldses.org> wrote:
[stuff snipped]
> On Thu, Apr 21, 2022 at 12:40:49PM -0400, bfields wrote:
> >
> >
> > Stale filehandles aren't normal, and suggest some bug or
> > misconfiguration on the server side, either in NFS or the exported
> > filesystem.
>
> Actually, I should take that back: if one client removes files while a
> second client is using them, it'd be normal for applications on that
> second client to see ESTALE.
I took a look at crispyduck's packet trace and here's what I saw:
Packet#
48 Lookup of test-ovf.vmx
49 NFS_OK FH is 0x7c9ce14b (the hash)
...
51 Open Claim_FH fo 0x7c9ce14b
52 NFS_OK Open Stateid 0x35be
...
138 Rename test-ovf.vmx~ to test-ovf.vmx
139 NFS_OK
...
141 Close with PutFH 0x7c9ce14b
142 NFS4ERR_STALE for the PutFH

So, it seems that the Rename will delete the file (names another file to th=
e
same name "test-ovf.vmx".  Then the subsequent Close's PutFH fails,
because the file for the FH has been deleted.

Looks like yet another ESXi client bug to me?
(I've seen assorted other ones, but not this one. I have no idea how this
 might work on a FreeBSD server. I can only assume the RPC sequence
 ends up different for FreeBSD for some reason? Maybe the Close gets
 processed before the Rename? I didn't look at the Sequence args for
 these RPCs to see if they use different slots.)


> So it might be interesting to know what actually happens when VM
> templates are imported.
If you look at the packet trace, somewhat weird, like most things for this
client. It does a Lookup of the same file name over and over again, for
example.

> I suppose you could also try NFSv4.0 or try varying kernel versions to
> try to narrow down the problem.
I think it only does NFSv4.1.
I've tried to contact the VMware engineers, but never had any luck.
I wish they'd show up at a bakeathon, but...

> No easy ideas off the top of my head, sorry.
I once posted a list of problems I had found with ESXi 6.5 to a FreeBSD
mailing list and someone who worked for VMware cut/pasted it into their
problem database.  They responded to him with "might be fixed in a future
release" and, indeed, they were fixed in ESXi 6.7, so if you can get this t=
o
them, they might fix it?

rick

--b.

> Figuring out more than that would require more
> investigation.
>
> --b.
>
> >
> > Br,
> > Andi
> >
> >
> >
> >
> >
> >
> > Von: Chuck Lever III <chuck.lever@oracle.com>
> > Gesendet: Donnerstag, 21. April 2022 16:58
> > An: Andreas Nagy <crispyduck@outlook.at>
> > Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> > Betreff: Re: Problems with NFS4.1 on ESXi
> >
> > Hi Andreas-
> >
> > > On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> wr=
ote:
> > >
> > > Hi,
> > >
> > > I hope this mailing list is the right place to discuss some problems =
with nfs4.1.
> >
> > Well, yes and no. This is an upstream developer mailing list,
> > not really for user support.
> >
> > You seem to be asking about products that are currently supported,
> > and I'm not sure if the Debian kernel is stock upstream 5.13 or
> > something else. ZFS is not an upstream Linux filesystem and the
> > ESXi NFS client is something we have little to no experience with.
> >
> > I recommend contacting the support desk for your products. If
> > they find a specific problem with the Linux NFS server's
> > implementation of the NFSv4.1 protocol, then come back here.
> >
> >
> > > Switching from FreeBSD host as NFS server to a Proxmox environment al=
so serving NFS I see some strange issues in combination with VMWare ESXi.
> > >
> > > After first thinking it works fine, I started to realize that there a=
re problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).
> > >
> > > Importing ESXi OVF VM Templates fails nearly every time with a ESXi e=
rror message "postNFCData failed: Not Found". With NFS3 it is working fine.
> > >
> > > NFS server is running on a Proxmox host:
> > >
> > >=A0 root@sepp-sto-01:~# hostnamectl
> > >=A0 Static hostname: sepp-sto-01
> > >=A0 Icon name: computer-server
> > >=A0 Chassis: server
> > >=A0 Machine ID: 028da2386e514db19a3793d876fadf12
> > >=A0 Boot ID: c5130c8524c64bc38994f6cdd170d9fd
> > >=A0 Operating System: Debian GNU/Linux 11 (bullseye)
> > >=A0 Kernel: Linux 5.13.19-4-pve
> > >=A0 Architecture: x86-64
> > >
> > >
> > > File system is ZFS, but also tried it with others and it is the same =
behaivour.
> > >
> > >
> > > ESXi version 7.2U3
> > >
> > > ESXi vmkernel.log:
> > > 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompli=
ance:209: [nsx@6876 comp=3D"nsx-esx" subcomp=3D"vswitch"]client vmk1 reques=
ted promiscuous mode on port 0x4000010, disallowed by vswitch policy
> > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)World: 12075: V=
C opID esxui-d6ab-f678 maps to vmkernel opID 936118c3
> > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS41:=
 NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed:=
 Stale file handle
> > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS41:=
 NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41: =
NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: =
Stale file handle
> > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41: =
NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > > 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD=
 page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported
> > > 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path e=
valuation for device mpx.vmhba32:C0:T0:L0
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)World: 12075: VC=
 opID esxui-6787-f694 maps to vmkernel opID 9529ace7
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-0000=
00000000/test-ovf/test-ovf.vmx
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209: =
Creating crypto hash
> > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-6978=
82ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-0000=
00000000/test-ovf/test-ovf.vmx
> > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209: =
Creating crypto hash
> > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm 26=
4565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-6978=
82ed-0000-000000000000/test-ovf/test-ovf.vmx
> > >
> > > tcpdump taken on the esxi with filter on the nfs server ip is attache=
d here:
> > > https://easyupload.io/xvtpt1
> > >
> > > I tried to analyze, but have no idea what exactly the problem is. May=
be it is some issue with the VMWare implementation?
> > > Would be nice if someone with better NFS knowledge could have a look =
on the traces.
> > >
> > > Best regards,
> > > cd
> >
> > --
> > Chuck Lever
> >
