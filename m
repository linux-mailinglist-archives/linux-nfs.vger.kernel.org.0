Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B665B26A5
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIHTTb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiIHTT3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 15:19:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27D91028
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 12:19:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJKI4011851;
        Thu, 8 Sep 2022 19:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5pUkh7hfNmgoza+HnXrmwSneJnxOXxjSdMIKO3WNFWM=;
 b=ZYmEVXPAKr/ixXsnlO8QCOhYmgYfnwasnc24zoRE6znoy40vYpdT2XLX5/lwPutCu+TX
 LOmS8H4mt+FbVq/9MBtWR7gpWnMR7hON66jSvDx9ZmONAe834aW+bOj6YGq1N7hm+REI
 T2PjYqP4NbO2gT4J/YjvqHeLZlNxBtQy/tbPygdz4bSy5jjzveGnUOC3bSoa4VPD2mOZ
 Od64Fh7lbCUvd9H4N5SGk7N88Ic8GsAK7dL+M8EWsRCocNGBuWSXYg9pBK86TghNILIy
 4aNyF3LUSAoHdoQtJkXnBbuaTyEliHwZkYBPPByBYWlOM91D6XyynpTLqJNiwKVb/py4 ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2munc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:19:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288I0ICP028104;
        Thu, 8 Sep 2022 19:19:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwccnkc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:19:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYWu2k3QaRitO+kdgf6RsIjvnsOAsgIBMUMTmQ3Co/1kRvJ7xW2nKb1VSDLar/ojAW2zhbNlA4cw5ejJUe5pjHS7ZJvHdUpx8q2jVSGVziLGHNBFu+APEEe6RIkC/v2TAnJbn/RVnn4ZGv17WHtq3Dfbtoa65KWF8ycUwmQqxSVxSnWZGie7z4zXyKPcgg3eFP+23Vz/RosXFjWHBpDbeTqs96YZvJm4KAY7spoSuOu8iV9ljG/hbxAmHnVor3jmedF5dNqxYz5f3fUIbgOvbpOT5SsNIio72v4DgJop0UGTbu7h7nOC3FVuGaGvk1pjIutb7cz0pXFIl2MdHOeHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pUkh7hfNmgoza+HnXrmwSneJnxOXxjSdMIKO3WNFWM=;
 b=DH+b9lLeUQPzo3qrVp5trcoLJ2R0Fyp2GNpgniDNwQG/4YuC4B45mJoXNJKAMQ4Yv5j+8pJBTFO84j/60t1GjpVAa1+VmMzazqcf8XtDzTtX1qhn+T+P+NuB5xbRlJkHvKvgka2NONtq8heNWBWa/QTAjKoVugZ62kYv6fEgoOaybaYewuvJgUBcTWJBrboBeiTtxz/bpTBEL8OnYhOMQPGmDU1bL/WDCWoNiAeWxRChdX8NASQo9mCJNQA5bTu39Qceyy8uCt5GONEbH82HO47RSiEX8kL5bb6lanyVwHKcYKsqT3/wHKvQVQ4HLpm2QP/dUVgggvhCHnMp+MHlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pUkh7hfNmgoza+HnXrmwSneJnxOXxjSdMIKO3WNFWM=;
 b=rx4Mm30dWbzZJ3jgNow6w8gQB5EcRaSIdE/e2dX+wCGXtkEr9d50wmeRf/k5JUbv28peiLKse52m9+KsGbwGxEn3fKZJOyXY35q7rYcOMWKWBjVoclosjmADHIVG8/VfNRyNk/blJQlbivL5P0W6BLTyNliypAbyZEDq6mXVggo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 19:19:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 19:19:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: clean up mounted_on_fileid handling
