Return-Path: <linux-nfs+bounces-8107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B59D1D2D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463DB282EF3
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53D27473;
	Tue, 19 Nov 2024 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U1LCFswY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wlMjXKtw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C9175B1;
	Tue, 19 Nov 2024 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979196; cv=fail; b=QoIrc+6rTZuKnVdFOMuUhRpdm2m3SCVq6Wdhc415sHSDV7n7nLUwAxJ2OKjUNvBxx0YsVx22qRV/BA+SO9o+VFsUWKRRn54QEk04L238QEnfPz0xi4jIci87rQpQjjIcZy/IWkX0tt4/+e+p6DM+pT8Kh96FvT2sQP1/Azo2WoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979196; c=relaxed/simple;
	bh=jG9oStihEdTi6i6Ph07BE7ggvdAKf50kKu3wB6BxYy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HzXxeeASbfFnqDoT8Bec0zbluBIEP0LJIrDGEqFneJZiFldAcvLEdntPBVBs67LoO2oy4KwhtRvpKwgZTPfBtNdvPgRjjHMAgMVn3wtArUA0rj2F2JGQJOXlIRIIbvBjw3qcUv3I6ce8EX9j6nTQENdXqyB3znwPo5VUTsrwEZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U1LCFswY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wlMjXKtw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AINMbV4012457;
	Tue, 19 Nov 2024 01:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9AjXT4p/Ez2Q9ABh0O
	I1aSYg0QL5fLvXox5FGqAQuQQ=; b=U1LCFswYy21Gvd/40EuiYUV9v9dcoAoItm
	hOrITzVThNb/PHBkqYlXbnOBTyMFOpTnsLLXDMy2AUNxFe/lAKJmM5Y1BKi37fSe
	98hDmDKx1nXhtLzLGtUZC7vGtn6QVJQhF2wrAIzYjuWQA5zoCStGKKhiPK/6xPmv
	4iKnIuGnujzLGXyrqI4HJwzEs//kh+7xAlFoLRPeb4jtXixbcrJQr/gPPbJhJ4/C
	9Y7bJsEtnU+UWeaA5iv917iA6uTUx3W8DlQ6jkKGHo2Euj36ttVbbYYQ1yhwj/U1
	VxEVpNnzcObiNdnYQGqQnfOxfj4JrlZO1BbplH7Z/IGnnxj5STaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyybyvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:19:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ0eTIo009012;
	Tue, 19 Nov 2024 01:19:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8388d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McmtgQBHdxiid6CfXd8HU7t7x2ITl6/oJ+wC/57uBpVdxUNbjbqIsCXrtUjiGLUS1BCKbAzsu4kZOrGIJq/ygRAVl5eZI90kSR44lD6Blm/fBQcs0EH8OhXczeaXxHzsGGIjocCqNBhg7vZhLDeCf8RKPf2LAk+46HaFeOLRu5y9qiZRTka7BGswI3AzoFXf20qjuQ8O0vZmVerQVNwA5p1UAAS4JQor8kmZNvrSNFH/eJh0iQ37abqqniwqMQCNmbM5Ttxs94N1PeXmfnzrjRsw58UtoxpBGiLNiycl66bRyM5X34o8M7VIyrbf7bxYDlg2ApB2j+bQQIzcDN1pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AjXT4p/Ez2Q9ABh0OI1aSYg0QL5fLvXox5FGqAQuQQ=;
 b=w1546iMMKW03LC4zdN5gO6m82U0eU+QHWODVIBBsJ5QZpYLYMVpLh3wYmAiLRqHKgV/8fP/dzJgfl/LyDGFtaVBPK6h4k/B45cPchNIFz5UX4S+/jDfM03tl7Yeshtw4ZEbHMAzMji5qECSgAiEnyvh8TQyWC/REt5W055cO6W6BgM8EHF+1tGr2qr9KGU4nRrs6qdRPjgVtjG370LtXqdC1omJaJezGW4thR9AwbVAM39an65hychcKudGir1KtSF5BZZXmvyyXCJMQVp0pNqQyYdk1wTGURL+/tbqCVDszP63cyG9CDxZslSqyXZHBUc5cEI7QZnldTD+f6N0jUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AjXT4p/Ez2Q9ABh0OI1aSYg0QL5fLvXox5FGqAQuQQ=;
 b=wlMjXKtwTq5woSg0FQcKqqsmNV//DyXi1UuE0hmLmP86NiRyWl9YXDqf6ripRFk05pHM6hKO/ZcwZt6xTgm1hbxM6UTe7BNeMd3mnqCEuLpPAX4HTOAUg4Ji4KrO/UnNhbt+HpPZKqcfwP8wBtVg4j5x+n0xOF12gAWGQGGe+MA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 01:19:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 01:19:38 +0000
