Return-Path: <linux-nfs+bounces-1274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABE837698
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090F11C20BC4
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E812E62;
	Mon, 22 Jan 2024 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBjxnZjy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WxwggO5K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80212E5A
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jan 2024 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964005; cv=fail; b=aBOUszGz+vU/GJeYykvZjS/lJhTcJ7/bu/ZG8k0lZPlHh/lPSBEQV0RsjBN2/02P6TdnUVHmclPA0eDXJloZgVgf2gVF7X555fFy9CWrQVfKAim7RjTBJ9UpvSxBzBWq/U7kp6awsXjxMw4v35rspNmS6gWH+fXKZ7tcjHeE3lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964005; c=relaxed/simple;
	bh=ouADzd62f7fL1349ZQhm4mtdnTPGY73aSEGDu442aG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AT3TFXxQ0OUPjRPsXJCut/+ykPxNHIHimV/b5KtGg4THjJ7pgzBeFLVhkg0A+KebWhrT2e0kOoN2l2Q9yx8LJaorHLbVf+jIbDHQJ9wFhcinXIbYqvTZIMjVBLQD3V/X7/g4GYpCkCeoT3gGGxP1fOtKPRqO4quG3wt1RtIlOL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FBjxnZjy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WxwggO5K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMoxxW026788;
	Mon, 22 Jan 2024 22:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=zmo3AXV6dJWALMTkOn7bTj/FJe8nNqnQt2JPFh7l4DA=;
 b=FBjxnZjyW3POPBQFsH9DxIwLwxCK9edHt2FZK4tLUgRvQKru+7SnHzAMcyhk4cHjLZos
 QSRuHiE50OMySjFJPi2qFCL+96IVQiDvdHuOITdhS5J3c9Am7BKJhPlfEvHcKhzJ3L1G
 Wf+DIIx6If4geBvX6qY22I13h1cxUgNaxifv3VD2Uc2j73cCbI3mnF6jrS5jrVaPkuwj
 F7PmBgGDTcjSY9O1jnu6aYfipThj9Gt8kOhaj64I6mglATL07cNA/rg/SE7Hz6pC6/+J
 BO9CJEh2tCDNKumc3V195F/J76Iq+80BkBvR8bBgYHb5JWyGlFNK3FuZ+E1eCCkxW9LJ 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anmvy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:53:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MLB4Yf013191;
	Mon, 22 Jan 2024 22:53:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs36ywrww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 22:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC7Bch1ziOQrJeOztPzKRPL0oa6tRLS2UBqn3oJm5sol/mFNyPlzF0+xj4zCrxp2L8gtmMYLy5G94bBpRQthcH3Jx/6Cu7wuo84gTFOd24IUp/hHLLpajM49qpcFWmT/0izA9j4bbtyFydrURJju+Dw4duj0F/ErEnw8bAtW7Oqy909icQnPqgWgdYT/abTOwarZYoqSl4tQlUF7PfBBCOyrAHW60r9k0hrUoiEmwnkdmJrrBUVwuCTabmKoMCDOAiN2JP420RI3DCsdDtesMAcqOe1VWStvEyUTGQyvf20r+CA5vR6CYcuVRA1YOaQR/HvNz2PLJ60i3cJydEnodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmo3AXV6dJWALMTkOn7bTj/FJe8nNqnQt2JPFh7l4DA=;
 b=bEVyQyKQ/riCTiCWv903/Onp9LAmyp0GHWHyLwlo9R3RO+9YnnBK88KiWVjoRNaAR5lctiRQ06IFIS8gUSEww4USX+pkrupTmyg+JJMRAUer6JFK/awc0Rmg3N4+BkuQkqJzpaf5b2jSrizVLdn5U1+hVHW52QsZp2ZxB3GT2JHResG9/DXsiQ9bAK1lk912lJ/ysT98A85k6R2eEprsyrAGuc17VKNQHpjRm/U2Fc1JCxysx9rSj3Y4F+d5PUg8VEFQ5vJYapU82QIDJq8TVY8YLJM/htdir65IsGehCpVVLr2miQxyl/r2yeMh4bgo6u3UgW8nN69zEyjUTLSa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmo3AXV6dJWALMTkOn7bTj/FJe8nNqnQt2JPFh7l4DA=;
 b=WxwggO5Ka2fwIeeW6LUitQ3YgAxgmWe8E9hJFGBlZPvWOAJgJVlIg33rThkEp78142Efg1k0VGFwVa4BqlVtZT6lHzLjrGs1Ea6+sqa7IR2/iMcaSHCEict/ncK/4VHhaS3R0Vvhuk0srVLk4yIKWIiIL/i7dOE2bLPvCZlMNTk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4272.namprd10.prod.outlook.com (2603:10b6:208:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 22:53:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Mon, 22 Jan 2024
 22:53:15 +0000
Date: Mon, 22 Jan 2024 17:53:13 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: samasth.norway.ananda@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [External] : Re: [PATCH 1/1] NFSv4.1: Assign retries to
 timeout.to_retries instead of timeout.to_initval
Message-ID: <Za7x2aYNRqc3nIbl@tissot.1015granger.net>
References: <20240122172353.2859254-1-samasth.norway.ananda@oracle.com>
 <995F0BB9-C709-4C3A-92F3-5EB9710A47F5@redhat.com>
 <bdd760d9-9900-43ef-8000-0e9ce0aa8b3e@oracle.com>
 <8B835117-498D-484E-B1DE-912FBBBCC74E@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8B835117-498D-484E-B1DE-912FBBBCC74E@redhat.com>
X-ClientProxiedBy: CH2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:610:20::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3b1e1f-8a1e-4c32-f9d0-08dc1b9ceb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b042RHqNGjHBAo+3iLEEg8HaAPBUv7t1nRhnCz3ZCxfoQEomAZAZjGWIttor7MtxN8yyMiLotKh/XHUWUv3uQmRcU8qT+lvoct3S/ySs2Wv17909I0qWLnwSHPHmHsohAmHrrkifdmh+VJGU+AUSPGfiOaMy8uLZWcmZ6z/lYVFuKrvdUa9R+FD5Q3DNSJySjHaAc5qIvUQwcc3xJIxUXqsEmdTWPbdIfkKjJaWz5k0CYiJOoOPNWQNZuE3uqEBQNFJOMwMZ/pdznRlFuCiTi1vq5GG7N2lmGQ1kOc5dllGuemznDUju/h858SWKe3gykSWXPZVVSGl77h6lNyqf9ERzqkDxTEmsmqsb0RiJFV3mp/M8z0r3X9XiVoAeBlTF31Ap4Oin3H7E+hz4aNI5fiW2a7X1ZtSnBkPwrctl/DOjUdcHC4G9bZYNfs+gRLEHDJGhtUZC6VjzWcHhfQ9oYwD/Q8pzukJLZBRRIUdh9cwL36ISKy8syoQEJ9AOD6pyqok9L1WFi/qj5NizD1Xg/IDhu9HIYsww/05RCPAZmrkSlMpGQTBh6tjf2cIsrHPO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(66946007)(8676002)(8936002)(4326008)(44832011)(6916009)(86362001)(316002)(66476007)(66556008)(6486002)(478600001)(26005)(5660300002)(6506007)(6512007)(2906002)(9686003)(53546011)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elpkcktwTzdJT3NSOHE2UXhVRU5RTzBJQU9JSG9aZlNWRGJoa3YrZExpWmQ5?=
 =?utf-8?B?ZC9nNTVYRjZtQXlGeUJvc2dXZndldVB3OHZhTm5jUi9xeHpaZUpQVUdocXNw?=
 =?utf-8?B?QTBFdGdDYUhBNHFsV29Cbmk4TDlXOWhTMHRKZkZpVkZHSlZDeG1rVWFqSGx3?=
 =?utf-8?B?TzRBSEwwVDE1MldSNkNDTVBjRWFKTHQ0Mlk1RU9URjBtUE5aR3ZYN0dmZTV1?=
 =?utf-8?B?MTRMSEFDR0tKUGdnOTF2dUVGQ0xYKzkrQmNNdU5nRWVkMy9QdXM0K1V4VkRR?=
 =?utf-8?B?bTQ3bmZXcUJhdXRRVlhhRFNVbFcwSVlOWFd4c2RlT3RUeUg3UWxBeXJHQWJV?=
 =?utf-8?B?NFFVa25lc0ZSSzA4cU0zOWs5eXZOc2RUWmpLVDdBanBwSVVwWWRLS0tYOHdv?=
 =?utf-8?B?VWhMNXhaNXhGZFpsVkxWQUg2R0pyYnZIZ2lSYTlXVS9qMzcybkdEUkFGMHdL?=
 =?utf-8?B?SWdRVTIzdXFtclVBdWFORUtlblZvcWNoMlRBM1ArMUpTSTE3VC9aY3dZMUlk?=
 =?utf-8?B?U25YZ0g4YWtSU0FpTDRVZ1pZTXpIY2ZITVY5QS92cWFBdmM4SXcwb1ZmdnBO?=
 =?utf-8?B?K0xyOVo2OFNFVUxCNzRqbHFpbzZManFybzBkUnYzL2k1TGZGUmVaRE9QTFhn?=
 =?utf-8?B?TS82bG5LQ1NydDdCemxpWHFCUTlkWE5xa3YzRVVwUFBOcVZJMnNnckJUUFFr?=
 =?utf-8?B?ZHNzblU5Tm5ZUTN6S1M1cUZlWHVuVW40Rk1rOXdwcWtBS1QrNDY5a1JvZmVN?=
 =?utf-8?B?N1MxaVU2a3dqUDFQMHV3WWlRcmZucnUrdUtqNkN2Y05ndDdzeHlqVVNrM2lm?=
 =?utf-8?B?VlUwNFVKbVZBVGphS3QyZDZOUWM4b0pzbWpHSkMwdjgvWm8yUXgrMGsvOExp?=
 =?utf-8?B?UDhVZndqdEFmbm1MaVFBSm5oWFpYSmxoNFVpQ2k1VHBGWm1yM0hPZ2dNWTZ4?=
 =?utf-8?B?b2pzSmpWVWU1TXZFeWhLYnVOUTRpaThwNnlweEhCejRSZnJ2MTB1aVBpcjd3?=
 =?utf-8?B?OTVuaDZZV2l2cTMvS3lPSlB1c2VKNHVKUVVSQ1d4OU9GVUlBRXVSdjdKR3dq?=
 =?utf-8?B?MUR3U3VOdThpM3I5YzlZWUpUd3pXZDVLVldLL0dtSEdSVFNTQ0VLNWh3VTZv?=
 =?utf-8?B?TC9JVm8wSm8vZGpsM0pMblJ0TGdvaE9NaDk1NjR1bU1UWTJYSTQ4emtBNGtt?=
 =?utf-8?B?K2FTaEtINkRqOE9zak5tdUE1c09uUGpOOHBjeVBEOTZVYnpmRnN3YTZ2MTBt?=
 =?utf-8?B?Y0toNVNnZFdselc3UnZSYTZFUURFVnpaSjZzUEVhbDR5R1FCajRqYjlyeGlh?=
 =?utf-8?B?RWdMejlwYjdUVnp2dm1lKzg5SGpZejJmSFEyS3RISUJqNUk4UHJBWkdYaEow?=
 =?utf-8?B?OXZZclZTNG5kL09ac1Q3bVBzZm5vUjUyNnEvNmFsVFlrYUFXdnE0YmpBaVoy?=
 =?utf-8?B?QXJEaytud1Y1NEpBUkswU3k1dVBLNVkxZU84eGpDRGZvdE1Ta2FMdDFURG1p?=
 =?utf-8?B?YkxMMkRCUHBOSnVTemhtYmJHcjl3RUFuVEJpNEQ5Yjl2aU0wMjBiOWMwSk9x?=
 =?utf-8?B?YlFPQ2hlZ0ZBM1Z2WThFSC9wQitYR3RrR2dIV244VGRBUkZUY2puTDZWeWhp?=
 =?utf-8?B?NlhxWW9sYWZ2anlOSVhnQno5R2hNdTJlT2l2V0xSOFduSDgwK0JqbVJxUkZG?=
 =?utf-8?B?QWp6b2pHNTBEZUttd0lVNjFpS2lJUGJ5cGYxdFV1RDJRbDJoVnhBd3FnQ2JF?=
 =?utf-8?B?Q2dzWFllYWV1aXhqNjVVSXUvMVhhL3gwOTZwSWZxSTBUYUdRZG1nWmxZdUxF?=
 =?utf-8?B?OE10bnpNM3AxU294aThpb2lTZXA3bjZOcUZvTWgyYWhYTXlNRGZBM0d6WFN5?=
 =?utf-8?B?RnJqay90QUNUSjJ4bUxHb1lxL1IvSW9lMmZ2M3R2S2VyOTg1NGNQOGZ4cVl3?=
 =?utf-8?B?Z25ENnBCMkF3bUYwQTBVdm5meGI3blBvb2pSUmVBN1ZscC9TYmlnV1VWaWNu?=
 =?utf-8?B?REZjMzhIdWZ4Q2Rpb2s4L1BEUTNTaWo2MlIvc1ZMb0JXakRLWW1odmp6NGRE?=
 =?utf-8?B?VEkyRW9xallqSU5OQ2JaTDBqK0hreG1VNEtHRnRWKzl5SFF1OXdSYlFGeGwy?=
 =?utf-8?B?Ujg4VmJjb0czZ0lINEFpYnhjUSthclh2a1ZPMUZLS0N1KytoSWl2ZlR4dzlk?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FhVazp2KXBC+Fs7d4Xpw6kYAlWhNaXzn5+ytRF9kxeBW2mEQzXpUBvIHiQEPiHmUGeW5J859aOQr3J3aRQyUd5odtLCyiO8bEKosW4kUGao6kpxHf/k/fSoDry+S9UekASye/p3cTxJoVdqB2OzrEkVHm3O6SlMUP77rVb1MZ0rPn8FDPvsEeDKtBR22D6tYgvaUC896B8zk2v+1LnT362GxSSgYtYTLANP9awfSl5cvBiwCgTMpHelVYxvz127KYnlnoF97VCxOT0V8Rr4ZzGC7cbdsS/IL9F+ITQ/2b5lAmMGOLZUtFN6Ca5yV4lkWL4ahZJntwnzc6HtDzBxpQMy7zM1+UTOQpIqZ28xPG6Mx+qKI4n8RThBThTxI2YqDLz7+acsO4pnTobFxctJNGftOxOlMs9D5LVmaX+isDW/jPjACqAWN2OH59nQGnQl54lMU6K8WUqKisXbACeJQo7GUgFO8PYvi2NSe00FymZpt1QgYbLNDGrlZxi9CKlwiP7ZlYPqph0P/XCRSzZD0FBSDjzjMHtke1QKBrYWSKFqlltR0GmJG4F9hDpnbEFrFSyy2BRzHPaYLBGjxJ0Esvah/4HsVTmjgo22WLoH8Elo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3b1e1f-8a1e-4c32-f9d0-08dc1b9ceb6c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 22:53:15.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PuzMFcxbK49FWomBXoQvFUGDsi65JIRsKgSe3Ho2YghYMfWJimYG2Y53AUJVfgXxrMyUCNS1fqnw3xayH6rqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220163
X-Proofpoint-GUID: QIRxbZQQAEdLxVx-2iD1j1mIi6_OU-KC
X-Proofpoint-ORIG-GUID: QIRxbZQQAEdLxVx-2iD1j1mIi6_OU-KC

On Mon, Jan 22, 2024 at 05:46:56PM -0500, Benjamin Coddington wrote:
> On 22 Jan 2024, at 17:44, samasth.norway.ananda@oracle.com wrote:
> 
> > On 1/22/24 2:41 PM, Benjamin Coddington wrote:
> >> On 22 Jan 2024, at 12:23, Samasth Norway Ananda wrote:
> >>
> >>> In the else block we are assigning the req->rq_xprt->timeout->to_retries
> >>> value to timeout.to_initval, whereas it should have been assigned to
> >>> timeout.to_retries instead.
> >>>
> >>> Fixes: 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
> >>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> >>> ---
> >>> Hi,
> >>>
> >>> I came across the patch 57331a59ac0d (“NFSv4.1: Use the nfs_client's rpc
> >>> timeouts for backchannel") which assigns value to same variable in the
> >>> else block.  Can I please get your input on the patch?
> >>
> >> Oh yes, this a good fix.  Usually the maintainers won't pick up a patch
> >> that's only sent to the list, rather the patch should be addressed to them
> >> directly and copied to the list.  Can you re-send this patch to:
> >>
> >> Trond Myklebust <trond.myklebust@hammerspace.com>,Anna Schumaker <anna@kernel.org>
> >>
> >> and copy linux-nfs@vger.kernel.org?  You can also add my:
> >>
> >> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> >
> > Sure, I will do that. Thanks for the review.
> 
> Can you also fixup the block above the hunk you posted?  Its backwards there too!

It's backwards in a different way.

And should you set to_maxval in both places as well?


-- 
Chuck Lever

