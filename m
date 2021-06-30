Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1E3B868F
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhF3P57 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 11:57:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12374 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235960AbhF3P56 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 11:57:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UFpD0P026939;
        Wed, 30 Jun 2021 15:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HXKuaRSGclIktJYl6JbmkyLMWvXV8dHRRZTlSOHztzY=;
 b=dYkeN253APE4efQQGFYsOR50ipH9yG/OiFUp3MvVoy1V0nZOEMR+shJSSGJh81nKBaUn
 vQE9pNIs5s4GB0hkL3PVgSpzJrf/EyOpc0McjGI3FXnuBHHaAjeHJ5TgBtwyxeB2cRI1
 WihOCZhvitQ8wjNlrF6lev4ejvgdIysLbHvntcBTaM7w/3YDrx5tmb+1oPDXkwxscb92
 dkN/QxOyNSk2D+8GqSIHqfA18h0XzhhkLgJfu8uXcCisPZA9wojWs0oAPezfyU4u+v9R
 AyF0PDgkM8VWtafxt++QuNc74ESHCnSd6lNJLxHTIQi5rUBDxdLqu9hQx0sdj7SkSK+c rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39grmarg8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 15:55:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UFnuXJ159974;
        Wed, 30 Jun 2021 15:55:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 39dv2881sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 15:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkylu284D5/oNO5YxpOJmUVzBxqBhasybu5sjZdaK/bmVhXJ1brUgBFuSHl9lL2JPjCmBL9kpHXQye1MFznVyJST6aUORk9KoNycFlWeIpdVRXsK9bbG7/t+GNjkLgkQ0JElXcCm3dVzwKNpchwNLq6hEgFsQiHPU8zMGCUDNdPVWv6wncJHHq0tnXsYlUKBGxgyUdVQJYO7qOHN74JhVLio5Oy7sm9gmH0bc2m0Vpm4zsCLfwRL19ZOMlSe/u5/kG1vpCKL4HieNVlDqyP7XhGBGBZx2Q8zVvTUgxbg+ZP1rcf+3QaSYntrCxo2DSQT1pNNmnb5WK0u9wsXdlYptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXKuaRSGclIktJYl6JbmkyLMWvXV8dHRRZTlSOHztzY=;
 b=nqHF1AcUosmDT3BBdwv/2zVGUqOGUKsbZhn+eW9yagdip7XRXDWCq2BiK9tPG0/81WZu4URGBaRXSfZ8pcCx10EGNsns1vE6D24ZQNlcWItxoXQ1r4tBgHrwNDRN3pOYYrZnxTX0sOkau6XU0zZNNwR5MUJq9wp+7+ew48W0Rwmj58EJUU4CwozE6cOgRGoQC4lrBXtvr2rTtnM1uFceVVxYyWqPjOnemHom6TSfc1wxTU67PIeoAq/XJabCTy2lTQT4Pn83aL7qdp2Madb9lRr20GKzENaIVZntNRkAIjOrCyHXYKQDGOHvouqTWGjXS2WOfIT97KgLdjeEF44scA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXKuaRSGclIktJYl6JbmkyLMWvXV8dHRRZTlSOHztzY=;
 b=Ung1mmYwOsR3CrtRPnVV2eFalmkIkyRhsg6fstbgCfMCaI5eTYFUgt1U0uvL44wigIYQ1j1fF3ij++v4upU84SI3jp75Y7hgkNe06s9XmL/hLtLe0m3dsrzOQImdnFVInBaAQvm8Km0+Etwbf945pGGvORSlC6eBiPri6fPB6BM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB4085.namprd10.prod.outlook.com (2603:10b6:a03:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 15:55:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 15:55:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: 5.13 NFSD: completely broken?
Thread-Topic: 5.13 NFSD: completely broken?
Thread-Index: AQHXbcgaFJnLmMlpmEOPdhWd8pFOCasstRGA
Date:   Wed, 30 Jun 2021 15:55:16 +0000
Message-ID: <1BF34FA4-EC1A-405D-AA8B-217BF94DA219@oracle.com>
References: <20210630155325.GD22278@shell.armlinux.org.uk>
In-Reply-To: <20210630155325.GD22278@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c1b0406-6134-41fd-e196-08d93bdf7445
x-ms-traffictypediagnostic: BYAPR10MB4085:
x-microsoft-antispam-prvs: <BYAPR10MB4085792C3C6CBFE30A13535593019@BYAPR10MB4085.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDX85vgtdKTqhGF2nqOrXOZcw0rPwMivTaOFJQlG5nUsJycU6fV5NAHPQlguZrKVL37Zs3R2sciavAPHEU5scGcfTMj6n3hM/HDJ2S58DrLKd5t5ebGOi9xHnf4k6LM6p8u/TLfeWp30+DP2t5DTJUI5aO/kssxvzc6mF1hMMyJ6J9XtpuLEwb67aaaL/DxsFmrzWLaTMORlDXfYXU3pPkXIRLUuHC+QDo9jRs7QY5fjTqNxy12zSd93s+kFCNxwIhnOyTRs86ckgDmgSV35PpK8Rq4TWlGDT8JYBWUl+4f3ddf3DC90GjzSbfRehELoJbQjc1/IpgsQAyFLVfKEyWZsh0c42Qdb3PehNvmSiuBPzVNlnUg4s/s9cgm884/LtOJPGVjndLaeImWknnBgpqBfIhmNW4YaoJ7816uFPbC4QZizbezkO5k3bVSBJFZn0Cfhmlahg8XdyesEW3zG679lWfthx1weOL6DA7ep439u1swdaoQ02zT+t/LBQGe1CXSu1ubTe59b2CD+QX39srxAp4SEGMfZD1fStElXnNDaImW2+NChR31zoJHko/UFJ6S5VPS67kV/3FDeKG3LNUFJNxX+p7kMbP+dnIP9fUs+8hVvLSjFW9tHWfw4GAxuzNrPLb5S9CsNHuouwscDbAiQoGbB+ucUhQePJ7L1tOdrcmfMJAG5SHDZ0p4uCx8Lu/QvrOa7k86OHiQHpA+yWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(396003)(39860400002)(6486002)(4326008)(66556008)(64756008)(66446008)(2616005)(66476007)(76116006)(91956017)(66946007)(2906002)(36756003)(316002)(86362001)(54906003)(38100700002)(33656002)(8936002)(5660300002)(186003)(53546011)(6506007)(6916009)(83380400001)(478600001)(6512007)(26005)(71200400001)(8676002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xSyhWVdOjkevg8hy8U7/5jGsdYod8tfJNzuy9UdX5qVvtQweCaR62Ayu7BZL?=
 =?us-ascii?Q?jI8C4o5ExUq7/bcvm2ZF075UaE31Kza0cVm5n/zbL1oa3R0K9oA3JHhgyaB8?=
 =?us-ascii?Q?p4kFFn/F8Te86KwCSkk83MuUUK1wQWv7aLWkpavEXajSVPSKEHkcq3OEqPuk?=
 =?us-ascii?Q?Ahz8c8sHxVay5votIm+9sFa052+N6sEd/bLrFSjN7P6mg1XRGknmE+qU6Rs/?=
 =?us-ascii?Q?j3x7C0JficfueQZrZvLgDqFrtLWSzEwbL3AFKcm5k47XXsXDBeQenP2RjeKj?=
 =?us-ascii?Q?ROjnYYqZbYxW2hDU7XvMkonpdhd2/cAV97l87KuikHt0Ir5Pxi+qa/kMxam0?=
 =?us-ascii?Q?4GCIdfikzvBTBh5sbqVjhlYx6SnYbSmaiEwA+/dr7GcPcvxbGX4hpXYStv5A?=
 =?us-ascii?Q?MDrckJ+pucP8uEFUtzOVM150kfHvUoeCoHOT0ke4NqkqXy0ApQVWgjj/fig7?=
 =?us-ascii?Q?z6u1v62cMCDonIWsF0dIJHj7Y5+AOUkQeCrCIhb2z3t3u169+NF6oBNBQQRp?=
 =?us-ascii?Q?z0jECNnOZHPxych+CAZv1uaQ4pxzDPXWwKjK3Y91l8GToLESR01m2q2enqes?=
 =?us-ascii?Q?/lsRHbvS3rF17lBAw+L9Ri0jNYFBVX75FTX0jxwcgsGgQcqJfcopWIXyt+Mu?=
 =?us-ascii?Q?797ot91N0vsDcwIMWa7eEwH7dF3jIJko94iQLiSG8RKgmd4Lxju0IpNw1Jby?=
 =?us-ascii?Q?dzDek/BusZo6tZEh6Iajb/pLD+244fkRGeYiXs1Firaj0kP8MRoWLofystoU?=
 =?us-ascii?Q?Ezt0+xSTK787221j8iwjurQbfIErTTKwZexTmyVOyQrTi5O753y8sQOSZFbS?=
 =?us-ascii?Q?hmvhOuJ2tGLLYdF0dO1QTGNaHaly6WzW7PmZRfsiTAOOsu43rQlCfRX8XFE0?=
 =?us-ascii?Q?J544iqYo5RUAUYJ2urwA7Bz6+YDmJijBhVP/kX3Uiwk7UtMkeMqeaXnL72hd?=
 =?us-ascii?Q?qgdAUvYygIEEHoNdERvl35gwxOYjpA5/v2IRTbJs7v3lVa2VbI6vum9UOaB3?=
 =?us-ascii?Q?XkallDK5RW53nJ8ZXXohaHIWFJS8wljEMdSMmi8m9FByERDW2oKO+h6P8X6V?=
 =?us-ascii?Q?20o216i5eDnY+aeKPc3xnyD08aShzXgS6B40OIcJdGHICPg4Vnlu24REgnQs?=
 =?us-ascii?Q?BJ8TJ7ebMzGT1eIIzLZmidMQ+SkywApPNpzVUB9mSBVzBGCfWca+90lc1g3M?=
 =?us-ascii?Q?gt6kVce8aTQmUyt9W87/sZGY+WkXmdTcqjmiJ1hEr16SijRlbmy7z+77aFB4?=
 =?us-ascii?Q?BYw4bqwppqMev8Dwr2d/2sUwZFW/ArRBc+LUWc/Ut4UGMDczc5GMAWq3x7O+?=
 =?us-ascii?Q?ZAmEyphhCA0VwrS+EUyshqKK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AADD52168D62FF499A1700FC1EC31CCA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1b0406-6134-41fd-e196-08d93bdf7445
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 15:55:16.2425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPC+hTMk1dwesnTjkSbwayDwoeGjtY3fVLx0N2GXU2FPF1ZwPZx5fG1oLSROk+RKIZJi7qEfQMe/QsjGudXmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10031 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300094
X-Proofpoint-GUID: S_jGXyuPGBHqZN2j2x8Lf12TfMX87MW4
X-Proofpoint-ORIG-GUID: S_jGXyuPGBHqZN2j2x8Lf12TfMX87MW4
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 30, 2021, at 11:53 AM, Russell King (Oracle) <linux@armlinux.org.u=
k> wrote:
>=20
> Hi,
>=20
> I've just upgraded my ARM32 VMs to 5.13, and I'm seeing some really odd
> behaviour with NFS exports that are mounted on a debian stable x86
> machine.  Here's an example packet dump:
>=20
> 16:39:55.172494 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1027945732:1027945880, ack 34775=
55770, win 506, options [nop,nop,TS val 3337720655 ecr 372042622], length 1=
48: NFS request xid 822450515 144 getattr fh Unkno/010006002246F4529A1C41AD=
9C321B1BF54BA2DD
> 16:39:55.172904 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 148:296, ack 1, win 506, options=
 [nop,nop,TS val 3337720656 ecr 372042622], length 148: NFS request xid 856=
004947 144 getattr fh
> Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.173365 52:54:00:00:00:11 > 00:22:68:15:37:dd, ethertype IPv6 (0x=
86dd), length 86: fd8f:7570:feb6:c8:5054:ff:fe00:341.2049 > fd8f:7570:feb6:=
1:222:68ff:fe15:37dd.932: Flags [.], ack 148, win 449, options [nop,nop,TS =
val 372047356 ecr 3337720655], length 0
>=20
> 16:39:55.173383 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 296:444, ack 1, win 506, options=
 [nop,nop,TS val 3337720656 ecr 372042622], length 148: NFS request xid 872=
782163 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.173474 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 444:592, ack 1, win 506, options=
 [nop,nop,TS val 3337720656 ecr 372047356], length 148: NFS request xid 889=
559379 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.173649 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 592:740, ack 1, win 506, options=
 [nop,nop,TS val 3337720656 ecr 372047356], length 148: NFS request xid 839=
227731 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.173708 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 382: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 740:1036, ack 1, win 506, option=
s [nop,nop,TS val 3337720656 ecr 372047356], length 296: NFS request xid 80=
5673299 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.173830 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1036:1184, ack 1, win 506, optio=
ns [nop,nop,TS val 3337720657 ecr 372047356], length 148: NFS request xid 7=
88896083 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.173921 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1184:1332, ack 1, win 506, optio=
ns [nop,nop,TS val 3337720657 ecr 372047356], length 148: NFS request xid 7=
55341651 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.196354 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 234: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1184:1332, ack 1, win 506, optio=
ns [nop,nop,TS val 3337720679 ecr 372047356], length 148: NFS request xid 7=
55341651 144 getattr fh Unkno/010006002246F4529A1C41AD9C321B1BF54BA2DD
> 16:39:55.214728 52:54:00:00:00:11 > 00:22:68:15:37:dd, ethertype IPv6 (0x=
86dd), length 98: fd8f:7570:feb6:c8:5054:ff:fe00:341.2049 > fd8f:7570:feb6:=
1:222:68ff:fe15:37dd.932: Flags [.], ack 1332, win 440, options [nop,nop,TS=
 val 372047398 ecr 3337720656,nop,nop,sack 1 {1184:1332}], length 0
> 16:40:25.892493 00:22:68:15:37:dd > 52:54:00:00:00:11, ethertype IPv6 (0x=
86dd), length 246: fd8f:7570:feb6:1:222:68ff:fe15:37dd.932 > fd8f:7570:feb6=
:c8:5054:ff:fe00:341.2049: Flags [P.], seq 1332:1492, ack 1, win 506, optio=
ns [nop,nop,TS val 3337751375 ecr 372047398], length 160: NFS request xid 6=
71455571 156 access fh Unknown/010006012246F4529A1C41AD9C321B1BF54BA2DD0100=
0200D0F60B4E NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS=
_EXTEND|NFS_ACCESS_DELETE
> 16:40:25.893365 52:54:00:00:00:11 > 00:22:68:15:37:dd, ethertype IPv6 (0x=
86dd), length 86: fd8f:7570:feb6:c8:5054:ff:fe00:341.2049 > fd8f:7570:feb6:=
1:222:68ff:fe15:37dd.932: Flags [.], ack 1492, win 439, options [nop,nop,TS=
 val 372078076 ecr 3337751375], length 0
>=20
> As can be seen, the TCP packets are being acked by the remote host, so th=
e
> TCP connection is alive and intact. However, the NFS server itself is
> ignoring the requests. On the server, the nfsd processes are all sitting
> idle:
>=20
> ...
> root      1155  0.0  2.7  32208 27820 ?        Ss   15:43   0:00 /usr/sbi=
n/rpc.mountd --manage-gids
> root      1165  0.0  0.0      0     0 ?        S    15:43   0:00 [lockd]
> root      1173  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> root      1174  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> root      1175  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> root      1176  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> root      1177  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> root      1178  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> root      1179  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> root      1180  0.0  0.0      0     0 ?        S    15:43   0:00 [nfsd]
> statd     1195  0.0  5.1  57012 52528 ?        Ss   15:43   0:00 /sbin/rp=
c.statd
>=20
> So it looks like they're basically ignoring everything.
>=20
> The mount options on the client are:
> (rw,relatime,vers=3D3,rsize=3D131072,wsize=3D131072,namlen=3D255,hard,pro=
to=3Dtcp6,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3Dfd8f:7570:feb6:c8:5=
054:ff:fe00:341,mountvers=3D3,mountport=3D42927,mountproto=3Dudp6,local_loc=
k=3Dnone,addr=3Dfd8f:7570:feb6:c8:5054:ff:fe00:341)
>=20
> Has 5.13 been tested with nfsv3 ?
>=20
> Any ideas what's going on?

Yes, fortunately!

Have a look at commit 66d9282523b for a one-liner fix, it should apply
cleanly to v5.13.


--
Chuck Lever



