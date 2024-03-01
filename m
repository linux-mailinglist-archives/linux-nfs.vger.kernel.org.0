Return-Path: <linux-nfs+bounces-2139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4C86E5A5
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD28BB2514A
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902C4411;
	Fri,  1 Mar 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="DDVjXrGV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (mail-bl0gcc02on2114.outbound.protection.outlook.com [40.107.89.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD846A5
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.89.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310725; cv=fail; b=PmVBbC6PR7k2imLlZWKzFD8qlOcpP3ORQuwTpjmQ78wfEswoPXiN5+WEfwm5bvuTIBGFuVnDHtkp/a3jCCQZbZylRvFYFWWVbphDMulkAOgKAffDTMWu5i1T/2mUnjJmHatUEultey+3I/9LocQODGsyTRqLKj8UYCpVFmFVfhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310725; c=relaxed/simple;
	bh=kigINiZVb60CoYVU2XtOHtSFYlsFYAdYMqxP/XmY3R8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IY5+m0Phq0jEIpMhc0GU/iydpYNZ40ThMZ9i2bWfm3zQ2HiMGLB7e+oC7h4Jnj70fVOK1SXmgkKOxYHS9tKQLep+ZB3Y0sL0jx1lH7tI2opzg17CmkJTmyN9byVqqPUAWaAs/bz47Kgd3tO6DVujb+NyM2QJSHoWY5okaJIIgpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=DDVjXrGV; arc=fail smtp.client-ip=40.107.89.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6Qb915NiHIQfxdVU6IHSniedXFifoXISFKHaLPEYE/n0Dm1vv2X+VFncc40QhqQRMeHRDC3x7zEfKGfiZYaHdFH9fHtkH3fUfh+QBaXrUcbrrT2cj3loePg9ytQ0UPj1AWlNgzKNTwGVRdipTHk7UR1PmTQ4AEQd64VhzuYlSrznwB7e/i3HRazzs7Oaba5zNCw6Tm/hbteFGJ5sGCstQQN9KgCVfYxV71k5ZO+AyNdw4PYAqw1UambFYKhdu6nIa6CU4NgrS8NFfIUkW0PjX7R7t8JRHrfrO5/sModAiEHV9a+EnffyOHd9y8080VZ0TTX4tPzOWSOl24WSkPeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MSr2eAKeuaEuVB8KJxDAoGI3XCy6MalHzFGBbKt5pU=;
 b=nFszLIcam93MlWvXlIALt1Nx3/AGIAFJe0jZa8K0di3qqITPSGeEgo67BnFw9/ctrA8odEtOYywqu3FrstiooEUeEJocy8xpI8ADJgNWa351J3OcffjFO75jU5MFq+SVElHon6Vj3s/YCclWlPrJ2ZaD9bkUvJDJ4IM45F2jUFSiIcVsVpu+d3VFOpYREDJZHHP3ruCLq5UfWtT25plGATxFerB08bE8yHRmHqxnsL0WV2DgkC3X5j68vjC3hmdpjk65XPCyhZMfBEEocDUAUBZDKkfhrTIlL15uwx9U23lkTAaiTYtZFKm2O7XAxrKyLduRt9lQve7qltSh2s+mHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MSr2eAKeuaEuVB8KJxDAoGI3XCy6MalHzFGBbKt5pU=;
 b=DDVjXrGVHayKide98W5B0YaxtuaJs6tZtmD1mnx0lbrVwBC7aJAZ175qPx82iYW8qBxwr65xtIdNJAo3xR6J5XwpYj0OCdbzvxgp7p5rY/3YzPZryqcuXf2KfDWGNFf+PSNa+X/W+QJli5HIc741WWvoaeTluNt9lqkwzB58HI+IfbBDecXp6dYAe5c4tULt4r2amCNuVEyQNDcfXr+KSzXvQSfBnhxZgU/6XoOjBFNEERAoJMLkf0Sx/yb9aZke5V0n3nke2Sfsy7XneeyAOoLmi+cl5mybt4GkXeCay9SFkrZWTuVWgH8Xy7pm1+jH5CcTsMdkVBAfeQ4dKTB7tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from MW4PR09MB9632.namprd09.prod.outlook.com (2603:10b6:303:1f8::17)
 by PH8PR09MB9982.namprd09.prod.outlook.com (2603:10b6:510:185::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 16:32:00 +0000
Received: from MW4PR09MB9632.namprd09.prod.outlook.com
 ([fe80::8d34:e911:1a99:5242]) by MW4PR09MB9632.namprd09.prod.outlook.com
 ([fe80::8d34:e911:1a99:5242%7]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 16:32:00 +0000
Message-ID: <181e6547-a0ec-4c02-844b-bf1eda464acd@nwra.com>
Date: Fri, 1 Mar 2024 09:31:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Cannot initiate mount with sec=krb5 as root from EL9 clients
Content-Language: en-US
To: Scott Mayhew <smayhew@redhat.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <8b16410b-6b2b-406e-a669-41abee137932@nwra.com>
 <ZeEYttbCcrqTUO9z@aion>
From: Orion Poplawski <orion@nwra.com>
Organization: NWRA
In-Reply-To: <ZeEYttbCcrqTUO9z@aion>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000205040807080005070301"
X-ClientProxiedBy: CYZPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:930:89::28) To MW4PR09MB9632.namprd09.prod.outlook.com
 (2603:10b6:303:1f8::17)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR09MB9632:EE_|PH8PR09MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: 414c39b0-5072-49d6-27db-08dc3a0d1eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WcwBebdjUa8h+0J/n5sqDnKBslPisYPWEi4+VikNJlwWalQ44zmQ5Cf/ViP+hxzqySitKiHxQEat4zwhs2zsDH3AZJk8TLlR/eqFgRgf089rSiOuPxCi5xfi60UeuITQnE0QZ3ouBoILxL7/BatIrBcWxDoBM+x7Bw7nxLTFznS45XNYkHdx1CecEEeKEMgJRtCPXP4xbgVM92YfWeWAggsqjDB6AFz3+9O6bzub/sh/R+G+/JaydXCi/cjEU6UHqFZj5hdpFEGL5IynIN6nK24Ha2Vvl9I69u5xmSu5Be07Cf3YFxYycrv48N/1WXZeUpVOW3t3OtN5o/bsujTSUmRmIxuJbxgw/ekxBE7JXDHdX8adQJ2GYqNQisesU5lUTa5ZUb0B3rIh7+JOqyIPMaZy09vWam/bvEF9hCXPh048zBKehXNPY0Ob40VlU4RcWZSEslWX4QDD/E8J4oCTfNcC6YHGGLcWkXgv8ECLU4uDNP+HZBS0yIzmn1sHV86kqretu7IeFYkrql+7oXcua/wS8RCo9Dv+itQjFbQmXThmZ8HZFlColZbjIBs+M9dqfvH4Vd9aPE6Xu4zCwdiAmWcd506r05NzS/PJX74JxfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR09MB9632.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(41320700004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGlEUWpIVFpLVTdCRE9OTVlwRFZYWWx1WlYyNHliMGVIWnVnT2lMSWVhUmJ3?=
 =?utf-8?B?SCtLaXlnNWQxMk5kRDhsYS92ajB1R2VjbVNzYXFFa1dzSDBTUDN4bTBkMm96?=
 =?utf-8?B?Q1NjMktXMFdZMGdXS0hVTXo3ZXVXSGQvZXFkU0p6dFdmZllFemo5MHJ3dkdT?=
 =?utf-8?B?dEhTQStRT0JhbHM3dU5rOEZZZGt5cW5hczgwTDBJN3dlSk5ObjdMcFEzL0Zt?=
 =?utf-8?B?VE45K2RVVEZlT3JyRDk3ZkxZdW5IRTc5a0F6VzNWU25VR1A3S0hPcWl2MmY1?=
 =?utf-8?B?MzFtVWV2Ry95TGdZZk9GY1NmTVpsQzYwdWhxbHNEWDFYNFB0bzNCNDJnbFdY?=
 =?utf-8?B?M29zN015MENRdUFWWWJ2QVB6NS9KWXgwbnFvQ044cUY2OG9XTlUrQzA3TzZ2?=
 =?utf-8?B?cmVpY2c1SGNhZ3pJK0pxMXNkYjhJOGlwYU9ieXA5TW1TNUtUbVN1RkQxTjgv?=
 =?utf-8?B?bWVtaDI2cSt6SjlhS0lCSWJaOHprYTk3RnltOEIvRDYrZ3ExdXZMa3JyS3Vk?=
 =?utf-8?B?aithQmtteG5ORW9qZ2l1S20zWkFsa1dtcnFxa1BQTVNBZ2h4STdWTjVxbEVz?=
 =?utf-8?B?Z0tQSDhTeEExRWcyUmI0d0xOWnFwRzBoU29WNHJaS01XWmdZVGowa29ISzB2?=
 =?utf-8?B?Kzlod0xkWk9XZTl5T0k0bWlwcno1WjZXTm5MbjJvMUZaSnZDNjErUHhZRzJR?=
 =?utf-8?B?THppY0JibjlPemdCUzFuQ3FNZnFmbHBvRTJFaUo0U1MvVVVKbE1lcW5tTzJ4?=
 =?utf-8?B?T2hyQUFuUlQyN0krQ2YxdWtoUXdSRk5WRTg0YlRURjcxTVd3ZU5VRGJxNTY5?=
 =?utf-8?B?L0Q5NU5EWnFJdDZ1SGtCZVRIeEFhS0Y4aHhxL2daUStvU3d3T1NDZHJHZVNJ?=
 =?utf-8?B?SVpTTSs5NXVNLzhBcTgxS0xHUjIzY2t6c0U2RGZCalJuNHdoT2lpNDBJbzk2?=
 =?utf-8?B?NzRhRUJVdGxjRDR2RE12TDVldmRpQXhvbWNURm9Ob3BPTmRsSHVYN0NhM0R6?=
 =?utf-8?B?cVhRVkN1VFRaMFFyWHc2TjZOK2ZaSjR0Q0V6ZGpzNXh0SnMwN1E0NkhHa3px?=
 =?utf-8?B?TjlZK3ovRm56QnRqUk5zcGxEeGVvR2NqUlFZRUwraDhGbWxqdmo1UXJQZmNO?=
 =?utf-8?B?bmlvQ1E2d2l2c3NhOXZoOHgyQ3ZJR1c1NGsyVnZTWXRZTmJSd0JLMzZhc0ly?=
 =?utf-8?B?OHhkVTlZSG56UlM2UGxEeG9FUUpyU0JodVBTNWNoazZzRWo1UVhlVENPTUJH?=
 =?utf-8?B?RlNHTFJSQytqTkFaT3J0YTlnNDBFY1VFK3R2dFhxZkFuK2NpOEhHWUQ4RUFz?=
 =?utf-8?B?bXR3cm1UbnU1VmJ5azNvZXVtMDJTazJqbnp6TmFuNXVCUnk4U3NJZFZuRHhN?=
 =?utf-8?B?Uzlpbk16R0cwdSs0TTVJSjh0ZW1sZ2hUR3pLczJEM0ZTOGJwZFcrUTQ3eXpI?=
 =?utf-8?B?TXoxdGtPV1VZaFlnd1kwZ1htUW9mMjZWM0lTWGpvK3pSUlJFN3N6WHlIdERR?=
 =?utf-8?B?V2NvdjNtTmRNUDk4SjJsaENPVEVoQzJjeHpTNnBua25JS0VFMWNQL0tmWHY2?=
 =?utf-8?B?YjVhTjZGTnU5TlFZeU5XTW13Ym9yL0dBakFwY2xiMEV6bDBqdmxVaXNjZmxj?=
 =?utf-8?B?eWFlMVJFVU1aa2ZqcTIvNlJrVjkxYnF0emhLNWt5QStxZllTSGhYNjRONnlj?=
 =?utf-8?B?TTR3bU55NWRwNnpndWYxSnEvTnJWVXJJcG9HQ1Z6dnBxRG5jS0FmcFozb1Uv?=
 =?utf-8?B?L2pmTDRxbTRIbGtibC9MSEpzSHlIQ0o0eGEwREJGNU1CRDdWSUZ1aTB2TmdC?=
 =?utf-8?B?RENJek0vRzh0eU5IdjFsZXJpQlZrZ28rOGJCNU43S1pyQVZzbjUzMnpHbFNY?=
 =?utf-8?B?YzZGT0hnWEN2QUI5VWN2aFlvVk9oZjlvd0s5cmE2ck9waFNmZGo3QW1oa0I4?=
 =?utf-8?B?MVpjSmh4MjRMbzhicVBHRmZKclVhc0lEVllGdWEvbG9MOU82QWFlMGFJWU9w?=
 =?utf-8?B?eWlzYjNuZmQ0MjdRYnU5WU1XbmF5SHVoVkx2TkloV1hmMzBzVmk3aEx2TDUx?=
 =?utf-8?B?SmVIdzBJd0k2dVNuMzNzdXNEWnhFb1RYM25CdU9hendRQjI4VUd5cXFnaU9x?=
 =?utf-8?Q?OjzwrtxDYHnZkKSZG9Y6vCWHt?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414c39b0-5072-49d6-27db-08dc3a0d1eab
X-MS-Exchange-CrossTenant-AuthSource: MW4PR09MB9632.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:32:00.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR09MB9982

--------------ms000205040807080005070301
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 16:52, Scott Mayhew wrote:
> A quick solution would be to do this on your NFS server:
> 
> # echo "mac@Kerberos = -HMAC-SHA2-*" >/usr/share/crypto-policies/policies/modules/NFS.pmod
> # update-crypto-policies --set DEFAULT:NFS
> # systemctl restart gssproxy
> 
> but note that would be turning off the SHA2 enctypes for everything
> krb5-related, not just NFS.

That has worked well, thank you again!

> Or, you could test the patches I sent to the list yesterday (this would
> be on the client, not the server).  The problem is those patches don't
> apply cleanly to the current version of nfs-utils shipped in EL9. 

That's a bit much for me at the moment.  Especially since the above workaround
is acceptable to me.

-- 
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/


--------------ms000205040807080005070301
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ClEwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggU0MIIEHKADAgECAhBOGocb/uu4yQAAAABMPXr3MA0GCSqGSIb3DQEB
CwUAMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMw
d3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYD
VQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIg
Q2xpZW50IENBMB4XDTIzMTIxNjIxMTUyNVoXDTI2MTIxNjIxNDUyMlowgbAxCzAJBgNVBAYT
AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdTZWF0dGxlMSYwJAYDVQQKEx1O
b3J0aFdlc3QgUmVzZWFyY2ggQXNzb2NpYXRlczEbMBkGA1UEYRMSTlRSVVMrV0EtNjAwNTcz
MjUxMTUwFgYDVQQDEw9PcmlvbiBQb3BsYXdza2kwGwYJKoZIhvcNAQkBFg5vcmlvbkBud3Jh
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKn5wO5Bjob6bLDahVowly2l
AyCWBHGRq1bSptv7tXpj+Xaci4zpCqRoyqX0Gjpo8BEulUYQK8b7nO7UM3aMLC8H6vyzQ64A
GupPGIKuJg+Qr8jA0ihCVH+duE0bNXfDPTm/8VsXOubmVLPLp0cejxzrEC/RI5l8rdl0sQ+2
QZp9jTlyghB1Rxt2AYVYhVVnRMSJ8RgKp9MLV3qIfHqF1k5MGBIP6rS1afmlGd/yW9IWSB8z
iASPtr/Ml5ObbxtYZG47kCKCS7RF2rI6rGNmK/R6cITRs37dzUfBmagDFV897wAW3tHTyLQM
4vobhmS2UYi8C5voc+I75LYOsvLaXHUCAwEAAaOCAVEwggFNMA4GA1UdDwEB/wQEAwIFoDAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwBBQMBMGoG
CCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYI
KwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkG
A1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLe
a5skMB0GA1UdDgQWBBSZhCz4u7bZ2JjPtNAM8gx3QVEp1zAJBgNVHRMEAjAAMA0GCSqGSIb3
DQEBCwUAA4IBAQA2L6VG0IcimaH24eRr4+L6a/Q51YxInV1pDPt73Lr2uz9CzKWiqWgm6Ioh
O9gSEhDsAYUXED8lkJ3jId9Lo/fDj5M+13S4eChfzFb1VWyA9fBeOE+/zEYrSPQIuRUM324g
PEm8eP/mYaZzHXoA0RJC7jyZlLRdzu/kGqUQDr+81YnkXoyoKc8WeNZnSQSL+LqRvPJCcCTu
JbCdd7C8zYW1dRgh4d9hYooUSsKTsSeDoRkFyqk4ZH0V3PFqa2HiFrdi8h3vpBX44VFddyaa
e+ekomLvvVZWGtJgXWr6VEBo8PTah0fw8BQjCIfFym44D9dulz1YW7E6FRPMSZ7x8X3UMYIE
XzCCBFsCAQEwgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJYIZIAWUDBAIBBQCgggJ1
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMwMTE2MzE1
OFowLwYJKoZIhvcNAQkEMSIEIEdEoWkArdJuzexXlsk1GhKFZCwXxC7nI1e55V7PuXReMGwG
CSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgw
gcsGCSsGAQQBgjcQBDGBvTCBujCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3Qs
IEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5
IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZ
RW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIQThqHG/7ruMkAAAAATD169zCBzQYLKoZIhvcN
AQkQAgsxgb2ggbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJKoZIhvcNAQEBBQAEggEA
JqjxkXJuQFKokLO7iGHMfrfd7y5RwC2kXsHbofb9m3ieK/SgO4uMqGm2ErEvegg0TIQMG7/3
znBCyUdUESwOKHUjvpkAtXzDwoTRLFzJqj8sM4WJZMbS6OxYzff/bn4z4fRKoXmjpCG8W4z9
E6ZazUKNeH0tNxeKacMGBstkkgTxuaBoDkwAKXyrRqBRLBwPF1SgJ9FebY9AZGAXivF/j50d
NyDkdGjCxfc0VtVbQJoyfraCpAvzj/COX9dbPeejFGhrcrKlBKIDKYpMXCIvhzagVXIRqAHr
oPVBYVxbnFRnADuogaV70Ur8Pi3fKMvQ9OSIG7rhs3aJoqY6O3t4eAAAAAAAAA==

--------------ms000205040807080005070301--

