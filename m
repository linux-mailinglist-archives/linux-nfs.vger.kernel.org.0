Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9332A951
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578849AbhCBSTx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:19:53 -0500
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:47276
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1378848AbhCBJD0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BecxQdI/2PQWV4xIgYlnZNLXtecDeqJkNtLssuHUiGFtaoTm5zcFHEzAL8TiB5UTsWEG7iP1igMyCCM3eJb+SumRx8a8sTQqGZKFwA5KRU+q8bn4ow6PrPQLwBYZO4JhBrmgvBQpqxv6os/ySuXhigox5TtxeyC5dOX9KOYYDcTdD3upiMLVFktUF1ThCtAK0Z9ZbVjkjbShhobZ1B7oHVIra/tQurra/ij/YcSngAMFOxbSwVHb9eYdL0tfddYSbxdAjuqtVJkRWdKFOlGm3y5sK8r6eioIv3eP/JGZJPozhCGCvhoAoSJgDKCyteQmRGuqPn6gNXdHmKiNOorTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2H2CuX+3QTCioO7762cHJESDMp/jbniLyJN+gypP6U=;
 b=jNaEKP36z1dFASTOn4pXulhmkqArvQSHjyj/uMJSAW8+4FVhQZkusAgRFkD3xT0TOw81qcwvC0ky9jETJWzfN8bwhuaXjbEsADegDZ4AS5mnx6cYPXVxPYD4+H5DrAIje5lVrrpmLAjfV8raJDRYC0hddxMDIbpU4LHB+aJKatmGQf2SwIyC3z0x4SSg5b3bYktfWluhi/pxjQx9KuAFEsdM1q4sVaJCkYOwu0iPFcjSmHQ2+Nmo8nU+yr9S1FJDF9eBy60xAm2oynKrqBKHXGgHZYfFUaaJQ+qH/nMgG2yLWZ8Q210JeMvCE6SEdDxj5wICHyJHkXpd+Ev5HAeJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spinetix.com; dmarc=pass action=none header.from=spinetix.com;
 dkim=pass header.d=spinetix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spinetix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2H2CuX+3QTCioO7762cHJESDMp/jbniLyJN+gypP6U=;
 b=ac45x35NfalfRfs2+vD1BwoneR9E6moR+r4JCwHAF2tc4sE1OhO2hMzGcyBkjEcpaoYpCI9/tsdwxRq8wqxaBS70dODtly2IM7orhUaF3vZOzmPASJYJiLW8xzUHKzy39PhctFBFCr5BTEMzML4JA0diL+cxrRcfM0OngjwnEHE=
