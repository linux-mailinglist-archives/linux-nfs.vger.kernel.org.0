Return-Path: <linux-nfs+bounces-2428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66213885A07
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FFA1C21639
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7D84FAF;
	Thu, 21 Mar 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GamORfAS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HeO3AnOp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753284A57
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028153; cv=fail; b=FxAOFWLLRySZGz7ECekmkHNrkEkIdrk5yx+vF7KS8+IeLPc9LwWDiuqcfCTGvrfhEufT7O/rE5uOmKnieGBb1uTZzy+Mc1fTwM+rMAtSr6E+jmAbKmFZ2UzgVblALfCwUng4TVQ2lFhM50eWoKw0Q/5stzKD6uhfdSdSwDF0pNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028153; c=relaxed/simple;
	bh=ODmVucLptS4EHdWrCZEJBmhu3f7ZXGjNeIrDkPRYDlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fF/UF9M+hpYdQPMtJShrAXCYq1NpWeyxl4/YrbL6/APh6g2acwtvkuqx7A0WnVdmHNAqUArwTVuRRJD62mIhnQEodO78H/1IjSIqVfXsB+ReiC6ejw5PoiYRqf7qXcEk0cVYgG2YNFwik8OuOPLpQ9hrGofDZV5oxfX8uZyNAGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GamORfAS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HeO3AnOp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LCmS5Y010905;
	Thu, 21 Mar 2024 13:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ODmVucLptS4EHdWrCZEJBmhu3f7ZXGjNeIrDkPRYDlw=;
 b=GamORfASctY/XVa5zSFeMMbeXjy5lAoF3RA2cY1/gXzFqLYmnnlSgDNFoHTdiMtrE1Ko
 cHavQqVqgYKuJs2w65Xr5ax8cST+mE8ZZrd+VDbeFbQEyWlTpt6yxmmkxH+rSOaBt90m
 TncaUVvhwrri77o2q8Qgd3vYVe5bP3tPkwsdNpodZVbYB60r59jvpCiZkIr0AHpQ6gUT
 5ygzIhI1pWvCuWYXTFdoPTHn2r47uz8VKkHHSE8k/nLq3v1la3iedVH+7d7JzPwr1lEw
 0YQ/MbUUDKH1DrUuxDLjxL7z4eKduzp3KdfnP7UBEMhQRHaFRpYj6cgwKUmH3OYamvaQ TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aajawu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 13:33:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42LCVDfA006139;
	Thu, 21 Mar 2024 13:33:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v9h4jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 13:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnsJBXdCrBh8MKB/HWR/nETRSimZhWomkBBSK7IFd1QlT3Jr3Zvs/zQIdWrfxx2Mmxz+3M3A26p72vWxLKzpicupxXbRl/BWwfnh1g2V2JIhDQpgD7N2ALOPYW9sD065HwUDwclu+D1ZMWmvBZ/iRjFi+f8XPWertU3glt2eJuPmmCyl5qwkT0is4vaJrdb4IdEujfwdSrE3HcOWD+SK5DKbSZu9NpsXGnC7jUQBPfQL8cLdswP35nQZYys81cKNmUyh1+YT+XYd1oM70NMTGC0Gn2JtN5uYrfUOcVbLo5ErKJKwDxfUMwoSnfVqidyFB6dj/R/yhdxBFxLeKdFNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODmVucLptS4EHdWrCZEJBmhu3f7ZXGjNeIrDkPRYDlw=;
 b=TQVZVRSlntSHKfYB4VYemFKEac745xxNuCyYBayzAl8Kfm/fMw336P9NqehBm15LDzSWE3Wagaq23kyXwx76sUQ6aDvcjkDX0I72G25ziGgvVCTAoNcSxmCgW6aIkwzb4gBJBU+Ui9fslOM48ihJhBSQfuB10oYAp2U/EzI+t+4axyN/cie9gEDxjzusi3d8pqv9/ryLLz5ozQTwQTJoTv2OgHW2Xe7SJklfX3N5/DlPSxGHpQKlD69rt5+eJNiiPZat9WHOcCtzXJBGkGmh/EpvlTK70//JoEb4xpwr7YygNdZfRWXkAw7jKH9CGbxywNawSDZNxIWLArU/31JxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODmVucLptS4EHdWrCZEJBmhu3f7ZXGjNeIrDkPRYDlw=;
 b=HeO3AnOpzj8f30M0cCqYYLcu1MfAzCcY1z6hYitW+VGl5VeQFJ84T0VXhZhKcIjS9flFKDpem9cW12g6bLLr57FPvlV8V0pawvt6yw44vOuTfeBySm4pn19M61H2Etn1nxMhYnD4imx72GWgZWT7Vy5YEv0Gb240Hh8hks7NGi0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5887.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Thu, 21 Mar
 2024 13:33:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 13:33:36 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Rik Theys <Rik.Theys@esat.kuleuven.be>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RPCSEC_GSS_KRB5_ENCTYPES backported to some older long-term
 kernels, but not 6.1?
