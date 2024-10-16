Return-Path: <linux-nfs+bounces-7200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6A9A0C57
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153D91F249C9
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225BA207A11;
	Wed, 16 Oct 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aa+0gbjf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d13QfxDf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646B502BE;
	Wed, 16 Oct 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088184; cv=fail; b=g5L+Si/SvgSX1sW6afpb2GoX0PhBJ+53HI8enti7IEmDbBz/gPI3NubqEpCA+7aTOPSjt5B3VG6Q1yT/8Wu0+0RAX6LLxu2uoaPJmrqe2sHFsNQJYt1Pc50YtluG+sLuzD/JZy5jhvI0twWlp9t5gll4417sZIQEVN5GtQeyMt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088184; c=relaxed/simple;
	bh=TkGcIc0PvXlFG3vHUBzhlJCzufWG1e0JpPSRRtp58e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9Ec3ATxn9VpJpNFI9Kh0rZSWLW3v40GViI1N3wVhLDBLKgxRaSi2gKa413lZtlOAoC+q8YQjJ9NacuJWuOE1TPwfz0SqA1yg27h3tV+ZVMFIck9r5GFF6R/NkpW2sWB1Fl9udV0u/NivPap7Egt6Wfj3jfUF1YI+ssT0JKb7Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aa+0gbjf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d13QfxDf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GEBktX019862;
	Wed, 16 Oct 2024 14:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=GOq7mGXum/IQCuBJ9D
	JcNQBQs+lQHsSW8WsdgXmPRsU=; b=aa+0gbjfoCsGtaeNcLgPpgKpCXloWHIfeB
	W0EwPJFO+zyjLfH1OU40/SSaLuoURIL/kfL1/K73kxlX/QXRk+uWgrdgNK67+h/i
	UqcPq5BqL7al42OL8ZrWAfrMEN+HWAkMrbqjmIbGmh/PLQnGxm3LovLcOzv5xq1s
	bYQMEfWQ/CRSeNErkZPeOakU9wTKg+1cKTaJ6jblmMgIj5ozKe8oJs4myKu5UH8D
	1uuZ9GQMAiuNQeHksT2PJaMe1IHs+XsP/1Xe3Vjn4sejwwzr4qCLG2TYBddvYl72
	j2+gFoCeLMtb8TokAfc2uwjZQntpcsS10hckjg096s9UHZB2BPpw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2kynj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:16:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GCrC7H019863;
	Wed, 16 Oct 2024 14:16:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj8w17x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 14:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyflrBGvJ5JgFFtOuDmi+07Raclm8vVXR4Ke1Z32sH6yFRi5sO7odgalI9ay0x1vqCR2GzxMlO36nZvFCHAO+wveuaPz+LyJoSJvBh6+nz0hvv99tWdvUXPVVM+GcUftkmTHhA7sYUED5VH6ceQuhMSashy+sA3h4ua4LISUoTUuPHbq9Rqjua4oVTiOja2RUJIhWed6MyHz7Wt8ykaI9IewKrf8jC1til2QonEM2e7WgOANDfhxmr98dfLv6LAhIPnZF6+i4E/On4WlZAhxBoBaKu7f8jcGz94rzP2zFSVOlMNZHDCB6FuKlSvmZ0cQEA8w7CM2PY6+eoz7CxtPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOq7mGXum/IQCuBJ9DJcNQBQs+lQHsSW8WsdgXmPRsU=;
 b=MpkShnmTcfdhfEePeU9Ru8z4pA45Dd0Ib8GTWCiyWgPjQHHUkYf07E4SmKPW7IUrNzpgjWi/1rQ1XYEug4EZI7HXvAdf+gbaSRFiqudjxKG8AcdsdQtRWyynX6frCgx0OyUdsQL2oOwuUxWtZdlbZKj7vCFTAy7HP9LbywmYI4iDor+oTNzvuJuysTn+jvVt0JhOB96N9uAWPnoHsO4HyxiEcCTnYBOD4AqkCTZyElGq/Qy7xl9sZE4Yy192+Hq0r7+LRcJksTNpOzr+TdDc6gnNWcFGY24wdAyziKwxihP7fPkP6kYR8FS3gM/GH6I0wUj9js8frrMuFr3lrSKJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOq7mGXum/IQCuBJ9DJcNQBQs+lQHsSW8WsdgXmPRsU=;
 b=d13QfxDfhxhzwNPVhDdh1PO2i/koCITLGV3K5B4klpeTCZ6WWCALpf9aJkaX7msLISZjrrfRfaW6VUMQuF0L+00oV7w6SY/j8RA7oMDwHRM1QwFaIiUmcDA6h78PGmNJbxOB6Rq71TVJwnlyb8Q+k/C8QJ6V718xhTNhLNetgCc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 14:16:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:16:04 +0000
