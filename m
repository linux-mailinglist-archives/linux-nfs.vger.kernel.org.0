Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07643463E1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhCWP5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 11:57:21 -0400
Received: from mail-eopbgr1310135.outbound.protection.outlook.com ([40.107.131.135]:40742
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232912AbhCWP5P (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 11:57:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvXP0/Yt/l9HmhdzyOlXncHurWlUMMXDEtzMfyG3qSeBIQ40aw3tcQAKMnmAK3tXd105BEUglKjQDk6NTs17XIHy8xFzHbkD97up7PXtA9a0ctM2dViJ1OEGQUNqPMZmV3MBjHliUXk0RzzOWu/yReOIn2atw+VQBmGZopvVIVT/yOZ+gshty/qDpXgrPq5tgiZpnJH5TBHxNgTwbm9BDytHBO3PFQem553WOQlVgwPewPAftVv70S0DHi490N1slUpBMdjrLXhm9p+jsxrBRdQoG/RaypG8+60hIxB4nN2rH5sqvgQcWqB5CMa98ZtouXgg9x5pRu7Kr5/ZT9JiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVR61r3wmzGB2ExUTF+fREznZCGbivVNx3pf0y9aO0U=;
 b=asta/47uKs8PR0hY5yBtogHZO5RwCSc3u21gF/Ezh7toKJML2x32YfkVNjsI4EhaVP2RILxH0XYwCDuaA89S6I+pWJJIJIKYT4SXi2/wz04dgvwlmSnaNJHB1XbjrvlS98+M4ZMDp48IdVCUu9sWAj+PjF+UeoTMx+X8glS1+COGoTgAU30SbqWpRDlJDRjkYc3HFny0m0qdhFfPqOMAQYvSlIGpn5bpdetx/MX7ILWyLvAkThV3E3PXS6MNlsBPL9p7CouFeCzmLwFvikmoUSDNTVeaXhV7tCo/42QWrlafqZGhFx6emNepXXFHgqgGMtKw1Pbuwj/ucdA2i+lJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVR61r3wmzGB2ExUTF+fREznZCGbivVNx3pf0y9aO0U=;
 b=A+YHWSAUoR+f0dtSgab2HpmaJgxpr5MseZWVl6NsEL7qMNQQBQIlslxwirb3SitvvJr4NZH0PUaolrqIHCE/H5rwv3LPu0qBt0E8KkvZ1wV23oVjVGg7c+xBp61jW4QAmd6RuFGJMLNzku7h/eYoZnU5k5eDq9oMiL7lZPJ3kqA=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P15301MB0032.APCP153.PROD.OUTLOOK.COM (2603:1096:3:10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.2; Tue, 23 Mar 2021 15:57:12 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 15:57:12 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: RE: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+A=
Date:   Tue, 23 Mar 2021 15:57:12 +0000
Message-ID: <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
In-Reply-To: <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f58d9e78-5073-46a7-97e2-08d8ee1452c2
x-ms-traffictypediagnostic: SG2P15301MB0032:
x-microsoft-antispam-prvs: <SG2P15301MB0032B8DD303CB0E31726EF769E649@SG2P15301MB0032.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBa4whQ1EcXJWq9tUqeyoi0Cu9rdQGMLPW/MQXygX+ags/usq5MDOvRHgyqAITlyCFIPNybYQR2X0GVP4oNl7OClUrZL5ivzvxgc1MLZpmLuIMiZcYApVrBpFbMcTybZHceoM+4YxeeCGDnUps22uRlw8P2q624LOBhV2Vj5VNvkRlfrpgpiyFNQI6twvKNJi8noPix+pyz3HZUVleXKiPdwQbyoHhCYIxnh63f6JOEOmb0t4SzbLlJFtJpLF0fiL6bmEPSBt6SRKGJCzT80ukieOebLK920GB88Y4HlJh2sEPza03+yUYpDhrqpGMdKnndO3imsNOduZAOLxYgM/nR6zd8ApMPSCYnNgc+ioXMx9U58nWhMTHGQ6D/CAdJQjjailVJeeWLVCQOVXn7kEzFAck+RnK3Jt83K52OVn0/ALfyD99ENAHdWvFG5TXJw+W11Y2l4RnJOaCln2TKiHK4G8osGCCGpufgzz7/qCEqPOhH7boQjEfFrrBqB7AKMsVGQqQDUQ6hAyXl5Nnav5ZD/AAOLQO++wRYmofUrtjP5DrGAAwq8kLCdR1SomzBi7bEv77D69rlQ88ZgTKYPerXFMovtFFWfPVycFoJD5chICIOq7TvlWrpdWrD9j4NEK0pS0Tl9XbJhFIBqJwvIdQZGHFKHbARhYHX2n0AJU8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(71200400001)(86362001)(7696005)(66946007)(82950400001)(8676002)(33656002)(82960400001)(186003)(66556008)(6916009)(76116006)(8936002)(5660300002)(64756008)(66446008)(2906002)(66476007)(478600001)(54906003)(38100700001)(8990500004)(26005)(53546011)(9686003)(4326008)(55236004)(6506007)(55016002)(83380400001)(316002)(10290500003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nrhQ5RBFq0hV+EuPA2a36j5LIz38yRUIyY6CsgsjxGrDh1e3R8eanfXRQnIW?=
 =?us-ascii?Q?bi1zWwBdkBe7zFuPMp/KLO9Oq1RnOXcNzkKwPSoPuzi/Lq10nF+8yzUUJ6mn?=
 =?us-ascii?Q?ZZJ+OuR4s3clamuErWHOY9v4LvRWVxirOHPvI+yGntHNLdGa3g+omXipj2a1?=
 =?us-ascii?Q?lU3CN4erUmztTZ3wQmTwtkUnxfOdbWJsCuSTnriODfNPppuj4yBo+MwwF/Vu?=
 =?us-ascii?Q?RnGzgbag697B981NKIZYw2BGGUQ+pxa3FJVtJuLarSWpUh6swGK+v7pWuAdD?=
 =?us-ascii?Q?jxEC77CsiKgBzLOD/Bf5xSsSUcHS4nCLyxR2L4k4bOB0K1N4kNDN9WpSHMdE?=
 =?us-ascii?Q?Wba0OIKTC+JL+L7juFasspHN5DqFC+MD4+mXZOx0PRO/j4bjnAXNaWF9F+l6?=
 =?us-ascii?Q?uLTPmacrYSHn4BHVG7SXLzterDGvUBs40/iwbOTIYYCSPSki3MmfmW2j2Fak?=
 =?us-ascii?Q?QhrvtjjqmlKYbDE2nmjXFv68fLe9egClCw0vWI0e2tD5Rd0Q0KKcz965NYgB?=
 =?us-ascii?Q?jSZRkK80HXl9/knHgd+Ls4Z3LIaVG5/1I2U0Nh9SGSekWkc0BO1FOARTRTXB?=
 =?us-ascii?Q?ckd5zPzF8DUAniy0XPUli8pP6kHOjSykmLiOvJWcckIWo/+M8B5f18eIAcSl?=
 =?us-ascii?Q?UMRN81xj5qJ1dxJPUcoMOWCv6JXGFOx3ZJd96N9DEHnyi6b785PSZuJWsbB+?=
 =?us-ascii?Q?sEBYH9KToNImdGiykRkyGizLEOkl2YhPqcsTFKSKhf4fWvDZP8pORxqfenxI?=
 =?us-ascii?Q?Lg3ex5v8t+ZC/SvoZfzLFR4NQ7gpho8V/ULugy6s52ySluviy2uwU899XPUb?=
 =?us-ascii?Q?vvwyHolfo90PytgM04ms8pyQ+yoIkzrYAQbBt/h2OpqmUA6cSJzj5ai/DAjV?=
 =?us-ascii?Q?Jb9cX7+Bvckwpge6+7w2TrasCGCaYySooiK9yOJrJVrQPLRW23W9A4ROTk2z?=
 =?us-ascii?Q?mIHdvbzgcheWxkYsTH5BT7VYatrTbA/Zv66SedewkiE7jt1Mn1VcHKWI3aIM?=
 =?us-ascii?Q?a7EqvX26OHDOD9sxg2esjaZ2V/bJoziRVQN5TLhj1t5EdpyYmZjXbyC7ngkY?=
 =?us-ascii?Q?EzFeyBsD0+PuktclUtOMnZZtEtJvZ0mCC1AsEJM7s6iVZuWmBLDUM07XCyCA?=
 =?us-ascii?Q?29ep0Pokalo+g/7tXoL9ku0wnp1eC10Kv7cXwTu6O+P1zM1Eq1hhbcEifJxb?=
 =?us-ascii?Q?Bk9qFRFAT5NvVn+/qPivmnTP1p+C/XtT6eT7lqA+Yae6mmEtir0UKCKXiwxY?=
 =?us-ascii?Q?WPdGuzwZtrV/aQWyzkH/43Om/9KR6yuwOqRy57Z88H7BmxBQht1mhFpPsZ1v?=
 =?us-ascii?Q?x1womzjx6XZcC3hIIfEWGnHW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f58d9e78-5073-46a7-97e2-08d8ee1452c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 15:57:12.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1bBBSi7/yJFlaeBmvLqwE4mpQTiBy2n23+Dcvq17+euQhKegruX34qd8cGTlEchHS6MLw7eUaJTL6uD/lM1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0032
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

 > > On Mar 23, 2021, at 1:46 AM, Nagendra Tomar
> <Nagendra.Tomar@microsoft.com> wrote:
> >
> > From: Nagendra S Tomar <natomar@microsoft.com>
> >
> > If a clustered NFS server is behind an L4 loadbalancer the default
> > nconnect roundrobin policy may cause RPC requests to a file to be
> > sent to different cluster nodes. This is because the source port
> > would be different for all the nconnect connections.
> > While this should functionally work (since the cluster will usually
> > have a consistent view irrespective of which node is serving the
> > request), it may not be desirable from performance pov. As an
> > example we have an NFSv3 frontend to our Object store, where every
> > NFSv3 file is an object. Now if writes to the same file are sent
> > roundrobin to different cluster nodes, the writes become very
> > inefficient due to the consistency requirement for object update
> > being done from different nodes.
> > Similarly each node may maintain some kind of cache to serve the file
> > data/metadata requests faster and even in that case it helps to have
> > a xprt affinity for a file/dir.
> > In general we have seen such scheme to scale very well.
> >
> > This patch introduces a new rpc_xprt_iter_ops for using an additional
> > u32 (filehandle hash) to affine RPCs to the same file to one xprt.
> > It adds a new mount option "ncpolicy=3Droundrobin|hash" which can be
> > used to select the nconnect multipath policy for a given mount and
> > pass the selected policy to the RPC client.
>=20
> This sets off my "not another administrative knob that has
> to be tested and maintained, and can be abused" allergy.
>=20
> Also, my "because connections are shared by mounts of the same
> server, all those mounts will all adopt this behavior" rhinitis.

Yes, it's fair to call this out, but ncpolicy behaves like the nconnect
parameter in this regards.

> And my "why add a new feature to a legacy NFS version" hives.
>=20
>=20
> I agree that your scenario can and should be addressed somehow.
> I'd really rather see this done with pNFS.
>=20
> Since you are proposing patches against the upstream NFS client,
> I presume all your clients /can/ support NFSv4.1+. It's the NFS
> servers that are stuck on NFSv3, correct?

Yes.

>=20
> The flexfiles layout can handle an NFSv4.1 client and NFSv3 data
> servers. In fact it was designed for exactly this kind of mix of
> NFS versions.
>=20
> No client code change will be necessary -- there are a lot more
> clients than servers. The MDS can be made to work smartly in
> concert with the load balancer, over time; or it can adopt other
> clever strategies.
>=20
> IMHO pNFS is the better long-term strategy here.

The fundamental difference here is that the clustered NFSv3 server
is available over a single virtual IP, so IIUC even if we were to use
NFSv41 with flexfiles layout, all it can handover to the client is that sin=
gle
(load-balanced) virtual IP and now when the clients do connect to the
NFSv3 DS we still have the same issue. Am I understanding you right?
Can you pls elaborate what you mean by "MDS can be made to work
smartly in concert with the load balancer"?

>=20
> > It adds a new rpc_procinfo member p_fhhash, which can be supplied
> > by the specific RPC programs to return a u32 hash of the file/dir the
> > RPC is targetting, and lastly it provides p_fhhash implementation
> > for various NFS v3/v4/v41/v42 RPCs to generate the hash correctly.
> >
> > Thoughts?
> >
> > Thanks,
> > Tomar
> >
> > Nagendra S Tomar (5):
> >  SUNRPC: Add a new multipath xprt policy for xprt selection based
> >    on target filehandle hash
> >  SUNRPC/NFSv3/NFSv4: Introduce "enum ncpolicy" to represent the
> nconnect
> >    policy and pass it down from mount option to rpc layer
> >  SUNRPC/NFSv4: Rename RPC_TASK_NO_ROUND_ROBIN ->
> RPC_TASK_USE_MAIN_XPRT
> >  NFSv3: Add hash computation methods for NFSv3 RPCs
> >  NFSv4: Add hash computation methods for NFSv4/NFSv42 RPCs
> >
> > fs/nfs/client.c                      |   3 +
> > fs/nfs/fs_context.c                  |  26 ++
> > fs/nfs/internal.h                    |   2 +
> > fs/nfs/nfs3client.c                  |   4 +-
> > fs/nfs/nfs3xdr.c                     | 154 +++++++++++
> > fs/nfs/nfs42xdr.c                    | 112 ++++++++
> > fs/nfs/nfs4client.c                  |  14 +-
> > fs/nfs/nfs4proc.c                    |  18 +-
> > fs/nfs/nfs4xdr.c                     | 516 ++++++++++++++++++++++++++++=
++-----
> > fs/nfs/super.c                       |   7 +-
> > include/linux/nfs_fs_sb.h            |   1 +
> > include/linux/sunrpc/clnt.h          |  15 +
> > include/linux/sunrpc/sched.h         |   2 +-
> > include/linux/sunrpc/xprtmultipath.h |   9 +-
> > include/trace/events/sunrpc.h        |   4 +-
> > net/sunrpc/clnt.c                    |  38 ++-
> > net/sunrpc/xprtmultipath.c           |  91 +++++-
> > 17 files changed, 913 insertions(+), 103 deletions(-)
>=20
> --
> Chuck Lever
>=20
>=20

