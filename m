Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A91B69674D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 15:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjBNOsY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 09:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjBNOsX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 09:48:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA35CC13
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 06:48:21 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EESvaC012867;
        Tue, 14 Feb 2023 14:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BvZAElmiedOwQgQscr19Fzt0LTGjPwfZPqSa9RNqO98=;
 b=vwLDMvhRdfjDtGs8WlrFvLuxoY/tJCgQX1hUmrq2qJ1pF2nMvJgVf+3vZob2H6+fHl0H
 cl2AjP/lvp/edxasfYFimXyVFLM+n7rVR3fbqhIJD6IsdGt/O55fDFTMOHHdCZvS5OQC
 A735pt+LBHHmcIlZ22ezRIaoU/0yTvm6L8+IAhfz8r94NlrIi8eTDKqWkXbatAcYgEY7
 o/C4WX0q5e8iy1uOGBMcegTacWYzPUZrFL4BSMJ7NsNqioQqD2VD4Yha+g5oMdfADiNV
 EekALreM57Klixg3D+HLKs7QwONCzQa1oG0zQqFPVEWG5peYGVRJATcUTd+nK0b3VDjz Lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32cdj33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 14:48:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EDDu7Z011523;
        Tue, 14 Feb 2023 14:48:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5p31f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 14:48:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcxBcV7kfvzxVmirizgMGcUYmHDssD+VaOl1s2ovr8YcrXDETDbl3RRErvqU7KBTdCGa8+Z8BCyPe6whTjDZqkqI+rqVNnsh6VgTQJXSjphBXrnNVUTPMKFzOBsENWj4nD6sqKln1whwta57Mng2CNEyQ5Si3S9j5RzqQmN089VJGq6DeSJNMK5rl5Ja3ohpDPIsfRlJhM875shXXZtEplahch/Kjwt2yIOEqa4kQcPcihMuf/3nNG2nFbe40M9vALyW18Lpc/3EmzMEUqkTNM0yzeatIGXFzjMvPtb/bjVD/Xuaql11k9pHUGj/ss5YdlFoirpDCqLLKx0vBR7gGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvZAElmiedOwQgQscr19Fzt0LTGjPwfZPqSa9RNqO98=;
 b=hkkjbrNYjecAByK3OxVoPvxHzJqb3y3nxywWO/ui9rCMAxDciKUeTrGLtfB28YVGNMepIiyzyBklDfBDM8sUu3tJdP0u+oibZRD+Pw/smGs8cLd+dZcuSFzbhASnO1oHUKY+5SOsiv9kcMj/ks7r9OY40H0lH32q/a9aGq7OgIA/vXLHCyQZO53sAPTwBoj6equhHmLB7WcTl71xsPltkN0Lc5ziRV4/JyF0LewbP51lX0SM4KEJu53LZJDUJN9LbhXY7G7B86o3LQ29DNRB/2N9ePX03qGeB9XJLArNAJR37107w7WJAwlHr0rGS8aEv1qwcA9eYhIUH3UhzqfVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvZAElmiedOwQgQscr19Fzt0LTGjPwfZPqSa9RNqO98=;
 b=i1N0FtnImnzzPB4xK5qGxqLCXRDRaHKBD5bpEv4/xUauz+9WnTZIJSS4noQ8EEUMgdG1K4D1omEAQO6fFkCP8d+QysL/6NkapC5HplVRNjS2uV5w+dEbjopltAQ/YkOS7mol5deNeMbfmpbArNdukWi+ZyV+n3/9gav6AgGVEEI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4239.namprd10.prod.outlook.com (2603:10b6:208:1d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 14:48:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 14:48:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: allow reaping files that are still under writeback
Thread-Topic: [PATCH] nfsd: allow reaping files that are still under writeback
Thread-Index: AQHZP+kYZqo+lvM+xk+OVBsJow3AIK7OhuYA
Date:   Tue, 14 Feb 2023 14:48:13 +0000
Message-ID: <E1A055FD-45C3-47A0-A6CB-296C84985D43@oracle.com>
References: <20230213202346.291008-1-jlayton@kernel.org>
In-Reply-To: <20230213202346.291008-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4239:EE_
x-ms-office365-filtering-correlation-id: 856a2713-22ee-4d96-1fa8-08db0e9a7fa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbHYJzU72WH7CMI/WjJtAzlmyD3BfG9l3FvNiy58Vuz3yINWYR8mol/QuknAR3OSfRG52+8sltzl3SwJBvBQAyKvZYR6cOR2D5cmPF78Nv9t+rgPqzISIXR9IfbJUBMwOvxcwOW+is4qKFKFv4VlonmrLc3fzADLGtk+i5mRUXkJOx6yun2PLxLcoWv/NlQm2l7N0Z4610rG/psSkG2UcamKhjQAaOxq6WtceW34GCb9YfFX96PGK/q0IWBQZvpX6Qk1kDGImpNsDARuuBz73UCxZHTviXsAUB97EJSQW+Lql21OUbQrVqJSRf3WfqLFiCwUjhpVgGkrEmopdAfIKIZAcMnUnIemj5eTgg3vnT8DqH5HE9qSUkbCs72yRpb133sl+JNa+mB6cnEF83C7FWG88SFhWc9GLh2qzO84N5nlARVBbcKPRBcEDA5KFXkqavUaihW/w/NnooSeGWCA7Udp3yksha9es4fDD2q6gzXo3ov0779wnkT3TPNJsEe6p8hkp4l4/VSNBlidecBrcZzVDmO7rPBb/PO0m40eky/9D4g3+YTCrKivDbrBI7FKFt0weKDwWPw3gVm9YbMdLZiqiDMdsC2GJtW4HwJzIWd8zpOhZ/sQECu9JpnwI7I5osssl6cYwieDS2E4g9HkPSIch2Ly230W3ynmkLnVciDIsH+cuN21G3KpNW4W54EQyerUT9vom7XInwqKMavQwAeYGdkcUjp9pAdlStAC5mc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(186003)(26005)(6512007)(53546011)(6506007)(36756003)(71200400001)(33656002)(2616005)(83380400001)(41300700001)(8936002)(5660300002)(64756008)(6916009)(66556008)(8676002)(4326008)(91956017)(66476007)(76116006)(66946007)(66446008)(2906002)(478600001)(6486002)(316002)(38100700002)(122000001)(66899018)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GFrZzx/KsIFYRp/cBl8gc0V/TeWc2V/TPNWNlel+B+7mz3ZOhgq2kVpFR8rN?=
 =?us-ascii?Q?Zo0JBvqjo8mtr45HOTz1A8tJP+WHN2aJJyJS+CQVOQa4AmpNHwAYMO4UHw2Y?=
 =?us-ascii?Q?+dUnDqrzNZcas5sruJBpC4vhtLVOZpwr9oSnM7gxjRw6ZM+e6zf8yNv7ZqTr?=
 =?us-ascii?Q?FnxQYiEMhIzO70jMB2LUHwlALNLtfjCRcsF24Rh+3dVRSIIY5sMCckZec8O0?=
 =?us-ascii?Q?mRfs83yAm3yHilOg7KpGpph/bGipnwbqZ0jYS23x4wJCmnkHhVN0AGl+EmAG?=
 =?us-ascii?Q?s+qWCxX1C2SRnNK/INe74vyvyXSdIoqvWaNT85/qu5o3AwlMCG3q+yhQ2pkL?=
 =?us-ascii?Q?1ZVjnvViG5PO4xfOpwezkCL6rAtnCTeQ/7gzSVtSmcKlT4XkGDmbYoCU0e0Y?=
 =?us-ascii?Q?UADMxm4QszRgKDB1H+91DFBevgNGVUCngiMQbLmg1BeCyOkMe+XfacL25mU7?=
 =?us-ascii?Q?3bd0i2eQSgxP4KIayAhmV4cbDOeYAU72hqvCvGbowQ5j8AZ5DdrJV0bZN04z?=
 =?us-ascii?Q?9+BpH1/BNrw2ZzvIH6pJFeHaWnkXHcm/6C5xTp5IWjBAa6QYqdjdebo6mvu4?=
 =?us-ascii?Q?0cY8uYKCPyQtpCdN9fH2uA054OyjY//MRthOweKjDI3QpJhghG1m0rfqKpvn?=
 =?us-ascii?Q?HYRcbsvopv34txWlsyz5EyXAR92Z9iXgzJVAUeVoMmxhz77+0+FVR3oKysC7?=
 =?us-ascii?Q?28A7pG//ORUm5Fq5FgYYi26uDHKWqdrnmApP0CKcnT6AoY9bjCmRSxwzKy2A?=
 =?us-ascii?Q?rt0G07qhjBANbr303wIRjCnfGjiXVG7BxU+NvRRyUelqRCV96o7xlAFcFO8v?=
 =?us-ascii?Q?XlBCikv++Xg9/d5a+MTN3WO4KQgbL/kK+xWjSC/cWP8Zhw4Ckq2ciqYt9AUW?=
 =?us-ascii?Q?oCaajA5gCyoZQd2VTjXHae5CrF7K/88qEOyH/9R2r2MAw0D6bvoCBh3BJQv8?=
 =?us-ascii?Q?nvoV+GFV8VsHQVAY/XzyREEtgWie6rO6Pmry7VC51MchoN1NTqR5Kl8UeTlQ?=
 =?us-ascii?Q?/r7+khP6sE/tBj8tzGPhdUFm7dbCOPJr5iEsYisJDu5wxj+lOwUsalD7vX8S?=
 =?us-ascii?Q?YoJUIOyeN14wawvM17HIouJeGeN67RMw6XCKZQUgsiF8PXhi5hPo7CYmomCU?=
 =?us-ascii?Q?S3OSV2IQJn6ZsG7zbNah8mniqLEhWRrwgPGXnxlioLdaXeNMgUFHeS6kmhmH?=
 =?us-ascii?Q?m5YozJd0JjZqNsT+wMyll5EJ/4b2PE5OtV3CNnqMOZNWRqn7XyQw8czJ6Drf?=
 =?us-ascii?Q?J05sAx38V54Ybny5Kw74FPth192NuNOFHDGtUNU4/wFZboXWFkFr1M8mamL0?=
 =?us-ascii?Q?MGR3zChtnBynSLGSViCBlvyGfAGEW5iyCSVDnprTyqALtM3WB2AIaPsJMr+G?=
 =?us-ascii?Q?yt0oVjMbDYizpmRycyKxP+11iWG3fk7I0aUFpsxWfV1dfcDQPOizYW8SftTO?=
 =?us-ascii?Q?/ROiswZTb8Z0x9XjseqG0p2ER+ewY65cCZvySJchm+yrTYJpKcxCZ+3rMlbW?=
 =?us-ascii?Q?ECIR6tiFEUDdWiazyRP3ybfhrf7Le+Y2K5AbvERbQPIrsAJa+cho7IULY3dg?=
 =?us-ascii?Q?0zsWtRH6kepFLTEv5mel6oDd/917yvDqqECas7mEEHq2G4xE3Nr4i+Rusfo3?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <867625E909FA0A489682CA2B4490E523@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Bd/y0/KndLJ9xsVAA8TpXw+H0XZPRJmmuGx8Wi3LRGcFmWKRm9LOdasIb4BAtzcMz5DqyJY4m7e+SRgDjTthMGWIovUQZYE7ncESQct7jLZNaWQ3p4vA1rgdUFp6OlB+8XqHJZkiyTCYxNUx+JSLCgA68SZ6UYM09CvDW1vwoifY6S98IrWSCSwHpk1VQGdKcCWdGsDX6wkEH/gPMNKgb80B9JP7i4YxPUB6MyxvZiZr1Ld40XHfkpPDjUIW3IFfFle/UI75ZEHcZ5uYa4Zr5Yhp0ZiEdfCG8oAVuXzIAd5FCVX39FJ1OgbqGDNefxtDNy5YVW65GQZHeXuc8bH2ApRexxWPqoQDhb5uKKlBQZTi4UG8KOFJDE0G67mSCH6xEsQCrAOf6qP8x56sChqghqDjpo1/LYTmkMTTyaK5HweNCJ+xXHVQsrN88ujln7ZIWpokF7tA0A8sqvFmwXMr8Y0Kn0222l8xVS01S5sIidhwGm/rSleK9QfVrndj7raaLJjhoETpEZfpb4FHUwqs9aycI3jeLdphwn9D1PTjVI8Ka1ZEhjkPGF31eQ+PlfddpxXPbnOgYgvF2UnljERjBAt1NVkkjDjAB3W2xzniNn1xJcimRcJ3R8j/gSskzEs1gXfA3Q7NAXwzOgrDivjhBpv4LeQGgLTPCygl13PZpUTxrh9SqG83tmlKy4UhBB+FtwtZQewEWxhW4Xx++9JaDCvb59tVg7cnblM2XD25ZkONKYbWiCzYTGowZykBL+ND7u15Z64MGK4e0Xvzn4JW+P15JdqHBQ90vkn3MXGlW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856a2713-22ee-4d96-1fa8-08db0e9a7fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 14:48:13.1921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZ1PyiiXjwb8TLimuZRS0a3+lhgYwvKNcKB/pyvlOELd9w8+qgQP5RcXgQfp9qXSFwdcvY61rxc3K+AwJgo2Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_10,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140127
X-Proofpoint-GUID: UTQK8nxN9dkR__2VW03BGOfV58QpZ7uZ
X-Proofpoint-ORIG-GUID: UTQK8nxN9dkR__2VW03BGOfV58QpZ7uZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 13, 2023, at 3:23 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> There's no reason to delay reaping an nfsd_file just because its
> underlying inode is still under writeback. nfsd just relies on client
> activity or the local flusher threads to do writeback.
>=20
> Holding the file open does nothing to facilitate that, nor does it help
> with tracking errors. Just allow it to close and let the kernel do
> writeback as it normally would.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks! Applied to topic-filecache-cleanups.


> ---
> fs/nfsd/filecache.c | 22 ----------------------
> 1 file changed, 22 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e6617431df7c..3b9a10378c83 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -296,19 +296,6 @@ nfsd_file_free(struct nfsd_file *nf)
> 	call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> }
>=20
> -static bool
> -nfsd_file_check_writeback(struct nfsd_file *nf)
> -{
> -	struct file *file =3D nf->nf_file;
> -	struct address_space *mapping;
> -
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return false;
> -	mapping =3D file->f_mapping;
> -	return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> -		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> -}
> -
> static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> @@ -438,15 +425,6 @@ nfsd_file_lru_cb(struct list_head *item, struct list=
_lru_one *lru,
> 	/* We should only be dealing with GC entries here */
> 	WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
>=20
> -	/*
> -	 * Don't throw out files that are still undergoing I/O or
> -	 * that have uncleared errors pending.
> -	 */
> -	if (nfsd_file_check_writeback(nf)) {
> -		trace_nfsd_file_gc_writeback(nf);
> -		return LRU_SKIP;
> -	}
> -
> 	/* If it was recently added to the list, skip it */
> 	if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags)) {
> 		trace_nfsd_file_gc_referenced(nf);
> --=20
> 2.39.1
>=20

--
Chuck Lever



