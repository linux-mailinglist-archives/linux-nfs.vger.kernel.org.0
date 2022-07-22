Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924E757E6FF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiGVTFv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 15:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiGVTFt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 15:05:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABE0A8970
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 12:05:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MIYQ4Y011279;
        Fri, 22 Jul 2022 19:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Dhp5RE0hmwfSIWCLp8lmeIY3GzvY5wPQqkVItNHr4CA=;
 b=Elyv3XcITLw2U+z5VdeFwheogXTXSrykbq7AMbHHnwrN4aYFtPHPN08ixda4O+HppKaR
 QKG9n9khKXoh3NJs1QJleoHm0EzVwBK2LnNUt1bbfVH1lEq0TzzxjYTnp563tr/l7vqb
 rIge/yA2K19Laz/ch6LK0bcIytbGJbjmDfYVpctRNZuii36Eky8HKXd21j+ziTNNFdwr
 AgM33VBnBiNj3bea899oRJdIIldjY9Yt97Ku/9B48lJnhQyJN8ycPWVWj336s6KoyHqW
 px4v081IZ7335T/Hl3QwO1yDn47Tg4XLCVLl33ctYH4+jA7Y1qY536yPh4URfo7dUoO0 ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx18bfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 19:05:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MIeiD6022175;
        Fri, 22 Jul 2022 19:05:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hvfjg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 19:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFi74HNnf9smdlMTtM4ilyRe1r53iBgnXYAcan3om9//LrnYoQhi+LE3hQBUGQthKLHLZ+qyZZcJfGYAxW4zywdgwIYKT/4HXzzGcW16osESpMPEskCGqvHUNaX04CXK8V3QSVi2m716ex2ZmwTpZ4bNhNerr3yYynToF/2fiSvMx6NsaxZJcyBzXRevof3rEYdrvvIge/Ov1kaXbfEu+v/P0Z8lec4hiTESxTL052DdOUXlq8vC+A+jmORqVqyfQmP+gmyJMJ3IlbERVlt/yhvpa7RUeunlLS9wY2tdE42PLKYn+9CB0LUozCwHZ99g6/zuZK+u06G2kA5eDfuDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhp5RE0hmwfSIWCLp8lmeIY3GzvY5wPQqkVItNHr4CA=;
 b=jmelf2SdjYNj2idlC45HSjwOq8bww2GiUy2aslHRsWt6IC7Y2C8ZF4R6WS8MhCoOWhGWW5vK7uEfJWhWpgfprZS8ONlfjgDvu2nx+kmsP3MTTXI8o4EQZX/fGKJZ/bMw3sVHb0E+GDd1MSswGU0VrBbdBaOoWivIB6CtvwFyR929dcRhmCJiYWnRNgfm5QKkW1eBAmhY4bzZTzxxlYcWcuQ8VPm2S1RxCRf19uJqJtGmCi5r22RuqkWJRei0tFIkLr1cxAXWsve/autJxP9eRSAruGhaQY6gkbymEDbURnFErOQBJUpm9zwKJkEoEpSR+qWpeV9pSFxrJKfb44P72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhp5RE0hmwfSIWCLp8lmeIY3GzvY5wPQqkVItNHr4CA=;
 b=xr0sC1gfi4c50gtAYzLjT2DpWOK/i9hXOP8uFfw7bHghQ7gcRdJ1L4r9sd4sv6XXLS6+vPpnZaUfXwza2WjIVSYsEiVhIFDgWedPjwDmmzi0OOCJtk430nlv/WFQkumquXftnNUTydihNLBv45eoEYrpV562mKtM4STNfJfO9Dc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2901.namprd10.prod.outlook.com (2603:10b6:a03:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Fri, 22 Jul
 2022 19:05:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 19:05:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] NFS: Replace fs_context-related dprintk() call sites
 with tracepoints
Thread-Topic: [PATCH 4/4] NFS: Replace fs_context-related dprintk() call sites
 with tracepoints
Thread-Index: AQHYnfAc4RwX/1fEQ0GbxKTZkoqbKq2Krh0AgAASFYA=
Date:   Fri, 22 Jul 2022 19:05:41 +0000
Message-ID: <1B48C0CA-835D-423E-92F4-5C69FE4849A3@oracle.com>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
 <165851074904.361126.11450659589753012982.stgit@morisot.1015granger.net>
 <a4e1c7e1f6229de8fcf0160fba68b4217e7ba82c.camel@hammerspace.com>
