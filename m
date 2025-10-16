Return-Path: <linux-nfs+bounces-15287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E3EBE3C41
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC75188D627
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A809339B31;
	Thu, 16 Oct 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IB9tKruu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s5nA2XpA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA57339B2A;
	Thu, 16 Oct 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622102; cv=fail; b=lMHopwtstXP91qs5/Tye+YzidAo7VIBexYsOd75Q4+aSlQ+YhWmYdT/heeSNKpq5Y5HwCfvE++3B/Atpm/9iMKYo7gFURU8k+g8+kQlNMTVgeMCdn5njWspPf/1B4nRcDw3iVD/0bLGe416TyP72CVsvBNiBQU9qvKWmMGi9unM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622102; c=relaxed/simple;
	bh=05VZdfG89yH6YnxF1NYn45I/TDZ/b7NIDP9GAH+Pxzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTYPnrgcxgsoKtaOzsvZAW5wunvnKu5Qc6Mx6REOd+JVSONe55qf8vvgXYA2U0tUPUMlla+8/PYl7xtFXowXDWNfqW+clm2gYF8Q0tLTGD3ttI6WuoWI0Mo+KL/4VjxVBoFILS18QGFqt26k8dsgYBODxo4AZXPa/gwVap1KFn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IB9tKruu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s5nA2XpA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDbtfN012304;
	Thu, 16 Oct 2025 13:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jYNLbImN4WUXlafG+FyRfqP4LXo81NsXeidXMRAdQCE=; b=
	IB9tKruucJVeKgeugevTgMvo7j9xEYP0K8C3xuaX6Ag9ejIadynq3fU59HnxIxL1
	4Px1XLCit5PJttOaYTfZFSpFg8t7A8WCfNU2cI0IeAT8LSoI8sTr5KO0kSauqiiF
	pVDKPyhERPsMkjrObgYiGQIryHlhoV3Ev7WEdEfjybi7DxA//KrZebUQ4/i6V+WX
	qiHLyJRrgHLfrKieUsUtjkGjWtt5TEMC4K96x+ASLGdvOF+kMHLR5xd+Oa2IKrHm
	6/hi2QeyYY6Is9fbEIHf7LJlcgBc1ogwXAksEWrVAE8i5gWcsNPyhir0ru6uQjk1
	OFzRbh6T8760LLHV66P6jA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfss0vyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 13:41:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDTuCj017967;
	Thu, 16 Oct 2025 13:41:34 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbg1wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 13:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaLKIe7ykA73egS02dW9VVe2+ADXyB0YrnNvaxXMVvYNvp2vM4++MhVQWm9qQzV38q4v9QKXUivjBWKzvMNtXaJTD6yVfgG7n2EGv1O8AIihfiTvZMNTLdfNX8BtGPb6e4EkrQmt7QTIGgKQII2oxL8ubUcbT4GZoYNInic7oB9JjTpHPf88TldcGCH35BRwC6rcVlOIFLnnbN7l9wi3Fi1YpRk9GP5IKEW/eQ65S39NrVD9lzpr03Alv+IpQPVN2mEZoDqg4QUcMpXGVGCpPvwwgwdmO0nAjgSBasWj9IOvSE0ErqFYLcad6K39i3gf8+TydbKCdacmtFyqHpuOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYNLbImN4WUXlafG+FyRfqP4LXo81NsXeidXMRAdQCE=;
 b=N6nNh21gZ7qLWlOZCUHP8F4KrzN42jWS9WRrhVsxNahQCdZBgz9Tphi7Vt/z1bkHjoKCUx1MH6ORrXyHCypv8b2LFUik/03dlEIePTxnzMXH8zVoxfizbKsWs/BXc3GeW4CJI1uAa0UOB2TBy+xC5+8uz1R4z5UEHSixlKACQXJGnDlthtya4hZVjowGTXPwXaj59Zw9/kVvshE0kGobVNl86Hr7bf60eEEUfGT31OCfH1Tz6zq3xwboiIOOAJcAOgI4WWrYjlRLcd5WxjJTC+jMW7YEuduRojYUePJEBlOo218JRnmbIEI5S5hW8/Ks+0klKeUEoNCBBYoFIudv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYNLbImN4WUXlafG+FyRfqP4LXo81NsXeidXMRAdQCE=;
 b=s5nA2XpA3qNkYzZ0HkqFHdcY+6Yu8GWlvLMwUHcjWnGhqfoK3ZJ2biGrsHfvMZWQ2HkrbjaN+aJZv4uXBOvQYlRy3rAMywxWjzWvNgvMXYaWpCzP0CeXR5pRQWxJBqLBoHnjl6g0NT42o21w5uekXMkO3Ic6SMPUSfEfiUU1Ecw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8040.namprd10.prod.outlook.com (2603:10b6:806:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 13:41:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 13:41:29 +0000
Message-ID: <d85b364d-b7d6-4893-b0eb-3df58ef45ce0@oracle.com>
Date: Thu, 16 Oct 2025 09:41:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251011185225.155625-1-ebiggers@kernel.org>
 <582606e8b6699aeacae8ae4dcf9f990b4c0b5210.camel@kernel.org>
 <20251012170018.GA1609@sol>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251012170018.GA1609@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0059.namprd14.prod.outlook.com
 (2603:10b6:610:56::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d253e14-9143-4af7-abce-08de0cb9b58a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YW9EVytyaHh2NldWQWNYNzZ3MzVwU0hYRzlzVERRZ0NrOWo2a1JMSkg3OTZm?=
 =?utf-8?B?a1VucTEwUHh3azRCU0ZTelpGVUs0T1BjVWlpaG13R3lrOHdLMGZ0U0lBemVP?=
 =?utf-8?B?cG15QUJ6eE9rVmVXME1lMCtSRUlleVJHYUtoRXhhWVZHWVVYd1NiRC9aRFBp?=
 =?utf-8?B?NWxNdkhqTldHZjM4VFI2Y1JEQkRKZmhET0kvRnJHTWthWmgxdDZxRnNRV1V1?=
 =?utf-8?B?eXE3VmI2REIwNnV3QnNBR3NZNEo2Tjd4ZzBiRWs4SlgrVXBwL3A0a1JITXNo?=
 =?utf-8?B?RG9KNDBXYjdkOHFDclY0UVVqK09xTXhoTWxHRDYzMGduZTdwbVJjWUhjWlpn?=
 =?utf-8?B?ME8rUHVOeGtnMXFXdHVCdWsvYm4wbVZCWFlBeFBVMWJ2UlVBMEpNTXR0Ulpw?=
 =?utf-8?B?M0wrdEMwaCtFYzZDTmUzYnRqa1dOUmQ4bnNHaVpBT3RFTnNjT0lxdElDSVoy?=
 =?utf-8?B?dHUzQi9lb01SSVpBbUJYQzhmMWV6TU93eFFaVkJXQTJXTU9XOXd3TEtsL2ZZ?=
 =?utf-8?B?OTJ4Z05MVnlxSVdWVWZsNi9xZlEwbXpsTzR6NkVsVlJhYjd2L2RYbHAzUXZM?=
 =?utf-8?B?OVBoeVFBdzluRFFwbWI4ZHBvRUo1d2ZjZVErNXZ5RTVySkRyVXZWWm1DYzZE?=
 =?utf-8?B?eS9RUVBZdklBK1JMd1o3WUF4cTRyM0h5R2Z4Wi95U21uVVI3bVhRaERyT3NN?=
 =?utf-8?B?WjhNK0dHTXg0R1Z1RHdlWXRkc29yK1lDUmJXQmw4NVRGc1UwYU5sekcvRlpu?=
 =?utf-8?B?SUFYU0xLQ2UvS25PWGZhckhPekNoTHgwRzNjdUwxZjlieEcrOCtteHV2b2dP?=
 =?utf-8?B?RVlmUGYwTUhQdFZ0a0FMSWg0bUNwSmtLNFF5YnRkSCtkUVR1YWNCbk1XY0g0?=
 =?utf-8?B?SG1maDI4a1F2QTNqRDJVZ2RSMGJCdm1teWEyY0NxaEM2SVlQQUdyOThkSjBk?=
 =?utf-8?B?YTFsM2h6czZSZXZNUjltR0RaYm45bFJjNnRKVzIrdUROUXhJSUJ3OUZwZjRX?=
 =?utf-8?B?am9rYkpoZXZtcFc0ZG8welRIV0NIRUQyVTl1anlKa3paL1VRM216MDUrMFR5?=
 =?utf-8?B?ZEJsNjNzSU9NcTBld0tGcnNBYUpxNkIwWUdzMHQ4U3JhRWZXZlloUitXdzlq?=
 =?utf-8?B?dktyQnI3enpQMUJGblREU1k0ZGxCY2hJb3lVYTk1NmJlN2VvZHRlTGJFcUFI?=
 =?utf-8?B?UVFTdUZHU1N6ajdRcDhwM29ETkRBMjRGOTc4MFl3UnV6dWo2dy9COWlsRVBu?=
 =?utf-8?B?dTZTL1dpeFRKQTJ2NFlkR0QvR0VWS3RjaFJNNUxKSjZGZmdQMXNLMU51M0hC?=
 =?utf-8?B?OUo1Ujk3WHdCS1hqYWViNGl1cUxYNW0xSTdCa1VHYU5FczZhcGFQOWV5c0Zq?=
 =?utf-8?B?UWs3dkhWbWZNVnJmOGM5cFNvd0YxM0xoekRFYlZzOXlhOEZzY1d0UjhiNzV6?=
 =?utf-8?B?a0ZrSEljeHBIVjhDeUJkYjdMUEh0akhCZTlBdmxMUDN6S1Zhc3J1T0ZQSUNo?=
 =?utf-8?B?TnhsS1o0dDVzdjAyeUI5SUpFWDU2dWtha2xSZ1ZKcitnczNqRjcyWHZMTWNo?=
 =?utf-8?B?ZWljQldybFBsOGplSFRHWHBXYXk5bUpkS3kvdVljU2NPTnA5L282Rzl3S050?=
 =?utf-8?B?L1c2ZjVxSS90ZmFZWGhGSVFXK1UxaTQ2VGt3eHgza2trZnZZNWs0UXQwczE0?=
 =?utf-8?B?MEsrcnBvb2FiV0NXUGZ0WGRUMjl3Y2UrZ3ZzdEREQzAvRXRHQ1liTVowZ2NE?=
 =?utf-8?B?VHk1Z29lQWdHa0wvNTdGc3RaUldPSVFlL0RxOVd5VzVkM2d1ZFJvWUlXbXVD?=
 =?utf-8?B?NTFGTm91aXpXNk1pYlFTR2REcU52QkI0QUQxaTZpTTJONFpKd1MzSklPbDFL?=
 =?utf-8?B?S2RkV0xoUkRwRWUzbDRHMWhySGtxRzg4ZUhvWDRKRFNacW5iTVhETjRSNWtW?=
 =?utf-8?Q?5gyGclof8ebSzaIVz+lL/FzoXVhi1CYj?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OWpKTUdTRTFHVWd5OFp3OC9FNVhsVCt5S0hOZFBObE1NaGhyZmtpSlpGZEVW?=
 =?utf-8?B?WG1wY0RtNTRIVW80YmoyaTA2ZndwUFhscEpiTTBLeEw5bERPMG1TRjNJUXFk?=
 =?utf-8?B?S1FlRGFJOUZZc0t0RTYwZUlnbG5MNlYzS3NSS1VtaWE0TWdUM0t4ZEVVZGFv?=
 =?utf-8?B?clFoRitUZW1Nam5XUzV2MWlrL1d1ZlJTOVpwYSs1TmJnU2xFRGQ5R0NQSEQy?=
 =?utf-8?B?QTU0WkFBUG9GcnR5L3hDN1JvUXJCWWJkNmVMK29nUlVEaTRtWmVOdDFCQVBy?=
 =?utf-8?B?MlVuTjM0SHlRWEFHQWxIS1FTT2FXQk14SzQ1cWY4bElKb3RyUGY4YW55UDF5?=
 =?utf-8?B?ZDVabGtGK0pYUmRGMFl2czdyZzJzTG5GNGZBanUrak5QT2I5QjBwcHYrSlQ1?=
 =?utf-8?B?c041d3FpOWR0eDVGQzdBRXpMVDZZY3E4YW9pZFVXUlVBWDVON3RWbGV6ZjR0?=
 =?utf-8?B?b1NiZ3ZNWjJlQmgxemdTR2VLOFZHU3ZiSzcxdUJqVURjR1B0TTdOVmRrZitM?=
 =?utf-8?B?R3EyWmVETWhReTNXUFExcEpnRmtERWMyd1dWWWNBSnhGS0traFl6QU4zbi9N?=
 =?utf-8?B?NWhlNE9sWmhOSWVIMGpJclJieWlRYTlNRkd2Uit2S0dIS2IvZmtydW5hbTJP?=
 =?utf-8?B?WVVmNk1DdkhtdFJEelpsdUxxVUlDUW01VTFKcjUrQndjNnJwS09NZXFucFkz?=
 =?utf-8?B?SVdDVGVKaU1ZRXNHQ042U0FxYnBNdzJXUVVaTExscUhNcTgxNVJrOFlKK2Qz?=
 =?utf-8?B?eXhjVUliN3FNb1g5TUU5T3hHMkswMU5NODJaNVNLbDVEZTJBdG5jQTQ5Tkwz?=
 =?utf-8?B?M2g3ZUcvWTZMRXc3NDByaktCSFNJSmhta0dNQTZSdjg3S1RrN1h5VnEzUTVu?=
 =?utf-8?B?RXRNNGdTQnpITkpodi9ZQUMzV2NTSDJETnV6eVZNeE9TcXhmZ1Y5SkNoMFY1?=
 =?utf-8?B?T2Z3dUdxb01GemdKRjdYU3IvckpiSlRQOWd1VndqWGdINU1GSkYyOEdwandT?=
 =?utf-8?B?Ly9DbEoxc2lmNFB5U3hPVk9KUElLclRQRC9xYzYzK1k0NFZOekQ2WVlTRytk?=
 =?utf-8?B?T1d4djVjWUVlZFdoWFE3WUd5TTRPdFNkYkgvNjNGenMvWUptZFFaVTMvMlBW?=
 =?utf-8?B?a1pkRkRydWxGS3Q1Z1VqK2czb0hmVkNDbkhHTndsR3JHVVNwWGpNTHZtSDFv?=
 =?utf-8?B?c21wbHdVRFE5V284enlQNmkwY1VETDZiaXNQejRrci8yV0xPSVhDWmhZZ2dF?=
 =?utf-8?B?c1lKdkZYbG5RbTMwQk5pcjZEamF3QWdjdDd2YUF4SVh3NStmYkk0ZVQ3SFBx?=
 =?utf-8?B?aUdJTUFMekErejdSak4rODZPUlhrN0J2MjQwdGxyaG9kdGJWVVljSFF6bSs1?=
 =?utf-8?B?ZVg2SjkxZUNNVXJUU0d0WHdVNzNrblNtWXM3TEZSYThqd0VSckRpc1BZUWs5?=
 =?utf-8?B?SnJhQWFPNDNpbWliRFRDMisvNnpDWkFacjJCTEJ2M1hrMzJ4SjFWeFZXWEs4?=
 =?utf-8?B?d1FMWFByK3FjMFpMcnI2bHprVlJTSFJ1WVpXcnVMUExIQnFnczB1dXRZQnRS?=
 =?utf-8?B?aEVOaSs4Mm9mdG5nUU1tMkZtYjhwc2gwaVRPb3hMV0tDTTlJTjNVOHFOV2pS?=
 =?utf-8?B?YTJ6THhGZlo5bXIrRm5SWnBLMTRRaXpUVStVcDZNdTlDWW5HUHVYVlZPM25I?=
 =?utf-8?B?TUkzN0JPaHJvYk0xWVRLRzU1UWdkNE5EQVY0N0x0MndGdE0raFZGN013ai96?=
 =?utf-8?B?bkdTTUJGbVN5RzZKbUx2Qkk4TCszbWxFU210bTdoQ05QRS93ZUc5Y1FOeUhH?=
 =?utf-8?B?UkFwYkFBcnVCWTd2d1lLb1NVb3FsTmUwUlFuUUFrOG15aHB3akhuZE0wdFFx?=
 =?utf-8?B?Mm5WVmovV29qYkJlcmh1SHVIVGY2NGF5eGY4YnF5d1FqVzNOZHVDOG5Wdy9u?=
 =?utf-8?B?QTdaVkhKYjJCT2NpR285NGtmYXl5NEpYUnRlOWxidHZaMzR0Mk1SYTR1bXdK?=
 =?utf-8?B?WnB1MzB0SU50blM4SHkwVXZzbUxKQytYR3FoTE83OW9tSlpzQ2hLSTdNZWc1?=
 =?utf-8?B?L0NwN01EamJ6SENhZ3c0UXZ1YUp0U2ZLbUFwZERWa2NRNjdjcGZhZ2Nsem1Z?=
 =?utf-8?Q?ZISStZDu+0k2IP5uGqhwR4Djk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mRKnn7YZwgwNfN23EPYzoRKssfx9WYXjWc1aR2RwrZuZ9Jf8CgwLHZlOarfn2CLMrpxcVlWTpNJMcP4AxrRzkCI53PhQBCaret11f2+ccVYPrrKASqvHEhW5QqAM3fLWewYb1u0qkciCF9+kfARZ/uvTVg9cPnIJsjPFnM2IBx3nS4x1eb9QoDSMhSe2dglBAGOf4MXQBWMmue08fV2m+D0vBIzxoHbdH5qlfKj8s5Ja+AuRoYtn8uUa0fWA05F3hzTCsZg0r1BYKzOipLESWl26wo+z/33FmM1zcvoXwyQ3e72EQSxL3MgBuVxHUOfXACNE56JqX9HPXWfb5Px4uuTMcwcUjXM7zaoFhC+UQNr6rvG3vHJBWVldTokAEXyzWdTsoKTf+vSrUX+a305BO1YoaomKjL9iA/p8tlJiGxNuu1E08PV4W/ryzFpx6Svd/NfN1YeZiztwQ86p9YHwVkrvjrPit1CcjJkw+LW5m9IVzrRVUev3KQv4CZOja1ksyF7/XXDeiwfjzRnsC/BUGMU5m/TKxYEcrdA6zBOixImu/a95yRzMKT9vtFT6eFNhVbQP3q0krbM8GbUsdEcmg6n+2ACjinWudzOEc55uA8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d253e14-9143-4af7-abce-08de0cb9b58a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:41:28.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dubeZvC4T8K77XD11Npsc8xOIEHXxqyVjrLL+2laNVq1b+M7+fwUsbG3zjbNQYf2CDoWI0lmfXNuuFceZysV/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160100
X-Proofpoint-GUID: psDEzhiBvN8-Uo6KBpaAsExoVxCpOYEG
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68f0f60e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=abum3g6zHJxsXt9TTSIA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX7/++2hqd11b7
 +X3QhDUQ0mHLzT4f9GzzpIIfUDEgIoJgHXzLR1lGrsSvODI0CKpNarjfWT9cL306IOsAvrbhbTo
 F2vPCl1wzmrJ9rq/nmfiUlh0Eo/aZ/azByCpy2r7U8uDzDx0oa+INwxRtD+cAazO2Q+c52P+SWH
 xdKcFaPMuKpzWZEu/BSzPA2hGvMhOPv7GVOD53PeR/VrPPSJ0OQR6x00Yaidx6Lik20/UzoQJpm
 z4mxSXH9dii6TH0WMe9eUQ0NMNh/rVNDC1DR4PK5U7Gri9wN4maGRoy9MlBiO9fMPQKxQA+JTSK
 U5I57ApDzH8xdXz3FCJdtmC+ZrHGDHSd73rKmfmWGgbTRomxJU9Y1OF9bizKoihRLE0XwNc/ETg
 GxYskAjqyDPCc0dXWODR/Q4WX+F3tQ==
X-Proofpoint-ORIG-GUID: psDEzhiBvN8-Uo6KBpaAsExoVxCpOYEG

On 10/12/25 1:00 PM, Eric Biggers wrote:
> On Sun, Oct 12, 2025 at 07:12:26AM -0400, Jeff Layton wrote:
>> On Sat, 2025-10-11 at 11:52 -0700, Eric Biggers wrote:
>>> Update NFSD's support for "legacy client tracking" (which uses MD5) to
>>> use the MD5 library instead of crypto_shash.  This has several benefits:
>>>
>>> - Simpler code.  Notably, much of the error-handling code is no longer
>>>   needed, since the library functions can't fail.
>>>
>>> - Improved performance due to reduced overhead.  A microbenchmark of
>>>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
>>>
>>> - The MD5 code can now safely be built as a loadable module when nfsd is
>>>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
>>>   built-in, presumably to work around the unreliablity of the name-based
>>>   loading.)  Thus, select MD5 from the tristate option NFSD if
>>>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
>>>
>>> To preserve the existing behavior of legacy client tracking support
>>> being disabled when the kernel is booted with "fips=1", make
>>> nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
>>> know if this is truly needed, but it preserves the existing behavior.
>>>
>>
>> FIPS is pretty draconian about algorithms, AIUI. We're not using MD5 in
>> a cryptographically significant way here, but the FIPS gods won't bless
>> a kernel that uses MD5 at all, so I think it is needed.
> 
> If it's not being used for a security purpose, then I think you can just
> drop the fips_enabled check.  People are used to the old API where MD5
> was always forbidden when fips_enabled, but it doesn't actually need to
> be that strict.  For this patch I wasn't certain about the use case
> though, so I just opted to preserve the existing behavior for now.  A
> follow-on patch to remove the check could make sense.
Eric, were you going to follow up with a fresh revision that drops the
fips_enabled check?


-- 
Chuck Lever

