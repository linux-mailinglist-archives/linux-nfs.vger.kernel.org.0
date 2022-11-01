Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D78615470
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 22:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKAVuP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 17:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKAVuK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 17:50:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0146270E
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:50:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1LjD0a024506;
        Tue, 1 Nov 2022 21:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=z7ZkFwCBn7LRDoHH3NWyzBxHnBMT8iIAh6LWcGL2HHo=;
 b=tiPV68RbkKKQJ+Cm0rXvjd8dNxwIHPgmkxlAFjjEdXSdLCMYtMOHnvpGZGCKfoSfwLjZ
 0BuEWYMcQJIA5eX3+sXv3a3CSG4YKhKmtUr2IiEM88AfUiHnV2OqCze8257J/+MwNKpb
 0k64A1/SsTiwGl0wmJly8g4jXxArO9gukIygj9jYK1qvKFlo3dGH8ODPLHOQj7JRGlo4
 gcZOIm3UUlnDXp7J0eXhSGTWSCvJJePjEHi5YI7O2zJutE1TtZB34dGmReAIoel2TflC
 t3zPvRqavMQt35SJYo8E9VXv6RCG/SS8qTUXgEzBJoy4anTLUCp7M9nlFpX6Zn45p7Gp aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2afuxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:50:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KVBM9030309;
        Tue, 1 Nov 2022 21:50:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4we85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Pfdn2wi+tQ4WKfwuZj5e4MeKGWXjYI19ArSjXylGxZCniRL20sFCx479EGaAYc7caO+aWCtey8drRnze29SmEhuXQx4DEFWRtdjL7ICohUq8s6PW7/JsNUIZQDxi3ac1JkL+kwv4DhPMtaDh5dJGhuQs4fAD8vPOJADO5Z+a6d6T0htKFIyTyCcJF2R1mT3Ap9KKniysfhd0dxYxlqRHmVthCUwdI0917e+1ldCCVf6q03ONaorN12GlerdmJSrzw2QhfJfDEVj4DQu2aaRTgMqw63281y2nt/Sd8RY1BelqU1xIysRhaE6kK2WM+E9uXiIRa9tX9PLNLXjyw8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7ZkFwCBn7LRDoHH3NWyzBxHnBMT8iIAh6LWcGL2HHo=;
 b=HU9rdtWf44Xn5aSqiqcakP50k24ZQPegazlakA6KOjO9eFYmMgoNxSd2UUZ+KoFo78DzgcYzbUpbsNumGJvNg22qSFVhqHEPUbwReJHyRyQhj119zMFqlh9PY8attugsfqQeUBN5T+T5HacSDjkBBNul1gkOTJQq1lyRJiGNMtaMjacd6MnV9HY/PdTn9mwIXgsKb0GneqZGgo6OocAES6/AEQpLgncXX08huVXSNOmPNdZdwmZUdDl84Nvc2SijPlTXsDPpo+eVeGBgzMpvQ/eH3TkBGcpCq4CEq9aUKajABUW2QChOPB/8dHFIy4uxXS5VmxI+UL02KT99A0mHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7ZkFwCBn7LRDoHH3NWyzBxHnBMT8iIAh6LWcGL2HHo=;
 b=ADWeDO81+mRs0BbYawOOlt0cKMJkTeVmUPoYYwp1dD3nj/B/7sFZPr7unl1b1wMevKxGDPu4CN1XOt3N3TyBhR8NLply0/fsMlOGg/YVEF3q8A6qFIFyMrM8LWQU5rznuu5Avp511PBGJU5rpGjA9ITRHPC/rwiK6SW3nDzks+o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5641.namprd10.prod.outlook.com (2603:10b6:510:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 21:49:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 21:49:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Topic: [PATCH v5 3/5] nfsd: rework refcounting in filecache
Thread-Index: AQHY7gDKf+UJMCSoA0e+WwOAy53hT64qlIAAgAAEOACAAAMKgA==
Date:   Tue, 1 Nov 2022 21:49:58 +0000
Message-ID: <CAA2B2A0-51D0-47E2-A6CB-D89FEA5489EC@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
 <20221101144647.136696-4-jlayton@kernel.org>
 <166733783854.19313.2332783814411405159@noble.neil.brown.name>
 <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
In-Reply-To: <bb8a4e623371ad4ac9d49f2cbe0d4880e8ba52ef.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5641:EE_
x-ms-office365-filtering-correlation-id: 34c52c1d-88cd-4e97-56eb-08dabc53054e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUIu2Mgw6rx4v0XWDjgYPDD79nq1Yh2alHUKHnvpOyn+SHMpHLL7OIQUrZwl30bzeGmQt9HY0HBJZfwa8bnkJH7ndiS1BnAJegxV2Un702igBY5DRgi7xb4bfKRiNeqlAkqEUfYeCW5+3uWAyXwi8UZx6VIeCgqdj78+rJk/WS0+6fPp363pjdeSEL7lK+SgvKaAaopjoal2ZV5GKVrAQNjFCO3uiEOvWOvuWlFH92iYr9e/halPItlFtcg4bEjhABqP6/BfAPFvAS2OUIvWdVAcdAO+GfvNER3+M6tK+6LPwYROwAkZjGvzKy7zoBwCxkX5Dc/3wH6XjlNSTY9A4yoRBmVo2GkojVoyUE/+pGxCDx9CNScimeIwV5zREItE+juGG3N6lkoNweYqdVAImPSaKDLmMa/UcBuGsMM/SZWqs26D/ygb1guvCOm+BU+LSlTeGseiIEL+MfCOvDoysaiWK7SMMLfryk0S3EYr+PU4e1+EG6kyb/4ZrNWpLpl5ZCidfKR9unhQOOts5hu4QtUcBXEzJ05iJXiW40zttKjwd8f7X170aWA9EWF9KBVnGUiYP2JeGDAtgCbCum2vQ1ke6Ts0kIxmOSYDGXnRFoI/8s7oxjOhWYXQ6Hnp2MUUNOSBoM2mrcUhRnUSutQqa0ma625XmE3+5c0bA/rU4RRqh7nc12nKRw9ORJWYslKF5wwqGS7fiI3csxnyQzBHKw0GzDrZOsPN2BXQbSt+GQeejBuwPrBw0mGkXb4IJLiXFv8lM+OxFLj2aJyvQa5GMtabjnu8WUp3HskYd5f2NC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(66556008)(6506007)(26005)(64756008)(91956017)(316002)(110136005)(30864003)(2616005)(8936002)(186003)(38100700002)(8676002)(36756003)(4326008)(2906002)(66446008)(33656002)(6512007)(76116006)(41300700001)(86362001)(83380400001)(66946007)(53546011)(6486002)(478600001)(38070700005)(71200400001)(66899015)(66476007)(122000001)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qXrJ+BDf8A25TKkP/1qce5geVa76ogAnF/pzN4wwk6vm5PS9vpOlZFT3zUkO?=
 =?us-ascii?Q?F6u1NWeaC6DCTAOPiInQ6ycmdLSP6vxtuXBxwQCSgtvX/R/WMYkc86evTWid?=
 =?us-ascii?Q?cp7jTv4YHsGZ+RftY7A69Qvr6yPp7TjDZZ0EyWX4xpFjzmwqtdhCeIbyoSj/?=
 =?us-ascii?Q?ss9lkCKp3efyrhSCcmy2vqFKq4kr/TY+8aP7FT53LWeeJj+LrrMQKi7yK9Tp?=
 =?us-ascii?Q?VcGLTou6vUSFdyBgyO72NSbbeABAOpYt0Ch4Yc/2PzWhOwadzld1DweinLY0?=
 =?us-ascii?Q?eOc/dPp9pKWutBCDv2Oyh3EV/OD7oqFqxVwnTpOAKctm3NJ3smFbzcx5WoeM?=
 =?us-ascii?Q?8/HQXJ5tc3XAhtCTsqTocB5dRSFCS13Bnt8ZjuVy781pbZBeu5i11k8R7HdO?=
 =?us-ascii?Q?QVtPtTM1muWuxgJh9DhvmGBvBct9aM6pkWRWO/TEorQq7lBNpnegBPPeX0A9?=
 =?us-ascii?Q?ypdI6ZGW6+IQGQ/LoqHRYLuJ+gQbHuEN/SbU2750+su/4axdqWWYWdwQmnJt?=
 =?us-ascii?Q?D8AXWh02MLcSRqK3YyJn8aPVvkKpPv+B+B09KeDHjt1TTxHcYAw7pLYdfJe2?=
 =?us-ascii?Q?AxTcYiNKQgQYbxLy/PCgJ3eQkTM7i0AuYD72fLlQ82d17pZO30IHDUW+SJBo?=
 =?us-ascii?Q?C/pY5i7aytPc8d8fGDXVIVBuAleyhMOHj0OzAf6dKZc6cjGJNk0P2ZEDccpZ?=
 =?us-ascii?Q?8RqmxuP3vCZU7IdFSXMIrCbpxIyeWDaBY7x/mJ9UK1HfbHnVvQ3vYRK3Y1Ye?=
 =?us-ascii?Q?LFRNoklxpCs+unu1Xlz2bjLNvJwLpeTOOE8RBGKBgKOjgelgVYUYqXFyumio?=
 =?us-ascii?Q?YzIvpSF3HZMcBjwJlWiDqzkLPpbbyCJhZLBIeifiadwrXGa/8Lqp/uFtjoqw?=
 =?us-ascii?Q?I1lTQ9VkZ83w+IVS3SkGNXRZspAZ2+NrGLCiekw31UIDQwiH5SYWasbiVGNp?=
 =?us-ascii?Q?y817rFgV1I4IDZ6M8ZDd9NIeMkgPElCyuhUiGNMlegWKSUsmBROaz8mxH45c?=
 =?us-ascii?Q?mwkp5/6ET2zuD25tvm4nsa+jGwUPbSMzi0DS6pz8zTRwpNBhtGFewIU1ozPj?=
 =?us-ascii?Q?tJ7i2dju8ynJ8qzLWlkL/ySJgj35Ajfp05bkwhgjXp/LyHV2NtV/oHDr5F7e?=
 =?us-ascii?Q?zrglAt3crBYifgX/RuOJ8RH+Qv94y1zNZ+3CTSCpbva9RxACOF63byq+auDC?=
 =?us-ascii?Q?GBpn3+CvrNiP8SidiKWD//SluDyJp2OpV3uCAoRR4e3y6u4m78hTioTpmVKG?=
 =?us-ascii?Q?7nYf2jtZTU0XvqJ3w9CtmTbdiwaxfTbggkw7BcrbKIsCOAHayCAQRrYoezlA?=
 =?us-ascii?Q?sKAdDncg6zmzzKFjn6ysjX5cu/cMm7kqdGpXjstMv3/GpqCkg2oycAA5Aulx?=
 =?us-ascii?Q?O0t+t1na0S+kNDeEAgwsqb9PMRuawYPTlD8RxNADOojpiMv7R3Xu/oFmu3vZ?=
 =?us-ascii?Q?GVMsah3w5zb6WrxfpN9c2kf0EuayUYkBShYazPZsU6pj6SewL9My6ZshEw77?=
 =?us-ascii?Q?PWbdUFz8CQ4ujxGBXWIVVjnocXvqblPQYKQrbuoseCW7N47pA15VNOKX+ciB?=
 =?us-ascii?Q?r4B8OhRyUh8ty72TWvzYY4UsU1lWum5xpt8Ra2dq6lPEoftkPGHCc45quGuc?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FEA2F599CBE5A44942659AABD6914EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c52c1d-88cd-4e97-56eb-08dabc53054e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 21:49:58.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/4s9+RrU5qb2f4YTxzYlQj57uf5I0bxDWImzFVKXa6kfvxmG/aO2pLCOokVYMrVAmvlzS7HdXFsCIBWHlzpxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010149
X-Proofpoint-ORIG-GUID: 0VyXkryWbthBBSyeTtJ4wS9Jwa0W4zeE
X-Proofpoint-GUID: 0VyXkryWbthBBSyeTtJ4wS9Jwa0W4zeE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2022, at 5:39 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2022-11-02 at 08:23 +1100, NeilBrown wrote:
>> On Wed, 02 Nov 2022, Jeff Layton wrote:
>>> The filecache refcounting is a bit non-standard for something searchabl=
e
>>> by RCU, in that we maintain a sentinel reference while it's hashed. Thi=
s
>>> in turn requires that we have to do things differently in the "put"
>>> depending on whether its hashed, which we believe to have led to races.
>>>=20
>>> There are other problems in here too. nfsd_file_close_inode_sync can en=
d
>>> up freeing an nfsd_file while there are still outstanding references to
>>> it, and there are a number of subtle ToC/ToU races.
>>>=20
>>> Rework the code so that the refcount is what drives the lifecycle. When
>>> the refcount goes to zero, then unhash and rcu free the object.
>>>=20
>>> With this change, the LRU carries a reference. Take special care to
>>> deal with it when removing an entry from the list.
>>=20
>> The refcounting and lru management all look sane here.
>>=20
>> You need to have moved the final put (and corresponding fsync) to
>> different threads.  I think I see you and Chuck discussing that and I
>> have no sense of what is "right".=20
>>=20
>=20
> Yeah, this is a tough call. I get Chuck's reticence.
>=20
> One thing we could consider is offloading the SYNC_NONE writeback
> submission to a workqueue. I'm not sure though whether that's a win --
> it might just add needless context switches. OTOH, that would make it
> fairly simple to kick off writeback when the REFERENCED flag is cleared,
> which would probably be the best time to do it.

A simple approach might be to just defer freeing of any file opened for
WRITE to a workqueue, and let one final sync happen there.

Splitting this into an async flush followed by a second sync means you're
walking through the pages of the entire file twice. Only one time is any
real work done, in most cases.

Garbage collection has to visit (and flush out) a lot of files when the
server is handling a heavy workload. I think that single thread needs
to run with as little friction as possible, and then defer I/O-related
work using a multi-threaded model. A work queue would be simple and ideal.


> An entry that ends up being harvested by the LRU scanner is going to be
> touched by it at least twice: once to clear the REFERENCED flag, and
> again ~2s later to reap it.
>=20
> If we schedule writeback when we clear the flag then we have a pretty
> good indication that nothing else is going to be using it (though I
> think we need to clear REFERENCED even when nfsd_file_check_writeback
> returns true -- I'll fix that in the coming series).
>=20
> In any case, I'd probably like to do that sort of change in a separate
> series after we get the first part sorted.

Yep, later works for me too.


>> But it would be nice to explain in
>> the comment what is being moved and why, so I could then confirm that
>> the code matches the intent.
>>=20
>=20
> I'm happy to add comments, but I'm a little unclear on what you're
> confused by here. It's a bit too big of a patch for me to give a full
> play-by-play description. Can you elaborate on what you'd like to see?
>=20
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 247 ++++++++++++++++++++++----------------------
>>> fs/nfsd/trace.h     |   1 +
>>> 2 files changed, 123 insertions(+), 125 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 0bf3727455e2..e67297ad12bf 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -303,8 +303,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
>>> 		if (key->gc)
>>> 			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>>> 		nf->nf_inode =3D key->inode;
>>> -		/* nf_ref is pre-incremented for hash table */
>>> -		refcount_set(&nf->nf_ref, 2);
>>> +		refcount_set(&nf->nf_ref, 1);
>>> 		nf->nf_may =3D key->need;
>>> 		nf->nf_mark =3D NULL;
>>> 	}
>>> @@ -353,24 +352,35 @@ nfsd_file_unhash(struct nfsd_file *nf)
>>> 	return false;
>>> }
>>>=20
>>> -static bool
>>> +static void
>>> nfsd_file_free(struct nfsd_file *nf)
>>> {
>>> 	s64 age =3D ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
>>> -	bool flush =3D false;
>>>=20
>>> 	trace_nfsd_file_free(nf);
>>>=20
>>> 	this_cpu_inc(nfsd_file_releases);
>>> 	this_cpu_add(nfsd_file_total_age, age);
>>>=20
>>> +	nfsd_file_unhash(nf);
>>> +
>>> +	/*
>>> +	 * We call fsync here in order to catch writeback errors. It's not
>>> +	 * strictly required by the protocol, but an nfsd_file coule get
>>> +	 * evicted from the cache before a COMMIT comes in. If another
>>> +	 * task were to open that file in the interim and scrape the error,
>>> +	 * then the client may never see it. By calling fsync here, we ensure
>>> +	 * that writeback happens before the entry is freed, and that any
>>> +	 * errors reported result in the write verifier changing.
>>> +	 */
>>> +	nfsd_file_fsync(nf);
>>> +
>>> 	if (nf->nf_mark)
>>> 		nfsd_file_mark_put(nf->nf_mark);
>>> 	if (nf->nf_file) {
>>> 		get_file(nf->nf_file);
>>> 		filp_close(nf->nf_file, NULL);
>>> 		fput(nf->nf_file);
>>> -		flush =3D true;
>>> 	}
>>>=20
>>> 	/*
>>> @@ -378,10 +388,9 @@ nfsd_file_free(struct nfsd_file *nf)
>>> 	 * WARN and leak it to preserve system stability.
>>> 	 */
>>> 	if (WARN_ON_ONCE(!list_empty(&nf->nf_lru)))
>>> -		return flush;
>>> +		return;
>>>=20
>>> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
>>> -	return flush;
>>> }
>>>=20
>>> static bool
>>> @@ -397,17 +406,23 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>>> 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>>> }
>>>=20
>>> -static void nfsd_file_lru_add(struct nfsd_file *nf)
>>> +static bool nfsd_file_lru_add(struct nfsd_file *nf)
>>> {
>>> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
>>> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru))
>>> +	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
>>> 		trace_nfsd_file_lru_add(nf);
>>> +		return true;
>>> +	}
>>> +	return false;
>>> }
>>>=20
>>> -static void nfsd_file_lru_remove(struct nfsd_file *nf)
>>> +static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>>> {
>>> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru))
>>> +	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
>>> 		trace_nfsd_file_lru_del(nf);
>>> +		return true;
>>> +	}
>>> +	return false;
>>> }
>>>=20
>>> struct nfsd_file *
>>> @@ -418,86 +433,80 @@ nfsd_file_get(struct nfsd_file *nf)
>>> 	return NULL;
>>> }
>>>=20
>>> -static void
>>> +/**
>>> + * nfsd_file_unhash_and_queue - unhash a file and queue it to the disp=
ose list
>>> + * @nf: nfsd_file to be unhashed and queued
>>> + * @dispose: list to which it should be queued
>>> + *
>>> + * Attempt to unhash a nfsd_file and queue it to the given list. Each =
file
>>> + * will have a reference held on behalf of the list. That reference ma=
y come
>>> + * from the LRU, or we may need to take one. If we can't get a referen=
ce,
>>> + * ignore it altogether.
>>> + */
>>> +static bool
>>> nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *disp=
ose)
>>> {
>>> 	trace_nfsd_file_unhash_and_queue(nf);
>>> 	if (nfsd_file_unhash(nf)) {
>>> -		/* caller must call nfsd_file_dispose_list() later */
>>> -		nfsd_file_lru_remove(nf);
>>> +		/*
>>> +		 * If we remove it from the LRU, then just use that
>>> +		 * reference for the dispose list. Otherwise, we need
>>> +		 * to take a reference. If that fails, just ignore
>>> +		 * the file altogether.
>>> +		 */
>>> +		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
>>> +			return false;
>>> 		list_add(&nf->nf_lru, dispose);
>>> +		return true;
>>> 	}
>>> +	return false;
>>> }
>>>=20
>>> -static void
>>> -nfsd_file_put_noref(struct nfsd_file *nf)
>>> -{
>>> -	trace_nfsd_file_put(nf);
>>> -
>>> -	if (refcount_dec_and_test(&nf->nf_ref)) {
>>> -		WARN_ON(test_bit(NFSD_FILE_HASHED, &nf->nf_flags));
>>> -		nfsd_file_lru_remove(nf);
>>> -		nfsd_file_free(nf);
>>> -	}
>>> -}
>>> -
>>> -static void
>>> -nfsd_file_unhash_and_put(struct nfsd_file *nf)
>>> -{
>>> -	if (nfsd_file_unhash(nf))
>>> -		nfsd_file_put_noref(nf);
>>> -}
>>> -
>>> +/**
>>> + * nfsd_file_put - put the reference to a nfsd_file
>>> + * @nf: nfsd_file of which to put the reference
>>> + *
>>> + * Put a reference to a nfsd_file. In the v4 case, we just put the
>>> + * reference immediately. In the GC case, if the reference would be
>>> + * the last one, the put it on the LRU instead to be cleaned up later.
>>> + */
>>> void
>>> nfsd_file_put(struct nfsd_file *nf)
>>> {
>>> 	might_sleep();
>>> +	trace_nfsd_file_put(nf);
>>>=20
>>> -	if (test_bit(NFSD_FILE_GC, &nf->nf_flags))
>>> -		nfsd_file_lru_add(nf);
>>> -	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>>> -		nfsd_file_unhash_and_put(nf);
>>> -
>>> -	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> -		nfsd_file_fsync(nf);
>>> -		nfsd_file_put_noref(nf);
>>> -	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
>>> -		nfsd_file_put_noref(nf);
>>> -		nfsd_file_schedule_laundrette();
>>> -	} else
>>> -		nfsd_file_put_noref(nf);
>>> -}
>>> -
>>> -static void
>>> -nfsd_file_dispose_list(struct list_head *dispose)
>>> -{
>>> -	struct nfsd_file *nf;
>>> -
>>> -	while(!list_empty(dispose)) {
>>> -		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>> -		list_del_init(&nf->nf_lru);
>>> -		nfsd_file_fsync(nf);
>>> -		nfsd_file_put_noref(nf);
>>> +	/*
>>> +	 * The HASHED check is racy. We may end up with the occasional
>>> +	 * unhashed entry on the LRU, but they should get cleaned up
>>> +	 * like any other.
>>> +	 */
>>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
>>> +	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> +		/*
>>> +		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
>>> +		 * it to the LRU. If the add to the LRU fails, just put it as
>>> +		 * usual.
>>> +		 */
>>> +		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf)) {
>>> +			nfsd_file_schedule_laundrette();
>>> +			return;
>>> +		}
>>> 	}
>>> +	if (refcount_dec_and_test(&nf->nf_ref))
>>> +		nfsd_file_free(nf);
>>> }
>>>=20
>>> static void
>>> -nfsd_file_dispose_list_sync(struct list_head *dispose)
>>> +nfsd_file_dispose_list(struct list_head *dispose)
>>> {
>>> -	bool flush =3D false;
>>> 	struct nfsd_file *nf;
>>>=20
>>> 	while(!list_empty(dispose)) {
>>> 		nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>> 		list_del_init(&nf->nf_lru);
>>> -		nfsd_file_fsync(nf);
>>> -		if (!refcount_dec_and_test(&nf->nf_ref))
>>> -			continue;
>>> -		if (nfsd_file_free(nf))
>>> -			flush =3D true;
>>> +		nfsd_file_free(nf);
>>> 	}
>>> -	if (flush)
>>> -		flush_delayed_fput();
>>> }
>>>=20
>>> static void
>>> @@ -567,21 +576,8 @@ nfsd_file_lru_cb(struct list_head *item, struct li=
st_lru_one *lru,
>>> 	struct list_head *head =3D arg;
>>> 	struct nfsd_file *nf =3D list_entry(item, struct nfsd_file, nf_lru);
>>>=20
>>> -	/*
>>> -	 * Do a lockless refcount check. The hashtable holds one reference, s=
o
>>> -	 * we look to see if anything else has a reference, or if any have
>>> -	 * been put since the shrinker last ran. Those don't get unhashed and
>>> -	 * released.
>>> -	 *
>>> -	 * Note that in the put path, we set the flag and then decrement the
>>> -	 * counter. Here we check the counter and then test and clear the fla=
g.
>>> -	 * That order is deliberate to ensure that we can do this locklessly.
>>> -	 */
>>> -	if (refcount_read(&nf->nf_ref) > 1) {
>>> -		list_lru_isolate(lru, &nf->nf_lru);
>>> -		trace_nfsd_file_gc_in_use(nf);
>>> -		return LRU_REMOVED;
>>> -	}
>>> +	/* We should only be dealing with GC entries here */
>>> +	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>>>=20
>>> 	/*
>>> 	 * Don't throw out files that are still undergoing I/O or
>>> @@ -592,40 +588,30 @@ nfsd_file_lru_cb(struct list_head *item, struct l=
ist_lru_one *lru,
>>> 		return LRU_SKIP;
>>> 	}
>>>=20
>>> +	/* If it was recently added to the list, skip it */
>>> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
>>> 		trace_nfsd_file_gc_referenced(nf);
>>> 		return LRU_ROTATE;
>>> 	}
>>>=20
>>> -	if (!test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>>> -		trace_nfsd_file_gc_hashed(nf);
>>> -		return LRU_SKIP;
>>> +	/*
>>> +	 * Put the reference held on behalf of the LRU. If it wasn't the last
>>> +	 * one, then just remove it from the LRU and ignore it.
>>> +	 */
>>> +	if (!refcount_dec_and_test(&nf->nf_ref)) {
>>> +		trace_nfsd_file_gc_in_use(nf);
>>> +		list_lru_isolate(lru, &nf->nf_lru);
>>> +		return LRU_REMOVED;
>>> 	}
>>>=20
>>> +	/* Refcount went to zero. Unhash it and queue it to the dispose list =
*/
>>> +	nfsd_file_unhash(nf);
>>> 	list_lru_isolate_move(lru, &nf->nf_lru, head);
>>> 	this_cpu_inc(nfsd_file_evictions);
>>> 	trace_nfsd_file_gc_disposed(nf);
>>> 	return LRU_REMOVED;
>>> }
>>>=20
>>> -/*
>>> - * Unhash items on @dispose immediately, then queue them on the
>>> - * disposal workqueue to finish releasing them in the background.
>>> - *
>>> - * cel: Note that between the time list_lru_shrink_walk runs and
>>> - * now, these items are in the hash table but marked unhashed.
>>> - * Why release these outside of lru_cb ? There's no lock ordering
>>> - * problem since lru_cb currently takes no lock.
>>> - */
>>> -static void nfsd_file_gc_dispose_list(struct list_head *dispose)
>>> -{
>>> -	struct nfsd_file *nf;
>>> -
>>> -	list_for_each_entry(nf, dispose, nf_lru)
>>> -		nfsd_file_hash_remove(nf);
>>> -	nfsd_file_dispose_list_delayed(dispose);
>>> -}
>>> -
>>> static void
>>> nfsd_file_gc(void)
>>> {
>>> @@ -635,7 +621,7 @@ nfsd_file_gc(void)
>>> 	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
>>> 			    &dispose, list_lru_count(&nfsd_file_lru));
>>> 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
>>> -	nfsd_file_gc_dispose_list(&dispose);
>>> +	nfsd_file_dispose_list_delayed(&dispose);
>>> }
>>>=20
>>> static void
>>> @@ -660,7 +646,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrin=
k_control *sc)
>>> 	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
>>> 				   nfsd_file_lru_cb, &dispose);
>>> 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
>>> -	nfsd_file_gc_dispose_list(&dispose);
>>> +	nfsd_file_dispose_list_delayed(&dispose);
>>> 	return ret;
>>> }
>>>=20
>>> @@ -671,8 +657,11 @@ static struct shrinker	nfsd_file_shrinker =3D {
>>> };
>>>=20
>>> /*
>>> - * Find all cache items across all net namespaces that match @inode an=
d
>>> - * move them to @dispose. The lookup is atomic wrt nfsd_file_acquire()=
.
>>> + * Find all cache items across all net namespaces that match @inode, u=
nhash
>>> + * them, take references and then put them on @dispose if that was suc=
cessful.
>>> + *
>>> + * The nfsd_file objects on the list will be unhashed, and each will h=
ave a
>>> + * reference taken.
>>>  */
>>> static unsigned int
>>> __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
>>> @@ -690,8 +679,9 @@ __nfsd_file_close_inode(struct inode *inode, struct=
 list_head *dispose)
