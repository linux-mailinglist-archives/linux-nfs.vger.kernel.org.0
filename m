Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977C23AF0E3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhFUQx7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 12:53:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19274 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231753AbhFUQvs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 12:51:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LGmgUZ019881;
        Mon, 21 Jun 2021 16:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jA6hz6cLKqcD1CyXcO+g1ce7CxxGTI/DRwio6EgkYVA=;
 b=fifJOQhnsvxiLx87eonHm4r+EEvhfM/b0EMPHJM6rdJ3gToMmR9yTkdeu4mC3yZHwdI/
 /r3z/jJXBBc//c/pIsuu6f5FoymzeIkQQ17v9OGEcifYOG0YothL8K0THvaZXXL94RLu
 tZawKLGE3d7XyIApRBq6ttmueLgkU1FzpEjN9GnccRT/0rjknQhUDFlLST4u0mxqop4U
 9ngkP9uJDlbX9ril3NjY7pSKYeOXgKuECaB+PyZLoh6q+Ye0/XZu0Yzp15FthEKdW7SP
 kE5Tlbw8XOveOwyNpkKlB/EEqx4PIYw7C6bNrMHTgVHkKo3vg1FPjin6bAuQ1EFCZw0v dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39anpusa80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 16:49:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LGjnim055462;
        Mon, 21 Jun 2021 16:49:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 399tbr8gcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 16:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5LQmmEjdF8SCoisqdiJflGSPY35yP9ZtR140W6iU2zm5OtoY5JmzHgRMg2pU/FdvTP7efdWtLZ7yjQi68sSbMQWRSZhjKuqCgfaRj2zzLPPQD+rUozDgOQCqAhawAocf7i9x2yB7lpvNVPdX2oyxVf0JiJ0EB+7b1trHJy9SKuIhpXfLYbrIMbPrdeEeot/Zj48IRzXWlZtmpNmPMMFIDnNjDyzEyF9eyN1XP8jrVwmGeLCNn1Nx0qWxYEC2ucriNF9inXRgNq49m4vGIsihLImqpjt7A7XuRt07AD5k5Iirp0FXlwKVa1lPV+KBj8ta6yTs64SAvL/dSaIpD8WIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA6hz6cLKqcD1CyXcO+g1ce7CxxGTI/DRwio6EgkYVA=;
 b=Z1EIesDPZrfHJZ6x6ML/ZapJ7ayg297gYkqSHuEAtwCbRKoCsCPYwv9yiikIE3mzuz3H2u13vu1brNPBwULRvMmlR4Q3Z+EopRSHVKlkZZNQLPWPrzzwjaRR451BiqPMcwcyuiDDwSiwqXfbeVNNnv3ezmXg+OA7SiTwdxJAQB/Fz+3zaS2/O0rxwNGEP6ajzUfhjYWUn/c+UJRifgea0SVP9xjD9lVcBQpqLuB5TRRWinJbDx1GfIkgXLPW15PGk2G+5c919MzFE4mHoXcVdW6ydzRAW7bSxuTuIXrdoKZ8ZTFcTNG+EJBQTRLMMFSFL33cigKAZ0QVGdcGSnwhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA6hz6cLKqcD1CyXcO+g1ce7CxxGTI/DRwio6EgkYVA=;
 b=hEM1SCQ/JXUaTAv/eEbQfFL8XfGANGWnhBCJXBR1zI9fPY1n1EE7SyLrlkQ2FRSlqtW/ochTLz01vWhiGeWuMmXD2JSGSg4V+wd3lex2RPgAsfe+3ChQRhJlRReeG/yimETXYzc2KAYyCrraHYQibdxbx3C0R9+wS47mDDOIxXM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 16:49:28 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:49:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Topic: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Index: AQHXY9BFZBFmWOpSekG1W92QMIYbjKsesyqA
