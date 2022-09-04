Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC45AC639
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiIDTp5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDTp4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 15:45:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0FA29CAF
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 12:45:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284CRodb007403;
        Sun, 4 Sep 2022 19:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qA+6q1m9AXduCVmRsGtBmtEDuAtOsXaEJFBYRgkn4S0=;
 b=gOn0vhKmJ6l56LQP3elCjlEns/m4SJs/8xHJWXo/EDmZwaWIa7pSsTGIxUgY6bTprMzR
 g3M1sNOLkEJcB8TrDeqkP7l4LzM6eFv9YNJTtXJaMNlYGP3WOr+PMNOEFW/L3Tih6bqD
 B0lWuE6bA1VkzNuGLGYyHjxd+GlW9NkFfw8Yn6wFnJ5TwOvIVWDrV04bhZyaZVahwTUb
 qCW712/PDy8Ak8aFOGpmApmLAbGP9opVgsf40Z2fKlk+0sy5PgLO7/tTmCtZYVEh/wtt
 u8WRQvtPT/3bQn3yVRT63XwzplW+2oK0jSyisTX4PTD1Yy8py+UiMspeCK6H7xrZeQGa 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftj0jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 19:45:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 284De3Ac017125;
        Sun, 4 Sep 2022 19:45:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc7dbaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 19:45:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDURZq2hVHc4kbxS2cakPfFV4Hpt8YO53jipfSdaURRhHakaXKqxIQH6I+PVjvQQpgffBUoveeCIEixaTyhHXgbc/DMghV5w2//gHe4+2FZMLQvjYy+OpM+W2HO1STMh/EDaxZsLuGnZhQ6f7urNNapStU6rDxj+VQWvnBu2zH8U3xnkzs9b7qsx/MzTifsAZ53Do7LuqmactIlHI0TF8HOp4AWRT67gf8XkbYk2n2d+pXzmntYEVYzudtWiUnSvaEiIpmEGPlYMkwzVHCGHuKykDasVCdJJrzyAgi3aPLyrhkovR2sZfjLYOWnAWVrZJfoKScGvdXvA4bcL2enIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA+6q1m9AXduCVmRsGtBmtEDuAtOsXaEJFBYRgkn4S0=;
 b=lFzTR2MEDR/AywbxJ3tmK6ogGncyqaK+OK5L/TLhuGdlIz2y/W0P+FuvEUFJwRm+ujvq6gsuLHOJqqo1GTmORfMqGt3y2vzJiChQsSN0AD4T3zKmstLqPsSr3l75mt+RBNupMb+2LY5EHwkqT9gIUVaFRnUJM4RKVqZ84+g7KWtYkzwJcDmhdEP6YBmc6X9+yt1trQTbQMLn/yHwgLXJtyJEp7GvCd+MnlMYih8xM6o3zcWhLguQapPMxjQR+2NA/AsD9tUWxAWO0WreC/fBbrLS4aThmtKQbRv7bkWumEsvUOKwWrNm7d8Fv5JO6/kI7Awhf6pyjRQzuqNqSXKpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA+6q1m9AXduCVmRsGtBmtEDuAtOsXaEJFBYRgkn4S0=;
 b=peSCCTPAPnNb4H9Fo0WT81rZIbsCXMo5CLfPMpjonPLd38HKT40iGxVGkUMWGtiI2SCp5BYQIB3X6rMlyUgiYpAxtejxUdV/konU2gxNsmZkNZL3igFuyW0z6bfg5Lcpl07TqH/iDSgurAxLQ8+bMd/nid8Xy0s+rA1X+TXpaAI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sun, 4 Sep
 2022 19:45:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Sun, 4 Sep 2022
 19:45:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v5 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYwIOuUqvUBO3RNkmB+TFB9mt5Uq3PrNOA
Date:   Sun, 4 Sep 2022 19:45:47 +0000
Message-ID: <213CA9C6-2C64-4F8A-B86E-E2CB54B184F0@oracle.com>
References: <1662312472-23981-1-git-send-email-dai.ngo@oracle.com>
 <1662312472-23981-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1662312472-23981-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77cad0a5-00d9-42d1-b4d7-08da8eae1050
