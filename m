Return-Path: <linux-nfs+bounces-1460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE1C83DB28
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 14:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4F0B20EFA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDBD1B940;
	Fri, 26 Jan 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g3TTv94t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wm5xzJfI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986801B81D
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276912; cv=fail; b=AExTrtCbpqDQBZsuIdsh5pq6k5Ag9Pne0d8GcWFBHrtXwPhGVTJM3FI72g7l+30mdmv4Yqay3P2tzPLRDaJVlhLTveXnD7hLduR/AwgjlsSvGx/GhbKYK1a3OtY7H5+2N7PzeqPNNJQrkRBSZBULGmXf5oZV6Hqva8lXEvRZNHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276912; c=relaxed/simple;
	bh=EnnmUGd4Rpg0T2hx5fxdPrX+tTipH3lYJcevO5QLrF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fvb7tf9VU0YjCzikLFSatazarQ3TNtZF7zp0RWQVXhyqYHtRKiALcog/KU+qaiLigjqwHZlIzYkpTJElc4bzur0Ypb9c6WUuNdXNZtOj5UCG3Jqcl1Cc+QzmoPCLbHhJG3HxvI0nhyYmvbsOhQjBgSkFCDi95fsOZkowxlTjmVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g3TTv94t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wm5xzJfI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QD5J5e018542;
	Fri, 26 Jan 2024 13:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EnnmUGd4Rpg0T2hx5fxdPrX+tTipH3lYJcevO5QLrF4=;
 b=g3TTv94tJALYI4BqEByD9ZTMU6T9efbkLPe7saPlhKqj8rEyQCf5rhqUCXxjhgw/gVBb
 bX79BQ3OPExTpyxsrV01BQ9pyf7vnVeICC6vsF/U+hhQr4pgOJY8aGVFdsPdZ10KCzHs
 ANCs6CY23p/NagCKKklEk+/dX92oe9SLA0A9Hwou0U2QrkWbkBCquUJdcpY+wtxskJei
 1HCtr/VHMw9WCqwmtzXQHkMPgJ9nIwBAV8X0Yn9FytwPEf3LPsNf4PuzUQ9OoRxVJ+Uz
 aLoOnxmOEl/E+C8axJHmKlJzwErlh4EXVEhr89MPl9DQD4XQgy9baeSN7rkCR98yXesj xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy9gu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:48:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QCkwKM029265;
	Fri, 26 Jan 2024 13:48:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33y8q6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 13:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYkZKt9Ft8wJdliC5JHkCBCOweHbczQV2PSpJM41AWdefYqNnMqAKqH6GA2bwB0YLvwfTe6kiXMVE4OHoCbI0lxVrQwljYND/ZWN2Sbe/5mmdY/ICGZzd+7VKKR2aqO1aNG23p5KCzX9fLbOYf0esl4uU33O62AiJ8KO8PkKKB8VsE6aaMiYBKvsY61X8bWiE9J4bE65GLdCV9nBusi+7V9QV+M0hoeu992UdJt6MyMGSj6ftDq907Rx2PQuo3wWnCXtqRHyD0Ljsj1zHdFVBToe4tDPz35REXqE+mO8RGlc5pogLTvMOQPohFKtgVlOTUY41hU487VWofbnW9jLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnnmUGd4Rpg0T2hx5fxdPrX+tTipH3lYJcevO5QLrF4=;
 b=gcGI+wLSlr3aOjgWxo/Mz2SNh5nMdY71NFpuzLdTOjKR2ULB4+nlFaUg3q9M9D+eCVCoyIHmTpTyiR8h94X9hTdSIfdT1zYZJFzy8iXdnopJHAgiqdOErhQsiQFnzIiV/zSCxNFQ/U2JZrC/Aoztfq9B2Vv+nC2NcMK2I+H1AQKPFzN3smUribZDK2WhfsSl4smCz5w9+/J8Np+pGwloCX/KGYE4FMXOUvP5ovrgG1xCgupBWLnt0qM8f2jHQ4Y+5o6Fi9gK1zZw88t+gXHJnSgttbHJB6HQ0JznnCCQuWBMJmLhICHqpVEwfZmqRZJ3Yqu9CTSHeyevjoO2Y1Q4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnnmUGd4Rpg0T2hx5fxdPrX+tTipH3lYJcevO5QLrF4=;
 b=Wm5xzJfIwUDfNrqCwXs+B/en89hitAXacHTMrWSDxOFSPkb2bLee2NTl8R/I3mdiJQw4A/VGo1HHsXZpMtYGb5809vcgKge5emfir7rHihIKnbs5OABRC9ViCUU43wqhvdnOZkgKlIe9TjBsadNviXn4JB4OE75jCqdRsXJ+AY8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 13:48:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 13:48:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com"
	<kernel-team@fb.com>
