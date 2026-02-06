Return-Path: <linux-nfs+bounces-18787-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHt8JbYThmk1JgQAu9opvQ
	(envelope-from <linux-nfs+bounces-18787-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 17:15:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94A1001D8
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Feb 2026 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F24B3098A15
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Feb 2026 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF102C0268;
	Fri,  6 Feb 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="R2gQtdrQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020099.outbound.protection.outlook.com [40.93.198.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C52737EB
	for <linux-nfs@vger.kernel.org>; Fri,  6 Feb 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394206; cv=fail; b=ouy3Jyq5U/jUDCHQu7ck4F5xzQ6Kl3kj38eG42uo0MX/LELtD5Mu4hmtypsUQD4tojFzKwNsD+cugyMCJgW181PfgZRvX2QUSbQJYrg4fR1PHAF6wdUUByuUHh62CKmiYHXIQVFciFAwb4eojMCAfnZnj4jLPy9vyibexTZa8yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394206; c=relaxed/simple;
	bh=oZNh6BGcFUn2ZQzEbtINEbZMwa8OKAGoFpu/tOAFCDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRLIHiv2YCVozA2+enHCmoAmvb9aEvAx6QM7exDifNzqFowPQfTTL0gio+2WB69OXogj5H8sFjSyqoa0xNzPXv6eku170G+AIi6LQJFqz/e/c27PBNy/ekAL6/AUz9lGSfxr1P1JaiVyyCMNYvsk9rNezC3KjwSMRnMgsaQWp2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=R2gQtdrQ; arc=fail smtp.client-ip=40.93.198.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Len2XrzjmzizyLoJ0klVDjpjToxD5P1gC6EMMNpfNU99unhcZ5Ky9v4oga5Qd5IvVFKXA/ijbPoijGx7bFiqXYEGQ92js29E25vFMb1nxq2CK14hcq8aiTOfycebn+S6fl+Jrjd9obSGnrvqz1SpgO8tFf7Gsk2ggIT8a3hcqWDNHF8U/TAEfacDG+32Z7PSU8AlFwOKXR0oa6EIHCwTZvF0WqILqRNW581eoq5cVnfnCNjTBOvcytQX5/YjJXsFejHv5SpXQbpUW3OBGodXRL79x1sMlEbI2TsGPg/6zEZTZjqTYt5BWPxiOhNzCYJ+6+80cjSLcNbSOdw1HEYzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWPL+YeBLMVmrCYkAYt3GvnZESaV5fyPr7lo8opWBio=;
 b=PBEKPdM82ExDxfECj4Z4Dh5j97vddZLeLs1ESAupMpx79gmF6Ss7Fr+f8CM2vnf8QVXwXNgzmQuRnixHgRSBAW6/S4n4335oClflPyIOF6Zz2cU+ntDLkyuS4gRnBv1j63Xya6uFv2gRMM92gKCohZBcvk+0AHggvO6wlDwjNoXwXpM4WVf26QXtKvD0o9Ivi7VA8foZsDImByoZzIYVvwQ0Oi54GMeJBJ8JRiaCn0dJwcGI/Ro2jMYR8S0s8D86mz11MtJksUTeCRgMMU0CwHa2T+7Q3RZRuB7YNSRgsrPDbNO5fO8moTeH2nC8TRgbRAtS+3JlXtUkgOiTHEChog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWPL+YeBLMVmrCYkAYt3GvnZESaV5fyPr7lo8opWBio=;
 b=R2gQtdrQC7gV/8Bu6zqWo7S7XJeGY3BQx/4c4DExFW0kBjwfc5oIe+tfrc7cUeVWr/RpLvXF5m9O9sRSibJ1dlTzG89vBEW7p9zhMEJzuohS7fIhsz4sid2HHtoGmnaNiJrDKGkYRFeG+XtXWgdMHROB+C/VQuvxF1WRFqnK/nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS0PR13MB7504.namprd13.prod.outlook.com (2603:10b6:8:294::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.16; Fri, 6 Feb 2026 16:10:03 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9564.016; Fri, 6 Feb 2026
 16:10:03 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>
Subject: Re: [PATCH v4 2/2] nfsdctl/rpc.nfsd: Add support for passing
 encrypted filehandle key
Date: Fri, 06 Feb 2026 11:09:59 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <B26A9ACD-F94B-4F0A-8BF6-C15228D62FD1@hammerspace.com>
In-Reply-To: <621062de3bfe3ca8fc8909db85a3d9cb5ca140f5.camel@kernel.org>
References: <cover.1770390642.git.bcodding@hammerspace.com>
 <733f98f0464b882574cfb58a7b108e270b843372.1770390642.git.bcodding@hammerspace.com>
 <621062de3bfe3ca8fc8909db85a3d9cb5ca140f5.camel@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0PR07CA0117.namprd07.prod.outlook.com
 (2603:10b6:510:4::32) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS0PR13MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: abea84e3-909a-48a0-1b80-08de659a2f58
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fToyJZRgrvwrzTaW/1LG2Go1470EJLwfjKEqwX5fvC29bfi+WE/pWm0E/4+p?=
 =?us-ascii?Q?MvM+fwXmipO5sdcVi/fREfO3PsqKKehQ/HgPMpi7QvMEYtM/ARS6H/LUd6+U?=
 =?us-ascii?Q?NUwJPt9iV95j+qDz9f08k1CY8C1Os8SUFsn5TT/CXIllRddXARJk+/shtNsy?=
 =?us-ascii?Q?oUb/Xn5ZV93bYTZXO1GyH86P0pmGc5b78LJ9Znl4LlDsG/iSum13r70CnJj1?=
 =?us-ascii?Q?+yoRRzs4a/gUXiKJlxyFxcfP8dXQGpeBbIiPKX+4Ayujk3etN31MHkSxCDHo?=
 =?us-ascii?Q?XRWoxWdLsqxIoW8B/zONeRWwV8VDiNyIbpXHes4HR4iZZdm6xpMLXVY7tYYs?=
 =?us-ascii?Q?81xUmIkEjOEF9gAH6vDCbEkVa4bXApYnMX+DQcN+z9aTeSORT+1epd55sM6l?=
 =?us-ascii?Q?IjKval0807ZjUVIJCIsN7CHtHAHsNX5jM96YtvhDgEL3DI/3WQ6q1rsF2/P3?=
 =?us-ascii?Q?V2mgnGdY4q59nEFGnZeh4DuLXsFe8E2CqtiZ1mM5bYXOqMoFlNkEkSixRbu/?=
 =?us-ascii?Q?TaxadLHefawDUKX7PCquQzqq1NcjJXpHXisHEXmq29XO5//46uvCrFvwnUjU?=
 =?us-ascii?Q?D7v8DfC1/kkoFyvs5+Qt8D0bk0HLhUhEAXrX4EB6B7JPOc3yRzUPn6WpnV5j?=
 =?us-ascii?Q?ok2119wRlCawsIln2sLFX4c5tuM44m4cB8VDfXA79Dq9Y7bKKmdJrEMbVWeC?=
 =?us-ascii?Q?9/sd3cuNbZ9ej+xBUxGRduHZ5wRVriqnlcEcNCuyYWNnCS0ApsM8Pnd0YD+8?=
 =?us-ascii?Q?CGRXhb51sa6LDOF4syK5+ifqPDS0Tcql6nNJl8Brl6se8NzWArQRkRFT0awt?=
 =?us-ascii?Q?8zuIC3W9R52jqKSep0D5MBOZLbnBEe69ZQ8F9Z/OR2scDN7d++3cnBoqGrjV?=
 =?us-ascii?Q?rIwPf/dWW1n5CjmY1BcK+W/ntC6qCq0rgenqMGn9GFwo0GD1DPxoySwZnAH7?=
 =?us-ascii?Q?Obc1mhrkIPykp/4HRD2TuhHM1zOC+VQH8GLnUbmncJs0Zj+fOZ/Q5MnPliI5?=
 =?us-ascii?Q?DJakTae1mx10Cx9jiTTwuliN2iO95BZK4PHLXkcHVQZlBjkr0CCKUQxqAR6W?=
 =?us-ascii?Q?SEBnClZZO90xYRbBiT12yTxu6IV9fRlmNH8dVDs0L/f+YRq0SaRUsqo18dp9?=
 =?us-ascii?Q?vfTFZvjdx7Rsp/NtNsJMuZG4BGmqfkRoKLzJ6h+V0xfMOkGNNBP5Ki4l4Y2E?=
 =?us-ascii?Q?BeKyUzgwXM/tPX0Dgya/+WmhutnU3ExuIqhFP4bbCSvXv69UOqxjpHuKd8fR?=
 =?us-ascii?Q?VZHni17MrFGCkk00d6pnfo/OB4ZBTHX01WXsF3FHm/eYH0pJaOhAE3s6N6EE?=
 =?us-ascii?Q?s3CmCdBfjeMgTGMIXCgTUEZ2WEl38gHMBhDhns3k5FReLBLBeYJzraRDnZ+I?=
 =?us-ascii?Q?A75nL2Nee2NJ7pe7+4Yidz6h8irBu5yrxX7wxwYfj8oDPAeg15xexNYKXyaD?=
 =?us-ascii?Q?zww+6CO9fKAekq/9e4FhkhY33bxOonvNmAcWb4DbcDQ80w7zenrSemneUERa?=
 =?us-ascii?Q?u8/aHTdv1ZuVhyVt+/ukR2kaQshKcl6ILurS4ONWeK+Q/kd/Ble23kBb6mZN?=
 =?us-ascii?Q?falcfqKzGSaesm14tlE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KevOBLnbK1bMAN03saOCnFqGXQ9sdgddLAnx8w2RcZA15zoxGw4dKBXFuxm4?=
 =?us-ascii?Q?lboU6yvNyG/Jyeb8+NrvcCLON5iryM9dyH2rt9j1GbjDkmyORsK15zR4pr/w?=
 =?us-ascii?Q?s+DT0BbclMUaBxKf2ywaRdHe4NHfTnZvfFz/Xc+SHtNtLIQZRxwT7vl7UIrm?=
 =?us-ascii?Q?6oMT75ZXxC0B4mmUXou4BVDhEzg6wmiUaQh/IVGuf65eVeABF+KcrwbbeSDT?=
 =?us-ascii?Q?ZgD9r21CWKhAfen83dKCI+/QaRoE42pKeLTu3PDYw+n2cn6bLWGDxsRCPBmz?=
 =?us-ascii?Q?/+K9nNULaptLaVZR7KfIrrQUIv0lDlwsCo4bJ/t7SJAyPl1VeZgfoz55Vrs3?=
 =?us-ascii?Q?4INN2jSrBWRjrfDMAUVbJ7zUo7oXEzZxICPh0fo//ZjOYI5iWZR7P8L7hOYm?=
 =?us-ascii?Q?+rgGR+8qdLiecqi69Sbs/gHjHtSptVCvjqGPJOdkA3rx2PhQ9VrrJBo8vIb1?=
 =?us-ascii?Q?3Ha/ZBamT+QTLXoAOwOJgPoTH+at4nKJOmmO46+5D0tlIj2EcVPbfocWTR3z?=
 =?us-ascii?Q?SgoCaYj6PNqJtmOQlgrb9GRftrEE/piBeCcZdFsINsAPvfEIlowx5RHCilmy?=
 =?us-ascii?Q?UvOFrbFUY2q8QCipHK36ErVkDtHY2pDccHLRXEj1LTHvsbLrv0GPesZJ+LZY?=
 =?us-ascii?Q?JEC296hOAHUxgDUKOGjYCfo9SS8Rc4wArd4hNOG5rQSZL1UWuAk9RbfMuFnP?=
 =?us-ascii?Q?B9F75Xwi3e9ZtC486BfOSAj2snCytXtMX5MTi89F2lpiYFdRw+uy183/segb?=
 =?us-ascii?Q?Ax0N9qMoDhkjZAYYYrt3Z/qAeMZffNSS0mrp/5dQsmmEKQ+h5GEuCFVW6UxM?=
 =?us-ascii?Q?V0m1xpSol3GV2kAHr+8EJVP/KsnMEWcSDnxQkmiootUBSY8bhNr6GtZy2dhP?=
 =?us-ascii?Q?62I8PscmybuyxqRb3JGAL4ktTWPp5CIJYb6dmFcWe4y89n9L9XgQKsmMqebR?=
 =?us-ascii?Q?4pyOG0NzFYEGMe/pd95H8LDyTyzKD9IaEYEEJH1J0sN5EVtAeRacPB6erH44?=
 =?us-ascii?Q?HFV8XztKw9WGHRT482lWUpMlxhWtGSxFatObUADhB2qNgVPX+8hFFQNfGHyq?=
 =?us-ascii?Q?wCCFsyVhzm+g5Kq5NPOy+V9suv63JJS5mZb8IIJeywxQVoz/egWhfuqelCMk?=
 =?us-ascii?Q?6V7XsqFByjbYzemYHNVG4YJrKpngeU3w6U7pWxDmXSXk+Xhd0lJ3sH0U7mUm?=
 =?us-ascii?Q?5GKP9rPjermnJn5DMyHhL35OGGtUq/KZay76HyF7p2YmXYAsb1vDJi3wc1Op?=
 =?us-ascii?Q?EXsT7c7sxTxzNzoW3XwFFB7XLKb9SOskbn7BPiXuc9kUYbPonHEKKk62TFtu?=
 =?us-ascii?Q?xqz7D+ZZs35ztcmrWoRIhegdhH1X0OyGph7+P9vUh/xecZFROAClWCT/GoT9?=
 =?us-ascii?Q?9RR2L14J/PSZDcXRtzn3S+jGZHx+Yv4PuCiNB9fFn5hi6oQfcGsr/DnXmYvU?=
 =?us-ascii?Q?Z3P+LxRt/SuFTXps0WIn5jYV9WTsUE9L6o3pkHE+xWlhENhvuuYNtQnTh8y/?=
 =?us-ascii?Q?fa30SZ97Wq4FVTaHPpJ3thKWr4u1FACMQvrUkj9fkHhKE7sJDeOCHlI2A0dY?=
 =?us-ascii?Q?XxAqkdITrWvrVsZnmPNPTHFOWd3yQVUR9atCchHkb6OpuIjRVgqRaXKaq+27?=
 =?us-ascii?Q?tS5pLCUDMG9ya0eIDk7Av0+6IJQ01O0oQ/y7+MrQYBGK6grFCeiz3M3MBUNM?=
 =?us-ascii?Q?5++bCKQyqiuKJoRMuNtPJwjO/XXmFjGoFk7wlgTl3B8IphZidJxeOUOS+05I?=
 =?us-ascii?Q?sKstguw9vGHLo9r9UUjy0i4g8qRbMdU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abea84e3-909a-48a0-1b80-08de659a2f58
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 16:10:02.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ3KVpq/UTs1F/QwARNWx1+KgiFvzxoTU1Jj8OvnBxFbwBj+jcKCenJaHfWBuCebY+gWmJrBzo8fXVgxx4r8zWOTHmhldHDf6h7dx0e2NRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB7504
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18787-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA94A1001D8
X-Rspamd-Action: no action

On 6 Feb 2026, at 10:58, Jeff Layton wrote:

> On Fri, 2026-02-06 at 10:15 -0500, Benjamin Coddington wrote:
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
>>  utils/nfsdctl/nfsdctl.c      | 39 ++++++++++++++++--
>>  8 files changed, 122 insertions(+), 6 deletions(-)
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
>> index ecdc4fc90327..a6b5c907b457 100644
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
>> index e9efbc9e63d8..97c7447f4d14 100644
>> --- a/utils/nfsdctl/nfsd_netlink.h
>> +++ b/utils/nfsdctl/nfsd_netlink.h
>> @@ -36,6 +36,7 @@ enum {
>>  	NFSD_A_SERVER_LEASETIME,
>>  	NFSD_A_SERVER_SCOPE,
>>  	NFSD_A_SERVER_MIN_THREADS,
>> +	NFSD_A_SERVER_FH_KEY,
>>
>>  	__NFSD_A_SERVER_MAX,
>>  	NFSD_A_SERVER_MAX =3D (__NFSD_A_SERVER_MAX - 1)
>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>> index 6a20d180a81e..2369a8495954 100644
>> --- a/utils/nfsdctl/nfsdctl.c
>> +++ b/utils/nfsdctl/nfsdctl.c
>> @@ -29,6 +29,7 @@
>>
>>  #include <readline/readline.h>
>>  #include <readline/history.h>
>> +#include <uuid/uuid.h>
>>
>>  #ifdef USE_SYSTEM_NFSD_NETLINK_H
>>  #include <linux/nfsd_netlink.h>
>> @@ -42,6 +43,7 @@
>>  #include "lockd_netlink.h"
>>  #endif
>>
>> +#include "nfslib.h"
>>  #include "nfsdctl.h"
>>  #include "conffile.h"
>>  #include "xlog.h"
>> @@ -636,8 +638,10 @@ out:
>>  }
>>
>>  static int threads_doit(struct nl_sock *sock, int cmd, int grace, int=
 lease,
>> -			int pool_count, int *pool_threads, char *scope, int minthreads)
>> +			int pool_count, int *pool_threads, char *scope, int minthreads,
>> +			uuid_t fh_key)
>>  {
>> +	struct nl_data *fh_key_data =3D NULL;
>>  	struct genlmsghdr *ghdr;
>>  	struct nlmsghdr *nlh;
>>  	struct nl_msg *msg;
>
> I think you should add a --fh-key-file=3D option to the "threads" comma=
nd
> too.
>
>> @@ -663,6 +667,19 @@ static int threads_doit(struct nl_sock *sock, int=
 cmd, int grace, int lease,
>>  			nla_put_string(msg, NFSD_A_SERVER_SCOPE, scope);
>>  		if (minthreads >=3D 0)
>>  			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
>> +		if (!uuid_is_null(fh_key)) {
>> +			if (nfsd_threads_max_nlattr < NFSD_A_SERVER_FH_KEY) {
>
> I would move this check into the caller, so you can handle errors
> differently. The "threads" command should fail if someone specifies
> --fh-key-file and it can't be set. That command is intended to be
> interactive.

Ok - I can do this.

> For "autostart", I'm not sure:
>
> Wouldn't it be better to fail to start if the kernel doesn't support
> setting a key? The clients are going to end up with stale filehandles
> in that case, no?

No.. if the kernel doesn't support setting a key its not giving out any
signed filehandles.  I guess you're thinking about the "downgraded kernel=
"
case - while I'm thinking about the "upgraded nfs-utils" case.  I'm not s=
ure
we can handle them both in userspace (nfs-utils can't tell), and the kern=
el
makes sure not to give out filehandles for exports that have "sign_fh" bu=
t
no key, and an export with "sign_fh" on a downgraded kernel won't export
because the option returns an error.

> I'd hate to mistakenly boot into an old kernel and end up with all of
> my clients falling over.

Right - ok, you're definitely thinking about downgraded kernel.  For this=

case, the exportfs will reject the export config that has "sign_fh".

>
>> +				xlog(L_ERROR, "This kernel does not support signed filehandles.")=
;
>> +			} else {
>> +				fh_key_data =3D nl_data_alloc(fh_key, sizeof(uuid_t));
>> +				if (!fh_key_data) {
>> +					xlog(L_ERROR, "failed to allocate netlink data");
>> +					ret =3D 1;
>> +					goto out;
>> +				}
>> +				nla_put_data(msg, NFSD_A_SERVER_FH_KEY, fh_key_data);
>> +			}
>> +		}
>
> I think it would be best if the "threads" command failed with a hard
> error if the key can't be set, but I'm OK with the

lost a part here - you're ok with autostart succeeding?

Thanks for the looks!
Ben

