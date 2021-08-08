Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139E23E3D0B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhHHWjK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 18:39:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58094 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhHHWjJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 18:39:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 178MQTAk015612;
        Sun, 8 Aug 2021 22:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5KdlIu2zYJzS4WcZNxBF/du77xRgNZoEkKXZMrGreo8=;
 b=bGNfoajSKjxwueRebNpFJp5ZlaKWqU7qmzVcf9VyzQg4jrRls3fAefC/JTehUPXScKsj
 Ge4hwDN9i+HJikaR3ZxtvrUcIG6b+7fYgSvPLfV06I+jkUY/E9kq5Oz/I7fLagk4pfSf
 YWdhJLsS66JxFDEAV5qxr5v6kIJOt3n2RzOUVVabYwBaxUAjyDlkBziRxz0ZOgNeop8T
 Hk+ndbW+/ZHHwvzuZo9zC9GbE+pmJ9sK2aJn83RmAFP1d5GqpTVLD15TiDfbiIDnb51F
 uxJd7AxJcQap4acWQyl/yIAmdTgPMhLL7jlHZVBr8xenb6t6GSzqYPuN9GZ++VIMvf3H tA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5KdlIu2zYJzS4WcZNxBF/du77xRgNZoEkKXZMrGreo8=;
 b=Fnvbcq17gDdbnLN4S+do4/ieUy0UeCgANtLFStypCS55i6Ojxb1hECDHvW6sS91NfiQf
 KD72RfSds6+OhgQZ3DUEPP4xfLm1xIKEh2dYhLquX2iLkmia0j95o80pkoy7/LGbRnZR
 uWZMqEQ1a3WPdnqYdn+qXLXi02SimaDBpl7mFrzrvUoPJUTS9s3HT1NFH9Csvd0qasq1
 HeDd6nkubsaB/IkHdA3PJPIDVbKOOuq8SGNg4bN5VQlAHe1k9C4fP8Vd89Qrya9CoSXg
 UlaC+rRTH6A+Oue7aKwms1fUPMpGJGu8Orl9Dejn1lWTCEpaY9nNZi2Aw0wpXy7Gm9zH sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9hsshwup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 22:38:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 178MZuPs076157;
        Sun, 8 Aug 2021 22:38:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3020.oracle.com with ESMTP id 3aa3xqbfmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Aug 2021 22:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggsjSTEC52w/FodS0Asf+QCeGLwyig1Pm7znabQQJ4Nx+Oa4W9kijdCmUfZIE944Q+1wZ6KQPcYEoRCdKeK0LR4a1ga3Bewo19YjDO9UgWYGFg2YnBUUUfIx2R3YixtAvIHBl0Ps4350/QXesvJXMcgf4g3RlHvQJTbpUxWDYJfG+5Q/4qyUKfSNF7ahnWMWTVTo7zfYcKXu0NaGIX/JxrvSPefpIoJwcs+jGXy8Y36dcvZ1VL5aZGP0vwbguZm81tdyfzxvkYpYcckWGZrNnLcTcZtQOOc/Mt3RYZ673nzACP178rpN8qJC7qVifJ+HXiDaTtA0llXBu+8KyCfIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KdlIu2zYJzS4WcZNxBF/du77xRgNZoEkKXZMrGreo8=;
 b=S8q76hMJUprNeFz16pQal7ZiWgUv8HI0nnrbDsD3oGnnBXfHtKFtV8nVrqGV/6rVD1Er4wKMoqUYhNw4qGs4A8DktJoxzPa+ZHXOz5djHdwj9ezqnAmYW0DiKn5z0MLwXWUaUdlss9dsL75b4OuwbThXwwx/5zU7N6h+UKrrn1HFIGeo/8YUFGf0TL4f8QNiGrETqrGPXD5glbVqQ3bDFm2nQJDmmBokU/EaiS04vJd1K8/lfrib9r+xT4jXod10z8nfxEYBWaUBfQc/o9QRDhNhkEIkupTdZFD4QkrmJ0uB2/CJPy3bn5sf4uQ7vcdEmCsyrhWz0xFzWW+FAlL6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KdlIu2zYJzS4WcZNxBF/du77xRgNZoEkKXZMrGreo8=;
 b=dw2W5bCLzK3R9ypyl0Z+kG5WAKV8HR4EZ4zFKU0+rH40oTFoUx2OjfU1xcRSSw99HdlkS2dofHxX7V09R801XCdwrUwZJ4pHaCc+HVuNlz7mPjdWo2mp1GrVnSMl9TxfynLtHm5xsOtwtRzhiHP7UWhkwme/HIrpsNyBnx+CxiU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Sun, 8 Aug
 2021 22:38:30 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.022; Sun, 8 Aug 2021
 22:38:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        "kukuk@thkukuk.de" <kukuk@thkukuk.de>
