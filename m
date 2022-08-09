Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E358D9F8
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 15:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbiHIN4t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244811AbiHIN4b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 09:56:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419118368;
        Tue,  9 Aug 2022 06:56:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279D4hYM015612;
        Tue, 9 Aug 2022 13:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=P8ulxd4LCszQaP7HiZs6Ajr/eiNLz5ybYQI7IU8G+tw=;
 b=SHhgLkmuOG0CmjktUVdHKHvFgcWplFnTziy22gQZjBhXCQy5wydaA31Qkch88UOS8fFY
 2yX9RatEafD3Uj3mgWq1m3QFITEnru5LdCSyCrMqvu++2t3tLUPwxNjTf1SV2n9nTPVw
 Nl8XIdXjIB0WoTk8utiaCAoz2ZQXww3YiAl4T1vFc4n+fVJbxDjE5F1DmZ+K4Q+dXSjZ
 yIQKzhbsk7Cp2eMuuiOksGUGplpltfx2hgsjbEwm6JuuZCH+dVQuSJHe4EdfvWHOyUU/
 oBo68ISUMzZpu5U4g6J4q31lVmHCL1BE1xVnvmDdg/Ijdp95Ys5K5eLeOO8Hntku/IlM MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hseqcpexe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 13:56:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 279AsUqI033021;
        Tue, 9 Aug 2022 13:56:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser2uyy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 13:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcGWWs2uRSBuwzFGyIRZvs5i3Q3qzk0w8jMB4qTC8v/8OMb8DyeAXcDgB2ZdlRw//rUjlleuENK7NgGD0fO/fZG0R3UCZqlIKeZDQM0iduVTxAYEG0dn1n0ntCJ86Uy99ukt1DDZR6cxsi02cJarbHQ4BoEk1JbxB9iDSjd+YvD+/+KKO10T7KSmhdNJh0pkRfHph8xYz7Dyg0pNTxbrQb+/bpSTyfGobbv0/fZSO40Ho+xeR3IVVrMlfbHSwfTLxeTpdGa/QmjljNCJ0CCbxV4UvH8o2PD8ufjrbPNxGo1V8XHBHszNkyEPr2XvxbuCOm5sITVAkA5+W6kqDFTWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8ulxd4LCszQaP7HiZs6Ajr/eiNLz5ybYQI7IU8G+tw=;
 b=LltGomnE4MUwqi203YQhXtNDFQeDJMCHHCkeRfaoU1TOvw4taOwlQua7AQBtk8euXi7NWZnRKZt4Q4N7btedoUc2nd97/dPfFfEzV2phzP7ypmF9kc5w65gTfSXXxSE7C7GeDHVULkYM4uNjh8bcnDW5SxrPYxsKuhZ0F3CG2Y88FUYQEGZoEpZT4CZNhRLcONxOfImODZeUsMClohMRLrdInHI5P2aXR4NG/AjkrIdWVevX7sxAK4ESCo6EoW0D8LDisEdhy42jvc94JiwuLFGyFgfURROhVdCg++N6cRQqRD8sgyTqeQ1Xo31XgTHWfLqrSqjYVyFmvxgtIqHI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8ulxd4LCszQaP7HiZs6Ajr/eiNLz5ybYQI7IU8G+tw=;
 b=esFlCiduR/ftL0nv96ZZr0+k9VrhYv5OHNX8miC/aa5D49H5r9aW/OLO9Y+Q4tIUtMitx28WlCABNvZ/UcSWbIMJaSSSzyBC4k/l934Jmr7/xJPyZUGDyZ8sMyeLZSlS0Pk1bCfYXudSi1adXD7Yv34UX8tTmq89XWdSuksi+6g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1732.namprd10.prod.outlook.com (2603:10b6:405:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:56:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%7]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 13:56:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for 6.0
