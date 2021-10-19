Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6480A433A08
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhJSPTT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 11:19:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49984 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhJSPTS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 11:19:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JEChJ6002884;
        Tue, 19 Oct 2021 15:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f1VUQ8CFUTqUzBujtraJ4xlywhPblRZvZpScHRGuV6Q=;
 b=hpbMJCLALeMsvOa3vfP1XhQKhJeksdJwrvpGN9oRhe99W8txsXfdfm7iOMQBapPNixNP
 6Ca9FMF4lnaurOIanRUmH9Tez2FxOt1nWfX/DZg45dRo+F3zGUhU5tq9LOdERI1vkt3M
 dnwRTPKsHGKbUREjveOWGIqsjFLBnO6xDrzoRTAEiHSBiyHYlIumqEU0JQyjUXOdBkue
 0tYEAypMCoE4YjkKM4EOMHaYXPvMjlmTcHBnA25IG6E+CICLjSWajQv3qGIXbxYAc9at
 2yLD1aNGFz+JzzDiVqfdGZXiu6VkaPERNX46iNJoVsB9aQWmqP0RBShNgxVpmEXuu8IZ GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsrefb5n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 15:16:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JFGnrR081568;
        Tue, 19 Oct 2021 15:16:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3bqmsexh4j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 15:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue58kzo6BWSRL/GgDIbhiwbX1sfg3b507YdXuNryGaFR+/bQJDTC8n63A/Q6/Xr/0S6gcRi2BynzEXTg2LT9TM5KmT5/T4FrQ8s9JXydJ4WYjd0k3IpIP6HlgcN97U/XOrubm+wnEZPz2cUMbXGyYh5P1GNo8C0b+mdcjRUVDUIYcG6x07A0AOL3z/bnpWvtYoio6SCzjb1F+5iwl9wwUd4a5QXWLYKUsQ8ySfXsP4CQ8h/l04C9bVz0X3NtHaEiBIeO+hADCgsjPxDoHTU5yhCGLPgOqQUJJJmo7Rugc6hjdw30v5j0DXl61204feAsRRtBd0kN831gsoHf42IziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1VUQ8CFUTqUzBujtraJ4xlywhPblRZvZpScHRGuV6Q=;
 b=jsO0LIf+L2I/pW2PxZq7+kLf1dWWz2iJVxeKZz9ST1qXjIYmcgeyNWj2cHMtQ2dsyH1J+bHmRHUqchKxjdWr2pK8pZCoUrAIn2q34zwJwHuGLdCvF1hqH+qd9aRimyE4I6Mp6ehnGzOMm4ApkBySZ7DlT/nBR15nYPMHvA5AoJwkWKoMFICKrO5UFA9mu43H5Xndh82lHxWy58rRygpdj6ZITu7WIQf3KOIyJ7VhfzFD+T0/D5WnrY4QRsCqHZC9LI+PcEdRNuTcbX/7DZPa6p8J2/9Fg4jBUbQVcr3zfyf9vCz7vOvUF63vcpuWTv0V39olbrSYNqj/yU4mDK1RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1VUQ8CFUTqUzBujtraJ4xlywhPblRZvZpScHRGuV6Q=;
 b=dACGh8mErT6hIXWdQoeXptFCOwLqkKi+05HOtVMZkHyfahfsIBszbGIn4lQF4CIUmpW0b0vOSxC+XYK5K4Ynsei1CL+qHNO5oDE5Iuzq/KXzlUzIowiDXvVGW8iFmLp/5A3NPSrUGu4azeXjoHmqsg3V9cqzecxyOnAsQL1cyuY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 15:16:48 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 15:16:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/7] NFSv4.2 add tracepoint to CB_OFFLOAD
