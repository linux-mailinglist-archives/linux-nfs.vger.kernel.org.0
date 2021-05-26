Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DE7391D9C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhEZRMz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 13:12:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42042 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhEZRMy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 May 2021 13:12:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QH9Wf2123925;
        Wed, 26 May 2021 17:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=m40G5ODeVYSj61nhtw0YJIWEK7v0iUvLmj8cUjK3vNs=;
 b=YWcFZrqkGM5X55hUuKSDJr6dphVNC8RTZj5bzBvxJh/vcknfp7qVsE9OBFrTcLcyApsP
 Q8yWe0hxcqxFTVMMhEv/5yfVT/RNnipB2utuNyl6fXar3xJ2Kr5r08ZsQoVJcgXyf+xG
 eW767ve2yqHUgG4JXD+wusuPhiIfeIjnnOVcdgk6R6d8RiZUTFtXQk68Zup9LMKLCToF
 sw5Y9Aq0tVgJfa9OimwgLgEwiAMXS65NzoZ3h0muPHRJxCcYgKMTxsD8g6oNk7A6zVNu
 B0F0PdUijOiw35Fy9TwI5poChTUfgiPkZ5HsbuRbu86n5MvDCucDydfJbIIs23njMPuq uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38ptkp9t2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 17:11:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QHA7Gi126064;
        Wed, 26 May 2021 17:11:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 38pr0cw5sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 17:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiNdrPe454vIxwItspLKnbKfBqVMOQ3TsqZ437dc8yrf7vIIWQ+Hqi3WHDp0omiOdkxqaUHyETOU5CYF6v/z6aFdgHrdRXBi0KQVNF+8A1+SXiX+604EisfotmmNnG+kpLmUEzaCnygDKwCAzeggihkkTGPKgICfRtjOJPgpD13cU45gijwJ/iipdr97swEQn++EXP/m43d8NRgq6OlRbjJhW6HahVd9slIsjGLfRPMFwCW8WDRM0HJA92qV6pmcISR/s1z2qzOtBy2/FtfwLafDOK4VMR9YY8NEiQCANvNivmEohGF//F257mCYs/xCkICvVfwb5tWZ40oi17DmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m40G5ODeVYSj61nhtw0YJIWEK7v0iUvLmj8cUjK3vNs=;
 b=f6R0JQ/rk/+bqqP3ZPAqQRFSP/OncBsUGChAk8Q2mc73L2E8jK0AZ2jjosNlfd+9jwdohbC0XnPtGrwqPdNJJtOLRdeC0h7id9Eaxls7jr7Vli0Qt7Lt5+hD2IFhUvSqmomzndLs2rnzdZsHgYLLcNHYwwp8rX7+TnxzA8CTgrEV7LZ+NIwqMyh20hXAcEua+D4IQxflQgiScx0BbQ3AwSkCm6yZzFMIdc5LkQGHZzYzmaWg/DPpzOzFZqh8fj4YuLtp60MNCefGjclMc2RxSP1O0tHPwSSImUnVXyx/yiH2Frh0k5STRgseRHbyhmo86utoNpPKc7AoggmdsbgfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m40G5ODeVYSj61nhtw0YJIWEK7v0iUvLmj8cUjK3vNs=;
 b=OjeB5E2KengUdUcAZEAkLMgGITMvSjIt2A2yYOvwABgB5MtbXW/byRLBSLEfy6zOr+wol2j7/yeA3TNZjYLy4ng5Jp62iXJbPQidsf2l3jd0uvfEeUln53dSLHWoxyrESBMDb6h+n9tlVkJo2xgQO0BsqPly7I1DVD3gNMq8s8o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 17:11:16 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 17:11:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Scott Mayhew <smayhew@redhat.com>
CC:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
Thread-Topic: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
Thread-Index: AQHXUY/jFV75Fliw8U6toJ2Vas9+e6r2AFQAgAAAzwA=
Date:   Wed, 26 May 2021 17:11:15 +0000
Message-ID: <C16545F8-B5BA-4A7D-A7B4-B07EABB04C25@oracle.com>
References: <20210525180033.200404-1-smayhew@redhat.com>
 <20210525180033.200404-3-smayhew@redhat.com>
 <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
