Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19F2467A22
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381611AbhLCPVL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 10:21:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47944 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhLCPVL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 10:21:11 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3Ej8ji019878;
        Fri, 3 Dec 2021 15:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yyWnAKCZqg9MRObLE23BXMG/HlOFMM49tnWgvA6+Kio=;
 b=evSBP2hj/PgW7vIpY1ciyiW2hwkT/38kLNFgOBXYyHZrmyFmYkuAPKQSscJXTyQOCs3l
 bAatCpIAUQ5OekkxWdqqMjBymEmwDA9aTJG3XvG/5P1LvU+bp6tymyACD/IsrEsuMB8Y
 nkW+sUjXhfm0RAqw0lygUCWnXLmwtH0VGBVggM/vb/VbYLrW7eCPW+8+o1ha6cUoL5ch
 NahIqtDX+H1Hjpi8VmXtAiD36D+ohg7Xzc9NSaF1wtraAY7fgR7MYPfsmCGKzS/Pz2O3
 6uJa8j+hay6Y3CWgR8I6f5cWQ9sVKcaRx6GVcuhMx+C9xofE6UwM/5U/kefEIKyDyHoM gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqn99g5q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:17:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3FAU4A064824;
        Fri, 3 Dec 2021 15:17:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4wcuju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:17:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xl+BaxOTafq2Een9NGzDqgg1qiYPf61A7XXosJGfFHWa30khagpTTEhZj1CKKwKRJcFrQ1Xj0oEUQEkK8P92Dy5/N40ZlJq9cg95o1wleo8SgUOB07UxMJGdJRRmUfVp9V/Cw+efNdanP4MnqTBov9E2bOmq8VTePchFzbZWOBZ2ZJrvqFmi8ZvYsBDpakzk+yYfhFO/0SxUG4v+E+FfLuz22WINMbLy7DaGR0ADxrg29LvNPUvVFYRIyNzhMSIZhUgxkm2wPX3+Ice1/rZCgoATxsH7xyLQjMM2Pr7Gumi9hqbxOD341StKdErxzB8wB7bdhYMbU+GZyHELaGeRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyWnAKCZqg9MRObLE23BXMG/HlOFMM49tnWgvA6+Kio=;
 b=WXEV+5pLYzhMkjhJ0JJ3w2HphU3Q8a6lCF85iOB+cEs76YI0+5k5D+Ue6m4aVtgLdQFTRLg+3vVKRK5Px05El21xHsBTYevUtcHy2yh3+sCyhBfqfURrW7wFh2rhMJH+yQiIjmEt5Cm65KPZT7xGCipphRWtyPOnCcDY1AfzdWZh+A/CaP7qD2sw64fYO6oJv6NeOcYx9JsAQeFFGi7BFT0z2LNiMOx/FOKRgYKVAPRywXIbYHOLm8vwYt62vjx7ZXrNTUgmyiJNSHfS/MwvygrrkaF3cmRu9GxC+vslZN0TfNZa2D7VjkkfzbvglN1hmlt8F8Cj/RIexbmXe50I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyWnAKCZqg9MRObLE23BXMG/HlOFMM49tnWgvA6+Kio=;
 b=MFURVs4xqrK+ddQ5VUsdQYC2ckDJAjgeq7hh7Oq8icS6CbTjMdsJhdZQ/mEbHBCWbZkwE9FjBF5E3oIrr4f3J6/U0CndbI2bYt4KwskV0mxzI6nZbAK3qeAfDbvF/FB+cB2uipdM6/4bRTu6KyDRFeUMKrJv5LbKhI/wzggkTLE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 15:17:30 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%7]) with mapi id 15.20.4734.022; Fri, 3 Dec 2021
 15:17:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, Neil Brown <neilb@suse.de>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Thread-Topic: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Thread-Index: AQHX5dx1rd4OTcROt0WbUE7C0kd8rqwcg4MAgAQhm4CAAEDugA==
Date:   Fri, 3 Dec 2021 15:17:30 +0000
Message-ID: <0428D783-49FE-451E-827B-6DB8F03347D1@oracle.com>
References: <20211130113436.1770168-1-weiyongjun1@huawei.com>
 <888F3743-AB98-41A6-9651-EFDE5987AA01@oracle.com>
 <20211203112505.GI9522@kadam>
