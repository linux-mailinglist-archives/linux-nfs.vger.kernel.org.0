Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD87C6E14
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbjJLM1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjJLM1U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 08:27:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDEECC
        for <linux-nfs@vger.kernel.org>; Thu, 12 Oct 2023 05:27:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C92JPE023333;
        Thu, 12 Oct 2023 12:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mbtLK+pE//ECF85YzB8/bQDmzyRNcZkbAPndoVoJ61A=;
 b=JIGR+LN9Qp5RPZYgvQde762Fxm4/b9LkUJxvxZDeuIEO3PYqFPqUkkQwerPqu+3JajJ5
 aB3GFP7PiqqafP7dCm0c3fLonHj1VKB6MK9NnE7NTsJW7b+X3aF2tceecn6hVZARDjGJ
 mYvd9m9d0LRYf555RRvvi6hlyf5MMBCuxdWyt68Npey2m+kv0RgIRvJjl57nNhFUUq9M
 BkHu129AHuPdNsahCW3DV5OaoCS/u/slblaPkMzcP8qqDZ8poeHwu/qLjnKi2GDE2Hgx
 Ktls3bTp6wU+YdC3Y8aoDWdvnFsLnFLnUNRnIJyKyu6rsBGN1vBh+4HMixkAReomGkvz 0w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxuan0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 12:26:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBidEx034920;
        Thu, 12 Oct 2023 12:26:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsa8vge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 12:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJYQGdPA7OtGyj5wwVBClMwPnDXYq4dA2f7+J8nIR9+FHbieNDqAOqON6ndueM4ePPYNqUtU1DvU2eRUVdwpkyVNiBGvRE+Wl+EfW9EbN/QaCn9UpUAxpkSIOC0WVcWltEVVCM5Ywp2vEUNMPj8Sw5/5/bQR18tSesYiLygzW2vDQBO8oOM5ii77TO60P/QZN6nPOKUhRKeTILsu5lek1CdDkxCzGKHOBqPdywmYv5wng+3GbN6ZTjBlp/JAFX6FUzoAHn3g+vVmI9QLYv761FPo0G+MVrAt0JmXnYym7fOHbh4HRqOcYeDeHQpGx2YY6bzKh2t+n7/NV1G+2ErqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbtLK+pE//ECF85YzB8/bQDmzyRNcZkbAPndoVoJ61A=;
 b=AMvZ/W+X5z1fZnhdCvBiGRl1syCaP71tWxc4YRQS/fnaEiBhoyDFhq18iiPomf0bBWqZYb/BJ6d/6KMkMaXr5WTJDt1EphzOS2QD5fBkrKAxqwS4WOA242KJgopRmZQhu8ZEk9by7ETfQqvUZS19l7Haqz8zHxIc/IN5LdwUjeINcKxObyLP8HQMB/M+j2o6wCd8fwcgAI/DZ4A91YefSmwM+XjB3MjUgLkrjkC5SGk8Jre1VEDrtpQlhWKVLEL2VBLEGouw9Iz0gPMifZlCXKnLv8qpQ9NXD9wGTrHKFGyjFc0VZ2SePytpL8OoDyYD4yKPcXxVoiL1GB+YyZLPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbtLK+pE//ECF85YzB8/bQDmzyRNcZkbAPndoVoJ61A=;
 b=JxE8AzWnJ0mIVJVQDUkkBJ2Sek5tN4ANFduF03fLUzFi2WTLs63MAIdI9SNLNEuCE2HOvdrpbm4L9BWWuqBdRBJygcXJ6UJQoMGoaiNBmuQbN/mI4L+PwYJM7gj/QFnUY9AQrRFMi1ERiEfsJZmwC/f4L+jWwQCUcN7ZXydH3+g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Thu, 12 Oct
 2023 12:26:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::cf32:e9b3:e1e0:9641%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 12:26:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?6buE5oCd6IGq?= <huangsicong@iie.ac.cn>
CC:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: clean up alloc_init_deleg()
Thread-Topic: [PATCH v1] NFSD: clean up alloc_init_deleg()
Thread-Index: AQHZ/OcG8LABiXmnrUW8EtIoXANEhbBGFNiA
Date:   Thu, 12 Oct 2023 12:26:39 +0000
Message-ID: <77D3B950-8F4A-4526-B70A-72B34E85BEB1@oracle.com>
References: <49ad6b84.57cc.18b1de7572b.Coremail.huangsicong@iie.ac.cn>
 <168b769e12553d9a5974943f523de2f8b903d61b.camel@kernel.org>
 <280c4ab8.22ed.18b230651e6.Coremail.huangsicong@iie.ac.cn>