Subject: Re: [PATCH 1/1] rpcbind: Fix DoS vulnerability in rpcbind.
Thread-Topic: [PATCH 1/1] rpcbind: Fix DoS vulnerability in rpcbind.
Thread-Index: AQHXi64Cdqj7NA+DcUC7//SLnyqazKtqAfOAgAAclACAABZUgA==
Date:   Sun, 8 Aug 2021 22:38:30 +0000
Message-ID: <3DFFC57D-0E92-4F16-8B80-261574AC168C@oracle.com>
References: <20210807170206.68768-1-dai.ngo@oracle.com>
 <72C62482-3E44-4D76-BFB0-18402D19FE2E@oracle.com>
 <88b2db88-bb76-0466-4ae4-a27240c7f8cd@oracle.com>
In-Reply-To: <88b2db88-bb76-0466-4ae4-a27240c7f8cd@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c22ef1d3-20aa-4d72-9485-08d95abd3f19
x-ms-traffictypediagnostic: SJ0PR10MB4544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB4544BE6820BFA992F5CEF7E793F59@SJ0PR10MB4544.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPN/CDpa82MMB6YK8ByRVPteP3DJadrR8NJYtWLq5AciKrxwJ1MGfnSPsYyxHJWeW/lLv3n4bSik+SFRlw/DB63VlbxFvIgWFCkMg7kX1eGUiM0OVazJ7AaB5Qn9jB4hmBJW9qqoXJsFGtLVruWMmExdUztdPsbRTreJzOhuli+Trl+PsNOAcGZphpjE7rjwTJI1aeWYzdPVN/6LISv9QgOMOevxfcDMIhXart7x7G2P4kARrHB50hHg3Gvyfr3OVDlMJX4rgoWdNVZtCR3pztT9rAjzFYiYVdvrooxjlyZ1KHvXT3rbVGqirWDgu6kLeBYMyzD9jw2JGY7RVvYPAfSZKcSRJa20OOW/9+5+g5vJmsgzRJEOUYQsjqbPrguCrilNZEKh4rhNLDTaasyiOEPPc6xgxsd4o2raElJfR+wHpKRUYwwze9pNCFgwLYemyIEprxpTHO9lFBxbsMjlgeQPYX62oim74f8hOFPnT95HlxOuf9ykvIhAF55qjvJLeswS8XNYR8OIDHtvnUSdpbaE/VcAOnYTVJED47Qes6HctmGVhceF5Hx222bc9vEMR4YBXDu3zzZrPn+Ag9qfvSBmeqggtns8FhgfCZ7vcyucioVgu3I+OM8GK+jIU7VcXn9wOiZ2ZztwV8Cw5CvAN6X2ON56eBQRdmxl2bWpG2C5l87b0KwWc81KQ9YroCZpaiWzbsP0+58mLhSIHf19ZStbsEC2Te11hefiJqh5fXF3rjZ9uMmdfewCcI/kmEYy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(66946007)(6512007)(6636002)(66476007)(66556008)(64756008)(66446008)(83380400001)(33656002)(122000001)(38070700005)(26005)(2616005)(478600001)(4326008)(6506007)(53546011)(186003)(37006003)(316002)(71200400001)(54906003)(5660300002)(36756003)(38100700002)(6862004)(6486002)(8936002)(86362001)(76116006)(8676002)(91956017)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CHf4Z5skH5kHMBRP7yh3seZ693cArwm0IzU5f8pprilPQ11PjnO3LgpOs47W?=
 =?us-ascii?Q?Fu3TU4vUfz+7PxbZtnDzUypQZrbuKGJKD+i4y2jY4BYPA5ec68YTGevwzq5I?=
 =?us-ascii?Q?o7CJEFEavHC/RAagpUeyK/K5/mSKj/bZzkxtG+qHRz5kff2FFXmqC7yKkoQI?=
 =?us-ascii?Q?/jmDptiTy3YEy9K9hWRNPuDq89VJlRk3tG7vl/gvQsmKgjbJqhDa+nVSQeqK?=
 =?us-ascii?Q?nBS1ms1GhSaIwHxEENYQu8X4c0AkRJS05YJ/9oSmajFruQaQc3HWhYeeplcd?=
 =?us-ascii?Q?Vgy3QdhUziMwt4Zwy1MBU4mTkde9Yf9PSY+wnQ0xe0jMCCCfr+WNb1lcdXSn?=
 =?us-ascii?Q?0mp6CbGYLl5YwQmLaui9VP9wa3TSrx1e9qTHDqenwQoDEEUBsdxAHvgtcms/?=
 =?us-ascii?Q?pItnjQTxXRk7HvL7Kh1tDQUsej2JpvmxDn/iEOI7U+HNyGtBV/mS1n0w9PUi?=
 =?us-ascii?Q?UwWNOFR3fWbyLw+pFPBlBdaNX8TqrBsLn3bdX0p8pgbP0P983RqDpcm0s+Mf?=
 =?us-ascii?Q?4XV45bT+6OtsjQsd4HkZocxbR19xkkFJZhH431oC4/XC4VAaYTSd+9JYYq9Z?=
 =?us-ascii?Q?NazUhLo/cNrl59b+I2KpbbSdNpRIdo8/tpYSvQuO7qmZ1poSd4rHk4uXy+fg?=
 =?us-ascii?Q?qnSKr+PXa6wUNSRgDYXWh1jb2L7iiVjyprrLIOxv33kK1rEPg5z+pgDGibVP?=
 =?us-ascii?Q?ZGog8a343rPZnNzjQAPL5pwl/s8MGok3UPe1+AGODeUa3Ga4uqJgo8Po6G1M?=
 =?us-ascii?Q?+PkVQOuGCV0smKMOfL7akFbS0ruma//Hrnsj4ep5UNFa/LQ0tCLNMl9SHmFm?=
 =?us-ascii?Q?2v0+hLBAkLz1UKI/7Ss25hU++Rv2aLIW0+p+iaNNcWenoQPcE8BH5iw2sAvp?=
 =?us-ascii?Q?2128/BhCAfG1IUOMl+13CcqqCnB1TtGBvIBoFbLMmAY33TZpepIMtr5klapl?=
 =?us-ascii?Q?CKSeHj/BMqGSoLkBkxC88+IFqebtsB8UDMdXyP99nuXSACChr/MvXLiyxo8C?=
 =?us-ascii?Q?iNMgP4w1QzoCmWzm4l1abV/igtxT0CHn5v+X5f9wbPLXhOoRaK40UB3su22z?=
 =?us-ascii?Q?9UFPZdGmHeVpSbFeefq1hDMSGZjmB6lRG0/3G7MYuPUGawbZ1eRs9EqhCOCb?=
 =?us-ascii?Q?Xhws6C9RgxfHBVRTCp6uCQU+covvHjlbR2g48jtw/lcbLDBZMYNgSwP23yAL?=
 =?us-ascii?Q?dBKtIlaIh1i02J6AWqZe+JgqCNXDrQtIiYFIflU3VMDmvc8ocdXQcG6PRzAZ?=
 =?us-ascii?Q?1qEr+2pRu4wLG8TQMmhionrn5hZcP/gNdbiRH8J0dNah4laQRnVQ7tgjBcBe?=
 =?us-ascii?Q?Mw+Pivj1rBsgqhFbk7xPqqsGBtF4onwCCu9HHoIv6S3pWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9EFF914E29F4F419F88A66164ABBAF6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22ef1d3-20aa-4d72-9485-08d95abd3f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2021 22:38:30.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJ7fehhNr6Cf1CRmICvNZM1/zHRJcQLGfAl/DJgn65F7BqLoz708rSNT36uZFXXfaC0Q+g6ePanW1ZS6fNGsRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10070 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108080143
