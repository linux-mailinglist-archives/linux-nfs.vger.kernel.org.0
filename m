Return-Path: <linux-nfs+bounces-4683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B18779294DC
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CE4B22141
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11C13A404;
	Sat,  6 Jul 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jbI5Pnav";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h6SbUcAE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35512AAFD
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720286142; cv=fail; b=QIBNbd0y3EsMa7gqJvCGmApT28XbIGMOHzm0US9C7IpLOn56gtUHv5IdUXIvAH0vv2uaQS6V6OP4xn3DfG22VT1wQcvwfXW3MgyJhgmBu7d48Pab96fz6+pUHDr5OY7IuiLl99dfbHV4UrvX+O5GDdCJ/bFQotfsyyAduARFSF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720286142; c=relaxed/simple;
	bh=VEqHj7kmA+rBjSawAJ3d0uZGgT9rnm4ntT5fzZMfNlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L1pDzKiY5Xxv+5eb0E1EvSPqbs/Wl3pBjmqRnhmdFLm8x/ZuiUYzxpuhF0McCmw3/ZfmofrLRnKzZM5g0wIcf8+gNdEo5L7kHqUvUHXbClWoZ1qRYeQTJJOaUNcHHQt8/N2ObD7J08N7wbj3+aYxfI0EU/D4FOoF26t0EQra6QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jbI5Pnav; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h6SbUcAE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4665dWAY004948;
	Sat, 6 Jul 2024 17:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=VEqHj7kmA+rBjSawAJ3d0uZGgT9rnm4ntT5fzZMfN
	lg=; b=jbI5PnavKCj+nLhmWMMRLGdjGsK/DSjh/odZl/o+h0Ok5R12f9M++wqFa
	/cJhjtn2KfSGx73ptbfuAIZGG5GGgP8NBs6IqnRvQN2xPTbhWzLi+GeN7Ali7beb
	h4fS64DjgSwgllQEHg9jt3OjAe2CwNSJwYQWnsbK2e+Xdn9VBucnkwcfNq+x+GAW
	dJ8W1EZDQEI+mffebAjSO58/+PoOnSnimHzXB3Y3IiDomhoevDGDcQSIamB0YVEY
	IGJPJR+yp/2FviRpB0zlB7Qv3/cuWhukfjy5kXPMI8BAruCMgMZjNgO7HRhyNcKd
	CM0YCB2W0TKW8nviCEE1wsuR51sTg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgprf7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jul 2024 17:15:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 466CW0R8025021;
	Sat, 6 Jul 2024 17:15:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 406vc4mnge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jul 2024 17:15:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUIGSGQhdVL+tsQ7eXKdXXsvTXotWp68jx0V68xT81BG0ctjrhL7BSytRjPI32PE64oyw4Cv7r9v4cxNBeQIpJrNXxdNMTKIt8OhgKohWp8q1/bS0Oh6aCCEFmD63ApEpqlQpZNMl6R+CMyLHTmwEgn7e6cL9W6NQomiX/gZ7cl5FgOjYOUk57Y6TNsbic2WBeqhO7jxgCiXCJE2t7KuaSmnPNt+Fjmdl5YoMUBt/H8+3ZW5Ztz0CIxNxT1bZQdHF2hP3rwsdnlP6D08jNDC/ZLYpbpKq2QPakc5esPW9V7BoQe9EyokNU59NfILdAX/IeDJk1Km4VWGdPi+Z1ymfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEqHj7kmA+rBjSawAJ3d0uZGgT9rnm4ntT5fzZMfNlg=;
 b=UxIsjsWyE3nxW+rGyPsnidS+eMrLDdNLTxoyF3qyGLAYWtlOulqojdC2JVCyQPXm0McaJY1odKakBEEQtsKT+prETTT2DlayFW03hF6TlAsUBS89AQHlLxa4er8voPkTuCzAHW9rOGKVAFCopCCuqoWdTCp1aiSRDc+mB0Y39BIfE1cFkTQe7IXM8grflwDFyO3Yf2dUAarDx2aTqLdZIhP4yLOlYdObl1ebCsiurNSl6vZvv5/QfiiI5rdmzzxo2bVt1Xo5+RgP66MbuxQZtNyza06xuDB1FQbcysVEoRsd+UwBR+3YtOPnPSxdVjYH3ULEf92slOnIGBdeIxJ/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEqHj7kmA+rBjSawAJ3d0uZGgT9rnm4ntT5fzZMfNlg=;
 b=h6SbUcAEBmkb5NTdBRP3WhYfLHM08diW57/wXIk7a7eRtWzoHceJOW9JKWX2zPdRt8dtB10ggZ+Mg5Da5BMCEn1zxHXqOCPItRdnQh4wECFP4rOsfIHICDoPhtqIubv2p9RpVPIveA/s829XnoK58zsu5P5ld5igaZJbtR0DcyY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sat, 6 Jul
 2024 17:15:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.033; Sat, 6 Jul 2024
 17:15:08 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux
 NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner
	<david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Topic: [PATCH v11 00/20] nfs/nfsd: add support for localio