x-ms-traffictypediagnostic: IA1PR10MB6783:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8n34Z81qKJ3zPQdUwpJ8pOlWi7Cf36Vau7dmUKMvUlJ73I3EddCVB8rhRcAztaae5KqrduhQvqMEGvEPcNfkD238ES5WyF9r1PLtc0uUh1OwiansuyUPUp0Q/LPUlNl+q/se/6ZbZA10cqj/1nd6xmIz1Y4n9QeRev3XBs67rwh9N60SdIGvYJYnSYPQOOgCGmxlMXzkKSbsWUZ1LQzUPIJFNk8T/IK+9EdrJ1oVQ3f7fCa6rpoVQ5n9077O5XRDGpVJ2pf1aj+0Xm649cnxWEWW3kh4c8YQT5gq0J2qPY35o7/lSWJk0LrqE1jmN7JvwSTAraRVdfp/jHXJOTuBYzms5u1McYH6iBB46+LtqveZvgMic80xv3FGgHvKJy0kJMHXFCCj3iYL/Zl8SyYuaXSo5DInlgwukzwZcvfBjSs6kdQKv/Z60poQ4e9UHooq6f1+Fk3QDVTuiItgBKxeiQBhdt5g/uc2KdKTtZ7CUOt6nhJ/bsYlhNHPJZI2oGtBWcylw7m4JGPRbjGInb7Y80zDW413WjFDdO5nrZALI4SZDn/6tRlL2g3lxNo9TiaXxMykTXUBg6YOYbz8tgX0nIJZ9tV7qFcmN6pXsG+5ecdn9bjxm2xTnUdpB5RSZnIksORb1sRd5nTfuCZYHSr3Wolo3i7jJaNjKM9kdK8ml1dKg0NeMHkluB2w12jHXoyCLvfUgAQRFrviTgN6YYAzIUeAS8Q3u+2Pl8iyoeysvNE3kbToV0gTiY63KbWM1Oou0ITm06vMYsQabcDIRQY5IAbeVmZH+Jwo3qmRnJgEDFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(136003)(396003)(38070700005)(83380400001)(122000001)(186003)(2616005)(71200400001)(6486002)(64756008)(37006003)(54906003)(8676002)(4326008)(6636002)(66446008)(66946007)(66476007)(36756003)(316002)(91956017)(478600001)(76116006)(66556008)(26005)(6512007)(6862004)(41300700001)(38100700002)(6506007)(33656002)(5660300002)(8936002)(2906002)(53546011)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JY690MpLM/X7iGk8ktQKxVM550hdaIR84g+sMF0CO5rfy7hs5xHgUM6zHkD0?=
 =?us-ascii?Q?7QFNPDFqEpRnUq2O8pmwvm07lD4zgYOjACU7m0mmlLvkYqtMCwHJafwUYBMN?=
 =?us-ascii?Q?DBbOpwgoDt2hzJw2KYzqYEOo6q40g8R5tpGYeAD6xw91K/MGjcqQUIkmVNMR?=
 =?us-ascii?Q?ZIY2Gyd14in153b4KXDb3TVT2M7+CheILrOWmngTd0Iq1YXmlvxqk863Bs8N?=
 =?us-ascii?Q?OClnX/GTMsl8+IYtxXDOw4W7vIAM1Qn4fWbQKRoGi/n84sf0zu5qsWqJRehj?=
 =?us-ascii?Q?HX7LJN6LPnLeclhs9O7vP8CcHMzM+FoTx1lItqPUrd1VXZmyZCsewrvRS2ee?=
 =?us-ascii?Q?cIzN8GCSP79NK5zqqUazd6IgF/vUTl4UAGs4X+6w2R9D761xKzsHaBgfVLMT?=
 =?us-ascii?Q?TJo3FmBnZWrt08XjphxffnFet2BjApidv1pVrFWNS64SjabG3mHfhUkFjRbJ?=
 =?us-ascii?Q?Vm1GoMIMnMghdJLo1SRkcwSCZ1aN8nN6ZQrvbmfKvSWBf+l677MvMyoXCPTc?=
 =?us-ascii?Q?CwyCDikBB+CdOia1L5VYe3v/VjzYfJL2CRbPET8RgCyAe9ffug2alAPILdW8?=
 =?us-ascii?Q?Oh8rBn6xRzERXpalIp1VtOIDed5Byepqn8IByDNI3/ILgl6kGtjO18lDX8gt?=
 =?us-ascii?Q?iShewKKe8itmYBTVcCEX85gxtpC1NlWOYvmF7maue146kqgynlpHwGjptpkr?=
 =?us-ascii?Q?48s/0DXrithjEKom8KKVziCNzJKJkF+899JpweRVU7z5IYKKaLXFPDQl6XOn?=
 =?us-ascii?Q?93nDzJntZPk/KGD2dISTGASMHwXuU9F9NIGC4GHA3dw3zH/EfdsK+wXudD8o?=
 =?us-ascii?Q?AxpTbTVk4EJcoQD+nYMaXdFNyx8jaN9fCvOKKSvqBaTw8Ih2z4vBxhN+wwb5?=
 =?us-ascii?Q?TYfpiBoj/XutsMODT4qg5OxAM4cRw8CDKfz8MvO/fW1dkvkreeABLK/sCve7?=
 =?us-ascii?Q?srzqZkB12BBIi7NEyTjYjanF6iDI4IQME5EPNGBZ/7btwAYRGjWyzA19C+lL?=
 =?us-ascii?Q?Q8LwhAy+41NDE93mLd8qhjHrerF16wcuGE+KS0osoD9nMfMtV6HURMtj1UnX?=
 =?us-ascii?Q?GmGrcsK7cP7s55L+7yUo5wcBd68gkpmFN6EjTxZhRLRIY3fdqAUhP72stg+8?=
 =?us-ascii?Q?yj66KvQHCh9nC8DLqofoF5dDzrkUbulEf2oV5Arema4pPWpmKKkV9jD48wxu?=
 =?us-ascii?Q?yk7TaZP2P0QCOozi/2jGM7mkTDqmyJEcHeODDUNpLeCao792YKpbcG6/XJlk?=
 =?us-ascii?Q?Qwx6zhxFJTyrQhV7SF+aa9Ny2KCaFBxHm4Mpa/2ZynhRhA/1QfFkdRkBCbnH?=
 =?us-ascii?Q?+HeXnkT+d6OU9BcAuNc1UFKCwNrp+6XEtnZM1NDTIpzO5wsJBgjIn1Xa48qF?=
 =?us-ascii?Q?CphWDHSMXVYUV8WA4my1/F7ZAybyuv/MA8u/jiCfFCbNK/hOClc0JDnIKqfH?=
 =?us-ascii?Q?p4zPJ9WnMUK+zVJ/Mjet302UVSkqT09WZzkwfc+2zCeYbKk0NFzELfH9SA/6?=
 =?us-ascii?Q?P/NJ27og+LOiF9VeKxSnmvySb5XqpjKhbkzaUNw8sTXzikbaY3WKLSS4SR3j?=
 =?us-ascii?Q?Wa2dOG48FJpGyDuu8i4yWj17nrjzMS/WCK2RRw/iBixuzttBeVy+wjPwDT3F?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5845964E4DC89340B93EA7C6D326DEFA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cad0a5-00d9-42d1-b4d7-08da8eae1050
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2022 19:45:47.5212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNPJZMbidZzaYtlOCDhxbwCa7K9ReEvbGZm/5k3NLMvY0dZSjLlQxX5L67SkfdEdK+z8oh1X8QkRXwBxrlvoaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209040101
X-Proofpoint-ORIG-GUID: iJ7Z0GrVxSzKZOYCYX7N_cAhGGohPyWX
X-Proofpoint-GUID: iJ7Z0GrVxSzKZOYCYX7N_cAhGGohPyWX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2022, at 1:27 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add the courtesy client shrinker to react to low memory condition
> triggered by the memory shrinker.
>=20
> Currently the laundromat starts reaping courtesy clients only when
> the maximum number of clients is reached. This patch adds another
> trigger condition for the laundromat to reap courtesy clients.
>=20
> The low memory trigger is created and the laundromat is kick started
> by the shrinker's count callback. The shrinker's scan callback is
> not used for expiring the courtesy clients due to potential deadlocks.
>=20
> The laundromat reschedules itself to run sooner if it detects low
> memory condition persists and there are more coutersy clients to reap.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/netns.h     |  2 ++
> fs/nfsd/nfs4state.c | 43 +++++++++++++++++++++++++++++++++++++++----
> fs/nfsd/nfsctl.c    |  6 ++++--
> fs/nfsd/nfsd.h      |  6 ++++--
> 4 files changed, 49 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 55c7006d6109..85e351f08e57 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -194,6 +194,8 @@ struct nfsd_net {
> 	int			nfs4_max_clients;
>=20
> 	atomic_t		nfsd_courtesy_clients;
> +	atomic_t		nfsd_client_shrinker_cb_count;
> +	struct shrinker		nfsd_client_shrinker;
> };
>=20
> /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3af4fc5241b2..a27553b42e72 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4347,7 +4347,25 @@ nfsd4_init_slabs(void)
> 	return -ENOMEM;
> }
>=20
> -void nfsd4_init_leases_net(struct nfsd_net *nn)
> +static unsigned long
> +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
> +{
> +	struct nfsd_net *nn =3D container_of(shrink,
> +			struct nfsd_net, nfsd_client_shrinker);
> +
> +	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> +	return (unsigned long)atomic_read(&nn->nfsd_courtesy_clients);
> +}
> +
> +static unsigned long
> +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control=
 *sc)
