Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0004347C619
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbhLUSOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 13:14:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38296 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241133AbhLUSOn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 13:14:43 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLHKIDe010373;
        Tue, 21 Dec 2021 18:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Hn7mIIZcESjyxySF9AAoARi4D2TjZ0U7CY7C3cNP2gE=;
 b=uXlDPiMLSiKZP3lQc9p9dr6OFjwYopBu9VYwtbxJwjoJCxw8Yu4tyJ/KehpDfIQv7Hwc
 zAJFAW/yM2noNqhJ5EbSaMs0Dbn1WXx1W7sGIvEuBaD5Sc/Rp8Ho7ZXvYZwEYjZjQT5Q
 WMPYlF4OU8ae0Qlm6FfqKWQSTvF7D39wY9w0Z+VgluCgbIa43SJTi+8G31l5f7cyY1lB
 GrXWMLRLrbk/GqwcgQjGATMNXX1Tz8C8FPm67eTpG8+hmQDngVUIbXyP3ItKcoeRYF4k
 WRGrdFiYPwWyQ9s8lgLjx6Il9jaV4hWVlP/BGmM70Cu0wpFGrx9uOQ9GrZUouuJ0cXdV Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqv4fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 18:14:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BLI6qVn008916;
        Tue, 21 Dec 2021 18:14:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3d17f47smq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 18:14:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhCwmmoerxlctocBpsqFBtRQ3PiKLeVKSZCWv1UYaykq8WHzNSe03D7fOmIHexnVUuYRkXSdWaUmC5upV1RUSOkqEaf2nWdMiZMl0/PzjTdOQcH4mJ/gDw979NzUe/cF8BzfKsj6fUw6MRC8zK5OTloxUif/dTJxqSyUK5YOSZEhF1H4emgatHgi3BRe59lG9D88XBnENOUQuZ3hfeGpHl7k11FVldRDlWZR28nW1KnUfzpCJmIRQ1jeZrjZss+AvKCoaaeaT9efrKzKidvTl9ltGEiJ4wUw/Favls73jA3HaK1fr/QKJSUWgDq2aQt2PkT7VGOUV2Y/G6CN7SiSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn7mIIZcESjyxySF9AAoARi4D2TjZ0U7CY7C3cNP2gE=;
 b=m/GcRejql7pLXLLJHaiuBn+9PZNJgJBsFVJmy/8Tf/PFgmes5KcQMmwi0pOClUlj6JlvQ2chytpkuTOuos8BpHKPqYjMpGLuYztO2Y6hKjZhDQFn2SZb3UHUvNBfAs6d4K6Y+pAmvWIgRcrzJ0YYmtBggmDU6r+olcJgRajqFv6wcTaqymx41SCh7IjEs3GXvCAqTMG3Mli2sZs3D1L+wy7q6Yl8zhdxjlgAOq/oj6IvcUpjgU4ZCVrsCijrZR/vx3Qxqek/ueYObi9fdjmsrh79IP66M/HvxGg0Ajpg+t7BZ0tVQEiGUsdLu6ul9WKamfM0RgDjREeofxBqHzLxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn7mIIZcESjyxySF9AAoARi4D2TjZ0U7CY7C3cNP2gE=;
 b=qWQ9VD0eTznuoVTPJxSNGkyQCLBwcpCVFgr0aT7mAcTUTQA+/zAbSbQDCNKz6E60U7lpaRv0ptUQVJVOatbbmg3NaU+vYYwYgwsKsuKTJvflHfnIJUJZcenP69Oy4UTHzPKFRgcABackinlF8fgU7TsCe2WdOjkk7fupI+5XmS4=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5162.namprd10.prod.outlook.com (2603:10b6:610:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 18:14:32 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 18:14:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] nfsd: Add a tracepoint for errors in
 nfsd4_clone_file_range()
Thread-Topic: [PATCH v2 07/10] nfsd: Add a tracepoint for errors in
 nfsd4_clone_file_range()
