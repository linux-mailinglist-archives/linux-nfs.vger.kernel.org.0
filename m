Return-Path: <linux-nfs+bounces-17843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F959D1ED65
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 13:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3E830173B5
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBBA36A027;
	Wed, 14 Jan 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PbewZ9Jt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022117.outbound.protection.outlook.com [52.101.53.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404535965
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394403; cv=fail; b=l3KWlbC1z+9PxMdRmT0GD6VqeDz/XHupP733Ne0KVfAKEkQQx+RIMDv8O96iLlLlLg7N1JR6HSTs02xDKdNiHEVaS2+ISbFziy1MN4cUgK4a9OeVfx1Bj7XtD0dtp6UECcfnXUfWWJeRkQpGdjbwZElxzlhwt3nW0x2tt+s5pXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394403; c=relaxed/simple;
	bh=uKN6zigKt8qhu/dw6hGxgM1yyZGIiXBlSPD1ZxTiBFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aTcLa+nxnz/CIbQ8tvQTE9JKnB8dVceh0WaIQC//ZlHmii2xoYkPRoZcsjy7o11LhitLidPBXvOOA3LYjRjSbDM2VutmwYf36O6xdJhVS2Yq2ZgJ61RfVlqmyNm1C78HRPXcmduM97jCd0xjWPXRUVOAU54ck1Dpac9gQhlBh8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PbewZ9Jt; arc=fail smtp.client-ip=52.101.53.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6zwVSNbYtDcByOUDdbJrBKTa9fvxEceuvEz1xqIxasSGr+S8rmnh/b0dBDE9WlxnNbUt+7PF1wD+xH1wbsU4uvqr5+nb782gPyNx0MpxDFColAbpXUtBNLd1ILe0d9y3tgB1cZG2NYhOHZOdl9TGmbGeEATBpCIfCXeG4el+8mQfy2DFyi03spPi/PJS0TpYoJ3zq8ihyJD4MU3lgEEK0+36cTKxT0oRHeXkCzWOiDKFPS8DRrYhkOW2mfGq0ASRWpuc2CtBaXVp2v7ck3Xu5MzYxIaGlBWiJzUCr74maMDCf3auLcxXgxFxwgg5ZDL/mHN1LrdIfEz2qZlZMx33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrSj2JSGDopHnhw09kbjGkGVEICtMffQVVDdz6v6YF4=;
 b=ofClFPVljqmwQs0xlkGygI7o/wW3VguzXlPKFMjEJC2zp1CYpSD3p2NG867UYH95dFQdwDdSJFYU0173J6aNPKqu4m8UVsSPOSKx11zeYMekuMgPUlbYJoiixzcSh8GoIb4SnWhsObe4H4yx8Wkz4bPWuRDlH2dwO2YyJQNaHJ+IX8Ukd4f3AWWzf2oPGtl176XK59yOXf31FUu9nhAn2IrE6xWktddg9HdBELxda0qJtHzT6Gv5YChxvyfJJ1m0L9CIyupCERs+81JWMikyRuA9dxS/kpK2hZqZkflvF8CAVcagcsXRGHJVpifLBbcTG4BMD21V2pOK7kFSqjN0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrSj2JSGDopHnhw09kbjGkGVEICtMffQVVDdz6v6YF4=;
 b=PbewZ9JtwbG9DUse9ub/h+Hg9/HcK9cmSExF5k8oLf2lwvzoPXeiGUP1iFLp7UFBhd7fbsyKZe+VX3iGf2ylLMKaEE2a8QQWE1rFpqPIuwtBb24RkbbkuK4v0ZUOl00+7r9v+tze/ckUElPGBlduZKFK39r7Ce3C+1VqR0L9STQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CO6PR13MB6045.namprd13.prod.outlook.com (2603:10b6:303:149::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 12:39:58 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 12:39:58 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Wed, 14 Jan 2026 07:39:54 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <834DBCBA-1CD8-4BA9-81E8-09E621B3F176@hammerspace.com>
In-Reply-To: <20260114004205.GC2178@quark>
References: <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
 <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
 <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
 <e711e1cb-eb8a-4723-a9af-39ce7d9658dd@app.fastmail.com>
 <C79886E5-3064-4202-9813-0D79091F78DF@hammerspace.com>
 <20260114004205.GC2178@quark>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::16) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CO6PR13MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3cd418-8160-4a09-eb2f-08de536a06f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vg5OUMvNibD0zNTubr1jDAVEmFWqvU7MNr9pPjhd3FWX29u9PqtON4d8E6nD?=
 =?us-ascii?Q?IhK2Yt/KCjg0e4ChJB/Y2y2q2tPpDcQS+ft6PqcdfM/Ctp5ygimsvpL+3Nvs?=
 =?us-ascii?Q?kILXfXSEJG4tsvaVlkn3d3vxR0P7edARKrcDVuQk3eYZl9sTGsbis+Hl9MJn?=
 =?us-ascii?Q?Tv/5kpiecTwYI8p+1238Q5SNilMSez4Ry1MxRPq7Hhvik1detXath4tvvs6D?=
 =?us-ascii?Q?XOzqkZnV8eNbznXEJOvXym3EOIru7fv/RnHpsvuq5a5Ii0YZ0Xzy27778wKB?=
 =?us-ascii?Q?3Lc9RQrsLhGhOeGHO2aF/07m7jOPvQvADtuLpOKn3366nIYePR+SMspDY33P?=
 =?us-ascii?Q?0e2oSf/hsVfByRVuDjc6d/GAZXaJSXsqMETz7/PtlFCS8DgA2/2WCCCmnNQT?=
 =?us-ascii?Q?UzSw2LSR2zDjUNxDMvZDVhQx/zzGTbjkAALYtgann1xM+L+cdj63IvvDkYbd?=
 =?us-ascii?Q?znRwKAIuYf61unuhd+NZKIj3WnvYv9YlSW6m8u0QyJZtE8AQTAG9tjl1ZqVH?=
 =?us-ascii?Q?IBEJlDueF0BII4Jl3zbIAKEnzhK/PFXAS4GSXYnkGTt4/ej8W6LmFFrD8Yp6?=
 =?us-ascii?Q?M7ibxOENvSHMVJu4B42Tqb6I31SHcxJRm7l1//+1vniC7xFaog0NiEa9q1eM?=
 =?us-ascii?Q?+Y97pA3HCJlHqMqhtITnQwXDUWpJFBXL9rkMVqFAd0RiOybjePV07VxxYPOM?=
 =?us-ascii?Q?xboix3ibYK0bp9gY9AVbSC2+q+LvXG212xT2oGzolMBXX0Ij8k8MzKKwYhtu?=
 =?us-ascii?Q?lkYVJ65Sqwewwb1OQ8I7CZNt4aFYTZQbg2qfchyIXuHpnbQFO0MlTk7pp9OH?=
 =?us-ascii?Q?rZ17JnD5f1A0xcLxBBrMZGDIzal89QRIz56QFJCrAMRneSWdJSemEcnHolr2?=
 =?us-ascii?Q?0sbE26M7PqakBUaalCC/6mhti5+b6lnKQIP1ARZgmrrTunSPzDaETnPO96MB?=
 =?us-ascii?Q?7qtanzRdSxc21U+DcDY7dgUny1wak344mqVF5350Hy/Nj6vVicuoDDH101uP?=
 =?us-ascii?Q?ZZr3oAW2cTMlFsG45cYUotvzizjaSmAZqX/rd5VdsrhRS1G23hJy5Kpxelaj?=
 =?us-ascii?Q?xUTpvhCN7n0dR73DjVjPj4lCLhK48EN1VTMc28ZNZmUZPrhaTS3iJ4o+sNN/?=
 =?us-ascii?Q?BRUK+Stb/aDrCIjUq1XlLKiSqOQZF6YywH//2wt1zMeL2wmuIpAkPLAPJYKK?=
 =?us-ascii?Q?8q8V9jFQFFkmcoC+Tn5gWF0fgD67NMk610367Xj52ZumDJzxG1hDKDktDK+e?=
 =?us-ascii?Q?wX9gn3N9nFlafFC/SYwgDPKeJbDxtWJ+ynyac0wpsSB22u6mgbgoP8kBIQg9?=
 =?us-ascii?Q?Qb8554e+WArSVmWCAMFMfcfr63ExEb9uzfpm1bP9aLQIaMO5uZlxqqRYypro?=
 =?us-ascii?Q?K+rSbXGB3m2vrtNNjyfr5ThZYVbfStIpQe12q97P6/vHrjwpDZiaBD915G43?=
 =?us-ascii?Q?iHgFmBOgjDgvy5zM53lb0aE+JRKYKKYbfa9PQI3zkZ4LbypgLI7PFnAbh6hi?=
 =?us-ascii?Q?aVBnKUpK0i14y012Z/7Zzo+ysH6isZWGOp6cuPlf8g1nEFr/MtDxAK24NE9P?=
 =?us-ascii?Q?YK5ie5+YNeZtLG5tH08=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNX1zXhmVGXS2zhrlRoVI2NEZmoPSlHbQfRgLh/JAA/wcOG1iUxx24MR1Kew?=
 =?us-ascii?Q?crZN29ceAZwtcJGb0HYtRoewC94E01n6XApHA8iAaWoIc7lhwXt5NSKlh7mY?=
 =?us-ascii?Q?zhU1s6f4rSwC5plmlsXD1k/BKRVZBi+HFlvV8dgXYQ95Mzu5/uNjtm7BiYZG?=
 =?us-ascii?Q?0xv5ffzEDIEpjGUA+FS5UeGlMRoPu9fWuKwut31TeN69+hJu1MDcfZw3eaJv?=
 =?us-ascii?Q?hzGGBdrlYkbBvzPl6LDffecDH8jSahoW99E4q4U83duF35vnOcqJxHbl+eWx?=
 =?us-ascii?Q?srFZy3lFRK1bUFnbjm9H0zjjSs1Dh4C6DdqKKTAElktE6o2lzSJcEluGoly/?=
 =?us-ascii?Q?PHyb+MfaXuA2MYjzTPW5pba3sPCw/q+YYFBYfU2cy8OCWnC7ErbI7NCrCofH?=
 =?us-ascii?Q?SpyrWn+bjcOtC0tRrc+8S/oXoTpxUS+3I4AevoSlq1lp3Qwwhwrk6nED8t4J?=
 =?us-ascii?Q?HRHrpt8jo5Mkh3eD6p1nGWPye/TdJbW0xTXMyVmx9pTTQ1y0X8iL5Cxi/7Mv?=
 =?us-ascii?Q?u0PKfHhwrdX545j1CQbRUPqG2/kMfn8G8Ik17tb5ocs6y8U512zvgiOL93+y?=
 =?us-ascii?Q?Hh2jWZfsVmqkjfPU65QxYcsyosRkbtMaG1feoq6K/nubTSvwzDHG/KlA/rRG?=
 =?us-ascii?Q?ltZU3K0rMdoX0zek0afS19RGsT2vA6j2JBzs5b+OEtyke/ankdF7CDsFZVqc?=
 =?us-ascii?Q?xVnID+lV2UKBVhKcg8DrESGbU9DEOPW1bMi6KBXs/z6RZ8UA4aHqso32ckzX?=
 =?us-ascii?Q?RSynaaM7+Ck/ulHVE3duE+sM29dgUWkOuB2awrhGq2bP1O88PBpKra1byAzO?=
 =?us-ascii?Q?QhZ4TCCqBbCnaEuA5TWJeQ4OBW89u5e79vGKin6A4ouLN4+Ll3xm6stardwN?=
 =?us-ascii?Q?3QGLvBpCmtiskgir/s/FKR7YSYPM135fB8AOajSYxwtmqpcFZRvipefL5G6B?=
 =?us-ascii?Q?I3jNyaTtECcb7TjDNsyVsKuuUmlHxJNO5qwx0Kb91AEY9DfBv8lyXYI5JWw4?=
 =?us-ascii?Q?aEmFrr5Cgwq7QYauRw54FNndPolYeR2mvFapIU2PbVlL+E/30jiodCOa4y1j?=
 =?us-ascii?Q?J9TI7/CcH2UDCyL15aVas9v1iM42nM/002oMmF24XjG5Nj2juJllZeSp+Sk7?=
 =?us-ascii?Q?hRNBgh+dhbeoiSEPfwE8PxRIfiNgDCJjobcVgANL6lblINWXVwxuhZ707X73?=
 =?us-ascii?Q?ggLfRAGzOp4F5iyIY7Oa/rXR5BUgviTYjkaZmY+fpxJDDzyxkcbdMwY0/sZ1?=
 =?us-ascii?Q?zK91e8dR1USZ1KGtg9obNFiV9P3OtqPnRy93Q6NHuBHcGJqBuz5rCAu6aLE2?=
 =?us-ascii?Q?xYerigWpr26XC6FimEAeA10v76wbk2qsOeuRw6Pxsp8cGgRtdqQ2mHezACjJ?=
 =?us-ascii?Q?f6i2EEOVJ//jMDJ/slQivCGW37jO1J8OBisAJNxFdRdqLx43809zV1Xsdeqn?=
 =?us-ascii?Q?CgifKK0972ZotTjDRr28kmZsqk0XE3e5pT2XTWhHQgdVcCtPrJ7hvtw/MSB+?=
 =?us-ascii?Q?hlHD/JYuOI8PV6Cthc6JAKH+loM18eHeEsBbrhPbJ7FukIDz/uIFsXF5NlJ/?=
 =?us-ascii?Q?H8CfcFmKs9/ARCSffrWIZGiNIuHuM5kOotnRqV2T56ja/ppXEijI0ExzTvif?=
 =?us-ascii?Q?Cx2KGdNQVoURgQRgPjgecwoDwQaWeFqdrdQx3thAOUyMqFwgnH/70TpLGB75?=
 =?us-ascii?Q?aF9/hByCTLTjnw1EXRjhZALedluRoatVxvOs4sg8lrmSP8MAcx4AZm/54vua?=
 =?us-ascii?Q?6RORUl9HnAnfd4rqoFG6ggGSoCYJsuo=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3cd418-8160-4a09-eb2f-08de536a06f2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 12:39:58.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrYr+8HCDAjT4Kcy52O1CIwK7mbG/V43MGxZ0Cfo5oCpL5vpYRfsSRSkitQ3tijRG40kZgPMytQ9kyiP12ldw1c7j+28a/s2jvZD33MnC4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6045

On 13 Jan 2026, at 19:42, Eric Biggers wrote:

> On Tue, Jan 13, 2026 at 05:33:37PM -0500, Benjamin Coddington wrote:
>>> - Individual filehandles are small, on the order of 32- or 64-bytes
>>>
>>> - But there are a lot of filehandles, perhaps billions, that would
>>>   be encrypted or signed by the same key
>>>
>>> - The filehandle plaintext is predictable
>>
>> Mostly, yes.  I think a strength of the AES-CBC implementation is that each
>> 16-byte block is hashed with the results of the previous block.  So, by
>> starting with the fileid (unique per-file) and then proceeding to the less
>> unique block (fsid + fileid again), the total entropy for each encrypted
>> filehandle is increased.
>
> This sort of comment shows that the choice of AES-CBC still isn't well
> motivated.  AES-CBC is an unauthenticated encryption algorithm that
> protects a message's confidentiality.  It isn't a hash function, it
> isn't a MAC, and it doesn't protect a message's authenticity.  AES-CBC
> will successfully decrypt any ciphertext, even one tampered with by an
> attacker, into some plaintext.  You may be confusing AES-CBC with
> AES-CBC-MAC.

I'm not confusing them, and you're absolutely correct - if an encrypted
filehandle were tampered with we'd be relying on the decoded filehandle
being garbage - the routines to decode the fsid and fileid would return
errors, because a filehandle's data is meaningful and well-structured.

That's a big difference from what using a MAC would provide - immediate
knowledge the filehandle had been modified.

>>> There are plenty of other kmalloc / alloc_page call sites in the
>>> request path, and the server is designed around permitting synchronous
>>> waits for memory allocated with GFP_KERNEL. If you don't want to wait
>>> for memory reclaim, use GFP_NOFS or even GFP_ATOMIC but for such small
>>> allocations, it's highly unlikely that an allocation request will fail.
>>
>> I'm ok doing the allocation dance for every filehandle, but I think its an
>> easy optimization to keep the buffers around if you know you're going to be
>> using them - same way we do for RPC buffers.
>
> In the kernel, several MACs (such as HMAC-SHA256, HMAC-SHA512, BLAKE2s,
> and SipHash-2-4) have clean APIs that don't require dynamic memory
> allocation, scatterlists, or CONFIG_CRYPTO.  If you do need a MAC, you
> probably should use one of those algorithms and APIs.
>
> I see that FIPS 140-3 got mentioned.  In the case where the kernel is
> certified as a FIPS 140-3 module, I don't know whether this feature
> would actually be considered a security function for FIPS purposes or
> not.  That would determine whether it would actually be required to use
> a FIPS-approved algorithm.  If you're choosing a MAC and want to use a
> FIPS-approved one to be safe, you could choose HMAC-SHA256.
>
> However, as I said before, the first thing to do is actually to evaluate
> what security guarantees you need.  To me it seems like you want to
> ensure that for a given client, only file handles that it was sent by
> the server will be accepted by the server (provided that it can't snoop
> on handles sent to other clients).  An unauthenticated encryption mode
> like AES-CBC doesn't solve that problem.  I think a MAC is sufficient to
> solve that problem.  An AEAD would too and would add confidentiality
> protection, but that seems overkill / unnecessary here.

Thanks Eric, much appreciate your advice here.

Ben