Thread-Index: 
 AQHazJzmgcDeJH7XRUCD8QiVhiofhbHju8AAgAC4HQCAAD+aAIAAWoOAgAAPdYCAAAG7AIAAAbOAgAADUgCAABligIAA2CSAgADR6gCAALSggIABGiiAgACEe4CAAAnNAIAAAW6AgACwwAA=
Date: Sat, 6 Jul 2024 17:15:08 +0000
Message-ID: <CCC79F21-93A6-4483-A0B8-62E062BE4E6A@oracle.com>
References: <Zojd6fVPG5XASErn@infradead.org>
 <172024784245.11489.13308466638278184214@noble.neil.brown.name>
 <ZojnVdrEtmbvNXd-@infradead.org>
In-Reply-To: <ZojnVdrEtmbvNXd-@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5873:EE_
x-ms-office365-filtering-correlation-id: 4f482d1e-352d-4e03-b256-08dc9ddf2fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TFlnampBcjA2c3BGZ1RYcXNqalVuTFN6Z0FydXYyL3pLZ0ZQaTdObDBzVjJK?=
 =?utf-8?B?ck9BS2VrVGF4cW1RQTNkY3dDbnZPVklmNjBvMENnZGFvUlM0eFFFT1hKdDJo?=
 =?utf-8?B?OXB3WTFNWTFOaU9abHpOVXllVjdBOG1aR2Y2WGJQSGpVcEhHeGtZU28vTW8z?=
 =?utf-8?B?NW1ydy9HTlliVXhhNEFFMVoxcnFSMDJJMktxY3hnQmlUZnZMNXRHWWc1a21q?=
 =?utf-8?B?Q3BtcHVtZmtiQkxoMS9vUnM0ek1rQjNaaTRsNXVIYTZtb0ROWmV0QWZoZ3Bs?=
 =?utf-8?B?TDhubTVRQmdOYjUweE9ua1hrcWEwVUhyMlp2cUVJMXlmSml2Zll2YURBYTMw?=
 =?utf-8?B?T2VibTZnL2RTZnNlN3pIVnNuaGJqV1J5T0M4aEx0TDJlSEZraUFLN1RJYjRj?=
 =?utf-8?B?ZGdnQk9mL3JRQXd1Z0ZjeFl1YkIyMldxRjl6ZVZnY29RZllwYXNzZHlHMmVK?=
 =?utf-8?B?eHR2QUFTUU1hMUZTUW1FQi9nUkoza1ZWTkxjWTVJM2lYWlVvYTNxc1RWWWlV?=
 =?utf-8?B?NkRrOU1hdVBOQkNycUg2TGdBZ3ZVTURaVS91MVc3SWZTZzFjTWpVUFk5L1U3?=
 =?utf-8?B?ZDl4ZmR4Q1hmUUM1alRqNkRBL2lmUWNLbW83Ui9IL2psR2lJbjF5dG9VM3NZ?=
 =?utf-8?B?eGxuQS9nVVV2RTQzTlpIOG02RUpCRmlCckxteWpGS0t1dXBhNmtnM2ZUWkRv?=
 =?utf-8?B?OGtKV1V6NWY1ajZoTkZacjI5S3prL2pqOW9pVUw5cHV6RHAvMi9GQWdsbnp0?=
 =?utf-8?B?NDJ1RmxJenZTa2gxOEp4YTF1N2RoRUVCSHNjVDdlOWVsT3NEaTdKQ1ZUd1VW?=
 =?utf-8?B?QktiVjJ3YXNkYy9NQXBNZ2psZHp2WDFzUHdTc2cweHY5L2RpTVFoMUZtYzF4?=
 =?utf-8?B?VzZTZVFMcUdwa1NGcVdVcTFsOTBYQkYweFowUEgvT2hNVW1zb05GNllGZVRp?=
 =?utf-8?B?ekpyRmpNSy9GNjBTYy9rZDRIdWRmZXl2bTZJMVpQRzV3WEsxSTk3RWVYeHd5?=
 =?utf-8?B?WVdIK2xMZmdTaEdHRGNYTzk2YXQ0TWRIVE40c09zNW1hek1JZ1FNU2YvdWpW?=
 =?utf-8?B?b2I3VkZXY3BQeExnVUNtclVxQXpHZnVac1dtRTc0TkpOL2FwdHJxcERLR0sx?=
 =?utf-8?B?NHR3N3NMWXc5L0ZGTERKZjhtNDhEdUlZT0x0Sk9HeUVTT2plTkthZ045bzUr?=
 =?utf-8?B?eWV3RkhTOGVCRGZQRHZiQXViSHN4bnBpcHpQSXVucXNkYStSVjN6b3hldjRn?=
 =?utf-8?B?WEJNaURjbXZKNEwzQUJNWWRrT1loYURiYlRFdDJxY01Qc0hwZ1VIVFdmb2Fy?=
 =?utf-8?B?MnA4dzhvOFB3MVdCOUVQTmFMU0dROTNJWERJTHlnYk9DU3NKNGdYcW5VNXFH?=
 =?utf-8?B?bzJQMXlCcjlPQnhraFpyVmQxVnNrRmY3V0RsT2FRVTc0Y1B1Q0krZi9QcW0y?=
 =?utf-8?B?R0xMcHZqcDNHYU96Sld3TkdNQ2ZhK1d5S2FWOGlEKzdQSVc5M1JWNVdBZjJF?=
 =?utf-8?B?L1NVbjBWMXBOZ2NCQTVZQ3ArUUpSdG9Hek5ZZ3B6c21ZS0lja1RyOStHYStX?=
 =?utf-8?B?MXFIazJ2RHl1dVNEOG9mVWVWNmhCU3EvenhzUVBkOEEzSHhyK2RDYlBCTm8w?=
 =?utf-8?B?ZXdxcUxzWkRFMnpHdm1VZk1jakdoSEJTUklWcnh3UU5DODZhVmxOR2V0VGZN?=
 =?utf-8?B?Rkt0MW9EUWJaRUkvL1k5cm1SQlJCZnVBbFFabkhyNStKdXB1b3pVVXNQdHZi?=
 =?utf-8?B?L0ZEYTRUVlZsTFlxay90VzZVR0ZLOVh3R1Z4Tmp5SWsrdS9QMi9UdzdsTHdi?=
 =?utf-8?B?NG9HbVBOUGFZSTRpZCtzc0tYSklrSlM3aWcwNTBCT0FhZ3p1Wnd3dEFBTjAy?=
 =?utf-8?B?U2REeHMxLy9zaGxCc3pWMDZFZ2dWWmQ1bDN6MmxvNnVKcWc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T1NuQXpMelRuZTM4Q3NUbXdkTTdKTGNtT241emNiSmZYOHZSN3hjdzQzRVF5?=
 =?utf-8?B?NXArUGV1anhncUF0cDBzcVNlZkp4WHpBZ0wwVWcxZHcxTzQ2V2hOc0tsVXJD?=
 =?utf-8?B?U29EeC9jdHEwa1hMZGdMbm44VHppeFVtMXlJdmhKdW5oVE1nQVhPSC9OWjBG?=
 =?utf-8?B?aWc1RWQ5TmNzdzk1bUNWVGxqam9qZDVuUUM5a0NMbm5jYk1qSk42MFB1L1Fr?=
 =?utf-8?B?RFBMQUsrcmdKa2kza20rdmRSYUNYZnRHYzhoOG53Slk3dGp2cmVucTFqSk5S?=
 =?utf-8?B?MEVWaW9vSXY2UVE5M3l2cUVmWHVGY2RzKzE1WGNEeTNVdmxBaytjeTQxVXJh?=
 =?utf-8?B?WXRqcVRBN2Q5aDdDT0V5NDdtY2RaV0Y1b1d4YVNjck90UnM5VEJRSW8vcHNE?=
 =?utf-8?B?YnYzeGd3d1NldlovZ3RDNXRmb3VLaDFsbWxqUjAzTWM0MFZ4cUxSSTJ4eXRk?=
 =?utf-8?B?bzNLamE3djhmc3lJcW9qQzIvRG1zRVVKVnlIWU1rSFBQc09SeXRJQzJqNGNN?=
 =?utf-8?B?V2R6ajY0TlNhMGlxRHBwdUZxRFZWRThSMjJWdGM3RThSVzA1U0dLSW1sN0tS?=
 =?utf-8?B?OUQ4ME80SzQwaHUvaWZPS0RBdXpOWVY0VWpwaDRUQWN5eFVNRnNDZHdSQVFO?=
 =?utf-8?B?VHhTZHVtMFFrT09JUGgxa01iVXFwdG14TlB5eWVaYmRDN1l5ZkNUYUNWVDhZ?=
 =?utf-8?B?SHpIeFdQQ3VTZWVTcVdZUnZjWG5mMnhTVVdsSU44UmlpeG02cWJjekNVRGVm?=
 =?utf-8?B?Y2VwekhVa1JMSWZXTVA1M2QvTkg2UUMvQXM5STlLS3l2R0FhVjVHWUVqanVB?=
 =?utf-8?B?OUlzL1BNZXlhellrWHJNVFdNQStEaXVPOExKTFVRZ00rV3lDbldnT0JuQzFD?=
 =?utf-8?B?TFFHS0NUYnBVaW1wazcwTm9iRklGWHNwUVhxbGp0QlRxbTh2M3EwSHdaOVNv?=
 =?utf-8?B?dmNBaHVtdHRWbWxNb01kdURiekFzMThBR05kY255d1krbkR3ak5meVRtc09w?=
 =?utf-8?B?cWJ1T3hvNUFVeXZsd3FaMEhxK1dQU0R0VmRNNmY3ZWZtbGI3Vk05R1h3MkJL?=
 =?utf-8?B?YUJFYktGZ3RPN0RrMUk1VkhWalNkOWtBZkhtQ0xyNFUxdWVHVFNNd1hHRWw2?=
 =?utf-8?B?SFJ4L2pFeVJOZXpLWkQwbFM5QmJSRnZSWXk5UmMzUXlJdXp1ak94cldDYXV3?=
 =?utf-8?B?Rm42RHJWdGFqaHZtR29hbzY4dFdpYTEydWhHWG83bW5iRDJod05vYjlka09y?=
 =?utf-8?B?S2ZabnliRm0xSzdtMUVsWURmK1lva1krVVQwcWJBRDVDMSsyQlZFMXNBb0gr?=
 =?utf-8?B?S08vaElOSmtFeE1hT3crSldGK2txN2xBaFZZY3FzYzJCTW9SN0dteThiRXhJ?=
 =?utf-8?B?U21HQjFiSlVEYThNVG9tWDBxbkZXVzM3K2lSMjlQK3p1V1IzQU90aERhOHMx?=
 =?utf-8?B?dDFHbXVtcVpuQmRNSTNqR0pSZTgvRlpEYjRZeWltKzhtUUVFZ2hFc1IzYnFu?=
 =?utf-8?B?Wld2WXJhMlNtYnRkYzNDdzMxbXNuRHpOU0E0ejFsUmtIMjErNTlXNUppanlN?=
 =?utf-8?B?dFR0ZWQ3NnB5Y2tHN3hlb1JUOWxoRDNyMW9YdlprcjRPcnlKWHhwVVBKeGpH?=
 =?utf-8?B?WTByOGhicHFkWm5KNUpNa2o0dDhXZjlGcU5HMForYW5qRHBqTlJNWkF1Q3Vq?=
 =?utf-8?B?Nzh1ODRYOFFveGRIS1VjbkxTYWxocm9Oa2cvaXErNFRnMk5GeThtdnowNEZV?=
 =?utf-8?B?T3Q3OEJxMWJTSVl1SjRzNGJTaU1SWnpSMmlabE1BWGZzTmQ3cUl1TW5UU3NH?=
 =?utf-8?B?SzRNS3VBeUk0OCs5ODYyOHRSaXViNDFVMXZPdUNrd1Y3cWp4bkptamFGMkcv?=
 =?utf-8?B?YWZKdWkrR0IvMmZoSVNnRnpRUVdrL3MxdlF2bEIrRjJySHZEdjVYRkhKQ2dZ?=
 =?utf-8?B?REw1ckZ4VmFjdkR5ZG12ZnU2cDNXcEJtMUE3My8yMTltY3RGZ2lFZU1ZU2F0?=
 =?utf-8?B?UVpKam54akxubisxUHUweFFXNERpOHp4L29sV0VzdVFWVVovSHNBUSsyYjQ2?=
 =?utf-8?B?aStJSVIyK0RZc0tlUzM2Szc1UVJDNzlzeDJpM2pTWEtiOFJJY0I5NHdvVndt?=
 =?utf-8?B?aktCN0xCZXhoeEt2KzZKdjdwdDFmWXVLdU1vdUJnTC95Mk9BWVBCbkJEb3F0?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9625C4D969DED4BB0AF6076982B7735@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fcvRCJ95IFDGvXnd7KoRBuIv54LjmcqwbFSBaf63Wm3D8GMNXl0g78UR5GYKhZ+a34IlJCyUTvqqVnkjeI7D5C1NIUqxXnQbhNdCVuL1qcWPie4b8AbXZnZMkK3SoFVVi/4op53NJQfucqzp/Q1LaiUKLMEimqUar0iW3OU4m/6Ma2kC/JS5BdVLhK5ES57pbnfJWohlukAzwnvRzQpvwctagGJDkBS+tka7DKBHQrQAuRgP0wsh4sV/cp/2hUxiO+TsWF0fa2gxV1gJAdkQUl5AbPlN5BLr6i8TKR03PiGOc9bByKUJBgKsfCV69lfcNMXWIi6g2yIc1ekVcx4krKdbmckSmEquXDIXjDvkmQuHJQ8h3XekS3L9TdArxPbdtEtJ6bWUiVZn3+Ak7U41z21w9G9J3L3CU6CoHSupWJe+uVGxXszEQXtnrsT2zGCPBcQfmo8T0NCHKba1h4wJgR5vfnLfgMZTz2KzS3YBGgEhseLRh144cChyaBoCNejPRm9mplsMHHXQ4MqFjSAJeAnpKEKFlhqttLX66lZXfneWUR0aoLvUJkXhGUtq13wYrUKSzj9aIMvS9TkSpnivSELfBM1QiT4iWS/xcYCt/V4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f482d1e-352d-4e03-b256-08dc9ddf2fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2024 17:15:08.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rcc0nqwb7a092HlRRdMBkcURNigmGLDkAntm5anKHshZTK4YbyupMfFcdMsks/JhcJOlaF5MsU9JgKtCRomqcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-06_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=760 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407060134
