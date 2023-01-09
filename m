Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E120A662960
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 16:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjAIPIX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 10:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjAIPIB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 10:08:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C59A188;
        Mon,  9 Jan 2023 07:08:00 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309F1hnY013678;
        Mon, 9 Jan 2023 15:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YusgGfdoHJUKdzn/h0p+E+IB73yndSFdgqu2PNSb2Mc=;
 b=wyJx8c72cDvLq4m98nxe9gZsc5aZNgksQlv+9cEJNmIK84KyIdFpJk+rca4WLYuvCQx4
 hhMH5qz+QqohFBO0ZeFMkBaNzzGRloEhYAOtwD+25tdsD1hzA0RFFdopsF4R2Un5mhD3
 sKy+y0H4Jvv/8TUyrEfTE5eEaQgXuTfj95eflgkXZoRyKmGBGC6d/1PisQMcPtH8u5c9
 na+aoZe0iJ5vY6+8d9FqMRtidd1Ym0DfwrM2BW7Ce2Ga+kMByVbnDugzfvAC4dmTq5GR
 /rRVL9CYDpl7Di6gBt1NZqZ2ulsdMhJjLrGQ5MvHZWiS0gPzXFPSpg87L4T2CyX+AVth 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mycxba9wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 15:07:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309Dj7AP035417;
        Mon, 9 Jan 2023 15:07:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n0h8u8tyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 15:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2R3Nfw2LrnMzxKecwExSds0QdRvttnIuFmIg7ZA6egRGVVNTe/50aU06BO1/sLHnrn6JN1TP0kTDYsy3gDD9+OJZDvihD9e0+ItSeJ2Y0kW6ls3/aubClabOgKiDP2XTn0bj7TgnLs2F7JRWIXZDPk7JztRYoJqCmmHGhbpDB6hZyKt4A32dxAACD1lZ6vFacgsk330hlrryoWQ3VZ5hB3u4m5z3Mq89RM8g5FH9D9l8SarRVCKuApWxZcrEpVt3VCu3+hgGUjwUdwfj63G0TqqyQ0oiWOQwVcIRm1EZXDaKbfx/m6j6YkvRV66KyMWQUzNIbrHr/CCEDQt3ZQY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YusgGfdoHJUKdzn/h0p+E+IB73yndSFdgqu2PNSb2Mc=;
 b=oWxgkSfNrd4FFQPPQUlQN8zVWnKhruULL76gT+7ucyb393wEoknzZcLQyBWU5MttQdcnGCglnyTapZSVQvRVNeJZKc009b2NqJyxtntSf6b4ESO0U1OKS30ERXE1NcCSPSpblGc1B/CSkwPUQ6E/9kl0S8O4U6xFcqwjTMvsOgmL8UNa2KuWTSfmdTWPFldMJrwRcvOoRCTCSxy21LpRlh/QutML1o32KdJoSguyQsLIts0Zbj4p+2LMGi7zZt0af2s+nL7n1Pz52gBb9ixJTUdqXxRw+PHGDDakZp4FLxQNK4zu34bz7zyB6kYe08vTUPz32SlgvywZqsE1TdIkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YusgGfdoHJUKdzn/h0p+E+IB73yndSFdgqu2PNSb2Mc=;
 b=Zu5T5pmjTkVJoKlcHJJvQDaPGwF9aqoHe1Hf/LTvtYql4aS7AvupQfN5+k2TG47BNNzWstYCOjiH8HY1tHB0qzZUfAndVePB6TuVEonqg4KoptvdXnPWIZ+dIMW4f1YGvORpvL4HpHaWdWF5Krh58bPVePs6OxX/ERvXLxZDnJo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6776.namprd10.prod.outlook.com (2603:10b6:8:13b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 9 Jan
 2023 15:07:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 15:07:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Topic: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Index: AQHZIq8GJkROOS2NVU+FmVsgVWlM/a6UhAWAgAA+nYCAAPy6AIAAB+QAgABlFgCAAAaNgA==
Date:   Mon, 9 Jan 2023 15:07:46 +0000
Message-ID: <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com>
In-Reply-To: <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6776:EE_
x-ms-office365-filtering-correlation-id: 658522a1-7759-4979-2ee2-08daf25343f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mlz2amvmPOSNWVW0QVeqXE22LLQ8hsCCBzcB6C7abgUbMhhXIbnHk57x4S6AYjZdKvBorQg/6BlbSH6B0TpsjCCbFo/CTt7Nc1HKIS429oYRBHRywL0ScgurJOYrIcbEp90bjlbH5dicmrgFpMfUPiYCFckh0oxE2QeE77SqHBc5/6Vudt9nSDjjRSpofX+q44uWSlg9FAwRziU2DAtXhelFQFnqunARmHzSy+pUq0qHro5FyZQQ8sBg+TL5RBZPnExWOnJp1gWNyHCAZJjHDygDt4VAhomR5J4Ae+H85/m+GudG6IfY/ieqRE7RbLxjmRgfLqgvdPJJGeSY+iAoODXlbjrHJWxvr/cZ8nP4WMZNbZQ9IXu5BdS3Ou7zk1EKmLXiyRXzLfttZMPmtonm7QJOxuno7FjyILjSO5Cfcbw7Cx/5TwoR9KUc0F1k/BcV6OCPxoL6TyW5ZDH5ex45Vkm9CWtCX/HNKWFXwEiMSSrsaBKC1TgEc3AbIg5Faol3KpA4xjn5o8ovUXHSO21OawoaIKw7CSbaSz8swZobubkP05Ex1ahAmG3ITUysXhuMcKFJOJgCDsIdOQ+JAeYnBn2p3x/HlIB0eAv1RXXOBOg4vsq+g0FS3a32NUtoJjL/s3m/4ZrqtMChfbCa0A65eT9ihF2OR7scIoznz1Osmj/ZnSJ4LiYQWUw++FQ5yRjmdnXVDfF1REtuO8gzcj4bFcj1T/DercOBoRUV6k4Z0B1GujARJYej9B7Yzu6As0gG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(38100700002)(122000001)(33656002)(83380400001)(38070700005)(86362001)(41300700001)(66946007)(66446008)(91956017)(66476007)(66556008)(64756008)(8676002)(4326008)(76116006)(54906003)(110136005)(316002)(5660300002)(2906002)(8936002)(6512007)(2616005)(966005)(186003)(71200400001)(6506007)(26005)(6486002)(478600001)(53546011)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ccj4Ut7pZ4lqi/cz4R3YMpRX9D5iN1FDl1XPRC2XrOIWj3TFc5N8NW53rfWu?=
 =?us-ascii?Q?Fs4AXYGtz000rZHIdWmYIznbs7DMNwpQ2hIbqmFcWH8TY9BPj21cKnTFa5mp?=
 =?us-ascii?Q?d/SljBbFgwg1QF3u85L12a7SCFUH+yPpJOKpr4v4KUlrPJyQyXLcfVYQy1rx?=
 =?us-ascii?Q?XGhUqDCmGb0YZtEgkHzg/BQ3O/t1eoVCyzhP3Imwi6VwimLny2c6PT72Rm/n?=
 =?us-ascii?Q?vDuqTxzp8t7w6sGrVJwNeJQUv8xBWfEbEc9fdEfzGb1gGgRU6ZmxQBZRbDB6?=
 =?us-ascii?Q?89Cxr20iUzzlTGaAMUpn95k2ORy5ro6/W8CQk4jFwj7Zviv8FB/c733g6Tp5?=
 =?us-ascii?Q?we9xFS/9TzotyAG5bX4uJZBtws81GmkuySuWWu/eWwJAtsKpb7vS5BFwTJuY?=
 =?us-ascii?Q?iG4g1Bm+YMMdaqre9xNMIiAzraqmhMXCamGx0TBgLvhQC+IpboSsRW7aAMNW?=
 =?us-ascii?Q?SKNlpR5gsJ/5lVIBpKMvbmJMXcN8j1ZziHjMKlGbioJAGX3hHyz45PWIdzvr?=
 =?us-ascii?Q?KiGLlsj38q4IVkK0mv9Ni3YcY4KGeTGtQ6Ee/NeoYHfgWtQu8UL8xgUpkLBc?=
 =?us-ascii?Q?Pk0cnW6k9IL2i71HT0Gj89wn7skf9+Amp3mtlffucg7mt6JPGPMfaqKb+cmu?=
 =?us-ascii?Q?QqwqPzIsz31/+IMiARKKF6mGQJocB5jaPq9k/dvED3qS09ta9dBb9bPmks6a?=
 =?us-ascii?Q?qlbEdGu0GAhlagat/twC7fQ4bT+/ZhlY7mpRxSXNmjKgUiKYUXthnhLvfv4O?=
 =?us-ascii?Q?Ip0twJy5tIDu5acegplDVt1pWgr7ikpCaNx9jP3jwDReasXjrI0AL/wivAF3?=
 =?us-ascii?Q?Cke4WYOqcw4lSEPJNo6v5dHkyuTtPXaSvixbcmhfBuhamxL9h98FId203BFz?=
 =?us-ascii?Q?M7S1TIlYd3HSwK95z3LBftLRfapiMY74gtgRlH1QJj+ineu0KrKl0dWhY4hN?=
 =?us-ascii?Q?BpvrtzzNGh0jNdNLdlgUNiQLalROcQe/jrDszLxurK+HKLepL9puPVKLaOf4?=
 =?us-ascii?Q?qkAU0RuF/iCQ5MCVbDMn2VMPzSYwDRuUDJtV0nJYq3/Bj64vEoQx0YEyH5L7?=
 =?us-ascii?Q?fXxO++pYWxRHnMSD7sPv1cqhsvWp7QqL+dG0Li+u/kDqDlYvhvUxAUuLP5Jx?=
 =?us-ascii?Q?Vhd/P1s0am8Fl6APvHCPscIxHpF9aFNN2HErmJGZG3wSS2Uue+tZwjW+W7a6?=
 =?us-ascii?Q?XP6r8kSXhoZluct2eLE9rR6Vkwb7yR9L7Wzr0ssx6xPSDahtqhpH9a4V1svb?=
 =?us-ascii?Q?rGizCByZnoDd0aMbkQZP/+hrIpIA6OrY+AgmO8bJU4Mn7pebC5mLBBkUyXN4?=
 =?us-ascii?Q?uQHpDThdl+SElcHMoGwqGKTs/jS/+NV4g3NkhPlGpPQICwFW1frLTrcnR4+4?=
 =?us-ascii?Q?4FozVcb+KlSRvDpz/NhOb/8rNdjlRoEGSkuEwF0ZqfjPXfYYtBUwrigK6rvB?=
 =?us-ascii?Q?C9PtDjM57lUJ9lp6++Q0Z/qBjEwQz3DvZDzzOasjNmEeEn+YexiWvKU8p0Vk?=
 =?us-ascii?Q?jBQG53KUZRnmO658ryLcZQWEl/3yw1AKx/I1byQEoJJezxdY6pcE3HacBj6m?=
 =?us-ascii?Q?3GaE00TAibx5RSKb8o/aph3qHCiVpZHV+3CGt6sIKSVJXSwsfQV1s88P/gcM?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0BC5084936AF14B9D57375D8C43945B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iePuI5Ttrbgkj8pqRq0tHov2zP2IWgZjOj4fDSqg6TDfYobC98EO6IrQJ4Ug0XdQ/1c+/Lv0JfzI4teCbhbLLiclD/cxUBul9Kc1KgOq4m8l4zUL+n9/9iNV96lFKVruPN/bewh5DFPMoDP08+WHIyJBEsGY63BDgdFESpQTZYAPjksnWBKzKvSqFcJC5ROpU4FUmEt9MIZSx2R/dJp1mgjnhBfL6lLvxbqwdeSw95nIor8b5Gclb96CqJHAwR418s9+JRwzzhihNVMlDlurE/q6fbZGHGo/iPoDmykXxGAWvDoZPKHWIWg4DzG3syEsZ+GU47H+am4RVbUPbJJidfLC4nslSGmMEuw+JH0s2Q1v8ggFJNZNSVLrl3twjYj30OnpHBJczsNBGci2dwYhiSChnprwfc79foXcIWtfXT6QyKdmElQzjSjvcSDS8f3cDhHsNX9kJmASVgsCPi1eIsywvIaJsbvsuCfj4LH78ldvf7TvWXGaiEVmFj0JM0aPHk36leQ2j3UaqnjhLCN9DfVNno+NGQxaPzniIqiqecsZArJzvBUiMKctgGmaZ3JHuUNNSH//atoy60WBbwCI8rGf7YrewJprbBAtozcVuKwZT52YrynBjGEC5S7ijBgIoRO55urtsEbMCz0uNB+caBYsNglfZmE6q+qgnzZ6SahBBYj+bdkxcBjBlHT27o9qgHYmnUszJ4dJz4J4Vw1hI2BcdgRVtlLbpm3lD6T6Yg+xL8Jt0u+8mA+YXJt0R/bmG7EmTfVFhjTNDiSDH+3GBdUQ1K15f6mHDws6MHyJlFjLJ1ODuOwhOu4EaKbdiMoVD0MULt9nsQIOpaJKt+P0JWjO1YNeqHzbDeYlGA5p7pvCqBFqydNuZ4JX3RN5VSUplRhy1eHhCRAmvntbRGq3ag==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658522a1-7759-4979-2ee2-08daf25343f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 15:07:46.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gknygaFp65TC8XIQ5hUxR5+o7gcvbiOnouCuY2aR1TbejY2ZoQDfKTlndRz2hpq6/WRsKKHj1fXwVH8AxmCzvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_08,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090109
X-Proofpoint-GUID: w50eHOpCzSwzjQzuPWMIERUw_vjaIRvG
X-Proofpoint-ORIG-GUID: w50eHOpCzSwzjQzuPWMIERUw_vjaIRvG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 9, 2023, at 9:44 AM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
>=20
>=20
>> On Jan 9, 2023, at 03:42, Krzysztof Kozlowski <krzysztof.kozlowski@linar=
o.org> wrote:
>>=20
>> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
>>> On 08/01/2023 18:09, Trond Myklebust wrote:
>>>> Hi Krzysztof,
>>>>=20
>>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@li=
naro.org> wrote:
>>>>>=20
>>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn=
 why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>>>=20
>>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>>>> Hi,
>>>>>>=20
>>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
>>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer excepti=
on
>>>>>> when mounting NFS root on NFSv4 client:
>>>>>>=20
>>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Inv=
alid
>>>>>> argument
>>>>>> [   26.199478] 8<--- cut here ---
>>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>>>>> virtual address 00000004
>>>>>> ...
>>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/=
0x358
>>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>>>=20
>>>>>> Full OOPS attached. Full log available here:
>>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>>>=20
>>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commi=
t is
>>>>>> not the cause, but rather making it default caused the regression.
>>>>>>=20
>>>>>> I did not make the bisect yet which commit introduced it, if every
>>>>>> config includes NFS_V4_2_READ_PLUS.
>>>>>=20
>>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to=
:
>>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>>>=20
>>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>>>=20
>>>>>  NFS: Replace the READ_PLUS decoding code
>>>>>=20
>>>>>  We now take a 2-step process that allows us to place data and hole
>>>>>  segments directly at their final position in the xdr_stream without
>>>>>  needing to do a bunch of redundant copies to expand holes. Due to th=
e
>>>>>  variable lengths of each segment, the xdr metadata might cross page
>>>>>  boundaries which I account for by setting a small scratch buffer so
>>>>>  xdr_inline_decode() won't fail.
>>>>>=20
>>>>>  Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>  Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>=20
>>>>> With a trace:
>>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Inva=
lid
>>>>> argument
>>>>> [   25.986237] random: crng init done
>>>>> [   26.264564] 8<--- cut here ---
>>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>>>> virtual address 00000fe8
>>>>> ...
>>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
>>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>>>=20
>>>>=20
>>>> Is this test being run against a 6.2-rc2 server, or is it an older ser=
ver platform? We know there were bugs in older server implementations, so t=
he question is whether this might be a problem with handling a bad/corrupt =
RPC reply from the server, or whether it is happening against code that is =
supposed to have been fixed?
>>>=20
>>> I would say that buggy server should not cause NULL pointer dereference=
s
>>> on the client. Otherwise this is a perfect recipe for a rogue server in
>>> the network to start crashing clients and running exploits... Imagine a
>>> compromised machine (through some other means) in a local company
>>> network running now a server with NFS share "HR salary data" or "HR
>>> planned layoffs", where unsuspected people in that network access it
>>> leading to exploit of NFS code on their side...
>>>=20
>>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
>>>=20
>>> Which points that it is not latest stable, so anyway I need to update.
>>=20
>> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
>> latest stable and I can reproduce the issue. Therefore:
>> 1. It is visible on two stable (one new, one old) kernels on the server,
>> 2. Buggy or rogue server should not cause NULL pointer on remote devices=
...
>>=20
>=20
> The nfsd READ_PLUS code is borked up and until 6.2-rc1. I thought we had =
a server option to disable that code, but it seems as if that is not the ca=
se.
> Chuck + Anna, can we please send a stable patch to rip out that code alto=
gether from all the older versions? If we want to enable READ_PLUS by defau=
lt on the client, then we cannot do so if the majority of NFSv4.2 servers o=
ut there are running a borked implementation.
>=20
> I do agree that we cannot allow buggy

or malicious, or non-Linux,


> servers to cause memory corruption in the client code, so I propose that =
we revert the Kconfig default setting change again until both the client co=
de and the legacy servers have been fixed.

I stand ready to receive and apply server-side fixes, as you suggested.

However IMO it would be most responsible to go straight for a client code f=
ix. The Kconfig setting is a red herring (as delicious as that might sound)=
. Any thoughts about how difficult that fix might be?


--
Chuck Lever



