Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF126A8518
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Mar 2023 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCBPZw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Mar 2023 10:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCBPZv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Mar 2023 10:25:51 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2135.outbound.protection.outlook.com [40.107.116.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6709F1350E
        for <linux-nfs@vger.kernel.org>; Thu,  2 Mar 2023 07:25:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWFmNCvPh9xr0FHLRLLU+Z5sgcKfILce/GQzrx8aCHU/G2BDBXjOWK5L+UrU7N9kyRgRkOJTx12YnPhAmpk9zvVpg2aTwSOtqe0LRBiFsQsJ21sFRnn5Pqv0Cit8rxYk2NZml/a1LdREITPGqjsoWM/XwZfcYEehpQQxGcj/YrgUy9ZIFJtxTifVsMsJVzYyiEC6k+i2L13o5abfih07VWtN15Y3XPC7bhhdtFhaGN3bq7gfXqjJFu4uHMIW5CxzTwNwlTMB/IRDpOFooev3GVBkmwvaUZn1vS9rrur9g/CNOsf6wyeueJJmrb8xdOdDDD6eB62+2V69bEB3y1f38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YvgT+1iUJxrr6Vffp4w2VStR97PE/fJuVZWnmttKYE=;
 b=B+hKc9MjmSgYjP0MCL/TZOGu6elzjbbb143LtPGd/HbLxcrPZlgwiINFMQK9nj6IK7oWnH9OF0eA9NV5heQuD93wYE3EYL/2w3N0Dsc6dLUEbS3w7vNolj2Yno4nCK5g9loCSMnBULy4rZt5QBDqZ9fvVpVKh8CW+e//jzwgXyshKjLDfWBUXPkoT/E/VGawMnhA6xK8MwreoahaB7v3v+V5uTKKqwO4Ef7/OKHBfmC7xjN3zbaLcPRXuKseh8+MVCWudwXpE8T0VATdxuXG5ipjVHhyLtmf0vcJtYT9enGb7WIy9eaunGg3+X6qufLQRZkY3IgGjaFJthMVt6D7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boatrocker.com; dmarc=pass action=none
 header.from=boatrocker.com; dkim=pass header.d=boatrocker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boatrocker.onmicrosoft.com; s=selector2-boatrocker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YvgT+1iUJxrr6Vffp4w2VStR97PE/fJuVZWnmttKYE=;
 b=2beCvHXJFKrEJ4ZRrAKIM7bAT7qt3YdUi/s0BNvGCac/EZpRxzpaO0b3Nbdpruy2cjqadWy8XxLKr0JXc6GmfKm+VSJ+4LwJ8qXHSavRD+0LnldHrdmAG8vf2ktfUhvAG4fPnFC0l2eWMnFnDLxb5CLK+wJLgUI3G4V/V2W19+g=
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::7)
 by YT2PR01MB8790.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Thu, 2 Mar
 2023 15:25:47 +0000
