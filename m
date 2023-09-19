Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3577A6ABE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 20:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjISSdW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 14:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjISSdV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 14:33:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F085197
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 11:33:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JHxJIr030306;
        Tue, 19 Sep 2023 18:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Gzww52x0U1gC2YE4owczYMTEzAxs3/MOaK0AOIbbvIs=;
 b=npwVFwB4Ld88DaK50fHPHLj0m8zz/hzuq5qByJY5DvjI2XzvLRPeCFCmIR88r8whzvZs
 5tv2Iaz3rdvnhz0IB6nEDOpVyRl17b7B2GeYUhinkka5THs5g+yt1xz9h5sr0z6wCT+D
 piL+dxrKuyeH6AWFElm776Ni7jua6hHQwLwQdGKfqsVHlb7d4a/sxe6dhqbEzIENzGaL
 8Vq9SJRMX4/NoZDW8WlIu9QgJU8SCCMa7xlp2lqc/VZYhaHR5I5i6+W4JILhKKYR+c55
 S1/7XifEz5aJUNcKTXBzt/b2jvZP1s1uD8NfgZDHTFnqi8ceiQG8r8lNcrUSt4JSwW8D 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52y1wp7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 18:33:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JH1q5m015975;
        Tue, 19 Sep 2023 18:33:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5t284-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 18:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWxvKNEzXAZTfFFnvB3GwPA0Lnre9sLFFsB82Te530Ahwbo/zMmMBchPh4D9ZUmGWGYvmEiD1JgckTFWdA540WSWYTQ3yU+NHNXfg+V4jIWY788fh1KyDiQoCb9X5Axq51jb5F9Jhfo0/XHgJGnJYHoNEknT5hbIT97AKhfnI+yPIyvHiNYmYkZn/VBYdNH8LfOwfQI1MylgDJvnq5XzLBV7j0NUz/uJTf9U6A03KJAryZdxaGdhuPW4xoEMFk0EKFgibVxsvLeMxrtLP6DU/Y6z+jk4K5yvj+MCCdMurWiETgE8ZRyJI3gqSl7s79jWkD/MbsLjO1Z1Iu3VQ7N4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gzww52x0U1gC2YE4owczYMTEzAxs3/MOaK0AOIbbvIs=;
 b=GdPpJpi4mCYAc2UheLbIRNGyrV+sFnJNtXEtrX7czogJg1JQau499mpARNSnfnPCWhz56l5qHl6RPMUuZMmQGgcd0dE40LkdprPQyloW8cmiT8tBiDjr8OXuNomrC1ZGSVzfzlrnQH095vvTku2W8TjbBwDTv8ve2GLsYYvXDIkhYDZN7/qlWKCwyecIDjpjWPXcefFxFRjcZ5MNvQ07ItdaHjNeVubvJrdpka8TjW/GRkMWhlIE81H4hJfuFxJOey36lO+QEjzJqEo05PX2CpKmAsSPBb6maRJQFXkVc3sNVI1rUmZiHq4AZl+HFzQWKhzM+SwfisvGUZfCiji+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzww52x0U1gC2YE4owczYMTEzAxs3/MOaK0AOIbbvIs=;
 b=VzxzO9f9BfNEz5fQnHZ9km1H94KgySH/wx74X+2lVVBViJj8JV0BPpLxsdHc8VHmqkS5hLdW77aymYLtkurQ7UpWqgwEdmV7QIPK3VnWzf1wZUaPYtnabtn6Q7N2gDBr6Fv8h7cqqS6i2vWd9ggpV01uVA5USMsgsXTg/hyknjA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7559.namprd10.prod.outlook.com (2603:10b6:a03:546::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 18:33:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 18:33:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] SUNRPC: Fail quickly when server does not recognize
 TLS
Thread-Topic: [PATCH v2] SUNRPC: Fail quickly when server does not recognize
 TLS
