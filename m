Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD438CE02
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 21:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhEUTM5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 15:12:57 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:41909
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231174AbhEUTM4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 15:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug4WpNCDpg+L5/MrLm941FDvbYRCdkXPWv2olK1QU+K+mV+Zlpe0mIVhaBGNDWVrtd3tb7Thh+nFyMhDCeVsSHAYm3it12RqV/6d6gPwgvu8p+L/QqEz9xCMvQmf9Ebf431s8dSZHgDT5D4XXY/3F/6Xtxkkc/NryNYEC8L0UfyUQLd3a34D7tF1V3Zgnlu5FlyLlxwaDPbjEylWfMHXI/SUC+rtAZS9V2P73N4BrVc9pvwieWToRChBkf6rneD+OUDIzcMnh6DfOC1cKKsK29cgkOe2m5FVgH2WXSfAiFcjvr4CISJy5V8E8X2VZTJpszqAiMVzaoP9ttpi50x23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGygnnCoYNEKwl4iMR0uoIxbCgY+7ktstagbzGofk2E=;
 b=JDMgdVOXlI/fKwBgJdaY0mzizvEb6wM4Uv0vVetktFK8aOLPUkUCsjmE/pVha1EY/Id4KScEP/leB2c+elIFuPv5Q276QiDwRHNywBug1T4L1IvffNJE+0e1BAFHhA7zjcTduy640CXYKG0QktPgtyQ7KGYLsOepHNP0V1fjPrgxQmckHt3JP9QglQ56yJSjU5a3WmZ2GFATfgiKplN+pAAcARBWUQb9innIDO5U+qSSb/QRMBXy3lHVka7gH8biuPRND73OEzLdFcXSQ56ZOZixvRdyGj5ljpbxCQqs02ZURpwmK2tAdVVkYNlsLyX344YP6FxNeRU34LNcd2k6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGygnnCoYNEKwl4iMR0uoIxbCgY+7ktstagbzGofk2E=;
 b=FfbmNb7FB8tr2zwgPK/VMogTQEBghF18GAx83Z2V5hEMq2Q7w+85nn0gWpRF5pNzeYn+yBsf6yoriko7VIp81ErJdh0XlaiXJeBsMuKnsu1RegDF9OdHtK1354RbvaaqPOODGr27K5blz3UJmz4GBt2lID50bY9KEdBMZsTXDUk=
Received: from CO1PR05MB8101.namprd05.prod.outlook.com (2603:10b6:303:fa::14)
 by CO6PR05MB7652.namprd05.prod.outlook.com (2603:10b6:5:341::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11; Fri, 21 May
 2021 19:11:28 +0000
Received: from CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002]) by CO1PR05MB8101.namprd05.prod.outlook.com
 ([fe80::6cbf:9cac:d7f7:d002%7]) with mapi id 15.20.4173.012; Fri, 21 May 2021
 19:11:28 +0000
