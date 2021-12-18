Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1998479C18
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Dec 2021 19:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhLRSmH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 13:42:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41922 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233837AbhLRSmG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 13:42:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BI9uDCZ022254;
        Sat, 18 Dec 2021 18:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QMh4ZdouJFfnZlpfIVFPqPRsvfM0T+9OmL8m0ZDrV1c=;
 b=ZIRBQN2LSNISF8TM2oY4pnwZKpXJxAGFn5Hfmc1TmLJDyOOEIusRo7iNZXrHocFUorgF
 nPBDPXVBNuGBX8vhKsnEwcjsjCeUAzWC5+39sn1aBz/KDmc/zRCUyUe20gIoCPI/RKyv
 85Sx4/ysQF57hwtcBaGK261VQT3rAwBmDY4apV/w7z7B+KtteWOOvt8b/cHoM2xfR55e
 T3IMRW2L+55guvs1nFhSjgTUklKv/sLF1d5M5ElWcqX7pfyifv67ph1H7yhTqyNa632C
 H35asm4XhqJP6iL1/WoTVxI+lNRY6fOaJ80xCst59fZ5J/CknNMSXzyeL0G7n6vxjMx6 NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d16800u8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 18:42:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BIIaiHK173619;
        Sat, 18 Dec 2021 18:42:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 3d17f17haq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Dec 2021 18:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1SNSN8k3oD6SCbAhPEKOcuUortPgONJh0E2wKOLc02duN6LHnEVN+q/LHNih8aiqlO3h7diSsJ9TK/nh/cZ+SAlRQFZeRuV0+u4MAaeZoi9mJCouOBUcNvVQ6DzcK6vKOrAu9cGza3AqaPMqaLVOzwfYkWZ9E4Csc55wK/tsRQEsf7VVm3HIwgYYvaoDKfK2fH+CiuQapPVCgkkCpSUk5bRdA9B8YkdKNr6UT/kkQd/XO0JNiqQheoz2StPmWaIqx94a32DLEad3+ZjhqGbLY7sPX1zlaO/QzR07ywlETvHuzLYQzs8pkL83v1hxcxO7ayYEZVkC9w2kGPszWNDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMh4ZdouJFfnZlpfIVFPqPRsvfM0T+9OmL8m0ZDrV1c=;
 b=NIpfmDuXRp+zKj6kad1Unvk9HbLJTqOnIDPG/NKTOkqgtg3ExVaPdw8gVjsRuThMrxgYseztZQjTJoN3ZijL/JC9dyI2PHHnM11PIC0J4fk4ns43hqMbu9x9NJ2nQxdffqwQYueznpxlgT12WSk8QzGeRllzz5raZF/yc3SteXp3Z7XtU04g38cCFXZuKBCr7YB981Br8pCZ9MWnaxXMFLGxqmirU+ogSOrNxu8fHxJ8+QFnR4XesA9KPdLc0eOhnd+Gux9A4n5bpbN6fzJ9c9dnfbetEMvSljwZbr2TwRSH6lKpcGSyU4xWggdJ2MPohW0sLiw/AFkFQtvKbsDRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMh4ZdouJFfnZlpfIVFPqPRsvfM0T+9OmL8m0ZDrV1c=;
 b=NUm4fWs+kENhym9wIgNxqmo8Gvua1csRsbBJHTaVOVvxTJd67N14cjk5Xsf/c6mShE/CQO607ucntktESHzKf0Ft1AQQtMx2ZsAdMqP1ck2UU5XSa6uM5Ju7PTQHmj59O4jqD9dXr/gNa0oizC9OXoUy5uw82P5LNrUtE6550aY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5323.namprd10.prod.outlook.com (2603:10b6:610:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sat, 18 Dec
 2021 18:41:58 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 18:41:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/9] nfsd: NFSv3 should allow zero length writes
Thread-Topic: [PATCH 5/9] nfsd: NFSv3 should allow zero length writes
Thread-Index: AQHX85EQOpfoO3BIDki7nGQFL8H16aw3QksAgAFUcYA=
Date:   Sat, 18 Dec 2021 18:41:57 +0000
Message-ID: <3A406AE7-B088-4618-9FA1-63BA6E939578@oracle.com>
References: <20211217215046.40316-1-trondmy@kernel.org>
 <20211217215046.40316-2-trondmy@kernel.org>
 <20211217215046.40316-3-trondmy@kernel.org>
 <20211217215046.40316-4-trondmy@kernel.org>
 <20211217215046.40316-5-trondmy@kernel.org>
 <20211217215046.40316-6-trondmy@kernel.org>
 <CAPL3RVFaWgdWQnWOe5B_6=1pNGSOZXp=SVFOBs24aucXphi6wQ@mail.gmail.com>
