Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1346740D1
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 19:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjASSYo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 13:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjASSYn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 13:24:43 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2109.outbound.protection.outlook.com [40.107.95.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CA887298
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 10:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh2vzWQ0MnSAnSJTNwbfcW+d+02PgNOBE5APBXTkcY1e8r9vhNoE3akqPOSQ7VQKyNC/51lHP4R3bmkZkadpj8vjVfbBxLN3Rf2606KjQdyGMc9UVi9bXLn+If9RcNBhAKlZgTUWKJBlsxZwUT/QiAVoBwsCX5txsLhFlVixGvmO0ma6kgpRh5g2aQ9glOGg2Ys2OJhtnYwXRtyNoZQXu22hkxZ+NlkbYqx2Sps1/17miuqfFaPh/EyUMb80MfyBbUpRCn1HmBsry+Mfeqy1IJwkXYWjCdbiR6m6Pkg+bAyiZiRdVm7OMViIGR8G2rc8HwFBs0Rf88EMKLrIk4xGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clzGYU90VTCLm61oSIaLjwDywwI3DqQ56VbVuu+BNzg=;
 b=CLV7JkElSnhVA60ivXgPuh2cmT0NQZCaImkemUVBmanalzJ9hxesxhg4vJn0kPqpPvyXclB3Tbt6K2BBT0C3MBAT0aiVjtM/hWBOFty25yUGf4srVVK7pFpaEu2ZEg72uNtgkasUE1++ZHACjPsb72wEF27KVYCsZuWhH0ojJrU3KsV8eLTuFLvjHHopLgI6MSxRbBJtI/fD74WUNEQ/jVoZ4evgdITL+Lczw7hS5qlaU6KKXcBTXf8+QfGQ/CgsgO46lDl89arJdLZHOT8j+fag144tfaUUM+W/cgu8mGSFNiq/5J6gj+5AJ356kICzcJYFibU6rmO5dB3pSLCmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clzGYU90VTCLm61oSIaLjwDywwI3DqQ56VbVuu+BNzg=;
 b=Erdk4uG37s7V3oyQYjbi4Ky7WnPEJXPcm3sEtu6JSvO6o6JQKvJqS6BqLY7NiV5LKjw6rtqFJHxwFoX3+Y13DZdPMmI02bBpnPVuf5Zn404Bpx9HmK+NszsQY1GrTSJCqw4dBkBgnFAeztsFntQGd53RU+/MI0svondMiLzecnM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN4PR13MB6023.namprd13.prod.outlook.com (2603:10b6:806:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 18:24:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::7007:3376:4f4e:b87b%4]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 18:24:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] pNFS/filelayout: treat GETDEVICEINFO errors as
 LAYOUTUNAVAILABLE
Thread-Topic: [PATCH 1/1] pNFS/filelayout: treat GETDEVICEINFO errors as
 LAYOUTUNAVAILABLE
