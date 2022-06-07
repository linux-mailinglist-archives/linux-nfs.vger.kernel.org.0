Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2353F3E0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 04:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiFGCT7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 22:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiFGCTy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 22:19:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666AACE07
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 19:19:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2571Af9E026474;
        Tue, 7 Jun 2022 02:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EQ2rPPDuEHRbd39+1Rm7nMPSo6YAGdAeQxTtJf150KU=;
 b=uZkVo4kOTzdckfQzr/9LzBxwzmb5eAOrJerLqFT6xnEXg5chpuXouK7Xf6TF2bj70oJv
 1NWnZFUQP8HoJNyKkuPHPuBQYE7NACrkZwa7Nvuh4bYtZRDvTKoy7HCV1F6xInQKMoDz
 9iW8wo7eNykWjieB5xfX+Ah4K4matXhzg3DN67yYgaGzMCCRCSbFR1K6DkDJoTzTn8oU
 EkOxAR4RmgyYGLpI8argJ7kSqke/MeazdThe+8DOT9f+8fJGUPQEq+dGsXtoAC3djjuC
 B6FIc8YFs1OoyqjAvX/YisUMnH3/gZsekosD3X0PbHhe+MAxG0VAVB9pCVB6oihSS0km BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs3825h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 02:19:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2572Fx5L022405;
        Tue, 7 Jun 2022 02:19:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu86j6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 02:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/3Obk0+T1/1gCPiTgN1uBwDdqjl0B6T43fliVMMfmUjLis+dQ4aGMRFF5e2qUayYDkP6Xd4ebVMTw7gmp43dJr39OyZz9sp6NTLPyptm5P2MDIxW65Kx4pLtIabyAp5p2qLzBJksxHGWcwc/zDPqAeXWgAjhyCW/DH51l2cf8tZcIfW5Oxc4RTur3M+juwQRE1v88GipiEcYBJDfVFlN4F7GJT133Uhwt9b9mgTFofdy0B8mORBsuvTY9QZfj6pcwWYTJstHmOCfvRrhVQT/fGnq+ZwewN8kEUJNtLdELwl2yDPUltyDEd0PXT/zGH7nriwY0YvBaGgn1mUiNNVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ2rPPDuEHRbd39+1Rm7nMPSo6YAGdAeQxTtJf150KU=;
 b=dM75IG57h9HSZ/z6j7BBZmZCSEFFDdaNVTYbHbiURRIB9HOyg/8U/TQuOjYzLgcCYm+IKnMkNjq4mqNq6K+qsts1vAUccETnMPg5d7UevHZMi4f3mwJuRJDZHSHINxVhzIAqrDnet9jmkY9XHjKR8LjpJr5iAXscRqjlf7oIX7n1mQaV2E5WyjV9ZXnAYVw6JxajhofnJjkixTXcYKDdN/nxkhhH2pZCliITnvtRVkol+mt7SovqiXXuLIwRxJXVZUsm9pjT53+Z0GyjixU1nCcf0izPZ6DZmZHn7UXAjYnSbKLvC7GhOPi4RuSa18UdhpJ6oDaZDEVHwJUgOWCC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ2rPPDuEHRbd39+1Rm7nMPSo6YAGdAeQxTtJf150KU=;
 b=Hzc/+CRpMN+4eOaqG6exW65fvWUQ+j5bz+cHBwDXDamI0dL3j7yq15MgFdyTrSduMWjQ5M0WSkazc0EBUtdAdW0IvuvS9fMhRDBugR0CZ3pI0XSg9M60a3dXzqbIMmzJ//Izzd3o6xQaepav1XMuTSa2oOkGqbJefiC16ZCWo4E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3310.namprd10.prod.outlook.com (2603:10b6:208:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 02:19:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 02:19:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] SUNRPC: Optimize xdr_reserve_space()
Thread-Topic: [PATCH v1 2/5] SUNRPC: Optimize xdr_reserve_space()
Thread-Index: AQHYeRapp2vV8XMEOkqZg53DiKDSaq1DIo8AgAAVXQA=
Date:   Tue, 7 Jun 2022 02:19:45 +0000
Message-ID: <0F620E33-2490-411B-B934-F8C379C05F74@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
 <165445911199.1664.12318094116152634589.stgit@bazille.1015granger.net>
 <165456379661.22243.4266686429763691053@noble.neil.brown.name>
