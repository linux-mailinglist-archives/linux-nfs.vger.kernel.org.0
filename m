Return-Path: <linux-nfs+bounces-15841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78858C25360
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24483A6809
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C23431F0;
	Fri, 31 Oct 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U7gUeXhb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pykTVVg7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073A1A8F97
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916410; cv=fail; b=Xmi8sBkboHYIkiVWHkoIHCiCBR047TMAvjGrMRLCngnUcDiQ8JgdobyUI4nUWb68cHXse8LtVlYewsTAW/ctpkseP1mFG1lQy2ZaaJUedkSFRATDe0v9WrPvSm5oqBAx04lSpLk48Xm+2DnIiZjJtKQvnoLuxJDZMD5C0+XvgwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916410; c=relaxed/simple;
	bh=N0J+q6tq4xaRZ3G07uSCn0J9plqaxnvnn5d0DSD1KiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1esl7Br79eKCeHCzXdovi4rtlj/S7g/jbqpzdOQUK2XVicbNmbFS7EwmYGxdDJeVrokA8LCKqMilIYwQJGC+LZ05omDv+BiRqzyUuCTy2ydLoWMda/niRtptQXwDAG+1o4vL3rXNsAvNPkHgjgX4yggwXo2HmBgH7xPlo6UwGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U7gUeXhb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pykTVVg7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VD9NGv004450;
	Fri, 31 Oct 2025 13:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gkmfwjYPc5AhayqDsSCs9TD8rsZhL4DX1EZge3EV5CU=; b=
	U7gUeXhbZexoKhh0kF7FYfzczIi+McrQrn/yV9DVJ12L/kHMX3YxVlRO5y3f+L+U
	T8MvJg3GQV6oU+4eNka80cfvEnM/sVmvV+89QdE23C20iaVpjTaEVs/7pMIx99aq
	hsiLBm2ATyCbpG9MaqCIK/mwlzMU+MVO7mop6VfaSYsBcc/4yBHg9/14rCqIF0dI
	Doiw3TDrad1prIE8lOqwbxqSQWW8KozA98VSHwXXnHLP71RgnIcdEGbd+IjKxtcA
	H0QA3mfqK/FfPwGRJCBk4SVLmMS2lx4WUN5U9I1LS5gPGgI3yUPOC4jpBznqBmDp
	vlIaKFnPsuVYVU9uFxLExg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4wrdg07d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:13:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCx1As000548;
	Fri, 31 Oct 2025 13:13:22 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a4k7buas8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtXO3xcX7k1hu/htFY+wJ8mH8J4wTP6FozB23IICN9mUV7PkaiHdZfqbNraJSPH/GRRjCJikju4SabRCHzChm9QjkntlwIdUfc6+RmDpGBSnD9NWe9KbN5eu5ejF+1MrSJ2WSRewvdO5f496yLc7WhnOk8Lq1k37nCh5XmqV17JVdBQ7hkK/Hw9tGayj38VKtvZSh+iJ2IMiCQQeR7fbhF6rqY0J/Wvk5K7nD43rWShrU4puyt8Lw2dvRL1nvAcS6V9ui2fnAYcRyfVLb3qj1vxoPykZLIHbW3d6Gr7Dyt/n2Jv+RcsN3ivIkMzbQslCGoGdghB1aqg4AmZf2oyLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkmfwjYPc5AhayqDsSCs9TD8rsZhL4DX1EZge3EV5CU=;
 b=RyDLUiEmOAzptIwzijnD1rWZAbrm7L13PGxjB0OU/pv6VBnaweZibf6Ei6WdD57KR7t6TtzP17PR63MIrF+obmiUCTZ7OD8L2w++dwEJvQ4B+7BzAr6WGDMtEpJunWYWadVPJaIHLz8d4dyOK0nZjQohwHl9ycuBq3bT5WDrSycvVhcNQsCmb9tArC7cA0LeFGXnnORJhTfj8W9ah3kiiSaeZiQHoxswwS4fhKqnNU7xZypLmTXv88O+2gpPAha2Hpmes5LSixtZWPiScfYz0y8Ox7wrEPalNlcZwBHQKlRPhmbjRG2GTOT4os85C5S7DaHSIrDONZcn5RASS0alGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkmfwjYPc5AhayqDsSCs9TD8rsZhL4DX1EZge3EV5CU=;
 b=pykTVVg7drgK4Z1xjbskfAKMUrJWJSBbgjVBeOzWk/6mfrjS34r3/KAd+/6jN6TK4OOkQSZn1EgHXG+3ov0E5Z2bkZIcWkTFh177ixOPmNYTQwValE00ee1Rc8asW1ZE7Mv4IY5VdXaVhicyhY+Iw4VuMvGnTZ+vff+9OMgRIuY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6198.namprd10.prod.outlook.com (2603:10b6:8:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 13:12:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Fri, 31 Oct 2025
 13:12:52 +0000
Message-ID: <4086d557-00ab-4e50-9424-212cefe0c0b7@oracle.com>
Date: Fri, 31 Oct 2025 09:12:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] nfsd: conditionally clear seqid when
 current_stateid is used.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251031032524.2141840-1-neilb@ownmail.net>
 <20251031032524.2141840-11-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251031032524.2141840-11-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:610:119::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: e2158297-1d23-4f62-b839-08de187f32dd
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R3ZWRGJlTmdPNFo4RXdFRE4wM0x3QldHWHYrZUU0Nkl3NG1JeTBhS2x1MCt6?=
 =?utf-8?B?Yko1VGFJQ0ZLb1R6dGtFS0twL0V2ZjRjVlk3SGxFL0dzNC80Zy9TZmVKQldX?=
 =?utf-8?B?UlVhMUJhTHJCTnQyU1ArelI2cnNiSkgxSkxDOGU3Y2xJeGYyWFNvKytqOWI2?=
 =?utf-8?B?NzJOSi9KaHVJd0pudVVRMWVaZHIxNExTbUhYT2dleDBadHNzZUwvNjkrN0hR?=
 =?utf-8?B?T1hhZ0MwUXF2cjB6djgwL1NwelAzQkNUOEtLWG9CTC9QeWowNW42b2xybW5s?=
 =?utf-8?B?QTZ6UU5zWnhRZ0RNYzFNeDZCSDFySzNFdEJodXI3YVhnWExjZlRlTE16bk90?=
 =?utf-8?B?OUxQUUdiNUpkelNQSmNzRWFUbEJOajhpaW1la0hlQ2I3YVJrdHBOelhWNjhV?=
 =?utf-8?B?N0RQV0dBWVZZSnJRa2tGeEpkQ2VhQUpKN1lkOUhxNjdTdWdMZ0o5QzRRUU00?=
 =?utf-8?B?V1Q4dkhWVmFsV2c5Zzk3cWNvOEhRTTBFTlZQejRYRWV3VEZ5SE1vZHE5K2xR?=
 =?utf-8?B?STdFeURqbmZ1S1ZReUVIKzM2enR2dDB3cytYVW9zZkpLMTI3MTN6S3F0czA5?=
 =?utf-8?B?UU1QYVlTNi9JK3pDUzg5a2h1SVhseGdRcFM4dkhGK3JVcmNjZStadURwQlZ1?=
 =?utf-8?B?dUx6S3JaV1Q2eE1xT2d4Tko4ZjltS0Q0RW05QmVObUNTTGVOOXhTRFdhZ1pu?=
 =?utf-8?B?S3YvSlZNVEVQTmJVZTh0THl5ZUxmR0NaL3NPZDlUVzk5Mnc0cUMzYmVLTk1i?=
 =?utf-8?B?MlM4Mk9KcjlscllHaHBiRm8waUdpVkNSMkpwMVVpSC82VnA2TlVRSnlLcm8y?=
 =?utf-8?B?RHNESWRtWkJUUGNFK3hWUTVjb1JUOGkyanY4YkhQbC9idjhEcEQzOCtXVFF0?=
 =?utf-8?B?VGYvL1M0Tm5WeVNDN1BLRmZ0K20xWnRZN2VrWGgweFBTdUVKbk1XZE1uN2dH?=
 =?utf-8?B?dzc2V1c0ZEhOU3FHTjJaNm9rVTliVm9mUFRXS2Zsd1Y5UUlXQjFOYW8rdlRQ?=
 =?utf-8?B?Q0ZERmllZ1VEWHdiTkNpa1hmVlNrSU1LS3BpNTYxd2dIZElueGhlRXEzb21W?=
 =?utf-8?B?RTZpMWJqNVZaaXZHeW5zcVV1blV1RHByaExyTk52RjFjVzFxaHJGb3AvMlhw?=
 =?utf-8?B?WStaV0xLYk5INzg4d0JVWDd4bVNLbEEyMVV1cDZtTTZxSjlSK0pTa0d1VEhj?=
 =?utf-8?B?TXYrKy9tRkh3WjhERUwrMjZ5YWxNa3FKTG5RK3Eya1d1a25XeEI2SGZDNmdj?=
 =?utf-8?B?QmtBRXp6T2JaVE9OblNVMG1yek5LRUFuU0NFdG5STVBvQVZiZFp4NFJxMnB6?=
 =?utf-8?B?TXBnQ3dqNWU3ZFpkamVPM1J1ZWc3SjNqT014OXIyTldjN0xQVDM0NUJuRUd6?=
 =?utf-8?B?THFOUDIxT3ZXY2JnYlJ0MGZwcitld1ZIc1JGRW9vOHdYNy9QUzlVaTQ5Y2ty?=
 =?utf-8?B?VEExSEFHSDB6eUV0TmQ4b3REbkpjcERGdjFoWnhlSi9tSTJHZlQvMVZtVHI5?=
 =?utf-8?B?QVFEWWhxN2F0TXRMQmk4dW9remV1eXlDR3ZSU2FISFh3SmlQTlc3TlRNc3c5?=
 =?utf-8?B?cjI5ZEhnZHJWV2xkZEtSMG5UKzk3b2k2SzZOSWJEdmlJTmIxOUpla000b1Jr?=
 =?utf-8?B?SDg2VnBaTlQraUh5OStiWitnQ1dRek5ITTFjZy85UmNwc3VOZjR1MG1adzNk?=
 =?utf-8?B?WnZkdi9UczE3T1AvN0VZV3B4VTA1aEZ6RFhGSmZHNTdmTHIrbVZISDVaN3BF?=
 =?utf-8?B?eWgyR3Y2QlVjWnJxVVpGbnM2WllvQW5rM1kxMkJGS1lXZ0J5Ykc4d29SV2dD?=
 =?utf-8?B?T0JKMFFDcXlER0k2N29Ub0xvLzlLVnU3eWxYWGYwcXFRTzQ0QU4rUDVtNWlB?=
 =?utf-8?B?SHBhcFo2NTVtelp2WWlLNnYzU3NlMUJWRVBNZHgvd1d6UzhLUWZaaWN3ZW5T?=
 =?utf-8?Q?+71SGhnLIvQZi3AgiWsPyb5fhtnNBRvx?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZitVOUNzc1hhVTB4NkE0RXRwb3lHaDZUbVZoR24zbUw5Y3BEVWNtNFVpc3Ir?=
 =?utf-8?B?ZXhZUHJacUpDREpSZTJPU2Z6eTU3SFQrL3RJU1JucEo1OUZIaGo2dDlXeXRK?=
 =?utf-8?B?TG5VdzRHVzNVUTNWdGZLTlZ5NmpzOVZTWklyRkFhSERaTEVJaE9PbEljTHNx?=
 =?utf-8?B?Q0IwcVo2WCtNdGk3OWRaNWd5NHZCU09OcnA3Y0UvazYrV0MvWE9zQm95VFJG?=
 =?utf-8?B?SDNPNHBMN3E3VmVFUmJZaDdlSDc4cjl2dkZLeDQ1YkpUbjFyMTRORnRKbWJ2?=
 =?utf-8?B?VTVPRDRmWitZRXpSMUFyVjV1M3FqN2JXV3hPK2pUUnp0b1JVSzlqV0R4MGxn?=
 =?utf-8?B?U2NZcDVBOE8vbmpXdzdqSkF1ejZnazUvLzRoZ2d5OGtYUFZNZXd2YytmSkUx?=
 =?utf-8?B?TVFEVzhrNW80Ykl6UDAySlp4T2hSdWV5TTdoL0dtYkJXeG9CdjJTQ3kyZG41?=
 =?utf-8?B?TEdMc25JRG9BNlJFRW9BNWdPVkZJekNydithcms4UUY2OUttOXhNMkt3V294?=
 =?utf-8?B?dkhPM2h4Q0hGU3pxREY2M0tBbjAwN3JaTXAxK281Qm52ZTk1VkdiV2RVWnlz?=
 =?utf-8?B?dkgwV1Fqc2ltN3NoTjd6K2cyeVIzckVUMXkyUUtpcm9jcGU4SXNrQnRIcFVp?=
 =?utf-8?B?ZFd2blB6QTRsbVpQTkxPeWRGaHJKdnJZZnhwRWNHZkx3YzFSd3VTWHB3UmhY?=
 =?utf-8?B?TXcxSlhhNmdqVlZ0b1BDdFg0Z2hES3U1bEI0ZHNDZTQ4VUVYOEtsZThZbTdU?=
 =?utf-8?B?LzJtZ3FEaGR5UURYOVB5aFl0N0FvZ2QyYkdsYy83MlpxSGJzWHRGakxrNUh2?=
 =?utf-8?B?azFxN1RQT21idTlNZ3hvd29SNDJ0RDBxZjRmYmhXVFN2VkJkZXpvbWVuQzdS?=
 =?utf-8?B?cWxwZ3lyZFlxTHI2N2tWSnB5UGZxaDdPVU1rOFVmV2c2NFIxUSt2VCtyMTRP?=
 =?utf-8?B?Q2ZrZy9lcXNrUU1HTTcrNGo4em5ORmdsTWxQNGpFdmxCQUFoS2ZpYW55VHY1?=
 =?utf-8?B?N3U2Sjc1ZVNRTEx5NFUvVUUxZ3N1MVZUbkZFeFhmb0ovRkNjbEdSeXAyYkVO?=
 =?utf-8?B?VUhLZll4VUJZOUpGdDJTSmxETlB0aHZNcnYwSDNVZ1RGeVVZWVZTcmY4TnVF?=
 =?utf-8?B?Ym5SQTVGdnNIUmhsYXlkMkpjQjV6bnhQV08xNXVab0RDcEFvNVBPS0p3UzhO?=
 =?utf-8?B?RXpOQStDR1ZPWUlqekVaUTN1Q0I4KzFLZktlY1VhWnZvN0xiemZ1S2I3Y2hX?=
 =?utf-8?B?WURqYzVCdEoybVVac1JJMHltT1JSMHJVWDhBVGhHZHBid1Y1U0hTMVkxYUVq?=
 =?utf-8?B?RVQrc2gzRzl3OWhqMFdXSTdhcFFsa3FFQ0Q0bS9INWZJbzFWUGRXL1JSZmNS?=
 =?utf-8?B?UDNzYSs1bmJnM05vMU5NNHdqemV1dnhJNjlvUyt0UVhON2hpZFFlZjYrYVNI?=
 =?utf-8?B?Q0Z0QXhkTEJMYjhYcURpcm1tZDJ2R3BQL3pvU1pvcUp5T253R1JNRTAzV1M1?=
 =?utf-8?B?djJ1ZXRXd1pVd051RkdEeC9scjJQdVVaNURBOU9DY21aM1FoM0gwbXBsNHZN?=
 =?utf-8?B?N1M4amlnQkc0TDB4N2h3NmM5QVUxWXhRRHo3VHFNbG03Uk9NMlZOV01ObTJz?=
 =?utf-8?B?VSt5dElYT3pvZm1TMkhsU3A1TmNnUFUyWEtWLy92bnc1am8rV0tTajJZSTdM?=
 =?utf-8?B?Y0VwTGg0UEtLVmdxTTNxaG5nUkxOZUw1TGhhTlJmYUw2L2FrRzc5UVIyUGVX?=
 =?utf-8?B?ZXNyUGs0MzNHd040V0twOUxVLzZJNnFPdkx3U01mN054N2FWRTdVdVhoK2Fv?=
 =?utf-8?B?anhCa3I3bGRMZzJ4NVFLUXdLb0dITHlsNEl1TWNNQVdHRGlZRGlpT0pOeENV?=
 =?utf-8?B?ZWVycWZHTTA4VGxPNFYxQzdLQU1MZXhiVFJjdTQ3UDZucnMza0dCQ2l4SlA0?=
 =?utf-8?B?RmlGenV1YXFTcFFxZlRTSzg4bWxUQ1gzaUd3bU5kdGxYa1lNYTBXZmFXaFJB?=
 =?utf-8?B?TjhxMG1pU1o3dW8wSGtVV0FZSVFBbjJvTFJpMkExN3FOcURMdnBCclgzS29Z?=
 =?utf-8?B?eWgrNm9YY3ZRdEUzVmZ3Ri80YVRqSkZKd0dWYnNsUzBkRjZicWplZ0lGVmFx?=
 =?utf-8?Q?Xv/lc7jW2ZWbiBdkpHH0VkSXT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w9QgnHuuN1EcEglFOc3FQ9jlmIAFf6XSLOret52cAK/8xmIkrsW0yrTwzqGbxBlhsiWfSKhXRm3nMBy4rVP6S10lfaidX/zZYNWJ5AQTMFUjb/madp8Ofq8b+P4edKAg+LkF68FCRk6DQpo3Zshvf71J1DrxrIwqSJuPoVeZvOX0PZKTR4vHscLj+jTGWhWsNOMLtp/amP3koNjYKPf5h+dc085IsTnYzdwCxU+PDDGFoQ2YeDroBx2yJjbYE+bpEDHuEZ6+bwhwZXAjxHeq49rJJr4QTABNk6PLzWPy+IiqrBLQFQ+GLdUIi51/qblRmWMaWwqV7L0sGpx2cpm4MyVMeyTcRHkmNgaz9qoq0xQHcN5IO7J0EnIV+NCnNVEa5CPJepGCO3NrkLyRsAaBXljLXG0ICVRCmW4WlwmG8Y/67uU3BD3LIIsZirNBvElouShSmXYcHKMZ7f6kvC0HSZP5DlKY1B68ycGkx3Cqbtdnqkaw26sOjG5tvri67OnWee3e+TJYLZboq5ExH56RqBhdBR5xS7vMABE84IM1hfLiAOOq2Rikc7U6zSzVLEpijYbeY33fvFdnWRvMjg7WbqdD/V5LlN1nNndAAMz0EbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2158297-1d23-4f62-b839-08de187f32dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:12:52.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfHbHWORAXL1+p+df2wv25ULrBmLz/eLGvqgO/OwrvHLLrmavdMvo6PZuxN6n0tKAvJpk8tBuEGIo+zozq29kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExNyBTYWx0ZWRfXx00/brvpKPDr
 rqHZRUFXBxPOXlHDmzJV1FcJJ63JcODFOc4UgKwWMue/GlYATpYdH+etemYxy+CTpywcd9nbJsZ
 5uyNfOHPUcXN2px2vosah8i7arDt0KVwbx8uErrWmHrKvyIAZ9DYwt7cClWJqlPK7MqoJMFAS+R
 JkIkQpwC7XzL3zDD1CnREi8aI5CvYPRWN5XMPLTWefDn7YrsZbd0QrEWJEg8QXIzb8wJLAwG6rd
 43D9e43u/ZyyQ/NClonXOf4t2+33DXObM1HqFpW6CDVRi19kHVd9jg3N8RcxbQV19pQuirwGyaj
 y+ouUl2b/cAivrv0DzZ+PRqc/L8DcXkZmTXWC7SLhNsTnuFWEcVaWTDva7LhrVnGa6nwoLPKB7Z
 u0mgIdal+BaYyu9jh67wvnMiItoJOg==
