Return-Path: <linux-nfs+bounces-2732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0647289DD71
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 17:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAAB2866B4
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909368287F;
	Tue,  9 Apr 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tIXPPnnQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D6129E6E
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674795; cv=fail; b=Oczlt11PwAEuDt7DvC1cgM01X064EHYzN2Yrw1IkcRDiIfPm9w5ZTpjkLfn2yl34scnigXHRcfzZnrBUmyeJtvTBGP4afvKWOpSmxqfLmoB0cnu7Q5qU4HxmkofyDBiqja3koRVrJcVA0h9AT3ZVAl2ppYdszgR8507gshg0ZFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674795; c=relaxed/simple;
	bh=+eClkX/OwG5NWuqH7xbRg86sr1a+CjLJ8zImNcXKGIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bSXMSYDt78Vcho1yKAvm0mKD4TCCwfRqgQzzCdhEUpjBtW2IO6ClKCFjZduz8HYG33h8hpRoD72fSrS8mYjnYG59UiW2Xlrg9IiVsm/ox5M9xhW69H9j41xJIcWg62yImrKiE0UDEehVuepLf89KYcfI0mrnYijZZ5NDPtvgTZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tIXPPnnQ; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712674792; x=1744210792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+eClkX/OwG5NWuqH7xbRg86sr1a+CjLJ8zImNcXKGIE=;
  b=tIXPPnnQx+lgj+H1oORF2UG0ZYVgSmtj66XOgvYKDh6eCbhC7vVJHhci
   FrFFAeN9q+Dsv1DWNKeu9WPV7u1yfnU21PC8kfJg41SR68ZD66cWTNx0X
   oDShAW5ck3Cii9xjY32hBeF6/cCWCWfBs3TXfhk153winvKtgp5YfOSEl
   Mdut11v0m1y26b5dNBJzdzpLnoU+oRW1JE3aCdfKyQocOyj9b6iUQgRir
   7tTN6lzMCwzXfqYoP2uoXixcC480z6BacqDSPZ8aIwyadjHMZJ3ZwlxbN
   4B55T9jKH8aLJPWxOiqUEK3NJ13oPNVMqYJ+zhsVEJi0S2o1kVrKIc3nh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="116209586"
