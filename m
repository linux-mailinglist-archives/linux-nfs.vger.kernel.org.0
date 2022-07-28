Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B1A58425D
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiG1OzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiG1OyZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:54:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5903C60517
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:53:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SEnpUk030822;
        Thu, 28 Jul 2022 14:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ecBiQ6oIQ7q+ITsLf/09uNqtuW3Zy6B+41WPsxJPArs=;
 b=P7NzHmhUwOfcJRiS8GptL+ZGf5mb3pyaiHxL3g54+3aKApsnKEpRX764pVN2K9zWxmB4
 PbqSSNg0juGjxRl2+hFS2gxNmUKngB3btP2OCPzY7jsdORFZNnEMcN499Y1OVNkZSo2f
 lVNqXK14MYCcX/rLYF8WwSOyDdSGdhCxtW8vAtq6QNHRX0/1XTG5759OA0x6yuJ0BwRF
 Vqcs9IhZ4pZ8P9vDK0npHhkJeS8IeM6X8o1AB7gKJqgds9RDjdPLTF4HHspElHwOK6/J
 iG55KeQNnkZf+hIX/4JChGMMBD2dyQL//hKbHuJBfXVcWCj42KgeO08woGIoeahg0dp6 +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gms52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:53:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SEAmcM006455;
        Thu, 28 Jul 2022 14:53:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65ebp2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 14:53:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mChg5FE4tT08psDXCWYTHNLrrBM5XwesTkYOkELnkq2MNB95ujgRyuiUszO49QNs8fBpFlkGLy6/nDUtMq1PS+u+x9eeokEvvi2KL5zqHbkoMer++usWAiTYfDHDAeC2iQKdKs4VoTq5kORf3rlhnGQW1xKCS0zmI1Gztplt/mU1XOt758HIRWtrzHenN2Sa1C8n6Xw/dE4AD4fZHR2v7aD0x0J/JpuUjjZJg1WnvedXu9MQNDl8est8EX2+azSXowWHnLC6dPCXnpv1uBOL9TuY0or9Ykc8HPdv6uYV0g/uxFUFDKoqNTgJLk8C51SSH/jhP+/Sj0v4RCYELkJ2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecBiQ6oIQ7q+ITsLf/09uNqtuW3Zy6B+41WPsxJPArs=;
 b=M68U+hAVcs5o5QxB8HfIN3aEMQ3M+R6L/jdVi+Wmudqc5l1RmgceEoaymIQ/RRxfDh8wAO6dnKMOB+VCriVhnTeH+ECKt2P9WN7/oQ8ffSQs6sFgwnyFVqO+VjQZ9Xb16XfmZqwZcUfLME+Xlc34RQsERJfD9qk+/7Xw0mWLPnJ7mIwfiGTKc2rqw2lh5HCGPu7Jj+k8wH9ZYX+Cq1Xe1/qOredkr/dAjnvyIkFna2TluKeo55y9dh3Zi2ejodINFLM5F9tqJDOgjY/7oj3vRsFHN8wZN2RsnHdS04N5bNVnZX1J/ncIi8BdbNI51dBcBAX9GJxPRixzGRBAL9BxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecBiQ6oIQ7q+ITsLf/09uNqtuW3Zy6B+41WPsxJPArs=;
 b=LT0CzS3cF+bTuz9bv3SQQpUjj3wXNuWqjkpT1i45te/8UhmqlO6tkMrRiOqlXvY29UByhDnKt7vq5smdKQPavIPgk7PCeDF6Bzio/oJbQPC99D3Yye0ATgutUgZYWL/h0wHM8YH1V5twsyBbhDP2nyJWCdYC7ILEXlERoVjTKkk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 14:53:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 14:53:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 04/13] NFSD: set attributes when creating symlinks
Thread-Topic: [PATCH 04/13] NFSD: set attributes when creating symlinks
Thread-Index: AQHYoLujfmoC23Q2SEegG+eOkJm9Ja2T4iAA
Date:   Thu, 28 Jul 2022 14:53:29 +0000
Message-ID: <F72352C4-4CFA-48CB-8901-EC6AFAC2E8BF@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
 <165881793056.21666.12904500892707412393.stgit@noble.brown>