In-Reply-To: <CAPL3RVFaWgdWQnWOe5B_6=1pNGSOZXp=SVFOBs24aucXphi6wQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 224092ed-eda6-4139-f304-08d9c256125b
x-ms-traffictypediagnostic: CH0PR10MB5323:EE_
x-microsoft-antispam-prvs: <CH0PR10MB53234FA4B664D1DC5810F75E93799@CH0PR10MB5323.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xPjDZU/ryjsb/uZcN6nj8NtMAzN3A6UKQuQ1+vL7QFvEjd6KWkVEkoRyskGQKcHyb5Qs8pk0sMbsNVkaLUvkDyXSTocM75ofdQ6nagtQrJTGdkvHV+ssFODrGtJnH7h05OX4RlLZl81JwApvSTRSpdcABChlvDhaIN8cJeaNqoL47QG8hqLaLMSWWUS2x6j8xH4uYE7u8dooX1aXM8JPQV76KXInhsotUjbremFzjzGKz6CzNfIk5V715bOiVFAcwB4Ee4liJcOFcp3Gig0oYTMy/hHz+ApFxq7gE7ljpcNQ5lORO2358cXZiszjh6MHXyKmbHPcMSobKVZ4lX7ce1wvShOjjFc5emmKRnC0XCIW6x1u4SXJrmcQogMI7C4SxxzW/OpPv+qIcfx1BZNjXZkW1r0CgwjhzNywnZtdhFVzd/HEkBzLRrfk9ZRp6kpyb6/pzfGnh7N9tUR7IUFj6DX6iPYxbfAnCjxGDSFLj/v7KHa+zqPASJ+sJs/8ug+hkbWqdB7vdO3zdl+YJekienYWOQ9QQtDmyXRXhj/+Gz1WQPwgATEs7hriekRisfOxvJZVkDyfTm7UVLlyZEzSTpN+vM8OD5jiqCUCRsV3RYxtdM9WBUGvtv5QiCcM5I9mTiRthPoffwpXEG5AIgnc/sjgcOEiwhdsSixzgPHQjdoxzyvwrB52yltoZyAh6Uf5PCH6dUQxx0WUyAaKEPjF2WwqI2NK55nQ6BhDb3f/EyQ2oBFE3SAZ+Y135chBsEH/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(5660300002)(2906002)(38070700005)(26005)(4326008)(53546011)(83380400001)(33656002)(8936002)(6506007)(76116006)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(2616005)(6486002)(316002)(8676002)(71200400001)(6916009)(6512007)(86362001)(54906003)(122000001)(508600001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bRXTN9HA2WTgWNsEIy982mJUYBrS+eS6Q7Y5iOyGH/QELs3E/BpXTGwSKVoy?=
 =?us-ascii?Q?TQFqfb8OvgDNCxmtNKgobnrgzXl6BH+fqczu2RPLVaF9jMaozcDXumns+y0n?=
 =?us-ascii?Q?Kua3cEIEgLKCTG9FCEZ87fJxzM0cUSm/LCxqSg3uiyU/EyhxJA5XND7d7dwS?=
 =?us-ascii?Q?ONfVQ4SxMt/3Jib0wOl+p7U/JWQ2RrNLHvIOr46kjfzGcW7ZbQ3txFTtBSgG?=
 =?us-ascii?Q?ImGItJUIk73TKWll/tI9O368o/OOjTC2V0WABjS5+i0QhNbPZwE491Rk800c?=
 =?us-ascii?Q?VRr/YTMDx+aY4tKw3AsD/gIPpDqJK2tS05oKG8JBdkC9HcyFnQc1jMoEIINi?=
 =?us-ascii?Q?WDrUe7Ya/s10L78jFewbAYSrLnARghFLtOc0Ckoq/tN2Fvx6Sy5Fd6mJwJhL?=
 =?us-ascii?Q?4NA7ToB783DuFi9c45apLoHKDDil9opDGRNJohIcexkbUMfZKZH9vs/2excx?=
 =?us-ascii?Q?xeWippmS5jtKZVEf3nWlaWNxcNTSrIHwOGFeLgGdXQywY17fzKWBrlTYacoh?=
 =?us-ascii?Q?953xLVNeUtbTUn7Xuo/WRSPJE4VnE09fGlHd+opXDYuO1WTOblHn25lvbT2c?=
 =?us-ascii?Q?c/CynkwBkviSBJygDMyAHSlUlndRLAwYt67H59q4Wg4ou62J+gEZI2lkUayl?=
 =?us-ascii?Q?WeOp8Hm06hjPfzVw+vFIi8sjkAi2KJB3f+yEq1UJfDnYO+kaXZ3z16sdHdCA?=
 =?us-ascii?Q?F9FfeJD9j/fPEIkbzekJcEnPt5XK34IdKZxwDhkjbRT2gI8ukhFTxiT1gU7d?=
 =?us-ascii?Q?fxy7vHn1wjEK3IR7+wLTbOYcloQ5rhrntL+GBm4Z+QsaNUL1pEn+JdJRkhYl?=
 =?us-ascii?Q?iRCjYfQB8xbMUzcu15F5n70POAg5nERQAg6VfIPExSZW/rXITaZMdh+3H8YX?=
 =?us-ascii?Q?UZkP9u2S4RLvSkZLmINylv/eymwDOCaxBR1C0V3pcLQPCmu6uC7c7QCJV2Gc?=
 =?us-ascii?Q?+C23Xu3/fBJ4FZNHCU4IohtTAKjBR6ZnKqKbPzptA0R67kqsx/jIJOU/Huum?=
 =?us-ascii?Q?q2h9x3/MIjiiHsm/tLM6tXXIV119IKVDRXdSlb8kikN3ynjpbcROJoFARavp?=
 =?us-ascii?Q?yKb4znT1q5ozO2bb7zAGXGZ2sxtasqufAZZm7bNq5tH/L2mJmR1ni6LNmNvt?=
 =?us-ascii?Q?a0BC81hJ6giprgEVN5s7lfEA/CT+2uPT1GB2KNgg7jc7A7pu8+cEWqWzDi+t?=
 =?us-ascii?Q?FB5gkVNJir/rtaW8Dn/JW1kW5c/vfXaHJrAWurOYxCotTgAU14NwuHwGNajd?=
 =?us-ascii?Q?qh0jo41CsYxwPXleHXL+qQuoMMFwR2F4UvUOkjfOQ+Yx2RV2IodenrMrZ255?=
 =?us-ascii?Q?wVmbW12k1TZHWtK52YNRkXhGsRzDHooQ0hrWPAbJhsJbTQ4WATC9/Gw5MEAm?=
 =?us-ascii?Q?64TXp6q6jPDBM4byP088dpzzhWuKKw/sREWeR2XLBpmGw7OZNFu7oSWZ3wjU?=
 =?us-ascii?Q?wJW1OJ1EDAPHq7PVeI8qlfS+kXtRzEQkFJvxscdjtD1tRdt3b8KnMoTjjkKv?=
 =?us-ascii?Q?/B1QwuVNysi3MEM6XAyyCIHLWAfEokQWnQ8GprobmSGqo8XMCL7Ul96OypRn?=
 =?us-ascii?Q?O0X40/s7hckmvWZPMLg8Nfswd5y8P+CPTW2dbrD6cozuGORHLt5hcdeIrMUC?=
 =?us-ascii?Q?bwhc3ux192joGJsdqCbKJ0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4959E698D6355142A4DA3023750172D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224092ed-eda6-4139-f304-08d9c256125b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 18:41:57.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOOtRepJUW+jvRpcW4McXql7BNLZeVNnfXsxD2fm4N78GM7cfX5a3Vq7nqFmoxm4xwa8Dec3a2TUh/swdAct3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5323
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10202 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112180111
X-Proofpoint-GUID: JktQHWp_BlnIcm4M55HOmWTmZ7KSk6UR
X-Proofpoint-ORIG-GUID: JktQHWp_BlnIcm4M55HOmWTmZ7KSk6UR
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 17, 2021, at 5:23 PM, Bruce Fields <bfields@redhat.com> wrote:
>=20
> On Fri, Dec 17, 2021 at 5:07 PM <trondmy@kernel.org> wrote:
>>=20
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>=20
>> According to RFC1813: "If count is 0, the WRITE will succeed
>> and return a count of 0, barring errors due to permissions checking."
>=20
> Yes, I'm surprised we're not already doing this right.
>=20
> I wonder how far back this bug goes.
>=20
> The svc.c code is from 8154ef2776aa "NFSD: Clean up legacy NFS WRITE
> argument XDR decoders", but the behavior might predate that code.  The
> nfsd_vfs_write() logic, I'm not sure I understand.

The new check in nfsd_vfs_write() might circumvent the VFS
layer's security checks, so I agree, that is a little suspect.


> We have a pynfs test for the v4 case (WRT4), but I guess we must have
> nothing testing the v3 case.

I guess cthon04 doesn't check this case.

But it seems to me WRT4 should already tickle any problems
with nfsd_vfs_write(), shouldn't it?


> --b.
>=20
>>=20
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>> fs/nfsd/vfs.c    | 3 +++
>> net/sunrpc/svc.c | 2 +-
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 4d57befdac6e..38fdfcbb079e 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -969,6 +969,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, struct nfsd_file *nf,
>>=20
>>        trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
>>=20
>> +       if (!*cnt)
>> +               return nfs_ok;
>> +
>>        if (sb->s_export_op)
>>                exp_op_flags =3D sb->s_export_op->flags;
>>=20
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index a3bbe5ce4570..d1ccf37a4588 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -1692,7 +1692,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst=
 *rqstp, struct page **pages,
>>         * entirely in rq_arg.pages. In this case, @first is empty.
>>         */
>>        i =3D 0;
>> -       if (first->iov_len) {
>> +       if (first->iov_len || !total) {
>>                vec[i].iov_base =3D first->iov_base;
>>                vec[i].iov_len =3D min_t(size_t, total, first->iov_len);
>>                total -=3D vec[i].iov_len;
>> --
>> 2.33.1
>>=20
>=20

--
Chuck Lever



