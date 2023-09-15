Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D77A233B
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjIOQGI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjIOQFk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 12:05:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687AD10FA;
        Fri, 15 Sep 2023 09:05:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFhq5W002147;
        Fri, 15 Sep 2023 16:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iO4o734xVuqubCD+2FulJLTJHYoRdEPYj5wnRwU0hGc=;
 b=28w13eAoRxZNf1sLWgLmQsggpJUR0LC3U9Q82j+Ybt7rkoIw0ZA6nML6Ppzr7usKhnxE
 ThtqX5AjaZFufLkB713XMJdgg6p5iPKUn6W+AjPrzu+mqeis1KcyXInISs3DY91FI+x6
 5xvSR0GbcdUdNZC9cyWkkfsZMgXYOsf6Zvy4PnfAB0VT5pCvwCLndXZkuQu5WLQqbH3/
 IVNnYbAAZaCdcUA62T6IpDuOUjrNpwCLFnSVdLKfrAU55OpJw3M3PivSoYoHo3Zstkbe
 zhk+T01D2e+NYBxT/5teQ/wAt5rBny8X9BX8Qyjapy+p/UkFJVgyExaq12Fh1+N5atjj xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t37jr7bxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 16:05:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FFKV9d008866;
        Fri, 15 Sep 2023 16:05:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5ah8ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 16:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDDcFcDfvaOzJWt93m4F0t/ZO6CLKSn+MFrCYs3wapgEncMXHn+WuIYiY7UpureOWcoB783uUVz1j8hSz/EnsMDiH6E78sltH7yycCfjn2LAR/xam5oXC375p0sKzEnKEl58TiBZ4ClCoAdb0H5PPi7fBrqlXj+eZKq+4gr40fPBR122qPfpOmzSo0uvuL5841anel8kFDhLQA8z0wgccLWyUF2VDSDZ3qlzYqC+xVszbc3pwS118xSVUZllSK10xRqag2pDuoUG/JFJuNW1CcrdPd7wdfwbvpFqOFV3jhpTIZN8PW4EXwVHLmQ8KQWSklOzrxzq1Fnk5oALq4ke8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO4o734xVuqubCD+2FulJLTJHYoRdEPYj5wnRwU0hGc=;
 b=RWNAHZGpP7IeqyHthOi/y9fIhXaknR7hkQsdFahwqxApHIGn6gfYntuz98W575xnIWI9BXttMWDovT2W53pu3Z9OlrgwzUKaYMRSRDVaVaeYufiDhyVJVMMU5rxztP6EYmewy8XmwfGOFRZiZ/vE2ibuQxgW7cHEtRwJ7fU+gxUF6bRCgesb7zPfOFQBrh7Vh2W6IFlKIwHrYWnalJ7T0jEZ+9De5c7pV5ovpDheIV8WfENCbhXxqJsuSOxP4B0eKPVqAb3h7E1RQyxu3LFb+U0yblEs+GmrS3tEPUgu2yzgpmBQ44srtJ9k0Y4CJztPlf/8kHHaXq9hqT0FZci/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO4o734xVuqubCD+2FulJLTJHYoRdEPYj5wnRwU0hGc=;
 b=NXlUY0Wr8FGXoRBxP61jPMrVtPeFoN2UQdQFmJUT3RhyfBF/YLyw6smIono6o12sshejTRGyPmUsG+4/ihTalq4FOIXNL2X4fN0wfznOEp/QgsxqMOX40z1HqQyH2jH67OeejjHN8+853PW6VBURTbmSBa5VUWOg+HJyw0DQpkE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:05:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:05:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] first round of v6.6 fixes for nfsd