Date: Mon, 18 Nov 2024 20:19:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Thomas Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] nfsd: add support for delegated timestamps
Message-ID: <Zzvnp4WYcHocYsJG@tissot.1015granger.net>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
 <20241014-delstid-v1-5-7ce8a2f4dd24@kernel.org>
 <173197809388.1734440.12511559535515038071@noble.neil.brown.name>
 <Zzvj3BdZg2sxB+SF@tissot.1015granger.net>
 <b68d500c1199888a98d2cafbcefb50a7aa031fbd.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b68d500c1199888a98d2cafbcefb50a7aa031fbd.camel@kernel.org>
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 84747e3f-86a2-4431-a105-08dd08383caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pgqoqRgNR1baKsERkYrQRpfBZ2yCEJTw+3ejNXCLqhNsnZuYDA+/2uek2+KZ?=
 =?us-ascii?Q?iS75sRn4KHx9S4iYH+x/aB9/Jyw09Q/qEQZZAlwJlxODVK2VbblMcA1LIhyn?=
 =?us-ascii?Q?F8zS7O2NBg5Vve9BmytWEYikefH1kl79l/8JXuVO3Bam4gKpNZbBdIMgcGyr?=
 =?us-ascii?Q?akNWxefj50kWA5DndjApn0qK5lPC6uMeMM8rNmhODiSTE09R8pJkn2DCvtkm?=
 =?us-ascii?Q?KRz4OprGdwzHINRVXHBKcZ+eXTgr2tx/Zg2VeQuitJXfURqMIffyowX7a6yY?=
 =?us-ascii?Q?AxvQH0U61zu6n58qtXDpFG0RvOOr0jhRDpQbMT38LtDP9FvrVhkgD6LK9SEt?=
 =?us-ascii?Q?VAvjGeLl7nJNXrEkgbAADCo8orJxOrRdXVLdqYPnimYcfOxscp5JAwg4xHH0?=
 =?us-ascii?Q?iljqCxERirZm8wNaS4Gpzidk8OPt/s/IWf6PfOcmXHFdQr38iBmBJgmWZclb?=
 =?us-ascii?Q?Q8iKfBmv31og2mWEoDPjgPbMw3IihGrYgeGu4IhlR+rVsuKo/6fP6ZoZL/kl?=
 =?us-ascii?Q?F6KlV0APQOeXwPswx41nU/5RbmGCkU+vN60hhH08oNuFZk/hiVDOOiEtqXQU?=
 =?us-ascii?Q?9wdWRhbUXn34qWbOb/dQhjnqQM9eK38NSCSI2n+N+AXgu7SBMtuTFcZd/7+V?=
 =?us-ascii?Q?pRpJxjVcJKvPHfbV69xoYPPcBSFXi0LWrtTPQDQXfVpeRnSZOdcjl57UCR4+?=
 =?us-ascii?Q?jQoEGnucmYvzICtezNm0lGNcfc75w78P4xrto7vHRUFhghxm5S/IgGwH1iXV?=
 =?us-ascii?Q?j+JnWMqsBYXIWXf87xSjedZ1/Uk2UXXfc2Y5DpK+1jWxEw94AdpJFa5mGVCe?=
 =?us-ascii?Q?tYsjiF/KStdPI9/iCsX2S3JNRMeRSVrbaFpT7R7RExvT06ViPysc4kja5qDS?=
 =?us-ascii?Q?oBPmDyC4PFNMZmtvjpWnB5zq4+3fyJQ+ILxgHkt4nJO1oKuzAWUl/7o77ZMx?=
 =?us-ascii?Q?IdBi5702ss/232YMAaqMmosSSiF9RnjlgTDf8YIkvJf0CCifyU80nb8UcO0C?=
 =?us-ascii?Q?Disw3ZAHiSh5TaMOneXEe70QbcdUc8s6RjqDbYZ19kQUdqMs0LNf/ieQ25mA?=
 =?us-ascii?Q?3AA1inoxhgsMhmziEUt+xP2nT34KnOrMY086ZTMwTRt/N2fxVGMHE038MeML?=
 =?us-ascii?Q?EW+Lr8TugFkqNZZMzE7FHsWknOrNZ+55VL/Z7mf0meJODHfCrHp/BJLCQWmX?=
 =?us-ascii?Q?i4gRatLJ6f/ORn3wQz8rF0fRBEH1ZXVzRLGD17T/sbyNvLAeEI/jwSfD5hbO?=
 =?us-ascii?Q?gU8lZMq2fbN6nc6/3cLSsObR0kuibmSiybvFGNOl3F1KB3L+aneHEeusE6Bz?=
 =?us-ascii?Q?nqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GNLKqLJqPXJYYnMRtLRyE93x7xdAYb24eQeL+JI1HL04Qx1gE4ysxTCQWQml?=
 =?us-ascii?Q?ZrAgjfbFmwfJCifOm7ZNE+vyUFDlYVSptGLbwbGwjzvBMmR2D/eTpL9eot5n?=
 =?us-ascii?Q?oNz73kOO6z4wNeYZXelB3ClOCyinHl30hiaV+oTj4dGVNSPrGwwp8bBXr2e9?=
 =?us-ascii?Q?HjTRwfMChBbYJMtlA46bagCvv6yxcGZMKa6/Zzb/Hs9pgIy7tVWIT9COXzlv?=
 =?us-ascii?Q?5M/SJ9scI/Ide3AiR7JBPtT4ULL/WOO+nXWB9na1DBZLAhUU4d1wnFU43PWn?=
 =?us-ascii?Q?UPJfJ5FPbn39SWFNzrfT13Dpr9TTZP437WW2HIpTCAL+CxVfZJ5l0kbo6Pvi?=
 =?us-ascii?Q?tHf/8kAfVK3UyGB5Dc5kqf2ZT6/It5C9I1JKdqaxpU4brldXg/HYyGyHHODk?=
 =?us-ascii?Q?iPINKvRFR4Fc8QV225zHwlm/TEI8h0pH/+OmhCnDQjZUtOE4j65pkuiJ23fg?=
 =?us-ascii?Q?efqFa6iQQFABATokYMEIxX9356RdAzwlPTW/alV15aVWbTHvdFW/AXemIlv/?=
 =?us-ascii?Q?Xkgzc6uO1RaeuPEHGoyx7jXbEoZTrARfI9U/vfALMpsg7K3u+tY3ySGe9NJr?=
 =?us-ascii?Q?Qlrzl9nVxltoVVZG+lHkk9sENwFNfyePiEjZcOLXczOT9PFnJIIs6qKK6Lz5?=
 =?us-ascii?Q?yYfQw0Zgi2GOmc1U9sznduM7H3utCE1/I04HOIfCOAbJQfYAIYRsI6CqTmzU?=
 =?us-ascii?Q?S9bZDD13igQwBjcoguEOEHzokQULCsCU5nN1Fs3PSs24peUE3ap/5CV3j9fm?=
 =?us-ascii?Q?bBJI//ooScrCK8cRIZwDN+KU46iabPFOGCo1MZVmISiDqICm9+Vz4PGcD6u1?=
 =?us-ascii?Q?hKcDMxjslr2vJygH9RbsRIGcrHbUjru4EkrBRF2wowqVLEOvs6oyTB/YX67Q?=
 =?us-ascii?Q?DvS90aRbhO8uXF2eJF4uaF5GE0KkN1IVKG4czBUxNNVFHGp5O7FmFzDuEDZj?=
 =?us-ascii?Q?HG8+W7v54foFeu0YTNyLO8ZFy05bVUZNez3Opl7e+Mq9v7762BfikKlTO/Lm?=
 =?us-ascii?Q?xuYibo3+B+Fd33Mi+tFlez3tlwHbuaPSrRv15xzTxJGHFQBRIqZR6GndRF3q?=
 =?us-ascii?Q?Cv15VDMSKfONJOZWUMN7tShtbSmPlKYacNddADH06xLXgUy7PJos3VU8TL+7?=
 =?us-ascii?Q?zbmVR5Pl1+n1BL0qcD1/bZP8xT6nTGp+DQohE+JYm64LZLhtKSYf4bs7w397?=
 =?us-ascii?Q?cIgyZPW4iWasCPp30GRZbh9SP+vqlD0lGm9c2ZyremuIZezXDEPxH37CbHVZ?=
 =?us-ascii?Q?9x19JPq+N6SB7+JIVzZf728X3byRyTlrpsUK+4JiLjFN3dujT0t1vvP3+7Ow?=
 =?us-ascii?Q?EyoHCL94cP0QZ2+NZbcOQJV/LDKuTW7WB0BtrCxyVrLlNKfEi9ibemKJTrqQ?=
 =?us-ascii?Q?uLf410awxHVikKLTkxvm/PAj7NXWPrmuCNhZNN4LyZlmMsWl1XeaP/4jCrjg?=
 =?us-ascii?Q?3DsqtGbQeY3X5ocniFOIjbQJ+jJykWDb/74PGxi7VQpldl+/xQKjAtR8FKnq?=
 =?us-ascii?Q?IiaBjpE3Z8mgjL3Cq/rassCjGExq0BEUpWpDtkcVOWXTArk+8d1DSgCqAdgu?=
 =?us-ascii?Q?MDSrgCYTcXwZjRqnLtP4TIwrVMiIDK+ckK082XMr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7TMjOoE6imYMBj/BrLIxzlVLSb2fJHhsD0s230O+kASwaU+MICUTsDAsDMDkrFWx2vD2aIkN0U2jlio3NB2qXl3kaqjO4mWEM1DdLnASVCcXQYmfuQ3Vv69SrVln6ZsWwDXsiFXZg+IR6+cbUjOhUqSZQ1qbJmORDkH4mEaduK7ov8S7cUrxZSpiL55CeFdC2gqBv+jqm1I3z8b//LkRzCd4gc5Q1TYPWvkd1s0okOUxj00M2deBGyKR/GIHJqT9UEfHa58fsPEBnNt7GXoHqkoQhgcaAJ+Q1+66OH4S1UZSfaL2M3y004XQrWsn2S+22XxK1zhbWcJ5RfWh68PQvDt6iKVbkbk3MKeJMAaqSv3eM32figMaKvx7fAQCzO1fptiAHhhYNt18BOl+IxKroF07Zm6UdEyeDA2bJ8dq/0TysTAttKMjoJ6gudqwszZAhenZf34a2vsamT18JAue9KQRbjST+Q5ccGr4PV8zsx0nN1fnsoYeL5OanFsaMp/vVZj4Wf9Ty6k6xzM7FO3/TFILFJIy8g48+vHcY8Xd01zJV84svf++DrncCF43JLO9Jgy4S5HT7sUsIL+ckZRmE9zhfQpyVi/ZXoLAKSW/TMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84747e3f-86a2-4431-a105-08dd08383caa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 01:19:38.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlIUeZ4SixYpN5sblMzZX+Yp+8g0CIP/tS7us90bjA4U9UeWlP2ExBMe+tX+jPpp+GrUbrHgCzGV9cn/ZgjJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190010
