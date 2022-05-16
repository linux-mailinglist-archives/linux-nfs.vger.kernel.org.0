Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F695292F8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbiEPVhu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiEPVht (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:37:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D1419B7
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 14:37:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GL5VHx024500;
        Mon, 16 May 2022 21:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0IQpB8ZMPsXL0er23IYYjRNdHCfwX6pDHi+oW5aOOPg=;
 b=bm4vhllN0AlsMBSoq+FoJw5ll67tAzyIoYRYLt+Ay7Fi81vvUF9667IozZpaY73jKYg0
 1Pkwco9HMirC+vh0t5wSPhxvnAxFUEyxPf0AQY8i6k2C4aA2Ld/dht5sOE7b3WiiY1eC
 B2BmZEwlAYw6m4pedgRj70HkYVB00CzMdlANkcvaqnWdY0gWaJcYkJ7LNpImt5mjR7YN
 tZ9kqPoG5ZiQ/DCHqcaF0DGpYOa4SyLPhocQz3ImZvjkhCz9ubh+CWtpt6conalVe5oi
 hyCNztZfcCNdqZ1HMeTEMmluRQ7kB7rQxvTCqrwuM4413Xxb4z7E1jnjzJ3mwB4SEXg2 hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc4g26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 21:37:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GLZdEY029495;
        Mon, 16 May 2022 21:37:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cp0uy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 21:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0JES4WBAAN7fl0MXAAxv7krpvUrTy2DO5lYzVD+lQk9utyCPZa8AQWclvgCjIewnWdjoIFguoMKc3uuwSwGmxDPN93zo200f1Y+O6v1IsBATbppTHunC+iE8ZziumDE3HguKdhFLQnnYowT36ffsLCBLVkAAGuxvYsJbF5iHXY/N9s/9JxoouWrjy5PktjSCv5u6Cv0YkP/BusabspkU6jA9yK7Tf2g95cExYj4WMT7eEUyGl6uVtuSwjh4nWAhaJCz6pZO8KwiKgRQzt3+j9Y7OPzC8r6enqMBGwWRx0hgh/nQeBm4dQFoOOqxzhAoQerlT7GqWj0PLi/t/CRyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IQpB8ZMPsXL0er23IYYjRNdHCfwX6pDHi+oW5aOOPg=;
 b=cciOnSnxNnUDadAmS2i7sI7dR5KoFM259FcLR5h8rFLbyCDwXI3CID+33N5XbmIrkojj1YJZP6lhWVXynqeJ0Wwh/i6jvM+7zwDU203fl/kE05CCwLP067+fuSCQ04uKztMqaLihb9PRDv6vDbOWoiME0dgxQfPVb6ZxBeeadum9Sv6YLIBOfN/3R99IRkhPnShiOqvO88G0TuhbvAZS5nVXms4C3zZxWywylsBN7BskWm20Kmbd4wGzUYByQBfG04FmpI37Avjo3zapOmznzUHaSwoQRYHjlAaioHzxocb70XGMy9KBFoyT/dG2K3NtsWApqMklUnzqt2CqiuKe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IQpB8ZMPsXL0er23IYYjRNdHCfwX6pDHi+oW5aOOPg=;
 b=JtW2to+rdfJJgGkNuCkDFnN4lHG1scfvc8GoUEexEe8AjPClF2Kdh4iNER4UY7K47iY043esClG9bUrwNbgeIm2wT29HKDxA5taTf3kyXKUY3LSYqfkIeykh+VSzb/WTe6OSDvYEfKG86dZombG5UlM8LKwgRdbLDsUf462+3vQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 21:37:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 21:37:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v1 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYaWgxARJPFMcwk0mT6makjhNPcK0iB4UA
Date:   Mon, 16 May 2022 21:37:41 +0000
Message-ID: <CFB40FB8-5180-499E-93B8-0DF4C8FE8D94@oracle.com>
References: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
 <20220516203549.2605575-7-Anna.Schumaker@Netapp.com>
In-Reply-To: <20220516203549.2605575-7-Anna.Schumaker@Netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cfb9039-23fb-483f-888a-08da37844e06
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30854586C4F260EFED3748BE93CF9@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xpJAaJC12kAXgzptWFj94CrRkjl4I+7V0asOaWgjSwBMslz0NXN0nvoVjgZqG/w24Yhlby0Pberg0PZMpsV5dnbx69Z2lcOAQ8wAHr1VkLs7IaGGhEX9gFTa4wxonCKaNtS1saXWriJjfV7Ot7kGYM+XXykAKcD/aJ9DAK/8+SiWYpk7xlDfu/ZWz8RFvrcOj5lWfVRfB+VKjfvULNv5IQ9e8WA1CnGM0FY66lCeaGI+8N4o2RujZibc8kfeOQ00iY0Yiy2NypF4LC3Eli8v9yGVJP/LIgvcz6qh/FyeoOpGxk2ni2kTsugilo9ELR2k4yhDHx49pKXkt2sU1TX9WxlrQ1NlYpEelK8RnzHwaoII2IGy3dF4gK+sdQlfNSf5iOU28zmsZUBMFi4diaA5zSq6pYMn+Aezm6tB3Bmu1caOZB7KAJwMforkxBEfpo1YR5kfwHGjbF4o5FV0xEoC//4gCb9TgFcyAvD0/YoCA9gvkaxYcpVpvndAFyPlpo3+Yhic+GZWOb6YeAPMcIHGLs/lYdykJUdPU6maEr6bD5JLo2ev0YdY95AJjjqPb3ZuNKQmoBKaTSSUOM9pzsioZp6OL7zEcJ5McfYmTkEYKwve45unXlrHYQ3ig31KiltRDKre5UbqeOTu4o1aFw3ZTI45bwNKaVt3ngD5tMQCtjhqitvbqVnY3n+kStjASZaPIJax3N0S4e4wHp2qW+8Qrp5fA2kO1r+2GzysIgvC6eSTiZ5hBHnQrFZrzNnvNVMp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6916009)(71200400001)(6506007)(8936002)(53546011)(122000001)(54906003)(38070700005)(316002)(6512007)(33656002)(6486002)(86362001)(64756008)(66446008)(8676002)(91956017)(66476007)(2906002)(66946007)(66556008)(2616005)(83380400001)(186003)(36756003)(30864003)(26005)(38100700002)(508600001)(76116006)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T8sEsyxUOAuw6aJMdkD/1YMgkU95qUZxRc3GnU2v880yAM2m6lgIMKTaGgpI?=
 =?us-ascii?Q?TI1ZHmuZxL5PILBNAJ+8k8HY9p/tHiSvVPHMEC3S18jY/VqTsPwHu5XtadAp?=
 =?us-ascii?Q?LXprFt0sAFQUD8svVBpkQE8TRW4R1qVsgOCiVbmzZCZY+hBhCEVRkYOOktYb?=
 =?us-ascii?Q?E+A7AVblsSfE2Ezo5BSLU+dZZ5cicg/2aGc+1FFuRi+rUpqqp3zMOSe4Qvdu?=
 =?us-ascii?Q?79alsYkcXdQf7LZSnXPIrTuOoqI+5xZMQEZ+iilaZYe5o0j1SZMHvSbrRig6?=
 =?us-ascii?Q?74eE/G9agw2GrxXBMURf+KbCWHN4V/T+SLqVSgb/lv51RHmAS0jME3yLHZD8?=
 =?us-ascii?Q?QU/NkdP5RXzhDMb3vYt8yTGV5Xag99nPwaMSQmg/AgKg7BcJADG8wBZEnuEp?=
 =?us-ascii?Q?V947Q1cfTjyV2Sdxk9soOpXU7gNHVBXrVuThoAu+5dEnKwQe0JQQWLuFyIV+?=
 =?us-ascii?Q?OUwUDu4hQzA52scL6CO8WwY4lNLdR0gIF172xcUmymGtbNWkGOdsVYM/ZxM9?=
 =?us-ascii?Q?I7Hug7+l5ZyrJ8RjNkVvL6XlOp8G/gwA75dEK2tp3TB08n9Sk0yrhKT7++Ng?=
 =?us-ascii?Q?3L8GUdVzJkHZM/Ifj9ePobUh32n9mlUvvCy8dPLPzkTEzMZrIKPAd/2tR9hc?=
 =?us-ascii?Q?w7kP1EOkws2Qbpje4bIJn+AHt56HvZLhSr4njK2Yf342XSDmW4KE1mNCHyIi?=
 =?us-ascii?Q?yk7ih/HQxFxISB8O/31W2zQgMUl/npJDb4eeMPX5YBToJe2cYFwEz4NNqd6T?=
 =?us-ascii?Q?DOzBPhGC8rB//b7tvwUR3GzGBe+Ad39VhOuEz204zmJfE0AmmBYuRskL8e3b?=
 =?us-ascii?Q?WvEXaIFLBScpUOt81RyWsGFuslUumZfRXdG91iRbe2h/DKoA8tbTzcE+dENe?=
 =?us-ascii?Q?voL9pen+MFh64LAq89EVD4B5z2OTx8WM75oz9ZV26b1UZEHLDPRdsN6fLfJk?=
 =?us-ascii?Q?CR03DtseO3a/+KMpRFVXEbtftptjVQga6M5435aKHhpgyVkoFM8HEOZWAEaw?=
 =?us-ascii?Q?pPGL9/I/7X2xH0WF1ZKuc9nrdh7NqKstiRVNER6sFrlW2w9eJ0mQwANIqouq?=
 =?us-ascii?Q?nvBtPxQKTxRVVXIigR5rDJJYdQ3PsK4zen0L3WMFKaKDbxmuiGlcFrdE7KyT?=
 =?us-ascii?Q?97iuI86H0QiGqIcFHarRj8N0LKlRRwKsrNxUZD83XlKfwzOjPj2nUDssO9Cm?=
 =?us-ascii?Q?Lw99xpYtS4QYH7i8MYDW2jhCDP3iZcUHUPRU/dWsrDs065zGIfMaIhQRZiKV?=
 =?us-ascii?Q?bo617r4Wp3xptmlzf/j1IeIJPlac5Ly2GkaHlOXT43UdVEYxs3nN+og3y4vF?=
 =?us-ascii?Q?z69etHamslAoyfkHZ5ez54d+vylSS3a5v2P9oIy5pGqrjFlSepx5SsfphnzT?=
 =?us-ascii?Q?BzjUZTJa27s82Vp4496+h3waqrZlaq6f2lpWvJYXheHPMoKMrttckNo3YhQe?=
 =?us-ascii?Q?GUFXan6ZbPyQPbk3w2vBIFdCHPmDzIw05o3xKJW40vtBFXMarOVr5garNJGJ?=
 =?us-ascii?Q?qwN4haZieOaXjl++OCs3m7eRw+9Gn6c4WunpoFm0CEKZNioR/mw1v/SFDBx3?=
 =?us-ascii?Q?/ui+2EtBDv0wB2z6fZVbFO+J23jLdoqGP7y2gtWWX58JQ+IFXJ4VnG7BB+Z/?=
 =?us-ascii?Q?qJp5Q568hd4nXJ3Krpakn1balDIX1zAztmm0h0wng1Uapmn/EC9vEO1IJXaO?=
 =?us-ascii?Q?q0N5ouXG7hQ8UNpU5Q3wbdxcAvAlixSGDXfo/0txEwDWu7A6yVyEeoGI7Vdw?=
 =?us-ascii?Q?wDixxJxyuQ5hTg3P8QU75fjUCD/AcUk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA6D19410814AA49A51EFC41E82262AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfb9039-23fb-483f-888a-08da37844e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 21:37:41.0452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmJAybRUybK6jMNt3uc6PUAr8NVJmOZq5TNn2iz4hrV+w+9XrTgqZRTDCZh4jSM4ODfH4T/c+OrYOS9970phSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_15:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160121
X-Proofpoint-GUID: nz-xwKAlKqLP2t6j-zYLe8jkIGyZ0Wk7
X-Proofpoint-ORIG-GUID: nz-xwKAlKqLP2t6j-zYLe8jkIGyZ0Wk7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 16, 2022, at 4:35 PM, Anna.Schumaker@Netapp.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Rather than relying on the underlying filesystem to tell us where hole
> and data segments are through vfs_llseek(), let's instead do the hole
> compression ourselves. This has a few advantages over the old
> implementation:
>=20
> 1) A single call to the underlying filesystem through nfsd_readv() means
>   the file can't change from underneath us in the middle of encoding.
> 2) A single call to the underlying filestem also means that the
>   underlying filesystem only needs to synchronize cached and on-disk
>   data one time instead of potentially many speeding up the reply.
> 3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_DAT=
A
>=20
> I also included an optimization where we can cut down on the amount of
> memory being shifed around by doing the compression as (hole, data)
> pairs.
>=20
> This patch not only fixes xfstests generic/091 and generic/263
> for me but the "-g quick" group tests also finish about a minute faster.
>=20
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

