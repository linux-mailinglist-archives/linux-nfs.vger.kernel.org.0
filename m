Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446467ACA16
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Sep 2023 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjIXOpM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 10:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjIXOpL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 10:45:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108AFB
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 07:45:05 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OAFq9K028057;
        Sun, 24 Sep 2023 14:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dY9EnKwpwnudhyaKY2nbc4eH3NQr2VQ+zAyfDgKRAK0=;
 b=CFAv9wZ1crvBwntTlVf/jDQiib2Bb7PQmv51eIK4gXFnj+bz/dkKYUcfk5t1QNustziI
 yp4Em3+fqzO3KKFrM7ZoMd2lL6LYyJpnEnjX1E/i8EeJ4Y/fnN+3mk5kj+fb0qI48VoR
 O6IE/FZUT8Sdhh3D7F/BXTUUBBDVrirtiG/Im9GH6NXywSddIWcT1b4mGixe4d9hpOHp
 6qyl9KOzQTWDhFw6WB7e+FTZhNYnApXnCy0urBGxlniywXHEq/f9qiH8xKlfKbG8rErT
 RgGBtSWauGNaWt32awSecawRL+bByIbCQ1tXSNZ6S7O9vy08xksFnfMBAnbzr6NqoD+8 nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxbt3pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 14:45:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38OBMfDR035041;
        Sun, 24 Sep 2023 14:45:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf3qecs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Sep 2023 14:45:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1NZ+KsWQQQz0z23/0O1XEkryY873KCkui0MUN1nzMxK1OoLyOz6ZUvS+SKiPf7zZsK5V31iEotp9UzWEMgJzOLK04o15z2Gp8APC2SNRXhdcb9FdlEE5k8KeV4WWPRKwVs8nJf9BwxbPY7aKJxP/zDE6EqxqoBd3tZNo28XQGvLgYh9zmwHmXqoFE/x4EP4qYxfffiIzmC9pHagpmHIclVGF89Ow3XHVSIJPo3KgSGGPLhyABT2avmO5hjwV4lZdYqAKWTRvmORtebPN7a//vlAvuYjVMq6rkhwyEx10GHaDGciq5XqlYjmXs5W2G4ZLN5OGvVKL4MG3VHvUqVsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY9EnKwpwnudhyaKY2nbc4eH3NQr2VQ+zAyfDgKRAK0=;
 b=hMqBSEqQKW5vkG/lZ03zY8DXQ1SUhHK13UlWtpC9ZznSnwPfVksqIZQb/Ev5O3Ujg9JriU9b2C0db6d3RW5zkoiMNXfeXxIU6/QyWfXNnnV2sGbQGK+xI/FBbELi2IQMlcmHGRivD/vcX7J24c5TaSqG/lvIzcE1b9SW0jkbHwsZvmA0FTNvFsWdmJ80GV3qBA11tDIdDsaEriq72wKuZkw2+H7qhFhs0OimKPeY5LaFcyEM+TOv1GSzCHrUIapmu8f45vkJR8hlxbdnB/O7Dz0njN/3u5BxzaOZeCen7z+a7n+rT8kwveOYdxmJBXKri1VUUEMGfuSqIWHR7iFebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY9EnKwpwnudhyaKY2nbc4eH3NQr2VQ+zAyfDgKRAK0=;
 b=S78/sxdL3Wag7eByCkjtBrpXQ+15cjHgGFMbMtAge1war+kFzP27NMcUUf3SmlJM2gxPSPo/lsx2MQyGMtW//EhoSlVH2hnPcnitbKASBLZeyrCvhYUFw5ZIrglNi7w/IJIG3jw4+t5rqn7QR6+PLENOTC7h4abSU6St0u2uEC8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 24 Sep
 2023 14:44:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Sun, 24 Sep 2023
 14:44:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Thread-Topic: Data corruption with 5.10.x client -> 6.5.x server
