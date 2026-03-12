Return-Path: <linux-nfs+bounces-20071-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGtaHQLrsmnAQwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20071-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 17:34:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDF275AA8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 17:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A57E4305CC07
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 16:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A053F8DE6;
	Thu, 12 Mar 2026 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="g3+apTN/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021137.outbound.protection.outlook.com [40.107.208.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CF3F8816
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332961; cv=fail; b=U8Q9p7OTKbXUKm1wUtGROGYxhV5xqRAArKyeK+yLbfzobp2f5cYEqZHKwKLZist9zBJutKsiQh78nhV4GG0C7EFFXzVpsdnmcfRIqy796wz78dq69FinxCsOxcJy4FaaMed0soqBZ6vV8G1qPuxvjoJu0JmXhHlLiu3qXPL1ZUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332961; c=relaxed/simple;
	bh=ll/0L6wffIQ2wVarHv7bN2NxVqSvnnIv/ykMcKX76Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxyMG5OndnCt0HFUN3aonUpHtdLBFl3gwp4OkijOmgYy6X0lct6enWjNWQJs7Oi7PeREJ7I2SDJUFRuwmi7VqJ4e+wnMnj1uG96XqwgVfGTHfW4cBrEo9Jm672uAeXC/LReucg/xvB9PqCeVvcKvQoZ3WI+Qj258vLcxPziGZrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=g3+apTN/; arc=fail smtp.client-ip=40.107.208.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su2EfdVobLVIq220jF9FD9954ZNi0ufHuWK55Sy1iDY6Rb83kDZCK7XqN80zX9DbBxEg943ZKUTXCQ6hWiOvFuWm3xWgGA+iABfOAHHxB15CSdWzxS7WVTU8wnIFoaFoBj5OtRRCFvzzfb4qxOKZsKMCnRv2yr3bsvBXKrA8HCbehwwGmji65ae9BmFCYA4SIY7hnvZvS46tmgvJGuOPcsTZa9HNYQ4mNEfAZn/BLgx/9yvuFeZU7716Z41FciJk/o457HQ5GP8fznZkzBAyZ9BmOYpAsaxVnz0j2x+iu2D/Kl6QO57ZoUKFQyiVN9iIAmXj9meMf2ftXBkSeKQ1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iqg5mkmK6GP1OVTB6TwuMO9o1gR1Og2dfAIWK1bd7o=;
 b=M9zZ/XafZn4BefhElkgQfEbzOOYqGYA5dA84gBVOlweB8yw3yKGgPRnsjaCGv2GsOjplaWOU9ilEAE/xtD+JjFcq1atH/yvnMEn4ybdCUMIg9PdIkcOfDsAsgpZawlYiW2+tRwhVDtgxHFNo8esRZ5lqLWSRApgeyHb/P+P50XUHDK1XtguB1uO1cHZADKXXgbyY2VBY/M8nxOShY0UWT+HAF/YXLqqtDi7x5Ob3PfKKoJiX4OpfBh0xypKRppiKlMY+qzqgGkAiZSrK+j54A3MsOftvo5TTGilToLe+qt1rgx9FwC86+e6OXS0WWt4TXjYPCLpyOuC/JRkTFbVLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iqg5mkmK6GP1OVTB6TwuMO9o1gR1Og2dfAIWK1bd7o=;
 b=g3+apTN/h3E7stipcAZWoETH1CEYfwsNT/Wkq+812p0AMBD3J4yGhbGIz6SmkV7zUflXeS6UhudipltJqVR0ww6v+rJUUJ9QCv/a70qduBARaxAn4TXymC/hady4p8eZVjLO2dNx/U0dH6qKu6u6w8wVKNQuknjfY+FsxQoedBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 IA1PR13MB7496.namprd13.prod.outlook.com (2603:10b6:208:5b3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:29:10 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 16:29:10 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: bsdhenrymartin@gmail.com, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH] sunrpc: refactor TLS transport to remove rpc_clnt
 dependency
