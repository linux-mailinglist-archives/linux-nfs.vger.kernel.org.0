Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B657936A271
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Apr 2021 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhDXRwm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 24 Apr 2021 13:52:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29976 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231307AbhDXRwl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 24 Apr 2021 13:52:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13OHq1F3008160;
        Sat, 24 Apr 2021 17:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dOoWhPlSwBqC8nIll67kq3uvtYlpqg4oT34/nRzkiMs=;
 b=BMKQ7nfN6UrgcY7NBabojtFyX+b4fBXYSkcyGnemsee+exWBnp/X2fqCcrfryUpSIRQI
 nXBl7QVdA5vdMkCmW1WAPv2eMSvp/3vtSkjGhno8Wanq0HuoQ+FsBWGLZr4A2rmgdgbx
 tZiSkyCpo40LgNE2lR/gDXpAeIa/GOsxhmhIFaG95XEiF/k5dtG75CsLHtNxa82HKQ7H
 BZtIIU0WGZV4UVCaEYscoU2ZfQTvZxjaCxMQ95wX1SxN3+55b0tRal5pVbGqmbGbnm/W
 RzBAC9Y+G3q/BWr3auzWwUYYe9y2DoY6Pb0ttvdopUXKc8SaHlLLPNLatz0NwLbOiaN9 Bg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 384a41g5xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 17:52:01 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13OHq0vV158993;
        Sat, 24 Apr 2021 17:52:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3848eswq72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 17:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfOvLqP+mDDkQbna/YqIkG/0XAUyyaYdxd3wlPhogwqmg8H5h/LOlk77MS00WtgpRk+9K+zSm/AlLnsRc+yb1svviRPPutiZRXdWAP7D3Jm4/UgdtnDD0uDor9jNVCgeE24U8A7ZG5NuIq0KyfOVcM5MhOTXJ6C9tqheNtWRRLUFHazwalhawSdhUk0wdWV5WesTy7cUpcsXogBJHHxoql6goyz9PbzyknJzK2rid+cCbYAlMQU8iwmYRCDZ94RMIxEEAx7ZHd0uWl0J4jCnFJXBDacrWgOtwrhIt+byApxp+ifzBrXLHe3x+evcDE0FD//PeUukEDuAzcNns48Kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOoWhPlSwBqC8nIll67kq3uvtYlpqg4oT34/nRzkiMs=;
 b=esOQmMrcjkK54Pn2o0oJz+FLovfD7te/Gm0nityk3xSvFynAZPth9N34D84dz6WOVj6daA2Oz3OjmlKZ9AynLlJhZKkUhhSZ/4C1QE/x8q64e4P2rPfZvBpyVkOQHOMA0rm80GDpaIe1ypDsoVdVe/UA3VEiZrScRifdi4RbdVGcvaNo2y4s9MMDRjMJQpeNwTZ2IGU9ZGt2lhonCIx3UaeQh97n39I00iqaggklkzwEfyEx9aROs6dZlLT0Mc1n1MARxm1qFd4yxFMeGC3r/GEDgvNYUKUmOSUPxc9SrGE/HOOU7c+WeXSrSMesIMBELsJ0mv0CaPtYAnyGhAuAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOoWhPlSwBqC8nIll67kq3uvtYlpqg4oT34/nRzkiMs=;
 b=hWdP9qOcm5nzIKAi52qCpWlNhM14FlpsDkm6AXki5T1OWLeJNY+ULQ2+DkibJWoJRbUxBTsi6DnokLDcCronF9r3EG0pPtlBNjZbVtZkS4ypP4xOoWJvjUUSu556dCqQDFm9H2UEglqBXX7CyiOiD+MLLZhvEz4P4ipENTNG84Y=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sat, 24 Apr
 2021 17:51:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4065.025; Sat, 24 Apr 2021
 17:51:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC v2 1/1] NFSD add vfs_fsync after async copy is done
