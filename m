Return-Path: <linux-nfs+bounces-1550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97818407F0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392E81F21260
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85DA65BA2;
	Mon, 29 Jan 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lxw/jkBn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0DXKfJsm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876865BA3
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537705; cv=fail; b=qhnvMy5Gx7LLgGvbcFSgX1/5dkXqXqhPu6kBUokdhM2RINY2hbXXMID6nJtTALB7Ul+E9+QvrvdULiLOUgyFq/MPjTcqlti4+7inBRLsZXguHsljlZLlEPrx5r84eWEo34ey6lcARb0UVu4F5exaqiYuume1js088nh97Qq1tTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537705; c=relaxed/simple;
	bh=51tsK8MxV2nvGMnhY4JwGSs9H+aaEf7QLvcco48Jraw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnJuyHBajsEqaR1FGPiGvDVzO/cz9IRBhrhGEI3LPy/Mg4PmY9ln3rzopqbebpTlWjV8Di3CvQoGcTFiZ7n21K9bA9uwoJLqGd14ip1wB8VhSadLTwxPoQdMBScHgbQpHGeUeH71G2WQtGXUr51TVUGJ/RQ/LitYTdu4cU5Cbbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lxw/jkBn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0DXKfJsm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9hxNu010634;
	Mon, 29 Jan 2024 14:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=51tsK8MxV2nvGMnhY4JwGSs9H+aaEf7QLvcco48Jraw=;
 b=lxw/jkBnJS1zIjyU0jl9e+GFHgorer454AIM3sT5cqw3rQYsWUYd1XKqWfmw7SH0EsKN
 rVnG0LZTEMgEkr28dOYD7XR5aHyEB5Z/7hHsKoJtmKGtMdvDXU3+SEbJBMCKoNrR3gLY
 PR1jRPiUQsphj7cm0TqlLI9ezxsy3sAxwCVXXKKE8iVQmfIv+Kkq5SIMEs7aYd2z9nH1
 OZS/UujIWi2UMqHhPDMHxndDVxN+hjrjv/wBg2Mw32E/BO1NeMtBs7fpJXO+XP3THqsj
 xIAcNAtXFJZ6A17VfQBYoDoG5hhI0z4zB7GU5hNu29aGT5vwehC6k2y6rQn/V5/Ufliz Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3v09d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 14:15:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TDvAx3014767;
	Mon, 29 Jan 2024 14:14:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9bxjbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 14:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCL4XXqxdui0S4fwt7zmF+whksteGMJ+bvBpaH/iyPpTfWAexaYCcS8Gsmw+t5hbZRqDReLe5w8HlamKiRaw0JbAzvCLgzuhBN0m7BlCHmKfCJF2Ri9SYjWq9iSJjO3gKMQzyil3iOut7+47FHQCBXQYD9I4tECg3N5/DkTv0UFRT0hujiGgqgsoanAR9xPh1iFAWR4nRHF8Yu51wX6SU9nxAwBUAnJjHYy8fUDa0zSk4ncPXTT02w6v+8MTTVKr/16RVX+V1OTsx4Nky3kRWXbauy3Mia8wnDMZF2K0A5lh8QuD5l9ZeDFystfq8a/MwCEmLatmOicKJiTfehCqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51tsK8MxV2nvGMnhY4JwGSs9H+aaEf7QLvcco48Jraw=;
 b=hCtMLCjsnFK3/jhRYed+OqObOqkwYTtw5EAzn2znX1OYeBZ7exAZ11slFc4zv9dIy4QrPMLBPqcztiRqjHUkaL6qrM7m0IDp2eLqhH+Lh4jDy6Wo36GVOBjiF1kBebmGpp94fLdoPNgc8EcQa+YIA08fmsEsBQwYbM1l9RPp5tmzRBM5eAdq8TH5AFBtmmImXyDG1F9ZQNrl+ks48i9l+Jf6fQxTcY/Dl+wzTU6Swj8+DNEKSV1LwyIwCa1n1lMWN7+CiuIos9Yp8Su5vy9B9VpioBp78r5LKt/dvg+pzvm58YXTQvIXogAZG3SaVY3Cvh52xnOtcTofxGDcD0i+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51tsK8MxV2nvGMnhY4JwGSs9H+aaEf7QLvcco48Jraw=;
 b=0DXKfJsm+Sak0InuBPU5+ReLl3nT3GOfYMVjdEPfaTRdD4+HZ4bpW5LpsBbnDw0NpT12xvYEpYkfv7gg2WsUiLEMXbfmevV2k1o0YqIJNQr3JkKaposFaRbPftRtFivTqJZ+diVDBm8bACRcSTmdB6xgRM0wk0UehtBaM3N+PM8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Mon, 29 Jan
 2024 14:14:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:14:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Wege
	<martin.l.wege@gmail.com>,
        Cedric Blancher <cedric.blancher@gmail.com>
