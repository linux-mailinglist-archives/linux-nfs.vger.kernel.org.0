Return-Path: <linux-nfs+bounces-11374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468E1AA4D75
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 15:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891C57B6DF5
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4BF20DD52;
	Wed, 30 Apr 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2vVdxLa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eKolFJt+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B967239082
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019721; cv=fail; b=YSTupEWcMhMMseC/pppKjtSnYp9JZhbfhU4hvCXrjIlQUjTsVUGPIcxiTqo5OdzXbTSXw3cDcs7eB3HsM9zMCNSc45rmrzWmhwpLp0Tt/N+IO89WDisKXm3P2d+vq6gsB6dt8vBPnVyKe9VFF+gUDJDbmdjQwBhsCRQcegNqZVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019721; c=relaxed/simple;
	bh=h9W5EoeSEezRBfh9AaRl9Fuiu61PViC3ViaDOX0g/IY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nYHaVRqeED+81cnOLYEm5vBjQf4bj0b1EkHO/k/066TMos2Xx8JPyF9IUXBZs/oLmUkcksRAGtj66+QgT6Wi3dSLLvFo8c5l/LKNQ6yrV4f6rOyQIg1vJ/nalm7uPlRG+vSlhfzmvgtTgeUA4UO2wQXo/1NjoEB1ioxTibZSBgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j2vVdxLa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eKolFJt+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UD05A2013644;
	Wed, 30 Apr 2025 13:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=43X8tv8kNFjxqkSIBjCe75MLmJ1XUNs7R1XXuXZp1Ik=; b=
	j2vVdxLa0PBW9+AEqVkQEmZEdPglWHLU4IzZuZGQJnq9J+WvRYjr6ukQXjfZYTtU
	uU1oECKzxBGNrDDaYX7kI+3FlAFXhMZL/R1fcBKjknikBp4sBEYhhSZAfaDJqhGZ
	PG2XxmHUld4lSS/njEhJRJGZLe8rvjDnWpUEfcD8qXNn+NmR/agt/bc4RsfyKbh3
	sTQglBixAdvwdqzlSCqN1ox7L+/VXV7srB7oYTSzUqZF7qnuq7tSZBTUwfCgo0Fn
	VCxXRDg3PomJa9H9HZrXr5xMKIMnUW9Fc7KVgO7JG09J9ObAt5c8w0BeXkJmapt4
	LxdpZnOhcP+iEepLm83P1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ut95js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 13:28:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDGM4p001383;
	Wed, 30 Apr 2025 13:28:25 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxba5p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 13:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTtnuLPYHm7cfRsxbtxvgXLEtzfoqo2hDdpxoN16eNQQRNv82ZXTmg8rkL9nVkBG4wvONcoSA9JBN8sk98EHpzhQnjoCVisOzIum2FlPqVpYF7oHYlL+3ZGsLKvP5RMastHhbVPOfwY+nJT+2FgNfcS+bnkL7F41WCfHG9RCwlYmCtyj7RJpjcQmU+EgHYRNpBO0P/cZkFnpCnubhAKD/j7PfjUai3J2KZ6BqZ5+J5LAGI/3ye90/8qQVQdUTBLsJYPhvcHa3wJhdafm4EyY6B1o+ItrE45CDkgFp581a6gv8TGg9DHKmF8fRQfk44xCtcikJ4nx62IT2GJRBfpGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43X8tv8kNFjxqkSIBjCe75MLmJ1XUNs7R1XXuXZp1Ik=;
 b=d1DtJ3nToQfaDu2S5Kj5HQfqbprq/v5zhZ730PAkKr36LJjvF9KvvC2V3mK52KrcP9Gi7UENKy22/Omho3tK89UVFVk2gJWDE5zFGqqQgkCyZa31C+M0GysZOmS0Jh0GucccqRJYPpSRWxfFvEAhErr6tJp9rInIDvupaxk4I4fK2NQPdLKdHY5LrIa56LR6eGDaD244eQ9Pzq8mCsaHpMCUbHa819d9YP1F6ZsRQNi7UWS0wu9v1iuLsH4aEXu3wAMI3L/QZ6wOb3La2qRTxO+cdl7mxz0ILUyKJGxkPDAJnp/kh6/4WF7u/CxQ5tr8k0EwGwNvgW7ktkxLqdTTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43X8tv8kNFjxqkSIBjCe75MLmJ1XUNs7R1XXuXZp1Ik=;
 b=eKolFJt+3+tzA8935qivlKdwR6O8ywGT5eNizFoTbAXPOyb8mEQ7nBLrw3n5sC5hqRfJBMDNfmia6Pwrtvp02daMnMu8BZqdERsZ/30K/S69lw8cAqOTAvDjLTPWw4GAhRMFQyRFwEmne103Ji4liYZP8fFMCfFK/JPxmMCMWHw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7159.namprd10.prod.outlook.com (2603:10b6:208:401::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:28:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 13:28:22 +0000
Message-ID: <0a8d2285-e5b5-4a75-98a0-1a94d6fbbae3@oracle.com>
Date: Wed, 30 Apr 2025 09:28:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: Avoid flushing data while holding directory locks in
 nfs_rename()
To: Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>
 <2526363b-1f4a-4999-9f9a-8c4c5c6c132d@oracle.com>
 <c4b94ca894764b5f323fbf92530389f8c8b85894.camel@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c4b94ca894764b5f323fbf92530389f8c8b85894.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:610:118::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fb25d2-6b75-4320-8c99-08dd87eae13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjVsV294cGpXNGt1bytWR3lvNk1jRXR6YmFXRi9tc1c4Ujg0UnlQd1piQnZ5?=
 =?utf-8?B?Y3QvbUFERVhzc0FiRk5BdGFIdS93ZkZLd3M5aG5XdTlSQmxRUXFibFNoTWpC?=
 =?utf-8?B?cEc1QzJaZUlVQVZMdC85NEF1Y1l4RlRsSThxNEU0OGFyMGxpcGFpSFo5ZU1K?=
 =?utf-8?B?MUI5YlZrMHhtc3Q3M3BCSUNUTkJoSUlPdXFNT2hPVjZURDNubXRodmtkZnRx?=
 =?utf-8?B?cjlOYnU4dDdERlhqL3RDaHo5VCtHNU05bW5BQjk5R0s3bkN3OERVbmdaQjBD?=
 =?utf-8?B?N3JDZmpJZ05Yd2xqREw4VDdzbDNWL3lnM1pTYWdxeWdmZHEyRmF6K2MvL2ky?=
 =?utf-8?B?cUpERjFKTWZqZE8yVjdTUmZpRTlyWTBIYmw1ODZhVHY5UHdvNTNBNWk1YmJW?=
 =?utf-8?B?ZDMvYWljcTg2cVFzVmJBVVNtVmsvZG5hRnlDeTBRVys2WEE1VThTYlhiSXNr?=
 =?utf-8?B?c2NMSUN5a2xmTnBnOTRDMnpFTVFWb0RuZnQ5ZHVnYmdVTlFDUU01YjJtUkVz?=
 =?utf-8?B?bFVvbnh5N0tyVWFMbG9vbjRzbyt0TFBNVzRkNkFqV1NDcm45MDZLMXF3eXZB?=
 =?utf-8?B?WGYyK0Zva0JmeDhuZG9uUC9hWEhFbm4yUXFkS2FWcWV0bWp5SmFPL0ovU3dJ?=
 =?utf-8?B?cEgycVRwN3Byb3pZaFFDSUZtMVVuYlRPeTFCSmFEYWVmL0RmYmp6ZU1NaGZ6?=
 =?utf-8?B?QVI4cnVDKytHRW51MHczVkgxTDNzVGhLdTd1YWdodDdoVVc2UDZWc3lZS1Q3?=
 =?utf-8?B?NXRpQ050c3hmY3pVSGVhWGJDOWw5Q3pmc3cvRHAvNDFubytBZUFPTVd0YlZX?=
 =?utf-8?B?cEJZcS9ucm93bmxqUDlGYmlVYkZ0ejZNZUszSlhxa2o3ZlNDNDNiYXAvU0tO?=
 =?utf-8?B?aW5UT3JOVW5lc2VGbDRLZTFFS3JZcmFjeERrTS92QTdpeHlldm10TUh5UXNH?=
 =?utf-8?B?L3V5V3FtZFNoYVpmNmVDeDdqN016UkdhUGVsUGJpR0dnR3c1RjZhM1FtNFhZ?=
 =?utf-8?B?SWoyRk9iNUlmRm5mcDhtREQ5Q20xa0VpOSs0WmYvdVUyV1RQMVJtN0wzVzRj?=
 =?utf-8?B?ZzNPMXhBRUFtZjFISTNqcERuUjRubDVwcDZLdTQ2WWtHRFlOdjRYbzJpK0Vk?=
 =?utf-8?B?UGNJZ2JONzU1dWcreFhyTjk3Q2ljc05MWGJZWmhpUEQvMmp0YS9OcVNIdFo0?=
 =?utf-8?B?Z1QxNWVUY2Vwb2dIOVcvTlhtT2MvNmVVdEFxem1QU1pkQ0U4VDhTaStIU01k?=
 =?utf-8?B?ZXIvTEEyUS9tVFFkclYyc2o1eHJYVVBxc29xR0lzanV3ekVTY0FQSk5PYnY2?=
 =?utf-8?B?TWtlTHp5ZXg4UmRBMmEzMU1lay9wTnBOU296Ykp3MmNSMkZDWDdZcnJIZzVS?=
 =?utf-8?B?ejRxSytGR0laS1FXUkJHMlhqSnFWMUYyYUU3cW9ocENuaTRrWHRwN2JoQTNR?=
 =?utf-8?B?L3B3WWl4S09Ua0xJd2VPL3ZUREhWUXFxMHRoc2hmcFdzOVJDSysyWVl4ODVv?=
 =?utf-8?B?S0pVWXFhM293cCt4MjJuaXBhZ3l6VVk2cUdLam15Zkx0Mk9SaTJoV3NUbzZh?=
 =?utf-8?B?NzlFREMxMHVVbmEyS2FoVTVqRUhKYUhtYitvUEJRUTd6UXRRdk8xbmhMOG83?=
 =?utf-8?B?c0diUlZmckZuTlRObWVBS0hhMzR2UUdUNzZjeTVCSDVwNE9QS2pVcXJvWGp0?=
 =?utf-8?B?SjFndHJsU0NZd3Q2aGdwWUpmbVhZYXNpenEwczNYcy9SYk1YZWdUbTBJeExy?=
 =?utf-8?B?R3Q1bGwyemtqUmFPWWduRTNFSlFBeG5hMVVidkQ2T0haOVNmaFhzSEZvT21s?=
 =?utf-8?B?Q0U5UC90MkV4OFc5UGdRR2REci81RFJqZkNkZ2xZTG1kSzBVU1paWW5zaUpG?=
 =?utf-8?B?RDUyZXpiT0JPR05oZlcvZFVzbU02N1hhZTVGLzdRd0VaU082cXpoaWtGMDBp?=
 =?utf-8?Q?NgfiZO6/gyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJwRTFnZmxxWTBhUGxBczlJcnQrd1FTd2JwTUQwQk02dDAzODFySTZlVVZ3?=
 =?utf-8?B?WU8xWmF1Y0tBRmlPN2UxUFhBakpsdXozaExxcGptWFZzN3Y4R3lLTnF1M2lG?=
 =?utf-8?B?THNGMGZPSlVKM2ptdGlpL1ZwVGpPck1JVEF2SWczLzBBNXhYKzE2TDk5eUNx?=
 =?utf-8?B?S2NoUEpqL2tiL1ZuOUpEOTJDeEtXRXFJaWlRM3htZDhrYlp4QjdLNUNQOC9E?=
 =?utf-8?B?KytaNko0KzhJY1pidnYrZ1lrT2VOZ2pLbktRejhmS1RMRGkzOWQxY2M5K3Ry?=
 =?utf-8?B?SHBTUEJaMTFFeWQxc3JMSVV2anFUVFpGQnZud21oZTNoRzZITU40RXl0RTly?=
 =?utf-8?B?VXVlclVZQWEwcHhzZmNVOGxid1RhSXlhZzlqVGNxQ3IrMGN5elhwSjBFM1F4?=
 =?utf-8?B?WTZhSm4ySzBYdUN1ZG52YzF4OWRVRHhRL3o3Q3I2SlJZNzZ4OXVrMW5lN05Q?=
 =?utf-8?B?V1ExNHBMRVMzYjNiUmJDcDZuKzBPUTA2THVSK21tN1ltUUZQNzBaVmtvZ253?=
 =?utf-8?B?K3hGM1hnQlJOSDl0cjhTNGk4UVJYT0crTURnTzVLemJpK1lSR2oxcmxkRTln?=
 =?utf-8?B?YURKR0xtemI0UWNQcEhhaTdOTVl0YlllRk9tbWFENVplaVViYzlNWklOR0Mz?=
 =?utf-8?B?OHAwOWRGRkJSQlZUWjZiZ0hHT0YxMW5hRUttVTlNRW1uUXN4UkhiZ1NjaE5p?=
 =?utf-8?B?UThsZGxIbUtpUlEweWR6dVFGRXMvMXZpcEN4UU52a2lsTzA2MkVhcUJuL0g0?=
 =?utf-8?B?cktUZWNRSklXVmZDU0tWQ0tiU0IzbzN0QmxXWTNtL2piRUVTcWQ1SURyNVhZ?=
 =?utf-8?B?VHpveU9xR0U5bFUzMWRMa2pwQm1PYTVubngydVhWeC9uWS9JNjZKbUdpV2FT?=
 =?utf-8?B?VnFTYUdWRmE0ZisxY1lZMENwMGRHZ01DUFUrYmJtUGpiVUI4OU83NHdabzA5?=
 =?utf-8?B?dnd5UVFRdXJOdkVKbmVQWW9PTTdZZ0xFaFhZUHRKRlRUYWxlL0twUjBGUzhE?=
 =?utf-8?B?a0JMVFBneSs3alJpWTdieENmS1lWeitLNnN6Yk5DMk1FQ3Y5U0t2WWQySHdY?=
 =?utf-8?B?bHAvNnhFL0oyaGxycS91OXg5N1BSenFSbEdzY3RnQVFlazRDeW5XKzZWQ2VZ?=
 =?utf-8?B?QVVjY2laM3B3K3p0a1l1NFFlOFRabUo3aXFqeWh0OE9zYmZYWWRjb2k5c090?=
 =?utf-8?B?dU92TzFhQmIvMjYwS0dveVFGbjhxclZWRUZSdy9odE14NGZVR0s4c0Y2TlR1?=
 =?utf-8?B?OFU0dkI0NEhlVzlPRzNQUEI0VmRPRllXUzlwb3lwbVZpNnBlVVV5azVwREE5?=
 =?utf-8?B?c241Zm9vSC9PcFIzWG92cWhGTlhpbzg3bWpLYU4wanZDWk9za2NSbVBXSHVl?=
 =?utf-8?B?UEtvOVRoY0d0OFRZMmIxR0dmR0RWV3k2ZFpjbEF6WlptdHU3YkZtSjJXUWRY?=
 =?utf-8?B?Y1k4dkhxSFlwUUlrVVJIKzl0MHJlc004S1pJVGgrWEtnMmhOT3hVN3NqODcz?=
 =?utf-8?B?dGhTVlYyNXZ5ZE82anZTSWs4M2Uvbk9IWGZaKzFjaW1pcHR6Lzdsc2RtM1N3?=
 =?utf-8?B?TC9nYWovcldQd3lQMEJ1blBEdjdvZzdGY0w5TUtXd0dPdDhMdlJ4NllRVlVs?=
 =?utf-8?B?dkx5UU1PTW9jcllmRC80VUFrdHBDMnIzVjc1YzlibzhxMllHcXl0OENCZGFJ?=
 =?utf-8?B?RnppZ3RPbGZJTkpid2loV3A4Vm1WLzAweDRVenhsK295Mk9CU0JmMURpbVJE?=
 =?utf-8?B?QTdmMitmcGwwbCs0MnlFUW5JMys5YjFjQnB0VzkwZFBvV09MR0V5SHArWHF0?=
 =?utf-8?B?S0FKVVhGa2F2cGVZNDFOeVFqVVovcWVyWVYxWnlEZDFZdy9PbXhZV2FNalB3?=
 =?utf-8?B?Y1JTWGlFMjBqY0FadVc0L0ZENll4S2dFa3gvNHhvVGFZMHVUTGtmSnJ5czFU?=
 =?utf-8?B?dEV4UndrbWkzcEk3eUYwS2c4cEIrQ3hrZ2x3TytYM2ZGUk11Yk9pK2lkREZm?=
 =?utf-8?B?UWJzaXhNZDROQ1FxWlh2Y2RyZmUwbEIwVVNRUG1STjVyQ1I5NURTN1FFWVls?=
 =?utf-8?B?TGpMV090eWNPQmhkcnVZd3FUd3hUelA5WnJTenVKVWVsQkVyUEVYYkRJYmgx?=
 =?utf-8?B?TEYxK21HeWJtUjVzMS95WXdjeTh2ME0vc2NwV2lhYVQ2S1Z5cVBERllYYVZE?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/hbMwGQimRW+bWqWSI3isXqhow8PBghxIVBGDOBL4NOk6raDrR7co1F1Tr9f1P7TrKmN5MLRW/nz5HG4lFRgQF6EBIZk6iYnjAHsqJavCzJ8vyr2LnCaKW/BgbXtD17tq1qlvmQ+ZzFoFvy7YiMzLhi5KkKC/059OijVnwrWWO7qdq2yu+8eXsUOtRfNL3RmY2XMI5Vk8qixbTrB4dFqJwYsRkFsu8dQZL1hFeq3Z1sypssbnaHS/8wO9Kx8NHYld4YdVlODgI79rCIH+YxR2CB9OCB8j1EcuGQfGWuZ8Gpm53ViH7gWShxv1FV5wbTVJW+j/2Ggi2DfRNdFweAqXRUlKCPhWtMMEOTwJXfSD68hl3riGMT4DZH3sba557Rx/FGsl1HjM8hSIaEaGewGpDLhTm9aUVqEt4mPzZ5PxKAe2CJkjmIUHnXXEATu7YnGBLOa/lsz+l92R8b5aCEpFS13iN0nBAqIgtq4bHfyn3CW+8le9jxAoFRLkvBe5AByqDku+HfcDaxHQf9/ppzsS9AEw47FfOt7WsIbuOhF/b9uVSS0dwdUzktoLuHR6P4SG9MBk+Y72NZQd2ZJEJj1qZWUQdWp0TiU8P3+vj2Zddo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fb25d2-6b75-4320-8c99-08dd87eae13d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:28:22.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq/XKkiKAeC+2upckb+equZWgbhMAMs7ol4gYCSKToxVXdSpTmIhsdPi7IWFfvvu2cx3JcHCEYzIXVVc7myE8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300095
X-Proofpoint-GUID: voIpZ3q3yumtjFnmhHf7CJULJ6bSSlsb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA5NSBTYWx0ZWRfX2ZS1lso7QOtU DiFcpqDAqPliNYgGFLVqAXdekcaJJiUXTHxKQ7GWQjUaM8bnKSNeSAndx7oY/SlBrOLrAqbwqYx QTLDDlpsKRmRbxn6Poaq+oTiejeqeUGELEVA2xhgmObbHK9hq97cQCU2Xtwh4UDaAKgKdKqOl3m
 aG1+Y10z7DN/bzPWGpq8+QFqa15NvGwPGgPizEReVdNwEtTX3LmRQEq/aQ+2rEPwPleQJQiZkvu Nyyufp5xeYTV8eb80aY4Bv2r5tRVPmhpJg3wghVWAkViNH5EbwdKamnKIiClTW79pWc/uqiEm4G pY5kVYzGNWbdigjP+dVCW4opoHybH6vv+WgjIhe2t/iAiV05+2ETUw2G2Y9PLdAnvXYs5/j36/O
 F6R1BuvtxJSJdnTKYYeTqZ/0hU26ROYPwuCA/5R2Pd3ZnAkP9F+s/2I5RuOVFlNDeiwlcxgp
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=6812257b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8 a=I4OJOmu-QpTY69J4ndEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13129
X-Proofpoint-ORIG-GUID: voIpZ3q3yumtjFnmhHf7CJULJ6bSSlsb

On 4/29/25 7:22 PM, Trond Myklebust wrote:
> On Tue, 2025-04-29 at 12:14 -0400, Chuck Lever wrote:
>> On 4/27/25 7:01 PM, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> The Linux client assumes that all filehandles are non-volatile for
>>> renames within the same directory (otherwise sillyrename cannot
>>> work).
>>> However, the existence of the Linux 'subtree_check' export option
>>> has
>>> meant that nfs_rename() has always assumed it needs to flush writes
>>> before attempting to rename.
>>>
>>> Since NFSv4 does allow the client to query whether or not the
>>> server
>>> exhibits this behaviour, and since knfsd does actually set the
>>> appropriate flag when 'subtree_check' is enabled on an export, it
>>> should be OK to optimise away the write flushing behaviour in the
>>> cases
>>> where it is clearly not needed.
>>
>> No objection to the high level goal, seems like a sensible change.
>>
>> So NFSv3 still has the flushing requirement, but NFSv4 can disable
>> that
>> requirement as long as the server in question asserts
>> FH4_VOLATILE_ANY
>> and FH4_VOL_RENAME, correct?
>>
>> I'm wondering how confident we are that other server implementations
>> behave reasonably. Yes, they are broken if they don't behave, but
>> there
>> is still risk of introducing a regression.
> 
> I'd prefer to deal with that through other means if it turns out that
> we have to. The problem we have right now is that we are forcing a
> writeback of the entire file while holding several directory mutexes
> (as well as the filesystem-global s_vfs_rename_mutex). That's terrible
> for performance and scalability.
> 
>>
>>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfs/client.c           |  2 ++
>>>  fs/nfs/dir.c              | 15 ++++++++++++++-
>>>  include/linux/nfs_fs_sb.h |  6 ++++++
>>>  3 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>>> index 2115c1189c2d..6d63b958c4bb 100644
>>> --- a/fs/nfs/client.c
>>> +++ b/fs/nfs/client.c
>>> @@ -1105,6 +1105,8 @@ struct nfs_server *nfs_create_server(struct
>>> fs_context *fc)
>>>  		if (server->namelen == 0 || server->namelen >
>>> NFS2_MAXNAMLEN)
>>>  			server->namelen = NFS2_MAXNAMLEN;
>>>  	}
>>> +	/* Linux 'subtree_check' borkenness mandates this setting
>>> */
>>
>> Assuming you are going to respin this patch to deal with the build
>> bot
>> warnings, can you make this comment more useful? "borkenness" sounds
>> like you are dealing with a server bug here, but that's not really
>> the case. subtree_check is working as designed: it requires the extra
>> flushing. The no_subtree_check case does not, IIUC.
> 
> subtree checking is working as designed, but that doesn't change the
> fact that it is a violation of the NFSv3 protocol. You can't to change
> the filehandle in mid flight in any stateless protocol, because that
> will break applications.

