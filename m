Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3C625E49
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 16:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiKKPZ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 10:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKPZY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 10:25:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF658655E
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 07:25:23 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABFK79e013637;
        Fri, 11 Nov 2022 15:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PQc4b5cmtsKRwZNk5jVnSoOkKcwAYlARE5ZW11k+Vx8=;
 b=DE719tSdnCWMw3JofajcCzSVFVaunO0W+S8Yt5ZmhtnJ3Vv2hzz5X6+4zPX9ZerPYOLh
 fEbbnzyR5fJMz3/PnPKw2HNibFhUIpR/kaGtWXCv+U3RKOcRylPCaFQTr8+87Klj/8xy
 PHkGEfyuSHJJfO18npO1gGtGPvJutJVadsj1YeQYaV7RmNmA1zv6za7I3foSUsVbd0C3
 bkmMwZyTmr4LEpg766oK4zRCklaojQuD3PDsgvI/k0zHfrlogSqI7/dokqQhlBivoMMP
 z3YnQTLp1WLaGFm5sXA87VyA4MhQBUm+jiSiA0y6R+ZAtZnB4/qxSCBz6bWvBwk0/KtL hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksrxm80mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:25:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWp4E022383;
        Fri, 11 Nov 2022 15:25:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcytfbwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0ac6iCOTZPLJSy0gZJAAInNBn9IgKVS9JFiuGlQpZQEthTEDjMjTnjTTRzU5PJC7a0sT3ZA/HGZhBWExAnBUfOjiMqOPgXqMQcODNXu+UTWUp9HmC+qTebWbBV+NCoun+t3r4ufmLolft9R9OSODFx6OrNSwDTJNDLn2trzMBxVL47qeMBeIFfTYmXWucVZGKRfIvj2lMn0pHWU6dCS2T45qDOtJhL4WUtoEVmnmRFq6/nv6196FQuTpbnBGjOkUgu/DtW9tyaPimH9eai59pAKJWCnWhk/4YkKthzOiD8eo43HsKxnu5kGMgS6keuRr9++fcPMM3yjeYUu3VYUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQc4b5cmtsKRwZNk5jVnSoOkKcwAYlARE5ZW11k+Vx8=;
 b=Dlhdfgijeb+V9DVUX1k8I3fIAMPpj/3/vw0FtdkEudPk3KqDVB17Djh9TwzrVXyFfuP+nNX6RbeaKgjFs4K2MdHVQ/bFw6R1XqF3usl0lxZH0QiAJqdi+Fcl32x5PGP516jz6drWNE4A30J65DeQbitS5pDf0H/uzTa9gW1Ra3rdgT2teFrz+/cTx7jooTBMjUeHy145o6rRBDd8sWqGhef2+Fjjyj6N+XxEmldeRHjAfrkI6knfhjIv0IIsM5jsFnZKdIvDvQyRVN2tRm+O9aiF9ByYu9TUgymh0095sXJr9sqrd04/jxASBf+q9Jy1UL8HITxcyXmdtL/FcWedzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQc4b5cmtsKRwZNk5jVnSoOkKcwAYlARE5ZW11k+Vx8=;
 b=r8LlVBQpnReBvorqPUUjsDwju8lIkeoz7OJZ4GtYQaaT3x59SaJ8LzqG2oTd/AZm8TmlFVel2KKQUFR7tBmM3QPA0ErwcPnN0sjN7uZsdZWS32g6Fleg7u9/12/5qjdZAznv1rXpVvmslKn1pp8GZ8/MydLJpKqpBKbtNP4RbYY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 15:25:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 15:25:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] NFSD: add delegation shrinker to react to low
 memory condition
Thread-Topic: [PATCH v4 2/3] NFSD: add delegation shrinker to react to low
 memory condition
Thread-Index: AQHY9LtYnjX9QlBWgEaSdHqVc24UL6452iIA
Date:   Fri, 11 Nov 2022 15:25:16 +0000
Message-ID: <B311BC62-A485-47EE-86F3-0C17AF119C12@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
 <1668053831-7662-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1668053831-7662-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5680:EE_
