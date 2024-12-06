Return-Path: <linux-nfs+bounces-8397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B56B9E7A3A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 21:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF84284AD9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B31C8FBA;
	Fri,  6 Dec 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gb4Nq0Ez";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A9tf0NOM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC51C549C
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518292; cv=fail; b=HsGm7bTQHFlDgmTtt7QHoMsOPw2QvENyqN3kTbBN219RW3EH8hk/nYQUDtdHYjmX9vRDLaGUYpugD3ebRzRXWJmETD1MubyOUlgqdErXuhoJ9/dYlJeDGbofaYGNFJ4asd8m9MS7R0y+GJBKC/CUdXEP+XYwiRk82reNtDoSRoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518292; c=relaxed/simple;
	bh=viTcDNAKutFBpohHXwBrZXRPZ9mMIjvw4QufmVaGKDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gd4nesAsKvN+FaxUXu2e80WUC5EGKo1r5cIhyNGW8rNm4lVVmqleE3QaPltwJkD+0IyHPNoRJiJwuZms2wWwtm9uySYpn6gqxAX1LSo+CPDyxIHQS15r4kbFNBL9gkIrM03QtRk+B0zjJ4Avf4LG9d3DY/CnmMRQB/dDJilcOYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gb4Nq0Ez; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A9tf0NOM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JMmsd008842;
	Fri, 6 Dec 2024 20:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mttTFuoR23ryWx/9qmh9t3Urmp81ClJ6az5Rm9xgXss=; b=
	Gb4Nq0EznNsg+9ENYkl2b6UDlAgvQkhWZJ/tlhczqgN95zJD4OSMMu0hRuBQ+OsT
	0eJL9JuCMmpLh17smxTOF9YZQHd3o4jVEFNNrpkzDBwZyyrBcT1OVL1odxR4B5Vw
	VuG7zifY4Fqd4kX4f58zRbR/6e6903I3/rxYr/zrthzhrmbxlkw1qdwI7fxOxawj
	/l8PV9mdvf72aKoQ+ty38//lRx4LIBTkjinFbacc+QoATUsAx76wvJo/lPJDvMgh
	rx7hJI5OkB8LVjgmt4y1Qj+JcIlBzyPsCmUtTLc+XmBsFJJiU8x8XFQRt+knfcxx
	Ql6Bz8gzC4JZfGBolUnzDA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sa06dat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 20:51:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Ix4v3036910;
	Fri, 6 Dec 2024 20:51:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5da3n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 20:51:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ+HzIAfjvlWbH8miiRBhLrpwpxTlknSye1+yO9T5U0a5hEiec0z1Lm/aFCAWPCslpDJycjqN5dCoccTZ58iGS5YA2eyy7DCfHHRlHhPTxlfxsCOQsHhAbTLiED5B5Dvc2cpMaLy13Klb+i0r9gmoSeECXHGX1KO1yylcZKXynl28770oYwmqhx9nw4H9Zcmqu8npzxwXv7JVd6xZ0iI0xoX8bQRSgF1PzbF3F2VQzBAWQDhph+39om7FqkzzSSXzSODHGgK6Qexx1J64jIu/mc2WT5ATb794EmBw6+DMy041DVaKyVJ8NujWSSjQppdHLEjQLmyPXxAcawdcCKm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mttTFuoR23ryWx/9qmh9t3Urmp81ClJ6az5Rm9xgXss=;
 b=mxVu23nElD+ZBjgT4C7enzGc74qbDCQZGTnb0ijii6Bb3yr2kmeCggMKoA92nH0vbzxoIbJAAKBSOHdxCJyNv2NilrdfjyaVIA98iVpdEzHsrVYuVVDxlBD/GOgI44E8mclH5pcxtXd6T2iq+bdX70QJvXX/WAmzrO3iBFyJBgkLBto+ZQmvz093J7Qtqpu/Jskoo8zzQeo22HuRBcSRTdAF5TdTv7jbxxD6LNN2mt3vhaqVyYX37C9W0ky+gZnuHiSC7y/k9KCczpoXQJnQgRwqQrqwOXV9DghdrAWqh56ZMnIOXTCVlaCBf/zYh3HnUMKm89iEOISrkwqDfVIHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mttTFuoR23ryWx/9qmh9t3Urmp81ClJ6az5Rm9xgXss=;
 b=A9tf0NOMn5hRLsxDXulDylIrhkFN34W5HT1LIP4lobcAtPlefoNW/2zuwtuTqNH5g3MpUiRFwKoSdx56ZNAKt3k001vMvl68wlPkEWDntJDBSumHlsCZdaONMyMYsy6ePyZ2YiRbi2C76IS+96o5SBsd8KF0ETY4GLd8JXq7sUk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 20:51:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 20:51:17 +0000
