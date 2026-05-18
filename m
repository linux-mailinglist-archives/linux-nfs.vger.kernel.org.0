Return-Path: <linux-nfs+bounces-21664-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC+gKmtFC2qsFAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21664-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 18:59:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A807F571582
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A9CE3009384
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5548BD52;
	Mon, 18 May 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r304exc5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0UmN/rPv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB648C8D7
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123529; cv=fail; b=jdf9b4QeJtpD+yF6a+GDuX++OehA/H9phYSZmgUI43dT8HP/TySW+us4jNJjFqvkRY47lFHzO8US3+qukghWz5uqPyPwWO5NFp6+Wm9lWr6N2Hfp5jlyZwV1IosMe4dpsbTBANPuoJPGjxqFPpKI9cNI6l/taDrDs2mBLotyVh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123529; c=relaxed/simple;
	bh=QPlCetC+gfO1fcf9kJsCdLV7lzdyyda8Tv2UXMmZwUc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kGZiFt4NPX9I0OpwzK+Lhk11HivrtDBjBqLXbNxNf6hG9ma5ljBFXTT/O9frzHVszRoLCecg8oU4Lftvl44sSpYeH5l0kvU5Qa0r2htj9neNku4X3E9fbvwQrzSL7hqJp3VeOLFXe08pbcmuwBqGjB6emBk+HpsLTOiEBZ+1zWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r304exc5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0UmN/rPv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IEsrAx2632241;
	Mon, 18 May 2026 16:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/iFhh0pC0bE+yDkSuq8J/YKHdiFcOyLvFVNYA9DWRoU=; b=
	r304exc5Hi6fZ8D8ZhWvfm7fanDf3i4KIz85k0gsMRBC/m/YQdOLY2f5s9McNpmt
	oYRMTttYEIdUBWrgo3I29f+I99jUDv7IivoZ2XnPbo3NbjEmYelKcM5RHQSUHnrA
	MEg16txlPcj8dWfg4scJvqMC/Uh6JBys74t0Nenhd0eT9f8/ZwoDgttmnxuxuUWN
	kShuiP1FO5FaM3LlBpOHmHIHLucEaUdzBFbRxj8kOQlFb8xKKb0VykmUuHiEIMIZ
	tltsq1VsjD+8PgzRjzqrvx0lZrVNL5HYUjHlKO5K3gLqShh+9ga0LTqcgCJYWSjV
	PabLZF3dEjf2X3dvZQtYzg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1stm0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 16:58:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64IGskfH036475;
	Mon, 18 May 2026 16:58:11 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f19p78e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 16:58:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSHAFFy+jq1GWyeXPaqsZyx/VtUaDrwUgOqX+/YqVUhrVUDeF/f6ShNz7AgBkolEnuY0G/8X1LsUG5HCIwHuBebDyuM0kwA4owgARklNI12zvEu7+hJFlqwNi7Ah83MiupQiR4CzG1oV6W2h06PiAz/FKdnM0C2XgbdB2KrosL/yUTKIJEh6WrLBATysgMYw+dAJNSYJZE8/qcrbtf/T1r3Nl9DPMPUxmROcmS3pPP5IxSqOxDmtKExb3tm+sF2Gm+JzWU7SZmD8RDmJyItRdval4GwggDe6+GWzDbqBBdcD1RQl9eHio/hlycRjlzJGvJ8+QrD3YXzNzp7bo3ykWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iFhh0pC0bE+yDkSuq8J/YKHdiFcOyLvFVNYA9DWRoU=;
 b=Ooi2uWL8Tx9GCdvVwj9y2tcIHVWQoZjFevjeiXRz7t6Q8Zk0YUmFq2Dy9/9W9hpx25HxcgW9JHtWWhW0iZ/lN9nzInO72I3I46sJRwpNBrOVm/3H8XLShf1cwHzSIOjW+WMOLsK3uigFPgqF043SvhW3JiN7/J240L2ikNH73iVyZJxq2Kepm0wK13+IvpNFr9Gdewv/X5komM02s2PBkuX4yW7ZMRmOC19FrqtvIQaKdPIQVUywl/BRVHWAVQqU2T/5jn8gVY+rTdeOM6Y3lF7+JdNheIV19vi9Le7k74cquCFQlhTF25vE/pNVw32J95p5tJf/UIB5r1EKyzO5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iFhh0pC0bE+yDkSuq8J/YKHdiFcOyLvFVNYA9DWRoU=;
 b=0UmN/rPv2OZ10vdE99N/t05pfb5sCOEmKJly/lXLeGhPhIcjL7LQhZ6S0cswLD7iHU4+SPcxFcvai24aBgDexl8SpweiykDR+yHvAWJrAqVYolDLkS6tl8Rwo9CebKNze1AkjLzeJ4Ra2aRAYbVAJxIXXTtPBATSfTzL1Uefzlc=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH3PR10MB7612.namprd10.prod.outlook.com (2603:10b6:610:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:58:03 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 16:58:03 +0000
Message-ID: <484d4fc3-8f02-42d6-b5f0-891289dac177@oracle.com>
Date: Mon, 18 May 2026 17:57:58 +0100
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, lilingfeng3@huawei.com,
        yangerkun@huaweicloud.com
Subject: Re: [PATCH v2] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
To: Chuck Lever <cel@kernel.org>, misanjum@linux.ibm.com, jlayton@kernel.org,
        neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, Yang Erkun <yangerkun@huawei.com>
References: <20260513024252.3681597-1-yangerkun@huawei.com>
 <177868131676.213195.3678046994150964706.b4-ty@b4>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
In-Reply-To: <177868131676.213195.3678046994150964706.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::21) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH3PR10MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a8846b-0dad-46c7-4f6a-08deb4fe9faf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 oL1fA8unlVXLymMILpU1q8NXGMhbtDlf1VE/K3i/34BucpHZUuJQcJDUQqEx5y+YFAEyqTltq8ba/NFWqjP95h5PbFuYfh5QMcv+/L74OWUG2t8cBXfmGsavRP+P4G/dfEhB6bEY3gffDNsW9YVxDdsJCamp3S634w40tQdACyUn4DHuoL/ufpjcp09LGPJ3W7IJkrJE6mrPAwahDbl+Q9tXsrVW8YV/d4mTN+eipq66Ri+bxsLPkBmzAGV5KswDecr22wsJZg6aZSPD2x/QUyswoVZZ5iEYXkeUtYq2bWpq3W/eLM5X75NikH2JFNNTMoegBll4OC7hhxJdapIJ6Mx/7jTH61KHNc7vX8GnEGCNOGT4OPVbL/uyULQArvBqQyIkZ+p6+mtI6ncGIpxeCzzqT+f93rpD5uWrqm06GC2dzUxZZU/jzL0LuEpZnVzAPrBaIU/pLbEjy0vtpZzLqMop1fisDIrrUF15UtZJW0MVQVtmtTA3PmeHIfMZ+M6yVcjRFVvDI2tb7e36CawOArT7LLVpDJXaGQv9eUhesgHQIJzy7xst/+OzrQXgMPBVEfjLTym/P5kGPgVjsPHGm4MTpm/iBIO0cT5RL7m6yxDHLg5EoMRPBgNDBpxQZ6+dAENPV4hxmo5BVTeAQ6IWkksIRnUDsnOa2T/6kwbneFQlAsFrs7l5OitW3n+Jxroc
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L0hTd2k3VHc4UCtPcmZJU3pYWUNVS3JHMFhKaitzS3MzU1BCYnRXSnJtdXRl?=
 =?utf-8?B?a0ZLQnY5YzAzOElvQ1ZRNXJVVDVhS3EyUEQvZ3JWL28wRW5GQkw4dHBHR1Vy?=
 =?utf-8?B?MEZDM0xWQmRoTi9JM285OE1yWlpVOHNXcEJyZnZCUXJpZGNSNUJ5dlo3UkNv?=
 =?utf-8?B?dUUyTG9vV3U3UDFESWxKakNFWTVHUjBMOWMxb0Z5UllYOWdHY0ZOMDRmcDJK?=
 =?utf-8?B?Qy9PMjJzVnZtaldFWkJzaDFIdnNQUVBacTF0V2lnNElOc05kcCtKSEtjaFNF?=
 =?utf-8?B?YytnSGlVYmVTeW95c2FxN3lDNFphaXdXbm5FNUJrSms0QitwV2cxMkY1a1JB?=
 =?utf-8?B?d01ZVzNSOHA5UThOcWJOWTN2dnV2UjdYS2pRZGRkN2grQVVycWlYS1lOY1gv?=
 =?utf-8?B?SGJwakt2RkxJU0paTW5QZnYxMm8wVnd5ME9rZTg3M0lUVzBTcUN4MHBERC81?=
 =?utf-8?B?WnRXNU5oSGNmVG8rL2FoMEFkaDRLNUo2ZGFzMXl1YUlDdEVoWVMrT1ZYSlZD?=
 =?utf-8?B?RC80cks1dG55M1dWdFpTR1k2amp5ZnBESnBsOUh3bEpVTEtjTk00ZDAzbXVo?=
 =?utf-8?B?NlNzRDg2SDd1OFVYTEczZ2lVd2xRcHdncFdjMGlCRG1kTUtmbk1KcEVmaGJl?=
 =?utf-8?B?dFZzemlTRmFKU2lzVUtaMW0zYkw1cjdkL1Q3elRmc0pnZkNvN2FERFpZYlN3?=
 =?utf-8?B?bXBNUlloZXE0ZGVDWkQraDgvYXlGY0t6cWs1ZlFiam9qVkpCZEpMdmdtZDU1?=
 =?utf-8?B?NWRpSE9FR1doWWVkWGZhN2NFd213RUR5S2wzQ1pUdkNCc2lQU2FFRXAwVnhD?=
 =?utf-8?B?Ry9jaGR2REVhQ3B6UXkyY2RVR1NDcnlNcjBsY1VsdkgwclZ1T2tSVEZqd3RT?=
 =?utf-8?B?YTk5TGd2V1FqY0pGaUxHR0F6K21EdTJ0dk85M2xVaEZuN0VUMmlnNFA0blla?=
 =?utf-8?B?T2tnazg5N2RjNjhxbHJLUHBla2Mvd0IxRzF5Nyt5cGtYTERLYXRzSmQ4T2VP?=
 =?utf-8?B?RXkxNE5Dcm15ODRyWEpyVjdneEtZbkVjeHR6cWxuOFBKaitIQWU4Njl3RkFh?=
 =?utf-8?B?ZVkzQ2N5MTlzQWFEOHpyTkNrc1NFU0NlZG1ZaXFTa3dCcnZHSVZmcmdDQjFq?=
 =?utf-8?B?dUJZMDkzU1Z1WFZNMmlzaVkvcmVWOHhOTldGdCtaanI3ai91ZmkvZ3BiQUJ6?=
 =?utf-8?B?TmhrNnVoazJXY0RyejRCTWdqa3RXYm5zb09SV05RTENkZ01FZWtPdzV0aUV3?=
 =?utf-8?B?RXVYNCtjaHRET1dEalE0bkNhUVIwNHlINXpQcDdkTEJKSzVGM0NJT3RZSkpn?=
 =?utf-8?B?RHByY2Jnd1d4aUhxSGRZNkRsLzRvN21kUlQ0dzU4bU13UjRBcEhmdVJ1b29p?=
 =?utf-8?B?dE50UVZubVAwQU5qK1VvRlM4SGlVc3NXUWNhVlFlY3VJZjRqeURaT3NFeVp5?=
 =?utf-8?B?cVFvbGFtRUdVY3VSNEs2cCtwelFYTHNaRE9vclZjUVMwQlZmdGFBNjhCVXZC?=
 =?utf-8?B?bXExdkVmcTdwREtmL1c2QWZyNnlyRHhSR2ZOYzVyMEFGYTAwSEtXYTRHK29E?=
 =?utf-8?B?bkJZNjVjbXUrbVZXYnpkYnFjTDlmekIyUXZPNnM3UFJvaW04NjNTT0JLa0hJ?=
 =?utf-8?B?eTlJVVJpSy9TdHBRTGNpbmo1cHJuM3NFY1hPME0zakxMdDBCQzlGWlpqYXEv?=
 =?utf-8?B?RVg4QmgzYnJFemN2c3VhaCtQZXprS1UzcGVMWTkvY09zL2l4L3FTV0F5b0g5?=
 =?utf-8?B?RE5xa3Q4VER3YUdIS2gweXFLU2ZleUY1YW1GclZmbjVXcVh1NS9XcVo0RExv?=
 =?utf-8?B?TXdNU09hREp1MXJ1ZmFiMFpIQ01TODE3anpCdDl6MlFvbU1CSkgyWVRHWm1P?=
 =?utf-8?B?elYvNlpPR3hXdkV1WnJ2dWIzeWFBU3V1MzdzM1pETWo2YTJnNHNuSUppR213?=
 =?utf-8?B?akY3aDdoaW9FQkdOR0djMW1vWnFMNmVWdDdRbDBUc2FFaDFTZmwyT0t0bndx?=
 =?utf-8?B?QThacFc1YktqSitJUDN0VUM1enk1dm9JQTFUL0pxWVhzQXgyRndxZmhqTXUx?=
 =?utf-8?B?YTFmeHoxUXhjTFRnTDdDd3o2TUxHZFBBR2l1b1ZvdlRpMElxUFhZcTRET0d0?=
 =?utf-8?B?c1FlRE0yK0YyeW15UzZ2dU1Icjd5QWw3b00wUVVwSkc4b3c5cDhnb25PdG1E?=
 =?utf-8?B?dVdKd0ZNUzBjSWtEbitMRDIwN2dNMHNpcGtEb20zOFBIWHhEenhDRUQrVnA2?=
 =?utf-8?B?RWRBVzVlWkRJb0NvcHplUmR3OEpCWnE0SjB4bXV4Vjl3VlNwZEVLV1orTXpB?=
 =?utf-8?B?eDUvY2ZXRnFlaVhkUUprc2RENXdDVFZmdld5emM3QVZiMUNFbHREQT09?=
