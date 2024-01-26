Return-Path: <linux-nfs+bounces-1450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED2F83D29B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 03:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB611F25EC3
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 02:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32011C0F;
	Fri, 26 Jan 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9MQLbK6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rtbyz2LW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636E1C17
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236650; cv=fail; b=nKAHtqpNA8KK+R8TAaouVJhjyGUduJcVINdrE6Y//3mUWwQN5jP6YN6bYP25s9AYjh0IbG1sFgtol7VZBI0kid4pI91lHe/PO6e+jLcOzK1GMuJrMr2Mfg7EgxKXm2mYOiJ4OwxrthF++gUujxV+LKZwZ01qJ882jlz6yv2M0as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236650; c=relaxed/simple;
	bh=aVFXWVEEVDcqtopxAoLC2oPKmlZ22nMnGMLXd9Tg1N4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N8c0EFfr7TCT2M/IJTTTAhaFLyleOSmLpfTD2SEsbrxzJsTzh80T2JrieCN2CF654AENWoRe6w6na7ZLkP5nqg/JXpYmOkzUEZfvwiRAyRJRlqeBOZugTXmlpQCdtvOW3n95NtZ0w9GYOSGY7gkntkDZVbXYuaUYuBwW5VxlpII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O9MQLbK6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rtbyz2LW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PMrJcg020562;
	Fri, 26 Jan 2024 02:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aVFXWVEEVDcqtopxAoLC2oPKmlZ22nMnGMLXd9Tg1N4=;
 b=O9MQLbK6wieOFIhOk+cm7cytpwhV0gr4+fHLSJP601akPdqAm3x8mmoKbFvHm2M7BHMr
 tRYAMMUChLIoTN0yT53fvOkTZZCBdC6eSHgr+jhYMy3Nk+lkdC6eo3E8rb/L4pS1H9Zh
 V3pnMubzZumxfHUnn6fF9M+xkJgLC088QYecei8CU+vuk35KFFIq6FlIsyDS7w0h79YB
 tBkpCbJaEuDZutDoL+qkQGcfEk97vA3poItJ8P3xwxvootFFSslSu0ks9tseTY3zXUyy
 uJ90TBQR41b7d/3ZblKVzWb5PVvsp6H6sjFY8JT1klwqYKwjINNQ7GqXcZip2OB/nCqx lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w996b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:37:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q0JH9U011688;
	Fri, 26 Jan 2024 02:37:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs326uesy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPzQSEypdJO6Fc03AV+1yKEE1RHWODRNyBlWXVsaBOqKG+APRCgyyKC6Eve2TtVGsDAPq5YQdnzycnKiub8ZRkcOcBhys/XcnWd3rBmRmw2+9jEqZhnE/k7GbqinhpYAIBJhu7HgivSBdgBpF/qLHnErFoAMBUSMqC379Vbqe3ijiS0n1qC2jIJ11rjTfW97T9LOGmUcvIJGEPqtS2oxTQ2HzfT8zCxrvq27YZg+AmBHZPJHRLOUQn9J2Eg+7oBSDT9ODLxZ4a5k3qzDsBbJzO+XzYhm61cYCNEq6wj4XQn262Gv4dJ0wIyGjDY+AKicFnuQvfXhW3kKI3c087z/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVFXWVEEVDcqtopxAoLC2oPKmlZ22nMnGMLXd9Tg1N4=;
 b=LSnjpUaDqqIeA6xWY5UyadLpSUyD+drdi+vaGp+cceKeFlgQnNzE1iNjyWupGjkmUIr0dyG0U4jfIA1uHHFa27xMYZ4NZcxYaoIkEDu05eVIoMjxa2zG+8d31ivhsuYag/J1YLoY/erLzUCrz7w7I4Rsr8I0IiPAHwE7mtnuE/AgrP1/7TZSIKMTYftQx2/9Z6uvTDr7y0IKOT8Q9aNdg3k3fu4FlGxstgGujyhUUFiWz9zvYdx3qYrJuUQyk15/7pB27x3Q1XVebkwvYAxoL90T6lgRAh4SGtMevQQxXDTgFvhBZfRguOLQL2Zt2GO0Xrvnji51M2kfED+nGKIeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVFXWVEEVDcqtopxAoLC2oPKmlZ22nMnGMLXd9Tg1N4=;
 b=Rtbyz2LWmFl5tMGrNyx6ut7CpdLGl/jjTurijKms07d0jmrY//tJjmL1/rENypNnLH/ePyUSyk30yDm2X3sQ3uhO1GjqupOgTdu79y1Klg3OWq89fIGfEASDVasfrQ3t+OmPlDERTpjbo3ssr//ZpkshkC63x2hIOqtVVeOjS1E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7764.namprd10.prod.outlook.com (2603:10b6:610:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 02:37:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 02:37:14 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
