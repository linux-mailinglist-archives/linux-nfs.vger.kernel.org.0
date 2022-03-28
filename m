Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1C4E9923
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Mar 2022 16:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbiC1OQN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Mar 2022 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiC1OQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Mar 2022 10:16:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E08237FF;
        Mon, 28 Mar 2022 07:14:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SCu7Qq031710;
        Mon, 28 Mar 2022 14:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4DXRiPpW+4DbF31vRxg0STlgbjb+HaJSC9qE2YriaHE=;
 b=L2LJumKTNafrQYsP71uJamw3hmVb7aRacgsf/7JzhN/ID/A8IbdbupgvR/I0EZkOMCTP
 4hdbNRn4hr7Q1+j0s+W6IcF/70Yd1Y0ZhyUYadOkP3CnGVjF6htyobttT9W+RtmiTwwH
 /5baa52k7WjjPKUrXXxkaBq+ptO4BfKKiRc0iL6WQBR6G2LnDFwYVxwIMtu/e3rgNC+M
 +yzArqu+pnw51zFNruQw098NMqSPzFYjM20WqVK+GACBrZR6TVdLCYgsLCPZP+ea8prT
 VEaylkQqkXuBp9JGQruOYO6Eryb2T6FfvSGM9ebDtC1hn5srd+GmRooobLOLnqYdDDP/ IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1terum9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:14:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22SE5vZB070477;
        Mon, 28 Mar 2022 14:14:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3f1qxqbmgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxdHaXG6SjXh4xfnWIvyEKm8CWNOnm5DfcbuJhvwb9449USwHDJxy8U/O0EK+SrnMutDOM481ISFvAt8L6EmXKYDGd8HNdz9386bZf/WE7i0Ldt69y6GmdJ873aiiICfbVMLYndATRgG5rl97BHI+NmgfiNT8kxXokNP4B9ytbpM6gSZFZ+8qfNK3RnYQrt526T8fhIfuk1EphqshG5z1/aBTAQWOuUu7+VZHH1KTXkk9Ct0Eu4kspoPB3M/KZjOZnW4CYbDMgebVKAy2n4Nvcg86VOmTbmRGS6SjN+oUAMMrwF2qAvftnCiP5TzwcP13eBzKo84yV+sANMfNZIfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DXRiPpW+4DbF31vRxg0STlgbjb+HaJSC9qE2YriaHE=;
 b=jivhwR5mR392LWc7CvDFN6VSd81Mb9T5q5guCSpdzuaSsTpRH5QXFLe2BC1faWgrGG6yp2zuID+Z3mVOCNzWtWo+y276GB5zgOn2ggbkOcKGI67ORrTNJvcMU+rQH0cien1yDIa7QEszEwqC+WPu+BD48Gi6jkKFIVnPcZ0NTq4EInPlDdK+eT2wS4/NWol+2jRS+ZUVZRC5Oeq+1xTrNffCq0qVcNdIqnvlfLMGBVhI1dsVsyA55uqs2CQnh1+X8TEfPIgiMEeXzFNmQvRBryvrBpv1X5ck+EyF20AO9eBaYQfkhPW6YvyG+5AaUTSRhKz3dJfAM02aR3UH1h4e1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DXRiPpW+4DbF31vRxg0STlgbjb+HaJSC9qE2YriaHE=;
 b=VtTGg/KJQIH9XrvT57352RQU5hKsSon+t9ihBGaKw/z7hPfaSG15Xp42FsoN4EbrZO/HpAxByWJVjdYqA+zlLVVoG3Wh3G+D4PtwO00gx0Kk0hBppf959qzGlUCmA1XfZEUaNOvFH7GwARPe0o3suHKWE3MhWmaF7qYJ2O6IRyY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5277.namprd10.prod.outlook.com (2603:10b6:5:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 14:14:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 14:14:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Return true/false (not 1/0) from bool functions
Thread-Topic: [PATCH] SUNRPC: Return true/false (not 1/0) from bool functions
Thread-Index: AQHYQk5l2/abG1IVUkO/vCgjDe5+XazU152A
Date:   Mon, 28 Mar 2022 14:14:20 +0000
Message-ID: <53C50F72-581E-4BCE-8D86-9CD7DA7D2521@oracle.com>
References: <1648435739-3034-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1648435739-3034-1-git-send-email-baihaowen@meizu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd84573b-e2b4-4b28-6753-08da10c5408b
x-ms-traffictypediagnostic: DS7PR10MB5277:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5277FBCCB7CC094EB37FBECE931D9@DS7PR10MB5277.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nsHpkZGk21YduYrIpwAsiIxLUsJ5H3u84VuE5kqVViwS3L/pkDRzEK7zfnujn9fdsJq3HWclTD44GFnQ2Za0CKeY6s7XJ0Zk5br3N9jGhn20tDHr9BCl5OLkukiyhGmtKbCNRKyWeWCm4dT0f+oUBi6lASrA80lvgr27DlwVQmPoP91YlxNzc7Ri/VKW8gwyS1OYgbPpwfU3vSr/9IW0c4rFUNtYLp2TKU0a61C3+flxRChbJfmJSGaLVOc5ctYLbICyRFnWQ/dbaVa/8Vq3WGE89zYMKg64EXw5Pc71GkMcrxGt8nky+yKAwNvYQqy83/MFzPCgmxzWiay4CT2BKoq8CBPfuGUl+s2PIuYK9tEyelP7Hr7uQMgDUMMXr80P2VNgzIhqP06ld+Yh42D9500NpQCnL8ZG49NnXCJH48HqUNYA/nF1qisUIIkSogX7bRZLc++rmi31k5iZ3OI3YEdoXvtKyGomK/qy+w+lz/k0j5BODKAdbDld8S41qNc0dsBuP20aMABXP/2R0fkj5he7m5Fo1lmCeMNkW/3AxeFJWDZEDS8i2bJqVYHk3tWRA00Idb7iDfc2s+YcwW1pLGx8FpVPuvDmYFlRK6CEyCcnvuGYFwTF74nK1bEgUk6C7pLmOXXttf9lk59wjDuPcQsN3hvT04YegwupW73EtnEwgKaNowGddBW3mTwSE54Uhc3cGhg4419RlT0p0ErgqpiNWtqcrYKMBro7cIVbQX5sVpBsUWxj94Kx2V3TnoYu0lB2lD5nGutcuxS3mepdbS1RBPsVza4yVLhUObR6Hf+Lp4wA2qo5JwHMf5Ndvr5U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66476007)(54906003)(6916009)(66556008)(316002)(4326008)(5660300002)(2906002)(64756008)(76116006)(66946007)(91956017)(8676002)(66446008)(38100700002)(33656002)(38070700005)(36756003)(86362001)(122000001)(2616005)(6512007)(53546011)(966005)(6506007)(6486002)(71200400001)(186003)(26005)(83380400001)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YOHCS43TSnf+/AshW/jsb8ZPBex/IfnhDIMjMeP0BwdAF5FStH0H0phKiIaa?=
 =?us-ascii?Q?fTW3LO8esKf1Z2AeVqRmI2bPdz0EBiT+VxBr+wQfafcYLyFQ9s7NNeZS+QX0?=
 =?us-ascii?Q?xqGP302fR6z6UzxdpPTLJMRoXq40WfnKKab0Kc3EO75JYuCwpbv1NJB+3rNW?=
 =?us-ascii?Q?PHtv6gfj5Bx+Sflf9d2sUggxTKwvNuOmYWs1YVITXFfYRI00jTBPUm6LWLk4?=
 =?us-ascii?Q?yBTXhkUc2Zl30N9ia/H2oRmriLEMcmNjQNILvqPMhS2tvTOYUzg9aPG9BsCM?=
 =?us-ascii?Q?vbNWmEhwtpx8osrdasUu2/NE3BFj4lmE4MAWorQhaYMLkwjsagfW+xqvw/mw?=
 =?us-ascii?Q?eSMicckW0n4W72i8u9+XsTVzh5vI/pdTt9w3sg+pjGJWN5SuPPUMWXKi0B38?=
 =?us-ascii?Q?ytOQF4Erm+S7IsvVkzEDUhsz7jStAzz8/iBqlPxTF5Rwrj2C+oz/9hy0AuRM?=
 =?us-ascii?Q?cQoXyffmpFryZG5f9TBnUnEX4gVa7PP++qe0eIGXwCruRZsJCp6hAcVSwbo0?=
 =?us-ascii?Q?ewIQiTDAyLyoxRhNuqdNSEfoO0V+6QFjvwZLf7yfxBxHs7obCu4JQPwxIBbQ?=
 =?us-ascii?Q?6WdASJHUi3psJ+PuOL/iLB1vmeyf5TaMqF5O0EOHTedbcntMYTN3S9l7bKit?=
 =?us-ascii?Q?Il5eXOGsh6D4l1WHJr5fOb8u1FpNpJpjP5bhmEzZQtcuLm3kWidC722WNmwa?=
 =?us-ascii?Q?J/tafhqoTnHy+ZTFHT+65BKdMdHc2Tf4AO8aqnWy0imemKgr3m22dHgqA3xy?=
 =?us-ascii?Q?aiTDc3DuhI4RXBJYxPDhbX8NNRKSz2/Ww+BO02dlr5Pxup+GKXLjCGjO9ZmL?=
 =?us-ascii?Q?xnuR0D79zZyqlDknt8hi+MOn4jNsrcKqgGSEImvTg3ZgFsugca2xUrP9OvIT?=
 =?us-ascii?Q?6Pyywi3Ub83PzB2qCxxHNLLhaS/GnwxsbyQv2a5zP0n8CIvtUdwOZmsQaK7i?=
 =?us-ascii?Q?RYFhF+jl/0/kzjPSz9e8RzjPy4OQJOzFE4WzVrMGfoKIdn20TIv7SrYQsFp0?=
 =?us-ascii?Q?nRc7lyQdl/WKDU6D1o4dUi90TUFk+swnNL5ipR8oV5cxMLaIzeJ8DdCTXFmP?=
 =?us-ascii?Q?PyjxyfbmGiCeGDPdUEQWh3ge55CrFIKbWUSMgOnEAIQ98Yde6Mvh4L6pxN8z?=
 =?us-ascii?Q?B7wRmzcvqTNMyJUo8mdDvpXFuJ8h08u4cIlTB2vaW10943N/XsPkFI5vlk9W?=
 =?us-ascii?Q?ftbjoplmT6AYcxyOvDW4W6jwT/JkrXT12YH6aDwimtmlC63zAJzF6ZdCMnfQ?=
 =?us-ascii?Q?BWQy9wRfZ9YcdmU0xACwyJjV/gt6uBVQ2J9bPjZ1xp8f8xq1P3aHWmuKqe3M?=
 =?us-ascii?Q?RmS3M67yXE7YS9eJI1Zg77oQ/o4yKwuiA+7sXIM4cgodZ+LHszVUruxUJe09?=
 =?us-ascii?Q?U3K7NmcL9KlLVCBS0Grt912CiomlPId/duGUsz7ceOWWFQ47NNzcTpR/kmvg?=
 =?us-ascii?Q?jXP+cbrrbKen+EAkjOtWoWdfKHifsrTr9yKFdFQFNjGTTUCRKqQ7wZkNrbZa?=
 =?us-ascii?Q?F7O5SlAQwVpoAC5ODiQ1bKlPO839nSETHK9crV7FVH4oh3h11O3EwFk6zrBy?=
 =?us-ascii?Q?ZMf6PhWtFU/w3x3Mi9MRDP07xbveJGCBwLy2Hgv4XCudnCN8/B4+MwexPN3O?=
 =?us-ascii?Q?NlDMGi4bcnkalaUGhgLeTQLjPCND8kVDc9CgND/pHboZm0C9hwMXPXiuhcoh?=
 =?us-ascii?Q?CIxsYy9iZlGrTtRKGuf7A4A3P9FvVEr26pydoRtjBLyyPQ5Nh5kgje2VhQFt?=
 =?us-ascii?Q?GtGaO7HPit0PCo4nVwZYDs8LgPBzBD8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B459C53B48B2D45B2FB65BD93FAF1F1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd84573b-e2b4-4b28-6753-08da10c5408b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 14:14:20.3044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/NEvIAJs2KRwQtb+JL0RfsW9XpOfDUG+4N+1kMV6WYmKtGlT0i1hoPm+tCA6tN89OieOrcZRn5jil/2xvSRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5277
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10299 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203280082
X-Proofpoint-GUID: jz-72OYsopoo2gyQcPhg5rvFC0OvT_NI
X-Proofpoint-ORIG-GUID: jz-72OYsopoo2gyQcPhg5rvFC0OvT_NI
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 27, 2022, at 10:48 PM, Haowen Bai <baihaowen@meizu.com> wrote:
>=20
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> functions.  This fixes the following warnings from coccicheck:
>=20
> ./fs/nfsd/nfs2acl.c:289:9-10: WARNING: return of 0/1 in function
> 'nfsaclsvc_encode_accessres' with return type bool
> ./fs/nfsd/nfs2acl.c:252:9-10: WARNING: return of 0/1 in function
> 'nfsaclsvc_encode_getaclres' with return type bool
>=20
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> fs/nfsd/nfs2acl.c | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)

