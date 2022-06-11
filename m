Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC707547078
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jun 2022 02:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbiFKARm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jun 2022 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFKARl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jun 2022 20:17:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1A324;
        Fri, 10 Jun 2022 17:17:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AK4t0G008446;
        Sat, 11 Jun 2022 00:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J+ECtowNdxD61yPD19cMXU4ZCThADvk+AFmRkQCtMTk=;
 b=sgkNgyVFnclosi+cj0wwXN+s31nfR7zZ6CjT0BOcat9jRWC3+zstP2+eQg+rSOT2AlFp
 U+gDMX/kUcF4ptVONIg6EQnxk5s+51V8PuAKbg4bBnScrFMhKmmzpVA2u1xCZ3jvlxVu
 qwSFoYiAGhD1Tbrhl65I8MoNv8ZqoRLe2XHyXO6aPiZJq2eGkwB2210opSVxZBpw6P+4
 t0Za4ppKPxahBTJ9PwS3pMPXaYpP0OYTj/KROq7VbLNXybNL0hXCPDrQqLuQgQuIx0Ae
 tE4y4dXaJbQ8H0Kx9nrVN3XLMhd8mLy3EuRDNGWFTe8JvOdPWrPgodoZ48/MBc1I7X+s 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekppjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 00:17:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25B0G7AU030121;
        Sat, 11 Jun 2022 00:17:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwucmuwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 00:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFtpj2wUrjdH7w8WxojKFZZveLNIvl3z6wUyoo53mJ/zCPfzH9MBczqeWpSsTSbv9NPGiUfvCro/bYiGYfxUD84LpL3ce5utPVptK2Zoe44ziYBt+neWnVjULJZkFhZAtjKr2Pl1yaBNXjuR1giLSiU6piIRDDOopb4h6wmNk6OCMpqql3+x41yDpHDLqtzioPB/yuJdSaxFH61Nb9dM+/ddtlLw0Y4d7Eb2Fxh24t1Csv09Nb6767g9MCIpY07vso3vDRmpEQE9GPRZTP7oDpCTxSHwSTFdOXdOh+msTcCxNSNOmOE68ZrOn+6CDmaxbZhxjVbpsspeoYkrSVQRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+ECtowNdxD61yPD19cMXU4ZCThADvk+AFmRkQCtMTk=;
 b=Epr+mZkzkV9igkYxlqkYpTFk4wfp0eSIVlDrteISgzFOLEmvjnoZ9iKPieFPqYF3bE7EWpa8gq59shphdCt4yt4LpLSiP/K+Lx7Wq1MqS2uR7G0MlEmQIyWFRyrq0ugE4QGdFK0Txb6LYXAPzMRQDwdiVSsmf1ZW3mcqP0qt7/keUHuA7KElIY1jMo1tVMjdHDj4fWUnezCZ6YhQ+8miYHvw4DLT6E24pqKK6p43iyoC1XtsXV7sqORHJW0Lgeh1c77zzttgrhyU5T8eFs81fs9sRRdGtiI9BlT0//n0z2Lgfbnxz74eZPDcKRl4TAwbpW75G5GdZHOxywXad4lFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+ECtowNdxD61yPD19cMXU4ZCThADvk+AFmRkQCtMTk=;
 b=u+D5sHTCATOoVRL5k8l66pq28jsF/B+AoUU0hSgWilhoQ9urHmOk/G7t055frfD7V+1XI1X7P99GxGcuYiYu7zgHMH9+nB1bhtpjEzzz5fGJOTlHRWpaJ3cbAwdvY/s6Zrn8bRKk/8Wf8DQUxL+qdi8OpbcjLF/G02dX0TzPEds=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3853.namprd10.prod.outlook.com (2603:10b6:208:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 00:17:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 00:17:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: [GIT PULL] nfsd fixes for 5.19
Thread-Topic: [GIT PULL] nfsd fixes for 5.19
Thread-Index: AQHYfSim9D9FXMyO4kqEE4Rf+HGbYA==
Date:   Sat, 11 Jun 2022 00:17:34 +0000
Message-ID: <FF9D9B25-0117-446D-B5B3-A4240C67A99F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5271d07-0f9c-487d-0259-08da4b3fc8bf
x-ms-traffictypediagnostic: MN2PR10MB3853:EE_
x-microsoft-antispam-prvs: <MN2PR10MB38539FD5B44A45BE04A14E4293A99@MN2PR10MB3853.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzx9htyzNOzqif7OLK5Jr3GoqmKcPif68zo0x5eAfetRbrr6f8EJfxFMtQaibNqDf9qAo+maSKZ5rstQJJuaYMWrUhN3fAYvAPK9gs7SxtxvUQVhEMVZa1yBSuZ5fSTKKj2Z5tfFvHFIfz7ixc2aJvwSda7wkjlAk/tnvUf+JjxI4vAxm4/AXFNp+Ok3enlo7Xl3QfodTjr5gBPZZA6wzFieF8Ll8bsKl4qHMLNqskcO9B+XnVjl7iI4Hk7ikSbsfkphvdQMohAKMiNRvd5gEfBTlIx+UrYQsRXNljlLVqiRyA6GZchRNsvoG+0Al5+1FfrQYPg7OXMu1d0ae7GIRkDyVVjYcqnwpg03OPSWNbPTzN9jwy0iB9AdrFmKTaGSuLmCcyLi6FGJhCiNlOn5Hf9JBTTcpW31g9/ggDuu7AyTKq0WOQk1sSQFnvfIWPt8+blygs0KaU1K+6Ig2LoFz/Gou+8SwHq+9vvKQH3eKxkxvwtWuyH65dP8oE69zqfRvCCylufVeMxSBbStvAuapeeziaaEtXVw2hZIOeY9/2ugRdY7A4dZKnCti80le0quXO+T8/vH67H30HDGRafVghnWFUk3iRlxst1SMFVyLnfmztTgy1TJRqbpe8B5XW1rLnAfA6Hf15PN5vHL72rxlOKz/EE+5R5BpHyKwHa+0u4z+WZ/gCRcjl/SfGb4yisrjjLxbziFaVQZdS03pIHWV7MVt2bbO0lxM23impMuMnI0Y9+ywp+4wdgN8grhTZCDgjvwMDCc8KIidS3DzVUZH+vzwhQR5TsJVhBGjlFosrPn0IE1LsMZLwqWd9N8Hw3j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(6486002)(966005)(122000001)(33656002)(8676002)(4326008)(508600001)(66556008)(91956017)(64756008)(5660300002)(76116006)(66946007)(66476007)(6916009)(71200400001)(83380400001)(26005)(54906003)(6512007)(66446008)(2906002)(86362001)(2616005)(186003)(38100700002)(38070700005)(316002)(6506007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UQ/1rBhum9HVdAGsJmEULLoayx9CDjzjb05sTpt0LaB9Me/RUYDpUiyO2RJG?=
 =?us-ascii?Q?qbiUEOKxKEtx1G4IkqErm6AYTDCjHeNo1S4FXfVqMoTg9CpSm7Imo4/cvbcX?=
 =?us-ascii?Q?GCYfhCFmSHbaah7PDUtUJRpJolU+nSKvVet9BTq+B1BqfNsDDNdkGFu1/ejn?=
 =?us-ascii?Q?UJ5x72Pat249eUNAh5dNiPLJ7aXp7ThwOw+f1xJF5goIkvL5isQDQiFPwy3X?=
 =?us-ascii?Q?VTSXA6TXVmUAtE8zMs2coUu4ozS9Mwbp69NXt/ct2D+UHMfDBg4ic9gMygde?=
 =?us-ascii?Q?pVUlLq7uaci37CXRQ9FAKPKrc0xLYDdgi1uIrrm7pu0IY9QvKUPtYEJkc2Nv?=
 =?us-ascii?Q?8QSiWKkyDy5Ymmm007kEx+5jl1Bx8PPA2vHXf2JQyfnqqjlEK4qeQkrtX3zN?=
 =?us-ascii?Q?LakV1H4o5cmWp7/bWD4aTJyWxY8HQYA19l9FWSjjm7uGWas64S4vZ1hYty3B?=
 =?us-ascii?Q?W4U7Wd3lzg3BJVkZbK1Nw/r2Dyxol5iD2joigm7UnLCCPChOhrqMNtXfZcHP?=
 =?us-ascii?Q?sbUiQ1XSKlCQjrE4CEY4us1pYE6SgriWgvWdSSZnxW3Hg7yzN14qnMlxepR+?=
 =?us-ascii?Q?wr2ftrajdkCquMtXSyEnGvNQPWs57njh//PNFWwwYBzRBgrtibx3bJjIeKNt?=
 =?us-ascii?Q?NTnLtaICWpXjfhnOarNvw84wrueIzX1754cDjmALRf2orRmFvW3utSF4ybkp?=
 =?us-ascii?Q?2D4xjkh6QLeb/R58FBwk2TMytfEyZgqyLayySccTRGHwhw2LdKHoKwYeuxeC?=
 =?us-ascii?Q?W6De4+wGhLV01yson6t40rGhS/wp8OPmxoZJV37lIGhK1ASV8qDLznfiieL0?=
 =?us-ascii?Q?fxJijX1ujhWDB1ru9K6LZoY6XEsleJ82dr+3fjVj/yH8cV3lqrDysBNJrHi9?=
 =?us-ascii?Q?V+LRXjPxFLxTJF0gmn+dQGsbwcmQIpQb57PulD7pWl6TxuJC1wzcP5gkXim9?=
 =?us-ascii?Q?dmX+XTMkQQpST81czfnm0pFw3eJGD3uoq7To9L571BgXWRjJZSwSKaczfzwP?=
 =?us-ascii?Q?bHhU23VkxKZPVjpU5mWgme0PoAXkAJWPFyz2B3P0pn3Ds6slcizPmwxyw/g6?=
 =?us-ascii?Q?72TJER/2kQNcTLlaKC8iiw6f8EWESh1kMX2mw/VSLzATcJ3OoHzyMz2vH+SC?=
 =?us-ascii?Q?dhwIE1FGBVZUqdjO+SuyZtXVTqQEggu1lQfw4ZE8TVbO7NgPDRr8TLFQTVrC?=
 =?us-ascii?Q?Ni9gUsus/3pVt2pn9Iw2V9Bq0IPC3kQOmpNQAfItvtfrl4o0s2DUQNBOXnFL?=
 =?us-ascii?Q?hf8vPOJsdsrBiVt/c5XJdxuzFF8gDK250sxAJjsZgVmZbBcyCK796VD1dAJk?=
 =?us-ascii?Q?4ETQT8jZ3a2tpIuiMpZ2kirfTBN2QAcYq2TWmaJdjWXlte6JLlJbmsrPqarH?=
 =?us-ascii?Q?v2GBKF8g+jXrO7ISSX7jR5t51V5feA0JCWeoEODQoPNhRnX9oz0LZao2cEd4?=
 =?us-ascii?Q?DGuYGyNEdY/STaPmIrVBKq/3LNXjIpo8uTfbkDGiib6ptLRZrrHujERxCN22?=
 =?us-ascii?Q?kByuqwPQCir67RHICNBZROSNigWpP/cDZtKcfVMnGvQrbFzmhrRvVyvanDG6?=
 =?us-ascii?Q?bPEhE0w40xKIv2iVoy/DgEaeaqqJ596R9SZFuafCqVHF6+hDC76d6NbZhuP5?=
 =?us-ascii?Q?w5VXtsGC6oSbO+zK5oODmdFLyQOU5kxI1FWuPo+W9S16Fvcwudern+SIfNXo?=
 =?us-ascii?Q?3evqNY75LMMVlE8vUlWifpQg+s/D0rAUnNJ0jmOQlBJK40M72Zp+PpYJvKJh?=
 =?us-ascii?Q?yMySmdUp2eZUDt85BNfR1y6Hq8WkJOI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBCDC0D12239934398609E5036869F1B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5271d07-0f9c-487d-0259-08da4b3fc8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 00:17:34.8705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRracLTIGaZwXlklhbw8nuipNJpy2NdfLoOzLBw2T+Q6ZDltmd3H79W8Lyk/Ze43y9cjsMkAXKuj1phTrR9Nyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3853
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-10_09:2022-06-09,2022-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=965
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206110000
X-Proofpoint-GUID: Tf0rd2jclgmc5VlQPmNuUq4Wj927dumY
X-Proofpoint-ORIG-GUID: Tf0rd2jclgmc5VlQPmNuUq4Wj927dumY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 08af54b3e5729bc1d56ad3190af811301bdc37a1=
:

  NFSD: nfsd_file_put() can sleep (2022-05-26 10:50:51 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5=
.19-1

for you to fetch changes up to da9e94fe000e11f21d3d6f66012fe5c6379bd93c:

  SUNRPC: Remove pointer type casts from xdr_get_next_encode_buffer() (2022=
-06-08 12:39:37 -0400)

----------------------------------------------------------------
Notable changes:
- There is now a backup maintainer for NFSD

Notable fixes:
- Prevent array overruns in svc_rdma_build_writes()
- Prevent buffer overruns when encoding NFSv3 READDIR results
- Fix a potential UAF in nfsd_file_put()

----------------------------------------------------------------
Chuck Lever (7):
      NFSD: Fix potential use-after-free in nfsd_file_put()
      SUNRPC: Trap RDMA segment overflows
      SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer=
()
      SUNRPC: Optimize xdr_reserve_space()
      SUNRPC: Clean up xdr_commit_encode()
      SUNRPC: Clean up xdr_get_next_encode_buffer()
      SUNRPC: Remove pointer type casts from xdr_get_next_encode_buffer()

Jeff Layton (1):
      MAINTAINERS: reciprocal co-maintainership for file locking and nfsd

 MAINTAINERS                       |  2 ++
 fs/nfsd/filecache.c               |  9 +++++----
 include/linux/sunrpc/xdr.h        | 16 +++++++++++++++-
 net/sunrpc/xdr.c                  | 37 +++++++++++++++++++++++------------=
--
 net/sunrpc/xprtrdma/svc_rdma_rw.c |  4 ++--
 5 files changed, 47 insertions(+), 21 deletions(-)

--
Chuck Lever



