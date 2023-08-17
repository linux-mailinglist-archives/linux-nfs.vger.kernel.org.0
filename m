Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8177F86A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351694AbjHQOLl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351732AbjHQOLd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 10:11:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69632E55;
        Thu, 17 Aug 2023 07:11:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCOGxE016436;
        Thu, 17 Aug 2023 14:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cDHj6Ye6/raoGcLDRt9F/7OaYtsSjGyL/OUxRBUXeyk=;
 b=JCJNgga05hg7iEW5pR/1dhU45FBHthMEmvL76jVjnsr7yWt8SqAlNHIRlqpMP1Sz40+j
 k3Xle5eNLK6g3sW4CdnOdbKzd1EiaJPiMGpnqvWndcax2a6rSDMAR7xIQ2K0lzIRNLsY
 Cf4hymZ6SC4wcEGY1bUSeiuHl3OdTKBQVHi+MF2Fv36YzviAGQFN3+oD2HkmflByj5yB
 w+PjllnRFlk81z+DSAUDlialcqna6NInCBicrxXhr+6LiUPO4v0iwnr+vip5UxI63d/S
 nExxwiWKZmenGj6DeK5I889QAWeLWS5DFgaLm4zCVs0a6Tk/pjhZaSVkOD1pqRIGKTp5 aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w61mhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:11:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HD2fkE003854;
        Thu, 17 Aug 2023 14:11:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexymnuc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOkXFuTCvCWsSv7oeD4Y/bIvoxMMDABp82R7+Dl3G2/gBeY8qTruqGXMmmFWlWO7X0BLxAQ80nKbIPcNVRc9JBssQvQw0/HW7E0U8T0SCfgrVH0nlProer1cUeExratymSqKjrx1Gy3upqEtwrmME0svykdpE2PK6wBIzznUUSVBZsmZ7RQD43tO2FAlHrlWqv5LWF74kNKXS9hbIf+s0D5wAx5lZG299QtF0wN17nozBc160ZAuXPTQnQjvYcTHkBlyN7/hut2V5DRjuzv7ffxYjB8BMk03emF6ZrE1Ifngvrr6BgPN/oVzA6t2W8F+odlzELYo1jMm3Z1AATIEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDHj6Ye6/raoGcLDRt9F/7OaYtsSjGyL/OUxRBUXeyk=;
 b=YU+TvOvs/fo1lyfiZUIGSJ8uddAj/kBbGkBzDMjodTaCQSTb+TrmrpglU7oBdD0tQg7IBWvI9kB2XMie9EPn2ICB4RFc8ikZijWXbtx/fhIA+nJntLcTpx4VbgfmdxqYud4ZjxWMRRjoe8R1efdVFH/PNZU0irvmLYwrHkVwrhVGSgLheaBRkGuKCAOoC+YDQfE2GhEk+XigCPsgigIOn6/0DUCG4YMRq6Z5c6AkagjRD+H+b0DsKAKZhrl6u2mHN49JQpDk3cQvo227TjxFGsYGOwNdEzRx+0z2I7giGHUVo/DTjMOOueb3Tthc5Vz21C7Lrqn5VZtVy+TwqL8tIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDHj6Ye6/raoGcLDRt9F/7OaYtsSjGyL/OUxRBUXeyk=;
 b=cKMaKuLv3CdghypACj0bSx4GPKx7GhoHvvELuBOoYiNqaLH3SGconAsyERYzbo4FAWmJAMNlJQu0n2YMNo1UD4rz9W1PRf82JkLmoxxjw9t0fHtXL7bdk8xAy4j6B9RBhhbE2WhuFiJn5vdOwgctcmUY8NXI2GDH0KF2tjzKAWQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7823.namprd10.prod.outlook.com (2603:10b6:408:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 14:11:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:11:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] one more nfsd fix for 6.5-rc
