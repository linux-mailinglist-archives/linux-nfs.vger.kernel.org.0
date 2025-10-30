Return-Path: <linux-nfs+bounces-15797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF90C20E47
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2AA425778
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409732F77B;
	Thu, 30 Oct 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="BMYrFlv2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020139.outbound.protection.outlook.com [52.101.85.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37132E73F
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837782; cv=fail; b=tmXBmme4/hjlLqdL3ns6RoqeZhZRm5JDNxTy/kf/G3GOOIsAzrw6r9gpxjSxokZizwUTF7wze7NDbqUyHzF712kmRsEdPH9cKE1sWXqxSrsl/NtQai1gbQ50n4oEnreJYcnN9IhtDMibuUdiT4Mf/XT4VsAE2HZfqAmWK4fVHs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837782; c=relaxed/simple;
	bh=vvq1PlSjSLao4zcqFPGS4BVeygkPazNR/BctxKk58hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5xY8e1vxM7o2qwa6HlaJFeO0T5eL/j27oVO0cLAOKOee3S8nmVEVg8R36CxylCF6tXCaaxjDQnJdoOpiYdgH7BCfFZYkKN+RM4K3NM3qIrFd4/dTvgpZ3OBVehkcG9dnP7cTrA5cdh56oRmfy7k6b+2JwNdbjdCM3YhwVQX8+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=BMYrFlv2; arc=fail smtp.client-ip=52.101.85.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XG/wcB4PG8kX4SOjgn6YuksGKS9gyrUnQPB3uT4oiXAg/kfzMTqgKHcWXAzjM6Cs2uqR3GGXf6b/cLWbhEjenYqQaUoMUXIGeelrjIqWWJfM/5NVSEgmKRGFaG8FLUWscaF7cRZmF9cTNXosu5UGIsWrUAu3B3zsYFUsPnendlv9yQRQlqJIhOSbQh9T1x7pE3tBVtqm+lZoYQGKcRNyHjmsBubQwhG5FIkK29xdQ/9NvUCw7L2zcbDXEJPJuHXSw5jRNpg8N2rauWz176h9/8CnMaBSDWLAc2YjMYj9xuNqkfLcS5V5yoiIjKeCCxAit0gAPpg1Y73lEdpXR9ghKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTFb2bAZeIiFnq+rl6XZ/UrEL2hCwbK5vl+LCPJT1ck=;
 b=jL2hWwBW8COtpEYcvgAXSUKTbYrGwuO+QvwqkAFM00+mV/EOpkmOpUCShVjmy/hNOhZoShzZ5DA1lm3Q8F9n9Y7nRF7mS8EIEzCANsE/zn7DPdQLEjPV6Zw0CG4FJKAa+nxnyivdZXnUJEAhXUdDr2YmWKYpQouHa8oZDRITC2kW5yuO+3Q0NOay1ewcLpqcR+r5riwXCMXFxjFdTcQKDnj3k/Uuh7cwf2vUZInW/wbzkEaT0K8aufuaZPz+4vGr0SZAWUtNo97eFlEb9ySd5gkP9eaeBeWbKG2+XaIz8VkgKf4O9Mk3Bk565wrAPFU/btqSwtGPIAVqZNwwuCHIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTFb2bAZeIiFnq+rl6XZ/UrEL2hCwbK5vl+LCPJT1ck=;
 b=BMYrFlv2y9xe5ou3EXDARUkdCG824MIi3d/Fmju4MebQ9rHrAaTTWUReur0raAecYUzL3DNV8stjVUq6kaJQAyjUaEj4TvxYi7+M7GwK6eS24w3IcDiZGPgMOr+r2rv8GzAnP57HUZ1IyJx/siY1hxf9gFJ/2xSx1QXmeu6xgX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from PH7PR13MB6217.namprd13.prod.outlook.com (2603:10b6:510:249::12)
 by MW4PR13MB5864.namprd13.prod.outlook.com (2603:10b6:303:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Thu, 30 Oct
 2025 15:22:55 +0000
Received: from PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3]) by PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:22:55 +0000
From: Benjamin J Coddington <ben.coddington@hammerspace.com>
To: Scott Mayhew <smayhew@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: ensure the open stateid seqid doesn't go backwards
Date: Thu, 30 Oct 2025 11:22:52 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <91B71657-6813-478A-98EC-27FDE7114B37@hammerspace.com>
In-Reply-To: <20251029193135.1527790-1-smayhew@redhat.com>
References: <20251029193135.1527790-1-smayhew@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To PH7PR13MB6217.namprd13.prod.outlook.com
 (2603:10b6:510:249::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR13MB6217:EE_|MW4PR13MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: c71b949a-2930-4edc-9f54-08de17c8335a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKGTMpFxLUhrwqTuP7o4/qJW+1zjMV417xiKve4EiSnYrdyk1T+l3C13SSAy?=
 =?us-ascii?Q?YC+vUpE2lhXLOXk/WRbLywOUe5ggw2VJoDYKQYHNS/Bhc28zwr22X1U+jj05?=
 =?us-ascii?Q?WVYQY+0+So7aV72c753SxFbLrv7MuHjDeJTexdq23BwacnXXeCRq3YfP1/M1?=
 =?us-ascii?Q?zV71HPIYuBTPd4UseyGkki4PEO6gPks7yCtfb1PGOV/Vnmspsl1232wlZP7j?=
 =?us-ascii?Q?0kjmq7jhXdA1tYto/0gfPjer7oYgh3kQ5yNUpzv7H1PHbqJQ9cHzcmmX77I+?=
 =?us-ascii?Q?iBKzohTG8bE9GrcrO39G7FAQbuL0RXC9bWaajdcemUDIvxYOtsL5uUPLZ8xV?=
 =?us-ascii?Q?ClSjyi61FpleDGLN/EHgS9veH20P7vYYtohHT03cvlWVBWSg9+LtMetC+cPu?=
 =?us-ascii?Q?c6SWePkXIS2nytVsb00IYjQtERU7CcfsvgCoupvazSd+4s25jbV4xq9mSZfA?=
 =?us-ascii?Q?7NwNA15TEIotyLlELE77GUmEsUUYTRkSP+avtJTZD4lQs9G/Z9L6NtV/drQy?=
 =?us-ascii?Q?8aCye9/8ApMrmaRcFMcD82r9Bl4V/w5j4WKGcR8LzRd/Ib3HoLXezB7gvSww?=
 =?us-ascii?Q?wGAoghL2k9DcRfFZOW8tn734v/Bi4eXExQYWxOfk0CVHUjicRpqZP4VoRb9C?=
 =?us-ascii?Q?V/SKxc/hoILTC8dj93mzjBblhdOTIRuFuWmVvJhABCiXhUjy8DiCJgBzVttc?=
 =?us-ascii?Q?RSvOq52fIwPIyC819ZLJrRuYtMZ/UZUT/kzuw08VhXHIEI12/WfNHn+Z/PzW?=
 =?us-ascii?Q?hfA0HgL0nl/GF8SSyY7w9C3owftUS6pCtLRng4UtWfflPE5AT+fl+8iHBh3P?=
 =?us-ascii?Q?zATp+8k/9zcbsrvQ6EqfPaGsLpDFmmf24jLz4dXzAMIZoyiutgGglfyLdf6A?=
 =?us-ascii?Q?mja6rZgOr6oUwflyWOGq9BEKJJgEk6LW73AB3Jvv1S/2h40P9Dc8Ndiz7QUP?=
 =?us-ascii?Q?ymz7VP6V1jAlSLsT1SOdSe2zb6/htIFa74yND+uqkELBKfnH2qRU7ykPp1r1?=
 =?us-ascii?Q?5gJNIsRNb3V7o5QSrnc7RhPZIrBEiF+7YKuOHOVRG168E+qZUU7bX1k7aljK?=
 =?us-ascii?Q?9IWQZibf0/U7ASZgdDH9dn4FKAMqGUO5PgLysNHXk9D+oU5v/20+GrA01dne?=
 =?us-ascii?Q?1nRF/c71qvG2vxiKqc9NXUM2heuu9NdlPGTaQ9L8GVlUNwPWU9NrqKgPx+KN?=
 =?us-ascii?Q?7hVXZ/Zeng8AZl+4oAi7QZKcgkqldU0lxpfrEAaqxF9+NAbYy4L1Lbm8Kjs0?=
 =?us-ascii?Q?X39gAl2i5/t5dCmemEy0DcAQvO8X1M9w3FfP5/nfSOVQxeuOD3zfc0+vw2Pw?=
 =?us-ascii?Q?iYfltth3Dyn0XkAkPoxeOCRLFSme/H+ImL2xDIieTzRQTOQf5OPMxbreiTEL?=
 =?us-ascii?Q?MiPBHcwge7ThapicbNF2dV51owo9+aIOAngzZ0tl5KQ0MQzkKhxphgfYEvHX?=
 =?us-ascii?Q?QOBSM46m3HS4nxxcOBfO4IEdhdn3/A/N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR13MB6217.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3vRnfQecsbkq2SE9va8u9fD6tzYjYTHiLu0xKNCpvt98+xOHq769cI41dXk0?=
 =?us-ascii?Q?NKLgq8qga6o7D2E96zTJX9l+eZIP2/FkhSsRZKIL2Ldg/izULKgQacC6BDkr?=
 =?us-ascii?Q?a5z2mmRFxYtsnt/PFgy2yYXN5a93pyVhYKEmh6uHGq/fz4kMgNP5rcNp0fuY?=
 =?us-ascii?Q?7kh+QMoglN0gd+ngRNbh+a3f8sbjBlQWxqy2blivNHPVNLoqxbbotQS02Ixq?=
 =?us-ascii?Q?HzwyrT9lTD9byVD6zTVI4QcFF1DUGwXTAsc8CfrOfrZ+aRVwWqSDNhMxzeUi?=
 =?us-ascii?Q?2jFhgIwcQOhxmaLApKVURzp7iVNEqOqi6JVCs88m9eJPK8brsfxzaHZHnwhZ?=
 =?us-ascii?Q?KGL3sqnNuPmBX3bh8gmV0MegMNTwX4xbEAhUdwCi/X+NLdI7ZE85sVdaEzo2?=
 =?us-ascii?Q?rjA2m7A6LrnFl7m6V5/+zvShor7GrofoOhr/EpNyxuU3Vjugo6aTEwE/Yswr?=
 =?us-ascii?Q?I0Qtq8EfTAZIiacy6kvwLMBtIlQBsqwGocgYa5kigwPGzDPJ+0QrUwenxeKe?=
 =?us-ascii?Q?ro5Dwe0YlljJF9xHZYx/JK4Aiaa0zr9LuT6YI/UACwsxU4/ugtHnMLyNyI2t?=
 =?us-ascii?Q?aZwHcW1dqV+KCQJ6Ajl5dcTvv9WITVV3JDnIx8skwjyN8wXxaK0g0+mEiEOX?=
 =?us-ascii?Q?HNANet2ZzgbvKeSYqugixgcmXnileizss1GYeRlCAWKKnNd7AK5FxYT7a17I?=
 =?us-ascii?Q?beEDEjaCEVgcWgcW5N1Jn8P3BdlCXgXOahbG5RQnVNX7LQKt9lmi5gVvDIMA?=
 =?us-ascii?Q?OiNWt+gBYO6wUd2fQsRf0adKWtuXYyw2dY7Yw7xoGnkNMY7EDrmESzFwXShv?=
 =?us-ascii?Q?/ynCXfQVm1rZgHWLzSB4hsaOcymMKzUyGxREnbu8wMv+0RxH0EXZa+l8NVuf?=
 =?us-ascii?Q?PA0qp1i198oNB7+OpSKgduJo/B9Nouaz9zcXgeM2R72GHZejDsrxWyvv+MEd?=
 =?us-ascii?Q?QEdaTQseZX/TSAnC6Yu5ax4a/ti9BwNQR/uuBh73uHZ/sQNErdlxhNH8uHAG?=
 =?us-ascii?Q?znMDsebUQhtikcZ+WQCPTdmTtbDfvdwxBwxbdj5pW4gvGudgYtiqeUfUNACQ?=
 =?us-ascii?Q?hHjhAaD/pw7CyY7yodYRoGawPC9jbAM0WM0K45BwnvLhVsVFwJNz21e8c5Fu?=
 =?us-ascii?Q?FvL6TIbXWUQbG4wtBVPh4otUImkOOsSMX6Q2MGbc2kX4uaVFxln6Uq+zNMyL?=
 =?us-ascii?Q?kzDSBlTIcwzrbn4jtE6J7nZaO0UPAuS5ddrJaFAbJ2D/4dZzgmf54fRJdula?=
 =?us-ascii?Q?b5nLiRrXUWJBnLC23KG/23Vs8S0hehZ8yrCdZt9LoV42CTPAXD3kyNGNNteK?=
 =?us-ascii?Q?rZTQumexayJeX0/LkYiSWHhkPVgJwm2m7n42034zcjGfPbPqwQ0srgMSOI4Z?=
 =?us-ascii?Q?QioDpZrao4eJiUVcBpRXlrr3z1Ei/P7xcNTbWGlWjMYjl9ss9dYXDq0B97qI?=
 =?us-ascii?Q?9B50F+NNk8ZRDw+D+/Fw/nc7estVSNL1Aqliv2c1zwzJyGnoWeE9dXaeh6rC?=
 =?us-ascii?Q?zdUmD/1/gLknwV1w6Hye9bCm7nwnFdJt5HE8eRD9IRRA373J+X8Amm6p+FpA?=
 =?us-ascii?Q?PDzztnxNsy55PToebf7K54sozYu953nOswhUK56rVO8w/J3NCYOMI+GgVxVW?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71b949a-2930-4edc-9f54-08de17c8335a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR13MB6217.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:22:55.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owg7G/cr9xDB97zYOpcMQNo5icbq//cuLuPwAq9nA/J8Mguq3xzK36eHA3VMqY9KncCegxvLvafngghxP9eKSgJfWSkAoPtM1vgVQaizWd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5864

On 29 Oct 2025, at 15:31, Scott Mayhew wrote:

> We have observed an NFSv4 client receiving a LOCK reply with a status o=
f
> NFS4ERR_OLD_STATEID and subsequently retrying the LOCK request with an
> earlier seqid value in the stateid.  As this was for a new lockowner,
> that would imply that nfs_set_open_stateid_locked() had updated the ope=
n
> stateid seqid with an earlier value.
>
> Looking at nfs_set_open_stateid_locked(), if the incoming seqid is out
> of sequence, the task will sleep on the state->waitq for up to 5
> seconds.  If the task waits for the full 5 seconds, then after finishin=
g
> the wait it'll update the open stateid seqid with whatever value the
> incoming seqid has.  If there are multiple waiters in this scenario,
> then the last one to perform said update may not be the one with the
> highest seqid.
>
> Add a check to ensure that the seqid can only be incremented, and add a=

> tracepoint to indicate when old seqids are skipped.
>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfs/nfs4proc.c  | 7 +++++++
>  fs/nfs/nfs4trace.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 411776718494..840ec732ade4 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -1780,6 +1780,13 @@ static void nfs_set_open_stateid_locked(struct n=
fs4_state *state,
>                 if (nfs_stateid_is_sequential(state, stateid))
>                         break;
>
> +               if (nfs4_stateid_match_other(stateid, &state->open_stat=
eid) &&

Should we unroll or modify nfs_stateid_is_sequential() which is already
doing the match_other check here?  Maybe it could become
nfs_stateid_is_sequential_or_.. skipped?  lost?

This is going to be a super-rare occurrence, but when it happens we shoul=
d
be aware that we're going to process the waiters out-of-order.

I'm trying to see any harmful side-effects of doing so, but not coming up=

with anything.  I guess we could have mis-ordered setting of
NFS_DELEGATED_STATE, but I think we race to that anyway.

I've tried to think this over carefully - so:

Reviewed-by: Benjamin Coddington <ben.coddington@hammerspace.com>

Ben


> +                   !nfs4_stateid_is_newer(stateid, &state->open_statei=
d)) {
> +                       trace_nfs4_open_stateid_update_skip(state->inod=
e,
> +                                                           stateid, st=
atus);
> +                       return;
> +               }
> +
>                 if (status)
>                         break;
>                 /* Rely on seqids for serialisation with NFSv4.0 */
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 9776d220cec3..6285128e631a 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -1353,6 +1353,7 @@ DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_setattr);
>  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_delegreturn);
>  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update);
>  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update_wait);
> +DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_open_stateid_update_skip);
>  DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_close_stateid_update_wait);
>
>  DECLARE_EVENT_CLASS(nfs4_getattr_event,
> --
> 2.51.0

