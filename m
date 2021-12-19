Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDE47A1C4
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 19:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhLSSeX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Dec 2021 13:34:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10490 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236304AbhLSSeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Dec 2021 13:34:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BJ9KE8w022691;
        Sun, 19 Dec 2021 18:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sBbX5DfUrxF3ot8Ua2EZ3VmFcAUu3LKcr8M6nm8AtBY=;
 b=JgXhaMcQJr/ZENCzmFcPwzHiBkIWedtg3ShNFZJ4AMRXh+0nJg2WAf9iKXozhy8xWCNM
 iirIpctu9cNxXEgZ7RCocJQgV8dHNBbwtST7nkPLilKhHKgCMwaTxOZawJgvzs9zOO+Z
 cimrHmc0IFH0k6Zf7Hzw7Z4RXEJpyhqDCV/UzJHwYpefCjC+RM1QePYyjBAynJKfk6Yo
 fn/YrlSKg0G7ZrYoGrc14an3i53b7xFFYeGZDXSgRlFqwiTa55cuPNichMgmehfKQC8+
 cqBqqUBZxK8Y5vWtaSaeUScLQPvYOGkPJomkVsNiouxYwe9OZ8h507ZkXxZPnwpjHSXZ Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d1680207n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 18:34:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BJIQUPr138711;
        Sun, 19 Dec 2021 18:34:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 3d193jtvce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Dec 2021 18:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGZAtj+9V/kqWFxTyyNM3cJMxiD1r9OsThNfTCy2uOhAr6zZLuRzKWgEMrI+kY/eVqKTehP9/8Y/rx/8m4wjiPfbkwXfhdY9WYLfcUgPkEL15JfyNdy1Uh2NLOAq3rVGTiDdpiRtii8HIFWV3rQeWeeOamVfWrmfwUWf1f6JkxhuW7/HfnMQmdxEYmOGF0BLEmR0aPA8yuaCQ7boLtoZWhGYfWWNjBRenLljErqIZKy4mfMoTpbUxl/Aqe8k7hj/t5A+QBRxh9YysXGz2Aqn7dN9AprB8iXleDsmjyvc/SRk6SUqr6QSwwXrCjCwtExRQnssTHfm/hEWX0676ye5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBbX5DfUrxF3ot8Ua2EZ3VmFcAUu3LKcr8M6nm8AtBY=;
 b=BRE5BGMF1MHUHpEZd36Y5S4EzluIy2ee9LfjTbCJWp9DDvT7a78umL5daxPncBDyqWMM64pj0Bu1cxrC5ztH8W/N127aDZc8O7NgrUCMljpz5LuXfctAaHqs9u7hAO6+CEPh/nGUanbVhr4E684+53cklxQ2NbARPm9JTBJmxhbYNqMF3DqIK+q8S1QoLCsZD6Pjt5kfuTcoEikBIda1L4GmXAGGMivwZsTUfTyy0drpPT721W9oEbrUonPz4Ozoqv7yG9oXI4LRH9LfYKZFh47zYgyd36hg6uQARcmPzxEvYPalp0JGfCHvvomfbpL8lemQXksHKsq/12tUHZvyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBbX5DfUrxF3ot8Ua2EZ3VmFcAUu3LKcr8M6nm8AtBY=;
 b=ZJLFDrxHNUB7FB81Pdm8zUF/5l5o3mSqlThV+q7DED9SLelS2NpZM6vt1K57Ihf7IAsq+GbEzyzKX1lGh82dZQW8BbsLmd+l/vd5gRPhi7iWLOPeltikgVXjGqScdwr6qLRopLdrOvCmUC1pQmFB5S9hT4X2f3BQnpbA/ohM5II=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5035.namprd10.prod.outlook.com (2603:10b6:610:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sun, 19 Dec
 2021 18:34:15 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 18:34:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] nfsd: allow lockd to be forcibly disabled
Thread-Topic: [PATCH v2 09/10] nfsd: allow lockd to be forcibly disabled
Thread-Index: AQHX9HoJhWnJgEOGdUmX2SRgV5Jy6aw6JRcA
Date:   Sun, 19 Dec 2021 18:34:14 +0000
Message-ID: <12FA08AD-3F5B-4E7B-91F7-E2EFAC680A3E@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
 <20211219013803.324724-9-trondmy@kernel.org>
 <20211219013803.324724-10-trondmy@kernel.org>
