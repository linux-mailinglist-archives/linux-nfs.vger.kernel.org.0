Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D765264B
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Dec 2022 19:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLTScn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Dec 2022 13:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLTScm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Dec 2022 13:32:42 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2124.outbound.protection.outlook.com [40.107.101.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB6ACE5
        for <linux-nfs@vger.kernel.org>; Tue, 20 Dec 2022 10:32:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDc8C+Z9NdqAWKKBMZjVR4BEus3ft5NjBAi9kcWyfGc7f5J3kKlquEloJ/tMT3zOenk8OCBF5xp0/fzSmL2cnBixhSZB499cNMpoY+9wy809RDAzdeOXjErg9wJTvUZaZfJaEWZilaa9EBO6eGGy0xsdpRrj71DVhiSqYAJypTaxkzAUhZZmhKnFxFf8bEu6+37N0FMCq3LlqhdAG2bA0VY1IzrAaEMEjfwLYX1AYyy1hyaJHCZFtHzgOC9kleOFHhvA7Lsnh4zof04r5MpG8rS4Bg4+0KynKvckQwM3s/52cmqJ13hbfmOJc4RM744MUzWiAXUwMZGSQB+rEE4j6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUFCqtkjboCXgXcY/VbDmUuFxVGGgGrtujk2dRFZqMA=;
 b=AeGnP7pJWZqg4Nz6htfKBpK25X68kNp86exXGsY3PTBbR8A9catgS9RfiTtV1pMQXEfbpcF3RsBlPlD+8JxuROvRHg5Q/i1SwZg/FsODkclBmsUDdVVZXaZeC5DjdOdUmrTtPDS7cto8CPPiTiWSl2oz9pFZj1/neT/0bOjyX4wK8OT2v5w4K300l680CHAZ1D+uhLisRH9pPr+omc/nt3fw4YeW36uoa0DeoGwWezOLJT4ORTzUbkmPzlty06cRuhoAjWWg0DRwTG9x8k1F2kaCO+2Mr4CPrvHTo4woBugUDotAp8KZMWcYpwIPzrQZrb19PKuxpJCykeU9QDHXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUFCqtkjboCXgXcY/VbDmUuFxVGGgGrtujk2dRFZqMA=;
 b=M9Q5cMjgZ5/OiCyW0VKotzBE+mCxJhWJOgqCpykX0Zp3dxf43M6KC9mvFU0jgp0IN/eiETE/lW/DeAh7svc6uk+hvbfyGCdFL+McRbpUxX0YBhoYYQNvHzp2xviLaP86fFmSaiv3TaJMQd8KeTtwSDqnPYGrBsakbHtVOkGBfqQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB4480.namprd13.prod.outlook.com (2603:10b6:5:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 18:32:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::34dd:cd15:8325:3af0%8]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 18:32:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] pNFS/filelayout: Fix coalescing test for single DS
