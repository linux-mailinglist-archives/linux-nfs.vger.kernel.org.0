Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E277570C19
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 22:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGKUnh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGKUng (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 16:43:36 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2065.outbound.protection.outlook.com [40.107.115.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5773586
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 13:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5Yekc4MuMN5fp2v/xXjjZaF6tXZJBohir0Ob+0RDaCodxzBGfROnLOigF34+ovKXAQ+Oo1gYD8g9oRO8pIu+e7BB7w/cwPRpVtnP6f3c3tvuR0zfQx7HiOUNcwamNsg7iyGUSkK+XdZt4D6/QP2Ymfq6Qqany4R6lNWlfyNta9RagOFgIH1ka/SECEMK4HvfIYQEJCIBn63gCG1aB6ErH67XiRRYb8pYz/RZx/ELQqeh9+cki25g9nSt+ZKm5Mfg6muISe0tdB2bCS22a2VNGso+ICXTtUyX+ePQBzQgq0GO6AMG+JBK62d1eA4COAxfUU6beXAVgLPIfQtucT7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj/tbQbqpHec+cVnlx53ndg69P3f1KQDh3YLp0+8HYE=;
 b=bdoTjrs6S3Id1n0Vi3OBsTi61E4bmjHQAkyZbPIh9WUtEDkJL4KWHRTuczzjbI1uZOaVMWgw3gmW6u6XuNbGZjM+hlhpwn4ilKY1CUmg9AgIAlXqkwwo+awObYr+tZ04HLgdbaagP8FKnvgqj6SiZ0CbKpW501brPypeBgcMEf8pbJrZqmUF9enFP73N/6cfrmtI1hxmgPhfUV6NzuABC3aCmJL3qBVhkQIirPRZLvwCj8Z2mH7V/1spwUhV/+nZlLP2PMjB5ERllSAbkEATm2Bt9wLpZhmSRBV4rCxbCd/gKCEy55ZY3J+AHyPNqdxC3Vs+huI1c4gPWUDuySDlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj/tbQbqpHec+cVnlx53ndg69P3f1KQDh3YLp0+8HYE=;
 b=UXvqOgpMmFyRNsttCcJmvEr5QEcedCG+4P6eXh6pWODu7bKYDjq3iMCp6sDCkXBsvkVv8790PFKYMeUZwkF770lGHkOapK/e3rssR2jbF2qAKcaCL+NvT9EkMf2VNOsSVg3pIoVXF6m91mKd8biMg45XxrbVIrfkzm/G7WpAFPSSJBF6iSH5gEkMMelH8KnMIgOE/rLqWvmJwRBI5JqgmQfxg5Aj9FagbvQS+rx+KjLzT0L/T0TfB2530HlXFfuZaHSqJgcZ+9kMAidkpfWHkDXziurBh+4EwRNB8G+n9dWTTPcmuN49dbLChZePddyJaqG3sbvMHSL8lmBNJ121ZQ==
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:81::14) by YQBPR0101MB8120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 20:43:24 +0000
Received: from YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75]) by YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c494:e35e:76d4:7d75%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 20:43:24 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Topic: NFSv4.1/4.2 server returns same sessionid after
 DestroySession/CreateSession
Thread-Index: AQHYlKIG8hnDNDQzXUuZ/p7iJwgH2615RPsAgAAqTQCAAAlZgIAAKIvm
Date:   Mon, 11 Jul 2022 20:43:24 +0000
Message-ID: <YQBPR0101MB9742865EA5C7945107B76A8DDD879@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB97421B80206B30FC32170C25DD849@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
 <DCE64EDD-FCE4-4C21-8B00-7833D5EB4EB2@oracle.com>
 <89044942-DAFE-4E9B-BC70-A8D2C847A422@oracle.com>
 <24C858F4-5334-4417-BFA5-4D580274F47E@oracle.com>