Thank you, Haowen Bai. I've applied your patch to the for-rc
branch at

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

I thought I had a patch that converted the ACL XDR encoders to
return booleans, but it must have fallen through the cracks.


> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index 367551b..b576080 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -249,34 +249,34 @@ nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, =
struct xdr_stream *xdr)
> 	int w;
>=20
> 	if (!svcxdr_encode_stat(xdr, resp->status))
> -		return 0;
> +		return false;
>=20
> 	if (dentry =3D=3D NULL || d_really_is_negative(dentry))
> -		return 1;
> +		return true;
> 	inode =3D d_inode(dentry);
>=20
> 	if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
> -		return 0;
> +		return false;
> 	if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
> -		return 0;
> +		return false;
>=20
> 	rqstp->rq_res.page_len =3D w =3D nfsacl_size(
> 		(resp->mask & NFS_ACL)   ? resp->acl_access  : NULL,
> 		(resp->mask & NFS_DFACL) ? resp->acl_default : NULL);
> 	while (w > 0) {
> 		if (!*(rqstp->rq_next_page++))
> -			return 1;
> +			return true;
> 		w -=3D PAGE_SIZE;
> 	}
>=20
> 	if (!nfs_stream_encode_acl(xdr, inode, resp->acl_access,
> 				   resp->mask & NFS_ACL, 0))
> -		return 0;
> +		return false;
> 	if (!nfs_stream_encode_acl(xdr, inode, resp->acl_default,
> 				   resp->mask & NFS_DFACL, NFS_ACL_DEFAULT))
> -		return 0;
> +		return false;
>=20
> -	return 1;
> +	return true;
> }
>=20
> /* ACCESS */
> @@ -286,17 +286,17 @@ nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, =
struct xdr_stream *xdr)
> 	struct nfsd3_accessres *resp =3D rqstp->rq_resp;
>=20
> 	if (!svcxdr_encode_stat(xdr, resp->status))
> -		return 0;
> +		return false;
> 	switch (resp->status) {
> 	case nfs_ok:
> 		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
> -			return 0;
> +			return false;
> 		if (xdr_stream_encode_u32(xdr, resp->access) < 0)
> -			return 0;
> +			return false;
> 		break;
> 	}
>=20
> -	return 1;
> +	return true;
> }
>=20
> /*
> --=20
> 2.7.4
>=20

--
Chuck Lever