X-Authority-Analysis: v=2.4 cv=D5tK6/Rj c=1 sm=1 tr=0 ts=6904b5f3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KHcYpyQ9bgIy7Ybo16UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _vjubk-8wFdEjQwFiVnAB9iaFbsHbMYg
X-Proofpoint-GUID: _vjubk-8wFdEjQwFiVnAB9iaFbsHbMYg

On 10/30/25 11:16 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> As described in RFC 8881 scions 8.2.3 on Special Stateids:

s/scions/Section/

Does this change need to be backported to LTS kernels?


>     The stateid passed to the operation in place of the special value
>     has its "seqid" value set to zero, except when the current stateid
>     is used by the operation CLOSE or OPEN_DOWNGRADE.
> 
> Linux NFSD does not current follow this guidance.  The seqid (known as
> si_generation) is left unchanged.
> 
> This patch introduced a new status flag SC_STATUS_KEEP_SEQID which is
> only used for lookup requests and sets it for the two exceptions: CLOSE
> and OPEN_DOWNGRADE.  When this flag is not present, the value copied
> from the current stateid has the si_generation (aka seqid) cleared.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 24 +++++++++++++++---------
>  fs/nfsd/state.h     |  6 ++++++
>  2 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 515c78226a11..553ed2c1677b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7185,6 +7185,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		if (!cstate->current_fh.fh_have_stateid)
>  			return nfserr_bad_stateid;
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
> +		if (!(statusmask & SC_STATUS_KEEP_SEQID))
> +			stateid->si_generation = 0;
>  	}
>  	/*
>  	 *  only return revoked delegations if explicitly asked.
> @@ -7508,6 +7510,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		if (!cstate->current_fh.fh_have_stateid)
>  			return nfserr_bad_stateid;
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
> +		stateid->si_generation = 0;
>  	}
>  
>  	spin_lock(&cl->cl_lock);
> @@ -7630,15 +7633,17 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
>  	return status;
>  }
>  
> -static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> -						 stateid_t *stateid, struct nfs4_ol_stateid **stpp, struct nfsd_net *nn)
> +static __be32
> +nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> +				   stateid_t *stateid, struct nfs4_ol_stateid **stpp,
> +				   struct nfsd_net *nn, unsigned short statusmask)
>  {
>  	__be32 status;
>  	struct nfs4_openowner *oo;
>  	struct nfs4_ol_stateid *stp;
>  
>  	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
> -					  SC_TYPE_OPEN, 0, &stp, nn);
> +					  SC_TYPE_OPEN, statusmask, &stp, nn);
>  	if (status)
>  		return status;
>  	oo = openowner(stp->st_stateowner);
> @@ -7736,7 +7741,8 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
>  			od->od_deleg_want);
>  
>  	status = nfs4_preprocess_confirmed_seqid_op(cstate, od->od_seqid,
> -					&od->od_stateid, &stp, nn);
> +						    &od->od_stateid, &stp, nn,
> +						    SC_STATUS_KEEP_SEQID);
>  	if (status)
>  		goto out; 
>  	status = nfserr_inval;
> @@ -7806,7 +7812,8 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
>  					  &close->cl_stateid,
> -					  SC_TYPE_OPEN, SC_STATUS_CLOSED,
> +					  SC_TYPE_OPEN,
> +					  SC_STATUS_CLOSED | SC_STATUS_KEEP_SEQID,
>  					  &stp, nn);
>  	nfsd4_bump_seqid(cstate, status);
>  	if (status)
> @@ -8299,10 +8306,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  				sizeof(clientid_t));
>  
>  		/* validate and update open stateid and open seqid */
> -		status = nfs4_preprocess_confirmed_seqid_op(cstate,
> -				        lock->lk_new_open_seqid,
> -		                        &lock->lk_new_open_stateid,
> -					&open_stp, nn);
> +		status = nfs4_preprocess_confirmed_seqid_op(
> +			cstate,	lock->lk_new_open_seqid,
> +			&lock->lk_new_open_stateid, &open_stp, nn, 0);
>  		if (status)
>  			goto out;
>  		mutex_unlock(&open_stp->st_mutex);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index c6e97d6daa5f..7566f6b6949b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -138,6 +138,12 @@ struct nfs4_stid {
>  #define SC_STATUS_ADMIN_REVOKED	BIT(2)
>  #define SC_STATUS_FREEABLE	BIT(3)
>  #define SC_STATUS_FREED		BIT(4)
> +/*
> + * Ops other than CLOSE and OPEN_DOWNGRADE which use the "current stateid"
> + * must clear the seqid (aka si_generation). Follow flag is never stored
> + * in states but is passed through to request the seq not be cleared.
> + */
> +#define SC_STATUS_KEEP_SEQID	BIT(5)
>  	unsigned short		sc_status;
>  
>  	struct list_head	sc_cp_list;


-- 
Chuck Lever