Thread-Topic: [GIT PULL] NFSD changes for 6.0
Thread-Index: AQHYq/fN31X8ycYALkayoXVj3xaFLw==
Date:   Tue, 9 Aug 2022 13:56:19 +0000
Message-ID: <961E618F-200A-4C73-80E4-A6E720D8A45A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 401af57b-1b9b-4d3d-924b-08da7a0eefa2
x-ms-traffictypediagnostic: BN6PR10MB1732:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIJ++SbPNCfSv1MeHjONjJNcJe8bzOMyBfkIslz1/KZ02blw4NRsqpnQgwITzpuBUNgseT2fZt63hGFqW9NnKFVSvreeteQtbTPd+5sMXH/jP/da7+GrGK8qdYgcXchwX/M1MiYYF+8jwAsqfBXWwaNRRW0+q3ME0nuKH8dY1IFuK5X0rU1uMO9DmEwicFMc4ycrVWgrdLmg7KrmsmNJWT1mOHZYPcab3AFWNQIsw/yRkzSPBSsLmDbFt0/ZyN+4dfDR1Mr/zP0Vo7+TOYRVI9dCJZnuut9reUDpuD5bl9WFVUjtfEmouJpFEKr2+2gehNPhV5DIy5uo0RdAyPQnBlHXKOEQ3MYM413m5jNzhhUfEguvEz+5EYi6nfINqqN/4AuAp0boui5MLY84wa85n8dR7sWV5h5lkmsPjgzP2P6L/lzSLggj/9EdQJDrHWJGNXt5aKS3NAoM2yLwjKoefLTnhmCtb0CFMsBFHHUyR4731sTJWcBCuCA8PHW1bVutaMyIvwp8a5t5J6LL5998gKtCN1mcrPRlCuCtyQAlgCP94l4HEVQ7cNiMSxPvrcZ1LJpQ+uARz4odl9ebRbGYHnPu4r3Cmft5qwsouQMnMUeIlCEFY0HH2KhlVCqYVsjqGJ/bVO+UOHG9nyxAxjIlBDgpyp61Hco2bsX02uj6XV7oWGBgd0pEGaEuxiY0ehnP9OXtLcIAgMm0sYQeCVUHdfJqcGkJ4J7Xx2JIgpYfNepXA3II8S1ey+a7GMIBadldmm4jmBPT0+de3vunv5LOhTs/V70/A35fmI2oF4Z6CR0HvIigt4xPFgI/+NAscSCVXakG1I9tr+yVEhzpBcQSiQ9gw2wNiiajroQrVGtND38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(366004)(396003)(4326008)(76116006)(66556008)(8676002)(83380400001)(66946007)(64756008)(54906003)(6916009)(66476007)(66446008)(316002)(33656002)(36756003)(41300700001)(186003)(26005)(6512007)(91956017)(2616005)(6506007)(38070700005)(8936002)(2906002)(5660300002)(966005)(6486002)(478600001)(122000001)(71200400001)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kwIFN5sYAJU2SE1MUh3+Xdv5an+YDzd/u7V88r2/+1xf3u//6DrHHBVeXR9S?=
 =?us-ascii?Q?Y8BXdfQs1iQZ6+5NfIUCf1TbZTnKRCpFLJKp33DhNLNt9T/iKWhrDSCJQ5Bj?=
 =?us-ascii?Q?wTndLSQ0GW0DY8LpRCCB1tVkQ+SsHVc0iwXwpI0Ew2cTudKugtkpr4xb9rkZ?=
 =?us-ascii?Q?+RXa++S6qPSaDNwaxt6vRIoBL0EeNy9iWecRZzsVntjQScreTBlZYAuGM0+R?=
 =?us-ascii?Q?j9HaYGCJSFtAO+zDavcSzWVZcQfeMomLDBUMP0Vc1osjg3g4CTnuMgWn56fX?=
 =?us-ascii?Q?f9QOSiHxLTFOAPNITdiat8av7I7c3TNlykKjqE1074Qfw9i2ITRv1CbpDaWX?=
 =?us-ascii?Q?U4DU5p/swrRJYE8fGfwYhZnARkO2m09OxmvTBnaPUa7F9OevPXrnN3fUcyTp?=
 =?us-ascii?Q?EjtsPxV2lFUEYTqjYZT+XztAMVBqI/XJP0ZcNHLSIenXaop5A3CSRju90Jqb?=
 =?us-ascii?Q?NNnHRBUx402Vpm4Ua/E7KBb6UylQNFQQxAhAexkALBKBBq98Nc+m67SgTPkx?=
 =?us-ascii?Q?AH/ze/953OFq+Ia2nX6VIST2DXO2MyUmosoOpVTP9EV4NNLE1hhtI2llXudU?=
 =?us-ascii?Q?m5E0JSYYcytFgKpmYEDCngrkmaCtdiBdLd7H7czASpMTFWOnttyQoSFc7qVi?=
 =?us-ascii?Q?Sc0h59ch5h520VqDG64UhFEbueIcNDTe1HBttYHozEPEmY2Ok9ZlfG8bjKh3?=
 =?us-ascii?Q?QjBeW697Eqv8D6eqKK/9pnJGEfE1pdsmK4m6T8Aa1sKE/HBeqGJClyDeQROB?=
 =?us-ascii?Q?xP10ekjImnruACkbKdkhh0ejznEj7zjmARgUUeVRXm8OeJfO7jO4T4PiYBTe?=
 =?us-ascii?Q?xRofa49KG66KUbaCfhhlxXSBoNZdq5yB7zIhBWnxC2r7/nCYiAa3oA8cGJMN?=
 =?us-ascii?Q?ORqx0R9eGsgU2xQrhVVKsRMP/rXLqFattj8NGW/zYMoIFz+ma0ZQlONCWl3S?=
 =?us-ascii?Q?70QYunQhOfFtfPTvdpLsPLTNIDCA/KM5z0tUQCHMNXv2Il8O+OJkiRA0Xyfn?=
 =?us-ascii?Q?djyZ7iUPKg4lpjDdtZmXPaSFxg8twSwXLdU+waL3bwq+Xvz629KkP5wP3rjX?=
 =?us-ascii?Q?wMN+C0Nlbts1PySf8WAbcsPs/7BodmcwwWooraRcDsDL5lgWoj2DpTR0Gvah?=
 =?us-ascii?Q?+Zq9KLQCEx3m0Q0ibAkjsKbXLGDJapwi39TLHMf+MR5kbyT/g9mueolDn2nh?=
 =?us-ascii?Q?F3pv4TFLx8iMg9aFpoajdDIMw8wvQneVh1H9KV2ULIeTDZU6TyUSof9hWVmM?=
 =?us-ascii?Q?fmUsDDxVXstT+mm/dIYD2SFTUsN8ZOn8Z//PVHbV1RKBlXZu6MEZpO8P3G4d?=
 =?us-ascii?Q?Ik4mWlhuj7uL/kL3J8qeGaHylDoyT+WtZ2+SX04vMcXau8N+YWRMbeNQIEka?=
 =?us-ascii?Q?g9ZIW0YpIqMJcRqwJOiRjMUAvTLQC44WXJEZQ4PEg6VUMBArys7ggIpt3GCY?=
 =?us-ascii?Q?XO9DC8R8UT2ka720KgmwGmXaaUxM9dMG9UHcdZk8D8ZCND4klgsNrzeFkkDy?=
 =?us-ascii?Q?lioJvefov0e5fIiUCdbC0GZ5rUmLSety0ZMs2L87nqIY0kNbkMdROSEXxAqY?=
 =?us-ascii?Q?UC6evYQ3uZ9f32n4kuYvnoqyOcbdzCUpWWUzvrSRE+9qpmXP7f//Kus5JS13?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2243C4CF6070D64BBD41690FC6949650@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401af57b-1b9b-4d3d-924b-08da7a0eefa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 13:56:19.4417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Pz1uWC0ocMoCXSOSIV/HJgYANadYT221WHzVDQHIayjwEvR1G5QAeQBW6SF7ZzyNoQ39NZHMLac/7exV8FuGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090060
