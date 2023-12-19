Return-Path: <linux-nfs+bounces-713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13E8191A8
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Dec 2023 21:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ED6288537
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Dec 2023 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C1839AD0;
	Tue, 19 Dec 2023 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9mJn0L6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ImtCCieX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7A39AC7;
	Tue, 19 Dec 2023 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJIoK4i000820;
	Tue, 19 Dec 2023 20:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xt5iXzTvOY4Xd/Ve/4Jre3zD4xM/D3vCKxOkVTF4Vxo=;
 b=R9mJn0L67Up6CBSWfXXBohPbsGpqi1MflFsYIM1uyPN7C+soEipYAAvHDHzZabMDnaUr
 yYuX3TrZLY3sHOqcfQ+P8MoILpcQYdwlywXxJcYxUOTWlOfg97OHz9xleHpUQrBOYs9i
 veDx/RW6wAtks7NF6jnYC57eGdRpjf8slbceBmS9cA/MplfCy4ColWd5EpzvfHJ5OcTA
 QN3lbEJxQeFAX6bk+yiDpnoinaJh5RqPaivWNP49yEmxQyN7YmBEVzdHm10xz8MRjFhO
 jrnqeSNN0JFxaO7sQY/8WRCTQmPAXhORKcAv92DjPUr9VfAzoOFgIq8UwedF8RZILdkU /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12g2ewtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 20:41:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJJKNx8022262;
	Tue, 19 Dec 2023 20:41:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b7knur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 20:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDGmTmmDbIC3PNyjqo/54NaUlL8F5d54D2nNK0QMI2cYzn8bTa8ROXp2FZ/0u47bSIxxUMtN6KOK55CcCCkdcwIcBUHeaQ0KZze31CUd7UeOy9qla7ooGCNFq7o6HnJh7UPmMB137ESwMdjz7IHpPdHE3BqL1IH3jrcI1QF5ehYH1xxzdk1OyUzliWYcutm6Ey/dh/8WMvKfC74m4YTuNg+J7TKqmUA1osvVq6GAgpgy1iGr/1SXU4b802LonhSbqC3t2kA7NVTi0ZEHpThyrG0Sowy4YQWG6z8Ox9Y+lbh+rIjg3rfQJuHtlETOlLxF+5kUqUD4hrDHu7BJQ7m5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt5iXzTvOY4Xd/Ve/4Jre3zD4xM/D3vCKxOkVTF4Vxo=;
 b=HCyYVUumapvNVaFg0YPMpySV8bPhCWc3BylfW9VHrqrweqnMA849FPtEeqj+V4tHr+dssuAvgoH/7deZL9wnE2FkZGyv2Gv3GJerNZQk8Cps/+SrsNDDs3pZeCkQlvt7ll2APGT5xxKInnDrOeYhkUh4t/EpQKpg0HY4mWNePB3RjfwL5qn8Rm+9jh6wbAvDgaFzCm3UPgWoDz+ZRSO6me82PKvnSW8734sJqbmSyneZYL8HuxzPWd6gBeGnVu9YYBlPrAAyl/c5U13WiIycyN2Jpscb/eKZ6IarJX0um1R24FXc8CNdu6zuOOm5sjq2UM7lY8SOw+xUvQomNGa9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt5iXzTvOY4Xd/Ve/4Jre3zD4xM/D3vCKxOkVTF4Vxo=;
 b=ImtCCieXBBiuODQJox2+CIcaskZ59oOUCVwsqQX1QDPNEPITU3c2oqrkRShXIgkoikE0k410N3v6nbil5f9x5yLMQEnLLAgT/+dHyebYCSOb1I8aMmFU0LuxOy0G8cnTfXezNmFQ4eLQxlVy3bn6qK6mKILJB2Ei2FN80HOKyC0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7788.namprd10.prod.outlook.com (2603:10b6:a03:568::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 20:41:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 20:41:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] more NFSD fixes for 6.7-rc