x-ms-office365-filtering-correlation-id: 3a6e7333-f3aa-4223-53ad-08dac3f8efc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgBZ+/yfOx0EIO599Y3PGUV2dJfGBj0X0RaEe7BR1vXGouDonEUrRxC0SlfpLnOoEPrY3rJ36559J4TiS1mrbR28Ta/GPyMA0V74NZyjYJgvN4kqN5FZf1N60yb/z+rmEnRDhQLToH7EqI5rEDtaIBP/VZmqZWSyzlEI5wdYrjbVWcgT5Gwd+h4fDOW5n3Tym+ORyrB0qJU0Ulh5ZTr9EHakaLBjEW24jfm3UizGqgAkLVofAXAFJrK2pIOPa4lQWws0z1JFKFdLGXhZtpP2qnhpxN+dxAWddiqdudQ11l8qB2qRssGBsWLTGRWj8VCQBXOYTAsQ8xtea/8qJ/SoBHSCzJKrxtgkq5cKjdMEfhkWpE34avKJ5ELQpYF6TsihWPW17vhz+XbMWvATCOpiudaCx/vuNLnzLkTtT+t80i1Uxi/+CA5WXkFX5NbMvDiZc8O1oRZxvypjK3v5vVLJYcpOLUbqaCPa3eekxlJocWxqf3eMwrRil8hwkjewi/rMGqoOnx61z+Vv9aoJFTNsoVmb68i0YHGc556JR5aPTQXcYcZjhSKNeEwoNk23DIMy1S+XvSfFmifZ1eouJZwehU/M9scmdfsUJ7LnSZPF9u9J7H+sUXB+cpOKsqMwb1wiKV8JAvBlvQpWifgSLoDkHpSj/6QiCO/asl6eRTNvxrpEs60w636mtHlyEaYgtrQH1c+AQQqX9DHiqrSgHQVeGrQDthKWbcKoOH28FxgHFEUFLymbGm7OAgYcryo64x/l0BG5LKiVUetEckxmplvQVlIrbdieHT+y84bXTsxe77g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199015)(38070700005)(8936002)(41300700001)(5660300002)(8676002)(4326008)(6862004)(64756008)(86362001)(2906002)(37006003)(54906003)(6486002)(6636002)(316002)(66476007)(66446008)(36756003)(91956017)(71200400001)(76116006)(66946007)(478600001)(186003)(33656002)(53546011)(6512007)(2616005)(83380400001)(38100700002)(66556008)(6506007)(122000001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mb8c2FNkeg30cXtVf/O/7JSHpV2MsoTRFobnvfdsi9mIiWl0D3KLYDBqjh9C?=
 =?us-ascii?Q?0GXw97OiwQDHs6QSxUBfUbeILP5CY5Pzawg+GM0xyzCAZvDM4aAVpbdVUOTw?=
 =?us-ascii?Q?vaOerq7qorU+s0KeO1IiG0KgHQsaek+fu8gEBB9nBNPDrVYz7UyrJHXLoIq9?=
 =?us-ascii?Q?o7/hlgmSMMkHYNRLoV3adahq5iseuM0G9XiHKYxAvhbKKB69lyQl2NcYdrSb?=
 =?us-ascii?Q?H2cIQ0dpljcRODoQ2c/81N8RUTfaF/VQzJYj3LJol3gwhnk598VLF+/yCorl?=
 =?us-ascii?Q?JgstxFEeGrklHMkI0yiOWotg/PbpXh2CvNg6e7ojxtGqehKKeZNlZpEl27xH?=
 =?us-ascii?Q?DHcj3r4TlEDlB6gzrx4Cz4lxHmtwOcXA/XvNjm+zp2+VhQ+/pPV9VBwbg6jL?=
 =?us-ascii?Q?7evpWMOZGkD1TrdSHhkP9Q263CtyxW9B2SVqnB6Lsgeu3JrmSaARcv8dQM8E?=
 =?us-ascii?Q?dol3Y9TmNEsKsHXe8cuGIvlJbTRRy62RzsnOAU8cxjyx2RttcAJ0Q5HufAaW?=
 =?us-ascii?Q?l3HwNGES9M3IxEsxxJ5dDku/Bk/Obdw4+qSOW4ay8Y3w8LSc5nguQmTXYxt4?=
 =?us-ascii?Q?jM8CkDTbFmWSGshnIW8ydIMitFVqMnm5Rl0U6U61Iy54OaWLjcan5U77zYyl?=
 =?us-ascii?Q?BlRzFsj97rIZOwUvAPzgrFoOveD1aIOKrGS2+HRSznF3jjm0LNduPbj1POKo?=
 =?us-ascii?Q?Vmh66F8nETmLyW/he7ijSmpDG4ZgicUqUZvF5OJTk9ft+P0nAZClPJnHQfl6?=
 =?us-ascii?Q?8DZ1VnuO+eA6e6qV1IXQesRvQ6aestcj32kFBRLAEiNivwSUZV6m8IL+YJIL?=
 =?us-ascii?Q?RxTlVO3FR1wdYKsqQ2Uo0Zr62yaRR9fcHh+EHOwrcf1/xJcenoNzhV79IjB2?=
 =?us-ascii?Q?TY73OEMx97h66d+hP6UAoJdvBYtLIXSJSf6q7mHcvIIBIVHdh6qL7tnEFUFg?=
 =?us-ascii?Q?zuYMJpq3PC05/jVely10K1SQRQBcusm/KP9E3I0IcTF526CYnw2nQfy2eHrk?=
 =?us-ascii?Q?EVdWa/Tjjf3w1nUsg4ctObJUH5XBIvJlYvxTPPDxlgAoK8rV64du38iMLJPL?=
 =?us-ascii?Q?/fcaU/YRrbKkaR/Ie07GLvbUyy6NY5lokZJ0sq1rkso6pS30KO5NiHlAEB33?=
 =?us-ascii?Q?/0ADhE85lD7jrWqVLvWl9b/HnRRrEODxaGx/mjJDkF/NhgwJ/jnmVbbYvpzV?=
 =?us-ascii?Q?vett/PiwAVO/b9LET6X+EKI65ICDC4J96p1TY4UrJUup81QQdq46gQSVuOrE?=
 =?us-ascii?Q?VB+o+956tltxvETGHDO029taWsVdkoSPj4Dpk5GzL1O6Y8dAw0CbibQ0idn7?=
 =?us-ascii?Q?WAJeGlC1BHs1MPn2ja6xNWsMltqo8nFnDSMFcuslbr8lgyE9eG/jlbquV3PS?=
 =?us-ascii?Q?x0VTzNLAGnUb32Xr6voGOr4rZUxxTr8atUWQkXeWIkPvzhtEUHfmRbrXrhif?=
 =?us-ascii?Q?+UZz1IqGDrWQUB48RtcqSszXshxbkqzsIHTx+vDyWtMBF0Zfo+rdoYRPO/4K?=
 =?us-ascii?Q?caV4jKHLKjoML4HuSIV5DAym9KywD5F1KdMzZcr7ekCbt6YVcMC+j2qS0Ct4?=
 =?us-ascii?Q?FzM9tB4B675EijnPoBOYbYMbsGl2OMcWcZdXNexDsBsOlOfL2/3TJpVuGB2F?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02088CB5E59A3F4381785259DA157461@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +H0AY3oqU0gNYiNxdEyeka7cpNSsEZ/lMQvJNsqW8tZqBRr/F7TrfkDC8etc71n+QveKWajvkwdu0XHXcTNTHIBdNKzhNZlqHMCtaR79ZYobCih4RYs9PjxSzEUeyahaTdXy3kKMsqRiEuX1MW2+13+BYkLrMGPEBO4+9d3AOl10eYR7ESzxgdLJSB2irtqh9IXacdEJddUs4/LvS27vrYRWMq5QJfnXTUQM5cFxzmXS0JfjehTF1aOKBTJOkwnnhQX3OwWPuEeeQp8+A4nQq80hsMZLzO9xeZ/OTnT5gieyrS7YDv143zFCJyv0TtDnjcRu+f3l75Ulb/K0lMK8gRS2VC1zSaKGtpGhPmGBTjpbhWoniFPvUB/ix8jKypbqCNw9y86GtRN49XhyemyfaKGUdJjak0Awwm0+Q5p6pDd5XSsU6k7b8QHM4tzHfaqfGVRR1cIJvMylqIKrcI4XI3gUx9W1mUiwMLPqA/l+CwpUNmwNRR4imS9PW85VeY//oEVIMv8cpWgsgsfkbitvrIWz4xFmmNF+Vw5jse3QLZ9MvyBkjFdbWYRjo3pFej07LnFoT9pNgTDK6DFFHlMl3cjQOE97AV4lLeELEDw4rSFdDEswW3Ygg03hpYWRxyA2oYvuHrT47ARuRNf7OllH2xuGf+8/vtJ+qXoh61UiT/t83Pd1WOaQQ8CaqfcvrsjtOe44PxojCI8V94hu2CEu/x/azSxVs61LYx3w5PvIUj3Kq4gQDIFRxLACAH9lmgBWBQ4OMV/AnJ/h0uO+1YIaJF+koZrw37yqt80MtPgzMSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6e7333-f3aa-4223-53ad-08dac3f8efc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 15:25:16.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ez8F9MRTDR458M3LK/J66bx3fddCMk9rJdjKnWXWu5sJinXMkXKWquu5bJ2iaEI/NfC+FYUYPUESFXwiGleE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110102
X-Proofpoint-ORIG-GUID: GtfuJp0AbAciC97HVtOCulupkDO1xCVE
X-Proofpoint-GUID: GtfuJp0AbAciC97HVtOCulupkDO1xCVE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2022, at 11:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> The delegation shrinker is scheduled to run on every shrinker's
> 'count' callback. It scans the client list and sends the
> courtesy CB_RECALL_ANY to the clients that hold delegations.
>=20
> To avoid flooding the clients with CB_RECALL_ANY requests, the
> delegation shrinker is scheduled to run after a 5 seconds delay.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |   3 ++
> fs/nfsd/nfs4state.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++=
++++-
> fs/nfsd/state.h     |   8 ++++
> 3 files changed, 125 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8c854ba3285b..394a05fb46d8 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -196,6 +196,9 @@ struct nfsd_net {
> 	atomic_t		nfsd_courtesy_clients;
> 	struct shrinker		nfsd_client_shrinker;
> 	struct delayed_work	nfsd_shrinker_work;
> +
> +	struct shrinker		nfsd_deleg_shrinker;
> +	struct delayed_work	nfsd_deleg_shrinker_work;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4e718500a00c..813cdb67b370 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2131,6 +2131,7 @@ static void __free_client(struct kref *k)
> 	kfree(clp->cl_nii_domain.data);
> 	kfree(clp->cl_nii_name.data);
> 	idr_destroy(&clp->cl_stateids);
> +	kfree(clp->cl_ra);
> 	kmem_cache_free(client_slab, clp);
> }
>=20
> @@ -2854,6 +2855,36 @@ static const struct tree_descr client_files[] =3D =
{
> 	[3] =3D {""},
> };
>=20
> +static int
> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> +				struct rpc_task *task)
> +{
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> +{
> +	struct nfs4_client *clp =3D cb->cb_clp;
> +	struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
> +
> +	spin_lock(&nn->client_lock);
> +	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> +	put_client_renew_locked(clp);
> +	spin_unlock(&nn->client_lock);
> +}
> +
> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops =3D {
> +	.done		=3D nfsd4_cb_recall_any_done,
> +	.release	=3D nfsd4_cb_recall_any_release,
> +};
> +
> static struct nfs4_client *create_client(struct xdr_netobj name,
> 		struct svc_rqst *rqstp, nfs4_verifier *verf)
> {
> @@ -2891,6 +2922,14 @@ static struct nfs4_client *create_client(struct xd=
r_netobj name,
> 		free_client(clp);
> 		return NULL;
> 	}
> +	clp->cl_ra =3D kzalloc(sizeof(*clp->cl_ra), GFP_KERNEL);
> +	if (!clp->cl_ra) {
> +		free_client(clp);
> +		return NULL;
> +	}
> +	clp->cl_ra_time =3D 0;
> +	nfsd4_init_cb(&clp->cl_ra->ra_cb, clp, &nfsd4_cb_recall_any_ops,
> +			NFSPROC4_CLNT_CB_RECALL_ANY);
> 	return clp;
> }
>=20
> @@ -4365,11 +4404,32 @@ nfsd_courtesy_client_scan(struct shrinker *shrink=
, struct shrink_control *sc)
> 	return SHRINK_STOP;
> }
>=20
> +static unsigned long
> +nfsd_deleg_shrinker_count(struct shrinker *shrink, struct shrink_control=
 *sc)
