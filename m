Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8123A67277E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjARSx3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 13:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjARSx1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 13:53:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF60A59B5A
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:53:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30II4MUh004550;
        Wed, 18 Jan 2023 18:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rQ0sqSWqXiH+D2qGPyAzn97iHKWMASKKm9UpK+Joj/Y=;
 b=q3JCmHx9fQC7UtQ2X5mytjV+XhNhR3FRIslO6vGmJt196GwFzJce/5ipvlmWMI4EnS+N
 7TmMVseFpLkHRfz2/hEJSpjRxiu77LkzSxkEN3TDlSFKgu3G8xCKBh9yujLHV2ab9/Ip
 jzpYnjjoXmmBsbIHz1Wtqwz8OYf2J38fW6z1IQ1j6mv/LApimwrN9TvwKJym2vdvspuQ
 rXlQSB73PB6foJiY1waB9iINpdY9jOwhvHg7ApafJTRLxDfCgPxh+YtA142tHbe3nLsD
 kRCMLFhuMCMsaktt6kSAXX4j7W9xJBE7kSnvmOAuNLG1jPXv+qYEnN93LB8ORMFfgxP1 Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdftf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 18:53:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30II8hHe020189;
        Wed, 18 Jan 2023 18:53:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6nst2084-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 18:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2ri/QBunbuXAUXvjVOnzv/8VLv/jq9e8Xnn8YDmP3Jfv+oG3Dx6fxyysNXWQzLYH/Km+ZW2M3H5kdbb57CrQyKyXyobGt/ZnTzFny9h/bMoa4QalHgSKFW2WXUSvm7tfXdraUdmt/8V60aSvv/NT5T4kbMVn8FK3OuEu6u0NxP4UntFgWeRbczJBnddjVa6exC9iUcdAhnA/DiCVM9MPEzaCZZH1HkL05hhzjNFRo3cpGNQrC0iTxgifzwgVjcerMtkcoehHbHSRuSbqabJtklkgpsp7G4AcWI5XM8IHyb99DDMmFRFF6Bnc0Sk2w1O23wwa8jAbizZMIuQoYGqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ0sqSWqXiH+D2qGPyAzn97iHKWMASKKm9UpK+Joj/Y=;
 b=PxATgNGjxxZTN6eBJ4cKWV/2/4mxNC7chHr6RQzh4XN+ycyWrhR6j8V6onSqA3t1IyWe4jbLpyLAzeGSJorKxRVgLJ7++zuwwHUycGTnr5I5WwuoPYdH2K8x7kiFPJqI39ada+DH0G9J6XJQgQCYhz3FHfI42MaK91nv7A/XnwvUh3OZe730wJH2sJg+NwDAbuNHEsHWaKxZz1wV/bFrTIpEI0YLVOeoZ7IEhwrjZJe3ZM2Vh+wM8A3ul+jy3Hizfq9jPxTb/WGgnXjVbJP5pOmAnRP3wNa1KC4DDRi65ZolqirwT70uNC7VexMQpiUjxnrjiNKxXN021iQ3Wofwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ0sqSWqXiH+D2qGPyAzn97iHKWMASKKm9UpK+Joj/Y=;
 b=owQaxzmhOjRM7zt4fIZyDzHqi27RBZ2O0LIsSltrgCLTuG91vE5U9qEtM5UTf39mLWaRJ1exnuf2MnLd5/XQK3ZQ0ev2Rg4RglF+scaTNBbiGFxTqJnYxeeYNpO1+eYmYFoUUwR8uXNyoQvfOj79jGDrf+4uMTt27gB7vs/6r9I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6525.namprd10.prod.outlook.com (2603:10b6:510:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 18:53:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 18:53:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/6] nfsd: don't take nfsd4_copy ref for OP_OFFLOAD_STATUS
Thread-Topic: [PATCH 1/6] nfsd: don't take nfsd4_copy ref for
 OP_OFFLOAD_STATUS
