Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5145A676
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhKWPZD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 10:25:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6662 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhKWPZC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 10:25:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANFC4oT008367;
        Tue, 23 Nov 2021 15:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Fy+Ux7/x9bdKIROAISuxy9JIM9tZxtld7P5gf+odT3Q=;
 b=eyxMBmX3CRVI8sZNL4gl/4Hq4ws33VPlWw/DbRWaalUPT+7qbYUbnMGu7LkjYuWJH8Dz
 Q14DfVqvQqCvB6r/xyxWFYWIK9Pw69drFpNB/WOYvxECpd9Z+6Mq4P52OmZXUTOdpAaj
 XyIKLPTS2BwLWM+jJw+xm1sG4Ip58C/uf3618j78NEwNJpAhP/soLIHUKtIIY7+IXeyC
 jEmHmc1YOTN+dG/ZldIP5uuaS+qdoRYPLOXLICDdYFx3h+eiV9zLwXOIA0h+lg3EQlMv
 CPFpXdekSTXZg2x+v8HbP9nqs0800Oa4/dq6OY6EykgFyFt2Z1sk+B2EC/tTfov+YwT9 Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg461hv14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 15:21:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANFGcHF160352;
        Tue, 23 Nov 2021 15:21:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3cep4yjycx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 15:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbOLGAo7SfCN6RloOx+8U/r+LE8naXon3fVIaMTlTOWsKfoYE+7V6FupZf9VO7me8MjcbvZOdAKHrS0uJS+2EUdEm0FHs15vNe/0WUQ5lGZe8E6YBl/SWOmywlABH+SnYRSk/Vdp08MDGDbTwEnWIsYQgf80OCn4utGzG0OpbdB1VvagIGTld8WAQ+f0HHk/vmQhtA+VGoywqK+xHrAc5Ljx/3F9hoDx3HuBqLXrarGYrWxqabUGCKjffC5JdAOOoIwSuwYxZ+RK6oksqM7HsvWZFpZsWXpszL6or6nIsAC7OPhIL9WhI+7Jwy8Z4WQTI5BHenx/bIfYOTBC6rTOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy+Ux7/x9bdKIROAISuxy9JIM9tZxtld7P5gf+odT3Q=;
 b=ToppeRrUHYPk7lJUzMA1n8YApx+41t6V1pV6pLsjNhI/viLh6hnmYCpkx1QG6Z/3ekCk7oS9iwqRaAuYjT82JoweXWHoyG86tRJYNoiqaF3ok5yTWfJn1kYUwmStg/mYfvC/1/lr/9FmTsXs/f39fJDpqCKyi6lidN0w5ySolHUWFSiumrGVZupqQE488yHpSPhsjWisfU+hl6R8y6gt2+cbKT5iByr6FvrF+uyNFPmGj4k+Bff/014A4F3i7ga8HoosJI/w51YGKN7Bs9CYdcZkdm1EKoNoT+YEYxVjTj9O8yRCp6rdHWEkPqbo2rra6b44Z5+EVFe4V9KNo/Ln6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy+Ux7/x9bdKIROAISuxy9JIM9tZxtld7P5gf+odT3Q=;
 b=pwhQ7ifkraZuG/emwwk3yQFlm0sqddHMj9ipC6PQXQiOedm8NTnLrmQYW4mI/sfXX7YTYukufqwA8eQm4p4JeWlT364s+sQcz8xvhpOs/1y8XYq9LzP0fTkT0MFC/x+8wcZ9xAbFKZEfTKX3tlGh4llrENr46EqwxEy8/9yziY4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 15:21:42 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 15:21:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Vasily Averin <vvs@virtuozzo.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't put blocked locks on LRU until after
 vfs_lock_file returns
Thread-Topic: [PATCH] nfsd: don't put blocked locks on LRU until after
 vfs_lock_file returns
Thread-Index: AQHX4GTIZQ8O/Wal+UKjnqXW3Az4WawROmkAgAAAb4A=
Date:   Tue, 23 Nov 2021 15:21:42 +0000
Message-ID: <3E5336E5-1FCF-4E9C-A10A-251834C6BA17@oracle.com>
References: <20211123122223.69236-1-jlayton@kernel.org>
 <d3f68639-3f07-dbf7-9a4d-984fdd7bd62f@virtuozzo.com>
