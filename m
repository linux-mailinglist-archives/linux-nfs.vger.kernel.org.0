Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D46585181
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiG2OZG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiG2OZF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 10:25:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E227B56B8B
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 07:25:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TEK2cf017592;
        Fri, 29 Jul 2022 14:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=omkLTGQnGEvX9zKNqOVuieyJXXx2+dM9Rg5B/k/n258=;
 b=L/9j3RujrysyGyGgrAm4qi1u+xEyqg73rs88PmVi/lKq8UPMh7z/iptmkjFa4pvjguZq
 4vajO7ZqxX8pXYk7Q3qz6wV2KzeH9xERdwwSMxrkINyJ+H2FNkaQwqGkR84KCdznZ4gl
 /zOI2B9X2EHMRQW9gvLLUyQg5QQYl/o9A7k7e3sN8+EqpJfMavA0vn44r5nIpurl4y/d
 ttTsejJjykkr73epMZjVR6Jiw5mVcFhuKNvTpItFHPPEH7YPaMTY34bM86H9qUAujPvf
 mq5NcDIub8+mYK/B1Hmpa9gkN3AzvNlfH4Z3ERREKzjORf6JuvRbjwg22pz4NqTlrr2e RA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940y1j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 14:24:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TCouDs016583;
        Fri, 29 Jul 2022 14:24:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh654ajwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 14:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGK52Rkc/K1xcV5u+RN/RV/8wrVjltz2+pGqGsiiLQ+y9uKB4s3yKzmLODt2crOSTvslnaA9ATYVpV69wgtJc+kHzxYNsVWf17sbblmaFRCr1BhNZtZQK3ckDnoiX+qiO9neEbGgkC1qrwhD3wtPOEzAYKlhYIuXd2wOxlIhGKe90B8iiIPNfvCMfg+g4ujub1uRijdCS7DsPaAsb1EfsB7IWYUpK6RywVckSwPFEyIgxSl7skRIBB8F3DYxOeuH41V8UWFvR3j2Ao0inxp6dKNsW7HnhEP7ja/oWnZHT2D1z0TUwafmPsAzi7edt3zC9FX9gNq0AlmmG2gQUHntlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omkLTGQnGEvX9zKNqOVuieyJXXx2+dM9Rg5B/k/n258=;
 b=bkP8s+3vuxnFvfGzXAq7ip0Frx3vo+c1WYqa9BhQhdX1hdv3RGOcgEG/DY63mroqowcl/CHoli0/p6L21EpMyuTRo67dTIT6Rp3hwtaOb9SUq2WtAdxX1jgB06GSZkf9Kho++AOAhWJWuSEG7Q6b07xU1gnHfFNMaMohbWDvXKpl3Ny1BXvGDbdHvW/k39HG14TB7yhqs9ofuGuyUrf8ls8ix6y/q3jh4vO5acEHhk/snl/TX6iHcsWPSy2zq3ztUm/BKe8y6ps+2PzQQZ0fP+exZLy1p3PnW5rckNmOpNlpNSeEVD3MHXsMnrbjCsQno78F4KC1qcQKuxiXOngedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omkLTGQnGEvX9zKNqOVuieyJXXx2+dM9Rg5B/k/n258=;
 b=rsNgG2naB1JRPZPoRta6A8bKPgTGtUsvbtYOBsysWqOD/Byh4H4RfFgqmYkLGSZYznpoGb2Z1vd38BSPab3qNbp2EJQmfo60Lny9ftVspZfAKHMeWmE2mJmPKxvgsrTn/cllo8AuYcWWxMZGkF+uv8T+eeb+lQXulwPFuPsl6k4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6202.namprd10.prod.outlook.com (2603:10b6:510:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 14:24:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 14:24:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 06/13] NFSD: add posix ACLs to struct nfsd_attrs
