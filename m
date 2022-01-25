Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8604749BCB4
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 21:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiAYUIj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 15:08:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19830 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231397AbiAYUI0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 15:08:26 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJDd9D024951;
        Tue, 25 Jan 2022 20:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0hkYR/m+UVMz31v7rYFSQRXmPDJjEruNxwCpWiTzpqA=;
 b=dY9Pp1Ah6Gdkr3Gzp0P3rBuLGuYTmE4cv93ZWn7T0t+9O2qO15n3HYfvHq7X9t2Pr5m8
 X3SNwVeiKJl9gQ5V1DSPfQNbAVksaYP2s0tIlgUNwoJo9BDEwkJDC77jPR2zyPAbr3BZ
 kYHsB2fzgc4me6DMPgk6DHE+v0KkFkA7ZdQtDTpLh9BoYo3N8uu8MfKVz8/lx1MKXhgE
 HL+6vfGjPBLaEV6PJqngE++btbKtdiB7XLZAokrtCzS0xa8EYgeKPSjSJj2gZv3hABXu
 ymCgnVc1ORQ2WceFWP/iyutwCRUlAAOvBvRbcq5LaMMDmdmxNfu2g/Z2HMGwwnheKgRP Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7av9yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 20:08:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PK10e6008653;
        Tue, 25 Jan 2022 20:08:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3030.oracle.com with ESMTP id 3dr71ypy4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 20:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpvGcvcSd7tsYSPJ4WwfPEyOgMtXAGRQW2FjJCfR2Lyp6MbIievg777ewCbR+H1GiMwzNAJybaZBZh8GS6r8s9UnAdK0hzgHHbfLbOEoTSl25LmTvZR+AES/6QRHguE8/Nzy+bH+LkhP8t0IMmt15UM+qxbJZOkvB/4M4GUihxuksAkTpWdWVj9lIOe3PrhqampnJT5lxuo8Z4UHIJc/ER7ijOoQ6BIseTwBbTAL7P+uyjm6bx1oSsJVHMsxRSfYwk1Jn0EwJLPf2kQc0SKisI7OUxNnLjiytwX2XMmacXLhJWkwqWDwHRRwRsMMz8L8N1Ot56TMiKsvb76Z/w4JBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hkYR/m+UVMz31v7rYFSQRXmPDJjEruNxwCpWiTzpqA=;
 b=CWLREEsr3bIngAppqUZMz/etgCc8kBjdEXbVoIU0RDmGCl1UIRdaQcCSIJhUmu16nCkNf8GoDQFTDkaon6qHlKoxjsAyjuskEEA6ZCXHRkP9aHje9rZ5ljVuHFxQRDYtS3FE7lzoEpfMQlKL10MeQzLyfqxhPWFGhMevukw2N/zTXj2alw56FftPomADl9UL1o1n6BixwrIF6Rqfda93JFWOQ9zsIEPHSukRjnGAWDZMv/02zCAuwOCt4qXh5rzzwQ+0juKyW2XI5QnPpEnIGyk1wL9avBGgU0lamOrNaENW0Lw0axCYgAA1OM70dVxU4OMXkd2xvIN8/ojxWBIuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hkYR/m+UVMz31v7rYFSQRXmPDJjEruNxwCpWiTzpqA=;
 b=ySyTzoZGqajp//MldKTXJG8CyRvpHn7auM37CtGrq7x/EQg35EY++A31XoMNj3ruJ/8epbAPnIYeTSpeeg6KTLcs7qI92DDTrRDGfqbaDoQjEEeDmLWpvgEFfXLelGEzkGjKakBVORjq4C51PTl6GyfUbHvs2kg5LOhJuATr9Bw=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BY5PR10MB3889.namprd10.prod.outlook.com (2603:10b6:a03:1b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 20:08:21 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 20:08:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dan Aloni <dan.aloni@vastdata.com>
Subject: Re: [PATCH] xprtrdma: fix pointer derefs in error cases of
 rpcrdma_ep_create
Thread-Topic: [PATCH] xprtrdma: fix pointer derefs in error cases of
 rpcrdma_ep_create
Thread-Index: AQHYEicZS9bK0SAADUGGLcqWd8KJUax0KkoA
Date:   Tue, 25 Jan 2022 20:08:21 +0000
Message-ID: <C8A622F7-9AE0-4F4C-B35A-4B673DB847C7@oracle.com>
References: <48846140-72B7-4B4A-8948-6F35F1670FCD@oracle.com>
 <20220125200646.3002061-1-dan.aloni@vastdata.com>