Thread-Topic: [PATCH 5/7] NFSv4.2 add tracepoint to CB_OFFLOAD
Thread-Index: AQHXxGwEJEU6hcAUf027GKBIL3/nzKvab8aA
Date:   Tue, 19 Oct 2021 15:16:48 +0000
Message-ID: <9B0CDAB8-670F-4D34-815D-49AC44B4DFC6@oracle.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
 <20211018220314.85115-6-olga.kornievskaia@gmail.com>
In-Reply-To: <20211018220314.85115-6-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d604bc2f-2d3c-40fc-290f-08d993137863
x-ms-traffictypediagnostic: SJ0PR10MB5836:
x-microsoft-antispam-prvs: <SJ0PR10MB5836B019AA6681DD6A88BDDD93BD9@SJ0PR10MB5836.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:164;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TN5mL6Rwcr21OUwCFbXJTBkvUmX7QhiJiWgGrFr1XGnHaImWX0gq03MVzcJ3BM7gVi++LgLJvKr6IlUWvb81tTpZGpte4roYbIugGZF1mng2w3CFOTtCIdVHXnqcORwY9jZS3q5AOekyq6j9u/A/g70IgP5MY17hyI8aRAz3XyPhPeJLovc/bU1yvi7acF9SgxTMygJcVY/3zBfE1ZYMkY1AGuig0QACg7IKAIUgwF0qM32iTHhcL0PITCF8YJfF9OPMwhxD413hFerkbrDXtcLtYgkMyMINnWeqLNEVek4dQP3wvWnNvMsd6ynjY3zvFQFl9POzkjTt8SllSxF8PJJu5MnNzWJXaTwxSWJuMdBsNwAcYIqc1siNZ1twkp23AW8TyQXnKRoBYtbaUp2HTU3YdB5WoUHdoQF/I1n7n4tyQFpGhS7+2iNBgBev8Py+phi9bxXQS6qIyRlcpH74aJ0SJx5KjwavSb6LOUKWMcXmXxG9eveZsT5ReqvKxQqx6i3/lNF0W7h3TAs/fP7JIALA5eihX/f0tp8eOzv1Ov7DpHCU41ui4I5B9CVmg0ez/15Fc4HekcxCurXWJQ0JYInGMqTP2bzdCpiG8AyOIFO+Ew0B5gSd0EurMSmoHhxxnl6Sy/lfrZWEFkblDqFmOOwfzcoyp879m0Q6JpPb6IVAPLfzBb70hSmOv3i4ls6HtWNLKVZwO+OCoXhQ4Qm7RezifayC8NYUUBZnoEAk6ziM2iGxozKjRSm3jImYjyADPnuPkQCM4eMXnIcI6xWHquOLSMJIAK6h5Op9qTTOkjaJsysVjL45OzGgtPIn+cO0c1miIjwab1upkLaEO5ljGHBCnTaC/AFqSUwBHYscimpVET0oh9ft5aiq3H2iKhat
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(8936002)(6486002)(6916009)(186003)(4326008)(36756003)(6512007)(966005)(5660300002)(86362001)(6506007)(53546011)(83380400001)(8676002)(122000001)(2906002)(66946007)(316002)(38070700005)(71200400001)(38100700002)(66556008)(26005)(66446008)(64756008)(66476007)(508600001)(76116006)(54906003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h44f9YJZybkLdjX/SGPbM15HHx/nb83i1PvnYmOvaik3/DtHYyiH0DmXOs3w?=
 =?us-ascii?Q?LlPZtSk+lHWy889k4Qq6+jZQ7piFNY0csx+6ktuwpzDBpgngaBd2d7cubdyF?=
 =?us-ascii?Q?bBmS3s1BduQx9gT63DWyrcucNMBBTSM+KhixfB7uoh0PQQY1KjoZPlp0xD4y?=
 =?us-ascii?Q?zNju0KYp6/fS4ed6UBSTujPbTEy3anPdhhvvHBUmK8bkVgHNgXdXo3l3jD3n?=
 =?us-ascii?Q?6IvL6LS7YH6HsD5S3cpmBPIPaAb9vaerLbAr1BgVWVIO6d+/ixfzAFy/+5Ga?=
 =?us-ascii?Q?tbB8FaUG+ercij/ciLe+L1y+ta+ARCbALDk5I+PbMIUhD59AastI4JRBxIXc?=
 =?us-ascii?Q?RX5Qg53TqNfHoLiJrowr7qXquImDSRwd0leoEoqwHTmx3nMcjoyWpRfhc7g0?=
 =?us-ascii?Q?ldZkWIWmmHT+2cNnxIlWDhv6N2kywoDW/JFOQl73Bpoz8qQ2PYTv2UpBom0s?=
 =?us-ascii?Q?tJ4EDlB2U7x8F8h77wNIKs5Nb6LNc8JOeFJEsHXgVgFJ4Or2YS5oXcD/g7ES?=
 =?us-ascii?Q?f5vYNPkOVcMSnqOK/5FmS+ibFqQEi+lGa8pohm7wd6/pBKGcRaH7wIlDFmKv?=
 =?us-ascii?Q?c5fFKqzN/LdenSyRfYW6ahZU3TR35GfTCdIxqCpFqoC90gnD69p5O5/zGb0z?=
 =?us-ascii?Q?eN3HiCA4fTa8lAmrnmddpxjBflTUobt4tQSog17KkgO9pLoYyhg8je3QAMU4?=
 =?us-ascii?Q?VRjQ70Fx/LHuKjXCLvk/FLVwPPPfNcdkgvtOq76Ck80Cuj12cXUbqqa5GPu+?=
 =?us-ascii?Q?IX8M/snI2ubbO+62nHytHpGfGde3x4ypqNkLFJpPnEcm7A0XWGCXEX5huH+H?=
 =?us-ascii?Q?Ii/EDHvvdtkp1KGxASCzKFZopy0eyCVUVGZsJXVem8QV4C9EWQfbBql2yN1y?=
 =?us-ascii?Q?pMHkwKhbYe0xmzMwb6wzj6u9NEjx4MmRx+olGAmg+GqgFXA3V9NFahTIsfDC?=
 =?us-ascii?Q?qYAjkS6TbqRH/HAXdDb/C7ADXXWTr7ZaFkDO0ta209b6/K8945swfZRumsRC?=
 =?us-ascii?Q?tnYzbKcm04rCEhKLM1iPQibWEe1y6VTdXtp1RLcaVgtAoN4Mgu7FJuRoFFj6?=
 =?us-ascii?Q?u2p+V7JDOWoC5CkEf5UygFnxcJUkA+Dc290x9oeGOWOBglcyZYiFNjIJsij+?=
 =?us-ascii?Q?zxF8VheOzOHtOKiwKQu7v7ia31t3jEdIP2XyQRNa+3SoG4SCnw32V01NcCa0?=
 =?us-ascii?Q?5irhzRuDjwVm/ilzXhkLe57B0VYWJRerMrYE7WzX7HDZWptyEKWmNEOV7aMj?=
 =?us-ascii?Q?PnEhT0g9wAsGmIJsR/36vPcKCFpGblVSJHVOzsvmYXDMwXrw2jNrt9cAOLXl?=
 =?us-ascii?Q?i7agcs5cLjv6VdIvQ3y14oy3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D52ECF95EE8164883F62DA2A2BE0CB3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d604bc2f-2d3c-40fc-290f-08d993137863
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 15:16:48.1688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQLSNopbAd+Q8rTkdhjJDTbOs343690bs0jwxgDlJCB/EiWDYBx1NcEScozxj6RvKo4c4H2z/YdOntIXXhpBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190092
X-Proofpoint-GUID: wPXlZVzY3lGG6FCF1TsxmGF_yd3XvsbI
X-Proofpoint-ORIG-GUID: wPXlZVzY3lGG6FCF1TsxmGF_yd3XvsbI
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 18, 2021, at 6:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> Add a tracepoint to the CB_OFFLOAD operation.
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/callback_proc.c |  3 +++
> fs/nfs/nfs4trace.h     | 50 ++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 53 insertions(+)
>=20
> diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
> index ed9d580826f5..09c5b1cb3e07 100644
> --- a/fs/nfs/callback_proc.c
> +++ b/fs/nfs/callback_proc.c
> @@ -739,6 +739,9 @@ __be32 nfs4_callback_offload(void *data, void *dummy,
> 		kfree(copy);
> 	spin_unlock(&cps->clp->cl_lock);
>=20
> +	trace_nfs4_cb_offload(&args->coa_fh, &args->coa_stateid,
> +			args->wr_count, args->error,
> +			args->wr_writeverf.committed);
> 	return 0;
> }
> #endif /* CONFIG_NFS_V4_2 */
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index cc6537a20ebe..33f52d486528 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -2714,6 +2714,56 @@ TRACE_EVENT(nfs4_clone,
> 		)
> );
>=20
> +#define show_write_mode(how)			\
> +        __print_symbolic(how,			\
> +                { NFS_UNSTABLE, "UNSTABLE" },	\
> +                { NFS_DATA_SYNC, "DATA_SYNC" },	\
> +		{ NFS_FILE_SYNC, "FILE_SYNC"})

