Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F17E75FD
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 01:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjKJAhy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 19:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJAhy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 19:37:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA31D5B
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 16:37:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MY1pX022414;
        Fri, 10 Nov 2023 00:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=il4tNM80IyQwaOfSaivJQh1goTYlC/kAH5489qdfi+o=;
 b=QA4I4QkQ277Ls/I6WPop0zkCj3zzBjwCAoVE4H6vcSJm2z0z+hKQZ2b5MNsIJpahZiVK
 3IJSvHOuPEecsBUrJM2Vyk/iLFyy9Jm9BYxHVjZBpvQRwyrLGfdR3PaQ29/9P9XUQCnP
 Z67uRV5fBm/2x7e8Uay38WYW3MYc97eDY1/8+Owu6xXYLk8BcwtRa5kDLEInddD2epwB
 gbJNnM+QA4KPR9Y8i+GIyfcvituyQedMR8Pes18ZBw9O61UYCMH1i4VSTioSz9lkvJEX
 YNKoBp8AEPTEpvOXaSDkyTiC5ibxoV1EAgAEzuntWU2hJdcuoD5lxHqKCtEZyiPSjK5b 2w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w215d7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 00:37:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA045KS017608;
        Fri, 10 Nov 2023 00:37:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c015whp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 00:37:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h07KvAb/MZwOT2QabReeMNbunsxIoC9tMZ/tsFwUxfLVQGCEieCOwmArQKCM7RjIdeJEshgczxZ3m3a7icPT32yhEKsZAMVSAEbyyBjIp8M7AXtPpq9G5njt6GqA54Hh4t0EG/DXRHzx3Q5t/DAayKOOPQDpCXbkdM4dAJGJS3tVCS1fZel5VZqDXB168USF0noJP2UnX0r+Sd8A7+MWQaw66evweBRly7wjnm7ZWuzks5uPsIt+2YaERAxTKkfXVrCO8RJ+WRMkERHShKlVPAEtpWCmnNOfh2XIs3VeDQdkY73SY03IcxowLmFJjetsJ1sN1gXDeA+h+n5VxEbMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il4tNM80IyQwaOfSaivJQh1goTYlC/kAH5489qdfi+o=;
 b=MtQTDbIX98cbs7cxlGZ9WKNpf/QvyuRLlDDTb4j1uRVLXtrePoabrxZMEd7Vuxm7VfLpbxNfxjvTFab1uruty9y+E2gUNhn7Q6XsgPWyg+B/FmwNheo/LcuApfQyPP+wWr/VzSlMxYrqMDaS/wiE8QzCtRX+K6luHaSnXvneRR4plPKIlNMC4Epxi2a1PPpSc7LT+pSoZMwM9aODJA7b4mIaweHMJdnV7cMhxE9dHlbDOM7LIGi94+RVDE4TaSKKLwJWAzosPay3QvDnFvwjObBtvy7VwaeUQZ3Mf4DStYNkObdGmYI54pAH893aIoFdNHZF50hm9Huqbjz8J3oytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il4tNM80IyQwaOfSaivJQh1goTYlC/kAH5489qdfi+o=;
 b=T8F8wR/d4LsvhLKxXI4fyNJ507xxPZ4jrv0qW/lU2DWCF7Cu3eyt8FN4NRdDha/ywErAqX8d+rjZBOLktMq+ZhsAvPoGIj0IZzauvLXEoY+E9HQCDIg8FA+gDiKVhq+jxM9eamKHYIHcPD02AJcclgNslhM4wllOF8aclk83164=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH8PR10MB6645.namprd10.prod.outlook.com (2603:10b6:510:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 00:37:47 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::22b7:a093:4235:b27e]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::22b7:a093:4235:b27e%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 00:37:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Cedric Blancher <cedric.blancher@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Topic: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Index: AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gA=
