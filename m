Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7017966444C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 16:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjAJPRE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 10:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjAJPRD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 10:17:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5750E48
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 07:17:02 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AFFmSs006531;
        Tue, 10 Jan 2023 15:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gRElWAotqy19L70+YeJQMV/VVIYd8FaiSvW5WBrYg4Y=;
 b=dO9iKVA45XEBBdRLkuwj0aidNZkhC+7H8+0VjkPNs9I+Au0jplP9NnGgEs+y19nmd2Iu
 aYwKybw4EpTU+znXDNH2gZtHi0BCm2DAkeeodiBV4SPXcbrfznCGaTW5qZ5B+Q0i/kel
 n3YRG/N11z9ZpDlXo/mtjmj2AO6oMkR/cSniVVNNqd8mMkohkYSxv7PxN1LtKt7ZZyXP
 RsQfmvlXvDchMnsRyLNHSuvUZVneoPnMHv8yRFrh8UNazAczwmuavZsjtpTenF7ixuA2
 AMYbUD565CeYaJhnoPau3OinlLVQqOpHFK3uqQ090p3KocXyAyEh4kz3RMQUk0db1Bci 4A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n14nf8s6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:16:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AEmsDo008218;
        Tue, 10 Jan 2023 15:16:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1a439f94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN/u2GRvABDazqaWokCCcXH05NKF4QKsQDheeW/8MJvR6wMjMyYNImon2qgPfc+anHgzbJd8nOkvUQlMFoM1MjCpeh6l/Kh/caNQKy4Qla5b5XCptOXnjh+QqO2i87uOKzEezwrQLolz8A6d2fk9LnwDYpiYSYGbt+X24DNLCPjx4ViQW52x1KjJkb7jL9euyGVtUAaF8s6/VQ+ZVliajQMZUsb9SEUlIUTBybhb1KuI5dtv9SdN5lp4UwQTuQOoJixNotWCzkMGInVW6jBfLcZYjG5yxw/CsG7DzsFBC5lVtIexDHUlYg9ijyawQzOMFKvIjxQ4TsZVQ5/ncPomCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRElWAotqy19L70+YeJQMV/VVIYd8FaiSvW5WBrYg4Y=;
 b=AZABzJ5sxb24wSXIe9OVmZHufqYF/8+hPmLvkfz4HQPy/UMjqVNa/xYAmxWK9WVVuiqe1kvrn1QWJqWzUtaZsqHg9Yo0UtqnFp45StSRtv/8hiZSd/MMcKkqaW34ydeX7Vpah3GRlSLMj/dXrJIimZkL9+XLs4vEq6amoUD2Ch9QGktzI2E0jctW0YG03KY6ki4s5XpnImBp6qrcTZEEpumrJ4HcbTO/CFsDXzJRd4+lHXzTUJJPQU8c5aroOj736uCyYHMhurUXOCBtrUXaJ15z6MMBY0Cu9WcolgARHbP7ZT4aUf92b5KNUZC4FjiEjqNePAXuP5jpBzWzdTWx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRElWAotqy19L70+YeJQMV/VVIYd8FaiSvW5WBrYg4Y=;
 b=SEa27fGP831x5kTXHWG0jFtdb29VtAyhs4f0tWLS88z6rlerYAoAxfkjTwAiIPVPQQ/RJJBDzZ+WguozGuKvOpqo8FfgdphHQp6MkckgSRJY3oXP5rT4eJYakHy/okMpUVrLN6CKXWTgkPs7qWCFNknj8GsgPMacOrc3CKMq1T0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7295.namprd10.prod.outlook.com (2603:10b6:8:f7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 10 Jan 2023 15:16:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 15:16:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 00/27] Server-side RPC reply header parsing overhaul
Thread-Topic: [PATCH v1 00/27] Server-side RPC reply header parsing overhaul
Thread-Index: AQHZI37m5Qh52doLRkW9UASLLYSz/a6Xv50AgAAGhIA=
Date:   Tue, 10 Jan 2023 15:16:50 +0000
Message-ID: <CF69C362-B07E-49C0-8DB4-D1DC029A824E@oracle.com>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
 <64b51ef5ed4b11f8a6d59bf59ce0ab8c36ef454f.camel@kernel.org>
