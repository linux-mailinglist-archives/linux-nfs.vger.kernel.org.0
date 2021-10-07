Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6416425CE7
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJGUI5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 16:08:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48962 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhJGUI4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 16:08:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197JCKJp026145;
        Thu, 7 Oct 2021 20:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fb782qSDiTdjVEX42vt1fhvNChXMFN+jDSVme2faV/g=;
 b=cN7V0+NbIPAr7RxT4Bih22EQCuotCZ+pdftTZs8tGpLxVwbPfs8T0q3+LgE45mbyis73
 gU8+DYTh/zXN+rKzYSooENttqI/wI0HqMVRgsuf4LYA0vxev0ysAHk/ibiUD0lgtFAEb
 vYx7YDzCIWt1sxl4cDq8pHQSo+OmLwOwXSuIDpqiigRvBktSBpr1QUfeorKTj5TBWnrP
 IQuyCo62Kx9oVAKrmF0oHPd/iNDdeFyeAUEDbt042fNbtta1QwBne185bJzx29m4vSRx
 QnQWaAWqp/2nTGGcPQeX5R9bgwvz2aDEW6d8znnJVRngSpKEBp/kQOQCZfv00LwbWmbF EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2dbvk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 20:07:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197K0spr062291;
        Thu, 7 Oct 2021 20:06:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3bf16xdhp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 20:06:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QASDE2b8lOIcEmqt9Jh+oCjrFUzP6BhPgLDDd5oHYznLTEdafF0Nw4T39fwWLVtoT1F+X9V7DKvgOVnz0WRj+AG8y9ss3Nbjg6Ov+xjkau2sKZlt2TN71peBFDQvGik4By9GL/h9CHdFhSgwAJ+fDcVMviP923ndIisExCnL/OPTS4DJURHwtZd6PIjiSED+zB0DzJ4En8CbDD5MDyMnsqkrrs7JXyuZC4NcsHVduGG9g5WeEgIpmaKZxJHzxlKTbioC81Z+i55LPz4vlXLDsE6WgnmBychLoEdp4IDpYrSl/kDNBb1rJ1Ds1ZVlPd4Cy8kOmKq0kabpPFylyMOhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb782qSDiTdjVEX42vt1fhvNChXMFN+jDSVme2faV/g=;
 b=FViWhFxL3naIh75LFSYILZ0LLex6/7C3XC3iBoulQlugVdyMJkxlgfbSmd7mF2fYT+APOkRH687yNav3xd9F41g8CMHkrZr7qu1PDMN4gKyU9MvXW/QxQFXZUmVENflzLAN9ms2atFhabKFKmXLNkgwm2cksVDA3aNbK/11e9JTV/8tCdlImcjz8i4yKUBlhK07dxhpmcIRM3MEcRhYbayV8saLUuerXQblNiyih5TRVhBtkP96w7desGpVvinyOK+HqihG+1zjRge8CMXvLiJVdplFKNANATdxwcrajerpgmilBL2GI5Xzr4pZ3kyqDYeAXJoRg/j6ev19hJ3WcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb782qSDiTdjVEX42vt1fhvNChXMFN+jDSVme2faV/g=;
 b=vQvMbYJ4wrhjxzS00oL2tJMbcmUv2+7eE9wcWPriy9AQUg24nu3Hn790svJG8/cPQBgGwp0SjZYsZD4dq6tmoT6CbRqILrz9ASMGA+3VxjvTIDg7ZMNKvC269UXHITzsiB94FjNiJCIy3PRW32I4xeixQREYcDyG3muVlNIRi98=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2648.namprd10.prod.outlook.com (2603:10b6:a02:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 20:06:57 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 20:06:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "J. Bruce Fields" <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] more nfsd fixes for 5.15
