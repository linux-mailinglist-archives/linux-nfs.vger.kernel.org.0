Return-Path: <linux-nfs+bounces-3355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5F8CD990
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 20:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1438B1F215C3
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97676F17;
	Thu, 23 May 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Fo0a3zBU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2119.outbound.protection.outlook.com [40.107.101.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190771F934
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487212; cv=fail; b=WACzdp4TWEDXNuxzEdFLxPU8V1SHzf7eTGAEGTIM1sPqj/qB1BKyPAVrtlJZcGes1LplsqzRnVUuzZXI+T/GBsDotVCGoWzRpvcIGvGe7jHtMHv9zGDw+smNUNE+2Cz2YbbXLTbRwky/6mWrvGAm7mTgTLuHrcv1qKV2xf2A3Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487212; c=relaxed/simple;
	bh=0q+ZLM0RzdhWWC2S8pdtVkMQPmCB8WH/1jls68FO/0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MpjKqVjECsTgTtsb3qXz5KDkv5IU8KePo4Ewgmh2jxBe3v9w3i4A2aeuFHNKUGypdEB8u8FaLB3QGa8+JUpcrJ9Nj0RP6Jl80LGmWFOhOHzMyhcc9mcAbnQo3UgZwvqw+7ye2Aabev4inE/K/N7x/11TItH/exwiCaPPYvNkZfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Fo0a3zBU; arc=fail smtp.client-ip=40.107.101.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSiz9OJth71LUbxF7hA8fvb4ztA0DgUWf/QG9xCGsj5g4dV50FwGS4jYAiMPzL6TrsdREDIkAKxz4tnaHf7QWDS3Wxg4fuu/rvkLbEDUCjcmzKVT71OsqYwUm4BdT+uyWgQ+WrS3FMVrvrZRaz0W3C3MczXj6zpXx1+mmsMTETQjPz54XgkZPoyJCThbmHzafjoEQAGaB8CacoOiTgUjvFvwG+KB+PtO8hzp8zwu7m+w+1U4rZOy0E6+uRzki4tRzVWCEM65VqBakbWNQKoJ4N/dsxKLK0NLorlrrrmioZj7O/EaRbZFrelbwpNX/W1Pr7RwBWZzV48k/zNd9xRcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0q+ZLM0RzdhWWC2S8pdtVkMQPmCB8WH/1jls68FO/0c=;
 b=UntXoutGkZzYxfDNMVUxIoRXWEM8bIUXlHn7W9so9zA4OiNqKUhCUE/q7oGelQCVoKPyYeLDAUrJFKJ8qUDRG2oU2UdB2PHX08P/hhc74bkUhp5P9GFA/BIMgfPY14b7rW4wOYVRlbyPJx2+WcWUaVC10Pc5sdJlDq1HzYMyMvCMEo4Cwy5pHmvK6CzqHRmre0pJ8NLzykb39lriVPfSarDBNduSpshEZscZ/PYSDKayfmsZa+AANp4iA0zJuJ5AcBZpeixkIJLPLla85zpMPRe+30bUmizZovEjtM6Lq05Qp6a1dZW4gUiD0iUiWWwsq1/0vZ/V0uGZA0ZKEEQD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0q+ZLM0RzdhWWC2S8pdtVkMQPmCB8WH/1jls68FO/0c=;
 b=Fo0a3zBU6RYy0cHfdauF+lt7PTdMpsUWb+9Ek2nQ3A3FsiG9LLmsvKj8nBxlMbOiiERry8JtdRAHaSCR5Mvh0N+Fyxhrp8pUOskQgiAjKCVAZPLUlXYWf5Xkma4m6CRPgXZYDWgopXGO8mxr/pInoGTwrEoOxkuqEM5vgMfk4fA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5468.namprd13.prod.outlook.com (2603:10b6:806:233::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 18:00:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7633.001; Thu, 23 May 2024
 18:00:02 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jack@suse.cz" <jack@suse.cz>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
CC: "anna@kernel.org" <anna@kernel.org>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Bad NFS performance for fsync(2)
Thread-Topic: Bad NFS performance for fsync(2)
Thread-Index: AQHarTHxut+LV3noB0CLJKnIHPrqBLGlG6yA
Importance: high
X-Priority: 1
Date: Thu, 23 May 2024 18:00:01 +0000
Message-ID: <271717b8f2a6b2121dbb529ed3a21a69467b0fa5.camel@hammerspace.com>
References: <20240523165436.g5xgo7aht7dtmvfb@quack3>
In-Reply-To: <20240523165436.g5xgo7aht7dtmvfb@quack3>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5468:EE_
x-ms-office365-filtering-correlation-id: 979b9fb7-496d-49d5-aa28-08dc7b522b06
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFo1S3Zhb2dyMTVUWWhFSDczbTh0U3pHVFNkSHBwOVJkMHllakppT1ZheVF5?=
 =?utf-8?B?enBBMlFjNTdFamNHK0hLNzc1anpaQm51bFg5b24rMXpodnFCZkIzRlJtT0Rq?=
 =?utf-8?B?MVMrd1FicnBRZXpkWHpXZlJ0alpYK1pBKzZQaGNqeGpsQUZUZUE3Um5UK3Bt?=
 =?utf-8?B?KytPZ3hlWHRodGtzL2RHLy8yYVIxamZUU09nVWlPTDlvcW1PajUyZGdSd2pk?=
 =?utf-8?B?OWcxUDdHZDh3VlhiazBOczg1OHR1a1RxZWs1WlpQZkdBYXVLQzNzdkRVc1Zv?=
 =?utf-8?B?ZCtzR2R3eU1wMHg0V0Zmem5QazkyOEQ3YWdobWdaUUc2WG11VDFTOFpwZlBU?=
 =?utf-8?B?TVArN2dwa1o2cjlNRnptRkRmSzhWWVpsc0dsNDJWd1Jad2hUM1N1SU9yRWo5?=
 =?utf-8?B?YXEweWJuUGNBYTcyVEJlSGg2MHViMVh2SFBoSEJOOVRyRFZZZmxiZ1ZBWWpq?=
 =?utf-8?B?WFoxdzRtNDRadUdtVHI5cE5JYjJORXZWOUM5ZjByN2JiT0J0MTlCQTRoV2pU?=
 =?utf-8?B?MkJUckdhT1IwZ3RyZnNoamZFSVdzdElnb25wWGhWeXh3ZHFjTjVQZnM3cjJX?=
 =?utf-8?B?RWhCdE9UYkpZN1VuZHJ5NXJNVW1VTmd3bGpkNlpJdjVBU2VNNzNURlpoSGtj?=
 =?utf-8?B?a0xuSndWb09zUnBlN1RUWklua0tkRXNwNnBxUHovSWZxd1JFNVZaOXZraVgz?=
 =?utf-8?B?bXNnU3NxaHJrdjV3d25qNDl4MjFJWk5wV25maWJucTBEcXB5VG5ndUUwbzZI?=
 =?utf-8?B?WEJvVHBKOXJEWmE4R3QzNHZXY0dTcVhEak9xNm0zYWxpOHlORFJlanBqWm9n?=
 =?utf-8?B?ZG5vUEh4encwNHFmK0k5S1ZQWGgvV3Nkblh6eWhNRmFYUWkvVzhNVy9MNHE2?=
 =?utf-8?B?OWRCcmhIN05oMU5RMDFjcWJNeHhRM1NkTzE0ekFLakpFRmM4MkJ1dlNxUDR5?=
 =?utf-8?B?cWEwZXdsbjZIRFdidlhuTW85RFhZdTVnWTduNXU3Z21WK2VhNUtMZFpWTTJO?=
 =?utf-8?B?SnZuOUJhSldWSktJbnJsV1Vmb1pmaG9NaDdlOTJDTi95YnhvY01JYjhsM3JY?=
 =?utf-8?B?cGRia252bVdWR0VPUnhrUVlKaGdLZDZwSzEwOFROWlNEMTRZN1JjcDFaUHY4?=
 =?utf-8?B?cGNmQlZ4Y1R5UnZTU05NSFBnOWpYYjlyN0Fka2ZOT3N5Y1pPSmxDNWFNOWtN?=
 =?utf-8?B?RElCY25qNDBkeStLK2lkWkJkWU5iT2VNK1pCakkzbWJXUGhGRFdrTXZzRU5E?=
 =?utf-8?B?WUdXejM2Yy9jUTRlckllL0ZBcERqQTNuYXk0ZmRzU1hhRTRCRmUraE5jS2Uw?=
 =?utf-8?B?ZFRmSDM0SzgvL2dmWno5NTVTZ2o5T1RpYWFQSVZ5VzlPZWVlSnF2TkxVeUtk?=
 =?utf-8?B?Vm9LWWp6NFlxdEdjREJpVTdPTDBySnFNa3hyUVNCZGtMQ3RiYnEvRC84Vzdi?=
 =?utf-8?B?cWFrQkwyS0RsY1ZMYktPYTVXSG9hZ285TGozU0pDclRJZDhtVWd3K1NQeFZX?=
 =?utf-8?B?NVNaZ2NpMHlRQjlNOXJqbFJlZVIvSTFJOUl6aXN2UDc2VDcvdXFMR0E1ZHpN?=
 =?utf-8?B?OXhWaU1aUjlNQzl0cjBuL3RMdGhoTXVmUXV5QnRNU2xEZ3dUU0VSTlRmZDFk?=
 =?utf-8?B?a00yRW1mMlR3NlVyZm9rcHlxZTkzY2psTFJHeTlkNWhQcGNQZWs1MUFGVHpH?=
 =?utf-8?B?L3dmQWs4ZmhYMnlkdDdjdmVMV1FoZkl6TWxBUlRpRGR1eFFQVGFsd3RXS1I5?=
 =?utf-8?B?TGxJekVJUXZYY2NyaUlpK09BKzY5a2MvZ1JNUkZEbnhvaGlRMTF0MzZueU5D?=
 =?utf-8?B?LzFxUStDRUF4SU0rN0s2Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUxtL1J2a1hkYlliNFZFUGxpbFN0RUpxaEZUaWI4dVRRV1R6OTJWdFRTRXk4?=
 =?utf-8?B?UGsrRjB3L2JqWkNyRDc1bFFKTzFSVGFqcExOS0hEYjNpYmxGNGhQZjZKOVZk?=
 =?utf-8?B?WVZXQWl5S0hnd1NlcldEa0JvdXZqdlFsWllUT283NWVhN1J1ZWJqMzJCT2VE?=
 =?utf-8?B?TnZuRTczYkVnSURaRkh1R0hpdEFMQ0d1ZWphbWhTU1ZKL0dCVzVtL0N2dytT?=
 =?utf-8?B?ZVRIOHlDdkgzMHUzN0V3V09ReGhpTkd0RnZ6ZVk2cStvYTJNZk03cWV3Ujhn?=
 =?utf-8?B?MFVsNU1DdjMzeFJadUhBMStTdDNmUE5OWVRMb1orK0pBZ29LZGtSTlNMNFFa?=
 =?utf-8?B?Ui9LOFJZK3IvL09VbUZMS0NHUmd0N1lMZlVXOUFsMTFrbGZrZTZzNEdOWnV3?=
 =?utf-8?B?c0tMdjJGR0RCc3B3d3VhOEVYdHZxbXYzTTgwTFJIOTk3MzBQOGl5NEgrd0Ju?=
 =?utf-8?B?a2cweGwxZmxVUDZWa0Y3MkVxa1pUaUY2WGJOSEZkOFdCeUJjSm1EWG8wS3Nl?=
 =?utf-8?B?VlduNU94K1UzU0JOWDBOTjFrdzErYUhXLzZsbnhZTW10dlJkUU5VUWZQYlJT?=
 =?utf-8?B?d3kzeHhoczlSRHlkekpRMWNLaVkzTDNkTVJOeG1MSjZUejlEMG03UXpCaHMy?=
 =?utf-8?B?UnFMT0xwemFaS3BSdzY5MVRXZUtoaDlmV0tSUG9CWFRWZ2duVkRXZytvTzkw?=
 =?utf-8?B?QWVGa2dkYkJjM0pZWXFMTkpCcjNOSGw5VlZxUVJ1QzJpTUlWMDBVYTZwa3Bz?=
 =?utf-8?B?Tm5UZXdmbStxUGNSL0xpb1NCSTl2em9vdE1uYkVpK0kxVlFqeGVQQUQxVC85?=
 =?utf-8?B?aXBSY29rL1l0REM5QzNJbFJ6bTU4bUU4T3RRSFA1K3I4RUNSd3QvSW8zR3ls?=
 =?utf-8?B?WU1Qei9IV09ldnVNN1luYzc0MzVCdTd2Z3FuRlIwdnZRT1czcnBEYjFJVWc0?=
 =?utf-8?B?UUJSWVp1MCtVbDUwWG9JcWZnWEV5M1FqRXF3TkJmSUJ1OG5kaHlVMU5aaGQz?=
 =?utf-8?B?ODdONFBrZkxzVFBTM1FERkpTMEFkN0REVzVITUpYek1hVXR6eDVhZzVRNHh1?=
 =?utf-8?B?NDYvR2hoTFhJNnZzOVlWWnNkcHF5dnFVZjNLc3VSWnVaTXpYQjcvTW1mUEhx?=
 =?utf-8?B?c3RXNW45aFZMMm1mWkFLQ1N3WG1Ha1pCN3UyN3BjOHk1SmM1WDhRTnhjR00r?=
 =?utf-8?B?T0ZCKzF4RllPOFQ1UFBMVnE0UzY1Wk5oU0tsSzhDMldMK0lwRWhjd2JKZ3Bt?=
 =?utf-8?B?OFRXMXZ3VjdDcC9CM2VkcWg2SUp2QW1ZdkFlc3ZEMG9ZNCtYRm9CSGd4dS9z?=
 =?utf-8?B?eU1CTHVGWnhCd3drVzE0aXRDOGNheGdjNVRqQjdWdXBTSVlLSmZYREYwZUFN?=
 =?utf-8?B?aW9mc1lFRDVJSXhYNjhXV1VOTzZWUkJyZ1B1dkJISXhHYmFuclRDRktsbTNV?=
 =?utf-8?B?R1pXaGcwY005d0haZ1Z4bnMwamRWVHFMOGYzSzNISWZ0ZXR0MGNkTzlIQWZh?=
 =?utf-8?B?M2hFSTBHTlBsRSs1Z0tUT3pWUzNXNCs4WWJpMThFYnhWRXY2Q2tGQTBZNngz?=
 =?utf-8?B?NkgrbCtmbFRsMi9rSmRVNmkrVzlrU1lBaVRNc1BiL3l0Sk9XdnlzaHJvc3o4?=
 =?utf-8?B?UjR0YXFDQTNHRDZGcG40ZHhCbWtyU0hKVDBkY2k3ZW42Y0NSZmRaRjl5QUNN?=
 =?utf-8?B?SENkR1dqWE1WY1h6bnVpMzFXdko0aStlR2ZKemFWN1pVVm9OSWpEUVZKcEU0?=
 =?utf-8?B?bkJEN1VoSXFCQ1lpRmZCOU5TMWZMdkVlV0ZpbTBveXNIMm1xbUVqaHIxeWg2?=
 =?utf-8?B?VGxveUZhdzBwUDN4L01LUmZ2dnhYQmNNRWVUUmtBUVdhU0k1OGdSRzJXeVIx?=
 =?utf-8?B?WmRYNUkwQnpHSjBXZjZnQUFXZG14NzNFcW9tbmQ5ODhXVkVBNjZPN082dGFW?=
 =?utf-8?B?dzcwT2p5OVh6Q20rNDd6QldUanRkeG1KcDE0RDhrWjZkYzcwS0pJNkhCZk9z?=
 =?utf-8?B?WERBZWRGZnFwdHNpY0Z3V2R4aWpZZDRlQTNuc2dtdDRaeDJ3SGZOWjBTaVZJ?=
 =?utf-8?B?aitSdG93c1JHL0RHaDRJeHNmQkpMZHRRcllDc1IwV1V4M0lDcEtrSlZOL0dW?=
 =?utf-8?B?Sk05TDR5U3UxbjhuUTVJa0F2cGtIQmlmRDZGcVFKYy9xUkROYXQ2YmFsc3Jy?=
 =?utf-8?B?bXNVWmg2b0FBL0dxY1JodDlSRlp0U2NmVTJVeVc4QVdGLy9yMkgwQzFpcTJj?=
 =?utf-8?B?R1Vna1Q0ZlBWYWUyYlpKaHgxQlVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B53466B19E3BFF42B51EAB9DF8F6431B@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 979b9fb7-496d-49d5-aa28-08dc7b522b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 18:00:01.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIHSyQ/LE8I57TzyOoayRycm0JcTwCGWyGOA2z1KJVEqCp1ZhCjqWj9+9zoNciHDq+CBTlzjPnl9xvLTmeBqzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5468

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDE4OjU0ICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gSGVs
bG8hDQo+IA0KPiBJJ3ZlIGJlZW4gZGVidWdnaW5nIE5GUyBwZXJmb3JtYW5jZSByZWdyZXNzaW9u
IHdpdGggcmVjZW50IGtlcm5lbHMuDQo+IEl0DQo+IHNlZW1zIHRvIGJlIGF0IGxlYXN0IHBhcnRp
YWxseSByZWxhdGVkIHRvIHRoZSBmb2xsb3dpbmcgYmVoYXZpb3Igb2YNCj4gTkZTDQo+ICh3aGlj
aCBpcyB0aGVyZSBmb3IgYSBsb25nIHRpbWUgQUZBSUNUKS4gU3VwcG9zZSB0aGUgZm9sbG93aW5n
DQo+IHdvcmtsb2FkOg0KPiANCj4gZmlvIC0tZGlyZWN0PTAgLS1pb2VuZ2luZT1zeW5jIC0tdGhy
ZWFkIC0tZGlyZWN0b3J5PS90ZXN0IC0tDQo+IGludmFsaWRhdGU9MSBcDQo+IMKgIC0tZ3JvdXBf
cmVwb3J0aW5nPTEgLS1ydW50aW1lPTEwMCAtLWZhbGxvY2F0ZT1wb3NpeCAtLXJhbXBfdGltZT0x
MA0KPiBcDQo+IMKgIC0tbmFtZT1SYW5kb21Xcml0ZXMtYXN5bmMgLS1uZXdfZ3JvdXAgLS1ydz1y
YW5kd3JpdGUgLS1zaXplPTMyMDAwbQ0KPiBcDQo+IMKgIC0tbnVtam9icz00IC0tYnM9NGsgLS1m
c3luY19vbl9jbG9zZT0xIC0tZW5kX2ZzeW5jPTEgXA0KPiDCoCAtLWZpbGVuYW1lX2Zvcm1hdD0n
RmlvV29ya2xvYWRzLiRqb2JudW0nDQo+IA0KPiBTbyB3ZSBkbyA0ayBidWZmZXJlZCByYW5kb20g
d3JpdGVzIGZyb20gNCB0aHJlYWRzIGludG8gNCBkaWZmZXJlbnQNCj4gZmlsZXMuDQo+IE5vdyB0
aGUgaW50ZXJlc3RpbmcgYmVoYXZpb3IgY29tZXMgb24gdGhlIGZpbmFsIGZzeW5jKDIpLiBXaGF0
IEkNCj4gb2JzZXJ2ZSBpcw0KPiB0aGF0IHRoZSBORlMgc2VydmVyIGdldHRpbmcgYSBzdHJlYW0g
b2YgNC04ayB3cml0ZXMgd2hpY2ggaGF2ZQ0KPiAnc3RhYmxlJw0KPiBmbGFnIHNldC4gV2hhdCB0
aGUgc2VydmVyIGRvZXMgZm9yIGVhY2ggc3VjaCB3cml0ZSBpcyB0aGF0IHBlcmZvcm1zDQo+IHRo
ZQ0KPiB3cml0ZSBhbmQgY2FsbHMgZnN5bmMoMikuIFNpbmNlIGJ5IHRoZSB0aW1lIGZpbyBjYWxs
cyBmc3luYygyKSBvbiB0aGUNCj4gTkZTDQo+IGNsaWVudCB0aGVyZSBpcyBsaWtlIDYtOCBHQiB3
b3J0aCBvZiBkaXJ0eSBwYWdlcyB0byB3cml0ZSBhbmQgdGhlDQo+IHNlcnZlcg0KPiBlZmZlY3Rp
dmVseSBlbmRzIHVwIHdyaXRpbmcgZWFjaCBpbmRpdmlkdWFsIDRrIHBhZ2UgYXMgT19TWU5DIHdy
aXRlLA0KPiB0aGUNCj4gdGhyb3VnaHB1dCBpcyBub3QgZ3JlYXQuLi4NCj4gDQo+IFRoZSByZWFz
b24gd2h5IHRoZSBjbGllbnQgc2V0cyAnc3RhYmxlJyBmbGFnIGZvciBlYWNoIHBhZ2Ugd3JpdGUN
Cj4gc2VlbXMgdG8NCj4gYmUgYmVjYXVzZSBuZnNfd3JpdGVwYWdlcygpIGlzc3VlcyB3cml0ZXMg
d2l0aCBGTFVTSF9DT05EX1NUQUJMRSBmb3INCj4gV0JfU1lOQ19BTEwgd3JpdGViYWNrIGFuZCBu
ZnNfcGdpb19ycGNzZXR1cCgpIGhhcyB0aGlzIGxvZ2ljOg0KPiANCj4gwqDCoMKgwqDCoMKgwqAg
c3dpdGNoIChob3cgJiAoRkxVU0hfU1RBQkxFIHwgRkxVU0hfQ09ORF9TVEFCTEUpKSB7DQo+IMKg
wqDCoMKgwqDCoMKgIGNhc2UgMDoNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJy
ZWFrOw0KPiDCoMKgwqDCoMKgwqDCoCBjYXNlIEZMVVNIX0NPTkRfU1RBQkxFOg0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5mc19yZXFzX3RvX2NvbW1pdChjaW5mbykpDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYWxsdGhyb3VnaDsNCj4gwqDCoMKgwqDC
oMKgwqAgZGVmYXVsdDoNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhkci0+YXJn
cy5zdGFibGUgPSBORlNfRklMRV9TWU5DOw0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiBidXQg
c2luY2UgdGhpcyBpcyBmaW5hbCBmc3luYygyKSwgdGhlcmUgYXJlIG5vIG1vcmUgcmVxdWVzdHMg
dG8NCj4gY29tbWl0IHNvDQo+IHdlIHNldCBORlNfRklMRV9TWU5DIGZsYWcuDQo+IA0KPiBOb3cg
SSdkIHRoaW5rIHRoZSBjbGllbnQgaXMgc3R1cGlkIGluIHN1Ym1pdHRpbmcgc28gbWFueQ0KPiBO
RlNfRklMRV9TWU5DDQo+IHdyaXRlcyBpbnN0ZWFkIG9mIHN1Ym1pdHRpbmcgYWxsIGFzIGFzeW5j
IGFuZCB0aGVuIGlzc3VpbmcgY29tbWl0DQo+IChpLmUuLA0KPiB0aGUgc3dpdGNoIGFib3ZlIGlu
IG5mc19wZ2lvX3JwY3NldHVwKCkgY291bGQgZ2FpbiBzb21ldGhpbmcgbGlrZToNCj4gDQo+IAkJ
aWYgKGNvdW50ID4gPHNtYWxsX21hZ2ljX251bWJlcj4pDQo+IAkJCWJyZWFrOw0KPiANCj4gQnV0
IEknbSBub3QgMTAwJSBzdXJlIHRoaXMgaXMgYSBjb3JyZWN0IHRoaW5nIHRvIGRvIHNpbmNlIEkn
bSBub3QNCj4gMTAwJSBzdXJlDQo+IGFib3V0IHRoZSBGTFVTSF9DT05EX1NUQUJMRSByZXF1aXJl
bWVudHMuIE9uIHRoZSBvdGhlciBoYW5kIGl0IGNvdWxkDQo+IGJlDQo+IGFsc28gYXJndWVkIHRo
YXQgdGhlIE5GUyBzZXJ2ZXIgY291bGQgYmUgbW9yZSBjbGV2ZXIgYW5kIGJhdGNoIHRoZQ0KPiBm
c3luYygyKXMgZm9yIG1hbnkgc3luYyB3cml0ZXMgdG8gdGhlIHNhbWUgZmlsZS4gQnV0IHRoZXJl
IHRoZQ0KPiBoZXVyaXN0aWMgaXMNCj4gbGVzcyBjbGVhci4NCj4gDQo+IFNvIHdoYXQgZG8gcGVv
cGxlIHRoaW5rPw0KDQpXZSBjYW4gcHJvYmFibHkgcmVtb3ZlIHRoYXQgY2FzZSBGTFVTSF9DT05E
X1NUQUJMRSBpbg0KbmZzX3BnaW9fcnBjc2V0dXAoKSBhbHRvZ2V0aGVyLCBzaW5jZSB3ZSBoYXZl
IHRoZSBmb2xsb3dpbmcganVzdCBiZWZvcmUNCnRoZSBjYWxsIHRvIG5mc19wZ2lvX3JwY3NldHVw
KCkNCg0KICAgICAgICBpZiAoKGRlc2MtPnBnX2lvZmxhZ3MgJiBGTFVTSF9DT05EX1NUQUJMRSkg
JiYNCiAgICAgICAgICAgIChkZXNjLT5wZ19tb3JlaW8gfHwgbmZzX3JlcXNfdG9fY29tbWl0KCZj
aW5mbykpKQ0KICAgICAgICAgICAgICAgIGRlc2MtPnBnX2lvZmxhZ3MgJj0gfkZMVVNIX0NPTkRf
U1RBQkxFOw0KDQoNClRoZSBhYm92ZSBpcyB0ZWxsaW5nIHlvdSB0aGF0IGlmIHdlJ3JlIGZsdXNo
aW5nIGJlY2F1c2Ugd2UgY2Fubm90DQpjb2FsZXNjZSBhbnkgbW9yZSBpbiBfX25mc19wYWdlaW9f
YWRkX3JlcXVlc3QoKSwgdGhlbiB3ZSBkbyBhbiB1bnN0YWJsZQ0Kd3JpdGUuIERpdHRvIGlmIHRo
ZXJlIGFyZSBhbHJlYWR5IHVuc3RhYmxlIHJlcXVlc3RzIHdhaXRpbmcgZm9yIGENCkNPTU1JVC4N
Cg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