In-Reply-To: <20220125200646.3002061-1-dan.aloni@vastdata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b462ef3-a7a7-4fae-7c7e-08d9e03e6f79
x-ms-traffictypediagnostic: BY5PR10MB3889:EE_
x-microsoft-antispam-prvs: <BY5PR10MB38897B3314A58093A3324097935F9@BY5PR10MB3889.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:117;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uhm2uDFNCr64BKhAqYQU4KAk8Chzlf4S4ayOMl/TpYwtnw3J52k7KlZAFSAidN+G5GhBxHMMUiMCRtirSdxdOyUeyeq1IPLVT+R1eFV5ac2pwsXC28sJD4cnozJIDNuw3cSwFrgxNFFZZPtsVvfo4V95ybFSnpioKvockkcWIwF1569gdqmjk/5a9p5asvk7ANoTCVWZCZW+YzIOz60xUPZ1RGquNDCvMhSXzY511uUyAJNJNWaj6TRUfiwgzhqrwZZjvhI6hqpT8nFtRNg2pqQctVvG29y/RFK0IOkJyD2IQL7G2lqjRxXg5/2w7325+0ePBFtGzAOikceIL5NxzS9oi8wdSMiKOv/Sp3pFfEq/Nt7kS84XqWg2cnDJ3Rfd8nbhleOiwcjw6rCIpVgjFF3DP6/gYWptLFHGgZedP2XUqfLySkJnrz5lm9V964y1dXdkiGomw2aoFo4JwaPJTfmY6m3JZuL5D1pep/OfmQU5wwgghZqYl6kC8D9uS8F2wqufeNjePPOpcTA/8IMk/qU8xEpTiHG2M9WHiwhu1FP7WuoqEQ8QRngBOZ5NzMgfHMEQYsOLTNVaDdAhVRqJIVzCqYPUK0Ah51V3ptdlk1umWokWWlqRO72XW6ZiTREEsyWrvbEb/LfT9+bvdz8bidnPmy0MhW57Pr4qIT1AR84Z2wug2UGJMOy0h0SdFN77uNIw0zvGnuKvWrSIAH4nfafh+/cGyuhkuYJOA0MsMeY9ZXKWc5ORu/0AtluEjHn7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(76116006)(6916009)(5660300002)(6512007)(316002)(2906002)(53546011)(6506007)(36756003)(71200400001)(54906003)(64756008)(66476007)(66446008)(86362001)(66556008)(83380400001)(66946007)(508600001)(2616005)(38070700005)(4326008)(33656002)(6486002)(186003)(8676002)(122000001)(26005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xjpIBRnItOcWxF0N/JDXs2H7YHoSOxz7Y1dYPS+bYCMWsBpfBfoXtInvnYj1?=
 =?us-ascii?Q?xCgW4TrRqIWiQHBmMZszkk9Vi2Sxpn4pNmK1MckEh2EIeKFvAwzP6j5swep+?=
 =?us-ascii?Q?3+5HpPvdPcnBFPu+T5++lb28c8XS0vMeedUXgaJcQCJA8x0lSQm7iffLW9h1?=
 =?us-ascii?Q?2PmDt8C3aDJ1CeucYJonGgnzLRyNkzb05vahHgkNCOnZg7Cmz0dlRl8GTc40?=
 =?us-ascii?Q?CwR58YH+zKY6u9Ukk9qJbzyxFC13MdPQIST3PMz/W/7I6+9iYN67559EbUur?=
 =?us-ascii?Q?HghYi+Tl6WXkdpUzfAt+ODcwm8wjSwft3dmAZ9Y0apOAxo7DE7kMqZzwLo3J?=
 =?us-ascii?Q?T9GANfZwMHfWEKqKaiUzvptAJIZls8MaKRYtl0HBjnglCY04hGwKKY0qkH/N?=
 =?us-ascii?Q?Bn/lGMu6V/f706smH7EkOY9vaKz1MOyyPo4U2jDp92MFYuiyTNSk+mIZ2upe?=
 =?us-ascii?Q?fxtB3mpem6CZ5VJf5mdGW6Odcb1NxwpAoSwSLqtqJOWODJAzPdHZ3HcvWJdf?=
 =?us-ascii?Q?5h8xbpMEj+cNsyYi2RalmCJpKvnjLczjFv4zXcBVbGKwk/LD5WIKfx8saGZq?=
 =?us-ascii?Q?s2oKtza7soYQXOM9Pg/RWue4SmWrPmutGEmDDvVoLLRhfXzTmTr2QuaRBi70?=
 =?us-ascii?Q?Ev15bOoMcGBGvI9Tbyt9wnVci1fvpN0VsBhW8CjV8VjcuyPWk1/UNaDCeTLQ?=
 =?us-ascii?Q?j/xWMLyhwTn62xeolN1vulvqq+L7bMxdQANrkBPUpz4hWDUKLmUVTbst0gaJ?=
 =?us-ascii?Q?eaGcPOH4gx1AaDSTTwgmTBE5uWNC1Oq7XhCMQC/dWgzp+QhOn0G2jDSSMhDQ?=
 =?us-ascii?Q?7vmOp/n+ha3+aLTrE0reKg13iurSwDTJlwg2+tKJveCQHWfoAUGJ0+Za3I05?=
 =?us-ascii?Q?RO9zZE8hdlvjIUidpFWq03w0UGXikxCgDs1pengWsHQJZbCVYnTAfu1kaWkO?=
 =?us-ascii?Q?LuIm2VvzilIfxBMTUzg6U56P9/6scFj/woZmsiXUTwdu3cFaQhspApgcRXbh?=
 =?us-ascii?Q?Q26kD1F/2sHizaWbfcI/Lf3pK3gcGTNI+QeE1+u9+smBnOEr4xjbGIhC08kW?=
 =?us-ascii?Q?+dn96yFMFkgQ//ijf3qDGv63ff+Q6W57Y67YcarMROaVz2nZrd7uXR8j1yRV?=
 =?us-ascii?Q?LSpf1kHtJzHFMHzoZlF8GYKGRX85DCZzyyyoxXUxtClWYnYnFtp8qcM5D2EM?=
 =?us-ascii?Q?6B5/2Gv6QKCNcdZjdg9sIQMcgcEZmq2xKLwMIXPogCECNbYUGlnEunUv5FRk?=
 =?us-ascii?Q?9LqqWCAAQCVeuMFfxTX8ittfeSuvx1aC3TTe6xex5k+/n7/GXEPggKikoGOG?=
 =?us-ascii?Q?R+axhVQP/85tbq5Or6ICYSI6TgUSqwnMrBmUkqgAAmVhDUStssejQ03UpU6i?=
 =?us-ascii?Q?ECIqXG3mVQUOIxBpO71AdRYd7Z4Xyee0GndlN31fzxVJLxXaDpNFNlt2Eyt8?=
 =?us-ascii?Q?EgFDgOryQdiBzYepxCUzJW6dS8vSGXF0++HIOH0qHV5H0s5PecpHdPkOAbnt?=
 =?us-ascii?Q?a3oFAA+TlPUzFGgJ/tvc21uXAEAOwtKwU5YL9gN0mIi+XLcpETt1OWiPfWrD?=
 =?us-ascii?Q?K6F09GAvq3urQihKTpkLHxWewKsxr2l/y1Ohdz+BYod9zc0qL3P1GDRrPF+m?=
 =?us-ascii?Q?xRKCsuB+xtSvW5p9/8Q9bx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <859F8746F0079D4599695B121A2E8821@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b462ef3-a7a7-4fae-7c7e-08d9e03e6f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 20:08:21.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7fJnOEudSC5saB7XCTM3ZnO03JeJ+u4Ip6l00O0Ag6TZwkR59ayrgDVTowtOi58GcesqdBfZ5FSJX5dMhE9SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3889
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250120
X-Proofpoint-GUID: NdT0T8JwOG8kgaWMDTGcHwzALnXxl5bg
X-Proofpoint-ORIG-GUID: NdT0T8JwOG8kgaWMDTGcHwzALnXxl5bg
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

> On Jan 25, 2022, at 3:06 PM, Dan Aloni <dan.aloni@vastdata.com> wrote:
>=20
> If there are failures then we must not leave the non-NULL pointers with
> the error value, otherwise `rpcrdma_ep_destroy` gets confused and tries
> free them, resulting in an Oops.
>=20
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> net/sunrpc/xprtrdma/verbs.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 3d3673ba9e1e..2a2e1514ac79 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -436,6 +436,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_x=
prt)
> 					      IB_POLL_WORKQUEUE);
> 	if (IS_ERR(ep->re_attr.send_cq)) {
> 		rc =3D PTR_ERR(ep->re_attr.send_cq);
> +		ep->re_attr.send_cq =3D NULL;
> 		goto out_destroy;
> 	}
>=20
> @@ -444,6 +445,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_x=
prt)
> 					      IB_POLL_WORKQUEUE);
> 	if (IS_ERR(ep->re_attr.recv_cq)) {
> 		rc =3D PTR_ERR(ep->re_attr.recv_cq);
> +		ep->re_attr.recv_cq =3D NULL;
> 		goto out_destroy;
> 	}
> 	ep->re_receive_count =3D 0;
> @@ -482,6 +484,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_x=
prt)
> 	ep->re_pd =3D ib_alloc_pd(device, 0);
> 	if (IS_ERR(ep->re_pd)) {
> 		rc =3D PTR_ERR(ep->re_pd);
> +		ep->re_pd =3D NULL;
> 		goto out_destroy;
> 	}
>=20
> --=20
> 2.23.0
>=20

--
Chuck Lever



