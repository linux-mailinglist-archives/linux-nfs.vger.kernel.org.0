Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0858C433A71
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhJSPdg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 11:33:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36604 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhJSPdf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 11:33:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JFIS4B010377;
        Tue, 19 Oct 2021 15:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nQODX4L4QKK8lddM+jRd53XaGSUsu4kuVtWnIYa3wlw=;
 b=RWXsPmilR4+f23Zv9E59mp2OitfMtsVIhrQtWo8Vc+RqAEk4gwcM2NHut+SAt2xHQF+C
 ljEqRhzQbfWj4VS55Ubqihj3gGgVMTW93xlEo82meB05cX6h7fLeOkuZDC2WipDYshWZ
 lm+O+mPk7S0azU1IpI6tjzYTd+lsKukKjQfOXsNfip7uDcf46tYtl57JdWDA9Z04DkJO
 7jo3yIY1I5cuKDLJtqtaCCiIHY+2o8YajgdpSfp9Yot6SXS263fN2cN2IGkvEqhCCZDY
 /7hCGSDp19P9Lcqvzqf1TTqCx+dz4Ayz4+Y852jgk6qssoix+LosC8dyLHHehrTj9oFY Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsr4539kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 15:31:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JFFCtK089687;
        Tue, 19 Oct 2021 15:31:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3bqpj5mc6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 15:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1yEag/QLWDjD6VwPjUzxZtmC7ldpLm9Z+NVbpDQz8CXx6LJbPd6mn61rPv16jNb3GNL0MOj+6CvrEcI8jrAI/0Fwl8h04MQYXhaR89k15TwhLIG0UsmeP8RPG3UkHJQnezbke6o7D5IkD6YnXa4zUH1J1g85R89npsYbsbpucPcBpha9GFbe952F+RPHNf7fjWdvs1g3PGEx9kQxts5dVIgPCi/bGLuiy+FTzte2nNDqDn8yjJTgF63ZpThanWbSY6Go7shv7LssmduAGHHGo1IcWqSI5lfYD4MsGT2J0qdwtywDZqgbI9xAbZqjbqqO1H8UE73NhneoxMuCzZXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQODX4L4QKK8lddM+jRd53XaGSUsu4kuVtWnIYa3wlw=;
 b=JEJAGQK5dLFrDmMrPJP5TixkMzXHOjMcG8FlNGxzLq6MgTUukvLsII9ndTXFsNUY3Im7/gGudFkWcIndLQL5GT1vmlVfbbvNLKvCRlQ9cqTAKcqxLduJWkktpfZ6iDnAFylts4JBJ9nLQduygYKfVtUZmbkX+m067jHEI8yklnJYWhqUCKWPtYy9XHsKP2U7MuX1rJG2g2180mmLGPMnywnMydxi/JkDMbdVITjGe099Cu/zOSDU2nZZCeMLWhdeSvHwffrKxxwqKGwG8EZMNJpV/IkfRQIih6M9W63z4wWsXVDBK0pbcgUISyjAOWTtfAslmsGveFL9D7GG6UPdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQODX4L4QKK8lddM+jRd53XaGSUsu4kuVtWnIYa3wlw=;
 b=cGQcFtQafGjS7tad1gA5uOfuvRFdMJ71/amyhXJB3yz5u7wOn24W4T7K3X7DksQABofX0L34xzmsf+9J1Tl5n4rSbV/BMBgi9EepGj7RcoMhiYegZ3odNqAPhL37ElqFTUogF/qXyB+vC/5ucuQEF5mecy42x9ip4GDGAygri3k=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4275.namprd10.prod.outlook.com (2603:10b6:a03:210::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 15:31:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 15:31:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/7] NFSv4.2 add tracepoint to COPY
Thread-Topic: [PATCH 3/7] NFSv4.2 add tracepoint to COPY
Thread-Index: AQHXxGwEbncX/JTLN0G2I/WdYzvASavac9kA
Date:   Tue, 19 Oct 2021 15:31:13 +0000
Message-ID: <7C2CC1B3-732D-43B4-82CE-932DF82DD14B@oracle.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
 <20211018220314.85115-4-olga.kornievskaia@gmail.com>
