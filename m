Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316D4FEAD3
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Apr 2022 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiDLXgB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 19:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiDLXc6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 19:32:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E9C6B63;
        Tue, 12 Apr 2022 15:21:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CMCtUn008564;
        Tue, 12 Apr 2022 22:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bmQHTao6+4yGPbVrTI6lL3FQ/ouTVy5YFS4xG0oSQE4=;
 b=wVAcfDb7AmHQDmn0NfFd29Az/99ik/qoFhdNGGCA1o2VvP45CCNy5GFZqgtTNclYe5zQ
 HYb/Xaf23Vm+dF4rPAia+3GXBdkZZmODhJrLILeeno/VFBcEty53WGyP67aPDbGsTVkW
 vP2U/SjXfZEm1Fy0YYiZK6DcrxrhtBLQrSH6dyPbmPOl35gvjNLanTxk3vDVf4yedHtJ
 DgZFXBk9NS7mXZyOfcm6fPRl1kVVKt6R19/xB7oir1Szp0O+0HNJYJ8rfuE0QMthAqQ0
 Qyol8jMMAFe/4GOTzrNX6wYB61dlgnPz3zSw1aS0wVmjOdVNq8CDSq8LGxpe8GOE7qjz Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2gaqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 22:21:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CM1PeH030144;
        Tue, 12 Apr 2022 22:21:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k3cwsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 22:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjox7yOQ+VgA9BZgPvH8U2jhmoxvvrRIzgFXaHstW1OYLon25L+QJUsWAZbAdDYp6Fc8n/KD40DYkqW1ElBtBu8dof77Ca2y1qlTh1cZdWF8JYRVgUTTazN513kIcsTksvcruXkiAzyWr0XzEnOdayrJdaqjMDp/YXFDpKBvPgCzWAPJ8cabcXOao9FBwRKE21Ci5laT2p7rNZABEtSPxWLDOqBwbqWp84gxhkXTrFAfsoNZnRCBsZINI7riovHZkl2Jq+EVNPKMj7syrCGMr2ZgnDt0LpqlE4C9dck+Fwq1T/53Gsy9Q5qqaXXQglSdvUxlwskboseq5AKSZYEXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmQHTao6+4yGPbVrTI6lL3FQ/ouTVy5YFS4xG0oSQE4=;
 b=Pl9je00yYg9SQUmsFOpSSbLUcIdROaX0dDjoUbBxTZ4mpXpagSmqy2ivJ1BTiR9C3WiUn3XCmsnxQFK9AmwtHBxaekhh91uybozerXmu8Vy/c0RqwPEevrmgKEhilvDcfsF4P4puAGxI0HeNi5wAYgL36OGeCKx6EgjHlyJ2lB/cVUH3SlZBWf2DauvBGDl5VfBnBcHNcTCCzXploJWp9DhaLNc9dz6bOtsuGNHudYif+x6C/xnUcn4iqm5B85DTEMonruFOHDBYVTLtJIaqNpCmSUoVg6bCSbO/IritIOgTKgFfISwu7p/dsrFQ0ql1npcH9e1ofckabAzBIeqijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmQHTao6+4yGPbVrTI6lL3FQ/ouTVy5YFS4xG0oSQE4=;
 b=vKkoqv4aODyfvazG0z6o3GRTrDHtQcc4CuITg/hRCBH/CCfqnHsl0GNU25dZu8+vvsQ/aRFlyIpirgF4EzAOISR1jYjsNgW9nYeforXdyuu2L2oHQjglz7NWihTBfErZtgbHCc67jlXu2monhRktB/guQjYkrtFJtr/s3OHJaDA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL0PR10MB2897.namprd10.prod.outlook.com (2603:10b6:208:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 22:21:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 22:21:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] 1st set of changes for v5.18-rc
