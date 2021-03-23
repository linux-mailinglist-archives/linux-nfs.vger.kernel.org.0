Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDA34652E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 17:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhCWQaH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 12:30:07 -0400
Received: from mail-eopbgr1300097.outbound.protection.outlook.com ([40.107.130.97]:6221
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233358AbhCWQ3t (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 12:29:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V13wOAY2iBy5mDxaZclYeRbJGN8t4klo7j5Dv9PZUrkcGQhLdjHF36Bie7+gTQ4EaTXwtg9f2LcqLSJXtDg5UpwySpLuBowr/O+ePFBmDho+3Ac+E/jspTeRr5B0ZPY0yx0pmqKlUTDuurRozlOVMdha045Fj7eLCU2Lllxp9agUO+daSiA9+vzD1lLpKtWzJ7s5gN5FJWd0WUorjOLQPqA5XDVpwxz0wWyyXLnz1h6UKSqQxY/64RYm/UtjelkvgjcDH53V177gVcVC0U+waO/CVuYWrsctFbLWraGnFEhA0Cow7v4bSC81HgEHYmrt/27hdfj0VoM1eiP/zlafSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB8kUrScf1hiCrN20rl/PhqYP7Q17sd/8rsWkhgcyoc=;
 b=MkrcoEYNpnoMnS85os6D20fls0gUegToeTOc05gxEb89gX5AGTVChciyiAw4+7kuRh5029/VPqrVYN9a+49/NTAeYykTyzgWuW7HZ4RZ7H2ZLCUPWfqU5PSH/sS8k6kSx7p/XUYcG0SQOu30DaeBHwINP5asWOtgmCncseKd1cdgnvEXPv8wfJoD4eShwUBnC98YnBB41XQRFMmgxIj4W0KWHov2q8Bwh6cTR70TTRh55xRfwZLoI3QFOgGTlymJbavw2HDu1TiPYWlnFBxe20CKXURs8f+Zby/914QmEZn2K5BNLJzu4ILCQmwdo9UBtSG2CPCMw9UF3s7tXWb9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB8kUrScf1hiCrN20rl/PhqYP7Q17sd/8rsWkhgcyoc=;
 b=PDAIr8T/2zDjH2VcV9pXQAztg7Pjb3QAVpndjTGIloUWXsxi1Ys8ol0biQzlxlWFbxR5Y+4c6u2bZt+4X3GduNVdciyCTPYYLtkmHdARE/WkVR01uLh4UBAKlU0pGDakxF+GXAqlKqpaHWPIYL5M1VkFsHxzdTDMr/ebr3hCqbg=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P153MB0301.APCP153.PROD.OUTLOOK.COM (2603:1096:4:d1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.2; Tue, 23 Mar 2021 16:29:45 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 16:29:45 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: RE: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+AAAek9AAAAU0WQ
Date:   Tue, 23 Mar 2021 16:29:45 +0000
Message-ID: <SG2P153MB0361DC1EF8EDD02356D29E579E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
In-Reply-To: <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4850b5a6-6bdb-414d-5bf3-08d8ee18ded7
x-ms-traffictypediagnostic: SG2P153MB0301:
x-microsoft-antispam-prvs: <SG2P153MB0301818D68F335CCF2CF842B9E649@SG2P153MB0301.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpMTI3jRETEA2Rk2bbW+u4K9++km7cjUlZJFG6WfCdE64I1PLBqmbAXk8IhZ8F+1jVMEMoXIUHke1p72urWy0HqXm+hs6LSkBL5oxEU6MeBZ1omNW6jbjF7d05DarHkoExvZ9UCvywD7x5Sdtz1pwVI6Fu+R3gvnuh6JZcnEgvAhJzd5wck3A7TnR4BBG6zI3i3+4GDjeqSexRGjSs5QY3w0YCy5bHWxTdQKAmcNSfyOqdJcQ8G9ALeCvhtDgYOpfCw5g4H5MPNz6RQl6e+8iRwxLR1TpR1B5VzXBspwAqSubFwigWmDh04ZbiFTbybk8NMsy6ojzgIta/GeJ3Jo7evbObt36ONQZ4MkGKcngyYaX7Uf2dwWyPoE1j/qGFLXbt0djHEzvcdl4HTn21oPBoIM4LftYzYNm6ZthEYSYy6L/QBWjUlT3vD+QDJlQfVlrEK3tzF8wKqssdAhOHkMpBoml+m6D1ufo6AV71GDhungmM/3n1PmvM2kOL7r4UcbPzeLhrLGwiFon5aCLYAxkLjs1SORwtb+YNTKxPJdo8k6Yy4Yz3NMHsdbkZD0cWD+VfX1T4o8Fdy+gYBFBcSsPLr8jch/FycnWqNy0fpI7NDW6kZ3JERALRBl6vdIrC4Aq6x2BRm2Z7k3KcQx8eru0zGEaYmM4jt0kkUfRov85VQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(71200400001)(66446008)(10290500003)(6506007)(52536014)(26005)(7696005)(53546011)(5660300002)(8936002)(76116006)(4326008)(316002)(83380400001)(66556008)(82960400001)(82950400001)(66476007)(55236004)(66946007)(2906002)(54906003)(478600001)(64756008)(33656002)(38100700001)(186003)(8676002)(8990500004)(9686003)(6916009)(86362001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v/nHb3sAKMNpd5XV4rU5UqXjr4IBHsqSx72CCEWXP5HGqx7rrbuud7WVz+lx?=
 =?us-ascii?Q?ATs7y3bOn7i7AUFCvPhzXEGN9K9OL+pbvxUXQ+BVB1M7lMLQp7XxsmnCoMy7?=
 =?us-ascii?Q?BNcbuGLodwYTS6Usqb3S6VyJVM8Z0zUMUtev8kx8qC+ryErQo7vRd9xbMmzl?=
 =?us-ascii?Q?hzRE4oyw1TpJUxxfWRDwGlwNx4DEuLgoGaPL93rJcGeKkMENxoasdmD6lj/h?=
 =?us-ascii?Q?6tMQr3Lb4GcYqjfhZaUs+bQD8SeMtjqPpfFkxNcic4p509F+5CMXx6NkiYll?=
 =?us-ascii?Q?wreOeeDluOIVo/atZqAGMyL+0ylNbwGUT561EDNAGCqWSVMixidsLx1bs9rw?=
 =?us-ascii?Q?OcYXTCBxTKyB/9lZCEY2OzFjGkHCNwIvwgXgNb0fXyDTUyr2CeLgMdRGUd9U?=
 =?us-ascii?Q?rVGsisVwNQFdYIUbk+OCpBuyUnXSPUwzkJhCFCljUnEWK516e4PS/rIPLndp?=
 =?us-ascii?Q?5ToCn3+Eze1KxtC8mPqVwHi4wjgp5soqMQjNDiODQNA+Zpv6nN1v1epAQSc8?=
 =?us-ascii?Q?ZF8cJRZYAaczhq8b6t0LldM3MkY0xHF1br1ZQRBdi2gcesbEsb03TQD9lgJf?=
 =?us-ascii?Q?E9k3cAEGyF5fEfKgzeo5+Ld8eSBl70wlTapxC/MP5D07KxQ67y7tl/Kit+UK?=
 =?us-ascii?Q?AvoAgOwqhiAI01kcs4EQYYN0goyAqXLCu0m3FtfkZuYx62Z5iozbYIHPplyZ?=
 =?us-ascii?Q?2kXjWe6a2JEiEEbfn5S2p7eG7mkZkXci/CgQM+1lHSnP5MBepatqkgGD3K32?=
 =?us-ascii?Q?8p2Kv+oCwbr1q28Sb9IadugIRoVmUWqsLwtePzAmEfrhdE++f8z8K7J/iRgL?=
 =?us-ascii?Q?5/tjYvduE+yfHNc686xOcFiv5jjVE3hcwwxMHoDZ76aZq+IQjgGZa5Qud1KT?=
 =?us-ascii?Q?dhOziMSZlzcjNB5diVITwPDPfkPdKqoHUXzYc3xVS5pOYYSfFFidG+IEPy5Z?=
 =?us-ascii?Q?DkHtVHPlUa6qFeP+kbWGeXk9OipH5zr877kDqwHDEDB9CLNm4Q+tzlby5jJ2?=
 =?us-ascii?Q?/Gez71ESWe67E1a4CNzcf1YvcSgwfR6a77lw8OEzDoJrIbvVXOlo1t7qYdoz?=
 =?us-ascii?Q?VE3FwixQ1Tl6nOZ3XgCss5Z8dBJNKa5pVMrlrphHa85GC3fPVFhzGA8sWNQo?=
 =?us-ascii?Q?AIRop8fQOfs5Lz7Kztto2PQJLGBpAVq8YgduFTDza6O0Aq3MNndh0oHorNS/?=
 =?us-ascii?Q?8NFK/9LGngKyaM6JdL1QVw6ppS7svm4+mZsPh6cyB0NU2KfgoJytJArDn+r6?=
 =?us-ascii?Q?gtHh+qHJYB1qgdP03p3gaMoSvWcDfHH4Y/sU14vxYKyfp7VjX46RurawsYjQ?=
 =?us-ascii?Q?WmkVRCANkEaif/1XjA4MDrUr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4850b5a6-6bdb-414d-5bf3-08d8ee18ded7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 16:29:45.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3CiQFla7702pDXOXcNjc3AwvkTJBT7FpAj99NfbS0RIvp6ezrE5LZegwhRldPN5Vmouc9MfR0CYN+vdw6/8Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0301
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > On Mar 23, 2021, at 11:57 AM, Nagendra Tomar
> <Nagendra.Tomar@microsoft.com> wrote:
> >
> >>> On Mar 23, 2021, at 1:46 AM, Nagendra Tomar
> >> <Nagendra.Tomar@microsoft.com> wrote:
> >>>
> >>> From: Nagendra S Tomar <natomar@microsoft.com>
> >>>
> >>> If a clustered NFS server is behind an L4 loadbalancer the default
> >>> nconnect roundrobin policy may cause RPC requests to a file to be
> >>> sent to different cluster nodes. This is because the source port
> >>> would be different for all the nconnect connections.
> >>> While this should functionally work (since the cluster will usually
> >>> have a consistent view irrespective of which node is serving the
> >>> request), it may not be desirable from performance pov. As an
> >>> example we have an NFSv3 frontend to our Object store, where every
> >>> NFSv3 file is an object. Now if writes to the same file are sent
> >>> roundrobin to different cluster nodes, the writes become very
> >>> inefficient due to the consistency requirement for object update
> >>> being done from different nodes.
> >>> Similarly each node may maintain some kind of cache to serve the file
> >>> data/metadata requests faster and even in that case it helps to have
> >>> a xprt affinity for a file/dir.
> >>> In general we have seen such scheme to scale very well.
> >>>
> >>> This patch introduces a new rpc_xprt_iter_ops for using an additional
> >>> u32 (filehandle hash) to affine RPCs to the same file to one xprt.
> >>> It adds a new mount option "ncpolicy=3Droundrobin|hash" which can be
> >>> used to select the nconnect multipath policy for a given mount and
> >>> pass the selected policy to the RPC client.
> >>
> >> This sets off my "not another administrative knob that has
> >> to be tested and maintained, and can be abused" allergy.
> >>
> >> Also, my "because connections are shared by mounts of the same
> >> server, all those mounts will all adopt this behavior" rhinitis.
> >
> > Yes, it's fair to call this out, but ncpolicy behaves like the nconnect
> > parameter in this regards.
> >
> >> And my "why add a new feature to a legacy NFS version" hives.
> >>
> >>
> >> I agree that your scenario can and should be addressed somehow.
> >> I'd really rather see this done with pNFS.
> >>
> >> Since you are proposing patches against the upstream NFS client,
> >> I presume all your clients /can/ support NFSv4.1+. It's the NFS
> >> servers that are stuck on NFSv3, correct?
> >
> > Yes.
> >
> >>
> >> The flexfiles layout can handle an NFSv4.1 client and NFSv3 data
> >> servers. In fact it was designed for exactly this kind of mix of
> >> NFS versions.
> >>
> >> No client code change will be necessary -- there are a lot more
> >> clients than servers. The MDS can be made to work smartly in
> >> concert with the load balancer, over time; or it can adopt other
> >> clever strategies.
> >>
> >> IMHO pNFS is the better long-term strategy here.
> >
> > The fundamental difference here is that the clustered NFSv3 server
> > is available over a single virtual IP, so IIUC even if we were to use
> > NFSv41 with flexfiles layout, all it can handover to the client is that=
 single
> > (load-balanced) virtual IP and now when the clients do connect to the
> > NFSv3 DS we still have the same issue. Am I understanding you right?
> > Can you pls elaborate what you mean by "MDS can be made to work
> > smartly in concert with the load balancer"?
>=20
> I had thought there were multiple NFSv3 server targets in play.
>=20
> If the load balancer is making them look like a single IP address,
> then take it out of the equation: expose all the NFSv3 servers to
> the clients and let the MDS direct operations to each data server.
>=20
> AIUI this is the approach (without the use of NFSv3) taken by
> NetApp next generation clusters.

Yeah, if could have clients access all the NFSv3 servers then I agree, pNFS=
=20
would be a viable option. Unfortunately that's not an option in this case. =
The=20
cluster has 100's of nodes and it's not an on-prem server, but a cloud serv=
ice,
so the simplicity of the single LB VIP is critical.

>=20
> >>> It adds a new rpc_procinfo member p_fhhash, which can be supplied
> >>> by the specific RPC programs to return a u32 hash of the file/dir the
> >>> RPC is targetting, and lastly it provides p_fhhash implementation
> >>> for various NFS v3/v4/v41/v42 RPCs to generate the hash correctly.
> >>>
> >>> Thoughts?
> >>>
> >>> Thanks,
> >>> Tomar
> >>>
> >>> Nagendra S Tomar (5):
> >>> SUNRPC: Add a new multipath xprt policy for xprt selection based
> >>>   on target filehandle hash
> >>> SUNRPC/NFSv3/NFSv4: Introduce "enum ncpolicy" to represent the
> >> nconnect
> >>>   policy and pass it down from mount option to rpc layer
> >>> SUNRPC/NFSv4: Rename RPC_TASK_NO_ROUND_ROBIN ->
> >> RPC_TASK_USE_MAIN_XPRT
> >>> NFSv3: Add hash computation methods for NFSv3 RPCs
> >>> NFSv4: Add hash computation methods for NFSv4/NFSv42 RPCs
> >>>
> >>> fs/nfs/client.c                      |   3 +
> >>> fs/nfs/fs_context.c                  |  26 ++
> >>> fs/nfs/internal.h                    |   2 +
> >>> fs/nfs/nfs3client.c                  |   4 +-
> >>> fs/nfs/nfs3xdr.c                     | 154 +++++++++++
> >>> fs/nfs/nfs42xdr.c                    | 112 ++++++++
> >>> fs/nfs/nfs4client.c                  |  14 +-
> >>> fs/nfs/nfs4proc.c                    |  18 +-
> >>> fs/nfs/nfs4xdr.c                     | 516 ++++++++++++++++++++++++++=
++++-----
> >>> fs/nfs/super.c                       |   7 +-
> >>> include/linux/nfs_fs_sb.h            |   1 +
> >>> include/linux/sunrpc/clnt.h          |  15 +
> >>> include/linux/sunrpc/sched.h         |   2 +-
> >>> include/linux/sunrpc/xprtmultipath.h |   9 +-
> >>> include/trace/events/sunrpc.h        |   4 +-
> >>> net/sunrpc/clnt.c                    |  38 ++-
> >>> net/sunrpc/xprtmultipath.c           |  91 +++++-
> >>> 17 files changed, 913 insertions(+), 103 deletions(-)
> >>
> >> --
> >> Chuck Lever
>=20
> --
> Chuck Lever
>=20
>=20

