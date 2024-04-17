Return-Path: <linux-nfs+bounces-2890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8679F8A8BC7
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 21:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A964F1C21A70
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B21D52C;
	Wed, 17 Apr 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TmK+/cUl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AnTbsybn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4A24B2F
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380446; cv=fail; b=VGNmRbtQcy6DW4geN5ZG1cnvygBfjtupxRbAllRLLF7WLe53dDtwQ6AYbEKtJDPo1+KnrxfDFwfFtqUN9620vBhxscSgmktz8EtsmnKuESijWnS0MsH5Gc0WfjmQcSAnJb0AcEo+/7mViADvNXWh37uAgHeiry4R5IFHkkIdt8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380446; c=relaxed/simple;
	bh=jRfbD9sSlQx2yLoqhuxF7OSW2XzXGDNSPyLCUn3tpn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GiJ1zYsDTGW/kMIW1wPZVZWXGHabAd3VYUapC3oMTFCdT8SV5vr6W75waCIYgXQGM95jNeIbaCNS0eue9Bu/m2QdAe7C0aeJmX0UGL2SxbR0+DartfFi91md0WxUy2G8Hv4bA1eH3THnuT0w2+O15ypeVjIS+9FCjxvPXJs9p64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TmK+/cUl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AnTbsybn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HHhhvG009957;
	Wed, 17 Apr 2024 18:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=bwID8K5S9vGiP0dHdXXPf+2lClPzCpmCkcZZUfaltfA=;
 b=TmK+/cUlaDNXHockzIE5BwICzOKIxb9OV3Gs9XVZSPWVB+NcxIuM/trEUWt6uC+BWY4o
 mK+nx8nB089rRNNhEtmvC6SjyHsrQTc4LeUGLaSdwiSUEOs2LiHkCQt2KHzIwOlQd/1L
 KYQjPHqreprHwTsgQnYSBW4BlHeb4rwImx1sBOjvA+OhpfCewRMpUC3jBRAz3Hgr2ERH
 VShhOTcsKPwWUanS7PA8HSd/MuHUgRpteBS+1LFTRlkyMpNVobKsKNboGnc3zbVzxz8/
 tZYYTpRfzsHgeLzbaUP0gh6a4vmR/s2qfJpMohFasEpnaQktpfx5ilU1WHMWU5NL/S+v Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e8tqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 18:56:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HHKdke029171;
	Wed, 17 Apr 2024 18:56:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9999a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 18:56:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is990kUGGi+vJR2V3999nz5FvUTIHCmDS/WmjBlnuhi1QxR5ienfyPkEZKERsI1QSVYVcNftuHLdejsWe8PToC01cyY/PYpHfVhkEM8ZC4TQq1n47/IxlqzFPkvUsrlZ+QZ+zv848jYU2//DIdHVBVPldhcpzwdolvin46nWYlJEpXKCG0Bf6zBt87SLtOm+J7VQRvIXW3eP3CDkjmJI3eMr+VciVGpSGlNsrVr1PSP564xeQyWhHLKxTxIjlKpyOuKYAdd28gA06PfzsBmE2G4j1Xi6eLmENvzuHjoFPRp6J7isGp8Xk/ntLmhixDiNI5edRF1TguFjbjv6JDq2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwID8K5S9vGiP0dHdXXPf+2lClPzCpmCkcZZUfaltfA=;
 b=IQBDbPR8d2owvDL4DuKldYDfmIl5E/yz/01g5r4A0Vr34/C66SnMWJYb/LYA2xXVwyudAIWMCQ+9g35j4eISqIWPLXg8lkkpNmDWd97ordKkpCTiqvxSc9mTg7eZpeuG04TRhmSaISX8VcCeGtBm6qphLt0zrid+ojiBRbqvsZWXWGXJ/NZuWILFCvnecvp3gyANet9CjVWqk/qMSOHN5wvuZzxh8+Y3DlwSx9J+OKw7AICTZuldQtaKM2FHAjox2WRqFvaoxGz+yO2sfc7nTuCfFmCdyTSibaW6wZy3oLaR/2ihnBPn+ubvgSdntHBwwVucFIgXLNVBCS+WWsmhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwID8K5S9vGiP0dHdXXPf+2lClPzCpmCkcZZUfaltfA=;
 b=AnTbsybn9JRghmtEoNd64mUfo76VSo34TJ+yZucRHuzIINCVkzQUgGdqr06vy9v2gocWBidAVXWRAnGoGLYOdNkBN49BjZ/EYFBMC6TEd/t4ZWFfZ2FLbVNhjm4jf4g4pjKpK7QMUKr/MmKAKtv5t0P7vsK4iu7Nh/lCbba/tdo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.39; Wed, 17 Apr 2024 18:56:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 18:56:10 +0000