X-Proofpoint-GUID: Co2YZXb_fZ4Jt1zlrvS5oa7_8ChsDDIf
X-Proofpoint-ORIG-GUID: Co2YZXb_fZ4Jt1zlrvS5oa7_8ChsDDIf
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 8, 2021, at 5:18 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 8/8/21 12:36 PM, Chuck Lever III wrote:
>>=20
>>> Signed-off-by: dai.ngo@oracle.com
>>> ---
>>> src/rpcb_svc_com.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>=20
>>> diff --git a/src/rpcb_svc_com.c b/src/rpcb_svc_com.c
>>> index 1743dadf5db7..cb33519010d3 100644
>>> --- a/src/rpcb_svc_com.c
>>> +++ b/src/rpcb_svc_com.c
>>> @@ -1048,6 +1048,8 @@ netbuffree(struct netbuf *ap)
>>> }
>>>=20
>>>=20
>>> +extern void __svc_destroy_idle(int, bool_t);
>> Your libtirpc patch does not add __svc_destroy_idle()
>> as part of the official libtirpc API. We really must
>> avoid adding "secret" library entry points (not to
>> mention, as SteveD pointed out, a SONAME change
>> would be required).
>>=20
>> rpcbind used to call __svc_clean_idle(), which is
>> undocumented (as far as I can tell).
>=20
> I try to use the same mechanism as __svc_clean_idle, assuming
> it was an acceptable approach.

