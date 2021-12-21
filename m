Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D064D47C5F5
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbhLUSKX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 13:10:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44972 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240980AbhLUSKW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 13:10:22 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLHKGm0010355;
        Tue, 21 Dec 2021 18:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RaSBrctGcQVY4PphT3BXYDalos/S3Bfusgf+2waam9Q=;
 b=EY6W/bSd9Jf6PgKpOoDBY4nl6+abulOwUxdxMXCcuKmdf1PQ7bRUd315emLYVM+nl0hi
 SiIa6PKjgytDFpKi/vUnQ+TVmjir73fiGl5DLYrHX5oBey56qCcC9E4txRikXiAjK1V7
 9U+MRkERnV0D26KwJVT26Oo/1JtDd8B4PYjXu+itPcupFRua3lGuB/vGoNaPTPyQlnbn
 OHjQ4sB1+AqQ/HQdAYQxvHq+eVX9uTHAwoMeTVjPLyjLpdtMsNGJ+txt7Sa+0AmULIIx
 DlqBnNkuoZrdyydYw+qxI7rTEkJnbgqLI4o3/qqoK/OFM8ayWTMA791wW0cRQTzoH1xo jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqv46p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 18:10:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BLI6wqP103325;
        Tue, 21 Dec 2021 18:10:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3d14rvwsg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 18:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqsKWkYOArP9CEiB6kFU6YI+5el+hdzWz5ncZKY1rennzYGaDdXb6YQZ/Tr9CMxppqaZEqj+plusUAVhl4ux+94oQlY7AW/bVZzQxQFYTtyGcp+4A80JUt42xwRtwbOsyrdp4FKFq1KZ8b0Z/otXBFK359NxDXrzrmCVeKOPgWa5YaT+ApVe86ZlMdBbIWlzuETh1QskdRBA/FmCvLnD+hnd8MkD3jRJjR3jd5rkrOECjoiltCjtRN910uvspdYP6tQm7Y1VFhRL9qLtpTq4F9e710gb9eOEGpDoZ44mYQlFF3RkWt3Ho+5CTXXgXuAx9c9LXT8FoHbIxYZ3MQPobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaSBrctGcQVY4PphT3BXYDalos/S3Bfusgf+2waam9Q=;
 b=ETGNxEfYMNQ40rjeSNI/ni36YsLPREAhCTO43xhpzmtrhscdwIT4WIsY7TPON3ivlueddD5s/8IY1BUL1E4yYNnxqsKHUPoiNEXicNt+2C64plzD7PCTqrMWOZYkCM5M3m2d8cu5iAMewpsMCeIdFk/KEs0uOKAusuC5gU2QnFFK87GfrP6QUlBxV24zI2inzLi3cY1jnjqBn+WCKE39GBnbNYtIB68BlfmWdllW2wLOFXHhnR3YZBAErdQpyBIgdTWC/vcDL6/SoVlGuCjqqB8fWFZz4Cj/OdTBv80JV1cc37W5tMQ6Wp5xv/5iJMivbJ3G4TOHgG+95T5W4zb/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaSBrctGcQVY4PphT3BXYDalos/S3Bfusgf+2waam9Q=;
 b=bExVLDgiCLadRr0fW9STmLpia8JvrWtKnttdknlghOmF1APNMd6Ko98GADaAEeweg4Acwb7f7xF0jxkxsy55fQEtamZZNzR6Ra47EnwbGfgxoVW05MP/v4DUN5ewV7Ggt7a9q8IB8olyO16XZ0PuGF+rLbVE0Pc3VY5n8OMKhw4=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH2PR10MB4040.namprd10.prod.outlook.com (2603:10b6:610:12::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Tue, 21 Dec
 2021 18:10:15 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 18:10:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] Assorted patches for knfsd