Subject: Re: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in
 /etc/exports?
Thread-Topic: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in
 /etc/exports?
Thread-Index: 
 AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gCAAALcAIAAGasAgABndgCAAK6dAIADivKAgHm3SACAACn/AA==
Date: Mon, 29 Jan 2024 14:14:57 +0000
Message-ID: <610FDE39-3094-40EB-B671-F2CA876CA145@oracle.com>
References: 
 <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
 <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com>
 <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
 <CAKAoaQ=FDdkTW2Vh=_Y08DEWZYaJa6tDSYKnFiZCfQ6+PW_5iQ@mail.gmail.com>
In-Reply-To: 
 <CAKAoaQ=FDdkTW2Vh=_Y08DEWZYaJa6tDSYKnFiZCfQ6+PW_5iQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4563:EE_
x-ms-office365-filtering-correlation-id: 1d7bfe57-12f9-480b-3214-08dc20d4ac26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5S1VvBRsns8boeYR86J8mfn0lrc/KftkiN+Mu7FG/td68rdU3EgYF/nYKziY3PEvE9xYIkapOXATHsl5/OOage8CC5eBBMDDTB+035QiM1xqbbaCzx+xDsh8Ts2jzP6F9urgLMSMcOSzXdaKZot2xhtm3sg0DP4DtVtYyJgUD7HcsJy3DXituvLmVzFUIBujbk8vh6lRC93kQf49Ysj3xM4Oq+YyJCKS76q/YAfE9OyyaV4WfRAv/Pekm9d1D2S7WyINw5GkuvCnZHpmAeeW5XuXH29xIiznhdX62ZbH2moRZFwDfdMU6aXUuiSG+ee2OWPiU/1FnlJsLag+8YUInUn7luNi5Wx8+PUw4w5yJeGnzXsJO4/q8yuCFS3hym+BDnuXrK2A9JpcOAAqqs+QZ3B0XAKCebV3q+1wX9ccI0AjNMp14euJ7xe6yvV5gvXpt8lleDez6uQGfZ8VeYK/A91d90IYYurobHRZuLLjwwLbRkWXHXp5E2cU6cnLVzmbt/x3uCdrWXfTmnJ/+QKx2ZLbVyKS545wRyiTt01+AccwWLYJwhbBNWKBggZn3EKwLr7X7o8R+mo/Ukfz/4rviGwrlQ++UFFyORf95SKJ67nBEgD11ogmAG4J39Wax285Oir5hYxOLhwxOml1LW9zbODJ5IBSoZzPfaY4Y6ZOpti8glKIRtDBnuVFI7EVWath60PXfC9OHw5W+eO6ZN04Wg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(38100700002)(122000001)(66446008)(66556008)(76116006)(6506007)(86362001)(54906003)(53546011)(316002)(6916009)(66946007)(66476007)(6486002)(8676002)(8936002)(64756008)(2616005)(5660300002)(6512007)(33656002)(26005)(478600001)(2906002)(71200400001)(4326008)(83380400001)(36756003)(38070700009)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MVJhVVlZOXpGaDA5eElZcEw0TE1jOGlWTVZUTUNZYUs3eU1HQlVGZjh6ZXFk?=
 =?utf-8?B?ckRKbHpZTTVCQzhoRE1Na2hsOUhBSFJUeGN0Y0Nlc1FjT1RmVFBPbUNNRm1C?=
 =?utf-8?B?aWRpbXFhZ1dYTndySjhhTmh3dktIM1U3UVplU1FTMG1PUU5KWExRMXJLVVJH?=
 =?utf-8?B?ZHRyakFSS0xERllpTnV0NHp6VWh0U0cvTXpHcmtUV1d0Q1JXQXNCbjVNS293?=
 =?utf-8?B?OTMwK0dmbWZoSXprcy95WXVSaDgxS1QwUERjdHhjVEUvQVlkSmlMQXpycGMr?=
 =?utf-8?B?SWI0UGQ5U2t0d24vcmxNZ1l4a0ZsR2dBeTZLZ2xud3pUS2NGbU9md3JNU0tF?=
 =?utf-8?B?T2MvWFFzclZQaG9INkV0NmIrcXFuTUowT3pSUzZuL1VQdDdBM2xKTkhNL1JU?=
 =?utf-8?B?Nmt3ZWErQ1JFTlU5Vk93bmxWTFhoQUd3Zi83YURCMk0yV09TS0VoSmhIekl5?=
 =?utf-8?B?WlRlQTlqSUVWWi95SS9iYTJVMVVyaDdmYlZYMDFEeFRCeEw3aFV5Z0JkYUdD?=
 =?utf-8?B?QjlNampCNDRGdm5iZzV1ekRhaUc2NWlKcVdMb0I0M0d1YTJBU3VRbFB3aXVt?=
 =?utf-8?B?b3Z4T2FZcUw5OEhxbzZBMzlQNXRsdmxOQkcxWlEvSUllaW5uMFN4OEZnbVJ5?=
 =?utf-8?B?aStaTHdjelhaVTBnUGVFODFJY2JtcDE2V04yS2FyU1NUUU1JMENsaHlxNzgz?=
 =?utf-8?B?cVlML3JsR3BvUXczb29uSFd0UVpaeTJpS1RRZS9qSHJkM0hNT0JOckxibkhN?=
 =?utf-8?B?cENiTUN0WUxLdDhSbmlNTmJ4REE0QkFpWjE5WVNiWWlSMEpiTUg3TVZNZUtK?=
 =?utf-8?B?cm9ZenFPVmV2TnU5cUFKcG1hMTJpK1BqRGpJR3E0S215cWU1aU5ZM2hmOWt0?=
 =?utf-8?B?clRGUGN5TGhRd3lJc1RxaWk2cjgxQ3dMeGR3MHFFcDhQUWUyYnN4b3ZjZ0ty?=
 =?utf-8?B?eGQrKy96em9xS0l1Wm9CWlliYnVWVWJxREdJSnVBTnlIaE1PcHZyVXR3Ui94?=
 =?utf-8?B?a1RDRk0ybURndFRRVlNLZ3BuSmQ5ajVBc01XWW1WUkFCay9oSUIyTzhZSnBa?=
 =?utf-8?B?TXJHRGNNTTdmdm1KU2h4RlBjdlNSS1Mrb0ZyMlBncXRjeklhWkplc2MwL0dQ?=
 =?utf-8?B?a2lrTXMyZkpVUHpzaC9JOVAvYmc5d3QzS1lpYUtDVVlmcmVWeVBOaDh3V1hY?=
 =?utf-8?B?cXNzT2lZbjdIUHlQNS9YSzlZNUp6ek9SOXlkazVsNktsSHI1U2tHR3VlZWZu?=
 =?utf-8?B?UUtZcERmWnc0V3ZiOWtsdFZCWUF0aHpJK3ZkMWdrcU9BUGtJdFlTUjN4bXdG?=
 =?utf-8?B?S1V1SENDUk9MdmpKdGppRkFwV01FMTMvQS91NXREUU9ydUZtem9SQnMyVTlR?=
 =?utf-8?B?a3IrZHdoc0JEK3lwUGFKWHZQOE1KaW9DTTF0MTc5dHFMRmJmd3g0ekpPT0tE?=
 =?utf-8?B?T1JXV21hd0lZU0NMS0RycE1pdU5WejRId1RMdXV5ZWRGRHJCdUZyNWJtTk8z?=
 =?utf-8?B?TmpsWUJHbjdKV0U4Ym9SZ2lqMDd6bzUwVkFTWXpleWl6TTNrTDRwNm9EMTJE?=
 =?utf-8?B?alhZTlI4YW9TOHp0eGRnaGFORno0anFCMjduSXhtSkFnU0hNRkg4bnhYQTVX?=
 =?utf-8?B?elVNaEVtdFdCUzE3aFpiUDdtVUpQUDJWWnh1bTNPdU55Y3FYUzBFaGxnQU5s?=
 =?utf-8?B?SC80SVFCNEVZc2U5Vmh3ZUZkWFh2WUtkTGpCMk5neGdRaDhEc25tZHEzc1FD?=
 =?utf-8?B?RmRlcXZ3WStVaDIxQmQ1eXk3ZENVdWhhNHpwRXAzd1V2aklDWVByM1V1clky?=
 =?utf-8?B?RVJCdDZ4d2ErTHpwZGVuS3ZRdm5NYVlKRlZ4Y3dFb1E1cjJNMjg3K3BPSzU3?=
 =?utf-8?B?aEdEODZWNlpJQ2VrWkJLYkExRHBkY3dGNEovL3Y1R01DclBNdmJWb3A4UVc3?=
 =?utf-8?B?UHhpTFZuUzhwb29SdXhPeG93bjdlTWJHSVd4Sm9QU1N6MGFFSFpHMFhIZHph?=
 =?utf-8?B?UjhqanFDUlhmSTZtWi8xbGNBQ00rYTlaTWg0T2hPdk5Zeng4RGQwaXloMk5L?=
 =?utf-8?B?dlBCTmQ4dm9FOG5UVGdseXZhWnd4VDRQSkROYXVFb1ZsSGk0ZTNWS2g3NTB4?=
 =?utf-8?B?RkpCeUtjS2tjTDZGTEhSRjlQZmtnMllxMXhsOEZXc1lUMUlNdzdtcVJDdG42?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <766867E21930B04C8A8FB1C497800989@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DAx6UVerNIlAd86klQ5PcEWGqQpc1+wRLSwNqFhLQYoAidnxRM9DK2bgw9r/Ik6JhGo0bcr3qU2dJMu9uun/NsxkWHPiLgiDcoZpoj9H5WzIUXFdV4aUYle8WT2y2OWUxoBrg8XeZoyon8ivl6oN05AOoUVYxJFjqSA6ytcY5IMsi3oJLmAA/GdQ9c5/dglSXCbjcssRK1ucs2zbxKnZeHBRVL24I7CdFF4+urwki/Vq8r0/4rPY5Wex4YehPA8+epc27wgomIN/DVmkVA3Vqcj1QXr3iEWcHNy43PqxaDcSW3+wXG7eQx6JNzZzY8d+IRTmVDfTcrR+5ihDj+7nxeL2HLUgZX9Mowvu6JKCp8Uqu95/YQnU1SZSizc95oUKtIyBxsTiBikwBzI776DuuKiiH3aom8o6cMqgEVNJ88QaJsnUxd3Cfd61Hk58aZT9YWJnsDK5DGOb7QdqT02rV3CnaOE5uDrP187KhL1m4W2z8XmSPfEYRTQi240GMNiTSqT13vcdZWGll2iapjCvJEiH7Q/Dh4tf2A56QopTpVCR9CCfQBrHnNgWxXolY4Jp5t/eSMOSiLGYxhLuGg9kzGwbHNtqVW49JoSpOMpLPKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7bfe57-12f9-480b-3214-08dc20d4ac26
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 14:14:57.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGZdfaswk/Erg1XlhzVSRxEVqgX1ZWzipPCLvrUST51PcX9tS3SHCg/1Wog57cqxb1Zd4FwNN5uUUqzodlNIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290104
X-Proofpoint-GUID: XMR_TpliuaugdeUmmoIQ7_Z6_DvWB5qH
X-Proofpoint-ORIG-GUID: XMR_TpliuaugdeUmmoIQ7_Z6_DvWB5qH