Message-ID: <6428e0ec-c743-48b3-85a8-810c8727c059@oracle.com>
Date: Fri, 6 Dec 2024 15:51:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jeff Layton <jlayton@kernel.org>
References: <20241206004829.3497925-1-neilb@suse.de>
 <20241206004829.3497925-5-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241206004829.3497925-5-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:610:cc::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: caf01af2-fe0c-4d9f-d01d-08dd1637bac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHUrcXdUL0pXbVpUeFl6ZEdNdUhCYXFzSTY1dnBzTklscW9xdEowdld0L2Vi?=
 =?utf-8?B?K1dnVGtoVDBVdEJOTjhIYzE1cDJqSEhrMGF1Z2JOVnJVSHYyVm44VnFHcEtl?=
 =?utf-8?B?WVFCUlMzT1pUNHZVK1VESnBuVU40S1ZNZ0crOEs1R3J3UzBieTFSYzVCV3hm?=
 =?utf-8?B?bWlOeHVxSmdsaWh1VVJ1SXgraU4zcHdtZFVlaVoxNU5WQ2ZFblFnQlR4VmZv?=
 =?utf-8?B?VS9OQ1pCVHFIUGRUbjNhaVd2TWhCdXRIZ0JqRHZVNkdwbyt3V1BXblZYa3Rt?=
 =?utf-8?B?TlJDVWd5RXZIUWFHbytkVkk4TEs1bzlUTnZoMGoxRm5tSnJFdEgwaGN4VUhu?=
 =?utf-8?B?TXA2V002WWNsK2NaTWErNDlKYnY5QS8zK2thdldkNUFRdXVqMU52MFpDZjNo?=
 =?utf-8?B?QTZibnQvRFpSd1A0SW05Zy92c085Tks1RTd0bnpQVDFFYnhqdmoyRXRLUGE5?=
 =?utf-8?B?bjJhOVJiUHg3K1RLeWNRTDVaNi9DYWdHU242VWdienpWS3Y2YkZ2MGg2dHdQ?=
 =?utf-8?B?VXl5S2h4WXE5U2IvRmZPSUwyTHJKTTQ5dTNYQlpHR3M4NFZZSFFxcC9RdkdV?=
 =?utf-8?B?djloaDlOZC9qcTBGTDJMcWcvV2g0L1hnbi9FK2U3Vml1MytDWXVQVTNXakgy?=
 =?utf-8?B?bmE5R0lONXc4bFpudnZNek5uV3U3K1VJWTRxQ2hlRit5c2tRZ0x4QjdXQkZN?=
 =?utf-8?B?bXhlTm0wcU8wbEZkblBhUDV6UGtBYlJseEsrQ3RMTlVJWnAzTHBSOUcrTHFn?=
 =?utf-8?B?c0F1MnpZemZ4RzlldkdLWk1Vem5UZThpZUFJL2wwcHlCZmhFVS82Q3BuRWpG?=
 =?utf-8?B?Mk1EbkpGVGw5Ykkvb0oyOW9oT29kZEVITlBGazg2T3JTSlk0bWVwN2QvTzlB?=
 =?utf-8?B?K2RGaXN4UHZ1VWcvRVd5clhwVUpMYUpCZmZiR1FWdENnZk1PQUgwVXI5ZTJD?=
 =?utf-8?B?ZzNKeWxpUURyejIvL2lZUjVuRDdjQzVqdndEc053OTZjR1VtL1IrQThLUXQy?=
 =?utf-8?B?SEZyUlVYMkwvVTMrNnh6MklnVmlkY3JlUnRTUDNwMzI0K2k5R3daSitkaWtV?=
 =?utf-8?B?K3hUeHpMWFBIOXlzWktEOUJxK2tGUmxlNjJvOVR4YkltTEtNMEVNZm5BeDFS?=
 =?utf-8?B?cVR4bXBpWmNFQ2VQWEp3THRlVWVJWk9aUHFyR09teThNOFlTd0NpTmZncWtu?=
 =?utf-8?B?U04rM0lTaXBNSVdEeGlaSlloMGorSE5rRWQxWmg3YW11WWZMQW40bVZyLzBB?=
 =?utf-8?B?bzB2U2phMmQ2U05QdDI4dW9GbTRPbHRlNHdITVlUTFNKdWRaYTlUTXZ2Z0pB?=
 =?utf-8?B?TGp2cFNQSlpJRURPVXhKT1hWcHphOGhBcmlmMndmc01ieEZDelV4WDJSODkw?=
 =?utf-8?B?WC9FbWVOK0t6MFM5OGNxMTV3WmZ4b3BWNDRYNER5OFdHKzlDUUNyOGZEY1Jt?=
 =?utf-8?B?OG9jN21oc2F3d2RLbmZJY3RnRDVRayt5dzlWbVlhT3I5clNabi9ndzk0S1hp?=
 =?utf-8?B?M0MvOTZsRExtbGc0Vm5jTXpScVVpa1N3U01qR0ZDcG00UVhYWk10TUtQbEFI?=
 =?utf-8?B?SEp1N1JUVDMxM0NOLzduZmNBc3pjaHIzZFRZdVJxNDBqZ3lKcGxXZWlkRTlq?=
 =?utf-8?B?K1JvMXBFNmlkV0lWbTE3ZVhCM20zeGlVZkwyMmYya2Fic1UyTWpmT055cnA0?=
 =?utf-8?B?cmsyZ1paYmpSd2Jia20rRktXTDFPclZBM2VIUWwzeDlFM0tUdTJMY3VIbkpH?=
 =?utf-8?B?bVg5eTd3eTRFSy9HVDQ3aHBwd0ZZcDJHUS8yUHp1ZFRIZitsTlgxb2U5VCs4?=
 =?utf-8?B?YllYazdMOFNCdHlpWnFFZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1g5QlFBcm9MNThIamk1d3BmbWZHSlp0VE5WYWJLS3c0OERWN3pxOUt5elpr?=
 =?utf-8?B?eXg4NXl3NmViM1IyMUNTbm1qVTFWL3ZwbzhxdUdySlREamZuTDBGazNZZktW?=
 =?utf-8?B?TThlSVllakhTaUFiNmVIRUpCRjlGWVhoOFVxc2c0bHowckh3akZYTUtyejVQ?=
 =?utf-8?B?M0pNZUw3aG85Y0RKeUY1SFRSdU5qTDR1QVdINmtCNkpJUWhXYndGNWx4VHUy?=
 =?utf-8?B?Qk5HT0tZcHBDaVpNN2phMHJpcUpIcHA1eE5iVjViclp3aVFoRlNQYWlPQ3RM?=
 =?utf-8?B?VWUrbnBFTXpwYXdwNmhpcnhSZDV1MkJTUzlzaXlpSVU4VlhINWZBS29qeHFz?=
 =?utf-8?B?SVhqZUZiS01SUm1lbVdocUFhU3BpZEd4M25IaUhOaTJuMUd4M2hROTdRazA4?=
 =?utf-8?B?djNQOVByaWlpZTA1WEU1aFRYTWwwWlplclJ6YU9kdUdaYStvcHJhbGVLN3dU?=
 =?utf-8?B?dThRYUExYSs0UkVnL2pXY0pvbDIvZXZvMnd3K2xvdmRnSTBWQmhTZHNKek1I?=
 =?utf-8?B?M2d4ek94K2Z0VWt5NkJFTGZjR00wOWVMTjZuT0MwbllWSjlTcWRsOWZ6NGZ6?=
 =?utf-8?B?ZHovZzFXQWdoZ1FsMkJQMFNBcEpMSHJSY0pVZTUwVDZLaUNvbkpWdmRiSGdX?=
 =?utf-8?B?Y0lGLzk4U1dZdldqVWRkUFZ1LzhGVXpmV3dSS3AwZzllSWM4VGFhb1pDbGcv?=
 =?utf-8?B?NHE2dkgwSTgzZFhSeUV0Q0RDd2lCR1NzL1JPK2JRcTcvQytGWjh0MEVOK1dN?=
 =?utf-8?B?VVZnem5xQWovQ1lORjJtU0hLWmd0eFp3R29oeWFLMDg5V3JjVk00ZGtxd1Iy?=
 =?utf-8?B?MWhnTXlDb3JvZkwrYlE4QUZ4RnZMcnRIWjhkc01lWlBRRVd1MUI5MU9Qenhr?=
 =?utf-8?B?TjVPT0Z6amlYUndHUEpkbEM1SncvU2U4c3Bkb3VaVHl0eDd2WnU4cEd4U2tG?=
 =?utf-8?B?OUpPY0JtbDF4ZXJtSHZVQktiTkN4QXhHY3dmNkJ1MThwUFBoRjNXL0VYRUQw?=
 =?utf-8?B?V1M1dmJFSitXMWJiZVdZTmxmczBGUC96eXpQWnBaQUc3aUlxLzZwc3Y3MlNH?=
 =?utf-8?B?OFZ0RTFZeUVQdU9FQ1VNczRDdVhuRmI3Wm5hY1V6MTNhVUxoSVJ3djJiY0di?=
 =?utf-8?B?SlhVSkhXWm5KTHptMkVtY3EramxMSFpTeFpKR1dhYTROWnozbDVqQWp1cFhh?=
 =?utf-8?B?WExoNXRVZGorYU9uazYwWXd0R3FkZHM0OXdzT1J5Y0toMWowRkdtWW45OXkz?=
 =?utf-8?B?NW82KzQrWm9lSzBBaEdDdHpqdUYvVkFzZHFneFQrZ0FTcHJXcC9Fc3BkMnZO?=
 =?utf-8?B?Uy93V0I5QWIrdlRkcGhKL2VOT0Q0NVN4ZUwzM1RtUVdzSm5xcW0rcFM3NHV1?=
 =?utf-8?B?N2E4bzlvbW5jeHZYdDNyK1dMR0pQQldGcFRYNWxDWmNjR1FQK0VKWk4wanlE?=
 =?utf-8?B?aFY1NFlQQW5ITW5xdGVvYWJKTTZabzVmeVVJKzd6a1h3NlVSY1owZkVpb2Nk?=
 =?utf-8?B?Z2NKdEdZUWw4Q3FZWjR4SFl0dHN2Q0dldXNueWpqNkRCd1pOTXBYeHpTT2s1?=
 =?utf-8?B?S1BwVEZkK2NwTGtZc2JzSGU1b0ZGN1hkcEpTR1piMEVHcTl5eWFBVXJWTnlG?=
 =?utf-8?B?cTJmV3dhak0xZ0FCRWZnblNLNHRJZ2JXKzBOMS9iMmwxTjhkR1dyWkU5ZHFs?=
 =?utf-8?B?eXFLdFVtalRnN1owR0oyL3ZWN2JhYS84MDdaTkREVjNEQnF4RVZkN2p5Y2xu?=
 =?utf-8?B?MkVUNCtkL3F1M1NwYU5OZElmOHNWZXhqd1RPUDB1UDZYRE5KV1B2aXMxZHgv?=
 =?utf-8?B?ay9GT1hmRXpJT0xTQml2RWp4RThWV1JNREFRYjg4YUw3RnRtQmF2TlZ6TXFm?=
 =?utf-8?B?TGNLSkJoT3ZTWmZmTXJnWllZWDlCVXBFaXBRMUFFZi9PV3RvQzZZZnh2eTND?=
 =?utf-8?B?bHZUY2FGTVIrNDgxOEVxYVdnZW5MNnVjallrOGFYcVNEQ3dqUlFxbWtEWWw1?=
 =?utf-8?B?dXB0U1F0MERLdGxqbHBkLzJHck02SHdqRFAwd2M3dUIzU0Y0VWc0Q2FjYWdv?=
 =?utf-8?B?Y2huRDkxQXhLdnk4ckJsVElwYmRrWXFpcjNFcTMxMDJiUDBPMEJpNlVMR2xP?=
 =?utf-8?B?MGVyK1FRakp3eThBTkhOVnpwbWFyelQ4dlNyeDVadGFOR3ZhM3hEZGRlMlVP?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MRWzLVLl/5M89hYxQ+mCqvUr+kF+tRNdCi3J+0NYdRrB1g1OzuD35CWwy+agybfhk86EZh/M2tnhskO6DGmI1ygufDcXnXQVSpVXC//b2JmH1seWdgwXk50zs8Y/eADFflIurqPWeBi94E/rJt7Ts/GiKHvddXFUiiyFX8A9+4k6d0dDlccAb3lCnXrJRwGGEs5pGLGlRYe8ABi98OdygjOpq0HDZ7HvlNbAN39bfNsFAY4FFAGgGtveypgwdbgYK6Yk6Uo1vOCoiyrMz30LWE5Imt4x0HA94sPmh+YR0XN/kHtUri7pgZd8oztz4Qby/l4mMziFV+qp9ZrC1tmCkjdOE+y0rvcEDSycn0Q0Yn3U80NT9vvK59LJW0FTST+A9UY/qjUn/0LdJ0emW1mD7ROb/iFIzF004MIyi2CkpDtwQx0o7zrsNeE/F0StGGcvk9BMiHsNBCG6NKVhJzYUYXZtMyMHQTW4re5j33auY3tRmfQx5sFieq3wS5G4Ui3GQszVavQdB01GIuPLzVkB9SAGoUKgQJJk12nhTGKO+PWjxGsu3wa/5fPGrtJ6jQxv1y4sonAQvo6j3fphCIQifbe72bF4ztEg+EjAGvBPQ3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf01af2-fe0c-4d9f-d01d-08dd1637bac9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 20:51:17.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6qLcFO9We4REQAduftap8mTeUpDVP2X1aNhLWAzc8ItcDSMg3EQNgAtTjvc8Rxvjd+IxsJnGZVBpLLLj8wlcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_14,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060157
