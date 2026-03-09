Return-Path: <linux-nfs+bounces-19882-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPQNFVDLrmnEIwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19882-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 14:29:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B3239C09
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 14:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 851503017DCA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F21B3925;
	Mon,  9 Mar 2026 13:29:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020074.outbound.protection.outlook.com [52.101.195.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C725212542
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062989; cv=fail; b=hbn9k5vg47usjEeqNF/I+eGjySDbo3nD2sl+rs8Dudw660aPRiB/MHxAhPQ/Y5AYusQzgLBbqJWIDtdqE1D2bybwOaXhIpdkyB3V1cKtAruGY2fW5tq8w7FOSG2Dzl8yoAV4UetRZKXj1/aNaodyVoNZPqPp1x7sqy4atIc0K4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062989; c=relaxed/simple;
	bh=Tgt+VTey/TdqYF7q1tR1EdlBbGu9SmZJBqtzREEWuVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bI63Wm/dwGi2vFnoPxf2d79CSt8q1hTxnGQ27hzcHgttO5MxPh3g8zcKktBmyH7OtEVZpVcJkCLLdMxDUqjg2M/aHozxV+thdpzFUhyWmD6MB+7j58DaTyy4Xide9NQlxD+sEC1yXsWhOQ+oFiOzX8Gt9ku6FeZ2DftyT4nOPfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cj7yr+M0JJL3fdu/XE4Tnnt8YkEpH939v5SIAGlN4PEaZFfb4mtoNmtaIdyaWvwz+Qk78u6G236ix2OfcX9WUgn4OE84VWvCN2HgVN8vmEFLPyBC62WyOoLOMDCcDyBP7d4tDLVtjvex9GueUMCvEUMGVect9sANu1WtvQiAgDV+/1BeZvyaln5duVsLyGW4pM9dqPvNEZjLDWEcYVJwgBh6H+o6+stlvapwj0/OQsaab6Wct+//5e9jyJ/+t90n4qOxpZbdUqCRnZkCehu5/fJT9YSwHzVmLJCqm7uK+Q42+WMUdnAtiCt11N/FswSjovr8PkIeFHGZRw/uxBS7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVJkCECU1+N1KAAB0Ip/eXo/rWX5sSxUBCVjaHAL/FQ=;
 b=g/KzyOVr+6hc5AVFnSczzAtZfGJo0mwuhNFf6O2WS7hVDE6eRQb+iOuyQM+3yK+2zX9wH2ow1dsblsKs7fp7jDM97FK680U7dluf89HmAM8ZvNhcAjchMAnVG7u1RetkfRH4c1aWwNQoSpxjrfzW1Y3JdPpwFea6ZP7uGMKpVMNuWcYbAD0uB9Q7HFKyC8CzQQMrp4sB1dbL1q+yoGGp+QKet5hsBdEizcwau+jcgmiQeU5/5ETV2m8O2rzT9MoZkbNFkr0mG0moWP7orFEnSmnG7i6+21uF5FR0xPecAKVBIBP9KloOdsJAGE8bEB+nSPUnev9zYf2CA4GRYt7L6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8908.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:482::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 13:29:45 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 13:29:45 +0000
Date: Mon, 9 Mar 2026 09:29:40 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Steve Dickson <steved@redhat.com>, tbecker@redhat.com, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsrahead: enable event-driven mountinfo monitoring and
 skip non-NFS devices
Message-ID: <be4dsl73wdridt67nhccl5ccj2d66hymkbstm3tykwsqe3ykfr@cc7r4yawfk62>
References: <20260306161929.4148128-1-atomlin@atomlin.com>
 <ea495f1d-1464-4f9d-91de-dd3fe828fcff@redhat.com>
 <CAHj4cs-Eg7sJZLju_32yiQv5x=WHvVUpkgFshzr2AQZek+z1=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHj4cs-Eg7sJZLju_32yiQv5x=WHvVUpkgFshzr2AQZek+z1=Q@mail.gmail.com>
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5cb8a3-a045-4063-6486-08de7ddfed55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	zZArT+iqpaKlmRFSGOlZnpmOX6TY5vermZgZ9i25E+OtBs+jlHHYglYKrNMP3y51QhdQ47uITgZkoOr+sZIKRuhdXdl/W/cBwTTPK8Heyt/Jc3v2AbORd2c+qhKotQa8Vvh74Il7BJhXopEYdSkklBjiqtJZ/Jq6rx//B6mfxQAG418L8Ik4nV5O9GuieDM6CdBJoBH/VOV4YYJ/X0bVoodltoqtl6qGc/as2Jnppu/J/B3MWW+w1Qdjl0TCyqMSgAjNTdS/PVx8DT2g/4dG/ExJz9nYt0OKy/QioUAA84EEuA0BrK+IvcRMF5PtwflojD/uBoaVH3ztbv/3pnjva+XHDj6SYOGMjw39hfSujwbTZOiThHfWfFvO67RM1XM0eJjTzozS7XGe3c7x52ZIohu1IbHrdutpkqzt7/4LiANTXQdLKeVDbuDyCuwR8GunysliXtDczos2C5dVxMUHDi3lGh5mOwlAJbmNQa8Gn71CA8nxREBwMqmcSRO06LS0pfZsphD+aN2vPuOX8WNRWxbrXZ7lm5V/u8ZROcReIOdB6OdrFdgo1wUnZRW/GU78sxYH6MiV6/TUIeiqgnlE67Lag7NhqAIfgLuVXOJ95kXUtFA969vZaybiAUTLroiJ5xfOoinb5Fm0CQ1/xpT0BMIVTP7x78iigPOmHZLWiqFzS1AJLkSOmvoF39J297oqCB4L4ZFwegepJOrQGg4+fkIuEu3NsJP6eZm7ZWL3DpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0k1ZlZwb3JKWmY1MnhPYmtWcThrWFNOOWMvQkVtNzZGV0NWRURPRFVWcldK?=
 =?utf-8?B?azQwenZPcnF1SjhpSmZQdjl2R2ZLZnJzU3orU1FKdVJZY3hNVXA4ckxoUjZo?=
 =?utf-8?B?WlJWSTV1QjRNaU1oZ2tSWmZuclBGYVdtQjZFNWZVcGw3ejhaY08zNEFSNlJ0?=
 =?utf-8?B?SmJZM1VIbkVDWUttMDRiSEtWSWRlREpvaWdhYUVaekVBazRkSDRwOS9aQmtq?=
 =?utf-8?B?QS9ubkMwaEUvZ1B0QW5NbXBGMXorVXR2anFNRXJ6ZzliRGpjU21ISmpzbjF2?=
 =?utf-8?B?VVEvdnUrb0prL2tHZlg4aTM5TkdMYzVHVmpvTGZsM1dJZERpb0Y1WklQMllk?=
 =?utf-8?B?VnNqN0tYYnUyWm9ZSkU0cmVLZlVzN1RTT2syTWtxRUw2OCs5dkVGakRwNDRj?=
 =?utf-8?B?K25wTlJsS2YzRGE4OHZ6RHU5a3pLNjlNNzFrY3hnWFRjUzc4Q0ZVSEhUbWhp?=
 =?utf-8?B?cXRUQ3hsRmRaclFaNCtUWDl4Rk1ZNVp0blFnbk5oVWh4OGI0MW9vR1grbElp?=
 =?utf-8?B?L2VzUEl6N0VVSWo2WVhWL0ptNnh3UmFZNnA5REFaN2NFYkM0THhhWWtFclJn?=
 =?utf-8?B?NXgxMmNLa2dlak5RTFVPS0dvVHh4NVJiZDVlcDF2SUk2dTZqdEM2cHJHQ3Jl?=
 =?utf-8?B?N0FCdEhUMkJRTExWWHBjbEJBS3FHaUwyQjNyMWlSaFJUTFRrbzYwV1dRM2d4?=
 =?utf-8?B?NmJJcURIRFhIQ0Z3RFMvL3hON1pSd1krN2xyTHV6VkNLY1hOWWxuemtMaDhY?=
 =?utf-8?B?TGdBWGNWQ1lOUkF4a1BIeGgxVHltVnNremdTTnREWGEyNlhlRWpqRjM3eUhj?=
 =?utf-8?B?YnpmME4rZlo3aEdpNTU2SWp4cm5ocDNiZlBMS3JBMkE2eHczK2lmUVIrSHV3?=
 =?utf-8?B?akU2YnFFeTFGUkVZNlRrbXhmYUprVXV1di9qQTNiVlFIQURWWVZ2NjUraGRm?=
 =?utf-8?B?MUErRUZ3UzVzci9uWkRXcWFuaEdvdTQ1amRIenVjMFIwNVhGeXNFL3o0WjBY?=
 =?utf-8?B?NWpBKytuWlZIUnhFZUFsY3JvQ0lGaHU3THhvdTQwMEFhWDgxbURNT09MZjNo?=
 =?utf-8?B?NzJmcGU0NEIxeDc5U0R1OHNKRVlSTjlGVHRURVlWdnlnQTVSSmRYVG42ai9y?=
 =?utf-8?B?MHRoNm0wa3lhRVlFd29Md1Q5N2hDdjdMVVFnc09PZzhoOUt5SDJaYldtM0FH?=
 =?utf-8?B?QVpGSElhakFGWEVrbGo4K1FsSjNGK25mMk8xK09QeU5Tc1BvRENUbXhmVUxV?=
 =?utf-8?B?Vm82RnNsZ3RweEl0azFPLzZ3OWgvQ0lWUWxQb0JVQlorNDZMTmlFbzhVZ0hH?=
 =?utf-8?B?dFJoTk8wVEFEcWZPMEEyVW5YaTFJM0xhZWlRNXZnNjFUNHJ1MTRpcDg2L2x5?=
 =?utf-8?B?SGpHdUlNTENROWFycXMremV0ZmVsMmhnZDY4dzYyNEhZdGRqbmFFbGdtMXQ2?=
 =?utf-8?B?SVFTZEIwbGhaVW1MQUNUTDUxbUJFcW5yUkQ2NWxKVjBaT2s5bmNYNzZid2kz?=
 =?utf-8?B?dWZ3YTFnUTM2eW5YWGlIWW5XaktoRG1sYnFtbjhudzBVR2lHejhqdytKdytW?=
 =?utf-8?B?SUpkaHpoa0JKcFJDaEJxWW8vN1JHanJReUMzbTVLNG9RZzVIYnowNDF1TmRD?=
 =?utf-8?B?K216WEJMcHJSYmt6M0F4Sng0cVVubTNObUEzOHFqL0R4b3cxZlduRkdZYjZi?=
 =?utf-8?B?RzJZQzc2NXhySVBkZGJpVUlDeExHNitFaGVvSEY4TFoxQnVnR3ZFUlBSbmlM?=
 =?utf-8?B?eVZRMDRQQmNyV2ViV2lXOTdXeFlkOWU5VHBXaVhHQTVuTVJXd0VsZ1ZYY2U1?=
 =?utf-8?B?d0VBRk93V3NGOCs3SzJyQjFIMElGaDU2SlVxcWZ1T1prVTM3SUU2cjQzdVla?=
 =?utf-8?B?eEc0Z1lkaER2V3FjZm5UbVNUS1ByaFZINUtEZXh0K2VTTE93ODVMbEFYbFBQ?=
 =?utf-8?B?NDZEY0NOeitIck50SmdVcmxOc0wxWHJZNHVaOUNZZ2NDWWQ3STQ3SHpKaUt4?=
 =?utf-8?B?NEY4VEFJeHNVbkRqZ25qYk95bXlLUktrMDdCYWhmRG9uem9Dd25QZkhtUk9r?=
 =?utf-8?B?ek8wN1hMNkd6aVEzd2xmTEtoelhRN1BuQ2Mvam1vWERrQmJIaGJmRHZxaU9q?=
 =?utf-8?B?c1BhR01nSmNYU2NwTGJ2ZXh0ZHN6YldIVGRYRTh6TllYaE1iTzNqNFh1T3dB?=
 =?utf-8?B?WUZUYVExUmY5VjhWbi9KNkU1Y3NzS2tLK2Fmc0J2b0RHYy9ZMjJVSy9SLzBW?=
 =?utf-8?B?enlmS3ppc1ZIM3F0WVp1a0xTQjJOOVhwT0RVQnBYZTgwcVNZcmtYTW1zMmE1?=
 =?utf-8?B?TWttb202M3JtbG43bFRqVGI3bGR5NitQTFZYbjNBYjhPOVNhemZxQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5cb8a3-a045-4063-6486-08de7ddfed55
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:29:44.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uw595EMjNqRt4cl3leAr4B3QlJGxZkYwNVXdfczUutRBdgbxIkbRLKCdTc80oYDAGyUl6JYR6QRBQyWfOp2Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8908
X-Rspamd-Queue-Id: 414B3239C09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19882-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.039];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 08:38:54PM +0800, Yi Zhang wrote:
> Hi Steve/Aaron
> The patch seems still have issues. Here is the journal log during
> blktests:

Hi Yi, Steve,

> malloc_printerr (libc.so.6 + 0x7fd2c)
>                                         #5  0x00007f7a2fde4710
> _int_free_merge_chunk (libc.so.6 + 0x81710)
>                                         #6  0x00007f7a2fde4789
> _int_free_chunk (libc.so.6 + 0x81789)
>                                         #7  0x000056327361bd47 main
> (/usr/libexec/nfsrahead + 0xd47)
>                                         #8  0x00007f7a2fd66681
> __libc_start_call_main (libc.so.6 + 0x3681)
>                                         #9  0x00007f7a2fd66798
> __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x3798)
>                                         #10 0x000056327361bfc5 _start
> (/usr/libexec/nfsrahead + 0xfc5)
>                                         ELF object binary
> architecture: AMD x86-64
> Mar 09 08:35:07 (udev-worker)[9115]: 8:16: Process
> '/usr/libexec/nfsrahead 8:16' terminated by signal ABRT.
> Mar 09 08:35:07 (udev-worker)[9115]: 8:16: Failed to wait for spawned
> command '/usr/libexec/nfsrahead 8:16': Input/output error
> Mar 09 08:35:07 (udev-worker)[9115]: 8:16:
> /usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM="/usr/libexec/nfsrahead
> %k": Failed to execute "/usr/libexec/nfsrahead 8:16": Input/output
> error

Thank you for reporting this issue and for providing such a detailed
journal log. It is incredibly helpful in pinpointing the problem.

The log points directly to an unintended side effect of the recent
fast-path optimisation. While the new logic correctly rejects non-NFS block
devices (such as 8:16) without blocking the udev worker, this early exit
completely bypasses the initialisation of the device_info struct in main().

Consequently, when the code jumps to the cleanup path upon exiting,
free_device_info() attempts to free pointers containing uninitialised stack
memory. This is what triggers the glibc abort(3) you observed during the
tests.

The fix is quite straightforward. I will shortly send a patch that
explicitly zero-initialises the struct at its declaration:
    struct device_info device = { 0 };

This ensures all internal pointers begin as NULL, allowing the cleanup path
to safely handle an early exit without crashing.

I will Cc you on the patch once it is sent. I would appreciate it if you
could test it against your blktests environment to confirm the issue is
fully resolved.


Kind regards,
-- 
Aaron Tomlin

