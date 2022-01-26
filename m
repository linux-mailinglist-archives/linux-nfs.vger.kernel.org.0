Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B105349CF8D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 17:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiAZQXM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 11:23:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12130 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236678AbiAZQXM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 11:23:12 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFok26029685;
        Wed, 26 Jan 2022 16:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JOaNpoq7ldjYvI3ICjxk0dDzc1Sqe4OYrJT2NaJMJpQ=;
 b=O0NwKG9KTSwi1ehOidwD4v3qKj56IZVo/X3BxGpXv5oYyqYogNT99la6RkEZtSHy4mQR
 kSwOq16jO2Be3honEHrKQ9EI1LsEunmY2tXP/FoErkiul2j9/zm+JMjmvio9mf7CZrIT
 fK+kyGB4PXPFH0csTGcMYhAHb/5Pq6s6j0BFMrvK0o/+Ouqyjlchjv3DDqULDsoCXSSy
 NyLXU2vmhyzZYpLTtGGmiC9KAkToSjkH88n+s19rIGzIPIIWYYhbOa+KCDzqkVByDQU4
 sxcUWYwIZW0lHfISMOG7KFUkUUpDkwOcgc6LTbfybNfTIqz1yJEvp0yetkknp3Ouik5m Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfpcaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 16:23:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QGAUxg153265;
        Wed, 26 Jan 2022 16:23:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 3drbcremy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 16:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy72nWdY3hbrJVJp5pvByfI6XlZ7TcUfQK9BA/gMxhDPzkqH2GrG8cWm1hl/9k/vxZCmZRfQPSBgUzxZES2vbIf/8bNkrIJOSDCXDuVOtYh6QEFawCYtaJ6rYwEtPcI207Ge5hudb8fe3e3PngCBC1wD2ZWORFuCLCkLyFRXHCROS7yjGhEtPPw4hVrkeYo9Hm6CvSrc17NGWFlHBulAvN60sWlO8aoY8rdj6K/8wnwvpReOf0dXL8J+pDKZk5PsgAj9hY9HCsvGnhoWW9t10t/Xa9nDcumfdLveeKE9d0ZHn0KBCU9x4axLE0VsRxqwFeUdaMXFsid6FGnTYTVg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOaNpoq7ldjYvI3ICjxk0dDzc1Sqe4OYrJT2NaJMJpQ=;
 b=QUWL4RZSD+Rl3Krjr/6xc1KsfjyNwc0EjKhPlLkoAtpQvl7menOv2N5xo3yo7pyAMGw+1VVZ1yj4wbgn8mj0zIjY5u/LFDFpJNBOmw8Xt2NSdA+FJKTyJJhC7SryrzCJlJXlg/Vj5DbX3m6QoPMYA/VzpFLoFek//EUp8I58g2snqWsi6UHC5leyWWQxkFlLmOV2F+cETVPVOOZgybLmj1vXUm0C8C2ye83tdYTHez1yiO+sdjyqk/iFJyCGCzD3NKU1EzXmnbRqiBLQbT/L1KeogLRAiKanQFcLokQmnbxe14QwVb3zazCX79FQgPjYMFT1tBnDzwGgD9zqph3hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOaNpoq7ldjYvI3ICjxk0dDzc1Sqe4OYrJT2NaJMJpQ=;
 b=PkeE5Y9+MNgvuvucBIgeQFE0AmQj7mdB3ThK36vItnRk9ZxPvu3uUhqUDfC8kPCcnCmFn0pwA8oT1zNvzs1nW4oOnB9X4Hv381FBz3X9zVAJn+EnKjRYpIZLZewQx3EqceUbxMIasbRCQVEA8M31ltdOIKNWbZOg6r80MoYp0TQ=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 BYAPR10MB3589.namprd10.prod.outlook.com (2603:10b6:a03:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 16:23:02 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401%2]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 16:23:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v3] NFSD: trim reads past NFS_OFFSET_MAX and fix NFSv3
 check
Thread-Topic: [PATCH v3] NFSD: trim reads past NFS_OFFSET_MAX and fix NFSv3
 check
Thread-Index: AQHYED6pOMI/9V2oVkmi353YFkSzN6xwu4+AgAAaS4CABKuigA==
Date:   Wed, 26 Jan 2022 16:23:02 +0000
Message-ID: <F94FB612-02EF-4524-97A7-C4DCD1E1902E@oracle.com>
References: <ADEC85C2-8D72-4E25-A49B-2039C1FF82F2@oracle.com>
 <20220123095023.2775411-1-dan.aloni@vastdata.com>
 <58db6c327e2c72776f051a987f9b813606c53a71.camel@hammerspace.com>
 <A1AF622A-6794-4104-8A89-EA5CD9E19D7D@oracle.com>