In-Reply-To: <64b51ef5ed4b11f8a6d59bf59ce0ab8c36ef454f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7295:EE_
x-ms-office365-filtering-correlation-id: dbbd9754-8fda-4e4b-87c1-08daf31db287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FmAmtyR2c+Jo7KDtzL3mBldwtRi7Zi5DgUyam33VFi63+TvHQ2VDv3e1jUkwNjQPr/eXRQ3q46S2wS1NNYuOIUYdT9YQbKS2rmXGPcOuLtHSsA6ork2x/M/7holPDClP9DeTI7RE/4OhxQEvLmn5uwy7x4Dx6LSHNn8lXkRp4dt+wDW1/YVByxu5h4XkTfjS79i6b3g7dOK9tNjq+2BC7eHS4qY158ikL1ZXxVueZfGguknj+//fGC6Jfe9Qq/zfdq2NbYp5dJjNEbOInUTjrK52a3qaoyPtUQXWGFAcuRYZhcRHdGv5AfWGOh6jwa/7BZVgIJZ+MgZEtgfYiEqlkkv3OZnCn9hgMo54GHz+kv64dNF6/bHoVM+BM2JDbBiARR6Ms4sU4IhVoN5VXts+MFdMJmvm/vkQSakIj02Fy93lBxjDkS+0goGhQmz3cwrrNxv6fScfH7UwV77u0q3HjvWKQqQJOI6aOUwk71ExUjPIlw2orGwSocIM1ZUZyLCbuI5y5B2rmzRGP2/4HijR3eyhIaORIj/dwB9LJFY0y/rwTloIPTc425jw4dBnxdtFcOJcqitzqXjy5dLFMYkGOVmReACvLcJJhupDhPfF/QP4qRbIHgwCaYCQVGBq4EBQUqbt7TKSllCTOML1SVBi1qZoxYXexLTDmgL1r0CgtauT1vMjhIUYjpPPPsypEG2n5NK8VacEmlZq3y+6Jo64yDkbxR1SE9sYo7tH+TRmg8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(316002)(26005)(6512007)(66556008)(186003)(8676002)(66446008)(66946007)(33656002)(64756008)(38070700005)(66476007)(76116006)(38100700002)(36756003)(5660300002)(53546011)(6506007)(41300700001)(8936002)(91956017)(478600001)(71200400001)(122000001)(2906002)(4326008)(54906003)(2616005)(83380400001)(86362001)(6916009)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D9GjQwZ08GRlakqRx4cM4sabWDVAe9ErJTQxHGMjtNJuEOGuhzGJp3PDpMbg?=
 =?us-ascii?Q?YKVNJVBEEEkA/crb8gcTagPA1NIi0GwwOgnvIBYcR++dx2TDIrvSETJ9j+Bu?=
 =?us-ascii?Q?fFTFMNJSBdoSLnQObULmo/EX/ShRcBgrgbM+SUYnGYL9tMF2YAUvCGDGVjpk?=
 =?us-ascii?Q?JvKd4UNPbf/mKiw2n2ZpFkY5XNgRGPHOtzUUMxdE1Yy8BR5evYmrYsjXsysv?=
 =?us-ascii?Q?NIcZ1yHmm8940nD9YPhSUvWk8d7YRFCyHHjtZZbKzuWMq5Sl0WEfuuUZMmhr?=
 =?us-ascii?Q?8XPdKHe/J/xG7CNAHlmbxVOwClHB2BtPAKk076E/tfo4FNiAXJhxCu+re9jx?=
 =?us-ascii?Q?Itby3gaTeddlONBFOV8ZB/o83gifO2qbwZxWZzRs0zU5PneOSo3PGIyIEfbM?=
 =?us-ascii?Q?xuZZrmaSAgw2MuSyKBdpQjiJtzdJbrnhs8p1iVqHojJsTTsmuvNcSkXwoe7w?=
 =?us-ascii?Q?0x2ijKGU4tiQZhgQEX5vpBdAWldkc1Z9gyK2T2xsG4f9xGEKGwFQlRxcmsCG?=
 =?us-ascii?Q?tC1LBh1gMILZp2qrNoxx29jd4DihJ7zUPNgtyf3nKmIWVIGt9ot1HRgbXZOS?=
 =?us-ascii?Q?Dc0GGvHHJZCm6lit5NK3aqtzX+SQnvRZKSqyRtR/73BSVPdYiKvt7IX9aIBc?=
 =?us-ascii?Q?fVre19SfY+/W/rB4TBM5lcwKZSSClrZqj0Wx7hE+XrSnUrmY/G7pndPBWPOm?=
 =?us-ascii?Q?lsCin5NivKqzl1j3NePd5Q4IcxewfpS54XjjBDACZmBfS8fuO8XdRx2ht3US?=
 =?us-ascii?Q?XBj1w/AKRXw2PyePmCwJPpFJrNMNHgG17gverfQUWS4MJGqSluh+wmi/oqmO?=
 =?us-ascii?Q?im0aItoQFYA7qvbbzV9MYZLHoaul+8E4dNh/uV++vYJinn9Hz2OwEbDD8dI/?=
 =?us-ascii?Q?8Lld7oUgH21ftyPTEq7OdmLZznYWz64i8m2ilGkDj/nWRd6tlnypjG+Pp8+M?=
 =?us-ascii?Q?KGC8iEXQctHlDJezmV9iBGJk38yzWh7x4pbHDC23TGM3ORBMt6qiT7rGJ9V9?=
 =?us-ascii?Q?j9PPi89cLYvDPvQs0nPRHS2SoF+DUaLfziUAtalMkxbnbMvQvSPMvonMHpwy?=
 =?us-ascii?Q?PTfnvrlpIcHwDFaJ/fjB8soMNZc3OeTEUTa56mnsyL3muiik3ISLlGqlj3ea?=
 =?us-ascii?Q?MK/RhTkyylW7E1PF9zsMLdxTe690nBl6n+gAu8UFRNiqb0T9/uXQy+C7qLXl?=
 =?us-ascii?Q?wzVWTyiaCjK0ZKYkEi8Ujt/Anq6/RBuRY6fGlbsIX7BjZWWO2UtpEj4/KfKy?=
 =?us-ascii?Q?jFsgjaN8bm+MuUKOCERHX3scwdv8SK9K2pRwJo6BnUSp9rwff0Vp/QVClHSR?=
 =?us-ascii?Q?oYasEJoQEm/dHwNDosjCscXG/lkXJlYL7jKZWciQYI2jWgbXRmnaOOsWouiA?=
 =?us-ascii?Q?eCVQnSC1oyyCQCWg1D6EM7oIpmFdFxnEjgOSrGd+NOtycCMDYNj01yoD3L03?=
 =?us-ascii?Q?nEVgMiGxAi6VjyJydXEXLox7vwpB5YaCEcoamHnt/Jvw4x8rGIol2Ieq1xM+?=
 =?us-ascii?Q?zMxMd1l/8NLVFhQNqc1aAltUdlfGN1dyhC6Lvzw3lltnuVGdv5eS4NUXpWXZ?=
 =?us-ascii?Q?Q1ECtsLIHDPsSS7CrluesPbz3VuwxLQQsGKEQ9FZpEOrl0FaQLmdSZIFwdUK?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C86E82C50BE184FBE75970BF520750B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fmhDQ8AW4S3/nG80mVoC5CICvIAFLbuT9B1Cq5MyUV6nRmJKX6rKr8Tpf+JiE3AEMrYF2VovQQbJ94EAGcoM5tZ3K7acYMWVcHnc1lbxhXBwYSDtrS/pXCOMHQrw0eNVek7QoJNhH5tMdAiYt9x1IZw67Ze12x0GIz0ICYBggm458pratOTYymbfDU9uzZQrnMQV66F46sy7VHNcpbPcvW7FTVXt2rw8vr8zl2RmoVpqnOWabR0hFgWcUvbdz0J9WRbGFYD+6WEQkt5wD2Q9Zeu4sBoadWox2kr8tCpqOcFLBNv5ouC8gNPzHCZnTNdQ2j8YO5LVWh9wUGsReMC/7Re72Bq6WRWE/E23oarBssxTr+RteCDmj9x5zpwesejKWORNRnuGdU0MfouKsVlMrfupwV/576zth48+2t0OJfbG8Sbxoh8mzUVeZ/dqT7AeI/faYtyMBfNVwQv8QdfM5c2ruhPaRdXGaihQ5ZWPZYL8IjxXg0rkL9+SxrKej4CXcIdn8cXCkbKg+6oFFM7i4WmuDbLVPCsQhQELNavMNIThB+MuVMg6TdtEC1CYPfx49860DdD7r8bgN9ZvMwXkDOzp2odlai2SzRcU7Bp8CeY3NruZrpuf7nj02TVf9acJYuvmvfvClSbUdzDWk8pkI25BO80eRN0Hcm93OKfYLL9NcVTjXGQVkP+SE/M4Z0nAo+lbziww6mJxyggHGBTFCx6bbZCqFWBeU8NRD00hTwwMFdZ+SpnVm65GcQSct5mQ1h3AOEk0Np2eYbV+43tgmiZOGXsgl55W1rhDCgI3k1BK0DfJXB56nhStajSOuGXC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbd9754-8fda-4e4b-87c1-08daf31db287
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 15:16:50.0705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0Shf0EWbxHq1h1sReEi9r0FURN7kNAK0E0oPBY6QCFxKXC/5FZLv6Ac+Mne68NcN/FaL2QU3FhVBZg6b7n/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100095
X-Proofpoint-ORIG-GUID: puA42H72H2F2yCUDjfaw16mKiSu9mkuJ
X-Proofpoint-GUID: puA42H72H2F2yCUDjfaw16mKiSu9mkuJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2023, at 9:53 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2023-01-08 at 11:28 -0500, Chuck Lever wrote:
>> The purpose of this series is to replace the svc_put* macros in the
>> Linux kernel server's RPC reply header construction code with
>> xdr_stream helpers. I've measured no change in CPU utilization after
>> the overhaul.
>>=20
>> Memory safety: Buffer bounds checking after encoding each XDR item
>> is more memory-safe than the current mechanism. Subsequent memory
>> safety improvements to the common xdr_stream helpers will benefit
>> all who use them.
>>=20
>> Audit friendliness: The new code has additional comments and other
>> clean-up to help align it with the relevant RPC protocol
>> specifications. The use of common helpers also makes the encoders
>> easier to audit and maintain.
>>=20
>> I've split the full series in half to make it easier to review. The
>> patches posted here are the second half, handling RPC reply header
>> encoding.
>>=20
>> Note that another benefit of this work is that we are taking one or
>> two more strides closer to greater commonality between the client
>> and server implementations of RPCSEC GSS.
>>=20
>> ---
>>=20
>> Chuck Lever (27):
>>      SUNRPC: Clean up svcauth_gss_release()
>>      SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_integ()
>>      SUNRPC: Record gss_get_mic() errors in svcauth_gss_wrap_integ()
>>      SUNRPC: Replace checksum construction in svcauth_gss_wrap_integ()
>>      SUNRPC: Convert svcauth_gss_wrap_integ() to use xdr_stream()
>>      SUNRPC: Rename automatic variables in svcauth_gss_wrap_resp_priv()
>>      SUNRPC: Record gss_wrap() errors in svcauth_gss_wrap_priv()
>>      SUNRPC: Add @head and @tail variables in svcauth_gss_wrap_priv()
>>      SUNRPC: Convert svcauth_gss_wrap_priv() to use xdr_stream()
>>      SUNRPC: Check rq_auth_stat when preparing to wrap a response
>>      SUNRPC: Remove the rpc_stat variable in svc_process_common()
>>      SUNRPC: Add XDR encoding helper for opaque_auth
>>      SUNRPC: Push svcxdr_init_encode() into svc_process_common()
>>      SUNRPC: Move svcxdr_init_encode() into ->accept methods
>>      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_null_acc=
ept()
>>      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_unix_acc=
ept()
>>      SUNRPC: Use xdr_stream to encode Reply verifier in svcauth_tls_acce=
pt()
>>      SUNRPC: Convert unwrap data paths to use xdr_stream for replies
>>      SUNRPC: Use xdr_stream to encode replies in server-side GSS upcall =
helpers
>>      SUNRPC: Use xdr_stream for encoding GSS reply verifiers
>>      SUNRPC: Hoist init_encode out of svc_authenticate()
>>      SUNRPC: Convert RPC Reply header encoding to use xdr_stream
>>      SUNRPC: Final clean-up of svc_process_common()
>>      SUNRPC: Remove no-longer-used helper functions
>>      SUNRPC: Refactor RPC server dispatch method
>>      SUNRPC: Set rq_accept_statp inside ->accept methods
>>      SUNRPC: Go back to using gsd->body_start
>>=20
>>=20
>> fs/lockd/svc.c                    |   5 +-
>> fs/nfs/callback_xdr.c             |   6 +-
>> fs/nfsd/nfscache.c                |   4 +-
>> fs/nfsd/nfsd.h                    |   2 +-
>> fs/nfsd/nfssvc.c                  |  10 +-
>> include/linux/sunrpc/svc.h        | 116 +++----
>> include/linux/sunrpc/xdr.h        |  23 ++
>> include/trace/events/rpcgss.h     |  22 ++
>> net/sunrpc/auth_gss/svcauth_gss.c | 505 +++++++++++++++---------------
>> net/sunrpc/svc.c                  |  91 +++---
>> net/sunrpc/svcauth_unix.c         |  40 ++-
>> net/sunrpc/xdr.c                  |  29 ++
>> 12 files changed, 451 insertions(+), 402 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> I went through the whole set and this all looks like good stuff to me.
> The result is a lot more readable, and there is a lot less manual
> fiddling with buffer lengths and such.
>=20
> Do you have a public branch with the current state of this set?

These are in the topic-rpcsec-gss-krb5-enhancements branch in
my repo at kernel.org, although I'm about to push them to nfsd's
for-next.


> You can add:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

I very much appreciate your time!

--
Chuck Lever