Thread-Index: AQHZ4P2F9j++Z9A6/kC/pa1eWMwKZrAg+DaAgAGTwACAAAF2AA==
Date:   Tue, 19 Sep 2023 18:33:05 +0000
Message-ID: <C655C063-8DC3-4DAE-BBE7-91F49DE8FC66@oracle.com>
References: <169403069468.5590.10798268439536368989.stgit@oracle-102.nfsv4bat.org>
 <AA691FE9-5183-4912-BB0A-32E86629D7B1@oracle.com>
 <CAFX2Jf=hVi1sGARPvfW8BLJ189obH=Ha+qovDWD6_ptWvSpUqA@mail.gmail.com>
In-Reply-To: <CAFX2Jf=hVi1sGARPvfW8BLJ189obH=Ha+qovDWD6_ptWvSpUqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7559:EE_
x-ms-office365-filtering-correlation-id: 14d4d7da-258b-4539-c296-08dbb93edd17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVWx0OeJSrSPAitm9Bome6lNdA2CqWXU8dYHoCsp6uIOEt4ZtuW0g257A8OzpKexzRbPPys4bF42ESZV3LYfZH9cb9xxIU+UscQCnq7un+PjGGvrGc9jEcdsEeKO5LhG62Giqn9A5I0LtO/RZqd/+eZOYTcAFBag2akGvkP43w11eSpl90If9xhz6ycmqb7VeLVFK7Y2J/OOWPfXkRKlU1MpFCe/dgzJItzuu54gi9nsRkOUPOs1xQJuINqzohwrOmCEpU5aSdM0Mh2oVqM5WXt/WRw4bFoJJf4Rdk0Wo/eljzP6Rfw3q482hIipuEZmaRsmJblFrO4LntNhA2HAH5j65b8V3EZo+UGPxFnsudNn95pbQPwl6+OAP3kpeB0Xc4VTStTut59kvgRlsLSPKNIJC5SgYQ0nS07HjfuMF1Dz99xpGdf6n9sT5BBmC78gRErkqd/MXishEy4MulTwQH4EPCsyNBapKx+gevdlA5Nr/5z3iab4cdNdYzmuswN6t9BOcd32o7KmgYpnW8GJndmKiQ12w0cEXw2GAMMlx9ihrTj8ChI683gyG8SzliPVKq6h2tzdSI5sm7uEk0RktbA9rDqdqcvad1M/mVkIR3QxEyAGoEOgH5D5k399r8WSnmpM23yyi+GSiw4U6b5/DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(1800799009)(186009)(33656002)(36756003)(5660300002)(83380400001)(86362001)(8936002)(4326008)(8676002)(41300700001)(6486002)(71200400001)(53546011)(26005)(2616005)(6506007)(6512007)(122000001)(478600001)(66946007)(2906002)(76116006)(38100700002)(38070700005)(66446008)(66556008)(66476007)(91956017)(6916009)(64756008)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGEyaTJtQjhXSytEdEVLalRKaG5zRzBjbzJDanFnUDZjWlZxV2NQSXpCQm05?=
 =?utf-8?B?em1BRG9IeXV3ZzV0emQ3MlB3ZXI3a3cvbUwyYUR3SktlN1BNeHlCVEM2OGtZ?=
 =?utf-8?B?c3hsZkljRkZUN1VTS3JmVzNVWjgzOU4xZzR2cDR0S1kxL1NhL0V0Z3BMdFA3?=
 =?utf-8?B?U2xXZzJCaTI4N0VGKzk2cnZ6YkUwK0ZsSkgweWx0Mk1Uc1lQYXlkWC8xWW1u?=
 =?utf-8?B?NU55cVFCTDZmaVZKT24zaFB3T25UWkR4V1BVcVB0RmMrY2pDZjROTmpjdGRW?=
 =?utf-8?B?aEU4b2JHNDVKMkRPcGZ1OUJhSmh6U3o1elNoaVlid1NPR2dVb0dEbWRtd3hV?=
 =?utf-8?B?bllxSFRXMUVWZzdTdDVKSXZ4R3gzRk5QUjFONmdldnZCelZMYWFla0N0OVJN?=
 =?utf-8?B?eUQxcmZsdUFIdkR1NjhEMFhCeXIydWg5ZlpxcWNTYmhKSi8xZ3JSMnFRb0pJ?=
 =?utf-8?B?cTRMUHJGRThxN0xKRzdsdXY5UkwxNjQzV3hTVklSSzVBbkEyUVg2alZyajdD?=
 =?utf-8?B?QWhHaC9ZTFRyMVo3UTJydFJSL3BhMjhqd29DYVVYV3dpalBkL1U0UUZ0eDkv?=
 =?utf-8?B?RnFJeDdyaysxNjVBTkdTbGVXT2dlc0c4UWg1cVpEVXVabllUZnNhK3dTcmZt?=
 =?utf-8?B?Tkk1V0I1N0JoR2o2M3N1NnNiV3pvYVp4d2d4bkZrN0ZoRXVQMU40Ujd4Z1dH?=
 =?utf-8?B?cjBrNnRTMXg4aWhSQnlDSlJZNjlUTE9rUUpnTHkzeWh1cDNod3Q5NXRwY2ZX?=
 =?utf-8?B?UWM2TUNIbjltUUw1WVAwOFZ5U3lIQUlBdEdDby9UcnNwYk1ueTYwNkFIRWZs?=
 =?utf-8?B?QmtWc1B3V3V2UlV5Wld1dTFYcUFsM01JNjhGa1JYMFZNYWpZVEh0TGVwSDZh?=
 =?utf-8?B?OGhaamRob2VLaW56NnNKQnczMmprUENpSmIzc1FJTXNTVzY3M3dxeWV1Q29X?=
 =?utf-8?B?eUlMZmZFcjRieU8xa25hZ0Z5bE8xMGk3Mm10WGM2UkthbXZucXl5Z1hkcEc0?=
 =?utf-8?B?SEdwcDhrYnpYRnZ3eVN3R0g3bGlCaGV0M3lvbGpnRTh3UGlLaE1ObmV3YnFB?=
 =?utf-8?B?Q3dKVHAxeXZzY3ZsRC82VkxQT3JXKzRHUzdST01DMFkwa01DSXJXcVhUUjdq?=
 =?utf-8?B?UklZTCtVK2oxcW9KV04xOGJtSk4rOFliYjdRVkdsd1F1NUZMUjZKMzNPa2sr?=
 =?utf-8?B?TTBGU3lsdW4yTndEa1JSbzZCa2VpUEFtMlRseHdETVYzQnJ4ZmpNc1BEb1U2?=
 =?utf-8?B?ZitHL2Vxb29mbDlkUDB1cUZabE9RQUFtMHJMa2pkRUh2OEdZR01STWt4NlpJ?=
 =?utf-8?B?YXlLSXNSVEJFcE9VSktrSFRYaFh3cHhtWnFaSjR4MHNFTEJ4cm9TRWNaNVMx?=
 =?utf-8?B?dGVEYUpCN2JqTUVWZktIT3MwcmJpSU40aU9BOWhCR1VoQzlGbzlwUmZQeFVu?=
 =?utf-8?B?UHA1V0dNL1hEY0Rod2JodEt5dGFaNUFEQTNkTGxOZFp1a2hNZnU5ZkZnSHI4?=
 =?utf-8?B?OVd6ajkxbkhsdm56MHQxZE1wMXljSFA3ZllGSG5paWZFNzhVWndVY3c0Ui9B?=
 =?utf-8?B?dncwUWpDbXgvbUFFYXNxV2ZhSHV4OUtlOHZGZGZLWmltU3k0OWlHbE43QTNw?=
 =?utf-8?B?dFR5Z2VYRStQcG9WcnhHbGVNQXpRWXp2VGZYeENFTUtISXd2Ukxzd0xHeXQ2?=
 =?utf-8?B?MURXUVl4SmM2aVM0Rm00ajZkNEhzWUN0Q2RwYkpxeFRySmg4UU5ZVVdzM3hI?=
 =?utf-8?B?bmNwdU9GUFQweUs2VEFORkcwUzJHREN3ZC9JYlpzckxya2ptT0t6QWl3ZUQ1?=
 =?utf-8?B?QU16Y24wSndiNWtVUjRlTnd4UHRpcnNvN0lrbXJXcEwxSkIvWkdlSDlEeWZJ?=
 =?utf-8?B?NThtRVQ4czlIdzVmdTY1dzlmMjZpL2NYaXhOOHJlekRvMjZxWVdxSWJySGlL?=
 =?utf-8?B?R2dMMzNoQzVJS3BkdFUrSHJ0Y1BQMnlSOFFhODA0d1NPMU15YUZSeC96NTV5?=
 =?utf-8?B?bWxIZW55MlZsN0hDZXRMUkFETnBESHNMOWhWUC9mWFpjS0ptYjI5ck0xV2pZ?=
 =?utf-8?B?c3lmUzlzUWVvRFhoSG9mUlg3WVNPNGJIb2F6WVgyVjF5ajF3MVAyZnFvajE1?=
 =?utf-8?B?Zk1FUGp4NFl0SnkzM1dWU2IyS2VqQUdoWVRNYTVGblE4R3NzcDh3WUVBd3BO?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <192115AC909BA842B890C8425EBF7C38@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lfeFpuI7vF6zTyUvp+8D9H+3SOhr6/Bm0EA86TB9JggOFds9EWi0eVb/9NJNlB0HGypZ1KSchcS+c5Vr7jLo86MtjujwZ7pW/rMhuy9cCiDwUyeGQV9XzF5X7nEOtzOyt2Fsz18M6J7/6c3G3JGvVXo6+2q5e6866E9Dh8/LiYoy+iUzNxmT0g11ZMEIPIlEk6AqQHxr6l+j4vD+VKLs5CtQ6w0+HfXVDRv3BOGec8pzjCGoRusbhJAqHceJsZe+XtOLLQR6cloSXZiBoWWJajwqZl9A/oLNXr1/OwEFjUfk+yWfoD5J0efzQUK+KTaw+yRNt5hWXdf3f9pRzqsHd+zW+/rTwh52Ksx2aATtRfpEs1vBKiCSw2jbJ977JV7FMeKvB508l2Y8keXBo+74NDT4h9zIrhVPgTR6enL41QL9Ak+XmruVAX05oYL8I8w5KmT61AHxyDz24sdeAvVt4asAnfKa6XBpAX9priAFm1fADWdsk98EdVdP/aUx7ka7/m/DA7X3hLDBjuEaCLrdMO8/H2V93XUg4/CvM8uPLxm2W/JrM/qoas601WuYC/9WRtW/FQYkN9WbYqvYLfDYtWNOa7ceGl7HMnidKJc88izMs+YmGJ+0AaqPyue6IJtmCqoGBV3K20e+njetNtXRydjsVujpgnhYBEAkm1jOv+dJROs8axiWOWRI9+8OEF1QqjoPUEnIY3iikfGd1ehvVqdKzOiubCp8hWwN2v10LAXezv07VZUcE5ncLhnZnlLgZkjepSSn3a9ytEOkOLlDmkU7py1l1ZVit9wCzmDAeYwk71p7ZrtDs/h4wfsQRtLaIeGPIkooU75yK6dSaroW/tAIeZHvJtPnrPu+Fb4MwFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d4d7da-258b-4539-c296-08dbb93edd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 18:33:05.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUiH0vfOZRhep7VWhdhGR4MnlbKJIqT/ZQcFYRC+urbysLUqK8WnFeLp4uURzWAD/NOQo7wJPTVMzsacFt8K6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_09,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190159