> +{
> +	return SHRINK_STOP;
> +}

I notice that backend_memory_shrinker does not have a .scan_objects
method -- it does it's garbage collection in its .count_objects
method like we're doing here. But it seems to be the only shrinker
that does not define a .scan_objects method. What you've done here
might be extra lines of code, but is probably safer in the long run.
So, good to go.


> +
> +int
> +nfsd4_init_leases_net(struct nfsd_net *nn)
> {
> 	struct sysinfo si;
> 	u64 max_clients;
> @@ -4368,6 +4386,17 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>=20
> 	atomic_set(&nn->nfsd_courtesy_clients, 0);
> +	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
> +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +}
> +
> +void
> +nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> +{
> +	unregister_shrinker(&nn->nfsd_client_shrinker);
> }
>=20
> static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -5876,12 +5905,15 @@ static void
> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> 				struct laundry_time *lt)
> {
> -	unsigned int maxreap, reapcnt =3D 0;
> +	unsigned int maxreap =3D 0, reapcnt =3D 0;
> 	struct list_head *pos, *next;
> 	struct nfs4_client *clp;
>=20
> -	maxreap =3D (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clie=
nts) ?
> -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients ||
> +			atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0) {
> +		maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
> +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> +	}

The rest of this work looks great.

But I really don't like the idea of making the current
nfsd4_get_client_reaplist() do more and more by adding
exception cases inside of it. It's already gnarly! I had the
same difficulty with Neil's original lock simplification
patches.