Thread-Index: AQHZLC5+WV3KtMEgS0CPt+y/JtfSTa6mDiyA
Date:   Thu, 19 Jan 2023 18:24:38 +0000
Message-ID: <C3BB5432-E3A1-4BC0-983F-0A1B11E828A0@hammerspace.com>
References: <20230119175010.57814-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20230119175010.57814-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SN4PR13MB6023:EE_
x-ms-office365-filtering-correlation-id: 32896135-4734-496a-8997-08dafa4a6ca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yyubrF+1EaKBQ+wLZIEj08Ea19GkXbO/W6exrvJX8NfwMsK4FsrLt40BVAxxltDGqXhIZF+FvDlhajQhJ0GX2DWUuBw1IuEvZQ5ZAkyGc34OS4zYeMTErApWAj7/OzxPk5q+L+HK1XWWV6CNrWdtj///u6G0Ihlea34olf6TxjPDq8kE0qJwxWVXxx98F+MaIJX5VIGYGMYecPcsnbDAthOmHnpQLtOCKLAW7ovq5/lkXjnEhNT4+ryf+4uwTFgy7cOdNrbefMIrFjEci3RcGQxnUF+6WaZ9iGtnzhxi1/hV4ceT7xmUvi4VhhVKlJz7ELsBCsWI+Gn5VrwqTIJzE+Y69sKIJZfgjyRSzf5yXQL/D4RfIevEOhO9ilBaTzbNarkuf12pc9Lrvs0khboPBfwNDtZwjKZmPcJ+dUp+IX6/TBYPD5GNoYjPJtOHDe1pRGMu5CYeeE7tOaGOWuWOG5vtaZR3h4sSVHzB1zucia0+hdid1kV7oG+VNaTZDz+8MN0FT2Td+s3NLviswkCuRiiJ8CWLtzJbW/IcAXhvwT0ghAG9c7CdPcYxHhl7TTpSArHX78HZiGzUkUQXGgTI51GOs69vuOjS4LyMGshbkiz+5SZ9MPTzE9ZDqeG34CgeIFyVwuDNIrQvJrnxt8aHBCxpZxUPJIYV/sR5TPzNNHIfOnZbPBc3/pUIm4of+vf5Dat/r+IsmB6z/ugtCvUtgmDyzgJ3/B0cEZIWtuLXf/Z3wsZMySCKPs1nMQzb1D0B2S7OtSY6ZgX714iKg97EcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39840400004)(346002)(366004)(451199015)(71200400001)(8936002)(122000001)(316002)(5660300002)(33656002)(86362001)(6486002)(36756003)(478600001)(53546011)(6506007)(2616005)(38070700005)(2906002)(83380400001)(54906003)(66556008)(38100700002)(8676002)(6916009)(66476007)(66446008)(64756008)(76116006)(4326008)(66946007)(186003)(6512007)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wi4y6J34QtX0lN5iWfzaOa143pjxj4zxu2mbU4PB1ZA35J4vWRNM8sj/4Bly?=
 =?us-ascii?Q?Nov1y4Da2ceViJGjitmdc1fOp1YKNlaJs4Ej1bd7iKG76RBwWBP1jcXD0LhQ?=
 =?us-ascii?Q?sSc+EKHa2oaEQpRCvcsxwP3EHRtPn8HhFSplNjvDn2wfqsqtcOi/ATM7CMH0?=
 =?us-ascii?Q?w/DWl/iTExRXBQYA/6I6argb2Uzkl0OvSpq+OCHGHnt6iDY8m4YkDU/lDA1c?=
 =?us-ascii?Q?7+d2fQ6RmmcF/Nxt8cBQ8hhJd4Ke0HaSL67uxknKWQnpianK4Xde8+TI7SNT?=
 =?us-ascii?Q?5F50LZkkOrcEYNA3MrproA04DF29+/AoAaWSIN/+eH+YBNoniQgbU5mL+/8z?=
 =?us-ascii?Q?gt1+4tG0RX9mv6T4E6Qx+FuQvHdET7BT+iMf58CujWjf7u4fWeb94AmESqmw?=
 =?us-ascii?Q?rQ+G9LIgFR9f0XC2Gus21ZqeeFa78Zcub+wfomDzLP5Dg9LQqsVaBx8/Fymk?=
 =?us-ascii?Q?meZj/RUYiLILWV6QBMI80Wodga/53IcNdT0rCSD6PsCuXFQ2abuO4OHWVruM?=
 =?us-ascii?Q?SxJKG8kUiZ9ObW5tqYHxZliKV/PzY9MhtlJhH6PPwavbTbtqjexEEU3JzgLj?=
 =?us-ascii?Q?G4Zp05NtaA7V9UucwQwaorsXMx09czqDHadN+F0KO5vVFhbFBYImPmPpzWOO?=
 =?us-ascii?Q?X9f+lw/Y7ZBlptKR0L4ohewBpikIX8U8O604i6yWIarA/f7le0DaFot5dyyh?=
 =?us-ascii?Q?m5Y4oq5RVcATU8KC9kGdnjwY7rvdbjdKt3/wRYn5NtFNc+u9U+yoySEHEeAi?=
 =?us-ascii?Q?fwqJzUCeiBirucVbmH+p9IBPg6DTJGBaE0aDll2TY5Lbs6IK7+fchXvNIQja?=
 =?us-ascii?Q?M3wuHqRHbpRFZfbHH95dx+uHap0F7a0g6M4vFG9meNAWlsJpHt/VPTqfrxhV?=
 =?us-ascii?Q?+yjYRNDGK9MOX7iVi+cA/5oeNrmSQPnrDkwT3iqWUZjMSTNb32lBdrazhFSN?=
 =?us-ascii?Q?uO0TzploNDHGfazfoGTtdJPc7jbNLyXUeetFx0sC5TPMKLt5MRDGE6gc5Dlg?=
 =?us-ascii?Q?j6e1O+DXOWM0NWTQ3DdyEgiivDGuyFjPRL5tC/KZRFuKNmSqIFqvph9ClUCC?=
 =?us-ascii?Q?qVWz7eSULknagOs+kvOve7lZpog+432dLppZciOS41KubiMiZTZaCgH+N+Vv?=
 =?us-ascii?Q?v7CSD8acme4qsEr/YVYJ/JimRtz8IpDzSPGrS68BfmJ2UlqqY/sgXAANL3w3?=
 =?us-ascii?Q?zh+xliXNC1ceSP4af0VBQsoWslNeDd0po5x5qVnwfnX10zLLUS1kLcrYbVFX?=
 =?us-ascii?Q?yh4AAudsnjljzYYh6HszWU4rXjJ68CZo4mk5edHVCEfUXWkb2Stg0ItvG9BU?=
 =?us-ascii?Q?RbCgGA8nU+XVpEsQLtrD4H0ErmppzlckKtIv48QHEBZabLii+Gr7CFKbcvd6?=
 =?us-ascii?Q?09nrU24+NyqWl76ausTIoo1M7hya0BdZT0LeHVhOnjOI27XN4Ze/9K41xDU/?=
 =?us-ascii?Q?6QZqKmgkaNCO6Z6eoaSSspl5+4hz/hNHN8MWv5S8Hu0Nq6VXpc7aFQqFS6J/?=
 =?us-ascii?Q?u4C5GEV0PJoPqIOgMw1z/eVHVsbX4WCQCSKNRCsETMQBqwNQ5Mu/yf0vuRQn?=
 =?us-ascii?Q?M7c0S8ijtYUMjY1s+a/V+vErziKN6fJRI54dWhb805Z+IO58iN6ekK4GiHo3?=
 =?us-ascii?Q?00QiNEJUWju+5VOOtDz5gejK5fd6LkBeumMI62l3E45I3dliRd6melDyLvX6?=
 =?us-ascii?Q?4vWxpw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54E0D1AB42193443898ED4A1D9232B71@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32896135-4734-496a-8997-08dafa4a6ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 18:24:38.3189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mMKLgT/LSTCMPf7S58T1HMIwu8fi/h0CZTlnwMhtLn3vBCBuxjqebPHRC0+7HuA81nZntAdW7K+I9tFLc9K7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 19, 2023, at 12:50, Olga Kornievskaia <olga.kornievskaia@gmail.com=