Thread-Index: AQHZK2K9IXbuXawJ8ECZcmttxfv1rK6kchaAgAABfICAAAWCAIAADGKA
Date:   Wed, 18 Jan 2023 18:53:14 +0000
Message-ID: <51D89D69-F23D-44CA-81B1-B7ECE34F9D34@oracle.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
 <20230118173139.71846-2-jlayton@kernel.org>
 <CAN-5tyHgYpGBaJYB932VAqyMGSMikexA=0uKTzROtP9nw=Nu-w@mail.gmail.com>
 <944bf7f3e6956989933d07aabd4a632de2ec4667.camel@kernel.org>
 <CAN-5tyHnhk9sV-jfnDvQ66brYtqY7NPvsq3D1-hWe7vYUxjgUQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHnhk9sV-jfnDvQ66brYtqY7NPvsq3D1-hWe7vYUxjgUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6525:EE_
x-ms-office365-filtering-correlation-id: 2d1658a4-d356-4d65-a055-08daf985414c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rU06vhZD9CRqEpEi86kaFU9rwffsxqcRy/hABpYhYHm0JNci4RlNM/zmzU9oy2Ac5os3FEW3L9vSSHaqN2IPdYcX5Rx2S5t3I6tLhowcn930hYkzlbVUt3Bz+wPLMZ/NsvDS6F0PzgLQnSeFYiq/byyAT8GlLz5QLTuHW8B9PXmjNnfFdNc9VrOEvDpGwYIg9a2En2ObARO+ebvA2G8kSRqvKuI+iNuQ5Kp5iLesvNASq5OtK53yVP0lAwRVZFOJ5+kYF5wM7F2CWIh8SyKUy4xED+tS3FfYiMi1/IZWMVmIrphu/EDSjUytbOpCmYWeT1FSNQe3d+tP0DdwdBAN/Tbz8Eumq1KIeB3mbEZ9lfMcUpRnAFFECQ5BsEmTQBHGA9YAKOnqtgjE6rNV8ZxR1nWekRuU+EabwqDdQWjYX95U1A3Kbxz6Q1c1rTA6jMGWaqe/KHxsmSg8Z5opOFP9SaWk51wlmxGlHOHePhJM/RG5PzbNZrDMI6+zL+vhX3EY+H+l3Zpf72cT/RR/pv6r1hQw4zSGWl32t8CZvyL7QxiYu1An5F7376iVlAjD/Cq+us6y0hVQm4aUa4llxXnirhflJF6RNnbrUkwsa1ToR8cAo+Cm+POiJ65pp43cIcoE77tyaOovr8hkusEcZ41nyJUYvRlSycpNKFmC2BL+Y/VTwxDjW6fEILcP9HAoBAXpDxKoIVTASo0JFSkurvhmzFzwLWtRpPc3Qth63IFirlRlCkkwyXdkksPxiQ214MSyg34lI/R5YmNxLpCVtblOZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(66556008)(66446008)(8936002)(5660300002)(6916009)(54906003)(41300700001)(91956017)(76116006)(2906002)(66946007)(4326008)(8676002)(66476007)(316002)(6486002)(64756008)(478600001)(38100700002)(122000001)(26005)(6512007)(6506007)(36756003)(186003)(53546011)(33656002)(71200400001)(38070700005)(86362001)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nhh/w10HP0+1+F2bPNnEnwnz35crN1EzMtJszkjLfYNN7zkn9JbPi4kvJvj8?=
 =?us-ascii?Q?1HsAIEKXkk76gtr3hvmmMTnl0MdobxCd4KeY+M6lmC0yGxmA4VLvnxl7rGX0?=
 =?us-ascii?Q?nLcdzRlT9gRtNFMiXxW4oH+j096aHmyYZkGJ4nvWaSuoPYpVq/dTNSt/JCSp?=
 =?us-ascii?Q?IJWm0a4ypb9Nvi/9/wEC3DXnIlz06xWCcNjHKw7PVD+1lzjGH3HquZA8Ixws?=
 =?us-ascii?Q?R+x9vsTuY+ATtTAbIJwqY2KFcBRU0mPBp+vsWCfozSFWrmWmNPJP04UIuS3W?=
 =?us-ascii?Q?oBNVdgGKRC7XBO+SNSX0ShDb3O4wL2U53RRFYu4inkmXOBHPEb5VzKWq3/uS?=
 =?us-ascii?Q?W6pczCv+4A3SB840H5i2+FStfbAjHLDk9TQC/EvNnxTmKEChT0IBxSS4dM61?=
 =?us-ascii?Q?bkoK+Jl5bvItYBnB83JO6ElYIA9GEH4NYfdmu/HoKHzrloNG0ytZrFd93fET?=
 =?us-ascii?Q?2E7uguTvEGsHC3kfLmVmRX1/MpafHwClSkutXuvHnJqcJhmhV0BzspvTgVbV?=
 =?us-ascii?Q?kQt+0e/a2SRzXKVPsqJLrOS251yOJP2Z6Zcw1FAtz/yAmd85b1iQbK4KlvZu?=
 =?us-ascii?Q?i8aT5I2IZWWN9LURRHOBnVx/8Sk6HPrBiewtr8hgEFxDi9k4gpIvaHhzrUV+?=
 =?us-ascii?Q?m37SGUYqSaXvfEp8P5cCGa8Qtw07CNlYe/hAAbBWQp39VOSx3PyCJkKoA91V?=
 =?us-ascii?Q?eAB9PcRJaRN6bxz9Jj4qwUPN0ljr/ycwWnA3nEj2UVKL3dosZ6J68JmpHcUi?=
 =?us-ascii?Q?5mGThW6KQqBWJa9LH74Mgr2wWXZwMFwMMvC6Z/wY5vhNljVSd7cX+MPEZKyf?=
 =?us-ascii?Q?opOy/dEI9ALaLeAMq80hXTRwe1O/kdahwT1ad/4nu6jtz2h8aPbAKG57n6EI?=
 =?us-ascii?Q?IE4h/7QXYHzolXSrsIYcc6pQe1RPhdS6FMRzx1wxhQIldbof/HcktMVEq144?=
 =?us-ascii?Q?42f9SQNIk+TXa67Bh63CgkIA8g260NHLK535nEfbxDhTb/38PpRogwJz5VPv?=
 =?us-ascii?Q?IsUfVXA+6aRyPerYkztkxLVYUhvClxCOJ6jzFcDshATbSluxKnYUcS83PR2p?=
 =?us-ascii?Q?z6U/iV5QfnWjcGmh0P4bfTna6ay6WIpfaglBopFz2HN3hxSFPg7vGTNDKNHJ?=
 =?us-ascii?Q?NwK8L1qzGI3B5H6xiPQWGekcJZAqv0BgP1HXxaVWl6Q3EAPvsBCHdZLFw6kU?=
 =?us-ascii?Q?zfbUaDoRqgrq3cTD3AAKdzmhGvDe2lbl+weuXeX4uTETNoEpoKdEr3Czs0zj?=
 =?us-ascii?Q?xmypAuFUt1SUrhQ/1eqZQxk3VX7p/4wc6Mo5leu3vHvx/Szn5qMU9H876k+E?=
 =?us-ascii?Q?S2tSEmSftWPnOYBfdK3isOTHpYVM9buTcXcAkLBmhkYmLLO7CR/WMFLhzBUb?=
 =?us-ascii?Q?O5BILJoyMVmUAsEXy+PZOvtKAT4cblk5odOUreTagdBVb3U4abGrWcmOzaXz?=
 =?us-ascii?Q?SoxaWsNfFscvwhLF8ysehH5zMBrlPUw65cb9LviSVI1ZGfBOOkcHzkppEUat?=
 =?us-ascii?Q?9+zX0wscC/mGFrfV9ODWluQQcmEclDRhnINmT0ME3CU5gbM/ajqT1AjUgjJK?=
 =?us-ascii?Q?Qe0UGRY78L86pTcS3NnbZbnH+VoSVusYdb3Y5XRCzYuNSMyUHooI1zUGa6jo?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0592AA3791AD3845AE68F35FE1100338@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z6yPbT9Z9y4xRWFH6gW5kRpuJA8n5j5kZXatDUf+s1regELWaFwp+V9UBRvpQFvNSR8RZN69f2Ez4kBKBl59u4zYjjUnxYEQQ+7NX3EK+BNbLhSZpC2rTLoCoKA21YsDcEzQ2NpCkAaJbgfXSZAjmr7IeD79tpDlp8Xqkrd9qFudsyR65GyHmTTiLF2d0bC3MZk22oEc+7CXAtuHQyeDtmLcMX6V0ddGok6QNMKz06k4QbpnnsM7RvuVgHr2Ml95dNFYVD4IpGHQSuECl0K6xkjMwBLkbbNXWVRYbUIODpirKWu2En1k532sSiN6eqmaETFfJBX6tHFN+xrJKThmjXi8l7kWcIPV/aUhddqgGmb6BXuCJjzhv7gjP3oA184xASl3VNz/Qp5s+rpZ5uoO/E2He7iBLcXelmcxmvYROMlj7IJepsnqX6Pkbk1YrA05S2cu7t0+GcgOix+oEoBaKHkt8nJBmHr11ETmUMMXPupJH4kE8uUBPZSdhlQuHvsEsXcMxPjdmEv20ZD4tYkmMmG8JehtU3QxPUd3f4KDBhJN+ZFplorMB/Kb4AO2faqhYCotBfBycyUWOojFKeCjbf9/Mi0+PwSn3HFmGd8DyacgVJw4iCj7EYLRou8B9moaP9QzWAkP7orI4CagSClj6z6cdAdKfRKCu/nrB5sUD0gNHrQqg/ttBlu5olywV7OgyS1SxCe+24gbQMmKCBcm5cr6b6Pv1cOAT/S8rnFhGxbdRsi14lubhab9vZ6xdSOwVLxmJ2K/+hiBq6vHUxthiHS/GgLbiKYy821Vczk2mFVD8lysMWiGdhOFoxc3CTyn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1658a4-d356-4d65-a055-08daf985414c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 18:53:14.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3To8bIXVuDelM8Q19hiORTe+iBlNy9ueO28J9zT8gkawwZ4rH4Nzzhkubh559dROOGzl4BVXk9F4PqghYs6eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180158
