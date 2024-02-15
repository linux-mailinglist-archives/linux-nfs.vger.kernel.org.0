Return-Path: <linux-nfs+bounces-1982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A23857121
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 00:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B731C21415
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 23:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5B134744;
	Thu, 15 Feb 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z4bd7yul";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bZdG+QNs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175A12CD93
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038264; cv=fail; b=dvkro/lc/u5Fth6QTeufpTzm121Ak854zukaT3yKnlEfkfU5Ued1XZnxx4GeAAG5WLJn7auzEYMMU5VbWDMVSUpz6gRwL2BKJROKMmUrVUlogGpwG8oMoAol83QxT9xYCgGAc2zJSfTtcGU3f/qTtCfxn0oJrt+5J7XqKvsSd0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038264; c=relaxed/simple;
	bh=ddvjr4UM96fj0IPOMWLiP5K6ThMgUZbZSVpDJBBEcE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CzTWEOEt3WOPSVZvTbiMSwjO7tZ2hM2Uu5GqRfQ9fO5cCpZjWbY9x39qtq4ZuUJ4pVGy81ExuJVDMtbxBOJVKMwuVyV1CvIqPhe4QhxALQfSm2kqZJPDbQGF9O75OBxZcE7CnULr8QOgPXv65411agqQ0qdXQAz5X8C49gMJdYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z4bd7yul; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bZdG+QNs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSM50019671;
	Thu, 15 Feb 2024 23:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=QGjqx/sVVUuSafpahT3LdV90K9xrSKjcosNSO6fhzX8=;
 b=Z4bd7yulrv6MovKM6mGura3rRwvEfcYPjc7p/yNARUmw5+XequkicrKYYtIpenIxaV4I
 W/QJv3ecxYtDDRysX6QCIWBUx7rsX9Gcu+h4NRF8YukTBI0dEt2nDseV2J7gl4ACdsZ9
 L6Wr8kEPF8bx5OwO4mMWfqxxDhfW6jwO6WtTcJD/nKgS3IDymbq7dGfLuowGU9o2o3/r
 8gXIMSiCF6sjvm9OXV3H69FfTD9q7qJk2HlOIrlki/DyQ5UrPZnd/ViTifK9f3M4rNi0
 Flgw8OSdZ0xXAfNeIdjWXJcVNedTVvgDH7/aqaWh9pljdt2FsoHX+7LKvhItcKpElTT8 Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w93013gg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:04:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMC9L2014971;
	Thu, 15 Feb 2024 23:04:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykayvdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:04:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciK25eqRAR66TFB42terUydGlw5IF1eTn9guastr7SK51Ao7rebmqB0exep4CMkZWdHv5blTGxTArM0IWmVe1EcbPZBjAYE3A+SLe2rXWJJteRfp39LYDpz9946tXdiCLVPoHOmwGgtMCZcH8zkqNnJtQtaJNLTVCMcDOsaoO74hp/Aj9QYffjcU/WWS4kssKteVdTN6weWhuh0o7+3BwzZDmdoudHlLZCZd7URocUEbbK+knJEE28pDb4j55afd9T3nTHkbeNar2MqUr4SgByTRMZPo3Ax9Gqa4Ea1D9r2OO9hmRoxeENHzDsWXEx6TefP8IvtHIwnhB0C+C0jn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGjqx/sVVUuSafpahT3LdV90K9xrSKjcosNSO6fhzX8=;
 b=W1ufPZROQLifDjD/fUL7hHm2YEDAC0u/G1BkYMEdayEO4BLqYssO5HUe5w4HXvmmMWXZWZ/ynQSYUGU7Cq3PbFa93UjVClQptn8sC+cAOrMISVZxFAQoE8zF1DRC069KSXpYywWmL2TfCyKLoNZ5S/ucbPYCIymQ7/xb58diGYLL+Mkh/9PGzGqHgiIXkvQgx4+0sjgNly7VOQVMQQ9TtLowHVX5d6s2oSwzcMwGfdqJ75UEYuIwHytsGiX/UGv3YdcUyMbecfOvYsiCBFuGpKeetBKzLaMqMG0tyxpkP2FXsnrgir0ys1hodbMUZ+lULWDB8eySauPYJohLIHipaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGjqx/sVVUuSafpahT3LdV90K9xrSKjcosNSO6fhzX8=;
 b=bZdG+QNsFCAQJYcSvjfEkPhGp3szJH12wSSXJNm0kvjS6qcAHvPY/QbI11fi97DKlRKPVJ3kt31fk71FiYi8NMfevrDMreSIgWNQHhmd78WNTzOpFucFaMJMUp5B167RNSKfI15J/002gHfKrG7WfJz1+zfax3mVrpQofkk2Dng=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 23:04:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 23:04:15 +0000
