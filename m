Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27F6562246
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiF3Sp0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiF3SpZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 14:45:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D1427D9
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 11:45:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UITnPc024972;
        Thu, 30 Jun 2022 18:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Q5qOjIin3/eYsG5y/7GAgNoaeli6m6yu+pGlfA4xbbU=;
 b=P9jrCqvvyWE8am6PXLpk7lVpSUrDgIRoaVDLM+DecKE42NmX8yRyOraFHNzc3ho/Dmkg
 lL2ThlN2Q7F1Q/4pNGmvIYoJ9Jq4FQO+HhLsU+qzoMV9KLCti1mRvp9gircPUMsvma4C
 jNNyw3NfoqpoTR6jOwchMgX9+zm+g71pmrX979ljZ5yGehgAeSPWD59S1QoLegw4rUNj
 mt9rWeb1nCFLbpTqW/0ncShbMnxQ90TtPMLyJphxvBYJ2ctBjizxsHfId/52IQK/Lsyq
 Sclh2kmjeOTQy55PbaPQVbvwvrogB9GnWoezqrz2gqxApVdTR0y6OasIOODFqD30U13q 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52n8fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:45:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UIZY05040811;
        Thu, 30 Jun 2022 18:45:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt409bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKIriQnnCFxEyDlSwocQzfuUnyg/qB+RgxLTYokSende1RzqVk3TKTmcGvD8oTjLIppK1BzvGFHQQtq/uJ91tLsFG8+OVtMeI+xVtohZ12dEVAQAUQpG5d/0XZud66acVjdtzlU+iPoEqVCdRwQNDaKzPgIpKiBPoJD+gSwPqxu5yGZJ4Tn5LHNGjqS64lhaX3yZCYnNvFlwhOxUvysxc7fJXgMOxJ4/f+9Y58DF5UxholR/bffZs32ZbHY79cZjKMgGaLYSaz9XQtageas41tHqD6YTLdhWMytM5uxdSXJpZZLTHgM1CZlqCus1rjFGFIhvhP1xv3U8rObmDL6vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5qOjIin3/eYsG5y/7GAgNoaeli6m6yu+pGlfA4xbbU=;
 b=RMA7bCGzmDs3sUisKwwbPgKiUDDSUnmqylEOaYIn7nBIoBW6nSBHgsNj/Ie1hwwDgJWXDwpD2rhL9DCXfIolwFfmTwmh5lGYE5dAZ0aypWYxRP+uxNnSueAxWxatd/hh1aa4ni89TPfQvZAACdWeVtTX4jbuRsxKyg3TJ8CbGCqWjV6yp4steJy/YN36T09ER354CvqQvpaHBgzkgNMTQjIK3hM74uH77Tjvk0vx74LozEsE5BS3+df3y06Uv3LYvSrzNkWePaBxVYje/soVlwb/lVPdH4q6qPm7uLNNWcDTStGG2xr/rpZodatJDEzzD2T1jOlhJqUKVMmjnvuABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5qOjIin3/eYsG5y/7GAgNoaeli6m6yu+pGlfA4xbbU=;
 b=uhyLVa+3fc9Vn6nbnkAjtUXZ8uLoET2clH+GVT+7c/w/mh5eeUf2NnSbYWVcs8lDzaH1jsjopUg08KXyY0gk+FSpryrgyY1Iajb0M3GmgM1km79844annO1vZaG4aU0XmPH9fipWwL8lJBqZXLxkjNzlFZbIzI7AnjoQlAsqe9Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1705.namprd10.prod.outlook.com (2603:10b6:4:6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Thu, 30 Jun 2022 18:45:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 18:45:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <schumaker.anna@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "zlang@redhat.com" <zlang@redhat.com>
Subject: Re: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
Thread-Topic: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
Thread-Index: AQHYjKZHa6b+9VALEU6RFmL5KfoMFq1oPUmAgAACXgCAAAi+gIAAAV0A
Date:   Thu, 30 Jun 2022 18:45:13 +0000
Message-ID: <CA75F344-82F9-4932-B196-C22D6395981B@oracle.com>
References: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
 <faae3bdaf5fc4b1c2ff481977bd1bf091bb0c8b6.camel@hammerspace.com>
 <CAFX2Jfmxi2_M=Ptt=2M7dbks62Gkdia2913yod5zaZ8bV9vGwA@mail.gmail.com>
 <0d8d0de92b9f7deeab0fa8ab6a0205b32fc5b301.camel@hammerspace.com>
In-Reply-To: <0d8d0de92b9f7deeab0fa8ab6a0205b32fc5b301.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6467ba-c5b8-47e4-b200-08da5ac8aada
x-ms-traffictypediagnostic: DM5PR10MB1705:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bmtugEir3OKEclSQ4yjF7pSwp4ztagXkTsddrOA2DVa9aOJkmsq18sNhCyG0/waXkU8rL2XUoDLgLwq0Ubb/aaH3xk6KxtnTmaUwjKwwClxFzJ/cZlCcft8NxOQTyrPF6k5V8UHSMcTw5TZQg8Yg1aFC8kTqop3orF49+cVRlgdOE2fGKNhxLbB40De0OtooBplxiORq1YFN+sQyQxmfexHwmgi8wRmKU5OBNfdLT6EpmWlv8aGyNFPNcdV8XUJpH2fi4TZRvd1Kd7TYXnBetW99+BNPN3Ywjw9JyUG8Kq0X7NAcbeGWDZh/TlRoIifvpCzRNAtpc4bCBx8pZeUlrcFDTsN0XQOpZiblz85LYUwE4uvxvLj1CnZZmVDitHIcKrOiWIe/lH/kuVfjP1/7a7gnXyp6j0rUqrDpMQH7UONwghYlVbBmwPlL6WQ0oztG00RlNzuNAMIeHSIXzDE8mR9xhY0muaSdf6xk6pzD8iLmM5UXAhoJ5owMsNzJSgUIHh7dWVnkc2TLHW+xYzhc5JfE/At9ryBRGQaR73n48ICv+KNMq8iX2ZYMH5lIhKee8j+e0DvrE5IqnNzYWqKEWzan1VV74n7DKsvKm/Nfl5fo7si0urctsxcanmObm+bZMz13JJquYKbpNBxF6qKrBSN5p0OavRZDwoIimokvMlbu796jn/WjwW322sPIFtoEFFzIbhJYiFxEfeSQM6eXNFtdTOFJAW0sHCK8rHA3WwV/6dmnEt5ZREzi9H/mWhv6AeP7gf0OY2i06DIlsICXPb8VjJDYcWAOocrfqNQAIWQCqobeukeUCgzLy0B6anuUPhvQ85pHBw7EZdzWAt05Rey7v/EkkoUbG9F8Ow3WFkqzgmlUZ7M/DuNqkwN2GP17QIkfQH8cajZt+MhLAJmZfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(346002)(396003)(376002)(38100700002)(478600001)(316002)(38070700005)(36756003)(54906003)(2616005)(6506007)(41300700001)(6916009)(186003)(6512007)(66446008)(66556008)(66946007)(4326008)(8676002)(76116006)(26005)(64756008)(122000001)(83380400001)(5660300002)(71200400001)(66476007)(8936002)(33656002)(91956017)(6486002)(966005)(53546011)(86362001)(2906002)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?43MYFAP+2c9dzU9RigeAEPdVP6hDR0ungI8zT9l5aBGCgZidV25ikF1kv7Ub?=
 =?us-ascii?Q?WSLc3lW3aUL/wS2TdP/zodm1X4K4Zbl3MwoqMvSndwfjf9LvcZ+bp1tkwcZX?=
 =?us-ascii?Q?XcQprr6zmhdxqB1t0/YdhbZpwIkfzb6+QK6ASZRO7Ww6FhqT5HhPg8hZ5WjW?=
 =?us-ascii?Q?6A9jS0AjeXnDNtw+/Yh0lH6XM7gJ8ggTSzgOXPiMHUlZi7tN3wkYyc/UwVN/?=
 =?us-ascii?Q?5ZxeLunWd9fb4tgKQUxFAkxvdW+xUaefr4qWBWiFFS0yyDuPXCkWD19St6OM?=
 =?us-ascii?Q?Z7fer4M610ZnKLmOuWZx/AeYwdegV6HLvZ9dT20mb/1TdvWaO1OOMOIJIKLe?=
 =?us-ascii?Q?fttDN1AATR/RhvTy2PYdCnVY+sSWN6U/GzNTLcqPLVhuo52iMp7GI1YSt5SU?=
 =?us-ascii?Q?KjkbZPOefCzJ/OxdddDzYwa9bFv2gO/lDelAmv3EDIS3EdAd0giyoAKPEGN0?=
 =?us-ascii?Q?Gd1kRUpc+CVSlC0FjnjYtaKKgTj8waX/DpLhPWDFPyklsaW+SiBjNdWJrKoo?=
 =?us-ascii?Q?l6B+QS+No6nrVoXKcw6GcFOBcVtZsQ8y3yU0YM2zvSQT6c0xAbN+zXDO8IY0?=
 =?us-ascii?Q?Ty4MUkey11CszJ1VjhJdjJCQWuQ7gf/PNO4aRtey0IhuoUgy54Aly9oLlmyc?=
 =?us-ascii?Q?qKEbXxBEsAviLv74Q8kkl/devHWwaVph/oYtvTIenrUl+2Ar5sQwgdr3lyKa?=
 =?us-ascii?Q?j+FeTaGbdrW/m467KfrM2UcumlyNN3alOuysq2kXq7XBVyKP8AjXApJdLNnt?=
 =?us-ascii?Q?0dNSIjYoz8ygWFXlCIqcVCTQrrVjC5Q6ZXEhg5Um+Nj8GwkeMi7ewBTGNbYP?=
 =?us-ascii?Q?+X+r0JP2Tj2T1DBXIaZmEPCvWYZf9UL0wBP8KSfoPeDAVTqv29WvXCmE9n2g?=
 =?us-ascii?Q?9NLfm3cr1qN/Ur/UKjrK7suKO0AIn59lwwJ/nyu1XbPF/tZGROxl2SN6s4rC?=
 =?us-ascii?Q?yQnjTsI8fga76pjU6F6Z8Slb/+u8BcZGagZWmVsvmnjL9aBEfHcEY3V8eHP7?=
 =?us-ascii?Q?7rW539gtTSTiEPF8XYK0uuG/9whXgNUZrJ/U3WCUhv96eac4vj8MEM2W4AmW?=
 =?us-ascii?Q?O/ghqC0stFEj1RIZ3VGRgxQjSJvIbe1SHIDFTQcl4A7CTqmYrat1JcQ88l+t?=
 =?us-ascii?Q?VDsfJ2RL4oNUCmINJIq8rYo7qjWl5OS6IJneFQTGaSllvkBkmV+x7t3ThsLv?=
 =?us-ascii?Q?mHlWqaFzl/G4XMALWEyDTWTqDQbqHVrFwXeDc3fLMbWce4xNm0UzbPfxvXFJ?=
 =?us-ascii?Q?mUFP3Ga0KmQ/UyGZ4dOqwF/qMxu3BWc6kEsuO//iTPKWPteyzu5Asz7nnlwd?=
 =?us-ascii?Q?RnnvVqxSYVdBAsYR04HHQ2Zj6PZ7+6cyJ8DG2+1Xpx+EUQpyjD6MbweIGBke?=
 =?us-ascii?Q?KJD/swOjfitLlSBi2gouImcC/qv1u11/WZU8z09DoBLRP1u4D25fUbHG3ssn?=
 =?us-ascii?Q?rQuFHZceKMPObIFNqLxuJBfBv39fz/KVZbcvJQeFGxISxs0/mJGSd/QkwSGZ?=
 =?us-ascii?Q?Y4cNBa6wbzExL4e71odLEdjhhU7JwYi9xQKhAl5LqWuzVU23mCZoV8eG1mYj?=
 =?us-ascii?Q?JyRdwhpbLk479uvu5USDHd+AbaVTwwoyvI9OC+R4n7QuKD54haa/lZBdf5qy?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A31AFCEDF02224DB8EA9678166ECA3A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6467ba-c5b8-47e4-b200-08da5ac8aada
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 18:45:13.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYoyOI5A8V0sMg9SUjg5Hon/wIzaShanBU2tIfJJdGXY6+e7/XceV23FVul6PJu9ZOtCdOHluJo1chMf2SYvXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1705
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300072
X-Proofpoint-ORIG-GUID: 3PrgN7aYMpuJT6AG2nLtj4wEFAcNVLnv
X-Proofpoint-GUID: 3PrgN7aYMpuJT6AG2nLtj4wEFAcNVLnv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 30, 2022, at 2:40 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Thu, 2022-06-30 at 14:09 -0400, Anna Schumaker wrote:
>> On Thu, Jun 30, 2022 at 2:03 PM Trond Myklebust
>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Thu, 2022-06-30 at 13:24 -0400, Chuck Lever wrote:
>>>> Looks like there are still cases when "space_left - frag1bytes"
>>>> can
>>>> legitimately exceed PAGE_SIZE. Ensure that xdr->end always
>>>> remains
>>>> within the current encode buffer.
>>>>=20
>>>> Reported-by: Bruce Fields <bfields@fieldses.org>
>>>> Reported-by: Zorro Lang <zlang@redhat.com>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216151
>>>> Fixes: 6c254bf3b637 ("SUNRPC: Fix the calculation of xdr->end in
>>>> xdr_get_next_encode_buffer()")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> net/sunrpc/xdr.c |  2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> Hi-
>>>>=20
>>>> I had a few minutes yesterday afternoon to look into this one.
>>>> The
>>>> following one-liner seems to address the issue and passes my
>>>> smoke
>>>> tests with NFSv4.1/TCP and NFSv3/RDMA. Any thoughts?
>>>>=20
>>>>=20
>>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>>> index f87a2d8f23a7..916659be2774 100644
>>>> --- a/net/sunrpc/xdr.c
>>>> +++ b/net/sunrpc/xdr.c
>>>> @@ -987,7 +987,7 @@ static noinline __be32
>>>> *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>>>> if (space_left - nbytes >=3D PAGE_SIZE)
>>>> xdr->end =3D p + PAGE_SIZE;
>>>> else
>>>> -  xdr->end =3D p + space_left - frag1bytes;
>>>> +  xdr->end =3D p + min_t(int, space_left -
>>>> frag1bytes,
>>>> PAGE_SIZE);
>>>=20
>>> Since we know that frag1bytes <=3D nbytes (that is determined in
>>> xdr_reserve_space()), isn't this effectively the same thing as
>>> changing
>>> the condition to
>>>=20
>>> if (space_left - frag1bytes >=3D PAGE_SIZE)
>>> xdr->end =3D p + PAGE_SIZE;
>>> else
>>> xdr->end =3D p + space_left - frag1bytes;
>>=20
>> I added some printk's without this patch, and I'm seeing space_left
>> larger than PAGE_SIZE and frag1bytes set to 0 in that branch right
>> before the crash. So the min_t() will choose the PAGE_SIZE option
>> sometimes.
>>=20
>=20
> Sure. My point is that it makes the test for space_left - nbytes
> redundant (and confusing).

I didn't immediately see how to collapse the checks together, as
I had tried something like that while working on 6c254bf3b637.
But I will try out your suggestion. If it tests OK, I will post
a v2 of this patch.


--
Chuck Lever



