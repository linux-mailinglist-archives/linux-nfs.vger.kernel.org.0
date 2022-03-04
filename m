Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453744CD8F1
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Mar 2022 17:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiCDQRL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Mar 2022 11:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiCDQRJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Mar 2022 11:17:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D11BE0F2
        for <linux-nfs@vger.kernel.org>; Fri,  4 Mar 2022 08:16:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224EFUZn019128;
        Fri, 4 Mar 2022 16:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oFc4OdS/I4KMJw5W9wi/dyDrVs9gBZg7nLDIh1MUw4M=;
 b=0PDoeEmIozI/FpB2jEpQQ5gKhjT5V9sQ5+gAzGflFd5UsGzvE3Ki6gvyW/IkK6G9NfgQ
 2dx2QX9Mxe94fX2o8pZW1V1QyNwi6OIQAcsjdQ/jaa3IqHOEhGmox4qdup/y7iLiXwEU
 Z1YG1lqh7ox8RFn4rECIti5zwMPFW0Ux8DgH6T3tQH6gPyzeLV4nT2mR2kVe21ZPkne9
 DcQI6Ivq1Gv39nmY2B3zxEV1Cnjp7jOg5xECv+bPEb0U0qmjhZpzcznVVGXZTkilXyPi
 zm04ygOquoo9HYtEp8mJPbuNPtGESH7Kv8wCpjP4NFrfVXfhSduqTCyuxSZPi1hVdIyi 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hva4wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 16:15:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224GCA5F039521;
        Fri, 4 Mar 2022 16:15:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by userp3030.oracle.com with ESMTP id 3ek4jufyya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 16:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy0QnUjw3n81p403jRMP5gYxTJ9ReRPUpWAByeEn7ro/5RkDUt02pKovOJZWZ4XY9bjY0tWNB41tHsgQqwyaU/BLiLkd57LfuGkzYHpgoX+lQH/OwN2NVLNBPnBmGIGjT6x/ppFHA6F6Zs3PCwWWKHaaSUc4MzLoAO6eHML7OYYEodvBxfVlP+GVlwtRkSHOTy6/0+u4zodsfgN8us8GN9k6Uw7NpQceXTEjrgjXto1jgryG6UN9D0e5W9+3iZKVsixUuKC1pEBUhcObcIyUCHLS8VVucKWGj2lFxXhJgQgFvYDEFwjRMzpENWthbhU1ae7HMbNOguvLPj1bPzr8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFc4OdS/I4KMJw5W9wi/dyDrVs9gBZg7nLDIh1MUw4M=;
 b=ZtUuF3CY5rkdWAlUFNr3tWQdJllzYEgVi21kc0CyZqt8lq15H5m4BAqlRXTXL+uOpqYRcShmOoraZdUazP+EDU5sHfHExtsZMtQo1hD14+5ibEN+FiX3DRX12Momk4TG/laQ4jtPMAAVmPfQgoagggeB0C7fSW4QDDJplC6jQ8VMe4wEW71GCactn8cz4XH/o/C9la6VFabnYd9jgiu8mbQHzg5zRZxprYfUW+lMMCV7UyLF9L5UVEkvG1gPGbQwRI39RxAYj1RjW3DKojmj5I2tosksLz0PPJW4iHhP8G8sHSXTuvQ7m9I6n22agtWM84h3EOHVUOAvZQzNgupPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFc4OdS/I4KMJw5W9wi/dyDrVs9gBZg7nLDIh1MUw4M=;
 b=DxNl95SL03DCzcRHzyQeV9NvGmlB5bjexSS8GkP9G33zNLStm3i8X06QevkMrCKJK/qLYZCZN4MQdtq/qEkX+O7/WUr0HAb2wkYrcg1eg4TWk308rEXvSCUyf6c4wLVyiKZo7UvQ4ePKbwHHizR9gzM7M3Z6M4gyv22aBfHa2R0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4400.namprd10.prod.outlook.com (2603:10b6:208:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 4 Mar
 2022 16:15:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 16:15:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>
CC:     Neil Brown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Topic: [PATCH] nfs.man: document requirements for NFS mounts in a
 container
Thread-Index: AQHYLR6czeCutPWqYkWZgIa/iwKGvKyqohqAgAJglgCAALucgIAAsaUAgAD2HQCAAAXzAA==
Date:   Fri, 4 Mar 2022 16:15:55 +0000
Message-ID: <C534D3E3-C706-4128-B05A-9131207EEAAE@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>
 <164627798608.17899.14049799069550646947@noble.neil.brown.name>
 <fe1527f96f5b8f6280b24985603bbf99cde58864.camel@hammerspace.com>
 <164635642445.13165.9587906660448735526@noble.neil.brown.name>
 <3d4467af-e6f7-694b-e711-6fafb6490fc8@redhat.com>
In-Reply-To: <3d4467af-e6f7-694b-e711-6fafb6490fc8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93924732-8c91-43aa-f1f8-08d9fdfa429e
x-ms-traffictypediagnostic: MN2PR10MB4400:EE_
x-microsoft-antispam-prvs: <MN2PR10MB44000C7F5D5B766F1C65A99F93059@MN2PR10MB4400.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSUJj/9jeXKhj69pavmsDczM8Erdnqgq18hAxavFXzmP/FOK5WQ9fvV7Y7FX/PHCG601utPHNHHd0Aqf+RuKEeKnsC/XGPMPjcrFF2AG+g7tMaFPZUdxkt6S1+NzPmPOV07NriQ+ZxT6rtgT9mVHPKItwMoH+LGPG/GDw/Mt4Tugu4lS4DmffKsAJOqogzezyY4QArg4AHCQsHT+Ex4WjWm6mlmEdewPH7ur4WqFWRTgVzFZd+TDjIc1ulEBBb3u6BvmySepNGDmhIy4RYluyrgLGtVRxQ1ZoT8UT+Xx1Y7vrmlAPD4vvOIBoJmRGtXDmolnBvJD7wGk/vyEvDInQzOrM1h+JvPhxOpjMglHW4rfwm3mvlOrr+KKtB9/Ogq1sQQjtUtbOvRGh/JYL0uoEwX4+SBurmy/Ue262z3cketgwJBqYTYTuihb6BA9yA5QeyJHz8lI2bEsVvwg2qAs9KkYZXylrPo9J5QvmEgsbVHHrIDCx5rYJbNNXPcFuXZxUQh4c2CdwrJHEYqi0mEFEUKzI01KQOUKBimjA45VFuWnyPQ0vQxKebCui1GmyD8N58Tw9mSRT4GrIQGgu+H0/KukX7maiRbQwGIR+AAiYoLd0RMPmRi3Xkav9coz3w96DuoYKjrnVB0Hq4J1dFAsyj+g8cCAFd4sgii8/QON+Iib4MPvwXnlDK+NrGmYWfs5lt9U1TYoXISGJZuwzvHdw/cLBJsPx/MEwiJBx5O2gIjBcbm8Ka0Qry+UrGFZjc5/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(91956017)(76116006)(86362001)(64756008)(6486002)(8676002)(2906002)(66946007)(66556008)(66476007)(4326008)(83380400001)(66446008)(5660300002)(316002)(54906003)(36756003)(6916009)(8936002)(508600001)(38100700002)(53546011)(38070700005)(6512007)(6506007)(71200400001)(2616005)(186003)(26005)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EhgYCtLmn27YvOjkRxbigJbnsLYVsbwCL24pydbpGJVo4lWj+rEAk0foP/EE?=
 =?us-ascii?Q?exPPuXzqRHcPF5l85q1hDQn6o3+SKPyshSFMJgJEjg1qK1/jcwoqpPwCT8zQ?=
 =?us-ascii?Q?u75OTejKPOTd/4JObC4FSb4g1mB9g8dS9dbM10WDEgzuG7OBhKgRe777SK9u?=
 =?us-ascii?Q?+xm70nAIcPyMzwAj94uAFZebvyTOIQM42MuA2FpFrez4kLTyy2pTyAilg0U0?=
 =?us-ascii?Q?jlLrU8Gl8wevihU6oNGo/Bbd/p8q4Tihd5qBX8u/ee6T96V3ndUmURA4BrIO?=
 =?us-ascii?Q?JHC7tSqlHD1PmQMc3YeztuVYfJmszPN3u+d6eTiIAkp1Q4xh84Vl6ZuGUMh/?=
 =?us-ascii?Q?/t3Rei9a4CdeGJXBa2wntVjGhN6taZ+OsGiP01olP8lq14lYICJ4x/EnxxjD?=
 =?us-ascii?Q?pbJ6LF1ltYEMHyazmUSlfPmK+p6nltMaAyZQh2uVAzU/Npfoxp3fCKb7FB9Z?=
 =?us-ascii?Q?waGQkjk07sSfyYiznMZc/tF1YXzPSWJT6kqadkaa9y22unfzRnul58M5AtFx?=
 =?us-ascii?Q?1RbomHSG0kpl1SRvo8aMqqCQ3fNvvgNOD+S0HYVSsVaIhc22y3Dj4+hcz0r+?=
 =?us-ascii?Q?JJbXPesfHNqHLp2ErTu/UrvYpMohw58P3va4pDrtRdxuEE8n9K9JgMeXCdTe?=
 =?us-ascii?Q?stLo2Pm9if1+PhDd8NxCpCyvSLr6p8VeYT6foPHkKa2akZ05/0uoGUN/9IMp?=
 =?us-ascii?Q?hH2LpNmG3vs98NgB2kzLLhJwGxvwi9I3+OsD0WEq/zcMVosamtsDZy+pRZ59?=
 =?us-ascii?Q?pp3IBT+OdYEAZ5KjRoDaz3/kxFy1TXRRvDNdQfMp/AwCK8zZa3TCFJA8GqHZ?=
 =?us-ascii?Q?sJ64vQJfWFYQp/XZKxbYetbjv54KNqO0Pr73kPI8SkwbuouSBp+eSaU+t8oo?=
 =?us-ascii?Q?aLpW1HJMLJoExH82/BuYs7sd5mG0eHHj28EjD9vv7kYfAl3j1SMdPED4qQBr?=
 =?us-ascii?Q?qniKI2kQF4NWPzVEErxj6pPLaCNAoCvjApZNP+E8LEQCgWvoB3E4k9xn7qdN?=
 =?us-ascii?Q?72qmYr33JWU09CDf5M4M0ab5U8bX0wUwjczNPG3FqqF8OUfITmMPlJjewmqY?=
 =?us-ascii?Q?B/Z7lgsNpr/CeDpK+zNNtBdlowlsZQVo//BRPLFKP02RM7SNnEu63pFQDQzM?=
 =?us-ascii?Q?24p0mXUmbZJiXLVEnzU50XEm5IVSUpKhMTBr4WuOCulipjYbpCrBk/uDfSLj?=
 =?us-ascii?Q?sCDEzcA+rz48g8/8oW8DxSHWwVjfJQ4XXmNSxJaDtUYclVk9CcXMl/rXe2z8?=
 =?us-ascii?Q?CGmd5bsIVLSkcNXYg9DS0GKfhMejURJLNWj7iaFgbIpIAm6G7Rm1JFo2c4EM?=
 =?us-ascii?Q?mCOUyvU1DBe72DHUE9j/flYY+13kwhrRhcY/dgAe2jyCrO2IAeqo8qaCzyYa?=
 =?us-ascii?Q?43pMdtLAIzxO7qwdgEzjmDGonUL+FdNsLinqR2gH3dHJSXjECk4u3DJJ5SWP?=
 =?us-ascii?Q?dGbSDIbRk2tC6MmnXDoVjQRdS2Fhga3zj31Koc+NZo6vaZ6PZI7eVbaQ468O?=
 =?us-ascii?Q?olwLtm8ns6ErhaB9TS8n1vdI9wNLe8ProLXz1uvLY+Z1cV/bSFz2h+mteNLx?=
 =?us-ascii?Q?vfeLK3q194lX/IXQkPS0Zujchno4Q/u9GRoKsoC0J1PxBy4P+SAl5zOkofOg?=
 =?us-ascii?Q?7tP/V1G6OPKrkpR5csIaaKw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E85C14521F63E54EBFD93672CE48B75C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93924732-8c91-43aa-f1f8-08d9fdfa429e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 16:15:55.0050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3rZq31aElezr4OLX+UnzNynsMq3C75AM1ayJY3lYaE38DAXTVIwpDFWjhwJHjWHBpRhC+GoUpoDCtf4sIck7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4400
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040084
X-Proofpoint-GUID: bO5gPs1oSNU53aFTGOPwLs5zvz4pamD9
X-Proofpoint-ORIG-GUID: bO5gPs1oSNU53aFTGOPwLs5zvz4pamD9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 4, 2022, at 10:54 AM, Steve Dickson <steved@redhat.com> wrote:
>=20
> Hey!
>=20
> On 3/3/22 8:13 PM, NeilBrown wrote:
>> On Fri, 04 Mar 2022, Trond Myklebust wrote:
>>> On Thu, 2022-03-03 at 14:26 +1100, NeilBrown wrote:
>>>> On Wed, 02 Mar 2022, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>>=20
>>>>>=20
>>>>> The remaining part of this text probably should be
>>>>> part of the man page for Ben's tool, or whatever is
>>>>> coming next.
>>>>=20
>>>> My position is that there is no need for any tool.  The total amount
>>>> of
>>>> code needed is a couple of lines as presented in the text below.  Why
>>>> provide a wrapper just for that?
>>>> We *cannot* automatically decide how to find a name or where to store
>>>> a
>>>> generated uuid, so there is no added value that a tool could provide.
>>>>=20
>>>> We cannot unilaterally fix container systems.  We can only tell
>>>> people
>>>> who build these systems of the requirements for NFS.
>>>>=20
>>>=20
>>> I disagree with this position. The value of having a standard tool is
>>> that it also creates a standard for how and where the uniquifier is
>>> generated and persisted.
>>>=20
>>> Otherwise you have to deal with the fact that you may have a systemd
>>> script that persists something in one file, a Dockerfile recipe that
>>> generates something at container build time, and then a home-made
>>> script that looks for something in a different location. If you're
>>> trying to debug why your containers are all generating the same
>>> uniquifier, then that can be a problem.
>> I don't see how a tool can provide any consistency.

It seems to me that having a tool with its own man page directed
towards Linux distributors would be the central place for this
kind of configuration and implementation. Otherwise, we will have
to ensure this is done correctly for each implementation of
mount.


>> Is there some standard that say how containers should be built, and
>> where tools can store persistent data?  If not, the tool needs to be
>> configured, and that is not importantly different from bash being
>> configured with a 1-line script to write out the identifier.

IMO six of one, half dozen of another. I don't see this being
any more or less safe than changing each implementation of mount
to deal with an NFS-specific setting.


>> I'm not strongly against a tools, I just can't see the benefit.
> I think I agree with this... Thinking about it... having a command that
> tries to manipulate different containers in different ways just
> seems like a recipe for disaster... I just don't see how a command would
> ever get it right... Hell we can't agree on its command's name
> much less what it will do. :-)

To be clear what you are advocating, each implementation of mount.nfs,
including the ones that are not shipped with nfs-utils (like Busybox
and initramfs) will need to provide a mechanism for setting the client
uniquifier. Just to confirm that is what is behind door number one.

Since it is just a line or two of code, it might be of little
harm just to go with separate implementations for now and stop
talking about it. If it sucks, we can fix the suckage.

Who volunteers to implement this mechanism in mount.nfs ?


> So I like idea of documenting when needs to happen in the
> different types of containers... So I think the man page
> is the way to go... and I think it is the safest way to go.
>=20
> Chuck, if you would like tweak the verbiage... by all means.

I stand ready.


> Neil, will be a V2 for man page patch from this discussion
> or should I just take the one you posted? If you do post
> a V2, please start a new thread.
>=20
> steved.

--
Chuck Lever