Date: Thu, 15 Feb 2024 18:04:12 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: "Perry, Daniel" <dtperry@amazon.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Backporting NFSD filecache improvements to longterm maintenance
 kernel release
Message-ID: <Zc6YbFoLyrHEvHKn@tissot.1015granger.net>
References: <3AFDD198-5391-4EF0-BD54-A0CD0AE77FAC@amazon.com>
 <Zc6RQBTnUblpJcvo@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc6RQBTnUblpJcvo@tissot.1015granger.net>
X-ClientProxiedBy: CH0PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:610:11b::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 4183e70d-8bef-492d-3977-08dc2e7a6e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jFNMISBg+IdQXBBo5Z+yeMqzQyE535O4sQpKTVep+agYnhjOZIqX/fXZBH+5lpKj4V0WAdP4dE3s3a22OEdKqgvgJUE0EbB9A46WQ7KA2J3mPpnYmhCOKvB4yEpd6DhkHIoBDCxLADR06CXOY4QbxkazRlQ3AIlR467UR/cNT+6V7W2j1T9tc8+aztx77d25dO0u2kzi0kOQHuRqSIQOVFUDGvCNAfYZC93zqH54BQxw1/NMNzYO0+wQYU6cAX9mJoKeUitwoMgXoAUXl10WFTm/DQMRaj6KH2l81+8uMWoD+x/aNTbf+ye3rRM9TXqpMEvnzD0c8/mBi2A4tvbGP2CL9DkuVVQWH+0IwWN/eRwRWrdLGOkM6j104GrdzpxjBowxZn5i+47wO+1tJIERzGkBAK7PlJ3KTBJtaTjOI0w2ttPCNitLELtadC+cUZxwZYV956u7PrMQDzW6lTbk1dVSdDmMUsciwYGP5qzZhakzr7YFPRKzA36HzXMrSxNAIzhYcYim7kjlG2PK8jfX4NUf1lGeOFDYmwZM7Zxc3vQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(26005)(44832011)(5660300002)(6916009)(8936002)(2906002)(4326008)(66556008)(8676002)(66476007)(66946007)(478600001)(316002)(38100700002)(966005)(6666004)(9686003)(6486002)(6506007)(6512007)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hALpdzJOXRCM9fOxR7IB+7F8q3yMKVkC5LI+5yOOakIdokiS2xBeA9WA3N5O?=
 =?us-ascii?Q?wruC1sYqIQ19WpJEIrrSTa964k0IAQ/M5Zo6v9GjurmsjPSAjoDApkgM9h44?=
 =?us-ascii?Q?uu39Nx3fvH7E43tT/FUhJPpheq6LAwO4wa5ZKVeJg3C+4wlMdHoPDW/0DZ4K?=
 =?us-ascii?Q?sQlAhWqTdemqgighLlBK5FvWduExdp14m/0urZ574eY3zToIVU6HbFktQjSx?=
 =?us-ascii?Q?KQOGrsqUrzAN3fPl7tBzmG16k9EITv3hoPvLK2Zfday0OD/+YTkvadO2lGUP?=
 =?us-ascii?Q?I9DUvUuPISyZfQQQD/JI+d7cFW6MAnhozSLC+5+HhPQ4uxTbnu9Abov/d5OM?=
 =?us-ascii?Q?YjVa0StQ1H1Linal4R9VrXutOtr+IFga5Dodn1viToc7L+EwA7IimHD6wRIl?=
 =?us-ascii?Q?hQOjZjD78htSlMFqL/hTUDzaJbJJqw1Wt2m/N2044g/5l2yXbwcRCT13XhPY?=
 =?us-ascii?Q?Rg7tqp2dDvOs3VCDwqC2z6nhM4Sc3j3+ZzfZD18tBxazOeANmqoeIHsddWOj?=
 =?us-ascii?Q?I6+/nvQGM1Y0YHUrf1zC5nNFET4LalIXRafWhlkhrTf+fwmE04SgjAJdnHGX?=
 =?us-ascii?Q?pYqIkVZVgFWynY2lIkjLbcGw1TU4VbTSE6uCHi00ZNHXQ+Z0OFpsh4nu0sVM?=
 =?us-ascii?Q?Z8y5NZy6tmz/iY0apBZ4a5Yjd4FMZ9C3kv9HYDei9qNJFQ9qax28Dawm3D/V?=
 =?us-ascii?Q?pkYCpkAdkuwR8RPa0wu6fhDN6z57VGGlkBLu9SYQMlGuxlniQI1GKxn5MP/j?=
 =?us-ascii?Q?jKSlQiALAsF3cTqM1L0hMynMKt7Q0N+na9sfYfT5yvxznmUw/0PdtXyL0Gwc?=
 =?us-ascii?Q?vHeMxs8M7gx27ns3BNuWHc2F5a3ODTQfuvzcyz1e0uXEbnhJ+lF19IKXyRBg?=
 =?us-ascii?Q?j6HBW5gllIei+EZ7j2un5Iz43gqGGW2Cym7ZYiT4UhwABy63LE+YVyUml23E?=
 =?us-ascii?Q?Ehq9/JbzCyFqSoGR/PTJwtLtDd119Ecxu6qoDY1mv6w2YEY+SUl2v7Dv2v10?=
 =?us-ascii?Q?Qgg3hOtgZSLceW53FuQqGVgTGKjcnGxuRh4U9tFczHKy8hwL+Yhpiax1LHzS?=
 =?us-ascii?Q?kDIrd9Hs1auJxPd6MrrOnSVkeCrTmDgkvJE9JCNbTorOoFX5McXtefSZY2lU?=
 =?us-ascii?Q?VTnomxjp+CW9y2p5FKWbwQ6+QNrKNZy1fqhvp0IlF1iasT2DPKJhHs1x/TvF?=
 =?us-ascii?Q?uYvtODc34p+z4gUAG+pHuStl4N1Dao6AMius/sLTBko1h3hvgyx9DKy7R23i?=
 =?us-ascii?Q?F1WVDkm+AHYv3tZa8XvlDZAuFJyvpa1OLklywqfxchkGYEq/6h67SNFO/ASc?=
 =?us-ascii?Q?VMQJ3bqdguGuq35eGlrIPdzvVE1JMGfpDJw3W/le4hOfafNUoGsyQzhjiZNt?=
 =?us-ascii?Q?QArdbCByl8Hkxk9nBpPJOrjZ90p2dZMgrP6w3BU4UhmRwgl8cxcrLIWvZclC?=
 =?us-ascii?Q?F0yC347jklZcuz1++YrvuUSpk/72k4QfxThXsQ74ZpArKuywXocPm78mMBet?=
 =?us-ascii?Q?FFqCHWAGvT7CFK4ie0M1oYYs+Sh1KYC6yu3KDjTjXQO8LY1OrW8eKe+moNbP?=
 =?us-ascii?Q?TS8fwwsIGNvhc1fmyvYGFCk496bBOp915m+DhP0sDcdxmYVu20IE5Iob9sWQ?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4BdbELm22fOvDPZzz7j3F2qEurUMkHtA8ypdaxbZSu2ZFchSdSyBa1A9rfZzgPJZY03/QqL57Jh5xbWHr5xAgskjU6oJBQRadBYBErewqIpqdDrwhjvpkdX7M410UV8k4OXvL01Tfg1X6o6hudhnNSGlWDdQlbg88PEvmkZmEHOgYRRtYY40ulfFIqBrbrE5Xg2NwOUNVdgSidWWbjGoFdavoXBX27pMuyyXaJD7x9KMeWZDDu04yKcCUd4VlOS1KCw2ZAbF6S26+F2LAJ8nuf+2xAlOB2bnB+kN84PrrfYzr8GqWdjEzZS34ceAOHPLDnT8xee7uyQ6XwbY+7oTZTXgulNAej8dOKZcKPNLA99s2NhF0GSsICKuqJNahJjY+avaoG+4dCXdZRViFEaFgII8MIEJ/MEMrGUKPJ50mcWsnInuD864yKTodWI01synOs5KCz4+Wa6KAiU5ICiKTyHog7Ppb/1DX4Lo7PY4ideD1w1Qh/G7rQ3dEygMxtHb5DGgxeqn5w0ocgVb1D+VzPRU5ne0ykNzConNHr52bOTyyDv/bRgNbWCg63J0wK6ssDXGQAWoKp4+QCqsZWzhsUAXcbfWUCdGNFC2cknJQk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4183e70d-8bef-492d-3977-08dc2e7a6e67
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 23:04:15.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8sILGlCqb5cKpvznVMJms2VUlRf30K9eKv9/3wM5Q16UKg3b+K3WECElt/LvwKy6HEhwNi3o0KfRAlwx11weA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150180
X-Proofpoint-GUID: UrujIZTK1CdqPw6vE_OUFjmhlqPBikXx
X-Proofpoint-ORIG-GUID: UrujIZTK1CdqPw6vE_OUFjmhlqPBikXx