Thread-Topic: [GIT PULL] more NFSD fixes for 6.7-rc
Thread-Index: AQHaMru07twXlh2zWUeiEETNadJQpg==
Date: Tue, 19 Dec 2023 20:41:12 +0000
Message-ID: <957B327E-8807-4EEC-8BA3-6465A0810778@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7788:EE_
x-ms-office365-filtering-correlation-id: cb36e267-fd3f-4aef-09c2-08dc00d2d6ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AEfKylidk1PGSxHP6xUg5tLeBQbNK1uHXhO5ju5gSaUVNR1mCZx/PzhSCXI0eIZ5tQvJlcpce8ik3KFm4DVnFcwU66F2Pw5UbN+YVayDYZmntQEHZERkRP9P/XlS3dMczFUP6o0Tf/Jc2+sRBvkyqJXKQPo0zTX2w+Sv0MveGJqMnfPwjCjxOwsbl9x+tS84kbgcE8St9bN7ldIIS0fANXl/dLTp/YMIWf0j2QvN2m3ENIQ/ID8BvP8CeEebOoaD1b3efq5Og66zHqQDqUiwin0chdhO762EVX9vuZxml3hblV4ZWTykac/iXYzPs3KzlstjjXFP4LO8srVmIQdZS8umJo8OQ3An+UJ6kWrt9bCMMo6EkHwCowlk//+utAH/n3y9jSgQHaQSni1yfuTtSF5WpuU7ZySftkfxPiWB26kpTGpSoycLp9OjGgSN2F9LW0RG1H8gfo9Mtj46F7BFIeRj4u6glgR2omfteG98J5OhewzwOq52Hq/FXepD2sQRgAU/vU3IRK/RERLXDXj504xjI4Ytt/LhaoiUHpZwgjXmGEltyzBQ8ErOOIzXAwB1XNwSVp10sWUB6egM0sPCM2ghGVVFGLgT7pZE6BxXPy2nk8LxHOKgBqXR45bdQBQrDJDolBogXII1HjiaBFY8JQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(71200400001)(2906002)(26005)(2616005)(6506007)(122000001)(5660300002)(83380400001)(4326008)(91956017)(4001150100001)(8676002)(478600001)(8936002)(64756008)(66446008)(6916009)(66946007)(6486002)(76116006)(966005)(66476007)(316002)(66556008)(41300700001)(54906003)(38070700009)(38100700002)(86362001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vmxNH43Tbqn63SHfFRSyBoeATSQR1f8S/kal8UHNkk58hQWgWNYfUAlbdTMH?=
 =?us-ascii?Q?Bl+rcPMjhMEKJYlkQVnIyzN1AtCJkpcnSVUexidVY8LC9Ok98OHTsWnB+GRB?=
 =?us-ascii?Q?Bor7ZIMCkkA5YGs7Z2Bwqsk3xOexszIfdmGr6tFRRswi7kL5QsrcmcCb1c4p?=
 =?us-ascii?Q?vzOszKZTFee9lfTjfLUD1pmNoHq/sIAtRN1K6+RubLEdc44Atj1yO2+nj31E?=
 =?us-ascii?Q?yL70Egk8hIRGaU9lUR/o7BUradZB/SW6AfWFyBLGOZbpFnPZkeKxX13Xxqlc?=
 =?us-ascii?Q?/dpVY3AXGrsBRsYkCOBgWQ2FOnGZ0kTUFYbpwbH3CHYVwZCwN0mgSkF26MsH?=
 =?us-ascii?Q?37STOSxOYBBCdfOsZ5RNH56xszFnm45ZBDls9e+MNvhuNMRjXdHuaKWIo6cX?=
 =?us-ascii?Q?YOgLPKjGykO36zB92fdMvxN8yJsIvFr5bvJra3+dHN17y1M8UYGkdXRmosGv?=
 =?us-ascii?Q?YuwaK6g9ASQkTIS8vVt0+5/KNYsCi2zCtEd1r7XQZtEO3Oey2vdzxbPbU/he?=
 =?us-ascii?Q?v3l5x3gobc3DCkIiPGAcCHVqn+mw8Fy++8FwePwFReIJKNrxkEMQIVYofrnb?=
 =?us-ascii?Q?Hqh86Ze2vNyqdCFQdFlL/TA9AODUamUgaoYh5agpbG4SxcmP0iy2RhNqdMpi?=
 =?us-ascii?Q?EJjRVW2INBSatrBM3a2ReuCwPqZtT5BvU+Fi83YH5+uoCLsHeY6uTAjotPPB?=
 =?us-ascii?Q?Wy1qIQ9atAxzsxQE0inJbU3G3ER1GsoJL3Ixi7zgGi5pTJ9FBc9EM4noNyDY?=
 =?us-ascii?Q?vAQKqJj08YyyzHJ3vTWICGrovQPK6WunoaKCo9lvU6esqIAbOU08QU6FVFeO?=
 =?us-ascii?Q?7F2fr5jzC8Tf7plgElvjLWcNkbd5tlPmYc6enYxU/Ds28zx+ma3b7p/Jg2Eg?=
 =?us-ascii?Q?pFnBg34QyCcRrWC5BwE8OjHvJLRiZ5FPRJJEqhY5GKJPzuSiF07rC1ojtGrP?=
 =?us-ascii?Q?4aD6eMx/9sg6nfR72OmfpMNL4NGgelONgJs8sZvJ6FYTvNYlGB3xIIs5GSlg?=
 =?us-ascii?Q?C1/76bzHSYkXFLcO8CHdetW3Is7y0d3Bni8yo/ojYP+L4MNjYDk7aE+atX5c?=
 =?us-ascii?Q?wJZg65HYcNk2fZXn6Py3TE2+AFVEgn7FeTJ6GBjB5YACmfVq144uvyq8+Ils?=
 =?us-ascii?Q?PU5oBhuFmOvJw75hky6jyiWeCgZTkGnZsAgwYDlpQZ4IP+RsLhZRsa/h2/vT?=
 =?us-ascii?Q?gIFgzX1Dl8crcuKraPRpgdpQmEQtGTlEkCXeSjAf2EiM//BtHUvIsJvsofTO?=
 =?us-ascii?Q?fwaRA/FYO+/BFbVcmRMqQMC+TQetJSDGMD+jiai9g4tIeHIPMF3dAne9JH7G?=
 =?us-ascii?Q?ebYU34lKaZ0MUjzDnAd2KDD/eL68dYX794qEpxlXazKEt4MR0j47UQsuHpHD?=
 =?us-ascii?Q?Nu1uNG4vrP0RiR8J41s9q+caMulZGoYJ/5hvwE+cIi2/5DSbYCCXdUY20X0R?=
 =?us-ascii?Q?kPRFyxp76/ddJ0LPYsVsBKgUKGiEsuDl2XEh1P4PB/6M0xfK2B0O5jjqPklQ?=
 =?us-ascii?Q?+UNtDhSC7tXuVdBFiSdCIKGjMMixu7zNzXdKvjlzBypHJJMN7wQNahPiH4LW?=
 =?us-ascii?Q?QXwNkhM4B4tKOCGis+tiDwORyekk3A6ERHb+t3b8q/A6HLPZ4qfXjJNhJ1Ie?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDAD58EA37AAA84DA0C9D946920F36F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LC8+4G7ZSV2+kZDfUH1gBfoupXACUWjPo5iqYyFs+zgReOg383qGQWu0TX48pdB/Z6bsdYhTDiD/bZ+ZwaAFpgJzvs3tYNhjWb/KpdXpP997qyYLsyekkoXdF1XQpRQToASZFy+tOHqJbGvDsUUiLPgFsYYLroZQLJbPfwIjfuqfeWl5mg00YjzXHiXtVuQMi4JSLh8SVfUUoRC9Md88WpwcRj6BFqfnBLwqUoGA9FKQBld/6Oco0e2YK1r61oL1iTBssRdwfqW1+APR/GC65RhuVPpCApuW2lPQf4Gt+sW+0wJg8uz8XW8HnoPfhcy25Cudxtxd0C70Dbf8gatBZYpGDxzLkOaE6AjP6Ji0amRSpxLT8NJ7+822FLA8HDSZFXeofd0FUeWZ5jagig0OhoUPWE9hmJ3joEP21KfMqHSH6gi0tIzOXDMnu9gOdXKnCI6lqaKlULCTrBVdAieNyB1A77SGP7/xgGfgh7w3lETlUbt7216T/4VVj0zlldiBt4wlsKST87ppk9zKNwDXRWJd5ZcG+FaEvjoaXCNP0NgUufTbhmhLjNKdO2zOkn5iGXXr3A8kvXHHd1Y66fdjg9jGYAYcSw/flrfXEMJMMUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb36e267-fd3f-4aef-09c2-08dc00d2d6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 20:41:12.9265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oxs1uEYM1gvqAYEJ8vROzTtUDTFL5nPPLzPjhiTAg0W/4SpkEidWhpmhGiPhj8J1/d7lNa9fLl9+jMX65qw5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_12,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=917 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190153
