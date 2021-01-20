Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA69F2FDC2D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 23:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbhATV57 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 16:57:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:39760 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436692AbhATVCi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 16:02:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KKsgJW082253;
        Wed, 20 Jan 2021 21:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TI+iAPkZ8nkUw755oA4wMgroafYC+lr6IGRJDiPgvsQ=;
 b=q60uq1LrysKro8AheQRL7dIvqXPvN93BhCbgp+ln5M9Ilm+Ddw56Pfjfn1br8rRiOITJ
 MjZQRv/vK8Ka5ppGsoTTjAtqxfYsMiVeaWoHnsrCcT0liISMEcp3m1zC6WGCuIv1DAqe
 Xu19S3S1bf00ksx14USgZz+PaHXP7WsQXNPN0l+/6a7d2GhPdEaFcE0QPu7k3hitV3Bs
 IwtzB/rWgf8WjfWCdIW5QkalvmsBbXoXcnGtCls36HT+VAaM7cjyDrQqZ/2EohlqyK6c
 2c0BhEirxGJlSRPvfaVSa66Pemo8Esgx4jfctFRGA7HBQt65ahtahcs6Lmr1QdThwQxQ oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3668qrcf1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 21:01:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KL0gx7132254;
        Wed, 20 Jan 2021 21:01:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3668qvwpp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 21:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJZ35ZpRw53xB23R/mLDhfSkuoQrHclf/wE1akUr90nP+GzxAXf2wdbQpCaVQsPNmOOkACtWsi4QQ1Gyl829xDVLMoUZbEr0Fre+U+GL4dAqBVr7lYtRNyOoghsUjZAii85tc1S9kwpnqkgA/kZ1E9L96HNDck3bbaK5kHw2fZ6lPuE1pnYQ3vouyZ49tDBgxp0TK5Ljjz6CbwquaAz1OOOabd3OgTgD8vYZ7IekWuV0W0lcAM9nPB0CQoLafnd7iHc2mGOTw4pd8VUCH8tE5xB5BkflYuGlZj+G+10RhdHLn/09YDdmienNGfUlJQr4O528IJijEyA4Pk+qUFOW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI+iAPkZ8nkUw755oA4wMgroafYC+lr6IGRJDiPgvsQ=;
 b=GU0nq0NPUAQGVa9ywTlpKVYWu35Q7+4ThMk6EvwlVd8PfJkmnBLFGOJZcxgxAW2CB6+LBRCekyioFhRLQkNiUCzFbrX8zAvyvvqpwIYk5OyTuWRdoq8uqCwDmZrp55kPV1yHroPG+IfUYcmlyLj5h2iXfip7re1wepbKD6pO7ITkJbCGWlx1TVGuz7+bKyuEcHMUDgIdQiRtEenqGJ/dz+Ze1DfCsbUdNH6MUVWCdJhF7Lqj/kiosLLN4zT6VdPzyY77T5J1wTI0xjrSdPfRJow4H8C6hxx+tZ7uQq281tXRiyn7/TNKNV8QUFGH7rIojgEu3M7/hL1YuGVrZFW/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI+iAPkZ8nkUw755oA4wMgroafYC+lr6IGRJDiPgvsQ=;
 b=xzvx8M0JQjibgBvzas+EAFYU/kfnMvhR8ZpMwSvxlRttRbBciUbg47WruvY2Qgny7Yf6yhJj2NPsSlK/+VrywM1qIDYFqQmgUEYLUXC0cGz3edNoCduUYROJyfZspf3Xxq+3x76cH+GJIv+Tu2hTUrRAAGezNixQioi2/9g73HE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2693.namprd10.prod.outlook.com (2603:10b6:a02:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 21:01:53 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 21:01:53 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] nfsd: simplify process_lock
Thread-Topic: [PATCH 2/8] nfsd: simplify process_lock
Thread-Index: AQHW7rNqL60BYk2ML0mnagl6N1r9T6oxAY6A
Date:   Wed, 20 Jan 2021 21:01:53 +0000
Message-ID: <B0EA0C57-443B-4FB5-8E21-4CBA082EF8A6@oracle.com>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
 <1611095729-31104-3-git-send-email-bfields@redhat.com>