Thread-Topic: RPCSEC_GSS_KRB5_ENCTYPES backported to some older long-term
 kernels, but not 6.1?
Thread-Index: AQHae1kWpMGS0wQavE2n5+NCWRnGFrFCMgIA
Date: Thu, 21 Mar 2024 13:33:36 +0000
Message-ID: <F2ED9EC7-3A5E-41B2-B225-FBF28C99132A@oracle.com>
References: <ff131330-9f1c-493c-bfe2-8732a2730bf9@esat.kuleuven.be>
In-Reply-To: <ff131330-9f1c-493c-bfe2-8732a2730bf9@esat.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5887:EE_
x-ms-office365-filtering-correlation-id: 6f1298b0-8bc2-407e-4140-08dc49ab82e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iQhlHec0xPSVGCxotvz2G1+4TPzy/NsPzg0EGEI8iRGf7y3E9TPlHOB6q/xpCamwuHyRuY1yttNW/ctY7OiYbYb6TCSsP/xD+hVX8DhNhKL/UdsiP4QwX+XnVZTQPGP6v9ljvh1fgzSkJjIzqVZVTSKipaClwKM5NM0FjMfVJGq3LyiiRXocLKslKoleJKJaih3xnnxyTmTZ9ceLvc6izWPObwnA1z/vZR55E9bD+dxmarSN89x2zfSK3dwdXFN6M/RuTvHzI+l/d93d6eLI6Q20thOUSazr71IemBFB9R4CqQU219Dgamw0dH6y/qdjywDCwpeoxOqko40XgbRu2vVeg87MxFGjCXMy3n/4XxnpHZy7kz6NGQ1Di4yIqZURYjIjWNv1kMUArR4OXYCdWgdUBF543M2IJI1eQTdeLlMuH8gOnfC9VnRGAgQ355ujgwQtdbsSlZUU96l1Q2c768mo5spkaVCPjUnnqPEKuMNg9IAmWnX5cXDyzR1GIv3HagsYxf9/3klzD7O3qJXTJo/nTP6LNb1jCzIgZjvS9IfKnSxLcD6MwCgf01u71eq2UrQCfIASp5VXEDz5xi8+dIdHJey1hlDrsr5BHYnGgE3svxhOdd6XTd6XDPmap78RgumdoHjzlQu0b1VAfS4lv4gc4nVYiAnmwOa0IXEKWNE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Mk5tKzZiVGx2aEovdXZnd1hoQWlEOVlGQ0MvUGk1RnFKRXhmSGloV2g0RnFI?=
 =?utf-8?B?OWgzZnByaGNpWTh6UGg5Q084TXk0eXo1b1hMdGhTTDFNWU4wT2NMdmF0TTZ5?=
 =?utf-8?B?UTd4NEpVek5kVjdGSXlSWHpVZkFLSWZIRHk3bUdvbzY1L0dRTDFTdXljbXJi?=
 =?utf-8?B?QUo2alZmYm5QK09CTzhhLzZUaGlQL2JweUFGUThORmVQem5OS0tVQ1lRdUFM?=
 =?utf-8?B?dWxEMEFBcE1iTVZyNXVIUVZDbS9FRHNRcm1jb2JiNSticmhJYlZpMjExRkJa?=
 =?utf-8?B?OXFUR2c4SDVkRXZvYmlsdnQ4b0t3ZWNWQWVnVUNNQkFjNWlJME5OTFZ6bzR5?=
 =?utf-8?B?U0wxT3RLcWNCMnVPK2pvZ1hOT0ZjeG9NdnYvZlFHL2JyakpYMWhmdGJMb2NQ?=
 =?utf-8?B?MEtzVWNIQU4rVEJxbzIwZWFMekpwY1FFOGh3aDZvZEdZVnRsZGhXK0phdXZs?=
 =?utf-8?B?Wm5Tcm1IcDFKSVlmYjJsYjV2VHN6anFUVEhGVnFjL2Nod01LVG9NUE9hVGkw?=
 =?utf-8?B?RjNSVjZ4dGZHMllWTUorTFhIdXZiVmthUndsZFhCUEx0Qy9tcHR1VDI1SXRL?=
 =?utf-8?B?cDJMRElOaFliMlcrTnB0ZDB0ZCtHMmd0S2tXUmFkL3MyeWNqQUtCM2lqUkNB?=
 =?utf-8?B?dmxtc2QxUnQ3WEFLb3RDRVJYemRhNUZtTkQrT3ZXTFpRVTVZc0ZvRWhOVjdZ?=
 =?utf-8?B?VHJLd2pNTlRKYllXR1k1bXhHbURVOGpsemR4V2FEQ2FURmtwVkJuS0JUS1hY?=
 =?utf-8?B?dmhvbHl0c2Jha2I3TGZHZ2hSYmZiZWYyWk8vOFlnYVlTUWhCR2Q4a2Q4WmpP?=
 =?utf-8?B?VldPU2R3VVF1YW9RODlkU0N2WTQyWklTWUY2cWNtQjRoSVlYVkRGRjJLOGRX?=
 =?utf-8?B?T2ZlUFg5N1RHMTFaaWpsS1V4ME5LSVdMdlgwc20xaW9rN3FuT24yemtMRW1s?=
 =?utf-8?B?SjN3VFZtbHk1bFlabHJFN09OZHlwZ2wvVE9FQ2xFUUZNdVpjbTMwTkdUTHEr?=
 =?utf-8?B?bmhReFgxOVZiQ1EzcmVGZDgvcDYzbjJ4VCtOL1ZFRXNGUElDQm11TUd6UVYy?=
 =?utf-8?B?N1FOUWRIeUZSL0NwS0lMWDRJalJmbDVsSEUxRnJhNmo4dk5WdEtWMWZjMms1?=
 =?utf-8?B?M3krVnA5VE1GVVQ0aHZsbjZRWGp4Wk9jUCtxWVFGK2VtQy83MjdYTEp5R0R3?=
 =?utf-8?B?V2VkcllNaWdVVjFaTzl3cjVsc1lnWGlCMThSNTE5NjB3TUxPMDRxYVc4a240?=
 =?utf-8?B?Uk55Q3VZYzU5d0twUmN0UGkzUTdKMVo1d2pFcGNDM0ZMOXEzRTg5WmJad3ll?=
 =?utf-8?B?MytkV1EvM25JRUpTZTdLcVI0Q1pJYmpqQ2EyejBaTTlYWVJGUnlac0d5QUxI?=
 =?utf-8?B?aFJwMUNRekZpazRlOEszcXhnNWZpZzh3RHV6SFVuMlkyOXJYVzI4VjBEUnJ4?=
 =?utf-8?B?ZDIzUmVTUDZxNWkySXZ5aWF1TXB4djlCVWlYNnBjSUxORjN2TXFzVGdINTJV?=
 =?utf-8?B?NEtFb2Fqek93em9XWnJydndiejBFUjlzTDJiV0VvellGcnE0bHp3NTlabjBK?=
 =?utf-8?B?dHhUQjl6STRUOTlLZlBvSS9Qa29CL0pjemlFUEt3c2hvTytTcUxPMEdFRHhT?=
 =?utf-8?B?c3N1c1N2SDhPbHdTbFZVQzZhc2srcVhvdkZ2SHVxZlJ0c0dlaW1yOER6LzFN?=
 =?utf-8?B?OGduRkhEaDd1SFlhUkFhUitZQk4rUXZqK25PU25HTGlzL1RRNGNPYVZTUEFn?=
 =?utf-8?B?K0xZeHpqVnVaK0tVM2owTFR2T2JRZlZXYlVDREJLTzVJVVlJbUFycnZ2YXha?=
 =?utf-8?B?UGJCSFRGcUd6YktRU2M3UnBRRElGejB2cG5mOFZYc3ZhVEg3a1BrSjhtKzlu?=
 =?utf-8?B?U0l1aE9IWXhkUzJqYk16SmVkaGc1QjRoUlFKSjRZVzFxSnNKU0N1UzBIckZp?=
 =?utf-8?B?Q1RIVEhmbzdBaWJTSGsycXg4amthZ0R1VWdzZEtJM1Vwd3VqaVFyR2FNUVBm?=
 =?utf-8?B?MjlQY0g0MWRKTVhiRkdSZmdEZU9MSVdOblB6ZTN3bXNMc0JTMHhzcElYTndZ?=
 =?utf-8?B?bVVwYXVDRXNjb3RnRGEyOUJxeE1ETVlmR3M4QTBDb1VXMzMxSkkrVUxmOXk3?=
 =?utf-8?B?enFOSE8weElIZ1VlWTAvZGVkU3pyVExPdW16LzhuV2lsVG9UYmRHNGlNQ2U0?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FF9293243B6E64EA9C91F673F0C0D90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ysux6AXr2revFy6/cpTQFQtAJpwJjwmMODUDnw3KP0idAxaG62Zv+9SnAKnu9XhsS2nO2lN55dXaywRkUrVHlF2JoMFgvyrZbDCrD1PgReQNyBDlbUz3Sv/kHFjFjS+o0qeI4a1DIDRr+MwaZiGd1trLh+xBdvu9W9JaJ7jDHcBd4dqD168L0y8bZGebvjXSG5skH3lh8GvnCpO3CWskte8p8bii+CBqkVewGfH8qBv8b6SDNX+S5gB38LZCinrWrX4Mg+cAF66iq8U7K6hRVi43AqqvTPvBIm8B/SSAgCQGptqkm0zIpZ/6VL/66Uucpt7tqc25saZaMSL9PV1ICLCpBrihp+pva9QPjgS1miYn+imS7t+wyNtEd88MlMBrj9y2y+/hUjYnecn60tcG3h6wMakNoTSwE7CrSL44MV6G/BsJy35r2w6zOvi7+EQTShJ5vFcQCsb0VYtEBBzbeoD+6IUD618kprHOq54QHoTsc1yH6NYvrB+JcFZB5AM2JVUQYkXlFYf7YWUMGd+V11JTmUyj6sdoy0b4Sn/8hzUdOODGtH+nwEqtCJc84sgpA5+1LjurTRospYvMhH0fXd0yyyB+sPkwVh6lZGFPUE0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1298b0-8bc2-407e-4140-08dc49ab82e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 13:33:36.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fHbhgN8ct67vMB2FanLgFwybZoCHgcH/O7qu0v3Ogo/Gpu43KIyGP1+oz26uZ8acgrSNgpL9tjEzMJ8jIB7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210096
