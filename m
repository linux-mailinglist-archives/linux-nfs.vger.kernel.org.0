Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A461521F3B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbiEJPr3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346115AbiEJPr2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 11:47:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BED26AD97
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 08:43:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AE9A97010355;
        Tue, 10 May 2022 15:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=66ohtN0EcFCW8dbtnUQZQFKgoTJUUibzN9DEYb7zJA8=;
 b=Hux2HQtodvUtR+LAz87JQVuxZ6ik1KWcVsM2w0za2DRBWMwbWSjnXqxqhLt51BS20Z5j
 Lf2yelTy/4tfW61Wwlx/7kjoewlcHB8lrh95WM8i4xrbfd/hri8sJgbIb2u/+S2Cq8d0
 BbX23Ve/tXZOQw0xXEa1tqHS2A3vPcttPAELm7vxoY6FlN8kgra+clpnnQbUG4/DNmkQ
 ZnBx/RirxO6OaOjnWi2wpR5lgo4DQPob87NcDpZpceLg2RybwDdXeWTVjmb3K5UlYBg2
 wJWPQJcoL8/8pdnSt1iTyj4xykQutVxCxSgGQ2TOwRXbofjFn8wSq07lJf3VYQ4bgm6X Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c716f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 15:43:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AFUNuv009276;
        Tue, 10 May 2022 15:43:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf72yshe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 15:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk3vbT/epID/7qEcBa/Z4XWeO0hLo2tJVqj1ZUsgKLNBt5PErrk/0K33Gs/GaGRwwZo1BrlYqn5TmPl/mfy6ypcVnTKDlOp93laCuF1DSJ7I7R0EzDGqM8EtRJNZNtjmAJHqA1X66isPEi6j+eP79FKZy9zXknbph3aDxDrwGIcLEk4RT3vtWuWCkgS2yLx6+Y76mngj0UrQq49KRgV1kctPyR1xJlWhZrKDHQkdYyhs+mEZtg5m+mJzEkPr5jTOh2nQTS1MPlVjXmF8pD3cv/QVWNLPlSi24K25x2XaMgCgHTFlLaxt17ubeDr+Khv9KNZkXQDa6It3w0zbHHOzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66ohtN0EcFCW8dbtnUQZQFKgoTJUUibzN9DEYb7zJA8=;
 b=mMiTK+Q3e1cEyL7PsI+oWEPXZ8tEXIJBRxf6+KL9AE7/B0o1M01NA2f9IgrdqLnC6cVjWkMNasTXFW/KvVHsPJUwsndpnqwv7GNQp/hylpP1lU2A3u9zwOJKuraYH4FiLrHZSxwxGdEfNyKpItrdrsDM40BkHiIopPXI1JpvKp0JTWErNSXC+2qSBOtf110cJh1+wtpf2w6TIxqYDxRystCKCvU6aUKs4SP052kM88ESSZko6cZ+/+JiXmfxeJkB7LrqYpTo4jX2TxNox/AfJMAB94QzAA+yX5gYRbH+NMBxHnjwnC8XvUX+P/oefYyq45zgi1uimMg5T/MVRsHVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66ohtN0EcFCW8dbtnUQZQFKgoTJUUibzN9DEYb7zJA8=;
 b=OiewHPBic11ScCerE5mXWrPNiTv8GmftTKlhr7MCjMXVVCH/fl/QF9XTTRWNF0Gko9L8R1p3AvxCk4jX1Czb3Wn89m2aXu0kqYQm/j4IdHGNewqX2nqP2boHShsfspO37nHcNj5ZFWShA9bw6BOE+xqnrBAJ7Dcg1C6+JyQLqJE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1686.namprd10.prod.outlook.com (2603:10b6:910:4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 15:43:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:43:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Topic: [PATCH v2] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Index: AQHYZHxZSPxsF5U2f0y7AKAokOfOla0YQFOA
Date:   Tue, 10 May 2022 15:43:09 +0000
Message-ID: <C822F603-8D89-4D95-B31A-429D77729C15@oracle.com>
References: <YnK2ujabd2+oCrT/@linutronix.de>
 <11F8D1AE-EB3D-48F0-A586-563165640AB8@oracle.com>
 <YnpURpp14qNi7TnI@linutronix.de>
 <73B0E604-D839-4F66-A19C-2C2B4CD57DEA@oracle.com>
 <Ynp46bc5Rt54skl8@linutronix.de>
In-Reply-To: <Ynp46bc5Rt54skl8@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9af49a4c-eae0-4932-305f-08da329bc8b3
x-ms-traffictypediagnostic: CY4PR10MB1686:EE_
x-microsoft-antispam-prvs: <CY4PR10MB16865756B26457F3790B52C393C99@CY4PR10MB1686.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWyc0KPS2SDYxSihruVFetWCSikUBaRYq69a/qosiA/9vG9UFYlRabcyBh/2kvRFIJocojin1LTnoLuUcptoa7ZJNAfmYSar/EuclYBmLlUWG2RugtmgZEBdikZwrA/qkLCJQLFQjzcRP2Ca/aA734/FTBnXY+FV1kIHPvhW1JGI5/14Rd0cE4FyLM6vBJ/GxqwXP/0WEp1pBGyZAfj1wLmEkIm8eQ3oYp5FKFaljt34d26s9kFkeRMloMF68X+EdHnKIy+rCWCYdmwIk1R9cWD63p3VNkFuylnhWyYRqJG/dORKJN9F1tdOnPK17uCoKO1JG3YM6XBjgwqB1r437Z3pp5T9Owqj7wGQY/lq228EpYhclGXvKKiU7iObp5BlrLfL72ImbpsGd4y+fsuLVVJBWzH9Wtr7qudDEPqeALCNLKFlssNUawO6mokdTaa0tZOv4dFU+gKyFcPqXMRpqDqNQ6rVa87OPHu5enuekfUDmlrVzXYlf+8CMaEyB/KVZFs/7NDB5DCVwGmITO7MMlJXPLGs58Xm8NgtHNJeAGPHUdLES6jM9Gmq5jvZW+gbeKUluq+sCVPGf7OWndFCc0EEwoDrwZ4nKGW7JvxqFzYOIuwj1Rsn9Dv+X6RGhAwVVK/WkU6xRgsTslfntgad7DofNqKAKUfwt18IJ3+l1LbvuIGT/+3L+o8tnEvGNNwYUjOSFOJV4Poi5jBM7GuS7fKJKmZiTV0OF6b85/p8U/MwWLvJXbDe8+4o26LEnGjo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2906002)(33656002)(8936002)(91956017)(5660300002)(66446008)(8676002)(66476007)(64756008)(66946007)(66556008)(4326008)(76116006)(86362001)(38070700005)(6916009)(54906003)(38100700002)(6486002)(186003)(83380400001)(2616005)(53546011)(26005)(6506007)(316002)(122000001)(71200400001)(508600001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU1QeS90eVhkUTRSL3hxVThodU5vQmd4SHNVdk9mWmEzSkE4TTFIb1VQRFU1?=
 =?utf-8?B?NWtYN0Z2cXc1ZlE3eCsvemhkSm10WDRKMUhnVVJiMFN4VHJGUTgvTFpMOGla?=
 =?utf-8?B?L3B6VVlrbnFZd1p5b2o5eUI2QS95ZWlqK0NYNE13VngzSkx2UW0vcExSVXFI?=
 =?utf-8?B?bXY4dlE2b3lqZld1VkZPQmJHRmxRZkFMOG1HM1VLZVNMcXEwRjFrT1k4NHRw?=
 =?utf-8?B?OWlwY0o4Zjljc3RlS3Q2WHlUNGRxOFJkazNRY1gzYmNvMFd5SytsRXFjb05T?=
 =?utf-8?B?WDJrYlZzTHFyL0FZYi9ZNHA4VnV6ajJYRWJ4a25pdjM5clozNjZkQ2JiMkx4?=
 =?utf-8?B?dlEwR3RjOFdHUmZtL0cxSllEaUd6SHZzMGNVV21IWllvWjVQWmZKaCt0MDlZ?=
 =?utf-8?B?ZnFWeUp3bVVoK2w2cm5WaCs0TnV1R0J2eWtyTnBSaDhWZWl0M1FNc2liZ3Nl?=
 =?utf-8?B?V1Z3OWEwelFzQ3k5V0toeUJZRTl2QzZSVGhpbUNYQXBIaUU4TkRRbTExczlo?=
 =?utf-8?B?T0hLRWg4VWVQZmtoblVaY0d1b20zbWZtdFdlNnIxRCsyVnYvWGs0Qm1nU3RM?=
 =?utf-8?B?MXorNURsaDNvSG1NTnhFbUhiL2JjMUdSU0x3d0JYSElyMUVJVUxJcy9pT015?=
 =?utf-8?B?VjZZSUlFa2lBNDh6K0dNaWkvMUxTdGxZYWRubUtXemZ3T1dOVGovb0hsNGht?=
 =?utf-8?B?cGFsU2E2ZDJyNS9wb0NNaXh0UmhFdW5ycGRwRkVGVFdSNjdMTnFiMUhVdjFa?=
 =?utf-8?B?QlZaNkZwcHJvMlBwckhVUDJiOUJZOHZBS1dsREFPY1FhNXIrMmI4SlVESkps?=
 =?utf-8?B?UU5Nb2lRN3grUFNGMGJQQlJna0VkemxrdW1Odm9UUWtqaW1raWwxTm9WOHd5?=
 =?utf-8?B?bFNYWjZkY0xLdjJTeW5EL0pzQ1RyUEg1N0lKQnBxYllBallkOXdHQ05oRWpR?=
 =?utf-8?B?S2JvQ2lRUE03eS9lNEdER3hteHFXVnN2YldyVlU3RjJ5Z3p3em1qaU1RbWtC?=
 =?utf-8?B?blZ3Wm5QUkEvMjA0ak9JR210M2xlMFhIRGJ4alFZRlpsS1ZvNUZPKzdmVzN1?=
 =?utf-8?B?STc5U1dkdGRpU2NiSnVXK0E4QzNMdENNcTBVMGJldWxNUjY4MkdoZVgzL2Ev?=
 =?utf-8?B?Y2FhZVRiTFlTNWlDUXd4by81djQxN3ZhYTEzaFFVOUFOZG02NkVZNEF4UStF?=
 =?utf-8?B?VFdiUS9DM1VHamlNZEt4bXlFbldZcjQvSW5ad3pJNnUzdUQ4TEdiLzdIekpG?=
 =?utf-8?B?aW9KNlUrY0ZBZld6S2ovbHlaVFJYQVBOWG9aTHV6bUQxREJjaW5Ud2xFMlY4?=
 =?utf-8?B?a1pGNzZUY0U0ZU5OZmh3MXZJYUswWU1scngyUTU3RnN6Q0ZoWElLOFBjSXJ3?=
 =?utf-8?B?Vm83MklFbEpaajRES1NacSs5MFo0a1VEQTVCVHhST0k5a1lEbnJ3WnRmMHFy?=
 =?utf-8?B?andoc3pvZUFpYVhHRDRGdWdVaFVCK20wWjRTOWIwYzhNbnZZY1RHR0pRNVJo?=
 =?utf-8?B?WEpJbDhwZDhkNGwrRllwVEh3TDVwY0h6bWk5UUYwMksrdHUwVjZuYU50SWNW?=
 =?utf-8?B?dW9FelJmdkxGZU5wZ0RkUUIyVmpXc3kyc3BUaTZzMFNSOWxEbExlOUtGVUZF?=
 =?utf-8?B?YkN3cXA0ZlhxcDkrU0cvcGNBd3RIR3Y1WmJUOUk5U0NXWmp5a242bXY2QnFi?=
 =?utf-8?B?OElMSUNQN2kvY3NsdUwwZVRPcmdwZE90QmlyN1BNNDlYbTZBTUtRNEdadys5?=
 =?utf-8?B?NytWSWpjeDk2K1hlcHdEVGdocTdlVS96OUgvczU1R3I4VlpvKzRoci96czZU?=
 =?utf-8?B?dUZpRFhzWmNDRjJWcm02SThSa2tBQTh1ZUNoUXB2aml4eXZQd3lVM25CcUI5?=
 =?utf-8?B?S0MxZVZmTWYwS3dUd0pwMVVPTWpWT0ZiRDg4UzE0aWNMWlA0YmluUlJBM1Q5?=
 =?utf-8?B?UUhya0xvbVZSWXBXSnZHK0N5SHFBZStIcjJ0ZkZIUWp0TVpHeTFWSm8wSzZ4?=
 =?utf-8?B?aW1hNHlSdFcwcnJrNjJqakJVRnMyQmptdmM2Ry92K2k4YW5qZkFFMmF6Wm9s?=
 =?utf-8?B?Z3E3U2hQc3lkTEhsQlh2cDdETHoxSlNUSSszS0cwdmc2akxUOVMwdWlLSzBV?=
 =?utf-8?B?Mklqd0RmOFNDamxPVVRZLzdCcnZtUU03TStXc0pCMkRyOGhHVEc1YlR6ZUZZ?=
 =?utf-8?B?Q1k0MTRPbjZiNzV5MnZhazFJaGlwczVub0lGYldSSXlsUnRYMzVISUVCVm5K?=
 =?utf-8?B?R09KZmt4L2RRdXN2Nmh4bzJTN3ZmcFpJUFFadjJxRk9CSG5RNHM2bnBlbXB2?=
 =?utf-8?B?dFNXcDEwdUgwVGVqTUhFTkhFUUxzVE4rUEorbkdRVElveTlrYld0RmljWTJC?=
 =?utf-8?Q?uMqgFDqRVoKiYlSI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F50F2E5D6ABB244694310B755D09747D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af49a4c-eae0-4932-305f-08da329bc8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 15:43:09.4540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS9tQTBUSxXbB5dw6sxGOw/jsWbe25zMxayFhHAOxLnCx0/+p+/ma5h9PQoVb04H8JQTEqHnxHhqr5NS+PrJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1686
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_04:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100070
X-Proofpoint-ORIG-GUID: 8aEPiP1VNv22o53nD0OepHKrTQums9ed
X-Proofpoint-GUID: 8aEPiP1VNv22o53nD0OepHKrTQums9ed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDEwLCAyMDIyLCBhdCAxMDozOCBBTSwgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IHN2Y194cHJ0X2VucXVl
dWUoKSBkaXNhYmxlcyBwcmVlbXB0aW9uIHZpYSBnZXRfY3B1KCkgYW5kIHRoZW4gYXNrcw0KPiBm
b3IgYSBwb29sIG9mIGEgc3BlY2lmaWMgQ1BVIChjdXJyZW50KSB2aWEgc3ZjX3Bvb2xfZm9yX2Nw
dSgpLg0KPiBXaGlsZSBwcmVlbXB0aW9uIGlzIGRpc2FibGVkLCBzdmNfeHBydF9lbnF1ZXVlKCkg
YWNxdWlyZXMNCj4gc3ZjX3Bvb2w6OnNwX2xvY2sgd2l0aCBib3R0b20taGFsZnMgZGlzYWJsZWQs
IHdoaWNoIGNhbiBzbGVlcCBvbg0KPiBQUkVFTVBUX1JULg0KPiANCj4gRGlzYWJsaW5nIHByZWVt
cHRpb24gaXMgbm90IHJlcXVpcmVkIGhlcmUuIFRoZSBwb29sIGlzIHByb3RlY3RlZCB3aXRoIGEN
Cj4gbG9jayBzbyB0aGUgZm9sbG93aW5nIGxpc3QgYWNjZXNzIGlzIHNhZmUgZXZlbiBjcm9zcy1D
UFUuIFRoZSBmb2xsb3dpbmcNCj4gaXRlcmF0aW9uIHRocm91Z2ggc3ZjX3Bvb2w6OnNwX2FsbF90
aHJlYWRzIGlzIHVuZGVyIFJDVS1yZWFkbG9jayBhbmQNCj4gcmVtYWluaW5nIG9wZXJhdGlvbnMg
d2l0aGluIHRoZSBsb29wIGFyZSBhdG9taWMgYW5kIGRvIG5vdCByZWx5IG9uDQo+IGRpc2FibGVk
LXByZWVtcHRpb24uDQo+IA0KPiBVc2UgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSBhcyB0aGUgYXJn
dW1lbnQgZm9yIHRoZSByZXF1ZXN0ZWQgQ1BVIGluDQo+IHN2Y19wb29sX2Zvcl9jcHUoKS4NCj4g
DQo+IFJlcG9ydGVkLWJ5OiBNaWtlIEdhbGJyYWl0aCA8dW1nd2FuYWtpa2J1dGlAZ21haWwuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIDxiaWdlYXN5QGxp
bnV0cm9uaXguZGU+DQoNClRoYW5rcy4gSSdsbCBhcHBseSB0aGlzIGFuZCBhZGQgYSBjbGVhbi11
cCBwYXRjaCB0byBtb3ZlDQp0aGUgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSBpbnRvIHN2Y19wb29s
X2Zvcl9jcHUoKS4gU29ycnkNCmZvciB0aGUgbm9pc2UhDQoNCg0KPiAtLS0NCj4gdjHigKZ2MjoN
Cj4gICAtIFJld29yZCB0aGUgZmlyc3QgcGFydCBvZiB0aGUgY29tbWl0IG1lc3NhZ2UgYXMgcGVy
IENodWNrIExldmVyIElJSS4NCj4gDQo+IG5ldC9zdW5ycGMvc3ZjX3hwcnQuYyB8IDUgKy0tLS0N
Cj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvc3ZjX3hwcnQuYyBiL25ldC9zdW5ycGMvc3ZjX3hwcnQu
Yw0KPiBpbmRleCA1YjU5ZTIxMDM1MjZlLi43OTk2NWRlZWM1YjEyIDEwMDY0NA0KPiAtLS0gYS9u
ZXQvc3VucnBjL3N2Y194cHJ0LmMNCj4gKysrIGIvbmV0L3N1bnJwYy9zdmNfeHBydC5jDQo+IEBA
IC00NDgsNyArNDQ4LDYgQEAgdm9pZCBzdmNfeHBydF9lbnF1ZXVlKHN0cnVjdCBzdmNfeHBydCAq
eHBydCkNCj4gew0KPiAJc3RydWN0IHN2Y19wb29sICpwb29sOw0KPiAJc3RydWN0IHN2Y19ycXN0
CSpycXN0cCA9IE5VTEw7DQo+IC0JaW50IGNwdTsNCj4gDQo+IAlpZiAoIXN2Y194cHJ0X3JlYWR5
KHhwcnQpKQ0KPiAJCXJldHVybjsNCj4gQEAgLTQ2MSw4ICs0NjAsNyBAQCB2b2lkIHN2Y194cHJ0
X2VucXVldWUoc3RydWN0IHN2Y194cHJ0ICp4cHJ0KQ0KPiAJaWYgKHRlc3RfYW5kX3NldF9iaXQo
WFBUX0JVU1ksICZ4cHJ0LT54cHRfZmxhZ3MpKQ0KPiAJCXJldHVybjsNCj4gDQo+IC0JY3B1ID0g
Z2V0X2NwdSgpOw0KPiAtCXBvb2wgPSBzdmNfcG9vbF9mb3JfY3B1KHhwcnQtPnhwdF9zZXJ2ZXIs
IGNwdSk7DQo+ICsJcG9vbCA9IHN2Y19wb29sX2Zvcl9jcHUoeHBydC0+eHB0X3NlcnZlciwgcmF3
X3NtcF9wcm9jZXNzb3JfaWQoKSk7DQo+IA0KPiAJYXRvbWljX2xvbmdfaW5jKCZwb29sLT5zcF9z
dGF0cy5wYWNrZXRzKTsNCj4gDQo+IEBAIC00ODUsNyArNDgzLDYgQEAgdm9pZCBzdmNfeHBydF9l
bnF1ZXVlKHN0cnVjdCBzdmNfeHBydCAqeHBydCkNCj4gCXJxc3RwID0gTlVMTDsNCj4gb3V0X3Vu
bG9jazoNCj4gCXJjdV9yZWFkX3VubG9jaygpOw0KPiAtCXB1dF9jcHUoKTsNCj4gCXRyYWNlX3N2
Y194cHJ0X2VucXVldWUoeHBydCwgcnFzdHApOw0KPiB9DQo+IEVYUE9SVF9TWU1CT0xfR1BMKHN2
Y194cHJ0X2VucXVldWUpOw0KPiAtLSANCj4gMi4zNi4wDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQoNCg==
