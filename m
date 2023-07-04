Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938397474E5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGDPFC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGDPFB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 11:05:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80610CA
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 08:05:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364Eictu026466;
        Tue, 4 Jul 2023 15:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MH/QnKLUshFITecnvnLeas2ZbgHhhrN+6l9P7gQrfdA=;
 b=rQE2ty5qrhPDXRlnyU974PuOkK8X+dE1/MkphrIXz7C4jog2rE3mv7hA/CSBhezF2vKl
 EP//R7XmUP1hkosQZEYIwBt78kPzQL1b+Pl/UOk9W0SXmQMQe8APukcYr1KfiFaRCjt/
 IyH6X8BnIinvggreMNW0VnTRQni57fX2KtmY2aA8/K1rNoluSt+o0xQ5ELfKd1135yNc
 2qIMEQA4RoVJz2mjCsCmHttn4FxfrlZ8uHdqHADHJNDLXQ5Su+o3pIOj19rcn/bFbObf
 u9jm1I/BwThSc0qAH8pG4f+Cx46LAAAjsaVbqpW53n2/ihi87BqfEDblNUGnTEqHuaDt 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc1amqdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:04:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364Dia9f009645;
        Tue, 4 Jul 2023 15:04:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakagfu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 15:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsxtPwsZLOZzzwjvzM6SXCivWz50Qf5KQ3KgEjJn4tahrs+WkFmiBvk/rUf/WLURggzEpvsf1wbtKQAicpbBSVuey5VJCQ7kK0LvVTTWi3Rxijma4Hn5AhFSUMHSN0iMG+bcSyaqJ4A7xql2dsLfcM3rhk5gKBaSheNaQrXifi4DdONVlgtQ9QNmPBj7vrSN3RB/yTFPij88GCIHZ8lZvbBk83O0gU9Ug2PFPpoNdCoBb8JNuAxFKe2bpn+91x+/04gviouXFDc1/4KVsTsUlnlw4g0haJYplEQSNCB4eAVRZbjwTVlyaLDwvKgaNGHm2+aTyD+VhqJefBbwLtkdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH/QnKLUshFITecnvnLeas2ZbgHhhrN+6l9P7gQrfdA=;
 b=Oc9mBSB2DukarkkysS70pZLu4S4ucPZFFECNZV37x2gSX1Bd21OZsAI/XYmma5aAktMTf5aMJIcQpMFCR5G1mLUmKpqbUq/Ek5hxABBChWb5FxZT4amnH3z+azKN9wUiG0L+FaEo3FMxzXP6l5PeqMsOvDKh4LIa+0f3QPTyZB8QhOlEWenVKXm/lJerjwu3syy0Z9PP9z6GXqaX2ODKR+EHjNjIZlj1wuHFEKR03TXdl11EjrHfWYOOQkYalzvZnP9DPeODYKu9yYkUWYIdFRBPfHM1AF/v92kaCAFh4VRV1rJQh8bKGUCVGPKztLbDMYEA2sfdjNLnoiS0BtACWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH/QnKLUshFITecnvnLeas2ZbgHhhrN+6l9P7gQrfdA=;
 b=nMW3pU4tUnCCnwSfdoRijrtbLGnCLx9heiQeUDKDkivdZh5a/YtAvUMRIQjIqkmIOgrrsitKJeBrWWUKy6elkXN8ZhrlKSIQus/NwDs5oZhSq1gHAbNdvHW0hYk7ohwt7Sm/fWk9V/zYbV8m9hRCleUMvQ8+rXUNDWrJGBtBRyc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:04:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 15:04:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v2 4/9] SUNRPC: Count ingress RPC messages per svc_pool
Thread-Topic: [PATCH v2 4/9] SUNRPC: Count ingress RPC messages per svc_pool
Thread-Index: AQHZrguZSYcSrGelgEOwXadkv8haTK+oxYYAgAARQYCAAAxCgIAA0pEA
Date:   Tue, 4 Jul 2023 15:04:46 +0000
Message-ID: <3A42B6ED-E288-4351-8C12-0C9DD8396E2D@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
 <168843785749.8939.9913705917013899427@noble.neil.brown.name>