X-Proofpoint-ORIG-GUID: 3eWcXjH-edUpJcpiIqBq4e_JiP6z2iMy
X-Proofpoint-GUID: 3eWcXjH-edUpJcpiIqBq4e_JiP6z2iMy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2023, at 1:08 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Wed, Jan 18, 2023 at 12:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Wed, 2023-01-18 at 12:43 -0500, Olga Kornievskaia wrote:
>>> On Wed, Jan 18, 2023 at 12:35 PM Jeff Layton <jlayton@kernel.org> wrote=
:
>>>>=20
>>>> We're not doing any blocking operations for OP_OFFLOAD_STATUS, so taki=
ng
>>>> and putting a reference is a waste of effort. Take the client lock,
>>>> search for the copy and fetch the wr_bytes_written field and return.
>>>>=20
>>>> Also, make find_async_copy a static function.
>>>>=20
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> fs/nfsd/nfs4proc.c | 35 ++++++++++++++++++++++++-----------
>>>> fs/nfsd/state.h    |  2 --
>>>> 2 files changed, 24 insertions(+), 13 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index 62b9d6c1b18b..731c2b22f163 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -1823,23 +1823,34 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>>>>        goto out;
>>>> }
>>>>=20
>>>> -struct nfsd4_copy *
>>>> -find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
>>>> +static struct nfsd4_copy *
>>>> +find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
>>>> {
>>>>        struct nfsd4_copy *copy;
>>>>=20
>>>> -       spin_lock(&clp->async_lock);
>>>> +       lockdep_assert_held(&clp->async_lock);
>>>> +
>>>>        list_for_each_entry(copy, &clp->async_copies, copies) {
>>>>                if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STA=
TEID_SIZE))
>>>>                        continue;
>>>> -               refcount_inc(&copy->refcount);
>>>=20
>>> If we don't take a refcount on the copy, this copy could be removed
>>> between the time we found it in the list of copies and when we then
>>> look inside to check the amount written so far. This would lead to a
>>> null (or bad) pointer dereference?
>>>=20
>>=20
>> No. The existing code finds this object, takes a reference to it,
>> fetches a single integer out of it and then puts the reference. This
>> patch just has it avoid the reference altogether and fetch the value
>> while we still hold the spinlock. This should be completely safe
>> (assuming the locking around the existing list handling is correct,
>> which it does seem to be).
>=20
> Thank you for the explanation. I see it now.

