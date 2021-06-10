Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD623A2D22
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFJNgw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 09:36:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50154 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230396AbhFJNgv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 09:36:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ADWgns022846;
        Thu, 10 Jun 2021 13:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KRVsZg45Viel10ccWBLI2h/k4bEjH2dH+cM9o/Z+1Bs=;
 b=N/ATIACMR9UMgxQUvNAsAxQq1U38nxoXpNtO2VJtu+81Gkk05TbZylJOAgO821AilqC7
 cDKsBvlx+BqPcENWHfDvSkivXVeqlSLnIlmKPPiPVXcs57sgNnVCVesbSgIzOFOpyhzI
 PkzEWbglNFfndCZqGK1rMODHlNDDhsKHN0xuGLvQknZQg9z1q2KaehLOMfUDqeIUFHiJ
 XA4V3VVo6ZuMegLVEf0XEuCqUCJ5jSZzqCllWcpRXJ31p2CuP6tlR6ek26gJrvMSF4vh
 kzujNKXxbvxBHSD75Dm+Su2NfXy6Dzy1AZ9BfQk0TiOuRLyV49xWCtq/e+dZYegcQ8Qs Pw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3930d50cun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 13:34:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15ADYoqm045925;
        Thu, 10 Jun 2021 13:34:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 38yxcwn80t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 13:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkXVzO4V2ITV6n+sM4ej+TrPcRlKoqBtLrgUxQyzp2Nx0u1NhNN86YrNQ+O8n0s9h3SSpzI7tnIZrl50ko9WP58bGG3W7kPV/qwmGhK/ZM6EPFPAlBKiskxYW8Tj66+lYI35tIV/sFVu9a9VFKmqHVh7Z2Hvl9vGIEfRXAxcyVdaFfu6eRaiNC8V44skYTcOT+GHL0NjIBuFIZ9IX/vTaQLjSUl50IZsqm9GiHTlb/jEc7xihkOSvA3WhWUXwOSSniIuJ6oTQ6vWlC5Ajumt7lwgy4Gl7HqEehnJl9+4fAj8UzdMsYqF5l3wWSxDGnrcZDrxzcQxJgU6QkeTsgN6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRVsZg45Viel10ccWBLI2h/k4bEjH2dH+cM9o/Z+1Bs=;
 b=K+EZqQUq4GYzcONatZyWF1z3WYT4AN3E/4ay5W3d1mWfpSG6qDPdBFa8S3Fj4YaINHwP3RPjT6h5eGHvtK7yx7FV9mEbeImNIAiy+jJolQKec3voOMVau+axokZYjEnhf2eIDxLj4wyjKpmSKZGt4oxa4+jN49U7XjKk8chJ/o+JrhVhVVym6VystHBTuywrrZAW1R88BWdcXedhB9cf1qa9y/5WlvSp65TIfzGoMMFjYfVCHCavHXnrIxFwmWR2LJSh5AhYDhZHTNl0BvBi2TOuS8gLiWKLwuigMI+f1BHBeLMVAGAVR+HWTaK9rcWYD8YCm4yrv3PaMc7lJuykhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRVsZg45Viel10ccWBLI2h/k4bEjH2dH+cM9o/Z+1Bs=;
 b=DzcKAJyZG/nDhU9kM9rV4z39AjMQPrlqGWYS1KP2cMaVevQRiYj+Ic9HgZG78qhCVwK4tYcEENENfPSyfL+iQbaV+2BF2kkvWP7f/m26EJ31xwNqeeg+FWDv1Oa1en3Ygpes1UGgs0FAAEbxF7CIl47nwoasp1Ez+Rx4KJONrdU=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR10MB1405.namprd10.prod.outlook.com (2603:10b6:300:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 13:34:48 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 13:34:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] SUNRPC query xprt switch for number of active
 transports
Thread-Topic: [PATCH v2 1/3] SUNRPC query xprt switch for number of active
 transports
