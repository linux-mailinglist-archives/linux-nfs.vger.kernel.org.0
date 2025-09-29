Return-Path: <linux-nfs+bounces-14768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F2BA95BD
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277611884EC1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F86270ED9;
	Mon, 29 Sep 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mipa5kF+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p1VOkIgq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC092080C0
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152786; cv=fail; b=JTODiS5f7RuTRYdM8krMCtqpjrNNIL4zvGZjtuBepPj0vaG2rQi4s8zlNVUyXq3gMZuoQ9/z+k20qj0ZNbZRKnt2TVfuMuRf0HSUsugemsNq4w0qh+PY0K+jgMK7vGbORrLSgKBONuOh+VIsSIrESblhNYILFRkkfuSq1hqsJR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152786; c=relaxed/simple;
	bh=L50rDu96TwFhNG/2hSzgkpwxtUxAJaKChocBPDnXXf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHvmz8Ang0kA3fVZ5uN8b7EV2sanh+0+PvQlojpvqoG+u+K9gZRH5dbNbrEfS75iej3T8pAYzKmVvnYVLofX5R2Qp4tRf9FlGy7dBJbKiO11TSb7hYkJwbuE9BN0ZQDvEkdkRvqsizkMZO8duZhb5CQYg037jpzHFCGkjlnymKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mipa5kF+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p1VOkIgq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TD9HZl008810;
	Mon, 29 Sep 2025 13:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cF8gHJ/bZ2ASwiZfBQTyKyQ90tIFxJFIWNPHeNJZzxc=; b=
	Mipa5kF+0XpFYfz2Hh5fu40kixWdsYFu8ky1iXDZ/L7Ph5lnmYDuJDZFx0as8nbD
	lS7DPa1Exe6WQN+4Iu30l8B3aZzKpSqtTz2CurYcKlT0MjFs/erv0+dhLtmOw1tv
	bLCU9P4jbmoMbtwXoUw7aoGyBOXYGcVPD2gGqdCD4nfQ+ZbJT2Cv4Xk3oNwCna+z
	8mauAEsOJFx7IDOJ2n3wkkr9rf0oECWrFZutvMG6wU/GO9l3Miiy51Qty2hdDu+1
	QmHS3JX8gfMYn/Ks53g5H+VcyGH34EiB8dRlHLZT2k1dELChrxkSd88FCNQEq/xn
	QPpH+uEl8B8MAwQeP0aPgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ftrc81r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:32:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TD3H4E027202;
	Mon, 29 Sep 2025 13:32:46 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c6eubu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 13:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZqPxJeyOFbVOiUNZCgoo5+EGrm1dMc0Cwl1uPYfngtfNLOb1ySi+98TigwDBCSwwjqKIuHNYptWM+FyTmW8pzu2PuSI1vsWYPVeU8jSqI2uPfG68ZcAb0NcPz4vxFPGO5soIP7yGcTP2d8kGs3BG9AUv5fOKAUsCLl9+Tt+KXO+7H0k2Rh9rfBKsxCKCa5O20815wgJrF2C4E8jjF6mMCvlpjsgD3S+JWRmskgx5M12+rxBRBbkx+HQ+GF/3sunR3uNRA4h3JT91WwZZmRi/KlLtmPFJfU/JYmci/iSP2Qh708rljUg8jdmTCGPCSI7TELrMbEnaYfDgz6Oycwbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF8gHJ/bZ2ASwiZfBQTyKyQ90tIFxJFIWNPHeNJZzxc=;
 b=LZHh7bSuGFc6q1QHfNXa5RrWamMAfXNqaOkB8vuf19tLrImFn4KyoI4tnat5eXDIQ2fd8K3iT1ubdlWa46GTyuJn9RtF2HYCtRlh0VxN1dS78Un3MHNf1x7AVAPNfeRjC3eRH+SWigyNwpdqL/6Dwbaewb6/kE46+v6knFgWFwLCSe/dUO3kTeBT77aUBcD8PNzHas3yCQ9ZMTBKy1AlhywXwoNgT0vBXIaFs+yeMEopNz6baVv60+lUu3rj99BZ9KU/nKpKTlrKrhNS9n3A658G1bCxq/KIHyLEzNuPn89a6XhW9zOqLnR0aqPhJ2Bi8S9LSJMD+sv0vgZykYZRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF8gHJ/bZ2ASwiZfBQTyKyQ90tIFxJFIWNPHeNJZzxc=;
 b=p1VOkIgqYbIxAVPulpDdFe8Q4W6OaLV9J1aowZAKnvyjVgZuiTSEjs3UzBZIP0tdLxJ0I3EuGHv9sHnvr6ofQyHZzwfykDGl/j/qixu7xLVH2U8iQcVteKJfD+T3MZSrXJQDrPTG+3ieVmHeSEB2w5RyT6ybFD//PzimKOt5W2Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6292.namprd10.prod.outlook.com (2603:10b6:510:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:32:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 13:32:42 +0000