X-Proofpoint-GUID: mhbWugKS72J9lN56gNIoiR7ugsF4yl_8
X-Proofpoint-ORIG-GUID: mhbWugKS72J9lN56gNIoiR7ugsF4yl_8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIFNlcCAxOSwgMjAyMywgYXQgMjoyNyBQTSwgQW5uYSBTY2h1bWFrZXIgPHNjaHVtYWtl
ci5hbm5hQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIFNlcCAxOCwgMjAyMyBhdCAy
OjM34oCvUE0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiANCj4+PiBPbiBTZXAgNiwgMjAyMywgYXQgNDowNSBQTSwgQ2h1Y2sgTGV2
ZXIgPGNlbEBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBGcm9tOiBDaHVjayBMZXZlciA8
Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+PiANCj4+PiBycGNhdXRoX2NoZWNrdmVyZigpIHNo
b3VsZCByZXR1cm4gYSBkaXN0aW5jdCBlcnJvciBjb2RlIHdoZW4gYQ0KPj4+IHNlcnZlciByZWNv
Z25pemVzIHRoZSBBVVRIX1RMUyBwcm9iZSBidXQgZG9lcyBub3Qgc3VwcG9ydCBUTFMgc28NCj4+
PiB0aGF0IHRoZSBjbGllbnQncyBoZWFkZXIgZGVjb2RlciBjYW4gcmVzcG9uZCBhcHByb3ByaWF0
ZWx5IGFuZA0KPj4+IHF1aWNrbHkuIE5vIHJldHJpZXMgYXJlIG5lY2Vzc2FyeSBpcyBpbiB0aGlz
IGNhc2UsIHNpbmNlIHRoZSBzZXJ2ZXINCj4+PiBoYXMgYWxyZWFkeSBhZmZpcm1hdGl2ZWx5IGFu
c3dlcmVkICJUTFMgaXMgdW5zdXBwb3J0ZWQiLg0KPj4+IA0KPj4+IFN1Z2dlc3RlZC1ieTogVHJv
bmQgTXlrbGVidXN0IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+PiAtLS0NCj4+PiBuZXQv
c3VucnBjL2F1dGguYyAgICAgfCAgIDExICsrKysrKysrLS0tDQo+Pj4gbmV0L3N1bnJwYy9hdXRo
X3Rscy5jIHwgICAgNCArKy0tDQo+Pj4gbmV0L3N1bnJwYy9jbG50LmMgICAgIHwgICAxMCArKysr
KysrKystDQo+Pj4gMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPj4+IA0KPj4+IFRoaXMgbXVzdCBiZSBhcHBsaWVkIGFmdGVyICdSZXZlcnQgIlNVTlJQ
QzogRmFpbCBmYXN0ZXIgb24gYmFkIHZlcmlmaWVyIicNCj4+PiANCj4+PiBDaGFuZ2VzIHNpbmNl
IFJGQzoNCj4+PiAtIEJhc2ljIHRlc3RpbmcgaGFzIGJlZW4gZG9uZQ0KPj4+IC0gQWRkZWQgYW4g
ZXhwbGljaXQgY2hlY2sgZm9yIGEgemVyby1sZW5ndGggdmVyaWZpZXIgc3RyaW5nDQo+PiANCj4+
IEhpIEFubmEsIHdhcyB0aGlzIHBhdGNoIHJlamVjdGVkPw0KPiANCj4gTm9wZSEgSSB3YXMgdW5k
ZXIgdGhlIGltcHJlc3Npb24gVHJvbmQgd291bGQgYmUgdGFraW5nIGl0IGZvciA2LjcsIGJ1dA0K
PiBpZiB5b3UgdGhpbmsgaXQncyBuZWVkZWQgZWFybGllciBJIGNhbiBpbmNsdWRlIGl0IGluIHRo
ZSBuZXh0IGJ1Z2ZpeGVzDQo+IHB1bGwgcmVxdWVzdC4NCg0KV2VsbCwgaXQgZ29lcyB3aXRoICdS
ZXZlcnQgIlNVTlJQQzogRmFpbCBmYXN0ZXIgb24gYmFkIHZlcmlmaWVyIiAnLg0KT3RoZXJ3aXNl
IHRoYXQgcmV2ZXJ0IHdpbGwgY2F1c2UgYSBiZWhhdmlvciByZWdyZXNzaW9uIGZvciBUTFMNCmlu
IHNvbWUgY29ybmVyIGNhc2VzLiBJZiB5b3UgYW5kIFRyb25kIGFyZSBPSyB3aXRoIHRoYXQsIGl0
IGNhbiBiZQ0KbGVmdCBmb3IgdjYuNy4NCg0KDQo+IFRoYW5rcywNCj4gQW5uYQ0KPiANCj4+IA0K
Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvYXV0aC5jIGIvbmV0L3N1bnJwYy9hdXRo
LmMNCj4+PiBpbmRleCAyZjE2ZjlkMTc5NjYuLjgxNGIwMTY5Zjk3MiAxMDA2NDQNCj4+PiAtLS0g
YS9uZXQvc3VucnBjL2F1dGguYw0KPj4+ICsrKyBiL25ldC9zdW5ycGMvYXV0aC5jDQo+Pj4gQEAg
LTc2OSw5ICs3NjksMTQgQEAgaW50IHJwY2F1dGhfd3JhcF9yZXEoc3RydWN0IHJwY190YXNrICp0
YXNrLCBzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyKQ0KPj4+ICogQHRhc2s6IGNvbnRyb2xsaW5nIFJQ
QyB0YXNrDQo+Pj4gKiBAeGRyOiB4ZHJfc3RyZWFtIGNvbnRhaW5pbmcgUlBDIFJlcGx5IGhlYWRl
cg0KPj4+ICoNCj4+PiAtICogT24gc3VjY2VzcywgQHhkciBpcyB1cGRhdGVkIHRvIHBvaW50IHBh
c3QgdGhlIHZlcmlmaWVyIGFuZA0KPj4+IC0gKiB6ZXJvIGlzIHJldHVybmVkLiBPdGhlcndpc2Us
IEB4ZHIgaXMgaW4gYW4gdW5kZWZpbmVkIHN0YXRlDQo+Pj4gLSAqIGFuZCBhIG5lZ2F0aXZlIGVy
cm5vIGlzIHJldHVybmVkLg0KPj4+ICsgKiBSZXR1cm4gdmFsdWVzOg0KPj4+ICsgKiAgICUwOiBW
ZXJpZmllciBpcyB2YWxpZC4gQHhkciBub3cgcG9pbnRzIHBhc3QgdGhlIHZlcmlmaWVyLg0KPj4+
ICsgKiAgICUtRUlPOiBWZXJpZmllciBpcyBjb3JydXB0ZWQgb3IgbWVzc2FnZSBlbmRlZCBlYXJs
eS4NCj4+PiArICogICAlLUVBQ0NFUzogVmVyaWZpZXIgaXMgaW50YWN0IGJ1dCBub3QgdmFsaWQu
DQo+Pj4gKyAqICAgJS1FUFJPVE9OT1NVUFBPUlQ6IFNlcnZlciBkb2VzIG5vdCBzdXBwb3J0IHRo
ZSByZXF1ZXN0ZWQgYXV0aCB0eXBlLg0KPj4+ICsgKg0KPj4+ICsgKiBXaGVuIGEgbmVnYXRpdmUg
ZXJybm8gaXMgcmV0dXJuZWQsIEB4ZHIgaXMgbGVmdCBpbiBhbiB1bmRlZmluZWQNCj4+PiArICog
c3RhdGUuDQo+Pj4gKi8NCj4+PiBpbnQNCj4+PiBycGNhdXRoX2NoZWNrdmVyZihzdHJ1Y3QgcnBj
X3Rhc2sgKnRhc2ssIHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIpDQo+Pj4gZGlmZiAtLWdpdCBhL25l
dC9zdW5ycGMvYXV0aF90bHMuYyBiL25ldC9zdW5ycGMvYXV0aF90bHMuYw0KPj4+IGluZGV4IGRl
NzY3OGY4YTIzZC4uODdmNTcwZmQzYjAwIDEwMDY0NA0KPj4+IC0tLSBhL25ldC9zdW5ycGMvYXV0
aF90bHMuYw0KPj4+ICsrKyBiL25ldC9zdW5ycGMvYXV0aF90bHMuYw0KPj4+IEBAIC0xMjksOSAr
MTI5LDkgQEAgc3RhdGljIGludCB0bHNfdmFsaWRhdGUoc3RydWN0IHJwY190YXNrICp0YXNrLCBz
dHJ1Y3QgeGRyX3N0cmVhbSAqeGRyKQ0KPj4+IGlmICgqcCAhPSBycGNfYXV0aF9udWxsKQ0KPj4+
IHJldHVybiAtRUlPOw0KPj4+IGlmICh4ZHJfc3RyZWFtX2RlY29kZV9vcGFxdWVfaW5saW5lKHhk
ciwgJnN0ciwgc3RhcnR0bHNfbGVuKSAhPSBzdGFydHRsc19sZW4pDQo+Pj4gLSByZXR1cm4gLUVJ
TzsNCj4+PiArIHJldHVybiAtRVBST1RPTk9TVVBQT1JUOw0KPj4+IGlmIChtZW1jbXAoc3RyLCBz
dGFydHRsc190b2tlbiwgc3RhcnR0bHNfbGVuKSkNCj4+PiAtIHJldHVybiAtRUlPOw0KPj4+ICsg
cmV0dXJuIC1FUFJPVE9OT1NVUFBPUlQ7DQo+Pj4gcmV0dXJuIDA7DQo+Pj4gfQ0KPj4+IA0KPj4+
IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+Pj4g
aW5kZXggMzE1YmQ1OWRlYTA1Li44MGVlOTdmYjBiZjIgMTAwNjQ0DQo+Pj4gLS0tIGEvbmV0L3N1
bnJwYy9jbG50LmMNCj4+PiArKysgYi9uZXQvc3VucnBjL2NsbnQuYw0KPj4+IEBAIC0yNzIyLDcg
KzI3MjIsMTUgQEAgcnBjX2RlY29kZV9oZWFkZXIoc3RydWN0IHJwY190YXNrICp0YXNrLCBzdHJ1
Y3QgeGRyX3N0cmVhbSAqeGRyKQ0KPj4+IA0KPj4+IG91dF92ZXJpZmllcjoNCj4+PiB0cmFjZV9y
cGNfYmFkX3ZlcmlmaWVyKHRhc2spOw0KPj4+IC0gZ290byBvdXRfZ2FyYmFnZTsNCj4+PiArIHN3
aXRjaCAoZXJyb3IpIHsNCj4+PiArIGNhc2UgLUVQUk9UT05PU1VQUE9SVDoNCj4+PiArIGdvdG8g
b3V0X2VycjsNCj4+PiArIGNhc2UgLUVBQ0NFUzoNCj4+PiArIC8qIFJlLWVuY29kZSB3aXRoIGEg
ZnJlc2ggY3JlZCAqLw0KPj4+ICsgZmFsbHRocm91Z2g7DQo+Pj4gKyBkZWZhdWx0Og0KPj4+ICsg
Z290byBvdXRfZ2FyYmFnZTsNCj4+PiArIH0NCj4+PiANCj4+PiBvdXRfbXNnX2RlbmllZDoNCj4+
PiBlcnJvciA9IC1FQUNDRVM7DQo+Pj4gDQo+Pj4gDQo+PiANCj4+IC0tDQo+PiBDaHVjayBMZXZl
cg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