X-IronPort-AV: E=Sophos;i="6.07,189,1708354800"; 
   d="scan'208";a="116209586"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:58:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK+yHrmU3RqWH5dksJ3A/y0wFzE0yUGJxLEq6CrnpZ1VhpehngzkNgvZvx4plXB5chu0vFGDqagUwLVX7giab9xwDiG02awctZ3pADqyR3C54DYu+5j9JzULE8Q8+fHt6E9jkhjE0LBy6vKFgTreYoR5U5fyZ25W2XQPtf1H31icQ6He2B9NoK+MjVp5+C07I7cLn77DMOA8bwX9+dKNUL22d1ZQSzTddos5WM8W5dXIGssPREQ0xYwDZ1cKMzvovUJTD7Tm8NM1dT2fMOOrpEXJYjOn9qlJw2SfGwonvMiWDy0t07X/cwbtbagR7fo7YCk+aJNLHudlzHeufvW1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eClkX/OwG5NWuqH7xbRg86sr1a+CjLJ8zImNcXKGIE=;
 b=TKgMn3m0ujjoMsf7AYzoduTVfPxo/rB0qQv2XIWINBQT86zJrDmzEXBpJdK30QkLRc1NGvU0059R/pXbE3pua/CzjaWTarsE9ZnQlj7vIXu46Ml0VDjlasOk5+cJM2V9M81cWXc7fI7OeehSDxlItEeANxsYLg1jaDnj2izVdBGTwiQ0V8j1woaiI92KT0DeeQ2wyn3+8k8oWto+aiXDmyrQ46CWzLUaBIOeABS5sBvBu0UuqBMdanRHBYk1oqv4ZF2W250jOFiEsylOVR0t/HZ0IyqP7fnqbNkxC5leLGAiovUPP7hpRNAUUOyc1AjJT+4WrRvw0gwaZ9t8FgSf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYAPR01MB6347.jpnprd01.prod.outlook.com (2603:1096:400:a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 14:58:36 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 14:58:36 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Anna Schumaker <anna@kernel.org>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: add tracepoint to referral events
Thread-Topic: [PATCH] NFSv4: add tracepoint to referral events
Thread-Index: AQHaiZp9lfGVe+PqZUy1kvlTxaKabrFf79KAgAAZwvA=
Date: Tue, 9 Apr 2024 14:58:36 +0000
Message-ID:
 <TYWPR01MB12085126B7EAFAC2DE3B40A14E6072@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240408095052.367-1-chenhx.fnst@fujitsu.com>
 <CAFX2JfkF62GvP_DUpji1SKor6vfLhYqrwiK5ZNWevV_6f-QLfQ@mail.gmail.com>
In-Reply-To:
 <CAFX2JfkF62GvP_DUpji1SKor6vfLhYqrwiK5ZNWevV_6f-QLfQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTAyZTZhNmYtMmI0MC00MzY4LTlhM2UtMzIwNTQ3YzZk?=
 =?utf-8?B?OWQ5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA0LTA5VDE0OjM5OjQzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYAPR01MB6347:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rOtN0dAovPx6q8EiZ2YNpHWk1kLJVQJlaT6KNZeDoJjvXU9RLBiak2UYEQP4lwoJCS69dRuJFnexXvsiN7APIKLCqbb/cSwFBsGENjrNxhpskISruNORee6dIz315Vic9zn7wAV0bcSQ1jIsW0MdyoA4jnURODNTRdkD7QeILCi/TX9kBYPQWdMwJpXwWmdcCHeJuwr2ePZMf4fqeO17dCWaitIZ/eS2XS2qr4lbMJR8ztUrrW69DhliEmYK/OZMOkKE8jCcqxPqyRjBfs4LS5VQ0bxzknzz81xt/+7dCT/AObgOabra65bIY1me0BT/h7GRMyHn9vj8TxsbpoF2NrNiwvxDbX9Ype+H2V+gB6LNGRfT5jWktYSbUHWX+lLdH+FkFx12uhmuCVcZ1bnUbgJ4D3oW1IVUhq1puRV9BitqR1nxV0RUD5KzORF5MZP5r+MrLvK0Rc1z5WOq1PEiVqEe6kUDQVkI4I3Nz7AjH1ZhMN+22cNlwJ8soYBEVEZzVXd2Z8edaii8j8CGf6NYWBIOHKCtJSFvAZWvVHcIurDWpTZxac+Cdjue4w3ZdMdQwIPLkG7JFDQhxaELl6N8g0LkfNSXx9L7/7sJcp5J/qZ3cxXJe0QAKnpbMHAfY+vLqK+Sypk7nq9zM9l2q6771DJ7ZgXg49Fpsa/PXBSDekjPgPH3vnfmWNB2WM8vk3aOc1Gpq86XwT7B7g80Vhzcew==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEY1SUNNblRMUWJsR3BNK0FJUjNLL0kwYlRvNnYvbGwyZHpOdjhoTWYyOUdh?=
 =?utf-8?B?eEszdVQ3d0gvbDhEZHVueVVCQ2kvM1hOQlNSRWRPY3ZEQmZNczNHNXhYZEZS?=
 =?utf-8?B?cnQ4bDdaN1ZpRUZVZDBuYkhpQ2J2ZEc3aTljQUFTN2tDdThtZi9JNXNtTFB5?=
 =?utf-8?B?UEsrMTBRUUxCMFFldkJtSmMwWnQwVjIxbGhrWC91YjR5WlBqQVVNV2hiMWRu?=
 =?utf-8?B?VXoyU0hlSjl3UHdJUTFQVUhPTzV3ZHpaWk5KTVdNTkZ6djN1N2ZIbEE2dHZi?=
 =?utf-8?B?REIwclVtRS8xU1Y1VG00YnJ6OFFlSG5ETEJ2ZnhaZDdVNTRjemZmQUlRU2M2?=
 =?utf-8?B?WlJvQ3BMZERjbEJicFZkY0E4cklsaG5SWnZIeURIVExTNUVBd0JWOTVEcElN?=
 =?utf-8?B?aVlqcmRFbjVkdUFxNlhsRVlIR0V4azhSWEw4algrUHRqbHlKTmNZRUJtNzda?=
 =?utf-8?B?dVV2SS8rME5xRGdxdDdEV3J6NnhKUldSUEZVSXdTR1VUUHhLcFZJdHQwTjdR?=
 =?utf-8?B?NmMyTXZtbEhFeVRURGtqOGNRaldVZWJkekZ4RUw2ZWx4MExnM2Z1OGhIZUZC?=
 =?utf-8?B?OXVVSitnRFBidDhRWHRRc04zZmsxbXhEaHgvK2Y5QXdXSDg2VFNLb3hnTlU5?=
 =?utf-8?B?dFRVRGYvYmpjdnUwZnM5YWIzTmVjTmpOMjQ1K2xHMEJPL0UySEhramNmZTZ6?=
 =?utf-8?B?WnlNblBQVTY2M2ZNdlJreHMyOXNTRUo3bG5ybStkWGp4MExCd1k4cWprb2hW?=
 =?utf-8?B?YzRVWWZTS1NRcHBXU0J5SllLZ3h3MHRJRWx3VXFwM0xwVnY3eUJ6Tm8yeUVN?=
 =?utf-8?B?VThKUDBSNGttRjRRclljUFVaekswTWU4ZEMycFF3cHhiUUxXQS96UDBRSkp5?=
 =?utf-8?B?Tk5BQksxYVVUK2FJOEYwdEtCcUF1c0FkMVdFd2VEa2EyMEgyM1JDKzFyL1BJ?=
 =?utf-8?B?ZEFtQUhMc0x3VUg4K1FIbWE0d0FpWmxrallSSVlBV0pKcUxqbzNzSDJFbE5T?=
 =?utf-8?B?eWhwMmkzSFhKUG1VSGxCcDFpNFpZbzRDek4wTXk0V0xKUU9OTzF2SXVDWWll?=
 =?utf-8?B?VFJiOGltQUNsdVdPK1ZyODhWL2xpYzZESmoveW5YVTF3QStUYzZiOUI1engw?=
 =?utf-8?B?d0VCeDltblhHS0pyUmx1czVJME0rOW8yeDZJWmxZSFYzUWFydmhTU1NJd2k0?=
 =?utf-8?B?QldFcFIvVGlTV3VSSERleXRGVGVvLzlVWHRGb2RvSDc5YmcweTRmR3ZjTEdO?=
 =?utf-8?B?VzZ0UVhrUHpjL29YRkhQbTVmaEFlVEZUWXZNZjh2QmF0RnlKdmxlMUd1VzRQ?=
 =?utf-8?B?Y2dlUTRycXhEMXAwdUdBaVZnVE5VNHpMVEtKYTNsdzNEVVpXcmlnbzMxZTgv?=
 =?utf-8?B?SXNxVXVhcGdVeWZzaDZybGlyR0lvbmxsbjNpMUdxeC9nRHd0Nnd5K0wycmhi?=
 =?utf-8?B?dlliUGZpWlhnaklxQ051eVkxM1hIOTVHMnJzdVVZcnZrYnplSjBNS0J0UUhr?=
 =?utf-8?B?UmFzSVNXVjI0blY2NkFpdEUzOGVWNHIzb0lodnd2bXhGcXJuYmdEdEkrOFZw?=
 =?utf-8?B?V0FHMW01bWRyZkVZL1lVUGdxczhNYXdOblozblBnVUg1TDY3U0hVbE1NVFky?=
 =?utf-8?B?Njd5T1p1UWY4QWxrT21wbjEyREF4WjcrMmtsemVKazhoUHdoNnFuT0IwV0E0?=
 =?utf-8?B?ZjVWc3h2QjVZbUx2QU1NelhnZkpsdi94V0VJd1lpUEZBaWJ6RHkvSlQ2YXZQ?=
 =?utf-8?B?VXBzV2EwdmVWUytIMjhqRDIraStDTzNTcEhhZ3Jxdm1hd3VaSVp1TDdiUnFP?=
 =?utf-8?B?N2RUalBEU2tFVzd1S3JEeEZ3TlJtWFRIblBNM3JGN0FzVk14NGhFSjFTZVdM?=
 =?utf-8?B?VFFCdDdSM2NNYnFmc0ZzM2pKRjF1QWdIOVpnQitGQXRBOWZ3cURvYnZVbkph?=
 =?utf-8?B?NWZBQUhEL3llU0N5UGR1ejhZTU1aRFMyTkVzejV4OWswMzdDY2JxMCtiQVBE?=
 =?utf-8?B?bnV0aFBMRFJTMlZUVjZpL3ZYZXVQVW9razVBVE16UzRIT0pCSDlLQnJpc2hQ?=
 =?utf-8?B?MWxNcGNMMlJFU0JGOFA4YjE2d2dsMksxZVNKdWd5VWRGK1NTd3UvZWdLMUVL?=
 =?utf-8?Q?ZvO2w5fGhcZSmPn5uNzjMH+aK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VbPGPxHkB/fdHXqGbTn328Xhc2KOG7xg4P7+8lpTnXL+IXrUp90NeqfYdE8Rrrpd8NlPv7yuuicpfZeScArjo+OVvljLaX8EB/f//a9wKpys/hW80KaSoEwwWTJLdvlDmYuY+NJGFswmsQt6AHcRew4jmPXr8T0dW1rByvAunp3L69ljhaILapPSiKGdRwC8qPvn3pcNbgDp4FK5N7RdYpwbcTp1Z3wuPKFMRv+/+A1BHJ7BJvFa9OOH+4eyvwNglpAsuQVM33c+WXhSpyNLb/nGcsayXwPdDvxnZAeuDb7xSlqnh840hdpkAn+3qym9gZz3G2BMz6bJvzoJnp0miM+ig8LJU7ts/U8gwYLie4hsTFTXdE6N7QRygQNKaCMayBFECPrNGGKwPhz5u9fjbU4px2muzZjJnUxOfwyhG1ZFHIulQ4+Av2DcUORnGeinw7jn5k4Z2QNix3GoMjypkm2rlVT+SKc5q3q2Y0CQvTfz91cac/0uDG+TcXrJMEb1DmtYVwgHFUUZ6w6U78AKUqRZ5d+eSphi4RiIbeFsKJooUj0Di8nKXYgnf47ef5GqVmyDsChvCjpf1Kje9BtSBhRwerY0mBtBrOH94UytXG2+4x74Ft2olBYIJ7mT28as
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca5a15-49be-4bff-8527-08dc58a58890
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 14:58:36.3317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEZcOJqhD782CHGGbldbt1YWq4h9a7mRzZ3ytDCY4cCq8anDOsSZrW1Pksd3EtGxRhARHf9YmTqBPf4uB+ltTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6347

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEFubmEgU2NodW1ha2Vy
IDxhbm5hQGtlcm5lbC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAyNOW5tDTmnIg55pelIDIxOjI2
DQo+IOaUtuS7tuS6ujogQ2hlbiwgSGFueGlhbyA8Y2hlbmh4LmZuc3RAZnVqaXRzdS5jb20+DQo+
IOaKhOmAgTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
PjsNCj4gbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiBbUEFUQ0hdIE5G
U3Y0OiBhZGQgdHJhY2Vwb2ludCB0byByZWZlcnJhbCBldmVudHMNCj4gDQo+IEhpIENoZW4sDQo+
IA0KPiBPbiBNb24sIEFwciA4LCAyMDI0IGF0IDU6NTLigK9BTSBDaGVuIEhhbnhpYW8gPGNoZW5o
eC5mbnN0QGZ1aml0c3UuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRyYWNlIG5ldyBsb2NhdGlv
bnMgd2hlbiBoaXR0aW5nIGEgcmVmZXJyYWwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVu
IEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9uZnMv
bmZzNG5hbWVzcGFjZS5jIHwgIDMgKysrDQo+ID4gIGZzL25mcy9uZnM0dHJhY2UuaCAgICAgfCAy
NSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0bmFtZXNwYWNlLmMg
Yi9mcy9uZnMvbmZzNG5hbWVzcGFjZS5jDQo+ID4gaW5kZXggOWE5ODU5NWJiMTYwLi5mY2E5ZmI4
MDFiYzIgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL25mczRuYW1lc3BhY2UuYw0KPiA+ICsrKyBi
L2ZzL25mcy9uZnM0bmFtZXNwYWNlLmMNCj4gPiBAQCAtMjQsNiArMjQsNyBAQA0KPiA+ICAjaW5j
bHVkZSAibmZzNF9mcy5oIg0KPiA+ICAjaW5jbHVkZSAibmZzLmgiDQo+ID4gICNpbmNsdWRlICJk
bnNfcmVzb2x2ZS5oIg0KPiA+ICsjaW5jbHVkZSAibmZzNHRyYWNlLmgiDQo+ID4NCj4gPiAgI2Rl
ZmluZSBORlNEQkdfRkFDSUxJVFkgICAgICAgICAgICAgICAgTkZTREJHX1ZGUw0KPiA+DQo+ID4g
QEAgLTM1MSw2ICszNTIsOCBAQCBzdGF0aWMgaW50IHRyeV9sb2NhdGlvbihzdHJ1Y3QgZnNfY29u
dGV4dCAqZmMsDQo+ID4gICAgICAgICAgICAgICAgIHAgKz0gY3R4LT5uZnNfc2VydmVyLmV4cG9y
dF9wYXRoX2xlbjsNCj4gPiAgICAgICAgICAgICAgICAgKnAgPSAwOw0KPiA+DQo+ID4gKyAgICAg
ICAgICAgICAgIHRyYWNlX25mczRfcmVmZXJyYWxfbG9jYXRpb24oY3R4LT5uZnNfc2VydmVyLmhv
c3RuYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+bmZzX3NlcnZlci5leHBv
cnRfcGF0aCk7DQo+ID4gICAgICAgICAgICAgICAgIHJldCA9IG5mczRfZ2V0X3JlZmVycmFsX3Ry
ZWUoZmMpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0ID09IDApDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0dHJh
Y2UuaCBiL2ZzL25mcy9uZnM0dHJhY2UuaA0KPiA+IGluZGV4IDEwOTg1YTRiODI1OS4uMTY1YzRk
YzdiNWM3IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9uZnM0dHJhY2UuaA0KPiA+ICsrKyBiL2Zz
L25mcy9uZnM0dHJhY2UuaA0KPiA+IEBAIC0yNjA0LDYgKzI2MDQsMzEgQEAgREVGSU5FX05GUzRf
WEFUVFJfRVZFTlQobmZzNF9zZXR4YXR0cik7DQo+ID4gIERFRklORV9ORlM0X1hBVFRSX0VWRU5U
KG5mczRfcmVtb3ZleGF0dHIpOw0KPiA+DQo+ID4gIERFRklORV9ORlM0X0lOT0RFX0VWRU5UKG5m
czRfbGlzdHhhdHRyKTsNCj4gPiArDQo+ID4gK1RSQUNFX0VWRU5UKG5mczRfcmVmZXJyYWxfbG9j
YXRpb24sDQo+ID4gKyAgICAgICAgICAgICAgIFRQX1BST1RPKA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IGNoYXIgKmhvc3RuYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKnBhdGgNCj4gPiArICAgICAgICAgICAgICAgKSwNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgICAgIFRQX0FSR1MoaG9zdG5hbWUsIHBhdGgpLA0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgVFBfU1RSVUNUX19lbnRyeSgNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBfX3N0cmluZyhyZWZlcnJhbF9ob3N0bmFtZSwgaG9zdG5hbWUpDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgX19zdHJpbmcocmVmZXJyYWxfcGF0aCwgcGF0aCkNCj4gPiArICAgICAgICAg
ICAgICAgKSwNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIFRQX2Zhc3RfYXNzaWduKA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIF9fYXNzaWduX3N0cihyZWZlcnJhbF9ob3N0bmFtZSwg
aG9zdG5hbWUpZQ0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl4NCj4gSSB3YW50
ZWQgdG8gZG91YmxlIGNoZWNrIGlmIHlvdSd2ZSBjb21waWxlZCBhbmQgdGVzdGVkIHRoaXM/IEkg
YXNrDQo+IGJlY2F1c2UgdGhlICdlJyBhdCB0aGUgZW5kIG9mIHRoZSBsaW5lIGhlcmUgc2hvdWxk
IGJlIGEgc2VtaWNvbG9uLA0KPiB3aGljaCBteSBjb21waWxlciBjb21wbGFpbnMgYWJvdXQuDQo+
IA0KTXkgZmF1bHQuDQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCBnaXZlIGEgIldoaXRlc3BhY2Ug
ZXJyb3JzIGRldGVjdGVkIiwgDQp0aGVuIEkgZWRpdCB0aGUgcGF0Y2ggZmlsZSBpbiBwbGFjZeKA
puKApg0KVGhlIHRlc3QgbG9nIGlzOg0KICBtb3VudC5uZnMtNDc4MyAgICBbMDA1XSAuLi4uLiA2
MjczOC42NjY1ODA6IG5mczRfcmVmZXJyYWxfbG9jYXRpb246IHJlZmVycmFsX2hvc3Q9MTkyLjE2
OC4xMjIuMjEwIHJlZmVycmFsX3BhdGg9L3NoYXJlMTINCiAgbW91bnQubmZzLTQ3ODMgICAgWzAw
NV0gLi4uLi4gNjI3MzguNzI4MDQ3OiBuZnM0X3JlZmVycmFsX2xvY2F0aW9uOiByZWZlcnJhbF9o
b3N0PTE5Mi4xNjguMTIyLjIwOCByZWZlcnJhbF9wYXRoPS9zaGFyZTEzDQoNClNvcnJ5IGZvciB0
aGUgbm9pc2UsIEknbGwgTkVWRVIgZWRpdCBwYXRjaCBmaWxlIHdpdGhvdXQgY29tcGlsaW5nLg0K
SSdsbCBzZW5kIGEgdjIgc29vbi4NCg0KUmVnYXJkcywNCi0gQ2hlbg0KDQo=