In-Reply-To: <165881793056.21666.12904500892707412393.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c198024-bab3-477c-e6d7-08da70a8eef6
x-ms-traffictypediagnostic: CO1PR10MB4593:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqLl/bl9U5EfGBJkBC13bWh1tvt9suMH4WbVm4ho0yoD/+YnJgGCcDSIF2Zr4i2lNNLEynwZJHs6o3fVme5n3pZK2jm2pExEG/1367VLeBCBO1KuFPn4rwlAloQPsiB9Db9zDHLBrh7RME7PeRX6UtYAUzZAo+evREGGE0AgoRNLyJw4NVAmNb1GS6WWWHf6IoctY3U4VQARoU1uzHdipG9eejlKvpcylj8A08obsDo2fGnN3YnOeFpCvpCpJXKDW79NqDC7CwhOeziNf1ouu6ipqOupCoPiUDSgr96fv8ZLBON7MHB3LR01lapBQaZ7wossRq77xT5FDIHrO7p5PzK103MruUiY/xb4FgTeCY1+UXDPGU6/grX7Vup0xUS4CwRfGiABnj2QFXjFxxQOpyv9B4AmFBZYxQS8yqr36h7uFhjX+JNkviN8XgdnTsmrkxmBs0+0SDN89cBaArT8i6RqTqZEEJ0P8wUjZElXB0niAbtQjsaU+IOuaK8au1TNHkDSLs4au2FHyCTjYh3BB/Z688YVsN+XZ2l92rqLJ9WL2g8G5zRRCMwljRjNl1ep/zCmIXSp0biGVPHSEg8Bzr7HuymdrWlI5CegvaHXR/zhZzbplB6mSFKYKAtIIPpnvOUMI6/J8TZFmC04Xks1UapmB4yBwAXThOkPvUPrN45xxp0+J/25DLAqyLww2LZI2UCcq+vndE8mldBmR5KDI2LJmneukiRve4dfBIal+iGHmJzXOROIeFE0LXbTI1lZ2+UJV5unaG71DemCjKBN1IGTF+hdHzqeV3rM9yloAhPSuhE5u5v0iOhcWBqSJnzPH3Lrh0FI85CnzFZo67uN2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(396003)(366004)(4326008)(66476007)(478600001)(41300700001)(71200400001)(53546011)(26005)(6486002)(6512007)(64756008)(6506007)(8676002)(66446008)(38070700005)(86362001)(38100700002)(83380400001)(2616005)(186003)(122000001)(8936002)(5660300002)(2906002)(36756003)(6916009)(66556008)(33656002)(54906003)(316002)(91956017)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GqUnKtN5lag7aTuHiPsPh52XMyi7CkyhPWNLG6fniU+ysqERm2vx3q0C4CaA?=
 =?us-ascii?Q?nZZRkJKIH9N5T6+EZGLH0ASFRjV9uETagGL4VDZQozTUxGC4hx6G+JH+X0n6?=
 =?us-ascii?Q?HwMc1w41m46F9KcFaiEFRYqZ7g06hkf2qbK/lUkjXOjvdaZz0t1yAdOj4zxh?=
 =?us-ascii?Q?vIjx1tO9CaEdDrTwb+9CLIgajvZq5wz+A4vUVwsZmht+6iz+OofwJUtX7ZZY?=
 =?us-ascii?Q?IoGhztMVjBDDwcl/gbK8fQH4E87dYOtQCLBtW6YeoMQTyXHATBJoditrHrMJ?=
 =?us-ascii?Q?nDQBgvCJTcmM+mAtz3VS+hJ7Obzmrcb36qpeUnXaSCbzlc9MnStQNnEd7fMx?=
 =?us-ascii?Q?SDlx4Rgx2gwLnefLtVZqI9nGOcrZSNuXmzC3VsMVnKnAUBAJVkXuEM8disKY?=
 =?us-ascii?Q?5s+MwevTR+us/LTrQSB/dRfQKsvnVvAz/baKqL1bl71NloNcVKhYa7MvIZMb?=
 =?us-ascii?Q?AxwfS2CrNwEBhmzbBjTSKubUx1qGP5vvnFxXMPZ764eIcgjEW5IhhBEP0MSb?=
 =?us-ascii?Q?znhNU8WV9x2ToLi+t94+ezMUeVQVzXDsyWHA9dnvW2km70g7pr4cBUO9KJ1C?=
 =?us-ascii?Q?NN9xnCQTZfEc7hxVsg2GuhcEABwJqgHuEKRkH703UinF7BPNPFPX5caN2Wd+?=
 =?us-ascii?Q?tsOLzSXRqulcm+XJsS8QPOBCjaROlWd+a4Qi8N6CNdnPnFvvs5gFlU/ioVKk?=
 =?us-ascii?Q?UuMtEQT6kg36944fijyapPhy7QjcUbNY4gYnZcOOS7fhaP38U+08/7b06OYu?=
 =?us-ascii?Q?gYyzduTy/Qbs0ZxtFtDs8GE4gzqhIZhHI4LWaDMYApyazf68HPzu/ymDxljT?=
 =?us-ascii?Q?Dwno9X6yHp7f6mi4aC5yOWAFcs4s9pCujF59RJKhYqUM2+KiPMd933FA8cvM?=
 =?us-ascii?Q?gkDsDNOwpEbMoJbheVA3w1YHqW9mUq1HlaTWMgdWsuXNVqgg9moeh4wzTWQ3?=
 =?us-ascii?Q?40EMXIr6RQrx/aSHCUag7ryvpnQXqQ1OTxQFfXLYBvpPLpP2PCRjOY8Pxfe0?=
 =?us-ascii?Q?RvyR1T3GYrIxTa+N4X8WeQCKn82bZjM5zQejMIAqtLmot1lV7C+8XQ+6OvGt?=
 =?us-ascii?Q?y3Eg8Wfm+VxZihbq+ig1CDtcmpNDmFa4WVggobSj56Gt2+VdEJrpYX+D5nzF?=
 =?us-ascii?Q?Qa+va0Y1GalS4/pBqcdvObrlOKT7Pygh++5Hr5cyQ73gwdv0TUZZF7AXuVSh?=
 =?us-ascii?Q?3nR5MbZDzUB4C7zZyBa9n6R22oaT/JpTCMLkiVGlgdraac/VoWzJ+DH68Qxl?=
 =?us-ascii?Q?x5d2Usi0UiOU4VAwOtmG3OCwoCrvnDN/fiJNrXcuTwZPtMyfjPac2nukSSzL?=
 =?us-ascii?Q?uz21RtY+JUBZ/orQfD2AIzeSQUW7exL5NuL7dYtangB50EwpYMpRpcfE5O6B?=
 =?us-ascii?Q?jI5yeMSDePC2gAmzXFrJoyeadbR6FWg8NI0hcb1F4reWWAi2BuBA0k8v2lyo?=
 =?us-ascii?Q?Srrf8bR6/0/+NakZ1anxxjEez1T0yaJNrguhXavxSttUY/JzLx2fQtQRpWz3?=
 =?us-ascii?Q?z6LB6r2IvdNfKbWo5pdnnTxE1cukR2pescvyOW50QFnnImGxYa0Y4N1McfVQ?=
 =?us-ascii?Q?IhwH/+5er3PCqxhJO23si2myWR9uyTvKD8uG65KaOn98FzULBHfTBVRxLUx6?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11522249E800224A91486739CB5A9FD8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c198024-bab3-477c-e6d7-08da70a8eef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:53:29.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qohA5bgZMgbTfgygpgnFqSprlYsFNJX+5DJgDCFJgGpwSeYtZWAfJJ28NAlBogm8Nc4s6gEizIODwFd2Vi67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280068
