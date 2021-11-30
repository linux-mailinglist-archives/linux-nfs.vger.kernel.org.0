Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC11F463F21
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Nov 2021 21:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbhK3UXU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Nov 2021 15:23:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19448 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234770AbhK3UXU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Nov 2021 15:23:20 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUJTWIk007156;
        Tue, 30 Nov 2021 20:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E6iw4hIfivVZEIEZh6uep0f7QcR87fbzlpAfEnIbqdE=;
 b=SQairtR25TpBKwz18EfnRZuT+PYapnPZE3XzflXTwuHGxh6wcJ0tV2YAKGVIjJ8xppfl
 Y1EtprbQ8bVURITzfboX6yK9PvfGZXcWBpq6mQumLJLJnSMGuiKJSBMro7FUBV4LxcKK
 V8ncgl0rGLZ/kG34h48GHHsH0vaIc1T/yrIeVqUcJYL76eCFvh2BgXjVzvwGIO/qnKA5
 tuORcp1bQuQ1sbCpbkAKRWCEcxi0WxuyZBWL19FR2qCdFxIwco1IJI/noCBfu/SknOSZ
 avALSTKJjprRFBh/XWsCjfmgEJ6FX6gifKOPu+Rg/O7AHmdlGdNN8XVIKG5CZM7tj2gb 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmueem2st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 20:19:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUKBkQW180991;
        Tue, 30 Nov 2021 20:19:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3cnhvddc7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 20:19:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMO+9U0GuRB2Dv05Amg7HkavH4Qot0/7xYK0QPaFK2T4wZ42DMREDjcdeJMP11wXFErZ2FugdYsU0UHR7PvcBxnbgWLELUQ5HDNmZ7jEVzWS0qHZLKxIgGaCgBjrk2Vk56Dv2h8llS89Ufqn0yBnveLaPl2vHrC0JDZDqPx+dVsWeDzjQtIViAd/+LxpKtcJdUL9r+MY9EjSEMvpVhdn4q/HzRi1Gjde69iXX+OD9Y36Oc/P3cSKLqF8MLQ88Pu4CPCWgc6H2Os7amUdEK+SHIGCRJuGnzeFxrLZ0brypEY32RLVB9Y3Ii4raFU9shQCMameJw88tQDp85iZn2lSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6iw4hIfivVZEIEZh6uep0f7QcR87fbzlpAfEnIbqdE=;
 b=e8ozlx6ZfHpTJ8Uzcz3ay9C6zJBnIoVJKDSCgEeVvhhpGdOlf8kome7FnK0H0MmAigHiLu/47SJjlBLDZt+MmPKLEbnK4BHW0uU2L6xFs+x33dlbSPIoRLq9CalHsx5/QVrzBrblaaYEKHGuzE6cEjpYklf0ovtXbD5QO3G00rVlnNaRGQiBsslJyAu5sRSsVqgQvBfEL+4Aj8KlNME9zAF0DIWp0NO8Ijw4ocU2a58hS5huh0H4EF/t+7xbIp4TBqIrRI4YnzoVyXXqtuBS43CbMrHoZUeqfXLsS9XMjWOk2a4fy744j8grarPvXw8FDcfeQTW8eKuPpbZ47nsOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6iw4hIfivVZEIEZh6uep0f7QcR87fbzlpAfEnIbqdE=;
 b=F0AFZ/jGu+tCfQTzC2Wb49mxaiTF+XRg//bYvwnOwyPEORKcXDzpifbOYzIxaziSj2OwFb5h9nnRiQd3jokuuFsNFJGTM69/qr9r3n85F5r1HXxpyOpEdeQxxQd13Nf9nEksV8f5yCSiPA+78mGt5g55cnWVwscNHJSVUKHFth4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3221.namprd10.prod.outlook.com (2603:10b6:a03:14f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 20:19:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%8]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 20:19:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
