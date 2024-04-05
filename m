Return-Path: <linux-nfs+bounces-2677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1E89A3DC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334A71F23984
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57B171E5F;
	Fri,  5 Apr 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cvUAySCS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fgu4H+Hb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511571D530;
	Fri,  5 Apr 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340468; cv=fail; b=oMr93ADW8Nrfd5qWtSlBehEu0JmZYDKto3zqU+BoIAJZBXlH2ydlmNeTEUCnJS6olV+GSyfbgfwrKY6/NsnS7EO8d41BZve/TYV5Nr1QqAYkhdNKa4M1AXTwuZNCIBAfgb2Y24sQPf4WigPmT9MWgsiKGVuci4RhSpXFFCHAMIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340468; c=relaxed/simple;
	bh=e78dw9kFn093XhW9AfNfi9kWRR6YB51tUb7LHvowKJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KOMj7ld7qfzxTRTDqVxqN27RT4LvUxpi+A0+hDAoKi5CR5cJi3VqhT26G/IRLItbq+BsdgebUyh56gLHRKOGMv9w6KlVbOj1MOLOWUS9bRZb6uX6R8d9hgBU13L0abf/cKQo8ndORhoJEnRnXtSmvva4mjNEdG/AcYHk8DITJFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cvUAySCS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fgu4H+Hb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435F3eZY032597;
	Fri, 5 Apr 2024 18:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=PHCa0jk/1Xq2ur2SQcvvgCAQeF25oLu3lHlN+KVVfTY=;
 b=cvUAySCSHc4qOBk2kvuWHa/SGYu/beFWnvucwoZfzU8b1BfTbUh30vkqnn8Mo2/ehoKU
 QnkW9BHynz7ZQVV1oA1sJMMCUN4+Cbz5cTp3BvyTEn/NsocIs75fNA3kZZFufRnGGoK4
 M+mPJGFG9QdlkxMJwmS4PmC0EKS49AhPJ75PXmyLnqTWxqpWP8YtIOrlANOHav2vrFX+
 eOLKIJDD90hPK0N8oerf7ZvuuqECgmIldlaZT45x26aE3B5wEscMSYPli6Cnkqnpw+w+
 E51I6Msm1xF18anMFKn6WXZpIh46o5urrDc94emUA5p/G5YjcK1DeS6aNVtkHTkvg5O+ gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9f8pc1e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 18:07:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435HviUh026901;
	Fri, 5 Apr 2024 18:07:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9empakbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 18:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne0+jZ7zVbotUhC5S1XguDvQ/r7W9OMkx7xs00wL08WwJY0TEjhtaq1KhG5zmVR/6PcIAlhmun7x5uvdTy88ZEHUWflNdPpmPWMEHijZbAnrd9yoAinGBeyvhBpVq993EeTnSaG60kqQ/proM8wW7qrLzTGEBgKr+0T/bwaONyUgsiwOlzjNoq8Mj0lZnwonmEyoejxh3Fa5JWH5ugQGc5SidMD12vdEFx67qLWtko9ICSaf2L8R/Lb8RldzBqq4x6JsAWkI4QpheLzxN5Ln2lyg7CYsx1qKyGZ2GlO6ZJPreQAskUv4P9cQUzS+mV4P29a66Caiv5i1bq7Q/3MUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHCa0jk/1Xq2ur2SQcvvgCAQeF25oLu3lHlN+KVVfTY=;
 b=S8hoExP/WkwHmr+XuJb7syADmYT6tW8ZGZcdiiXTrN7ydGkIMouVbo6IWzrsD8fZAsptACZI53aSNcU3KimHpjP51/NDvHhd9i8MZXU5G+5KNobcr96B3FykC6M9x1WCxzJ8GQzJLNEPvpLxDkkmg49C7RKFhdVX0MvgYoR7LzzTLqfKYy69+BJIczQ6YzKUVqqUXdPs4wCXs4nkoF9+W0942h+lUhRzC7swzYw3/srb74EpEvgM19JAnTLRMbDiq+Db8+2gjBbG310j89/EBPwZr/IfFYlJxpp9aarc9FxahZ4uxZpBhZbWlZwJPVBh0Mp09sJ32mZJ4aNLvuDFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHCa0jk/1Xq2ur2SQcvvgCAQeF25oLu3lHlN+KVVfTY=;
 b=Fgu4H+HbvJpEkoS3ZJU0nk8BC5bORC36P/PatwYeN6NJRFKIgPlA+c8NCqP+SKM/08ZZASqLYrm2VfLBLbzIZiM816hf2Pi0yN2gSKYrCQf4vcjEIN9Ylg8ZOdK7c8Glu+R2Z18N8cqxHGQ+esKI7cUm9GxrtBzCNQ8JbbbKceE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 18:07:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 18:07:27 +0000