X-Exchange-RoutingPolicyChecked:
	csaDW/mKRKm+IxpZuP9pkVBuMxrMWjkjvPT3tzydh3PERgfav20oqhVcJdSRIHyMKEKgTlHbGvG7AGsoR5mLGHEAjkLm9UJc7bJstV4ZYW9Qsd5FPZbaa/5Xzhvbml4vzhlAqG67slNQJALTJYR7SkgSJshJQQesajWLKdk4eq1Zy9VneRCs9CVmcl9PZe4+k7SRttSSb3TXzhopiJ9y2uids5piGxr/0x0hvplvMRpkWdSstlUETk11GLb9a+hryS2ojGY83FXsAiDGyL/CaoFGbfS+qnMzlobkY7dC7DTRlYbEw2qFE4LEmr1Y/7cDCup+rCafBcstibo+Hlc9Vw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HCk5e9ZOsBs/TgeenHn1Imd1Y7sBWwPn+4neXJ+YHcPKWBIBozLFBBSt/w5VUDQGM2fkfa8tOLb2gipdc8A++zMZLQsTJxNpB2PY2vUk+xT8WtLpdN+fnsMs9r0BJFZo2OvZAVMSWjPgQKg9+aqAiyWpwC5T9Hvuv6qYCOwlquHvAVUE6DCENq0ctd3+3oad+FbertSTqcAo321vksfdIyuza7SyIT7MkMM3WGTnYqqKIr+uXcoWSP5MzoHrFoz/QHriimm0RXUQgzMh738WQeelzC0/HTs8qvDbDRyEPBk+APY7qYObiV+ONjxZPJdBONJgd7YkiVustsgXn3DWBfF5Xn9asslRZHIDXNB8u2L8sOPO2XDLLFNIXPAfQWABXx5v/e4w15uH7vtTo2xnpDDHISmzSd7y5pYd/8TBk4WdJSkkqGXMRGnzpoGd1TTqOPkpXER1L3FJoYGJ7+voyEdNO/z6QuO1himI4NJy4NGyGu2UjqhUYRppYlPPf36den1MTT5Pr9rZOQNZJ/xxrsj6P6NWfkjhNIiQEPncPpptzRiSa9FuJOLgwX6kcy/vss+zTjpY134Ab5c4jeem8A2wTXL2iVTmo2TiPkktrL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a8846b-0dad-46c7-4f6a-08deb4fe9faf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:58:03.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coWJlD3gqeBpSwC5BwDFplbDrbvOdyn7XKE51ixskHIxr4aLDoLfVmYZNybxa0hNuONbFBv0B5n0Cppp//SsNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605180166
