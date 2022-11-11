Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDD625DE1
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 16:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiKKPIy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 10:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiKKPH7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 10:07:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100E6586A;
        Fri, 11 Nov 2022 07:06:09 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABF4O6L024035;
        Fri, 11 Nov 2022 15:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=d0YegtZMiH7AmFGXrjtbvfqxF6qr0VbxJVWnHrlPn40=;
 b=dERAdDbLhLn0ruoQK1/TyXne1Wb58ImPgnCSgOZz02RSr8N8O8ZnOIqOthJT4/hV2KbM
 82v6MuKrf35D/4wEHdrtUR0r9BK6VIf3hFJleYaqS5hP65+KFzh++3zxCBf1OGAt1nXG
 3AAxiGPXDs5FOWjnv4Iu1cmt8hp4d9Xoh/D++bqngVG44gwFWQ6XZCJwIZtstLB+6dIm
 IrXyJTrCM7Ogr1reRi9kQLpEfDoycHBhQ0qKp8iROYO7cZEqVahH/9dlOF6VACDKATtx
 IsiMX9rouK6cri5kqXUR+y1UfsB7D00JJpuHh6nw2Low/YS5XBh5jN0zLqlh5Zp2AnfU 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksre481rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:05:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWomw009007;
        Fri, 11 Nov 2022 15:05:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqmmhxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 15:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpdDCNrTlmARHwiqk3/fkLpSUSCV27/Lxk9pS4N/EAPeamKiGO5PyAT3rx5UVc2ZbjKKEj3o1zwhsxWz+RyRQSQPwAipycElEeWLwr/2tHwJwyiuMZfG/FtiAI5cyHUKBLOhpF/tirFtb66HNcTu3kZ7g9MZzdMXPcHb5YKJx9l1D8pr2zJSm0x3YOFJ8PECMWtXER6dez0gGsnot+HWh09OkW2rM01vWvm52N+h2GOHBF4cAhpXf7aNe+l1nMOe4RCWx8p4DpzwpAcu68qLAPv4FaX08HkWV9O+xPcnXCDAu0N/CdrJeoU09Bh0P0JN1uC273+yUSJs0S48geJNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0YegtZMiH7AmFGXrjtbvfqxF6qr0VbxJVWnHrlPn40=;
 b=PjN26czTSZASgnIMFqzcREGtvOm5B+c8HhDYhYFjBS+dd2qJRsO9LLah9Kct58l01JeceGokYpQrh0t7B+Ek4SCL4pX/lhuAk1WDqGXMUOBboRJ9rFTL+SKDwqRlxGoxLsrDLc87+TJw9j9rKPW+cZX1dY3XG97WxhdQapE9RKg8oe3Q+mmt1apQAX7l1K35ohbAYAO9dtLRU3hoski2Gnh0NlgZAlcMy8Yd2TpeRUla43gGHV0Mm0etn2i+sT9DDjQo4RC0W8P4G3ywHQjAM0+/P2QLtbgG9g6hXJraZVThBDx/+TMQe8nd5dSQzH1Wwet7EAGdUBMansdSDlDl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0YegtZMiH7AmFGXrjtbvfqxF6qr0VbxJVWnHrlPn40=;
 b=SFmbpzfn+ZOBeqDbDAKS7QdLDUSzXFTH4132nKY9moEq8S6U9pys7pqubcxT57GW6LAVmAbu7KSzmKImDqljFlvff77uastEvvkXhwtysSsqAl2VF0pkjwpgJcf+HlxLtlA1GoY8YmGfRdUEOAarMPvviiFZCcTVGW2po/07DRc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6388.namprd10.prod.outlook.com (2603:10b6:510:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 15:05:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 15:05:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] 4th round of NFSD fixes for v6.1-rc
