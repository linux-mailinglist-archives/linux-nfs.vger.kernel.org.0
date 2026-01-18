Return-Path: <linux-nfs+bounces-18084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C4D39833
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E55353005093
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jan 2026 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AA21A9F93;
	Sun, 18 Jan 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="IQ4JPQiv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022089.outbound.protection.outlook.com [40.107.209.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C9500976
	for <linux-nfs@vger.kernel.org>; Sun, 18 Jan 2026 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755633; cv=fail; b=Nr0+h7TPjm0/siXpmU64lYRmwFBFBvqxvSvdtjBh5FJL9GTpCUn/sbhJI9mGsAmXhvnwqaCQZ6CKHFXzn9JBF3DZcT3J6uMNlrUPU/eTJATKPpOb2geeeS8s3FIG7p6o/9EO8x+TEYlWG5d92yj9/OJ0zEPW3eR4CuhwB8lvxCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755633; c=relaxed/simple;
	bh=BnpZ6a9EBVXokO7vAkzdUHB0CuAGU4XJFSIbL1xhsAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwlaZmi0s6mYyyBX1++pGUl8uWRjP6r90UkAf+QBrZaKVv5JzeCjU6GqbqBrv9X6DQ6lgwWRA3HlOc1G9WbT5NMDKEqrbxD26X9xrqps2Co2mm6k3mr+gPif+PYXfOnoaaHgSqOD5l/DMrKxf6kS41ni/GVfT0MddUT0323bnAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=IQ4JPQiv; arc=fail smtp.client-ip=40.107.209.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxzsN3BliRiFcr0FSWCUEqJPnCuqfG4jpuUBtuzGroEKrIV6VTxhkpvnp9RvAhl0U3bqn0gDWOUKdpCVQFyusnGDVD584VdxdbTuDZSI+UXIensDCzL8CV+Ik2r2n9wi1C/y9bxbrfRlZqI0kGYLV+z5BoPOsBCkjujcXZDNfpzdR/4ZobIZD3iIrOJs++0RaH8P8lZVPOX7tLkbb+uw7myCMWcRtZg/X27Juz91KeuV/T+zzLtlfljVCoU/GwmDZ42cgaTbXtQGhKBSfUxKvzBy1a6hAYeA4TCEB6hTEL0dw3+qH6mB1sMo+5wcFLy5gfnIzIEtq01euwNAr7ykLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwHueWpBQx6bcmgKba6W7ewOXPOJGkoSkrflgxHGOcU=;
 b=OzDvzoTDO/Mfn8Pk/PnkavcXOlsO71dsKR5Hi6Q+AoicydlTRUbN5d2BrlcN4o9z9qd8gTriWd954tusRzSKLc+awzYTv9NeqpKxL6cGaFOMZNvt1uK+kUiE8n7YpAJWFNrEAPVDBDfb1nWwTBGj1KtbTR0AqQxvFnBJ107HLal9NCoVEE2cFlxo4hT2BF+hRuIqsFFdDPORnPOaQfakzbGURZhmNLo3seB39ivGi0YAUty/UYB7rBpDwV/klFruuMjvC3duSOGMxPT0C8Re+r+EFM31SyCh7N0NX7TjKiS8Flff7n6jaabk2D08A0hQzPRSy1PWrDo/sEBcPuQjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwHueWpBQx6bcmgKba6W7ewOXPOJGkoSkrflgxHGOcU=;
 b=IQ4JPQiv9DzaCpvhoEAoSu0c/w8YmVSnDmauQ8LiyyhJsnJYnuWfHsHep2Kx1cqzckxOBxnXohajWyPQRSdfsWWWMps5yPy2qKwNCH/QUzmj/UmlJFA3qPE5ixEPfFsjT3BpEXWFtIGOAaUDuLENeVRvqWYuxbeAyfvREsk8uII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MN0PR13MB6640.namprd13.prod.outlook.com (2603:10b6:208:4bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 17:00:30 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.010; Sun, 18 Jan 2026
 17:00:30 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v1 2/2] exportfs: Add support for export option sign_fh
