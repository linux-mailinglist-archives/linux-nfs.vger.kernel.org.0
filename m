Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E241838D
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Sep 2021 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhIYR2d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Sep 2021 13:28:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65502 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229511AbhIYR2c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Sep 2021 13:28:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18PC7DMd030040;
        Sat, 25 Sep 2021 17:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PapgQivNzjg/Lc9k0HUegCBy8V546RS+58/mKr9CGcY=;
 b=kilcLBK4APnlGgm64vn7RsQt/8nVDQZjFQmIIMxl9RRSVLBFqz38Gmxi8HQ5btAkskyB
 qAprarScEU9VqRX+fRfTuLQfvmRsqevdQyFRTFf+jEa3bujJtZy4KYQ2IWL8325UA4pK
 90uQd3lmnjmCnj2Wvu2netifFK3l7mjHkoBqZmxMqi05pqpYCyjaSwLhJGDhJKWgQXSD
 QKIqBNl4IiHFoWhXDklK0Wh+xCuPvPDYGvW1R3EGOPAdjAlc/knfzC+4dKKfS72pWQWW
 o2QAi/tEyUWWQIPJlaLmbfV7dYLKpO9AjXpeSes6vRqFdBw4q125lLWu+5A+awnNO7tN Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b9t6chdjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Sep 2021 17:26:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18PHKCLn191343;
        Sat, 25 Sep 2021 17:26:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3b9u3jp4bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Sep 2021 17:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnW9YoKuioxOzrbf8BptRBmhtkxDKkX9ecwL/o4YnFYyGme79deI9pdvH9cpe6m01em+5qXd8Ud03Y9mVyAHJC2aeaDLMiM5BfRyfZUKkUTDBwEVC1M3V1xuYVI9k91+UNIHrTEl78rSBRl2HxXYbEIfFV+E1m0dz0r25YSaBxUvH0UnmQNh7Ruhxppg3FPTFgSJYRj/96Ez/HxHTfuavgiGZPzWS4ljKD6KhJbJCxMKPBWvQwCW4e+jwmrk14nW5tJIAGIEooHUvjoxMI6W2/3rRRH42UFhC8ct419zalBuxj905D7T0/2/0H6AzoT0shZl4l2sJ4U3uUUOIkQ+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PapgQivNzjg/Lc9k0HUegCBy8V546RS+58/mKr9CGcY=;
 b=CmkJnUDGYHPXJSzgrbLsdaUxScREe+By8AZ18OUieF1VA7Yt6nj+3npgInp+SqxqnPnPEXO/fnmNl2Zxu9YFprx+Er2F7P81DhGVL+mZQPFdlpZDU1/+rHYowF73Exm44JzKPCVyRM6M2EM3S+g6BL4hDhyUYtKDMNDUz3Ks++F0J8jhk6z2q5horHMEshJcg9DcQXfjvtrByCANWivyCkLreCTZyU2JIf8Q6FuD/0wwyeYfaN6ybmt1H1BjNE4SxNDrui1SE7F3mCzfbrBcu1uWvTF5Jy1YxKC4qBoJutnCN1ftGECEmScrEBguXgzz5WeNphJZBovIWiTZxOIW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PapgQivNzjg/Lc9k0HUegCBy8V546RS+58/mKr9CGcY=;
 b=tdejA9qR/CK7h9Q3mh3LOknpRhS+nLq8+Z3jYfsyKDM+S8ORCkLv1xeuLqCu9TsYkHxfcM0BJgRfJaRuScI/O5fYr6WT3w5PuB2jxJKAF7K7M/q7UoZa617ObhCIuUlBxwHJ5xDduTKyT2VSGvMz62GEiV8WgL4Hf3PT4QVQcfE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2920.namprd10.prod.outlook.com (2603:10b6:a03:8f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sat, 25 Sep
 2021 17:26:52 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4544.020; Sat, 25 Sep 2021
 17:26:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fslPfHYBEJkGXNGWvoY4o9atRAYKAgFtTqACAAuCvgIAEfGYAgABvhACAAUNMgA==
Date:   Sat, 25 Sep 2021 17:26:52 +0000
Message-ID: <DF5259C4-56A1-4AEA-A06E-EAE235AFC04F@oracle.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
 <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
 <680A4FB2-B90D-47E1-A390-36B3081B1464@oracle.com>
 <da6ef7efef96f126f89a70446eaf643ab0bcbe26.camel@hammerspace.com>
 <EA26A03F-962E-4561-9A70-C97D19574993@oracle.com>
 <aa2ef2bbb991d693009fb5cf130462a366f5d459.camel@hammerspace.com>
In-Reply-To: <aa2ef2bbb991d693009fb5cf130462a366f5d459.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14e98ffd-ad9e-409a-ef4a-08d98049a9e9
x-ms-traffictypediagnostic: BYAPR10MB2920:
x-microsoft-antispam-prvs: <BYAPR10MB2920FD8A85B39603D97FFED193A59@BYAPR10MB2920.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EDrnmzaE6cYIf8+ICycEGJv13VknT87fUjeHaZLNNqHP4youQY+ZCr8lUAleKdXZm/qRU6chAPrnSiVFSPxUxpzI9xzlvloPGihHJzItHXBSfpwwNImbUc5km13NeU/NAOcfnZSwLeM2GESp8bOfjoFjv0BZqf3g3XmOLe0moJNwOyGhWAmLW4h4OPZrTSPungqE5aTDDmlz9KK/dWJ3iFG04UtDFlwc+7xwbX6ycnrHWbQMCUZUdi240dR7vlSK6E9euuH+73Kcs1M3qNNpvsC15onJ0ga0CBBSkfSMJ9msmRhbQDkIWAPFkdpuRKZMeTzKCkfmx+ZtJ9zaqEcGCWSWjaTxJCoMlYfWoZeRvai4hGplITsS8uk810uJGNRBAmD8EQx4IxxEnOL5+Rm9Hd5veQNfboZUbAxxIa9sojryhCm3RgNkSC6BCp/ZpmpTK+fkke4zLjYOBnU0gyg/qaWF+7Q0SU3cEscfC1w0MQNiFkAIWRQiU5abKZJaK3izKfWjSlOqXK0/7YG+QU92vAQcHXw7ciH2WZ9Bp8Md3iPwgNpsGeAL6HxzrnxvPmVH0X+M72sOGvKHMBeXNI1jvOE/arenBG99L9lekVNoDf6dFRiDGblkJG1Yb903AVlzIWLxbxFqmKWABuktqCWjb0JIPzmsiddZM5Pck4XvgeCMoR12cJDZzysXKocHBo4HTI3Mb8vhXmfTeHF3uLayL5kZicqlqcFkTQ8bHpyNrOdDZ0OsyMCg6g6nElUcmVhm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(91956017)(6486002)(36756003)(66446008)(8676002)(5660300002)(4326008)(316002)(38100700002)(76116006)(71200400001)(8936002)(6506007)(66946007)(186003)(86362001)(3480700007)(122000001)(38070700005)(508600001)(66556008)(6512007)(2906002)(26005)(6916009)(83380400001)(2616005)(33656002)(64756008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ywz41pm9c17Pq5dlt+MGx/l7yqtJMsruGTaA/KyiiXTSRl5lyY2zj+VLfk9?=
 =?us-ascii?Q?psnA+OanrHs92PCqiy6wAeCiXoAh7nzlCgp/UoN2HLbACtP/ahDuVMCn6Jes?=
 =?us-ascii?Q?/hJoo5WbhFp7ZPcIxANbEvc+r668l2Ml33eWeX0Qrf9q9QOj9Ni7cYW5geNO?=
 =?us-ascii?Q?BDgWdAntFWBQP8wds+jVpk/sdnDuoeoOMugPYQQN/+IVYaDjYfc5XydjtENJ?=
 =?us-ascii?Q?VzVLBEziyyecunzJoVm++Dey6Tf0l/4JAh3XVT0Xidlc21020ZCQrGK8jSEC?=
 =?us-ascii?Q?0xQNrM53ddFG4QibrTt/3qCSK67Cl+hfvV91qnVl6YeT4F3b866uyKnGiUjd?=
 =?us-ascii?Q?uj0FeIwItwRqg+5cxXIgSkl63SzTYBstgddzLke1EEoFDg7VA0aUO06SPwRm?=
 =?us-ascii?Q?AMBpvwU2upGgqgDJaXyJxLY0yEUbH0oDcCkzMFv4wqZVyNdkv7tYVWFxW7zR?=
 =?us-ascii?Q?Ltxgpt4b1QfcpUg06xqiXEFdt7jJQTEyZT87gYNcD0BkfzurwI7nO7eti+NO?=
 =?us-ascii?Q?3AzeG3Cx7uC2VxwPOZzO3lS5tFwJHa4WF1tVkbezORMdcLzsoPYyJ6zd+5oA?=
 =?us-ascii?Q?RGLK7YUfjsAknhBQFBfdzH76XUuXgoaKYqnU4dTD0soLImYeyZlO9AZ0NIe0?=
 =?us-ascii?Q?W7ZI8/D8LLOcKbDr8LCa4B5e3Gt/hCs7rhzW1fau045PVduWX87IgEastNWD?=
 =?us-ascii?Q?4fWxxKFmspa44WCtXrC9FOPgLAbQXWVoBslqVuvEK87Rd8b9TO5ofBfvAhIu?=
 =?us-ascii?Q?ZQlwruTVlRJaSeIm3x9vXbV8ufunoNrn68etKdL77KzA3ybyfI/EKYJJcRvP?=
 =?us-ascii?Q?3gqSNb5hjIH+HxhluZTb1OzB6kAGwx3Udw++W3/CZML6Y48WEiRC9eOyXYwW?=
 =?us-ascii?Q?IjA8lny4rDxcCNiSEAY9pTE5sqrfLhleSRsINP3u9K2IHtTDJ1gAxsmOt7VM?=
 =?us-ascii?Q?3TNcKQcvdeQdZtV+YEWk6IIJbR1zMM9EY0+sbyMOdhHVY9bZkxW6tU4qI8v4?=
 =?us-ascii?Q?fV0VaK3WpYKdBiAkRtfMNZCBCQJ5LmYQfXinxl702YyFlOOFtKLKmVpHprSQ?=
 =?us-ascii?Q?EAATqzgGJAW6J7b82y73qh3LSLE+UhoWkYz6If02AmoU+kKJ4ZBLcc92CwBv?=
 =?us-ascii?Q?JzdXDVddwWU8jXpv+EJdb64dSHkmcgQNQ6p9zcQTMAfgGMp7Gu6MpxN/9xLQ?=
 =?us-ascii?Q?sAuiWo59zXZr1MYHkLvdqaUhby7hinTzgQUOcoWBRyflE0G2cQDa8pWd6+cJ?=
 =?us-ascii?Q?E+J1edN59kfl8yDVfHL/wFDuoqDCdy6PwJUFQTYSu/4bzu1jWJWVvGyQ3i1J?=
 =?us-ascii?Q?FHG1/g0w29rQm8TBDt5t5/UH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E1D64722E77AF4886E89106B479BFA6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e98ffd-ad9e-409a-ef4a-08d98049a9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2021 17:26:52.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJb7PF37uaeXZNt3UD6o7VgaBgSJcka7M9ldiUeb86WWbU5h+Pm9uJ+iBqLXPF2gWd4gbpQv+9qxFexst/c6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10118 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109250131
X-Proofpoint-ORIG-GUID: aR1VBFtzEAAwcw90ndWcWMpsoiByGyN2
X-Proofpoint-GUID: aR1VBFtzEAAwcw90ndWcWMpsoiByGyN2
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Sep 24, 2021, at 6:09 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2021-09-24 at 15:30 +0000, Chuck Lever III wrote:
>>=20
>>> On Sep 21, 2021, at 3:00 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Sun, 2021-09-19 at 23:03 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Jul 23, 2021, at 4:24 PM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Fri, 2021-07-23 at 20:12 +0000, Chuck Lever III wrote:
>>>>>> Hi-
>>>>>>=20
>>>>>> I noticed recently that generic/075, generic/112, and
>>>>>> generic/127
>>>>>> were
>>>>>> failing intermittently on NFSv3 mounts. All three of these
>>>>>> tests
>>>>>> are
>>>>>> based on fsx.
>>>>>>=20
>>>>>> "git bisect" landed on this commit:
>>>>>>=20
>>>>>> 7b24dacf0840 ("NFS: Another inode revalidation improvement")
>>>>>>=20
>>>>>> After reverting 7b24dacf0840 on v5.14-rc1, I can no longer
>>>>>> reproduce
>>>>>> the test failures.
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> So you are seeing file metadata updates that end up not
>>>>> changing
>>>>> the
>>>>> ctime?
>>>>=20
>>>> As far as I can tell, a WRITE and two SETATTRs are happening in
>>>> sequence to the same file during the same jiffy. The WRITE does
>>>> not report pre/post attributes, but the SETATTRs do. The reported
>>>> pre- and post- mtime and ctime are all the same value for both
>>>> SETATTRs, I believe due to timestamp_truncate().
>>>>=20
>>>> My theory is that persistent-storage-backed filesystems seem to
>>>> go slow enough that it doesn't become a significant problem. But
>>>> with tmpfs, this can happen often enough that the client gets
>>>> confused. And I can make the problem unreproducable if I enable
>>>> enough debugging paraphernalia on the server to slow it down.
>>>>=20
>>>> I'm not exactly sure how the client becomes confused by this
>>>> behavior, but fsx reports a stale size value, or it can hit a
>>>> bus error. I'm seeing at least four of the fsx-based xfs tests
>>>> fail intermittently.
>>>>=20
>>>=20
>>> The client no longer relies on post-op attributes in order to
>>> update
>>> the metadata after a successful SETATTR. If you look at
>>> nfs_setattr_update_inode() you'll see that it picks the values that
>>> were set directly from the iattr argument.
>>>=20
>>> The post-op attributes are only used to determine the implicit
>>> timestamp updates, and to detect any other updates that may have
>>> happened.
>>=20
>> I've been able to directly and repeatedly observe the size attribute
>> reverting to a previous value.
>>=20
>> The issue stems from the MM driving a background readahead operation
>> at the same time the application truncates or extends the file. The
>> READ starts before the size-mutating operation and completes after
>> it.
>>=20
>> If the server happens to have done the READ before the size-mutating
>> operation, the READ result contains the previous size value. When
>> the READ completes, the client overwrites the more recent size
>> value with the stale one.
>>=20
>> I'm not yet sure how this relates to
>>=20
>> 7b24dacf0840 ("NFS: Another inode revalidation improvement")
>>=20
>> and maybe it doesn't. "git bisect" with an unreliable reproducer
>> generates notoriously noisy data.=20
>=20
> Hmm... That makes sense. If so, the issue is the attributes from the
> READ end up tricking nfs_inode_finish_partial_attr_update() into OKing
> the update because the ctime ends up looking the same, and so the
> client tries to opportunistically revalidate the cache that was (for
> some reason) already marked as being invalid.

That agrees with the behavior I'm able to observe.

I sprinkled in extra tracing to get more visibility on what's
happening. The XDR decoders report the file's size as returned
by the server. I also added events in readpages to note when
a readahead starts. Finally, a few new tracepoints show the
cache and fattr validity flags used to make cache update
decisions.

An excerpt with annotations follows. Throughout this part of
the trace, the iversion remains at 1752899367783879642.


# The MM starts the readahead operation here

             fsx-1387  [006]   391.823097: nfs_aops_readpages:   fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 nr_pages=3D7
             fsx-1387  [006]   391.823102: nfs_initiate_read:    fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 offset=3D114688 count=3D28672

# This is a concurrent truncating SETATTR

             fsx-1387  [006]   391.823109: nfs_setattr_enter:    fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642=20
             fsx-1387  [006]   391.823109: nfs_writeback_inode_enter: filei=
d=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642=20
             fsx-1387  [006]   391.823109: nfs_writeback_inode_exit: error=
=3D0 (OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D17=
52899367783879642 size=3D151896 cache_validity=3D0x2000 (DATA_INVAL_DEFER) =
nfs_flags=3D0x4 (ACL_LRU_SET)

# This is the new size value carried by the SETATTR reply

             fsx-1387  [006]   391.823136: bprint:               nfs3_xdr_d=
ec_setattr3res: task:61174@5 size=3D0x3ab89

# This event captures the client adjusting the inode's size

             fsx-1387  [006]   391.823137: nfs_size_truncate:    fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642 old size=3D151896=
 new size=3D240521

# Here, refresh_inode_locked is shunted to check_inode_attributes,
# which decides not to update the inode's size again

             fsx-1387  [006]   391.823138: bprint:               nfs_inode_=
attrs_cmp: fileid=3D00:28:2 fhandle=3D0x36fbbe51 res=3D0
             fsx-1387  [006]   391.823138: nfs_refresh_inode_enter: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642=20
             fsx-1387  [006]   391.823138: nfs_partial_attr_update: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642 cache_validit=
y=3DDATA_INVAL_DEFER fattr_validity=3DTYPE|MODE|NLINK|OWNER|GROUP|RDEV|SIZE=
|PRE_SIZE|SPACE_USED|FSID|FILEID|ATIME|MTIME|CTIME|PRE_MTIME|PRE_CTIME|CHAN=
GE|PRE_CHANGE
             fsx-1387  [006]   391.823139: nfs_check_attrs:      fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642 valid_flags=3D
             fsx-1387  [006]   391.823139: nfs_refresh_inode_exit: error=3D=
0 (OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D17528=
99367783879642 size=3D240521 cache_validity=3D0x2000 (DATA_INVAL_DEFER) nfs=
_flags=3D0x4 (ACL_LRU_SET)
             fsx-1387  [006]   391.823139: nfs_setattr_exit:     error=3D0 =
(OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D1752899=
367783879642 size=3D240521 cache_validity=3D0x2000 (DATA_INVAL_DEFER) nfs_f=
lags=3D0x4 (ACL_LRU_SET)

# Then the readahead completes. The size carried by that READ result
# is also captured here

   kworker/u24:9-193   [005]   391.823090: nfs_readpage_done:    fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 offset=3D49152 count=3D65536 res=3D65536 status=
=3D65536
   kworker/u24:9-193   [005]   391.823142: bprint:               nfs3_xdr_d=
ec_read3res: task:61173@5 size=3D0x25158

# inode_attrs_cmp returns zero also in this case. Prior to 7b24dac
# this would have been enough to block the following size update.

   kworker/u24:9-193   [005]   391.823143: bprint:               nfs_inode_=
attrs_cmp: fileid=3D00:28:2 fhandle=3D0x36fbbe51 res=3D0

   kworker/u24:9-193   [005]   391.823143: nfs_refresh_inode_enter: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642
   kworker/u24:9-193   [005]   391.823143: nfs_partial_attr_update: fileid=
=3D00:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642 cache_validit=
y=3DINVALID_ATIME|DATA_INVAL_DEFER fattr_validity=3DTYPE|MODE|NLINK|OWNER|G=
ROUP|RDEV|SIZE|SPACE_USED|FSID|FILEID|ATIME|MTIME|CTIME|CHANGE

# refresh_inode_locked decides to invoke nfs_update_inode instead
# of check_inode_attributes, and that reverts the SETATTR's size
# change

   kworker/u24:9-193   [005]   391.823144: nfs_size_update:      fileid=3D0=
0:28:2 fhandle=3D0x36fbbe51 version=3D1752899367783879642 old size=3D240521=
 new size=3D151896

   kworker/u24:9-193   [005]   391.823144: nfs_refresh_inode_exit: error=3D=
0 (OK) fileid=3D00:28:2 fhandle=3D0x36fbbe51 type=3D8 (REG) version=3D17528=
99367783879642 size=3D151896 cache_validity=3D0x2000 (DATA_INVAL_DEFER) nfs=
_flags=3D0x4 (ACL_LRU_SET)
=20
I apologize for this taking so long to diagnose. I was only
recently able to derive a reproducer that is reliable enough
to make steady progress. Fwiw, I'm now using:

# fsx -q -l 262144 -o 65536 -S 191110531 -N 1000000 -R -W fsx_std_nommap

on an NFSv3 over RDMA mount point against a tmpfs share. This
is taken from generic/127 but -N is increased from 100,000 to
a million.


--
Chuck Lever



