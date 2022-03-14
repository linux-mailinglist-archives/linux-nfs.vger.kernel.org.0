Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB24D8730
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiCNOrZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiCNOrZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 10:47:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37BB41639;
        Mon, 14 Mar 2022 07:46:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ECkoI7018634;
        Mon, 14 Mar 2022 14:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rKCx/dRv5OKxVx+RNi//nSNXTXlo4TD7yYeldzsglNU=;
 b=BA8UfhT35uAm0fPF4x8el0h9UPMy5fDNNFvB0e9hqyGLL43BM9PdM9EaSgOQAQSyXGoj
 QMEoPD6zv4lmY2rvgh38yuCEKJjFrO51I8ye02cg26ivcVI+fm2llcq5BWz56zKxrkjA
 5iEPAakIE2DgXmhuyuWkiWsJKQrg+1RYoML/28zXl6gzV7Ud1/RpuDOPwspHSxhZWSEb
 JHW4h1IwCXVrdYQ+MyOAPEcHQGKb9vhUa8xQ35Ow1jsE+am8dHRwOtaTMNDko5fYDxiT
 7gRex3DtXF5DtxSLbICOMnMUXsBT7QJq6eysTfBad+M1OIgDsHv9UEAx+u3krUXY26gL bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rgd5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:46:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EEjKPj177908;
        Mon, 14 Mar 2022 14:46:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3020.oracle.com with ESMTP id 3et656t47w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIRnwLqmTFCubXYiNQs2z3dnjRBMppFrxIlUmvLrqjhI+ZIbgea6WiXO0fxHB+f99fYZWTgBatRW04kwx9u2Qe2tfc2ORzCGvkqAJ0KH2qbk9Y8ePXBP1KWD323b7rMmzwX9gJmSwvoHJqwI7Bd6utAzAUWFp5RX6o5BM2h1+4N7BC39yMb9tkPujKfi+Dl9bE2CSV+ray6ffV9xgRIGCVbVegJXkYy9obY3lH19TY9DWNd6NlyGn8fmFsEa2vcu7XY8Qb9aP/anZTnVjB4GYI2KjhPTX0BauOPliJrj/hxRtnS0zp8uQGZHL6PxfbLZAewZURkKL3/o2TbO7o6o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKCx/dRv5OKxVx+RNi//nSNXTXlo4TD7yYeldzsglNU=;
 b=L7L8KVU1rfNDRunBTyjKGZ2i3/HL7UefxlITZY+X0lXthGGLCobTdLY/XZc80ogUTM/BN5RaioRqch53mK9iTIlBNrbg1jRfe1CZb1hf42WUZu3X/LRx6PhRPOC0AbX0PTya12T35BCBII2GbHRw8ruVrMKN7O50jXaLgBhKQ9rdkhEWW6/RFZqY7zUY88TsR/wf9yd9XLd7lkGITiFWNbM+U7UABGDygAixyxkj4I15ofyVN3vYiHQpFzJyxTXw+jgP6QqiZthq4KujyzX4p7VT6tMegq8UBDBkpSItRIoTDzwpvkV9EaK+8ggzvkTSxJPIl5EiSCAijqM8Omyn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKCx/dRv5OKxVx+RNi//nSNXTXlo4TD7yYeldzsglNU=;
 b=wX+L1nGplaqOw1+Na8wisPhmuY/3u5HRvT7mmZsahghlGatgvHHIVyazM7DgjrdQwp3dBE0heXDXMO6/p9HOJXZ22baHpanrNoYlz0YPtb9vB4K3fMkpy6LN9xnYxshrBzRDrJ590Ov+2kjugA4ZfB1G+KLrWNKDuKGk3lMtCfY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4546.namprd10.prod.outlook.com (2603:10b6:303:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 14:46:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 14:45:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Thread-Topic: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Thread-Index: AQHYN603kl3z/l9gp0O8Q+O/wElPrKy+9RWA
Date:   Mon, 14 Mar 2022 14:45:59 +0000
Message-ID: <251A4166-DCCD-4C84-9819-F350D17A7298@oracle.com>
References: <20220314140958.GE30883@kili>
In-Reply-To: <20220314140958.GE30883@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0176975b-724f-40b7-2eb3-08da05c95ae7
x-ms-traffictypediagnostic: CO1PR10MB4546:EE_
x-microsoft-antispam-prvs: <CO1PR10MB45465DB3767BD534FB1C5877930F9@CO1PR10MB4546.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mr/IxX10wDQIcGlDh3w0FblRUCLLKnPReCfSo9pQd2OCVsS+TyPX4pTR6YcKK1wBQ+65suil5yOMBXDAH59xcw/lu+6nfEuPgpjWf0qKsgW25bfjJNyzqsdQ4Rgmly7Pn6QLfsyGT6IvHYYCFr/ERJsfN3YMqmq6QmhA8C2ZrPJiIMdqQgH9ZkSlEt7Wi2Te13HSeBQlgXKPzpbYpMIqD/r0iZS+BIjrPx/I1ySahhAGKbgv5es/z81wpBnsSDOohwQUjt7LOCqZPxk2/ByIreLWCwdOHCxm2DnBfgk0n9G72QYhaiGa7soz3fQSuy7d1a4HKBTS9UsoIfDj/u7J1DnMSY1YJX9pjdXE5990TC2UBCQtq7VA+OjKP1QCnGVnZtvazlE+XCdvTAXAxmqPYFtyGAKbdl2Lht3w5ZqhOUFckPhgOoC9fzPyxBUqIcnJYnKSQrXOwtcTdEpVlez3Ivag5a6o73p3LqxGse1O1xIfLxNj2WN9IvBHf1bkKMR3bkwHxOwxRR5+ePtPjv1NUKUKUJFmZeuqe5rSjUW2Ck2e4wArUErXYqYd06GG+1rVg1Yrb6HNr3Nt+JQi2+kB58Q/kKbekzRPLQ+D10SXA0X9whGgJnpejkeRe0n8RVfu+oOVb0ZSkkZkVSfSLIJA5sXOoLQSj5qq6rlTIbclvk7YiiofJNZ2lMYJNQfvq56wXCjIBWkDZlRJL9L2tpThcVtH+QftDPZc3G9tGSR8QwhYOF7eqeT4snpp0pv1Ubik
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(64756008)(36756003)(33656002)(122000001)(66946007)(8676002)(6862004)(76116006)(38100700002)(4326008)(6486002)(66446008)(86362001)(6512007)(508600001)(66476007)(71200400001)(38070700005)(37006003)(316002)(6636002)(66556008)(107886003)(2616005)(8936002)(5660300002)(6506007)(53546011)(2906002)(26005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MbbWjIkWWanvzfuQpQbXHTmKxnyocaX+IQ6Cq68Leiwg1qE9xBkYPOZnIsPG?=
 =?us-ascii?Q?QxvPFT2XhWg8oxAvngHbLSTzNGdslUnCy3tiAYjyd0JF0iZWnSgogt9p04UC?=
 =?us-ascii?Q?8yMSC68EbINBfi/01l0l7BGgd6vTYWzlucJQ6W5K0Og1sssIkRvBXSwiNsoO?=
 =?us-ascii?Q?vr00zGlCu1fIICu4YNqjJWXTFvzpsBKkUtdbOo65OfUzM2Xqfayy+BAeGelQ?=
 =?us-ascii?Q?omU3pzt0ucHgFza0VKKqa06gEFGGd6S55dcy2+BPVbUCGVlYyGPOV77kSrDK?=
 =?us-ascii?Q?XuJwLBb8vqxcGpS25Osd31RZGLR2WpEpcpZr/bmpyAOB8Clsr5KAenWUIoDQ?=
 =?us-ascii?Q?O0LseDbuGMO4atkn9+fCrhw5ZsljUEYUZrY7lfamLtJVZzOHPCjPOETPF9XF?=
 =?us-ascii?Q?nAcPcL36TOQs2nDR4KFMkAz44WxJZMl6A4XgQqEac7giQf+xCYRWDhmrelrx?=
 =?us-ascii?Q?7vlDRn1vzkoBFmEZ6CviYdSisaA8bNNBDRO6xHpiZ++kn0wkPDRGg8MHUlow?=
 =?us-ascii?Q?f4gN61Ampjj0e9EJFRjgf029iS4RNIQ6loKZgXmgr47YuDKM68evBzSQKNsb?=
 =?us-ascii?Q?Y0NPkkcghXJZOHsh9W8zTm/tZP0Od5wv45fZLWlFizKM51WWz5/6+dl68Cys?=
 =?us-ascii?Q?KsTw22cddmceK5ERefdDar5XzqlnOWwKlCIzRSVeGlnioRWAM7p4Mcv22KbQ?=
 =?us-ascii?Q?EDv8ld4TKdleoAjERIGX3YNarLzAaBX1CzYnGapH8Y3pZ49b2OLHxXR4Xj8H?=
 =?us-ascii?Q?sJOxbqRFqC5mg8NnnMVn2m/ttySrrxgJrqn1c2kp59FeF4f50YOjNMaLUpR/?=
 =?us-ascii?Q?/ugD1xWTXZeC1VWbV3uFBtEBp6rKTmklwAVw1IK3xM+dl+GTcJcM+5wbkacZ?=
 =?us-ascii?Q?Nu/3FL9mBzrkW6Rhn3HF0IcAcRR/jRtkrZq7GS8fTTpKTieo8QKRhSAaImHx?=
 =?us-ascii?Q?5aI+DUWwlM9q5fNsf2hJJmOB1wbZIRt5e3VQM3oZ7GxUGjAEb8dZwLkdfPW7?=
 =?us-ascii?Q?X2o6dHoHHxTKAATNAhePMVIO/1PbhguP3bS9I3HymtsTkYbEFRPHD0ImmYST?=
 =?us-ascii?Q?jRwXTjSzqD019WAuiQVzqWyy+4CH9xU++5ZD/1tby3eJmiOgQ1P2goHvfe0x?=
 =?us-ascii?Q?ikkaBJaVKfZ8b6wq9wFN0jbHHYYgyJ7/KJ0FMEmLg5RTDDZ34XAlQDgPHzQp?=
 =?us-ascii?Q?CbVvhNZ6J8unMtepdKBIiKALIKOU7DxRqB0YtrdH4nxQP/envYlu6kNoYCdN?=
 =?us-ascii?Q?5B9J4VusJrGDL0tEwne4JBOpcni90iwZb0Vvv6Uf9a+fqRS3Q2iWIyeXgXpG?=
 =?us-ascii?Q?djH0xxkrYlp35O55wkbWOYPl3QlhNEmM6zrV32Y5rbrm7HwXHxkkxCNnk70D?=
 =?us-ascii?Q?SuddHt11E66XPxtUQcRT59Osj6bIVq1V6G4E8D7dxMnJFubl4yaBABmSY5q5?=
 =?us-ascii?Q?aqnZXmK8JQ2DkJPYuOvnVA+ReG2UYYZDXg6QjOBZ9a2kkyPcTkdvIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02FFF317F700F74A9A199B5CC4D41018@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0176975b-724f-40b7-2eb3-08da05c95ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 14:45:59.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTB/oskmISkQ+lZdGpGzxvOF2UJIGZ0SoqCZiWC+98YLwiQON278FEuOlbkKtzPKbxXC20yBIl89eBOBqxfduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140093
X-Proofpoint-ORIG-GUID: SOGAoFMnlKShjwUCRKS5DLAl7L77ahF1
X-Proofpoint-GUID: SOGAoFMnlKShjwUCRKS5DLAl7L77ahF1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

> On Mar 14, 2022, at 10:09 AM, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>=20
> On a 32 bit system, the "len * sizeof(*p)" operation can have an
> integer overflow.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> It's hard to pick a Fixes tag for this...  The temptation is to say:
> Fixes: 37c88763def8 ("NFSv4; Clean up XDR encoding of type bitmap4")
> But there were integer overflows in the code before that as well.
>=20
> include/linux/sunrpc/xdr.h | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index b519609af1d0..61b92e6b9813 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -731,6 +731,8 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr=
,
>=20
> 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
> 		return -EBADMSG;
> +	if (len > ULONG_MAX / sizeof(*p))
> +		return -EBADMSG;

IIUC xdr_inline_decode() returns NULL if the value of
"len * sizeof(p)" is larger than the remaining XDR buffer
size. I don't believe this extra check is necessary.


> 	p =3D xdr_inline_decode(xdr, len * sizeof(*p));
> 	if (unlikely(!p))
> 		return -EBADMSG;
> --=20
> 2.20.1
>=20

--
Chuck Lever



