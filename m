Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B342649BE16
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiAYV7p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:59:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48706 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233434AbiAYV7p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:59:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJH84m003671;
        Tue, 25 Jan 2022 21:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E/AQK8T/uNkludXzr8coM1tuOGuySQ6fv3eDyXQb5P0=;
 b=rhhvOJQ1WLKSOEjAeO8TLqpON/tRnX5/g/+jZEP8DJeLLUyaPFB/XHf9G0oY1wkwGDqI
 LeAOdTU/8EWaKzQLKjAvBaKfh0akbjKJieb7cKa9T0dUZbVG0VlC6eYfsGVAdynaSGUT
 F7ryHY+wRGxJBiCw86t7Cbq9qmmBWFUGXHIdIDHOels/O2gPpNQ5NolusETCGuVGL7fF
 n8jx57Ss0qyGBbqlIrOr2V+aHD1qcQ2mnhAzUf1/bSwx7FJRHq0Q6xjBIiEiPJRMrElk
 /9MCquiKFkzB2l4iguIIakhmZbc1++hBDYP7qY9cBVYIharAZCOrjwQsvbJJMMdRAgOI lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjd0bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:59:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PLoxwS183792;
        Tue, 25 Jan 2022 21:59:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3dr71yv2nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0CPab76VDZ4i/vNwjktwC8inb4EztvqVjavIiXLXDEkHV5yUD3Y4I9uE2fvtt0LLcru9tSeTTa+U0BADELwGrFuJOw6SYgaPIYay7FmyzUtRP/gCavFNPEAPJNOn8xxqe/4w2T/ASxEeIKlc+H9tFyzdKV1QeuYHFLL2/OFZbCMNauXrS8CfZOgCGh2HLiAa5S3h+6uitdML6j1LkHxQQTM3GLA3nqtR9HQ2WT1TuOmzB+485fdm54jY/Nkb62xsm0oCQZDXaW9J4k5kowenjzDMSR8J90M36lkhnP3iYA/0kti6dcDEDN562RuLEQfrURbTw0xbyaZJPvYz10afg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/AQK8T/uNkludXzr8coM1tuOGuySQ6fv3eDyXQb5P0=;
 b=Z8/fee62GnM42Uxz+yXa+OzsjNsts/6ypw4fUmp4RvtapRNFVLrvo18DC6Qc0ZbNCmbqeU89UuiAIlIp0OOzWhiBguDojxtiuh1POU6wPeL2D+VHu0D52P7SQKkHByup9aGT/m6zmShz/A0RrnmpqEQM4GJqwP2+WkYkd5PalNBdShVkXzCNwhSyPpK291Dc1pRyj7sGCWWIM9Z2Cm1bq5njPTUsUY5MHioBa3fmMy0VdYMUZOBzGYVNgHDwtEQ7sB8ksNVKKCNa6MOHR/7c62oMTWGUFje6EKbBPGnAY4+4pkr3+aLkSLDZCNWXIhl8VSwUXBuQwZxuIU7orRPSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/AQK8T/uNkludXzr8coM1tuOGuySQ6fv3eDyXQb5P0=;
 b=ukkZnlC03uZYMv4XIpGzgjkbef9TDjf/D/eOs126JgOg8tu5ZoH21azpe3x5FWeKB+P8SsqUsMyRCF010W2Uf06t6V2XBnPMMr9ULXWlj3mbW31mz0wYK45Di9WARpEitXhgfcjGj168HmiDo8IGmsBlry9gBaYmqCyt0FaD+ko=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 21:59:39 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 21:59:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] SUNRPC: Remove svo_shutdown method
Thread-Topic: [PATCH v1 2/2] SUNRPC: Remove svo_shutdown method
Thread-Index: AQHYEh4AiHVQD0aNRUipeoAjiSRA4qx0R9qAgAABnIA=
Date:   Tue, 25 Jan 2022 21:59:39 +0000
Message-ID: <E1C5753E-6061-41CC-930F-1565488FC799@oracle.com>
References: <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>
 <164313725230.3285.5420060785593218794.stgit@bazille.1015granger.net>
 <164314763348.5493.760625882164316264@noble.neil.brown.name>
