Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8996CC619
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjC1PW5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjC1PWj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 11:22:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B6FF2D;
        Tue, 28 Mar 2023 08:21:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SFF66K031661;
        Tue, 28 Mar 2023 15:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0hDMyw6DMO4+2z/GljFptutzAZ4fWWf18afYQ/K/g+k=;
 b=JJM4Lioq+Z7sFJyIlyD/DiTXA+3BYKdD4Nn85+863un5yOAiHy3uGCI3UW4mX8csHJ5U
 iyAS71FtQWvc+rstMuZWkSXIELTYe5RguQkyt+8o6pqHexdzX1ssh3T3V8xve+Vi3+NK
 hNpJPhsImWAye8W6jSuI68lBf7KRTpnyPbTtxZTivd2r4NTA01RJvZPPjHpPsjIs94Ra
 H+0Y0PU/zg3UmYgaaq1TyTUMhmzFfbhWKyjmQAsIif8CWWUyA0kSPadO31C0bdX9Tndg
 30SEcbbS76kVau2ZTG6Y4LQHiIpYjeCUczMhK49twIVzrRQwdYJcWfn05D9WKmvDWKSF Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm2q100t2-36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 15:20:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SErkjP009204;
        Tue, 28 Mar 2023 15:09:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdd2050-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 15:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa9Tm53ZtO7DW1ySeH8udkg27k4Ir7sdCdFkwlh8qfFIVO3UgiZnBd/v0x+9bfkfmG9IGDkb7v5qATZCjZ6d2LJ8AiTZgfI3jdeo5BIvisE8HgNHTcMsV3krDg7EIskAvWzjk8P2gFloU0W1pQ6gUQtOZXn19ZVe5OjrwYIckGwb5lyChJQyM+dCAo0du4A8MAae+DaxMvQZY0yTtpkHK735lSgfwuemPBvDLpn7FlQk2aK3m0+Fcq9Y0ih4OpFjDmdkVe+La385OnwYWh0EH4UBOMpYFj7T2tEYpsTCwdqYWJqir+aveduqkY4t7vxM8KAnLi3TTIQmPfuS1RNFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hDMyw6DMO4+2z/GljFptutzAZ4fWWf18afYQ/K/g+k=;
 b=acAfDrvNKA898yM9aeapKk3Ii1oNq7wjE7BpusuZv68uJhEx2PBHsHUlStFflFlB4WFSMdgtXTq9T+qmjKUW25frg7OPb6TdOQTYdwhHCjLAeJeXh42RPNkHscZc2QZbRojneI8W/3OpawHiFZ1f/3PfmneSu8F6T/73qIRvOTLMoqRmyqmSs78X7NFwzYVXzk7rCl0G5c9wkgEwzt6iEz0S3kK6Tv1QqAnmeBa5iU7gj+8aFvnsH6iEk5+STAOiesOhPDYgkQMmkfmy6TIZtFVo4R5e/MJ7m9G1dH8Zfh7eKhTCp9rWq8nO9HihYjia0Pi4zhz7RG5Y5GqZEca+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hDMyw6DMO4+2z/GljFptutzAZ4fWWf18afYQ/K/g+k=;
 b=Vkl9n3gWM/v7oIV4F2S+YqvOlYJ0TFvaXfa8pA7sjNwhtkU/yAk3BPBya0If7Cy+H8QA9QA8XluPGOWsKXUy3p6Orq2JvClKvz2rGncTb2uklMRTEjbZAmaFXt0g+f6VL5thBI9uOuAfraEV24GwbF1lZ7cy4MbRKBAhVjtDoek=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:09:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 15:09:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] NFSv4: Fix NFS_V4 select RPCSEC_GSS_KRB5