X-Proofpoint-GUID: wiQ6-k0qiJp9AcudqRMULTz9DtnFIhTt
X-Proofpoint-ORIG-GUID: wiQ6-k0qiJp9AcudqRMULTz9DtnFIhTt
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
> The NFS protocol includes attributes when creating symlinks.
> Linux does store attributes for symlinks and allows them to be set,
> though they are not used for permission checking.
>=20
> NFSD currently doesn't set standard (struct iattr) attributes when
> creating symlinks, but for NFSv4 it does set ACLs and security labels.
> This is inconsistent.
>=20
> To improve consistency, pass the provided attributes into nfsd_symlink()
> and call nfsd_create_setattr() to set them.

This patch actually introduces a behavior change, if I'm reading
it correctly. NFSD will now permit an NFSv4 client to specify
attributes on creation, correct? I'm wondering if there will be
fallout for our test cases.

In any event, not an objection to this patch, but wanted the
behavior modification to be noted at least in the review comments.


> We ignore any error from nfsd_create_setattr().  It isn't really clear
> what should be done if a file is successfully created, but the
> attributes cannot be set.  NFS doesn't allow partial success to be
> reported.  Reporting failure is probably more misleading than reporting
> success, so the status is ignored.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/nfs3proc.c |    3 ++-
> fs/nfsd/nfs4proc.c |    2 +-
> fs/nfsd/nfsproc.c  |    3 ++-
> fs/nfsd/vfs.c      |   11 ++++++-----
> fs/nfsd/vfs.h      |    5 +++--
> 5 files changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 289eb844d086..5e369096e42f 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -391,6 +391,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
> {
> 	struct nfsd3_symlinkargs *argp =3D rqstp->rq_argp;
> 	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
>=20
> 	if (argp->tlen =3D=3D 0) {
> 		resp->status =3D nfserr_inval;
> @@ -417,7 +418,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
> 	fh_copy(&resp->dirfh, &argp->ffh);
> 	fh_init(&resp->fh, NFS3_FHSIZE);
> 	resp->status =3D nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
> -				    argp->flen, argp->tname, &resp->fh);
> +				    argp->flen, argp->tname, &attrs, &resp->fh);
> 	kfree(argp->tname);
> out:
> 	return rpc_success;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ba750d76f515..ee72c94732f0 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -809,7 +809,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 	case NF4LNK:
> 		status =3D nfsd_symlink(rqstp, &cstate->current_fh,
> 				      create->cr_name, create->cr_namelen,
> -				      create->cr_data, &resfh);
> +				      create->cr_data, &attrs, &resfh);
> 		break;
>=20
> 	case NF4BLK:
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 594d6f85c89f..d09d516188d2 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -474,6 +474,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
> {
> 	struct nfsd_symlinkargs *argp =3D rqstp->rq_argp;
> 	struct nfsd_stat *resp =3D rqstp->rq_resp;
> +	struct nfsd_attrs attrs =3D { .iattr =3D &argp->attrs };
> 	struct svc_fh	newfh;
>=20
> 	if (argp->tlen > NFS_MAXPATHLEN) {
> @@ -495,7 +496,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
>=20
> 	fh_init(&newfh, NFS_FHSIZE);
> 	resp->status =3D nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen=
,
> -				    argp->tname, &newfh);
> +				    argp->tname, &attrs, &newfh);
>=20
> 	kfree(argp->tname);
> 	fh_put(&argp->ffh);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index a85dc4dd4f3a..91c9ea09f921 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1451,9 +1451,9 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, char *buf, int *lenp)
>  */
> __be32
> nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -				char *fname, int flen,
> -				char *path,
> -				struct svc_fh *resfhp)
> +	     char *fname, int flen,
> +	     char *path, struct nfsd_attrs *attrs,
> +	     struct svc_fh *resfhp)

It would be nice if nfsd_symlink() had a kdoc comment like the one
that nfsd_create_setattr() has.


> {
> 	struct dentry	*dentry, *dnew;
> 	__be32		err, cerr;
> @@ -1483,13 +1483,14 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>=20
> 	host_err =3D vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
> 	err =3D nfserrno(host_err);
> +	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> +	if (!err)
> +		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
> 	fh_unlock(fhp);
> 	if (!err)
> 		err =3D nfserrno(commit_metadata(fhp));
> -
> 	fh_drop_write(fhp);
>=20
> -	cerr =3D fh_compose(resfhp, fhp->fh_export, dnew, fhp);
> 	dput(dnew);
> 	if (err=3D=3D0) err =3D cerr;
> out:
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 9bb0e3957982..f3f43ca3ac6b 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -114,8 +114,9 @@ __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
> 				char *, int *);
> __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, char *path,
> -				struct svc_fh *res);
> +			     char *name, int len, char *path,
> +			     struct nfsd_attrs *attrs,
> +			     struct svc_fh *res);
> __be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
> 				char *, int, struct svc_fh *);
> ssize_t		nfsd_copy_file_range(struct file *, u64,
>=20
>=20

--
Chuck Lever