In-Reply-To: <24C858F4-5334-4417-BFA5-4D580274F47E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 5dd3f11d-1736-386f-3862-59d35e053d37
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fe6b474-557a-48bc-3006-08da637e0049
x-ms-traffictypediagnostic: YQBPR0101MB8120:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGc2HPqFPWiOhZ2np1oDi7rv/oqe57HFfYE9g9S9PtlVZlDKwPC37iMzIia20HEPenPwjEcqpefIJXhS/UK+D/vHDFQeukXhcSOzHZq8ZlozQQfGexEI2bbeG9Z8CaILMOBijhfk1zMjYIA/GhSVu6iNXpwTd++09DC7xmu67XpETXjyjPnVCh4JJNRt7y9NDr0Fj+MBGJATSoLTb/8KF+Lys5ADouB/ueHHh7n9HGq83oRwP5YQDR2XU8zODzG4xKDV1EFfkrp1S8kt8Kxj/8abKMrNHctXnZ8kHlnfjnSPQGfw31jXuh1zIKY5EllJkUWhl82TkKvQABfura/VfTuKmVhVau2QJyw9QvBO0aXvm84fdzXxsPlno7os9IZUxAUo03SeJaUFW7jcN/16Hgvt/QTK2dtF7RQm9bqrLF8dJsS06JEfhPYLpsQz0x6sTWQxA4C+cLDYJ7oHPd5Jo8+AfBbIeW4wvICICcxd9G5T1WG5OoqA+sjTNLXdX0ZAwZxyvHKSYDYgGUuJLDzOpXHwPqIJJDW8+cQkXhHkghh1/HU+Th8RA669MksZAK9Ze5atg/EP8AE/C2y+B7PmAwwGsEysLbOZIaBDNqZ2FI5ZIeX6JRmSYbMw7xsVmJTp0db2iclPKHZO10KC8+t26R7GShF0xm8rV07jrn9mZODh/IU3k03Pl25Q7xB0e7m/Mb7rJNE9LKdPV9gg1SNzw5QZPcS8KJ4v3c3ngISjaMBZT0RmlmSJA0MtbW6OMQowbXZZSHLAVKOQHOJHivhABftmll6II8/geA3LcB7afodwmn2Flrq0hAiBhvjJ9F4fiCE41pt/oV+BLYhrt9OesQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(55016003)(41320700001)(38070700005)(8676002)(4326008)(66446008)(33656002)(478600001)(38100700002)(76116006)(86362001)(786003)(41300700001)(71200400001)(5660300002)(6506007)(7696005)(53546011)(9686003)(966005)(186003)(8936002)(122000001)(6916009)(64756008)(52536014)(2906002)(316002)(91956017)(66946007)(83380400001)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IyVTXXn7dNBIUPy5t+bEFcD6LJt1NWcrWqIkvGEPeE/Zl41KLyGj77/gO7?=
 =?iso-8859-1?Q?mOJ7Ux4AFds8O4f/gfKGE2vl2G05lmG8yLYfvHinThXxCg90KTyXzJfasZ?=
 =?iso-8859-1?Q?DqhnCFWaAjgqImjawGRYO6YC1pSI949lhsog26tYfOQqyLJ34fu48sx7qZ?=
 =?iso-8859-1?Q?R4vEMEhVRYIoEQOjdSHsJe98ULJJfHOmhGup36RzTx0I8ZzVrFINNYcGqF?=
 =?iso-8859-1?Q?OZFpEjp4AWmC1lnthYBq53utb5254uyBCQrQ9f9th2mTDUf7jU8OtQ21pb?=
 =?iso-8859-1?Q?NJsE4L4U+y/Ji/OTPmd/Ixlmv94WAFfXFrGlACO7AmCMCrfDS3wt9kMa2A?=
 =?iso-8859-1?Q?WL8VI2PriLnmRfe9ibWLXFCl17yRRLldhQ/oXUmNzR71tAgYPJDDEnsVHb?=
 =?iso-8859-1?Q?NcYHbPp6n+9cfSdZaLlX0MEvOw2YdFkK+y2CdszDcwx9IMv+y68OyCKoRq?=
 =?iso-8859-1?Q?lf15S2VJkQWK6J0bEFZaKlEN6oa4QOCjaoSOn1VE0n6AGeXeQPCX0D8xrx?=
 =?iso-8859-1?Q?edOSZqHNASuhrxpeKGjJ6jRHWE6Ect7p9lMARrhruyK8n1gdnxarPKIemh?=
 =?iso-8859-1?Q?tZkXumtimMkqd6KGX+i3gLt0f+5Bp6TIx4iUFyd8uDQEI+7iL+ovkAkVvh?=
 =?iso-8859-1?Q?IC73b1I+3j5h+ilGTLWZx839EICeGtI8lz9sVuSF7VIQWZBGnipCi705xu?=
 =?iso-8859-1?Q?WvdqTEiVuzxGsYlf5WAsbtUYZT4Pq3N2t8rha2aI28+7NifOnu/d9Ubcws?=
 =?iso-8859-1?Q?BP/Q8/aXvvlUxBXNsGSJ1RRvTTH8XweTIIgKcpvG4pDqWl6KjYX3cCf5HL?=
 =?iso-8859-1?Q?LfhfG2D+b5zzC8EfzfxpFND3woZQBgDYguF2F0UNmH447z/eXJGiRfxbKP?=
 =?iso-8859-1?Q?EurnIzj887lHVQSaWbDBV9bKl19agaVrCUSC7gLaIzERUG00PIPnUYKxLr?=
 =?iso-8859-1?Q?ivML8LUXAk2YTyDA7JGEASQby6qa1h1/WTw15HmD1m5wX/n4B34nT3+IBD?=
 =?iso-8859-1?Q?aMbFOip1E+++1RFnnowxGeD3YbHXoDHKbgmNUt3JznstxO0NRS2aVTiFcc?=
 =?iso-8859-1?Q?3Nj9YRKFqpqSvr9VuEiwiUkicJ8L4kre2LMvAN6kIQyMjBOk/R4X2S1+17?=
 =?iso-8859-1?Q?nXaovz3aGeIKHg2wR9SgRsqZWjvCL8SMPBYL+ahB0oWhLrZ0Ibhq88N4BA?=
 =?iso-8859-1?Q?9Q0siusPQQUhBM6bo/yK2x8fPoIMvcUrMPdJ0fVSLiMeckatJ4W7iH/Td3?=
 =?iso-8859-1?Q?jlQ85cxdwhFmugSlyOaI4I1ZlBdU6ev66qIMbZHyCBWkTXAqzFO3UVkyLy?=
 =?iso-8859-1?Q?zvGPF41oooJ71sfDMkJ4iQalBFyqP37CojsYwMMhYhhRwYiHICXN+sbCUc?=
 =?iso-8859-1?Q?qv3MmKSHI8OjbaS4OmM4S/hzRghrobu5IA3N1ORCVsbUKQ6uURSN2qMD4O?=
 =?iso-8859-1?Q?LUSA97jmv1/PGeeH2KOhkiHFXD6Z4RTUhzZqvUoBZSThGHn7rxJM7zumsw?=
 =?iso-8859-1?Q?s5dtOfZ3Iaq26/4Xzlxs4GPcBNfkZIg6VQKygqkct/lV/z3N3ZcOoPmjcD?=
 =?iso-8859-1?Q?83uM503JdaD9NUr+E7OrGiATLFSO9q+of+ZuBgftefaRi50ZeIATttI4rA?=
 =?iso-8859-1?Q?Ib98UMRrSS4C5EFvntsPD2ejUt3+zEVGJSMheIaoQ+5f9cLhbh3TERC4DB?=
 =?iso-8859-1?Q?NrBEyV05mR/E12QOAQpwp+afL9RKFTDrDEjo5TCz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe6b474-557a-48bc-3006-08da637e0049
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 20:43:24.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CloDugJa0wAP65issO/IGg3LkHBvB0Pa6pztezbA3FM5UjaR+FxrJoFEL8+cgYrUN5VA4pwkMwdvflaeFJcaWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8120
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever III <chuck.lever@oracle.com> wrote:=0A=
> > On Jul 11, 2022, at 1:33 PM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:=0A=
> >=0A=
> >=0A=
> >=0A=
> >> On Jul 11, 2022, at 11:01 AM, Chuck Lever III <chuck.lever@oracle.com>=
 wrote:=0A=