Subject: Re: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Thread-Topic: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
Thread-Index: AQHaT8hEq8/wrLWuZk2tTHK6HjPCr7Dqr/QAgABjIQCAAPz2gIAADPMA
Date: Fri, 26 Jan 2024 13:48:13 +0000
Message-ID: <1E87E98E-EA7B-4BBD-A9FA-EF4B217141E0@oracle.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
 <ZbLMJxLWIvomQIzO@tissot.1015granger.net>
 <20240125215618.GB1602047@perftesting>
 <889ecfaa124883cd99e40d457562af45b5e97e7d.camel@kernel.org>
In-Reply-To: <889ecfaa124883cd99e40d457562af45b5e97e7d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6547:EE_
x-ms-office365-filtering-correlation-id: 5fcf4766-6dcd-4c7e-c590-08dc1e7570c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9SzxROIdCJUTSvb3Zxe0AF5E5+aHqEH98NvDfiqJBF0N0DFXEXolS3YlU+CmcCLRa4gKxJokqLBdAeMwV+2GOMfiptPJfAXlQ9D42xa/15L8Ncm3V2LZjlY4wdXviAcd1aALBvcs9ruOzif1MAy78V38SFNLb8k8XcJwHFNnzMT/WTKIqF1ZLy4j4GRqNQP26b25vJmyazNJQtITMiIyYhgY7VfM3A/VykazrAI3tQSK0SmjX51eAxTylqVVIm795TWJMppr+6hNVKGQlPa2aVPlPWZmvamnvim7GJ26QwHf8exkF7vbyMesxJCHvUoeNPT97yEDTMBBBTPZPiRijeWpaphp6CI9L62gWBg0PUzXtbSUhcjtomAjFKSc4VGi0HYpmfWpoXIQxRO+Xubg96WeuqqCi9f2D0oPjsSDK1YpEU184w7UT/2T+HMjjgqwrvNVO8TQHJD1OUNKPS9cG294gaVxRoRnpOa0tKIK98iLoaLv45eiKxn3saSyMkeOtAFLqHwWtTvN5lFdSMQYTrHTlKYUcL07YTxFC8cIEyhdVUxWuomaoEb+A5ftGP1Uo4jYO3RXRjAafsZz4enrN2Wm0wNvTbqUySuftRrfMl7s/J7Rzrpv6rziyQjPJvrX7mid3cvHCk2FEIE1+4+05w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(83380400001)(86362001)(26005)(38070700009)(33656002)(36756003)(91956017)(122000001)(6506007)(38100700002)(66556008)(6486002)(2616005)(6512007)(76116006)(316002)(66476007)(53546011)(110136005)(71200400001)(54906003)(478600001)(66446008)(66946007)(64756008)(4326008)(8936002)(2906002)(5660300002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFVhZkp3UjlISnZLT3RhK2NBVHpIbFlLMzdaSWJhWTF3b2tpbWtoVDEyc3lH?=
 =?utf-8?B?YkMxcy9UVmhGR1RINXBGYTJMTFN4djQvYXVDVnZMN25xWGdYTUI3MDJXdmdJ?=
 =?utf-8?B?UXlJeWxFbW0xVzlOMjdaZlZRWDlhZGJaZ2x0Zm43Y0IrUzhxQWd2Ky9wZ0ZP?=
 =?utf-8?B?dU16MEdtWFE5WGNmSUpJM003L3dQVmhlUkYxM3J1blZVWTJJTWxwbGY3SFA5?=
 =?utf-8?B?VEN3WGRRQ2JTaWZmOEdoS0pJSTNwZGtTNDIwaTg5eFVVUnNZTTFUd0ZtQkk3?=
 =?utf-8?B?T0JDc3lRQ2l6N3ZIbmx2VmsxSyt5OEM1YnpUU3puL0drUmxFRGVvdjhMMWFs?=
 =?utf-8?B?eVl1NFE0Tm1wbWQwRmdkMWU1SkkyVDdJUS9Rbk1LNXR0VTFXQ01HODV5a3Bu?=
 =?utf-8?B?d0VFSEdCZFVDdER1TEk3OWFsdkxDK1dEZ0lURS9DaE1ibTl6Q2RTYzArM0w2?=
 =?utf-8?B?NnJORG5HTzVxaXZES2lYRlhBWVZwcExRMGswK1ozcnIrQnNjVlVzTnNXdHZq?=
 =?utf-8?B?NWZGQlZxS3ZSVVM0eEZIN29mTzljQm1FVUNJK3Vsbnh1bkFabW81dWpxWkd5?=
 =?utf-8?B?Mm9qQSs3NTVNZURNQVA4dzRlQUM4WHVpdy9jTlh2dDMvbG9jQjdjZ0NGdW9M?=
 =?utf-8?B?YitTT3l6SjZOeE1YV2ZnUCtrN3daV2ZibEtCWll5RlhlRmJHOXFDa0pHNUls?=
 =?utf-8?B?SUY2MllvQ1dOdVJBanV3VlNxWDU3QmxXZSs2YjZsYTRLYXMxRXdqb2dJOWNz?=
 =?utf-8?B?MEhKTGhTTHFtZG4wK2UxUnNzczUyOUdiVkdkbG5lUyt2SHI3TFNPWHQ5THcv?=
 =?utf-8?B?c0REdmk2eDhEaXJZUTROcDlqb2JMMlpWWWN4cGFCVyt4VUQyZ2JPUk1MVmE2?=
 =?utf-8?B?YXdXTVViR0hubVZtbVlyNVU0czZYUmFUZzk1c2c2R09hMGkyZW9jOWh2dUE1?=
 =?utf-8?B?ajBvWmVXdkVLL1hiR2VLalVXWDNCVjhCRmFBZ1grZlpkYUVxZURiRHZFMFhL?=
 =?utf-8?B?bjFGOTBlVkl2eEVsZm51eDdZR1NRNXVCQm9lc25GU2M5czNaYnk3R3dtT2Zy?=
 =?utf-8?B?dWpaUkVya0dWVnl0NHdmcTFtandNK1FmdXFrRjJNOWFybDF6SzJRRVJVYWdo?=
 =?utf-8?B?V2pOK2VScmhwSFRQTmQ1MHVmSm0rLzBabkhNSjNJSURMWlB4KzBnQlNpeGl0?=
 =?utf-8?B?M1JsYytWWld4V095SC9iY3NPNTUyOGFkN29zMkdKL05mZHlBVmxRenE4VXZp?=
 =?utf-8?B?Tm9SMFQxSEJSQ0NCVkZtSCsreFdpaWpQWXBTRFYvTE45QVRhd2FRRjNBSVZQ?=
 =?utf-8?B?UFdxUnl1R00ySFdPTmtqVG9zUlI0bVFOTDNRNzJlcFpMSDZLNnZMQ0R3K0tC?=
 =?utf-8?B?TUZNeTNadUVLMFI3UkNIMUYyYWx1UE13U1Y3YXJYaFF0bFpndkptYjV1TjJj?=
 =?utf-8?B?RFN6b3JIZFEyQXpqY1ZRUjBhMTNJOWdKRzI5Zkl6WFFKVy96S1RwVFBsajNp?=
 =?utf-8?B?Z2phUmlHc2hDNnJ4YXQydFJUWEJTRmd2OE1YWUcrN012Q1doemZsR05hZjhM?=
 =?utf-8?B?ZnEvRGhtOUZXVm9xQmFmZU4rblhWSk9mOGY5S0dFVEhCVWNsNXhzcTM1R1lD?=
 =?utf-8?B?ZHJKZ25QMFBLZzc5NWxsMk8wYjZkdEtYbFJQWUt1bmtOcDJmNFkwcG9lTWdK?=
 =?utf-8?B?M1VrcjRVQzBhOFN1c01oaDQvUFJFeWVjRjVYd0NZTEJPZ2xJTVNzd1QxM2Ri?=
 =?utf-8?B?TWYwUXNWN1JaSUE4aThKUHVXLytNalRJVmFXUVcrOVRwbGhSYzNDR2xrdWJm?=
 =?utf-8?B?cHVjMVliM1BFbXpNSVo2NWVTOVJ6RWNmL1pRVlZHZk9DbXJhOVRkYzlBN2Ry?=
 =?utf-8?B?UnRkVTMxd1UrdkdhWWJWQkc4WnJqYlZDMWFwWGtsNjVtaS82QWszbk1WQlpz?=
 =?utf-8?B?OWVSZ3RSbHMyT0xNMnphUHE0UCt5elV0TUNUMWYrU1c5bGl3OG9hVU44Z0t2?=
 =?utf-8?B?a2F1SWR2SnAwb09zYThIK0gyQ1VsRUJQeGFDMVJwSXVIYk5EWXFOdTUxUURN?=
 =?utf-8?B?TE1FQmNuakswdlFOdVEvc0QyTCs1VFBrTXB3eTN1ZWhEN1NUaGxWNHBabDE2?=
 =?utf-8?B?dkMvRDJPdWJxME5GeTRNRXp2MnZvanp5NnI1QjduZ1dpN1phempNaFF4dUdI?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07C8F300926756409E83898FD1DBE8DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RCMhZmYwU7JGoKyiYswfI367WmqvtK+6skacYKoCYg6cF62huXOwCY0FHc+G4/PtEMxyyCMfAWmb6I2XBHh5LHmQ9/fS9uQMcC3ozM4QkKiS/9NfUDg/xbA5uXDczjxmolt/bm/ti3SeKPwJpWj/I1ZfwyOz+uHgYxHJN9i33W8PoNN4sVduxnnLBxVnIYZb0/TW4GGNumQpLH3lBAeruFbgUH6aMmu0l/ZnjMwMpLa9/MyYE+oAp5JlSQLg0/OLqxQ3eUt++2HGqlKBJa/3+2wYJITposKHRyY7hB80wrsHYcEz+3i5IcpFyuT3TNOarDN7v+kaW2vgmlND2N5UCFt9ssnVs7hHDLgJ5USIsjui5eHsNUltSIMrnfQ1nqzSGmNDj0qJ+m4crC5cFk7gCd7RgoMNlWwVzToR2H+Z129LOqz1xD2equ09hIYa/hHBkgFx9V/w6YuQuyu6aYzwfQj3Xc0HC+WZV6NU5EpuGNGH6HNmGMUA9rJCjjcCi+esoY9N4wVMsiuvrziy9bFh8UAiriGp2Rc32A6APmc+Zh5lJIfPFpOn6JoUVl/6ijHhOCiahSantaWp0wASfiKNmnZINX8upqKG42iV9Hc3xK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcf4766-6dcd-4c7e-c590-08dc1e7570c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 13:48:13.1714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RTRQFQX4pJKC/HACI2TThv2U+RQfP5kC0E7XNMetXGxE9VMoiYdatEcOloMt7YctR3LQHEQEEnL8JgqlJQVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401260100
X-Proofpoint-ORIG-GUID: dPFzci-rlTfwhsCiZWw1HuugbMfWlRzg
X-Proofpoint-GUID: dPFzci-rlTfwhsCiZWw1HuugbMfWlRzg

DQoNCj4gT24gSmFuIDI2LCAyMDI0LCBhdCA4OjAx4oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTAxLTI1IGF0IDE2OjU2IC0w
NTAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4+IE9uIFRodSwgSmFuIDI1LCAyMDI0IGF0IDA0OjAx
OjI3UE0gLTA1MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4+IE9uIFRodSwgSmFuIDI1LCAyMDI0
IGF0IDAyOjUzOjIwUE0gLTA1MDAsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4+PiBUaGlzIGlzIHRo
ZSBsYXN0IGdsb2JhbCBzdGF0LCBtb3ZlIGl0IGludG8gbmZzZF9uZXQgYW5kIGFkanVzdCBhbGwg
dGhlDQo+Pj4+IHVzZXJzIHRvIHVzZSB0aGF0IHZhcmlhbnQgaW5zdGVhZCBvZiB0aGUgZ2xvYmFs
IG9uZS4NCj4+PiANCj4+PiBIbS4gSSB0aG91Z2h0IG5mc2QgdGhyZWFkcyB3ZXJlIGEgZ2xvYmFs
IHJlc291cmNlIC0tIHRoZXkgc2VydmljZQ0KPj4+IGFsbCBuZXR3b3JrIG5hbWVzcGFjZXMuIFNv
LCBzaG91bGRuJ3QgdGhlIHNhbWUgdGhyZWFkIGNvdW50IGJlDQo+Pj4gc3VyZmFjZWQgdG8gYWxs
IGNvbnRhaW5lcnM/IFdvbid0IHRoZXkgYWxsIHNlZSBhbGwgb2YgdGhlIG5mc2QNCj4+PiBwcm9j
ZXNzZXM/DQo+IA0KPiBFYWNoIGNvbnRhaW5lciBpcyBnb2luZyB0byBzdGFydCAvcHJvYy9mcy9u
ZnNkL3RocmVhZHMgbnVtYmVyIG9mIHRocmVhZHMNCj4gcmVnYXJkbGVzcy4gSSBoYWRuJ3QgYWN0
dWFsbHkgZ3Jva2tlZCB0aGF0IHRoZXkganVzdCBnZXQgdG9zc2VkIG9udG8gdGhlDQo+IHBpbGUg
b2YgdGhyZWFkcyB0aGF0IHNlcnZpY2UgcmVxdWVzdHMuDQo+IA0KPiBJcyBpcyBwb3NzaWJsZSBm
b3Igb25lIGNvbnRhaW5lciB0byBzdGFydCBhIHNtYWxsIG51bWJlciBvZiB0aHJlYWRzIGJ1dA0K
PiBoYXZlIGl0cyBjbGllbnQgbG9hZCBiZSBzdWNoIHRoYXQgaXQgc3BpbGxzIG92ZXIgYW5kIGVu
ZHMgdXAgc3RlYWxpbmcNCj4gdGhyZWFkcyBmcm9tIG90aGVyIGNvbnRhaW5lcnM/DQoNCkkgaGF2
ZW4ndCBzZWVuIGFueSBjb2RlIHRoYXQgbWFuYWdlcyByZXNvdXJjZXMgYmFzZWQgb24gbmFtZXNw
YWNlLA0KZXhjZXB0IGluIGZpbGVjYWNoZS5jIHRvIHJlc3RyaWN0IHdyaXRlYmFjayBwZXIgbmFt
ZXNwYWNlLg0KDQpNeSBpbXByZXNzaW9uIGlzIHRoYXQgYW55IG5mc2QgdGhyZWFkIGNhbiBzZXJ2
ZSBhbnkgbmFtZXNwYWNlLiBJJ20NCm5vdCBzdXJlIGl0IGlzIGN1cnJlbnRseSBtZWFuaW5nZnVs
IGZvciBhIHBhcnRpY3VsYXIgbmV0IG5hbWVzcGFjZSB0bw0KImNyZWF0ZSIgbW9yZSB0aHJlYWRz
Lg0KDQpJZiBzb21lb25lIHdvdWxkIGxpa2UgdGhhdCBsZXZlbCBvZiBjb250cm9sLCB3ZSBjb3Vs
ZCBpbXBsZW1lbnQgYQ0KY2dyb3VwIG1lY2hhbmlzbSBhbmQgaGF2ZSBvbmUgb3IgbW9yZSBzZXBh
cmF0ZSBzdmNfcG9vbHMgcGVyIG5ldA0KbmFtZXNwYWNlLCBtYXliZT8gPC9oYW5kIHdhdmU+DQoN
Cg0KPj4gSSBkb24ndCB0aGluayB3ZSB3YW50IHRoZSBuZXR3b3JrIG5hbWVzcGFjZXMgc2VlaW5n
IGhvdyBtYW55IHRocmVhZHMgZXhpc3QgaW4NCj4+IHRoZSBlbnRpcmUgc3lzdGVtIHJpZ2h0Pw0K
DQpJZiBzb21lb25lIGluIGEgbm9uLWluaXQgbmV0IG5hbWVzcGFjZSBkb2VzIGEgInBncmVwIC1j
IG5mc2QiIGRvbid0DQp0aGV5IHNlZSB0aGUgdG90YWwgbmZzZCB0aHJlYWQgY291bnQgZm9yIHRo
ZSBob3N0Pw0KDQoNCj4+IEFkZGl0aW9uYWxseSBpdCBhcHBlYXJzIHRoYXQgd2UgY2FuIGhhdmUg
bXVsdGlwbGUgdGhyZWFkcyBwZXIgbmV0d29yayBuYW1lc3BhY2UsDQo+PiBzbyBpdCdzIG5vdCBs
aWtlIHRoaXMgd2lsbCBqdXN0IHNob3cgMSBmb3IgZWFjaCBpbmRpdmlkdWFsIG5uLCBpdCdsbCBz
aG93DQo+PiBob3dldmVyIG1hbnkgdGhyZWFkcyBoYXZlIGJlZW4gY29uZmlndXJlZCBmb3IgdGhh
dCBuZnNkIGluIHRoYXQgbmV0d29yaw0KPj4gbmFtZXNwYWNlLg0KDQpJJ3ZlIG5ldmVyIHRyaWVk
IHRoaXMsIHNvIEknbSBzcGVjdWxhdGluZy4gQnV0IGl0IHNlZW1zIGxpa2UgZm9yDQpub3csIGJl
Y2F1c2UgYWxsIG5mc2QgdGhyZWFkcyBjYW4gc2VydmUgYWxsIG5hbWVzcGFjZXMsIHRoZXkgc2hv
dWxkDQphbGwgc2VlIHRoZSBnbG9iYWwgdGhyZWFkIGNvdW50IHN0YXQuDQoNClRoZW4gbGF0ZXIg
d2UgY2FuIHJlZmluZSBpdC4NCg0KDQo+PiBJJ20gZ29vZCBlaXRoZXIgd2F5LCBidXQgaXQgbWFr
ZXMgc2Vuc2UgdG8gbWUgdG8gb25seSBzdXJmYWNlIHRoZSBuZXR3b3JrDQo+PiBuYW1lc3BhY2Ug
cmVsYXRlZCB0aHJlYWQgY291bnQuICBJIGNvdWxkIHByb2JhYmx5IGhhdmUgYSBnbG9iYWwgY291
bnRlciBhbmQgb25seQ0KPj4gc3VyZmFjZSB0aGUgZ2xvYmFsIGNvdW50ZXIgaWYgbmV0ID09ICZp
bml0X25ldC4gIExldCBtZSBrbm93IHdoYXQgeW91IHByZWZlci4NCg0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQo=