Understood. I'm not quibbling with that mechanism, but
with the addition of another private API. Private APIs
are very difficult to maintain in the long run.


>> 44bf15b86861 removed that call.
>=20
> which is one of the bugs that causes this problem.
>=20
>> I think a better approach would be to duplicate your
>> proposed __svc_destroy_idle() code in rpcbind, since
>> rpcbind is not actually using the library's RPC
>> dispatcher.
>=20
> then we have to do the same for nfs-utils.

Exactly.


> That means the
> same code exits in 3 places: libtirpc, rpcbind and nfs-utils.
> And any new consumer that uses it own my_svc_run will
> need its own __svc_destroy_idle. It does not sound very
> efficient.

You mean you don't particularly care for the duplication
of the code. Fair enough.

I don't have any problem copying this small piece of
code into callers that long ago went to the effort
of implementing their own polling loops. The code
duplication here isn't bothering me much.

If you see a way to convert these external callers to
use enough of the library svc APIs that they get to
use __svc_destroy_idle() automatically, that would to
me be an acceptable alternative.


>> That would get rid of the technical debt of calling
>> an undocumented library API.
>>=20
>> The helper would need to call svc_vc_destroy()
>> rather than __xprt_unregister_unlocked() and
>> __svc_vc_dodestroy(). Also not clear to me that
>> rpcbind's my_svc_run() needs the protection of
>> holding svc_fd_lock, if rpcbind itself is not
>> multi-threaded?
>=20
> The lock is held by __svc_destroy_idle, or __svc_clean_idle
> before it was removed, in libtirpc. I think libtirpc is
> multi-threaded.

libtirpc is multi-threaded, so __svc_destroy_idle()
is correct to take that lock. I'm suggesting that
the copies of destroy_idle() in the external callers
would likely not need to take this lock. I don't see
any references to it in the rpcbind source code, so
it's probably not necessary for the rpcbind version
of the destroy_idle helper to take the lock.

Note that svc_fd_lock is not part of the public
library API either.


>> The alternative would be to construct a fully
>> documented public API with man pages and header
>> declarations. I'm not terribly comfortable with
>> diverging from the historical Sun TI-RPC programming
>> interface, however.
>=20
> What I'm trying to do is to follow what __svc_clean_idle
> used to do before it was removed.

Sure, I get that. That seems like a prudent approach.


> I can't totally re-use
> __svc_clean_idle because it was written to work with
> svc_fdset and select.  The current svc_run uses poll so
> the handling of idle connections is a little difference.

Introducing yet another private API should be off the
table. An alternative fix would be to add a public API
that is documented and appears in the headers. Again,
I would rather not diverge from the historical Sun
TI-RPC library API, and SteveD would rather not have
to change the library's SONAME, so I'm hesitant to
add a public API too.

The bottom line is that adding a library API to handle
idle connections is the right architectural approach,
all things being equal. But the goal for this library
is compatibility with a historical API that is also
available in other operating systems. We have to stick
with that API if we can.


--
Chuck Lever