Date:   Mon, 21 Jun 2021 16:49:28 +0000
Message-ID: <1669C849-D7DC-46C1-B6B6-F2C79C819710@oracle.com>
References: <20210617232652.264884-1-trondmy@kernel.org>
In-Reply-To: <20210617232652.264884-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbe33596-59d8-4ecb-e16d-08d934d488d2
x-ms-traffictypediagnostic: BY5PR10MB4259:
x-microsoft-antispam-prvs: <BY5PR10MB4259D558408E7E9C5758DD5F930A9@BY5PR10MB4259.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xhx1wi0GoS+zYHHUco81tVMlcG3u1sPxkqpFMYOpN65JcdNcx0KvkQKfo+5mMIPoalk9+nqSiuSuIRmVJXJM865JnSX2TXW6KG911DPsUH0ugdQeXWQ7Gw6FcipH20tcPIMm02jf2Op3jY0lIQwOdOY7KvSk+yvKrjkUejw3LeuyyrwDUmfeEdVc4KziYQxmMA5Lob3JNqw2goPPxfVp3aUDX7T+PndR4Sbl2mlUKXFS8G4aMMpT/46yg9olzlzL0jvsXe3M6sS1t2WWPZPM2z0mZaLs3ToEHmZkUe7AlgsyLoCtC1blGdQJhB3nZrynvJfbv/3ozDN+2yaMMBSCQoWN1SYQCYmnkgW4i3msAh2ccj4fo8KT21rrANEfxPTolWrZ8umFxkvArOt5MmWB960KBE/3aU9yuJlqj1mx62lWdJAjA+fKL+ihvm0CD2Wdx5mQd8/or22ig2UL+qs3z24UJWjY/TX5t/hZ0BJ8TXLmuM+y5f9+mIXxiRBhZm+hRrGaOuE6NyYA8gTBZPmSWmkSzHG+MTQvAlC/JdKutYAsOJighuYHQDpNRPBz3MEWY5Ws35T0T83QjxFODw9JvL0ZDpqqrsEkLlAxFRfqJEseJ3MmZ11A/ip/e4qcAxgO+tGa7zeoDlrH0buTKu7Y07bSHiDzOXyD5fPeDrUN14g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(396003)(39860400002)(8936002)(5660300002)(26005)(6486002)(53546011)(33656002)(2616005)(54906003)(186003)(478600001)(71200400001)(6916009)(6512007)(6506007)(86362001)(8676002)(91956017)(2906002)(66556008)(66946007)(76116006)(4326008)(38100700002)(122000001)(36756003)(83380400001)(316002)(66476007)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EiGrdI1eAZ6wsowz2SfLUatXWiU4/3sBbbs2b0kGL+qEV830vqP1SD4cSfFW?=
 =?us-ascii?Q?9ve51ibrcYiwjSeT8uwgYW10C0KdB0r3J2HGTjOKGmkKT5VLgXj/Thq1vamP?=
 =?us-ascii?Q?m9L6HDEBSarieApC+5ILmi+sLgIxB58cpFoHUX2jAanMJf2rs7AvM97OiK8s?=
 =?us-ascii?Q?zEogtSHqLw66TlS1mbtgF0ZE2JrzFFwcbik8xNzk2PPOqLWe+1jRftspcoZj?=
 =?us-ascii?Q?GVU22UNj11sJAZc9Sea0Qf/BpZfVmk7OIyagHgYt36qGDr51iWjgxoMSM7DV?=
 =?us-ascii?Q?xOddcSPQiD7Gm1SwEovXUL/jdxE2cchJxo7GsQngyCKO6c0i5YRs0fe7YVPm?=
 =?us-ascii?Q?4Bo+KAOuSVjRlUjShRQFUpGLYqp3pL687SsYFiC+SRz3RM4PsK/NrOMAv7xU?=
 =?us-ascii?Q?dxaZjcuOHEDDU0Htm4ozdD9nrnJvQiN5A0rYgaPDL3y2fdX2eluIwSzK8I3N?=
 =?us-ascii?Q?UDtIfbTpYRn1IHBCZFdzgah7jmjuEICImEcEwYb3+TCv3vqhL7d/s4goUDYs?=
 =?us-ascii?Q?wSdBMl/OJnVY0AXORCZzx6WGhBtxf4iiigfPCuyNIoktKhTTnEkfPDGPBVEI?=
 =?us-ascii?Q?qgwkDyxzLKslvRHghOld1eyVknFwx8bA+Cf3dIyWzVoRqnHJeDRtziLVJw0o?=
 =?us-ascii?Q?7YMHYFQm4g0I6Al5U9z+6OPlYUW4DWvPScbGeKgKqPY0johMCE+IkGDzxGGu?=
 =?us-ascii?Q?oD1cZ3NKOu6p5UBqS96L2PIM7+tArAmWTxA8U8n1mZL3RKQGSDYkqbtL8O2W?=
 =?us-ascii?Q?WD6jHvkRzj+H8wM/Ff/HHguy+m4GsKR/+AXeiKir5DK8nGb67V8nx3cnQRcf?=
 =?us-ascii?Q?33NUspDHF3QeekLb0mQeXpssOg+bFYS5q7BEdcJc3isHmg+Ja0FGngi1z/cg?=
 =?us-ascii?Q?ej2NTdJ/HzmfW+W7M5dQI5Am3Md8+kS+Jb55kTVWsG2Svkp3G06nLD5RcPUe?=
 =?us-ascii?Q?KAyJ7OJWC+/IbaNfyXXbLLiakV3rBjHMyQsCYOb1bjJC+L761dFE49/USJ8g?=
 =?us-ascii?Q?AAY7SmeS3E4uzUT5ZIVYek0OO6GBNoAdeRBTfosTgjUAMkFSVR+IVtoKy2H3?=
 =?us-ascii?Q?cY7egsr8J/BUDfG79VyDMQsDoHPlGA7un3OThB3019H8AqxTDEErWBdvlWVH?=
 =?us-ascii?Q?FuwlG+2ipaghzid7fTjL+j+GkLq2A3tDcKRTShLaCZmMp7+wBMV5OTQ1VnOJ?=
 =?us-ascii?Q?9CxAjI8nWwExI2poTK278/xhNl/zuqkc8xjh6GhMfj8ma85gF8iFufki3Qod?=
 =?us-ascii?Q?QnNC/aSiye05VZTsNV4nnq82j/KGv33E+BAFa3ne1AsmhLEsn5P9RpVZMPG1?=
 =?us-ascii?Q?ddyevNpaeSduvx0OLQdvMh1V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD4243EC856C7A4FB69F0935BD8221C4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe33596-59d8-4ecb-e16d-08d934d488d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 16:49:28.2121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gWySM9QxdApi7z0kzxP0U95XjH5KpONFaIv59HtOMWQdquJBO8kGe9RiHTZPhCYVbbQr6XoiUGMdfdbbnYnnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210099