In-Reply-To: <20211203112505.GI9522@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa8bd6b3-2146-4703-da4f-08d9b670064b
x-ms-traffictypediagnostic: CH2PR10MB3960:
x-microsoft-antispam-prvs: <CH2PR10MB3960A7A26492D6FFE7C7FB9E936A9@CH2PR10MB3960.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQnrcaAhGnh4srfMlpD4Shw74rX67qu1jUzE3dEvPCsCf3xfSOvZCBy5nFYJ1TGBFX9fXLBKZk44bw6/aN4rH8+DdS1pII80Pc70zcYVRlYjgrdjkbrttx2n7gn9lNlO3c/We2xWG4oYPK8u7BSW2U79LgaoUBkbnh0HygnJESCCKqB8MCd70GQb3xeV5gQksx5Nc1Uo/aYXDydK+Tf7fNdVLiZOBwQss3mT2ypwQWagA/l+Bh26KN/AMS7dVNydMkZTBJzbumvz/O5djrhN1UrKDp0SfcEw7W1dJEF54YSmbHVMFDrbrKKVuZh+Tfwday3PiNzN52Eg1/dogRytZVs6cS72JAgyxmaZqw/jKUR/vjAZaTw12CaDYOS9eyQ2XSuDk5WQuFFa0BNQaXBmGMqeMKYx03d61DgacQ+mHCCRS8bPfxznbz/aNe8hnoxZ20L3p+9Xsi4gPSErr6x8IXuEK4xOlqt4sKfHFpJMpxv+deG9WiTdAWckj3PzDR9igpOiErEeZEiY2vMIKCDC+XwRhhJUWR5uJs20Dmi0EbD5nGbNv2C1N38eipY+9dQm127QasA200/tZsAmffDeoyYmGeZ0LBXDGZYm4/gxFWNjEB6qbQDKaR3XXlMmRk7pPLHmV80r9xlPpK15V+XxSiiUiIhSUhhSHg8QzoCDNcjSPXsOnSDXUQqE6JJwXDqtfjAR05GP7fptTRyBpOZJNoPM1Ruf8BOmQUBpDw5Qhbwjy7YN0OgETpFqlK+rtBYqc6ZqXTNP7C/ONk2dWq0GxYSOZdVTdU9jZ1vB0de1aTjjDoOXsX2k9B3+gHXBSLae3uGR8lHGcSeWVz/3trY18g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(316002)(37006003)(26005)(38100700002)(2906002)(86362001)(38070700005)(33656002)(122000001)(4326008)(6862004)(83380400001)(54906003)(66946007)(66446008)(6636002)(186003)(76116006)(53546011)(508600001)(64756008)(66556008)(6506007)(71200400001)(6512007)(966005)(8936002)(36756003)(66476007)(2616005)(8676002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZE5FVmrmPmvm9h2i4UXRA0QQOutKVFw8r85io/YZPUj/VPk9nW/thSQrl4N?=
 =?us-ascii?Q?n4Nc6NvHWMoeVXOCv96uF14+jRDoY996vqRmCF1RqAx4cRZKaTRsYtKqGo3N?=
 =?us-ascii?Q?Alp7TpMetUQYlMbAfRqH6XAOv2IDAWwroHw/PbGnL/kXZLYY+z9GfCXYg3P3?=
 =?us-ascii?Q?EGScTB6C8B8hTV6dRSGzsS2HxR56I9uNCIk4mgy4qzay9pD9SXCr095TZMGE?=
 =?us-ascii?Q?+Kh9lRKFyF/xMTKlDxdOUBQlkcwl4Jb2Vpv5E7jHxJfAB36whZwqlaw+k79o?=
 =?us-ascii?Q?QrUc1KrAl2JF52UtE/Tto8onT8gy9/QXkR5nVoNMcRNsC6YS5fD5cUXBj0HL?=
 =?us-ascii?Q?BPdwjTgKvJAeAfNXAxEgE3fqCSZcblc5/80gaPISRKwc7KCFfpZPcQdv+5k7?=
 =?us-ascii?Q?U4w+6oqsyZFhTyMBAuD4H3dOCDb6rPFwDI3MdcFP/D4CdOtExilINfIO7ZYb?=
 =?us-ascii?Q?6fGf1i++nOIMitcXPttCbDsI8Pl1WvA2BDS4eLMQe2VWabC+wG5K8dPGadOS?=
 =?us-ascii?Q?OqiLbBlfBFuMRm0cnOxAaBddm503ITFhzHWanSWM8G/3/9bXmPRiBDNgbb9L?=
 =?us-ascii?Q?LPLRP590/hrYgjIUNCZrKW/cYYpuzDEkMNZD8Q08v7m8QY2daFr6CF36PxFV?=
 =?us-ascii?Q?n121f/Avcdw3n+e+u+ADFGJdZArPXyRpI31cqUI2zzF6/oeX77Rsfd6ugzJK?=
 =?us-ascii?Q?8MenMnWVMs3VZTuSmEsXQsdAiIKrUpFS6A5nELJDkHUZjNm9onpftHw9t6z8?=
 =?us-ascii?Q?/PnXW+56tjGpuyCFmLJpISCU7cRT+sYlfuNMSKw2ORrCvEikuIluznyPnAje?=
 =?us-ascii?Q?ax+Ar9sizXMS31mAmud29bZjnPYMSyNL/7l8uHnpH4pu4b19KnEf3qX/GUFz?=
 =?us-ascii?Q?xq/OgEHDK2gu4qxsreJD6oBDummSZQ4UZB6zZYtriLl+HcvvG8JL0ikek0sh?=
 =?us-ascii?Q?Kwf6N/IcgCSzxB5EMxtNc//9rx26c3OQi/cCYGQAhLyStCTyxbHo0QXC0yNX?=
 =?us-ascii?Q?jzEViJKhPQkpxENmRx0wA8omJiGMrrDfFGE2ZFGMM9eOKCNeN83XrhlcIf8J?=
 =?us-ascii?Q?PSZBfdWJaL9E5c5EWSSEabbyzE1sS/f0UlqzArj+D08RLLp0rmrz6NXV+06z?=
 =?us-ascii?Q?Omo0ouVMa40w8ldQSzHp0phGUz0IwUQhSnXX30BdKXA0bKlzii82t3WXOkGn?=
 =?us-ascii?Q?uqeDF3kL+BNtQ6Ov0bl/yZMn9G7AyjDSUumtZxN4p8FnKEHM7kRZmCD0MbHG?=
 =?us-ascii?Q?ALnXumvM7wC+TEJ0MrM4+kCKRfwdpV3jDlP+kStV2plbh1krmkip83fd9miu?=
 =?us-ascii?Q?31gys4GCNR8Zc4YjKuEioJq8JOXUe1dD8TZu6OF6vNT+sumQ8nLaX6iWuvB8?=
 =?us-ascii?Q?hgGi2JTSSYyiWaPlV8PiFzW5XfPLVhaTiRTUc8TWUI2jxoV93ve+KfyLscd7?=
 =?us-ascii?Q?migYjtjrAH8xi7spYOmmruAnr9bfYbddvn3zfAy0beKo4O6jqHN26trciSEo?=
 =?us-ascii?Q?yVKg+y2PArNrnjoRnqpOkgscoWislX1qoEpWBCtX1TVuQloNyZlEREDZhAp4?=
 =?us-ascii?Q?Vc3NgXAlycCgWnQ2dCzHfnH/UXmSshpvguOQawhHcQemMDPZE+XLIQIZbkT3?=
 =?us-ascii?Q?a13PPiW1RPQ+vRX4VA3ZLzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3A975D8E09FCB44B0FFEB9CAF2F5EE1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8bd6b3-2146-4703-da4f-08d9b670064b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 15:17:30.7225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHSAzfRVErPr+Q8Otg4dWzALcE4Z7C7T1ABVRMO2Ynpo4AP9mvT5Lh3Pwp0bsHa6qHHZn4TSHRXR0VhD5lIQvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030096
X-Proofpoint-ORIG-GUID: 6IBHwKMACGV7JKZoXD1l8NMF8_kyp60p
X-Proofpoint-GUID: 6IBHwKMACGV7JKZoXD1l8NMF8_kyp60p
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 3, 2021, at 6:25 AM, Dan Carpenter <dan.carpenter@oracle.com> wrot=
e:
>=20
> On Tue, Nov 30, 2021 at 08:19:47PM +0000, Chuck Lever III wrote:
>>>=20
>>> -DEFINE_SPINLOCK(nfsd_notifier_lock);
>>> +static DEFINE_SPINLOCK(nfsd_notifier_lock);
>>> static int nfsd_inetaddr_event(struct notifier_block *this, unsigned lo=
ng event,
>>> 	void *ptr)
>>> {
>>>=20
>>=20
>> Thanks! This was pushed to the tip of the for-next branch at
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>=20
>> I removed the Fixes: line because a backport is unnecessary, and
>> the commit ID is not yet permanent.
>=20
> Removing the tag, makes it more complicated for backporters.  Before
> they could tell automatically from the Fixes tag that backporting was
> not necessary.
>=20
> On the other hand, does this patch really need a Fixes tag since it's
> not a runtime bug?  Different maintainers take different sides in that
> argument.
>=20
> If the patch needed a fixes tag then a lot of maintainers have scripts
> to update the tag during a rebase.  There are also automated tool run on
> linux-next which emails a warning when the Fixes tags point to an
> invalid hash.

Hi Dan, the patch fixes a bug in my for-next branch, not in mainline.
There's really no need for a Fixes: tag.


--
Chuck Lever



