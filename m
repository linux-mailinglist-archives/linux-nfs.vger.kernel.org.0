Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92250A846
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Apr 2022 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391402AbiDUSot convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 21 Apr 2022 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388270AbiDUSor (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Apr 2022 14:44:47 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-oln040092064027.outbound.protection.outlook.com [40.92.64.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4374BFC2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Apr 2022 11:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Pt7dvoKXxIvmw4wqqJ04A0CLN+NL8ta47CIsGkO3WtYb2WHHHRALdJP+KkgP0dDKC4EMRSBZ5ZdfhzGhSpN91h/OLFmfzSv9pXJfP75Cuap2HhljKRzM6gO23zs7ZBaFCifLg8nzymQseUO+i5IqGLgKFTbyxPIdMq5M8BGxt2IaQWrF3n91vVV/dc70hR5rGhRSttJBj29CJgmfpABSq5r8zi6wux56Ov2UU8dNHo3HuyNyh7n5ilSNgDPDPvM+hWAaOvMF+VWrNiazJ8HLShstNyGMyvB29XLpeSm7fscJNw5TYkWg+ooB3hbiY0DByzXdREIe4DzNvW+s0AJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekYzU8TW437vUoM3pj6yBcS7t+y/ixG5oysiRRaDfj0=;
 b=JTdk21WxcRoJxag4gFcf4Bthqpf4S7EOkX7dtAEYMAHCEIhIi7hrf07/HxwtR7rBlYChSIE2Eo94bI/67rI9c5uIUcyC4IJCe1YDGZV3qJtrUEvHH3noGByEwp6uVePSCBNCwTWWYbsSZH1VCOZejO3gDK2rGKzfxBwvKgGfCm88ttIs3mY3+1N2f67281uftiC5fVZOrW/2WmqXrfS5uLdZVg7EjiBljwLkSiQf6Hu3YF1IESk8ouViqWOlF5m8WADGYp72lfMtYvZNTOFj6RgdOB3tL8O9X+kICJKMtE1Hp8nPN52RiB303uzVz3hchCn12lxDrcEBXho8Y9yc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by AM0P191MB0562.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:156::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 18:41:54 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%5]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 18:41:54 +0000
From:   "crispyduck@outlook.at" <crispyduck@outlook.at>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAL9LeAAAMkRQ==
Date:   Thu, 21 Apr 2022 18:41:54 +0000
Message-ID: <AM9P191MB166507545B0F931A6CA92D2D8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org>
 <AM9P191MB16654F5B7541CD1E489D75608EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB16654F5B7541CD1E489D75608EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 298b67c4-5b2a-607d-566a-d669d3958646
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [5gq52Ye7ajlkL1Y68vG67K7kRCiIM8+P]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 083b312a-78f1-47d4-3f5b-08da23c69b4a
x-ms-traffictypediagnostic: AM0P191MB0562:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zf2Hxd7j2WQUIVganVcA/UkzVQI9D/TkgoSMqIEVjcoIOM7KUZTcJwr4NXPzSvS6a9mEfMpGgvFZzNXL+2ktJKG+i8WnuNfhybqfBLXroFHEMJffsW6iyobD5p+YaO2kz8Mw4x9gZPINmFN1Z4J4s/Ej2zCMrXFK3BVQxN79H70gFAZDDgMaajMUP9oHK3n2OQ+VZcNNaU501dzt7+fy7yn/d8IRvlP3CyHtQjvum8df3K5EzaGYCu1S3dyta7uvI1punjl7+zT92jhdbQC/LGG+pI4Cnrb7OHi1cSchFO4JHmDk3eYJdSoV7YX4yTdCYgP2c4Q+qan8YYWPlwroCqu1yA3P3+uaRRRZSRMaIXfgqEzrJBDWPRLMpmzlNO4L+DnQCi6w5dNlM9OCcZwHoLH5II+a5TKzfMJDHgoL45jN+2DbBMfVoS+vGi5O+wb3sJ6KXiwqZQI3jhpaviwiFnpTm4PCVBYjyH/M+PhrnLGIikJkIZTPDfzLHZKiwIx6xZ48R+LHPu/or/6NmTvvrH1dKuw0w+Xn2m2w8/TIXmH411yP3qEEAgpUz3Y6J9NWH7nifzGjxoRQmgu7V0ZbwyLqb+l73r8ESWuQMY7jVzeTNxLRevMyVDQvs2YzwQ0w
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4Xr1CdCj++ngEOdgkcJU2JT+4vO+3d46M5R0GRGehmQsUApEAENMAYkY70?=
 =?iso-8859-1?Q?ziYND3dRWfvrkGfNB/0LTQiJljIepMqD/NMsXZqgqtnS6w/ZUVNP3gvx/e?=
 =?iso-8859-1?Q?Fs4GYZU2RyBhcDplf+nyw8e5jebPDKVWIZvQUM3NaqXOixK0QFcn4Wk7j9?=
 =?iso-8859-1?Q?0w9LGw2GSlAZAcSGaeli8uX0Osr66VxU/ucSvtR4YGn4pjV4P2yl26qXgv?=
 =?iso-8859-1?Q?VAJzjZeAc9FT2TSKtfskSyXUSF1FiqrQ+d21itBUj0sqE0iipfcvE92PKX?=
 =?iso-8859-1?Q?j09PWoz7E4FZ8rAKJKZvVULbjiCnRYgnzhKRGliMSWyt8rcBcg6C5pZU6I?=
 =?iso-8859-1?Q?jMPGxjTYs624uNEJ+BvWmmbYcBox/JMdzBG2clfPgTsMvBgHlZVSmk31ry?=
 =?iso-8859-1?Q?eGzrOGbU2NEXowGjGEYcq4mcFmMQEmn91NdGNL3axWcryW8cckbPs2yZ73?=
 =?iso-8859-1?Q?+o6PDhicLt8OC2d6jOxHw71CvVoIvu9qZKHH4cDAKL4q1NsGv3wAMtTObF?=
 =?iso-8859-1?Q?rz43LROwTqS2iHTnLSxoGMPIsivofCwVYAnyCSuOBex4YLm2oL91bdxa/R?=
 =?iso-8859-1?Q?Bb0UxFEKCFhCp14JhvlmXqmUpfJWHoNx4pjHkhYSsZliHfJa9gJj4WTP6c?=
 =?iso-8859-1?Q?DMUTVAZ8aOdLuU56h48bDtdzLvCXZ5fhEYxS2Io+1HGXDstt6sRfe9vLXg?=
 =?iso-8859-1?Q?NfJq9Obby6Xp6LiDekcLKzHlMgep9IgXHonQp99rtL9oN4MAZEG7HO8LLu?=
 =?iso-8859-1?Q?qdwGEyvTcQCSC+LZhNjm4MZ47JNyOeekKfGRwZEFkZrlEBICmIvDkWRC2s?=
 =?iso-8859-1?Q?QE+TBFXwp0acg5foyJK0YBoHnqZY4tChq3VaD+2sGxoKMEwqA0pf/YKaC/?=
 =?iso-8859-1?Q?Sgqj2h/pR492ZRoirimMCbUAYdGXr5bIMuWiFXPQCb4+eEkaVtT+bDSr2X?=
 =?iso-8859-1?Q?GEdIS/38Z5m5mGmVANhUSSHmarEjamt1e55uu/XSXgCML6D/6LaQv2l1Dr?=
 =?iso-8859-1?Q?ogflFybBo6aNL5jRW1bCqAM42erPHoOOYFb5WDDEDeFLOhm1/IQilf7IBB?=
 =?iso-8859-1?Q?c56T6wOSDZdVG9U7IWrPOIAoEt4fkoGGYDlDt6gPUA76g8mZR+PpiEpW2g?=
 =?iso-8859-1?Q?F7KMwCypK27m+B8HlE82u7VWecd0e3sVdjNuuJdSR6IUJnwhM5BQ17d6XY?=
 =?iso-8859-1?Q?SuFaBF4ZBHLj4BuB3HH83Ejg/Fe7okAGMWzwMxe8ntD0cYwbY6NCeqgM5N?=
 =?iso-8859-1?Q?ueVUSDpZBI4WN0Ebh/vHcrH3JTJhkR+fpk9r71TcF32hEb6DijFm9bEJVg?=
 =?iso-8859-1?Q?npHQ2IMKY9pPfVYVVhzv/QH6KUAOUePyaplxSabXrFvj9NJaeBdNZ3eEjd?=
 =?iso-8859-1?Q?LSmepH6ZlA+n1b0DSeF+XGa97Pm7sSkVhvUMHf34PfYOM0365OjAsySBwL?=
 =?iso-8859-1?Q?gVB0W73kVYvpXQpT7b9M/XxMvVfRmfWTvts0r4LIqrCx+yMJCGI+aX8qH8?=
 =?iso-8859-1?Q?Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 083b312a-78f1-47d4-3f5b-08da23c69b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 18:41:54.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P191MB0562
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I can do traces,... as needed if someone is interested and would investigate deeper.
I can read traces, but my knowledge here and on NFS is very limited.

Br,
Andi


From: J. Bruce Fields <bfields@fieldses.org>
Sent: Thursday, April 21, 2022 6:40:49 PM
To: crispyduck@outlook.at <crispyduck@outlook.at>
Cc: Chuck Lever III <chuck.lever@oracle.com>; Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi 
 
On Thu, Apr 21, 2022 at 03:30:19PM +0000, crispyduck@outlook.at wrote:
> Thanks. From VMWare side nobody will help here as this is not supported. They support NFS4.1, but officially only from some storage vendors.
> 
> I had it running in the past on FreeBSD, where I also some problems in the beginning  (RECLAIM_COMPLETE) and Rick Macklem helped to figure out the problem and fixed it with some patches that should now be part of FreeBSD.
> 
> I plan to use it with ZFS, but also tested it on ext4, with exact same behavior. 
> 
> NFS3 works fine, NFS4.1 seems to work fine, except the described problems.
> 
> The reason for NFS4.1 is session trunking, which gives really awesome speeds when using multiple NICs/subnets. Comparable to ISCSI.
> ANFS4.1 based storage for ESXi and other Hypervisors.
> 
> The test is also done without session trunking.
> 
> This needs NFS expertise, no idea where else i could ask to have a look on the traces.

Stale filehandles aren't normal, and suggest some bug or
misconfiguration on the server side, either in NFS or the exported
filesystem.  Figuring out more than that would require more
investigation.

--b.

> 
> Br,
> Andi
> 
> 
> 
> 
> 
> 
> Von: Chuck Lever III <chuck.lever@oracle.com>
> Gesendet: Donnerstag, 21. April 2022 16:58
> An: Andreas Nagy <crispyduck@outlook.at>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Betreff: Re: Problems with NFS4.1 on ESXi 
>  
> Hi Andreas-
> 
> > On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> wrote:
> > 
> > Hi,
> > 
> > I hope this mailing list is the right place to discuss some problems with nfs4.1.
> 
> Well, yes and no. This is an upstream developer mailing list,
> not really for user support.
> 
> You seem to be asking about products that are currently supported,
> and I'm not sure if the Debian kernel is stock upstream 5.13 or
> something else. ZFS is not an upstream Linux filesystem and the
> ESXi NFS client is something we have little to no experience with.
> 
> I recommend contacting the support desk for your products. If
> they find a specific problem with the Linux NFS server's
> implementation of the NFSv4.1 protocol, then come back here.
> 
> 
> > Switching from FreeBSD host as NFS server to a Proxmox environment also serving NFS I see some strange issues in combination with VMWare ESXi.
> > 
> > After first thinking it works fine, I started to realize that there are problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).
> > 
> > Importing ESXi OVF VM Templates fails nearly every time with a ESXi error message "postNFCData failed: Not Found". With NFS3 it is working fine.
> > 
> > NFS server is running on a Proxmox host:
> > 
> >  root@sepp-sto-01:~# hostnamectl
> >  Static hostname: sepp-sto-01
> >  Icon name: computer-server
> >  Chassis: server
> >  Machine ID: 028da2386e514db19a3793d876fadf12
> >  Boot ID: c5130c8524c64bc38994f6cdd170d9fd
> >  Operating System: Debian GNU/Linux 11 (bullseye)
> >  Kernel: Linux 5.13.19-4-pve
> >  Architecture: x86-64
> > 
> > 
> > File system is ZFS, but also tried it with others and it is the same behaivour.
> > 
> > 
> > ESXi version 7.2U3
> > 
> > ESXi vmkernel.log:
> > 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompliance:209: [nsx@6876 comp="nsx-esx" subcomp="vswitch"]client vmk1 requested promiscuous mode on port 0x4000010, disallowed by vswitch policy
> > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)World: 12075: VC opID esxui-d6ab-f678 maps to vmkernel opID 936118c3
> > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed: Stale file handle
> > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: Stale file handle
> > 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported
> > 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path evaluation for device mpx.vmhba32:C0:T0:L0
> > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)World: 12075: VC opID esxui-6787-f694 maps to vmkernel opID 9529ace7
> > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > 
> > tcpdump taken on the esxi with filter on the nfs server ip is attached here:
> > https://easyupload.io/xvtpt1
> > 
> > I tried to analyze, but have no idea what exactly the problem is. Maybe it is some issue with the VMWare implementation? 
> > Would be nice if someone with better NFS knowledge could have a look on the traces.
> > 
> > Best regards,
> > cd
> 
> --
> Chuck Lever
> 