> wrote:
>=20
> If the call to GETDEVICEINFO fails, the client fallback to doing IO
> to MDS but on every new IO call, the client tries to get the device
> again. Instead, mark the layout as unavailable as well. This way
> the client will re-try after a timeout period.
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/filelayout/filelayout.c | 1 +
> fs/nfs/pnfs.c                  | 7 +++++++
> fs/nfs/pnfs.h                  | 2 ++
> 3 files changed, 10 insertions(+)
>=20
> diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayou=
t.c
> index 4974cd18ca46..13df85457cf5 100644
> --- a/fs/nfs/filelayout/filelayout.c
> +++ b/fs/nfs/filelayout/filelayout.c
> @@ -862,6 +862,7 @@ fl_pnfs_update_layout(struct inode *ino,
>=20
> status =3D filelayout_check_deviceid(lo, fl, gfp_flags);
> if (status) {
> + pnfs_mark_layout_unavailable(lo, iomode);
> pnfs_put_lseg(lseg);
> lseg =3D NULL;
> }
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index a5db5158c634..bac15dcf99bb 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -491,6 +491,13 @@ pnfs_layout_set_fail_bit(struct pnfs_layout_hdr *lo,=
 int fail_bit)
> refcount_inc(&lo->plh_refcount);
> }
>=20
> +void
> +pnfs_mark_layout_unavailable(struct pnfs_layout_hdr *lo, enum pnfs_iomod=
e fail_bit)
> +{
> + pnfs_layout_set_fail_bit(lo, pnfs_iomode_to_fail_bit(fail_bit));

I suggest rather using pnfs_layout_io_set_failed() so that we also evict th=
e layout segment that references this unrecognised deviceid. In fact, there=
 is already an exported function pnfs_set_lo_fail() (which could definitely=
 do with a better name!) that does this.

> +}
> +EXPORT_SYMBOL_GPL(pnfs_mark_layout_unavailable);
> +
> static void
> pnfs_layout_clear_fail_bit(struct pnfs_layout_hdr *lo, int fail_bit)
> {
> diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> index e3e6a41f19de..9f47bd883fc3 100644
> --- a/fs/nfs/pnfs.h
> +++ b/fs/nfs/pnfs.h
> @@ -343,6 +343,8 @@ void pnfs_error_mark_layout_for_return(struct inode *=
inode,
> void pnfs_layout_return_unused_byclid(struct nfs_client *clp,
>      enum pnfs_iomode iomode);
>=20
> +void pnfs_mark_layout_unavailable(struct pnfs_layout_hdr *lo,
> +  enum pnfs_iomode iomode);
> /* nfs4_deviceid_flags */
> enum {
> NFS_DEVICEID_INVALID =3D 0,       /* set when MDS clientid recalled */
> --=20
> 2.31.1
>=20

_________________________________
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

