Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19B17EA884
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Nov 2023 03:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjKNCHK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 21:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNCHJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 21:07:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F82D43
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 18:07:06 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADNsBof008964;
        Tue, 14 Nov 2023 02:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XM+3CP693Zj89FV1vYfsHktfYS+JYOTPX6y36FYz/oY=;
 b=JLosTt3OOhZ4/Nl8qvrO5PpOqXOGrBz7+vWwJZ4o+JBgnp/J0hS8vvP+1TFe26v0liqf
 3rIt8e/muhAqg2wh1N7FP610jnCUPYh0y3FvHBPzwhBLXHzDKTUWKYdLQGGWujVoEy++
 WZ13HQgB39l9psGnmIY72MT/q8K+WQkEGpu9yhDQe09xT4XtPHZjGBYVAaYIeBBEKbu4
 wXFog7rj6ZmOVCgkrH07Vki4DuSbyWxbYN0jtOB878YFGHWuRcp+hOLSScUwG3H2lFjI
 r2dsObelZlB3z6/86f6ndcekTV9yobXmn4MlG6AMek8U0oZcGTbRFs/WuqJglIBM3aFg cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjm61w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 02:07:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE07F6q004521;
        Tue, 14 Nov 2023 02:07:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k2jsqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 02:07:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOAz80GrXEs34PVTO8apJfTXC6AgtaSuG488NK1PSM7DCz45UXBbNN208wE3bccnBmTZMNwUgHiF6iyxYUFxALhjvZtBq5N08VnCY7gvZhMxcNF8MO40i1cQegoWtOyO4D1kiUnizF8de/ZxPv1gqWZ0iFcj4IOKUXy7XMeAcyhmnZ3VmJPtaeiLksbqUf6QcgI7AdDa/h04ZR03IW8q1SqYpejtjNa0mif3W1wbv7ZBE4cFsTOIkUGxEjPupjEbkAQifpMWyrlzIyTmlxpXyeNgdiLJEmmXiA/4UFA0fz8nO+3KDO12bdSRSWN0y7MXH7A0uTtjCVwGNk5NBHgGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM+3CP693Zj89FV1vYfsHktfYS+JYOTPX6y36FYz/oY=;
 b=lmCGVDIhjIMDQmewyBnSBxVLJdf4kRb0X6VDAG84ylQEQFPmKDItiTN/MICD4AfIC9NaQ+zqvtqscBhodwvcBkYYGrUnM8DMTMsk0pzKq5LvVNdnblxfGBLicKTTFm4B5fq16F6OuucbxVqIAuyEVDIJ+1cIrrxx38grpttWP7jpVMcWkMEYLH5t0LfJ7o4pvkU+H+Urkl+HWVOE0KG60ZzbbGDi66KrhiOhCfhn2HlgvlD2x2cU+uhitlFkjiopeWtirup0f41bWhwD6tWhrsdf5FEGR4MNZrMnT7nKSoqu86+9+tYpnoNJgzr1E0S9sqR+kfsige1vWPkkdNM2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM+3CP693Zj89FV1vYfsHktfYS+JYOTPX6y36FYz/oY=;
 b=EtiWp3XQv5IZn1lCPalSVzVjN6WaZi9p88IU4tTwsypZ9iXb636XnlTdEX3g2KfT4w1LrmUG2Vbk2cQXzqEHygNAwPP0TEzqU515zSPu98TwmBWsY1R+VKwI223ypbTto9TdAWtHffQjKZRHlGI6zSYvZRKAciGlQ9AAxQ7NzGE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4342.namprd10.prod.outlook.com (2603:10b6:610:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 02:07:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 02:07:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Cedric Blancher <cedric.blancher@gmail.com>
CC:     Martin Wege <martin.l.wege@gmail.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Thread-Topic: NFSv4 referrals - custom (non-2049) port numbers in
 fs_locations?
Thread-Index: AQHaDKK/5xxTBJcRKkGtisdr07fPibBlifCAgA2y6wCABUQbgIAAbzOAgAA1BgA=
Date:   Tue, 14 Nov 2023 02:07:00 +0000
Message-ID: <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
 <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
In-Reply-To: <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4342:EE_
x-ms-office365-filtering-correlation-id: 9a9832ca-81de-406d-0daf-08dbe4b6634d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nCgNWmgpFovocBKFRsHM8ba7CEj9ts9bEfjZgOdmdVnfB8IfNC8UaJyu+1daZQqRpgb7G+ZLAfMO1BLK/m0k1zsQStYM34grfvM6JXSzi7LT/FkYoTVwQKwQOy/M4xHdbrIgsA5QaKFOUg+H2X7FfXxj8mTkLrMQsaZSJr7017la4qj2RZMs8ta1kCetFx31WMVCoaEZn5XPR0urnWIybq3f0pZLFLSLt22n/eeXJ9B19R9qYH6lgzqYLCHv2ZFHBN+R2kEt0totO+lrkP2oaYyvCDlCE+Gi5AGAo3dZpH1ywVBOo3HlYs+weod9pwWAoDDJmUmYJSaRt7K9uSMXZpSy9mBSW4jZuVCZw8TLut0nUHSUoUmknaZvDuHopJkgwWNK3pk6HBoBIWjHoEAb0ksZcmPOZ7Q7Uy+RzTttrnAy1b+W8M6+CUqx8JYZ6ahWhAH6+M1C/lr1wW3M/Fa88ZosbirOSSyqwIvrieuMvUo4LzngoBtFWacFHEUnyFFUmAse8Yhj17WWIcdZ293GvSK4BnS+s0e7IINmevtCb2k5lYTQOgj7ZldnPWm5+bSyg/sm7PoRQWblGoT6ArtBCRibEK8jt1/fIdiUD3m07ExXnndW7+Iew9lFLPEuQ31+oJq27vEs7blqhwok/Uxms21bp40o0Kd783kcpVvwnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(4326008)(36756003)(8936002)(8676002)(38100700002)(5660300002)(86362001)(41300700001)(966005)(6486002)(2906002)(6512007)(6916009)(54906003)(64756008)(66556008)(66476007)(66446008)(33656002)(66946007)(316002)(122000001)(26005)(38070700009)(91956017)(2616005)(83380400001)(76116006)(478600001)(6506007)(71200400001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXZXNEN0OHBsK1lHeWdvZmJYb2hPMisyNWl6Q1Q3aWc5VHRlUmt1U2xvNklw?=
 =?utf-8?B?c29iQmxFZ05FQUlEM1o3cWd4N3RiZUlXMFJVM2JQRFpCNFY2aTBXVzluUHdL?=
 =?utf-8?B?TEZhMGZSVk01OEtpWUhhZUhoLzdWVTNEbzhVMHNDLzJkT3g2RzVScEc4UHRK?=
 =?utf-8?B?ZTVPOWZkMnp3TGoxdVBJb2VkRXhMVkxRY0xLMC9tT24wMjN0RkdiOExMa3ND?=
 =?utf-8?B?MWw4RW8rM3FKR3lFMVdVQTBMZ0hUMjA0ZU4ydlhwWm9RUTJsUkVsQ0UwQ1ZC?=
 =?utf-8?B?cHcrWHRoVU84UDRJV3hQY3kyd1FkQmpBQm9LSUt5WGJGNHIwZ2FLRzZjYUxo?=
 =?utf-8?B?TkhZZkMyeVoyd3NSdFJzNDI1cGpsOTBsQ3BWR0ZNMnJ0TEVTMlFZVE95UXJ2?=
 =?utf-8?B?TURZaWh1bFpscThiMVgwOXZaci9JbUdZOU4wUkpWTTN5N3BHRHFIRnYrdGQ3?=
 =?utf-8?B?MDY5a1J4VzBlOEpybFZjRXN6N0NQa1U0OHZiTzVlaWw0Qk1nVTlUQ1JMU0Fq?=
 =?utf-8?B?TEZ5cHh4cXpiN3Bzc083eTUwcVZkVEs1YTY1SU9iWTExOEpXZUpNOGJaRjRC?=
 =?utf-8?B?dGRsWVladEZLbkhLOEo1UXlrK0FvLzgxRmt0Q0RFRzRCM1RvQlU3dDFocW1X?=
 =?utf-8?B?UXh0N2JKSHZvNkV0Q254c1BFa2pFTG9OWHNtYTNQWFhwK0ZDT1laQzlLd2pj?=
 =?utf-8?B?aWZjLzNRb05VbzYxaGxkb3VyeHRDMU9WMEhDZnRyWnhqOC9iME9aV0dheFIx?=
 =?utf-8?B?NUhPQW9rU3JqVnRyVHkrZE5EVjdDSHc0STF1TWZkUTRFeXN0ZXhHRHdPdXpX?=
 =?utf-8?B?NERiNUxQYVZVN0hvdG1RVHphdjF2Zm5JRnUydENVbkhrT0VTUmVzZ2lnWlY0?=
 =?utf-8?B?WE1UNmQ3bUVWbk55SzZES0hlamlhMXdIQ1cvUm1ZWXRiQy9lQ3IxeTlXbWlU?=
 =?utf-8?B?QlIzQW10eDBnZG9jZTFEME1kVkJmaUpYdk83aTFDSXdJUWJ6K0QwN091Zllw?=
 =?utf-8?B?VWNjYllndG9NUTIxMW9ZQWZuMG9nUzJmWjN6eHM0QzZKWDdsVE9LZThyZldy?=
 =?utf-8?B?U1RQYU1pbkVML2d5YkM1L0dobXBQQU9iWmNKOHZMVkhrSzB5bHlZN0YxV2NK?=
 =?utf-8?B?QTlKemNKcHVXYnY2ZGNOQ2M2cGN0SG03N1JCVXQ5RGxPcmo4WFFIOTRwRUM1?=
 =?utf-8?B?QVdOaXhIRWg3cjk2c2h0MExjTEtQSEpUajJpSERvRDYxOHFBUlplYzZ1N0xU?=
 =?utf-8?B?QjdLL1A2N3NOQllvTVpZcWI3Q3lrbys4ZndQZUpNLzRlbzNBaW1mLy93S1RM?=
 =?utf-8?B?UHZ1YmVBT2dIbnFXdlNyUHE2S0VVZW1TdjhKOUxvdTBMQUQyM1NzejMwR01m?=
 =?utf-8?B?c3l4SFlJN1lVelZSMnZxQm0zSXZrWGtKd09EWlBTdFVoYmtLMy82RGZRZUpt?=
 =?utf-8?B?Q2NSK3pqZ3dEWUUzdS9vM0h5d2x2YzVZajZhSkRkNDkyanQwT1pKNVM1bCs3?=
 =?utf-8?B?VnRKa0Rwd2t0OWNKTzN6SnVldElUQTJzRjFneXpwNlZsK0VTeHFSRVR6SjRJ?=
 =?utf-8?B?RGJ2cUMyV083aXMvaGkrZ3NQWWtyajl6WndQRW1BYWgxTEEraGV3cHIzM1U1?=
 =?utf-8?B?TWFWaTl4VkUvQTdFSG1PMzQvQWw1S056TnRlQlhTV2JHa0U1M3ZvcVZHYVYw?=
 =?utf-8?B?djluUkNFZlk5L1dFN0lGQS80Vkx4QVdiNEYrOHRNWm54UE81NGdHcmF6aTh0?=
 =?utf-8?B?OG5YNkZwcUNjU1VoTDVhZFJYYzQ3NmFldzJlVkNaaStLNnUrTUdTWjIrbit2?=
 =?utf-8?B?K1oyUWpOckYrUmtLdjc1MU94bDlreHNLTE8wU1ArZEJOU3lxbytGOThYTmRy?=
 =?utf-8?B?a0w1Z0tqQnhVM3IwNkorb2dUQjlWcy9IRTF2ZDcrMGU0NHJpL3M0L3RjSEJl?=
 =?utf-8?B?ZGJpcEYvSDJIYWZqZ3J3VXRaclk1WlNpK2o2QlhsMWNKdHNmMEFnTTRoa1l0?=
 =?utf-8?B?aXdOV2NROEpnS3NYTkdoWlVUL2FjUklMMEVFWGlSb1hkUGFzbW9UNkUyODlm?=
 =?utf-8?B?UWkzL1IyaC9iU01ZT0pVMEc5VkZzcjhVQmxWaVdhWmZJMjJKaTBFblRwYW9C?=
 =?utf-8?B?b3hJcnVzVmR0dzRBSlNVSS9TQ3FtNFpvUEgxUnNUNnRhZ0R6YStqemJ3bm9H?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D7541D58874B94F813282004FC8A253@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2YK1xJlo4guHtKo1942U/Aqg06snSt90Ydit2WRFNJ/yUL4s7A3jfGphNEabLf76X2M+cbPma95p9RupWC7JpKOaBxacClyTUuyvypnYd5JhleuhHEpe1+uqLog9Lyk5RUccCxfmM5xh3QxBaRu6xTeP0p5vyLOlJkRlazWDLZkbF2orEvl7GwDO3bZZM+7IVJYWWCB0U65YzipiSsRctqKyCeHjAl2hwizjF6SJlUXTvZenf/+3fb9ROF0+fWy0bC8xCdq8lbxBneaRh2Ot1R7xaLfYbhjovXGilY3KS26T0BoULWinJz2sXYBic5bt+HGrE+/kqYcx/Z1rFv4eu0WJx1C29qgeuXl1XywNOYAOxpBdXR/i2PlwPqym7gylpbdQ1+/+6EMDgZAQL4sxKGZqcF+m2aLXA05FbqqpfyeUn/4l8ooMRghK1HJj5RIyPNg3YiF2ANPkpYDN1/npOE7Bt8dStGdl/LGpU7aK4nR0IuTCS4hCGBpZZ/epXLlff40239AWZoUv8RUMzRE2nKY9DRtkbwAF8O9pPXBIWbUE5SjMOn09CRkhX3wTfNKd82R8ixTGYoitAxW4H0fSgO47ThR+FucvwKrQbYe3K592lycZhDBACAbq8P1sgACl8uEJ/s/J+tfMCrq9o7zBdLNcquv2ZJrXTdV3R/Qo3x1LonChW3Wg/r86PDCUb60Jo+Q0vXR+ZLKxrl9HwqsRYzuFsXF6J2XGEOC1avSLTNcXv6xBx55vU0b5VuFx8pzAoJ+fLFwNw8V5S7L92auKacY0liE9ZQYtnEE97lL8GpvNPg6AzgX0kowv7e18+iJt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9832ca-81de-406d-0daf-08dbe4b6634d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 02:07:00.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkwvunyxhLtgBL/5w0zcVP2ZP43PP9aTD75Xp09q9CBqRt8cEBUynSN/t+1vK9bQ8EBkNK7hU1+Eh//NgsRUyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140014
X-Proofpoint-GUID: mvbQpHhIn9IjYobHiwmQD8EtSSNmtrEh
X-Proofpoint-ORIG-GUID: mvbQpHhIn9IjYobHiwmQD8EtSSNmtrEh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIE5vdiAxMywgMjAyMywgYXQgNTo1N+KAr1BNLCBDZWRyaWMgQmxhbmNoZXIgPGNlZHJp
Yy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAxMyBOb3YgMjAyMyBh
dCAxNzoxOSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+Pj4gT24gTm92IDEwLCAyMDIzLCBhdCAyOjU04oCvQU0sIE1hcnRpbiBXZWdl
IDxtYXJ0aW4ubC53ZWdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gV2VkLCBOb3Yg
MSwgMjAyMyBhdCAzOjQy4oCvUE0gQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiAxIE5vdiAyMDIzLCBhdCA1OjA2LCBNYXJ0aW4g
V2VnZSB3cm90ZToNCj4+Pj4gDQo+Pj4+PiBHb29kIG1vcm5pbmchDQo+Pj4+PiANCj4+Pj4+IFdl
IGhhdmUgcXVlc3Rpb25zIGFib3V0IE5GU3Y0IHJlZmVycmFsczoNCj4+Pj4+IDEuIElzIHRoZXJl
IGEgd2F5IHRvIHRlc3QgdGhlbSBpbiBEZWJpYW4gTGludXg/DQo+Pj4+PiANCj4+Pj4+IDIuIEhv
dyBkb2VzIGEgZnNfbG9jYXRpb25zIGF0dHJpYnV0ZSBsb29rIGxpa2Ugd2hlbiBhIG5vbnN0YW5k
YXJkIHBvcnQNCj4+Pj4+IGxpa2UgNjY2NiBpcyB1c2VkPw0KPj4+Pj4gUkZDNTY2MSBzYXlzIHRo
aXM6DQo+Pj4+PiANCj4+Pj4+ICogaHR0cDovL3Rvb2xzLmlldGYub3JnL2h0bWwvcmZjNTY2MSNz
ZWN0aW9uLTExLjkNCj4+Pj4+ICogMTEuOS4gVGhlIEF0dHJpYnV0ZSBmc19sb2NhdGlvbnMNCj4+
Pj4+ICogQW4gZW50cnkgaW4gdGhlIHNlcnZlciBhcnJheSBpcyBhIFVURi04IHN0cmluZyBhbmQg
cmVwcmVzZW50cyBvbmUgb2YgYQ0KPj4+Pj4gKiB0cmFkaXRpb25hbCBETlMgaG9zdCBuYW1lLCBJ
UHY0IGFkZHJlc3MsIElQdjYgYWRkcmVzcywgb3IgYSB6ZXJvLWxlbmd0aA0KPj4+Pj4gKiBzdHJp
bmcuICBBbiBJUHY0IG9yIElQdjYgYWRkcmVzcyBpcyByZXByZXNlbnRlZCBhcyBhIHVuaXZlcnNh
bCBhZGRyZXNzDQo+Pj4+PiAqIChzZWUgU2VjdGlvbiAzLjMuOSBhbmQgWzE1XSksIG1pbnVzIHRo
ZSBuZXRpZCwgYW5kIGVpdGhlciB3aXRoIG9yIHdpdGhvdXQNCj4+Pj4+ICogdGhlIHRyYWlsaW5n
ICIucDEucDIiIHN1ZmZpeCB0aGF0IHJlcHJlc2VudHMgdGhlIHBvcnQgbnVtYmVyLiAgSWYgdGhl
DQo+Pj4+PiAqIHN1ZmZpeCBpcyBvbWl0dGVkLCB0aGVuIHRoZSBkZWZhdWx0IHBvcnQsIDIwNDks
IFNIT1VMRCBiZSBhc3N1bWVkLiAgQQ0KPj4+Pj4gKiB6ZXJvLWxlbmd0aCBzdHJpbmcgU0hPVUxE
IGJlIHVzZWQgdG8gaW5kaWNhdGUgdGhlIGN1cnJlbnQgYWRkcmVzcyBiZWluZw0KPj4+Pj4gKiB1
c2VkIGZvciB0aGUgUlBDIGNhbGwuDQo+Pj4+PiANCj4+Pj4+IERvZXMgYW55b25lIGhhdmUgYW4g
ZXhhbXBsZSBvZiBob3cgdGhlIGNvbnRlbnQgb2YgZnNfbG9jYXRpb25zIHNob3VsZA0KPj4+Pj4g
bG9vayBsaWtlIHdpdGggYSBjdXN0b20gcG9ydCBudW1iZXI/DQo+Pj4+IA0KPj4+PiBJZiB5b3Ug
a2VlcCBmb2xsb3dpbmcgdGhlIHJlZmVyZW5jZXMsIHlvdSBlbmQgdXAgd2l0aCB0aGUgZXhhbXBs
ZSBpbg0KPj4+PiByZmM1NjY1LCB3aGljaCBnaXZlcyBhbiBleGFtcGxlIGZvciBJUHY0Og0KPj4+
PiANCj4+Pj4gaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvaHRtbC9yZmM1NjY1I3Nl
Y3Rpb24tNS4yLjMuMw0KPj4+IA0KPj4+IFNvIGp1c3QgPGFkZHJlc3M+Ljx1cHBlci1ieXRlLW9m
LXBvcnQtbnVtYmVyPi48bG93ZXItYnl0ZS1vZi1wb3J0LW51bWJlcj4/DQo+PiANCj4+PiBIb3cg
Y2FuIEkgdGVzdCB0aGF0IHdpdGggdGhlIHJlZmVyPSBvcHRpb24gaW4gL2V0Yy9leHBvcnRzPyBu
ZnNyZWYNCj4+PiBkb2VzIG5vdCBzZWVtIHRvIGhhdmUgYSBwb3J0cyBvcHRpb24uLi4NCj4+IA0K
Pj4gTmVpdGhlciByZWZlcj0gbm9yIG5mc3JlZiBzdXBwb3J0IGFsdGVybmF0ZSBwb3J0cyBmb3Ig
ZXhhY3RseSB0aGUNCj4+IHNhbWUgcmVhc29uOiBUaGUgbW91bnRkIHVwY2FsbC9kb3duY2FsbCwg
d2hpY2ggaXMgaG93IHRoZSBrZXJuZWwNCj4+IGxlYXJucyBvZiByZWZlcnJhbCB0YXJnZXQgbG9j
YXRpb25zLCBuZWVkcyB0byBiZSBmaXhlZCBmaXJzdC4gVGhlbg0KPj4gc3VwcG9ydCBmb3IgYWx0
ZXJuYXRlIHBvcnRzIGNhbiBiZSBpbXBsZW1lbnRlZCBpbiBib3RoIHJlZmVyPSBhbmQNCj4+IG5m
c3JlZi4NCj4gDQo+IEp1c3QgdHVybiAiaG9zdG5hbWUiIGludG8gImhvc3Rwb3J0IiwgaS5lLiB0
aGUgImhvc3RuYW1lIiBzdHJpbmcgaW4NCj4gdGhlIG1vdW50ZCBwcm90b2NvbCBnZXRzIHRoZSBw
b3J0IG51bWJlciBlbmNvZGVkIGludG8gaXQuIFByb2JsZW0NCj4gZG9uZS4gVGhpcyBpcyBzZXJp
b3VzbHkgYSBub24tYnJhaW5lciwNCg0KSXQncyBub3QgYXMgc2ltcGxlIGFzIHlvdSB0aGluay4N
Cg0KQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoZSBtb3VudGQgdXBjYWxsL2Rvd25jYWxsIGFscmVh
ZHkgdXNlcyB0aGUgIkAiDQpjaGFyYWN0ZXIgaW4gdGhlIHJlZmVyPSB2YWx1ZSBmb3IgYW5vdGhl
ciBwdXJwb3NlLiBJdCBoYXMgdGhlIHNhbWUNCnByb2JsZW0gYXMgdXNpbmcgIjoiIC0tIGl0IHdv
dWxkIG92ZXJsb2FkIHRoZSBtZWFuaW5nIG9mIHRoZSBjaGFyYWN0ZXINCmFuZCBtYWtlIHRoZSBy
ZWZlcj0gdmFsdWUgYW1iaWd1b3VzIGFuZCB1bnBhcnNhYmxlLg0KDQpORlNEIHN1cHBvcnRzIElQ
djQgYWRkcmVzc2VzLCBJUHY2IGFkZHJlc3NlcywgYW5kIEROUyBsYWJlbHMgYXMgdGhlDQpob3N0
bmFtZSBwYXJ0IG9mIGVhY2ggZnNfbG9jYXRpb25zIGVudHJ5LiBETlMgbGFiZWwgc3VwcG9ydCBp
cyBvbmUNCnJlYXNvbiB3ZSBtaWdodCBoYXZlIHNvbWUgZGlmZmljdWx0eSB1c2luZyBhIHVuaXZl
cnNhbCBhZGRyZXNzIGluDQp0aGlzIGludGVyZmFjZSAtLSB0aGUgZG90IG5vdGF0aW9uIGZvciB0
aGUgcG9ydCBudW1iZXIgYnl0ZXMgbG9va3MNCm5vIGRpZmZlcmVudCB0aGFuIHRoZSBkb3Qgbm90
YXRpb24gZm9yIHN1YmRvbWFpbnMsIGFuZCB3ZSB3YW50IHRvDQplbmFibGUgYWx0ZXJuYXRlIHBv
cnRzIGZvciBib3RoIHJhdyBJUCBhZGRyZXNzZXMgYW5kIEROUyBsYWJlbHMuDQoNCkFkZGluZyBt
b3JlIGhlcmUgbWVhbnMgbW9yZSBjYXJlZnVsIHBhcnNpbmcgYW5kIG1vcmUgdG8gZ2V0IHdyb25n
LiBJbg0KdGhlIGtlcm5lbCB3ZSBkb24ndCBoYXZlIGEgbG90IG9mIHRoZSBiZWVmeSBwYXJzaW5n
IGxpYnJhcnkgc3VwcG9ydA0KdGhhdCBleGlzdHMgaW4gdXNlciBzcGFjZS4gVGh1cyB0eXBpY2Fs
bHkgdXNlciBzcGFjZSBuZWVkcyB0byBkaWdlc3QNCnN1Y2ggYXJndW1lbnRzIGFuZCBwYXNzIHRo
ZSBwcmUtc2VwYXJhdGVkIHRva2VucyB0byB0aGUga2VybmVsLg0KDQoNCj4gYW5kIGNhbiBiZSBy
ZXBlYXRlZCBmb3IgYXV0b2ZzLA0KPiB3aGljaCBkb2VzIG5vdCBkbyBwb3J0IG51bWJlciBlaXRo
ZXIsDQoNCmF1dG9mcyBpcyBhIGRpZmZlcmVudCBzdWJzeXN0ZW0gd2l0aCBhIGRpZmZlcmVudCBt
YWludGFpbmVyIGFuZCBhDQpkaWZmZXJlbnQgc2V0IG9mIGRlc2lnbiBnb2Fscy4gTm90IHRvIG1l
bnRpb24gdGhhdCBpdCBhbHNvIHRyaWVzDQp0byBzdGF5IHJvdWdobHkgY29tcGFyYWJsZSB0byB0
aGUgc2FtZSBhZG1pbmlzdHJhdGl2ZSBpbnRlcmZhY2VzDQpvbiBTb2xhcmlzIGFuZCBvdGhlciBV
bml4LWxpa2Ugb3BlcmF0aW5nIHN5c3RlbXMsIHNpbmNlIGF1dG9tb3VudGVyDQptYXBzIGNhbiBi
ZSBzaGFyZWQgd2l0aCBub24tTGludXggc3lzdGVtcy4NCg0KTGV0J3MgZm9jdXMgb24gdGhlIE5G
Uy1zZXJ2ZXIgc3BlY2lmaWMgY29tcG9uZW50cyBmb3Igbm93LCBwbGVhc2UsDQphbmQgaWdub3Jl
IGF1dG9mcyBhbmQgdGhlIG1vdW50Lm5mcyBjb21tYW5kLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==
