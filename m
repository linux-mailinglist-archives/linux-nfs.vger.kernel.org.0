Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA550A436
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Apr 2022 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351963AbiDUPdN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 21 Apr 2022 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390112AbiDUPdM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Apr 2022 11:33:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075063.outbound.protection.outlook.com [40.92.75.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435764C8
        for <linux-nfs@vger.kernel.org>; Thu, 21 Apr 2022 08:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbKxBH58RJP1lP620iQCtcxlWTXk6C4ybMTSm4bDEc/PmJe0rDQl8FZAD91YWtxL5jljwddEqgUPI3dgpW+R3EkTednVTBdNyS1yS5BkXjbGWlEm3PMlHApGX4hD6EbRCmHvZe++TeSXPNvshKcg4RqK7MATZzXEgEeexUTGOWZQI+ytfJdwp16bNpg9cdWy2V1c0B/EXdkqDgcE9lsPYk/ZYS84BTCDL8jCiGkOk0qLCb28AmGfERmfyk4ykuZl4PlqMNZBsx4y/BRYTyQ7/nzuLnCJcK3fCLMoWE0HvGBxCUlPos8mggmGN2e4kS3aZ5usTAHSnEuM91YJrl+zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2pw1egNTpxGxwui5kZYd7gpQosgcCKpxm8RNThhG2o=;
 b=DAiaq2maAGhgn5JtzA1fz0MNXY7QV2r+drumerv4ZWZ42thg7N8f1VQnun35UZAZNy+WLynA0CnodKv0uogdBJAdxn3ty8+5Nb2oHkqY5qsoHWrAcFArF6xLvNEHSIHkOR5T5J2eONnUTzh1ZXfeu/uwpeR+0b7MuDJznTYEe6HfSgrK2ZOqEZmwekO1y3dvheAsthZ9tFxx5AbOIWraSE6EbQQNxuVK7E2J3sfodq0xGP37VJL7QPrbsPxY9qzyEIqTeTJLlpTEd8WnfbzL6cV4uVGOLJKYxxHhaqDPM9pFimRkSn/JqGq67VQnTx0+FKW5HUmnYFIiovJ0+J+aHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by AM8P191MB1202.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 15:30:19 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%5]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 15:30:19 +0000