In-Reply-To: <A1AF622A-6794-4104-8A89-EA5CD9E19D7D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03e191f1-0030-4844-9337-08d9e0e81fed
x-ms-traffictypediagnostic: BYAPR10MB3589:EE_
x-microsoft-antispam-prvs: <BYAPR10MB35896970886A1C5D9AEA396893209@BYAPR10MB3589.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIaRhmGDeWJNyrpRgYSYERPpIzCuyU4m65ernSJbRG1WsrxIUSAgEVwHxQnoK9f8RSvlMU7iWc/RWHuYvagAjvHOSsdDFcz3uBAqc+P0i68EroLys+FHfKXV/aGWeDm+kkv7mxvv4voLarWBmAkaaHzGohNgjwvj77Wxramu/GZj0s7Y+5IhpZ0f2BVxyOC7YWC5y0qFnEwaM1uk4yWGCp6oB1W5R3vJm7D8bm9zjVcbswmPRpzEImPQynlQMe//KJRZ83rjFo/+2JewHhrL1tuQub2a0Ob0fWbBqWrkBcmTcljIXBMMqvNCV2io8QZlDDBOh4RSgAZPLvnZg/4ue5GSFV0xp0JNbszAF5CY8Vsu5lyheq2CFpIh2rKiA60tFwJ9L8qHwNlfRJKIfqGo5iAoIaMc98pqE6ZZ/5twyR7m8l0MSLBXE6Cq9CkqSBD7/jPgDDkSPmVrD6ni+H7+H90XopU6doXuhvjSdssPVgbT6Ey0bCIj02TqjKx3VgRsI+l2/TVFVdKr/QH0h1Ny2ENSgQjS1tNJGxCTNGhJAlwbMBXNowuWJFKev6cbsb21w6b8QkmJIdsRC4Y/3SlNX+aR8rLh0WA40VXmo4NGxzCqFBhkXEJHHjMtHtfcHL/2+5+qNzcgsBkb+Ar5x9GB9WO3eHz+vhgJXJw8fxUs+wvBqIMCVCr9dScYxqnqlnXGFVYVtMZWsn8/LXpjaRt3rLYtRSwVzwpFHJqBuakIV3U7H5p4S5Mp+DHZro9KdGqh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(5660300002)(71200400001)(38070700005)(91956017)(76116006)(26005)(2616005)(8936002)(33656002)(8676002)(316002)(6512007)(186003)(6506007)(53546011)(508600001)(86362001)(66476007)(6486002)(36756003)(4326008)(2906002)(64756008)(6916009)(66556008)(38100700002)(66946007)(54906003)(66446008)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uSjmZq26ntqjRBjaCo1TMeGlW//PFAb54p802hYL/gRVhsV6PCiSbEqQ54Tm?=
 =?us-ascii?Q?igLAA0FtQWldoNjGvajkSZ4Sbk6dvCRpriiKkSUaoL9BMjfFshfXDZC3R3Lf?=
 =?us-ascii?Q?F8kut2wsLQF31gCwemLqAtOBXbE7a2tSf1qJJ/qVxirXNhIfWwbLR0BTnXeh?=
 =?us-ascii?Q?e/JRjHskiE2cmkUZh6J4c4X2ad6uenhYApbOYgldjQTVrj7dzdCM5AGOLE0/?=
 =?us-ascii?Q?AivIyEQQsbi6rV55JLb2vE+fNu8/hT+UcBCBV020LhUXC5bu3GqN3OQrq80c?=
 =?us-ascii?Q?9WUJa9xsHstbuxoA8STHS/v2klEEeoyLI9D0CCavcQ3R6Kskc4fQItm5pqOS?=
 =?us-ascii?Q?HiI4H7pzB741WAep90uIdGd9xQBiF1fzMyUKk7W6kIdvg0kWRrgRGJXA/s+/?=
 =?us-ascii?Q?NeGXKFNHazHfpD/dGaaKOWDKWzMY40JOrGHqXSO15JiLuKzQN35O80Ljnyzb?=
 =?us-ascii?Q?1jnTffJ5S4qjYemTa1mMMDgzQYxFy1pkTkjTyLmS8yERm6L2akfgIc+7M3JT?=
 =?us-ascii?Q?lvergnJ5TLv7H74iYzIOz6smtl2sozINdTzey1Az8RXu4gkgQlNIKFYXIq7R?=
 =?us-ascii?Q?aDpW6u8zk6PnNQvJ8Db2y9ARSRdHW0aOwK0eKnqDQnmiZ8BgfJ/LGhk1XeA6?=
 =?us-ascii?Q?8IhU5XKwo6vxMQ76Xpcm4UZB1s6Nb32z0MqAkTPhAE0WRWaMtjGxgkDZxlQe?=
 =?us-ascii?Q?Pu2/kLtPHInvcHjoY0eSJQHTd54s4xBGyoxIVr0yjqo84+zoK/puZPSWW3Zd?=
 =?us-ascii?Q?lZQZ47/NKtCqK4v+YtCd3+5Ca73/TDMXu5/JTv7d6zfWDLYhIalk2hGu3EbV?=
 =?us-ascii?Q?1dqqeYLTTRYq7OQxiJDTOKHTCGaIn+hn6g1awiBC7ZIT5JkD2T86N+K9y8ZR?=
 =?us-ascii?Q?T3GEohQErpVf3Y4C80QZnUPUZ4ut5Pt6JpbHCibGag4y7zCZZDGJ8b2PDq44?=
 =?us-ascii?Q?0IF4yV12nwzB86AlVhNVioWxypKjJOL3VPGaRaZGltuGrbeM/MfqqXO1y97k?=
 =?us-ascii?Q?eF8akTglsoefWG2VTky9nJhRCPGjHQH2PqrpNvbgU40AnYE7Is6HT5b1GGM2?=
 =?us-ascii?Q?6iYa9uQJfcbWV6ny5NSti4z5Jtfkv8gVOB/k4S9XoLCAPhoECZTExohpHTLI?=
 =?us-ascii?Q?0iL5NUQS/aJjcMoccQmhviHHLz1spA4gGMYZeMjl5L5rzgpiYJOwf8+8MHXS?=
 =?us-ascii?Q?KX2Rsl1wQ4/4mRWSHnwOcIPvk9ouDDCVfv4rajsGyYR2CAqY28AlGXy9MJnf?=
 =?us-ascii?Q?G98n5pgoyyFm7csbfxGAC5XbMuqcG/9eXekBHA8clPIIyBvecLL9lUmVG43x?=
 =?us-ascii?Q?R5xmA2VeYJUFLyiCIhezXWQdfGuuWAwtYbSZB94St6VVNAuss5mOq9gGuD+D?=
 =?us-ascii?Q?A6NkKlvqJYORtnK9s4q7GP3em9Ai+CWZs0zGDV14efQ0G7mBRzgtJseB+tpq?=
 =?us-ascii?Q?NdKsKFpB63Z+144L21Hmrj2s5DWWeCT7J//kc+xvqqeY2vYIsTId5KgCMkex?=
 =?us-ascii?Q?isUgkmwJT1FPHFH0S1xOB+7JGQzktnYrPpZaS0meWAT9zC85+hyrsdRdlQsV?=
 =?us-ascii?Q?0fPP9gOOyIrhwGaTrl2e9jInWfYKAtBIj8jc5D47l9SGtYzjXSwh5lcGNKDN?=
 =?us-ascii?Q?PNyBEDiwbdnM9/TULcsLpxU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CC62FAAC8197248883913BA3E281540@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e191f1-0030-4844-9337-08d9e0e81fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 16:23:02.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qorILBDMrsR9TgGH7dN52qiB/TB7LCnmNfz/74ZTv9tQFaUfx5+O7CoXsj+ZqGdV86sRt0Pw5+9jC9yvTUYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3589
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260102
X-Proofpoint-GUID: qok9iUdDAAawihXeGbQMmZCV5W3gOuxv
X-Proofpoint-ORIG-GUID: qok9iUdDAAawihXeGbQMmZCV5W3gOuxv
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

