Return-Path: <linux-nfs+bounces-18821-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB/UHeosimkjIAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18821-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:52:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E15113DAA
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Feb 2026 19:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5FC301B90B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Feb 2026 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D323D410A;
	Mon,  9 Feb 2026 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="XSynV9gY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020111.outbound.protection.outlook.com [52.101.46.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B83B8D65
	for <linux-nfs@vger.kernel.org>; Mon,  9 Feb 2026 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663137; cv=fail; b=MthXb2u8EqI3LOn3D4JT6Wl0V0PYI4o+rSnnbserCMZr4DmUwzl/kTkLsAe3+XrJ691PDu6JZX7iEM2+aulwdOoXkRFlLtS+vuP9fHyreKMX4SKNQBl7hRC3Rq1BTCC/cP2lUaVua4hmmoVwwwERGHOUMP1+IANjYavW9sW3dco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663137; c=relaxed/simple;
	bh=8iydX0cKPITF0FkTHsY1SYRvMXDeyX6K4K76RSA5mx4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m0zVnYLDHPEPlfDqvVaJ7qS2rnoMloRwQ6At/qYs/JxO99Wj5PdGozYFhk/fEXq28LjW1OQw0D6mvtuTci+k1t2HQjLIkRPVN3Syr0mFh9KwRqZAlkOnsMky7hPuP2cztBSqHMohJkSEuqx3tmwCwNcegGRjFzVE1VaANvVoYCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=XSynV9gY; arc=fail smtp.client-ip=52.101.46.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzoR7nFeZ+tyLFsFUrNBaiAxSPH96b59SeJtanwb7vfSeWQ35zpdV+JK+cuSV/epaWijeoh59bqJjRKyRNRcXQYkmSLMMZRHPa/u/nuKf8SlC1LJFe2FfRgQRYRTDV9rKUz339+mXnQ4jfd7hu3dCQWZSj63FSka6nfnDy+0ThCmqUycFEkhHg/UisgAxLP7ea9z6oHtcwRddrYY5y1MsmI0F3sVT95m0/aCoPgzL56b9ieeMTX4DNmAxtFE/etgrvPXm8HjpVxLK4H8b6GH+jgjoG+HOERFn8/Ukmwp9gN8Q9Qy+LukAl8ZadAAuZ5dhqv4TrL9P32LZlGfRoVv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq4zNHwqOEWKNLcyW93gdv+RuHqftWLMA5/TcFOBWOM=;
 b=EcGb6zU6EShhbLlvwp+YA7JURx9aDMKC+x1Nclc68mTOk8LUFeybUVqXPPxWUPTE/MzIkbLJdO/r4bhqmY/BZh7eDdndnzYbe5LFMS3ZNZsL4djnJ4Q/dw0DgmOyor72mf0l1ZQT73eUnLyAQAi+2UfKcXC5GyG/hIZLLtX/tAHOmkD5x/FUTbPUwVFAI2n+RzarbPtSmm4rAnn0QOOAxNaYRIiKsM64oOBcfJTQH/VBjyfD6wIUG65KHQBaAuE6nyxlk0j+F13WjZQejcdy7JNui4oJRTmKM7t9HeaFIbxsYpATvBGm7BnQfGRdY3bBOX9nOUjKzNPxEalycW3Zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq4zNHwqOEWKNLcyW93gdv+RuHqftWLMA5/TcFOBWOM=;
 b=XSynV9gYvEaQL4U7lxQOflg1BBtNuJUhgi/MbRLbmzzkNgZtZd3xOGpyWLtBXcojvAQbc0+HQFj7vAwm2qw1GKAMkyIhs3fAg9+anf/O4rDinwoVfV/bOjv6D6HpVBCCo/7rEBtggyT0voV77fGRYt2/zAUWS+kJJP6IF8OWzI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM6PR13MB3740.namprd13.prod.outlook.com (2603:10b6:5:24a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Mon, 9 Feb 2026 18:52:11 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 18:52:11 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/2] nfs-utils: signed filehandle support