DQoNCj4gT24gSmFuIDI5LCAyMDI0LCBhdCA2OjQ04oCvQU0sIFJvbGFuZCBNYWlueiA8cm9sYW5k
Lm1haW56QG5ydWJzaWcub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTm92IDEzLCAyMDIzIGF0
IDI6MDHigK9BTSBDZWRyaWMgQmxhbmNoZXINCj4gPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+
IHdyb3RlOg0KPj4gT24gRnJpLCAxMCBOb3YgMjAyMyBhdCAyMDoxNywgQ2h1Y2sgTGV2ZXIgSUlJ
IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4gT24gTm92IDEwLCAyMDIzLCBh
dCAzOjMwIEFNLCBNYXJ0aW4gV2VnZSA8bWFydGluLmwud2VnZUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4+PiBPbiBGcmksIE5vdiAxMCwgMjAyMyBhdCAzOjIw4oCvQU0gQ2h1Y2sgTGV2ZXIgSUlJIDxj
aHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4+PiBPbiBOb3YgOSwgMjAyMywgYXQg
Nzo0NyBQTSwgQ2VkcmljIEJsYW5jaGVyIDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90
ZToNCj4gW3NuaXBdDQo+PiBZZWFoLCBpbnN0ZWFkIG9mIHdhaXRpbmcgZm9yIE5ldExpbmsgeW91
IGNvdWxkIGltcGxlbWVudCBSb2xhbmQncw0KPj4gc3VnZ2VzdGlvbiwgYW5kIGNoYW5nZSAiaG9z
dG5hbWUiIHRvICJob3N0cG9ydCIgaW4geW91ciB0ZXN0LWJhc2VkDQo+PiBtb3VudCBwcm90b2Nv
bCwgYW5kIHRlY2huaWNhbGx5IGV2ZXJ5d2hlcmUgZWxzZSwgbGlrZSAvcHJvYy9tb3VudHMgYW5k
DQo+PiB0aGUgL3NiaW4vbW91bnQgb3V0cHV0Lg0KPj4gU28gaW5zdGVhZCBvZjoNCj4+IG1vdW50
IC10IG5mcyAtbyBwb3J0PTQ0NDQgMTAuMTAuMC4xMDovYmFja3VwcyAvdmFyL2JhY2t1cHMNCj4+
IHlvdSBjb3VsZCB1c2UNCj4+IG1vdW50IC10IG5mcyAxMC4xMC4wLjEwQDQ0NDQ6L2JhY2t1cHMg
L3Zhci9iYWNrdXBzDQo+PiANCj4+IFRoZSBzYW1lIGFwcGxpZXMgdG8gcmVmZXI9IC0ganVzdCBj
aGFuZ2UgZnJvbSAiaG9zdG5hbWUiIHRvDQo+PiAiaG9zdHBvcnQiLCBhbmQgdGhlIHRleHQtYmFz
ZWQgbW91bnRkIGRvd25jYWxsIGNhbiBzdGF5IHRoZSBzYW1lIChlLmcuDQo+PiBzbyAiZm9vYmFy
aG9zdCIgY2hhbmdlcyB0byAiZm9vYmFyaG9zdEA0NDQiIGluIHRoZSBtb3VudGQgZG93bmxvYWQu
KQ0KPiBbc25pcF0NCj4gDQo+IFdoYXQgd291bGQgYmUgdGhlIGNvcnJlY3Qgc3ludGF4IHRvIHNw
ZWNpZnkgYSBjdXN0b20gKG5vbi0yMDQ5KSBUQ1ANCj4gcG9ydCBmb3IgcmVmZXI9IGluIC9ldGMv
ZXhwb3J0cyA/DQo+IA0KPiBXb3VsZCB0aGlzIHdvcms6DQo+IC0tLS0gc25pcCAtLS0tDQo+IGAv
cmVmICoobm9fcm9vdF9zcXVhc2gscmVmZXI9L2V4cG9ydC9ob21lQDEzNC40OS4yMi4xMTE6MzIw
NDkpDQo+IC0tLS0gc25pcCAtLS0tDQoNCkhlbGxvIFJvbGFuZCAtDQoNCkFsdGhvdWdoIGdlbmVy
aWMgTkZTdjQgcmVmZXJyYWwgc3VwcG9ydCBoYXMgYmVlbiBpbiBORlNEIGZvcg0KbWFueSB5ZWFy
cywgTkZTRCBjdXJyZW50bHkgZG9lcyBub3QgaW1wbGVtZW50IGFsdGVybmF0ZSBwb3J0cw0KaW4g
cmVmZXJyYWxzLiBJdCBpcyBvbiBvdXIgZW5oYW5jZW1lbnQgcmVxdWVzdCBsaXN0Lg0KDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==