Date: Wed, 17 Apr 2024 14:56:07 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-nfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] NFSv4: Fixup smatch warning for ambiguous return
Message-ID: <ZiAbR5oTqMsBw/T5@tissot.1015granger.net>
References: <b1577a24c58a9b0605a4540c8be5c411a07cb04c.1713379239.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1577a24c58a9b0605a4540c8be5c411a07cb04c.1713379239.git.bcodding@redhat.com>
X-ClientProxiedBy: CH2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:610:4e::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 43499a00-abbc-4ae2-0917-08dc5f100bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k4Wkvw8uyJFY/JhMYOvJXeEbcIAr6oZS/8qK0hXEwhd7iBO5xX72svr82E8J?=
 =?us-ascii?Q?CqdisBdW75fwygIEN0vk7eaclx8HCcs/qsIokmufNoZgSxLxsmLyaTSf7Fvi?=
 =?us-ascii?Q?tm+IWTVq06GWMaoRCt9pt2p2VK8dNHaz1jM6VqvoFungj7QrnywIjGrw6B5b?=
 =?us-ascii?Q?GcDUUXcfiOgZtIHHfCCaHnaz2mEjF0zhjQE6oPV+BtRQ9vMBJc0ov/fQWzm0?=
 =?us-ascii?Q?K3ZQMPBS1H0XivNv5NX53+Byx7impoqS/0GyiN88bZIK9Qv5OnFvL+Fi2hUd?=
 =?us-ascii?Q?Jfejs/AqDWyAZ5OVUuUAlTFJIEDZoeEl3rvhO1KLYrc2nYwAq1/iCEoI/a6c?=
 =?us-ascii?Q?PglbVKFnk6hVpam8jLvE+HNJUcv0phmCXKerU8Izz0j1UA7Xjfbs/mdpkKej?=
 =?us-ascii?Q?iMCKK8+VX+escyD06mWSiShSS9kbVwo6MhRdw1m3OT+8lbjxPNI9tL7lGWd5?=
 =?us-ascii?Q?x4mgJ6cmMbPjTQtzUxiVg4nCGaBO668s4veSP4adrNmW9X9lN56+s1e9nqUF?=
 =?us-ascii?Q?voV1VTsXq4/WbmFSnTh2uVQ5YPz1QMAb9TnGuHZqA+1MDinzFDqDHC3b3toI?=
 =?us-ascii?Q?ttLbI6LEwi2FOTrcxi5NTUQmLK9Jdfc46kYO1FCRrA34WUe/F9Pdm0gtRYj7?=
 =?us-ascii?Q?Hc/MGqyrs/zHETX56BREzDgI1905Srmcp/eIk+WSei2DH3/2p3edqM9ADOS5?=
 =?us-ascii?Q?+qFkKBF+ayciSolUYMCw2eJFYKjncFmacvDRpCs+U8cZlFZq4Xn+Qr+8FgRz?=
 =?us-ascii?Q?e/1dzPk9Pg/3/aKTUqzjrSjWU02p6Uz/K9reJ8qtmCgnat9p+NcLfBufGYVG?=
 =?us-ascii?Q?P7CREXT5CO8mQb2LFyvVeLcl/e5V3rpuysR7hySqtkJr1UyWj3vnVhJGw7+V?=
 =?us-ascii?Q?W2pCT2kfs7FLRSwGaz072XnWabgjy8sg0kb/tB3/UCfEqFqEOClohXkKXti1?=
 =?us-ascii?Q?Vrwl9DtECmaOYTg6RR2SFo3xEiGehsDIkcZLxlklfwpA+FsnJydn6lxTraXv?=
 =?us-ascii?Q?CoTYWrIkgoDPZdZ45vfczgqiumK/lsC23vKIAWSLv+WJZJu11MxlZ6PUTVs8?=
 =?us-ascii?Q?MMYrzZ+swfogu0u0j4t1IEQNdnrldXnYEZtOqJ3aYdfkUBXNMaWhtZebdgzX?=
 =?us-ascii?Q?cYO9QQ3H2uuIvKMDWE5ArBS3l877UNFA9hi2oktA2dooQfQ970CLyzYRa0m2?=
 =?us-ascii?Q?Q4ADVgMVYvCCxw4JPSNNBEOY4lz72Df5vcJHD7uIk/C6/mLtg7uKaZXaU3qM?=
 =?us-ascii?Q?Y5XwSWHOtA1Du6bXndNXKshwJ++E9aolDGM16e4DFg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?74IcqHvZDaZwVXi5r45tMvRUdPku+DIl7J1KFzJ7h5kehCQ/TdKrfy6CTCtE?=
 =?us-ascii?Q?lkHobmIk3lRLnC0xIXqihtcPtA/rHj0lKdXkuc6327Qrdws40mViysdNUGVi?=
 =?us-ascii?Q?zCofZOym0z4gEg6hJe1VRnjvgeO3nVghjLJ9J9i3/Yn0YdKHTvYjvIzoAM98?=
 =?us-ascii?Q?T428Jk6qGYQr6/WyAoAAjytOXrQRZUmKjgwzWYDrB3eSByIZYTouqLQ22Pk2?=
 =?us-ascii?Q?DMmc7whSSWixeMurB9EtLJfHopCFwV8kLiy1PxgWHsefB2/9ZWO2KwuYNstF?=
 =?us-ascii?Q?N26PE9u8zUqk8LPJ29hbUuR02REOjpQJkYGD3OzW36VX3eDlD9xfRGRW+fzA?=
 =?us-ascii?Q?9IJuOtdk/R4uPGlVv7OAhqI/06mVzN3bqFJJQ08Yu+dKJX4y+AMiIlYvkhm8?=
 =?us-ascii?Q?odZY54GziyLrGRcpQCv6/ss2P0B7oCU0D0MloSeTiRvF6RuwJEE+bQXdxZZu?=
 =?us-ascii?Q?09cJQP61lohcsYAkW4a8kYgaJqAzOeJczAV2LoGbm1cpWhTy5hRiwMbyS3V0?=
 =?us-ascii?Q?Fgpp7cVaVAyuuWJ/57ULn21qEYASDB5OdQp9pLuprQR2er3k9bTgfcv3+OPC?=
 =?us-ascii?Q?bKrbqDnOmbKOGELAFEZGxt68mRxLHRVc/kKXbLLV1YXVJxhPDV7siBU2fFGV?=
 =?us-ascii?Q?09aSPzn5C7BFl4I+ZLSOJ3AuEKEVqaL2uo3GeEUruYb3h3s9PaF9ydDnVTS3?=
 =?us-ascii?Q?tarP/Pl4dG5uzoT3s0V0W+vwS+C1GKi9IH+9ar5Mfz9fY/LgKaWvV5OxPtT7?=
 =?us-ascii?Q?FbPsS2fySKGpAzeJb7RH8+lGNZpjtydB67rQn6+czHmhdrT+tlbdueikgUTL?=
 =?us-ascii?Q?sOnXbySZ/MzSzyUbxUK4JoSxXEQ/CfcVHQ9cHhBKG5PZt3PmY5FF3EG7Nfu5?=
 =?us-ascii?Q?svuW2r4FHZ+OyofCD2TudMxmxvgVZCzelG9Eq9gnXIsEu9MtW68gfJLTdAvX?=
 =?us-ascii?Q?NBwiMzoYXV+QCTP2xKw7nRaGl55cqHAXh3lETKCqZGhOcd8MT7A8pupT091/?=
 =?us-ascii?Q?FhO6bLwIqo2QmhsznVn/1Ri1xD2oAgGCS/Qy6WoqNB7WVmdOapJTq8KBQmbt?=
 =?us-ascii?Q?mhPbylDxNTEePU9vqs+/Fw49lGnvw4zHaLRfnKJ69hHD+yKuY4PLHA0FyvWu?=
 =?us-ascii?Q?AYx8ZagJW1COOYMnz1kEb7iqze/+VwIsAu46M58kLy9/D9vMM96hv8jjIBP+?=
 =?us-ascii?Q?lqSH2V9QRG9/CaJ6hI7UKUYKaD4wkR/eDuCCHwCDod9xF8249YFQBU7qNxjI?=
 =?us-ascii?Q?X624U5mcfUZ6hXgDH8ULK7Hqwqr3Lp2MimQD0yeXgqOAK/MXwCbajvhKelCn?=
 =?us-ascii?Q?Nlbhw4CaOmdZAvpPmUyEYYn8fXN/2aL5ETW5sLzwECZ4ooRtkLN3gXUX09Rl?=
 =?us-ascii?Q?HoXzYz7G0+a2PHmBWYfP+GTx5r/cat5QQC22W//yyJ2Herb4J4da/SHDGJX5?=
 =?us-ascii?Q?LS+U7250itKjOAupAWFghvOQUI6SAmPjtIJqBLTSh5PogbBISuV+mCcQx4sq?=
 =?us-ascii?Q?Q5daDJ9erl64WYDQks3p2ZhQLUnSXX69GVh7sZCSxobZ2QJepLfYx8Rortqe?=
 =?us-ascii?Q?ykTbfiHLGHjM9y5njgu579ihIK1u1KxdGss65Y+05VEoHRXuuF/i/kGkmnVu?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uDw7xV6Gl7DfKJt/hCYD3cAQL94eNdxT9pYq/r0F3K9CgsFePqLiSn1WcvQrTY3+qZVS5m6F2q7OHVfXbT+VfDRTsOOjPHIuB1sXaEheda3sz2jbT+EelNd1NQWbJ8/h1yoNnzUxydgiOK1x9Y0urkYiWEAm9vT2RPYhjxDhqZOgOMJZqemLJqGSMYhJTDzKuZxh9mGilLYjjZNEV96tOeToq6T6SZs3ZhSMIBsfuLdK7uOH3d6WgOtyA1dDdN9IIPK/ShVHbdcsdIVwouYxgCR8e/0XyK+Da2jtdTmj9Ypv4QFkp5S05BDQaRqH5yQ9GfDE8Xm6ZNnzFCYlmVM/IUFmoFBmeD1pmoSRgW76CyBkNdjK0Kw5ylLmVGFT5QZL/hUZMvyYmLI8tkVDdiCDmx6iUkUmcu4kKsweWG3M6uAFhB3Ls55yq5xKbd2sUcqM8yORCMeHg3iD6mx4xDNwqtf3SI8ZOoi+35Gxzla2QAozurT5rwkBPaosQVwbSrtntSOrQD/jzckbrcTpVofQYbsw6pTFgKQoJ9EpBH/UkdwkpjClt1tTwgXO4K3zbTb7SQZ6vfuKyLGfOuXIbofLYI7QLh0KF6oxwG8m56uHIUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43499a00-abbc-4ae2-0917-08dc5f100bb1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 18:56:10.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skNb1t3/OPaU1/Q7/McUNx9WF3uFtBFpTbH7b/rdTvhyXo9nRtcTbo+LYTBV20V9jM/V4/w9hLhQidb8vLaytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_16,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170135