Thread-Index: AQHXXXnxzB7zpMPkhEi1mNscPMhCzasNP86A
Date:   Thu, 10 Jun 2021 13:34:48 +0000
Message-ID: <91214898-F21A-4604-9FCB-9E9884F177B3@oracle.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20210609215319.5518-2-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1b8489b-4994-4642-e0d9-08d92c1484a3
x-ms-traffictypediagnostic: MWHPR10MB1405:
x-microsoft-antispam-prvs: <MWHPR10MB1405439F2FAF598684C170D093359@MWHPR10MB1405.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2K5QGY5HNOSUob+09o1KVSFkzXpYwvBU8Ikt5Z/GveMetsJcYScnmUQIuCkHj/UvvbKHAYasDrCYKt2CQO41ZoUiC/F6k8ZvPxO90NMf8V44pFT0aKhtQe0IgQOD4tUDqA1mhQPC3qtKd91LrhP5K1KzT/INlNr0nBkjRP3RUQJX7WzYPjNT8ouOpsCOjxGf79h62YGhPvAtnSvooQp3Nyt+pPJBlP1NsIlDxKrmUxgN+3nWFx6Ucc1L/hhA6TZ+mvJ1Ps35A1Lrv+N3OMg/Lolhr5EkDZ+COmJkpHmEJRmg40VI60asP6Tz4e+bWYmtLQWcBg7cHjJj8QR682em4vWjB5EE7IsWWJODHd2ehvxke2fS5Inzpf800bJj5UQhMlfWij+NaqSzyIhJN0Sj0HPnqIc28hooP0lqJshLOp9Dbey7GLdMsHg9lUWD0WZrxRDtzmA73y5tRRqhv5j/mXydfExeseUFAyAqBTpLd0ebLbcYb+v1RF3+l+SaZ7k0mvmlF1fvRi44HWvl6NxA38jrrta4YxnIOo7Zmw0aPdsDwSZAThA+/VfobNKorKRKAoh3dTqBcDXkqWP7+bmgLkXebwR7FSu1q6tZIuJ5EGLQWtWvMvHhjYvrQUv6rmjoYPGyV+udJxQfQ50ezG//ZEPLYG9Wv8j0KDLlkcNJcR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(366004)(396003)(6486002)(6512007)(316002)(83380400001)(91956017)(6916009)(66476007)(2906002)(66946007)(76116006)(5660300002)(54906003)(478600001)(2616005)(86362001)(8936002)(122000001)(33656002)(6506007)(36756003)(66556008)(26005)(64756008)(66446008)(53546011)(38100700002)(8676002)(71200400001)(4326008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Sv5YlRRPiLYYCVuTLizMCJ9KIZaVgeR6srci5qIIugVdgPvcx9N5/UDyXOh?=
 =?us-ascii?Q?w85pm/1UYchqA62d3wOFawiIxdRE9UcFXmLCSQxDsBR5DQerR+Fb0csiajWy?=
 =?us-ascii?Q?/5LSQV6ha4LtZhIMbscvQ6lNuHaftQPODMunIoBaU6TpxdHmLYf+o+5vhUsO?=
 =?us-ascii?Q?yBZpRRFCG20cXZ4gDuKOpL5rAoxhvJUQBO+ZVb8aVdBoDlprZFiUXbOAS9um?=
 =?us-ascii?Q?JLmV/gNFk+hz2QrFrC5KcYzj7Ia58V0i3Ykf0XBy9GQ12iWMonA2HmZUxddv?=
 =?us-ascii?Q?eEutMZWA7aIw4sv+z95Wjyqszkf07h7HFsnD/53/+O3v7y0IwPtoCy6rZISP?=
 =?us-ascii?Q?Iwl43maV9srjbfHVqy52mJq0iSYJCQnc14h9/J7vMo10I4xgn8aoHL+vos7Q?=
 =?us-ascii?Q?OB0ls4J4Q95B6NmWN2wfYtemKBlsNNZN48V3akwVjnlnin2lN14PX/Q+25r4?=
 =?us-ascii?Q?SldVEtJ23PSKtyPCewKN0aTD0kXSy0aN5l8W2hloge5hk4KFhBN3ZsE+0xyX?=
 =?us-ascii?Q?rjJekhzQk8srbztNYe6OHGgGMDZlC4eFE1lrlDLq7/QYDqkhKw2pkyBaUjyW?=
 =?us-ascii?Q?nfLVeyPQ2srtymwFw5Qqyhrc2ycdf8ca4jMft8/EtONH10VRDzk0LA+M7lJx?=
 =?us-ascii?Q?rPFXfgxIdljGj2Q6eZ4fWwVX9pwNhcWy52rMr6isIm53uqf/Jhz2P9juewIw?=
 =?us-ascii?Q?lA9mRa+0CKQ1U8wA7Vx2axK8+9EiL8f88tta07ieL770jBAiqZlFeES2f9Vq?=
 =?us-ascii?Q?YgSGMBu2bpto5ybuO423Zvvx1fxU00VIPV9XUDsssXjgAi364WmJEevSy6Nm?=
 =?us-ascii?Q?zvOfBwyfMcrrIQGVoF3WEu7oA6NI48dRVFcCDWfyMibf15j/EWI8ZuJqDcRb?=
 =?us-ascii?Q?HdivfbZ+tM40rbGMn9fqkPneByFFlXxzln1q7hKgarBR9voM0nCz52Sf5eIt?=
 =?us-ascii?Q?zj5BN5lICJKz885nxvD9n4+qU32KYU7NHM7GxW0RTG4x8SG/oyat0gpYgrNU?=
 =?us-ascii?Q?X4LkUnLmsZcKF2TCa7kFs7BNwmIPwPCSnzI9WNGdMgr6DCpsM2+B3E9q97vF?=
 =?us-ascii?Q?RboApNOamWf5ywZR7La5A99RjIO5dKr4S1wisi7CswVx/ehTjmxjI+5OGW3j?=
 =?us-ascii?Q?sWRJoE4IlPzqhglK7LLEZri9Qfhj+TBXKwDLJrORej2BFqRRGIPc2aAOSjSI?=
 =?us-ascii?Q?sXYVCuB3aF7u6aDndmPwIs9RJMcMtEeEITtdY6Qoctp0nHK9aIVmD+RNdpBh?=
 =?us-ascii?Q?TI+OzJMXkHRxPAnSkE8GE9yhLvQZop711WIzkX+3MTMIoKLgT0fBll3pSKe2?=
 =?us-ascii?Q?TgTWoPLXk1gkHyabuu0aa8wj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3200D8A38D5472489F6459B3F98D0115@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b8489b-4994-4642-e0d9-08d92c1484a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 13:34:48.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLh+iXUS+IwEBOMCoicTt7hooHPvc1aQ9Ad+7qwFCRiYgwdvT0KI8K03EEq6jPkqClxBMzDLdOw8ukIZd0cYiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1405
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100087
X-Proofpoint-ORIG-GUID: c-g6DKXkBIqkprLOzbxjCOcPPwQOK5Su
X-Proofpoint-GUID: c-g6DKXkBIqkprLOzbxjCOcPPwQOK5Su
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <olga.kornievskaia@gmail.co=
m> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> To keep track of how many transports have already been added, add
> ability to query the number.

Just a random thought: Would it make more sense to plug the
maximum allowed transports value into the struct rpc_clnt,
and then rpc_clnt_test_and_add_xprt() could prevent the
addition of the new xprt if the maximum would be exceeded?


> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> include/linux/sunrpc/clnt.h |  2 ++
> net/sunrpc/clnt.c           | 13 +++++++++++++
> 2 files changed, 15 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 02e7a5863d28..27042f1e581f 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -234,6 +234,8 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
> void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
> bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
> 			const struct sockaddr *sap);
> +size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *);
> +
> void rpc_cleanup_clids(void);
>=20
> static inline int rpc_reply_expected(struct rpc_task *task)
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 42623d6b8f0e..b46262ffcf72 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2959,6 +2959,19 @@ bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt=
 *clnt,
> }
> EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_has_addr);
>=20
> +size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *clnt)
> +{
> +	struct rpc_xprt_switch *xps;
> +	size_t num;
> +
> +	rcu_read_lock();
> +	xps =3D rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
> +	num =3D xps->xps_nactive;
> +	rcu_read_unlock();
> +	return num;
> +}
> +EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_nactive);
> +
> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> static void rpc_show_header(void)
> {
> --=20
> 2.27.0
>=20

--
Chuck Lever



