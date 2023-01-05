Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852FA65EEC8
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjAEOcm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjAEOck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:32:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9533D5A
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:32:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E497U021227;
        Thu, 5 Jan 2023 14:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vDNJR44jNLExugy7f0LYDjE78fPqgsdzT5f2LRSGKow=;
 b=yald2eKgMXGVQ/h2A7kR5S6vdu3N8iBBmGhDv1P20ReZ7Avx38fbRVMmdr3x/WwbcQhH
 3+RK9hScX/oVOb64MrOhkN+qYIokU1Ld/2IBqywrxXwhSpcL7EdwrbeaXRMHJ3uOCoh1
 D4s8PLR49RwcLdewBxvZg6UC5O1s00bIz5tpLKHPqpFdgDJMIBZV5b9lz5Dysgdnmwdl
 hUG1AYZW0jY8xgAgqrxSm1Wutwgi0JAChupqpRiWJ3Gp2xielY3cWq5HMAW46UEZGsIU
 pY0CeKcfW0LloeDdPNPLEMf2Cnk7dgBJeE6JxEeVItzBTF8OLseSrv1hTVdFM3d0/RrN rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya8v39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:32:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPKVs033840;
        Thu, 5 Jan 2023 14:32:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdts6qe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 14:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMBvkz71zq5V42PDF+lOxRzL1NLREX2JulwKTZb4mRc45Ra+iemKlBCMM55inzg7I39mL0QY23zxsPspDlhckCwLpB3uu3HkLg9zV6u9a/JpGaMiMWJzHf/+Z7pDejxcDR7VjviP02t43NP2eZJYEj/363cUyW0+T/ArBb8em7gAzK9H+pDpmFScnoPdBNiiqKTHkvdvl1OLoUwIVT0mFN86SrxuyLY/Y0Cf2lXFNd7G78vKGiz5Ytfbpgs1D3S37T6TBt3vqDMtRkzXIN+hhNv0+rGiRhEF5QZMpSjylQ7E5EYNSAVuVL94Ihu1UEZb0OprPgRjcdWd/4y4dMwNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDNJR44jNLExugy7f0LYDjE78fPqgsdzT5f2LRSGKow=;
 b=PK7zSRSzenS/exuuG52dSxt+jzTk1zorgI0uEYA7RlUB7J8S3VCFWNa0AmpTo3j2NgWOBS/FEh/FOUcOL3tcLwuxthaeLcpbLk5i/yKfaXPs8xs34y2g0D4oebDqQMAkLvFwL8YZUszFXQ5InyUu2P+yZx3uklB/AW4gu/F0HzJZCCwS3KHas3vZAfpTC3ZG/TCcQvSofVonJumdX3+WaMrgAzIPjQmQlB3x4o8uDk14yNh5RH3kNJ1a2I6NSwJeNVUbRIvZkheMmyWzHqB5LfurzfU6Nk98HeeLJLcp+FoR4a1ojHobqXDQjSKO5nVyIhwlKB1LMEAXoQF73yW3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDNJR44jNLExugy7f0LYDjE78fPqgsdzT5f2LRSGKow=;
 b=dYCsooscQ4nGxT1cUPYpOFpsQi2ZdOHuyXA/Iz9EpjPXmTQmq0reRVao1WDLXnlmTdyeVLOXtMSNYePi/evdLDuvrYNEk5yc3dW9XHt29zVOC5NS3aVh+PKXYpCzBF6eEBpBmf+vJSrMRRgZjxoEfojPCIR3SuAXMvnD/LdbjCQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:32:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:32:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed
 entries
Thread-Topic: [PATCH 2/4] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed
 entries
Thread-Index: AQHZIP9icvcrgLzObkKRs2F8ILhq166P30YAgAADAYCAAADQgA==
Date:   Thu, 5 Jan 2023 14:32:32 +0000
Message-ID: <1FC23D54-C9E6-49F8-AB43-271196F47910@oracle.com>
References: <20230105121512.21484-1-jlayton@kernel.org>
 <20230105121512.21484-3-jlayton@kernel.org>
 <22E267B9-BA8C-46BA-A76E-A7A72FA5D9B3@oracle.com>
 <cba5f0b6f13a314d78f7c767d47a7b6fac7e5ebc.camel@kernel.org>
