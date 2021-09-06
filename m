Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6E401DBD
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Sep 2021 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbhIFPr7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 11:47:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61410 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhIFPr5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 11:47:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 186CU5Rc000311;
        Mon, 6 Sep 2021 15:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A5TTgcCSIgr4f3M2RW2NRX+DbU0gJCJyRdhGue5kszg=;
 b=M28pOtfdPKzS3zVXIlDH88YU5qp7uOf5iQIAinj61VphZZxYmoMGH4VYVLQyclA3dM1c
 FGIcPZbgkHPYXe1HJYdsR035sAWXb7TM2dQl5h4ihcPkihLWT9VTdonvSwMDsBR7kjNO
 mWuw2UFcvd1gcMATdru2Ii+DIY7y9BYcgHtTTqj/eFE99twjK2Yw4UIWEqS4tAMDkiw0
 yJCqOo8dOvfhmtGC5Tu816Jwx3UgFWQ3G2Jduq0FYK+pru2MJ3kpV1RE2JDN6SaVhtHi
 oWqZdSzlMhDuO7wx+D1ocssQCxcjWadbTwxw4NEgiEq5+x0z52jqeIpITj35azkCbMZP wg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=A5TTgcCSIgr4f3M2RW2NRX+DbU0gJCJyRdhGue5kszg=;
 b=CBoW6SGhY4ixs5D/XlQ0QXACTf7xmZ0vG+sl2lqakTaPswmf+HyGhMmtAZeZjhYqdx8p
 vEkGleDWLqZmepPbSjSrjM3gTN+PImR721M9iqaHCOlZxZO96PQn59Xyuej70lTd5LZc
 hWZk/R8Uvkq22N5jeNh4FR/RGR6JTWaxb+Z3mX42PxEZM3oIK1rGEEP9BMbS1MjBVPns
 leT2VtfbeCy0t4UOWY/uWg+9wo4kZhAbelDKav+UWRb0hi5pLY7t0uG+jBBFyH6aUePQ
 cVGrqqxG5QyPcZHKJ3laTRqD6OvpTe4ACnRoZmD6OF0OIMTMl9JomjPNSqHPmqPCbun6 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3avxtqah4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 15:46:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 186FkjDo149876;
        Mon, 6 Sep 2021 15:46:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3030.oracle.com with ESMTP id 3auwwvj2xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 15:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7Baapx07fvIBaPM9RKpoPM+ZcS0pNdadld7jwGnfOX98fVF9NH9Rp/JpRu+MQlXfXLDw2MRINpSRV+HlYwoF9Ev4nPPbDE0KZBOPa/KSyguX6e0nc/46sTBdMYf0acJB1681S1jAGYI1pOq7ENGmHmI/G5PzP20m1P8dqBk8I0jqKZmyID/QU4X0EQIRbVQsQJGrBTavHEvfhUYDH3fnOUNbvhSyGUYzfRg9qdSY2rO6sTFGoOdubxC90hJG7uMyCjML07hSlrZEmQ8ZTVcd439yHzHAMfgmGPQ8esbTvXDlf6OTbQ6uTPFM1v66ovwKm9LaWL7sT1IbroiCTyNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A5TTgcCSIgr4f3M2RW2NRX+DbU0gJCJyRdhGue5kszg=;
 b=DRXqNEVpIkvlO2983UbHat712a+WbOeYw0RZg8ga4UtqG6mhWI5Ni6kHtfMv8CNpjPssWGY0RCnyFuJPN57v/Wsi3Ca0jSvYPunicnOyB5DRI5oM2EZzoL4w2SxTBhjPmyFSgej45UhP2VKOfFNPNMWymmiP59d7mX7bqAutFQAeKs/S+Yh8VX+W8ll9acAMbkxFv2K5fvFA63n7wtJKy00dTmEQeFetukGY7Kxk86KkMVTFRX1n13/omzgI/Fner8piMsxYiGQuITGoes8BX/o0t+bsEiREdYekYjYZMLconEUGnFo7scAdrup0mXKz1Vbf131SWtCNTKB0/PMPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5TTgcCSIgr4f3M2RW2NRX+DbU0gJCJyRdhGue5kszg=;
 b=ptxkxc6rsD9aUMfghWByv4i5NTL7EcXHyYRGl6BYD7Vx5AqXC5b0wqEflvFsuew40evAxfyXjFolCzUSuz7a6t4yealoSeSF1tTQXY3xlrrazE1hU0SF3NW9tg3p955tHbgPeSiMaQb1dxogbwuaxnlpUAfnqFoGIAZy0Wp+nJs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3825.namprd10.prod.outlook.com (2603:10b6:a03:1f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Mon, 6 Sep
 2021 15:46:34 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%7]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 15:46:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mel Gorman <mgorman@suse.com>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Thread-Topic: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
