Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46BE6367AC
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 18:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiKWRwS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Nov 2022 12:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiKWRwR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Nov 2022 12:52:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2DAEBE6;
        Wed, 23 Nov 2022 09:52:14 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHepgo006437;
        Wed, 23 Nov 2022 17:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FqC3g0s4eDcm9BzlQ5AdYtj2hsEyzZqesKP08ljzR5E=;
 b=Y9rgZhmPW51ZmPRTWc8xLRXHTxt2CCzKxRp1yFDlXf/ZCe6EauXUTiiEe9K5L9YLILlr
 T7d2EQaFSmQuQRPMcyCYzvq2ZjYAo/RMIfmHCLg/sXPEU3JCDBXIwj5VaaVyMkSADjGW
 OyimM9OT6c9wHJmT0zfZ5YtXRgPhzEOHGp/gSUFBP53PLFlqr8RflOG5MJtMLESxCwo7
 aGT9NAgHniUdOpH5d0wwi9jNu6uGpZk2i39BJ93Kh9i/wboOCZWWSPvLb7BL7zsaMpet
 sNLBJ8KZkaic9CJSROghDwaHfRIB/D4JhwlWdO8XzBskrgNWswOc4yUaNu4jIoCyoIGV Tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1nd88hy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:51:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANHHZlN037360;
        Wed, 23 Nov 2022 17:51:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk6mjd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGlAeQ4QrOYv+6HQmLkMMc/R35WutC6AJz5iuvjgfGhW5h3+weFssmpy9xS0UJWPPyD1rjVW0FpSRaL//541tU2648SddVRl/uzO8Nj4Gt7SDRGp1nGPBxD73s8QP/GpFy55PBs9rDqX7T+lHAC5NBmyfkwkNqvsWyOkrfbEujHIwe1e9vvQssiaXFo2TgbQS+RwURDY1SM2v0dVFgNje9fMIaK1oPPco8wnb80W8Dxf8cur4LSJK2pL0TIps4NiHm8ah1FLawO7EdPQS3BIOKA7OXOijH19Nxc4yM9tc761qJKX8yRypvgAHc9BCKov3L7DPxYJla8fhV/YRh/H2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqC3g0s4eDcm9BzlQ5AdYtj2hsEyzZqesKP08ljzR5E=;
 b=Bwe0mBvCnhVPk7qER8E4ds5YLGHgz1ux8DtPl86ZdQgkiAw4zdIb9elp+VMy9MSty9EawxEAMkYt+C4TEJZ7xK0wSBtFLPqIkHUBdg6GaPpt8rCyeW+DEGshMK6AMHazRfd49LrH7szzWF1+9iGT02iu3OwODOlMXr0Qx7RQ0zKjHWrCKmNEf4ngGu+rO5TCr8bPeaAvfES9YIvymLWjLZFYMgvuVVI8XUvc4NUsM2WMxO0YMgPiQgFrfkSNSOhB9peIXPc38ntFcRQeR/Cu2rgdoTqZKh0B3Bak/f/MtGFuKUpEghkfCr68fkPmgdn0j3y8vJ6C8xQ4DIogodDf9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqC3g0s4eDcm9BzlQ5AdYtj2hsEyzZqesKP08ljzR5E=;
 b=MMZfx5GOAnNuOrvDHiptqhTJWXVsofxDXPlZpBI+CL+qsR01J22OK/XTWsklTqVgTQmnVmly0rdSQnDJiMnJgV7BaMxkvvQWetJu+/jyIMi3KxLChTizpD02S/dUyUfeb1DXa0Wp3nib1+a8wEVxO/TuLIOJqZjL3wMRzp2ddoc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 17:51:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 17:51:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Anders Blomdell <anders.blomdell@control.lth.se>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Thread-Topic: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Thread-Index: AQHY9gcBJU7eFYwcqEeGEUKtEHfZtK5MWxIAgACAoACAAAC3gA==
Date:   Wed, 23 Nov 2022 17:51:37 +0000
Message-ID: <90DACFB9-2854-4688-8822-936C6EEB1FD3@oracle.com>
References: <65115206-ec17-443e-8495-91661a2fd9be@control.lth.se>
 <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
 <A0F05ED3-14B0-4AE7-B4F7-82398033CA34@redhat.com>
