Return-Path: <linux-nfs+bounces-20309-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO1zI5XJvmm4cAMAu9opvQ
	(envelope-from <linux-nfs+bounces-20309-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 17:38:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094EB2E65B3
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6479A3015A6B
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D862FD1CA;
	Sat, 21 Mar 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JMXpWpan";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C+vBLZqY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11192DCF6C;
	Sat, 21 Mar 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774111116; cv=fail; b=JKATpe3oxUjfbbqHO3rfwQX86SvYRUAmvDyzzmVUsnk4LJvA3RT9x8hP2QDeUuUJSFhcmkKasst2TO+vmA0RtF62cZkpQH+TallvvzsCJxxUGdx8zHE+nuoJlEcfcq7Gm/68BRAN9NamyrZeO957WH4eSFaawvSWupxh03KXg9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774111116; c=relaxed/simple;
	bh=qaKuMWH5HFYixkeiDN+6dfNX042GlZBfkQnCA7NbrX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FnK8wfUTqoNdkKOiSbt8RSA/hvKzfaKmnyWJnMLS/XzkXskLE90DQckpRAPk7sfyF+wkMys96c8lecMXqfD3yr9/e1yow0DwtLMZ5iuAcamxJWbw8TBm5Q/++jhBMViGZzRXWtJLAAEzDBI5qC5njy1eUq3oMJsHYeczRDGvHek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JMXpWpan; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C+vBLZqY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LFxDx52219236;
	Sat, 21 Mar 2026 16:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RyxqN4CV4lIG7gIMoqrkAdO6CfhKxZvgxGNhdEU9Ju0=; b=
	JMXpWpany4A8+AqqEAnBEL3tJD29h1Cr2jmeM4Trr2Y3JyQtCiVR7nltFgvEBnKw
	ysULaXRYPwIX72bDfJ9fiepQcVxsyi6oEJKU7rjePuEvBdSKvIERjNr6uAKxHzIu
	gJj1qlioXkT9PrdWb+2h5R5345ohuepOv3a5n8iDmx1vVrIhSvPOTRlq2ZYo3i84
	PH0O/VUThTpPEhcny73F3mM3+TQKbN8FlAlHcxne16dJq6juJJjQ8q7TDNxkwWDt
	+OJ3LsFcDymq0WK9iPF33Y5F3odclzxDaDQqbSSPRTJ6021inoC+sZzHIo2qqnpC
	KBnQ2krrzqElo939inPR9Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf099s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:38:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62LFCX9M012371;
	Sat, 21 Mar 2026 16:38:22 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hscyhcr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 16:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj38Pihf/A878P3XteXUg2++eYKJpjYg8U1WRgwRqgKmT1dxn3IT3+W5xIDtobJpR5VZ7+uAJLk5ksguwJvaPUFHMUTH9C1A6zOfe8OHCmTZ2wLR60RivULrVeM5CTkMIZIb14Q17ShvymHkJrQ+L8yYkpirx/Q+xj8J+apEPLAeotQIOJ6GIdYotCGr8jQE/FyzXyTZgFJIquU8YH/ujAiFFslIZqDEKHdiF/JbsSwLK3hlGesYubTjHLkzfrZvkxXFdl/uAf6WpRy/roSPuHDJNlxG59CDFydkrWewBXq8ef5S5WSUG+AQt3pX6FKmefBcMoe5QN8f0KrIO8o/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyxqN4CV4lIG7gIMoqrkAdO6CfhKxZvgxGNhdEU9Ju0=;
 b=vMuaRXFMi3ybW27NGejqARoX6y93sJyVfLQjCfEaY7f0ylTybOHsQZMFEFzQdh/F9JNDlEuXD6x0z0255+ry56P0Czib5p6JTeKsjIPCtqK0TIuwKNOpjoiSiocZ6xtP3olFV85PUpOIcC095r+VSHyUF3DMuEybmlWrVMuTQNoWDk79IMJB4tu6gChF7g0Uc4A2urOn2d7J9K6GEmfKZW9UXtEkGTYPok8O+RpFi82aI8+ipHg5Rpx1nGW4jKrnB2P65g+2xblgTfh6z7l9AzOJCPW5Sc5ZPIVSW4+vc7ReF8GgxDlzTAesmuOkbsVj2i6VbSIvffXs2gmxbRM2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyxqN4CV4lIG7gIMoqrkAdO6CfhKxZvgxGNhdEU9Ju0=;
 b=C+vBLZqYWbTllgYqqUEUkfs6Mf17sCl92aZk4gXyjQVrt3Co5NHFAvuN9TnITsUIhqhiDFHqM+cJkGEo+/js6pnH2u1fBS32T7uIUZU7L8ij6ADzSb7UnMTgKlHRgyf9EGSSdPZGhJC4J6yOtxSMCm3aCQUtkFqHE+bgMChpKfo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 16:38:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 16:38:04 +0000
Message-ID: <15f31b98-aa14-4f58-a685-d034aab61d73@oracle.com>
Date: Sat, 21 Mar 2026 12:38:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] nfs: Refactor nfs_errorf macros and remove unused
 ones
