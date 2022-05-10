Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB67522594
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 22:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiEJUiU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiEJUiS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 16:38:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF56AA5E
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 13:38:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AKa6vw024483;
        Tue, 10 May 2022 20:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UBbOqFP33KOJy9p8ioytp5aNPR3cev66CA0gkfFF9AM=;
 b=fTIYqlOqXpikr+DTgmWUKkzwXPpFvqs31FPQImxGA3HERV66lnsCJ8OcVvlqrFXyxrgJ
 pYHUvm6d/Uch5UqdaIO4l7WpTYr3wTqRUQQkc++Hs+G7nRt5PAhOtCfErA8VwNeE12Y1
 7J0Ted8S53SNuQskSxNambtX5RphyFSmGZwVZq1eTdOt6fj905CYcjcm8mgHKQP7pSaJ
 h95t+rd5vcsLa2WJwix0A94PJpFvFwY2PJcf0UEP7ug2WQScnnosQN2J2eD/rtvB9vwF
 2ONdCNCK3ODKJeA1wAfUBERMkfBCom2c27JhFmmyhwsnMY0pbgr9M3V2uvQud3P/pK3O uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2fy9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 20:38:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AKL16k008227;
        Tue, 10 May 2022 20:38:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6dytp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 20:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSq0A6TAblE5+fFWrJuNY6ZsxwWSTBba/15NmejwIZ0DWDFogv5L9JPlpdmmP5ryGmpE3yXJtYEWTiGFcnzR8rvM52T9ux8MckmlJi2F0RXpKCCwdul1Ipq5IrMgE4w2cGFRbxsY7C4+uSc8uw9Ch0+vgYSRRHK/dB2M35GYVUZkiOXjd1pwBGdAzy+VYFOwx7fkl0p4NpG1MebykMGQq/kXIIrt+8Owt6xjaDm9hcCRsbUimg7gL5MhxXg+l2dFEUnfuxfWe2PsygpNnjLNQaC1Il2f/1NbHWE0azDT5NBXjVgEYeeNE1glkDEIo4/KNIOtrNZ/ZCUbYzDfaa/8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBbOqFP33KOJy9p8ioytp5aNPR3cev66CA0gkfFF9AM=;
 b=jb9WpTC7YPgZAhNLYa7cnn6ONMEVY3cPFNYB6dK0Fn32R3XmQkJuQA5TE5KTieEfw4yGcaWDUgflh3DxzJtOaqwlYTXG5QqhCVu1gDEsjL1oWhZH2NoPkioD5TdTh7Vx9cvYS38OLYf/ogamLc9Vp/BcWEzScRijvO5+0ePUrEOjLzwLyZRz0KBKwumobxwodcTYdSdblVrLS4Lz5RSFSrMkzWHkQmPj/fzF5DbUYUF5RV8w/TvjK3t8WKy8hd1CvA1iEnCjaGTOUFkZZcLvwCurHM2TUQIF6u+w5MqBLyrWeDXhCANF04DnbMau/P/WNFVcicAhYbcVNiQprdY2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBbOqFP33KOJy9p8ioytp5aNPR3cev66CA0gkfFF9AM=;
 b=rIkTHu99sRn/zA9hQmBKMro/3PHaV32HSOMWixtt3KcWb2hcpIxIuQF6DG6Q1IQV0zLzBxPs0l7ZuAqR0YLPQyfP4pinWfveHUtiTqY3shKXfGVghH1h7ntNO1JLgJPTW6HtnRs5+LDT3fQc2gfDUcVsgsu6TtPKg4m1IAbhCfQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2835.namprd10.prod.outlook.com (2603:10b6:208:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 20:37:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 20:37:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Richard Weinberger <richard@nod.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        david <david@sigma-star.at>, Bruce Fields <bfields@fieldses.org>,
        "luis.turcitu@appsbroker.com" <luis.turcitu@appsbroker.com>,
        "david.young@appsbroker.com" <david.young@appsbroker.com>,
        "david.oberhollenzer@sigma-star.at" 
        <david.oberhollenzer@sigma-star.at>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "chris.chilvers@appsbroker.com" <chris.chilvers@appsbroker.com>
Subject: Re: [PATCH 1/5] Implement reexport helper library
Thread-Topic: [PATCH 1/5] Implement reexport helper library
Thread-Index: AQHYXgHgoneWG2g3iEC82B/y61YHaq0YKM4AgAAEiICAAARAAIAAA7gAgABh+QCAAAhdAA==
Date:   Tue, 10 May 2022 20:37:56 +0000
Message-ID: <128C7052-23B7-46EA-AAF6-A914F036284A@oracle.com>
References: <20220502085045.13038-1-richard@nod.at>
 <20220502085045.13038-2-richard@nod.at>
 <f4ae288c-b7f3-25fe-ef08-7b37256771bb@redhat.com>
 <1A6F1763-C95B-4678-B622-6D3300AF087E@oracle.com>
 <fe2ecc50-4036-2922-28d6-e2f139408961@redhat.com>
 <650BB9E2-7CBD-4A38-92AD-C2AC82DDBD8C@oracle.com>
 <8d8c0e43-5607-ca9b-d21e-b7599c5d7186@redhat.com>
In-Reply-To: <8d8c0e43-5607-ca9b-d21e-b7599c5d7186@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 676fcfed-7566-4a4e-95fe-08da32c4f74b
x-ms-traffictypediagnostic: BL0PR10MB2835:EE_
x-microsoft-antispam-prvs: <BL0PR10MB283570E492F303BA758C3B9893C99@BL0PR10MB2835.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uv1z0i3xWWMT0PXfwKhBPCbVcjk+i1XpHoCnJHQ3xXOGc2cAmTm/qvnqDKolz8Y6M90l/C/nLx79hKlwZsxvYaCAxv3vTQdUgQXvknn41+QiWcqHjW/Br3hRF48avX0peWVCFKJijfW4ujbjIcJvJmMoNm+6UPbRWcZJvTndk4lCKZaej4ZIxIRZ5/CnIFMFkmdDZ2dYRaBs5RYSfdYjUICAhSV5b1OYnelYO7s1mdAaCDvYDhnA+t9lhd2p8WZ/9Tvrw5hcmKW8dErgvxTgzX6sDmbtMDPGcH1J/NQOJTDRvFM1s4JV5oxTWE+1UTMA/+i34Ll7ZcApfBbOqXncEDMPwtvbzqMYonE2HCFrAB2VhLe8B9AZxeQfbn2930U3BRTG+qQ8I+/5YIX/Qsv0oOSTupUZ0vZiCRnEyuPtg1kKxZibIfFMThkBIlxdvRjOo5Q53RjwiEn3sFt1idPTQSk9yYsEjqVhXtVXR7J/0bbZkQyKss5P+gXKzWpsV4zf6p6zpuiBByEeSaHtp+4xzGnxQMC7JSK1V0O6jB1JJwN5wSwcQfx7ipcqUqkfCH8lmMsXFKQauTib2uqq8YKgaAcp79fxNorj6Zf+6CoydID3aLRZMgPro9QH/V3Vw3nkqI8Q0BjnzFTHFDSpLqFNYGqXRK70A+Qb57HzsNtQPvRK01x1pu9+ty6GNZzvbMXO0LSlQOH6QyY1wO/m3o1u5oa6XCUJgwDtH1Kma79qzuuOlXQ4HNb90YpJlKSmwqeOJk3yi/C2nDnxq9xXgaLN6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(33656002)(508600001)(83380400001)(26005)(2616005)(6512007)(2906002)(36756003)(86362001)(8936002)(122000001)(7416002)(71200400001)(38070700005)(38100700002)(5660300002)(6486002)(76116006)(91956017)(66446008)(66476007)(64756008)(54906003)(66556008)(6916009)(66946007)(8676002)(4326008)(316002)(6506007)(53546011)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lYMjHvjrq0aP81uptn5IiXFtIJ7faTOF96oixjEaSWOgGoiJE2yRNZEdoJ+6?=
 =?us-ascii?Q?7ZHLsPPXGDBsVYpnf6FdjvH2hv1DrtzDPbrnfMw7fqqxGlj7SnU09sktOG9s?=
 =?us-ascii?Q?bakxZkkee/sz6eH4srqt+nOpxvqiA9U1Cih43B3Yk5IodNR6Zhj5CQmb4hFN?=
 =?us-ascii?Q?ReFailo0mkNehZCIJngZn0tTAymM5IBkVj4qg4iWmP8F5/OurFgFkYfqVIkN?=
 =?us-ascii?Q?RrGQQjFDBq/seP1xVnPwc7jshtK6HbwAZZOzucEXKYsfO/orSZvYawW8nPL4?=
 =?us-ascii?Q?7OacHPQjJHshA/V8Na/HOXA3AdhVujGnC3wgNtNHlBSDYW3fK6zkkiIh+WST?=
 =?us-ascii?Q?4aHyb+it17KPTcNeU2fpXo9a87zunM2jbJqeTwjiAZcwe3bCrpGgEr71J5xH?=
 =?us-ascii?Q?+dl0x4yoBDBfD6CwPQPk7SB6QAMgJ4JeJJUfOcpGsUEV67XF1mDBCp9hEYom?=
 =?us-ascii?Q?rCA56VBTkdL47pLqRk5UaSsCUxFGJbKVHYTEVqEVgziHyDEVli97LBhkPQzo?=
 =?us-ascii?Q?si1uccXy+R5wJ1jlTwl/jjHvQAfzEv1BEukk5QVIsJH0PHcbdcuHU3KMQ+WT?=
 =?us-ascii?Q?2ICXsL1OG7jzUy6ZybsRuvMe2EKIAp+I6ChQNTa0lAZN65n6VnXdyvUoPyVt?=
 =?us-ascii?Q?qMpUYFmlXw8TXg2oDocsX66p6XV4A/AhyoaXsjXUVmMNNXoQjHMRnBucQmmZ?=
 =?us-ascii?Q?CzTrO1EfIZH4Hor2giFxjEXxvDcN5+ClCuPNOe9OKaaIpfrvdBXQDd4B/2lH?=
 =?us-ascii?Q?wzkpgQOvhvuU6uF7ENogusJGxwAokQHUuI5b44KrUsHMNfidg6zYSRUbVcnP?=
 =?us-ascii?Q?2gZxSQk9x+rSJG5Ee/bMHWt4eHf6v4sZp3cKdUZ/07f0ElrE6bCX8OAsIz0x?=
 =?us-ascii?Q?0QkEY25+mc2cytWC41gmSthM1ef+lAECKvMHCBo81gHwL6P+7mzRW2/cN9aV?=
 =?us-ascii?Q?CAx76JkQxRFkS8/bxbRA1PFbiO5UcrinCATxYgGUoSiMGtJpeF3+cBhDkqcy?=
 =?us-ascii?Q?lu4JJR3yWKTbQhrMX+cZWnVOS6Po2bWXSncbZAnlatxMGBWjOaAtvKZVXrsE?=
 =?us-ascii?Q?ygcZm8rL7FEAXBLxAX7zDo7+VWu2guyR6kS92coA2ZcJ/FpRr9kO+ZT8uxAt?=
 =?us-ascii?Q?M88jvDl/fDuVOpapOHw0IDh/NCVcjPofYsvOsE+E5cVMnZcQczs+li93j7kt?=
 =?us-ascii?Q?GlLrt6ShzaQV24hy53fSzud5lZx9SCKTL/cv4Mydo3LT3e3DQfIISE0bsDxz?=
 =?us-ascii?Q?+aQV6Bg08avEhFddMfPYucpeM/yjt05PBFvnhHmIJ1KnynBagMBoUSlPDDfQ?=
 =?us-ascii?Q?v2zcKPfPETAeexjOxNYYRuD1O1GOEmpwMg7jefAsO+dZldYqV01FzYdcPBlA?=
 =?us-ascii?Q?TPZF/UDKQ9Nox2T2lznNj3pIFNYnbpBcqstjJ5ZlcsOGTPlkj+LnI77Vd6DQ?=
 =?us-ascii?Q?7hCLzinLf6U3rVnGN4HiXK3vRCofIftq37UJIKGk8803tXC+mEOu+LTCeYQo?=
 =?us-ascii?Q?iHSAkw5iYMGUBS361NPstSotXP09bb30jXWR3hJ6rQOS2RPibAQa8SXIFmhH?=
 =?us-ascii?Q?EFKLK7WKDMl2MeB2bAR17QaNL5sLJLPaawRcdHNEIcVXw8+FvWsm5FSXCowr?=
 =?us-ascii?Q?qaaYDR7hlW8odsdoy7oTGCP9LeoCg58FqJEx7ZrbOUC/3ipItWkL4tNMt+9t?=
 =?us-ascii?Q?e1V/uiqW0YwwnF+2C0pdLWcbQdhFuoz+k3IN9gJHEQ6zZAeEHHUinmssRIRT?=
 =?us-ascii?Q?pPB71xwmJgw1pPMX8Zu7MAwj+yImU8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAE4E768AC209D469EC2F8A1AE0D9619@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676fcfed-7566-4a4e-95fe-08da32c4f74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 20:37:56.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYTN1PQ9pKOFS63xux4Yr8YG4KjiIPK1U4Ko9eZ8Fz7/n+6kH/fW8afnFxiMMEWoZzPk2HAEVG07NHhxHHCAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2835
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_06:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100084
X-Proofpoint-ORIG-GUID: knPIeJUgfZx5GqBgG5SvpNuZFNLaJ_gG
X-Proofpoint-GUID: knPIeJUgfZx5GqBgG5SvpNuZFNLaJ_gG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 10, 2022, at 4:08 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
> On 5/10/22 10:17 AM, Chuck Lever III wrote:
>>> On May 10, 2022, at 10:04 AM, Steve Dickson <steved@redhat.com> wrote:
>>>=20
>>> Hey!
>>>=20
>>> On 5/10/22 9:48 AM, Chuck Lever III wrote:
>>>>> On May 10, 2022, at 9:32 AM, Steve Dickson <steved@redhat.com> wrote:
>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> On 5/2/22 4:50 AM, Richard Weinberger wrote:
>>>>>> This internal library contains code that will be used by various
>>>>>> tools within the nfs-utils package to deal better with NFS re-export=
,
>>>>>> especially cross mounts.
>>>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>>>> ---
>>>>>>  configure.ac                 |  12 ++
>>>>>>  support/Makefile.am          |   4 +
>>>>>>  support/reexport/Makefile.am |   6 +
>>>>>>  support/reexport/reexport.c  | 285 ++++++++++++++++++++++++++++++++=
+++
>>>>>>  support/reexport/reexport.h  |  39 +++++
>>>>>>  5 files changed, 346 insertions(+)
>>>>>>  create mode 100644 support/reexport/Makefile.am
>>>>>>  create mode 100644 support/reexport/reexport.c
>>>>>>  create mode 100644 support/reexport/reexport.h
>>>>>> diff --git a/configure.ac b/configure.ac
>>>>>> index 93626d62..86bf8ba9 100644
>>>>>> --- a/configure.ac
>>>>>> +++ b/configure.ac
>>>>>> @@ -274,6 +274,17 @@ AC_ARG_ENABLE(nfsv4server,
>>>>>>  	fi
>>>>>>  	AM_CONDITIONAL(CONFIG_NFSV4SERVER, [test "$enable_nfsv4server" =3D=
 "yes" ])
>>>>>>  +AC_ARG_ENABLE(reexport,
>>>>>> +	[AC_HELP_STRING([--enable-reexport],
>>>>>> +			[enable support for re-exporting NFS mounts  @<:@default=3Dno@:>=
@])],
>>>>>> +	enable_reexport=3D$enableval,
>>>>>> +	enable_reexport=3D"no")
>>>>>> +	if test "$enable_reexport" =3D yes; then
>>>>>> +		AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
>>>>>> +                          [Define this if you want NFS re-export su=
pport compiled in])
>>>>>> +	fi
>>>>>> +	AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" =3D "yes"=
 ])
