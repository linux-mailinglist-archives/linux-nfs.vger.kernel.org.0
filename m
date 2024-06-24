Return-Path: <linux-nfs+bounces-4255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0682B9151DB
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B361C21072
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285A1EB3E;
	Mon, 24 Jun 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="MzgybFc4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2105.outbound.protection.outlook.com [40.107.102.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEE1DFEA
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242225; cv=fail; b=c/i/qkI62KNzOTXtS4AmPqVI/Yhe2WsUVIt7pSX+dXp1qni92psUlIoRB2ApkL/dlv5Yz+/Tu+QLtAnZGjrNimOp7Ju31vrNpJjm3SVQffENr9ScU0QKrIbsvxSWAn22AT7yaB9wcngEceya3GfQsomfwIDZ+bps3DYwDmn6oSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242225; c=relaxed/simple;
	bh=46YLH3y3YnSkhP7uhlJo9HerUrGX0suwbuS38BiZs7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iecNK/xSSPSevmcCI5PXYvY4VzZS6oGhizOlOZTZUVY8GfQqayaV0OU3b3VU8qQRdbN6VwqLMOyd8ViC2sOX2kAKRv00s3j6hVsbJwB3TdY3TidHp1U0kIpspu3aQOwU0UkMRVkTsaEo8isDZsXU1f1IisTB3HDKz1l03C9XlFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=MzgybFc4; arc=fail smtp.client-ip=40.107.102.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLtS91tyHHtoU7MzUS0CMeAfoUZhS1p6X3rE8tob/0eakLXEMnlOTLowq9Fdj+uyzkHlUZSHNqZ0EArMjgapUc/Qy0U9hxyY9+iD8wm4y7Ty+oYVRWw83cMIMbw8/G5G6dgHcA9ltHFmUdZeZH/hMUDe7PSW5HJmeWpNFw6xmEf+Fc2eLpZPDD1x6GZ2dApqJgbDtmRIltmc83ZDpb4wCRISgJ0/ul080H8bq4tlX3tb1CdjRrch6hvHbeAla25syA8lNB6ZmpPvwpixljpjsorg6HseuExeltaMUls93oCH35um5DwSqmm8gdhluyWv5LG3LZwor7wpnxSJD6rRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46YLH3y3YnSkhP7uhlJo9HerUrGX0suwbuS38BiZs7A=;
 b=H2ir2LsMuD8nca9Y9KPaxbo9KN8I0ldmfIgkC2fbqjo/irRhJYorFdKMtPn97ZQBtXvXuLiOdy865h4Kb1+Zf3gkJ3rwDKcX2cyMD2uwplRR0xKwX8lkRAQU0q3BZHGUMpjoi5bhF4FubYDL4R9qkJSc0x+iUhREo5dKvXzxVFl5KF+sj+9hTaxwDyPxIByr2bE3rypEfM+SPS21yk6M/eZ7Ndd8dKE2uFsUg4gS6eDUPhPyJM/7PGlVSJBi86tC302bB7mXqcJPUsod5n/Y+Jg5GMoxaaDO4P/fOYvUnyFKmuIlOcDT4K1njrwFIY3nEc5fSxjo2pr4lQXCr8a4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46YLH3y3YnSkhP7uhlJo9HerUrGX0suwbuS38BiZs7A=;
 b=MzgybFc4+tQ427cdDMMlQTu5Tb5qyrZJHMDSCsQNsA9wj6sAoj9Tdfs9N616p3+gyBPfC589GsPEiEtidIfmk0wjqEIvLDdUjRb3BXqnHTPyfPkHjraVJotOoKlbPtPQJz275O0iRXT+94LDAeA+E1HX6/FPX62EdG71/LQd0nA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6557.namprd13.prod.outlook.com (2603:10b6:408:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Mon, 24 Jun
 2024 15:16:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:16:54 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
	"olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS for
 DS server
Thread-Topic: [PATCH 1/1] NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS
 for DS server
Thread-Index: AQHaxjppixMV57VTmkeqWI0q/gQrHbHXBqGA
Date: Mon, 24 Jun 2024 15:16:54 +0000
Message-ID: <bb2d44bc4f10032ce1abdd7cbc576cc5ea5da5c5.camel@hammerspace.com>
References: <20240624132827.71808-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20240624132827.71808-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6557:EE_
x-ms-office365-filtering-correlation-id: 3cee4a4a-1845-41af-9d54-08dc9460ae9e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z09JZzNPdHkxdnhVUllua3NmVXhKTENYZE5KSzh6b0F5T1o3SHQ0YkQwdG5U?=
 =?utf-8?B?eFNRREY5cUVudkxSR3Y5ZEs1dG9hcEZBSEtZMnNXeVJSa1gyc3BwZEtnNEMw?=
 =?utf-8?B?QmVGYVNrSHlldTFXTkNvTCt4Und4WDJoTkJZb2kwbzBha2haL0tjUUZuL0h6?=
 =?utf-8?B?ck40b0NMMWxvWmtydjZ5d0tmQ3NWWWRTV1dOTHF2VWMrRGY1REJsRE53bnN5?=
 =?utf-8?B?ZERSV0VvVHhBbVdRS2RKV1NsRXN2R29BY3ZJS1laeHFrWTdWcVgzelh5dU10?=
 =?utf-8?B?V05XTERoRlFQSmNVMjZFL2hmdFVBcHNYeWtFYUNXMFVMQTdoci80NlpXR2dQ?=
 =?utf-8?B?MlhXZVYvSGhwV0RFNlFJMlREUWg0MzN6dm5UZ0p0TUVBeEE2RmFjVi9aNDEz?=
 =?utf-8?B?WHgxdmMxUmJ5WkJFRUZueU1PQlVmUlNyOXMrKzZQYmRxdVNlbjRDT0xmVFh4?=
 =?utf-8?B?N2N4Q1l1b1ZVQnJTcjl4L2p3RjJSR09TTm11dnI0RUlUWkdac0xZeW4xOVBQ?=
 =?utf-8?B?M1h6TFpCc1o1NWYrcUhCcVRzUjVqc0hTYVU0LzVwYVdjUmNHbHB0NW9CdW13?=
 =?utf-8?B?ZE1ZZ0Z0eFhxSjE1QStTYm5Ka242NmpQcy9XWExtZjNzSlMvN0VEMS9yczNC?=
 =?utf-8?B?RG1aR3JqZ2hIc1FOTWFZU0R0VjJ2UGdmOEZPTzRCVXdleWJ1L1RJYS9BMnlH?=
 =?utf-8?B?UThjV01oejRBbEJOcFoya3lVbjJqTW9jcXhSd1F0Sit5MTdmWGpGbVFBL1lR?=
 =?utf-8?B?eEYyZlRESHBhR2tiTjRIaGxYUW9yK2dyanlNbUgybzkyRmJrMXY3dlB2SjVw?=
 =?utf-8?B?YmYwbFBXV1JTZnVJNitmZnNWWDhWZnRlV3kvWTJ0ZUF5MVJRTXJuTVk0YTR0?=
 =?utf-8?B?V2VHaTNzRCtTQWJ2ZFNZTHNjRWZXaUUzTU04MzlzNVdtRjhmM3duWE15R2t3?=
 =?utf-8?B?WEc5SENydTZKV29PaGp5TnF5NUk1bXhiNzBYQVRrQ1pITVhIVGtiUjZzUWJ4?=
 =?utf-8?B?NlI4RFFFaGRhUkUyb1gvSmovSUM1RjJQYkVsMXlRS1J0Z0tseTlNajlEczcr?=
 =?utf-8?B?QldmcW0xak5zM3gyVkdwK2MvMjgyUVltSHpiODVhbGFLb0Z4L0k3T0k3ajlo?=
 =?utf-8?B?d2NzN3dFbFdldVJPc2s5bk5Ta0RCOCtyRDZieHF2MEJrMjNuaEJIV2kxTUNH?=
 =?utf-8?B?YU91Y1RnSmY3NU1NWWk1dzZCOTB1bkxUWGVYWXlDOFlrVmpJTHBDWXNLbWhi?=
 =?utf-8?B?RzdhL3RibjlNS2xPUEFIRE5VeXJmZjFycXVkTzdoU2h0d203aFQ4OWsvanhm?=
 =?utf-8?B?TnNuaUNuQXA2SWZtbGtFTERNZmtSVzZZVnZEbUdrZU1TRmJBYk9mZWJzWERr?=
 =?utf-8?B?ZFZ0UGRnRFh4akViQmcvVkFTdHZJdEJDM2VDaWFpemFYbHNNMXZOMEJIb0wx?=
 =?utf-8?B?a0JNSUNUbld2TDhXLy9LYVZLMjkxSHE3dlJ6WWRtZklUTnNhSXF6cFc1Yk9R?=
 =?utf-8?B?bUZIcnFEcHNLblY3bEhacFMzMHY5YlA0Z0szQ0V6VzIwOWJJQWdlUndBUVE1?=
 =?utf-8?B?Q0c3Sll1ZFVRaWFkY1lkR1FpcXE5ZUdkdkFob3NMbWlxVitVOWhuamFqcHk1?=
 =?utf-8?B?TGFWZW43NFVVc0djeitOdE1TZnFsWGJQYnVkMXdPZnoxdnVSSDJOTlFhNzFm?=
 =?utf-8?B?c3JrZVJtZGNvdnd6Z2xoWWdMU29sd250SmhuSm5DN2JGenEvZjZqSSs1QVJN?=
 =?utf-8?B?TU1GU2FEUThOWFNldDViME95QkE1YTJWdENwR1I2UGNidHBEK3VQSFBUVGJs?=
 =?utf-8?B?SjVTZmNRZkFtMERaM2hlSHNDblg0Q25SWDdmbnZIMnhtVk1LWVdpNHF4Qktw?=
 =?utf-8?B?ZmMvL0d0blZGZi9YZjI3T3IzNEtiNUF4YWFVYU1hZ3Zhc1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eENSa1ZNNWZYbmN4NkRPT3B2bE85M0hoejZtOTJZNFRFa1hrajV2Z0luSFlG?=
 =?utf-8?B?NnVUVTRmbmN5dGNOaFgxMlo0VmFVdkg2MjhtcHVlWkJHci9yc2tpL1MwakFC?=
 =?utf-8?B?TkdVYTZqMTdJazMwWk9Pb3AyRG1sOExOYmkxdXhxYlB1RDZvVDcwazFEdzl2?=
 =?utf-8?B?NTBoTS9IYmUxRHllU2t4Q1hQNlYreDNKcm55VDhRUDlXQ0hJYkthc01RQ1NR?=
 =?utf-8?B?S0xiRmRrSExpWHRKVWRSLzJFeVYvVk4yaDNUS1hUYW5BNERTYkpIOHFrUU5F?=
 =?utf-8?B?YzF2N2xyRHhPQnFId1ExMHhBM1pMLzdYV1FRM2QyQW1EZXZwOGY4SFlHaTdT?=
 =?utf-8?B?MS9jS2NRRjkreS9EL0NrbUpOaTF4STJpNVdPYjJuVVNGN0k3a3FOQk80N0dU?=
 =?utf-8?B?S2FGQ3JOTSt0czExTUZsSXl4K2F0dzkxUnZsaVlod1F1S0luY0lBaG9zdG1m?=
 =?utf-8?B?dEFBZEwzcDRYelpmazJteDVkaHNJaUlMWEFEc2srZXU3TFYrOHp2UWFveTRB?=
 =?utf-8?B?aFprNXJnM3hjTTdGZlhUb2FySkNETTlBeEFQZ0wvcFJuRjYyOTFRWVFGK3hB?=
 =?utf-8?B?SlNYYkV5Z21KSk9vSlc1ck9SejdGR0daUGprUytXZGZDTC8ybGQ5bWxCNytk?=
 =?utf-8?B?NVovMlQ4Y2U4UnZCd3BIb1MvTXBiYjhGQmIrSGZNOFdkVk1DenREZndUYVBk?=
 =?utf-8?B?ZUNWZy9Za0lzendiSTNObmUxMStGOXdWZTRKc0JaY2JqQi9LQjRBMEQxVGxR?=
 =?utf-8?B?ai8rc1NIQ0xoamZIV1VqQzNacDNtaXI0aTNqazRGb1lwSjBHZGYwbERQVEpF?=
 =?utf-8?B?dzR3WFVnV2FoMTZvK2JXRHl2ZFNtNFgzMGMwajMzck12T1JxRm43Mzhxb0hU?=
 =?utf-8?B?NTY1RlZkdnY4ZTZkT2tzalBTMURpYUtHRkR2R28yMUljbUtaaStRdmxBUDg3?=
 =?utf-8?B?aC9OU1FmT0dCVGIvczJreE00NThTM0grek80akhkR1NoRllLSGVQb0RVWThp?=
 =?utf-8?B?K2lyaUpwM1QxdEJRUTlTS2Frc0VNeVpXZXA3SWRhbWt0VFFjaDF6aUprNEdT?=
 =?utf-8?B?dGlxUmtHOVkybjVIdEt5YS92TW9VcjNtMXlCSGlaT0MvVmdYTzkyVXlnd2xD?=
 =?utf-8?B?NEJ5cWF5ZkFBSmsvQkpjRmVlNnRJeHdMeTBDZXJDbjIwYU1xMTUyWDZvS0xC?=
 =?utf-8?B?V0ttcFdRSnlHU3RFR21sakh3YTRRWWpJQ0g5cUYwWGgyejdXc2IyTzkvRGNT?=
 =?utf-8?B?dHFLbjRoeEdSaS9EN01IVFN4clByR2tJL09rdWFzdHA0bUJlZjNSUUN4dUg1?=
 =?utf-8?B?MnZESEJqUGF4bVpoTmxaaDE1b1JMYlcyN3BaY3BuOFpkdnBYZzJNRm1PMFB2?=
 =?utf-8?B?RWllRGZseU0zSTVjZ1BTSWxYVXEreHJjUE8ranVpYmFVeUdHYTRweXN2bnZQ?=
 =?utf-8?B?dkhyRmhWaEVENEp2NWp6VU82QlVkRmtXUUpJNVRWRVU5ZkpCOHJ0UWhiVkJo?=
 =?utf-8?B?SVJjS1VpZmVIc2N2VzJCOENLc1BxZytvb0lJZUxXVGV6Uk5wSS9yQklGQkgr?=
 =?utf-8?B?NUIxMmFYZ0J1WFBmcC9NdTJGaWE3dGRiZThDN1NsQ0hqOWtZQkpHeXV3aXFR?=
 =?utf-8?B?c0xoL05NMzNCSlAxYmJkZEUvbmtsbEFST25UQUg5UWxLYlRDR3BadDY5aWVN?=
 =?utf-8?B?a0lscTVvaUo1NkdjU1BFR2FadUhBQ0VzdVR0NGlENDNnTkMxbUVTdGhRRDBY?=
 =?utf-8?B?UDYvVDJuWWhkNWlTMVJpLzFEWjlSNGZycUdPRTJ6UjNqcFlKbWNLUEtSZVhu?=
 =?utf-8?B?RVlFZWJUUTRRZ1RDRnZOSmRXWUN6UFUrOFE5dHl0K0M4SHRpSkowWGdCMDU3?=
 =?utf-8?B?WnpwRExkc3lNcHNiN3BXTURiU2k4ZEdmcEVkKzNhamRzL09lNS90YVFhb1B2?=
 =?utf-8?B?ZTd3TkwrenNGR0hmOFN2TDBHSzU1TWNKWFhTK05GODVsek40N3dsZTZBQUVD?=
 =?utf-8?B?ekhhd1lMNDhoVWw0cm1WTlFyM2FZM255SUdlQmIrVWJPZSt3UkpPMXdRbENR?=
 =?utf-8?B?RTBXVEFqUndvMnVKVEVRSzJWZkdWeUY1WXN2ck1EVE52QmVlSGQzdGlvSTl5?=
 =?utf-8?B?Nkl2ZCtLZE10cmJWaUV1K0VoMVkrRDIzZTViSUs4bEJheTdLZUxzemdOZzkw?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D61CAC0A7EC841A583620E6CD28C64@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cee4a4a-1845-41af-9d54-08dc9460ae9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 15:16:54.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kroYtfh5pZXI3el0Enbw8O4Lf4Cgacp1WIo9Go5cZATJpo/b2s+BH/ENzegNMn+IvzckGfRl/LFOV84Mr17EIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6557

SGkgT2xnYSwNCg0KT24gTW9uLCAyMDI0LTA2LTI0IGF0IDA5OjI4IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5j
b20+DQo+IA0KPiBQcmV2aW91c2x5IGluIG9yZGVyIHRvIG1hcmsgdGhlIGNvbW11bmljYXRpb24g
d2l0aCB0aGUgRFMgc2VydmVyLA0KPiB3ZSB0cmllZCB0byB1c2UgTkZTX0NTX0RTIGluIGNsX2Zs
YWdzLiBIb3dldmVyLCB0aGlzIGZsYWcgd291bGQNCj4gb25seSBiZSBzYXZlZCBmb3IgdGhlIERT
IHNlcnZlciBhbmQgaW4gY2FzZSB3aGVyZSBEUyBlcXVhbHMgTURTLA0KPiB0aGUgY2xpZW50IHdv
dWxkIG5vdCBmaW5kIGEgbWF0Y2hpbmcgbmZzX2NsaWVudCBpbiBuZnNfbWF0Y2hfY2xpZW50DQo+
IHRoYXQgcmVwcmVzZW50cyB0aGUgTURTIChidXQgaXMgYWxzbyBhIERTKS4NCj4gDQo+IEluc3Rl
YWQsIGRvbid0IHJlbHkgb24gdGhlIE5GU19DU19EUyBidXQgaW5zdGVhZCB1c2UgTkZTX0NTX1BO
RlMuDQo+IA0KPiBGaXhlczogMzc5ZTRhZGZkZGQ2ICgiTkZTdjQuMTogZml4dXAgdXNlIEVYQ0hH
SUQ0X0ZMQUdfVVNFX1BORlNfRFMNCj4gZm9yIERTIHNlcnZlciIpDQo+IFNpZ25lZC1vZmYtYnk6
IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMv
bmZzNGNsaWVudC5jIHwgNiArKy0tLS0NCj4gwqBmcy9uZnMvbmZzNHByb2MuY8KgwqAgfCAyICst
DQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRjbGllbnQuYyBiL2ZzL25mcy9uZnM0Y2xpZW50
LmMNCj4gaW5kZXggMTFlM2EyODU1OTRjLi5hYzgwZjg3Y2I5ZDkgMTAwNjQ0DQo+IC0tLSBhL2Zz
L25mcy9uZnM0Y2xpZW50LmMNCj4gKysrIGIvZnMvbmZzL25mczRjbGllbnQuYw0KPiBAQCAtMjMx
LDkgKzIzMSw4IEBAIHN0cnVjdCBuZnNfY2xpZW50ICpuZnM0X2FsbG9jX2NsaWVudChjb25zdCBz
dHJ1Y3QNCj4gbmZzX2NsaWVudF9pbml0ZGF0YSAqY2xfaW5pdCkNCj4gwqAJCV9fc2V0X2JpdChO
RlNfQ1NfSU5GSU5JVEVfU0xPVFMsICZjbHAtPmNsX2ZsYWdzKTsNCj4gwqAJX19zZXRfYml0KE5G
U19DU19ESVNDUlRSWSwgJmNscC0+Y2xfZmxhZ3MpOw0KPiDCoAlfX3NldF9iaXQoTkZTX0NTX05P
X1JFVFJBTlNfVElNRU9VVCwgJmNscC0+Y2xfZmxhZ3MpOw0KPiAtDQo+IC0JaWYgKHRlc3RfYml0
KE5GU19DU19EUywgJmNsX2luaXQtPmluaXRfZmxhZ3MpKQ0KPiAtCQlfX3NldF9iaXQoTkZTX0NT
X0RTLCAmY2xwLT5jbF9mbGFncyk7DQo+ICsJaWYgKHRlc3RfYml0KE5GU19DU19QTkZTLCAmY2xf
aW5pdC0+aW5pdF9mbGFncykpDQo+ICsJCV9fc2V0X2JpdChORlNfQ1NfUE5GUywgJmNscC0+Y2xf
ZmxhZ3MpOw0KDQpXb24ndCB0aGlzIGNoYW5nZSBjYXVzZSB0aGUgbWF0Y2ggaW4gbmZzX2dldF9j
bGllbnQoKSB0byBmYWlsPw0KDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=