My point is that the comment you add in this patch, although whimsical,
is not terribly illuminating. A more expansive comment (with the detail
you provide above) would be helpful.

But if subtree_check is not compliant with RFC 1813, perhaps we should
consider finally deprecating and removing it. At least exports(5) should
mention the spec compliance issue, but my copy of exports(5) does not.


>> It would be better to explain this need strictly in terms of file
>> handle
>> volatility, no?
>>
>>
>>> +	server->fh_expire_type = NFS_FH_VOL_RENAME;
>>>  
>>>  	if (!(fattr->valid & NFS_ATTR_FATTR)) {
>>>  		error = ctx->nfs_mod->rpc_ops->getattr(server,
>>> ctx->mntfh,
>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>> index bd23fc736b39..d0e0b435a843 100644
>>> --- a/fs/nfs/dir.c
>>> +++ b/fs/nfs/dir.c
>>> @@ -2676,6 +2676,18 @@ nfs_unblock_rename(struct rpc_task *task,
>>> struct nfs_renamedata *data)
>>>  	unblock_revalidate(new_dentry);
>>>  }
>>>  
>>> +static bool nfs_rename_is_unsafe_cross_dir(struct dentry
>>> *old_dentry,
>>> +					   struct dentry
>>> *new_dentry)
>>> +{
>>> +	struct nfs_server *server = NFS_SB(old_dentry->d_sb);
>>> +
>>> +	if (old_dentry->d_parent != new_dentry->d_parent)
>>> +		return false;
>>> +	if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
>>> +		return !(server->fh_expire_type &
>>> NFS_FH_NOEXPIRE_WITH_OPEN);
>>> +	return true;
>>> +}
>>> +
>>>  /*
>>>   * RENAME
>>>   * FIXME: Some nfsds, like the Linux user space nfsd, may generate
>>> a
>>> @@ -2763,7 +2775,8 @@ int nfs_rename(struct mnt_idmap *idmap,
>>> struct inode *old_dir,
>>>  
>>>  	}
>>>  
>>> -	if (S_ISREG(old_inode->i_mode))
>>> +	if (S_ISREG(old_inode->i_mode) &&
>>> +	    nfs_rename_is_unsafe_cross_dir(old_dentry,
>>> new_dentry))
>>>  		nfs_sync_inode(old_inode);
>>>  	task = nfs_async_rename(old_dir, new_dir, old_dentry,
>>> new_dentry,
>>>  				must_unblock ? nfs_unblock_rename
>>> : NULL);
>>> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
>>> index 71319637a84e..6732c7e04d19 100644
>>> --- a/include/linux/nfs_fs_sb.h
>>> +++ b/include/linux/nfs_fs_sb.h
>>> @@ -236,6 +236,12 @@ struct nfs_server {
>>>  	u32			acl_bitmask;	/* V4 bitmask
>>> representing the ACEs
>>>  						   that are
>>> supported on this
>>>  						   filesystem */
>>> +	/* The following #defines numerically match the NFSv4
>>> equivalents */
>>> +#define NFS_FH_NOEXPIRE_WITH_OPEN (0x1)
>>> +#define NFS_FH_VOLATILE_ANY (0x2)
>>> +#define NFS_FH_VOL_MIGRATION (0x4)
>>> +#define NFS_FH_VOL_RENAME (0x8)
>>> +#define NFS_FH_RENAME_UNSAFE (NFS_FH_VOLATILE_ANY |
>>> NFS_FH_VOL_RENAME)
>>>  	u32			fh_expire_type;	/* V4
>>> bitmask representing file
>>>  						   handle
>>> volatility type for
>>>  						   this filesystem
>>> */
>>
> 


-- 
Chuck Lever