Received: from DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:e::19) by DB8PR01MB6312.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:153::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 09:02:16 +0000
Received: from DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
 ([fe80::a979:e5e4:3b20:ba6b]) by
 DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
 ([fe80::a979:e5e4:3b20:ba6b%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 09:02:16 +0000
From:   Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: symlinkat() behavior with NFS depends on dentry being on cache or not
Thread-Topic: symlinkat() behavior with NFS depends on dentry being on cache
 or not
Thread-Index: AdcPQlxlz0o0+PGxRoKy1LGtL+Fk7A==
Date:   Tue, 2 Mar 2021 09:02:16 +0000
Message-ID: <DB6PR0102MB2630902B2569060CD5E802EA88999@DB6PR0102MB2630.eurprd01.prod.exchangelabs.com>
Accept-Language: en-GB, fr-CH, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none
 header.from=spinetix.com;
x-originating-ip: [178.198.240.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea96dda-3bab-4f44-e2bc-08d8dd59e0d5
x-ms-traffictypediagnostic: DB8PR01MB6312:
x-ms-exchange-minimumurldomainage: github.com#4893
x-microsoft-antispam-prvs: <DB8PR01MB6312B429358DF32587BA5F3588999@DB8PR01MB6312.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dzSPSY7aJugdAQV1+3CgRtmliM1h5loKsk8bDM0nra13mmX7QZcJkTCkr3lZY/vRVH0MrLzueWjpJo3Ta3krWoCT+wItwHPDoWQenC/rff//ybhSVbGrAEgWefqivAi5dsxWof3/WXfY1a5Q4qkwe5hv5Z1v1ESfRWpJ6f0hkZJZvctQq919b47g0BhlXZlX34m++Ccmg7foQnzfNvXdgt0FS0gtro1FNuRrQyB21uHwD4mPSfoOz5TyuU3r27PWQLMwRZp3vYgpm8ZWV8MIpYWtpPAYEXzjtAAUYM+OaWXuZr+z11YsauVlAMQageoB3y8sVWNBtBCpPm/wO4rSL3BlPlgt4o5Pid6mJ/qEXCrh6eI1ybB5g5RrDMbwac9CRUu7ldCU4vXPvzB4QBbfnueT9wZ3fnaybor5tWEV/OjItyL5r+tvPnl6NrxMzglwyzEwHfX70k1yF/VopxgKYtxSh5YIUUHbR07oulZ2bFRpfgH43g7zVoCzij9eL/17TAPnieMX3k8I4igQWuDpDcTSInARWVgB/WEcCX0Pvq+NOWiJ6ENwo459l3o1zSUTHm+yw9AzGDFQtHIuRcCw5kuPgXj9VlhvrEp2ZTRH/k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0102MB2630.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39830400003)(376002)(478600001)(99936003)(966005)(9686003)(66446008)(55016002)(7696005)(186003)(26005)(2906002)(6506007)(86362001)(66946007)(76116006)(33656002)(5660300002)(83380400001)(66556008)(52536014)(66616009)(8936002)(54906003)(66476007)(316002)(8676002)(4326008)(71200400001)(64756008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/Vj1nFFXHePnJ6Y5io7yK0oQpMxYRqoFFz5UYzsNJsO4w20dG7u0K+ZufFzC?=
 =?us-ascii?Q?HA2cN4Cu37+ZpKmNUrxsaj5dm+MZei+3AwCKL2YOhtbiVnFVHdRxV0e4a7zq?=
 =?us-ascii?Q?PgbUuq96X62HndqqIIYYVhn4u1Dj8ERBcMXNCvb5t97CW7fCDGGf/K6C7F9V?=
 =?us-ascii?Q?8nuhkY5pMcBJzH31EihZy5+mrdFtPSgeG3WEPaHskLeP2Dfjoyr3ShJM/UpI?=
 =?us-ascii?Q?4yqYKX/FgfW8BdpncSXQod+ZuHSPULMcZEeY1Z1o2x/2QTmg1fQ0i6ne3l74?=
 =?us-ascii?Q?Y80kIDPWNMy5LnZBD+YzOG5SaQOVyKXWSR78SsssTwFO5WwIrVEnAVj3YHRf?=
 =?us-ascii?Q?/2AiYCWBpLRDzp81TQuW8I2Ou0KZX8rCbAnsc12eCLQwn2F4T2jrbDeUUfSA?=
 =?us-ascii?Q?930JyCe9w8JSYmsRUIprJ2Sdhpjg2AW/+JP7IuMHRdFolNuONEBaR9AL0WiL?=
 =?us-ascii?Q?uU+roepo8vdiBsWDzmfUqYBYX7jc8vll2fr+ShpNe63cvekQzCmE6evIBEBa?=
 =?us-ascii?Q?5u23yO9ie3s2kM59a5p/5udrz7iIbA1Tkaoy/LU9m6i7egViOMVKd1hYgMv3?=
 =?us-ascii?Q?ZvGrYU/XlWdEA5ad091jkcYQpjV6TNORyr8en87gW/e4MPceGC9jTq4zD2+o?=
 =?us-ascii?Q?a0qwGfNackfrpzd4QFEy3kZApO8Fms0BRrvtZ4tWtsQHJ5RbjxL0hS5yTGLB?=
 =?us-ascii?Q?o2xT0cL36Jb439ZrvWm9DJ1oeH/N/E1jcxQna/1k+ANzKC9V9xkwTB9pUXq6?=
 =?us-ascii?Q?urC2c/gEUeDuXqYA/OhparfOiQ9bJjlF2Y5/2EVaRllYXPaqqduyjzH2gOsB?=
 =?us-ascii?Q?njyi8mDXmAyeTnIdXz372IFdWfoHxy0OJ6Z55Z6zBQ/HW63MLGXkr5kybnaV?=
 =?us-ascii?Q?cN42tXTeiVUXr75KbRHkMvp8kdP1bKA4SgkXUBln2gN39r+J6E+5KtXujzL1?=
 =?us-ascii?Q?8cxrZE6VPXIwB3eckUtN413BTJcVSMrFpdhj1V5vFht92w7uhWofMKR8ouxI?=
 =?us-ascii?Q?ft4etxC+xNshT3a2dD4t9Rkc+ZuABijDAar6QXyFGDBTtLx0Kq7w0i801Uzm?=
 =?us-ascii?Q?ki8irHL+NEoGL2B6W0a8Sh8ixRXfnIaTtnI2DuW+ZaTGjo07tCzjC+cvX32d?=
 =?us-ascii?Q?JNRW1Othn4te5TlygXHXdL7V35G2xUfRxFaPUBtfnwHA3/uqzMEEngKyV6XD?=
 =?us-ascii?Q?w04RdYQ0Lxz5aK2eiuXKSGj+1Wt67ip/DU72CdGWvnbSNz2uOrlwiB9hyKNj?=
 =?us-ascii?Q?PwJWnSoVIujVH/6Laz09W6GwTjqF6AqDvXnU8bvKVU1xTIVeTNNPrWaCeF2Z?=
 =?us-ascii?Q?uLeXoKsqE1SQ9DQ5B+HDqW5V?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_DB6PR0102MB2630902B2569060CD5E802EA88999DB6PR0102MB2630_"
MIME-Version: 1.0
X-OriginatorOrg: spinetix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0102MB2630.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea96dda-3bab-4f44-e2bc-08d8dd59e0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 09:02:16.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5f4034fa-ed2d-4840-a93f-acb1e9633b93
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7+HsvxkGDSGCLy4jRKcoAJbZmKK3dnza02fSbH7N9TqLWkVMyOS4ideZCyOlDm3SHUe0BDZDYwdgVR7XWY76rLq/UeONmpwNepKVOOPF3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6312
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--_002_DB6PR0102MB2630902B2569060CD5E802EA88999DB6PR0102MB2630_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

[resending as plain-text, sorry for the noise]

I noticed that the symlinkat() syscall changes behavior when the newpath (i=
.e. link name) has a trailing slash and is the path to a directory residing=
 on NFS depending on this path being in the dentry cache or not. I stumbled=
 upon this in the context of a Yocto / OE-Core system where I updated coreu=
tils from version 8.30 to 8.31. This creates problems with ln in coreutils =
in 8.31. I am currently using kernel 5.4.90.

What I observe is that sylinkat("name", AT_FDCWD, "/path/to/nfs/existing/di=
r/") returns ENOENT when "/path/to/nfs/existing/dir/" is not in the dentry =
cache but EEXIST when it is, but only when "/path/to/nfs/existing/dir/" is =
on NFS (NFSv3 in my case). Note that if I remove the trailing slash from th=
e newpath argument then it returns EEXIST in all cases.

Following change https://github.com/coreutils/coreutils/commit/571f63f5010b=
047a8a3250304053f05949faded4 in coreutils this makes "ln -sf name /path/to/=
nfs/existing/dir/" sometimes fail with a "cannot overwrite directory" error=
 (when the path is not in the dentry cache). There was no problem before th=
is change because ln did a stat of the link name path before calling symlin=
kat, so the entry was in the dentry cache when symlinkat executes.

I have created a simple program to reproduce this more easily, which I have=
 attached.

To reproduce do this.
  - Compile the attached symlinkat.c
  - Mount a NFSv3 filesystem at /mnt
  - mkdir /mnt/test
  - To test the error with no dentry cache and trailing slash:
    sync; echo 3 > /proc/sys/vm/drop_caches; ./symlinkat name /mnt/test/
    symlinkat name /mnt/test/ failed: No such file or directory (2)
  - To test with the dentry cache:
    ls -d /mnt/test/; ./symlinkat name /mnt/test/
    symlinkat name /mnt/test/ failed: File exists (17)
  - To test the error with no dentry cache and no trailing slash:
    sync; echo 3 > /proc/sys/vm/drop_caches; ./symlinkat name /mnt/test
    symlinkat name /mnt/test failed: File exists (17)

Although I'm no kernel expert, from what I've understood of the kernel code=
 this seems to be a bad interaction between the generic fs handling in fs/n=
amei.c and the NFS client implementation. The filename_create() function wi=
ll call __lookup_hash() after setting LOOKUP_EXCL in the flags and if there=
 is no dentry cache for the path then nfs_lookup() will be called, will not=
ice this flag in the nfs_is_exclusive_create() test, optimize away the look=
up and not fill d_inode in the dentry. When execution returns to filename_c=
reate() the special casing will notice that is_dir is not set and last.name=
 has a trailing slash and thus returns ENOENT. Looking for LOOKUP_EXCL usag=
e in the kernel only NFS does this kind of optimization in current kernels,=
 but in 3.5 and older the same optimization was also done by CIFS.

According to the symlink and symlinkat man pages ENOENT is returned when a =
directory component of newpath does not exist or is a dangling symbolic lin=
k, which is not the case here.

What would be the best course of action to address this issue?

Thanks,

Diego
--=20
Diego Santa Cruz, PhD
Technology Architect
spinetix.com


--_002_DB6PR0102MB2630902B2569060CD5E802EA88999DB6PR0102MB2630_
Content-Type: text/plain; name="symlinkat.c"
Content-Description: symlinkat.c
Content-Disposition: attachment; filename="symlinkat.c"; size=497;
	creation-date="Tue, 02 Mar 2021 08:59:00 GMT";
	modification-date="Tue, 02 Mar 2021 08:59:00 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0ZGRlZi5o
PgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RyaW5n
Lmg+CiNpbmNsdWRlIDxlcnJuby5oPgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkK
ewoJaW50IHI7CgoJaWYgKGFyZ2MgIT0gMykgewoJCWZwcmludGYoc3RkZXJyLCAidXNhZ2U6IHN5
bGlua2F0OiA8b2xkcGF0aD4gPG5ld3BhdGg+XG4iKTsKCQlyZXR1cm4gRVhJVF9GQUlMVVJFOwoJ
fQoJciA9IHN5bWxpbmthdChhcmd2WzFdLCBBVF9GRENXRCwgYXJndlsyXSk7CglpZiAociAhPSAw
KSB7CgkJZnByaW50ZihzdGRlcnIsICJzeW1saW5rYXQgJXMgJXMgZmFpbGVkOiAlcyAoJWkpXG4i
LAoJCQlhcmd2WzFdLCBhcmd2WzJdLCBzdHJlcnJvcihlcnJubyksIGVycm5vKTsKCQlyZXR1cm4g
RVhJVF9GQUlMVVJFOwoJfQoJcmV0dXJuIEVYSVRfU1VDQ0VTUzsKfQo=

--_002_DB6PR0102MB2630902B2569060CD5E802EA88999DB6PR0102MB2630_--
