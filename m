Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E216A88B3
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Mar 2023 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCBSr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Mar 2023 13:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBSrZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Mar 2023 13:47:25 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2127.outbound.protection.outlook.com [40.107.116.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8624515FA
        for <linux-nfs@vger.kernel.org>; Thu,  2 Mar 2023 10:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaA/VTbRkwV5BkbKKmEAltKXKXE/UBpcbrSFxvr242tPPerNzyaun+8IC+DElC1qUiwdOArjDSGTEqaYkwScQoh6n/NOs+uzlyaEUPyQIyj3NYV/Z39dqlTxThQVl2SoJFN9OueMxNaZ6QuAom/qEgY2y2HFmNSiZ9f3HrFMluQiWtHgt/72djfZWPYgLxn7M2YXJTgjLsNcIltMeyuAc1UYarZSzdqUStmoMp4XX33qIbMkP91YnYctCFS4Tp1l1px9WQ5fZ1QD6B4W3+kYEzHPAIACo0ljuhoR4In0rcpNc4MqV0dmVFhoKqtz7fIhVAlDGQyqlhZ7YZi1I1XNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99lPbQG3MBenZeKh84qTQDHeZrTGnCPQ2Y+juUv9BhE=;
 b=j/ysXolbNu4jre4QmtJYkQSO9cW32iUiCaN/pG9U+Oc+Adl0YedNn/z+CIlHC1P3raqpPa94dEUl/7AUKHSlkL42PLlQ9BzW6PgnydPSEhpN7YCqQfIa7M9Yk6/6jGH09Jz07eqy87C9L1qInDucEvi+KBCADXMgegH2yOQ91WP3DwXnGG3yr9pWFnJeLwyR9xx6ABpteeqI/UNZ/IGj6CH+znU3o0dC91uKDLKWAJUnJdr/Ikhz3VtAmw1EmsWxgJ35R579b/mWFDm/kvpVrdrqtfIhEfeUg/eHAU0JD2+n5x8pikqW9MnIavifs0yT5jxAv2RCC69FOFtNSqpffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99lPbQG3MBenZeKh84qTQDHeZrTGnCPQ2Y+juUv9BhE=;
 b=jw8NhMA9kiwbmFWOVLbX4kc9iMqdAfm026EV9lJYorecT9qgBbeheLnktQzQPR1XHbVRrGlc5QcGgESUNVEsWVyO48/5rVXqjYY7k3y2FM9keqriVglQKY0yN9QVKRsxyScTU+tFPwmh300o9Db1BJnOxAgpqvn676BVgDEu+aA=
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::7)
 by YQXPR01MB6041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 18:47:21 +0000
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643]) by YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 18:47:21 +0000
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Topic: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Index: AdkvR33g3mzLGSb7R/abGwkCKolj9QCUyz5AAA3zOxAAIFt1AACi9rVAAAFExoAAAB8OIAABI44AAJGeUGAAwz0wEAAEYlXABBrHNWAAL3yVgABuswZw
Date:   Thu, 2 Mar 2023 18:47:21 +0000
Message-ID: <YQBPR01MB107241320C90E9E4DA9E31A9286B29@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
         <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
         <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
         <YQBPR01MB107243906854065876378D57B86D69@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724969B61BA7156DB71A82686DA9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB1072471CD751CDDEE7C0AD5BB86DA9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724998CA29C5AFF7E6B391E86AF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <45e2e7f05a13abab777b3b0868744cdbfc623f2d.camel@kernel.org>
