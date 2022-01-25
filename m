Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14C649B990
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 18:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiAYRE1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 12:04:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54424 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354737AbiAYRCG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 12:02:06 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PGmWeh031613;
        Tue, 25 Jan 2022 17:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hOX4KkrWxLXpfRVbxvlNSY6mX2G+QzVu7v3rKVbptmo=;
 b=CwRKMgs5X54Lkih7MijBWeBp3O8NSVnpnd/3iLuUwuOahfQBG/Nf46J5Jj28cPQYBN+T
 RbaZa+4xwed0fGnLcTFir/k4E9BbWJVsB8XJG0oTY4xPVkFLcc54QDUfBgZurfu61pz+
 5qb2qBQrpaDx75expl7idbMpKcauhtM1/Q59tZ+mt+ndVhr0n06XyNNUWKVQHCJZOmeW
 Nvu4j48OTusg6uLgH7Oz/xYjE7Ciky33PhHMwK9sKCcbfQVs48EzM4yh+ajDy1po6W2P
 crKruw1hsachKynIcXrTIzqaSN6m9eOM+neAXoQPld9S87AFvoqwBPehVIPpJ3VaC9Et rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s3kp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 17:02:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PGoSoC192238;
        Tue, 25 Jan 2022 17:02:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 3drbcpav7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 17:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGM+36LuyrE+fPiBalyCALgeJ8fLmjyoVNsXrNr03GDKw6kqBsP3oossis9a/jkHOTb6da4zF7EwLBbZr7njzZCyFRn+cPQCMBoEMBOGBg/Sz3Be+vIvhZ36zeKYXgQ9G8PWnST7ey7Qm6n92ry9+Z0sckskL1bXRa0f6na0zdfI+RUKxLYWCxIsUnGdLZomQiq07i6m+/ctGt7pV6kwuCrcUlTYuexmcHvLCss35iHbq+c4X6HxcbO4/C1DIfdboAdoKtAefFS2aYVAa4fCuUCH6WmjjCggw2sYDwOZjqAImad4Y9xLL7kxv42kBX9WT1X+YJM0zKW5H5oeUZP1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOX4KkrWxLXpfRVbxvlNSY6mX2G+QzVu7v3rKVbptmo=;
 b=jtkMnRrx+G+ha3qPooo/Qb23fcedn+TlASCzMLncwbCs918fHN5DJqTiq9/Z12H8KjQwSvl844MCrX5fyCfkjQfBPeFCTPa6z3dr/F8csau45SiFKrZkAxwTr4UBFMa77p+l5RfNOWiqudQpQWBwmDUOZWJ3RswzoWH+2NrJIxMFt2S0iw8JR33jqXI5MjfLkOekAFjNbHQ+8BAqEkOrO96obKdkMqhyPRW8H8SV5kC9JjjRiucql4OXQsSF/Ok3RUy9LgID2sVPs+F2ByRr4lsnngdVup/U9+OE4QL6ObwWfA1KJe71PSzHVFDzKVg2+BhWWT2oIi/4z4JTVhiNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOX4KkrWxLXpfRVbxvlNSY6mX2G+QzVu7v3rKVbptmo=;
 b=uFjUxPbr/JRUEnfd0I1oeA44iOew0YxYCvtSNgl6MbWv7IfsospDkVsvKmTv7KLkox8T1JaNbm6HeLUkvryKQ9wzxYPnefGH/v6CiDCVTXje07BpcVEZLB9svyeyJSHl7qSHTtyzVBrUkZutH3K8aSA0tTu9fCTzNZz7z/mA1Og=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN8PR10MB3410.namprd10.prod.outlook.com (2603:10b6:408:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 17:02:00 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 17:02:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] NFSD: COMMIT operations must not return NFS?ERR_INVAL
Thread-Topic: [PATCH RFC] NFSD: COMMIT operations must not return
 NFS?ERR_INVAL
Thread-Index: AQHYEf7IxxPUnrPBHEGdXTqLugFGy6xz8ioAgAAEYQA=
Date:   Tue, 25 Jan 2022 17:02:00 +0000
Message-ID: <25C6BF9C-9C4A-4469-A2E1-D0CB2DF27E9F@oracle.com>
References: <164312364841.2592.937810018356237855.stgit@bazille.1015granger.net>
 <20220125164620.GB15537@fieldses.org>