X-Proofpoint-ORIG-GUID: 9NxKPedfheyrHH2mmEtovfLCyAPsD19Z
X-Proofpoint-GUID: 9NxKPedfheyrHH2mmEtovfLCyAPsD19Z

DQoNCj4gT24gTWFyIDIxLCAyMDI0LCBhdCAyOjI44oCvQU0sIFJpayBUaGV5cyA8UmlrLlRoZXlz
QGVzYXQua3VsZXV2ZW4uYmU+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBXaGVuIGJvb3Rpbmcg
dGhlIDYuMS44MiBrZXJuZWwgb24gYW4gRUw5IHN5c3RlbSwgdGhlIGdzc3Byb3h5IGRhZW1vbiBz
dGFydGVkIHRvIGNvbnN1bWUgYSBsb3Qgb2YgY3B1LCBhbmQgY2xpZW50cyB1c2luZyBrcmI1IE5G
UyBjb3VsZCBubyBsb25nZXIgY29ubmVjdC4gV2hlbiBjb21wYXJpbmcgdGhlIGtlcm5lbCBjb25m
aWcgYmV0d2VlbiB0aGVzZSB0d28ga2VybmVscywgaXQgc2VlbWVkIGxpa2UgdGhlIGZvbGxvd2lu
ZyBjb25maWcgaXRlbXMgd2VyZSBub3Qgc2V0IGluIHRoZSA2LjEga2VybmVsOg0KPiANCj4gQ09O
RklHX1JQQ1NFQ19HU1NfS1JCNV9FTkNUWVBFU19BRVNfU0hBMT15DQo+IENPTkZJR19SUENTRUNf
R1NTX0tSQjVfRU5DVFlQRVNfQ0FNRUxMSUE9eQ0KPiBDT05GSUdfUlBDU0VDX0dTU19LUkI1X0VO
Q1RZUEVTX0FFU19TSEEyPXkNCj4gDQo+IEknbSBub3QgMTAwJSBzdXJlLCBidXQgSSBhc3N1bWUg
dGhpcyBpcyB3aHkgdGhlIGNsaWVudHMgY2FuIG5vIGxvbmdlciBjb25uZWN0Lg0KDQpnc3NkIGlz
IHN1cHBvc2VkIHRvIHdvcmsgZmluZSBvbiBrZXJuZWxzIHRoYXQgZG9uJ3QgaGF2ZSBBRVNfU0hB
MjsNCmZvciBvbmUgdGhpbmcsIEFFU19TSEExIGlzIGFsd2F5cyBlbmFibGVkIGluIHRob3NlIGtl
cm5lbHMuIEZvcg0KYW5vdGhlciwgdGhlIGtlcm5lbCBleHBvcnRzIGEgbGlzdCBvZiBzdXBwb3J0
ZWQgZW5jdHlwZXMgdG8gdXNlcg0Kc3BhY2UsIHNvIGdzc2Qgc2hvdWxkIGJlIGFibGUgdG8gZGV0
ZWN0IGFuZCBhZGFwdC4NCg0KQ2FuIHlvdSBkaWcgaW50byB0aGlzIGEgbGl0dGxlIG1vcmU/IFRo
ZSBjb25uZWN0aW9uIGhlcmUgaXMgdGVudW91cw0KYXQgYmVzdC4NCg0KDQo+IExvb2tpbmcgYXQg
dGhlIG5ldC9zdW5ycGMvS2NvbmZpZyBmaWxlLCB0aGVzZSBlbnRyaWVzIGRvbid0IGV4aXN0IHll
dCBpbiB0aGUgNi4xIHNlcmllcywgYnV0IGFjY29yZGluZyB0byBodHRwczovL3d3dy5rZXJuZWxj
b25maWcuaW8vY29uZmlnX3JwY3NlY19nc3Nfa3JiNV9lbmN0eXBlc19hZXNfc2hhMj9xPSZrZXJu
ZWx2ZXJzaW9uPTQuMTkuMzEwJmFyY2g9eDg2IHRoZXkgZG8gZXhpc3QgaW4gc29tZSBvbGRlciBs
b25nLXRlcm0ga2VybmVscz8NCj4gDQo+IExvb2tpbmcgYXQgQ09ORklHX1JQQ1NFQ19HU1NfS1JC
NV9FTkNUWVBFU19BRVNfU0hBMiwgaXQgc2VlbXMgaXQgZXhpc3RzIGZvciA0LjE5LjMxMCwgNS40
LjI3MiwgNS4xNS4xNTIsIGJ1dCBub3QgZm9yIDUuMTAuMjEzIG9yIDYuMS44Mi4NCj4gDQo+IEkg
YXNzdW1lIGl0IHdhcyBiYWNrcG9ydGVkIHRvIHNvbWUgb2xkZXIga2VybmVscywgYnV0IG5vdCA2
LjE/IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGJhY2twb3J0IHRoZXNlIGNvbmZpZyBpdGVtcyB0
byB0aGUgNi4xIHNlcmllcz8NCg0KSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBBRVNfU0hBMiB3b3Vs
ZCBoYXZlIGJlZW4gYmFja3BvcnRlZCB0bw0KdGhvc2UgZWFybGllciBrZXJuZWxzIGluIHRoZSBm
aXJzdCBwbGFjZS4gSSdsbCBoYXZlIHRvIGxvb2sNCmludG8gaXQuDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==

