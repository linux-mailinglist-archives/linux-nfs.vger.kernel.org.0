Return-Path: <linux-nfs+bounces-18706-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAovOCxZg2mJlQMAu9opvQ
	(envelope-from <linux-nfs+bounces-18706-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:35:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27502E72D5
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD9983007510
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD59347DD;
	Wed,  4 Feb 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="bnEDIr6r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020094.outbound.protection.outlook.com [52.101.193.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751C18EFD1
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215690; cv=fail; b=hIZW1wAROLRPR0Bfi8KlNdrFoK+gEb7RQbtuIElMRUg2SelFF1AGf53iJol58hXoGR/iGFa1xnn6TdEwp7dd/jOxF1LxSQ/4siJOILWyYuWkGfr9PqDSFbVNR8z4hkFGaG3iJcSCrMJB3H0/1jwxWa1I64ChcV7qSOsm6swo3yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215690; c=relaxed/simple;
	bh=+cgJe6347qE5KYoWcSohyhcbKRcr7SPPuKMLx+ddbEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AyI14hA2Oc1g3QkVfiiqxyr+sO7mfcWRRGRUu4EMq7SeIEs1nlqOa9xGk0MY4Z0ZtD5cz6WB0C6B0p/2SZzlMfTTCptNaMHssVcCrP9QtV+Z74ilDnaSTDRRpfkn6iWfG50rciKSme8ccM/1HRHgWZY+iWsOFnrnb59qotZblwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=bnEDIr6r; arc=fail smtp.client-ip=52.101.193.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFHJgKFAajL5pN2jzSkCzt9S3vb/TERrwHyvoTtuGrQFJH4vLCf7H/Y55CpZsDwyLq9y5iQ+HNqUcR8JijzbI8IQ/HeG3o7z0OvnvfEoo+I6IOJieuTfJ9mDkyttkCj/BRn5wnP/9+1ZItAXjabLOaKrC5eoEFAm2IjfdOK/Nxu8nngtuJ/MWx/SJZEEKbT5ERky8hddQH/pl6kz9n7X18M778Btu0+QDEk8AxGFcMH9nPq/wezha+fBpjH6d4GuFKz+senxct9DQKSXjmFqpXqslaljoorjNK5As0GNyyTDCK8YKe7F8SEfnM7JXpApLyrtZTLT7Z2zLXp25QSqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+kyLsaq6Hl7uh4o153b5DsGYJ2oxlna3+GatAKB814=;
 b=Ui+YxZeUoQSDSKs7ChDyRmWtvFUDVKCEkIi/SoGm6jC8UsstYcnH4tjL96PYZnn1+wApj0auAe6GYdniZsGU2tEVuaeqIgTG7Jggqjjm+UkyLZF5A/5+7LsbCHNdBaqF5OAoxBCravKuaEhs52QZ1Ga02Wyo+YJW2cPJVVb7iccLIAODvAADo34dZp/GtssgaHuT5ntlmXJE/Ra6j10mWxSukaHOegm/VIFl4fBiRarnTiigrVVffW9uEgE7GPYUZ0zvC5N+VfUnGqCm8uipgU4DYaBIf/lfCQrPRqazjasrSVA5/QpDYCJhWFbtqrALO4FBt+mpAQCKYvqXseqN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+kyLsaq6Hl7uh4o153b5DsGYJ2oxlna3+GatAKB814=;
 b=bnEDIr6rEu2MagYhgzSWYOJ97ZDLoCBGjIcDGIPX1UyIUFI3kf5NhkJXgtWZBo5LTrv/86eDlnJCxI0+fz2rubfjBqCnBQWq/Kh1Fut+UdzQ+NdiFygCQHfKrbdKdl+uca5Vuric9xWXGzYahOM/Mu9sTRROmbF97nrvbR6/PwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BLAPR13MB4675.namprd13.prod.outlook.com (2603:10b6:208:321::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.14; Wed, 4 Feb 2026 14:34:45 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 14:34:45 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>
Subject: Re: [PATCH v3 2/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
Date: Wed, 04 Feb 2026 09:34:41 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <E53EB602-0C16-4E47-BC80-D1CF752C9F0C@hammerspace.com>
In-Reply-To: <2edec478ce219943dfced2884f646687c7117892.camel@kernel.org>
References: <cover.1770051230.git.bcodding@hammerspace.com>
 <1b3bdf869fe4075689fd29fe3fdb669ae3ea920c.1770051230.git.bcodding@hammerspace.com>
 <2edec478ce219943dfced2884f646687c7117892.camel@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BLAPR13MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ef9b05-42c8-420f-73dc-08de63fa8a71
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?paMztG+Hw2GCK8093pDlsfKb+yKFmzLvt+AND2lZvYDZQgRHkbJtKvOPhzU/?=
 =?us-ascii?Q?8inbdrCdYPjFUjBk0jCac4snp5nubsv6D2OMd7CxA2QxRtB3mNFVR85Uy1wC?=
 =?us-ascii?Q?uANzwbgdUifjVDSSGShEgjvSf7uSwSHMiuIYJ9Yi3UzhGoge8fQrwbbFFIT9?=
 =?us-ascii?Q?LOazK3Zvj9Nz7OwqEBaZ3RabXLluarpXkiWayM+KISL84t7s0vwLeeZJvAyg?=
 =?us-ascii?Q?zLtuayyHAcQQXjRZETaKiZvXsWVPnwKofn2a+sxal3m7BLbx6ZFZHrTVwPEx?=
 =?us-ascii?Q?R8F21fcn37KpDJeHgWAhiUBJenAkYrRWcFbSDdHNxKHIPzfKzAVAK/35QGp5?=
 =?us-ascii?Q?SkVCpVXVN/AruWQPAH8zMOPVUEHHA6jW0aIMzSQZOwtx9ooYTR1v75WaQsn5?=
 =?us-ascii?Q?xSt4l7IfPGJQ0Kiiwdo2k2pAL3xgETbAYYqiYvbWBlPQ/rJKXzjqhUWovuNC?=
 =?us-ascii?Q?mjc435VabNVWqo1Ad9eXSuswXA7bMlLw6/hE5q21sfXarSshFRKmT0bRS4EO?=
 =?us-ascii?Q?kqLFr5uX46V4B+ncqaMZg4xW25U/e6/rWPAfHWaI58BP6Y9OftYzWasSVb0R?=
 =?us-ascii?Q?IQBV/qF6+mSN43wBsMe9vf5a3W9Yea6kVJPTguX25viqiOtqTz1ZaIm4ISxz?=
 =?us-ascii?Q?civLKruLb7Uqah85KVbFaAn3u05lokmx6oo8smkcTWVv2CrTF/bTlrMF3O2z?=
 =?us-ascii?Q?cPyhVU0+DkUDfKFKg/dlmU2iNHSpr0X8MgB5ocoaumu8Ijk7QW7RROwLKV2Q?=
 =?us-ascii?Q?r4f3+woNczAReYIoVZbe2REoewbbuCCQIoEM8L5HRq+bLfco+xxiTRV7QQAY?=
 =?us-ascii?Q?SVtPjmjwlO0EHIJo9WWwW+Q4aAcJCe+Cb/aAo1byGEd5FLO90ks+WZD9mRSD?=
 =?us-ascii?Q?BddkQs98DcHi0WQWZumMIZyR18KmR+3lOZDDESuKK61ee95RfrqknEXIydCs?=
 =?us-ascii?Q?81pEWtMqjaLNAEA+pUHc9qFRPMTmnLmvJoCprYlrpxptbxjQBbEPYiCpYP28?=
 =?us-ascii?Q?bJOwsKxFUy3DfRNwWvfs6t65qigfSFTi3GuCbdTJjVJtV4+1NRw792sHx0yf?=
 =?us-ascii?Q?iwXkWGcL1k3+odlUO5sEvyNH39JEQtEorF0fnoERDZ6EvO/BEFDdH4KfhFXs?=
 =?us-ascii?Q?hH0L+TK4CNDDmxnyf7nFPqCZ2q5omzSdEgzPHHDWJ9LHAkeSKMzmivqgUaE0?=
 =?us-ascii?Q?NMJul1LII/+deMXua6GWGq2QdcuKZny15ENAyskHsQHNme47lzP3sIQC/Cnb?=
 =?us-ascii?Q?30jElCMvxKc12aeYDRhD8D+P+ofJZElKN5mcGQQdJ7Bf+OxpEy1BO9PYuUam?=
 =?us-ascii?Q?x1Cuq/9zyM3pbObxfXkquciU0FGc8lJeWXLLTlmV90hviSphfdw2/zDyjh3i?=
 =?us-ascii?Q?tJBesDP+2WZIQ712u/hAgCupNgRqWSRcVPd67Ge0ikEB+xk5skiyCWy+Ueka?=
 =?us-ascii?Q?dhOoMFDFISHd7ClBfvnCMi0tkj5U0M4zUGH5caHoFl+OWyZLvsbZwk+oaAnS?=
 =?us-ascii?Q?B1hcDJabC8r0IItxW0Z78JMk4XUDqCGT9ggfpgyOA52ZdWRMlSeL4oNzVVuP?=
 =?us-ascii?Q?+7rzDi8qzntvGwuG0b8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S081pGGn4PcENo4BCNcsHPEjd5AE4w1CXEOuvUPzFi5UWwYHs9B6djL2sYcy?=
 =?us-ascii?Q?e3+G0/4leCfnLeTJgmwUz/Hhhn0mfd4/MECGjK2+qjhGJ4ok6DupSPkNNk0R?=
 =?us-ascii?Q?5rIfNR6sY5emXi0NuzAnHOd3EOpzsPDkOY+acbY8fpL6yJdaIrLImcghIAmd?=
 =?us-ascii?Q?z3H0qPS2SQsqBSDIEw8VGjl4Y/S08PjXhQTpmzsBkKcgm8L4dHQkbPL1Hwq4?=
 =?us-ascii?Q?kZeNDzIo+SfxTe+2FZrVU5a1CQOF5B2rd1AMKgxztWqPDUjrmIh8h/8mHpm3?=
 =?us-ascii?Q?ltP7qkh1mn53CuyVJFDMhQOUNW6DzKbGhJ563KFChPCtgZ84VTrLpgapAFcv?=
 =?us-ascii?Q?k//tj4TMfvDadAtcpE0NJtPimbn+fi5K91sWE7SYEqCMRbZRiQYQT0ur17L+?=
 =?us-ascii?Q?okSWWZ97QhP0XD6Pf+g5f0iQ6BYobE1plLbUipmcocV5TR28nytBnI9OtI1W?=
 =?us-ascii?Q?r/bpb0ZM80Ghp1U9rkCbUssprKSF0RzzRhDNnod7/awR5fDRB/RvoTaTTv+x?=
 =?us-ascii?Q?v/FxEQFfTApYoPePrWcEj6VRi5US5THWBoLaz1sk7bKumOi0oTxLDcAQZrSh?=
 =?us-ascii?Q?X5cllPTCcL+XWIfbAmJvVdojRqXRLCOWalZOhh36F6P72PI2pdGtjW2AJmXT?=
 =?us-ascii?Q?hLUi43wvDF83xHqkCwHePIpzYAQMtnlElr2UZI8YXqu6v3XwrWmkx9MCfVHp?=
 =?us-ascii?Q?o+xWddCe6JtzPV3rb70Wa322NpgLqOABUDJzagSbNeKhzgEnhZE5Z729kaCa?=
 =?us-ascii?Q?8hhHXBVWb0SNk89dXxrlNRMu4vyadC0dNOR/KTkI/qC/JBqR27OQQJxsc5f2?=
 =?us-ascii?Q?Gq6hwrin9P7ot8C8HaODcJ3lW+OuGaByK4npxEsvlSbaMlVUfktF+UzaiEck?=
 =?us-ascii?Q?fFnqQnaIFhh0jlJGqOMRyM6TVvH/aRDAu0nzvKlRj4XftiFtxtyGQe2/O+vi?=
 =?us-ascii?Q?uIr4EOcens15nFLHJ6Ix2ZhdY4KVxIswuk8fZ59dsLkmQcMs/a/oBk9vpho3?=
 =?us-ascii?Q?tGdw0ExAFw5kNA4TIwhd6yFMEri84XKbJdSV/7K9hZ60DVfycRWSjOLmZlhC?=
 =?us-ascii?Q?BTzvQhfLZFaWnsoWBGqYocH9XWq7By4QX0aYy7wDMM84RjrVWEGWQvjilyii?=
 =?us-ascii?Q?5hfyF7RNucePAKK05npfZlOcVLjLhQmm0dpo8kKu/KkASdOgfqXt9lYc1ORk?=
 =?us-ascii?Q?LIvdpeoIEVU3rDGyQHXWqyb0nwxmsdizW5v0r0W3hpPJTPp7+O1r3RieCJO5?=
 =?us-ascii?Q?aGeQJZVHY+KscGsY6OLBcuhBWIvGcoM2jvRP1TodGfoiy0XMwVB9ObnZzYtm?=
 =?us-ascii?Q?N8nOokIlmeUJPguXcC41/WJaP3MnCbEEQp3QPRlPv//hcokYwwaEbBXWUlf3?=
 =?us-ascii?Q?Vn9535dp9voCJdFa7KL6OAyds0VTX5shGY1SAYmuwT8gRnGynCB6Opa2oZs3?=
 =?us-ascii?Q?/xCUBnJtaJJDqRATekgC5uoCCZtLcYitFsKvqfZwUPAa1VHdO7JY7xewm/aK?=
 =?us-ascii?Q?OE8c6sKmtfkp6C0xPVhj7oIWJ1aQ50ECr1d5h7Q4R0/KHgcE/LfZE9Lw8+0N?=
 =?us-ascii?Q?o5cZveHdmEkyqTSKG3YNvq9supMB9ChsvtVxbsEJ83QahMD8PTm1J9BcqpWz?=
 =?us-ascii?Q?6kVMr1r1a5uCnHD31zv0REER/rOG1skmb1CdfPcoxC4kynTYwXYpqghGbeel?=
 =?us-ascii?Q?MbNv8oGXHlrLgweqAYnEd3Z5TuoB1NSBByUpTtLaZ2gHD9DyKMkXCNySMNvw?=
 =?us-ascii?Q?4V8I/ZhCaNKCy42NDEtwMyNni/vTFIU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ef9b05-42c8-420f-73dc-08de63fa8a71
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:34:45.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FABynUib8mIwjdNwb4wmwfrqkaWhRv6p3pDkAm+8/xK97KytNhlSZ6o0SFwI9bvcBiVOOadN7x7IJit6EWfrF6LU2MsRMt+mnHv82z4UgsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18706-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,libnfsconf.la:url]
X-Rspamd-Queue-Id: 27502E72D5
X-Rspamd-Action: no action

On 4 Feb 2026, at 9:21, Jeff Layton wrote:

> On Mon, 2026-02-02 at 11:59 -0500, Benjamin Coddington wrote:
>> If fh-key-file=3D<path> is set in the nfsd section of nfs.conf, the "n=
fsdctl
>> autostart" command will hash the contents of the file with libuuid's
>> uuid_generate_sha1 and send the first 16 bytes into the kernel on
>> NFSD_A_SERVER_FH_KEY.
>>
>> A compatible kernel can use this key to sign filehandles.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  nfs.conf                     |  1 +
>>  support/include/nfslib.h     |  2 +
>>  support/nfs/Makefile.am      |  4 +-
>>  support/nfs/fh_key_file.c    | 79 +++++++++++++++++++++++++++++++++++=
+
>>  systemd/nfs.conf.man         |  1 +
>>  utils/nfsd/nfssvc.h          |  1 +
>>  utils/nfsdctl/nfsd_netlink.h |  1 +
>>  utils/nfsdctl/nfsdctl.c      | 35 ++++++++++++++--
>>  8 files changed, 118 insertions(+), 6 deletions(-)
>>  create mode 100644 support/nfs/fh_key_file.c
>>
>> diff --git a/nfs.conf b/nfs.conf
>> index 3cca68c3530d..39068c19d7df 100644
>> --- a/nfs.conf
>> +++ b/nfs.conf
>> @@ -76,6 +76,7 @@
>>  # vers4.2=3Dy
>>  rdma=3Dy
>>  rdma-port=3D20049
>> +# fh-key-file=3D/etc/nfs_fh.key
>>
>>  [statd]
>>  # debug=3D0
>> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
>> index eff2a486307f..c8601a156cba 100644
>> --- a/support/include/nfslib.h
>> +++ b/support/include/nfslib.h
>> @@ -22,6 +22,7 @@
>>  #include <paths.h>
>>  #include <rpcsvc/nfs_prot.h>
>>  #include <nfs/nfs.h>
>> +#include <uuid/uuid.h>
>>  #include "xlog.h"
>>
>>  #ifndef _PATH_EXPORTS
>> @@ -132,6 +133,7 @@ struct rmtabent *	fgetrmtabent(FILE *fp, int log, =
long *pos);
>>  void			fputrmtabent(FILE *fp, struct rmtabent *xep, long *pos);
>>  void			fendrmtabent(FILE *fp);
>>  void			frewindrmtabent(FILE *fp);
>> +int				hash_fh_key_file(const char *fh_key_file, uuid_t hash);
>>
>>  _Bool state_setup_basedir(const char *, const char *);
>>  int setup_state_path_names(const char *, const char *, const char *, =
const char *, struct state_paths *);
>> diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
>> index 2e1577cc12df..775bccc6c5ea 100644
>> --- a/support/nfs/Makefile.am
>> +++ b/support/nfs/Makefile.am
>> @@ -7,8 +7,8 @@ libnfs_la_SOURCES =3D exports.c rmtab.c xio.c rpcmisc.=
c rpcdispatch.c \
>>  		   xcommon.c wildmat.c mydaemon.c \
>>  		   rpc_socket.c getport.c \
>>  		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
>> -		   svc_create.c atomicio.c strlcat.c strlcpy.c
>> -libnfs_la_LIBADD =3D libnfsconf.la
>> +		   svc_create.c atomicio.c strlcat.c strlcpy.c fh_key_file.c
>> +libnfs_la_LIBADD =3D libnfsconf.la -luuid
>>  libnfs_la_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/sup=
port/reexport
>>
>>  libnfsconf_la_SOURCES =3D conffile.c xlog.c
>> diff --git a/support/nfs/fh_key_file.c b/support/nfs/fh_key_file.c
>> new file mode 100644
>> index 000000000000..ee26df5b70bd
>> --- /dev/null
>> +++ b/support/nfs/fh_key_file.c
>> @@ -0,0 +1,79 @@
>> +/*
>> + * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
>> + * All rights reserved.
>> + *
>> + * Redistribution and use in source and binary forms, with or without=

>> + * modification, are permitted provided that the following conditions=

>> + * are met:
>> + * 1. Redistributions of source code must retain the above copyright
>> + *    notice, this list of conditions and the following disclaimer.
>> + * 2. Redistributions in binary form must reproduce the above copyrig=
ht
>> + *    notice, this list of conditions and the following disclaimer in=
 the
>> + *    documentation and/or other materials provided with the distribu=
tion.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS =
OR
>> + * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WAR=
RANTIES
>> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLA=
IMED.
>> + * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
>> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDIN=
G, BUT
>> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS =
OF USE,
>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON =
ANY
>> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TOR=
T
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF
>> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
>> +
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <uuid/uuid.h>
>> +
>> +#include "nfslib.h"
>> +
>> +#define HASH_BLOCKSIZE  256
>> +int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
>> +{
>> +	const char seed_s[] =3D "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
>> +	FILE *sfile =3D NULL;
>> +	char buf[HASH_BLOCKSIZE];
>> +	size_t pos;
>> +	int ret =3D 0;
>> +
>> +	sfile =3D fopen(fh_key_file, "r");
>> +	if (!sfile) {
>> +		ret =3D errno;
>> +		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, str=
error(errno));
>> +		goto out;
>> +	}
>> +
>> +	uuid_parse(seed_s, uuid);
>> +
>> +	while (1) {
>> +		size_t sread;
>> +		pos =3D 0;
>> +
>> +		if (feof(sfile))
>> +			goto finish_block;
>> +
>> +		sread =3D fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
>> +		pos +=3D sread;
>> +
>> +		if (pos =3D=3D HASH_BLOCKSIZE)
>> +			break;
>> +
>> +		if (sread !=3D HASH_BLOCKSIZE) {
>> +			ret =3D ferror(sfile);
>> +			if (ret)
>> +				goto out;
>> +			goto finish_block;
>> +		}
>> +		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
>> +	}
>> +finish_block:
>> +	if (pos)
>> +		uuid_generate_sha1(uuid, uuid, buf, pos);
>> +out:
>> +	if (sfile)
>> +		fclose(sfile);
>> +	return ret;
>> +}
>> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
>> index 484de2c086db..1fb5653042d3 100644
>> --- a/systemd/nfs.conf.man
>> +++ b/systemd/nfs.conf.man
>> @@ -176,6 +176,7 @@ Recognized values:
>>  .BR vers4.1 ,
>>  .BR vers4.2 ,
>>  .BR rdma ,
>> +.BR fh-key-file ,
>>
>>  Version and protocol values are Boolean values as described above,
>>  and are also used by
>> diff --git a/utils/nfsd/nfssvc.h b/utils/nfsd/nfssvc.h
>> index 4d53af1a8bc3..463110cac804 100644
>> --- a/utils/nfsd/nfssvc.h
>> +++ b/utils/nfsd/nfssvc.h
>> @@ -30,3 +30,4 @@ void	nfssvc_setvers(unsigned int ctlbits, unsigned i=
nt minorvers4,
>>  		       unsigned int minorvers4set, int force4dot0);
>>  int	nfssvc_threads(int nrservs);
>>  void	nfssvc_get_minormask(unsigned int *mask);
>> +int nfssvc_setfh_key(const char *fh_key_file);
>> diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink=
=2Eh
>> index 887cbd12b695..10df6d750fa1 100644
>> --- a/utils/nfsdctl/nfsd_netlink.h
>> +++ b/utils/nfsdctl/nfsd_netlink.h
>> @@ -34,6 +34,7 @@ enum {
>>  	NFSD_A_SERVER_GRACETIME,
>>  	NFSD_A_SERVER_LEASETIME,
>>  	NFSD_A_SERVER_SCOPE,
>> +	NFSD_A_SERVER_FH_KEY,
>>
>
> I forgot this file was even there!
>
> We'll need to add MIN_THREADS to this before your value, or this won't
> line up properly. I suppose if we do that too, then we can rip out the
> autoconf check for that constant as well, and get rid of the #ifdefs. I=

> can send a v2 of the series I just sent that just does this.
>
> You will also want to rebase this on top of those patches, so you can
> better handle the case where the kernel doesn't support setting a
> fh_key. I suppose you probably want to throw a hard error in that case,=

> since being unable to set the key could be a security issue (or cause
> stale filehandles)?

That all makes sense - I will do.  Thanks!

Ben