Thread-Topic: [RFC v2 1/1] NFSD add vfs_fsync after async copy is done
Thread-Index: AQHXN7YtqW0CeNWCGUK0Bb6AbDOzCKrD9ZqA
Date:   Sat, 24 Apr 2021 17:51:56 +0000
Message-ID: <A38B105D-D6DF-43CE-A9D9-C97B98E3B967@oracle.com>
References: <20210422202908.60995-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20210422202908.60995-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1d0e3ef-c343-4a09-652a-08d90749a709
x-ms-traffictypediagnostic: BY5PR10MB4388:
x-microsoft-antispam-prvs: <BY5PR10MB4388C8C5D3BDCC2C7D48EC7093449@BY5PR10MB4388.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EAAU+eHfdP0D6LsqaVy06q6et6sOVu4ezMjskjFOdX0F3ac8ufyPwdIjh7Rh0pp9Er9g2ymDihlu6rPZiJDsm633HDYxFLQd1rEV86+ExiykaFuCaCYhWqzJx4F8/5lda6Brc8F9eW/gFHI8VlPi+Q5TRGSWMvbH+dECwa0H+6jjQ2V9QOfKZtgHp4MGC9qcXxIDTjl9WP7d15Z5TEJCsqJQkxK+9mjzg/StarKf0y+g+YLHxMXViiUBhetYAXYOj9P3TtRhlzFBmUf3vnZJ8+mKYcYbbmv0XJOEskpLmnBJqNWZL7JGj6bxoNRwCyIlqiDIWPNyjqloKEPCL0AOfpLP5Xu4lOH0kowOOlZU7doFTPbC0Y3BxLEWWhNpkGSuCRXRLjZt3qEe/sHhvBr1KJX3OnUaZqtzYfpa3IFDIQeJ7xFSZuU0NF4ERN3F6Tv7Q0hy+kZHDgEQkn46Ez7EkWf0N1NtEPHqsd/aE4Ga50DU27sgXHQS28v88QW3g95T/64bv7J+4mYKshU4rPterRzVOFu5FxLx5mq2Fv+VYpqN89TC6cl9iufsk7qWK1S94t9H4qZVbxcJm4Ui+5uURvj9x12v1wq4KYDtpDD96sii/LILbLa6tQsyFSng5AgHmxenWImSm+PRm8xGbIlMpC8u1RXbnZhGT8zJ4xy5Sd0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(346002)(396003)(71200400001)(36756003)(33656002)(4326008)(478600001)(83380400001)(2906002)(5660300002)(6916009)(76116006)(186003)(2616005)(26005)(6512007)(66446008)(91956017)(86362001)(6506007)(6486002)(64756008)(122000001)(66476007)(8936002)(54906003)(66946007)(8676002)(38100700002)(66556008)(316002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4QsED/PPVrQ0o07Y/9nVRn+NUTce+Sb1J/wfbnmc6jjXly4w/C/rmtAum1QA?=
 =?us-ascii?Q?xYYy3MgUDnGwkYJ5e1+hzl+OVtc7BipHZkLzR1S9gV35TsxGgFq7a8LkVFxY?=
 =?us-ascii?Q?RAHJnMjAdTmUAgzVci6YhtZVKh+30kakM/yk/Qgj/b3Ovxo4rWqUNDbn4Hjz?=
 =?us-ascii?Q?MlGftpkX1NsydHog/2mVCTFpYPnawhaCfPZOhW2sLk6wL3I4LND1DsECHJKx?=
 =?us-ascii?Q?EALvxLB+V2IBsdtla7Y4zFYDl6rBxCb7YA1gfhnqXVG92h7Xwp1RB+9ZoieI?=
 =?us-ascii?Q?eawuXjiGD7wh3BSqdso1oELgAuyTu2ZEXConwck4PQubOGtpN/+eRAOClqZD?=
 =?us-ascii?Q?X9dl8rqDWV13Tgib5gEuISGmBk82FPb02kx1fJbuxdKHRgOrmrqVrusP/xrL?=
 =?us-ascii?Q?xzTxcmOrIgZXOQpmgmqYRQqnXWrqcOIfNY+7rRBSZF4lRhsUnHpvlyHObyxB?=
 =?us-ascii?Q?RQht5wGIvxPO2nb0/EkF8fNCtrSF/kIJZNGsYx0nrXsdJ0qyVBEG7E8O2Egq?=
 =?us-ascii?Q?RZRINj1UhwbO8NOesPy9R6aWRwEtWdGdUYX3lAHBYlP8wtLRl2x5emtq0syI?=
 =?us-ascii?Q?7M/I6VRwRBkNLd5J3R4dDIiq6G1SvWBeLoD5cYn/IW9Rb6GK474u2bqLR1JP?=
 =?us-ascii?Q?vatcMyE77+dpIxcCR/p0ASxIgDnJLYzImeIHFKyAfDH8KAWNIgDUZTX/+lcm?=
 =?us-ascii?Q?rMsV21kkgSVqi1d2+BpWj0xuvH2COtG+fPw31YUu7nXCgp4uCUCaPk4UrFwt?=
 =?us-ascii?Q?WrQ81u+EvfFoWHcsXNVISUojq7ZwANBrNW9/75cG7bgyurE3hOdNM24L4YiJ?=
 =?us-ascii?Q?ZBi8C6OVdRcHnXslEWQVQJS15jixwZ9qxZ5Cc9aYV1ggAFqv1//q1oIAqhXT?=
 =?us-ascii?Q?oSkkOzLBruAv9CKP2yHpl8beOFtRWqz0ECN07tD4rRNL07Lb+7X7eRJ/LkUz?=
 =?us-ascii?Q?EcDF2sunIrX9pz/GauogvoaxzotfykPBQRwMDvdpzSWJ8pnPO8WfdAIYbBOn?=
 =?us-ascii?Q?EH5gcYkAppfpXpCZaXOC+6sxfBbV/vA8OS5qkBAydztQUp1CN4DPnFO1o2/K?=
 =?us-ascii?Q?ESkA89ucHCwgn3Nm0OqXhYJeGifIhyQzYtD7+UN3EFkTzFWuYdcKJmOqPRlo?=
 =?us-ascii?Q?qM+h8XJR6z1HZQuLxya711C1c6rI4vPDdjEEi6683T3rgUa5Rc9M7ECvIEOv?=
 =?us-ascii?Q?darTTIGegEU7FR1PZwp0v8NfXEMoU73njixABZiguPF8vMBzAUlWlLa1vsI6?=
 =?us-ascii?Q?4rKpmhfo19dPAO0qJozT9fZTh0sgWyUsXiIFB9/l7KBmWWqalE465I3z95Ih?=
 =?us-ascii?Q?ZCBdULcEbSWTFWjULNmZr3IT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFFDC97E4665AB4A97C93E51DBD226E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d0e3ef-c343-4a09-652a-08d90749a709
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2021 17:51:56.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65GZ0onEOpEKPZrzcSgZFcs5rTTZKoagPDD8bsJpEzRYHwLb7ep99cxYUHAP7l9Sheug+Q4cb0KWp+NTHwp23w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104240135
X-Proofpoint-GUID: 9FMacIvLPmRW6erc_gLiGBdKVH8-e67_
X-Proofpoint-ORIG-GUID: 9FMacIvLPmRW6erc_gLiGBdKVH8-e67_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga-

> On Apr 22, 2021, at 4:29 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> Currently, the server does all copies as NFS_UNSTABLE. For synchronous
> copies linux client will append a COMMIT to the COPY compound but for
> async copies it does not (because COMMIT needs to be done after all
> bytes are copied and not as a reply to the COPY operation).
>=20
> However, in order to save the client doing a COMMIT as a separate
> rpc, the server can reply back with NFS_FILE_SYNC copy. This patch
> proposed to add vfs_fsync() call at the end of the async copy.

I'm having trouble understanding the description. Are you saying
the client does a COPY then a COMMIT, or that the source server
is doing WRITEs and then a COMMIT? Just suggesting a little more
clarity (or an ASCII diagram) might help the weary reviewer.


> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> fs/nfsd/nfs4proc.c | 23 ++++++++++++++++++-----
> 1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 66dea2f1eed8..f63a2cb14a5e 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1536,19 +1536,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_o=
ffload_ops =3D {
> 	.done =3D nfsd4_cb_offload_done
> };
>=20
> -static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
> +static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync,
> +				bool committed)
> {
> -	copy->cp_res.wr_stable_how =3D NFS_UNSTABLE;
> +	copy->cp_res.wr_stable_how =3D committed ? NFS_FILE_SYNC : NFS_UNSTABLE=
;
> 	copy->cp_synchronous =3D sync;
> 	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
> }
>=20
> -static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> +static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy, bool *comm=
itted)