On Thu, Feb 15, 2024 at 05:33:36PM -0500, Chuck Lever wrote:
> On Thu, Feb 15, 2024 at 08:40:06PM +0000, Perry, Daniel wrote:
> > Before we spend more time investigating, I first thought I'd ask if the maintainers would be open to reviewing a set of patches that backport the NFSD filecache improvements to LTS kernel 5.10. From my perspective, these patches are core to nfsd being performant and stable with nfsv4. The changes included in the original patch series are large, but from what I can tell have been relatively bug free since being introduced to the mainline.
> > 
> > I believe we would not be the only ones who would benefit if these changes were backported to a 5.x LTS kernel. It appears others have attempted to backport some of these changes to their own 5.x kernels (see https://marc.info/?l=linux-kernel&m=167286008910652&w=2, https://marc.info/?l=linux-nfs&m=169269659416487&w=2). Both of these submissions indicate that they encountered some issues after they backported, the latter of which mentioned a later patch resolved (https://marc.info/?l=linux-nfs&m=167293078213110&w=2). However, I'm unsure if this later patch is needed since LTS kernel 6.1 is still without this commit. The above two examples provide some hesitation on our side for backporting these changes without some assistance/guidance. 
> 
> We (Oracle) have been discussing this internally as well.
> 
> I'm not a big fan of backporting large patch series. Generally, if a
> stable kernel is not working for you, the best course of action is
> for you to upgrade. But I know this is not always feasible.
> 
> In this case Jeff and I never found an adequate reproducer, so we
> can't nail down exactly where in the series the problem was finally
> resolved. And I think the community would be better off if we had an
> upstream-tested backport rather than every distribution rolling
> their own.
> 
> Further, the upstream community now has more standardized CI that
> works for not just the upstream kernel but also the 5.x stable
> kernels as well.
> 
> And, I now have some branches in my kernel.org repo where we can
> collect patches specific to each stable kernel, to organize the
> testing and review process before we send pull requests to Greg
> and Sasha.
> 
> (Perhaps) the bad news is I would like to see the performance and
> stability issues addressed for all stable kernels between 5.4,
> where the filecache was introduced, and 6.1, the kernel release
> just before things stabilized again. Maybe 5.4 is not practical?
> But I think fixing only 5.10.y is not good enough.
> 
> As long as the community, and especially the author of these
> patches, is involved I think we can make this happen. Can we start
> with v6.1.y, which should be simpler? Do you have testing or CI in
> place to tell when nfsd is working satisfactorily?

Looking at 6.1.y's filecache.c, it has already got most or all the
fixes it should have. The only thing we might want to do there is
confirm that with some testing.


-- 
Chuck Lever