X-Proofpoint-ORIG-GUID: g2-NdLUGR0x6beIMlccTJNgwCBSt25BM
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a0b4524 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=ivRFNOwAt4n9eVkbAtgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NiBTYWx0ZWRfX6eeppdW/IVwa
 HiRQn7bpI6T4hW4yu/phBpPZ2XDgwh954oUSLziJ6D/j5brXRvpttmj54lItRCTMSXAb5vDK0+i
 /wl8kFBYx33cKr/KkJgPU1IWC7gHf/Z6OBOq5LmHi6MggzBJabIBgbSAIw7RjuVBqb4Am03ykRn
 VYFZJ7G8APjRRsjC5TJClIUXgy1FXKQvH/MjYcpu/xJ+ceDkfTIMiP2FtQyVPxrpuZbg0D9m0kp
 enEVIa4O84uwsnfMTj3Ng6VlKptvcbwP0BSZOEGGQdVsD24swwsPZkoRso/ZgBHqYe0XvYjTrRy
 vTKXIkn0gWpUpg5qt1YnDDfqnxSywgj/lYg6Pp7RYb2V55t1HGX1wXTq/MTXmZbhGimZC6YlHZ+
 ZG1VHJKHIWNNRIGYVwxjWE+U/qMsCpNZVo0SE9HYqtAje4/+4P8LWg8zhMQ2j9OuA/RXiZu8h4d
 +W/KAqoBKcOHoO8cA+g==
X-Proofpoint-GUID: g2-NdLUGR0x6beIMlccTJNgwCBSt25BM
X-Spamd-Result: default: False [-0.15 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-21664-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A807F571582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/05/2026 3:09 pm, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On Wed, 13 May 2026 10:42:52 +0800, Yang Erkun wrote:
>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>
>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks") describes an issue where calling svc_export_put, path_put,
>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>> accessing ex_path or ex_client->name. But after discussion in [1], it
>> seems cannot happen and either will introduce a gression that was
>> already fixed by commit 69d803c40ede ("nfsd: Revert "nfsd: release
>> svc_expkey/svc_export with rcu_work""). Therefore, reverting commit
>> 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>> is necessary to fix this regression.
>>
>> [...]
> 
> Applied to nfsd-testing with an expanded commit message to preserve
> the context of our discussions.

Testing looks good, Chuck: no crashes, sosreport no longer hangs, no 
seq_file warnings.

Tested-by: Alexandr Alexandrov <alexandr.alexandrov@oracle.com>

cheers,
c.


> 
> [1/1] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
>        commit: ef4e34669aa1a15d2f5ba86fd433fcac9aee81c9
> 
> --
> Chuck Lever <chuck.lever@oracle.com>
> 



