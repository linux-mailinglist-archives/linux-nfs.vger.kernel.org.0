Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5C3D4233
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jul 2021 23:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhGWUu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jul 2021 16:50:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231724AbhGWUu4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jul 2021 16:50:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NLHBZ5018769;
        Fri, 23 Jul 2021 21:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PXPkHfXvoIBF31+BDgm/nB/JrJN1V4i4mDIWN+6hjd4=;
 b=usIouHdekR5bJNK0NaHTTHEzaLnZ1XQsmQOp25T4pOK2xMcIsPIMgmacsCqNSkS+rFjw
 4LXnXUmbld4v0AnLhTtLSAYx5HT0raNs8kzu2bnqQF4ZWl+5BuBQbzOZtb6RBh/O0YQW
 U3DOeGTGRKTkHAfP0WCMLFpl+BPPIfMG33K0EamVufg2kzasSP6TiBYfFh2AHwdLVqEe
 3i6bylfKGpB7Z3Ktldqd8CFmzRwvAU2pxrV2lFU1AXF278FqGZsJZXxuzGc0DZP01dDo
 TnQPjm4QEyjIyPFMsyKT9sdLRFch9fWKnwS6ayESDIKUux3+t2RPK+I1Q3ThFsnLxhNI fw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PXPkHfXvoIBF31+BDgm/nB/JrJN1V4i4mDIWN+6hjd4=;
 b=G6Pwhex2pgns32SX231YuS+LSUgv3q5zlRH33V9DN4q/zTaaz969kVLWuwIEjDmzsQ88
 60NLAg/FyrfeJ+08pvagztc2LSQ6tHLQiryftmNVrMvizzdEG3ic5kJf+dLGmpDv5C6I
 ONXYUMm6o4Mniv9uKb0STCcqppAN7fD5Ek636vDwXnY4JpfXYGCQlyEh4saenBpka3CE
 oM1jypECrLRA70IWnkmPIhz3tmfUp38KHLlds32h9fu80LPEjYnXAHqFvJKv5D/0pr+/
 2f6KJy3vUiRpRthXh5FQT9ckYmKbsW+DSzMeEYk1PgtR/tcNDAi80L3rxeCBkVA5Y3Sl +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39yj7fj5d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 21:31:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16NLGdZm010938;
        Fri, 23 Jul 2021 21:31:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3a04yu9x99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 21:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSRiWygavhSAs1fBX0gdH/cI7AXbtRBuDhKDXR6DfY50xtjcmKCmArQJ1DWVRCW/Tt/8POtZjvNAKrDBmXDWexcR7eQN8zTme1qMdbrDuteLi7FZra2xw5OCq4KVQpQkpIbHSYr5rHocKIXd93AoUj/vRIY5zn+DsMDrHvaB020inu1iKkpdLrjnD9mFtme1CJUPbT9XFw/uHWMj1ZGp3nikU7oX89tilayozeHGlu/JgNKYOSBqnS59r9K/E0v7yoNI3P0SUPfQby8lXqiep2jkpBISUPWlLT/TS6kA/omlBavKwab4AGnViq0+ut5m13dbjcK3KtrUc1MLyXLFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXPkHfXvoIBF31+BDgm/nB/JrJN1V4i4mDIWN+6hjd4=;
 b=T5reEUram7HSq/dkcTaMGXrv45+onDRF5NUXZpNzyjhlSUOZDBnfHU0arsDNBZowEW+92z7RTO5vFu6bbbqBejv7sS+o/MNiY9q661njitv2X4tdCpYq2GW5y+7HnDmDSoKQOY7JaTNdzSvrcvdxvkTn9FHF4rWYYS2Hm4uc2dLoEHGH3abKFYTMq+u5ImMlsFi81f+daSP4rb9tBRfsaUaahWmUQEa2UO/fox0Jnw6OmByLgnQCroEAgX710WVLVAWRv5Q0K1ltgklwgWB9lOCS2munLO8PrwVahT54PMsZltnLnb3AT3CqwVcXGgjy2S4bpnQ4gB0OO3VjzqEjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXPkHfXvoIBF31+BDgm/nB/JrJN1V4i4mDIWN+6hjd4=;
 b=XOU9Qt0vpZDAVLWfWiFDNymze7IsKbb2oc58k8JmzSWYAgLHKqulWBm6/72TxuI/PjuqV/eSV4XYfiZHnY/h7d1b6PRj9rLUIMJZ71ccEkQnHXLStrq0eqPpO2HJ4ZXfA9IWAoD6ZbDIn3WeuD1+ViKP6Km9MEAig7mGdPF3M+Q=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3718.namprd10.prod.outlook.com (2603:10b6:a03:126::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 23 Jul
 2021 21:31:20 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 21:31:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: recent intermittent fsx-related failures
Thread-Topic: recent intermittent fsx-related failures
Thread-Index: AQHXf/8fslPfHYBEJkGXNGWvoY4o9atRAYKAgAASpoA=
Date:   Fri, 23 Jul 2021 21:31:20 +0000
Message-ID: <36417C84-FE59-484F-859D-3445F53CC0D7@oracle.com>
References: <67E1CF9F-61C5-4BB9-97FE-61B598EFC382@oracle.com>
 <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
In-Reply-To: <2e8bce7bc15b02bbd1dcf740f2d993d6e3d58367.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6228c850-f1c8-431b-3001-08d94e213691
x-ms-traffictypediagnostic: BYAPR10MB3718:
x-microsoft-antispam-prvs: <BYAPR10MB3718A032ADFD5ED2D59B7DF393E59@BYAPR10MB3718.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2d/8AkYk/38pKHXpidbzvEJ38q+LT2gOMx7OMUazrcdu2Q/pPV8KYdMEdCZ7CTNda5H43fCa+EOP2obiUdbNor3HvAK2KM5yjqU467KVG3IVsfKnv09b9Q4uiZ9tS4o/i+9gSb5GuustcGTvGWb0juhs6TwL5PR7pWPzU+f3yLMkRjK4OJQbH62ZIl9nJ3Biyt39kYrjPLNuUo86/M9IpYlVEWqVBnGOCTvhtE+X0ThrObiOOoheFyfw93hAWzxjgUYU+QYHcInaZohj1dJdv1juTxRdqVrXzCpieQnxxrcJyOgCLyOZRsBsa5F2SLHUtivpxsyzA0or0DORPRnVPkoN2xIBNuqGlV0jiXcwA4uEN/FsViC21/qNBbkjT7wKFELwCkXJin+RE5EuvH9FHvWUwjAYPbK2ejLU9nmyU8kpt4WdpkjvmPcecVrTD1kEtykz8H03ihugPqmuh7muGMbQap/4TRBuGasKfQcYOCR8wssqnaJL+ThezNMSbCB5lYhMZy/P71iM4RwOBtwnKNOwIh3BA3OW0yzLIqqfB3vczy7efWwRRWV/8PKQZ9H2a07sXFF6RQ29VAS7Fqj5AbYCsQORS/0yiD8Hj2kcgZ8gdp4nbTeIxqSqnF8RxbBSTbMPiLb+e4/IZEA6cN5hOPHsQpZpJ0DZCSXeLuwS4uAUJxY7rJRdxJRLq0t1r8e2Cr2Y6DNB7Qx9LLPvtgsv51IL2hBpLiaHMzZM/0tTA406xsLehrxcR9nFaE+bLF1V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(3480700007)(64756008)(83380400001)(4744005)(86362001)(122000001)(8936002)(478600001)(26005)(2616005)(38100700002)(5660300002)(4326008)(186003)(66476007)(6486002)(33656002)(91956017)(6512007)(71200400001)(8676002)(66556008)(36756003)(6916009)(53546011)(316002)(76116006)(2906002)(66446008)(6506007)(66946007)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?65F1kb0iKeaQ3a3OVJ+APtFtFVa9jbs9oYPCaTSDdTocx6b87w2/kx6RgDNe?=
 =?us-ascii?Q?WHmdERasr63iek2aovmq0R+XwIr047dFVFj6QPEghpXMsXxXx7ZSaAKm7wFV?=
 =?us-ascii?Q?b/8iatwMQ0efneA3UhYBXCLUL++T021MUuIu8HhQoHLtbs5zdIhKGXaPs4Rc?=
 =?us-ascii?Q?8H4ybLInra6b1a7ULpAyYxj1DtcnpGUHbcE79q4DGKUQwD9dEmx4atT1JoIS?=
 =?us-ascii?Q?KNrIn66X/cwABTvdiFROaLIs3sYGH3s2Dhq7+YJ+aAsfL2HNc3AhrfmhHOl/?=
 =?us-ascii?Q?hq71tEkr2DnKvwV29PzmAuR85smSAYWIA7tlrG/0QADFUenn/Fo+TaNQ+80t?=
 =?us-ascii?Q?wU9Z4CP35Nr/9pJ7iQA8Z37C0JH6GSmPsL+N1kdvhSA3pkYPUq+xQiH7w17Y?=
 =?us-ascii?Q?73szdZ304uHhL1699NuwwKXme/fR/FQ9SITS5sz8Ek53XFjEAw6dSxOBFLME?=
 =?us-ascii?Q?bEB55YIXEE0TNBF1HMioBKVeYRBDpFX1+uHI73nwM9LNxWafkoIN1VijvBNn?=
 =?us-ascii?Q?uzHhvhw3EWcIL00xoMzAiiLXWERoDZLWbmkHX5SZzN4cLrEv5BrdsAEuxqKw?=
 =?us-ascii?Q?0gMZIUX2tShiGO/ik3QXVqFbh35Naq6FE8iqSo1q23VnP5W+3LM7PCZYyCqA?=
 =?us-ascii?Q?Gn7ZmqNTOoJ/ejWnadmKkBGP/4W9slCOjlo+ZUuWy9mUistYVu5QUyo1QcZ4?=
 =?us-ascii?Q?RgbxuwLfjFkzkH8YFHJlO9PeSwlZSTlJBlDsQ3FuVAAZHW992DT7IS23vUc4?=
 =?us-ascii?Q?mQPW5BLjDRRrcevbp0fyCDFoKt3KEMvbM96tU4rCdeLdGpOTXTnRN7iNWAhM?=
 =?us-ascii?Q?1XFrwPgE95V+DJ/EFxjTxDDMGG1e7xWUiyYodTpju3QupHpU020MDDzbrMx3?=
 =?us-ascii?Q?CPtJ4dgmS55adwVZzObHzTN9LiP46MROtQXb4EjNc6WFCjuczNDTHPP7bjCR?=
 =?us-ascii?Q?qaxlgSK5pH+QEX+SccEyEL4nFuxz4cgWwc1wh+SL1HxcyMxLsW3maVSD7ttP?=
 =?us-ascii?Q?B+T8UOzb6Xb51Dud7TGhqMndBb9F1hO52qySXk1h4bjoTbJB91Slq60JiXoy?=
 =?us-ascii?Q?/IS+hPXa5rJWJsV17HYB/yaq84vQ6W2qAYF9L6KM2pcwpvEKd7jo6mv77NIV?=
 =?us-ascii?Q?qO9WVtmWI/AjVWXtKhSOLqigF/wCoVyP+QHMSTvE6NTSdXbNxeynfyv0cViF?=
 =?us-ascii?Q?MdgiyBdaoP0jSxu3hIcvf0ThBix3fcmlGWbEGRLO/PmKyk+SJ30Zu4hMc4dz?=
 =?us-ascii?Q?aQQZgtKoCv+JoV4o7TUdrYFjg2nQnMGiTIVR1MCfhi9rdU1SP1lXw+KpZIfQ?=
 =?us-ascii?Q?6HtebzPEQAmoPf/yTSbzl1kI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F886056C4B2A424C8C6EAF13CFE3A421@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228c850-f1c8-431b-3001-08d94e213691
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 21:31:20.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UE1HVPWZtBnF5M4HBjU18O84Er63NFX45Jc+IoMjK+xpaX21RHLoI5jp97ML4ZkYmV2LOXpuVwBDWUQYNTSRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3718
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10054 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230129
X-Proofpoint-ORIG-GUID: iH9EOHOnoVNnZvh2g-GL62Dz-GiZIHSc
X-Proofpoint-GUID: iH9EOHOnoVNnZvh2g-GL62Dz-GiZIHSc
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 23, 2021, at 4:24 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2021-07-23 at 20:12 +0000, Chuck Lever III wrote:
>> Hi-
>>=20
>> I noticed recently that generic/075, generic/112, and generic/127
>> were
>> failing intermittently on NFSv3 mounts. All three of these tests are
>> based on fsx.
>>=20
>> "git bisect" landed on this commit:
>>=20
>> 7b24dacf0840 ("NFS: Another inode revalidation improvement")
>>=20
>> After reverting 7b24dacf0840 on v5.14-rc1, I can no longer reproduce
>> the test failures.
>=20
> So you are seeing file metadata updates that end up not changing the
> ctime?

I haven't drilled that deeply into it yet.

Fwiw, the test runs against a tmpfs export.


--
Chuck Lever



