Return-Path: <linux-nfs+bounces-18623-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOdUO9bzfWl1UgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18623-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 13:21:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D619AC1C4F
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 13:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 330543001FBF
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD321BC46;
	Sat, 31 Jan 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BvXm8+Ps"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022089.outbound.protection.outlook.com [40.107.200.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6343019DC;
	Sat, 31 Jan 2026 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769862097; cv=fail; b=lv0+SVyQ3jXOmpEVNYmEYkMmmmorxr8m4CqKKiozsU4/l9NestAG6Dk5vLzqhNjJQ9QOCwiO3wnKAwUOa2xY2p//G9vS4AtRT9GhKfe+wwbQuO9JSLqAyUHDVkbEwK52/32l1G6kFzvcJl1HVyrEo8EpfJAm4fY9ngc60pVcc10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769862097; c=relaxed/simple;
	bh=ROFe/Pr4/aUEhLidaczPjqD5VlIqxFKaTKN5ehVuxzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dT/R4k177fv/AdvmHtTonebHAcF0frTyOWi6wPrZhBj0UD4Exe8Ecn7+zL7H/hFPqTOhrV6zx/kKRhKsml2C9KWvcPY+MkXH5Rwy6vASFxBkc6AJMzw9dvj0oDRW2PPyy2ZJrDwUo8Hi7mekw4zTdplDrC6HJ+eBzsNj8MYiyzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BvXm8+Ps; arc=fail smtp.client-ip=40.107.200.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOd31+PXw7oBVS3swi/xH0VpAJd/iXFQByobLbdwQrLgACI3qNCJMCafCCXRUlYNk5Eg8YVWI61NuLXNKz5lK7XyExtyTbkgDl3bguSqrxY5N3trTcEjb1ucPVywezZ+0rG6/orcW5BNj0n4kZv7aUnlrG8pPz2br0JOm7cNeujhSXuyhnpksEUgfm5b3dVw1Bks4ERJw0+8jf2zNApq+VaAfgB0fhWKOr9QswgL9piiNqIPYmLK8fkW63MsDQ8OM+CRqrCr0xjFfe6iPFUVbGgNabdGgmFs69jZaNK1NPBNs0YYG7yXS9aAI0iFg5kxoX06h2KTmjFAO6yjKXj1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROFe/Pr4/aUEhLidaczPjqD5VlIqxFKaTKN5ehVuxzc=;
 b=ptMr8tNmFKhRd+4tHOpz8M2A9KZJWww6gjBDdOnVhwUUgolQAv34/Cfq80VVTOFugdAWCI6m3T1evaTl905vdiOY5MQplmfNvacMILiDom28Cxn4CDT2duiBLZyLMRQD8QCDjAz+LLuMbg79tWimPqt5UP1jrtLDO7AV6m3ecxlEd910KDgHybSomDa8C6iQ03Eq8T4LO5y5wF9gheRuHZoQe4NTK2/5Q9jl5wjf0L6OYe3UQIBY5nEdcBSaonxrs0AtTUl3lpsI0lK/UPuRmIyIXnjd1CKo9cri4U6b8g7vCfaSzKMTeFuyP51lKdSXSqLB8Hu2KwXTIdPqjLtoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROFe/Pr4/aUEhLidaczPjqD5VlIqxFKaTKN5ehVuxzc=;
 b=BvXm8+PsxLkozSTFwC6xIOatKr5cIR8htiriFF4go98A7ZG3osYZTai8XO0Zv3P+y1k5MmgX2D0McH1IW+1sASKF9w2OveFHnWBqJhcBE18U5dP5G+GGRaNoQXJq0RLIbC04M/Xe8xWgG9CsdY/ARBLohHpsxqQ9kWzZEWOpdc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY1PR13MB6213.namprd13.prod.outlook.com (2603:10b6:a03:52f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.13; Sat, 31 Jan 2026 12:21:32 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9542.010; Sat, 31 Jan 2026
 12:21:32 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: fix memory leak in nfs_sysfs_init if kset_register
 fails
Date: Sat, 31 Jan 2026 07:21:29 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <9EF0F792-3B22-4A20-8A37-9C4B2236740C@hammerspace.com>
In-Reply-To: <20260131000937.229276-1-salah.triki@gmail.com>
References: <20260131000937.229276-1-salah.triki@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:510:f::20) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY1PR13MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3966b2-ce4f-4893-e9e0-08de60c344bf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R5ZqQHG5fH3lAFNuae1Ew1BQtUuG3bk3jG/+albqMD/PjFUDO0L4S/wAcH6L?=
 =?us-ascii?Q?oZteMs39yP6NtrDCjWiHIBnYoyTVKT7LNla87q/MEKJrhLt0OLeX4EmocT//?=
 =?us-ascii?Q?Cj2L/i2jsn9FrsYiA5mMGOkaCzEYW8OHzfhHxa/WN2ovPEFapRG4K7RCSz5n?=
 =?us-ascii?Q?2fDSrVvsw55S5Far2LiDWfsdVAJu/aJAPgnE16jIZ3r4gB7OzjwNUyDC6K+S?=
 =?us-ascii?Q?m8E6C4d0xxQ5kr9Sx+d0UYVHYhlhMYxakNRWU9aOzMXm9sPE1D093xujXX6F?=
 =?us-ascii?Q?JPwK2Qatb+n8aRCJWfMTo2fO5aByvoaJPxilEw+wSSv88YYdA8Ctqw8VtnzD?=
 =?us-ascii?Q?u58CVyxolXg7hFdF+S1Y8bTZMeP6DS+1B8WuZOsezQ6FSIzOgOzm0R8w/oqd?=
 =?us-ascii?Q?Lv5AXrMBEtIPGTuGBvLPAh0LQ/hv02ZqwKW3cV4NIuM60sgOl39nNqjV0625?=
 =?us-ascii?Q?oc7pe8eUJOv68rrMN0XPeHPcDFjM6baaLCDOIyz+kNV77PlKZWxqkvkpeMbW?=
 =?us-ascii?Q?Dmo2JQhiTogGYy9KblhHVMHGpFvMIRyewRxF7K3Ad97uVHvX9eGng0C7ePAb?=
 =?us-ascii?Q?coH+Q59fL8gtRDS8kyrGay3c74Abo45oEuKGaiQlsqF7QtbUluzlCQhZw8m7?=
 =?us-ascii?Q?ejVxxaDhhKbxMHcTi+0KxAVqJbBeblutWEauXqamCppgGMlh/VtNK+GXMMZx?=
 =?us-ascii?Q?g24HfHFc0/e8nfXCykhMnEwhoSct8T91bZ+vJtlxAr+AB8W2vLtFzX+cY6mH?=
 =?us-ascii?Q?DTwhwt1xJSULXHFkumVN2Z4zy8E9vGBfcE13OHu89rn8ZQNeMCwiOplTWcdP?=
 =?us-ascii?Q?sWuKVfbUFCJqE/YCrgYGPVd3UHv4JJwrDOXyjY6Yre8w8GVnzzUbNAH0y5Ee?=
 =?us-ascii?Q?Cib8fTQzA91YeY67PA6XMvhXKIV+RkCA8wS69e1FEkgIsej5pvmUyPhmS3eD?=
 =?us-ascii?Q?qX3CNCy7dHtn9Tmzb4gek7uF/SSBtDpf8RJ3mANumcqdjC1DLcwwNL6p4i80?=
 =?us-ascii?Q?yAiq0hzlv6vWopPZrUVJggi2/rYkLdp2pK9IF72SAtTeF1hShV16myni5FJU?=
 =?us-ascii?Q?TrQKx5MQjWomy8g0R37h5ZHoLBZeZM2NqRXCraL9MET+e9d3ExA87VIHaph/?=
 =?us-ascii?Q?/OVLbPIquilQwUUMt8Mnj6UAdob42y9u1AkZFulKW0/8G61xfraNygAv/SGx?=
 =?us-ascii?Q?+ieKWiPqKnBGvFsJQfpPvCVB2NBLfQoVLwdqI+o4GF/V1OW+tZjGAMhu9w8C?=
 =?us-ascii?Q?MrVmAkh9/QyIR1OzyJH0/Gy2teM/zYvji8I0gvMlpB6oCwMpZ/EZ6XMJ/kFu?=
 =?us-ascii?Q?Z8ElpNNJcwxQJuaWm4qQpWdPzK8N0RpvmOS4FB5bKlQpn1zmeDSTwViCE2VQ?=
 =?us-ascii?Q?PTUeSTBSIZC20TdRrDyUULhgmBU74Nkp/LENtj+QK+zJuAVC5K9+h7c4QuJ1?=
 =?us-ascii?Q?ZNQWTmrTqM9LQlih5spxL+8SgAuc8wX1W6XNiQ2GTzPpFOClan3IlETd4nEl?=
 =?us-ascii?Q?6n1b88QQmJbsUVUm2gnatxq4/2wlv5DWh03eh7VgDpKAnF7lj/LJg1lGDNv8?=
 =?us-ascii?Q?urgkNTGL000dGA58Iwg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWEPtUtcPMfeKyVM9P3PVsYXze5OqMwkMH80AzOea9BdmNhU4+ZAGtRQg5gJ?=
 =?us-ascii?Q?RBvBcBgmxOMbCDIEUZPQREAPLmi2DuWywizcZBKy8/4Mp8w/E9q6VH5QaAEH?=
 =?us-ascii?Q?vSBoRD/Tzn/oKxaSsqzzOZja0sIb60+57cIlU9JADGoG/+M6nyVFZdk8ly/p?=
 =?us-ascii?Q?Ko8BIB9Oj36DBAMdByueXHP6BGnEhtFjBpmpaijWsLG7l9zbax97zobZZkjh?=
 =?us-ascii?Q?mGdSR6YaXLL+BzGREOlKIUE9ZnR9zlRGm7ZsECZ1EYxxGaLXIRA9WNJJZCpw?=
 =?us-ascii?Q?zBq6THAFizi3vT6FlQ58R9uRDyIGLhrw9/kSarcXwXIvWSgLgDWhWPt0O3b5?=
 =?us-ascii?Q?OGN8YkNBJDMOHyPw662iJ0r6fPqTjkBmSkqVm/COsnw21P91A59yKysXAwkc?=
 =?us-ascii?Q?+vhpCwZiv/OlyI72KiWWr2w2yf826RkuNtybZgV24n/xU6PszDYIPksz0798?=
 =?us-ascii?Q?USefgnco8RKEQ97sm2dUzPc+y8X2oH9kxGAEE8lp46No514PO7Wc/lCVEHlf?=
 =?us-ascii?Q?+c5GgOvMgeTa3a7nPnsOpnyVm9gJm+EYuqjEXi3cNXNrluZP2AzU75n3tHcc?=
 =?us-ascii?Q?AlvKEmbcgHXoSqP9vgfQqGJfNjzAm0TrlukjipQLzdHvB+nv28iTv2DM7ckn?=
 =?us-ascii?Q?UbFGrSxpOSO0W4KpnEjpu89od69kuiWVOAaBjQOvyRe/DbsEjZTKidgBhVHS?=
 =?us-ascii?Q?HtXQ1l3F6q8BUjTDgrkG0YkDpCGaLvgHctbDSe853d4Ve1qjXjg8BBfnupLZ?=
 =?us-ascii?Q?1d80sV5zj8QOLugADfQxLLmNixDowuAvo6sb3XPQaiUtw56SSuCNsjP+9lgO?=
 =?us-ascii?Q?yl/y1CtY/WSJ931/We/szpSJ3FaMC7Uspeha79+PpXFRpy6yCkGzYTkm9O14?=
 =?us-ascii?Q?mQAh9ZSbzMNvhMpbpcjGbYBmc6nFME46zSmk+hlTf3XiAhWZtpTF4zhqHVuh?=
 =?us-ascii?Q?feRp9txrGcQjpO5YU6HKvWUNRD1NsNpmMxuqzFGLmP9bvFAQupISpNKBfayF?=
 =?us-ascii?Q?E9d7YZfRoqHG0UYoLER5UkIxauAvLbMMiwe0rXNV8esGwyoCv5oTyHhVqhW3?=
 =?us-ascii?Q?jLR1xfR175X9po8bw5O/hLCYSTlt6hFlclFfjHf1OSKM+L9oqV/6JsI+MlAM?=
 =?us-ascii?Q?Bh2b30iMx25sF9Ec3i/tuvwAfV1YhS63ckLb9YNCocViLqXln8k8a1vA291J?=
 =?us-ascii?Q?OXEuObREHAMoiTZpSPh3EgCcWBwQ450mCvGOF69SOXUbQ7XRWhIt5frKwnTP?=
 =?us-ascii?Q?TAiq6jU/jz9RiDkOzv2046tjg/VLp6RMw/SiR174E2inv5IesrpPglB/qmAW?=
 =?us-ascii?Q?ph5weYBklXhryAsUGBiwLBjRzhH81VvP4UJYkxl4qm8RouABoa3sy15u/nKE?=
 =?us-ascii?Q?ZlxEPprLkxSaiF93vUg8jCE3etaWtEhOoVj8jZObe65B8akcwC4PeZc+K2bv?=
 =?us-ascii?Q?j6dkfROBF1Hu9Z/mKrMx+/zySYebTbmF6tWoeH3kUKUpG9upV2kELurIQeSm?=
 =?us-ascii?Q?llTmp+YPRuuEzlyNwaLNKw41cj+1wxNYt9qrcNY21A5dvNkrtlFI+kw3I08f?=
 =?us-ascii?Q?f1moC2h4dNbjOL6l8pOeNtyWtEckJ1hg0UBFZqE7VE22Aogy9EYBRnnyeEOh?=
 =?us-ascii?Q?SpVunP2N9WahVhJ9VTcUQ8/WQDZszZ34QrQrdRIQonJZQFSf1l7RZC8+GAgd?=
 =?us-ascii?Q?DySVXe15fhl5NcOQ0UeMIG3cN0YXxt0wUj7od+H74l0emTFYFvkzE99bVenN?=
 =?us-ascii?Q?PgSDYnQNGT+HsZjkTR5QW8kDbSpiPA8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3966b2-ce4f-4893-e9e0-08de60c344bf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 12:21:32.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIGY3x/ea514IAo1gtj673+btx01OQgxDG5eDFytjwLWw1bNWfIRp05bm24U42D0f9wkeV5UvpnXQl0eRchXL9Vs+Gohmd8c+R3MAaI0Z7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6213
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18623-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D619AC1C4F
X-Rspamd-Action: no action

On 30 Jan 2026, at 19:09, Salah Triki wrote:

> When `kset_register()` fails, it does not clean up the underlying
> kobject. Calling `kfree()` directly is incorrect because the kobject
> within the kset has already been initialized, and its internal
> resources or reference counting must be handled properly.
>
> As stated in the kobject documentation, once a kobject is registered
> (or even just initialized), you must use `kobject_put()` instead of
> `kfree()` to let the reference counting mechanism perform the cleanup
> via the ktype's release callback.

I don't think this patch is correct - the kobj is not initialized yet, and
on error return from kset_register() you'll likely get the WARN from
lib/kobject.c:734 kobject_put() when calling kset_put().

That said it does look like that path might leak kobj->name, you might
look at doing kfree_const() on it.

Did you test this - how did you determine this was a problem?

Ben