Thread-Topic: [PATCH] nfsd: clean up mounted_on_fileid handling
Thread-Index: AQHYw6BsHHkMh8Cy3UWrE5HB3Ds/Qq3V6HyA
Date:   Thu, 8 Sep 2022 19:19:10 +0000
Message-ID: <37C6EE53-D14A-4E26-9202-E560B0555A4A@oracle.com>
References: <20220908163107.202597-1-jlayton@kernel.org>
In-Reply-To: <20220908163107.202597-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4196:EE_
x-ms-office365-filtering-correlation-id: 942f215f-8eb0-4c12-0b2b-08da91cf01d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovcNg66blmqnV9I+3ZoRnNimhlyyI0Sn8X97Nh69+CksIt2QJ6MwRsGdBF0Waj99gcNFSH273aFz1X5gxCqdpHCGrWdkGWircSTHp55pfJTWFVU5ZqxijbdDD4rXfMSrLDP+87ji+VDxF2IBFKH9WlcB9gotmwvnKNJJtrumBATuHwwByBMUvYdm4kfgR/VxfTN8x+BeVAY9sWbztsazQbEmdKBpEH9PhHXTlPMNimg9+0E8Hxf7V5ufpLW7/ZpaNHoV0HIeKk96moOAqrORApmtYBghDqTYUycPCaoZuBNHl1Y6kXjxH+40niAmnK0lAaimODcDCQC0UFfeLp8vVgdHEUq4i4XMT30O43kppLTmN20XD8PJCLcp9O9EHnGE5ZfOm2d3sGVI5HSkTUXq4ifyQvXVmzyWwruE3QxER18BFEeipNzljI7rctCQc46USWujeHy3hKpmaal/w2tV7BeMvi7u5qs8ZP7tNu4uzVv9Gg9s8wo/Q6wGsN6QyqPTZZKTSODK1fwRyObxR5Jct4EeHKgzE06ry4x7OytLr3rINDlm6pFnA6yKO8HrvVXjuv4cULcUbkuUNyLLME4IBFp07y5O/tLko5vOyORwjaJczQoIkmi5PIw6zo+pb48Z9evXkyikEdwY0wfQ6Qv0YGDih4qlcOomWT5CTQKFNn8dFdjHhNDTPLRkH8DNJQZrSFLDVnDD99e3SAxVCKataM9lp0rHX4Ajsk+6V9SRmj+YGMlEjP9fGhRQ3FDXI8JHizIcVjMovpp1E2+81k0dDLl46SvrK8dv3CL2Msbl5HA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(38100700002)(38070700005)(122000001)(316002)(6916009)(71200400001)(5660300002)(8936002)(8676002)(64756008)(76116006)(66946007)(2906002)(4326008)(91956017)(66556008)(66476007)(66446008)(186003)(2616005)(53546011)(41300700001)(83380400001)(6486002)(478600001)(26005)(6512007)(36756003)(6506007)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HTsUbgP9WrsSskKtmwKXA2O1JwqFLqnRYMq+vc9tAW2K0JwpW/NG7ltBjTf4?=
 =?us-ascii?Q?Xso15HhHERI41Q1GjAHiVm+WzO2Ng0/KJmMulYBKZPczN/UxQY6TqThObDAV?=
 =?us-ascii?Q?HjeK65SwCx4Mrv1aaZ//TYT/fxi9rTVmtRcux6YRlOZdPp3OG/D68/6QRyb6?=
 =?us-ascii?Q?lejqFtbm7rQlfD42pnW1mmGnYvBscOy0HNiUt8XL41ETnMpeb2mRNtawVUzq?=
 =?us-ascii?Q?EmZnC7f9o8xZgKPGxOc27LBQfgwTSfMI8ymo6m7PJuktcsXHvOdYn8gvoetO?=
 =?us-ascii?Q?heg+PWIGQJzlcX2QBskcbiFWEYMzefTInFNdmatSAvl4H1CMNbg0b8SqPBmv?=
 =?us-ascii?Q?uZQbdHm30KgTWHxT/vqR97D3eK+Ojn2mTrUs60mCXbXbSGWWgxPZcA3e7XDy?=
 =?us-ascii?Q?1b0hI69uQBvoLeA0giYQPODrtQufhNsnew8QGZ9sx8cGxpQLyoJgS3ynBSJD?=
 =?us-ascii?Q?HECWgOjJBJmyoan63UsAG30RnnVH2wA/nr315JNGiJeg3JEV3v3BKO4KMw/k?=
 =?us-ascii?Q?DSjyPx4fNb9V4/5MuuNh7HiTSwD1hNB6kJd26Ltu2r71/N3V+dSG2z8NVRYv?=
 =?us-ascii?Q?DkXva5h/4d7OPLtHGHHvFRpujGf0sr9VZCtyAsm4S00bD1d+7+IjgR20C+4e?=
 =?us-ascii?Q?AR8p5ABx5NGMoHR3nomStT6s3N7fSBLWNVStNXrqhpN0UOCyIUmzQSKtjxq0?=
 =?us-ascii?Q?MWChZts+r0+hILHGlHAaYzwC89TKWlp9Hqpyz8tlUNzNB8WpN4pLyDPlRBr2?=
 =?us-ascii?Q?eBsOStW1haL/A4VdhkLhLSJLCfFKYZFvLtCNBwZ/m8h0RsF0IQZ8A6NGkUbZ?=
 =?us-ascii?Q?9FC7em4jIkrv4RZYSmfHhfZcPIZfBRisXziZczgCJiTQTdDwNh0sVuzQ9Q0g?=
 =?us-ascii?Q?8+Zqcmjp50LsY03x1zFGDvHEsZHstC4D6uiI/fX5zbj84dcSNvpBEZQ+GPUf?=
 =?us-ascii?Q?V6y6mPo6kiZs/5uTPxqkePMDPsTsn+KKaNZMRiteJDbN5BavM3Zoavw3riJs?=
 =?us-ascii?Q?Sol0NjLvMnD9uLcEkKt9KV31WuG63e/WHhOAj90TV0uNM2ET2POmEyKbejdB?=
 =?us-ascii?Q?M9aYw2MyDjTTXpq5Qto8dW9H49PWjfnObKQeMBhMYJr5xBu2hTCp2KJF39Az?=
 =?us-ascii?Q?f6pKOkSPmJTtGUdb2w3419s9SdZ8K0pVoD6WU3lb2S6iiJi8YC5PLsE6lNgj?=
 =?us-ascii?Q?v95kbZZ3hOnR534PSeKaBqS35RAnLEUUe1aOrj043nHtBeyKITJidhISVXGB?=
 =?us-ascii?Q?mUY+Tvhi//6JA1xSJIn+RKmazELtBvZCaO6uybQPMZcUo3TO/CpuCJgALc1e?=
 =?us-ascii?Q?ExIa1yc9l+MyAMHgRY1dd2LycLHJeXRI65OJhyHidC0/J2xdNnF3tcSlgls0?=
 =?us-ascii?Q?oTYkPxJuXW8pdRENar7Jn+3pJIg+7ywXQ4jzBSJ28i3F9xsEG5FHaPQTPPCA?=
 =?us-ascii?Q?b226Yz3VQk+NYzcTWkn3sBsq8nx53r73qVUzo587LtlYhGyZpdpDfIGFRxwE?=
 =?us-ascii?Q?3UprN9Wjo2wtajA3CBF9woPP28zr4plrGt/Uetg2yOzEWNk7WMJS9qIMbWX7?=
 =?us-ascii?Q?CjDp/ecaMyKGEfrXR1T06PvHBLlBZVOs6SVDGx3nAbgTgNp+JvmX3hJC+ZGj?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <602B91749951484A96C1975DB20EA51F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942f215f-8eb0-4c12-0b2b-08da91cf01d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 19:19:10.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivH4LQVg6K/QbG35wrHywogqBJx7EnZZEwsGF8DAq6bafYrwyKXgIsIARyyHzew2lrscPtWn8X64D1J3NzRGFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-GUID: gZM0bU6WLR8zDmiFwx7AZUuOX7zPUVj6
