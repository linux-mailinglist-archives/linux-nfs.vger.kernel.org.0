Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D976DFD16
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDLRzy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLRzx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 13:55:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C301940F4
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 10:55:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CHEEQN028970;
        Wed, 12 Apr 2023 17:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fp8OyFSMO5oB6sPuhzJDbBaiu7dLTZ35ZxGyeG4K5Bg=;
 b=csS5PhkEMaKIg81n7KJfZr29jgJhaIoUw7VjfJpjWz5FP81QjFmxztDaQXxPfOSbM/Or
 ChBF8kBloKkqQlVa0nAU5BPCs4J5t2cbt5DxEq3bzLzU/Qy6Szo8lz+txeyOvRvLO/sR
 NHPRNpJPrR14ma0h73IAhJITTkmRokTdxi9zH01EPBquYBqONqh/qH6jjWl07L0uxtot
 Z/gbyft3/rSPcyrl0FKyuHaaxL/meEUKQ/PHDxTujlEm1spTOcrAfKTBe3DwNhqRe220
 sZeuRPT73VPb3+xrXQi9bm1h/fy9ZyVmIkyPVmvDqheH8q6h0xbk0ApAdbJ++8xPmVAK MA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etrvk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 17:55:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CH8f8B025126;
        Wed, 12 Apr 2023 17:55:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdr6qfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 17:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVdk0t9PtNKYDDzGAZbwjfB2V7c4ouVe4er215ZrcqMKFHqkLi/7y9OLS6T6ifUETPKxbyXBGo4loiRcUvAeW7FWdTdt+4kaE8z5j5feFRwVVunPCxHgEigi06wUebFYRaOVz9DI7gKkIJ41Av2Ml9F1RUby7s9JCn5sqp2hqggX+mdNHTtoT34IwUjHQgVig2fV2OxsmpVeJCPD2DKvnEe+mgI5pkJLlClEb65rPVwP1dEccoxGx7rRDyNQf/4RvoC9ARoDSFLgj2ZfiAyTDzZck9UYgg2pTOXe6fZP4/GwF3fAc1TMk5tyqsJgfFbXWey3/OgmK1K3GE04YmNT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp8OyFSMO5oB6sPuhzJDbBaiu7dLTZ35ZxGyeG4K5Bg=;
 b=Qm3Ea5jqU3vBJXlTx8IMm8boiUfvReeIrf7W18kz/7hwsp7cUb7TmE2JMa3dsRsiegb5pfc9EcjfCvjzhW86dbWccN2He/6wPeYF+FXMDtnxpVvvLlSt2fRxJZoqT6gM6v6OGCdr/AaMi8MKPBrlY5SiR7EoF3PkdVPcKBlEHoTLnxBUxjgbjH6+G6/RAqA0+IGsXCcdCkn2Ot2fvuCZWXBA7Qhel4k3GBCEw6pLWoTYj2nboj7IytzEBLXcM76qI3Lb9LusDQcm5jTt5D4//D0O7zvchJtxNhxXjX4d6ZooaWOOeOb9v+ZA3G1ztbycAacmS3Eabq2/Amo2ddyuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp8OyFSMO5oB6sPuhzJDbBaiu7dLTZ35ZxGyeG4K5Bg=;
 b=yNzqakQGZTCPMoLzgKNMOV6LuhORwbw3eGwo35GDOGceorhroCEn2igJYK4OXC8/6VV9IlVL++O+86akBpB11GT7sQLbn+qXVHFngojq44hAEYeSxQ0QqYrlBn5TtlEQI88oVTaM0Xdpk3xZCGa1/VnB8/kfGFAf5VQzq7Mvj1U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5695.namprd10.prod.outlook.com (2603:10b6:a03:3ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 17:55:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 17:55:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp2wdCHl9MJskyADf2q/cMSEa8n+xAAgAABSwA=
Date:   Wed, 12 Apr 2023 17:55:41 +0000
Message-ID: <561C2E8E-4DE3-4EFC-8821-B7A2C49B42E9@oracle.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <9b97325926ccb7d983455b13617a35c9e83dd7be.camel@kernel.org>
In-Reply-To: <9b97325926ccb7d983455b13617a35c9e83dd7be.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5695:EE_
x-ms-office365-filtering-correlation-id: e623de92-f37b-46d3-9472-08db3b7f2175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kBk8dth6GzdPqSJIRrpZaxmELh1P4SSNhWtJG2R5g9vsDCnq7wlRaYFXUjQMOjIenfP3SyuUayck2W2yQrUftgb5bJH7Q7wXvdvGtjBWnz9+54VePxOf4UZPxLwgJBNqySQBETu+xdWNkI4pM9UcZ9PUb8Te0vi0uRdene2JqDAHLkTI9CwLy4EWKHQxolhJD6FDRBRYDRshy+Ic03yJP5TO91V0dS5tUVrLK59yWQqWgH/5CFMoBD3Byq9eDRgri660dXHdHcmDxiUYF3ar4vzeSVMP2gjAG+SHvWYtbOYSRdog4fRAFVwwfv0qoIdKbaBRTzdk4dcnN3nwKezUCWSyZXjZuOo91E/pHogYr1KYDw73bfHF9g/HlC2+4Lue5Enubmf+lGTyEoqQIYubpYH7EC6mXuOcX7j1nO2xWkuaXcFBRx1qRtnfRLSseM4MJ8qr5nwllCclfg9pKDEjk8643D92Yu91qac4N5cP9mywMmLQrwFmo23cZABbrDLgYxuA9BpFL2RiiKcNMygvW55TByIIgwuB7QwjMRkkngkwNg2rbNxMZpJB5eo9pX6JAiMUlalxH+Oo9GChBVmneBbh2Y8laxPodmfXC1XBT14nl/OucgQDVR2B1C9R3l311Bg4pJ05PoDVfbcAm46xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(478600001)(71200400001)(33656002)(54906003)(83380400001)(36756003)(122000001)(38100700002)(2616005)(38070700005)(86362001)(53546011)(2906002)(6486002)(91956017)(316002)(5660300002)(26005)(186003)(6506007)(66446008)(6512007)(8676002)(64756008)(66476007)(41300700001)(4326008)(6916009)(8936002)(76116006)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E/VtNWqCs84TdKNrMX2map+jYj9+QjU5Q8l8usEnVsgZHTLOl2+cszVr5atC?=
 =?us-ascii?Q?suhSVWZjMOhchmu39rHHL+RwoIjoeYLt1bvNDAxLORrUJtOxnJYHKMNYytZW?=
 =?us-ascii?Q?GkfNKz6jun+t2aozjkWt5QRc8p7g0/zy8MF+kId49G3naMgyU0VjcgOMFk5u?=
 =?us-ascii?Q?Cfz3A9rRIyJ/x5FDBO/6+Q7pe7ak6Hja/dnElGPotAtz6ySYU1qjk58esqx9?=
 =?us-ascii?Q?1pzSmhMzGAaufkHeX7Lq7a0+bMg78VhDQnvFx1LibKqqSTUHIW9oAyc3iFwB?=
 =?us-ascii?Q?h5xiuCAbzk1vuc5d15MdsmfAlCkqVDCqYQZIJX+7mDoomii5rpWbamT87xGD?=
 =?us-ascii?Q?ltYec4ZInSIrIM14cc719X7bnpXFzsUFokRL8em2Mr3OcDbh2q++LLKjviOp?=
 =?us-ascii?Q?IJ1TEqh6tU0SpVQNK4F2X6TBLJm+QCzvfSWCizVRxzhIegFDwTQK4DRqX6+T?=
 =?us-ascii?Q?fHK5cCXTQVI2jMB+jdTweRY7Niz9M1sWzWnWh674KQ6pcSqs++VuElBFY93t?=
 =?us-ascii?Q?8MknarE/XuU9VpQsZ9wHBz8JlgEDUjeKItzDDztpOKH0fl3ZJF8rJn031NtZ?=
 =?us-ascii?Q?BJigiAg1G3QyaOcdMTbDpfhJ8krV3v0ZcjBYy8xoAn+PI+IE2CRrKHWNMRWY?=
 =?us-ascii?Q?VbbdEx+69PJhn2ITw+kW3kUOZYZ9h0OMXzSfqkN+M1Rz8Tz0IUKcYqThe245?=
 =?us-ascii?Q?Cndw1NcMg7Dlt0n9TMgq5Z9/jGmWWHl6LZRiPt5OBiWcNmby40yYaz29DolN?=
 =?us-ascii?Q?FKnLJ0XRy5ZkoVWQjrjrhkk+PPG7JzGvxBDEp2xJQFM8s0I1Xfdr1uIdqorN?=
 =?us-ascii?Q?Jyjil9g5l15lYg4+I11ioIoe1qVVlAD/aarQZWlLlITjAzNkGB8uP6SfqjQO?=
 =?us-ascii?Q?ITT6dTV4A4dQHUN0iL6LzuBNLOeZIElHbufDsGHkkaOeHEuFxtU9AzLtSQyD?=
 =?us-ascii?Q?ZSunP5kTRQrFGS9rWqsplKhLTNU1fN6c3ZIHOP2t5gi4TeXXZh7qLVA9M/oR?=
 =?us-ascii?Q?sT3Lc3zcZTfUkoUzvb3nvrk3KwHX+QQdKhVkhRCfRzlrc4rSjCg28j5VOips?=
 =?us-ascii?Q?nsFnIN4RVVAQXYeyLLhP5JKLdd0bvKMd5ZqmDkYiy6s0bAQ0DrsxRAjkdJu2?=
 =?us-ascii?Q?MHwIy8f9eyn+k03iwsOeua4J1TiJlUvw8BFsouTWywGtgj9g0HJtkPQ6wRCw?=
 =?us-ascii?Q?MHGYhuf/bcjV4RGCdRq5kVxu4YZ0WHctSzxmgKybA55uWkiN8+eWuRXin7uV?=
 =?us-ascii?Q?sj1Sv6LszNrhriSubj4ceNy/L9mbqOfiekLvT2tteRjpt++XXOEpaD0z1Ohq?=
 =?us-ascii?Q?WJr0UpLbnSW+WKQO17zSFSe/nOmMKaX4JGU1g9E86SOiuJOieQvG6EFPW96h?=
 =?us-ascii?Q?EJYP8ZbW1ubpDOCWotbH28NI5LJNzBCaZjE/O47rlP4P+PIlXjCUnxnlvqe0?=
 =?us-ascii?Q?dDS9FZNIpYONdmciSASZ7FcrOYsCL8VgX+1KvMXO3P/ZndYhN4YJznk4kHWy?=
 =?us-ascii?Q?K1nywrjKVRNfH6apI3nuKJFNsxLv/YW+pS6KEeJcqlPjr0Sq1WJwjYZ1pJqm?=
 =?us-ascii?Q?FSYbVmt77w3ejlls+eZWRdD0h9d24lvr/niWVDzVjO1L4DaEsdLb1UOVUnSg?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <991BED35847962468968EB408D1B2EA6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oRaKxZiuxMcbhyiDpjvyYUXSfSn22ocjrvf2NSyjJm1CuvvochKNHwih0oRScEvi9GjqpgySyLQHnYctLQO4IoMqGRQ719OGx7vpSP70H9z2FFCxWI0851GJZrYhiSjH12vLDlR9JxsUaAc9mgn5Tdd+KlIUZtkIh19fsBH44zKjjWZ1SclQ4P6ankD04B7pPfOO6jKPY3M6I5+uw4GFxv7w1kBCAqHFiYJTHYBvTTOnULrvfV6+0PKLZCc7dGbcJCetfO7D5xOFFLaWnOeCNOljnmhyMxsE6520ceUX0gLsXQrBAz+Q3BAlcVUbG1laeJeqXSem5O9T1uhBZ1wPOGntzdNZ3zdg87SaP0tEYvGVV2Amm0lgX+/YgkheafDo77lSEvb+g2UPCSzDxg1NO7MzqrNGdUrSNhbBK8VaJ1j8Lpk54NEN6/dslT+5T+8RgsWrqHKO61WcpQRYM6+5nZoAowgCT9zFgfbpG4fjtdbtXmo4OKyzRWAosrEUQ4W59LjLR8KkcAIy1Ol9UkSJBSONqxRQ5vKYxsknhHC/zOeGxiZ4AthOScCSp3mToCLBePBbGWp0Gl7GUk4VDUU+zqVKt50sBVZBD0bNgNjm9615I0kt3Ic8H9ey+R2geBBjEU6p+00+LbiTbvyqE6bel2EFtMuepAnNSg45QLHZadjzqPyEQOiMF0d2IVxP/nCFs/cBCB6BL7II2rWwlvWtL5r5OFLGUv6stMgtg30XeBgjfrrh4fJQDMbg6pUKojRoyQX/ZFFVSGpwVkRQ1hDJS+QgNrvhQarQpPRbUog3cAPWBd0b17mM7bY0j7LO6nW8hZhvsJaQbBHkf3PiQ/1f+g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e623de92-f37b-46d3-9472-08db3b7f2175
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 17:55:41.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BCFT3AsY4lqpKNLII0YY72In7jFKcII0fLCpEig2QpSRMCg5/UJFco9Yrm8ypijX9LBMh0pKIEPrT5E9ORRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120154
X-Proofpoint-GUID: q4Ha2gNlT0F4EU5IF8RfZMtIHZ07YAbg
X-Proofpoint-ORIG-GUID: q4Ha2gNlT0F4EU5IF8RfZMtIHZ07YAbg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 12, 2023, at 1:50 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>> Currently call_bind_status places a hard limit of 9 seconds for retries
>> on EACCES error. This limit was done to prevent the RPC request from
>> being retried forever if the remote server has problem and never comes
>> up
>>=20
>> However this 9 seconds timeout is too short, comparing to other RPC
>> timeouts which are generally in minutes. This causes intermittent failur=
e
>> with EIO on the client side when there are lots of NLM activity and the
>> NFS server is restarted.
>>=20
>> Instead of removing the max timeout for retry and relying on the RPC
>> timeout mechanism to handle the retry, which can lead to the RPC being
>> retried forever if the remote NLM service fails to come up. This patch
>> simply increases the max timeout of call_bind_status from 9 to 90 second=
s
>> which should allow enough time for NLM to register after a restart, and
>> not retrying forever if there is real problem with the remote system.
>>=20
>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
>> Reported-by: Helen Chao <helen.chao@oracle.com>
>> Tested-by: Helen Chao <helen.chao@oracle.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> include/linux/sunrpc/clnt.h  | 3 +++
>> include/linux/sunrpc/sched.h | 4 ++--
>> net/sunrpc/clnt.c            | 2 +-
>> net/sunrpc/sched.c           | 3 ++-
>> 4 files changed, 8 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
>> index 770ef2cb5775..81afc5ea2665 100644
>> --- a/include/linux/sunrpc/clnt.h
>> +++ b/include/linux/sunrpc/clnt.h
>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>> #define RPC_CLNT_CREATE_REUSEPORT (1UL << 11)
>> #define RPC_CLNT_CREATE_CONNECTED (1UL << 12)
>>=20
>> +#define RPC_CLNT_REBIND_DELAY 3
>> +#define RPC_CLNT_REBIND_MAX_TIMEOUT 90
>> +
>> struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>> struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *,
>> const struct rpc_program *, u32);
>> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>> --- a/include/linux/sunrpc/sched.h
>> +++ b/include/linux/sunrpc/sched.h
>> @@ -90,8 +90,8 @@ struct rpc_task {
>> #endif
>> unsigned char tk_priority : 2,/* Task priority */
>> tk_garb_retry : 2,
>> - tk_cred_retry : 2,
>> - tk_rebind_retry : 2;
>> + tk_cred_retry : 2;
>> + unsigned char tk_rebind_retry;
>> };
>>=20
>> typedef void (*rpc_action)(struct rpc_task *);
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index fd7e1c630493..222578af6b01 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>> if (task->tk_rebind_retry =3D=3D 0)
>> break;
>> task->tk_rebind_retry--;
>> - rpc_delay(task, 3*HZ);
>> + rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>> goto retry_timeout;
>> case -ENOBUFS:
>> rpc_delay(task, HZ >> 2);
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index be587a308e05..5c18a35752aa 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task *task)
>> /* Initialize retry counters */
>> task->tk_garb_retry =3D 2;
>> task->tk_cred_retry =3D 2;
>> - task->tk_rebind_retry =3D 2;
>> + task->tk_rebind_retry =3D RPC_CLNT_REBIND_MAX_TIMEOUT /
>> + RPC_CLNT_REBIND_DELAY;
>>=20
>> /* starting timestamp */
>> task->tk_start =3D ktime_get();
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!

Since we still haven't heard from the client folks on this,
I can take this fix through the nfsd tree.


--
Chuck Lever


