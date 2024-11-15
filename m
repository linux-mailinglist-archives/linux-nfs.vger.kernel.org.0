Return-Path: <linux-nfs+bounces-8003-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6379CE11E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13EE28E0B6
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D021CD1F1;
	Fri, 15 Nov 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fvluu3Lu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IwhvD4F5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C001BD4F7
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680358; cv=fail; b=lj547yY4xUom1JejlOyIk6AF1Gf9cIJqBlwcfxaeEOVusv6er0g6qT81XDGMKypl0AXHABy8ufy5pOExPHYLnBgecF9popjYHeeIBpOGL6ZGaMO+vXizkxew0vuUEmjk63Fq4F1oIAfncHaKLXco3jxSuJD3Jhj++fUijH3RDPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680358; c=relaxed/simple;
	bh=BrG3Wd0s7WjTVFcVSFwFySlDWBR52P2rGVHCqV6X5pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ApmIRdWVzKLJNJFwN6NJ4RZtovxGf2lAorapf5Kg14Ga8ujBg66icTZZ8F0Se7QT58cO3UTLT00/TyZOl9v9m/ymcdSYul0qh49a80OeZuVfHmmP450SmzcSumZcyRnlTVLAeeVZmZDkVhkO2wmn6HFl5rBrR3VNoVTsPcQS/PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fvluu3Lu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IwhvD4F5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCTTX031063;
	Fri, 15 Nov 2024 14:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2FWu7R3haeuuKoPoEd
	MiDaF+gVP4yU1AOxS3YCxvHOY=; b=Fvluu3Lu7n7S3eMlCfDb72Oh+LrIz6EOXz
	8erGlLWRPi4XIe7xA54xKoLMjnl/RTLoXUwl2EhqLZzmjDRNBpxUXtq6G14ouH+q
	aKQNYjTNeyHYQ0KKkhOS5qKy7vmAPHPmmPD5pd3fAyhmLBDSzmDnd6mzX8n3GTxx
	Kv6WJEeZwD76FRul63M5KywZWHkJLF3Gh4gyhx3iilzD2q0t+fTdfsSF54y055J7
	L01+N42jZZKo8U7wiaVU2xcb4TSldPiM+Utd+yyE4ecSABwZ6wMnkn/UOuE8hHbE
	yrYR1UPXUNGZYg+9OjI683c2ixpNWI8wYzI7okkeoJ6e/fsrIStQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4n68j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:19:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDhb8i035964;
	Fri, 15 Nov 2024 14:19:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c88uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtiZKudj10jvd45sjERtDbSBNlkH2s159gksW2Jum9urRMmlm/pbFWJ6wMI9lczuJVmkiPkUV6IFvsCvUk69kS2iszbhBbpPPSjZChObBD8sD+9kIc+/Fr63oF2GVjY3zTh3ZH4bpqq3g+XUKsXpCkOljdLEcwJmbBC4wG+24ovh4xRC57jjP9hNJEOm17ULxjjwfGw3AbaetPWtCKo5grKFOlytpHz7bDTjSws8vG4174LLWMN3VG05SOIlVMK682AyFytKS8VrhVRBeTIFuj4b6AcKd0Rn8PaL36ahOJoUjb9ljsiQinfcVxIgZge7QJt001WMRRAYXFJtmDH1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FWu7R3haeuuKoPoEdMiDaF+gVP4yU1AOxS3YCxvHOY=;
 b=S2yPzkJsGaLspCu7ul2VC7imTiSkCK7ZPodkQIPuoVfWaddMUztmhG9xNxzRlVGOHCTaVpbrGIip3x7GQVLBEat/0WdqaRn6Scq0P0ASM+g+24l17DID072HL2v/GfG0wtf4vGQm/2rEX9CGMQJUPYwnBxVzrINGpY8zRGAUPopTLbjmKz22JQiX3CtyZU0PAPXu2PR6FQi0je/6TVSGQIFil6hBEbugGOVif9IAQPrS7t/LjnfYsnHK2T/VDvY22DYSPfXmr+HVFWZMUxetbxGWM98jUobSxcl1C2buEdVp3sE4XNPfvrlEcfF8+ukE7NfOtILn8++5qEdrsl3xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FWu7R3haeuuKoPoEdMiDaF+gVP4yU1AOxS3YCxvHOY=;
 b=IwhvD4F5CbjPDTRxAYR76hB13OdMSl4vFba/RAP9SOQqRHP+Hbvy9EaYUvT9A1n3aCYYUDPfcp8NBKf7BchC6vmKvnsHvBV1IVyloWLtJv1nWj89G9eLu5Zksqv1dKROd2VeRga7O/5E9iGfOyGkSAKVwU3PaJIThGrDx9b2rSk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:19:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:19:00 +0000