X-Proofpoint-GUID: FFcGULJ8RE6kzmwzMl8aGrRTpKsJN27C
X-Proofpoint-ORIG-GUID: FFcGULJ8RE6kzmwzMl8aGrRTpKsJN27C
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Jun 17, 2021, at 7:26 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> When flushing out the unstable file writes as part of a COMMIT call, try
> to perform most of of the data writes and waits outside the semaphore.
>=20
> This means that if the client is sending the COMMIT as part of a memory
> reclaim operation, then it can continue performing I/O, with contention
> for the lock occurring only once the data sync is finished.
>=20
> Fixes: 5011af4c698a ("nfsd: Fix stable writes")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

The good news is I've found no functional regressions. The bad
news is I haven't seen any difference in performance. Is there
a particular test that I can run to observe improvement?

I wonder about adding a Fixes: tag for a change that the patch
description describes as an optimization.


> ---
> fs/nfsd/vfs.c | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 15adf1f6ab21..46485c04740d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1123,6 +1123,19 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *=
fhp, loff_t offset,
> }
>=20
> #ifdef CONFIG_NFSD_V3
> +static int
> +nfsd_filemap_write_and_wait_range(struct nfsd_file *nf, loff_t offset,
> +				  loff_t end)
> +{
> +	struct address_space *mapping =3D nf->nf_file->f_mapping;
> +	int ret =3D filemap_fdatawrite_range(mapping, offset, end);
> +
> +	if (ret)
> +		return ret;
> +	filemap_fdatawait_range_keep_errors(mapping, offset, end);
> +	return 0;
> +}
> +
> /*
>  * Commit all pending writes to stable storage.
>  *
> @@ -1153,10 +1166,11 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> 	if (err)
> 		goto out;
> 	if (EX_ISSYNC(fhp->fh_export)) {
> -		int err2;
> +		int err2 =3D nfsd_filemap_write_and_wait_range(nf, offset, end);
>=20
> 		down_write(&nf->nf_rwsem);
> -		err2 =3D vfs_fsync_range(nf->nf_file, offset, end, 0);
> +		if (!err2)
> +			err2 =3D vfs_fsync_range(nf->nf_file, offset, end, 0);
> 		switch (err2) {
> 		case 0:
> 			nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
> --=20
> 2.31.1
>=20

--
Chuck Lever