In-Reply-To: <A0F05ED3-14B0-4AE7-B4F7-82398033CA34@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6613:EE_
x-ms-office365-filtering-correlation-id: 21e9e262-a0b6-4645-e385-08dacd7b5ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KP/oztZf2H32NVKahjTR/LGrdi5tDm/QjubE/YaE6ApStjPNF/+zVScZ8RCsPFNxyrbYFs66tZCa4XClowZlhM4Ax9ya7cJsH+3iGxu28LFngoWaOp+Xii/Gvh11qpo8z8MQwUcsijA6dH8MHVlm3IJVLatf/6OhKAZdHhQcfp8dJ0ecUuEOePwmmErBPEH8bt7ZEm2n8cF7iF2LSureaI7yPvlrytVmfiF5zNB/7z2lrl+QMsSyg7EfrxWRhap8MJJpcuWqK+jfqPiRkwK5McltXW8blokMDewXxI+SBL8Zazn/6qWb4r8uQerlXondHyeZfoIlAh5FG7lkH8GAbwuevY55C56FvpxSGssPIYA099oDH63hGqdvKZd+wwarZRkcTe3qIiSIr0BExtGmcXmWKUO74c5CuFM+KmUKjZgC+Rn8sMnRqzDwX0uCl7oooeidRZ13nZMAk2H52nsdcJBAYTzrwfadSDAS1hMTvgS1rGtylgLp5pe1n1NlLeOi5xfaUflJKW+ZAs5XlcN2z4ybm5q7T38F+KZCWAMR/mrrliUFFte3DGRuFpj6qowUGWLDPlXoIAcKbwmuc4Le0EHXauvo/fhQX+C5yZein31W+Ttg6UvO/XAHhiMk14OOAQPIrlHZ79TSuH7TbVLo4MTUU4LsE10VQ5c6WJrlMgz9BDBtCUbu6k3hIVzzxPVvftyNPKe/H6raR3Hnn71l0KPJQVvGUlNYkt9bt8m5fNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(66446008)(64756008)(4326008)(6512007)(8676002)(66476007)(66556008)(66946007)(122000001)(38100700002)(33656002)(54906003)(76116006)(86362001)(41300700001)(316002)(6506007)(5660300002)(53546011)(2906002)(38070700005)(8936002)(71200400001)(26005)(2616005)(186003)(91956017)(478600001)(36756003)(6486002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZPLPHitUER6EdDx9JH4zJ004oYs9XTwUJM3F+libmXBSOzEgNguTlQdiIbjM?=
 =?us-ascii?Q?/WCILpNMaT0Aud6+wGzrxpxJ0JWkOtGSWzUWDzj/SkMH1VY7QoIWXXV6oMlK?=
 =?us-ascii?Q?eCK8eT9bglfKFprMZMigYcGM5MYRBfP3W5szNkVRkCKJwk/+ILIunxBDfRwD?=
 =?us-ascii?Q?xrWloW3n29fLCfSA1SkA+4HMxYrNgjoOWURZJiQDnwM/tXXflq5esLGNrKMS?=
 =?us-ascii?Q?aXDBC2CzzeAkQELeIK076vIvC1Hdx310QmNyuthH8+qbCzsADbi7nWLQ196V?=
 =?us-ascii?Q?p1Y9WbOl1ZCoR90LQsawshfOyd3U1XpOJcuN8xLwT7NJlcpS+8AxBRX6aKRK?=
 =?us-ascii?Q?H8meMcR6R6Sv1GZ+3HwO+Y/RA8K5vrHF+8aMuinylALGEa2zxYp7JKR9pT18?=
 =?us-ascii?Q?JQ9Io1kdxJYdJ9jsX+AtQX2jU7ykAOD3ix1PVy4P9A4A2+We4q+21n98Z2Ge?=
 =?us-ascii?Q?iphya4l2PdruZp0jxfWh+G/dcis2AOcwm8W3V1C2l/MhlNqxq0JU54JpA3mX?=
 =?us-ascii?Q?ZQdsVY+Fhx4bLR6FsaCtbOSkz+CmrgwCLvmNlxyODdEo8vBXHjLrwGTUMSGm?=
 =?us-ascii?Q?7sRv0jc5yTFOIyJheKQICAeNCd4PHGFaAAalVh7Kv7n2uOs/lJYvhfZGHErp?=
 =?us-ascii?Q?klghp4NPkkcLj7TX4/MktSk+EK1F1hNj7KTW+qvCCCV50ZHJG+0o/AVEUZ3L?=
 =?us-ascii?Q?8u4ewVQPNVx9AsUm7KuCtxyhtOTRLfnw8X+T1ovK86N7Vz45wnmIZA8MfuFS?=
 =?us-ascii?Q?ihffr7kp3803y0dD6RpBmdiw2Ge1O/4ksTUbcErY55Yt741X1lWp4JEoa+nl?=
 =?us-ascii?Q?E3fMCprTgNYaSr3dEWro1d3zKrE0BVA84tHT+wD5oc5GHEhwaBpy3k2gDwhy?=
 =?us-ascii?Q?5PC681ui2MSCGmj01c8BHeY2JP3Vi9HnglxhvNNC6isjM6QcaMcdA6IyaX3x?=
 =?us-ascii?Q?oyqgCJjQRB7TtqOYrBMquKDGEfhwC2PVQifJpYeTveVsb1rP0oJsKt/2KWle?=
 =?us-ascii?Q?y67qXDlkmI8ggpDV7cZWoLqLlgPF5lmObAbO4YFSbh4eseUB4/wZKv3yYite?=
 =?us-ascii?Q?p1vzO6iJK+lAav3rsHzqv8zVuPCX2tc+YbdEJrTk/6CB3L2Tz+TetzSz4S7S?=
 =?us-ascii?Q?sFmLCxKlHEL9MPBtCJeCJZ0QoPkehgG1ZZeA+9uEz7B367w+ceUJMj/iAJyA?=
 =?us-ascii?Q?qfa5JONiSV9XhuN6bpnvV6OdDUqGpPRkGoOAZ5vu67ttOMgaoAK8DRlmB/+C?=
 =?us-ascii?Q?VhvdIIpPJ5RnsFBM2CPPZQ8Yuc83/2iutFmQNjWyQYMrnNFDL4NEwSjL8/vJ?=
 =?us-ascii?Q?fWBHIM3hTsgvo/VxK++GGWIqEblNN2RzBijJQE039lmjF3twJw9swimhNREX?=
 =?us-ascii?Q?tL4liflOH0hFFNxBsTgtO0iGxnccIc9cSoQct5YAlH8QcgKag9hobTUmYU3i?=
 =?us-ascii?Q?cUtTjHRxq63pvnPdxLRgDT4dGI0H4x8ISuayYgtJ0hj7G4f2J6u6KTMhf4x2?=
 =?us-ascii?Q?zceinVcniAUyioPj24MND8op//VqSxJq+RisOACas0DuW2Q3jDkKH9AhnbBY?=
 =?us-ascii?Q?GIsAgHm2T/S6qBGKpbpG2qiSv91F4ZbfEiCtm4uBPYiGR6QNFBTcP7HLc2bN?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61CD80C92AC6744FBC8C1E961069D24C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s0b6vBvWq3id8Jmxl2MheJcCzwaHCyS+WL6bk0E+L1pOCDwl0bhd+6FVYmsC?=
 =?us-ascii?Q?Wtu7kaV1wSgIPhcr49qq3ia6BIprIKR4u8F5IRduVxik3fixJFDPh3hluUCj?=
 =?us-ascii?Q?uRJw5qJXaXM4UQxSrRNKYIGPGaFXXj0jQUtGHBICeNOblQNyueVFfs7maPF4?=
 =?us-ascii?Q?CG+GP92sZo7UJKD55kW6i/l6pgU4vv4Yv5kbGYUNKOTv3rzOzN7OK6tCEZDB?=
 =?us-ascii?Q?nv3oThI0A7Pf3M3CYD7nB7AIW4NqToO91cPG7NR4K5n5Lwf9kFyMYrDymIxo?=
 =?us-ascii?Q?YA9w8kuGrXGXkfnyKh7c9B9mfZREjP32P1lT4U8kMgAi2hP69knEA0ezceUS?=
 =?us-ascii?Q?pPxjb1LHRTB9QGITEqk1h+3WEGzknP8xOHPfAC76pqPNWyWsiXTRPaD0oMP6?=
 =?us-ascii?Q?WGT3nyCF4anuswmKG0y5L0TuQrLBSewp5VGxrSxQgsxIkoils1uHu4A7TkFT?=
 =?us-ascii?Q?OcH7P6jKc7lZWuWJqa+xcN2J40DvfKJF3gvetN4tx8/THzCYuVWew1Ms4eaE?=
 =?us-ascii?Q?CIpMiv5zk+3kVH56znnRzHJEy/ar3L1bz1nsUPBGmzx79wE5nAI04TtPUwOu?=
 =?us-ascii?Q?CrUc+6dnfQTV2N8IpPCn80BOUv+l5+3vZdntOYFxn2vzziUwhIa8SJKER45s?=
 =?us-ascii?Q?5TT638Qh2su0R/JogJlDBS9NsDdvKfzSDBk5bTGjz04xreENWnlZrlpqUNMI?=
 =?us-ascii?Q?GhVI96QwIal+3effS+iDnztHpSI/t6l0kKcynOzuHfC9IPU0FcAbOUPtk0Tq?=
 =?us-ascii?Q?Rb13vAjrQIXDxGDizEnTGacGWAz3Yxn0qy+mj5aWNoF1h8n35Lin49luJ/fz?=
 =?us-ascii?Q?/xmVS1WxzUJdyjkcy/Yd/Xv4ifgsy/SAm6a1hl2ySW/k1VYU09+6NYX3BvM4?=
 =?us-ascii?Q?PWlGvsANa6RvHpeRSN8kkh+OCyHUdqCW3tY8o0OEiYTGILKnXMWiWf7at1LN?=
 =?us-ascii?Q?JLMsetDuAurfBhqbndM6vGGOV+aPWctlG94MoWQGoNNy/SeSfnXIwi6o0IxF?=
 =?us-ascii?Q?tCHpY6hmbFmBM1NwrZq5QGoBdA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e9e262-a0b6-4645-e385-08dacd7b5ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 17:51:37.8856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKFScRy3tqtLjMWdLgkMNeBFxMZwZjVcJEdCEIdRebibSQ8gida7xLw69GuKvb9H8xUk0U5vl47jp8yqxKzmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230132
X-Proofpoint-GUID: E-OnRJt15Bnb_Z40AJlx0OeWaMK99Hr6
X-Proofpoint-ORIG-GUID: E-OnRJt15Bnb_Z40AJlx0OeWaMK99Hr6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 23, 2022, at 12:49 PM, Benjamin Coddington <bcodding@redhat.com> w=
rote:
>=20
> On 23 Nov 2022, at 5:08, Anders Blomdell wrote:
>=20
>> Our problems turned out to be a fallout of Al Viros's splice rework, whe=
re nfsd reads with non-zero offsets and not ending
>> on a page boundary failed to remap the last page. I belive that this is =
a decent fix for that problem (tested on v6.1-rc6,
>> 6.0.7 and 6.0.9)
>>=20
>> ---- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -873,7 +873,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, stru=
ct pipe_buffer *buf,
>>        unsigned offset =3D buf->offset;
>>         page +=3D offset / PAGE_SIZE;
>> -       for (int i =3D sd->len; i > 0; i -=3D PAGE_SIZE)
>> +       for (int i =3D sd->len + offset % PAGE_SIZE; i > 0; i -=3D PAGE_=
SIZE)
>>                svc_rqst_replace_page(rqstp, page++);
>>        if (rqstp->rq_res.page_len =3D=3D 0)        // first call
>>                rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
>=20
>=20
> Does anyone have insight into how we could possibly have caught this in t=
esting?

Was also wondering this. I had though fstests (via fsx) would have exercise=
d
this usage scenario.


--
Chuck Lever