From:   Michael Wakabayashi <mwakabayashi@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgADowkOAABnQAIAA3Q+AgAFDiLY=
Date:   Fri, 21 May 2021 19:11:28 +0000
Message-ID: <CO1PR05MB8101F210648CF41D02510E23B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <CO1PR05MB810173C0D970DE22AA9535B8B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CO1PR05MB8101FEE18F82B0B3B251F1E5B72A9@CO1PR05MB8101.namprd05.prod.outlook.com>,<CAN-5tyGmq=LrO4SgqjJdhJkEgNfAHEbVNkNtEeuA3vvW7rjV=g@mail.gmail.com>
In-Reply-To: <CAN-5tyGmq=LrO4SgqjJdhJkEgNfAHEbVNkNtEeuA3vvW7rjV=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [67.161.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3be7752-996a-4149-32a6-08d91c8c3c6e
x-ms-traffictypediagnostic: CO6PR05MB7652:
x-microsoft-antispam-prvs: <CO6PR05MB7652AEB64D71B83402411F37B7299@CO6PR05MB7652.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXCwlxE2iLzEZ7W6i4emNpE5oFSRHOiYL5hDSPhbqFxIfpXyjd/A1M1z+zG73XuXPIalGiGXVCKyChTRYG6SzSHMcnRPrnLeziBhhheZ7Th9PlpOHTkpYU5XuaQjkmEXwzMWeHOMWdv0FqvcIqfuAnCNhHWU69GIPrIw1Bks36dk86ykgDlOQ1ZD5J75fflnIVm7dVv9owTubc7xAn8zvHBYpPbS1q8w28mypwgTAeWEUUeUcJwKeVtbTYrzHTbr7OHsY0nSrYOZARnLvb1EmmwaNIcYd5+POeoxudisGRu6ldjI9HTeuziKwvMJ80khvKxK4TivIuFHiPhefsuF9bcGQNEUffcQoufw8dmMMk9Xw8i3i9BNU5JEgRzamgwoTGlCrCwuGsja2emmBb8w+qAIEJv0+epYoKmyM6yR9whEW6Oc1NwkKuiH90F3A6/pSeqTNW9dGLzVNOHLaSE9/7j5QUbwFHQE+ImV93faBEEWso2m0Ms02UHWl6yK1eJ2Z3V1ytx+MfSn3uUTW/7ANl6FVuOp1zyN91RQKFC+ZNhY7k1vXud1EAVr3TPV0QjY87mtgwXtq6o9szjEcIo3oGIaQVoavAjmm54r27UQTeMIF4j+WdXYphgdjaMzsEk5oJ6sOBSjArcro70cvslAc4p3Q0jkcBK188eFrb6KcoehFu7Wns0kLesUWa6pbtbPRC4mJLzhFIkxY5ydCKJ2oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8101.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(8676002)(8936002)(2906002)(9686003)(5660300002)(64756008)(4326008)(122000001)(66556008)(86362001)(76116006)(38100700002)(52536014)(66446008)(66476007)(66946007)(55016002)(83380400001)(71200400001)(316002)(33656002)(7696005)(6506007)(30864003)(45080400002)(6916009)(186003)(26005)(966005)(478600001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?mjnYvDQ2oeHp+BU4z3wRpi39qTYOKHsY2957JwmwCZAWTgPUoN1altdH?=
 =?Windows-1252?Q?RN5KkSlSEX1LwJ0HYD9w/ohTD0iK/gy6iuCGyjR6UiCjuCMJ773OMpPT?=
 =?Windows-1252?Q?b3LKItaaZcd+rMOokAF6pTmb15tiG3SPu/FFjcCt04KiadG9lU1ITFsW?=
 =?Windows-1252?Q?UdMPSmX1YzlgSnnQHDpNr08oUROEHdzUWss1mSf9ZB8RUrf/m5yDjQqf?=
 =?Windows-1252?Q?C85vkKODW78MhXB4T41xhkj2mwDvICcVKbOB/458bAFOSUY9zhZ9gaoH?=
 =?Windows-1252?Q?DE4E0Tqz024re7kXdG/SODPMFUgfyAZoFpSpFTI8UMlSs3h5sNiIAOZ3?=
 =?Windows-1252?Q?9BgPpGP9LCaG7njMozzcjMlVAKX5EaTkoNKLN+RseeOHwvjIr9TeXOTQ?=
 =?Windows-1252?Q?tLmdwdBxmfyZpjYw/5jfnAaF+Z1jXoakA60JJEkgCe/jIpIG0inAAo4l?=
 =?Windows-1252?Q?G1lQ+sZTqf7ea7qbTuGx0IORWyWEmteyntrxLvGj3hrVgH7Siu39Nm+u?=
 =?Windows-1252?Q?SG8qL4haWf+SxcYsbheFiCpjoFlZPjaOyPBvVTuQG+l6wFH6JPWDHVlw?=
 =?Windows-1252?Q?1E4lRvfn73aGA4BlVx5DU1V9UM6jDhb3jMbtaF2JRkctYaJgGkeIz77n?=
 =?Windows-1252?Q?WuHb7Wi7DqtRslIRlUzsuKvCho2pErWyMbIRamcCbqrJ/B+K9dgEYYYp?=
 =?Windows-1252?Q?ymQrUUegYpAB6pwc8I1GVnAu0gvHYTLsg+K8RJMoVLSwrstFRZWqFTgs?=
 =?Windows-1252?Q?dBgTPIvU36EtM71ZWCWeyBnBl/ZPT/abOObnLIg6N3DAIjjK21WIuhIA?=
 =?Windows-1252?Q?sqhuFSHZPGVzLU5NtQUPujC8s6QZYBOvRd1ZamdoJ5WpXiid0bMpxH9k?=
 =?Windows-1252?Q?ws34NCfDLFnrOCnGBMEgwxbtY2wW6mBlOQzzBnq2vYHPL5c0Jf+/jL91?=
 =?Windows-1252?Q?XF4iNj2/bdhEK09HrC0abnDYuJNZ6myFx6wec0iZ8rAAfbsyBuQtP1YG?=
 =?Windows-1252?Q?D19otd6W/UkbXEtpmHUVyCAOS9Qh6YhCAwxJ/Mk6z8VB0BocEvKeeo5F?=
 =?Windows-1252?Q?jMoDkfEVHHuglNE86yMJB7XVT4+M3tYDDrY8RpHSChRzs+ZTOmXIaoYe?=
 =?Windows-1252?Q?y0Qnyl2ZLyscYBQO/gyWwhev1qrARQq8ugB32g76Ytn8GKjuXLos44vH?=
 =?Windows-1252?Q?7d32WWQvilGRz6T6HmVG8fkpST1VIMYE07NVXFYa7CZZzxPnKVbcTU6a?=
 =?Windows-1252?Q?YNa1YuV+B3pc6rXWLemRGcPazSEfiulRsqDBITq9bo8Y0xlWlZRuV7JA?=
 =?Windows-1252?Q?GiafdPT5t+4Fj11tO8Bu5DeWfnaxuLD41hc33mGjEOYiyZUiu77wEp1Y?=
 =?Windows-1252?Q?sMScpRuJoC+oS0zXcRbQvoCeO4NGWrw051w=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3be7752-996a-4149-32a6-08d91c8c3c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 19:11:28.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyrcrpSy4EGhmNlsNeYS7BQkGVtFARlLpOmWp1v9KbMav+Lf9ufSkfaXeXGJW0AoKuGTDQ0onFZu1CDrt75trg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7652
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve and Olga,=0A=
=0A=
We run multiple Kubernetes clusters.=0A=
These clusters are composed of hundreds of Kubernetes nodes.=0A=
Any of these nodes can NFS mount on behalf of the containers running on the=
se nodes.=0A=
We've seen several times in the past few months an NFS mount hang, and then=
 several hundred up to several thousand NFS mounts blocked by this hung NFS=
 mount processes (we have many "testing" workloads that access NFS).=0A=
=0A=
Having several hundred NFS mounts blocked on a node causes the Kubernetes=
=A0node to become unstable and **severely** degrades service.=0A=
=0A=
We did not expect a hung NFS mount to block every other NFS mount, especial=
ly when the other mounts are unrelated and otherwise working properly/healt=
hy.=0A=
=0A=
Can this behavior be changed?=0A=
=0A=
Thanks, Mike=0A=
=0A=
=0A=
=0A=
From: Olga Kornievskaia <aglo@umich.edu>=0A=
Sent: Thursday, May 20, 2021 4:51 PM=0A=
To: Michael Wakabayashi <mwakabayashi@vmware.com>=0A=
Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS=
 mounts on same machine =0A=
=A0=0A=
Hi Mike,=0A=
=0A=
Ok so I can reproduce it but the scenario is not exact what you are=0A=
stating. This is not an unreachable server. It requires that the=0A=
server is reachable but not responsive.=0A=
=0A=
Using iptables I can say drop packets to port 2049 on one machine.=0A=
Then I mount that IP from the client. Your stack requires an "active"=0A=
but not responsive connection. And indeed until the 1st mount times=0A=
out (which it does), no other mounts go through.=0A=
=0A=
But I think I agree with the previous comment that Trond made about=0A=
the need to wait for any clients that are in the middle initializing=0A=
until making any matches with it. I think a match can be made but the=0A=
initializing client can fail the initialization (based on what the=0A=
server returns).=0A=
=0A=
My conclusion is: an unresponsive server will block other mounts but=0A=
only until timeout is reached.=0A=
=0A=
On Thu, May 20, 2021 at 6:43 AM Michael Wakabayashi=0A=
<mwakabayashi@vmware.com> wrote:=0A=
>=0A=
> Hi Olga,=0A=
>=0A=
> If you are able to run privileged Docker containers=0A=
> you might be able to reproduce the issue running=0A=
> the following docker commands.=0A=
>=0A=
> docker pull ubuntu:hirsute-20210514 # ubuntu hirsute is the latest versio=
n of ubuntu=0A=
>=0A=
> # Run this to find the id of the ubuntu image=A0 which is needed in the n=
ext command=0A=
> docker image ls # image id looks like "274cadba4412"=0A=
>=0A=
> # Run the ubuntu container and start a bash shell.=0A=
> # Replace <ubuntu_hirsute_image_id> with your ubuntu image id from the pr=
evious step.=0A=
> docker container run --rm -it --privileged <ubuntu_hirsute_image_id> /bin=
/bash=0A=
>=0A=
>=0A=
> # You should be inside the ubuntu container now and can run these Linux c=
ommands=0A=
> apt-get update # this is needed, otherwise the next command fails=0A=
>=0A=
> # This installs mount.nfs. Answer the two questions about geographic area=
 and city.=0A=
> # Ignore all the debconf error message (readline, dialog, frontend, etc)=
=0A=
> apt install -y nfs-common=0A=
>=0A=
> # execute mount commands=0A=
> mkdir /tmp/mnt1 /tmp/mnt2=0A=
> mount.nfs 1.1.1.1:/ /tmp/mnt1 &=0A=
> mount.nfs <accessible-nfs-host:path> /tmp/mnt2 &=0A=
> jobs=A0 # shows both mounts are hung=0A=
>=0A=
> Thanks, Mike=0A=
>=0A=
>=0A=
> From: Michael Wakabayashi <mwakabayashi@vmware.com>=0A=
> Sent: Thursday, May 20, 2021 2:51 AM=0A=
> To: Olga Kornievskaia <aglo@umich.edu>=0A=
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
> Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other N=
FS mounts on same machine=0A=
>=0A=
> Hi Orna,=0A=
>=0A=
> Thank you for looking.=0A=
>=0A=
> I spent a couple of hours trying to get various=0A=
> SystemTap NFS scripts working but mostly got errors.=0A=
>=0A=
> For example:=0A=
> > root@mikes-ubuntu-21-04:~/src/systemtap-scripts/tracepoints# stap nfs4_=
fsinfo.stp=0A=
> > semantic error: unable to find tracepoint variable '$status' (alternati=
ves: $$parms, $$vars, $task, $$name): identifier '$status' at nfs4_fsinfo.s=
tp:7:11=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 source: terror =3D $status=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ^=0A=
> > Pass 2: analysis failed.=A0 [man error::pass2]=0A=
>=0A=
> If you have any stap scripts that work on Ubuntu=0A=
> that you'd like me to run or have pointers on how=0A=
> to setup my Ubuntu environment to run them=0A=
> successfully, please let me know and I can try again..=0A=
>=0A=
>=0A=
> Here's the call trace for the mount.nfs command=0A=
> mounting the bad NFS server/10.1.1.1:=0A=
>=0A=
> [Thu May 20 08:53:35 2021] task:mount.nfs=A0=A0=A0=A0=A0=A0 state:D stack=
:=A0=A0=A0 0 pid:13903 ppid: 13900 flags:0x00004000=0A=
> [Thu May 20 08:53:35 2021] Call Trace:=0A=
> [Thu May 20 08:53:35 2021]=A0 ? rpc_init_task+0x150/0x150 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 __schedule+0x23d/0x670=0A=
> [Thu May 20 08:53:35 2021]=A0 ? rpc_init_task+0x150/0x150 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 schedule+0x4f/0xc0=0A=
> [Thu May 20 08:53:35 2021]=A0 rpc_wait_bit_killable+0x25/0xb0 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 __wait_on_bit+0x33/0xa0=0A=
> [Thu May 20 08:53:35 2021]=A0 ? call_reserveresult+0xa0/0xa0 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 out_of_line_wait_on_bit+0x8d/0xb0=0A=
> [Thu May 20 08:53:35 2021]=A0 ? var_wake_function+0x30/0x30=0A=
> [Thu May 20 08:53:35 2021]=A0 __rpc_execute+0xd4/0x290 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 rpc_execute+0x5e/0x80 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 rpc_run_task+0x13d/0x180 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 rpc_call_sync+0x51/0xa0 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 rpc_create_xprt+0x177/0x1c0 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 rpc_create+0x11f/0x220 [sunrpc]=0A=
> [Thu May 20 08:53:35 2021]=A0 ? __memcg_kmem_charge+0x7d/0xf0=0A=
> [Thu May 20 08:53:35 2021]=A0 ? _cond_resched+0x1a/0x50=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs_create_rpc_client+0x13a/0x180 [nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_init_client+0x205/0x290 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 ? __fscache_acquire_cookie+0x10a/0x210 [fsc=
ache]=0A=
> [Thu May 20 08:53:35 2021]=A0 ? nfs_fscache_get_client_cookie+0xa9/0x120 =
[nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 ? nfs_match_client+0x37/0x2a0 [nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs_get_client+0x14d/0x190 [nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_set_client+0xd3/0x120 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_init_server+0xf8/0x270 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_create_server+0x58/0xa0 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_try_get_tree+0x3a/0xc0 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs_get_tree+0x38/0x50 [nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 vfs_get_tree+0x2a/0xc0=0A=
> [Thu May 20 08:53:35 2021]=A0 do_new_mount+0x14b/0x1a0=0A=
> [Thu May 20 08:53:35 2021]=A0 path_mount+0x1d4/0x4e0=0A=
> [Thu May 20 08:53:35 2021]=A0 __x64_sys_mount+0x108/0x140=0A=
> [Thu May 20 08:53:35 2021]=A0 do_syscall_64+0x38/0x90=0A=
> [Thu May 20 08:53:35 2021]=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>=0A=
>=0A=
> Here's the call trace for the mount.nfs command=0A=
> mounting an available NFS server/10.188.76.67 (which was=0A=
> blocked by the first mount.nfs command above):=0A=
> [Thu May 20 08:53:35 2021] task:mount.nfs=A0=A0=A0=A0=A0=A0 state:D stack=
:=A0=A0=A0 0 pid:13910 ppid: 13907 flags:0x00004000=0A=
> [Thu May 20 08:53:35 2021] Call Trace:=0A=
> [Thu May 20 08:53:35 2021]=A0 __schedule+0x23d/0x670=0A=
> [Thu May 20 08:53:35 2021]=A0 schedule+0x4f/0xc0=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs_wait_client_init_complete+0x5a/0x90 [nf=
s]=0A=
> [Thu May 20 08:53:35 2021]=A0 ? wait_woken+0x80/0x80=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs_match_client+0x1de/0x2a0 [nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 ? pcpu_block_update_hint_alloc+0xcc/0x2d0=
=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs_get_client+0x62/0x190 [nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_set_client+0xd3/0x120 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_init_server+0xf8/0x270 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_create_server+0x58/0xa0 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs4_try_get_tree+0x3a/0xc0 [nfsv4]=0A=
> [Thu May 20 08:53:35 2021]=A0 nfs_get_tree+0x38/0x50 [nfs]=0A=
> [Thu May 20 08:53:35 2021]=A0 vfs_get_tree+0x2a/0xc0=0A=
> [Thu May 20 08:53:35 2021]=A0 do_new_mount+0x14b/0x1a0=0A=
> [Thu May 20 08:53:35 2021]=A0 path_mount+0x1d4/0x4e0=0A=
> [Thu May 20 08:53:35 2021]=A0 __x64_sys_mount+0x108/0x140=0A=
> [Thu May 20 08:53:35 2021]=A0 do_syscall_64+0x38/0x90=0A=
> [Thu May 20 08:53:35 2021]=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>=0A=
> I've pasted the entire dmesg output here: https://nam04.safelinks.protect=
ion.outlook.com/?url=3Dhttps%3A%2F%2Fpastebin.com%2F90QJyAL9&amp;data=3D04%=
7C01%7Cmwakabayashi%40vmware.com%7C64c924b4b7054405307108d91bea44fe%7Cb3913=
8ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637571515274079272%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;sdata=3DIRCXJjIXojFm1xaFuSy11LW0QFbMN04C%2BjzTwI3FCVM%3D&amp;reser=
ved=3D0=0A=
>=0A=
>=0A=
> This is the command I ran to mount an unreachable NFS server:=0A=
> date; time strace mount.nfs 10.1.1.1:/nopath /tmp/mnt.dead; date=0A=
> The strace log: https://nam04.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fpastebin.com%2F5yVhm77u&amp;data=3D04%7C01%7Cmwakabayashi%40vmwa=
re.com%7C64c924b4b7054405307108d91bea44fe%7Cb39138ca3cee4b4aa4d6cd83d9dd62f=
0%7C0%7C0%7C637571515274079272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNMI42XLcC=
ZiECy5VUAQ7VyAWepTVLX22%2BBnBWaDOD4s%3D&amp;reserved=3D0=0A=
>=0A=
> This is the command I ran to mount the available NFS server:=0A=
> date; time strace mount.nfs 10.188.76.67:/ /tmp/mnt.alive ; date=0A=
> The strace log: https://nam04.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fpastebin.com%2FkTimQ6vH&amp;data=3D04%7C01%7Cmwakabayashi%40vmwa=
re.com%7C64c924b4b7054405307108d91bea44fe%7Cb39138ca3cee4b4aa4d6cd83d9dd62f=
0%7C0%7C0%7C637571515274089229%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJy7dGBjQr=
ViwXNJFYowg7x%2BLJZjxf6PUwvEQV7Ql5JM%3D&amp;reserved=3D0=0A=
>=0A=
> The procedure:=0A=
> - run dmesg -C to clear dmesg logs=0A=
> - run mount.nfs on 10.1.1.1 (this IP address is down/not responding to pi=
ng) which hung=0A=
> - run mount.nfs on 10.188.76.67=A0 which also hung=0A=
> - "echo t > /proc/sysrq-trigger" to dump the call traces for hung process=
es=0A=
> - dmesg -T > dmesg.log to save the dmesg logs=0A=
> - control-Z the mount.nfs command to 10.1.1.1=0A=
> - "kill -9 %1" in the terminal to kill the mount.nfs to 10.1.1.1=0A=
> - mount.nfs to 10.188.76.67 immediately mounts successfully=0A=
>=A0=A0 after the first mount is killed (we can see this by the timestamp i=
n the logs files)=0A=
>=0A=
>=0A=
> Thanks, Mike=0A=
>=0A=
>=0A=
>=0A=
> From: Olga Kornievskaia <aglo@umich.edu>=0A=
> Sent: Wednesday, May 19, 2021 12:15 PM=0A=
> To: Michael Wakabayashi <mwakabayashi@vmware.com>=0A=
> Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
> Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other N=
FS mounts on same machine=0A=
>=0A=
> On Sun, May 16, 2021 at 11:18 PM Michael Wakabayashi=0A=
> <mwakabayashi@vmware.com> wrote:=0A=
> >=0A=
> > Hi,=0A=
> >=0A=
> > We're seeing what looks like an NFSv4 issue.=0A=
> >=0A=
> > Mounting an NFS server that is down (ping to this NFS server's IP addre=
ss does not respond) will block _all_ other NFS mount attempts even if the =
NFS servers are available and working properly (these subsequent mounts han=
g).=0A=
> >=0A=
> > If I kill the NFS mount process that's trying to mount the dead NFS ser=
ver, the NFS mounts that were blocked will immediately unblock and mount su=
ccessfully, which suggests the first mount command is blocking the other mo=
unt commands.=0A=
> >=0A=
> >=0A=
> > I verified this behavior using a newly built mount.nfs command from the=
 recent nfs-utils 2.5.3 package installed on a recent version of Ubuntu Clo=
ud Image 21.04:=0A=
> > * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fs=
ourceforge.net%2Fprojects%2Fnfs%2Ffiles%2Fnfs-utils%2F2.5.3%2F&amp;data=3D0=
4%7C01%7Cmwakabayashi%40vmware.com%7C64c924b4b7054405307108d91bea44fe%7Cb39=
138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637571515274089229%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;sdata=3D9U%2FiCu0sH6gKkMk8Jq4nM6B5Mwhx7LYYb8%2FtvtezoCY%3D&amp;r=
eserved=3D0=0A=
> > * https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fc=
loud-images.ubuntu.com%2Freleases%2Fhirsute%2Frelease-20210513%2Fubuntu-21.=
04-server-cloudimg-amd64.ova&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com=
%7C64c924b4b7054405307108d91bea44fe%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%=
7C0%7C637571515274089229%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D58zX0jg4xJrwxb%=
2BDtw5uzyOxhEvdxR25bYka65XNdyI%3D&amp;reserved=3D0=0A=
> >=0A=
> >=0A=
> > The reason this looks like it is specific to NFSv4 is from the followin=
g output showing "vers=3D4.2":=0A=
> > > $ strace /sbin/mount.nfs <unreachable-IP-address>:/path /tmp/mnt=0A=
> > > [ ... cut ... ]=0A=
> > > mount("<unreadhable-IP-address>:/path", "/tmp/mnt", "nfs", 0, "vers=
=3D4.2,addr=3D<unreachable-IP-address>,clien"...^C^Z=0A=
> >=0A=
> > Also, if I try the same mount.nfs commands but specifying NFSv3, the mo=
unt to the dead NFS server hangs, but the mounts to the operational NFS ser=
vers do not block and mount successfully; this bug doesn't happen when usin=
g NFSv3.=0A=
> >=0A=
> >=0A=
> > We reported this issue under util-linux here:=0A=
> > https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2Fkarelzak%2Futil-linux%2Fissues%2F1309&amp;data=3D04%7C01%7Cmwakab=
ayashi%40vmware.com%7C64c924b4b7054405307108d91bea44fe%7Cb39138ca3cee4b4aa4=
d6cd83d9dd62f0%7C0%7C0%7C637571515274089229%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DvzhKPE8kaesr1jGRCghvn%2Be84%2FUXXXj7CbivwIrpLUE%3D&amp;reserved=3D0=0A=
> > [mounting nfs server which is down blocks all other nfs mounts on same =
machine #1309]=0A=
> >=0A=
> > I also found an older bug on this mailing list that had similar symptom=
s (but could not tell if it was the same problem or not):=0A=
> > https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
chwork.kernel.org%2Fproject%2Flinux-nfs%2Fpatch%2F87vaori26c.fsf%40notabene=
.neil.brown.name%2F&amp;data=3D04%7C01%7Cmwakabayashi%40vmware.com%7C64c924=
b4b7054405307108d91bea44fe%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637=
571515274089229%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI=
iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D4kr9PxATC2Sv74njqJcajMGt=
erOIIKCvtrZQHgGkqPE%3D&amp;reserved=3D0=0A=
> > [[PATCH/RFC] NFSv4: don't let hanging mounts block other mounts]=0A=
> >=0A=
> > Thanks, Mike=0A=
>=0A=
> Hi Mike,=0A=
>=0A=
> This is not a helpful reply but I was curious if I could reproduce=0A=
> your issue but was not successful. I'm able to initiate a mount to an=0A=
> unreachable-IP-address which hangs and then do another mount to an=0A=
> existing server without issues. Ubuntu 21.04 seems to be 5.11 based so=0A=
> I tried upstream 5.11 and I tried the latest upstream nfs-utils=0A=
> (instead of what my distro has which was an older version).=0A=
>=0A=
> To debug, perhaps get an output of the nfs4 and sunrpc tracepoints.=0A=
> Or also get output from dmesg after doing =93echo t >=0A=
> /proc/sysrq-trigger=94 to see where the mounts are hanging.=