In-Reply-To: <20220125164620.GB15537@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b837263-eb6b-40a5-e0e4-08d9e0246776
x-ms-traffictypediagnostic: BN8PR10MB3410:EE_
x-microsoft-antispam-prvs: <BN8PR10MB341059993C88AE594DB20F9A935F9@BN8PR10MB3410.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:177;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSoZ+IH2VFfPU9g06kfykXhHiRJ2VJPDeskVXjKu0CyZ63b1/GiQp7+JpRwJ1VQ2W+FmNKCPgZ+DPJedj3vSgEFFin6ombpXrlF/EpR9fJh3mUPIPxqWNyuY2rZDA9TFOjJhkdkmdc8c5ZcUaHx2GEiv43IXhZmAHggJLZ14jJW/5NDUJ0e+IGaA2+LxnDgObsGrTomVWpZc8zs6I9f4mR4lhk/GPpWvgGEqfgrSilFXik8Jt+qy/nybz1dZLvuQkCqfVyFg4+Esvfe13nZQW0uzXzUfR59cw7Wg4sI4yrsLQhNPZ/ZiHYRgh+UrYeG3AXR28MNSu5UWPGz/oiQISoIFRerPfjeuaX183Iqe+Fva+rEsrHgPUZT+ij44/do7yDx+D4FQNaQyHa+tJBI0fCQcA2ua2kyyNY8d/PTqYCT5Ft8Eit353rS2tAp6Er5d+MycQyAT5ebKpR/RlV+UKXgwgeWaftVIFMIP3OTMrZMrRpXm0//WgWdqIR+EbSxVAns15qxOweTh77bnoOEdEe+iyMNKFyx2whQRKBGKSqIF4KDwuYteMnsp03QW7LY62sIYyAGuU/42GJaJPcHXbBgOCqAGJH+RWEFvJ2F41LJlWjhb6o0NJ0icUcP+96BhjzkI/LmrhjYbmvC0XLHD+D89XwPNuLyW4tPQzMu2lVywoRhaQgBifFtNQDAvRj/wmZzOgnyOS0+izr0bf0JHKUhVBR/w1IsIazmEAL1TCGaYkq0I7tDIQKBYZJ9j9rNG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(53546011)(66476007)(66946007)(5660300002)(36756003)(83380400001)(26005)(6486002)(2906002)(316002)(33656002)(122000001)(8936002)(38070700005)(38100700002)(6506007)(66556008)(66446008)(64756008)(508600001)(8676002)(4326008)(6512007)(86362001)(71200400001)(6916009)(2616005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k2xLRIGp2NgoNoRTba8YaOJS8yybNswEH/khO8QMN1/llzNDeQCkjmx8Kbj3?=
 =?us-ascii?Q?1MPurwt+nQV9U5cPFqjkYUOQ8KXCsTlLk/HjpM+DXJhlefei2wIvWuLmJvjx?=
 =?us-ascii?Q?+sVyfXFyiqnYnsUuMdKEdp64v4/w2M6ApsDAlS/Hgic4GjhxGDD90xet43Ur?=
 =?us-ascii?Q?nRJ2a5Fwf/iOjD/3fB+oyFpt+1SSWb1t/Fe/F/fyrfPAVMHgUwPYu1TSnd9v?=
 =?us-ascii?Q?AYN8Rs/JHqear0/GgS+azc56VhRuXMh/+qy9c2HcnXAmZgGiGquo17QiuxPO?=
 =?us-ascii?Q?BBWf1XLgorHNKFvlLsp7X+04HrH8moAnro3VXWo2KK0YcM/RcS89zLbeY1d/?=
 =?us-ascii?Q?rJ3YemcJNRH7qvw6b98OWq8OrAUv5mywnDw2a7R2jDe6swyDlgfVcymDkk9q?=
 =?us-ascii?Q?wXUap22Lw+cfDZ2YDiK7yWjdj2TBRcjMBpgZCIztB/HzEC4tO1EJH9qW0iUM?=
 =?us-ascii?Q?B3DFkPu+4OQptvbTWkqimRBGeRpRCveNdcpODbSrsySunhrCJ8hmu2xA39XR?=
 =?us-ascii?Q?NDs6BjfwHuLSw2QROWy45KLBBfNO5hLEGK9H3YiUsE60nmMHVTHnCuq5AZMw?=
 =?us-ascii?Q?snF1z2l4kYc/2xM23sbVaL7jSzv/g4FW1RzmrnAFmnLJ6YftkWbapHMd8OD8?=
 =?us-ascii?Q?nm8/bwozawejXaH8zxOHIH3cYA2lw0jBeQLgbrDY2o5VDXqbquhjKXlUazaz?=
 =?us-ascii?Q?AnDW/8jaM4RnWEeEzOgbhG7csstuFod7NeJjWKKgAyovPfMBjRRd3fv/MsE+?=
 =?us-ascii?Q?ALVynV7RLLT9Q1xtls+FE64xgX540VZ9BQ2XCPJ0ZkKcIEbLv8VLSV6KFkRR?=
 =?us-ascii?Q?COqVDGJ2N09r1D8p6Yor1DEkreEx5hgpz8hhwPlJi9WkJ/lBHR+EtW/e6Sc9?=
 =?us-ascii?Q?X5RbZXIFy/QBdAW7+KZY6+VW0PfLx12AzGYZ+o0xX2eUTUwFjvB/7R+UtFtv?=
 =?us-ascii?Q?0I6imwoBPcU2uW6BNA1zI0NhkfEd6xd6xBN21qR5I0lqO3fCFP8DaPeP/MAs?=
 =?us-ascii?Q?VfRn8xISummWRRKnV1kUsLrdCbfjUGd6oci5MUCVztSLTkJeOCp6ERtSdbT9?=
 =?us-ascii?Q?qBV8xxNqbLcQG9MrONpv+9Dh0HAVlFhCLynwc0YrZmtYohhaKjRutu9uB1BP?=
 =?us-ascii?Q?ulNgYnRVN9c+yY72SbLOCociSk8Gglt3+WSdFisD8Kj0d/rgQyalV5eIFhe1?=
 =?us-ascii?Q?ZTbvj/x0D3B4OWnrhRSL/KPT8b3iyp/zhFcWJfCcnvd3KBD8/OjNp+R/a0ho?=
 =?us-ascii?Q?4aW8Wi08lOgXkRGOfxJUx4lpBlZ+sNSeZRsuqZ4w3B3dkaVK6A5mY/yizL+s?=
 =?us-ascii?Q?xuP9Lt/CO0aa8d+gIg94D9HS9I7BMZpOHSFmS/d+jKkuzlRi4LaK267DdnKe?=
 =?us-ascii?Q?64CZfMMRyks8mvgogM0jDd2SCi27yZa4Et8HqxuaFLC+qc4FAh62TQ+HL3XT?=
 =?us-ascii?Q?/NTFaRQ31AWxFFEvvhiMdUPWHO+eMh1rjjKKjDiPlbH8qbAhPXOHnx4su7FV?=
 =?us-ascii?Q?Xczwg6DP4xrDgGlahtvlA00RHWTH5NB9V2FphKrFZYuhG0aUw+cG3JYCeTzc?=
 =?us-ascii?Q?5IZDKjNM36D5xN2kynHCgTslERSRtHMN6cxt73Glzhum46smhYnH6Z9e/NFj?=
 =?us-ascii?Q?v+r5Y2rLxnh9iqoA53T0A9w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C841668D9BAFD04AAD8A86458AAD1C54@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b837263-eb6b-40a5-e0e4-08d9e0246776
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 17:02:00.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47kIDaJNUJUDHt6xI81M50a4VzqSV+vZQ0k7F37Uwc7ZyGkpJNotUtpc6RkWfLxyBtL13fBWsKjtlaAk8gVt5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250106
X-Proofpoint-GUID: _mhhsMp9Xw9pcsM-zG4y18IC5JTZNgC2
X-Proofpoint-ORIG-GUID: _mhhsMp9Xw9pcsM-zG4y18IC5JTZNgC2
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 25, 2022, at 11:46 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> On Tue, Jan 25, 2022 at 10:15:18AM -0500, Chuck Lever wrote:
>> Since, well, forever, the Linux NFS server's nfsd_commit() function
>> has returned nfserr_inval when the passed-in byte range arguments
>> were non-sensical.
>>=20
>> However, according to RFC 1813 section 3.3.21, NFSv3 COMMIT requests
>> are permitted to return only the following non-zero status codes:
>>=20
>>      NFS3ERR_IO
>>      NFS3ERR_STALE
>>      NFS3ERR_BADHANDLE
>>      NFS3ERR_SERVERFAULT
>>=20
>> NFS3ERR_INVAL is not included in that list. Likewise, NFS4ERR_INVAL
>> is not listed in the COMMIT row of Table 6 in RFC 8881.
>>=20
>> Instead of dropping or failing a COMMIT request in a byte range that
>> is not supported, turn it into a valid request by treating one or
>> both arguments as zero.
>=20
> Offset 0 means start-of-file, count 0 means until-end-of-file, so at
> worst you're extending the range, and committing data you don't need to.
> Since committing is something the server's free to do at any time,
> that's harmless.  OK!

