Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7B36A268
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Apr 2021 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhDXRkD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 24 Apr 2021 13:40:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhDXRkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 24 Apr 2021 13:40:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OHdIxZ009783;
        Sat, 24 Apr 2021 17:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=74trIU5w53HCxsu+wRhX4tD0aZ5EOX4Qjog8K9NW0vM=;
 b=0McHZ1iPzxW0Tu0eHVgw4eHcYnhqq/C7XWSZH9JTvyNpL/LlMTn1RZWYI/4+jq5QWVuK
 2QMBP9NBy6SC121CiJ0NimWkZfI5SSL02iLLwJaM7KRCcoRCeQJawhH/+QzY2vcHGHOi
 h7jAVDQzv6ZRUhv0bvY65Mct+w65Ph2e1HWCIk6Ttb5B0+T73HAfpBZ54/K5XYHsAkuJ
 kYtk5GtBGJTFEs2PNQTtH+4l0CAW6gEwU4qUOK3yGYt0rIYRYIDwIdDudZ7mE3O4QKum
 QMzRJSTWL663CFoEOV3DJvdBjhg9owhnZIFMLAPpPfhDuVpqUozrr4NtC42leLQ8PrCR DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 384ars0pgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 17:39:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OHZXXm091998;
        Sat, 24 Apr 2021 17:39:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 384b51nqqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 17:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9Vq+/5bAQgwzsg2XlrhW0CB3Ny9ndKTnLbMJgebQYXfPiu8fPDgJSSlhD4EB/bOIFmUAYsEfS7Sl+pSQnSA3uo2W2TkokxObsE4wdmgtEoJDXrrMgP1ecGqqeZeKr9BqNmyBtizXOFxGIX5kt3dNlipeq6L6/ZCWHs6biA17Iqc1nAW2WPuagNDkVtueAoUpHHFPk9sdyzmIX8fp5uNyR9euVRT58gQWEMXAkaD1CKqizcsn93xEUuYzQbYhE042pKbeJIIyxfRVMuxKZY/QQ13tgnw+22It35puhGC2GSJglPrTbwbMQbLfW/BOGKPh94+Qv3vvcsqz5OiPtzT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74trIU5w53HCxsu+wRhX4tD0aZ5EOX4Qjog8K9NW0vM=;
 b=ecs2hrptjWgIT9fpJz8mAqU7l+QoH4rwLg9HnTTnoWNCVV6/EkcjamwH7mjHFniRrmecIsEJqqbdO03ddGMwa0fy9ED8X+YQ1IeAtWMS6dZXJmpShYyUF/eKx5xojsj1b+fnXUZv7ey0mTjt3udnF6HMa2u2H31VTSSzgFlNqmEvEiOqmkQlrWkkfDsNkik1ZtlpcdhKIMs0XMDI95VYOlyRIGsJfcKMbZGjalqKA9fMv9hE2M7hhjmstxy5m1nsiEZyrjeK02HXTR8kpeZJ0ym0j/xuSoc3cRMtGsZuF/4AWaVboNx74YFXGnhZKUrT+xCir5k/KG7Ey+wmIpaB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74trIU5w53HCxsu+wRhX4tD0aZ5EOX4Qjog8K9NW0vM=;
 b=MlVFFzijhjLbWGZOkBUY/RuuM9/3WMbEngH8i/H+orfS4WBwrhK6yKMWBhBYkR+3x2aQXviOI2dTPZWbQLkRfqxl3rJLTcVAc+vCOhSREmWfNo2gFvDYGix/AfUC4DWVnxTxP7HSTeixx0UzODtkfuvqehRFiuG/x+TcN6lSBYU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2712.namprd10.prod.outlook.com (2603:10b6:a02:b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Sat, 24 Apr
 2021 17:39:15 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4065.025; Sat, 24 Apr 2021
 17:39:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 07/26] xprtrdma: Improve locking around rpcrdma_rep
 destruction
Thread-Topic: [PATCH v3 07/26] xprtrdma: Improve locking around rpcrdma_rep
 destruction
Thread-Index: AQHXNUYp2YQRCT42e0GulEubGqapWqrCnoEAgAFYbgA=
Date:   Sat, 24 Apr 2021 17:39:15 +0000
Message-ID: <0DA1937B-3EA1-45A9-BD37-F7426764F83D@oracle.com>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
 <161885534259.38598.17355600080366820390.stgit@manet.1015granger.net>
 <89d2e2bbc40d953e28c4e4d56be0b5c83c25dc23.camel@hammerspace.com>
