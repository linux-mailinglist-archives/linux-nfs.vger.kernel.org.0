Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555325A8034
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 16:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiHaOas (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHaOan (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 10:30:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9A71988
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 07:30:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEEUe8022464;
        Wed, 31 Aug 2022 14:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NDK0hZFlHycRJ7sxdvDuqn6QUAt6phhoKaao38dnxMA=;
 b=eTRaVV0iMMBZkfWPjjdBTvfBacb8bfJ+KXWq/CQ9++qhkWoDe8xPqoTDODvj+/GmcgQW
 fZBcL9GMGytDc0RSJomma9koxO1O9YFZfpD4ZCqmvEHwh02z+LO7Gc0qVHRratjhJHnt
 WTtiwIUF078eBghxlwZUCuhr3dmNyvDQBhk7aVvK4Jffn1iM6Zit6HNaywJtk7hhvmNn
 Fzh0rV/DZ0z1BTDRIkt3O6UOXPndPLELVBJEY4LLQnUdEDokcUhOi/fnMkwJjeNNLA0i
 6m1ThLVG1o2zfk+gIbVTkdv2+nqb0JUVJWo03Q7/b2jJnJCNk31pZ2lFFc35xD1ugIA/ DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7avshctp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:30:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEN6Oo014861;
        Wed, 31 Aug 2022 14:30:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79qbdux6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfdYK3PoOssRIaKZIGSFSpF/KhLv30L2fIrtOzvDtZHJlhtyBdDK97UBK3oPwM9ltic4wXPXwoT9lC47HxKym8eRwpGQvMCR0co/BcBUQGzEVriKfi3JPbV7WBNW2eRgsHT5Xu85DzewwSZrOnpPixvUJf2xKu5zuernWwprId/tY20zntH2Yp2iKhZ6iwqI5sP0E7BzQKdxXFcI1/DAgvMY7WFEGMieiihIcHz8PDPwMpAcIhwPbpKBew9fEiEl5Rs+lXfVpS37MkUSV1FpHdaA0ZeLVx8nahSbP/mqB2/C/DoMp7IzXqLmcaRbsFLtvBeyIxQyPFWRWXHl0BaCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDK0hZFlHycRJ7sxdvDuqn6QUAt6phhoKaao38dnxMA=;
 b=oaL8q2NObRyw4BaErgiChu44TjDlRJVe6NCRU62kOr/Q+2BE9Q5/wTgMt3y8cA2ibgccud4nWpUSxRFrnsMDBI+atJKrfYFYW9DeU2EAPCY1Tb9SnF6qxYaLPGQhxFfG5un/3ipnSzDXXtpXtCqF7dEDijiBGSvNDvJySjR+m0uTBbEYsQ2i380HGBKFoNGBbrv35o/kKGppUn3FyLaLxFu2dtDR+f6jm5rJzVHk9A6zlo33TQAqYWHF3gruwOxMhpZp5t6T+tMRDbWH/MJduo/EUG5WDB3PTxd4VBBDvy/aZQo0nuJcTL2Y3G/Z1blUw68WeLj0mtwhQocn2E2MeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDK0hZFlHycRJ7sxdvDuqn6QUAt6phhoKaao38dnxMA=;
 b=reQ+rLTx0VLaykJUDM9Ii5SjUR89JAtbhV1EW/5jd06nLSp9Z6lLD5d2UyHDcBAe/hALzcOmP9woLfFDA/ehSeoqi12sgMVnmz5JB86vVoDgKjS5WkLK2qr7BEyB+5nWlPz9JiBar27JpKuERTmN6MHiHrzuV1x5VI8WSrtcFiI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5971.namprd10.prod.outlook.com (2603:10b6:208:3ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 31 Aug
 2022 14:30:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:30:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYvLpF3IXRGSf70UK3afu6RNBIZ63JEv+A
Date:   Wed, 31 Aug 2022 14:30:34 +0000
Message-ID: <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45475137-11d8-4a97-c952-08da8b5d5d54
x-ms-traffictypediagnostic: IA1PR10MB5971:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NaNEdKQ600iMd2r/IwjkEmqTDFrgRcxOdjUqR0Kz20btFpGCfDcHKDEnG7zpYCSfCrv2fpOf7smeqNRjj9/JdvwwkkNBNDvja3eyMF7y9Q14IYwCPGIqtSJC9PSMfKxdfLEHpU7bSkWD4qIMlyBGo7wPRbNP91rE3O+rh6wFXNjBstnW2JORFpmDibrhG3XpLbGmGGxZ0afmY023ROzu62qNZg/hUVLuO+9QVZ0N9KceO+HqDmYSY4op+CMO84hZaBHuYjuuuPK1b5Ab7YINtRjjggXIbNYJX2Wy1+qiTxwJ0mASz8ZXfsBZ0JU3z3cwa2BuRGkb5Mi+/MaDWjYA57CHSuu1PpeHTY/fKxchOEvLRtFbjZ2dLr1nXmF+WxR4pRPFX0PaEZpfwy5KcPet6YVRNzPC+9sFLDSeoHq19Y4vF+ZUX1LyG6TZmumMZMYECYbw2Aap+5Ce0qG+qBvZfYUdp//QxIhapdw8h+9cscgNS/biQiTnjC5BPGIXSh2SpKS9SH5M+zloc17V9cZBSlqhq9JqOYWCjx9/dQqq6eeAcvroTibqxynwA7Xb56I9Ryhh/OO/gGJf4Fpk86Dme10bhEvX9rxoya6SyEjS7nsobP+YPJybQ6zl7H9M8noI0uMOz+bG/a2Pl2btj71MfPA3gAZkCZXuDmiITighH1qtMVZzsNC9DKaf+Z4x9JFVgeQzrpiJJzPke6okyU7YEQDZ0LCtnaUzGmqQKF/nKnzWrI4sBdzI7kkZRzT0VLzauF0Dwfsdngb9bkVqtXwnh9yvHdiX8BzsRcJ558ZBdLM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(66446008)(6486002)(122000001)(6862004)(33656002)(8676002)(83380400001)(71200400001)(478600001)(36756003)(5660300002)(2906002)(54906003)(86362001)(91956017)(66946007)(8936002)(66476007)(38100700002)(37006003)(2616005)(6636002)(64756008)(38070700005)(6512007)(66556008)(316002)(53546011)(6506007)(4326008)(186003)(41300700001)(76116006)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fgbqPMw7ezpKE2EB3Jq3wl0e7BBQsISMhylEDVpfoJ+vefvSwXU35+70hf+H?=
 =?us-ascii?Q?ZSrev00vAJSpY3RWyCrbDYfxXaAEeC5mq3yo2493yj6wJyfAj2smO6cKNvkn?=
 =?us-ascii?Q?Tv/I63eyX29BfDWJQ8BbDxzg2Z5bS7BEbk/TKZ5wW3iS/LyJO29NXeKl9/2n?=
 =?us-ascii?Q?d8mA5aMlnMSe4nSdbnbDfuukiF70YLraXPubmNjFXzyPr96BB9cNgF81m8yY?=
 =?us-ascii?Q?NZhWJHDEXrOhEh77huMmNUoNbuFJ0v19HZdPlXFlH/EQ8zn5qI3V8xz9sHIS?=
 =?us-ascii?Q?f3EFGlgAxyVRoLvNuyasnhLcgEah53kqdXCMjcw1VUz+G1w5q53rU47LU9y7?=
 =?us-ascii?Q?5a9XQiN+AKx46suKq9UJCKX7cf/et2k5t3UgMOf3cQrffXr1eu2cexTxGYMo?=
 =?us-ascii?Q?AyZ2uH8Co+8aA62g0h+nYCTh8k+0E3o9BSiwgkAzBPm2dMJbQunXmgtrUwt6?=
 =?us-ascii?Q?kSj4q01JfS1xhImc30FxOjg+kTdgtUbH6xHKa1RJoxWYMQlQFQsacoyZ6h2E?=
 =?us-ascii?Q?i2SUE4+K90ykSVLdpwo0o9tbnpme/ErhyUmdgfk8yoVn8ZeV7GLr1/pvWziY?=
 =?us-ascii?Q?/iIOR3dOGsqJtFKqUTXPgufH9lw6UczM67wlr6loqkiQMShG7UVAwwqYemny?=
 =?us-ascii?Q?f6MmA/FpSXutzhJCJ1wlhakcikBUlx8iygR+8WeHlu0Q3yp/DBFm+GHVwpLU?=
 =?us-ascii?Q?CnIaDHrBDKqDTAK0W7qvbpovAiCw578uhHOlJ+Exz/wQqmhLqZV+hvlcJjsD?=
 =?us-ascii?Q?P7OwKD1fKVN+tNxZTwoZ7/7ponUMyay59E68OX44VYCEqcyoJnUVi9bAOiNT?=
 =?us-ascii?Q?MBN4ZqFXvOJ7XHfoGTI+61Bpnazs2OBoXBrfmyQJ+e9hWrITQ4syKvAPSRXK?=
 =?us-ascii?Q?8Bd3TXIWyI3XMnYdyVG5V0c6ZOpfgF3xy43kl7cOKH7ewilxdAu4deOaKHGS?=
 =?us-ascii?Q?SMLYechitBClh3TWRLH3/z6DuFcApTEq1nEi2qOON5/8PRqaKANGeQLbTVTN?=
 =?us-ascii?Q?M0FVdx7PwXRU8DWNj9gyMFNUSwBpx2feSyWdQ5y1kM0WaO+O+acf8eangNcv?=
 =?us-ascii?Q?dyMbX4tMPNfDzk6gL1OhztcuSVjx7q1sCiJyyvXiWG3yfam5S2cSYn3eY68S?=
 =?us-ascii?Q?IH4g4RcRSiXfbt5JQxyvzkYmrqwDCpchkQC9Z19DiRX5pJKj1fB2DafaRT9e?=
 =?us-ascii?Q?r83ryhH7E8PrAb86JMCNIkkdYBqul4YXjruBrWhXLcnjn7cqJQaON7/cG2qY?=
 =?us-ascii?Q?JIdo/JwvOHVyMawIq4+fF6DClUOdu7dpUAoYEzLF7X6fjBeUplUAVeopUJjt?=
 =?us-ascii?Q?06668L2j7EcnX562bY5xKoLbCXZaUGgNLr5dHb4yv1PrrdVLlUcXTbtxVSR5?=
 =?us-ascii?Q?pE+65hrcKQMUFuXpGREur+nJ/wxbqC3im4BiakGkcp8kDuPFqKRs4M59jrms?=
 =?us-ascii?Q?3+6l/KqQX7RqRXuPOUICCq/8XZdTVaDQq4JqUTmXvS71RXRS5rJLVHehlMRr?=
 =?us-ascii?Q?kn7khZoF5zse0Fr69r0J0vD6cPu/jPqKFaBtsT8a/ATAnQ8INJCnYClel0yp?=
 =?us-ascii?Q?Ix0seNwMgDpsX0A9xUBTLa9noAA4INW1Xm15IncZxCMFXf9GMLqSDCB4RSkx?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB040FD966AFC947A9706F36D5D78A68@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45475137-11d8-4a97-c952-08da8b5d5d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 14:30:34.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5PSCp8bnE33XE5kLFJqzVG+tO7g4HLSf+82iWnsJ01L4rEli706hpTPfJp6GwjkTcN9/kLGVcbAWYEiBCVNyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310073
X-Proofpoint-GUID: cqnbGCd1pCbSYpGYXoRxWnWaR4pFNOXa
X-Proofpoint-ORIG-GUID: cqnbGCd1pCbSYpGYXoRxWnWaR4pFNOXa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2022, at 5:48 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add the courtesy client shrinker to react to low memory condition
> triggered by the memory shrinker.
>=20
> On the shrinker's count callback, we increment a callback counter
> and return the number of outstanding courtesy clients. When the
> laundromat runs, it checks if this counter is not zero and starts
> reaping old courtesy clients. The maximum number of clients to be
> reaped is limited to NFSD_CIENT_MAX_TRIM_PER_RUN (128). This limit
> is to prevent the laundromat from spending too much time reaping
> the clients and not processing other tasks in a timely manner.
>=20
> The laundromat is rescheduled to run sooner if it detects low
> low memory condition and there are more clients to reap.
>=20
> On the shrinker's scan callback, we return the number of clients
> That were reaped since the last scan callback. We can not reap
> the clients on the scan callback context since destroying the
> client might require call into the underlying filesystem or other
> subsystems which might allocate memory which can cause deadlock.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |  3 +++
> fs/nfsd/nfs4state.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++=
----
> fs/nfsd/nfsctl.c    |  6 ++++--
> fs/nfsd/nfsd.h      |  9 +++++++--
> 4 files changed, 62 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 2695dff1378a..2a604951623f 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -194,6 +194,9 @@ struct nfsd_net {
> 	int			nfs4_max_clients;
>=20
> 	atomic_t		nfsd_courtesy_client_count;
> +	atomic_t		nfsd_client_shrinker_cb_count;
> +	atomic_t		nfsd_client_shrinker_reapcount;
> +	struct shrinker		nfsd_client_shrinker;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index eaf7b4dcea33..9aed9eed1892 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4343,7 +4343,40 @@ nfsd4_init_slabs(void)
> 	return -ENOMEM;
> }
>=20
> -void nfsd4_init_leases_net(struct nfsd_net *nn)
> +static unsigned long
> +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_contro=
l *sc)

I find it confusing to have a function and a variable with exactly
the same name, especially if they are related. Maybe the variable
name can be nfsd_courtesy_client_num ?


> +{l
> +	struct nfsd_net *nn =3D container_of(shrink,
> +			struct nfsd_net, nfsd_client_shrinker);
> +
> +	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	return (unsigned long)atomic_read(&nn->nfsd_courtesy_client_count);
> +}
> +
> +static unsigned long
> +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control=
 *sc)
> +{
> +	struct nfsd_net *nn =3D container_of(shrink,
> +			struct nfsd_net, nfsd_client_shrinker);
> +	unsigned long cnt;
> +
> +	cnt =3D atomic_read(&nn->nfsd_client_shrinker_reapcount);
> +	atomic_set(&nn->nfsd_client_shrinker_reapcount, 0);
> +	return cnt;
> +}
> +
> +static int
> +nfsd_register_client_shrinker(struct nfsd_net *nn)
> +{
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
> +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +}

Nit: Move this into nfsd4_init_leases_net(). I don't see added
value for having a one-time use helper for this code.


> +
> +int
> +nfsd4_init_leases_net(struct nfsd_net *nn)
> {
> 	struct sysinfo si;
> 	u64 max_clients;
> @@ -4364,6 +4397,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>=20
> 	atomic_set(&nn->nfsd_courtesy_client_count, 0);
> +	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> +	return nfsd_register_client_shrinker(nn);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -5872,12 +5907,17 @@ static void
> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> 				struct laundry_time *lt)
> {
> -	unsigned int maxreap, reapcnt =3D 0;
> +	unsigned int maxreap =3D 0, reapcnt =3D 0;
> +	int cb_cnt;

Nit: Reverse christmas tree, please. cb_cnt goes at the end
of the variable definitions.


> 	struct list_head *pos, *next;
> 	struct nfs4_client *clp;
>=20
> -	maxreap =3D (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clie=
nts) ?
> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
> +	cb_cnt =3D atomic_read(&nn->nfsd_client_shrinker_cb_count);
> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients ||
> +							cb_cnt) {
> +		maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> +	}

I'm not terribly happy with this, but I don't have a better suggestion
at the moment. Let me think about it.


> 	INIT_LIST_HEAD(reaplist);
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> @@ -5903,6 +5943,8 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struc=
t list_head *reaplist,
> 		}
> 	}
> 	spin_unlock(&nn->client_lock);
> +	if (cb_cnt)
> +		atomic_add(reapcnt, &nn->nfsd_client_shrinker_reapcount);
> }
>=20
> static time64_t
> @@ -5943,6 +5985,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 		list_del_init(&clp->cl_lru);
> 		expire_client(clp);
> 	}
> +	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0)
> +		lt.new_timeo =3D NFSD_LAUNDROMAT_MINTIMEOUT;
> 	spin_lock(&state_lock);
> 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> 		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 917fa1892fd2..597a26ad4183 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> 		goto out_idmap_error;
> 	nn->nfsd_versions =3D NULL;
> 	nn->nfsd4_minorversions =3D NULL;
> +	retval =3D nfsd4_init_leases_net(nn);
> +	if (retval)
> +		goto out_drc_error;
> 	retval =3D nfsd_reply_cache_init(nn);
> 	if (retval)
> 		goto out_drc_error;
> -	nfsd4_init_leases_net(nn);
> -
> 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> 	seqlock_init(&nn->writeverf_lock);
>=20
> @@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *ne=
t)
> 	nfsd_idmap_shutdown(net);
> 	nfsd_export_shutdown(net);
> 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> +	nfsd4_leases_net_shutdown(nn);
> }
>=20
> static struct pernet_operations nfsd_net_ops =3D {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 57a468ed85c3..7e05ab7a3532 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -498,7 +498,11 @@ extern void unregister_cld_notifier(void);
> extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> #endif
>=20
> -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> +{
> +	unregister_shrinker(&nn->nfsd_client_shrinker);
> +};

Nit: please move this into nfs4state.c next to nfsd4_init_leases_net().

static inline is used typically for performance-sensitive helpers, and
this adds a dependency on unregister_shrinker in every file that includes
nfsd.h.


> #else /* CONFIG_NFSD_V4 */
> static inline int nfsd4_is_junction(struct dentry *dentry)
> @@ -506,7 +510,8 @@ static inline int nfsd4_is_junction(struct dentry *de=
ntry)
> 	return 0;
> }
>=20
> -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
> +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0;=
 };
> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) { };
>=20
> #define register_cld_notifier() 0
> #define unregister_cld_notifier() do { } while(0)
> --=20
> 2.9.5
>=20

--
Chuck Lever



