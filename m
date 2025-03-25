Return-Path: <linux-nfs+bounces-10871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FDA70B86
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 21:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D287189F76D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89A0187FFA;
	Tue, 25 Mar 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="b8hph3RX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41271957FC
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934643; cv=fail; b=nzszSlZpGsZkrNHGthY0CeLuVpVe8kkfmsXuAGNSS6dozQJbXkfuV5DHhg+M3vSsHU6ENR37ss/s54i334cUDpiLxJsH8ukPcMJjzY9Vk3Q5VZOwTKrk6rIuMSJ0+A6JGoxXW4g3SorD+7xRS9w+dHUSPoD6if1XxaadRpuuT5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934643; c=relaxed/simple;
	bh=UTzvmlbBhpd5gA8CsmrHNlqwNXnD10agsrvQy1LR9Dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yj6o47YNW3pOy4HjBYdQfUAQ3eBhH2mxzppFw+3LpbK1r1AOEXvmMjxUiXQc4RfVAfxl9SJZWdaZkC+o2ZMIn/Tc71zbeQZigmh3xKHSpC6n8cyd/WR/Sz3J4QSNXb99tqqfUdUgCTmKK93Q9PS141de5+Sa/W8FA9dw58DeDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=b8hph3RX; arc=fail smtp.client-ip=40.107.94.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWvv+EPhEABrjRin5MvDCDGFfjM7RfwYw/cc6tUV2vtzJrGwSwK7boTVHOhSj7jGhCnRMQBLi7828Hrx4y8LjBsUCAFstZQInSCmKezla9uhPyM99VrEowOBE2Rbiv85O4upLY+aaF3uDT17dKqlPA6RDj+nVZWPR0nYzuSbDW6MLPAh/q4EOIaGqvmitK0RcBPRcL9RQXys/7i/eUgUYtYSIgZ+6s8Hb8qeseidr7ifRy/13dtJbqt9HwVAFCGvHXuqOUor/ujNXzFETP85gLWHUr2A4SNXw+8efANcFjrchl1pbX9Du1cVst3/RTWrtWl3wttirUwRatB2DOOszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTzvmlbBhpd5gA8CsmrHNlqwNXnD10agsrvQy1LR9Dk=;
 b=Q7aFAese5GFeN0+D77RBPkozPV6IF3bd/RduzVZYmnl2/cUO4jneQ3RDjRpGDAJ7foxJj4tOHWP1cjgzaYbsFOpfzzARhUbTVRifnxR/+n49CNrgPfwIQbRHgn9zGFAv2H2fHHawmHa0jTHihMp9awNaJYN54yWs9SC+x+h8MS87DCX8AvQbW9gPZ3xCsafB6bzPqCq084MAOuQyhkWkOin5p0f56XwhF7OEgqpXWf8zotQk+VafdIVGHPAyI0dcGZ3g14JNkSplDUdha2a2Os8jOhWc2DU3UXVMn8qZusVwOFkRMceLJbNo3u4y+R7XyNmKOgdo+/EltRVc/bi4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTzvmlbBhpd5gA8CsmrHNlqwNXnD10agsrvQy1LR9Dk=;
 b=b8hph3RXJEwlCDyGalL2GvRF2e69pxLGnvTxjbVKkp8mfbpYauc+ilIyopaBmK3GBh5ekdS7MBndD+AaI5RXtyQl/QLrGzkGugwHbd9FLADlH9fVrtXYmxdo9xdym+DMqMg8kP+D5p4gnaBdB48c0RhyeuoXy+MTyS9PODdSmwk=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4054.namprd13.prod.outlook.com (2603:10b6:208:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 20:30:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 20:30:37 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "bcodding@redhat.com"
	<bcodding@redhat.com>
Subject: Re: [PATCH v2 3/4] NFSv4: clp->cl_cons_state < 0 signifies an invalid
 nfs_client
Thread-Topic: [PATCH v2 3/4] NFSv4: clp->cl_cons_state < 0 signifies an
 invalid nfs_client
Thread-Index: AQHbnaGz3iZvUDZepUa3HVS9khkBf7OEI+0AgAAN5oCAAA98AIAADPQA
Date: Tue, 25 Mar 2025 20:30:37 +0000
Message-ID: <3d8ae18a092c3720a42b7b9ff5480065eb29ad91.camel@hammerspace.com>
References: <cover.1742919341.git.trond.myklebust@hammerspace.com>
				 <56bc4d7e614a6d9d0aa520c71bd0ffb102e3ef08.1742919341.git.trond.myklebust@hammerspace.com>
			 <202d8ae85ba2b1cfb454356a2781ef5b31ff37be.camel@kernel.org>
		 <bbfa25ef22c7b7b826d91d8cad71b5de2590ec92.camel@hammerspace.com>
	 <2146465da4d77595aa9876cfc4b636898f08c96e.camel@kernel.org>
In-Reply-To: <2146465da4d77595aa9876cfc4b636898f08c96e.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MN2PR13MB4054:EE_
x-ms-office365-filtering-correlation-id: 401be72a-1865-4878-7818-08dd6bdbe734
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vk1YTEhGZkxUZ0NwTkl5QldEemVsMzEzMUwzb0RyTFJmRVh6dWtwdUJLZ1l1?=
 =?utf-8?B?VlFWWTBXQ3hBRW9Cd0g5dVIvMitZWG1jU1dEVzAvL3BmM2YreFRtb0tzYkpE?=
 =?utf-8?B?UXFSSU9QenhkTWQyY3NyWHJSalFVSE0rdisrYlROeFM3aHBKQVl2NlFwZE9Z?=
 =?utf-8?B?NEV2L0YwTVJUc2xsUEVTNjhSSmorOGFBRklkOEF6UWExMVNFTzRySUVYa3p4?=
 =?utf-8?B?a3FHRW9WVEtabWtIeDFLZDJmUGlYK0g0UlNJMlZzcGhyL2RKWEcwdnowTzNC?=
 =?utf-8?B?cnc3UFNGS2RremErQXE0RkpjYkhBSmNFSTZ4dHZIZk1DRXh5VS9wblp4YU81?=
 =?utf-8?B?K1F3Zkx4Yzc4TU12bERIcG51MG1FL2wrTERaRGR1cENhRDh6ckZ2Q2wxR2Vt?=
 =?utf-8?B?amp4czQrelVIaVc0d2E3YzkrZUV3OW9QUFczcUJmVGQyQnVkdmFocGFKMGF2?=
 =?utf-8?B?QmZLVDB1TkJ3YzZJSXZWNm9kZ1VEOUZtOFlOWlhaUUFkdzRKWHh1a0JTSUpz?=
 =?utf-8?B?UERIZGI1SnZQeWJKTTQzTlVwbEYrc21rc0Fza2dTSjRDWHg2TnNEamJtR29v?=
 =?utf-8?B?ZW5QNER5YmpvNFpTTFJ3eVFCdGM3aEtHQzRxNzczQzNia250UDJMV2x2RXVL?=
 =?utf-8?B?c0NJQzJSYU9mR0tUY0pJRVYzRUVweVMvbU9vcDE2MUFnVHNDWnRPcTZFZHRC?=
 =?utf-8?B?YTBiWjRFbjJXYzFXc285TnNTcWpuRStQTlFrUjN1UlpwbDVZTm9scmhBVThs?=
 =?utf-8?B?V09oOTdNY0NhWXkyOU80RmRzRlI2RHFEaU1tZnZVL0FnMitUOE1JUUpFRVU2?=
 =?utf-8?B?VTRYRUxpMnpPaS8wcXpMbWFDaC9rZUE4ZDNIZzRkUnB2UlNsM3U0V2NHTm9o?=
 =?utf-8?B?UE80QklBbU8ydmtXSlRoNWVyYWNnYjRhaitkL2hSckJMLzFIZ1JEeXpoL2c5?=
 =?utf-8?B?eEo0SjBKYW4wU2VkRFdsS3NSNFg2RU5iQU9DajRKVGdNNTk0S3U1cUZiYldY?=
 =?utf-8?B?UGx6ZktaeVhOb054RWJhZjUvYzU3MTdJbmtaNjVrOGl4c2lFWmljT3ZUd3ZP?=
 =?utf-8?B?NFJZNmZqRDZzU3Vlc3g5ZVo5azJBSlQ3VXlTNDNRVUJ1YnEyQlI4VUN6NUR0?=
 =?utf-8?B?WXhJMlkzWXRVelpCejR2K2REdUF6YTJLSlhtdzJmaklqSWdpTTVZMFhReWpL?=
 =?utf-8?B?N3VQTSt3L2tQYndFSW44M3B5Z0hKZ3BTRGJoSEpqK3NwMW5qdW4yYnlCZWRj?=
 =?utf-8?B?Z0Z3ZDF0V3BaY1Bzd0xGNnJRaE5uQXBqMlgyWEc3WEQ2WUZhOFQvbzNMcDZm?=
 =?utf-8?B?R0lvRnk1N3JNYmpDQmlJaENsdUM4ZVFuVVFvZHdGRC9OV2N6ZzI5UDhhb1d5?=
 =?utf-8?B?VkZncmRGNWp2U2pwZGtRSW9EejB1ZzlzR1VCNUFabk1Cci8xa0RTYURkRlRX?=
 =?utf-8?B?Mm9lUVc4SUFOb1o0SklxektrbXFnZ0pqNXJDK21WVzVBQlF3K29oNTZJa0NR?=
 =?utf-8?B?QTVoeTVLTGJLK01PTXlReE9zUnVTMk5leEh0S1hwNFJENTJXWCtmeGdLdmlH?=
 =?utf-8?B?emNZa2RxSGVwSmFxeWVRaEhnc05Sa0NhQ1greUgvTk9iOXNGUVYyVUx0cmpK?=
 =?utf-8?B?elFYU2gxT0E1R3pNYitTY3pZd3cwT0YxR3VObWk3UnBkaXdHQThmaDZUbTcv?=
 =?utf-8?B?TjhiUUpVdmZEc2xEYlVFbXpkc29abVhyY3Q3S1dObWY1ZHZlZnBHUSsxR2pO?=
 =?utf-8?B?R0d6ZW1BVVI0RkF0dk9VREhPQVcyNWdjS0gvU3BnSXR6bmFhWHZjSUc3MTBa?=
 =?utf-8?B?bERCWTRnZnRaUW9ZdEtadnFXKzN1R1ZpdENsNlArK28xLzhNam0zL29IYzFV?=
 =?utf-8?B?MlJnTGRLWUd5bVZjN01WZEtKa2Y0cHdJbnVFUzA1RWpmYmV0aU0veVQ1SjFW?=
 =?utf-8?Q?5W+t6qNgri8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OURzWDdZUGF5VTN3THd2elNVQzJ6NGJ2aWEzU012WlBMSm9Pbk4reWxURCt3?=
 =?utf-8?B?dVJ6alYyUjNTMzFxZ1hMTW96ZGxSVFZ4a2NuWmNWQkZEUVE3UG5aZEVDcGVV?=
 =?utf-8?B?WHdvMWhHaVpOZERhbkZGK2NFS1hkbFJ1T09MTlVieWJHZUVlMXNiUnhRQlBx?=
 =?utf-8?B?TWQwT1BKZFYrN0FUZ2tzYTBPUUliTXBOVGlDaGZLSjNHMFp3dnZ6U0E2UHNm?=
 =?utf-8?B?d2ovem1rMU5GRVNXSStHODM2N3hZWWp3eXYwa0E2NlNmQ2IrVFZhN3ZDQ1dU?=
 =?utf-8?B?LzBIUjgyYlhPK3d6OXJWQXF1TjdSNzkvRXYzL1dVWW15U0lKM1REYTBFbUhL?=
 =?utf-8?B?QWdVaitldmszcFJGM0NLaDE4WlR5RTlwRHBJa0hRTGZlbmRTbWdXUUNnZS9C?=
 =?utf-8?B?Z3RTRWF0c0pCMldXQWdYUGxYSEZjVXMybjdDSmJ0MS9ndWdXcjB0TEpTbS9U?=
 =?utf-8?B?d0ZObW9ZZ05POUQ2M1BxMWN2Q3lpb3pSRDRLMlBDcHRjL0h3ek5sdTc5Ri9u?=
 =?utf-8?B?VzZjRStrMWt0NFZnWnVXSm14Y0poWFcwYXhvb2FHZ3NtWkpGL0NTemlCL0lq?=
 =?utf-8?B?dkhWd1pmSFBmeDJsOTNCelBWbTB1SmtoRHYrbEJ4OFp5WDJUcEpkQUN2ZFpZ?=
 =?utf-8?B?czFXaEd3YndJUWZUTXAzV1E5TkFYU2dibWQ4bjY2S3VCYjl1WWs2RUtHQWpV?=
 =?utf-8?B?bjFqSDRNR3AxemoyL2xoQXJRSHFKY3J1VzFqbGMydkhKOVZMc0M0TjVuS0tQ?=
 =?utf-8?B?dENPeUd6MUhIRkpjVTJjSnlYNURMMys1R2V2UG4va2VoeFpHblBKSDNBRkZX?=
 =?utf-8?B?SmY5NzRZcWtFQU1uY00vcVVYOVZvYkdORUpEOW0xSzJOaEhQa1Q3ZWxzZ1Y4?=
 =?utf-8?B?SzZjSkZNeVBVNHRkZUVHTjRwUUpqQzZqTlNwM1dmMjJNbktmUnkremN1QXJQ?=
 =?utf-8?B?M2NuQ2NJUWpHZlk3Ym1oQXVXSWxxQVNBbWhOLzhCT0FtbnBteUN0cUtmQUsw?=
 =?utf-8?B?VkdvbWRCWGNnOTYrdEZrL2JZaThRYjZBOWU2c09TVTR4V3ROanVBZUhBejlS?=
 =?utf-8?B?eXRTNWR1RnQ0elhzblZUbzdEdDBWQUl0dHg4czhybUVJdzlQRDNrMCtXT3pV?=
 =?utf-8?B?M1FKZVB2R2NqMjQ2Y2JIVFlYRy8xbG9qeGg4OFBuZlRKWHRTK3p2Q1VaYmZU?=
 =?utf-8?B?Y3JoWEdoY29vRTYxUXBlT2k2WlQraTZyVWNNZ2JzajNRUXRqY2FicTBMZ2pu?=
 =?utf-8?B?UUxidE9oWmg3MGJvZExIQVh5Y1Y2Ukg2VS9kSXhhbmFmVEdESy9ubXBDM0s4?=
 =?utf-8?B?a1RvVkwyRzJlTjN0eG44a0llUnhUZ1ltU0RKbk40OVozZ2t0TGliR2tITGla?=
 =?utf-8?B?STdRZUhTa0tTU0NEOXhxWWVVS3VhOE9VOFhtZFhybk5OaktDK25Mc0FzbnRr?=
 =?utf-8?B?cFk4R25vK0lzTHhFR1g3Tjh3Qll6SmZTMEk4cFZtd1JOVDlNSzZoWlI1Rzdv?=
 =?utf-8?B?RURDSlpKeGEzRkZ0OHp1ZHJrVXFFU3JPakpLN0ZGeUlVcDlWbWdTT1BYSWlp?=
 =?utf-8?B?bjlsaVR0L0Q3c1UwOCtZL2FRaTVXa2VKQkgzU3VjamNlNTNxTURpQTkreVQy?=
 =?utf-8?B?ZDVDRlp4TjB3NUJ0eGVGY2VNSWZ0b0pMNlVUWTZFWWJLRm5qcVJ2YmRMbUhG?=
 =?utf-8?B?YW1Ca2ZpZkdyYjl3Y0wrYWRtdnk2WnYxSmNHTHFtYk9zYTd1cktVaDA3SmRm?=
 =?utf-8?B?N0RZdENzV1ZVRWtodnJQckZJQUxvVU5WTXdVQW9KRmI0ODNuWGxHdlh0enI1?=
 =?utf-8?B?aHVtY3RyRXBaSTFqS1BKellscXpkZng2MGJEcW1VNjFWNlRORVZ2U2lCcGVZ?=
 =?utf-8?B?dFRKaXBWVGMrbGM0VmU2TGhQUFdSYStLMjQxdzlZb1NXbHNoMkxlamRxQXNM?=
 =?utf-8?B?NFlxSTF5VHlyNExGOVdtTzdHLzJPajUzcXVwTlI2NXRjUFhIRGxFQ0UwTEZq?=
 =?utf-8?B?UGVrZlRqYzAvVDY3blpWWGhESjlFOEt0aHMxalh0RTVxeGx3ZENxbmM4WDBz?=
 =?utf-8?B?UXJ5c253YmhmY0xXVWs3L2Jnb1pUL2FGR0FjRlBBWW1TeEpPMGRwdG1kd0tU?=
 =?utf-8?B?dzlONEEvcENYTE1UaUxrZCs3UWU5ZFhJemFCWkpUaXk1SFBIV1hlT25NL1RY?=
 =?utf-8?B?c1RnWG9kbzUzZUtIV1N2RCs4dGl5cGVsckxwcmw5YmlZSlhGODIwc1JtNjhM?=
 =?utf-8?B?NmUxYlVYMnpHQlBXa0pKcUxpM1J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE7F4C00DBF1C54AABB9C81A7B66C063@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 401be72a-1865-4878-7818-08dd6bdbe734
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 20:30:37.7139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1d3xtkKSar4wxqhM1KN+5L4IZ78pouEnzwbRZif8xyeIHZuzk2zp71KKtOIy0eFPN5LIIvvydbwGTiZTKeSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4054

T24gVHVlLCAyMDI1LTAzLTI1IGF0IDE1OjQ0IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVHVlLCAyMDI1LTAzLTI1IGF0IDE4OjQ4ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gVHVlLCAyMDI1LTAzLTI1IGF0IDEzOjU5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIFR1ZSwgMjAyNS0wMy0yNSBhdCAxMjoxNyAtMDQwMCwgdHJvbmRteUBrZXJu
ZWwub3JnwqB3cm90ZToNCj4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgc29tZW9uZSBjYWxs
cyBuZnNfbWFya19jbGllbnRfcmVhZHkoY2xwLCBzdGF0dXMpIHdpdGggYQ0KPiA+ID4gPiBuZWdh
dGl2ZQ0KPiA+ID4gPiB2YWx1ZSBmb3Igc3RhdHVzLCB0aGVuIHRoYXQgc2hvdWxkIHNpZ25hbCB0
aGF0IHRoZSBuZnNfY2xpZW50DQo+ID4gPiA+IGlzIG5vDQo+ID4gPiA+IGxvbmdlciB2YWxpZC4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdA0KPiA+ID4g
PiA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
IMKgZnMvbmZzL25mczRzdGF0ZS5jIHwgNCArKy0tDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYg
LS1naXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiA+ID4g
aW5kZXggNTQyY2RmNzEyMjlmLi43MzhlYjI3ODkyNjYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2Zz
L25mcy9uZnM0c3RhdGUuYw0KPiA+ID4gPiArKysgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiA+
ID4gQEAgLTExOTgsNyArMTE5OCw3IEBAIHZvaWQgbmZzNF9zY2hlZHVsZV9zdGF0ZV9tYW5hZ2Vy
KHN0cnVjdA0KPiA+ID4gPiBuZnNfY2xpZW50ICpjbHApDQo+ID4gPiA+IMKgCXN0cnVjdCBycGNf
Y2xudCAqY2xudCA9IGNscC0+Y2xfcnBjY2xpZW50Ow0KPiA+ID4gPiDCoAlib29sIHN3YXBvbiA9
IGZhbHNlOw0KPiA+ID4gPiDCoA0KPiA+ID4gPiAtCWlmIChjbG50LT5jbF9zaHV0ZG93bikNCj4g
PiA+ID4gKwlpZiAoY2xudC0+Y2xfc2h1dGRvd24gfHwgY2xwLT5jbF9jb25zX3N0YXRlIDwgMCkN
Cj4gPiA+IA0KPiA+ID4gV291bGQgaXQgYmUgc2ltcGxlciB0byBqdXN0IHNldCBjbF9zaHV0ZG93
biB3aGVuIHRoaXMgb2NjdXJzDQo+ID4gPiBpbnN0ZWFkDQo+ID4gPiBvZg0KPiA+ID4gaGF2aW5n
IHRvIGNoZWNrIGNsX2NvbnNfc3RhdGUgYXMgd2VsbD8NCj4gPiANCj4gPiBEbyB3ZSBuZWVkIHRo
ZSBjaGVjayBmb3IgY2xudC0+Y2xfc2h1dGRvd24gYXQgYWxsIGhlcmU/IEknZCBleHBlY3QNCj4g
PiBhbnkNCj4gPiBjYWxsZXIgb2YgdGhpcyBmdW5jdGlvbiB0byBhbHJlYWR5IGhvbGQgYSByZWZl
cmVuY2UgdG8gdGhlIGNsaWVudCwNCj4gPiB3aGljaCBtZWFucyB0aGF0IHRoZSBSUEMgY2xpZW50
IHNob3VsZCBzdGlsbCBiZSB1cC4NCj4gDQo+IE5vdCBuZWNlc3NhcmlseT8gSnVzdCBiZWNhdXNl
IHlvdSBob2xkIGEgcmVmZXJlbmNlIHRvIHRoZSBycGNfY2xudA0KPiBkb2Vzbid0IG1lYW4gdGhh
dCBpdCdzIHN0aWxsIHVwLCBBRkFJVS4NCj4gDQo+IEZvciBpbnN0YW5jZSwgaWYgeW91IGVuZCB1
cCB1c2luZyB0aGUgInNodXRkb3duIiBmaWxlIGluIHN5c2ZzLCBhbnkNCj4gUlBDDQo+IHN0aWxs
IGluIGZsaWdodCB3aWxsIGhvbGQgYSByZWZlcmVuY2UgdG8gdGhlIGNsaWVudC4gV3JpdGluZyB0
bw0KPiAic2h1dGRvd24iIHdpbGwgc2V0IGNsX3NodXRkb3duIHRvIDEgYW5kIHRoZW4gY2FuY2Vs
IGFsbCB0aGUgUlBDcywNCj4gYnV0DQo+IHRoZXJlIGlzIGF0IGxlYXN0IGEgd2luZG93IG9mIHRp
bWUgd2hlcmUgd2UgaGF2ZSBhbiBlbGV2YXRlZCByZWZjb3VudA0KPiBidXQgdGhlIGNsaWVudCBp
cyBubyBsb25nZXIgdmFsaWQuDQoNClRoZSBzaHV0ZG93biBvZiB0aGUgbmZzX2NsaWVudCBSUEMg
Y2xpZW50IGhhcHBlbnMgaW4gbmZzX2ZyZWVfY2xpZW50KCkuDQoNCk9oIHdhaXQuLi4gQ3JhcC4u
LiBXaHkgaXMgYSBwZXItbmZzX3NlcnZlciBmdW5jdGlvbiBsaWtlDQpzaHV0ZG93bl9zdG9yZSgp
IHJlYWNoaW5nIGludG8gdGhlIG5mc19jbGllbnQ/IFRoYXQncyBib3JrZWQgYW5kIG5lZWRzDQp0
byBiZSBmaXhlZC4NCg0KPiANCj4gDQo+ID4gDQo+ID4gSSdtIGEgbGl0dGxlIHN1c3BpY2lvdXMg
b2YgdGhlIGNoZWNrIGluIG5mczQxX3NlcXVlbmNlX2NhbGxfZG9uZSgpDQo+ID4gdG9vLg0KPiA+
IA0KPiANCj4gTWUgdG9vLiBJIHRoaW5rIHRoaXMgaXMgcHJvYmFibHkgYW4gaW5kaWNhdG9yIHRo
YXQgd2UgbmVlZCB0bw0KPiBjYXJlZnVsbHkNCj4gYXVkaXQgaG93IGNsX3NodXRkb3duIGlzIHVz
ZWQgYW5kIGNsYXJpZnkgd2hhdCBpdCBtZWFucy4gTHVja2lseQ0KPiB0aGVyZQ0KPiBhcmUgb25s
eSBhIGhhbmRmdWwgb2YgcGxhY2VzIHRoYXQgcmVmZXJlbmNlIGl0Og0KPiANCj4gVGhlIGNhbGxf
c3RhcnQgY2hlY2sgaXMgZmluZSBJIHRoaW5raGh1aGRsamtmamx0a3VkZGpyaWcsIHRob3VnaA0K
PiBtYXliZQ0KPiB3ZSBzaG91bGQgYWRkIGNsX3NodXRkb3duIGNoZWNrcyBpbiBsYXRlciBzdGF0
ZXM/IFRoZSBvdGhlciBwbGFjZXMNCj4gdGhhdA0KPiBjaGVjayBpdCBjb21lIGZyb20gdGhpcyBj
b21taXQ6DQo+IA0KPiDCoMKgwqAgNmFkNDc3YTY5YWQ4IE5GU3Y0OiBDbGVhbiB1cCBzb21lIHNo
dXRkb3duIGxvb3BzDQo+IA0KPiBTaG91bGQgd2UgY29udmVydCBib3RoIG9mIHRob3NlIGNoZWNr
cyB0byBsb29rIGF0IGNscC0+Y2xfY29uc19zdGF0ZQ0KPiBpbnN0ZWFkPw0KDQpZZXMuDQoNCj4g
DQo+ID4gPiANCj4gPiA+ID4gwqAJCXJldHVybjsNCj4gPiA+ID4gwqANCj4gPiA+ID4gwqAJc2V0
X2JpdChORlM0Q0xOVF9SVU5fTUFOQUdFUiwgJmNscC0+Y2xfc3RhdGUpOw0KPiA+ID4gPiBAQCAt
MTQwMyw3ICsxNDAzLDcgQEAgaW50IG5mczRfc2NoZWR1bGVfc3RhdGVpZF9yZWNvdmVyeShjb25z
dA0KPiA+ID4gPiBzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyLCBzdHJ1Y3QgbmZzNF8NCj4gPiA+
ID4gwqAJZHByaW50aygiJXM6IHNjaGVkdWxpbmcgc3RhdGVpZCByZWNvdmVyeSBmb3Igc2VydmVy
DQo+ID4gPiA+ICVzXG4iLA0KPiA+ID4gPiBfX2Z1bmNfXywNCj4gPiA+ID4gwqAJCQljbHAtPmNs
X2hvc3RuYW1lKTsNCj4gPiA+ID4gwqAJbmZzNF9zY2hlZHVsZV9zdGF0ZV9tYW5hZ2VyKGNscCk7
DQo+ID4gPiA+IC0JcmV0dXJuIDA7DQo+ID4gPiA+ICsJcmV0dXJuIGNscC0+Y2xfY29uc19zdGF0
ZSA8IDAgPyBjbHAtPmNsX2NvbnNfc3RhdGUgOg0KPiA+ID4gPiAwOw0KPiA+ID4gPiDCoH0NCj4g
PiA+ID4gwqBFWFBPUlRfU1lNQk9MX0dQTChuZnM0X3NjaGVkdWxlX3N0YXRlaWRfcmVjb3Zlcnkp
Ow0KPiA+ID4gPiDCoA0KPiA+ID4gDQo+ID4gDQo+ID4gLS0gDQo+ID4gVHJvbmQgTXlrbGVidXN0
DQo+ID4gTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiA+IHRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCj4gPiANCj4gPiANCj4gDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0IA0KQ1RPLCBIYW1tZXJzcGFjZSBJbmMgDQoxOTAwIFMgTm9yZm9sayBTdCwgU3Vp
dGUgMzUwIC0gIzQ1IA0KU2FuIE1hdGVvLCBDQSA5NDQwMyANCuKAiw0Kd3d3LmhhbW1lcnNwYWNl
LmNvbQ0K