In-Reply-To: <165456379661.22243.4266686429763691053@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f647b229-cd34-4b1b-1611-08da482c302b
x-ms-traffictypediagnostic: MN2PR10MB3310:EE_
x-microsoft-antispam-prvs: <MN2PR10MB331075B42EAF14FA0DA3DA0793A59@MN2PR10MB3310.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4iTueXjv2sKrk8naXUQolG+9nKkYVbJJCEjPuAVckBt+Jek2mqDGYNQkzGvydI1jhp3TOJB9GkvH/nm6ljS8mpZLECXIU6P9JGA6QIr8GVzSDZdODvSY98wcTMR0IQc7R9VjVznEGVrFmy1VpUXuZzFqfO3q5hRyTsM9iz/1cOoz4UtL7JmXlpEbp3wGvwNQUMZUo2G98wkhKxk9sZX20baTfk3tnTa5I1zkqYq3AXjgjq8DY9AbTTu+yB93DvHZBa62ZbLbbR6ngjqAY9odcMazTX5wtE+Rr5qq2RtM0FYvAEfm7y2L5hnDBV/5Z3xdez/qcC54nSbiiGei/EZOI/7n224PRnqSv/zVWdU3DNfj0vvWzXyvaiZ2LBnneomBcVJklA78JlJg9lmXNh4dzHa7eHmlhIMbG2i4YzWzVkuI8ELAdzcXeN32QrueqITpEgicmCQLPZ6fo8GYh096a9LEAf9kqu7IjMY6ceaRKD05OJpVqhn6wOppXkK6B99lBKd72AZiNaQY216aotqs+kPj73DrVy2c/Ci9tqK9srYas0821D5QLsAzHj9HdfsYqUpGBiW2jF6onDnxknhE1sfvXR0b1VV6B/spaltT2T+G9nHg7WTsjjXT2wCS0G+nKhK9UTe628Apv6tN/tmYfQ+QKuJeHQTg86iHdjgWLQxs7Oe17ePVIHfWhVuy2lNlszUw5la19/6Z61C7wjiPzTN4LDEqYq1H4MGhn/yrceTlq3OCEQjKGfrxY9wmjSr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(83380400001)(186003)(66946007)(38100700002)(8936002)(508600001)(71200400001)(33656002)(86362001)(6512007)(6506007)(91956017)(122000001)(53546011)(26005)(36756003)(66446008)(38070700005)(64756008)(5660300002)(2906002)(2616005)(76116006)(6486002)(8676002)(66556008)(4326008)(66476007)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?euSM6ZLBFYmcsSz/yYGIOMMvX5RwpNymnpCrfEJiSPsUIoX05gho5rn2i9qD?=
 =?us-ascii?Q?SXyOWd+/dKwEXxAl1eT2hx72TqZv+BNW0+Ybh/R4NhiGM2AvhMTObyPARoxb?=
 =?us-ascii?Q?DayytJ1RkKyVrQtPMBJBkodHM5/r2o8uOt/aHHL854sUofIN/Wkkxd0GgXt8?=
 =?us-ascii?Q?TcDgrh9kvS+JQB3ApE9q/R8RDa+FBL3+/VBxlhjgNUNwpiruMqDRmFX/6V13?=
 =?us-ascii?Q?pRoinCZigtqY7WMP6gEAnqWpCAiDWy0dZjNMmKfX8qHt0siL85j2u6BxKpm9?=
 =?us-ascii?Q?Fd7Rlf5UhXkqwb8CAI7Ctz8tStfXHjVzoen+GRGHugoAWdwXDKa6NX34ePJE?=
 =?us-ascii?Q?FgqOVPwiR0O7AAentMNKmV8cllZKws6SU3S9Xe25xWy1HWVpCxyMHizp9AKS?=
 =?us-ascii?Q?e8XdGd+xYcKwkUy9UlKaHQftClcfoOKD11C4CWQ4DzImZ1C6auIOFKgCFjZa?=
 =?us-ascii?Q?MDHlBGb6bXRnXoAz9syri2yHE00BfMGrCysces4YIrU/Q231NSiYyYeFFHj7?=
 =?us-ascii?Q?jHMBEFTWX0GAA8BGDGRLxAsV4IrYZQ4z5N7KqjW3pkGD6M8ul0je35BIxwf9?=
 =?us-ascii?Q?Y1gp5vbUQG6jbAkUtmXE/I8vwGy1pI0z/JOU1+WOaXx9iorcD35+3zfK1w7M?=
 =?us-ascii?Q?wM/yvkSF+q01NxQ5NV3OypgXQnj2IIB+gMRv7izUof0yL0TxHCi19P2/sLZv?=
 =?us-ascii?Q?M+FZDiHPrZZ8b5pC7LLZzD8lctIIRuzXkrD4dcmfpQzLsyka9RdaTh7BRM4N?=
 =?us-ascii?Q?4oFccQ80wCKXiAb7pCn5lInwR0cUpvUYK4lBUwSLjvrXzf5eBZskguhy98V+?=
 =?us-ascii?Q?3tYKTwLoiraA77G6Yjy+Kh4bXxg0L/Y/7Hkl5S9GXhcDYIq9MUm2nj0LelUN?=
 =?us-ascii?Q?4Sv1cpzuH/dFLXAUL8p//001Flnlaqt5p2P7rNn3q/tAH2kH3zAtYfX+NCfi?=
 =?us-ascii?Q?oGS5J1ToT2kImjzPpLt/Oh3OnMbnY0aGjmczjDeo2jIpctsBCqM7vwL55HI7?=
 =?us-ascii?Q?ZsfNR2m7pT0IlshKY7jX2ycASfm3cAgNhvJHUPxNtGwd8C9utkVE9GQ5Zu0U?=
 =?us-ascii?Q?x5GsRQetYVFfNr6e4kMIc1AXzWrqYtTlD8nZzK7EH4I97GA52h91/7iAofmk?=
 =?us-ascii?Q?znh+2JMYlPOm4Dtzfo7Kb5Yh5StoujWC9h1ZS2OM3jAFbnj3Uc8ah9NXT+Zx?=
 =?us-ascii?Q?mD79Q0Ykuem7qw9zWB+cNPrMTv0XyLc4fbhAEN7ZXu2tPuAzCr8G3dpUkhtn?=
 =?us-ascii?Q?Dib7pbJ5yC1ISqtEos8w/b4m/62+hEfGnLn2ANHrRRPPziDwKYOs20VkWjxb?=
 =?us-ascii?Q?BiDRybLlT46EGpujqlBt6Lr5ydnA9dQHouQsb8G8mbxmxYCEL5rUAH0fYBel?=
 =?us-ascii?Q?CxC0OEoHuIE+DY8Z09AvSKjE90ij8OIajcXn/cwyEhH/9rtX6+Pv309E7SIt?=
 =?us-ascii?Q?3AT3EDo3xRO3VpgNMK46eQZd3a13F77NJqLmlS62fizzHx4pWAOIKKA978Jb?=
 =?us-ascii?Q?BeYDPql3Qrgg7G9JD80on5DwHUfG4HZ7ShwyWZHBfGnXG/A+A5XFMbWi8j6N?=
 =?us-ascii?Q?gPIT9yzemrq6BoV0kQV5HO5EEZuUkPD75uWmlnwZ8dGKw51lfVu8LIaDlXDK?=
 =?us-ascii?Q?8+HdH6HWYBAWeXZ1gr//9jfJSpYvSG9Dk42NylN0kufGKX+D2Vo2uilDi296?=
 =?us-ascii?Q?GeLh9yfq5wZRx4rbAm4Lk9/nR65lpaRsj835GwGneQRJcCSNLXJb1Fzk9/DD?=
 =?us-ascii?Q?X4P4ewMSURGUZS3IxVRTZyHRyHRBObY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1D2C4D022ACB148A27506B9A0BDBB39@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f647b229-cd34-4b1b-1611-08da482c302b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 02:19:45.0081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Euf4rRMSNr1sG8lOSIT3aEYbpJEhZRndUvWQcpHL9UB2bh/9PzANPcsK0IV4LDd5tdeGNy5wgBLtOWcCH0A8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3310
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_07:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206070009
X-Proofpoint-ORIG-GUID: WbzRdQ6LkN8fNOd0igbQ80VoaBTTr0sp
X-Proofpoint-GUID: WbzRdQ6LkN8fNOd0igbQ80VoaBTTr0sp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 6, 2022, at 9:03 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, 06 Jun 2022, Chuck Lever wrote:
>> The xdr_get_next_encode_buffer() function is called infrequently.
>> On a typical build/test workload, it's called about 1 time in 400
>> calls to xdr_reserve_space() (measured on NFSD).
>>=20
>> Force the compiler to remove it from xdr_reserve_space(), which is
>> a hot path. This change reduces the size of xdr_reserve_space() from
>> 10 cache lines to 4 on my test system.
>=20
> Does this really help at all?  Are the instructions that are executed in
> the common case distributed over those 10 cache line, or are they all in
> the first 4?
>=20
> I would have thought the "unlikely" in xdr_reserve_space() would have
> pushed all the code from xdr_get_next_encode_buffer() to the end of the
> function leaving the remainder in a small contiguous chunk.

Well, granted that I'm compiling with -Os, not -O2. The compiler inlines
xdr_get_next_encode_buffer() right in the middle of xdr_reserve_space().


> NeilBrown
>=20
>=20
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/xdr.c |    9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index b57cf9df4de8..08a85375b311 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -945,8 +945,13 @@ inline void xdr_commit_encode(struct xdr_stream *xd=
r)
>> }
>> EXPORT_SYMBOL_GPL(xdr_commit_encode);
>>=20
>> -static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
>> -		size_t nbytes)
>> +/*
>> + * The buffer space to be reserved crosses the boundary between
>> + * xdr->buf->head and xdr->buf->pages, or between two pages
>> + * in xdr->buf->pages.
>> + */
>> +static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *x=
dr,
>> +						   size_t nbytes)
>> {
>> 	__be32 *p;
>> 	int space_left;
>>=20
>>=20
>>=20

--
Chuck Lever