In-Reply-To: <cba5f0b6f13a314d78f7c767d47a7b6fac7e5ebc.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4815:EE_
x-ms-office365-filtering-correlation-id: 37b55900-1f62-4d4f-317a-08daef29ae3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQjaq4VVYsonwkKmqzukIwaUSgnU/6NA83+xp2gnExjHuIAncFrkuM22RpKg4TJVOItMTjy1oyMDZoSLtIvXEqY0gR8cfBm6mBAH9foTRlZ05YLs5MlqSdKznUXoQdgsnu481lDJSn0+VDoG5AkPvYaGcaxxvdETPCJIX12rcJBytHddlx3p9k60dvi7rf3MCoPd5C6bVdH5Afb+H5qAJB1sRy6EfpWP1cnc8lQ4PC8maxb8X4Jt0Y7Kat/6CH5EG/G1J+y15XpUyG3PCtZabFHK7P/9LidaxvzB7OqDR6qxAfB//uCEPHXd/4c5NGRhIxD9+uGrt1p12o4BCYyn8XnIhFWXbceEgNL52G6uzX2Q2cn7FMrcWCvBA9vpq7INICNjJedQmKDvdN3PjGOzKpsLPikjuWXLQ33HROeIK/RcgDI/MOfx164pw0/1LFNpmL/o4j2RlOPiEE325LGr4zw7AQv6NsHCFCGfzKl/PvwZD9QR0CNXJ3OkYE4s7pomNhwRbBHfjYvPMig8Uaz9ICYYXxwPvFBDxt0JTcc8pI5aUtuhtZzc99eyefDLZxVX3Cnq1293Z+n9E6v8pxYnmWGRB+u9MxoxoHKf4o33m+AI9ReIyrD5DbEYSPgR3rg13Ayu8DFgoK1FTYC7seWqfam+cI8cHDC9ccG1AYi5KDDB1zJCfkWU4G3NPC3aDgeJTssiC6DT0N3P2oHYm5cgNENyderY8XrB/EU2qc9f+carkMn3bgWnqgFSDdb1vvIh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(6506007)(478600001)(53546011)(36756003)(86362001)(122000001)(38100700002)(38070700005)(6512007)(33656002)(2616005)(26005)(186003)(83380400001)(6486002)(71200400001)(76116006)(66476007)(316002)(8676002)(64756008)(91956017)(66446008)(66946007)(4326008)(66556008)(8936002)(2906002)(41300700001)(6916009)(5660300002)(37363002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ygyby/xaF3OJpSP/Nfg85tBtlw5QpFZHlKk50QLTi0PBKn3Xm8MR4L34u/iM?=
 =?us-ascii?Q?BlhxjeC+wE7sgRBdelNRMg8GFDNXSXmkf99PfzfYKETdwpgbhfoP+8J/6JFB?=
 =?us-ascii?Q?SEEoEVBLlCyq95aZ0LkFWcS0ySq27JE8zR02p2mkGpbGne54VsqmgDLuHb6U?=
 =?us-ascii?Q?Ag8XtRoqclDl/xi5mHSX8gjCdXJOKwcPBMPETwwc9ED9sOUVNh9bL2G6xjNj?=
 =?us-ascii?Q?6XwKDQ/TwAsTulcCts217q+p2ctpRFX9W7vOR6RKwnBd0Fgc0gOzvwk0wwTZ?=
 =?us-ascii?Q?kuLQjpi7MGBiGaKigRxCjUGPF1pSSh292S2Prl2cRGdXa3Aye0H4RfEaGVoS?=
 =?us-ascii?Q?uvw7wvm7JInROiwVxJn6oULDVjp3UlhR5XRPLvp99J4q8dbPbW709loHK0nY?=
 =?us-ascii?Q?a1GpCS7+LFBXVkvcOw1aPDdkN8enXAIhFz1CSPJiWo/aGmpOaS0T2yTMwPbZ?=
 =?us-ascii?Q?LOMyAuAVzY9ctBVdoMq/xO5+iHtznW2h+p3+F3akNZfATzWxwbHqQhI/s5sz?=
 =?us-ascii?Q?m6GFQ5Tu+L1+nF+OIQCf8iFdGWwcziIswBMjAFS6WdXkLw+Ti2AU5m0SBW88?=
 =?us-ascii?Q?1xeA8ZWUKca1W2oV/MPbyUFDL8pQiK+mURP0Hk/8WU8t2zrEAQ/zeFQUUUE3?=
 =?us-ascii?Q?9WbJL5UoxwjO26HvBik4gK1Gh31YJT5QYesoTnXweNMzCp0jRdlnE/9GRG9L?=
 =?us-ascii?Q?rqh95LptDs0+gvsZjTb3yWrJwu8WQ5C8Fy6ECQIRlP9hQvEWbrXuwQczxHxM?=
 =?us-ascii?Q?1zD45vDu9O9LzW+ZKJ6jq3u/Go2r2f7W2kO7iiRUI+XfZRn+JBXfEjpfJa8A?=
 =?us-ascii?Q?wT48Z4tKGdX3UAiqDHFPY9U8lbifm/qO81NMmtAx/nMnj3ZxBTIxFG0bqJbv?=
 =?us-ascii?Q?XnJUCWrfs8ouUfP/Zb4vR0Y+z35IjgoL0yQ1cIxsUhl2Iyxu4RVyKC0Tf8AK?=
 =?us-ascii?Q?zA6db09e9dW04uXjpJ1s1TV+SP3ajN73UNKazigmzLO+U0ikjbDmJv/1baMf?=
 =?us-ascii?Q?NKe6MWtBs6reObfPheJR/Ga1dhctiV8UfjACLZV6OZoa5RFNWShzBIqE8j27?=
 =?us-ascii?Q?zoMTVzdNBDEX0/a0oiJc2U5yE8vtmVM6wWG61Sd5VL1fu+5hw4BkgwnkkYzB?=
 =?us-ascii?Q?YutnewgW7yYEHBsOIJLDnQapDt38aglcq7VO6H9jNiBnwwqNUhnJNck7x1HA?=
 =?us-ascii?Q?MyMu14L7xw79esMYyBRqdiSjT5grVpNXCj0wcbSGDUjBdIwbhpbia1tmzaWA?=
 =?us-ascii?Q?yLFppfLTR69m/mAt3pxrj4p66QsNzj3+xOHa+FN/1k/0bjdtOtgNbFTye3DB?=
 =?us-ascii?Q?3c6jzhaWUqhBaB/wpnniRmzsrBtG8CNTAM4xcO0ijimUF4E2CwEANBcH9xu0?=
 =?us-ascii?Q?b9EcHarXrGfRtBWDDN6zq+RG0UPXTcTBFC9ZIpDv1JZFpRKqdKbKR6eA/L+/?=
 =?us-ascii?Q?Q0D2EQZ/qq8NncN4AvGjHEnXgnyuxxJnYHG3MkBMlHXl78U4sLTlXzmkqtNk?=
 =?us-ascii?Q?3FRfTVyWYX978+Z6UKw+5m4tM91wSrxEsvh8Gw/bxCns6C3svg7qkazSjcw+?=
 =?us-ascii?Q?ZykF68Iw4ePRNsvGNS2E3Own4VCqTPOxGLYYU/ZfE4e4LFYU19Cwi49LOkYI?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <221A0EF3CAF2614E85EBAD5528A1E3A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oyfSDdc3VjPubqR9kMs27EBklVJb+C5PZQYfiK9/v/9E9wVa7vi2+2xn0JNRCdqycGVlFfx3OK1PMzZX6UB+cBe785on7kGdfWjL13DpHKI265RE0uTrk6Vc3VD0Eby9C7WfsEmfrx3H0MIeEUtJoMA/OvuTFLNHticeC6UfEkXI1+xgZaZRLEfbnJOByxYA0fgPPyuvwCQgtpwieH/5t8mNDfH4Mpr/urTDMrCbp6Nt+T+R8KzcucTU7n6IrMnJi4Zb1vG32AICb9oM50qz9S5y7Vdkx4L/6rYgjjd3hjpgsvTpFf33lIrDaZPwBvGKwgVLF0wYNvrhLsIxelNbJ48ODJtWeeOhPCxYH+bIsOA3Q0afnv6dInYkACSH3gwdo1VSMf4Y0e6BDZ5flH/q6vGhQHElcYdSJltARU06vJ/b6nkRNMhcBMNIKhY5OPsK4Ey4lrjm8WJKbJFXzAag8gtcsrDXtdKLX781jGJzwtTgm+8f1e/EyACcNZ0uoDBDzX6jFmZwuIIYeKQLbAoKyDmTnnySQZo0fxe/DO8UJv42QNjz3J5f943ngQLl1IU3jBwjvkXDl/UgHK/n0vVhisScMNE4Iv9cS/scoezAJGE+cab1Ax1ct7Si5MRuW2SpK0LO3weEbbAo2Ex5uw78EB2kG1seSerITb/RJnmEF/QOoPqEIwrgF99LARhG2r8FrSMuxIX5QI8vaCG1VxC5ET+6ewUuET2sikYAxPPzPFi8aTukN5ENaTHUa6nIyu/GRk6IwnYGp/xoCs4HvopUcSm46O+mFAMSxzw/wjjg8hU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b55900-1f62-4d4f-317a-08daef29ae3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 14:32:32.1952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmSBI4lavGfinbBz3mekVCyDrQLsHsvGJYpB+91Mdkjt3tCs2lU3Y3cMpQ3MiOgIdSzTURMKyCkreYP2bAur9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_05,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050114
