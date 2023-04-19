Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B606E7B1A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjDSNmY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjDSNmW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 09:42:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1519B9;
        Wed, 19 Apr 2023 06:42:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JBcBK7006002;
        Wed, 19 Apr 2023 13:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xhobOUq7OnB3uRsGOU0DXY1iUfp/ODt8+M0A2dPv19c=;
 b=k8LVdK7BmMpHpweEqJfSOwDFPfvV+gzSyXz2EjEdIfpyWyfBHzBG2zUOMwn/Cue3rdnb
 gpcVS1StgAFumMOvLzUSldoOuCDSVZiwIjORJYFqixYGNMOoJ6sKsF/OItiJluM97SGt
 6NDU+XDdeblTwuKJfVzyEwWBR5xOp3Kgd6Ch/USX9IwynemHFfZ71FVXOdFSjvpHbtg0
 bL0mb6Wjavs9sgO1TwvZKWQTcENGdGHvitQj5OfwKEeHsZCWQNVXFj9O9Igliv7gcTUf
 VWlNVMcR6O+hhsb2bCMMCm5Zc7ZaRQwPIPtNxumBOLS6P+fzmYZfp12IzpvoiFF4A/GN lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq48bn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:42:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JC3CQ6036695;
        Wed, 19 Apr 2023 13:42:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjccyreh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf0gMLrZe4BqaHafxz6/XM1jjka8UfPALOLyDtnU92vcZfElY1jOHNA+KyJPLxKXczQbvXqEzNCtYJ3rthMehcxeuXduPuOkCxw1XF/+SMGxnoOwOCQTIjQLDmkELMctVtd6CEbEWw9W5JrAaFyBXeK4u7AuID8RKkgOQMzb+ZRLg2LiXj8VTxF5LsPA+z7jj9Nui5faaH+9w2lndZ+Pz7BLpnEkzYKmT8tXIhLKw8w2H8JDqi2AWS8WtTdenRgTj7tnfHniZkPXY6i3gt8UstO67GGc0N3tFtTwHfnHYxbLjzD4jsGI+rDCzo0REgo9p5N1GqMEjDEU24aBu66/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhobOUq7OnB3uRsGOU0DXY1iUfp/ODt8+M0A2dPv19c=;
 b=fCuTp9WKjg0urGDeOBuM4chci5UittfNKvLW0r93xbOCm6NSCN0bRa2dNcpvv8jE2nNwmf6YRk4oEubYmC/IdD0fiU4jCDIUEJcS6ZSpIboJNrKLmpeshC3rKWYRD7htaQNKrJkTj9b5AT5uZGjVQoHNEyVyxJuMknA5qNfQ03OWaAQzMIrovSawA3cdHyj7dYIIyWYvVFllwl/WSo6htwazM3NNYiFYS0nVrpMBGS1Bc8mtDlQgeLcvL6SpWrhslGF16liE7i44zMYNubjMV4uhfg+3lkFPY+yFiiFXWpIUF1RovtFws1SBISsFyCOA2/qSj4Pi/vbU488pu7Fw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhobOUq7OnB3uRsGOU0DXY1iUfp/ODt8+M0A2dPv19c=;
 b=UuEpABP2gyO0fhqaRNmvBUiAk1h7xBvZeEiz1SW8hISfMeKZ8xPzMksLZ95QrcjiGZ9px7OdrOujsJOok4GL5m8Jps+WqGrUsSmJj5BSXb8z7HjzFPyyK2t+dVtiNdzaXauZFr0BnRkvcT/US5Nq4XjVNXp8AKFY4PT3gFgHujY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4463.namprd10.prod.outlook.com (2603:10b6:a03:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 13:42:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 13:42:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd fixes for 6.3-rc7
Thread-Topic: [GIT PULL] nfsd fixes for 6.3-rc7
Thread-Index: AQHZcsS/LQzpBbWA/kOuiYten1jGAg==
Date:   Wed, 19 Apr 2023 13:42:12 +0000
Message-ID: <54D84D86-4B89-4575-84AF-3EC7383B0779@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4463:EE_
x-ms-office365-filtering-correlation-id: d203dee2-72ae-408f-f979-08db40dbe19a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: daBYKybAeBQL0Z2tQ1bGVWr7pdJeL/CB2U3FJ7jVd62r0hBo+lGpmC/LBKno1BAWo3vYJjekZkTEq/kZARWd6EmLH03L16miq1LboCEDrQu/xBGajSE4V+8vyE/qAyezZ92csEs34YOxte666JWq1jApq6B5U93krUCJYzanhs086XgA+8XVcEqIjp1i45reVwPvu5i843MqoIiCU/S2JWZ93edr0XVNrBukvp5NRbMIhRj6NJUELhwuCC081WlQ+AmJEVoWn7paT6bZiyv0DB3tYK5dVCk0xP6NY8TNsV5w4NijLgV8Jp8US2N2+DghCHtyHX3QSA5LeesP/11ppqVMWjyGiBW8b/mueQ7nfWJgA2H4KH88Z1vV4t7scVGSTZOe2ycsPG6HTtrrI2cvSdeQfHq8ssoFSRCNPAnKSLdRWqfllZZ5KiCAcCXkb99wUhrUDBq2rrlm7BgmWQwc4enjwb+4FCjxmxhEAkgNK6hJpLpOGUoDuArm4cUI5eZR/YnhKQV0PC0FHtnxMjEc0qo57/50Gh2hw/9bAg93ubL17T6V67Kmty4dWhmBlnzXSQq2P4WJ0t7odGEwWUQb5buls5O8sKmMA2w7iLEyqADWwQ0eZEjTMUuMDXD/OlblE3Zk5+V4kyhLbbYkyFtCpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(4326008)(6916009)(26005)(6506007)(186003)(316002)(6512007)(8676002)(8936002)(4744005)(36756003)(86362001)(33656002)(2906002)(5660300002)(478600001)(91956017)(54906003)(64756008)(83380400001)(2616005)(41300700001)(66446008)(38070700005)(38100700002)(122000001)(66556008)(66476007)(966005)(6486002)(71200400001)(76116006)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NfjjU/XC4XO4WOx5tY1S1dKcqqLXt2qU5cYvBTcUcsrzRIQz5XdIFEzla7zL?=
 =?us-ascii?Q?2p3WziK1LAOxiDt/isxWRST+JzksOJRSb9PxwuUmFShmrxJOFkLLOLrPsuol?=
 =?us-ascii?Q?6HdZZwia5AQaCp2fJcZRlE8xHXTdoSGW3pypLErt+l+PW73YrhpliZmrt2wU?=
 =?us-ascii?Q?lWvczofkjr8KytqYWNReUQqFVLFB0Ad9NP7IDqXtlF7xC1q5hB6hKF6urHY5?=
 =?us-ascii?Q?CZyIWTbBHpInAhza5avaQtvWROCeR8uqeknxYMrfRqi4NdCr6QanpqNPDwCB?=
 =?us-ascii?Q?RJJWSkWrvf9ipfj1EgBWhmeNJOQsy2XKOiSszevRpUXGCLCfoXzqi3RY2qCT?=
 =?us-ascii?Q?Q9ECraFEla6+RcGU6Zr+47mZclaY5PCiNJIAivc7Agm3vQ45XLve4Oam6T0P?=
 =?us-ascii?Q?X3eDER7iMleNp5NbETTcfAdVvAhU4R+MInBCaOdJVS88+5RKiXwrScuWV6s6?=
 =?us-ascii?Q?0suTqEWXysBznJirAKNPp0fSscFNQlLjYV7884Vd9Eq4Jm1JP3ueh5F1mRXW?=
 =?us-ascii?Q?QQLQEK/LqSAR1FcK5e3P9TCJ0toqj77pN05dyt87k85gHTvAezBAL9mLEoZz?=
 =?us-ascii?Q?6oceLHtmzsn8cBjMIjS7G52WkeUL4VIEicwmiyFZm4xKJ6/mFYN1wvJX+Qfm?=
 =?us-ascii?Q?t+qaYgCssQp/jfV7Gj0cgSZbPCjvzlcUaia61eaawoDMzkaoJNpfnOlFPUUp?=
 =?us-ascii?Q?ZbvTgjEGzQJ5eC9UmkAUkYT64DAxs37tKFQAfTy8RdUfSoIoptVQqDQ3bncq?=
 =?us-ascii?Q?FPcYBuhxxqvm3y4KRreDrTKTKZimCIbeInW8euqOOZxWrfBzT6K/Bs+6ZHoM?=
 =?us-ascii?Q?WmUuQw+4v8JKJ7hId9f3f99zgTbB6B3Yj5EWqkjCPqiy+lNi7AY2WepMHRW/?=
 =?us-ascii?Q?+6CjGy2n0mKcP+facCsSirdw8x14EA1+xD3qyHfkoJ3FnSY8MjIQgBC54Kza?=
 =?us-ascii?Q?ChsQeeuXnYMkXSWmPXnUcjF6+93QXz6tTrWbDoMb/E0FbW7uB/KXbFzi8J/P?=
 =?us-ascii?Q?I87dx54ayJ+za8Z9WQkRm9itpIsVpiP9RNuxVbViTBSGyrOJy/WZE13MH0HT?=
 =?us-ascii?Q?ZYXIEEhhtAht8jNQjmVRqKX8dI6c+/x5uwboETQE4l31ut0u1obzxG9MEWDJ?=
 =?us-ascii?Q?VNW8dVAx24MmHNa9ViPBqu+S4WHkTw2eV+0T1QqQJbVqG12peJvcKlsDNDM8?=
 =?us-ascii?Q?DChTl+J0YigCjwwt64k2m21nWkHVU2I0R7PLaRmaTKFK68C1FLmIkHOkD3iH?=
 =?us-ascii?Q?S8MXBO/ftw2/uZ4Vg/BvMrwyblpdunLEkshP4fa7LwZzl9pDVpdpKHJTdbhr?=
 =?us-ascii?Q?ljeIGNLGB0EHtIJAVszxfdQ5UfL8WshJxxGA9tJhKcKSAZ5LxHv8nQ8EbiI5?=
 =?us-ascii?Q?IqDQxontDh1Aj3gD1yxc5q/uzphzmNdLYqPBkbQ4b49XmUqa8hCdTRZ8MZU2?=
 =?us-ascii?Q?/CSqciVAZQVwnAQIJ+QVW/ESkTh6wD8ydBvxQz+lVYBhSFyWri34w5Yi5xKD?=
 =?us-ascii?Q?E+LO5xow1lA03+DZJHNPXcVTxwQ46wbmUuGaiCQ/RErDh1W+dkEG0Kim1XHe?=
 =?us-ascii?Q?non7TNhfUzZUTnf0IyKo44Ad4SxMgcY0IyX9QJC5T1AoOknVApksxCK0f/WQ?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <537AC408698FC4498FBDF5D57919BF4A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G6+mvFmT7e+BuIXlpSQ1K+mpwCz1D/mSVa/mlfs3n9nw7pyFif0ItJroVGdDFeCR1Sjv0l8dAD3cavRjAGnoqpAIAfD12/gzeIioNrxdb7pquxX3E1mlqV1ndIZqXFEqlBnxEHcGDe4t72f4B1bM7yU0uH5lUj0HEyGdnzjD1lhuSoPb90ZIxb9Ih1KU9MuMLDjF2lJCf6bfEY0Y7fqLqfOMyuWfXu9uVcxV708de0e2SHCEYw5F76GNtBWprOK95I02+pXGO4AX5s+YBGrcB4YT58ESoAJBp5QK4kIWzbmCE5tX2MxsRmYTT6XJPdfrrojvqlp/EJkUsFeRhKNOy/lzsvbRzjT8svCzKNEHbPFUjDkybdy7tFkOEf1sQPYevjG0HIzsRygrlfMHSYPbWUdREgs0Ee45mRuY6yjna6xR5S/BmXDXafnyLYlrd7wsgB5rXV76h4DFWzAgBUHFsod9cIYI/HyCke65rm4HbaFuOnZuq1WvNysnileEgUDSImSB3AxBbjpw6TMb4dshOpPuxfUsjzKm1aYMACVP1avolKqjakCE9GoZsJtO6HN5yiMg1A70WU6C2MLO0MdDDghsn9fDcpAACtk5MZPQy1b2I3hxpKGVd36Ya/IRqVNSey3BtIWsJajPlU4OOYkHIICtOGT/o77IjzUPFpjhCc9WqAcKBWVTxIwOiYmYU9BQ6bl6aahelp9BisNDkhs7qLwVztF9MnMoww6BxGRNWkMx1h9ANdwjru7se+I2zgILvu7Yav4WpjibJ6E9zZASWTDFYpCV6WVxNoPxFwwIDh3wt+v8sXQ8N18Aitkdg4rabU0Y4PsBIC7yMz+pefSCxI37z0/hNwabopdMi5GC6KY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d203dee2-72ae-408f-f979-08db40dbe19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 13:42:12.9572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S77bdvPklAEr5gKnI44SkfQVggBI7UzHUgbHV/l20GM5Nfhq0gIpOQ2KbP5wwS3leX/znrmLxxYUHyBMoogO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_08,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190123
X-Proofpoint-GUID: q3lLdBNlaHa5T5Ff5yhr226hIehiblqp
X-Proofpoint-ORIG-GUID: q3lLdBNlaHa5T5Ff5yhr226hIehiblqp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 7de82c2f36fb26aa78440bbf0efcf360b691d98b=
:

  NFSD: callback request does not use correct credential for AUTH_SYS (2023=
-04-04 09:55:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.3-6

for you to fetch changes up to d51425190805d47aecc1910b272e65476dd3b937:

  SUNRPC: Fix failures of checksum Kunit tests (2023-04-17 09:42:54 -0400)

----------------------------------------------------------------
nfsd-6.3 fixes:
- Address two issues with the new GSS krb5 Kunit tests

----------------------------------------------------------------
Chuck Lever (1):
      SUNRPC: Fix failures of checksum Kunit tests

David Howells (1):
      sunrpc: Fix RFC6803 encryption test

 net/sunrpc/auth_gss/gss_krb5_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--
Chuck Lever


