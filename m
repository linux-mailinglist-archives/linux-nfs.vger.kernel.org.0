Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1469392E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Feb 2023 18:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBLRri (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Feb 2023 12:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBLRrh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Feb 2023 12:47:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCBB750
        for <linux-nfs@vger.kernel.org>; Sun, 12 Feb 2023 09:47:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31C53Oft001514;
        Sun, 12 Feb 2023 17:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=T3yWGZnmglWJS9lHG6MvHmKJQXZcR4K7kfleRyx+jMw=;
 b=I/YPUPscKKQlyT7+10eK5YULU/qXDuQA4wG/hJqeqWjwlAVum9w+6fUwazw6ATC1FIsQ
 lMLM23gFPWmd0BwSn4fYKrMxioHIlqSDqMPp6l5qyIdycaYzKEl5Q7GQ1Quf5Q5Wvcpy
 ExEysgWhojOsj0XV1nB+JPDnvNOY6hdKrbzTDmzTepUqdj85Qy9gA8xplyvVmxBUDqly
 N/+5+7ARxAZvpW+FJY0jp6Yskbt/ErkH9OVmgrOVgUG1uTvYv3nG5ae2idEBG+PHIOQA
 fLUWgaoE5OQBwmisYngA3cY+HeeF+XCEoFl/GtVn+OV0Q4hOwZ46Gnt8posl3gMsB/mk zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m0shxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Feb 2023 17:47:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CFPSHx011564;
        Sun, 12 Feb 2023 17:47:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f39jc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Feb 2023 17:47:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4aj6FGLkneF4mchPjKWdIGJUXhazzQIDvOtbrqC+qS+OF5tYcCSTcMaT5k3PabwanV0aZV6OxcHkUE787oh+xOXxX+EjwpXVc/+1TEmm0EN9HXRnwmmMiN3WvywLfKVbVk9vlHB1PBc0pMtTl9kgSAJvLKuHLWHe+YSRFA4dYZJXSlP2WaEwQnIuErWIMKsA5GzyUgxQrQ8Iaeu2IHS7/xZqWK/iWwbZ1o1bg/427J0Z6d+E7ZaWdmzHCWIw8xAXwQQTw3KdgdcZsVsvnJnTJJL/3weE2tJMTduNyNUeSwlf3cCrGr0r/ckLjGc1GloAtTPPKYf1yUQCvkShhrtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3yWGZnmglWJS9lHG6MvHmKJQXZcR4K7kfleRyx+jMw=;
 b=cwLL/43fjCO2zbajf0jaDEPOVCitEgwYN3xH3P9JFrhq3IKEBLUGU9FohUDw2CWWFYLYY0CBDGlc2/f85uk1EBzNEwJKCbsWHH05dLRNkydRJ9Yjvnkj7f1/UZb1QzuikHx3ijrxcOrnSfkaLbMwbXoVkg8H8XMG9kXZ4wG0mRlDncGx13Hrsr0ZkhPeVyrRpREedGPv1uhOr60cP0+FJdd72c9Rjxwz2z0knN4Y1K9LT65B57C+HHqAi05j6ojqkwD4zanbiv+vhlwNY2sCeej0Pt0sNWJkQ0iDaR3oDbn+ZbkWbqFYb/iJY7gkvlmzJ0jdo1gmhbLhTsO1IvWe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3yWGZnmglWJS9lHG6MvHmKJQXZcR4K7kfleRyx+jMw=;
 b=u6KUlA0PyTKTE91d4oHdWEJ3RQieys+aRR3U86t58kMwGKIHGpq49wJP98izU7GBINrOGOE4eS6zlzyK/Fuaep1S8SroduujDGgfs8rF9zZQAhW0jQH2AQzLFhhYRz72cEQd16GQtnflbCQNcKTUfXt4tyDjpjE481AVF90hzNI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4239.namprd10.prod.outlook.com (2603:10b6:208:1d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9; Sun, 12 Feb
 2023 17:47:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6111.009; Sun, 12 Feb 2023
 17:47:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: question about the performance impact of sec=krb5
Thread-Topic: question about the performance impact of sec=krb5
Thread-Index: AQHZPqeMez/BkWTmQkuEvdu9Nhcyhq7LltYA
Date:   Sun, 12 Feb 2023 17:47:29 +0000
Message-ID: <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
References: <20230212140148.4F0D.409509F4@e16-tech.com>
In-Reply-To: <20230212140148.4F0D.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4239:EE_
x-ms-office365-filtering-correlation-id: 1cb9ad3e-7aef-4d16-5bb1-08db0d2135f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0r8iqdVy+PjLsSSsph+9H0wgmVECx3DjRoWUoDqxpsB1jnH+hY3AoLwy+i6arRPErrXAuwvzY44eZB+tub+NMvvIwcybLFLDHnbgHfY4IR7yufZEcgA5ufyhQP3g/oKe9twViSbHa38Sq3HHNZUXwcCcnCnqJkJ9PXGSxZb5z3QZVsjF4L9MuGQE8ujs2cf9yqOWUiqLPwhunNcAH9h9cHJ2eI1Jt/WD/huqqR5qIqeUH927d9Pe44S6WrE7bDsY0mDuzq9f8eTZHqU9j4GFwh1hp/e+7hJYXUIoy4/R3uz2yr4eIkHhstpX3huUWlv2UqtEj2JZzs/kT41nHQ017rMox0S7s2tZWZU4ztr5AOCOJ9TFwU4ffJZhuOyg9bUSUsh4s7h4EtPpVTf6WcE+SeisWjsqKxCtLw7vv4DYzE9yl8z3nNMFDsmHFG6EKJ8lT9V01AIxrGZGUSO8g+Brnb4PDNL4IC/h1EPGXrR7gIbONZQRK8bWoihE+NO4s3y70GkdCxgAgj46gyHqACdHsNhtVKmbjuCzO7ERSYpi6/ilXJrmz00ehayL6blS9/tydSBua2E+iY9YGtm1xsSVwSYZ2Y7yhqMGfYrkdYGnLTArQ+XfhB4QgK9UuLpwfWqkXTb3W7XiIY7dS2gHzgjZr8Hx/Kw/p2RoHi+gZ+5GtBiF7I3D5pWUGslIfRHo+O2Ezy0918zR5hLCUZyMNJLrWfQDSfaVmo++Uw5kLQU9cGtf2qSdw3pklT3IwAOmWuHRf95nOhfcjV4qk9zRFp+qOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199018)(38070700005)(316002)(36756003)(2616005)(66446008)(66899018)(41300700001)(64756008)(5660300002)(66476007)(66556008)(91956017)(66946007)(2906002)(54906003)(8936002)(8676002)(76116006)(4326008)(6916009)(966005)(6486002)(38100700002)(186003)(26005)(86362001)(6512007)(6506007)(53546011)(71200400001)(478600001)(122000001)(33656002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXdYd0RWaWdLMXUyd25NaXJqS05xelJuVEZZeW5hY29vbitvaEkzSGZXei9v?=
 =?utf-8?B?UlYxaG5kR3hGQ29yVWN0VnNnR0g3RXhacTRickptckhvU3NPOVlrc2RuNFBa?=
 =?utf-8?B?UzFkTDRVeTdWR2hTd2x0ZjhuQmFxWWl0SlNuUHdLZHZKUStUVHMrUDIxck1l?=
 =?utf-8?B?Tm54RHA4eGdIVkFBRjlQRG16czMzZHdkQ1F2Tm9nSGQrWHFwaEtWdVB2dHVj?=
 =?utf-8?B?U1lpMTh4UVN3K0Nzb0syU0RqeW9NV01tR1BLS3NjbXdWUlNrMmc1VTlLWWto?=
 =?utf-8?B?WjB5cVAvZDZaKzlTRE5WTk5DaDcyOGs0aDhHbis5a3JERk4wTnNhVGpRVDBM?=
 =?utf-8?B?aWhVUjFnK1lGc1RmZ2pDYVd3TGpTNUM1M0ZyRDkxTWJkQkI4dnNjRENjUFJ5?=
 =?utf-8?B?RmU1Q280NGVld2I2Sm5GNlhxQk1ZTDBkQTUraTk4bzNNUEV5OTRGRjlkdXo4?=
 =?utf-8?B?OVRFWkhrQ2trK3kvcTlQTVl2OVVPeko5anh6RUNSZkNHSkN1ZE1LUHkxYmRx?=
 =?utf-8?B?SGtQWGs3bVNFZ2N3azBSaXloSWNwYytFVWFLRUN3a3c5dkRzTXQyYlNNVC9o?=
 =?utf-8?B?YWNEYUdNWDA3cWZsOTdOY2pMN1RGdXpiVUdtZG5id0dQQjIrTG5CTnYwRFU5?=
 =?utf-8?B?ZHhxMUNWNnZFUUFWTnAvYnUrNmQ5amFEN2Z3a3gya2dYRFd5cnVCTi92OEVy?=
 =?utf-8?B?QWxwVDdxbEVndHJjM0ZXRlFVaVE2alY5ckhoQklVL3N1MTdVbjdydE1Kbk5E?=
 =?utf-8?B?U1MxOUI5NjBmeFZjZlJ5aFpjdFdJV2ZxaXpmdUlFRWIrdWxNY09jbzY0YzRm?=
 =?utf-8?B?Vkd0WTBrdjZ6VDhGMVdhNjJWSlRYYlNZTWo1SzZ6MUVUSUtxV0ViUmRTbmZw?=
 =?utf-8?B?SHJ3ejRHV3ZZWXZJRVlPTTROVENsQmYxaUZNUlZNQTJvV3hUcDRNRWExcVF2?=
 =?utf-8?B?NGx0MW5aaDBLUlYraHBmWkxMMXM5bXBpMmJDQ3ZUdlBQL293Wkxna3Z2YmV3?=
 =?utf-8?B?QlVwWHZHejVPdHNtMHZtUlZXYVlaTG9LdUZYUXRoSngrL0V1WHVubzFiL1Zv?=
 =?utf-8?B?bTlVenlIVXFHVGtBVlJQQnNNOHBXL3M4R3ZmSUhJR1VMYWdxTm1MOFQ1RmJJ?=
 =?utf-8?B?dFlSZW44bUk0dDZqT1MxQlZ4U1RncUdPYWdNZWwyejhtcGJFc0R5T05CVlJo?=
 =?utf-8?B?SkpYQXdxSU5mWVBaekNEdHUraTFCVUVwcE9LY25kTVRnRWVxOWQyMHZrT0Nh?=
 =?utf-8?B?aXdLdHpwN3hvVjYyRnRYajhzN1hDS2RhRWNheU91QjVkMk41RG9hU1BTVFV6?=
 =?utf-8?B?VTJFcmtYQXgxWjdqdFJmR0ZjVUJLaWNSVVRHRC9hTEJIdjlRZmd4Q2lwU2tR?=
 =?utf-8?B?U2tCTkVFU3BKTnN5ZndNaUpQVmNjTFZYV3o5SHF1WDErd1dOaDJOaWxWVWo5?=
 =?utf-8?B?S2lGand0aTM3Sk9lUTFIWmEyZUlYeHNMU0hGb0VHNUZiMVlFSUtVMzdMQWFX?=
 =?utf-8?B?dHRVOUF1M0tqMW9wRUkzejZmRWZmd3hEaUN3RldPOGNhYlVGd1RNcVhjeElv?=
 =?utf-8?B?YjA5ZWtnZUdZQngwem9jeEZCSWcwcjhnZG03OHZORXJLditPaEhSZjAwS3I0?=
 =?utf-8?B?NDJsVnoyeTZxSWtmWEJ6NGIxVWorM3JEcEhubCthQTdiMFdaWjUxbDVYQ1hV?=
 =?utf-8?B?YklZMlR1L3ZpYTVYUDBlMzZDc2IwQk1yRGFNNnA1YXQxK1lJT3RnVDBjbXBx?=
 =?utf-8?B?Sk4rVDRCZjMrVGczOWhtQ29jRVFINmkxU0pTUkNlWFFJbFVFV2tXQ0I2REdz?=
 =?utf-8?B?ZnV2a0JXRnhpdC8rbkN4anB2QWUrRW50Q3ZyVmwrL1NSUkx5OXBnNEdtYTlq?=
 =?utf-8?B?RkZyaGVwVXFBMXBvUVJBeWovQk16dDBuTWx6T3pkVW91SjZHOGRsUm5FQzUr?=
 =?utf-8?B?OTgxTDNZUysxUzlWaUc2cittaVFwY1pYOHJpS2Q4MlQvdWN6WEErQnl4ZVNp?=
 =?utf-8?B?TmxacWN1cTFLSWVIQS8vanVLTi9DRGJ3WFdIUTh4QzIzMjFnYldua3lLd2ph?=
 =?utf-8?B?T2JJVllZVHJGaVN3dFNjOVlwZzBNQXlNOVJLcG5uV3JMdCtGK0dBUEh2c0Mx?=
 =?utf-8?B?ZUlJYmNUOGNCM3NYbmdDZ3FxaVNZVWswTGIrb3BZdllZdHdnTHpTS0dNV1dx?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E5567846DEB944EA77D25857E08FF5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m/UmkLZRszDPXNZ4WshPGtrqNqrEB1rNSau5RUtlmUMxNrT+RJhs0r9S4FGQusAdaXjvd6PxyCyD5FumHtEt73hjWsOnrEKZfhHga3Mf1BK/HaD+pWOrPiZEebgiq+pV2XUNDy0xejYkEVNJ/LUM5XSPbWDycsLJDoKTaXbhcQLdRJbyMhhLgRL92TZuhXPhQS00BsrW9Mr6MKM9SgJ5Z9dTW8l4dx3Dr3kfYGaYeXlK4gLvxH1J12V1IFBDuyWidOKmfbvgbgLl+OW1zd5uW2oku+uqjzCwY3NPzfPH9Uj4aNq6RNnhjUZEbX1fM7KbPj7p4EJOwaPdFf3JCMlXl5v2QKHqmZuuKSB1zUOJWqYOMkRy/qXUT2zzqiE6aUC0kkyILjRVMnqbsFuVV2dMC8yk50Q718QwYoJ6BPJgsJyrxAaGaLFclj2+imyi38jEKEeRR5pCD1BkSMrd16LpQJWCgy9CItkJxC5/rKvCnY09pvKIPIfEYG09Uo5ZYG5bAId+Lyz9McaM4nMUKmHCksRigwOfC+pikT6TYrxnDS5Y+6OGTOJAAlCdcZYrmVc6+aJDoQVJ2aKCBfXxJ8IFDQkH1JmvutIFMWXvcS0xH+Lj0FVhfaEHyEqAs+tWH/b6tPMczODovQfkqEMpAAqH8hkpQ9Md3KidZaw3NNQ1Hlae74qJQIcezTJFmHNqw+kRMNYL59SyviDmhuOmkoO4ubhbdt0QQdthfk2Z3aryArdZnruWiwl0zlsaFZj1NT69j8wsQ+YMPin4qaJidJKH3ykGrQaoyvr3ru+rA310XRS+6sr+7qyMEk/wT6w/av0tv+fStlorOxgRRHMqQQmk2g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb9ad3e-7aef-4d16-5bb1-08db0d2135f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 17:47:29.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVgG2bOGyeUAu4o3c+NBpr1rX5Z0EDDXbCs8ZxpA/4NuU/73hY8fy9ntLiaqC2zaHtaf74kMdnpTJmH5JEC5Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_07,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302120161
X-Proofpoint-GUID: QScCdUIgLQMphqGlByQEnKmA4iHcoaX_
X-Proofpoint-ORIG-GUID: QScCdUIgLQMphqGlByQEnKmA4iHcoaX_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRmViIDEyLCAyMDIzLCBhdCAxOjAxIEFNLCBXYW5nIFl1Z3VpIDx3YW5neXVndWlA
ZTE2LXRlY2guY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gcXVlc3Rpb24gYWJvdXQgdGhl
IHBlcmZvcm1hbmNlIG9mIHNlYz1rcmI1Lg0KPiANCj4gaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQu
Y29tL2VuLXVzL2F6dXJlL2F6dXJlLW5ldGFwcC1maWxlcy9wZXJmb3JtYW5jZS1pbXBhY3Qta2Vy
YmVyb3MNCj4gUGVyZm9ybWFuY2UgaW1wYWN0IG9mIGtyYjU6DQo+IAlBdmVyYWdlIElPUFMgZGVj
cmVhc2VkIGJ5IDUzJQ0KPiAJQXZlcmFnZSB0aHJvdWdocHV0IGRlY3JlYXNlZCBieSA1MyUNCj4g
CUF2ZXJhZ2UgbGF0ZW5jeSBpbmNyZWFzZWQgYnkgMy4yIG1zDQoNCkxvb2tpbmcgYXQgdGhlIG51
bWJlcnMgaW4gdGhpcyBhcnRpY2xlLi4uIHRoZXkgZG9uJ3QNCnNlZW0gcXVpdGUgcmlnaHQuIEhl
cmUgYXJlIHRoZSBvdGhlcnM6DQoNCj4gUGVyZm9ybWFuY2UgaW1wYWN0IG9mIGtyYjVpOg0KPiAJ
4oCiIEF2ZXJhZ2UgSU9QUyBkZWNyZWFzZWQgYnkgNTUlDQo+IAnigKIgQXZlcmFnZSB0aHJvdWdo
cHV0IGRlY3JlYXNlZCBieSA1NSUNCj4gCeKAoiBBdmVyYWdlIGxhdGVuY3kgaW5jcmVhc2VkIGJ5
IDAuNiBtcw0KPiBQZXJmb3JtYW5jZSBpbXBhY3Qgb2Yga3JiNXA6DQo+IAnigKIgQXZlcmFnZSBJ
T1BTIGRlY3JlYXNlZCBieSA3NyUNCj4gCeKAoiBBdmVyYWdlIHRocm91Z2hwdXQgZGVjcmVhc2Vk
IGJ5IDc3JQ0KPiAJ4oCiIEF2ZXJhZ2UgbGF0ZW5jeSBpbmNyZWFzZWQgYnkgMS42IG1zDQoNCkkg
d291bGQgZXhwZWN0IGtyYjVwIHRvIGJlIHRoZSB3b3JzdCBpbiB0ZXJtcyBvZg0KbGF0ZW5jeS4g
QW5kIEkgd291bGQgbGlrZSB0byBzZWUgcm91bmQtdHJpcCBudW1iZXJzDQpyZXBvcnRlZDogd2hh
dCBwYXJ0IG9mIHRoZSBpbmNyZWFzZSBpbiBsYXRlbmN5IGlzDQpkdWUgdG8gc2VydmVyIHZlcnN1
cyBjbGllbnQgcHJvY2Vzc2luZz8NCg0KVGhpcyBpcyBhbHNvIHJlbWFya2FibGU6DQoNCj4gV2hl
biBuY29ubmVjdCBpcyB1c2VkIGluIExpbnV4LCB0aGUgR1NTIHNlY3VyaXR5IGNvbnRleHQgaXMg
c2hhcmVkIGJldHdlZW4gYWxsIHRoZSBuY29ubmVjdCBjb25uZWN0aW9ucyB0byBhIHBhcnRpY3Vs
YXIgc2VydmVyLiBUQ1AgaXMgYSByZWxpYWJsZSB0cmFuc3BvcnQgdGhhdCBzdXBwb3J0cyBvdXQt
b2Ytb3JkZXIgcGFja2V0IGRlbGl2ZXJ5IHRvIGRlYWwgd2l0aCBvdXQtb2Ytb3JkZXIgcGFja2V0
cyBpbiBhIEdTUyBzdHJlYW0sIHVzaW5nIGEgc2xpZGluZyB3aW5kb3cgb2Ygc2VxdWVuY2UgbnVt
YmVycy7igK9XaGVuIHBhY2tldHMgbm90IGluIHRoZSBzZXF1ZW5jZSB3aW5kb3cgYXJlIHJlY2Vp
dmVkLCB0aGUgc2VjdXJpdHkgY29udGV4dCBpcyBkaXNjYXJkZWQsIGFuZOKAr2EgbmV3IHNlY3Vy
aXR5IGNvbnRleHQgaXMgbmVnb3RpYXRlZC4gQWxsIG1lc3NhZ2VzIHNlbnQgd2l0aCBpbiB0aGUg
bm93LWRpc2NhcmRlZCBjb250ZXh0IGFyZSBubyBsb25nZXIgdmFsaWQsIHRodXMgcmVxdWlyaW5n
IHRoZSBtZXNzYWdlcyB0byBiZSBzZW50IGFnYWluLiBMYXJnZXIgbnVtYmVyIG9mIHBhY2tldHMg
aW4gYW4gbmNvbm5lY3Qgc2V0dXAgY2F1c2UgZnJlcXVlbnQgb3V0LW9mLXdpbmRvdyBwYWNrZXRz
LCB0cmlnZ2VyaW5nIHRoZSBkZXNjcmliZWQgYmVoYXZpb3IuIE5vIHNwZWNpZmljIGRlZ3JhZGF0
aW9uIHBlcmNlbnRhZ2VzIGNhbiBiZSBzdGF0ZWQgd2l0aCB0aGlzIGJlaGF2aW9yLg0KDQoNClNv
LCBkb2VzIHRoaXMgbWVhbiB0aGF0IG5jb25uZWN0IG1ha2VzIHRoZSBHU1Mgc2VxdWVuY2UNCndp
bmRvdyBwcm9ibGVtIHdvcnNlLCBvciB0aGF0IHdoZW4gYSB3aW5kb3cgdW5kZXJydW4NCm9jY3Vy
cyBpdCBoYXMgYnJvYWRlciBpbXBhY3QgYmVjYXVzZSBtdWx0aXBsZSBjb25uZWN0aW9ucw0KYXJl
IGFmZmVjdGVkPw0KDQpTZWVtcyBsaWtlIG1heWJlIG5jb25uZWN0IHNob3VsZCBzZXQgdXAgYSB1
bmlxdWUgR1NTDQpjb250ZXh0IGZvciBlYWNoIHhwcnQuIEl0IHdvdWxkIGJlIGhlbHBmdWwgdG8g
ZmlsZSBhIGJ1Zy4NCg0KDQo+IGFuZCB0aGVuIGluICdtYW4gNSBuZnMnDQo+IHNlYz1rcmI1ICBw
cm92aWRlcyBjcnlwdG9ncmFwaGljIHByb29mIG9mIGEgdXNlcidzIGlkZW50aXR5IGluIGVhY2gg
UlBDIHJlcXVlc3QuDQoNCktlcmJlcm9zIGhhcyBwZXJmb3JtYW5jZSBpbXBhY3RzIGR1ZSB0byB0
aGUgY3J5cHRvLQ0KZ3JhcGhpYyBvcGVyYXRpb25zIHRoYXQgYXJlIHBlcmZvcm1lZCBvbiBldmVu
IHNtYWxsDQpmaXhlZC1zaXplZCBzZWN0aW9ucyBvZiBlYWNoIFJQQyBtZXNzYWdlLCB3aGVuIHVz
aW5nDQpzZWM9a3JiNSAobm8gJ2knIG9yICdwJykuDQoNCg0KPiBJcyB0aGVyZSBhIG9wdGlvbiBv
ZiBiZXR0ZXIgcGVyZm9ybWFuY2UgdG8gY2hlY2sga3JiNSBvbmx5IHdoZW4gbW91bnQubmZzNCwN
Cj4gbm90IHdoZW4gZmlsZSBhY2Vzcz8NCg0KSWYgeW91IG1vdW50IHdpdGggTkZTdjQgYW5kIHNl
Yz1zeXMgZnJvbSBhIExpbnV4IE5GUw0KY2xpZW50IHRoYXQgaGFzIGEga2V5dGFiLCB0aGUgY2xp
ZW50IHdpbGwgYXR0ZW1wdCB0bw0KdXNlIGtyYjVpIGZvciBsZWFzZSBtYW5hZ2VtZW50IG9wZXJh
dGlvbnMgKHN1Y2ggYXMNCkVYQ0hBTkdFX0lEKSBidXQgaXQgd2lsbCBjb250aW51ZSB0byB1c2Ug
c2VjPXN5cyBmb3INCnVzZXIgYXV0aGVudGljYXRpb24uIFRoYXQncyBub3QgdGVycmlibHkgc2Vj
dXJlLg0KDQpBIGJldHRlciBhbnN3ZXIgd291bGQgYmUgdG8gbWFrZSBLZXJiZXJvcyBmYXN0ZXIu
DQpJJ3ZlIGRvbmUgc29tZSByZWNlbnQgd29yayBvbiBpbXByb3ZpbmcgdGhlIG92ZXJoZWFkDQpv
ZiB1c2luZyBtZXNzYWdlIGRpZ2VzdCBhbGdvcml0aG1zIHdpdGggR1NTLUFQSSwgYnV0DQpoYXZl
bid0IGRvbmUgYW55IHNwZWNpZmljIG1lYXN1cmVtZW50LiBJJ20gc3VyZQ0KdGhlcmUncyBtb3Jl
IHJvb20gZm9yIG9wdGltaXphdGlvbi4NCg0KRXZlbiBiZXR0ZXIgd291bGQgYmUgdG8gdXNlIGEg
dHJhbnNwb3J0IGxheWVyIHNlY3VyaXR5DQpzZXJ2aWNlLiBBbWF6b24gaGFzIEVGUyBhbmQgT3Jh
Y2xlIENsb3VkIGhhcyBzb21ldGhpbmcNCnNpbWlsYXIsIGJ1dCB3ZSdyZSB3b3JraW5nIG9uIGEg
c3RhbmRhcmQgYXBwcm9hY2ggdGhhdA0KdXNlcyBUTFN2MS4zLg0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg0K
