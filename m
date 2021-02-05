Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ECC310E24
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 17:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhBEPJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 10:09:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51264 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhBEPFW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Feb 2021 10:05:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115GZR9M167651;
        Fri, 5 Feb 2021 16:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=omXkBepfcJ7H8QHeNHOqUEr2Wm9yK30mjahhqCKMHqQ=;
 b=RDSCkjEzH1LhTQUH/h33p7W3RvujRJ4B4dwiNILfi8M5auzjkxRH8zvtRlplKDHaGtuY
 DWjbpiSpTgDJnKz5SC8wUaRLeFnyJEWS8Ng7AE2+00YMJaIDgPK9nTkoFyCsASXbjoOj
 qt4vxbZrwZTKXqzlko5BoNr74KNcUic92zsUwBjb6C/0t5r2H98u+0QIC7Pptj1ClaN2
 CyHVHY9w8Sjwq0nVIRTcbMjWMTMynjb2kbmVqoOCOsdhotxhxbj387YrBCChX4mXcic6
 gCzBsfBBT37UGCPKONAV1ZKqph4syOL9Smy2QDisQcJvn6yv3T7wg8LnaVUP6rIKjJoX sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydmabaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 16:42:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115GZPAg120987;
        Fri, 5 Feb 2021 16:42:50 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by aserp3020.oracle.com with ESMTP id 36dhc4dhsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 16:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9j1NzMhk2eVl547DobUiITgdE44zKWnocG6ddxq1JeTiBN5lmWaJd5/Cba1PX3Hl/+KOuuXTbNV3P/C+jV/oyt2GUcwHJ6NKPlYzE4BhoBjkpulDt3NPRTo6OqS6zedgiXvawL4XYBp6H56p6ri6O5Dw1zZN3a4F7FKBM8J8MAprA6swSBex7H1Lg/F3twFBxrQoyt/6WobDNvi8Y8IUjjm98Bvs3G6zbPK/Xa+8PKYXYd/uBhRhC4VRK7ryCYgf3xMrSqd+q3QhMb7gsqwArkn3D2bQbQYKY5DYq4Bc7CBYPqwFMGDMYjmfEySGcXSCK0MxH2pj9fC6T75oYQbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omXkBepfcJ7H8QHeNHOqUEr2Wm9yK30mjahhqCKMHqQ=;
 b=nPxwM00F6YgShNHC+k49525WcAjhjb9+Whwjw6VhoJNcbgOcdRnN3EUGpZ9I+n+MWcUzUrIitHowHiNQC++0SjOan+IrC5mj2O8SybcBf1jwS1IDJ3TD9KfOV1CoFmUmkbKGZl16v+L82Ln+HzIB+3SjVAIQDi4TMb3T7utgsg3lJ20FYHIX7DC4UIfjF1WWKLwkST+IqdjKIyywK1wWvlLMu4mCMhIPgBwAfeHSyN07hx5t2qR5K4m2dsdeVJKnuzLKkxdDHJlXpoAB4sJ6/OiEQ/KuDAM7UoNsMbZc8mL9YaMyKB6NRkw6o8lVRMHNWeS6EY4vhfTIHoI67HOD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omXkBepfcJ7H8QHeNHOqUEr2Wm9yK30mjahhqCKMHqQ=;
 b=Z2KXq1CprlcCy/WfTb4i3TSclN19sOObJLZ8ryNIlSkwmZJOKGtmQ+mfpDOrvkduST0+aAh4gZA3RgoZ1wAFcbdGGuKFa//TwUZ3ejbgAavCIkfBk3KaJtGD1e7sRj9NhfpwGr7xAxnU8UvHSEthRfv4UoqQmGw0kuu0s3U6OJo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4036.namprd10.prod.outlook.com (2603:10b6:a03:1b0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 5 Feb
 2021 16:42:48 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3825.024; Fri, 5 Feb 2021
 16:42:48 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [GIT PULL] nfsd changes for 5.11-rc (third round)