Date: Fri, 5 Apr 2024 14:07:24 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Vladimir Benes <vbenes@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: hold a lighter-weight client reference over
 CB_RECALL_ANY
Message-ID: <ZhA93BQSxkJqmqaw@tissot.1015granger.net>
References: <20240405-rhel-31513-v2-1-b0f6c10be929@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-rhel-31513-v2-1-b0f6c10be929@kernel.org>
X-ClientProxiedBy: CH0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:610:76::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4847:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vlxwrRD6c3uhk0mmS8nxU5KV6Fd9BcShg1p4ys0e9IKxxpfCtzw/nungeOcZQIgUp2Rwv5vbyRVXJlYiTvZnbOIRozR621wS5c54EaouMaqSS3s7wmJBGMx3RO1Tn1tCjLL+m7+wJ07g67y2KGO8xgHej8O0X6TeAR+bofmPd9SAeGCAAzFoHVk870VVpHAvqeqOioIvhzhQIZ8Rgy7amfe//9LBFA0rTDS3c737qZu68K+6e0PhCsT2GZJLDaznkG9o66rwPaNlUgPHNjGEZs02bYGSI3Uy5/KleFRpHRZqMsKDt8QVOSZ7j05lDddOBGfdjUxkRiKdEBdAhVOpWHEv793uXOn8Io9FzVgPDrt78m0ts8Th9joK1Wnb8EDfv8SeyMVqpzJQc+oXZufG0xskwC4DIqwdcpdkgpJ/bMOehhXFHbR8MGlJmNFXJRZYvipzACepHVJHPYJKHFUJ4J9I/ytzvMeOi4yyn0MnFZwweuGdMXjWn/qqbs1wZdMj7Y6RynknLRUu85pBvz218OHvw16Ei55tlrwonnpDQ17bRG1G4d9QqhTTLvuxH6v8NwiFR2dF/ga58AiMxIREtT5npPVA4LmoluWL+s3HVnheA6OVCHgZNOctCnLz4wJ8yEH4XUIDbaYoyEcD9lNhIhrXqfnNTdHKBPD7h6WPqew=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/2clvrE89kZSROCqRgwOjHqAYRsJL28FsGyJLeWrN2qneIppgaXfqMqwmfVb?=
 =?us-ascii?Q?/0E6BTSwb9AiQs8JDFcPNmjMwTu8l7b7DV9GpyhCGaFQIS729yEEqFIxRwbu?=
 =?us-ascii?Q?DTOPol77bZ9CqE/JPkLrq5D5DfnF6aBLHHqAyllUhftQfyCU61pey2q/1m69?=
 =?us-ascii?Q?mVYrCW6eUi/ln2LWEDhDWDx0NAQrb976H1gvpa04c+CzNgpUk9yqk3vlszXa?=
 =?us-ascii?Q?GsPm9VODsg434KNK/MK5MhL9ha8y586vtK6jWW0/JEwTqffhTDvBwz1/CShU?=
 =?us-ascii?Q?UMZtqHKt/y6qxZBRflNeLHqxvKzIbJ2AE6ljF0iKDKNYvKurug4VcWro4KQu?=
 =?us-ascii?Q?pAgAJOUIuUWghLiH5TnqmYsyuc1FGk4TWUDYOz1OAz7ZG2TDg/x5kqcoQaOX?=
 =?us-ascii?Q?l3dIldioazndtoV+Ox/HAVwj7VZz2+Ad62vqkqgVt3Nb3katng+vODN5e3ik?=
 =?us-ascii?Q?booFYtvSd823xHtfyUqg/ogfkER375aeUFJjuChmtNPYB6pRxKLS4OmlYvR0?=
 =?us-ascii?Q?bQ5z//fytSlOajiRtIQsR0yOIQaFkmKRfpHBaNngFOxBpM+LYcd58JH3kTXy?=
 =?us-ascii?Q?brsM7VzHpVc+nRJ63ToNfd1nkBjymR1Q5sG4+sK5RWowH4KV+ojFroGmAsDz?=
 =?us-ascii?Q?NCt0KNJdvwmgV6wLVoWg5Ym3iYZaNyflwmeJ6JURX7vpAyG2M16u79jEPnYm?=
 =?us-ascii?Q?p1NRFxHlRCEGlQVSKl2BfLbRRvIQxiIogn6qsksii6fJ2vQ2cG2iQCOybDbZ?=
 =?us-ascii?Q?nZMknL0KEfRbULviCJMFiRxtjaBMdacs36U7d73t4GSyIvWi51LAKSLHbXGr?=
 =?us-ascii?Q?s+HP14oaJs5eiZhpIUgBpEF0McKyqEoM1W74QUC/sJajCi2nuE/5Cq3UTeML?=
 =?us-ascii?Q?HPPEW4C6fzU8Gc2LdKU7Z2G2s/3BcFpzCi/v7B6d/sa5M1/EeYzglCS9GyOW?=
 =?us-ascii?Q?eh7oq9xUbnUBmxtLXEkH+zY37ARSDv/soliE4TL2eMZVugw2UDNcRTbtgAd7?=
 =?us-ascii?Q?ZoXq9PeoJ30ASJ41KtQ9+0x7wAH39RQXsmKD0u7Srl03rifs3KNCO91W6Hoz?=
 =?us-ascii?Q?U0qVavi5rLM1yPofvJ39epzW3t0gdREmNFtRhxPXY4vVXzmx7HM/OKeizoX/?=
 =?us-ascii?Q?nEU91tTs7EyVsK8cDzMw2QTtD/Qm1+WQ5cy5Tyygoqzi9vVGfD7z11vavz0W?=
 =?us-ascii?Q?jJWJy+H9A7M1jYro2l41ysjyHFWZiqwM+AZA+qLtnAwXdvPKh9DfC3+NTTEy?=
 =?us-ascii?Q?OpgHgVWoYqEMbHRqpx22jl2mLkPkwqTWmbcOoDtbVK6rc6D0UHiQwGsIeVGH?=
 =?us-ascii?Q?7Trio53OpzuLTANXMOf4itNr6xJJ3rB5PjfR46vEDz9ghysLreMSWsTtY0X3?=
 =?us-ascii?Q?rbjhAP0yCJOiod3VgiY7KHHjUpuf6EgSk0ONuhZ+1+EoJ7TvcHgCaQK1be3x?=
 =?us-ascii?Q?0fCV5nrfOKpX2UzM/9abAV4V/pp8r2ULry9EUXLoDUMpSvcS1XjcQ5Upif/l?=
 =?us-ascii?Q?4LU/SPVdRVSyeAK8/eXqstGGwUCIvfZMvNS4rPGh5I0hvkEuHDNwe4tjtsmb?=
 =?us-ascii?Q?fuk5JKwY3H1l2RbEIR46GZeuPBqrI1HvXhXHdn3eESfcVUiOZrMXKexItjFq?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UflHXB3uqAZGBkvdMgXWX9x3uW3bXlV160fZvNgl5GuhRZ0lrAiYo3VoZQxzG2yATKdk95A9u44TC5iPbCbZAxpEPPM1mrlbCKoRpf68jXQZkMA2Q6OsggbUMkYYx+1UHII80S/UuYDE7ewpF+zDfGot2Hq2sdnQnEdzAwh4adgMJ91DRKgwLks26pMei1jaZOxbHWtefyZiUBXt6gD/XRmUnMYz5TRCJtEvX+pwoRJCd0Asfl3fy0neSTvrLA3bGKS2Pp5TwF/6y/lCaaACeHR4PYQJACjavn+7Xx4OKfgYryEa/65L/lddjTKVTug3/P/ve3lFubGq+/jYtRdQ/cnWTmYyTP33lns8hX0L1QIJA2s9K7vUBfK2LUWtjocFW36v06lmFkQp3J4nTxsQEJgjVUfyHrHW/OCOE7aRj+KYJvRrJbfn0Qxto9IM1Ln5BDZmmls7sppKT58t3hm+qXv0kPfZ0t+W6mlAlLW0/tUJy/SG+9ZUeYWewsThpVyQYC/mRzlQ6gpGWEF61PrA8L3eH8xAbQpeoRUcbQEetcU7HrehzrNJvMTFa10RydBaY2B2F1+qfg8eVpp0IRh5ncZ8xVgJtzJU32Owl9j4C7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72358ce-75a7-4601-4067-08dc559b4097
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 18:07:27.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPHNiOVyKAE6uxx7nPupd2A4Cd9SzX6qXOIw27LzELGCfUx/i+2THAXowL2T9aLsTRunvKHrhDv9mOMby5F45g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050127
X-Proofpoint-GUID: XIW3FjVYdEN9D4S25k4EY6DLp2kl1hcU
X-Proofpoint-ORIG-GUID: XIW3FjVYdEN9D4S25k4EY6DLp2kl1hcU

