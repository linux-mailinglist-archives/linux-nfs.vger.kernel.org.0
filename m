Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2005E613A5F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiJaPln (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiJaPlZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 11:41:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5BE12085
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 08:41:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VEnxoT024064;
        Mon, 31 Oct 2022 15:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eou5oBs1lUacFX40L2+8Qal1C6UvuI9navfw3/Hu+MQ=;
 b=fgSG1/S3OOpyNlhQ6VljDFa7r4lWjL3trRtBi6AJ4eCPfDRIntJSc5o0A5ZK08TlGU57
 i5oO3pvxd7yT/t99gPElg1yIVAosQFhu0rTBkKo2XXSc6dRMf4+WcbvPZ5eY00NclRSX
 IaKwne7GWyUB481z6p3jORHm1mmkftiRI1zkamLoC4DSWON22UDuHzNxEv8zS0p9PGas
 fT8sX+f9kmxbruI/3iuA0ZR6mIw8ZzSHyMjGVgqu5kAsXfiyphT+8bFS7EpzHeTeV8K5
 7NjVyxqiQI6uxL02ytlZB7KjaPnFNQmUNvTUjgRdOQWBbtdYYkdbpLzhp6DAW6dtJMON Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2v4g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 15:41:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VFIxci030908;
        Mon, 31 Oct 2022 15:41:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9eyu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 15:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw9YirrIdgjtuUYGxEGMz0og97l5xqN23c7G6NfFE+n6qBWVp5Y2xVOb2cYOZbHfntakJbr2hChUUF4OU0jg1FfqoSqaQ0JsWFXFkFDVdZWLK3RS434OyjIvz2Z5Emqg4WS4FAYcNLQcFYZhUDNNGSWuuVUdUL/2PDmL/wuTWLoCX31/hve1hLuqxejTgZLUbogak9bekHU+0AC1nDB4cv+yvs8w6PfAzHgu3DYfosWf9MqgcUEYbpbjeia0/+9Qb5vBtAP3k1445FJWmX3lGkRUQ57iuwCgD1Jr15Vhc7MWE7Fr04DL3eUdVulhf0S37I5vzM0q31oi5VQdadBidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eou5oBs1lUacFX40L2+8Qal1C6UvuI9navfw3/Hu+MQ=;
 b=W6N4dOaeGHt49RW65d/80lGkWxbwPOZb3KhST6+p7SSFmkegl9iDnJtLagHC/LHQacW4xyyjBHTnAlXFBTvf/ie5zCIkYE4l2DzKXRtai7SpTpgVuGoEjxzVPmoBw7x+RsjFU0nPPuDqsoveks41vtfDJTlzPonAXdq7mbfgil6uXmxS2/4QBJNLD062kY3gmeDHxNMiumpIWPdkRwnmqZsypSnNiRgmMLvYRkaBlHA5qxJ8cUSCcVf0KVqsWUDMsW76EasD/y6I4AaVidpOnuoq3ToU/dp+1eIwoBSKAnkaVUHtCZIzOsEKkw4k3KqJaS1XPDxvBiQKm/l61XvI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eou5oBs1lUacFX40L2+8Qal1C6UvuI9navfw3/Hu+MQ=;
 b=Sh8eo9ivF9k+UTXpXEgqk3/qUmdPBnC2F4QPEftQNpFa0TJvG36XuIpFUiekKKzuGKGkr/APRG7fCWc3du8mIpfz9MIeLPG5gxq47JUQvQ9Z8y4ZBQVBYZBMw8i/csYcGL2tDRrCLFC8e4au0rMcterONkDh2ZQJV2k4T+4/hx4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 15:41:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 15:41:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] nfsd: fix net-namespace logic in __nfsd_file_cache_purge