In-Reply-To: <89d2e2bbc40d953e28c4e4d56be0b5c83c25dc23.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d0bb809-5574-4689-c972-08d90747e143
x-ms-traffictypediagnostic: BYAPR10MB2712:
x-microsoft-antispam-prvs: <BYAPR10MB271261D189D8950DD93E7B5293449@BYAPR10MB2712.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBNxW3y1rwAfLlWuQ10UwLLu0kHTgLA4Z4Y0D9AipygOgo87fSX0O5PuLS4jKmKYQ9xyUuRs4GiyKgb8ZI3Uw8KCfdGuAjnv34P8w4axhMEAet3cmoy5lOKzCajG/bbl5RrcvOzK+UEWKq8NRV1G3lp9BBBL+tZRaQqeHgRjQ9PBJduXG9eROJ1h7tVsTLQJCOxzInE7Z0WKaIEPgHvleqICAai28cBxMR7Qh7L3HUjQ5CD4YF+GyhOC5LYanGnm6HgFOyRpy2H+CaTwoOruC4l/bgDjtygQMafZbOKRJVtZZvG8DJTDd9qcPYpOlKUKc2N0vhZZ4SP5a8bO+c/a7IEbEC4XsuOTRn+T45vp/MhOIcOZ3Sro+vcGCwKSlmKw8El9HM0NMXr0L7VX7WOdWbOvl0KR7r3gimeBNvmxkFhE0GBEY4gSaEc/eCuXYzkmUvbQctEaB0X7jmr1D/7PY5XIVvX8jQcNqTA7E+jFM+2UE3W2JHzakZaxhIfWwkvSMjqt5mGyiVBA+3HheW/EaPoyicscbNSE9HMBX6UC+AHTpBIcHhT/+8yTKqIMUtGr/KN/kK+269Vo95nPY31TjJ8AfM31H0nz3q7GtSdYcNbpXsXKNS81eh7nNSTXBa3nDrzVJpKJF1s2L+90lan6ZcVqBVuh55R8DqXI8vqqAqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(396003)(136003)(53546011)(6506007)(5660300002)(186003)(26005)(66946007)(66446008)(2616005)(2906002)(54906003)(66556008)(66476007)(64756008)(91956017)(6512007)(122000001)(76116006)(6486002)(6916009)(36756003)(71200400001)(8936002)(8676002)(4326008)(83380400001)(316002)(86362001)(478600001)(33656002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MunIZOqbU8WJTMCa4cs+/3TQsb9Gy92cVvfAoAOAhIktv16u+/pZYhorFGqA?=
 =?us-ascii?Q?LLznq3f0MJyrbVimhc6CuXeBRi57nxQrkjYYtCLVgiz34q6zsswcl5bbwhVO?=
 =?us-ascii?Q?YHfg0BKGFgM2Ya/F0F8dnpRXcHep4fJUoMbmgn8qAFKx8fgvf8mhTKyVybIX?=
 =?us-ascii?Q?KWPyVLbocbsUxwGt+rxdv6VxZbcRLx5fKkzbcWYt7GsRCVLGCadrHPI6EgCv?=
 =?us-ascii?Q?nSVVpkMQIgVYgwo/8vL+dlii2pKkNLN8g9wwfFzMGzEBgcM5RVcJqgvXvoEq?=
 =?us-ascii?Q?Rvulfehp1lkan8QK8Vvez8f5OTPse5305lAKk/24UTMzHitv7C55ZGVHCwDi?=
 =?us-ascii?Q?SeaOjzx7N+5abUiA4DLS83YnPXBI1tBDIRXrSsV8pvBvNmDJxHSpSpqArwEJ?=
 =?us-ascii?Q?otXxqe8zWeJM0t9LizeZrVneJG8HemFB6WlgUKoitOL3XsUta4Nj88ATPX6/?=
 =?us-ascii?Q?4EP8po500vPMsKKqKoigWY9281M/O2eVR7lsSkUVw9JRMHcv22/DRkQDgUCf?=
 =?us-ascii?Q?1wcu7M6IItjVYky0q4vontpmffTqLPH60IHHvmC4mh/tJs6vhZOoeCPmT8ic?=
 =?us-ascii?Q?JGAxFxitfhyLGHnau+fhyvvVuMxnFuFSyVYMWluM4h6jzlKT/KW9fD5k2jah?=
 =?us-ascii?Q?Ip/2+EJT1Mtlji3Vz5SFxcm3iBdJE7+MgQoef0Z/FenltG9FKwUtRbuNSmqd?=
 =?us-ascii?Q?xK1S4rkcY3mGulaseCuGOU/f0U1QFtQJ4Dbe2Nq/Gtq8ypoNl521H7v9nLN8?=
 =?us-ascii?Q?Mtndb+frdMbbjeOBAI7p0N8LzbzZuAPuo1PbshPpTwoUz/xm/FY7ka2SYsNR?=
 =?us-ascii?Q?sLsbp4S1faP6/RIxaThCa60IyX8zi8VbLBSZgG70LmKjvzJwBrwRESu3Cm3x?=
 =?us-ascii?Q?SRr7+ocFxGJDn/qkqCliTQe7b7ciFu/dGDhwqNs3DXefjg2rQ5FAySnd/UXM?=
 =?us-ascii?Q?1bMFkgYbnhydudIvu2mLUONGfC8Nfch16O6CQEnER0xdI/I+/BR0TO4kkm35?=
 =?us-ascii?Q?w15wRzX7Q0abQt/ZQn9h1vxsi3zPB/XSrHOsQVAl1BvtulX3xj6O2gLbFJOe?=
 =?us-ascii?Q?RAzzuSGDwDUduivzlEDq40NL0c8dZUPp7SLR/DKcadUJHoGyAcGdX5nB2iLc?=
 =?us-ascii?Q?Ti5B24eIe3IV12HJXJhlAXOJCEfNdW5Kw4+KjkcN6KSxZGoHqOG29/Sh4FnL?=
 =?us-ascii?Q?+dvZ3UVkuWy68m78aPoOHw12sIN3GsLqi7J7K2SrmS8p+Navi7iKpfjbhSQo?=
 =?us-ascii?Q?hpqiiDiUSQh/stD0TIZlrEV7WczjX07FcfKfmK++7t3vl78vqR1/MWErHL2P?=
 =?us-ascii?Q?nM8FHRMoPW9oR7ivX97GPUv0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AAAAA71C1A67E94BAE36E623F58B844F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0bb809-5574-4689-c972-08d90747e143
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2021 17:39:15.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kq54maJxB24fnWS7SKqWo53sYOk91gAvqO+fVadluGAoLXfgZDYNeCOVngH9ZDQmK0wrl++fpHdrFRDosmfnBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2712
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104240133
X-Proofpoint-ORIG-GUID: cU4bXEwNAbHu9Rtrx2u88qS0LMg7VEKc
X-Proofpoint-GUID: cU4bXEwNAbHu9Rtrx2u88qS0LMg7VEKc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104240134
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 23, 2021, at 5:06 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2021-04-19 at 14:02 -0400, Chuck Lever wrote:
>> Currently rpcrdma_reps_destroy() assumes that, at transport
>> tear-down, the content of the rb_free_reps list is the same as the
>> content of the rb_all_reps list. Although that is usually true,
>> using the rb_all_reps list should be more reliable because of
>> the way it's managed. And, rpcrdma_reps_unmap() uses rb_all_reps;
>> these two functions should both traverse the "all" list.
>>=20
>> Ensure that all rpcrdma_reps are always destroyed whether they are
>> on the rep free list or not.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/verbs.c |   31 ++++++++++++++++++++++++-------
>>  1 file changed, 24 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/net/sunrpc/xprtrdma/verbs.c
>> b/net/sunrpc/xprtrdma/verbs.c
>> index 1b599a623eea..482fdc9e25c2 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -1007,16 +1007,23 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct
>> rpcrdma_xprt *r_xprt,
>>         return NULL;
>>  }
>> =20
>> -/* No locking needed here. This function is invoked only by the
>> - * Receive completion handler, or during transport shutdown.
>> - */
>> -static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
>> +static void rpcrdma_rep_destroy_locked(struct rpcrdma_rep *rep)
>=20
> The name here is extremely confusing. As far as I can tell, this isn't
> called with any lock?