In-Reply-To: <45e2e7f05a13abab777b3b0868744cdbfc623f2d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boatrocker.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10724:EE_|YQXPR01MB6041:EE_
x-ms-office365-filtering-correlation-id: c0e23440-8e57-4e82-9e8e-08db1b4e8ea9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199018)(83380400001)(66556008)(33656002)(71200400001)(122000001)(38100700002)(8936002)(52536014)(5660300002)(478600001)(66476007)(55016003)(86362001)(38070700005)(26005)(9686003)(186003)(55236004)(6506007)(8676002)(2906002)(64756008)(7696005)(66446008)(76116006)(44832011)(66946007)(316002)(41300700001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jd+E7BZzYKd6HLD7Rv2WUtL4ZjcFsWFxrVh8HA1dPD0RbEssnflaFrjbMLTbqCvRyMa8L88VtuWfGGJ7pGfiOesOLAyDn5TTVdi9mzfU5WCGSxqGqn2ckpBRdq6mpFV9/NPKzOxgW6tfb7pw9LU8+B1RVpDAZG0S0N5tpzi1U+Y7KZC/zzbYSQTzv78Z2juqrNc8MeB5i6UnLo8X9qa5hNv98fVovUDT/tAT3JHbu25sZeADtZo0k6tLJblr0BL7pBykLpqGTBEZjPM/yljDTXUDovVEkeVEAlMz0wGKYboz16P+csLeSrAf6vC4Sgf+js1MJbXW+uXB/jemrqovbP6Hfi1XOEIjOG6lEPz5EGr/SnGcLFczSB6u7Po0E4j2h7wyU4KCKgHlexWatPByW4bBQhwx9u0567wHY4Z+lIgfwk8lt3BWOkaJPXxRRDcEkYKLeLGfZO3eLHzRkjcc8qrn/jOYMVFt398au5jbcymM+KSNqeSYI/t1MByDK3YWgM6vgktOprwu0QurYXQLEvAHV2jtUCPcSrppf6qa94FM2JzsJmYlkf7tBtWY1ggyxYFZ/5OrNPsX4uDteQqqBeKMTTVgUhVknNrtyXQFvQnrJ7FY+zmnArlmZA66XDoBpu/Ms+1F3BNvDpoQvM3XgcRM77lc83YyW+ihfO+FlhwhfxwdIqTHP/6QvGvIN5SBVInieqRquXHsq1nOjJWQzg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TqXKJtNiG4fxZy87BLJcTaoh50Ltv89ko61fK8DABP3NPjVu7olcTGH87CoF?=
 =?us-ascii?Q?5oBEPuP5yfYSom+hd66LM+Ibz+eVHvMZCHJ85NLL/7qVAEZANUtfcndNFiLU?=
 =?us-ascii?Q?VSePeMDS3/5bX+pzfR8yQHQrgCfrEL4yYsI70l1LffLxuh84gIB1oFuGnfxq?=
 =?us-ascii?Q?Ckgu5NXxdJU1fy3ESi8fNmLH8jtVX7U+gxZM0hnya5KOz6nJ8zttc+O2k2OG?=
 =?us-ascii?Q?jZ0oBv+Kf9x02T5vHW2BJcRaFEyAkQkeLTV12+8RVjeKBHqnGsfAzH1YkriA?=
 =?us-ascii?Q?PKSA+0nyH1G8pdzoOplsgUm0+xfDcOdnxVM96BZMc3WAT0sCDo6/8AyN429V?=
 =?us-ascii?Q?nzDG8Un21XbGkDJk71XR7Rmw3N5kgRi6HD+S7e5vY9oJ18ZjX2EfOrVo8R3N?=
 =?us-ascii?Q?KA5X8xD97kCURoZ0wINTFzfitTYEkExWt3hjJwTJaUeWMNMpNAQRZceFwAXV?=
 =?us-ascii?Q?tOVxSainA67FFKcTUHPgIpUTthVxygHqFZORRI2HNr5S2h0T9cevqS0OSo3p?=
 =?us-ascii?Q?dn5Oq8Qp+eynVJKzjEH91NpsFgsCGLWmYgWRfOCuPA9j6lyzBlACRZuZ/FD9?=
 =?us-ascii?Q?VcwBxjMgOhxhXDcvhSvYVHlnKHtnyLo2GtI5gT4R0dp7FdFmYOQfyVBmltK2?=
 =?us-ascii?Q?PvBJM1BoMMHRUle6+JyJgxypSs93NkzqYoOuSSxQ3LEdS6tamvKwN4DYmk6Z?=
 =?us-ascii?Q?+CGhIqU5tyj+J8kJuFhpwYj0mYXpwWv/j8eW9Q2hb+KHHePaU0msZT1L4dGE?=
 =?us-ascii?Q?XmN1VF3EBJqJRY2J5EBArrikwbqGNnDiVDNCEhdoRa1GfXzS9DheUYqwpXgR?=
 =?us-ascii?Q?j4ZI0Dm8VpTS5zWCKkO9rgNmKm0M+lvODDrmu+JPRIVNMX6AEWH4WS14rzbD?=
 =?us-ascii?Q?UiZT1UsAd3UZWhxi+guDoz1IKT/TvmBTYYiHfV/U8HfC1FiXlKFTczcRsCsv?=
 =?us-ascii?Q?uI3yVYCKVyRzgC5bcPFJhcXDt/592FFGhOxztrrnyDyv56/7u9Qr+wTpzmdx?=
 =?us-ascii?Q?+1u1fDykMZX+JwaJ/la/WkZC8XMGKCGDLFJIqVXZO05uNjNj//I14yiTqqHu?=
 =?us-ascii?Q?gQFZbR8WaFv8pgfDCJvV2Q6y29P3vS6Wbs4wvkLz3CoptLTszSgj7wrrbKEB?=
 =?us-ascii?Q?il2wSZFXwhGi1z8NjBDAnoVGxtR3Ph7NnAFvB2lPJOS9YozYWbArB9k5DK05?=
 =?us-ascii?Q?tTJpXH+3sMRMcczQX5Nxk4Z5WgAOZFLkUAQF+vIHF4T7cTbdeOhlKqcpUh2v?=
 =?us-ascii?Q?wTNx6Xu7vGQ/R1njgnEw1SdsYQIkv+OPMpXlorrIICtsUWP0Ho/rO3wvOhpd?=
 =?us-ascii?Q?8Pz7Bhddj6/qJq0g739aTc7hI9X2bNKEmUhtHBUuX4bUFRlyDQzTaGWeUsgZ?=
 =?us-ascii?Q?rNvLnmceu3kSKnMkL/k05APpzU9ksB84QSKuo8fBBcqsmu9q0jP7BvWpOnB/?=
 =?us-ascii?Q?HtPOxe+qP4l2OOHlR93R/kPDUfy2En6EGj7mjg/0wFL1SqBSvADRCFgK70tL?=
 =?us-ascii?Q?980mlXwI99YhOjHn64s00aG4kyXDEFFwJs9VSJiBDek4l5iw7zckWXaxwXqw?=
 =?us-ascii?Q?Nmiix6UDjh84bAKzmdTb/8fnkhUpsWasaRjEy8ZQTOB74OLTRRPhCnZjjeUv?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e23440-8e57-4e82-9e8e-08db1b4e8ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:47:21.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oe84AZuDoWdI8A5V3wdhEhyHtEczV7vwK8jgBsXIx7b+VU471odQVmVodoXvJo8ASiRzSH5XNv1zRu7lz0DJomSDU9ZuGp/+RnQxisoe6KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6041
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> From: Jeff Layton <jlayton@kernel.org>
> Sent: Tuesday, February 28, 2023 8:24 AM
>=20
> On Mon, 2023-02-27 at 14:48 +0000, Andrew Klaassen wrote:
> > +struct rpc_timeout *xprt_alloc_timeout(const struct rpc_timeout
> > *timeo,
> > +                                    const struct rpc_timeout
> > *default_timeo)
> > +{
> > +     struct rpc_timeout *timeout;
> > +
> > +     timeout =3D kzalloc(sizeof(*timeout), GFP_KERNEL);
> > +     if (!timeout)
> > +             return ERR_PTR(-ENOMEM);
> > +     if (timeo)
> > +             memcpy(timeout, timeo, sizeof(struct rpc_timeout));
> > +     else
> > +             memcpy(timeout, default_timeo, sizeof(struct
> > rpc_timeout));
>=20
> I don't think you need an allocation here. struct rpc_timeout is quite
> small and it only contains a bunch of integers. I think it'd be better
> to just embed this in struct rpc_xprt instead.

I missed this in my initial reply; apologies.  What do you mean by "embed" =
in this case?

FWIW, every time I tried assigning xprt->timeout without an allocation the =
timeout values would be correct just after the assignment in xs_setup_tcp, =
but by the time the code got to xs_tcp_set_socket_timeouts the timeout woul=
d be filled with random values.  I'm sure this reflects my limitations as n=
ot-a-C-programmer, but no matter which way I tried it I couldn't stop that =
from happening until I allocated memory.

Thanks.

Andrew Klaassen


