Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222D1309071
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Jan 2021 00:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA2XJP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jan 2021 18:09:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA2XJO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jan 2021 18:09:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TN09oB045256;
        Fri, 29 Jan 2021 23:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eT2e+mmu7OvBHLNX8Zef2dKl1i4T7JDjawtuxvPoz+g=;
 b=e7LAZGg1dskA6qbn8TtOwkUcElUws2Y/4yE6s0vqRmT1A0aBlAThM1cjEo5KVlx3KV3h
 m4wVM0BVvn+gh2JUpynCLy45YZo1EQrU9nc58d2Lv9vVb0nUfc4X+XyCsYZlbDd2MMKM
 4AqT3KMdqD+FIeESzib4h1ZpysRF8Hl0z4WeMeOOdXdv1c5C3SceSk1a+0EgnylLWMAY
 0gIR2uXuGIfOv2rjyADCvrsQXCSoZqYjtiQ1w0zsVqf1BIgGWmWTYnw5eZP0vlK3/Lj9
 y8kRtb0iragBvGqinhvgzqu/Ayt/9lh0Xf+Xv2ofQLJGIgJBC+NEodFPFjrswzXkq9US TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3689ab3rdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 23:08:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TN5J49074623;
        Fri, 29 Jan 2021 23:06:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 368wcsvraa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 23:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZodDHAjmyeJPESuJvpLZu65FjGoLKEIxL8ZEmA+faN1WQVPwU272B0BLWAj8ispGWH60Bsi4tIF5RFzzrJWpJuuL67eCIJuEJ7aBjWAVw1gN5pVEjFH7vxHf8xwCKprK/0PSEZBUS1xntxIcXXoTTwZX6Ph6pp9i74vV4+a+cu0sKTywNIv3CUMy9pH+7fK/Y2U7VH2QvuGGI0ZeSAwtcbvw0gb7B7YxyJNL0gMcdAc8HBDZm9CsgsxfKZxlwF5DTG1PF/bQmLvMAeN1gTcZZE0Wr+CuMgGf1XP0P59DaoDandjvItzJjJMcVMl6M32FH/Roy4oyqUBD/5D0FnWiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT2e+mmu7OvBHLNX8Zef2dKl1i4T7JDjawtuxvPoz+g=;
 b=PnYWM5GDEj13tYhKMkys3TIyWHnwPB7lcuj/sWhgSvLpQEtd1LYaHMvQ+rVI8orf/nVKNpTjYL6f8Xq7CW6VyGZeX7SmR9PLCN8OzGm8i2LiXt2SkLnZJIn5k08BKbTFZlzVDRR3Sf2FC5X24AbN67HIMZkHxCI5TRTMCX9KJpXMUoip5e4In4NURkdZ/Pg0JZWRqHy0qk5E+bSbESiS/7PEDadqxxK+J+F9DF1BV9Dnt51Mxz1IDdCXWFhDPnGNkXRoawUaao1JYiTCHfWHzIa8F08XHfcF64/16VaDUGdjvS/++lP+2R56tD36T7qVLFJBQZ/deCWfGHoe6u5Yig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT2e+mmu7OvBHLNX8Zef2dKl1i4T7JDjawtuxvPoz+g=;
 b=Ww7054oii6oK+O9AJmubVouoV6uHZM2GHHt1+y7Vqbeg4WbjtaHEoP/03B3ADE21vD72CAx3omzKt7cDWAJO4+bSKeoV7bh1fL7nTn5KyS4tO4vsVbycmtW3mkmxA3px6Ov8X1u1l4usEufzbbYxUYbA7fs1ApXlZ1GR1lVi+RA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 23:06:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.017; Fri, 29 Jan 2021
 23:06:27 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