Thread-Topic: [PATCH v2] pNFS/filelayout: Fix coalescing test for single DS
Thread-Index: AQHZFJjqPqDlBbCtTUKkoPpZ0duUha53GaCA
Date:   Tue, 20 Dec 2022 18:32:38 +0000
Message-ID: <0AFE65D4-2495-4635-BC10-AAC410CB3DA9@hammerspace.com>
References: <20221220173129.98009-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20221220173129.98009-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB4480:EE_
x-ms-office365-filtering-correlation-id: 9998c2f7-47c2-45eb-b3ea-08dae2b8927e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cPuL8IKHyqyVDDmTLiwjyuWDpzg+4+7/fxQsNb2C2OyqvIeOs4Q9/IzwRUbKqHhk+J/2zq2ZApgdW5nMYA8XyQbvfUE/unnOze5TZJiw1Nqc5A92N/7I4Zsj0qoBmprVQv6TF3QlJjursLJ8JVXTlGQUInR/AcKN1uP7VphY56G64kE8sVXKb3iFAnx9E0VeDSXRBQfV/xuNs8u4j8DhYTvEXFAKN3TuHMigYVRbIj9aLUMjpOS+6PSCtSo18BY4b8Mbvx115Io840GHDL3zJkeoQIXZS2Zz2uVgDEkO72sBbkWspAdSbp0NTRQhybCL3uQHIQ0uMO+wwzLCmrH4l4ReV/8RU3oq5DvPtjhlZdPlOoulW0K2Q+Q6i6BuxJVTqDnjs7vfr0+4HzJw/U4f4874BbhcDDr/5YxqaWCI5BeTmP12Z2MSTh6sPxUJiwtbYxXrTYyXQGUJRyCPSeUePaFTFgODtW1gULa+snwAEvnvBlN6Dmy/2/Rud0+wBvnbWCqDmaM+c699sv88OaTgUuASd33B7V5NbgTnYNEkLS/xDuwb6oKO/NHzgPBhQVIjv6bMs1PcQcNMpNXvASqJ7jbJ6fLz+7L2JetqS3jcXAR6UsEF5KpbukPM8eXIiy0vHuZ0Ov+gCzl6yg6OLLZErYOTYMZMDfrK/w7bkRdOi38Jj2cHBbX5nzYkcN7QjDObA6RBTp/wmrdPgCDEmiaTdbHOHIhFuzIRtOvVK9LmaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(346002)(39830400003)(451199015)(122000001)(54906003)(38100700002)(478600001)(6486002)(6916009)(2906002)(5660300002)(316002)(8936002)(36756003)(86362001)(66946007)(4326008)(64756008)(66446008)(66556008)(66476007)(76116006)(8676002)(38070700005)(83380400001)(71200400001)(41300700001)(2616005)(33656002)(53546011)(6506007)(186003)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RuYIDQc2y3eqHSX6i/edkzm3LpeU0Ai1DVjTeGFyCikbN62JIrXudBxWYQ+E?=
 =?us-ascii?Q?x9yfdRoxOqmNgcAqbmFjiBqZBzVK5ggrskQf/dCYYtkolv1oYFRJsa24lT9p?=
 =?us-ascii?Q?PCQ/gp/fcuFceZaCe1N6iqPoU0Io5FZn95YuU0zLUcGmjnGYYL//D3t9aBgi?=
 =?us-ascii?Q?ftnPY/LSk1zIfRcRTsPxro/8vBYoYd560aBcEvBxQUy9jHZMcnmt9Vp4Qfx7?=
 =?us-ascii?Q?krJEPILROMzN3WEV4dmPV6CyKTi1Gg0PG0FT/wCgmvl6ArjizDQXN5cnOwUc?=
 =?us-ascii?Q?h1z8jYkj2wktM86ZQUNGuntgdoDCXcp0xnHzuouSyxUuriXo5TVmmz9C9wQL?=
 =?us-ascii?Q?Z3ITdvvy2hVmqRIrU4XQwjTZosMzuORJISfzo2bP/IzF2Zld46OsNxv/4ZwB?=
 =?us-ascii?Q?gKFDrA1cUNLUwGlpP3VKS7Nh79UA2CcoYu3gHwBNxrWSFXKagQPOe6TaN629?=
 =?us-ascii?Q?CUK98zlxknIG3H6zXQ1sla13H8CHk0uZM11rmTJg/KB3io0ZUlON62715xo/?=
 =?us-ascii?Q?nAFGeYNUFgkO6Lkd4XEKlWVxURdMSR3N1l5Agudc7PlN+yJNG0qpNvcIEuJj?=
 =?us-ascii?Q?ayGfuzJh/YJXYSKgrAoXHKvOYK0kwShsWf75g4uWHsRAgmShLl1EsKI2y0rI?=
 =?us-ascii?Q?w2G/lA+MrdvdrJnxid8OGR/3WurWCBFhg25myxLUPhd69FRYeLGf9YcVgbbZ?=
 =?us-ascii?Q?jN4P/zyU4XNvlMS4dkFBEx3czMaYcazkUix8ujzYSFZz4rDujFwHckOIgQlQ?=
 =?us-ascii?Q?B2NsR/g60wdYC+i+86zQGefADJ+wUMBetJcfBD4N7BMNEsS68uw13d3znV2/?=
 =?us-ascii?Q?z2iJkYvFWP2/hxj5+JiyOO8ON4OjY9RPe7EBBnt2okHOPUFRwGQ07s0orTH9?=
 =?us-ascii?Q?iPS0TDB+CR5oprhYDxEDWizYWxpdNpN4109JOCyCQ6asnkq5Zx7Jyp1laMH5?=
 =?us-ascii?Q?n2tRZytJ8NpPFm4H6aZKFgweWLQ60qYt2tbhtqkuZXlC8dx/KGyNQ+9jgrh9?=
 =?us-ascii?Q?BPwN64qwHFTnpQbPyDnX3WfybGYs/BM02wzKhqqRIguhT8L4AdLwOlJwyFhy?=
 =?us-ascii?Q?X1mvieHaDS5hfsXkA49jrzgvbLptLbciFRd1rrnv6VIZfDFRTxCa7xgsGG/B?=
 =?us-ascii?Q?ExNw/r8Gd5yhwSQovtxPcrKx6mnIHt4s6xETLtVItjcg32sJGj+LfgDR7ran?=
 =?us-ascii?Q?lVTEQ937vVvtzkeNe2/+2lXvhDj8HTBS0TYvxMHE/0e25mrJ5UG78Cj7H77L?=
 =?us-ascii?Q?8+c3iGQOfNHu0NORKX9Jrd0UKuMl/iCD/wvDo245bgar3uLgryN3wVjmzcJy?=
 =?us-ascii?Q?AWdFeqGPkP1dIlg3PBzL8s0k77Arol20dDqhk2nBQ8SdG9kVTXJBbxqX1GGq?=
 =?us-ascii?Q?JdhcWuT0WK/Bm/HqZrRqvkRGQmATN4C7pI5IDzUAqaNIjPzteNDiWeucu0AY?=
 =?us-ascii?Q?qVCYvvmaehlbCiRzL7uRQzSqsMsAi/OEzl9lEnzn6nY1wh0JTNmBSjmF8qfU?=
 =?us-ascii?Q?7G6hv5uUsRA9XQesTDCbVtIv4BGh4xDNwqXcH7kVlWW8CmQSKfnmmetQfBN0?=
 =?us-ascii?Q?aKIPtee+7cZRT0WnBJoLhQ4RLZ8x8Xd5F7MqEUjr+7Yhao3OStkbmvgSOWsq?=
 =?us-ascii?Q?J1uTRScn2XOO43mmvFbqwvYO3+kyNekFdTUe7dnI3D5oZBuQB+t6IqL25VhN?=
 =?us-ascii?Q?V1G4zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAC52691C0F3F7488FB31C583B4DA2D3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9998c2f7-47c2-45eb-b3ea-08dae2b8927e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 18:32:38.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNXI0XC4yNivaWV8COkC491ootea40r4Jw6r7F1bJQ33r20vF0d1AkLDAlSed/KoLU62ijkl5nkFVANaw4H3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 20, 2022, at 12:31, Olga Kornievskaia <olga.kornievskaia@gmail.com=
> wrote:
>=20
> When there is a single DS no striping constraints need to be placed on
> the IO. When such constraint is applied then buffered reads don't
> coalesce to the DS's rsize.
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/filelayout/filelayout.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayou=
t.c
> index ad34a33b0737..4974cd18ca46 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -783,6 +783,12 @@ filelayout_alloc_lseg(struct pnfs_layout_hdr *layout=
id,
> return &fl->generic_hdr;
> }
>=20
> +static bool
> +filelayout_lseg_is_striped(const struct nfs4_filelayout_segment *flseg)
> +{
> + return flseg->num_fh > 1;
> +}
> +
> /*
>  * filelayout_pg_test(). Called by nfs_can_coalesce_requests()
>  *
> @@ -803,6 +809,8 @@ filelayout_pg_test(struct nfs_pageio_descriptor *pgio=
, struct nfs_page *prev,
> size =3D pnfs_generic_pg_test(pgio, prev, req);
> if (!size)
> return 0;
> + else if (!filelayout_lseg_is_striped(FILELAYOUT_LSEG(pgio->pg_lseg)))
> + return size;
>=20
> /* see if req and prev are in the same stripe */
> if (prev) {
> --=20
> 2.31.1
>=20

That works for me. Thanks!
_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