Date: Thu, 12 Mar 2026 12:29:06 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <93C11692-7008-4239-B68C-227C9F21C55C@hammerspace.com>
In-Reply-To: <25094279-518a-4477-bfdb-772a48c744b5@app.fastmail.com>
References: <a57879782d2d383e2d1af292fe2b9005a43ea06c.1773263233.git.bcodding@hammerspace.com>
 <25094279-518a-4477-bfdb-772a48c744b5@app.fastmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|IA1PR13MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a436fa3-fe14-4698-9548-08de80547d88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|22082099003|56012099003|18002099003|7142099003;
X-Microsoft-Antispam-Message-Info:
	yFxTmTXCyW/LtsgC+yLRHHsCsU+25DIeirKEY2C9bdRvGyJMshv6DAYZsRkRFdVFaJshwFSl1eSXDZBxqynFzyB2/iGsWAkp6ZgZVXNuM4XzDPq28wFicgBLkumyEdcvhOiP4t9O/x0iih39WV45gl2AqeOa+g750zqAdPK4YGms/F4t6vkT7bZjZf1HnzDNLnrG6PYmmT7+W5xTqgMYyIT6qQwSA45mQYpA4WgMHVL2vNBuDNebdA7buqghMHwSFb2XmFznm9CYoZbhQEpYsrFu5FsNqsGgJjtW7wweJ8WkniCB50L/x+PyvqSoIsVc2WOTaUFMEAyBZ9fgLcmEtDb32AI4YLrq8FVeBh3s1colqWMHJBidJgfseribvvD8zagEqA3LkYoYBZ1DVOA+vqPdK49+rja2E1rAba9ykByzHvOS0X3G5WFiJWLbXWvvxzLUWxMtcAZYqoyUiIJLElzMsmMZeqUUK7U2T/eQPV0RpbFHW0HaFcBD/uHduemhc9u4jSBHG1qK2bOciBDhzCwr526rEpHEuMy8jS6PRVz0cBYUOeUiEBfIn/EitxDNCcMIrEHmKNaA35alQYTsIw9EUMyJDAGKMWGNEsh+PW4+fA2GCjOfHRmTOn8MyVGeAx2SFAf5fV9294aezARDmkyJ2iZWvxaJRZLrqtst75UoTPPd8FngtwS5C214mNWPuop8vVfflmqVAjUH6FcptR7Vvtq8ksqO1n8zqSeVahDArUOG/WTEFapUE7u2zlZM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(22082099003)(56012099003)(18002099003)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uXMeIkXGXxc75nPkwnr8twRZQeGwVgOuP9MMENqydLa6f7zfM6wx0/ew4n5?=
 =?us-ascii?Q?0+d8fos5Yc0Yz1+F/rDcpfwhNHsU4U/zSFNyW82rvDH0rtK8MjcA1fs8W31M?=
 =?us-ascii?Q?Q+aLEhbmU3lyR/DTp1CsHVh3ib1QWmcmniEgQG80/d9iQ/wykXz7BhV+zNxa?=
 =?us-ascii?Q?Og87nxlIoly3d5QHX39wA3dO+6bogCB+L1fiLoTakq8mGsTs6xAjyxY9JLWs?=
 =?us-ascii?Q?C1F+82B1gwhmE7mv0YSj2fguW7Fs/Nhd5V6Mjg64JT3LQ0Df1+FJcHq9XttC?=
 =?us-ascii?Q?SFmNP3cYy+6q8D80h+neHVEnBd5Kfq86VLfIPmwhPMNqgE+7p4Sgn+0+BXKP?=
 =?us-ascii?Q?MsBuMeNdUXH3/1ZJJ1hOwQAXXMp9kRDMG8RSOrxFX4JuPS7ueryNkFlpiVLj?=
 =?us-ascii?Q?R34d51BG3ayh9F9yACMaQLkM0zu/Agryd/A4kK4OOmArs598YEOn0VXN6sXY?=
 =?us-ascii?Q?/F3eyrJXZ5ZOGx3yM2Fc9GZ+G+XJ08TQ3ERUW3sUptLLZCxfKJmskj67pxEW?=
 =?us-ascii?Q?KbIjSn5dE9Lv0i0rDqOT7RAE9GLWfbCS9DXS3nZPUCO0nTvrNADtMiEvSDBd?=
 =?us-ascii?Q?U7fu9XUNHX9F+KIKs1/nXcecbIaPyYqh2QcnCaHaBtqpEU9g9ZLS0ICit3xL?=
 =?us-ascii?Q?EYeNwSi22x++RUehcDgLMZJtQHKSGEPdkBUFbNUsWYn7z8kU3ptwoHmOK2cJ?=
 =?us-ascii?Q?4pycXpbNzwiT4Nkg1YwX8FpkoWWqv6lwwFUvxzkKvmM9CFkWuvdhzaaIGNmz?=
 =?us-ascii?Q?7uptbfsJ3IMlqhfNQzhljWcQRZlTQMQ5gW0vQ+5QDthBGIKGiuvh3wnMTMwT?=
 =?us-ascii?Q?RbIPw0tL4UQw8BKgX+fZhsGbKyb2prZBzTEtva09R+94jL993tDO2wKOtUvr?=
 =?us-ascii?Q?+la97ImNrDl6yKZJbnJ3cGstl9ho9CWaN5wloX38XvTzFF7Qnpx1ikClgCX6?=
 =?us-ascii?Q?JsOJhXnnaF+Fq4LyhXjfSkiHWWCQaFeg2mAGinbSbfg+rDGHCeWCnifZGAm9?=
 =?us-ascii?Q?psldDbeF8Dic6VGJrKyqqS+DhrzRm2RQLwUwlKN+iIkIcyH7EUAJU0GrZKIE?=
 =?us-ascii?Q?RYt7k8T8SM1j8/3LRWbFH1OBYAFHYOERx5ZYKHaDD8dRdhK/XR9EAGtmrk1x?=
 =?us-ascii?Q?sHP01ECPAsLVt0xQ0djk2Y4OCbDHzbllT+fy8Yt9TVqCBiAioR2uYQ67j91O?=
 =?us-ascii?Q?NLXhIlJvgElw4MoTyns44ZVAq1v61E5DTKtlFQ5AJRAzDjm1gJ4h/VfH2uO2?=
 =?us-ascii?Q?ldtZQIaFYFRbqppGSZjAgUSfC52vOasm4BRvD5z+XdyubghzSeUaw1haUXPH?=
 =?us-ascii?Q?ZTV09U9N8KBxPvij/lDY3I9Rph48IKMDtT/CX1CqcVKuw2wNBVG1aUPqEZS2?=
 =?us-ascii?Q?45kK5V6kqCxKNaZnNgbrYIrj93fliTpxgxIPqw7nTxb0ro59g0rzlpAtf3qZ?=
 =?us-ascii?Q?ONfzFD2jiXlI9dneiI2vi+Lksf4luXbcARWSRk61asVkrCp+nbKbYE8Rb95X?=
 =?us-ascii?Q?2LpwqOVZmKFEwvmSz6gJYTsx+afO0LzY6B4luwRpI8VeXDCYMYUBGGQZO7iT?=
 =?us-ascii?Q?HQR2FnFrlhjnzBA2vPWVzQI7Fs/09HH13ybns+ZYLFiHXRQhQT/HFM+g2QC0?=
 =?us-ascii?Q?QkHTzPp6mD1wPsb26E98ome2Hn+iNHN9BlZ3DnOxPOn0STPqt/qq8gQHIlMQ?=
 =?us-ascii?Q?eQa9f6u3m4CuaAS21BjIdaZw6ZtoJcFeQALbM0mDl9e1TTOOwPCJEiJt4zL/?=
 =?us-ascii?Q?XChoD0C6NWeado5PhUww2iW+A7C//a4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a436fa3-fe14-4698-9548-08de80547d88
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:29:10.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apEnwjHAwgNVj6C7YQ+lZlpaq7IbwvRpm8wwLU1HlwXcWIWR0hRDCJKnEhMappuC+abLElHcC38JNcPENJKxyGgrt3v1Vt77G228J6qKlFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR13MB7496
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20071-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C8BDF275AA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12 Mar 2026, at 11:10, Chuck Lever wrote:

> On Wed, Mar 11, 2026, at 5:23 PM, Benjamin Coddington wrote:
>> The TLS connection worker (xs_tcp_tls_setup_socket) currently
>> requires a reference to the upper-layer rpc_clnt to populate arguments=

>> for rpc_create() when setting up the lower-layer transport for the
>> RPC_AUTH_TLS probe. This dependency led to lifetime issues and a
>> use-after-free (UAF) of the client's credentials if the task finished
>> before the worker ran addressed previously in linux-nfs upstream
>> posting:
>> https://lore.kernel.org/linux-nfs/20260309112041.1336519-1-bsdhenrymar=
tin@gmail.com/
>>
>> However, it is architecturally cleaner to decouple the transport
>> connection logic from the RPC client entirely.
>
> It's probably worth expanding (briefly) on the architectural
> cleanliness argument a bit. Why not simply bump the reference
> count on the rpc_clnt to prevent the UAF? There is definitely
> a bit of abuse in the current code that is removed by your
> refactor.
>
>
>> The TLS probe requires
>> the upper-layer's RPC program and version to facilitate the probe.
>>
>> Refactor the TLS transport setup to:
>> - Remove the clnt member from struct sock_xprt.
>> - Save the RPC program number and version from the task
>>   during xs_connect() into the sock_xprt structure.
>> - Update xs_tcp_tls_setup_socket to use these saved parameters for
>>   lower-layer client creation in dummy program definitiions.
>
> ^definitiions^definitions
>
>
>> - Update TLS-related tracepoints to remove the rpc_clnt dependency.
>> - Remove the rpc_clnt refcounting and assignment in xs_connect.
>>
>> This simplifies state management and eliminates the risk of UAF withou=
t
>> requiring the transport to pin the upper-layer client.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>
> More below.
>
>
>> ---
>>
>> I'm not sure I like what came out here.  It adds a lot of boilerplate,=
 and
