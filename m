Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BAF74E187
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 00:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGJWn4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 18:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJWnz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 18:43:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DF01B7
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:43:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHTKv4015066;
        Mon, 10 Jul 2023 22:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1EUMKxtFG4eC57YbwRauMZx/mNVuy0bj2lF9pjx/LF8=;
 b=w4v5mYS583qRafp3YvE49hnPmszk84EvBQARk2hYAjY1ZRdv0namPsxLPQXzEfiHYWQA
 1e/Nb9Je1xYkl/iiZhgsdQ2vzw/5So1y2+xCHTSGyBQZWKQeSZXOZEf4irvcU1zaZ9t8
 VxZWjqoakmXE33UYU5vj4JeVcvAgSciFSQTzt9z16EsvbdVA67yt4Fx4AcqcnLZvtAQD
 oXXZHJ0sRdEI7bAMIRGGDFilMHXoF6+1wXP7DxApIqS4pkDLADyIYEiuyK8rMN1DESb8
 FlzkjnCEjD9qSuGI9vkweA5CBXWCcqLdnJbldwdByG+f2vbj1NoOFg3mqZ7ll2WpFftJ Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2snu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 22:43:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AL8efi004014;
        Mon, 10 Jul 2023 22:43:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8ab78k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 22:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7YHkmyGruyCv2dJh16trtqAVbVtndakaV5xbnXXu9E8B8voBGN36BMM4LwlQLra2U40Xv4P2eZ1z8eKDL8KqnyzKTaC63Vsr4n1mFRjNKcNfIlcvLflt1R9d+M9f54ASvK+AZykPKBU7TmCmMc4SBJ8yq1Ae9yqzJSit03Ri6IuGseObAi9sNZa5QzD2coLADVBuV1ZYJ/HxmzZcYd3IFByGjbLbr4iyzB9zUK/EC9ffzFT78P8mOVv5vighbG5IZDxgZJ0Va0jygyC+Qs7vV/5555Hz8GbNama+JH49b8V8KDn2l/DxecVDLC/pQmzoSeBIleE8Y1+sPK4uX3IAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EUMKxtFG4eC57YbwRauMZx/mNVuy0bj2lF9pjx/LF8=;
 b=iXpD0ByJe7bp6AgxmmgA6CavCwQ3Y5eg9UfaU1l00wE+EX1IuofqlSAfEO5D00Oy5JCUiH2z3vps3gsaVyTDN3hkClPBdGzkpRXvjUPxyFIEVprk+E8g3aOFoh8c/8/Qb/2S7wWw4yLweIYcTcyeSA+hffGvCoJVs2vw4zQBmvKCEqXFF8p+L0X50uIQ4HL7D3PPg7pCdLjlYQLvRaL3LYwou0ZHWwyd59r7g4UDDUi1pH6KWbI6eMCppJwjyq61AFM3bTHP/S5DwFVVTDDdg383W5SVCY1X2tVm2B/tnut3eq2HmkabewPlcrX3dOxieRlLyYGFg7UyTHEjxWQ7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EUMKxtFG4eC57YbwRauMZx/mNVuy0bj2lF9pjx/LF8=;
 b=AxhM6fGes/XFwACRkzdI2jGkiDsYrmHVbyI+bLP6ex6XzweEba4D8AdfxxilsYql1aS6BKgUHUDORzKWM9waiQjFSI5IsC/6g83YJXBoEO1IUBW0uV4QXo0WSeTQWIRaa7oshteCCzybafq2oWuDwSnXDN2QwK7CCi/5EuyCY7w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5094.namprd10.prod.outlook.com (2603:10b6:408:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 22:43:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:43:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>, Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
Thread-Topic: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
Thread-Index: AQHZssdRahirD7+pPUW0IQejq+CcU6+zL6gAgABjxQCAAANfAIAAA4eA
Date:   Mon, 10 Jul 2023 22:43:38 +0000
Message-ID: <B94C13E5-D84F-4BF7-A559-4E701B0AFA6D@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
 <168894969894.8939.6993305724636717703@noble.neil.brown.name>
 <ZKwwFNeTw60Wuo+K@manet.1015granger.net>
 <168902752676.8939.10101566412527206148@noble.neil.brown.name>
 <a85a38468bf0af2f5cb38df2e1c20a8baa0bac6b.camel@redhat.com>
In-Reply-To: <a85a38468bf0af2f5cb38df2e1c20a8baa0bac6b.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5094:EE_
x-ms-office365-filtering-correlation-id: 84239c91-57a2-4e71-e4b2-08db81971a66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIWMRjJuAg9S8dx1ikZtSyhBi9U9JSMYAyLqBsRL0CbIodfxgofkA2AZbytU6IyX18hvizUKtkRvGbyiteEFgRoM0d0R+Jwaw2hAK8ctbi7d6OSxC2m0PysqLbhVZoTzq8ucQXB+Kauv/5hLAUhtMCxxVxdvdSqE9KwyhC4LV3jSYbAOLc1TWJzxcVJgvWmEsDXmSrCnfbN/JSE6ZzRpDe7cKWZav7d0eVBoZY1+oaLToF3AzijkG17NvgjtuB4MsUvY+B9O/k8ePWhJ89iimLTgoJkbygU7TEGQvD0PZY8sPtoBN6/weJQSkzHKllafl3xhnTY2vbfOLWyhVBhZD6CEYd7iqJp7/9v3CyRXVVxu97/ewlGsJDD/rvKT+JKXFH6gsotkTcxCN6jL9tP/PjYu0un/ELgWW8/pS9ARErd4B2Mlz+uhAMIojB4Xue3LzJyaycDswHTFK40sZvbuu3JqXgLqgHpirZiKDGOh1Oeznjar3iaPEY9OjKDI5RuedmLwtrcgyFudELtu+rxAPjfY2t0OFwvAKFH/wwRqdHgWNptA8J7FOAq9jKNVhghzuPuljR1x25/fN6ufEIy/R6Nx/3j/Gh9DEYQaU4PaQJod4kV0F3fBsjYYt52JfAQzT6u28LF0P1b6OpRfDVvyow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(38100700002)(122000001)(86362001)(66556008)(54906003)(110136005)(64756008)(4326008)(2906002)(4744005)(316002)(5660300002)(41300700001)(66476007)(38070700005)(66446008)(66946007)(76116006)(91956017)(83380400001)(2616005)(36756003)(26005)(186003)(6512007)(478600001)(53546011)(6506007)(8676002)(966005)(33656002)(6486002)(8936002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lDJHYjcImEnMEgzfMcbSOFVGfynwMWfQYt07R4ajS59NEWO8zYSyqU4sTLm2?=
 =?us-ascii?Q?7wC9AIqZdB4PSpy8m7JzcROPFMlVgXiu+BZPdAMJChQvSJIlTWO2rK0O6IAX?=
 =?us-ascii?Q?6Gtiq/le/S3ab5mfklHQxgUd5IhDjdz8sD8yku/5jxHpLyTGtOupsOkQu0T1?=
 =?us-ascii?Q?b0/WDmtDLgnQibgO2zoeoEcnF/BLXq/rdtkxZRvwA5T14hqUaXEBZbdFvbNH?=
 =?us-ascii?Q?scz2i7G+1xpdJlNImQgvaAwPqzH2WreRlvTKRmsjMMPi/PQOTZTKFnODkUee?=
 =?us-ascii?Q?cQXihKcY5AmmpukdXS9yt4Nu0qYEdTMOMGKSgHHBC16Rg+nFtMIJwc00V7kd?=
 =?us-ascii?Q?qatV3K8XMAFJyU+f5tXThDc710u2dHTl/+yn5ER/Q/Cw7TbhuCfmlgs/dPww?=
 =?us-ascii?Q?RaGq+p4ok8PkaMR959MZ+2uZXpsSHlHnZPl1LVml0Uzr5RYQWknfIvEvaZ2h?=
 =?us-ascii?Q?gxUY2ZNGhmkq6U+ZSxA90IfqDaHnBs5ZjuKxfjaGipLbB0pULStm2WlxvTGV?=
 =?us-ascii?Q?ZQrbrwig39jEOWrclTp5FAVlkKkubZwDL9vWoo1d4fGWQ2TyBzLjpPhmMTFY?=
 =?us-ascii?Q?7fptF0Z7AaBHQny43WvyCFoAkzD1+4ZcgPYzihYFJoCSw4/TaCg1C+Z4g1tU?=
 =?us-ascii?Q?b8DHOQN80ItywFC/nbsJ47jtBNUUXTAEydv5q5FSREtsAzWgvugiSQm8Sz2n?=
 =?us-ascii?Q?CgOBVpTcXkTtSivgqrlqVvRYxOlq5UVm3VJKxFH0FRRqP3ChUn16sGxuCw5P?=
 =?us-ascii?Q?4es+is4gsYEzO5KjGEWRt3PYTk+Eehip5mkiYe9A+Lv82zoT6VsChcz+YtFX?=
 =?us-ascii?Q?QwHmLdwJWJ3JD0RAEHapoRLIwCJ9CepCTOeiykZRcV2eP/2iO7KHH0U683AT?=
 =?us-ascii?Q?TOyH1a8YWYkdWO6WbXwSp2h4KY0Z1M7sLY8qmvC3ov1JsKbda3/SA4kyjHGl?=
 =?us-ascii?Q?6P4m3gxq2QfWsYospgLvLiLRhcBZqq3DB2LbAXlvfAq/to0BLvGIabxmnoQc?=
 =?us-ascii?Q?LjrEjVRjNnxrZ9srqH3xUTGYxly0x8m+mHdn9jzbMMdS4xPtn1kNOmQGJ8g9?=
 =?us-ascii?Q?OgW/tQtKUW/XO0iKzNaU5gpIkSLRapS+USHMpXRZSo4KcmzsaadaqYAHjS9d?=
 =?us-ascii?Q?O6yrmdaPmUxCYYIDsixFWzc2vkqTZNy99A5Wp7H5KSoOuaTwiWqPY1hLcnSO?=
 =?us-ascii?Q?h9LChXjQkG0SjECuS8liypxDfN111nItcd4I90DYzn9hvhir7pAz4FqiLgod?=
 =?us-ascii?Q?IEavUJYQ0y7C/yv+8e3aHcYRC+os0IkMeIuBbOLkp1LQCW+w35cHCTqd3YNA?=
 =?us-ascii?Q?1YjHD4jUa0njmiuX5/YAde8n8GCD4/Z+oJ0NUt56a+mJaM85gRy7P1yBFuW5?=
 =?us-ascii?Q?4wDGNm++5c6qRplIxpHYNyQ6eFRiDA5NGT7jZsToSi6F9pjD1WxZqkEhK/j0?=
 =?us-ascii?Q?MEoGiy/6LY/j9KzTLcMJJIaNWU9fTdis5dGPqJUcw8eDYHe8E+552EDCQFUW?=
 =?us-ascii?Q?jqjDuYlkaLZK1EqNcvtcfQlKN0KDOF7vwANdBgmuUnXWzlUAHqbxhyMEAgN2?=
 =?us-ascii?Q?rkAP8EUJZtHYd+2j/6TXUxjcfJQ37P4JreG9fytRXcH5EOM1C+SH45VxZHU+?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5672C52AABEDA34DA2A902E6144D63AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6zyibYkaEmYP81tsVDQigb7XDFaQ3kHpvtzMHrRy5w2bBX8ql5PLamOzyHOADmjzDT7sp4IoNJVyAD3dmnjcm5sdZWSd3qjzeiA40N//AXwrMBNQOLldBK3FaZsM0L+UbSb+kbQ58DSiu6Bdy3XAjub4rntWOmoQ4CJuZqfahkF7eqpolx/NsYlAdeP4EKCMi9stdJfrrM9aKpa31oz/O9tzCKYtzGxdr2BBAFSweF8snlu3MD0oUxMyTSp7OxmvOzlRUWJv+XXX/E0/RRYVQ7MtbutnSGFct/6QFZvztDRbF+kF2/BwLPFP/DdvhGZX4W3sltpSLm3h0uG2Nwt4MIHnIWXq9e75jL8sAjDfqm2e56/PpaTjBEt1cAGFQuqfuSjRZk3cXY7UFEmL8R7ZJI1Vt+CtwW8N2ExA6bAIUWn9+UvviLLhbAiAXoTRIWVa4JAT3gDmf8mqtW6riStJZRGQZY1EEmBJdIznzrDiszvUv2BWG94ZOxwfbftvmFUcW19I2PfPCbNzYYOY5nh3352NSRuW3SNMuuazLaShYSpLiEqQWKqcUgd3nCHVJJ1snabnsHrz5GujxgcFXuBKOjvNajwurqDXxifHX//soxNex5QY4fvBO8xE+6xsnsKV7vcsON2Lq6UTxT5uHOu2YyJesFxN4TkAFyzPctQrj28Mi7WffQVr6lNNX00oBl+lorA7sdDR3p98gHD+zYUgiNNI9v6OAapT59CrZPRI+SwKMp/K538AGmnSRGwdJcXaUQ+BnBnruRl9y9MP3tTW6ZihpKiCcaidM+f1FqLKo/ZLDOZ5BJftYhw97ZF4rsvTl7LOpaRPnkL08GsGduLNOzSi8HpNXX/Fnz8DLTC9InMMornrb4YC9/KI+Mp/n4/j
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84239c91-57a2-4e71-e4b2-08db81971a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 22:43:38.6058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u72NVaiRQ+MK/C7ILvOaGoTT2lzfqpTVTCwiiIVY1IVaQhMQWePoqDY18A0N6UD+Lc3xxGluiMG+eSaZ/y1Uyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=565
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100206
X-Proofpoint-GUID: G2GXDVMnLDepmEOgSoe6xaK8QDwR8VC1
X-Proofpoint-ORIG-GUID: G2GXDVMnLDepmEOgSoe6xaK8QDwR8VC1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 10, 2023, at 6:30 PM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Tue, 2023-07-11 at 08:18 +1000, NeilBrown wrote:
>> On Tue, 11 Jul 2023, Chuck Lever wrote:
>>>=20
>>> Actually... Lorenzo reminded me that we need to retain a mechanism
>>> that can iterate through all the threads in a pool. The xarray
>>> replaces the "all_threads" list in this regard.
>>>=20
>>=20
>> For what purpose?
>>=20
>=20
> He's working on a project to add a rpc status procfile which shows in-
> flight requests:
>=20
>    https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366

Essentially, we want a lightweight mechanism for detecting
unresponsive nfsd threads.


--
Chuck Lever


