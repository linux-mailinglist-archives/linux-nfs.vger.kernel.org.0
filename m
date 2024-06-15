Return-Path: <linux-nfs+bounces-3849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705E909506
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 02:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2418282BB1
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05F9623;
	Sat, 15 Jun 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="evEDa30y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CC1361
	for <linux-nfs@vger.kernel.org>; Sat, 15 Jun 2024 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718411129; cv=fail; b=uHxzGglbYDl6bxvH8NoYIaA+CaiofuWN8x3wtXrTqKLnVJATmHmeuEAHTTlBM5Ui9DAavN7gifIXo9uYdDRk9bZ8SXjAw70xmkaIUHQFNn3ptNtVTTtkG3fZQOq1OiVijr2j3vo9oNO8W9hCv4gWoXjC4kWA8dw9wM43a7yDtLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718411129; c=relaxed/simple;
	bh=hYS6clwDj5ic7tyMZaMilGPRk/N5mFzBkJEPJeg7hhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EMncIommAoQkEELj4mdLyVV5etZDZ1/AJdyrDHS/kuN030jrkj83Mx9qo0yRYEWr3OTmDCjLbevW78aHQR3Sjf9GHnhROlNv8OiYsymHJZW/xaFYtCXdsF5CYMtGgyLz/8lgSPklZP7b7Bh+rGXOjqBGALrISQ5uo4oPOgYHcSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=evEDa30y; arc=fail smtp.client-ip=40.107.237.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXUH9FF+odAMIY/ALWkQ0vvHz7W1uzA9nm/sjikHUt2Tlxfch8+vmoLNYHo2/6aFUkpa3FUpUiDNKKi4kSOpHcmZDVenuoh/7VSeMD3xcZsnOjJliHpOl2wn4YVrsKkbneHPfubTqqp1h3c/4pfURmX32XHh185V0EcvuV7/2av/BccSNKcXG3fHOP5pWoIHcp8+/8ZZ0M2F0PaAm98NKaTgA3S7Y6GhI4bCWuVG0Dmdg7u2B9fuE0NOM1EruJLGSj/2FPz0Itur0ipISRbHfM3lJNvkceMhUER7E9U2/7YfeXoDNafQhceGcxgXCHRk6j0VQmTv7VdArnYoR3fX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYS6clwDj5ic7tyMZaMilGPRk/N5mFzBkJEPJeg7hhg=;
 b=dbJQs6SI8ppD6w3As3KhzYJVfQ2E3AnmLBqbQmTf5z2k5wei2fBnyjBrmtb/wSJq3lM8Lc5VFzDDC9U3G4b4ljJoyVEMNpp3ZEV2wKbX2JbxyXVIDmJu87so7PiGmmVq5tq2tI13Hqo06YhoAfxzCaBZEi2wmUOFViLVTE5P3VTwrvL4UUb4yEpa/N1LW+eXJl6yBvrXVgkYRO4JQOkvRRsRgQ4oC3tIQyEW+XTfXRFkoB3IFoibsfV41qC3Oc6NE82YXOMOO5NFri+NPpO8gYTa7OKAhf6BHxmlEag3WJOyocFLNseLlQk9tCcBbECCGCVzhzs1W/yqHyWr0cn3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYS6clwDj5ic7tyMZaMilGPRk/N5mFzBkJEPJeg7hhg=;
 b=evEDa30y2THsHJ3k2PnLT9e96YBzyc+q9Mvfb1U41hoTsteLFS9842khiDc6g2AbXDJsSJi+lTj+MhHCBgv14Zb0IP6DqnO/zrw9QqJReLfwW91sXpENlFXGMVLQJeoYUpgHyu0SBccizwB+gsg5b+c2AboIbrlCFeUmOOpZQ6c=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB6025.namprd13.prod.outlook.com (2603:10b6:a03:3e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16; Sat, 15 Jun
 2024 00:25:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7677.024; Sat, 15 Jun 2024
 00:25:23 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 12/19] NFSv4: Fix up delegated attributes in nfs_setattr
