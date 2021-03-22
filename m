Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE3344E6A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 19:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCVSW4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 14:22:56 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:27315
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229868AbhCVSWe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Mar 2021 14:22:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl8SpadKlNlu/25ZH+UcXH+G++eq+drSyvBebrRQNTn4dR6nLfwooMDxENarvwBC3J0U1G0lnfBzo99kPxvzvjsL3rk50QBhHA0o1uhzOuaIXeGcX8XzDeUI6Q3pMphL/eEvhUtodtw5OJxzucdiSEQUGGu/CTMKL2K5R6Vu/kdvJQrrDsRtxxiMSuBlbZ+EQWv1GaxzYMe1MNZse277V7q4cHd90KvvLuqjjuBgk1opjWFyMH9+8Qj4rEnyFwbvAQJ0IRbkrT1ysVZVE78SgNjwbxbtumQ8DnhVzo8l67mNynOBtteT6y1Eqmt7VvewDLNjKPHFloq99k8FvviuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVKqBNaWrHuLhA8e/1O6o5ianaZwlQ9zaJgHZ0PV6w0=;
 b=Lt45Ghwn3X9ijdhSZz0Md7fA1IKTqv8E3GYbz8mHOLTWl6fBDBV6JAt1+ULm8G4logF6MdNSNPrDR6k5IJ76foRSL9dlRzjG7yd3kPTzBJo4uGvU5bR6Tfrua4tAcH4bRKioZVO8t/bMiUnQxFuN3PWReD/6+kEs1CRCckGUkka8xIUgklM6bGiwLHd6L7c8IvxfVUCTpth27QIJrBsXeckjVyekmvz2LUyq0tksrKb6PFz9mQA4IKYa0o2Kjle0iqRijK2XgSpsq3Kih0J31n/CTBeNE1hpJLkTALj4QyVJQkUfN9LSkXPQLp6C1UeCrxVZrqy/RJ745eMx1A7fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spinetix.com; dmarc=pass action=none header.from=spinetix.com;
 dkim=pass header.d=spinetix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spinetix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVKqBNaWrHuLhA8e/1O6o5ianaZwlQ9zaJgHZ0PV6w0=;
 b=a+Ix33aoKh6yo/IXoVmp++0HrrE1asoI8fiSt4r6Ltrvai9/6PuypBdBznToj/W5wA4Wj8d27gjbNENMzsBm/C4zrX1+gBReTBG7Ab+z4VIzeYYXB7qVFllYHvwou3yXUZC3f6d2nMkqtbUNF8qWk96/8czQA2u43j8N8rC2ebQ=
