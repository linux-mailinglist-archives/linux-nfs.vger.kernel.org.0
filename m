Return-Path: <linux-nfs+bounces-646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CDC815106
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967C32864DF
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F3741857;
	Fri, 15 Dec 2023 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CMXJt248";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FpIPuTu3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5594187A
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7sfv020259;
	Fri, 15 Dec 2023 20:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ot1k+3+owyujgl6uq8yaEEds/MzZ4BVyltYXSslxn+k=;
 b=CMXJt248wyXzryGLOwL+x421SENdvUD0EB8ZBb1AnNieRXqroq/KtLvBAJQPtgc+UjlX
 OfkXQCyxjo/grMNtfWPiTh/Ig6v7BNOu2ZhWA/cdzt/sgUSLglBolbLrQxBtbnxD/UbE
 JqFRkDj56H8stEY+AX+SyQOtxp/SbeaI06zuhcAqhQDdycOMCnOhgVDxwqQIbRmNf3u2
 Bpk9tza2HDsxjcuH8n2moI8GoIXsSk2vx8+bPCE1AiN6wlrAqC+h2bvsfsq0pHz4OSQ3
 vev/TggQ0UhI0j7AKfxpzkK2y5kQO41zPo88ZfxTUqpglJ3V83SRXqgnNO0yJIZIy1YB sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu2e6nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:22:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK8fA6029829;
	Fri, 15 Dec 2023 20:22:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepce83t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 20:22:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAwcAejSnzttIfQ/fZjFR77Nuv5mKIkXoy99Kabt+QLEGkUcyB1PIz3EmwUyLyyUEYvDlowfncrpOGP9bBhOG482+Dmnoq0U6PahHJ0r+8774BTnic6TQ4iUfT4yO1NAuEmM91FeLY9SrQYI/raS7HPbCwm24SqK75s4WdfO1/8qVLDp2XVLow2U/MwZNTpFyxr6wJF8AdNgVlttVBEcmS0fEyaTMuc6V802cTwNXTYgWkqb4X6usOoZ0MIrBVEta0uJ5YhiosT2Amx+UPkB0rbWAmn687FD1XeJQgw/gvE5LMzPd7P2mPVzyP2bLu1CpAcrQEtsRs4tjYso4pcBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot1k+3+owyujgl6uq8yaEEds/MzZ4BVyltYXSslxn+k=;
 b=nlWPeU+s2gdeWBDR8Gp4+E4FPJLTwa0sQ0OgQuvA7nVAO9vJXaSMpxqwNFFRvqx/HSmWSwT8XQWcB4cJWLvhM8femAOcLhjNBWYkI7XdiDyifpxTI1k5l4IYNMHjjY2yOOeCRdYjL0IKn1F+Bnctr1InhfzlRxIHwSRZIL5qxa5n+JnbRpsSegiH6Znf99tb0RRpc2kU499b4dgulMPVTbk/9C9Tj7OwBM9DFfoVlWzPkRXVYFse5lO0ws44Pl+MI/zrM/aIBc5ShB2+0gqj25AYuE2jxIUBW26mpmkTqb2UMQmWyVoUsWPDxUlJHxfg2uOMoYn7+VaYJcz6ae/abw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot1k+3+owyujgl6uq8yaEEds/MzZ4BVyltYXSslxn+k=;
 b=FpIPuTu33eLNf6IALlUGtKYebqxzIOW3EzfLDZ21kXPS4VW3D5NpAk2fW0DbhfsKCQV9eotHhLi7y4Uz+r43D3sRL8IOrx1yvjAT3dDSSMITUf2GcDNHfSbqHeGLO6uKTU1dw9/Bz+5b1brRUc5iTWY5U+wnUYB+In6rMsTU0d4=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BL3PR10MB6162.namprd10.prod.outlook.com (2603:10b6:208:3bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 20:22:35 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 20:22:35 +0000
Message-ID: <917ded69-d6bb-48a7-afab-9d58c267bb4d@oracle.com>
Date: Fri, 15 Dec 2023 12:22:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: restore delegation's sc_count if nfsd4_run_cb
 fails
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-3-git-send-email-dai.ngo@oracle.com>
 <5b07e47d33925128400559f6c5eef694a9984279.camel@kernel.org>
 <dc7a582f-3898-4f92-9fcf-bf76373f657d@oracle.com>
 <79cb6c0a54738a5ac77e4baa90f296f965f7cad3.camel@kernel.org>
From: dai.ngo@oracle.com
In-Reply-To: <79cb6c0a54738a5ac77e4baa90f296f965f7cad3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0009.prod.exchangelabs.com (2603:10b6:208:71::22)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|BL3PR10MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: c428cf95-52d0-4e7e-2ffa-08dbfdab92f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xogRV7wrnbFXaIpLmHLi6MFBF/KKmlDn7rcyrSuxTfdLJd9yLXVJcrO3i2d8PTpv0g6JRcXRIHaCZVBBJACOvxfWuGqh2sjxzkMClHGdq8fbLZsvFn4sACXF0W0FT5HMagYp6JO9GMthq/6sgDwpc0N02zJjHeA5ZucvNFg6sc5bLQmuySNt8aV/Hmih+m7DO4BtcH9XQj1kECz9vwqjRPf5JxjrtYrCx/60tNy7Gr2lAEJsuscAZ2vNf0ZJOxau09SFxC4zX2ZUUHCTOLBU7AcMThVYjDY2VazRVMDRMxJOHDe9q+SHTfx3l+99mFxMx7TZ3b4u7bhYDjunODVAlHOujzlgYwQWiXosZHyq+Cv0nEuyb9LhJmLhdXcl6NObNzAtunzFEpI2zYE+YByWNuRklTUjzhCc726uUrxlT7hg8nJikTSGgLLJF3Etpc92wSjN8WyLw/RKRXzeCrOuAp2QF8VaczfaIwJsq5j0dHLbJ3abimo20M5bSf72u+afpnh/ZY1XRgLaCbuLbL8BoCIpPchC0sXaqkC7y+DxjO7UyBUm1fakwhUuXErGYJQ/W6m6/MPNA20iIR1IsMGf2nBdVgUp4hS1puSnjvpKbijpmPaEMUaQUYS7isTh8A8h
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(4001150100001)(5660300002)(2906002)(8936002)(6506007)(6666004)(6486002)(6512007)(478600001)(9686003)(53546011)(66476007)(66556008)(316002)(66946007)(41300700001)(38100700002)(31686004)(86362001)(36756003)(31696002)(2616005)(83380400001)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnZWYTR6cGVuMkxJZGxmb2drS0Rnb3BjTnpYd1RrMnVJT0xtbFBrNTN1aFhS?=
 =?utf-8?B?M3NGNlM1a3hXZTl4citMMnN6cWpIU3VFUDZ6eGo2TXl4c1hLZ2MvTlpldXlo?=
 =?utf-8?B?NDlnb2RZR093WU9jQ0dvcVphaEpJNjVtUzJiR2ZwUUlTaWlFakp1Z0o2eUVl?=
 =?utf-8?B?bURwZjdTa091OVl4cVRSUTVESjNhY3ZpUXJsd3k3TjNJYU84VmxWZWJ2cnZJ?=
 =?utf-8?B?YWhSS0NYMzZ6SWZtbk1oOVREMlRZdFpsTUpTanVFT3NwU0grU3RpT254TVFT?=
 =?utf-8?B?ck1Hd2xVY2luZUhjQUJ3L1ozdjFlWTBIWWN4cFNmdklpdXllK1dJN3E4L3FG?=
 =?utf-8?B?YlhuTWRlL3JtZ25xalZHMW4zSjNuTjVuME5Ddm5zMThWbTY4N2ZLUnJKSVpS?=
 =?utf-8?B?UTlUWVpDdmdBYUlqK21JQ3JqdEJtNXdGRktIUWtmM1JzRnVWM0NMd1Y3R2xx?=
 =?utf-8?B?MEtnZE1PS3NZZnlEc3BLWFZ4K3Y4R2Q5TldTK082OHhhc3dEVnhuUjN1Z0lX?=
 =?utf-8?B?WEVJOHVQSlRrWDgzYS9BU2xnN3hLeU9GV29CNkRtYlptV3pJejk3WjRjMHl0?=
 =?utf-8?B?YWxMSjVMN0l0bGt6RmxqU3IwKzVtN3M0QUlyZE54dEhRODJLMnlscW5WTUIy?=
 =?utf-8?B?WERTb0plVzBSRGY1NlpIL2Z2aEdCMHR0VzNINVJxY3U0aDUraXNoSEdNblEw?=
 =?utf-8?B?SEE2MUkxK2lkY1duQlZCWDFyaXVHNHBYKzVNNElOUnNIZVQvYllwOGxaSEgw?=
 =?utf-8?B?YVBUeDNPUFErMFJ5TVBzWW5JY2xPNzVOZ2ZQdFBORDJzanA2UjNURzU0aThL?=
 =?utf-8?B?ekYvQThBRFpTNXhsVERXTmdRdGs5RzRIRVZRZkJLSXd5aW1QRGh4cFFCK2Yx?=
 =?utf-8?B?Wi9ib3ZkOGp5bXlRQW5mNUpJNUVZVlU1dXNIQWF4bVZCbW9kT3RtQjZ3Y21k?=
 =?utf-8?B?aEdYSUY5aFZ6ZHZwb0JadUN5VTdOTGtLVjBDeEF0QklvU0xTZkdJWWZmaDZs?=
 =?utf-8?B?Tkt3SkNNZll1dW9uMXUzY2R5YVhPYWZHQXg4ZGpHRXhkczYwY0RqNVFJc1Fw?=
 =?utf-8?B?ZDlPb2xMMTJIckhnQ2dNanFwNnVTc3RtYzdVWG8yRGpOWmtuTGhTQm1BanhN?=
 =?utf-8?B?Z09VRVlsU0hpYUlSNlZxb0hjWVBLQzdiNGtKMWR0QTJnSXY5bGVFKytDWERZ?=
 =?utf-8?B?WnBUQytpYld4bngwa1AvbS9ibVJma0hYcitLZVpZclN1SEdzZkJJNTlkVFJh?=
 =?utf-8?B?UkRDNXpoc0czUlRnZG5VZTlmS2ZwQ1ZMNHFyOTRyUTdLMXZoVFM4OTNQSUNH?=
 =?utf-8?B?d3BnaHFQd2FyRThjTzFPM2kzY0x5V0ZaZUlDNCtSU3BORDAvYlY2djJnOGdO?=
 =?utf-8?B?VnZoS1IrdkwycjlQdUxtU3VUMUhvV3NNSGkweDE0N3gxb2tnRnFnaXA2UVZx?=
 =?utf-8?B?YVVYMGNmK3lLWVFqYld5d1VWRDcxdjArRllWVGhaUnVHdHNyREh1cTg3MFpx?=
 =?utf-8?B?ZmpWTS9wVzFGVndWYlRnU1RkZExydWxFTXBsM1p2dGtSZk9FR3ZuU2daV3dr?=
 =?utf-8?B?eHV2UDQyZDJzLy9heXR2dXZNdkxmZ1dYN3NGRndSOHhTOUtGQmJrcFNxSnNh?=
 =?utf-8?B?cEwwUEpwUGxpRG51RWdLL2ZVdG5zVWoyZy9hR2NOdkxHU2VYaW5ZSUJLSTMw?=
 =?utf-8?B?WG4ybjFadmhhcHNxQXFweFdMRFNhNFhPOU52cWY5UnorMnArUnl1MUtJWFdo?=
 =?utf-8?B?aU9VNGUxU1RlZ0pvS09haDFZeWw0QXFGT0l1YkVmQnFvZk50OXMrRVVRQ2hI?=
 =?utf-8?B?bWkxK2lUMm9PSDJjNUQyZHkzUmd6RzczY2RKWVFPaS9rakluODRaZmo3UEM0?=
 =?utf-8?B?Y1I5SXVXNVo1UmowYXRxdlVFd1l1UlgvaGhOUEU3MSt6K1p1SGV0QmdIck42?=
 =?utf-8?B?UkMwckpjSk1mUXB4WGtHb3RSWHpEdzhjMmx3TWR2dk4rdTRIVkwzL1RhSFVM?=
 =?utf-8?B?Y3p1V0d0S1UyWlg0SWl2Z3YvbCs4NnIvWGNHVGJLY3JrTlF1WmtKNzgyR1BH?=
 =?utf-8?B?K0pRcERGNWlzeTdEWXFHQUlNMG1iaS9wQWlobXg5Q1dROUtKbEdVT2tWQXZP?=
 =?utf-8?Q?9u/g1GfSMhuXjACS5ukFw6kYL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h4MTx0gxtr5reOMIovQXVgzBpIjHGQkfclJvB+s90ezUNZF6b0wtOC70TEpCsfZXk6ObLn9VpCOX2H9AkPaUqG4j/H1I3xQcwZFWAiUV/MZbjPZtw9aBmgaf3tCkdzO4Ff24pCR/732Iot5ALzD4a9n2AcTHXHAbZ3UG99Wcy/byYJy3l0BcqZY5qL79iUdugKxh7sDvmjCcQ+n8u5TjxFh5uipTakO1lKmJJnyi0Q4qk88dz+rNzNVd2gzQe8Euz4Op0hYTLDEqh7eD+tU6iDkr7RBIrw+YhC/Qp30B6HG39P/8XSgIpZO7GoMhpoNGihLsn2sSdBt7xbZa1b8Yj2jy5LMTYECwxDHeoM0wpyeuVR1ko/NIzJJrLOkpuky7mNrvJq0mBRa96UThhFv9iZfA33UafqkNq4PJqgiKs4CV/3GSqiwHxTCyHCZsQ3T7Upm7ojsQr7/P8/bNa2TGRPFbkhceqvoHZAq8h1dN4zViarnGwUNI1S+hv0kjW14hKUYhoiJKui7dlIjVXLB6Cdgi36r7DkExzdUnvSy4N4aV3zvY/Sdrednkz1fR1TKy3ewU7KixdjTvjxQXqLeY639VibLmIo1P6Q+kkmh4O+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c428cf95-52d0-4e7e-2ffa-08dbfdab92f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 20:22:35.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZidkGDphKLVXxhIhchvs5Wog1wJswF+Gx9GGKzEyp84CnjUVwItcQ4/c9ssbxQWTWZHZpL2SylplM0YP9ws1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150142
X-Proofpoint-ORIG-GUID: 67aevR1st_FHiXBCbviM-_OUuA2AwUzW
X-Proofpoint-GUID: 67aevR1st_FHiXBCbviM-_OUuA2AwUzW


On 12/15/23 12:15 PM, Jeff Layton wrote:
> On Fri, 2023-12-15 at 12:00 -0800, dai.ngo@oracle.com wrote:
>> On 12/15/23 11:42 AM, Jeff Layton wrote:
>>> On Fri, 2023-12-15 at 11:15 -0800, Dai Ngo wrote:
>>>> Under some load conditions the callback work request can not be queued
>>>> and nfsd4_run_cb returns 0 to caller. When this happens, the sc_count
>>>> of the delegation state was left with an extra reference count preventing
>>>> the state to be freed later.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 17 +++++++++++++----
>>>>    1 file changed, 13 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 40415929e2ae..175f3e9f5822 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2947,8 +2947,14 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>>>>    
>>>>    	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>>>>    		return;
>>>> +
>>>>    	refcount_inc(&dp->dl_stid.sc_count);
>>>> -	nfsd4_run_cb(&ncf->ncf_getattr);
>>>> +	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
>>>> +		refcount_dec(&dp->dl_stid.sc_count);
>>>> +		clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
>>>> +		wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
>>>> +		WARN_ON_ONCE(1);
>>>> +	}
>>>>    }
>>>>    
>>>>    static struct nfs4_client *create_client(struct xdr_netobj name,
>>>> @@ -4967,7 +4973,10 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
>>>>    	 * we know it's safe to take a reference.
>>>>    	 */
>>>>    	refcount_inc(&dp->dl_stid.sc_count);
>>>> -	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>>>> +	if (!nfsd4_run_cb(&dp->dl_recall)) {
>>>> +		refcount_dec(&dp->dl_stid.sc_count);
>>>> +		WARN_ON_ONCE(1);
>>>> +	}
>>>>    }
>>>>    
>>>>    /* Called from break_lease() with flc_lock held. */
>>>> @@ -8543,12 +8552,12 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>>    				return 0;
>>>>    			}
>>>>    break_lease:
>>>> -			spin_unlock(&ctx->flc_lock);
>>>>    			nfsd_stats_wdeleg_getattr_inc();
>>>> -
>>>>    			dp = fl->fl_owner;
>>>>    			ncf = &dp->dl_cb_fattr;
>>>>    			nfs4_cb_getattr(&dp->dl_cb_fattr);
>>>> +			spin_unlock(&ctx->flc_lock);
>>>> +
>>> The other hunks in this patch make sense, but what's going on here with
>>> moving the lock down? Do we really need to hold the spinlock there? If
>>> so, I would have expected to see an explanation in the changelog.
>> We need to hold the flc_lock to prevent the lease to be removed which
>> allows the delegation state to be released. We need to do this since
>> we just do the refcount_dec if nfsd4_run_cb fails, instead of doing
>> nfs4_put_stid to free the state if this is the last refcount.
>>
>> This is done to match the logic in nfsd_break_deleg_cb which has an useful
>> comment in nfsd_break_one_deleg.
>>
>> -Dai
>>
> So is this a race today? I think this deserves a mention in the
> changelog at least, and maybe a Fixes: tag?

I will add some comments in the changelog and add a Fixes tag in v2.

Thanks,
-Dai

>
>>>>    			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>>>>    			if (ncf->ncf_cb_status) {
>>>>    				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));

