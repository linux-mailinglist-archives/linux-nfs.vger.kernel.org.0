Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CE59FD54
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiHXOca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiHXOcT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 10:32:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64584D80C
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 07:32:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OCsK8F011471;
        Wed, 24 Aug 2022 14:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IXsZ7cJCgb6XVGmcTRwysk6HNOZbbjTicHZczi+IuyQ=;
 b=mpB6VowXa3UEGUIt5sg96k/HkMM7DOphHpJhgS0ohuDzR+sYYnG0SYZypjLRSRnoZLoN
 qEZNfEovVcOKghKXTk3se5scMa3LcdN5Rc8SXh8cLM71YJRbJYSMUTNIX1cRPHxKqHaF
 RRbyyupjoJA3e8JEJy4CjdvHtJRQI4QMrEQNiUwcK2sogDP4lMEJQGPbJdlnmIDrHOg5
 8FHX0LA1+DE6Fgp0Y/gvBkkGKtLViWWo/U6amrHtIfmZSjperG4dOL+QKMdJ6goS0Y2x
 CpzXx/t+munG1k2Wwdu3nWiz/kr1DZTmPSDEQciVy3q7ZWgv/wtpXXWMNetrQZRvfjHj fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nya2uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 14:32:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ODmBug005007;
        Wed, 24 Aug 2022 14:32:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6khw1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 14:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIw4Ew1n1iGbMZO2vjAfu4LUYKxb9PaJs36V2zCSR81owHBTsbei7XeQN91afQcoe12dNJcX1BkkOx5RSaSaa9BWFMdaUWIbjeHDZA6cMoB3DVQqBTUgLQFX+hi4G0+asDJUEqdSnaX8VymOW2/3N66hSzxvkBLmiPdLEp+feSoonqdBp5vj0bFWwNgE9UwBN0UC9TJ4qTlUIqLUhZTOQtFAz/aTMZwJHhAdFvvXy2Jnt5YyG1DevNCqudQs9hAMsa3jSNW5Y4MG07YbfwZ/3d3oDd+U9SpzBV8xCgWaGz32+DPBLCYnEUMzJyuWPq6zcdGntSGQw8ZB8NzGGTeXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXsZ7cJCgb6XVGmcTRwysk6HNOZbbjTicHZczi+IuyQ=;
 b=csy1tav8i2Qjy+fQgjY54Vy+jX18oqRjnAgo+/9JToaMn0J/vweQ9TgMUxg3MwzO4jpc0/Nyz5oFCPpVso9/eakM9ViKdM59VNCMGlE8mE97v/4tuUe0RSFaNiqe8f2GZ4OovY06BZgIldPE4cIcTjuVwvH3MY9JdEAJVLmlNIoJbaAZ19rqg769orfOpbOb+fN8AQtNZ8LyW8tXF0dwuEetaZy70JCTSTHzhcw5YHv/ceV3IL6obcJZd/Dhg83vrY6qisQaPgMxouMeys16k6of2jutXOwIZ73RsjjgFHTRF9AqyVTU5lvLXoYmd5cv+y1XcMvzmt4SnG3LgOmTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXsZ7cJCgb6XVGmcTRwysk6HNOZbbjTicHZczi+IuyQ=;
 b=tPKpc/TxV6Hw4i4QFQPxWxpk48MA/2vAv/MWj4gNGhDGcpeJ3+vhaM4NC3qL44Ow1oIXKcc3r57h4L6GfS1qJBHW4LhNL7fKNsnMvYyDR3JAiXTz+ULZ5TVQQMLb5AJAJAixmddBUbrB5MZWZCuQ2cLTpihrxyQkAbaIs0YJyvk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3182.namprd10.prod.outlook.com (2603:10b6:208:132::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 14:32:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 14:32:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/7] SUNRPC: Fix end-of-buffer calculation
Thread-Topic: [PATCH v1 1/7] SUNRPC: Fix end-of-buffer calculation
Thread-Index: AQHYtzNv6O/MgKVaMUSIVJpseBkTwK29Bt8AgAEXUYA=
Date:   Wed, 24 Aug 2022 14:32:12 +0000
Message-ID: <A157A4DD-E4FD-449B-9C7A-5EFE6E46CFF5@oracle.com>
References: <166128840714.2788.7887913547062461761.stgit@manet.1015granger.net>
 <78191e118727c12796fa1256d4e093877f4fca09.camel@hammerspace.com>
