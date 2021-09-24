Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7379A417789
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbhIXPcU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 11:32:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62850 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233132AbhIXPcT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 11:32:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OEghGN017791;
        Fri, 24 Sep 2021 15:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Y3k7TrFeC3ulRM0BbWpEUGsCOOMTNYjQTaR69xxv+ns=;
 b=IzeUjzIcUvtgyElWkniyOM3WaKbQ2Rrxd5zjE7oAJaDuQrY0mTsb0vBjbYnryAGdVSj+
 xoeQhsbOYk2YP2O6gEF6Y+ZIs6pkfSj8uSa9pu5N9G4eTn6NNIh1V6j0tk56Lsug4Wm3
 UgZdTDZ0Ab6QbidKuBQVDpwmtwhJoVpwcfen6lJwrysjkTKs51H9QxVr85S13Hyp5k0J
 Ek+4EnDmvq3sX8YugFrqE6Gd0yq6cFRbsIX2yQ2p+Y615zEYHa6gREB7OgBP2G3/H929
 BH8VvGQHaQatc3Xj0SBkO6ynIhdUnDpIcZS/udlEor7rvCDbxWPz5VNAHDO78fEPt7xB tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93eqm7nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 15:30:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18OFPjFl070006;
        Fri, 24 Sep 2021 15:30:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3b93g3ddy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 15:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy9CQzqqzMuPd8G08tOwTqMz2GydhOoM7yXHSDhNdr9hmZTBFp+CBbHOlhhwH8znjhv1Y9l/6JjvqZwrKjVX3N8ZW8461bfdwe6vorw2g6TLAR7rjRn6UUsqJJLkYiffsq6p5BWVX9QpHw8L9Qql4T+HeOQcYKcuiHRrixjEKwMdegzy6/HXeO3UvcLaRIGHHQN2gXOaD0hbMD8oD+vEAA4KeQNeGb8lNxm/M5/IBEs0nKEPzpI9cACFLLyyk9akEXPtS2V5kWDhMirQ0lCbPD4Y7f5bt5CqRdbhT9P9lf/56FmMdvqNU/ocmqVonYWOcHrksDVrSchHlre3SThQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Y3k7TrFeC3ulRM0BbWpEUGsCOOMTNYjQTaR69xxv+ns=;
 b=gMVgaQGryqBdcDMH/pSnijydx1waSeT+PFncM//32bN5UihSuTGZrPZO3WZnvdnGDVAP3BswlSB/yM5vF02TeocAzVAAY3XDqRenH3oQhinUXsdFQFJ3r51/Sris2TE0XGnRfwP6TYlK57pYluPJT9MC3dff5YVUjI2rr9a3h61+4PY36Xok/4bXYOBCHUPWnbZ1N3G73qWMXH1bytFbokm5Yc4f9fyIWEzKBjt8daOqGCbYBZzT/EWde/Do+1RGxkU7h25UXe/Q0HFG5EAg+wBUUac4VqlyIkx17Sgsdv14BqoxrxBWU/DHon28UWprgLWNjeQk1v6SO41cFzSXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3k7TrFeC3ulRM0BbWpEUGsCOOMTNYjQTaR69xxv+ns=;
 b=qYF/CvHy8Yfu8axVqMVXtCeW5ay5rcV3HAiBZ27QWv297YYjyqDcQVJ0hLN+a9apClxyNzxOXC7k8ut1NarGYR26o44gxCpNa5za7K6cWzQ+nSyAXofgfV8uvWygTWOavEMnZBzq1W+mTnUHUNjIm3/eOHDqktKKtgbswheD02U=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4608.namprd10.prod.outlook.com (2603:10b6:a03:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 15:30:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 15:30:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fslPfHYBEJkGXNGWvoY4o9atRAYKAgFtTqACAAuCvgIAEfGYA
Date:   Fri, 24 Sep 2021 15:30:37 +0000
Message-ID: <EA26A03F-962E-4561-9A70-C97D19574993@oracle.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
 <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
 <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
 <da6ef7efef96f126f89a70446eaf643ab0bcbe26.camel@hammerspace.com>
In-Reply-To: <da6ef7efef96f126f89a70446eaf643ab0bcbe26.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 364a11ab-767c-4aad-e6b0-08d97f704295
x-ms-traffictypediagnostic: SJ0PR10MB4608:
x-microsoft-antispam-prvs: <SJ0PR10MB4608181F7731A3830A7A19C893A49@SJ0PR10MB4608.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tefGjDrFseatAxRbXi2VYsSWrLlZCpKHfhR6vzow+0/gKVN3WJ+5Ri1ugJMQj6+T6B14G3ITn6rp/8UbqZcBMws0IbVED08BUGDGhnD30fsfYuKiS5UZHavQWI7fCoIrwKjaH+Z/srVbfgfH7PwC+GcZfCqhLRmCIKmnsK2kZNAsmUtZ1N8/ZSA0E7lrS6ULlPw8E3ROi+fqfMY/clWkHh2mo9E4KxZwFuH3nZFeH3mWA1ZByKuKjEQ45IC3wsHH6xu4YNd09q/w/DiavEtbzhskUtrNt/FIIHw4CIZo+B1b7LfBbUovDd+EmPS5aVn4lLVHfERlm8gXqTPFs9X+c5E3xY5s3BvsN1Em7WWf0hnmrFTO5Cz43GBgSs/xPpuqZhMzpkPLEEqkrEVHn3pGAAt9K/E5RWiRfDviCYeIUnu7RTGuzA2YNLzMRouC0gqennt6WTrFId6xyg396Z/tzlLxY9kJ2DVUl69ZdpjUG9ZmJednVVwLbU5AF0bO9LlyqQ+rLAm014RE7GuFu9iJZz+0GIZ4rUohv1Mx/1vMAMhCiu9MRw3ArutgKk+f3OocJ2nG7BKQb2IbNNsgZ9112UYQ0s2ooTmMJMllZ27kPPfRc7PJNP5M29Xx8cHkxab3c9bvxd/c+wQ1DjwlpkIDIg6RxCM4oqI2N8sZpq2L7LVEd7NOOmQGecVKV2/PZcvbwEc/F4x/MFa6tszmyl+9NQ0nHC6aa1CsciEDRdhs7LMnoIrkW8dCXLFuXd+OGk0G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(86362001)(91956017)(66946007)(66446008)(66476007)(122000001)(83380400001)(6512007)(8676002)(8936002)(6916009)(66556008)(4326008)(38100700002)(26005)(3480700007)(316002)(36756003)(64756008)(2906002)(71200400001)(6486002)(6506007)(53546011)(38070700005)(508600001)(2616005)(5660300002)(33656002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2qoHVTmHJ3spFv+417eQ6nKozWk+HvsZfsOTb+COTGy+nbehLiPKbDNkhQlL?=
 =?us-ascii?Q?E6P6BS+nnOpJ/x4mPDrvDZLki+oFoBk4P9oBkp2/ThtRR1DSfkTiDUhvukxF?=
 =?us-ascii?Q?jKCSk2BQ1F9eOQvbId3j+5OyKZut1S/QTCw4FP/Ny9FD9QGwqPkfdx+CvQyJ?=
 =?us-ascii?Q?dIx1atrjY+vcD1d2CdFXFyWCfh1MjNp3e29y3aWR62qh8LIqGK2q6Dv6Qfpr?=
 =?us-ascii?Q?nAME4rkJmdzPyER21PdPcRaQ3vCmBUdPefinuNN45R4UTKZ6k6IjQx/DQMCy?=
 =?us-ascii?Q?kUUana3MkoS99+F0i3cpwtUCFs3UKBGPmtbQfwz0MTFq/xB4n3yvMlIqYsaA?=
 =?us-ascii?Q?8J1D6lHHfCXVEB5Hsj+9Hrb4h77vUhWo3FnzplnU5PiFH4TYHflMvJf5b/nw?=
 =?us-ascii?Q?q1WRLJ6iQVbSRoDz5wlXb8Go2v7T4OQhqM2MH7IhzR4HoII6LhlqiX7m2193?=
 =?us-ascii?Q?BDkjL+MxxaA6LlB5hhHZBSX1wxa9UjlJlBmQseNgFTjG/m7eI/0fuPr1WFyb?=
 =?us-ascii?Q?TyXf6+7Y5ttzo4UUdBg5isZV2o7FXLgV+/TzOjZyzoVEVYCqpHfZNWsGz5nc?=
 =?us-ascii?Q?lg4KZEAjOhWIY/KKeB4QzMB7u5+Jum3Kx4FnifSnaVizDr4iQJadU372psfg?=
 =?us-ascii?Q?QsY+g2TVFu9O7shukx62WCFSavbgzwDEdHOzpgFyA/Jo6rJQMNUsu7Cprgmc?=
 =?us-ascii?Q?ycIfIyBiW/zjEnO8N5eei1hZsPMeFqdpv+uvmGCPu2yRakHVSfqvg8jh/WvI?=
 =?us-ascii?Q?NiPAUxleICVZfFgkkr7+oH4kBQoJSEEGxZLfN9NX7HoNQGjKVfmkAC8rBou+?=
 =?us-ascii?Q?eIgGegbnmZ8llDFnO114CkxMvIem/On4JdoO919rODKwlTdMYUq5cZiwfIyM?=
 =?us-ascii?Q?MAj5uuJnPke91FGbId2+4RZk/P1ij4PY/Dq6L6hLVi2BrVCuD4LeWIYLDKpQ?=
 =?us-ascii?Q?Tte/yxv5M3Qpsop4qc5EAKDrukyydk/beM7YjA9kIW3Zt9D0q7uhxvtyF1Ul?=
 =?us-ascii?Q?751ZSiJ0rpk20t5gTx4RAd6wyDtXUp79Tk3i/jLvvyoT+20QsR59wJdNd9U7?=
 =?us-ascii?Q?vCVTqRZH3PZCTWGjwkWK/V+tQfWXzohLN99c9DDHVvmKRxL51W8T8PMA6YFq?=
 =?us-ascii?Q?ImCdnT2UOJzQ+nTOI00mxyapq87pR452FoY5IOL8a03woeZDHgkdmGj1ApzM?=
 =?us-ascii?Q?LzcHeLvC6zamIHG+MbcurzmcLjKIndfMUk62cU5sOIk+3wky06fYgYtdyOzS?=
 =?us-ascii?Q?DMIFt7vr1srmbb07XQSeMfgmtZm6Ua+lLliN287Ws/jqQunbV6ckEJCJNx1u?=
 =?us-ascii?Q?KVs+oY6urkcsU0W48CWgj7Nz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <496BDBA8C131FF4E985D829A83C61345@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364a11ab-767c-4aad-e6b0-08d97f704295
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 15:30:37.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frwhh9N0IgDcHAE3tYcliR0x/ytLuI8x9ZOrDkr/2iCVzJlr7L7JCOsYhXke2O0lewtz9Ei/NqVPS1qvEZq7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4608
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240100
X-Proofpoint-ORIG-GUID: v0CPkrSRHaNogwXrLEtxtoMesbeFcYSK
X-Proofpoint-GUID: v0CPkrSRHaNogwXrLEtxtoMesbeFcYSK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 21, 2021, at 3:00 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sun, 2021-09-19 at 23:03 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jul 23, 2021, at 4:24 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Fri, 2021-07-23 at 20:12 +0000, Chuck Lever III wrote:
>>>> Hi-
>>>>=20
>>>> I noticed recently that generic/075, generic/112, and generic/127
>>>> were
>>>> failing intermittently on NFSv3 mounts. All three of these tests
>>>> are
>>>> based on fsx.
>>>>=20
>>>> "git bisect" landed on this commit:
>>>>=20
>>>> 7b24dacf0840 ("NFS: Another inode revalidation improvement")
>>>>=20
>>>> After reverting 7b24dacf0840 on v5.14-rc1, I can no longer
>>>> reproduce
>>>> the test failures.
>>>>=20
>>>>=20
>>>=20
>>> So you are seeing file metadata updates that end up not changing
>>> the
>>> ctime?
>>=20
>> As far as I can tell, a WRITE and two SETATTRs are happening in
>> sequence to the same file during the same jiffy. The WRITE does
>> not report pre/post attributes, but the SETATTRs do. The reported
>> pre- and post- mtime and ctime are all the same value for both
>> SETATTRs, I believe due to timestamp_truncate().
>>=20
>> My theory is that persistent-storage-backed filesystems seem to
>> go slow enough that it doesn't become a significant problem. But
>> with tmpfs, this can happen often enough that the client gets
>> confused. And I can make the problem unreproducable if I enable
>> enough debugging paraphernalia on the server to slow it down.
>>=20
>> I'm not exactly sure how the client becomes confused by this
>> behavior, but fsx reports a stale size value, or it can hit a
>> bus error. I'm seeing at least four of the fsx-based xfs tests
>> fail intermittently.
>>=20
>=20
> The client no longer relies on post-op attributes in order to update
> the metadata after a successful SETATTR. If you look at
> nfs_setattr_update_inode() you'll see that it picks the values that
> were set directly from the iattr argument.
>=20
> The post-op attributes are only used to determine the implicit
> timestamp updates, and to detect any other updates that may have
> happened.

I've been able to directly and repeatedly observe the size attribute
reverting to a previous value.

The issue stems from the MM driving a background readahead operation
at the same time the application truncates or extends the file. The
READ starts before the size-mutating operation and completes after
it.

If the server happens to have done the READ before the size-mutating
operation, the READ result contains the previous size value. When
the READ completes, the client overwrites the more recent size
value with the stale one.

I'm not yet sure how this relates to

7b24dacf0840 ("NFS: Another inode revalidation improvement")

and maybe it doesn't. "git bisect" with an unreliable reproducer
generates notoriously noisy data.=20


--
Chuck Lever