X-Proofpoint-ORIG-GUID: uLo5qPD6Uy91stB7QZVoTcy2lIqJ4v88
X-Proofpoint-GUID: uLo5qPD6Uy91stB7QZVoTcy2lIqJ4v88
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

Sorry this PR has been delayed. A last minute decision was made to
include a fix that needed to go before a major change that was
already queued up. I wanted to give the full re-worked series a
few days in linux-next.


The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28=
:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.0

for you to fetch changes up to 6930bcbfb6ceda63e298c6af6d733ecdf6bd4cde:

  lockd: detect and reject lock arguments that overflow (2022-08-04 10:28:4=
8 -0400)

----------------------------------------------------------------
NFSD 6.0 Release Notes

Work on "courteous server", which was introduced in 5.19, continues
apace. This release introduces a more flexible limit on the number
of NFSv4 clients that NFSD allows, now that NFSv4 clients can remain
in courtesy state long after the lease expiration timeout. The
client limit is adjusted based on the physical memory size of the
server.

The NFSD filecache is a cache of files held open by NFSv4 clients or
recently touched by NFSv2 or NFSv3 clients. This cache had some
significant scalability constraints that have been relieved in this
release. Thanks to all who contributed to this work.

A data corruption bug found during the most recent NFS bake-a-thon
that involves NFSv3 and NFSv4 clients writing the same file has been
addressed in this release.

