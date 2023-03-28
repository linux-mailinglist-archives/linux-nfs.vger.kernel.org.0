Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC216CC131
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 15:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjC1Nlb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjC1NlP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 09:41:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B577C67F;
        Tue, 28 Mar 2023 06:40:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SDT6r1030460;
        Tue, 28 Mar 2023 13:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BZuc7VB7isfLElax15hNuK9YtEa9oVTryDN515F1gZM=;
 b=U/aswbvNieTFdVuhXluQUx0iPiXMo4+Laak18Bmtu/Kh8ABaQJFSYJF7wAm1vllmjiAD
 iFtfGCL6niyUFvOt1VaFazgqsG5e55j4VRJv0e7lR5Ojfbxh4VzYaFp3T5FTXwFO0t48
 7dIslDtE15q5c6MmMYraJ3kNb7/4WJDxD+JxpX3yHtVS4ZJX7mG7DjbEuiMzzJxxcJip
 bRalDaYbb0QsmLvl+rTqSmt80/c+7J2R6Y0lTqzD+7muvOJhT8bD2ZOxchkcke7v8vUJ
 FbreJcKdO4ko3KYhqo1wy2eWX/QQxI7VM2V954h13XE+DsBaH6TzbOPQdLP6CyGB7LSS Dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm15p01cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 13:40:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SDVBm5009318;
        Tue, 28 Mar 2023 13:40:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdcx4dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 13:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjsMYUyIwwTyrYlzYx6uwQ27FGK8qdEsolC1BxL8UsDdwYH5Z/bJEKNaPkSM0Pb1oeAQ++NCsgGDMVaG8zM6r58XPkvrUo9iQop82naoQ1hQhZIbFU416YcFZcCZQSPWHRaPFQqGx2znWEib41qY03ls76z7FlBI6IUQJzR7Wcax/5k+tGmRdBxa+as0EjCi0f6fKoeS1sxYyR0ORrwTISXzoMf2maYAZLh4vCfU19PZ+ocvb07bw/V7VUIFp/yYZglHQKiCMmsfIcO8aeRcGGb8ncpZbLbq0Mf1VEYBRTe6p54xFTCHmP9+QIUHkUtK46xwEsYc2ZyDrCBpLBrDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZuc7VB7isfLElax15hNuK9YtEa9oVTryDN515F1gZM=;
 b=iqJNNnxR5S7tweHpHizKLnxv/MpN9/C6Nt/6FQFjGyMadWm4Za39pBLKnNhFeE2wcr8UR9s9IGNUiEoKcwtE2S9QDa/1J7IF6i91AjAFNk2PGPGOltbMFTRwAgS+9o1W+E/UFYZVWMikfEluT2w0XqshkDUtNALtxtRqdba/MMA4QyyC7cerCUFfZkrvzEOkgw/JHIosHrKdbJxvS7yBUzIjJtaQKEEvbXjybd7EmLZwGiWgoW1FpDwISbg8RGOOT7TRCy7msrxwwyoU0psf+Pbvtfk+YisCZWOEngmRT+V80eR3fRpGligNhJykwjxvzYrsLWDqlGtjtRWzR6Cbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZuc7VB7isfLElax15hNuK9YtEa9oVTryDN515F1gZM=;
 b=dkpLn/aQZXFSiXe5WFPr5y94uk/qEQ7PANl8Oo5cNe+Wwb5B6UasalP5waqsUUu96oDMFLYhHj1SKQFmO+lb8Z3wlO3XrVMFanAFD5yFcsZ6p3hD1XUlk7w/oAcwSNCo1iYL5QeXdpE+3PkwdgxbH4eKvOTFrj1X77qp3dzjCZ8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 13:40:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 13:40:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] NFSv4: Fix NFS_V4 select RPCSEC_GSS_KRB5