Message-ID: <73257f96-8961-4667-8ae9-a1d0594bdecf@oracle.com>
Date: Mon, 29 Sep 2025 09:32:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Define actions for the new time_deleg FATTR4
 attributes
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, rtm@csail.mit.edu
References: <20250910152936.12198-1-cel@kernel.org>
 <ec936c41-0047-4998-9e94-1998780ad1ea@oracle.com>
 <9257ac997712ecd141608d4814697c8c4fbec7a7.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9257ac997712ecd141608d4814697c8c4fbec7a7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aea3920-07eb-4a1b-4bcc-08ddff5caab5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T0dId2tmaC9hR2tKY3VrTTRwOFdrR3QzbDE1aUZ6c0FSeFBBU0dNRnJKVHNZ?=
 =?utf-8?B?RTdTWDc1Z3BZOEcwd1RkUDBKWW8yRnV5d2UzRlBRNWR4a0lsaG1wb056UFVy?=
 =?utf-8?B?bjZiaVp5V2w1OUJZRmY0M0pYUnIyS0RXSy9tRkpjRGpaM1BBTEY1Z0lKaU1H?=
 =?utf-8?B?UVErZThBTHg4dE1JT1FwRit0ZzZPbjNZR01uNkExOGNVblkzT09TZ1BJaERz?=
 =?utf-8?B?VSsxY1V5b2pZYTRvZlBBSTBUWngyY3I2UldMc0JLdmR5UVB1L3A0d3VoTFNS?=
 =?utf-8?B?Z2VJUmNNWnV1ZXpOM2Jxdi95QUFFdTV6YjNsOHJOM204MVNQT3FqNm5oWStH?=
 =?utf-8?B?OTliOG1MNm8xSHlpbkRwTEwwNnNTY0dDYXRxS0JmR0pBQW43eHkxY0pPZTA5?=
 =?utf-8?B?RmhGV29PekpNRExjbWhNMndEM25GN3lHekJuVTdKZkNDYlhVWndoT1luZ3NK?=
 =?utf-8?B?dWpjWnZJamlGbW9ERDFGcDBnMU9lQTBVR01nc2JFOEo3Z3FlSXhZbXZzSWlL?=
 =?utf-8?B?bHdPbFRnNElIcUluUEprOUpJei9LTEFiM0gzRkd2Nis3UHIyZXFhdGUwYU1F?=
 =?utf-8?B?WDdjR3JZdVh6SlZ4c0tTMFdpUExNaVlPVjk2L1hFUEsvWFRyT3hxdXFhNzdK?=
 =?utf-8?B?QVBwOHM5V1gwNG5QR1NjTjJHNXNTOFMwZ09qU0FVdWE4WUJyWitlQ0ZGZGt1?=
 =?utf-8?B?UWl5c2lxbmQwNW5xUFZ2ZTk5K0JVOU5NaEo1Rmd4anRzdTBlOGhwKzZUQmxw?=
 =?utf-8?B?UVltSDlUZjRUNkVoSXNNQVRBUFgxTHluRmZKNDlMYmtiOVhUcW1QRXUrYk56?=
 =?utf-8?B?NU14N04yMW9sbHBXRStLZzdtQXVYdEM0UXdac04vYklBckxiQ001RW1mNHg0?=
 =?utf-8?B?eDJSMk1kWk56UmltM2w4aWlCN0FQRmY0bGVFQzVaU3FUSllqYWZPRkp6MlRa?=
 =?utf-8?B?RndiS0lUQ2lJVHAvdlJDZllUK29leVJnTHFmdlpmZ1BVR0lFTERXWTVGYSti?=
 =?utf-8?B?bHpnS3pta3JXbERLSmpHNnJwNHdSQldBQjFHd3MwcFpPVERMbm5HVnRMVWlQ?=
 =?utf-8?B?MzBPU052RUkxL1JmaUdIRG1zbmRuREhlY1ZmUjh4Y3E0KzFwQ01qbVQ5WWdO?=
 =?utf-8?B?VkFTUzdHcWh2U0NaMWFPM0Q3QVNGOHRJbnh6Y0I0c0lmN3pVQ2ZaZXFKaGJy?=
 =?utf-8?B?a2JTeG9yVFgwVzBKUCtkMGFwdnNuUmMrRHVobkozc3FWSzVONVM0Z1ZWdEZt?=
 =?utf-8?B?MXcyOXNYSWdwdGUrenpCMHIyNm5DWmhFM2pVVXNjS3ZtWUdpYjNLRitWZ000?=
 =?utf-8?B?bjhFZEV3cWZwaFV4aTBpSUlPa3dMTDFxQmZTUUpyMFlHckpUVHNVUTQyTlha?=
 =?utf-8?B?Tk5BRmIwUWJUNzBHc0M4S1FadDhZQks3MGVuRExGZ2FqVUpVeDVpR1J2VHow?=
 =?utf-8?B?U3RiOTk0NTRKK2txUHRhZ29aVkpBSGQxZGxBM2FUNGhNUWNvaFJxbUU0ZkN3?=
 =?utf-8?B?enluQnZuN2Y1V3ZqM1BqcThPdmJrcXFYMlN5R3d5aHRXNnhKSzdtODNTZ1pV?=
 =?utf-8?B?TWpBeTdVU1lpd1YyU3VjekhSUnlyOW8rZEd6WXQ4QnMweFpXS1l1MkVoc2Zu?=
 =?utf-8?B?K0JQL1V0R0hrV0lRTDVFV2EzQ0lSRzV4Z2pLM0VEblVnSWlZeFdrdUZlSFF4?=
 =?utf-8?B?TVgzbEkyNTloTk10Mit5bGJhZ0Y2a2RTQzhPWkN5THlCM2E3UFdXUFoydkFJ?=
 =?utf-8?B?SlNpL2dIZmhtMW5TSGs0WGZrYnZMU0piR3F4ZmNtWGJTeHN1OUFBaElvSFhW?=
 =?utf-8?B?b0pIMk5BU01TL3NTQTh4MDRaVjNvRk5SUTl3b0V1S2RicVZVZzNNOFVuYmFB?=
 =?utf-8?B?ZHpVcisvUm9HdzR0OVI0dlA4STZQekZ1dDYwVUowSXpGWUV1ZnY3U05iNFJ5?=
 =?utf-8?Q?cjraC485NSQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dzM1Tkc5c1RDbktUeUhRR0RuYVhEdm03TzFQWlZLZ3ZtR2xORHlMTU9qVEpH?=
 =?utf-8?B?Zmk0VUx1aHdZazc2cVVJWDViUUtxU0pEOVZsTTNmZENSUjRoN2ttNHVtdnlV?=
 =?utf-8?B?VjJZbXZhNzJ3MzZGaC9XRW4wMjhMbnlmUW9WVTVHMFVIeklXMm01cHlkZE04?=
 =?utf-8?B?MDBpQ1JuSllqNEFVZUZReEhsTkdkV0krNkEwNTNVNFFDZXRRRmZSYXFWcUFh?=
 =?utf-8?B?UWloS1Vma3pRVkJRVUVNMjJDVUd4eW1sREhSTjV6NHJmUUVyR21zWlJTZC9E?=
 =?utf-8?B?UkNwcitnVHZPeWExQWFIa1FEK05nakdhdkJva3Q2SUhCRVM3aVFTcmNPMVc4?=
 =?utf-8?B?MVlrck1uWUlUcHJxck9XY3hTUkZJNnhMNzcyL0JnbGtSeUhvSC94TFQxSVEy?=
 =?utf-8?B?TXUxMEpraVVmV0xQUCs0RVdCcVRneWFCc2l4ZjVwRzJWcmwrMzladFRtcWhL?=
 =?utf-8?B?c0ZPVjNLaFQ3b056UkFPVlBBcFJpeVdFeDNoMW4wS05IdnhsdHg1Q1d0emNB?=
 =?utf-8?B?MWxEWFlVL0o0bDRUdHhLSTlyanIrQWVmS1dPR0FOMThKM2xKQ3h0RFY4UTlB?=
 =?utf-8?B?YVNEYlV5bHQzR3NPS2wxYmtrQjRudWVnaHduK254S3dBRktMdkdURGlTcFMy?=
 =?utf-8?B?YjNLUjd6d2NsanVpK2xvMlNMZzFmbWRSaVZiWUkwUDA1bDIxNFFGSTFGSC9r?=
 =?utf-8?B?eXdWeDFhMHRJSGxnbFJZMHlVUHdXS3RHYkh6Q25WbXA1bnI4TTc3QUJ1TXQx?=
 =?utf-8?B?V0RlN3VRL1NjN0lvWUN2Z2pGazdLVHM4dnNyTDU0bHczbUVkVm9DOThiYXd2?=
 =?utf-8?B?RDYrejArblZqODh1eFFHL0xPQktINmdTUGxsZHBjUDc3cmRRZkVmOHo2YU5k?=
 =?utf-8?B?MlBDRXNOQ3FZQlBQN2pOSjJpNVBSNjhJUVVRcHlsRVI3RkI4L2ZCUHRLUUZ4?=
 =?utf-8?B?K1JzV3BwT1VGdXVaUGt1NHdzVC9YS3FEZVNtNWYxam0xNVJ4UGYrTHp4ZUM0?=
 =?utf-8?B?SjhhVlAvZ211OEhLVlp3OHJYd25yWHA5WTliU1djUUlVNWdzWHV0Wm1tV05V?=
 =?utf-8?B?L1dvMWRXbUNvTldESDdxcHI4QXd6cWZwK3I2VmRyOE5KSG1lcS96eXJXUHJB?=
 =?utf-8?B?Wnc1K01FRml1SEVxQUp4b1FJWEYvVCtLSzNOdFcxeXlVWkQzazdhN0RLSVRT?=
 =?utf-8?B?NDJDendJQzZmRzVDa2Rta2NwSDNlcDBaVGJQSDVoc1ZQRnMzTExiQ1h5TG1n?=
 =?utf-8?B?emFuVTF5UXd6YU5SZDFmdXZIdEJycHhRNnVZMVVvU211Q0pPWEREdUZ1Titn?=
 =?utf-8?B?SzhTM0ZrbU1FTG96QzB5QjlmYnBMalZkRGE4WTF5RXh0cWVMejUwNjh5YjNC?=
 =?utf-8?B?Vlowck56NlV4ejhxMmQvUy9iQk1JOTBTdkpjQVBXVyttOUFFV3pjS1piNkFR?=
 =?utf-8?B?WDdTd3ozNHZwa3lENGRmSi9ObUI3TEdrS01lcTJ3d1BRMVdFeXNBZk4vWDVr?=
 =?utf-8?B?MkV3aFYvMDlBVnFsYUZRMzIyVmlZSDVjOUp0K2x6b3J6L0xmSVl2ZzN0UzNO?=
 =?utf-8?B?M2lmME4xMVZXNzhDaEV4OGlZN0VwelE3ay9mYnNYREI1UjEyWE5TSzErTkFo?=
 =?utf-8?B?aFJKTWJTMlNXeTFjejM2VzVDcTVKeXNrdE92VWhKTWxaS1o3RlFmVXF2cEVB?=
 =?utf-8?B?OVVycUVVK3BPTDJVV3k2RmppbXdaT1hJNE4wWDZ5WG1CQktzSm1lci9DZ3I5?=
 =?utf-8?B?cTZSam5ONGxaNEd4QVdNNXczRTVDcEJTU3VJbUV6SS9Hb1E1TnI2Q2ppdDZ4?=
 =?utf-8?B?NlByYnZsV0IvbkYxU0VLSmJkQWtnTWUxMlNveDJSY2F3TDJ1NHVlZ2pTKzRm?=
 =?utf-8?B?WUlsSG1PVzBlZWNKY1M3SU8zWks4WG02MUt2UEwzZ2prYVFKWWQzTTZCZXA0?=
 =?utf-8?B?N3IrcFgzS2ZQc2FwUWpCWXVnbDlHWCsvbENrc3ZTVUVaVFdlTW85dmQyYVZK?=
 =?utf-8?B?Q2N0NElBUUVxbnNXV2dtSTcySXV4OXRrN2dpOWZhR2MwdUIrLzRURDBiUUlo?=
 =?utf-8?B?dUE0eS85am9kSWN2cmdvVVQwNERxZmtkUndVUVNRVzh6dUhZcy9nOHI0QklS?=
 =?utf-8?Q?8NyZFkFJPA5JkNqQkU3a/G35Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QioNSOaCNFk87/wAIwTkPw6UZIcZ/uY4brW6XyQJzAPNbhJxhRjyGVV1WiueNhBMZYPi8baGkHVrK7RRui7PJhdSLUYcQ5WHdxLArSyp0WnN/3CXJ9t9bDnK6yCp3nWnswMnmF4JYQT6naa8zRHN247+vxghNZAjeVqq1YNKtxFXmpG1LVIYFSXmdaMYvKO8RR1CpLO3uPndHi+A7tZeTV+bZoNJiP7DPtMfHkKUkEmBL22nt7OuV5xyUgD6y1zImU4kleRc+NNZOd7NnK9LqTmvWVX71m5rJ3DVpoZWhvc82p16vxlUEO4YyxKdeCqa6UemgqoEPHXYF1pvZUxVC3IaFOMV3C+nuvHDVDaakZxhOgIqqNLUkAvyalGNVV8MPxM56goR5JC/1MPhhx0GjTWRJedEKqmb40F0HZE9NBPxqrSXUB07Lcgc61RX3+4nc3t6gP3O67D+F43ZumnjH253I0CARleToSMHBvtPVqs3KZ+3P4nhVtZWTVKAlTvD8/39F49a/4BezHb6YNUmBugtV7lWJIaVF9DyFfbFSnKSFUmEtkOZJehVCwcW0jZ1+TKpKEX4Ik4Cfx7EHVPydqRZGfFc9SM7Znzdh1AGd5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aea3920-07eb-4a1b-4bcc-08ddff5caab5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:32:42.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwHAhbQ1XvSB1ctVlkF2zk5gZ3oPQatokwF0l2FVFHzcEo6pK/X7LWjHJWwXE2D5QT4QGpQdFXb9wMOnvvoKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290128