CC: Cedric Blancher <cedric.blancher@gmail.com>,
        Jeff Layton
	<jlayton@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        NeilBrown <neilb@suse.com>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia
	<olga.kornievskaia@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
Thread-Topic: Should we establish a new nfsdctl userland program?
Thread-Index: AQHaT8Zp476+VGqpskq8+ahQ0OuBVrDq8R0AgAAIaoCAAEpCAIAAHcGA
Date: Fri, 26 Jan 2024 02:37:14 +0000
Message-ID: <EF137514-5F62-4E64-9727-710CECE764BF@oracle.com>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
 <CALXu0UcV0b8OvH7_05tD7+GRgoXRcp9fd1aXuHjtF2OBDPmSJw@mail.gmail.com>
 <66892D4F-4721-48E5-A088-BD75500275AD@oracle.com>
 <CAAvCNcA4x1vR2Bh0vTy+kc7tK0t7sdM0JPJa5-XfLhD+-mLQTg@mail.gmail.com>
In-Reply-To: 
 <CAAvCNcA4x1vR2Bh0vTy+kc7tK0t7sdM0JPJa5-XfLhD+-mLQTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7764:EE_
x-ms-office365-filtering-correlation-id: bb5f0d11-b6a5-425a-72af-08dc1e17b47b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yJA+oY/Q+ThhHGnJRmhz2lvG+N7BOVHvog3T24qecZykGiCF6T8D4ZrtRCit84nhRiOoQ7opOhxf1gntuc40pvVrnTnHWBFMHdupW5vV28ROA3HJDOJezANZSk7FesjsNYL6mAQUKsYHAhT+N/Xt0hVaCnzq1Bj0FXKVLHidyalMh1t/DkT6VJ8BxOyZkDP3Zvq4JX4rUxpzgzfoSmdJdcd8pXYs7YEpAKfSuw2X/K2NWFGryfx7KfhYir7R9dWQ6uDc9qtLusnyaCD4R+6OOk/ONjKBqHUiOEEv/DhRstEOxcBZH8x7nf+DpPZeHbHFabraFHd9CWdKXhKPsXZDwy19oiuqvgKAG9uQ1VMd2pGVraefiJsEwd7vb7WNE5d4/Xvsddjdqel7ISUTKjzeF9TpFfesM5WKUTlv/b1SYnxtqEr0tPhmpczkD7BXklnP8e/B4AcCv1q5D9ev48KE6v8aMZKQjKg0iSZKYnY8AUk+T/cVTe7o8lxshM27pIRiAbOXTG4263A4up43JZ6MaMBRhTMmi7tiBKqxaa3dFdOZiyoQqnmeNaDSGoLhz/ggtcI19MiLCD1OecShjfrFpHQNvMAgqcCXywML9C422jVANLSi20mW7e6uPwA73+P0yMxxphTkKuO5p3GXx/upmrQ3eJcHGnLFndBzWA9lwf5rPnJu/xTSEg1HcGCMpluM
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(38100700002)(66946007)(6916009)(316002)(66476007)(54906003)(66446008)(66556008)(64756008)(6486002)(6506007)(76116006)(86362001)(71200400001)(91956017)(8936002)(8676002)(966005)(478600001)(53546011)(36756003)(5660300002)(4326008)(33656002)(2906002)(26005)(2616005)(6512007)(83380400001)(38070700009)(122000001)(40753002)(133343001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z0Zub0w2UkN3VS9vaUFFY09yWTErQW5IbTVqNHFMUmJ4WXE5K0RZYlJmYVc2?=
 =?utf-8?B?VHJWWDY5endvVFRONGtWT0NJTnk1amZKWVVMc3MvY2Y1OVZkZThSbVVyNXlj?=
 =?utf-8?B?Y1U5dTFUWVZPQTFCc0ZndUJkTEN5cTV1ck52aW5HdGNRblpRdE5ic1pXbDhZ?=
 =?utf-8?B?Z0pWOXJiTCtneDNmV3ZkVHpGVHVUZHE0Qy9lNE1xbUdXVnFTZTQyVWlnNjdn?=
 =?utf-8?B?ellnRXM5ZzlveVFQWFpTR0Y3cDFvc29zQmdGZzBSbVdIYnBNbk9laHJrNFNC?=
 =?utf-8?B?SVhGeHkvcHgzRHh1TFlJMHp3M1p5T2Vlc1UzOGN2bHEzdkI5dTlBbmkydjJ0?=
 =?utf-8?B?bmEzbzRPZVlsVDJKOUpsMGtGdEVTVkNqSTk4V2h6S0xSeEFOdFdGR2dLT0lT?=
 =?utf-8?B?em9HQ2I5QjJwZkw2YTB0Q1hsd0Z1Y3FOdkE0bktiem1aVjlCbWRKOVFqcytl?=
 =?utf-8?B?dWZyQ09WMitFbVJVdFk4NHNKL0pDRFN6bmNSRDNhU1hKcnhoZ3VYUVJoNVRD?=
 =?utf-8?B?cWVXeUZsQTBmR2c5MlpGUU0rTXE3NE9sTTRjbVVxMUhzZHl0dHNZejdBK3ZH?=
 =?utf-8?B?RnRnSk15R0RyYStrKzZkZ0picWhuTWZPbFRObDg1UGFTRktZcXRsZW90Rkt2?=
 =?utf-8?B?ZUxJZFJtbGpOQjZKRFFmbDN5NmNxdlpvN2xTRGFqQTloUzh2cU5lOW12RVVP?=
 =?utf-8?B?S1EzekthTDlTSENIeFQvQVNmZEVqZGRzTUVmUFhtclNMY2dMaHlXcnhQVDZy?=
 =?utf-8?B?THV2MzNWd1BSNGFKREltZDBzWWNOVTZmdENuWnlWbklhRUZTaVJLYXhJS3Mx?=
 =?utf-8?B?ZU1ubEZUSWEwUkpPbEQ4aENRbHd6SHFDTU9XMzY1eVVYaWlnRGNWeDBtYVZw?=
 =?utf-8?B?ck52ekVpZEFLN3ljcThHN3poZjl5bFpCTTRSUDdIeDl4cjFDMnYydlU5RTFp?=
 =?utf-8?B?QlpkMEhjWVV3alFpcHg1ZXJjYlJtU0NYMlRDVm1LSERFbG9SVUxhVmdlSXJZ?=
 =?utf-8?B?d3lDSEx3RHN0cFNtMk1JWFM3VGtvazA1WUZiQk93WUxySUlhSWI4b0ZTbkIr?=
 =?utf-8?B?WXhQdGVtRFAzeERpQXpOQTZnQnRqVmM1R3ZUVTNweEp1YThVQmxUcjgyMEVq?=
 =?utf-8?B?NGlZK280UmxDQnhnVlp0dkRXanpvL2FwL2lHSFI2cGtpZHNrTjdUdTIrTmhT?=
 =?utf-8?B?cG5jdWptRExsN0IzbVhmNDRMWFljaktKY0RNeDdxd1U5MndTdFMySWsrT3pN?=
 =?utf-8?B?aGt6NEJvcDkydFJldzRPUDNtZzhmbkhYeWxPVE0zekhnY2JlMFkrUTJGMFRK?=
 =?utf-8?B?QlRJVXNBOVFlRzNEOHNXMStTOWQzUFVlTzNYU2h5K2tkZVJCODNRT1dVWDFO?=
 =?utf-8?B?TG82YjcvcGhmSVByR0hMZ2VtcXlUNXpSMTJmSy9NaUQweW5jaWliYXptRUxW?=
 =?utf-8?B?MTBIL2dDZDhXK2ticnorYWlCLzBlazcrNjZLZWdtY1pkWkU1S3psVFhBSE85?=
 =?utf-8?B?TjFSeXpvWGxaSXJpelZTYktxQUZVZzVJRnVqbkxCSzhGS1NQVkNDUnN2aXRQ?=
 =?utf-8?B?VnRzeWVJT1AwdTFxczM3WjlPZVp5dHh4bVpwclhkQ3lZV3J4K2Y2NlJKd0JH?=
 =?utf-8?B?VUc3aXRhaVRRL3ZiL2ZqQWNTeENwQUlrMnVqRGxQV1dEQkVlTjBWVUUreGIz?=
 =?utf-8?B?Sy9NV05ZUVJqVkxrdk1aSXFlbTZ1SUpDa0JUUENpVXdpM0pqd0JKY1Y2UmVo?=
 =?utf-8?B?emdRdGdhR2UxbzBTQVk0QTlOWmIyRGNEcWlzMWdJZ09ocHFDMlNkNG9xelBM?=
 =?utf-8?B?SGZmOFFYdjNTUUYybVIrN3lOQWc3MDFVZzlXMmVqQTFsVERmdTdXT2xQTGJi?=
 =?utf-8?B?Y2NLMmdEVGRvaHVJQjlVV0wxenJDT24rSnhtT2g1dnlqOGJ4dTJSZHVpdENF?=
 =?utf-8?B?U0dxMWZOaTV6eGxEOHl1RnhlQ0NZMFBxeXU2dTJZNHk2MzJpYkViK29EVmlK?=
 =?utf-8?B?d29TK2V4RDdoRzArUGk1eWV1MklHTUxnb3JqZXJwOWlvS0YvSDZnWjRXem1B?=
 =?utf-8?B?WjZWVGxwUFVlVUtKOERGZUplYytMM2JQaXRUb2VjY3cvbXc3citBbGlRUzZw?=
 =?utf-8?B?SU8rdEVWN3lVcmpjbFVKVXo5WGRHT1krTDJ1Z2NMK2plVlluVmUxejh0WFFU?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A24F03714CE5764AA13DF2DE239FF518@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KYdu7D9ddSfzaWxvUrAHwPczoyRSL5j30vc+tRF6JCqQdansteA70pRqVUuyAoZoVfumG2MTtO92uYLv/O8hMKeNf3WZa8TuEfdjfPeuWZE9EOT89K9tO5sW8KjQfT67fOe5dA0U/QCRlJ/sr02fOTNjBed4TlwdgVLlhDAUGVVEbN2Njqr+Uv9HKF76/LhTbHzHk8OO4NNGv1cqrfcWMWM2cRUia90sHWVQoWmpNyYh2rCkGM9nD35K9w5f+O+k07nS1NF+XqiZKf29TBYZxi6gE3ADOTdw3CaHXef1gkqj/4g+JL5UtJvHxlL2xi9hhhdQOXBKMJF0NPoUecdgDZUhSKmn6lFFSz4Gg8IrsCw05OzexDInuF+3S3gpDT7IhuB2BAlm4LvxBLnhqbWE9ndRKu91Y4PsEWH345udcxh+tXCrFRo87TkCSHETCgoMaHo/vrJk9hz1w/0GEEc1kqLNHzClpwp+JBVGqblHQiDdJ/t0DDH2nEcesuvnOFB0u4Iz4wIiIiesqYqmsIFTz24wLVvpmZMRH/qJ3qUdaYY0fRoxZd3cezbW4TMVZFEF5XjEKJPh8PbWPdDG1TMGvXL+uPS24szjyO2zRfJKvZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5f0d11-b6a5-425a-72af-08dc1e17b47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 02:37:14.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1JhkG/rmWtaWZVT5J7pi5k9LI1HMHatEUfAmmJMbNA6EcBdsDYHrYb0WWOMcYUFVH6EZR+S0lFcRUjGqw7Wmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260018
X-Proofpoint-GUID: OCO8opT5r7BXxouOiM9yucfDLPNJSEMG
X-Proofpoint-ORIG-GUID: OCO8opT5r7BXxouOiM9yucfDLPNJSEMG

DQo+IE9uIEphbiAyNSwgMjAyNCwgYXQgNzo1MOKAr1BNLCBEYW4gU2hlbHRvbiA8ZGFuLmYuc2hl
bHRvbkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyNSBKYW4gMjAyNCBhdCAyMToy
NSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0K
Pj4+IGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2h0bWwvcmZjMTczOCBjbGVhcmx5
IGRlZmluZWQNCj4+PiAiaG9zdHBvcnQiLCBhbmQgdGhhdCBpcyB3aGF0IHNob3VsZCBiZSB1c2Vk
IGhlcmUuDQo+PiANCj4+IFJGQyAxNzM4IHdhcyBwdWJsaXNoZWQgdmVyeSBjbGVhcmx5IGJlZm9y
ZSB0aGUgd2lkZXNwcmVhZCB1c2Ugb2YNCj4+IElQdjYgYWRkcmVzc2VzLA0KPiANCj4gUmVhZCBi
ZWxvdywgeW91IG5lZWQgWyBhbmQgXSBmb3IgSVB2NiBhZGRyZXNzZXMsIG9yIGJlIGluIHBhcnNl
ciBoZWxsLg0KDQpJJ20gd2VsbCBhd2FyZSBvZiBob3cgcmF3IElQdjYgcHJlc2VudGF0aW9uIGFk
ZHJlc3NlcyBhcmUNCndyYXBwZWQuDQoNCg0KPj4gd2hpY2ggdXNlIGEgOiB0byBzZXBhcmF0ZSB0
aGUgY29tcG9uZW50cyBvZiBhbg0KPj4gSVAgYWRkcmVzcy4NCj4gDQo+IEkgdGhpbmsgeW91IHRh
a2UgdGhlIHN5bnRheCBwYXJ0IHRvbyBzZXJpb3VzbHksIGFuZCBub3QgQ2VkcmljJ3MNCj4gbWVz
c2FnZTogQWRkcmVzcyBhbmQgcG9ydCBzaG91bGQgYmUgc3BlY2lmaWVkIHRvZ2V0aGVyLCBhcyB0
aGV5IGFyZQ0KPiByZXF1aXJlZCB0byBiZSB1c2VkIHRvZ2V0aGVyIHRvIGNyZWF0ZSB0aGUgc29j
a2V0LiBJdCdzIHBhcnQgb2YgdGhlDQo+IGFkZHJlc3MgaW5mb3JtYXRpb24uDQoNCkkgaGF2ZSBu
byBhcmd1bWVudCBhZ2FpbnN0IHRoZSBpZGVhIHRoYXQgYSBsaXN0ZW5lcidzIGJpbmQNCmFkZHJl
c3MgaW5jbHVkZXMgYm90aCBhbiBhZGRyZXNzIGFuZCBwb3J0LiBFdmVyeW9uZSBhc3N1bWVzDQp0
aGF0IGZhY3QuIFdobyBkbyB5b3UgdGhpbmsgaXMgZ29pbmcgdG8gZm9yZ2V0IHRoYXQgc3VjaCB0
aGF0DQpoYXZpbmcgaXQgYmFrZWQgaW50byBvdXIgYWRtaW4gaW50ZXJmYWNlIHdvdWxkIGJlIGhl
bHBmdWw/DQoNCk5vdGUgaW4gb3VyIGNhc2U6IFRoZSB1c3VhbCBhZGRyZXNzIGlzIEFOWS4gVGhl
IHVzdWFsIHBvcnQgaXMNCjIwNDkuIFRoZXJlJ3MgbGl0ZXJhbGx5IG5vIGJlbmVmaXQgdG8gZm9y
Y2UgZXZlcnlvbmUgdG8gc3BlY2lmeQ0KYm90aCBhbiBhZGRyZXNzIG9yIGhvc3RuYW1lIGFuZCBh
IHBvcnQgdmlhIHRoZSB1c2VyIGludGVyZmFjZSwNCndoZW4gdGhlIGNvbW1hbmQgaXRzZWxmIGNh
biBmaWxsIGluIHRoZSBjb3JyZWN0IGRlZmF1bHRzIGZvcg0KbW9zdCBwZW9wbGUuDQoNCkxvb2sg
YXQgdGhlIG1vdW50Lm5mcyBjb21tYW5kLiBUaGUgYWRkcmVzcyBhbmQgcG9ydCBhcmUgc2VwYXJh
dGUNCmJlY2F1c2UgdGhlIGFkZHJlc3MgY2FycmllcyB0aGUgaGlnaC1vcmRlciBpbmZvcm1hdGlv
biwgYnV0IHRoZQ0KcG9ydCBudW1iZXIgaGFzIGEgZnJlcXVlbnRseS11c2VkIGRlZmF1bHQgdmFs
dWUsIG9yIGlzIG9idGFpbmVkDQp2aWEgYW4gcnBjYmluZCBsb29rdXAgaW4gc29tZSBjYXNlcy4N
Cg0KRXZlbiBpbiBVUklzOiB0aGUgcG9ydCBudW1iZXIgaXMgb3B0aW9uYWwsIGFuZCBmb3IgbmZz
OiBVUklzLA0KdGhlIGRlZmF1bHQgdmFsdWUgaXMgMjA0OS4NCg0KVHJ1bHksIHRoaXMgaXMgYWxy
ZWFkeSB0aGUgd2F5IHRoZXNlIGFkbWluIGNvbW1hbmRzIHdvcmsNCm5lYXJseSBldmVyeXdoZXJl
IGVsc2UuDQoNCkhlcmUgYXJlIHNvbWUgZXhhbXBsZXMgdGhhdCB3b3VsZCBiZSBoYXJkIHRvIGNh
cnJ5IG9mZiBpZiB3ZQ0KcmVxdWlyZSAiaG9zdG5hbWVAcG9ydCIgOg0KDQogICMgbmZzZGN0bCBh
ZGRfbGlzdGVuZXIgeHBydCB1ZHAgcG9ydCA2NTUzNQ0KDQpHaXZlcyB1cyBhbiBBTlkgbGlzdGVu
ZXIgb24gVURQIHBvcnQgNjU1MzUuDQoNCldlIGNvdWxkIGV2ZW4gc3BlY2lmeSB0aGUgYmluZCBh
ZGRyZXNzIGJ5IGRldmljZSBuYW1lIGlmIHdlDQp3YW50ZWQ6DQoNCiAgIyBuZnNkY3RsIGFkZF9s
aXN0ZW5lciB4cHJ0IHRjcCBkZXZpY2UgZXRoMCBwb3J0IDQwNDUNCg0KR2l2ZXMgdXMgYSBsaXN0
ZW5lciBvbiBldGgwJ3MgYXNzaWduZWQgYWRkcmVzcyBhdCBUQ1AgcG9ydA0KNDA0NS4NCg0KVGhh
dCBzZWVtcyBxdWl0ZSBmbGV4aWJsZSB0byBtZSwgYW5kIGRvZXMgbm90IGRlcGVuZCBvbiB0aGUN
CmFkbWluaXN0cmF0b3IgcHJvdmlkaW5nIGVpdGhlciBhbiBhZGRyZXNzIG9yIGhvc3RuYW1lLg0K
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