To: Sean Chang <seanwascoding@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        David Laight <david.laight.linux@gmail.com>,
        Anna Schumaker
 <anna@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-5-seanwascoding@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260321141510.68214-5-seanwascoding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 2472e99d-ffae-4559-f5e7-08de8768399f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KsfuxxXtWb82ecqH792d+C5ugagP8zfo/u+o2PKZesjOl5mmx6pwSgyoEW0WjurQO8fcXPuKhboWg/tvSkaQAhRUaGH3ouz5MsYmFZ4dwoA6OAJOj80okYSjtnI86pfvVCn8IFDOrcLWESJV1OJlgIbaT6f52gAlAOzaQc4/Od55Fnemd5gQQPhWFUW/duwOVQDaSOj2OeiWOKi8C12z6NHnqkHbtf9Q4NOjz5omD3iZz/A6K4Cp2y6jEjk5s8GlescoOefvq3sJ+FA6LjoFQPHsGKT+Wdft0rJRtoTxYUnDzWFnBPpAm3tWZJFWT+F2BOw2rHztjU1tusVqtGayzHNSQM0oWArlosw/GwlUvL5M3fNzmutULYbepdZtWCi6Cm5iQ0+tgNveEGXKwSTcPJK+xp68v7KWjnQvRMZ+TjA1cORbvYSMUUqfN01Bwpm0o3tj2G2q0X0EN8RtJULBIDUssjv6849ybwPOJo/dxy/Wf4UiRiVh2zOhBZ/n2zm3p/wd6um7YraU0WO/gHwOHuBCVEcceK7edIwUpJ7iFp2kapT5IE7jK0T8eCXhiWtVQqEi+uomid+r3WZf1VAD4tUTmVXbmLe1LK0zUctk4fgIJLumcDPNjyeQ/aUHypn+ovadZT0UN4LpVMi+dsm54qrlPdiP5WGUyck7C9HyPY1XT4Pmr958/SUe0jEhykXBN2RFsI5umYVZsWgY0rXp8uQ+pDtjKkthtg6fXf2SGbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlUzVnJUaHhMT05LWGFvcGdMcU14UGxHc212UUhHRmdUaElUZE1VRks5UFBL?=
 =?utf-8?B?YnNzcVZBWmpVR1Fsczl5ZWM3RGszK3ZrNDRoa2FUWUYwZ1hWRmhzcHBBYjB6?=
 =?utf-8?B?eXROc0xLM0ZicHhuREJOTmI1SW83TVZ6QW5ydFFJREw3TlJyMFdiL0NXb1hQ?=
 =?utf-8?B?bXV1cldLWFZyZ05nUE5vcldrVUVleGxVYVc0S2gyWDFaUWNLWXlvVTZBUVdH?=
 =?utf-8?B?Y3A3SzlEMklFeWNSYjJIL1NNcndSTzUxZ0h4NnJBdkZoTWN1V0hTaDZNSExz?=
 =?utf-8?B?L0tTRUtxbmlRdTVmNUdlRXVOUVdScXhPQXEzLzhtSkRmMnRVZk1VMWJoM1U4?=
 =?utf-8?B?SzQrMFYvNFVsY0FueThOZTFWTUZoNWtYYVI2cFpvamlkZmtTYTVJb0JUMitl?=
 =?utf-8?B?eEswT04wVXZWYUkweW8xajFXVkFBQmNCZjNyUTNsV2ZTakdUbW5rdTNQVmJB?=
 =?utf-8?B?bzVtYXgrbmZDbC9FYXA4M0NOVlZxRlhxckRwN25GRDFabzg5WEJUMzVEbmVo?=
 =?utf-8?B?Um1IZk5tOHRiQXQ5UUZVcnduaTQwMDJDa014M0YwMkN2aUdBN0ErSHdqbEg0?=
 =?utf-8?B?a0JSalJlMXZISEFNMjlHTlVZUFZZUUFBOXA0bTNZY3Zoa3hTRXVHcGR3T1Ev?=
 =?utf-8?B?dHRXcG5DUk0xTWFGZTFVZVNwM2FEdlpjSjNZWHN2aE5HS05TZGlkYytGWUs3?=
 =?utf-8?B?TVlPRSttNWZOWU9wU21jdG9CK1JyVlAxbFl1SzkyNEJxMXFCd1l1T1Z5V2FL?=
 =?utf-8?B?U0tDNnM5dFg5U2dBdU9zQVAwNkZkc1JvdU1sRHRXK2RuQ2RXbHFCQWYvQVJp?=
 =?utf-8?B?L2tkN0E1WTZyUjRzUDNvSmJycDZ4NVdGVGNmRXJWVDJud0Q4d05WczVwRVhs?=
 =?utf-8?B?Z2tYb2dHU245QmtJNEMzRjF0T21uTmpzVDI5N3R3MnhXNWc4aG01c0tZdmND?=
 =?utf-8?B?aGN3NU56L29Ka3YxT2NYbG9reVpBdkJoL01NTVFRUkZEYkc0c3Q3RjVZcjRJ?=
 =?utf-8?B?Ylhkb2FMemNjVjBab1JOcitmdnRNcTdtSTFidTFRRHc4dGlIdjJBSkFVSVVJ?=
 =?utf-8?B?NTRxZmgydlRqOUFMZHZFUnpxUUIyQy81RmxnWFkzWjIxNjVsQVovU2RwbHJJ?=
 =?utf-8?B?SGIzUTIzcE1jRU1vUm9QZkh3SlM1aGlZTk5BQmVMTHVtcGw1UWdsWmFVOWdu?=
 =?utf-8?B?ZjNuUGZEdkROSkxaSlJzeFRNTUp6MWw0SFB2UVlLUlJtR2ZkaU5wYnZDWTla?=
 =?utf-8?B?ckl2RjJobnJ5SmFVZGNKQnB3QVBvSFVEdVhQY0JiL1BDSGtQUStJYWxQV01D?=
 =?utf-8?B?VUp5WHB0WEtzUXg3WjQ2blorYVZ4b2VHbGF0cTIrSG1Xd1N6aVNINGY3UmlZ?=
 =?utf-8?B?QXlXcFp1RG1HMFdYYzlrRnBLWmdhLzVpdmMwaW10a3ljREw4TXVvNmZEaWlZ?=
 =?utf-8?B?TzQrMkUrQjFmb28zVWNZZCtyMEJRd1l4T1lRNmR4cFUwQk1kWTIyNHlaRlpP?=
 =?utf-8?B?RXRpN1o0dlc3a2JkamF5VVpaa0NkbFpERERwMXdBV1FSUWJlOS94ejVhUHFk?=
 =?utf-8?B?RHVyVHEvb3gwTXc5V05RbUNqUzZmNUxOSmpCdnJkYVZ6VENnbkFnYlJFSVpq?=
 =?utf-8?B?N1lOeTdnSWxiZzJ4WjRNUUJiODhIdUl2a3c2b3hrOHU5REVHWmI1aER0djBD?=
 =?utf-8?B?SEVDWHVYVTNjSGIxRjN5RHhMUGYzVEw0dzlEQ1JpYldMQnpoMzZFdTVwazdz?=
 =?utf-8?B?SkpiYXJxOHRRL1hvZzVpZFRhcTVUKzJUSCt2YVJwT1VCQ203Z3hVdmx1L2cw?=
 =?utf-8?B?QXI3MzZERnZUNjA2aHE1TmNnVVJkQXQvTlZQWFVFQk1oM010T1Z3RlBOSklv?=
 =?utf-8?B?ZEE1MEZ0SVRpc3IweWE4aWpZdzNKbG9aaTFxeEx1QmlLNWwrU3FFSXRIeko4?=
 =?utf-8?B?Z3ZNNlErdExKSE04WW1qUVI2OEdjU1VPVGZ4RklxaVU5QU8xZzhEaGR6eXpl?=
 =?utf-8?B?eXo3VTF1N1FZejlBNW5rUnN5bEZGSE5RQThtMWxOdFRrVEZTMmhTdmVTVVRC?=
 =?utf-8?B?NUl6WkRMUWRuQWp0UDN6ek1GZDZjc0JxS0RzUWVYWGZxYzE3czlIZG1XMld2?=
 =?utf-8?B?TlV4bXdIcDJUaWRHQjVMcUlEcEIrVGtFc1MxaHNlTEVaUTVqUnp3eDcxRVhm?=
 =?utf-8?B?MncwYUVMOGRuaGM5YjhJL0M1QTcxVlZ6dXRnQlBzWnppSmZkYm0yNW82MDBh?=
 =?utf-8?B?b2JqakIzMzgvOGF2WDViaVVrczd2dXM1UFBENlVnK0M5aXFrQ0tJcW13TGZW?=
 =?utf-8?B?MU8wSW5lakUrWUMrQk1TU1V0ZFpDc2s1S3RCc1FCTm9vSEl5TWxYUT09?=