In-Reply-To: <78191e118727c12796fa1256d4e093877f4fca09.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34deca51-adb0-47a7-19fa-08da85dd6f0b
x-ms-traffictypediagnostic: MN2PR10MB3182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FmCOEfzIKyBqfByc0mLhCd/gBK9MxJEMYAp+X57ajhjqtFkD4lURdMcf6IbwnenfZ4WEzigcgxY/lr6I5um+B6bne9aYQyXuU/Z28kUaFk/JmjDkFJhfqBjig8IVdyh6URA1v0/2h6YjO0MH3bx7bb3fYNxNkg6tyeZmL0fpUrnmQs30p5OTt9CI6K3W3dZTeVjw7XrjBVYY9sYwhkGH+SQtRz+3ixAYkagymtuVaPr5+5NEKKt3XBr1VUPPFFM5T2fiNz55kNKQo9xhjTxzhwaIKLTKzj4VbDr7vVZvdt7mbA0qGQNqgkGT/fx6gwWAYGHvO7TrWgUU0+/trdAH9/nP/9sh9B1mMmt9fC8yd4JKCK37Rh1D3AdLEtHbn2ALOsKnjtK0cswi0odJn+pUy9no+tEeHuxD/sml/3SMAZUsBY+AUO2DWnak2lKrACNGI+tqZj8THANoHzKvyBoy7RugxMDkPXWOAC9eFeInRJ8Obc6oXCmI77t65ukvyq5B2EnqgdCGRKzXx2Ll/7TMV+IxR2cJgMC1k/CbnBe+klYyz1v/kKl5lTKeZAfs3OkNtpaX9GzsxTfxvXEDgv0XSql+Vb5vyHK5g0E1ZNfThRqGjfMxBlYzBU7Ed0XZDMlkV3F1sLpCCR1fpuuUB8/r8R9dQGdMVpy4tQcUhXML58Y9Siz85jEk85zRnasVrUVn0aDEK93NZ+SmNVT4uAEOWbmJ6cZNx2A0siagoM9Xkg2/8OQtLyMLhz8pB6fUKhqT2dRtU8tETm4vIQ1fuk65zLKJaFW1kQmtccifYBGrbfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(396003)(366004)(186003)(38100700002)(66446008)(64756008)(66476007)(66946007)(66556008)(91956017)(2616005)(5660300002)(71200400001)(33656002)(36756003)(6486002)(478600001)(8936002)(2906002)(86362001)(6916009)(41300700001)(38070700005)(83380400001)(8676002)(76116006)(53546011)(26005)(6512007)(316002)(122000001)(4326008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f4lE2b9D57wZfEPWPTyL3G7gVsbsHaqUsG2llz/l+cPtg+3iP+azdwt1Ipzk?=
 =?us-ascii?Q?G6ooWseXaPFaLw8ODSQLpsIYrYhirb4aOtCCqlNVHMxwewR7arbRArQ1niTf?=
 =?us-ascii?Q?vZZOt1cL1koLYJJG76lQEMfmXXvwrVieRYQSACMRKmC/QhidsaGCYDLFD0Hu?=
 =?us-ascii?Q?Fx2AVGg7CNRGHD5zOsFl1ZAhjszRCHZF6r8Dbu7sLuGt6W5AOq40bt4LsJiY?=
 =?us-ascii?Q?9TPXihCUWzfieFDtkFMu6zY5ss/DeKNjMN8BP0JjFPM5/MMMjkqe8l6GawzO?=
 =?us-ascii?Q?XfR3MDjmPCpvirQWWP0NiCxUUpVMTCncGqM4ELOvCTPaYpMHVdtjq+s5bZ85?=
 =?us-ascii?Q?VM9/ZUKRs1Jf+LyvJtIw/NxwlriXIFMre8JY45eR1HnHyJRo6k3mGFdTWP44?=
 =?us-ascii?Q?00N9YvUTqvxX4c4g3Y/KgRiSORJmFhLF2AaDnyuEigCvHqF/HwZtBk/6/Ah6?=
 =?us-ascii?Q?VaR3xPn2neTIKAZ1/T5vxu74TFdQLrZ0qnv5Rfba0qRkCulm4vd8NdQ5+x7q?=
 =?us-ascii?Q?fHrd5HZFlSXvwrIkG9FyUAYxm4JpKjj/TI8+Qf+2LUTlUGvUsXKgA5DYene4?=
 =?us-ascii?Q?aas1evmKYF8Q9dPLA+L34h9yRyOE5rDtQQGtX10iDNTtUuDD4OQiwl8zVlP1?=
 =?us-ascii?Q?wvOIPyoTQgdHtUgaNuZjv3DAbUVKmEji6PrHpF1L8wGjI5G4pZhK6XwpdnOG?=
 =?us-ascii?Q?NOyKm2U2sR6IO/eJNqvo+usjoU52HFbusqArQc1Ld3+4rJejmmtiJ5VIJ1qI?=
 =?us-ascii?Q?PzfUPz3n9ICoPxPgGBM+xlaLhsZ7Z0pS++Yv8ngcAkSBR2oLxWzWSwbPG2gs?=
 =?us-ascii?Q?yrXe8KaBRDFKwJ9tDMPCky5JwRvhKnkKEFXuF/RtxCSh73SS+NY9TAKj9gMQ?=
 =?us-ascii?Q?CwcD5SODOocXJr5QTTSDo1VoM0sfgKsPrvbT2WX6NZ3s5kVtVueygcWnQ4au?=
 =?us-ascii?Q?bp7BWLTS+F5ba5gt8UaTXEeRn266yazaQjl0iPbclwJIq+Izn1CKYAtzcObH?=
 =?us-ascii?Q?/0D1HSwrsgrTGEKK0HWiJE1AneogjOOsGS6lY0ketN+oOZ9n9hxQzwLoXo3J?=
 =?us-ascii?Q?9ovwrxqxa13tyUlQeSMzM7RLqy8JHVmT0+/g6+l2LxRy0+8dPVK/EBhV7EOG?=
 =?us-ascii?Q?Xp1fWFRPAhiW/Cti9RStaA5umpBnMWvonP0rT5gVryGWP9W7kZyKv7EnAbl3?=
 =?us-ascii?Q?y5r3NdgNJ8kJilh3My9ZCJEUuMoYs9GGPrt2+0sxLnXaGpCxYPzxXc2ih4Cy?=
 =?us-ascii?Q?P2Mse9krJ24YKh7zTdZdQFkSm40tjN2bJgHEusM50flzfCQqtR4NWyCRRN6b?=
 =?us-ascii?Q?kSr8Dy/hzuQaTbEjdGbvoEzsLLvQYIvrxxnmF4P3FzLWsO/tYsIN7NnSxAwA?=
 =?us-ascii?Q?BFHluZEjxNb2GFHuKRbZq6LumIeqlROaCywGtKuLwQ88jGcBhBhe2QlaRIwE?=
 =?us-ascii?Q?x/hY02yzTuOftAo9j4YiBj/Iz/G4+VfpHys+K3+3Htkrow8dNCMhhtejQUDg?=
 =?us-ascii?Q?S7eKJQxhX0BJJTC9rZz9rzKpT78rONND78W56C8hDYr6XJLJae0zW1tJFIAG?=
 =?us-ascii?Q?6BturmPOwrcTLoWawPei78EoMXTLj2ap7oaNb94dYEG1sbLOVRDKb+L43/uT?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0D3411113A49345B3628AF7DEBBC80B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34deca51-adb0-47a7-19fa-08da85dd6f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 14:32:12.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbSF4GJryDp/kBRtd4u/ufKeNDy2elETkaCvnGzIFW94nckkoFLND7FTOHW48Sb/1umy3kTIl/ZnzNv6XtUC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240055
X-Proofpoint-ORIG-GUID: rsI6mrbcBB09CxzZgfOFHeOeqY16GbxE
X-Proofpoint-GUID: rsI6mrbcBB09CxzZgfOFHeOeqY16GbxE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 23, 2022, at 5:52 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Tue, 2022-08-23 at 17:00 -0400, Chuck Lever wrote:
>> Ensure that stream-based argument decoding can't go past the actual
>> end of the receive buffer. xdr_init_decode's calculation of the
>> value of xdr->end over-estimates the end of the buffer because the
>> Linux kernel RPC server code does not remove the size of the RPC
>> header from rqstp->rq_arg before calling the upper layer's
>> dispatcher.
>>=20
>> The server-side still uses the svc_getnl() macros to decode the
>> RPC call header. These macros reduce the length of the head iov
>> but do not update the total length of the message in the buffer
>> (buf->len).
>>=20
>> A proper fix for this would be to replace the use of svc_getnl() and
>> friends in the RPC header decoder, but that would be a large and
>> invasive change that would be difficult to backport.
>>=20
>> Fixes: 5191955d6fc6 ("SUNRPC: Prepare for xdr_stream-style decoding
>> on the server-side")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/sunrpc/svc.h |   14 +++++++++++---
>>  include/linux/sunrpc/xdr.h |   12 ++++++++++++
>>  2 files changed, 23 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index daecb009c05b..494375313a6f 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -544,16 +544,24 @@ static inline void svc_reserve_auth(struct
>> svc_rqst *rqstp, int space)
>>  }
>> =20
>>  /**
>> - * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
>> + * svcxdr_init_decode - Prepare an xdr_stream for Call decoding
>>   * @rqstp: controlling server RPC transaction context
>>   *
>> + * This function currently assumes the RPC header in rq_arg has
>> + * already been decoded. Upon return, xdr->p points to the
>> + * location of the upper layer header.
>>   */
>>  static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
>>  {
>>         struct xdr_stream *xdr =3D &rqstp->rq_arg_stream;
>> -       struct kvec *argv =3D rqstp->rq_arg.head;
>> +       struct xdr_buf *buf =3D &rqstp->rq_arg;
>> +       struct kvec *argv =3D buf->head;
>> =20
>> -       xdr_init_decode(xdr, &rqstp->rq_arg, argv->iov_base, NULL);
>> +       /* Reset the argument buffer's length, now that the RPC
>> header
>> +        * has been decoded. */
>> +       buf->len =3D xdr_buf_length(buf);
>> +
>> +       xdr_init_decode(xdr, buf, argv->iov_base, NULL);
>>         xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
>>  }
>> =20
>> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
>> index 69175029abbb..f6bb215d4029 100644
>> --- a/include/linux/sunrpc/xdr.h
>> +++ b/include/linux/sunrpc/xdr.h
>> @@ -83,6 +83,18 @@ xdr_buf_init(struct xdr_buf *buf, void *start,
>> size_t len)
>>         buf->buflen =3D len;
>>  }
>> =20
>> +/**
>> + * xdr_buf_length - Return the summed length of @buf's sub-buffers
>> + * @buf: an instantiated xdr_buf
>> + *
>> + * Returns the sum of the lengths of the head kvec, the tail kvec,
>> + * and the page array.
>> + */
>> +static inline unsigned int xdr_buf_length(const struct xdr_buf *buf)
>> +{
>> +       return buf->head->iov_len + buf->page_len + buf->tail-
>>> iov_len;
>> +}
>> +
>=20
> NACK. This function is neither needed nor wanted for the client code,
> which already does the right thing w.r.t. maintaining an authoritative
> buf->len.

See patch 7/7 in this series, which updates two functions that are part
of client-side call chains.

I'm reading into your objection a little, but I think your long term
goal is to have the XDR layer manage ::len opaquely to RPC consumers
in both the client and the server implementation.

I agree that's a good goal, and yes, eventually I will pull the chain
and replace the use of svc_getnl() and friends with xdr_stream-based
decoding. Just not today.


> If you need this helper, then stuff under a server-specific mattress
> where developers looking for client functionality can't find it.

I don't have to have this helper, it was meant as nothing more than
code de-duplication. I'll remove it and drop 7/7.

Thanks for taking a look!


--
Chuck Lever



