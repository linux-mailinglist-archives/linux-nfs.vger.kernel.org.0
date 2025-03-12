Return-Path: <linux-nfs+bounces-10572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B9A5E77B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F6189F7CF
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B11EE7C6;
	Wed, 12 Mar 2025 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZCauHJf3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2097.outbound.protection.outlook.com [40.107.223.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78541DFD95;
	Wed, 12 Mar 2025 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818716; cv=fail; b=ZWc/RIsoL0NHYU3CikO+A7a0JY8GN0z28SmXN3rgTTHLfSUlg8GrhBAXP5mjyYrfpR0FeRqcuqcMUkmFPWFoYonp6f9N9izQXmD2rDdhqKLUlxd7eB3XYnxqqLFh2+BV/0Gab2SvikGnc+O2CmFeEdaXJBZ5JagLkCVCysWHsXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818716; c=relaxed/simple;
	bh=VcBhT7dyIaewRLkwccSFLzMsqhL1tidW37HCaifJ3Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rcKgvo2xd7S9mSAvD/tabq2J7MnT4kCSanSrJE6qwbFgGwrpz2AW9qhLFsrLq/05Dl4RgCyxajP0NpnHJ8800xsJtxItn+kzN/R+CzA6PqbIRFZtEZh6o79p61F8uQcQykxHasC67roIqkkch3P4xXKNbxvS2Fc/koArbuMF1HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZCauHJf3; arc=fail smtp.client-ip=40.107.223.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wq/I6Ba51q6CAtbK9fmVCNFflde8bDYXH40Tht3bxiKa8uSST/sKFdit8MU9PTKuzjSa/CDbL42VoUAZ5NzLmdrcKc0A1LH3U9QTRWGUfLzRYWyl2WLrRFfWJmhkB4wssU2kdg2YP+BpIhoEgAQBFyCYJFjz7GAMvGdnMFA4DMdyxcI4zA8Wdh7ENZ42mywi0ELgEjzifl0ahB9SxlGl+UL55/c2W4GrNe6sopX4asiDgWXekq1XJ2/SW7LyIOJAub44EgpZhGV6QFCtH1aVS8dPsPG6lHlh31p1ThAjniW6194E1uGKE6fO43TASYty3vTNqz1hUzPHtbVBC6IsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcBhT7dyIaewRLkwccSFLzMsqhL1tidW37HCaifJ3Ss=;
 b=APnXlghZSRJRRH1j0zQdW8PrWtFoYv35hbq3LNni0ovu7+wu1N5S/YxJH9Eu9loh4TQrpr+d17BEYMfKAdkjucBbJ1nsR4TKLaRUkqD6e2SUWqef8HO5NGrYlX5z2dRInuL6sT4oyLeQt4pwCP5/emwiXUVUfOeJGKyEvMWdnTNpZw7Sutkc7pUDF8oFFP4Iz7nSodwgmSJ1jmxYxBSlxgOl6fb/iYtXv7WzfhjAayFq9IkYK/vIKkppsqJn1NV8rO5J9d5u0+1GljIdR5qbJU4RR8lpL62+TWCip+Zv7KiV7+A1+KRMlU0YpCHh5MrPzCqrmuWQzy+yZFwrraWSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcBhT7dyIaewRLkwccSFLzMsqhL1tidW37HCaifJ3Ss=;
 b=ZCauHJf30jzKHQ6l6e2faELghSLXGpfev4QwVHQIrTA/gyIveslsktz45h76QgxpMr6FsS9H3hPwzVcg1373hlsJvWpecnv54u1IBV/o7pnG4xMRsP7sM6S0hnEPcq0ywrXtyJVwRZ93IH0i0raNPqVy/ImPVRifyfUMQzz6ApY=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by CO1PR13MB4872.namprd13.prod.outlook.com (2603:10b6:303:f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 22:31:49 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::b148:fe5d:ff6a:6310%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:31:49 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: add a rpc_clnt shutdown control in debugfs
Thread-Topic: [PATCH] sunrpc: add a rpc_clnt shutdown control in debugfs
Thread-Index: AQHbk1PiR4iwcdz1fk+nPyEdeeSYhrNvhXGAgAAMbgCAAISOAA==
Date: Wed, 12 Mar 2025 22:31:49 +0000
Message-ID: <8bf55a6fb64ba9e21a1ec8c5644355ffd6496c6e.camel@hammerspace.com>
References: <20250312-rpc-shutdown-v1-1-cc90d79a71c2@kernel.org>
		 <7906109F-91D2-4ECF-B868-5519B56D2CEE@redhat.com>
	 <997f992f951bd235953c5f0e2959da6351a65adb.camel@kernel.org>
In-Reply-To: <997f992f951bd235953c5f0e2959da6351a65adb.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|CO1PR13MB4872:EE_
x-ms-office365-filtering-correlation-id: 5f9328d6-8b25-4c64-c961-08dd61b5ae22
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blUyNnNFNnN2OHh1VHBJck14am9KekhWN2FNTzQwNUU5ckpTb0ZieVhsVU5q?=
 =?utf-8?B?WGZBMGQ3RVZmRE95WFY3Rk9uQW5QWnlscDRSYVlIOGg4bExXVmg4VU90bDhZ?=
 =?utf-8?B?V05VR3JoWjRjUTRINVdvUmgyWXlUY0c2Uit5L0gyeTIwOHVIUDYwZXJlY2t1?=
 =?utf-8?B?R1hWN0J2akc3ZDJWTnpRY1dRcGVaaE5UTHpkVGNHTDlBRXhPS0lKT25lbkRi?=
 =?utf-8?B?TmJkM1NGaHNnQjRveTJVMDdiYXZYRCt3c2QyODR0RFBxdlp4eDgrMEw5QXFn?=
 =?utf-8?B?ekh1V3ZPemR4d0FvSkFzVlp5Z08zWDM4bVhEK3hJdFVtVzVXaDhMUHVOZHZX?=
 =?utf-8?B?OERYN0EwL2RNOXVxcjZBYmFMR3BjdVJmRkoyYzRINWFjaHc0eUZ2bGsrYngy?=
 =?utf-8?B?di9OdHA1RGVNWjVGb1c3V1I5T2lEc3dMNW9Kc0Y4NU8yNzFaSWZWME5Dakh3?=
 =?utf-8?B?Vm8xN3YyQ1E0U0RlWnBQekdURWl5cEZrUzc3THY3WlBwZTNkV2l0T1ZHNjNM?=
 =?utf-8?B?V3JOTnFaNitUc29YQjlvVVJGUjUzNEc1elYxdWhrUElYM1c5Q1YvOWZLSVlX?=
 =?utf-8?B?aXhheFY2b01RRkR4M21ZcFRmMmpJeTBudGVJMXVHY0VzYlQyM2laZkdHWUFk?=
 =?utf-8?B?a2F3cVU3K3lGTFZQZ0FaVkpGNFlnMEIwaXh6Um42RktPTTk5aFhIOG9wYlhV?=
 =?utf-8?B?N1huTXNmSGE0K0xaWldNeUE4cDQ4eE1tcUVPY1ZUSTh3TGVMeU5YeDQzSHhQ?=
 =?utf-8?B?UlMxK2dnRHp0NDZ2UDFtc21vM3hnV3h2S1A0d3ErdThBOGhNZWNSdDFualNq?=
 =?utf-8?B?a0lYeHdONGFLUDE5allpeG5Dd2dsMjRLbHptMEhRanVycmlmU2dNREt4cy9L?=
 =?utf-8?B?SlB6dytpYVZFei9DdTZtcXJpbCtGK3krK25BT1JYdUVoMGtMSzcrUm8zaHN6?=
 =?utf-8?B?UllaazQ1UjBySmZYU1VNdGU5bTcxUGVScW55ejNCQUxkYk5Odjk2TndZVTlQ?=
 =?utf-8?B?azhlN0xCSmpUNDRVcjRCZ0g1Z0o4TGwwejNXVzVnOWZQNUxKanBHUGJ6VUtE?=
 =?utf-8?B?T1BTMzdiNzNkTXMrbC9MVk16eFE3bncrMXllRnNDS3pMKzlvTVlGS3NEdFcw?=
 =?utf-8?B?QVpCcnUzTDkzUmo0VWJEZThFWVdUaG9LQmd5eW04UGFxOUJsSDhhODNKZ2FP?=
 =?utf-8?B?RjVEbHF0RmRZMGpwQ1Njc3UwUk01OVJQVUJ1cG1UOGVwNXBaa2ZIV3ZzNXZj?=
 =?utf-8?B?c2l3KzE4RmxOTU5SL2Q5OG0xcWttWjE2Uk4wV3JzUnlWYzRreGo1OGFkZkNh?=
 =?utf-8?B?M0V4ci83VmErL1ZsWWZrcUc5NXdveEtvMTQvQlFDZnJzYnNyTmYweDVnbXJ4?=
 =?utf-8?B?YnNMek4xa3l1YlVBTFd3Qkc3dWVRRW1OZUoyNlBlbkxsU2MzR3JZZC90QUlz?=
 =?utf-8?B?dmFVNVUwcEFOK3VRd2p2alllMzJteFJQZUNVN3JDZ05IbEFtV1hSUDBoVFY5?=
 =?utf-8?B?MHFQL0tkZmF3cGxiOXVFaFhSd3YxZFRucGJhcjZKQ2syVTdVOTlwMzBzeEZE?=
 =?utf-8?B?TStFT21aamkxSDJkc2VmVzNBc2QwUkYrNkJJUlNyZTAyREdRVVlZN0l4TElJ?=
 =?utf-8?B?VEhhTjNjNkZnN1lWVFVmVGJQR1lwRkpKVDdUUDh6YW9PL1JLSTAvZWIrQjZB?=
 =?utf-8?B?VFBLVXltZUFOelllQlE1MFUvMkRDWXJRUkxQc2MrbHIrNXl2M2Zza3hRb2Vw?=
 =?utf-8?B?V0wyT3ZKZHZyL3NCSFBNVjE5aXJYT0xkeUVwT2NJK25IV1gwWUNRVWlISVlY?=
 =?utf-8?B?QkFyK3JScmxBWkZEMHJZMTJmN0o3SUpZV2I3Wk1SaHIyQ2hpa2ZDRXY1Zlp5?=
 =?utf-8?B?YVRseHFRTDFxOGgvaHh1eVorS2NsZVdNYWN6Q2lsbEFlODZOazNVNWluR1Zz?=
 =?utf-8?Q?cZKkwJwnWeWzhzM7zODAzUQlM6s99OCd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0hBOFQ5akZGUmoxVWhNNFUreE44a0dQVEl4b09BZ05kSDhRdWNiN2NuSENv?=
 =?utf-8?B?M3U0ZDJlVFhILzJ4b1lXYi9abTRyVG9IaUJxWFBPaVhFTlR5VkJpR3R0K1lZ?=
 =?utf-8?B?Rk01VCtKUEEwTG5wenp5d0V4SVAxc1ZNZk91eDFGMHoxWkF0OXFyRUkzZlRU?=
 =?utf-8?B?Y2E2OW1lQW15eGxqNkVaSzdvNXk4VGpLS21ibjZRSXFpSGV2WVBDOEFGcXdR?=
 =?utf-8?B?bzdFREw1QkxrVE8ydi9yK0JZSUpVOVg2OXpRRVlNR2oxTW1TV1lCcmVhQmZQ?=
 =?utf-8?B?SEhQTk9YQmxYVVNPWEN4cDFnWWVjTVFiaUhGWGQyMnVOVXdNYlVmS2NFZ3dP?=
 =?utf-8?B?Z1Nva3JldkxtZWNsUW9rdWtHNkZ1QUU3UTJoS2E0NHUzdkxpOHdpRzJ3WjRK?=
 =?utf-8?B?WEc2cWN2ZVpSYmRyRW1WL3NEbmorWExQRWJPTUJUMDJwOFVQL2Z0c1RFSk9s?=
 =?utf-8?B?d1E1ZVFDZ2tmaEZ0NFowNFNJQWduY09Oa3A1TFZEU21nNXl6TEhkaXhnVGQ3?=
 =?utf-8?B?TVl3TG8vWjdoS2FqWDlWT1V1OXBweFdvZmJLUCs2YlhxTHIwSkw1Y3NPZDZa?=
 =?utf-8?B?aHdrV2g4QXg2a2tXWGJUSVZRU2tjQ1BSTzl0N0NaMERsLzB1WCszS2g3VXVu?=
 =?utf-8?B?bEZpczR4V0k3NXQzYWM4MFR4NkJLVzc5UFZveTJ3TURmVEdRUU5remIwZ005?=
 =?utf-8?B?K3EyUzNKd1k3N2RvOEVmWG1ReGFFcldVaVV4a0lvOURBVENyZENPdFcyMUNR?=
 =?utf-8?B?ZW5pL05ZK0pBZk9ZVDJxU0l5a2t4NVJlMkZHTEkwYzdGOFVnY1FiUlBXRlFM?=
 =?utf-8?B?N25jZW5WYTNpZ29GbmQrWWpRNU9iRXlLQ2p0VDJnQ3FMSS9BeWg5dVRYSURI?=
 =?utf-8?B?bDlHNmlnWjJqelIvV05YVThWaUVjSlIvanNwVHpVK2FkaXg2NlVvYklHZFBj?=
 =?utf-8?B?VWhSOUVOb2NOOC9FdjJzL2o3eXlKM0x2cWRXQ3lwMGc4cExrVHJXZDBZa0hW?=
 =?utf-8?B?WEhIRk04VHMzWUV4cHBLeGlhZjlCSEZZTTh1QUNQQ2haS01iMWJySFE3M3dr?=
 =?utf-8?B?bEt1T2Irckxqc2Y0cVc2SHMzWUZHQmNwNXFzM016dEZPYmtvSUpEQjlCRDRY?=
 =?utf-8?B?Y1EzY21TSVRxZWhqSjIyMjZDVG1uS3gyZU1xYnFlKzRjU2p1MHhtM2YrMnFl?=
 =?utf-8?B?MnZtZlFvN3Jlemp3UFFnY28xVFJ4UVc1SG41N3lQUjJVanlnRHZ3UWZZL1pq?=
 =?utf-8?B?YnNFbURiUmpGNFlXVC9QNUFuVkdzWm9qUWRXM0hjeWlISkhLV2ZsUFNWbCtn?=
 =?utf-8?B?djhiTVZCaExURDZtN3BNeU1PdElHWERNNWlYdVZyZTk0UzBEOWlNc2hDeWdO?=
 =?utf-8?B?ZFExcGZYWWxpZ0NaaHgzMFBoNHJIK2xvSVJmQTFkajlnMlFZYUZZb0NKUC9Q?=
 =?utf-8?B?WURDU1hCTjN6SkRYSW9jQW1TR2duYVlJdGhMc016UTNpcWlPUmEzeFlCMzlI?=
 =?utf-8?B?ZEhQRlNTd25RbUJPbEJLRTlPS0ljcXJWODJ2Qi9mcUlRNk03czZBQ3NhME9k?=
 =?utf-8?B?Vy9xOXg0UXN4RjlEOWMzakhQNlJTaXhyak1tMVdqME5VUEt1T2E1TjZwSk1j?=
 =?utf-8?B?UnRyVldNczJnTDBzcDNFdCtXRmo4enVFOXNDQ0VBdFNTTTQ5ZlVoaWd6YmY2?=
 =?utf-8?B?R2YvY0h0SjFvSVhkUWpoZ2VtVWd2ZWxldGgvcG5mQm11ekVlalgzdHEycEt1?=
 =?utf-8?B?M01QcklEU3RvSTJHdXRPaE5VVHBaU2pDNTZtM1dUM000NFl0SWlldVZUcjBJ?=
 =?utf-8?B?a3ZRQnVJNktRWWlQUkhlNzVRZHpsN1Y2dWhmVWJzcXJWQWx1WURxbVduMFVn?=
 =?utf-8?B?K3VCSEJiNGxwYmNZMXZkZjg0eXJMSWRkaGc1b2ord0tLNkt0elAxdmtSYUE4?=
 =?utf-8?B?UEVSMTYyZEowYTJCRFNpNDJHa0JsMFlxMjZOT0V3bGN3T2s2Z1NBckFNRkhw?=
 =?utf-8?B?QVZJMitmbzhnZ09tWEZ5MHl6bXd3V1hxR3RLbDEzQlB3a201NWNrVmRyNCtR?=
 =?utf-8?B?KytPOGZ0YXlPbW5kaGp5OXdhK3lYY3NYN0h5eFc3WU1MTTU4b3RIdk1iSSto?=
 =?utf-8?B?MHNldzh4NnZ1Mi9IcGtISytoNXFqZFc0RjB2dUhiZjhHV01Ta1cvYjREM2RH?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <809230536F19354B866E6E20DA35FE2A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9328d6-8b25-4c64-c961-08dd61b5ae22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 22:31:49.4503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZBD5aDE/swqhLbO6ouUTcRgho4j8Wa1wb496dcM/BGBpEWrDJdeYOXY3N72Cc+lb00/CdrS03fv6j11ByZAGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4872

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDEwOjM3IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gV2VkLCAyMDI1LTAzLTEyIGF0IDA5OjUyIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiA+IE9uIDEyIE1hciAyMDI1LCBhdCA5OjM2LCBKZWZmIExheXRvbiB3cm90ZToNCj4g
PiANCj4gPiA+IFRoZXJlIGhhdmUgYmVlbiBjb25maXJtZWQgcmVwb3J0cyB3aGVyZSBhIGNvbnRh
aW5lciB3aXRoIGFuIE5GUw0KPiA+ID4gbW91bnQNCj4gPiA+IGluc2lkZSBpdCBkaWVzIGFicnVw
dGx5LCBhbG9uZyB3aXRoIGFsbCBvZiBpdHMgcHJvY2Vzc2VzLCBidXQgdGhlDQo+ID4gPiBORlMN
Cj4gPiA+IGNsaWVudCBzdGlja3MgYXJvdW5kIGFuZCBrZWVwcyB0cnlpbmcgdG8gc2VuZCBSUENz
IGFmdGVyIHRoZQ0KPiA+ID4gbmV0d29ya2luZw0KPiA+ID4gaXMgZ29uZS4NCj4gPiA+IA0KPiA+
ID4gV2UgaGF2ZSBhIHJlcHJvZHVjZXIgd2hlcmUgaWYgd2UgU0lHS0lMTCBhIGNvbnRhaW5lciB3
aXRoIGFuIE5GUw0KPiA+ID4gbW91bnQsDQo+ID4gPiB0aGUgUlBDIGNsaWVudHMgd2lsbCBzdGlj
ayBhcm91bmQgaW5kZWZpbml0ZWx5LiBUaGUgb3JjaGVzdHJhdG9yDQo+ID4gPiBkb2VzIGEgTU5U
X0RFVEFDSCB1bm1vdW50IG9uIHRoZSBORlMgbW91bnQsIGFuZCB0aGVuIHRlYXJzIGRvd24NCj4g
PiA+IHRoZQ0KPiA+ID4gbmV0d29ya2luZyB3aGlsZSB0aGVyZSBhcmUgc3RpbGwgUlBDcyBpbiBm
bGlnaHQuDQo+ID4gPiANCj4gPiA+IFJlY2VudGx5IG5ldyBjb250cm9scyB3ZXJlIGFkZGVkWzFd
IHRoYXQgYWxsb3cgc2h1dHRpbmcgZG93biBhbg0KPiA+ID4gTkZTDQo+ID4gPiBtb3VudC4gVGhh
dCBkb2Vzbid0IGhlbHAgaGVyZSBzaW5jZSB0aGUgbW91bnQgbmFtZXNwYWNlIGlzDQo+ID4gPiBk
ZXRhY2hlZCBmcm9tDQo+ID4gPiBhbnkgdGFza3MgYXQgdGhpcyBwb2ludC4NCj4gPiANCj4gPiBU
aGF0J3MgaW50ZXJlc3RpbmcgLSBzZWVtcyBsaWtlIHRoZSBvcmNoZXN0cmF0b3IgY291bGQganVz
dCByZW9yZGVyDQo+ID4gaXRzDQo+ID4gcmVxdWVzdCB0byBzaHV0ZG93biBiZWZvcmUgZGV0YWNo
aW5nIHRoZSBtb3VudCBuYW1lc3BhY2UuwqAgTm90IGFuDQo+ID4gb2JqZWN0aW9uLA0KPiA+IGp1
c3Qgd29uZGVyaW5nIHdoeSB0aGUgTU5UX0RFVEFDSCBtdXN0IGNvbWUgZmlyc3QuDQo+ID4gDQo+
IA0KPiBUaGUgcmVwcm9kdWNlciB3ZSBoYXZlIGlzIHRvIHN5c3RlbWQtbnNwYXduIGEgY29udGFp
bmVyLCBtb3VudCB1cCBhbg0KPiBORlMgbW91bnQgaW5zaWRlIGl0LCBzdGFydCBzb21lIEkvTyBv
biBpdCB3aXRoIGZpbyBhbmQgdGhlbiBraWxsIC05DQo+IHRoZQ0KPiBzeXN0ZW1kIHJ1bm5pbmcg
aW5zaWRlIHRoZSBjb250YWluZXIuIFRoZXJlIGlzbid0IG11Y2ggdGhlDQo+IG9yY2hlc3RyYXRv
cg0KPiAocm9vdC1sZXZlbCBzeXN0ZW1kKSBjYW4gZG8gdG8gYXQgdGhhdCBwb2ludCBvdGhlciB0
aGFuIGNsZWFuIHVwDQo+IHdoYXQncw0KPiBsZWZ0Lg0KPiANCj4gSSdtIHN0aWxsIHdvcmtpbmcg
b24gYSB3YXkgdG8gcmVsaWFibHkgZGV0ZWN0IHdoZW4gdGhpcyBoYXMgaGFwcGVuZWQuDQo+IEZv
ciBub3csIHdlIGp1c3QgaGF2ZSB0byBub3RpY2UgdGhhdCBzb21lIGNsaWVudHMgYXJlbid0IGR5
aW5nLg0KPiANCj4gPiA+IFRyYW5zcGxhbnQgc2h1dGRvd25fY2xpZW50KCkgdG8gdGhlIHN1bnJw
YyBtb2R1bGUsIGFuZCBnaXZlIGl0IGENCj4gPiA+IG1vcmUNCj4gPiA+IGRpc3RpbmN0IG5hbWUu
IEFkZCBhIG5ldyBkZWJ1Z2ZzIHN1bnJwYy9ycGNfY2xudC8qL3NodXRkb3duIGtub2INCj4gPiA+
IHRoYXQNCj4gPiA+IGFsbG93cyB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5IGFzIHRoZSBvbmUgaW4g
L3N5cy9mcy9uZnMsIGJ1dCBhdA0KPiA+ID4gdGhlDQo+ID4gPiBycGNfY2xudCBsZXZlbC4NCj4g
PiA+IA0KPiA+ID4gWzFdOiBjb21taXQgZDk2MTVkMTY2YzdlICgiTkZTOiBhZGQgc3lzZnMgc2h1
dGRvd24ga25vYiIpLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8
amxheXRvbkBrZXJuZWwub3JnPg0KPiA+IA0KPiA+IEkgaGF2ZSBhIFRPRE8gdG8gcGF0Y2ggRG9j
dW1lbnRhdGlvbi8gZm9yIHRoaXMga25vYiBtb3N0bHkgdG8gd3JpdGUNCj4gPiB3YXJuaW5ncw0K
PiA+IGJlY2F1c2UgdGhlcmUgYXJlIHNvbWUgcG90ZW50aWFsICJnb3RjaGFzIiBoZXJlIC0gZm9y
IGV4YW1wbGUgeW91DQo+ID4gY2FuIGhhdmUNCj4gPiBzaGFyZWQgUlBDIGNsaWVudHMgYW5kIHNo
dXR0aW5nIGRvd24gb25lIG9mIHRob3NlIGNhbiBjYXVzZQ0KPiA+IHByb2JsZW1zIGZvciBhDQo+
ID4gZGlmZmVyZW50IG1vdW50ICh0aGlzIGlzIHRydWUgdG9kYXkgd2l0aCB0aGUNCj4gPiAvc3lz
L2ZzL25mcy9bYmRpXS9zaHV0ZG93bg0KPiA+IGtub2IpLsKgIFNodXR0aW5nIGRvd24gYXJpYml0
cmFyeSBjbGllbnRzIHdpbGwgZGVmaW5pdGVseSBicmVhaw0KPiA+IHRoaW5ncyBpbg0KPiA+IHdl
aXJkIHdheXMsIGl0cyBub3QgYSBzYWZlIHBsYWNlIHRvIGV4cGxvcmUuDQo+ID4gDQo+IA0KPiBZ
ZXMsIHlvdSByZWFsbHkgZG8gbmVlZCB0byBrbm93IHdoYXQgeW91J3JlIGRvaW5nLiAwMjAwIHBl
cm1pc3Npb25zDQo+IGFyZQ0KPiBlc3NlbnRpYWwgZm9yIHRoaXMgZmlsZSwgSU9XLiBUaGFua3Mg
Zm9yIHRoZSBSLWIhDQoNClNvcnJ5LCBidXQgTkFDSyEgV2Ugc2hvdWxkIG5vdCBiZSBhZGRpbmcg
Y29udHJvbCBtZWNoYW5pc21zIHRvIGRlYnVnZnMuDQoNCk9uZSB0aGluZyB0aGF0IG1pZ2h0IHdv
cmsgaW4gc2l0dWF0aW9ucyBsaWtlIHRoaXMgaXMgcGVyaGFwcyB0byBtYWtlDQp1c2Ugb2YgdGhl
IGZhY3QgdGhhdCB3ZSBhcmUgbW9uaXRvcmluZyB3aGV0aGVyIG9yIG5vdCBycGNfcGlwZWZzIGlz
DQptb3VudGVkLiBTbyBpZiB0aGUgbW91bnQgaXMgY29udGFpbmVyaXNlZCwgYW5kIHRoZSBvcmNo
ZXN0cmF0b3INCnVubW91bnRzIGV2ZXJ5dGhpbmcsIGluY2x1ZGluZyBycGNfcGlwZWZzLCB3ZSBt
aWdodCB0YWtlIHRoYXQgYXMgYSBoaW50DQp0aGF0IHdlIHNob3VsZCB0cmVhdCBhbnkgZnV0dXJl
IGNvbm5lY3Rpb24gZXJyb3JzIGFzIGJlaW5nIGZhdGFsLg0KDQpPdGhlcndpc2UsIHdlJ2QgaGF2
ZSB0byBiZSBhYmxlIHRvIG1vbml0b3IgdGhlIHJvb3QgdGFzaywgYW5kIGNoZWNrIGlmDQppdCBp
cyBzdGlsbCBhbGl2ZSBpbiBvcmRlciB0byBmaWd1cmUgb3V0IGlmIG91dCBjb250YWluZXJpc2Vk
IHdvcmxkIGhhcw0KY29sbGFwc2VkLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==

