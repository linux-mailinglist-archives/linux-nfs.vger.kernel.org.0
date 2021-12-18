Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA46479BED
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Dec 2021 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhLRSHf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 13:07:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27806 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhLRSHf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 13:07:35 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BIB7UlK010009;
        Sat, 18 Dec 2021 18:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=p2AJ981XWinYwzr4ErQ1dBMT+NMBHujmjqSCz4WrThg=;
 b=lfavg4cKRAVDIM39o0fz5QFv3bLqC5GRquUAVLPLspq1y2sNk6SF5KaEYH6UMCT2zqwB
 mVDLu4Krlx/KxcMasgYxF7ueQnXWS/H7sm78WyTuMLmvTMDv+RbTa4ZQF3qj9Rv+Yz6D
 tgSQJrEeWn1re4Sfaf9fob/U4+EMSDy2p3hHIAfZXe5pLBlQqP3tADoH67aEn+opOAHl
 dWHv0scq7qtAMsEl3FhhJZ/aFGwxOEi9de4KN3cy3YDgElQk2V0W0aNEGzzvvSl3TgUT
 A9LyiOeSvVN+Zp9pKefQTyDLSM6eVz+RdK4hBT3OjhkMTJe7+m9rQeJS+IIwbQ1X+5Tw rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d178t0rv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 18:07:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BII6Dfe082323;
        Sat, 18 Dec 2021 18:07:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by userp3020.oracle.com with ESMTP id 3d193j62uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 18:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNkGMByNiR5Alfbmn04Txs0EijzwA86JY++3i9J1Yb99nGLHJPArdHK6wmQ+tkjfvw7yrANTQ6N+8NSiMF0rSpp66JGrS1aNublyjoGoll1pW0TImfAgJnnWG3w3E10FgpEvdj9BxPzE90znXrTvEz2efMGgEYWXRrYhVedc3ZNktovVf+sBzVQ49bjCc0KyD1yMHPKu8d8k+ug7XEJc8Pl4Y7QjnDpy1aEFGP/TQTvYaPZ7o+IpTr12uDHfs0iBk+M+9glDLdri6bzhes7S8PZDV3Jw+HbpZ/EAOh5TUa3NUII7Ta1RcjBmtHM1Q9vHuijdE2CZSR6i5r17794ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2AJ981XWinYwzr4ErQ1dBMT+NMBHujmjqSCz4WrThg=;
 b=kP/Vq/7bbPcqzdDpV4SKghKs7TTvTPko2hLSHPo7W9cGXTq/mJkDUWHik47wWiIddho6F/GDK/I30StsGCj0CfqJcG1CtZld87hHSfHMs4+oOofgIfCacv6g8Vc2OStkBFRh0OzOyS6W7LicoEYyv26tru7KfJ/Jb6hRMXw3zweaveqpbrEIVzVcNlfk2F0BDbpum3IWJI9FlSqiQha5rsj8f9bWZ80iBa3vCrQWCZUK47x8dPi2GSVp0aQn/Nlnksb+rG93oXsNTA0XPhk/6guSqp1rjaCsbL7lLNhL1L4KAdOvIFqzVHGED3PGnH311akzamqG6lk+QOQY9qOO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2AJ981XWinYwzr4ErQ1dBMT+NMBHujmjqSCz4WrThg=;
 b=hf+P331kz/8jFJtAScrSzKlSoPFgDwo2QxdEvn749Ib6RYMK+r1oomVYxnRV9EMAPvoauKhVujstfqgxzJAtxAc/WOItodqTKeTPYeXozvB3j8G/G15w3M1JNLJRZtdXMuPkz6Z2B0hvH0C8t3glXspW3Le79V70hUuv45wZ0Hs=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5241.namprd10.prod.outlook.com (2603:10b6:610:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Sat, 18 Dec
 2021 18:07:22 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 18:07:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 8/9] nfsd: allow lockd to be forcibly disabled
Thread-Topic: [PATCH 8/9] nfsd: allow lockd to be forcibly disabled
Thread-Index: AQHX85ESvjrRCI8MH0G2yfodVqlkq6w4jRGA
Date:   Sat, 18 Dec 2021 18:07:22 +0000
Message-ID: <05EB51E1-7F6C-416D-8165-6DCFC9B91996@oracle.com>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
 <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org>
 <20211217215046.40316-6-trondmy@kernel.org>
 <20211217215046.40316-7-trondmy@kernel.org>
 <20211217215046.40316-8-trondmy@kernel.org>
 <20211217215046.40316-9-trondmy@kernel.org>