X-Exchange-RoutingPolicyChecked:
	DmxxGI3xfVfAU24+aSvpXmn36tQnhV95skquPdZ8wDwxo4l8TUGih4KS5iE2Q8tb4PqAaHUfOZojQVnvJnhTdGxhrWzGd2snxJniXnQghEQNHo/obIdfRh2XxBVdaHi2TL1qsIycZPemHiS43YRMjO/7uG6CTTKv+zVr3pXUlTLN/UjhHDIoykb3sTrFA5gFrjtaMMhSj9r84wvIcBAOcGyhDv0QFax1vKSh4bpRsp8zsfVpwbPwPyFmAUAPqDQtBF416Is2cB+/3JehT/5wvXoJkBPGvYJGR+83F1ySPXNB6Y9jhNQxq4b93lrccgGnnt91p0UKJFjMwkbfA7w4qA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B8H2qfuW7kxS9TU7LFMRHdpdw6KzDs4NyZ6hdiJfVAkC1EOwpUtqvOl/f88WMSG7Ki0fyAwzEgXLfoEpQXYaY31yWVePxckQmqKjpe5bEnNxKuBZUTVVliUMrJpyQW5C8WcJzHGwsBkjo9JBsuSy4bYfQ9r6GGfjwk3Z3BY+BlD+rKej3k2Z6dmsuDgWgldIiahMyqv8rCWahpPjpSrZRixH21mqwPP2REZhYSq/af4kP79glxc98o3l5Cxg+EQpFbmdum/Bzu2v6fDPWcfNDjc8nRfBPBTY/H6woorFbIcP+HCT4LBwpneCuiplHTE+ZbroH2bYEJWxuAqEFFdHd9RT8ldTdQhnmfmckMheMBZFU6Q9zPMTMp+1/xea8UnY/9raXdC6u8jmUbozmny7a5evZhfyluIYE4WEcjtTUtuWpwSrUbpx3KOVlK0R62L6Rxtvi/CuMnvUkS+L/s3cGkCktUXCq6hPlBfNID9KM0YtZeXt5BET0PFhcy2JrKwlF/yD4x4biEKcCsY5FSW3AOfxKL9myn8dbBimZX0YVsjH+6yXL3kI1zmPyC+B4Jxof8VPlfMSa3i3G9N/kYwl1OGAyW+tqyfcsKKzZ9CiU5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2472e99d-ffae-4559-f5e7-08de8768399f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 16:38:04.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HYxOfz/2FU9+Lyb/5TyMKWxSBOUWuPliByngaauycXwGJJhvZzeGkaN6Yx5qNABXtoZPZidwYuGkJEL+tSLxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=793 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603210141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0MCBTYWx0ZWRfX+ILP92IS9oBs
 Ug6RW660CNjr9eOdJnyR4rfuz6EnkjT0P3pfXmDyeaSPMSLlO1YrsD4I0sFKKrrTbpc8U7EVg1u
 +pcfwqHkvSaE46HfmToZLaWJyujWUF2tqVhhoHNXr6kOMCPwtlukdQA+oN2ute+QF4FMrfK0xSu
 VhHbUbAu/9acEhpvxcVdwsW8PLckUee21LmPhNN7tYke/3FQ46fLCio0Mq0ENSyMOeVjnMEReSO
 bZHFABDAOoxP3eyGr9lKFJaZWIuZYohfFxipJRh4LvUv3PaCZZ4L/M+Kn1QIQZ5T1ZNAKJ5KYSO
 0sWbnmhz8q5TOxjDBWu4Sp4MSYzGaDDH3PaiSrupS9YpKUCVazki6f4qZH65Sl21i8ns7ZQAiD+
 WvIts0p488jiMNo9EKAK8Ec3LB8dtCaBsnoA8pFidPzfxVLdzimznab/i+7/YfLPIJvKu4LHNfy
 NeJVhFN+DRtv+pvd9B/zIyKFXfpXwqn96HLkW7QY=
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69bec980 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=riVuAcx9QJJhqxGfLLgA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12272
X-Proofpoint-ORIG-GUID: _mkurW1u-kBF1KJily1JL3A7MfGMjogo
X-Proofpoint-GUID: _mkurW1u-kBF1KJily1JL3A7MfGMjogo
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20309-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid,intel.com:email];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 094EB2E65B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 10:15 AM, Sean Chang wrote:
> Refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
> pattern for safer macro expansion and kernel style compliance.
> 
> Additionally, remove nfs_warnf() and nfs_fwarnf() as `git grep`
> confirms they have no callers in the current tree. Furthermore,
> these functions have remained unused since the introduction in
> commit ce8866f0913f ("NFS: Attach supplementary error information
> to fs_context.").
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603110038.P6d14oxa-lkp@intel.com/
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  fs/nfs/internal.h | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)

I need an Acked-by: from the NFS client maintainers on this one.


-- 
Chuck Lever