Thread-Topic: [PATCH 12/19] NFSv4: Fix up delegated attributes in nfs_setattr
Thread-Index: AQHavUi0gMtnQJb8rUyAZH08NRiFi7HHdl2AgAA5xACAAEpQgA==
Date: Sat, 15 Jun 2024 00:25:22 +0000
Message-ID: <8ef1bc16395921e6521e306c89e3c880e14ce662.camel@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
	 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
	 <CAFX2Jfk7u37+AOX_o1ZRf-QX_abSDXpKaEpHt=iOvL5Bq6opTQ@mail.gmail.com>
	 <bddef727ec63731061a7c80f477f8dc112085b0a.camel@hammerspace.com>
In-Reply-To: <bddef727ec63731061a7c80f477f8dc112085b0a.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB6025:EE_
x-ms-office365-filtering-correlation-id: bf2a95d5-c17e-436f-b746-08dc8cd1a555
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2ZoV1VyTmN2YTBIZ3FKenY2NVhpZzRuOFVwcXhDZFZjUVhMdlJ2OEU0U3Yz?=
 =?utf-8?B?cmN6WnZlQXZOQnBkSjVYUE5OczNKM2tpTUlPcWwwZzlzcDJSRTJnMXo2S0Nv?=
 =?utf-8?B?U3VRSHJpd0Z5NU1EYVUyZ2ZxcHRTRGc0QlB2czN1cHBMOGloVkY2S1dzejVR?=
 =?utf-8?B?K05MMHVTaE9pcUNvdEdOWldoajhndXRGZEd1WFNrRzlmS0JZTjh2T2Rrbllt?=
 =?utf-8?B?OU9UVWY2eTR4TmRBZlJmT1FOZVE2cDBZdEtNT1BiVVBrcnExSVFnTUR3YXZp?=
 =?utf-8?B?NmMvNUZMbUIxK2xEZitrR2lnZml1UmJjaG9rV0thc0pmNGNEekYvZEN6eEoz?=
 =?utf-8?B?aU1DYW9MZkNTVGVLOGNZanpWQlp4QWppVlorZUtsSTZvZHhNc1BlK1hOM3hK?=
 =?utf-8?B?SG1LS1R6Zm4wcFd3ZDBVbWRVeUV3SkgxK1JQWEZUcEkrRkE0RWZpYnFvek81?=
 =?utf-8?B?Y3BHRFhtY0dBTnZlRXkxd0U0WWlhdWFjeUhpU1V2NlIrNTdJOGVhNkx1VmFH?=
 =?utf-8?B?N3kyZEFTV3pWamZSbnJuZkY3dEtRN1YyaGcyWFAwUWNQeUhkV3V6a1JCOXl1?=
 =?utf-8?B?ankrcmhBTTR6dDFCMll1TVFZOXVJWmVFaHplMzd6dzZwczNsQjMzVzJHR2Qz?=
 =?utf-8?B?SmlsOExnSDRST252c0hFNHJBNmVOQmRoNGpjZC9wUWYraThUb01PdTdEME9P?=
 =?utf-8?B?TjZOWWlOem4xWXhSVTA1K3NpNmpSV1NNamdRQmRBM1dzYmloMitWWUJxQnlW?=
 =?utf-8?B?MU9mWnRJck1pV1dtbi8xMVpQOC9vQ1dLNkhRem05bnQ2bm5WZ1pHQVd1dlc1?=
 =?utf-8?B?Vk1keFk3Qk9KZ3dkMVFUNUpFbi9kWGIrdDl4emg3L2lUTGJ2WGF2VlJ3azFB?=
 =?utf-8?B?dlZCNkRSN2hGeVNTU2ptN1pFbnV0ZjlVbVVHVEIwd09CZEo4L3c4VVJpNnRO?=
 =?utf-8?B?V3Y0OXhod1hRUUk5VkN6eGYxY093M2FUK0h1b29aQm1MN0dHVnE0S2ZHWkpX?=
 =?utf-8?B?U0MzTGpuNFNpTnY1QXZmR0J2USsvUFdEM25ETEdWODdHdG1sellLTUtjKzV4?=
 =?utf-8?B?MmhRS1VEcWJtSXpoeVFqa1gyYUVYYi9vdkp4R0wyQXVVbTNQQmhONisvRm9a?=
 =?utf-8?B?cElydjVtVGlqUno3OTlpM2MvRlFaU3h4a0VERHZPUEdLdFV5NCsrV2pIZ2gv?=
 =?utf-8?B?Unc2WHBmeU40UzF1TmFwTGR3VUtQVk1HRHZod3dMOTM2Q1pDeWFuRVFGR2lY?=
 =?utf-8?B?V0lXTDcyUGE2NVN4VUFWVkdiOHA4c045RjhNMnR3Qkh0MGZGQXVUWDVYeEFK?=
 =?utf-8?B?aDNzRlhNcnhaNnlWOVNtd3llRnIyRm1WQklxVUJteUJsUnFCcVIwRzdGUDlw?=
 =?utf-8?B?QUQ1NUdUY3ZGZ0lkRzZiSFRtS0dlaG5WK28zZy8zMDJnd3FGb2VIMk5ldXVm?=
 =?utf-8?B?SVFWTjA0SHd5RlMyQWphTGlXUEVweW1yTkFtS0hoYytIQ2FINW43V2FUekh6?=
 =?utf-8?B?UFpJaTVKK3NUd2EzU0ZpU3lvSEpzVDB2cDhMbU5KZlVQd0Z0L2hOcm90bEI3?=
 =?utf-8?B?eHR2VzhweGd6WW8rMFQ4UHJtQmRxVENhbGo0TUIxZGdRMlRpcExSUjVORnNU?=
 =?utf-8?B?OW9BWTcrVnFSNHcrQ0ErOFZNMDBFSXJFREFZVDRtaEN5cm41WGMyNHpuNFVC?=
 =?utf-8?B?VVNQU2RUVE1nM0RRZWtkVkFFQ0V2YmdIRXUzc25jV2kzTzN4eEMvTTJBS2c1?=
 =?utf-8?B?WWRJT2tUSHdzMGpOYVU4VUNjVXBLeGVJcHo3VmZVckVmcy84ekpvYlo1VGpN?=
 =?utf-8?Q?xLhb73i9+ris3cbn/z+6XUi1INht4t79Mnyt8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW0vdit1dzRNWmc2bWsxTG4yR1pkRkFGUVljZmZublNsOVNXenZKUlduR2tn?=
 =?utf-8?B?dHV0ZE1JczZGUU5aSG1Vd0J1aFBHWGc2bDkxSExLVnh2eG1GSFlJZ0pKUmxt?=
 =?utf-8?B?RFQxSWZCdURuS3FpRjNMSUR2anRQaDlwNVRodDBuaEFNMUJkOFY2Mm5ZM2RZ?=
 =?utf-8?B?b0lxMlFHa0xwZFpNQmI3ejUxdW5GWTk3RDYyMU5Ha2dOQmh6WTdzMGtVRXFC?=
 =?utf-8?B?bWJnQzNNNWJsMld1cDF5QjZuWXRybmo2MlJoMGVJOHY2Y0VILzgveG5FM3hE?=
 =?utf-8?B?OWpicFlZdmdwamdmR2NsSmlFckVjdHhEWi9WQXB1QTlhckFLbzQ3cFpvNlNH?=
 =?utf-8?B?NU1JTTM5NkRRaXhSditSUE1ZYkNNRmZnUmY2dWFaUW9Pb0JWVmdDcWtVc0xB?=
 =?utf-8?B?R3V1elQrZFpkdStJN3djcGh6aHg1WEhTSjdzb3FyYXhpNlpFZEVWSFMwWWpo?=
 =?utf-8?B?cUZlekM5MUoyYWpiNVBFd3VGL3RGa1BPczBqckdyNStZdXdnVDc1UTVnRHdW?=
 =?utf-8?B?NFpNSXlObWZVeUc0SzZ4ZnNkc2srVTVRaXJwSS9iME5jN0NiaXRVZm04UFJP?=
 =?utf-8?B?UXMrVTZuZDFRbTVrcTdNUzVRM2Q3MnBNQUtNdDdxL2JFWWdZUUw2a3ZqdzEx?=
 =?utf-8?B?MFB4ajIvTXBJT0szNnczVkxEUkZDbW1zUjh5M21wanVZa2xKTzlhK1daY1g3?=
 =?utf-8?B?dGNVbENZQ2pXdmYwZEdEbzY4c1pBL0NJUWVkd2NDUWg0TSsyMHlTa0dpeGhP?=
 =?utf-8?B?WXF0Qk5BS2JhbHR5WlhlY0c5STVhRnNEckJiVFdqTjU4dXNDK29VRGtMUWc3?=
 =?utf-8?B?dHExY2tZYzZCM0ZHZngzWnNGZTNVTWJGTmtsR2VaV1JsQm5ZeFg1RVRSaXJi?=
 =?utf-8?B?TEE3ZkNlUk5OcXZXOElwRmtFbDNxVHJMdDRtdk5PRWNNakZDLzMyditDSXRx?=
 =?utf-8?B?Y0RqUHJXY3lpeG1UVlZIQVY1d0ZGMXJRYUx0elF5K3ZJeWFnSUp5VjRLbmVi?=
 =?utf-8?B?Z3dwTHltU1I2SlhscjBGK1l4anJ2YnBsMHAyanY2Ym5lemlUSU04WmhXS0Z3?=
 =?utf-8?B?dnJFeGNPZ0lqS3NTVTc2ZTEwRWErRUtvYmNPbnk2c2lDZXo1SWFnb08xd0Z2?=
 =?utf-8?B?NXozdmtva3JwQzN5OUpKVFZVbjRwVmN4aEJKUzcxem1JTm1UM1ZNTEsyOWRx?=
 =?utf-8?B?Zm41RzJUeEp2endCbXBnOUY1WVRland2ZnBxLytCSlVSdUVUdDlXaTZYc09F?=
 =?utf-8?B?a2x2TnplRlJKVFc0ODhCQ2dFVFdpR3pNVVlGeUROcHFOanZIcHQ3Unh4Y0ll?=
 =?utf-8?B?MUZYWUp1d2x6L1ZDd0ZBVUhBL2NZUlRCNEhuSDg4ZEdsU0xFc1BmSm42ZTNm?=
 =?utf-8?B?OFFzb29ROC9XdkczK3JqUi90V2JkYktETnlvenhlVENtQlRGbHZpNjRqM0FY?=
 =?utf-8?B?d2NOU2NRVzJWZklubDF2VWprbk1wY1Q4eDU5akwyWkc0WElOV0FNVXkzMUI0?=
 =?utf-8?B?QkQ2cnB0UStKeUlqbjdNeVM2eGNZVHVXYXNreUQ1S3pRQTA1dGptWW1QbDN4?=
 =?utf-8?B?TEZlNTFNc1Q5aTBiUk9raHZETlJsVThiR1MwVW1jemUwSE1rUGZlZy9zWTMz?=
 =?utf-8?B?R3dCRW5vdERYaTdjc2M2YncwdmtsSTR5bmJiSlFhb04zeXErcTBZbWt5cG15?=
 =?utf-8?B?blorMWNiSnhOcDE3RU9lSFBwSXdLcWU0TG5iM3Z5T0pyVk5rbjIwV1N6UTli?=
 =?utf-8?B?dEdSTDREYUNjNkQzamx0czdXUENFU3NRZlhXazZyU1FtN2ZscmMvTHNoQnZL?=
 =?utf-8?B?eHRFeFRDWnZyQkpTb3ZkZXY1ODZPWEdHd0MveGpseHBZalE2S0FNR0ZpQUNU?=
 =?utf-8?B?clFUREU2OUtUUlNOMklLUHJzMDhVTmozMWdEQzJBQXBSUDhYVVF1MHJxQlcr?=
 =?utf-8?B?Z2NnVkhKbGZZcVpMMUw2ejNwZFNqOFBmQlQxdSsyWUhEbmpmamVjRXY3S1JT?=
 =?utf-8?B?WDk5WWZIRERERW55U3dhYk5ZTkZ2U2lvc0JjZFZVd0pCWFA4UXNhVW9nK01L?=
 =?utf-8?B?REw0bHo2aFVreUxhcTFkVUdUZ1lLWlU1VEUrTzI5YUhIUTNrN01PZzJ1RUNo?=
 =?utf-8?B?ZU5xMnU0b3BZZVkxakExcThKalF2UUVINWcwRldkandXNTdGaDdZcDBTRSty?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93DE0F027190F4438060B1D628C55AEA@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2a95d5-c17e-436f-b746-08dc8cd1a555
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2024 00:25:22.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5VqSbKrByh0KAGCj+LPEefwGYa85lJPsRKp3DexE2GJF21Qc2wrdZ3u9O9WjiKcl5+Uk8hxEQJbORAqAntjBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6025

