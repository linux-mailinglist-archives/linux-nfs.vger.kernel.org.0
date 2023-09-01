Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC47A790071
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245350AbjIAQDz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbjIAQDz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 12:03:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7710EB
        for <linux-nfs@vger.kernel.org>; Fri,  1 Sep 2023 09:03:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381CAUkN005230;
        Fri, 1 Sep 2023 16:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gAAGGRLK3L6tSyZ05UMNyUSTniQDeubA8lNNNJdnb2k=;
 b=2Kgefvq0npB2VvUj5EKDsGM9kQ81SalvBIYx6IvcvLti/0tnOwVNmFoaxxLR/AKMOZfK
 LV2Si/7jXr4r/gHJZ4jyNcYkDABJI3FN60VAchNh+/37cRGEevcnXIJubUyhVlQokc61
 s39pA/d8MsnQ8bMzC1D3rYB+SBeMyuPQGUtC2Zr9iLiOYYKUP37gviNN5DwsiwOQqXki
 tePR/KjamoJtfq7J44pAqhLqf4JjcLybHLrZLt3vkcEhBTMY0+SKFhyQYzJnFzehbt+y
 9kJ3wnXrs+0IbseFQUik4GYZ0J95SKQPtufYV0h/cJhqjfadlOby3SAKuZYTjQ21T2GP Ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4md7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Sep 2023 16:03:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 381EJ6Sx032856;
        Fri, 1 Sep 2023 16:03:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dt0yd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Sep 2023 16:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2vMfPUCqetOYLF67sUeG4dyUdk0/iruT6Bgmb10uemGScofZEJ2cVXHQa1Oyvsg+oT/foM4aM0/pn6fr31GFEJ+srqTuoye8ZcKCwtu6KSeHVUKSYHBekSQ7yneKGdfsjorsYRtGtrlkfcoNRjZtwnKGgQ27AvgfcRJCsKkKwRY0cOLfbVSZKc4TrJYyuESxIKEBP1dAX4bo4vCLlUA7wAckQBbFyxvd129vtwRFaHAfYEfp/kWK1zrqWdayzFcxDV6aFKWE8aX0XJeCE/2GIQqJU1iSWzH+VIQ3vNaqH2M3pGFguE0G2Z4q2Cp9MiLF9dsVRCD/dwfypgyku64fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAAGGRLK3L6tSyZ05UMNyUSTniQDeubA8lNNNJdnb2k=;
 b=Nt7AB7yre3jDN5ni5Xbt++exRrrXxUTw/4B48Uk44lvAOQJ1mJ2QybPRxqwNVFf0Ict2aCZ3G7qOwjsxUguqwCPv9f5EDbklFbXgrCKndZ/uR3olN38d24tzkzbm/psVxNxyQd4sm8X07bkaY/Hxap1UZjwmTvy3iKLwlkwFRIXkm6hJAksnuH4MsQ13l5JBmWZn8IrT/bVijpV0pTpyQNzTjhbbO10BQrGLvYiUUDNMzb6fTiI8U1e61zhNCshlbOblFMh4LGslZKFIiag5sQm0bzoM7IsNZd34oZy040g7v0WLbQ9EWULng0kz3VT8j44MUc88B5/cagTFwdlaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAAGGRLK3L6tSyZ05UMNyUSTniQDeubA8lNNNJdnb2k=;
 b=y6rWI9Br1xF6ULRUHSGEB96vJJRMifRPdQ4nmBNTGJ5+FcgF9AtpVrSJf88nvIHmmKH2Xof2+j19wp4xD4Rs2DFXd33uUzoG4HfTz6DtGePfMrahl34VU7fUYQ8iLN57Ld+X0LgZKWkZEbdJAUvIFezjQYq8rUeXwOSjiugmBGQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7754.namprd10.prod.outlook.com (2603:10b6:806:3a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 1 Sep
 2023 16:03:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.022; Fri, 1 Sep 2023
 16:03:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Rick Macklem <rick.macklem@gmail.com>,
        Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSv4: Always ask for type with READDIR
Thread-Topic: [PATCH v2] NFSv4: Always ask for type with READDIR
Thread-Index: AQHZ24BY53U5tewZlUKVZeHRnbTiPrADR/EAgAAPAoCAAWeKAIAAA0oAgAAVF4CAABexgIABNgyA
Date:   Fri, 1 Sep 2023 16:03:21 +0000
Message-ID: <F102ED8C-591F-4B32-8562-13E71B24FAF4@oracle.com>
References: <82d1908e4f835a2f16a509a11b62b9d93ccb6cdf.1693424491.git.bcodding@redhat.com>
 <f793a08ed0db7bbe292c8aa6ec7241178c111cab.camel@kernel.org>
 <4eb846815a1cdd1a98e064305b57a890b46e2708.camel@hammerspace.com>
 <f4837c30b2faedd6a736a19d93c79b93df230349.camel@kernel.org>
 <CALXu0UekEaGhj6+CHEeq22K3sTxTxMJn=5fg9J0PjKmzB+WVrg@mail.gmail.com>
 <a596dba822bba0733434fd234d335d01289bd567.camel@kernel.org>
 <CAM5tNy5DPqEQ5-dYrii4iWcFmHQV8jYDAe6WiYzxL+LmFZpx4A@mail.gmail.com>
 <ea9504a8ae53acd504d03f6f4cad20b22df737d5.camel@kernel.org>
In-Reply-To: <ea9504a8ae53acd504d03f6f4cad20b22df737d5.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7754:EE_
x-ms-office365-filtering-correlation-id: 20e775f3-ffe4-4915-fb54-08dbab04f709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8tXNDVcCcz3vwc3OBDAsr0lN6wVCTghUHGn00cQHo7YkxOwUmLUB169xWKMLYl+SsV+9KnxW3R6psbT7mFXOUhnTkf/jk4W0MeqgpJqCNQRsqVwVO7D2fP/4k1LMDjtKcdXBplZVWtynh60n4VGfnr9gZA22e7RszTYZdA8eAP9/eEZ0JDIgZRYCrt7zYFetLjKw6qWrOeRnqxYWdI3nkFtSyz3iE3qZzDyMMYv4xOvZ41OX8pZXqhAJl6B4yADq869fexKo8MWL2jDQVhbr1HhBcTN0eLw0w+fEKORn/4MaaAXhewZy1HAwe78FvW9GlpSHskX+gXPzLg+HHOvz4kvZsm1OJyxRHwjr3x9s3S/c9Ikqj94DeMav6wQhysd4a/CcaKngdYfUYN5et7MpEu2nkkl2CDi9HVPUxPWbgYkyrhTsrXEtYF2Z37yrSFBlIMoKdtdClE8qzSF6EeIECJUEazrY7XTZr5Db1BA6R1UsHPtbGIlSSHto8sYWdWPqJjKq+lyM0UCmSJB0FJ+KSMGBFkPKQQjLPWb88j/Qs7aK/AOhdtvf+SP+MKWaSM7zwB4lJ0yThAEJJiVBGtSVMUv/J5c2J/2aTQ2KQ+XwbNJ1HxBM11hubqSUJRiNXNMrd1v5TCkvO5Qj2gQEyB8fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199024)(186009)(1800799009)(6506007)(6512007)(53546011)(71200400001)(2616005)(6486002)(91956017)(54906003)(66446008)(8936002)(66556008)(4326008)(33656002)(5660300002)(41300700001)(38070700005)(316002)(66946007)(76116006)(64756008)(2906002)(6916009)(66476007)(36756003)(8676002)(86362001)(38100700002)(83380400001)(122000001)(478600001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkhBNFE4dVBmYS9OQzVVUVFRazdOejdDNFlIRWRaTXZodHpsT2tCRHFlY1Iy?=
 =?utf-8?B?eStIN0ZDazg4RTFQQVVKOVlyQlAyNitWT242QlNaUEdPNEtHWWU2QlVXZkxo?=
 =?utf-8?B?bHQwSU1mWDU2SmQ4cG5XZzErcWh4TU9rRGtyWVhoeE1ZWFZKQzlEZ3NmbSty?=
 =?utf-8?B?ZDVXTDQvbU42N21GbFR2RS9SZjZaK1BJMXF6VzRRUHJEN3l0RzJuOVdaZnNQ?=
 =?utf-8?B?SGZVaUJCTHpvWUtOWDU4YnRHSk5BNXJxdU9SVTJlZHFGNm15VHZDVlFpUlcx?=
 =?utf-8?B?SnROazNrU2xZaGQySGs0Q21PMWFTSm5OWEs4K2dPdGlSYmM1VStxMmJpdGFv?=
 =?utf-8?B?STBqKzEzbkcrdk50S2dyNnZOREtmTjhMbE1QR2tOUzNDdzl1S2xYdVMya3k3?=
 =?utf-8?B?Z3kzLzNxOWU4L3dRYkxZUk9RcHh4RGhJU20xWDIxN0ZMbHVrWFArajdCWmVj?=
 =?utf-8?B?RkIyRWtTK2R4NGtuanVVb1lPODlaMW4zaFpBU2ViL2s3aUJCMVNza1RwV2tT?=
 =?utf-8?B?ZEhjK0dJWFk3YWllaml4NXA5YXVKYURuY2dzQ2RkYXFNOVhQTEs5U2pMRmFw?=
 =?utf-8?B?bExRY1FHcEtHVDZObWRSU1VzRml3Y2Vxb3pKR2ZodHZzc2VOOWlNeXkxcmJ5?=
 =?utf-8?B?NHF4WTE1N0FjVElYY0Y5c04yaXpQZEk4MEFiblBTWnVmajFUaGVpMkl1VEVr?=
 =?utf-8?B?Yi9DcXNSMjR0WjQ4Ym82MStNa2ZqeHAyR3BqQTZuV2R2SndaaVBXM3pkTkVw?=
 =?utf-8?B?V2JTVWI1S2tlZ2lkMFNGNXNiaGpmRVg4b1FIK1dtK0dNSUQwOUd5b2UrQXkx?=
 =?utf-8?B?d2hERldrVXJKdllaU2JKT3IvU3JoNFlYWHB3alNlL2dKeTBIS2tYZjdUUW9D?=
 =?utf-8?B?UHVndDhWVVYreHVLM3I2MU1SYkJYTFBWaEJnT3o2ZXNsOEsrOWsrOUNSeVdS?=
 =?utf-8?B?TzBsZVpBRU1TODBxUDRSY2RwTW1JcURDaXlpUUl5TXNFUG83N0w2REM1YUts?=
 =?utf-8?B?eGZQUHRvNTNRSWJrYVNNL09YR2k2Mm5iNkx2SU9tVWlMclV4angvcm5JUG9O?=
 =?utf-8?B?ZUtJUy9WR0NzWmc5L3lQNXY3MjJVZlI1bk5jTk0wN2ZsZVlsS2pFbUNnR2dr?=
 =?utf-8?B?TmpIYk9RQThYQk8zaVBOSlVQTzk0TEFudndCTkNIb3o0RmRrRm4xMXE2SlAx?=
 =?utf-8?B?ZE96dkFPMHgrUVM2RnZ2b1QwQitBcnFZTGJqbkQ5U2FMeEUvdWZEWDNoRktF?=
 =?utf-8?B?VGpuREtydG1LVVJ5ZS9LNlNsd0VsakJTVGYwTnJlMzA0Y2o0Qk4wcWVTSFBC?=
 =?utf-8?B?eGNMMGtmNFBIMzVqVHZZeFEwN2JiaDJkRUJxN3hLUG1lbm5TenRQVXJjTkU2?=
 =?utf-8?B?SEI5UmNkNm1PZEFpcUpheFNqc2xLRGRhaFVGcGE5VGFXZGVOQ1hOVDVoUy84?=
 =?utf-8?B?WG5vbEc2OGRHR2R1OXlwazdidUVhNFRuMENWaEFxRHpnRjltMUlhR1VDSDRP?=
 =?utf-8?B?MjI3bDlDNzNOMjFSNUNKRlprUzFud0xORjNYL0hrNlJiVlU1NzNFSUtrWDBS?=
 =?utf-8?B?Q3kzdk1jSi9qNjVxM3FJQWNpU1J6Wk1kY1I2c3ZCQlErL3FuNG9mM1VmREor?=
 =?utf-8?B?K081bUNVSVJWYmJLYWFrWTl4OVJTQkZjZGNRelBtbWpWNnNITFRpTy90SGtG?=
 =?utf-8?B?ME93OXNCL0M5Y3ZTbUloQjF4OWtCY2ZaSysvTWdMYi8vTVFvV29ISVpFVlp2?=
 =?utf-8?B?TFFLQXVEelVkK1BWeXNPaEhpNGFzejVFSnZ6Zk1DLzlOVDFRUWgrWStSQVBT?=
 =?utf-8?B?cGprZGhIRHV0Z0ViWnFGN0F5Y0h4bWhTRWc0d0NURDB1ZDMwNjkwekRDZWZm?=
 =?utf-8?B?b1YrblpPeERDTG9rVmpZQjlUTXUySGc5S1lrd0tZNzRDRjFlaVBsQTFTUzUz?=
 =?utf-8?B?ZHFKcnRodlVTTlpiVWtMRmV6RDdxSHVpY1ZIa0xCTmFEbzJFUG1JaUN2c0lV?=
 =?utf-8?B?MWJML21aelZQN3RIVHhadzFoZWxKazk4UkE1S09QTWZ1NnZ0ejdyRmdpMTE3?=
 =?utf-8?B?WCtsQ0d2T0ozNTJGOFQ4dnJaVS9aemNGYXlUbDhGN29FZkZUL2ZQV1lJWVhH?=
 =?utf-8?B?U0JSckNDeHZ1Umh0WkF5NkhRU0c1R0dBb0ZWUDExUUlnNVhQYjJSZ2VtQ3Nm?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5057BF5BB329E546B01D520589C13B7F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w8RJ3ZdrIyYBShy44p4ecSqADEBlpOrQSLTvRbjUIsYGQ3y81GNkcUeTGlcH1t+tKKChAbwUZO9CBqehlgUcm2PXoOJfJZcMPdecLFkHP2JHdVhAY3WgpD2ehLn91l37QoZljcSqKlPmpG6aCH8urij6OSBJmD50prfRD3Vej+vtE1SliT9ZzvmmOe9FHPs9C3MHx5PNrPSROLf85CWRxHB6jk+dbCIY0qw222CoHvcLKlGANDaU4IKOjGm/1gF1srPQLi6wtwBvMIvyuNmQjJEi9l+S739d3KpkGNMRcoJrvD6RYmV/jNtooUAznO2TWpN6s54mcEhaomGrxXleEj8WHT7oOUo5yVoGmeoOr0q7Rz8NoX+5l/c9aGzCC7dHnPwsWHm+tz1uDFYY+60TH2FFsYWbijI1/SG9BFkwxw4BksWvC78N4Z5h9lobjCEVuOX0SMjiMN9oSXTZOqlW7TtF58ULngQ6iUA/j/pY5LsQPIMJ+EFrEHqry8Ac2939XliABcMIf5J/iMJlbmW6oJuPL6x3cxy5EenoVVq8tjDbNyh2AEWQqrh9eeHjGIwi8qoAaepTfdtyYfSJc+TEPLIuBw7zwxZRWwAGC48rD2jPranThODMCMocknmiHYoWirRDoLdbb4LIkmuNyF7HnuHA3MMfyDyj3DhkA5+jLRRy0RWKPbtWzy/y3Fisu40XSUBTuBPARi1VUtlnh73mWzR00qwCIsMEICo39oA67xMujt3xLGkQe6lDHuBn5zRpT2r7WOYIMj+HzRnnGJiuh+7KLFS6Cf/3gRSik7KYSbCyiIQZKXzxDztqAPxHryf3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e775f3-ffe4-4915-fb54-08dbab04f709
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 16:03:21.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+TamQqwoShdpRno8q5mRJEP2BK6OVd5vhR1fm2YxlUJUrs5sr8utiHNniKbYEKhPDtb56xZQWcIFCQX+IJ4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=888 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010150
X-Proofpoint-GUID: zlp2--NimlflIAab3-2nmrmWM8qyxfBN
X-Proofpoint-ORIG-GUID: zlp2--NimlflIAab3-2nmrmWM8qyxfBN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXVnIDMxLCAyMDIzLCBhdCA1OjMzIFBNLCBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyMy0wOC0zMSBhdCAxMzowOCAtMDcw
MCwgUmljayBNYWNrbGVtIHdyb3RlOg0KPj4gT24gVGh1LCBBdWcgMzEsIDIwMjMgYXQgMTE6NTPi
gK9BTSBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBVbml2ZXJz
aXR5IG9mIEd1ZWxwaC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
LiBJZiBpbiBkb3VidCwgZm9yd2FyZCBzdXNwaWNpb3VzIGVtYWlscyB0byBJVGhlbHBAdW9ndWVs
cGguY2EuDQo+Pj4gDQo+Pj4gDQo+Pj4gT24gVGh1LCAyMDIzLTA4LTMxIGF0IDIwOjQxICswMjAw
LCBDZWRyaWMgQmxhbmNoZXIgd3JvdGU6DQo+Pj4+IE9uIFRodSwgMzEgQXVnIDIwMjMgYXQgMDI6
MTcsIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+
PiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQgMjA6MjAgKzAwMDAsIFRyb25kIE15a2xlYnVzdCB3cm90
ZToNCj4+Pj4+PiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQgMTY6MTAgLTA0MDAsIEplZmYgTGF5dG9u
IHdyb3RlOg0KPj4+Pj4+PiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQgMTU6NDIgLTA0MDAsIEJlbmph
bWluIENvZGRpbmd0b24gd3JvdGU6DQo+Pj4+Pj4+PiBBZ2FpbiB3ZSBoYXZlIGNsYWltZWQgcmVn
cmVzc2lvbnMgZm9yIHdhbGtpbmcgYSBkaXJlY3RvcnkgdHJlZSwNCj4+Pj4+Pj4+IHRoaXMgdGlt
ZQ0KPj4+Pj4+Pj4gd2l0aCB0aGUgImZpbmQiIHV0aWxpdHkgd2hpY2ggYWx3YXlzIHRyaWVzIHRv
IG9wdGltaXplIGF3YXkgYXNraW5nDQo+Pj4+Pj4+PiBmb3IgYW55DQo+Pj4+Pj4+PiBhdHRyaWJ1
dGVzIHVudGlsIGl0IGhhcyBhIGNvbXBsZXRlIGxpc3Qgb2YgZW50cmllcy4gIFRoaXMgYmVoYXZp
b3INCj4+Pj4+Pj4+IG1ha2VzDQo+Pj4+Pj4+PiB0aGUgcmVhZGRpciBwbHVzIGhldXJpc3RpYyBk
byB0aGUgd3JvbmcgdGhpbmcsIHdoaWNoIGNhdXNlcyBhIHN0b3JtDQo+Pj4+Pj4+PiBvZg0KPj4+
Pj4+Pj4gR0VUQVRUUnMgdG8gZGV0ZXJtaW5lIGVhY2ggZW50cnkncyB0eXBlIGluIG9yZGVyIHRv
IGNvbnRpbnVlIHRoZQ0KPj4+Pj4+Pj4gd2Fsay4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gRm9yIHY0
IGFkZCB0aGUgdHlwZSBhdHRyaWJ1dGUgdG8gZWFjaCBSRUFERElSIHJlcXVlc3QgdG8gaW5jbHVk
ZSBpdA0KPj4+Pj4+Pj4gbm8NCj4+Pj4+Pj4+IG1hdHRlciB0aGUgaGV1cmlzdGljLiAgVGhpcyBh
bGxvd3MgYSBzaW1wbGUgYGZpbmRgIGNvbW1hbmQgdG8NCj4+Pj4+Pj4+IHByb2NlZWQNCj4+Pj4+
Pj4+IHF1aWNrbHkgdGhyb3VnaCBhIGRpcmVjdG9yeSB0cmVlLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+
IA0KPj4+Pj4+PiBUaGUgaW1wb3J0YW50IGJpdCBoZXJlIGlzIHRoYXQgd2l0aCB2NCwgd2UgY2Fu
IGZpbGwgb3V0IGRfdHlwZSBldmVuDQo+Pj4+Pj4+IHdoZW4NCj4+Pj4+Pj4gInBsdXMiIGlzIGZh
bHNlLCBhdCBsaXR0bGUgY29zdC4gVGhlIGRvd25zaWRlIGlzIHRoYXQgbm9uLXBsdXMNCj4+Pj4+
Pj4gUkVBRERJUg0KPj4+Pj4+PiByZXBsaWVzIHdpbGwgbm93IGJlIGEgYml0IGxhcmdlciBvbiB0
aGUgd2lyZS4gSSB0aGluayBpdCdzIGENCj4+Pj4+Pj4gd29ydGh3aGlsZQ0KPj4+Pj4+PiB0cmFk
ZW9mZiB0aG91Z2guDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhlIHJlYXNvbiB3aHkgd2UgbmV2ZXIgZGlk
IGl0IGJlZm9yZSBpcyB0aGF0IGZvciBtYW55IHNlcnZlcnMsIGl0DQo+Pj4+Pj4gZm9yY2VzIHRo
ZW0gdG8gZ28gdG8gdGhlIGlub2RlIGluIG9yZGVyIHRvIHJldHJpZXZlIHRoZSBpbmZvcm1hdGlv
bi4NCj4+Pj4+PiANCj4+Pj4+PiBJT1c6IFlvdSBtaWdodCBhcyB3ZWxsIGp1c3QgZG8gcmVhZGRp
cnBsdXMuDQo+Pj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IFRoYXQgbWFrZXMgdG90YWwgc2Vuc2UsIGdp
dmVuIGhvdyB0aGlzIGNvZGUgaGFzIGV2b2x2ZWQuDQo+Pj4+PiANCj4+Pj4+IEZXSVcsIHRoZSBM
aW51eCBORlMgc2VydmVyIGFscmVhZHkgY2FsbHMgdmZzX2dldGF0dHIgZm9yIGV2ZXJ5IGRlbnRy
eSBpbg0KPj4+Pj4gYSB2NCBSRUFERElSIHJlcGx5IHJlZ2FyZGxlc3Mgb2Ygd2hhdCB0aGUgY2xp
ZW50IHJlcXVlc3RzLiBJdCBoYXMgdG8gaW4NCj4+Pj4+IG9yZGVyIHRvIGRldGVjdCBqdW5jdGlv
bnMsIHNvIHdlJ3JlIGJyaW5naW5nIGluIHRoZSBpbm9kZSBubyBtYXR0ZXINCj4+Pj4+IHdoYXQu
IEZldGNoaW5nIHRoZSB0eXBlIGlzIHRyaXZpYWwsIHNvIEkgZG9uJ3Qgc2VlIHRoaXMgYXMgY29z
dGluZw0KPj4+Pj4gYW55dGhpbmcgZXh0cmEgdGhlcmUuDQo+Pj4+PiANCj4+Pj4+IE1pbGVhZ2Ug
Y291bGQgdmFyeSBvbiBvdGhlciBzZXJ2ZXJzIHdpdGggbW9yZSBzeW50aGV0aWMgZmlsZXN5c3Rl
bXMsIGJ1dA0KPj4+Pj4gb25lIHdvdWxkIGhvcGUgdGhhdCBtb3N0IG9mIHRoZW0gY2FuIGFsc28g
cmV0dXJuIHRoZSB0eXBlIGNoZWFwbHkuDQo+Pj4+IA0KPj4+PiBEbyB5b3UgaGF2ZSBleGFtcGxl
cyBmb3Igc3VjaCBzeW50aGV0aWMgZmlsZXN5c3RlbXM/DQo+Pj4+IA0KPj4+IA0KPj4+IFN5bnRo
ZXRpYyBpcyBwcm9iYWJseSB0aGUgd3JvbmcgZGlzdGluY3Rpb24gaGVyZSwgYWN0dWFsbHkuDQo+
Pj4gDQo+Pj4gSWYgbG9va2luZyB1cCB0aGUgaW5vZGUgdHlwZSBpbmZvIGlzIGV4cGVuc2l2ZSwg
dGhlbiB5b3UnbGwgZmVlbCBpdCBoZXJlDQo+Pj4gbW9yZSB3aXRoIHRoaXMgY2hhbmdlLiBUaGF0
J3MgdHJ1ZSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhpcyBpcyBhDQo+Pj4gIm5vcm1hbCIgb3Ig
InN5bnRoZXRpYyIgZnMuDQo+PiBJbiBjYXNlIHlvdSBhcmUgaW50ZXJlc3RlZCBpbiBhbiBvdXRz
aWRlcidzIHBlcnNwZWN0aXZlLi4uDQo+PiBJIHJlY2VudGx5IHBhdGNoZWQgdGhlIEZyZWVCU0Qg
c2VydmVyIHNvIHRoYXQgaXQgZGlkIG5vdCBuZWVkIHRvDQo+PiBhY3F1aXJlIGEgdm5vZGUgdG8g
Z2VuZXJhdGUgYSBSZWFkZGlyIHJlcGx5IGlmIG9ubHkgdGhlIGZvbGxvd2luZw0KPj4gYXR0cmli
dXRlcyBhcmUgcmVxdWVzdGVkIGFuZCB0aGUgZW50cnkgaXMgbm90IGEgZGlyZWN0b3J5Lg0KPj4g
KEZyZWVCU0QgaGFzIGEgZF90eXBlIGZpZWxkIGluIGl0cyAic3RydWN0IGRpcmVudCIuKQ0KPj4g
UkRBdHRyX2Vycm9yLCBNb3VudGVkX29uX0ZpbGVJRCwgRmlsZUlELCBUeXBlDQo+PiAtLT4gQWRk
aW5nIGEgcmVxdWlyZW1lbnQgZm9yIFR5cGUgdG8gbm9yZGlycGx1cyB3b3VsZCBub3QNCj4+ICAg
ICBoYXZlIGFueSBuZWdhdGl2ZSBlZmZlY3Qgb24gdGhlIEZyZWVCU0Qgc2VydmVyLg0KPj4gDQo+
PiBUaGlzIHBhdGNoIHJlc3VsdGVkIGluIGFib3V0IGEgNSUgaW1wcm92ZW1lbnQgb24gUmVhZGRp
ciBSUEMNCj4+IHJlc3BvbnNlIHRpbWUgZm9yIFJlYWRkaXJzIG9ubHkgYXNraW5nIGZvciB0aGUg
YWJvdmUgYXR0cmlidXRlcywNCj4+IGZvciBzb21lIHNpbXBsZSBtZWFzdXJlbWVudHMgSSBkaWQg
dXNpbmcgdGhlIEZyZWVCU0QgY2xpZW50Lg0KPiANCj4gDQo+IFZlcnkgbmljZSENCj4gDQo+PiBJ
IHN0aWxsIG5lZWQgdG8gYWNxdWlyZSB0aGUgdm5vZGUgZm9yIGRpcmVjdG9yaWVzLCB0byBjaGVj
ayBmb3INCj4+IHNlcnZlciBmaWxlIHN5c3RlbSBtb3VudCBwb2ludHMuIEkgZG8gbm90IGtub3cg
aWYgd2hhdCB5b3UNCj4+IHJlZmVyIGFzICJqdW5jdGlvbnMiIGFyZSBkaXJlY3Rvcnkgc3BlY2lm
aWM/DQo+PiANCj4gDQo+IFRoZSBuZnNyZWYgY29tbWFuZCBsb29rcyBsaWtlIGl0IG9ubHkgd29y
a3Mgb24gZGlyZWN0b3JpZXMsIGJ1dCBpbiB0aGUNCj4ga2VybmVsIGNvZGUsIEkgZG9uJ3Qgc2Vl
IHdoZXJlIGl0IGVuZm9yY2VzIHRoYXQgaXQgYmUgYSBkaXJlY3RvcnkuIFlvdQ0KPiBjYW4gaGF2
ZSBhIGZpbGUgbW91bnRwb2ludCBpbiBMaW51eCwgYWZ0ZXIgYWxsLi4uDQo+IA0KPiBDaHVjayAo
Y2MnZWQpIHdvdWxkIGtub3cgZm9yIHN1cmUuLi4gOykNCg0KSSBkaWQgdGhlIGp1bmN0aW9uIHdv
cmsgYSBkZWNhZGUgYWdvLCBpdCdzIGFsbCBsZWFrZWQgb3V0IG9mIG15IGhlYWQuDQoNCkp1bmN0
aW9ucyBhcmUgbWFya2VkIHdpdGggYSBzcGVjaWFsIGNvbWJpbmF0aW9uIG9mIG1vZGUgYml0cy4g
SSdtIG5vdA0Kc3VyZSB0aGVyZSdzIGFueSBjb25zdHJhaW50IG9uIHdoYXQgdHlwZSBvZiBmaWxl
IGNhbiBiZSBjaGFuZ2VkIGludG8NCmEganVuY3Rpb24sIGJ1dCB3ZSd2ZSBvbmx5IHRlc3RlZCB3
aXRoIGRpcmVjdG9yaWVzLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