From:   "crispyduck@outlook.at" <crispyduck@outlook.at>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: AW: Problems with NFS4.1 on ESXi 
Thread-Topic: Problems with NFS4.1 on ESXi 
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6A==
Date:   Thu, 21 Apr 2022 15:30:19 +0000
Message-ID: <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
In-Reply-To: <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7abfc342-d5e7-dd76-94ab-c7a221e957fb
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [1FWpz/R8xb1q4cRBsNB9DnLvqisYOg65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b6d780e-414e-4a61-b52a-08da23abd7e8
x-ms-traffictypediagnostic: AM8P191MB1202:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9gUWFTfBTfWBnTM64PDNp66aOKdZsKu8zwCPZqpqWkCP4lJkbtVVqbnCPe4oersiEOJuoy72R/sWUtIZIHELGVkzIHNK203NBb8Cxtzg/rKkmyG4Gh+aUiMj7S2V1ZkW3rCY19/c1+UzObLi4q18qyFDwEaRe615BuaDKf39vYrctuoojsjnn+SXIK7HNTjL8CV9T2nbZwJ0t1loO4/Qmr6PaJ8sMItbh+eaQDv7OoMEnXxX5KLe7nRZUDHaE5UTlDyuvrI/sGPDo8Njlr+OpeIB1yD6nuYkCFTOTYLxBJfzwM+pxKS6whUtnbU/SKMJVM5zNCQI2aQhDogW55+ue/Vm+rf+20aOi2c5vCWM0tcnfISSkG2H3YW/+mjW5YNphHoT5fBcT3fAUIIWSibUeoilHvVAqu4KqrQKpmCtdt/umY1d2FhjKjlHBx0QKj335GIkfxYABlfa/5K+kUZ9+jfYwtv4a6ntu17+w6snfU1x5rNT/68zYeuksxZSVETjDfTGVg/spcDOSqggrgaUrrwXP4cP3L0GTNG1yBlH1q7ultqtjMezOaC17n3lxp0PCrgrFMnTIB7kRKQhBPhd77dqp6Ico4aFUu63malkJ+a5oX3T/+G5Fzwps6Lf6xF
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JH/xgGJ81I0V16iywJrqakgZmCoFJ/I1Ob4v8j9CCAnpLZhZNJ0bEoIGZf?=
 =?iso-8859-1?Q?QZMLePS7KsuaVPX8LieMgse6lC/+XhpMUmmZYT+wtv1dXbIDaGLeQK9rOH?=
 =?iso-8859-1?Q?zSvUF+1Uf8o6vaaBcRwcWXKaiE8W0hlBkL98rFvtVdkqR7kWCTCrlTVpLt?=
 =?iso-8859-1?Q?YFIpejat1sBgzIFhRmJNIuXWMYxNIqrhgXh1DKiqnVfYkwNihhIRdF9lgZ?=
 =?iso-8859-1?Q?NLn6MABkWvqgIjJL4l3Aph4UMJEIkFi0HdhfzZHA5t11UXWh/qzvoXasVc?=
 =?iso-8859-1?Q?meeFWA9ax0M5vwBkoAoft1hTAn7YtgWxEe7Pj/XjDFhdZYZy3ArPUP3b+P?=
 =?iso-8859-1?Q?xPb4wDEsSdhUGKjBh8PsHSmLBRt/8NnMyGsRjHO5ZZpGLPWpL4dBkKTuBy?=
 =?iso-8859-1?Q?fOafsztVDaKjqF39dtFG9twCnTdV3nlcAGwhrG49YeK79fibZ9gFd435+O?=
 =?iso-8859-1?Q?buSxvKRpyAxiAB34AduITNoxslsNAwcHGlH3eX8Ijt01GYyWAV27n7x7/L?=
 =?iso-8859-1?Q?dDtx5BI0plAvQXg6QkDRTDZAAzowqm6gzpALeLxfjx8V74edLgTw+eQIbf?=
 =?iso-8859-1?Q?yIMNaKWreGVC7NCPkyMOv1CVS7boFO+WrCGTOsEhIx5zs1u+TFHEHkEpv4?=
 =?iso-8859-1?Q?t5E9FUWGc8WCLRucQD3vmLHZdlKn37oucI+cwz9PyChrfhgr3a7f3JPnQj?=
 =?iso-8859-1?Q?IVTa8r9OQwiUGUpQFlF1WPX533pF5meWJSPsjGniGIxS1xklddbWBC4gt+?=
 =?iso-8859-1?Q?8lMdXOuIEogKq/dQ8ktG9+ODVP06UIkXUWuPmAD18AwhNsv0d9KTKdZCEY?=
 =?iso-8859-1?Q?ACw37OtVtVzi0yx0QEs3BW3N+bi9Yq1/JZw94jCO4cD4PAVlp+rY74ZJdj?=
 =?iso-8859-1?Q?3xunGOk9HTX0I3pRB12sjUkhiLq8pBqMIHFw7DL/Z0OmJ+XAOPk0ZoXE/S?=
 =?iso-8859-1?Q?RBvchviNn4f3bYyjjqHDX/BooEqUrij9Z16ylHaeoScy0qB5N8hXYwcQNm?=
 =?iso-8859-1?Q?Ufp/TdtHzki3kzgTy898E6Ih5rqrsEy+uYupca+vmiZENZCqXmrQmsDuyj?=
 =?iso-8859-1?Q?8Du18BRIUwtsiA6jjXP8ifbyuXTF4sJvQRlgkGZPDzgZBw8PQOfc7HYyLJ?=
 =?iso-8859-1?Q?SPuV4RkL8GfSPmOeqkgwT/FKTp6sNy6vUv/viBZy4e5z+dzg8hIGWRumoB?=
 =?iso-8859-1?Q?i714Vfixjy+lfKaSo0VC0wdAB7jtDRt4bPptG8f/4B4cBkvabrGyfIBQ6I?=
 =?iso-8859-1?Q?PDkNttvS4HCUMV38bA/pESk97b17v4w3CPvOLl3pL5uTm4dkuXgBn8alw6?=
 =?iso-8859-1?Q?dGT2V9OTTg+KTu06BMlyr6Ftr+VUe7icNCcxmRWhUGSDCz6ry8D0qL00ut?=
 =?iso-8859-1?Q?a67XSIP+khQ5LILAwhqEfiUjofcf7QbtaePZN1FRD/r+n8WoM4/A6oWFzk?=
 =?iso-8859-1?Q?i+m5TAIFVhaMlDMw5x2RmivrBG4qXhCTWozolMV7EZsYGvhpD/nWh9B4e5?=
 =?iso-8859-1?Q?Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6d780e-414e-4a61-b52a-08da23abd7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 15:30:19.4453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P191MB1202
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck!

Thanks. From VMWare side nobody will help here as this is not supported. They support NFS4.1, but officially only from some storage vendors.

I had it running in the past on FreeBSD, where I also some problems in the beginning  (RECLAIM_COMPLETE) and Rick Macklem helped to figure out the problem and fixed it with some patches that should now be part of FreeBSD.

I plan to use it with ZFS, but also tested it on ext4, with exact same behavior. 

NFS3 works fine, NFS4.1 seems to work fine, except the described problems.

The reason for NFS4.1 is session trunking, which gives really awesome speeds when using multiple NICs/subnets. Comparable to ISCSI.
ANFS4.1 based storage for ESXi and other Hypervisors.

The test is also done without session trunking.

This needs NFS expertise, no idea where else i could ask to have a look on the traces.

Br,
Andi






Von: Chuck Lever III <chuck.lever@oracle.com>
Gesendet: Donnerstag, 21. April 2022 16:58
An: Andreas Nagy <crispyduck@outlook.at>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Betreff: Re: Problems with NFS4.1 on ESXi 
 
Hi Andreas-

> On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> wrote:
> 
> Hi,
> 
> I hope this mailing list is the right place to discuss some problems with nfs4.1.

Well, yes and no. This is an upstream developer mailing list,
not really for user support.

You seem to be asking about products that are currently supported,
and I'm not sure if the Debian kernel is stock upstream 5.13 or
something else. ZFS is not an upstream Linux filesystem and the
ESXi NFS client is something we have little to no experience with.

I recommend contacting the support desk for your products. If
they find a specific problem with the Linux NFS server's
implementation of the NFSv4.1 protocol, then come back here.


> Switching from FreeBSD host as NFS server to a Proxmox environment also serving NFS I see some strange issues in combination with VMWare ESXi.
> 
> After first thinking it works fine, I started to realize that there are problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).
> 
> Importing ESXi OVF VM Templates fails nearly every time with a ESXi error message "postNFCData failed: Not Found". With NFS3 it is working fine.
> 
> NFS server is running on a Proxmox host:
> 
>  root@sepp-sto-01:~# hostnamectl
>  Static hostname: sepp-sto-01
>  Icon name: computer-server
>  Chassis: server
>  Machine ID: 028da2386e514db19a3793d876fadf12
>  Boot ID: c5130c8524c64bc38994f6cdd170d9fd
>  Operating System: Debian GNU/Linux 11 (bullseye)
>  Kernel: Linux 5.13.19-4-pve
>  Architecture: x86-64
> 
> 
> File system is ZFS, but also tried it with others and it is the same behaivour.
> 
> 
> ESXi version 7.2U3
> 
> ESXi vmkernel.log:
> 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompliance:209: [nsx@6876 comp="nsx-esx" subcomp="vswitch"]client vmk1 requested promiscuous mode on port 0x4000010, disallowed by vswitch policy
> 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)World: 12075: VC opID esxui-d6ab-f678 maps to vmkernel opID 936118c3
> 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed: Stale file handle
> 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: Stale file handle
> 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported
> 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path evaluation for device mpx.vmhba32:C0:T0:L0
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)World: 12075: VC opID esxui-6787-f694 maps to vmkernel opID 9529ace7
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> 
> tcpdump taken on the esxi with filter on the nfs server ip is attached here:
> https://easyupload.io/xvtpt1
> 
> I tried to analyze, but have no idea what exactly the problem is. Maybe it is some issue with the VMWare implementation? 
> Would be nice if someone with better NFS knowledge could have a look on the traces.
> 
> Best regards,
> cd

--
Chuck Lever


