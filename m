Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8B31506F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Feb 2021 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBINio (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 08:38:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56038 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhBINiB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Feb 2021 08:38:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119DUqo5128597;
        Tue, 9 Feb 2021 13:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SsbkD3FUAa8YUWT+eehKX5R9svSdT3d67uiTr2Mr8dc=;
 b=LC644iznEVVIVUP+ckY+3Cd6S5Sh7RbZ7KAjHd5Mjh3TyYpsmjQy2XgsuIj1RpsATf9s
 mAPEeniHORkdTYhA/So2P17+Yli5xpXuvB9gjYD9XyA5zPHVVq86za1DR88I2sV9OuLd
 NmIOtlNWmGORWcAK+YvCJ07c1Vl3+S8r3by9oYaCgvh7eFtN3wCMcy/KlttTVdg0zqdO
 4jZs23F/mWnFUOqg0S0U1k5Zy6ffGKSv1vI3Y27NhW/HteKPlKDztvy7wIUVN4/+FdR5
 mFvFaQCf8ZO5TOzhq1muKIUeXccH++2NX7/TxgIL+ECyR6XcstEpkDK5MxiiEN6d2O2t IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36hjhqqfuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 13:37:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119DTt6I005761;
        Tue, 9 Feb 2021 13:37:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 36j4pnpya4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 13:37:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTNfSc7iU7jT4tUCxZLgtavVL7wm+tCPmoDd+LPKKV6Io2/s1x7IGAq5d7FP+r17HXszYwIT3fjJQJAyNphUeYdYouSFnJjyX8n7CEFN5W01djkltLHOcKYiRPjcr/EUMv1mRF03s9lTMIw76FTqMrWIXsjB6DRk1bdVgoiydttnKhTYPSeqTxa97Gs/Jb3ZxFV4AKvMFWNKTjnjkeGdA/WtxQtl7dryjsNn1s5UNI5KfQ5I0TU/OP+CT7TImgxHPS699NuemkDwYNOKtwLSrR8KQC1Bempai60EDZl0wPbmGmkh2/Dfgf1CngpKXiZLekFA0BQ38MKmHHOWJW3xRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsbkD3FUAa8YUWT+eehKX5R9svSdT3d67uiTr2Mr8dc=;
 b=Ssiagb+iWqAEyy1rsULNRS6fWu/IouZRYiNrRYQNfaJx4IsUvDGLLEc5XXLUJh8ppcE648/3xMmEzEMRrSGSNRvKX7y+lMHdZomv0Vsu5mjRSXxSJ7wcBj3s2Y0DMO7rmGNoYRykoy6HGheHrCbPa3dph7XmBjvZoo3IBNF4HnOoQZIjd48yQu8pWnMkNExR+5CtF5PpKdg5QLdD+og2dP126vsG6QdBbvxc7SdDuYv2WVijR//NM2PR7iy7sozS6I7lLWh3y92RKRhk32iN2lEmWrA+UBur/ArIBF9BHuv0FKIJGowjoDQpSoSEmvcWI5kmlanc0w8PGEUDZC1Pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsbkD3FUAa8YUWT+eehKX5R9svSdT3d67uiTr2Mr8dc=;
 b=qMuNK3Ym9c/h5evOyNoZo0aJz3Q6FxB8gDvl39Sls+53JvxkFvqZdRaBJr9wJysoZQw0gjjXdOdWTCXQqO/WQDO58Z3Ed4mTD48s/4g3m+XXJsokd4dKCNFTgEfQQ3casbRYRCZiQ2P5IwRMn6gr5DvKlGHHZNi3CHBfcQuYMlg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3224.namprd10.prod.outlook.com (2603:10b6:a03:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Tue, 9 Feb
 2021 13:37:04 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.026; Tue, 9 Feb 2021
 13:37:04 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
CC:     "mgorman@suse.de" <mgorman@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: alloc_pages_bulk()
Thread-Topic: alloc_pages_bulk()
Thread-Index: AQHW/jD1lENfvnr+s0+/RnBes7PyXKpPoPgAgAAz8oA=
Date:   Tue, 9 Feb 2021 13:37:04 +0000
Message-ID: <AA4A17F9-FF31-4D20-87AF-9A325EA6B311@oracle.com>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon>
In-Reply-To: <20210209113108.1ca16cfa@carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb459b6e-a1f8-4eaa-117e-08d8ccffc984
x-ms-traffictypediagnostic: BYAPR10MB3224:
x-microsoft-antispam-prvs: <BYAPR10MB32240765F9B05595E867D618938E9@BYAPR10MB3224.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0nYowc4vzk6wvjTEiieytpty/aKV3KZ62euYkmJJXGt/1fRkTceDxmRMFrLwWZDBeV5Yn6IgfvZzPNPvOeiTDm2qnryfzgioGsC0sqrj8EXPMJt4mn8inVmaglveGwUlImagCL0lX+eFs8MlsIuswhxRoC7HEG/mC7VvAv420ZRAd+cDYSE5BTuCrMDNgjfoe91bHTmIbuBhiRY+AHA53EG7hKYvtvkhNXfvoml3sKiAMOcl4re7f8R2NsFbaTPojmMdJYWH5CwQreFZ3veNKuCgl4GxCSoBpXfMAXBMbCXsV/1Q5tSypbR0m1cCp9e/dHOjYoHhLbTh5vQS1E0K8ZZHcIGjw4coDZXTa4SGheC1XI0WjSV0/swSqF3DN+CvBCS2a12CUSAXT6aakpuXCaTWZKm4d56IRIKSexjBI+ADmkgZdPBEwfSzwHnoAkShy+7ugervEDtn1C3r9y5nu5l7w3Tt+Wg0xFs9dd6sn/JdSKNjEEYC+67Osg3rq+6wxdRngU6osZvK/CIsVtHw0A4CyvuqandciWX8XoMaaqPa27DX1WYHtqLnjSZEzr6645i2JqGmSZt/1o1moNQWFqafyDQWYo2SLsv2Gn52+RCsER7e3G9iGua801x9aAKpJzshZ34R8yHCHbbXufv89ba1XhypfUBcdDZEyPoQy4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(478600001)(45080400002)(2616005)(966005)(44832011)(6916009)(83380400001)(53546011)(186003)(6506007)(26005)(7116003)(36756003)(8936002)(8676002)(33656002)(6486002)(66946007)(66476007)(64756008)(66446008)(66556008)(76116006)(91956017)(316002)(5660300002)(54906003)(86362001)(2906002)(4326008)(71200400001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RzYNXeeeU+SrDyYwXJJiI7euZsVFhufK3y5JRjuMkzMHx/+k2nXJJStWqDwF?=
 =?us-ascii?Q?5R+n7DpSYZCkodB+JoAH4wslsl8M5YbuPrid042El95u8KeElgabldH4VQX5?=
 =?us-ascii?Q?GlGMKd5XbUGisc6UT9iOGUS8cQIXomXgAyJf2cKJ81DsPQjaU6BzUrzo41C6?=
 =?us-ascii?Q?6dOYk0Kl9rkhFGVSrXgmxt3ICAtikQuYoSduZ3GSah1JBt9G9OC8pV+mqITM?=
 =?us-ascii?Q?oA6NiTZBqNmEkYlQZDXMtwkG/krmsLsTNA857RINe/SfxQQJoO57NXTKX6rG?=
 =?us-ascii?Q?XBy+Muvu77ZHtxC2Qb+T+HvCXiGshq83zEdW5Q547E47np1q+gTg1NmVocSr?=
 =?us-ascii?Q?L9Lgb/fRNX6fKAwrrKZ7GYKAHmGkjRm72r/tV9Dxy4Q0zgUfRPKpmBlRouiq?=
 =?us-ascii?Q?AXq00Cq0NCpGSQt95HHPDmU7aVfl+cRIQe5BWHVwuXLcvC61vb0wmYiNYgBz?=
 =?us-ascii?Q?/0CzZk0IwIGYMPlryhswWPpSk9DpH8EB5F4BTqt0admVdUaVUgRxjarXRhTP?=
 =?us-ascii?Q?t/e2Y6CzBkd0EkGBon9RnII0c01dJRs4WV49e5c5NR0pT2qmBF7usaEAVorn?=
 =?us-ascii?Q?sX+ejb0ytgRZ+axHohrijsOYk/9RV1J1f/ZRt6CEruj41SziKPe6GWfR8Np0?=
 =?us-ascii?Q?FdcY2qmMxItboG+2XuUD+IRtLF94bdnM7llprjUPC724J0x6DycEJCQYK94w?=
 =?us-ascii?Q?tdCMVtgFQzUUj9MXWLZmntUdElU5+QMKyaCD9gYoOxIxhx8PGl6QkTi4sWJ6?=
 =?us-ascii?Q?IyffR/i4X/Jyb1X5CeT4V7yQ4dKdUX4YTq5tSVF4skuhnzlpNbmphsTBFPfo?=
 =?us-ascii?Q?S9AfYd0qAbfGqNmX1lvJ3akoQ+jProylOBJzr/OmmpT48HKbCM4Q0BGTO1AD?=
 =?us-ascii?Q?fE/CmBenQzrk3TnV/bvOND0SzgrO04Jx+DVx1zvNY6RxmqpdzFq1H3JfciGh?=
 =?us-ascii?Q?npmmjNF8w2jG1bVSiNw5qujWvve/Gzs2yFu1PK3A6hr4kBJTlXlDfVW4tCDC?=
 =?us-ascii?Q?XHFRVBcvjXn4wCai/WJpD6QHKJV2MzWMGBNc6fp3ZlhBDSyhC6WxixQ9JCG4?=
 =?us-ascii?Q?TRjd3Na+JHhHoJmFXpMaO8vix10OHmqFkKUKSMDE3FJzCjddRCicec7zculi?=
 =?us-ascii?Q?dEoF8pY6bgmZL8GRLPdl9Cgojyd5ahB/3+Oo4mRjLkuuzE++5wxLHYjMMcok?=
 =?us-ascii?Q?Iffvm2cUKWoK7QuhyCN2p0YQioFv4fdvXu1pTi9mbSBdjdCUcAKBK8DB+mxz?=
 =?us-ascii?Q?guKktai4+MqGYMp+GJJvKx9uAw8x/4ukTyakyHezjXO4I6+b44KpLB5WmbC4?=
 =?us-ascii?Q?olXEYXLZ7e1+9PpVukBI1aYLMvebD2kgiXJY8+5hHxeyog=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E5FB34A98881F48B122F094A0014ED7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb459b6e-a1f8-4eaa-117e-08d8ccffc984
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 13:37:04.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3y46JEOkaasuWWlAtMmNoCws+Otb18RrkRGwbuXIHxM5cKehWPLKc18E33fidcdXR6qp+PIg00+/2N8fLhYpxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3224
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090068
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090068
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jesper-

> On Feb 9, 2021, at 5:31 AM, Jesper Dangaard Brouer <brouer@redhat.com> wr=
ote:
>=20
> On Mon, 8 Feb 2021 17:50:51 +0000
> Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
>> Sorry for resending. I misremembered the linux-mm address.
>>=20
>>> Begin forwarded message:
>>>=20
>>> [ please Cc: me, I'm not subscribed to linux-mm ]
>>>=20
>>> We've been discussing how NFSD can more efficiently refill its
>>> receive buffers (currently alloc_page() in a loop; see
>>> net/sunrpc/svc_xprt.c::svc_alloc_arg()).
>>>=20
>=20
> It looks like you could also take advantage of bulk free in:
> svc_free_res_pages()

We started there. Those pages often have a non-zero reference count,
so that call site didn't seem to be a candidate for a bulk free.


> I would like to use the page bulk alloc API here:
> https://github.com/torvalds/linux/blob/master/net/core/page_pool.c#L201-L=
209
>=20
>=20
>>> Neil Brown pointed me to this old thread:
>>>=20
>>> https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingular=
ity.net/
>>>=20
>>> We see that many of the prerequisites are in v5.11-rc, but
>>> alloc_page_bulk() is not. I tried forward-porting 4/4 in that
>>> series, but enough internal APIs have changed since 2017 that
>>> the patch does not come close to applying and compiling.
>=20
> I forgot that this was never merged.  It is sad as Mel showed huge
> improvement with his work.
>=20
>>> I'm wondering:
>>>=20
>>> a) is there a newer version of that work?
>>>=20
>=20
> Mel, why was this work never merged upstream?
>=20
>=20
>>> b) if not, does there exist a preferred API in 5.11 for bulk
>>> page allocation?
>>>=20
>>> Many thanks for any guidance!
>=20
> I have a kernel module that micro-bench the API alloc_pages_bulk() here:
> https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/be=
nch/page_bench04_bulk.c#L97
>=20
> --=20
> Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: http://www.linkedin.com/in/brouer
>=20

--
Chuck Lever