Thread-Topic: releasing result pages in svc_xprt_release()
Thread-Index: AQHW9lp7CEvfS3Emm06zTXNJoADK66o/M5eAgAAGcQA=
Date:   Fri, 29 Jan 2021 23:06:27 +0000
Message-ID: <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
In-Reply-To: <87im7ffjp0.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aeda9d0-47bf-4aaa-a350-08d8c4aa81cf
x-ms-traffictypediagnostic: BYAPR10MB2869:
x-microsoft-antispam-prvs: <BYAPR10MB286929E3F22AA5FE7112B23F93B99@BYAPR10MB2869.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKyNbTUTS9SuSnNU9jPa2NiEGyIyhd7Z7P1NgtWPOy+mVbOHn4KJ2+Jn7GUQOqPPca+HFKZnfxafCl0YwH5LFK/qdY1fWXe8v+JDr7trtMKQ2moS0NKsnxa6tcyVK16o9BA0ZUOev/06Clq+cr1h8WWi4DH73ONggc/I9V70usI2e6pWNM7c9rDpadgXwEbZlnl781kw8Jx5o8MjpaIOpgSuE6JF1U6eKj1kW7Eeib8nVjfrY/zrVEYw74jkGlLa6YTfVTejWPgNeBNLC7uUkX9So1K3fdWmeUT6K1jVQTLYFsD0f+eb7PZoRtrhp3cOHEPduwE2sXDPkhvUJi+/9uGxAD6J4IIHE247DPHvq8DaRYD1aTktieTvMhk80pmPAW4O+2LhhNnyzf9WQ9aO2RaaKRpbdYK/XIvJYFgJb7NR3ILOKOJ6R5Am8DBVJOlXRKnxn8skBxQQ/CfGYVHlsI+3k4yjwl3ghT6eKJuw0bHLKZ551sZRCLhuBgKf69xUcegPkmFrnC5XD/37TEaCHQbriA5bQicms7nkzi8WUDpWy6sNBPaT8DPCRTBb0l0KZhQlTDW5kcqS1rb2W1+jzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(396003)(346002)(366004)(6916009)(316002)(4326008)(8676002)(6486002)(26005)(186003)(44832011)(2906002)(86362001)(6506007)(2616005)(53546011)(83380400001)(8936002)(6512007)(5660300002)(478600001)(33656002)(71200400001)(66946007)(76116006)(66556008)(66476007)(64756008)(36756003)(91956017)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+vhLCdugJehFNg3oo58nlkIgorH7RZvdixHHIdLo74hnzPhL57j1WoY9DkRk?=
 =?us-ascii?Q?h/YZOR4/8Kqb+uuITjMrLV320lzCS8Lgn3xy83vL8LoAOIrVqiWkbrfpQ/EC?=
 =?us-ascii?Q?DTkrHrDrIOfZroofs6ievcn9nkRadhs9o11/ihaiJZnTUT2Xkrm0hbS5dRT9?=
 =?us-ascii?Q?JWT+EYSYHCGt/teSC5iPb/DOQ8cRsoXcU7DVEjD0db2lui11iokkoedS6Ld2?=
 =?us-ascii?Q?QvL3ihkIBULlzXZgsXEKSaiHj5xnstCVpknMpv7/sRXs80wCwyhFf4FJ+g3s?=
 =?us-ascii?Q?bsk5ACWvYqW3MxfAIqCwnsYP1Tu148S+S1JbHNdHcmNDFmPbUtgiuBcdUHRZ?=
 =?us-ascii?Q?bxRJD6exBdPkrbQV0N/i3pl3RoFNi2cEqf3FH0dJA/V+dfS5E/g2J76tUKeI?=
 =?us-ascii?Q?BZN6FpWVzGwrarSAWIgcnGAmBtgjYPfyjRS+PfETUe837VDFWG3/WqZFkuHp?=
 =?us-ascii?Q?4K1ermUMXTbEVSOuaxh/0fXl5z/bSnjcakynAqMe1ypPxZEpFdWercBP/6Zn?=
 =?us-ascii?Q?cFoixTS8PS/y4wQgs2gNP8cLZpsklSft3EHM6yDMj3Xw8zC1/0MyqHGwSf6Y?=
 =?us-ascii?Q?fNezMYRzLjTaY8WK2WdVVlgJHE9i8KcHwq1g+W9Swd+5v7Q+FGmCgEmPFpQY?=
 =?us-ascii?Q?7JgkMhQFKeYYLuaBytpy8VNjBILuYQUChAr1qQUJEp8pk0INSGeLIaVrStYM?=
 =?us-ascii?Q?gCHoBqMhbrHT05SfyTu+NwSH+ZCNQ6stXhrWYyNthBEWs0F3/Iiin9Vsvcrt?=
 =?us-ascii?Q?s0G7W0GPHcUcHGv4IDDm4AelOJBW/gEll16J168k4amllMfbN03kzHxKlLgQ?=
 =?us-ascii?Q?DeMqKOi3rLnXD15Oa+394bv/QsNjoQd4UyiBvYd9CPBuldquqWqLJC8AUAeT?=
 =?us-ascii?Q?b8aYNRroHf1bl1HrJZmAGURLEJXwPO7LMXq3R6zxvISovKyJhsRHn+J7LsHt?=
 =?us-ascii?Q?Bc8KPFx0V5DcXekVu/dqucw3tDjsXXhO8+inL6zA4AJXf/jcNIT5UYyjyKRC?=
 =?us-ascii?Q?2LtOcUhXk+NNDQ6V8KtjL09cZFyeRT1EHgWqYI7S5kgTZqd390xE6d1BU+bh?=
 =?us-ascii?Q?N1p6+5yhfjEShXPqdKKn/MbC5FZWFw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE024EA983BCB544A4A03C189363E520@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aeda9d0-47bf-4aaa-a350-08d8c4aa81cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 23:06:27.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cP1DPq0eXZGW7z9QRJp5V+K284pv67TWiJ8JE/iAff5V9bwpP0qRJ+CiM0iLz/KoMxs6/eqxgAuVuYs3ij1M0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2869
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9879 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290113
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 29, 2021, at 5:43 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, Jan 29 2021, Chuck Lever wrote:
>=20
>> Hi Neil-
>>=20
>> I'd like to reduce the amount of page allocation that NFSD does,
>> and was wondering about the release and reset of pages in
>> svc_xprt_release(). This logic was added when the socket transport
>> was converted to use kernel_sendpage() back in 2002. Do you
>> remember why releasing the result pages is necessary?
>>=20
>=20
> Hi Chuck,
> as I recall, kernel_sendpage() (or sock->ops->sendpage() as it was
> then) takes a reference to the page and will hold that reference until
> the content has been sent and ACKed.  nfsd has no way to know when the
> ACK comes, so cannot know when the page can be re-used, so it must
> release the page and allocate a new one.
>=20
> This is the price we pay for zero-copy, and I acknowledge that it is a
> real price.  I wouldn't be surprised if the trade-offs between
> zero-copy and single-copy change over time, and between different
> hardware.

Very interesting, thanks for the history! Two observations:

- I thought without MSG_DONTWAIT, the sendpage operation would be
total synchronous -- when the network layer was done with retransmissions,
it would unblock the caller. But that's likely a mistaken assumption
on my part. That could be why sendmsg is so much slower than sendpage
in this particular application.

- IIUC, nfsd_splice_read() replaces anonymous pages in rq_pages with
actual page cache pages. Those of course cannot be used to construct
subsequent RPC Replies, so that introduces a second release requirement.

So I have a way to make the first case unnecessary for RPC/RDMA. It
has a reliable Send completion mechanism. Sounds like releasing is
still necessary for TCP, though; maybe that could be done in the
xpo_release_rqst callback.

As far as nfsd_splice_read(), I had thought of moving those pages to
a separate array which would always be released. That would need to
deal with the transport requirements above.

If nothing else, I would like to add mention of these requirements
somewhere in the code too.

What's your opinion?


--
Chuck Lever



