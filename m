Return-Path: <linux-nfs+bounces-2691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700889ABDB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660A11C20945
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25913BBC1;
	Sat,  6 Apr 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bKvk27wl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168F2943F
	for <linux-nfs@vger.kernel.org>; Sat,  6 Apr 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419385; cv=fail; b=HOiiXRyVLStnHSFTLZdDcpKcQgpk+mrU4B5/xozMozvet94oxDT487nGGxwEF6OH+hSs3FxgKHy/7wv0mmJ0Ycu2r4vN3JhVnDMmJrxBqcrj2Kyq0xY/ysPxRlHuS77v8O0aCFCvlHhRLpkjqwnYHDyWBW8qPNTiIfphqZ/rFjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419385; c=relaxed/simple;
	bh=bJNsEb96O0XFigtBiDI2B1lb4nya6sRhanfMulxraf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D3AcmZPYStfG2ZfA/Uxsn3UA0xG+sDV2ZK5KMMUQgiyimkZG3ti0zPDbnMJgaqEz2sYpqIGYeh3kTiWBG7Nuy+4bjxxjkYU9huruCdd5pEoppo5R7JZxY1elMXUjrHGL+oNu82LgHGSPYoZx4Ej2/DwugobHvdlHHZQo7S3hevs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bKvk27wl; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712419382; x=1743955382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bJNsEb96O0XFigtBiDI2B1lb4nya6sRhanfMulxraf8=;
  b=bKvk27wlHFM7zs6KtKGSRBL4Nz/28X89BQ2UXW43QCp/gahmlIj+KuJd
   HOzdAaT1jQKyz4w72e2XEsEVCBNf9i+OXiVzcv59NzCvwJvzHqhs7uEkD
   2wkQJhbB/VHWjjA+kr+/9Fe25WfK832Eya9Djfz4gMAYycG+sQHLJjGb3
   Zg2w/7fSfKHxSyRQBaSvZkcnWe6hlvvSpvCsN3ch/2sNU/KMmf9+nG8jG
   5zq+IbKMMjuyS9LHsgH1F7BPMubaEko69DnEgKxqC4fcKBTSfNe2G36qv
   oRfS2rMsa1o3I0uvxuX0zQXOcTFrCLquq31241A6CAe4fIbMGcOBGSCpY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="116915239"
X-IronPort-AV: E=Sophos;i="6.07,183,1708354800"; 
   d="scan'208";a="116915239"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 01:02:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+OqmSi/34uNOMz01F8GX5qOrt3QrDGHh+ep+wzYKjgEYuHK9MiI5RlsOWg76uO/YqtjKSi7K07FUFuIteJVYpbYNdHpOnEJAYIB42BHY+rmOBK6sQVkumr/cp6W6AA1uiQ++EJjHAo6gj4lFW/XOKHE5IQ+PJU5R8EN+8iY5T3ZOfOb1PAl5viIV6s1qNPza8EXCowx0HMm6gKKax9WfS7n3UTdAVRO3lq3l1AJ0suin1TfONAWouwPStzpOL7AQ/595bhYOFqXUk5+jmgPV91EsUnhQTSCgmJR9P5CWMMCXfW+Fm7ryCH2+7ZeCVyDEPcAET49zKp5gU/3bBRTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJNsEb96O0XFigtBiDI2B1lb4nya6sRhanfMulxraf8=;
 b=O0/hB6XZemle9FF0Pi5xtsdIa9iVIBNnce00Tuv2zc+Bw0C5R3EfpcgkzVVPScpZfv49umNpQ7Hjexsy8WphuJfZI/4TCpqZfkQoLgA/ysD4ZYcxY2i7YSFBd/8VwR7AlTb35Eb0ZfD078Se+FQnEL9C2mTt/i7bieaMD8aP0j/3UIrKd9OaH4b8sXkikWiuP0N6lbJtdHWnpm7sN2zfiJxOF20KzTkUG5BfUTOZQQHxBckY/SZq2fQyOYYXWihfzuznk4BC1ws/x6Dk7kX/wK9FStl5bawu650A0UmQUhycr0iCMp9ktL28fbMZoSBSZA3H9I+r6OtTLN5pSaR9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by OSRPR01MB11504.jpnprd01.prod.outlook.com (2603:1096:604:233::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 16:02:48 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%5]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 16:02:48 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: trace export root filehandle event
