Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA33B72DF
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 15:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhF2NDs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 09:03:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233729AbhF2NDr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 09:03:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TCueXp016767;
        Tue, 29 Jun 2021 13:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XKkiZ5mAwIf1sX1IX7o2yeGLPzVI8op2dlDECNrYYDw=;
 b=Nl4xurgsYu0SFW8WWrkYDkzi6lgF281CFI7gDUB3rkcHvqX96pYxRV5/fGCWXtnm3kBm
 MjOR0ijMYhZ0POK5ipsLRhd7oAL08x/1rGypEoFwO3TFTnNIlHTwHQ3ZSdi4WBVs8YoI
 5fqYX87mMMyV2WO+5vOl2zQqzbP6M48ASpEEMUMkxF3f/I+Jj1j+RblP7EORua2Mb3q1
 AoXEPXq9R4JZu3G2m+VreRCLBWZTSJt5whlVGX3eenhns8iQOB9BECvqz5k0yKJ+PV+c
 hhuPhVdaP9GOn/lgIXoGs26gRrltYZ+AnzSXUXkdZjshnEnXnHiNbVMkjDTg0R2Bj2TF Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f174kr18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 13:01:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TCu3EI058052;
        Tue, 29 Jun 2021 13:01:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by aserp3030.oracle.com with ESMTP id 39dt9eqtey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 13:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ0VfCeoHwIBmHOhSB1G8aCcs6nds3LBUn2oTjyweZmq5F9Op4rYn0zm4yAkKXuGaMWOwKK02QZdzhXNGjuRZ2yQCYo2HPDvpaXHyTCaZnwtshylD02XmzOBl8M9Xuc5zLJVUhvUPFXxQZhlxtR7P9qAjVeFeYzonaXiVy/zgn9qEbBdy3mwsBDULnmyVNWjWWB0LzlSMD4PTguH2+Q9XYABekprFtR+A4uidr1UAKwL6yXWmTaLU4nkRUglv8+1FjXwG+4K/c5vnCOUdbTNSBVkbUz7hrHOcaOhBVAmy5XdVUgUAnFCLQ1HumNm9rjh/SH5CB7/Uz7U5w/tPGGXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKkiZ5mAwIf1sX1IX7o2yeGLPzVI8op2dlDECNrYYDw=;
 b=LLU40XExu9iZH1dpTwfnR8YT2qKBGjSlwnLIa24C/Dzf8F7E5GennBuceHJy+fWo4jWqbBoMyUe9qKHpQWqo8MH7vtln2FVH29T6EXl+F1IpeF2tLYl807vB7aZx9tmwpAg8sYCbPz2hBoPoZmre9+LYAux4NOb1Qjw2h+bIOzEzguCCF6+m+v6fhNEwqlc9xpExPxmtD6d4fcNJwOGrbpXvYuqvmEWxF1N/UYL78Knqe3BHd9TOjrM2Wce17JlXy/NN0mM4aH3tHnJUdoG8YdSSQgUF8LzjDv1n+coKMFypcQKlu7QbJRW+fpz/tJURk4rTGtrFfpFDwF240Mz2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKkiZ5mAwIf1sX1IX7o2yeGLPzVI8op2dlDECNrYYDw=;
 b=qgkunQNqd4W7TTYe5Mbg5Cp2crRue+1pYqZZraEPhRQut8Vi8xOEtjNPb9eJ29hJ+A2hebneZDOEXurn65z2tBjndvxjZZQMWLfh1Wbb/fT83uwSEXfjgy6qPhhg0em1NCXr1cv38xDdMijxHlFU7YbospfSYWynuUaXdzZ4tZ8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3192.namprd10.prod.outlook.com (2603:10b6:a03:151::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 13:01:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 13:01:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux 5.13 kernel regression for NFS server
Thread-Topic: linux 5.13 kernel regression for NFS server
Thread-Index: Adds0xh8TyPplr3rRaqlXbtYqWYwkgAE72MA
Date:   Tue, 29 Jun 2021 13:01:13 +0000
Message-ID: <CB1159AE-7C7F-402C-9F52-954FFAEAAEE8@oracle.com>
References: <004d01d76cd3$18db1830$4a914890$@lucidpixels.com>
In-Reply-To: <004d01d76cd3$18db1830$4a914890$@lucidpixels.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lucidpixels.com; dkim=none (message not signed)
 header.d=none;lucidpixels.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb9b4191-2b74-4321-7f58-08d93afdf958
x-ms-traffictypediagnostic: BYAPR10MB3192:
x-microsoft-antispam-prvs: <BYAPR10MB3192354FEC373853DF0CC30493029@BYAPR10MB3192.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqmpOG++RW25J1pj1ZVeKqhzyVBPmkAqz9E0JFvjyVpNwOekjYCm1ExJUNmSAPsejm74h/jXDe4xDiCoyWGbOjWpnTOjXNvEENSBkt1AImSiKyjID+RuM/lDmHgVqZEQGDQtqrL1L0V+pdlcKrv6xIlYbhkmWK5Pb/uTvzCKimHtgvWShLz1/a2+RuIFFpU8lwpLAi0qTZVS4ulKJPTR8U57UdQTo1Hi6msYjVykTQ7H2xqZRMXwZBJGksyeMx5yH4hLL0g5NclhT19RflQDvoMtB1+BBiJb98uDXiTZjEPL+vwt+rlPw/TRas5cjPP3TtpfOoKdYCSAfaOyiuT4wmpLqlvERj1w0RGDgdIsMimBWcqeNBbSirxP9yG6KjLDH6IKLxd1Eoc/w+bG7Qd40USapPiDYKl9gCU/PoN8DGa9WAGSIxVUu/foIREH9xbxL1/Gl+NDSpXoCgV8N/aJKj6sVczeAE9/BzxmONEvqxW+KB0Li7qlK2cxzoSV+lBVxK+SvVkteFsZ4pCGD3dzuuKvZA3wAgw8p83RV82w3x8BMdKa2uYVm5yZkQAu0Q9yB0ACkH6sjn/RRQKxOeIQmx/O/EHFQaeUnpLBvCjiX8xhNpCBK0jBXyAsNTcji3GS/lvuGRcd4HxlnJ+4NflwkD69NcGaiReIOZXt4LtY9uFic9zZH0P3b5ZJmK8kDcoCTFTq85cT5xKxZXQ3cejI1oFzoBwH0uNP5GVR379d0HTOwnGknU79CBcAYWMrHfCSfQ1Y2tOg+l2BzRco/3L4ZX4DWd9uybgcjA6MpWWGZtGpk6TrcwWAiwP55FShbJMedqDm32zliW3VSip706a/3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39860400002)(36756003)(53546011)(6486002)(6506007)(71200400001)(26005)(76116006)(8936002)(122000001)(91956017)(38100700002)(186003)(478600001)(966005)(86362001)(33656002)(5660300002)(64756008)(8676002)(66446008)(6916009)(66946007)(316002)(54906003)(66556008)(2906002)(2616005)(6512007)(4326008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?keX+lObvBsSxpDRHG2BmX5VLqWAKn4fDJh9aNZCJIpTCDmFL/jWDO5oSIhTi?=
 =?us-ascii?Q?wHRyp15+7LW09PLwT3+mqxO7+DVb2S2WaJbgna3EX/0kobD9qfaVtE43OEug?=
 =?us-ascii?Q?qrgr6fCltQUMuWAM5XZzGwbryrYjhd/Bo5v+70j+XRq8VSSKC6Zx+FHluXxc?=
 =?us-ascii?Q?SlXLcE2LTXPq15lqzVVT66uS5TVFFo1766NbSyqtdPXVd/hoasHLE+DlHHmn?=
 =?us-ascii?Q?SkyWovBBZ+tezTDieE9EVb8SyA5GaARbWFp1aReDGPw3+uB0gMqMfThUo5aw?=
 =?us-ascii?Q?orPV+qKpVkZLsoMVfU3N61I249D+1hC+b8XZXsNsqy36L2S4F9RGJMkN4R4K?=
 =?us-ascii?Q?tjKZUxDYyeZWPji8Qr4kCWno3ttSn5xWtMaMfHI5rFpd0wJz1oFsF37UqiJO?=
 =?us-ascii?Q?hSmxFbJ75ULYw93FY27QBHEOKM8W9QhT/wqQGShrMHCx987ztOZ2xMMOVl29?=
 =?us-ascii?Q?O1V8swwo2LoiFiCutY7JuwBCYQLc+vPsf0rK6/NJCrxcq4HFNTctlMTQ6CQL?=
 =?us-ascii?Q?LgiKqvunxxZxjwOZItyRhc9qYw+GsUA8soPo2itIzo+YcIe2+tDm9z4nkI6A?=
 =?us-ascii?Q?ladAe1ck/looaAJdwO5iiUNEplev1/JrCLiLzECXCrcrtnX+aXjLE3vcHQBs?=
 =?us-ascii?Q?1wflmsH6ms9gsrdPdDdGTcWLihdiQA9C7aL9dCJVtLR+j9wnQX/VGvWdK1y1?=
 =?us-ascii?Q?CxyFx9df5nRWohhja4GcS1ELpc1CEkZ6lgRt+xDLgBpe+CEFArW8efzS6hLn?=
 =?us-ascii?Q?Xg3xC8Lj7ppO8FWNnIxIx0p7SD1pPyF46mKYmTmovswCVpg+zeVWtqZqH3U7?=
 =?us-ascii?Q?0FpFZemuxbNDzUHT/Gqm5rDqG9whTpx59p3lhlCr7TH5c8gx73Tk7dP3tqIW?=
 =?us-ascii?Q?PhsAj/JodZ82CGT5fdMmcBJRelu8pOxpGx3qsUb3jEt2ec0C12l5WhISk1oN?=
 =?us-ascii?Q?YtHGMGTtW+QAoqRy8cCnkPNF6q4QOgzZ7tGLc/Z+HKBcAA+WPaQUTM1i4qjU?=
 =?us-ascii?Q?8GO2oSywAnAzY76wWBSI4fNbL6ebZnu71TppB2unXCc4e4JWCyyDyxW3rZpp?=
 =?us-ascii?Q?3V4iZQgwYi8mNAmn+7qCX0P6HUZ/aqR1mBNBqsUReWoMtbH9gbG3tPyI3Tc1?=
 =?us-ascii?Q?D/JJiLqaiDJiT1PryUQFTHLcOuRmKUo2oYQZIsMUg5PKEtNpkd5Th4wwHgUx?=
 =?us-ascii?Q?iYtQ/r9Qm6aWZlcOJbhx1v4wNgQXdnhr3+SntDG7toRz8/Y6+Cg0YkdR6svT?=
 =?us-ascii?Q?pO8hADodLBN5ct5Gyek1ijMTskYEabnGDv+L/X1WsYLVP2vdwoYEVDPoQTrJ?=
 =?us-ascii?Q?CoRElaw58W+rJaN6dXup5K3X?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8134D79E4149B84C80CE0CC662473C4C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9b4191-2b74-4321-7f58-08d93afdf958
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 13:01:13.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByaNpwHc2T9y9D+Q/pFTMQqU2IASuQ+Ed4UBlDBvo1YGIyJ80lF/8rJ6ylIKT2F0YJmeAG8+ygM561FYBWJP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3192
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290087
X-Proofpoint-GUID: FxvHikVdIfs2lfQOvDzEBNcM2_xwO6KI
X-Proofpoint-ORIG-GUID: FxvHikVdIfs2lfQOvDzEBNcM2_xwO6KI
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Justin-

> On Jun 29, 2021, at 6:39 AM, Justin Piszcz <jpiszcz@lucidpixels.com> wrot=
e:
>=20
> Hello,
>=20
> ISSUE: Can no longer mount NFS server(5.13) share.
> WORKAROUND: Reverting back to the 5.13-rc7 kernel for the NFS server, all
> clients can then mount the share.
>=20
> Kernel 5.13 vs. 5.13-rc7 for x86_64
>=20
> With Kernel 5.13-rc7:
>=20
> ## mount is successful (from multiple clients, phone, tv, other Linux
> client)
> # mount 192.168.1.2:/r1 /r1
> #
>=20
> With Kernel 5.13 (hangs from multiple clients, phone, tv, other Linux
> client)
>=20
> ## mount hangs:
> # mount 192.168.1.2:/r1 /r1
>=20
> (strace output where it is hanging)
> ...
> clone(child_stack=3DNULL,
> flags=3DCLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=3D0x7f2285e303d0) =3D 1741
> wait4(1741, 0x7ffeaab6ce08, 0, NULL)    =3D ? ERESTARTSYS (To be restarte=
d if
> SA_RESTART is set)
> --- SIGWINCH {si_signo=3DSIGWINCH, si_code=3DSI_KERNEL} ---
> wait4(1741,
>=20
> No user changes in the kernel .config other than the comment for the vers=
ion
> text:
>=20
> --- config-20210628.1624867695  2021-06-28 04:08:15.152781940 -0400
> +++ config-20210628.1624867962  2021-06-28 04:12:42.591981706 -0400
> @@ -1,6 +1,6 @@
> #
> # Automatically generated file; DO NOT EDIT.
> -# Linux/x86 5.13.0-rc7 Kernel Configuration
> +# Linux/x86 5.13.0 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"gcc (Debian 10.2.1-6) 10.2.1 20210110"
> CONFIG_CC_IS_GCC=3Dy

It's likely this regression is due to a last minute change to
alloc_pages_bulk_array() done just before v5.13. See:

https://lore.kernel.org/linux-nfs/20210629081432.GE3840@techsingularity.net=
/T/#t

for details.

--
Chuck Lever