> >>=0A=
> >>=0A=
> >>=0A=
> >>> On Jul 10, 2022, at 6:10 PM, Rick Macklem <rmacklem@uoguelph.ca> wrot=
e:=0A=
> >>>=0A=
> >>> Hi,=0A=
> >>>=0A=
> >>> I have been trying to improve the behaviour of the FreeBSD=0A=
> >>> NFSv4.1/4.2 client when using the "intr" mount option.=0A=
> >>>=0A=
> >>> I have come up with the following scheme:=0A=
> >>> - When RPCs are interrupted, mark the session slot as potentially bad=
.=0A=
> >>> - When all session slots are marked potentially bad, do a=0A=
> >>> DestroySession (only op in RPC) to destroy the session.=0A=
> >>> - When the server replies NFS4ERR_BAD_SESSION,=0A=
> >>> do a CreateSession (only op in RPC) to acquire a new session and=0A=
> >>> continue on.=0A=
> >>>=0A=
> >>> When testing against a Linux 5.15 server, the CreateSession=0A=
> >>> succeeds, but returns the same sessionid as the old session.=0A=
> >>> Then all subsequent RPCs get the NFS4ERR_BAD_SESSION reply.=0A=
> >>> (The client repeatedly does CreateSession RPCs that reply NFS_OK,=0A=
> >>> but always with the same sessionid as the destroyed one.)=0A=
> >>>=0A=
> >>> Here's what I see in the packet trace:=0A=
> >>> (everything works normally until all session slots are marked=0A=
> >>> potentially bad at packet# 14216)=0A=
> >>> packet# RPC=0A=
> >>> 14216 DestroySession request for sessionid 2725cb62002ed418040...0=0A=
> >>> 14302 DestroySession reply NFS_OK=0A=
> >>> 14304 Getattr request (using above sessionid)=0A=
> >>> 14305 Getattr reply NFS4ERR_BAD_SESSION=0A=
> >>> 14306 CreateSession request=0A=
> >>> *** Now here is where I see a problem...=0A=
> >>> 14307 CreateSession reply NFS_OK with sessionid=0A=
> >>> 2725cb62002ed418040...0 (same as above)=0A=
> >>> 14308 Getattr request (using above sessionid)=0A=
> >>> 14309 Getattr reply NFS4ERR_BAD_SESSION=0A=
> >>> - and then this just repeats...=0A=
> >>> The whole packet trace can be found here, in case you are interested:=
=0A=
> >>> https://people.freebsd.org/~rmacklem/linux.pcap=0A=
> >>>=0A=
> >>> It seems to me that a successful CreateSession should always return=
=0A=
> >>> a new unique sessionid?=0A=
> >>=0A=
> >> Hi Rick, thanks for the bug report.=0A=
> >>=0A=
> >> CREATE_SESSION has a built-in reply cache to thwart replay attacks.=0A=
> >> It can legitimately return the same sessionid as a previous request.=
=0A=
> >> Granted, DESTROY_SESSION is supposed to wipe that reply cache...=0A=
Well, I just re-read the RFC and I don't see anything that says DestroySess=
ion=0A=
affects the CreateSession reply cache.=0A=
=0A=
I had thought it did, but I was wrong. See below...=0A=
=0A=
> >>=0A=
> >> I'd like to see if there's a test in pynfs that replicates or is close=
=0A=
> >> to the series of operations in your trace so that I can reproduce on=
=0A=
> >> my lab systems and watch it fail up close.=0A=
> >=0A=
> > I constructed a pynfs test that does something similar to your=0A=
> > reproducer:=0A=
> >=0A=
> > diff --git a/nfs4.1/server41tests/st_destroy_session.py b/nfs4.1/server=
41tests/st_destroy_session.py=0A=
> > index b8be62582366..014330e7d623 100644=0A=
> > --- a/nfs4.1/server41tests/st_destroy_session.py=0A=
> > +++ b/nfs4.1/server41tests/st_destroy_session.py=0A=
> > @@ -1,12 +1,33 @@=0A=
> > from .st_create_session import create_session=0A=
> > from xdrdef.nfs4_const import *=0A=
> > -from .environment import check, fail, create_file, open_file=0A=
> > +from .environment import check, fail, create_file, open_file, close_fi=
le=0A=
> > from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_c=
laim4=0A=
> > import nfs_ops=0A=
> > op =3D nfs_ops.NFS4ops()=0A=
> > import threading=0A=
> > import rpc.rpc as rpc=0A=
> >=0A=
> > +def testDestroyBasic(t, env):=0A=
> > + """Ensure operations outside a session fail with BADSESSION=0A=
> > +=0A=
> > + FLAGS: destroy_session all=0A=
> > + CODE: DSESS1=0A=
> > + """=0A=
> > + c =3D env.c1.new_client(env.testname(t))=0A=
> > + sess1 =3D c.create_session()=0A=
> > + sess1.compound([op.reclaim_complete(FALSE)])=0A=
> > + res =3D c.c.compound([op.destroy_session(sess1.sessionid)])=0A=
> > + res =3D create_file(sess1, env.testname(t),=0A=
> > + access=3DOPEN4_SHARE_ACCESS_READ)=0A=
> > + check(res, NFS4ERR_BADSESSION)=0A=
> > + sess2 =3D c.create_session()=0A=
> > + res =3D create_file(sess2, env.testname(t),=0A=
> > + access=3DOPEN4_SHARE_ACCESS_READ)=0A=
> > + check(res)=0A=
> > + fh =3D res.resarray[-1].object=0A=
> > + open_stateid =3D res.resarray[-2].stateid=0A=
> > + close_file(sess2, fh, stateid=3Dopen_stateid)=0A=
> > +=0A=
> > def testDestroy(t, env):=0A=
> > """=0A=
> > - create a session=0A=
> >=0A=
> > I'm not able to reproduce the problem on 5.19-rc5, but that=0A=
> > probably means there's something going on that we haven't=0A=
> > discovered yet.=0A=
Nope, your guess below was correct. It is a FreeBSD client bug.=0A=
=0A=
> My guess is that your client is sending CREATE_SESSION operations=0A=
> with the same sequence ID (1) and that is hitting in NFSD's=0A=
> CREATE_SESSION reply cache. So it's treating the client's new=0A=
> requests as replays and returning an old (stale) sessionid.=0A=
Yep. For some reason, I thought that a DestroySeseesion=0A=
put the sequence# back.=0A=
=0A=
On re-reading the RFC, there is nothing mentioning that.=0A=
=0A=
Now that I've patched the client to increment the sequence#,=0A=
it works fine against the Linux server.=0A=
=0A=
Sorry about the noise (hopefully your pynfs test is still useful).=0A=
=0A=
Thanks for the help, rick=0A=
ps: Now I have to fix a deficiency in the FreeBSD server. Right now,=0A=
     it only checks the sequence# for an unconfirmed ClientID, but=0A=
     that is obviously a FreeBSD bug, too.=0A=
=0A=
=0A=
--=0A=
Chuck Lever=0A=
=0A=
=0A=
=0A=
=0A=