X-Proofpoint-GUID: b59ian7QXyUJ3j6NV_z-C4hf3m6GXkyv
X-Proofpoint-ORIG-GUID: b59ian7QXyUJ3j6NV_z-C4hf3m6GXkyv

On Wed, Apr 17, 2024 at 02:49:29PM -0400, Benjamin Coddington wrote:
> Dan Carpenter reports smatch warning for nfs4_try_migration() when a memory
> allocation failure results in a zero return value.  In this case, a
> transient allocation failure error will likely be retried the next time the
> server responds with NFS4ERR_MOVED.
> 
> We can fixup the smatch warning with a small refactor: attempt all three
> allocations before testing and returning on a failure.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: c3ed222745d9 ("NFSv4: Fix free of uninitialized nfs4_label on referral lookup.")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> Chuck, does this look sane?  I don't have a simple way to test this at the
> moment.  Also, I think the only result of returning -ENOMEM here instead
> would be that we skip continuing to try to migrate for other filesystems on
> this client, and we'd get a log message and trace output of the failure.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


>  fs/nfs/nfs4state.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 662e86ea3a2d..5b452411e8fd 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2116,6 +2116,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
>  {
>  	struct nfs_client *clp = server->nfs_client;
>  	struct nfs4_fs_locations *locations = NULL;
> +	struct nfs_fattr *fattr;
>  	struct inode *inode;
>  	struct page *page;
>  	int status, result;
> @@ -2125,19 +2126,16 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
>  			(unsigned long long)server->fsid.minor,
>  			clp->cl_hostname);
>  
> -	result = 0;
>  	page = alloc_page(GFP_KERNEL);
>  	locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
> -	if (page == NULL || locations == NULL) {
> -		dprintk("<-- %s: no memory\n", __func__);
> -		goto out;
> -	}
> -	locations->fattr = nfs_alloc_fattr();
> -	if (locations->fattr == NULL) {
> +	fattr = nfs_alloc_fattr();
> +	if (page == NULL || locations == NULL || fattr == NULL) {
>  		dprintk("<-- %s: no memory\n", __func__);
> +		result = 0;
>  		goto out;
>  	}
>  
> +	locations->fattr = fattr;
>  	inode = d_inode(server->super->s_root);
>  	result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
>  					 page, cred);
> -- 
> 2.44.0
> 

-- 
Chuck Lever