Thread-Topic: [GIT PULL] first round of v6.6 fixes for nfsd
Thread-Index: AQHZ5+5qoC3+fWCcek6lD8h3Y3gyTw==
Date:   Fri, 15 Sep 2023 16:05:16 +0000
Message-ID: <63D87D8F-8513-4B12-BA9B-752BD5C7D4FD@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5083:EE_
x-ms-office365-filtering-correlation-id: 7fc0771c-2640-4072-9345-08dbb6058d4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2CzLXrBpXT0yQaXRB2C7IF0E0yEwBUJVO39HlNGBmLsAPj4WKLC0I5k2AahltnUXbN3CZtrNZA6XwBXrPNzeKo3o3sSnKZk9y6F/+bB1NzLBKZy8xOzHwoeovHyhsgvI6B/WqK6LQLkVmr+ZUe6kXEHosXP+p13WW+vXcaTdAUHBbkJ67u7S510dKzz5k0RQ08xFNIJcmZ/Lg1HOWsJqwzRe0Ngb30G18twoF9GzIfFNtN0CvNcqG4CE0q2JDVer1fabjhvuUqKdhIsd7UM2YUB9ZW/pkS/vPHCQJBwNH/S7+z+Rfb3Sx0d1CPO6NDgsoIc7R103z7IAB2i5pzMdxXgvS6Ym1tPAu8/r2T8zfVDL3xesxP+xy3Adk12rhSTl+NhC0uJO/TNEVeTJXpv2kGJ5sS+kUAXfc5BVPQriCUBkm1/g9dHIhB2hGnUZzP6B808Cv6IDmJjETDTGoR1ZvPQG56FDdIJT62RL/P+jAKBOWR7pGbE7ev6+8Pcwp9ZArCsF9PxtCODxr6hWYIGHAX0AV5vFIzwqp1Kqwz+F8/nE6tjMGlZD1t9GMpYEBkW+76is19N6VPie0CODESqC0buIK/SdvrvgCk5Hck9tb9yuq9YxTbvua3+qXICHg9Qrug9/OH0GzQaFM4L3Icadw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(6506007)(6486002)(71200400001)(36756003)(122000001)(86362001)(26005)(66946007)(6512007)(2906002)(76116006)(66556008)(91956017)(83380400001)(38100700002)(38070700005)(33656002)(966005)(478600001)(4744005)(2616005)(5660300002)(54906003)(66476007)(64756008)(66446008)(6916009)(4326008)(316002)(8936002)(8676002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y91p34UPjhRBOt1aLgVZfWsjvJ6+aLEGpyZUt+XC7oCYqsxyfuHJIEyxfeSU?=
 =?us-ascii?Q?CQJplg9l+c8fLUHIP8bHaBhDBWaaB578t8gsE60FV922k0Eh2lAgq8mwFAr0?=
 =?us-ascii?Q?Z8GGy8KpF/nHW09pTKnCgzIt3m40EsVVaBH5ldSauLqba0qeQasjSuhqZEXq?=
 =?us-ascii?Q?779uXziEIQGBvFeqFSzyAgxqlupgQFzfAhtmpSftCDXFGYLw1uIUK6chy9I3?=
 =?us-ascii?Q?YXaYFDqzZH+cH4URwhiJi7ExOwut+3vUyH38FVogJQDNpyekmYyuvj43ZUSb?=
 =?us-ascii?Q?xUwG12leGPE+8wcTNCI5EFcx4/nEEQ7oGbOtgAc9XAYslKGiezutjNi2uU+J?=
 =?us-ascii?Q?cLn74r7WLcqxhuVCyOGsuKnn9qhtPbkfnmL4GDlSR6dDyJpZ+59su30feFRE?=
 =?us-ascii?Q?suvbOo8W4BozXlJlqrNh1QGa004159mCUVYolY2uELecY73giJmODIjt0nnF?=
 =?us-ascii?Q?TTv2pYntJFfgqeiEafilwPOtroOEJHTH67v6lFIkK2OuE3pNjWuZ5C/GRBM4?=
 =?us-ascii?Q?XFKP6101FyH9nJGXQiPw0ZtvOabO/sXVfJUdcE4lLTYjyUBYXLy4VMsfHO/Q?=
 =?us-ascii?Q?ZXE0N1HEnkbwQSm5YynzrvhDbWnlABWHN+etQO/59pQeheVKzyYWaUG0EbQZ?=
 =?us-ascii?Q?gr7TWzMQ0tWTrjpxTHStSnkkgfnb+oUhzMRNZyA2TZiuo8wL89rNaTNQFqp9?=
 =?us-ascii?Q?0nhpe4Vk222Gw+1J9V/zNA3NsNgSbHgTXSePQ3WqzaDPbT8YVGsvCon8fksD?=
 =?us-ascii?Q?bbhhcGoA11sFyZp/O84x7nqTLIkEbSEwThSxTHWtwN6LDilDLPC7eKET7I7U?=
 =?us-ascii?Q?z5S0ckpKi+kNt1nxBSsg0jS+r/on4y0t+5WcKrrus5RkHinVgfvgq5uUdeJ2?=
 =?us-ascii?Q?LdRLfOopNx+hI+3S4TCDBs8f+Wbhwn00B1dbGpIG2UBQpkDajz+WWjTRQ8sA?=
 =?us-ascii?Q?1y0/quOxeKjVeqmq5jmpb/qd7fMZv23LSIyHEtBQwrcLMu3SXFXZ1cUfAeoS?=
 =?us-ascii?Q?+0NC7Zz94YQiVvWXalQYU6hZ5zHc3uDUHXVRURYYnl6gJYqjmXSRYW98gm4j?=
 =?us-ascii?Q?tRQbLrcIR2yb3LdAhyT5mIexp8AUunLSWSVaWDegWd8PgpOcibRBwzeqjvEI?=
 =?us-ascii?Q?CChdNiCz7hntgwOHhecBmwm4Hbc4rurmSHsBNm6qcXIGXSVziOqAlQ+sN2Lo?=
 =?us-ascii?Q?dcu3ZsxKeS4AsmGOqPeE2sdpMEhw8/ax6Q3djBPAtXliuyhvFCO+TmQ0p55V?=
 =?us-ascii?Q?5fC/b23OvJATmDnnKH6+rKBzf4HAKTwZL8rgQrUhSft6Z+TC8nRxojQvHZhy?=
 =?us-ascii?Q?fUhabN/8VOn1CZXyBTCMYBsFxn1J/ZeBhzo+CHj5/0nFTSuqHXcE8RTQyZbm?=
 =?us-ascii?Q?zX7g0czt9y7Ihkhv/3nMQh0h2I13hYYwQ/R2WLeewDuHK0qr7sEfzz2XAlus?=
 =?us-ascii?Q?korIAddbsWpWcdQodUGODZmfZN+H/FtUsbY0v1rZCZ2oWs8v5ztRVrzXWww3?=
 =?us-ascii?Q?ht2J+LnNiHMsDyHYp8rWeByxGhxcZXvq0RsvTMTZDVdRDT48LDQgPi9F9BMy?=
 =?us-ascii?Q?dfyJhedCnuG29flXaUlH3ECdwfYqtqhU9owkzMXFycHrQ3Ia9j8nova7QsR/?=
 =?us-ascii?Q?gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2C3C6BC65CE3B4BB974FDEC76E95478@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vGvtae/cl5Ai8sq4eMuTlj4Kxi1jUQlTb3ggvGx73SGF4kl02B9dnv9E5VlzyK0k9oHWhHGQe5cXS49a07AmyVxwfuQEjPcR/7GAjEaEsVc5zQPBsSmJWCHDax4uovuOuH3oew+fWXahm5cnuMPVm89L3zAgIy0thoJYzUdMLGenenfiX3qmbvxRUazYucXV1UVw/KIWtw00zbzKrfsC4MACdZSCyXbXa2Oora0Rs0+offUeitGio0nlPt3ERvyiNgrYXGP+18sVrJRSwoBUgrOC/7aBP9otDyJyU6ybYvv7KUg7GgXOsaMKghsCyCR3dpq+sAfWJTYT2ODy0bvfH5ULcAVv1epSAhKSkKYtaxlvcAXAqOA5e31GtAUSDSj3gLYjwvW03yjj5LkiOimBRMghIuoe3cuqiMZYXtjsk9znvKIz7P24NrSGWjFvSQql4HHNigFEop6kB+6F473N4NGbWHxNYxOH7gP4I+L5vjShAOJbkTiTuiJakxuhL5TYY5skcs1u4OT8V663tPKLT8NorzgooUgoNdwdQIYo40nRfWsA1kFxC4yaGIxGOtOzMeV42vl5PiG6uqx6OIaxXKrsepwnXwu/Kco5VszFxD3mkBx0AGZNy6VoxGk4edft/xgbWPvETEjhRlnn7qYuWq7JScPBeXGj6Uv8IrSDG6mqAcqoV+NjtYoMM3vnBaThZl5tDgZJ+Csz0fjCCqe2q5sFQdPfCYwIh0rHcVB4E/BV+NN/HfV87GYELzaQUSe79AgqNYy9pQxHZY1aTjYmBeLCJqhCAx9zHyQqsllVsIdBveEe+3tKtASaRUjx0ARQ5xMx5r+9qVpLXMjGYFbkvy56/zSBVPXwrF6gqdX5uuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc0771c-2640-4072-9345-08dbb6058d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 16:05:16.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHVztBXSA8zyf3n8ZG778e4hL2Pb8r+6QcXodQ76B9sVG+WrIwpZrN2f/ZNNQWsSYJ+4hDCVA1dLQaHP5Uf1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_12,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=788 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150143
X-Proofpoint-ORIG-GUID: xVVtkCMVFYyDEi08fpye1CJ2MXBUyUZO
X-Proofpoint-GUID: xVVtkCMVFYyDEi08fpye1CJ2MXBUyUZO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit b38a6023da6a12b561f0421c6a5a1f7624a1529c=
:

  Documentation: Add missing documentation for EXPORT_OP flags (2023-08-29 =
17:45:22 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.6-1

for you to fetch changes up to 88956eabfdea7d01d550535af120d4ef265b1d02:

  NFSD: fix possible oops when nfsd/pool_stats is closed. (2023-09-12 09:39=
:35 -0400)

----------------------------------------------------------------
nfsd-6.6 fixes:
- Use correct order when encoding NFSv4 RENAME change_info
- Fix a potential oops during NFSD shutdown

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: fix change_info in NFSv4 RENAME replies

NeilBrown (1):
      NFSD: fix possible oops when nfsd/pool_stats is closed.

 fs/nfsd/nfs4proc.c | 4 ++--
 fs/nfsd/nfssvc.c   | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--
Chuck Lever