Thread-Topic: [PATCH] nfsd: fix net-namespace logic in __nfsd_file_cache_purge
Thread-Index: AQHY7T58NUg4sXwuC0yflWrruFT13K4oo+yA
Date:   Mon, 31 Oct 2022 15:41:15 +0000
Message-ID: <9E442FA8-8603-4979-BA82-8E25A24A6EF6@oracle.com>
References: <20221031153554.498442-1-jlayton@kernel.org>
In-Reply-To: <20221031153554.498442-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5095:EE_
x-ms-office365-filtering-correlation-id: 2199c455-e22d-4e84-ea94-08dabb5658a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ky/Dlb9oDEidLt7yxDE0kTSpBoOgo8t37o0jyiRVmVoVwO0OAPmYjJ4wVVRy0DgWTE7UNMzGxesF2t97zJVP9RJtF25f0gU0+Lr9vM2kPWI8oCrrVpSj7VW5KRnAM/fcrMv2joQIZwemK0ZymnlDA89kS0fvImiD83AbdCFbMn0i+YqvVEH3/ugAMI3oSMFdAOYP1WAjZ2THf4EXMEFiLLX4lOpCK1C8YKW26M+vEMvO6Q6RxrGrq8OIVIXZ4JNJcXbV+Mn9JHL+HriHuXO90gp9SrueRyur1IRxKfNjMJ4gje4ZYRHn5eahDTQYbmBCKltmSRfUfQV0P63e0lcofUIVXFQU6l5mZXEVtCMz/kRL/Km+Ep8Yrvr/dlULNr0QXb5us4wKqWJjw3rFKM20I9NGsrNrYCfv4yhQpuNRHJiFuZ9EljN2POvklffxrhrnAXCrxcGJ+ERpSYRhJcBSGoGqY6ojOUGNVsMkLUZ650GGs2ztEMVs9pwGdhG9ZT9QUWctvTy2xPfX2QfWv9OiFE0dB9iw9+AiRCzxtNuhmw/mJl59m0NAzloSwMRhxpXoSI34DWcIwb1Kv/wvFYko3FtuwXtTvSSV+m6fJE5PyMSvX8uAVRmKffWCGsAuuzCMq7Z4you5t/EPeKW9E+4V0qJ2FKe0tDshzS5ubBb89KZAyoZRmC24x9GB8Jt6Npj8vsyiSxQodH+upWpsa+gaH5qSVxUsVSoVpwdg6F5WapEEXrszlybc2llwPBphgKNqj50nn+Y76RVLbwXuBk8x+SPmo5bZH0vG0344/UmfjU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(83380400001)(33656002)(6486002)(71200400001)(2906002)(36756003)(122000001)(86362001)(38070700005)(38100700002)(6512007)(53546011)(26005)(2616005)(186003)(5660300002)(66556008)(66446008)(91956017)(66946007)(316002)(64756008)(8676002)(66476007)(76116006)(41300700001)(6506007)(4326008)(8936002)(54906003)(478600001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CcS/l+SmIzaDhTr5dg9rW4BEspoDo53WyVth6ayMGfOCLj+lNTOeulIex/oO?=
 =?us-ascii?Q?Ktd61JNFIw7Ly/3TBhlKgzJkmN4qNqsSU3u6n/KSs/N+PuinG9s2ogKlCeEj?=
 =?us-ascii?Q?ZaQRMAQp6AxPdtli5Abd0hd2CiyTHBQjpR18Xif5NwGHKqLrLDLyokhBSz7r?=
 =?us-ascii?Q?q8V2kzlmByNKitnJXJRWQteltbqGXKXO1ixfoEvgvAKpD7S5O6bxXchDS5jl?=
 =?us-ascii?Q?MCCUClKDTQ3WRvGKL6gcZhum/TRjhUoXvH+1GWb/dh39tx5piEDdcjI0Tae2?=
 =?us-ascii?Q?y+6meMxtIx7fjaX8uSZ0nU8+ob6h3iH+EAlcqiHnmz1bmv2EBzzSiQ2vZv1o?=
 =?us-ascii?Q?uIKHBUjDZcL8lfqSFcb6wa5PeVRmkQPKcjYtpNAGFYyDkCPNbV9/jHpNor1Q?=
 =?us-ascii?Q?xwGJGLOSIFPfO/e5HAFyQD0Ew1abk5Y2dV28G2oFPiKKZX6K/d69d3HV0PtS?=
 =?us-ascii?Q?AS1UtTqIlg8+P9fPK0plGnbgTRDQqYSDaggPvIno7FHQj1Z8652bgfRVzJMp?=
 =?us-ascii?Q?ccmL2RUoWihT28B3IqSQMYqNOA+CwO6uZRYNOOXwqLOQRh47g2Yv06miioLh?=
 =?us-ascii?Q?4ez+BCBfPGPKHcCNw1sQTocri4+AQFz8XBe0uLk8obAXRZviLQzMgTL1WiDO?=
 =?us-ascii?Q?gUFfV107TerFz/CoZgpp+2aJ+mBDsaiBArKSgrxniHlcGPRJcSGVoxdRbQac?=
 =?us-ascii?Q?uhDw1ABPYA66sxHFtKcJZrhJmFdgd1YOZq1aM5+R5NCiib6Lf3xwr11FKwXX?=
 =?us-ascii?Q?lcckgsqtg+Mfdfbn0NlPexphlAuve3SthgeO5cvEXgxfRA0a7rxf/cnQdc73?=
 =?us-ascii?Q?ELfbH2hwWXuSJZ6O5vhGudvPQ0a4sPn05GdmOSMwRw4rg0lIHn9j245x8Z3G?=
 =?us-ascii?Q?i0u/Bgz1rq7amqBHGqKfOsQmbqXGNX7FAyKPngBCfAILsYB2+1iAiOIC3YNE?=
 =?us-ascii?Q?NeFumA2Ss2Z9WIWfH/rTcR/r5ngAlCyiDAoVcoYxEPFckFwfjj50/uvCO+5s?=
 =?us-ascii?Q?45k0wkR5kMt+HWrOk2sZHwf+6WVPm2IK1QRBcIveOORD2L7bFEg51TCwIH+Z?=
 =?us-ascii?Q?jdGadTns2TXfW6xsmRxaaa/H9SMV4S6bUwqgxlJlVxCT811/uEW9rsmqrpfS?=
 =?us-ascii?Q?b6UfOjDZ2Oq+jdqPFeCardozZp9anujRag02XofZFr0eh4xqhhkgW9NBE0Ex?=
 =?us-ascii?Q?/oMqAMXO0AV7oTZwcrPNtbrX+ESxpGl4kmvDEAM9f8/e/n7zXv7xfYxeexJ3?=
 =?us-ascii?Q?6DTmmcC4RkF1fu5f/x/K9XSIP7ftJmG2poqvn7qOtxNzSCcwm+Jk4FKs9kUP?=
 =?us-ascii?Q?hxfWXGDP/z9y9Nac/p1nfNUsg6RW1uVp8qaFB54iZqpU/a9LatdOjjOlbaCh?=
 =?us-ascii?Q?YVzTQ+ENIDlTOGoq5gNfrw2P+V3LNfWmWciyDeKyJBgDvy+Ihj5T1n0F1A/G?=
 =?us-ascii?Q?+kmKhi6xD61CXTpBznnovaaQIdpdSZagC6CHSeE7MDs3D41G2k027JvQRTIe?=
 =?us-ascii?Q?sAbhOsmM0Dpdn407jBxRu5BNGFrzfpVlPv4v4g5AftsXFw3K2j2f08zJjbV9?=
 =?us-ascii?Q?7u5feYckfTjrJqjJudtChZmF6qjvREn0HVMw9TWBgkyQk0l/zGd2ZwyfoAoD?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAD5A6A7B8035545893F1994B19139C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2199c455-e22d-4e84-ea94-08dabb5658a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 15:41:15.4753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQkZ3l3dr5EnOrBP6d/9lALibJ5RxX8Gp4aV8Qpfe9wDu8QI1wRh6ILqYwfcb/exyB/XRGDqvzEd8NSBw+xxCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_17,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310097
X-Proofpoint-ORIG-GUID: bWV0J-uws-4jDt3-XUzswLGNekLvRV4E
X-Proofpoint-GUID: bWV0J-uws-4jDt3-XUzswLGNekLvRV4E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 11:35 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> If the namespace doesn't match the one in "net", then we'll continue,
> but that doesn't cause another rhashtable_walk_next call, so it will
> loop infinitely.
>=20
> Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
> Reported-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 20 +++++++++-----------
> 1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> This should probably go to stable too.

I tried to apply this to for-rc, but the WARN_ON_ONCE logic
has already been removed there. Can you rebase and resend?


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index eeed4ae5b4ad..f9ea89057ae8 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -908,19 +908,17 @@ __nfsd_file_cache_purge(struct net *net)
>=20
> 		nf =3D rhashtable_walk_next(&iter);
> 		while (!IS_ERR_OR_NULL(nf)) {
> -			if (net && nf->nf_net !=3D net)
> -				continue;
> -			del =3D nfsd_file_unhash_and_dispose(nf, &dispose);
> -
> -			/*
> -			 * Deadlock detected! Something marked this entry as
> -			 * unhased, but hasn't removed it from the hash list.
> -			 */
> -			WARN_ON_ONCE(!del);
> -
> +			if (!net || nf->nf_net =3D=3D net) {
> +				del =3D nfsd_file_unhash_and_dispose(nf, &dispose);
> +
> +				/*
> +				 * Deadlock detected! Something marked this entry as
> +				 * unhased, but hasn't removed it from the hash list.
> +				 */
> +				WARN_ON_ONCE(!del);
> +			}
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
> -
> 		rhashtable_walk_stop(&iter);
> 	} while (nf =3D=3D ERR_PTR(-EAGAIN));
> 	rhashtable_walk_exit(&iter);
> --=20
> 2.38.1
>=20

--
Chuck Lever