Right, committing more than requested is allowed.


> (Are the checks really necessary?  I can't tell what vfs_fsync_range()
> does with weird values.)

In general we want to ensure the math doesn't overflow.
But I can have a closer look at vfs_fsync_range().


> --b.
>=20
>>=20
>> As a clean-up, I replaced the signed v. unsigned integer comparisons
>> because I found that logic difficult to reason about.
>>=20
>> Reported-by: Dan Aloni <dan.aloni@vastdata.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs3proc.c |    6 ------
>> fs/nfsd/vfs.c      |   43 ++++++++++++++++++++++++++++---------------
>> fs/nfsd/vfs.h      |    4 ++--
>> 3 files changed, 30 insertions(+), 23 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index 8ef53f6726ec..8cd2953f53c7 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -651,15 +651,9 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>> 				argp->count,
>> 				(unsigned long long) argp->offset);
>>=20
>> -	if (argp->offset > NFS_OFFSET_MAX) {
>> -		resp->status =3D nfserr_inval;
>> -		goto out;
>> -	}
>> -
>> 	fh_copy(&resp->fh, &argp->fh);
>> 	resp->status =3D nfsd_commit(rqstp, &resp->fh, argp->offset,
>> 				   argp->count, resp->verf);
>> -out:
>> 	return rpc_success;
>> }
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 99c2b9dfbb10..384c62591f45 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1110,42 +1110,55 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, loff_t offset,
>> }
>>=20
>> #ifdef CONFIG_NFSD_V3
>> -/*
>> - * Commit all pending writes to stable storage.
>> +/**
>> + * nfsd_commit - Commit pending writes to stable storage
>> + * @rqstp: RPC request being processed
>> + * @fhp: NFS filehandle
>> + * @offset: offset from beginning of file
>> + * @count: count of bytes to sync
>> + * @verf: filled in with the server's current write verifier
>>  *
>>  * Note: we only guarantee that data that lies within the range specifie=
d
>>  * by the 'offset' and 'count' parameters will be synced.
>>  *
>>  * Unfortunately we cannot lock the file to make sure we return full WCC
>>  * data to the client, as locking happens lower down in the filesystem.
>> + *
>> + * Return values:
>> + *   An nfsstat value in network byte order.
>>  */
>> __be32
>> -nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -               loff_t offset, unsigned long count, __be32 *verf)
>> +nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
>> +	    u32 count, __be32 *verf)
>> {
>> +	u64			maxbytes;
>> +	loff_t			start, end;
>> 	struct nfsd_net		*nn;
>> 	struct nfsd_file	*nf;
>> -	loff_t			end =3D LLONG_MAX;
>> -	__be32			err =3D nfserr_inval;
>> -
>> -	if (offset < 0)
>> -		goto out;
>> -	if (count !=3D 0) {
>> -		end =3D offset + (loff_t)count - 1;
>> -		if (end < offset)
>> -			goto out;
>> -	}
>> +	__be32			err;
>>=20
>> 	err =3D nfsd_file_acquire(rqstp, fhp,
>> 			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> 	if (err)
>> 		goto out;
>> +
>> +	start =3D 0;
>> +	end =3D LLONG_MAX;
>> +	/* NB: s_maxbytes is a (signed) loff_t, thus @maxbytes always
>> +	 * contains a value that is less than LLONG_MAX. */
>> +	maxbytes =3D fhp->fh_dentry->d_sb->s_maxbytes;
>> +	if (offset < maxbytes) {
>> +		start =3D offset;
>> +		if (count && (offset + count - 1 < maxbytes))
>> +			end =3D offset + count - 1;
>> +	}
>> +
>> 	nn =3D net_generic(nf->nf_net, nfsd_net_id);
>> 	if (EX_ISSYNC(fhp->fh_export)) {
>> 		errseq_t since =3D READ_ONCE(nf->nf_file->f_wb_err);
>> 		int err2;
>>=20
>> -		err2 =3D vfs_fsync_range(nf->nf_file, offset, end, 0);
>> +		err2 =3D vfs_fsync_range(nf->nf_file, start, end, 0);
>> 		switch (err2) {
>> 		case 0:
>> 			nfsd_copy_write_verifier(verf, nn);
>> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
>> index 9f56dcb22ff7..2c43d10e3cab 100644
>> --- a/fs/nfsd/vfs.h
>> +++ b/fs/nfsd/vfs.h
>> @@ -74,8 +74,8 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_f=
h *,
>> 				char *name, int len, struct iattr *attrs,
>> 				struct svc_fh *res, int createmode,
>> 				u32 *verifier, bool *truncp, bool *created);
>> -__be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
>> -				loff_t, unsigned long, __be32 *verf);
>> +__be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
>> +				u64 offset, u32 count, __be32 *verf);
>> #endif /* CONFIG_NFSD_V3 */
>> #ifdef CONFIG_NFSD_V4
>> __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,

--
Chuck Lever