Thread-Index: AQHX9HoI5uWnHkYMkEKN214m+GdowKw9RD6A
Date:   Tue, 21 Dec 2021 18:14:32 +0000
Message-ID: <4C063542-423A-4752-AF37-295CA0247C38@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
In-Reply-To: <20211219013803.324724-8-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 304e0923-200f-4a75-4f5d-08d9c4adbccd
x-ms-traffictypediagnostic: CH0PR10MB5162:EE_
x-microsoft-antispam-prvs: <CH0PR10MB516279D7BF3C611B875B1577937C9@CH0PR10MB5162.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrKrEZHVtV1gOXAf6kgcExVGq2Pt5JV6Xt7WMsmy6v9cNm/7q6sZ71jjmcV9UowAL4Rx+8qXI3N1yRO+uPgxvacWqFAaHYJwpstZ5sBjq+EZ9Q9BRaObzKMqUXUJE9T6zjdycpmMnslzM0VkwNyWiCkoya77bht7YEv1YgMGPWDxJLl/FcgbNe5PdP4y6fV3kGhxomlku8IjQdYilwCHoXx/X1rQ+IUdZFqVcapjxG9L2FvkWPSZg5/ftseJlRgAUEzt7uym9DPuwqIJVWYBXrRUwWJ07fPxz1BjpocPMyvu5AlsgdPEfxMkB6w3qSyblCgC46bxGohqxDNA48zyoCFJJBhs8/qxeqNEoE59P+OdwzrbkRfnwvU9biCLxoTQd0EFo9C3mJJhgdlEHrt4pojij4e5JqmKTsUxQv2UlBT+lmt77utvSWO+es3EYgre68lWlK23JY9fm6fZDItzHCVstp/PUcALTDeDVK81ozZciMAHh2JdfyNqY0q6v9iS3M/tC8HFrFv+3tNwJzMk6h6UZeIHAn//P92zJHsOzkIdfApMIGalSeucSHlTRWNTy3CmJkSf8qY+Ucj+EcKo/LcKitlBMM7S078sSUbd5k7AfodJVl7hKmHtKOZf3I7PNLHRKP5J6J7hPqpPeRBuwnU5+/lJ4++yNnljVyeZEFF4gTPWp8wGVqS2YOjiqkXmpZdJwrT/YGI7qG6N678Hb6J1L0CCc2qYlbBLwp8NhSTObFfdV0WjWtOLI3wcnWan
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(2616005)(53546011)(26005)(186003)(6506007)(86362001)(71200400001)(2906002)(508600001)(33656002)(76116006)(6486002)(66946007)(83380400001)(66446008)(64756008)(54906003)(4326008)(66476007)(66556008)(36756003)(5660300002)(122000001)(8936002)(316002)(8676002)(6512007)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FhxC1Dlbv5Ke61Q0Pi5eWWp2peQFZAAgqTU+be1XJvItKXzxZ0bEKN+Y7sOs?=
 =?us-ascii?Q?5UUt2cLYvbTXndn0khx2/XK7GjQV0aX/s9MLnl7rr9l+ZEDkM9dk5UfozCQl?=
 =?us-ascii?Q?dv7iSw/EhhkkdRorrqpvEQYUAuUYNWonUQd8dRkX7Cy0AsGcwBz9wSXkfT5F?=
 =?us-ascii?Q?GoxbMl92eD5rMfXLSQ00d/mAel/jQB2/WeLmLhK80LXrkngZC4V9Meffcr9g?=
 =?us-ascii?Q?WIsEp65QYqRDaPhHAFBnEHV7MwOCwoGqCcxZGciDEklSlcfexoE4HT9v9vOF?=
 =?us-ascii?Q?Vn2nB0mE9ShOKyP8Nzwm8sxe3Ulk8l7TUZgFJ9mSa5vG7Ix6Wuxj3VcUJrcv?=
 =?us-ascii?Q?CKmNOp++5NljY0ug3AvSFoM5VVdAw5CCNVhqzECr8GB0oOei/kwG9zTwCx2Z?=
 =?us-ascii?Q?YSjhV27bsWNj65APWV/ZGah+FS44zafXhJo5A19K/BLNkuEnLFQgfgH3sjzK?=
 =?us-ascii?Q?isfdmhz7JajUqVZOTaQ5BPdcrpZLRcOyi73bR0mkhdO3vDCuB/PBDp8tBDzB?=
 =?us-ascii?Q?QQT7koXEOGhVy8+CuC3yGc/NYhmgKz1gomNAI4lhJ/+fJZoykBpTOy3SZQRa?=
 =?us-ascii?Q?irYZx1IG/ArvBJts/sQ1qLKJLprXgHksFEO8AAuLD5XyDOLD+yIvInE0mq2H?=
 =?us-ascii?Q?6RcbHaHHpi7vfjvG/gKBRjOr2ay64EsxBDrJCo6mLX+pmXGYxrJlMCy5eiHK?=
 =?us-ascii?Q?jVnDahwAHryIqNvcnprIAI8nszucKUp8+Ny1ivm8qxkue4H9LhJCo+0/kR2V?=
 =?us-ascii?Q?XC5f+XyWopvz6Hev9bZU9V8068ZgctZ15dpsOUpvFdSVZMpUoRTbS/Ph9LWo?=
 =?us-ascii?Q?MMunsnL9oqfE4Ju2Rbb6n8CRMWvzHb8mKe9SxRF4h70I3Xij4EFwpLSjf7ux?=
 =?us-ascii?Q?FIskKObxk+oMVzGBAEAW4pLti6khgkKEHFSdZ5i3SFfVSaGt/+SZJ2t3y1PK?=
 =?us-ascii?Q?7XswD4QUo28eEfmNHwdZ1UhkOD/DBrgDYJ552yfed8nvr/drtCdU+VFRdLZ5?=
 =?us-ascii?Q?nIM1uRCPUosulZSg1prZUX4HECNaZ+ELpankMI71DIqHALZ8JosjQaQbilsD?=
 =?us-ascii?Q?lfUT/pLyi9tYq0U2sdlM+su37CdlcvPXWh8H/SQvWZPpf+AWomqBS4coLkXX?=
 =?us-ascii?Q?f4TrG0u+nh6I0KCFzLnonXYfXCB+uCX2LQb/GpUdtMXMdtUyi3tc3G9k9nNC?=
 =?us-ascii?Q?A64ii4KPyC/7Lx81yMO/G7fh/igdMR9bvrGXJVE67pM+QNcVM+Rv5WA7KsEX?=
 =?us-ascii?Q?/bhRExxQu62+nUFKFvhYsl5/RDHQ6yuzCUgHSzi6gGyhCp5KM913ZjotG17w?=
 =?us-ascii?Q?Ct2ARqOddQFrpjfTGrq4K1IRWHaBsnY/4HHIau20cyqXYgMFLCi+Q3sNSR2H?=
 =?us-ascii?Q?l12mDqb8covisCEKB3RD7SARbCmjJapIdIh7tijQfvPoj/G22djZVgxMeCJe?=
 =?us-ascii?Q?W199qNC0RLwjo75+xwqGIK53dVGx0nsR2WiSqPKewxe1UuxwPHmJkau4a1jL?=
 =?us-ascii?Q?5Js/Ir5oKQN3ScwMdJ6DySPz/llRMKidqRQ0n5b6OFZuPHmXh97iCY88CXyB?=
 =?us-ascii?Q?ugYQ8TDzPwwbMrcJMHTvIPtt01pwnwOB+UC6jaX7q9EduLqqXCtZT8ZBtQWn?=
 =?us-ascii?Q?Du0rTXwrC2E8zQZLs9+kyZ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D835E80966C464BABBD7A8C33B09169@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304e0923-200f-4a75-4f5d-08d9c4adbccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 18:14:32.4344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs1id1wtB4Zb57zOnw6Vf27FUkKiKZFHh348qzviZi3RSnmF+S2YOwPtHhCniSot4OWmZRzLQkh6SXHDPdsI7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5162
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210089
X-Proofpoint-ORIG-GUID: zPUBI6uDFBJWFvVAD0rPuJAxUaegEJ7u
X-Proofpoint-GUID: zPUBI6uDFBJWFvVAD0rPuJAxUaegEJ7u
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Dec 18, 2021, at 8:38 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Since a clone error commit can cause the boot verifier to change,
> we should trace those errors.