In-Reply-To: <168843785749.8939.9913705917013899427@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6663:EE_
x-ms-office365-filtering-correlation-id: cd89fdf4-1485-416b-42a5-08db7ca00186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNi7HyxHsYtvUAZIvl1T/Tcas3aLZb66K3XGJOfxvyzAfaY4sU7tAIcg6dC8WYY0FG+OsCI+hzvTQ4lk+zRpZ9+LjuuxaGCNhqh4HmKF4GGlj/Cm4u0H2ne+A6mtPl3rG46Fujp/pUq1GlV+S0dZvg2HAuIFs83rfXchwQJ1bPAU44gHp7sWM6xAjvBr7nLnzrYwxireN9YEsWGtAwrxX0oWY7//vmuampNhVL2iia5T1jdwczbC7zYJ5UI9A+TmV+zLtBBuc4qhP/G2szmE5Y8RsTvQwN41fdUptcCAuDOSB5LkWXyFJ7xF/NfCWg+vlfxQgGmylwUA15cUBbkkzKds0FQfqFlNoOdAKQ32EpSYX0a51IZ77S6BYitbEvZFEZGtbdF8NEnv+yNRz/Ju1Vxe08+h1Rk0HRBk6PxZTSKUlATssYXT7zcWIXfBrL9GqEc76nvqQY7zedj7t5R7S1ymBSRnsd2dqwkCHOcUF1h6ZszXIJ7gfuIIXsMtjiocCI55RZUQgtMxFRKgwU+GJ2AxmAhCPMeEsXTbzZvPQL76C7ljXHewhuNMvROFpCbZ0I/3VFl/QVnc7NpazMA7Z64P2UvAaw0Peo/3lowMhjST1opHBIND/F4VE022w28RQt2dp3h73VUjPgtEJdhN+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(54906003)(2906002)(478600001)(26005)(6486002)(86362001)(33656002)(41300700001)(15650500001)(8936002)(8676002)(71200400001)(5660300002)(36756003)(316002)(6512007)(66556008)(66476007)(66446008)(66946007)(4326008)(64756008)(38100700002)(122000001)(6916009)(38070700005)(53546011)(6506007)(91956017)(76116006)(2616005)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ObDTB3xgIDE7dnccvirpYJGHdgS81DPmNo2uA2ChKSA0b0oLbCAQnrmmWvKj?=
 =?us-ascii?Q?SzzoAT1SU9hRR6t8uZD6qQqtxZadISKiBhstue7zo9weps3u61SpqY2ugvkM?=
 =?us-ascii?Q?9aDckupLR24iD2vhml9HN7t7aUAYr4UlaIQj1TUTJPOoArGmmQE2GrTpGox9?=
 =?us-ascii?Q?EhGtJSJtNd2ter0AuMjK0c/UmbjKsX//mPV4EukfIBUr171hwTzJGimUJLPK?=
 =?us-ascii?Q?mw6iSPGp9Kl3FZF204U+83kSnMqqDfbqxGbOyJ1T4kBPTWyLciNJzGwz/AYN?=
 =?us-ascii?Q?5fxwidGnxt7nDR3NldXw8BLIpn1UvcwrnNrlaXNEDHT6rT4TrbdbyydQCgDc?=
 =?us-ascii?Q?DRzWJgNq5mDe2PNA975Y1QnC9DVtVtOAdX3uAJJPk+eIdeCFvdqFHlk/nMC1?=
 =?us-ascii?Q?YmvMpZgh9DD+IHkKmiudN/N/yNOXpBqQ8aBgI1wKOpOFXpQ8rZjBi+g6WNqm?=
 =?us-ascii?Q?jwFws0QEPBD/b5aFOwpRBnRljib5W57Do6whNCj7ApILYtxGD1lMgxbSC6mR?=
 =?us-ascii?Q?IPYWY/mdh+BQJDau9dM0cQdbuAqqp1jIMdeBqbQFJAFONmwFNgKqb4rNDKW0?=
 =?us-ascii?Q?z12ct/iNKgVYtq/xNyHhIxYIsoeuIX9RESv4GidLTViyTcAVHaW1W37Lg9fX?=
 =?us-ascii?Q?7LbqgTDEUIxpaWModHF/ryZxBQ2JzT8S19O7Z2HB0eXURVX4eTLR3BapJh8u?=
 =?us-ascii?Q?u9vVG09MFatFF7J7Owa61Pkt78tzISOn0doMsXP2dSn1hOb9A2GzQk5TOrov?=
 =?us-ascii?Q?LcOsJW+JgKRrfg+lxwpGQGvd4BPnOgmCeHPwTCmsD+yU5Q//ttltGMgtjxeB?=
 =?us-ascii?Q?0XZZ3UaaSGSAzsm3FN6dKQUL1GN9rsg61IibjWs94HwQiiXyeLXw+az2cfEo?=
 =?us-ascii?Q?pTNNguLCVnYpWtP/F3I5G2pnq1EE/J1/Tp1p+G5/YnILiNFK87rgzi2zwr54?=
 =?us-ascii?Q?jr7/gRA8Raqt6ehLEl0y5ULvxD78U8gVqwQzXc2tI29ZVRjeeWB2ilVgXrgz?=
 =?us-ascii?Q?zQ8gL6C7yOqgv3W+GQ1JNorNY6ZRMs+HJFAgyXj/YPCp+f/1qR+gvLCl1Xa/?=
 =?us-ascii?Q?PAOjnDoeM3bsNieOlwASVPsqLA0F+2aBu0EuMF6F/IlKLXQGqYTwMtR24szN?=
 =?us-ascii?Q?HF7FLYjmbcxEbL7cEA50dOP8plWHvjHpgNlMj/W+rA2e+MPnAPU43llUcac3?=
 =?us-ascii?Q?EvcfISse9ee8eQu7ZOfNvHShTUJc0LAw134vff9dgTqfnMXaaYxY9yA7UOws?=
 =?us-ascii?Q?SQx1pbhf+CJzy6b96uG/8Jy5ziWjHtnn8hndpVl17CyFeJSFA9nXizEvFEYm?=
 =?us-ascii?Q?wy4vJaLInMUXpoBcBSgfVN1LZEB3CkvzJXOeUUajeaAf0uUOrpKTnencY4To?=
 =?us-ascii?Q?Rg9zL6F7y0+k4S9UJPSYz4x/Fcnn5JT52B3xrebG2+yBcHP0GNwCQfIOhZli?=
 =?us-ascii?Q?fIZvkpvxF3JzyPeUg8XLwuXSdOfKDn1BrqLGwBGApCemzL2YfWvAnyuQJtPf?=
 =?us-ascii?Q?uFKhKonydUAxe16h8er4NsbhBIVFulQbqCZBko1b8135udl9MUsleQ35flSC?=
 =?us-ascii?Q?F+/VXEumeadUIfe1S8mHeR6B1wHu4ojsFaSYWFKNlpqtbIt1brF1eZwIzuq4?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D09D7E5ABED84D41B6799A8ADFA8BC8A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KKF+1iratm86+UWV/wkJXXT8EoF/cXjCuyT/CahsMc3XjlJl2kGTr5GMfbLJ3pn3bX0UeJV8PrTSDKwGiW1HoD5dTMkfL4ZK63uWD8J25pC/crK/0jTwUKEwozjbvqlsUoIulGW/G/1LswA6btwmy+Fr76wG9mGRCxybWnNbKOoliAkqAgAwpnmHF7FerDaDHM84vQaEicDmu31IUNXA7JU8pcxbLzfnLIT/9yzJxhTs+f9LtcrQZ8mZZsfnvY52jqxr9QD15Pmhm4l5YhPWHPuKyxHeqDBDH50360tAWVdMyN04W+vfQlhuh4gFYDG6ZCsUXjkJV5rAKYnqmKaBrsoZ1VHPPpky/1r80fwOBxpn2qPXt6+oJ+f0V6U9a46fndaYc+22Jvk0CmLVcfdzU8+xD7lc3DFcWGlT5Rcdj4HYrdvB5AxOv4XQ18tJuZEuQhP3f9cqJBdeznvINgtkXd7XNofRdY6vn2rMa04LXPURhcEIKdFYD1b+8M/nOPQjlRT35DGJ104OQcDRtuFm4yXDyaK+gQdGYqK4JPU+3munB78/UfnT53FXh/BPebKS07xy+b22FtoqSyQUHJ7cmOzELTIMqCKU/DuazZRX+Jtj0XRxKAXIrpDCqRzXh5os/+o6ZK3crIUOnymTebWC1nhSCvzCnSFzOh1RQuKv7F7KytigCJLOBKhpySaer9qJ1DvepQ7+ZcySYHuqOh89i8HnmW0/PDK0KktskjznXNPHe9Fi1UojZid8AezOK0x5u+4IBlKqtzLpbU6gcssoCMcHN8iAMY97EyDBHFI38t5S/ieLNs3kvS+/KIYvaB7Q4FaJFwsJgD7j+JDwf3TiPuwWrtHfaOwA14P1gYM50kJB6yTrj0yTqI3ww8tFCUv0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd89fdf4-1485-416b-42a5-08db7ca00186
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 15:04:46.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUNVzowdKF9nSC86mkz1jUJxU7/UZQVvx/PCEj6myv2gZfIuFmWRYjoxG0HSkwyXR/38Mgju2hZYpGtXcmgUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_09,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=925
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040130
X-Proofpoint-GUID: 978epEtqP7RVii4F1jCVYnNq6PVcvHwk
X-Proofpoint-ORIG-GUID: 978epEtqP7RVii4F1jCVYnNq6PVcvHwk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 3, 2023, at 10:30 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 04 Jul 2023, Chuck Lever wrote:
>> On Tue, Jul 04, 2023 at 10:45:20AM +1000, NeilBrown wrote:
>>> On Tue, 04 Jul 2023, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>>> To get a sense of the average number of transport enqueue operations
>>>> needed to process an incoming RPC message, re-use the "packets" pool
>>>> stat. Track the number of complete RPC messages processed by each
>>>> thread pool.
>>>=20
>>> If I understand this correctly, then I would say it differently.
>>>=20
>>> I think there are either zero or one transport enqueue operations for
>>> each incoming RPC message.  Is that correct?  So the average would be i=
n
>>> (0,1].
>>> Wouldn't it be more natural to talk about the average number of incomin=
g
>>> RPC messages processed per enqueue operation?  This would be typically
>>> be around 1 on a lightly loaded server and would climb up as things get
>>> busy.=20
>>>=20
>>> Was there a reason you wrote it the way around that you did?
>>=20
>> Yes: more than one enqueue is done per incoming RPC. For example,
>> svc_data_ready() enqueues, and so does svc_xprt_receive().
>>=20
>> If the RPC requires more than one call to ->recvfrom() to complete
>> the receive operation, each one of those calls does an enqueue.
>>=20
>=20
> Ahhhh - that makes sense.  Thanks.
> So its really that a number of transport enqueue operations are needed
> to *receive* the message.  Once it is received, it is then processed
> with no more enqueuing.
>=20
> I was partly thrown by the fact that the series is mostly about the
> queue of threads, but this is about the queue of transports.
> I guess the more times a transport if queued, the more times a thread
> needs to be woken?

Yes: this new metric is an indirect measure of the workload
on the new thread wake-up mechanism.


--
Chuck Lever