Is there no way to reuse fs/nfs/nfstrace.h::nfs_show_stable() ?

Btw, I have patches that move some NFS trace infrastructure
into include/trace/events so that it can be shared between the
NFS client and server trace subsystems. They might be useful
here too.

The generic FS macros are moved in this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Dn=
fsd-more-tracepoints&id=3D495731e1332c7e26af1e04a88eb65e3c08dfbf53

Some NFS macros are moved in this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=3Dn=
fsd-more-tracepoints&id=3D24763f8889e0a18a8d06ddcd05bac06a7d043515

Additional macros are introduced later in that same branch.

I don't have any opinion about whether these should be
applied before your patches or after them.


> +
> +TRACE_EVENT(nfs4_cb_offload,
> +		TP_PROTO(
> +			const struct nfs_fh *cb_fh,
> +			const nfs4_stateid *cb_stateid,
> +			uint64_t cb_count,
> +			int cb_error,
> +			int cb_how_stable
> +		),
> +
> +		TP_ARGS(cb_fh, cb_stateid, cb_count, cb_error,
> +			cb_how_stable),
> +
> +		TP_STRUCT__entry(
> +			__field(unsigned long, error)
> +			__field(u32, fhandle)
> +			__field(loff_t, cb_count)
> +			__field(int, cb_how)
> +			__field(int, cb_stateid_seq)
> +			__field(u32, cb_stateid_hash)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->error =3D cb_error < 0 ? -cb_error : 0;
> +			__entry->fhandle =3D nfs_fhandle_hash(cb_fh);
> +			__entry->cb_stateid_seq =3D
> +				be32_to_cpu(cb_stateid->seqid);
> +			__entry->cb_stateid_hash =3D
> +				nfs_stateid_hash(cb_stateid);
> +			__entry->cb_count =3D cb_count;
> +			__entry->cb_how =3D cb_how_stable;
> +		),
> +
> +		TP_printk(
> +			"error=3D%ld (%s) fhandle=3D0x%08x cb_stateid=3D%d:0x%08x "
> +			"cb_count=3D%llu cb_how=3D%s",
> +			-__entry->error,
> +			show_nfsv4_errors(__entry->error),
> +			__entry->fhandle,
> +			__entry->cb_stateid_seq, __entry->cb_stateid_hash,
> +			__entry->cb_count,
> +			show_write_mode(__entry->cb_how)
> +		)
> +);
> +
> #endif /* CONFIG_NFS_V4_1 */
>=20
> #endif /* _TRACE_NFS4_H */
> --=20
> 2.27.0
>=20

--
Chuck Lever