X-Proofpoint-ORIG-GUID: 4nB72k3bXfo3ZZKaF2O0b5mKVxEtvL1g
X-Proofpoint-GUID: 4nB72k3bXfo3ZZKaF2O0b5mKVxEtvL1g

On Mon, Nov 18, 2024 at 08:09:35PM -0500, Jeff Layton wrote:
> On Mon, 2024-11-18 at 20:03 -0500, Chuck Lever wrote:
> > On Tue, Nov 19, 2024 at 12:01:33PM +1100, NeilBrown wrote:
> > > On Tue, 15 Oct 2024, Jeff Layton wrote:
> > > > Add support for the delegated timestamps on write delegations. This
> > > > allows the server to proxy timestamps from the delegation holder to
> > > > other clients that are doing GETATTRs vs. the same inode.
> > > > 
> > > > When OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS bit is set in the OPEN
> > > > call, set the dl_type to the *_ATTRS_DELEG flavor of delegation.
> > > > 
> > > > Add timespec64 fields to nfs4_cb_fattr and decode the timestamps into
> > > > those. Vet those timestamps according to the delstid spec and update
> > > > the inode attrs if necessary.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > >  fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++--
> > > >  fs/nfsd/nfs4state.c    | 99 +++++++++++++++++++++++++++++++++++++++++++-------
> > > >  fs/nfsd/nfs4xdr.c      | 13 ++++++-
> > > >  fs/nfsd/nfsd.h         |  2 +
> > > >  fs/nfsd/state.h        |  2 +
> > > >  fs/nfsd/xdr4cb.h       | 10 +++--
> > > >  include/linux/time64.h |  5 +++
> > > >  7 files changed, 151 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > index 776838bb83e6b707a4df76326cdc68f32daf1755..08245596289a960eb8b2e78df276544e7d3f4ff8 100644
> > > > --- a/fs/nfsd/nfs4callback.c
> > > > +++ b/fs/nfsd/nfs4callback.c
> > > > @@ -42,6 +42,7 @@
> > > >  #include "trace.h"
> > > >  #include "xdr4cb.h"
> > > >  #include "xdr4.h"
> > > > +#include "nfs4xdr_gen.h"
> > > >  
> > > >  #define NFSDDBG_FACILITY                NFSDDBG_PROC
> > > >  
> > > > @@ -93,12 +94,35 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
> > > >  {
> > > >  	fattr->ncf_cb_change = 0;
> > > >  	fattr->ncf_cb_fsize = 0;
> > > > +	fattr->ncf_cb_atime.tv_sec = 0;
> > > > +	fattr->ncf_cb_atime.tv_nsec = 0;
> > > > +	fattr->ncf_cb_mtime.tv_sec = 0;
> > > > +	fattr->ncf_cb_mtime.tv_nsec = 0;
> > > > +
> > > >  	if (bitmap[0] & FATTR4_WORD0_CHANGE)
> > > >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
> > > >  			return -NFSERR_BAD_XDR;
> > > >  	if (bitmap[0] & FATTR4_WORD0_SIZE)
> > > >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
> > > >  			return -NFSERR_BAD_XDR;
> > > > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
> > > > +		fattr4_time_deleg_access access;
> > > > +
> > > > +		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
> > > > +			return -NFSERR_BAD_XDR;
> > > > +		fattr->ncf_cb_atime.tv_sec = access.seconds;
> > > > +		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
> > > > +
> > > > +	}
> > > > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
> > > > +		fattr4_time_deleg_modify modify;
> > > > +
> > > > +		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
> > > > +			return -NFSERR_BAD_XDR;
> > > > +		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
> > > > +		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
> > > > +
> > > > +	}
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -364,15 +388,21 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
> > > >  	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
> > > >  	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
> > > >  	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
> > > > -	u32 bmap[1];
> > > > +	u32 bmap_size = 1;
> > > > +	u32 bmap[3];
> > > >  
> > > >  	bmap[0] = FATTR4_WORD0_SIZE;
> > > >  	if (!ncf->ncf_file_modified)
> > > >  		bmap[0] |= FATTR4_WORD0_CHANGE;
> > > >  
> > > > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > > > +		bmap[1] = 0;
> > > > +		bmap[2] = FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY;
> > > > +		bmap_size = 3;
> > > > +	}
> > > >  	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
> > > >  	encode_nfs_fh4(xdr, fh);
> > > > -	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
> > > > +	encode_bitmap4(xdr, bmap, bmap_size);
> > > >  	hdr->nops++;
> > > >  }
> > > >  
> > > > @@ -597,7 +627,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
> > > >  	struct nfs4_cb_compound_hdr hdr;
> > > >  	int status;
> > > >  	u32 bitmap[3] = {0};
> > > > -	u32 attrlen;
> > > > +	u32 attrlen, maxlen;
> > > >  	struct nfs4_cb_fattr *ncf =
> > > >  		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> > > >  
> > > > @@ -616,7 +646,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
> > > >  		return -NFSERR_BAD_XDR;
> > > >  	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
> > > >  		return -NFSERR_BAD_XDR;
> > > > -	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize)))
> > > > +	maxlen = sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
> > > > +	if (bitmap[2] != 0)
> > > > +		maxlen += (sizeof(ncf->ncf_cb_mtime.tv_sec) +
> > > > +			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
> > > > +	if (attrlen > maxlen)
> > > >  		return -NFSERR_BAD_XDR;
> > > >  	status = decode_cb_fattr4(xdr, bitmap, ncf);
> > > >  	return status;
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 62f9aeb159d0f2ab4d293bf5c0c56ad7b86eb9d6..2c8d2bb5261ad189c6dfb1c4050c23d8cf061325 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -5803,13 +5803,14 @@ static struct nfs4_delegation *
> > > >  nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> > > >  		    struct svc_fh *parent)
> > > >  {
> > > > -	int status = 0;
> > > > +	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
> > > >  	struct nfs4_client *clp = stp->st_stid.sc_client;
> > > >  	struct nfs4_file *fp = stp->st_stid.sc_file;
> > > >  	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
> > > >  	struct nfs4_delegation *dp;
> > > >  	struct nfsd_file *nf = NULL;
> > > >  	struct file_lease *fl;
> > > > +	int status = 0;
> > > >  	u32 dl_type;
> > > >  
> > > >  	/*
> > > > @@ -5834,7 +5835,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> > > >  	 */
> > > >  	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
> > > >  		nf = find_rw_file(fp);
> > > > -		dl_type = OPEN_DELEGATE_WRITE;
> > > > +		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
> > > >  	}
> > > >  
> > > >  	/*
> > > > @@ -5843,7 +5844,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> > > >  	 */
> > > >  	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> > > >  		nf = find_readable_file(fp);
> > > > -		dl_type = OPEN_DELEGATE_READ;
> > > > +		dl_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_READ;
> > > >  	}
> > > >  
> > > >  	if (!nf)
> > > > @@ -6001,13 +6002,14 @@ static void
> > > >  nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> > > >  		     struct svc_fh *currentfh)
> > > >  {
> > > > -	struct nfs4_delegation *dp;
> > > > +	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
> > > >  	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
> > > >  	struct nfs4_client *clp = stp->st_stid.sc_client;
> > > >  	struct svc_fh *parent = NULL;
> > > > -	int cb_up;
> > > > -	int status = 0;
> > > > +	struct nfs4_delegation *dp;
> > > >  	struct kstat stat;
> > > > +	int status = 0;
> > > > +	int cb_up;
> > > >  
> > > >  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
> > > >  	open->op_recall = false;
> > > > @@ -6048,12 +6050,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> > > >  			destroy_delegation(dp);
> > > >  			goto out_no_deleg;
> > > >  		}
> > > > -		open->op_delegate_type = OPEN_DELEGATE_WRITE;
> > > > +		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG :
> > > > +						    OPEN_DELEGATE_WRITE;
> > > >  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> > > >  		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
> > > >  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> > > >  	} else {
> > > > -		open->op_delegate_type = OPEN_DELEGATE_READ;
> > > > +		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
> > > > +						    OPEN_DELEGATE_READ;
> > > >  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> > > >  	}
> > > >  	nfs4_put_stid(&dp->dl_stid);
> > > > @@ -8887,6 +8891,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> > > >  	get_stateid(cstate, &u->write.wr_stateid);
> > > >  }
> > > >  
> > > > +/**
> > > > + * set_cb_time - vet and set the timespec for a cb_getattr update
> > > > + * @cb: timestamp from the CB_GETATTR response
> > > > + * @orig: original timestamp in the inode
> > > > + * @now: current time
> > > > + *
> > > > + * Given a timestamp in a CB_GETATTR response, check it against the
> > > > + * current timestamp in the inode and the current time. Returns true
> > > > + * if the inode's timestamp needs to be updated, and false otherwise.
> > > > + * @cb may also be changed if the timestamp needs to be clamped.
> > > > + */
> > > > +static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
> > > > +			const struct timespec64 *now)
> > > > +{
> > > > +
> > > > +	/*
> > > > +	 * "When the time presented is before the original time, then the
> > > > +	 *  update is ignored." Also no need to update if there is no change.
> > > > +	 */
> > > > +	if (timespec64_compare(cb, orig) <= 0)
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * "When the time presented is in the future, the server can either
> > > > +	 *  clamp the new time to the current time, or it may
> > > > +	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
> > > > +	 */
> > > > +	if (timespec64_compare(cb, now) > 0) {
> > > > +		/* clamp it */
> > > > +		*cb = *now;
> > > > +	}
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > > +static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
> > > > +{
> > > > +	struct inode *inode = d_inode(dentry);
> > > > +	struct timespec64 now = current_time(inode);
> > > > +	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
> > > > +	struct iattr attrs = { };
> > > > +	int ret;
> > > > +
> > > > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > > > +		struct timespec64 atime = inode_get_atime(inode);
> > > > +		struct timespec64 mtime = inode_get_mtime(inode);
> > > > +
> > > > +		attrs.ia_atime = ncf->ncf_cb_atime;
> > > > +		attrs.ia_mtime = ncf->ncf_cb_mtime;
> > > > +
> > > > +		if (set_cb_time(&attrs.ia_atime, &atime, &now))
> > > > +			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
> > > > +
> > > > +		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
> > > > +			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
> > > > +			attrs.ia_ctime = attrs.ia_mtime;
> > > > +		}
> > > > +	} else {
> > > > +		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
> > > > +		attrs.ia_mtime = attrs.ia_ctime = now;
> > > > +	}
> > > > +
> > > > +	if (!attrs.ia_valid)
> > > > +		return 0;
> > > > +
> > > > +	attrs.ia_valid |= ATTR_DELEG;
> > > > +	inode_lock(inode);
> > > > +	ret = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > > > +	inode_unlock(inode);
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  /**
> > > >   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> > > >   * @rqstp: RPC transaction context
> > > > @@ -8913,7 +8989,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
> > > >  	struct file_lock_context *ctx;
> > > >  	struct nfs4_delegation *dp = NULL;
> > > >  	struct file_lease *fl;
> > > > -	struct iattr attrs;
> > > >  	struct nfs4_cb_fattr *ncf;
> > > >  	struct inode *inode = d_inode(dentry);
> > > >  
> > > > @@ -8975,11 +9050,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
> > > >  		 * not update the file's metadata with the client's
> > > >  		 * modified size
> > > >  		 */
> > > > -		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
> > > > -		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> > > > -		inode_lock(inode);
> > > > -		err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > > > -		inode_unlock(inode);
> > > > +		err = cb_getattr_update_times(dentry, dp);
> > > >  		if (err) {
> > > >  			status = nfserrno(err);
> > > >  			goto out_status;
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index 1c9d9349e4447c0078c7de0d533cf6278941679d..0e9f59f6be015bfa37893973f38fec880ff4c0b1 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -3409,6 +3409,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
> > > >  #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
> > > >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
> > > >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
> > > > +					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
> > > >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
> > > >  
> > > >  #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
> > > > @@ -3602,7 +3603,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> > > >  		if (status)
> > > >  			goto out;
> > > >  	}
> > > > -	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > > > +	if ((attrmask[0] & (FATTR4_WORD0_CHANGE |
> > > > +			    FATTR4_WORD0_SIZE)) ||
> > > > +	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
> > > > +			    FATTR4_WORD1_TIME_MODIFY |
> > > > +			    FATTR4_WORD1_TIME_METADATA))) {
> > > >  		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
> > > >  		if (status)
> > > >  			goto out;
> > > > @@ -3617,8 +3622,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> > > >  		if (ncf->ncf_file_modified) {
> > > >  			++ncf->ncf_initial_cinfo;
> > > >  			args.stat.size = ncf->ncf_cur_fsize;
> > > > +			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
> > > > +				args.stat.mtime = ncf->ncf_cb_mtime;
> > > >  		}
> > > >  		args.change_attr = ncf->ncf_initial_cinfo;
> > > > +
> > > > +		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
> > > > +			args.stat.atime = ncf->ncf_cb_atime;
> > > > +
> > > >  		nfs4_put_stid(&dp->dl_stid);
> > > >  	} else {
> > > >  		args.change_attr = nfsd4_change_attribute(&args.stat);
> > > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > > index 1955c8e9c4c793728fa75dd136cadc735245483f..004415651295891b3440f52a4c986e3a668a48cb 100644
> > > > --- a/fs/nfsd/nfsd.h
> > > > +++ b/fs/nfsd/nfsd.h
> > > > @@ -459,6 +459,8 @@ enum {
> > > >  	FATTR4_WORD2_MODE_UMASK | \
> > > >  	NFSD4_2_SECURITY_ATTRS | \
> > > >  	FATTR4_WORD2_XATTR_SUPPORT | \
> > > > +	FATTR4_WORD2_TIME_DELEG_ACCESS | \
> > > > +	FATTR4_WORD2_TIME_DELEG_MODIFY | \
> > > 
> > > This breaks 4.2 mounts for me (in latest nfsd-nexT).  OPEN fails.
> > 
> > Yep, we're on it.
> > 
> 
> I see the problem. The OPEN_XOR_DELEGATION patch reworked some of the
> NFS4_SHARE_WANT_* handling, and this patch relied on those changes.
> When that patch was dropped, it broke this patch.
> 
> What we should probably do is split out the flag rework from that patch
> into a separate patch that this can rely on. Not sure if you want to
> embark upon all of that during the merge window though. It may be
> better to just drop these patches as well.

I'm going to drop all of delstid -- it's just way too late to do any
real surgery on this stuff, and it seems very tightly interwoven.


> > > By setting these bits we tell the client that we support timestamp
> > > delegation, but you haven't updated nfsd4_decode_share_access() to
> > > understand NFS4_SHARE_WANT_DELEG_TIMESTAMPS in the 'share' flags for an
> > > OPEN request.  So the server responds with BADXDR to OPEN requests now.
> > > 
> > > Mounting with v4.1 still works.
> > > 
> > > NeilBrown
> > > 
> > > 
> > > >  	FATTR4_WORD2_OPEN_ARGUMENTS)
> > > >  
> > > >  extern const u32 nfsd_suppattrs[3][3];
> > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > index 9d0e844515aa6ea0ec62f2b538ecc2c6a5e34652..6351e6eca7cc63ccf82a3a081cef39042d52f4e9 100644
> > > > --- a/fs/nfsd/state.h
> > > > +++ b/fs/nfsd/state.h
> > > > @@ -142,6 +142,8 @@ struct nfs4_cb_fattr {
> > > >  	/* from CB_GETATTR reply */
> > > >  	u64 ncf_cb_change;
> > > >  	u64 ncf_cb_fsize;
> > > > +	struct timespec64 ncf_cb_mtime;
> > > > +	struct timespec64 ncf_cb_atime;
> > > >  
> > > >  	unsigned long ncf_cb_flags;
> > > >  	bool ncf_file_modified;
> > > > diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> > > > index e8b00309c449fe2667f7d48cda88ec0cff924f93..f1a315cd31b74f73f1d52702ae7b5c93d51ddf82 100644
> > > > --- a/fs/nfsd/xdr4cb.h
> > > > +++ b/fs/nfsd/xdr4cb.h
> > > > @@ -59,16 +59,20 @@
> > > >   * 1: CB_GETATTR opcode (32-bit)
> > > >   * N: file_handle
> > > >   * 1: number of entry in attribute array (32-bit)
> > > > - * 1: entry 0 in attribute array (32-bit)
> > > > + * 3: entry 0-2 in attribute array (32-bit * 3)
> > > >   */
> > > >  #define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
> > > >  					cb_sequence_enc_sz +            \
> > > > -					1 + enc_nfs4_fh_sz + 1 + 1)
> > > > +					1 + enc_nfs4_fh_sz + 1 + 3)
> > > >  /*
> > > >   * 4: fattr_bitmap_maxsz
> > > >   * 1: attribute array len
> > > >   * 2: change attr (64-bit)
> > > >   * 2: size (64-bit)
> > > > + * 2: atime.seconds (64-bit)
> > > > + * 1: atime.nanoseconds (32-bit)
> > > > + * 2: mtime.seconds (64-bit)
> > > > + * 1: mtime.nanoseconds (32-bit)
> > > >   */
> > > >  #define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
> > > > -			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
> > > > +			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + 2 + 1 + 2 + 1 + op_dec_sz)
> > > > diff --git a/include/linux/time64.h b/include/linux/time64.h
> > > > index f1bcea8c124a361b6c1e3c98ef915840c22a8413..9934331c7b86b7fb981c7aec0494ac2f5e72977e 100644
> > > > --- a/include/linux/time64.h
> > > > +++ b/include/linux/time64.h
> > > > @@ -49,6 +49,11 @@ static inline int timespec64_equal(const struct timespec64 *a,
> > > >  	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
> > > >  }
> > > >  
> > > > +static inline bool timespec64_is_epoch(const struct timespec64 *ts)
> > > > +{
> > > > +	return ts->tv_sec == 0 && ts->tv_nsec == 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * lhs < rhs:  return <0
> > > >   * lhs == rhs: return 0
> > > > 
> > > > -- 
> > > > 2.47.0
> > > > 
> > > > 
> > > > 
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever

