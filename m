Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22C611B70
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 22:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJ1UMf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1UMe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 16:12:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2109.outbound.protection.outlook.com [40.107.95.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6D27176;
        Fri, 28 Oct 2022 13:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsF+C/XbTYfyDisaB+YY+Svf/djXN4NZ4UcCyAM85KPE6c74Ex8bkDasQzYR9p/n+V65gRUG7ifKQv/OcMeTBz3c9FwYuKN4gUUwAW3EGoYSwPze9+QEeCPUAItp1bQckVViX5oAOM5jc8Cd1IEThmBKVQnCaYH9E1wtcbMyKhMFWV1dphNNwlLD0TVCYTgfmX3FigJMvXkSKtHzsILeZMfBRWIwm9MiHpFatXSaAfJqXVmWABKOpJMbA0rIkR0vxTfWl2FKiVNPVeZonfQ5Z451xOFk9GaZTIvxYFD/m8HDK9AEccWUVH5uFUuB+m/Jpz1BBPi4waytx0HK9Gtepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+11px2V5e0KDc8oLGpfDKBKTHgoZf6AfqCbh3p/rdk=;
 b=SD92stcn70OorSUjyHztxT++Iu6i1Qefze6IIKUp+Nv8h1fjDfI8+LpJmEYlJ/6/TdL8YPlbH290um0vamd8MEdikFE9J37j8qw3NHBb//myjRhZ7tb0/3syzcE5rnAuFxRfNxtOkF6qP6hnPNEZMTluUMxXZNzeECzoKQEU9cvwpFmj8Gml0pDmA5yvY7vKU5Duw/veKg8yT9L26rg5PeaVloMKZwrviWAayr2MKP6W+NpIbVHXiBuzAYWwNC+WLxQno60/3jFRuKGwx0Ejbr5TMJDiZ/oyX1Bev1p57SayyYxUvRMJcLOpJE4g+MS8fWD4xIraW8NWsohUfgPFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+11px2V5e0KDc8oLGpfDKBKTHgoZf6AfqCbh3p/rdk=;
 b=BUM0FKn2IeMGhCZuXwEojsm0mCGcgDZwVyBBQzUFYgCrAPr90+zJ0gk9kXfM6KWOaj43QrdEWGQXgg2skBNlBWkOt3KVye8Hh0BWhExq28d3BSVv8yO+D/gQaO/xLOqJF7sUJcFdxG+XusG0iUto5EKLCUaGtvzcU9dMCD88tZc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4069.namprd13.prod.outlook.com (2603:10b6:208:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Fri, 28 Oct
 2022 20:12:30 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%4]) with mapi id 15.20.5791.009; Fri, 28 Oct 2022
 20:12:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna Schumaker <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Thread-Topic: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Thread-Index: AQHY6v4TOWSLEQmUbESsXe/9l99ZN64kPS2A
Date:   Fri, 28 Oct 2022 20:12:30 +0000
Message-ID: <A016D74D-CDFC-4CAB-9AE4-C1688C9A49A1@hammerspace.com>
References: <20221027150525.753064657@goodmis.org>
 <20221028145005.28bc324d@gandalf.local.home>