X-Proofpoint-GUID: -FgZ3QYcA6GC2r_RCrIl-Djiq3RKGLtO
X-Proofpoint-ORIG-GUID: -FgZ3QYcA6GC2r_RCrIl-Djiq3RKGLtO

The following changes since commit bf51c52a1f3c238d72c64e14d5e7702d3a245b82=
:

  NFSD: Fix checksum mismatches in the duplicate reply cache (2023-11-17 15=
:13:01 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.7-2

for you to fetch changes up to bd018b98ba84ca0c80abac1ef23ce726a809e58c:

  SUNRPC: Revert 5f7fc5d69f6e92ec0b38774c387f5cf7812c5806 (2023-12-18 17:10=
:52 -0500)

----------------------------------------------------------------
nfsd-6.7 fixes:
- Address a few recently-introduced issues

----------------------------------------------------------------
Chuck Lever (3):
      NFSD: Revert 6c41d9a9bd0298002805758216a9c44e38a8500d
      NFSD: Revert 738401a9bd1ac34ccd5723d69640a4adbb1a4bc0
      SUNRPC: Revert 5f7fc5d69f6e92ec0b38774c387f5cf7812c5806

NeilBrown (2):
      nfsd: call nfsd_last_thread() before final nfsd_put()
      nfsd: hold nfsd_mutex across entire netlink operation

 fs/nfsd/nfs4callback.c |  97 +--------------------------------------------=
-------------------------------------------------
 fs/nfsd/nfs4state.c    | 116 ++++++++++++---------------------------------=
--------------------------------------------------------------------
 fs/nfsd/nfs4xdr.c      |   7 ++-----
 fs/nfsd/nfsctl.c       |  18 ++++++++++--------
 fs/nfsd/nfsd.h         |   1 +
 fs/nfsd/nfssvc.c       |   2 +-
 fs/nfsd/state.h        |  25 +------------------------
 fs/nfsd/xdr4cb.h       |  18 ------------------
 net/sunrpc/svc_xprt.c  |   5 ++---
 9 files changed, 30 insertions(+), 259 deletions(-)

--
Chuck Lever