Date: Mon,  9 Feb 2026 13:52:07 -0500
Message-ID: <cover.1770662817.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::35) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM6PR13MB3740:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7476bd-0df0-4000-c0fb-08de680c551b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O1U1xQ8K9yh880VPjj5WZbKwnAM1b+Ax9rcjKYz/xWUzfY24os1vxsWUlKRW?=
 =?us-ascii?Q?8wwoIg2tEuqEEBrvzf8QJl4qoi3JdGh2RyenBC0xj9oloFE9NiA02Gi2s3Jj?=
 =?us-ascii?Q?hHCQInFqGxwQL8gaOKbyAgxSHk02zyUDNCHI1Yvh8tOLfbu+Eh2DgwkIIlZG?=
 =?us-ascii?Q?4RsQv/ianjupDvzny7f2JxNAKBXS9sz5uuzSws9LUr29T/T+zE6oLQFBmOBD?=
 =?us-ascii?Q?TKusKjOynEorw3sU1xztO5/yeOllRj6lCiheU4pETogubE8xjfEuFlYcG3aS?=
 =?us-ascii?Q?44iT88qh1l4EyyweDv35MLIIb7QXPbh8VCuni9ENghcDEjOQ4pqi4nJwC2lR?=
 =?us-ascii?Q?66ikJhqjCR8qAuB6PvYpJpNUUWH7hqj3+M7xdv5Ela1KJv4lnMgoTedNeTTK?=
 =?us-ascii?Q?IS7S+Bcr3B9cuB5gpCY7K7msnFSPqHzdOlkIEPMT9XBP/Pla/VLAh5yfesiu?=
 =?us-ascii?Q?OQj6HrNMKZPpMaBlwYSJTj9Iuvhd9sjnaLqDUJQO1M2rXebgywVHGSsFYd8e?=
 =?us-ascii?Q?BRUpOEFKspZ0Rz6ifVE8TIEOZKN4ifjhOEfbCAdw42Tsza5j4TBa5kDh1rg6?=
 =?us-ascii?Q?m2BTIYnw6F4ewZhx/F/AhAp2wLGQWAJq5ErHbKnEUIYHmfCV7lkg4a5lCNEf?=
 =?us-ascii?Q?SlxL0Q9xQhTX9whV07nRESsGue7BmnhNNrOlVVhXIJk1OMOGate1BgZ8T1A1?=
 =?us-ascii?Q?NqZbHcA239/Y4jezoNvv/w29YtPFBubQ2I4M00EnuetpJKbogrdAgiNvaVVB?=
 =?us-ascii?Q?eyirZq86GJzfAu9h2cY0/OqvqI0Td5t/lPxcOWO863uekjEtWBTXZ7Cf3e9w?=
 =?us-ascii?Q?YYZlzJImIIQeRs9ERbKt2BZ2loO0YS8sjjSAci5U6fQtQJzm6ijL6PHzIpPm?=
 =?us-ascii?Q?ULPVWVfTjccsM3qyeR/CkLBet7YU9f447ggFpUiB5L/omguthtlEULVd9KIm?=
 =?us-ascii?Q?pvxkm2E2fRIEJEwnfzb8vzmq58wZsDw4j0BZ3TFbkzmDHlhlJFasCeNW+ACu?=
 =?us-ascii?Q?ENBgDvwM6mLOfBPjjpgZKBtO4yqYc065T2cUSRupX7Fo4CkwvzSEJ2qRe8oC?=
 =?us-ascii?Q?mgURiMV/b+9g/7KeylihhwdZEc3wkONLLDnJQfyAHdAxzh2goFSVBWwlLBlr?=
 =?us-ascii?Q?3APvJEJgKWXgv1X5YzJKf0rS/qycI6ecPEJtRUUK9mcVqwpT9hoKz1ebZuVS?=
 =?us-ascii?Q?QI4oJpvHmIgrWI6I5BDUNm0F6hT4vuQvotTcs7XeBWv2DX2qkuikLi/tzklX?=
 =?us-ascii?Q?e0kqWDXj8pyOAWJstfxvje4PPnPW15JYRe+/Nuu8BzfWpEGfNolXdN1jE2ie?=
 =?us-ascii?Q?iiA4sAHnBR9dgQ62jHOWp3FKCFalCFnlc4F6N/Z/VOl1RB9BJBsgbiPyL2XY?=
 =?us-ascii?Q?6fh6bI1MsH69HcrrN3xGWmKhZrDezCd4yE31klReKe4DwtAvyuVgSELFKner?=
 =?us-ascii?Q?/WBNbdcSaxOWGyBmOL+sOsq7pCZDQTnrXNj2zHy6ATbbMaM7kjH4eV6KTiZJ?=
 =?us-ascii?Q?TS5Z5UJQKI+d4FYo+WXTUnnId2eMPYMMmvXsXAwmn76/wO+nxc23x+EnoiF3?=
 =?us-ascii?Q?V+EBPMQGf1WDYpTr/Aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2+l2V3y1nsY7WwuseUstwpy+xpKklCE4aaRJFzeSZBd/6tVvt0LYha4q9oD?=
 =?us-ascii?Q?4+7URptD2Ec3OovdsbPD7inEYmxtjOtcLLVnHy4u01OFLtBmKnUbcupfrl0U?=
 =?us-ascii?Q?+1kesppjAu0cAWoip2T9W6UEv0I2ol2e7oNLm81sK7L029Y2aOIXScdks67f?=
 =?us-ascii?Q?40nYA8tMLbn6k5wpuFOEkg3Bcblwnko/WBZGefLuKVaCfHEQUfWxtEUropul?=
 =?us-ascii?Q?8W92/fo4zEx4R12oPDeKS9jWVsdiH2ejgHnKp5339EAxo0LpOg7fSYOgJrQt?=
 =?us-ascii?Q?AT3mgwd9umaA/AuNmOP/KDJmOMG5QZfGTC6UQwlg1yoGuOUoeFl0KtSyZl4X?=
 =?us-ascii?Q?KHP7h/oUd7Hf/gk6vVES+pnjmgcnPkh2dYNQqpx8ExyIntU0EuTkdsMHA5SF?=
 =?us-ascii?Q?0dzigkPR/GIELRa6TeHg+k0xO7+HVt5htqjAK7x/6lfv78lG9uc4r29Ko57Z?=
 =?us-ascii?Q?OhwLcr8H1JdH4xiytOS4uvU9JHxmDtTm2srFNC03zqpjUVYNn3ND4y5pu8DX?=
 =?us-ascii?Q?O1HfQJUpCes006dOlv9U06f2COaatpa5u40/L9MNZwffANtHkkBxrtDrCm2D?=
 =?us-ascii?Q?Bt5DLi7b5MOoKBAmzHBe/cyGm1Bpgxzru9wxa0GvvCZA0oSD6sGV5IPPcDBu?=
 =?us-ascii?Q?Spwdlo6mSWu2BtuN6fa1fbMzq+9CzR37XoIf/N/NwN1bZ7DkG32K0ruDVsME?=
 =?us-ascii?Q?PEtoFYu1JT3/N2V7+UFUysRXGOybCd4jTi1DysOEp3/lNu/HjGsniisux48q?=
 =?us-ascii?Q?Na19ZXGag0hJktSgVcx2tUOSiZRJDlHF+mRckViZ5FJwedQhIsZHZ0alLKw0?=
 =?us-ascii?Q?BIUOUB+4fGqPZfJ8ApUtHAYqQf6m7RcUpNh+ppVl6MDMrZHJkKs2npA6jjHK?=
 =?us-ascii?Q?dA2JObe99ENhTluE/715TP69Lanebrr7yNxVjbYqNWZaC71+dGuVp6Or+hmf?=
 =?us-ascii?Q?xeVbbkx1VJlDTkwH6R75JtnmBMKAzwwMKIE2E5WE4GJjeGHyun+dc26fSrsm?=
 =?us-ascii?Q?/vEqeUldHHbkHMBBpEY38yHvy4mwbrEfZJTDUURoMXGYlnnlkBGJQmsMA9p6?=
 =?us-ascii?Q?WZnDmZx60fk5xUA3iBAh4XIVvxHJeeg3k8ExP9uPRPkNc4VSNt8RgyxYEOhq?=
 =?us-ascii?Q?yj6cBNRsD5Cr/Lzn0D1q1z9vz0zmEGW9cVEWLNNKrmWEV97oI+aITVDAYOhx?=
 =?us-ascii?Q?ar0+E1shuYZVXPwZ3gsduD/hI6XghExu4fmMeg2jj1hX2mmHqTIk1u4Wwk6Z?=
 =?us-ascii?Q?0fMisOyMvvKA48CtFCP687p47xwrxmdASNHAUz7F5lP/eUul0RRkj41cO9vJ?=
 =?us-ascii?Q?9p3Lt9XcgelNM+9pNaxryOOcSr3P8v1jWzJK4FF7LXWyC2z7UG9jTPQtH4Si?=
 =?us-ascii?Q?HA7TeT7q94cGUyWG2UUuKsgY8YWTq0NAC8ylEQO3LLHFqGCUsL6bmwE5597h?=
 =?us-ascii?Q?ce6koC/iAfbpymatUrDXgCsOlSIH+LNY0DxjkUjBEHEdtXGqucUw67ZRY4aZ?=
 =?us-ascii?Q?Y82VMCY0fbXTHlolFI92Eu7efuPNA+u6EIAi6BkLCv3b2gLPChX7eoDpsLhV?=
 =?us-ascii?Q?X1a/Udhh1VhwKGxvTH3CaT9gFuDEbcXK4h5yvhkV8kKXZiuKkfLWdIPag/mm?=
 =?us-ascii?Q?n7uhCNgSr/YIt6T/zPMqj0bx8mWXmhnHbWylJq4Tm7JsJ28xeIQlBldI+H0o?=
 =?us-ascii?Q?8rDOXniiKtzvpJY/JZa+TAQLySZfay6rHwjfPw6Oz4wp8YptMeCsBzseykX4?=
 =?us-ascii?Q?V/LixVSUrZqM8XlXgbPNaSwXm7QesDM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7476bd-0df0-4000-c0fb-08de680c551b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:52:11.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCxUtzQh/1Ydw7gUI6oe5B3G1i8udXmQeMKL7wGL/ljvoiQhujcX0dgxXlB8Wx8WJaPKDEtARJDF5vMy6CVZEyvZrXroUmwpBmZ+BtuydgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18821-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15E15113DAA