Thread-Topic: [GIT PULL] more nfsd fixes for 5.15
Thread-Index: AQHXu7bh31qVkpZP30a39fNnJxVfOw==
Date:   Thu, 7 Oct 2021 20:06:57 +0000
Message-ID: <39B6F288-2C96-4FF7-955C-43CEA8AC9075@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f91bc49-dbc9-4729-2ead-08d989ce03f1
x-ms-traffictypediagnostic: BYAPR10MB2648:
x-microsoft-antispam-prvs: <BYAPR10MB2648A82F751D7CDE308269D993B19@BYAPR10MB2648.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSjJalmemkNTPL2YvSJemb8Rw33zEqGn6Lw0DtedbQ45xTPEeOuYvf9XXNeptJAOdo3CfM+vKdA19+B6pLjSeYesSrxGeYfIIRY24oERLYkkjd0X8vsnnAzeYe/1WL7oubCfZjNpeJBhR4fWIeReV0vIe166CboG6ouA1muAuDPIBRDLg54uiMNqCBPfkurLPXaSJ2+FG1BM9BOZjHZf588xGEVxM/Mj2rvkX05JknQJh6NNgKR64kjDkU3nI2UheYjpYCl/paC9VMMO/fNDZ2sgS+df3hfNG1q8tDAiKA7IXadI7XNfnMrU6RBs8GuwCRXYNlrkdcr1QGB2UIt3bsBCSWim7VVSTmFPJt+uckhr8cOLjTOHhLaBdYol/cJURxw08Z1Etymuh8tFPnoW/2Q8O64hLvEfiLO3dX3R+xvktflGyb+/AhrdASm567RDS704nIeE5TXhwL/4xF9T+Sq6MSGpEFdyrxWwSP4+1UVN68raYpncEy5jUAgaa7jxb22A8t75MwYWa9ki9801ZF5htAT4EmpJiticqcfWIfYpuqVGF9XWNUMzWPy8jw6AIcUJzHPFljX6PlmvLKDicLq/BCZx5bIREKYgW3LTJBTKDaLxXaLkYlQwoIwXkCU4yj4ZhC5bDYw8MN2yOeDUap3HLTGndHni81xHs9nT/3xHqY8EEc3y4DUgzdOoqXKX8Zkfvli3cji7b41lR/+1MQNMJeo5/bMQLqhTdse7Kuz38czO1N1elDkhY2k0opno
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(186003)(6486002)(83380400001)(64756008)(33656002)(6506007)(8676002)(5660300002)(26005)(71200400001)(122000001)(2906002)(8936002)(38100700002)(4326008)(316002)(508600001)(54906003)(36756003)(6916009)(91956017)(76116006)(6512007)(66446008)(2616005)(66476007)(66556008)(86362001)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b5/QUNbvzOnDTLvPeGdzEoxxb4/QaZBjrUoVa6sGCz/GHknnQJ2RGlrn5jJb?=
 =?us-ascii?Q?BV/XZsNI7I/qyKEJHuvaW0Mj7jXoeM4qpE5KJiXCBJZASt2wK6FWy7cYYQeg?=
 =?us-ascii?Q?OyQWk4NphIbbSQPQCq60TN3ePR7bVaimm64Nt7JAQW+kjo9qLNu+sl72Ep5K?=
 =?us-ascii?Q?sy/A341zqAY437AF8EZfSaEQ5/NEoA+H6+ByfywJuzZVn0VLTHS3ULrRK6J/?=
 =?us-ascii?Q?+Gg15KOi6vmIAQxVm3cfQN8wdxgli/g/If6eLX0riY3qvY6hXekwYfGpSb+t?=
 =?us-ascii?Q?kAOu613qoUSeMBfJ4MpeV03vaaFzYfOcUXgoC6dJo8PIBIve1l4D1J9kVbGB?=
 =?us-ascii?Q?gtlR6pbzo7qpZalKthMkwB8sBxCXcBAaJ4AEa57SqZ4m+7FmC3MmhqkCJaS2?=
 =?us-ascii?Q?DJ8LiEyPujOvz2KbfgaRFxn7D43nmqFwDQZBOSIy8s+4HFmhFMT6A4m2Fh9H?=
 =?us-ascii?Q?zwQ0XWVjQzVqLHIwomC9jxZxKD4gD7bwt3GMjbKHMrSgaODc0uE78La/9V+f?=
 =?us-ascii?Q?PAJEtrdZ1HSKWsNbMApOE6+gI20qtXHj60cIGhGDAIG8KlDPZfw4Q9BuY1gT?=
 =?us-ascii?Q?IuuSPncmqgEY+l+wCl4Sq9emCFoFTXTq7TIbWYK/NJslSzyqfrVfd0DpFVf3?=
 =?us-ascii?Q?CtpP/F/kMoMq8CzA9O0zKXY/4pxaF9Ey0qBoqJ6FQR7bRBO8/ICT2VDNJIhV?=
 =?us-ascii?Q?TSMzEfg9+3cdINRKHHqa/5kyE0672TPPrFOSCKPwd7MQN1FUuOAeu9tW3Jk+?=
 =?us-ascii?Q?x2LvLzmhi4u7Mppls/8ioU7B9RBpAGDRsRVOCM5Tu2Yb3GEmL/njATJE5TqL?=
 =?us-ascii?Q?1c58gCamx+JO4eEy9l6ZQ10pbqVJqV62Mjk3LB8DwqmN3RH+EmhiMB+mAgto?=
 =?us-ascii?Q?vQCw2pBC42DbbLJDYQDEsNOBolGByqgvEElPfgvZNMQHY+d/bka0mlcHxPes?=
 =?us-ascii?Q?xIKXcebdiu/5Cufk+IUWRb61q2WZ3MU9/EH8LpEHblXnSkP8B9PHveQU3npW?=
 =?us-ascii?Q?eSAic/+2fQmWJQebOXAkYM6n2F0RmquDZjP2tF9waG8EKwfhVzz/JIu7f1AT?=
 =?us-ascii?Q?EkCBMK6JbCfGAYRQcQlbtiw8jVhWBcg6NJQ2me6auQweg4xQ013L7zx0ssUM?=
 =?us-ascii?Q?ZeqaIoGMZe92XtWF0Xf2PkZRcS5Qtt3/m4B1d1/zXZE3ketYZQ6COvJqXJWv?=
 =?us-ascii?Q?uI2lHmhXSyqDwVTcUaRoVJRPnbn1S/ZalkB+DiZ3w3FkpB9x03DZqF7SePgl?=
 =?us-ascii?Q?KU/Rf/cJdlHHH8pPgdmvnrKBoKh9hjBoAE8Hx8pQGuYmEWSAUKzjDDbPEMiN?=
 =?us-ascii?Q?or5zhtyHoQU6e8RX2jP1EbpJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEA4013881741B4BB1A605ACFADBC754@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f91bc49-dbc9-4729-2ead-08d989ce03f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 20:06:57.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wubaS/FjGooMhI2cNvpZF6ytcxSiobl2EFABm48SA6HY8lmR3GqmzrmAt3sgQy1xJcWeNiw+kL4N+dvWjaoDAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2648
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=842 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070129
X-Proofpoint-ORIG-GUID: JFs-Xq0SJoutKGH_KkgNz0GFrVC8KP8n
X-Proofpoint-GUID: JFs-Xq0SJoutKGH_KkgNz0GFrVC8KP8n
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 02579b2ff8b0becfb51d85a975908ac4ab15fba8=
:

  nfsd: back channel stuck in SEQ4_STATUS_CB_PATH_DOWN (2021-09-17 10:35:12=
 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
5-3

for you to fetch changes up to c20106944eb679fa3ab7e686fe5f6ba30fbc51e5:

  NFSD: Keep existing listeners on portlist error (2021-10-06 13:24:25 -040=
0)

----------------------------------------------------------------
Bug fixes for NFSD error handling paths

----------------------------------------------------------------
Benjamin Coddington (1):
      NFSD: Keep existing listeners on portlist error

J. Bruce Fields (1):
      SUNRPC: fix sign error causing rpcsec_gss drops

Patrick Ho (1):
      nfsd: fix error handling of register_pernet_subsys() in init_nfsd()

Trond Myklebust (2):
      nfsd4: Handle the NFSv4 READDIR 'dircount' hint being zero
      nfsd: Fix a warning for nfsd_file_close_inode

 fs/nfsd/filecache.c               |  2 +-
 fs/nfsd/nfs4xdr.c                 | 19 +++++++++++--------
 fs/nfsd/nfsctl.c                  |  7 +++++--
 net/sunrpc/auth_gss/svcauth_gss.c |  2 +-
 4 files changed, 18 insertions(+), 12 deletions(-)

--
Chuck Lever



