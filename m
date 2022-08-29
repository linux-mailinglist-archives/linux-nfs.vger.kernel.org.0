Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C15A4EB3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH2N7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 09:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH2N7y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 09:59:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1455BA
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 06:59:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TDulQZ027736;
        Mon, 29 Aug 2022 13:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=So+sHuV09WgXZaRAbvlnLDRfvIdoFMuZTFZO0TU3fm8=;
 b=I1oF2pq8zXK5MC2n174k18JRU0h0gLFlsxZWYk27unlorI/VKksCqx5W8J2NTHITf2Sq
 zBXg77gmJTbOS2YKrUMgQiwfQUU3R3EQo4UbIgApma+yVfZ5mpQpThKEm9a/GzNJJnKm
 cnfbtu4Qf98gt1uEpCQV/r4X1X/p6DzYWrurKDEomu5d3JgrOGVLx1dyo+nFWBaKrfU2
 Of+hEx/YALtBeFljb8WVCK1Ly1ppUoUzHYtpA+42WOj40JJT0gg0pHUNMEmYCpG9GF3D
 Uz5GN3En3vZyWhXM36saqdluK8Kb6VjwRLCHlOuzAmmvuFpeAfK9UJR6UMojjPvBN0ar HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59uduw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 13:59:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TDXEHr002848;
        Mon, 29 Aug 2022 13:59:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q2n6g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 13:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj6YLCy9rdgNlNVjfkthB91t2vr3qpVrfDSkJ1HuwHShKvnG8wACGKc26WKqYQiq3Be/dddJO2x+szWnZcwglv9BJsCIIOUF3WtpW9b1WNHIAf7URcbRFCOSHY0hpr5G5CRBHMuhx222ehHhKEXAuyTPBDEEHNvED6Ab+dokl8L6jsRrEmfZPEWuEokwalwNK0q+gcAb4oII8RBCK+kA2LrxSD1qGUnnuzRIENk+G9J39zAjDkq7ofa1k3aC5m+X61x2EN5cac33ak2Y2o/5MA21stDCvCf3cBjFsjHsaCTr8HIjTnN9JxiQs0GZ1sjAl3i6dtWA4ATMHnP08CSUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So+sHuV09WgXZaRAbvlnLDRfvIdoFMuZTFZO0TU3fm8=;
 b=HOKbTQE6UH4kv4tfLZNHRdusddel83UepNH9uRP/mB2HOe78uruWMTsJmRBCpTEF73ymn2PZb199+dk7yqxEYMKv7Q7AMS/STUTtNWtbpXcvHmzWtpqkZwBvrXu7umRMbv0a5uwyrqgKwb3h/R1F/CYdJxPm1O259RLr5PHly8x4pZAtv9yHxMDjUUwvJZHBaVigTRgET8socQNTQyeqe3tvXTiq2Kl4G9b4mVA0gMfasPD6+MFqfDSzFq5Pekyq9qFVEOkdZVhG5nPxGlPzMvh3v3xWtxe9HdunCwZLJd5I8tBHp+TBQEuXPFRmPeaEAH+nnNkk0Cyww+x/b4PEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So+sHuV09WgXZaRAbvlnLDRfvIdoFMuZTFZO0TU3fm8=;
 b=UD3UYy6FXkDqVgB8AhKkxuBlskylym9PIqIXGm1WtXWFZI6x1rzCHY+a158IdsqZIEs47p/IP2+zh6ba8gBz3QWWa86nUj+Na0ZRBSAbxN3ojVilQaFFV60tZ9Yq2+MHguzl4JjXfQwk9OrCNCbjHIEjKkbGbT1R0E0VR+qnHsU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 29 Aug
 2022 13:59:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 13:59:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] NFSD: Protect against READDIR send buffer overflow
Thread-Topic: [PATCH v2 3/7] NFSD: Protect against READDIR send buffer
 overflow