In-Reply-To: <a4e1c7e1f6229de8fcf0160fba68b4217e7ba82c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b3dce35-c4b8-47f8-3977-08da6c152c11
x-ms-traffictypediagnostic: BYAPR10MB2901:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hsXLnpWZLO+n2rtfPmhbeFWxawpUTqxC8GaK+hgv6DS3jKmxwgssbUCYWj8woZqOmG5r6mlrsS+PhJYhffhi5ThypYd+7JxMfUrRidUDaDCapsXCWhvq6ptwqKeFH8oKns+vEKfGmXOhU7FvxG9a4mZsRH9nim/5piQrCr35FDwVbxmoRq4wg6Il3vf2nB4YnwM1pPCWSQtNjtQVUsqP3d6DDa4YfXfk+LKxEe/r+rnt+zhnhHJMkja4MOuSrSkVmeNohx8iygtY3NsEN3ZKT1iVKnyaFWZHRAvm1eCxnRyVQx6dH6gxslqoROqsb63NyKU4eBSAd6S1OB6T9tvrK/MMFC3OGuYKzBCBxt1ygAVcVgzKRdm0dmVs6ZCvEcBy3nWa8wBuAYzwD5HOgsdw2gmgu4lnNupH/LllHQoiT59mAXvtSOPhChkqdcpjUPMK38gcx13JPSr8sMuj4A5gLNHaeVzUlKPEYDO68AYTz5z6VYJ7b+AAaYYbCsqtIlRSdLBciFOOzlEfh8+u6lrr1NCJllYslrULZkLoD9s8U5hhAafoLnyXqlVsBmaMgXYIuXhYJFl2sFNNe+Z1bkiN2wg/wHQyO0hm2LvW+DRANpattRH7XUb4N+WAIjnvaPJdJfIvklQJddvInRxqeu4570r1yXF7JMIHN5RUo/sT8C7YeUkfJhx4rLG384vW2VuUT67fm4BHpk+2VhHUWExJRX5CDQvyX/85hhEDdYp90/tdHVOHaHAp7TQPDdyhLe41exTi3VIkR1GctXb0g4sI3fAKYWeMnV5hMLvfpqX0JeSCcoSFnxRYKJPJntDoTNUd4cEJYBGOAknj4Ck1bDNHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(366004)(376002)(71200400001)(316002)(41300700001)(478600001)(53546011)(54906003)(26005)(6512007)(122000001)(36756003)(6486002)(83380400001)(38070700005)(4326008)(8936002)(6506007)(33656002)(86362001)(2616005)(5660300002)(2906002)(66946007)(66446008)(91956017)(76116006)(64756008)(186003)(8676002)(38100700002)(66476007)(6916009)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?arHeF5TU6ux4qPtXxKPJGgixpOlp9KhGkDHcWL20eshnstyQ6P53n64pAZ2d?=
 =?us-ascii?Q?VN7SqUwGcevv+IvwlwaFgMUlkhBsACTvhIoI+zKMqVDo4jTV3mMbTjggeJiZ?=
 =?us-ascii?Q?PU3WlrmIaVOrPYN5mcxV+i2meLGj20zwAW8kMYTegvzvPrA0n+PGRbXghqxd?=
 =?us-ascii?Q?ynn2oZ62BjTW+uIqZvSm4l7RiLuRvWtt3tY1pESmi/XIKsBbeQ/5OzMj7twJ?=
 =?us-ascii?Q?4Vw3QhC2JjER/gnHnuxFPmw5bo+mc16SXK9tZQxD1TcpnbF9CL+mEqAgQ0Vf?=
 =?us-ascii?Q?kjTZPvI8q6pfXM9N4VRGx0qjlOPYIE0gO5SemkaHnLitrFmIfhfTs0sc8L1C?=
 =?us-ascii?Q?WahaoFN2vzmbt/ADFLCHk6P8Alb1CmqHBQ3kCE1xyA9bLlMg9s3mJM4b1k0Q?=
 =?us-ascii?Q?PU3OIWfMHa7TTaPs3iE0v9ph37Abc6ixJoouJ0bYqiyO/+Xx0NtuxDx3nkT9?=
 =?us-ascii?Q?aAXIBZ7Mqm4uN3vF2/Z7yd5EwpIXabQt/6PZtPuzzO3wNPnevQnG/C8MKqfl?=
 =?us-ascii?Q?TNQy8UoCEFfx1IbaMdqgUOYZQSkQ54xFkFDfTI37hOjsTkRfp8mX0UADCHD9?=
 =?us-ascii?Q?v9W5uKCtFDDnMxgCN5a3OxqMZLl19/p1esnymrez3A2VCyrwoSQMncCM3hbQ?=
 =?us-ascii?Q?OkjOht+njN61gD196xXU7nJ4XuSqNXvKOoC8NYw6sFu6NZEFM5yKdLe3zqJ+?=
 =?us-ascii?Q?U4VrxvMLDaLBIHfzv55MuB0mSb9KpqA2cJHGU1dlNKUpt1NWiu5Ru3CjqKVR?=
 =?us-ascii?Q?FIcOjSCQPnfsAhKAFBBUNqaFrtgKTmQGJnOcKMgOvzmwVVcNpEZ5nYcEz7sa?=
 =?us-ascii?Q?XS/pXOTx+P2C2gC/wc0u0E/wN/9byAjgni5kBRTI4zJUjRIOhXnDHwvWCBAW?=
 =?us-ascii?Q?ir+WoMfWrW5m/XRAI4L+0sKLxhn+ikm7MR+dL/U0YLPHsFw59hCAWCaOLqZB?=
 =?us-ascii?Q?Y1izMzb8Hxv0x3332l2auZxwJr9XTFQPH+mgwexYYKNLt4I6S3ja5CcC06lq?=
 =?us-ascii?Q?ZJ2jpPOCqTe8awP/ShZ3l/4NBRmyX325S/mNqJyWVzdZ3HBDv1JjXWz4ifYE?=
 =?us-ascii?Q?GDwwddBn85O7MaphIVSlwu+OUDPioyU1dLUNvqnudaWlR+4qIzs4tsTHz0j6?=
 =?us-ascii?Q?MRAcD8hKT4fpJwjzgJo70BV7lDTqvh7585Rt5chi8EPTdBSxl1yDmq15ehjT?=
 =?us-ascii?Q?QUvvtNARdaWmkrMgIHBMVki1TCAh7u2+2z8fH/Dlq7ISnblnC8osSvePB2Ao?=
 =?us-ascii?Q?Ns2IqwJnmeyHZOZFSa8MJU91f+tWovFdEyWeHybgA9Vi8E4vjUlPaq9iV6Jq?=
 =?us-ascii?Q?PgZNq/wqE18ypPzPj1XHSGQFzNdhv7OAzfOyv/I8XUOI4PGtP79z9W4niznR?=
 =?us-ascii?Q?BZ88Qn/Ys0KH6cjnjKXSfpF+FW7ojhr5PK7iz95FXOhqiPIGCZm8Fwj7TbJI?=
 =?us-ascii?Q?YSIn56zLPAnc2D+44M5uwRSGryxgLcoAYp6fH3nqaudYID3EjKr8deFv57fJ?=
 =?us-ascii?Q?ZSPQJM6v824l5ZmnchEQorV9RUVtfDdD9YivBl/oyVnd+CYGqyO9ZSnhDjDM?=
 =?us-ascii?Q?Us0hi4ooR0U3CRO+ddyNF66cC8/gRWHbxawEzQB7uEyuISOvZPfwuyxVGsW0?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56B263C27802DA4288A0488418668C1D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3dce35-c4b8-47f8-3977-08da6c152c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 19:05:41.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtL8R7V3Mrl+QX6fW7zaTjVMTvlMqQylgRCmgkUCTZtKUVsHVYSYmQX6B9S5Bk23rwdzhfj9RN/M3EwffEBGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220078