>>> 				       nfsd_file_rhash_params);
>>> 		if (!nf)
>>> 			break;
>>> -		nfsd_file_unhash_and_queue(nf, dispose);
>>> -		count++;
>>> +
>>> +		if (nfsd_file_unhash_and_queue(nf, dispose))
>>> +			count++;
>>> 	} while (1);
>>> 	rcu_read_unlock();
>>> 	return count;
>>> @@ -703,15 +693,23 @@ __nfsd_file_close_inode(struct inode *inode, stru=
ct list_head *dispose)
>>>  *
>>>  * Unhash and put all cache item associated with @inode.
>>>  */
>>> -static void
>>> +static unsigned int
>>> nfsd_file_close_inode(struct inode *inode)
>>> {
>>> -	LIST_HEAD(dispose);
>>> +	struct nfsd_file *nf;
>>> 	unsigned int count;
>>> +	LIST_HEAD(dispose);
>>>=20
>>> 	count =3D __nfsd_file_close_inode(inode, &dispose);
>>> 	trace_nfsd_file_close_inode(inode, count);
>>> -	nfsd_file_dispose_list_delayed(&dispose);
>>> +	while(!list_empty(&dispose)) {
>>> +		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
>>> +		list_del_init(&nf->nf_lru);
>>> +		trace_nfsd_file_closing(nf);
>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>> +			nfsd_file_free(nf);
>>> +	}
>>> +	return count;
>>> }
>>>=20
>>> /**
>>> @@ -723,19 +721,15 @@ nfsd_file_close_inode(struct inode *inode)
>>> void
>>> nfsd_file_close_inode_sync(struct inode *inode)
>>> {
>>> -	LIST_HEAD(dispose);
>>> -	unsigned int count;
>>> -
>>> -	count =3D __nfsd_file_close_inode(inode, &dispose);
>>> -	trace_nfsd_file_close_inode_sync(inode, count);
>>> -	nfsd_file_dispose_list_sync(&dispose);
>>> +	if (nfsd_file_close_inode(inode))
>>> +		flush_delayed_fput();
>>> }
>>>=20
>>> /**
>>>  * nfsd_file_delayed_close - close unused nfsd_files
>>>  * @work: dummy
>>>  *
>>> - * Walk the LRU list and close any entries that have not been used sin=
ce
>>> + * Walk the LRU list and destroy any entries that have not been used s=
ince
>>>  * the last scan.
>>>  */
>>> static void
>>> @@ -1056,8 +1050,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>>> 	rcu_read_lock();
>>> 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
>>> 			       nfsd_file_rhash_params);
>>> -	if (nf)
>>> -		nf =3D nfsd_file_get(nf);
>>> +	if (nf) {
>>> +		if (!nfsd_file_lru_remove(nf))
>>> +			nf =3D nfsd_file_get(nf);
>>> +	}
>>> 	rcu_read_unlock();
>>> 	if (nf)
>>> 		goto wait_for_construction;
>>> @@ -1092,11 +1088,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>>> 			goto out;
>>> 		}
>>> 		open_retry =3D false;
>>> -		nfsd_file_put_noref(nf);
>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>> +			nfsd_file_free(nf);
>>> 		goto retry;
>>> 	}
>>>=20
>>> -	nfsd_file_lru_remove(nf);
>>> 	this_cpu_inc(nfsd_file_cache_hits);
>>>=20
>>> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may=
_flags));
>>> @@ -1106,7 +1102,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>> 			this_cpu_inc(nfsd_file_acquisitions);
>>> 		*pnf =3D nf;
>>> 	} else {
>>> -		nfsd_file_put(nf);
>>> +		if (refcount_dec_and_test(&nf->nf_ref))
>>> +			nfsd_file_free(nf);
>>> 		nf =3D NULL;
>>> 	}
>>>=20
>>> @@ -1133,7 +1130,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>> 	 * then unhash.
>>> 	 */
>>> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>>> -		nfsd_file_unhash_and_put(nf);
>>> +		nfsd_file_unhash(nf);
>>> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>>> 	smp_mb__after_atomic();
>>> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 940252482fd4..a44ded06af87 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -906,6 +906,7 @@ DEFINE_EVENT(nfsd_file_class, name, \
>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
>>> +DEFINE_NFSD_FILE_EVENT(nfsd_file_closing);
>>> DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
>>>=20
>>> TRACE_EVENT(nfsd_file_alloc,
>>> --=20
>>> 2.38.1
>>>=20
>>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