Hi Anna, some general comments on the NFSD pieces:

- Doesn't READ have the same issue that the file bytes can't change
  until the Reply is fully sent? I would think the payload data
  can't change until there is no possibility of a transport-layer
  retransmit. Also, special restrictions like this should be
  documented via code comments, IMHO.

- David Howells might be interested in this approach, as he had some
  concerns about compressing files in place that would appear to
  apply also to READ_PLUS. Please copy David on the next round of
  these patches.

- Can you say why the READ_PLUS decoder and encoder operates on
  struct xdr_buf instead of struct xdr_stream? I'd prefer xdr_stream
  if you can. You could get rid of write_bytes_to_xdr_buf,
  xdr_encode_word and xdr_encode_double and use the stream-based
  helpers.

- Instead of using naked integers, please use multiples of XDR_UNIT.


> ---
> fs/nfsd/nfs4xdr.c | 202 +++++++++++++++++++++++-----------------------
> 1 file changed, 102 insertions(+), 100 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index da92e7d2ab6a..973b4a1e7990 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4731,81 +4731,121 @@ nfsd4_encode_offload_status(struct nfsd4_compoun=
dres *resp, __be32 nfserr,
> 	return nfserr;
> }
>=20
> +struct read_plus_segment {
> +	enum data_content4 type;
> +	unsigned long offset;
> +	unsigned long length;
> +	unsigned int page_pos;
> +};
> +
> static __be32
> -nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof,
> -			    loff_t *pos)
> +nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_read =
*read,
> +		      unsigned long *maxcount, u32 *eof)
> {
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file =3D read->rd_nf->nf_file;
> -	int starting_len =3D xdr->buf->len;
> -	loff_t hole_pos;
> -	__be32 nfserr;
> -	__be32 *p, tmp;
> -	__be64 tmp64;
> -
> -	hole_pos =3D pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	if (hole_pos > read->rd_offset)
> -		*maxcount =3D min_t(unsigned long, *maxcount, hole_pos - read->rd_offs=
et);
> -	*maxcount =3D min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->=
buf->len));
> -
> -	/* Content type, offset, byte count */
> -	p =3D xdr_reserve_space(xdr, 4 + 8 + 4);
> -	if (!p)
> -		return nfserr_resource;
> +	unsigned int starting_len =3D xdr->buf->len;
> +	__be32 nfserr, zero =3D xdr_zero;
> +	int pad;
>=20
> +	/* xdr_reserve_space_vec() switches us to the xdr->pages */
> 	read->rd_vlen =3D xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxco=
unt);
> 	if (read->rd_vlen < 0)
> 		return nfserr_resource;
>=20
> -	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
> +	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_file,
> +			    read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
> +			    maxcount, eof);
> 	if (nfserr)
> 		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount))=
;
> +	xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount));
>=20
> -	tmp =3D htonl(NFS4_CONTENT_DATA);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
> -	tmp64 =3D cpu_to_be64(read->rd_offset);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
> -	tmp =3D htonl(*maxcount);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
> -
> -	tmp =3D xdr_zero;
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
> -			       xdr_pad_size(*maxcount));
> +	pad =3D (*maxcount&3) ? 4 - (*maxcount&3) : 0;
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero, pad);
> 	return nfs_ok;
> }
>=20
> +static void
> +nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
> +			       struct read_plus_segment *segment,
> +			       unsigned int *bufpos, unsigned int *segments)
> +{
> +	struct xdr_buf *buf =3D xdr->buf;
> +
> +	xdr_encode_word(buf, *bufpos, segment->type);
> +	xdr_encode_double(buf, *bufpos + 4, segment->offset);
> +
> +	if (segment->type =3D=3D NFS4_CONTENT_HOLE) {
> +		xdr_encode_double(buf, *bufpos + 12, segment->length);
> +		*bufpos +=3D 4 + 8 + 8;
> +	} else {
> +		size_t align =3D xdr_align_size(segment->length);
> +		xdr_encode_word(buf, *bufpos + 12, segment->length);
> +		if (*segments =3D=3D 0)
> +			xdr_buf_trim_head(buf, 4);
> +
> +		xdr_stream_move_segment(xdr,
> +				buf->head[0].iov_len + segment->page_pos,
> +				*bufpos + 16, align);

The term "segment" is overloaded in general, and in particular
here. xdr_stream_move_subsegment() might be a less confusing
name for this helper.

However I don't immediately see a benefit from working with the
xdr_buf here. Can't you do these operations entirely with the
passed-in xdr_stream?


> +		*bufpos +=3D 4 + 8 + 4 + align;
> +	}
> +
> +	*segments +=3D 1;
> +}
> +
> static __be32
> -nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> -			    struct nfsd4_read *read,
> -			    unsigned long *maxcount, u32 *eof)
> +nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
> +				struct nfsd4_read *read,
> +				unsigned int *segments, u32 *eof)
> {
> -	struct file *file =3D read->rd_nf->nf_file;
> -	loff_t data_pos =3D vfs_llseek(file, read->rd_offset, SEEK_DATA);
> -	loff_t f_size =3D i_size_read(file_inode(file));
> -	unsigned long count;
> -	__be32 *p;
> +	enum data_content4 pagetype;
> +	struct read_plus_segment segment;
> +	struct xdr_stream *xdr =3D resp->xdr;
> +	unsigned long offset =3D read->rd_offset;
> +	unsigned int bufpos =3D xdr->buf->len;
> +	unsigned long maxcount;
> +	unsigned int pagelen, i =3D 0;
> +	char *vpage, *p;
> +	__be32 nfserr;
>=20
> -	if (data_pos =3D=3D -ENXIO)
> -		data_pos =3D f_size;
> -	else if (data_pos <=3D read->rd_offset || (data_pos < f_size && data_po=
s % PAGE_SIZE))
> -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size)=
;
> -	count =3D data_pos - read->rd_offset;
> -
> -	/* Content type, offset, byte count */
> -	p =3D xdr_reserve_space(resp->xdr, 4 + 8 + 8);
> -	if (!p)
> +	/* enough space for a HOLE segment before we switch to the pages */
> +	if (!xdr_reserve_space(xdr, 4 + 8 + 8))
> 		return nfserr_resource;
> +	xdr_commit_encode(xdr);
>=20
> -	*p++ =3D htonl(NFS4_CONTENT_HOLE);
> -	p =3D xdr_encode_hyper(p, read->rd_offset);
> -	p =3D xdr_encode_hyper(p, count);
> +	maxcount =3D min_t(unsigned long, read->rd_length,
> +			 (xdr->buf->buflen - xdr->buf->len));
>=20
> -	*eof =3D (read->rd_offset + count) >=3D f_size;
> -	*maxcount =3D min_t(unsigned long, count, *maxcount);
> +	nfserr =3D nfsd4_read_plus_readv(resp, read, &maxcount, eof);
> +	if (nfserr)
> +		return nfserr;
> +
> +	while (maxcount > 0) {
> +		vpage =3D xdr_buf_nth_page_address(xdr->buf, i, &pagelen);
> +		pagelen =3D min_t(unsigned int, pagelen, maxcount);
> +		if (!vpage || pagelen =3D=3D 0)
> +			break;
> +		p =3D memchr_inv(vpage, 0, pagelen);
> +		pagetype =3D (p =3D=3D NULL) ? NFS4_CONTENT_HOLE : NFS4_CONTENT_DATA;
> +
> +		if (pagetype !=3D segment.type || i =3D=3D 0) {
> +			if (likely(i > 0)) {
> +				nfsd4_encode_read_plus_segment(xdr, &segment,
> +							      &bufpos, segments);
> +				offset +=3D segment.length;
> +			}
> +			segment.type =3D pagetype;
> +			segment.offset =3D offset;
> +			segment.length =3D pagelen;
> +			segment.page_pos =3D i * PAGE_SIZE;
> +		} else
> +			segment.length +=3D pagelen;
> +
> +		maxcount -=3D pagelen;
> +		i++;
> +	}
> +
> +	nfsd4_encode_read_plus_segment(xdr, &segment, &bufpos, segments);
> +	xdr_truncate_encode(xdr, bufpos);
> 	return nfs_ok;
> }
>=20
> @@ -4813,69 +4853,31 @@ static __be32
> nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
> 		       struct nfsd4_read *read)
> {
> -	unsigned long maxcount, count;
> 	struct xdr_stream *xdr =3D resp->xdr;
> -	struct file *file;
> 	int starting_len =3D xdr->buf->len;
> -	int last_segment =3D xdr->buf->len;
> -	int segments =3D 0;
> -	__be32 *p, tmp;
> -	bool is_data;
> -	loff_t pos;
> +	unsigned int segments =3D 0;
> 	u32 eof;
>=20
> 	if (nfserr)
> 		return nfserr;
> -	file =3D read->rd_nf->nf_file;
>=20
> 	/* eof flag, segment count */
> -	p =3D xdr_reserve_space(xdr, 4 + 4);
> -	if (!p)
> +	if (!xdr_reserve_space(xdr, 4 + 4))
> 		return nfserr_resource;
> 	xdr_commit_encode(xdr);
>=20
> -	maxcount =3D min_t(unsigned long, read->rd_length,
> -			 (xdr->buf->buflen - xdr->buf->len));
> -	count    =3D maxcount;
> -
> -	eof =3D read->rd_offset >=3D i_size_read(file_inode(file));
> +	eof =3D read->rd_offset >=3D i_size_read(file_inode(read->rd_nf->nf_fil=
e));
> 	if (eof)
> 		goto out;
>=20
> -	pos =3D vfs_llseek(file, read->rd_offset, SEEK_HOLE);
> -	is_data =3D pos > read->rd_offset;
> -
> -	while (count > 0 && !eof) {
> -		maxcount =3D count;
> -		if (is_data)
> -			nfserr =3D nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
> -						segments =3D=3D 0 ? &pos : NULL);
> -		else
> -			nfserr =3D nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
> -		if (nfserr)
> -			goto out;
> -		count -=3D maxcount;
> -		read->rd_offset +=3D maxcount;
> -		is_data =3D !is_data;
> -		last_segment =3D xdr->buf->len;
> -		segments++;
> -	}
> -
> +	nfserr =3D nfsd4_encode_read_plus_segments(resp, read, &segments, &eof)=
;
> out:
> -	if (nfserr && segments =3D=3D 0)
> +	if (nfserr)
> 		xdr_truncate_encode(xdr, starting_len);
> 	else {
> -		if (nfserr) {
> -			xdr_truncate_encode(xdr, last_segment);
> -			nfserr =3D nfs_ok;
> -			eof =3D 0;
> -		}
> -		tmp =3D htonl(eof);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
> -		tmp =3D htonl(segments);
> -		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> +		xdr_encode_word(xdr->buf, starting_len,     eof);
> +		xdr_encode_word(xdr->buf, starting_len + 4, segments);
> 	}
> -
> 	return nfserr;
> }
>=20
> --=20
> 2.36.1
>=20

--
Chuck Lever