X-Proofpoint-ORIG-GUID: IIZtLI2TeW5RaEum78INslNRkDl44OKP
X-Proofpoint-GUID: IIZtLI2TeW5RaEum78INslNRkDl44OKP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 9:29 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2023-01-05 at 14:18 +0000, Chuck Lever III wrote:
>> Hi Jeff-
>>=20
>>=20
>>> On Jan 5, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> Since v4 files are expected to be long-lived, there's little value in
>>> closing them out of the cache when there is conflicting access.
>>=20
>> Seems like targeting long-lived nfsd_file items could actually
>> be a hazardous behavior. Are you sure it's safe to leave it in
>> stable kernels?
>>=20
>=20
> Basically it just means we end up doing more opens than are needed in
> this situation.
>=20
> The notifiers just unnecessarily unhash a nfsd_file in this case, even
> though it doesn't have any chance of freeing it until the client issues
> a CLOSE, due to the persistent references held by the stateids.
>=20
> So, this really is just an optimization and not a "real bug".

Good to know. Let's add this to the patch description when you
redrive...?


>>> Rename NFSD_FILE_KEY_INODE to NFSD_FILE_KEY_INODE_GC,
>>=20
>> I'd prefer to keep the name as it is. It's for searching for
>> inodes, and adding the ".gc =3D true" to the search criteria is
>> enough to show what you are looking for.
>>=20
>=20
> Ok.
>=20
>>=20
>>> and change the
>>> comparator to also match the gc value in the key. Change both of the
>>> current users of that key to set the gc value in the key to "true".
>>>=20
>>> Also, test_bit returns bool, AFAICT, so I think we're ok to drop the
>>> !! from the condition later in the comparator.
>>=20
>> And I'd prefer that you leave this clean up for another patch.
>>=20
>=20
> Ok, I'll drop that hunk.
>=20
>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 14 +++++++++-----
>>> 1 file changed, 9 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 9fff1fa09d08..a67b22579c6e 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -78,7 +78,7 @@ static struct rhashtable		nfsd_file_rhash_tbl
>>> 						____cacheline_aligned_in_smp;
>>>=20
>>> enum nfsd_file_lookup_type {
>>> -	NFSD_FILE_KEY_INODE,
>>> +	NFSD_FILE_KEY_INODE_GC,
>>> 	NFSD_FILE_KEY_FULL,
>>> };
>>>=20
>>> @@ -174,7 +174,9 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_co=
mpare_arg *arg,
>>> 	const struct nfsd_file *nf =3D ptr;
>>>=20
>>> 	switch (key->type) {
>>> -	case NFSD_FILE_KEY_INODE:
>>> +	case NFSD_FILE_KEY_INODE_GC:
>>> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>>> +			return 1;
>>> 		if (nf->nf_inode !=3D key->inode)
>>> 			return 1;
>>> 		break;
>>> @@ -187,7 +189,7 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_co=
mpare_arg *arg,
>>> 			return 1;
>>> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>>> 			return 1;
>>> -		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>>> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>>> 			return 1;
>>> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>>> 			return 1;
>>> @@ -681,8 +683,9 @@ static void
>>> nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispos=
e)
>>> {
>>> 	struct nfsd_file_lookup_key key =3D {
>>> -		.type	=3D NFSD_FILE_KEY_INODE,
>>> +		.type	=3D NFSD_FILE_KEY_INODE_GC,
>>> 		.inode	=3D inode,
>>> +		.gc	=3D true,
>>> 	};
>>> 	struct nfsd_file *nf;
>>>=20
>>> @@ -1057,8 +1060,9 @@ bool
>>> nfsd_file_is_cached(struct inode *inode)
>>> {
>>> 	struct nfsd_file_lookup_key key =3D {
>>> -		.type	=3D NFSD_FILE_KEY_INODE,
>>> +		.type	=3D NFSD_FILE_KEY_INODE_GC,
>>> 		.inode	=3D inode,
>>> +		.gc	=3D true,
>>> 	};
>>> 	bool ret =3D false;
>>>=20
>>> --=20
>>> 2.39.0
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



