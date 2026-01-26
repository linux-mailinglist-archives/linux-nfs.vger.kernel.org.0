Return-Path: <linux-nfs+bounces-18479-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L+DKNqgd2kCjQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18479-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 18:14:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8E8B593
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21BF83008099
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CED34A788;
	Mon, 26 Jan 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAbOkIHo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6933A71F;
	Mon, 26 Jan 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447614; cv=fail; b=V/NXr4kQBvL+BdU90ppszszjaBU44T0veg0TS4trK+GhcyYFyKFHDW+eiN2mspKTqMiDXt3WjDMvxZ95gMEoA9KNrpL2IuvNMDwFMGPTmvXuzszTK/JQ2VSvUCSz1PnYBdZg+3giVDHhb1UpQ5FVdFzA2hd14UMZd1hbss/tGJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447614; c=relaxed/simple;
	bh=gVkJ1yzyzo0aSA4EhNHI6s7veeU0JlHNSEtxDSoW0yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbGGUs2fymznAw1Ww+V3wUkRlH7oAoiq8ncns9wEFHT6soNBRR+osRHmO7jiFc3SmjrJea4QX3F3JUPtIuFK+aMvfvcbHBLzehkpv3c66ss6GVibKwlly5mkD437p9p772smFb9pRe3B9sWInCS+FJRjbuoqVcqm/7KZClneXxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAbOkIHo; arc=fail smtp.client-ip=52.101.61.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnVoNe4SwuOLvjZnP8sAZBoQfVbnHIx5v0e9YRv4rL3ES0qLbYJO0JQzpWRDdeexKZ68/tFUI5wMBAzi4nHCCyTIWsfcg9TwrTkCdJ66Ux013+aB51omOrSpk1paCR4i5/dFL8fkq8PIRzNcudw2pXWCWggSUVgMwkf87zU4fu3idUFw7wnuJiGc/wOIsGI0blIXgy3O9aW9jzxXPFdGQXKe9nAr/qzpCXe13NmVNOynLu/xb7rRvEWBM1bBNWjcfhz/w3MCxUowUbdC5gZpZh+aOERA94aS6BuBe+VkvPG7HppO1AWaGzObot4YsTIW3v+i7ze7wf5EOE4K6goswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVkJ1yzyzo0aSA4EhNHI6s7veeU0JlHNSEtxDSoW0yM=;
 b=xL74RoKdSUZxbRZ/LrybK8cDDs6vnf+AOMMLkDmZ5pZXolP55PhaJjNnSFmnw6g/RZgvfzLLzBsp2Vw1QHpCU5ywjdueDEUr4VVtgShRZ0CozIODZIlFVGq/N9QKmpCDOavQVcihVpZwFWL1/Zkdu8D/1jL+yCyrpdIZhqmre0YiMUruku8Mlfj9M8VRRA1E5QSxwrvgRUbsw9xvIo0VXDDyHFVigddnQO4i3Bpbr1gr3Y5RL/dp+z6CsQ3pz8hN/UByTPio48kxSPOoxfOf0RRNyVYD30QzBe6qVoBCWHHgdJZRipm99eA1gXU/b4/8pwpIkGrZ/OuVc/b6FxeElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVkJ1yzyzo0aSA4EhNHI6s7veeU0JlHNSEtxDSoW0yM=;
 b=cAbOkIHo7vtRBo9ymyl6/YhyKN9bl0UfcgIynYCMGhGmR9z4Lm2lPE7bN7S9GIRQ/+6qNpE/vrhVfptrjhFrwvjsrWVh1ti9cmir0Nd38txlfY5Q01WoSgwkDlKYJu1Qcg5L3GZx66lTl2SQ6kcgv6sHF20EcQZyYtZN6UylZIwcfT+1XardSsMJRvuXihe5/MPVir+z7ZthcbLo7WCCCMdZhQLiGg3tSxMM3aa/S+qDXjuUs4jHhNrL+BCZVB6d60VKOj0WcJN7FXw0yLYvkQkYQYE5HsgZIEQusIOmCvKsxMzIhAJOgaDk4qavNdwK2vmaKGMZ8rdikuXCc8DgsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 17:13:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 17:13:27 +0000
