Return-Path: <linux-nfs+bounces-3985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7154590D2E6
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FF31F21112
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C305915383A;
	Tue, 18 Jun 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lYShLPWJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kty0Cpr/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDE13B58B;
	Tue, 18 Jun 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717467; cv=fail; b=Iqr3WcDNTM8cE6EQxLkerC1znCb4dzBHqAYDoqlKi6xAZ+XGYbrS9CRh98ylDPlgcFC2gPQRo8UGAbA/JhMep0rfAYeIxkgb9ejgA8GWP+xObstOEnpbgq4RWq7DN0hxxOJk6XFQM1AEwMD6dF4g6UzXvPnxVH5nj1S8id22bHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717467; c=relaxed/simple;
	bh=E4z/vYz70RhvR9BUtfmWG+L8ZFviBUd48Bmtic/nV3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=trULdwFDfF1+uyz3b8OyV/mrY1QG6xGzrGTIZPv5YyqmFWgA16rFnvu2A322EdblteJb3VXJRw7MuvBBI5TToyYu5vfobEVsOwJj7/dfuXzA4mUItRz/fn+rxDCnMAs1WTJczvUTS6JYK8edMND/LtqNLPxvWlnJy7IoOy2u6vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lYShLPWJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kty0Cpr/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tQVH014702;
	Tue, 18 Jun 2024 13:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=E4z/vYz70RhvR9BUtfmWG+L8ZFviBUd48Bmtic/nV
	3E=; b=lYShLPWJQUgsASca305AG1qaJwK6pZkt/yhq3s4333yVeGKiCGakroJiM
	qYhCh2G/XOZMKjNjLytOV5eOqZx6b62M+HTlSzzDeL53w5Hr0EaiTBwwK0WgZDUS
	31ixQdF+ygungn4Vu0W9kS9L4CBW+/2ZuPjD3CrlbjApRgYZiO7PvM+Cq+PuhPvZ
	79CQQnFkQ6jdvGLgE1KiHFUeFx/2kRJI/dcXQAKzEmkzaqIROZ9w37DSDwPhqUOB
	WzajB+tn4Movx6yUvL6Uwr46zSTC0Qyh6eQnPUzJCowzL9R75A16xYAlw1MgOqw/
	Qb/foywey6/ezrekjwjeX8Y1GlBqA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1j04xqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 13:31:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45ICwZSK031924;
	Tue, 18 Jun 2024 13:31:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d7v014-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 13:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/dOU+ReG2pgoBWBrsIssGmYkQjkpVR3Ctjz4ylQZTtfSo1H+SNuLUifxX1DnZADE5hIq35TbU/ySvU6ZLm61bIhqN8lqbnNCRg1jy5BgjwlqxTHUYZSEAh6p/Osepo28oqHIwNLow+AjFttFQY6+a0/6dElQOOb0l0WFx0nsHqnjH47fB3gdjdXYzAcReb4SkydIdd+soBF1kCI9xzNMKlcxHL1y6HCMl5RflIyAmcPUzYtebn545n0t7mO4PKPNtFaZJ66JxQ4sfB2s3qIJw8goqmp0NpBo6ZADSR6U1szWfnDHsGDFvkQvwvQdn2RAzGfUIFnSpSukwxJW2gk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4z/vYz70RhvR9BUtfmWG+L8ZFviBUd48Bmtic/nV3E=;
 b=aE8sWDoI+JjCAxuj2lYVKVsKCF1zw4+M/oMoHoae7HHJOFVoHf+ZfuKdnoKeT47xYiXu+J86S2oAvgIfeI+tCI6iXmH1fDmcdDURlgpLcvImVFRnBtdAV8tb3Zd+232d91Z8XwpXcoH8H2hzxjQ6ZAqG0Tv0PcyNIClRJvmmYkQBBQwwQkBS5UvaDzY8nliBNJHuq/XoBbVADG3mmUkZXvk9U8FmhSM5GKm1muSujhumwuj9YYBDPqdBmvBHxXJmXLJyqEN+pWLIUsEUR1JEws2V33xiUHxeTNlPRAWojlkTL5/sjXh+bdagNERode3V7NlKbSAs0I6xJv5Dz+1sew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4z/vYz70RhvR9BUtfmWG+L8ZFviBUd48Bmtic/nV3E=;
 b=kty0Cpr/avc/9gFVqfpMRX4/kwpYX3DYnkv+91x019eRhwcMWIqQQm+S+g2qd8e6LRjAlYM2Bi/MkrFq8cZBhc/T5r4oaG6lVPZ/n5zHljDH2F89ZsLM+c/DbR+EGBmQHn5WiILCFw2MJKAi70sXrlyRaecatQ4RvpV8aTso3/M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 13:30:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 13:30:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [GIT PULL 5.10.y] NFSD filecache fixes
