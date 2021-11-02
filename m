Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9676A44368B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKBTnw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 15:43:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1354 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhKBTnv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Nov 2021 15:43:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2J5DjP012154;
        Tue, 2 Nov 2021 19:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iH+lymlvl0pvXOM3jwn0+x+HfFwh3YzjD1qc8YCcluk=;
 b=sC1Bwil//pPUn3bvLkY57ILie5hVaTz6IXQrEFHFyyUYTV55QutlDIrsry//tXMS6uy+
 2cfSfRIcd7TMuaxuNUQelk7WuFHUnrrp93FneYcCwwyO06h9L8SUjYkwsJ26iT/kEewe
 yuT3tBc6ibbmsFe0wRrBUkxXRtkpSrAgp0s+naQ/kmsRFCn/LvzxpEJOQTG1ZlboS3G3
 elYXBAi3eIskFpquoLU1HIjq6Ug+qoBBWIK0sr387dzJ1dbpZU472BrpKXF6sBGCq+E6
 8N4DyQKwm0E8f/mhTNDWj6Q9MQ4I7yBsuV4OpoMDYp2ppMbl+gXJmhH9OxVQS4BurhzM 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c28gn9gr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 19:41:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2JUnBa027244;
        Tue, 2 Nov 2021 19:41:12 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3c27k5kf1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 19:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpu8INO4n6wfa4W+zZWg0VkyzVdBvW3wRb0kVRi8+OHxa6pJm8Qm0Lyo4DTLzUS368S4iNjzI632c1G0l6xNIdvawE3RcMoJLpsFSNJ1/Vblf8sBAgk72rz4Y2isl5h24Z8Asek/pKOBu6KLsEwoPCZMr4V53vTTcTP9/2+uPwTMXjbp2oXZKrEt/ekKitUqSOX4YPYH9B8VqgOHmVdYjgfqCFz0DogJovAoMP2EDx1rJXB5sFsnG2czmZ8XqtW83GAI5eo0pWP9RBPw+CaA64id16rOua26BUiy0W44OtHAH91jLtVs5+ZtpOORw8UKmU6JW8mRh20GRLC53IJAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH+lymlvl0pvXOM3jwn0+x+HfFwh3YzjD1qc8YCcluk=;
 b=W6Y+sOD/NAyGS+7Yk36QUfTVE84xudVXdKmWLX8MnKXV2ustb+i5j+PC9C3fgq3v9dxJuXgyYMACSmIK/rOLDw1AoUCwe5WFJgTZCR6ZFqlO7/64dlDXeiV2Ry1tH3JQvbGQ/eoQ4+T1n2p06KWLbSWg+WDcPC56oIo/YhF8RNDzOvVB6YQsWb0h5S8hUBLD6FbTRRk6F2fEaFGQDn/My+dmuowcHJ1C8CWeYIF86u3OdbRla+jTpZRI/UsGfAptzimsSaqcta6DLNiIJ3aZT+3fZBEUWb5kPVAaZCx4We1jJjGzsDW+77RaQPl8A4vbOkreKIKTM2XJ8DSHIqhgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH+lymlvl0pvXOM3jwn0+x+HfFwh3YzjD1qc8YCcluk=;
 b=uR3MkveRTa3IYMpGaf0pWxTl8GpkoRKZHzBEoPdCNSucrlngqb5wtWCW1z6EzkEquvjiHDsSvI20IqaYC64ncOjRX2PR6aegr5AqKjZu7sZ8FLh+qXuGAHYcHcLf13WK8bYEiBTqxuADtRxa080kWfD9mQyq1DiuKOBD+fAw1XE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 19:41:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 19:41:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Topic: [PATCH v4 5/7] NFS: Replace dprintk callsites in nfs_readpage(s)
Thread-Index: AQHXwtmVwCh+Z7HobUeFsQnT5z1kfKvwvB2AgAABWQA=
Date:   Tue, 2 Nov 2021 19:41:09 +0000
Message-ID: <A0A92DE7-78F5-4217-9C43-8AF7C0C8644A@oracle.com>
References: <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
 <163442177101.1585.8852378085253353318.stgit@morisot.1015granger.net>
 <CALF+zOm1gCuVOJ5bEf6_t=PvmTQ4KQPCYQsgLUenxMNhzUx_oQ@mail.gmail.com>
