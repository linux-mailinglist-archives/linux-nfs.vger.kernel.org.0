Return-Path: <linux-nfs+bounces-18596-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKaaKZ8fe2msBQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18596-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F214DADC09
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 09:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD73B301410F
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C578D37E2EE;
	Thu, 29 Jan 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CIB91GA+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4E37D11F
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676667; cv=fail; b=rTwM0IGqZIQlv8TVT03Xvj1njhg7JHmTASbO4X9bHrtrZjnXBLWKGZSFUZidpW6kfxtZzqWoFwqCPAgdudAy83RQkw6Sbv4v83H8h5TTSuO7RWeCbX4lQAdGI9t/FS5CebT0kAdJHv+PTRX9kQVJ5RHlEDVrcT0aDbK5YJz/+GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676667; c=relaxed/simple;
	bh=dBr9hlbUtR2qqfldVC6NsOai4aiM2dTyQyc+Gr3+ZiI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VHdiTPKHw6dz6y4lGo/P7ImJhg1Lq69Aahbw1Xkxz5X30qfSp0SNla72AhOXOOsaMrjoKQTnHgOwXVi07RHwPvtqf96qO8+USFc58ZknSrWrKsmmtjvZTEwzaZUQwAYQCayqeWyrjGafrFyGW0XAdZA5SsjwVKOUI3nCdZcBNJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CIB91GA+; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNwJOeWffhBVt0EOqOeAifEoG2DR/e/ZnsjxKQxd6oDhxv6hAtfCSRr69kXr1T4e/qzcX+vF5XTKXB6lhA6fne0PCkcKzv79V/zzvO/xEDXWhPJk3I8WmbsLkZSlGno7X7iRg7mHEWxMIA3Rtn9OfjDc70VneIwA5IsCxA+EtMEEh89+bdaT6QuA1sWp9wwDbLU68TKUCS07eKaktqSqH076d0b+CHX4WdpznENnYaOCrovh9KwZXwVKciGEKY5cb0eg/ApAVhYbwbokhXsI0qaQYO/IUxGlKqW/8Z6NjStH4f6Q2u4Rb0TO1jZkPWcxI6eEurgVyXzVvXy4BLwmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBr9hlbUtR2qqfldVC6NsOai4aiM2dTyQyc+Gr3+ZiI=;
 b=YCoprwPXh7yRMq0fVus+39uoE5InBN6mvTOsNHHyeGM8zqHLR76xq3SNpSgI8gbfWXCVBMMUApoF2dGODYS5ACCfW5t+IXbUz7aOSMbJERvTmVR730wfD8WgCLARwLWFKsWBW38Olqisu724yJ6wzRMAmjJ0CMif2VvV47N/rrbPx16cdQgHfPrTr/aNKZuJvpD3+BeRGPkOSI8LwKZOtOlCF4+GuWWUh4pjsRkpeX08iGhP53MMoxY3SPj8Z35SKhjtdzi/lxp6vIjrvDV1JqjhDUfD7oYrU6dqwqRZsbNXSrI7dI/d/vtqNbnjL+au/4OgJ5gMU8I6vc+E0I/Gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBr9hlbUtR2qqfldVC6NsOai4aiM2dTyQyc+Gr3+ZiI=;
 b=CIB91GA+ecT8WI8bkLRvadI62dIh1A0OvMAsoISwWH80f0EIc9EgxSbW/FgDMXrtw8qfdkpSYRdgU+dHBwuS5PqEvwtTOf7cM6qtp4MF+uR7iLnGwUM7lWZSFs9JPXlv7VFxFOjVVS8xlsJOjIu9w/InSWeGU3TF2Tf95OlxAcoWDlCAcg/6VW8ckM7vtKhFXRKLA7UcHNlFofdbnUZWe53J3Qnuh4a9F4c6jwLMVohmkXHHyC5Vr2OanwijdjJQlGPSaaUTHOkvx89dYe23AzTdYpVxGiR+tMh17YIy8DlrfGIwj3RmmdJZC+lStMQBwY8BTL2TL61O4HCMIAqmeA==
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com (2603:1096:604:1b4::7)
 by TYYPR01MB15165.jpnprd01.prod.outlook.com (2603:1096:405:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:50:56 +0000
Received: from OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a]) by OSZPR01MB7772.jpnprd01.prod.outlook.com
 ([fe80::5956:959c:6018:183a%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 08:50:56 +0000
From: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
To: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
Subject: [nfs-utils PATCH 05/10] exports: fix a typo in man page
Thread-Topic: [nfs-utils PATCH 05/10] exports: fix a typo in man page
Thread-Index: AdyQ+oim1/RbgxUlRwCH1RGB8luhhA==
Date: Thu, 29 Jan 2026 08:50:56 +0000
Message-ID:
 <OSZPR01MB77727A02A5B4351AD06FEE0B889EA@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=12c6d796-429e-42ed-94eb-8c8438107692;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-01-29T08:34:13Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7772:EE_|TYYPR01MB15165:EE_
x-ms-office365-filtering-correlation-id: 54dd796e-582e-418d-bd3c-08de5f1384b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?eFN3QStwSE5Bd3UvdlczYlZ1ZE1vZFVBRi9BLzhndjlsYmgrTTYvclgz?=
 =?iso-2022-jp?B?dTRhZzNaVTlIM3ROdVpxV1hVbVZMMkRRK0NGdEsyc0xiemY0Zm85cEkv?=
 =?iso-2022-jp?B?UlpvUmk4SndQZ1Vyd2FRNXZITUJYODU4ZVo3YnBuY21hVSt0YUZjaWRk?=
 =?iso-2022-jp?B?TkNiYmlTelI4MjMwL0IyUzlFdmREUDJRckY4ZzNqeUVkZnIvUk9UZjRr?=
 =?iso-2022-jp?B?WHI5QzVrclZXY2ZadUNnS3poR0wwZGtzRU9VZkFCSno4Vk0zR0lJK0h4?=
 =?iso-2022-jp?B?cU0zckxzSWVTYXlZN2gxaWxFYnN1emladUU0eVk2WHJSRjR6cWJMZWcz?=
 =?iso-2022-jp?B?WXhmQlQ5V3RoMDREQThLNThDSUMzUFJMamViRXZDNVYvWEljMVF5Z3hs?=
 =?iso-2022-jp?B?RDJNOU1EbGw4Y3FjTUREV2dOZ2x4ZU1hcytBZDlCeDZmdSswcE5pUmFx?=
 =?iso-2022-jp?B?SjlWQXZMTlN0WnYvcFZtNnNIYmkweGtNQUdhdExEQkRZMTNrTXRDMS9u?=
 =?iso-2022-jp?B?RHFvWHpsOEk1MXdrc3RHR2M0Q2pMSXhEK2VqZXhJN21NRVg3d0NZR2xv?=
 =?iso-2022-jp?B?YnB4Tnd1bHI5THQ2UlExd2hwVG1QMzkzckNaN3ZxNkNTZ3NLRCsxSDBR?=
 =?iso-2022-jp?B?T28ydGpnd2xXaXg5YnRaWC9lWlA5cE5ybnc3OUtaZURaQ2hTWFJqOG1R?=
 =?iso-2022-jp?B?SjBocWY3dEI2KzljTDI5Y3hoVUxXTHpTVXpydHJ4bjFrb1B6TzJqcVl1?=
 =?iso-2022-jp?B?V01WSHR0TzBtc2FRaktHdEtzLzVsL0x2M1drVFBVSm0rM3ZnL3pCK3dE?=
 =?iso-2022-jp?B?MUNldzJ1VEhLOXdBWk9Ockpod0NuTTdYOCs1c3lKdS9rSUQ1ZUFJSGJP?=
 =?iso-2022-jp?B?dEFoQy93MmVMWjBocDZLMXRuRjVYNTRza2doTWk4R3dNVXZDaXFBYis5?=
 =?iso-2022-jp?B?azhqY2YxeVl5djZKY0FUZFRMcjdvek9SVUhEQmg2NnJWN3g1SVpmNUl5?=
 =?iso-2022-jp?B?Uk9kejBRQUpsdDRlT0VnY1YvdjhTNkVCdUxEaFhldVp1OVVHUEMwellV?=
 =?iso-2022-jp?B?Wm1ERFYvSlRjaDArUy9Wc2ZwUllsblhISDRmR1RQQ2dqdEx0dTZIUk5Y?=
 =?iso-2022-jp?B?aXZ0Y0cwZzcwZkwwTGFhQnhOWlpCbHlSeUp2ZmlmLzdWMEJOZXA5QUFx?=
 =?iso-2022-jp?B?cThZVHM1b3B1OTVTU2NVdHNnSkllQkxFT3lqZU02K1VNVjdxU296Z1Q0?=
 =?iso-2022-jp?B?VldSQXNDV1pJblV2Z2FyM0NpUlJiSEhTWHhzYnA1SmIzSW9xQWp1SDMz?=
 =?iso-2022-jp?B?YjJFMFpUeXEvbWc4cmxCbFhZb29BcXJJcUh5WmxnaTIvRXE2VDdnWSth?=
 =?iso-2022-jp?B?NUFIbFFESzJiZ0hkUkxVWVcxd29UWlBlVHMyWDFzbVBqUTdaUmNySGV4?=
 =?iso-2022-jp?B?UE1RV1BvWTFBc3MvTkhMa2h2aUtJUmdYVXNCY0lYTzNPR1ZDQlByMWhl?=
 =?iso-2022-jp?B?SmlGMXR6cGZQbjdDSWFwNjA2RXA0VE5XWUNhTXo4THNnb3A0c25yNVFG?=
 =?iso-2022-jp?B?cmt1L1RqZml5UzdWTEdPVTFNVENtQ21mL3JJVkZHNmpXZVdkUHR3M2NL?=
 =?iso-2022-jp?B?K0JtZU5DUFI0dUY5TnBDRGtLMnVtV0tIejU5Mkh0cS9ZM0tVcnN6azRH?=
 =?iso-2022-jp?B?MWlPL0ZuMWZCTk83UU1ReWZJd0s1ckxoVHZPemxxdng2aldvZ1lBSHlU?=
 =?iso-2022-jp?B?bko0Sy9lZGhzOEwrSGF2MEhwZ1duZHJlbmU0UGxiYnV3STllWHZmY2xE?=
 =?iso-2022-jp?B?czVDZUFtSTNrNVY5NzBzUktQNGJGWXA1SEVFNEVtMGo4NXBVcDN6bm9D?=
 =?iso-2022-jp?B?SlkrKy9QOU5Sb2FnZzJheHg1ZHNBOWZ1RGNiM01yNVlYN1pNQ1crNyta?=
 =?iso-2022-jp?B?Tk9FMTRadDg2R3p6Umx0TkVtbHNCTnFVRExFUy9la2FoMVkzL1VKNE9Z?=
 =?iso-2022-jp?B?bVFnVU1JSHh5MU5QRDM3Q01PSE1CeEUxUW1YOXZhT2l2aVlYdXU3MXBD?=
 =?iso-2022-jp?B?T3FqRzdneUxLc1NqWWthKytwMWdydjB2a2FtWndyY20wcEt3eG5nY3JX?=
 =?iso-2022-jp?B?UnZseDl1UWVic0xwdTJjTVNwNGZ5VFY3QmFZdEdhNEpCdjZ2ZDhoaVlG?=
 =?iso-2022-jp?B?dmZtR2JZakNhVDM0RVNDRjBwanBocjBscTk1TS9Fa2FoUFdaMU1LcGxL?=
 =?iso-2022-jp?B?cGdmU0dOQVJNSndITkh0NnMrVDc4YmpVUGV6NldBbmJzRlNqSVM3RXN2?=
 =?iso-2022-jp?B?RExHMElua0hXRWxUbWxXT1locTd3bnpKUE1XczhVSWxCT3VFRmlISVFx?=
 =?iso-2022-jp?B?TjBUMWM5Snk0VHRUeXNnRmpuWnlYSzkrVS8=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7772.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?K216cWtXL08zb01NWjJ1cG8zbzg2YkxqdXNMazBjMEdrQXlERmFsc3Y5?=
 =?iso-2022-jp?B?dzNkN0xnNTZxbk1CVEZqYUFhUlNqRlFFbENYZnZ2L00ySUxyL2hXV1Bk?=
 =?iso-2022-jp?B?ZytqMVhST0FVUi9LcXVqcjAzR0w4RjZvcDlOSXBZdHZqMXZ0bWRTamtW?=
 =?iso-2022-jp?B?N1Mza1psMnUyemZNUzVyOElMM205L3hxbmpxMjBoU3BKemFtcE01eC9E?=
 =?iso-2022-jp?B?V25NaHRndXBYMnc0a0hENkVCV1llTGtHTlFVQ3c4eEhadFk3TVFuZUQy?=
 =?iso-2022-jp?B?OHhnM3N5Lzd2Y2NHUllMc0J0aDNGSzVkckdVQUlDbGxLOTRYTU9CZGhn?=
 =?iso-2022-jp?B?Y05yOS8rRlk2THpyWHZTWVlvcEh3OXN3Yys5bndzcVA2bU1jWGpYNSt5?=
 =?iso-2022-jp?B?QnBjVWpYWktOZC9IOWk1YkdySitudW5PekRTZ1ZFUWhOUlY5ZjZBQ3pC?=
 =?iso-2022-jp?B?SE9SU2t1dlZoSWlqaWppNitPWWJJRWlGa3ptN1FzcXhiaFhER2FpY25B?=
 =?iso-2022-jp?B?WGFreWNWL2Z3Q2pnWW1FU0ZEMWN3MUZ2ajR4ZW03YzZObTA1ZGQzMVIx?=
 =?iso-2022-jp?B?eVdhZ3d2S0V2ZE53aVpoNVUzNThBVVNUeDBLU1BML1RMdy9ZUUhUOHV1?=
 =?iso-2022-jp?B?a0pyakhpcElCaXBiYzNDVjUwTU9SVEsrQ3FLYzFwQWlTU0hUdmFoVVZ6?=
 =?iso-2022-jp?B?YWs2WWtvZ1BmSkk3YlRlL1JNcFRyNlhiWHRzeHpvclNiKzRxUnZwdWtV?=
 =?iso-2022-jp?B?U1FXbnlwb0QyK0FYa2dxdlN5c1JncG5WSVFZT1F1ZkE4bjRaRjRYNk9P?=
 =?iso-2022-jp?B?YlpHUm8wM0tudTRlVkQ0bVVrMTFQOFFTd3pZaUVmVGt3Yk4wdmR2R3Aw?=
 =?iso-2022-jp?B?cTVHSXZQQVRla1NwWEMwdWViMWJkWjE4TTZwYzE5UHRvUjNjd1RwVzRS?=
 =?iso-2022-jp?B?dFVxdjFpdHRWMzJYVEpWeEppVTdtRGZSZmVMYzU5bTQwMDNXUmFuY2Ji?=
 =?iso-2022-jp?B?WjBiM05WV21ML1NiaUhqMXpoYjJWdGFXNnpiOGJLTXB3WmFHcUZ1RFYr?=
 =?iso-2022-jp?B?VzVtNktHMkRvZitXLzZHdktMQXRmdU41b25GSm10TUIzM1F1MVpvNXM4?=
 =?iso-2022-jp?B?Sk94SVVuQzhIT1Iva29kL3NtRFc5QTloeGxOZFcwZTI0V3pwRWl2Tmwx?=
 =?iso-2022-jp?B?M0s3aDY2cXVBWjR1TGNTTHEySUUvMFQ5YzJsVUxqSXQ2U3RUWUpLZG9D?=
 =?iso-2022-jp?B?ZGZqeVJFcEtrY3JzT0FhdzEwdkI4THZDc2Q1QVpXMFJEbGN6Rk9KZHpz?=
 =?iso-2022-jp?B?TW16TXdYUEhiR0NjQ0lBN0ovTmpGRm9XWmJwRlhzckl5eFFkSjljU2pm?=
 =?iso-2022-jp?B?WU9WSDJ2WWthbHVZTklFY1BHN0pjVkZ4MGYxN3RFYWNsaENxUjNGUUpa?=
 =?iso-2022-jp?B?MmlOL0dINXgzU3BzY2k4ZzBja3NRUUQvTDhtNThBdkxHb3RzbWdzdEFN?=
 =?iso-2022-jp?B?OEFHeVdYZ3NnN21OZ2dQcEVMd0gyZ2JMaWhPZWdLdk9Jb05tcVpXRGpL?=
 =?iso-2022-jp?B?azUrYWRRODZ3SXU5Q1NHajVGaU90UlpIVDN4aWdQUWlqY1NXY1BmZzQz?=
 =?iso-2022-jp?B?QjI3WUpTZytKTGl1eEZrNmg2Y1JjU1NjcDM5T3VscmR5eFpPUmVsZmt3?=
 =?iso-2022-jp?B?WXRibUpRaGQzSUFLazYxRS9FUlVFWEUyRzZFeXd5NzViaFBzK21HYWJU?=
 =?iso-2022-jp?B?YmRHTFNmQlFTRmZtU2NzRi9aT1ZEMnUyVFBRekhDSVB5NTVsS0h1L2tr?=
 =?iso-2022-jp?B?QkhWVzd1Z00xRkVvNmRnUWhIZGFOTHlqWlZtT0Uwbk9jZXE2QkZkUjdV?=
 =?iso-2022-jp?B?TkhCREl4K0sydTVCVURIaFh1TFhoc21Ec0V5WmxuVnZDdnNkd3BOS0lH?=
 =?iso-2022-jp?B?NVRMajR1U0o0RExHVm5ZejNZVzBmSEFPZW5QMkM5MkJNY1RVaGhSa1BQ?=
 =?iso-2022-jp?B?WHJVb2h5ZWRnZ0lKWXZlajJsb2puNDh0T21MODBDYkxDYUxrVkJ0RDRp?=
 =?iso-2022-jp?B?RE5mU1pqQmRZbGpBVVdISkJpZitwRzVZRFpKZjY1ZVZ6Y1ZuTUFkdG0x?=
 =?iso-2022-jp?B?V0JLTWVORWpnWVgrcE10WWpselVROGtubWZXK014VFhLdjUrNlhqckNa?=
 =?iso-2022-jp?B?OFhzVkpmWjU4NDB4VkVhajQwQW8wVVVCY3BnRnQrYURIdkFUdTVKY1ll?=
 =?iso-2022-jp?B?ZHNSSTk2WXQzYUlQT3QrbjVmdWZQZkVWWW8zUVpOVklWN216QVZNVkNp?=
 =?iso-2022-jp?B?YnBpd09TdThJOEtRNVV6aTFlYUdlQWVZR01aNE9kQ0JkSGtTZUUzcGV0?=
 =?iso-2022-jp?B?dlBhZ25vRkJCK1ZEQWd1MnBRVVd2VnZmOFNZMDl1UUdlZFFrNk9DY1Er?=
 =?iso-2022-jp?B?em5wOGRBTXdzSFEzdytFdzNpUFl6ZzJRL2RoTi9LejB2bnRsY0VFWWVm?=
 =?iso-2022-jp?B?dllkb01nS2N1dVVuNkRjNDdEc01IWmFDaXBlUT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7772.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd796e-582e-418d-bd3c-08de5f1384b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:50:56.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyi0cQwBam3xVxk6VkrMyMydK+sWHvayYZ80+dye5RaXeYO0YT2d4R/ZnY6zLJD5PIErWGEoWuDVWt5j052VXChOuAYoeAwhpBgzQ7O+aKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18596-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.ikarashi@fujitsu.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F214DADC09
X-Rspamd-Action: no action

Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
---
 utils/exportfs/exports.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 39dc30fb..efbc6ef6 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -488,7 +488,7 @@ option becomes handy. It will automatically assign a nu=
merical fsid
 to exported NFS shares. The fsid and path relations are stored in a SQLite
 database. If
 .IR auto-fsidnum
-is selected, the fsid is also autmatically allocated.
+is selected, the fsid is also automatically allocated.
 .IR predefined-fsidnum
 assumes pre-allocated fsid numbers and will just look them up.
 This option depends also on the kernel, you will need at least kernel vers=
ion
--=20
2.47.3


