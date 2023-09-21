Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759817A96E9
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Sep 2023 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjIURFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Sep 2023 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjIURFG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Sep 2023 13:05:06 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2132.outbound.protection.outlook.com [40.107.96.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EDB2102
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 10:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNoM23kBpTtyhSZ58oK1FaxxaJLV0YDowl6VPJzLOZWFmmSBLTZTt0JFNB6j0anBRZDUIuD4e4GOuk/IroTWKhCM6Q142Q6smFuc90zEdc3oUsGx9oNkHRmVSvPSW6NsNLYjH99K8Snk2YkUZY+keyPyuYNVYf/pi+gOyUX2YJ+vnEJMv/sx5D1U8kODVG8HJ4h9uH1LXh/wpec49bACJAK2FkbwzDqw3CXlus3FIUtkBjLeEU20Xm74rLExHdiuw2TkkChtAWGl6qHy/0Kwat2BUvk+7qlUD4/sD03k1Y27yaEGVE19mIWhK8HADcDp7WYVX68RLX+HDWZExxI49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yED59un4r61DvzvaNhnmyuDanO4Dyb5+XUmwWaoenB4=;
 b=iMcs79HNXqtb1uXYyk/qyF31I2NPHQm6++Gi/4tWdeRzhiBgsG00DBaJWEBAtPYf6XnpwYGxAejrRxWYtO/w4EJQc9zTGNQ5SexdtzwM7bLIF2y3+/qjZYATYqJQ0V9x41gljuhZ7jq9JqBZqW8293Ey+Eb8+I45SfIub5ortcaRx5V7OstMH0yBvzg4ltXFVnC186gBEQO4R+ux8lVqAhWe1BwJIyXXqgdtXQ7EJQ01e4qpvIXoryShEfrGo7fpzK9G6a4xntThhYmKJT/z3mZu/PF6y9EP7vk/KWyEGQ0pD9+hULHq08k314SZcIN7gRbFIiandFv7IeCKXJiPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yED59un4r61DvzvaNhnmyuDanO4Dyb5+XUmwWaoenB4=;
 b=uC3adjvho1P5m9sZc0czjovL4IYBm30lVYnln6i58xta27rDha1FqQHF03lz8y2xckPsmAm7t2UZjcm4Srl7Lg2p/nHsOebNVXFz5ZsFWpadxJJfaDw1No39JyqRd5W6EzbvhqE1EaFWUgdiHk92WoJLQN/+sSjh17GZz4UMDSU=
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by PH0PR14MB4656.namprd14.prod.outlook.com (2603:10b6:510:82::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 13:56:31 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6a50:ce96:4b7:a145]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6a50:ce96:4b7:a145%5]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 13:56:31 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: bad info in NFS context
Thread-Topic: bad info in NFS context
Thread-Index: AQHZ7Bgh+wAiuciHp0i2Q0AWGe3SvbAlGSKAgAAvuxuAAAPwAIAAAEjV
Date:   Thu, 21 Sep 2023 13:56:31 +0000
Message-ID: <PH0PR14MB5493A8657F42289DBC301CC2AAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
References: <PH0PR14MB5493ED33985C95FEBE4DA808AAF9A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <B7D023CD-2810-4BD6-8570-AB0C0EE95287@redhat.com>
 <PH0PR14MB5493AB9814249EC5D66E635DAAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <650954F9-F67D-4F62-AD7B-4D16DF45E168@redhat.com>
