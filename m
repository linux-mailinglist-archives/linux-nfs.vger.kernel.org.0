Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6DB437E75
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhJVTSs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 15:18:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60496 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233564AbhJVTSs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 15:18:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MJ9WEK026091;
        Fri, 22 Oct 2021 19:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AezTSFk8zuPbdTMt/b9ACOXS2gGFfH0UlSuP6H9dRfs=;
 b=xVpcTTU3Itzh6VOF4KKqpnNIaRWzxVQT/3lmcOtywr9o1xObLl72WGL8yR8/vbiNUCZf
 C5k0xkpLNBUNlzm/P1k5yi0D4lznMLXuY+UhYYpl41I6+DSMaIbayDNu0FJRH33JsEJz
 3TbPeQEGGVSTFHEoyehmd+3YB8UPO4PxU15+psqTjDXr7XIfm2qx87Z1MDa6N+Ilp5xe
 UaOomu7rcKMPGys3ahao975q/bJqZ4Lrl/Em84UXpe4sObc0sfo/GiTCXYeYuZimBPSg
 5X9FdKzS1ScZL7fBAzOt3MB38rX4GCMjy8PosxExDYNFxBVZNz6wKy25N58IMJaAtYDW jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bundfm4p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 19:16:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MJBN8o095998;
        Fri, 22 Oct 2021 19:16:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 3bqpjb2cty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 19:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TonbRHMcPjXMhGIa8C2gS8PIuKmbJV1teXGgMrVkjhI6Pt6ocgxWRED6ZDvCQF1ORbZoYRSY8cqckJPpZUBUlhiLZg1dlRHECtpbhqJHW41DuVMTFw04Fm+8rHKvwaQbWCwqOY+uVOl9kmOCM0q1GngC3lPZJh+wbPlTAqTgfgjleHX4kzRb0G7zf/e2OqvCpul38YO6c7JQHRsZDIPNX/I9Zw2ELOKAqW2zW21Tzc0SkJuc5ihXOiUxkhA1H53GYjwcdVo6omHZqKI5+pdOVAXzoFwIiZTKwvV3qGGhojxjXU9poQpBpgDC110i0mwOb/hhaRjLl6eT/7dX/yEztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AezTSFk8zuPbdTMt/b9ACOXS2gGFfH0UlSuP6H9dRfs=;
 b=CZ4izMiNA4DnK0PaS03nuF4np8WN5WTre8xtN8s7sduh0WiHoJeUPT6DgvR09fLTboA4y2KurVcwitOyfoWOpAOaZ0wUfnEjo5vPxPiLN9XJn5YfyT4YVn19Lma/IWRmbKRMCOPe5P3yB3zwPAg98VOrSKk8do9nuD5Ft4UJS6RVRy+hRiEcg/Nc1FlKS+UVXAU+MAiA/uzRd82MEUScJyXi8yNmvH+LBwawBs8UL++UhQn49zk7pQ0z83935yhM4ML8wQzgoKsxauVZMG4Ng1u7HSX7glHZM7eP04A3AhWh3Tr3FNprze1iMvm0K/RGv2/96XvxiQzluIFfZ0Gt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AezTSFk8zuPbdTMt/b9ACOXS2gGFfH0UlSuP6H9dRfs=;
 b=AqNu50fO3lnwsfUXlcNSiFhPif025Wa7EEOwLVIqdQxJm39d0BVYvBnuYgb8kIG8qZP0vT9ZTSLA58LH2h5kRYkbVJjTxQEuSqBnLuGfRWAR10fdl1jUMmx6lSzjqLl0LdQWUJkwH5z8in3CukWPBKvW2v7ddr8hi9egEhZPF6c=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2693.namprd10.prod.outlook.com (2603:10b6:a02:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 19:16:20 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 19:16:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] NFS: Move generic FS show macros to global header
Thread-Topic: [PATCH v1 1/2] NFS: Move generic FS show macros to global header
Thread-Index: AQHXxQjSLWCBRaywyUO1OlTtPHP5davfZ/CAgAAAk4A=
Date:   Fri, 22 Oct 2021 19:16:19 +0000
Message-ID: <C19A9D95-F3E7-40C9-9B37-E4829249DDDB@oracle.com>
References: <163466195619.4493.18063027404688028587.stgit@klimt.1015granger.net>
 <CAN-5tyH93fc_UQxZGALe6Z7tGhGnk1gzhiXMQaN2aonZ_FL5=w@mail.gmail.com>
