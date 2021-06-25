Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA03B489A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jun 2021 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYSHl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Jun 2021 14:07:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31950 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhFYSHk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Jun 2021 14:07:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PI34Uq017533;
        Fri, 25 Jun 2021 18:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xhprCKxSh30zAsfVaRwsbTSbxH60sOHJLos9ku/gVS0=;
 b=gq3nvHz2V3PBHGvW3ufwyKwf6Km7GuZlhfkJYXemwkBM18cWYye6wKvjXWbAdxrYenmR
 pxWj9hFw3MraIzYVm+CytBEQlUm3p57pqHHlUyr0eFeLy8nes+eDyAnOn6/t/sg4Hldm
 +8DNg3013cWeghG53UJYqUj9dMaHIZQ+N53ySVIVSdEJnAm2KzEvMp1Uogut9ZmoxSQ/
 Ll+VhWOvqN59OKC0j7nBGnST+krH3rMYRw/Sf2HwOujHcNVQHE3oRFApwDXa7lGT4Mco
 00BSupq3yEWKics4BIdOnTo0m2eX4uH3GqyUkCGPC4UcqGkdzHYAlI1BGI9ZLTAGrpA5 uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2ahsw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 18:05:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PI1QXf012121;
        Fri, 25 Jun 2021 18:05:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3020.oracle.com with ESMTP id 39dbb1sw7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 18:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noUm7ZNBggEksYrFDx+Rzv5RCosm5w66wxJVtob6wYa5Z93mfAo2PtUAvZpvueis818upKSSIM0bzy3WiOUu9audSnFrgv4/9lj+deneJ9LDkdY/ULEU/AqnH1uKo42Zpf2nnm0K+tNZpNlfPB9Co8jDVTlPGnkQ7dX8ibCZRwnYungb4+5fmbqasSBGOUZYTYmYAR6Hwag2w5mVAjQVSEP6HK54pLStUxk8USPfVtHNEl8Bg0e2hqF9eU7sVthEmRNv7i+bnTSHedA7vqxDdPRuNnDnRwRz2orJ43Xi/hrzLuc1nJ15S9A8Go+JitxK8CocRwV6j/a5+/S5DZWM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhprCKxSh30zAsfVaRwsbTSbxH60sOHJLos9ku/gVS0=;
 b=c6omkUN5mJYCmugVe+tIOALMMvE2U+72kXdSEMtHL7MvCzoO4LahkEGLaGkBZu2o6LrBHQgz0FyaHA4xSbgs0Wha32okjM3lVEEaUKA3rK72joqkhkKN1N+k3oYJkKKeZfP5qdDf/mp9AQa7qi+7DFDIq+sQaTdUc2uLT3SrN9fOB9PWV/w7YJTy1UUbcUTRoxfchcFzBGlaAYpNaiJ2Gn0xQG8d3+vx374/G4boyDORCaKi58AnSFxIhRqd4hXaOCHUAyz1k2/sBbbJM2bWjPSsQlpb8fDZ8cBaRrRkKfIfb7xCTnzyb5nYXkpdrlNA8LdU8xOQJ9fJ5vzN2XF4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhprCKxSh30zAsfVaRwsbTSbxH60sOHJLos9ku/gVS0=;
 b=oKDon0VSBBQYZ/5FD1dMum6Y6pGEE+lCyyAAWgomaIUEXMaKW1N7t6DnY0bh72/Zt7Y0VqN3B/sCC4NoxAgvjQIDoV4d0bF4Jvs9ImR1XBT4czzr5ChjbACysODCUcjEHryqqeBfM9Nsd19fU5TCfsXOmmotFoBzP7XdoMLrTBk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 18:05:12 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 18:05:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Topic: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Index: AQHXadSUyWoIP0jByEW2b8M2eLEYFKsk6oUAgAAbGYA=
Date:   Fri, 25 Jun 2021 18:05:12 +0000
Message-ID: <FB070B1F-FF5C-43B5-AFC2-0DC6B9348AC6@oracle.com>
References: <162463396907.1820.8112792283525036426.stgit@klimt.1015granger.net>
 <b71c76c0fb21ebb35e1f91864bbb411a4c895370.camel@hammerspace.com>
