Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517DA787901
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbjHXT7I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbjHXT6m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 15:58:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F071FC7;
        Thu, 24 Aug 2023 12:58:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEfAC018720;
        Thu, 24 Aug 2023 19:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6ihcqYSkWiw/T5wLYdFgs+3G1fPN2h/mNDCbAY6KMh4=;
 b=Nc91rSP2JI9Mas8tnKcgXbj/GdzDUptDB7O10Ll9fCzRoksr+n22M80xH7SrvYKJJmP/
 Cjrp2DKnxCOeYsM/HTd21UtwK50s3lEHxsQ/pnLg472Eyib6XM5Nx2DIOl5rvFT7JYH/
 tRe7QWdLmjJnVqkrDr4OsswWsuqHIHGL/1Kzahi88zZG5K62/L1kqFG2dIm+82pDxzDk
 JTvwc6mmEzJNEoOV1Uv9d/e1y3ng4ZQOjEIvbU+EhtHiRvqakfgyCXWlFghFaWSBHBwr
 QGxz6YS3zRYNcYBN8J4xjaxeesUQeZ+xpmfTqWk4YhY22T6pfWGO5/X2/leQR8Uh30pS yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvw25v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 19:58:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJ67TR033179;
        Thu, 24 Aug 2023 19:58:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywxcgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 19:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRdSSJ1EA+jiEqNyOkEMOvup5G7j5Ex146ZSFz9w1tbdRzqiEaV8e5pHNNMoJYnCTLw26Q4UDFPgUB4Q+arZNPWJlKurq7lhFdCgtqemuJ+06sJShCmLwq/thmLA2so3bianDYIdksb0oAuUJhIT3fsUHy6xXq8wfK0AyT7vinPfHd36+oj5nDNt6keW39LA+FxljBG/pAhKIWDp7BkB0tPpjP9D3JmKqi89B6zobzBJpzOPiYW4KDdR0JUGbaa+sCaTBvRlLTbWD6xQm5SuyeGQ7R/pEqwbyOkp96YhjBgmZcmqgEvNbkLKItCgtQBOMwoyHFExipGmUW82iTu74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ihcqYSkWiw/T5wLYdFgs+3G1fPN2h/mNDCbAY6KMh4=;
 b=aYv4KUqTHEDQDrQbVRN2r2cREfcVvT4wPOCyS4kgsYmny7qHxv7o+ZvI1gU+KL8JvEKVoEayKUMoo71IouflE2dluSgX4EURLD2I/AMGIcRQ746w8ZRoyOTxKkYh16TKXml1T7yOXdmGa8Puix8oUzEPsfvV+dV3XjR4/Evqd+dKPzAUrk3OyPi1y5DAYdLGG4N/6iE5nukUhp5hX5M43JbkSwSS1deIAQfSuF5bMnVgHyYRKP9j22DjgqUXGeFqFzEWtwBjoMQpavLHcbfCTCTliWtQO0P7TKHHrQeYQRwv3fOtbwjpQ9HtSw+dIGEUDinGHMD4s9QaKBg5yxBtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ihcqYSkWiw/T5wLYdFgs+3G1fPN2h/mNDCbAY6KMh4=;
 b=X1jdFiClQ7VN/RvDX4LrNDDVOcbxpVNsa3rNYJN3Iauwur8Pi3YyQ/grwtfKs35xKGgeskNKKzxuTsLcQXpTNfda3BtJbnOzywS7fH6w0ZXaTJQnaIL6OojLzV3euJj7hSU5pLbinyIy89TKGfqT7NAqYjTOmDUQaX3I3V+ZKuQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7698.namprd10.prod.outlook.com (2603:10b6:806:38f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 19:58:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 19:58:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] late nfsd fixes for 6.5-rc