Date: Sun, 18 Jan 2026 12:00:28 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <CBA7FF39-6FD2-4A85-BB72-E3807612B397@hammerspace.com>
In-Reply-To: <176868718481.16766.16291541745508019690@noble.neil.brown.name>
References: <cover.1768586942.git.bcodding@hammerspace.com>
 <2cff941029aa02d5524ea5afeaff5c65af52adf4.1768586942.git.bcodding@hammerspace.com>
 <176868718481.16766.16291541745508019690@noble.neil.brown.name>
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MN0PR13MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 34180473-8e94-4e08-57e5-08de56b315f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2P7Poohrn7d7+Gy05P+OrtQbrr/JNEvaS1KCTcWmfOPzwaxM8J3qpeiiKDnB?=
 =?us-ascii?Q?CmuwshN4gh9tr0jvbGPKfENxyZIprMqUmlpSu1NdTRI2YKse5E3KhvyWzcSp?=
 =?us-ascii?Q?KKpKMNy4X87JArLnCsN1gNYUSg2Hgh6Lh36Z3NSXlEum9uQOancC4u/ZyvAT?=
 =?us-ascii?Q?AbJhv7/ayH4q3v8pI+Cd+sNXqdAEgECUt7q2xIs7PFoaGRCdWKmHZEcojG9j?=
 =?us-ascii?Q?CPTEYr+Yg3R5UhNypM4sK85KCxnG72JQ7lRcwxr/of8aarITXx7LFOv+PiRt?=
 =?us-ascii?Q?BUVWrYryJDGiGZ60NwmpPvkKzb0KVmqQIj1S8+2mdO4F8J/OdutLsUJ2t/Ro?=
 =?us-ascii?Q?j2I30wzE4f68f6FkGRNwylFD//kwrI5yMfOMCL2cSjtpJcjruOS0FNHdF77k?=
 =?us-ascii?Q?bfz11n1YB28gQnps4nIHuYgwe9hPxZB4VKOzWnRMbxKyhMz9mmmOgeDEDtGJ?=
 =?us-ascii?Q?uVR/XwhiH78tCa2ROMwc7HkGYqwAmpUyjjYGZlyMeSEyGlN8ZRsw/4kRMyyi?=
 =?us-ascii?Q?K02QU3aV+O+fyxWIrj07gGcCb//hNGF+caBft15eDgPywN2zAZ14p9IO+i0u?=
 =?us-ascii?Q?mHnhY73UsVo1pkEH1TjDTU1y074UfhQ7O+DwcGB2GfX9D/kxEZEOFHYN9+OK?=
 =?us-ascii?Q?ssZ+SHgdqnFXGQ+e8b7jSJlgnZQ2DuswYXvWxS7zrnMY7latfzj+OH9VZTx8?=
 =?us-ascii?Q?3lhVD9dA7Tbxl2Y5CeAnWMrBwMViSEXngyE/uQIP3FN04Kr5tw9eS/eMNhFq?=
 =?us-ascii?Q?iPrMTY45R0+kh6MNgz3hBSU30QV0Xd6qStZEwJ+/ckJLBmL1BpjFduCanIRI?=
 =?us-ascii?Q?M4NF76WG+AAb2F0N5M+3yLcsWff275r6+P0alGGRYGprd7Q3hb09/F8Vptzr?=
 =?us-ascii?Q?FkGA84AhP7YAn+6FdGnxJwvS3PWZSNs9/rzYEGqBcQKpOqNTvxpaeLtMYtSo?=
 =?us-ascii?Q?K35Ist/4YM3lQd9kmZ3xRAWinRW+6YCY2C0XfXft624VIpPK2vhHlw++Bspu?=
 =?us-ascii?Q?4BnS7QEKi4Dj7WxzSa8ZjPXJ3ep3E1TXKXJz9BG7669dT+gIoDHNyCzrgCLR?=
 =?us-ascii?Q?EYp65JhWaRQfGDUru/Sy1AWjNfpO1tn1m4GJJfnmn/u2NLopjw26u4MPgP/+?=
 =?us-ascii?Q?/Xz52PZhuQisrXe4oV4HbFnFb0JEWWxyTRA1S7ffoAveLvjWb0997eIAEPl0?=
 =?us-ascii?Q?RwienB9yIDU4ajy8LjavJWWlGqvcQc8mYcMTffc9+xTXfQ5Dxm+W/TBX8fFX?=
 =?us-ascii?Q?VPYGqnrWuyx00efBhNfBV4/beWjNUKtE0qkOMT8ImMcJarbqK2BAmaAR7gc8?=
 =?us-ascii?Q?KQOLN0JBzpw95NnPTiHdvL4Q+9rj+DkZGt/z+n+/usp71KBZA6MzSh5s5+IM?=
 =?us-ascii?Q?Q5O91pybFaCFFRDQjvZMDktaneVZ5p9JXOoR0uy0Wscje/CiAD10v09u87ls?=
 =?us-ascii?Q?YBoYUdlfePbl+k/5k25zRUFGVkZUHUy0jYNjpiGZxzPETs45icYJLqdKib2F?=
 =?us-ascii?Q?hffJhxnme3L+5tLb9Ax/xGcm5HJoTzSr3oZgx20Lw4XXtEWu29+HVdYMu7Rl?=
 =?us-ascii?Q?0Il+zAJxllUnFibZYpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXMGm3sp5AdiTCDDIYdKHhe2PBViUKY7Z2Dt6tBPx8KNy4ogq2ZJ0yIHmCzj?=
 =?us-ascii?Q?l4EKpW+FSIyWK3dQ64ddEvuwoT8QbpmCIieFkSOG8vaWVZd/ESEy0V/xsmM5?=
 =?us-ascii?Q?9ZHww2vp9rT5ROXK2JzEvjCmWw8cDNmCg7d7taISjLigynA28KE30bSodSUE?=
 =?us-ascii?Q?n02+xm3V1NzkHDRQtIH0NzxJojaNchbvclcoh5n0gJMd5ClnVkSmgIoDsiTd?=
 =?us-ascii?Q?8BWe6jAhBofYdDnc120mWm2Xc27zlpD4/4DIILyRUqEEvlVuwGxz42QfJJcJ?=
 =?us-ascii?Q?wYFWo2cEXCHkaABtSq1DuCPzdqft8ioQ4uuwsii63Mxlb46KXtQVbkO3VzH5?=
 =?us-ascii?Q?WPHqUFx+j0/A1IfwzQoacoL5QXev7plCtp/iBRSJ2th98eJVZVfd4KwKTAVU?=
 =?us-ascii?Q?+xvgJ/53X6MZ0HxH82ok0Xo9Kc3DURkfcXzGXHqNHOnDkh6SGJTIJoBFXtzs?=
 =?us-ascii?Q?wkBMUt2YX1OF6H2pATJaGXFk4YjxeP3nUXbVMKbuO5c8jsITE/4oW3jEOO0U?=
 =?us-ascii?Q?CcUgRxQ4kD4es0ShhMCq6HTu06QExAzt2Bpw1dr7mfp1OIJt8Art3Da79DGz?=
 =?us-ascii?Q?9LGcVfXisDK6YcaNq0AObnTVBzcGQgQ5xFiYdnIDojHsObCoYFgXPHp/54e0?=
 =?us-ascii?Q?M1fLD6GRrBb23PSn/RehZFppDB2Mr2bhcKuJDxVnvr0TUqdzLoYvI8/nosRi?=
 =?us-ascii?Q?LMf7gTzaZ1vrSr8DX+Fzl4fi5tOIhZ1GtGGNjWM8GyQWRNnvRP/Q0eOG1LEf?=
 =?us-ascii?Q?nBdWMIeKFOUFv0bTrqtJtIcoXRWTylPYPUvxcTsS0loB6Iul340qkUOrrRq2?=
 =?us-ascii?Q?GnbnLOU//H2CKS2DQ+6VFE67PfYzDA2ZEtBS9rCIWuHqkmED+LLESG1WL8zy?=
 =?us-ascii?Q?+/nF8JBLUkFsAY5LH991sQDKSwe52UbtAc3rSLpSHTZsCHHMxTQbv6L7zZaE?=
 =?us-ascii?Q?drBjBcfjZpnmPytDo/U+InLWIiI8AGiG67p2V8raRBVWKtLCJq82DbsoZdV1?=
 =?us-ascii?Q?Yj4GYoZN+UoMmNjBIH18X7IzlLyzA3Ku8mLveBfzrAAa5GpqfX2tik618+E0?=
 =?us-ascii?Q?iDknx7KbyF+rX3ztwM50WPueeaCCX0oO8GApdpbKev3m/ukXl12eO8k6s67h?=
 =?us-ascii?Q?6BvBUiSPBDiepk6l8TXWE7HmMO/SVhzPzTh918jaAISGyQ0gjzGFtFtLaqnT?=
 =?us-ascii?Q?iKQoiDU43fVDdhLVcluoEkleDFI/ZcrH7OEa+1OIjf9gleuvbkOh0ABPsUDc?=
 =?us-ascii?Q?odCKZ9VXgrSWn7Z7EnrDjPiZQkX+N6GuV1V1/2cBfWp1jldXn0+GzQy8QDUM?=
 =?us-ascii?Q?8w0YoFxONbmxjme33VkJf7U0x6DUKeJQ6gy5+ap7DhhNs8wP27GwxmDPfbpV?=
 =?us-ascii?Q?XM5h0KgdrekIPKlo3U/m06VjzE2oZJrQEnvzR565Ftc24Mp2Eyijm33MtLl4?=
 =?us-ascii?Q?LhqJJKvuq3Zmixf5gxisriOHA5MDvNWkFqKqYJmEIW8dTmGuNuRhhf2+/6/j?=
 =?us-ascii?Q?aSEB4tSmEpjroy71jTVF/AjLnIW+ptcHHwC2CeDWFMBn033U0m+YPMOuw+tj?=
 =?us-ascii?Q?lDdPtk7OnIcRB4pZBFRf6nZ/EbWoL+LYxFfBa4hzxYRSEVismtKW6lbAs0uS?=
 =?us-ascii?Q?k7VL52VdT+uqugUs+NzNzCiWbP7FXHHs+9iNHnVaXf/2R7opJ4rnD0f/aPfX?=
 =?us-ascii?Q?Noi2ndHmlUJfNqnUBi79hTGzObJZ83Al3fJsNLxeX+qHgatDEQA88XIEq+eH?=
 =?us-ascii?Q?zqMMGZ+KGO+nz7SDmVEvZ8UWVC8AnOA=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34180473-8e94-4e08-57e5-08de56b315f8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 17:00:30.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/LKN2YL1+MgwoK+yNvEuh9NdyW07iin6g283FPviEvShVJdkZVOgzgmF8JLXTDQ78Fw7zbP6tOTub6ecRWSsEx676j9/j/d/pTnApfN7+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6640

