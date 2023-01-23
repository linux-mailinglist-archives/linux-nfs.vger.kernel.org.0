Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F14678106
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjAWQL4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 11:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWQLx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 11:11:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2369D1041A
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 08:11:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NEhl8D030026;
        Mon, 23 Jan 2023 16:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Qv61WL25jmRIjltQtWGzNeXFsE2CTsopXt7d/VpQb5c=;
 b=sFUrgQUyP91jVGMveoPMr105w68Hxvlk57V9xvP1PYT4xgiF1vEZOLuSraasukvUaakb
 e3YuwTEAywgdx5SrIDqhvw8VDv18k5TRuTt6qda3D2zcFUQDOPeXJoYYCb4xkG4S240q
 m4Yf7ADlQxpxNihyLd5LvR2BvqLUWN/ZYe6CNY9cxZdsAHsM3PnZ704A4pgzGx7mJYT4
 gyP4eHn8m+koi70hB9YoP1AkhArMIPYBiskcmf5FMW5iUNUUgN7ZMMhnsdE3+cUPDcfo
 6dMofL6iOJIvFgEePGjekLoOGXcDiDYrNADZFegQe+TE20mGoAye96f8L29P7yeAFfA6 tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktu2ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 16:11:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NG3V2n040249;
        Mon, 23 Jan 2023 16:11:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gagm7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 16:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io5qpJb6tPvoXLDrsHHdS3lkHVlMtb5g7WbHmZoiXjxvALm7lSSWcZ8I9dk1L3Qd2Jvv4/T2CmFxfLTL2VzXNFCF+4pCvrfJxlPuU4Xe2BQjnizYY2jXq3r6SyurDyQcqmgya+PqnUBEyMg+fCs7PXQj5plVKQtB49WcWuo3r4xA0FND4MmHuvfvE1hC6LKL+69H3E2ZTbv/AyMdM47BaY+VaMRfgLXvtK9oafr7QJqZYsuz6IJkAS62gdB49vwpLwQJdLXSEMDiO3+aVCkrHmO6i5Qn1y7CI1n3RqIHAa31b0kFLxP5ILoeu4yNCrI8bzJyNfeK7rxs2ujioV4fqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv61WL25jmRIjltQtWGzNeXFsE2CTsopXt7d/VpQb5c=;
 b=ErkIgwFYDUR0BNUVsGX0Wyrd/rDmfXxaAZxRQ5PjG3STr5J8r6emHGpwd4ToFsQj5LDxDHSXnJ/2vpDc98Qu0j9ucJXX6Z/M9+wjtVRlZS68p7swhBnnyXMnR1IUZjy4oUBgFAt4TKJ41+7saaq64jL8ULWtAmMVeUjbMrXOIEynAuYoK42jpRP1RCgIMF07sViiuuPXSuWGbZ0wpSR/g/8HR0ow5N8O5lSzWz7E5Ceqj/gVjsyd9vLVUGsmzRT1JsAnkVABbtlUPvID1apLtwCuqzS1XpMPoE0YA33POMuntnnxcUOguueqwvWVYhjN2yIDeOyHZfBH/j4BD1yf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv61WL25jmRIjltQtWGzNeXFsE2CTsopXt7d/VpQb5c=;
 b=bnPRZVxRHZwnLgfGP8W2qXo1z8aiLi5CWG4RW7Ho8fMzyWabT8QwWKZdiM7WiINzivSgDdMNZlLwkFmQotioGOI7Dfae6vahLpiRiKNLDml7kxpkgx2jKpNQm6eCfWcw+JHXKuswtJwwT1AMwiLiTVAlqlrc7NGp7nNlAAN86i8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5368.namprd10.prod.outlook.com (2603:10b6:408:12f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Mon, 23 Jan
 2023 16:11:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%6]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 16:11:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Fix sysfs path for the NFSv4 client
 identifier
Thread-Topic: [PATCH] Documentation: Fix sysfs path for the NFSv4 client
 identifier
Thread-Index: AQHY9D/UHAS9TN3bW0a4ulUjeWuAMa42mHuAgHXi6ACAAA+yAIAAFhuAgAABCQA=
Date:   Mon, 23 Jan 2023 16:11:35 +0000
Message-ID: <0429A14B-2065-4B6D-8B48-8535AD05A15A@oracle.com>
References: <20221109133306.167037-1-dwysocha@redhat.com>
 <CC98B38C-2E79-40CE-BD9B-6E336BBD6552@oracle.com>
 <CALF+zO=u2p3BuH1nGt7DMekbRiJZGUuZZRF-D7pGULw5VoMo_A@mail.gmail.com>
 <2817011C-299D-46B4-A8E2-D5EDA9FE1D08@oracle.com>
 <CALF+zOmKL8mDX8HDdVEwijbdHDmeXyKwCC2H2wtE=WrjOYJe3w@mail.gmail.com>