Received: from DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:e::19) by DBAPR01MB6838.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:190::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:22:29 +0000
Received: from DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
 ([fe80::a979:e5e4:3b20:ba6b]) by
 DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
 ([fe80::a979:e5e4:3b20:ba6b%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:22:29 +0000
From:   Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: symlinkat() behavior with NFS depends on dentry being on cache or
 not
Thread-Topic: symlinkat() behavior with NFS depends on dentry being on cache
 or not
Thread-Index: AdcPQlxlz0o0+PGxRoKy1LGtL+Fk7AQBWUaw
Date:   Mon, 22 Mar 2021 18:22:28 +0000
Message-ID: <DB6PR0102MB2630FFEE12410EC97457114488659@DB6PR0102MB2630.eurprd01.prod.exchangelabs.com>
References: <DB6PR0102MB2630902B2569060CD5E802EA88999@DB6PR0102MB2630.eurprd01.prod.exchangelabs.com>
In-Reply-To: <DB6PR0102MB2630902B2569060CD5E802EA88999@DB6PR0102MB2630.eurprd01.prod.exchangelabs.com>
Accept-Language: en-GB, fr-CH, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=spinetix.com;
x-originating-ip: [178.198.240.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b4db7a-0e12-4a49-7281-08d8ed5f73b7
x-ms-traffictypediagnostic: DBAPR01MB6838:
x-microsoft-antispam-prvs: <DBAPR01MB68382AE6F1EC743FB01B09ED88659@DBAPR01MB6838.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohxpqP0bd91ZKmvI5F0N7KsFLc3LdECcKOR+36sPQCb2HBfeFyabnGEVjjvbcIaeNSOqmBwJeg54sBXl7Ox4mxZqvRpObsLIcfwv10LI/rs/DuOeMtQfIOsjS9Jz/1t1kGVaHNrtQ4bntQ4B7kFz6oiYziIsIWkAXN/dCZM5cgqTycgkY6m4jk13IgTXdDgUeQPwsnQ99JnT58leoRFKREvjdYxCzClX1WMzBXsbNhZ8fe4h6DdspQjTDxJEwNYUuXVot8ykjEC7IvYur5McX+IY40GXjov61r6l9oWd2fmDp9l3T2uSbZVCFoRoe9lvsAx9juTc2wOGiU7X66Kc9UfCjpu6FNox5LnGs6d5vYg2vudwve/kHibemlMI4T0d+/EnqfeDIeH8gUt5DQ7XNu9CTgP6v+wVtX4c/dzFV1Nbz1nz13lr0B323a61LWmdMMDTuLsFzdHjHlI/DLeDlTWowcSanQDMIsntB0S2sJQBqwg/4578WwUvkJfl7i8T9UepE1mjuzuWs+vGUp+C3Wh8w45ZJA0UFK1RfEdxZesaE4TCq/RiFU6XTR1hfA2EBCWfmE/YoiPqtWNgxmGyPmECFsMwx81ZPWBLVJn5qh+F4rwAocUD5ztU7UWQKBCVC6mMJkPdZOqVi0BsHww6vTEAwx66GJB7PcRvYbIB7ZjNDPULRCIoBb2UNRo/2eyQtJpHpYRMF13hTN70wgda7zFGWrugebDX0EcK5UE2nVLY3fUFpSDhbDYSIijsvgr8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0102MB2630.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39830400003)(346002)(9686003)(38100700001)(71200400001)(55016002)(4326008)(33656002)(8676002)(2906002)(86362001)(186003)(83380400001)(54906003)(110136005)(316002)(66446008)(8936002)(64756008)(26005)(52536014)(478600001)(76116006)(966005)(7696005)(66946007)(66556008)(6506007)(66476007)(53546011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RH0UgI+Pa180HpmPpxZfqinlNmG3Cl3kuYmtSJKvYxAFc0eZ2om4bL8fTlsE?=
 =?us-ascii?Q?ry/pZHqlJh6xXKeFcNb3uua/EGOk4kwrK4k0TbDpzlpbv4bNEtMeaOccnVCi?=
 =?us-ascii?Q?ZSs/6lGq+uof6Hu5dG5VhZOPifkn1M93MVxMDsyN2xEXeQtyNKBYUi+wxUK6?=
 =?us-ascii?Q?jHbB6U9e0x3vHuUYRoXpwC7sVWH/0SaCPeZzXchhjv1bgu6wN5NUS/MF9YLH?=
 =?us-ascii?Q?iQy5HrShk5ewwRX3YYm92X5BosqID2ujIanIyntk62/oCxBhfCDulMbZwLjp?=
 =?us-ascii?Q?o1rJ0kUdWXbzl4p6rGysuIFM1wI3o23v1xzYLpM1JRGU26h+aMTrp9LaPlmq?=
 =?us-ascii?Q?uec9a/Z9yV3yE2IFRYoFJrXwluksqz824byZXiTD8xuTVJu7cZxxAYkKbGKw?=
 =?us-ascii?Q?BeoIPVpJrnBNMc0MLrbp5epbk02EJ/uq6SKCy/hmKWDIiu5ityf1Wjn59zme?=
 =?us-ascii?Q?Z3o1D4KzPwJVzOI7KcbK/XAvkUKrxVv2n1pE8ZBYX3rqvwROoRDQTv/XIzdQ?=
 =?us-ascii?Q?W8Ubl8IBIwrFnTb6A4wuIeHbeBJ0PRZB6VVzGYFIcTVexvj1oQdyGj5CPTzx?=
 =?us-ascii?Q?YBvCBREmHuGTeWFYwXqbpnWNReuXQIshXoySKotNUQ+JX+N4mn1YLMIkqHNt?=
 =?us-ascii?Q?wNXt8ElsLi0uFc056vtXbVgrwtYDfJDnzc28NbFqDR3P0qAmDcWOZxAFK3N8?=
 =?us-ascii?Q?YmIexH7/e6bcULOlNaUHYLI9v6Q4n2mGJ+MCrzAhlzKLIqpI1zXFJJI9gpz/?=
 =?us-ascii?Q?rGn7M229nkZkJ5UsdNd3Zo7DTTxC41Z93x2tPvjhtD+29H3ysYn3I2iL0OcV?=
 =?us-ascii?Q?52pCH5gFX0KqCw7j/LmGtu1zcG+K9cpxt3+9elLXUbzXxEBU4Ivz7PjJC5MG?=
 =?us-ascii?Q?IWcuglFH0dx6yGiUKF150XvNxS07MQGI0js8neRuYW8IoyPHO0Mrx0vMxv7s?=
 =?us-ascii?Q?Om5UXL6/kIXU4QzY61t+t6vNLNJj2Gs+Keq+M1Na1PDttazUUeTPDN4+t9EP?=
 =?us-ascii?Q?unVoOalscKoogDdHE35OkQ0gSZqz4FJVBMSE22IBk/1eG0qU9ijUEpawO42q?=
 =?us-ascii?Q?kUKIFfvxWyCXVebrWxPNxaRLSxNmbJ+zGJMK1F4nmPAR96r2QE0rMNOrm2fX?=
 =?us-ascii?Q?smZ6jEds5T5mSOSgx33llAUVb7giYk0nc62U2CuiQIdqcPgvNq82X5TZbWzV?=
 =?us-ascii?Q?ikxGmsZK1tbOYUErV8/wj+LV/Uqp90Aq0kVZ1TxtC0Jjl98Sk0xXuq0hVLZF?=
 =?us-ascii?Q?nASk1VQrVixgYTxXtpQANgTWkr6oqftzrI4h4kED2F3p81M3azSsTjoiBn6O?=
 =?us-ascii?Q?1VpsGS+/vtrfqC1A91LA4//H?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: spinetix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b4db7a-0e12-4a49-7281-08d8ed5f73b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 18:22:29.0664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5f4034fa-ed2d-4840-a93f-acb1e9633b93
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCoUwv/DhOQfWt5CLbu3W32iLaAbx8laElVzCr17JiLpOe1ASNio4GJ4AkkE2WW3W08AcJ5/HAhALP6jUkQhR+UZqjeTBuy91BbZMcUNy2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR01MB6838
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> -----Original Message-----
> From: Diego Santa Cruz
> Sent: 02 March 2021 10:02
> To: 'Trond Myklebust' <trond.myklebust@hammerspace.com>;
> 'anna.schumaker@netapp.com' <anna.schumaker@netapp.com>
> Cc: 'linux-nfs@vger.kernel.org' <linux-nfs@vger.kernel.org>; 'linux-
> kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>
> Subject: symlinkat() behavior with NFS depends on dentry being on cache o=
r
> not
>=20
> Hello,
>=20
> [resending as plain-text, sorry for the noise]
>=20
> I noticed that the symlinkat() syscall changes behavior when the newpath
> (i.e. link name) has a trailing slash and is the path to a directory resi=
ding on
> NFS depending on this path being in the dentry cache or not. I stumbled
> upon this in the context of a Yocto / OE-Core system where I updated
> coreutils from version 8.30 to 8.31. This creates problems with ln in cor=
eutils
> in 8.31. I am currently using kernel 5.4.90.
>=20
> What I observe is that sylinkat("name", AT_FDCWD,
> "/path/to/nfs/existing/dir/") returns ENOENT when
> "/path/to/nfs/existing/dir/" is not in the dentry cache but EEXIST when i=
t is,
> but only when "/path/to/nfs/existing/dir/" is on NFS (NFSv3 in my case).
> Note that if I remove the trailing slash from the newpath argument then i=
t
> returns EEXIST in all cases.
>=20
> Following change
> https://github.com/coreutils/coreutils/commit/571f63f5010b047a8a32503040
> 53f05949faded4 in coreutils this makes "ln -sf name
> /path/to/nfs/existing/dir/" sometimes fail with a "cannot overwrite
> directory" error (when the path is not in the dentry cache). There was no
> problem before this change because ln did a stat of the link name path
> before calling symlinkat, so the entry was in the dentry cache when symli=
nkat
> executes.
>=20

Any feedback on this problem I'm seeing? Or should I report it using Bugzil=
la at https://bugzilla.kernel.org/ instead? Or elsewhere?

> I have created a simple program to reproduce this more easily, which I ha=
ve
> attached.
>=20
> To reproduce do this.
>   - Compile the attached symlinkat.c
>   - Mount a NFSv3 filesystem at /mnt
>   - mkdir /mnt/test
>   - To test the error with no dentry cache and trailing slash:
>     sync; echo 3 > /proc/sys/vm/drop_caches; ./symlinkat name /mnt/test/
>     symlinkat name /mnt/test/ failed: No such file or directory (2)
>   - To test with the dentry cache:
>     ls -d /mnt/test/; ./symlinkat name /mnt/test/
>     symlinkat name /mnt/test/ failed: File exists (17)
>   - To test the error with no dentry cache and no trailing slash:
>     sync; echo 3 > /proc/sys/vm/drop_caches; ./symlinkat name /mnt/test
>     symlinkat name /mnt/test failed: File exists (17)
>=20
> Although I'm no kernel expert, from what I've understood of the kernel
> code this seems to be a bad interaction between the generic fs handling i=
n
> fs/namei.c and the NFS client implementation. The filename_create()
> function will call __lookup_hash() after setting LOOKUP_EXCL in the flags=
 and
> if there is no dentry cache for the path then nfs_lookup() will be called=
, will
> notice this flag in the nfs_is_exclusive_create() test, optimize away the
> lookup and not fill d_inode in the dentry. When execution returns to
> filename_create() the special casing will notice that is_dir is not set a=
nd
> last.name has a trailing slash and thus returns ENOENT. Looking for
> LOOKUP_EXCL usage in the kernel only NFS does this kind of optimization i=
n
> current kernels, but in 3.5 and older the same optimization was also done=
 by
> CIFS.
>=20
> According to the symlink and symlinkat man pages ENOENT is returned when
> a directory component of newpath does not exist or is a dangling symbolic
> link, which is not the case here.
>=20
> What would be the best course of action to address this issue?
>=20
> Thanks,
>=20
> Diego
> --
> Diego Santa Cruz, PhD
> Technology Architect
> spinetix.com

--=20
Diego Santa Cruz, PhD
Technology Architect
spinetix.com