In-Reply-To: <20211018220314.85115-4-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c13916f7-a32b-4e52-104d-08d993157c14
x-ms-traffictypediagnostic: BY5PR10MB4275:
x-microsoft-antispam-prvs: <BY5PR10MB42753A56843006D8C5C1CBCA93BD9@BY5PR10MB4275.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJ9NRyTLSPs/zoeHFk7O2ME5smZ+8kZ+jw8r4RfRhTHUjMkOqK1gyZy9zq61pwugxJaOX7A/rh9KtoXQ56ibvjiK8pw0ElZArvWL1jcr5E/CdRwmI0NivBbsGunLpXWRYa9ZII2InaSzyivCxPBKYi1WPLja3mWKmX7QCpVzFA/8SAluFF+Ut0qm0HN7N4MsKy9ArSeKPXQL7tJPZbs+k96fdlVPfo1Aju6hpClS7Gem5933FjQZa/ty3Xj3CkcYHh57wXDTetCf1wrJ4wLhdCktO/laqQIk6UqpjJemP+uINNrpkJHyG3w0OWKkRy1FsZqESfymJOiqCpl5ThAAnjlTjBGeT/mA8DRfwi3O50GNsnYv+A30ER1SkBykRsI3LMLhzwpij7hH7kGdGW4eoHPVxWc9IfiuHwn/Jj0ItkQhrov3v9dzJDefUT3QuIDIE7d5BmyNzuiP2CUSlwYdHlV+nuUoHi0uI08DWRaCn9xKmiFnMcg+EWHId+nZPDarfzGP6nvuct+yjXIJt53YaB7aTdZjBrq4oYjbxjFlwB2vsXbv9CjMQxu1qm00UgC9i+vHd/YnO2rUVXz1oIHhBw/ZVqwoHfKTjB7sOF9I2lYAA/PISEHezLR6zVxkxSwoANP+0CegxGloj0XXT6DNZhn+Mz3og++gxzT+jMuuvhJL+acR0CHheGyO3FOoBr0s5pOqQO1x+9P17bNtrSCHoede/4C2qtU2hYIRCs6Cgdyx+GghLMPYgGErNYpXj/BM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(76116006)(6916009)(91956017)(83380400001)(6486002)(38070700005)(36756003)(508600001)(64756008)(33656002)(8676002)(53546011)(6506007)(71200400001)(122000001)(5660300002)(186003)(38100700002)(26005)(66476007)(66556008)(316002)(2906002)(2616005)(6512007)(66446008)(8936002)(86362001)(4326008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Av5HlkIOKL5SsP7LdVtpAXqJTK7+yN6qm7I5Qm5SXC0c77QwIibloiC40KS1?=
 =?us-ascii?Q?gXU8IJbqu8gqAvKn1GQ8CYEfLnfeK4P6zSdMnSUmDca13tWyIqEpsVWl5G8T?=
 =?us-ascii?Q?9Pu0ygI2iDmpe4bzpubH9ZYn4OsW1tRRJwdctWX/5C19b8NtKSpbnCsKkftw?=
 =?us-ascii?Q?j+hKlHC1yXfWJUeEAQbD+vqoqp/JCmr94rgbLpFyZGdmTfkYGAeZEMEE7Jx7?=
 =?us-ascii?Q?mttO5eU6xEhALn9eqxLdyrqvfsy15FPrv9hqIRot8PxXrUdXZc4tU8Nwd+4f?=
 =?us-ascii?Q?eA/xwiqy7OxxAlskpymXTEwNTPqAjPSKx0jRPkLpGwPC1HoyEPgwqdj3KZMQ?=
 =?us-ascii?Q?Kse+7k60HSjbh8yw1kp3o/O5O3qkFdjtC54C/yCrq0VrpvhfTx8T9gmexmCL?=
 =?us-ascii?Q?Ql9tNJBGG8VFhwNpsgv/h0e8aQz/8b1O5a7Fw6DNYqx5LskZPOmgFEBYC80L?=
 =?us-ascii?Q?LWxOqwGFMPsL+Afs/loa4mfRqWqcoplnW0VD4YKwsOdL2WdhyK5jx/uRYIEY?=
 =?us-ascii?Q?zmkblSzQ/dZR2HfYO8+k36zeUMr9arMECt6c0ok+qPjSYVP7O8o7hbHyCr/U?=
 =?us-ascii?Q?QUoPc7Ab6KSBi2zSHprKJmdDBIH71jUAgJs7VOlmZUMtpXUChuaKM+d121zA?=
 =?us-ascii?Q?Bv8x6XUbG2kuT3vxHcY5ul9kw87IAvDXMInc5RCTXpDGSi/ihFe5Ltqc4QK3?=
 =?us-ascii?Q?EVRcmMEnuSzOK23wyW8TzTxT4l3BojBIS7Hh2IPOzL2JceQw/oLgEGZFHWp4?=
 =?us-ascii?Q?aGmvVToTVDMPXAA9Hjx3y1Cqv3/sBZ6zCwKo4XQY8yToZoUO2uHCQQQIYj7/?=
 =?us-ascii?Q?Z9HHnEhZSlNLQCFCPtPJBxQD4Dhy0nFJoTeP2p+apvWhwFBl1CoY0dWCjbmk?=
 =?us-ascii?Q?3EgotAPyAKTsWX0no3BGhhSemf65UY5w0NI11cs6kFpFeWhqwKf3qzTVb9MQ?=
 =?us-ascii?Q?CdM3n7xxcKjGEQ82y3oaoVctGPDymslRjdcyHNEB+RHUnSV9cq0j5GWA3bsr?=
 =?us-ascii?Q?tS89OnD9WqLhk6+btkLhdWzqSvvnD6b8icZXUf5khhBSVPg86yYGT4cju+5g?=
 =?us-ascii?Q?RQvlhsieH5djKS8YHZ0Ctodo0BRcoA3jmlZbuB6KQaA0qTsgxvK52A2fq5FL?=
 =?us-ascii?Q?d18AsgJTbqH2ZXg14tpqkCDAxNeYso/YYmulQM2M3c1hpbQ7x405Cm7ulu2G?=
 =?us-ascii?Q?pvDHeOQ5FZEmE0DCoq2Vit6quIO/RlnzruFG/X5dPNe/gK1pW744yA6Xwa3h?=
 =?us-ascii?Q?yForC4Xdq59ObZK619Jz2zaZHeS8HrPXtVL0CMCc29iPJ7+lGFAswfJB29QD?=
 =?us-ascii?Q?QFjixYYcrnTsixs/L6lEp6nL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <993EED27EC9CF7498A951AC82C80819D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13916f7-a32b-4e52-104d-08d993157c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 15:31:13.4045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjVgSBvCREX5beY0B8bOBPUyY97jdK/jsfIlh6wMyqgucqG4gY30f89yiri2/Cae4L11WEUNmJGAroKvirbsMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4275
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190092
X-Proofpoint-ORIG-GUID: bHvnbIO8r9hQMF4upVHRpTDoCXxr249U
X-Proofpoint-GUID: bHvnbIO8r9hQMF4upVHRpTDoCXxr249U
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 18, 2021, at 6:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> Add a tracepoint to the COPY operation.
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfs/nfs42proc.c |   1 +
> fs/nfs/nfs4trace.h | 101 +++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 102 insertions(+)
>=20
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index c36824888601..a072cdaf7bdc 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -367,6 +367,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>=20
> 	status =3D nfs4_call_sync(dst_server->client, dst_server, &msg,
> 				&args->seq_args, &res->seq_res, 0);
> +	trace_nfs4_copy(src_inode, dst_inode, args, res, nss, status);

There seems to be a lot of logic in _nfs42_proc_copy() that
happens after this tracepoint. Are you sure this is the
best placement, or do you want to capture failures that
might happen in the subsequent logic?


> 	if (status =3D=3D -ENOTSUPP)
> 		dst_server->caps &=3D ~NFS_CAP_COPY;
> 	if (status)
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index ba338ee4a82b..4beb59d78ff3 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -2540,6 +2540,107 @@ DECLARE_EVENT_CLASS(nfs4_sparse_event,
> DEFINE_NFS4_SPARSE_EVENT(nfs4_fallocate);
> DEFINE_NFS4_SPARSE_EVENT(nfs4_deallocate);
>=20
> +TRACE_EVENT(nfs4_copy,
> +		TP_PROTO(
> +			const struct inode *src_inode,
> +			const struct inode *dst_inode,
> +			const struct nfs42_copy_args *args,
> +			const struct nfs42_copy_res *res,
> +			const struct nl4_server *nss,
> +			int error
> +		),
> +
> +		TP_ARGS(src_inode, dst_inode, args, res, nss, error),
> +
> +		TP_STRUCT__entry(
> +			__field(unsigned long, error)
> +			__field(u32, src_fhandle)
> +			__field(u32, src_fileid)
> +			__field(u32, dst_fhandle)
> +			__field(u32, dst_fileid)
> +			__field(dev_t, src_dev)
> +			__field(dev_t, dst_dev)
> +			__field(int, src_stateid_seq)
> +			__field(u32, src_stateid_hash)
> +			__field(int, dst_stateid_seq)
> +			__field(u32, dst_stateid_hash)
> +			__field(loff_t, src_offset)
> +			__field(loff_t, dst_offset)
> +			__field(bool, sync)
> +			__field(loff_t, len)
> +			__field(int, res_stateid_seq)
> +			__field(u32, res_stateid_hash)
> +			__field(loff_t, res_count)
> +			__field(bool, res_sync)
> +			__field(bool, res_cons)
> +			__field(bool, intra)
> +		),
> +
> +		TP_fast_assign(
> +			const struct nfs_inode *src_nfsi =3D NFS_I(src_inode);
> +			const struct nfs_inode *dst_nfsi =3D NFS_I(dst_inode);
> +
> +			__entry->src_fileid =3D src_nfsi->fileid;
> +			__entry->src_dev =3D src_inode->i_sb->s_dev;
> +			__entry->src_fhandle =3D nfs_fhandle_hash(args->src_fh);
> +			__entry->src_offset =3D args->src_pos;
> +			__entry->dst_fileid =3D dst_nfsi->fileid;
> +			__entry->dst_dev =3D dst_inode->i_sb->s_dev;
> +			__entry->dst_fhandle =3D nfs_fhandle_hash(args->dst_fh);
> +			__entry->dst_offset =3D args->dst_pos;
> +			__entry->len =3D args->count;
> +			__entry->sync =3D args->sync;
> +			__entry->error =3D error < 0 ? -error : 0;
> +			__entry->src_stateid_seq =3D
> +				be32_to_cpu(args->src_stateid.seqid);
> +			__entry->src_stateid_hash =3D
> +				nfs_stateid_hash(&args->src_stateid);
> +			__entry->dst_stateid_seq =3D
> +				be32_to_cpu(args->dst_stateid.seqid);
> +			__entry->dst_stateid_hash =3D
> +				nfs_stateid_hash(&args->dst_stateid);
> +			__entry->res_stateid_seq =3D error < 0 ? 0 :
> +				be32_to_cpu(res->write_res.stateid.seqid);
> +			__entry->res_stateid_hash =3D error < 0 ? 0 :
> +				nfs_stateid_hash(&res->write_res.stateid);
> +			__entry->res_count =3D error < 0 ? 0 :
> +				res->write_res.count;
> +			__entry->res_sync =3D error < 0 ? 0 :
> +				res->synchronous;
> +			__entry->res_cons =3D error < 0 ? 0 :
> +				res->consecutive;
> +			__entry->intra =3D nss ? 0 : 1;
> +		),

I have some general comments about the ternaries here
and in some of the other patches.

At the very least you should instead have a single check:

	if (error) {
		/* record all the error values */
	} else {
		/* record zeroes */
	}

Although, I recommend a different approach entirely,
and that is to to have /two/ trace points: one for
the success case and one for the error case. That
way the error case can be enabled persistently, as
appropriate, and the success case can be used for
general debugging, which ought to be rare once the
code is working well and we have good error reporting
in user space.

In some instances (maybe not here in copy), the
success tracepoint is completely unnecessary for
everyday operation and can be omitted.

What's your thought about that?


> +
> +		TP_printk(
> +			"error=3D%ld (%s) intra=3D%d src_fileid=3D%02x:%02x:%llu "
> +			"src_fhandle=3D0x%08x dst_fileid=3D%02x:%02x:%llu "
> +			"dst_fhandle=3D0x%08x src_stateid=3D%d:0x%08x "
> +			"dst_stateid=3D%d:0x%08x src_offset=3D%llu dst_offset=3D%llu "
> +			"len=3D%llu sync=3D%d cb_stateid=3D%d:0x%08x res_sync=3D%d "
> +			"res_cons=3D%d res_count=3D%llu",
> +			-__entry->error,
> +			show_nfsv4_errors(__entry->error),
> +			__entry->intra,
> +			MAJOR(__entry->src_dev), MINOR(__entry->src_dev),
> +			(unsigned long long)__entry->src_fileid,
> +			__entry->src_fhandle,
> +			MAJOR(__entry->dst_dev), MINOR(__entry->dst_dev),
> +			(unsigned long long)__entry->dst_fileid,
> +			__entry->dst_fhandle,
> +			__entry->src_stateid_seq, __entry->src_stateid_hash,
> +			__entry->dst_stateid_seq, __entry->dst_stateid_hash,
> +			__entry->src_offset,
> +			__entry->dst_offset,
> +			__entry->len,
> +			__entry->sync,
> +			__entry->res_stateid_seq, __entry->res_stateid_hash,
> +			__entry->res_sync,
> +			__entry->res_cons,
> +			__entry->res_count
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