In-Reply-To: <164314763348.5493.760625882164316264@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce6db024-9f6b-4152-ed1b-08d9e04dfc30
x-ms-traffictypediagnostic: CY4PR10MB1989:EE_
x-microsoft-antispam-prvs: <CY4PR10MB19896B06BE5AF0ED9C4C7CC9935F9@CY4PR10MB1989.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cwMoy80G31ojSfYLtvbPERBY7NzkLe98FrpMvuTUwHBLNIr9JdLtRDUY/qHyH7Nxx+wG+HJGce36ieaZqWPlvesqKZXi7kO568MTBbcc6PSxp6GHb3+BTcoj3v3Oj3kSq0+rzfRXjGNx4cCX4QboAuF9/Ykbpu9GYUSlknkLyvYdi5P4I/ylXNChshXTh5FASk1yrpVcn8po1KFntss4KupwEda37BqRXP5EcsDRRALmoWnKIwH5eJiuB3H+Xi2w7DMzh4quWn/gfsLZsfK6W9rNLT+wB3Zedz8pHIG740xw2Ndhng4kN0YkEhR+XFmxxnsWCWQ62U4BVdjUF/7nzR8+FJ1LgLTOsefB2KKTiI0GpWrFpewYwyDGpiga+6Qm0gXby7Y3cXPO4mAJilBrnWrJCB/6KKXipHAPmjts39uP29BoQspmFdfWTGrxcSKTP/tS2VrWtchaFyH3bOqCIfwiWzYQaD/8SS9s3JPhVOvY/Iypbs57YBd9wV4BOiLfiBZnthef61VoBgOgT3SuvpB62fLTXR72e26FGhj+l37g+AvLidL2aHnzZp3zPs9+A0r8G8Uc3GV50k1YVQ6hZULwXMtV/SE89inV90duIwcgYCe6/6oDjs9D4FiVbnPJ3+7SSAOpcJaIsiSkhN0R40lq+OIpE5tD1zD6gvwDbg673thIBrQJrDr7R0lsIB/KeKO14RBiYoiqJOfbZVUXgUgug7lAuh+7bO7YgKyg7NlOGlxXfAzFg8ZVxQqK2d0U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66556008)(71200400001)(186003)(6916009)(36756003)(2616005)(33656002)(6506007)(76116006)(316002)(38100700002)(66446008)(64756008)(6512007)(508600001)(38070700005)(6486002)(5660300002)(2906002)(4326008)(83380400001)(122000001)(66476007)(66946007)(8936002)(26005)(53546011)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yr5Si8b8zgJQFu/7utGamJJJKSFFT2XcZ738z4VrIw/jmPhWD+NjuVY7ZQ7R?=
 =?us-ascii?Q?+vHpyuKdLSaTpUNQ0cwy78l1IVaIoYE8xZpSti7W3p5BZS8xIHlRE6ZQI+4j?=
 =?us-ascii?Q?wWSTMPICALEiyQ0T6t9u9JlWL9anQ2CAs7jb6mBdyO6lAHSGSpbjPbtHqW+h?=
 =?us-ascii?Q?xxrPK3q993bnkm6+8UF5PeZVPfC3zm8wo7JPNRIB25L3BU7n76QzX676dEk7?=
 =?us-ascii?Q?IbQAIDpYzMP5jAwoRajDvAfNzex/B1cSfWOzWin3qxadEaDc4jZ+kWp9xMlh?=
 =?us-ascii?Q?mmbZUDiIz8noVXCDLicTWUq+cDvVYuuN1StAYtP74lifQWk/o1WJ1VfoLtM0?=
 =?us-ascii?Q?nUK0ODa0Rv/JT2yxJlKU1haczxht6EKBLXnr8yfXULoyY8x3fYHp+PagVJNh?=
 =?us-ascii?Q?etfx/+BeS8/cMHQXuiqWsHwKfErKw3ksTf4mMDKFmcJiLKE7Ta+ozWMkNZcU?=
 =?us-ascii?Q?DXymYig+45qeJl4LIv90Zqzgj5jgt9ltT2wXq5a2FRh5ZcPN2udfAkwti0k5?=
 =?us-ascii?Q?Opi/KlRUU4SsZEWcKM8KBuVYV4PSByYvURandLpRnPYMQ+5m3f6OLFu0LujW?=
 =?us-ascii?Q?CuTWLG/UcQ36WUzRM0UaI9DVxqhqHp4fpJoGQu+9XObdZ936mnTut30qtCJ5?=
 =?us-ascii?Q?9kKGqv3J+TpFYKq69leVqZLueh7W3k7E+pwzO7j4R3YwvcFa68BNTdip3Ou1?=
 =?us-ascii?Q?jLpyzKRB4YjV7JCF/Yyb6g8xHYePP8eazSnMq6n4rmA7bRJz3oVaV2FtSko6?=
 =?us-ascii?Q?eVLh1vaZZVHLRPthZMAOsYkmb45fvzPOs9rI49U463hyaAqTcJHRoOHC+phX?=
 =?us-ascii?Q?d0sC7UsFMekLlRzG/+N2ZhPEh+GBedCwkuQeilAtZGR125CjgVeD8a9K8Ecq?=
 =?us-ascii?Q?fKPHl09qq17Cn83Gxmb961e5NYQA0Uv7F1FBEg04q8cyS8dcm6PFGAwuOSPq?=
 =?us-ascii?Q?Xd+Q2HiuhdU27mUgFiIg+iYBl1VPk1VeT0Bu32VfiRelIYgH4l17fWjXonYO?=
 =?us-ascii?Q?M8vNST9IGs3uTQiU8tEadOykKoP3wY9bfdBOVMLY9Rkkmf1ckj01YBbVgqrA?=
 =?us-ascii?Q?yfjfFNCm+U5V9JCpbj++jIfPerGyoUyuUZTTWiT6T3P6ZQiJ59t23bybWMur?=
 =?us-ascii?Q?GB5ytG/ybASJRx5/sMRvSqBnltIHoJKyaV16JFy3buEUf/cS8sJnG0A0JGJC?=
 =?us-ascii?Q?r+sYDfJNejuGWy7n5/KYLkdJsR549bGgbm+om7J+ljhXTKW+/dg3o/+CfeJM?=
 =?us-ascii?Q?Lum2hLcBazh0pwFNjG02LOwtiYPXW1mV5mr8dBoufqeGsy8Ilj1pppjLzWY+?=
 =?us-ascii?Q?SHHNe4AK5D+zPvL+adUZ6zmqWFFaUzc198D4uXiDPbnQmyyGZEerVqWJodhl?=
 =?us-ascii?Q?SSJ6LfxSYBxzX5ljiomyNCU2oaUJPzKkJ91tCyfBIaJNnwQNW2FOlSr7/Qfd?=
 =?us-ascii?Q?x77TjVTLbKJ73FZ9vY24fLAkB14UbKSN9yjQmT5Z/C2SumtwLNEYyQ1XP5Br?=
 =?us-ascii?Q?IbJRXedygnnjVbqY7Lb8nJKME0V18j+BEuorz0sX0B+tsdXEzgRpGTSmeGQ5?=
 =?us-ascii?Q?uT//rW5UmNsw8D+BqOks0mNZ5tx7q7ItgyoSu9+hcxLoJBKF+Avww6clO33P?=
 =?us-ascii?Q?JbZNHpjFF9nvrLuLVEp4De0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62CA8DC7994FDE4BAAF4C992A8A581A3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6db024-9f6b-4152-ed1b-08d9e04dfc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 21:59:39.6866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTMlBdc/f/r95t02bjk8hQZISNoK+mtP3AsfXLuYH7msrcaWDgeIqNYF9iNlw0Qb82ICHza3UlhGzBTUap97gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1989
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250131
X-Proofpoint-GUID: zrWwi7wD542qdZwEMe7vxc5RDhvRY0qX
X-Proofpoint-ORIG-GUID: zrWwi7wD542qdZwEMe7vxc5RDhvRY0qX
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 25, 2022, at 4:53 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 26 Jan 2022, Chuck Lever wrote:
>> Clean up. Neil observed that "any code that calls svc_shutdown_net()
>> knows what the shutdown function should be, and so can call it
>> directly."
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/lockd/svc.c             |    5 ++---
>> fs/nfsd/nfssvc.c           |    2 +-
>> include/linux/sunrpc/svc.h |    3 ---
>> net/sunrpc/svc.c           |    3 ---
>> 4 files changed, 3 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
>> index 3a05af873625..f5b688a844aa 100644
>> --- a/fs/lockd/svc.c
>> +++ b/fs/lockd/svc.c
>> @@ -249,6 +249,7 @@ static int make_socks(struct svc_serv *serv, struct =
net *net,
>> 		printk(KERN_WARNING
>> 			"lockd_up: makesock failed, error=3D%d\n", err);
>> 	svc_shutdown_net(serv, net);
>> +	svc_rpcb_cleanup(serv, net);
>> 	return err;
>> }
>>=20
>> @@ -287,8 +288,7 @@ static void lockd_down_net(struct svc_serv *serv, st=
ruct net *net)
>> 			cancel_delayed_work_sync(&ln->grace_period_end);
>> 			locks_end_grace(&ln->lockd_manager);
>> 			svc_shutdown_net(serv, net);
>> -			dprintk("%s: per-net data destroyed; net=3D%x\n",
>> -				__func__, net->ns.inum);
>> +			svc_rpcb_cleanup(serv, net);
>> 		}
>> 	} else {
>> 		pr_err("%s: no users! net=3D%x\n",
>> @@ -351,7 +351,6 @@ static struct notifier_block lockd_inet6addr_notifie=
r =3D {
>> #endif
>>=20
>> static const struct svc_serv_ops lockd_sv_ops =3D {
>> -	.svo_shutdown		=3D svc_rpcb_cleanup,
>> 	.svo_function		=3D lockd,
>> 	.svo_module		=3D THIS_MODULE,
>> };
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index aeeac6de1f0a..0c6b216e439e 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -613,7 +613,6 @@ static int nfsd_get_default_max_blksize(void)
>> }
>>=20
>> static const struct svc_serv_ops nfsd_thread_sv_ops =3D {
>> -	.svo_shutdown		=3D nfsd_last_thread,
>> 	.svo_function		=3D nfsd,
>> 	.svo_module		=3D THIS_MODULE,
>> };
>> @@ -724,6 +723,7 @@ void nfsd_put(struct net *net)
>>=20
>> 	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
>> 		svc_shutdown_net(nn->nfsd_serv, net);
>> +		nfsd_last_thread(nn->nfsd_serv, net);
>> 		svc_destroy(&nn->nfsd_serv->sv_refcnt);
>> 		spin_lock(&nfsd_notifier_lock);
>> 		nn->nfsd_serv =3D NULL;
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 6ef9c1cafd0b..63794d772eb3 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -55,9 +55,6 @@ struct svc_pool {
>> struct svc_serv;
>>=20
>> struct svc_serv_ops {
>> -	/* Callback to use when last thread exits. */
>> -	void		(*svo_shutdown)(struct svc_serv *, struct net *);
>> -
>> 	/* function for service threads to run */
>> 	int		(*svo_function)(void *);
>>=20
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 2aabec2b4bec..74a75a22da9a 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -539,9 +539,6 @@ EXPORT_SYMBOL_GPL(svc_create_pooled);
>> void svc_shutdown_net(struct svc_serv *serv, struct net *net)
>> {
>> 	svc_close_net(serv, net);
>> -
>> -	if (serv->sv_ops->svo_shutdown)
>> -		serv->sv_ops->svo_shutdown(serv, net);
>> }
>> EXPORT_SYMBOL_GPL(svc_shutdown_net);
>=20
> Could we rename svc_close_net() to svc_shutdown_net() and drop this
> function?

I considered that, but svc_close_net() seems to be transport-related,
whereas svc_shutdown_net() seems to be generic to the NFS server, so
I left them separate. A better rationale might push me into merging
them. :-)


> Either way:=20
>  Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown

--
Chuck Lever