Thread-Topic: [GIT PULL 5.10.y] NFSD filecache fixes
Thread-Index: AQHawYPACmGJPAPuL0ixPhZ4ThuT8w==
Date: Tue, 18 Jun 2024 13:30:57 +0000
Message-ID: <54128DCA-60A6-412E-98AC-B8BFD12E501E@oracle.com>
References: <ZnCO88W37FXg5CV6@tissot.1015granger.net>
 <C268A974-80EA-4F44-A78D-460D881A00C5@oracle.com>
 <2024061849-impure-identical-ea0e@gregkh>
In-Reply-To: <2024061849-impure-identical-ea0e@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5006:EE_
x-ms-office365-filtering-correlation-id: 2037202d-4e94-405b-ecef-08dc8f9ae2d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K0pQN3BmNTFrY1hpamlaeXZ6NnpCUDF6UHZQUVR4SFFoR2Y5UnF1QkNwTS9r?=
 =?utf-8?B?dXdwdy96S1VUNDF2Qjd6SVVoVUVHRmV0cGJiaVZUVFVlbkJMM1hBU3ZKbm5B?=
 =?utf-8?B?eWVKb09XNDBWejUzRDVNVUZFcC9HRXNTSnNFTVEzbnV5Y3plYUtzYXF5QTE1?=
 =?utf-8?B?VGpTMGQ3QVdYdkRVTHIrT0tRelcweEtFYzA5SXI3MWRLSU9aNkNuMFBmTDM2?=
 =?utf-8?B?czJONVAzUTdqaUlCQTlkQkN0KzlkUjRLUDBzZXNFSGpiV2lDcW8yTTNtc0Fm?=
 =?utf-8?B?WEwzUFZCL2cwSlVOU2VnUG9yUmhHVyt4Zk4vSTFnQndLbFVEYUVENkFxWExF?=
 =?utf-8?B?Q3lVV3I3d2w4WktXYmM1cU45QWpZVERqQ1NpQ3BNRXVvMU5UdzJacitQREFv?=
 =?utf-8?B?U0Y0UmJyVGtjMXBqaEwrQW9HS2J4TzN3WXVleEdTSmZxVk8rN1NIYXRwN1VY?=
 =?utf-8?B?RWZ4VUFGSFNoRHpYMzFoMkZFSU5VenUwL0gvT2c3Mld4bG4wdyt5eTh2RWdm?=
 =?utf-8?B?OGw2TXBRSHpzUnlmckxPdVVGVDhvNGg4VUNicXN5R3hTU0xaWVB0OTVLRnda?=
 =?utf-8?B?eklRNDJIaFBpalkyVUk2aFR4Y3Rnd3pDbFFzWFdrM3BHQTgxSnhYWk9CMlJi?=
 =?utf-8?B?VnllMnE3UndIdXVOMk41dDY1SXZ0TlZGSy9lRWtPTE5KUG5ZQ2dEUjNSS2xo?=
 =?utf-8?B?ZEdacFNxN3R1cTJZTXI1RmdrVGFkVUVMQkZuMHdmVjRka2VnVE1EYk9XS3pi?=
 =?utf-8?B?a1p6UEp5bGtRdGFpMlMwYkUzYUpRcThuSlJOWlNtaXQzSS81d2UwMDVmUWs3?=
 =?utf-8?B?Z21aZzdsMzZDcXg3bmR6ejA5UldMZ1o4aHR4cWJ4V3RYZEpyU2d2LysrcDBL?=
 =?utf-8?B?NkNxM3NoWEdYSGZSSzM4QUlRWHByUlBXTHdQRDIwUFV6b1VPUENoeitHVGM3?=
 =?utf-8?B?UlNpRFliRzM5WEdLZ2o3Q2VIZi9aZXdjc3NlakJzQWtIcis5anJUZzludkZ2?=
 =?utf-8?B?MndneDBuMDVRL2VVanZKWVJFVk5VejJGb0gvNTkwRjRHNVdQL1dMbEhaRjJQ?=
 =?utf-8?B?TUx3eVR6N3kxUVlVV2ltakNnWXlmUGtVZGZxem5BMmpkVkx4SEx3bHczTmJP?=
 =?utf-8?B?Z0pDQUdKU0YzdVBWb2pUT2h0TlNmcG5RaXZpQ1VVRVE2VnR6M1N5M1llM3R6?=
 =?utf-8?B?bURwc2FlZ2g2Y2Z2Um0zeUJpQTZuWjIwOElLaXAzMkZsSjdadUhlS1dZUUt2?=
 =?utf-8?B?WVdCVjBkVjY5dzdpcTlYZmxWbWNXaVQ4Sy9Yayttd2lxdE5vbitodlR4TGdx?=
 =?utf-8?B?c0RHT1N2M2xGRllkZk1KRWxaRG5mMzk4Z0JTTWwyVjBHc2NqbmZLRTFVTlEz?=
 =?utf-8?B?RndqMWMrRGUrSTE0ZG5MemxnNWlqaThWT1JQVjFjSmk0SHpOTnVCNStueURU?=
 =?utf-8?B?M1NmUUJWNWNuTEZJQnNWZ1F4VUN2YkdnaFJoT3pHQVhHQ25OdHJnSkFvUW0x?=
 =?utf-8?B?K2JFeExxK1hEMWMxYmpCa1g2QWU3U0hIeS9HTWdzQUFLT3hlbENPQjNRWCtO?=
 =?utf-8?B?TXdpdkhZUlJGejk5Y3JMY1R4STJ0c3NQQW15ZjdvZ2t4ZnM1OEN1Z3JkeWlH?=
 =?utf-8?B?TmpNOEp3bDc2WEJBemN0QkZMNzV1MWh2MGQ3TnpZLzZvM0FScENtN1RXZWx6?=
 =?utf-8?B?SDJLSUZCcVhKbXZZeTlPeFBDYm8vZEs0RkorekZGUWc5VW1oaElXZzJxYnBJ?=
 =?utf-8?B?S0sxSEdQdVpVclVBSkkzL2RzZy9qTStraElCSEtoajl0bExuaENMY0w2Ujc3?=
 =?utf-8?Q?WJwvEC1F7dltVsVrUF2HwmEaZ8H3dIM/YSB4M=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RlZxWU1BOTMxclYwL2IrbjJhRW94cWdTRFFFWC95bEZodUd2a3lmQi9VeWR2?=
 =?utf-8?B?NFJMeWoxSm9WOGwyR09HbzdhSDYrWW5tS3BvNWhVa1pVaWVTMEIyVUVEZFdi?=
 =?utf-8?B?K3pkNEV1dGsveXVJeTVDcUhGSGhXK3BYRU5wcmo0RVFvUEZpZGlMU0NXdkRC?=
 =?utf-8?B?QW4rMFdlUFNyay9QNVl1czVxVUJTOEVQVG9YVnRBL2ZoalZXVGVMLzhBaGR2?=
 =?utf-8?B?cHc4UGF1OXRzQmp4b3cvRHZURmJLVlJZaUhJZzBwT1UwcmxaNG5vaHFJWWVo?=
 =?utf-8?B?ejhzZm10VHFIdldrOXJiQ0N5MEMyZFI1KytYazlaRW43eTFrQ1NaQVhQZzI1?=
 =?utf-8?B?c3pOYWR0QVdDTm8wUWJVbGFsclc5VTBFTFUrZFVDempiUDhieDVmU2RtMkQ1?=
 =?utf-8?B?dG5BaFRXZlY0N1pYMU90cGRFRXJrcjBrcllJeUJhUXQwSzVjS3ZnUHNMNG1R?=
 =?utf-8?B?M3B6UjlMQ0tKWHF0bldiMU45SC9uVWFoUVVqUXBwTVBaNDF5K0Y4OHdEU2tV?=
 =?utf-8?B?YVdNUWd0TFRSL3NLUmE4OWRycGZ3K0t5dTBRRVBmbU94Z0IxVGt3NTRQT3JK?=
 =?utf-8?B?ZnBOUUNwNkgxYlBNUVNDNkhTTUhVYVlBalNrVmJVMmljM1RDa050aFJJYTdq?=
 =?utf-8?B?ZzRhL1BvUTZqYjk0Zi90NVZVbXFCRU5jM20wVlBsbVdudUZwNllyWmRhQTRr?=
 =?utf-8?B?Z2xTaElkK09IcmRUZ240UW5keU8rOVFkUjJzcHZZWW40QjQwMEcrUWlXU05v?=
 =?utf-8?B?T1ZTWUptZ05VVUxXNlFpblpQTHRxNHpxd1JMMXozYkJKVG1KNEwwdnJnaG0r?=
 =?utf-8?B?NVpvdkVKYXppaEkzWlJ4REk0TTcwd2VMNEdIRUN6ejdDck5sTGgybUFvZW5K?=
 =?utf-8?B?eUFpVlNCSUZHcGhBd1B5dGJQNlBWcHFCVlBmMHhIRUVtbVROaG0rcW8yajVT?=
 =?utf-8?B?c1kxZ2xBelFsNjZldnRDb1YxeGJyTE0rVFA2bkVrYWNOQjh2MlFDNmJheUJW?=
 =?utf-8?B?aXBpYytLckcrQlQzdW5SeVhxNmpqd3BWR2RMaDJwL2d3WHhvZ3hBOTV1eC9k?=
 =?utf-8?B?ZHdXbDZPSXp4WE5JMUgxVWVielpHTFBWcFRFV2liRjZtWkhMS1hwRG44b0Fx?=
 =?utf-8?B?TlJXU1Z2aUdZQkErY1hMOHQ4RmZqdEV4Mm9FSG9zRi96ZXhUa3hqVjJGQ0ZN?=
 =?utf-8?B?cEZUMDYwU3NBZ3pHODkrSHBPWklqZUJvVGVkVTlPYWZiTVU0b3d0aW9uSEly?=
 =?utf-8?B?UmpxdUR4RytVRWFPdFJRMGgrS09BaWhYZHVWRzVQZURPeERPT0ZnQlF4Qm42?=
 =?utf-8?B?RWY4ZGdBS2VETHN6Rk01dWZnZ1FNTzVQOFlOUHUwMzhEOFczUSswWjUwM1Jt?=
 =?utf-8?B?aEpINmtJdzhaZ1Z2c1NpWkFSUWtGbkNsMEgwb2JFSHhjWGF0QVE0dHhTajVJ?=
 =?utf-8?B?ZFp0cjJWcFJFNXF2Q0pnS3BHck5YUkJuTVBrL2VnTUhOZ1RweHEvM21QbVBH?=
 =?utf-8?B?aTlTY1hFRlQ5THhPWHVyYmRPT2pjTEJRZVlYKy92VmQxbEo2SVFOMFUvdWsv?=
 =?utf-8?B?SlduZVVnRjBGSTQ3UnJvN21PdHJOM3M2Rm0wZmlnbFFxN2ZXWXRYZFQ2SVk2?=
 =?utf-8?B?bHlWWXB2RUhCb1h5OUxqSC9Pd0doUjdXcmdFN2l0cFhtdlhCeXRPZzdpeG5U?=
 =?utf-8?B?TC9HdC9ZdGdybXhLdWc5V3FmZnRUZE56QUtEQWNTWnJ4akhPbTRqNkdpYklO?=
 =?utf-8?B?YUdNQUhQS0FIbG1sWGRwWCtVQXdreVlGS2VsQ09zTUVPeTh3ZWU2QmVYRmhQ?=
 =?utf-8?B?dC9BR0lpcGZyWmdjRzhvczhaSlF4b2JLODNRTjFqOXBReFpuQkhrcVFiUHFM?=
 =?utf-8?B?WHJqQUNFa2g0YnNZaUFFL2ExUWN6bkFTYkcvT0wzbi90Rk5OdUx6eDlSaEl4?=
 =?utf-8?B?T1lrZW9xTDgwUS9LV242aThJWW1tUUtIT0RYS0RZL3ZQaUFSWG1BaUxsS1NF?=
 =?utf-8?B?UnNDREd0M0dHMHZKQ0ZzZUpFVXZ6SlBDT1lxQ1JIV0VtZ3NYOEdzaTNjb0c5?=
 =?utf-8?B?U3lBZ3VoYUxLZnkrK0dscGNUZHJMTlY0VlgyUm9ueFJDblFhb1V5Ulk0WUlU?=
 =?utf-8?B?Y3ZuUVR1UGFFZjkzeXR5djJFY1NlTVVrM0g3L3pLS3dzeXdWeWpreFc3eGJh?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45A4155761931E47B646F25D8F3D69B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4gGPltMO9bdUKvp1j7Z5pvKhwVM5f+OANopWPtLPr9TxLJOp5tplrFdEM0SHjRKT+bSIIj6qwOB8DvmEGydXx1iiQH8uuoE2YviLHWIUkyAXOpqoq3OKYGHXYlFcaMDsz7Mz7Td28fY88gydgsCArfnWWX42yB5/eotLjkWHgEiADBwjiwesQcXAUUf4yJNR+gfAnXnxuqYlqgfNL6eXMlfyuUq5TB37hM1BwHOeUQNPk5+hEKJPcM9bt8DfWN4Z2UzkOc/q7bWBNyXP7yr2S3l3nwmMho7+GP/7gbtmsBUzxG7Wb9Sl0Mggwav5L1nNYpmqHY0BW/hnimA/1y/Y4fRQcWpuXPsE94nmbHlXdcvEd8rxPCyrad5beA6woL/LzUBGg0NxY6oDXSAxfAWwPOedxruKAYO5ZIUSzOEOxuq6NUHJF2QQwAjcCNxaN7MAnafu/A7AaR7OwK8505rGBeFpN9XWwOFbu6av/PReU5rOOfTkDHA3JFprW94xtd3pQppCCw5YaKdmRNGbRDmowZvGOA6+OngT5VaX1QWL+qWMHIED88Cn2MEGj8IOyG5pYfjdAxFZRQIXZpLyJ7CU7QqxIat76ZgjE3ZnHz4vovo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2037202d-4e94-405b-ecef-08dc8f9ae2d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 13:30:57.2769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pLyzo86CqM391hjkjePLdgznDMWfSOD7EVoaS1moVKU6IZJOe+8tR5I+MGqNdkznjRWOdhMXqK7yOKBFL6Ypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180100