Dropping stable@. No need to copy them on this discussion.

Also, you don't need to actually cc: stable when you repost.
Just add the tag as you did below. Automation will pick up
the patch when it goes into mainline.

More below.


> On Jan 23, 2022, at 12:03 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>>=20
>> On Jan 23, 2022, at 10:29 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>>=20
>> On Sun, 2022-01-23 at 11:50 +0200, Dan Aloni wrote:
>>> Due to commit 8cfb9015280d ("NFS: Always provide aligned buffers to
>>> the
>>> RPC read layers") on the client, a read of 0xfff is aligned up to
>>> server
>>> rsize of 0x1000.
>>>=20
>>> As a result, in a test where the server has a file of size
>>> 0x7fffffffffffffff, and the client tries to read from the offset
>>> 0x7ffffffffffff000, the read causes loff_t overflow in the server and
>>> it
>>> returns an NFS code of EINVAL to the client. The client as a result
>>> indefinitely retries the request.
>>>=20
>>> This fixes the issue at server side by trimming reads past
>>> NFS_OFFSET_MAX. It also adds a missing check for out of bound offset
>>> in
>>> NFSv3, copying a similar check from NFSv4.x.
>>>=20
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
>>> ---
>>> fs/nfsd/nfs4proc.c | 3 +++
>>> fs/nfsd/vfs.c      | 6 ++++++
>>> 2 files changed, 9 insertions(+)
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 486c5dba4b65..816bdf212559 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -785,6 +785,9 @@ nfsd4_read(struct svc_rqst *rqstp, struct
>>> nfsd4_compound_state *cstate,
>>>        if (read->rd_offset >=3D OFFSET_MAX)
>>>                return nfserr_inval;
>>>=20
>>> +       if (unlikely(read->rd_offset + read->rd_length > OFFSET_MAX))
>>> +               read->rd_length =3D OFFSET_MAX - read->rd_offset;
>>> +
>>>        trace_nfsd_read_start(rqstp, &cstate->current_fh,
>>>                              read->rd_offset, read->rd_length);
>>>=20
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index 738d564ca4ce..ad4df374433e 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -1045,6 +1045,12 @@ __be32 nfsd_read(struct svc_rqst *rqstp,
>>> struct svc_fh *fhp,
>>>        struct file *file;
>>>        __be32 err;
>>>=20
>>> +       if (unlikely(offset >=3D NFS_OFFSET_MAX))
>>> +               return nfserr_inval;
>>=20
>> POSIX does allow you to lseek to the maximum filesize offset (sb-
>>> s_maxbytes), however any subsequent read will return 0 bytes (i.e.
>> eof), whereas a subsequent write will return EFBIG.
>=20
> I'm simply trying to clarify your request.
>=20
> You've stated that the Linux NFS client does not handle INVAL
> responses, even though both RFC 1813 and 8881 permit it. So
> are you suggesting (here) that the Linux NFS server should
> not return INVAL on READs beyond the filesystem's supported
> maximum file size but instead return a successful 0-byte
> result with EOF set?

After some thought and discussion with Solaris NFS server
engineers, I think this is the best response to a READ
whose range arguments go past the server's advertised
maxfilesize.

So can you please confirm that your final fix does:

1. The range of values that was failing before but shouldn't
   have, now succeeds

2. When the offset is less than maxfilesize but offset+count
   exceeds it, the READ should succeed but return a short
   result and set EOF

3. When the range is completely outside maxfilesize, the
   READ should succeed but return zero bytes and set EOF

And I don't mind if you split the fix over two or three
patches if that makes it more clear.


>>> +
>>> +       if (unlikely(offset + *count > NFS_OFFSET_MAX))
>>> +               *count =3D NFS_OFFSET_MAX - offset;
>>=20
>> Can we please fix this to use the actual per-filesystem file size
>> limit, which is set as sb->s_maxbytes, instead of using NFS_OFFSET_MAX?
>>=20
>> Ditto for 'read' above.
>=20
> That sounds reasonable.

I'm wondering whether the VFS itself will bound the range
arguments relative to sb->s_maxbytes. I'm told that the
kiocb iterators used in fs/nfsd/vfs.c should do that.

All that NFSD has to do is ensure that the incoming
client values are converted from u64 to loff_t without
underflowing. So comparing @offset with OFFSET_MAX here
seems like the right thing to do?

We just don't want the READ to fail with INVAL.


> But I wonder if there are some other
> places that need the same treatment.

I've confirmed that there /are/ other places that need to
be fixed. I've created a series of patches that will address
those. The first of those was the COMMIT patch I posted
yesterday.

Dan, I'd like to include your READ fixes in that series.


>>> +
>>>        trace_nfsd_read_start(rqstp, fhp, offset, *count);
>>>        err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
>>>        if (err)
>=20
> --
> Chuck Lever

--
Chuck Lever