In-Reply-To: <650954F9-F67D-4F62-AD7B-4D16DF45E168@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|PH0PR14MB4656:EE_
x-ms-office365-filtering-correlation-id: 5f7efd9f-0d89-4d87-29ec-08dbbaaa8f74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVlUuZ/nBCfU+TBkZ0jjlO0awrjt4a/jxY/qemyJ+bnSxlqBiQydoGEzKxJh8lK637uhS5OKzI6vlE76BEq4yy/H5hIkrm9MzeplmCO+cV2Xv3AXMJC/UhVapWeU7xD9m1G2ls1/gOyacN409/LCZKKmjrZA/+XPRMSe11PMOb2iYyMoqrnerK8l88BEcj+d8FXQuW/LdVobO7kq/e9hv4QIcHhNe7cRiRUwntY5ljxVN5GFSNtXsj95SUMn58TJLJ9ViGmcTHjXeI09G7tN7c3ODOj3O2+u5zFQLoBBv+kJkdUGyedbFCFbBg1QDelz8PD0L9/jmYOep8yaJ1ZkmxrX750I4qG5RRpBJw15QMNEUPRGvGuRKfRTnAbZfCjmKAOkYOmGYaCEE0Ue3DK+cumDs4nSl1Ie7SG9GOctzNp3neNkJi5C5SBg+tpq8ZNApHAKqqPdcKuCwEf+A7FaCDgPVsOhgFfBFw8aMG7T0gO0jTosrAx+9rFkoWWwDIQb+eSnV5souWf46j5bwKSUkIfalm0whxCMJnPwAz94qoCTtesUhv6lX9IkrNLfzTVsuB1zCMk9Xfs05D0NIdlFBGsT5hNaOQPV2CN2PbtU3MDWY1hJ82Eomfxu/ELFsqcw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(5660300002)(8936002)(6916009)(316002)(4326008)(786003)(41300700001)(7696005)(66446008)(53546011)(6506007)(9686003)(2906002)(64756008)(66556008)(66946007)(91956017)(66476007)(8676002)(76116006)(52536014)(478600001)(75432002)(55016003)(86362001)(122000001)(33656002)(71200400001)(83380400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AUKFrLidhcRMwlmi08uzD5sH1i38YftsIsXjb0GSbn/cpxEZCP73oSA0Wy?=
 =?iso-8859-1?Q?EVtVASFET/b8JcZOgBDRmUwUjOp/o5kTAqxivX8ANyGHoyYX0Wz3j6ffW5?=
 =?iso-8859-1?Q?ncbg5tE0ccmuoQuPV1aTVUbAIyQFolItVKkdE7ktRq7lVYt7Ma2QQuoG2w?=
 =?iso-8859-1?Q?okR5N4J+rjN6JvUkXl9x8c/Md/oWFE7/3aeODRwvXI++VlX6E06fmnVU81?=
 =?iso-8859-1?Q?rBefxqCvia2lnRo4ErXSlRj91DjmD8WtwrvyJ0LdNkGPRRUIKIiP6FvNjI?=
 =?iso-8859-1?Q?7TcM4ZeUBNKh8517fKhTOQWTMS/GGmKPWvRilaiEKCoJ7IHn4x+LJ3PgAx?=
 =?iso-8859-1?Q?mS/nO2IjufQOzn3ga431J2QU+lhbbf/PNecvc1dOPgqgWApetvJZXzDoCh?=
 =?iso-8859-1?Q?/61x0Qv92dwTRbELWtEuNFdI2eHIE5xr5y8cHF6Sd5bBNWxfHXY9cYXfqE?=
 =?iso-8859-1?Q?yzyQD2SW+zkUIIN3HPy8oS14YXzMMD1yiQpkrlr/U+fKTRlJ/BhADOyGfL?=
 =?iso-8859-1?Q?Olan/e+CUZMypLqQ5ZlIqt2Zf+sDXIFydZvOnO4bOcbmPEfRCXixNCo0eo?=
 =?iso-8859-1?Q?RQK4R/ei14OeL3TM0ry7+AztHDBLqQq5FdXGaYG4OcZCcMdnvoTZ2uKB3L?=
 =?iso-8859-1?Q?Q/cRspzQc2Bv6Jo/2QACnFnSJ32eb67tYxzaWWnpsu8JlQtSai4yTCJ+53?=
 =?iso-8859-1?Q?BZyLeqwXeFTYfwT+gyGjptLUqqJ0y2+g5qFGvQnVbBEr8GyRfhfnGeKLTV?=
 =?iso-8859-1?Q?KjKzgqHVdGBeYKQEz3ofCB0YC9TkZoFeIcv2UoKsThSlbwc5VV/pUjNDVX?=
 =?iso-8859-1?Q?5bdNxefzd31rR9XNnUUfi1VSH6SAvmeM4Gbdfs9In5IRqZoZ6L7dvyPmus?=
 =?iso-8859-1?Q?7HNGkWwEPIx1Tqdffke0682rz0mIGfStA0p2aGPZcVlBRgVnyh8W8IrG+v?=
 =?iso-8859-1?Q?8jFzpWQa0P6JF7yGOenk+IejOos9BSJknfL93+DNI4vUhzs1t0g6Laeu2R?=
 =?iso-8859-1?Q?YfC1v7AhwYTrIsafyGqNIoaV/iMtO/voUNIzONYk5xYQRScuGg6uZRiAnN?=
 =?iso-8859-1?Q?LnDS0KY3y2l2KV9HdaV4m7gj7w1jNvvvMv2KeYSsRysG9Ohs364LaSAn5P?=
 =?iso-8859-1?Q?Ew4laOiA+wzsE53W0g1qz1g8q2oxj3T2yadigA8WhL1nDb4Fa2eDxV+M71?=
 =?iso-8859-1?Q?GpQRzrNBbeHQnyIkOg7ENdZMfYdNQ5349X/mKpy/T+VsXJqgjKiKF+tO9M?=
 =?iso-8859-1?Q?KRTOF45oUSYzAbUB8UQjbz0N1jBKobaqhmOHCqqKKL/xlCBNw1Z0/lYZC3?=
 =?iso-8859-1?Q?HO2ZD5GXmMR06RYP6O6pcszZrQAihMtiim8U2NdAk056C2puO52geLyCMD?=
 =?iso-8859-1?Q?Dv81HHZLeLlsLMBR392X6582AmUGbAas+pMxcjuXfpPcuwYZhKGFfpjerY?=
 =?iso-8859-1?Q?RU99FqGV5feFaCcTxcM+FDIyYo5eTMnxaUa8+FsoxGG1lWt/s3Ox7HsX9O?=
 =?iso-8859-1?Q?vMe6yTRwi40ZjQIDm7PAD/6T5n+lUyvnmBnv4LEAfIB/Xaq8oD/zmCh+N+?=
 =?iso-8859-1?Q?PQ9bkHdBAx/f5dLqFTCsCT8fOr95Xm45QiLYhbetBqyVxWCcUFn1ZfGrA5?=
 =?iso-8859-1?Q?vQm61Um+ST2kMRUjvvQJoNdxxIs7dogpSZJGspfVXq8Q49/dtfMy+U9A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7efd9f-0d89-4d87-29ec-08dbbaaa8f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 13:56:31.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ni8VDagBtewv/sTBSPVF0BUb+W6FC0WfqTJ3Lw9hIBdXsX8JIJvpUNtk04z9/CLPuWq6vjOIQc+nBlxsbBr8KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR14MB4656
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

thanks. I can work with that info. Restarting the server isn't practical. T=
his is a large-scale system serving hundreds of students. We generally keep=
 it up uninterrupted for a whole semester.=0A=
=0A=
>=A0So, the NFS client will keep caching the result of previous calls to un=
changed inodes until it notices that the process' oldest parent with the sa=
me user/credential has a task start_time that is older than the currently c=
ached entries.=0A=
=0A=
I trust you mean newer. This is jupyterhub, which likes to keep user proces=
ses around after logout and reattach when they login. But as long as we kno=
w what's going on, there's a way for a user to kill their processes manuall=
y.=0A=
=0A=
=0A=
From: Benjamin Coddington <bcodding@redhat.com>=0A=
Sent: Thursday, September 21, 2023 9:49 AM=0A=
To: Charles Hedrick <hedrick@rutgers.edu>=0A=
Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
Subject: Re: bad info in NFS context =0A=
=A0=0A=
On 21 Sep 2023, at 9:36, Charles Hedrick wrote:=0A=
=0A=
> this is a web app. What is it about logging out and logging in that clear=
s the cache? We'll need to make sure that the web app does it.=0A=
=0A=
There's a very real performance tradeoff to perform NFS ACCESS operations f=
or every part of a tree walk vs. caching the results of previous ACCESS cal=
ls.=A0 There's not a sane way for the client to know when a user's group me=
mbership has changed in order to invalidate the cache, since the change to =
the user's group membership is not reflected on the inodes themselves.=A0 S=
o, the NFS client will keep caching the result of previous calls to unchang=
ed inodes until it notices that the process' oldest parent with the same us=
er/credential has a task start_time that is older than the currently cached=
 entries.=0A=
=0A=
TL;DR - you probably want to restart the web server.=0A=
=0A=
Ben=0A=
=0A=
=0A=
> ________________________________=0A=
> From: Benjamin Coddington <bcodding@redhat.com>=0A=
> Sent: Thursday, September 21, 2023 6:44 AM=0A=
> To: Charles Hedrick <hedrick@rutgers.edu>=0A=
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
> Subject: Re: bad info in NFS context=0A=
>=0A=
> On 20 Sep 2023, at 19:14, Charles Hedrick wrote:=0A=
>=0A=
>> Ubuntu 22 client and server (5.15). Mount is 4.2, sec=3Dsys. I add a use=
r to a group, but they can't see things that the group should be able to se=
e. /proc/net/rpc/auth.unix.gid/content shows that the nfs group cache has t=
heir group membership. Doing a mount -o vers=3D4.1 works (4.1 to force a di=
fferent context). Other users that didn't try before work. It's been severa=
l hours, and 4.2 still won't work for this user.=0A=
>>=0A=
>> What do I need to flush?=0A=
>>=0A=
>> Note that I'm using gssproxy on the server.=0A=
>=0A=
> Have the user log out and then back in again after the group change, that=
=0A=
> should cause the user's NFS ACCESS cache to clear.=0A=
>=0A=
> Ben=0A=