In-Reply-To: <20211219013803.324724-10-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 250f7d60-cfe3-4d6b-34c4-08d9c31e28dd
x-ms-traffictypediagnostic: CH0PR10MB5035:EE_
x-microsoft-antispam-prvs: <CH0PR10MB503520878F21A236BAFE7A88937A9@CH0PR10MB5035.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRIBh4ThWxqm17h6PZz7xhqDNNVzoQQKfWaFAsoEEb3eukaEMe0a8gTfwHLrVK2kxeh3YjqbWuTr1oo9LgZk17CA6hf2Ivia07AF13rO1pjtFzOFlB2vXzSQR2HRfU4EPoTqBpYe5cMAIMQ+IKuQd9UtAODSBlYLqs4q8D6lOv7bTEbd+bDbZF5znmvunZMEl2/k1J26zb8jjQo5+ZklvLKnQNxtPfO6P35nmgJylK4BG2ADmSpd+2Svkjnwy3D0ge6hAAWS4UEF046RXf6mL2ogUwVfT0jW//m2KQNkLa7XuCZqzpE5tgV7xR/ZMpaKgSeeLDLemZhwYjVKXuTZ2aBsSS8A7L2a/vWRU9SZvjhkdXS1hvgIS+QLAdsxAa0qsP8eFN56DoZ77bVGJbHU83BFJzbpDCCZX3sOaqrUww4eg9FzbfFfA70adHXItUWi4b/NiAQqVnF5Bje3s2dLUUB7ZhDIezkbeVq8YHPi/Qc16INGTXvyb7svQfS33PsTiLWtgaSBU+uvrEmd0SOvf8Q2VosQcejD4gy35OhYbRkXslHpR96ov4kmyqnGuw5t241mha545rU53vId1By6XsihqrSYaamz1s46+RgyTaAcB+eMS/Rcyn20lRamOseHwG8miq9SVfpx+ea9l6n3HfHCLw6C5XfikIDyZ+tEgMvKcI+KQT4USnk5LsYMfCHglkotsw/DQqwKkC0p3OeLHrTG1nq+dMemvyTGv7pTtU1B8c+3MrsMpDrNjRRAzbPk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(38070700005)(6486002)(6506007)(36756003)(5660300002)(66556008)(76116006)(66446008)(66946007)(64756008)(122000001)(53546011)(186003)(508600001)(4326008)(8936002)(83380400001)(2616005)(33656002)(38100700002)(86362001)(6512007)(66476007)(8676002)(26005)(54906003)(71200400001)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aunY7m33VnUgJ9QUZPdXrAFOKvCbxhHeorT2D1/DZ3UJWBMvK4Nj6df5ChxL?=
 =?us-ascii?Q?8/y0NZ3Shv3pSj+ag3QMh0ullQ5fISdLUPaFIog6vWtiUrpxYNdF6FYu9q2t?=
 =?us-ascii?Q?Q5b0r676rOD2raY6ljaX97pG+5Y/I57PM11XMAarR3zmDFh4GRu+9S3Pcgkk?=
 =?us-ascii?Q?T5pMKtaUx7NsrqkDiMudu7giKYBqudXeY1s5DouMT2kYsooeVIvBCVrXMEAN?=
 =?us-ascii?Q?XG7hDO3JyfeepG0gxVTWdO6F5k2qI9+JEH8lqKtYIQAzPTvQfPUDh3fAQYb7?=
 =?us-ascii?Q?ndDpqSMvgl4ExVjJ9Vy850dEmKlWu6Y17TKpiq5pcVT5jTgBAdv70ys1RMhS?=
 =?us-ascii?Q?a+8fPmFOTC/LbVOTkRcBLy1wQMg0TvzNze5vB+/XsyLrzjmdLNoC+/dqF9Ap?=
 =?us-ascii?Q?o0SqQDZLWXybr7kPua6hbFTvPFCN8R0FT6LK/a0iG3XNOW4t+wUoPG0I0zDr?=
 =?us-ascii?Q?C7hXahw8Jt7o4ZA5+V+ikQD2gQ1FlHoyEeSfIyt1Ns5BSbvrbPeed+cGNxKg?=
 =?us-ascii?Q?NxLJnD0aMi8RJrcCVj2CYLt+s+b/d7EFUDA2tfKqACciL2SjwQz3A2tHbNpk?=
 =?us-ascii?Q?c7h4UHcv+3u0pQ9pH9S+QYPhIh6sZIIldY5zTfXWHUfsU8GWXg/6vJaoSOlD?=
 =?us-ascii?Q?geDGPIJMx4elvTwmw1p4P7VZ+zYZKWqjXS8+eQT+JE0JU95S1WMPFuOAWRn3?=
 =?us-ascii?Q?6eQM42lcGCHjvXJgEpECUqITJeJ/iIDXYVIv3xyxbUqjt3JxiVKB8Z/mXWsX?=
 =?us-ascii?Q?9FPEMl2iMSPERik2L1RhaUZlz+GGXsjfYVO0c/XoNRJ8EIG+HiD8YgHIQJvc?=
 =?us-ascii?Q?2csHe16KDFIbc4wf3JeQfucuE2DuPdkHycrzW2OWGZxy4S9jqQGLOKStAndy?=
 =?us-ascii?Q?fE+NCmmY8t/kRQ9GYW7OOYWZbiVVtQzeFeFLZsJYZYeoXEkpHgBrB+cRgR7z?=
 =?us-ascii?Q?MWeTdeWCGbmCCHvVmw7cu7Xgp65XtvymRfY6C/I/rfjcB3C8FsROubZxGNrB?=
 =?us-ascii?Q?5+SYMfr7eI/DJ9y/OpOoPJw7dwnx7y+BVJMXTXd7bDMTAsGlC+A1VODuJux4?=
 =?us-ascii?Q?aY5zTqvS5SqbiS2vYmSvd+TB2M5yPTN00vBwrN/9UO5i5cvxNdBKzmtvN8Ii?=
 =?us-ascii?Q?RIbQLUayEtvvVBdyrhus4dv4/Q+1/eYV6emCAsL9ZmnD0j2+NsH4h2at58e3?=
 =?us-ascii?Q?Ca9sJzwMA0Xz4e8ppGBVdEF8Xy8THqGiye35bLW83hR9rtMeONs7D1mhgeG5?=
 =?us-ascii?Q?YSe5Uoa7wdqiwaT9YDoRhR5tQsXWbppuec3IlhpDx2ag3zKQGZq9/yVPJU7Q?=
 =?us-ascii?Q?J48RTX9+eHch53ESY2tXccL9rwHEJPtmvPk88+KDnQRJ38FeJd45/weSSzEw?=
 =?us-ascii?Q?L3H6Xqw6EN+j39kKMomMLipWz+tOYDZsys3NZXPokvzP1Y5jTijfWBy62eYl?=
 =?us-ascii?Q?Z5ZFfJkPrfV/LEeGf/JkPQpajaUj6ixoWg0eojXRvqA909GVWKl2DGXxhnjX?=
 =?us-ascii?Q?XQX6WMkMBwdNnSdXmxn7RMgE2i1JalIB5+V07N1gM8ZagoU0MiFsrRngDRFG?=
 =?us-ascii?Q?+ZNLzwBM3n6hWm9gDj748G97gIFPBAf4hHxbCcJUWWn+odZq73Z+d8lRu9TS?=
 =?us-ascii?Q?MDmAb5Mi1G48XNeZEZmkBlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFA9F76FF744C243B0B06A6D36254ADC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250f7d60-cfe3-4d6b-34c4-08d9c31e28dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 18:34:14.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erJKtm7npj6NYjUgzwRsjPBGVm1B44i5+aoq8uRi1ycERo6ZNg7FuUm9UNWcp6IIiVzrpLCCCwktOEPpFdrkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5035
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10203 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112190115
X-Proofpoint-GUID: VGtfwQdeyuWZClx4E5OvoN-AfKALXRnW
X-Proofpoint-ORIG-GUID: VGtfwQdeyuWZClx4E5OvoN-AfKALXRnW
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 18, 2021, at 8:38 PM, trondmy@kernel.org wrote:
>=20
> From: Jeff Layton <jeff.layton@primarydata.com>
>=20
> In some cases, we may want to use a userland NLM server which will
> require that we turn off lockd.
>=20
> Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/nfssvc.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 80431921e5d7..6815c70b06af 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -340,8 +340,19 @@ static void nfsd_shutdown_generic(void)
> 	nfsd_file_cache_shutdown();
> }
>=20
> +/*
> + * Allow admin to disable lockd. This would typically be used to allow (=
e.g.)
> + * a userspace NLM server of some sort to be used.
> + */
> +static bool nfsd_disable_lockd =3D false;
> +module_param(nfsd_disable_lockd, bool, 0644);
> +MODULE_PARM_DESC(nfsd_disable_lockd, "Allow lockd to be manually disable=
d.");
> +
> static bool nfsd_needs_lockd(struct nfsd_net *nn)

                              ^^^^^^^^^^^^^^^^^^^^

An nfsd_net * is passed to nfsd_needs_lockd(), therefore the
availability of the lockd service needs to be aware of net namespaces,
right?

NAK for now, but I'm open to more dialog about how to support the "no
lockd" use case. That's intriguing.


> {
> +	if (nfsd_disable_lockd)
> +		return false;
> +
> 	return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
> }
>=20
> --=20
> 2.33.1
>=20

--
Chuck Lever