Thread-Index: AQHXotncpaMymYUO4UWd0a8FIk5gVauXJwiA
Date:   Mon, 6 Sep 2021 15:46:34 +0000
Message-ID: <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
In-Reply-To: <163090344807.19339.10071205771966144716@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 102c4454-9120-4391-cd2e-08d9714d811c
x-ms-traffictypediagnostic: BY5PR10MB3825:
x-microsoft-antispam-prvs: <BY5PR10MB382597BA0CBA37BF6D50D43393D29@BY5PR10MB3825.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWnRTfwmAPlpOCtQ7Q6NjSVCoyZV3EKQrCsRMC7GuT0p2ucxOlb/k0TxYuuQNqXX49rTW/ngnCnLPipgbz2PnoduA0qUJl5oLBkTRYc3px5/e7dcLcou2g2uq+Nrf4BQ9ZzavAvBehbSNdBwx9A2oX2JX1AedZx5WIdMyc2MxdZ3lL1LqipsUPrf4/ZON7Aj1X24xzFb1DjzytRUsO15++tHxx/1nhP8wh7oMb9lIxv+71ZqgZdzXTc4Msa1Yj2j3smYtYRD9qz1PUECRNlmJzmJWcLLdi7QUT9uiKP2A3GbV2+oJtwPDy9F/klWyZ4q5r0CxyErFVlGrsX4Pt8kSbl5ooqukq+fIuTKqWKlpXqDNwsvpb3Eq7MisnGr1WtmWq/sNtkuzvJl4tVbg3LYgnn+MrDMG6ZChDuKCo8GQgqHsQ61Si0D/kXFVbuSYS0eScuPfzlBR1Cezh3PATDZ+CLhLbl+sScuwVcG163zoK6/0qW3GwdqaB2RZxiJkkQiVAkZED7+hBKSo+rSHUsRDlCtZRrHx42JTOqPJl4xzR1PBhJCecs1nQvJ8Mw5eS3xl5VAPkJolm9iNckuUrYtTF/Pf/1xqhI7G57bT6R7XOgXCWoWLUkY5A8B6/yapcH5jpZJrnY1Y8iIWFKqQqTQ0F73SGf2wV7zrqYa/wMcnjSSnVijF/Dg3ScDTSHRJRGPDo43h5pMoRwEGuUO94LzfaAnPKO6Oy6FvSItm6g9chX2wp9YgMBpiN5L7aqCOP5m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(6506007)(53546011)(91956017)(33656002)(54906003)(6916009)(83380400001)(2616005)(8936002)(38070700005)(186003)(8676002)(26005)(38100700002)(5660300002)(71200400001)(316002)(36756003)(86362001)(122000001)(76116006)(6512007)(478600001)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(2906002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hu1JpcRNQkujFWeDbHC4s0IW5J/Jq5MRMQbPFD+wvfy6xReQxQsPxv1bNT0k?=
 =?us-ascii?Q?pyr2+HDM1a5ZYYVunbWu0CWz7fhtF2rnEZab+F/5UtDdCXR5Banw8MsLItZQ?=
 =?us-ascii?Q?/RSwfJJ+Ze5VdosYWTbIAi5K7746ERqOO8oqbeLCvTUesZHte461UjggkdJo?=
 =?us-ascii?Q?QDcR2oq7XWmdmWURdIR5WbzF3Ip37p4Z6StAHQdXk1h5MSIwtw8jGWVfTfbj?=
 =?us-ascii?Q?KjC1+oh+wFfp45CfWw3c0brvVzNtjBG0ftxLofPHzVN2zMgzRdk+w5Tu0BGb?=
 =?us-ascii?Q?fEaMJOLIBAD7udtoTWzZeIz5gNBXfNprYn+Ds9EH1lYt71KbThKqrgEIvRJC?=
 =?us-ascii?Q?+l7brmaNFykqfiRcQRscMl+sJbD5wxFn2EtFEy+wPDe5rRtu5MBpsWPROb8t?=
 =?us-ascii?Q?v816YSR62wMJFcz6dLd6oiMOU4709tCtPIMjoAMA/HZNNvH4N/wFG6hgZjvc?=
 =?us-ascii?Q?0eTcEjqxOOPrrm3e2H6uMBFMeyrlEmNuHE9VOsqMx2AOdcBhlxT7FsQpu9IT?=
 =?us-ascii?Q?TIBe/uCyTnZzYrAYpR62gEIJ27AHbctg0vW7ky9m18klRA1lcobz+fwgpLM8?=
 =?us-ascii?Q?LaEruQ5bBOF0dzPQTm1lMDyLOalmCkNlPQhW7BVgCaz96o14AmK+xldJLsdN?=
 =?us-ascii?Q?3X4KpkKPhcCWuO6bzEhhNLKGUWiUYlvmuVsYmIHHR/ka1VvYHxACUf1WRkUU?=
 =?us-ascii?Q?4j4ymZrre0qrMa8gB03cC7+TPsq/AMkKalJgeA0nnBZ0wJO+mwiHE3Tb4iTR?=
 =?us-ascii?Q?bKp+aqZKFWkprERO+LNwIkbhAsIO3zLHGfTTB9TZYZXsiav8gXivfVB0WHRz?=
 =?us-ascii?Q?m82guOCuy4Z8DFqO53vvn7Lg4GTCzvbsOCWIinkaqZQx7TWPhv29wn9EvRZh?=
 =?us-ascii?Q?AENfKiNEClyBoZjenE86GvERk5vrN6SqVVKNwnf1Joa96l9pyvvAS82lzS/P?=
 =?us-ascii?Q?3L/ZVhcrwW4LjgdAtErZFoIXjvl4nnrXEXRMuGfejouEsWUqLNhZZyDsptpw?=
 =?us-ascii?Q?N3w8DEqE9bw1s4DjathjzZYI7QBibTUD63LeXBeyNpdeHfY5ymMz4HB3Yj8N?=
 =?us-ascii?Q?KCiX35pA5ZIws6IcCZdwRUP8AZQF7MTkB7Csy+p28OEU8dLRpRgUm8A8+9VJ?=
 =?us-ascii?Q?gkSCiyX53UW8NfEU6Crxn+EU+4C4/WiBq+V/Q6pm0MGwgvRTTR2Ndfzm1dsF?=
 =?us-ascii?Q?4bvrEyHGY5Uh1loh+9+qOrEiwxbr6xn+6492Vs/uJJJgBHXX5gxStBTjKMgi?=
 =?us-ascii?Q?wBJtwsy5f6dEV386v1c8NlNh5Y0XM11uwF7t5IXWxJ97suH2wlSe1VTHpAr6?=
 =?us-ascii?Q?o9Z0RQREEFP1+p5kbxvtMuxI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE64E98148E20545BB8596662EF7D998@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102c4454-9120-4391-cd2e-08d9714d811c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 15:46:34.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbdGmZ8qTQ+vlljhI5bCYv1HA9PmOBJ4ezvZQSXO4MygBpnEhJ5GuZ5sG4fGJSB8DEfE/8Te1uSauQl4TqT0ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3825
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109060100
X-Proofpoint-GUID: wxzPMwDnDaZQCPMPxImD0K5ftr-V2oCn
X-Proofpoint-ORIG-GUID: wxzPMwDnDaZQCPMPxImD0K5ftr-V2oCn
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

> On Sep 6, 2021, at 12:44 AM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> Many places that need to wait before retrying a memory allocation use
> congestion_wait().  xfs_buf_alloc_pages() is a good example which
> follows a similar pattern to that in svc_alloc_args().
>=20
> It make sense to do the same thing in svc_alloc_args(); This will allow
> the allocation to be retried sooner if some backing device becomes
> non-congested before the timeout.
>=20
> Every call to congestion_wait() in the entire kernel passes BLK_RW_ASYNC
> as the first argument, so we should so.
>=20
> The second argument - an upper limit for waiting - seem fairly
> arbitrary.  Many places use "HZ/50" or "HZ/10".  As there is no obvious
> choice, it seems reasonable to leave the maximum time unchanged.
>=20
> If a service using svc_alloc_args() is terminated, it may now have to
> wait up to the full 500ms before termination completes as
> congestion_wait() cannot be interrupted.  I don't believe this will be a
> problem in practice, though it might be justification for using a
> smaller timeout.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>=20
> I happened to notice this inconsistency between svc_alloc_args() and
> xfs_buf_alloc_pages() despite them doing very similar things, so thought
> I'd send a patch.
>=20
> NeilBrown

When we first considered the alloc_pages_bulk() API, the SUNRPC
patch in that series replaced this schedule_timeout(). Mel
suggested we postpone that to a separate patch. Now is an ideal
time to consider this change again. I've added the MM folks for
expert commentary.

I would rather see a shorter timeout, since that will be less
disruptive in practice and today's systems shouldn't have to wait
that long for free memory to become available. DEFAULT_IO_TIMEOUT
might be a defensible choice -- it will slow down this loop
effectively without adding a significant delay.


> net/sunrpc/svc_xprt.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 796eebf1787d..161433ae0fab 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -10,6 +10,7 @@
> #include <linux/freezer.h>
> #include <linux/kthread.h>
> #include <linux/slab.h>
> +#include <linux/backing-dev.h>
> #include <net/sock.h>
> #include <linux/sunrpc/addr.h>
> #include <linux/sunrpc/stats.h>
> @@ -682,12 +683,10 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> 			/* Made progress, don't sleep yet */
> 			continue;
>=20
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		if (signalled() || kthread_should_stop()) {
> -			set_current_state(TASK_RUNNING);
> +		if (signalled() || kthread_should_stop())
> 			return -EINTR;
> -		}
> -		schedule_timeout(msecs_to_jiffies(500));
> +
> +		congestion_wait(BLK_RW_ASYNC, msecs_to_jiffies(500));
> 	}
> 	rqstp->rq_page_end =3D &rqstp->rq_pages[pages];
> 	rqstp->rq_pages[pages] =3D NULL; /* this might be seen in nfsd_splice_ac=
tor() */
> --=20
> 2.33.0
>=20

--
Chuck Lever



