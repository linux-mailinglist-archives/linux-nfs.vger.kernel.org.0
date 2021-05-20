Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E938A82A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhETKrO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 06:47:14 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:38014
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236814AbhETKpO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 06:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7dUpthOLPFNa8lclZBegmqyeCXtz2W19qs/t8eXTnfdSKtImJ4GM8+d52LzIp3E20m7kUCr5+WPmbHl7bMyT5NNSZZAc+vtDgqdgaBh/dm3z8+Fu1V7nL/8Dqcu0Sh5Yhmu9fYzjhHSdgGXMx2xpev502CWdcCz4lCedbC2ogRu3hNEdz0fIc5zhsn0sSKatzZKoLotZ/JvvXTfrGdbeaFGW2i94pok6hc/zKJqGX8hjdd0wlHGqkOxBD0tSdQHwf0yGwMd4eNVoCe9mFwoIGO0h1RiP2d1yUnIi9PqmGb538e6IVAqxal/4+i/Bq9P8WbelKP/CaZp728xhHRxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcAjT6B9ofRxvrMquGaAtoJRmAAczeWf20YNNZWpZ78=;
 b=Jal7V6rYWgnc3xfbt+NNZWqGD+Z/c0o8yNTx0KjWWkN6ySRX9X4Wi8tOfMiM5iE7tMtz1w/pQ3JDPjNxWl0f2Pg0uOB2MZ+TBlz0haHGaA0FsJQI+SkH/WsbBCH9H0kxbgp4e+aM6THAd5YiKaIzncs/7fspi7XFVZ+zHHJhrbiuh3gsw1/6gfqJuh6KRzbRy9uOdq14s/NmLfiFGt1jeoDbjmnXEChHP3LGKYFnDmEd9gKQHtlr9TsRtRvG1VXAeyvKcUbK0zAvbkOEOI1kf3Jkge/s+xAjlxN4eUP1xukFsdnfbxnlr5snFCV3vC0+6JI+7sJOoLJ+nI22kERLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcAjT6B9ofRxvrMquGaAtoJRmAAczeWf20YNNZWpZ78=;
 b=dVLwDkHXxc5jFHRoZoj4nOGO+U/L2v54j2/ETo5RwMnGZ16KfvYKSA+C8KZ2lIC43JLqDNjVINzHDPrk84DPB3Rhc4ekgtic1ch6uEWF4Mo67hBfJSL2xilebMFGBJVT2wWdBOIpIjkGx+4002XZiuXYkEFWxpVcKDGrIiNtsro=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by CO1PR05MB8072.namprd05.prod.outlook.com (2603:10b6:303:f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12; Thu, 20 May
 2021 10:43:50 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4173.012; Thu, 20 May 2021
 10:43:50 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgADowkOAABnQAA==
Date:   Thu, 20 May 2021 10:43:50 +0000
Message-ID: <CO1PR05MB8101FEE18F82B0B3B251F1E5B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>,<CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>,<CO1PR05MB810173C0D970DE22AA9535B8B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB810173C0D970DE22AA9535B8B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1e4b832-e6e6-44f0-c4ff-08d91b7c27a0
x-ms-traffictypediagnostic: CO1PR05MB8072:
x-microsoft-antispam-prvs: <CO1PR05MB80722D4EBF6EC74FF8F3981DB72A9@CO1PR05MB8072.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvDmFp3872pRki9/wEdSVfw9FnIbrpz4X/1UPa9liwY/QRyAMKVyBwr94bVQyPzcB/kGNG7tyuSBM43yOC9zMvYkkixlWmjXhGrqc7xybdFq7fitdlZEUumtFpSmgcZHGJRZPHBQVOicwZEBlXDZZtSAo9GCURxWbWWZXKAIr93sAXSCiuxI/xpN500UERdjALTZN6IJG/8xIMkTJ0Q1UFAjTCgYjjqGyy/bnbBvJuJPd4C3Qy9gpCLOyuG2LdUsoRb6zO4CzxogEmY7WnWjpPrdVvy4uRmfdkCsQydqDlJ3SzG4C0pP/m7/cBUIUJaeDZ4CmPZknhcCZYbPHnIFdDn6R3Hc4SDas7s4xtgREwB2wcwtGTolabhwjlM8PQX3qzRvCGda4E0pFnr3vDFVjJXQ/eQDsS+Yj880DmFFjRqj8nuAqXenA4qcErYJ+AGjmeyj2IzMPlbI5N5R+8If8/2AahbP0SbppAm7fpdGadBy+Pp1BYwRCaKJ+M9rvjLI8jWLyyNQ6i6a7m6NMYUpSvqx1kdKmJBfRKjeL+OgzRJzWeKUryWTTvnlOViiTQCr3So55eXhRzOF7izW3ke4izUI21aYPXzqumMXlUJJYejwV8m5WScsylxneIOJNmkQqzp9kijDVWZxVavdBfzo/PzuAN5ySGsn77Zo3B8S4SyxPlbSM5nn+hUVanFj7PTu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(966005)(316002)(6916009)(38100700002)(55016002)(9686003)(478600001)(122000001)(186003)(33656002)(45080400002)(76116006)(4326008)(8936002)(71200400001)(66476007)(66556008)(66446008)(64756008)(8676002)(66946007)(7696005)(86362001)(2906002)(53546011)(26005)(30864003)(5660300002)(6506007)(83380400001)(2940100002)(91956017)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?QR7IPeE3s1QEX1VQQuP1OX/TL9ZmyPWgyYxu2ci8FvYfwmhYL5dw2FjN?=
 =?Windows-1252?Q?H9qNZ8OxcVMd1VVCCOBVYekV0znnMOrlDSpnVLOt0gkylmQhLONdQTv4?=
 =?Windows-1252?Q?WDxJeyrCKJExvsOob67fn8Zd3LLX4fCSB/XbgMvv2X5oVJ541M3V3ggs?=
 =?Windows-1252?Q?kWnsXyUcoKvINqUX5pDZXdZoFltzupihVQcx0ut9M1tWoAg2VDwaYgpI?=
 =?Windows-1252?Q?u4p9i58hWcgN9nBE/3SC0mP407AeH9lrTrgz18SGxFxfd3ZY6SO7T2A0?=
 =?Windows-1252?Q?A8YDtCq2IZrCzFgJZEyVAL7FdUz3u1AhexVXRFHfDrfpYDXx7JGt4LZs?=
 =?Windows-1252?Q?GxMHL9HJgKEI2X2XjZpVwWUaEhHuw2CbRwWSAxliVDGh3QjbkwaC5jTp?=
 =?Windows-1252?Q?8RQxoSPr8B4VsctdBKMBrsXQ+npS9XbQS62SdWlKOv4hLanp2JMPlcwp?=
 =?Windows-1252?Q?iQfenvS4tB+0o2nE28AwRm7RUYJAPZ0CJwE9rA24+zL/qxnyZ8TuMrve?=
 =?Windows-1252?Q?7HLt+ZFIFHdfXtLPUzCLtAs8VWpt4d2wajx2VhRe2W8lJ8L8V8NfZVtC?=
 =?Windows-1252?Q?0jOGZQUZv+0EM+wxKB+cN435v/scVBTqiTlWVcAGAKn4CUA2sHld875e?=
 =?Windows-1252?Q?LKoo+sm/6Sf/j5miRHOGBcAgcyJsuL5lfYPQj6vSD3TyCnUs2dDRHY7J?=
 =?Windows-1252?Q?6mhhECyCmgTZWjlRHSqD3PqOSY8GFTTeCptbbI54kLSp4Fvm1KJvb5Bn?=
 =?Windows-1252?Q?Qgt1qUcon+di85IH98Sckh8ZOibTeBk9jmJCEPyPq1mw33w+p1ZVKfQc?=
 =?Windows-1252?Q?BrETn7MfJIgjt5lnYh62yqvab8J5+u0JBO7kIaX27zTFFD+V46PsDd8c?=
 =?Windows-1252?Q?rMPBtFGA/hbTHHfazN9KPbdYckxYZVPUvus0fWkUmk+HpCjaUqpdJNpg?=
 =?Windows-1252?Q?6JbjVi+goMC3Cn9mn7u6q4A90CEk/TsJGFQmZTzs4DrVI3RWlu24tNoH?=
 =?Windows-1252?Q?2WN3e0vawysGQDSbs4xmw1S4eE80H2fafs+vDYg8l8uTV+vcpB5bw4gu?=
 =?Windows-1252?Q?rTbzKZ2YotZd91g0He6L+VQOQDR6BmEyDAezxuebpVsfm3RH5SXmmmgx?=
 =?Windows-1252?Q?PHnbzv/3TOuyBlZUZ3SR9Bk4Wxas4N0lD03AQb9qG4i+cpP1zucelAM8?=
 =?Windows-1252?Q?Npr2ECwmHNjweTlZllOrNYqHmcFLU+aI/70Q1QTdzWuGEn+ezN8grZCF?=
 =?Windows-1252?Q?KOaveD1c3xzZxp71HRhbfby+bODWnztSALOxwnMcz2pt5KufOoMWr7F+?=
 =?Windows-1252?Q?VaL6UbcafA2K6pFVE2jVreHbwL61BnMTmSkS7ECvo6KDFG620PWE/uSy?=
 =?Windows-1252?Q?F68Np8xS5ixv4Dcti3OHU4l4nnJckQZAC4A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4b832-e6e6-44f0-c4ff-08d91b7c27a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 10:43:50.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmHOmdz9kWy727Z5aobqASq4p85WCopC2lzediPjodBzHeWUMacTop/nS4CrOmjrTZMJW4vZqYu/tjquHwAPGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8072
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,=0A=
=0A=
If you are able to run privileged Docker containers=0A=
you might be able to reproduce the issue running=0A=
the following docker commands.=0A=
=0A=
docker pull ubuntu:hirsute-20210514 # ubuntu hirsute is the latest version =
of ubuntu=0A=
=0A=
# Run this to find the id of the ubuntu image =A0which is needed in the nex=
t command=0A=
docker image ls # image id looks like "274cadba4412"=0A=
=0A=
# Run the ubuntu container and start a bash shell.=0A=
# Replace <ubuntu_hirsute_image_id> with your ubuntu image id from the prev=
ious step.=0A=
docker container run --rm -it --privileged <ubuntu_hirsute_image_id> /bin/b=
ash=0A=
=0A=
=0A=
# You should be inside the ubuntu container now and can run these Linux com=
mands=0A=
apt-get update # this is needed, otherwise the next command fails=0A=
=0A=
# This installs mount.nfs. Answer the two questions about geographic area a=
nd city.=0A=
# Ignore all the debconf error message (readline, dialog, frontend, etc)=0A=
apt install -y nfs-common=0A=
=0A=
# execute mount commands=0A=
mkdir /tmp/mnt1 /tmp/mnt2=0A=
mount.nfs 1.1.1.1:/ /tmp/mnt1 &=0A=
mount.nfs <accessible-nfs-host:path> /tmp/mnt2 &=0A=
jobs =A0# shows both mounts are hung=0A=
=0A=
Thanks, Mike=0A=
=0A=
=0A=
From: Michael Wakabayashi <mwakabayashi@vmware.com>=0A=
Sent: Thursday, May 20, 2021 2:51 AM=0A=
To: Olga Kornievskaia <aglo@umich.edu>=0A=
Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS=
 mounts on same machine =0A=
=A0=0A=
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
I've pasted the entire dmesg output=A0here:=A0https://nam04.safelinks.prote=
ction.outlook.com/?url=3Dhttps%3A%2F%2Fpastebin.com%2F90QJyAL9&amp;data=3D0=
4%7C01%7Cmwakabayashi%40vmware.com%7C2759b06e70634987fce108d91b754e5f%7Cb39=
138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;sdata=3DxpENxRqSdn4aDPwB890%2Bh1RpB4dD2DfpnVGQeM6n0Io%3D&amp;res=
erved=3D0=0A=
=0A=
=0A=
This is the command I ran to mount an unreachable NFS server:=0A=
date; time strace mount.nfs 10.1.1.1:/nopath /tmp/mnt.dead; date=0A=
The strace log:=A0https://nam04.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fpastebin.com%2F5yVhm77u&amp;data=3D04%7C01%7Cmwakabayashi%40vmwa=
re.com%7C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f=
0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1uaPa3RDc=
R32%2Buh6NQd2F7wq5%2BvYZ0dnWcGve0bSj%2FQ%3D&amp;reserved=3D0=0A=
=0A=
This is the command I ran to mount the available NFS server:=0A=
date; time strace mount.nfs 10.188.76.67:/ /tmp/mnt.alive ; date=0A=
The strace log:=A0https://nam04.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fpastebin.com%2FkTimQ6vH&amp;data=3D04%7C01%7Cmwakabayashi%40vmwa=
re.com%7C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f=
0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1YwGfM0u1=
zQsWmOuZX6FJjYwlf3e01cMpJCDtK8JRI0%3D&amp;reserved=3D0=0A=
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
=A0 after the first mount is killed (we can see this by the timestamp in th=
e logs files)=0A=
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
7C01%7Cmwakabayashi%40vmware.com%7C2759b06e70634987fce108d91b754e5f%7Cb3913=
8ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637571012932297691%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;sdata=3DM6sP%2BH1XO2Ojhe0WOSCuFqDQDKJoOUdi2xR6dO5vkjQ%3D&amp;reser=
ved=3D0=0A=
> * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fclo=
ud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubuntu-21.04=
-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7=
C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C=
0%7C637571012932307646%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1iJYjPv5CHpQ6VJ0D=
RPvHXvbiqQZgaE9pt7VeGNKq0U%3D&amp;reserved=3D0=0A=
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
ashi%40vmware.com%7C2759b06e70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6=
cd83d9dd62f0%7C0%7C0%7C637571012932307646%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D9N5DFtCJykN%2F3YigbajvZrBt6T2jpfGPyY6QujZDS2o%3D&amp;reserved=3D0=0A=
> [mounting nfs server which is down blocks all other nfs mounts on same ma=
chine #1309]=0A=
>=0A=
> I also found an older bug on this mailing list that had similar symptoms =
(but could not tell if it was the same problem or not):=0A=
> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40notabene.n=
eil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7C2759b06e=
70634987fce108d91b754e5f%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C63757=
1012932307646%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DZ8agzK7vCLHVnY8yzJ23D3aBrW=
F0jsD7SYxwT3mtqjg%3D&amp;reserved=3D0=0A=
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