Thread-Topic: [GIT PULL] 1st set of changes for v5.18-rc
Thread-Index: AQHYTrugjVduezQ+B0SoTClKcUWhmQ==
Date:   Tue, 12 Apr 2022 22:21:16 +0000
Message-ID: <EBEC3138-E799-4F0A-B9BE-9445F8A17E71@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9597446c-1d19-40fa-c5a8-08da1cd2c2c8
x-ms-traffictypediagnostic: BL0PR10MB2897:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2897C7F419108B2D88F3485A93ED9@BL0PR10MB2897.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7XosE7VoSxm+/aw0pcVJG0ePpIfz/qKEJD6DAM1qUfGzxrtB0w0MpeGgSHrZbGxadJvLkIwXwEfhUgkU6ZBdTS7FHj13kqAihQAdtE4tebToD1I4X/XN+i1RH2k0aeIxvtg/BMq58mETgu0pfHp0Rn2rQgfEQxmU92b6x3mn596WyMMJ/2iJnCWsuMKnNKXoy6u0wqDXd2OYeswx0J6C/gf4byAGx2HDgWNVIOmzOCohteREToOEn+lo97ilu39332EgOWFCqqIFs/RcJMOU9F9piTp8uzdvIBvaj+zYJV4YcFj8wiWgGo2sOKHO4BydcaGdZno9qHnNeZ68gGygZrgPKm+td6M+UHHl2oUj5JhARoCTFgkP3luzydnxhUhg0sCOBLiHOLbGM771cc3MrtGNXKHZavFLTVSnP01eUZA1Sor0UdfyeWgSrDoG6i1QFScnSylBNMNw289edQ6C9niTFQ8lQHoOaFt44FhuEZAE5jBYcABr5HM8wvYFzXd3nnLsxDXXH9jP/HrKDcNcpRGFv7GmMR50picc9cbIsRtRhS9Il3/mDalJCwZSoyrT3yDHosYzGyEZKGmezaHg2YLzhM0i7JmClBnESq54yJiGkGXZv9FM46j493hnKsUGyj/ubLJtJu9yVZCHuaLOtSuScr+b5V7Mw6SAGxrQcD8IpiaPDk4KEas6DvQ3//kBT8W/sWmaGXWIyQeyODearmzT8SBVD7gxVsFxCKwotd3AYIw6k2Uh/LaKYjPYGUc1yldNWLGhzWuncfO8VmeHR9WQ50o6yCv7QYfI6ZykUnPnGkQ3WvFBqdn/bEpATH4Tmz+bNGtbhwScWcrk9roqjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(26005)(6512007)(2906002)(36756003)(54906003)(6916009)(8676002)(4326008)(91956017)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(33656002)(6486002)(966005)(8936002)(5660300002)(6506007)(83380400001)(316002)(122000001)(86362001)(2616005)(38100700002)(38070700005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?shlY/5QmnnsKr410rP7ehPtvH1qa7sBwB0iMam3EMF5n1PNYrJwyJKvTn4U9?=
 =?us-ascii?Q?vM5x5jSFekxThycArUQUAyFJqgvMFXekfLynpmTuXSk15lXWmH8dsMmMsMSi?=
 =?us-ascii?Q?pCWuKgND+N7QL6Dc6D4iLEgZgyoOTwo/+AM3Ai/tVBEg8nqSEnejkIAZwjFe?=
 =?us-ascii?Q?msLpzdcls+s7YYBtQ9Lnnmm7xCExC+Cs3Rc4IkOSNBP8Rw8GbCRkb1dBAjPJ?=
 =?us-ascii?Q?KkByP9Gd+WN+nt4guH/qCOiexOeE464XOrFNXvgrpyIpQrfKSbT6m/jwHgxm?=
 =?us-ascii?Q?VUEvnjHBxH+p72x2cuy7JnZUg3WgUnynNPMAFakJXl0V8N7KGGMjE/g2GB3d?=
 =?us-ascii?Q?iZb8wzQtT+APkcbmaHAcAA9XwAXIs7iDXUTqxDgI2bi0phyhtAtnVrUKUEKV?=
 =?us-ascii?Q?HB9vE3MC10PHSb4/mJXt3phtgiQGQUDDIbII4H53l4i/jg67uPsivAEkrfnD?=
 =?us-ascii?Q?wFBmVTAMM3regMQWuUFPo+7R4dnmpdnnPdGyKTIDjh3n7RD6sXN1NEn51ehr?=
 =?us-ascii?Q?f+MAe/E74KPizJj62OgyHSZL5ExaIf3c4R5KOIlYbgfLxtjV14dCYGzcnh48?=
 =?us-ascii?Q?KPy1EKWJXyRcrBf8ohOmkwh3+NylzDJCEHOKCr8pT/vqUN3LF4fL6VS6KwV0?=
 =?us-ascii?Q?66qv5QH54YJJMmkCa9pSBS4sVFp7fFXWcX/Fi5Oodikx/m6XBOEgPckzyZ/1?=
 =?us-ascii?Q?y4kdhUOOukX62wRcximtoOO5s6ZFMmdXox/S+NzPQKtXOn3g52ipULxpyE2P?=
 =?us-ascii?Q?RZoUe9Tz31/FNxIClwNRFQfEyPRTU5dJUe1hEo8zuG0Ts6qc7gXJq13OwaPq?=
 =?us-ascii?Q?vqs/Yczxg+R17ME7cmUwpIIi3Ww0ouVdcI17kD92U9Hvk3pAwJhBNoRSSFms?=
 =?us-ascii?Q?55KCEeLrjsc71CwMrgkpqN4H7245hBOpqhLdrmK7oni7U91S7bDCtDAuF11a?=
 =?us-ascii?Q?ZFvHxciX+ntZWVaMTEs1T8BWUsLrk/vveUK+IQFnjgmAsKZZmwTuFt0EsqPF?=
 =?us-ascii?Q?1821uRJ/aRritYv4mOigs6o0JdyXzB/8KD2jc+MweuHmSek2eEMw/+IO5brL?=
 =?us-ascii?Q?5HTjhXHXjp4FSMB2dLRuQErfLy/5aujVCfsn0DpeD9CKqx7h5Xu5ElVfscgR?=
 =?us-ascii?Q?/5otoAdWQa3PQUfiLdEAgva28ZaWC5RyNnUH691OMFiOm75NffISFSpBbwDz?=
 =?us-ascii?Q?5sUHsHJSbF7tI4uaioFw8glP2E4tYk3PUVydvVy8VKDzJveKrzaOPKupksWm?=
 =?us-ascii?Q?UtI5VUI6+80hRDKpqFmX9oXwtjswuEPMLjNmgIT2OuS7PfR+yZP6tyP2w1TI?=
 =?us-ascii?Q?/BoGNGkKlTKVzLqXmw1VParqG6YnHXhrTIhMfhgAwJPzEYo/wM6RJY8Hstej?=
 =?us-ascii?Q?clIDq6nma7KGSJvH+uru9jlXxFlok+8EZpbw5eaD2cmPHr5FG8O5FTl7eyG8?=
 =?us-ascii?Q?SFLR5jTp+mD0n3hgj6b6Tu78xOWlKHRXhJPJf5pVfLklUkiW85BBUQVAS3Sl?=
 =?us-ascii?Q?d0iLVwMJL+4zaWCABw6lKmIjIESrJ5rb9SEwrOoFRGqAH+HGzyhcnsYVPX8y?=
 =?us-ascii?Q?c+Fiki3vPlTDYaSjZYjZ49waFypR+CoC1fzSQc8pv6QJ6lFsPGK3/O3emu0n?=
 =?us-ascii?Q?DL1IMN1RnnTB15VKElWFFfFLwr8vVd7XCeivck2UF/SWhAVpzEenNDRmoDsL?=
 =?us-ascii?Q?tscuH3r4nZ3WLEyAYXpnwt3oTIurlJ5gz7237EaF9YMFQlry0/rr/kqzl9Rp?=
 =?us-ascii?Q?p6OzZC/gJVumriRjo1YSzOIQYvt/zas=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C96C974BA3A514B89145CCD1A71B0CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9597446c-1d19-40fa-c5a8-08da1cd2c2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 22:21:16.2056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25PFghWMaoF8TN+N3TN5XFZZ/PmENyZIhEBNqGfUAVkEPf6Bg6vpeYMZdXViu0CQiO94x6O13IkkrFCgVm2twg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2897
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120101
X-Proofpoint-ORIG-GUID: 6p_fxZYGeYVBiuEMlrVdRkaJi4OE-HQs
X-Proofpoint-GUID: 6p_fxZYGeYVBiuEMlrVdRkaJi4OE-HQs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 4fc5f5346592cdc91689455d83885b0af65d71b8=
:

  nfsd: fix using the correct variable for sizeof() (2022-03-20 12:49:38 -0=
400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5=
.18-1

for you to fetch changes up to 4d5004451ab2218eab94a30e1841462c9316ba19:

  SUNRPC: Fix the svc_deferred_event trace class (2022-04-07 10:22:51 -0400=
)

----------------------------------------------------------------
NFSD bug fixes for 5.18-rc:

- Fix a write performance regression
- Fix crashes during request deferral on RDMA transports

----------------------------------------------------------------
Chuck Lever (2):
      SUNRPC: Fix NFSD's request deferral on RDMA transports
      SUNRPC: Fix the svc_deferred_event trace class

Haowen Bai (1):
      SUNRPC: Return true/false (not 1/0) from bool functions

Trond Myklebust (2):
      nfsd: Fix a write performance regression
      nfsd: Clean up nfsd_file_put()

 fs/nfsd/filecache.c                     | 25 +++++++++++++++----------
 fs/nfsd/nfs2acl.c                       | 24 ++++++++++++------------
 include/linux/sunrpc/svc.h              |  1 +
 include/trace/events/sunrpc.h           |  7 ++++---
 net/sunrpc/svc_xprt.c                   |  3 +++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  2 +-
 6 files changed, 36 insertions(+), 26 deletions(-)

--
Chuck Lever



