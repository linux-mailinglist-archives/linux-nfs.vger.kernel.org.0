Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3E6B4595
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Mar 2023 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjCJOfD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Mar 2023 09:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjCJOfC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Mar 2023 09:35:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31CED6B9;
        Fri, 10 Mar 2023 06:34:58 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAq96o014046;
        Fri, 10 Mar 2023 14:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WVfgytBq+utMYvIF+OulEkK1koSRHd76scIyga8sFJ8=;
 b=fAyCFc7Bche4YC6WxCVNxKMPPquMP4xkBRD7eGzn3ZFX2RLArIv4NsC1HPTCAqAHO6Xe
 kvq3JiV3K0P876ASh6YKW1v9lSNAVun+bjMtjQURc8XW2wiykQaG1hN1dxGKtqTJ+rn0
 jPeVOxtxNOVkVqdT4f3as+RI1/Qy5usmJ1yMcgDinBq21uRg+A7QBR9gJHwTadwP/e5A
 nmiy9MZvBErzaOFAS5foOfPfqKkkqQzdD5WPj8W6Ob2elXQifQH98fvJqu9hc7GgKe3z
 r3fRg+SMKFLd/92kgp1NkqkGzJg5re2LVGw3jmAZnbyY2TIpvO6R1e002ItTaBL6tvEj oQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y5e16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:34:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ADZDwC015603;
        Fri, 10 Mar 2023 14:34:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6feq9bw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkTOjTFtjF2WNORD9FzcaU4FXTW0BuMuXQYleiXIKLehZBPV59GxKTRBILrDGWaePqwKZBY7wNUseNr1w5kUuQNH5c+ez0bR61pKBsaJA0sUycYVdE5I+3H3Jg9pBTKxDskQqI4jDPHet05PRh+1JVbUTlyifSIeoeSTD3fcGS5NHoE7qfZAqcUrWjC70yu2ujrLBCU9oUX0D10KHAzZjdZXNcTzXh54h3yGYxRS8TRErX16uwW3pU+Y0JbOeqvF6o/oYWanYT5QfuazvxfF4sqEWE7p6HXbzfkH5ekM2RsaLC8PjFkks+/dnVE8tD7RqY29NQ5PIqv9fHjQiOtT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVfgytBq+utMYvIF+OulEkK1koSRHd76scIyga8sFJ8=;
 b=Sj8h7qFTDtk7zoRHtuOyViTwso4K251N3VVfkmI0wNwoznmtbNRb4CMgnVVYFlP0l1ebQfYu/woBUEJUvsB/UL/LpkrVsPclWKOyLbB7DkkkVRrC/FVFs7ij6QVN/AouaEgn6hykqgZjAW0hfGiwucJnS1tOYtZY8Ofx8Hqr6sA5mZkR/mp9Lebk+/DlMSOrfXYvZmssNMOXo2j/7R18nenHfOo12p7d712Ail81jBwqhvxTc0AIqCUIpmWxZ+M0eONsM4lzO9QCkWZhIyjkK6yEnJD9AA1ki8tSHX+6UvQ+nOsvRXp0jp6iiIjrd9uaZlqg3+PGBDrooAhpLhvNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVfgytBq+utMYvIF+OulEkK1koSRHd76scIyga8sFJ8=;
 b=Zu2I+cR+yYtaEh7W6uEapFHwktCc1x5rWjtiTqFlzJwLOTCIzGgZUfs8NXtHunOC3kBOdDXrFAIqfoTnjsihSoBcvl1lMnyrL1NQsneGLTTZGyraZxjo0oGEF+yd40K9nZXXLYmwriioVp7Mcx4af2YZ8SASsjyDwrX/qSgy9YY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 14:34:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 14:34:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for 6.3-rc1
