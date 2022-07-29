Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47958519B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiG2OcI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiG2OcH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 10:32:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A16A4B6
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 07:32:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TESpwP001762;
        Fri, 29 Jul 2022 14:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QEF/Wfd7e6fs42gGzJX2CPf7ItVeGhdEmjv9Y2KqIx0=;
 b=h2+escKYio8NGQSAMxNegpqyb99cMXCKcLOOQZrRgpVm6yNJyGrTINN2X+aVh/JA5syh
 09PqTMM1v3Wqbe90LUWmKQS8gxU+WYTHp8u4oXmzirvNgAkjIrdHNxXU4iff1hPdJ4F9
 qw7hvnjhJIyhgnwEIk/dl3x7pAIxWuFlxllgPG+AYNyQDT9qGDRH2Cg/HYkjgX/8EFr1
 rfivbfShScGf+keqXMDRlhD20eIvRNhfomyBiyfDBR2Hqkupoylu5BcuBj1hBF3rSVQt
 ygrqViFgxvIxM+yc0HW4W3r/TWy6r4j6wXI/DonbGOecRJd3vrNuc7PY1HtY3a1Q26fy 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9qgt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 14:31:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TDYxjN034503;
        Fri, 29 Jul 2022 14:31:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh636pe0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 14:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjHjnMRowzVWNZMCIDDY0iJNrPgEYgcybsY7sWKkyR+hrYugKMKRLij3IWI7DjA4Qo/6iybKeOrC8NowyXS7Rc+/2lr70qUocBrfaSJJy3ee09RQ8mQ8h0CcCX0ld6FeILa0km1hqIi6/TG0ALvFbnAfxh8Y1zcUN+qxAUgoy2n8dTDSHzCfcwQstO9WyxOC7IVf0WEc6ayINQ4mtUN4aGjoaL1JaFi3tyRHt2UIv/ETIQAp55On6VyYpCOZ0AZe8ziOi09KOXdMWZavhNtNevqfEK33tAdZXabz8c9kAG/MpkV5NBjm4I+udtlC0tRPK/mZFxrtpSAacWjsASIShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEF/Wfd7e6fs42gGzJX2CPf7ItVeGhdEmjv9Y2KqIx0=;
 b=eU7ycGqJBrTIk4OeGIZ5qAnszR6+1tJAcX9o/COA18WjfvAHU1bUCielKmCzmLQzQ87lyBkc1axngK7WmDfEEOuWXtzC6WT/WmfTDHFeaY5rab/dAw/n/UUaiAYvC1Bh/uBCLHhO+zi9vscZAkE2YkuBLpZCc7GjCg2dEpXE+wRUaFWpSunfgP2I34ntLrtvaJSGIxx8wt4hYUjHdt8povd0BRunhAZQcIobHAklbH/O1CdZ2YU3yCnI50MV3/oeLW3qGzuB/wQ4VwwndLTxDgeJOFKkxSDEKxIVhuA2zJW8eJZlpN1LOjWoEwOeC0OIDf6JXr3dzOKKd+nQu8nlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEF/Wfd7e6fs42gGzJX2CPf7ItVeGhdEmjv9Y2KqIx0=;
 b=r8ICnKNnxFEg5sRxS9tqXMe5VchWcjOkbS7Kvaj1osbox4y0F6FCkZAMMl/2EuX7VoutTbyeqxe3PhZSihib7j7llTQPjwszuZabBIDbbPTr/hAZGV5JwKvtT7OhRAL7TgmcBv+zKvklTJ8KVbnABJbDBi6gHIHncEzdjV16Kzg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2725.namprd10.prod.outlook.com (2603:10b6:a02:b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 14:31:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 14:31:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
Thread-Topic: [PATCH 11/13] NFSD: use explicit lock/unlock for directory ops
Thread-Index: AQHYohNX7cvCckGh/kqPxDxsXdi4Iq2T38yAgACwrQCAANtGAA==
Date:   Fri, 29 Jul 2022 14:31:55 +0000
Message-ID: <B445DD2E-D356-47BC-8FD6-852565A867E4@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793059.21666.9611699223923887416.stgit@noble.brown>
 <6221A20D-6623-41EB-AC9F-BEFB1F4ED925@oracle.com>
 <165905802651.4359.17617640232417036364@noble.neil.brown.name>
In-Reply-To: <165905802651.4359.17617640232417036364@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbb14a86-4800-4269-951c-08da716f1619
x-ms-traffictypediagnostic: BYAPR10MB2725:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWBGxwZ0Sgz7J/DtgRScevpr2yTOS35do8DlAVY9lP5oXPIBj29qpWQu/MXqeuGjuOBSl4T7n5wdlEvt5rQhEE9qC3u7ObZKwlkPWXYH9FpqrJrT6bpZKZily35HaCyujGeuVghrGukoGtjZ2eXPqEPWCWQpZW0EteFQS4ecIifA3W8AWwPneA6sUTAJYdW9dELb2RSC/q0nQH0U5VOa6utIUbEcWmpaRdUNTnm3SvnSNUnIcZcMkLNh6+Hugx/cvLfMeuzUOzoK0xzc4l2dXYF55mZZW+yKTocUohX3frDXZtHQGfeNmOD5sdAH5Oa25MCPkFp7SOGO1GKx21C7JPMms860twJg5/yWGi3EnwADjlYN4N+8W6YLF4oUDETAfDowNblJeuCRGJ03rjxUS0wv5PNZWdHJC+5ChpvdLvVxUmKo/51xAoD31Ly+BoX0NVoqcAr2wSh3xa9eLAmUZ607GYlcUnp88x5BnbwPKQpiKlULwEQUbKbhUIaS7zwzR3+TIO7xYVVQjbT3NHNOYTUVd7GfdtsoNh5wrIWIDZIIA/IqJYqC5Ak09SM46VsXAI9Sag6IEjj41F+gOcj3qnRID92LBba8Pmh8gBCf7wFOOAYLYWqJMcdM1yfLPL6a4kCOuzN7zhcN+BFngHZP+FLwZBgBqBSuSdUwSTEYv7IeezNn37eQI5uEKITotlynEB3GEVMg0MO0pEM8g0cfvQh4rdwUOg2zzSW/jw/fBrD9YHDJjjDIdL7UsEGlEaKgxV7gAQLlIJRayoqHHNhRrrqG2LoQkXSJVneVTOT2U1wXDqEXZTmUOXMq6IBS7fFLafBoZsbuRL9Ftrf1sHTfgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(346002)(136003)(36756003)(54906003)(6916009)(5660300002)(6506007)(33656002)(38100700002)(186003)(122000001)(316002)(2616005)(26005)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(91956017)(4326008)(6512007)(38070700005)(8936002)(66946007)(53546011)(71200400001)(86362001)(41300700001)(2906002)(6486002)(83380400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hziXEmaWCpXz0TzrRwm+1Ugls5H02G1VeM44Rh4vFv3OrLyIDZVRFPkMiAKv?=
 =?us-ascii?Q?zWH0k0qO/oWJiq8OBXZ7P9UzA3n8/oK8luQTMAJSty0yfLI3yunNqGDiIDJh?=
 =?us-ascii?Q?HNhPvWVX4lN2h1WIN8Gr/psFM1XFfKihWlJftQIN/JRTUdHPnXb2X/tqVyiZ?=
 =?us-ascii?Q?BsZHLdoiEIuTZE+7b1RWQ7FrpAskRoqQ1QzssPnJmF7ouQgXlQZ0/Qt23It1?=
 =?us-ascii?Q?Bo/H/iu4QTkgSHMrML1P4mRcRsZ7ZKkOj4rSKri5/gf3yQFJIjrqYEPlqBwn?=
 =?us-ascii?Q?AWpGz3nHdXRQSoCEAouJos6Tlcbpkj1DfDjuc2d/xxinKq/xbvVz9ZU/xloN?=
 =?us-ascii?Q?QPIqLWdLAOxyxz1bno9+0OrdU8P1wW4bhPU8h8/Y77vOamLrytCNk/9LIIcV?=
 =?us-ascii?Q?ysqmSB+eKKtE1YtKEEY8o5gv68/Hz1PRq6uX7qzLVD6LbQO9K+QH9qinpmVS?=
 =?us-ascii?Q?r0O7U7P4brFfH4nSfgyLCpaeYMMOuGBCtkO2C/HyXE7rjwZKAaH0Wtm8JegE?=
 =?us-ascii?Q?z3XiQDbY80XWjtVN0L3rCOimx7li+3Eq2KVXoJEx0znJ/1lGTW35YzIwGMX/?=
 =?us-ascii?Q?R9rWLA+2TNwKWXwG/UkoDlt07OzgJ3zxCV5xhvqlKjxcIMBhKNawO64sGLwk?=
 =?us-ascii?Q?eiqz7dahS1A31SEL83BDybitbc0nxmYz+DWcgUE9065auIGOjlUm0BhtI+2O?=
 =?us-ascii?Q?0Cpf7Plwj++EMnbIT24wZfqTAqwloyPjZplPALyr8sVnveoLKAXdET7I+CgU?=
 =?us-ascii?Q?WO5qLjEVdlRxxsIEuJ2YEO0W6I9KFWq7MhjOiYRIipU2fNC9+xlzE3fIVtg0?=
 =?us-ascii?Q?09NL6HyuRv1vl/sM492qWH1VtjoBVWWPMdOp132sQoom/psvuG1zCXyvplRi?=
 =?us-ascii?Q?/7eD+BPobsYL3ObQpDSXl9xuoumzizWH/uvrUX+/wc6oXPrNJmT2J1ksZY8U?=
 =?us-ascii?Q?vtb80hhJHj1e9tC2IiJDjekykmA1H4t0aCpBGqlWgsUj1cqhNgNoBCIwo9EO?=
 =?us-ascii?Q?V1Onk8xmqYdEMyOpr50AJGuWij2f5arqWtK5NyjvUR9cfRjV7Q7w6XmGvE3E?=
 =?us-ascii?Q?PW0F5h1tMKkFgxJWqiAZ4CaS0Jft848T0pr/FT9tgSBf+mCnYs+uebQbUpAl?=
 =?us-ascii?Q?qTKY9l/jeh8UnC8GBN/w9jHgRmyb4dIKkkRewbL5hr3gtIMixgCix+gQnlb5?=
 =?us-ascii?Q?zbwwbs/T6M4voAHwBzSHFN5tZUMn/ssnWwcKZDPIs6p+HJGIBcnY9JZGKjHz?=
 =?us-ascii?Q?e+0ZbXhwf+2yUs/Qzdq8DwQlWfmMTljarM1aJC5YQXS1RuExmlsMTP9JnW4A?=
 =?us-ascii?Q?qlLxfOPEcXQoR/YUqVMVg+A3EfwIJZN3KeyeRNtO8R7Ulz8X7WsVeGrYlEI1?=
 =?us-ascii?Q?0cfgsT/G1v96pITsC/B9ie4V87GbLcH20+Tw6Lqf2Q1b+X6rd01/xHOTt2h2?=
 =?us-ascii?Q?5R9Gz20FKwtk0uMOYaiT/SAHydRxCkGmseDQ26wjcDxZhM8cfUUYGM/SSIq7?=
 =?us-ascii?Q?CxgJUT347+CmZi6vXmawDkcadiCIG+CsNnudZLpOGLJFkkd9M9fSKRZC6t8W?=
 =?us-ascii?Q?I7lCHvu5LU6BrjTxEn+JqmIQzj9HxSujI93tn7NTy0QOZJ2jldZPubBNLcqJ?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2083F3E7FFB39E458CA48CF255CCE32C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb14a86-4800-4269-951c-08da716f1619
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 14:31:55.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61cxmy8twReJiyyvFxv04LbJwBrN/dXQH9ishS3VW2Iig0lefyc4un+IRU7YUkK+TrsEv+IvRuUzPuHUYT4iFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_16,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=584 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290065
X-Proofpoint-GUID: 0ufHP74_OG8toRv-Grcre-_pnZKsKWtY
X-Proofpoint-ORIG-GUID: 0ufHP74_OG8toRv-Grcre-_pnZKsKWtY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 28, 2022, at 9:27 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 29 Jul 2022, Chuck Lever III wrote:
>>=20
>>> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> Also move the 'fill' calls closer to the operation that might change th=
e
>>> attributes.  This way they are avoided on some error paths.
>>>=20
>>> For the v2-only code in nfsproc.c, drop the fill calls as they aren't
>>> needed.
>>=20
>> This feels like 3 independent changes to me. At least the v2 change
>> should be moved to a separate patch. Relocating the "fill attrs" calls
>> seems like it could cause noticeable behavior changes, so maybe it
>> belongs also in a separate patch?
>=20
> Three intimately related changes that could be applied in sequence.
> What would be gained by having separate patches?
> To my mind, the primary issue is review effort.  Mixing unrelated
> changes make review of each change harder, so keep them separate.
> Mixing related changes is less of a problem as the abstraction that you
> need to keep front-of-mind are fewer.
> On the flip side, every patch added increases the review burden.  If I
> wanted to move all calls to foo(), I wouldn't have one patch for each
> call.
> I think that patch is easy to review as it stands, but if you think not
> I guess it could be split.
>=20
> Allowing bisect to isolate the problem precisely is another reason for
> keeping patches small.  If a bug were found to be caused by this patch I
> doubt it would be at all hard to localise which part of the patch caused
> it.

I adjusted the patch description and left the content as a single
patch. I was initially confused by "drop the fill calls"... the
patch is not physically removing code.

--
Chuck Lever



