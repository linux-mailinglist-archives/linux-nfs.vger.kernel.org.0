Return-Path: <linux-nfs+bounces-15856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B74C2638D
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748BE3B8BE4
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03091E520A;
	Fri, 31 Oct 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="d+T2WXcs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023099.outbound.protection.outlook.com [40.93.196.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AAE405F7
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928431; cv=fail; b=MjbMwf4DSK4dgKSI/ayjPXP/TNZ4zKa0vxISPlQm62t9lAk3J9Nr+H/2+qEC++O0rE2EQ4Ngd1gXflZIQt76NahmzTStEOlajkcdos/Ur3whY0GYljX0XxPolCQNsqxzcqjOApcZm8lnuQIypqJhBaC9G8egpowuTT8RgmQpr3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928431; c=relaxed/simple;
	bh=BxFluQNF1++qY8p+napHZyLi6Bf4sogyMosZHg5mueg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJeNCGniwUxeY8itrIAVhRAuHk9rMAKt7ffw5nZ+qtarS3fU/kF78V5yF1c6fpVOwUTugTaoyNXA6AJkytGQvFr1e6qzAlvfEju2K1I586AS9J0pAWJDkxgh1n/YV4i5peMFrBFIDtXTPqGCPt4Nad7VGMhcfXPu+/2AXX2ibsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=d+T2WXcs; arc=fail smtp.client-ip=40.93.196.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV3Fso/lovVBRryhw/gvm5jY5wJ9xFWpuNnnQrBamE5up1kxkYQkHb8L83JtOMPvaAWM+un7neQbbEdAFO+OpkWonzSlYypLIsKwx8SBKGpVzJFY5XS4neZvmmisgbwzyx8TC3TH1qAr8jqcwhXu9IH4qQUVVLHQf4fEY3ORknSbQLZhu0sBkF8z9wLRctWZBN4CSAFXxsQlFiKil3WKOa1rWACr4o6Wr96moaen7xk33ML7cPIvPHen3jXSbRngB3azp1JkI4d3H8RhlYCkVhcp4IHO00cHgdEJU8ChkDfIfvoCuFFe1ZkcdXq/wSi1q4hMtIs9HOsc3YE9WZBfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6IpYbQ+fzOgHiKbYpzruDPxc3n7Pd+zlpdKSr/NG4Y=;
 b=LIobk0/EHMI4R5aoz7WWni1/TjUqISandDU9lFTQI38H6vHkjqdMVbztDWxqWOJxlsSBGvk2eyWfAGmrhZFe0WVSqWmxygBYWtXhRSWUyH2u/4LDuvJ0p0/4+Ewq5j5BiZxaTDEmoFO7a7NuwZrVQVOKeHJL8P+JVyxuHIyYUo35AqzOG5+skCDJse3eQiOR3QDhORC45dbtUFElzkDDpX9rNPQ5zEIZnCoiF3XiPTU0AjkuHtz+X82tZUOczXq/z1sUKS9eytbl+p48CvH7u9EoSVVvKbBF8p3qcwzTP4cCEVz1eS/ylq0wljkzRZDZAgqq1/xkJCWb9aRi+G4kew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6IpYbQ+fzOgHiKbYpzruDPxc3n7Pd+zlpdKSr/NG4Y=;
 b=d+T2WXcsLPGtykUWeWkPKpEeZvdTpqb+vgw2woRCGja1w3RsYfFm970sppGXiiIqvHUNA+CRIqsLoPDQqXe1V4yVzAH4OhnUzJmduHDs+7TxpwCrtCRElWA/ZItYZlEypYfTo/XA3kWgZxFboTy8yWsm2zkBjKnVdFOqgCU071A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from PH7PR13MB6217.namprd13.prod.outlook.com (2603:10b6:510:249::12)
 by BY1PR13MB6261.namprd13.prod.outlook.com (2603:10b6:a03:52f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:33:47 +0000
Received: from PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3]) by PH7PR13MB6217.namprd13.prod.outlook.com
 ([fe80::9a18:22fa:f07c:4eb3%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 16:33:47 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Scott Mayhew <smayhew@redhat.com>
Cc: Benjamin J Coddington <ben.coddington@hammerspace.com>,
 trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: ensure the open stateid seqid doesn't go backwards
Date: Fri, 31 Oct 2025 12:33:44 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <7FF2D782-2009-4CB7-A00E-35F71502AC1D@hammerspace.com>
In-Reply-To: <aQTS76CWF_jArVq6@aion>
References: <20251029193135.1527790-1-smayhew@redhat.com>
 <91B71657-6813-478A-98EC-27FDE7114B37@hammerspace.com>
 <aQTS76CWF_jArVq6@aion>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:208:51::30) To PH7PR13MB6217.namprd13.prod.outlook.com
 (2603:10b6:510:249::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR13MB6217:EE_|BY1PR13MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d40b10-8517-49f7-e06a-08de189b43b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lpPDUt1dlvWbrCSh00uOcSrHwJiJhS1IuQUNHBDDe0GFb1cYk8U2hxT5YG5T?=
 =?us-ascii?Q?DU2RkmMCcXl4tLBvkqND38iLavlyFq79As0bdOOqYsee/1cC48WY7PkZraZe?=
 =?us-ascii?Q?KDBOqc//B8fLHyKyHeadcjxSqYdlb+wXlHuO0vnpxeWgHhSYWSutCtdI37gC?=
 =?us-ascii?Q?MQIXjbm4XeWd9FRbKNGzGOBuXnnnaJ3uO0CU3Vzwk1+ShIFn/u0RMJ5V5gvq?=
 =?us-ascii?Q?Toq6xCvBjD7v9XL/DdaKp8zUWANCbzQmOyIDGomUTc2x2Y2nJHW63BFRG0hS?=
 =?us-ascii?Q?KwoPvQ7LXG6tAUdb25oPB+wEdIbMBwe8dudc1wZflwfB5EsG4y43cbrofaJn?=
 =?us-ascii?Q?uWAYJDLG3rwQUK/IBXo4LXMFIJtQN/BdS8Y+SprTE7OF7poibzdv5AYkyqm7?=
 =?us-ascii?Q?y9iMRXfl61JPdBvDOssnGZG/6/03+46HpJnHJY4NLOk8NRSu8WFiQ9VAtwsZ?=
 =?us-ascii?Q?uZUR9SIEK+g30vC5q9Q9Dr2gduLOhWuMGTfY+H7beVcYPkQIta/iRiNYLNwj?=
 =?us-ascii?Q?aaSLeE0VCxRaQYnUe2OEKvQX0o8dlomI6TE1ygWsSz1fp+qQ6nUa2nVheJWu?=
 =?us-ascii?Q?JjmtIriEunWCSYP4euiG9cQxd7+uEmsGQk6ipDVhFt+DbKG+qHBDHnnPHDwF?=
 =?us-ascii?Q?9vBDH/qwOGlDr9r2+hkv++7oSVk/K3zyT/PXBWC31DgSyA6p7dYQfJri0iyE?=
 =?us-ascii?Q?GZDIu29sHVQ+ilJMRZe0UrqUsVW6F5Q2XlnERUq++EtklME+oA3RGGdNAY2P?=
 =?us-ascii?Q?MK+tB25y0LjlR6zc5Wf2qx4m2x/dCL97igvJwJ+gsAg3PCed4KxH8L4B8k8g?=
 =?us-ascii?Q?Gkvg8KHXEKOQeY2hsd357G9WX1BqRZ9PAj2cI2fnq3pNTgpxV5KetSAe9ZaD?=
 =?us-ascii?Q?EWDZY4BxlrFTe1maNgOTwqBFlGfRRBFUkXNagsrwVaVwaOs2cM9V6UdKsQ/4?=
 =?us-ascii?Q?SUHz5B3C1UtN12qjCxG+1MHGvNGrVyUv6ezRRuQP1y5LtcIxB9mEdnKeIBqB?=
 =?us-ascii?Q?K7/YMp27Q6rL/zfxdk9WS/feGvzHPET9wK2dVRxVTrrfoCKx4C0gkOtbusDV?=
 =?us-ascii?Q?7x1lOwF2Nff/2I4OUDLofS10aNAhdg2SiVCIVdno90v5ugDw4xst/WsbvIC2?=
 =?us-ascii?Q?8b5yhgFz6vnaD05O/OMJv/mOSWyN+srIje4KTa7sWVdY2aGAIy1hGt4cCoXX?=
 =?us-ascii?Q?cOuMmLY8xA6e8RkoC8alKHXFrJ3rehcudzPFKGs8F/s6u4ctw6Wr67k/513M?=
 =?us-ascii?Q?PHdohnKFTUPAEjPrLNvq/AjAKtPnq4Qw9Mf17FdvajJ8C7MhKWfHSCNkgkf+?=
 =?us-ascii?Q?3UQ1Kme2d0NoE+8fc41PnZ0L+fhGSK6briywk79E1XJwJssrQe3VCZnWP7zM?=
 =?us-ascii?Q?s3gFjHeJ/D3Vpd7uLrLIQlq37GWVBXvUEcQ3z2Ipe+fpF3Nu979iU0oWI5Qq?=
 =?us-ascii?Q?8Aisa3/yzN26V0k4KR+ytNFFfJhIf+ho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR13MB6217.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Il+cnE18Z54RMJgfX4aySTwhbAuLP7JjzXa0a34MupruHsYpP3L5t+l88LDH?=
 =?us-ascii?Q?5Uyg8DMuEyo9YVWnerxyKuUzCvPVVCdr+aEtdfG84XU1+MMs94t0+gZNBFpP?=
 =?us-ascii?Q?XT5E9jzG2LgxgO6HvoujCUH09mTE/v1V8/nTV+5IAFXwAfihizVuH4p5mjV9?=
 =?us-ascii?Q?Dr5QKVJsb13N4ae5QzhTCUWaL8DLxGfpuSdemNeDCq/HjA075RkcXBJ+GDHZ?=
 =?us-ascii?Q?8PmkVko7VMa7/wwG2b1M2uT8E9gEeIhFtCJ3if09DTcK06sWCfKN2FBrrbyD?=
 =?us-ascii?Q?thk7j6DvgUI//lGW6qBo08qcInpIsL2A8bzuwRdttrR/XsvEY2ifUlFDvSqU?=
 =?us-ascii?Q?FSHpGPMAxvElgHkvUCFDZpv/PHJTWkKCkvUq5wmo9xuOgBYXpqkUElaxB4qN?=
 =?us-ascii?Q?6DFneZsx4aJhdPKx0tGEm5qUxy/e/YGXFH6GATsEeqZ5C9kFDehzANHjrwkn?=
 =?us-ascii?Q?OSTG2bJaTn+Gy+NeoOWMlyx+Nm7PPnPYn2dQFFjBHIB3tZQx+OeaShim+86t?=
 =?us-ascii?Q?BvYkb3HHCHz1zV3gE2U8KDB6EwceRsCZBd/dNfKFVzjL266L/s+TUCZsYqnQ?=
 =?us-ascii?Q?kMvcgKkd3nqXJVZ6bPQslIxMOEo7ojJHplIpz/wzPS5Mrh0Qw6ehw5QGyF+x?=
 =?us-ascii?Q?kax/vUiylPDuKdmNJFeV5Mn9J3TJrbnwGwKXHZJEj1gyE3IytIA2SI/ivBDl?=
 =?us-ascii?Q?rPuCNQOM9NDk5zlHWmsHZptpoE1nZq+3L+HOuZb32vo2sM0glS8TmOAtdm2g?=
 =?us-ascii?Q?ryjtuydWbtSTa22O/U9zUMEJLzW3iUCergevtJkvd9NHJYC13v0THnhh4uBC?=
 =?us-ascii?Q?PNzsYy77qMeUT1k6pUgku9FmPy0SzLAiXf+Og7zZedrd9G+GY8TZnTxAsuXF?=
 =?us-ascii?Q?OxSVJdg/drXxXUdSgVYNxqUmgluVk79KKj1bv+ZQMycqAWafMXtnwoCwK+TD?=
 =?us-ascii?Q?Ss9PvYSQ+9Jn0LwtcJ0hBqPZSC9SWFeMZtAOW0XOWOj7QuM+mCPcF7DWgVHJ?=
 =?us-ascii?Q?JA2vJP2wwsG/HTynTlgqXGdkHGvIvux3ti5ZAvBZ9PQcddeM1A+lkZ2nglo6?=
 =?us-ascii?Q?zEFE/8PmNmgNj+FoZOOapIEXL1vPoOMp7Wf4NxSkDSfxmi6YjtjUG8NTkd6M?=
 =?us-ascii?Q?hCUAYNBCvJtwYbaXRh6TQd9pmAblfYaDj/0owVZIrISUWtcAsK7+2TvA5Rlm?=
 =?us-ascii?Q?MW+D2DIzybTXnIuEQeNmQYY3lrC4j1XBfMbuRLmOUY6KSSmSGtDPpqqUc+o0?=
 =?us-ascii?Q?tB3Y0+xdBiGL4ugy5Wxo6L6J9bxq5EC6V2TFzC5DUn+Vf9Ly5EYJ5qHJn22T?=
 =?us-ascii?Q?Y3M+iyyw9i66sTAkEFJP4d9d0T5z7JLjsoTFOb7bn1vb7ZMCFOSgNVCiQgDx?=
 =?us-ascii?Q?uBMr+eYO29/vTsU9XlYtfxrjNaNxz4mbjXRP8+oF4tDdFmJu2L3AGHrxM3KO?=
 =?us-ascii?Q?qVrYcB6zImDv1icDrMv8NmJxTKsS0u9TiOvzU/1MRuyrTo1DYVWUuIFONLGC?=
 =?us-ascii?Q?Kc4hoWUvJq60pAzEwGa9MJB2mR18h5MV3/ygdrJr/WJHAILK18ILboVMCJYv?=
 =?us-ascii?Q?V2XfsBZb4Tn8VDVRJ8BA39aZ7z+X5t6q6pcKXBsi1utY+0SSeFrzWGD7v/UY?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d40b10-8517-49f7-e06a-08de189b43b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR13MB6217.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:33:46.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9D7Etj9NtnPo83oUEdTg9JW9cDfwMRAE9kJg2tV9t2UawVXtlXpydZzP3ZCiKlVHWHtUCgI5imwIwg/svGPG8WoT3/OAYe2VIVujFP9J+wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6261

On 31 Oct 2025, at 11:17, Scott Mayhew wrote:

> [You don't often get email from smayhew@redhat.com. Learn why this is i=
mportant at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu, 30 Oct 2025, Benjamin J Coddington wrote:
>
>> On 29 Oct 2025, at 15:31, Scott Mayhew wrote:
>>
>>> We have observed an NFSv4 client receiving a LOCK reply with a status=
 of
>>> NFS4ERR_OLD_STATEID and subsequently retrying the LOCK request with a=
n
>>> earlier seqid value in the stateid.  As this was for a new lockowner,=

>>> that would imply that nfs_set_open_stateid_locked() had updated the o=
pen
>>> stateid seqid with an earlier value.
>>>
>>> Looking at nfs_set_open_stateid_locked(), if the incoming seqid is ou=
t
>>> of sequence, the task will sleep on the state->waitq for up to 5
>>> seconds.  If the task waits for the full 5 seconds, then after finish=
ing
>>> the wait it'll update the open stateid seqid with whatever value the
>>> incoming seqid has.  If there are multiple waiters in this scenario,
>>> then the last one to perform said update may not be the one with the
>>> highest seqid.
>>>
>>> Add a check to ensure that the seqid can only be incremented, and add=
 a
>>> tracepoint to indicate when old seqids are skipped.
>>>
>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>> ---
>>>  fs/nfs/nfs4proc.c  | 7 +++++++
>>>  fs/nfs/nfs4trace.h | 1 +
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 411776718494..840ec732ade4 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -1780,6 +1780,13 @@ static void nfs_set_open_stateid_locked(struct=
 nfs4_state *state,
>>>                 if (nfs_stateid_is_sequential(state, stateid))
>>>                         break;
>>>
>>> +               if (nfs4_stateid_match_other(stateid, &state->open_st=
ateid) &&
>>
>> Should we unroll or modify nfs_stateid_is_sequential() which is alread=
y
>> doing the match_other check here?  Maybe it could become
>> nfs_stateid_is_sequential_or_.. skipped?  lost?
>
> I think folding the check into nfs_stateid_is_sequential() would make
> the code less readable.  nfs_stateid_is_sequential() returns a bool.  I=
f
> we add our check in there, then we'd need some extra info to indicate
> why it's returning false.  Is it because the incoming stateid seqid is
> more than 1 greater than the open stateid seqid (in which case we want
> the caller to wait)?  Or is it <=3D to the open stateid seqid (in which=

> case we just want the caller to exit)?
>
> I suppose we could change the return value to -1/0/1 or add and output
> parameter or something.  Personally I just think it's clearer to have t=
he
> extra check.

I agree it makes the calling convention difficult, but it could be unroll=
ed.
Probably the compiler will optimize away the double memcmp().

We had a good run not worrying about this case and only needing
nfs_stateid_is_sequential().

Ben