>> it reduces the tracepoint data (pretty necessary due to the race, howe=
ver).
>>
>> Most of the fix is from just not setting cl_cred - it stays NULL.  Pro=
bably
>> the other values we get from the upper rpc_clnt are still hanging arou=
nd.
>
> Can the patch description provide a rationale for why using a
> NULL cred is safe?
>
>
>> We could reduce the dummy definition boilerplate by passing the rpc_pr=
ogram
>> pointer, but then there's a potential null-dref if the calling module =
gets
>> unloaded.
>>
>> Can RCU the upper rpc_clnt?  Any other ideas?
>>
>> This is lightly tested by hand..
>>
>> Ben
>>
>> ---
>>
>>  include/linux/sunrpc/xprtsock.h |  3 +-
>>  include/trace/events/sunrpc.h   | 16 +++------
>>  net/sunrpc/xprtsock.c           | 59 +++++++++++++++++++++++++++-----=
-
>>  3 files changed, 55 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xp=
rtsock.h
>> index 700a1e6c047c..7cafc3057bfa 100644
>> --- a/include/linux/sunrpc/xprtsock.h
>> +++ b/include/linux/sunrpc/xprtsock.h
>> @@ -61,7 +61,8 @@ struct sock_xprt {
>>  	struct sockaddr_storage	srcaddr;
>>  	unsigned short		srcport;
>>  	int			xprt_err;
>> -	struct rpc_clnt		*clnt;
>> +	u32			connect_prog;
>> +	u32			connect_vers;
>>
>>  	/*
>>  	 * UDP socket buffer size parameters
>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunr=
pc.h
>> index 750ecce56930..8088a8ad83d4 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -1528,28 +1528,23 @@ TRACE_EVENT(rpcb_unregister,
>>
>>  DECLARE_EVENT_CLASS(rpc_tls_class,
>>  	TP_PROTO(
>> -		const struct rpc_clnt *clnt,
>>  		const struct rpc_xprt *xprt
>>  	),
>>
>> -	TP_ARGS(clnt, xprt),
>> +	TP_ARGS(xprt),
>>
>>  	TP_STRUCT__entry(
>>  		__field(unsigned long, requested_policy)
>> -		__field(u32, version)
>>  		__string(servername, xprt->servername)
>> -		__string(progname, clnt->cl_program->name)
>>  	),
>>
>>  	TP_fast_assign(
>> -		__entry->requested_policy =3D clnt->cl_xprtsec.policy;
>> -		__entry->version =3D clnt->cl_vers;
>> +		__entry->requested_policy =3D xprt->xprtsec.policy;
>>  		__assign_str(servername);
>> -		__assign_str(progname);
>>  	),
>>
>> -	TP_printk("server=3D%s %sv%u requested_policy=3D%s",
>> -		__get_str(servername), __get_str(progname), __entry->version,
>> +	TP_printk("server=3D%s requested_policy=3D%s",
>> +		__get_str(servername),
>>  		rpc_show_xprtsec_policy(__entry->requested_policy)
>>  	)
>>  );
>> @@ -1557,10 +1552,9 @@ DECLARE_EVENT_CLASS(rpc_tls_class,
>>  #define DEFINE_RPC_TLS_EVENT(name) \
>>  	DEFINE_EVENT(rpc_tls_class, rpc_tls_##name, \
>>  			TP_PROTO( \
>> -				const struct rpc_clnt *clnt, \
>>  				const struct rpc_xprt *xprt \
>>  			), \
>> -			TP_ARGS(clnt, xprt))
>> +			TP_ARGS(xprt))
>>
>>  DEFINE_RPC_TLS_EVENT(unavailable);
>>  DEFINE_RPC_TLS_EVENT(not_started);
>
> The requested_policy field that is retained is irrelevant to
> the RPC_AUTH_TLS probe (though it matters later during
> xs_tls_handshake_sync). But the program number and version that
> /are/ dropped are what actually go on the wire in the AUTH_TLS
> NULL call, so if the probe fails, the administrator wants to
> know which program/version pair was rejected, not whether the
> handshake that never happened would have been tls or mtls.
>
> Note that this information is recoverable via container_of(xprt,
> struct sock_xprt, xprt)->connect_prog/connect_vers without
> needing rpc_clnt.
>
>
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> index 2e1fe6013361..5f3103e9a8f2 100644
>> --- a/net/sunrpc/xprtsock.c
>> +++ b/net/sunrpc/xprtsock.c
>> @@ -61,6 +61,45 @@
>>  #include "socklib.h"
>>  #include "sunrpc.h"
>>
>> +/* Helper macro to define repetitive rpc_version structures */
>> +#define RPC_VERSION_DEFINE(prog, v_num)                 \
>> +static const struct rpc_version rpc_##prog##_version##v_num =3D { \
>> +    .number     =3D v_num,                                \
>> +    .nrprocs    =3D ARRAY_SIZE(rpc_##prog##_procs),       \
>> +    .procs      =3D rpc_##prog##_procs,                   \
>> +    .counts     =3D rpc_##prog##_counts,                  \
>> +}
>> +
>> +static struct rpc_stat rpc_tls_dummy_stats;
>> +
>> +static const struct rpc_procinfo rpc_tls_dummy_procs[] =3D {
>> +    [0] =3D {
>> +        .p_encode   =3D NULL,
>> +        .p_decode   =3D NULL,
>> +    },
>> +};
>> +
>> +static unsigned int
>> rpc_tls_dummy_counts[ARRAY_SIZE(rpc_tls_dummy_procs)];
>> +
>> +/* Generate the structures for versions 2, 3, and 4 */
>> +RPC_VERSION_DEFINE(tls_dummy, 2);
>> +RPC_VERSION_DEFINE(tls_dummy, 3);
>> +RPC_VERSION_DEFINE(tls_dummy, 4);
>> +
>> +static const struct rpc_version *rpc_tls_dummy_versions[5] =3D {
>> +    [2] =3D &rpc_tls_dummy_version2,
>> +    [3] =3D &rpc_tls_dummy_version3,
>> +    [4] =3D &rpc_tls_dummy_version4,
>> +};
>
> This is a layering violation.
>
> Today's Linux NFS client stack implements TLS only for the NFS
> protocol, which has support for only versions 2, 3, and 4. But
> what if we want to implement TLS for NLM (or any other RPC
> protocol) -- NLM has v1, v3, and v4.
>
> A simpler design: use a single dummy version at index 0 with
> args->version =3D 0 always, relying solely on args->prognumber
> for the wire program number. The TLS probe never consults
> cl_vers -- it uses a fixed proc via msg.rpc_proc.
>
> (Ultimately that is still a hack, but you get the idea).

Yep - I get it - that was the originally idea until I discovered there's
some sanity/cross-referencing code in rpc_new_client() that may need
modification because it wants to make sure that version matches the defin=
ed
program version as looked up in the program->version[] index.

I kinda which I could define a completely static rpc_clnt, make a mutable=

copy, set prognum and version and somehow get that plumbed throught the
rpc_create() machinery..  then throw it away..  </waves hands wildly>

>> +
>> +static const struct rpc_program rpc_tls_dummy_program =3D {
>> +    .name       =3D "tls_probe",
>> +    .number     =3D 0,
>> +    .nrvers     =3D ARRAY_SIZE(rpc_tls_dummy_versions),
>> +    .version    =3D rpc_tls_dummy_versions,
>> +    .stats      =3D &rpc_tls_dummy_stats,
>> +};
>> +
>
> Nit: All of the new static structures and the macro use 4-space
> indentation rather than tabs.  Other rpc_program definitions
> in the tree (rpcb_program in rpcb_clnt.c, gssp_program in
> gss_rpc_upcall.c) use tabs per the kernel coding style.
>
>
>>  static void xs_close(struct rpc_xprt *xprt);
>>  static void xs_reset_srcport(struct sock_xprt *transport);
>>  static void xs_set_srcport(struct sock_xprt *transport, struct socket=

>> *sock);
>> @@ -2687,24 +2726,21 @@ static void xs_tcp_tls_setup_socket(struct
>> work_struct *work)
>>  {
>>  	struct sock_xprt *upper_transport =3D
>>  		container_of(work, struct sock_xprt, connect_worker.work);
>> -	struct rpc_clnt *upper_clnt =3D upper_transport->clnt;
>>  	struct rpc_xprt *upper_xprt =3D &upper_transport->xprt;
>>  	struct rpc_create_args args =3D {
>>  		.net		=3D upper_xprt->xprt_net,
>>  		.protocol	=3D upper_xprt->prot,
>>  		.address	=3D (struct sockaddr *)&upper_xprt->addr,
>>  		.addrsize	=3D upper_xprt->addrlen,
>> -		.timeout	=3D upper_clnt->cl_timeout,
>> +		.timeout	=3D upper_xprt->timeout,
>
> The timeout source changed here from the upper-layer client's
> configured timeout to the transport's default timeout.  These
> can differ: upper_clnt->cl_timeout points to a copy of the
> NFS-configured timeout (set via nfs_init_timeout_values()), while
> upper_xprt->timeout points to xs_tcp_default_timeout.
>
> For default NFS TCP mounts, nfs_init_timeout_values() produces
> to_maxval =3D 180 * HZ and to_increment =3D 60 * HZ, whereas
> xs_tcp_default_timeout has to_maxval =3D 60 * HZ and
> to_increment =3D 0.
>
> Was this change intentional?  The commit message does not mention
> it, and it alters the retry behavior for the TLS probe on mounts
> with custom timeout settings.
>
>
>>  		.servername	=3D upper_xprt->servername,
>> -		.program	=3D upper_clnt->cl_program,
>> -		.prognumber	=3D upper_clnt->cl_prog,
>> -		.version	=3D upper_clnt->cl_vers,
>> +		.prognumber =3D upper_transport->connect_prog,
>
> Whitespace damage.
>
>
>> +		.version	=3D upper_transport->connect_vers,
>> +		.program	=3D &rpc_tls_dummy_program,
>>  		.authflavor	=3D RPC_AUTH_TLS,
>> -		.cred		=3D upper_clnt->cl_cred,
>>  		.xprtsec	=3D {
>>  			.policy		=3D RPC_XPRTSEC_NONE,
>>  		},
>> -		.stats		=3D upper_clnt->cl_stats,
>>  	};
>>  	unsigned int pflags =3D current->flags;
>>  	struct rpc_clnt *lower_clnt;
>> @@ -2719,7 +2755,7 @@ static void xs_tcp_tls_setup_socket(struct
>> work_struct *work)
>>  	/* This implicitly sends an RPC_AUTH_TLS probe */
>>  	lower_clnt =3D rpc_create(&args);
>>  	if (IS_ERR(lower_clnt)) {
>> -		trace_rpc_tls_unavailable(upper_clnt, upper_xprt);
>> +		trace_rpc_tls_unavailable(upper_xprt);
>>  		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
>>  		xprt_clear_connecting(upper_xprt);
>>  		xprt_wake_pending_tasks(upper_xprt, PTR_ERR(lower_clnt));
>> @@ -2739,7 +2775,7 @@ static void xs_tcp_tls_setup_socket(struct
>> work_struct *work)
>>
>>  	status =3D xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
>>  	if (status) {
>> -		trace_rpc_tls_not_started(upper_clnt, upper_xprt);
>> +		trace_rpc_tls_not_started(upper_xprt);
>>  		goto out_close;
>>  	}
>>
>> @@ -2757,7 +2793,6 @@ static void xs_tcp_tls_setup_socket(struct
>> work_struct *work)
>>
>>  out_unlock:
>>  	current_restore_flags(pflags, PF_MEMALLOC);
>> -	upper_transport->clnt =3D NULL;
>>  	xprt_unlock_connect(upper_xprt, upper_transport);
>>  	return;
>>
>> @@ -2805,7 +2840,9 @@ static void xs_connect(struct rpc_xprt *xprt,
>> struct rpc_task *task)
>>  	} else
>>  		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
>>
>> -	transport->clnt =3D task->tk_client;
>> +	transport->connect_prog =3D task->tk_client->cl_prog;
>> +	transport->connect_vers =3D task->tk_client->cl_vers;
>> +
>>  	queue_delayed_work(xprtiod_workqueue,
>>  			&transport->connect_worker,
>>  			delay);
>> -- =

>> 2.53.0
>
> The proposed refactoring seems like a sensible direction.
>
> The UAF potential is eliminated structurally, and some of the
> transport-to-client coupling (and layering violation) is removed.

Ok - thanks for looking at this and showing interest.  As you've noted th=
ere
are quite a few rough spots here due to me just tacking this together
quickly.  Sorry for the messiness.

I'll plan on iterating on your review points for a v2 - may be a couple d=
ays
to get back around to it.

Ben

