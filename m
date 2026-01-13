Return-Path: <linux-nfs+bounces-17807-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D27D1A82E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3219430084D2
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B434DB4A;
	Tue, 13 Jan 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OemEq8Wj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022084.outbound.protection.outlook.com [52.101.43.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14C3033E7
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323760; cv=fail; b=biNPRbGFYLjZJqRH9wFXwU9TlXqdKegMRp8NynZMKE/NrPSdVNsLvFzJ9LMtRsDtjyw63qRsbTbqeUG5BMyHYTSR+F3hHpg/1EQ1lwl/HbqCt9TgfyAF9CCtk90ZZOQfzu1U9fkh4BmHxQvMsO3pUx4EUSjtcj8WBNUjgvPQFKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323760; c=relaxed/simple;
	bh=Wa/0Do+G0d4SqtYcB4QfzQqFWm1mBFQ6YgNa8L1shkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Un9uWQCcV72OzSDWgZwbGZuCHM7zJAwoUhLOQ4toFjSOERGcUXoALhIIrz6xh8bvxEH37SuPyJ8idS8adi1NLlXs3132AsPsHu8X6SpPX3TWZJFdHEE6yDBG1iaWX+rjygI3Ku+cljxQ7NKpsI/Eq18OhmkHmfoFFqSqmTTWGS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OemEq8Wj; arc=fail smtp.client-ip=52.101.43.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2BtQbHH6AKwxYwsanUpAWYC5p/Hi8r+TRFWsPpaDuvlP55s5FjxQPpRE73+gcHGooyZYPVlpCduEbW1UiCgfBbq69zYAPg3Wex1ddhOp6dbBLza2MQ+69qNgpF/gSJ1oImL4U9HVlgUyiskyOhAVJsLqQZvXc2UWYa97In+6wSWCIGdX313mHNNIoBtRQ2kQc2PYQ9R3UJasXpfSirpjhtqEB1RU1bUjikxyqp6SZ8VFTp6USXyxaiFVxyXGH/Bof8gM/RNunLL20dq+dilidom3cQvDX4nCsx2ouze+ymGOPW/PYMkAruRVekzhsk3fUdEyFa/n0aa3J3qoMZacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnoqodqX7tbRrWlhngHjXwbXijQoL9KSJTPS5qTwX7Q=;
 b=gPlrgfFDQo4+C3c8K5GBOTYFszNANp/wQd5WSHe2Jd/suAaXlRoBaK2xegJ34N7Sx6GNM0hTN+7K9PrnCt+VATPoDgl8XAgVONPvCVYNqltblT/95B1io+xdi5Fill3uwMwJKBQdIJAowDj7BL79VDEcuFC4VwR01OVbaeQMxvO3uIgG0Mep4GqZbZWwpjsBM+ONUsdEqLwp51wjlLTahPtgbFkJUrT2IhcycTyWetWT+k5xNoV54kKDaPV5E5T1Xm5lMSkDav9IHclb4P+RswnS4g/A6qm/2mDD0HGXEQ7FVBYYsOa1rx16fmoM6NdpxiE7XYZuw1og0KinltpQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnoqodqX7tbRrWlhngHjXwbXijQoL9KSJTPS5qTwX7Q=;
 b=OemEq8WjBdgtfTq8xmDk68UBv2It9+3oDSz3LHvU5vkgqymhqtxk9AWNs3XbytEKxI3YWW/RYdXM160W9YDcRxUcYwKObUl9wJZ+uy9yzsi+fdBwqa41SRsoBf4Iwqf4rGqZeltn20nuUJsjC+SqKp4hMNrJoU9aPy01lTJBgUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY1PR13MB6191.namprd13.prod.outlook.com (2603:10b6:a03:52b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 17:02:35 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 17:02:34 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Tue, 13 Jan 2026 12:02:27 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
In-Reply-To: <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0036.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::16) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY1PR13MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 2363f163-5d47-4734-28b6-08de52c58b6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwlne+oJqHvZvydCB88mjXmgvzb2Lafbzeh/lpJ8RKc8LsKA9VFK6IA/k7FJ?=
 =?us-ascii?Q?SrND48pvpZ1lR0TE3gAAPXvGY6JpSsBW2lb+30HiRs6P39NBFWXvX9Sv/jqR?=
 =?us-ascii?Q?kBbQjm0A/wDxtMQEIlpEAiH9nzCAIrabEV0/WEwtjmzvnZKx6ENsfNM0dMKz?=
 =?us-ascii?Q?cjp1jYH8f+J4GZIkUYMFpgQw9Zm6YDzc9I8Q7Db0/+aVUdJ+M6s/WyaFUgda?=
 =?us-ascii?Q?ThmP5zhNIO90CZT0KExql/TNzuRGcn8BxUId7kaNi70gDrdGojDuBqmy7S8I?=
 =?us-ascii?Q?VgKcQeEawi0OFTWMJra0zzQ3VmAmgqp+yiRALmzrf6+5cdi0MhKCIkgEtoYy?=
 =?us-ascii?Q?NOzXu0wgTtBRSmzh1eAGX7D6qEl1+tKnaXOtf8mfkNAHxjbVmI6qJNsKFL5L?=
 =?us-ascii?Q?7GbvgjG04TUax0qxGME9+TY7vA8bw3BRLv4/nNaw2bLsmQtA0fV3i4VTRmZH?=
 =?us-ascii?Q?SCi2mUHHfG1/AYNRkCQJ4WTcx0vD3vRg87nXW1yQ2YflIFsgCtBpNp/EbDoJ?=
 =?us-ascii?Q?AC2auoGTzYTH5+nYen1EATTprbzCqacpTjKn+8h8BhytZKWP0nSTPVsMx11c?=
 =?us-ascii?Q?esNmPgVO0z3VGfqWsDK0FrzQ4M/VtCxUwpeL0x04VhaIhiqYy5j0VFub2BAH?=
 =?us-ascii?Q?kHmWh/9XATzg937e+x93QioqPKLehzM7U19bdHT3vC21BkBIvNb1DgfjmbIy?=
 =?us-ascii?Q?O4An31Iecyi/tZ8J6RYi+9CHbLf6FCWEgPII6CsP4Vrp/Dgp8zKzYoZ2GJ1I?=
 =?us-ascii?Q?nJnlFDg/KjhAOl3SlBCCWF15q1C79i0uDoaNzXzhbC1fAX6yZC5R2C9ZHwBb?=
 =?us-ascii?Q?G0IC83tW48EWrHfGX92IeOm0riDTggcJzsNl5mrh+ctDagr6Ao4Ii3qUx1Cb?=
 =?us-ascii?Q?iZMRW6qL81jQZ8dq4GgxhtctOe89xIMxcu1+o/eUKpu3goOwiaEKn3L9nrrt?=
 =?us-ascii?Q?Tsa7144ku1Gg40jIqcoNenItaL6ZmWX1+YQJs467CoWefHFwstCJZO/AKqSc?=
 =?us-ascii?Q?xyTahU5cHIjTvmOoOm05pgnMhVTbpYidS7nwOVT/bv7p7/DWaEnhA5zg7HzQ?=
 =?us-ascii?Q?3zWhCNE4QyVuuR8W3yKb6bB+tLeg2nuS2PAQS1DG40/A9Ix01fUHjFbiSiI1?=
 =?us-ascii?Q?sKBeGxALvKuSPNmE7MCWraTgtQQ+Zv0e22pmdXKcui7iaHcNQn3xTY2v2iSr?=
 =?us-ascii?Q?vNuMJtGaiLbgsO8GA/6mhd9BJtc+u6DECir13v2M29o4UvuW1admlmtePLvu?=
 =?us-ascii?Q?CzEezpt0+Ia5lwsCuzY4kJvt8b6v5R8bK3/haWG1UNmcZCGl4aME7QCaTBo0?=
 =?us-ascii?Q?NrJX9buX1qZ2rO/3WLIrGumnnT3E1BLGuqmVUxLeQjx0tkRwxbpGFMLWt+y0?=
 =?us-ascii?Q?K3qhIJ8Ib6Cm4BthorykrOz3lUObODs4CTcHqsY6mF4KyKgF8aBQIaICeZe8?=
 =?us-ascii?Q?+A597t5xn3ep6B5EI3cHj96R96X3hq4n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zq6hGpLdJ9jZydR23O4FGI+FIpG3JqRGS/UOyphihTpAU1PE2f7zfHwJSyBJ?=
 =?us-ascii?Q?XPNk7qIcCeHjA/w2Xo9qvB7NkRVgRrIgJIIGjE9Z9o+2u0bg8rGEfcClsDxo?=
 =?us-ascii?Q?cd8WvPhpfTGA5cdeds4bgv9hXC4m1EsZEeaiFiU9iDIHq2t5TfAdKuaiFymZ?=
 =?us-ascii?Q?0YJoQfYj8lFCR8Jz16hG7a6zQzouNeGrnkFQxWMCPAOlQk84R/aeueHf2thU?=
 =?us-ascii?Q?l3raPcznHQHq/gVnmMgKPHyNg4OwUBD5tcqmUUGXguLzU5itSzOjlvzysIw1?=
 =?us-ascii?Q?A6lahVHQ2wcBWk9w39xlN+TXj8K5+HtdIdYxc+KMkVps19JKmQ3drIAbOcmc?=
 =?us-ascii?Q?sP+dbXSbIkEYf+xnA5K8GMBA9n6IEMHnUpq1DYl8+sQcvv7ngjH/dTyxZ138?=
 =?us-ascii?Q?1ZwxAmlWviFrXeCTyoNmrsHRbgsyo1tkeViblHJLll8hvf6CIhlnpTtGI7EG?=
 =?us-ascii?Q?HKSUNREryUztiddo1eZbcC6KMEGPl/sH+sUN7idgDrJjlKNSCc342x+kPDky?=
 =?us-ascii?Q?Z18k8l5v8a0QofcGQwI7p3S+lgSK9y4rpJ28lmu5K1HP3cfuUPH8XDv58rL5?=
 =?us-ascii?Q?PP9+o4Sut/9A/+DphPxDZL7GKLoOTkkrTS+m7GR7sLB9cOlKy8OvlBFJPzCI?=
 =?us-ascii?Q?CWp+XCHyV7D/9MzdA5Es1eDD092bA69j8j9pwMYkO0Lyl83zqjHqaJO3Fl4/?=
 =?us-ascii?Q?4NOD2uPFEFlwbOkXYboLoWyqJlvyJYBKw0cz81dSch6pgJEhmgN10NhGSXgB?=
 =?us-ascii?Q?BYfYWss6agAkVlJQjZXWkkZfvde2uKYDU182qAw3/dsMtoEXVjOfMdTI7w0X?=
 =?us-ascii?Q?ZCUP/k3Cei7GG7XXwrcwdK/KWc/kpYWmxuZaVWSrw4LS+WoftKJZcpUVQwp8?=
 =?us-ascii?Q?9/1UBuvtdYHXz0JItcjunTELUP6UFzjX3G4TK9N6LJAlpNvsM7dZ/7NZOAO2?=
 =?us-ascii?Q?LUpkEXt3dGfWH7efl0q3oBop5GaHbhhYDypv4UnMGNaJ/biPgCQ5X51lHDLw?=
 =?us-ascii?Q?hgUOHdqLSGAY2MXMxFEggLUM+ljSpojW2VORBwEC6zVH4ul3aYUNm0Uxuj8w?=
 =?us-ascii?Q?7PdpaqthiMxtV6QtqYZyoM3qQbqCyv1dQ6CHvEqm602a30yqaAbPoKv8VAsw?=
 =?us-ascii?Q?+h6e/W0P42xvtjPTl+oOpJ8hqd/lB6Jva5hiqhmdDcJTxdJDzyANL+naKGGk?=
 =?us-ascii?Q?Bju9brPOJnkGsr3DheYlwKu0fsJg0674s2Xl1mvjE0uRumQKXGapxLw58yPX?=
 =?us-ascii?Q?03dFAst5xloA4ee0k1sl0OFu+P4/mJm3YUD/aMBYCp08w64tEZ1d048sY3rw?=
 =?us-ascii?Q?n1Z5YjDuQ6icMmno+zSq305nfgdtj2+9FPnYV97vXFSgXoeQ6WfgrZcZpsjb?=
 =?us-ascii?Q?ZCiSvSHx7ryiDDxrulvS1jV//5i+LdrgkM2Jq0LRFxtFaq3w9mRiklKtLhFV?=
 =?us-ascii?Q?VqgIH722hcM3IVIfF2pS3lweqG/mPs0sXUhZQ+A/Yr0n/kQ+2h2Bs1okFjdm?=
 =?us-ascii?Q?in9P2xXYD9lxahVPPIF/5kisSIwvjvae5mUqmqiUcpJovD7a3RDnjTCVRMSm?=
 =?us-ascii?Q?vlEj9CMHUyw4c96QCkMysz/FJl7pjnTTWKRZrP7+gg99uFUPF3uKsYz+3gJ6?=
 =?us-ascii?Q?r03CC32jKGmBhjTFOoIIQJYcrrc026Qz3xx5XHuF0KEUnUYXG/IMPsxrayTi?=
 =?us-ascii?Q?/6p83OEz3PsX4wMc4iE1d3kppuGspNQPqZHiik26awrJyR01yLOJ//iao5xs?=
 =?us-ascii?Q?5r/BhzK6R9y7upqjNIcDtA+6ptzBlPc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2363f163-5d47-4734-28b6-08de52c58b6d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 17:02:34.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwSn5EW+puS9CyNbE0Is37RvBgietUvNuKKJ9paviDEyVCGFFt/AdN6Kfr+jwWK+FuxFcuxYdLdPuuYg64WgNGK05pHxMum5Mb7og2DCuSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6191

On 13 Jan 2026, at 11:43, Chuck Lever wrote:

> On 1/13/26 11:05 AM, Benjamin Coddington wrote:
>> On 13 Jan 2026, at 10:18, Chuck Lever wrote:
>>
>>> On 1/13/26 10:07 AM, Benjamin Coddington wrote:
>>>> On 13 Jan 2026, at 9:08, Chuck Lever wrote:
>>>>
>>>>> On 1/13/26 6:51 AM, Benjamin Coddington wrote:
>>>>>> Hi Chuck - I'm back working on this, hoping you'll advise:
>>>>>>
>>>>>> On 29 Dec 2025, at 8:23, Benjamin Coddington wrote:
>>>>>>
>>>>>>> On 28 Dec 2025, at 12:09, Chuck Lever wrote:
>>>>>>>
>>>>>>>> Hi Ben -
>>>>>>>>
>>>>>>>> Thanks for getting this started.
>>>>>>>
>>>>>>> Hi Chuck,
>>>>>>>
>>>>>>> Thanks for all the advice here - I'll do my best to fix things up in the
>>>>>>> next version, and I'll respond to a few things inline here:
>>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
>>>>>>>> is really an RPC layer object. I know we still have some NFSD-specific
>>>>>>>> fields in there, but those are really technical debt.
>>>>>>>
>>>>>>> Doh, ok - good to know.  How would you recommend I approach creating
>>>>>>> per-thread objects?
>>>>>>
>>>>>> Though the svc_rqst is an RPC object, it's really the only place for
>>>>>> marshaling per-thread objects.  I coould use a static xarray for the buffers,
>>>>>> but freeing them still needs some connection to the RPC layer.  Would you
>>>>>> object to adding a function pointer to svc_rqst that can be called from
>>>>>> svc_exit_thread?
>>>>> Forgive me, but at this point I don't recall what you're tracking per
>>>>> thread and whether it makes sense to do per-thread tracking. Can you
>>>>> summarize? What problem are you trying to solve?
>>>>
>>>> I need small, dynamically allocated buffers for hashing the filehandles, and
>>>> it makes the most sense to have them per-thread as that's the scope of
>>>> contention.  I want to allocate them once when(if) they are needed, and free
>>>> them when the thread exits.
>>> I'm asking what are these buffers for. Because this could be a premature
>>> optimization, or even entirely unneeded, but I can't really tell at this
>>> level of detail.
>>>
>>> So is this because you need a dynamically allocated buffer for calling
>>> the sync crypto API?
>>
>> Yes.
>>
>>> If so, Eric has already explained that there is a better API to use for
>>> that, that perhaps would not require the use of a dynamically-allocated
>>> buffer.
>>
>> If he did, please show me where - I only received one message from him which
>> lamented my lack of my problem explanation.  I responded with much more
>> detail, and nothing further came from that.  V2 will do better.  I missed
>> any assertion that we wouldn't need dynamically-allocated buffers.
>>
>> True - we could use siphash or HMAC-SHA256 as he suggested, but both would
>> still expose detailed filesystem information to the clients which was
>> counter to my design goal of hiding as much of this information as possible.
>
> We need to understand your threat model before deciding whether
> completely obscuring the file handles is more secure than making a
> cryptographic hash part of the on-the-wire handle.
>
> As far as I can tell, your proposal attempts to hide information that is
> already available via other means.

Not necessarily true.  Filesystems create their own filehandles and so you
cannot say that the filehandle will only ever contain information that is
also available via other NFS attributes.

> What you really want to do is prevent a remote client (maliciously or
> accidentally) from fabricating a file handle that can be used to access
> areas of the exported file system that have explicitly not been shared. A
> hash that cannot be fabricated without the server's secret key would
> accomplish that, ISTM.

Yes - a MAC will do, as I have already said several times.

>> Using a MAC may have the advantage of sometimes resulting in smaller
>> filehandles (siphash would add 8 bytes to _every_ filehandle).  But it also
>> may not result in smaller filehandles when the unhashed size lands on or
>> just under the 16 byte blocks that AES wants.
>>
>> What would you like to see used here?  I do not think that allocating 32
>> bytes for each knfsd thread for this optional feature to be a problem.
>
> I would like to not add yet another layering violation between SunRPC
> and NFSD, especially because there has been no evidence that AES or
> anything like it is going to provide any meaningful benefit.

I think we can do it without adding yet another layering violation, Jeff's
suggestion was on-point.

Also, it sounds like you don't agree that hiding filehandle internals from
clients is a more complete solution.  I disagree with you but don't need to
argue the point, the details are clear.

> Let's stick with the simplest hash/encryption approaches until we
> can see that hardware optimization is necessary. That already leaves
> out the need to dynamically allocate buffers.

I will also assert that AES is pretty simple.  Complexity isn't an issue here.
Buffer allocation is also not complex.

But you're the maintainer so, ok.  If you don't see value in the current
proposal I'll need to rename this feature, because it will not be encryption
at all - so how about some bikeshedding?  :)  Hashed filehandles?
Authenticated filehandles?  MACFH?

Ben