Thread-Topic: [GIT PULL] 4th round of NFSD fixes for v6.1-rc
Thread-Index: AQHY9d8N9gJCwwONH0GBmuVB2Vo91w==
Date:   Fri, 11 Nov 2022 15:05:35 +0000
Message-ID: <90885D9A-C975-4B82-BC17-137F80E14181@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6388:EE_
x-ms-office365-filtering-correlation-id: 843d48ea-5cd6-410d-27fb-08dac3f62f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jWk7w/XudZOzX5T4H0Oq7zMTy7IW7EZNZP2XONf73ktm8Gbu2dkLKscKCyaKiHgE/xTs6oDjW258plpLJv5bTDODfIa5kBSJKLPKoWqAf/wJghpci9gAFmkDkxx8sAm4Acbb0sIrTAVBA4SjVEt0/VqY18viA863ZRJqMhhNsvYAJalYeidpGwspg/jEqcDC2WZhrwGKqZqFdCF8Tdadl/7ojTh+FghR0rtYofHpdtFK/F2x+cJU4yV89VPdIOmhxPA1EuobQTG/UbQnkPs1BoJKFPnSCmPoFGpPCn+ACWnO06fKiKNO6b3gpXdU2q1lmY7fDtlLBbI+drhYL5vNY8ecJTZDO+D+IWx6PFBqJABfdlnIWERSjBLLiFeDRPjpvGTpnedpIlQlx6c7xeUTTxuEc6Tv49XRbmWToI7HOoMM3MwEK/Wd3huxyHPwnw2+uopWhP/gvQrfSHHHHWOfjgoQ944+p4hKzFaFCYttt2TTB2qwYCMFGzTir2BgOuD13D33nlBgCBYccKAvXNnPw0hojPm1x0MLqRcTarQuxReGfn689iWcwq7ySdHVbVHkSZwpUx51rQgh9+2IlmhUTiAmn+DJU51p+IEpFGNanV8k2cr0YnWuYAj0G7kMJl7OF6uiVwiN3uCfO5+eBIgOSALJhDN4ScHSTO/kkkTIxrcajXNzm0ocD1PSCQBU6N0oY+wWPSzgp+ntS0LjnAM72oljyYQ0xSqaCQnpMCKbpC3rQYSbZgI7060M5oxW7YJT8A7a0g3ytMycYv5Vzl6xvjjBUWlSBJcLWT+Leccd90/THJi1BLLS8BidhNIcl0cWviz4gS6hcGF4DbWNoYcjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(2616005)(36756003)(86362001)(186003)(83380400001)(6486002)(71200400001)(76116006)(66946007)(66556008)(4744005)(66476007)(66446008)(64756008)(5660300002)(38070700005)(8936002)(2906002)(478600001)(33656002)(41300700001)(26005)(38100700002)(6916009)(6506007)(8676002)(6512007)(91956017)(316002)(4326008)(966005)(122000001)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3G8T4EzQ6BmOzACc5DJAjB8Xyc8ltAf9m8Rp2UziUOvJ42VxbwrCiKNPXReM?=
 =?us-ascii?Q?UoU76nVagXK1NBq2mpyuvo9BQINmv+YEglfTeV9jE+oOCNGCXJ90cfojGZPz?=
 =?us-ascii?Q?TeUy8Hmqsul22IdONc8pFreOkUh6q2Ti/yCk1038GZ6DkZ2N0i1Pna0yOz88?=
 =?us-ascii?Q?qWmHoMNmX+pIzlX4kf+mqTnzVLy50OML1x/ZGDiCQK8T7YBs/OFaNt2fYzP9?=
 =?us-ascii?Q?Bl2rEtDSJDtXf1+daOLlnaFpFDuVfYWklt++fAuf+0F+xRVGAv/+mg4qitJw?=
 =?us-ascii?Q?43Oj6r9zmjTVH1MMSRyDZSu/CWbGFZt8ffiwrpp021zx76S8tqsr0EizjIM8?=
 =?us-ascii?Q?gmTqXEk99BRosmOEjXp6t+/ReypvWS0ljsR2LWKEURvpNlAxkYH5Da2cficT?=
 =?us-ascii?Q?4SKcuEWSU7tfKroyiKEiEfK4x2QgJ/Gkp7YUutxdCuSvr5LmkeWRdsLb2/f6?=
 =?us-ascii?Q?lgCIWu46bvZacVhvwf/qzvybpfhsCGRYggjIpCRQeH4wX/3PS3j48E1bLSEz?=
 =?us-ascii?Q?tpoFJwLVH0IdpN74Nm+I6X4xG2VsAAoApJw/DWG6fB2qJf84tGlvSnVEAu42?=
 =?us-ascii?Q?I/xu+PdubdBb+YbmLwHV2LbYzG6wFm67KXzQlAAlKM+GrUhjTkYtf7cDcuPU?=
 =?us-ascii?Q?pL0+yeapJPMvX2axPXfHmflgGXGYr+2uiZG56tCd4P2/9awJhgN7R/5TpYDV?=
 =?us-ascii?Q?CcErTQxQRz6XCpvVsqtGpsOdKJWPffu3dsgDd9sDFy4K4xDrrutcGPAuvICI?=
 =?us-ascii?Q?Hh4Ua+xh42p9OW9XXbRfoj6t83rgH74Qe8zmt0kzW3nY/TBCeSoOOeA5RAko?=
 =?us-ascii?Q?+gVk42TkuyNbClwNlP/jBxyWc13/N+t1AH/VXkjv7iOdEN11YuTKlnOns/3l?=
 =?us-ascii?Q?4bML9WvUNDl2hwQY21JLEAFe/iP1VR07/WpPbrvgaHmtCs2eECe4nIEtdTKI?=
 =?us-ascii?Q?i0Ta+ezwexITo4QsyYrSuH3zOejWiFUmVkPv6mWPF2bHfHXFxJZolDV5tFj+?=
 =?us-ascii?Q?f6UQU8HpTdA3ThEs/5xVXP1CymmQi/riOjxfGYuAm3IG0JXSNabO+o+mEMks?=
 =?us-ascii?Q?k8Klm0ukeprZRNGN03P9/aZ2BQ/U++YBe6w9RyrLLFVd9FhgOjn9GkHshf4W?=
 =?us-ascii?Q?ASkWWsMkWfAlebVpDEDnsddZ/KZIEFc206bxn+zttAS2pc+6DtaiXXWZ09yK?=
 =?us-ascii?Q?TFrFPNSFVhCFmGiJL9kuEHzUU0MmAOFDDpiQcGtdyefvw87BySEBW5bIIuaJ?=
 =?us-ascii?Q?jPP2e1AcE4PPehV2OZxQGbQjcJj/vceeIl1a5KU9IiDqVhDsIa4ecQm8/9Zc?=
 =?us-ascii?Q?9few+VVzcUeyJ6Ks1snO2HDsi79awj5SXJSdRyIZVcw/nfO8KOYVsK926/8x?=
 =?us-ascii?Q?HUw1d/ANfFzmYeD7w1U1HKLOG8aOK3SecJdwn3TizTvcHSfgi5CEh8WozVVC?=
 =?us-ascii?Q?NQ8P/vgP+XzuFm9AFHUKyttt0ZlIESWbc5mWf267y4D5a+9ogOAmcPXSZ7FT?=
 =?us-ascii?Q?aEWvrQT/anEHhHMVc+VUmW0IpeU9pUQZaq6JHw0Sg1B9oJ9w1Bn1krS1jpKZ?=
 =?us-ascii?Q?f7k6TRc1D8CE7AA0YDfbgcmhpk6cc7yKcjoW/1BXxDX7s+M5NU2o8LqgEae3?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72C3B857B13BB64A90AFF0E22CF68D08@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m3JxERrCIlggL0TFeUEkxcz5yZRj3Jbi/FbpCreUfgbTREjJvAZqYAy2WeyFX8unlpZrV7A38SarRT4xbfo1dszkyN7gAr2X+OuUFldKgSBTrJjPdYlMaVajJh9YjVcNUaR4lShHnW7954glf25JpoyGvK9qj6KxN3x5/TwLiR/6Z+b/pM/2IlHo3pGffzXYLp14Q8TQ9phPmjazxrtJg9VyvC53YyfvfZYXpkrWczzrCkyp8/Zf2Vm6CqKpQegF0wHNAJ37YqgawAydwXKqN7aa7XRZjgMwBOr59uXaS1saoZls8c/sB2S0MvlBnICwLyDdq/c0JYCtKPLsq6G0t52ZX72HSPT5jt4IZ7dRHPiiEasM3hN2YyXlm3VOzFOAKJCEUqCtli0kT/3QC6GTzTwjpnB6cxfIwbEm3W6YPZOkSOQiK8HoPMZO0Ctjn7BlES1gnI/hHXm/qIrF9UJBe+v2Zs877XSNyFSONZ0SWvOhH7xM2ie52DE9Bwj8GlvNYUsrRuw9OGyDJGl3K9yZmUlPSD9HXs+GwCSo9YzViBeGacNjcMTJRkQuTwI9rLIJnD0PUAio1olEWHG6g+CAY1carU0UNhO/Yheqa0wYWzgPFQnI/4yAUv1TQA+QBVHfy2IAkc7w8HNpPWLgCD6uMuAFYjNMpeN+fb5a1SqXbz+dlhZmZB6cRSC3pW2wVCWrRhG3j4FO/zr18lQsdcLP97mdrcUjlGbZNLXvynYnoGZBgBOTr1t+zxLTE2yR+p/1WYq8t14KhiIRSCCL3CJuRwwlczcuJypytzBKWbMDGxjZde0iEDaI80A1fEvU4VnGXiB+Rq5gpGeLpDS7ikCgpymMkfmU7vmk096sZmGctCmpAiVgBJC7upwodXgw1pgNCOVkeoT+rkEslUGGy3wSBQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843d48ea-5cd6-410d-27fb-08dac3f62f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 15:05:35.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEka2gEj1HLZWz0OPfrPNPJ+1gjROgh9K5cKCyr3WxuJoV8bpA13WPVdOAWwVwwuMTQiMyFs4epYMkltT+3MHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110100
X-Proofpoint-ORIG-GUID: iSTbu-cmWN4lfk0Bl5FOANiVthvzIclj
X-Proofpoint-GUID: iSTbu-cmWN4lfk0Bl5FOANiVthvzIclj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit d3aefd2b29ff5ffdeb5c06a7d3191a027a18cdb8=
:

  nfsd: fix net-namespace logic in __nfsd_file_cache_purge (2022-11-01 17:2=
7:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.1-4

for you to fetch changes up to 50256e4793a5e5ab77703c82a47344ad2e774a59:

  nfsd: put the export reference in nfsd4_verify_deleg_dentry (2022-11-08 1=
1:32:53 -0500)

----------------------------------------------------------------
Fixes:
- Fix an export leak
- Fix a potential tracepoint crash

----------------------------------------------------------------
Jeff Layton (2):
      nfsd: fix use-after-free in nfsd_file_do_acquire tracepoint
      nfsd: put the export reference in nfsd4_verify_deleg_dentry

 fs/nfsd/filecache.c | 1 +
 fs/nfsd/nfs4state.c | 1 +
 2 files changed, 2 insertions(+)

--
Chuck Lever