This release includes several improvements in CPU scalability for
NFSv4 operations. In addition, Neil Brown provided patches that
simplify locking during file lookup, creation, rename, and removal
that enables subsequent work on making these operations more
scalable. We expect to see that work materialize in the next
release.

There are also numerous single-patch fixes, clean-ups, and the
usual improvements in observability.

----------------------------------------------------------------
Benjamin Coddington (1):
      NLM: Defend against file_lock changes after vfs_test_lock()

Chuck Lever (56):
      SUNRPC: Fix xdr_encode_bool()
      SUNRPC: Expand the svc_alloc_arg_err tracepoint
      NFSD: Instrument fh_verify()
      SUNRPC: Fix server-side fault injection documentation
      NFSD: Demote a WARN to a pr_warn()
      NFSD: Report filecache LRU size
      NFSD: Report count of calls to nfsd_file_acquire()
      NFSD: Report count of freed filecache items
      NFSD: Report average age of filecache items
      NFSD: Add nfsd_file_lru_dispose_list() helper
      NFSD: Refactor nfsd_file_gc()
      NFSD: Refactor nfsd_file_lru_scan()
      NFSD: Report the number of items evicted by the LRU walk
      NFSD: Record number of flush calls
      NFSD: Zero counters when the filecache is re-initialized
      NFSD: Hook up the filecache stat file
      NFSD: WARN when freeing an item still linked via nf_lru
      NFSD: Trace filecache LRU activity
      NFSD: Leave open files out of the filecache LRU
      NFSD: Fix the filecache LRU shrinker
      NFSD: Never call nfsd_file_gc() in foreground paths
      NFSD: No longer record nf_hashval in the trace log
      NFSD: Remove lockdep assertion from unhash_and_release_locked()
      NFSD: nfsd_file_unhash can compute hashval from nf->nf_inode
      NFSD: Refactor __nfsd_file_close_inode()
      NFSD: nfsd_file_hash_remove can compute hashval
      NFSD: Remove nfsd_file::nf_hashval
      NFSD: Replace the "init once" mechanism
      NFSD: Set up an rhashtable for the filecache
      NFSD: Convert the filecache to use rhashtable
      NFSD: Clean up unused code after rhashtable conversion
      NFSD: Separate tracepoints for acquire and create
      NFSD: Move nfsd_file_trace_alloc() tracepoint
      NFSD: NFSv4 CLOSE should release an nfsd_file immediately
      NFSD: Ensure nf_inode is never dereferenced
      NFSD: Optimize nfsd4_encode_operation()
      NFSD: Optimize nfsd4_encode_fattr()
      NFSD: Clean up SPLICE_OK in nfsd4_encode_read()
      NFSD: Add an nfsd4_read::rd_eof field
      NFSD: Optimize nfsd4_encode_readv()
      NFSD: Simplify starting_len
      NFSD: Use xdr_pad_size()
      NFSD: Clean up nfsd4_encode_readlink()
      NFSD: Fix strncpy() fortify warning
      NFSD: nfserrno(-ENOMEM) is nfserr_jukebox
      NFSD: Shrink size of struct nfsd4_copy_notify
      NFSD: Shrink size of struct nfsd4_copy
      NFSD: Reorder the fields in struct nfsd4_op
      NFSD: Make nfs4_put_copy() static
      NFSD: Replace boolean fields in struct nfsd4_copy
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
      NFSD: Refactor nfsd4_do_copy()
      NFSD: Remove kmalloc from nfsd4_do_async_copy()
      NFSD: Add nfsd4_send_cb_offload()
      NFSD: Move copy offload callback arguments into a separate structure

