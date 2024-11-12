Return-Path: <linux-nfs+bounces-7904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C589C5A7D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50C11F22F26
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 14:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7C1FCF60;
	Tue, 12 Nov 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5qwHsnv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VwIhsPnR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AC1FCC50
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422198; cv=fail; b=ptR7+zt+T+eu3ynrpHYD8zCiV342PMucAni9hdC8t68mcAPAepqlTiQhLcAjDP+of1VHk10G6V3+5sEvcIJN0a2Smbx9ocOe2GXsRre24v1iimEdlbkCJZ2KBv5AbhtABvKRtIm5+TKXefFSW2a8tIRpD9rahrbqnvWzTNitHTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422198; c=relaxed/simple;
	bh=v+Dyo+S1M0pdPFSJGCVb6r/qsjEokChuyKYoTj/rkt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DuwRg0rGwrhukEwf2Z0U8YejO9MBJWZM2xsgZO3vg4Hd71Lh4LIqy9poTdkjE1ca19LJcQjO+T+vwTDHp2yxz/sBRbMGmsy9D5W4TokL+6KK/MNtAy1RYNVSWeOViOBQUSiEncKIUW/+z28s338ZEiH95GsDlrFiU2q6iHjAdhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O5qwHsnv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VwIhsPnR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACDBXvr009504;
	Tue, 12 Nov 2024 14:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=h+Bbfpryplt3XTpvl7
	fZ24BXCOjOQ5JSUIJPIEdPynA=; b=O5qwHsnv0cB55oKz1tqaBH1oRgUPPTdM96
	pvGBIsQnZtTQ2VCQ/J6S1VTfLfu+mnHrnoBI9wu7ioTjZwhUoQ/q5GJ9kY0Lr+AU
	zJSbjWdA5zNDP0MFBcR4hcDH4a7AonlQ6ZV1+/zG3N+ifSdZU3yAAGgjflXdraOh
	FXOa1SH1vRzA3cCLPeeUDVSEG8E/DPktJOpyNqAHyyujFPAEC90Fhp+7p/UWV8zQ
	sbVFCZIHv+5Ao6Cn/ldmsj63oXiv4ovZsJwY0yak5lgft6gKC+mwO5RvW4yhOm9V
	/sDA3Jjia8z9IZRtPxzBvyZrH5pOIjySDVBjDLgJEIpc3le36wAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwmgbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:36:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACETSnt007980;
	Tue, 12 Nov 2024 14:36:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx686wax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 14:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8tS4H+wR3f9InFXMu26UQM2QinwSMMIu+690ObSdL4ParaM5H57bMS4L1IFnBA1V6ncsGlbqAAN9I96UxJLBAH0qP8C9j1WAZXeVhqDxUOCPi9hR/cQWvUoEiiOzPWi5IsxJCKQJ+uXJXVq4sg6edOEhgehrmh77dOWT4HMj+YuOlLzpmeb733vgIF10FkISBRY7UogkZsaAfGEAHVLz6H1C/FJZo8QleYN2ZXkPliZh06pFp2PtSwOlaiifauXsdB1BeS9TGLtb1dyljp0QcKRGNVuXD7HcPw2rISMb9V/Ges6LxWv/XtAIdPHlGLBWQplxfn8RMAwp4DY+6gcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Bbfpryplt3XTpvl7fZ24BXCOjOQ5JSUIJPIEdPynA=;
 b=s8YJ+uty67eEdFs3EoHB7wU7HUDrt5IBgMBf1+x6M6tUNCf8G+V841In6B9mrrXZVenGujKhGOlbNiV4DJdgY1ecU2Dl7iDZW1nBUsvRpLPjmeG6fTrEa+fOiD9H9/rgHWudvtnuD861pfTa4JXG8WiQ0MKVa2Dxfkq32juN2UmLLG0QL9sy5ymwgoOn1lAzaV+uUrRfbfErEB1YeeNzPq6MlHkL8HVTvb+2QKvlN6igiMVVmQXDvXbCOyomHLLzETsCD4jN21yw5MJNDkmIOX9NzIdpsNC8fOg4bXGXuZ/5qsj2XZy+1gjcILjUoiOWWjyv0VQA6KZJoS1XmyO84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+Bbfpryplt3XTpvl7fZ24BXCOjOQ5JSUIJPIEdPynA=;
 b=VwIhsPnRhAEUPATSPd++svZy6ACn/S03YW166EibSK+LvRtydCGN0jA/5C0N3HIhZZw0ylss4rPyNFDkmUuwBDg3hrBbrVViSU39pEpyV5W5EsMveUkfplOFYel9+QuYj16wlksYAQIdAgTUy93crxaEBE2MHeRgi9kHP+xa044=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6332.namprd10.prod.outlook.com (2603:10b6:806:270::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 14:36:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 14:36:12 +0000
Date: Tue, 12 Nov 2024 09:36:09 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
Message-ID: <ZzNn2czIB0f66g0Y@tissot.1015granger.net>
References: <>
 <ZzKeciwU6n4R9VgX@kernel.org>
 <173137257042.1734440.8400976538590009783@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173137257042.1734440.8400976538590009783@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:610:5b::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b8f86b-d968-4721-0d7e-08dd03275b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDc1zLRwZ87GfWSZ9FJblqpgw+pcfdhQbPsSmphIYTVZenrYLZRaI1HpTw2a?=
 =?us-ascii?Q?V3yd33Ft3KVK1r07AePEeXc+jZVoxYwMj39wEgjkl+OrMmJRNGQHZsKW+jUs?=
 =?us-ascii?Q?CmvBxhp4dMZiIZyFkeWDsTwUjEMQ/nAiMf1T01oyzjPYUm9gOJv6rLkmoGM7?=
 =?us-ascii?Q?uCcE92VFOyoYmtDD8t5cLKZaItxeW+MK+AsD4xj42Zo0G0VVVV0aoP6JdexG?=
 =?us-ascii?Q?GuKkggkkMOG2yu1wYJO27Vy/sMwB0HVnHIY5vknGbesqJZWGRAoZEsUXXWYh?=
 =?us-ascii?Q?2xCd9Iz0pvxhdbt/m+hsdfyrwU4ZgWhvctpkwA89OTuCB/Z+JRrvSyemHLb4?=
 =?us-ascii?Q?VlKLh7IOdnUcscgX+129gLHmPqalxzMnPtpszp1ivRoYFvl0CDk79qER8zj1?=
 =?us-ascii?Q?cKEBSnlOYZ5N4ezPk132Lz2FsYtnkKa9Broi41F2UXzY4HGJ1uhfQcy6SV4P?=
 =?us-ascii?Q?l8jKM23McfWxiMas0OiDxy2H5agpOJVz5nOsa60lEYrv4MabLIhT01eLWimG?=
 =?us-ascii?Q?lb5xTgVB7OUL6SiC4Dm3r04vvMG+W6BwOUlq2sGwQwyvuifWkY8cJTCgxv3B?=
 =?us-ascii?Q?z28Mnz5IC0Wx0RuSxaADjuee5syCwQQhnudXCPz+WPxkH3OQexIcf9MR1w3G?=
 =?us-ascii?Q?qHqulXvufSRnOb8zzjDX0Tda2RoK3vYIsq9XMC+eStokMsiQzBlcqa5cvwkX?=
 =?us-ascii?Q?C1RaktO3Lv6YXA5uvy82cwSll5xj8rfVEtSIslef8YMCNqt7rCTJqluw6TyU?=
 =?us-ascii?Q?hEaDNGRhbgrNXbJ1t+W16OCyheADSl0aqIhEkdULjKp5RsSoCdqGFUZYJw0Q?=
 =?us-ascii?Q?ZTYpuakaUGqaIdHIH7c9vAo0lRK5MhRRtoWe+5UzULqidwqDIJMBEH51JOZI?=
 =?us-ascii?Q?018Fh72Q1GpJplWlN1JCXj9YExWnzX8ZCMcZa1b0R5PuDV9CogEemBq3pEPf?=
 =?us-ascii?Q?8EeskMP6AHzA0sF5oQS8mL3mYBbByZDmwCOq63Znzk0eq23RW4Yw2rXDVpxu?=
 =?us-ascii?Q?smBD1OL++E56oCu4hHhyZUJy6/DFfuMK18tVPG7/773rcpbtVOnF22Tw5vQm?=
 =?us-ascii?Q?gs1I+nRmoN5YZGvsjQHGsdIU6Ypj7qW3NRzRTjm2F+/ZMeU6bz50rkwZ89rX?=
 =?us-ascii?Q?+3GNw/TiEV0nA4cnAjXtpwmr/RlQpTqmFiYFQqZ1/me5FrP/3K1NwVrIQRgg?=
 =?us-ascii?Q?qmFfyr2eJZEK8PadrVsPgdfGytamBGg9Q9H+tmspWcUHHtHLea6ieBMM1DMw?=
 =?us-ascii?Q?WFK3PfUtSM+2CuES5nqQRQJlNC1j/Si8f4jMsgnQNOD8sN5MZBWuML03PpBc?=
 =?us-ascii?Q?bht9Fd4HPJYXtcf4Q8LMXNxl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5IRfcH1KbZzzubLIRuv4kxHoY3J9WnksVxXE065Y3bCyxD+xA5ERUDzRsAa?=
 =?us-ascii?Q?R2Og4RAfMl4OkkkgE84LsAjBsC5698u3Db13IWE9m48XycIYP9HAwylFlWRc?=
 =?us-ascii?Q?w26qnEH73shHKbQhmsHER7SnubpZDSUdaNRb3kIqGhGV18z3JfCee0ELB7T6?=
 =?us-ascii?Q?O6X2EQ3fxRZEpzA1P1VjD1k70rZj9TKl8xp58cCCTDQ7wQUo7NAqEZGKKsOX?=
 =?us-ascii?Q?TcYot/YkmQDVCzSTubkujjr/QvbSuiIiYrD0+Q8gRLvUDJhChd5bYWtelBdA?=
 =?us-ascii?Q?mOxjnlM2vO375nHgiy+trFrZa/d++JnCdKJsVbwj2y8B7HQxwv/50US5MNkW?=
 =?us-ascii?Q?sV5NJ9ttei55eYtmLybqSyo2mLJI0+iu/vY6XSe5l/DJZozLHiNt4N0HNpmo?=
 =?us-ascii?Q?jL/CeOMm0mCMVVKKKHcF4arZw6vbLvFlJaVctroJo4fx9e8IKsSU21ravD8p?=
 =?us-ascii?Q?ECdpnVX70SEwXzqefVs1/90XrCHqI57y1yZxAftDKxHyRei3V+VhmQQ+SnqW?=
 =?us-ascii?Q?b690ChOY87l7ItbYNalnV0pGuSWrrMxTcGJXoVvwVCgAcV61WKT66iKK+ESA?=
 =?us-ascii?Q?KZTCkemuP1HX3GqFwPfMZ4hYO2onYnvcsgE147la54gv/A8fRLqmi2j7o5uG?=
 =?us-ascii?Q?TUJiOGVQs9z8Ds+FFg34dHuYbBMlGFI5AeJK1h7z8LBNiHTaSVADPUHGzLPm?=
 =?us-ascii?Q?dYbJIrMAomzcKFn9gWuPMAmZgjYCjLGPxqqvO+UlMQOOdzdc4sV5SD0PupFt?=
 =?us-ascii?Q?5NyNVHewLEtxBr3Hjpl6grCPIoNOycoXRB0B1UamGSZxdOPP2lJZrr8W0c2U?=
 =?us-ascii?Q?di64sUWtXGf7p/wyK+KKG+OC8nL6xGtfYEXeWc2Y4Pg6s7JqwPRf69ckIlPZ?=
 =?us-ascii?Q?tiDX7ra5Fq2xfvYPFvvNdjpG4i7ei/ixiDXRw5lhmnJJBKbIlrNKrS2xS3nW?=
 =?us-ascii?Q?ULuPk9Fl2aDGw41kmoPwDu95yJawXgbuTxD2BJPziceXWh44KU+r14t5Ymtu?=
 =?us-ascii?Q?VwO/aO5Uroytv4Ffo5VzmJdD0lTq0ICmXV+1eKbel5DGnQ6759/jS0P+67bl?=
 =?us-ascii?Q?uzrlmCFKVEvJXxDr9gPXGtIUIfcAzMW80dxmyzT5rJoYgA1SxNF0/VH3I705?=
 =?us-ascii?Q?ZcdHm9ufqDZFs2vwdzwXE/s/lSl7+teAYZFurf5tw3ulgditL6+yCsnFOyQy?=
 =?us-ascii?Q?WyfV08c2+P7T2WSFy90vb4Zwd6VisSNMVgHITUOsTO4I+u6CIpAuBxFXHBmB?=
 =?us-ascii?Q?y0ZKSpUjh/Te4DrO8zzAQAk0u76lbrJbTPfj1hvW//IsytZXF7MGtYU6eFbT?=
 =?us-ascii?Q?5ZLxczUeN5DzoEW/6zDE10OEgFXuOM5uVhTkRNhSCVJiHddYGccWN8NEEuy3?=
 =?us-ascii?Q?LAhtBA1RldHHo1TOaJlGfkt7jN+SWqJatw8A6JFChLl4fLdlbH4a/Dqj6mo+?=
 =?us-ascii?Q?BOp0GQMTeOCALfK49YNtMmGpOMGbbGmxNzPl3F+EZHKl6aL7sIvqj+FC8zAh?=
 =?us-ascii?Q?BjHg6VSMXoLXabEb6q0Acs4qKkoaW6GS34uiAEU4F/1FqI6n6EwA/PNtV2lu?=
 =?us-ascii?Q?1TYP+B+ZN1goytqweNZdqBudwPxaGyfREM0x+LBdrp92kThYpkh51ZWqqH7f?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ag5FUwCmAicGtJ+jxHqkHfXYZaqXVN8osuvGiPS2o4XBf6nTZG0XlbVUmX9nWJlMJeiKgLz4CVUSxL4Mq/us6CnTA+y1E6vgoNQD+MXkKRgyCRSDsueeYfP+eI6+sH3Tm82qAvQTBTcdTDoVnMhwSf2rXG9USjQNC0Q8+g0eFMPq67gS/xXpQrXguEFo03JSzVCtHwpGwNb9eFccIWO0XzgfOXQvGwkQjfzefwhF5O1GOTZS/yMnQxOVjzB5mvEXxesmhxRDkBvskqcyPk0OlAMa1UCrclhzeuyWdEAWd31d1sjqWm2ZZxboE7S9uVKTSjtec+OxCJPktZvDuY1ocGoYqZYaxwbQs4wVUaXO92uxoE6GhT0LCMVGVFd4HCtWiOodtEWbfFQKA1cSR8aOJCLKOsbfIEe56jtq/8FRBtVzm9YRJuCGnOpQlu06hHSfty6h0GRAXnJOfkasLWI4dS1gbjertPxlZL6+NsRWjJhP8bBr0VhcJqtHEKJyoNgkXYXV3ntmjaAVV2/ZGRp90ubeuQwHLf9C8ChzqvpPE0b5tJWZNpTx3NFnrjeQT6/ijq5a207FlgLQ94iK4wqV+ICH2HD7MgKmYgnUan9KNzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b8f86b-d968-4721-0d7e-08dd03275b55
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:36:12.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ILF+riYbyzr6JpLpF+JCozu5uYI2kqfhLdsFXi/P2c8NBn1uABB9EDhI5Fe4B4ofsNPWboAzLmEuwgqFiibEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120117
X-Proofpoint-GUID: TEBBLd6rNAIA-XfG1WyeMxntKjOUkPuU
X-Proofpoint-ORIG-GUID: TEBBLd6rNAIA-XfG1WyeMxntKjOUkPuU

On Tue, Nov 12, 2024 at 11:49:30AM +1100, NeilBrown wrote:
> On Tue, 12 Nov 2024, Mike Snitzer wrote:
> > On Tue, Nov 12, 2024 at 10:23:19AM +1100, NeilBrown wrote:
> > > On Tue, 12 Nov 2024, Mike Snitzer wrote:
> > > > On Tue, Nov 12, 2024 at 07:35:04AM +1100, NeilBrown wrote:
> > > > > 
> > > > > I don't like NFS_CS_LOCAL_IO_CAPABLE.
> > > > > A use case that I imagine (and a customer does something like this) is an
> > > > > HA cluster where the NFS server can move from one node to another.  All
> > > > > the node access the filesystem, most over NFS.  If a server-migration
> > > > > happens (e.g.  the current server node failed) then the new server node
> > > > > would suddenly become LOCALIO-capable even though it wasn't at
> > > > > mount-time.  I would like it to be able to detect this and start doing
> > > > > localio.
> > > > 
> > > > Server migration while retaining the client being local to the new
> > > > server?  So client migrates too?
> > > 
> > > No.  Client doesn't migrate.  Server migrates and appears on the same
> > > host as the client.  The client can suddenly get better performance.  It
> > > should benefit from that.
> > > 
> > > > 
> > > > If the client migrates then it will negotiate with server using
> > > > LOCALIO protocol.
> > > > 
> > > > Anyway, this HA hypothetical feels contrived.  It is fine that you
> > > > dislike NFS_CS_LOCAL_IO_CAPABLE but I don't understand what you'd like
> > > > as an alternative.  Or why the simplicity in my approach lacking.
> > > 
> > > We have customers with exactly this HA config.  This is why I put work
> > > into make sure loop-back NFS (client and server on same node) works
> > > cleanly without memory allocation deadlocks.
> > >   https://lwn.net/Articles/595652/
> > > Getting localio in that config would be even better.
> > > 
> > > Your approach assumes that if LOCALIO isn't detected at mount time, it
> > > will never been available.  I think that is a flawed assumption.
> > 
> > That's fair, I agree your HA scenario is valid.  It was terse as
> > initially presented but I understand now, thanks.
> > 
> > > > > So I don't want NFS_CS_LOCAL_IO_CAPABLE.  I think tracking when the
> > > > > network connection is re-established is sufficient.
> > > > 
> > > > Eh, that type of tracking doesn't really buy me anything if I've lost
> > > > context (that LOCALIO was previously established and should be
> > > > re-established).
> > > > 
> > > > NFS v3 is stateless, hence my hooking off read and write paths to
> > > > trigger nfs_local_probe_async().  Unlike NFS v4, with its grace, more
> > > > care is needed to avoid needless calls to nfs_local_probe_async().
> > > 
> > > I think it makes perfect sense to trigger the probe on a successful
> > > read/write with some rate limiting to avoid sending a LOCALIO probe on
> > > EVERY read/write.  Your rate-limiting for NFSv3 is:
> > >    - never probe if the mount-time probe was not successful
> > >    - otherwise probe once every 256 IO requests.
> > > 
> > > I think the first is too restrictive, and the second is unnecessarily
> > > frequent.
> > > I propose:
> > >    - probe once each time the client reconnects with the server
> > > 
> > > This will result in many fewer probes in practice, but any successful
> > > probe will happen at nearly the earliest possible moment.
> > 
> > I'm all for what you're proposing (its what I wanted from the start).
> > In practice I just don't quite grok the client reconnect awareness
> > implementation you're saying is at our finger tips.
> > 
> > > > Your previous email about just tracking network connection change was
> > > > an optimization for avoiding repeat (pointless) probes.  We still
> > > > need to know to do the probe to begin with.  Are you saying you want
> > > > to backfill the equivalent of grace (or pseudo-grace) to NFSv3?
> > > 
> > > You don't "know to do the probe" at mount time.  You simply always do
> > > it.  Similarly whenever localio isn't active it is always appropriate to
> > > probe - with rate limiting.
> > > 
> > > And NFSv3 already has a grace period - in the NLM/STAT protocols.  We
> > > could use STAT to detect when the server has restarted and so it is worth
> > > probing again.  But STAT is not as reliable as we might like and it
> > > would be more complexity with no real gain.
> > 
> > If you have a specific idea for the mechanism we need to create to
> > detect the v3 client reconnects to the server please let me know.
> > Reusing or augmenting an existing thing is fine by me.
> 
> nfs3_local_probe(struct nfs_server *server)
> {
>   struct nfs_client *clp = server->nfs_client;
>   nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
> 
>   if (nfs_uuid->connect_cookie != clp->cl_rpcclient->cl_xprt->connect_cookie)
>        nfs_local_probe_async()
> }
> 
> static void nfs_local_probe_async_work(struct work_struct *work)
> {
>   struct nfs_client *clp = container_of(work, struct nfs_client,
>                               cl_local_probe_work);
>   clp->cl_uuid.connect_cookie =
>      clp->cl_rpcclient->cl_xprt->connect_cookie;
>   nfs_local_probe(clp);
> }
> 
> Or maybe assign connect_cookie (which we have to add to uuid) inside
> nfs_local_probe(). 

The problem with per-connection checks is that a change in export
security policy could disable LOCALIO rather persistently. The only
way to recover, if checking is done only when a connection is
established, is to remount or force a disconnect.


> Though you need rcu_dereference_pointer() to access cl_xprt and
> rcu_read_lock() protection around that.
> (cl_xprt can change when the NFS client follows a "location" reported by
>  the server to handle migration or mirroring.  Conceivably we should
>  check for either cl_xprt changing or cl_xprt->connect_cookie changing,
>  but if that were an issue it would be easier to initialise
>  ->connect_cookie to a random number)
>  
> Note that you don't need local_probe_mutex.  A given work_struct
> (cl_local_probe_work) can only be running once.  If you try to
> queue_work() it while it is running, queue_work() will do nothing.
> 
> You'll want to only INIT_WORK() once - not on every
> nfs_local_probe_async() call.
> 
> NeilBrown

-- 
Chuck Lever