In-Reply-To: <b71c76c0fb21ebb35e1f91864bbb411a4c895370.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee04c43c-aabf-4b20-9728-08d93803c726
x-ms-traffictypediagnostic: SJ0PR10MB4623:
x-microsoft-antispam-prvs: <SJ0PR10MB462376C3D43C960997F2BFFF93069@SJ0PR10MB4623.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W38UMB1M7oJ2NTwvYtjfGz23ekSI1X2WANNB316Fu31lPdEa1+dGtqlZtmSIJNR37PkBfCZqD9p8sdNgSNUm3OYiwMAXcProu7Ahk+1lye5nbVxDqKkvQ0BMOdPUK7h7GOdyCP1ZxtGDRNAUdBZJm2701EiLu34tr5hBpAViO6Hl1j3JPfx1f42y5fJS7CCTeOYJlTZ29OWTSNxpy/zhyg3yEDPXlUKRIz/LMmgiSpjPzcPop+/1FxA+XU6P/LSRa4X3RlsBYaScsfbG8VL6ZRn1jB6lDFBmZs6ocby4SZ9k1ocoB2r9zpnF5Ow+LKCY80o7w9Byp0+0KNctizPsOQJrac3Xx7bdmOkeM9d0YO2QD/KE/bi8MrFTKBY70lTUntvnzTBDY6qKakHwM3lbpeS7LIek7+T9gi1zXfISRg1Z+G0ObsJA/eFgbkoJSovf0A6yyxUQimWfCmdPiK+yJgOJOopAxytovoQZmfRgg1NY0MneKHy0gYDIaJfNnKGLqj07xwm+U1S+hf1twLwEt3A2JLwgVJvHFQ7dD81vnVzj9rzNf8QFvx9UF48UA9syXtuQoT2EHz41Dg0eQFP3kPGMIKnmn3kw23+Rf1U/st8X091fdywmFwMGf1pOiLwsf6QQmq2CQZAU0Hh3FGzzHC7uNOvRT3re6TZUHhOjpTc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(38100700002)(2906002)(83380400001)(2616005)(316002)(6916009)(478600001)(53546011)(26005)(4326008)(6506007)(54906003)(6512007)(8936002)(186003)(86362001)(33656002)(122000001)(64756008)(6486002)(76116006)(91956017)(36756003)(66946007)(5660300002)(66446008)(66556008)(8676002)(71200400001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/zGGECqLJODxdvRZK8HTjSZ6GjHGjMWi9wOz4VrVOEyDTgJcG7j2KLRAxq1K?=
 =?us-ascii?Q?fxi++dAMJBtrFlDRQFyo5nkaeyZL+mwztT716YOId1uwAVpJu5eGlfhP0B/D?=
 =?us-ascii?Q?VcRE3JF1zSqCew594IFbPFkC07GwVLjbRjDtG8HY3CkiWb24PjDA0TT5AOLk?=
 =?us-ascii?Q?2Yh3Ixz9+kIW0w8qpsyJ70562KAzjKAkp8ju4TNQ8c9JSGUkaqlebKli5bfj?=
 =?us-ascii?Q?UzDjb4fm9VFsn4KRyYBdngZlRo479kfrlxpEuT225xYPKJp5Q1t3UBW9q9wS?=
 =?us-ascii?Q?L0dDZNWEzqe8H0E1tsYDX1ZhQQROUU4rN4RNCOvqw4f4HcbAP1RWtwEiq6jl?=
 =?us-ascii?Q?JhM+4zcmJeSNIZCu1LByEXyZ+LxYcR8wnbmW1prL1J49moHCnChiva51EcLY?=
 =?us-ascii?Q?BQMkJjD/jUJNrzHY0OzTha4JoEBXlkanPKZig/L2fXSv02KqBjIscJoTDd2X?=
 =?us-ascii?Q?YuMiMGYwtOoUyFXVc68DsQzBuI1ogbjdk2i6IGu/oSfr/4umolYip9gI1/KV?=
 =?us-ascii?Q?2+hKvinz3wcQVkZoXoEPQtrhfvnnzulyKpZmknXe3IArHsG8zhoPTtVMPAvs?=
 =?us-ascii?Q?Zs+pavSGLhTKYVdi1F2EOuoKX5VxYmpdmU0x4sbZfqIi0VdLmc9B51xNjCzJ?=
 =?us-ascii?Q?VBr8KQ079b10QaKb5vYjbt3JetEOpA8/17nZx9EkZ8AIzgzLph5B/Ng0lOm4?=
 =?us-ascii?Q?BrEIZT1atvCxN9+h300hlzq99IFFbuVNuDlJmURC43W2pX1VdFQWO8QxPNgb?=
 =?us-ascii?Q?w2GoVgQcJ6jJFASG4zBdTORfW1+FqyoYwkZYs2R/5vKB2YClZqydXNa8Ntgd?=
 =?us-ascii?Q?Gm6kPmj2dQkT+xyQg1pf1dewM2vW/uR+Scu+yzJoBZwIc8Uv2rKwmfMbhJWu?=
 =?us-ascii?Q?LnlPCizyGYUcLRk6LxW6CCCl5yWb7u/oPXBLyM2zo6TU+EuZ42I05pa7TTMa?=
 =?us-ascii?Q?Zhyr7PBrvKHldNIwmLOSOswykdZe8RfU5RBamHou9r0RzqmNpfJbg4C8Fg9d?=
 =?us-ascii?Q?IaExpZGliXIeq7zBIwWr847NXV3E0uwhnEGMg5KGZ7k3IAox+IH2khvVEbyk?=
 =?us-ascii?Q?rjDkm0vqDDV0/j19CnI/maLaZ2Lmm3hsXOQ7A8ES3MFHs8UNaHL1U6vBOgpI?=
 =?us-ascii?Q?rMiom9b84u0Wfw/ZR6i9omTM9e4TofhJx7pWnwesOvwr4fJ74UVaIaSjDkFe?=
 =?us-ascii?Q?77+VCiLo5CJgMR3kqmBEVGkZvVo/kG9ArFsPxmXujEWU8wMRCKubGuBsR9U8?=
 =?us-ascii?Q?HoW/x5oxsi+dxepz7pQqcDnro0sNsD+6171ZH4cx+06HXxzNz8DbGdGHKVW9?=
 =?us-ascii?Q?WEbEB8leWSNzFJA+v2ZSgH6L?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D37CEB4C7F48A4687C49087ABF870CF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee04c43c-aabf-4b20-9728-08d93803c726
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 18:05:12.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUjECj7SQStkg15kyMxUHNQG7xaetJQFu0uIyYsF5j5GmciKjJb/vlAQzowh1Fbk9IX6t3t9eoF8J+vQWiIhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250109
X-Proofpoint-ORIG-GUID: 0J4bf0Eww7KocdQcK_-hZ1tTMF3IamcQ
X-Proofpoint-GUID: 0J4bf0Eww7KocdQcK_-hZ1tTMF3IamcQ
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 25, 2021, at 12:28 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Fri, 2021-06-25 at 11:12 -0400, Chuck Lever wrote:
>> The double copy of the string is a mistake, plus __assign_str()
>> uses strlen(), which is wrong to do on a string that isn't
>> guaranteed to be NUL-terminated.
>>=20
>> Fixes: 6019ce0742ca ("NFSD: Add a tracepoint to record directory
>> entry encoding")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/trace.h |    1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 27a93ebd1d80..89dccced526a 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -408,7 +408,6 @@ TRACE_EVENT(nfsd_dirent,
>>                 __entry->ino =3D ino;
>>                 __entry->len =3D namlen;
>>                 memcpy(__get_str(name), name, namlen);
>> -               __assign_str(name, name);
>>         ),
>>         TP_printk("fh_hash=3D0x%08x ino=3D%llu name=3D%.*s",
>>                 __entry->fh_hash, __entry->ino,
>>=20
>>=20
>=20
> Why not just store it as a NUL terminated string and save a few bytes
> by getting rid of the integer-sized storage of the length?

Stephen is adding some helpers to do that in the next merge
window. For now, I need to fix this oops, and this is the
fastest way to do that.


--
Chuck Lever



