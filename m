Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4232C6A3
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451047AbhCDA3p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51562 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579510AbhCCSb2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 13:31:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IP7HR127477;
        Wed, 3 Mar 2021 18:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=30v2owKApcAceMWzTHZhKGl+8GUwKL5nq5dbLQLxIXc=;
 b=EQ5JWpMvjdgRiEvskQL7+AlYOx8t3nYhgktXQMKBGsiXPXFKo1MZU0TGlSXTZQqR8iX2
 2H4I6KhqINqvmGP+N3p0lMSwuNGTHSkNY9UDro7WoD7wb75bRZjtKE0szI5LOiYBDP/d
 NdmZaKaG2H249Phmcs6z9CCH0Ci8fx/qObO6QKYN0FjUjFjxwhCNgRqvEtjl3spexJ0w
 0RfSrI92c1SqPSP+StWRy86kPz8mtwUZl5F3fEHx6ommDStjkcNabsbsCNTdvWJkb0DO
 sGeXmQDAjKB52l2DJjh/jrZxM3oX67GVGAdEGwBm1dNvWzokN2lE27RVy4NAzQTlly2M vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36ybkbcm49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:30:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123IP2os191621;
        Wed, 3 Mar 2021 18:30:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 36yynqw6te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 18:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKQwCzqMpnE6q/aqPKO0H7Q3Vvdas4t1Nly+W9F+fpqQp2IEVFz+BsLkSvzD3dk2uGY3buOZDLfs9lQp0XJGK8HHzzF0eWQwLFLa1wpd3pAb0IucvL6mRx2aUHy18TUA7RfKwhx8VnNgjJPwMcyhvQbDNp0VFOSO2OrjqlzSJZAdwzLI3zxXt9LWCp6FXbM++DtSaf9WA5I+22LZ5tgjqcsFUwyFVu18RteeJUXmyABAUOh7RZ1irACcT/YqFRjdEWBICzpi/89uZzTwyucwlMLhpTsDDB0chEGGFWhG0gAOgueaCdBUyrp3t9moK8QglOV7FoQjVKMAH7WfWGXtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30v2owKApcAceMWzTHZhKGl+8GUwKL5nq5dbLQLxIXc=;
 b=OlVNj+ZpkqDB6u204GSmQ4eKiIb/ZjT8nFp8qzzszdzSVYJjRr3YmqbuTlsGJMjR7GYlGCUox1LL0TmL6PHBs9inBebkgYleo92XqeowtN9Drp5DSlVwhnXl56grygT8zZ//oVCMTjCL22edE9l/0OzML2pdm0H938r8TGpla0nV+HDc+nkxYFML8QLJwG/7wXpDCZcaHeMbnycYki7QL0QhTNRMyh32df7NGUSua71yIuqYxoBfqbv4rfndQMDcXo5/Vt7NOi6vFd6skxSDtYH0K+dUAlGZVTkJXtqVvj6E/DyuiuK58ITzQk3RJpyCJODzGXUotUZDZbzcNWs7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30v2owKApcAceMWzTHZhKGl+8GUwKL5nq5dbLQLxIXc=;
 b=g+u7NF5eOG0Henyitd4erYpTu3qATF0rCZRhDVdaXPcSLm0QNBkX22L1NzYNXNDBV3QVZjhe13rAAoIrKOPGoomS0Wp+MjlsPYFnbHv+oVIhLqwsnilfibV2sAJwN5nOxZt0z59UcZERBUcO8EmcQfprzXXWYwRVEUpu1CA6BVE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3381.namprd10.prod.outlook.com (2603:10b6:a03:15b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 18:30:40 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 18:30:40 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Topic: [PATCH v1 19/42] SUNRPC: Fix xdr_get_next_encode_buffer() page
 boundary handling
Thread-Index: AQHXDq5E9L4cYzCeI0iQSySXwa3yeapxRKEAgAEl6oCAABNjgIAAGDkAgAABvQCAAACYgIAAAMaA
Date:   Wed, 3 Mar 2021 18:30:40 +0000
Message-ID: <0908A838-D518-4F81-B6EA-8C088D5538E9@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461183307.8508.17196295994390119297.stgit@klimt.1015granger.net>
 <20210302221130.GG3400@fieldses.org>
 <592A34CB-C178-4272-8905-F3BA95BCE299@oracle.com>
 <20210303165251.GB1282@fieldses.org>
 <D8625219-C758-44C0-A74E-272019E12C2E@oracle.com>
 <20210303182546.GC1282@fieldses.org>
 <FB4626C1-C2C1-4927-971B-8937420F963A@oracle.com>
In-Reply-To: <FB4626C1-C2C1-4927-971B-8937420F963A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a487af12-4bfc-44e3-3fdc-08d8de7272da
x-ms-traffictypediagnostic: BYAPR10MB3381:
x-microsoft-antispam-prvs: <BYAPR10MB33812309C87C1594ADAEA17E93989@BYAPR10MB3381.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tdz9YWf1vH80AQC4UNuoGP7XqangsAsse6EF3g83rYHBAkpVSKaLN3Ie42Ios0g5h9RSJ+NdvkHi15/g7TbJFmzz3YuiGU/g1HAga/wZyNek77024WyOVGLNrdA+ZjDfno9Amvo45plk4CbeSH9AcfLPniEysBJAf0rXrMQcxddD/I/6pHOAv4KhqkRvPsystx900OfykKLfylZW3uQ/JEXJrwHTFcnTcsIlwi1cddhwpTXiwds3w/K5en24vf9V2SL9hFcKjdhEZa00fQDf0EM1kQS2WF72DrtKn8WG32vlAs7PJKv2ndU7f6GuqJnAo0ciDP+09daokewEwstXtphmfzCh4WHvQxs4WNQgBKOxkbPhSHa4eEaAZ0wSN6Qt88Dec55YowEOQGjUmRRNOhJSbLRUPYACXzyKCUe0Eu+lmkRuSLWvJfLdFfeYJwrG+DGnbZCPpKePeF7MGXiq46G8VRDGEHMoGCtPg26hTHAu8ZFX5lVdQeb5mTfP1I/ru3icNVEiUCPcnHMVgT0vQNrs2ZDnrMvq0kwT7CJKtz1/1Fi5MhEOw/yt19aBSQYN42DT5n4BgZVS5qr2DWtPtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(396003)(376002)(91956017)(6486002)(76116006)(64756008)(66946007)(71200400001)(66476007)(66446008)(36756003)(8676002)(33656002)(66556008)(5660300002)(4326008)(53546011)(6916009)(6506007)(26005)(44832011)(478600001)(2906002)(8936002)(316002)(86362001)(2616005)(186003)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?grEuFOPGfEOfBz3kVT2GXXFCPM6LkZ39knnLd8aOpw7WzvmlRVZ8fG2/aRMB?=
 =?us-ascii?Q?3ruCxuEwmm2/gF/KcAGiso656DDFKkd4BQmT0m6Z+z3otpmgGlW3P2FK/yb2?=
 =?us-ascii?Q?aKeVahe1L7oM1UY/Xhc3s3I4n85wDCkJOAgmZuoaZgiuqLJ0R/Sos2K1BCQz?=
 =?us-ascii?Q?ifnbEvktKTZTDlK7PttVxsbgDNbxRdyJOyDFW1P+q+U3lMe/XXwVzLLGjckf?=
 =?us-ascii?Q?CfYa1Q4129LjAgSQbwcqUJO2gSp4MhuEDvYWf08FKseMJHt5tdOh2eKIGQIX?=
 =?us-ascii?Q?r5whzkEI+ZLdEXaSk9F9zG5pWvAhJkRlitP1D/f9TZPsJyyW73ZMiawfuoWS?=
 =?us-ascii?Q?MV8RxlO7towgTg8WAp1VN1264+I10LS4ScxelNlSjV/4Z05Spd99fuR19tVe?=
 =?us-ascii?Q?t3P9g25tlLPLduO/CiiqJPmjI44529wu7hk3kmd6FIrSMsEuzXQREZqzcDH7?=
 =?us-ascii?Q?EqJbYzwGDTF4cY/eTNvE0DxN7KVQfJRQ0YT512iMCV2pDtkhRc717iBI5Dwf?=
 =?us-ascii?Q?PoepqG+RmNv8Z7tXydReJtZZCFFqKU4C0Xc3j9+3BubUsp7X5T212SjJV2cQ?=
 =?us-ascii?Q?h2MTzs6v/wUAC7Y1VtZw+h+P8teXwXg1Ve4r3GptPT/+7l7du43FTwRT2OIZ?=
 =?us-ascii?Q?POSbGJE1yHLB4EoY9r0F9PGAggTBY2UndBSKNBJg5aS8Cs9JeRD608i+NZgL?=
 =?us-ascii?Q?1ZCK58xuuk1I6Hup9+GUiTVFVBbt+xH9tABtEXKhpGzs3EcVzV6Cc1U+QzUm?=
 =?us-ascii?Q?bRl7aoWNwgROEHJi2d4hTn9jG+nroO0azGV43zdoVVguZd9cJyQ1fUzGeW4a?=
 =?us-ascii?Q?kBqnhgYzH3jcl08Vu71LqQ03bQUttWSL+lFRzGPurx2nKpt2WjQ1sZA9eDCN?=
 =?us-ascii?Q?E1xzdFa1r1aJL2OvJ16R6K3aS78exAvSnsaTSeF66D21iDCGJg+zOJyR+ay4?=
 =?us-ascii?Q?LJS7fzXeQBaecBAtafE+BXORuqZVTodi+KLLLESd+0XeLebFhIqDToYbjD4z?=
 =?us-ascii?Q?aDV5PNQhgGMOAj28lDzF2PhJ0mcR75UUKanj62DGX3QYt6zynvGU09HZJ6+R?=
 =?us-ascii?Q?Lk6/B/zeEj3ngrCBLr6nuIf63crIHW8l8v3qYmY/mVprI0wHF+pnq0StRMpS?=
 =?us-ascii?Q?2xV4C8FR+3r/speX1JYhLDIC28PXac5XWa4XTdNXAizRIbdsW0JetSoeK9/+?=
 =?us-ascii?Q?IRsOX0sclS7jqIplRhdvjJwjMD0ifOs5iqIemsf+Mz7eFKOYhonnFnXtxlYS?=
 =?us-ascii?Q?kk13EHcKzK04y4DrM0Ysip2RDvF7usZ2JJhooR18py2vmBdqKJ71QCR6f1AB?=
 =?us-ascii?Q?qAxWpJDbVtCgx+qZWeLI0csfBlH19AkZm6YZoF0FWIyCgg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F9F9FFFAABDD1409AE02907B2EA4001@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a487af12-4bfc-44e3-3fdc-08d8de7272da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:30:40.6224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDNIzkScqEXMoVxd1vViVcTeZwmtl76IsCBhmcyHKq3vIgoT9cp1w2keDzzOs77IQcscP6nDRXezqKlJ8QwbUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3381
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030129
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 3, 2021, at 1:27 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
>=20
>=20
>> On Mar 3, 2021, at 1:25 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>=20
>> On Wed, Mar 03, 2021 at 06:19:33PM +0000, Chuck Lever wrote:
>>>=20
>>>=20
>>>> On Mar 3, 2021, at 11:52 AM, Bruce Fields <bfields@fieldses.org> wrote=
:
>>>>=20
>>>> On Wed, Mar 03, 2021 at 03:43:28PM +0000, Chuck Lever wrote:
>>>>> Why would that not be OK? the next call to xdr_get_next_encode_buffer=
()
>>>>> should do the right thing and bounce the new encoded data from the
>>>>> next page into this one again.
>>>>>=20
>>>>> So far I have not encountered any problems. Would such a problem show
>>>>> up with some frequency under normal use, or would it be especially
>>>>> subtle?
>>>>=20
>>>> I mainly just want to make sure we've got a coherent idea what this co=
de
>>>> is doing....
>>>=20
>>> Agreed, that's a good thing.
>>=20
>> I'm also a little vague on what exactly the problem is you're running
>> into.  (Probably because I haven't really looked at the v3 readdir
>> encoding.)
>>=20
>> Is it approaching the end of a page, or is it running out of buflen?
>> How exactly does it fail?
>=20
> I don't recall exactly, it was a late last summer when I wrote all these.
>=20
> Approaching the end of a page, IIRC, the unpatched code would leave
> a gap in the directory entry stream.

Well, when I converted the entry encoders to use xdr_stream, it would
have a problem around the end of a page. The existing encoders are
open-coded to deal with this case.


>> --b.
>>=20
>>>=20
>>>=20
>>>> For testing: large replies that aren't just read data are readdir and
>>>> getacl.  So reading large directories with lots of variably-named file=
s
>>>> might be good. Also pynfs could easily send a single compound with lot=
s
>>>> of variable-sized reads, that might be interesting.
>>>=20
>>> I've run the full git regression suite over NFSv3 many many times with
>>> this patch applied. That includes unpacking via tar, a full build from
>>> scratch, and then running thousands of individual tests.
>>>=20
>>> So that doesn't exercise a particular corner case, but it does reflect
>>> a broad variety of directory operations.
>>>=20
>>>=20
>>>> Constructing a compound that will result in xdr_reserve_space calls th=
at
>>>> exactly hit the various corner cases may be hard.  But maybe if we jus=
t
>>>> send a bunch of compounds that vary over some range we can still
>>>> guarantee hitting those cases.
>>>>=20
>>>> --b.
>>>=20
>>> --
>>> Chuck Lever
>=20
> --
> Chuck Lever

--
Chuck Lever



