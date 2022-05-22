Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5579C530037
	for <lists+linux-nfs@lfdr.de>; Sun, 22 May 2022 03:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiEVBly (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 May 2022 21:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEVBly (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 May 2022 21:41:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7ED30F4E
        for <linux-nfs@vger.kernel.org>; Sat, 21 May 2022 18:41:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24LL018N009797;
        Sun, 22 May 2022 01:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=p+S9dtssvL+uJE7ocYIE6eRER/RiL3ZeO/FhuHmE6+A=;
 b=vgDYqsyvYoEyufK+HM5dygTxYgDe7sbwfXiRUIUeCkYghWxosS7eT58AozgJeqCPGmyH
 oHdBGja04QPu6kHBfTLwznV7XFERFkn99Sgt5Qhzf1aqOsqn3FlFQaV/m0rbczJVUA+u
 WQ+ovjz45ITX2JtFN0OSujrQOA0uWbamZgYKoiXlEMCDd7rOdyycfV0y67gM6mdC4Apu
 x/DxdGUG4iKwezfwTCivi+l/d0LJooek5A1NZKjSVLtPgz8cwChTVE/vPSVI8zbmtJlz
 OjRSfi+ZDi8UATUVyOknTNcX3Z0O7RT5XTX6Kt4faaVnG6tlN+Mrr+KHmbL295wSlJFD tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps0yj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 01:41:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24M1ecKA002995;
        Sun, 22 May 2022 01:41:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph0k458-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 01:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMf7SHnGoWGY3hd0GIKGKK4UcOhMbZ1UAsN0McIvYOUQjMNMvALouSI0x+LGbfkWA4hmCfLDbvexTWQCbf2qe8OyTk7mxBFqRmGKzC7rjgMH6IkyOknUT2W6eLdompcaaf6ApAFcIgVHKkaouG3aGxMkgZQlYHLRRz5E8Ye/KBtDaNEb4LTIsPUkikjSqt5ZDN+7Ezx7FQn1F24u9jyfqfJNVAsDf74SgJqzykL/RrxMB4Rj332V1sjFwBfUuIabXibHrKRmsJX48af5aRW7E4ppSlHe3PJDCpUf4h5wVb3oT9To/q5pYTZ+qXL6U0tZ/o3IrSONc0dye0MgXtFjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+S9dtssvL+uJE7ocYIE6eRER/RiL3ZeO/FhuHmE6+A=;
 b=hcaEVBPyozS9Ih3u6/i/CzgG6xY8iSSSCFoomIW+u79sNQ1blfNDFb34Lj47GL0uDX0DojTZPckFzfnSP6APPIWvwoK+NBK1T1HhuISTB43PHYR12nx/Co8yIzAECY+2ArFQSAxYHGijzp9eOceO9jY25+MMNNqZdRiaeFUAkWVJBfd68tDwbTQQXTfNbE5VamypICvE8wVnuLpLvZ0SFHTJE7JOa9rOXVdqfj4XiaZzk2OrZL4wT4ksGRa22SSQPNfAsFkU43NjsVbekaby/0s3wOdJZjreItp7bVt9khWbX/kdZNxT1StnI2jSDTtc9K3wL4zVyv7bwql2gieVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+S9dtssvL+uJE7ocYIE6eRER/RiL3ZeO/FhuHmE6+A=;
 b=kJm8a9bG8QDcxH7whN3UYUfx5ruZOswqq/7iXd37Ipdk6YdorR/QwwSHZK2sTDPr1zanoZRJppLWi5AOzUdC9mKUeW7Vu8CPasXMjGSjdgwca7iTJO+icvO8SiFIOL5l8y6ysQTlh6M9Yx0CCxr0p8Erc2rwJRNQmeNz4ZMNHwE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3619.namprd10.prod.outlook.com (2603:10b6:408:b9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Sun, 22 May
 2022 01:41:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 01:41:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kinglong Mee <kinglongmee@gmail.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xprtrdam: Don't treat a call as bcall when bc_serv is
 NULL
Thread-Topic: [PATCH] xprtrdam: Don't treat a call as bcall when bc_serv is
 NULL
Thread-Index: AQHYbPhRTH/mCNjc006EIN3BpXQOha0phy2AgACUIQCAAATtAA==
Date:   Sun, 22 May 2022 01:41:43 +0000
Message-ID: <9F4E9614-9891-4787-86DC-944BEB45C960@oracle.com>
References: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
 <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
 <09f0b58c-37d7-4b8d-0285-01ec11601d01@gmail.com>
In-Reply-To: <09f0b58c-37d7-4b8d-0285-01ec11601d01@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12e093fe-36e5-4df4-e452-08da3b9439fc
x-ms-traffictypediagnostic: BN8PR10MB3619:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3619287044BBC1B166A98C1593D59@BN8PR10MB3619.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nF/cPY5i8LFkXhHRYERsuFNXVGmGKt6KYVaypfOcf2JHYidp68Gj5uyvkKjet3J7rgGiCczN9yDIRrEmXncI54huxrd9qZBvkH4/gYTkUr9SOVabgcmkA8QQlkb2MDGOwKuQVPxKuYen+LdBxVpAOFfz2b29aqsnyameP9104n5YZziAkMrF+fvTBK77/rrjsHUZf4yKpAYObTYqFjcmteyruCMDC3x0BBdOAaevdsizpQwn3sfTroTMZrFdDw7zp2QMDkF8VQFsU2oqBXTFltd4HFx3t5kIA+2Ymv5sdILxh5bKYtK0AzNrCV5C/J0Huwi/p3oJsgugNsIyoeJTSbvx8/gG/ol6W+gkCrnF95g5lp9pxb+eDgQcdx2r/cohdXq6HSd6Dz6U1WNcmPn0Eo8PRil0+248d/23QwHSo70cs79qrqTycPJh/gOZjrT+ww7DcWa8zJKhgJC3Lyf1YbpW0WSA7DasvsiBnUGPLCvpyViQhztGHUEGvJaFYts4ZVqIvH/bHoRI2E6CosCVKChv0bB/7/HTpv0VckudRVhtTFp3X35XAmi4H/8MxuAfr3ToNEY7SwtHaToIAZucdQbFDwwByA99WHZCpdkcHSFIYW1E9eTOfCzBzo+CvkqSBU5VCDAtRRO+FOCXUHgca54cqTEz2qijfmMo/v8AEE71Djd2HKNIQndvwCI2SndIp+OAJWeOLO+FgOQx2k80LmBPnx+3atdx365p9iFPkQ6sdvj80OtLfd5hI1+Rq2pT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(53546011)(6506007)(71200400001)(6916009)(38100700002)(122000001)(38070700005)(33656002)(508600001)(6486002)(83380400001)(186003)(2616005)(86362001)(8936002)(54906003)(5660300002)(64756008)(316002)(66446008)(66556008)(66476007)(2906002)(91956017)(4326008)(76116006)(66946007)(8676002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Is/tZiZZhMyOndDS3LznVS9F4+RdzfraUZ+uGUABqRDl6SBB1HtslModOjfc?=
 =?us-ascii?Q?Rwyd/K3ZIpT9GjMavgxyRvLC5Dhd4XTuFuDObemjOO1ZAfYd3KN0drtl11UZ?=
 =?us-ascii?Q?n5ePNWKaq5KarQ3wwxgLRTfHQV52dmASRZaxk3O3mE7z9sH1JsZX71GfC0HE?=
 =?us-ascii?Q?CcybjBHZvyyzyavRcLRFW//cYA3vavxFtw/ceR0zzytd6rTehRejMjeEGjzp?=
 =?us-ascii?Q?Tzr96t7FqYbdfqcDZ07JTtmr0z0RShP0QVhDhwscJMcGTZfeqcn3Ak5kxmCO?=
 =?us-ascii?Q?FUTS7SB8UBxacAeyFga2XegMPdwRdaRrZG/cmxLXh4TlwGWpdy7m9TPg1Rg5?=
 =?us-ascii?Q?KqAZBzydqM9P2UbOLL/+9M3+Pwy0BelzMGf9YFdFdRQKiLkeda5LK7QaTBqs?=
 =?us-ascii?Q?ZCgQ5xCs3zEcrzR0MpfNzk5gMqhEsnhgtT07Wd4KBvbfjJ+qhDkG0l6X3HKs?=
 =?us-ascii?Q?ekhiYpz0FBj7dvFQtvHUqTXlY9HXwlRUoEHEC/y16pj78SajMsefZHJikSTh?=
 =?us-ascii?Q?XyxIDXEEt8ZEH5bevW3srVnl0U64BIYLTNxugZhuCmm9qLtl/HuVLNdvYYjG?=
 =?us-ascii?Q?/vAk2hm4i+cAn4cm0fI1Mje2k906u2Aqzdkl04+JAat9dClHh9ngNAc53GJG?=
 =?us-ascii?Q?K9JqJwCY+2fmPtI0N0iRuC+FDhpGY+LGNFRP/l1M8Fy5WePYFi/bDkI59h1P?=
 =?us-ascii?Q?WvL/XM2Kw8Slo9wfANU2PbxYJbpnua3WzL/+5iBG3degSf0jsFMFnpGMFJT5?=
 =?us-ascii?Q?/9YixHAU8cLJWtiE7Ys4+vHclA9ILpa+WKqzRI3FALKEPZ2DWPljyWjkySGp?=
 =?us-ascii?Q?5jubBOgY2teSctRcjDAMT40t2jtiZeiOEpBJXHrqwrT8COv1eamRkmKtuPNT?=
 =?us-ascii?Q?qKDjQq4OKL8EhugVy2RMbRjfP3PiymugAR1fTvX4TWBliIpbLKc+kGYmA6AH?=
 =?us-ascii?Q?W2RMvZFepm/nDiKZqxyKb8qFKvNgh4gPB3ZpsUZ8H5Uy5D5TkQGtnxnvNsvi?=
 =?us-ascii?Q?187vtdg6wO/n3pDRpct8oaVcJ7C73zX1wpuUgGXIIvwZ2bPR392wSbtNd0Af?=
 =?us-ascii?Q?AEYmeClQvnfDXoCKOVvvKI4j9AZBv8NSOZLoGzVK4TEfv06FYBihd7i0C2IL?=
 =?us-ascii?Q?GY9wcEWvGOV0O83qaNFcz5tPdh9mJ/crzA9Sk0Ybtlq1dTI3l28shBuFNetf?=
 =?us-ascii?Q?D3G4fk67JBEAb/9byiWRzoiwX6b2hU/y7weaRGGCbk1uVA3NcqFADUTvg9V1?=
 =?us-ascii?Q?Gp+a5pztkByqmu+F6z6f74H6IHul54Om5LtxiJjEVVST5VD9uY5qbEas6RGh?=
 =?us-ascii?Q?SBxbIwqf6UgClTB6sv2Txko6ICIcKNcTXKuio69FfWd2WkKZPiURUU23cJZP?=
 =?us-ascii?Q?ebOYPlTEslvMiKZ3Tq+rW8eSzAsmFffeRS8vrECNPTilsCtobWiNei8G1YL7?=
 =?us-ascii?Q?bLkWs7lozzujRx07WMPq14i8eTxKrqecsYsVjkXlVaI8E9fF+Ch5+vuxJfR/?=
 =?us-ascii?Q?c4fNgxYyiog3z7/demyPvw1ds6TVTrIaYXInRI0S1U5lZvsFiPRZqadVoEpq?=
 =?us-ascii?Q?jw+coE578CyLDsgBEvpqD9uKn+eCYP0t1yjovSn3a//DjbMQP43pw20S3wk7?=
 =?us-ascii?Q?GbE40SbDgC9poDNedAmUmScUEem/40BDesUOOqsms4pTMdqn8nbQtET2YEOz?=
 =?us-ascii?Q?etg3V3aIM33uNC+LMRnDw4C1dHPpibXbk/0SbqDYSkK2/ls6iQPZD5B9pg9U?=
 =?us-ascii?Q?qqjlNh44EaatbvCcXCnPGhZw+CvWqeY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8BF3CAD8FB6674791D581CB0F4395A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e093fe-36e5-4df4-e452-08da3b9439fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2022 01:41:43.9951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYq0gtjHXO2xAhvlgBcKy8Ll5jNge7jsY07TeoDiIYTQ1UokCl/MLIFkiFGw/yM76DgwylmWp4yK8BxO6rcXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3619
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-21_08:2022-05-20,2022-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205220008
X-Proofpoint-ORIG-GUID: X9yIRVQo8HkD3f2pp1cp0Bl-pis17CO5
X-Proofpoint-GUID: X9yIRVQo8HkD3f2pp1cp0Bl-pis17CO5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 21, 2022, at 9:24 PM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>=20
> Hi Chuck,
>=20
> On 2022/5/22 12:33 AM, Chuck Lever III wrote:
>>> On May 21, 2022, at 5:51 AM, Kinglong Mee <kinglongmee@gmail.com> wrote=
:
>>>=20
>>> When rdma server returns a fault reply, rpcrdma may treats it as a bcal=
l.
>>> As using NFSv3, a bc server is never exist.
>>> rpcrdma_bc_receive_call will meets NULL pointer as,
>>>=20
>>> [  226.057890] BUG: unable to handle kernel NULL pointer dereference at=
 00000000000000c8
>>> ...
>>> [  226.058704] RIP: 0010:_raw_spin_lock+0xc/0x20
>>> ...
>>> [  226.059732] Call Trace:
>>> [  226.059878]  rpcrdma_bc_receive_call+0x138/0x327 [rpcrdma]
>>> [  226.060011]  __ib_process_cq+0x89/0x170 [ib_core]
>>> [  226.060092]  ib_cq_poll_work+0x26/0x80 [ib_core]
>>> [  226.060257]  process_one_work+0x1a7/0x360
>>> [  226.060367]  ? create_worker+0x1a0/0x1a0
>>> [  226.060440]  worker_thread+0x30/0x390
>>> [  226.060500]  ? create_worker+0x1a0/0x1a0
>>> [  226.060574]  kthread+0x116/0x130
>>> [  226.060661]  ? kthread_flush_work_fn+0x10/0x10
>>> [  226.060724]  ret_from_fork+0x35/0x40
>>> ...
>>>=20
>>> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
>>> ---
>>> net/sunrpc/xprtrdma/rpc_rdma.c | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>=20
>>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_r=
dma.c
>>> index 281ddb87ac8d..9486bb98eb2f 100644
>>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>>> @@ -1121,9 +1121,14 @@ static bool
>>> rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
>>> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
>>> {
>>> +	struct rpc_xprt *xprt =3D &r_xprt->rx_xprt;
>>> 	struct xdr_stream *xdr =3D &rep->rr_stream;
>>> 	__be32 *p;
>>>=20
>>> +	/* no bc service, not a bcall. */
>>> +	if (xprt->bc_serv =3D=3D NULL)
>>> +		return false;
>>> +
>>> 	if (rep->rr_proc !=3D rdma_msg)
>>> 		return false;
>> I'm not sure what you mean above by "fault reply".
>> The check here for whether the RPC/RDMA procedure is an RDMA_MSG
>> is supposed to be enough to avoid any further processing of an
>> RDMA_ERR type procedure.
>> What kind of fault has occurred? Can you share with us the
>> actual RPC/RDMA transport header that triggers the BUG?
>=20
> I have a nfs rdma server, but it handles drc reply wrongly sometimes,
> it returns a bad format reply to nfs client.
> Nfs rdma client treats the bad format reply as a bcall, and

Doesn't this test return false:

1144         if (*p !=3D cpu_to_be32(RPC_CALL))
1145                 return false;

But OK: a malicious NFSv3 server can trigger a client crash.
That's a bug.

This is an additional conditional in a hot path. Would it make
sense to move the new test to just after 1145?

Even then, it could be a bcall, the client simply isn't
prepared to process it. So "/* no bc service */" by itself
would be a more accurate comment.

--
Chuck Lever