Colin Ian King (1):
      nfsd: remove redundant assignment to variable len

Dai Ngo (3):
      NFSD: refactoring v4 specific code to a helper in nfs4state.c
      NFSD: keep track of the number of v4 clients in the system
      NFSD: limit the number of v4 clients to 1024 per 1GB of system memory

Jeff Layton (5):
      nfsd: eliminate the NFSD_FILE_BREAK_* flags
      nfsd: silence extraneous printk on nfsd.ko insertion
      NFSD: drop fh argument from alloc_init_deleg
      NFSD: verify the opened dentry after setting a delegation
      lockd: detect and reject lock arguments that overflow

NeilBrown (11):
      NFSD: introduce struct nfsd_attrs
      NFSD: set attributes when creating symlinks
      NFSD: add security label to struct nfsd_attrs
      NFSD: add posix ACLs to struct nfsd_attrs
      NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before =
returning.
      NFSD: always drop directory lock in nfsd_unlink()
      NFSD: only call fh_unlock() once in nfsd_link()
      NFSD: reduce locking in nfsd_lookup()
      NFSD: use explicit lock/unlock for directory ops
      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
      NFSD: discard fh_locked flag and fh_lock/fh_unlock

Zhang Jiaming (1):
      NFSD: Fix space and spelling mistake

 Documentation/fault-injection/fault-injection.rst |   7 +
 fs/lockd/svc4proc.c                               |  12 +-
 fs/lockd/svclock.c                                |  10 +-
 fs/lockd/svcproc.c                                |   5 +-
 fs/lockd/xdr4.c                                   |  19 +--
 fs/nfsd/acl.h                                     |   6 +-
 fs/nfsd/filecache.c                               | 745 ++++++++++++++++++=
+++++++++++++++++++++++++++++++++++---------------------------------
 fs/nfsd/filecache.h                               |  11 +-
 fs/nfsd/netns.h                                   |   3 +
 fs/nfsd/nfs2acl.c                                 |   6 +-
 fs/nfsd/nfs3acl.c                                 |   4 +-
 fs/nfsd/nfs3proc.c                                |  35 ++--
 fs/nfsd/nfs4acl.c                                 |  46 +-----
 fs/nfsd/nfs4callback.c                            |  37 +++--
 fs/nfsd/nfs4proc.c                                | 330 ++++++++++++++++++=
--------------------
 fs/nfsd/nfs4state.c                               | 127 ++++++++++++---
 fs/nfsd/nfs4xdr.c                                 | 123 +++++++--------
 fs/nfsd/nfsctl.c                                  |  21 +--
 fs/nfsd/nfsd.h                                    |   6 +
 fs/nfsd/nfsfh.c                                   |  27 +++-
 fs/nfsd/nfsfh.h                                   |  58 +------
 fs/nfsd/nfsproc.c                                 |  27 +++-
 fs/nfsd/state.h                                   |   1 -
 fs/nfsd/trace.h                                   | 327 ++++++++++++++++++=
+++++++++++++++-----
 fs/nfsd/vfs.c                                     | 256 +++++++++++++++---=
------------
 fs/nfsd/vfs.h                                     |  33 +++-
 fs/nfsd/xdr4.h                                    |  60 +++++--
 include/linux/lockd/lockd.h                       |   1 +
 include/linux/lockd/xdr.h                         |   2 +
 include/linux/nfs_ssc.h                           |   2 +-
 include/linux/sunrpc/xdr.h                        |   4 +-
 include/trace/events/sunrpc.h                     |  14 +-
 net/sunrpc/svc_xprt.c                             |   2 +-
 33 files changed, 1424 insertions(+), 943 deletions(-)
--
Chuck Lever