In-Reply-To: <1611095729-31104-3-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6310763a-399d-4644-fc14-08d8bd869d6b
x-ms-traffictypediagnostic: BYAPR10MB2693:
x-microsoft-antispam-prvs: <BYAPR10MB26934EBDCE4AC1A464238A1193A29@BYAPR10MB2693.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWz3/p3hVCNcqGkN8SUhCVC5J4RuLGZPQ9lWK/IHlM8Ae+biulxRVmuKYEZIiBiu9k0SeVdrxHb5KgxNqeMiVt4FommnJszV/nrFt2zXt+Mfb/ev3huQK/mPSWyPlCYVmk+q3FkpzeFcM14+yVA1+wRm0leoi5p7fwVkxXj2NVKSm2n6ibvCCQaX+8WjmVmQH7HeWfXP9s4JrajNrpUd5s1IsU762EKbyOwNzASRWGA1bmOPd+XGlYCCKP0yedCcjNR6UVRpr518P0zkuH4bOGv51H8RBz8fPqtoXgilOEYmBgHu8zVGFvdXkqYz4imjX9RkT4jaDGwbwi839UbUT58PV0/SFmCyRBiw3OExcPSKbPCuiFV78wG5klrAmncitKMlEODru4k5rM24PDD4gWBFe0nNJ7/4qrBm7EfrTz83LLIHrkbeF/hC/eTORD951fT8wx/jafLVnq4EnoyCo06jbQZBthtrWkc0ILU39Bue6NFNozbPk7imsV8YqGq6jnxun6N662INwxI1eYt5VGdLmYu9L13J6AzGbmLHgdchQSstBzkjQfidQNYcOQcM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(64756008)(6512007)(26005)(66556008)(66946007)(66446008)(91956017)(2616005)(83380400001)(6506007)(33656002)(86362001)(66476007)(53546011)(186003)(36756003)(8936002)(2906002)(76116006)(316002)(6486002)(6916009)(44832011)(8676002)(71200400001)(5660300002)(508600001)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Hon0x2b2Hkd/6m4dvz4M+iYBH+7Kw+nQioZx957IKLXtMMSnJ89rNnfq2HR0?=
 =?us-ascii?Q?PFAEBdRAyZBeEE0b7Ayf44iKsFUNrMzuDbJ94Gmiyn+1wgYPqvav9F7s6gXr?=
 =?us-ascii?Q?ITyzUPvCzvuTjabC4T/J3vtLcBm4RkCH9UzwRizqIYm7mCqVYJEkzkQedF3Z?=
 =?us-ascii?Q?1CRyIm0g2jbHQHL3bpE5Q37hA0I3/DOlgvIHz/IyC7x0jpdIVNq6duETcpaV?=
 =?us-ascii?Q?VFARoLNvJsjulI6G2/FUJLiXEJwBPUtN434WLDeVjt1gUJrgWyuMPli0dErw?=
 =?us-ascii?Q?ANjO8pciHMKM3f/aL73ItOWqG2HhdS2ai7qdxCH03Xz+dcE5wJRfl7sSs8uj?=
 =?us-ascii?Q?sBf8THmZbW68SXQazVW3q9aK/6OfgJ4ViVtP2AAJsBi9fu2Sq5j/ffcHKF4j?=
 =?us-ascii?Q?wQZtvhUmQVTTxh4QQFIe0Gp0PXGItRJGs+mzk+f0Bdqv+uCMrFLF5Bums6YV?=
 =?us-ascii?Q?lAsNLRJFfj3FNSuoiE2LjsKfI3juMp8ljwLdizrpM1nZy/bN9ii28H9iJ/8f?=
 =?us-ascii?Q?s/5T10Lw+fyxaGWrBmAvNJrkItFCmrd0TvxZg3HMDZ3afpI23b7VC7ps0ncK?=
 =?us-ascii?Q?qcy3FZZWwDxZX3ZBRHkQxP9yKd6B1BsQXqrPmpGnJD4qjqMeOhlkjec4pGxq?=
 =?us-ascii?Q?oqZ5TLslvHGZXH3qTRHxS8SZANo2bNg0apmJ3c7LDwxT0Qxdd47HJQVv+UeU?=
 =?us-ascii?Q?9ZasQqcs/yTxmRW6N+772x0NmM873W7t0tLx4dNxFcMU7FVQR/SdIV5R7TBu?=
 =?us-ascii?Q?uHfmMtYIyom3dgjkQWlpnrvSPAzS8X2FIfFEcU+dC3ZOOYcqVzhYXq+2BJbW?=
 =?us-ascii?Q?S5ARBQSwuqdqCYQ0hRbOThnfodDtNT6ptFeMWjYlJ3rdX75gGzFfpHSq9Qan?=
 =?us-ascii?Q?zoiV+A4Ui1OzKpJmdbTiAFd1OUUZfyE9KhrWji0z8coi+vtAkGzd5QgFzA4p?=
 =?us-ascii?Q?Ut4D3pMnFWKMo6uFiECph/7L4P78q1G1MOKQnAwSAtYzDviNQr4OPnT7qAC0?=
 =?us-ascii?Q?KR7Q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1715AB685759840BA6C8AE20C42596F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6310763a-399d-4644-fc14-08d8bd869d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 21:01:53.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4sOAUjW8MDhbox+35CFiNzfQXLsnfBNCSlidLIUaN74RBWX8rGY+52yvh/GYPMceuxTu8gEpogFGG231DIglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2693
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 19, 2021, at 5:35 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> Similarly, this STALE_CLIENTID check is already handled inside
> preprocess_confirmed_seqid_op().

I can't confirm this claim. Where is clid->cl_boot checked?

Did you mean nfs4_preprocess_confirmed_seqid_op() here?


> (This may cause it to return a different error in some cases where
> there are multiple things wrong; pynfs test SEQ10 regressed on this
> commit because of that, but I think that's the test's fault, and I've
> fixed it separately.)
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 4 ----
> 1 file changed, 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f9f89229dba6..7ea63d7cec4d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6697,10 +6697,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 				&cstate->session->se_client->cl_clientid,
> 				sizeof(clientid_t));
>=20
> -		status =3D nfserr_stale_clientid;
> -		if (STALE_CLIENTID(&lock->lk_new_clientid, nn))
> -			goto out;
> -
> 		/* validate and update open stateid and open seqid */
> 		status =3D nfs4_preprocess_confirmed_seqid_op(cstate,
> 				        lock->lk_new_open_seqid,
> --=20
> 2.29.2
>=20

--
Chuck Lever