May I add Reviewed-by: Olga Kornievskaia <kolga@netapp.com> ?


>>>> -               spin_unlock(&clp->async_lock);
>>>>                return copy;
>>>>        }
>>>> -       spin_unlock(&clp->async_lock);
>>>>        return NULL;
>>>> }
>>>>=20
>>>> +static struct nfsd4_copy *
>>>> +find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
>>>> +{
>>>> +       struct nfsd4_copy *copy;
>>>> +
>>>> +       spin_lock(&clp->async_lock);
>>>> +       copy =3D find_async_copy_locked(clp, stateid);
>>>> +       if (copy)
>>>> +               refcount_inc(&copy->refcount);
>>>> +       spin_unlock(&clp->async_lock);
>>>> +       return copy;
>>>> +}
>>>> +
>>>> static __be32
>>>> nfsd4_offload_cancel(struct svc_rqst *rqstp,
>>>>                     struct nfsd4_compound_state *cstate,
>>>> @@ -1924,22 +1935,24 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
>>>>        nfsd_file_put(nf);
>>>>        return status;
>>>> }
>>>> +
>>>> static __be32
>>>> nfsd4_offload_status(struct svc_rqst *rqstp,
>>>>                     struct nfsd4_compound_state *cstate,
>>>>                     union nfsd4_op_u *u)
>>>> {
>>>>        struct nfsd4_offload_status *os =3D &u->offload_status;
>>>> -       __be32 status =3D 0;
>>>> +       __be32 status =3D nfs_ok;
>>>>        struct nfsd4_copy *copy;
>>>>        struct nfs4_client *clp =3D cstate->clp;
>>>>=20
>>>> -       copy =3D find_async_copy(clp, &os->stateid);
>>>> -       if (copy) {
>>>> +       spin_lock(&clp->async_lock);
>>>> +       copy =3D find_async_copy_locked(clp, &os->stateid);
>>>> +       if (copy)
>>>>                os->count =3D copy->cp_res.wr_bytes_written;
>>>> -               nfs4_put_copy(copy);
>>>> -       } else
>>>> +       else
>>>>                status =3D nfserr_bad_stateid;
>>>> +       spin_unlock(&clp->async_lock);
>>>>=20
>>>>        return status;
>>>> }
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index e94634d30591..d49d3060ed4f 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -705,8 +705,6 @@ extern struct nfs4_client_reclaim *nfs4_client_to_=
reclaim(struct xdr_netobj name
>>>> extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nf=
sd_net *nn);
>>>>=20
>>>> void put_nfs4_file(struct nfs4_file *fi);
>>>> -extern struct nfsd4_copy *
>>>> -find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
>>>> extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
>>>>                                 struct nfs4_cpntf_state *cps);
>>>> extern __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>>>> --
>>>> 2.39.0
>>>>=20
>>=20
>> --
>> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