In-Reply-To: <20221028145005.28bc324d@gandalf.local.home>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB4069:EE_
x-ms-office365-filtering-correlation-id: da85e3c4-df41-4523-1d52-08dab920bdee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TCLKFAR9ZtD5z2ry3JQYiJxdjn43jcwsOhqT58xQQcnqHuj3u5EKr5hcOFFBJ6wYP+sED5YP665Z/H6XVvEqsVzW82EROMxmUo9rPADOAt7ntc+Lu39dULes4RsRiC8FgPJCHLfdMAD5LsF6OrW5V+17B7Osc0P1+BiasbuiAxHnP6LNI4+qe6QgrWkAYI4xlRtiRlgFikAaGLXOEb60dCf+enuiVXUxQgoIGR3COn54K9VWHWnSKIfYxQrdmOwB10oDNhVG9mt9a7e+RhaZy2FFsy2b1B/Sx2yrd5AOACjYOy7/THS5LTEsXxMs8hq7ck2o3PoFt1UHFB9TvjZ0D9VJ4X6kAdHx4nv1jnm4jdEMkZnsum6curmq9x3WbaJ5ve85ursT9q4Rs79gVGcWJcU4Wc5O0Yl4vV0McQkMDKf5O9zoZEg6la88mAcCLgcm00D42uPMOrAUgdYwf1wdcrypY63+MjWYRwu2E224Z3mYIl+iyp2CcV8MS4w5lvY1qUFMPXiZ+p52jRYhhA1SglKS+c+AcLm0kBEnxEcG0FV0l1whNVCb3Ecyc+IR1ReniInBylN44vuVWwpQOjEtkiadebASGh4267goWFYXVzj1ouO2k68GkR16E9pUSpkV3Nh/L4Nu3L0KgBHYSYdIr1D9A4ipynoAe24s8L10LYSz6J82pPLbpABkfMm7mzTZ43TL8OV98IjlMMo2GQnrMihIHrkTVxG9LjRqM2wlvDN9Rr8SDFKWBwbB6JH79WBIriTvSyZoPIPpCb/ZP5svWno1WTGSfQ0itnldopo+agE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39840400004)(376002)(396003)(346002)(136003)(451199015)(38070700005)(122000001)(6506007)(2906002)(64756008)(66556008)(66946007)(76116006)(66476007)(6916009)(4326008)(36756003)(53546011)(66446008)(316002)(8676002)(54906003)(83380400001)(2616005)(33656002)(86362001)(6512007)(26005)(41300700001)(186003)(5660300002)(8936002)(478600001)(6486002)(71200400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QyoMXgykAtlZg1pRHzO62i1/bPZSkZx37mnPrSnWeVabUDM9a/rqAVR3S/wP?=
 =?us-ascii?Q?te53wPAEWT1ybOT5y8XeqI+/kkh47lcKYxdMqn+uqyYznOojVaEpGjWQykk7?=
 =?us-ascii?Q?StJuCqLawFP93s1620oiDnacg6MLBT2lXYu9BhWFtvjYj6dBv+kbIH4PQsjS?=
 =?us-ascii?Q?ijUBCSxWNwyrEqZiKn7h9oqZ6FqzeCf12UOZyJ8cUXjOFDf91TRcADF2x9/k?=
 =?us-ascii?Q?3UzJ9SnmwzeOGcxzoi/DPRkveqS5cxx7vnViNICEaDRNAKSL0ziFkIGO/e9R?=
 =?us-ascii?Q?qNIjqrPRkB4yIjP5EebTgsvS5OFxI+7erAtasrpaY9ALbhhTcMvE2FwnGZ1G?=
 =?us-ascii?Q?a4tBPogOeNqBn1AHTqXVWwPX43ApCPtKZAlI94cbsZvIIvX36kdUem5/4IVb?=
 =?us-ascii?Q?cBBa5lKkNuZpYp9MRCJTHYM7Z/lMm9/6cdBnnrUWTIbGYFUUAYH17jR8z7R5?=
 =?us-ascii?Q?c/jJE/Qop4kg1F4Qppr6c4Y3RELqF2FF65it3E9bIDwr8xV5Wt6smS1LE4H7?=
 =?us-ascii?Q?1PE+fKomYHchS1FrsqRy7kjPPCn2lIPUQ4gNbeTdU40Id/JsRGvkidbUN4Sq?=
 =?us-ascii?Q?5VxkcvG8TURcwbnmSH6t2E+WfyCRTqzloEpqB9XJOnwkFCgxuChXQ9ynWRag?=
 =?us-ascii?Q?jaMVhfr1/v+VziKwGhFPt9EmlH1fva13V9AyMRBaEtrlEIccOGXPv2HjRJju?=
 =?us-ascii?Q?YHQzirTKRK6FSkLTJMsS3dS2j7+Lb4zXKG/0cUbf/m6c/h6kMPYE/NXn6X1d?=
 =?us-ascii?Q?onwMnH6quSlMXYJaFbLMqqELdXx24N5mvwhJ0jzd+oOjcLY87HWInP9zW40i?=
 =?us-ascii?Q?Gg0/YE0PpFaGOt/2QGBBteA8Z78BwpZcXNcbDF1c8DIJMryZNEwIM8hjIMEb?=
 =?us-ascii?Q?9sRFdi7bflOotY7p0ofHx0NFGYvXpSGueD0zaaCUsbTahSlmP7LNxQOrXnGi?=
 =?us-ascii?Q?Vol6hfA2vE3GAO5u2eT4BaKjSYzjTlL7vuv+l0H4e4Rg/00C2vzw2qP4iQgr?=
 =?us-ascii?Q?DUn8OiduzodJ0NLUShLLrWSywMzwxyDo0Wx3J9wulUF6lExIOMJjmqJrmVHY?=
 =?us-ascii?Q?CeJEeYcbSriCBQo7kyDsydlj0pway6czMMnI1KlrdVBy0OWq7iEfbA4FEp9L?=
 =?us-ascii?Q?To6/mlJzjadv+NJy8Ky5AhLGkoHLoGAXzDhqXVWWhU4bYehM6797+c05DA4f?=
 =?us-ascii?Q?uYv/ko7S57Wv5hv+RFV90mQX5OLpdQpbX2sbVHWBsbh16mCO/N6ANQzfw5l+?=
 =?us-ascii?Q?BOO3IDbPEQH79ch3kXziBV9Fr6ezt21O5EgUeVmSHO2EcC857yrT+BgoBmBQ?=
 =?us-ascii?Q?8978Q2GlxxUwop1SwghbzhH9KswXr4HmduB2i2OiteT5fUWphrzsPUKV0Hgy?=
 =?us-ascii?Q?9FNN4PNAHzY+9YB2srrwng2YsKuVsmBVmxoaeHO7fABVlFp8fIWLHXfivG8A?=
 =?us-ascii?Q?7ypFcw9rQJzPOfts9lsLT7pSq8Mt1rjiGv4CbCyiseKfd+5Jh0+5MKSSLbEW?=
 =?us-ascii?Q?pmbACCdzN3RI7t0c07BxWHnEyG92d8+YSuHFpFQeMxpGco6rGranTEqkl+Pw?=
 =?us-ascii?Q?4fh2Paczb+mDXgMpRmfMhNRdeV63Dj5SDBoQMSYkgu1NuE2Hq11SgQ9i/Kj8?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20ED1770BD05FD43BE4C650BFFE777F4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da85e3c4-df41-4523-1d52-08dab920bdee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 20:12:30.2625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82kz8xueak2RBpGcXSpavVgfQgsJ39b6jRknBx8FDcx29vIvEOYk3FF48HMxPYuzeAQ4iJ0hH1hHNEtJO8jFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

> On Oct 28, 2022, at 14:50, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> Trond,
>=20
> I'm looking at a commit from 2005:
>=20
> 0f9dc2b16884b ("RPC: Clean up socket autodisconnect")
>=20
>     Cancel autodisconnect requests inside xprt_transmit() in order to avo=
id
>     races.
>     Use more efficient del_singleshot_timer_sync()
>=20
>=20
> I'm working on adding a "shutdown" state to timers, making it required fo=
r
> freeing the timer. This is to address the numerous bugs we hit where time=
rs
> get rearmed just before freeing and then cause a crash in the timer code,
> without knowing what timer it was that caused it.
>=20
> Having a specific shutdown state for timers will remove this problem
> because if something tries to rearm a shutdown timer, it will fail and a
> WARN_ON_ONCE() is triggered. See below in the "reply" part for a
> description of this effort.
>=20
> The reason for this email, is because that WARN_ON_ONCE() triggered on th=
e
> mod_timer() from:
>=20
> static void
> xprt_schedule_autodisconnect(struct rpc_xprt *xprt)
> __must_hold(&xprt->transport_lock)
> {
> xprt->last_used =3D jiffies;
> if (RB_EMPTY_ROOT(&xprt->recv_queue) && xprt_has_timer(xprt))
> mod_timer(&xprt->timer, xprt->last_used + xprt->idle_timeout);
> }
>=20
> That's because xptr->timer was shutdown due to:
>=20
> int
> xprt_request_enqueue_receive(struct rpc_task *task)
> {
> [..]
> /* Turn off autodisconnect */
> del_singleshot_timer_sync(&xprt->timer);
> return 0;
> }
>=20
> Now singleshot means just that. It's a single shot and calling
> del_singleshot_timer_sync() will shut it down so that it can be freed. Th=
at
> also means that it can no longer be re-armed.
>=20
> I'm not sure what you meant by "Use more efficient del_singleshot_timer_s=
ync()"
> but I'm guessing since that was written in 2005, it is no longer relevant=
,
> and del_timer_sync() should now be used.
>=20
> After replacing that with del_timer_sync(), the warning goes away.
>=20
> I just want to confirm that's OK with you.

I seem to vaguely remember that at the time, del_timer_sync() would loop in=
 order to catch re-arming timers, whereas del_singleshot_timer_sync() would=
 not, hence the commit message. The expectation for del_singleshot_timer_sy=
nc() was simply that the caller would ensure safety against re-arming, whic=
h was indeed the case for this code.

However if that del_singleshot_timer_sync() expectation has been strengthen=
ed to mean that you guarantee never to re-arm the timer at all, then I agre=
e that we should switch to del_timer_sync().

Thanks!
  Trond

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