>>>>>> +
>>>>> To get this moving I'm going to add a --disable-reexport flag
>>>> Hi Steve, no-one has given a reason why disabling support
>>>> for re-exports would be necessary. Therefore, can't this
>>>> switch just be removed?
>>> The precedence has been that we used --disable-XXX flag
>>> a lot in configure.ac... -nfsv4, -nfsv41, etc...
>>> I'm just following along with that.
>> I get that... but no-one has given a technical reason
>> why disabling this code would even be necessary.
> Nobody has see the code yet... :-)
>=20
> There is a lot of churn in these patch.
>=20
>>> Yes, at this point, nobody is asking to turn it off but
>>> in future somebody may want to... due some security hole
>>> or just make the footprint of the package smaller.
>> I'll bite. What is the added footprint of this patch
>> series? I didn't think there was a new library dependency
>> or anything like that...
> Well mountd is now using an database and there
> is a static reexport lib that a number daemons
> and command like with...

nfs-utils already depends on sqlite for the nfsd
cltrack stuff, so I don't really see an additional
dependency for nfs-utils there.

However, there is a configure.ac switch that says
if there's no sqlite in the build environment,
then nfsdcltrack is entirely disabled. I guess
the build environment needs to deal correctly
with that situation and re-export support.


--
Chuck Lever