Thread-Topic: [PATCH] NFSv4: Fix NFS_V4 select RPCSEC_GSS_KRB5
Thread-Index: AQHZYUaWBGM1a5WuKk+I2VS9GPp9K68QMzwAgAAWxICAAAIZgA==
Date:   Tue, 28 Mar 2023 15:09:43 +0000
Message-ID: <2ED142CE-6E37-42B8-AB2D-602772AAEE2D@oracle.com>
References: <42751e1fef65485a5441618bc39735f8b62b3a46.1679988298.git.geert+renesas@glider.be>
 <2968C736-0150-4AFC-94BE-F9F8C2859F3E@oracle.com>
 <FF31002F-003E-4C43-8FC7-E2250788F516@hammerspace.com>
In-Reply-To: <FF31002F-003E-4C43-8FC7-E2250788F516@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5005:EE_
x-ms-office365-filtering-correlation-id: c07e2c1c-afc0-48e9-f3ea-08db2f9e7638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RO7zcF6dEqD/KSOa2aI684AhpvWBxfiBeZ8PBkg05NjLjwfUIgKDnoeOqbETQM3TlrJPg4nCgF/0Gdp8qdIZSAOwK/FKluqM7DuWZVlULGZalkWTihUGGQiqtD2XtiJRjJsc/HUiAWb8+7KrsfsYIrMGlXqUgNReKa6XhHrggSC6m9pkRforNbFxW/DvvrDgYvAWlNoqgMFofc1k3O1o7gGB0G0RXcn1UHDf6LnGVqTfVJyWlyX7MkiLYdxjfj69FnuiYb4oMAoY8uVj+p46BKlmuSaqeRo/I9Wfz4E2SjUWzIN1xEk/dxSwLxzsAyuz+A9B5dqS3qy6IAl3LJ8hqiH+bh59/PN9pACB3QPRqum1Cp9fqlYuZDA5l6RLyU1YucwA7BJPRyI83d1ZF6BeMnDZhGErK7Js4l5b0J/9Tzpi6OvzpaCvrAIONiqzN6mEPevJXjs6hdKBYBABbCmyunKkNbcPDe1G9IHxyu9xJs7deqbOGtUvR8Lf8ONG5qv7tOgZaax6vY26PiVdNcxD7Z5KZthhNExLmQ35BqGHAKU3jykmN78+tR5E6tArCJ6iZHc2YceqbTCGYzbiROF1UjMLIkFweS2wKD88BZATUo9LONQLbzn5/pxL/wHMfVTIPHo11KNLSfRvTsgR1Sn2Fso+0vVPhkZJZRy4NbQ73Ck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(66899021)(2906002)(66574015)(83380400001)(8936002)(5660300002)(26005)(6506007)(6512007)(91956017)(6486002)(316002)(36756003)(966005)(71200400001)(478600001)(54906003)(38070700005)(122000001)(33656002)(53546011)(186003)(2616005)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(4326008)(38100700002)(8676002)(41300700001)(6916009)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWIvdVRra1NJbEpQbHA3cFdhSVVVbEVCRFFmRG80UXQydUVHanE1VVNTd01x?=
 =?utf-8?B?NnNBRndTa2JlREhBdVRMZkJra3QycWdjL1ZOTURXcWcvbzIrNUhydGlySmtB?=
 =?utf-8?B?dHZOZkxKQk9YR2NqY3FrRTdjaEE0aTdPUEhORU1sVVdodk1nblAyNG4wZnVE?=
 =?utf-8?B?bHVlVERlaHA4MGtQaGlWdTVIVmtQckRNU3h5cW1NVVc4QUtzYTcvQ1dFN0V5?=
 =?utf-8?B?Vi9WbFUrbUkzUkszR2VEc2NCcXhjdVUzcHFuUmJjNVNyenpUVUYyTmZVM29J?=
 =?utf-8?B?Z05zZ25LOGxxZXE1TDRrZGdZVWZKUTc3MUExT2wwaWZYWmN0SXkwUmo1R0hi?=
 =?utf-8?B?RURMcmJkNndMZ0RhdytRelNGV3RRSjNQOHd3dFpOMlVPZCtEVE8wYk8zWmVG?=
 =?utf-8?B?aFdjNTZUY2ZhVEsvQUxsVTZ5R21kbC9hamljb1YwM01PbTl0WTZXc2czQUJj?=
 =?utf-8?B?ZkhzVXBqVTJGbFlQeW5IcjFJbFQ4cHdOakVEcVNjZ2ZUcDBYVTgxdGVZNkFJ?=
 =?utf-8?B?VkZFVHZMOVM2by9UeW9RdlQ5RFhDY2h6dlNpamw0aHZ6bzJyV2VGdTJRNVNj?=
 =?utf-8?B?TU9jeHJ5ZVlqYlpodzlXS2F2WDhZQnlpdXVueU9kVVV0eElidnppNklFcklY?=
 =?utf-8?B?eENkYjZOc2l6MmJpS2Fmc1FINzA5Vi9nb3BYUEoxMldiYVZ6ZVhCZHNIUHZk?=
 =?utf-8?B?Q3VuQm43dkx1bStYSUFWbVFsaGxuTFVOSDdkcUlzVEgyZG9NazJCNTNBVWc3?=
 =?utf-8?B?ZVNxK2lZbmo3VnkwV1pGcExPS3VRUWRnUE5mQWxwQ24yYVYyS1Z4cXB5NVpY?=
 =?utf-8?B?bVB4ZGw2aXg5dldwNjlJNzV3YkVSVjBRUE9YNDJBTTY4bTNsYkhrRFdiVmVC?=
 =?utf-8?B?blIzUkRvVWNjOHkxS0J6RnQveS9jN3FBRTZ2UlZEdEk3WW9qWEdKaUNlbEZG?=
 =?utf-8?B?VGx2Y2V0NFVNVVJJeUE0ZjZEQXVzY09FUWt0V2oyUTh2TXYwSDVXck5URlpF?=
 =?utf-8?B?WGgycDlIS1FZZEVJUzRCbUpHajhvMGtKVnJxYTd4ZkxjamUyR3VxS2xWSFZi?=
 =?utf-8?B?cGFXRHl5ZGFtQllJa3J0ZlJuYjdDNTVHaEpxR252WUV6NWQwMGZlUy9jeHV6?=
 =?utf-8?B?b001Nk1meVF1ZXN4UGNTeWx2L1VXNVFCdE01a3NJc05hT3lwRGkvZUR2cXRl?=
 =?utf-8?B?bkREWEFLYnJub1JReXlPTXh5b0RXNkNZNHFsRVVUTVN6bHBPNldMMkloL0Q1?=
 =?utf-8?B?K2IwZVB3eXhYS3VUK2lFM1hWaEdUbEttc1BYV1RRM1ZrYnlubjZBOFMyMzR2?=
 =?utf-8?B?UGF3MkFWd0ovRGFvWUdPRHByQS9HR05ZL25aSjlvcTA0S0thTXhieG4xdy82?=
 =?utf-8?B?d00vUXBFQVdNbkxWbVJCTlBJOHFTMGdPVHFBMXF5QUxDSkptdStNOTdkNlov?=
 =?utf-8?B?VUYrRWFJSzFjMUZNMkU1WjNDWlhrUmluOE1aeXQ1b1U3L0MzYjBGU09CVzF3?=
 =?utf-8?B?ekVJY1IzM3hobUlXK0NkWGFaSVJla0M4TmxxbUNXYXRpUW13b3JVQjkyUEI1?=
 =?utf-8?B?SjRTbCtYQ0JWT3gzdDg0dGtDdnN2YVhwcmpnd2djWm4zNE9WOHVqaThVNEow?=
 =?utf-8?B?ZE4vUjBFNmxMQm9tUll2cGFUNWUza0E2d3MyMWh4Y251dlFlUzJoUCsxL2d5?=
 =?utf-8?B?VVB0R0ZNbk1wNzFPM2tkcWs3a3U0dEZBRmR0bFQyUW5GUHdhaGk5Ymc4WHJV?=
 =?utf-8?B?bFdXdGI1RFNYSjdOK1hQdXFVNUVMamF4MTcwdEg0cjJBK2FsV3gzZlNWYmJU?=
 =?utf-8?B?cUx6cERhb3VWSC9VVUdZQ3NrK1dycThhZld6RHpGTU8vV1U2c00vZWFvQkRT?=
 =?utf-8?B?U1VXYUtCaGRZOHZybVU4S1J5L0VsWXJKdHkyUkRHcmEvRHl4U0Z3em9XZGpD?=
 =?utf-8?B?Q0MzSHJ4UXNNNElsMjA1VUlHVTI5L2U5dXFuTmhsNG1YUWdabXdYNUVneHhZ?=
 =?utf-8?B?VmxuUzhqZEVmSWFuSTlJUjRiMVVBU0lON2kyVm5pMWRwamQxaUZqcTNQSlJ5?=
 =?utf-8?B?Ry9DZ2NGYmlITjRkUVR6OHQ2YzB1cnBLVXF1N1E0R0grTmdYb0d6REcxRUFI?=
 =?utf-8?B?Wmk4TFZEQlBYZ2JLTzc2d3RwdlIxbldsd0dZbHQ4aXQ0RFYyRHZOdFVDVjlM?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17A6B90D38B83D459EBFB36B4B26DFF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mO7P93t0cwvkjLGyhRTzeBGaeRPiwcy1hiXx2myuO2sXdJQU3mLMeWkrhQiBEP+HZrWc9V3CptS9q7GU7jUYBsOVcZBntKuF3+n1jpSB93WC2YGooMhw/XCMO8R3DayEh7o5Is0B+qNRaZTvwqkWHjWZ5U1cjFaNrsm0pGi5Dg1X+6R1Yiw+HH1AQvbszw2zJuZ8Q30WyzkofgRr1Y+px9wavxTLQKAg1I5K8mWplvABXPOcueRkCRnFGIZqNhrME7lhgx9A+HwQN6pSnIPHne11jShy5agoASucWSy6AhpmHpGXljTDdkd7wThfn2B3ySBLns4bpiQSQRMbHEhA3IvmxgWi/fg7cvxzOAjwZQCw8tz1Xa0wgZSx9srfKoFgcpvDVax1VXcyDgwYAysFwF/3mS0Bth2lxeFUnqba3B7feNkwlvXAYTbwatg+Ha8vhaIgHR84VFE5uOcPcgfV5ivYBfBozbG8WQK4/43ImbHL6Ns0JvMWAG8m1J7Pld8DR0AsjdvyWtgwOgZ3HfZK8MVgS6WxNniYlkTZiek9nz8DYyKe+b7HcuTSFl8Www+P2jARLRntOGiGhD/MAqYxTlnvb8et6TOzVtxitjUH/6GLRLyE8eS8khzrmfObAWTau93g2ATrPrY2P+bHIKtHpagH7p9MvRL36ZXvWsetHIa+4FiJQzGf4zQ2QG2dLvMTioknJKp0ER3hwPBpzChTq4oxnwBu13UWoZtx+d++hauqx3clArHSMKMSNKGpE5TUlm/hvoe6XVJFfQAO40KzaaSy9WPt9cSLgd9/KX0wFdHvkmaD4JHvH2zTE2tZ2vHyjl5BJZKDDEtmTViOTs/Kp22GOgLQ+UVvG4gQKT1LL+O2dl5T899SvVQPPBn0XBeE7n7ESr5lf+iRsr/hGn5pyIhyja9IEZ1A6X6G0ZyFMVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07e2c1c-afc0-48e9-f3ea-08db2f9e7638
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 15:09:43.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQA8Syh1Olxsnmy6wK2b4QaWLDfgYmEeaqn6y1K2B8Kf7MVY+eEMnMxMddpAsjwXxhb1LaTJwOm5ZBEKkxItFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280119
X-Proofpoint-GUID: AEzMu-ERHDw7e0x2KQnmPjbfPjgkfFmQ
X-Proofpoint-ORIG-GUID: AEzMu-ERHDw7e0x2KQnmPjbfPjgkfFmQ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDI4LCAyMDIzLCBhdCAxMTowMiBBTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBNYXIgMjgsIDIw
MjMsIGF0IDA5OjQwLCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdy
b3RlOg0KPj4gDQo+PiANCj4+IA0KPj4+IE9uIE1hciAyOCwgMjAyMywgYXQgMzoyNSBBTSwgR2Vl
cnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4gd3JvdGU6DQo+Pj4gDQo+
Pj4gSWYgQ09ORklHX0NSWVBUTz1uIChlLmcuIGFybS9zaG1vYmlsZV9kZWZjb25maWcpOg0KPj4+
IA0KPj4+ICBXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRldGVjdGVkIGZvciBS
UENTRUNfR1NTX0tSQjUNCj4+PiAgICBEZXBlbmRzIG9uIFtuXTogTkVUV09SS19GSUxFU1lTVEVN
UyBbPXldICYmIFNVTlJQQyBbPXldICYmIENSWVBUTyBbPW5dDQo+Pj4gICAgU2VsZWN0ZWQgYnkg
W3ldOg0KPj4+ICAgIC0gTkZTX1Y0IFs9eV0gJiYgTkVUV09SS19GSUxFU1lTVEVNUyBbPXldICYm
IE5GU19GUyBbPXldDQo+Pj4gDQo+Pj4gQXMgTkZTdjQgY2FuIHdvcmsgd2l0aG91dCBjcnlwdG8g
ZW5hYmxlZCwgZml4IHRoaXMgYnkgbWFraW5nIHRoZQ0KPj4+IHNlbGVjdGlvbiBvZiBSUENTRUNf
R1NTX0tSQjUgY29uZGl0aW9uYWwgb24gQ1JZUFRPLg0KPj4+IA0KPj4+IEZpeGVzOiBlNTdkMDY1
Mjc3Mzg3OTgwICgiTkZTICYgTkZTRDogVXBkYXRlIEdTUyBkZXBlbmRlbmNpZXMiKQ0KPj4+IFJl
cG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+PiBMaW5rOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwMzI0MTMwNy5mNk5lVzln
Wi1sa3BAaW50ZWwuY29tLw0KPj4+IFJlcG9ydGVkLWJ5OiBOaWtsYXMgU8O2ZGVybHVuZCA8bmlr
bGFzLnNvZGVybHVuZEByYWduYXRlY2guc2U+DQo+Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci9aQ0c2dElvejBWTjZkK295QHNsZWlwbmVyLmR5bi5iZXJ0by5zZQ0KPj4+IFNpZ25l
ZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+
Pj4gLS0tDQo+Pj4gTmZzcm9vdCAoInJvb3Q9L2Rldi9uZnMgcncgbmZzcm9vdD1hYWEuYmJiLmNj
Yy5kZGQ6L3BhdGgvdG8vZnMsdGNwLHY0IikNCj4+PiB3b3JrcyBmaW5lIHdpdGhvdXQgQ1JZUFRP
IGFuZCBSUENTRUNfR1NTX0tSQjUuDQo+Pj4gQ09ORklHX05GU0RfVjQgc2VsZWN0cyBDUllQVE8s
IHNvIHdhcyBub3QgYWZmZWN0ZWQgYnkgdGhlIHNpbWlsYXIgY2hhbmdlLg0KPj4gDQo+PiBNYWtl
cyBzZW5zZSB0byBtZS4NCj4+IA0KPj4gSSBjYW4gcXVpY2tseSB0YWtlIHRoaXMgdGhyb3VnaCBu
ZnNkLWZpeGVzIGlmIHRoZSBORlMgbWFpbnRhaW5lcnMNCj4+IGNhbiBzZW5kIG1lIGFuIEFja2Vk
LWJ5Lg0KPj4gDQo+PiANCj4+PiAtLS0NCj4+PiBmcy9uZnMvS2NvbmZpZyB8IDIgKy0NCj4+PiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBk
aWZmIC0tZ2l0IGEvZnMvbmZzL0tjb25maWcgYi9mcy9uZnMvS2NvbmZpZw0KPj4+IGluZGV4IDQ1
MGQ2YzNiYzA1ZTI3ZGQuLmYwNWMxM2NlMDE1NWJkNjkgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvbmZz
L0tjb25maWcNCj4+PiArKysgYi9mcy9uZnMvS2NvbmZpZw0KPj4+IEBAIC03NSw3ICs3NSw3IEBA
IGNvbmZpZyBORlNfVjNfQUNMDQo+Pj4gY29uZmlnIE5GU19WNA0KPj4+IHRyaXN0YXRlICJORlMg
Y2xpZW50IHN1cHBvcnQgZm9yIE5GUyB2ZXJzaW9uIDQiDQo+Pj4gZGVwZW5kcyBvbiBORlNfRlMN
Cj4+PiAtIHNlbGVjdCBSUENTRUNfR1NTX0tSQjUNCj4+PiArIHNlbGVjdCBSUENTRUNfR1NTX0tS
QjUgaWYgQ1JZUFRPDQo+Pj4gc2VsZWN0IEtFWVMNCj4+PiBoZWxwDQo+Pj4gIFRoaXMgb3B0aW9u
IGVuYWJsZXMgc3VwcG9ydCBmb3IgdmVyc2lvbiA0IG9mIHRoZSBORlMgcHJvdG9jb2wNCj4+PiAt
LSANCj4+PiAyLjM0LjENCj4+PiANCj4gDQo+IEhtbeKApiBQZXJoYXBzIGl0IGlzIHRpbWUgdG8g
anVzdCByZW1vdmUgdGhlIGFib3ZlIFJQQ1NFQ19HU1NfS1JCNSBkZXBlbmRlbmN5IGFsdG9nZXRo
ZXI/DQoNClRoaXMgaXMgdGhlIG90aGVyIHJlYXNvbiBJIHdhcyBoZXNpdGF0aW5nIHRvIGFkZHJl
c3MgdGhpcw0KaXNzdWUgaW1tZWRpYXRlbHk6IHdlIG1pZ2h0IHdhbnQgdG8gdGFrZSBhIGRpZmZl
cmVudA0KYXBwcm9hY2ggdG8gZGVhbGluZyB3aXRoIHRoZXNlIGRlcGVuZGVuY2llcywgYW5kIHRo
YXQNCm5ldyBhcHByb2FjaCBtaWdodCB0YWtlIHNvbWUgdGltZSB0byBkZXZlbG9wIGFuZCB0ZXN0
Lg0KDQpJIGFncmVlIHRoYXQgcmVtb3ZpbmcgdGhlICJzZWxlY3QiIGNsYXVzZSBpcyBhIGdvb2QN
CnRoaW5nIHRvIHRyeS4NCg0KDQo+IEl0IGlzIHBvc3NpYmxlIHRvIHVzZSB0aGUgTkZTdjQuMSBj
bGllbnQgd2l0aCBqdXN0IEFVVEhfU1lTLCBhbmQgaW4gZmFjdCB0aGVyZSBhcmUgcGxlbnR5IG9m
IHBlb3BsZSBvdXQgdGhlcmUgdXNpbmcgb25seSB0aGF0LiBUaGUgZmFjdCB0aGF0IFJGQzU2NjEg
Z2V0cyBpdHMga25pY2tlcnMgaW4gYSB0d2lzdCBhYm91dCBSUENTRUNfR1NTIHN1cHBvcnQgaXMg
bGFyZ2VseSBpcnJlbGV2YW50IHRvIHRob3NlIHBlb3BsZS4NCj4gDQo+IFRoZSBvdGhlciBpc3N1
ZSBpcyB0aGF0IOKAmXNlbGVjdOKAmSBlbmZvcmNlcyB0aGUgc3RyaWN0IGRlcGVuZGVuY3kgdGhh
dCBpZiB0aGUgTkZTIGNsaWVudCBpcyBjb21waWxlZCBpbnRvIHRoZSBrZXJuZWwsIHRoZW4gdGhl
IFJQQ1NFQ19HU1MgYW5kIGtlcmJlcm9zIGNvZGUgbmVlZHMgdG8gYmUgY29tcGlsZWQgaW4gYXMg
d2VsbDogdGhleSBjYW5ub3QgZXhpc3QgYXMgbW9kdWxlcy4NCg0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==