X-Proofpoint-GUID: itygVIdfZ8gqAAtk9MQjVTbSlC1Bz0mj
X-Proofpoint-ORIG-GUID: itygVIdfZ8gqAAtk9MQjVTbSlC1Bz0mj

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCA4OjQy4oCvQU0sIEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKdW4gMTcs
IDIwMjQgYXQgMDc6Mzg6MzBQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gUmVz
ZW5kOiBDb3JyZWN0ZWQgZW1haWwgYWRkcmVzcyBmb3Igc3RhYmxlDQo+PiANCj4+IA0KPj4+IEJl
Z2luIGZvcndhcmRlZCBtZXNzYWdlOg0KPj4+IA0KPj4+IEZyb206IENodWNrIExldmVyIDxjaHVj
ay5sZXZlckBvcmFjbGUuY29tPg0KPj4+IFN1YmplY3Q6IFtHSVQgUFVMTCA1LjEwLnldIE5GU0Qg
ZmlsZWNhY2hlIGZpeGVzDQo+Pj4gRGF0ZTogSnVuZSAxNywgMjAyNCBhdCAzOjMwOjU54oCvUE0g
RURUDQo+Pj4gVG86IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+LCBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+DQo+Pj4gQ2M6IGxpbnV4LW5mc0B2
Z2VyLmtlcm5lbC5vcmcsIHN0YWJsZUB0aXNzb3QuMTAxNWdyYW5nZXIubmV0DQo+Pj4gDQo+Pj4g
SGkgR3JlZywgU2FzaGEtDQo+Pj4gDQo+Pj4gSGVyZSBpcyBhIGJhY2twb3J0IG9mIG5lYXJseSBl
dmVyeSBORlNEIHBhdGNoIGZyb20gdjUuMTEgdW50aWwNCj4+PiB2Ni4zLCBwbHVzIHN1YnNlcXVl
bnQgZml4ZXMsIG9udG8gTFRTIHY1LjEwLjIxOS4gVGhpcyBhZGRyZXNzZXMNCj4+PiB0aGUgbWFu
eSBORlNEIGZpbGVjYWNoZS1yZWxhdGVkIHNjYWxhYmlsaXR5IHByb2JsZW1zIGluIHY1LjEwJ3MN
Cj4+PiBORlNELiBUaGlzIGFsc28gY29udGFpbnMgZml4ZXMgZm9yIGlzc3VlcyBmb3VuZCBpbiB0
aGUgdjUuMTUNCj4+PiBORlNEIGJhY2twb3J0IG92ZXIgdGhlIHBhc3Qgc2V2ZXJhbCBtb250aHMu
DQo+Pj4gDQo+Pj4gSSd2ZSBydW4gdGhpcyBrZXJuZWwgdGhyb3VnaCB0aGUgdXN1YWwgdXBzdHJl
YW0gQ0kgdGVzdGluZyBmb3INCj4+PiBORlNELCBhbmQgaXQgc2VlbXMgc29saWQuDQo+Pj4gDQo+
Pj4gSW4gbGlldSBvZiBzZW5kaW5nIGFuIG1ib3ggY29udGFpbmluZyBhbGwgb2YgdGhlc2UgcGF0
Y2hlcywgaGVyZSdzDQo+Pj4gYSBwdWxsIHJlcXVlc3QgdGhhdCBnaXZlcyB5b3UgdGhlIGNvLW9y
ZGluYXRlcyBmb3IgdGhlIGZ1bGwgc2VyaWVzDQo+Pj4gZW5hYmxpbmcgeW91IHRvIGhhbmRsZSB0
aGUgbWVyZ2UgaG93ZXZlciB5b3UgcHJlZmVyLg0KPiANCj4gU2FzaGEgcXVldWVkIHRoZXNlIGFs
bCB1cCwgYW5kIEkndmUgcHVzaGVkIG91dCBhIC1yYyByZWxlYXNlIHdpdGggX2p1c3RfDQo+IHRo
ZXNlIGNvbW1pdHMgaW4gaXQsIHNvIHRoYXQgaXQgaXMgZWFzaWVyIHRvIHRlc3QgYW5kIHRyYWNr
IHJlZ3Jlc3Npb25zDQo+IGZvciA6KQ0KDQpBd2Vzb21lLiBUaGFuayB5b3UgYm90aCENCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