In-Reply-To: <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 239889b5-bffc-41ee-2fe8-08d92069459c
x-ms-traffictypediagnostic: SJ0PR10MB4496:
x-microsoft-antispam-prvs: <SJ0PR10MB4496FE6F09A717E1A429300D93249@SJ0PR10MB4496.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yK91u8SU8OEfcYYhBWGTKsldy2ivCepeLjr6xwP/Dc4pDYbJTt3HuoGIml2RqnVs7W4XAhvu1HqXKTBPfqBz9FzorbopRjDR4126FTnuOdmJMO+9hhT+7HhA/wbsJ4s2sCJR7w23tj0zsV8uGrXap/Dc5wBF0ihYktYQNNhcwOYhW//KlE/9Z/UYLCo29fbQyEvVNH9x5TSkUab86mATbmYrweFqp/FHalWZuRyF6FQAXZ1YuVIUH01yEMmRZKBY2GUsyRCrKhRlYNQkR/3m8/VwUnRiRh4N15fFwQGMzZZ56iaLfvwxqOaKAUxP8Qk0XpBzU7acsWxMnBkqxCpAhK+UlOUFp0zeAeWu0UaVM7ykBGmeh15agVOt8EH6EC8yj3v3+BhIMkzqR+J3GP4E5yykgTK/XzOV0x3zunLaacJjYt+gb1qngyeY6Ep4VNiN+eLhR0iXYed8CFqGx+gI0cPhYJQgCghW8FiFBjH7KOC6lHrEvBZ4XtwsDQv/7I7z5CQXDRI5+nVSyPFwx20e8LU/IIQCu1CSep4Z85EmRJH5JTc43JGFHRsfqqGbAWScqICCnLWmLIj6IZsecsTlBv3Uy1zobfEINxtQ0eZNQL4UGoxsOppTT9ge/7FhyGr+8sUJFOz2j0VjoFt6EqhxB8wcD/1JJcpPW6j9/2gKWFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(396003)(376002)(136003)(186003)(26005)(6486002)(2906002)(2616005)(91956017)(76116006)(64756008)(36756003)(5660300002)(33656002)(66946007)(66476007)(66556008)(30864003)(66446008)(122000001)(83380400001)(54906003)(86362001)(53546011)(6506007)(38100700002)(8676002)(6512007)(478600001)(4326008)(6916009)(316002)(8936002)(71200400001)(45980500001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?agMsxqzKdUI1hOViTFEuEfzicaO+zhBcei74Fa/1HdSjxVOKSxgdDmU4lEim?=
 =?us-ascii?Q?pTcfYd1GqdwwvaHRs2YfmXUQ43FnZ0hOX9gHElTySqsAw5AT6B+uEaxroCOB?=
 =?us-ascii?Q?P/knRV3k/zAf5+WzDZ3q3p5uh24fQ3UioEgHu3ASuxrtxQnfYkrjdFYF6skV?=
 =?us-ascii?Q?+rqxgfPkNTUcKHIAB9WIMhhkxMfwYhEpFcjhrw4pe4TOz9KAKGxSzb1LyWqC?=
 =?us-ascii?Q?yXXBaaJeu6ZKVfXklIiIw5O2OFUD0kThsgrU4FaVzb3IIqZAgwBBDmjrjtLg?=
 =?us-ascii?Q?upkJZiZaewgMw4g3BYfZh7YG8MRWfjs9peV/4k8QXf4itz9xHDRsFG/Kz+bl?=
 =?us-ascii?Q?n7cYTJRu3QU1t0bM2Khzn4mGTV4s8nVZpKepAk+hUmXgK9NXIqqC0JDeqKIN?=
 =?us-ascii?Q?eTdWEVq/6mfNDk5GHtfFKCWO+PiUjdQaqCd5BThOcNq3LAmYbwMItVTqUCYQ?=
 =?us-ascii?Q?PBQwEg/sO+NVcMU+MFuPPomkFkThhrGBB3Gr2jpmEItpgOTeFxaRMJrdBd+n?=
 =?us-ascii?Q?s0p9kANlvrrvEZjFUwbGJaHNWJsEKOv3U418ZeJkNqO+0oudWyqzJv3ZWA7o?=
 =?us-ascii?Q?HzXW0trkMxyXhV4Gn2BEXgtvdiejFbBMzIGhMxUe4BVspz4pZcVrNDpxmT/b?=
 =?us-ascii?Q?qpt1k/9tH7WMxwPLffeQS2ArkzOu4nRdYQfHdPhklPCGDw6dmdHbzMSWSb7E?=
 =?us-ascii?Q?8kRwTrhcFzcxbYxNICrW7m4EZfUBqWFVXPAjO6J567PCih13zpWAk/OQ8t5o?=
 =?us-ascii?Q?lvgnQx+qT6PCDb7NE8rWEHznoc2dw1PU4QeGGaUdipPozXFiImP+ctUQAD7w?=
 =?us-ascii?Q?YoWbgmKzMauTmXStcc5vpjwixouct8MYSxZ8FSsL5apnn1v7ICNjExFvc6cH?=
 =?us-ascii?Q?YFHAfNvxLYNy7y4b4rgDcifmzNlormgpPD7RsSGQoirIqJ68r0WeuGZPafos?=
 =?us-ascii?Q?45vXeqpLKdyOxqo23uh/RkwQnRwLj3HKeYHCx2XLZALj5wu6yacOASK5SrOC?=
 =?us-ascii?Q?amvhI+77YhQixJvV6P98NvAZOt8EyqLY9KLGhMLXDwMF4ixkOxCuZTOQko8o?=
 =?us-ascii?Q?GpHJKuBit2z3V7UTtS/VDXKKkBknf39356py1V2KAPlVbPceva4UJuBe1l1u?=
 =?us-ascii?Q?3al/Sx71vcSOGnVaJedUmQsFEtlsonKd48PopvcMmbHjVlQgT74mMco0C6cw?=
 =?us-ascii?Q?xUpdYny7X+PKSf3gTodJMZqIOIjdsDCJS3GNJQu0lwS+Y6vewNkgAyTkhQbs?=
 =?us-ascii?Q?A83bS+eORRYqi/Lwbp3Tp9NUBno451BcoYPM/YOSIxM73LbmyVfpaoQ6Hgra?=
 =?us-ascii?Q?qHtex+xITcdl2Vi+3TFYvW4I?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B777CEBAFE0C864EB135E066B39BB737@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239889b5-bffc-41ee-2fe8-08d92069459c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 17:11:15.9511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyRJkFJXVrwoAAPk86fmuXFU/xypnqzk1/x2NVoz4S6vx11/m3mcujyLdAgPxLtd1tT6f29CnoLd3GiZlUUamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260116
