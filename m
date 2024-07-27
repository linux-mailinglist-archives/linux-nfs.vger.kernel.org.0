Return-Path: <linux-nfs+bounces-5099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B893E0C0
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 21:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B45281FED
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 19:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4C1D69E;
	Sat, 27 Jul 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XLO66jjI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pw0nNSC1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018138FA1
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110322; cv=fail; b=gV+6HtlCu3Lw1RAYiy/UuxjdLhzhQH2C8EBcxEhXsQr62jmLGTd8YVLygk4pmd8UV4D34G9tmsmuHhdHbIiEgYlG6bJlGoYWsl+Z0hHFIfYusphBueeMsZG2/deSdG2ogPFD0X+krQJ/ALL4uA/0nbSPsrNa0Iaa9EMYRSFHG9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110322; c=relaxed/simple;
	bh=c8pRRJRyxGi8L13EGwAfk9Wt+8zNq12A8eitzG1+fFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eLIeZfuf8NrWKaB2GcyBsHabTX/QDBh4B9ENDHz8u8GWwMB51Vn3yisu3FnVFfryjw4aKvt0sq5zc5JsTuV4erJMMNtgfjtz0J5hTaKs2UYPUMw51I6Jx3fmHDvXcRYMJzTo9wkZx9sd6VUcrfLsqYTc4JODF9H9wTajdesSgVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XLO66jjI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pw0nNSC1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46RCTQWo032176;
	Sat, 27 Jul 2024 19:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Vf1Vc0QAPeuY8+S
	EcsiahTb1+vPtZXJ7YTv2MDTvB68=; b=XLO66jjILfFM9Bq7YofLQQ7TsymdAAQ
	8avR7yewJOgbxIQfoDu3mL6vOJ374OyZZvS5QWAbpTHHHtUNbQF0WKO6vd+7lJXc
	1BWtcOrVLTrxRQ3gz47X4sF+0Zxwy3jM2Jo88/guIqP5wNcedxzjWRNpsHE/mPDr
	PrV1NZYTlrL09dAaDmtE/LJlfmXTWEUaXDv2zkSzmvA2r7RLV2BLZ8CNRnN956Kb
	hUsc7Xa9fhURcwZrl9j2K9NlKaN+TGTnRp6EREvh9fFE0hUWBIWr8xrnTqpO6Xzk
	xmROR9Bq0lzyAQWFzMOn89RUYJlceeGDiV2mJPw55WdkPyNRhZqRK+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtagjbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 19:58:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RG15gp021195;
	Sat, 27 Jul 2024 19:58:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40mqb6ynur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 19:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjvA/4Oi2Y6H/0QUMD+FXwm5LHxLWCxUWdWyYR+3V6qBeI+tG1WlaJryjhLdz71tho+ITBv2TT9+F4cLJUS+TPFeCxJNX4R/K8YXphcdAzuCpcm2dI8wd0R4KNuUCY31gZRgQBeX2LPBRY2iHVgDLNP7IigLIeaPkQWnBr6upHJCZrrDsmLw45QKpp6M/ECD1uc21r7NPh6+b9GVWjharGrqQ5v0qmAB6NApy7G7n5f8nWhAWFhfTw40qXQAWhwmawy72VQDZyWzXOsbw3zwMVo+pcS85mhskM80Sa3pVSATur+MF/XadBk3U+tOo10hR/zPWjGsE6FE50ScjJ8EFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf1Vc0QAPeuY8+SEcsiahTb1+vPtZXJ7YTv2MDTvB68=;
 b=i28ZDWTns+u8X1Iie0/dNrQg2BYAVUi01QFmwSnfGDnAXIbVr7jx4Bc7vCfDfyGAQT9lwgivzcAMhOt0pKTQvWeq8WESiGyO/mnCX45sT6zWW3iesJV/MSEvfqkJy10GsAsOFgklQvjMTH3pyMwW9/OIMCJjQjwP6wVBHQpOO2rLQ8baAhj1GPE9EMMVM3OWQIzhrqDh08mpuAuz0WcXG3gHsYEf/iUxLIeLA104YPrHma1GQ8eZ0vbMdEq++4wQhZ9eQyxNTUvtZpMw8DxNM6S6uJHRuOITy2zC7NJC2/guqfQ8p6DmLRPS7bPNrA6jpP8bzJYqBxq1lV69OzyhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf1Vc0QAPeuY8+SEcsiahTb1+vPtZXJ7YTv2MDTvB68=;
 b=pw0nNSC1BMDUe9CmtnVKqecKaRdyJyYvbgkX3+Ez5VETOJX+ETQYX+yYDsPj7FmEHuXCRdsdCxbmhIloHaqin2Uh+IQNlVtj/+CZCISmvlxZ2S3Clle4DUWwLDhD2KggxDoC24PjAjPnrkt1Y4/+5DfM4Dy9AK3dNVb1WchhXHw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7928.namprd10.prod.outlook.com (2603:10b6:0:44::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Sat, 27 Jul 2024 19:58:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.025; Sat, 27 Jul 2024
 19:58:21 +0000
Date: Sat, 27 Jul 2024 15:58:18 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
Message-ID: <ZqVRWps0RZ7GQROb@tissot.1015granger.net>
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
 <a9705537-e9ec-47e6-8a96-b783868d96e9@grimberg.me>
 <ZqVQRVgblq4TfF9a@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqVQRVgblq4TfF9a@tissot.1015granger.net>
X-ClientProxiedBy: CH0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:610:b1::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 057b4c37-bd07-495b-c4ce-08dcae76773b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejT2Z7sTeiSprChXgi8cc0FY7Tp3nWuvm5eyX79RXMMl6dVHoqzIpMufjGY+?=
 =?us-ascii?Q?3gEAoPd7MX+jBRPZSBzW3FZI2I2eLo5GAKN847/znIEUcYYiJixj4KYXTS63?=
 =?us-ascii?Q?82PE4WFjs0ZbevPiIJd4cw5hRm9YuXU/YHfTSzk4tA3KVB82XTVrsXnQSqSI?=
 =?us-ascii?Q?Te6UJjuGaZpsVDjBOSsIU2Roy+yiew38PtjlCgb1H/UESPCPU2A3W3YeHlz5?=
 =?us-ascii?Q?eJR/Hye95H44VEnVNcFixUk3yTNfbxfDTD78gwPke+70oI5it9hTH9qggJFk?=
 =?us-ascii?Q?mbLLjTcFKygGujpMcANyJInF5VqGNOuihE1ZlIGorB1v4uM+6QDPI1UtrTY0?=
 =?us-ascii?Q?5D3GdRWrvEhPt1KhxaHeSq/bbUe/24K8OUYyGHw5J6VIPhAtzimr6bMLYBVN?=
 =?us-ascii?Q?I5DpI9Xuy7pgLcj+RXEU+luV5NIchWsimtEp+vjSqUGnOf6K4UciolVRwBxD?=
 =?us-ascii?Q?kxi7TyMhHiyFrX1DuBmEjF3NybanCeD3nKOlwOGwc3zd+F2B5RrLOB8A7vTI?=
 =?us-ascii?Q?+yiPtZNzsDOTAwvwtymJUk0QOFE05qZx4wDkRUkket/HdgZuZq5Xouhm2L7W?=
 =?us-ascii?Q?WNGkI5+AC1S7oxd4xkKpKvaYTVfEez7XlKucQSWYp3HKmognjezxEsgGom6K?=
 =?us-ascii?Q?RAhttoAx6Gp9Lv0FBLQRkThGHOY35KOQbQ3mveSLiqaptOEM7DJkKwisg6Aq?=
 =?us-ascii?Q?i+hg/YDTWulJ7RUkGs4JxbxWj9pgDvGzHxng4QOUvkp6Rda1eFIENA5wIj9c?=
 =?us-ascii?Q?EEbZ2AWBe6fV/Ra74pRZmygo2J7pQ9bGWOHV5mAic4t55z2XikarYY9IRbVk?=
 =?us-ascii?Q?0uU9cEDH2jg4+lSrUM/TOrvidT1g5qNNOmx1kz1Bfa+SJxj8/BW/yzN4WOV1?=
 =?us-ascii?Q?3XM5zF6djW4D3AVfc5A940QPbEqYLNZsWNJVw3K6n24z2gRhrM4OANKSu/Bl?=
 =?us-ascii?Q?kF9CxPTnxjQk0c1mrZEaiAUIja1FTaurt8O7E7fVk+sdt0WYQtcizpk+zBUS?=
 =?us-ascii?Q?dKkc0M240ActQuiEb4r1lDzxUP51syTpNlGCAr438G9BCG1OIEz8+yAIyTyS?=
 =?us-ascii?Q?kXrmzYTAnW4ExD0rSUkaxIYYmtqQSHD5g6cD//aGkrc4r2zdHK9uwYECfah2?=
 =?us-ascii?Q?gvlkb+WOXh912iu3jtv7DgADDKE+oLok24Ivc33uAIANE3DkNtwqwiXjJ1fP?=
 =?us-ascii?Q?sypxYw+wDyHNlGXRGCBzYF/NqVF3IezrQzDm7V7Gss0lA+BmBEF16vPCKs02?=
 =?us-ascii?Q?qrG6KCDof5M0UaByDbApw66+tq1o2M44GHksQT8nlGOOfrPnc1Tp3yAn7IJP?=
 =?us-ascii?Q?eBA54aMNIaSkTUnKPAmqcf5ECTetll9rRgHQGL2cDCCELw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/D3uzCS31J7tNtA8fiiLgPvW1cDZk58SX1xB1tv5zIcYjk54VlKVXL20IKf?=
 =?us-ascii?Q?KK9PZlRmHLkOicf0iR32SKyY8V4rrPcdRrT509Zvss15bn7FYqtKBTc8/ERG?=
 =?us-ascii?Q?Lx73+5m5zNc3/5vLGIlEQnU1+KqXNsYNt8bViHkGA9eopul0Zmq7wf6eUqb4?=
 =?us-ascii?Q?/eWoyOAcAg6iQPjrtoRBYBKUT4gtbuF43z0eHC8Y7mGzfFO8ffZEON8QQlaE?=
 =?us-ascii?Q?FG6ByWtuSsko+NjdnuXUXvnM157iwIRId6MsEktLfMfj4kpjB+h0QL37JxT4?=
 =?us-ascii?Q?+ZPbee4wnET6ASRSnm4yQlZHHkVy9mqKeCe4S9ekIMsUraOwf2FyDW1dhc69?=
 =?us-ascii?Q?G9ipRMZe2y9GlVHnteHU00AgbK3soeJbxD7iOpw581fxJIc/SjWInYZwqcaE?=
 =?us-ascii?Q?U0me+N5dDs3vMZ7QQKBUnsqiwmxjSmNdsjXhjmhLuWex1B+QPuRzM8H7s5Dt?=
 =?us-ascii?Q?n+fH3WThwj2pFbFrCfXjYDpXKC2j0NY3QxUDV1UIFNzki2Dg5z5b/p45I8kx?=
 =?us-ascii?Q?dbMwYhtaORvCI04WNWSd3kqj+LXpfufJ9V1rBs0APjblHIjbvzb2VjC219b/?=
 =?us-ascii?Q?Ss5LgQ0BknYGeq8ii+VU+9yp9RD43KNplpTpz2kB54zAJikEiam3LWtO2wsp?=
 =?us-ascii?Q?UG1wCQDqNk4WDJgb3cyXDZjqtGlle7CkTGn9YuR1lFvGBokVsPy90JVcAbcn?=
 =?us-ascii?Q?GbuwdecOPOUoHPYXnTApC5MoUR7TtPt5lZTJj4KDNPx1oG9AW85dW2r5ybHX?=
 =?us-ascii?Q?G8X08gEOKFfpKEm0MZ3e+t1qDiyr6NZ+rTv86Gx+PRWFtpo2Ckqx4ys92MGH?=
 =?us-ascii?Q?5pb8MEnb+bYTyqG5Vd7gUgJQBFg/8/EYXDnU4zquiKdWbvhNkes415wh2qmn?=
 =?us-ascii?Q?WLMkISonq/ExMTSHHlKVyolXeaZBqLMMmrhlorLwk9+LykB/JSUFwxtxxWbQ?=
 =?us-ascii?Q?Kd9077iv4XEKpbksK0STLUogGVrNF/urkQRvrDkDdAB1rITYhJ9t0dngBpPE?=
 =?us-ascii?Q?cH+IXacADUAuxg6SiA49R4MbKT5zkTAv54FDdx8sTi9u3ouVrgw8CADXQ9/A?=
 =?us-ascii?Q?yTJYMJW9AB+zMCDRFge0WvoGY/1LkEvKh4gkyn95PHQyA6ZGMYhzDAFuCHUK?=
 =?us-ascii?Q?zx13+x3FgXTbiLCas98fe4GI1UxJdqWkbigffkDLx2ssS0BzwJ/+5szzquEf?=
 =?us-ascii?Q?yzr0PzKku8Ls8X1Y0/QVmJ54wvrTtjVzL5YsmnAI8zddgOTi1doTFpbyYFC5?=
 =?us-ascii?Q?OXgZNEMbjCPYRpaOM76s3jxEd0jc0ds/xK2oH900mOaNhdfGZbY3eqUhxzbi?=
 =?us-ascii?Q?LzEQeRQRxwUFTkA/6ycTXF1bDNTOApGb1ECsi9C0MCjdT+gEmMoCk8qTyKw3?=
 =?us-ascii?Q?xUiBcd6dU9xGKPliNaj0i0PN7aFiGejYyKAi9jVi8p9eJalxoEGuTXnh7Atr?=
 =?us-ascii?Q?2JzV5iuwCFCicqucEfs2wO3UPHnOOdOLqU1Pv/tXyMaVp/S9JhudH4HqKXBA?=
 =?us-ascii?Q?8rE8MT49PTh81w1k3NlNMc8LQ9Kgd74364EY0zJZqbDwMtzAA1HXGal2fXFx?=
 =?us-ascii?Q?hrmvrjcUTolbuhVinpHGzdhmn/8RDwzy+UlQJLIv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lv+nvd1spuX92EdhqKeCPf2Y5M39/pAtbBC5fmuTe0KZ3PIJ8WOrqMPUqjwg+aQ3tFqEThpQtQpFtfISjRcHVyyymMmtoSBwUDS3cFqRxY9dDAlcVX2GIsNNrrTgBFHfnYjcnRhdAdXO7uUbEowLAc6bZj2q2c62diLZ4XIumWfrnovAoXIIlFTebl21DtknTflTs39iYDb9ayKlQtXtmdk1Y5LJe04sjj+WHRIGKsiZLq9KIKdIcfLThte6XLNwuAoWXNzNctLB7mzzZUQWujylc35/Qog+Pq+dNbA3H3Us6yxKF3er7CSCrXW84hiWcZTqzt2KkGPC3Sz6yrDdXY0qnOt82keBZfpawGZZk61kLF2wbHcwpzFC+cgL1FOHVMWga7YJhi5RTXbV7cLbDkddFuuKIr67EIeYMXdzFJnd16/oV44EhgYyVqoBT/tcTnK0bGDXaB1qrDNZKL71L+YYBCXj53N0mnurLyfvxr1EkTLaz31vPfW4mjxjDvLlUzv+R5wHlArJwKwOYqZQUdKUi9hH9ey9efQ+t4USHt7XYFfyZqyp/9mxspNwfu9ItJh9+RniOUy5nbZyGhPN/7simmy6ka6qUDiPdK0PLkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057b4c37-bd07-495b-c4ce-08dcae76773b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 19:58:21.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2JHxi2aPIJiSHEGS32Q1lepNTcJ/u0/kRmSDD7AsygGJm3qzRmlgZTriEaSbG6c5QH+G+CCmBqyptLd3iSL0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_13,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270137
X-Proofpoint-GUID: whgXlE9i0yg42ZInkfNB7XvCYj6TdBrZ
X-Proofpoint-ORIG-GUID: whgXlE9i0yg42ZInkfNB7XvCYj6TdBrZ

On Sat, Jul 27, 2024 at 03:53:41PM -0400, Chuck Lever wrote:
> On Sat, Jul 27, 2024 at 10:26:24PM +0300, Sagi Grimberg wrote:
> > 
> > 
> > 
> > On 26/07/2024 17:06, Chuck Lever wrote:
> > > On Wed, Jul 24, 2024 at 10:01:38AM -0700, Sagi Grimberg wrote:
> > > > Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
> > > > stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
> > > > Stateid and Locking.
> > > > 
> > > > In addition, for anonymous stateids, check for pending delegations by
> > > > the filehandle and client_id, and if a conflict found, recall the delegation
> > > > before allowing the read to take place.
> > > > 
> > > > Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> > > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > > ---
> > > >   fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
> > > >   fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
> > > >   fs/nfsd/nfs4xdr.c   |  9 +++++++++
> > > >   fs/nfsd/state.h     |  2 ++
> > > >   fs/nfsd/xdr4.h      |  2 ++
> > > >   5 files changed, 80 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index 7b70309ad8fb..324984ec70c6 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > >   	/* check stateid */
> > > >   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
> > > >   					&read->rd_stateid, RD_STATE,
> > > > -					&read->rd_nf, NULL);
> > > > -
> > > > +					&read->rd_nf, &read->rd_wd_stid);
> > > > +	/*
> > > > +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> > > > +	 * delegation stateid used for read. Its refcount is decremented
> > > > +	 * by nfsd4_read_release when read is done.
> > > > +	 */
> > > > +	if (!status) {
> > > > +		if (!read->rd_wd_stid) {
> > > > +			/* special stateid? */
> > > > +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
> > > > +				&cstate->current_fh);
> > > > +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
> > > > +			   delegstateid(read->rd_wd_stid)->dl_type !=
> > > > +						NFS4_OPEN_DELEGATE_WRITE) {
> > > > +			nfs4_put_stid(read->rd_wd_stid);
> > > > +			read->rd_wd_stid = NULL;
> > > > +		}
> > > > +	}
> > > >   	read->rd_rqstp = rqstp;
> > > >   	read->rd_fhp = &cstate->current_fh;
> > > >   	return status;
> > > > @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > >   static void
> > > >   nfsd4_read_release(union nfsd4_op_u *u)
> > > >   {
> > > > +	if (u->read.rd_wd_stid)
> > > > +		nfs4_put_stid(u->read.rd_wd_stid);
> > > >   	if (u->read.rd_nf)
> > > >   		nfsd_file_put(u->read.rd_nf);
> > > >   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index dc61a8adfcd4..7e6b9fb31a4c 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> > > >   	get_stateid(cstate, &u->write.wr_stateid);
> > > >   }
> > > > +/**
> > > > + * nfsd4_deleg_read_conflict - Recall if read causes conflict
> > > > + * @rqstp: RPC transaction context
> > > > + * @clp: nfs client
> > > > + * @fhp: nfs file handle
> > > > + * @inode: file to be checked for a conflict
> > > > + * @modified: return true if file was modified
> > > > + * @size: new size of file if modified is true
> > > > + *
> > > > + * This function is called when there is a conflict between a write
> > > > + * delegation and a read that is using a special stateid where the
> > > > + * we cannot derive the client stateid exsistence. The server
> > > > + * must recall a conflicting delegation before allowing the read
> > > > + * to continue.
> > > > + *
> > > > + * Returns 0 if there is no conflict; otherwise an nfs_stat
> > > > + * code is returned.
> > > > + */
> > > > +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> > > > +		struct nfs4_client *clp, struct svc_fh *fhp)
> > > > +{
> > > > +	struct nfs4_file *fp;
> > > > +	__be32 status = 0;
> > > > +
> > > > +	fp = nfsd4_file_hash_lookup(fhp);
> > > > +	if (!fp)
> > > > +		return nfs_ok;
> > > > +
> > > > +	spin_lock(&state_lock);
> > > > +	spin_lock(&fp->fi_lock);
> > > > +	if (!list_empty(&fp->fi_delegations) &&
> > > > +	    !nfs4_delegation_exists(clp, fp)) {
> > > > +		/* conflict, recall deleg */
> > > > +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
> > > > +					NFSD_MAY_READ));
> > > > +		if (status)
> > > > +			goto out;
> > > > +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
> > > > +			status = nfserr_jukebox;
> > > > +	}
> > > > +out:
> > > > +	spin_unlock(&fp->fi_lock);
> > > > +	spin_unlock(&state_lock);
> > > > +	return status;
> > > > +}
> > > > +
> > > > +
> > > >   /**
> > > >    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> > > >    * @rqstp: RPC transaction context
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index c7bfd2180e3f..f0fe526fac3c 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> > > >   	unsigned long maxcount;
> > > >   	struct file *file;
> > > >   	__be32 *p;
> > > > +	fmode_t o_fmode = 0;
> > > >   	if (nfserr)
> > > >   		return nfserr;
> > > > @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
> > > >   	maxcount = min_t(unsigned long, read->rd_length,
> > > >   			 (xdr->buf->buflen - xdr->buf->len));
> > > > +	if (read->rd_wd_stid) {
> > > > +		/* allow READ using write delegation stateid */
> > > > +		o_fmode = file->f_mode;
> > > > +		file->f_mode |= FMODE_READ;
> > > > +	}
> > > nfsd4_encode_read_plus() needs to handle write delegation stateids
> > > as well.
> > 
> > Yes, missed that one.
> > 
> > > 
> > > I'm not too sure about modifying the f_mode on an nfsd_file you
> > > just got from a cache of shared nfsd_files.
> > 
> > If that is a problem, nfsd can open the file with rw access to begin with
> > if a write deleg was given?
> 
> IMO, it's not a question of whether there is a write delegation, but
> rather what intent the client told the server during the OPEN. The
> server would need to open the local file for R/W when it gets a
> O_WRONLY open. Not saying this is the right thing to do, just
> thinking out loud...

OK, thinking about this again... The nfsd_file that is associated
with a write delegation is probably going to need to be a local
O_RDWR open, if a write delegation state ID can be used for READ or
WRITE.


-- 
Chuck Lever