In-Reply-To: <CALF+zOmKL8mDX8HDdVEwijbdHDmeXyKwCC2H2wtE=WrjOYJe3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5368:EE_
x-ms-office365-filtering-correlation-id: 76d941c7-107e-45ac-d7ae-08dafd5c803d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GINQB8LGPWU3HiWqp+9vWzVy2aZOKuilb4NUwpQkGY/g4ALtw64St8MIlMaUyihcAQo5hflY8dXAxOx4qPuVQ7yz1/O1ikbVIw/ZYYXOBLifRzDPqxbON5L2uOfaMEmVUzi9lTtfx+afrrTMz9cM+oliRco3zG+F7ceXAG8AG9bY9BKj2X0LF1l6AgREGUd/YnvE4ecQg1pVeDkjxgYr3XQA5Jc9aievKrMU80/fS8cje3POKI/XYuZ1o/A05Wl5l26pnglANCqs+rN+Sijia0PbLmxiJItJ8upgxdM7Qye2ENT9uLdeHGJ80WaI/GpCWK0Ec0eZm34+HyxGK0aXVQ2/b26tm7srfFe/Jo6RbS5hGh964VbGwvpwwkPwOSUj5OXeNmq2tcrDBdL6+VwJBMPS4vslWLYfaNW/fpR0OPfzQ9gNWfS4Sj3lFTno1jjACiuP3oASMpHaMEb/UoP9mpNty96o9k+i5bVQ3gzmju5pfaB8GqdVkcyuazvvRBMV4rNoa5YVma/3vyFQmaDI7Kr5UaR0HGFUV6fGhueCAjWJiXEfin8+O2pm+KRITGE5IoT6uWBmIxZER0MWmyY1aG4L91r0KiVCYypnakIKR4CJbc65Z3vbzpO+wPDp24+0IcJekv5jpF42roH3dg+0Ja9wZlEvsYsJKofkNL0jUZptB3LEPJnWu7g2x53H4v4KXinLKTOKMjpoKZ/6D7nkZEdj/68Wp60cDg8+e2HjIii/IdaX/RUPNtfQ7PbfsCmIzHh0rlNtEXqYI1bwIycbjbTwpDUYRjMyGy5FGIxSbLdM2UJS6jEtIbsSRJhtdIZ9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(36756003)(41300700001)(86362001)(38070700005)(5660300002)(8936002)(4326008)(2906002)(83380400001)(122000001)(38100700002)(33656002)(966005)(478600001)(91956017)(71200400001)(6486002)(6916009)(26005)(8676002)(53546011)(186003)(6512007)(6506007)(316002)(76116006)(64756008)(2616005)(66446008)(66946007)(54906003)(66476007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XO8pXqxmXeRRGoNUzJZ20hAcVHv3RO6s/NjEZAy2EC/CaD+SjmV5kiRz4iOF?=
 =?us-ascii?Q?Zh+vlHF7X+nW/qfD92Uj38HhG8ukscEt2JYZwm5Kg6wyPqNtZ6kMrcbq5wOk?=
 =?us-ascii?Q?jH5msj/fZKOEsxpGFuSq3kbCEvDR5WFd6aPIepRuFnpIa0Qz5erDTH3f8mEa?=
 =?us-ascii?Q?O8SFCEXtOGe9DvyJFyiuN6mpUEUT0mH+a0lppCNBNOzEKbdSvVMJqcBwlIg2?=
 =?us-ascii?Q?otR2Ya2y6YdqSk7+JHRLFFLkqsnBCO8iWqZD1zHSSlZMevoKTEh7UWQB3Yw6?=
 =?us-ascii?Q?spzae7WDdAWXvhM4V/B7eQWedSLj2zZboMiqLE4cSTL2aScvobqsJRmmydLO?=
 =?us-ascii?Q?FuxEmCfNZWDRe9OY4Dxn5rmCt/IIMtEYTZl2LkgMwf4zrl4J0kdHPQJEYO/Z?=
 =?us-ascii?Q?rH/zxaF1RlLedy1gi3UHCbmYVc/jkwDAqro4dC42+MewCtWUWtgmWVzldnfd?=
 =?us-ascii?Q?nSSurKl1gax42CFQg+EqMMtGy1KFrK7jdB+nRftyX0Y2OLcH76urnKQUgWy1?=
 =?us-ascii?Q?MCCvxcBcErNNjrl2UTDNGAdNceihyYfb5j0n0OW+3BaV6PbvyP73lAr/LkiO?=
 =?us-ascii?Q?qQLnwUnoKc93lHX4LZOFmxnn1G7T6VyyAPaKu8id9AKErCr5QPswOv1bqOWt?=
 =?us-ascii?Q?SSXuz1HjBjogo8yhxq3k5jiH9RPU1fS8eXv6etmdcJ9HO8jxaMKI93krBhHh?=
 =?us-ascii?Q?nlThQcPvS9nDUxpLLnLat02A/a+s795vWUZg837hzJWh+YIFuKqdEJPq9IkO?=
 =?us-ascii?Q?tJTB2gX/2IwzqrnAoRnBT6tVyFeV3CsK0/7bITb1faloDy3RDNVCzjYZ5u9M?=
 =?us-ascii?Q?IvWSiDkeNqS5+Oxt6ezdTnQN/YThiaD9MkGJ0mRTWG2ydP/V8OgtvSJpbQxr?=
 =?us-ascii?Q?dYINqbi4yhQTieIiTXluDpWCqYm1O9k32iJfX4+Z19J2UKNpHMV3cQX13LnO?=
 =?us-ascii?Q?I3x++lGSqSulAdD2tKW1H7gt/nXZRBElo+/I0R17aTlgnm6927cKJYeI5oob?=
 =?us-ascii?Q?IMIQWaeD1HHkKavZ2o5Dssu7hOfQDulx/fOFEoH1p/9VA+8w/4B3vvmAZN/u?=
 =?us-ascii?Q?ACB2nJEhpum5BGk2CHDXao85url49975mdtqZwr+91UbtVsPHp+qfUJxVvrK?=
 =?us-ascii?Q?Dj5e/hUM2vxFKPkkODl7vCB1Oc0eW/VikldnvP9KW32mR4L5lXLdiee+YKNo?=
 =?us-ascii?Q?P9rlmKHu89sGmXnxmpIpB88ZH95MyASZwGVUWjCrFpWwZBF3WD9qam9LiZFF?=
 =?us-ascii?Q?BLYtqsg+u/WKfPMidLSWbXXJRboAXgFvGF7ovH/msUFlE4qB97QHn5itgi2Q?=
 =?us-ascii?Q?yd5fPfvSiHrKhGQPk+HOayR0uD3EMQiHppsTyXvkJJwYomHxJYGHS739HobN?=
 =?us-ascii?Q?5sDyA63f2hoptuJ9PRhCC5c0/CMDwK6vB2k3e8gfz5sH4UbUAdpkxxuNLUwk?=
 =?us-ascii?Q?+yEMo3UYbKDXAHoI/ObKXYtI4vMCMs09Nxe6/QG9LDNpw5IHMJjq1Nz/8fzO?=
 =?us-ascii?Q?UrY8SC7MKikbDEtRv5sURXhN3Clod7mSL+4REAai19v3QZpUSQs9+/n2zcYR?=
 =?us-ascii?Q?LzVdN9tSORLEXVaxdBKjadvAHRgtAxP7jLQOTjhWSRHggVNHFfJUZ29qCRVo?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8901833D92CAF42A29B04FEEBA96662@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I23NT3plPJ4Z3TGVeOlEiodKbrVk7ubgg6YtwKIkePWuvvht4iuIo9G3CFNuxSPyEdSyX8VAl6syyR6RKgXAItFSKre/WvN+PiEmGMmRQZMJIZrjtLRWhfFySqfxZZVI1y5b1rPRno4R233i6GADCpX9ez3NbCu/TJhX9/FVdHJh0yNxm0HEAhmC1e3IR6H1OsJ5Ss9fVQi/rfGAD/ssBkfP0O5P5nr4UN5mZs0uJSbV7bNMR6AbUDgHgurD9kCww3KLgm2lFeuYPR05aELjeyOzgjDJkEdmVxAw1RtNSHeAskQNgcMnmz06R5yLlDuF+G8WNJ9e6ayGTc3V3IT+hXpT9+Dc1Bb3Av66ELppNAfFlIJ6elnK++AKqj8hJ8WJ1P/CV9+wLtXegTZq2XIteW2ZUgTQlIm0V5O7N/JG0Ms9ixFpyQ1iABOwBjqyUEL1kFP3epDC95uf0AeNeHoRkjDQLlMptmEbluWUOFo7ICOWd51mPUHy8uHu8su+o5nH4AQlk5FtSsv+h3m+cS8slrkGNi3FyI/3RTmjyc6CFrbhRzDyXxmrCzbJAmCrpi5yfri8aZNNH7GhUvjSZn+c50axIOQaMCXLAS0AOWQrXGko0yRg9pqinydegLeTFjTlPqqdndqqD5plnb/mE3sQYRxp7EVSqnYJKmp3I8mRINFY59af6GydE8YvsxQH89gp5J3l3sycWyLV7k9xMPQ3CLyFvgNY5U/TlR8D4bpD1wY94zuUpg5Z9PzsRONiOJqOogVbevuP+mt1RbGycAl452zO7DzSY0UDtvdQuO6FaD6O7oltdPuQN3i50o9i6RKJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d941c7-107e-45ac-d7ae-08dafd5c803d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:11:35.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IeCWWWnV7aY4WJjmlrgiXaqeRwVQDss0e612Gw46NSqAn9uNLmp9TIJ5gvoRiusWESfeMTQ1J6B4FQW5G7DvnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_11,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230155
X-Proofpoint-GUID: pVor2FLodmxA8VRJShIQPfyQeDFjYSX7
X-Proofpoint-ORIG-GUID: pVor2FLodmxA8VRJShIQPfyQeDFjYSX7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 23, 2023, at 11:07 AM, David Wysochanski <dwysocha@redhat.com> wro=
te:
>=20
> On Mon, Jan 23, 2023 at 9:48 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi DW -
>>=20
>>> On Jan 23, 2023, at 8:52 AM, David Wysochanski <dwysocha@redhat.com> wr=
ote:
>>>=20
>>> On Wed, Nov 9, 2022 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Nov 9, 2022, at 8:33 AM, Dave Wysochanski <dwysocha@redhat.com> wr=
ote:
>>>>>=20
>>>>> The sysfs path for the NFS4 client identfier should start with
>>>>> the path component of 'nfs' for the kset, and then the 'net'
>>>>> path component for the netns object, followed by the
>>>>> 'nfs_client' path component for the NFS client kobject,
>>>>> and ending with 'identifier' for the netns_client_id
>>>>> kobj_attribute.
>>>>=20
>>>> Seems like the redundancy has some purpose and is baked-in to
>>>> the path. I'd rather leave the sleeping dog as it is, enjoying
>>>> the morning sun.
>>>>=20
>>>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>>>=20
>>> Hey Chuck,
>>>=20
>>> I just realized the patch is still outstanding.  Now when I re-read
>>> your comment, I'm not sure what it means.  Your comment sounds
>>> like you feel the patch may not be necessary, but then you have
>>> a "Reviewed-by".
>>=20
>> I was responding to Ben's suggestion elsewhere that the pathname
>> had redundant components and should be simplified. After reviewing
>> the code (and your patch) it appears that all the components are
>> necessary to have, so the document change you proposed is
>> appropriate.
>>=20
> Ah ok yes I remember now, thanks for explaining.
>=20
>>=20
>>> I am not sure if you mean this should be applied or not.
>>=20
>> Reviewed-by: means "OK to apply". The documentation is incorrect.
>>=20
> Ok.
>=20
>>=20
>>> To be clear, the existing sysfs path does not exist, and we got a
>>> complaint about this documentation inaccuracy, hence my patch.
>>=20
>> Can you dig up the complaint bug and suggest a Link: tag to add?
>>=20
> It was such a small issue I was not planning to create a separate
> bug, but I can do so easily if you would like that.
>=20
> The comment was a private comment that came later on in this
> bug, which you commented on a while back when there was discussion
> on how to generate a unique id.
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1801326#c45
> The bug was repurposed to documentation only.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1801326

seems appropriate to me.



>>>>> Fixes: a28faaddb2be ("Documentation: Add an explanation of NFSv4 clie=
nt identifiers")
>>>>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>>>>> ---
>>>>> Documentation/filesystems/nfs/client-identifier.rst | 4 ++--
>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Do=
cumentation/filesystems/nfs/client-identifier.rst
>>>>> index 5147e15815a1..a94c7a9748d7 100644
>>>>> --- a/Documentation/filesystems/nfs/client-identifier.rst
>>>>> +++ b/Documentation/filesystems/nfs/client-identifier.rst
>>>>> @@ -152,7 +152,7 @@ string:
>>>>>     via the kernel command line, or when the "nfs" module is
>>>>>     loaded.
>>>>>=20
>>>>> -    /sys/fs/nfs/client/net/identifier
>>>>> +    /sys/fs/nfs/net/nfs_client/identifier
>>>>>     This virtual file, available since Linux 5.3, is local to the
>>>>>     network namespace in which it is accessed and so can provide
>>>>>     distinction between network namespaces (containers) when the
>>>>> @@ -164,7 +164,7 @@ then that uniquifier can be used. For example, a =
uniquifier might
>>>>> be formed at boot using the container's internal identifier:
>>>>>=20
>>>>>   sha256sum /etc/machine-id | awk '{print $1}' \\
>>>>> -        > /sys/fs/nfs/client/net/identifier
>>>>> +        > /sys/fs/nfs/net/nfs_client/identifier
>>>>>=20
>>>>> Security considerations
>>>>> -----------------------
>>>>> --
>>>>> 2.31.1
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



