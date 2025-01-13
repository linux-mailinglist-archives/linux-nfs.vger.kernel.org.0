Return-Path: <linux-nfs+bounces-9159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D36A0B8CE
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D41881604
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB922F171;
	Mon, 13 Jan 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YTAhlsqO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qgqKo4G9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153222A4F7
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776452; cv=fail; b=W/hg30Y9o1KcemWSgdIFCwflN/iptdnXHFI++I2Gp4NmnbWk0B5suK/XAYy8nwVeMdzRlpK2rW3E5kNmwgrHFrVfJ20/bQDNqTLIw2uXTfWPhF4Ty8wMP4Kj4lrCDEEkWVIUcW0rl0WrVxsyctqukfSNj7O39aTTAl3DARM9omo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776452; c=relaxed/simple;
	bh=DYn5UWFHIt2beV1PpXJyWtcNFeDXqKRG3tHO5bOzTSA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IfmTb8th3hbDMtgNaKzxV41pFm6W4AaovIkfTrU3HK4pheducpSVhubYYALUAHMccNUk4qZHZQseQHcTi0X0V8tK6ngAS5Bbq7fyWBm53ykHIXGW7Z9CWe/VC29Px59Rv7DlMAdAvA4VyFfkq2ejQUMRavdClamyTJDP3MHYX5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YTAhlsqO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qgqKo4G9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DDi4ww028787;
	Mon, 13 Jan 2025 13:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BL5p4dutvj35uBE8oeVs7vhyRe4CDy7H+Wohg3LtWFQ=; b=
	YTAhlsqOU2Hm62coBeeiMDdu7bfFJRWoMK9VvP+wy9BoGwar/VfLTzADAx8LMd51
	QjXaZt68vbsEfLva5qJHjVDJ3Rq9qP72erX9dWD4RL6JIJW61DmafGGXn5vVIqM4
	xQ1T0sjErhb/pfaULeFPTrvbOkWdOn7NUm+iyqFZmsOkEZirtgbIdAs84A1aa0Y/
	79Zrc+k14A5G7CuPN7UyyxSGuESuRMnZARfSH4VH8249SvV1nSrjXvAAlfOYToLD
	Nd8tGKJp01+ZEDhMSAFiwTrEtUaxjzVUSOYxaifaBbg4OUg5ephlYPtWwwkhPucZ
	LxdGdgB8MIEzvqr5sDGKsA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjakm1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 13:54:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DD4XqF020351;
	Mon, 13 Jan 2025 13:54:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3d8xh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 13:54:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8k21A4pyFd+2oUSbr3bao/tteGr2+eAN7qecrvTRBlkknet9wXSMLaUp5lclf7FRUtbmh9Wo5ia2hU97ncipro65bBnL9nFKf7fNTw36dsApuyVTka6u7dQD51nJ+W6RgNS2LnBizqp9TmWGv++j1EnVUCOppNH4GwLhpaH2mFt5Fn4DSWC+OLHTBaig3PkY8+vsRrRHijAJR3TkHF/Ei6i4s+i9I2J2fQTbaTj7wZiM/OuOhPcuEFdRAYXvWBgdlj1PfDdIJE1kCQecpE/ENKDUdNXNQRemxoupqzUeSKeyzE28JJhlGSSy+oCen1DI6StzlqkuRt7gl5HrbJyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL5p4dutvj35uBE8oeVs7vhyRe4CDy7H+Wohg3LtWFQ=;
 b=vRBXVRq18dpJIm21dOhhIb0zhexPaZZronG03veHrNWIIcb5dAklYTbr456oedZ0LYX5JkMTwe27rXU5hCcXTcp3ZzGCaU35uiOHghhDX1Qr6nYdQWIooomjEMp3wm6k1HVId0MZlVh7gTx+9mDsHZiBrFfTxrK8bXa9Bp+bKzKQGnVbYuTVI8WeNV+20RwV2Aaz1N9BP8xd6Ns9WRStg4lZgfI07UFizlt3BS1AGfOXmcsuyieN7vMSVH/IqnZiUqU16c7WRdZ1gbOeqLVnbksp7DibjWfPHyEAQXlg5uiVZwJflrqZo4QnrdHD3NItGhcAt0h4b5mq62+vbK16ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL5p4dutvj35uBE8oeVs7vhyRe4CDy7H+Wohg3LtWFQ=;
 b=qgqKo4G9A776csEDxsqtQqPo0sG1udJsJDG9mVMfuyv7qePzunor67YG2gtblZ7r/fXakpLuHKZFi4MgrKx8c2j2jwmNV2QPTYtdOMWGJtDrYd6lGSGOwmvFIgjV7w4+tSpwFX2tByOnq2bs+EdSoMmPGTULtXmCNHTy9KcRPo4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7945.namprd10.prod.outlook.com (2603:10b6:0:47::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 13:54:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 13:54:05 +0000
Message-ID: <dcbb68c5-efbe-4edb-8ba9-677bda178efd@oracle.com>
Date: Mon, 13 Jan 2025 08:54:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: Linux 6.12 nfsd does not support
 FATTR4_WORD2_CHANGE_ATTR_TYPE in NFSv4.2 mode!!
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALWcw=EPJk3XFNfXG95v4A3Dq7=spqh5aLYru05r9Lm-eVep6w@mail.gmail.com>
 <CAM5tNy5QamjN6xab3vESQmZJGD2+JgjXvn+qQit=AncG=fTPGg@mail.gmail.com>
 <CALWcw=GGunhwiuGJpA0HarYNiWCAtx8ku-TVZM8jgfDfwaiwcA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALWcw=GGunhwiuGJpA0HarYNiWCAtx8ku-TVZM8jgfDfwaiwcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:610:cd::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c87e15b-2d6c-4758-9f88-08dd33d9be35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djNRNnc3WXhVVXB5eGI0aWNKenM5QVRHbkN2cnhjOWVSYkFWUDZ4QVF3dUY3?=
 =?utf-8?B?NjFVZEI4SVRVaUxFZ2xVUGJxN3N6cDZUNm9hMnJMZjF4eG5teHZMMzFpa1BV?=
 =?utf-8?B?OGlBcml1YlhNY3gwdjNUOWFlZ2lpYW1NR3BYZU1yZkljT0cwNkw3Q3RLZ1lV?=
 =?utf-8?B?S1ZaWTI5MFQ4NzlEK0hKaTR4d0NrR3B0eHAvY0I5NHdWdlRtNG9yemp0QVpH?=
 =?utf-8?B?SmtKSFdlV0h1VnRYQ3A5aUJVT2NudjZBR3NqcGdoT05zdGJUVVExOHB0Q0ky?=
 =?utf-8?B?RFd1Zk9Xamhiakl0SnRORHhjb2FrKzVyMWs4OGg1TU9zcjhaYWNtRkMyczVL?=
 =?utf-8?B?Mm9MVnpmVUU2RGR4cE5FK1YyY1dkb3ovRTVlZFUzNUNrWjRqWE8weDA1MFU0?=
 =?utf-8?B?YjFUVnNNdUI4amlpaFVzNzdEYmRJRUJDRlpESkMwRldHUktIWUlzT3JuWVdw?=
 =?utf-8?B?M1AyMTByMU1jY0I5VU91VFc3YllDY2NBNjZGanF6SDh5ZEJDSVpGRXRiRUFh?=
 =?utf-8?B?cHo4RkxzbWpxc3BhZ1RHS2EzdnZVYXpIYUpvTU43Qkd3ajhYYitkSlJuVjlK?=
 =?utf-8?B?UE5wR0ZzVzErUkMxNWlMRjU0bkFIVVlwWGREWmtRemU5Y2VrUjhiV2tSZmJD?=
 =?utf-8?B?Zng0ZTUrS0svV2U3NFp4WDVyZlVkRnpZUHhPYXN6MHJCNW9iMjNvVDJmZGFD?=
 =?utf-8?B?OXc4c0dzZkdoeGlIZGQ4N3VDZFZaV3ZJQVFzdmY5VE9NNDV0WnBPTFErNGZr?=
 =?utf-8?B?ZmRoZjV2Sk4wV1RvaHlSNUtwSXZnUXFhWFhZZzBkWEtDbWFtbkxDZm5WUmhH?=
 =?utf-8?B?amsyQk5jcjNERkdKYmk1c2liRTl2YVFCaHNpWDV3OHkvVkJFd2hvQTI3MnM0?=
 =?utf-8?B?Lytyb0xtaHlOSHhlbVRyaFVoVG82TEZwcnc0MWFKQk5VYy9KV3poRDlZcExX?=
 =?utf-8?B?M1diZ2MzcTY3RC9qM0RFRS9iK3BNaFd1ajFURWpvT1RHK1k5cjNUQTgxcXRK?=
 =?utf-8?B?U1pScU9SMnRLanUxa3IxU1dYa09QOWY1S3UwVlJjRzIxVnkxSFJNbzh1NXQ5?=
 =?utf-8?B?bUNSN2ZSczdkK0MxdjZOcjcwWUd2SkM2eEJ2bC8vSjBaNXp1S091M05hTkZl?=
 =?utf-8?B?bjV4Y3ZyVit0VzRnNmVnYTU3K0d6SnB5c25NNjVKM0lkcWZFS01mYXE4OWVO?=
 =?utf-8?B?MFdQajNvbkJ3a0MyZ0NtbEtNdkZ5NldXVmZmaFpTK3dtamNIeWMzdXZTWG10?=
 =?utf-8?B?OUpJa0RxSjIycHNhR28wNVpoRGIxZ0VPaXRlNEJiWCsxWi8vRWNrb2dyVTdv?=
 =?utf-8?B?NEczWmkrTytsQnpBSFVibE4xZmxDOXJwQ1B0WmxiTlgray9ram5WN1MyM0x1?=
 =?utf-8?B?TDhrOG9uRXNZM2g1QWxGUXljU0xtdWpjdmRrV09iSEtRKzdSVmorUlkzOGZp?=
 =?utf-8?B?TEZReDNkWjdld01uUUxjZHpONmFwc1FtNzkxSHRlMzRxakpzOUFiTy83QlVt?=
 =?utf-8?B?ZXNxbW5mdkFtU3dtSEI1bVUrVkN5bk5MaVlPc1FVNkhiT0lGbkpGSFRXejNP?=
 =?utf-8?B?YTg2ZjFGMElKTjlHWFIzeW4xWXVaYWEzQ0NTaHJvK0V0OHByZ3VxQkcxcTVj?=
 =?utf-8?B?Y3kvNzlIQTZNeVVRYjBVcDJYYzA4V2dRaUR3VFJaclFPNTdlMWZLNXhoTW1D?=
 =?utf-8?B?b0ltWE85L2NBU1NrbmxYT0RFcnJzVk52MFJtd0VGdjJ6WDZWOHdUOGRIa2Nm?=
 =?utf-8?B?ZjhJY1ZBSWFFdm9YRlhoWUc2UEE2NERMZHNwdlZhK0kyM3BEMU9UajYwcWww?=
 =?utf-8?B?c0xmQ3VwbWN2aFBORnRjelQ0MW1WUnRPWXZnYjZ3SzBRdDRvcnBaL1praE5p?=
 =?utf-8?Q?odDXoEneHD/sA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXZwY3VneTByaHI4dW5NMGhCK0ZYMXFLUlY3SlB5LytrbVJJVVVqVXZOMWZx?=
 =?utf-8?B?R2J6eEMwandKeTV5ajBOMEdxZ0tKSGdmdS94WVZrM0dtYzZsYU1SYzYrUGQv?=
 =?utf-8?B?WDBqNC80Lzk2TEQxM25PWEtzSENkcm9EazZEajk3amFrOEhiK1ZmUkpCQXNx?=
 =?utf-8?B?U202Wktkcnp0MVhmbldERHJ6aVRDSXZrSFZxNnhEZmUwWG13VDg3OU5IR0ZD?=
 =?utf-8?B?Wmo4K085TSswUFA0TFhnVUF5Zi90SER1WE1lamJLVWhXS2dLMzNNOFRTcTNK?=
 =?utf-8?B?TkhFTTJKVDZOWksxcnlqdzlVZkJQMlhmUkx1NFAzR2pxSXJjZlcxYzFLWFNL?=
 =?utf-8?B?ZzFUaWF4NEptYnJPZEgweWYwMFBLOE5PaWs5bDFiL1RDQzQxSGVLS0lyQzZn?=
 =?utf-8?B?WVNLZ2FETSsrZGpaRVdCT3BNVzFIeUc4WmhNdDBBT3hoc0FqbzNWL0VEMzJE?=
 =?utf-8?B?YzRzMHk3cnFYWExydm0wZ2ZCdkNsUmRGald1YysrSStkZWp3T1ZsOVM0Y1Mw?=
 =?utf-8?B?SktoTkZwS1ZjakVkZnQrMzhGM0V2N2RyWlNETDJ2aWg5MS9LL053NkJHcG5k?=
 =?utf-8?B?SzY0eDhhUWlGTFFONUo4dEZFOUl2bjJleml5aHZPYkREcE1lMnhXUUh3c0Fv?=
 =?utf-8?B?ZGV3TmFNakNhbVdwNEo4cG93RXFSeHNOODMzWHNlbFdSZkxLbGwyODlJYlc0?=
 =?utf-8?B?M3ViZTNYYUVsMmcxTk50V3NYTTdaanZXWkJ1bG5NYXh1VTVSUHZoSGI5bzNO?=
 =?utf-8?B?SDBpNjZBSS9WSXpJWGg2NW1sOGdCRDMzczBGK1F4TTBKZnZhcTdCcTBlbFNK?=
 =?utf-8?B?ZWJEVGE0ZVAzbXZpbWkxZjlNbUFCcHVPaDJEUi9OSEcrWXp2TFI5aHYxMUZV?=
 =?utf-8?B?K3hnbW50bGpOWjBFMzFLN2tsbWZpYTd0Wjg0TWhrcFBabXZjMHpQcFhYRVZJ?=
 =?utf-8?B?ajFQRHlZWC9PRThBVEdNU0RKWmlJTzUzMXFHRDUybDUrNWhwcXRycVJvYnBt?=
 =?utf-8?B?TE8vdWtiVTdmVFVsWDlpWDUwTittcXBjTzFROVVDYmR2R3NHYnZsbGlxUXQ3?=
 =?utf-8?B?ZEZvR1VoVXJFa2lhUEFrT0ttWnBONE5FbjNvMzBOY0I3MnZrMjlvT3A3aW5j?=
 =?utf-8?B?NVBIQUNvMzdNaStPOUtZRWR5RnBkblZrUmlJYm9TZHBjT2M4eGpDM21pdkJH?=
 =?utf-8?B?NWg0Q2haSXBGUVVObTdhREt1Q2w5NFg3WERwN3IwaXBmYUhBNW9kUVRzUHVV?=
 =?utf-8?B?Y1U5OHRHZmZVZnNxRjlKV1hxeU1MM29HbDlOc2ZVU3psTUJQRHlRU2hSeG1a?=
 =?utf-8?B?TTcvSnpoWDJZMFE0Tk1QL1hDbUc5a0pOZml6WW1MaGxLN2hQNUhaOG9EMDVX?=
 =?utf-8?B?TGRlazI0WGZMclhxdVJ0OUVPMXdWOVVpbm1xQnphc2Q2T2FqL2xSWG8xSjZZ?=
 =?utf-8?B?SnhUbHZOYzVHR25DM0h4MDE0TFhsVnZvaDdaUXZpakd1Y3E5b0ZxMlc0NWNO?=
 =?utf-8?B?Vkh6ZFF5WGVHNXF2VEhNVnBDRUh3UVhnWjgwblpvTG1hWU1QbTlGVGlSQStt?=
 =?utf-8?B?RmpNT0tiS3JQbHBlck43TjVod1BscnNxRktxMjBVUU4zYzN6bkJXWVNGMWhi?=
 =?utf-8?B?WlpJRkJrNkthcWhVMm1aNjVqUFpLclkzZ1ErNkhSWTkrckNwSXVscjNRTHh6?=
 =?utf-8?B?RGFteFFiMXI2c0QwejBwSVVKdjQ4bDdYKzZ2dE8vQ29zRTVWajNLekFqN00z?=
 =?utf-8?B?WTdpcTJsam9Ud2VCU1o0TU9ONEhielRDYTNObldSYm1JOUJVQ0J6TC8wOVM5?=
 =?utf-8?B?RU15SEsxblQraVdqQk53ODJwZ0R2Yk54SkNITHFKVHB3QUZPVkp2clV3TWtF?=
 =?utf-8?B?MEZ4Y1RCQWt2d0JrRlhSRHlwLzR0WnMvOFpyOW1lV0oxQTJmLzdBSmFLWUNL?=
 =?utf-8?B?VHduc0tIY0Jsc0dVUXlieGYzS05kYkRDd0JZeGFkS0lTc2gvbURpV3gwVTFC?=
 =?utf-8?B?cm1rQlVNUXdRL0NFRngreHRCMUlaOU8wVW56SHprM0ZWT2JPUE84UDdEd0pu?=
 =?utf-8?B?eGx3emxTVlJqR1JiUFliYWlVajlOUEh4THRsOHNla1dhSkoydXJDZnVUd3BT?=
 =?utf-8?B?NXh0QnFRSUZpbk9CcWlWeWRMNi84UmtoeHhCU1BaV010VFNNN1RqTVQ4QjhN?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CTd9UPIo9dgA+DPVB6TdoRtdOdk/MeF3ICPZOxMtQwfBIEVySDWon5oPiD0KL8pE0ZMrwphTPy6oyVMm0PSHc8AYOalpVQltTapUaONKE72eYv7hgaYj/8LJ27y06ASMKv00PlMCBCI5/EC1LJOhgUI6Qg/7gZ6Dv/+0+F89EUslcSWIQ+U0X3U1yioVRa6YYrmx4xAzi3SB5xpZkj4xorrqjvZX/iWNtyrowkaQlBASmyF2wmwgAqbfBwqeIh4m5dKkBq3qb1XoZqOl82eaOyuOyNxo4nj+a/5Ttt6IXP0pUjgrWO8qCww5iRT1H/t+QaNjIPkRWjP7449Hz1g31pysQi9+S9ViT9NH52SPLpfqwSEErabq8FuUSvc3KXfH8YfulysRPZ0FHwqkeRm89gVtRE9CtlHqMc/NbuZXv88UFaFoWUC/VV/H3/vDp7eXRmQIexN7kYbX7CeGJuTcZDmrtjr40Vxmr4hmG3oTsLapkTS0LoysCftxAjrvohmRZc/75P80DOZMjNqqsyx4kRAqMBwm8T5/KoxtOtWZpHDP/wNGqJIUa4nb+AgV5W+EoU8Hz2FSq1v00W3KalhenxYU4KP5BUhLotrTed/eB8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c87e15b-2d6c-4758-9f88-08dd33d9be35
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:54:04.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTzSMHfg6K+JHU/tsxE4hoeS7dmA6g/MW4B9VkpqSSBD3PxHQ7JZ3fhcW06cVpeCD8+xYTrPwWqPOQIgrJPRfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=983
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130117
X-Proofpoint-GUID: Z2fLPgQIy3yLKyvsQyr1cjRYcYqKuunA
X-Proofpoint-ORIG-GUID: Z2fLPgQIy3yLKyvsQyr1cjRYcYqKuunA

On 1/12/25 11:06 PM, Takeshi Nishimura wrote:
> On Sat, Jan 11, 2025 at 10:17 PM Rick Macklem <rick.macklem@gmail.com> wrote:
>>
>> On Sat, Jan 11, 2025 at 12:08 PM Takeshi Nishimura
>> <takeshi.nishimura.linux@gmail.com> wrote:
>>>
>>> Dear list,
>>>
>>> We tried to use FATTR4_WORD2_CHANGE_ATTR_TYPE with Linux 6.12 nfsd,
>>> but the server does not set that attribute, while it is mandatory for
>>> NFSv4.2.
>> My understand is that nothing is mandatory in NFSv4.2. Everything is considered
>> optional extensions. I doubt any extant 4.2 server supports all of the optional
>> extensions in NFSv4.2.
> 
> That can't be true, or would be a bug in the NFSv4.2 spec then.
> "Everything optional" means feature support gets fragmented, and
> interoperability will cease to exist.

Hello -

Interoperability in this case means that the client is able to determine
whether the server implements a new feature, and then not use it if the
server hasn't implemented it.

There are protocol mechanisms in place to ensure that clients can
recognize that the server doesn't support any feature introduced by
NFSv4.2, so it is entirely safe to make them all optional.

As RFC 7862 points out, when a server lacks support for
FATTR4_CHANGE_ATTR_TYPE, the client is supposed to behave as if the
server returned TYPE_IS_UNDEFINED.


-- 
Chuck Lever