Date:   Fri, 10 Nov 2023 00:37:47 +0000
Message-ID: <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
In-Reply-To: <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|PH8PR10MB6645:EE_
x-ms-office365-filtering-correlation-id: 7920279c-d0bc-415b-4cc0-08dbe18542d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2OsGHys5a1HIQMpZGO5O08ig+22mE963n2OWIxLkfBy64lfEECKkgAUDna1ajRQZRN9Nh05uBYHlHXSEULzbHB5K61N8T+B2AxwPpr7jg0GbpKXlTTFKbDrBGqip7J2ahkqiyT7XVwhWalkTw73NOecNvIH3GRqZfw+y0GDPyiNRQIgmVde4y/FQ4Ez+3Ca7Hxn4IpGb8pwqdv9XO+brhnlmVcHzlycOlGKvZJgYg32Ts5ADMxeNXUGB7yfKRrSJ5xUHkg629IGXj/ai7A/WwUaMn2NEICtKndhuAYfRd0cYJA/Y18ODsvSAARgu9sTX20eqp5m8BTdJ4yk6Az8RHb+m54NiOWpulRH0wcBI08nIbEbC+Yl0y5GtJ9mVlC6ED8owHK6S88ziYD18sYt7N8wy9c1mv2Dj85fQ6GXW5my32/FalF0CqTu+2Z6lFgd+rV7TIyyg49Nagvsm4kQbkdlPrlr3IJ2p/BLwRGuftngqckGv9G1yrOgiHmBd5Tjxcx2Ym2DUG+mHaJ8WiP2gsanBZSfAyJrqq5HBYZTP+8z0OweEBiJcEe7DATVJ3f6vobXO0mt4ENGJrNhI9IsqezrAWbkBhkEPfSefDetlBLAmsW4Js2iEDQG1hw6fZggeq2KSaY9GAZbXQw6L1qvxDFjdScdofSc2ZRJkYzXhXMTFugOCK87C5+aH0eNNTqu3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(86362001)(33656002)(36756003)(38070700009)(122000001)(38100700002)(8936002)(8676002)(4326008)(2906002)(6512007)(2616005)(6486002)(41300700001)(91956017)(478600001)(6916009)(66556008)(66446008)(66476007)(316002)(66946007)(64756008)(76116006)(5660300002)(53546011)(6506007)(4744005)(71200400001)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7lPCo2Cf/2zlUpxmEj8GzN4oQui/vYYz48r3XitRzbIknhNAt2JsAlKr3qOe?=
 =?us-ascii?Q?KolXnnKnB/JoLhiKIKw/d46M1bsQ6rjM6USMLnlaCkkwmrqusbOrskprqVZ/?=
 =?us-ascii?Q?Qg5y6m2uCxSjQlL+QCmk5O8prIEFhRcYgh7ZqrMDB5E2BDeLcjkzivZv9u5H?=
 =?us-ascii?Q?MV1j43av4gc62uQUnduvFOmL5ccCJHTJo617wQP6l3mklQvTDX2O5qM9BPia?=
 =?us-ascii?Q?M4cbrrweoCRfENU66WP7Jjx0ZoZEn1QOTpWmOI5tI/ldsQcRVIAiCwypaqul?=
 =?us-ascii?Q?0+DOhUsyFCjhejFxFsD+bVUgfHTswMxpFu/CuA6/8C92As8epMSvRY+i8CXj?=
 =?us-ascii?Q?b/9LjI65jaf5Xt8BjoJ01vmSFI60Z565kZ2WGw5cYrO3Fw7w2gFhBgkMPi2m?=
 =?us-ascii?Q?+rG83HjIFPRWY4X+qxlAL9AN13GKm0YHn+fMULBdtkjNdSQYa/d1nHinJ7Ty?=
 =?us-ascii?Q?9NoXe9Ec9Gu0CEal5SE17focII5ODrAJRFN8SijJa2OSV8Y6BwrdL5xtH2Cb?=
 =?us-ascii?Q?LgcAiHJGXxEHTACtRV9glu9O+CRBIp5EekbZXHqRJT3sKsJyxBOoXLzRYaOW?=
 =?us-ascii?Q?yr4aCjOt+C67gJCLzW/QSTep0I/4FeZa4PSjqnkL4mQxUoA0YgM8iYr4V6HU?=
 =?us-ascii?Q?M3SxoPTaOWEOIfKNivbiaT21hrNwm98VX/FYrLhAwnNEKzVyc6iADFN/sQx3?=
 =?us-ascii?Q?dphzKRu55I5nXMBKfR+NHe2ANKBHDoyLlCkNBy/b9Jt+wivQsZ49txAbto9p?=
 =?us-ascii?Q?IrrVWwR2MR2FmcyPGWGL5B6R5NtvmOX1nOv+Dm1mFLY/pJPygzpnontlmxdo?=
 =?us-ascii?Q?KbZpPROAtewTSr79wV0c8sx06xtGGWXAW0V3r21gLDc/00Uavh1RF8Kwekqa?=
 =?us-ascii?Q?ESvweWO0DZ05xdD99Y1vGPs7PDwbEKBiDaDzBfAn9OvG2YM76asxgKBRZLQf?=
 =?us-ascii?Q?1sNhrewqkl7pd0h1RHqGOf/IMLmAY2GWBhOoL+GvHGm4KRIid01JUBDNbvmy?=
 =?us-ascii?Q?shLW1IqrNrt48dLqzrDKkyDWkMv7ju5w1aHyEN7n2Bo96mXVv6bVFcxHTgWf?=
 =?us-ascii?Q?8+QQAxQOcKGapIYEyc/JR62bK6C++NygUgMYx1QrkpokZf5ms9riQdxFWPBy?=
 =?us-ascii?Q?MYT9sYfNuppcHyRffFI9skLzZw4GGfkfhPnpnfcOnSpxC2oRtD2EcERl4PZj?=
 =?us-ascii?Q?VH54XSdZ8U6mH+ks4A4L6tMnrw3z2zmna0C+nmEI4D58iTWzk1nhfS6v5Tez?=
 =?us-ascii?Q?+aKrtF3haoUdATvyFJMdfQla86logURYgnKxTmo0v1LK0ufBp4nQMlI2V59F?=
 =?us-ascii?Q?LCedGhzpeh1akkn+OEDVSVwM9YeQKqR/AkrZy6qDAu8sG7Ef9BXrmJdLwrxA?=
 =?us-ascii?Q?+fZgieRQzrl94/ljkQL/hp75R3duulJ2fcL1oIqjoNsMAn415Y90xKoV9Xjz?=
 =?us-ascii?Q?FBlroHSBiTb/LJk49mrSL7bPHCCjTGz+NbRBeOFCBEya/g/17nIt1JCWfbfx?=
 =?us-ascii?Q?+4ZH7pBvprSD10sDi1obGNcER2wTtl1V37u/cD59Gn2NU7egeqLoShBP6xd4?=
 =?us-ascii?Q?MBc323tvHJLNtPDDQ3Ct8Lj8ZlyLtlQCg87Bn3e+ocKwxlPyxgJqLEBulO3E?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65F70BCD472FFF4DB099F35B1DF3ADF9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BqwGDDIR54FGOrSIVPkjdLXmHBb+YBLqsGDisv8d2xHes2FL37ujbssq/LRs2ZIwMZ+MNwpz+gIglKT+I1PKwhNEn5id/qtOnUgZYdHDqskYnXZcX1McTGSv1qiQJadc4Cq97x9KWcmdkGvNMzv7R+c9+M0oCk2R4xz0M8h9oaCW2Eh3RpRgcnFswtm9J651bCZiv/Nl/EvusY4F3TGpLr72BoxNaby3Eq8+UbdWEHgnWkitlemR4pUEDDEGWBfdqRObmVxKnQpG+c+8Jdy5HOdztug0fmq0DCygP3wh2gqZp0tjdavaK/dOPP4xZ8D+hl9zuZqfDsh34jc42gboEiubHdJAfcxJiQWkwsrEYjVeuMY0o55g6g0MXG+ozkWcQ5CdwBOKGvIGuxmtLBSyTNl2oWAWmQICpLxYwRBrLXH/fV2TqQvKGWNXsO9x48MNgKo7+GQqXssTlhXn8L1OgZyjebUHXSXoBXhxLT7LLDD4STq4q+cNoQwJIeL76M8r9qHPmLaVew7TF97NbZXXQyC/Iqjzw51YKS7RmnXG0lxFHxGa1GV5zyD1PEqi+4ShBFo3tQH0AT3ZRxKEHqw6a/q56hxFWS0K0tJL46TC/SgU5cdPWvg6+xcg+BiHYJ9eplWRWOXFbZbjlVcF0k0t/UAtqnTU161PsugmYU5JwjA4P8NUioq+FGNh0ZHrqgkTNGsD4PqgMmFXHvXuNNm1qbDNfbeBIb7KFd25S+T9yvpDmTVgod4xJSNq/MkpLtgBGMgzVHfkO5IWorOOQ+gARfH6RrkXHesJ+TK5wh/oGGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7920279c-d0bc-415b-4cc0-08dbe18542d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 00:37:47.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouCLyDrEIcgnD4o7+N3EFJdLxyqCwa77FjHZ1GvPggpfRtmOq5ZMGoJNWS7BMMOvVGFnBchSz7Hquioo5YHMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100003
X-Proofpoint-GUID: vkU-486m5SKqdTTixB0iLG2MxaOGzLTu
X-Proofpoint-ORIG-GUID: vkU-486m5SKqdTTixB0iLG2MxaOGzLTu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.com> w=
rote:
>=20
> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com> =
wrote:
>>=20
>> Good morning!
>>=20
>> Does anyone have examples of how to use the refer=3D option in /etc/expo=
rts?
>=20
> Short answer:
> To redirect an NFS mount from local machine /ref/baguette to
> /export/home/baguette on host 134.49.22.111 add this to Linux
> /etc/exports:
>=20
> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
>=20
> This is basically an exports(5) manpage bug, which does not provide
> ANY examples.

That's because setting up a referral this way is deprecated. The
preferred way to do it is to use nfsref(8).


> Plus, /ref must not be a dir controlled by the automounter, or a Linux
> 6.6 kernel will panic

Can you open a bug report at bugzilla.linux-nfs.org <http://bugzilla.linux-=
nfs.org/> (product "kernel"
component "server") and provide the details of the panic?


--
Chuck Lever


