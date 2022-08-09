Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB91F58DCE2
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 19:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbiHIRMM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbiHIRMD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 13:12:03 -0400
Received: from wmauth2.doit.wisc.edu (wmauth2.doit.wisc.edu [144.92.197.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8CE24F03
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 10:12:01 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by smtpauth2.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 8.1.0.16.20220118 64bit (built Jan 18
 2022)) with ESMTPS id <0RGC00KSWYG0ZZ10@smtpauth2.wiscmail.wisc.edu> for
 linux-nfs@vger.kernel.org; Tue, 09 Aug 2022 12:12:01 -0500 (CDT)
X-Wisc-Env-From-B64: ZGZvcnJlc3RAd2lzYy5lZHU=
X-Spam-PmxInfo: Server=avs-2, Version=6.4.9.2830568,
 Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2022.8.9.170019,
 AntiVirus-Engine: 5.92.0, AntiVirus-Data: 2022.7.19.5920000,
 SenderIP=[104.47.59.177]
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSFbr+3xxzGXIQh973ESNKQl5vQP2E6tMPpExSty9SWRgsz0JjaAgWatm6yc22wANEaT5LTEJg8OsMaVdiAzBEOKsh7amTtLw9ky8sAM37to9t+IT/I3Fe/M5FbkzMU6anw/cKJsxW+f6AR1MKqVuvjD0y9azLPshDT393HkjmhMzFdl8vF2IDScLsIlMCYVLzbDaqpsnVcuzAIEmRlG/1Ct0q9Rc2fGVBCVSnTDRA83EPVrmfbuzDwZA/+auggqUe//SvoNIXy+qlYzYw5bJEGsPgsUgKKY/oqh6hCD2OU8lhLTVSliKpDsZe8Wen9FJtONtBB+YWFcqRuaFY7ZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgdBqi7rFMkhz9f65eMR+mUihXov31GMTYo766L0PLs=;
 b=aOVTM7zexmc/HzipXWhlNidflVQAdHQY31ORQdlB2M6H9/nucTEH2d92bi6FkNQ3Nt8EKqpE9Lal50SFsmFXoXRKCgIagRknvA2G4rIiKX/IIZWiV0yLuxC3LtInmJrj33nrIAGJ6KvlNMoZqORQ4vXZfADWPK36xh5ZNqxG/HYveN3eMg5rkUvsxVWdMkBQ8UqU3QxIMiidtOuxicOa0/omvIeQiW//NzC6KjOu8JYjj6nM+jCGaKhlqzx8+BbzLFrxVCeQTmfXmjQ0ebrSSxq1u7m5P1QMYPDc+M3gILz5J+UWCWClwO6qPSseXqIdmreHLZufvzqim79UrxQFeA==
ARC-Authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wisc.edu; dmarc=pass action=none header.from=wisc.edu; dkim=pass
 header.d=wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgdBqi7rFMkhz9f65eMR+mUihXov31GMTYo766L0PLs=;
 b=eOWL0PCuCAcGK+38aVDLxYax2zP+9CN4mAGVY5aoIsc3PQk1oJuZ9Qucz4HkxrH6hkJy6IZKbBN0+D3bIabQ1OqKa3CJR1SbWdFf2xWOnTsp+BqYbQuSQWZz35joHJyLtGW5GdYiJ+QLI4ZflydV6ghnl9ZGQpjUJM3LzdBcC5A=
Received: from SN7PR06MB7166.namprd06.prod.outlook.com (2603:10b6:806:103::6)
 by BYAPR06MB6310.namprd06.prod.outlook.com (2603:10b6:a03:e1::32)
 with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
 id 15.20.5504.16; Tue, 9 Aug 2022 17:11:54 +0000
Received: from SN7PR06MB7166.namprd06.prod.outlook.com
 ([fe80::b8a5:b556:5d52:ceb7]) by SN7PR06MB7166.namprd06.prod.outlook.com
 ([fe80::b8a5:b556:5d52:ceb7%5]) with mapi id 15.20.5504.020; Tue,
 9 Aug 2022 17:11:51 +0000
From:   DANIEL K FORREST <dforrest@wisc.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Strange NFS file glob behavior
Thread-topic: Strange NFS file glob behavior
Thread-index: AQHYq428dDTNZxBbIk2YruyMT2DYiQ==
Date:   Tue, 9 Aug 2022 17:11:51 +0000
Message-id: <20220809171148.om46ypyfnorjys2m@cosmos.ssec.wisc.edu>
References: <20220809011700.bdiikqngwmxp3abf@cosmos.ssec.wisc.edu>
 <b5d62b32edcd3c0df17382a3442c5580ad2c9196.camel@kernel.org>
In-reply-to: <b5d62b32edcd3c0df17382a3442c5580ad2c9196.camel@kernel.org>
Reply-to: DANIEL K FORREST <dforrest@wisc.edu>
Accept-Language: en-US
Content-language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-results: dkim=none (message not signed) header.d=none;dmarc=none
 action=none header.from=wisc.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64ce8826-e969-481f-fb6e-08da7a2a40b0
x-ms-traffictypediagnostic: BYAPR06MB6310:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLoPbiLshWkYB3ht4++uG3rZ8H9zFZaMzbn5dBS6Fii4nSKPU6sA0Tk4UbZI5jvTCNsZBFIoKFqcw3JSD+uSkKYRLnI7byECPOdyw8iQ7Ltxv7FQjG4qi0YBYZHM6+SUviyjKxJK6RMPigTLTMH0JXSonQPzHFb6nlrJ4v0BmXJ61dHTrSb0tTVdTKg/U7+oVe0lpSJjnGXlh/UOTNP591gsTIiZsPFizDlX9KTM65SDAvxkfzPDwfadjpvgCwh6wEfnmbr7sl9kEjg+7mqJyq8OR/721wjAW3uzI4MP5QlyM2PAOU5gJcJQXEJ2wRoF1FyEJRRc0s1JY7hcXTYZ/CJx6xnBPglZ4VEwHFZFI8cd+T2LdoZhnwUEaWJBv7Nj9z7PXH2PJWpTsqfEyvE16bznRgjYvfgfFseYmOrbcfFjF93z5ksmLgO5YEb6F5y7ldonAuH8hAO4ulwSgfV9XNT6QOjkc4iPHaSioCceIEZ4YlaYgDwnVZq03MYvq9cfOyMVbTzmIsurcELWpCvLIhkgUz1kQcDxImn1BSwO2eQkaGFMdNAG+4lTxYyUHnXUYQr2ihWoePzZnO3sOc1pmYCi09VlQXEGrzUPkOAqN3x8gIAOTe9LmEGx8Cp2zAPmB6X5v8P+/ivo/TSJlxjWN/iABC3CXWP9/W7Wsu1vkJStEk27FA7R6g8fsIQsk50XB8F711lU0BUWhzQK8FrePUtqQSwaAAZ0ySWl5qla1feSVIDBQx458z0R/mu9aXRq4KOEkBQPJJM/NXn8WupVNBiRqM495fZKCwKbr634haleb4PLSFMQfCmFngM8V0ou
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR06MB7166.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(40140700001)(41300700001)(3450700001)(6506007)(6512007)(2906002)(26005)(86362001)(38070700005)(75432002)(41320700001)(83380400001)(1076003)(8936002)(66446008)(122000001)(38100700002)(66946007)(66476007)(186003)(8676002)(5660300002)(6486002)(64756008)(66556008)(4326008)(76116006)(6916009)(71200400001)(478600001)(91956017)(316002)(786003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0RokWxul382kX41+rUL3lFJgxvgZB2Z/E205Ywf1zmJOoUpItecKoWWn9H9b?=
 =?us-ascii?Q?ZNCHgGkbCm6R8vGEv1P+6BbadmMEkSDQb97/wvNM5SY9j56pZ3Eg12o1I7jH?=
 =?us-ascii?Q?uRm8FNrbFFYSSTLv8oZWbQYXT2Go2I6ePbhHit9PGHpoP1FQCQY5lV7tiqYW?=
 =?us-ascii?Q?6M2q4eSPCuNwGgQV7rallNyu6YuT3odvdziVunEHypoz2GXaOIiwHcgPgcCh?=
 =?us-ascii?Q?BJCOZgNt89sGjz0w+hyZCxFS1MaBfBkYNI5s6SAX176yZDMRt43EMI7As8z7?=
 =?us-ascii?Q?P2nzXKqTIzIrSFedzb3XR+Ba7ArQNep9L8sIXY3rFuhreWnXwcTgUbc2pEjp?=
 =?us-ascii?Q?a3/dPaLS/pgrkX0JCJZWGdh5uDSz3+2N/YBFDjBqX6sLZ9DuCGlj4tLiZP3f?=
 =?us-ascii?Q?P+drqxVdDjIxbx89WT3+NQtiRn2KHPEgkrE4IJWm2GjAfw4TAiUWcRzuosFJ?=
 =?us-ascii?Q?8QgvX/JaEvYDSkTSuEhBA2CmxTTwwGjuG1mzRqHaSxnB6rRrnp/AaPoYaPEp?=
 =?us-ascii?Q?93RmPl6AHPQFnkqu+706olh6NK/VSAkYI/TLZJYbOWumbcbEsGCKMzzI3SAQ?=
 =?us-ascii?Q?iSnmBbZlrgu7cKiT/rIGBe67EH+w3R//1wFUTOegOLfwxEP1RDPIDiG96x0f?=
 =?us-ascii?Q?AscbG81TyhaUk2LdFjek3JRo3tFTflbsPMNJ0HoVR0hgkNYHH951ZhZhJdaa?=
 =?us-ascii?Q?QMvmnyhlh/5X4PuXMADPb5xQXcMN+wXyUgFuk7q1dKTvJQA9ZyPyriVbGjW/?=
 =?us-ascii?Q?Vyd7uCsu8qrhk+a6E0ps68u97IwuSIQBTPiX1uU8mP5k2dK03mdbW1QF+yBv?=
 =?us-ascii?Q?qeWnDNbcsjjyPIh8BOFqKnVuFXpaJQTUsXMHQ/2BDGE1Z87KPGy6aIRIlGnn?=
 =?us-ascii?Q?yqQDEdMm2gUfvSqAMgUvUqs/KfDre7OF4PcdrhyLAImwav7CY4J8ewDjeaYe?=
 =?us-ascii?Q?ynVgGj7NGeCkd9F5u67m0GAyxKs6G9uEO6icCbtrO0tIhAS054rAgDLhF4/T?=
 =?us-ascii?Q?MAmDoA5InKypkCsP7P2IeXF1nGJtT1eDQoBya3hMFlvQ8wOlAEKxYC7pJxol?=
 =?us-ascii?Q?19VRbxM2dNAqCzcxjiL8jq1F7os0ys+z6WYMXP+th6bKqMlQWTkbFK1lDQUp?=
 =?us-ascii?Q?mZGuLif2lMJ6IjEyn8cfzgv8n4ggzTP1GbXT67AM8GdfJAzvQdqHE2Mr6e+z?=
 =?us-ascii?Q?ko2uy1KCVB9k9KXicWkCYPAPv4pa7DaoEwteE4JNP0luWVJ7FCSHseGNw52C?=
 =?us-ascii?Q?gKtovum9tdmUHkBkNlTuPq/EO22mJ9B34Pb4cBOZy+3otUSpyht8mEycuVRE?=
 =?us-ascii?Q?SsaXs0b06DRg4LlvqYiBETBC9yYdvl7qamZQuTGDMaYp38ikRtreZtYHawo5?=
 =?us-ascii?Q?m5kGdUyb/mHrQ+dq1ZsCOZEv6Rx9s8Rr33eyfSNbzXBzorT5MPHntOhPZyRP?=
 =?us-ascii?Q?oLJ2TEcENofs73Emox29Tk0KYZMxks5E9aAoCMcvY9Q3m2QLZiZDHvSbALV+?=
 =?us-ascii?Q?wSzK1kyKTsf4Lwi8hoDAB7S9Yp91wNn+d9gzL3LpkGDAwmshfR6miaogm8fG?=
 =?us-ascii?Q?J2ErwPiOZccsigNJQJJxiRwQ/zacqcsGr7Ljj3N3HRN/H+sWOL4eY4ykg6jq?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-type: text/plain; charset="us-ascii"
Content-id: <1170A95D90C3FF43A028F1C42F204A60@namprd06.prod.outlook.com>
Content-transfer-encoding: quoted-printable
MIME-version: 1.0
X-OriginatorOrg: wisc.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR06MB7166.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce8826-e969-481f-fb6e-08da7a2a40b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 17:11:51.8277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnITs6q7cjhgQkxDBPVkvSKNmWhBCHxz+7Tvx/pA/bymORPND48buOCWjtzPJfK18GtOCEf7iZK1Wcqs5eKRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB6310
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jeff,

Thanks for your comments.  More in-line...

On Tue, Aug 09, 2022 at 09:49:59AM -0400, Jeff Layton wrote:
> On Tue, 2022-08-09 at 01:17 +0000, DANIEL K FORREST wrote:
> > I am seeing a strange glob behavior on NFS that I can't explain.
> >=20
> > The server has 16 files, foo/bar{01..16}.
> >=20
> > There are other files in foo/, and there are many other processes on
> > the client accessing files in the directory, but the mount is readonly
> > so the only create/delete activity is on the server, and it's all
> > rsync, so create file and rename file, but no file deletions.
> >=20
> >=20
> > When the 16th file is created (random order) processing is triggered
> > by a message from a different host that is running the rsyncs.
> >=20
> > On the client, I run this command:
> >=20
> > $ stat -c'%z %n' foo/bar{01..16}
> >=20
> > And I see all 16 files.
> >=20
> > However, if I immediately follow that command with:
> >=20
> > $ stat -c'%z %n' foo/bar*
> >=20
>=20
> You may want to look at an strace of the shell, and see if it's doing
> anything different at the syscall level in these two cases.
>=20

I had the same question, so I did that already.  The shell is indeed
calling readdir.

> > On rare occasions I see fewer than 16 files.
> >=20
> > The missing files are the ones most recently created, they can be seen
> > by stat when explicitly enumerated, but the shell glob does not see
> > all of the files.  This test is for verifying a problem with a program
> > that is also sometimes not seeing files using readdir/glob.
> >=20
> >=20
> > How can all 16 files be seen by stat, but not by readdir/glob?
> >=20
> >=20
> > OS is CentOS 7.9.2009, 3.10.0-1127.19.1.el7.x86_64
> > NFS mount is version 3, readonly, nordirplus, lookupcache=3Dpos
> >=20
> >=20
>=20
> It'd be hard to say without doing deeper analysis, but in order to
> process a glob, the shell has to issue one or more readdir() calls.
> Those calls can be split into more than one READDIR RPC on the network
> as well.
>=20
> There is no guarantee that between each READDIR you issue that the
> directory remains constant. It's easily possible to issue a readdir for
> the first chunk of dentries, and then have a file that's in a later
> chunk get renamed so that it's in that chunk.
>=20

In this case, the files are created and then the directory is dormant
for a number of minutes.  Repeated glob operations continue to not see
all of the files until the next set of files are created.

> You're also using v3. The timestamps on most Linux servers have a
> granularity of a jiffy (~1ms). If multiple directory operations happen
> within the same jiffy then the timestamp on the directory might not
> appear to have changed even though some of its children had been
> renamed. You may want to consider using v4 just to get the benefit of
> its better cache coherency.
>=20

I think this is getting to the heart of the problem.  The underlying
filesystem has a granularity of 1s and it is becoming clear what you
are suggesting is the root cause.

I have tried v4 without success, the symptoms persist.

> Given that you know what the files are named, you're probably better off
> not using shell globs at all here. Just provide all of the file names on
> the command line (like in your first example) and you avoid READDIR
> activity altogether.

For test purposes, I know the files names.  In general, the names have
a known prefix, but are otherwise unknown.  A glob is required.

What I need is a way to invalidate the lookup cache, but that seems to
require there be a change in the directory timestamp.  I tried setting
lookupcache=3Dnone, but the performance made it unusable.

It still seems odd that stat-ing the files individually doesn't get
them into the lookup cache.  It seems to be only when a readdir is
issued and the directory timestamp is seen to have changed.

> --=20
> Jeff Layton <jlayton@kernel.org>

--=20
Daniel K. Forrest		Space Science and
dforrest@wisc.edu		Engineering Center
(608) 890 - 0558		University of Wisconsin, Madison=