Thread-Topic: [GIT PULL] nfsd changes for 5.11-rc (third round)
Thread-Index: AQHW+93vC7TFFB+bRkKFEe0/y/N08g==
Date:   Fri, 5 Feb 2021 16:42:48 +0000
Message-ID: <13567C92-64A5-4165-909A-2CD199285C7B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8a5d3db-2d0e-470a-4ea8-08d8c9f51247
x-ms-traffictypediagnostic: BY5PR10MB4036:
x-microsoft-antispam-prvs: <BY5PR10MB40369FE2BF4C0FB8C12973ED93B29@BY5PR10MB4036.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9X5hm4XTWjyJC2VdiM9l2j4DozVYbB6W8t2C5zfryzoTg1LaQAoiACu4KO5Bu05Iq5gqrtQcb752lYz6xhIm0lINp7uLfqUj4RjQzFmVZM3dO/amJbsQp2M+p5YOrAx7xNv+TA5qm621iE+VfcadDS9Sff8s+Ccc6eKuy1dXD+CdeK4r5S5PHtT/02A6xje/5uv+zq+52ACI7jEwd9TihY0DqUWTSUIbo0IXwsj0fOdzshzcTzzclbtQxAfH6tJAC9j7zZ8+v8RJLf6VZGCs1/lUuoT5MpbQoDqFymocvbQ/I8FidoLeAUahIhS4O/R+zyy6ZrQiJjRxKvcPEUutZZyau3X3p34yDu3bolOLJHv017ocOnWs5GSoxIHniyLas0NmIh5R7TM/wTqf3TUj710F02KJ3R6irAPkO7FxpXukc/Pzst2D7eXC/kT8tzQDamotY1mov5R2wtEasu+G+S86arZEoI80u5rBE0SupgXoa2UiD6bTGdst9yaokjHiLTW1DkgOGr5mSX4VmPdsOwh4RTKisDeWMfZ8YOqrImUzBbt3K2A0Sb0twfrZBN+ePwLmHkmc9q73llLJXlLKvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(83380400001)(33656002)(186003)(6512007)(4744005)(44832011)(66476007)(66946007)(71200400001)(66556008)(2616005)(6506007)(478600001)(4326008)(6486002)(6916009)(54906003)(76116006)(66446008)(64756008)(316002)(8936002)(26005)(8676002)(86362001)(91956017)(5660300002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aL5KXfdQ5UamXO3kPnQFqtLOttI/UD/kIUM1KhYd6R0/nnmR0ACOY8L9K+tF?=
 =?us-ascii?Q?bBn+7nYCQs8Aobj1jLJMo33hRCzoUfR1bRoyKU6NAFpuHdS1nfvFaM47iZfg?=
 =?us-ascii?Q?uuxqBiT6Ugt4HmIsSUtfiSyOVcT8hNhzosZ0BfvLTgdEubIKErO0xWql5DuA?=
 =?us-ascii?Q?2bf3zv951ciW+LcSQgUpTL0AMCfYBcrSE5UtYhL2uoRV0MGS9FXBn25IdJkd?=
 =?us-ascii?Q?EAW/ahOAAFO3YOFt+1UimX2Di+oEkc+YOBq8n/Y4jGpQWS68JQim+FKaZToJ?=
 =?us-ascii?Q?74Wn4X+ZcOpgvqltAQOff3/BLuYQbCxhd8tGVD3WG23wFGvW+IYFAJ3MGB/9?=
 =?us-ascii?Q?Iwo+ZYMO23iI0hrZuHJKqZvxRRNr8Nu94TI7howEgN9lu49wrDwnMeSG0B0F?=
 =?us-ascii?Q?kSDBF9NfJH1wQ6W/1y8oWcCQIAy4IR9aRrbmkWH/qJWAyjIdQuE4yjE6HPA6?=
 =?us-ascii?Q?ZIFUkcyhX6wJKZbJt/7WodnQkxAqGCQf76m05uuU3RNjXMhrb0eIGAQMcwpO?=
 =?us-ascii?Q?AoTr1NX+zIEdcSQNqy8dqPRZ6STsrWhp+Man6Y00fTQ0R8ByraNpuUe+MVac?=
 =?us-ascii?Q?M/wZwJwdUAgxqkfYvYYq9nnPGuErWTDJ/BuuhqiAAFE8IxJJ0CmVVVcuACYk?=
 =?us-ascii?Q?711NlTZze/CG1utaRxX0DB14o+fDqSmkqMeFEJslRDixd1RpZcDMMFfrLcVJ?=
 =?us-ascii?Q?ECtVF5myx2D/rOUQm2uarf7RLQwRBNqzJ39j+Y3Fb0uDFfyXzeLDp9q4Ay4G?=
 =?us-ascii?Q?7Zuh+TWhXPNsaeAi3ib93vg8yS+EZ2ottH7RIUVypDOVmxtMHhVbq9H0R2Gc?=
 =?us-ascii?Q?C2v9RrYYlPiycEhIoq3R17/V4P5DLgIUVpsPizQODB4fKpK23jQGciAajkV6?=
 =?us-ascii?Q?BlLcyyubYKQHNGPO8Nz2pvn99UlK/nKVLV3bZlQiynzBOCRQaOTpH4XeaDtU?=
 =?us-ascii?Q?24YuVqno/4UwXmPVz9W/Y44zaGJhALT3ZXtH9cE05ukDXMgwnd0YrvIv+BE3?=
 =?us-ascii?Q?tao3f2ZM52Yv2HRFXgzReWD3LAuV91jVBGUxHgmLOYruof/5zO+1drKJsE7q?=
 =?us-ascii?Q?hlktmu7ZH0M52TjffwX1GbIpuDnSHN0myPm7aqbF1Nj/G5QnZgbqXfQRksyl?=
 =?us-ascii?Q?I12ZOiHzMVbnfF+XJyZvmp4XvyefKHDdgbowqljuTQSkAOjefBsMMNpukbbH?=
 =?us-ascii?Q?YqC4yFtex+cHptyuZ3jiYnMrm0WCv3w4FTORVChK/o/LdL6TWHa7Xal2BnKJ?=
 =?us-ascii?Q?ktD/nV4xVaYyxpQm+n6BvtGx71HUItiyI0PF/ZhSc9FF76wim0sT8lleZUxR?=
 =?us-ascii?Q?fixTOYuqnNIBRVd9ZVdGG5c3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEDD048A1314654AB5ABD5ADA2D9D82F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a5d3db-2d0e-470a-4ea8-08d8c9f51247
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 16:42:48.2882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Te0n1JAWl6dfnWUgKvZQc8dy4oyyhG8yMCtGLzjtTCVl4I4FjoYRQpjyrK3jqA0EqPNHuvm/0uAS6GrpvCQ1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4036
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac=
:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
1-3

for you to fetch changes up to bad4c6eb5eaa8300e065bd4426727db5141d687d:

  SUNRPC: Fix NFS READs that start at non-page-aligned offsets (2021-02-01 =
10:03:51 -0500)

----------------------------------------------------------------
Fixes:

- Fix non-page-aligned NFS READs

----------------------------------------------------------------
Chuck Lever (1):
      SUNRPC: Fix NFS READs that start at non-page-aligned offsets

 net/sunrpc/svcsock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--
Chuck Lever