X-Proofpoint-ORIG-GUID: gZM0bU6WLR8zDmiFwx7AZUuOX7zPUVj6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 8, 2022, at 12:31 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We only need the inode number for this, not a full rack of attributes.
> Rename this function make it take a pointer to a u64 instead of
> struct kstat, and change it to just request STATX_INO.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I'm relying on your expertise in this area.

As I apply this for testing, may I rename get_mounted_on_ino() to
nfsd4_get_mounted_on_ino() ?


> ---
> fs/nfsd/nfs4xdr.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..5980df859c3a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2774,9 +2774,10 @@ static __be32 fattr_handle_absent_fs(u32 *bmval0, =
u32 *bmval1, u32 *bmval2, u32
> }
>=20
>=20
> -static int get_parent_attributes(struct svc_export *exp, struct kstat *s=
tat)
> +static int get_mounted_on_ino(struct svc_export *exp, u64 *pino)
> {
> 	struct path path =3D exp->ex_path;
> +	struct kstat stat;
> 	int err;
>=20
> 	path_get(&path);
> @@ -2784,8 +2785,10 @@ static int get_parent_attributes(struct svc_export=
 *exp, struct kstat *stat)
> 		if (path.dentry !=3D path.mnt->mnt_root)
> 			break;
> 	}
> -	err =3D vfs_getattr(&path, stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_ST=
AT);
> +	err =3D vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
> 	path_put(&path);
> +	if (!err)
> +		*pino =3D stat.ino;
> 	return err;
> }
>=20
> @@ -3282,22 +3285,21 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct=
 svc_fh *fhp,
> 		*p++ =3D cpu_to_be32(stat.btime.tv_nsec);
> 	}
> 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
> -		struct kstat parent_stat;
> 		u64 ino =3D stat.ino;
>=20
> 		p =3D xdr_reserve_space(xdr, 8);
> 		if (!p)
>                 	goto out_resource;
> 		/*
> -		 * Get parent's attributes if not ignoring crossmount
> -		 * and this is the root of a cross-mounted filesystem.
> +		 * Get ino of mountpoint in parent filesystem, if not ignoring
> +		 * crossmount and this is the root of a cross-mounted
> +		 * filesystem.
> 		 */
> 		if (ignore_crossmnt =3D=3D 0 &&
> 		    dentry =3D=3D exp->ex_path.mnt->mnt_root) {
> -			err =3D get_parent_attributes(exp, &parent_stat);
> +			err =3D get_mounted_on_ino(exp, &ino);
> 			if (err)
> 				goto out_nfserr;
> -			ino =3D parent_stat.ino;
> 		}
> 		p =3D xdr_encode_hyper(p, ino);
> 	}
> --=20
> 2.37.3
>=20

--
Chuck Lever



