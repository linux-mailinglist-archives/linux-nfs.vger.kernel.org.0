Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAE575366
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiGNQue (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiGNQuQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 12:50:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16576140F0
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 09:47:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFqxlN016433;
        Thu, 14 Jul 2022 16:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B0czuWTlhb5LqFMP9l/mulBjFDQSXyrkdvY4k6ZT87E=;
 b=cUbLebUGJVaFw9PwxJoKcWicFmLyo5nNfRoZnANSbpXazZsRNGe7qDr2F7OX2UHGaxn8
 8j6woMnh5QR7RxY1K5wUuFLotcwr92sd0YZ4Q3VIXcUUWtZ9PcyrCo6di+Pb+D3E2qVi
 RNKmxbbMsfMoCPgd3g7/s66VhxbE9eXMQ54T0CooAkNR9m6AkIkiqBfc5dNhxFOAgHz+
 ojcvIbjrk8xFTrhRBlt/LG9zDP4fh4+tfh/3URGtg0Y6QO38oFCjiUNA2hYZ7AxeW2LN
 W95J23EBXSB9vZv+zSXMGX5Vb7DI8pjR+LKZEGAMdIyzP8GWf7FoxxacLEBO/yVEOV7d /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sp7ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 16:47:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EGks1V018738;
        Thu, 14 Jul 2022 16:47:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045rchb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 16:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU0BwNNs18KjCboM137/8c9Tqaid/FU2R5KqNL3KDcesffz+6kKnw3Ay6McOEg1cSCO71Cnubzlvx43JLQ/M2m3Qib3O7XitckVI0leaotK9Kxt5fO40KX6RZ+cU7BAYlnBWqbpaAfg59GYywz0lKXKrw88jrXeIkvMijKJBlv84iZqFGKEVsbVJZWACfqa6Ya1I6zu0UoxUB34zfV+gIh6XthD3maRu3wzMzFtQRWwvEtkqi6AZmc3PFF3lrQR2Ua+F+UKmlQbVaF8K2/TpgqwkwYnWE9SEIvBerTIq1RUO2Srw9Ve66VTlj84YOZztvHEvRfK9Rnz4WPr/wrLKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0czuWTlhb5LqFMP9l/mulBjFDQSXyrkdvY4k6ZT87E=;
 b=WFWyBoG/pSWtuIJ1Nhti1QytZbF5HWwPGe/T43aZ8lE6S2rwHL9UknJIKdz5rh9Ndr8Dd5zL8mwr7A/IpRUrq5m8YE08PvkMaGkCs0NL+Kda9V8c2E7R6C2MFJztWeo/bvYossrUI0USgIpIgw4l5aVOmjbvtJbXmb6jxtZMrjlQxIxCjMBuy0qoypTuNCeKk3KjVoyAdPRXbCrCyFbLGi8uI1AbMzu++LdX6SrFKnmR4Wf8ByanPpoKx+u1ehMYBv24dEVlV1+4Ws8BmZ44rh4YNi/p9MWZDAZhG/jy7nLc4QCgiQH1o+1Vi9RLDFoYA2eO2CbB0oXyitNHgMul4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0czuWTlhb5LqFMP9l/mulBjFDQSXyrkdvY4k6ZT87E=;
 b=CtwOaPxo7Su9ls1r9uO7bcZEWYCPP0JbPraFKTodiFmSDYtsTmTobFL8bMBKBgOIgShaQtQrlfJRqFYaPvowokpFYLrdQ5hncg5G8NNZMOzB9tQo5sKwO30rEtiKeDvh68G2WM8DH89uyui83WCQFEzkAz/sXKncfvlWuCr/f2E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB3877.namprd10.prod.outlook.com (2603:10b6:610:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 16:47:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.015; Thu, 14 Jul 2022
 16:47:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] nfsd: rework arguments to nfs4_set_delegation
Thread-Topic: [RFC PATCH 2/3] nfsd: rework arguments to nfs4_set_delegation
Thread-Index: AQHYl5ZdeROx4s5Ma02JTduV4JOwj61+E5GA
Date:   Thu, 14 Jul 2022 16:47:16 +0000
Message-ID: <CDD9B96C-3CFC-4BA5-A71C-6C2BFAC2B227@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
 <20220714152819.128276-3-jlayton@kernel.org>
In-Reply-To: <20220714152819.128276-3-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f15484e0-2565-41fd-0d82-08da65b8825f
x-ms-traffictypediagnostic: CH2PR10MB3877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlGw10w7EWxM/gQIQZAdqOBSjLwMOuqPvhH6XEWigjwVEhH6z+CawgX2F46DxOE+D1DcQPKHGHU8oCSq+bXMqgMNFbSfoN24gcwscZg348mNzrIpniY2V9gARNEDNA8K6vL3yfG1GLFNLSXy0gTMX9qDMnJlBmtIh6AR4NZ6JfoR9Jd1yik+HaZOBiz0c16veC4m3A2+oDBGPfLFdUItQ6Z7LxYWnT1fsdNYwSzc63s/5xNOxDbzxi7g7XMy361iauUw0l5BfySXR20ur0vTEWvG9my5nePCAp4dJWZ9N4qUvNb28a+vZ91zkUF6zLcMJxgiQxf927Sb8uuWvmwpDGroV14q7DQMslHI6AShbYMrWNADoaer55DnPEIW4gKus8shcXHAMvTBLoH75nW40LPl1vc1pE6RIP1/d1cU9Uraj0CurAQ0Cam04pHlF5m23k4ClNn9XqvzQGtD0aoYlwFsWQTBGEMthpFG2cf9rL1Pj0UYmus8toWr3Np3dywI0zPNBp0+lneYDrR6DA2FAQNWNEI18r2oM+Nm0dWe7ePSmgwF+3KSHssN/KZ7J0tj8MyG+4LhU3hIbxXRC9qpMOSFLLNkMPuI3RQb00tLhJR529tPFDc0d1vpDq0mio7DGQOiT/HEnPCjWqahHuXbr8x0rLKtZwifEYdKA9kfq6ddoq/gJX6k+zokpC+e9+w7AgnQARlfvlaweDlU8WVXxRh9FTcPHGoHdLBY0VMtSCINk9KI3UZC+iW81VsNHH9uPdiN22DJnsUdm7KarJ0hVib8HLN/eFwXAv//+C0p+CIaY2gd2iQbvUKgPJIbzldgXM38svdHCZvYQtcQuLAl0Iiq8KZWXUgbWrTeiiD3xac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(39860400002)(366004)(376002)(54906003)(6916009)(53546011)(26005)(41300700001)(6512007)(6506007)(2616005)(186003)(36756003)(33656002)(6486002)(71200400001)(316002)(8936002)(122000001)(8676002)(4326008)(64756008)(66446008)(66556008)(91956017)(38100700002)(76116006)(66476007)(66946007)(86362001)(5660300002)(478600001)(83380400001)(2906002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jdYcmZ/z0ejnWAWqss4uW6uYesOOPHzBgEqe7m8pCELg1rCMCx83N4i8LOYr?=
 =?us-ascii?Q?kmnma/81JZp/WJBcgR3OveCdBT7yRiEk5I8QHQdGqdHmpZN0tpKSxuEnrMLM?=
 =?us-ascii?Q?SSYzIOmx5R247GRplF/e+SujsOgWFOZiHtcnDvBHybDDN3MpJukkV9ulgHR9?=
 =?us-ascii?Q?kh5EogbUWKpdcXiF3vMod17Q7qu6fgqHyDAYW4WbZS/T6BHKJ834I9v7xajE?=
 =?us-ascii?Q?Vi/nTX6QYF38SxaSclFMdgGLERDyu5P4/BZ6LhGizcCDFKeILryq0Pl/kI16?=
 =?us-ascii?Q?wh1IGmiDgUY8tGbgH7wYswL/i6vZLj61lWsaxpUKhyLyKjfr33HUTYQSBcyN?=
 =?us-ascii?Q?0tLcA8L7M/i5fW2VcikemT0iIZpYw+Ps0WjvexMaNVzgE5qi+Vq26uKvlzRB?=
 =?us-ascii?Q?E7HwU6dkjWZ2BPguwHAClbVUOsGGhRzQJjfjmrjTRi1hNsAXHsxmb2ohvzB8?=
 =?us-ascii?Q?J4L4vo6eqdhIP67GL86ed/EEHowq7XA9GEJbit1CXmptv3TgHeW0U/happKR?=
 =?us-ascii?Q?eSHbXlxtkCkpH776adih4lCEgWMsvpGw/cyUuPAn5oR4Xk+n6S4Eqj+THZvD?=
 =?us-ascii?Q?xs0oz7+aZCmS08WJySuNGNuPEiYKcuUQPLWLvyreTb8ORdkh892yh2b5nl45?=
 =?us-ascii?Q?/EIlWEsy9pFPs3loT5H9ktHgIPiJg5r/R47pk5XIdm5BbWJbJmHGrSv9DorG?=
 =?us-ascii?Q?Z1j0wbtd+5suwkN/u7RLg04G6IIHO2q/El8lTfk4FnE0XPB1gHWuJycEzoEb?=
 =?us-ascii?Q?FBScuig10Wmc9MWNkZDzGAbOOdzgnuX0yGXVdZsSXhOoJnSwhgTD5TOHh34p?=
 =?us-ascii?Q?TzJdDOzSv0wNd4ZeCPgTyBBJwfpYA4QghfiYGO5oK/GJ6Xf3hkapJNKPbePP?=
 =?us-ascii?Q?59pmGCOykU3C+3CMQlsJcPzWx5s3wygelJUtmGJeiVQmMc8ti8/Q1lDqSsTV?=
 =?us-ascii?Q?LWqf1T8moEvtcn/NU34IY5mXatn3eJgIk9aPf7c/Aa0agl9YH4hCnibd9QQd?=
 =?us-ascii?Q?3mVSP7tnXRbR7UVJOpyQzhhAyenQhhaKzEOWgsoT7DvC8t0WLvDFLCoPlj1f?=
 =?us-ascii?Q?FKg6+k/kZpC8UHww7CjvT4pkz4a0o5V2wmLd4jp68JvMn35vwZo+UUkrmttn?=
 =?us-ascii?Q?Xy/p7SCLkUYMhowUOjIstC3XqfvKRUtHGMX6UL7aRA31VQAo5U9Ill/C0/Ph?=
 =?us-ascii?Q?Y44RsFityfLJYGU/uVJQPMy8bEvA5CvmUjE7vNYgJPkG6UuKXW5qF48exm/Z?=
 =?us-ascii?Q?9WD6QsZbV56W6RIl8o0aD/SYkAM2XxUhOeqBeYP3yU1qxcZiNCmSVXxVQGIm?=
 =?us-ascii?Q?/iYrYgZccoTtvOAoe6y5SXb01OXgsrO/hBBaP7ZnwDuLnF3De/o4mJoyTk0n?=
 =?us-ascii?Q?PswjXsslqo5YULociSTWQb1chiwy5Frpj1/LBKeT9BMZKEZ/LP/x8qvuDGY+?=
 =?us-ascii?Q?3Pufcfv5e6anfT0rYJtkwLvnWl8O1nSRffCPXi2XfK/S4rK9Yp9U7GsOP4iz?=
 =?us-ascii?Q?4bUgdLFgWvHUYQaVNp/n7F/e3gQVuN9RNTFR18ZSLOl7KGhVdeWonQCsxIlA?=
 =?us-ascii?Q?kgySkV7uZuXKKqkixFMdFTd84+PcfaY0vOFP1Bxs8NnvdHDhStxJbpnuTvqq?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA54BF214ECB894EAC8241B254AB3461@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15484e0-2565-41fd-0d82-08da65b8825f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 16:47:16.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKjNsWxBTdUYrCe49efJb5Z0ySh9HOSp93bD9U5r7sMhKBqDamAjBtv86Xzj9bqMeD8GymZP8iY/d7H1h7TOGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3877
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_14:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140072
X-Proofpoint-ORIG-GUID: hLu1xtjhDqlAu6XoCFj7QaDwT-myUjCu
X-Proofpoint-GUID: hLu1xtjhDqlAu6XoCFj7QaDwT-myUjCu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> We'll need the nfs4_open to vet the filename. Change nfs4_set_delegation
> to take the same arguments are nfs4_open_delegation.

^are^as

Nit: Considering that in the next patch you change the synopsis of
nfs4_open_delegation again but not nfs4_set_delegation, this
description causes a little whiplash.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4state.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4f81c0bbd27b..347794028c98 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5260,10 +5260,12 @@ static int nfsd4_check_conflicting_opens(struct n=
fs4_client *clp,
> }
>=20
> static struct nfs4_delegation *
> -nfs4_set_delegation(struct nfs4_client *clp,
> -		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
> +nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp=
)
> {
> 	int status =3D 0;
> +	struct nfs4_client *clp =3D stp->st_stid.sc_client;
> +	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> +	struct nfs4_clnt_odstate *odstate =3D stp->st_clnt_odstate;
> 	struct nfs4_delegation *dp;
> 	struct nfsd_file *nf;
> 	struct file_lock *fl;
> @@ -5405,7 +5407,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp)
> 		default:
> 			goto out_no_deleg;
> 	}
> -	dp =3D nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odst=
ate);
> +	dp =3D nfs4_set_delegation(open, stp);
> 	if (IS_ERR(dp))
> 		goto out_no_deleg;
>=20
> --=20
> 2.36.1
>=20

--
Chuck Lever