In-Reply-To: <280c4ab8.22ed.18b230651e6.Coremail.huangsicong@iie.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4139:EE_
x-ms-office365-filtering-correlation-id: a15425c3-07d6-4fda-9524-08dbcb1e7c45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L1i/sX1e/maBre1uPht0Km5IcvfUKr9VzjNeZL2KdnR4FGrH0DaAAis5TfXQggU3vUN8XWEDwBKZjOFD+GHCzIUZeRyOK2+zWv/vyYxDmi+AV0agPl/dM7yDCQyW63Y2dlZ3vYDiAv/b73WQ5PoSZAUYHdI5fTtX+WAD0GMwj3Ad52dKzfqsROrpU1U3ewf6B1PERExfNno1gbkoyNATe6qiuFr+upTUFusfHbfIEvvE3kgQmGvgxvxSqpgSEiQD/dQLfOVCw1JPQ0KiRaUMvpXCYjKYf+AjMqThPx75NVKuZE0NeyZlJv3jblGMyTljNdbCHM/+FY9IgBOAPYKAbM+AEx4wqPRlWnqkYCiGVsiq27DCPuFX5Qb90ZnAhtihFsBNwTj8xFPi/95lfvfFhs2tgYu1C0Vrvuq0rKxCHjTbHdg06BMmR38tWdlzGUzgDY5X1xCH4wdMwnCsDb7tI668yDfAdl2ntTRuq32WYZP+XbonXEAXC5GK/fQp8sLkqpIweggpf4iTrfoOeFVYusNXS0cXbyLpwdqekUDubPOn2s1J+iPlsYX1N37AETSzXy6cNPbrp5IGcHnERtSo7Djs2BYxz6s2G5eaVOPrAMir/ZWPRYhQ7Cm9LaFhKIHlium+lb5Qt3cfMnpTUSOnfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38100700002)(86362001)(122000001)(38070700005)(33656002)(36756003)(6486002)(2906002)(5660300002)(8676002)(478600001)(53546011)(71200400001)(6506007)(41300700001)(4001150100001)(8936002)(4326008)(6512007)(66946007)(2616005)(6916009)(64756008)(316002)(66556008)(54906003)(76116006)(66476007)(66446008)(83380400001)(91956017)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTAxUWdxR2p2bWUvQmNHRmtvNUg2Z2dScGI4dUF0eS9Ob2RxR1VpdFowbjNi?=
 =?utf-8?B?SENjSXBOKzJFa0xGM3UrajVEQ2Z3ZkNwUkNZTGpKS0I1UTg5NVRlQ05QRjVt?=
 =?utf-8?B?UWVMemk2eTRZVHdsQVJuUTRQVUxwcjhDa1JZa3FvQ2dyYzFiUlgwYnZZQkxX?=
 =?utf-8?B?dU5nejBZaExWenJBRGl6YW9uYWg5T2VNZUQzcGE4M2MvR2NVNDQ4TVJkS3pJ?=
 =?utf-8?B?SDcxcDFtNllFZ3FoM2t3ZUdLdTM3T0svR2ZKRDNNYkxmdURHMEFJYzVWaGJl?=
 =?utf-8?B?SCtncEFrVzlaYjhVNUFmQWxJS0xIVHdEMGUwSGU0K04vMlkxV1dQNWwxWFNJ?=
 =?utf-8?B?cCtnYXYwQVdWaVNGZzE1N2tVNGtNTDJhVU82OFc5bVN0dXo4SG1MUTlJTXNI?=
 =?utf-8?B?NDZIVlMxWTJlOGpOdW4vOHA2K2FCWjNDSElpMmNvMFd2OWJ3NHJDWVVKQlNY?=
 =?utf-8?B?b29vSy80clVuT1M2QVFhS2dYSlRoeWh5ZlZ3aThQeG1sNmIxY3pUN2FOa1pR?=
 =?utf-8?B?V0JwNnFWazJtd0cxU043STJ3SVhNdmdXZkhhbFR2c1RLNGFuaVEwZTk0RXRz?=
 =?utf-8?B?UlYzQVBDWEZ6czVXRW5LUlRJWXZhZjlaTllpZFR1eFB3YUFJd0NoQ1MvR3Jl?=
 =?utf-8?B?VU9ZZHFJekJLNnhVZGxVYjcrc3d1RkJuK1hRMXNlT1FTdHZMZEZhc1NBY3dp?=
 =?utf-8?B?OE14dzh5aHFSM0gwclVrRzRxMjZFOUdTV0tRdnVPckhraEEySU10NmZpOVc0?=
 =?utf-8?B?TVJYZkhtUHlUcXJxZXRuZFB1eFF0RVBlekVRVHJ4RVJVWUFZWGVHVUw3MTY3?=
 =?utf-8?B?OU80dlV0cFE5VVo1eDRzTmI1eUFUOGhmSnpPZ1ZjMTYrT0ZaOTd6Z1hzdHFI?=
 =?utf-8?B?WXJMcnNGK1BEb0ZxbU44SkgwU2JOdnkrT2d2ejIrbkZ4NHI2b0Fud09WaVhr?=
 =?utf-8?B?VXE2Tmo3Q1JscTFuQ1BLaUJUTy83WlRhTWVSY0R0SGdDR2xtazhjT2d5N2ZU?=
 =?utf-8?B?cWE3K3EySmdkWCtRWEg1K3dVNkpGZGFzRGNoK1Vmakd4K0c0L3VsYWNaVk9y?=
 =?utf-8?B?bzMyQ1BvRllZVHd2WjhEUktYbHFQa0xncjFqcjJzSWdoSElQQlg0OXZ1d3JW?=
 =?utf-8?B?cFFiTk1sRitDb3IzZDNUS3JHQVd6NUVQWnk2UjZKanIrTWpDT2lnTldKUkZ4?=
 =?utf-8?B?dmt0d1FvNFQ1d2ZjVEJwTXhNLzFFRERONXloSUJweXplVWZHZUlLQVF5SWRk?=
 =?utf-8?B?UkJUUit1SEx0Zndab1lRWStGWjhqeTVZY0p2OHRFanA5WGdiblR4L2pja042?=
 =?utf-8?B?aGc0Q251UFBnVkMzVGg2MWp4Z1VTNWduYlFQVjdhblFiYVVaVnBpQkFFZUpa?=
 =?utf-8?B?NDEwaktKR0ZVMWhBaVBFWFQvaXhsNEp1UXlYbFlOOXIrMFRJS3VEYzJVWmty?=
 =?utf-8?B?SzBBK211MVRkQTNMNnpkd3BGMEkzZUtiTjdzcy9zVm9IWDkwb2l4VnN0L1RC?=
 =?utf-8?B?YTRwZWlyN2QrUkVseWhpRFRCVXpWeC9SZzhPclA3bXg0K3YwcWZhZ3JCcXhx?=
 =?utf-8?B?UUNiVHFKUEUvaWFxcjJQVitjK01MSGxrZytsZm5kM2tFa0xEN1N5aktCWFJH?=
 =?utf-8?B?OVBrSnFqbmlkUzM0Y3FUMmVQOWZyN2w4TlBPSit3VmZnNnI4RU9pejNKWFF1?=
 =?utf-8?B?U1ZJNkovVEJzSFErK1BjSXBYSFNiaU9XODFFVXA1T3VzKzBwb1VQUUNSVzJs?=
 =?utf-8?B?djhVQjd4TXRkM281bjJCVXdhTUErSzZtdkYvSWxWZjh4RlJwdllyOXJzbEFy?=
 =?utf-8?B?VnpDRXZBMVEzYjBzekgyZ0loUmlyU1NlWEdqRm9VWC9VaUxYNlNDWVZtUUNq?=
 =?utf-8?B?YVM3Z2x2aUFhYXFnc1psVlJIa1F4d3d6VG9tMHlNZmtNMURYYmR3VHRyWEkv?=
 =?utf-8?B?anRGTmxydS9BZ1hiSThMajZYOVhGbDY3ZC9QTE1CYkVndk9IMGxGcnZ5djV2?=
 =?utf-8?B?OGtRQldScjUzWllTYlIwdzF5cjhLUmo5cll6d1VSQ2dKWmZWNmxwYlNFdzNa?=
 =?utf-8?B?bzhUQlcwUEU2STFCMytOVzNSYVAwSk1TWDI5djFiSjBxYnFTUFVxNFAreTRO?=
 =?utf-8?B?eUlyRkpKbG5ZU1AvWEdsWGV4aGtyaGk4WVdST0NuNGdKM0htNyswaUZYMFh2?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C38D215B623A324FA5947EAFD371A68A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UKKUZMkYWIL6fZSDxwzfHXyE1UG5cSAjRMnc4/Ut1D9zDO+Qt62FTk/e7+hO4l4S9+cWWN2DeESaskB/qR5SNg5TJK0YhmOlhOZlIKplBXDEJCPs2xAVMxUY/M2whr6k3CAVKWxvKXa6cUjmY4FeyDPkAqO6txwH4I+DIUZAtai5FkR4Qe5wEwu50dMM491ssAODaPYPjvt2o37nYjMmDp/Iw7rOpTlNlkjyy4Hlzn/CUaY2ns60dYBoqLNEDAgRT/ny3qDNPv2E6JVhdhgD50y0hGCdPnS5yex75esGvs9xO1yBWq330eiXlJ5E/55MLipjaJUiR30ptKfyNp3cNGHy3SqWeqTjJC534pquPwtswRZAVXHreXesujbhOiIxpnZiT4Irm0ghf2K/ppDHaFkNpjEvusrRrHLUUXcOKk7RI7PHqd/T4/iYyqOPChVl3lEtUqKZJBWel6RCQyBIt15DVjKMpWk/NTImX2ruGbRoNaB8iRQPKTM7VGcRx0HGrPFrMc/ittmWjAJW4bX5M6yemFNx1FVSMcQTREdm4xxHlxQiyh8ERKro4c9U7X4/ZxDUzh29rCtSYKgHPOEh8GsKVCWvJaa7JNRpTQ8FX/gBmnGtPwb5+0X7FobkQS0mAKuq01ZMiKGSRSU3v+wa+qNlAHDM+P8Hf3ho2oqZ6ZFTbLeFkh7PpO7iowsjWyC7NrJr1zkiDmhIX4Q4ZSVk6Md9fUIqElcW7wXsDFCKNb94xrkLKGtgOwCLW9YTdzVwTipgVR/gwnUo0TfSmLYEC799MN85y7FZFwf575p88rRWAdb8Y3YreX0ZP4RVGL5RmZ0tyCc2JSVnRbko3TqMdfS7ShvzTe8BHkzm303mQ9Nvj737LPEiDzkZ4AB0AyUPbbEEfWK33lIYgoz6UjiT8w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15425c3-07d6-4fda-9524-08dbcb1e7c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 12:26:39.7226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWUgtt00ZGnCJCR8jRFxkTBTttvX1+7vAHyxrDJhUXKCWLbFL7BZpDu7X5wLdoi9wexZEmwgg0QS8+C2TZrHDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120102
