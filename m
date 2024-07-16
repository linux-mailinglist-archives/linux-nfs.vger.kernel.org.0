Return-Path: <linux-nfs+bounces-4948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAC93275D
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 15:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5810128272C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E517CA05;
	Tue, 16 Jul 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PGy/1tgQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2109.outbound.protection.outlook.com [40.107.212.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B619AD9B
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136246; cv=fail; b=S62bnySQ7LtJqBPP9xH5AcSNnMnRn8Aym+IU2oHuMPAYd18OLrQ7GvVXlgtc9s1lV6R7Br9PScF77IdoThuuRvu4Oyv2A9vQ1qSbHY9aBdpMV2FvF4Tr/W9IudaF9ya/juHW+e6u9LPS3rIGDmUiu7aTl2BIcE8qwCF9x+P6EMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136246; c=relaxed/simple;
	bh=oN09VgWqp/v/7z9ZW33qfE9pZhJIX5kN47a7tjWd/24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOieiE+s5Wt5GfzsxH8fDEvCkf+qJnqaJlMQbH/AfVWgEnSPwAFdfGN26b+Qs/AfIBpKva9wXQ9pqeuhlcKDNg0U72/MHZS1qooJNpRbCss6qhvBFovA9d64hg4r3+q6EckWHdfW50HV7UHpqCILNlcXBZOYfX9BMsYmEilxltI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PGy/1tgQ; arc=fail smtp.client-ip=40.107.212.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmF5EI5CLSHN3MGnwvnyCDZFDyMDMKYxTdDWnnfyetO7fuhy7mR8dikTv+CEKN61BwmXPYjc7puTx/hhP5qjpobwxX/1K+m9eOZ6JBXuG7jnBVp905FHBkQE/jWWloB0+gyUfWRGlbSiTbgzYpsZH9AVadwFhhf9BGH4Yb7Y7VoPqw0WSJNFwR45aQRVs68EzG0dHYYRqdkTB866e4m4U1Gckkx+mqw/ZZudXLyb/pb7cbK6QZ6df/+KtdviiY04e27vxOJhtgWYZs/DZrsWFA/2VvS8xYtNX5oLM1zbux3fuf1UToZ9pFjaDcvauuIUMI4D3V0s+bx9U7oBX3ucHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN09VgWqp/v/7z9ZW33qfE9pZhJIX5kN47a7tjWd/24=;
 b=GoGfXDySHpj5xgy4PQhlWlyyNZCtF7mySq1RdGzJV+oy0Y1YCVbmLfNzwvys9V4cjxyB0LTc6QiS1c3rOVREisM22DA4qKBzXDeBYxJgZJkutohJQOvHh/nWL+K6/wBIpgUIz8349l6P5jdVdAbZ3iRTWQm7HDyBoS4drcBCJhthJjV1sq75HOtp3OpD5yzCOsUwnW5h6zziGdPcH67/cojvfiCycm1q4eZLMU8e2OnTkMusWynZhiFYCasuDDBrVhMXleckhjTmCKE4+DWDrj7FaXSTGFBuEd/zZSyQJ52D02ztLD8pCk/b1vS+bleJJ4EZOJ/DzertXGCUgaeVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN09VgWqp/v/7z9ZW33qfE9pZhJIX5kN47a7tjWd/24=;
 b=PGy/1tgQvhvqPU8znytQpwbGuZ7GLHZsp4MGBeTpfe77KOwa9pVz0fSt98G90/TG+d7jcDdLK/zILlkMLST8Qj6tgQRsOo79ZNXoCpY74t5w7+pH7wb/6i03EWpH2hnuB2nJaQc+f9lb6TD6pHbr7nC0xDZF3bSFf2vqdWBkPfY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL0PR13MB4436.namprd13.prod.outlook.com (2603:10b6:208:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 13:24:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7784.015; Tue, 16 Jul 2024
 13:23:59 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
Thread-Topic: [PATCH] SUNRPC: Fix a race to wake a sync task
Thread-Index: AQHa1GMoMJaBbWI/xkiq3cOP8YqYiLH5XdyA
Date: Tue, 16 Jul 2024 13:23:59 +0000
Message-ID: <2525dfa8b9a5539a51109584bf643dcbdcc5f1a0.camel@hammerspace.com>
References:
 <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
In-Reply-To:
 <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BL0PR13MB4436:EE_
x-ms-office365-filtering-correlation-id: ab32c3b7-968e-4642-372f-08dca59a8d90
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uk5wTG5RYzFIVkdFcEpYeTV3ZGpWaWtSY1JCYzZjSlhHR0RLK1FCcFFZaVV6?=
 =?utf-8?B?dWgvZ09GVXFiTG1PVW9hT1kyWVgxUXNUMm5jaTJhYjcyWjZuNmExT0FmWGs1?=
 =?utf-8?B?cTAzbkV6ZkR2Ti8yQmMvT0cyUkZ0cDVZT2Q4bzZTTTdSbUtTVFMveEYxbXhN?=
 =?utf-8?B?bTVoR3VJMlBydkxOSlNCbSs0aDZFNGNQckw2UlJqK0xxeWpXZkU2RjlGQ0Ft?=
 =?utf-8?B?cUFOaEtyeG8yOXVkOW5wOUtOT2doY3h1bVNLTzVwN3RBS0ZUS0k2Rjd4Ylc4?=
 =?utf-8?B?d1RVMExqYlVzcHlTTldlYndsRWZwTmVWc2I4bFlWTWtGc2IyZGczUXVoQ0No?=
 =?utf-8?B?dVA2U0VSNFRaMVlUbkIwOFZmOFdFdWd1ZkwwUVNVelhOc1htSi9vaFB5RWlN?=
 =?utf-8?B?alhVTEhwc3UxT1E3NEl4dHp1WWRvZkdyc1pDK3FhRUN0cHJ3eWwzSFU2RllO?=
 =?utf-8?B?SmxSQVU0azBidWlIdWNrNVQ2L2RNaXpCWHdGVmlVakY2WjRGTTJKTWRadE5w?=
 =?utf-8?B?Sjd2UnNOd1pIbzhVZjRYbEo0K0tRNmRyRWIyeTVVREFzWTR2MS80QTlSQVp2?=
 =?utf-8?B?TW5UdmJnaXg4dkxZYVZjcGtDMG9yQU9jd2FocDZmTGxsTVFlOVdYRmJSSHNJ?=
 =?utf-8?B?dDRZOUxUWXVyLysxL3RKZ1ZleFZaME1pZ1gzN2xLaW9DT1ExN3FFZVJsYjdj?=
 =?utf-8?B?UDdENzZuYW1ZUWxKTGkvL2dZQ2VkdXJpcHJuL2JsaGtLZkJ5cmJidmpRRXlK?=
 =?utf-8?B?S1F0WHowdU1WUllFNXVlOFVQVzhJcXIwV3JpKytlYnpOWFcvQ29Sc3J2NG5G?=
 =?utf-8?B?cTBUR21qRmIxcUwyb0RyQ0RaU1pVcE8rT1NiSGxUUm1wb0R2UkoxWVV4RlBr?=
 =?utf-8?B?ZloySTk1THphS05tYWpxUTNORCtiRlE2ZEQ2ZWNOaTRTZ3hIYUNGODhkWkpS?=
 =?utf-8?B?eE0zeXU2SFZRZ25PZ0NhOExLdERVK2RLdUM5N24rNVhWV2xPQzVRTXg4RHlD?=
 =?utf-8?B?MjB1RXlPMHRHQjN3c2x2S25NMEVUUHhRLzk0VEJybXZQZDB0NmltaG5sSC95?=
 =?utf-8?B?dGJ4T1YyRHR6NE5nbGt1QW5vSHkzZjdaUWpza2JzbWo4eDF3M09sWlRTMytv?=
 =?utf-8?B?YXkwMjN6ZWwwZ1RkWFErSzRncTMvOW1Ec3V3M1hIQk5pWkY2eTdqSC95U2NH?=
 =?utf-8?B?RnZmNnE4TmZCbnpOdm5wK2pXeGdUcncwVWZHVlNwUjFUZVNSVDFMS21mNnlY?=
 =?utf-8?B?aHhKSHY1OEpUVTZ1MHNwcklmRHZnYWZjUmtjN0Yxb1VuTkVjZmZSOWpoaEho?=
 =?utf-8?B?aVhnQ2U0cEFvRmNvc1lqTXUrdFNxdjFHU29LeXFFOEFqaWlscjR0R3ViMVZ2?=
 =?utf-8?B?SmpiazN2bWRlMHZLckFxYUlLYkszZWowYkJHMG9pSWNLcFNWaTdYYkdDbC9t?=
 =?utf-8?B?enNBc2kvWmNmek04NXd6VU9Sa3JNUnpkYy9uRUZDcjh2MVJtRWVHSDkvbnNC?=
 =?utf-8?B?dmkwS0dmdVRtUlBSTkRDeUZGQ05iM0F2WWpqQ1VzcHBncU1JK0pXUWlucUNp?=
 =?utf-8?B?TWtDc1FtNjNKVkxyeDZZcmdtSTUxSVhEczljMldQQlVBYXNFaDdDSmFLOWd5?=
 =?utf-8?B?aDEwWVBQY09SK053NFBrcHgzMTVtVXY4bGNtRUdEMkkyeWVTOGlDdU5xcmxP?=
 =?utf-8?B?VXVXRzdWQUs2SDBlbXNvUzZIZEMvUkdlTE5EUnJQOStpY252MUJOZnNhZDFt?=
 =?utf-8?B?dW11YncydlBnS2tBZFlhQS9YTDRKd2lkV212THFUai9Qc25ENEUwVG5uSlB2?=
 =?utf-8?B?N25VbEtlM1BFZEZhV1ROaFpiMzFxdDdSdzNsQ2J6ays4WlJ3T3ZuQVNVaXYz?=
 =?utf-8?B?a1Z2aUJaL05WTXZ0dTU0Q2M1endyRG9WZVVwakdiMWpqdGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enNqc25HRUpZaGVpbWJjVGtpcmFBWVFhb1E5YUJQdmRZdFFNcjFaRXYxOHRG?=
 =?utf-8?B?SXNnS2F0emkrVDBtRitKNFhRWEJIRndwa2lmVi9Da0szcGRoQitQRTNsSXdq?=
 =?utf-8?B?M1dadFNrMjBGdTJsekVQcURDQzFjYTd5YURWd3l3TTd2Yks2U2pFLzFiTUpL?=
 =?utf-8?B?d0xJZWF0SzZyT0hRdFlhRmFvWmVhVTUwVldNb3VjY0U2MzBEV0ZQY3MwWEJ3?=
 =?utf-8?B?QlFDWGlxbVRuTUd4akNPMHc2RGZUeitXckl4L29ZYzU5WGxKaXJrUmh0NnpM?=
 =?utf-8?B?TDd3M1h3UmRoNndEeURuaHJUN3BTcEVHamlhRTJIdUszSGVaWEk5S3N5Mlov?=
 =?utf-8?B?SllzOUxLOUVVMTA2QkRhY0s2SDNaVW9KSFpXSTlpL1JRWGVjVVNaV3JyckhH?=
 =?utf-8?B?SExRd3RVMFE5V1VzSWlLU1J0M1ZveVNhWmo0allTSGIxbmpmOHRoTTFocmNi?=
 =?utf-8?B?bmJYVzdYS2ptMnFYOWs4WUJrOUt2NjFCbnRzcWVRMllEQXdPRUh6d1NCek9N?=
 =?utf-8?B?aDNjaWtYdVgvcUJnK1FzK1d5c3hVT2VBaTJ2dWNrNXdPelVsNjFodi91UTBh?=
 =?utf-8?B?OGYzQUdzM0tsaUF2Z1U1S1ZqdUk5MXU1N0tRUzJEaVlpQkhyWkpLWjVrWEhS?=
 =?utf-8?B?MTFvUTBQcEg2SVpBZDZic0JvZEZpcDBBZ05SaXBKOG00WVU3bTRFQ0hNM3VX?=
 =?utf-8?B?Qk1MNEhHc0VOekh5OWZ6NEFIb0NWbkQxMHVLYzNCZzB0dit6M1pHRWtINDNu?=
 =?utf-8?B?YWFVRGc0dE01TmFKbG5rM2NQSENPR2ltY3hSVzJRWTlJNkpXMGszMkVXRG41?=
 =?utf-8?B?ZTVmelJPN2dXSHRLZlE2Q0J4Wi9SVG5ydThtdzVsVGRDTDByN005Ty9vZE1r?=
 =?utf-8?B?Zlh6cFlmclIwbmFKdHBuWjRxSml4bnd6d1Y4aGdVTTFSWlgxQm5BRER6TERz?=
 =?utf-8?B?SHV6VDRJZHNLOGJFZHpEWUwxR3FNWW1VN0VERWVjMCtMaFFpL2JlSml6VUty?=
 =?utf-8?B?Yi9TcURhZm5MbzVtMjBrc1pwVFA4QXl1MUg5V3BERk9zdWFleHZtS1AwQ0dm?=
 =?utf-8?B?NnNsUXBJSTZKMU9pa1dNZ2owK3YvSTVLWVRoUVllVmxJS0g0aHBGYzhBUGI4?=
 =?utf-8?B?UC82Y1AzcXhhRi9LTDRjem9tREhqSWZ3a1R0ekdMVVM3dnFkd1QrWkFsWFh4?=
 =?utf-8?B?aE5tRHNyRml2OTc4TnRhOW9SRnIzQVZTdWpYT3NscnJGVXRTMVNEU1JRblNI?=
 =?utf-8?B?MUJqeWhOYlR2VFhRV1NydjNlZ2QzRWkvMytraU5vQkJTU25pM0VNQjlvUE1B?=
 =?utf-8?B?ZTg2Q0ZraHBLa2tKUWZaUGVxTThzSDJUR3FOcHhXSi9QT1o3UGE0eFVzNGwv?=
 =?utf-8?B?VXM1NHZhbndVMVJFaGhlZE9neW1JMkdWWmx5Z0M1dEFFbFo0NTFySkM5NWhl?=
 =?utf-8?B?TkkzYTRmQkkwOFFJVGN6NVV1S3lMT3ViUzliTU12MFV3VGphMHEyMmFxR280?=
 =?utf-8?B?cFhEcjhERkVNK2dlNEwwcmYrc2lWQ0E5bXBybm5tR3ZVZVdHK1hlbm0rdGZz?=
 =?utf-8?B?YXh1aGVYMEVLK29vN3VjYzQ4UG5vMGtnNzlVd3lXR0Q2aWFPSFRqUWJDK3My?=
 =?utf-8?B?U0d0a2E5MXdLdzhuK0VqaTFMYkFiR2xXblBuZzRBckp0aUFZV1VBb3U0c1BK?=
 =?utf-8?B?YXZkUmFSZDZ3aXhYc2g4aW1hbnl4NUdzaUpINThrREJxUzdvRGZPYzM1d2pa?=
 =?utf-8?B?NXlORHJwNFdDOXpFUkxrT0tQcFZPZTJHczVQZ0JTUjduT2VML1pwb3ZUMWdD?=
 =?utf-8?B?NzJBNVhpbDc2bG14Q0hmMDVXbHoyOCszWi9NbkVrWWh0TENkd0FkNUNIQWlJ?=
 =?utf-8?B?UEpXbHh0Yy9YbXVDdmoySzhueWdqV0dqODVzaHkxbTVlUDFkMURJeDJjUDRq?=
 =?utf-8?B?RFp6cXQzb3lSZFpMeFBJT2lzSUhjRlBHaHlxWjlJSDNiTzMwbkxOYmVsSDFq?=
 =?utf-8?B?K0JOSTV2ckpOTjhBcWM5QkhPanBFOUhuVnhCcXUzbkdyVzAvZWRNUGdGRzQ3?=
 =?utf-8?B?VHBIdFhpZytGanZaKzZOZnJ0d1VXaW8rcFRwL1ZpcVdBRGVlaUFzRTk1TFZ1?=
 =?utf-8?B?RWd6dHNLQzc3T1BsN3dUd2xKcVFUbm1OTXVKWm5NTG45OGp0U28zZXFIK2gw?=
 =?utf-8?B?ekFwY3ROU1M5eS8xempIeWNoTUhOYkY0emwyY3kwbXllWFR4WVFpZmgyY1Zs?=
 =?utf-8?B?UGUrbUFlNjZ4L1pFcnFxaDZIaWpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DEB689148ABB14D891BF8F120350CFC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab32c3b7-968e-4642-372f-08dca59a8d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 13:23:59.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cJQCaLN/FFEMI5Q93DJKPOIn49rbSJac1GQLzMam9DDmwMb8MWms+RcxkPugkkBoJTpb4LvnGVymvqhLEaJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4436

T24gRnJpLCAyMDI0LTA3LTEyIGF0IDA5OjU1IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBXZSd2ZSBvYnNlcnZlZCBORlMgY2xpZW50cyB3aXRoIHN5bmMgdGFza3Mgc2xlZXBp
bmcgaW4gX19ycGNfZXhlY3V0ZQ0KPiB3YWl0aW5nIG9uIFJQQ19UQVNLX1FVRVVFRCB0aGF0IGhh
dmUgbm90IHJlc3BvbmRlZCB0byBhIHdha2UtdXAgZnJvbQ0KPiBycGNfbWFrZV9ydW5uYWJsZSgp
LsKgIEkgc3VzcGVjdCB0aGlzIHByb2JsZW0gdXN1YWxseSBnb2VzIHVubm90aWNlZCwNCj4gYmVj
YXVzZSBvbiBhIGJ1c3kgY2xpZW50IHRoZSB0YXNrIHdpbGwgZXZlbnR1YWxseSBiZSByZS1hd29r
ZW4gYnkNCj4gYW5vdGhlcg0KPiB0YXNrIGNvbXBsZXRpb24gb3IgeHBydCBldmVudC7CoCBIb3dl
dmVyLCBpZiB0aGUgc3RhdGUgbWFuYWdlciBpcw0KPiBkcmFpbmluZw0KPiB0aGUgc2xvdCB0YWJs
ZSwgYSBzeW5jIHRhc2sgbWlzc2luZyBhIHdha2UtdXAgY2FuIHJlc3VsdCBpbiBhIGh1bmcNCj4g
Y2xpZW50Lg0KPiANCj4gV2UndmUgYmVlbiBhYmxlIHRvIHByb3ZlIHRoYXQgdGhlIHdha2VyIGlu
IHJwY19tYWtlX3J1bm5hYmxlKCkNCj4gc3VjY2Vzc2Z1bGx5DQo+IGNhbGxzIHdha2VfdXBfYml0
KCkgKGllLSB0aGVyZSdzIG5vIHJhY2UgdG8gdGtfcnVuc3RhdGUpLCBidXQgdGhlDQo+IHdha2Vf
dXBfYml0KCkgY2FsbCBmYWlscyB0byB3YWtlIHRoZSB3YWl0ZXIuwqAgSSBzdXNwZWN0IHRoZSB3
YWtlciBpcw0KPiBtaXNzaW5nIHRoZSBsb2FkIG9mIHRoZSBiaXQncyB3YWl0X3F1ZXVlX2hlYWQs
IHNvIHdhaXRxdWV1ZV9hY3RpdmUoKQ0KPiBpcw0KPiBmYWxzZS7CoCBUaGVyZSBhcmUgc29tZSB2
ZXJ5IGhlbHBmdWwgY29tbWVudHMgYWJvdXQgdGhpcyBwcm9ibGVtIGFib3ZlDQo+IHdha2VfdXBf
Yml0KCksIHByZXBhcmVfdG9fd2FpdCgpLCBhbmQgd2FpdHF1ZXVlX2FjdGl2ZSgpLg0KPiANCj4g
Rml4IHRoaXMgYnkgaW5zZXJ0aW5nIHNtcF9tYigpIGJlZm9yZSB0aGUgd2FrZV91cF9iaXQoKSwg
d2hpY2ggcGFpcnMNCj4gd2l0aA0KPiBwcmVwYXJlX3RvX3dhaXQoKSBjYWxsaW5nIHNldF9jdXJy
ZW50X3N0YXRlKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxi
Y29kZGluZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gwqBuZXQvc3VucnBjL3NjaGVkLmMgfCA1ICsr
KystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvc2NoZWQuYyBiL25ldC9zdW5ycGMvc2NoZWQu
Yw0KPiBpbmRleCA2ZGViZjRmZDQyZDQuLjM0YjMxYmU3NTQ5NyAxMDA2NDQNCj4gLS0tIGEvbmV0
L3N1bnJwYy9zY2hlZC5jDQo+ICsrKyBiL25ldC9zdW5ycGMvc2NoZWQuYw0KPiBAQCAtMzY5LDgg
KzM2OSwxMSBAQCBzdGF0aWMgdm9pZCBycGNfbWFrZV9ydW5uYWJsZShzdHJ1Y3QNCj4gd29ya3F1
ZXVlX3N0cnVjdCAqd3EsDQo+IMKgCWlmIChSUENfSVNfQVNZTkModGFzaykpIHsNCj4gwqAJCUlO
SVRfV09SSygmdGFzay0+dS50a193b3JrLCBycGNfYXN5bmNfc2NoZWR1bGUpOw0KPiDCoAkJcXVl
dWVfd29yayh3cSwgJnRhc2stPnUudGtfd29yayk7DQo+IC0JfSBlbHNlDQo+ICsJfSBlbHNlIHsN
Cj4gKwkJLyogcGFpcmVkIHdpdGggc2V0X2N1cnJlbnRfc3RhdGUoKSBpbg0KPiBwcmVwYXJlX3Rv
X3dhaXQgKi8NCj4gKwkJc21wX21iKCk7DQoNCkhtbS4uLiBXaHkgaXNuJ3QgaXQgc3VmZmljaWVu
dCB0byB1c2Ugc21wX21iX19hZnRlcl9hdG9taWMoKSBoZXJlPw0KVGhhdCdzIHdoYXQgY2xlYXJf
YW5kX3dha2VfdXBfYml0KCkgdXNlcyBpbiB0aGlzIGNhc2UuDQoNCj4gwqAJCXdha2VfdXBfYml0
KCZ0YXNrLT50a19ydW5zdGF0ZSwgUlBDX1RBU0tfUVVFVUVEKTsNCj4gKwl9DQo+IMKgfQ0KPiDC
oA0KPiDCoC8qDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