Thread-Topic: [PATCH v2] NFSD: trace export root filehandle event
Thread-Index: AQHagSt0e+Xz1sGnj02hKF9PSxk9fLFaDNYAgAFfQmCAAAHlgIAAB2fA
Date: Sat, 6 Apr 2024 16:02:48 +0000
Message-ID:
 <TYWPR01MB12085F066DD27503AB35C1596E6022@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240328161654.1432-1-chenhx.fnst@fujitsu.com>
 <ZhBDsqxNnj+b5iRg@tissot.1015granger.net>
 <TYWPR01MB12085681A09D7DA36C4114F93E6022@TYWPR01MB12085.jpnprd01.prod.outlook.com>
 <21A5DF99-1FEA-41FD-B569-FFA45EF59A7A@oracle.com>
In-Reply-To: <21A5DF99-1FEA-41FD-B569-FFA45EF59A7A@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZGQ5NGIzOGQtNGM3Yy00NzMzLTk3NjItMmE3NmFhNjQw?=
 =?utf-8?B?MzEyO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA0LTA2VDE1OjUxOjIxWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|OSRPR01MB11504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EgqmbaxKJcSpPmbKMeMJGcs4OQjSagF1OQyZBys5mHY64PLuyI6d7CPGVJ50e7bzgaEis0z7YWjKfJ1Gs663wAmin+/DpiUbPO8pED1bF/cvLx8H2zOY9d1CKnUED56//Lw/lNuqpUolYyZ2KXrtGw7S+PZofuPiw+ih6zjgbO4eTCgnueUSypPyz+svIbF8GbgGhqL/VUovh2ayF+H1pGQDvSMRNXS8Ea2NlwUzLnMbd18C60Sxv2JORt/Db2TQyZsfIWd9QSJE+gfrl+l4wHiBh7ydROVnrF6zYvoSkz2Gy/9Vd2hb0+kywewNxG009ANr8Oq+E/JCYcPioCATTa6uIKmQ9Yn5LccjAEdfQcObxoEMCRitjhgaw2JEUL+PCgaxtJ8u5dNBcxN6+EQa3luLf/tWJ703Yt44P5RTPw4EmyxjlhqG8pDEmtV0qLRIZN8RDGf/Ek6WqQwIgUUK5EX6aNBqxxZWP0F1ohXh2rGKQ8Ttn/tLqmNAILDm71MKC8GgbJhOouZo2wZWsWj1mFMJVd9LuqwDfOg6hvC3mRlZu0moj78aWINJEFUgb575WUQRgH5eeilJyD6H+Prrk3Cu0XTx1PbQBuBa+OzKCN0FoMqkG+L0RkZ6EYXlkAtRtxlUfzlQQchLi4i7LKQnZDtw9b13lfJutLR6XyI1g27GYbAtLzxrBLxLSNyjRTJQ5CzIgEapwZelJpbDxSAo9g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkExcFBJZVQ3UXZHSXhScjZ6Zm1OdnF2ejZrN2d2TDdMWXpiZjlkQVVoYXFh?=
 =?utf-8?B?STcrK2piTUcvTnRDdU9hM0M0ZTdjeFhvT2kzaFFCdVJJMFFKaWVZRVFXaUEw?=
 =?utf-8?B?SEJ1Z05SK1VoQlZ2a05rVVVKYjAwRWVUbVZTR1cvNHhLcnRxSkVMUTc1THlw?=
 =?utf-8?B?TSt2WEErQ2cwbXBZWVpiOW1JdDZQZmRlTnJvc1RtV25NS2d3UnExcDBsamt2?=
 =?utf-8?B?alM3VHZhSU1iK0Fac0ZxTWNUTjZhc0RacEZ3VkN3SHBFSTg2a1lJbGZobWJC?=
 =?utf-8?B?YU1PMDhsdnpvS1FjVjJENGpsbWVmekU2MWcveHE1bk9KcXEwdEt2NFBja09v?=
 =?utf-8?B?bnQwZWtjZkxHWHB3WHFwbm9wNEp0K0N1UEFVVDlncEFWODJlQzhpTGJmL2I3?=
 =?utf-8?B?d1BFeGRsZzF3cW5mMzhqTWRacFUrdm83NGdIK1k5WWRmK2pBaUpnMUNKZm9x?=
 =?utf-8?B?UDQydThlYktPL1Z6Z25mM2l4NnR6WUJEY3MxMWk5aW5yR2l4ZXB1MThHTEM5?=
 =?utf-8?B?Y0JhTnVGSVJmRkpYVkNHbmZwYjRiUER1b29qTkpnVGtPZkRqeWNhbm9HWm5Q?=
 =?utf-8?B?RGpyRC9wSmtYWGdkc282WFZMWi9pMEpKTkg2dW43bEh2M2R3RWJZZnQ0VnhM?=
 =?utf-8?B?dlFjdEViUjZqSXBqT2Q5SmVWMmVxQ1laRmZTbGhPVFJrcXIxWkp3bG5Lak9m?=
 =?utf-8?B?Zk1DVnBUMW0ydjNEUEtOOUlxT3hBWlArVlBUMy9BZ2dHMlM3SmVkNmxjcXg5?=
 =?utf-8?B?VE02OEJjNFN5OU9EV2cvelJhemo3eHZ5L2hJS3UzSXkzQy8xd3FLTTJUV01m?=
 =?utf-8?B?KzMrRVE3OGJNeVVoQnNpaEl0L1ZEVGhnYnRRMjE2TUwwdEM1NnVCYm1NVWRa?=
 =?utf-8?B?U0d1cXBoWGJNbWVQa3pLNmhUcUJEQUprdGx3V2tSQ041VmZ3Vkl4YXpvYmJp?=
 =?utf-8?B?S2tpUnpnTUQvNUVmL2NKZW93cGJydGUwZ2pxbjU0T1dKQ2pjcG1OZ21Gc2Ri?=
 =?utf-8?B?VFBwcmpuRlR6Z2dnU0ZVbHJJdFFnc1VOMnFwc0ZWNmdPR2NQMllHRHdLZWFn?=
 =?utf-8?B?bWowRTZVa0NWYS9XVlVxUVFrWVFsR1NuWHFCbjVTeFFrOSttQmhLRUFqSEU2?=
 =?utf-8?B?VjRqdTZKQzROTU9hR09Hb0d5eHdSbERvQkFxaG93VW1KRk5US0hsTytJMXBv?=
 =?utf-8?B?a0gxczVWMnBTa2wvQzVTYzZ4all0cWorVFBkS0x1SWtxRk41R3lVbWNBa2lr?=
 =?utf-8?B?b1dIUUVvS2lpcHk3TmFhRSs4N25RMEY1ZGQ4MXBZcUpkUVNqRTYzME1PV1FG?=
 =?utf-8?B?aGlBMVlWQksrS3hCTlllQXRWNlJEelA0WFBlNzFtMWFkeVNVQzA5djBNM3Bt?=
 =?utf-8?B?RTh5ZjFITE1iYnBMZUsyYmVWT2FyQjcveVhuaW11UFFNMFNSSnlJV3MrUnRC?=
 =?utf-8?B?bnI2cUVDWmR5MUFnUFV1N1ViaXJYR2RMQVVJMzdmOW8zYU1FbVBsQUpXNEZW?=
 =?utf-8?B?M244NDJNcmw2OUhqSE1FTUZqT0diOFVOc0xVdVFUb0RheW9EQVdTZ3liUllR?=
 =?utf-8?B?cjd6M0UwY1kzcUkvckNPVk9uRDBNdDByV08rZDJ2V0JFNkJNWUVXci84c1R1?=
 =?utf-8?B?TCtaZ1NBL3VQMytSVTZmdXdvdkIwN0lNY2kzTUpjdm1ldnRQTXlBNnYvcUUr?=
 =?utf-8?B?cllsbGg1bE90Z3JVbGcrby9NVTI1ZzM2UXUwOEs3TmRrZXVza3p5dTFpZ3Rj?=
 =?utf-8?B?VUFNZ0tWelFkbkRtZ21vRDl6dTZnL3Y4dmlkYW1VbUJ6Ui8rOGt5d1pUc2pJ?=
 =?utf-8?B?L3dJR0dkWitaRlY3eGRyMHRmVk1CKzVjUnJGM1B4RjU2Y1hzSW9CMlp4N3NL?=
 =?utf-8?B?TnRTNmpZU2JCbTZxOERPMHRKQlhaNGY0bFVhQWRaMEJrdVNLTGI0T0h4SnFl?=
 =?utf-8?B?N21oSmlKV3RoRXZ4S3pvK29mOEFMdEpUUXJHTHdpTmszaTNXSSs1STBRNjhs?=
 =?utf-8?B?S2luVFNJVERaSnZZVnZYVkZRcmV2WGlrSGdLcUFsMEY1RHRpNTMveVNOdVFM?=
 =?utf-8?B?N25GUVJjV0UxeVpSVjlkUTBLU3NzMFVtYlZuRUZzWDIySUV0ZmtKclN0aHlU?=
 =?utf-8?Q?rO7wLYhZhTW0NwUXe+JYc+4MZ?=
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
	YY/T3E8Mv1VFNn2YlmCYP8wq7dKChzgVK3e6DCyoCt1FCFDBWWdam1r3LD19VhUhqoPBrO4fQzQHKkJ8nMlBakTBcCghmkFv8xJIb6upOFw1uuzfKJZ8t+gzYqLJLR/bQR4dJODUGiPTubvLVSTM8OcLUZHywy3PZG62ZlVoMy9taxVa82ziM0T/prPYRuVs6meQLUW5p5hrLX4fKvCsQDkgxOW4l5HOv1wFxk3pAkHFA8u9KP+UiW/zhNvdcBv3vPIDxs2QcwEXI00CYLHD+MqW2VU9htSEoKh3WKzA6fGY2zs2xl/oyHjHkeyBF1vI4+YGr3iDq87Tp5plKMnrurXXl9UP594wOaAsUe5U7GdDFiTV/uEEyr//FKOwepTZkX12dRTQ5mgYBk0wsWuWPpKl+jtaTfhAwkORWaMZRkJkI1+ZqgQHSTOTNi4hLpIVZHNgejY6HGWNyKIneh2sm5d408Gwimf6wdQlI/y4me1MpvhSNx0kkDKAMnqBVyRoyCAv3VW5JaATNYAso6CVp/R1EOw0NVGj/zx9KQl9/naoSHMct2Q4m+4FehzV2rcWapXR+zd7RTnC4SWJPrrj8QN40mbJ01daAzktJ1hHgONFnSxSf8vHq2QGd2PBf1J4
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc06cabb-1c20-4eea-28b4-08dc56530156
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 16:02:48.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IU7XoKmisvvvjBgrMzFyCsOATnQq2/bhQjt3Fn+lADkrqGgEdOtNL1Qbf8fW+yq8RiqHhcsOJNwzKiEr7RPoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11504

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IENodWNrIExldmVyIElJ
SSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0NOaciDbm
l6UgMjM6MzYNCj4g5pS25Lu25Lq6OiBDaGVuLCBIYW54aWFvLyA8Y2hlbmh4LmZuc3RAZnVqaXRz
dS5jb20+DQo+IOaKhOmAgTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz47IE5laWwg
QnJvd24gPG5laWxiQHN1c2UuZGU+OyBPbGdhDQo+IEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBw
LmNvbT47IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT47IFRvbQ0KPiBUYWxwZXkgPHRvbUB0
YWxwZXkuY29tPjsgTGludXggTkZTIE1haWxpbmcgTGlzdCA8bGludXgtbmZzQHZnZXIua2VybmVs
Lm9yZz4NCj4gPj4g5Li76aKYOiBSZTogW1BBVENIIHYyXSBORlNEOiB0cmFjZSBleHBvcnQgcm9v
dCBmaWxlaGFuZGxlIGV2ZW50DQo+ID4+DQo+ID4+IE9uIEZyaSwgTWFyIDI5LCAyMDI0IGF0IDEy
OjE2OjU0QU0gKzA4MDAsIENoZW4gSGFueGlhbyB3cm90ZToNCj4gPj4+IEFkZCBhIHRyYWNlcG9p
bnQgZm9yIG9idGFpbmluZyByb290IGZpbGVoYW5kbGUgZXZlbnQNCj4gPj4NCj4gPj4gSSd2ZSBo
YWQgYSBjaGFuY2UgdG8gbG9vayBhdCB0aGlzIG1vcmUgY2xvc2VseS4gSXQgdHVybnMgb3V0IHdl
J3ZlDQo+ID4+IGFscmVhZHkgZ290IHRyYWNlX25mc2RfY3RsX2ZpbGVoYW5kbGUoKS4NCj4gPj4N
Cj4gPj4gU28gbGV0J3Mgb25seSByZW1vdmUgdGhlIGRwcmludGsgY2FsbCBzaXRlIGluIGV4cF9y
b290ZmgoKS4NCj4gPj4NCj4gPj4NCj4gPiBIaSwNCj4gPg0KPiA+IHN0cnVjdCBzdmNfZXhwb3J0
IHNob3VsZCBiZSBhIHVzZWZ1bCBpbmZvIHRvIHRyYWNlLCBzdWNoIGFzIGV4X3V1aWQuDQo+IA0K
PiBUaGVuIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBuZWVkcyB0byBleHBsYWluIHdoeSB0aGUgZXhp
c3RpbmcNCj4gdHJhY2Vwb2ludCBpcyBub3QgYWRlcXVhdGUuIFdoeSBkb2VzIGEgdHJvdWJsZS1z
aG9vdGVyIG5lZWQNCj4gdGhlIFVVSUQgYW5kIGV4cG9ydCBmbGFncyBmb3IsIGZvciBleGFtcGxl
Pw0KPiANCj4gDQo+ID4gQ2FuIHdlIG1vdmUgdHJhY2VfbmZzZF9jdGxfZmlsZWhhbmRsZSBpbnRv
IGV4cF9yb290ZmggLHRoZW4gYWRkIGFuIGVudHJ5DQo+IHRvIGl0IHRvIHRyYWNlIGV4X3V1aWQ/
DQo+IA0KPiBObywgdHJhY2VfbmZzZF9jdGxfKiBhbGwgcmVwb3J0IGluZm9ybWF0aW9uIGZyb20g
dXNlciBzcGFjZSwgc28NCj4gdGhleSBiZWxvbmcgd2hlcmUgdGhleSBhcmUgbm93Lg0KPiANCj4g
SWYgd2UgbmVlZCBtb3JlIGluZm9ybWF0aW9uLCB0aGVuIHllcywgYW5vdGhlciB0cmFjZXBvaW50
IGNhbg0KPiBiZSBhZGRlZC4gQnV0IEkgaGF2ZW4ndCBzZWVuIGEgZGV0YWlsZWQgcmF0aW9uYWxl
IGZvciB0aGlzIHlldC4NCj4gDQo+IDxtb3JlLWluZm8tbmVlZGVkPiA7LSkNCg0KVGhhbmtzIGZv
ciB5b3VyIGRldGFpbGVkIGV4cGxhbmF0aW9uLg0KSSdtIHRyeWluZyB0byB3cml0ZSBwYXRjaGVz
IHRvIG9idGFpbiByb290IGZoIGluIHVzZXIgbGFuZCBieSBuZnMtdXRpbHMuDQpUaGUgZXhfdXVp
ZCBpcyB1c2VmdWwgaW5mbyBmb3IgdXNlcmxhbmQgdG9vbHMgdG8gaWRlbnRpZnkgd2hldGhlciB3
ZSBnb3QgdGhlIHJpZ2h0IG9uZS4NCklmIHRoZSB1c2VyIGxhbmQgcm9vdCBmaCBwYXRjaGVzIGlz
IG1lcmdlZCwgbWF5YmUgd2UgY291bGQgZ2l2ZSB0aGUgbmV3IHRyYWNlcG9pbnQgYSBjaGFuY2Uu
DQoNCkknbGwgc2VuZCBhIHBhdGNoIHRvIGp1c3QgcmVtb3ZlIHRoZSBkcHJpbnRrIHBhcnQgaW4g
ZXhwX3Jvb3RmaC4NCg0KUmVnYXJkcywNCi0gQ2hlbg0KDQo=

