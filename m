Return-Path: <linux-nfs+bounces-12104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBAACE44A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 20:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F627A6BC0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AB1A00F0;
	Wed,  4 Jun 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dpdzEKn9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AR1H4orG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10E86337
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061254; cv=fail; b=NHQ796uWAtzKIpFu3ezttFXJdxeGPdC9gDRNTFrUj1Fbn3bMvI10zoB+TyMJasfbuJxhUZ9yINSf7z+XfjsS2zCDUF3sbBEls2jCcn0ZxPMG9kbPN765cjOBooOy6dqix6MdHa4l+ja9vjKeG5cHNx+CLIAuBAIOz0Gsi4Bsdqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061254; c=relaxed/simple;
	bh=QWTvLr7l+aLmrvIuoTW9iVJsDgwkHQflhtmObuFdrDY=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=tK5sNgHyex4Zjqb9Bnb99rVeFzEyKsRCcpLeHB4riLKX4fQWJ54jCkCwyZF2ImH3VBiHZ1feXJXrLVEXwCRfTN2lpiFdEG8Gi/rGBHtzCJcfIqwD0ihC1e3E23yZFZhRNZ6NZ3kjwhrQzvpIZrYJhfk7iK1BeaQC4aTsmuclkDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dpdzEKn9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AR1H4orG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554FdvSR022899;
	Wed, 4 Jun 2025 18:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=myD4jio+/OFjwznjjtTN3DBx+PR5ua8Lmup3UUrGvsc=; b=
	dpdzEKn904dhWoN6V0SZBFrm1QAqsdrx2IwpPv3J1Tep7IQ+TivTJvvphgqFqlHh
	nwaVzP+BZzhT0xWkuJUqk+WyhEMtp8VKRMT7HvnH8hzIWLr+9TbJ0L/cWpCJwH1f
	cOt3TE2XlE1fuUlgACJmZq3FUPi9caKpy4ZdV+IrGIP0ihLpaPZpy0wtwOKkxYkM
	nksluX3LnamtrJ88cR1ovPiZYjNkBgYsyfGyN88a5SxSW1M0WD/xKPAGpRuXn+Mw
	De2oAXayD8BuoimT6LvFYVjSX/kv3FiHOX5Ghv6Jq7pLOGuefQmhdy8MnyROC1u2
	fKZWjNa0drytMIlah/OHlg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8kcmjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 18:20:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554GrsCr030680;
	Wed, 4 Jun 2025 18:20:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7b44j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 18:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA0mqYw14tuI8kTz29dcT1NjpW/C4nlCrQ25DVC1Pj9sUSuKdYNJ24FkT7bONl3cR85FR6DKG4o2HrfKnyK5JA/UuZonsF702oy1Uiod0r06SmebvGkOLgcy69bpllmkT0V3q2CfaS+Jh9WGQMRDD1dJY6sQON7Er71K8l4r2Q2tyhLzHdRGYjnK7tFCIfvy+jinirow/n7Ow0GeMpy9GZ1xtOfz31Djk1WNzcaOv3lQpYcQx16AcQQVN/uis5iPiVioWJ23ezUYqxbP7WrkVv8aBuZbz9T3vwAFRpG3jjDwXFV/jCGHar+cvxDqTEQIj8uhDQy7MpPp751Xr43ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myD4jio+/OFjwznjjtTN3DBx+PR5ua8Lmup3UUrGvsc=;
 b=T4rCGjh/tpAxS3dpKI4BfTyUMmm7KWPTjtd/UxZwaiMPDwyyt9ymwoBZUX/X+BtK1KTXJqyOjm5YH3zUj4bJGbEKSVpgTCXXYpLGu5tHkkd6ELvB5xcZxbKJaJJjH/xVhc+J15lQsfOCXQHdVgtjt2XUK0HJtjUndveEI8xIw4bSn+lgBULocoba2RPcW+2E54tol/xxZ0e0Zs3oB5FiAQJEGGqM9Q8k6a/DnXck5M3yLMIgNU7uOuZeIwluoMozv/yYij53StcdNZTcGrwu3ddvxiTQ0xaUErpx83B3OrwZtLNpWOYrVXLjvjahiL1UP7+ss6ovKHZRkmB7YFRDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myD4jio+/OFjwznjjtTN3DBx+PR5ua8Lmup3UUrGvsc=;
 b=AR1H4orGUqvmd3VV2fFvgFvlUxdv7slIrjQ8oU4n5Bq/td7jJzqbma/UF11YcMAVG5poYQ80VnDiosCFSs7Lytg5g2OHLRjP88VGc+GAPDScSQaqaF6OXtRAoMAc4Utl/uKKFKfox0xmJcQKNJKjdCHHMjI7IED/K9jUT1J3Ce8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5662.namprd10.prod.outlook.com (2603:10b6:a03:3dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Wed, 4 Jun
 2025 18:20:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Wed, 4 Jun 2025
 18:20:46 +0000
Message-ID: <a5d54600-ebda-46a0-8eb5-96b7c8c60f6f@oracle.com>
Date: Wed, 4 Jun 2025 14:20:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <20250513-master-v1-1-e845fe412715@kernel.org>
 <CAPJSo4W8cN6ZGuFDs4Dda6KDs29ggCrBOq4CJC5FGrXh+bYGGQ@mail.gmail.com>
 <de3fb73c-04f0-4466-a776-c90794f214a0@oracle.com>
 <CALXu0Ue404JV5+g8Vabm9zwr+9pnpux9TZ0Sa92brSWcXdPuOQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
In-Reply-To: <CALXu0Ue404JV5+g8Vabm9zwr+9pnpux9TZ0Sa92brSWcXdPuOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbeca43-6d0e-4761-0c86-08dda394866a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SElwTlNRQkVDcWJsWkxHSEJGcTk2TEdwWGl4a1JxbGpFSGFzTkdMUVNyd3Nj?=
 =?utf-8?B?Nm5BeVZhMzRwRnZPZ1dJRnZDdVhRaDQvQkowSFhnV2F0a0M0QVJzYmpMc3By?=
 =?utf-8?B?TWVSczZOanB4dFFQL0VwdndwaFdjQlkybldzekNNQWhLdWFXSmQrUTB5YmtZ?=
 =?utf-8?B?VEdQSStzbHRIZ1J1TWxDTnBKTmE0LzljRVl2Uy9hYS84aEtuV1hlUjBWcFZT?=
 =?utf-8?B?cWUzVlhMK1BCckdWZDlXbnRIWEVqRE9uano5Smkwdkd3c1BpT3hvUkhveFl3?=
 =?utf-8?B?ZC9EdFdZSWZmQktjbFJKY0duSUFMMnpZWVVjK2QzS1U2eDVIQnlUb3dDdGFP?=
 =?utf-8?B?MTNpWGdtRmY1SnlvL0J2ZDFVVlFyUWRCZ3VqMmdXblRIZXdCT3VnZ2xOTXZJ?=
 =?utf-8?B?aHQ5cTBrT2twRXVMVjZRN2tJcmNDMnNNelhhdmVya1c4dm5kUHp0NlNqemh6?=
 =?utf-8?B?WGxKRzg1TEZmTXBGL0gwTWFXSTFjZGs2KzlPNUhMZ3pvT0Z5QWRsZG5NSzZM?=
 =?utf-8?B?dEFmZjJ5K2JyaHEzVzZnVWcxZlBROUV2WFZNT0VjMDloNkxDejFLN05WNmZI?=
 =?utf-8?B?Qy9DbWNweUF6K2M5SEI1eW5kczdZU1dXRVJxQnFEblpUUDU2WERwY0ZBSzVF?=
 =?utf-8?B?YngzaEg1Z3E4bVlYTTdsY0dEeGtoRkFPZXBsUExKSDNocFhGUC9OeS9mOVNr?=
 =?utf-8?B?OG1uWDNBWGVZYzlhcXZDUXl2K1lrZ1pCU3dUWFJSVnNXaWk3am9Ec1ppWHlR?=
 =?utf-8?B?dDZKVytWcHZIRU1uUkpyOXg5bjZjT3p1K1lNaTluR0gxWGkxbWVMVWNiUU91?=
 =?utf-8?B?QWN0ZFlPRWJuaGlZQ2NRYjBET01qU0ExbEtjSnZiOW5QOWMzbk9WbmxFVC9r?=
 =?utf-8?B?Nk1YUE1xdzh2eUFJdXhxcmZHbERQaWs3SjVjZlhvWFZYNVB2VFVQNEtaYTAx?=
 =?utf-8?B?ZG1Sb2ZDLzhOdm5lTndESldLSTd6Mm91cW5uOEQzWlhjY3NaTk9LYUhhd0ZP?=
 =?utf-8?B?NUptejZFdlYvdVM4a3RSVVpGVFdKaStoclcvbmNLWldsR0JIalVjN1pCcUsx?=
 =?utf-8?B?Zjc3RXlmaWNjdVNGdzN3QTNIZEJWTDN2OUxEbG00MklHQkhJRTdDZnBqQ2la?=
 =?utf-8?B?SC95MWs5REE3Y2xkSlEvQjNvbExhZVZnOHJKeEVPb3B0OXhSVXVUQWd6bFJO?=
 =?utf-8?B?MXdVemtpbzE2OVQzRHBLbTVpTGtZTDBsR0JXVVNVY0RIYUNhZS8zcWRGbmt6?=
 =?utf-8?B?WDg1ZTZ6K25NUm1FNzMzQkpMUlhpelFpTDg5SmFZNldpa2FJRTE2U2FZOStr?=
 =?utf-8?B?V2hqT0ZxeFl2OWdaR0NFZG01QXdSNW01cjd2eHdTamIrQkJ1a0IrM3FSVUpE?=
 =?utf-8?B?cW9UdVlUblJRbk5WS2NRZzlHRlBlTVNzbUlyN1JWcGhLTjJ4NHpGNzF2SVYv?=
 =?utf-8?B?Z2lQeVVWSEpmRWYzaU9SSFB1RVByQzk1YUJxYkRaNnZhTWJCUTlvdVdRMFFl?=
 =?utf-8?B?Ti9kcGtFZjFlZnY1UUxrQzlVZWhjS2J1TnFnS1VySFBWY1FIclVybkNwRStv?=
 =?utf-8?B?ZFUvalVQZ1dWUGhUVEZMQ3pJWmsxYUx5d2REa1ZKdGNSTFlHVFN5T1FzRGRr?=
 =?utf-8?B?WGFHcnp0Z3ZXM3FvWkEvNWRyYzlvMTZIMnFxSUpicjlodGE2a2NzUkMvT2pt?=
 =?utf-8?B?Yjd6eFowcGVPQmRLZGdGNnF5RHNNMktlS2ZVVVRHLyt3N21Lcm00SnFISWJL?=
 =?utf-8?B?dW5hd3RGOUNhN0FnVlV5K2J3K2dIRituaGtPMVBkZFZFZFAvZUdpL2ZteW1y?=
 =?utf-8?B?Y2hmZUU4SEJpd1FjUkgrNUhFZUsyOW1QV3Bob3ZMMXhNMTJiUk1WTGxuUFV6?=
 =?utf-8?B?ZTBHcDM5RzlIeUlacEU5T25Bb0tLTUZ6VjJaZmdJZmwzbXVFU2xZTnJzMWFv?=
 =?utf-8?Q?uSl2fQiYzSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjlyRWpUc2hLbFZPY0hPNml2ZVNUQkNTcDZNemFkMEtTTGEwWGtlSlBXQ0FL?=
 =?utf-8?B?YmlqTkkrR2o0emZVYjB0ZFNkcUo1VFhLQ3VNQ1lEdlJpUXJjZll2eFBKaVB2?=
 =?utf-8?B?YUlRQ2QxRzVVRjMycjRPc1RzbTkxVkpaMmJmQzhIZksyRjQ4cXRIQ0ZneUJY?=
 =?utf-8?B?eG5FTVFhcE9STmV1UjY3Z3J6SnZYVis2TkUwQXRzc3RRcElSdS9WdlZXVlhF?=
 =?utf-8?B?aysyWXB3azhtZm5pWXZYTmdCdG51cnBsRXo2dEdWOCs1YnVyck9td1RLSmxU?=
 =?utf-8?B?QTliREFhRk5nMFZTR1BCMGs2U3BOS1g5Z1c2dFF0WENjMXF2YkppUHorbFZ6?=
 =?utf-8?B?dzVpODNLRXFMY1FvZ1pWRTEyUTIwaW53cGwxdkpNMUpmc0FLeDRaQmlKbXFK?=
 =?utf-8?B?dXhuaVN6bU85azVtMTlMZUJVckY1aTVDME9QajY5eWFFbzY2ZzVsVlFVNSt1?=
 =?utf-8?B?NHpYSHgyWUUyUDlGTmVjbENab2RPVFlURlllWnpIK3p0RzVpaS9UUEx0Vk5O?=
 =?utf-8?B?MTJTR2FRTGNUM01OT3FhNmsyYVFrVHZtN0prSDVzd2syL1h0eHVVbVRjSEc2?=
 =?utf-8?B?bHRMREhZeWo4SXNyUTM1bUpsUGw0TDVXdDN2ZVR4SGt2RlFXUy9qZzJVRXVo?=
 =?utf-8?B?ZjRUUlJkMlhFWjRLaHRiQ1Mya1dDQ2xuUE0xdDRnT1R6anMrMXQvdGFmQ2FP?=
 =?utf-8?B?ZWQweFAySlRxUEZEQ28wamU2WFBudmVBS1RNSXNyZHZrdlZFc1JxYWM4cWYr?=
 =?utf-8?B?VkEzeGdjWnYzckVrY1dmQVFjR2E2TXMrNTgwVnFFQVVBWXV3NE1UMm5YU0tN?=
 =?utf-8?B?dktzUDVjUTJnZzRkVWMzcXpmSVBlaGxSelpRS0dvL3RPWHZYdXpLb0J0dnUx?=
 =?utf-8?B?cGcwQTZTeEc2eHVMNDlYa1Z6YjFES2xPVmlSZ1QvZUk2OFpPc3NLeU4wbi9h?=
 =?utf-8?B?VkN4T2FlL0w4MVJOU29jM2QrSGJTbTNJb0lDWTBOV0s4cjRGYm5xNGlYdWMy?=
 =?utf-8?B?NGFRVndFc2R5ZllnWlZvd1hDOHh0R3ZDNmxLVzJxMWJwUGJCbC84OGhJMmxs?=
 =?utf-8?B?RldYSTcxTjJ0RDdLdXR1RUdPaTAza0VSRHlqZXBVZ3pTUWZrL3FaSnAzdndm?=
 =?utf-8?B?VERRcHBzZEhFOVp2QjRJOTJGbnNCSnpPWGZwOUd0a0NFVDNZTWRCM2hNbG9W?=
 =?utf-8?B?aFJKajUyWDVPZjI1MTV4SmtESkZiWWJ5OEYwZkJkbXBoRTJ2S0gxT2VxUm1a?=
 =?utf-8?B?cnd5KzREY2dOaEhLOTd5RG43aHozcFB4dFFsSk9OZ1JaOWx0S29ITjlQM0Yx?=
 =?utf-8?B?OUFpNzlTM1YzTXpxRUNPVmVJOHR4dmZTem5VeU5KWFZsbnRQWEM5eVI2aGR1?=
 =?utf-8?B?bU4wTkIwZ1ZKSGhpNlhFSm8yVFErdW1wWjZjNzRmaUUrMThESWI1bGdBeU0r?=
 =?utf-8?B?MEFrK09LL2kwWUE0MjM5bHgrUTd0cUtTMUlKSGxEc0ExbksrQmtsWTRLbzV6?=
 =?utf-8?B?TWRUV3BUU2hmc0ZVSTlxZ0VteWtqYk9nZEU1NWl5WFpURExDcWpOSG53VHdp?=
 =?utf-8?B?dkowNGVQSEVTdE5NT1dUQ0ZCMi95S1M2b2ZoSktYWi9PZnVud2lNc3M3bEJU?=
 =?utf-8?B?ZUhQWTROaVc3SHJJQ2o0TUdraVczRjJYN1RXYjJYWmVFQmFZWUo4cjNvV1J1?=
 =?utf-8?B?S3c0c29GZzg2cVI3OWVNMXQxNEtIY1liT25WeFJVQzVNaTZHU3JVV3ZYMHln?=
 =?utf-8?B?b3dFSVJnL0J2T2JJNnNFc1BBcWRXcnpZS0FJa0tSRlJCLzZ3RXdScFRNWURP?=
 =?utf-8?B?bXZFM3VXTTlJQi9ZUXd4Q3Y2U1g0WUk4bnVsR01pamVoQWl0RW5ibUJwRnMr?=
 =?utf-8?B?djZSb2tYYTd3T2E3NkdKSzNqVGd4Rk8xSDFwWWNGL2pVYVJlZUJPVGFpM2xq?=
 =?utf-8?B?R2pTd3RrR2JrM0RiRTgva3l0RkE4RUhUTERxek9qendPbjBIV3VpQ0lCMFdm?=
 =?utf-8?B?Z0N4T0h6c0Nnd0JZTVI4dWJObDN4YnJKUlNmd1FiVXorRnZkMk51U1ROQUE1?=
 =?utf-8?B?UjBQN3RrMGpLWUxQMmlWb2pXeVljNHlkeE5KWnhEejlGTTB2cnZmWVQyWFlQ?=
 =?utf-8?Q?GIATOBGuy33czXrvmKHqW6a93?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kWc6gbBMZrEcFKaY4u7HxTKAVCrOp1PqbonE43AXfRhYcxERr44C6X0Uxt8xjnKUnIaWjB4F/Ws12HFzsJn5+qqbYjLRSLkB1ke1Jnjwtz3dBsSrLU0HQjlwCUjJSy246H8xrOQ4wbmlQJ2AORwdCyC7PYmHecFlcJjSFf9CfoSVeHKo7xzCEVDt+wejaPsWRaGBJetaYNxdJyju7DYfMiXyjSOklYj7mwDyFaPUwCIqAHZBlgJV0tCEBrkxs7QkQg4HBnNPOE7ZtywUtxTGqEhQXsUNXBqnN60m0YpOY8jZ1GTTxAUdf2353KLpr9QjR2Y7f1JYllXZZL9lmVGGIKmfXxsIJjp/Xy+i+mMXpdAMvp++2xeqrtIQNT9VY71NHCjXfdHa8cwmx4Nt530PmLJC6KmEyzUkkvc+EejMvYo5n01/4PkK4wcbTkYWt7MkS+AHroSrRJ3NB1nK1sSi0dG3MSCvxnA02ImIFC2Xr5mCa6d9MNv7DHTIa+zILylohk0GxG1x2zR6Zc0KJoohpHHZUVTrzRrdKNuHC1l2uYqeHEP3l+yd/9miz8FXhkWfieDCoIEJqFBhyCPhzH76F+pXhViJ0u7FYGsuV5sl0Bw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbeca43-6d0e-4761-0c86-08dda394866a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 18:20:46.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPbvDehIdax5k4QCbKWo6P1eA/pwZR2ShZkgTr0LQ9UmDEfnetRh0lwfVgbLwuOjnUZgqfdp+W5sdnNBOjt4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506040142
X-Proofpoint-GUID: kaY0AB5lUkRIyU-N5qr1R2Ti9EmavHos
X-Proofpoint-ORIG-GUID: kaY0AB5lUkRIyU-N5qr1R2Ti9EmavHos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE0MiBTYWx0ZWRfX2W1TwJSSgFon fmzXtPj8yap2G3fGUgt1KIliE41vfE+81os1IJSB56OaWJ4hri3SNZI72PzneZDcZmBQT65gQgw v3FL56JmlQluRvZ0d/WhUs6dtsn7pjnbHpkEcLCTD4lyrCB8Qzeatt+fydePy1z7fI/9yNGcT4W
 H9zZgjhzIAoBbNYQiB+gYrhmW4R354tQG5dHT/gW3TLqPzr/rheOGsrExDP/nH9LK12pKx7TUCV EPqwx5jSj/nkZHS+ZLM5hhmd4hI4Dr8y7T9Oxb24cloFnsD3bFhz3q9vd+N7m7TguuoG3hYSgim qzjb6Skp0KGhMeX2rWcplzZoyNepu6jrSLNTkECR2+ask7MYLuIcHuXhghagRms1+/PJo1PvX+P
 SSfRyI8WoQTD+jn63f+UAYIw9a4PXP7y2dK+DmbcQwFUvsQXu36OUbeY4zrXxLKUxhqeQ1i4
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=68408e82 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=tqpJoJ6bnGg8ZAmkeTwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 6/4/25 1:12 PM, Cedric Blancher wrote:
> On Tue, 13 May 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 5/13/25 11:14 AM, Lionel Cons wrote:
>>> On Tue, 13 May 2025 at 15:50, Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> Back in the 80's someone thought it was a good idea to carve out a set
>>>> of ports that only privileged users could use. When NFS was originally
>>>> conceived, Sun made its server require that clients use low ports.
>>>> Since Linux was following suit with Sun in those days, exportfs has
>>>> always defaulted to requiring connections from low ports.
>>>>
>>>> These days, anyone can be root on their laptop, so limiting connections
>>>> to low source ports is of little value.
>>>>
>>>> Make the default be "insecure" when creating exports.
>>>>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> In discussion at the Bake-a-thon, we decided to just go for making
>>>> "insecure" the default for all exports.
>>>
>>> This patch is one of the WORST ideas in recent times.
>>>
>>> While your assessment might be half-true for the average home office,
>>> sites like universities, scientific labs and enterprise networks
>>> consider RPC traffic being restricted to a port below 1024 as a layer
>>> of security.
>>>
>>> The original idea was that only trusted people have "root" access, and
>>> only uid=0/root can allocate TCP ports below 1024.
>>> That is STILL TRUE for universities and other sides, and I think most
>>> admins there will absolutely NOT appreciate that you disable a layer
>>> of security just to please script kiddles and wanna-be hackers.
>>>
>>> I am going to fight this patch, to the BITTER end, with blood and biting.
>>
>> Lionel, your combative attitude is not helpful. You clearly did not read
>> Jeff's patch, nor do you understand how network security is implemented.
>> Checking the source port was long ago deemed completely useless, no more
>> secure than ROT13. Solaris NFS servers have not checked the client's
>> source port for many many years, for example.
>>
>> Most of the contributors and maintainers here were first employed by
>> universities. We're well aware of the security requirements in those
>> environments and how university IT departments meet those requirements.
>> Any environment that requires security uses a solution based on
>> cryptography, such as Kerberos or TLS.
> 
> I wouldn't even dare to mention TLS here. TLS is mostly experimental
> at best, and its performance is so bad that enforcing it might finally
> ruin the Linux NFS client+server reputation.
> 
> In that context, TLS is not an option, unless performance, latency
> sensitivity and CPU usage can be improved by at least a factor of 5.
> Yes, factor FIVE, because TLS is that BAD.

I've heard this claim several times now with no reference to actual
data. I do accept the claim that NFS on an ssh tunnel is going to be
pretty awful. I don't accept the subtext that NFS over TLS will /always/
be terrible for the rest of time. (and note that QUIC is coming, and
for QUIC, transport-layer encryption is always on -- this problem has
to be solved).

We can't begin to address problems that we don't know about. Can you
cite a study or give us a reproducer? Was testing done with a NIC
capable of offloading the TLS record protocol (on both ends)? Flame
graphs to show us where the CPU bottlenecks are? How does the
performance of NFS on TLS compare with krb5p ? I would greatly
appreciate seeing careful studies of the problems.

Lastly, there are plenty of light workloads where TLS is a more
operational choice than Kerberos. It's fair to exclude intensive
workloads for now, but those are not the only workloads being run on
NFS.


> I only agree to this change because Solaris did change it long ago,
> but even then it was a highly disputed change, and today's
> universities still prefer the "resvport"
> 
> Ced


-- 
Chuck Lever

