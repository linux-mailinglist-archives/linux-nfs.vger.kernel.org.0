Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D872FBB64
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 16:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403746AbhASPjX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 10:39:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43780 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391600AbhASPjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 10:39:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JFYJwU151002;
        Tue, 19 Jan 2021 15:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Jl+MbuEJKtyMREkrDN4Doay8lfScMOZN4YQRbgKy0GE=;
 b=ngZ3IP7vjdNRWDdkTup+AkvTC2VhIYct8Xj3tqoXXA/zDIcG8PBkhJhY5CLszKwRDiRo
 gfcuFJADi+4IjDlLi8eWSb89010AOEAdwbXp7Q/8S+sKoboD56peUXroqFWQ8ACAY+dX
 0oM9584QA+CE6HJJbVqqDBB9R2qAshjA07JmjEleuxOexYqRha8NisJSyrBgZcH86Qgh
 j7hu2GOuRjngpvwJUnXN18nx2D6jzNjohVICw1Gbd9vz+JuYM+ddOAitDPWCt3IfV96H
 yfC9oehC9MZj0uSWEMnMeH0CJ8EqFkbAn4lL1YahQYqsPO/2MbFBy0QmhyC9B6wti4MM cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 363r3ksmaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 15:38:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JFZewJ013921;
        Tue, 19 Jan 2021 15:38:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3661njaw4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 15:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4wluStU7alI/s5GxqYjsb/DkurNy5EFyXjsgcAcFwlt98KD4xc/QpYOZaU4peWBr/yRTczdH5vBzp9sfiMWVYotMsJfVdmORsyPSP13E8S98CvmH2J+n/OkTdyXBazSpj6OIKwncXseS5bZR3reW1mJheP4FGID//IOajuKT/zf9C50JtxNfVEhr15yzEP3BUbnHfd93E/ix1DbXNNdBSsqxZZS1pU4wIuC3MCHu8hGVXLCHlUYZ0cJfognsny71wEqjnJf4FDVsnKiSQA2LgheqiOTSHBB5b/yf0ESV7N9MI5lemtef6nRNa/zdBOBp6wUuY5+uXRWTuVO1uF2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl+MbuEJKtyMREkrDN4Doay8lfScMOZN4YQRbgKy0GE=;
 b=GY+3D3Xs+u2UvjJQhp8N/e6ptAs9IHXSlq1LaxmstXHibVtIwV85NN9gSZktYt25ICqmtwtsibmaJTMDCItipk+tEsK2ltm5TUj/L13AL9RPzfII7e4GndI4qRoczF1ThkdBUQjDLwnJ6UzzpNpbuKM98pNqo4HSKT6NDLJzONSW1IkYmv3OOQzfWkvJJg/r/L6p4FVKfxSA1B9x8AjRxoNdnXmnATzOQx5/CVQb8o8UqwI2sKyfpcdNhjAIp0uURLx2m3dFj9AoGdtbS9OVkeA4MkqbHgJwOcFsBuxFSiehqQMhVhOfdb6NR2bsHX+ruXqoDtf+5XJB7oYRQrhC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl+MbuEJKtyMREkrDN4Doay8lfScMOZN4YQRbgKy0GE=;
 b=ao9IhshXTKTtPkNKJvMPJxTM8EmNvDFfzuXL7qzMB001DsKvL7Hq5pbi5FkePQK9uRnbbd8u9utoUOyfaRZFUn0YuJSODFbQ1QnHwrGneuFQN2/A3HNFGAhbiX9QVt5Iw2f03S2dVZaXiiF9nbYo/r1u39TeElDpUwPjOqwbZHM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3558.namprd10.prod.outlook.com (2603:10b6:a03:122::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 15:38:22 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 15:38:22 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Subject: [GIT PULL] nfsd changes for 5.11-rc (second round)
Thread-Topic: [GIT PULL] nfsd changes for 5.11-rc (second round)
Thread-Index: AQHW7nker3RHfQ/8Y0KCmbUv8yt90w==
Date:   Tue, 19 Jan 2021 15:38:22 +0000
Message-ID: <04E864E1-CE3F-4DEE-9A0E-CAC4DEE51D7B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2d75312-7f53-4490-4238-08d8bc9040f0
x-ms-traffictypediagnostic: BYAPR10MB3558:
x-microsoft-antispam-prvs: <BYAPR10MB355868C57CF4480A9D45438793A30@BYAPR10MB3558.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0rKVoi65eE3VCer/aDWCIBpEQ2JchlI4goxSInqcnsbMyHG+bjdA05Z4F4CTPZVfQvfEc3fFHXRvnPQ9Bn3d55SOgTAMeEdilmsFp/IMwFZu0RbSkD0nV0BGYa0x5dvQ+1VqciUfKJPc3Mq/Ka/XiAOrkp9O/Zf8ym/ZuqGwHFXEq95b7m3d0SjwIx9Y+dkq7C4dMUtu/fhypeQO5Q2Xir0M0cvB5oIKUqjTczuxCebYOAP0toe/Fd8ir6TEWjjAT35XJEDjngXiQXYizdxyFh/0LQti5AEIJJ5CSmmVuHOUOrsGbJ4S6Z3f4jNOSS+WVBD1wL5aqfOFqK9CLE/+k/80qzTDeOWf15COjKGAUbT1z59tbgUUiGZ/tqWvGq6Yx6Ws6fdEDGIgzPkTn4k5P26HcDHa/nGcdmZd/nQt5aMFhDVtup6bkt3CqFy3FT6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(396003)(376002)(71200400001)(66556008)(478600001)(8936002)(6506007)(64756008)(66476007)(86362001)(66446008)(66946007)(8676002)(2616005)(6916009)(316002)(6486002)(36756003)(6512007)(4326008)(2906002)(44832011)(186003)(5660300002)(33656002)(76116006)(91956017)(54906003)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wHZvhYqZ9trIdHazhYdrg5gFNmrTmXVzU5tfK6/0dc/sSqQW0sFPCo2fOEZo?=
 =?us-ascii?Q?kWOrn9IJqnRpsIoOiRLHzhN7hMiMdNzT86QsGiNHI6pRB/tMty3QDqpHPY3N?=
 =?us-ascii?Q?mpZOtqQh58krTmH9ksH5GJvw2a2fpkHz6vQKJEAvigbtFQHwe3q9oJcTISbs?=
 =?us-ascii?Q?rctE+lNA025kCBsgTVBU7dkv4xkJV4w0rXcBVX6OIuifcCqjeyWfyknD2cIp?=
 =?us-ascii?Q?ygqtzvGXhyZarz4qRRevLl+eBO4qPdzO9Nd6AuVFrtzaKcpAwVe5E5ZTUyA/?=
 =?us-ascii?Q?bw4cwTYs24OOJq5ePnxz24W/ZUK58KkRLAmpHuc32KWyJMSvDnwI9Q7qraKI?=
 =?us-ascii?Q?Ll2ynRLrF+eYr/UpVFQs2krrFvdbf7TAlPC1JKhdnDhJNR6twg4tn8wlrXYH?=
 =?us-ascii?Q?AzNn4P0wwcPMQ+bgSwBVjfXOQcO1bL/qM6yaf7tL5yRNENEyApxdhTulw0YD?=
 =?us-ascii?Q?Y/h+2wMLZURLIWzbv1YItQnLfjbBhIjjWcgfoltBsSEEMRMQwVMr2T1LNw2z?=
 =?us-ascii?Q?hzpBzmRNhVf4DbhnSK+ApPJsVcd8LzymzEn+ehgbeUGjWVWsGWZBxqqtCbuV?=
 =?us-ascii?Q?VjZzBrqIw0VUyrjzfe0zpoi4Jup4sebR0mxfvMEmsk5+Abc4mhBk2Jk7cGZh?=
 =?us-ascii?Q?gMtBjedF9i3wZdBPOZp/WYmDVM4IS+AvuZJ9p/MKHtIdeJEhg/0KXm6xCgoJ?=
 =?us-ascii?Q?PaesujnDu+lxtUSAngmS1BGvbYYbG8aCK7Z/zlZfPXCKSrNjWI9yFFMo9wSP?=
 =?us-ascii?Q?JvQf1vU6q9bw0iHKb7AVuwNjLWJcw/Wao2hGgk5sCnSAPYV/fCqW1ArjR+UJ?=
 =?us-ascii?Q?/d0r7Q4FOSQ5fcfObixQ8PCvXi8sd65jDxp36J2FEwl1L918Kk0bQW0sf1Ho?=
 =?us-ascii?Q?5DbJJRqJmkWMA+XjG8kA869uM9BVm2pLOZOfMJ3N8H8Nc/jT2sAWqkH0nDeQ?=
 =?us-ascii?Q?ch9+ri6dz2tu9cNd+paM/vdtYv68RcfKoVVQX5ftXEfoJa/YfATU3eq0zxd2?=
 =?us-ascii?Q?bNtN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D64498AE356FF04A81095831B7C59832@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d75312-7f53-4490-4238-08d8bc9040f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 15:38:22.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tv9cG7SS4ZR1ekDVE0/if8cN3MVNY93iW7Y3xeEC0h5VNWC0+In1ptH1x10FNeByqsUzvH68mQVRZZFES//jIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3558
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=945 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190094
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit a0d54b4f5b219fb31f0776e9f53aa137e78ae431=
:

  Merge tag 'trace-v5.11-rc2' of git://git.kernel.org/pub/scm/linux/kernel/=
git/rostedt/linux-trace (2021-01-11 14:37:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
1-2

for you to fetch changes up to 5f39d2713bd80e8a3e6d9299930aec8844872c0e:

  SUNRPC: Move the svc_xdr_recvfrom tracepoint again (2021-01-13 09:13:20 -=
0500)

----------------------------------------------------------------
Fixes:

- Avoid exposing parent of root directory in NFSv3 READDIRPLUS results
- Fix a tracepoint change that went in the initial 5.11 merge

----------------------------------------------------------------
Chuck Lever (1):
      SUNRPC: Move the svc_xdr_recvfrom tracepoint again

J. Bruce Fields (1):
      nfsd4: readdirplus shouldn't return parent of export

 fs/nfsd/nfs3xdr.c             |  7 ++++++-
 include/trace/events/sunrpc.h | 61 +++++++++++++++++++++++++++++++++++++++=
+++++++++++++++-------
 net/sunrpc/svc_xprt.c         |  4 ++--