Date: Wed, 16 Oct 2024 10:16:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 2/5][next] nfsd: avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <Zw/KoQRfBl5Y9xyS@tissot.1015granger.net>
References: <cover.1729037131.git.gustavoars@kernel.org>
 <9a04f3f766b2f8438887f6a003cf288d0f366fb8.1729037131.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a04f3f766b2f8438887f6a003cf288d0f366fb8.1729037131.git.gustavoars@kernel.org>
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fd2092-cdbd-41fe-ba1d-08dceded1214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmBWH7orOHKIj0JLwnwlzcWjnQIKlYFphgue6I6b7XlwfJWVago6IxlSvihZ?=
 =?us-ascii?Q?FYnRFGNI1ZmwOAZVaewKqmvUcS3SOFo2hIMRCD4+fIcjQeUKytnfvk+r28Pw?=
 =?us-ascii?Q?YLtV0ig4JiimMmgXbxMvd1fpnm0uqeANfLn564uuauHdAoB00d3721wjS4qL?=
 =?us-ascii?Q?ReHl+mvhRzFhlDm846T+dYPNuaJR0u8fKcRjGSh6THxls5Eywq9TvTEemMmc?=
 =?us-ascii?Q?Aa5I83VZNNWlK8RvdAEV0JSsavG1WO5qh5qWHJaZShBCSZjeJIkQxI6DOWVj?=
 =?us-ascii?Q?rae95QrTbaUjPBvbHp8QAt+DEq1717t5RhiR87tqUVlNSHpvlIn8vlgExVvR?=
 =?us-ascii?Q?gRJveDDGVaew+givLl0qz6FwNml1Owj0eSiQ5rW/0K2rSjHJB5oRtsFZfKMV?=
 =?us-ascii?Q?pOogh+iOJCIabi6a09S0hGajlNZB/tRJ87zsqCOdedn6DUqhAKoO2LHre2Mw?=
 =?us-ascii?Q?TP3CF5TdEyoEsJAqyh9mlEHT4qKt5FYL42WL6OSstm2ndc1fe6qH0lefnMAC?=
 =?us-ascii?Q?LGmPbFUtGfqkdcCavnt8l4RnEARUW1DCKOsmdGGec9uPYE55PChhsCgqhava?=
 =?us-ascii?Q?pwOF41DZ5MF66VcOcpWuRzvn01A5hf7H+rcDAMvDw7FJzppUIdKi2cnL2w0K?=
 =?us-ascii?Q?aWLNO96RVhSNpo7JGEiswLO/dQjN5npHPcamp9O3rLSzrRN65IxVgepVdJq7?=
 =?us-ascii?Q?3joVa/n4QbQCGLe+a+5kScInbBziqHCM5BeuzeHue/ZVDIoxEy7aAaPju8Yc?=
 =?us-ascii?Q?wNB/bNWfuDfT0rPgrnZpIX28tlupCn9OgDfXImKsmb2rIDxvIhNYa1mpZCbv?=
 =?us-ascii?Q?xhCabNVYFe00OvTHnSb8VI3hxSJ3u7/2fL+6a/4jHcO8gBjp4VLymrKzsbqj?=
 =?us-ascii?Q?UqTmk83QmXmi0UeuQCPTLzB2etMqB9mpcBQxa3ezxPrYYxbp39kAF+QwCjWJ?=
 =?us-ascii?Q?qSqVLcevLkKsRUa+lOZjzZl974bBebIfLTcoxgxjy4e8ybmLfPbWLDqSmDIc?=
 =?us-ascii?Q?J14I0yDdV1c51RJNWrLYidj/pZ52bkXAP8m5j6vrOoMAhy2TVmVc4x8uhTNa?=
 =?us-ascii?Q?VeRjX0nHqwjboAPXv9Po1V17fx6Lp67Bc+1WEOqK5Y5L+37iASZMymjpD37U?=
 =?us-ascii?Q?LIzND9duvGY5vgnYFvdFZOB8eep80M3Lt/3/pDhU57vrzPQGzmiJx8WtInBG?=
 =?us-ascii?Q?rdKZ8iCKru/UySggoaPAR9kM94OAdSFkO/Nqi/dNrlhfzi3Ci7sFDtItoz//?=
 =?us-ascii?Q?w+ko8fZ6yjY1wkDE7qbo/C7v6+X7hMSIgxKzMa325A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OI6vSrfkaKZ1WKc8+eNAK1v+9LoFb+R/8obZCWR5BtY4WMDbsbTZNkbmrMa?=
 =?us-ascii?Q?NSIIYYmZ6s9TSbFrZlQkd/0zbUzI8D6yQ+84jlLT2bXUwRAO2IoZwdedP0/1?=
 =?us-ascii?Q?KWREr92HZ3nDGgYzZoakGdYxihsQdxG1+KRhjnqUIcr2Klniw4lwCRGxiKAb?=
 =?us-ascii?Q?RO7bEjYoOYAOGZRG9CFRz8wK0zCHMYvfXWOX+XimmSEhGEwQ6DALRCKOAEch?=
 =?us-ascii?Q?Hb8PyYHpkBkaxoZvQsvAx5YpoHjHOWAdY228Xb9a1l2Oa7Gvc/eOUHxQLpOy?=
 =?us-ascii?Q?YjCutyi8lLGvVnznZ24buRoaRWvkOr8IYR8OXR4HWkB9wc0BxoJYUJVKThOX?=
 =?us-ascii?Q?yRGE6G3Bl5/2tm8y/2OAPNMMHCi6LOCxSHEcG24IZv135XA0GHTNjWt6AD+D?=
 =?us-ascii?Q?55Uevcd6JGfsrRBjTqwdB8sur/K5WBbEGT435T5OJfNEevEBm2Z2ZjR2oCn5?=
 =?us-ascii?Q?/C5OgjmG7/8hUtNpqBvetVbrkU0hq7fjqQfWAnMNsncAPPUMLB6PfwNR5MWX?=
 =?us-ascii?Q?4idKBscmJhNDD9xeykHPpxBtLOyVggp58lewy2y8S5Yjs6j66rUMy+6tS0Jn?=
 =?us-ascii?Q?p3n2QxA1XH4qzXoReVxkkjHk2U1PtuyD66tmo/4rzG7MfbgqFzruVYgvFPYw?=
 =?us-ascii?Q?92nuWICyUQho3UWX1+gZxUCsqnpPUAl73XfN1FQQN1sb/mlWzVMAR/9Hqp1c?=
 =?us-ascii?Q?/z9yekhfaWkXDDeQWe6ijVEsbZX6yWRd7cq3ASs6DaeK7x8jMNVjXwqPf/cn?=
 =?us-ascii?Q?hDPsyEGuH9qm7qSOKIzoUq+PQfFzHIjOxKM1i2V+seML9tYyYh3wNOCO+bqe?=
 =?us-ascii?Q?/O2Z8WhUycBygk0yDlMNlKNaIbSq51EYcFGCuFiuYNxNUoJrZuoyIlcOUI84?=
 =?us-ascii?Q?InF6wNpnrKCpzB5p4Ni5LxZaxSY5ion4SRKxUk5ZMaQ9GfModesBr9iBgo3r?=
 =?us-ascii?Q?THLiW2y1ySttDZIcHR4QlbxREdFb/QgiX6oGb/+1kuwd63NPfKPBDw1RjDMU?=
 =?us-ascii?Q?R0AwRTSb0cjl+lrR/JdBkI5DaWa2b9tzKnYQLJ9ZpNwsQ7tQVk8E+j7KQdJC?=
 =?us-ascii?Q?+Rud2dcYltEwXi3rNBUO3e9oQfJaHGN4e1kMqnKhsCRLe23IX5YeLfkBc0lB?=
 =?us-ascii?Q?9zTpOBuCZXzT+Jt7BLLcJHKW5jz7tX7qoozaufECmeAFm+N+OnaGLqtS9x5g?=
 =?us-ascii?Q?mGP9X+gTlgXEbJ4N4GABtKpGuBBcqXgatlk82Y3LCB9n1bXcUFX31JGcv0oE?=
 =?us-ascii?Q?UVBvYkp5mE4qRNjTAbHfTgkgexGLUADBXllgrpgTfPVbECgy4dXkJDgYN0eW?=
 =?us-ascii?Q?RkMccylcwy3QvnSVsx0W3tAzx5qMh0pZZdahd5s9qLXAEcMh/oUgWHSQSbs0?=
 =?us-ascii?Q?3YdFx5AVi/ArGvw99N9xHPqQ9XukJkHVXyQcaAbiq8e4AfZdFWhDTZRisLBb?=
 =?us-ascii?Q?WOjUCizkpR7n0xIAwGhfCSMb5PHR8zDFW+7y6SmRY4p01ooyEHdKAbWxtfG8?=
 =?us-ascii?Q?oo+/NfadWHVtk7K1od/zXAm/5k6KPr6MijyrSFl/YGNRD5EqaSeSGDomqWeL?=
 =?us-ascii?Q?Mn1LPa8KBNRv/CcYp16sE+vliTLAYzD6iUDa5O3MpNMIVQFgRNuYAHBysPB8?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cmSFm62hGt6EZC65aXfGsIo1XddxBinPLF7CD+Ly+lKMQbK73OKE88NNFo8lGaeUDLuh1Io+L0TUi2ClrFA4IOUoqDwlgaQQU8gZYond1315+rLC2/WpwtdONwXH2DsZvYcDJ1VUWi/eIudyIlV5B4w94Dj2CdYSQXnKnJysIm7rtj6qDyF9eWOftH1qAZhfpNbDJ2XK3lvKoGNngFctT05enJkBmOuvm/xr+mHYxwyvnmIuBDCB0ul9WnXZct1jsuhkoH8bjdt/nldvVissj7Nc3ayIbni4n3QSkzIb/HkYwcQFtKwUvJkoR2x8z5tXWWyKUoBos+RyiMh87WHLLJfWP85sx/vS27y/SYmu7ab2w4nUfmbGnvecPdC/A+MIZrMsOEJlKowqsVxdZQpiBNZGuK6sMoslpkOI1sbb/CI0Kj7Fu0LezoHx5Le9jQvLirIJmO/hO97U+m6L9atR4EyXZjiXEP1w37/s+E7bM6iCtsRlwvRcY+4OW+cJX4PsHt6xs0Sbr+/FIc97EG1IjlGPqh6JwPg6+82muJgRk6F5hBPoTmV55fOq+lyCtGPmLSO82QFnZyMEGzcNqVIfC0TqUYAzVr7AVNNv1cIB30w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fd2092-cdbd-41fe-ba1d-08dceded1214
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:16:04.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLk9KGeHd2UsDO0/M5Vl77YNVsjjwcSrG9TT5X2RqPjN3CWLl3UtFkHUGEWNg4gjOHkHD1RI//D7ZuIW530yfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_12,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160089
X-Proofpoint-GUID: YraGywigtHNzlImFo0yZrVtaPvdlVAzk
X-Proofpoint-ORIG-GUID: YraGywigtHNzlImFo0yZrVtaPvdlVAzk