Nit: Instead of adding an output parameter, would it make sense
to add the boolean to struct nfsd4_copy?


> {
> 	ssize_t bytes_copied =3D 0;
> 	size_t bytes_total =3D copy->cp_count;
> 	u64 src_pos =3D copy->cp_src_pos;
> 	u64 dst_pos =3D copy->cp_dst_pos;
> +	__be32 status;
>=20
> 	do {
> 		if (kthread_should_stop())
> @@ -1563,6 +1565,16 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_=
copy *copy)
> 		src_pos +=3D bytes_copied;
> 		dst_pos +=3D bytes_copied;
> 	} while (bytes_total > 0 && !copy->cp_synchronous);
> +	/* for a non-zero asynchronous copy do a commit of data */
> +	if (!copy->cp_synchronous && copy->cp_res.wr_bytes_written > 0) {
> +		down_write(&copy->nf_dst->nf_rwsem);
> +		status =3D vfs_fsync_range(copy->nf_dst->nf_file,
> +					 copy->cp_dst_pos,
> +					 copy->cp_res.wr_bytes_written, 0);
> +		up_write(&copy->nf_dst->nf_rwsem);
> +		if (!status)
> +			*committed =3D true;
> +	}
> 	return bytes_copied;
> }
>=20
> @@ -1570,15 +1582,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *co=
py, bool sync)
> {
> 	__be32 status;
> 	ssize_t bytes;
> +	bool committed =3D false;
>=20
> -	bytes =3D _nfsd_copy_file_range(copy);
> +	bytes =3D _nfsd_copy_file_range(copy, &committed);
> 	/* for async copy, we ignore the error, client can always retry
> 	 * to get the error
> 	 */
> 	if (bytes < 0 && !copy->cp_res.wr_bytes_written)
> 		status =3D nfserrno(bytes);
> 	else {
> -		nfsd4_init_copy_res(copy, sync);
> +		nfsd4_init_copy_res(copy, sync, committed);
> 		status =3D nfs_ok;
> 	}
>=20
> --=20
> 2.27.0
>=20

--
Chuck Lever