On Fri, Apr 05, 2024 at 01:56:18PM -0400, Jeff Layton wrote:
> Currently the CB_RECALL_ANY job takes a cl_rpc_users reference to the
> client. While a callback job is technically an RPC that counter is
> really more for client-driven RPCs, and this has the effect of
> preventing the client from being unhashed until the callback completes.
> 
> If nfsd decides to send a CB_RECALL_ANY just as the client reboots, we
> can end up in a situation where the callback can't complete on the (now
> dead) callback channel, but the new client can't connect because the old
> client can't be unhashed. This usually manifests as a NFS4ERR_DELAY
> return on the CREATE_SESSION operation.
> 
> The job is only holding a reference to the client so it can clear a flag
> in the after the RPC completes. Fix this by having CB_RECALL_ANY instead
> hold a reference to the cl_nfsdfs.cl_ref. Typically we only take that
> sort of reference when dealing with the nfsdfs info files, but it should
> work appropriately here to ensure that the nfs4_client doesn't
> disappear.
> 
> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
> Reported-by: Vladimir Benes <vbenes@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Applied to nfsd-fixes while waiting for review and testing. Thanks!


> ---
> Changes in v2:
> - Clean up the changelog
> - Add Fixes: tag
> - Use kref_get instead of kref_get_unless_zero
> ---
>  fs/nfsd/nfs4state.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 5fcd93f7cb8c..3cef81e196c6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3042,12 +3042,9 @@ static void
>  nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>  {
>  	struct nfs4_client *clp = cb->cb_clp;
> -	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>  
> -	spin_lock(&nn->client_lock);
>  	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> -	put_client_renew_locked(clp);
> -	spin_unlock(&nn->client_lock);
> +	drop_client(clp);
>  }
>  
>  static int
> @@ -6616,7 +6613,7 @@ deleg_reaper(struct nfsd_net *nn)
>  		list_add(&clp->cl_ra_cblist, &cblist);
>  
>  		/* release in nfsd4_cb_recall_any_release */
> -		atomic_inc(&clp->cl_rpc_users);
> +		kref_get(&clp->cl_nfsdfs.cl_ref);
>  		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>  		clp->cl_ra_time = ktime_get_boottime_seconds();
>  	}
> 
> ---
> base-commit: 05258a0a69b3c5d2c003f818702c0a52b6fea861
> change-id: 20240405-rhel-31513-028ab6f14252
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 

-- 
Chuck Lever