X-Proofpoint-GUID: SdjCUAhBwAuYNbqq0e4BDoTbWwztnaSf
X-Proofpoint-ORIG-GUID: SdjCUAhBwAuYNbqq0e4BDoTbWwztnaSf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 22, 2022, at 2:00 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2022-07-22 at 13:25 -0400, Chuck Lever wrote:
>> Contributed as part of the long patch series that converts NFS from
>> using dprintk to tracepoints for observability.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfs/fs_context.c |  25 ++++++++++-------
>> fs/nfs/nfstrace.h  |  77
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 92 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>> index 9a16897e8dc6..35e400a557b9 100644
>> --- a/fs/nfs/fs_context.c
>> +++ b/fs/nfs/fs_context.c
>> @@ -21,6 +21,8 @@
>> #include "nfs.h"
>> #include "internal.h"
>>=20
>> +#include "nfstrace.h"
>> +
>> #define NFSDBG_FACILITY  NFSDBG_MOUNT
>>=20
>> #if IS_ENABLED(CONFIG_NFS_V3)
>> @@ -284,7 +286,7 @@ static int nfs_verify_server_address(struct
>> sockaddr *addr)
>> }
>> }
>>=20
>> -  dfprintk(MOUNT, "NFS: Invalid IP address specified\n");
>> +  trace_nfs_mount_addr_err(addr);
>> return 0;
>> }
>>=20
>> @@ -378,7 +380,7 @@ static int nfs_parse_security_flavors(struct
>> fs_context *fc,
>> char *string =3D param->string, *p;
>> int ret;
>>=20
>> -  dfprintk(MOUNT, "NFS: parsing %s=3D%s option\n", param->key,
>> param->string);
>> +  trace_nfs_mount_assign(param->key, string);
>>=20
>> while ((p =3D strsep(&string, ":")) !=3D NULL) {
>> if (!*p)
>> @@ -480,7 +482,7 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>> unsigned int len;
>> int ret, opt;
>>=20
>> -  dfprintk(MOUNT, "NFS:  parsing nfs mount option '%s'\n",
>> param->key);
>> +  trace_nfs_mount_option(param);
>>=20
>> opt =3D fs_parse(fc, nfs_fs_parameters, param, &result);
>> if (opt < 0)
>> @@ -683,6 +685,7 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>> return ret;
>> break;
>> case Opt_vers:
>> +  trace_nfs_mount_assign(param->key, param->string);
>> ret =3D nfs_parse_version_string(fc, param->string);
>> if (ret < 0)
>> return ret;
>> @@ -694,6 +697,7 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>> break;
>>=20
>> case Opt_proto:
>> +  trace_nfs_mount_assign(param->key, param->string);
>> protofamily =3D AF_INET;
>> switch (lookup_constant(nfs_xprt_protocol_tokens,
>> param->string, -1)) {
>> case Opt_xprt_udp6:
>> @@ -729,6 +733,7 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>> break;
>>=20
>> case Opt_mountproto:
>> +  trace_nfs_mount_assign(param->key, param->string);
>> mountfamily =3D AF_INET;
>> switch (lookup_constant(nfs_xprt_protocol_tokens,
>> param->string, -1)) {
>> case Opt_xprt_udp6:
>> @@ -751,6 +756,7 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>> break;
>>=20
>> case Opt_addr:
>> +  trace_nfs_mount_assign(param->key, param->string);
>> len =3D rpc_pton(fc->net_ns, param->string, param-
>>> size,
>> &ctx->nfs_server.address,
>> sizeof(ctx->nfs_server._address));
>> @@ -759,16 +765,19 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>> ctx->nfs_server.addrlen =3D len;
>> break;
>> case Opt_clientaddr:
>> +  trace_nfs_mount_assign(param->key, param->string);
>> kfree(ctx->client_address);
>> ctx->client_address =3D param->string;
>> param->string =3D NULL;
>> break;
>> case Opt_mounthost:
>> +  trace_nfs_mount_assign(param->key, param->string);
>> kfree(ctx->mount_server.hostname);
>> ctx->mount_server.hostname =3D param->string;
>> param->string =3D NULL;
>> break;
>> case Opt_mountaddr:
>> +  trace_nfs_mount_assign(param->key, param->string);
>> len =3D rpc_pton(fc->net_ns, param->string, param-
>>> size,
>> &ctx->mount_server.address,
>> sizeof(ctx->mount_server._address));
>> @@ -846,7 +855,6 @@ static int nfs_fs_context_parse_param(struct
>> fs_context *fc,
>> */
>> case Opt_sloppy:
>> ctx->sloppy =3D true;
>> -  dfprintk(MOUNT, "NFS:  relaxing parsing rules\n");
>> break;
>> }
>>=20
>> @@ -879,10 +887,8 @@ static int nfs_parse_source(struct fs_context
>> *fc,
>> size_t len;
>> const char *end;
>>=20
>> -  if (unlikely(!dev_name || !*dev_name)) {
>> -  dfprintk(MOUNT, "NFS: device name not specified\n");
>> +  if (unlikely(!dev_name || !*dev_name))
>> return -EINVAL;
>> -  }
>>=20
>> /* Is the host name protected with square brakcets? */
>> if (*dev_name =3D=3D '[') {
>> @@ -922,7 +928,7 @@ static int nfs_parse_source(struct fs_context
>> *fc,
>> if (!ctx->nfs_server.export_path)
>> goto out_nomem;
>>=20
>> -  dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", ctx-
>>> nfs_server.export_path);
>> +  trace_nfs_mount_path(ctx->nfs_server.export_path);
>> return 0;
>>=20
>> out_bad_devname:
>> @@ -1116,7 +1122,6 @@ static int nfs23_parse_monolithic(struct
>> fs_context *fc,
>> return nfs_invalf(fc, "NFS: nfs_mount_data version supports
>> only AUTH_SYS");
>>=20
>> out_nomem:
>> -  dfprintk(MOUNT, "NFS: not enough memory to handle mount
>> options");
>> return -ENOMEM;
>>=20
>> out_no_address:
>> @@ -1248,7 +1253,7 @@ static int nfs4_parse_monolithic(struct
>> fs_context *fc,
>> if (IS_ERR(c))
>> return PTR_ERR(c);
>> ctx->nfs_server.export_path =3D c;
>> -  dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
>> +  trace_nfs_mount_path(c);
>>=20
>> c =3D strndup_user(data->client_addr.data, 16);
>> if (IS_ERR(c))
>> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
>> index 012bd7339862..ccaeae42ee77 100644
>> --- a/fs/nfs/nfstrace.h
>> +++ b/fs/nfs/nfstrace.h
>> @@ -1609,6 +1609,83 @@ TRACE_EVENT(nfs_fh_to_dentry,
>> )
>> );
>>=20
>> +TRACE_EVENT(nfs_mount_addr_err,
>> +  TP_PROTO(
>> +  const struct sockaddr *sap
>> +  ),
>> +
>> +  TP_ARGS(sap),
>> +
>> +  TP_STRUCT__entry(
>> +  __array(unsigned char, addr, sizeof(struct
>> sockaddr_in6))
>> +  ),
>> +
>> +  TP_fast_assign(
>> +  memcpy(__entry->addr, sap, sizeof(__entry->addr));
>> +  ),
>> +
>> +  TP_printk("addr=3D%pISpc", __entry->addr)
>=20
> Ditto problem with this.

This tracepoint records a /bad/ address, and the caller does
not have the presentation address value from which it was
derived. I don't see a way to record a presentation address
here, so I will remove trace_nfs_mount_addr_err() in the
next revision of this patch.


>> +);
>> +
>> +TRACE_EVENT(nfs_mount_assign,
>> +  TP_PROTO(
>> +  const char *option,
>> +  const char *value
>> +  ),
>> +
>> +  TP_ARGS(option, value),
>> +
>> +  TP_STRUCT__entry(
>> +  __string(option, option)
>> +  __string(value, value)
>> +  ),
>> +
>> +  TP_fast_assign(
>> +  __assign_str(option, option);
>> +  __assign_str(value, value);
>> +  ),
>> +
>> +  TP_printk("option %s=3D%s",
>> +  __get_str(option), __get_str(value)
>> +  )
>> +);
>> +
>> +TRACE_EVENT(nfs_mount_option,
>> +  TP_PROTO(
>> +  const struct fs_parameter *param
>> +  ),
>> +
>> +  TP_ARGS(param),
>> +
>> +  TP_STRUCT__entry(
>> +  __string(option, param->key)
>> +  ),
>> +
>> +  TP_fast_assign(
>> +  __assign_str(option, param->key);
>> +  ),
>> +
>> +  TP_printk("option %s", __get_str(option))
>> +);
>> +
>> +TRACE_EVENT(nfs_mount_path,
>> +  TP_PROTO(
>> +  const char *path
>> +  ),
>> +
>> +  TP_ARGS(path),
>> +
>> +  TP_STRUCT__entry(
>> +  __string(path, path)
>> +  ),
>> +
>> +  TP_fast_assign(
>> +  __assign_str(path, path);
>> +  ),
>> +
>> +  TP_printk("path=3D'%s'", __get_str(path))
>> +);
>> +
>> DECLARE_EVENT_CLASS(nfs_xdr_event,
>> TP_PROTO(
>> const struct xdr_stream *xdr,
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



