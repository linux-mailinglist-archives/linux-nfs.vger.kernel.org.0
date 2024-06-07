Return-Path: <linux-nfs+bounces-3584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55E900476
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61CA1F23B94
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212C01422C6;
	Fri,  7 Jun 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Chzag32U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E3F1MMIy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609121922EF;
	Fri,  7 Jun 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766354; cv=fail; b=c8kJ1TEzjawzxo6yUp1KIo3cY/9VG+IJskCClCtMCjqBu0eFDD+4wLceefoCvHocqP17cfUSLDcOnvbdqNguJtzun6PHENwatXhh7iH9JxhoG9UtXoZdWnzB+3ONog2rKOv+NJBLIrDb/56WoloFX1bS+0rAANsh8XzwaJfiS0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766354; c=relaxed/simple;
	bh=+KCtvUHwmMfxetBziQPUXX/FZz7uVMYnKZhV1kJtMs0=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VG4QH2YSuzBV0QfqyKd7XmKSE6RoPGY8zgYpj6/WesyKrBqYexJPhysP1htwK8lqhsR6tpJ/S2dnnfS87xytSNrZZ7rTjbCgn4yGj3JZrR/Z+NIDHbi1eLnztYCvgrhHVEW4tbjuKLlw3klFl0PA8PD2BoTmCTIrg81C1jrmEfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Chzag32U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E3F1MMIy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuUn9025407;
	Fri, 7 Jun 2024 13:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : message-id : mime-version : subject : to; s=corp-2023-11-20;
 bh=EaPb+JnNMFtp0l7uoHUyXE4T1nT01OBmZ+jPjw2iOmM=;
 b=Chzag32URU2sqIpn+iIUSVp1x2TbcF/02HIFg7nCQ/B8V1Z7FrAm+2AWUtYaOEapu7pS
 1vRM2tsL8W1rPhsLdSXbFwG6E6BJKh5EyYE/EffGUDANSR7d8t+Di8usygXSJo0THLgz
 HwfthKtu68H+SXOraKALj4n3+ysQrukk6geazqSPd/GBCEpIxRkKc+ZT7ellWdx5CUvv
 iOrcwy/YP7Eo8PePS0y0usERSewj2oyl0FdSrmUax08HGrD65EYAIgNz1Yms15QauC87
 K5pVgdC5UYXizSUn/8Kb8RpwrpQHcPBoKQgPhRBd5mSNKMbp1aeZZZK+D440okfewLBI /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ykrtb0x55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 13:19:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457C5BTZ016157;
	Fri, 7 Jun 2024 13:19:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsefn0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 13:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWdUCj0Cs5UOBi/w/H9dufh4JynfwuCOXwfYEoOXsxozjh8Zc9Y16P5lZGfB1cjRUCVCG4RFYTYRCRpgkmlvBjS4NMIIQ3slQFVNewDWl/HObwh4gNxnPQsQIsmVSgjzcdysVItzlDbMeHYtimNsdN4mSky6SxR8mVRMPSMCR2EPwYGHr5Pc7ZMpC2hwaIauHrf5CMP041OiZwM6MvyV9B+PNdPSREWwvL2UH29jyn2V/hS1gRwqi6p15n9X4qWy2dX0Q8oYMeaSq5dJSBEH+fyjIOYIsTZfSt5XVXpk27c1m3ZAXlkFw0Lhag1u10aOMqXgvpL2nvnoKFeOsyIJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaPb+JnNMFtp0l7uoHUyXE4T1nT01OBmZ+jPjw2iOmM=;
 b=Wo6EDwFyvYDmubfu3317ueBtNb5KKvvwzDlHaNTbue5pBuhsJLhURPj4FjSzGpTsxDO/xK0O/IMQr6z7qDgpiVRkfMU5EIckADMcfCl+T61PRUzmVEDTELN05pNKTqXKDu7agoXI5VEsMcXJXW8E/+M7rVl3WmoyZ6ep/GpKu45uVb0wmoDYJdxOIrOgxE7O7+Ws650qbHJ6J7Ij6F7Im6Un7zqqtZtRMAl6ps77ZPR2hEEUNowZsMPyKbFNhDnjb4lqnU95SN8TNf7muw8jkycq0zMzE0ymiydy7e2F9xzDNl4P1qQ3A7+/sj+wnZc2GK37NRp+gDFzmPXI+4kO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaPb+JnNMFtp0l7uoHUyXE4T1nT01OBmZ+jPjw2iOmM=;
 b=E3F1MMIysmglbYKag5PteeKclKaQcxk3Ol3Kn3w5lMSRBOKSSpATGc32+07JsbobD4fHClSTmf9a2VM1quskuNrzzgTUI9xR8yOeKa9otzLB7pb5FDIjlTnB5N7/LmNSy2qt/7m2J2GEzxRh3SuwPh6yAf4zFIPFQYpm02DWsiA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6210.namprd10.prod.outlook.com (2603:10b6:208:3be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 7 Jun
 2024 13:19:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 13:19:03 +0000
Date: Fri, 7 Jun 2024 09:19:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] first NFSD fix for v6.10-rc
Message-ID: <ZmMIxOjoqzW8auo6@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:610:54::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL3PR10MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: f25dc116-a4bf-45ee-d553-08dc86f466cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aDMfwd7/VL695YjA/2/Cy5BFTa0dA7uICuGQMOP3h1veh0D5JPNr39my0GAj?=
 =?us-ascii?Q?9OsSBWllVfl8JWrn2T/TRtjfV6y1f+jNVo+ml7Xd7sDTovkQcLlOLDdN3cI2?=
 =?us-ascii?Q?GBRnTQeU9rQ8MzQ2hPLJdQRuv9AL/BkS6yPdCaKTySMOQhtqwGy5NfKVZSCh?=
 =?us-ascii?Q?2Qi6TXKObnhsLm5Y6uiV6KCjLj4JY3lKaK6ehfU2GkFRxL33JbloTBXC4taR?=
 =?us-ascii?Q?CIiSowAhHcpmrYW2zwZm6U/+kMcODIE2rbPWEWVkd03WzKztMi28qzu1Ad3f?=
 =?us-ascii?Q?S/huFd6rKbsWyLNtBkMbFEL0FEtn4h53f2znbxPsrzJsV9jVtc1Yz8/8RssH?=
 =?us-ascii?Q?LR4jb4S7YvHRPFQ9qLq7D+qw2PdZT4W0GZ4Hgh4FNOHbhPg6+iohxxwhyrZ5?=
 =?us-ascii?Q?+reO5CfvQP4fc0JAFQglZz4JxgRYOcQ/aJHQBPyEgQVjbYe/o/4o1/twr2S0?=
 =?us-ascii?Q?0huGLyHhlqSJx6PfVjW81G9AlqIEvMQvAvsYdrZJfw60nitOyuTEvrszqr+C?=
 =?us-ascii?Q?dPNOuwJxqghDsFeaqGJjtMjya/oxymgcL0WOUSkuui+TGUY/7wmdt7xV+Rxy?=
 =?us-ascii?Q?KhhcJRD6P4kH4Bvy5Oo9Q05JLWqv65E76I+2dHlQKzxhEpITfu2QgXM+5RXh?=
 =?us-ascii?Q?1du8C8F8jv4PxN/4pkbrn/soE0Gbm0ZLpXmfvI218l2Qk/dpN4PBvZxM7qqN?=
 =?us-ascii?Q?CcVdxa8fuJCzgowfYPIiIHvGxAfZd/m0Wnvgkq45aU3+CBNj1EZOQagm2MX5?=
 =?us-ascii?Q?R5qJhugsWZUT3m/AQWAY1Hs1hXx2jtTvNMR+QQd0uCBCig4qyhs+1v/IRF6V?=
 =?us-ascii?Q?GawZ0MOIT5f/IojBYJJ2PAWpH7/Y/b0SsGuo6ealfFuqpwj0wSLOn6KJ27DY?=
 =?us-ascii?Q?D03ib6gXPd1FlhAmQJb8dca8eL1stD2obabaFzsDz3MHAUsSnxrzrr/5EYV9?=
 =?us-ascii?Q?RkvGRl14J/8e537cxuwB9bRu0OMZ2VOZwTInux5E64Hznw8/VJ7eL0PUXvfx?=
 =?us-ascii?Q?1Y+nQfjVo3okeHalBBjC/RREIxTsFcf2spSs5Ev82UeR8jrbu8g/KaJyAqvz?=
 =?us-ascii?Q?nmIp7Xcn4UYyHfqYL2wrxMrzXGoUfGCpWWl7kep3JarAKJov9pUcc8oF3knB?=
 =?us-ascii?Q?oQrkluMNuj5gJtoaDS3KWkyc9QU/jSM0qu9LYzUoMfktx5DTA7teJx2KrsEP?=
 =?us-ascii?Q?e7xDqiSIge0LgFMR8vkrlx3W+X4CE1AVK73jauPBt0cHx7/+03fkXdVhnudp?=
 =?us-ascii?Q?GB5aR0mdRMuUgtik8fI5tqQPJejaD4z/K4kQd/9gDO4ipXBpQXM38HlWVHYO?=
 =?us-ascii?Q?393Nu9okBDHyBVGumbRYil2y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CmZ0DGZkw63n9Dq9uwW2aj1vgNj/95rnwqi2Iyobev90I93M5Iy/dylDsqtl?=
 =?us-ascii?Q?zCmj/SY58ivro0zFuSDTKapdBRDjb2FrBKlcEFzjuxBL2GZAKvDpkICQEasi?=
 =?us-ascii?Q?GFh28UJPQuKzDPZp4qqV9+je+qFjst+y6NqRN1ntk5hClTpCJBRKHif3E8Q1?=
 =?us-ascii?Q?3JA1qrKOeFrJjqLlREV/1r/R2IEram3PTyBpIKsild7XK272OfozhrNDbMW7?=
 =?us-ascii?Q?fx0TAdwR/IaaY2VVqNVG0LtKlBDL5ZY84BL6ZqRUlP4uBe3NJqQzUDkSboa3?=
 =?us-ascii?Q?gY/poNvHew8H9k6cRwxOCkHgucCrb6WiM1H0r9+P4jy6A58nIBrtxVMYAFsu?=
 =?us-ascii?Q?+opuLsSLZmOOKG/fWRqYdtqdtJg3jeL80cgsI8fjiAcWu23/mGqcvCCziVSe?=
 =?us-ascii?Q?iQ2ENexUtyypB0b3yGS9Wkf0D0aMg7iqPgJKdfSjLTSUFT+TY1KnsduutILW?=
 =?us-ascii?Q?6Ora5JzjagQoXVXXrK128nb1zpBhZlMymqBKxvoVzYfAlz8ofdmEtRCCSEJT?=
 =?us-ascii?Q?QOWkUe70D+F5Ix2FVYCV2n57+gSGYt0Cn0aiR6+1bkB1eKTBIlxbx3BCNu8p?=
 =?us-ascii?Q?BZghfMX/K7lEEqaz3qZWgWoaXmEjKMv1ZWNloA3o2SNEGHLlD0JTk+Znzlby?=
 =?us-ascii?Q?rfGvvNjzgiwoKBcZhXIJ3Ubo/BiHo19qOpWn23oJaPZDwTFXo80n5KFfkl3i?=
 =?us-ascii?Q?1MKNVc5a6BC4FDj3fD8iDzufcQWU6MZCoslGKIXphvOilZpbKTx/I6OFnet2?=
 =?us-ascii?Q?fyyYlXPRmzFv676oXhXGhxcWBb9GaYL2blznkGW+HKImvHqI/eQmMFOk+voQ?=
 =?us-ascii?Q?XtE5K1Z1JUv/Q3vipTuk4X7/z5bJyqo40Tzj7MSpig+VaWvwPNz3C4HBqLV+?=
 =?us-ascii?Q?X+v091Lor5PwZM0hq2AD79WguknlADnNOKfBlkVIdEGbnLWQLQio0Q/0JVbW?=
 =?us-ascii?Q?ilA+b/bR1rAUpilZcegWxXKfElZYi9XGqwYmjbYMkUw2chP2jewIQ7/7TBlF?=
 =?us-ascii?Q?XcfUgYVDEPmP+QUdJAj1Le1WSGJI1Mr6DBDUuPbkTe0S8rRBXM73bnDGkncN?=
 =?us-ascii?Q?CN5gYW5Il+03EfCG0n+j8EE+98jrh4hfNsjei4zbWa4Sl+bRPBS9x7GhIAQy?=
 =?us-ascii?Q?fUXa82tlBgz5MV5WVkqm9y6J6A4u1vVxFvkpa6hdFE/Qa6F/jH7xmGrboCnb?=
 =?us-ascii?Q?0eKjAWW6KptldoHuzPu/pZERH+/HL6e/PBmR1AVfxZVo4vFxRv5mamKIVeKc?=
 =?us-ascii?Q?llRTQseC0SYKvV5LHk+tM09rPCWtTP9nYgM+IDhQ3/eUWGUm+xNRJz5NF357?=
 =?us-ascii?Q?kRL+cFd+7N1Vglj4ZomJRZLcOy76JGK694r1k1/5lqSR1EoXgbgJstdbcWpp?=
 =?us-ascii?Q?AzuKdHZ6Zv+j5dv/BAnGvUSMc/Llh4PdIjKL2UKi7z3zEU4KJwcrdubCsci+?=
 =?us-ascii?Q?+9J2oRZMbDfxZWyq86LmIc8l4eS0GPXkEVZe58Xg7VDCUHAuiNfmGARYO+fw?=
 =?us-ascii?Q?s3ah/mKB/OJ4KkZ0XgagNYfMqW40z8yGnKZEXWhX5x8pp2WYJ98A2iZuHb4w?=
 =?us-ascii?Q?qrBBB75CRbqph5WNgRE0P41dhm1Jxc32udZ/4hgEX1rYoUL72L5sBkRZcJyw?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NNhxXhekEPydcH9ZGoDTfxZe7xaTIUY7vtDjP897C2eKxVOJ+i/7ghyMmJlTF8N0GKClvjc3ttbTuirON5Ca18IBAZ5TxA67IEq0A566AE28JyNcQ+ZxB+SHCO7zPp2PxXXhX5DCIdNsk76FWutwcsRcATBFuRT+ZjZa4EPElLyx99aDGc4LV5xNC62AwrOcUVjFj/gXytrq3FDwlyfi3uTQY7Z5tf+gIDWJqRnfjthQ30dcQXzn4ZKysMSfuPqf49S1WZoru1cLWaIMFTTFPDn6tcAiEZy4lYa+86Y3P/lTmTwHattdyQYWdbLvNdLJDbTxe/yXZJNsx+kf3HkFOH//h+rWkVIwpvhBV/KRQljZ6y48RtKwBWJsQW2S86WJ7Y8/feCl7Uw5ypWCyCKKDquFWD9KGrAu+yKPJ0P2y2UxgvUdSOR8+y8Mz3V8fQhkL6AHrMSVflFnlJN8nyuWUAO/4yjYTzmDixA9uHvy5RDYaWd7SSmxoEuhan1wArACAqmyHA8N8PaIfwwcLTjzt8Y4rkS4lObtZQTWJHy57P+DWHAARM8t1PbU4Ak4GWl/NsYR+h+VHG5U5OzagYyoI2DXFCzIqpnbzymnacTqM1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25dc116-a4bf-45ee-d553-08dc86f466cd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:19:03.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkh9Yd3qXz0lRBtG8v/RmJhf0G7/XTgvEzgx8Ir/W88A6OZs4kfBWmvc9z/bSsUHj+2svl8sjY+1i24Wc3C9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_07,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=866 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070097
X-Proofpoint-ORIG-GUID: avMbqCYNwOoV7BJ8sts7jXz3SayURr7q
X-Proofpoint-GUID: avMbqCYNwOoV7BJ8sts7jXz3SayURr7q

Hi Linus-

The following changes since commit 8d915bbf39266bb66082c1e4980e123883f19830:

  NFSD: Force all NFSv4.2 COPY requests to be synchronous (2024-05-09 09:10:48 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.10-1

for you to fetch changes up to 4a77c3dead97339478c7422eb07bf4bf63577008:

  SUNRPC: Fix loop termination condition in gss_free_in_token_pages() (2024-06-03 09:07:55 -0400)

----------------------------------------------------------------
nfsd-6.10 fixes:
- Fix an occasional memory overwrite caused by a fix added in 6.10

----------------------------------------------------------------
Chuck Lever (1):
      SUNRPC: Fix loop termination condition in gss_free_in_token_pages()

 net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Chuck Lever