Thread-Topic: [GIT PULL] one more nfsd fix for 6.5-rc
Thread-Index: AQHZ0RSyzjP6VNvMW0mV7y0UFqXFPw==
Date:   Thu, 17 Aug 2023 14:11:20 +0000
Message-ID: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV8PR10MB7823:EE_
x-ms-office365-filtering-correlation-id: 14f13aa1-d00e-4945-0bf7-08db9f2bd4fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5uAKxYFisjLtUT1W2ZgXYZRpnlizd5uI0gfKKrU84LhXG0T0I/IpJYPFuxYg+OXzZ5qvDRFDyCZdyFVPKdR1ZU3rLp68VF2QrFuCRujceR8METohm0K1s6lXQJ/DVE6DmF+1HcCDa2VfgO0wriFBLzT9VE1oU7Pe8LIKjhgMz6ZShBkzgC83cFfSznHRmlQAajIYeuNuRjUNq6qXORBdTpdjiKdGYHaDd7C0ZGFyrhgQQwEGJrOA0Gj/Rg0jgjJo15EMbEMF3NMXlnlq9HrWB4VFlB4W3AUtwJQieWypdP1Za7CaYEa+UsX1e0y9WHMBZexyWFv0CpwXplzMZRvQvL6gKp3Bxt5H7YGBuawPPPwVa5OJiGfvO/3VpBrk/h2CEsek3nCfWgGiTB/7kaaQ/4kf3e1fLhz9zPA2Y2AbWfiJTZClDf0XPhS3y830Jzi3MwlUN9dvVUpNmAEt/r5lv/xfF0bZauj4nW4kyLiwY4iyIfT5AOFurNh1c8TD7mUB1J69f/kZX7lqgapA15WJ5wg+0aGR55AUQS0DKzoZgqBpF5CEkHXMsgnCBubO38eICpChRziMLzbW3iqXPOwiNN0mKY9fhTzZunIfTqyvnSJ0YunGtr3LP++18782IfAfAlaQEyTCB3h9zjk726UmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(36756003)(33656002)(86362001)(6916009)(8676002)(4326008)(5660300002)(2906002)(8936002)(41300700001)(26005)(6506007)(71200400001)(6486002)(4744005)(2616005)(6512007)(966005)(66946007)(91956017)(122000001)(478600001)(38070700005)(38100700002)(66476007)(316002)(76116006)(54906003)(66446008)(66556008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Sm2bfTFNKMHkoj3klT5giRCCLXVPsIs7koz2qiQniOxOaz/F0XUGVb4tToA?=
 =?us-ascii?Q?hRyLHT3AgOuBnqTYlIEE7s63ajimSkK2prieklOeTdKVfn5yDhBKsDaimSzy?=
 =?us-ascii?Q?7od088SzWd3mL3HGqp2eSALCZiMl/aK0ADLqAcd4JFzLgkWMReK3ZxHXSyPH?=
 =?us-ascii?Q?ArKk5SiYBuBdtwmfibKKyIS3CK66idi5SBmWC9b6mPrff1fYZ06LO9h/S04Z?=
 =?us-ascii?Q?ZT03Qk6xIBE3jLyHBYvStiPrhOsPSX+WCebQmcHBDFbKtJy+BX7o/SLzYLsJ?=
 =?us-ascii?Q?PK9piHK9qeMmBZ5daFBD45+uidLwq5GX89uyW+eVCGmPTjFuK3wyT5x501D6?=
 =?us-ascii?Q?hbto7mRZWEeGwyLGtDWwkrMHXrQ6o7vZgLEFgz+vZa7FsRSQ5+/OL0gb4WiN?=
 =?us-ascii?Q?o8+pfGmOK0icfA80xeK/mqUoeWuQ1gpaxD6fafkIMclCNFhpZZWI3WSidhX5?=
 =?us-ascii?Q?iYROs3roMgVvFHAH3m/StJ79AsGNQcH0NbtXUJip1Q8oiYH8YiSubf0syQ89?=
 =?us-ascii?Q?EKLxKGlYG9nP+QF5eUeqJhHYrrcSNnzCPjnHF9p0LHfQnfjPLZPnmvmraqpt?=
 =?us-ascii?Q?yXok792U30hs3QOnWXNZZs4h88r3JXXIweF07rMGQnD+6leGQm/2DXqZHL4h?=
 =?us-ascii?Q?mnMy5WduBOs3Y8rv6HSOgNpB3quzz33vsPHxPq3f5hfQVpPddslph8dk5PdB?=
 =?us-ascii?Q?JX53lm++Ijb6mgaEKp4oZ4kzdj4gXHD61/4CXrJ5ObdKGPjl8Qory4G2aCty?=
 =?us-ascii?Q?W0DmTXg7rE4hsFYrejxftiyKkt/7VU+XNVuLjKbec784sR2TjNX1l2JCG0b6?=
 =?us-ascii?Q?5/l0e2S6IRTu3UiHksEYecB8rOwJgvEXFk5MdIjIZluq5ct0wdcpqWKZThFk?=
 =?us-ascii?Q?MsBeJETAhWwuPzJmE+v6hIHc9SCfOISpHAU7y6wW1XYWqCVuo1eucpygTuUW?=
 =?us-ascii?Q?hfpZ+QUAFirNYjdmLIOIkTW7ghjgIaUuhjaXYZL4/z4f5j0QEUcx0EP19n4I?=
 =?us-ascii?Q?pL7GpELBCrLknjObma3P4Jl1DOdJs25D0ebn1orejapZwvaZr/e+MSdCFn0x?=
 =?us-ascii?Q?s72GG8ptyNrlZZ7CsUDtLxF7R8/7NH9nyxYWvdLDf0y2Lsd0SUQ+DB8muaN9?=
 =?us-ascii?Q?b/I5w9TS5wAvemszBCsSNaR10F+EqWx/B5xWNEcDDusJKYu8386IhLcc9rUe?=
 =?us-ascii?Q?LCK5oYdKBb5/88hzzJwpDrGjA+Qe9rNBZrZYyT7053+kHWZ0eooKR4z8uMRn?=
 =?us-ascii?Q?mLMZIqKY+YjpoCOkYuBsbxKzvMhlBSA5VyNry8Zt0hX73dg9BQHIRX3+Mr3G?=
 =?us-ascii?Q?MA/QXM+Pgm07lRRgBo7GGsYhYtCM1VMPbmsxw6tuOPceXOvkZXe2kf4lPXCV?=
 =?us-ascii?Q?7ry1pXmzI5JQdeK8/U+w9iQjJSnf6yzvy7hRXALpdK53ZYE8jB7eryrU4hsp?=
 =?us-ascii?Q?kmEiXF2gZyCJSBOomNEyCCm8GZMIX/kr92VZ0Hb/9dqvDWzex+m/H/DovYy9?=
 =?us-ascii?Q?HJGLiP3wP/IknuTdUGcW5Zrx1T0VYPrAMrvkgAd0kC4vknKelZbv6nbAACQB?=
 =?us-ascii?Q?5iAzwpa1WZVoFFPSpXAbcCeMeda68UgNXQwoiN0ZHAGJQUEcnz6RhoZ9EqoZ?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <678DC378508E1641A91539032451AF13@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y9Mfqexly7Ue+88rmY82gBpWvDoVAhQmN/T+ewyLVj5uF/Qfk/hYsdSXdh8B3AJ4r0nxFAgfm6MtBmUQ4r2xyFYQipu26WTmEiBzAWLwKVxc5SXxkfNn+cj8LBcqY7PpNZg4ygNgpPKS/5D1CxbGBBnEU5HzqlOMQ8EVe2CT5T4UOpPZuWFRm5feG29Fgx6UUqnyCjNetgKwqPH1sLE8utuGhP1Y6JerkfnL0aHgKRSCoFv48K8+xawKgNZgpkqc5a1ao/4Rb0T11wcyodHXFAtIQbIm4i9AcPkqnKYJYzWNA0lnBRBQ8VSdqOh4CBwBWZ932h1qxj9TjAAvfkBIkWFd3W8t5/VYgTWd1H9tydqvrnk7AZpLs7K8BDIzzfDen1cEwab1AlxW44WrvGIIvXGLt/ueNv+OxhfQoISSY7ldOXLdFFdunkPtnFhTE6vysJVUqMq37xXXqFgSHiyKE/MSuQMmk61Ut/VG9QaGNQq+ftCCNwe0HmGOuM9b93/8W+7yFPAjZihZ7WLHpxSwg6+uKh84vX8rD2m4+0vcMlJKY5l2MolOWC5KLScfKdcv2jSrK3+mnegUO7Y2BaXUnk9glqYFPhCIpqU8jkzwUG4zdR28qSH8/0ddotTUCVvF+IAXVvy7wQl8ghVP2Hat60HzNiqyoRX2YCusfYZ/+K5FWfK2Oq0IQhGnTRCaQWdg+5vIYULwkDzofkbDIvsmbasLdhvB3w1LT4Jt2S0vjYmJyy/kAiM4cZVbkWVgkiayH1IWi1kPHTDKjD25MoqQORWDrJTaNGJOAEKcBrSK4+MZFTwPqNjGR8xVPiIvq0/K0D6WgE/4AodvgKj3aInGfkWhXQXCNlRa7mCilmTbZ3A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f13aa1-d00e-4945-0bf7-08db9f2bd4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 14:11:20.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qWnqozSXMr8n9AJdTNdHkFVAv5YpighBw8CSx/9ndbyCkjZyCdzI4VzUz9f+S0qtYhhafy8fGhWv8twSfwcYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_08,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=846 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170127
X-Proofpoint-ORIG-GUID: _UJK1b-3fUDvhz5Oir539R6xzZ7QBIqM
X-Proofpoint-GUID: _UJK1b-3fUDvhz5Oir539R6xzZ7QBIqM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421=
:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.5-4

for you to fetch changes up to c96e2a695e00bca5487824d84b85aab6aa2c1891:

  sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg (2023-08-14 15=
:02:25 -0400)

----------------------------------------------------------------
nfsd-6.5 fixes:
- Fix new MSG_SPLICE_PAGES support in server's TCP sendmsg helper

----------------------------------------------------------------
Jeff Layton (1):
      sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg

 net/sunrpc/svcsock.c | 3 +++
 1 file changed, 3 insertions(+)

--
Chuck Lever


