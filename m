Return-Path: <linux-nfs+bounces-12998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16126B020C8
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06E3A61D03
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508182ED14B;
	Fri, 11 Jul 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m21flh9T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VJxW2b+n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D702ECEA6;
	Fri, 11 Jul 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248781; cv=fail; b=dVWT5GUYmTfL4pRy6SHdkQVGORoz8XuaKbZO7lSGU9weabuLNw21MNQLRVYf2MWQjXNcvW6IFGlDSxRYuxhTPtOHhreMIRjDSkqT8rzZjQTwp840FLaHtP19yRYmPUiDukprGliECeFqKzSGU3tamZsARTdVH9fmTugQeXihpdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248781; c=relaxed/simple;
	bh=L0SayEpL64TzHGyqz6BfwKW75NV4T/hS+plt5jl8DmA=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=BpTRI9zJ7zySat0iQqNu9zdPLCtNeqRTUkUommBjn/o7vNjrc5Prfh8MsNCQBDez6XkavXBmqh8cRSnoQfDRTToTNnDGkboaSOeFn7LxJ4kE8t2P4oqPBET14ov59iHP3hw6VEW8Lcnl8qitMA9zEesxJ3PLbU8Kr3XOdGQKREE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m21flh9T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VJxW2b+n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEpvTH009743;
	Fri, 11 Jul 2025 15:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=JfbIeErsa6D5MWmw
	x1XZb3IIu2Iku97K61BpKN9JjaA=; b=m21flh9T9HAULOOoBPjWO1YYPYyEunEI
	+pX4JH7oQw0BACIsgUTPvGoDY43zy6DP80lGEtU1pDTJwa9F4STJTQiJq/x7aqQ3
	XSpJBwuiDaZRPmu7FK5t6RCZafOKOwypspdlAA1CB6De0h6A159vriOmABccBeFA
	ZjpfVrIY6SODN8qZzJvsGua7UrqyKFggPk6DzjxlgbQKg+o973dE7nZhtNCr2aVD
	ZC/mCMN74IcirkF0SadrDFy+HwnVe4t/hRhu3Ou72JW13Uk7O1f7WjPUblNhn3bP
	c5DUt7DRhqDizsChmVJ6y3/A7OfBhC7RQIV1WJvqueLrlFjNLSA1lA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u4rar3y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 15:46:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEM6RD021368;
	Fri, 11 Jul 2025 15:46:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdpm3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 15:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZ8POJ5O6tMfvgMOvFuWDDU/GfRBcVGQ2fkYUACqCApBuMlIpCMS+8wktO1a1tD+IfEtB2tUfmPdfOYgTMc2YF3QM1yQ1DT61BLaKod02MwtHzqBJHTSaJwnDrRW3G6fFeLjwPfs1KLBJMUIwqHt0i9TspAsPWj+on0etOjT/hUgMQZptCz0rsPeTtNHDgKAudpYWGN4nbNOVvSZ4XXjD8ci7T5Rv5ZCVdzvrzSsVGvWC7531LiknRxjwJwlyOOG0nY7iQj+0sf63TTXVBHJxPUWFrNZbfomZI0PO/BXgiq8GKm/pyOLR73L90cCOyEqnnZjxhqXWyWIfRS8qoEEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfbIeErsa6D5MWmwx1XZb3IIu2Iku97K61BpKN9JjaA=;
 b=aO6hutdgpX7wdyncVTYBJZ9vOkjmSJmwntjXkigvUV+gnq4iNBWqe5XA1/GfIYtLV4MQgZ320WLlKto/b1BMuH21vQmABR9h4p7HgE6oIbvK+2EuYNTEzVPj5Ut+OEkV+qvHZn1UyNMQPNzPFM06v/KEcbKGftd9+Nh4OaPT7TNd73NxnOTHh3MPn00mEqKmvKaX9tGyzYX006sGdE6xz6tg0E/nF/HEcP4DZb/lnUrE/x4e1mIaKaPEaeIPfpQFdhSvH7aiqjFJJMPtyF6+eOR092U2rRihfHfH0tVi+igeyf1i1Lki6wibat0ambIX6LCocuvB9fuCl+ESJVQCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfbIeErsa6D5MWmwx1XZb3IIu2Iku97K61BpKN9JjaA=;
 b=VJxW2b+nZWHHHOuN7FsM3VHZ1jYFogmkFT9NcgDo1cVmOSHZlx4MH0aMNUtFg2bJSWxRxRpxNkbWXwwo7E2JZf4I/ggPh63BrunbLjauXRw/hj7WGS1fsNHMtskAmAkbAs5uHD591n9qDM8aCoRomgs5Dgi5vmKWDpJI442rAUc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8633.namprd10.prod.outlook.com (2603:10b6:208:56c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 15:46:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Fri, 11 Jul 2025
 15:46:09 +0000
Message-ID: <54177836-5517-4daf-8b5f-259edfbad103@oracle.com>
Date: Fri, 11 Jul 2025 11:46:06 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [ANNOUNCE] ktls-utils 1.2.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: a5916953-ec5e-445b-e83e-08ddc0920e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXhsSElzSWFGMlJZREFmVnFWSGRPUkN5SXNNVGkvcTRBQnFRYUtsOWw4TnBa?=
 =?utf-8?B?VVdEWmRmekQvblppeVgyb09nOXNVWUxrbHBXOXplV2Evbms0K0lReDhFdm5P?=
 =?utf-8?B?MEp6Z1lYcGxpUHJ6R1hvY1dVQTFyREw1UVk3dmdoRmIwd2ZVMHNKemJuN3JN?=
 =?utf-8?B?U3NPQnVzNnVYbjhsOUF1YWFrUWZWOU1ISDdjSldqWEVmT1NqSk9lbVBDRlMr?=
 =?utf-8?B?ald5c2NVdmU4czVQUHJoV3J6ZnNKVnVsMnh4ZjdESWVjT2M4S0d1TkYxa09V?=
 =?utf-8?B?cEIwanhpV2dZUVVjMXlsTE9hWXVpQWV3ZUM4NFF4NnB3NG9pcldlR3pKV2E3?=
 =?utf-8?B?dWtpenQ5MXhFZHpic0twajN3bW01UmNUckU2bS9rbk1WVENGa1ArV3RVSWRK?=
 =?utf-8?B?YTRQMGwyOTJFWTZNbThEOU93d2pkeHg4eVE1WGkxaXNOeVpGMk0vbWNlT0gx?=
 =?utf-8?B?VU1Hd3cwTENSS2hQYlZZcTFBZ0hpYjVXaFRIRG1HUHBQY2MxcFBNZG5VenNE?=
 =?utf-8?B?bFgvNGxXc25OZ1VBRkk3ekMzSk9zQTZvSk4vcjJSanh1ekkxdThONnc0eUpT?=
 =?utf-8?B?V2gyTkpjN3BBR05KSEZLMkJqYk5rR2F6VW1qb1cxOWNybUVWUVNaWUJRYWpY?=
 =?utf-8?B?a24rRUJEb3ZmeXJHakVuZjU0dFBFU3ZnUSt6Y1luejNDUlBOUlZ0QjZsbm5W?=
 =?utf-8?B?UzFxTmlJNUxWNk5tQ0RMMGZHUXp3TERGWFJCNUE1VlBUUDRIbC9jdlNQRk9R?=
 =?utf-8?B?QkZJaVVSbnEvQ2g0dmM1a2prTlV0cmc0WWI0UmNnMTVLSzlPcTIyK2JEVU9k?=
 =?utf-8?B?VUhtYzFXdmd3Q0MyRmMyaEpmTnhwOTZQRU9lS2U1aHF3NlBJRzNZQlJXcHRw?=
 =?utf-8?B?L3B1K0JqaTZzWWpxcHpyd3N0eFpCNEM4bGs4V0ZkQWhKV2ZUeTg0SGM5VXZw?=
 =?utf-8?B?SlZaQ0FnVHErQVQ3RDFOY3o2MDlsR0FTQ3V0WjAxMGJKb2c1Skd3LzZyWUth?=
 =?utf-8?B?TmNud2lZMXNzNkkvN3JtV09oTFk4Y2F6VmdsNGlXKytHQXZDSmltTHF1bXR0?=
 =?utf-8?B?bjBzWE1ONGtRVllFTVV4TEc1ZHFYamhxUGRiWTJNN0ZpL0NabTVnSU1KU2pH?=
 =?utf-8?B?Rk1QVzB1b09vRHl2anFOY3hXRk1MUTNERnpwd2N3L1VHbEpOaFMvZ1dTZG1v?=
 =?utf-8?B?ZHVCL251NHlIVVd0UjdMM1FneTB6Rmh3bnJSUExFUTM1SzBzUXlqa05mMUUv?=
 =?utf-8?B?VWNCV1I2OXV1NGlNN21hNitqeFByMlhpL1k3d2VNK05OL3R1UERKeWN2bXNx?=
 =?utf-8?B?Z01SMEZBcG9MKzc0Q3JJY1pBMDVMVWxRbmFSU1NkUkRaZDVQNkhQSzFWK0hD?=
 =?utf-8?B?VUszWHZ5OU1Xd0RpdGpIcHgrMkRMb0tWVnEyaG5VVnVYb2N6eHFZTnVKNHZH?=
 =?utf-8?B?bFlDTVpCWWR6cStONXRkVkNQOEJKczZSVk05Q2xNWEZuRHNJT1ZPQit4OFhW?=
 =?utf-8?B?VENhYWJ4WmNRWTNCS1pHSnZnRzB6VURZdXN6cUFidXhKeXE0ZGl1Z01YeEov?=
 =?utf-8?B?dW91R1liRWYrZWRkN1FnRVFRR0tXNEo0TzYzVU0xTHl0RUZQUmo5R0hmeDFI?=
 =?utf-8?B?VVNuRnR6M2pjVXlGMFNZM0RsUHp5dFladFFvOVFhNWRYWi9rUDU4T3V1aERt?=
 =?utf-8?B?anhXTnVLVUJlM2t2MlBtcG9mK0xGOE9hdC9UT2NONmpQZjQxTUwySng1L2x4?=
 =?utf-8?B?MTVuak9pUUIzK21ibEREV3dXVDB2d3RWYytXNGpQU05rR0llM2hoNHB0SHpm?=
 =?utf-8?B?NUNMcGFGMjBpUWh3WnlQeEthbWNNWW10WXZBUXp2K3NtUFVrU0xsVkQyUzMr?=
 =?utf-8?Q?NCfCdD6RVVq1f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEsxOXN4RU4yeEFnakpqRFVoNk03cEE5YWwydzg1WXpvejdXK0hyNldUeXhm?=
 =?utf-8?B?cks1RlJlKzFLcHNickVWY2dmR1JSSXJUcjFOQWMzUWtadzJRcXpTTTVIL0xq?=
 =?utf-8?B?OHJubW1PUCtHN0c1TmExOWRzbUtFREhobGlYdElkSmpFNUpoeWdscVVjZ2Uw?=
 =?utf-8?B?TFhUcUp3TUx4dzRRdFFSYmNMaWU2RWlSekxVc2didVJIeDBhMDJRcEprNUVk?=
 =?utf-8?B?Y2hmcC9tbjNNcGdUQi9rUDdHdjN6Q0c0Nlo4TlgzSDhKWjNMNE1YZDQrYlZB?=
 =?utf-8?B?V3IrRm1HbWpPcndDVmc5Q2ZXYmE3TXZHMWg4MXJRcWFLUHlNa2NZWEttTFgy?=
 =?utf-8?B?VVdmbGJtd0xmZ2Fnd1NjTFIyY0VKY0NSbFRtc0YwT1pVNnNNZThoUDlZNUVL?=
 =?utf-8?B?Vm1vdi85NmNab0gxMWYrenRrOE5QSEdlMmdWZUMvMS9YTDFvN1Y3bldXMDFQ?=
 =?utf-8?B?WlFXS0VrZ0dKNFQ3bU1uL0VrN3QrclJObEFlVi91bklVVUxmQlJwcjZob3p5?=
 =?utf-8?B?NjRxSS9YQURlSVFTeSt3YmxCWExsTHFEZUc1eWxwNis3UEVmSDlXTHAybXRk?=
 =?utf-8?B?SU9hRHY2dWdGZlFPT3BzOUlWMVhHTmhpTmkvZ05BaGRKT2VjTzNoUmNKcy9P?=
 =?utf-8?B?ZUUreHh1VnJNTEZlaVo2alNnYXNBbE9DbmpwNjJFQ2Ywb25lenJKREJkWDlp?=
 =?utf-8?B?UnJlVmhuQ3dtN01TeVhEeHJ6akhPUmZEazVlWjE4WnJSUmoySG9SQkZpK25J?=
 =?utf-8?B?UHJEclFhakd3c2ZSaTR0QXJhU3VvVFRpVTA1V1NqNjk2bGNCU2MwdytnYnpa?=
 =?utf-8?B?QTcwM1pMcDhNNU5DTGxrbjN6N2ZIK0lBdnphY3BLUjNUSEpHcXFhcS90cXB1?=
 =?utf-8?B?N2dnaStiRTlGTUhUWmQ0QVVrekRXMEU3d2N0TTNqZXR3QzlyWkNkZnRiUVpO?=
 =?utf-8?B?aEFzYnV0RzBqai9td0pGeW80TmN4NkFpRE1PTVRhZXI0MklsY0F4ZkxJaWF6?=
 =?utf-8?B?aWx3S09tK2JaUUpmTkE1dm41Y0dpZ0xDMzQ4L1VJckpKRlhTNG1ReVFLK3ZC?=
 =?utf-8?B?ZXoxeHlBUDlvZ2JnWklxUHVicHo2UFRESTRla28rR1lseWxmU2RpejlhQTcx?=
 =?utf-8?B?Q2JBdS9ZT0xpeUg5VjdkdHJVSC96dllPczA5QjVwWG1sUWNDNzFwd0ZuKzJq?=
 =?utf-8?B?OXY3TCtFNTk5V3FZWmVlK3hUcDcvWUZyVXB2Q1pzUGdKbmFBWXI5aXVPN1Jr?=
 =?utf-8?B?Q2d6YkZoY3pPVFZPZ2U2ZlJmdUdHaUwzS3JFSXEvQUZRbUEycmdHYkViZTcv?=
 =?utf-8?B?ZjFzNFBiR0VDY2I5MWkvL3RvYk9vVHZQK2d4QTdQRTJzY2hMd0FoY01aT3RM?=
 =?utf-8?B?MkJwb0RCZmJqYjNKZWQzbG81eEJHRzlvNmhZKzJnLzBFL3duK0xyZFNxS1VX?=
 =?utf-8?B?cVgzU3l4bDJpK21JVUljOXZ3RS9hSnJBaTRCS05Wc2w0U0svaHJqVXdMOU4r?=
 =?utf-8?B?aW9tKzBsODA0QTBNSmpEQVVHVnpLOTAwNmdNLzZPSzBRR2pidlNQUEZMczh5?=
 =?utf-8?B?RHNTV1QzYzRjM2FKWGtZVjE5S2N5TTlGYjE4TmVidnQ3Zk1TWGNad3JENGdi?=
 =?utf-8?B?cU1RVjlHZUh1Q2lKc1ZWSG1keDR2azRMWTAxczVrLzlVL3pFSDR2NG5qNWdJ?=
 =?utf-8?B?LzZZb1NkS0JhaEkzeUhGSmQzbjIwbnpIT3gyVS8yVHdPVDFhdFRsWnZmM056?=
 =?utf-8?B?VFYxeFRLM2ErTytuNmk2em5IZm9CSWNJNDhBTkxRYkd0WGNpV2lKMU9GSEg0?=
 =?utf-8?B?TUh5OXdBbXhFVFMwbkVPZGRQZ3ZNVXMrYW5XSmhQOW40MTlST1dKRXlKSXdI?=
 =?utf-8?B?b3JxOFI3ZFZLN25wc0ZKQmszQzY2SFhYQ2lvUE0zMERxanJKUEFMblJFSEJF?=
 =?utf-8?B?dmVHWGluM21DOHRNR01wU3hCVk9wOWViVmNBOGY5UVdJRG9vamg1dnBMMnRm?=
 =?utf-8?B?S0R5VHJCSFJId3U2VUEzN1ZNQUtDNi9OS3g1b3VTdWJ1SVRPelBRUjBaOWNP?=
 =?utf-8?B?eDdVOXpYZ0UzbTNQbDdoMUhZaWtSdDdwUXhwVHhNU3FrY2VCVlhtTGh4Qlp4?=
 =?utf-8?B?Ly9yLy9Cb3VCUnJXWEI2aWdWMzJBYjFXWlF5MHptYnAzVHJJYWtPUmxWZ3Nn?=
 =?utf-8?B?bitYTzFmeEgxQTBoM1ZSTDA5VGNmYUl5ZUd6dExGV1paS1FmSExmK0FOZFlh?=
 =?utf-8?B?aEF0cFRza1l5TFRQQ20xa0haRUZBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bUKxgJ972qhWV+u6Oc3Nq4x7EVJuomkO8MPakcXeG0Qbd5wpbYPHvqanjB5pm+GDGXobD77CLp25iMheWRhrVG8t3guknU9kh7uCIS29mLXK43VqpdThtxC50Cx8gKbkeJNe8p0A7+xMlrt+xkgft3wvhQztQQwqp/H17JFopMoFPIpIDtaiVoXEfh/X/yWt5KVmAEWoz2xCm67E6O8y5wjNnngyNqp/U3yTRV43LThoh95lCBuylZvmmkLb0m3XxQYXAxMEMui+yNz7lMgxyjtIRLF4tIWmSdgXneK/IwqghHKXhaM0uARkLQfFqmvzjCm4DduuzlqqzfnhFbLv6rUVBTuj3sX0fIMeJXta7jqxCicfyWSqqKOWwrjDVUR1+zZ4yYJYRDQLe3NgcwVCY4mUn0d33da7XzZUQBtaaCycTtyMYdvbO89t6TBu84BqenMr3ID87BewmHQZvVEZ3zZVZX8Op/5oLQwn6EnusHDheVV6SNF+BRJTQunHyYeLtTlO3MjB5Hp99IfCKEB+Dsy1wNaN7Wqnzh4YFp6pDWyqiS5ADQqXQVUP3RqdI8pBFmyQO9+jTZyCa+D52qWm7706EKmgdmnuVUzj4dHEKws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5916953-ec5e-445b-e83e-08ddc0920e30
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:46:09.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3poQu8505cBOXllhusZgswINeAVFoPdEnI9le4wdiCqkAp9dkZgO9bhbrVJNcLdO/v8DSUaKo8gRBEMzMzZxcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110113
X-Proofpoint-GUID: IXs2hepZfs0MN7YcmE_sfUF3DAtrseqr
X-Proofpoint-ORIG-GUID: IXs2hepZfs0MN7YcmE_sfUF3DAtrseqr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExNCBTYWx0ZWRfX5mDxZ0bYOvI1 9JICb+05n6GQe0JgHqKlii+befX8tYqoQMZVy4bcqapgrQPr+UExMhi92wzEfvNaCrAUpaYTINS 17oZ6yfqvwlHqdX8a3+Mk1X2R7uFq2xZre8kNCr7/CGNqSIT0aApq9I/D63jF8LpfBrRDg4y0Nc
 qZ3dvw/pcPxtz96EL+MiDFb9EJ0na7fQTk5Px6pDpRYlW+xAXPjG8hhHLHGW1NZPUfLQBQlBkF/ CWnQXt5Qm6vFLWvPqapvR4HKxhyi8Z3D1fNoJ/OJRKXHW5ezr8ukCsRNz7WmvpH7PP2M332xuw1 41lyzMfLyYPp0Knr8iWNEmP9HzgM6XfreHAE27VRfGxu7IPYqpD3Mg2MXHhgvtUP6mHaMWoy9C4
 9fGA5cSfr4WszLY7nz85HZ0jNoO0fgz10+OYDjwkat6ZeFVffU/u16R4i/qjFrM4ZE97IrUE
X-Authority-Analysis: v=2.4 cv=Y4z4sgeN c=1 sm=1 tr=0 ts=687131c6 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=CKgEeGIX9DgujmmE_FoA:9 a=QEXdDO2ut3YA:10

This email announces the official release of ktls-utils 1.2.0.

The 1.2.0 release contains an implementation of Certificate Revocation
Lists (thanks, Rik Theys) and strengthens support for passing
authentication material to tlshd via kernel keyrings.

Work on other new features is ongoing.


Official source code repo:

https://github.com/oracle/ktls-utils/


Release tag:

ktls-utils-1.2.0


Release artifacts:

A source tarball created automatically by GitHub:

https://github.com/oracle/ktls-utils/archive/refs/tags/ktls-utils-1.2.0.tar.gz

A source tarball created with "make dist":

https://github.com/oracle/ktls-utils/releases/download/ktls-utils-1.2.0/ktls-utils-1.2.0.tar.gz


Issues and requests for enhancement:

https://github.com/oracle/ktls-utils/issues


-- 
Chuck Lever