Received: from YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643]) by YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7303:f215:657e:1643%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 15:25:47 +0000
From:   Andrew Klaassen <andrew.klaassen@boatrocker.com>
To:     Jeff Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Topic: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
Thread-Index: AdkvR33g3mzLGSb7R/abGwkCKolj9QCUyz5AAA3zOxAAIFt1AACi9rVAAAFExoAAAB8OIAABI44AAJGeUGAAwz0wEAAEYlXABBrHNWAAL3yVgABmpDeg
Date:   Thu, 2 Mar 2023 15:25:47 +0000
Message-ID: <YQBPR01MB10724793CAA439A32D8011B7686B29@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: YQBPR01MB10724:EE_|YT2PR01MB8790:EE_
x-ms-office365-filtering-correlation-id: aa72c5a6-1df5-449f-9ef6-08db1b32659f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199018)(83380400001)(66899018)(38100700002)(122000001)(8936002)(5660300002)(478600001)(52536014)(33656002)(86362001)(38070700005)(55016003)(71200400001)(26005)(186003)(9686003)(55236004)(53546011)(6506007)(8676002)(66946007)(66476007)(66556008)(76116006)(64756008)(7696005)(2906002)(66446008)(44832011)(41300700001)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LG1qVXPwaiK344qLeTbnOmcGzPjEG1x0kDYTc5yYdB2TPG4hezQ2MC/xlTRQS4XvAlVYgjJhtobH/ZXmigmZhT78BiQZII+0HUs1jKSS7l6nDJbLu1IDNvxGicHmiZ3D0Evmk5TUEq+5vSYx5ALtHIkzlglrA61lSPRtGpOx3GTjNI9nu+w0NOqb2Fa8QM+QeFZQbAyslD7YLmxkQJZT/Sy912McJMO53BO25XYFtJc4vsAgxV3LyDPGeKqlu78QCz2dm19WJhzduSJUZR7olGJMB8Ke1NPrJFx/Gigt36ggJXNrL/o4blJzHnmIBlptjTOuMqFT56nlqnMPpikJarlWAbt9BRXLThso7GYgEUSKHtzdprZkVgYylx+XUbPzp+8FXySJCvsefYv1gp1jL2/7nzbjOCTqzxOKnTHpwD7qWpGNNUCOM1gjGmVeby8+WqD3qZTGE95Mmuv1Td4wGp6MZ+X3M4vX+Z7EbQtRd8bf5tZzmjaWLerB6eck3XZpNP0I1JZphfmVGwom062KKdC/KF/7G1PZfpFG3uzbxizvWR1+8CFxpa6bmw/LmNkUW+Kyx5IfBCA7p/AYgluGqMjixNKBzXEZ7Adcp9UUvHdpHf2vsTListSKwbvic2VdNCted5T4MUVGDtSvTzpnDoZ4R6/qpKlua8yLJUh8K9t39rbXCKz4SU2XCk05vtCd7HYN6EkEBrwpNhj1ujLhuw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/oL6xhw62hLfry/0hyIf27OpMGKfC4GLYbRZW/NwulEFeyILmUipWUdjG4Q?=
 =?us-ascii?Q?Iw9pIBr+2DfdqPGjVTsVOh06Kxq0s5n6aZpfouA3z99Bjq7unWqB7lHTQLQt?=
 =?us-ascii?Q?Az3yECWTYkf7O/w2yfw+IjGhg5fDGwZ+FXsuyHS3a7kGWC+4Ub8NcoAKcgtx?=
 =?us-ascii?Q?iHadYp6AOUvq3rL8226feUOg+HGCRyNrkhd/hhV5yPrmryFR8rgTOE1EMP8h?=
 =?us-ascii?Q?g63IkYcxTnmWmPKmHhr0O35u0aVPoJ5YjMfHdYJdu2XqUXjKtRfmqfi/Dg0s?=
 =?us-ascii?Q?+oSBfuV5FwPQdR1/uK5UyBNTD3c7CNTzzJgYSyu7jNQXbTnP3WCowObepsmc?=
 =?us-ascii?Q?homgEXckTgsKDYPcHlY8xL4YrHxLmobfcsg5C2mwqsp87Jr96/BhsOUBDnHn?=
 =?us-ascii?Q?z9NDCrLyxzvDw1THDx+Uo00mm29/u8vghQAZQyG8AEuJRS2ydnwVS0d+86a9?=
 =?us-ascii?Q?ccMBq6MzX8cl3ieXZVOKEeH3WJlC+WJBWo+XKXLgN+nqwiXuMer9ba039IZ1?=
 =?us-ascii?Q?ORbz1RGOmXilwkPjHQxGCZ/cbNR9Zo5nxs8yInh/md9FId3bezW7pJDBdKln?=
 =?us-ascii?Q?6QO8FXGRZLeHVpiLmbTSdYMXCDPZqRYDWKQEA947Q2bNr0SrR7kUPLydl4mZ?=
 =?us-ascii?Q?Pu+d6iVF0PqEJe0OVyFDrojXZ6T/qIMsRpn5QFwPIE4gLydgZB+gaa8PisfP?=
 =?us-ascii?Q?JKs3IJMXltDaPbZJCTNWaG4IQT/QvnJSQUp+0GRPMK5/WPY2KA0ad73TSQMr?=
 =?us-ascii?Q?d5vVpqHlo7nn+A98+sjdFEt7EdSXOGyPgFBCPV7/6ItwKWF62u+dQNOTWEWS?=
 =?us-ascii?Q?/RGtSZEVg5+pApFtjQOtSxjfU6Q2cL3537bGsEvDDEmsWVHKDEwX1K4lsSQ2?=
 =?us-ascii?Q?0HJ9QLMFh9FqgH3o2fxO2W8HgE/nBthlsFwqusZstZI32sjCeJcDZvtTT+6i?=
 =?us-ascii?Q?jwVqqVfuFW36TumqjYUAvZmAZ8/X17v4ok+GVVG7hPeROUbW5P0Ph1ZWAGJ1?=
 =?us-ascii?Q?D4OEo8zHvI0xRoCW+wU373a23weeJYPeMpJOTH1ZtMYM/oNgBl1IdwuwJIdz?=
 =?us-ascii?Q?tW/d6+NFt4fjQr5hJXVempYiGbB0c29t9q9hE41c6w+dsUaNyJTnM+ncE4Cr?=
 =?us-ascii?Q?ZSqynp7Py4OHJoLTj6xG30/BE0k+vBWs/8nEBNGwCBiJwd0gYuBNNC4pKqkY?=
 =?us-ascii?Q?45q5UOw8gJuUbRRKD4gRHa+cvlhJZ27mx23hDa67pcNfLYGz/3Ib/IgVymt7?=
 =?us-ascii?Q?y4r036b28p3u2UXpHuI26AVE8SO7CNiebyETbODSg4M1FAUFCYcWEx2WNR0j?=
 =?us-ascii?Q?ydKH1FKZP34y846nSAyDiZOxLa9NeaMAgnWUhaA7GzN0KxNE2NsZ2reVMd+h?=
 =?us-ascii?Q?eXOaDNyW0i9JO1cYApajAFR+x0vDJP1WOeIc5BupnCTrT2+i9unaEZSmikZk?=
 =?us-ascii?Q?AwWDpdhZRsDDn9Tzpwk7eg5QbVgMInpVaM1w5u/q98Si7CifDg4D6LSBjcWa?=
 =?us-ascii?Q?1tLEMTE791Rd/hlPJiw1LzFoZatJhJ0csj2Xldk9SZXZVrpQxpzvv3+ajbSe?=
 =?us-ascii?Q?OMd6D4c/k51O4C7A/YiDeSNkcwcU4FAekWfaewXN2GShJYr4SSX3/k9s5GLH?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: boatrocker.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa72c5a6-1df5-449f-9ef6-08db1b32659f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 15:25:47.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd92a966-cd05-4664-965e-b69e7529781a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msaN2Sncmx4gFr1R8c3I6+slZjoQrKB2e5vLZv4o6Atawrd31UiLXqa0vMuRxbt4JicdHAVabqLb9VM1b5CUGD8IdDqYL2mJGg/q1Clp9Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8790
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
> > > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > > Sent: Monday, February 6, 2023 12:19 PM
> > >
> > > > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > > > Sent: Monday, February 6, 2023 10:28 AM
> > > >
> > >
> > > > [snipping for readability; hope that's okay]
> > > >
> > > >  - I'm allocating memory.  I assume that means I should free it
> > > > somewhere.
> > > > But where?  In xprt_destroy(), which appears to do cleanup?  Or in
> > > > xprt_destroy_cb(), which is called from xprt_destroy() and which
> > > > frees
> > > > xprt-
> > > > > servername?  Or somewhere else completely?
> > > >  - If I free the allocated memory, will that cause any problems in
> > > > the cases where no timeout is passed in via the args and the
> > > > static const struct xs_tcp_default_timeout is assigned to
> > > > xprt->timeout?
> > > >  - If freeing the static const struct default will cause a
> > > > problem, what should I do instead?  Allocate and memcpy even when
> > > > assigning the default?  And would that mean doing the same thing
> > > > for all the other transports that are setting timeouts (local,
> > > > udp, tcp, and bc_tcp)?
> > >
> > > [snipping more]
> >
> > Here's the patch in what I hope is its final form.  I'm planning to
> > test it on a couple of hundred nodes over the next month or two.
> >
> > Since I'm completely new to this, what would be the chances of
> > actually getting this patch in the kernel?
> >
> > Thanks.
> >
> > Andrew
> >
>=20
> Excellent work! I'll be interested to hear how the testing goes!
>=20
>=20
> This patch still needs a bit of work. I'd consider this a proof-of- conce=
pt. You
> are at least demonstrating the problem with this patch (and a possible
> solution).
>=20
> Conceptually, it's not 100% clear to me that we want the exact same timeo=
ut
> on the RPC call and the xprt. We might, but working with interlocking
> timeouts can bring in emergent behavioral changes and I haven't thought
> through these.

At this point I'll admit that I don't fully understand the difference betwe=
en those two, so I expect that your thoughts on it will be more relevant th=
an mine.  :-)  Happy to get more of your feedback on it.  (I do notice that=
 the patch causes timeouts during an initial mount that are twice as long a=
s expected, so I assume that this is related to the two separate things you=
're talking about.)

Not knowing much, my initial guess is that the solution might be from optio=
ns like:

 - Create a system-wide tuneable for xs_[local|udp|tcp]_default_timeout.  I=
n our case that's less-than-ideal, since we want to change the total timeou=
t for an NFS mount on a per-server or per-mount basis rather than a system-=
wide basis.

 - Add a second set of timeout options to NFS so that RPC call and xprt tim=
eouts can be specified separately.  I'm guessing no-one is enthusiastic abo=
ut option bloat, even if this would be the theoretically cleanest option.

 - Use timeo and retrans for the RPC call timeout, and retry for the xprt t=
imeout.  Or do the opposite.  The NFS manpage describes the current behavio=
ur incorrectly, so this at least wouldn't make the documentation any worse.


> > From caa3308a3bcf39eb95d9b59e63bd96361e98305e Mon Sep 17 00:00:00
> 2001
> > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > Date: Fri, 10 Feb 2023 10:37:57 -0500
> > Subject: [PATCH] Sun RPC: Use passed-in timeouts if available instead
> > of  always using defaults.
> >
>=20
> This needs a real patch description. Describe the problem you were
> having, and how this patch changes things to address it. Make sure you
> add a Signed-off-by line too.
>=20
> When you resend, send it to the the nfs client maintainers (Trond and
> Anna) using git-format-patch and git-send-email, and cc linux-nfs list.
> I think your MUA might have mangled the patch a bit. Please look over
> Documentation/process/submitting-patches.rst in the kernel source tree
> too.

Thanks for the tips.  I did read submitting-patches.rst, but obviously not =
carefully enough.  :-)  Would it be appropriate to submit the patch as-is (=
with check-patch.pl fixes), or should any potential interlocking-timeout is=
sues be addressed first?


