Return-Path: <linux-nfs+bounces-8223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA479D99FC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 15:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD625162C94
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A21D54FE;
	Tue, 26 Nov 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yrrl3lcl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VtMYMWuS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1017C7B1;
	Tue, 26 Nov 2024 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632826; cv=fail; b=ZwSybq5iUtgmA/Nzbd98+lM32iwkULgyKUWpduMs+9iqnK/pe7nSjdfl5wVd3+7ldzGQgWxRPinnz+1Ff2MzXqlLoNXN4MFMKM3C3/y7Tr24WEOdGdiVcLgKL+m8kuXlKffPMu76vCvOpPDlUZ0wpXOdPZMw46gzFm7TJ5UmU2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632826; c=relaxed/simple;
	bh=fIWcxXr4oXxB9r+YhWW7C1HRyF8l2oMfdp35k9/cvDU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gjTlAMOcYhD13YB1+S0gkKTTMpKyiwVMjFYDxTXIDmkDPbEoXb7yfer3yg5QjSm9xkGsxOwnhVszJitt9syHrzSydn49rLwUS50VH3CTawPZkET4JnRn8+KpfaZGEZl7MKTVZnML/VwaPwIvwtA/Lr4YVqQ8TGuoA9onG8MVnNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yrrl3lcl; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VtMYMWuS reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQDLSfG007239;
	Tue, 26 Nov 2024 14:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=vDvDnNTG+XKCX7zv
	Srp/aGbm8w3g0bKMQBu0guANr4M=; b=Yrrl3lcl6eI19q/0cOKgvLMLM3WBBZU4
	JKYfeTZkdyWqvQRsrKnWlx+oxwd1bpTmkw5xmWdK2Dv3ad+CX0AWcPk7FVUBKitz
	JM7HV8kjgwhvgqIyzjxX74MdZyabpceKuZ2raW4SC6b7BQ9mmEmeX+pAXJCkP2Xd
	4sKfJ4FCKLketgX8IATpqtkIG6W77hLTkGPSUjMgNqf14X+CPM584cN9khFkYBGY
	ZmylaSeRwmm2s8QLX66XL0JXb1vfgYwvzJ+Si6YizmcsX/rXn0XaxtVaKtV5S5bi
	qnpz32b38e/l/J5xySASGycK0g5zkk4iB9i+62XyHnYWLglt8IN1+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43385unn3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 14:53:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQDxYl5002602;
	Tue, 26 Nov 2024 14:53:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g98pky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 14:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS7Xe8kQgMmQVjm16qlUw1q6W+lv+dycSghTeC2lkQzMyfIU8euVH3dom7OFqiMvdLRXHgqQWmf1cJdWCB8PkrLXYHDm4wOGoshnN4wOHNAGr0O95dFjUll02z3LHTCX1peEr8YACQI69647FJCIMUsJEbtKBvxigKA11i6ucu0y8jRofYG2uatwRO8R4bmhacb/Ol5sOIIumwTT/qjPnLZAjT83jOqBM8hrVjV4317qzidb1I+31EVrRhorMB4hPOLSr8dK36HxQaLK5m9BgH4rLdiXX5QXlzRion7oWM8uKwzlqN9OF2rq0koXomaMWCFfar8czopWBAQReViyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEWnpCVluIxN4ixe6/f4tdlwsinJXl3JLW3ZfKWjadQ=;
 b=yZps+p6PkaHyHMFb95gNzCdaQekc/mM5ki6oxlCmsSG5DNuypk29cJGbF0YDHMBj7VRdr/BQMk52AIDqAHsWpms7PDj/Ls2cb5WBYaD6JFN66tidsbMPWsN2+Vnn2eASkw/OefM0GCMXyfWamoJrT82wVCAqelf8SBmZvLulGctg3chcUX96cPMEYKBEMmhBTHOFjIFrPHopbJkuerDDd5i8QFHTbc1eAML8pTGnquvlM4w+665zaxsOt0JgSAG6x7IwZg7bZZNYU9NppycqZe74sDb4J9h02kJtL8Cj8q3isIw0nPqnbFWi5o7A6rh/kyc9Z9zUQy9LTXhwVC9B/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEWnpCVluIxN4ixe6/f4tdlwsinJXl3JLW3ZfKWjadQ=;
 b=VtMYMWuSvgoqoFUzLyeVnTXBg7+PuEl8qrPki+WFlqppZ7JtLcxcGoxKEXMqoJAVoVR+Fb/3R9khipVFTsBYOBb5SkBDq73UNL0yYV0jxixmmHtWoljT/GFLD90AQir/tlQckcaqgE5l+67OT9oZFyBoIG7N0JETnxDOfEn56rk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7448.namprd10.prod.outlook.com (2603:10b6:208:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 14:53:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 14:53:34 +0000
Date: Tue, 26 Nov 2024 09:53:32 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD changes for v6.13
Message-ID: <Z0Xg7A1J/CkYiENR@tissot.1015granger.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:76::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 86100c9e-e931-43d3-1371-08dd0e2a1a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?n+7tgm4BSt7gP2XOO5At+VkhU7A65qi8MRabbZevG5xxlro7DgH/qDroAA?=
 =?iso-8859-1?Q?5YHbHy/vp2ZVXLdqA1PwzXTqvs1VlVUpT6gYU8/bYJMYbbUy+Sbwbj7KdW?=
 =?iso-8859-1?Q?yEFpItn8TVFu4umTirrAHUujEKMiDMQY7g4bL9rPGG7/f1J7VLGQAMmJfv?=
 =?iso-8859-1?Q?d1fWrXC1pDC6KpzpvI7KQzVV+wM+NEC3Nmc5ZHtQPnJA9c6HB2bd2sBWVe?=
 =?iso-8859-1?Q?Vw8BDCXeSi+6aqhCYySL1nkPBPjSrEhrGIiNaBmsN7NNMLc4/P6dUwk1oS?=
 =?iso-8859-1?Q?tcffzuk9lptRH5vMhFF6BIzFVFYeZnwev82HAHyVuCUqIpuqG+4f3bo0eR?=
 =?iso-8859-1?Q?hramora1ghONnlosIGN4JH6Q+DV7Pc9q8mPuw2llN9yRe18o+dJS+5FLws?=
 =?iso-8859-1?Q?mkj482Qk81KfG5MW5PDYEaMueyqFINbwYnuzA9HSqL7MrVPAVFgyi9dQYw?=
 =?iso-8859-1?Q?pFDvB1jqJocGN+PqM4GxaP93kmBGitWAEU2kTBU4AJALeeT3IvcYWGd2p1?=
 =?iso-8859-1?Q?0rbNdfINi4h5GeSz8FcGYEuY/aGI+QxES4Csg299Vt+LVKbazsFgd901MS?=
 =?iso-8859-1?Q?mz/pkj2xpR8NwSetgLnQWwimTI3/71p5AMc9EP7NrJYWe8IU0iUoHn5BB+?=
 =?iso-8859-1?Q?bJxIbmKLBIu+zlYILuJbE8w76DmAMx+DeQLGzGi4IOb4GFnnYPoINgoO2Z?=
 =?iso-8859-1?Q?PiIdZNaixTJ84Hde3PN/VeFvLKpNJ+ZjRlFjkaWtcEu9XA3AOmzg5jMrs7?=
 =?iso-8859-1?Q?agpKdHzwEhrAtRHOJ+NzUhpiRMz0vHXJ0Tt5MdJsKQBbK0fKoR4/H1nZbr?=
 =?iso-8859-1?Q?GPVnF+8FwtMCwOBOvZdx/Ehh7Hvc7lB4qwFWeT+gDHE7geTWjtMsBpmaWz?=
 =?iso-8859-1?Q?eTLlxrWmPK9/ZmK5zPsq/4oDR7exo6pQKgpRBxnSct2jwn6Kf3g3s++XtL?=
 =?iso-8859-1?Q?nG7ZcnqOXDXVtAsFX721GBBt1YnYAIUfuoxp6jlIevGIZo8GXSqFsfurvX?=
 =?iso-8859-1?Q?2KeCqTw4mRhA+pCQHicQai6Dx6hRMytdZmIs2PatntRAiNyCAoCW/Jv8xf?=
 =?iso-8859-1?Q?98GmRnu7aNVoulS/sVU2/ueGQgVvRUHkFkyj1R9/3QZJktxSJmMFoMnaCx?=
 =?iso-8859-1?Q?ino8BNtj1jnwaGibTIm7Rt4t32mPbKSfTpfnQmo7zsUTc06/KZys/IlTqR?=
 =?iso-8859-1?Q?m2gJ66YXENtpyGuoGkiogGpecK5D9w8ZiMivZjegx0QFj5Y7H/amV/5Aba?=
 =?iso-8859-1?Q?IoXGUHpDtxGzGYqkNu9wouyl9uINocPRLj5sWiAiMCYReAGNlLcP0azG13?=
 =?iso-8859-1?Q?QvB6mI39XvMnAIx7pmjcMzuzWj7jCTYechOt2PeidSwY8nf5vFcd3JQDGF?=
 =?iso-8859-1?Q?lKKKlHdSJcfgTyGCUwLg8WLXWJ1eIOI90HPAaXYFkB17d2qOqsG5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Bf5T1/RhfkCms9MM1/fGhnk9fXaeDuqdsTGtr7IeB9uGw0SJo9NNR8unN+?=
 =?iso-8859-1?Q?Prguvimz1m7S9YhYlxQt08/CbFSRz2BAZRvW/Kz0NXQ8we0v8NyoBACBr3?=
 =?iso-8859-1?Q?XoG8fiKo3gEZqGUXQk1NocWYKtxLUzAmp2dyAtdJbC6/YQ6UOYM3ZUqoq3?=
 =?iso-8859-1?Q?E5CZzxJ7rK5fsJaDlxCdOOp6TwKhAoaUTHJJiJj53BJ8hXlRvQob0SuhCj?=
 =?iso-8859-1?Q?S3T4V0GPEa2q6/LgumEw7qSkffayFpQOtPLK95gwCVig5qCwMXKqxM5jJ7?=
 =?iso-8859-1?Q?SVE2dBnel7Gv8MFjmOyjr59241zQccsXnbluzBuqKN3YqMhP6+WGalzwEo?=
 =?iso-8859-1?Q?Zpb9H6ms/ip9M60MioDrG7f+BIme9BpjOOA+QKwm4OebczXSaAkIIgpLw2?=
 =?iso-8859-1?Q?NskIlggV+nfgZStkw1MVViI3oA4katkhVg9iMmYLlsn8wyScqp0t6oHldk?=
 =?iso-8859-1?Q?bwxDtzxshRdm5JdjaFKSchUW1I8sQRukyFLBEDWb7jbdhYqyYX7Bbtp2jG?=
 =?iso-8859-1?Q?4yMqrMRkvODzSqsdPO0ND0qFuPgTtLlF90GcUe8tLF1FHivLeWaE+n0UR9?=
 =?iso-8859-1?Q?HLAxSxQk+hBqop1lIP3xXb1cx3+tESA1in/Tse5sPxztPsAkRhqKYT9y9g?=
 =?iso-8859-1?Q?8qn5c81DX9+HsWvujQ2BE0SP5DTgfK66ZZPn1lQBgjy69KAoWjTdRJ6LFp?=
 =?iso-8859-1?Q?5Pyl7xo4CKQbFBsmrI/411cehcJw/Msx+YSyvGrfJFX2OYIL4fGLV0s7wC?=
 =?iso-8859-1?Q?QLTTHhLGuYsXPYEYbGwp/Q7/K4QkYSHWXYCyvqx0/nUNNT5w4H6MtGDvs4?=
 =?iso-8859-1?Q?kp+AXpKXuhdmsvBg4IyDXn2edAj/ShfNGkjv9kB4KECI/MR3i2frxCArTR?=
 =?iso-8859-1?Q?eX9j3MqAXg5zd/Du7UOCn/rVirQIyQZRwWV1wEK/3a+XAcRhGYXuL0mwzc?=
 =?iso-8859-1?Q?/UaRPGD9zju2OVmKCWIA5CRRvr/+fgjnLT+53qtyDEltDZizfFlapOuqW4?=
 =?iso-8859-1?Q?rlux11U8IoOhTqviIM6hrUWSzISOXGJbi7SewA3axQQv3iLQ/QHhRQ9SBu?=
 =?iso-8859-1?Q?ajFwSkvdxl5FWBmIysn/tFT9giArY+gOF0OIAwr1qM205p5WSQfgPsG+hs?=
 =?iso-8859-1?Q?yw67tkc7usWeyuzhmp0fbhdRnCNru1DWodSrS+K91xQO4uZPajj11Qf8l/?=
 =?iso-8859-1?Q?YrwxSi55IcRhyMctOwuqtX8gVDQl8syKfkpGWT3qH9JVovrSjLsOs1bWF7?=
 =?iso-8859-1?Q?Z6lAIQhx/su+lc1Surp7nV/eX4lUi9JHOfnEp5gLz3AMyYCVg0t+QqeJE7?=
 =?iso-8859-1?Q?NnFkpeo3d6kGTK9K8XDomR7v1DXMn/36RPtspaiMKtduTzGkiaIcwgeL9M?=
 =?iso-8859-1?Q?Wi+Sv2WPGyEvgqgtVFxIamQov0CC7MRBMceq/m93qaymHjGTzsjSIlUvZl?=
 =?iso-8859-1?Q?mdXf8DB9CLQ0PcCwzOeEgmoZ0pPQAYafZsJ5JmfaW5+KLJ3wtrJojlhfas?=
 =?iso-8859-1?Q?aAjkfagpkpykqG1I2j/nkBMO27teObrgZWXpWDukWL14PYApgMt6iUHg6Z?=
 =?iso-8859-1?Q?W9q30m36jctfZPs/VLCwT5MBUKXKR6ljRzbgXN7XLPnHUH+/T9CItGDqhk?=
 =?iso-8859-1?Q?Q48rWnID++FzKcUmenrGGs+JkwSPdOZxiS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OnaVtgvJWBXIa7vtJ/vPCOiclntN9vPQ2iqaSYoWjHzRfVerjLbHuVbROgItEuGi9NbxFVrDFV8BcdKBhKmj9HxWoek+0QpA5gkJg+Xofd0NxcpDf7mksOdF22Y/SB5o1IxmolmVsqTJGjBK4zW8T+0RIwu5eOl3xsh5UCE6WcCtBvY4HVNpZYNu7onUWe6g3aBzPIvyV6ljvlJZVYTIFi2aS2fcjqREJTdZ1CNF/cKUtDHhdOSqwjhYQcu7pMl09fiHW/QalS2FY18+0gvE00dn/mXHhUMUm9zV42TxsFyAb3UcPTjW4SzRjzizw8MG8i+sCOPdjtQIAfxKlKDJD8kgPcnKpv5z3TpJPmnThJfmqdqQRRemXlPiDWuHdB8stKJUYHtzvft5W8urkamnqByMSWdp0/e96KJjp+hFx6+1v7AIIY7TMIGl/kmcGFe/Qb53Q1YZ5aZLK5xA+eOSqLb9tGqfTRT1Z1we9/RaexELa2TQDHrmehueplMDW+zr8gZBMaOdl1IdPAepj1jrJlcT4zv2bohWaUC/8n1A9q/fv94bdXdv6QTJgbHlkYPYK7E1/rWXT/j6gW0HSWSbNJA78LWytwWQgwiZnuqMX6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86100c9e-e931-43d3-1371-08dd0e2a1a26
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 14:53:34.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PL7NoT9Ps4IOIWSK5YlgoiFr74Q3RguSa0Wj7SH+2k0onLjHtpMxvOF6hwR4TuRu8dHbAMmxFZtVn4XK7TD0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_12,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260120
X-Proofpoint-GUID: TsHSUmc6SDZGG2iYqGkWCNmQN9OHI1CL
X-Proofpoint-ORIG-GUID: TsHSUmc6SDZGG2iYqGkWCNmQN9OHI1CL

Hi Linus -

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.13

for you to fetch changes up to 583772eec7b0096516a8ee8b1cc31401894f1e3a:

  nfsd: allow for up to 32 callback session slots (2024-11-18 20:23:13 -0500)

----------------------------------------------------------------
NFSD 6.13 Release Notes

Jeff Layton contributed a scalability improvement to NFSD's NFSv4
backchannel session implementation. This improvement is intended to
increase the rate at which NFSD can safely recall NFSv4 delegations
from clients, to avoid the need to revoke them. Revoking requires
a slow state recovery process.

A wide variety of bug fixes and other incremental improvements make
up the bulk of commits in this series. As always I am grateful to
the NFSD contributors, reviewers, testers, and bug reporters who
participated during this cycle.

----------------------------------------------------------------
Al Viro (1):
      nfsd: get rid of include ../internal.h

Chuck Lever (49):
      NFSD: Prevent a potential integer overflow
      svcrdma: Address an integer overflow
      NFSD: Remove unused function parameter
      xdrgen: Exit status should be zero on success
      xdrgen: Clean up type_specifier
      xdrgen: Rename "variable-length strings"
      xdrgen: Rename enum's declaration Jinja2 template
      xdrgen: Rename "enum yada" types as just "yada"
      xdrgen: Implement big-endian enums
      xdrgen: Refactor transformer arms
      xdrgen: Track constant values
      xdrgen: Keep track of on-the-wire data type widths
      xdrgen: XDR widths for enum types
      xdrgen: XDR width for fixed-length opaque
      xdrgen: XDR width for variable-length opaque
      xdrgen: XDR width for a string
      xdrgen: XDR width for fixed-length array
      xdrgen: XDR width for variable-length array
      xdrgen: XDR width for optional_data type
      xdrgen: XDR width for typedef
      xdrgen: XDR width for struct types
      xdrgen: XDR width for pointer types
      xdrgen: XDR width for union types
      xdrgen: Add generator code for XDR width macros
      xdrgen: emit maxsize macros
      xdrgen: Add a utility for extracting XDR from RFCs
      NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
      NFSD: Remove dead code in nfsd4_create_session()
      NFSD: Remove a never-true comparison
      NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
      NFSD: Remove unused results in nfsd4_encode_pathname4()
      NFSD: Remove unused values from nfsd4_encode_components_esc()
      NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
      lockd: Remove unused typedef
      lockd: Remove unnecessary memset()
      lockd: Remove some snippets of unfinished code
      lockd: Remove unused parameter to nlmsvc_testlock()
      lockd: Remove unneeded initialization of file_lock::c.flc_flags
      xdrgen: Remove tracepoint call site
      xdrgen: Remove check for "nfs_ok" in C templates
      xdrgen: Update the files included in client-side source code
      xdrgen: Remove program_stat_to_errno() call sites
      NFSD: Add a tracepoint to record canceled async COPY operations
      NFSD: Fix nfsd4_shutdown_copy()
      NFSD: Free async copy information in nfsd4_cb_offload_release()
      NFSD: Handle an NFS4ERR_DELAY response to CB_OFFLOAD
      NFSD: Block DESTROY_CLIENTID only when there are ongoing async COPY operations
      NFSD: Add a laundromat reaper for async copy state
      NFSD: Add nfsd4_copy time-to-live

Jeff Layton (8):
      nfsd: drop inode parameter from nfsd4_change_attribute()
      nfsd: drop the ncf_cb_bmap field
      nfsd: drop the nfsd4_fattr_args "size" field
      nfsd: have nfsd4_deleg_getattr_conflict pass back write deleg pointer
      nfsd: new tracepoint for after op_func in compound processing
      nfsd: remove nfsd4_session->se_bchannel
      nfsd: make nfsd4_session->se_flags a bool
      nfsd: allow for up to 32 callback session slots

Julia Lawall (1):
      nfsd: replace call_rcu by kfree_rcu for simple kmem_cache_free callback

Mike Snitzer (1):
      nfs_common: must not hold RCU while calling nfsd_file_put_local

NeilBrown (3):
      nfsd: refine and rename NFSD_MAY_LOCK
      nfsd: Don't fail OP_SETCLIENTID when there are too many clients.
      nfsd: make use of warning provided by refcount_t

Pali Rohár (3):
      lockd: Fix comment about NLMv3 backwards compatibility
      nfsd: Fill NFSv4.1 server implementation fields in OP_EXCHANGE_ID response
      nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT

Thorsten Blum (1):
      NFSD: Remove unnecessary posix_acl_entry pointer initialization

Yang Erkun (4):
      nfsd: make sure exp active before svc_export_show
      SUNRPC: make sure cache entry active before cache_show
      nfsd: release svc_expkey/svc_export with rcu_work
      nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur

Ye Bin (1):
      svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()

 MAINTAINERS                                                                                      |   1 +
 fs/lockd/clntxdr.c                                                                               |   5 ++-
 fs/lockd/svc4proc.c                                                                              |  20 +++------
 fs/lockd/svclock.c                                                                               |   2 +-
 fs/lockd/svcproc.c                                                                               |  15 +------
 fs/lockd/xdr4.c                                                                                  |   2 -
 fs/nfs_common/nfslocalio.c                                                                       |   8 ++--
 fs/nfsd/export.c                                                                                 |  57 ++++++++++++++++++++----
 fs/nfsd/export.h                                                                                 |   7 +--
 fs/nfsd/filecache.c                                                                              |  19 ++++----
 fs/nfsd/filecache.h                                                                              |   2 +-
 fs/nfsd/lockd.c                                                                                  |  13 +++++-
 fs/nfsd/nfs4acl.c                                                                                |   2 -
 fs/nfsd/nfs4callback.c                                                                           | 139 +++++++++++++++++++++++++++++++++++++++++++----------------
 fs/nfsd/nfs4proc.c                                                                               | 103 +++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfs4recover.c                                                                            |   3 +-
 fs/nfsd/nfs4state.c                                                                              | 127 +++++++++++++++++++++++++++++++++++-------------------
 fs/nfsd/nfs4xdr.c                                                                                |  73 ++++++++++++++++++-------------
 fs/nfsd/nfsfh.c                                                                                  |  41 ++++++++++--------
 fs/nfsd/nfsfh.h                                                                                  |   3 +-
 fs/nfsd/state.h                                                                                  |  40 +++++++++++------
 fs/nfsd/trace.h                                                                                  |  29 +++++++++++--
 fs/nfsd/vfs.c                                                                                    |  26 +++--------
 fs/nfsd/vfs.h                                                                                    |   6 +--
 fs/nfsd/xdr4.h                                                                                   |   8 ++++
 include/linux/lockd/lockd.h                                                                      |   6 +--
 include/linux/lockd/xdr.h                                                                        |   2 -
 include/linux/nfslocalio.h                                                                       |  18 ++++++--
 include/linux/sunrpc/xdr.h                                                                       |  21 +++++++++
 include/linux/sunrpc/xdrgen/_defs.h                                                              |   9 ++++
 net/sunrpc/cache.c                                                                               |   4 +-
 net/sunrpc/xprtrdma/svc_rdma.c                                                                   |  19 +++++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                                          |   8 +++-
 tools/net/sunrpc/extract.sh                                                                      |  11 +++++
 tools/net/sunrpc/xdrgen/README                                                                   |  17 ++++++++
 tools/net/sunrpc/xdrgen/generators/__init__.py                                                   |   4 ++
 tools/net/sunrpc/xdrgen/generators/enum.py                                                       |  30 ++++++++++---
 tools/net/sunrpc/xdrgen/generators/pointer.py                                                    |  26 ++++++++---
 tools/net/sunrpc/xdrgen/generators/struct.py                                                     |  26 ++++++++---
 tools/net/sunrpc/xdrgen/generators/typedef.py                                                    |  28 +++++++++---
 tools/net/sunrpc/xdrgen/generators/union.py                                                      |  52 +++++++++++++++++-----
 tools/net/sunrpc/xdrgen/grammars/xdr.lark                                                        |   6 ++-
 tools/net/sunrpc/xdrgen/subcmds/definitions.py                                                   |  24 +++++++++--
 tools/net/sunrpc/xdrgen/subcmds/source.py                                                        |   3 +-
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2                                    |   4 --
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2                                     |   4 ++
 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum.j2                                         |   2 +-
 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum_be.j2                                      |  14 ++++++
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close.j2                                     |   1 +
 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2                                  |   3 ++
 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum.j2                                         |   2 +-
 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum_be.j2                                      |  14 ++++++
 tools/net/sunrpc/xdrgen/templates/C/enum/maxsize/enum.j2                                         |   2 +
 tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/{variable_length_string.j2 => string.j2}     |   0
 tools/net/sunrpc/xdrgen/templates/C/pointer/definition/{variable_length_string.j2 => string.j2}  |   0
 tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/{variable_length_string.j2 => string.j2}     |   0
 tools/net/sunrpc/xdrgen/templates/C/pointer/maxsize/pointer.j2                                   |   3 ++
 tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2                                    |   4 --
 tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2                                         |   9 +++-
 tools/net/sunrpc/xdrgen/templates/C/struct/decoder/{variable_length_string.j2 => string.j2}      |   0
 tools/net/sunrpc/xdrgen/templates/C/struct/definition/{variable_length_string.j2 => string.j2}   |   0
 tools/net/sunrpc/xdrgen/templates/C/struct/encoder/{variable_length_string.j2 => string.j2}      |   0
 tools/net/sunrpc/xdrgen/templates/C/struct/maxsize/struct.j2                                     |   3 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/{variable_length_string.j2 => string.j2} |   0
 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/{variable_length_string.j2 => string.j2}     |   0
 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/{variable_length_string.j2 => string.j2}  |   0
 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/{variable_length_string.j2 => string.j2}     |   0
 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/basic.j2                                     |   3 ++
 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/fixed_length_opaque.j2                       |   2 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/string.j2                                    |   2 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_array.j2                     |   2 +
 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_opaque.j2                    |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2                                |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/decoder/{variable_length_string.j2 => string.j2}       |   0
 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2                                |   2 +
 tools/net/sunrpc/xdrgen/templates/C/union/maxsize/union.j2                                       |   3 ++
 tools/net/sunrpc/xdrgen/xdr_ast.py                                                               | 311 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
 tools/net/sunrpc/xdrgen/xdrgen                                                                   |   4 +-
 78 files changed, 1115 insertions(+), 348 deletions(-)
 create mode 100755 tools/net/sunrpc/extract.sh
 delete mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/close.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/decoder/enum_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/definition/close_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/encoder/enum_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/enum/maxsize/enum.j2
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/pointer/encoder/{variable_length_string.j2 => string.j2} (100%)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/pointer/maxsize/pointer.j2
 rename tools/net/sunrpc/xdrgen/templates/C/struct/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/struct/encoder/{variable_length_string.j2 => string.j2} (100%)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/struct/maxsize/struct.j2
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/definition/{variable_length_string.j2 => string.j2} (100%)
 rename tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/{variable_length_string.j2 => string.j2} (100%)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/basic.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/fixed_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/string.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_array.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/variable_length_opaque.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/decoder/case_spec_be.j2
 rename tools/net/sunrpc/xdrgen/templates/C/union/decoder/{variable_length_string.j2 => string.j2} (100%)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/case_spec_be.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/maxsize/union.j2

-- 
Chuck Lever