X-Proofpoint-GUID: xQsrvlwEyIGSFe6X03NjJtc8SCahMxQY
X-Authority-Analysis: v=2.4 cv=aqq/yCZV c=1 sm=1 tr=0 ts=68da8a7f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=zOeTWX34-71YL1WgF7gA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: xQsrvlwEyIGSFe6X03NjJtc8SCahMxQY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyNiBTYWx0ZWRfX/1jiG8GRc7PY
 8jGBneqMJ5zUd6mQ4H8/S03eiyQiLBUvQ9UXP6JR0CI0Zz0AvaaLYV8LepXcSFcG7dZ7kiANpjb
 Kw+ID9IphPfDwhKw2feJMFziJbbi2oSyOpRwnoSQhFrJQerj7QbOAkAS+YGHq2ljtPY6eZCRSTM
 lp6sFyOeq1eDJAmkWplG9wGVyRyWHvwaihSvtxe9D8b7InDTMGMJeJnwNpYNTI3ZwgJQdYuYXNa
 2wtsoCeMyj6KpOz/2GR4pjp9vHh6Oe89ZFUV85IKLU3Mqic7pM8fe5iEXgYK9PQB76pZkjojUNp
 jBak4TPdfxC29wVBD/hpVUnSjVnxDy533ESS8UVj1D4VXRin2PZYOjlnfZHbWMkOLn/xo4c9EA0
 tshxZqgOAkEed0Xzv/LCKPqVaHKEFQ==

