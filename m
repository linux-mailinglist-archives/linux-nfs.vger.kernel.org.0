Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB473725F
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jun 2023 19:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFTRLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jun 2023 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFTRLe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jun 2023 13:11:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7319C10DC
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jun 2023 10:11:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGDwn5019858;
        Tue, 20 Jun 2023 17:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=abpI+hS2RvEQNtXHzbHZ+pVSdVFvweU+J+kifBzb7nw=;
 b=1Nsyq0F7WlmtLd/Ii4Oyce6M9HuB1bbLdbu2PZIRWFZSxT0lOwMPjfaQgw0yDWSWfpxE
 MfQntfxTXEC4b/pcgmD5rBh//pAWlIouyDMxg7kD4P73oYPyS46BNOT5M74gYDhBnmAv
 ETGbG9BqZKzCRtOI+hY8n99/l5fGPJcKIVmZfZUpHQty1hsArM1hFpIbh+V0di5VIhgA
 8ta5BqzhHyv+glUcURAEY5iuCscAONW1Fi0d6F3sZDvV6JhImnS4dyRFGCjdF+zSeRmb
 fnkqezhMHIM++YH2He028DBfMIHihAys6BBH1PD/GbqslFNitqe4QxO5shOmXKZDOS+0 /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dnb68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:11:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KFirQJ028809;
        Tue, 20 Jun 2023 17:11:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939aw6pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 17:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlAWHBNwodDBcD9IpQlpBXmWaGr1jdpALiqZdmXfHYdej5J9b7gG9El3oWUgoTXIo/HZ+0O4nplkUV0iqBDtSR0i+Xx7RWn7N6j4gE6Cz1ED+2YcvMmRbegLvOJTEMUCyw/fPObjm3dx0ieeacW1gtw41Wjk29+p28WiOOzrhaWw2CjJnLdyTZcIOSA19OGX8MeLRrdPCC+XKFXtEb79erbt4H1lXPTycsutK0nKI3Twngw78T4P4eyx6CbtthnTWTlXLmc3uebYt2Ywuj8RoVkYNtJmmyt7zVRRkrkDooK3wEd2Xub1mt7/a6THKF+prCRiXEPgLlv05lHIHePxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abpI+hS2RvEQNtXHzbHZ+pVSdVFvweU+J+kifBzb7nw=;
 b=KHwajRUgalsYcBaBrAA0ISeJcwoNZKNgcycRs4bpmg3ACnuowlxHrAIbtDoDts+csfGcwTiEO9EHwljldEmRt21oZOXv6kOccQC/mxaf2FvYVftN3R4tDfVosY7dEI2+gf8OKE0zhzxo1htgSBLFQL26nNaWBkqIchfT3jIinvQ+KCxc/XDYmC05owQYreseOvDN6OJL50GFBAfXvSvKvbrDxiJb96oy6ZB7NQghx0t+4a6g7GDx65y5xr6Wh5Mz5Eez33FdPhc4kckOKVHLvjo8sH3QxNvXmglVVZL/9lLb/vCYeMGpJxeQbfUnls8wEkqbOzmdeCX22HgYLwJ0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abpI+hS2RvEQNtXHzbHZ+pVSdVFvweU+J+kifBzb7nw=;
 b=RiLMrRc37BBTr8BCT2NnESpryYdNffrEYpQsLPSGU1wzueMvyGRXUY8ei08AFkYTar87MRasWRHtrrFYKCvD8egHNy9JVD6UB/YVwJwTF1ncd1aJqVWE5vW06caC01D3y3OJ+i5cTvwvupIVtxa3TY418FrI9rW505VttOXJtI8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 17:11:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:11:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     Jeff Layton <jlayton@kernel.org>, Tom Rix <trix@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix clang-17 warning
Thread-Topic: [PATCH] sunrpc: fix clang-17 warning
Thread-Index: AQHZlJYb6vjx06AMBkGvsuYKh+iggq92BGoAgAAPooCAAATLgIAADT4AgAAHiwCAHd2fgA==
Date:   Tue, 20 Jun 2023 17:11:22 +0000
Message-ID: <41946493-D36A-454E-BCC0-B98EDC7F5BD7@oracle.com>
References: <20230601143332.255312-1-dmantipov@yandex.ru>
 <2D3D2D8E-4E7A-4B50-A1FF-486D7F6C26D4@oracle.com>
 <8ed6eb2b-fdfa-4fde-81f3-92e6b34bc509@kadam.mountain>
 <ed2f956d-632a-90e1-f2e9-91710be5f2de@yandex.ru>
 <c6c5c38b-f258-4dda-8227-5f672b37bc77@kadam.mountain>
 <9fda7891-925a-1d9c-7c70-a7b040211199@yandex.ru>
