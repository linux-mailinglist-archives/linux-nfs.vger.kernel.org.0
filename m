Return-Path: <linux-nfs+bounces-5621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60095D119
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE791C23C25
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D03189506;
	Fri, 23 Aug 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EsuECSXW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bb+9xTyK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762C187861
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425857; cv=fail; b=CIHzxy/RNJMmSHbS8LJTnJxUJIARkY2bIr61ofwiyXcge1mzreP8rZO6Oz3n6rfRdHHaC+psCjXU+C9azf4KEiKetWsW/K+4BYRB7p4tLlvf3LDxufti2dw1efWMuHgQnHzpa+tth23tgREhPBhseH86MNodSXYOIQEj2kddFpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425857; c=relaxed/simple;
	bh=fyVj/BRb3ORfGlOKrL+63b3+MDZnUDClO7Djr2MM5qM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myrSUnQwSSm4x69sDP9q/GewjlcX+tZFFph8my2bu4CLakwusQTgrKb43/7QDEHaIoj3BDVQA6u1YTcCGtvME4xOMGccuZ8Zf66FVDnctvz9Gpod8JRidtnJXqpe3L3LIAdK/3QRUJacdAEzrjT5DwCRIeCXMAAqp9z3tTlbjFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EsuECSXW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bb+9xTyK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NDMVIG031961;
	Fri, 23 Aug 2024 15:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=fyVj/BRb3ORfGlOKrL+63b3+MDZnUDClO7Djr2MM5
	qM=; b=EsuECSXW+QCD/BywpOhC3paWMLXPkAUYQFKPHNPbQPQDtaeWWMreqo5vh
	U36R3vmUpd93SgaPd0Wplxke58VIn0gkILhqvNAM+/2lWSFVmHkQ23m/XCCrVQig
	Ub5S8pepCvr9RbcvErySEodVKv1Ihq4qtLag4TFxNU1r/EiOXTXqKjqMfDa5ZT7G
	tXVb73M8nsyCodrNXMJn1Q8ddwdb8Ln4Sv8pYEPc4sA7v3+2kIz/niCQUMGy+NX5
	MBjhdBkwT3d2aYqCKEOubiEpXw1TbNHmcwpDBUa0rx/Lnh6yz8/F9KtG3dWuXvCL
	jTxLkDVvmN4dtIa6FsEBFVw9W5pcA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt4k9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 15:10:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NETSlY038878;
	Fri, 23 Aug 2024 15:10:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416v80hnkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 15:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekQxU5SZ/yDUsSeTcTy/4k8cL+wNQzaFTlO6FzU6RYG2RUxwfrWNkJ4PEJB1OJbFCtoNcLvShawkfVOYfu/ng/JNYA7sCSko8tatWfH5+7T8QN4cH46C+MgEW72Hs5Ei0Pwt2v6j/XbVA2a5y1wLMVLfi6iMu7bg5Xaer8nlHnsYBahzjxCei0E07Bj78ucgSxynAeePLj0KaGpwbjPMOW6wrQ3OvxLtUrIVidy0gt2Pa2yEkIgj/FL0Fn8lI/d+TbEksTHJaoORy5QyFrL5Xasmm67xtBBeiA+ICGqi97fohEXYTTZrlohEgJTr1hY9QbCP1tpJmGAKXyBwwIAlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyVj/BRb3ORfGlOKrL+63b3+MDZnUDClO7Djr2MM5qM=;
 b=VuvqKfnfgnzKDx4MiMed/UJOr7VIWpJ0JFT4cm7+uUuZ5BEITDtX6jL0kcm8AeodBthksfqOAK4kwP80F3odOAcjxIC9PGq8BI8n86nsAoudFrVaY1jt2dmtWjn6FJ87opxyxtElEYWqvNwe1+Cdpr6WB/ZvXJsHzY8Jq3956IbWzxozmvJXYQTcD2EYo7lEMpcFSNLt5AIqsn5xXvUYr+sKpabPrlmD9QdzEi+FTix4TT+x/fP8upDRt+JHrpyGXgarpUaxCr0EYs1CkTsJYm/sBWd9Gox8et46GCRt0RYPKe3tRwXYUTsQJTUeSjP42FSkK52b2yau2dYtzk63Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyVj/BRb3ORfGlOKrL+63b3+MDZnUDClO7Djr2MM5qM=;
 b=Bb+9xTyKn3Ql8/b/wHz9UFAIy/6QldIiszgDJVPSNqJ7+gEI2wNr7YFAjgLgE9OOGSufkvBb3lvf3c8Uxb1ZL8dAfn4eqi/neXVJa+mq52UHTudpp1Y5wMXhUpT2pi/bo3A9WV0wm7M3weWXQc1nTkJ7NwYEDy3ikT6Q118kPaI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5917.namprd10.prod.outlook.com (2603:10b6:8:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.9; Fri, 23 Aug 2024 15:08:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 15:08:36 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Olga Kornievskaia <okorniev@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: prevent states_show() from using invalid
 stateids
Thread-Topic: [PATCH 1/1] nfsd: prevent states_show() from using invalid
 stateids
Thread-Index: AQHa9Wa9qsz1Dl3wQ06ZBl440W5vI7I06qYAgAAFt4CAAAFvgA==
Date: Fri, 23 Aug 2024 15:08:35 +0000
Message-ID: <5DEAACE7-8A92-49C5-A153-1A51452B3D32@oracle.com>
References: <20240823141401.71740-1-okorniev@redhat.com>
 <Zsif6pDBfVm1sUiV@tissot.1015granger.net>
 <CAN-5tyHENMDTeyESPA9ceCA=RaPMMW9ORh3NXu9RnbFiLZHRYg@mail.gmail.com>
In-Reply-To:
 <CAN-5tyHENMDTeyESPA9ceCA=RaPMMW9ORh3NXu9RnbFiLZHRYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB5917:EE_
x-ms-office365-filtering-correlation-id: 1cd1e8cd-4acc-4623-9d6d-08dcc385762b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVZpVEtUanRoaFMxRWVrSmZTeFJwTVpza0hVWjJTY05vVEdVVUpJaXF1SU93?=
 =?utf-8?B?VWJyK0NvK3ZvUE1FMU9tMzFMNjgxNzR1WnAzY0JLeWp0S05VTUJYOWtOUHpy?=
 =?utf-8?B?S1hOYjlHYXA1TlAxR09pSnpQNlR5Ty9qenh5TzZ2MFdPQ0JzRHhPV2h3Q1pi?=
 =?utf-8?B?aTFIWnRUMXFtVUViMWNsaVVneHFpditDNWdDejQ2RUw4djlwaEdUN3k3VEFL?=
 =?utf-8?B?TXpIMVJ5M0Z2QUg1QmlnRnJtYjR4RUNoOTI3SGRiaWM5OVVYaHJYbTNXZXpo?=
 =?utf-8?B?eE4xaXZzbHVyVTJKQno1UUc4VTkwLytXc3c1TDBlMmNhZlZXT2pFVHlUWTdI?=
 =?utf-8?B?ajdYNVliUkNnRnNIQzVxbGZjdndRNjhsU2UxNFZYSGtEeGFPRllMbGNRQVFZ?=
 =?utf-8?B?a1preHRYZDlTRnNNN3g3SnB5cmxSMnNxcmJ1b1NZRzVhZlBPMTVyMDhWMDN1?=
 =?utf-8?B?d1RueWl3YlhGQkgzUlNPSDVqbkRpS1QxZHNxcGZjNHlSbnJHaytQbkkzVVpr?=
 =?utf-8?B?Nkk0ZUZVa3phWjBwem4zanlPNWFyUGR2Slo1bElydFYwcitVeFpnMUNtT0Rt?=
 =?utf-8?B?SU9Oa1hMY0Vnd3A3ZTNNSUlSZ0hWdUZJZzBQS2dzRFgvc1FYRjE5dkcvZWhr?=
 =?utf-8?B?Y1E2aWQxVWVtSUtDTUtUbHZUbDh1Vi9FbVo2ZlYrbHVJajBLREM3WnNJSktn?=
 =?utf-8?B?TGkwMXEwS2hSb0xHbDRRdEU2N0tJRVNPN1hIQUIwc0czRXZlaWp3WFUvV3dZ?=
 =?utf-8?B?eGlwUXR2UHVxQnVKak83Z2FhVk9oNmhKNFFad1Z0NFEwRFh4dFNtUjg4MGZw?=
 =?utf-8?B?WVZrMFhmUDVFYXYvOGFYUmZDQnVoNjNsUnl3VkZ1WlhrZFBKRXRvZVo1Mmg5?=
 =?utf-8?B?Z1VZWnZOT3FrR2ZFNzlqTlJiY3ZCUnViMDh6ZlhuUVdjdnk4QnBqaDRkeGs5?=
 =?utf-8?B?cTlqZFMyS0VGRHMwZlZOUUc4aTBDREV4T2xsQWo4TWRoWVVjN3RkY0wrYVQ5?=
 =?utf-8?B?OVgyOE9mS21SeTR3OGxCYzkyQ05OTCtLemZWZzN4WkN1d2ZXc2lzdjNlRTA3?=
 =?utf-8?B?YitybVdFeERqSUpHMmJUWE41a1p4SER2aGRrVDZ2ajBIdTRiQVd0dFMxSHpp?=
 =?utf-8?B?a0FNSFMyTkhETlJhczRwVFlUSTBrcC96QjB2N3cwWnBBbDk5eUlWa25DMExX?=
 =?utf-8?B?K1MrWHpOZGRiWmg0azhlakdVRlljZk5wOGoxdEVja1lFcXQrRVRodVQ1NHNZ?=
 =?utf-8?B?YmdCRjhYeWxHcG5YcDE1YjhlVXlWbzI0ZisrallnbWg2ekJyYlJKc3VXU0h4?=
 =?utf-8?B?NWlzcGp0KzhrdzlTV3FITTFPSkRFSmRRQlRnKzdia0pZRW9pZGFEWVQ0QW9T?=
 =?utf-8?B?NXdIaDJScnFTVDVYblRmTW1QZ0xocG95RS9MN1NXYlphRklyc2JHeERPNWtq?=
 =?utf-8?B?YjRhZmI5UHJBQ254dDNaLyt5cWw0K0c5RUJxTm9FMmNrcXlEOVZ5VkxVQVNS?=
 =?utf-8?B?dURKdkNWMFJ6dXZjM2VFa2p3TzN6bFVVSFpNQWYrc3BqSXhwcTNiMGZTMXhr?=
 =?utf-8?B?ZUdyYS9ITXRhc1NQOGpCQld2aXlJWHE2SkhDejJ4Q084b2NWK0F5cVA3VCtz?=
 =?utf-8?B?RkJXQkdXQlIydTNrYVZrWjZIYWoreEk3SUczbWdidjVnMVI0NlcvWUROcmNm?=
 =?utf-8?B?VDUwQlJTekU0YWNHV1l6clE2YkxSeGV6UzMveGYxcGxPT0hld2d1OHh1dTMx?=
 =?utf-8?B?VEJUQ1lWalNQOEU0QlpGZ2FQNUFnbUYvRjNYY0FjdHJxWlJzbUJQLzBORlJQ?=
 =?utf-8?B?c0FmdjhIQVhlTlQrVGFjYlhzbjlGSzFZQWdlQVphS0VmRUlWbW9BSm5yU2t0?=
 =?utf-8?B?NHpKb0ZIa2FrWXJGMHlWTThIRVFINW1CS2wyWldmSFNWTVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blZ4cTczb0FpSXhpSlJjTWhmTEFORkpPdjA0SFVYdmZYem1XKzM2VSswMUR0?=
 =?utf-8?B?aDhvdk0rTGtoT0NnK1kzNEZGVnRiM1JoSU5acFpYWlM2TDBNM0srUzl3bFFI?=
 =?utf-8?B?Qlc0Wis2ZFFFNXhRMW80NUdNWFdmL1VnSVBMcUx2azA0MGVUSm1seEtWTHlO?=
 =?utf-8?B?b2JHSWNyNEtxdHBCNDEweVBKL1NKMWpocVI1eTI4M1ZKS1MrYnhOUkYzem14?=
 =?utf-8?B?L0QrMVlrRERSNFN3aFZZQ2l5NnRTVTZzdzJNMzdGY0E3VVIzN2lKdW9GT3NM?=
 =?utf-8?B?ZWg4cE5pMHRCWlRGRFJxb0tzRTBvTnVkYzBqOWpXeVY5bmNKKzJmb0Jlc2tD?=
 =?utf-8?B?bnZNbXd4a3VMNFkyOVA0UFBtYzR6YW1LaW1nVGZtWWIwRXl0amVXd1k4R2Ir?=
 =?utf-8?B?RjRacXdIZDJQZElsR3hZQVpvWGNjZ0U2WTU2djY4a3BWdkwvaDZQc3R2S29D?=
 =?utf-8?B?TitHQTJXbXMvZ1JWU1NOWW9ySUlJWjM4WXNndndOYXRPdXlTM0JBZjY1Uklq?=
 =?utf-8?B?RG5DRFROVTdHb3RuckdxVFl3YXBoQ05LdlQ5a255a2FyWG43b2dOUnFpRTRr?=
 =?utf-8?B?Z1VZd2h6UWJka3Nxanh6Si8xSjNtRlpYWlBwWnBPSDA3S1E1MzVYNXBicFp6?=
 =?utf-8?B?dER2eFV2OHJTOWtiT01DeHhHUXdLT3RkUkJ0cjV4dG9YQlF1Wk9CSGFON3Z4?=
 =?utf-8?B?Mkw3U0xjQ0dYSlJKVkVQYXZjSmcyck5ZT1VjU0djc3hjenhSQUdHSWNRKzFx?=
 =?utf-8?B?TGw1TENkUXpEM25SaUc5Q1BtWnZhYUVwWnptUmpZNDdWb0JzditpR2JNKzNo?=
 =?utf-8?B?WEJGd3BwWWRhcjc5UTFQOFRmc21Nb1lneXFqZzFNaFF1UUNONFVTV1R1OXRi?=
 =?utf-8?B?MzdSZjNVc1pQSktIMWtON2wxV3pOV0hscXg3RmJMSkpBcldyOVRaejdPY01y?=
 =?utf-8?B?aS9McVVxTTFIUUprN0FVMnBKaVg0YjdCbWFlWTh6bWtRMjlhVFVHcFpya3Zv?=
 =?utf-8?B?aHJqdU1mWHQrSGlObkdYWEhJYm1QQlRYMlhIdjkrNS91QXBwNDlmc25heWlS?=
 =?utf-8?B?a3VISVRWUGo1a1RkZDRkc1NnMk43Si9Rcm1PdDNtZmRsaUcxMVpIc1RzNzFH?=
 =?utf-8?B?ZFp4SWxXRE5qWElZcHVnUHpuREJ0SzdOK1N1Qmp3RHFjQnJJeWd6ZUVtbU1v?=
 =?utf-8?B?NVovQ1AzWU5YWEhDQzJmaTFSV1E3YTU4dWxNRU0vNUg1UjRHWDZ4SU91QlZt?=
 =?utf-8?B?RmJnRDBYUVpKNjVwQ1JNa1NhUXVWc0NMd3dVdjA0cmtMNjR5NW9zVjYwREZH?=
 =?utf-8?B?U0MwZ0xTT2o4UlVxaEMyM0N0TXIvRE5jY0NLVVN4enNsenZPM201SEUyaERt?=
 =?utf-8?B?dUMveks4VXNDejBucmJjWk9oRGZ0bTlrbmxwbk1LWXZTaEd1bWY4ZHFHQ2VX?=
 =?utf-8?B?QnJ4RTFtN1I2TTJSWHovSzF1OEk3NlZUKzFYbm1PV1ZsRmovL084VFhTL2pZ?=
 =?utf-8?B?KytMRUZWTmJiL055cFVlSG85SFNHSCt0NWVIaEFaSjVpNndQRVFzbEg5bDAw?=
 =?utf-8?B?cWxlbG9Ha1dXYTN1T1dTalpESGQ4cXVSVWlZd1lxWVdRMGxIRFBIUFNacDdI?=
 =?utf-8?B?ajJkMVFxTnBmWmVFdUFGOHZZb2RPRGZXd0RTRXdham9VMjNuUTlmT1hiay9T?=
 =?utf-8?B?TERDUzRwdDc1RnZ0YnpUeDltbm9KOXMxMVZHc25vejBwWUV3MS9ZWDQ3VkNl?=
 =?utf-8?B?Qkh2WCt1Q0RraTRHT2g1NjhQT29qYyswZVY3UDI2THA2NXlKUm1leUhoei9a?=
 =?utf-8?B?dTdpNWtuVHJDMUQ5cHdHUFhVQUt6cng3blg4STBjL0tzSDJnaHM5UFhhUGpa?=
 =?utf-8?B?Z1NFbGFYZDRnUDdMcjNEN0ZzMEtxeVdlZTlBL1k2MnY5WUFQa2l3a0VOMVhU?=
 =?utf-8?B?MnlQK1hpdjMrNE1UTENneUlUcHJ1aTR3b1picHRpSEhBOVpBL2E3SnlTUFNk?=
 =?utf-8?B?eU5aaHJHVURuREtRNVJPa2tVMWVmQ3RxWERhcTh6RkRVcHBLMld5Rm9nanBo?=
 =?utf-8?B?Vzl5TjRHcm4zVnpLRW5rOGZKODM3ZHhGdDFnQWcrclh6ZEhIWHNYMlZmdFNL?=
 =?utf-8?B?Qk5zNVU3QzdOOHF1VytzQ3ovd1lRa1ROU3g5MDUwem5pc0l4TGdMOTlaYVVu?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD5F0A4C2438948AD32AC8A4DE5AB64@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p5u3xC53m3CXReViihEfr3auX6XRMfFpmRz/WZrozfDLIP/TUG6PtASYMk67ND0Kbulv6FNM3NSDeujfnsnsivAeVH1lcelqqYG2tX+vADsSe7SJxy8tHXGW9+wZMfG/uwfzfIpiixoolfUTVwUbTxI0NVmP79/c1iWrr0ROdMdcAoGwlbdK8MSTL8X7bpU5PsE/IyIVgZ4jBMn73jBK0mPgR+pDyOkrMQCiIJsGTd1bO55ip2+qMo30QCQ5keYJLqDDAf5IXe5BUx/38MOpnfKt6EajTiSEmP5QNmNqiwcL5eUhvdoD4dT/Rsak6AI3BwMQ8/lnA8uU7XquM5UMlO2/S0P60CL7B7L7I6YZ19T/W9d0qzyYV6kjREdaQfTbehJojILPFA9jj0XFWejH5JrEMkLR++LCTwcGRZ94RmOLKXoJKCeNhsaM8NH4cxihWyuGYd8CSljKfXgOUoF9JCmDlWHIlHsc+7ix035GmnT8hzwVIV8E5xrsX7NHMww1ppnafAU1PO1XUuzCX3Fn7QVhvJoX6aEJjATfGMtAITZJeT9fPaqSNDCfACnr+91OupYoFoxkyBnZU8HuWCJ5nnwa00wmLM2z1yg9Wp5tTbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd1e8cd-4acc-4623-9d6d-08dcc385762b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 15:08:36.0011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBswWwxTEwJeMr4zdVk/Ddz7XSokxMq1J2gzs5Y92W4rVeegydMhSyAJ9tKIGsUPozX4Huup4BWhfm45zzD/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_11,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230111
X-Proofpoint-ORIG-GUID: QIxnCur9D7JF2Xd5gH5_K9m_5bfTOSzr
X-Proofpoint-GUID: QIxnCur9D7JF2Xd5gH5_K9m_5bfTOSzr

DQoNCj4gT24gQXVnIDIzLCAyMDI0LCBhdCAxMTowM+KAr0FNLCBPbGdhIEtvcm5pZXZza2FpYSA8
YWdsb0B1bWljaC5lZHU+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBBdWcgMjMsIDIwMjQgYXQgMTA6
NDTigK9BTSBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IE9uIEZyaSwgQXVnIDIzLCAyMDI0IGF0IDEwOjE0OjAxQU0gLTA0MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPj4+IHN0YXRlc19zaG93KCkgcmVsaWVkIG9uIHNjX3R5cGUgZmllbGQg
dG8gYmUgb2YgdmFsaWQgdHlwZQ0KPj4+IGJlZm9yZSBjYWxsaW5nIGludG8gYSBzdWJmdW5jdGlv
biB0byBzaG93IGNvbnRlbnQgb2YgYQ0KPj4+IHBhcnRpY3VsYXIgc3RhdGVpZC4gQnV0IGZyb20g
Y29tbWl0IDNmMjljYzgyYTg0YyB3ZQ0KPj4+IHNwbGl0IHRoZSB2YWxpZGl0eSBvZiB0aGUgc3Rh
dGVpZCBpbnRvIHNjX3N0YXR1cyBhbmQgbm8gbG9uZ2VyDQo+Pj4gY2hhbmdlZCBzY190eXBlIHRv
IDAgd2hpbGUgdW5oYXNoaW5nIHRoZSBzdGF0ZWlkLiBUaGlzDQo+Pj4gcmVzdWx0ZWQgaW4ga2Vy
bmVsIG9vcHNpbmcgYXMgc29tZXRoaW5nIGxpa2UNCj4+PiBuZnM0X3Nob3dfb3BlbigpIHdvdWxk
IGRlcmVmZW5jZSBzY19maWxlIHdoaWNoIHdhcyBOVUxMLg0KPj4+IA0KPj4+IFRvIHJlcHJvZHVj
ZTogbW91bnQgdGhlIHNlcnZlciB3aXRoIDQuMCwgcmVhZCBhbmQgY2xvc2UNCj4+PiBhIGZpbGUg
YW5kIHRoZW4gb24gdGhlIHNlcnZlciBjYXQgL3Byb2MvZnMvbmZzZC9jbGllbnRzLzIvc3RhdGVz
DQo+Pj4gDQo+Pj4gWyAgNTEzLjU5MDgwNF0gQ2FsbCB0cmFjZToNCj4+PiBbICA1MTMuNTkwOTI1
XSAgX3Jhd19zcGluX2xvY2srMHhjYy8weDE2MA0KPj4+IFsgIDUxMy41OTExMTldICBuZnM0X3No
b3dfb3BlbisweDc4LzB4MmMwIFtuZnNkXQ0KPj4+IFsgIDUxMy41OTE0MTJdICBzdGF0ZXNfc2hv
dysweDQ0Yy8weDQ4OCBbbmZzZF0NCj4+PiBbICA1MTMuNTkxNjgxXSAgc2VxX3JlYWRfaXRlcisw
eDVkOC8weDc2MA0KPj4+IFsgIDUxMy41OTE4OTZdICBzZXFfcmVhZCsweDE4OC8weDIwOA0KPj4+
IFsgIDUxMy41OTIwNzVdICB2ZnNfcmVhZCsweDE0OC8weDQ3MA0KPj4+IFsgIDUxMy41OTIyNDFd
ICBrc3lzX3JlYWQrMHhjYy8weDE3OA0KPj4+IA0KPj4+IEZpeGVzOiAzZjI5Y2M4MmE4NGMgKCJu
ZnNkOiBzcGxpdCBzY19zdGF0dXMgb3V0IG9mIHNjX3R5cGUiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6
IE9sZ2EgS29ybmlldnNrYWlhIDxva29ybmlldkByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+IGZz
L25mc2QvbmZzNHN0YXRlLmMgfCAzICsrKw0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0c3RhdGUuYyBiL2ZzL25m
c2QvbmZzNHN0YXRlLmMNCj4+PiBpbmRleCBjM2RlZjQ5MDc0YTQuLjgzNTE3MjRiOGE0MyAxMDA2
NDQNCj4+PiAtLS0gYS9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4gKysrIGIvZnMvbmZzZC9uZnM0
c3RhdGUuYw0KPj4+IEBAIC0yOTA3LDYgKzI5MDcsOSBAQCBzdGF0aWMgaW50IHN0YXRlc19zaG93
KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdikNCj4+PiB7DQo+Pj4gICAgICBzdHJ1Y3QgbmZz
NF9zdGlkICpzdCA9IHY7DQo+Pj4gDQo+Pj4gKyAgICAgaWYgKCFzdC0+c2NfZmlsZSkNCj4+PiAr
ICAgICAgICAgICAgIHJldHVybiAwOw0KPj4+ICsNCj4+PiAgICAgIHN3aXRjaCAoc3QtPnNjX3R5
cGUpIHsNCj4+PiAgICAgIGNhc2UgU0NfVFlQRV9PUEVOOg0KPj4+ICAgICAgICAgICAgICByZXR1
cm4gbmZzNF9zaG93X29wZW4ocywgc3QpOw0KPj4+IC0tDQo+Pj4gMi40My41DQo+Pj4gDQo+PiAN
Cj4+IEknbGwgd2FpdCBmb3IgTmVpbC9KZWZmJ3MgUmV2aWV3ZWQtYnksIGJ1dCB0aGUgcm9vdCBj
YXVzZSBhbmFseXNpcw0KPj4gc2VlbXMgcGxhdXNpYmxlIHRvIG1lLCBhbmQgSSdsbCBwbGFuIHRv
IGFwcGx5IGl0IGZvciB2Ni4xMS1yYy4NCj4+IA0KPj4gQnR3LCBJIG5vdGljZWQgdGhpcyBhdCB0
aGUgdGFpbCBvZiBzdGF0ZXNfc2hvdygpOg0KPj4gDQo+PiAgICAgICAgLyogWFhYOiBjb3B5IHN0
YXRlaWRzPyAqLw0KPj4gDQo+PiBJJ20gbm90IHJlYWxseSBzdXJlLCBidXQgdGhvc2Ugd29uJ3Qg
ZXZlciBoYXZlIGFuIHNjX2ZpbGUsIHdpbGwNCj4+IHRoZXk/IEFyZSBDT1BZIGNhbGxiYWNrIHN0
YXRlaWRzIHNvbWV0aGluZyB3ZSB3YW50IHRoZSBzZXJ2ZXIgdG8NCj4+IGRpc3BsYXkgaW4gdGhp
cyBjb2RlPyBKdXN0IG11c2luZyBhbG91ZDogbWF5YmUgdGhlIE5VTEwgc2NfZmlsZQ0KPj4gY2hl
Y2sgd2FudHMgdG8gYmUgbW92ZWQgaW50byB0aGUgc2hvdyBoZWxwZXJzLg0KPiANCj4gSSBjYW4g
c2VlIHRoYXQgdGhlIGNvcHkgc3RhdGVpZHMgc3RpbGwgaGF2ZSB0eXBlIE5GUzRfQ09QWV9TVElE
IHNvDQo+IHRoZXkgYXJlIG5vdCBjb252ZXJ0ZWQgdG8gdGhlIG5ldyB0eXBlIG9mIFNDX1RZUEUu
IEJ1dCBpdCBqdXN0IG1lYW5zDQo+IHdlIGFyZSBub3QgZGlzcGxheWluZyB0aGVtLiBJJ20gbm90
IHN1cmUgd2hhdCBoYXBwZW5zIHRvIHNjX2ZpbGUgZm9yDQo+IGNvcHkgc3RhdGVpZCwgSSdkIG5l
ZWQgdG8gY2hlY2suDQoNCklmIHlvdSdyZSBhbHJlYWR5IGdvaW5nIHRvIG1vdmUgdGhlIHNjX2Zp
bGUgY2hlY2sgaW50bw0KbmZzNF9zaG93X29wZW4oKSwgeW91IGNhbiBkZWZlciBsb29raW5nIGF0
IGFkZGluZyBzcGVjaWZpYw0Kc3VwcG9ydCBmb3IgY2FsbGJhY2sgc3RhdGVpZHMuIFdlJ2xsIGFk
ZCBpdCB0byB0aGUgdG8tZG8NCmxpc3QuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