On 9/29/25 6:29 AM, Jeff Layton wrote:
> On Mon, 2025-09-29 at 09:16 -0400, Chuck Lever wrote:
>> On 9/10/25 8:29 AM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> NFSv4 clients won't send legitimate GETATTR requests for these new
>>> attributes because they are intended to be used only with CB_GETATTR.
>>> But NFSD has to do something besides crashing if it ever sees such
>>> a request. The correct thing to do is ignore them.
>>>
>>> Reported-by: rtm@csail.mit.edu
>>> Closes: https://lore.kernel.org/linux-nfs/7819419cf0cb50d8130dc6b747765d2b8febc88a.camel@kernel.org/T/#t
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>  fs/nfsd/nfs4xdr.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> Compile-tested only.
>>>
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index c0a3c6a7c8bb..97e9e9afa80a 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -3560,6 +3560,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
>>>  
>>>  	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
>>>  	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
>>> +	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__noop,
>>> +	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__noop,
>>>  	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
>>>  };
>>>  
>>
>> I think we might need more here, because this introduces a bug.
>> (Not one that a working client will hit, though).
>>
>> nfsd4_encode_fattr4() needs to clear these two bits before processing
>> the bitmask. Otherwise the client will expect to see nfs4time objects in
>> the returned attribute list.
>>
> 
> Isn't that a problem for any attr that is set to
> nfsd4_encode_fattr4__noop ? The client is going to expect to see
> something in there for it.

I need to review. __noop might just mean "don't return anything"
rather than "not supported".


>> I'm not sure if I should remove TIME_DELEG_ACCESS and TIME_DELEG_MODIFY
>> from the "supported attributes" mask for forward GETATTR requests,
>> though; or should nfsd4_encode_fattr4() explicitly mask these two
>> out when it copies word 2 of the request_mask to the reply_mask?
>>
> 
> Why not both? IMO:
> 
> We shouldn't advertise them as supported attrs, since they weren't
> intended to be queryable via GETATTR. At the same time, we should deal
> properly with attempts to query them even though we said we don't
> support them (probably by just masking them off).

Do clients query SUPPORTED_ATTRS and look for these two bits to
know whether to expect attribute delegation?


> If we did that, then we could add a WARN_ON_ONCE() to
> nfsd4_encode_fattr4__noop() since it (theoretically) should never get
> called.


-- 
Chuck Lever