On 17 Jan 2026, at 16:59, NeilBrown wrote:

> On Sat, 17 Jan 2026, Benjamin Coddington wrote:
>> If configured with "sign_fh", exports will be flagged to signal that
>> filehandles should be signed with a Message Authentication Code (MAC).
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>> ---
>>  support/include/nfs/export.h | 2 +-
>>  support/nfs/exports.c        | 4 ++++
>>  utils/exportfs/exportfs.c    | 2 ++
>>  utils/exportfs/exports.man   | 9 +++++++++
>>  4 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
>> index be5867cffc3c..ef3f3e7ea684 100644
>> --- a/support/include/nfs/export.h
>> +++ b/support/include/nfs/export.h
>> @@ -19,7 +19,7 @@
>>  #define NFSEXP_GATHERED_WRITES	0x0020
>>  #define NFSEXP_NOREADDIRPLUS	0x0040
>>  #define NFSEXP_SECURITY_LABEL	0x0080
>> -/* 0x100 unused */
>> +#define NFSEXP_SIGN_FH		0x0100
>>  #define NFSEXP_NOHIDE		0x0200
>>  #define NFSEXP_NOSUBTREECHECK	0x0400
>>  #define NFSEXP_NOAUTHNLM	0x0800
>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>> index 21ec6486ba3d..6b4ca87ee957 100644
>> --- a/support/nfs/exports.c
>> +++ b/support/nfs/exports.c
>> @@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
>>  		fprintf(fp, "nordirplus,");
>>  	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>>  		fprintf(fp, "security_label,");
>> +	if (ep->e_flags & NFSEXP_SIGN_FH)
>> +		fprintf(fp, "sign_fh,");
>>  	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
>>  	if (ep->e_flags & NFSEXP_FSID) {
>>  		fprintf(fp, "fsid=%d,", ep->e_fsid);
>> @@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
>>  			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
>>  		else if (!strcmp(opt, "security_label"))
>>  			setflags(NFSEXP_SECURITY_LABEL, active, ep);
>> +		else if (!strcmp(opt, "sign_fh"))
>> +			setflags(NFSEXP_SIGN_FH, active, ep);
>>  		else if (!strcmp(opt, "nohide"))
>>  			setflags(NFSEXP_NOHIDE, active, ep);
>>  		else if (!strcmp(opt, "hide"))
>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>> index 748c38e3e966..54ce62c5ce9a 100644
>> --- a/utils/exportfs/exportfs.c
>> +++ b/utils/exportfs/exportfs.c
>> @@ -718,6 +718,8 @@ dump(int verbose, int export_format)
>>  				c = dumpopt(c, "nordirplus");
>>  			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>>  				c = dumpopt(c, "security_label");
>> +			if (ep->e_flags & NFSEXP_SIGN_FH)
>> +				c = dumpopt(c, "sign_fh");
>>  			if (ep->e_flags & NFSEXP_NOACL)
>>  				c = dumpopt(c, "no_acl");
>>  			if (ep->e_flags & NFSEXP_PNFS)
>> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
>> index 39dc30fb8290..8549232dea74 100644
>> --- a/utils/exportfs/exports.man
>> +++ b/utils/exportfs/exports.man
>> @@ -351,6 +351,15 @@ file.  If you put neither option,
>>  .B exportfs
>>  will warn you that the change has occurred.
>>
>> +.TP
>> +.IR sign_fh
>> +This option enforces signing filehandles on the export.  If the
>> +server has been configured with a secret key for such purpose, filehandles
>> +will include a hash to verify the filehandle was created by the server in
>> +order to guard against filehandle reverse-engineering attacks.  Note that
>> +for NFSv2 and NFSv3, some exported filesystems may exceed the maximum
>> +filehandle size when the signing hash is added.
>
> I don't think "reverse-engineering" tells the admin anything useful.
>
> "... to guard against filehandle guessing attacks which can bypass
>  path-name based access restrictions"

Your words are much better - thanks.

Ben

