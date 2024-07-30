Return-Path: <linux-nfs+bounces-5197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E76941FF5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 20:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7497A28212B
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971E1AA3CF;
	Tue, 30 Jul 2024 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpUy1hDc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c1TWMK6y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0241AA3C6
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2024 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365148; cv=fail; b=ixFDC+FqCE7kDbm3Q1Lqbbsen1GEeaTNDBlI92OHpljC82sbExwwJbBX3cM1WwH2ltuyGHsfgEHtAhCSnU0BEbxky7jj06PsamixSXUzdoUfMkIt5+rvVJEQubRKjTb+Jk+QPtjDlybT9OLGP35IHLRkAYM3qzS+qyOqLTKs+kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365148; c=relaxed/simple;
	bh=lFW9HobAOTFN4elPvatETv6yTzCJUHIvzzZSQj9KS9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EZgZzE1Ddk6Vi6oKuvtETR8a44cZ+C7GUO3Eu1uH8rKSX7uaQmASzRBJd5xOweacIlSeFslU8kNprINlxD91cAg+qNIU2b8uVmErnx1Zbuy16YQ2F8lxVj7c+pMM4ZsHPq1pJA57mW4mYv44SiAydHb++zGHcKS0DNY1+dF+h2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpUy1hDc; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c1TWMK6y reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFtUT4003770;
	Tue, 30 Jul 2024 18:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=ZeqH36F0IKwXb6o3F3yW/SSAdTdJcoYQCPNC2J7lgDE=; b=
	DpUy1hDcWO8+F548foPr6GgmSsWilWZEFvaBiW7hViFXYdKsRv3jYwcbExKYmoj/
	wbrmN2miYq4mndyfRBXDmFa1TaJiZARYfuOF07MNviQlgFwvXfy0uJD8OCVQdITB
	VegGJcVbXl8gEsQMh3cZ15C+BK+wPOdx6zz6hH871JIu/yRIIKMP/w0vu82lxWrK
	DIVoWlusjt+FZFJU/i5vaF8AEsiUHSncJMycgNGTIuAI0FUQPh4oHBCEfphpmEdp
	RS1OKwCKiOyX5rBFd4dTyv6szSMZ432IMt9gS+KzJ2WOAIPdUItPJaaVJuu7Wiu8
	8s2/2VJlbMe/bCrsDXUCnA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp1wuma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 18:45:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46UHXaUG002964;
	Tue, 30 Jul 2024 18:45:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn7kqyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 18:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8Aq7HEoGKCSUnscCpuHIjDvL3iEHQ4588XYWnwepOKXrX0CRIEpvGQVW88tb2QnkFyzOjhUUutpHFfAltAFdLsgHNT4vaw9tPsOv3bfanklM/zCoceIwwIq3VVPoXqpaSvvsMlEv1xU5pL9XeXrJ+fi/wsXsM+UH0rDg2XFrxR8KMLn+FPJllbMT4G6lWyvgi2SUp08CRhsSTJAM/1L0BNjiTlac4CEXnDu0CTW5gkEQK5KVsEKrxsayqojILUWo9M9OvSeYWRsSViXb+/ahJRxkUubrszBAjJ9FC7TiQTiuN5DE4lzVzgDIlxINdxHmRFD33+i+MUGn0YBWRNpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbjRJ6mG0xg5WVr/mssqFqDhR5Oy1EmVCnipagdCi+o=;
 b=pTaBbwQrZEUekXhBn21yPHY5v1RMHQc1urmGHrkHsS4x81VrmyGW/HwSxOhTDEJ0ozmUI7tcMtlMZw2FxUE1qQa5WCWvlUQXsZYim6liEKVGWVF7KEteutnFA28l6CN1Ifr3gLU+THzXQaoLCCc/FOuot0gsCaFYLw/vWdCnA1zia4gn/ExdmPUF3rnJXp5Mm0XF/Znwu/lOMms1wMqfH4b8WBT3CnjvfhzmBocyqB5yQRXspb6ZXdweiib4TGiswUTEHMZGPgrrGGBNrsGRn6HyX39w94kwbqo8ER3b1Pj9AxjyijzH/KvOvwF2i6NnEtZkt7mqAZUVqbJwIqhQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbjRJ6mG0xg5WVr/mssqFqDhR5Oy1EmVCnipagdCi+o=;
 b=c1TWMK6yKZtUGLUZVJE5NJIjRYLApNzBeHobXo3FRHIdg0dWuLj1khR1+WOVb7VN59MdV6ocOfCT5cv4PW453R4wVfMUav1NlWkNxuGBKUY92rWD8rv9JkvL5h7Bjq3Pc7rA3koeFjxgtPqcay+1U9aE9dNVwOi923m5atSwdrA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6202.namprd10.prod.outlook.com (2603:10b6:510:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 18:45:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 18:45:30 +0000
Date: Tue, 30 Jul 2024 14:45:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
Message-ID: <Zqk0x+8EY3qEkpe8@tissot.1015granger.net>
References: <20240728204104.519041-1-sagi@grimberg.me>
 <20240728204104.519041-3-sagi@grimberg.me>
 <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
 <6a78bd6b-b5c4-489c-a7dd-bd688fed8d94@grimberg.me>
 <cb6cf6834ca3383804b7bd994eeaf310cfbf8c78.camel@kernel.org>
 <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
 <8c17942a9ed617c90f3e99b8ef2fe69969c9c6b1.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c17942a9ed617c90f3e99b8ef2fe69969c9c6b1.camel@kernel.org>
X-ClientProxiedBy: CH5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: d895f18f-1a2c-4ebc-fbb8-08dcb0c7c984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?dI1s3FWsv3foU8cHw/6PlmNFVkRkV+p3Bdejs7E8vBXjXho0bFUTOQ7xV/?=
 =?iso-8859-1?Q?DuQMxJVC4G1FOT34S2muYPq8QQaPOrSRAM0mja0YzzS0h3nTOEmmsHH2LJ?=
 =?iso-8859-1?Q?KS3SNuUsCl17igLpu0HpTz5/Ykyewui7LTap8p8NU3Q7JMk57Pu0/DFuJ0?=
 =?iso-8859-1?Q?AmSFxeEMvv7jh9McExmIFuYkR1xvFvzWle3F1TO2igXZUtm4/zREOzM5kX?=
 =?iso-8859-1?Q?WkvNVCkX0asMPeDTZvpE/bdJS1Mc/lGC9AHlZkVwzm6ImV6nLcRv82WpCi?=
 =?iso-8859-1?Q?dFa2aHn3ZfoAm3sYOtmHh2L2YKH0NSQhONt1B7Ap5h8BebhoBifQzDCd8d?=
 =?iso-8859-1?Q?pdiSfFcTVfcCk219uD7yx/tw+/I97SLqmbt025zTEASpCc6wgxTnLg0NsV?=
 =?iso-8859-1?Q?2NoZSX4CCNzAInDYQZyVYpKifgEizDBxaMGP1WPlBvgMbhZ6Yu6jeUxwFl?=
 =?iso-8859-1?Q?qUmhxbQ666yOEd+l5fJnZkuzqeB0UohqeLDcLFFE5FZ7nRtypReQteRR/5?=
 =?iso-8859-1?Q?x9qGVSXAx4fF72TusGSKjQoYqmTnGCDWJ4uEpfvK+6cZxVnbdlTf9cZFDH?=
 =?iso-8859-1?Q?BhIkSo3EAgVQM63ajrQpZAfrMcnANkzE4CUnD1uxVb4V1ecey9g3PqMhuj?=
 =?iso-8859-1?Q?0h16tJXlQPspP0TMPax2uGMXI0YUQ4/yCK3Md2PbZoks7TyUjLtgNGbIPL?=
 =?iso-8859-1?Q?n9KUjdXG+mmTGyp4V59dXOnAily/W1If5+WioQcw/YKM4fUQJXKtOX+hkf?=
 =?iso-8859-1?Q?zjd9lObZcXw7tcIqTAZhLk+MPodJCcrdn/1qyD+lsg8O1aCJS/x7chCQsI?=
 =?iso-8859-1?Q?C/yoq8/VkB/DaEA1u7b2WeyrJJCuZBktrFGqfWaCAClMSTu1uZGy4gHIe6?=
 =?iso-8859-1?Q?1FeZ7bSbtshHJOTVvtGR6T5vUDtrTp9gMYY78O1xqbYeBuJJUNCzr0qpwd?=
 =?iso-8859-1?Q?4nc+FZyLIpxiTAeRH7jS8h1iz9wBg7+u6v+g/kiM7lTtJ1ONKtQV11P9am?=
 =?iso-8859-1?Q?Rta4Tm9hA8mjMMvRgg50JyuI7y+JpcrhVBimXODNsc4PoQdYb6GRockkN6?=
 =?iso-8859-1?Q?rhD10Oe8d4vg3opqeO4M12iPSMT319+Zm2Avr2PJ0RcKhc0q9KzzXu3ycZ?=
 =?iso-8859-1?Q?/ZzrpXBuQjHfRzq2JwXl0u1FLJFI1WP1/fQQ/OpAxohRby5IHxYr2W3x/7?=
 =?iso-8859-1?Q?QXnglZsdvtOfQ4shpHg7BxRoMoDbpEIOIrzm6IeITW2RbeLXFYOjQ2NdQP?=
 =?iso-8859-1?Q?U+haobZPoS/PyBdO2fHBFJYInUZG7oWav1qSJfi/qNFiWa6A2EVZQbzmSL?=
 =?iso-8859-1?Q?EGyttxnwU4Z9F+H2kvCMz3TF8BXCglCsPgZtFAxUJj9c3da4/hm6XL8N+Q?=
 =?iso-8859-1?Q?L4rKYmnDgLKXvyhYQGpgYTZ8XmAQE6cQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?9lK5mZVleBQ2wP6M8zMRmA9T8bPOaY/BcNi8HI6fk/Bm+X2Cm2NZhDvakb?=
 =?iso-8859-1?Q?exDrkslBQheJswa7JE0DIJeQJN52qhpWFIrJjo4Lh+DYpE5muowxe2jZS1?=
 =?iso-8859-1?Q?/u2lrGpIr3fhJEouisz9JLjI4KfqBr/gGnqQ+kIrjqqr/FG2seK+tlD6YO?=
 =?iso-8859-1?Q?93qynRkjxshvDXzimmGswKIj9T5Izy85oMy873lN65brLCbpdNAFyv8Kxy?=
 =?iso-8859-1?Q?TbQbOn8wcNHV1IFch/bIeF3lm/UYopp3SM4UHx0t0UVyHnj+d5ZVrigVKL?=
 =?iso-8859-1?Q?fy/QKyN6e++99M2WpIh+sKPIqioIcFuqfRJHbIry5V+eBoJnJwmkriOKFO?=
 =?iso-8859-1?Q?WAe2iFVBjAYAY4QU110mNBlHvUNSc9A7trIhpz+Vq6AXMQM/sZo9LlKCxu?=
 =?iso-8859-1?Q?pLAbJMCN3jtOw5iOob2XCo4ROCTOCc6JuoLlKKfON1HUCRGUeqC1VXdQ/a?=
 =?iso-8859-1?Q?UXtuLkI/5M76alj9QeW+BMamNiXSGssaxWYjsRoaKF6w4BaGh+UHkMY1aD?=
 =?iso-8859-1?Q?mZJY2OYNGdP/GM8xUMYpa5TV+EugGzjb6Xt6hIIZ5TLt39H8NMZ/1z79cj?=
 =?iso-8859-1?Q?UYHYwlP9ZQBXzHcMVQ8TFcxjBqbQ1i6ih8VmU94H00PtaLD+ri/0vDVBOf?=
 =?iso-8859-1?Q?tz5GQJNt+Amm9knYHqOKsS5g3TZp0YfYQT8qKVjbD2xOsPFLumemVqVKIX?=
 =?iso-8859-1?Q?72gH53dUIIQ5pmsI3Zo7hXWxI5/W24DI0K4AWGHl6peOxEC6hpuj7mG/nW?=
 =?iso-8859-1?Q?mVLCbHYlUy4O1SPlUOGejQIws4yl40+N0jPpInaI68rO4QQMYhuy/KWzuQ?=
 =?iso-8859-1?Q?FjOb1NSQO8PyKrhPh2eN2zWE5BgI0sUzGsMQ5V4UDWw9H6yzCGZyddCBqV?=
 =?iso-8859-1?Q?ka4asEKaUzLMNRrowIyd2znEsd+ubRXm+lY3uRaf0Z8nton2CLzxoQd7u1?=
 =?iso-8859-1?Q?dU52NvxQa2UflhF2KZC1IH25CSUR4IuVL7jnf5/8qywBiDqQ15ohFBG14H?=
 =?iso-8859-1?Q?xfckkCrDDwcXp/NXWpNnznblQ4c7unhlEUwmNya3PidfdA0ohdcQ/BKe8T?=
 =?iso-8859-1?Q?VBE9XrYwIdAJI0Vw+D2ZvTbByntsI8WBaktiBS4YjfwAx70DiRGPBdtoN+?=
 =?iso-8859-1?Q?rg3pzbNDxAttNyYUV7T+dFFSTZ+RB5woiWghvjz0c/h9L5J402YLi6aM4U?=
 =?iso-8859-1?Q?PCBp7JaQzpow1/bGTGacTrwjA7CzZeTzvk/KNhzWpL+Ey6TASJXlGYfyRL?=
 =?iso-8859-1?Q?TXDDXtJVps7O+Z2xASAR/ybBrhSrS8yRB8Tw5SuLRdkpSMk+tis1jSlj5t?=
 =?iso-8859-1?Q?d3lboguB/CPwjEQ3SAZ6YGlubMpnCIePUOFBc7hnyM0WbBLklOW9iKLh7A?=
 =?iso-8859-1?Q?USu7ubPAI50xX/k4qlng1oIudut+CfEsBXsYHU+moW13MKmBZeeSe6CmvD?=
 =?iso-8859-1?Q?smenlaYf0qMCpdxIDXxYdSzVza3uFeYSi6oIHnyZRLoYPw6T236PUjbiKI?=
 =?iso-8859-1?Q?WlDeww2i/E1DrJBkof7i27eY378Kk5H9iNK2yeHiGctQssjy6PVnTHl0gg?=
 =?iso-8859-1?Q?QcKnZAWB82Wvii31GfqeYZ82R2Ig+nIvlMEMJv/s7u/uoMblIxu92acZRK?=
 =?iso-8859-1?Q?nB/CC0mnEQqsNQWVMHxCq8IDE5RjsqEFJ1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ozivmakFWXNrlEV5aYW5fHP9JiU98DfqC0d5dnZ4qK0jYd24i5Ey6b4l5VS/zvH+3TwsD7rZeA79GV38yjd1NX+twbEcE4fI1P3ARlxGn3l4oSpzfqe4kLmnvobHg2kTaIJjXe9lx/A0E9oCLEzBEUaYW26Fu4nL9zkWWmAZH9Un+ns99vhpROlzGFhSHpsbw8UHzoZiXM0rKO28eKgDrOT2Y0GoOgbJsr8pSCcKgenoG0pm6IGLZcmc7yQjjHcCTGMuwOQ++I7eJD5iBzj7ZA0dGdmK5d8TMTKyFoSihSHHuoV59t5c0YgpvaNIGXeDzCIqlwNY9vv7mMgE0YREeW1XAg2yRcpvQyFdZ26BKb67Ij3sSP7O0dwTeQJ1WJrGeEbdY15wtVd+g4gbrGxt/zrmKCshsj56cnNQ4Ov6IlGbAwYETrm4C7PZD2Gy95olrbid5A/rTzM8Y2cCf8caAe4D8AWfNkvrgXbNLFnp+tmF8PRUTXLRxwFpJjKRBc1HezPrR88C8LbrPQuvkQee2jh4S9jEEUZ4lFZKGVzyLiSX8YyJm//ZTNnwDzxIcZFsw6plxFDSmKSot3uRafyqbrgiEapUmCIOtSzjldlW3tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d895f18f-1a2c-4ebc-fbb8-08dcb0c7c984
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:45:30.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWOokDnicMHBSs25MHpUJ2hlCjVZt8IL6DzWEPnkaUIZgfoohFupzLOK3A0o+GHb5EACfc+JYurqo+UmxRClGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_15,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407300129
X-Proofpoint-ORIG-GUID: qZwPgSVoL6WS6wgCXIcQ-j37PteijJ7n
X-Proofpoint-GUID: qZwPgSVoL6WS6wgCXIcQ-j37PteijJ7n

On Mon, Jul 29, 2024 at 10:12:46AM -0400, Jeff Layton wrote:
> On Mon, 2024-07-29 at 16:39 +0300, Sagi Grimberg wrote:
> > 
> > 
> > 
> > On 29/07/2024 16:10, Jeff Layton wrote:
> > > On Mon, 2024-07-29 at 15:58 +0300, Sagi Grimberg wrote:
> > > > 
> > > > 
> > > > On 29/07/2024 15:10, Jeff Layton wrote:
> > > > > On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
> > > > > > In order to support write delegations with O_WRONLY opens, we
> > > > > > need to
> > > > > > allow the clients to read using the write delegation stateid
> > > > > > (Per
> > > > > > RFC
> > > > > > 8881 section 9.1.2. Use of the Stateid and Locking).
> > > > > > 
> > > > > > Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open
> > > > > > request,
> > > > > > and
> > > > > > in case the share access flag does not set
> > > > > > NFS4_SHARE_ACCESS_READ
> > > > > > as
> > > > > > well, we'll open the file locally with O_RDWR in order to
> > > > > > allow
> > > > > > the
> > > > > > client to use the write delegation stateid when issuing a
> > > > > > read in
> > > > > > case
> > > > > > it may choose to.
> > > > > > 
> > > > > > Plus, find_rw_file singular call-site is now removed, remove
> > > > > > it
> > > > > > altogether.
> > > > > > 
> > > > > > Note: reads using special stateids that conflict with pending
> > > > > > write
> > > > > > delegations are undetected, and will be covered in a follow
> > > > > > on
> > > > > > patch.
> > > > > > 
> > > > > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > > > > ---
> > > > > >    fs/nfsd/nfs4proc.c  | 18 +++++++++++++++++-
> > > > > >    fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++-------------
> > > > > > -----
> > > > > > ----
> > > > > >    fs/nfsd/xdr4.h      |  2 ++
> > > > > >    3 files changed, 39 insertions(+), 23 deletions(-)
> > > > > > 
> > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > index 7b70309ad8fb..041bcc3ab5d7 100644
> > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp,
> > > > > > struct
> > > > > > nfsd4_compound_state *cstate,
> > > > > >    	/* check stateid */
> > > > > >    	status = nfs4_preprocess_stateid_op(rqstp, cstate,
> > > > > > &cstate-
> > > > > > > current_fh,
> > > > > >    					&read->rd_stateid,
> > > > > > RD_STATE,
> > > > > > -					&read->rd_nf, NULL);
> > > > > > +					&read->rd_nf, &read-
> > > > > > > rd_wd_stid);
> > > > > >    
> > > > > > +	/*
> > > > > > +	 * rd_wd_stid is needed for nfsd4_encode_read to
> > > > > > allow
> > > > > > write
> > > > > > +	 * delegation stateid used for read. Its refcount is
> > > > > > decremented
> > > > > > +	 * by nfsd4_read_release when read is done.
> > > > > > +	 */
> > > > > > +	if (!status) {
> > > > > > +		if (read->rd_wd_stid &&
> > > > > > +		    (read->rd_wd_stid->sc_type !=
> > > > > > SC_TYPE_DELEG
> > > > > > > > 
> > > > > > +		     delegstateid(read->rd_wd_stid)->dl_type
> > > > > > !=
> > > > > > +					NFS4_OPEN_DELEGATE_W
> > > > > > RITE
> > > > > > )) {
> > > > > > +			nfs4_put_stid(read->rd_wd_stid);
> > > > > > +			read->rd_wd_stid = NULL;
> > > > > > +		}
> > > > > > +	}
> > > > > >    	read->rd_rqstp = rqstp;
> > > > > >    	read->rd_fhp = &cstate->current_fh;
> > > > > >    	return status;
> > > > > > @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp,
> > > > > > struct
> > > > > > nfsd4_compound_state *cstate,
> > > > > >    static void
> > > > > >    nfsd4_read_release(union nfsd4_op_u *u)
> > > > > >    {
> > > > > > +	if (u->read.rd_wd_stid)
> > > > > > +		nfs4_put_stid(u->read.rd_wd_stid);
> > > > > >    	if (u->read.rd_nf)
> > > > > >    		nfsd_file_put(u->read.rd_nf);
> > > > > >    	trace_nfsd_read_done(u->read.rd_rqstp, u-
> > > > > > >read.rd_fhp,
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index 0645fccbf122..538b6e1127a2 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
> > > > > >    	return ret;
> > > > > >    }
> > > > > >    
> > > > > > -static struct nfsd_file *
> > > > > > -find_rw_file(struct nfs4_file *f)
> > > > > > -{
> > > > > > -	struct nfsd_file *ret;
> > > > > > -
> > > > > > -	spin_lock(&f->fi_lock);
> > > > > > -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
> > > > > > -	spin_unlock(&f->fi_lock);
> > > > > > -
> > > > > > -	return ret;
> > > > > > -}
> > > > > > -
> > > > > >    struct nfsd_file *
> > > > > >    find_any_file(struct nfs4_file *f)
> > > > > >    {
> > > > > > @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open
> > > > > > *open,
> > > > > > struct nfs4_ol_stateid *stp,
> > > > > >    	 *  "An OPEN_DELEGATE_WRITE delegation allows the
> > > > > > client
> > > > > > to
> > > > > > handle,
> > > > > >    	 *   on its own, all opens."
> > > > > >    	 *
> > > > > > -	 * Furthermore the client can use a write delegation
> > > > > > for
> > > > > > most READ
> > > > > > -	 * operations as well, so we require a O_RDWR file
> > > > > > here.
> > > > > > -	 *
> > > > > > -	 * Offer a write delegation in the case of a BOTH
> > > > > > open,
> > > > > > and
> > > > > > ensure
> > > > > > -	 * we get the O_RDWR descriptor.
> > > > > > +	 * Offer a write delegation for WRITE or BOTH access
> > > > > >    	 */
> > > > > > -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH)
> > > > > > ==
> > > > > > NFS4_SHARE_ACCESS_BOTH) {
> > > > > > -		nf = find_rw_file(fp);
> > > > > > +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
> > > > > > {
> > > > > >    		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> > > > > > +		nf = find_writeable_file(fp);
> > > > > >    	}
> > > > > >    
> > > > > >    	/*
> > > > > > @@ -5934,8 +5918,8 @@ static void
> > > > > > nfsd4_open_deleg_none_ext(struct
> > > > > > nfsd4_open *open, int status)
> > > > > >     * open or lock state.
> > > > > >     */
> > > > > >    static void
> > > > > > -nfs4_open_delegation(struct nfsd4_open *open, struct
> > > > > > nfs4_ol_stateid
> > > > > > *stp,
> > > > > > -		     struct svc_fh *currentfh)
> > > > > > +nfs4_open_delegation(struct svc_rqst *rqstp, struct
> > > > > > nfsd4_open
> > > > > > *open,
> > > > > > +		struct nfs4_ol_stateid *stp, struct svc_fh
> > > > > > *currentfh)
> > > > > >    {
> > > > > >    	struct nfs4_delegation *dp;
> > > > > >    	struct nfs4_openowner *oo = openowner(stp-
> > > > > > > st_stateowner);
> > > > > > @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open
> > > > > > *open,
> > > > > > struct nfs4_ol_stateid *stp,
> > > > > >    		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> > > > > >    		dp->dl_cb_fattr.ncf_initial_cinfo =
> > > > > >    			nfsd4_change_attribute(&stat,
> > > > > > d_inode(currentfh->fh_dentry));
> > > > > > +		if ((open->op_share_access &
> > > > > > NFS4_SHARE_ACCESS_BOTH)
> > > > > > != NFS4_SHARE_ACCESS_BOTH) {
> > > > > > +			struct nfsd_file *nf = NULL;
> > > > > > +
> > > > > > +			/* make sure the file is opened
> > > > > > locally
> > > > > > for
> > > > > > O_RDWR */
> > > > > > +			status =
> > > > > > nfsd_file_acquire_opened(rqstp,
> > > > > > currentfh,
> > > > > > +				nfs4_access_to_access(NFS4_S
> > > > > > HARE
> > > > > > _ACC
> > > > > > ESS_BOTH),
> > > > > > +				open->op_filp, &nf);
> > > > > > +			if (status) {
> > > > > > +				nfs4_put_stid(&dp->dl_stid);
> > > > > > +				destroy_delegation(dp);
> > > > > > +				goto out_no_deleg;
> > > > > > +			}
> > > > > > +			stp->st_stid.sc_file->fi_fds[O_RDWR]
> > > > > > =
> > > > > > nf;
> > > > > I have a bit of a concern here. When we go to put access
> > > > > references
> > > > > to
> > > > > the fi_fds, that's done according to the st_access_bmap. Here
> > > > > though,
> > > > > you're adding an extra reference for the O_RDWR fd, but I don't
> > > > > see
> > > > > where you're calling set_access for that on the delegation
> > > > > stateid?
> > > > > Am
> > > > > I missing where that happens? Not doing that may lead to fd
> > > > > leaks
> > > > > if it
> > > > > was missed.
> > > > Ah, this is something that I did not fully understand...
> > > > However it looks like st_access_bmap is not something that is
> > > > accounted on the delegation stateid...
> > > > 
> > > > Can I simply set it on the open stateid (stp)?
> > > That would likely fix the leak, but I'm not sure that's the best
> > > approach. You have an NFS4_SHARE_ACCESS_WRITE-only stateid here,
> > > and
> > > that would turn it a NFS4_SHARE_ACCESS_BOTH one, wouldn't it?
> > > 
> > > It wouldn't surprise me if that might break a testcase or two.
> > 
> > Well, if the server handed out a write delegation, isn't it
> > effectively 
> > equivalent to
> > NFS4_SHARE_ACCESS_BOTH open?
> 
> For the delegation, yes, but you're proposing to change an open stateid
> that was explicitly requested to be ACCESS_WRITE into ACCESS_BOTH.
> 
> Given that you're doing this for a write delegation, that sort of
> implies that no other client has it open. Maybe it's OK in that case,
> but I think that if you do that then you'd need to convert the open
> stateid back into being ACCESS_WRITE when the delegation goes away.
> 
> Otherwise you wouldn't (for instance) be able to set a DENY_READ on the
> file after doing an O_WRONLY open on it.
> 
> Thinking about this a bit more though, I wonder if we ought to consider
> reworking the nfs4_file access altogether, especially in light of the
> recent delstid draft. Today, the open stateids hold all of the access
> refs, so if those go away while there is still an outstanding
> delegation, there's no guarantee we'll consider the file open at all
> anymore (AFAICS).
> 
> Eventually we want to implement delstid support, in which case we'll
> need to support the situation where we may give out a delegation with
> no open stateid. It might be better to rework things along those lines
> instead.

Dai tells me that I assumed incorrectly that each delegation
stateid is backed by its own open file descriptor on the server.

So, if it's the case that delegation stateids are just references to
the file descriptor backing the open stateid, maybe we need to
address that first. Once a write delegation stateid is always backed
by a local O_RDWR open, I think READ with a write delegation stateid
will fall out naturally.

And, what you said here above suggests there could be additional
benefits to that approach.


-- 
Chuck Lever