Date: Fri, 15 Nov 2024 09:18:56 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Daire Byrne <daire@dneg.com>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on
 demand
Message-ID: <ZzdYULD/nDJHZIEA@tissot.1015granger.net>
References: <20241113055345.494856-1-neilb@suse.de>
 <CAPt2mGN7is0xOqBxy62WwJ_iPXQ0fjvpv2MVEEwYqxvZSFY30w@mail.gmail.com>
 <173164656863.1734440.5228838461812970848@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173164656863.1734440.5228838461812970848@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:610:55::38) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 7167ac43-d082-4eb5-d706-08dd05807308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ji+aOpq/IIyGhv6vEkWoU3vokvoUaXevRbGgR34B0EbEul86eEtPb5rfKvTJ?=
 =?us-ascii?Q?6kqj8mNYL/sSX0zc9UuJckf4+9q+K3eQ59+bCHcUA8d//KmpwRe2D8Ohr07Y?=
 =?us-ascii?Q?BZu29zCxhXFo7hLGPEyVu9ZsPiFq8UjG1ivlZBJa0lzIBGrmEcjdEU3BO2t6?=
 =?us-ascii?Q?Y4OlNV8idnKC9z4XlC0jfLNVb68SDmv4Mr2KS932OFAW03ygfymjIC6VmIdN?=
 =?us-ascii?Q?01pGhn1YP/Ypz+twdlA6TXdVhGR82YNKjmuqUIm1ctaTmP+WZXCW24p8J/V0?=
 =?us-ascii?Q?75fCt+UOOtS6rAXvN/4XjACe9uUe5/vRC44RyOl5Xlw/vFoZGG0QdRt2gyOG?=
 =?us-ascii?Q?w7EDhfvNIzKZoJNNyecJxniT2isVfpwZx6zou9KNuqjKb4NeLTNqqH5MVn8k?=
 =?us-ascii?Q?lT6OHGG7UyMIeerjIoESi+PAeV332OKZpcAyyP4Pa7iAoK13sYFISoFI4ndS?=
 =?us-ascii?Q?xS58NMrxi9CzASZAyExyAZeF0otFo9KSsiL8VCJ9nei5MYXx6Eo3W//22Ggj?=
 =?us-ascii?Q?k22Kl8I5db8WHRb5j0oAm2fhY9UgKfK04GxwFwDQPJvc6C/MKKYp1WiKTnXu?=
 =?us-ascii?Q?m15ld/dyztpv+yxAgNLFV8I3ODx/SbBxoMEv7+grUa+/3J43hwjz1TCyQ6ki?=
 =?us-ascii?Q?h+U4GAvIcMuqTIMJDRannYVXEfAgPPurUddh4T0fxFE+iwLtGGAhJgkVlRNC?=
 =?us-ascii?Q?d2u+dNB3j+0X1PCf7qCU55ba7sEKThOirvSpeoN7ncFSupXhJU3GnWlo5M0c?=
 =?us-ascii?Q?bHp1sIg2U0sPxXTUuAQnQrYPKphQOr2twQplTUdiCHREYjVmha0WuWr2IvXk?=
 =?us-ascii?Q?3vje8fHba36i+5Ifk9hKelSyaJEILCAxFLxTq25gx2p/sCgnZ5t0Ub7itpAg?=
 =?us-ascii?Q?f1oXxa3yqgguFgS4OxJgguXY98Jo+EAXkiLqwjIjLCQfKOS6nYFQB3rMY5so?=
 =?us-ascii?Q?Fi5C8xHna7W0M6NcsQSk4OsBw1kNUBwY/2uItbzinsvGxvMb4j7HK4WtospB?=
 =?us-ascii?Q?sLex+pC8Hmt5HdVG2jgTiRwEYqIjSIv2bEPHWddJW1B5k7MLzQ0bO5DwJy8I?=
 =?us-ascii?Q?//j9qE+nbJDeQOa8Bldmm7ZXTZjC46+DGxdhUs1JWeHGB4CYo90w7VoOTFCF?=
 =?us-ascii?Q?I1nSixqE66w8LfeYvw1dTrJi3AcYtdqlEOHE3gk1h7LvnbrEdeH2TCGhtsDP?=
 =?us-ascii?Q?QXZSM4CYylZ4OmuSwTubYleHIHvDvqkuGDWUGTO121ESmQb0zP9umaxbG7+D?=
 =?us-ascii?Q?bK/tv2Nf+wieGkUeJtm/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7kDERCXIOTFIdWLrZ1qU/LV4yg/f827zjVW+UQD/eREHqCz9TqJYxiBFPxV?=
 =?us-ascii?Q?3cq4VzgxN7AD8hsdaGmPQ24bGCrXiTAdEDt4sl3SKhZ58jJUyXBB6s5YhUoL?=
 =?us-ascii?Q?wzpW5fOO/M4ZMd19MYY70Ppkiwe+THDgOIMJLMwykGE58aOQm0TzMi2cbBJI?=
 =?us-ascii?Q?UE65q291Lu/rFhvjsOrXOP0q8XT/23Uy65J1aN/o6JshTu5Ds13tmEVmDjL0?=
 =?us-ascii?Q?5NWt/SHjYWId6J63ORGMFjh9/Be+uBb5HWcS6HIAcuzzbSGQyHCN6/Bt0VWa?=
 =?us-ascii?Q?6Wz+U/++EoSy6oI8JR00DDMh4MUcYz9zKgH8IcxEm2ARNdSWvn+QbhJTMIL7?=
 =?us-ascii?Q?mtliOKeaZFlsHgp2fba+0FGX7iNEs4OzyRM+rITNhyH6lYBY7LbZ9ruCq08n?=
 =?us-ascii?Q?spzSlLumugV0hf12OoMq57UuxvemSXkOgxmnG3KqWMo/TrItZXyaZzU/ivuv?=
 =?us-ascii?Q?/ZON4GhEaagvqFjoLeQay8VdPfeMnZQCuVIxCQ68+11RVzSPNZDKy/xrMXR7?=
 =?us-ascii?Q?hhVns9wjyEMSVNxA/GEYhQSyhxckZSSRte5HnXbb8PEubu3DNPISmQy67f32?=
 =?us-ascii?Q?sW2y7Q6hr8rS73PR9EEYsydxi4ZXpom7ZPpiw6iyAeZtKBRDHDwuhPGo/o61?=
 =?us-ascii?Q?tIO4OP7GhNx2M/iH4m+AiEZGDp4K9/CCMXENVNhbHQVdZb4/92TowqpFAeAT?=
 =?us-ascii?Q?+fIfy/RDfVPx0V4WCyl4zSMEmVM5e7D0bA1wbT9xtPNQ811wNkLrdYbd8juF?=
 =?us-ascii?Q?X3OAlu8jP8Q4baNdgPYSo6BFUrqKC7W2fcF336WdshIIcGYLQoNn2UJiU0lY?=
 =?us-ascii?Q?LIz8ffhHgaw3aGI+63GHeSzLMdOyBuEGgVk4GCmJ/ge4WysGl5tnCjj9j6kz?=
 =?us-ascii?Q?g4QK2Io0ObMKzxmbtis/Xf4/amMz3nDLppVy3JUEINn6ntvUstSpj0PdWp0L?=
 =?us-ascii?Q?I4M3BkZPHmME3eVMCWGuTfg/THtfgEE4xyLYXV1bqnW/2AgXyrf0JH0Nf+wJ?=
 =?us-ascii?Q?W0f2NMxyW9gmZ6lzDg7jazNMF0ZmpeWPcUkD0p2gfy6iN0eBMcDKWLzSvZPQ?=
 =?us-ascii?Q?wWryDnmMiwWrEpjqz8UBewhPKvhLk/pENzIvqmClh80l5kdAmV7bmuzy4e1M?=
 =?us-ascii?Q?2QjQG8eg/eC2wxaIv+gz/oMe/8gG+GinqdU4lR9aJFF+zMWde+ChuBJXp5pV?=
 =?us-ascii?Q?u/ge4cq7Px+7Yil5T2Lj67NgBYq5TmuPz3mN5DxZj+2l9/iawvdifzaWGdqk?=
 =?us-ascii?Q?8GWh1ffAxDK+li6HEzhOQ9Rps+IQa7RVWnuskPkVIcOF6q806+kQdJ5a3apA?=
 =?us-ascii?Q?UQjA0da10WPTdTxTfyTtf/4IQWg2OeY4nyuFEI+4vBiSCHgygfxAPwMmBXQj?=
 =?us-ascii?Q?YbLesDHhW34nik2FU4RCSMjBujWqVIMFZCKmOnGIGTgp/ECWcXyuG9P+4255?=
 =?us-ascii?Q?J17BedxkKeCZJBBXvzHjY5SerTpNZqUc1MtITG7F9dNlF5vAlmdldjRuBEGy?=
 =?us-ascii?Q?4XOh1QKiUB1hIf0Vo+sOB9kz+c3noMEtXJZbCwMVDwDfY9WCed0I0nmOrDQR?=
 =?us-ascii?Q?ctSLx1cPPtjF2rWnm9qWuyRfOi6+z2gqLeS6sr+K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2LDjo8MHqWJmbr6pPXPF92N2+E/nyDjxr6gNkjDgUWfewakylDS38dJ/LLHHZwiJB9FCfP5g4rY+47P8S65kb/tBN82061HHTs0rzsnyOL9Ns6pguV1GO4w2uHuY3eDM+wNwkSdXR7noFYTklNI6xk2Dvg9nhJK/oGfbNpJZ7axpyj/II8+jsd8mioLZtpTSGjwa5iWG5cZOSY1MXfkHmZneWKwaq3OeUE6xa96pepTa2s20IH/5m1Y0dxLeNPPwW+O37IbwQ870cTEl/70HEsWulcDCQ0vle6xQzv7KcnY95JUsJ1zVAl0RUSyboGLNtrFSbrd0h12fzJrt2oOVABTkwIBCnbCN3XGjJvAXSQlV3j/5DnW31kpzR52/yQwixfFcrKpVRBCYfkIB4A3UVKht10ebewX8PvzSr1/AgFuCLkMsn7qeLHESBD0W7Nt1BAK17j6JZ6WeOkELibcYK4iMX8ZMWFcD5AfHsFL95+ykCNBi6Px1/HB6nKPlLuQLVSGffig16rFn58+sYso6uazwo8dY+gyHlj4giegZl2WNnr/lQpxCLpy4dsAdQd0YihkI7CRQtjR8Y9enwZYEufToHSd+MG35lKrD26jRdus=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7167ac43-d082-4eb5-d706-08dd05807308
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:19:00.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QS15IVS4Rp8qL0znM+rxgGNOaLoRtLKRcyzqLC+c64ak2Eomaji8TYNTMeHRcpXl+PhRTGA7HuYMLEXmvM+npw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=566 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150122
X-Proofpoint-ORIG-GUID: t97oXeUVrt5ERgI76s4Jl-MSqbva9Ytm
X-Proofpoint-GUID: t97oXeUVrt5ERgI76s4Jl-MSqbva9Ytm

On Fri, Nov 15, 2024 at 03:56:08PM +1100, NeilBrown wrote:
> On Wed, 13 Nov 2024, Daire Byrne wrote:
> > Neil,
> > 
> > I'm curious if this work relates to:
> > 
> > https://bugzilla.linux-nfs.org/show_bug.cgi?id=375
> > https://lore.kernel.org/all/CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com
> 
> Yes, it could possibly help with that - though more work would be
> needed.
> nfsd currently has a hard limit of 160 slots per session.  That wouldn't
> be enough I suspect.  The Linux client has a hard limit of 1024.  That
> might be enough.
> Allowed nfsd to have 1024 (or more) shouldn't be too hard...

1024 could be in the range where having a shrinker (when there are
multiple clients with that many slots) will start to bring some
value.

Maybe 1024 is too large at the beginning of a session, but enabling
NFSD to grow a session to that size would not be a bad thing.


-- 
Chuck Lever

