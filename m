Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12A96F1A15
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbjD1N7B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjD1N7A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 09:59:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF561BC7;
        Fri, 28 Apr 2023 06:58:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S7iF0Z008351;
        Fri, 28 Apr 2023 13:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FZoONSuu+kq/NqnHLYKOWXrV2a05AO3VCuLwXZXQWBY=;
 b=zCwd/1g8OEZCMv2/RR9SL8/Q0sLoSJ2xpH+CpH84pBPe3w1uWszF55u4pxI9Zq/A30B2
 0BxN7D5i+oKtbO4jq2ljq4XG6R0SoLnXiXTPlbzciLqaqOw/7AvLHMd1d2no9wdVQZef
 Jo7v9l4so8/jrd8VE3mosd7gBvFZomAnNo36SYz+VjePEh4EKrvJDcebPurU9GtX6VtY
 aAP8MeW/SExazpQ8aaC4IWmkTNzj3hMKc04DiKFIRipsgaV97yjy4B0FTYKanqyTFUQc
 XcsszqsVSEqXlKsntC8wPC6qF9LaTMtfKRy+V7F4TnzgquKJ9j51sMutJ4uu1yjTr/ag bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460de7d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:58:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SCBiBk029936;
        Fri, 28 Apr 2023 13:58:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461atysh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxic6kqPZsaavZeKZOi2erU1Z/zusvpdNYYRb+xzOP9lmuE/jYQW6ubjBlJujAuMy8WiikWltTySkfhR9nflRELeE7/fVPOoc8BkscTFOj6K7EJdz9RSQ7MDEsFBrPUUrhr8OVfGck36P8RPVL/NCoajfOyD1hi1LPx6Edhu2Qc5sipIYivnST4G1BeWZ0rDfB/RUVEKcgihYWKdHEEKg4a2/gdhb8xEaVut0q6KfGRrkSaRq0rcGfl0j/EIJDSF+y2uUFiZDKqz7NAfCDuK/dI91OjfqWmBB2JLQywy9cCUOiL9C2dYQSOJUCF60OJmGziXDokCKGI0dyJvITo2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZoONSuu+kq/NqnHLYKOWXrV2a05AO3VCuLwXZXQWBY=;
 b=mI+xtlpGCwlQfN9geeZduXChQwsOw0LWctjZXBxKqGOp+tIpIwWgcmW/ZXOenSY+Bcc+TEgw3ucw9btDO7WIMlDR6rZmjtsiyTabfoNPut+LujrzOqqJYwX/5AL49Q7cV6pXDCyUxZa/hOEqCJwPxgi51uC6rnEKb9xvPXjZhBVV3A8feW9A2asW4M64lO/lXJDFC781lv2fDZ1l1ASNk7cTx+ZqBnv0bfpj0Cd+foIiH2XkZKoQVPvNX0PWqnZehRkYykiKNrwXgCaMQp9GmRyMk51dnFFvpNCwbguZhZWA4KE1YNbdVStibrUiIJqvMxF6sAU1w5JLqAO+Ylnndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZoONSuu+kq/NqnHLYKOWXrV2a05AO3VCuLwXZXQWBY=;
 b=ptYs5z/wpbR9HSruyHBwHqjzxHnfxBxFd8jvR5VyIyS4NB+vYUEDf6ItX6rhP5m+MCyFU8aEH4y+1CcRAmyo8c2Ch+0C6XJXShicNeqWw7ESVmIzHTTzl4o7M939hYI9l0RCK3ZVKnU03L23CqzvGr2RYQaYyKULbQUpOj5N5Os=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7192.namprd10.prod.outlook.com (2603:10b6:8:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 13:58:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 13:58:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Topic: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Thread-Index: AQHZeSvPGmUIQ02sEEOITmW0YGNWva9Au3SAgAAAroCAAAGCgIAAAxqA
Date:   Fri, 28 Apr 2023 13:58:53 +0000
Message-ID: <36CE272E-15F4-40B3-83E8-98BCFE55CA20@oracle.com>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
 <ZEvMo4qkj9NSLXTA@ziepe.ca> <34E28C03-5D1A-4DAA-9B5B-D453F8C256BD@oracle.com>
 <ZEvOec75yMrin/hB@ziepe.ca>
In-Reply-To: <ZEvOec75yMrin/hB@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB7192:EE_
x-ms-office365-filtering-correlation-id: 3117764d-e4a1-434d-4754-08db47f0b3a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: my3yU9M1yELeh5sePSGaQ5RZxoexM4P6Wr77ndkqREacAwHdjVzC3X+6sZNBFcsbsPJXZmfMA5zvS7nAUhMzcDQhuFg2FReonKNNNtHrVD5V9+4cFB8TTGDqnPFxL6pIKT9zla8uD36tyPhSefrEahrx5c9IpWLwIT7N5mW8zn/i+JpOxmwDnnSDcBs8WZ1MJ5dobfBWChcO5u73IWHJbT2Ane2Wt+pMLYOgKFNVmCWnp15TkMPiR4rGOdmF0t9jVsH5OM4+7EIS+xyx0M8xsCSLNqyBb1zRJ5YcICoBDTucsYx4tTgybUdLRg+UTGjlEACMwHbw7sLV/irE4qAxGTQNINVFiHP50idE35ZUk/SLvJ9yuyeQ7SvorZGTmhhuO5d+vRuXtCbO6e8VIq8O/Ezd4mTDqy4tGIDATjAm5xUuLISMm8uhXhCnQt2Z5TwHtqyT+X8O7frNehBM2u6Jj6J+ZZw2J3rowYjFDnNCi7WldoAXC5FZs4DIAn8XZdgFT9oYoK3DOTE+iwseSRMWvrCIIX/3lGlLA9AXjSKee4PXxp4rSW7gSzuaYbcY3ZyrYa2+s6YNXrVtuXr7TuHPN06x+jYJGdoPI1sIyX48b6Sx8xGXSdKl8m7ux66+fBZl1Xe6rHJ5dmlabSKIGkLhIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(86362001)(38070700005)(33656002)(36756003)(2906002)(66899021)(53546011)(6486002)(71200400001)(2616005)(186003)(6512007)(6506007)(26005)(6916009)(66556008)(64756008)(4326008)(66446008)(91956017)(76116006)(66946007)(478600001)(66476007)(316002)(5660300002)(38100700002)(41300700001)(122000001)(8676002)(54906003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4f93OCR/fwxYgIh8vjgt5ksiIQe2dOuLxKFYtwr4cArNuL4kzVtzMTcDWvMO?=
 =?us-ascii?Q?WfrQOXWebkRIh74/Au+UKXAGxK5k5N+AWzMkolzG1Pngzg1A00XnzB5cBAiv?=
 =?us-ascii?Q?mJ9b9PGbTTgY5kptVUllM55Tjkg0QatZfsA5EtGOrr7yLoALYAaA/PgxwNmL?=
 =?us-ascii?Q?kUdriucdYVdDHG0XDzX/arfCkN2jS0yyehahcAhJoGna3LG3R0VI5s0b+mwc?=
 =?us-ascii?Q?3OxzQaFCB+odgZBQ9ocpr/u+uRkTDIVTa/evMwlaqb24YOPrFiNqfPTEgk0d?=
 =?us-ascii?Q?LtHxhvIrR6/4NmoPGqUr7jBZ9k9hSekGAZuCLRXrBN3RkWaofJDROZg2c75N?=
 =?us-ascii?Q?e81BLBKkqe6ybx0WIfXTN38Q2IpzqIiaSoCXmQPqYB5M9v+6a2H7cx18EV7O?=
 =?us-ascii?Q?TwtC/hmWQ6KmXlqqowUx9KSy05qOOyhPd6+a3sr1gcf0Emst38Hv+kjwOm7K?=
 =?us-ascii?Q?yCPlnLp5l/vEpeShSSgTAcKIAyG7sYx/dohz1ED/3CdHKx+NtFd+M69fMuam?=
 =?us-ascii?Q?zGkPotC3oL7+1PNlPKm1G9zjMLNm97rBEHAXtlzYv2ZNmWDuzsYYHAe9FSiF?=
 =?us-ascii?Q?5fQE/pSCgbQAutUtMVtBZG85PQHJRM+lssYJ+LUbB9MHWNZqu2xX//nagXbj?=
 =?us-ascii?Q?/p2Fa45AicKaLljNuo/+Ro0fxk6TvdHSc7c5QyFrm/aStnG8eg5fNW01YHJ4?=
 =?us-ascii?Q?tc9ZxPIxP5zr394kDioOAi7NCEjPtx9fc8bRu4xyi2k0MWaoJw9ur08rNb2B?=
 =?us-ascii?Q?93nN3LAGs1cPC/WhKmSVyg3LzDrJy1oD/6pf1Vag/m5TYl4tw8fPTtP8ZZOE?=
 =?us-ascii?Q?bukG8MhptYbM7UsXQiC50kRVmHuYUIY6Tc57Bnz+DlAe6SZ5or71UvxzAuAU?=
 =?us-ascii?Q?UqhZmJ6OU57wJm6HOGXywfGwywWnGgy8hq+cWKoWP1f5qu62jD6Y5pJKojOV?=
 =?us-ascii?Q?Wz09lyv33ImopdBXZ9UQ9gjEPBQoYWE81hOP3OEryKHGyXHA04/iBOnpToWE?=
 =?us-ascii?Q?irHFmA89cKurYzrNnm9Aysjfomyze+9VJ1F43vVM7hLtZVpZpxb3rBFx/0zM?=
 =?us-ascii?Q?YpoaW9CoRk0HpfPXocdl7tOQbLTW1UGzZbFUEi/C6Tkmc9Oavuow7GS+OC8G?=
 =?us-ascii?Q?0wdJf2V1ib7pyWQamSj6F0mU+eqS5eodv8OfA8i1DN4E3FQq1aNONFK7TIcq?=
 =?us-ascii?Q?goILVUNtm0eDNt6XqKYnHAlO0+ueBfFftNLjnDmUnuw4d9Aw8fLAtnGx79EU?=
 =?us-ascii?Q?R+dOVf3lLwIaBoKxXHK3TUW/X2FBZWwmTDwBs+7Eaf+fcJPkr5iRHgVeg/9a?=
 =?us-ascii?Q?0BxOu5ig+7so6uQ+JYErF45KcR99/3fkwSXFQEE+8beXxmINPfqs+23R+osI?=
 =?us-ascii?Q?aUPuxoMBnRo1p6MmN+So7ry1+JSbyEE5wPRRs8c8r1nZ2fx24Q3G4pvl/QqK?=
 =?us-ascii?Q?ke36A1NBRQP88+5INvyhP9Bp6hOv/fpBztFge+RDLy03ndlmN+GfcPtzqMz0?=
 =?us-ascii?Q?9kdDYbwserucjJcrl6qnBOLO9QXYZiKL3BNr7igWz52+aos0e6V98BFBnA1s?=
 =?us-ascii?Q?2FXU+HxfAZcBKM4YX0wtakSZPPYKQlWa287Ii8DYiI6Tw6CrUoTZhtsWrEzY?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A3D6154C88B4B40A2EB1E0010720894@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: toWvQFQE5RPGrUP/Zbj2gQ8jWocZULOfCR0viyUy11PKevssf6xsjk+trL0kkfOrnjEaJDrzwkGn0424+NZHq/UY8KlPHqKLJiXtx1khatu4lzWjUt/1N0WEvaNYESuj/zBoXFbCaaaudpsZYPvznE9wqDn2XqVi3S2FVIgSCRGpiN1WKZiCB9A2ZeFa+Y2wfUFxW9BpB7XiJPeJYngY6YoeTn58uJgizHY3oH7rNVc0flQG2tuKa9Qvr6dycCw94jlaL0gf0PrASACZYZ589bgHKzaH46Mq3kPPsMqJWW2gBqcrHbuQqwSOBc/IDe5M4HAtdswFAd8MdOjq9PebD2kkY9K6xzk0KqL7BqWR96lVmpOQPUnICT1xS8GO8wdkJSdTIf+1H3PJKpQS4J2s+7kxKCkfzXZEc5G65aiWvKombxQZNf6Gar9Ii8XHa6OJOOa45IOoDhj8oCYEudAPEPo2NUr7J8uRUbawSeVfENeJPv2yNngTHnEobvN7lwiHIk9xZTazvIj5RG91dVQh+LZGmBssqlgMesytAhtF2WxN7hVhaHim6qqn5rUKYmb8vZSOL7b7OT+GJyydZJrwt+NLvg94yy/uVT6WFueWa2qxzv7Cwl8a2F+TkLq5P6AJfNqoCnT1xGdzLl9j7YVv9CeqBfuIB/UfR38NlJ1LlY/BvzV825ZsoETUdlVlVrtJbYgMaFUQMfbpCwu0Jksgn1WuIV77+1wfWiKKSz9qvLDnLLM8Irokdr/r2cYtY/e8do1YpfJP0Lee7E9WcKGFGXBt6awsdg31FIHywnb5q5lgAYjGcxG+yfWppRn91ybuO4vk88WYhWBG4rjJMquhfwPYOSGgVUde2rCSmWTdBvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3117764d-e4a1-434d-4754-08db47f0b3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 13:58:53.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqebOaREePbn6Uh1T3trDeka0xT7vZcwKvvdDVmaHoRNspEc9vyj0A+1tCcJn80pDyhHdwE61yy3J1bp9h7pjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280114
X-Proofpoint-GUID: Mgk2ksfOE77GRhS1N8w3TFZT7yzjy7Vo
X-Proofpoint-ORIG-GUID: Mgk2ksfOE77GRhS1N8w3TFZT7yzjy7Vo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 28, 2023, at 9:47 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Fri, Apr 28, 2023 at 01:42:24PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Apr 28, 2023, at 9:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>=20
>>> On Thu, Apr 27, 2023 at 01:14:43PM -0400, Chuck Lever wrote:
>>>> From: Bernard Metzler <bmt@zurich.ibm.com>
>>>>=20
>>>> Tunnel devices have zero GIDs, so skip the zero GID check when
>>>> setting up soft iWARP over a tunnel device.
>>>=20
>>> Huh? Why? How does that make any sense?
>>=20
>> Read it as a cry for help.
>>=20
>> The scenario is attempting to set up a soft iWARP device
>> with a slave that is a tunnel device. The set up seems to
>> work, but when connecting, the ULP gets an ADDR_ERROR
>> because the setup did not add an entry to the GID table.
>=20
> Don't assign a 0 IP to the tunnel?

That's a little cryptic... can you expand?

Right now I have a Tailscale VPN device with assigned IP
addresses:

3: tailscale0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1280 qdisc fq_=
codel state UNKNOWN group default qlen 500
    link/none      inet 100.64.0.16/32 scope global tailscale0
       valid_lft forever preferred_lft forever
    inet6 fd7a:115c:a1e0::10/128 scope global         valid_lft forever pre=
ferred_lft forever
    inet6 fe80::725c:1b6d:60ed:fce4/64 scope link stable-privacy         va=
lid_lft forever preferred_lft forever

And after that i/f is UP, I've done this:

 $ sudo rdma link add siw0 type siw netdev tailscale0

With the patch I sent, I can do NFS/RDMA via soft iWARP through
the tunnel. I'm not at all claiming that's a good fix, but only
that this scenario is supposed to work, but currently doesn't.


--
Chuck Lever