In-Reply-To: <CALF+zOm1gCuVOJ5bEf6_t=PvmTQ4KQPCYQsgLUenxMNhzUx_oQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5ffcce1-68a5-463b-6e19-08d99e38b846
x-ms-traffictypediagnostic: BYAPR10MB2966:
x-microsoft-antispam-prvs: <BYAPR10MB2966C216922782F77F18934A938B9@BYAPR10MB2966.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWWr94EutnAhE96QYRlJ8yYef+8mAJbOaU1mzAnYVhsxPODj9SF012hYoxD3PKpLJ4sV7KPbeBUcuc3AC/DB45i6iO79oJCML4TK06EWQzX4TQXC1YsUHy8LOCaWEbCZbFE5Fu1461P+INSjqvjId+2IFtsKC6w2t3GLq6HLuTyiIICdQw1cG4o/hylL5/Od+Yx7pJCQIZGFbWL1ZSfFF1MLdM8248tcuh2kCnC/+hSAYbfN8XqeVy4PHt2iX7I0pDPggZT2WvWzFd8rw86hiABJ1MmLXIDAQcEhGZ643FcdbTQToDnqXgaNrE3r2OIRnyAfvJEMBU/V1xLP8OaTJemn/7wsuK/aB4clm2FxwdNuAA98D0RLViwI4itP+yJMStKaxBnIl58abqHiwNyw7N5Do8VKidfl15vj1eK0iyx9n82Su6UShkC+FTgmjdkbF6KVuMK5E3Osb2Tc5OyUVSpR6MOZ/YdYouZRKmXB8C0RQ0xvOggMpkK8VEC+V7eo632gWAsYxExZQ3QPUti6puWn+GFhELztQgqt3nXmxAllSTkwe9bJKIf4sKx50R3zl7k6QjXhm9UQRrZnIh70jL6nEvtxk+I7CuhY12lFfIWf9A3mcOk3/Il/pDxlPDXkex3ykB1wRrrdYEzOu76Q/ia+NWuYdDm1KvhGy9nP6gv8fmpPgOwsoba4/EAxy3O51WA+77n7Gf8HLEPGjeA3HvXoefwo7zaeQR8BGEX63Kk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(38100700002)(83380400001)(6486002)(6506007)(71200400001)(186003)(8676002)(38070700005)(36756003)(26005)(6916009)(122000001)(508600001)(316002)(54906003)(53546011)(66476007)(66556008)(5660300002)(4326008)(33656002)(2906002)(2616005)(86362001)(6512007)(64756008)(66946007)(66446008)(76116006)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q20nVMkC+qtC3AXN0Am0x14dhKVA8ZA9jtgkNbHibWL8v1hvAp0rfEdEOaCp?=
 =?us-ascii?Q?qR11HhHe+UjrjQLCfBa2le6HCZfoN+SL2Wjj1+q1eJPRIXa08HXpVQ4Te3na?=
 =?us-ascii?Q?+gP9QNXGrjfbqW4gP3oPaZ/B4MvDz1dXVUbQVvxdD2pqqXODoLt2fu523K8H?=
 =?us-ascii?Q?X2D9sN1AWsUWx+GkaM/XVS3H+DLtQSCKpDXU7UcZgFhThhGY6ROY+RQ/bfJK?=
 =?us-ascii?Q?NzjYT7l9uQjlAg1g1TWfqhnf4ClnkujgyeBcBfpbAhK4iu0NgmE9FZUr2l+n?=
 =?us-ascii?Q?xji6j8HEHdyx1c+/hBuHCijZloZj1WFoX0kFRP11yml6MHupw/b34kIHe3R1?=
 =?us-ascii?Q?Xz10iK762Z+hjglk0SuDRHCbHtQGgYNKxX0JauTMWGJWELqkkYJBzmlPj9Mm?=
 =?us-ascii?Q?H4Mws/J6s3iLDCVMCQrnkUZD1uCoyChYYUB/0uJD/Wiz+gM1j6ePPQaKTkYD?=
 =?us-ascii?Q?KefS7+U6RQMm4XkJ0adlgVsRGw4GYAGcn/+nzIwKN6Km7z7BbYzWUf60bodj?=
 =?us-ascii?Q?b+TUefTD2VQEmoXq2Gkj3AFPPjbv+EldGJOj5GOJ+mKr649quyQSPbmqNkqR?=
 =?us-ascii?Q?T6LGb4eJZKGCm/HCD9w18+3/Kq0OV7TAEZtqYq8nP+Tm7eNtyeyeJpiAdjrz?=
 =?us-ascii?Q?D8PUupK5OxDsXvhGCmBt5o9jM+18kSfLQXaSDHtmJsOPASzVu4nMwzG0yhcX?=
 =?us-ascii?Q?sGvd1AdLtJe99/e2IjYx5lAjwrF+HMlw0pS4DbUSGo7YNp2DKn9xIlwgPg6w?=
 =?us-ascii?Q?RE1UrIS6TXxaTsTCq+X8EEJVXPOS6yHltv6T2OuVIVW4dXQhu/Efm8KrsWtW?=
 =?us-ascii?Q?McdzeMifD1ig8miv4ZfwnHlbFm9HHRRkgXZka5Tc3UnUMu008WCpDWN0kQYH?=
 =?us-ascii?Q?kjyM+IdQ1dzOReyIakwaDHptjhT17DhXRYK7CzKOQB6kzL6oq8j8I89WhBW3?=
 =?us-ascii?Q?Khp94C/Tv0XVL/dZZ+/yz1FhwNIQPeN6vpti8u/XQl42nevrHUagpOSqgd3Q?=
 =?us-ascii?Q?sPAR9fTMlw6NS/1xMToTgJnnwCXi/UnmpCx822ZgvDig/F/dpfUMtFw21huX?=
 =?us-ascii?Q?aRLVxwAmh3W4mV5agLhKHWyn7UBxmfk5yhkz98+RMuXtVjH2spoZm1lU1Cqc?=
 =?us-ascii?Q?CMLcXeRSxYdKGbtbr3iosvGBpWoqpqnRQKTwCjAdPJ9Gq514Sek6/qMvcRtY?=
 =?us-ascii?Q?GcQuw+2BVWgDupa63WLDKLqEA1YeO92vaUBLIntimoPYfjzN0tGi1nryHib0?=
 =?us-ascii?Q?HruBxcQ+x+HiJPuQLxlP5/k8caniKCEE0oixx1Ql06XAWx2TG//TY3jaJCKN?=
 =?us-ascii?Q?y34V1LyyJoeX4WpwYCW31/PdXvOC8pBXbXpVVeV94dyCc5dkVn90M1NSh84d?=
 =?us-ascii?Q?HtF60huGhl3xKNfd1Oi2wRPf9dC4sZYFY71D2hrplzIu0a7Sggew8J1sIYka?=
 =?us-ascii?Q?OYqLKrWe0kwhxM7uJmEBLSsVE+3x9dmCdEdPATlKiqZPp/WdhQWtt/1BCpqP?=
 =?us-ascii?Q?5kA0Y5SA2ccJx9NR5rHIyfsuLMn0kipC5FK4oLtTBSPehYlcPuWMiuiO26K0?=
 =?us-ascii?Q?ktoWhR1LRtzgwy1VwGMp7ztNaEsgEVLDKgmp1NBvRAhp7d967h0izcWWfeva?=
 =?us-ascii?Q?2BOWYo2Rg8arfJKao0VDkUc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8F2193787B3A6498EE92A8A8AC27A64@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ffcce1-68a5-463b-6e19-08d99e38b846
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 19:41:09.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWRakuXGCrDdj4CgjtQ3Vx0JFTcQa5jzH2QGptpdZVn7t9OUiELMD/l2/UZYB4axccGPkltUSphCg+meETFnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2966
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020104
X-Proofpoint-ORIG-GUID: xm6qJGm4iuV_1hmLcPMgZHznxdiI1Fki
X-Proofpoint-GUID: xm6qJGm4iuV_1hmLcPMgZHznxdiI1Fki
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 2, 2021, at 3:36 PM, David Wysochanski <dwysocha@redhat.com> wrote=
:
>=20
> On Sat, Oct 16, 2021 at 6:03 PM Chuck Lever <chuck.lever@oracle.com> wrot=
e:
>>=20
>> These new events report slightly different information for readpage
>> and readpages/readahead.
>>=20
>> For readpage:
>>             fsx-1387  [006]   380.761896: nfs_aop_readpage:    fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355910932437 offset=3D131072
>>             fsx-1387  [006]   380.761900: nfs_aop_readpage_done: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355910932437 offset=3D1310=
72 ret=3D0
>>=20
>> The index of a synchronous single-page read is reported.
>>=20
>> For readpages:
>>=20
>>             fsx-1387  [006]   380.760847: nfs_aop_readahead:   fileid=3D=
00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355909932456 nr_pages=3D3
>>             fsx-1387  [006]   380.760853: nfs_aop_readahead_done: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899355909932456 nr_pages=3D3 =
ret=3D0
>>=20
>=20
> Chuck,
>=20
> I was doing more debugging and thought about the readahead trace event.
> Are you set on "nr_pages" output here, or was that mainly due to the para=
meter?
> I think maybe it would be better to have byte fields, "offset" and
> "count" like the other IO tracepoints (trace_nfs_initiate_read() for
> example). Or do you see some advantages to using nr_pages?
>=20
> We can get the offset with lru_to_page(pages) and of course "count"
> with nr_pages*PAGE_SIZE