X-Proofpoint-GUID: vjsrqrkFxzHZXBlewYkADEYWb7nSYfb9
X-Proofpoint-ORIG-GUID: vjsrqrkFxzHZXBlewYkADEYWb7nSYfb9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gT2N0IDEyLCAyMDIzLCBhdCA0OjM0IEFNLCDpu4TmgJ3ogaogPGh1YW5nc2ljb25n
QGlpZS5hYy5jbj4gd3JvdGU6DQo+IA0KPiANCj4gJmd0OyBPbiBXZWQsIDIwMjMtMTAtMTEgYXQg
MTY6NDMgKzA4MDAsIOm7hOaAneiBqiB3cm90ZToNCj4gJmd0OyAmZ3Q7IFBvaW50ZXIgZGVyZWZl
cmVuY2UgZXJyb3IgbWF5IG9jY3VyIGluICJhbGxvY19pbml0X2RlbGVnIiBmdW5jdGlvbi4NCj4g
Jmd0OyAmZ3Q7IA0KPiAmZ3Q7ICZndDsgVGhlICJhbGxvY19pbml0X2RlbGVnIiBmdW5jdGlvbiBs
b2NhdGVkIGluICJmcy9uZnNkL25mczRzdGF0ZS5jIiBtYXkgb2NjdXIgYSBwb2ludGVyIGRlcmVm
ZXJlbmNlIGVycm9yIHdoZW4gaXQgY2FsbHMgdGhlIGZ1bmN0aW9uICJuZnM0X2FsbG9jX3N0aWQi
IGxvY2F0ZWQgaW4gdGhlIHNhbWUga2VybmVsIGZpbGUuIFRoZSAibmZzNF9hbGxvY19zdGlkIiBm
dW5jdGlvbiB3aWxsIGNhbGwgdGhlICJrbWVtX2NhY2hlX3phbGxvYyIgZnVuY3Rpb24gdG8gYWxs
b2NhdGUgZW5vdWdoIG1lbW9yeSBmb3Igc3RvcmluZyB0aGUgInN0aWQiIHZhcmlhYmxlLiBJZiB0
aGVyZSBhcmUgc2lnbmlmaWNhbnQgbWVtb3J5IGZyYWdtZW50YXRpb24gaXNzdWVzLCBpbnN1ZmZp
Y2llbnQgZnJlZSBtZW1vcnkgYmxvY2tzLCBvciBpbnRlcm5hbCBlcnJvcnMgaW4gdGhlIGFsbG9j
YXRpb24gZnVuY3Rpb24sIHRoZSAia21lbV9jYWNoZV96YWxsb2MiIGZ1bmN0aW9uIHdpbGwgcmV0
dXJuIE5VTEwuIFRoZW4gdGhlICJuZnM0X2FsbG9jX3N0aWQiIGZ1bmN0aW9uIHdpbGwgcmV0dXJu
IE5VTEwgdG8gdGhlICJhbGxvY19pbml0X2RlbGVnIiBmdW5jdGlvbi4gRmluYWxseSwgdGhlICJh
bGxvY19pbml0X2RlbGVnIiBmdW5jdGlvbiB3aWxsIGV4ZWN1dGUgdGhlIGZvbGxvd2luZyBpbnN0
cnVjdGlvbnMuDQo+ICZndDsgJmd0OyBkcCA9IGRlbGVnc3RhdGVpZChuZnM0X2FsbG9jX3N0aWQo
Y2xwLCBkZWxlZ19zbGFiLCBuZnM0X2ZyZWVfZGVsZWcpKTsmbmJzcDsmbmJzcDsNCj4gJmd0OyAm
Z3Q7IGlmIChkcCA9PSBOVUxMKSZuYnNwOyZuYnNwOw0KPiAmZ3Q7ICZndDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7IGdvdG8gb3V0X2RlYzsNCj4gJmd0OyAmZ3Q7IGRwLSZndDtkbF9zdGlk
LnNjX3N0YXRlaWQuc2lfZ2VuZXJhdGlvbiA9IDE7DQo+ICZndDsgJmd0OyANCj4gJmd0OyAmZ3Q7
IFRoZSAiZGVsZWdzdGF0ZWlkIiBmdW5jdGlvbiBpcyBkZWZpbmVkIGFzIGJlbG93Og0KPiAmZ3Q7
ICZndDsgc3RhdGljIGlubGluZSBzdHJ1Y3QgbmZzNF9kZWxlZ2F0aW9uICpkZWxlZ3N0YXRlaWQo
c3RydWN0IG5mczRfc3RpZCAqcykmbmJzcDsmbmJzcDsNCj4gJmd0OyAmZ3Q7IHsmbmJzcDsmbmJz
cDsNCj4gJmd0OyAmZ3Q7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyByZXR1cm4gY29udGFp
bmVyX29mKHMsIHN0cnVjdCBuZnM0X2RlbGVnYXRpb24sIGRsX3N0aWQpOyZuYnNwOyZuYnNwOw0K
PiAmZ3Q7ICZndDsgfQ0KPiAmZ3Q7ICZndDsgDQo+ICZndDsgJmd0OyBXaGVuIHRoZSBwYXJhbWV0
ZXIgInN0cnVjdCBuZnM0X3N0aWQgKnMiIGlzIE5VTEwsIHRoZSBmdW5jdGlvbiB3aWxsIHJldHVy
biBhIHN0cmFuZ2UgdmFsdWUgd2hpY2ggaXMgYSBuZWdhdGl2ZSBudW1iZXIuIFRoZSB2YWx1ZSB3
aWxsIGJlIGludGVycHJldGVkIGFzIGEgdmVyeSBsYXJnZSBudW1iZXIuIFRoZW4gdGhlIHZhcmlh
YmxlICJkcCIgaW4gdGhlICJhbGxvY19pbml0X2RlbGVnIiBmdW5jdGlvbiB3aWxsIGdldCB0aGUg
dmFsdWUsIGFuZCBpdCB3aWxsIHBhc3MgdGhlIGZvbGxvd2luZyAiaWYiIGNvbmRpdGlvbmFsIHN0
YXRlbWVudHMuIEluIHRoZSBsYXN0LCB0aGUgdmFyaWFibGUgImRwIiB3aWxsIGJlIGRlcmVmZXJl
bmNlZCwgYW5kIGl0IHdpbGwgY2F1c2UgYW4gZXJyb3IuDQo+ICZndDsgJmd0OyANCj4gJmd0OyAm
Z3Q7IE15IGV4cGVyaW1lbnRhbCBrZXJuZWwgdmVyc2lvbiBpcyAiTElOVVggNi4xIiwgYW5kIHRo
aXMgcHJvYmxlbSBleGlzdHMgaW4gYWxsIHRoZSB2ZXJzaW9uIGZyb20gIkxJTlVYIHYzLjItcmMx
IiB0byAiTElOVVggdjYuNi1yYzUiLg0KPiAmZ3Q7IA0KPiAmZ3Q7IA0KPiAmZ3Q7IChJIGRvbid0
IHRoaW5rIHRoZXJlIGFyZSBzZWN1cml0eSBpbXBsaWNhdGlvbnMgaGVyZSwgc28gSSdtIGNjJ2lu
ZyB0aGUNCj4gJmd0OyBtYWlsaW5nIGxpc3QgYW5kIG1ha2luZyB0aGlzIHB1YmxpYy4pDQo+ICZn
dDsgDQo+ICZndDsgV2VsbCBzcG90dGVkISBPcmRpbmFyaWx5IHlvdSdkIGJlIGNvcnJlY3QsIGJ1
dCBkbF9zdGlkIGlzIHRoZSBmaXJzdA0KPiAmZ3Q7IGZpZWxkIGluIHRoZSBzdHJ1Y3QsIHNvIHRo
ZSBjb250YWluZXJfb2Ygd2lsbCBqdXN0IHJldHVybiB0aGUgc2FtZQ0KPiAmZ3Q7IHZhbHVlIHRo
YXQgeW91IHBhc3MgaW4uDQo+ICZndDsgDQo+ICZndDsgU3RpbGwsIHRoaXMgaXMgbm90IHNvbWV0
aGluZyB3ZSBvdWdodCB0byByZWx5IG9uIGdvaW5nIGZvcndhcmQuIFdvdWxkDQo+ICZndDsgeW91
IGNhcmUgdG8gbWFrZSBhIHBhdGNoIHRvIGNsZWFuIHRoaXMgdXAgYW5kIG1ha2UgdGhhdCBhIGJp
dCBsZXNzDQo+ICZndDsgc3VidGxlPw0KPiAmZ3Q7IA0KPiAmZ3Q7IFRoYW5rcyENCj4gJmd0OyAt
LSANCj4gJmd0OyBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiANCj4gDQo+IFRo
YW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayEgSW5kZWVkLCB5b3UgYXJlIGNvcnJlY3QhIE5leHQg
dGltZSBJIHdpbGwgY2hlY2sgaXQgdHdpY2UgYmVmb3JlIHJlcG9ydGluZyBhIHByb2JsZW0uDQo+
IA0KPiBNeSBwYXRjaCBpcyBiZWxvdzoNCj4gDQo+IE1vZGlmeSB0aGUgY29uZGl0aW9uYWwgc3Rh
dGVtZW50IGZvciBudWxsIHBvaW50ZXIgY2hlY2sgaW4gdGhlIGZ1bmN0aW9uDQo+ICdhbGxvY19p
bml0X2RlbGVnJyB0byBtYWtlIHRoaXMgZnVuY3Rpb24gbW9yZSByb2J1c3QgYW5kIGNsZWFyLiBP
dGhlcndpc2UsDQo+IHRoaXMgZnVuY3Rpb24gbWF5IGhhdmUgcG90ZW50aWFsIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgcHJvYmxlbSBpbiB0aGUgZnV0dXJlLA0KPiB3aGVuIG1vZGlmeWluZyBvciBleHBh
bmRpbmcgdGhlIG5mczRfZGVsZWdhdGlvbiBzdHJ1Y3R1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTaWNvbmcgSHVhbmcgPGh1YW5nc2ljb25nQGlpZS5hYy5jbj4NCj4gLS0tDQo+IGZzL25mc2Qv
bmZzNHN0YXRlLmMgfCA2ICsrKystLQ0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHN0YXRlLmMg
Yi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+IGluZGV4IGIxMTE4MDUwZmY1Mi4uNTE2YjhiZDZjYjUz
IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnNkL25mczRzdGF0ZS5jDQo+ICsrKyBiL2ZzL25mc2QvbmZz
NHN0YXRlLmMNCj4gQEAgLTExNjAsNiArMTE2MCw3IEBAIGFsbG9jX2luaXRfZGVsZWcoc3RydWN0
IG5mczRfY2xpZW50ICpjbHAsIHN0cnVjdCBuZnM0X2ZpbGUgKmZwLA0KPiBzdHJ1Y3QgbmZzNF9j
bG50X29kc3RhdGUgKm9kc3RhdGUsIHUzMiBkbF90eXBlKQ0KPiB7DQo+IHN0cnVjdCBuZnM0X2Rl
bGVnYXRpb24gKmRwOw0KPiArIHN0cnVjdCBuZnM0X3N0aWQgKnN0aWQ7DQo+IGxvbmcgbjsNCj4g
DQo+IGRwcmludGsoIk5GU0QgYWxsb2NfaW5pdF9kZWxlZ1xuIik7DQo+IEBAIC0xMTY4LDkgKzEx
NjksMTAgQEAgYWxsb2NfaW5pdF9kZWxlZyhzdHJ1Y3QgbmZzNF9jbGllbnQgKmNscCwgc3RydWN0
IG5mczRfZmlsZSAqZnAsDQo+IGdvdG8gb3V0X2RlYzsNCj4gaWYgKGRlbGVnYXRpb25fYmxvY2tl
ZCgmYW1wO2ZwLSZndDtmaV9maGFuZGxlKSkNCg0KVGhhbmtzIGZvciB5b3VyIHJlcG9ydCBhbmQg
dGhlIGZpeC4NCg0KU29tZSBwYXJ0IG9mIHRoZSBNVEEvTVVBIGNoYWluIGhhcyBtYW5nbGVkIHRo
aXMgZW1haWw7IHNlZQ0KYWJvdmUgd2hlcmUgJyYnIGlzIG5vdyAmYW1wOyBhbmQgJz4nIGlzIG5v
dyAmZ3Q7IC4gSSBoYWQNCnRvIGFwcGx5IHRoaXMgcGF0Y2ggYnkgaGFuZC4gSXQncyBub3cgcHVz
aGVkIG91dCB0bw0KbmZzZC1uZXh0LCBzbyBwbGVhc2UgY2hlY2sgaXQgb3Zlci4NCg0KDQo+IGdv
dG8gb3V0X2RlYzsNCj4gLSBkcCA9IGRlbGVnc3RhdGVpZChuZnM0X2FsbG9jX3N0aWQoY2xwLCBk
ZWxlZ19zbGFiLCBuZnM0X2ZyZWVfZGVsZWcpKTsNCj4gLSBpZiAoZHAgPT0gTlVMTCkNCj4gKyBz
dGlkID0gbmZzNF9hbGxvY19zdGlkKGNscCwgZGVsZWdfc2xhYiwgbmZzNF9mcmVlX2RlbGVnKTsN
Cj4gKyBpZiAoc3RpZCA9PSBOVUxMKQ0KPiBnb3RvIG91dF9kZWM7DQo+ICsgZHAgPSBkZWxlZ3N0
YXRlaWQoc3RpZCk7DQo+IA0KPiAvKg0KPiAqIGRlbGVnYXRpb24gc2VxaWQncyBhcmUgbmV2ZXIg
aW5jcmVtZW50ZWQuICBUaGUgNC4xIHNwZWNpYWwNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCj4gQmVz
dCBSZWdhcmRzLA0KPiBTaWNvbmcgSHVhbmcNCj4gPC9odWFuZ3NpY29uZ0BpaWUuYWMuY24+PC9q
bGF5dG9uQGtlcm5lbC5vcmc+DQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K
