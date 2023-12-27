Return-Path: <linux-nfs+bounces-823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6881EFCB
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Dec 2023 16:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC4CB21413
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Dec 2023 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090045967;
	Wed, 27 Dec 2023 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="axOKTS2T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jw1d7JZC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E745961;
	Wed, 27 Dec 2023 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRAi9GZ013108;
	Wed, 27 Dec 2023 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=3gAPham7yKoef2CorylpEEEFBlveUtPkODbnL7mGGF4=;
 b=axOKTS2TxNUYK8jfJLV0Mx0H/aI+1qmr+oclBYWHdWld9uG704JI591kkBeH23clhSFN
 2/Rk3YMd6xe1Wx7IFQU4+5HEkPPM3EBCgcV1RQaNDOc44S7FVKjwEZK1cTz9UwCmSvuD
 2cQ6/DWd0kucyaP0TC5NWbxw9tXpwUrL2Zz+Lktq/jvKw/J4Cld+zdGZ3RvmIFU5DB+4
 P+DR0u1kLrV+ZayA8dQ2hlycFGo1NQVL6GV/75RdCnBYBLz68tFCnkZNkFX6tvhctqdr
 eNW6GuPyBCvcd9mBv2uqwQHpmTEh2CQ+pLuvbnCqWu6ROxmm+N6G+bHD1bdEPurnWCSV gA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5pb44wav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 15:36:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRFRqen010967;
	Wed, 27 Dec 2023 15:36:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0apxvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 15:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmfTAwI3yQfO8qMzwEWCqziA5fRvuvgjZS/dRo+OAU+QDQOgRsuSR627E+5hyx3aMJBT56Nlq/D27Iy2e89P+tgbcvE4xW07YlJerpO6l2rGL9/p6gL5daeZEA9969w1u/RbEM8EJ8SXHw6/lzj+elfAFYl9+Ph964KqXLlJ5k6bbGJu3A1BVnXtWbvq54tyKQV8z4TEG0T2XTXXYvVrwGDP1KvMsSZxwpF51sfQ67GPsUOWnbJ4irUF70cY3TKQYNQBgvwCdxalQ/SaiZkBx9uUCTUGttETWxqoSrMteUHsNp9ajES7gluxLxOw9a89jhfRyR0lUVDK2dZjCTCHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gAPham7yKoef2CorylpEEEFBlveUtPkODbnL7mGGF4=;
 b=SYQW1QserYkyFpKPHF+Wp6QN0vmG0gnSWj+WgcAw8Gu+DvpaDiPjwzVSI79m2FG8/XYe+Z9civwH96oytQRssrMAV4XqrtrKb1hWQkATTlmAipL6R9ncLWOtWykdpIyuTDo9zku1h9kN/LzEc44t/7ajMqBejbMgxhUHk5tqtDsRt74qQLsK/PwFbpNh9KxKGLaGNN4jKs3NjJZxXJnBJrL9MY184G6t3Z6lCxR1QHsb7vtheyboLk9eJE/GEYWxqhD41PFJnHcdvGk6edXu6VMx5Dn+rEWOZC6dpCSXN9DDmmitQSddrBlazIEPgcdypOrqUAATjFszv9ml21LgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gAPham7yKoef2CorylpEEEFBlveUtPkODbnL7mGGF4=;
 b=jw1d7JZCrNdH3NcuX+vhMeBT9T8ow24NFqepvTmbU6w0Qqon/Ekpc30jqU+0v3MPtw3QDJBLBq6dLV1IahfGrFTatvEQEXfl8f7aSRMIcAulSMVmkmGmGebVXFHeiodi8j3opdM8d5VjUt+bUi/eMmGaZoGZhiyQVQBBVPoltr8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 15:36:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 15:36:38 +0000
Date: Wed, 27 Dec 2023 10:36:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: alexious@zju.edu.cn
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simo Sorce <simo@redhat.com>,
        Steve Dickson <steved@redhat.com>, Kevin Coffman <kwc@citi.umich.edu>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: fix a memleak in gss_import_v2_context