In-Reply-To: <9fda7891-925a-1d9c-7c70-a7b040211199@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4817:EE_
x-ms-office365-filtering-correlation-id: b8a9c6bd-7c8a-4f31-4f03-08db71b15f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/d6a0MlrBB7oSz4Sk3un+8SAmzMiGet75Y41nQYK3UZPSPIRMqYZSf0QoO5XC+CcWdxE7ueZQXl9WUKy9l5YN5JusyTn3kcah193gfoyvBurC21HC3LjpfMlI7rKGxAYDB1gSIsBgM4jnvmaFeppbmmXmeOKvQiftdGqXSFoJm3PIU1vgJjObnEYnnu1MloONtcEPAi6cdpqI2+DZPCv/BZnH2oBFVaunTeIV36F/O8XJuIqzW0xVofEyLyvjAVEWfKvJP5zN60l77k5Xjflxlf33QsanRjq6Rw+J4gaU1NY+6lMpKSeptTZ2FJMkOdJp5AFUC/U4ZbU03/HTcZym281EX9iJlUyfUIBxo2mMrIbV8u3HWN/7Dd8cLs4ndGh489kgLTcsaMRySCvo2z/t4+wE7ZR3aqIqAoKnSxo/TFtQoVLuHY1hK/B49plnQYWE4gG9YFW+JZ7snJFCuGwz3C/gbeK0rnnoAwurqStlnKr/69gl7m7P+dGNTQiNz3eWcvnL2I+VHFb/+A5uT7ABXDz/umq4rfIWcY2Tc5lu3yrRCWYBZ4wpsj0Skn67Z+It1MT5aD8+gQKp8u7stQGlb1SrtPjjG0DRX9Vg2eud0d5y87NyBcSTLsuk+J3RwGz022A65N1eMngaF6B+w6/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(53546011)(6486002)(478600001)(71200400001)(83380400001)(110136005)(54906003)(2616005)(186003)(6512007)(26005)(6506007)(2906002)(4744005)(5660300002)(33656002)(36756003)(38100700002)(122000001)(316002)(76116006)(91956017)(66946007)(4326008)(8936002)(8676002)(41300700001)(86362001)(66476007)(38070700005)(66556008)(66446008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1wFkNZMFvLBp+tPgtiApq9rjlp9YXQwgKBJSOMkDUmil+I5vYQC/U2MMpJvO?=
 =?us-ascii?Q?geGlEfoLBGics3Rl10u5PlcHbJ3yuqU9BAzATncJuk5fYjZOHlD1sAm8wzWZ?=
 =?us-ascii?Q?DL6WZz8LqHTfo/Su1/EsqAmsqcwCcSJIBLMiGAqBvKOpktRNrEumaobrc9bS?=
 =?us-ascii?Q?HiNR1gkO7iHolkoBfXU2nrbEiHRjJ9rJ+VMBNyvX5bGzjIcYUs9rY/n+bTvj?=
 =?us-ascii?Q?Y31CyVCGWgxpPEva2iSZiUkfjW3MhnzXQ1C8g3wO/4kQMA+zUEGJ0p4wEaY+?=
 =?us-ascii?Q?yKUh4Yw8nmbtn/5vYyV9ruOoABRWGwTQSVlofpAZ/6hV2Mk8QyuMcvGd+in9?=
 =?us-ascii?Q?q21hQy8eEm8QtvbGTaTSPHzKNAYHv1YeU+hMALTovNL8Pf+GydiDC4boYess?=
 =?us-ascii?Q?nPM7EZXfVyWdTv0tf6d1ELlEWBk2vp+4l2n3aSBCARLEYnJ3j5tFTzJ4+WRv?=
 =?us-ascii?Q?SVpBwiYvO1Vl8qLk8YwFFbfejo9VAUdxvGvxJuCQ95h4L1LBickN6uioQl7L?=
 =?us-ascii?Q?l8utTMLhl4buDx6xCVUAsS6hxJUkQRjbWnXc/SbBhnMbcNqRDwNMQIXd3OXR?=
 =?us-ascii?Q?dKYl1I65Muqn0uXGhQruEcljiTTpFl4A2pg55vJl13T7KGBKauT5BW+cAnnD?=
 =?us-ascii?Q?/aNpQGTTNvfMroJR25dDA/ax2PvEX4fWHi4TAj2yr6pK6vXlDuxJ5SQwwWbA?=
 =?us-ascii?Q?zG/4NdDFh6X7WgRFAE7+L1GQ97ViRuzhMBbW5xH3My7nX8DU2ZZ4ouLG/nRm?=
 =?us-ascii?Q?6N8aiSGW7JoraNfTsrVLwUa14D5TZq0KJUeytcHqEJ+WdbURwsWUOj6hIbQP?=
 =?us-ascii?Q?Yt//omsw23516jx6QW6FSvZpkNSlwFXm3jKPq2wdjYQMGbd0WnpYcz9Gkq2u?=
 =?us-ascii?Q?//Ynu9ktknQrTVfxEwBqhfadmz8haP9QDFVsGxQfAV1FrJMRXasIWI+bkyQL?=
 =?us-ascii?Q?RnSRBd5X4Aj+uc/HV1HgemHLzfB22YyHGIznTWh++2SHbD2rTZSRQuh3xl5I?=
 =?us-ascii?Q?P7ioWRLZvYddYVvZdWvnxZ2BVWAF4g5D2Dov56InUu+u7WDXMkvA9RRk8q3b?=
 =?us-ascii?Q?i4Zz/wlkWn+RRZitekTZ6RNlEw2pZDClFgZHRdpaEER9Sg1IpjBIPuQSuANq?=
 =?us-ascii?Q?xMik5A3lkNnn5FfIHistBQmCv69vqvuCcYZBlV86DflgnoGA79L/AQFEQx89?=
 =?us-ascii?Q?rCzRa7+55xw7dwnzK1O5LHUWeSgGSUj0ZSbiQS/i+J+S7TPKBn9iXKmPDb91?=
 =?us-ascii?Q?dnGYFvz87fjcnnTVVgTjpqyM72e1dhH2FdyfxAvu2pFzCFQ/8h6K4R7wumAe?=
 =?us-ascii?Q?fH4DVDtaltO/gn8DoN7twaQaTc7yKwO/eN+qm4YYrWFT1Bl+8GKYIzSHvltR?=
 =?us-ascii?Q?DJ7dEYMu9lRTElzrTqaIGz57TOIpGRcjVf4g+TDcP0EpRFX6NqRaN+4A7I1r?=
 =?us-ascii?Q?31LBOXOQWUIuedoj51Eq/Ikc1i47OoSsCIC9sSJdoLqw7TpCRSLOBtHXNZBH?=
 =?us-ascii?Q?AuEFv+6mWr6mleyFCmTU74CS/Z6HL0z/qyzwqU7WxLyI7LAwUP2M0S7QoExH?=
 =?us-ascii?Q?EDQlLeoFKMb5vMaetM/yqIfGwNCdXIZVpW/Nk8SfScElfs5VCUIyWxrsa1JO?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBBE28788961CB40AACFEF31BAC5875F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DNQOWkOz2iFmZ5iwgL0bZVXiM4x770NchVD6HO/Zsn5/6dR1EzYyHXJXS9rgZeLSPFkWS6Si1l6axsKDNjKd8fPYByuTM4Gcw2wF6b8PWbHOYGenwD/MeOjjgseDSttmtB5RdU3HMOIFSiCF0sR7g6SpDqXyTTVXkFxofN6RKygnKBcs+cLS0RYaxgtePZvVO2T5FfTh+wM1W5Iw8AZQuj5DA6GLRZmfdB8r9y5JXe4jYmCKRNFYTvuKxwKUhyZ9SfC1aYdvekkfPeLYiM9UPJGYpjNoix9MTi7K25QIM0PI/ioyOYy9HbrTjyIr51gyzWwh34JMuDpcA7XlW1HS3IvIEy0CbTBlcHEWafUWF90rOcV8AlwarR9ZSbz8ysJqmGzDCijiCiJYSvh+3+jA1cbOFhtA8GGLr2di8Io9TSim2IMWqvUOxvTxmWDVVo2GU0yPXv2TC/rZkvoYOgdhoOeN70lrKqHSdGUaJV4ivDjSClewlItvlfiVd3tWe74matU8mmROLmEGlIMIafVS81k6dToIE3C2un3UI9d75Zou7aIhL54yH2PZ0t1zbqSbxEgebh38A/psAsb+OHaon+IKz6bXERxxjhBhrWRMjvqZTxMtVmP1MuPqSo0FC8NiD8P165QI11p3QIWY8E0a1c9jtSzj4rRk71/dgzSGXBFrUZxvI46lNJmH/j4yqE0fxJLr/LnORYd6z/KbxjAqW/bskiE6fztLEZSfJe82wA8KmqPDlwiDcG/SwS1MOOjrBI9epRmQ2dU3LPHC/MzMq6loVzvE0eC31ZMjJyjR3v1vZtGTX9NujQMAvZ4Z0mbulg2mCf6ODh401Esy9ViVF4y7FdOoyCKe3GXBdtUe9jm1bRWsbiPON956TPlIh95s
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a9c6bd-7c8a-4f31-4f03-08db71b15f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 17:11:22.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6LSOz6scGFec02ROFaBnbD7BfnaMek9JANKIwJ/4lOqSbvBgaZIXUW888Bv+6R9c/pxABNVPL/IaYbgKYGNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=761 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200155
X-Proofpoint-GUID: 5vzC9BUXbwqaTX5AN23ilqh88Q027c6o
X-Proofpoint-ORIG-GUID: 5vzC9BUXbwqaTX5AN23ilqh88Q027c6o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 1, 2023, at 1:06 PM, Dmitry Antipov <dmantipov@yandex.ru> wrote:
>=20
> On 6/1/23 19:39, Dan Carpenter wrote:
>=20
>> It's a false positive because the test is obviously intended for 32-bit
>> longs.
>=20
> I'm not an expert in compiler development, but I do not understand
> "obviously intended" in this context. An input literally compares
> <any unsigned 32-bit> > <max unsigned 64-bit> / 8, which is always
> false, and so the compiler complains. If "obviously intended" means
> "the compiler should silently optimize away this check for LP64",
> I would disagree, and that's why I would like to see the confirmation
> from LLVM/clang developers.

Dan, Dmitry, has there been any resolution of this issue?


--
Chuck Lever