Thread-Index: AQHZ7uglcAk7YvaB4kSAn1xCF15i5rAp+BsAgAAR7gCAAAN6gA==
Date:   Sun, 24 Sep 2023 14:44:57 +0000
Message-ID: <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
In-Reply-To: <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7763:EE_
x-ms-office365-filtering-correlation-id: e18fd7c3-126e-44c5-e71c-08dbbd0cd288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOYeUzEtZ8+5wrtut2DoLRUuk/0YZXqWQTGmOqs9M89reny9/1UfHm2V0498QvrPLWyF/V21DtDMvOIf8Y18NIFrPDausRXKJ438lfUJqzVLlOTKM9FbwKAub+RkrKdlVYCRGGuRBgBSKO82nVq/5lS86d0HeXOAK6MGC1xAzCzLLLu4xfcHC0k5khCr4JQpWyN4++xp+QiHSiFjcNjG7qDo2RuEBu98j1dhD04VywgA62OmKD1UFy56A6ysyv/WRXAzwixyskoDN4e/0A7gnn+hM2YeX3PauOBiGI2d3AlHCh7xmFaOoNYWasCkrQcd2sx9Vv5iMaKTYqzlLo+MWZHStZAi+4bD1RgWauAPkqACpMDYH3j2qmrAd/hKEDpdgQOZpmo/wW5P0p0w+ObPQgO2JlO0gHSmEbjB50rxq0WGqdEVV1TCJztwQBg0WH+xJ16DTIU5fpDr+iW2LstotVxl873nd6sRaABOei1kglYTQLb92RHQmlodCN9oyzSRX4m9p0lCRkQzcjKXbfSmzzZG3wHATpIx8LcnPiDRKh+WciHSbLdKz/Oe8A6Damm0wMFvayK+tS3tzrhv7Gp3dEMXuyQHPNmqMFmgEC5OfizR8mUdhfn5VYXQWvqn7GNkKfUfkEaM5ebN4VQ9ZroQNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(8936002)(4326008)(8676002)(26005)(91956017)(2906002)(478600001)(316002)(6916009)(41300700001)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(5660300002)(6486002)(6506007)(71200400001)(53546011)(6512007)(36756003)(2616005)(66574015)(83380400001)(122000001)(38070700005)(38100700002)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a05GTXFrZUFxU0RXL3RSMDZlbFBWOUxpU21mYjlsMVpYUjVVeWFYNVZPOHJS?=
 =?utf-8?B?eGpNSXhVaGgrd1p4d3JJWWF6VGNqODVTQ1hOb2lLNmNqQ2puMFgxbWRhNkNQ?=
 =?utf-8?B?RFBHWXh2TDBhWkZzQUZCcXAyb0cvMnB2ZndiK1dSaTFLclQvRlY0U3AzTGxX?=
 =?utf-8?B?S3lIdTNZZ1g3MjErb2RzQnI0Um94d1d4SXVtaE4yaGdwMEVRSmxkd1pTVUpj?=
 =?utf-8?B?Wm56eFVYYlM4VnNSa0RpZVBkd093WTRhU0FObHF2NEsyMldSTll1dW9XUVQx?=
 =?utf-8?B?NU1FTnphVGVCL1pUVzd5SFdkU1hvNU5BWjg3Q1N1RHdWQm83N2NjSHVIaXBv?=
 =?utf-8?B?QndFUHFpUitzNFhJT1hYZEJOM3FCRGxBZ1BWOGtSbVYwTk8yZjB2NjBlNkdY?=
 =?utf-8?B?U1ZXZFllQWZ4bXFGa3FIT2owYmNmQXE5Q0dTMGdmelc5aU5PaFBTTHRITUNU?=
 =?utf-8?B?bmZmRmZQZnVja3hyQmltUWNRL2pmRjVwYVhRTG82c2Z2ZzBKUWROY1JsU0JH?=
 =?utf-8?B?c0RTQWlmaEEyV0pXeUZvM3JkMWFoQkVrOE9KOFdrbG1aQURYbnlUSm5xM2oy?=
 =?utf-8?B?ekdmanN0THFhc056REdUQ3V6QllDa0NIYm5QOXBCZ0dqZzVtMW9jUUlNSnZH?=
 =?utf-8?B?YlZ3ODFwRUZ4VzQzaFUvK3BIUHc4a1cvVjAxWGFDWUJaSi9kZW5mZGw1NllS?=
 =?utf-8?B?Slc3ZWdXa1g4ak5xQlRGSC96SnRmT2NCeE9ET2RMaXk5OHRsdEVmc1Vxbkdt?=
 =?utf-8?B?eC9sQlAvQ2VuQ0FITTlDUnFuSmVVUGJyeFF4Q2lVLzNPS2M1Z1NKelhxTkw1?=
 =?utf-8?B?UDZCc3ZaeDg2RFZYRUtqNHkxekFydnlvYUdKS2xZSXpPaEZ5L29xcitSbllW?=
 =?utf-8?B?elFYUTJYY3RPQU02TE9rVEdUc01hUVRlL00vZUpWWEl3dDFtRzhJWjNWaldF?=
 =?utf-8?B?WWJ1UUNEMGZRQkx4ZTJqZFc1Q0ZUeURDaVFBZG9RdEZoa3FOWW10WHZGazFL?=
 =?utf-8?B?V1Z6c1VWbDNtVXl5Tit6VFArZ1ZVTlp6VW02TG96cC9hNzQwV1JlcFZtOHZN?=
 =?utf-8?B?Nlk1NXVXNWJVczJuMis1c1o3WEljSDA0a3FPeEJrZUg4TVhTYjVXS3d0bnND?=
 =?utf-8?B?Ry95UnA5Tmc3eEZYMmZDMTB0N2lmSnJOSVpRVDNXQ3hPSkNIUVpNZCsyUFBz?=
 =?utf-8?B?dEprUC9YbTdMYVZCa0ZhQ2U0NVVhanZFZW1LblB5ZnhKZGtORXd0V2haRUpi?=
 =?utf-8?B?ckFIZjlXYUhSU0NaNDcyMzRUK0pFWGlyY3o4QisyTXhPU3lTWnRKNXhaZUd4?=
 =?utf-8?B?VHYxOVFTdDNjblV2aHI0WnRpRGxxbGJGZ1hmeVFMdEd0YW9kdXZZR2NEamhj?=
 =?utf-8?B?Nmw4eUVaZjNFcGJnN0FLby9CUENYTGpyTW45Vk1nYlBTWXhZaEl0bnA2Zytj?=
 =?utf-8?B?bHNVaklvTk9mVUFjSjZiSmJTWDdPQjZMcUlRRzR6dTdxRGJwVi90OFVPb21o?=
 =?utf-8?B?K2lJbkRSeFErQUp3UWtkdDI2M0MvdDUwRXowSjd3bkN5U211RjBJWjl6ZlY3?=
 =?utf-8?B?S3R5OFVoWHFyRTBIR3FNcUhSVE5aTThPcnJWWG9pZDU5WjhLSWE0U0FFdTZ4?=
 =?utf-8?B?Y0xsOWNQVVRsQ2NoTmNLSFl6RnFDY3lVc3cyNGpCRXkrOVI1UGlwSXdqVmZh?=
 =?utf-8?B?ZnZLeUt4RW5JREh4WlBOUEVFK2dkeko0cFl2a2l3UkJZUnBZekhZSjJvZHRR?=
 =?utf-8?B?MFBVUTNLcUFJMVAwUlR6SGRsMDdwdjA5dVFRN0VOd0dXQ29mSGY3K3luaFEw?=
 =?utf-8?B?TVFKeEFkR2lldy9QY041aHpCQURZeGJsSndMVm1RdTQ5M2pCWTNJSVZtQzJT?=
 =?utf-8?B?NUtvTHVkelQ5L3N4bk02YXBKb1BXeE1BTldNQ1dPS2pDY3prTzV0SWdXRm03?=
 =?utf-8?B?S1lyMisydlBVenRidm1HTi9BTEd4aG83NVZuWnUra0UvdkgweFRRUkIzbEht?=
 =?utf-8?B?NHhrSU9yS2FTOERBSExDVy8xR2hZbFJmVTVnL3VCNXplMHNHVWxTSFAyNlhv?=
 =?utf-8?B?alJZWjBETnh3ZFMvTm5qWWNXeDRNU1hRVTFqQVZoUFJ0TXlNMU9CbTF0dEZE?=
 =?utf-8?B?ZEJjUFBlTlh0cUpyODJrY0IvSFBvcHVuYnAyVHc4NXBrUFo2SXQ0ZzlYN1Rv?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6CE8A65A8CFB740A325F663CCAC4271@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pvNxRe3mHPAQH1oj/w9eQ7rCB5XLFeoio0kyKtmpUZ0XOzDwKLD5/DkHTEViZvRf39nOytEr0zWMg0MVCjkvRbP62AX01VdhKZJ+QQpFgUDwAAMkE8TjB8TH6GgGH1xgRe6BC1bVejLJOVb9+bU5w+U4exDT85DfMfoFxS6R8w/DiwyWb3e7ZDXEi2/BG2Yf1qmJh5UKhUMViI+OKRQtyk05whmfe9ID3s1gEhs7XnMAmzHez+2WJ0LHR9q2rsUB0rfIa8y8sjal/3C7t5N4Ay37TooDkuf00f6RTfgFgW1tGuAzHVSXwTsM/gdsxGQ0QVRs2rBUgYxV7v5lrIpB8vfFsnVgkwXSNElu8pVPCLOOHbzHO7iIooPuM33C+WyDyFEkqUDp0A9n7bbSpFhTXI5jvg9Q0vDh1lAiM66nXQVz1Ndu9+m0V6talWjU40R3jCHUu1/kTYw8Xcf9YgICipgAMzgH1o7WAExPyHMqNBS5JUxR4JWNEn4Rx86tqUXAwQWfIuZyOn9R+asJ628S+B7MyHt6t7riJuyZf6bhATGrwKRftR5+m7Sj491J9mvp73Qsey9/94+vw0jgkGq2U0pxQJ6vMSHZZ6yMMksCwufAbc22hpjM8XxSWHzv4HibMBIqzbDPNf+yeaF7PmcfRke2EaQUZdkaZQPkka2mbQ+mZU29gutbmQfR6SxSv2UX7/1+ZsVmoWDUbnXmmS7ooarN7f1jphksUnXqmyCUjFScVdMYwEpSC5aAUAq5nL8FKA4fGmX1VVT6qvSxZqWmYoFBKopGAqoKOKw6TKOxZkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18fd7c3-126e-44c5-e71c-08dbbd0cd288
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 14:44:57.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jw+DNzomOxsFx/uaPF7UXF5tFan5sZG8NPyAcaV9y6INFAuOKed0XR4+/DSaCZQoAdiyAXDsqGPlTAR+g6Zr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_12,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309240130
X-Proofpoint-GUID: LZB78VvNdL0M0RDm0t_qhVsngR3yB-gJ
X-Proofpoint-ORIG-GUID: LZB78VvNdL0M0RDm0t_qhVsngR3yB-gJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI0LCAyMDIzLCBhdCAxMDozMiBBTSwgTWFudGFzIE1pa3VsxJduYXMgPGdy
YXdpdHlAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjMtMDktMjQgMTY6MjgsIENodWNr
IExldmVyIElJSSB3cm90ZToNCj4+PiBPbiBTZXAgMjQsIDIwMjMsIGF0IDk6MDcgQU0sIE1hbnRh
cyBNaWt1bMSXbmFzIDxncmF3aXR5QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSSd2ZSBy
ZWNlbnRseSB1cGdyYWRlZCBteSBob21lIE5GUyBzZXJ2ZXIgZnJvbSA2LjQuMTIgdG8gNi41LjQg
KHJ1bm5pbmcgQXJjaCBMaW51eCB4ODZfNjQpLg0KPj4+IA0KPj4+IE5vdywgd2hlbiBJJ20gYWNj
ZXNzaW5nIHRoZSBzZXJ2ZXIgb3ZlciBORlN2NC4yIGZyb20gYSBjbGllbnQgdGhhdCdzIHJ1bm5p
bmcgNS4xMC4wICgzMi1iaXQgeDg2LCBEZWJpYW4gMTEpLCBpZiB0aGUgbW91bnQgaXMgdXNpbmcg
c2VjPWtyYjVpIG9yIHNlYz1rcmI1cCwgdHJ5aW5nIHRvIHJlYWQgYSBmaWxlIHRoYXQncyA8PSA0
MDkyIGJ5dGVzIGluIHNpemUgd2lsbCByZXR1cm4gYWxsLXplcm8gZGF0YS4gKFRoYXQgaXMsIGBo
ZXhkdW1wIC1DIGZpbGVgIHNob3dzICIwMCAwMCAwMC4uLiIpIEZpbGVzIHRoYXQgYXJlIDQwOTMg
Ynl0ZXMgb3IgbGFyZ2VyIHNlZW0gdG8gYmUgdW5hZmZlY3RlZC4NCj4+PiANCj4+PiBPbmx5IHNl
Yz1rcmI1aS9rcmI1cCBhcmUgYWZmZWN0ZWQgYnkgdGhpcyDigJMgcGxhaW4gc2VjPWtyYjUgKG9y
IHNlYz1zeXMgZm9yIHRoYXQgbWF0dGVyKSBzZWVtcyB0byB3b3JrIHdpdGhvdXQgYW55IHByb2Js
ZW1zLg0KPj4+IA0KPj4+IE5ld2VyIGNsaWVudHMgKGxpa2UgNi4xLnggb3IgNi40LngpIGRvbid0
IHNlZW0gdG8gaGF2ZSBhbnkgaXNzdWVzLCBpdCdzIG9ubHkgNS4xMC4wIHRoYXQgZG9lcy4uLiB0
aG91Z2ggaXQgbWlnaHQgYWxzbyBiZSB0aGF0IHRoZSBjbGllbnQgaXMgMzItYml0LCBidXQgdGhl
IHNhbWUgY2xpZW50IGRpZCB3b3JrIHByZXZpb3VzbHkgd2hlbiB0aGUgc2VydmVyIHdhcyBydW5u
aW5nIG9sZGVyIGtlcm5lbHMsIHNvIEkgc3RpbGwgc3VzcGVjdCA2LjUueCBvbiB0aGUgc2VydmVy
IGJlaW5nIHRoZSBwcm9ibGVtLg0KPj4+IA0KPj4+IFVwZ3JhZGluZyB0byA2LjYuMC1yYzIgb24g
dGhlIHNlcnZlciBoYXNuJ3QgY2hhbmdlZCBhbnl0aGluZy4NCj4+PiBUaGUgc2VydmVyIGlzIHVz
aW5nIEJ0cmZzIGJ1dCBJJ3ZlIHRlc3RlZCB3aXRoIHRtcGZzIGFzIHdlbGwuDQo+PiBJJ20gZ3Vl
c3NpbmcgcHJvdG89dGNwIGFzIHdlbGwgKGFzIG9wcG9zZWQgdG8gcHJvdG89cmRtYSkuDQo+IA0K
PiBZZXMsIGl0J3MgVENQLg0KPiANCj4gKEkgZG8gaGF2ZSBSRE1BIHNldCB1cCBiZXR3ZWVuIHR3
byBvZiB0aGUgNi41Lnggc2VydmVyIHN5c3RlbXMsIGJ1dCBpbiB0aGlzIGNhc2UgYWxsIHRoZSBj
bGllbnRzIEkndmUgdGVzdGVkIHdlcmUgVENQLW9ubHksIGFuZCB0aGUgaG9tZSBzZXJ2ZXIgdGhh
dCBJIG9yaWdpbmFsbHkgbm90aWNlZCB0aGUgcHJvYmxlbSB3aXRoIGRvZXNuJ3QgaGF2ZSBSRE1B
IGF0IGFsbC4pDQo+IA0KPj4gRG9lcyB0aGUgcHJvYmxlbSBnbyBhd2F5IHdpdGggdmVycz00LjEg
Pw0KPiANCj4gTm8sIGl0IGRvZXNuJ3QgKG5laXRoZXIgd2l0aCA0LjApLg0KPiANCj4+IENhbiB5
b3UgY2FwdHVyZSBuZXR3b3JrIHRyYWZmaWMgZHVyaW5nIHRoZSBmYWlsdXJlPyBVc2Ugc2VjPWty
YjVpIHNvDQo+PiB3ZSBjYW4gc2VlIHRoZSBSUEMgcGF5bG9hZHMuIE9uIHRoZSBjbGllbnQ6DQo+
PiAjIHRjcGR1bXAgLWlhbnkgLXMwIC13L3RtcC9zbmlmZmVyLnBjYXANCj4gDQo+IEF0dGFjaGVk
LiAoVGhlIHNjcmlwdCBJJ3ZlIGJlZW4gdXNpbmcgZm9yIHRlc3RpbmcgbW91bnRzIHdpdGggLW8g
c2VjPWtyYjVpLCBjYXRzIHRocmVlIGZpbGVzLCB0aGVuIHVubW91bnRzLik8bmZzX2tyYjVpLnBj
YXA+DQoNCkkgc2VlIHRocmVlIE5GUyBSRUFEcyBpbiB0aGUgY2FwdHVyZS4NCg0KVGhlIGZpcnN0
IFJFQUQgcGF5bG9hZCBpcyBhbGwgemVyb2VzLiBUaGUgc2Vjb25kIHBheWxvYWQgY29udGFpbnMN
CiJIZWxsbyBXb3JsZCAoNDA5MyBieXRlcykiIHJlcGVhdGVkbHksIGFuZCB0aGUgdGhpcmQgY29u
dGFpbnMNCiJIZWxsbyBXb3JsZCAoNDA5NiBieXRlcykiIHJlcGVhdGVkbHkuDQoNCkxldCBtZSBz
ZWUgaWYgSSBjYW4gcmVwcm9kdWNlIHRoaXMgaW4gbXkgbGFiLg0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQo=