Thread-Topic: [GIT PULL] nfsd fixes for 6.3-rc1
Thread-Index: AQHZU115MGhDgQotVkCqMMjKMLDP8Q==
Date:   Fri, 10 Mar 2023 14:34:51 +0000
Message-ID: <70CF2D89-B9AD-46B9-8B2F-8164655297E0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7057:EE_
x-ms-office365-filtering-correlation-id: a8a27e51-054a-4309-2114-08db21749bf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJYt9cbLwgvIYFDyur3qdvppxlqEqNkoZOAzcYCSAFMFYs2c7jD+ycDPhOi6ZWZ6Pnv885rD1qmqyx4cHlsyRj1GPTmXicdceixlmoy0afPZC+UIcqbuJEaSP+gXk1ddubWppILqShUY8Pw+BylL/ym20vohU3kv4ZzPY6TTGF0oGOKptPrSfNTDElt2PGYZgTuFlC1BRkFXmAALo1AU2vGI/SL2UYpZ8oClHFomb9dpTAS4LIa08aSq/6G2OkywChx8yAZAbkVBdkVevgw9WCHEMHVWwtdznSbb8pW6VGt5xcaXXe1Zu7tv97p9XPPtAUEd1mfYuhxqsVt2QRyFjR1L2wZmBwWq6nWAuXB8FWXJwSqxSnIYFN+UhWzCUq7Z5FRW6G6ulV8+g4sIgrrrSzfvn6rplL3loOr8VM1uDoEtAlkv4GNBHa3kZcQr44pgWY6u2IQ4OI4IpVc5AFHYXMQzuvy9ded7uXHgxT0WX7sXImZ4HZ2PX/5iQ7O5U9m3Zmd8B7TRvHyNuTpWLZHu2SsHqtlNUNCsOc6IV+XRTTc6nn8QWNyocVUETkqWehoP1JRORyjprZFzbJqLOotN8E+SEJ1ithvbUMJFR1np94EU98FnhTytOegBD/bD7RLdDKRfDH7bmlCyEybUXvRFsCfvdrueihGKpFNrRvgSPzyIOLf33VwjXS8XBDAgvjoTuuSc5QRO57gdbr4RZzg2EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(8936002)(2906002)(4744005)(5660300002)(41300700001)(8676002)(91956017)(66476007)(66946007)(66446008)(66556008)(6916009)(64756008)(4326008)(83380400001)(71200400001)(6486002)(86362001)(966005)(478600001)(33656002)(316002)(6506007)(76116006)(54906003)(6512007)(122000001)(2616005)(38070700005)(36756003)(26005)(186003)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mtQgzDJvVMiHvARQq4OXQMT+ViFNglrOauXhNzMRsVzUFBjuWUQ9UVNAm48c?=
 =?us-ascii?Q?TDBAvNVqmu7LLUAc/gaJiaMDNggLTs6LnEymv7+mGCrMVK4Te6pPUP45w/8T?=
 =?us-ascii?Q?yLKhG9x7IvzGBaJ4fmH2iSDClNlXEZX+HT8FC8+Z1Qh3OndDAbV6d8tnQ37D?=
 =?us-ascii?Q?K6wklcwkA+n+omDZ+9FEgpJL03EvlFMEEU9roVH24ZCr4jxK50oLXyD+o8zD?=
 =?us-ascii?Q?oC0TZAiNJA/eXcN3+gKdClf9mKF6G7RdAL12MoXdkdD1v3qpZwz30HffgBCr?=
 =?us-ascii?Q?lZu0Rg0TxUNMAI/IbDU9HzJR3MruAhmgbCBNhkUrAfpzlT+Ht0uKXVdu96mK?=
 =?us-ascii?Q?Z3kLMukIgGgGhFP6gGNdcl6Twn5/3u2sZGq/17xAITrwIWIqHpGSkQqlF7ey?=
 =?us-ascii?Q?1B/LHG3WKevU9Z3We0ZOXj29joGD2sxAzfv2YahrcMxRvg/QPLJL1N+zlLsx?=
 =?us-ascii?Q?nvzol2bBmpEhGeAA0T+2EbVN6omYbRUNIxsfN+3vM9eTENWgkugXY/Tvcqsx?=
 =?us-ascii?Q?eZK7E7rUFt44lJNFpCElfQnlownXRYtlQJvU3HcPwJ0eeQnIOJr+/CH5WE/Y?=
 =?us-ascii?Q?LoIjozB3Q0oZzlo0+q2SljbfKKW9CfwfVT6G++41f0385+wYFq3Pon1foP4t?=
 =?us-ascii?Q?39HIc4HQrUtAI93q1V0JhB4ND4F1m2gncXF2LGy5L/46ssFMmu7y5F6ap5Xd?=
 =?us-ascii?Q?J7u4nQj05PifZDn0udrb2NL8uAYIptu3Q/wd7rQg3BigrThDpgOqidFXtTu4?=
 =?us-ascii?Q?uja2mpUzH05TajZViIVmbtP8a9LBTs+0qgxfa1ckO0zXaYnodvUl5+5zVw2F?=
 =?us-ascii?Q?Z1QEOUg8sLwL5sGRnG45F/wNCwGdqlZNNlkhHu4HbznBftM2w8WY4NAtZ76w?=
 =?us-ascii?Q?WGwUXVTrBARyObi0DskkuKm177zyHxRB1xG3kHBY8B1K/qtMZorGNxMwvhD8?=
 =?us-ascii?Q?os+qrxni59wtmcVvP0/uBr3w4CJ1Q2+YclKb5vxy4gBHzMY1Vrmu1ohC1/HX?=
 =?us-ascii?Q?TtiWcr2Yb1TTQZZ2Me3wNGxiN/onJRBnfEslrNitASHbDnU7KlZguWcxoOqd?=
 =?us-ascii?Q?rWrBErX/GFpZCsx7C9K8Ks3RpVq4ntcTKhaZYs9Yipi93xEGNLo8WLRyDkJ1?=
 =?us-ascii?Q?dt/VughdI9p5LzJHhw7QLlKWH6okRmeRbbH/vhXRxgd14i/FSX98wEs7lb26?=
 =?us-ascii?Q?9qaOTu7k7V4nHckvR9Uhpn/RbUsmG1mwZon44KVTwZPaTVHLt5yB5dN+sop0?=
 =?us-ascii?Q?/MENj5TCQDHBrqqinGsjrS6NjFNXLh8DCWyNuFEqAjAxkPenSvR7PHEUh1mg?=
 =?us-ascii?Q?e+uVcW/pXRYqurjMQdoWDtpTWmDxiwEqLeLyHc1dzZ3OpAeO1iWtacHYhb9+?=
 =?us-ascii?Q?r7AtBif5iMIrbmn/IsgUiu4Udfg316j4snr5UopZYZlWh2DrUXbogrxYrEyU?=
 =?us-ascii?Q?cxPH5O75nqRCeUUPf5aEU03p1CSXWs3f1iTCVSfKp/AdVJu/O5EjbgtwfehQ?=
 =?us-ascii?Q?c/b5ytyJqNPUT5xR3LF7S+afXgcBA7alvkS5jiFbOlazwyJKrEZHaBNj59E0?=
 =?us-ascii?Q?5Jdh++nKC8sf95UyQmc2B5i2Y8rlqeERHOjuwk8I6I2j6vrOvp5yHr5SLNFU?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1BBE32E9CF363428AF683EEEBA1C27F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dYLq9r/BVYh6BtgJjPJSyQbCgQLH5Y5+3LHkpnDyj9oyJFaLi9SKuYJk4gu8qkEAyeAitHvJnAxmE0ELOyAwjzlZKbIz+cZWJrZBA/zOZvy1y5c4vTQC3RIv2JH5EM8fz3DeQcYO7CyAZPrYnRIUj7+chovKxUXkc7s4frIB0Nl7MVlVSrovHOxZdc5rGoS2mPXMzvBHsc7erNZ05qbRlZ7tAZ+AFXNQjfLEQpnUv33rpgT3jzEaVNhLfSIRUP4mhB65gGJZhkC21Qaw+fJ0pBZFMrz6Fnu7RSvSQL/UA2kmJhISP9fTFzZMdcH5LCAmJh0MOYBibEeJyuNqOYfdcwCnaZx6v9ZIfqfBhgyURsfHt+5KYYYMZCOWlYnf77YPLPR8FkGELx2fKe2P7ST2SVR0K+PRvTA1UEEXyM2s2hoMwpUJR6rIMWWD1kOEpy2x7SANZFYqPEnkeDOWg1mUMfTvyPjRPT6O4Au29gfFV/Ffr63I0B4h2uJjbP7ofWQTSh6lO6wwHmBRYdp9ut3NjO/S4+OipRtLVC06rXNyaLpEBx4/ljALNRYPuQRlmsVixNfC+WWWU72GostpokFO2Gigb6JdJaOJ3/kwyRH9zP61OC3+vWBuAtJxFcjQKojdmAMuibIkHQJm86003guKsjtMF7ohTrQpUurJ9Q/wnoGlUhrJt1/vCYPLMLtlGR3bZbFqEmdhv8ElNaimRacaXAeojCHjNcCGVwOJchVdkwJJeb2nttguCu+UlK5Fp05VqfyDOs+O8uADp7JL7yxrIkijqSm3DYhKPtsRY5FAofpoNYk2s/BrSc3CeIbqE2ng3YS51PLXe7nOA2sViP7kUdT3HSRnKvXjQXlfGytrD6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a27e51-054a-4309-2114-08db21749bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 14:34:51.9110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fH6bOCKfzYQ7Yape5d4cKNrU8u6Bwm1yWXeiKHrPeSid3xXBbSDanb0zCFNm/q1ma3J2mqU0rK4UQ1XU0v9HBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100118
X-Proofpoint-GUID: ELc7sU3kOpW2S4LeYCw3EK6RL6t5hdSP
X-Proofpoint-ORIG-GUID: ELc7sU3kOpW2S4LeYCw3EK6RL6t5hdSP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit fb5b855d9f34927579baa0a20b4d0d8ea3740abd=
:

  SUNRPC: Properly terminate test case arrays (2023-02-27 16:27:51 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.3-2

for you to fetch changes up to 9ca6705d9d609441d34f8b853e1e4a6369b3b171:

  SUNRPC: Fix a server shutdown leak (2023-03-08 08:46:41 -0500)

----------------------------------------------------------------
nfsd-6.3 fixes:
- Protect NFSD writes against filesystem freezing
- Fix a potential memory leak during server shutdown

----------------------------------------------------------------
Benjamin Coddington (1):
      SUNRPC: Fix a server shutdown leak

Chuck Lever (1):
      NFSD: Protect against filesystem freezing

 fs/nfsd/vfs.c    | 2 ++
 net/sunrpc/svc.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--
Chuck Lever