Thread-Index: AQHYuw8V9SqhFRyk0Ueur3ltd6tJEq3F5KYAgAAEaYA=
Date:   Mon, 29 Aug 2022 13:59:43 +0000
Message-ID: <25409EA4-8DE2-4FA8-A525-E5337428295C@oracle.com>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
 <166171263459.21449.18044553311121354704.stgit@manet.1015granger.net>
 <52a93203dbd9daa02814cc920a61066d6df2749e.camel@kernel.org>
In-Reply-To: <52a93203dbd9daa02814cc920a61066d6df2749e.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4622c71-3ab6-4fab-7fec-08da89c6b9cb
x-ms-traffictypediagnostic: SJ1PR10MB5932:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MtKCu/R5EVFCWHFFlQCrrAtFfTivDrN0TEm1F3B63OHj/L3TdFlGZlTVcGe6AHDTmTePXOYFlcEd/VqrrsQRB05Z54QtPBKUwD1CgrGwcL+ykb8RkIdoKhsRhp1lp+FBFCpAasm/saZ+V6j95229bKdaQTmC26zD8lA1NMNdiEal5kpJB/JEA9FgRB8KVczGk1nhC4s5mKIyk2Kg9uWcxmPH8g2Bd/cJ2zs/O0/yV7sHckmbqorjPrKWs9A4GYJycNgnesajC7Ha81Ps9qKDMXu1DS/KZ2hf+nXnFH/8Tu/PsvtlF10Vxt1Hdj5LaKjQ8g2r/Z00RGLB3jddZzmRpENiZZpo2Sa2H3Rf2y4rtIDhP2FkdtaWuM7BWuT+to6X1QQIBEzJnxDsYPANbwtm8ftR0HCd+A0iVUNuM8CeGYl7sLu3rreuW4Wd61I2EIRQrXpHqQ6P0IJmBCqxuzlKfPC+ARkX4qXU6aIn3u6hSyr4/VeD1fUdMIQj1HuRSaEche/AEiEAJ5QjIzVk+rnSWAjMiiGov2j7wOOQqHRv8gZhCwERiD3bjqFh5VrYeMNgw5HrR+RV0AFgzqFXaUUIjnw0hDRUx4SG4M0e4jU98G900ZPWtPlnaqVzVAJFKibBtbbMhEV7UoKeA6U07ru0dqXhNST0hqJS2HeEMHizCX+DUi221QpeZR1x7lkYyFiNvV93NjzCKeWiecoUfeKG8peSCh09W+NpLn/gv6iwx1Dul0uzCM/C6/TzCj6IGjhfLfy3iuUk0wGEZFL+hqJxLuTVA2DO5Ve+VZAg+Q+r3LE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(346002)(366004)(396003)(66446008)(66476007)(38100700002)(5660300002)(66946007)(122000001)(6486002)(33656002)(66556008)(6916009)(2906002)(8676002)(8936002)(38070700005)(478600001)(6512007)(36756003)(86362001)(76116006)(186003)(71200400001)(26005)(2616005)(64756008)(6506007)(4326008)(53546011)(91956017)(316002)(41300700001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pIFsVrYWY9MSGp5BK6le5X6Y/TuHDdRCniDKoG4xwIGcjnwTq+3rdjX2rvid?=
 =?us-ascii?Q?+6jthN9JI2s9cloZLSqZJXJ7Qpfaep1/VSU/0uIN75FODLQKjZ6vDjCrPZjU?=
 =?us-ascii?Q?SaW/xLJNQhXKm/fWtHMvlcaUqtFVVq5L0X3cQISGV5oP6AkwAXdBesmIiOQU?=
 =?us-ascii?Q?KWnxoz7lep+j60fhJ0xigceWr7F51oOUUNds4QBpLCS+r4kz0VJKKvcgTn9L?=
 =?us-ascii?Q?5560oImW0RE931zkg6T0kKBTypX9Oj9O1BJaXPYtJbfrOLA54L4TyJMbo3EO?=
 =?us-ascii?Q?oO64BUtgKaX0/rbRuDNJGOjVh8kSfUzA/Ih9kw5EUO8/2J0lyiGp0TinOzv9?=
 =?us-ascii?Q?R6I/xTuQvhiLbPugF4ooeQocwQscxnpb+uMtjsO8c2Zrpjsfe+Kpu5nLD8XN?=
 =?us-ascii?Q?9jpaFYfhc3Hi3m5jXxLPIMVeOVPi8yJBjglspjd4VgE5ZaZtmvWr7qMkK5Qr?=
 =?us-ascii?Q?ZWzTTRba9+pA33SZcMketyYD+V7uwVmu8q4z9oQUSp7jBpeJTH/tXK9KTxaB?=
 =?us-ascii?Q?4EWS7jr7MMB3VUcJhIlr43cQ8KaCNAx5rH0P+dKFInot02eKKeMZQYftM3tE?=
 =?us-ascii?Q?e7pc0C+cWWxqTXVtpnfN9Hys9Edh7vD7c3iKdnTAaj1ukOIePByEbVPBZdbh?=
 =?us-ascii?Q?LaGpZQMARgMnViWRYEIakdeK/8kWb0v9HUmPliuKipbti8nEuDWROaC+QNNq?=
 =?us-ascii?Q?V83o9xXJc9TZtYCtrvvgLUS6a2O1QPp+/i3ow+K+5nNa2BREma2vVnoKKXIZ?=
 =?us-ascii?Q?VDgK0ryXIB5y513pMe4i9bfpSYOoOfgZJF6P2vfvq8ugPt1BpEfIXH8dA3jK?=
 =?us-ascii?Q?LvCNhTDeepDCFGwOjceGUnfZ625YdwpehL1NOaaGgczFCQb4uAN/fMKGmI6r?=
 =?us-ascii?Q?aO7TpzBHwaYyPaCtb9wDXZcW/Mj3H7GJ51N1ZncV2JDoGqSzE3g+QDcInWEC?=
 =?us-ascii?Q?OoswCGyMNboLRlj85wgf4mRzs4N+6oIfYNJxlebkgxSEGCnWEGFnO+zP3o+9?=
 =?us-ascii?Q?/KNOtlq5fnTlVoJW99ysihrpaSZb1TzSidq2SDW3UZXTQoHW/e+fvCjCmmmM?=
 =?us-ascii?Q?ET+kFCKMT8/P+obUaTNtzDIUWm34tgEucd0J+4b2om+4KYGyzq55SAYSCGU0?=
 =?us-ascii?Q?NjB7ajx0Gr7KmhGX5OYyO5Nf/8wR2Vnl9gObomBrsH68ja1YRqwVlnpwI74g?=
 =?us-ascii?Q?psu/r5AiDHwXjbi6tdRzcnDXhHoLt//Lu+SoqUkpieRwRuG46Iu8VZnZIm4i?=
 =?us-ascii?Q?cdWt+Qn9/miZEXHtiTxesVwYtH1H8ydJbHOG6wyi7uU3M/jpohpdKedPZW8V?=
 =?us-ascii?Q?V2BgNenzpEa3ngXazRQUhzjuvl4O9EX4IPF6nhSv5YWFWS2VcDQc2ORLrj2/?=
 =?us-ascii?Q?hBEZPMosN8r8MScyWurBsxEXVz9KlhzGGYkg5fl4FgH96tE4WPsQ9apHKh5F?=
 =?us-ascii?Q?rDCZor5NJK/Dd6B2Z9a8eDtarqpkYB35aSBjtjpBrjAUMRGU7i0saJuMSY1S?=
 =?us-ascii?Q?QkylXrMukA0L8Oqlzxu1ZdaGaGcSSya4RZNSbo2J5SaT/S2JQnQ+Sx2pC+Mp?=
 =?us-ascii?Q?65Xc5If7ECcxNDTXTGmbRnOiEKBmCdJn5/YQtJglNiClVDmMBtW7HiW/xMbM?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E52019BEF8F43B42B5AA0B4B12282216@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4622c71-3ab6-4fab-7fec-08da89c6b9cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 13:59:43.9685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+7/TdSEUJ/Sn7xmFFXjhvk8mqypJE9e72RbKB3RwX1T83FfNywLvdPqw13wjDQ9msiupX1erPUxeb14BJYNfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290065
X-Proofpoint-ORIG-GUID: CB9oCHlSEjkPrPz4_lXb9HwWKch_gOR1
X-Proofpoint-GUID: CB9oCHlSEjkPrPz4_lXb9HwWKch_gOR1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 29, 2022, at 9:43 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2022-08-28 at 14:50 -0400, Chuck Lever wrote:
>> For many years, NFSD has conserved the number of pages held by
>> each nfsd thread by combining the RPC receive and send buffers
>> into a single array of pages. The dividing line between the
>> receive and send buffer is pointed to by svc_rqst::rq_respages.
>>=20
>=20
> nit: Given that you don't look at rq_respages in the patch below, the
> previous sentence is not particularly relevant. It might be better to
> just explain that rq_res describes the part of the array that is the
> response buffer, so we want to consult it for the max length.

Good point.


>> Thus the send buffer shrinks when the received RPC record
>> containing the RPC Call is large.
>>=20
>> nfsd3_init_dirlist_pages() needs to account for the space in the
>> svc_rqst::rq_pages array already consumed by the RPC receive buffer.
>> Otherwise READDIR reply encoding can wander off the end of the page
>> array.
>>=20
>> Thanks to Aleksi Illikainen and Kari Hulkko for discovering this
>> issue.
>>=20
>> Reported-by: Ben Ronallo <Benjamin.Ronallo@synopsys.com>
>> Fixes: f5dcccd647da ("NFSD: Update the NFSv2 READDIR entry encoder to us=
e struct xdr_stream")
>> Fixes: 7f87fc2d34d4 ("NFSD: Update NFSv3 READDIR entry encoders to use s=
truct xdr_stream")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs3proc.c |    5 ++---
>> fs/nfsd/nfsproc.c  |    5 ++---
>> 2 files changed, 4 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index a41cca619338..fab87e9e0b20 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -564,12 +564,11 @@ static void nfsd3_init_dirlist_pages(struct svc_rq=
st *rqstp,
>> 	struct xdr_buf *buf =3D &resp->dirlist;
>> 	struct xdr_stream *xdr =3D &resp->xdr;
>>=20
>> -	count =3D clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
>> -
>> 	memset(buf, 0, sizeof(*buf));
>>=20
>> 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
>> -	buf->buflen =3D count - XDR_UNIT * 2;
>> +	buf->buflen =3D clamp(count, (u32)(XDR_UNIT * 2), rqstp->rq_res.buflen=
);
>> +	buf->buflen -=3D XDR_UNIT * 2;
>> 	buf->pages =3D rqstp->rq_next_page;
>> 	rqstp->rq_next_page +=3D (buf->buflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>=20
>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>> index 7381972f1677..23c273cb68a9 100644
>> --- a/fs/nfsd/nfsproc.c
>> +++ b/fs/nfsd/nfsproc.c
>> @@ -567,12 +567,11 @@ static void nfsd_init_dirlist_pages(struct svc_rqs=
t *rqstp,
>> 	struct xdr_buf *buf =3D &resp->dirlist;
>> 	struct xdr_stream *xdr =3D &resp->xdr;
>>=20
>> -	count =3D clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
>> -
>> 	memset(buf, 0, sizeof(*buf));
>>=20
>> 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
>> -	buf->buflen =3D count - XDR_UNIT * 2;
>> +	buf->buflen =3D clamp(count, (u32)(XDR_UNIT * 2), rqstp->rq_res.buflen=
);
>> +	buf->buflen -=3D XDR_UNIT * 2;
>> 	buf->pages =3D rqstp->rq_next_page;
>> 	rqstp->rq_next_page++;
>>=20
>>=20
>>=20
>=20
> I wonder if a better fix would be to make svc_max_payload take the
> already-consumed arg space into account? We'd need to fix up the other
> callers of course.

svc_max_payload() is used in places where the server's maximum
payload value is desired and in other places where the request's
maximum payload value is desired (as in this case). We'd have to
sort these cases.

But, now that I'm looking at svc_max_payload() call sites, it
does appear that some of these will fall prey to the same bug.
Eg, nfsd3_proc_read().

So, let me do that audit and redrive the series.


> In any case, the patch itself looks fine:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



