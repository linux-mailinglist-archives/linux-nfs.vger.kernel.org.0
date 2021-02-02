Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68C30CEF2
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhBBWcc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 17:32:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbhBBWc0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 17:32:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112MDjCT169527;
        Tue, 2 Feb 2021 22:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UNWzuhy0vJ/kIwx8Jb4tACJ63N+VmV0hVwlqs3/H56g=;
 b=u+gUwmzbvDhhh3OvVsDKzNLPre9yjsYSBEJtlYxNVND8dplD7ypSSSqWRHyJFmh4r0IG
 +LDoAJZACcG/PouZ8eHYe8fjxZGJ+z3VW1ZrGCePS7s4bXTr1Egay2P02WMhn26biBh0
 KFzdobOZQVjr7/K7oGns9efaoyiKhFRa8HIGkKfuExhPoSg3uSXlVZ/xJsBTaMaw5eOI
 utkioB2RgMZ4ZRm4uJk4rKgUTiIZduMmkby57iESF2XFOPF6axAAywY59T3pAQFODavh
 CbFzidFNthW1mOD90i6ysZu5zaV2t6wDaQFG2m1gRAGmNyqSfN8mBarv1W6EbsVhJtDp Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36dn4wk29s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 22:31:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112MAZse001466;
        Tue, 2 Feb 2021 22:31:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 36dhcxemxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 22:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub03GOpiWHk3pBbhcgrgqxhYPumvyl67BbdrljBDS6SEi6DKPChJji5BU0FIfRyGVz2BiIywZbqKVFjsDGREtSmuKeizHQS52XqK38gOIXSxoWx7AcrcZUnM75oeHNIhHoJFdfpxHIxs0+xSjttx2wqqQO92gUqrRHoep3SP5JXOA+HiduZ+Q86wNwyCRBx22dOxuyvytVqpdGcYD4qHxi2qNbDs9FCAF0cUaOU6uVZ+wvpVnrGve0fgTzyqwa7HzYah3eQprVK74KqLaR00ljFRj35cupKQWIb4bhsHJeHdGI00JY1ljBqcA8LnDlYSKdPmHf9v2UYkR0m3lvviNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNWzuhy0vJ/kIwx8Jb4tACJ63N+VmV0hVwlqs3/H56g=;
 b=IrXR9LVwBirJ+ugQh1Y2w2Q1+wkJO9B39god2BaoWqXp8sSn0pkhCuRpqmdScrzpkSmwozI5OEqv1qzmHJpW7srdcdVb2ufc6F3NRnVaiSiFxs1/M4QvX0R5N/ylyqh7PmoCF7FLxjQmX9mOnIVO1BaKZ/YkOiPl3HSQcwJTSrZI89wrPRpr4UHN7TfH6GZSAM0EYCcFCDYJuByUocok9S+PiOlQH366wQ7VU8wOKPw0uwstFSXepljfSMHcve9fYMusnnpsCBElx1SjJheq8Op5Ide72DLQnZpJUah1/4A1Xvp4ynSwOf5yWLdSWzj6chfnGyPtHA49xA9cjhUqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNWzuhy0vJ/kIwx8Jb4tACJ63N+VmV0hVwlqs3/H56g=;
 b=NgDTlnVtxERRsm/P2xex9AZ5bGZSOgC8k/dpiRHk0gqtoGrEYS994PlHBHdy3CUNA4FsuBcVAvngLW2xC0vJoGQlJOSi1/sYlMxQEgrrCqNaicEyggJdHiAvdL25TpjTfp/eDpnHkuD7QsBDGgiUQZPrDtd7/a6XmEq7l3MC2Nw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2918.namprd10.prod.outlook.com (2603:10b6:a03:8c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 22:31:35 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 22:31:35 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dan@kernelim.com" <dan@kernelim.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        Anna Schumaker <schumaker.anna@gmail.com>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Topic: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Index: AQHW+ZPDkI44uVsPcUiYIRmrZ1p/T6pFNZQAgAAASgCAAAj5gIAABxUAgAApaYCAAAD3AIAAAPCAgAAB8IA=
Date:   Tue, 2 Feb 2021 22:31:35 +0000
Message-ID: <B090C50A-326D-441F-A146-73562F9906A4@oracle.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
 <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
 <20210202192417.ug32gmuc2uciik54@gmail.com>
 <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
 <7dfd7e3b9fb39da71f1654347ca2f2feba4fc04d.camel@hammerspace.com>
 <102D99DF-30C7-4360-9A84-D5A4DA77FE1C@oracle.com>
 <f78d47587d548933598a044d8094ed496400cea2.camel@hammerspace.com>
In-Reply-To: <f78d47587d548933598a044d8094ed496400cea2.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66319820-4b42-4182-f8ea-08d8c7ca4cb1
x-ms-traffictypediagnostic: BYAPR10MB2918:
x-microsoft-antispam-prvs: <BYAPR10MB291803FB23B7245E44CE0AB793B59@BYAPR10MB2918.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YN3EA6M2HHwy5Ebp6fBMNEqYBtwjajl0AiSc3tbw88vEChQykiy+IltOSZN7ODdrTGdbUMxVgBuld+nGPeKLsvBGQmOeHMmvqBdI+dS2vpp2NI6m/nCTOmNNkAvAT1i+8283QCNOiBtYTDhgHFOEkeZBENmVS8y3Yxgh9if9AqpQg3/Jx30tkCfl1TG1daNlZe8B1bxE17xEJjNBCQvsE+o8l/9LMTQ9feLoCr8G1Cy/49XPLHLuG9UHAUzhUlA86Wzc8wFlfSGbOvt4ukl1CiBv6vLE5kp0P2YWXfD5fv/5VvNAwL6RGxAtK9yWBCNIqKbqiBiqmZoKKrYMA0C0EnSctX8agwbYpTWCDXaQqiE42kKOF66S3Eq5OawVOI7LKr2TIN2s0dD8bDsMUwNl5xWRTZlR6Xw84EOa6zUmQEUocjSiNrVtzYy+YmkzajuOjHMAkWKSFoPRCXzOUKBJkrbKsOzYFVbjlL9ZXhi1HWKqDSgNzED/3ScDKpzDe6+uXCziaIea4BEackBqi2ApnLtLx/S/ZpPxUdF4uVBiuVjxEpQiBuUewV0RULmklOEA+iYUUe6ZB43h3ahcFV9m6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(54906003)(83380400001)(66446008)(64756008)(66556008)(66476007)(66946007)(71200400001)(478600001)(316002)(76116006)(91956017)(33656002)(86362001)(5660300002)(8676002)(8936002)(2616005)(44832011)(6506007)(6512007)(53546011)(4326008)(36756003)(2906002)(6916009)(26005)(6486002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CLwcYPs29FdqItbA+MZeTdGfOiPcaA8m21iiMxH3EUuoqi2lm3cADhz5vXj3?=
 =?us-ascii?Q?y0GMBx6MTL291Wi3G1QCM2lIsZSzUxOI4eKKOk/8xLDT+9i2Gy/XPkRxZfHo?=
 =?us-ascii?Q?V8WG3Q85mruRxFd4W/ihYhIC1z9dxtNnNL13Pf94ASV6Mj3z/RgoIdswjnAq?=
 =?us-ascii?Q?MKj97Enwa3mqgxfXSNimH1o1YpUJONwZslZPVcmZpXbguH8QuM2VY3wVjjxG?=
 =?us-ascii?Q?7BigkEHQeuEwEIQekCOBeR3gENvk8zwSx5NOiZUvwrRkrVerGFcsxGEN/Pkj?=
 =?us-ascii?Q?e+dVpSW1v2RQMVl1nJxgGgMldyjMAWRPhleS4wslBfcovwxj0MQFcNib+Zuj?=
 =?us-ascii?Q?ioxyjpKsCSeSkCTfa5Xq7YwVVKQZvpwYw/0PQnpCzfSzqQqv8pHrBxgS7my2?=
 =?us-ascii?Q?7V/7FdLbl4fcOoOVw4svsHaWw1tIFC/UtWsdEddt7P6+/4EtYA1REJVcWB4d?=
 =?us-ascii?Q?befNpeaKiluDh5YhVJOT1KCMult6kJr7o23/nAQDVtHgdKx9GTnerk6BzHL2?=
 =?us-ascii?Q?6WHB/WL4aoCVQK7ZjA8bpZB6iXHcudhloiiJuchWAWnnB+GwApyY6xOu4WAV?=
 =?us-ascii?Q?sXCn9YMOq4WvQKm9bcDSpT3hOraKihAz+WGJPk8KPvuRxUKKzUhaeZwvM1aO?=
 =?us-ascii?Q?vjIEw/u+DWIcvHUFvLnY99ewTUJu6vP+LBUuWBe1G1S9sSnSUuendafocOcp?=
 =?us-ascii?Q?YhFJu5+2EsR8QVx/3LjwU44jSW7rNkumPwrHpSd5+j4Ik1ZUvVq5Rxnk41q7?=
 =?us-ascii?Q?KONQV/T6EtcvlO4p8Ni1CAsxK27CPRgwdWWoUdMxxRz+sOeW0uYTMUsT9bZC?=
 =?us-ascii?Q?kb5lJomD519EWpsMldKGRpUUzaXheNWrKsPP6y+12bhnEwL2yGDJzJNCBL5W?=
 =?us-ascii?Q?tMfjAGeV+rxuodM8r5JnxFTtxaS8FAdw1ZCWPC6tPHDxC+yVa629Mu3ynMwz?=
 =?us-ascii?Q?8LPf70g7y5gBxMQn82Sq4EMKWB1fwyQLjoJ+k8e/68XqvsQFcPjI/LkEBCMQ?=
 =?us-ascii?Q?LhyDHTvaR46K0oCjGj0ZNG0smW32WaTAhp/A8U9KnfKF6RiGvX57k9rouhNk?=
 =?us-ascii?Q?zhUNoX2ER1HRiatOAQG1CkoXOb2Yhg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD55EF532A0B4C48B9B9BE102F34E390@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66319820-4b42-4182-f8ea-08d8c7ca4cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 22:31:35.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWLDJyntJTvNX5/7AkIrCLnDSeWkVtr/JBO6l6N6npqkPU8IcxDUhpAdh/4vvs8Ewl9IMmyS9P32AZPw5XOIxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2918
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020141
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 2, 2021, at 5:24 PM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> On Tue, 2021-02-02 at 22:21 +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 2, 2021, at 5:17 PM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> On Tue, 2021-02-02 at 14:49 -0500, Benjamin Coddington wrote:
>>>> On 2 Feb 2021, at 14:24, Dan Aloni wrote:
>>>>=20
>>>>> On Tue, Feb 02, 2021 at 01:52:10PM -0500, Anna Schumaker wrote:
>>>>>> You're welcome! I'll try to remember to CC him on future
>>>>>> versions
>>>>>> On Tue, Feb 2, 2021 at 1:51 PM Chuck Lever
>>>>>> <chuck.lever@oracle.com> wrote:
>>>>>>>=20
>>>>>>> I want to ensure Dan is aware of this work. Thanks for
>>>>>>> posting,
>>>>>>> Anna!
>>>>>=20
>>>>> Thanks Anna and Chuck. I'm accessing and monitoring the mailing
>>>>> list via
>>>>> NNTP and I'm also on #linux-nfs for chatting (da-x).
>>>>>=20
>>>>> I see srcaddr was already discussed, so the patches I'm
>>>>> planning to
>>>>> send
>>>>> next will be based on the latest version of your patchset and
>>>>> concern
>>>>> multipath.
>>>>>=20
>>>>> What I'm going for is the following:
>>>>>=20
>>>>> - Expose transports that are reachable from xprtmultipath. Each
>>>>> in
>>>>> its
>>>>>   own sub-directory, with an interface and status
>>>>> representation
>>>>> similar
>>>>>   to the top directory.
>>>>> - A way to add/remove transports.
>>>>> - Inspiration for coding this is various other things in the
>>>>> kernel
>>>>> that
>>>>>   use configfs, perhaps it can be used here too.
>>>>>=20
>>>>> Also, what do you think would be a straightforward way for a
>>>>> userspace
>>>>> program to find what sunrpc client id serves a mountpoint? If
>>>>> we
>>>>> add an
>>>>> ioctl for the mountdir AFAIK it would be the first one that the
>>>>> NFS
>>>>> client supports, so I wonder if there's a better interface that
>>>>> can
>>>>> work
>>>>> for that.
>>>>=20
>>>> I'm a fan of adding an ioctl interface for userspace, but I think
>>>> we'd
>>>> better avoid using NFS itself because it would be nice to someday
>>>> implement
>>>> an NFS "shutdown" for non-responsive servers, but sending any
>>>> ioctl
>>>> to the
>>>> mountpoint could revalidate it, and we'd hang on the GETATTR.
>>>>=20
>>>> Maybe we can figure out a way to expose the superblock via sysfs
>>>> for
>>>> each
>>>> mount.
>>>=20
>>> Right. There is potential functionality here that we do not need or
>>> even want to expose via the mount interface. Being able to cancel
>>> all
>>> the hung RPC calls in an RPC queue, for instance, is not something
>>> you
>>> want to do through fsopen() and friends.
>>=20
>> I thought we were talking only about an ioctl or fsopen cmd that
>> identifies the transports that are associated with an NFS mount.
>>=20
>> Ostensibly a read-only use of that API.
>>=20
>=20
> I'll let Anna chime in with the details of her use case, but my
> understanding has always been that this would be a read/write interface
> for changing the properties of those transports on the fly.

Agreed, but Dan's looking for a way to match up an NFS mount to the
/sys directories that Anna is adding to do those manipulations.

So, fsopen() or ioctl() would identify the transports, and then
Anna's API would enable an appropriately privileged user to
change the properties as you indicated. Two separate steps.

If the new API already provides a mechanism to determine which
transports to adjust, then we won't need an ioctl/fsopen at all.


--
Chuck Lever



