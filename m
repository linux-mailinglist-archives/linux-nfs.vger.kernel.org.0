Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBD64B6E2
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 15:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiLMOJT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 09:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiLMOIw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 09:08:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B146620BEF
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 06:08:42 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDDwleA008809;
        Tue, 13 Dec 2022 14:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DxkSQsYBlKpW1/D6J9P2miLbV7iGwZnEA8RgDO8MFZY=;
 b=l95ps4BqSkEG8IIpYGUPQr7q3xu5l6hk20uJTuplmupOmpL4erILmgpppSKgjNMYNTMJ
 7A6f8NNSlL4ZAFoAz2Q/6UOVBv9hB+37NctkZB/mPl48qKnXM5Hg6DKsdLem2kNbiYLp
 V/JNMFDUqidG6bt9u5rel5/u3giUnvkvHBzhysjQ6e5EwcvMCzhXVORKDAFd2a1Rf0PC
 veoty10j5+9wazT3HKnM3xE3wgsTblG7KEcuUisdi9u7KLyeZO407OK9j5jpXVuiia95
 jQygYG8PJzS/vN64Ed8mpE4Mvry97C2Lph0+3eR+nKuGeFit8e1u2M6nq2+pJZubWyEN 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj5bwe6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:08:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDDRmOx034845;
        Tue, 13 Dec 2022 14:08:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj5r9kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUoBSs/lZ7vDjDwOnSISkmh3zTGfxEySkQtFPyCIesS44j8FW6ZTg2Z5xZ9pQZjehoVO6Tw1RBbmbPqB9LKwerUd5L/JHu1KmiFNXAGJvAIdrURa+/HL93pCypp1AeFtFl/8eU8j2BUkxd4LK06mz8IBYbDBwsRfRVrxS3PdsQ2Jx+DCMBEht0lkeMA/nJB2k4PPBK6hKPj/hllhe0PV2cQh3AdFv1GTB44o/alUm9JqZAbYR6VeM/SXIvSXXHwCfFQ3XsF9XM1MaF7VwpA7BTawvSIcYnJeNjllR997qfuV9ZI2rSPEy8uloctOPkkAneTxlvNWgCzm6FZ/Iyr/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxkSQsYBlKpW1/D6J9P2miLbV7iGwZnEA8RgDO8MFZY=;
 b=RuSoMmPZx/m++VJx0p06aC2yGdB6HKzd3Vv8G4UIGUnidksctcmLXM5KHPNp1mbdpwbwHUcjafFaZlVYExjZ5fi5iBMiE4nAJ2IubSkgAX15XTTGZEXfPiqbi4dFHECoyh/iZzrV2luMvwo1DmY7JkCnjSJyof7Z/HPV9WtoweAuHMLm6BF6XLuaUf9IM3D5EAKODZT0v7dkYi6rEmBPOXEtlWZ81day5E84VSXDyk+LotKX+3QtnAQW1dNEJjlTCdDx/HwF+ekHnEhKW0uTGhufxQw6fyBU4wen3x8ulkwGF5ZG4j+htYqtseHyabYFCGqqgaPbAkVNki5e1iR8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxkSQsYBlKpW1/D6J9P2miLbV7iGwZnEA8RgDO8MFZY=;
 b=Ni/GYc71zdP9zOecyo22Mt2bqK1yYL3lQ6rU+sS7YxV5Lpew66BAbCZyzXik3g2qkw4PSWNgX55gPtZJjPK+xA7+4dgUV2eCiMNnb3k50cZII3tHwXc1PXXUAxnHiqsr8Rm1MKh+8HjbBdhLiMl2mYmwq677DW2bsE3eF5d6UfI=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by IA0PR10MB7181.namprd10.prod.outlook.com (2603:10b6:208:400::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:08:34 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:08:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Topic: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Index: AQHZDnweXCJ53drKKku1BZzW7bJsHq5r280A
Date:   Tue, 13 Dec 2022 14:08:34 +0000
Message-ID: <0B0300B5-6E45-4572-810D-6E14610A60B1@oracle.com>
References: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|IA0PR10MB7181:EE_
x-ms-office365-filtering-correlation-id: 24cf0954-0364-4a5e-e6f4-08dadd1385e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6EZ1CTaDXwQV4H9r96cTPNo75ArgD4JdkD+w0kJHZGrL+MHIM/FMS1V0Tldpev0BiFgKUu5vygYpPtV+5MEwggn0aVdHROiIIyuafal5EazdJed2B9rmEeD7YLbuyjxOhBBVwWSqQnP/Q6L9+MaZxceBdV1h+JeSMDcFIGpLYS1ukCuNgJwGbYivZx6K8om5RhTXJMpj9hUTtHSY3ddgP/wGz6jZfegI0imd4sF1T0PC00ziJVbUIGskXXDb3fUl2N5r/hbq9kUwYKojnhIA8AVWr7JD7qzFuWDvh1DA4eVIKFzCI91Ow+8vi8kbOJ0su1TqAyyrP4Kppx8NZO0WvSibrbh4oOU7vPMGqGByOn+ePoFQWZEDe7khhAUEK0BK7YrCBRO+vuZdhsEF8drqpbSj/qsh3tUkMDOkc1Z4N53AcFMAGGXZTD2RpcfX9R4lYo5kwBNbriK1UJBH0i0iqB2F+tIvuWzQcvjqLL4ixIIs/kjdr87nosemg4FCPgrOSgoDzj6BKxnmHI59rEZ7BNIC4dVQq5DVhAQuuHowdDYqAi9ETVHlLgxlrWBJ7uLkbSeQTBa4wSwujiV3Z1nft0lJ0ZOf/ezrgb5hYOeIC48L+AaE1KN6TzyWoiI1mFt1MgBEQfZaxRhIZsysnjI4AxBMGauFVrHx2S3Ij10pJl3a7Nl/+Axk/5qlQGQIz7ep+FAejIWIYzeS4q+rFkc/BzZc/FaDjnTsTirzvy7cxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(64756008)(86362001)(83380400001)(186003)(66476007)(53546011)(26005)(6512007)(66946007)(36756003)(37006003)(6636002)(41300700001)(122000001)(54906003)(2616005)(6862004)(38070700005)(5660300002)(8936002)(2906002)(33656002)(316002)(8676002)(66446008)(66556008)(4326008)(76116006)(6486002)(478600001)(71200400001)(6506007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mbOdcBdlcVeHTDk92I44krgMJ57fKY413ZPOBUCokCvgDUy6V96tcb/oe6YI?=
 =?us-ascii?Q?hvGUAng/wPK3yE7WWfe6C4pzy2yDCsaeAzcdL52gmgXW911lBsc405BKFunX?=
 =?us-ascii?Q?spJNxhuNRxrvdDByVY/m7fWbNNlixpdoM5rnMoM9DTy6H/zC6cVKMhh9Epkz?=
 =?us-ascii?Q?voD13G6Cy5VXCtFAjrDUuo8EnHYdZwYyIcI/+KQYsvUJYJeE0X7zD4gVRC9J?=
 =?us-ascii?Q?Uj4leteDDGbrngVUDjd7GaUgA6RcgeW+iOcQ7Ph2lX0yvg5WOZZBO3BpJP7T?=
 =?us-ascii?Q?sN6lS+FtM6n/hjDHGsdJLY0WDydaqW0FDy8+2mxskAMRKNR2Bp+PFIvcJyL9?=
 =?us-ascii?Q?xgz+TYAfLJ9HXAy7j/j98Cpcv/nLT095EuiuBq7Mur6r/X+GCIP6mjMpBiKN?=
 =?us-ascii?Q?YkRzKvlPH4ohvnkme0zqF3WI/OPEcdVyoAY/rHSSCf10HOkMhBRRBYiYud+C?=
 =?us-ascii?Q?T0e4Raqo3/oERK4N7tm3buKteQcRp9vcvmFDGX/6tV5hLSYYozqMYuwxTyNU?=
 =?us-ascii?Q?g4gJNCwn5N3iIfQTO7rBV3GA7RTHeDHY0T7tHpNQRWfK26GVCTd53fVvqDh4?=
 =?us-ascii?Q?FbbZ43XQCjPtZUmqnoaofrsQ5vZOy1S/yjiMUIVyYuB80vPfAHZNLP0g4Jy8?=
 =?us-ascii?Q?6PJ7sLfkAf8w2dftDrqejSpO5WM4OudBa3uPtbRGZjbGa7SbKUQvd75QFlyM?=
 =?us-ascii?Q?OsfLakGzfmhzyA8+Q6n2mofPLHUhHbXYhsExtFBNcQFVwXxN7tvwYkNadaaG?=
 =?us-ascii?Q?cjb/7repknGP+kflV5Sj03djQ5uFdmmmOt5kzuEbWiALfZda+gE2qOeIWudL?=
 =?us-ascii?Q?kqhArnZpBWBUgjN9P45tirxDUmT7GrpeJAavCLUgQrWvRopNvn6YL+iNP/Io?=
 =?us-ascii?Q?HbB+rMiwpXgGnJDq5drkM4iQqhTZyXLJ7lOzQhwewnZgQbZsPTFGlL8kBpci?=
 =?us-ascii?Q?ClEBvv/cgD4AavsB82J7b0FN5eUPALiXnnB7geQm5C/8JJq8GdedLVwkG267?=
 =?us-ascii?Q?B313zpc8ziYGSeZWjm7iM/Lwq6kqH1Sna6Y5/mf1VHi72oOJr0+i9GXxQogl?=
 =?us-ascii?Q?dWEafdB3lj4U1w31oZGf3DyVwjsfAqi7/nghZN7XbvILSe9NUa7dpGOEeZ/w?=
 =?us-ascii?Q?fsnli3lzLNU8I3a7LFtDSy/upEwcA/IGBMLeKLlWZmehigxr28w0p0AC/ity?=
 =?us-ascii?Q?LPdTd9rNAkW8ZvfAKcarfrm/63gkTIkHriot24BAgsDSYUMkKeulFsx7qFRx?=
 =?us-ascii?Q?99r+7x48hCSD1KHv/yT2MuAmqcPfgEinrQ0QCV4wjJ2nEKKSxvt059dRIyMG?=
 =?us-ascii?Q?fadWrTqINlfm7qnXyiUwuoJyXb+Uh/IAAYlTds1w9OHH0cjy/qJv43ZYgZ8I?=
 =?us-ascii?Q?OR8YTX7YCwb2BHIPZzkbS+kIbZ0SWc/zuuhweIt5XWkZ5UDLhXFdaNPAGJTy?=
 =?us-ascii?Q?53kMqT3EeTeLXYyqxxdz3409+HzPwAcE97AI1S5CVBEz2rYj165Sad0plCaW?=
 =?us-ascii?Q?zsccQnS1i3AXiia77B3nE8FDkZBJki2nOcRUdY0Zx5galg2tY6VCgapvJonE?=
 =?us-ascii?Q?36IRf5s5OeL3dqD7diRjfcq/607b8O0wDN/WemCOLBsX2ZF0+G7PrzNwF8S/?=
 =?us-ascii?Q?fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A0DAF6DB7E0A845A8BC245B299FC156@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cf0954-0364-4a5e-e6f4-08dadd1385e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:08:34.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdwgL13csWR6EDn+up7EhuIzrBlKXqhw7bVuVLCqx/8t5SEQfpMXo7gCkMq3oMd+EOQc/y9JKXZ1dpsJVQS+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130126
X-Proofpoint-GUID: yzPt5sUdLvYpH0QYfWBkpDj9BiRMjN0o
X-Proofpoint-ORIG-GUID: yzPt5sUdLvYpH0QYfWBkpDj9BiRMjN0o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 12, 2022, at 5:50 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Problem caused by source's vfsmount being unmounted but remains
> on the delayed unmount list. This happens when nfs42_ssc_open()
> return errors.
>=20
> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
> for the laundromat to unmount when idle time expires.
>=20
> We don't need to call nfs_do_sb_deactive when nfs42_ssc_open
> return errors since the file was not opened so nfs_server->active
> was not incremented. Same as in nfsd4_copy, if we fail to
> launch nfsd4_do_async_copy thread then there's no need to
> call nfs_do_sb_deactive
>=20
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

LGTM. Thanks for your quick response!

I'll wait for review comments before applying.


> ---
> fs/nfsd/nfs4proc.c | 20 +++++---------------
> 1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..b79ee65ae016 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, str=
uct svc_rqst *rqstp,
> 	return status;
> }
>=20
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> -	mntput(ss_mnt);
> -}
> -
> /*
>  * Verify COPY destination stateid.
>  *
> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, s=
truct file *filp,
> {
> }
>=20
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -}
> -
> static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
> 				   struct nfs_fh *src_fh,
> 				   nfs4_stateid *stateid)
> @@ -1771,7 +1759,7 @@ static int nfsd4_do_async_copy(void *data)
> 			default:
> 				nfserr =3D nfserr_offload_denied;
> 			}
> -			nfsd4_interssc_disconnect(copy->ss_mnt);
> +			/* ss_mnt will be unmounted by the laundromat */
> 			goto do_callback;
> 		}
> 		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> @@ -1852,8 +1840,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 	if (async_copy)
> 		cleanup_async_copy(async_copy);
> 	status =3D nfserrno(-ENOMEM);
> -	if (nfsd4_ssc_is_inter(copy))
> -		nfsd4_interssc_disconnect(copy->ss_mnt);
> +	/*
> +	 * source's vfsmount of inter-copy will be unmounted
> +	 * by the laundromat
> +	 */
> 	goto out;
> }
>=20
> --=20
> 2.9.5
>=20

--
Chuck Lever