In-Reply-To: <CAN-5tyH93fc_UQxZGALe6Z7tGhGnk1gzhiXMQaN2aonZ_FL5=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8e81695-30dc-4368-c8a2-08d995906ddf
x-ms-traffictypediagnostic: BYAPR10MB2693:
x-microsoft-antispam-prvs: <BYAPR10MB2693117ABCF13CF4E6EA5B8293809@BYAPR10MB2693.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6468fOfr7l67aBD3QgS/1AKzxev9oTI0oyhSG/Tqmv3SFH1prJzQTDlMoFoHZ2pMqHte+f+Wu14LqH3A3azY8l9uI2RpLOVIDysl66BBfcsVyiI+xYoP2HNT1dtt4Jsu2soRCDw6cbJaMaW94RLxz/V51+LNSBWLS4Oa5JaPuiQjDp51nN5Jgy2107qXWpkIX/tTwq63Gv2/pr7/IJ/cs1OUCNOgEju20rXp7eKPJ46XX/yjp2iBc9O4aC5uABGiTmW1u5CIMnl1CcAsjEPpWNr89aA3vYKbuEgFDt62UWC4Iny1TQWl9K+Ioc2bVX60zG0ySIhhif6Sbaob4eXAx3ccsVht7PXpeOFyfxoDmryPbjIw9iwyT6bFC3tRimnqDKlJ0aFl6AU3ToS91KTRmP02fvq65PXBVqYR6xVtyvZYGQVYeVppZxeM6SqpAMtXXiuL0tVFFix3XIerRQMWpJYGbZlMFq8cTK8XznfNh0N3Wqul8IjXMxC5fi40h+rqFRVB3jgZzuyoICf0LpG2cUxTu4JjSBcKPIsDgijrMU1Lo6TzTSWzlNVXjS5Bof63WFTBOPE9zjPAR30bXN8hDNsxGtvkVDx3f2au/UCK8iuYXsWuTORa4B+Pf4DzOm+aX67hZ8xJCrQMlhQZh4KWgOFzmziOoAfttF9gDXxBg2iLH9nkOaoz8DbbiZEf0S6ec/W5Pyj+KmPUylh9hNAEVj0hKP9+DNFWELaumxYnXtCZf/5S9cAXtv218oTzlq7Yj/edWhieS3Sd8B86FwX3eA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66556008)(64756008)(30864003)(66446008)(186003)(26005)(6512007)(33656002)(316002)(4326008)(86362001)(66946007)(6916009)(66476007)(54906003)(91956017)(76116006)(71200400001)(83380400001)(2906002)(8676002)(8936002)(508600001)(53546011)(38070700005)(6506007)(122000001)(38100700002)(36756003)(5660300002)(2616005)(41533002)(45980500001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cCfVKUuWN2pLF1q05Q4ApDwpwAbvYSwAnn8quJfgXBEHto8/5vZbcepw2dCd?=
 =?us-ascii?Q?/aYriF7S+GhA71J9xqXCl8TgOKYDyL3a6we2A5mCr9j9+ztvVeDtGDF1olxK?=
 =?us-ascii?Q?sE+/1hdFAqlWuCIoicGrPj5jUD8eNW2ru1JRuKeyv3SgXC+H2m5rwMwIdIcV?=
 =?us-ascii?Q?LrDHjbDvwffmu3dqrQpYf6i7HOnQsCt3xw6jYN+VCKo9SFLagFK/Z1B2DM2t?=
 =?us-ascii?Q?9BPW7ywjMrwgW6ZuqGsOznPkjpUroOhG/v17LhCQm+P/Z5+30TAmoD8NTn5V?=
 =?us-ascii?Q?Sik+omqE4ObUsRNb4zy4YN5+MtxpgZamArQA8OmTUepGwP3J9NWvuUTwg0v+?=
 =?us-ascii?Q?5OtFDvyoVFR5wc0SbPq0JIzb4IZpdUYpxRy+p58IHzkBi9QxdA2XKp656UKU?=
 =?us-ascii?Q?HtEgF8uE3DiUaHJJrF536FMmtTHyiKYzvLaaH3MoBkExokpeTPh8MYKEmKmy?=
 =?us-ascii?Q?De5fGZYkDM8rDWNiYM3lR58/J2jwks1zBK/Y6UmivkHPRAv9G8qnVhW69/id?=
 =?us-ascii?Q?AHUdUZDbn55BEM5w/GmkxhI8fcPwLVaxRJkVpSf5HhLbb7HqQmvQwyAKyXIr?=
 =?us-ascii?Q?WwPZpg1568S3Haaejy+es7bIcdEaQS7VxPVSLlWpfb6pdh3cO19rnup0jSwN?=
 =?us-ascii?Q?ZQHREtQd/OdNfrdg1wACJRrSEj/WjY+jmV7Z60zRnc/jH51pMG15q/GjyUTy?=
 =?us-ascii?Q?NF6Mh0epaxo6Vnhea9gsFp3cEx8PrXNI46QhaDt038ctFG2qpujURYD/7OqW?=
 =?us-ascii?Q?VXVQP0d4XwHUOm6Zqsx7x7+e38VG8srSl5a4JbXU5AsFF1gvI1gKnBzU/uel?=
 =?us-ascii?Q?JiZi2XpsQP0IRD4X1bbmGnNycB3YBKxhZ1SZHWRFD6Q34erlI9nHSRJJ2vcY?=
 =?us-ascii?Q?xSaTgdhs+T35ROaHFEv52hTN0qKW/WnmBBsskDChmUEXFJgV4G5Ppl2CPHmi?=
 =?us-ascii?Q?HpwYCuoHmWFqHa0uLJlHl7qAdU5gCfEZPecTs/X8OtEjeHdDpNA9QwR7Q7UX?=
 =?us-ascii?Q?RFr/ugMw5/Y5JLEC2TUO/3v3kYS2vNTy1c3viXFsrDFWN356XEfHLY5mzXyP?=
 =?us-ascii?Q?e9WE6hiYWsuw7LuLn6nzJ+xGLwNYc8pyQ8FmdvwBsihwMeug8vcRP1g1pQ4Z?=
 =?us-ascii?Q?XXfACu2i+f2HWFPtYZ52vxowvLv3v/TEXFnapwfsgvTFyxXuYeMdZ5aJOTPl?=
 =?us-ascii?Q?z9HYePPLmzFt0ArUgzcghuXF57WsZ2ekXyjyi6DAcbjebSfYvwFxrjGUMJMo?=
 =?us-ascii?Q?kU/M40qissR2pLmT269EezeQZJoGQWeJro7uqriAaqZzhXYSKHhr3sABRI50?=
 =?us-ascii?Q?4hYcinz+mkgSIcTVaQGwPZ5SvBpuPa861jzjdckAPk6iundssP9tBcr9CyYX?=
 =?us-ascii?Q?A+2y/NS5BTw0oblAsszFi1OAR5e7fAiu7latFXYo56FaHoorWUXSe2zMdvnE?=
 =?us-ascii?Q?0bRjPCXmxB/ydAvxOBAS/kUWPCFxzxwv?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3CD08D082ED0E4DAA040A9E12691001@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e81695-30dc-4368-c8a2-08d995906ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 19:16:19.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuck.lever@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2693
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220108
X-Proofpoint-ORIG-GUID: BcJpVGgdwHpkSK5IyA8akLjpae-Rv69e
X-Proofpoint-GUID: BcJpVGgdwHpkSK5IyA8akLjpae-Rv69e
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 22, 2021, at 3:14 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Oct 19, 2021 at 12:46 PM Chuck Lever <chuck.lever@oracle.com> wro=
te:
>>=20
>> Refactor: Surface useful show_ macros for use by other trace
>> subsystems.
>=20
> This doesn't apply on top of Trond's origin/testing. Are there some
> other dependencies I'm missing?

The patch applies on top of v5.15-rc6. What fails to apply?


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfs/nfs4trace.h        |   67 ++++++---------------
>> fs/nfs/nfstrace.h         |  118 +++++-------------------------------
>> include/trace/events/fs.h |  146 +++++++++++++++++++++++++++++++++++++++=
++++++
>> 3 files changed, 180 insertions(+), 151 deletions(-)
>> create mode 100644 include/trace/events/fs.h
>>=20
>> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
>> index 7a2567aa2b86..b2f45c825f37 100644
>> --- a/fs/nfs/nfs4trace.h
>> +++ b/fs/nfs/nfs4trace.h
>> @@ -10,6 +10,8 @@
>>=20
>> #include <linux/tracepoint.h>
>>=20
>> +#include <trace/events/fs.h>
>> +
>> TRACE_DEFINE_ENUM(EPERM);
>> TRACE_DEFINE_ENUM(ENOENT);
>> TRACE_DEFINE_ENUM(EIO);
>> @@ -313,19 +315,6 @@ TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
>>                { NFS4ERR_RESET_TO_MDS, "RESET_TO_MDS" }, \
>>                { NFS4ERR_RESET_TO_PNFS, "RESET_TO_PNFS" })
>>=20
>> -#define show_open_flags(flags) \
>> -       __print_flags(flags, "|", \
>> -               { O_CREAT, "O_CREAT" }, \
>> -               { O_EXCL, "O_EXCL" }, \
>> -               { O_TRUNC, "O_TRUNC" }, \
>> -               { O_DIRECT, "O_DIRECT" })
>> -
>> -#define show_fmode_flags(mode) \
>> -       __print_flags(mode, "|", \
>> -               { ((__force unsigned long)FMODE_READ), "READ" }, \
>> -               { ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
>> -               { ((__force unsigned long)FMODE_EXEC), "EXEC" })
>> -
>> #define show_nfs_fattr_flags(valid) \
>>        __print_flags((unsigned long)valid, "|", \
>>                { NFS_ATTR_FATTR_TYPE, "TYPE" }, \
>> @@ -793,8 +782,8 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
>>=20
>>                TP_STRUCT__entry(
>>                        __field(unsigned long, error)
>> -                       __field(unsigned int, flags)
>> -                       __field(unsigned int, fmode)
>> +                       __field(unsigned long, flags)
>> +                       __field(unsigned long, fmode)
>>                        __field(dev_t, dev)
>>                        __field(u32, fhandle)
>>                        __field(u64, fileid)
>> @@ -812,7 +801,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
>>=20
>>                        __entry->error =3D -error;
>>                        __entry->flags =3D flags;
>> -                       __entry->fmode =3D (__force unsigned int)ctx->mo=
de;
>> +                       __entry->fmode =3D (__force unsigned long)ctx->m=
ode;
>>                        __entry->dev =3D ctx->dentry->d_sb->s_dev;
>>                        if (!IS_ERR_OR_NULL(state)) {
>>                                inode =3D state->inode;
>> @@ -842,15 +831,15 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
>>                ),
>>=20
>>                TP_printk(
>> -                       "error=3D%ld (%s) flags=3D%d (%s) fmode=3D%s "
>> +                       "error=3D%ld (%s) flags=3D%lu (%s) fmode=3D%s "
>>                        "fileid=3D%02x:%02x:%llu fhandle=3D0x%08x "
>>                        "name=3D%02x:%02x:%llu/%s stateid=3D%d:0x%08x "
>>                        "openstateid=3D%d:0x%08x",
>>                         -__entry->error,
>>                         show_nfsv4_errors(__entry->error),
>>                         __entry->flags,
>> -                        show_open_flags(__entry->flags),
>> -                        show_fmode_flags(__entry->fmode),
>> +                        show_fs_fcntl_open_flags(__entry->flags),
>> +                        show_fs_fmode_flags(__entry->fmode),
>>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>>                         (unsigned long long)__entry->fileid,
>>                         __entry->fhandle,
>> @@ -904,7 +893,7 @@ TRACE_EVENT(nfs4_cached_open,
>>                TP_printk(
>>                        "fmode=3D%s fileid=3D%02x:%02x:%llu "
>>                        "fhandle=3D0x%08x stateid=3D%d:0x%08x",
>> -                       __entry->fmode ?  show_fmode_flags(__entry->fmod=
e) :
>> +                       __entry->fmode ?  show_fs_fmode_flags(__entry->f=
mode) :
>>                                          "closed",
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->fileid,
>> @@ -952,7 +941,7 @@ TRACE_EVENT(nfs4_close,
>>                        "fhandle=3D0x%08x openstateid=3D%d:0x%08x",
>>                        -__entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> -                       __entry->fmode ?  show_fmode_flags(__entry->fmod=
e) :
>> +                       __entry->fmode ?  show_fs_fmode_flags(__entry->f=
mode) :
>>                                          "closed",
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->fileid,
>> @@ -961,24 +950,6 @@ TRACE_EVENT(nfs4_close,
>>                )
>> );
>>=20
>> -TRACE_DEFINE_ENUM(F_GETLK);
>> -TRACE_DEFINE_ENUM(F_SETLK);
>> -TRACE_DEFINE_ENUM(F_SETLKW);
>> -TRACE_DEFINE_ENUM(F_RDLCK);
>> -TRACE_DEFINE_ENUM(F_WRLCK);
>> -TRACE_DEFINE_ENUM(F_UNLCK);
>> -
>> -#define show_lock_cmd(type) \
>> -       __print_symbolic((int)type, \
>> -               { F_GETLK, "GETLK" }, \
>> -               { F_SETLK, "SETLK" }, \
>> -               { F_SETLKW, "SETLKW" })
>> -#define show_lock_type(type) \
>> -       __print_symbolic((int)type, \
>> -               { F_RDLCK, "RDLCK" }, \
>> -               { F_WRLCK, "WRLCK" }, \
>> -               { F_UNLCK, "UNLCK" })
>> -
>> DECLARE_EVENT_CLASS(nfs4_lock_event,
>>                TP_PROTO(
>>                        const struct file_lock *request,
>> @@ -991,8 +962,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
>>=20
>>                TP_STRUCT__entry(
>>                        __field(unsigned long, error)
>> -                       __field(int, cmd)
>> -                       __field(char, type)
>> +                       __field(unsigned long, cmd)
>> +                       __field(unsigned long, type)
>>                        __field(loff_t, start)
>>                        __field(loff_t, end)
>>                        __field(dev_t, dev)
>> @@ -1025,8 +996,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
>>                        "stateid=3D%d:0x%08x",
>>                        -__entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> -                       show_lock_cmd(__entry->cmd),
>> -                       show_lock_type(__entry->type),
>> +                       show_fs_fcntl_cmd(__entry->cmd),
>> +                       show_fs_fcntl_lock_type(__entry->type),
>>                        (long long)__entry->start,
>>                        (long long)__entry->end,
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>> @@ -1061,8 +1032,8 @@ TRACE_EVENT(nfs4_set_lock,
>>=20
>>                TP_STRUCT__entry(
>>                        __field(unsigned long, error)
>> -                       __field(int, cmd)
>> -                       __field(char, type)
>> +                       __field(unsigned long, cmd)
>> +                       __field(unsigned long, type)
>>                        __field(loff_t, start)
>>                        __field(loff_t, end)
>>                        __field(dev_t, dev)
>> @@ -1101,8 +1072,8 @@ TRACE_EVENT(nfs4_set_lock,
>>                        "stateid=3D%d:0x%08x lockstateid=3D%d:0x%08x",
>>                        -__entry->error,
>>                        show_nfsv4_errors(__entry->error),
>> -                       show_lock_cmd(__entry->cmd),
>> -                       show_lock_type(__entry->type),
>> +                       show_fs_fcntl_cmd(__entry->cmd),
>> +                       show_fs_fcntl_lock_type(__entry->type),
>>                        (long long)__entry->start,
>>                        (long long)__entry->end,
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>> @@ -1219,7 +1190,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
>>=20
>>                TP_printk(
>>                        "fmode=3D%s fileid=3D%02x:%02x:%llu fhandle=3D0x%=
08x",
>> -                       show_fmode_flags(__entry->fmode),
>> +                       show_fs_fmode_flags(__entry->fmode),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->fileid,
>>                        __entry->fhandle
>> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
>> index 8a224871be74..49d432c00bde 100644
>> --- a/fs/nfs/nfstrace.h
>> +++ b/fs/nfs/nfstrace.h
>> @@ -11,27 +11,7 @@
>> #include <linux/tracepoint.h>
>> #include <linux/iversion.h>
>>=20
>> -TRACE_DEFINE_ENUM(DT_UNKNOWN);
>> -TRACE_DEFINE_ENUM(DT_FIFO);
>> -TRACE_DEFINE_ENUM(DT_CHR);
>> -TRACE_DEFINE_ENUM(DT_DIR);
>> -TRACE_DEFINE_ENUM(DT_BLK);
>> -TRACE_DEFINE_ENUM(DT_REG);
>> -TRACE_DEFINE_ENUM(DT_LNK);
>> -TRACE_DEFINE_ENUM(DT_SOCK);
>> -TRACE_DEFINE_ENUM(DT_WHT);
>> -
>> -#define nfs_show_file_type(ftype) \
>> -       __print_symbolic(ftype, \
>> -                       { DT_UNKNOWN, "UNKNOWN" }, \
>> -                       { DT_FIFO, "FIFO" }, \
>> -                       { DT_CHR, "CHR" }, \
>> -                       { DT_DIR, "DIR" }, \
>> -                       { DT_BLK, "BLK" }, \
>> -                       { DT_REG, "REG" }, \
>> -                       { DT_LNK, "LNK" }, \
>> -                       { DT_SOCK, "SOCK" }, \
>> -                       { DT_WHT, "WHT" })
>> +#include <trace/events/fs.h>
>>=20
>> TRACE_DEFINE_ENUM(NFS_INO_INVALID_DATA);
>> TRACE_DEFINE_ENUM(NFS_INO_INVALID_ATIME);
>> @@ -168,7 +148,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
>>                        (unsigned long long)__entry->fileid,
>>                        __entry->fhandle,
>>                        __entry->type,
>> -                       nfs_show_file_type(__entry->type),
>> +                       show_fs_dirent_type(__entry->type),
>>                        (unsigned long long)__entry->version,
>>                        (long long)__entry->size,
>>                        __entry->cache_validity,
>> @@ -259,7 +239,7 @@ TRACE_EVENT(nfs_access_exit,
>>                        (unsigned long long)__entry->fileid,
>>                        __entry->fhandle,
>>                        __entry->type,
>> -                       nfs_show_file_type(__entry->type),
>> +                       show_fs_dirent_type(__entry->type),
>>                        (unsigned long long)__entry->version,
>>                        (long long)__entry->size,
>>                        __entry->cache_validity,
>> @@ -270,34 +250,6 @@ TRACE_EVENT(nfs_access_exit,
>>                )
>> );
>>=20
>> -TRACE_DEFINE_ENUM(LOOKUP_FOLLOW);
>> -TRACE_DEFINE_ENUM(LOOKUP_DIRECTORY);
>> -TRACE_DEFINE_ENUM(LOOKUP_AUTOMOUNT);
>> -TRACE_DEFINE_ENUM(LOOKUP_PARENT);
>> -TRACE_DEFINE_ENUM(LOOKUP_REVAL);
>> -TRACE_DEFINE_ENUM(LOOKUP_RCU);
>> -TRACE_DEFINE_ENUM(LOOKUP_OPEN);
>> -TRACE_DEFINE_ENUM(LOOKUP_CREATE);
>> -TRACE_DEFINE_ENUM(LOOKUP_EXCL);
>> -TRACE_DEFINE_ENUM(LOOKUP_RENAME_TARGET);
>> -TRACE_DEFINE_ENUM(LOOKUP_EMPTY);
>> -TRACE_DEFINE_ENUM(LOOKUP_DOWN);
>> -
>> -#define show_lookup_flags(flags) \
>> -       __print_flags(flags, "|", \
>> -                       { LOOKUP_FOLLOW, "FOLLOW" }, \
>> -                       { LOOKUP_DIRECTORY, "DIRECTORY" }, \
>> -                       { LOOKUP_AUTOMOUNT, "AUTOMOUNT" }, \
>> -                       { LOOKUP_PARENT, "PARENT" }, \
>> -                       { LOOKUP_REVAL, "REVAL" }, \
>> -                       { LOOKUP_RCU, "RCU" }, \
>> -                       { LOOKUP_OPEN, "OPEN" }, \
>> -                       { LOOKUP_CREATE, "CREATE" }, \
>> -                       { LOOKUP_EXCL, "EXCL" }, \
>> -                       { LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
>> -                       { LOOKUP_EMPTY, "EMPTY" }, \
>> -                       { LOOKUP_DOWN, "DOWN" })
>> -
>> DECLARE_EVENT_CLASS(nfs_lookup_event,
>>                TP_PROTO(
>>                        const struct inode *dir,
>> @@ -324,7 +276,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
>>                TP_printk(
>>                        "flags=3D0x%lx (%s) name=3D%02x:%02x:%llu/%s",
>>                        __entry->flags,
>> -                       show_lookup_flags(__entry->flags),
>> +                       show_fs_lookup_flags(__entry->flags),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->dir,
>>                        __get_str(name)
>> @@ -370,7 +322,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
>>                        "error=3D%ld (%s) flags=3D0x%lx (%s) name=3D%02x:=
%02x:%llu/%s",
>>                        -__entry->error, nfs_show_status(__entry->error),
>>                        __entry->flags,
>> -                       show_lookup_flags(__entry->flags),
>> +                       show_fs_lookup_flags(__entry->flags),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->dir,
>>                        __get_str(name)
>> @@ -392,46 +344,6 @@ DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
>> DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
>> DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
>>=20
>> -TRACE_DEFINE_ENUM(O_WRONLY);
>> -TRACE_DEFINE_ENUM(O_RDWR);
>> -TRACE_DEFINE_ENUM(O_CREAT);
>> -TRACE_DEFINE_ENUM(O_EXCL);
>> -TRACE_DEFINE_ENUM(O_NOCTTY);
>> -TRACE_DEFINE_ENUM(O_TRUNC);
>> -TRACE_DEFINE_ENUM(O_APPEND);
>> -TRACE_DEFINE_ENUM(O_NONBLOCK);
>> -TRACE_DEFINE_ENUM(O_DSYNC);
>> -TRACE_DEFINE_ENUM(O_DIRECT);
>> -TRACE_DEFINE_ENUM(O_LARGEFILE);
>> -TRACE_DEFINE_ENUM(O_DIRECTORY);
>> -TRACE_DEFINE_ENUM(O_NOFOLLOW);
>> -TRACE_DEFINE_ENUM(O_NOATIME);
>> -TRACE_DEFINE_ENUM(O_CLOEXEC);
>> -
>> -#define show_open_flags(flags) \
>> -       __print_flags(flags, "|", \
>> -               { O_WRONLY, "O_WRONLY" }, \
>> -               { O_RDWR, "O_RDWR" }, \
>> -               { O_CREAT, "O_CREAT" }, \
>> -               { O_EXCL, "O_EXCL" }, \
>> -               { O_NOCTTY, "O_NOCTTY" }, \
>> -               { O_TRUNC, "O_TRUNC" }, \
>> -               { O_APPEND, "O_APPEND" }, \
>> -               { O_NONBLOCK, "O_NONBLOCK" }, \
>> -               { O_DSYNC, "O_DSYNC" }, \
>> -               { O_DIRECT, "O_DIRECT" }, \
>> -               { O_LARGEFILE, "O_LARGEFILE" }, \
>> -               { O_DIRECTORY, "O_DIRECTORY" }, \
>> -               { O_NOFOLLOW, "O_NOFOLLOW" }, \
>> -               { O_NOATIME, "O_NOATIME" }, \
>> -               { O_CLOEXEC, "O_CLOEXEC" })
>> -
>> -#define show_fmode_flags(mode) \
>> -       __print_flags(mode, "|", \
>> -               { ((__force unsigned long)FMODE_READ), "READ" }, \
>> -               { ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
>> -               { ((__force unsigned long)FMODE_EXEC), "EXEC" })
>> -
>> TRACE_EVENT(nfs_atomic_open_enter,
>>                TP_PROTO(
>>                        const struct inode *dir,
>> @@ -443,7 +355,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
>>=20
>>                TP_STRUCT__entry(
>>                        __field(unsigned long, flags)
>> -                       __field(unsigned int, fmode)
>> +                       __field(unsigned long, fmode)
>>                        __field(dev_t, dev)
>>                        __field(u64, dir)
>>                        __string(name, ctx->dentry->d_name.name)
>> @@ -453,15 +365,15 @@ TRACE_EVENT(nfs_atomic_open_enter,
>>                        __entry->dev =3D dir->i_sb->s_dev;
>>                        __entry->dir =3D NFS_FILEID(dir);
>>                        __entry->flags =3D flags;
>> -                       __entry->fmode =3D (__force unsigned int)ctx->mo=
de;
>> +                       __entry->fmode =3D (__force unsigned long)ctx->m=
ode;
>>                        __assign_str(name, ctx->dentry->d_name.name);
>>                ),
>>=20
>>                TP_printk(
>>                        "flags=3D0x%lx (%s) fmode=3D%s name=3D%02x:%02x:%=
llu/%s",
>>                        __entry->flags,
>> -                       show_open_flags(__entry->flags),
>> -                       show_fmode_flags(__entry->fmode),
>> +                       show_fs_fcntl_open_flags(__entry->flags),
>> +                       show_fs_fmode_flags(__entry->fmode),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->dir,
>>                        __get_str(name)
>> @@ -481,7 +393,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
>>                TP_STRUCT__entry(
>>                        __field(unsigned long, error)
>>                        __field(unsigned long, flags)
>> -                       __field(unsigned int, fmode)
>> +                       __field(unsigned long, fmode)
>>                        __field(dev_t, dev)
>>                        __field(u64, dir)
>>                        __string(name, ctx->dentry->d_name.name)
>> @@ -492,7 +404,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
>>                        __entry->dev =3D dir->i_sb->s_dev;
>>                        __entry->dir =3D NFS_FILEID(dir);
>>                        __entry->flags =3D flags;
>> -                       __entry->fmode =3D (__force unsigned int)ctx->mo=
de;
>> +                       __entry->fmode =3D (__force unsigned long)ctx->m=
ode;
>>                        __assign_str(name, ctx->dentry->d_name.name);
>>                ),
>>=20
>> @@ -501,8 +413,8 @@ TRACE_EVENT(nfs_atomic_open_exit,
>>                        "name=3D%02x:%02x:%llu/%s",
>>                        -__entry->error, nfs_show_status(__entry->error),
>>                        __entry->flags,
>> -                       show_open_flags(__entry->flags),
>> -                       show_fmode_flags(__entry->fmode),
>> +                       show_fs_fcntl_open_flags(__entry->flags),
>> +                       show_fs_fmode_flags(__entry->fmode),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->dir,
>>                        __get_str(name)
>> @@ -535,7 +447,7 @@ TRACE_EVENT(nfs_create_enter,
>>                TP_printk(
>>                        "flags=3D0x%lx (%s) name=3D%02x:%02x:%llu/%s",
>>                        __entry->flags,
>> -                       show_open_flags(__entry->flags),
>> +                       show_fs_fcntl_open_flags(__entry->flags),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->dir,
>>                        __get_str(name)
>> @@ -572,7 +484,7 @@ TRACE_EVENT(nfs_create_exit,
>>                        "error=3D%ld (%s) flags=3D0x%lx (%s) name=3D%02x:=
%02x:%llu/%s",
>>                        -__entry->error, nfs_show_status(__entry->error),
>>                        __entry->flags,
>> -                       show_open_flags(__entry->flags),
>> +                       show_fs_fcntl_open_flags(__entry->flags),
>>                        MAJOR(__entry->dev), MINOR(__entry->dev),
>>                        (unsigned long long)__entry->dir,
>>                        __get_str(name)
>> diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
>> new file mode 100644
>> index 000000000000..84e20c43d0c3
>> --- /dev/null
>> +++ b/include/trace/events/fs.h
>> @@ -0,0 +1,146 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Display helpers for generic filesystem items
>> + *
>> + * Author: Chuck Lever <chuck.lever@oracle.com>
>> + *
>> + * Copyright (c) 2020, Oracle and/or its affiliates.
>> + */
>> +
>> +#include <linux/fs.h>
>> +
>> +#define show_fs_dirent_type(x) \
>> +       __print_symbolic(x, \
>> +               { DT_UNKNOWN,           "UNKNOWN" }, \
>> +               { DT_FIFO,              "FIFO" }, \
>> +               { DT_CHR,               "CHR" }, \
>> +               { DT_DIR,               "DIR" }, \
>> +               { DT_BLK,               "BLK" }, \
>> +               { DT_REG,               "REG" }, \
>> +               { DT_LNK,               "LNK" }, \
>> +               { DT_SOCK,              "SOCK" }, \
>> +               { DT_WHT,               "WHT" })
>> +
>> +#define show_fs_fcntl_open_flags(x) \
>> +       __print_flags(x, "|", \
>> +               { O_WRONLY,             "O_WRONLY" }, \
>> +               { O_RDWR,               "O_RDWR" }, \
>> +               { O_CREAT,              "O_CREAT" }, \
>> +               { O_EXCL,               "O_EXCL" }, \
>> +               { O_NOCTTY,             "O_NOCTTY" }, \
>> +               { O_TRUNC,              "O_TRUNC" }, \
>> +               { O_APPEND,             "O_APPEND" }, \
>> +               { O_NONBLOCK,           "O_NONBLOCK" }, \
>> +               { O_DSYNC,              "O_DSYNC" }, \
>> +               { O_DIRECT,             "O_DIRECT" }, \
>> +               { O_LARGEFILE,          "O_LARGEFILE" }, \
>> +               { O_DIRECTORY,          "O_DIRECTORY" }, \
>> +               { O_NOFOLLOW,           "O_NOFOLLOW" }, \
>> +               { O_NOATIME,            "O_NOATIME" }, \
>> +               { O_CLOEXEC,            "O_CLOEXEC" })
>> +
>> +#define __fmode_flag(x)        { (__force unsigned long)FMODE_##x, #x }
>> +#define show_fs_fmode_flags(x) \
>> +       __print_flags(x, "|", \
>> +               __fmode_flag(READ), \
>> +               __fmode_flag(WRITE), \
>> +               __fmode_flag(LSEEK), \
>> +               __fmode_flag(PREAD), \
>> +               __fmode_flag(PWRITE), \
>> +               __fmode_flag(EXEC), \
>> +               __fmode_flag(NDELAY), \
>> +               __fmode_flag(EXCL), \
>> +               __fmode_flag(WRITE_IOCTL), \
>> +               __fmode_flag(32BITHASH), \
>> +               __fmode_flag(64BITHASH), \
>> +               __fmode_flag(NOCMTIME), \
>> +               __fmode_flag(RANDOM), \
>> +               __fmode_flag(UNSIGNED_OFFSET), \
>> +               __fmode_flag(PATH), \
>> +               __fmode_flag(ATOMIC_POS), \
>> +               __fmode_flag(WRITER), \
>> +               __fmode_flag(CAN_READ), \
>> +               __fmode_flag(CAN_WRITE), \
>> +               __fmode_flag(OPENED), \
>> +               __fmode_flag(CREATED), \
>> +               __fmode_flag(STREAM), \
>> +               __fmode_flag(NONOTIFY), \
>> +               __fmode_flag(NOWAIT), \
>> +               __fmode_flag(NEED_UNMOUNT), \
>> +               __fmode_flag(NOACCOUNT), \
>> +               __fmode_flag(BUF_RASYNC))
>> +
>> +#ifdef CONFIG_64BIT
>> +#define show_fs_fcntl_cmd(x) \
>> +       __print_symbolic(x, \
>> +               { F_DUPFD,              "DUPFD" }, \
>> +               { F_GETFD,              "GETFD" }, \
>> +               { F_SETFD,              "SETFD" }, \
>> +               { F_GETFL,              "GETFL" }, \
>> +               { F_SETFL,              "SETFL" }, \
>> +               { F_GETLK,              "GETLK" }, \
>> +               { F_SETLK,              "SETLK" }, \
>> +               { F_SETLKW,             "SETLKW" }, \
>> +               { F_SETOWN,             "SETOWN" }, \
>> +               { F_GETOWN,             "GETOWN" }, \
>> +               { F_SETSIG,             "SETSIG" }, \
>> +               { F_GETSIG,             "GETSIG" }, \
>> +               { F_SETOWN_EX,          "SETOWN_EX" }, \
>> +               { F_GETOWN_EX,          "GETOWN_EX" }, \
>> +               { F_GETOWNER_UIDS,      "GETOWNER_UIDS" }, \
>> +               { F_OFD_GETLK,          "OFD_GETLK" }, \
>> +               { F_OFD_SETLK,          "OFD_SETLK" }, \
>> +               { F_OFD_SETLKW,         "OFD_SETLKW" })
>> +#else /* CONFIG_64BIT */
>> +#define show_fs_fcntl_cmd(x) \
>> +       __print_symbolic(x, \
>> +               { F_DUPFD,              "DUPFD" }, \
>> +               { F_GETFD,              "GETFD" }, \
>> +               { F_SETFD,              "SETFD" }, \
>> +               { F_GETFL,              "GETFL" }, \
>> +               { F_SETFL,              "SETFL" }, \
>> +               { F_GETLK,              "GETLK" }, \
>> +               { F_SETLK,              "SETLK" }, \
>> +               { F_SETLKW,             "SETLKW" }, \
>> +               { F_SETOWN,             "SETOWN" }, \
>> +               { F_GETOWN,             "GETOWN" }, \
>> +               { F_SETSIG,             "SETSIG" }, \
>> +               { F_GETSIG,             "GETSIG" }, \
>> +               { F_GETLK64,            "GETLK64" }, \
>> +               { F_SETLK64,            "SETLK64" }, \
>> +               { F_SETLKW64,           "SETLKW64" }, \
>> +               { F_SETOWN_EX,          "SETOWN_EX" }, \
>> +               { F_GETOWN_EX,          "GETOWN_EX" }, \
>> +               { F_GETOWNER_UIDS,      "GETOWNER_UIDS" }, \
>> +               { F_OFD_GETLK,          "OFD_GETLK" }, \
>> +               { F_OFD_SETLK,          "OFD_SETLK" }, \
>> +               { F_OFD_SETLKW,         "OFD_SETLKW" })
>> +#endif /* CONFIG_64BIT */
>> +
>> +#define show_fs_fcntl_lock_type(x) \
>> +       __print_symbolic(x, \
>> +               { F_RDLCK,              "RDLCK" }, \
>> +               { F_WRLCK,              "WRLCK" }, \
>> +               { F_UNLCK,              "UNLCK" })
>> +
>> +#define show_fs_lookup_flags(flags) \
>> +       __print_flags(flags, "|", \
>> +               { LOOKUP_FOLLOW,        "FOLLOW" }, \
>> +               { LOOKUP_DIRECTORY,     "DIRECTORY" }, \
>> +               { LOOKUP_AUTOMOUNT,     "AUTOMOUNT" }, \
>> +               { LOOKUP_EMPTY,         "EMPTY" }, \
>> +               { LOOKUP_DOWN,          "DOWN" }, \
>> +               { LOOKUP_MOUNTPOINT,    "MOUNTPOINT" }, \
>> +               { LOOKUP_REVAL,         "REVAL" }, \
>> +               { LOOKUP_RCU,           "RCU" }, \
>> +               { LOOKUP_OPEN,          "OPEN" }, \
>> +               { LOOKUP_CREATE,        "CREATE" }, \
>> +               { LOOKUP_EXCL,          "EXCL" }, \
>> +               { LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
>> +               { LOOKUP_PARENT,        "PARENT" }, \
>> +               { LOOKUP_NO_SYMLINKS,   "NO_SYMLINKS" }, \
>> +               { LOOKUP_NO_MAGICLINKS, "NO_MAGICLINKS" }, \
>> +               { LOOKUP_NO_XDEV,       "NO_XDEV" }, \
>> +               { LOOKUP_BENEATH,       "BENEATH" }, \
>> +               { LOOKUP_IN_ROOT,       "IN_ROOT" }, \
>> +               { LOOKUP_CACHED,        "CACHED" })
>>=20

--
Chuck Lever



