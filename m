Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AF38A3B1
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 11:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhETJ4F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 05:56:05 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:17377
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234270AbhETJxU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 05:53:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7YOFEdr1KkwYSmXzyMPkYL/J794Cl9idWpjbrdVcmeU3vhYYFDhA3Q9216K1TuNZ6WnYXS33v07zXvPffYX+JibiL+sx4tFTKvGI8zO8MFpule7ySJ105zNXYKjkkrTTGJrSVHQf9nfMP2Vp6rX4fB4NnBax4Y/0YURIuZBYxP4MI+T0QEyAPmPqhTpCbxMqH1bdF8WKMprZ+Jk1hvuNT/wybAnl1Hc3ed8pTNI1aoh6bs2KZCyu+HdJlZQsrBmpChY+TZMUHN/jh3pFfnPRn6yt4KiVqGR5m+dJ63+zj5VSIgAqZ2L0nTpjQHmKx684VjHNgg1I4pq7Mb/8k0pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtr7liYI/VomJui/6j+2jD+A9QW+TL1EHnYDPMSE2t8=;
 b=cb7VdAA0CV8pKI8jN9+44s4scqMXtOm6xveNg+T5y9XHlUdWi9CK0kShWbGnb1kavlpL4F7k4wvSNJTE66zgZ0+V21q0XX2J8vhGuRphtW9PXyzbpJ3jeNG6vMthcrIwxXB623cJ3KNRrPgLm6XA+wChklrtt2Tkca3DRXJfZtgN6N8sVdlpWhBFkpUeS68h4Kd0sBeUnmm291mAXmi3F9xMsb7c5/L5anDe8GpGf0KgeEQutaqv69aZV1a0c6TE4bnVziPQwJXOSW1j8cg8AzU+3dp2cUmNvth8mSj6D21lL1+mzvhEvd/HyWtYIFpxtuQC28NirkaVPwgo3L9Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtr7liYI/VomJui/6j+2jD+A9QW+TL1EHnYDPMSE2t8=;
 b=ZfXX3+tNe6JzUOrP2LA5RrpvBJQuZqOMxlhG183kiAmWuqwczQWnKkg+Nqzc2mdI+BKZlHyDV5qVE0/EfYVii4ZwD+4B2MTXOL50z0LXIMg7RdjNZoxJvCdy1XYopihEW66St2s3DZvHuBgJh2OjXFfubPreNIXGmD+658o7PX0=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by MW4PR05MB8697.namprd05.prod.outlook.com (2603:10b6:303:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.12; Thu, 20 May
 2021 09:51:54 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4173.012; Thu, 20 May 2021
 09:51:54 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgADowkM=
Date:   Thu, 20 May 2021 09:51:54 +0000
Message-ID: <CO1PR05MB810173C0D970DE22AA9535B8B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>,<CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
In-Reply-To: <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3b899fe-e398-41d1-8118-08d91b74e662
x-ms-traffictypediagnostic: MW4PR05MB8697:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR05MB86972303B6E496644E9936F5B72A9@MW4PR05MB8697.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwMimQYIUtJiPO7tMgODeeBkB7c5bU55PKxRUjT+AXvxF5Zixvbv3j4a9pleTUzSoUDgRXVGbCofunswRzBiS9NnQRWs5qqh8AoHILl/npipgkAP2YEeI4RDE4r9tH/GMMF8ytGz+x22bsqPxA3f9SuYEvB9m0h0YrNggQ+bF7v8VPpNdC0GriLtad8rIc8ufWxtR8yzNrn6H3FjoNEkhoDvV8qeLQPKaNofgGQfgzb0aRZgLTOhIl2hoNMwh2O3En5P0Xp9iDHr5OlbPjaIsIAq8UW7GXNHLrN205jbAusdvo4f8SodHmDILsggCZCmH+L/WtVWhw4kPrX1ktCcJgj8RWd9BYjef7meRTfN2oRDviLexnhaC8sObcp6HuiS8o++QI9YeOEPsO7kxbVy00PRnXHmB6V971vPsrzP7yoP4cnWFNfoCZ9532fIkfMduABdyfpvK0Vg57K22dhO0RIaZu/o64YcfjShpWhfXs8Uq+qJ/hQ89hpdPVRkE66SGyHr8QvCEtdrbIPNAq49TiQO2nZ5Ckrl7egce7Di17j2hMVEsNY3GMdK86YAeSLH54Wb3jB5rb4ZYMruOqR5bMaRuvIuqjkFZQP7xJeIqnHHAVSxjrIVU26VSTgX8GRLT5muKqFPL2gB+1wwgpu4yaeVOPvc6JGIC/rd1dhD+CGhsrmZZtEeMQ4qnbGVUKpAejZPI8/n8oQADgEvPJdFuE5eBpqEa8DwFtG9bCjG9FI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(966005)(9686003)(86362001)(71200400001)(53546011)(45080400002)(4326008)(8936002)(26005)(6916009)(498600001)(8676002)(91956017)(55016002)(64756008)(66946007)(6506007)(7696005)(66556008)(66476007)(66446008)(5660300002)(186003)(76116006)(2906002)(33656002)(122000001)(38100700002)(52536014)(10126625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?CdhXrmYr3N4zjvt9dVcmLyZcrbJ99xh4uEexkL9DQDEIVmZ/LAPquKMh?=
 =?Windows-1252?Q?22BED32iraRZY7k5PXXszEt1JsAIQn1fuaG7r8Pw+zGJ8dbC+nYtrSsR?=
 =?Windows-1252?Q?knX1WD98QP4zeZ9NTrzXoBtUaAkPlbEU7lVEg8flr03mHuSqBHbLfWoJ?=
 =?Windows-1252?Q?h1+MaV9xboKk7PZVPIH8pur3sJIFWor91wyA+KmHB//7e+y3Mikjpv6w?=
 =?Windows-1252?Q?IvpBPuVm1Zcf9JtCz5RBBxLzd3Y8XSz/NENUG2Au9HVDrKZLbTo8hmZt?=
 =?Windows-1252?Q?N+9Zr2/gO6uSdrwC3YzVJA0+Hoy2jzy99L/QqMhO7n5IzEVsprEu87Qm?=
 =?Windows-1252?Q?FnoOlPeGmQHTaIWaCpsoRuKFdGmjqrZoQ9c5FkZsH17IFOCtBSSU64zy?=
 =?Windows-1252?Q?KznThx0lY6AwZiy/p/k1htEl36jUf81bu8YlrH0R5ziz2zPNxaAy/VxR?=
 =?Windows-1252?Q?OajmZ5enxxpOCt7k4TD7VLpwk+k0x+cXuyXG7MelaC1dA6spIQGiIPWT?=
 =?Windows-1252?Q?iaXzFu97CTR/MyXj/IcNWmTnbZMmbXITh73d8iDRC68DzwDXdYHhAnpm?=
 =?Windows-1252?Q?axjrnf1o1paHJbe/dPwaLueI9iHMPPuWdD5zrjNPDbldvDane7TRFE/V?=
 =?Windows-1252?Q?00TYujNwDb5oZoQ6CYVAPwyS+DyKY70Wgt4bWaO2aFNMpSEB08XRTPdY?=
 =?Windows-1252?Q?xj/9tSeXT+7v63vHOR7ODgIoWtjM5woxLDcavl0t4DSp3X60lTykSbiR?=
 =?Windows-1252?Q?YT7ToLcHoZtyTXNevI8uemIfkUxVZ0plFYELexh4gCg0EXmlqAFqXUpp?=
 =?Windows-1252?Q?DjzNPTmnRCBnaXYaqqSKrsSlQFrEhjBJBF7YwNJr9cgfeYo2jepQh2N8?=
 =?Windows-1252?Q?DzigZwlGhopHhlNsl3fSkEnUB6X6AcE1YnuUcR2aMBJYQI1gdFn9YODd?=
 =?Windows-1252?Q?IaQa/x9SSTg9YBFg5V8gzSe9DrgkyvkgfmWNTFghkW/agKRaiUVobgbh?=
 =?Windows-1252?Q?fphzUydpr87dfAvSaF/d9VPf4FcRC1kxAHt76z152o87T9f2jd2roEJv?=
 =?Windows-1252?Q?RSlSORGm9Ce+z35gjA6hrQqM65fSVSDWYT+i3xqa4gV/vOussacirVOF?=
 =?Windows-1252?Q?NbEateV+Gn++4zcmuePe8j793vxB+84ThBxv6WCS7go2iZpJ6M3OztAr?=
 =?Windows-1252?Q?x+97vRmlUXWOrGd5uj8m3a2eJ+AiR1Qry03ddR8a3p9XS2chnTtHan4C?=
 =?Windows-1252?Q?WmuqwRnsqn7ziUzg2MxsCFt54hmb0xyFJSDI0lb3cycLYTUoA6whsoGo?=
 =?Windows-1252?Q?/GY3yNWg/Dr4z/0MRuQTqTUaXvc1Zr4c4kFV4f25ywe9ohAAuxjRJkpi?=
 =?Windows-1252?Q?nSOFsgqUM0eZmm46EgF9fz+bjimI9bA59Uw=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b899fe-e398-41d1-8118-08d91b74e662
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 09:51:54.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXSASwz/7KdrV+5aIvObcbYonlMkSPNok9ZcquDupdize26rMRML+z8248lJuPfKvvG3cQ/ZTRGcBKuZwEl19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8697
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Orna,=0A=
=0A=
Thank you for looking.=0A=
=0A=
I spent a couple of hours trying to get various=0A=
SystemTap=A0NFS scripts working but mostly got errors.=0A=
=0A=
For example:=0A=
> root@mikes-ubuntu-21-04:~/src/systemtap-scripts/tracepoints# stap nfs4_fs=
info.stp=0A=
>=A0semantic error: unable to find tracepoint variable '$status' (alternati=
ves: $$parms, $$vars, $task, $$name): identifier '$status' at nfs4_fsinfo.s=
tp:7:11=0A=
>=A0=A0 =A0 =A0 =A0 source: terror =3D $status=0A=
>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^=0A=
>=A0Pass 2: analysis failed. =A0[man error::pass2]=0A=
=0A=
If you have any stap scripts that work on Ubuntu=0A=
that you'd=A0like me to run=A0or have pointers on how=0A=
to setup my Ubuntu=A0environment to run them=0A=
successfully,=A0please let me know and I can try again..=0A=
=0A=
=0A=
Here's the call trace for the mount.nfs command=0A=
mounting the bad NFS server/10.1.1.1:=0A=
=0A=
[Thu May 20 08:53:35 2021] task:mount.nfs =A0 =A0 =A0 state:D stack: =A0 =
=A00 pid:13903 ppid: 13900 flags:0x00004000=0A=
[Thu May 20 08:53:35 2021] Call Trace:=0A=
[Thu May 20 08:53:35 2021] =A0? rpc_init_task+0x150/0x150 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0__schedule+0x23d/0x670=0A=
[Thu May 20 08:53:35 2021] =A0? rpc_init_task+0x150/0x150 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0schedule+0x4f/0xc0=0A=
[Thu May 20 08:53:35 2021] =A0rpc_wait_bit_killable+0x25/0xb0 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0__wait_on_bit+0x33/0xa0=0A=
[Thu May 20 08:53:35 2021] =A0? call_reserveresult+0xa0/0xa0 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0out_of_line_wait_on_bit+0x8d/0xb0=0A=
[Thu May 20 08:53:35 2021] =A0? var_wake_function+0x30/0x30=0A=
[Thu May 20 08:53:35 2021] =A0__rpc_execute+0xd4/0x290 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0rpc_execute+0x5e/0x80 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0rpc_run_task+0x13d/0x180 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0rpc_call_sync+0x51/0xa0 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0rpc_create_xprt+0x177/0x1c0 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0rpc_create+0x11f/0x220 [sunrpc]=0A=
[Thu May 20 08:53:35 2021] =A0? __memcg_kmem_charge+0x7d/0xf0=0A=
[Thu May 20 08:53:35 2021] =A0? _cond_resched+0x1a/0x50=0A=
[Thu May 20 08:53:35 2021] =A0nfs_create_rpc_client+0x13a/0x180 [nfs]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_init_client+0x205/0x290 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0? __fscache_acquire_cookie+0x10a/0x210 [fscac=
he]=0A=
[Thu May 20 08:53:35 2021] =A0? nfs_fscache_get_client_cookie+0xa9/0x120 [n=
fs]=0A=
[Thu May 20 08:53:35 2021] =A0? nfs_match_client+0x37/0x2a0 [nfs]=0A=
[Thu May 20 08:53:35 2021] =A0nfs_get_client+0x14d/0x190 [nfs]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_set_client+0xd3/0x120 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_init_server+0xf8/0x270 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_create_server+0x58/0xa0 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_try_get_tree+0x3a/0xc0 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs_get_tree+0x38/0x50 [nfs]=0A=
[Thu May 20 08:53:35 2021] =A0vfs_get_tree+0x2a/0xc0=0A=
[Thu May 20 08:53:35 2021] =A0do_new_mount+0x14b/0x1a0=0A=
[Thu May 20 08:53:35 2021] =A0path_mount+0x1d4/0x4e0=0A=
[Thu May 20 08:53:35 2021] =A0__x64_sys_mount+0x108/0x140=0A=
[Thu May 20 08:53:35 2021] =A0do_syscall_64+0x38/0x90=0A=
[Thu May 20 08:53:35 2021] =A0entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
=0A=
=0A=
Here's the call trace for the mount.nfs command=0A=
mounting an available NFS server/10.188.76.67 (which was=0A=
blocked by the first mount.nfs command above):=0A=
[Thu May 20 08:53:35 2021] task:mount.nfs =A0 =A0 =A0 state:D stack: =A0 =
=A00 pid:13910 ppid: 13907 flags:0x00004000 =0A=
[Thu May 20 08:53:35 2021] Call Trace:=0A=
[Thu May 20 08:53:35 2021] =A0__schedule+0x23d/0x670=0A=
[Thu May 20 08:53:35 2021] =A0schedule+0x4f/0xc0=0A=
[Thu May 20 08:53:35 2021] =A0nfs_wait_client_init_complete+0x5a/0x90 [nfs]=
=0A=
[Thu May 20 08:53:35 2021] =A0? wait_woken+0x80/0x80=0A=
[Thu May 20 08:53:35 2021] =A0nfs_match_client+0x1de/0x2a0 [nfs]=0A=
[Thu May 20 08:53:35 2021] =A0? pcpu_block_update_hint_alloc+0xcc/0x2d0=0A=
[Thu May 20 08:53:35 2021] =A0nfs_get_client+0x62/0x190 [nfs]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_set_client+0xd3/0x120 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_init_server+0xf8/0x270 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_create_server+0x58/0xa0 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs4_try_get_tree+0x3a/0xc0 [nfsv4]=0A=
[Thu May 20 08:53:35 2021] =A0nfs_get_tree+0x38/0x50 [nfs]=0A=
[Thu May 20 08:53:35 2021] =A0vfs_get_tree+0x2a/0xc0=0A=
[Thu May 20 08:53:35 2021] =A0do_new_mount+0x14b/0x1a0=0A=
[Thu May 20 08:53:35 2021] =A0path_mount+0x1d4/0x4e0=0A=
[Thu May 20 08:53:35 2021] =A0__x64_sys_mount+0x108/0x140=0A=
[Thu May 20 08:53:35 2021] =A0do_syscall_64+0x38/0x90=0A=
[Thu May 20 08:53:35 2021] =A0entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
=0A=
I've pasted the entire dmesg output=A0here:=A0https://pastebin.com/90QJyAL9=
=0A=
=0A=
=0A=
This is the command I ran to mount an unreachable NFS server:=0A=
date; time strace mount.nfs 10.1.1.1:/nopath /tmp/mnt.dead; date=0A=
The strace log:=A0https://pastebin.com/5yVhm77u=0A=
=0A=
This is the command I ran to mount the available NFS server:=0A=
date; time strace mount.nfs 10.188.76.67:/ /tmp/mnt.alive ; date=0A=
The strace log:=A0https://pastebin.com/kTimQ6vH=0A=
=0A=
The procedure:=0A=
- run dmesg -C to clear dmesg logs=0A=
- run mount.nfs on 10.1.1.1 (this IP address is down/not responding to ping=
) which hung=0A=
- run mount.nfs on 10.188.76.67=A0 which also hung=0A=
- "echo t >=A0/proc/sysrq-trigger" to dump the call traces for hung process=
es=0A=
- dmesg -T > dmesg.log to save the dmesg logs=0A=
- control-Z the mount.nfs command to 10.1.1.1=0A=
- "kill -9 %1" in the terminal to kill the mount.nfs to 10.1.1.1=0A=
- mount.nfs to 10.188.76.67 immediately mounts successfully=0A=
  after the first mount is killed (we can see this by the timestamp in the =
logs files)=0A=
=0A=
=0A=
Thanks, Mike=0A=
=0A=
=0A=
=0A=
From: Olga Kornievskaia <aglo@umich.edu>=0A=
Sent: Wednesday, May 19, 2021 12:15 PM=0A=
To: Michael Wakabayashi <mwakabayashi@vmware.com>=0A=
Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS=
 mounts on same machine =0A=
=A0=0A=
On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi=0A=
<mwakabayashi@vmware.com> wrote:=0A=
>=0A=
> Hi,=0A=
>=0A=
> We're seeing what looks like an NFSv4 issue.=0A=
>=0A=
> Mounting an NFS server that is down (ping to this NFS server's IP address=
 does not respond) will block _all_ other NFS mount attempts even if the NF=
S servers are available and working properly (these subsequent mounts hang)=
.=0A=
>=0A=
> If I kill the NFS mount process that's trying to mount the dead NFS serve=
r, the NFS mounts that were blocked will immediately unblock and mount succ=
essfully, which suggests the first mount command is blocking the other moun=
t commands.=0A=
>=0A=
>=0A=
> I verified this behavior using a newly built mount.nfs command from the r=
ecent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Cloud=
 Image 21.04:=0A=
> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
rceforge.net%2Fprojects%2Fnfs%2Ffiles%2Fnfs-utils%2F2.5.3%2F&amp;data=3D04%=
7C01%7Cmwakabayashi%40vmware.com%7Cfe9df245d11945bd70fd08d91afa7565%7Cb3913=
8ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637570485288219912%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;sdata=3D90wWL%2FDqjJMsdlFDxF3hlmyhuS86VwNrtOD%2BLTGxY20%3D&amp;res=
erved=3D0=0A=
> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fclo=
ud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubuntu-21.04=
-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7=
Cfe9df245d11945bd70fd08d91afa7565%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C=
0%7C637570485288219912%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiWIB0PuQ1HiOpFGmo=
ViTmzreirD8EJRAkG%2BOw57QTKs%3D&amp;reserved=3D0=0A=
>=0A=
>=0A=
> The reason this looks like it is specific to NFSv4 is from the following =
output showing "vers=3D4.2":=0A=
> > $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt=0A=
> > [ ... cut ... ]=0A=
> > mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=3D4=
.2,addr=3D<unreachable-IP-address>,clien"...^C^Z=0A=
>=0A=
> Also, if I try the same mount.nfs commands but specifying NFSv3, the moun=
t to the dead NFS server hangs, but the mounts to the operational NFS serve=
rs do not block and mount successfully; this bug doesn't happen when using =
NFSv3.=0A=
>=0A=
>=0A=
> We reported this issue under util-linux here:=0A=
> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fkarelzak%2Futil-linux%2Fissues%2F1309&amp;data=3D04%7C01%7Cmwakabay=
ashi%40vmware.com%7Cfe9df245d11945bd70fd08d91afa7565%7Cb39138ca3cee4b4aa4d6=
cd83d9dd62f0%7C0%7C0%7C637570485288219912%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DWLxFM2Ls5PodPjrvA%2FZninvvHF6LlrO9ywSEMwgcR50%3D&amp;reserved=3D0=0A=
> [mounting nfs server which is down blocks all other nfs mounts on same ma=
chine #1309]=0A=
>=0A=
> I also found an older bug on this mailing list that had similar symptoms =
(but could not tell if it was the same problem or not):=0A=
> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40notabene.n=
eil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7Cfe9df245=
d11945bd70fd08d91afa7565%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C63757=
0485288219912%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DY6A61VJQ6IDwsvUjjBc%2Fjrf8=
0rvGSkaIjc0UhWRQ9kk%3D&amp;reserved=3D0=0A=
> [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]=0A=
>=0A=
> Thanks, Mike=0A=
=0A=
Hi Mike,=0A=
=0A=
This is not a helpful reply but I was curious if I could reproduce=0A=
your issue but was not successful. I'm able to initiate a mount to an=0A=
unreachable-IP-address which hangs and then do another mount to an=0A=
existing server without issues. Ubuntu 21.04 seems to be 5.11 based so=0A=
I tried upstream 5.11 and I tried the latest upstream nfs-utils=0A=
(instead of what my distro has which was an older version).=0A=
=0A=
To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.=0A=
Or also get output from dmesg after doing =93echo t >=0A=
/proc/sysrq-trigger=94 to see where the mounts are hanging.=