X-Proofpoint-GUID: kmq2nQo7QAHzpIOHa2SJ1GUu_mCNX_Kt
X-Proofpoint-ORIG-GUID: kmq2nQo7QAHzpIOHa2SJ1GUu_mCNX_Kt

On 12/5/24 7:43 PM, NeilBrown wrote:
> If a client ever uses the highest available slot for a given session,
> attempt to allocate more slots so there is room for the client to use
> them if wanted.  GFP_NOWAIT is used so if there is not plenty of
> free memory, failure is expected - which is what we want.  It also
> allows the allocation while holding a spinlock.
> 
> Each time we increase the number of slots by 20% (rounded up).  This
> allows fairly quick growth while avoiding excessive over-shoot.
> 
> We would expect to stablise with around 10% more slots available than
> the client actually uses.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 67dfc699e411..ec4468ebbd40 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4235,11 +4235,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	slot = xa_load(&session->se_slots, seq->slotid);
>   	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>   
> -	/* We do not negotiate the number of slots yet, so set the
> -	 * maxslots to the session maxreqs which is used to encode
> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> -	seq->maxslots = session->se_fchannel.maxreqs;
> -
>   	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>   	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
>   					slot->sl_flags & NFSD4_SLOT_INUSE);
> @@ -4289,6 +4284,41 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   	cstate->session = session;
>   	cstate->clp = clp;
>   
> +	/*
> +	 * If the client ever uses the highest available slot,
> +	 * gently try to allocate another 20%.  This allows
> +	 * fairly quick growth without grossly over-shooting what
> +	 * the client might use.
> +	 */
> +	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
> +	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
> +		int s = session->se_fchannel.maxreqs;
> +		int cnt = DIV_ROUND_UP(s, 5);
> +
> +		do {
> +			/*
> +			 * GFP_NOWAIT is a low-priority non-blocking
> +			 * allocation which can be used under
> +			 * client_lock and only succeeds if there is
> +			 * plenty of memory.
> +			 * Use GFP_ATOMIC which is higher priority for
> +			 * xa_store() so we are less likely to waste the
> +			 * effort of the first allocation.
> +			 */
> +			slot = kzalloc(slot_bytes(&session->se_fchannel),
> +				       GFP_NOWAIT);
> +			if (slot &&
> +			    !xa_is_err(xa_store(&session->se_slots, s, slot,
> +						GFP_ATOMIC | __GFP_NOWARN))) {
> +				s += 1;
> +				session->se_fchannel.maxreqs = s;
> +			} else {
> +				kfree(slot);

Don't you want to break out of this loop if slot allocation or the
xa_store() fails? Does the session logic work if there is a gap
of unallocated slots in the slot table? Seems like we want to wait
a bit anyway after an allocation failure before asking again.

Otherwise, LGTM. I assume a v4 is forthcoming to address review
comments.


> +			}
> +		} while (slot && --cnt > 0);
> +	}
> +	seq->maxslots = session->se_fchannel.maxreqs;
> +
>   out:
>   	switch (clp->cl_cb_state) {
>   	case NFSD4_CB_DOWN:


-- 
Chuck Lever

