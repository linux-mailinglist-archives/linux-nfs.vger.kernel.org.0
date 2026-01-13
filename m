Return-Path: <linux-nfs+bounces-17814-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE2D1AE9E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83123072B3C
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59047342502;
	Tue, 13 Jan 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Zkd1i7NM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021090.outbound.protection.outlook.com [52.101.62.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4B30DEAC;
	Tue, 13 Jan 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330407; cv=fail; b=KkotoZb2rlcC+NaH60AyHVIBB72xgv2Dn3JXROWO9h8UOlX+FwxNL2UcyPhzgdS+U22KRuc+/saLZcBLXHnVUedAb7MdjPdV4cw3kqyTkx1field8JDyw6taRrv6Hb9SYZoJowuAOYHWMnrqmKywV93PE5wgJVuE5v9lvonPSto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330407; c=relaxed/simple;
	bh=tTzVNpUHqGZY+z3ANipp6FlvezJzdHQtgQFrwOMzSo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVB8HCcm1ZvxiUea9b43bkFOS7AlJnP+y4Zu2l6U3PidNNQ17o7zGrjbknSQ+QWTUp0zxkG84L3v/BEUTXjeR6YqFA3MSJUUpQOeqa5Ewgh1IpQc3yVErRO3rmFITuEck+xNJXpWZT77mUuwt0LIwABO9eoNe21ZVscP7ANo+IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Zkd1i7NM; arc=fail smtp.client-ip=52.101.62.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBdyvL+qLSTmqvn+6HgMMGlzvtf9o3vchibe3ag/vRYJzxUPqDl2XAcxKKKtq56uPFXPNaMNJbxLynMHDUReprmAqIWR4x7iZYWhslnAl+9QqLDGmBsQYXLXhTBljFOW1Mc0q3sY+8K9/LeYEPzZ730V8M50ueIncBmNwpcJyZ2uy48NDCzymJkIh3oxhekXPViRmoyNB6NEmSz/tp+IFLG69HkkVA6tSNLy6+GVQKyywUuP0bq6BlvaPVYZlz7GAV5SZvA4ObhtnXQjO7YsE2AmI2LWMS5YJl89O7A3RUGKaNv5v8sJ2UdEmhVVecVfoSmZZgufmDKeVFvx4H6dHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGmce7fDR3b/WxGCoj1CGusr02vc4FPTsTLqhl3Ha0U=;
 b=d+CdEIkro9f0yXrZYeYJycUtuApREsscrRs9D06XHKqHHNcnUtACYc1H1DsYq/EBtbRHaymJhtsHl51wJIAb5rCFLFLUZKTe6uB9ARtEVPHeeu7YQUHuU7VxzXVsO88YtPipQEUG3/u5a1k53h1h8aZoBxXDPG6tNIarMTuB9YSVc29/xN//9KWW5TORbrDjSDFHNfjgyDEnLc0sINbBHpG4BgsDk84hRldDCdjyiAlDpK62CI7jwfXDvyahcBZzVOyv5K+NrOjndhYpHFdGdNyuvFiidnxvB+UkY0AfMV4GUtYlIrKAJOqa0gORrKYpXXV8w0Rg88yLqyIGOFAlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGmce7fDR3b/WxGCoj1CGusr02vc4FPTsTLqhl3Ha0U=;
 b=Zkd1i7NM/E2EgebAl07gAsMtIeuO2266sh+Augs5SNDsi5A4q2mUIu625LVeUeWoWRJ2P+6pftUfj774aihgWfClzSrQP9fl7F4h99svHWsq3Wxq3a1iwqZ0cnF3PfDQz7oDmDjPvz364F6y/B37AP20pX26WGITTebmC2bmt5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 MN0PR13MB6764.namprd13.prod.outlook.com (2603:10b6:208:4a5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Tue, 13 Jan 2026 18:53:22 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 18:53:22 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd/sunrpc: fix up some layering violations
Date: Tue, 13 Jan 2026 13:53:18 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <D867076E-FF23-47C5-87BD-5DE805DF4ED1@hammerspace.com>
In-Reply-To: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
References: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::7) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|MN0PR13MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0190f0-3dc5-429a-475e-08de52d5063a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLKQeFsfPG3T5LxWEQzf7+p3myKGmJRHNPt4O6cGjseJa9/LOWbCfrJOFotJ?=
 =?us-ascii?Q?guOxzpLn2V75OoIzrpWt7taNoACkinU3A44xv2wZPArvq65Pr0H5wweyZN4b?=
 =?us-ascii?Q?agGJjOIXTQrEhgU4XHsYIQ3aLmw00IthDdHnlANnRi/bwEbZwFPwXd7iMgTU?=
 =?us-ascii?Q?JbkXtXdqE44c1tvnpKBdQmARlZAJtfybUnftFGwFWtmB7O9d0LBKfUr/PcYA?=
 =?us-ascii?Q?HspWjuBs5ZcX5OwEEDqiwpFyhvp0qJKkoLHErBoxzL48qgT9kPYQHPdB9szK?=
 =?us-ascii?Q?wXRcHKEqA2d1w8q5slaIEfdZqC5CxPPS8pRFXU1s4QdaZsyXWI6W0FfmxBaA?=
 =?us-ascii?Q?/S0zc3t0HmLRHZ7VfFHGPnS+8ZRb1x8OSA95yvJYPrVThkSADae925mMNtVL?=
 =?us-ascii?Q?IRwwu6Ws7vIt4g+PjQWquctx7pVNQEhnc2CrwAJy6FE1LtMV/z67gGssGU6m?=
 =?us-ascii?Q?6k8zgi5lgvFeWqoMySvDdQt1QlFJThGalhHXJNrEwcLEuivRrxDfEGv+imnS?=
 =?us-ascii?Q?tLnfR8P0dbcCheJpzOcOYWrhLC7lpkpNNc3Z27jwzcTOGJ8TW/SX0tOquzSp?=
 =?us-ascii?Q?kthLAAQiqK3s+Avu9OfdnVr2CkpBE4JE8sKwSQtpcCXWlwfUlACbEzJ3HUAu?=
 =?us-ascii?Q?EjKWgoDoZme56DqDJml+EM18+cPGLhWHGGjEbmV43Io5T+LbfElGtfeDUwqM?=
 =?us-ascii?Q?TmiBpKP8EoOWaiWggf9lH0/X92fLVIdTvMVYqnb/JdIkQhCEE/1BPozYLKpV?=
 =?us-ascii?Q?Tkpxo8bMP0Mv+/D4Yn6DVQJadzJsZ/N4/pUvdlaejA9bxviTRLrUPEIFGQHU?=
 =?us-ascii?Q?Dbsu0N2g+eQexV4vHZFmgRWeMB5sJt+2BC8nC8C8P6GvwiUX+9g90mxBCOJQ?=
 =?us-ascii?Q?lVt/eKdMf18UQmcH9J1qnonVNm/t4KuDTCl8MVGSwnDUqtwFlFFlIVAJucyl?=
 =?us-ascii?Q?vYih04K47NsLRgkYdw5t4Rt4/bmRGMROjrCOf9wjqePuywlqxy8UTUGENiCe?=
 =?us-ascii?Q?wsBKax3Lw50EgwyB+JHVD/sTc85R54V4+lK0/UVd1FsuG4dhBPphnewBX+yx?=
 =?us-ascii?Q?5wMfbiTJ0vA/kqXUDoqz6CE/ng1ZmZyFrzdE+UFEASZldO48oR6e3B/Ks8XC?=
 =?us-ascii?Q?6tg3XuVFBS5WQrilRuG6cG97dzaO0p70A6DRxOR6+CUfMk8vxFs9oPIY91CH?=
 =?us-ascii?Q?TcfODRwpTjVv2abkqq7tpKhAWkmGX83OOFX/IWxYDEqKDodGJd/AYqRLQASA?=
 =?us-ascii?Q?kqAcZp1/6mRANhTgG1EbKbjxbVbTFWNTQDDragiKxdl5ncaA5vU4fnop0KAR?=
 =?us-ascii?Q?rsrLlpmg803RscWkFJKXfibOnQV7+NHphZtlGRwN5HWeh3fxmx3S7xHB9PQr?=
 =?us-ascii?Q?deZ4kLQfJhu8CkPAUvonghRT8iAkBJ3ej+w0cLr7uJn1GQP89OKYgqmcHTYT?=
 =?us-ascii?Q?ZCFCuChjaIBFpIZSzCqmAHHF4aDhxg9x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kkPyUhxYv8fPgB0cKqqpS6AMpjIspVtRnXDjrpNF72ZW1G9MzgvEt9OFjzm3?=
 =?us-ascii?Q?eWF1mvgQ5Nlyx4rq1qtBAo1pW0vfElKbeSCCWuWeegGQVAg8tfu5d3F1rOz0?=
 =?us-ascii?Q?rA1KBouNhYfgo4B45GsFtgRYeonODYZGkHYM/bIt8Y0clUGcTBpLr2j6XewT?=
 =?us-ascii?Q?xWeUoii9Nr3D18fH3ZteA55oGMv7lm0V74mdCzX6HT4O7b7vOSWOVED/2FxO?=
 =?us-ascii?Q?aCwOlLxLndLb5F8Tm7X33ZXsyH8lzGjwLKDwd0RvSx2s487jNkokC2NMs623?=
 =?us-ascii?Q?79fQmqP9TuAVeWTIo537wdEwsrfH799OsUFTD3oZ/8yY46de+eq4aZbqyA3Z?=
 =?us-ascii?Q?Qq7IKfV8MUl7T4jDL4RG+OLXP2KDABjiNzO7DOE63Pf8qQyuOvuo+qo6ZRid?=
 =?us-ascii?Q?a5g/G9bYwPcSMI/GMyOZ7DdsW5FjK7oajNEsfWytu4qKVrCnCBjsEUemN4jZ?=
 =?us-ascii?Q?DIVKvp7X3pkWQACwsEIREESAbcB+mdPSzaVdtdqY4KJtY79xFJBI0rPtTcWp?=
 =?us-ascii?Q?Xx17RK57/SLTFFJ+pG1U8odjP0i+WmCU53v/EgMmXk0EHr/VjbiGUZjsLT/c?=
 =?us-ascii?Q?RpVdkiYB12ETBrM+/qbFTCILuMZ8op82wCQWL4b3nexf0uId947KR1ALZcap?=
 =?us-ascii?Q?eVSpn4lahN1Drc6t/xBtTKzVgbCGgaBtBciECUwDeel79G2UUvcH4ksPZuZ+?=
 =?us-ascii?Q?dDl2SXuFBACMiYZtAHieB6Mc4EeSFzoXAs81QhOb2Egfo8TU5/p7/MwlnvU9?=
 =?us-ascii?Q?OR0b7+4qSmbLKqeJ+OZ9nSAXuWRfgC3BKEKSG0djFpwaelA8jO9HXLbC6HMG?=
 =?us-ascii?Q?kYCh3twrgIl9SfALgWAWlwZtp5HJgRhQ4RYFA+wYRsQdaNwjWR5AFNQiIu7E?=
 =?us-ascii?Q?gehfKd95hk89kHiHCXY1KMfUOFYFda3DDqh7Ta/m9b+LxTd/FQK6eG76g0vJ?=
 =?us-ascii?Q?t7nL7kQ0fRaVooYKzWsCIRsgtWq5CCU/rC/gnYTYxI+ovOFdrv7oUw5kK6j3?=
 =?us-ascii?Q?O4xks1Fe4M1jIxlErMoSXwjgqdHb4tfObmUyW0h1Yf02d1bJ0Umbn4eUFv5u?=
 =?us-ascii?Q?NGuTOJizVEuBGhUbIS+woKbTvYA0DVyTCe/Ln0KFpPZtVdL5nKYy/8m4CzXd?=
 =?us-ascii?Q?v4lWrK4b7re0rF5iVv8CO2kBIrv74Zf/c8XekotAcqryIPS6AUzNBiphEo74?=
 =?us-ascii?Q?cuZHfq4mbLmUm9crpbeuta+8kbaPQU1pF4WsM4tw/GX1XPnYGUclkOVgtKGk?=
 =?us-ascii?Q?zkcSl1vRhOm08zMlyafLUhhbG0hhwdKJGRlV0x3lWN4pLmN1GuJ0Nr5C9syq?=
 =?us-ascii?Q?r410TGcpSQtUgkFIO3U7W57vXQCZheMnYAWQRWGV1F6ZsJo89l2xFRpluT3U?=
 =?us-ascii?Q?UHrqIVEusXj0A0w6ss8KRzfouRCiQy5EkuPRuTGUNlgYGNZJhC8RUK2L2R6H?=
 =?us-ascii?Q?qHnZM6R+rqTxUnA8X2+QE1+A5ZulLObmE829zyMRl9kK5dLwsMCyUVaIH2EW?=
 =?us-ascii?Q?zWGPlTHYWJ78V+b2eFdk974Q7fijkLLZh2rkw79jfJQAFx5V/ik7YFOEa/xL?=
 =?us-ascii?Q?II5BL/t93YkVmLczPshh759DiXcNHH5g4w+3YwmCwKbQIQw6PPNWHOUJBwIO?=
 =?us-ascii?Q?uZYnepVkQwt9yBvAykoFOkADnudNIT2wHbPSji48REeaWly9L8z+UvI4Mu7w?=
 =?us-ascii?Q?JiTgZudQlHddTFfw7WZxkDLt15Ws7tZ4k6+hsAq5zdcS4O7qZzRslMMbemAw?=
 =?us-ascii?Q?zZfohgdG9IW3RSw06Y4GA3N/J9MpLL4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0190f0-3dc5-429a-475e-08de52d5063a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:53:22.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT9wePoDHBp34v8nGNYvAbKiddEY9ArIChViKH86fXlxjb9qesxQkU2m+0nL1Ki+xLa2O6qa9DBr1hiX79hFY4iqK8ZHlXllKT+TWRMqSHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6764

On 13 Jan 2026, at 13:37, Jeff Layton wrote:

> The rq_lease_breaker and rq_cachetype fields are only used by nfsd.
> These patches shrink struct svc_rqst slightly and makes the layering
> between the two a little cleaner. In the case of rq_lease_breaker, I
> think this also gives us a little more type safety.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (2):
>       nfsd/sunrpc: add svc_rqst->rq_private pointer and remove rq_lease_breaker
>       nfsd/sunrpc: move rq_cachetype into struct nfsd_thread_local_info
>
>  fs/nfsd/nfs4proc.c         | 3 ++-
>  fs/nfsd/nfs4state.c        | 9 ++++++---
>  fs/nfsd/nfs4xdr.c          | 3 ++-
>  fs/nfsd/nfscache.c         | 3 ++-
>  fs/nfsd/nfsd.h             | 5 +++++
>  fs/nfsd/nfssvc.c           | 8 ++++++--
>  include/linux/sunrpc/svc.h | 6 ++++--
>  7 files changed, 27 insertions(+), 10 deletions(-)
> ---
> base-commit: e42954bff52b9538de21267c1bde2567b13b6632
> change-id: 20260113-rq_private-05f22aac0c20
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

Both look good to me:

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