X-Proofpoint-ORIG-GUID: 4DpMMqXUtArEUcOYfV660w0mwIbGVyof
X-Proofpoint-GUID: 4DpMMqXUtArEUcOYfV660w0mwIbGVyof

DQoNCj4gT24gSnVsIDYsIDIwMjQsIGF0IDI6NDLigK9BTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgSnVsIDA2LCAyMDI0IGF0IDA0
OjM3OjIyUE0gKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4+PiBhIGRpZmZlcmVudCBzY2hlbWUg
Zm9yIGJ5cGFzc2luZyB0aGUgc2VydmVyIGZvciBJL08uICBNYXliZSB0aGVyZSBpcw0KPj4+IGEg
cmVhbGx5IGdvb2Qga2lsbGVyIGFyZ3VtZW50IGZvciBkb2luZyB0aGF0LCBidXQgaXQgbmVlZHMg
dG8gYmUgY2xlYXJseQ0KPj4+IHN0YXRlZCBhbmQgZGVmZW5kZWQgaW5zdGVhZCBvZiBhc3N1bWVk
Lg0KPj4gDQo+PiBDb3VsZCB5b3UgcHJvdmlkZSBhIHJlZmVyZW5jZSB0byB0aGUgdGV4dCBib29r
IC0gb3IgUkZDIC0gdGhhdCBkZXNjcmliZXMNCj4+IGEgcE5GUyBEUyBwcm90b2NvbCB0aGF0IGNv
bXBsZXRlbHkgYnlwYXNzZXMgdGhlIG5ldHdvcmssIGFsbG93aW5nIHRoZQ0KPj4gY2xpZW50IGFu
ZCBNRFMgdG8gZGV0ZXJtaW5lIGlmIHRoZXkgYXJlIHRoZSBzYW1lIGhvc3QgYW5kIHRvIHBvdGVu
dGlhbGx5DQo+PiBkbyB6ZXJvLWNvcHkgSU8uDQo+IA0KPiBJIGRpZCBub3Qgc2F5IHRoYXQgd2Ug
aGF2ZSB0aGUgZXhhY3Qgc2FtZSBmdW5jdGlvbmFsaXR5IGF2YWlsYWJsZSBhbmQNCj4gdGhlcmUg
aXMgbm8gd29yayB0byBkbyBhdCBhbGwsIGp1c3QgdGhhdCBpdCBpcyB0aGUgc3RhbmRhcmQgd2F5
IHRvIGJ5cGFzcw0KPiB0aGUgc2VydmVyLg0KPiANCj4gUkZDIDU2NjIsIFJGQyA1NjYzIGFuZCBS
RkMgODE1NCBzcGVjaWZ5IGxheW91dHMgdGhhdCBjb21wbGV0ZWx5IGJ5cGFzcw0KPiB0aGUgbmV0
d29yayBhbmQgcmVxdWlyZSB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIgdG8gZmluZCBvdXQgdGhhdCB0
aGV5IHRhbGsNCj4gdG8gdGhlIHNhbWUgc3RvcmFnZSBkZXZ1Y2UsIGFuZCBkaXJlY3RseSBwZXJm
b3JtIHplcm8gY29weSBJL08uDQo+IFRoZXkgZG8gbm90IHJlcXVpcmUgdG8gYmUgb24gdGhlIHNh
bWUgaG9zdCwgdGhvdWdoLg0KPiANCj4+IElmIG5vdCwgSSB3aWxsIGZpbmQgaXQgaGFyZCB0byB1
bmRlcnN0YW5kIHlvdXIgY2xhaW0gdGhhdCBpdCBpcyAidGhlDQo+PiB0ZXh0IGJvb2sgZXhhbXBs
ZSIuDQo+IA0KPiBwTkZTIGlzIGFsbCBhYm91dCBoYW5kaW5nIG91dCBncmFudHMgdG8gYnlwYXNz
IHRoZSBzZXJ2ZXIgZm9yIEkvTy4NCj4gVGhhdCBpcyBleGFjdGx5IHdoYXQgbG9jYWxpbyBpcyBk
b2luZy4NCg0KSW4gcGFydGljdWxhciwgTmVpbCwgYSBwTkZTIGJsb2NrL1NDU0kgbGF5b3V0IHBy
b3ZpZGVzIHRoZQ0KY2xpZW50IHdpdGggYSBzZXQgb2YgZGV2aWNlIElEcy4gSWYgdGhlIGNsaWVu
dCBpcyBvbiB0aGUNCnNhbWUgc3RvcmFnZSBmYWJyaWMgYXMgdGhvc2UgZGV2aWNlcywgaXQgY2Fu
IHRoZW4gYWNjZXNzDQp0aG9zZSBkZXZpY2VzIGRpcmVjdGx5IHVzaW5nIFNDU0kgY29tbWFuZHMg
cmF0aGVyIHRoYW4NCmdvaW5nIG9uIHRoZSBuZXR3b3JrIFtSRkM4MTU0XS4NCg0KVGhpcyBpcyBl
cXVpdmFsZW50IHRvIGEgbG9vcGJhY2sgYWNjZWxlcmF0aW9uIG1lY2hhbmlzbS4gSWYNCnRoZSBj
bGllbnQgYW5kIHNlcnZlciBhcmUgb24gdGhlIHNhbWUgaG9zdCwgdGhlbiB0aGVyZSBhcmUNCm5h
dHVyYWwgd2F5cyB0byBleHBvc2UgdGhlIGRldmljZXMgdG8gYm90aCBwZWVycywgYW5kIHRoZQ0K
ZXhpc3RpbmcgcE5GUyBwcm90b2NvbCBhbmQgU0NTSSBQZXJzaXN0ZW50IFJlc2VydmF0aW9uDQpw
cm92aWRlIHN0cm9uZyBhY2Nlc3MgYXV0aG9yaXphdGlvbi4NCg0KQm90aCB0aGUgTGludXggTkZT
IGNsaWVudCBhbmQgc2VydmVyIGltcGxlbWVudCBSRkMgODE1NA0Kd2VsbCBlbm91Z2ggdGhhdCB0
aGlzIGNvdWxkIGJlIGFuIGFsdGVybmF0aXZlIG9yIGV2ZW4gYQ0KYmV0dGVyIHNvbHV0aW9uIHRo
YW4gTE9DQUxJTy4gVGhlIHNlcnZlciBzdG9yZXMgYW4gWEZTDQpmaWxlIHN5c3RlbSBvbiB0aGUg
ZGV2aWNlcywgYW5kIGhhbmRzIG91dCBsYXlvdXRzIHdpdGgNCnRoZSBkZXZpY2UgSUQgYW5kIExC
QXMgb2YgdGhlIGV4dGVudHMgd2hlcmUgZmlsZSBjb250ZW50DQppcyBsb2NhdGVkLg0KDQpUaGUg
Zmx5IGluIHRoaXMgb2ludG1lbnQgaXMgdGhlIG5lZWQgZm9yIE5GU3YzIHN1cHBvcnQuDQoNCklu
IGFuIGVhcmxpZXIgZW1haWwgTWlrZSBtZW50aW9uZWQgdGhhdCBIYW1tZXJzcGFjZSBpc24ndA0K
aW50ZXJlc3RlZCBpbiBwcm92aWRpbmcgYSBjZW50cmFsbHkgbWFuYWdlZCBkaXJlY3Rvcnkgb2YN
CmJsb2NrIGRldmljZXMgdGhhdCBjb3VsZCBiZSB1dGlsaXplZCBieSB0aGUgTURTIHRvIHNpbXBs
eQ0KaW5mb3JtIHRoZSBjbGllbnQgb2YgbG9jYWwgZGV2aWNlcy4gSSBkb24ndCB0aGluayB0aGF0
J3MNCnRoZSBvbmx5IHBvc3NpYmxlIHNvbHV0aW9uIGZvciBkaXNjb3ZlcmluZyB0aGUgbG9jYWxp
dHkgb2YNCnN0b3JhZ2UgZGV2aWNlcy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