> > ---
> >  include/linux/sunrpc/xprt.h |  3 +++
> >  net/sunrpc/clnt.c           |  1 +
> >  net/sunrpc/xprt.c           | 21 +++++++++++++++++++++
> >  net/sunrpc/xprtsock.c       | 22 +++++++++++++++++++---
> >  4 files changed, 44 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> > index b9f59aabee53..ca7be090cf83 100644
> > --- a/include/linux/sunrpc/xprt.h
> > +++ b/include/linux/sunrpc/xprt.h
> > @@ -333,6 +333,7 @@ struct xprt_create {
> >       struct svc_xprt         *bc_xprt;       /* NFSv4.1
> > backchannel */
> >       struct rpc_xprt_switch  *bc_xps;
> >       unsigned int            flags;
> > +     const struct rpc_timeout *timeout;      /* timeout parms */
> >  };
> >
> >  struct xprt_class {
> > @@ -373,6 +374,8 @@
> > void                  xprt_release_xprt_cong(struct rpc_xprt *xprt, str=
uct rpc_task
> *task);
> >  void                 xprt_release(struct rpc_task *task);
> >  struct rpc_xprt *    xprt_get(struct rpc_xprt *xprt);
> >  void                 xprt_put(struct rpc_xprt *xprt);
> > +struct rpc_timeout   *xprt_alloc_timeout(const struct rpc_timeout
> > *timeo,
> > +                             const struct rpc_timeout
> > *default_timeo);
> >  struct rpc_xprt *    xprt_alloc(struct net *net, size_t size,
> >                               unsigned int num_prealloc,
> >                               unsigned int max_req);
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 0b0b9f1eed46..1350c1f489f7 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -532,6 +532,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args
> > *args)
> >               .addrlen =3D args->addrsize,
> >               .servername =3D args->servername,
> >               .bc_xprt =3D args->bc_xprt,
> > +             .timeout =3D args->timeout,
> >       };
> >       char servername[48];
> >       struct rpc_clnt *clnt;
> > diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> > index ab453ede54f0..0bb800c90976 100644
> > --- a/net/sunrpc/xprt.c
> > +++ b/net/sunrpc/xprt.c
> > @@ -1801,6 +1801,26 @@ static void xprt_free_id(struct rpc_xprt *xprt)
> >       ida_free(&rpc_xprt_ids, xprt->id);
> >  }
> >
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
>=20
> > +     return timeout;
> > +}
> > +
> > +static void xprt_free_timeout(struct rpc_xprt *xprt)
> > +{
> > +     kfree(xprt->timeout);
> > +}
> > +
> >  struct rpc_xprt *xprt_alloc(struct net *net, size_t size,
> >               unsigned int num_prealloc,
> >               unsigned int max_alloc)
> > @@ -1837,6 +1857,7 @@ EXPORT_SYMBOL_GPL(xprt_alloc);
> >
> >  void xprt_free(struct rpc_xprt *xprt)
> >  {
> > +     xprt_free_timeout(xprt);
> >       put_net_track(xprt->xprt_net, &xprt->ns_tracker);
> >       xprt_free_all_slots(xprt);
> >       xprt_free_id(xprt);
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index aaa5b2741b79..13703f8e0ef1 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -2924,7 +2924,12 @@ static struct rpc_xprt *xs_setup_udp(struct
> > xprt_create *args)
> >
> >       xprt->ops =3D &xs_udp_ops;
> >
> > -     xprt->timeout =3D &xs_udp_default_timeout;
> > +     xprt->timeout =3D xprt_alloc_timeout(args->timeout,
> > &xs_udp_default_timeout);
> > +     if (IS_ERR(xprt->timeout))
> > +     {
>=20
> Kernel coding style has the brackets on the same line as the "if"
> statement. You should run your next iteration through checkpatch.pl.

Thanks.  I did that once, but forgot to do it again before sending this ver=
sion.


> > +             ret =3D ERR_CAST(xprt->timeout);
> > +             goto out_err;
> > +     }
> >
> >       INIT_WORK(&transport->recv_worker,
> > xs_udp_data_receive_workfn);
> >       INIT_WORK(&transport->error_worker, xs_error_handle);
> > @@ -3003,7 +3008,13 @@ static struct rpc_xprt *xs_setup_tcp(struct
> > xprt_create *args)
> >       xprt->idle_timeout =3D XS_IDLE_DISC_TO;
> >
> >       xprt->ops =3D &xs_tcp_ops;
> > -     xprt->timeout =3D &xs_tcp_default_timeout;
> > +
> > +     xprt->timeout =3D xprt_alloc_timeout(args->timeout,
> > &xs_tcp_default_timeout);
> > +     if (IS_ERR(xprt->timeout))
> > +     {
> > +             ret =3D ERR_CAST(xprt->timeout);
> > +             goto out_err;
> > +     }
> >
> >       xprt->max_reconnect_timeout =3D xprt->timeout->to_maxval;
> >       xprt->connect_timeout =3D xprt->timeout->to_initval *
> > @@ -3071,7 +3082,12 @@ static struct rpc_xprt *xs_setup_bc_tcp(struct
> > xprt_create *args)
> >       xprt->prot =3D IPPROTO_TCP;
> >       xprt->xprt_class =3D &xs_bc_tcp_transport;
> >       xprt->max_payload =3D RPC_MAX_FRAGMENT_SIZE;
> > -     xprt->timeout =3D &xs_tcp_default_timeout;
> > +     xprt->timeout =3D xprt_alloc_timeout(args->timeout,
> > &xs_tcp_default_timeout);
> > +     if (IS_ERR(xprt->timeout))
> > +     {
> > +             ret =3D ERR_CAST(xprt->timeout);
> > +             goto out_err;
> > +     }
> >
> >       /* backchannel */
> >       xprt_set_bound(xprt);
> > --
> > 2.39.1
> >
>=20
> --
> Jeff Layton <jlayton@kernel.org>

Andrew Klaassen


