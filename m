Return-Path: <linux-nfs+bounces-9939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC1A2C5C5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FC23A9265
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733723F267;
	Fri,  7 Feb 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DU7w5+Nm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U7bRo7Nz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865A23FC50
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939414; cv=fail; b=Q8M+Mm1Z/3f92r1P80iHWOhZirMpaLdSdRgKTYzI9dtkQ9cujpOouiktR4LUV0cRCEb2DgKvJQf1hpzq9V6kmX7zDYwGJ78Dw88c6i3HNzn8A8P8/m+2X2WlLZqtsf1l+Sa3+E6mxPGOWJwrOQ3qbv1Si3HflI+4uXXpzOHMEd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939414; c=relaxed/simple;
	bh=lO8D5JyeJj4E/0oYmZUfSCt14KABOMxY9zkkbypRSp8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LodA4FrRw+16D5yUjN2a7nfOQB1SUYpLLvyBcnDUCLNKYK1LjzOqidzofS0Rxt5hXrY/pl+gDoTANosaL2RdrEmMk+gffBbgIQDl/+GoA9vYc0zHCyAfpX68wJl3STo/tfM0OcaUDulXUH4J7ZA1dJsKgBlP5VHa5SbsznFfV2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DU7w5+Nm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U7bRo7Nz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517Egs6H000500;
	Fri, 7 Feb 2025 14:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oTKUAqlYahEPVklhSbnu5txGo/yQck0XgQGJ4MYN4AE=; b=
	DU7w5+NmFPvLVf2D3zyXzEU/0mAL9wUYyO2KnxviqHs7ONx+SzIj0/z3isoUy7kP
	nnH4dg2VnuueQwwsyRiST3BhiIt9f7scWRgf4EL1OuHskhDdLr+P5+oWa6rZJD1T
	xOqRMN9/VKY2o/5pXSiOr9OtZ1/oYh0q44ASrUYiyIX2WrHRTvbKV9eMCQ0C+D8e
	vFmTQ74F3VxRVA/ATKMRLXGaW2QhasP39usPlIUZsGtUDinct3PTeb3RfhXSHvqo
	m6UL8hsLUzbYAFLvaTRnCCWNykqmy0uhUUIxe1Yu81SSPdmhc9eyAFyNDn2DiS/d
	JDt3+X6LQ5xw7W8eT05oFg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4xrxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 14:43:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517DcINo020782;
	Fri, 7 Feb 2025 14:43:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ftb66e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 14:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RstTJDJ3I2Q7OTEp0hU+5DrOBhvyzryIZNzyrICOheOwuU1aTom+R4y4zzvUKQlKJeKGK2RGbS9AvzzoIlX7/q9FQNXvtDIoHWYsvhDbf68+Thvy4DPGYolGXqCMD4FtKjqHQZjgdB2jkYOqB8XQHwiaisF7HnDv6rU3jRKxFFlTN7dtLL6llF3eLbuIkafgZOPXUaEu7i+I8JYfOAnjgoecHM6ldVTND6gy7GTUnYIBpIegd0X0fuVuwIp0P82ENQV7EwD8pEGs8RHK9Yymafkrqyox5rqYY7qtXqLtsjxUjUhq1BaD7XFN8Ju6A5Ogi65o5tdL7lNS3znTRbCK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTKUAqlYahEPVklhSbnu5txGo/yQck0XgQGJ4MYN4AE=;
 b=ctsjRfxfVCAGDrFlGny01ohpl4+GW2Qshe+49xCwbgNyxV4Wm9P1iquBikz1VVcuHLnJWrCe3gyR+/iR/vfDK2fjgu9L4StivDn5ClD9xBaXR5C0tpgj7T40pWBtMUYpq8Cl95EPNynDqLnM2R29rx6r7TvlOq61lKGqorKRckBx/apIt8xxwSo3siKdr41BVyrs85GsJUUGnqZsGeV27rLPuJQwjRgdB8jHf3W7XeGuOYmXNvlbnN/ZACladybBndRBJj3b2y5jjAr+nHiAvIXUIj+8KsCYzT67b9Es8yh9lqYBBhRJAAfFUp3/zQkQzm6xGNxTa1dWrNDd6tMU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTKUAqlYahEPVklhSbnu5txGo/yQck0XgQGJ4MYN4AE=;
 b=U7bRo7NzcuNKFzmBoAStpWZaNfg91+3nkP7Ha7k32vaD8OPvYw95yx0dzFQqTK/428hSl5xHfxp+ATbyY04ItL6wCpy1nzWg8iDM8ttJWsOXtQKubSvRWSEdsb+bd91z7oPYmV+X3aM8BbQNwe4l/f9berWNnOa4DOdtzBy9pgw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4282.namprd10.prod.outlook.com (2603:10b6:5:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 14:43:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 14:43:19 +0000
Message-ID: <fb5deaea-0ffe-4f66-9757-7c38934b4c29@oracle.com>
Date: Fri, 7 Feb 2025 09:43:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nfsd: filecache: use list_lru_walk_node() in
 nfsd_file_gc()
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Dave Chinner <david@fromorbit.com>
References: <20250207051701.3467505-1-neilb@suse.de>
 <20250207051701.3467505-4-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207051701.3467505-4-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:610:e6::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f6f7b6-a20a-4835-6317-08dd4785c34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmI5Z09scUxKQXBiMi9oSHEwYUp2djNUM2Y2d2RKN0dRTmZjR1ozd0hpYVE5?=
 =?utf-8?B?WjdMbXMwbE5hRFE3Ull5czdVMHVjWElKempySlhoSnZaYzRwd2pWS1MxN0Jw?=
 =?utf-8?B?ano2TVZaNFo3dXVIM0xWcDZKTUVqeHlOeE5nQUhtMkRlRGpuMnlBaGdXRG1J?=
 =?utf-8?B?NmdaOWFxNmh3UE43OXY0MUVqN29Bam5pRktCQU15UXd0MXBCdGlhNm8zNWU5?=
 =?utf-8?B?dE5IN0Zmc0VKeENFWGNSVlJFRUVSRWFaU280dnc1U29sYWppS2IvQm5FUGRa?=
 =?utf-8?B?ZzFieTFXZDgwZDBrTDlObi9LZ28zL0RHN3hnWkVJQ0UrelNjamFvZUEwZXVv?=
 =?utf-8?B?RURnRlZRMlFHZjhZMnpmTFp5VDlucWdNakVzTnBZaUh3MnBVMm1RYWFSZmJV?=
 =?utf-8?B?enhwWWVRd3B6YU55bHhSNmJ2clZaNk1JdWlYaW4yNXBxeXMrVEgySTA0VGpT?=
 =?utf-8?B?NzZnQjF6V2M2WkoyZWJDd0J6ZmxsNjU3WmExRm5WaFZFZFQ0T2lsSGw1U2VM?=
 =?utf-8?B?aG53c3M1SUJYdFh6aWZoTUZSOE9IY2xjYldkNS95ejNOMmtSWXVPOElockVy?=
 =?utf-8?B?VUtvY3d6VUdCM1pOblQxbWZIWEV3ZFBleEFsSkh2R3pTUVhuYUxlRUZ3UnAz?=
 =?utf-8?B?TnZXSTJwSkNtVnAzVnR4QWFEaGVVNk1seUNxSDVqMlEzRTYrU1d6R09NdFJs?=
 =?utf-8?B?WkVaU3p2bDBHdVdKSUhFZXVJR2NTRVZCbW9VQllBTmNPaE5Ob2ZnQTVhbVpE?=
 =?utf-8?B?cktYNm40UXVqMisybmNaZHNLVmdOZmNNd3hpcmFxKzRZT2xEbTdiZUlCWFZO?=
 =?utf-8?B?Y3IzYmZSS3ZHZzdjd3pDd3hmM3JyOWNJUHN3aFRNTVpNbGJxN1hLT3ZLMkJa?=
 =?utf-8?B?QTNJaTF6dWxtZmFrYXNIdzhmUytaKzhReXZjbThGcXR3QmlxaURlQWFXQ2g4?=
 =?utf-8?B?RVZQeFJ2MUU5eEYwWDJRMk42cVY0R2oxTXBrb1EzMzg3MERhODlzdmxuaUJj?=
 =?utf-8?B?V0dFS1NZV0EzeUJJekV1VCtXR0NoY2dvYjAwMnp2c0hsazFNMFphb01zMkpE?=
 =?utf-8?B?Ui9SODAxcjVaQ0k4c0ZDTlRGVTBaQllwdWZzb0JrZUdPYUl1U3ZFbEdFTlVL?=
 =?utf-8?B?dTZic1Z0dXhWci9Femc2TFhEUURzUTVaZHVKQUszNjVxTFhpYTg3L05qTExn?=
 =?utf-8?B?eFUrK0orcXBKeWxFSDJrejV6aTQ3dEY1UmxyTzNxL2NuOUtXb0VwbjBpUG5l?=
 =?utf-8?B?c09PMlMrSkN6aGdsVDlKOFV0YVU3WmtQVDFiSUhiWXdOdGJUMmhWK2lZaVdR?=
 =?utf-8?B?N2JoQ2J5V0ljbE40RnE2NzdHa092RzE3MDJBMVNkUnpoc3lEamZMQ3MyN0c2?=
 =?utf-8?B?azNvV0Y3VlhYOFBlYkVyZkJSSURwS2lVdzJRYnM0bWM4c1FKNHY1eDhOeDdp?=
 =?utf-8?B?T0x6WUN1WW9jUlNjeDV1UjQyNXBwSXFpMVBqcXZRV3hBMGE3aHc1OFRNUlFK?=
 =?utf-8?B?c2ZuQnE3RXB1dUlUVVQrYlRYMW1tYXZYZFo2MjdldDN2OXRTOFA1bjFaNFVW?=
 =?utf-8?B?NHcwUVMvZEhJYW9vbmVHblNOakNrbHFvMGFSMnNHaFk0M1NSQU1sTFJ2RTk1?=
 =?utf-8?B?YjBIWVNBUHN1OWRoajlPTGE1NVFmZGtlMjVLcEZ2dnRWNzZMUkNNSDNQNGNl?=
 =?utf-8?B?aG9NbTE0L3lSQkk3Tzg3V2crR0JFMno3MDIzZE83YVptcHg5bytydkpHQlRr?=
 =?utf-8?B?S2NhZlgvMXQ3Q05xbDVpRk1hd2xKbmpLZnhadjdPa2ROdmVXaGZ2NFBsUzI3?=
 =?utf-8?B?SGNQMy9PakhTVDRrRy81TklBUW1WVGpnTkJJN3pvMldDbEptTWdWV1hXNFJC?=
 =?utf-8?Q?WBQdPbwpJfINO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1luNmNYbE55VmZ0eHRscmdpNDFWQjFKV0MxajhiY1dzQnhCaHI1N0x6Nnlp?=
 =?utf-8?B?QWs1VzB5YWdvZDUxM3kvc2hUaENRVnRvc3l6ZEhGd1BrR0dVQ2s3S0FuMDJG?=
 =?utf-8?B?cFlrdWphem9hYW1jbWRxRjBqWDNhek5zTFQydElqcnpUYTBFcWo0TFVtcDBW?=
 =?utf-8?B?OXExWGJJNkJ4OHhqTmVuRkVtVjJ3Qy9kR2d0SnZPcEI4bk4yaHk2QWNGcnRB?=
 =?utf-8?B?OUZ2WHhtYTJFRTU1djhYVTVqWEJ5QUFwQkRaR1FmUllTaG5tTDAzS1pZL1lo?=
 =?utf-8?B?MW1td0duTzc3RVN3MEdINHZYV21WRDY1eXBPUWN1QTlsUmNEbUIwUTNRSm8w?=
 =?utf-8?B?U3RDayt1ZEp2dXd6dlZZb2F0OGh3dXkrWHpkTmkxeURFaEJLbVI0ZGpacElY?=
 =?utf-8?B?bStsNi83QkxWM0FaS3d6Ly9hVmwxaTM3aUJldEJUck1YUjZibGxSYW9XQURm?=
 =?utf-8?B?R0hUT0NBTkpMWGdHQ2UydXZJc3ZiOGZ0V1RWbHY0Y0Z3VDBiYlg4SlFjYWpo?=
 =?utf-8?B?SzJYdjJWTjJHTU44TGhqeDFjZVRNcG9vRXYxT1ppdFRsQU14MVNCVTdPeXJY?=
 =?utf-8?B?bjBxbG5GZ0haQ3hmUGdybEFObkJscU4zK2R6aE5HaWZzc0N3SXZFWkdyU0Fh?=
 =?utf-8?B?aVlzUjg0RXBsbWVnYWVodkJweDhCTWp5OGRabnMwK2cvQm1KbEc5K2NBckhl?=
 =?utf-8?B?ejAwREs2dmxIVFVtY2JyNHRZVEFWdXlDbG1OazE5TldRRnA4b1BpT2I2VmJw?=
 =?utf-8?B?YUVDbFJVcHpaMFhFY2Q5U3ovWDY4ZVV5UFl5bzdJdHdTeE91VnVkZW00UmtG?=
 =?utf-8?B?QThzcXEzWHllZERwc2JqdGVxVk43cnU4TmFLYmhrQXdrQjBCUHJuYStBRE1Q?=
 =?utf-8?B?NmxUUEpDWVdoNlhRYkpEZFprT0lxcnBIUUhPUUZkMnFsWHNvT3JLbGMyTE1C?=
 =?utf-8?B?V0gwUE5nNFN0TUh5TjZ2dkhDTzdReThKQmJhZFR1UVlFT2hLQ2FTSS9JM3Zk?=
 =?utf-8?B?cXVyTGV6SVRjS3FEcXV5NStRbTBIZVB0NjI3aHd0d3lpeTZMeHFYZmRncUpL?=
 =?utf-8?B?MDJIZm1wR0U1OFdKdlpYRFZZMGVDUlBqdXBjQWRQSW1RU0JzbmdFUkd4TU80?=
 =?utf-8?B?OCtkdTQySXUrSEg5RDVheVhmc2RTeVJXWlg1RzdSNk8zTUFkWE1LMDBEdXRi?=
 =?utf-8?B?a0pxS1lWTjlwTVRmbFl2UXkzckVqbm03dWhKdUFqQXFlbzdFMnNaYno3OTBt?=
 =?utf-8?B?bE9Wc0o0bE96a0VkVG5SbWxTSXZGOGpIaklid3BDN2NPTTZVYWtSU3JBYjZu?=
 =?utf-8?B?ckpCZmI1R3NkNFhJaXpHL2kxNzQ3RkJUejZQcDB2OTN0OG9UQTdUem9LdzJu?=
 =?utf-8?B?MXlwd2xrd21HM1hCTTBGbnVaLzY5WGxhcFl0dXdXQVpSWkpJTVNrTnh0TExY?=
 =?utf-8?B?dXp4amJDaWpjWm1UOHFIRGIyR2tTMnVsckkyeHZhRCtiM1pBWkw0N0pOVVcr?=
 =?utf-8?B?THNwRDJsOUg2blB0QXFBdEFLeGIybFg3VG1Ycjc2VW4wVUpWcC9ucU9Wa3o2?=
 =?utf-8?B?cUV1amQzY1hOK2dmZkJPTG12TDVUS05qQTFlSUJNMS9vbUd2cDlNZm9sTzcx?=
 =?utf-8?B?WXRMeU9kSFd1RGV5RS9YRjltdnJiQyszaGZLOVcvb2ZvRXRmVVFyaTVHVkJV?=
 =?utf-8?B?SXNzei80aitydmJIY1ZLMERIZUc2ZVoxeUVPZWFKa0tJbmRDd0cxWEJNT1FD?=
 =?utf-8?B?QVFRNGdPMHZDVkY1U0lDT0JObE15cjJEZWhiZUtzOHdaV0dBUjlzY3ppaE1Z?=
 =?utf-8?B?V0t2RlJ4QmpEYi9jM3UvS0FsMTBoVXljd2QyZjJIcHdtOUtxU1RwQmdZOEQ1?=
 =?utf-8?B?UEdhWEtwaWtEK1Fiekk2OTJjY1oyTzdZaE1hNXJvRVlhUzhwdzY4K2Q3TjZJ?=
 =?utf-8?B?bDNKRDhiYzE0Lytaai9nWFFFaWlyZHFzYmhXbWJtaTZOVXliMWxwYk9sL2M4?=
 =?utf-8?B?ZW9lcWZuMFFwanZiMURCZGpvWUJKL09YZHhJRGt1a2FJWFQ5N1ljRDlZM09W?=
 =?utf-8?B?NVJ0RXlrRTdqRXl3RVRxZzZuc3ZmUUdOVGNRL0ZMNUJyd25mOS9BZ3NoNTdD?=
 =?utf-8?B?clFxNGwxQUwyWWZ0dWJUbTRiZ0NSYldaeUVvSXlha1NSeXBsdmUvQlhDclYv?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bLsMUEOUptAHMDWDH/YkwpCeCiR6Ju+loSNy+T6sdcPP3+zhL3ZFFBg0pV1wHDkPQMYN5hLeo+0ipc0NrTpoXUS7AcZ+ncyMigrBdo8pyX+XGBiFlvCtAMgBgtBKmmtKxEbFVfvvkbK0J4c6XX1LwVy/CEzvWtElhC/rpkPa1doWYLvVewdokcKu/H4g5W+27MDe2O1/KLnw2yr3sCpzMYxyZtcmGqKwEALRjx4oo3c0/vWWLemV9CSq8XGZ0/ahAiGtLHHEPkKZ+Vwwo6D/FZuRzCMiaD/zhaUJadJMw73psUon82xrqaC5rHsYZ2N71w2x/pv/KyMvVGXBlis6u5DXSmG3HLMm0awSWcGQqbTIfeM3ZcNnD2m/LwHBOY0VWuV5oeRLKrLn15hIV0V7XSzA/HwkRT0TvfmBdGIjNd0WvSTVIr6G1Tc3DG9J5Zz9xyrZhyAylruygUrcuQcJH38munaITDLPWVm5F62mDHHhM479e2peoTUkeidMDdvU7nqUkTwLNOPLSXbIfykkJDpbOsd7U4UyWsjHD9WQCmkB9G91Y9R2baJkrmYZ5YIPOd1qaaPrIRl+im/vafkw3y/iFik+TkrcZ1Rhpnay3JY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f6f7b6-a20a-4835-6317-08dd4785c34d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:43:19.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /K8OMr+T1fZ4KtQES6ISb8LzpvGKzQxtOuaCC7/mz2HScb3Kp0yEKEHf6j1UIu0ndxnGkWgfWNb0CglPsLfMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_07,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070112
X-Proofpoint-GUID: UebyaJtxPV-woumeeOR5X1bT-qVif3cM
X-Proofpoint-ORIG-GUID: UebyaJtxPV-woumeeOR5X1bT-qVif3cM

On 2/7/25 12:15 AM, NeilBrown wrote:
> list_lru_walk() is only useful when the aim is to remove all elements
> from the list_lru.

I think I get where this is going. Can the description cite some API
documentation that comports with this claim?


> It will repeated visit rotated element of the first
> per-node sublist before proceeding to subsrequent sublists.

s/repeated/repeatedly, s/element/elements, and s/subsrequent/subsequent.


> This patch changes to use list_lru_walk_node() and list_lru_count_node()
> on each individual node.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 7dc20143c854..04588c03bdfe 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -532,10 +532,14 @@ static void
>  nfsd_file_gc(void)
>  {
>  	LIST_HEAD(dispose);
> -	unsigned long ret;
> +	unsigned long ret = 0;
> +	int nid;
>  
> -	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> -			    &dispose, list_lru_count(&nfsd_file_lru));
> +	for_each_node_state(nid, N_NORMAL_MEMORY) {
> +		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
> +		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
> +					  &dispose, &nr);
> +	}
>  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));

Nit: Maybe this trace point should be placed in the loop and changed to
record the nid as well?


>  	nfsd_file_dispose_list_delayed(&dispose);

Wondering if maybe the nfsd_file_dispose_list_delayed() call should also
be moved inside the for loop to break up the disposal processing per
node as well.


>  }


-- 
Chuck Lever