I've applied this one, but wanted to follow up.

I like the idea of tracing boot verifier reset events. I might
just code something up.


One more comment below.

>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/nfs4proc.c |  2 +-
> fs/nfsd/trace.h    | 50 ++++++++++++++++++++++++++++++++++++++++++++++
> fs/nfsd/vfs.c      | 18 +++++++++++++++--
> fs/nfsd/vfs.h      |  3 ++-
> 4 files changed, 69 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a36261f89bdf..35f33959a083 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1101,7 +1101,7 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 	if (status)
> 		goto out;
>=20
> -	status =3D nfsd4_clone_file_range(src, clone->cl_src_pos,
> +	status =3D nfsd4_clone_file_range(rqstp, src, clone->cl_src_pos,
> 			dst, clone->cl_dst_pos, clone->cl_count,
> 			EX_ISSYNC(cstate->current_fh.fh_export));
>=20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index f1e0d3c51bc2..001444d9829d 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -413,6 +413,56 @@ TRACE_EVENT(nfsd_dirent,
> 	)
> )
>=20
> +DECLARE_EVENT_CLASS(nfsd_copy_err_class,
> +	TP_PROTO(struct svc_rqst *rqstp,
> +		 struct svc_fh	*src_fhp,
> +		 loff_t		src_offset,
> +		 struct svc_fh	*dst_fhp,
> +		 loff_t		dst_offset,
> +		 u64		count,
> +		 int		status),
> +	TP_ARGS(rqstp, src_fhp, src_offset, dst_fhp, dst_offset, count, status)=
,
> +	TP_STRUCT__entry(
> +		__field(u32, xid)
> +		__field(u32, src_fh_hash)
> +		__field(loff_t, src_offset)
> +		__field(u32, dst_fh_hash)
> +		__field(loff_t, dst_offset)
> +		__field(u64, count)
> +		__field(int, status)
> +	),
> +	TP_fast_assign(
> +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> +		__entry->src_fh_hash =3D knfsd_fh_hash(&src_fhp->fh_handle);
> +		__entry->src_offset =3D src_offset;
> +		__entry->dst_fh_hash =3D knfsd_fh_hash(&dst_fhp->fh_handle);
> +		__entry->dst_offset =3D dst_offset;
> +		__entry->count =3D count;
> +		__entry->status =3D status;
> +	),
> +	TP_printk("xid=3D0x%08x src_fh_hash=3D0x%08x src_offset=3D%lld "
> +			"dst_fh_hash=3D0x%08x dst_offset=3D%lld "
> +			"count=3D%llu status=3D%d",
> +		  __entry->xid, __entry->src_fh_hash, __entry->src_offset,
> +		  __entry->dst_fh_hash, __entry->dst_offset,
> +		  (unsigned long long)__entry->count,
> +		  __entry->status)
> +)
> +
> +#define DEFINE_NFSD_COPY_ERR_EVENT(name)		\
> +DEFINE_EVENT(nfsd_copy_err_class, nfsd_##name,		\
> +	TP_PROTO(struct svc_rqst	*rqstp,		\
> +		 struct svc_fh		*src_fhp,	\
> +		 loff_t			src_offset,	\
> +		 struct svc_fh		*dst_fhp,	\
> +		 loff_t			dst_offset,	\
> +		 u64			count,		\
> +		 int			status),	\
> +	TP_ARGS(rqstp, src_fhp, src_offset, dst_fhp, dst_offset, \
> +		count, status))
> +
> +DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
> +
> #include "state.h"
> #include "filecache.h"
> #include "vfs.h"
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 85e579aa6944..4d2964d08097 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -40,6 +40,7 @@
> #include "../internal.h"
> #include "acl.h"
> #include "idmap.h"
> +#include "xdr4.h"
> #endif /* CONFIG_NFSD_V4 */
>=20
> #include "nfsd.h"
> @@ -517,8 +518,15 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, =
struct svc_fh *fhp,
> }
> #endif
>=20
> -__be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
> -		struct nfsd_file *nf_dst, u64 dst_pos, u64 count, bool sync)
> +static struct nfsd4_compound_state *nfsd4_get_cstate(struct svc_rqst *rq=
stp)
> +{
> +	return &((struct nfsd4_compoundres *)rqstp->rq_resp)->cstate;
> +}
> +
> +__be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
> +		struct nfsd_file *nf_src, u64 src_pos,
> +		struct nfsd_file *nf_dst, u64 dst_pos,
> +		u64 count, bool sync)
> {
> 	struct file *src =3D nf_src->nf_file;
> 	struct file *dst =3D nf_dst->nf_file;
> @@ -542,6 +550,12 @@ __be32 nfsd4_clone_file_range(struct nfsd_file *nf_s=
rc, u64 src_pos,
> 		if (!status)
> 			status =3D commit_inode_metadata(file_inode(src));
> 		if (status < 0) {
> +			trace_nfsd_clone_file_range_err(rqstp,
> +					&nfsd4_get_cstate(rqstp)->save_fh,
> +					src_pos,
> +					&nfsd4_get_cstate(rqstp)->current_fh,
> +					dst_pos,
> +					count, status);
> 			nfsd_reset_boot_verifier(net_generic(nf_dst->nf_net,
> 						 nfsd_net_id));
> 			ret =3D nfserrno(status);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 6edae1b9a96e..3dba6397d452 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -57,7 +57,8 @@ __be32          nfsd4_set_nfs4_label(struct svc_rqst *,=
 struct svc_fh *,
> 		    struct xdr_netobj *);
> __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
> 				    struct file *, loff_t, loff_t, int);
> -__be32		nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
> +__be32		nfsd4_clone_file_range(struct svc_rqst *,
> +				       struct nfsd_file *nf_src, u64 src_pos,

checkpatch.pl complained about the missing "rqstp". I added it before
applying.


> 				       struct nfsd_file *nf_dst, u64 dst_pos,
> 				       u64 count, bool sync);
> #endif /* CONFIG_NFSD_V4 */
> --=20
> 2.33.1
>=20

--
Chuck Lever