X-Proofpoint-GUID: YKUfZTeOThH7ynFZ_GfgjI-vgoUq7m4e
X-Proofpoint-ORIG-GUID: YKUfZTeOThH7ynFZ_GfgjI-vgoUq7m4e
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260116
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott-


> On May 26, 2021, at 1:08 PM, Steve Dickson <SteveD@RedHat.com> wrote:
>=20
> Hey!
>=20
> Again... a few very small teaks=20
>=20
> On 5/25/21 2:00 PM, Scott Mayhew wrote:
>> Add a global list of active upcalls and a watchdog thread that walks the
>> list, looking for threads running longer than timeout seconds.  By
>> default, the watchdog thread will cancel these threads and report an
>> error of -ETIMEDOUT to the kernel.  Passing the -C option or setting
>> cancel-timed-out-upcalls=3D0 in nfs.conf disables this behavior and
>> causes the watchdog thread to simply log an error message instead.  The
>> upcall timeout can be specified by passing the -U option or by setting
>> the upcall-timeout parameter in nfs.conf.

Not a critique of this patch, but I'm wondering if there's any
way to get a sense of why each stuck thread was hung so we (or
the local admin) can understand the underlying problems. Maybe
that's something for another day.


>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>> ---
>> nfs.conf               |   2 +
>> utils/gssd/gssd.c      | 125 +++++++++++++++++++++++++++++++++++++++-
>> utils/gssd/gssd.h      |  15 +++++
>> utils/gssd/gssd.man    |  31 +++++++++-
>> utils/gssd/gssd_proc.c | 127 ++++++++++++++++++++++++++++++++---------
>> 5 files changed, 270 insertions(+), 30 deletions(-)
>>=20
>> diff --git a/nfs.conf b/nfs.conf
>> index 31994f61..7a987788 100644
>> --- a/nfs.conf
>> +++ b/nfs.conf
>> @@ -25,6 +25,8 @@
>> # cred-cache-directory=3D
>> # preferred-realm=3D
>> # set-home=3D1
>> +# upcall-timeout=3D30
>> +# cancel-timed-out-upcalls=3D1
>> #
>> [lockd]
>> # port=3D0
>> diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
>> index eb440470..54a1ea3f 100644
>> --- a/utils/gssd/gssd.c
>> +++ b/utils/gssd/gssd.c
>> @@ -95,9 +95,15 @@ static bool use_gssproxy =3D false;
>> pthread_mutex_t clp_lock =3D PTHREAD_MUTEX_INITIALIZER;
>> static bool signal_received =3D false;
>> static struct event_base *evbase =3D NULL;
>> +pthread_mutex_t active_thread_list_lock =3D PTHREAD_MUTEX_INITIALIZER;
>> +
>> +int upcall_timeout =3D DEF_UPCALL_TIMEOUT;
>> +static bool cancel_timed_out_upcalls =3D true;
>>=20
>> TAILQ_HEAD(topdir_list_head, topdir) topdir_list;
>>=20
>> +TAILQ_HEAD(active_thread_list_head, upcall_thread_info) active_thread_l=
ist;
>> +
>> struct topdir {
>> 	TAILQ_ENTRY(topdir) list;
>> 	TAILQ_HEAD(clnt_list_head, clnt_info) clnt_list;
>> @@ -436,6 +442,100 @@ gssd_clnt_krb5_cb(int UNUSED(fd), short UNUSED(whi=
ch), void *data)
>> 	handle_krb5_upcall(clp);
>> }
>>=20
>> +static int
>> +scan_active_thread_list(void)
>> +{
>> +	struct upcall_thread_info *info;
>> +	struct timespec now;
>> +	unsigned int sleeptime;
>> +	bool sleeptime_set =3D false;
>> +	int err;
>> +	void *tret, *saveprev;
>> +
>> +	sleeptime =3D upcall_timeout;
>> +	pthread_mutex_lock(&active_thread_list_lock);
>> +	clock_gettime(CLOCK_MONOTONIC, &now);
>> +	TAILQ_FOREACH(info, &active_thread_list, list) {
>> +		err =3D pthread_tryjoin_np(info->tid, &tret);
>> +		switch (err) {
>> +		case 0:
>> +			if (tret =3D=3D PTHREAD_CANCELED)
>> +				printerr(3, "watchdog: thread id 0x%lx cancelled successfully\n",
>> +						info->tid);
>> +			saveprev =3D info->list.tqe_prev;
>> +			TAILQ_REMOVE(&active_thread_list, info, list);
>> +			free(info);
>> +			info =3D saveprev;
>> +			break;
>> +		case EBUSY:
>> +			if (now.tv_sec >=3D info->timeout.tv_sec) {
>> +				if (cancel_timed_out_upcalls && !info->cancelled) {
>> +					printerr(0, "watchdog: thread id 0x%lx timed out\n",
>> +							info->tid);
>> +					pthread_cancel(info->tid);
>> +					info->cancelled =3D true;
>> +					do_error_downcall(info->fd, info->uid, -ETIMEDOUT);
>> +				} else {
>> +					printerr(0, "watchdog: thread id 0x%lx running for %ld seconds\n",
>> +							info->tid,
>> +							now.tv_sec - info->timeout.tv_sec + upcall_timeout);
> If people are going to used the -C flag they are saying they want
> to ignore hung threads so I'm thinking with printerr(0) we would
> be filling up their logs about messages they don't care about.
> So I'm thinking we should change this to a printerr(1)=20
>=20
>> +				}
>> +			} else if (!sleeptime_set) {
>> +				sleeptime =3D info->timeout.tv_sec - now.tv_sec;
>> +				sleeptime_set =3D true;
>> +			}
>> +			break;
>> +		default:
>> +			printerr(0, "watchdog: attempt to join thread id 0x%lx returned %d (=
%s)!\n",
>> +					info->tid, err, strerror(err));
>> +			break;
>> +		}
>> +	}
>> +	pthread_mutex_unlock(&active_thread_list_lock);
>> +
>> +	return sleeptime;
>> +}
>> +
>> +static void *
>> +watchdog_thread_fn(void *UNUSED(arg))
>> +{
>> +	unsigned int sleeptime;
>> +
>> +	for (;;) {
>> +		sleeptime =3D scan_active_thread_list();
>> +		printerr(4, "watchdog: sleeping %u secs\n", sleeptime);
>> +		sleep(sleeptime);
>> +	}
>> +	return (void *)0;
>> +}
>> +
>> +static int
>> +start_watchdog_thread(void)
>> +{
>> +	pthread_attr_t attr;
>> +	pthread_t th;
>> +	int ret;
>> +
>> +	ret =3D pthread_attr_init(&attr);
>> +	if (ret !=3D 0) {
>> +		printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
>> +			 ret, strerror(errno));
>> +		return ret;
>> +	}
>> +	ret =3D pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
>> +	if (ret !=3D 0) {
>> +		printerr(0, "ERROR: failed to create pthread attr: ret %d: %s\n",
>> +			 ret, strerror(errno));
>> +		return ret;
>> +	}
>> +	ret =3D pthread_create(&th, &attr, watchdog_thread_fn, NULL);
>> +	if (ret !=3D 0) {
>> +		printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
>> +			 ret, strerror(errno));
>> +	}
>> +	return ret;
>> +}
>> +
>> static struct clnt_info *
>> gssd_get_clnt(struct topdir *tdi, const char *name)
>> {
>> @@ -825,7 +925,7 @@ sig_die(int signal)
>> static void
>> usage(char *progname)
>> {
>> -	fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir=
] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D] [-H]\n"=
,
>> +	fprintf(stderr, "usage: %s [-f] [-l] [-M] [-n] [-v] [-r] [-p pipefsdir=
] [-k keytab] [-d ccachedir] [-t timeout] [-R preferred realm] [-D] [-H] [-=
U upcall timeout] [-C]\n",
>> 		progname);
>> 	exit(1);
>> }
>> @@ -846,6 +946,9 @@ read_gss_conf(void)
>> #endif
>> 	context_timeout =3D conf_get_num("gssd", "context-timeout", context_tim=
eout);
>> 	rpc_timeout =3D conf_get_num("gssd", "rpc-timeout", rpc_timeout);
>> +	upcall_timeout =3D conf_get_num("gssd", "upcall-timeout", upcall_timeo=
ut);
>> +	cancel_timed_out_upcalls =3D conf_get_bool("gssd", "cancel-timed-out-u=
pcalls",
>> +						cancel_timed_out_upcalls);
>> 	s =3D conf_get_str("gssd", "pipefs-directory");
>> 	if (!s)
>> 		s =3D conf_get_str("general", "pipefs-directory");
>> @@ -887,7 +990,7 @@ main(int argc, char *argv[])
>> 	verbosity =3D conf_get_num("gssd", "verbosity", verbosity);
>> 	rpc_verbosity =3D conf_get_num("gssd", "rpc-verbosity", rpc_verbosity);
>>=20
>> -	while ((opt =3D getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:")) !=3D -1) =
{
>> +	while ((opt =3D getopt(argc, argv, "HDfvrlmnMp:k:d:t:T:R:U:C")) !=3D -=
1) {
>> 		switch (opt) {
>> 			case 'f':
>> 				fg =3D 1;
>> @@ -938,6 +1041,11 @@ main(int argc, char *argv[])
>> 			case 'H':
>> 				set_home =3D false;
>> 				break;
>> +			case 'U':
>> +				upcall_timeout =3D atoi(optarg);
>> +				break;
>> +			case 'C':
>> +				cancel_timed_out_upcalls =3D false;
>> 			default:
>> 				usage(argv[0]);
>> 				break;
>> @@ -1010,6 +1118,11 @@ main(int argc, char *argv[])
>> 	else
>> 		progname =3D argv[0];
>>=20
>> +	if (upcall_timeout > MAX_UPCALL_TIMEOUT)
>> +		upcall_timeout =3D MAX_UPCALL_TIMEOUT;
>> +	else if (upcall_timeout < MIN_UPCALL_TIMEOUT)
>> +		upcall_timeout =3D MIN_UPCALL_TIMEOUT;
>> +
>> 	initerr(progname, verbosity, fg);
>> #ifdef HAVE_LIBTIRPC_SET_DEBUG
>> 	/*
>> @@ -1068,6 +1181,14 @@ main(int argc, char *argv[])
>> 	}
>> 	event_add(inotify_ev, NULL);
>>=20
>> +	TAILQ_INIT(&active_thread_list);
>> +
>> +	rc =3D start_watchdog_thread();
>> +	if (rc !=3D 0) {
>> +		printerr(0, "ERROR: failed to start watchdog thread: %d\n", rc);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> 	TAILQ_INIT(&topdir_list);
>> 	gssd_scan();
>> 	daemon_ready();
>> diff --git a/utils/gssd/gssd.h b/utils/gssd/gssd.h
>> index 6d53647e..ad0d1d93 100644
>> --- a/utils/gssd/gssd.h
>> +++ b/utils/gssd/gssd.h
>> @@ -50,6 +50,11 @@
>> #define GSSD_DEFAULT_KEYTAB_FILE		"/etc/krb5.keytab"
>> #define GSSD_SERVICE_NAME			"nfs"
>> #define RPC_CHAN_BUF_SIZE			32768
>> +
> I think we should add a "/* seconds */"=20
> so you don't have dig in the code=20
> to see what interval is=20
>> +#define MIN_UPCALL_TIMEOUT			5
>> +#define DEF_UPCALL_TIMEOUT			30
>> +#define MAX_UPCALL_TIMEOUT			600
>> +
>> /*
>>  * The gss mechanisms that we can handle
>>  */
>> @@ -91,10 +96,20 @@ struct clnt_upcall_info {
>> 	char			*service;
>> };
>>=20
>> +struct upcall_thread_info {
>> +	TAILQ_ENTRY(upcall_thread_info) list;
>> +	pthread_t		tid;
>> +	struct timespec		timeout;
>> +	uid_t			uid;
>> +	int			fd;
>> +	bool			cancelled;
>> +};
>> +
>> void handle_krb5_upcall(struct clnt_info *clp);
>> void handle_gssd_upcall(struct clnt_info *clp);
>> void free_upcall_info(struct clnt_upcall_info *info);
>> void gssd_free_client(struct clnt_info *clp);
>> +int do_error_downcall(int k5_fd, uid_t uid, int err);
>>=20
>>=20
>> #endif /* _RPC_GSSD_H_ */
>> diff --git a/utils/gssd/gssd.man b/utils/gssd/gssd.man
>> index 9ae6def9..20fea729 100644
>> --- a/utils/gssd/gssd.man
>> +++ b/utils/gssd/gssd.man
>> @@ -8,7 +8,7 @@
>> rpc.gssd \- RPCSEC_GSS daemon
>> .SH SYNOPSIS
>> .B rpc.gssd
>> -.RB [ \-DfMnlvrH ]
>> +.RB [ \-DfMnlvrHC ]
>> .RB [ \-k
>> .IR keytab ]
>> .RB [ \-p
>> @@ -17,6 +17,10 @@ rpc.gssd \- RPCSEC_GSS daemon
>> .IR ccachedir ]
>> .RB [ \-t
>> .IR timeout ]
>> +.RB [ \-T
>> +.IR timeout ]
>> +.RB [ \-U
>> +.IR timeout ]
>> .RB [ \-R
>> .IR realm ]
>> .SH INTRODUCTION
>> @@ -275,7 +279,7 @@ seconds, which allows changing Kerberos tickets and =
identities frequently.
>> The default is no explicit timeout, which means the kernel context will =
live
>> the lifetime of the Kerberos service ticket used in its creation.
>> .TP
>> -.B -T timeout
>> +.BI "-T " timeout
>> Timeout, in seconds, to create an RPC connection with a server while
>> establishing an authenticated gss context for a user.
>> The default timeout is set to 5 seconds.
>> @@ -283,6 +287,18 @@ If you get messages like "WARNING: can't create tcp=
 rpc_clnt to server
>> %servername% for user with uid %uid%: RPC: Remote system error -
>> Connection timed out", you should consider an increase of this timeout.
>> .TP
>> +.BI "-U " timeout
>> +Timeout, in seconds, for upcall threads.  Threads executing longer than
>> +.I timeout
>> +seconds will be cancelled and an error of -ETIMEDOUT will be reported
>> +to the kernel.  The default
>> +.I timeout
>> +is 30 seconds.  The minimum is 5 seconds.  The maximum is 600 seconds.
>> +.TP
>> +.B -C
>> +Instead of cancelling upcall threads that have timed out, cause an erro=
r
>> +message to be logged to the syslog (no error will be reported to the ke=
rnel).
>> +.TP
>> .B -H
>> Avoids setting $HOME to "/". This allows rpc.gssd to read per user k5ide=
ntity
>> files versus trying to read /.k5identity for each user.
>> @@ -350,6 +366,17 @@ Equivalent to
>> Equivalent to
>> .BR -R .
>> .TP
>> +.B upcall-timeout
>> +Equivalent to
>> +.BR -U .
>> +.TP
>> +.B cancel-timed-out-upcalls
>> +Setting to
>> +.B false
>> +is equivalent to providing the
>> +.B -C
>> +flag.
>> +.TP
>> .B set-home
>> Setting to
>> .B false
>> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
>> index ba508b30..ac7b1d1c 100644
>> --- a/utils/gssd/gssd_proc.c
>> +++ b/utils/gssd/gssd_proc.c
>> @@ -81,11 +81,23 @@
>> #include "gss_names.h"
>>=20
>> extern pthread_mutex_t clp_lock;
>> +extern pthread_mutex_t active_thread_list_lock;
>> +extern int upcall_timeout;
>> +extern TAILQ_HEAD(active_thread_list_head, upcall_thread_info) active_t=
hread_list;
>>=20
>> /* Encryption types supported by the kernel rpcsec_gss code */
>> int num_krb5_enctypes =3D 0;
>> krb5_enctype *krb5_enctypes =3D NULL;
>>=20
>> +struct cleanup_args  {
>> +	OM_uint32 	*min_stat;
>> +	gss_buffer_t	acceptor;
>> +	gss_buffer_t	token;
>> +	struct authgss_private_data *pd;
>> +	AUTH		**auth;
>> +	CLIENT		**rpc_clnt;
>> +};
>> +
>> /*
>>  * Parse the supported encryption type information
>>  */
>> @@ -184,7 +196,7 @@ out_err:
>> 	return;
>> }
>>=20
>> -static int
>> +int
>> do_error_downcall(int k5_fd, uid_t uid, int err)
>> {
>> 	char	buf[1024];
>> @@ -607,14 +619,37 @@ out:
>> 	return auth;
>> }
>>=20
>> +static void
>> +cleanup_handler(void *arg)
>> +{
>> +	struct cleanup_args *args =3D (struct cleanup_args *)arg;
>> +
>> +	gss_release_buffer(args->min_stat, args->acceptor);
>> +	if (args->token->value)
>> +		free(args->token->value);
>> +#ifdef HAVE_AUTHGSS_FREE_PRIVATE_DATA
>> +	if (args->pd->pd_ctx_hndl.length !=3D 0 || args->pd->pd_ctx !=3D 0)
>> +		authgss_free_private_data(args->pd);
>> +#endif
>> +	if (*args->auth)
>> +		AUTH_DESTROY(*args->auth);
>> +	if (*args->rpc_clnt)
>> +		clnt_destroy(*args->rpc_clnt);
>> +}
>> +
>> /*
>>  * this code uses the userland rpcsec gss library to create a krb5
>>  * context on behalf of the kernel
>>  */
>> static void
>> -process_krb5_upcall(struct clnt_info *clp, uid_t uid, int fd, char *src=
host,
>> -		    char *tgtname, char *service)
>> +process_krb5_upcall(struct clnt_upcall_info *info)
>> {
>> +	struct clnt_info	*clp =3D info->clp;
>> +	uid_t			uid =3D info->uid;
>> +	int			fd =3D info->fd;
>> +	char			*srchost =3D info->srchost;
>> +	char			*tgtname =3D info->target;
>> +	char			*service =3D info->service;
>> 	CLIENT			*rpc_clnt =3D NULL;
>> 	AUTH			*auth =3D NULL;
>> 	struct authgss_private_data pd;
>> @@ -624,11 +659,13 @@ process_krb5_upcall(struct clnt_info *clp, uid_t u=
id, int fd, char *srchost,
>> 	gss_name_t		gacceptor =3D GSS_C_NO_NAME;
>> 	gss_OID			mech;
>> 	gss_buffer_desc		acceptor  =3D {0};
>> +	struct cleanup_args cleanup_args =3D {&min_stat, &acceptor, &token, &p=
d, &auth, &rpc_clnt};
>>=20
>> 	token.length =3D 0;
>> 	token.value =3D NULL;
>> 	memset(&pd, 0, sizeof(struct authgss_private_data));
>>=20
>> +	pthread_cleanup_push(cleanup_handler, &cleanup_args);
>> 	/*
>> 	 * If "service" is specified, then the kernel is indicating that
>> 	 * we must use machine credentials for this request.  (Regardless
>> @@ -650,6 +687,7 @@ process_krb5_upcall(struct clnt_info *clp, uid_t uid=
, int fd, char *srchost,
>> 	 * used for this case is not important.
>> 	 *
>> 	 */
>> +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
>> 	if (uid !=3D 0 || (uid =3D=3D 0 && root_uses_machine_creds =3D=3D 0 &&
>> 				service =3D=3D NULL)) {
>>=20
>> @@ -670,15 +708,21 @@ process_krb5_upcall(struct clnt_info *clp, uid_t u=
id, int fd, char *srchost,
>> 			goto out_return_error;
>> 		}
>> 	}
>> +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>> +	pthread_testcancel();
>>=20
>> +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
>> 	if (!authgss_get_private_data(auth, &pd)) {
>> 		printerr(1, "WARNING: Failed to obtain authentication "
>> 			    "data for user with uid %d for server %s\n",
>> 			 uid, clp->servername);
>> 		goto out_return_error;
>> 	}
>> +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>> +	pthread_testcancel();
>>=20
>> 	/* Grab the context lifetime and acceptor name out of the ctx. */
>> +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
>> 	maj_stat =3D gss_inquire_context(&min_stat, pd.pd_ctx, NULL, &gacceptor=
,
>> 				       &lifetime_rec, &mech, NULL, NULL, NULL);
>>=20
>> @@ -690,37 +734,35 @@ process_krb5_upcall(struct clnt_info *clp, uid_t u=
id, int fd, char *srchost,
>> 		get_hostbased_client_buffer(gacceptor, mech, &acceptor);
>> 		gss_release_name(&min_stat, &gacceptor);
>> 	}
>> +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>> +	pthread_testcancel();
>>=20
>> 	/*
>> 	 * The serialization can mean turning pd.pd_ctx into a lucid context. I=
f
>> 	 * that happens then the pd.pd_ctx will be unusable, so we must never
>> 	 * try to use it after this point.
>> 	 */
>> +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
>> 	if (serialize_context_for_kernel(&pd.pd_ctx, &token, &krb5oid, NULL)) {
>> 		printerr(1, "WARNING: Failed to serialize krb5 context for "
>> 			    "user with uid %d for server %s\n",
>> 			 uid, clp->servername);
>> 		goto out_return_error;
>> 	}
>> +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>> +	pthread_testcancel();
>>=20
>> 	do_downcall(fd, uid, &pd, &token, lifetime_rec, &acceptor);
>>=20
>> out:
>> -	gss_release_buffer(&min_stat, &acceptor);
>> -	if (token.value)
>> -		free(token.value);
>> -#ifdef HAVE_AUTHGSS_FREE_PRIVATE_DATA
>> -	if (pd.pd_ctx_hndl.length !=3D 0 || pd.pd_ctx !=3D 0)
>> -		authgss_free_private_data(&pd);
>> -#endif
>> -	if (auth)
>> -		AUTH_DESTROY(auth);
>> -	if (rpc_clnt)
>> -		clnt_destroy(rpc_clnt);
>> +	pthread_cleanup_pop(1);
>>=20
>> 	return;
>>=20
>> out_return_error:
>> +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>> +	pthread_testcancel();
>> +
>> 	do_error_downcall(fd, uid, downcall_err);
>> 	goto out;
>> }
>> @@ -786,38 +828,71 @@ void free_upcall_info(struct clnt_upcall_info *inf=
o)
>> }
>>=20
>> static void
>> -gssd_work_thread_fn(struct clnt_upcall_info *info)
>> +cleanup_clnt_upcall_info(void *arg)
>> {
>> -	process_krb5_upcall(info->clp, info->uid, info->fd, info->srchost, inf=
o->target, info->service);
>> +	struct clnt_upcall_info *info =3D (struct clnt_upcall_info *)arg;
>> +
>> 	free_upcall_info(info);
>> }
>>=20
>> +static void
>> +gssd_work_thread_fn(struct clnt_upcall_info *info)
>> +{
>> +	pthread_cleanup_push(cleanup_clnt_upcall_info, info);
>> +	process_krb5_upcall(info);
>> +	pthread_cleanup_pop(1);
>> +}
>> +
>> +static struct upcall_thread_info *
>> +alloc_upcall_thread_info(void)
>> +{
>> +	struct upcall_thread_info *info;
>> +
>> +	info =3D malloc(sizeof(struct upcall_thread_info));
>> +	if (info =3D=3D NULL)
>> +		return NULL;
>> +	memset(info, 0, sizeof(*info));
>> +	return info;
>> +}
>> +
>> static int
>> -start_upcall_thread(void (*func)(struct clnt_upcall_info *), void *info=
)
>> +start_upcall_thread(void (*func)(struct clnt_upcall_info *), struct cln=
t_upcall_info *info)
>> {
>> 	pthread_attr_t attr;
>> 	pthread_t th;
>> +	struct upcall_thread_info *tinfo;
>> 	int ret;
>>=20
>> +	tinfo =3D alloc_upcall_thread_info();
>> +	if (!tinfo)
>> +		return -ENOMEM;
>> +	tinfo->fd =3D info->fd;
>> +	tinfo->uid =3D info->uid;
>> +	tinfo->cancelled =3D false;
>> +
>> 	ret =3D pthread_attr_init(&attr);
>> 	if (ret !=3D 0) {
>> 		printerr(0, "ERROR: failed to init pthread attr: ret %d: %s\n",
>> 			 ret, strerror(errno));
>> -		return ret;
>> -	}
>> -	ret =3D pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
>> -	if (ret !=3D 0) {
>> -		printerr(0, "ERROR: failed to create pthread attr: ret %d: "
>> -			 "%s\n", ret, strerror(errno));
>> +		free(tinfo);
>> 		return ret;
>> 	}
>>=20
>> 	ret =3D pthread_create(&th, &attr, (void *)func, (void *)info);
>> -	if (ret !=3D 0)
>> +	if (ret !=3D 0) {
>> 		printerr(0, "ERROR: pthread_create failed: ret %d: %s\n",
>> 			 ret, strerror(errno));
>> -	else
>> -		printerr(0, "created thread id 0x%lx\n", th);
>> +		free(tinfo);
>> +		return ret;
>> +	}
>> +	printerr(1, "created thread id 0x%lx\n", th);
> This will be removed...=20
>> +	tinfo->tid =3D th;
>> +	pthread_mutex_lock(&active_thread_list_lock);
>> +	clock_gettime(CLOCK_MONOTONIC, &tinfo->timeout);
>> +	tinfo->timeout.tv_sec +=3D upcall_timeout;
>> +	TAILQ_INSERT_TAIL(&active_thread_list, tinfo, list);
>> +	pthread_mutex_unlock(&active_thread_list_lock);
>> +
>> 	return ret;
>> }
>>=20
>>=20
>=20
> Overall I think the code is very well written with
> one exception... The lack of comments. I think it
> would be very useful to let the reader know what
> you are doing and why.... But by no means is=20
> that a show stopper. Nice work!
>=20
> I'm still doing more testing and nothing=20
> is breaking... So it is looking pretty good!
>=20
> steved.
>=20

--
Chuck Lever