In-Reply-To: <d3f68639-3f07-dbf7-9a4d-984fdd7bd62f@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d94055a-3da7-4910-4cef-08d9ae94f427
x-ms-traffictypediagnostic: BY5PR10MB4385:
x-microsoft-antispam-prvs: <BY5PR10MB438560861C78622FAB56156193609@BY5PR10MB4385.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ybdp68F7n8hMPgtkgIIDpOpK3brFUW1Gksk8tSzUs8MNn1cmCZfb0VQ8BcTCD3huVMM+MYQZGqscs6J8Oupw84AXL60tKnZHVvNU8/APEmqPfZA8e8Q6tfac8fwVRB2EcbiUi0TwqKK1ZP6m/IFMTpwjNT4NbVEEt6wa5GSr/lQU7lN8+NCt0uNgsZ4G741mN8INxMz/lJEhB4IwzBsvmzV0rp3u6cfOT7eVec4Km7M+qbunGVcONUUhuHSoYb2d9kLirzV8Zr02LXXi7TPHEa2sg1CtLQh95OtjmedqoDfhYzaU0V5nEWu8m37I/i57Hv4g/Bvtx4U8mjgmv4NjNpgQTDfA+5xizlygY6xSLYJV32cyIpYnebpjAGJrLTKSPYoHqfOlfGyuqLmyKo6Zk3CQhrOf4ocz90hkki+ERJFZPSLMkM6vccNdLnl9OItUOlMtu6t7g6rg9Ym62BhPs2urDheBeYCFe/RO9ESbsr33mWkBTzWxlV9WAwpVxIvDZMU3fIGYWgVC6la8BCm0iF+63brcGIl7iCbn5WFqCJ+aHGJ62a5AO2fFU/Dh372ZII4TBR9SqrWdBWK+EJE14IspSD2UVJ6qBYjEB4mrE9HeftGxwIUEhldjh1Lohb1cwbHJX5y8jPODyeMqpvZHTB8l59HGb1fXu/8we+vHofbB+c8p6T+st/PlAHtpEFHyvY/7o0AdMNXNCnGyQ54rzVlqozwLwBQmxQs7MouXPKC2s0CpIaypUVuh0j+Pflg8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(91956017)(15650500001)(66946007)(6512007)(186003)(53546011)(38100700002)(8936002)(64756008)(66556008)(110136005)(54906003)(6486002)(2616005)(38070700005)(66476007)(316002)(76116006)(26005)(5660300002)(2906002)(122000001)(4326008)(66446008)(83380400001)(33656002)(86362001)(71200400001)(6506007)(508600001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JX0AjTg7SkPn6J9mb5HQrGT+gXjZJiXbqdOCPczFazovPcilBzI+AN+zbo3x?=
 =?us-ascii?Q?XcFcKwoAlzSnCB25719zd68EZedx6yZnmECD1kRfI2Kn1mkSHw2iiMPxLLfc?=
 =?us-ascii?Q?Y0kTxzGYZRf42nBORsWzbvi5HOuM269uyXR/jO++XY/SzFH8YE3GQolhL10E?=
 =?us-ascii?Q?VtfU+DQmXlAKDE0z+U/QKT+h3OIB29Tu3HRcUnlrXKnrt3fpOm8U8Bl7rBU+?=
 =?us-ascii?Q?Yr/9ZBI6no7ip4QpkmW9koNaiKH7edihlFEUMksr1Z2nPVKMh03qUJfl+NMs?=
 =?us-ascii?Q?9pYT3yL6w8dU1ll5r4gOOc5UIDuZhp2yGniKAxm2rxOPhz6PRzc5ZIKyI7UO?=
 =?us-ascii?Q?eFgK8g7V9qkk+PYdoR2vTwYX4bkxsiIWkJ29vlO3QdlI4iylT+ZjLNDHg4oF?=
 =?us-ascii?Q?DXPYkscYX5TMavMB3OKtkUVcII7q8MQLNUhG2KlLpycrQQ1KeAPUq1VG9wxO?=
 =?us-ascii?Q?0gupIhRtYvOzkdaILh9X5E3eVJJRam7UepF3c9aSg4k9sFYT7mEpTNWe4SAe?=
 =?us-ascii?Q?s43FUP9409QC6AP9YF6udmuGTp2klRsibybzhaSBnFwZq/ilI8HB/XmQ8W8K?=
 =?us-ascii?Q?BhZnvWOQp5KC2tXrZwgqJPh0YgRM6iWX/p/b4sNchzxu+6RbzuZQP0sBYCUZ?=
 =?us-ascii?Q?YJDe4Pehl+r46+B6xqQ22/xfLaXK7tJgWOVE72wfOPLYsl078E0Xq+HDMOW2?=
 =?us-ascii?Q?KcrICqHwbFtkfcIe9Xrdotf6vu8hK7LdB1nqnEXpCLldtrpQKV8laygP5TEB?=
 =?us-ascii?Q?nAueNgw0WuZkiBASs7KtUorHAXtxZ0mhcnr3JHNBKI9r5NWz2fPBrrUJ1V9N?=
 =?us-ascii?Q?YRNByY5uiyXj3ZC/0Cz3stLHDKyOTQX9BvlDYqw4rBGA0v0AXlQqj1xmm+Ka?=
 =?us-ascii?Q?mzfhjZ6qTlD78G36C9hr7W03STxETDXqsfHYqEtwM809NJ9XLBmFqol3sIbj?=
 =?us-ascii?Q?coTBP6MAmhcHAMOPvhsK9IuWsepio4wcMuNXwiLwo017COwpqeU6yfShNf39?=
 =?us-ascii?Q?O07SLXyMkIBK2kmofk4rfbuQIaaA7tvwQo1w/hIQ4ugTRShwDOFWLVd4SDV7?=
 =?us-ascii?Q?+pfM997Y7kyzEokHnD1smYH/BI+/4SuFcthPOVjOtrM7X+9gIZnZbSDz62VK?=
 =?us-ascii?Q?36J8kj8a7OYTuH1vfDzkhYe4Q1mMQ0VMibH3efBxlMfUMJboQsiFApTHEb/A?=
 =?us-ascii?Q?o04jHWWhX0qgjDRLBBntORC1W5LUsF8ZDHgP29BB6fpJ5rgOgM/84BlqeSlp?=
 =?us-ascii?Q?wT3e2mJ2qLRz2qkOqGpbJq3zUt5eY+0JhC+cqfyajMkHawh/R1nna3MTT9Fz?=
 =?us-ascii?Q?ZmgLWrqnj7PKPXsjeSGfc0lF5ZbT6SvOad6man9lMJC9/sTP6VsxnHmlSz/W?=
 =?us-ascii?Q?PayQUx3AJEYNOvL+dZYKmFLXwNr/r/qjzlB46Z+tjBanOPB7Ho/rd6uzhy0U?=
 =?us-ascii?Q?imeGi0ojK5Tz0dmmtl3o+gF1U6IzKXrsPxB2SFN8RbWzYoxj8qT6rv68wg2c?=
 =?us-ascii?Q?PH/+a2X+8FY4Ty4SgP1XJuni7h/GaueaSEeCzYSV/rGqmRn7/Q8wQqazTmdk?=
 =?us-ascii?Q?AY8EIGf/5sIlloVDtvzclYfWneqdwaAih3eH5Sz+oftqSKVXFbH4h5U+Am/H?=
 =?us-ascii?Q?6U7UT4zzxiUUn9aARo2SnqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F29C6FA1EE3A84588C615412057EE75@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d94055a-3da7-4910-4cef-08d9ae94f427
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 15:21:42.3786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rE7+IDEnMM+E8ej1yx/y5NRaGbfsbVBAIT4ggdLOJNkB+D/FqDU3/aTev1Tb4cbp3drkt3g48UuhGBggCR1abw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230080
X-Proofpoint-GUID: UT2EJPN7Hnaf4LkTNTuJZ1LR5BeIZLkp
X-Proofpoint-ORIG-GUID: UT2EJPN7Hnaf4LkTNTuJZ1LR5BeIZLkp
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2021, at 10:20 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>=20
> On 23.11.2021 15:22, Jeff Layton wrote:
>> Vasily reported a case where vfs_lock_file took a very long time to
>> return (longer than a lease period). The laundromat eventually ran and
>> reaped the thing and when the vfs_lock_file returned, it ended up
>> accessing freed memory.
>>=20
>> Don't put entries onto the LRU until vfs_lock_file returns.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 7919d0a27f1e "nfsd: add a LRU list for blocked locks"
>=20
>> Reported-by: Vasily Averin <vvs@virtuozzo.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Vasily Averin <vvs@virtuozzo.com>

I assume Bruce is grabbing this for v5.16-rc.


>> ---
>> fs/nfsd/nfs4state.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index bfad94c70b84..8cfef84b9355 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6966,10 +6966,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>> 	}
>>=20
>> 	if (fl_flags & FL_SLEEP) {
>> -		nbl->nbl_time =3D ktime_get_boottime_seconds();
>> 		spin_lock(&nn->blocked_locks_lock);
>> 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
>> -		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>> 		spin_unlock(&nn->blocked_locks_lock);
>> 	}
>>=20
>> @@ -6982,6 +6980,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>> 			nn->somebody_reclaimed =3D true;
>> 		break;
>> 	case FILE_LOCK_DEFERRED:
>> +		nbl->nbl_time =3D ktime_get_boottime_seconds();
>> +		spin_lock(&nn->blocked_locks_lock);
>> +		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>> +		spin_unlock(&nn->blocked_locks_lock);
>> 		nbl =3D NULL;
>> 		fallthrough;
>> 	case -EAGAIN:		/* conflock holds conflicting lock */
>>=20
>=20

--
Chuck Lever