Thread-Topic: [PATCH v2 00/10] Assorted patches for knfsd
Thread-Index: AQHX9HoG6l7c74yDiUisdre2kgrnXKw9QwuA
Date:   Tue, 21 Dec 2021 18:10:14 +0000
Message-ID: <342ACA13-9F45-43AC-A858-0F1A894458F1@oracle.com>
References: <20211219013803.324724-1-trondmy@kernel.org>
In-Reply-To: <20211219013803.324724-1-trondmy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7268cab4-54d3-4e49-9837-08d9c4ad2348
x-ms-traffictypediagnostic: CH2PR10MB4040:EE_
x-microsoft-antispam-prvs: <CH2PR10MB40402D1A0CA03B5DA8649551937C9@CH2PR10MB4040.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7ESUqMZ0EdT1l4HBhY9Mmw+021P6beDkWaPlRUxSX6JwPEm7cADMQ9yOLdzxINqSeMNnjkAbD1NEgntCrevaEBIs9d38nYqdrbNjV/sck0mLK+K+Evw9WKKTtmEmdFGGcg71qkP9qkKKzkwrWIUSTpKjXlLN6eCAUspC0zZuNOtS6FwH7dRxlLLaav67OMJ0MTVxupIeN/Fh20NlDjA2YGU3c8S0sbKwaYsASD49Mv5hwabpAytqZcsX4mQ606SbT8Cdg7PGV8hmyg6A97jRWvyrOqcqKrCoFr89dROCJMyyTko4nB65y7QcQk2OdeWxhchh+zu7oQ9aJ+IwHM8O1vAA9o0VhqbZ5GlVwLVEv9sdX12a6g7CUwm1XLLyrCV4ygL2O7Tq+SE7C+SM7AI8xUzM/I5aneums2iupzlLA7LjWuChFqJ5cjPPHqYY3hU9Tjzijj+uxAx8bvHksoj9WGu2NRcBp6vl+AaiRn97JdY9gnZoUZh6BFgNA2hFKXyYqmPjFoWJE90ZfW07rw2IHVadBCdzikLG5EK2vxbFd41Lz2X3ix4N20MSpx+gXCyh6pQDCF9xaay9YZfnWnttwLA34YtpqEPT/CdY9J3haaxCLVqGmoZ6n820pV/18uTAySLyGEqGSBlCCf68/fZieENBpE3rXaENky9QH5AyvGBBL42r34ND8RmuysjKjpAZn7l0sdZSzP4UU4IHco/6WAWnJM7fV1Jdy14gzoohBaItiZvX7EFKsZBGL4JgeDbV/W6IZayXlESdrW0vU0LWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(508600001)(76116006)(8676002)(53546011)(6506007)(5660300002)(36756003)(54906003)(6512007)(4326008)(6916009)(66446008)(38070700005)(64756008)(83380400001)(8936002)(122000001)(2906002)(186003)(26005)(316002)(6486002)(33656002)(66476007)(2616005)(66556008)(38100700002)(66946007)(86362001)(17423001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qdJgJ1V9txIXLjDvm3U4VC1I7Ob7/ffsr9SUm/KeiEewONh1zq4+BYrsrsXn?=
 =?us-ascii?Q?WHX2QmyKGeQZyBSLPTnfVdOxSPxxGgpSHVIMS2+S3xxpPkzmQ45GbwE/umhe?=
 =?us-ascii?Q?z6DsFjjL/CXeuFb/VtQ2Lg0Er2LS/1dujrhZ/AZfj3bzjvI1PdczTV8yokdm?=
 =?us-ascii?Q?z3RYRRHp5tPqBwXsxNaKxiyBhQyhOOmQFh9L5tNnLJPm448Cykkcvizs/kyU?=
 =?us-ascii?Q?DdWHB7TrlUxsgGj9gbJz1b56jA5z3vDUhh+i33oaDpUruiLBdSgpDpj/wfpv?=
 =?us-ascii?Q?msD5y2JVcrPKEjmL7pUrxo52Gs/1+tjKq02W3GJho+yzz3zKHf8F2TvI9d71?=
 =?us-ascii?Q?Bu5Zfbsr+ypMkePtrwWrZmFrJ3Ie3YmuUB7PFlG69y+E10Oo2QJ6Nwc++NFz?=
 =?us-ascii?Q?hZcv6sYqmVcfufpk0LeUfLTnAcniWqbvHqjPFmyf6vecxSr0F56X4E1wP05k?=
 =?us-ascii?Q?9kqXv2GEpMqEccMgIzmZRG+yXD50u1PuRw9VAPPkE+jSipQ8KhxB4JNdmQri?=
 =?us-ascii?Q?CxXHGhTlEP97TgfGDcbQFNdHLVB5xSEOTd42B1SNse1QRFpwjdjrdAZRWVU1?=
 =?us-ascii?Q?8itcBViO77PzdhIhzJBGS/ua83e/OK4Xp8OTa9F0Dg5LNJpqlkgN+paIPcWt?=
 =?us-ascii?Q?xg6G5MX72wkyCnoE509370CLJ/sc7s1pS0yhLAsxH9FP7XAfcLS69lPWZFqU?=
 =?us-ascii?Q?+6jdyyyhODsLhK2oVle/0CzGr+R014BOIlWDgHxu3G8MDmxCAjAbvOgNDQsO?=
 =?us-ascii?Q?tywl0i/zL/5CR8a8UeiSBRG5W1DU+AdwfOfY9wSd91xDHKP72t9tol3OasWf?=
 =?us-ascii?Q?lBBnUjKpIzTjQ86DeqAVDCDZdYYwgBtvaD+ZgYkLDjf/4Dv1YQvG9skWtm/B?=
 =?us-ascii?Q?ZCY2Cf30e3AeUlfneJ2ZBvdcO9ykjMTkY8whjuN1WeshinQ/QenSWSVN4jMz?=
 =?us-ascii?Q?5jqpiX2iHqamM/6XCY5Fl9BvWmWwoxtq49oluz7yQIZJBETxg7b5L8N8lqV/?=
 =?us-ascii?Q?tMN5AMO+GEOPasgfsWF0wd2lIog+JmQyr1ko9d7+YkoW8mJosIUZ9R4lh5q2?=
 =?us-ascii?Q?fB7IGZZnyDVUUSPJ4mTVahV1eYXwYTVVLb/yBQCib3CwNwyQ+YTpwfipsufR?=
 =?us-ascii?Q?05yvnb4dK+bDTyBx7jJ2bFA/CKO84wGbiPYCOw5SpCakHmQLu1Oa4aVi0Ubl?=
 =?us-ascii?Q?v0AAaWoC5MAZOIeTOO6hmUPzzhJ9CCS411ojLCmqVgaJtMNe/JsMXpuUuL2Y?=
 =?us-ascii?Q?/iqGVzizwY3fbixIs1MD5R60yKPVqhAku+/95Vo4msU2YyBZmxcTjrq6BxVM?=
 =?us-ascii?Q?2SnbWstoA0NAnpjubL9AK7ATuAuLql6QVJgNYtaggE221v87iKIoOIk7ziBA?=
 =?us-ascii?Q?HcZZ9GUweH67YsbBGzql2btdDc1Tz6dS88z1tIHFGS3sxE0Bsj8k9fr27gQk?=
 =?us-ascii?Q?RJnwt8NCRz1OsDkLzACreniOO5vRmGYnhCz44+92EbpJgLZCj7Iy7iAUcDXN?=
 =?us-ascii?Q?CF53F3kuiUKrkbq1cJTUgud21lgyAqy0HES6E+PVv+wFvoHfr5/P+pAD1fZR?=
 =?us-ascii?Q?vgCuRl4wRa2I9nTKRh6l5jd/BJOjne0pOvGygWw+AEevZkHYRQElLw5R1Wme?=
 =?us-ascii?Q?0guUsPItxhvij/Y1EwBhpRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5333FA263668F47B2E9661B1C76C845@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268cab4-54d3-4e49-9837-08d9c4ad2348
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 18:10:14.9044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4/CdPnckwC5GcYKP05RyLysziKl+jrtLDvaPJTWDxivTPRTDc2t40Uq3O08Dr0XD42Mhg/hxL/v42LH5VHevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4040
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112210089
X-Proofpoint-ORIG-GUID: GzSE4x_5_2MBtfy5U62KmnuDHUKqtfAC
X-Proofpoint-GUID: GzSE4x_5_2MBtfy5U62KmnuDHUKqtfAC
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Dec 18, 2021, at 8:37 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The following patchset is mainly for improving support for re-exporting
> NFSv4 as NFSv3. However it also includes one generic bugfix for NFSv3 to
> allow zero length writes. It also improves the writeback performance by
> replacing the rwsem with a lock-free errseq_t-based method.
>=20
>=20
> - v2: Split patch adding WCC support
>  v2: Rebase onto v5.16-rc5


I've replaced the following patch. Thank you for the bug report.

>  nfsd: NFSv3 should allow zero length writes

I've provisionally applied the following five to for-next while
tests are in progress:

>  nfsd: map EBADF
>  nfsd: Add errno mapping for EREMOTEIO
>  nfsd: Retry once in nfsd_open on an -EOPENSTALE return
>  nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()
>  nfsd: Replace use of rwsem with errseq_t


The following two are still open for discussion. I get where you
want to go, just a quibble about exactly how to get there.

>  nfsd: Distinguish between required and optional NFSv3 post-op
>    attributes
>  nfs: Add export support for weak cache consistency attributes


The following two are deferred. IMHO they are not ready.

>  nfsd: allow lockd to be forcibly disabled
>  nfsd: Ignore rpcbind errors on nfsd startup

When reposting, you can leave out the patches that have already
been applied.


--
Chuck Lever