If there are separate distinct functional needs, let's break
them into distinct functions that then call common pieces (to
maintain good code sharing). That way the operation of both
cases is clearly documented by the code instead of having
one big function with lots of exception processing.

AFAIU, the shrinker needs to look just at courtesy clients. The
laundromat looks at both courtesy clients /and/ active clients.
That suggests refactoring the courtesy client code reaper into
its own function that can be invoked by either the shrinker or
the laundromat.

The laundromat can call this new code and ask for it to trim
only when nfs4_client_count exceeds nfs4_max_clients. The
shrinker can call this new code and ask for it to trim exactly
N clients. N might be a small fixed number like 1 or 5 if we
prefer to start simple.

Obviously you'll have to wrap the refactored code in a work
queue for the shrinker to kick, just like the laundromat.
That adds a little more code, but it makes it crystal clear
what is going on.


> 	INIT_LIST_HEAD(reaplist);
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> @@ -5947,6 +5979,9 @@ nfs4_laundromat(struct nfsd_net *nn)
> 		list_del_init(&clp->cl_lru);
> 		expire_client(clp);
> 	}
> +	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0 &&
> +			atomic_read(&nn->nfsd_courtesy_clients) > 0)
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
> index 57a468ed85c3..d87a465aa950 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -498,7 +498,8 @@ extern void unregister_cld_notifier(void);
> extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> #endif
>=20
> -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> +extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
>=20
> #else /* CONFIG_NFSD_V4 */
> static inline int nfsd4_is_junction(struct dentry *dentry)
> @@ -506,7 +507,8 @@ static inline int nfsd4_is_junction(struct dentry *de=
ntry)
> 	return 0;
> }
>=20
> -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
> +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0;=
 };
> +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
>=20
> #define register_cld_notifier() 0
> #define unregister_cld_notifier() do { } while(0)
> --=20
> 2.9.5
>=20

--
Chuck Lever