Thread-Topic: [PATCH 06/13] NFSD: add posix ACLs to struct nfsd_attrs
Thread-Index: AQHYoLurDuvdQIXikEO4o1VXFN1HkK2VbHcA
Date:   Fri, 29 Jul 2022 14:24:53 +0000
Message-ID: <2CE51ADF-AC32-48EF-9D9B-107BC8EC0370@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793057.21666.7472233362797480106.stgit@noble.brown>
In-Reply-To: <165881793057.21666.7472233362797480106.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a02adf1f-5b53-453d-d7a6-08da716e1a7f
x-ms-traffictypediagnostic: PH7PR10MB6202:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yV4UyiVMLS4DNeArRSRb3u9XkW2Q0Snhpn+mtTONfZVdHUksBagiz7wC++Qb4IbWG0AOLx95QW5DUankcXGlS6AfYia4S7r4NykQ4XVdEXBJ653ZSylPX0wPwQvbc2+H++TSdQNC0CPVY2ZqWh14eX6HRTeHBS4WlxkuXO6shiYH13PeeeRU47aJdosL4H6PjgxU5mGSuoOSuQ+I8YpeCjLeYzwMFsgCVfX0pgEjsgKB2jG8N3uLLcs6LrMwbsWu1BYCczGGlWYNyLTx09eSiTiZqSzkRipcL5cl4TmPK6Wlaf/w6bHPOIdkytoPWTTg/ehPdGVQvs7Ssk+e1xeUUu0wxj5Kz1ofDwCl/6FrE2UyokHixh0XRNaQ+NHG95+/AXxd5jUbwx5tBrLuPqjgpI97tWUXHFz3OSE773GB2qXN2kHFGC9mXmmU3Wis7WB7mSqpiaqzNWjWglQbLuOGrVKZgOQtbxM8SYPP2WwxY8zZ3w9FK0WbM22ERiaZXztzd37pWmkClDitioK9T9MBjo6lYNg6/nag5VNj8yxJL+oLdIEP6xNy0NMB71nRVQxNPdqqdfgW2MlVQjGYiT4DvGDxStldL5eR+KohDn52/YgHju18aIR082ppOX2DWhokfOVIPbXkB88ojf2beD2N9Ju2FnKUaydS9C77MEzDNjbLIt465UdEm5OdEnjE08Q6WrWn/LOkIwpqQzg+Y0DMw9fv6IOM+NzbVVsDayThF0m14HDqEL6qj10I94cb4FdlnG7f0Vbo9m5vKDr8cQcVK2SljyCq6UZK/F1DiXL3TKpbYlejH+EoeB8sozPClStU59ynlHBHbMItzkIbKnVdCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(366004)(346002)(39860400002)(5660300002)(36756003)(54906003)(8676002)(66476007)(66446008)(6916009)(2616005)(76116006)(91956017)(33656002)(64756008)(41300700001)(66556008)(66946007)(53546011)(6512007)(186003)(6506007)(26005)(122000001)(38070700005)(38100700002)(2906002)(316002)(6486002)(478600001)(83380400001)(4326008)(8936002)(86362001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?70n8Z6m/9zin2B3yYhjPMSgaENvvak5mLk/au7/CgY/LmObuAZqiQOT3pVGl?=
 =?us-ascii?Q?xziV+bASAaDFX0EtZEDDJYh+VfgoeGdYkWZIbMPxv5+KbmoXzc94UBjKZ1Gy?=
 =?us-ascii?Q?jys0va88yPH2duRIp/kFLgDF96UvjBUpYgXel25FzrKKELbO0qjqjpYGeSJb?=
 =?us-ascii?Q?OcGVRfJmIKkW3PIaByPfZwnprU5DDuatOBYvce+jt7aqxRC1v43SwJGAQqhp?=
 =?us-ascii?Q?eTUzJmo30l2Q9nIQKlBcpSGSRgJherqTGB60cVM3hsvRTg1YqgcjlGCiS4Co?=
 =?us-ascii?Q?BQYREoyB4DDs1hvfW/VTCwvxqAzqSLDPUr04SOos0TUGeON6YS7mAI8Cw9Wb?=
 =?us-ascii?Q?bmXku5y7OdkxMaYjRMkR2QqWW6RCgYigVIjn0O2Os3F38840FnoG7PEcdkb7?=
 =?us-ascii?Q?Ddpy9JO3r/br4EPXdUtMEvfH5T+8+gnb8Kf7NphPlP0+Pfb2SF8Mfck0/PLW?=
 =?us-ascii?Q?XF9mSJh94mbRgplMFagOwhhVv4GmUl7nCMTL9SZ1vul3V+4n857rb4MKKHmn?=
 =?us-ascii?Q?vW0q0o7BHw893KZjkHXXFfkM+K3v+iZWduplcKt2sVdEP/HgQcVbjWTbfYm7?=
 =?us-ascii?Q?kPOuuqgPLSYSv379ikzVMyFoTbOb0L4tLE7EcYUDGNc33Bx0vJqweFqAkmWH?=
 =?us-ascii?Q?jnhzDgaFiEz4bx/Xd7gVoprVBAEHJ8lY97HJivZ/6AMWbRzwlHfyJQ1VHeWV?=
 =?us-ascii?Q?RpV0MA8yvkUOT+Ey+2I4GGQh3w3g60xEBgXITW/48n3erKH+uIJ/dEfb/mNp?=
 =?us-ascii?Q?X7eoONz5PkZD4FvO41Te0uzlRY7Hg8B3T/pGP4KdHjz+LDWQstmj6HF2+X7H?=
 =?us-ascii?Q?h5L9lWiHPelUGhsYAcpZb3UD0ycdP0ZrfeSRk2YWFYzST4UzYdlY9GqC06DK?=
 =?us-ascii?Q?ky3s4qZCoLLwwaevSiCJIkopb7K9LNcgmrDXU7yXBOE1KenniK2gbDTkus0G?=
 =?us-ascii?Q?V0YfzJ3UeEDEG6xYwDW/Dl5vFeJUtCfPcE4GcQCte5WNrwJDeR+G7qssgzqQ?=
 =?us-ascii?Q?rS59VZ5H2GdPBLtQy1qIXz9cvpilngRGOp/FrSHnhzwovAEnxJGC42gnJTGQ?=
 =?us-ascii?Q?tL93R3B5HD1nYmnWl6yrTStmD4f6gv/SZnDd9X0CZWanjCWJtb4H21bOUggT?=
 =?us-ascii?Q?YaDhALsSpCliihxbxGbFb/0v+i2AGljmQ+3o/xyrfbF2Qt2+f29U3rFQ+E4y?=
 =?us-ascii?Q?RlLAJ9LNCzAnYYtlwSacEDNGG0GFElLatOPWlygu5Dkh+C9rVejLZLrfOahA?=
 =?us-ascii?Q?AhcIepPsuQ9ZkKXShaakHUeK/5sZxP9uD55zFnvhe9kgr+YXDr9IEzdXUO0x?=
 =?us-ascii?Q?7OmaHM5nW5DJ3MKvYpwXMSFZjJdOuJrsiVLSYH4y9YjD0aFanmEi8fDxKngM?=
 =?us-ascii?Q?eTkUjNqDgrjzgrjvqF3Ss6NHCt/Ki1Ciebd/dXPvlRoVQ29j1rotLtRzfjk2?=
 =?us-ascii?Q?stCUEGDOReK+0LOEbIozetOG6nqMyH9b0rdE8c4FGizscRd+Yhi3kLDkV1DN?=
 =?us-ascii?Q?nIIzmQ0rS+BIJPul0m5uw43lKFnOGSiTvZCpNz5ivz+pAPRoAd/Q84p4rJ3q?=
 =?us-ascii?Q?DInuYK+W17ph6zCdERdANk8bwUUs7m6w3PC8ojoOQaBhbdPmZgwui2ZsucT5?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F5A57451F550D4ABA30A327867E73A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02adf1f-5b53-453d-d7a6-08da716e1a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 14:24:53.0648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYUsb6MyixahjfpudScpoQ+BQRiI17nUcwNOwjZxHo8vtVgGwe/eVFNYcS2yKdugWtuVbrlShvnP9nT0lCw8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_16,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290064
X-Proofpoint-GUID: qvUojvKosW086AafLpEXzhPsTQ_3Y7tg
X-Proofpoint-ORIG-GUID: qvUojvKosW086AafLpEXzhPsTQ_3Y7tg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> pacl and dpacl pointers are added to struct nfsd_attrs, which requires
> that we have an nfsd_attrs_free() function to free them.
> Those nfsv4 functions that can set ACLs now set up these pointers
> based on the passed in NFSv4 ACL.
>=20
> nfsd_setattr() sets the acls as appropriate.
>=20
> Errors are handled as with security labels.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/acl.h      |    6 ++++--
> fs/nfsd/nfs4acl.c  |   46 +++++++---------------------------------------
> fs/nfsd/nfs4proc.c |   46 ++++++++++++++++------------------------------
> fs/nfsd/vfs.c      |    8 ++++++++
> fs/nfsd/vfs.h      |   10 ++++++++++
> 5 files changed, 45 insertions(+), 71 deletions(-)
>=20
> diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
> index ba14d2f4b64f..4b7324458a94 100644
> --- a/fs/nfsd/acl.h
> +++ b/fs/nfsd/acl.h
> @@ -38,6 +38,8 @@
> struct nfs4_acl;
> struct svc_fh;
> struct svc_rqst;
> +struct nfsd_attrs;
> +enum nfs_ftype4;
>=20
> int nfs4_acl_bytes(int entries);
> int nfs4_acl_get_whotype(char *, u32);
> @@ -45,7 +47,7 @@ __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int w=
ho);
>=20
> int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
> 		struct nfs4_acl **acl);
> -__be32 nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		struct nfs4_acl *acl);
> +__be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
> +			 struct nfsd_attrs *attr);
>=20
> #endif /* LINUX_NFS4_ACL_H */
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index eaa3a0cf38f1..8a5b847b6c73 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -751,58 +751,26 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl =
*acl,
> 	return ret;
> }
>=20
> -__be32
> -nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		struct nfs4_acl *acl)
> +__be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
> +			 struct nfsd_attrs *attr)
> {
> -	__be32 error;
> 	int host_error;
> -	struct dentry *dentry;
> -	struct inode *inode;
> -	struct posix_acl *pacl =3D NULL, *dpacl =3D NULL;
> 	unsigned int flags =3D 0;
>=20
> -	/* Get inode */
> -	error =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_SATTR);
> -	if (error)
> -		return error;
> -
> -	dentry =3D fhp->fh_dentry;
> -	inode =3D d_inode(dentry);
> +	if (!acl)
> +		return nfs_ok;
>=20
> -	if (S_ISDIR(inode->i_mode))
> +	if (type =3D=3D NF4DIR)
> 		flags =3D NFS4_ACL_DIR;
>=20
> -	host_error =3D nfs4_acl_nfsv4_to_posix(acl, &pacl, &dpacl, flags);
> +	host_error =3D nfs4_acl_nfsv4_to_posix(acl, &attr->pacl, &attr->dpacl,
> +					     flags);
> 	if (host_error =3D=3D -EINVAL)
> 		return nfserr_attrnotsupp;
> -	if (host_error < 0)
> -		goto out_nfserr;
> -
> -	fh_lock(fhp);
> -
> -	host_error =3D set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pac=
l);
> -	if (host_error < 0)
> -		goto out_drop_lock;
> -
> -	if (S_ISDIR(inode->i_mode)) {
> -		host_error =3D set_posix_acl(&init_user_ns, inode,
> -					   ACL_TYPE_DEFAULT, dpacl);
> -	}
> -
> -out_drop_lock:
> -	fh_unlock(fhp);
> -
> -	posix_acl_release(pacl);
> -	posix_acl_release(dpacl);
> -out_nfserr:
> -	if (host_error =3D=3D -EOPNOTSUPP)
> -		return nfserr_attrnotsupp;
> 	else
> 		return nfserrno(host_error);
> }
>=20
> -
> static short
> ace2type(struct nfs4_ace *ace)
> {
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 83d2b645b0d6..c49cd04cb567 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -128,26 +128,6 @@ is_create_with_attrs(struct nfsd4_open *open)
> 		    || open->op_createmode =3D=3D NFS4_CREATE_EXCLUSIVE4_1);
> }
>=20
> -/*
> - * if error occurs when setting the acl, just clear the acl bit
> - * in the returned attr bitmap.
> - */
> -static void
> -do_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		struct nfs4_acl *acl, u32 *bmval)
> -{
> -	__be32 status;
> -
> -	status =3D nfsd4_set_nfs4_acl(rqstp, fhp, acl);
> -	if (status)
> -		/*
> -		 * We should probably fail the whole open at this point,
> -		 * but we've already created the file, so it's too late;
> -		 * So this seems the least of evils:
> -		 */
> -		bmval[0] &=3D ~FATTR4_WORD0_ACL;
> -}
> -
> static inline void
> fh_dup2(struct svc_fh *dst, struct svc_fh *src)
> {
> @@ -281,6 +261,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> 	if (host_err)
> 		return nfserrno(host_err);
>=20
> +	if (is_create_with_attrs(open))
> +		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> +
> 	fh_lock_nested(fhp, I_MUTEX_PARENT);
>=20
> 	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> @@ -382,8 +365,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>=20
> 	if (attrs.label_failed)
> 		open->op_bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> +	if (attrs.acl_failed)
> +		open->op_bmval[0] &=3D ~FATTR4_WORD0_ACL;
> out:
> 	fh_unlock(fhp);
> +	nfsd_attrs_free(&attrs);
> 	if (child && !IS_ERR(child))
> 		dput(child);
> 	fh_drop_write(fhp);
> @@ -446,9 +432,6 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate, stru
> 	if (status)
> 		goto out;
>=20
> -	if (is_create_with_attrs(open) && open->op_acl !=3D NULL)
> -		do_set_nfs4_acl(rqstp, *resfh, open->op_acl, open->op_bmval);
> -
> 	nfsd4_set_open_owner_reply_cache(cstate, open, *resfh);
> 	accmode =3D NFSD_MAY_NOP;
> 	if (open->op_created ||
> @@ -779,6 +762,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	if (status)
> 		return status;
>=20
> +	status =3D nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
> 	current->fs->umask =3D create->cr_umask;
> 	switch (create->cr_type) {
> 	case NF4LNK:
> @@ -837,10 +821,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>=20
> 	if (attrs.label_failed)
> 		create->cr_bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> -
> -	if (create->cr_acl !=3D NULL)
> -		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
> -				create->cr_bmval);
> +	if (attrs.label_failed)
> +		create->cr_bmval[0] &=3D ~FATTR4_WORD0_ACL;

I think this needs to be "if (attrs.acl_failed)". I've fixed this
in my tree.


> 	fh_unlock(&cstate->current_fh);
> 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
> @@ -849,6 +831,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	fh_put(&resfh);
> out_umask:
> 	current->fs->umask =3D 0;
> +	nfsd_attrs_free(&attrs);
> 	return status;
> }
>=20
> @@ -1123,6 +1106,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> 		.iattr =3D &setattr->sa_iattr,
> 		.label =3D &setattr->sa_label,
> 	};
> +	struct inode *inode;
> 	__be32 status =3D nfs_ok;
> 	int err;
>=20
> @@ -1145,9 +1129,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> 	if (status)
> 		goto out;
>=20
> -	if (setattr->sa_acl !=3D NULL)
> -		status =3D nfsd4_set_nfs4_acl(rqstp, &cstate->current_fh,
> -					    setattr->sa_acl);
> +	inode =3D cstate->current_fh.fh_dentry->d_inode;
> +	status =3D nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
> +				   setattr->sa_acl, &attrs);
> +
> 	if (status)
> 		goto out;
> 	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
> @@ -1155,6 +1140,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> 	if (!status)
> 		status =3D attrs.label_failed;
> out:
> +	nfsd_attrs_free(&attrs);
> 	fh_drop_write(&cstate->current_fh);
> 	return status;
> }
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index e7a18bedf499..4bb05586a258 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -461,6 +461,14 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> 	if (attr->label && attr->label->len)
> 		attr->label_failed =3D security_inode_setsecctx(
> 			dentry, attr->label->data, attr->label->len);
> +	if (attr->pacl)
> +		attr->acl_failed =3D set_posix_acl(&init_user_ns,
> +						 inode, ACL_TYPE_ACCESS,
> +						 attr->pacl);
> +	if (!attr->acl_failed && attr->dpacl && S_ISDIR(inode->i_mode))
> +		attr->acl_failed =3D set_posix_acl(&init_user_ns,
> +						 inode, ACL_TYPE_DEFAULT,
> +						 attr->dpacl);
> 	fh_unlock(fhp);
> 	if (size_change)
> 		put_write_access(inode);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 8464e04af1ea..9343aac0bd15 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -6,6 +6,8 @@
> #ifndef LINUX_NFSD_VFS_H
> #define LINUX_NFSD_VFS_H
>=20
> +#include <linux/fs.h>
> +#include <linux/posix_acl.h>
> #include "nfsfh.h"
> #include "nfsd.h"
>=20
> @@ -45,9 +47,17 @@ typedef int (*nfsd_filldir_t)(void *, const char *, in=
t, loff_t, u64, unsigned);
> struct nfsd_attrs {
> 	struct iattr *iattr;
> 	struct xdr_netobj *label;
> +	struct posix_acl *pacl, *dpacl;
> 	int label_failed;
> +	int acl_failed;
> };
>=20
> +static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
> +{
> +	posix_acl_release(attrs->pacl);
> +	posix_acl_release(attrs->dpacl);
> +}
> +
> int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
> 		                struct svc_export **expp);
> __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
>=20
>=20

--
Chuck Lever