Date: Mon, 26 Jan 2026 13:13:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chuck Lever <cel@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 0/5] Add a bio_vec based API to core/rw.c
Message-ID: <20260126171319.GO1134360@nvidia.com>
References: <20260122220401.1143331-1-cel@kernel.org>
 <c02ab348-5243-4e97-b916-6bd59ffe769a@linux.dev>
 <d67a30a0-5ff1-4e31-a168-81f8b7bee97f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67a30a0-5ff1-4e31-a168-81f8b7bee97f@kernel.org>
X-ClientProxiedBy: BL0PR1501CA0001.namprd15.prod.outlook.com
 (2603:10b6:207:17::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 5890da99-ae20-4e64-040e-08de5cfe3863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8NGYbVfXQuGDNnjlF7iXLjrSsTFpgRTgSPV4qCGU07UB047g8+Z3PedQ9By8?=
 =?us-ascii?Q?wrEoRx6646Cuy9rHDY0OuQCVpyNL38fXc3jVDzWsUpmScpP+Wx7AhHytytFZ?=
 =?us-ascii?Q?5lEsOSqQSDV1T46oof/U2Fd3KM4u3QM4DNGRh7fsCNs6i6DhH9dI5UN5vPWm?=
 =?us-ascii?Q?B2oTTfdSHk7dahMmE3du9Bzxws+Co79GHmawlKHSEZgUVM5817fqLIPOHgkG?=
 =?us-ascii?Q?wIx1Gjcc99bpM5cOCC3FFq5bRGzOZqA1wYW6S6KgbMygsBG7w0XOBM1wA/G5?=
 =?us-ascii?Q?afmBsXMLjfr723pUTY+dmmdbJosL55K6ZX7k1tiiJyCcGJlr6PVFSQ7ccZvp?=
 =?us-ascii?Q?EKu4csIcAC2J666DNvkZIQTe1zXySn8dvoobp4dexvSf/gJDZwjZzT3NItE3?=
 =?us-ascii?Q?ORBh+RBau6vIvhqELyes0O+9+8BbMzaKM+MScLhLxPpbQJQ0SXRP+RHjcFJ1?=
 =?us-ascii?Q?7cs9l41MgiYqexYRWTpdnZkBhXaCYOD3TPM1oA4rmRIvrV28AOTLV5N/QBLQ?=
 =?us-ascii?Q?G/0kHnntNAGLi12hD29YjHFld4uhiLOPhc/0ZCKbGd97wpNrKjrNlvaz/FVA?=
 =?us-ascii?Q?/rU8/JG4OrrTEW2ccX6h+8nR83zwTN6R64Ux5ckT/LcPznnRuvDH/ygd8Uib?=
 =?us-ascii?Q?A9YHuUcGxhZMFO4mT1QiAi56hyW+FkmhZqMFd8+ZpiRTbRTd3TKGCUzEskZ0?=
 =?us-ascii?Q?ZBDmeYDmSHYUYmI1R4LUOYQzsea1yvalFPtkVpQPvpw58N5bDwBfNktcVp1P?=
 =?us-ascii?Q?7MyONx6wdtspvOowgnPKcJ8/IZRoWiz5h/b6vkywpKHVPeybnS3lh0eCeFDu?=
 =?us-ascii?Q?TJ5BNEZSeIy2+uBUhhFC75lO4UHh8bKvGdOJwNZEh9ilhF+2G00dG8MfO9GS?=
 =?us-ascii?Q?CgGaFXVOSGhrKwrKBm9wmWcG8Y7fC3+PwECGeXxadyN9GGWO1tBddm+m9RWC?=
 =?us-ascii?Q?z/NTeUXq2O7rjlgxuK0AFF2HcEJD+WmRFOEpb2Ei65/rSHQR5JXm6VaKFeXf?=
 =?us-ascii?Q?Ig2Z3Qqs9XmgxWVekzvmP0ruclkkhdrXHUsfkFO324T39bOtri+n/p6qVWcr?=
 =?us-ascii?Q?JpV/s6JhMOPt4uD5QxuI/sqLBqdXNjxkh7ZxjrkwAEAPjdFPTaZSqum6L8f6?=
 =?us-ascii?Q?VgwEfrk2Tt5oNv5TNraEexJnJ2UglGkT8fj/WOe1ccioMvrU4Y+mSvkoE4dj?=
 =?us-ascii?Q?sVl/aglCnDShVUP5zEC1VieKwvlpFpUp1a0mDVuCozFyHYLyCFNKWhPBN7Sw?=
 =?us-ascii?Q?UFhGTLGY/PIoYKhgzCFRlNBvTUQOy2ilCODXYKk1ydDUC6pkx3AEg11orC0n?=
 =?us-ascii?Q?F8WV4TpHeKKTqGzTD/SSS5OmnEFb8XIjxNg7BtRP3+jMgcBzT5sQBQM8RrY8?=
 =?us-ascii?Q?eaZAwLQ7UGBl+s+a2PAty9/tgkzhHRMPDuaNm2QJPM1m+PvxdAHw/XuZcEhf?=
 =?us-ascii?Q?zF25VXJcyJ1KtNRVIuW6r2JWmXaicwXjHcQn9+X6O6VvxE9K9fh+PqEXoP/W?=
 =?us-ascii?Q?mfDN84UzxgUMkCJ1JwtuWtqKCrsOUZP9r3eGLSs3xVBPyp+7f+f7aUwW5yep?=
 =?us-ascii?Q?jAMsbfMaT07yjfS2ccs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzMPn6w/yVhGJsJtyny8SGBjFVUzxKnHZtpQB4T3C9Ekv7uUr+PggWnY9XSu?=
 =?us-ascii?Q?UYYobKjCbYGoskGbqGGwJiyEeNxx3M2+mSIO4fpbOXaVbuLthOuyRq7WdFmj?=
 =?us-ascii?Q?ipOUkoMAV0rUblU9buOAov7sVd4NI8ss09rNySHkvBuaSwDkLTkcsXLpiEpJ?=
 =?us-ascii?Q?JZvTIRxLQMZfPgDydc0vZAt1WFHXHjm2BGKZ+ZzPGhRP7kqnaso4nbufawFQ?=
 =?us-ascii?Q?5eR5IPm4nK18zj9N7Bo5WYjzYpgrtGUT4iz7MEN/tIt7SJEj7Qp9z/vjLnW5?=
 =?us-ascii?Q?s1cNo+m+2zMwgRLcoeeUKkDbh0CFglyEvg2ZAdbLdZjQE4JYweDiEFvGGtza?=
 =?us-ascii?Q?1uDp9bIhr87w1/WEfbqMNPrxzfHasTnEJ0vudTylHV5qDikEd0ERH79Q3h/b?=
 =?us-ascii?Q?ZcRLW0iZMfPxiFT+GE7pY4uLq0qqZ1sHekdRtb/2k0TF3xmnvWnqjm1UfqT0?=
 =?us-ascii?Q?XsLOSz5tM9H1N3P8IPAp5E0kBeZkZafd1qxPp7+oPx23WWI3obsZnz7CBxcr?=
 =?us-ascii?Q?YveB7A1crLYavJJlKmGPdUlx2U2ZKPFedZoORnk/Cx3gWUEHQxIH3zfzy6sU?=
 =?us-ascii?Q?XTf7BjQvD82/o1pPRSHUMvBRMEQpZoI29+UCoRIupqY8cgMNYHkNj5qfvcOa?=
 =?us-ascii?Q?IJHS06vpIvARAuhXSlGtxavUYnQKg9MNkG8EiGMsNZ1QpUA/tlRXEjEjqnFu?=
 =?us-ascii?Q?LEWSgrJXRdeS0AKBqkGXIgxGKrrPECfyx51116QnhOmWPolnVyEwPc3enVau?=
 =?us-ascii?Q?H9M/oofj8wNPHKCRMvv1SufwytLEUi+WFEx/lI5LBcxWPkJIMEXQeW3JXm/J?=
 =?us-ascii?Q?r1oMmVovnwAr2+KkquFqn24DRwu+pZvmHeVeUD4NH9q7ohIEYwJwtkDjjDia?=
 =?us-ascii?Q?bsUxEi1Dsr4h3niBYxamVHjXytO3BkKSaKlrqTFgrrLZe9pLxijEcN2AbuRn?=
 =?us-ascii?Q?/EEeX8ALGN0H2jfUeYt9UR1JEmKCXPZGzgCHLjKSqaVd+waS/S1qb631YHA5?=
 =?us-ascii?Q?NPPnKsaGU8UDKz31FeWkTyCRCLMTH/yI4VYJU89Vj0zLdbW4n1FOdVTJS6NI?=
 =?us-ascii?Q?ELyjILzFKw6oNKRn+jyiwlZMpwZPILdl4LVUq/TjxVqoVAh2G7tudEIawkUX?=
 =?us-ascii?Q?EXhXCU/l88IhgkPpt49uOUAKolQ8hUGMN2GfQQMHUPG5xdaaI81jIJUdT/bQ?=
 =?us-ascii?Q?T9NU2TI/6mpJX23R9FXfq4XTkcGAOoyvvlw9lEL6JTh5eq9KzFF6G/xv3Pvy?=
 =?us-ascii?Q?RDs8eYGgXjYMHll4Im4ZBVA5DzgimBCEP9x+I5eg0UfGyfspyCBVujs38R7m?=
 =?us-ascii?Q?o92cv7XcHpVZFld1GZH3MglLGIwF5E/xjGZXMpLJm5KH5nqIdRi+laKu0lh4?=
 =?us-ascii?Q?0o1RopENYlYwLCas1eyHoWBwTne9utKdzp/021reTi7N4p7a21mWWGD9b6fO?=
 =?us-ascii?Q?bYez3lIUhYBJuecPXoNLoe/yIn22Ku7scjl/NA4jWN01e/5eQ32W4U9XaS24?=
 =?us-ascii?Q?cOOd+cp6rUiUwqTIECJiOatCOiSaocwPxQBX0+agD/FQrgzjFnwCgP8d+uob?=
 =?us-ascii?Q?+Oqa58hdC717hpWPlYK5GyMMEcU6qkS3ykam8Vx8ziRYD6uGNa2m7HlvrpWy?=
 =?us-ascii?Q?86NJciaiFycakJJnsNbgFlVwBdrk5AvjXjz77PKRSQJNWUn1bAMRScCrFeTt?=
 =?us-ascii?Q?xDVe7l21ibb+vTHmd7NX6CvGr6FwRuxSs/xn5S62kLZ3x9jp6Tp2FVQT1wjp?=
 =?us-ascii?Q?2KkAVTsyqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5890da99-ae20-4e64-040e-08de5cfe3863
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:13:27.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fJU9GPf6o1BWXRNdoeV9/Aj4RSzfFZl4EDzCBqpzg/Z7EFaZ8F+MqMgyxMFPFDr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18479-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: CCD8E8B593
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:13:47AM -0500, Chuck Lever wrote:

> The main purpose of the series, however, is part of an effort to enable
> kernel-wide replacement of the use of scatter-gather lists, which are
> technical debt. Socket APIs already support struct bio_vec.

I haven't imagined tree wide, but I am envisioning a world where a
modern server runs all its primary IO paths without using
scatterlist..

Jason