CC:     Neil Brown <neilb@suse.de>, Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Thread-Topic: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Thread-Index: AQHX5dx1rd4OTcROt0WbUE7C0kd8rqwcg4MA
Date:   Tue, 30 Nov 2021 20:19:47 +0000
Message-ID: <888F3743-AB98-41A6-9651-EFDE5987AA01@oracle.com>
References: <20211130113436.1770168-1-weiyongjun1@huawei.com>
In-Reply-To: <20211130113436.1770168-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcc01fd4-c0d9-4da3-e552-08d9b43ec16b
x-ms-traffictypediagnostic: BYAPR10MB3221:
x-microsoft-antispam-prvs: <BYAPR10MB3221981231C1369E980D4E2593679@BYAPR10MB3221.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKbaILcMG217bwSOOOO1oazVm5bSjOraP8R1NDSMXb1UJkaT2y3F3ek592IbdJHr7wii11v0J0FRoZFBrEoHB83cJafgGZpflq0EJktLdm2VQpfNKYtmad+YJhjGyd7mevxK9gFXaz6vKzIeq6c7Wo/IMlcqunBdVNGDjRIDlBnwRXbEV1e4ALDEMHRpSgIqFz8DC72U+6c+/JU/YXlrFX2uMgmvE+OylBSVyhI3Q8j3IB8fpnBT6mYx+f/UoZX5BkzTjzYDcBkhYQMt9xbiZQ2oTNguALlTwLzY+VWI7vH6QrG68cVnpNyr6zmgIcWzNvQ4jjLjVhD19/uINViM2KnixxY4+vQVp2m+vD5bntYxxgtD25ZlPB6Pbpv95Orm/dG393eKocnp3Wfwg9M/u7SisiT4/5jMoW5swd47gC+0YuMKf2Xo3ebbIEKtKbXq0CDCpmOGkkSnzbfiFwZPyTburuKEMOQz4Sk9QfOA0Q8gp8bH9EiDbROE4+s//heU3wX7xlOqycjmEx2J5VtNJyy6WYXfaHBvOyrnJtav6Zuj7izCod7zX+iuHvvRq4r4Fz6gfnn+qVeFE/ZPkrO2WmJtk9qYzd5G69QdXJPg2CE5uQek3w4nU0jB4EYeC2nWaGjKoV7SUoShL7QtHVYVMELhZ6KmU4VxLlmwXYZsRIcnghGf6LvtkWvNNPxvrSwZtuiZ0uB78xQnsBJhN8W78dBckTaliRO5f5DuCdIYsZlMqR5HLmMrgsOtPaB5i6so1RRtqW7c05E/HmliMGQhvRV6KM9bIKkN8IAV2q///W5siPz7Dcbx82HabGL8Fc8eg8iLFz5YUemm2aNTnagfBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(86362001)(6916009)(38100700002)(76116006)(91956017)(8936002)(53546011)(66446008)(64756008)(33656002)(508600001)(2906002)(316002)(2616005)(5660300002)(36756003)(122000001)(4326008)(66476007)(6506007)(8676002)(71200400001)(38070700005)(66556008)(54906003)(6512007)(83380400001)(966005)(6486002)(186003)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sNedteBi9p0OovspULzino96kWHakY6eFLnEshZaxq2X0fIVgP6OSI1PeJmt?=
 =?us-ascii?Q?x8hORHMEHPaoeIGCcYDKnF4HKCRheEXVOgU2MOmCIKAy/KU2Hif4Ufcnn0eq?=
 =?us-ascii?Q?dLnC7kSmcnaEvF1viEk7YLxkC13VBmO9yJg2eE3xjYW7i+rHfN6RQYcR3Ymw?=
 =?us-ascii?Q?DFFLvo6bnMq/NvKZpKpcmMnDM0Yz8qBzOgLFeYOyutPh+uNr3+v9Rn6Lp0P1?=
 =?us-ascii?Q?xv3iYDBMo6pgRv3pTl8lHMBNue1L7ZZ38OeoElBRrjEcy2zXCG5uPkOsM5Tj?=
 =?us-ascii?Q?3ht5oJSMQT4ub/FbUxkeqchtMhpSyKitmsZoFzm+ebFWVdXZcazpuJq0//YC?=
 =?us-ascii?Q?a6KZuKMpOb2oP5Os7Xe/T5Ng+9A9i9kz2jetmbTjnYEF5rJybVllndsO1Uv9?=
 =?us-ascii?Q?UgOG1B9yjNQod/W0AbHZKu9X/IRSAsqhLiy7lsyfNN6RxXkXH67n+UAoqFS9?=
 =?us-ascii?Q?nnd0ZtNmT4mKdkFJHZQewmYr3bQD1JCZCzkG2iLWEU5BjjynI3DfW43HcSDB?=
 =?us-ascii?Q?9Dil3e3/3CrIRg7heqXRhhni+JrGnZ/fzIEKW6/xPVNC4QXRigpzJkW8r6ZC?=
 =?us-ascii?Q?CDN0KBLY3vxJr6TCHfa0M/YtX5BRlWwEhn748aajQWpRGZ2R2e/CNUOwni4o?=
 =?us-ascii?Q?NrBHZCqpkSh58FfYQNR2607KylZORphi7sejWgPCTHF1iK1iSlGTMCbllUBb?=
 =?us-ascii?Q?VMtVVRmlQUuZSreERAPyjYSh6xqo1xIDABhwaBPw/yVoz829ImECRjDNLDCb?=
 =?us-ascii?Q?1P/yjJuwhRFwqYB3KDeH4xJbOvbhQaJCZ9v3z0ORqwh0Q28bqhpA3EIZyO4d?=
 =?us-ascii?Q?/7AG/rvoCECN70r9cgB46T0VCdCGoKjK7N6ufaSz33MxI3TfDZAykKa9WI1k?=
 =?us-ascii?Q?k0kDHbBqVClof1fufuGvTiUbGmovBMjYZd7Q9nz2RjqT4d6m71V+4R4Bq/VK?=
 =?us-ascii?Q?hs8gMP8U01ij11fqrmES/o49rqdo4DTb02/zLNBrTjSIj/K/rdq7e/UIMUPH?=
 =?us-ascii?Q?QLym+3du4GdCBH//9qG8sJTc3mY8/XAQwQTFnAaXTdvyTG3Av1WKFwZEVEou?=
 =?us-ascii?Q?SAowKCBTWTUtq86Sj5CA84dfx1dirb7y7Soh2YMtoRfVI1ITU0I6qteUA2iE?=
 =?us-ascii?Q?lnzGkVZmrqsWhdKoBb49n89jz4XZYqXJiGl8UpMH9ApwKwp+OU68gLGmWlPs?=
 =?us-ascii?Q?BW039y8xkXDuGgGd0j6JhvDyHQuoGusALevSTT3UEa1bhT2p4f7SzWVTH0v5?=
 =?us-ascii?Q?9HOaubfW/r0G9F37vpttdrTWUE681/6/8IgaqBbDjj2+ZgJg5s/6DeavZoFS?=
 =?us-ascii?Q?CQBP6l4T0EUIxLXkt6bkm2vm8SHvU/aPTqBFvYmBuV6Qzn5A6npEtghkPjoL?=
 =?us-ascii?Q?gIzZeDw6/GdixTTN5c0MHg4+BPLBjkn5qM9JgYToU1GWv+XBEvuFbdiZpLix?=
 =?us-ascii?Q?DeCypZjYGKQNqpLH5JrmIRjrSjwG+wjDP+MBt2/nEpBaTSwWpVS6WMZlk51k?=
 =?us-ascii?Q?Jav5SYkavOFaNPEPtw1XtZcexGPwAHvznYnHOmBl1KiKWv1dGzShseVU+dDI?=
 =?us-ascii?Q?Xmup1UwnmfgwbUxwsu4tCo6DPfvOpH8Lf9z4Ylw1NtqAaRIz8HvO/2N1p9aM?=
 =?us-ascii?Q?oFobDq6Y6jfAfNnKvjmV8lQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3196ADB50839224FB38E9433C5DB22D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc01fd4-c0d9-4da3-e552-08d9b43ec16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 20:19:47.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8PRMnNaA9qMXrHGuxZWk1y5fQSI+IfTd8yAAFYzXhLmZKsDJGW2LVHTdxwDj7+BWB6NNdB/R5yXbohlUssNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3221
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300104
X-Proofpoint-ORIG-GUID: jlY5zLyy307BgDurfaHu7tk3JWOcDytK
X-Proofpoint-GUID: jlY5zLyy307BgDurfaHu7tk3JWOcDytK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 30, 2021, at 6:34 AM, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>=20
> The sparse tool complains as follows:
>=20
> fs/nfsd/nfssvc.c:437:1: warning:
> symbol 'nfsd_notifier_lock' was not declared. Should it be static?
>=20
> This symbol is not used outside of nfssvc.c, so marks it static.
>=20
> Fixes: 6ac25fbcbde9 ("NFSD: simplify locking for network notifier.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> fs/nfsd/nfssvc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 070525fbc1ad..14c1ef6f8cc7 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -434,7 +434,7 @@ static void nfsd_shutdown_net(struct net *net)
> 	nfsd_shutdown_generic();
> }
>=20
> -DEFINE_SPINLOCK(nfsd_notifier_lock);
> +static DEFINE_SPINLOCK(nfsd_notifier_lock);
> static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long=
 event,
> 	void *ptr)
> {
>=20

Thanks! This was pushed to the tip of the for-next branch at

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

I removed the Fixes: line because a backport is unnecessary, and
the commit ID is not yet permanent.


--
Chuck Lever