> +{
> +	unsigned long cnt;

No reason not to spell out "count".

> +	struct nfsd_net *nn =3D container_of(shrink,
> +				struct nfsd_net, nfsd_deleg_shrinker);
> +
> +	cnt =3D atomic_long_read(&num_delegations);
> +	if (cnt)
> +		mod_delayed_work(laundry_wq,
> +			&nn->nfsd_deleg_shrinker_work, 0);
> +	return cnt;
> +}
> +
> +static unsigned long
> +nfsd_deleg_shrinker_scan(struct shrinker *shrink, struct shrink_control =
*sc)
> +{
> +	return SHRINK_STOP;
> +}
> +
> int
> nfsd4_init_leases_net(struct nfsd_net *nn)
> {
> 	struct sysinfo si;
> 	u64 max_clients;
> +	int retval;
>=20
> 	nn->nfsd4_lease =3D 90;	/* default lease time */
> 	nn->nfsd4_grace =3D 90;
> @@ -4390,13 +4450,24 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
> 	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
> 	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +	retval =3D register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +	if (retval)
> +		return retval;
> +	nn->nfsd_deleg_shrinker.scan_objects =3D nfsd_deleg_shrinker_scan;
> +	nn->nfsd_deleg_shrinker.count_objects =3D nfsd_deleg_shrinker_count;
> +	nn->nfsd_deleg_shrinker.seeks =3D DEFAULT_SEEKS;
> +	retval =3D register_shrinker(&nn->nfsd_deleg_shrinker, "nfsd-delegation=
");
> +	if (retval)
> +		unregister_shrinker(&nn->nfsd_client_shrinker);
> +	return retval;
> +
> }
>=20
> void
> nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> {
> 	unregister_shrinker(&nn->nfsd_client_shrinker);
> +	unregister_shrinker(&nn->nfsd_deleg_shrinker);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -6135,6 +6206,47 @@ courtesy_client_reaper(struct work_struct *reaper)
> 	nfs4_process_client_reaplist(&reaplist);
> }
>=20
> +static void
> +deleg_reaper(struct work_struct *deleg_work)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +	struct list_head cblist;
> +	struct delayed_work *dwork =3D to_delayed_work(deleg_work);
> +	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> +					nfsd_deleg_shrinker_work);
> +
> +	INIT_LIST_HEAD(&cblist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (clp->cl_state !=3D NFSD4_ACTIVE ||
> +			list_empty(&clp->cl_delegations) ||
> +			atomic_read(&clp->cl_delegs_in_recall) ||
> +			test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) ||
> +			(ktime_get_boottime_seconds() -
> +				clp->cl_ra_time < 5)) {
> +			continue;
> +		}
> +		list_add(&clp->cl_ra_cblist, &cblist);
> +
> +		/* release in nfsd4_cb_recall_any_release */
> +		atomic_inc(&clp->cl_rpc_users);
> +		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> +		clp->cl_ra_time =3D ktime_get_boottime_seconds();
> +	}
> +	spin_unlock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &cblist) {

The usual idiom for draining a list like this is

	while (!list_empty(&cblist)) {
		clp =3D list_first_entry( ... );


> +		clp =3D list_entry(pos, struct nfs4_client, cl_ra_cblist);
> +		list_del_init(&clp->cl_ra_cblist);
> +		clp->cl_ra->ra_keep =3D 0;
> +		clp->cl_ra->ra_bmval[0] =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
> +						BIT(RCA4_TYPE_MASK_WDATA_DLG);
> +		nfsd4_run_cb(&clp->cl_ra->ra_cb);
> +	}
> +
> +}
> +
> static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *=
stp)
> {
> 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
> @@ -7958,6 +8070,7 @@ static int nfs4_state_create_net(struct net *net)
>=20
> 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
> +	INIT_DELAYED_WORK(&nn->nfsd_deleg_shrinker_work, deleg_reaper);
> 	get_net(net);
>=20
> 	return 0;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 6b33cbbe76d3..12ce9792c5b6 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -368,6 +368,7 @@ struct nfs4_client {
> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
> 					 1 << NFSD4_CLIENT_CB_KILL)
> +#define	NFSD4_CLIENT_CB_RECALL_ANY	(6)
> 	unsigned long		cl_flags;
> 	const struct cred	*cl_cb_cred;
> 	struct rpc_clnt		*cl_cb_client;
> @@ -411,6 +412,10 @@ struct nfs4_client {
>=20
> 	unsigned int		cl_state;
> 	atomic_t		cl_delegs_in_recall;
> +
> +	struct nfsd4_cb_recall_any	*cl_ra;
> +	time64_t		cl_ra_time;
> +	struct list_head	cl_ra_cblist;
> };
>=20
> /* struct nfs4_client_reset
> @@ -642,6 +647,9 @@ enum nfsd4_cb_op {
> 	NFSPROC4_CLNT_CB_RECALL_ANY,
> };
>=20
> +#define	RCA4_TYPE_MASK_RDATA_DLG	0
> +#define	RCA4_TYPE_MASK_WDATA_DLG	1
> +
> /* Returns true iff a is later than b: */
> static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t=
 *b)
> {
> --=20
> 2.9.5
>=20

--
Chuck Lever