Fair enough.

I renamed it rpcrdma_rep_free() and it doesn't seem to have
any consequences for downstream commits in this series.

You could do a global edit, I can resend you this patch with
the change, or I can post a v4 of this series. Let me know
your preference.


>>  {
>> -       list_del(&rep->rr_all);
>>         rpcrdma_regbuf_free(rep->rr_rdmabuf);
>>         kfree(rep);
>>  }
>> =20
>> +static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
>> +{
>> +       struct rpcrdma_buffer *buf =3D &rep->rr_rxprt->rx_buf;
>> +
>> +       spin_lock(&buf->rb_lock);
>> +       list_del(&rep->rr_all);
>> +       spin_unlock(&buf->rb_lock);
>> +
>> +       rpcrdma_rep_destroy_locked(rep);
>> +}
>> +
>>  static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct
>> rpcrdma_buffer *buf)
>>  {
>>         struct llist_node *node;
>> @@ -1049,8 +1056,18 @@ static void rpcrdma_reps_destroy(struct
>> rpcrdma_buffer *buf)
>>  {
>>         struct rpcrdma_rep *rep;
>> =20
>> -       while ((rep =3D rpcrdma_rep_get_locked(buf)) !=3D NULL)
>> -               rpcrdma_rep_destroy(rep);
>> +       spin_lock(&buf->rb_lock);
>> +       while ((rep =3D list_first_entry_or_null(&buf->rb_all_reps,
>> +                                              struct rpcrdma_rep,
>> +                                              rr_all)) !=3D NULL) {
>> +               list_del(&rep->rr_all);
>> +               spin_unlock(&buf->rb_lock);
>> +
>> +               rpcrdma_rep_destroy_locked(rep);
>> +
>> +               spin_lock(&buf->rb_lock);
>> +       }
>> +       spin_unlock(&buf->rb_lock);
>>  }
>> =20
>>  /**
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