Message-ID: <ZYxEg3g8NIwcDZWM@tissot.1015granger.net>
References: <20231224082035.3538560-1-alexious@zju.edu.cn>
 <ZYhivG2MxmtePvo3@tissot.1015granger.net>
 <45874bb1.58022.18ca55b2eab.Coremail.alexious@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45874bb1.58022.18ca55b2eab.Coremail.alexious@zju.edu.cn>
X-ClientProxiedBy: CH0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:610:11a::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: bd55c30a-fa3e-4716-a083-08dc06f19dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DpOZcWCq2zkuWYXcI7fhXOUo8nFJebUeNXjUaDZ1BM/7Hatb1FIi4TeE+EulqMQHQ6PDegbDI44pZA9XOi+uM+TL9BJTl7+WOgnqdjT9jFdAg69sN2x58M+17gQ8pfBAaHIvprz1wF9Ics4gAuVjRolG0QqxpJbejglaqbJBZv9KQPVOGtat+BQZ4U0GaRLGnI7gaSIhChDrRmKSTudy593hdr+c+u6FGHwkWkD3HUX1dUXnRhTYh+CIqUjaZeUbfBzd2i9vDTSIFsv2DfF3D8T+om0kpCkryPf0ZE9o1LhPcWzhmfB9b552+/iB8QVS8Xr1YAu/el3uv1O2kbzaobd2K3yIDSw2ac8nA1/hPo7FdLRoCbVuQpfI5U+hzrMAqaTjv6YrmQS7u49xLnIwFGOfYoTNemLcT5Kb1jPaua7oEAtoAoL0F5wryMuej/bzc2mPKQuz/d/8GR1xED6Rt3v5BaDZt/oa2MsphX8PEpyx/zDmmQ9ffFL6qucJzOad4z4WudVq9jJ7qqHot7Qqp5aiOOUdmPkNuZ5oroDxo1WEh5gYHDjwTLgVEpue1R6q
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66899024)(6916009)(6666004)(6512007)(6506007)(6486002)(66946007)(66556008)(66476007)(86362001)(9686003)(316002)(26005)(38100700002)(83380400001)(41300700001)(5660300002)(2906002)(7416002)(8936002)(478600001)(44832011)(4326008)(54906003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9r3BpIjHNN/34MwxMin1TdQgGVjw6hgwENMk0ttwJjwZyz4wC64wZRKSkO72?=
 =?us-ascii?Q?pllwKLoYoMempbu16gw4cYXPFgZSNeiL01h4Q1Z+fINfnXDVwJO01wwnHyNs?=
 =?us-ascii?Q?22OA8sD2Skk3gzoNdgXnZ/KR6fkHhagOrqieF8cBoxsLN77oMin5ah2xJkno?=
 =?us-ascii?Q?d9yS9fMYDhhGdY7ViVe5WvlFddS+CuGb8loRO7LD4zHuPZTXDAmS/k5q2MHO?=
 =?us-ascii?Q?bND2nKxCSYYFE3pzqOOyuj8Q2bGDMdlOXVlCC/XBYnP8mx4ufe/jvvK53yqb?=
 =?us-ascii?Q?nla0i3B9OHa8uojp3Ji5eGiu6+JZKClvOP2UPMxfDn6xdIgtXHOOz+h0S8kx?=
 =?us-ascii?Q?njY3k7sMYkoOivpgac0ieJaYIlaJ2IpfHRWXmNlz9Nm3fN+jU39lJo8irDsG?=
 =?us-ascii?Q?Pu7UsiynCLNSHhO9r5/nCK9Bl1t+oLK1W25M/WeP0JZ+JNPmdDOZfc3b3DxJ?=
 =?us-ascii?Q?wKUP+hVp1nZ4hhPY0qe+5UXBFfMkpDR9OCnbjFm/gkPT1+sXiBJehJCflImU?=
 =?us-ascii?Q?gf10jDmqv2wwq1EGHcSccQ9l27HC6n+L/hHP97O5ivJW51O4XpHkeXrtTgMf?=
 =?us-ascii?Q?H7fYlQqEopLQx+QbQ5K2ela343XKamt9tdnVbsLGfG5+y1QvOZeyeaSJ64FK?=
 =?us-ascii?Q?D9HBXh4+/6oXZ8eUkYDPtGznKrUUzjRJOpfnewzJCl3H3gugafDOb5AEtEz/?=
 =?us-ascii?Q?YuREWZ6J0cebTQMCdh3f8z6xJhm84KjsIrNXmEIP7+xSCM8zN/Xz8fHRYP/n?=
 =?us-ascii?Q?OQNQCZRUc+gIM/pmk40aowMhpnNDN7/HfxxUlgmMSpRxMQeICjm7DU/iOnTe?=
 =?us-ascii?Q?CKUHp/CunqQvo3piHTVsylg3nXRGvucEZWWLUkFGmYme7Y6HSgVx4eTwjd28?=
 =?us-ascii?Q?plBIUSOuuga0eyKdg9gSdSm1N3ir7mEqzZhW99OHKHksW9gKSfZHTfOtWIUb?=
 =?us-ascii?Q?l5FNBb0BU381kwwFK38b2MZ/5O3l6D7r0HN4OtVPWkxhAp+n0BlczUqLEDF/?=
 =?us-ascii?Q?GKVLKNxUnJpTCZhdYvlkGGQdAqoyCb1ZNkyrizVNQrNXgA1nf1r9FBUbc/nU?=
 =?us-ascii?Q?2uO7dq9JDjP1jWAq03BLn+rR/OLoBEzt2LzxbltGVHCQFyYsgsfmxI5heOp0?=
 =?us-ascii?Q?tIFzKtugFllWpPMZZWEzqpG85Dc8jb7N3JpYWl1o6Iktg5ggtB8CMRKg2lWN?=
 =?us-ascii?Q?Q9FAk95Yi3hhlz3Rs8js56SH6bK4h1Xjd6r/pYmYQ/8CkeTqJSgfQDA1FcjW?=
 =?us-ascii?Q?TgpzhE5MivF5kwIpJnuNH0AxUo67+4OQYdbMSQFz9/ijGL1DzLFpLIuVMGUk?=
 =?us-ascii?Q?ifkjSSpTY0PPSFy8ZC8oMme+I5+5NX6BWcIOr1QiROS/1yU/LORXISItyluX?=
 =?us-ascii?Q?T/+sYkAUdHhxa8ny7xirhxOMNcrwk/k9PZTdFSk2Nd3+v5dUtFgfJTUOUxBZ?=
 =?us-ascii?Q?O9OTEXDHe2eOovqYidJI44vkBKNl0pBa8tY/EMWEKNWnOJRQiMDn+ZLvSQ0r?=
 =?us-ascii?Q?5CaGFY5HvT7XwWhxPU3Rt2Fven4tDEUGItXvo9g7CtL0PoB2srox5sg7tgq4?=
 =?us-ascii?Q?iASVep76R4dvYpKuiUwctN3PF7xZkdbh4wNGZpZBT93nDl8sKxsd65jPa9vg?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yy9PmUw1b5nPTc1ncsPWcyk6T8wd4CADGz5PsAU7kdEIxDE2skDoMFsPeiQXnohXecTtU29nelohVPJh2Nmcyxfk6WJ0e67EzEVyS5Y9Wc8SMMevZpQx5XJvnDu5/LlcdOCGjjliNJ+LZ+YqXkauoQDau7xnj6EW2b3VHkT9jHFFlgDd+O0w4C2G/QwsDa2dpaUUcZ7SjjserCj3a88XvyUCEoawp8jqt7+F3Np4k3VlzcrYCVkgzRDyekM5Zzfz0RXpWERmyFZ6O3/34q0M3Uf1ULsZZxoL3HWLdKxFmH5EpNZ5tf97DiSaWVzt20j203uXH4a8hWEwbG782g6eAznVrK7KyLmyPer26s7XdmzixJP+b8VhOpl6udE5Aqm4QC7BKMDIs5BKIkeJ3L+IFCLFb+1OJR0Q31j3LCgiku+cc63VSPTlu1P85pgLMTaf9NB2fPqnld1VqtgMnTDnAuT7r/3h6YiGrVmRlr6Mi11rWYqCv7CtZZ0/3L8i2SDQJ9UEBG+GS19fKxUJQOeIVb6Hoc5rjy7BnbpRuNMGnIXqodLEDORIL0vkhXdW6t1da9igGvjWCV5/Vr8YnwRcrWfvb5GpoKtPyGPO5g6itQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd55c30a-fa3e-4716-a083-08dc06f19dfa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 15:36:38.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Imd92t4sHfLbxLT2x17Mj8N2DjcVeiDOnI0aXZlZfH5FSU/ri78VuOONu2yFCSMXHqcSXV9P9bdtihHSRNKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-27_10,2023-12-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=940
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312270114
X-Proofpoint-ORIG-GUID: dInAuHTnf_ZfJj-qPz14K3-WAKE2TXC7
X-Proofpoint-GUID: dInAuHTnf_ZfJj-qPz14K3-WAKE2TXC7

On Tue, Dec 26, 2023 at 05:01:05PM +0800, alexious@zju.edu.cn wrote:
> > On Sun, Dec 24, 2023 at 04:20:33PM +0800, Zhipeng Lu wrote:
> > > The ctx->mech_used.data allocated by kmemdup is not freed in neither
> > > gss_import_v2_context nor it only caller radeon_driver_open_kms.
> > > Thus, this patch reform the last call of gss_import_v2_context to the
> > > gss_krb5_import_ctx_v2, preventing the memleak while keepping the return
> > > formation.
> > > 
> > > Fixes: 47d848077629 ("gss_krb5: handle new context format from gssd")
> > > Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> > > ---
> > >  net/sunrpc/auth_gss/gss_krb5_mech.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
> > > index e31cfdf7eadc..1e54bd63e3f0 100644
> > > --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
> > > +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
> > > @@ -398,6 +398,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
> > >  	u64 seq_send64;
> > >  	int keylen;
> > >  	u32 time32;
> > > +	int ret;
> > >  
> > >  	p = simple_get_bytes(p, end, &ctx->flags, sizeof(ctx->flags));
> > >  	if (IS_ERR(p))
> > > @@ -450,8 +451,14 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
> > >  	}
> > >  	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
> > >  
> > > -	return gss_krb5_import_ctx_v2(ctx, gfp_mask);
> > > +	ret = gss_krb5_import_ctx_v2(ctx, gfp_mask);
> > > +	if (ret) {
> > > +		p = ERR_PTR(ret);
> > > +		goto out_free;
> > > +	};
> > >  
> > > +out_free:
> > > +	kfree(ctx->mech_used.data);
> > 
> > If the caller's error flow does not invoke
> > gss_krb5_delete_sec_context(), then I would expect more than just
> > mech_used.data would be leaked. What if, instead, you changed
> > gss_krb5_import_sec_context() like this (untested):
> > 
> > 471         ret = gss_import_v2_context(p, end, ctx, gfp_mask);
> > 472         memzero_explicit(&ctx->Ksess, sizeof(ctx->Ksess));
> > 473         if (ret) {      
> >    -                kfree(ctx);                      
> >    +                gss_krb5_delete_sec_context(ctx);
> > 475                 return ret;
> > 476         }    
> > 
> > Obviously you would need to add a forward declaration of
> > gss_krb5_import_sec_context() to make this compile. The question
> > is whether gss_krb5_delete_sec_context() will deal with a partially-
> > initialized @ctx.
> 
> Since the ctx is allocated just in gss_krb5_import_sec_context, 
> together with that all of gss_krb5_import_sec_context, gss_import_v2_context(with this patch)
> and gss_krb5_import_ctx_v2 are allocation-free balanced. It seems that we don't need to 
> release anything else by invoking gss_krb5_delete_sec_context.
> 
> If I miss something leaked, please let me know.

I see, if gss_krb5_import_ctx_v2() fails, it releases the ciphers
and hashes via out_free. So no leak there.

A nicer approach would be to handle that clean up in
gss_krb5_import_sec_context(): less code duplication.

But you're right, it's not broken today.


> > How did you find this leak, and what kind of testing was done to
> > confirm the fix is safe?
> 
> I found this memleak by static analysis. 
> The safety issue can't be solved by automatic tools as far as I know.
> So I check patches manuelly before sending patches.

Can you give some details about how you check the patches?


-- 
Chuck Lever