On Tue, Oct 15, 2024 at 06:29:31PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Address the following warnings by changing the type of the middle struct
> members in `struct nfsd_genl_rqstp`, which are currently causing trouble,
> from `struct sockaddr` to `struct sockaddr_legacy`. Note that the latter
> struct doesn't contain a flexible-array member.
> 
> fs/nfsd/nfsd.h:74:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/nfsd.h:75:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Also, update some related code, accordingly.
> 
> No binary differences are present after these changes.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/nfsd/nfsctl.c | 4 ++--
>  fs/nfsd/nfsd.h   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3adbc05ebaac..884bfdc7a255 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1599,9 +1599,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  			genl_rqstp.rq_stime = rqstp->rq_stime;
>  			genl_rqstp.rq_opcnt = 0;
>  			memcpy(&genl_rqstp.rq_daddr, svc_daddr(rqstp),
> -			       sizeof(struct sockaddr));
> +			       sizeof(struct sockaddr_legacy));
>  			memcpy(&genl_rqstp.rq_saddr, svc_addr(rqstp),
> -			       sizeof(struct sockaddr));
> +			       sizeof(struct sockaddr_legacy));
>  
>  #ifdef CONFIG_NFSD_V4
>  			if (rqstp->rq_vers == NFS4_VERSION &&
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 004415651295..44be32510595 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -71,8 +71,8 @@ struct readdir_cd {
>  #define NFSD_MAX_OPS_PER_COMPOUND	50
>  
>  struct nfsd_genl_rqstp {
> -	struct sockaddr		rq_daddr;
> -	struct sockaddr		rq_saddr;
> +	struct sockaddr_legacy	rq_daddr;
> +	struct sockaddr_legacy	rq_saddr;

I was hoping to find a struct definition that was simply a union of
sockaddr_in and sockaddr_in6, which we have in nfs-utils but I guess
not here in the kernel.

Can we use "struct sockaddr_storage" safely here? Then above,
replace the raw memcpy() with rpc_copy_addr() ?


>  	unsigned long		rq_flags;
>  	ktime_t			rq_stime;
>  	__be32			rq_xid;
> -- 
> 2.34.1
> 

-- 
Chuck Lever