In-Reply-To: <20211217215046.40316-9-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef3b8cab-a3f7-4421-11ba-08d9c2513d4b
x-ms-traffictypediagnostic: CH0PR10MB5241:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5241CC96A686B0F4B979941E93799@CH0PR10MB5241.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qR2+xucpZ43wLTjtJRC/ovGg+xL1P1yqB1z+ZhmqObTwTsR9PEUonObhV6fAv3e6uCF0I/3nTTHU+8vBgrpZH3bL+IjMZLGDHCds5YNlvCCQAbJ8a0XwAA6HVM474WC5Fj2nJyryB6cHDOV6I8NMVV4Y5oQbcSkvmrXxqLE3U6GvzzY/Ev25/6+Yd0Pzk4x6dKoZgUkFADiLMc/HlrHy1GHPzdOhzqmNR/P5HeLAynIeIHGVCSnZqL6nOAoFjENThhtKLPZYK2MvJ+sgzogE7vw/sKe5kkXE1vuPzj4qB1xnlvC95IaHr0g3AR0KOIeFe2UHs+Oj6r7i3F+0TCPc4tXkxoWMuWCbJ9niu5OAsMiAD04ezvpvOeXeOPEl3sxCLHPGpUcEqkMKXa/aRSZqLOtK60XIHvT05joT4SPoEpQicQeJk2WFjIt58cp27WBd9FxjLRJjZE+3Qmzx1EJ3wgn5iyTsVqoJKbB+7uv9DtxICe45If8anucMlgYGRDKL9bVwbJ2WWk8pdkxITxanxE2ZT8jibs0QwZQadKeDG4wvD+Dpdu1qKwU8c2Al46wx8DdT5VGBgqL9v3dz8DCn0BJHm5IPgUan96racpQn5/0+UWv+pRFjjDp1poVaJ4Or1oTult0VFpAcROyyUdZ3n6eQKIJ0Kgl4+MMf6kxBO5wlZzyNjWXxtUG8vX8rZfsIqGNx6cpDXCub/KOTprsp/yPwa06DGvktl0Enha64poNBYpRIEhyIYAeJBB1+bMDI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(53546011)(38070700005)(83380400001)(316002)(6506007)(33656002)(66946007)(26005)(5660300002)(64756008)(4326008)(66476007)(6512007)(66556008)(186003)(2906002)(76116006)(66446008)(110136005)(38100700002)(122000001)(36756003)(8936002)(86362001)(508600001)(2616005)(71200400001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w71ViwaTFHjy1q5l170XbhoWpOq4gXkGqVFcyhR3EPR6cYZjbIu7i6KBOtIN?=
 =?us-ascii?Q?zR6zsMCQIJ86OdqLybpUl5xTYRppMtmWsP0G7QS7gZPRqJUb3MkaMgNmFi+4?=
 =?us-ascii?Q?jTULJhivwiDrUJ5WL2mSSOzmvDnxjwSj71Wfqglpxw7b84bFX8Q+yFdyilhs?=
 =?us-ascii?Q?PC8DoDTKD9eFPdJ5ahaavtNazZeutP8ZDAvTNWNtebCvH7FFuF83UfgoyAKX?=
 =?us-ascii?Q?TPVa4hqQBVP3XFu28Q1yfTHUQXOaOfz4rwgKzHuqiFtSd8imULd5i9t1el0y?=
 =?us-ascii?Q?59SV5YP+XA4vlrDLHdspSVGaDIinEXN+o6Uz8t37ryY+6aPKb/Afl8zDSMI+?=
 =?us-ascii?Q?zGFRGk1HFZPct7hgPTMkL3jhwQNWZ5ajCCaC9fGv7QpQJUiM7hQBM/auLQ9d?=
 =?us-ascii?Q?Rz5LwLpuCHoplAIi4U+NDOksmjunjBJYtzyQBmebGsWxqZ1JvtoooaQi7+Fg?=
 =?us-ascii?Q?TNfsGv3OgCS8WOEe+rv4NYia2CIYXgEsBEsK/RzCgMz7/3vmYMQp4krTZNZq?=
 =?us-ascii?Q?OVeMBnqicrICcCdmEanA8gZzCb8NESAeywsgUB9G5SiKxYls3F9kAxr4BQae?=
 =?us-ascii?Q?POOXxbIEcNWzbliQE+koXWS+KvifDf+SZo5x1ka5GjwKqTt3VMEAo7i4qgoE?=
 =?us-ascii?Q?H1QcHzPPb0qQ7kSXffvMF+aRF0cneXltlsATdCQ1caXedWWqh6rM/nx00Kv3?=
 =?us-ascii?Q?pklOCrMh49/ExhMPRkyODfeTfE80eJ6z5KHjPlZuMMkQSR7RWpItxjMIIp4X?=
 =?us-ascii?Q?z4yW6igl4jZGP5/9ZRWbgt8rqr1+NcCbmK7Pg2YbIudJcM71KI0jjGsPz2Of?=
 =?us-ascii?Q?xa/TlulB0BF6RmtM70Atkg6lZbUp13ws/poOXsbCeByBPckSMAcLgCvrlZi4?=
 =?us-ascii?Q?F7qCBhEt2PNnhUk0WqnwDGzighzEjMknD9cGEZbWb8haIY4hI/00dasBtZLM?=
 =?us-ascii?Q?cu2mBzhzgs9Pgv8J1jMi+78fBqqTd2lDhjqHibAP4Tkfn1dEv6cW2xgj+K5Z?=
 =?us-ascii?Q?qH6hssP+nOt8B3Lewo8w6koB2cacbeLs2sb/mkOwF6zB/YJQ4iTRe9UOjqV7?=
 =?us-ascii?Q?vx6YvmDBwjq/GoV6aTe3JTquBahCRgok4gr5tn1VydoFo4rJmajYfqvzLcM6?=
 =?us-ascii?Q?x+Jb1AwXh6eoHapHlZGZtTo/7Cwyqc9ECfXotudKWGrWl0xszkOswz1++kPx?=
 =?us-ascii?Q?qW7zbYAd4uyF3O44zzXQwY/iams6xCwHQ2Fq5Qjnd4Oy+QsOuhZNqSs4S5c8?=
 =?us-ascii?Q?yeh0o2zBkwa0hbjnjD/ck5nN3tcQG3nwCw4Fg/2V4MopfWd8sYYYeYiZpnZm?=
 =?us-ascii?Q?lEaPlX4cNYlEaYLnO5OmCBPHHa5VxYrZ4dvWVkiQ6bYf+hG5FqWlZ/Q7Xmqs?=
 =?us-ascii?Q?xQ4dZcY33zyYIYi0eEDmy5kGyCtkWbFfYeoX6sfS3Z+7QnJKCoCrl/cC75gd?=
 =?us-ascii?Q?ML7P+KXhTlZWrZmq89vXkqnPPBXAoejCoPbkClqVRo61x1G64nezZDwik7W0?=
 =?us-ascii?Q?+8CF4tv3ZYhJc1sMd4gskWsz+/IzyAh4hdNXCMxGKrPGoxPF91DuCB3zGy5y?=
 =?us-ascii?Q?dsDB+odHstR3uc4mPh+pVoK1M5rcs7iCeAQ78tpPir7EilygWXFvkaPqJEcr?=
 =?us-ascii?Q?IK1QigDA8GztRuwHVC7LW5U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C65289CDE454664984EB568E2067C7FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3b8cab-a3f7-4421-11ba-08d9c2513d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 18:07:22.5636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2cTF0MsSuu0gubgdsBNfrMp9KKE3dseBDNDZWwxMinJhXfVLxyQMU2Xob/O9n5+IgwndlrkWb/HammxaMEbFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5241
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10202 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112180109
X-Proofpoint-ORIG-GUID: RcYeJJziVU-eOPafNU2n4ktLrcplSYNx
X-Proofpoint-GUID: RcYeJJziVU-eOPafNU2n4ktLrcplSYNx
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 17, 2021, at 4:50 PM, trondmy@kernel.org wrote:
>=20
> From: Jeff Layton <jeff.layton@primarydata.com>
>=20
> In some cases, we may want to use a userland NLM server which will
> require that we turn off lockd.

Does this adminstrative interface need to be container-aware?


> Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/nfssvc.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index ccb59e91011b..7486a6f5fc21 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -340,8 +340,19 @@ static void nfsd_shutdown_generic(void)
> 	nfsd_file_cache_shutdown();
> }
>=20
> +/*
> + * Allow admin to disable lockd. This would typically be used to allow (=
e.g.)
> + * a userspace NLM server of some sort to be used.
> + */
> +static bool nfsd_disable_lockd =3D false;
> +module_param(nfsd_disable_lockd, bool, 0644);
> +MODULE_PARM_DESC(nfsd_disable_lockd, "Allow lockd to be manually disable=
d.");
> +
> static bool nfsd_needs_lockd(struct nfsd_net *nn)
> {
> +	if (nfsd_disable_lockd)
> +		return false;
> +
> 	return nfsd_vers(nn, 2, NFSD_TEST) || nfsd_vers(nn, 3, NFSD_TEST);
> }
>=20
> --=20
> 2.33.1
>=20

--
Chuck Lever