Thread-Topic: [GIT PULL] late nfsd fixes for 6.5-rc
Thread-Index: AQHZ1sVWiIyGY8WHw0+con3r9rs4Kg==
Date:   Thu, 24 Aug 2023 19:58:23 +0000
Message-ID: <DCE0F098-3F69-4C3A-A74B-34F4E6AF0AA5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7698:EE_
x-ms-office365-filtering-correlation-id: 7c7f1f0b-2349-4a03-5758-08dba4dc797e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zntM2Nqvr50cwvHld5LCKkoy5vA1FztrhfsH5RwCBE2JNShzduoQdQ9e7LecD/Jxo9No+QWRTa8WytgqPZlVjkYY0pT6F70HshVesxaCewvbonG7Gm/lQM2DNwPDYWrwv9Fj1TmyUoqVnsEpIW/cHXyawtmWPQqxpU6CLd7KjKke2qXeZbs7t3lkuXJBxH6T17mdE22QDgsCPg4uPEN0wGBVb6OU0ckZzne8nE6e8bozUxcg6p8+muVTE8CpVLWcflS7SaJf5ml5/OIYh+ZolIg9EIRthI6ObHZV/mst0TQ7nZjWg/Fp7PpzM+q8TSeigxpZ/cTIkx72aWD8EkV0BOp/EYYgjTdRqIS2prNHIKn5YOJ5oj20i3rq93HcjO8ngzJfTfwNb3fZ7vMPnGYfDFKZY20dYY+rCj0cIJh/LB/A5DDJPi6OcJ0B6sFPcnvbu0raa8lPLz0ntdFNVG9sPHbNgwoLEGAmIadmTthy09O0ESNUMakSanlSjEm487JaYSqs+UGyPTS5akoJEvjPq/DkM1Rv0NuRO6yk3KI0Io1OwZwkai7p45Ea7QnXubJqZw+HY6KWHQ7RvaSjpEWDy/ptsz/ZlTILPBNv4fKYXPDJBa9+zEDCcDlN6Rh/ARtyc1Cor6J/Waoxn0q7Y0OP/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(33656002)(26005)(71200400001)(38100700002)(38070700005)(122000001)(76116006)(66556008)(66946007)(66476007)(66446008)(64756008)(54906003)(6916009)(316002)(91956017)(478600001)(966005)(41300700001)(6512007)(6506007)(2906002)(86362001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3EkvWvtBhLt7pteuJKzoG+lLP/I6aDz5addWejyyRBIZ4mI126TvGxPIBz/s?=
 =?us-ascii?Q?7ElwVXvUaDkNC3KDVLsXispklubgSlT/Ue28ouDzMMcmZo0/W3cdFrUQHwP4?=
 =?us-ascii?Q?8/13Q7jhZmS3Ow56/K5eWkqH/3au9TOByTAy2fdMEuHsqdC2wvD8cV4a9zF8?=
 =?us-ascii?Q?cIBrXCKoZOaSw3r/P0TzQ2kTeIvI6rxIUS20P5FEU0Cr1YE8ySqEzamkWe1a?=
 =?us-ascii?Q?wB1PjCjxAGGefEpwyTfUNAb2toCs1aEDaJHZVv7wE1F3LbQbBfLq2wQExtv3?=
 =?us-ascii?Q?phYFKk3bZd7HAoELJlUUtMFY6HPioC+FgzDEpR7o9WFOr373EGHy3k0b4I63?=
 =?us-ascii?Q?4YDri22zfAER8rhFRrnMm+WkflGYJyw0+htfur16lxCbzqOZyq7dmHL2aC0t?=
 =?us-ascii?Q?dBOvKYtTds1/y8w/Yw2/aRn02UotkBX3fIqbI3juqvEzdTc9gwuOSi+22STL?=
 =?us-ascii?Q?uCM7DFA8mYRzvjFdmLwPv2UwZCp2LmBtJkn2Z4wBQW+BFNlI/kk7Wf8UPOSQ?=
 =?us-ascii?Q?hQX1nQHQ8jfNLraJ7z1Y+EkRaTtxIFfR92gCsZpb2JLPNOI3oJEBsjyGdBZz?=
 =?us-ascii?Q?67y23o82+TTyAjbbAJ8ep9c88JfFVUSOsfp5uYeg49MamIYoirsxjvgwCAZu?=
 =?us-ascii?Q?lB/Wt0uXhYpkSfqQdpASOxxnq1/xDf/C9x9/OtbJnchckzRDGQZju9ISsPV8?=
 =?us-ascii?Q?kC9wVC2LkyAxZgACbBWZiUMyLMsZ5lCngbDC/mxQgew+DC2Oz2dCE4pplbHX?=
 =?us-ascii?Q?SL4OiSQdvdq1lkwEuFofaAJlQIRH/N5KL1vOpCQOJv8pq+L7/8scrJqOjsT0?=
 =?us-ascii?Q?Ghu7aRP7MIbyxYP5mpSEfTN2oMKCSK+QXoxKWoond6qcSYFEc4x1OJARxsuv?=
 =?us-ascii?Q?XD99iZJSVQkHF2Rv3csuXhAcwMNS1j6YwqaA0KBMyA6FyoV9YJNWyRcpCOqt?=
 =?us-ascii?Q?sP9KJ3Xg2IRdNqy2kEAVNY31H9AAmJ2IGWPizrdUAZA+Nq4SSg4JY/AqDk3i?=
 =?us-ascii?Q?WRBUY7o5WUNSOZwdVDTg/WOxJQRUqgq7W8JnKD9SriW8M/WYyEzZu8/iN1YL?=
 =?us-ascii?Q?jjjNf50wlN5GOu8YDfatrnT7L7H7zAufGkRiDhC6e0Zg7QoE3o+xJ+RPbe5r?=
 =?us-ascii?Q?K/YrKanVlBcg4jbtIOl95pdC7PIzbEjRsK1GDs0OLqTkefRlanAs1GJm4PTa?=
 =?us-ascii?Q?PXHzo2vQt+f9PzNYzS4G4ZIOJjH/klDL6PJ/Y/L4lrsJZzzTmGj4gydvOxIK?=
 =?us-ascii?Q?jdBBUzq8la0e44qrclGs0eNAsCBB5nE9COqlh3E14EvXL1xVmkI3NEBzCY/u?=
 =?us-ascii?Q?hP5t6trk0v1gJXA1Re5/WOlq9DNC5aYOOnZkNrasOTfDVpPIdtVaJJqwgI6i?=
 =?us-ascii?Q?7UuJMekdAkyesOqm/ckbmDMTblFW0gIhrSyUOWKST4m8Bno8268BT4Ufn0ea?=
 =?us-ascii?Q?j7NPQtY38oIpQtGW3R+FeSZeFrEI4SdA0A3AseIydyT3pehmg5zA/9tUWmbu?=
 =?us-ascii?Q?L+y9A7tuwbog81dSIKewtTUbobaCdLy8bf5zzGKaJm57k9qhxxueWHJVcKsb?=
 =?us-ascii?Q?LNudTSsYRUd12jnlRzlkMOQAAN4ZG7o0DRYEHMJ1D5L/wCPwo24oE8yGUJP8?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DFAF4283CDF624A88E56A9281FD24EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g7TjFOG8mjC9nPcEkD55BJY0Ix4NffaKVsQ+L5h75cjuwdrKpB2QPds1c7yliktZTk5KmpubkTZiGfuZr2G6hEYXgo2pVp1ravtBwhm8otbcP0nwa1E6Z3jzq8//ikJU0YWx/8QZG9ty2SfjtQcD1XqFqQ8+0x+g6RukA/BVY9zw+ACqPf5ZYGPo465+PgIUggLuVKGoRvyQBzsDWdEVwoOMuFaShQ5ZjUdjeBWGa6Na4P1HqOn4wVJ6TkAPil1YANAEjytYanXqeq2WbSTl2sFn1TzKwLc22eiOTs/iNNCONbOkB2kxcEAxJ3ergsRhd2LKYNJAGZODNp7BoVHzcqBcFIdLZMg9iptydiwBOBDbzxRP+r2apWf1pfmqtYeuCTw9I/utZH4vQvc++Uw1csnjAFSB7AZb+g+prNuJBWQWisdwStdL/Qja5mic6nyNjcHN4vfz6sSzDVEtZ8Kmg+sb8dDybg30WgDvuTAcVIIkhgXUIS4N4OOWBRui1Q/BW/cxypbar+5Bwe3hbLdgdCoWbJ7/7dE7/akV4YPuyNyIP2qzDDPzfQYepybDnrlyAy5sMXjp6NehA5x2dcC/c8W9EpBhNZw/1dKcmV4Ty6sWjy0rBlgK2Abv4xU+qa0iBv1OCoG/4fSANjIJ4nyW1JdfCtnw/GBZLcogn5mxK0CMuurafWQQj/3RxesSmLKAN3DpyKWcHtYOcPYUbZI0Xj5M2y0xXtw3HUdgfq+YTAbI1gyHguLlB2/6eLQHrLKaU9sTdtmq9Qax3SuRNASY8lOXZVMz5KP3oEzAwCKuh2onCqS5yRuNgUNchNpIffo7SIWNLYP5HuzvMZ8iOU1Oxyz8Y9Zf2zNqxhbTnIS2kOg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7f1f0b-2349-4a03-5758-08dba4dc797e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 19:58:24.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmlmMUcMRaGb5HA3CCiZB7Zuhc4duQZKww2zL3qBHlJuVqaTZ7lGposD+bH24/V2w4qBMdl3rXb9f9nZ8e0yhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_16,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=743 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240172
X-Proofpoint-GUID: 0r5EiFyyCv88Q0xaTpUvGWUvLFbkz7mh
X-Proofpoint-ORIG-GUID: 0r5EiFyyCv88Q0xaTpUvGWUvLFbkz7mh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

Two last-minute one-liners for v6.5-rc. One got lost in the shuffle,
and the other was reported just this morning.

I have not waited for a cycle in linux-next since we are so near to
the close of v6.5. But these seem pretty low-risk.

-----

The following changes since commit 101df45e7ec36f470559c8fdab8e272cb991ef42=
:

  nfsd: Fix reading via splice (2023-07-30 18:07:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.5-5

for you to fetch changes up to 8073a98e95323abdea5491533bf5cb51e0ba18d9:

  NFSD: Fix a thinko introduced by recent trace point changes (2023-08-24 1=
0:56:28 -0400)

----------------------------------------------------------------
nfsd-6.5 fixes:
- Close race window when handling FREE_STATEID operations
- Fix regression in /proc/fs/nfsd/v4_end_grace introduced in v6.5-rc

----------------------------------------------------------------
Benjamin Coddington (1):
      nfsd: Fix race to FREE_STATEID and cl_revoked

Chuck Lever (1):
      NFSD: Fix a thinko introduced by recent trace point changes

 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/nfsctl.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--
Chuck Lever