X-Rspamd-Action: no action

Here are two patches allowing userspace to set a secret key for kNFSD to
sign filehandles, and also set the option to sign filehandles for an
export.

The secret key passed to the server is the first 128 bits of a sha1 hash of
the contents of a file configured via the nfs.conf server section
"fh_key_file".  Exports that have the option "sign_fh" set will cause the
server to use this key to append an 8-byte siphash of the filehandle onto
each filehandle.

This version of the userspace patches correspond with the v5 of the kernel
changes which have been posted here:
https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com

This work is based on a branch that includes Jeff Layton's patch for
min-threads:
https://lore.kernel.org/linux-nfs/20260112-minthreads-v1-1-30c5f4113720@kernel.org/

.. and Jeff Layton's v2 series to fix up userspace handling of kernels that
may not support the most recent netlink attributes:
https://lore.kernel.org/linux-nfs/20260204-minthreads-v2-0-a7eba34201e9@kernel.org/

.. and my patch to automatically load required modules:
https://lore.kernel.org/linux-nfs/09076517d782c31cc0a654563b42b78c846c5f38.1770236512.git.bcodding@hammerspace.com

Comments and critique welcomed.

Changes on v5:
	- add -k,--fh-key_file= argument to "nfsdctl threads" command (Jeff Layton)
	- fail if "nfsdctl threads -k" unsuported by kernel (Jeff Layton)

Benjamin Coddington (2):
  exportfs: Add support for export option sign_fh
  nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key

 nfs.conf                     |  1 +
 support/include/nfs/export.h |  2 +-
 support/include/nfslib.h     |  2 +
 support/nfs/Makefile.am      |  4 +-
 support/nfs/exports.c        |  4 ++
 support/nfs/fh_key_file.c    | 79 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/exportfs/exportfs.c    |  2 +
 utils/exportfs/exports.man   |  9 ++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.8      |  8 +++-
 utils/nfsdctl/nfsdctl.c      | 57 +++++++++++++++++++++++---
 13 files changed, 161 insertions(+), 10 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c


base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
prerequisite-patch-id: b0d57152c98d360daa9a71e6fa9759b7eb9de348
prerequisite-patch-id: 99680869954aef9f878c24ec9ee1302ab7f24b1a
prerequisite-patch-id: 2ab31271461352d11bcce760e45573f9e6459553
prerequisite-patch-id: 22c392c9dba2e63916af6cd8fbf4e9d6bce9d01c
prerequisite-patch-id: 50f6f48932426f89060eb77de58718baa80b979f
-- 
2.50.1


