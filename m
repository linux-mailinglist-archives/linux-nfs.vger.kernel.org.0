Return-Path: <linux-nfs+bounces-3570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12C8FD1C6
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 17:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C505E1C23504
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825413791C;
	Wed,  5 Jun 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9r49y+p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z3Sh9eEE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690483C482
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601822; cv=fail; b=aYGDkRLoWCDb+f2KocrjmFTdBi69sL5Xm/8kQUZRX+97C0hLOrhJdh/jfBTaCg95oRv32BEr9cftYgZd1k3Rn5uFC88z/1lCms8nep/m/oibE+HiXSI9fnM0CFZIuH/CQjvvBad8BZF6Yt9bcrZXsuktCwsRbl5K3RS/gj/QbJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601822; c=relaxed/simple;
	bh=a0A6rnkz6/K086qCLzEu2zA3pU3J9iy/iskN3KVBjLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ehjEkvoielHVwlmlXKp4dFY/oImUEB0R+nFoIx1UD1favgoxgZdMsYhyO0qyPMRCHvvvhyEyF4JMq/6DbTJT3/bBX7yZ+YjpBZxxjQxl+EiFMrtAgWmQuPKtKoeTW5TczteMSUwTfhciogaa9YEHajXt87Sjty8WMjJgAXC+q10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y9r49y+p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z3Sh9eEE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455CQt0C026597;
	Wed, 5 Jun 2024 15:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-id :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=a0A6rnkz6/K086qCLzEu2zA3pU3J9iy/iskN3KVBjLU=;
 b=Y9r49y+pu1L6Xpj3EdupIKNVZd9L6CNFC+We3Z7uiOgSxxfE9T/t6KtAwxymYIR/897U
 Zgpn6nydPj4RB6M1hOohLu4zcH5SG9jEqrKdit42LCcwjik7VwDlWTtPi2V0VKj4nzo9
 ES0uzrCIN/yC8vA9E8Hex+0FlKHdqojnzdprftg9BlrEfxE8vadOQA3IElGKJeIfvNvx
 L4AXfOoBZfo3zv2Xv5fLV/w40qVvviWzDf8uTWjr+dfXJ32i5QhMH5bWU20n1IgrE/JC
 zP+LuYLr7b4VEPMxcNZ55iHiHS3fK3GDtnfoRXrw+pCWk61A1gwBEsFA3l6PfwR9pDBB Eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn1k9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 15:36:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455FJtEn005523;
	Wed, 5 Jun 2024 15:36:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmf4y5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 15:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrPe4tDucE31Dz2UYmBGbJDznKpfR7vMtLdc0faC4ED/YidEUqUKKIp11+EvWlmMnKxDV2x/vgYjV6yzilmH4XNegKNlmlgP4ai3Tyd3ThGXPMxhUEcMHItTgGYRxDTQmntHU2SIJzl5zppwIrqmtlHR5hzMti7JNLfanfHcyc7WmMG2GjB+A4Zm+muQrzarNGPtYhwWvMGX4AlmOKRsLnflbAmgrBIoD6MctH8K6SdDDpugBYTHd/mLzaC8HV6Qp/zv1tXMR8z45WBUnRaqvprKdjV39WZwOd+YCtulOl6DWC9WUuQ/CvAQq2ggHFr883q8kBWnytn+8VS8JhkWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0A6rnkz6/K086qCLzEu2zA3pU3J9iy/iskN3KVBjLU=;
 b=m2v1S4tOhFTWLVxEIMfqzTXejOGkgssdfA6XqTik2IifL66tPg36EXB97Gt+5q/6va99RnKz1f0NVmKS3Mhgh7OUcgPY9M0tv3dlpQFj2Met7mPxJziJSPJbmQhPdcr0TvPT4nO8EwN3NXg+fPWakRtzacUMa1mPeWj1AMYq94BD9NmSFp2yVG2QfP2DFouKmFhKuKliePRkoQxiza9uP1h3uRU2nB8fAxFTTQMI8F5TH8bl/4giaOELQuhorr0BJJSIajVnjjVc6w54KdHA6f2xjzhsS6eJFcjiMlh3yNcatDMOE8mhoTXEjRktqmEf4CulqeXNYZH0XMmWbRJE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0A6rnkz6/K086qCLzEu2zA3pU3J9iy/iskN3KVBjLU=;
 b=Z3Sh9eEEHSDVhaUJNsZp316KUsUBm6knWDO00SMGv6vTkHtqpIrrzBfdDWg7c4xBa2+0oUHsDQHQuevBwLLibEBJpAlnh6Cf6IAgdq7LgsoZC2g02yzeIwaEgz/vC3GBNOT6ipzzrXTPMo59klZFIIB9cu+6hRnTFTaA3jH7G+g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5207.namprd10.prod.outlook.com (2603:10b6:408:12c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 15:36:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 15:36:52 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS with TLS on 4.0
Thread-Topic: NFS with TLS on 4.0
Thread-Index: AQHat1WhT0aMbb0QkUWIMhwCSacQ87G5TaKA
Date: Wed, 5 Jun 2024 15:36:52 +0000
Message-ID: <6E31172E-8991-43E2-A9E0-88FEAEDDA00B@oracle.com>
References: 
 <CAN-5tyHghLR_eSoPq_z18_XvdySKNrWpPKjuAd2c97KKqYGjFg@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyHghLR_eSoPq_z18_XvdySKNrWpPKjuAd2c97KKqYGjFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5207:EE_
x-ms-office365-filtering-correlation-id: 284aaefa-3a48-483c-254f-08dc85755273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UDdpS09tdUJmVE9jcCtRS0JudEJsYUFGZTZmMm5kV2x0dmlVYzExSm9sUVQr?=
 =?utf-8?B?K2ZiTEQzbUphemRpNWo0bW9MTFZTdjBxVEhJd09zOWF4d0JlUmU0amVtR1hC?=
 =?utf-8?B?UGlmdStRdlhDYTQ2VHdtUGxCUnE4ZC9KT1ZTS1JudFVKVmdsSlA4VllKV2VM?=
 =?utf-8?B?anZyZ2VqQ29FZ2ZIbFBiQkUrL3RESklZemdnZ2tTWWkzSWtVRHl2SklrNHQ3?=
 =?utf-8?B?VU16SHZNdHZ6UmNMZGZDV0lUWnJwOEU3bFltSVdsZkVZR0dtQXZxTnpjaXJP?=
 =?utf-8?B?SU9ibGpFUUpYMXJrZGtRZ0ZNL1dSeDVxVHFVK1c3RHdRZFdHTDJPSFdZTFpq?=
 =?utf-8?B?cWwvVCtJYjZUazV3S1NxQlNYVTRoeEQzdThKM3VZbGc5dU9BNjAvRjVMMkdx?=
 =?utf-8?B?R3A3RjNrUWRtZUpjZmdkc01EdWR5MlNDTWlSTkhVcmszYXRCc29JcDZrSktU?=
 =?utf-8?B?U0hOaEc3UDJaVC9ZRU9iTEdUR3lZdDgxbmp2dDBKcXVNeWpsai9uMzEvU0Z2?=
 =?utf-8?B?WjROQ0dtR2VmdjZKQVk3b1VpMERzYU55WDJTQit0WDNYOE9hTFAzVmRrcDVP?=
 =?utf-8?B?NkNVbTJleGdMb1lxcmZUL3FQZUhxRVpIQ1pYTjRMSzlUYWhTSmRTSmN6c0tk?=
 =?utf-8?B?VjlEeFZwY1VrS01CWWcwbk1nUHlFblQ5MjQwQTJseDhMUzVlK2txRjgxVTd3?=
 =?utf-8?B?bnVIZnlBeUorRlJWdG5ocTJNZWl6TDhicG5sUmZKUHZMWEtLaHdhQ0E1Q3l1?=
 =?utf-8?B?bnd2U1h2TzdOSXNhdSsrM0pHdEFGdlZnWnpuYUI1NStyN1A5enZQNnhnd044?=
 =?utf-8?B?NWNXNVErdjJrUUtTNGluanVKVE5vSHZneEdpcmd6WENtNXdkR04weXRoZUhV?=
 =?utf-8?B?bVRtcUdLT2Ryb1JXZ2IrdHBvMnA2T0d3VEJzZ1ZaWkxBUU1NQ3JtUXNOaGRG?=
 =?utf-8?B?KzdMem9DeXNUZHBwUHBDblBqQkgxRjcyajlEVGRxeFVsdnhZc2FOV09ncER2?=
 =?utf-8?B?dDhocWxzT05BK1IxbVlHcEVlajNLeWdjdlR6cncvWTgzMHl2ZlRoNnlUZXVE?=
 =?utf-8?B?WHloMzMrNU5pZi84YTZIMjZ6NXFRT1pjRWJ0b0ZtMXVYTmVlUmthUzIvMUJ0?=
 =?utf-8?B?dUtaY3UzQlpsaGhkZkJSdEFhbnN2UlhTN3pCNHNlMlU4ejY4MForYWIvTzhO?=
 =?utf-8?B?QkVaVEtZaTBIZ05wUTlZV2JnaDR2RWlGZGdQUzZSOUNSdmxIVklLV2hRNzF1?=
 =?utf-8?B?TTJwZW1GT25NRHdhd3d0dlBDcWo5WWsvaTQ3dzBpbjFFVVhxNTBReUduTzJP?=
 =?utf-8?B?MmtCcUFuZnR5VktkVzg5a2dIbWQvblF3WTl4cUFienZFVTU3cThFYzUxOWdU?=
 =?utf-8?B?TlU0WnFCcjVBVThOc3VJdHdaL1RhUXlkREZQZWdvM3FBdldNZTY0TDM0UlZZ?=
 =?utf-8?B?QUVCckp5REVJNFV6Zzhsc2JxaHhwdFVGWDUxUFh2Z2p2aDNFbFhxNjIyL2dC?=
 =?utf-8?B?ek9vVlQ2bkdTZG9ZTXNxSjJmUi9KMkJkWWxmdFZYVktRV283ckFlWnF6N1BZ?=
 =?utf-8?B?U2pFQkF4bjZUY0RVKzJSenMwS3U1VWNkWUVBSUQrelBBakRmNDNPd3owcUN0?=
 =?utf-8?B?TUl3a0lsSDl6RTVncG8velhrd25sWUM4Z1VJK1VXQ01rTEE5OXpkNnhHaXNt?=
 =?utf-8?B?MFpFVkR2N3g1UGxmMmx2VEFXUW9leWhGdTk0RFFnaVB5YVBqSXpRbkhzb3Nj?=
 =?utf-8?B?clhTbW1QZytsTklxb1hFVlFqMGZYTmUxRlRCZjg1M29ldFBucjNsOUNUTHov?=
 =?utf-8?B?U2tPRU0rb0JYaFRJOXFBZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVpoV2pZUHZ6NXVRcmw4b1JINzk3UDdmenlDRlQrUW1mbm4xUnVsZFpoYktT?=
 =?utf-8?B?MHNCM05KLzh5dG9CQkhFV09NcHdnUVdBSnFUb0k3bFhjS2VRQVI4TGtZVVhK?=
 =?utf-8?B?VEFsalZJeHpMMkpZdHB6SjQyRmM4a3JHSnBQUFFoL3d4N1hyS1VjUUZnMDEy?=
 =?utf-8?B?ZW5Zb2VmOGpuOHZBSDliYmRSQ1E4YytSZE5QY3Z0STBqbk1qKzR6a2tUdHpu?=
 =?utf-8?B?ZVVmUG1rei9HVFdPT1JUVmloR0JYbXFPUkE0WGg3bjFaMENscDU0bG1UQXpo?=
 =?utf-8?B?NlE2RXU1QzZyTWRxSkNoSUtSUGVDUVR0LzZOSHpFelUyRnU3S1loMHVpL2R1?=
 =?utf-8?B?ODhxVWlCZWFEMXhuV1p0UmpHcUdPUVNxeHZNczlPeGdnRkpCUVFVVy83S0tV?=
 =?utf-8?B?MklROFpWRmxycHhLZmEwMEFyRGZsUUo3N0JTMHYvTVF0S2wrN1lwblpUYnhH?=
 =?utf-8?B?RXUrVVptRTk2aU5VSnZCUGdFQUJ6dDFkVlZ2ZXNGaitMTGdzb09lVndxTGcv?=
 =?utf-8?B?Z3ZvdWhXY1ZRMFNNelh3UzYxdWpmeW5qY0Z4cEdONHVsWXZHZW1KVE5iNjl4?=
 =?utf-8?B?MUpldXlwYXptNlFiVytJU1VLckExZWdYYlJ2VFJ2aGFZVWdIVWp2VW44b0Zn?=
 =?utf-8?B?SDFISXVpb0VDMUxOSnhYTE9HZDMrMGtFaEVESDZ3eGJNcnRxcy9UaFUzUFpj?=
 =?utf-8?B?OHYyU1EzQW9ZWmFoTlBwb0V0dEoyM1NYSWdmellvb0Z0RW5JZzZiU1cxR3JP?=
 =?utf-8?B?SlJmUkJtWGhYcTY2aGlZM2lGVHJ0Tyt0WUhFWU5XaHlVMzhWN1FwaTByRDla?=
 =?utf-8?B?ampGVlFjL2p3ZktYMVVzMVFpSHRTSDNYeFQ3dS9EczdIMU5JdlpsdUxhZVBR?=
 =?utf-8?B?U1FwdWcrT0FHSmZLc1JJaXFsaEExSlVJYmJvaTlHeUNyaDhuWlIzQjBwYzZr?=
 =?utf-8?B?R1IvMDdiMGthRnhOY3hFeVd0Y2NvbU83R1NDV244WTNZMnRTNkp1OE13V0Ja?=
 =?utf-8?B?MnZZOFQzSUM1Y0R1U1A5TTMvUktJbGgwaXlzQ1BKK09qMVNyVmQvakl3ZUpC?=
 =?utf-8?B?MWdKdjRpTjFrMXR6Szd6dEZ4N3UrRVJrU1FrNVRxVGRrN3VVdFNscHdyZmNa?=
 =?utf-8?B?TnVPTlQzWFZ2Y0hYMzdsejJObUsyQzFsajJscDZkUzhtVTZJOGNwWFZpTENk?=
 =?utf-8?B?RTM3QU1sOUhIb0xxd3psVGxuZEdldzIxM2ZnUjk5V2phUlRNdnpLVDhFcHd6?=
 =?utf-8?B?Z2NyaGgxWkh4TjZEUUE2bjhDRjVDc3I0ZEcrM3RDNG8veDhrUU1SYUV6cDJ2?=
 =?utf-8?B?ekowZkZHd1NlUzlJMjl1dWtrN01hQmVPVko3bFJrUmNCc2IxT3hHYXVQVTI1?=
 =?utf-8?B?eTlDbHZrZFljbWJzQXlURUVsRWV1MHpXWXRzMno4Z1dGTEZLVVpPRmNGd0t1?=
 =?utf-8?B?eUVrWHJlTm0xRFlOZml1Smd3VjJOdk5DR0hJeU40Y05HYTF6Mjhtb2tnWnpV?=
 =?utf-8?B?dXlxR1hPeXdaNjBRSVptcUV1S1U3MWVua2tZdWxpR2VFSy8wQ1RObVNtTTZO?=
 =?utf-8?B?Zm81RktWcHJPakVLQThudWFvNE5sRy9NWW1INjhFYjV6ajgxaHU3SFpzSG41?=
 =?utf-8?B?QUVib2dYK3lVOFQ1OHJQVlczWHlJRjdvalFwWkRCdFozYXRycVpMSXh6SDRG?=
 =?utf-8?B?VWtXdUtVM0xDLytPNzBzZEd5N1NYMWwwTkJYcE5FdEd3Q2k2WnNvSmk0dEo1?=
 =?utf-8?B?U0JzYldtdzU4NjUwWmxGZmp6aVpZNDlaQnJlRnRobnN5KzlaQVRrWUpIS0t2?=
 =?utf-8?B?TCtRdXVpcXZjMDk5Q2J4YXlHUTgyYnpaUU4rNFhBSlNyNkxoQm9WSnA4bzJG?=
 =?utf-8?B?MlFjeGZVR2hwcW1tV3NHQkNEaXBDd1FoS3BUS0VKU096ajgvbmo5U2tTaFVH?=
 =?utf-8?B?QVJTUWROTElBSlA3dGJobU9VaG1IcHZzTDRnTUVUamh5QUlCMVhDM3FjQlpE?=
 =?utf-8?B?ckcxZEsrcHQxeDNUS1hCSXIzMjlVZVBSaG5YcUppQ2MvL28xSVNGNjFkaTBj?=
 =?utf-8?B?UzFxRm5LOGNhaGJPaWh0d1o4ZDJxZ1FZOTFldVhEWk1xSzVGTXRRQk50YTNS?=
 =?utf-8?B?Q0RQajV5YzBldnVVN0JBUXBoSXE2MXRZRlFuU1FVYldwZGVPaW1xS3FMNTNr?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E492CA8BC3543E428C7D85E52268AD35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2HyTkz56MxyJAIihN6cAQ07PFAC7Up3IAApm7EkAmEnRKqbW58HOAb7P97jw6ZIcW+zYp8Q7kqhgu+hWvQOEywP1LZUiuALvduYXdrvIqy+3llhYzZeIfRSIhdFBov6/KlNMj8iX0ePaeh1MAZfo50xVgilfLPvZ+MwqI29FlM0LOkAb2AjE0AJ3H49GOdE3f7viVdPe+SvUoSfXdLSeHhWewnoIOy77MOnSvgw9+wR4k5uGG6/Z91sKZ/Cjtqx5GnQkoSUiCHs3ZN5KXu8EXYBzgCr5GyG7KHVWlHePHLnm/lfbitEgt+kRBerBTC62RkwaD+fk7O+U6NXW/t9+6frVyT3rTz1MqKGBDfsxP/psqrx7I12qcVV6gnjupJdES9P48PRwHClXLN3rsFya77Z6oiW5QztGAB7KcK/l2sIZHEYco5khNvXP16MmZsxaVxKXmDMXXyOOT+F5W8E/KgiM2C8Q3LdBJVAyir+FSjq3dV70Hq+0jPeFlDhUMhqlHIolk6rgl8TSiPjSjn0a/9Ac+7AIAspR4d2osYBKJI/8cJG8f7xdDX3l1Mjb/QDNOwUcPfuVqroM+a6yI6TmsczP/6lsFDgEzYIq0H7XQbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284aaefa-3a48-483c-254f-08dc85755273
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 15:36:52.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3i29V43rOJqcJ+eg4lQgD0emjqhvMVyIxE1qstOLN5IoqmQ1dowfgrSIig8cuDCU4d1ZgdBaiCMX5EglxC0gpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050118
X-Proofpoint-ORIG-GUID: QT9eZ6mimKQqJMxnJvlmsRZDqkeea2xp
X-Proofpoint-GUID: QT9eZ6mimKQqJMxnJvlmsRZDqkeea2xp

SG93ZHkgLQ0KDQo+IE9uIEp1biA1LCAyMDI0LCBhdCAxMDozNOKAr0FNLCBPbGdhIEtvcm5pZXZz
a2FpYSA8YWdsb0B1bWljaC5lZHU+IHdyb3RlOg0KPiANCj4gSGkgQ2h1Y2ssDQo+IA0KPiBJIG5v
dGljZWQgYW4gaW50ZXJlc3RpbmcgYmVoYXZpb3VyIGJ5IHRoZSBsaW51eCBzZXJ2ZXIuIElmIEkg
d2VyZSB0bw0KPiBtb3VudCB0aGUgbGludXggc2VydmVyIHdpdGggdmVycz00LjAsc2VjPXN5cyx4
cHJ0c2VjPXRscywgYWNxdWlyZSBhDQo+IGRlbGVnYXRpb24sIGFuZCB0cmlnZ2VyIGEgQ0JfUkVD
QUxMLCB0aGVuIGl0IGlzIGRvbmUgd2l0aCBnc3MNCj4gaW50ZWdyaXR5LiBXaHkgaXMgdGhhdD8g
SSB0aG91Z2h0IGNhbGxiYWNrIGlzIHN1cHBvc2VkIHRvIGJlIGRvbmUgd2l0aA0KPiB0aGUgc2Ft
ZSBzZWN1cml0eSBmbGF2b3IgYXMgdGhlIGZvcmVjaGFubmVsLg0KDQpUaGUgQ0JfUkVDQUxMIGlz
IHVzaW5nIHRoZSBzYW1lIGZsYXZvciBhbmQgcHJpbmNpcGFsIGFzIHdhcyB1c2VkDQpmb3IgdGhl
IFNFVENMSUVOVElELiBUaGF0IGlzIGFsbCB0aGF0IHRoZSBORlN2NC4wIHNwZWMgcmVxdWlyZXMu
DQoNClJlbWVtYmVyIHRoYXQgeHBydHNlYz0gZG9lcyBub3Qgc3BlY2lmeSBhIHNlY3VyaXR5IGZs
YXZvci4NCg0KDQo+IEJ1dCB0aGVuIGFsc28gY2FsbGJhY2sgaXNuJ3QgZG9uZSBvdmVyIFRMUy4g
U2hvdWxkIHRoZSBjYWxsYmFjayBiZQ0KPiBkb25lIG92ZXIgVExTIChhbmQgaXQncyBhIGZ1dHVy
ZSBpbXBsZW1lbnRhdGlvbiB0byBkbyBmb3INCj4gY2xpZW50L3NlcnZlcik/DQoNClRoZSBORlN2
NC4wIGJhY2tjaGFubmVsIGNvdWxkIGJlIGRvbmUgb3ZlciBUTFMsIHN1cmUuDQoNCg0KPiBPciBp
cyB0aGlzIGEgc3BlYyByZXN0cmljdGlvbi9saW1pdGF0aW9uPw0KDQpUaGUgTkZTdjQuMCBzcGVj
IGRvZXNuJ3Qga25vdyBhYm91dCBUTFMsIHNvIGl0IGRvZXNuJ3QgdGFrZQ0KYSBwb3NpdGlvbiBh
Ym91dCByZXF1aXJpbmcgaXQuDQoNClVubGVzcyB0aGVyZSdzIGFuIGludGVyb3BlcmFiaWxpdHkg
Y29uY2VybiwgSU1PIHN0YW5kYXJkcyBhY3Rpb24NCmlzbid0IG5lY2Vzc2FyeS4gV2UgY2FuIGRl
ZmluaXRlbHkgc2F5LCB0aG91Z2gsIHRoYXQgYSBwcnVkZW50DQpORlN2NC4wIHNlcnZlciBpbXBs
ZW1lbnRhdGlvbiB3b3VsZCBjaG9vc2UgdG8gdHJ5IFRMUyBpZiB0aGUNCmZvcndhcmQgY2hhbm5l
bCB1c2VkIGl0LCBhbmQgYSBwcnVkZW50IE5GU3Y0LjAgY2xpZW50IHdvdWxkDQpyZXF1aXJlIHRo
ZSB1c2Ugb2YgVExTIG9uIHRoZSBiYWNrY2hhbm5lbCBpbiB0aGF0IGNhc2UuDQoNClRoZSBMaW51
eCBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBkbyB0aGF0IHlldCAtLSBUTFMgd291bGQNCnByb3Rl
Y3QgYm90aCBkaXJlY3Rpb25zIG9mIG9wZXJhdGlvbiBmb3IgTkZTdjQuMSBhbmQgYWJvdmUsDQpi
dXQgZm9yIE5GU3Y0LjAsIGl0IGRvZXNuJ3QuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