T24gRnJpLCAyMDI0LTA2LTE0IGF0IDE1OjU5IC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
Cj4gT24gRnJpLCAyMDI0LTA2LTE0IGF0IDEyOjMyIC0wNDAwLCBBbm5hIFNjaHVtYWtlciB3cm90
ZToKPiA+IEhpIFRyb25kLAo+ID4gCj4gPiBPbiBUaHUsIEp1biAxMywgMjAyNCBhdCAxMjoxOOKA
r0FNIDx0cm9uZG15QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+IAo+ID4gPiBGcm9tOiBUcm9uZCBN
eWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBwcmltYXJ5ZGF0YS5jb20+Cj4gPiA+IAo+ID4gPiBu
ZnNfc2V0YXR0ciBjYWxscyBuZnNfdXBkYXRlX2lub2RlKCkgZGlyZWN0bHksIHNvIHdlIGhhdmUg
dG8KPiA+ID4gcmVzZXQKPiA+ID4gdGhlCj4gPiA+IG0vY3RpbWUgdGhlcmUuCj4gPiA+IAo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBwcmltYXJ5
ZGF0YS5jb20+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IExhbmNlIFNoZWx0b24gPGxhbmNlLnNoZWx0
b25AaGFtbWVyc3BhY2UuY29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3Qg
PHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+Cj4gPiA+IC0tLQo+ID4gPiDCoGZzL25m
cy9pbm9kZS5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspCj4gPiAKPiA+IEFmdGVy
IGFwcGx5aW5nIHRoaXMgcGF0Y2ggSSBzZWUgYSBoYW5kZnVsIG9mIG5ldyBmYWlsdXJlcyBvbgo+
ID4geGZzdGVzdHM6Cj4gPiBnZW5lcmljLzA3NSwgZ2VuZXJpYy8wODYsIGdlbmVyaWMvMTEyLCBn
ZW5lcmljLzMzMiwgZ2VuZXJpYy8zNDYsCj4gPiBnZW5lcmljLzY0NywgYW5kIGdlbmVyaWMvNzI5
LiBJIHNlZSB0aGUgZmlyc3QgZml2ZSBvbiBORlMgdjQuMiwgYnV0Cj4gPiA2NDcgYW5kIDcyOSBi
b3RoIGZhaWwgb24gdjQuMSBpbiBhZGRpdGlvbiB0byB2NC4yLgo+IAo+IFRoYW5rcyBBbm5hIQo+
IAo+IFllcywgSSB0aGluayB0aGF0IGlzIGEgY29uc2VxdWVuY2Ugb2YgdGhlIGNoYW5nZXMgdGhh
dCB3ZXJlIG1hZGUgaW4KPiBjb21taXQgY2M3ZjJkYWU2M2JjICgiTkZTOiBEb24ndCBzdG9yZSBO
RlNfSU5PX1JFVkFMX0ZPUkNFRCIpLiBJIGNhbgo+IGp1c3QgcmVtb3ZlIHRoYXQgImlmICghKGNh
Y2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19SRVZBTF9GT1JDRUQpKSIKPiBhbHRvZ2V0aGVyIHdpdGgg
dGhhdCBjaGFuZ2UgYXBwbGllZC4KClNpZ2guLi4gTmV2ZXIgbWluZC4gSSBkaXNjb3ZlcmVkIGEg
ZGlzY3JlcGFuY3kgYmV0d2VlbiB3aGF0IEkgaGFkIGluCnRoZSB0b3BpYyBicmFuY2ggZm9yIHRo
ZXNlIGZlYXR1cmVzIHZzLiB3aGF0IEkgaGFkIGluIG91ciBtYXN0ZXIKYnJhbmNoLiBBdCBzb21l
IHBvaW50IGluIHRoZSBsYXN0IGZldyB5ZWFycywgSSBtdXN0IGhhdmUgdXBkYXRlZCB0aGUKbGF0
dGVyIHdpdGhvdXQgcmVtZW1iZXJpbmcgdG8gdXBkYXRlIHRoZSBmb3JtZXIuCgo+IAo+IFZlcnNp
b24gMiB3aWxsIGJlIGZvcnRoY29taW5nLgo+IAoKLi4uYW5kIGl0IHdpbGwgbm90IGFmZmVjdCB0
aGUgYmVoYXZpb3VyIG9mIHRoZSByZWd1bGFyIGRlbGVnYXRpb25zLgoKCj4gPiAKPiA+IEkgaG9w
ZSB0aGlzIGhlbHBzIQo+ID4gQW5uYQoKWWVzLiBJJ3ZlIGNoZWNrZWQgYm90aCB0aGUgcGF0Y2hz
ZXRzIHRoYXQgSSBzZW50IG91dCB0aGUgb3RoZXIgZGF5LCBhbmQKSSBiZWxpZXZlIHRoaXMgaXMg
dGhlIG9ubHkgcGF0Y2ggd2hpY2ggZGV2aWF0ZXMgZnJvbSBvdXIgbWFzdGVyIGJyYW5jaC4KCkFn
YWluIHRoYW5rcyEKCj4gPiAKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvaW5vZGUu
YyBiL2ZzL25mcy9pbm9kZS5jCj4gPiA+IGluZGV4IDkxYzBhZWFmNmMxZS4uZTAzYzUxMmM4NTM1
IDEwMDY0NAo+ID4gPiAtLS0gYS9mcy9uZnMvaW5vZGUuYwo+ID4gPiArKysgYi9mcy9uZnMvaW5v
ZGUuYwo+ID4gPiBAQCAtNjA1LDYgKzYwNSw0NiBAQCBuZnNfZmhnZXQoc3RydWN0IHN1cGVyX2Js
b2NrICpzYiwgc3RydWN0Cj4gPiA+IG5mc19maCAqZmgsIHN0cnVjdCBuZnNfZmF0dHIgKmZhdHRy
KQo+ID4gPiDCoH0KPiA+ID4gwqBFWFBPUlRfU1lNQk9MX0dQTChuZnNfZmhnZXQpOwo+ID4gPiAK
PiA+ID4gK3N0YXRpYyB2b2lkCj4gPiA+ICtuZnNfZmF0dHJfZml4dXBfZGVsZWdhdGVkKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBuZnNfZmF0dHIKPiA+ID4gKmZhdHRyKQo+ID4gPiArewo+
ID4gPiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgY2FjaGVfdmFsaWRpdHkgPSBORlNfSShp
bm9kZSktCj4gPiA+ID4gY2FjaGVfdmFsaWRpdHk7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDC
oCBpZiAoIW5mc19oYXZlX3JlYWRfb3Jfd3JpdGVfZGVsZWdhdGlvbihpbm9kZSkpCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+ID4gKwo+ID4gPiArwqDCoMKg
wqDCoMKgIGlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19SRVZBTF9GT1JDRUQpKQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYWNoZV92YWxpZGl0eSAmPSB+KE5GU19J
Tk9fSU5WQUxJRF9BVElNRQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgTkZTX0lOT19JTlZBTElEX0NIQU5HRQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgTkZTX0lOT19JTlZBTElEX0NUSU1FCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBORlNfSU5PX0lOVkFM
SURfTVRJTUUKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IE5GU19JTk9fSU5WQUxJRF9TSVpFKTsKPiA+ID4gKwo+ID4g
PiArwqDCoMKgwqDCoMKgIGlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19JTlZBTElEX1NJ
WkUpKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYXR0ci0+dmFsaWQgJj0g
fihORlNfQVRUUl9GQVRUUl9QUkVTSVpFCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBORlNfQVRUUl9GQVRUUl9TSVpF
KTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgIGlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZT
X0lOT19JTlZBTElEX0NIQU5HRSkpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGZhdHRyLT52YWxpZCAmPSB+KE5GU19BVFRSX0ZBVFRSX1BSRUNIQU5HRQo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
TkZTX0FUVFJfRkFUVFJfQ0hBTkdFKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChu
ZnNfaGF2ZV9kZWxlZ2F0ZWRfbXRpbWUoaW5vZGUpKSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19JTlZBTElEX0NUSU1F
KSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZh
dHRyLT52YWxpZCAmPSB+KE5GU19BVFRSX0ZBVFRSX1BSRUNUSU1FCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgTkZTX0FUVFJfRkFUVFJfQ1RJTUUpOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZTX0lOT19JTlZB
TElEX01USU1FKSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGZhdHRyLT52YWxpZCAmPSB+KE5GU19BVFRSX0ZBVFRSX1BSRU1USU1FCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgTkZTX0FUVFJfRkFUVFJfTVRJTUUpOwo+ID4gPiArCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKGNhY2hlX3ZhbGlkaXR5ICYgTkZT
X0lOT19JTlZBTElEX0FUSU1FKSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZhdHRyLT52YWxpZCAmPSB+TkZTX0FUVFJfRkFUVFJfQVRJTUU7Cj4g
PiA+ICvCoMKgwqDCoMKgwqAgfSBlbHNlIGlmIChuZnNfaGF2ZV9kZWxlZ2F0ZWRfYXRpbWUoaW5v
ZGUpKSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKGNhY2hlX3Zh
bGlkaXR5ICYgTkZTX0lOT19JTlZBTElEX0FUSU1FKSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdHRyLT52YWxpZCAmPSB+TkZTX0FUVFJfRkFU
VFJfQVRJTUU7Cj4gPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4gPiArfQo+ID4gPiArCj4gPiA+IMKg
dm9pZCBuZnNfdXBkYXRlX2RlbGVnYXRlZF9hdGltZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQo+ID4g
PiDCoHsKPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZpbm9kZS0+aV9sb2NrKTsKPiA+
ID4gQEAgLTIxNjMsNiArMjIwMyw5IEBAIHN0YXRpYyBpbnQgbmZzX3VwZGF0ZV9pbm9kZShzdHJ1
Y3QgaW5vZGUKPiA+ID4gKmlub2RlLCBzdHJ1Y3QgbmZzX2ZhdHRyICpmYXR0cikKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoCAqLwo+ID4gPiDCoMKgwqDCoMKgwqDCoCBuZnNpLT5yZWFkX2NhY2hlX2pp
ZmZpZXMgPSBmYXR0ci0+dGltZV9zdGFydDsKPiA+ID4gCj4gPiA+ICvCoMKgwqDCoMKgwqAgLyog
Rml4IHVwIGFueSBkZWxlZ2F0ZWQgYXR0cmlidXRlcyBpbiB0aGUgc3RydWN0Cj4gPiA+IG5mc19m
YXR0cgo+ID4gPiAqLwo+ID4gPiArwqDCoMKgwqDCoMKgIG5mc19mYXR0cl9maXh1cF9kZWxlZ2F0
ZWQoaW5vZGUsIGZhdHRyKTsKPiA+ID4gKwo+ID4gPiDCoMKgwqDCoMKgwqDCoCBzYXZlX2NhY2hl
X3ZhbGlkaXR5ID0gbmZzaS0+Y2FjaGVfdmFsaWRpdHk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIG5m
c2ktPmNhY2hlX3ZhbGlkaXR5ICY9IH4oTkZTX0lOT19JTlZBTElEX0FUVFIKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IE5GU19JTk9fSU5WQUxJ
RF9BVElNRQo+ID4gPiAtLQo+ID4gPiAyLjQ1LjIKPiA+ID4gCj4gPiA+IAo+IAoKLS0gClRyb25k
IE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=