IMO offset is interesting to include, but I don't think multiplying
by PAGE_SIZE adds much value. If you disagree, you can always tuck
that into the tracepoint's TP_fast_assign section.


>> The count of pages requested is reported. nfs_readpages does not
>> wait for the READ requests to complete.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfs/nfstrace.h |  146 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>> fs/nfs/read.c     |   11 ++--
>> 2 files changed, 151 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
>> index e9be65b52bfe..898308780df8 100644
>> --- a/fs/nfs/nfstrace.h
>> +++ b/fs/nfs/nfstrace.h
>> @@ -862,6 +862,152 @@ TRACE_EVENT(nfs_sillyrename_unlink,
>>                )
>> );
>>=20
>> +TRACE_EVENT(nfs_aop_readpage,
>> +               TP_PROTO(
>> +                       const struct inode *inode,
>> +                       struct page *page
>> +               ),
>> +
>> +               TP_ARGS(inode, page),
>> +
>> +               TP_STRUCT__entry(
>> +                       __field(dev_t, dev)
>> +                       __field(u32, fhandle)
>> +                       __field(u64, fileid)
>> +                       __field(u64, version)
>> +                       __field(loff_t, offset)
>> +               ),
>> +
>> +               TP_fast_assign(
>> +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
>> +
>> +                       __entry->dev =3D inode->i_sb->s_dev;
>> +                       __entry->fileid =3D nfsi->fileid;
>> +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh)=
;
>> +                       __entry->version =3D inode_peek_iversion_raw(ino=
de);
>> +                       __entry->offset =3D page_index(page) << PAGE_SHI=
FT;
>> +               ),
>> +
>> +               TP_printk(
>> +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x versio=
n=3D%llu offset=3D%lld",
>> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
>> +                       (unsigned long long)__entry->fileid,
>> +                       __entry->fhandle, __entry->version,
>> +                       __entry->offset
>> +               )
>> +);
>> +
>> +TRACE_EVENT(nfs_aop_readpage_done,
>> +               TP_PROTO(
>> +                       const struct inode *inode,
>> +                       struct page *page,
>> +                       int ret
>> +               ),
>> +
>> +               TP_ARGS(inode, page, ret),
>> +
>> +               TP_STRUCT__entry(
>> +                       __field(dev_t, dev)
>> +                       __field(u32, fhandle)
>> +                       __field(int, ret)
>> +                       __field(u64, fileid)
>> +                       __field(u64, version)
>> +                       __field(loff_t, offset)
>> +               ),
>> +
>> +               TP_fast_assign(
>> +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
>> +
>> +                       __entry->dev =3D inode->i_sb->s_dev;
>> +                       __entry->fileid =3D nfsi->fileid;
>> +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh)=
;
>> +                       __entry->version =3D inode_peek_iversion_raw(ino=
de);
>> +                       __entry->offset =3D page_index(page) << PAGE_SHI=
FT;
>> +                       __entry->ret =3D ret;
>> +               ),
>> +
>> +               TP_printk(
>> +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x versio=
n=3D%llu offset=3D%lld ret=3D%d",
>> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
>> +                       (unsigned long long)__entry->fileid,
>> +                       __entry->fhandle, __entry->version,
>> +                       __entry->offset, __entry->ret
>> +               )
>> +);
>> +
>> +TRACE_EVENT(nfs_aop_readahead,
>> +               TP_PROTO(
>> +                       const struct inode *inode,
>> +                       unsigned int nr_pages
>> +               ),
>> +
>> +               TP_ARGS(inode, nr_pages),
>> +
>> +               TP_STRUCT__entry(
>> +                       __field(dev_t, dev)
>> +                       __field(u32, fhandle)
>> +                       __field(u64, fileid)
>> +                       __field(u64, version)
>> +                       __field(unsigned int, nr_pages)
>> +               ),
>> +
>> +               TP_fast_assign(
>> +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
>> +
>> +                       __entry->dev =3D inode->i_sb->s_dev;
>> +                       __entry->fileid =3D nfsi->fileid;
>> +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh)=
;
>> +                       __entry->version =3D inode_peek_iversion_raw(ino=
de);
>> +                       __entry->nr_pages =3D nr_pages;
>> +               ),
>> +
>> +               TP_printk(
>> +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x versio=
n=3D%llu nr_pages=3D%u",
>> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
>> +                       (unsigned long long)__entry->fileid,
>> +                       __entry->fhandle, __entry->version,
>> +                       __entry->nr_pages
>> +               )
>> +);
>> +
>> +TRACE_EVENT(nfs_aop_readahead_done,
>> +               TP_PROTO(
>> +                       const struct inode *inode,
>> +                       unsigned int nr_pages,
>> +                       int ret
>> +               ),
>> +
>> +               TP_ARGS(inode, nr_pages, ret),
>> +
>> +               TP_STRUCT__entry(
>> +                       __field(dev_t, dev)
>> +                       __field(u32, fhandle)
>> +                       __field(int, ret)
>> +                       __field(u64, fileid)
>> +                       __field(u64, version)
>> +                       __field(unsigned int, nr_pages)
>> +               ),
>> +
>> +               TP_fast_assign(
>> +                       const struct nfs_inode *nfsi =3D NFS_I(inode);
>> +
>> +                       __entry->dev =3D inode->i_sb->s_dev;
>> +                       __entry->fileid =3D nfsi->fileid;
>> +                       __entry->fhandle =3D nfs_fhandle_hash(&nfsi->fh)=
;
>> +                       __entry->version =3D inode_peek_iversion_raw(ino=
de);
>> +                       __entry->nr_pages =3D nr_pages;
>> +                       __entry->ret =3D ret;
>> +               ),
>> +
>> +               TP_printk(
>> +                       "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x versio=
n=3D%llu nr_pages=3D%u ret=3D%d",
>> +                       MAJOR(__entry->dev), MINOR(__entry->dev),
>> +                       (unsigned long long)__entry->fileid,
>> +                       __entry->fhandle, __entry->version,
>> +                       __entry->nr_pages, __entry->ret
>> +               )
>> +);
>> +
>> TRACE_EVENT(nfs_initiate_read,
>>                TP_PROTO(
>>                        const struct nfs_pgio_header *hdr
>> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
>> index 08d6cc57cbc3..c8273d4b12ad 100644
>> --- a/fs/nfs/read.c
>> +++ b/fs/nfs/read.c
>> @@ -337,8 +337,7 @@ int nfs_readpage(struct file *file, struct page *pag=
e)
>>        struct inode *inode =3D page_file_mapping(page)->host;
>>        int ret;
>>=20
>> -       dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
>> -               page, PAGE_SIZE, page_index(page));
>> +       trace_nfs_aop_readpage(inode, page);
>>        nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
>>=20
>>        /*
>> @@ -390,9 +389,11 @@ int nfs_readpage(struct file *file, struct page *pa=
ge)
>>        }
>> out:
>>        put_nfs_open_context(desc.ctx);
>> +       trace_nfs_aop_readpage_done(inode, page, ret);
>>        return ret;
>> out_unlock:
>>        unlock_page(page);
>> +       trace_nfs_aop_readpage_done(inode, page, ret);
>>        return ret;
>> }
>>=20
>> @@ -403,10 +404,7 @@ int nfs_readpages(struct file *file, struct address=
_space *mapping,
>>        struct inode *inode =3D mapping->host;
>>        int ret;
>>=20
>> -       dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
>> -                       inode->i_sb->s_id,
>> -                       (unsigned long long)NFS_FILEID(inode),
>> -                       nr_pages);
>> +       trace_nfs_aop_readahead(inode, nr_pages);
>>        nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
>>=20
>>        ret =3D -ESTALE;
>> @@ -439,6 +437,7 @@ int nfs_readpages(struct file *file, struct address_=
space *mapping,
>> read_complete:
>>        put_nfs_open_context(desc.ctx);
>> out:
>> +       trace_nfs_aop_readahead_done(inode, nr_pages, ret);
>>        return ret;
>> }

--
Chuck Lever