Thread-Topic: [PATCH] NFSv4: Fix NFS_V4 select RPCSEC_GSS_KRB5
Thread-Index: AQHZYUaWBGM1a5WuKk+I2VS9GPp9K68QMzwA
Date:   Tue, 28 Mar 2023 13:40:44 +0000
Message-ID: <2968C736-0150-4AFC-94BE-F9F8C2859F3E@oracle.com>
References: <42751e1fef65485a5441618bc39735f8b62b3a46.1679988298.git.geert+renesas@glider.be>
In-Reply-To: <42751e1fef65485a5441618bc39735f8b62b3a46.1679988298.git.geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7106:EE_
x-ms-office365-filtering-correlation-id: 526e6348-995a-4663-19c1-08db2f9207de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YKgDwzpRE1dsShRnvcmj/fYyyR5c0cf5rtXBvhRB4h+BZcYvfjSbmo/urOgxyHPxGl8311eaQwvoonha+qIh893X6Mcgj5LEZ2AV3Hdfs2hkEpzAq0+0mvrRxXrp+8QbHBgzM37zrEgu1KxmJdZPlDkAuO07c6Cn6KHwGfscCit+H1EDDmcZu0SzzkE3qoky6wkSkyQJ3fa6RCxQFJK9ILHgeBsCqtlkmE6WwkpFUi02PeeIQ2Or81w2BefURq43ggZpQdoDH/jvRLPY1+OnzLZzIeOkbjaD6u++fQV+ojD1K6z73l5y/ldtDU1GO8WJNf6SDJH9m6zHlueiLtiCcMPCuoO2pzxEhQjeSKlVrkRfkyw2MHuT4PBK4oGTa+sKm2dCU89Cc8/FIU/Ctz5LV8tZWEEnwzwUgnBfZaKnM95gJf7wKRObh9bW73TgQBITwoblD1TNBdtwswvDhflTE+F6MG+iNR3pBiEPDXN5/VmhQPxRHfYFWDX+40zATXqd2AH6AhNbpLDN29/Dx9qtg8CRdG8pmSFz8fImgI8G/Y6kzuMegNWKMQnMReL2we4WBGtSTaGHu3qwmOisylM+cYq+lOv4P2gIOMBRSofj1IxYPAtzQ0dOk9Eo3aMDCtiDT5tqKKirW4vtkQh55le0SL9MPiiqSbOza4Llbz8P0rw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(66574015)(966005)(6486002)(186003)(2616005)(83380400001)(53546011)(6506007)(6512007)(41300700001)(122000001)(5660300002)(2906002)(8936002)(66446008)(64756008)(66946007)(38100700002)(91956017)(66556008)(66476007)(76116006)(33656002)(26005)(4326008)(8676002)(478600001)(86362001)(36756003)(71200400001)(54906003)(110136005)(38070700005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3ZkWW51S05ianVrZldMSGVIQ2FyUndCRXFDNmZlcVhQWmVmVGNNVjhySlRP?=
 =?utf-8?B?a0xDclJwRExBUkJyeUZHQUMwaEswUUpaZCtzSWFpQnVSNThNMGlOZ1d6aUdC?=
 =?utf-8?B?THAvMXRwQzJuMG1NSy9FeHljOWhVdXZ4K3U1NmhxTEZva3dySzhGVTNBZ2lV?=
 =?utf-8?B?eFFQekpVeDlNeDBtK1lTU3huZjRQZGY1cllNZ1JqU1o2QVMxLzhteGhjdjVp?=
 =?utf-8?B?cDRkSENWS0xJZUJ1S0lmQXdLTzZFdmZRWlB4Yjc2cHpQR2tTUjZLRGo0WkhX?=
 =?utf-8?B?eWVPWVVnMXovRW1xZWlMVkJOZ2c3TERGYUxhOGpWdTdpelprTGF3M3VNNC9i?=
 =?utf-8?B?QlJiMEJuUXZXcHBZWFd4YzNIOUY5RGF6bkdxcUx4RTZuczd2OGRzbHJTSWYw?=
 =?utf-8?B?VkhiOEt4WVl2NzhOWnVwdFN6bk5IN3dGcjBpQWlKRVhQNUs1QVl4Qkt0N3Ir?=
 =?utf-8?B?czRWOThrMmZ0bzRFTEl5cVRsTzRCVG05NWN3eGZnZDB5N3pZRFdqUENKTG9y?=
 =?utf-8?B?N05wREJjSStSTkQ5NnV5Q2RJNDZ6eWowWFVxamczSGQwNzVhaGE0OHlIcTNS?=
 =?utf-8?B?dlovYVp1d1dUQkdMMDJiWjYxZTZpenNieWhSVklwY1VGcXJiY0xwWDIvSURI?=
 =?utf-8?B?WEdQWTl4ZTUxellqa3ZXVyszWURZRHljSlhYVnYvQlloYnBUUVFRcWRrMjZU?=
 =?utf-8?B?WnBCS0Q4em1JQmZUTk5BRnFyejd0N0ZQbFZkUk5ORmxBZDA5dmFBZTErYW1h?=
 =?utf-8?B?WEYwSzlVaWh6N1NVSnViUWtldCtMQ2ljSTIxdXZMNWpNbHNMZVkwTXB3S1lD?=
 =?utf-8?B?UmhReFN1cXI2NlFjTlhBS3FQVE1mK3FkL3FaZmlLTmZYaW5TV1RvTmxGTzhQ?=
 =?utf-8?B?YXdmaDY4a0lIYTB2Nm5BUnB6a1c5QUdSNlN6Y1pjdnovSlhxekhtTzl3ZVpB?=
 =?utf-8?B?Wlk2bjZ0QzJUS21xbFViSVA5Q3JNUjNvQnBKMi96RzBQUXpjbWZFb3NsMW5D?=
 =?utf-8?B?V3Q1N0lVbUUrRTZPdm51blRUZE85ZThpNERiVmh5N0VsVExzVjNDQXplODFk?=
 =?utf-8?B?YS9xNnZKVys5VHdDQThRVFJ3Nk9rWDBkaTlCSlF6RUo2bVVzWGdOemo5aFpk?=
 =?utf-8?B?blkydk1QV0ZNSFVMbE5Ua0F0b0lwa1IvajFISWdNc0VLUDRtdVZ4Z2swWEk2?=
 =?utf-8?B?akV0bHFNZ004K1E4UlhUTHpaRlBHemhzU2JtekhCeXpuSEREQWJiUHhFMHRa?=
 =?utf-8?B?WmIyTk9PbHBQSDQ2Z1FMaUozVjFlVmVoeXYyMkMxV0NYMnpTRWNtQnY1TDZs?=
 =?utf-8?B?eUUwNEYrZlpxN1VIdTJsWHcrV01RS2pscVByZzlFTG8yVkRxajJrQXg0YXI3?=
 =?utf-8?B?b3NCNitwZEY2NUNKUi9BNnQwUzNtWjRmZnhkMzdELzFtSkZqK0lpNktRRVRV?=
 =?utf-8?B?YzJ0ZDVCRUZnbmNwS2FBdVlEeHNWR3lLUndyV0RrN3pvc1dyUHZiV2xUaFJk?=
 =?utf-8?B?eUwrKzlLajNrbTloMzVxTTF1amRpUHgzc28xeVVKSjdzcUZOK0svMmtINDRI?=
 =?utf-8?B?RzJWYVVNU25DYjBZYUtqL3Z5Ukg5emtwZmdzcjhBKzM3N280YzN1T29UNTZu?=
 =?utf-8?B?QWpYbFdIMk1PVlBlUERHRXcycmpOODNMY2ZMZ3NORU1HVXVTQi9DdjErQUdm?=
 =?utf-8?B?bDA4dlhVWEV2eTVjRXRubk1FdnpsbWVRY2JqTmtLb1VxaXVoeTNrMmpVWnVz?=
 =?utf-8?B?aHZlYVRLbFovNFlxbC9FeDFpTnBvM1hpNldEamlGd2dLS1A4K1VLRC90YjRh?=
 =?utf-8?B?eHpQbTJWZXR1SzhDVDh5alNFaXhNK0VkUWV0WGdlRCtjcW5aSm16dHp3TFB5?=
 =?utf-8?B?L1F2eFpIbUZyUmlzM05RTnB3TnljcmZHbk9WZVQxU25nZDA0a0FvdGlQWUEy?=
 =?utf-8?B?TUlSZUhvbkJKb1Q0azI4NVJuTHVDaVhxR3IyVms5MStkMUsvUm1OcnVzMVl1?=
 =?utf-8?B?MWZmcmFmNXlFRGtxaGsxVTFKSnoydG9jR0pnVVVRYlhEcEp5TUgxQXUwSFFX?=
 =?utf-8?B?eUZzb3JaTXNRY2ZhRUovdThQeEs1bWNpZFljOU9SQTZ6T0t3b21naEFyN3Zr?=
 =?utf-8?B?UTc5UnpLM0xLcmR0aDFqR2toT3ZmV1g4dWdrVE5sV29tK3QxbmlKM1pjaE5i?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCF25BB45D511C4F985A835D2003FBAE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HGDCAsF1zQBWSprNuXDcSeu7zq0DhnqqlRybAA7EoI/95KWWthFBpSmA4Mab3Z+3DdeDP7IhBmoV+v7Jclgoo+dduRskmV/WkgEw1V+zszcgpUS+4hyl3e7b75mEQlvuO2DvCufPPfodjumvkANeybdSz1RBTpubgwqo159xLnqbdjfeZ780YURQLCg/2tS2+ESALEa7UY/6wJUdoo5DJ/JRh6jSUaAFgft6GF3cbQEWq0wQ5W6G2l4fnShzOikdbrouplFyFSt8HYA/0UWR8AiF5HtHFHQLhL9oMGs1d1Y+EQgTouH2mDUgyRN4qwUc0aM9zj+bLfIn43fmB0i2pfisix5q0UYkkZULjkEcj6SHY13V3HjdUkhs4xUSxqjOowmE6npaPO4XPLj1XWa43WK9AbgNs7+qQ5WSwYhZbM+uJ8+nQKfEc+cVPYg8p7+zQrlnCU+z52gPtxJZ1aR3k1J66Vy1KggZ/hjLPEVuGvvRgVubI1N2XqNREdRDCs+9X8NMJWbvCnyJw0vrOYF9e8mB3zMG4+nS6c6m5TDzJVgNvNz+OGuD/8QoKT6tnDkzoREJLT3998fRjX59VDvxnhdewB/Y+maljuxinteE6fOJJ4v04iBq0E+Tf01gAFSwLJH5rWN0GtFIaUziW0ZqIi7hG5CIpEbA8nxrC5ZmGJk66MjI+IELW6qH3GV6R/hkj+1YA/ptHuT8PM0W+4Fe82d9TwWvaN1YzRt7Hdpu7AfCq86TqYQhqHd9e0+d9dxnpYzWyxEOtPjrm/Wjy41ktsk4dISK7GTR2oS0Uz3SftwYpM7mDvP+Sf5xzQzwtfkMV3kYtEztjzHxrA8H+6O58Iu9rLMG1vRVNmUCUIYdCtB82niQIB1SP8sHBHbUIiyKBeVnEDuZmsAjZlzpNK8BKnp6I6oVlydMd1zDLmTdciE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526e6348-995a-4663-19c1-08db2f9207de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 13:40:44.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFRqo7/FvXsnslnVCtsK086NETMaRw+NU22IpYF1M4BMxhg9WC0fRfkRllHXghGAHw60FiWNqzAopMcfJNkz4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280108
X-Proofpoint-ORIG-GUID: EGStN1AgMStGI8IVhB8cswYn6L79kvfQ
X-Proofpoint-GUID: EGStN1AgMStGI8IVhB8cswYn6L79kvfQ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDI4LCAyMDIzLCBhdCAzOjI1IEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPiB3cm90ZToNCj4gDQo+IElmIENPTkZJR19DUllQVE89biAo
ZS5nLiBhcm0vc2htb2JpbGVfZGVmY29uZmlnKToNCj4gDQo+ICAgIFdBUk5JTkc6IHVubWV0IGRp
cmVjdCBkZXBlbmRlbmNpZXMgZGV0ZWN0ZWQgZm9yIFJQQ1NFQ19HU1NfS1JCNQ0KPiAgICAgIERl
cGVuZHMgb24gW25dOiBORVRXT1JLX0ZJTEVTWVNURU1TIFs9eV0gJiYgU1VOUlBDIFs9eV0gJiYg
Q1JZUFRPIFs9bl0NCj4gICAgICBTZWxlY3RlZCBieSBbeV06DQo+ICAgICAgLSBORlNfVjQgWz15
XSAmJiBORVRXT1JLX0ZJTEVTWVNURU1TIFs9eV0gJiYgTkZTX0ZTIFs9eV0NCj4gDQo+IEFzIE5G
U3Y0IGNhbiB3b3JrIHdpdGhvdXQgY3J5cHRvIGVuYWJsZWQsIGZpeCB0aGlzIGJ5IG1ha2luZyB0
aGUNCj4gc2VsZWN0aW9uIG9mIFJQQ1NFQ19HU1NfS1JCNSBjb25kaXRpb25hbCBvbiBDUllQVE8u
DQo+IA0KPiBGaXhlczogZTU3ZDA2NTI3NzM4Nzk4MCAoIk5GUyAmIE5GU0Q6IFVwZGF0ZSBHU1Mg
ZGVwZW5kZW5jaWVzIikNCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIw
MjMwMzI0MTMwNy5mNk5lVzlnWi1sa3BAaW50ZWwuY29tLw0KPiBSZXBvcnRlZC1ieTogTmlrbGFz
IFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg0KPiBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yL1pDRzZ0SW96MFZONmQrb3lAc2xlaXBuZXIuZHluLmJlcnRv
LnNlDQo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0Bn
bGlkZXIuYmU+DQo+IC0tLQ0KPiBOZnNyb290ICgicm9vdD0vZGV2L25mcyBydyBuZnNyb290PWFh
YS5iYmIuY2NjLmRkZDovcGF0aC90by9mcyx0Y3AsdjQiKQ0KPiB3b3JrcyBmaW5lIHdpdGhvdXQg
Q1JZUFRPIGFuZCBSUENTRUNfR1NTX0tSQjUuDQo+IENPTkZJR19ORlNEX1Y0IHNlbGVjdHMgQ1JZ
UFRPLCBzbyB3YXMgbm90IGFmZmVjdGVkIGJ5IHRoZSBzaW1pbGFyIGNoYW5nZS4NCg0KTWFrZXMg
c2Vuc2UgdG8gbWUuDQoNCkkgY2FuIHF1aWNrbHkgdGFrZSB0aGlzIHRocm91Z2ggbmZzZC1maXhl
cyBpZiB0aGUgTkZTIG1haW50YWluZXJzDQpjYW4gc2VuZCBtZSBhbiBBY2tlZC1ieS4NCg0KDQo+
IC0tLQ0KPiBmcy9uZnMvS2NvbmZpZyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL0tjb25maWcg
Yi9mcy9uZnMvS2NvbmZpZw0KPiBpbmRleCA0NTBkNmMzYmMwNWUyN2RkLi5mMDVjMTNjZTAxNTVi
ZDY5IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvS2NvbmZpZw0KPiArKysgYi9mcy9uZnMvS2NvbmZp
Zw0KPiBAQCAtNzUsNyArNzUsNyBAQCBjb25maWcgTkZTX1YzX0FDTA0KPiBjb25maWcgTkZTX1Y0
DQo+IAl0cmlzdGF0ZSAiTkZTIGNsaWVudCBzdXBwb3J0IGZvciBORlMgdmVyc2lvbiA0Ig0KPiAJ
ZGVwZW5kcyBvbiBORlNfRlMNCj4gLQlzZWxlY3QgUlBDU0VDX0dTU19LUkI1DQo+ICsJc2VsZWN0
IFJQQ1NFQ19HU1NfS1JCNSBpZiBDUllQVE8NCj4gCXNlbGVjdCBLRVlTDQo+IAloZWxwDQo+IAkg
IFRoaXMgb3B0aW9uIGVuYWJsZXMgc3VwcG9ydCBmb3IgdmVyc2lvbiA0IG9mIHRoZSBORlMgcHJv
dG9jb2wNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KLS0NCkNodWNrIExldmVyDQoNCg0K
