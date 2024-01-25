Return-Path: <linux-nfs+bounces-1434-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A526A83CDE2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E330B2577D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328B137C3E;
	Thu, 25 Jan 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRQAzvvY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZjmlCX7O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38861339BD
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216172; cv=fail; b=VLU9dG7DMWByC7LKhTHKJaMI5kZz43KuL9qOE5ARpjJg9LsHNLQxKMgUqPytFrng+cAVEyl9mI2j8kUe7DCx/tKp/avO34ASzX3YX1LgsHAQs7PW/XdTHeK1eXXtKa2yRuKOEszogV4OiAeZipuMZ/Wv10hAa4xw0ZDQNq80MdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216172; c=relaxed/simple;
	bh=f7pc0hD3gCv4Lt3QoHWEnz2pBxvtPNaWmZn+DW/i9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sRM/MrzPnbZTR1cm8i9xDBDAwFeTFyAKrTHvwgCZ3NvvJ3IU/gV2AF3UWpKbsoUUe2vaX50JU3HybcYxjlgu/+8iW0HWUAjPwpEsEPeLvrnH3C80C9E67vSj6oANgazO6ECIU9OKJ/eKunEJZ2TE+evTQuVcTWXtRhreL9CKqJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DRQAzvvY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZjmlCX7O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK3wXb020527;
	Thu, 25 Jan 2024 20:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=EOMjMNFBZ19KYwGuZD1XahkppQtiYjAEDrEshjW3aT8=;
 b=DRQAzvvYXW7gbDWo+rbcCbbkkCsO5uqYMMGJ89FcMi2us67VN44s1paV9krlxP+SQtyr
 s+nVbwwQEYKFd+mnGU/G9rgap/UzS+HFjgzhjqnX9vEKM+e4yHWOXL31rAg/z4IM3WaW
 o7HEMdK01fMXMfvnC23LF5FNYTbo06ewgsye711/d3YI5c5IONJ6Oa0KEpHKKhduw/WB
 xginfW4VCH5Owm6sAM6apO6UzTzLCEY8IZFUVoRFyw552PC0r84/TZNMTZYAayiK1X2o
 Bl3/hAMesYOaloQl7KujrjZ3cQcKaD4tMAq7xzNlDvCwvAXKR/A8xI8NnO/HMJ0fwZgJ xQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w8djp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:56:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PK5452030694;
	Thu, 25 Jan 2024 20:56:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs375fgx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDwRLGrg8htN7M+YXno9WCXbv1Hr71q54ul4FjTcLAw1HqRXAKrQF7J/2+LGVWnj0ruDhMmYVBNMEpsIL9UBM0WM4Xo+2M1iutRaoVVNoLHGd8uSyW6LopN5Hb2O/gU3PFKu5xtulES9Z7g7PYP7mnG+DpR1qQAt3BnhGdbAoe4EsaBji9POuKLG1SF83nMEnPNw+gJob4ivsoLuCxwkqt5pJluH/ik4ncJgcXKrLT2ELiBNa3VVocYYUj0lf3ZnsROKHub4Q2OWtNTrdqgHON8/JRmpkQ+lwLHHYe8ZFKoHNh5tI7/J/a3R7imES+Pu4XYclQhvlwr+q6EoNzlx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOMjMNFBZ19KYwGuZD1XahkppQtiYjAEDrEshjW3aT8=;
 b=HnKpicUrkm5uLUd4f73L31n09iPCp0YTH7R2bymv9RbBsm8t9Vm713+DTeOGmg0utMgdEWzk+VyX0BLY+91sVQGlV0+HwqYB1tQdGeSt8uLj6wW4lhsbemBCr0Enyh1XnSgTnLFHGd3qfvPKFWiwbhA7waXtRMs2xe60phoqosh2Qyk5aOHRMh+vFrLUa+Y1k6SO1VAelCnjciCpawFnDka4/xnP0KpYp+TVM1YjDRijoGphEiNEHytBPmSN08tUT8UTdr/vcshH6oPUvciT5EIqP1cE7Z5pJTLQpYG/iw4rND1MiPLZ/4I/2CILnxq5rwazV09Md6CwVaMbss7x0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOMjMNFBZ19KYwGuZD1XahkppQtiYjAEDrEshjW3aT8=;
 b=ZjmlCX7OlCWGltOfmmV1J0FLWLBcqaYWNOR9hrf3ivIJp77u8dW0e3bX10XFKselLdjoO+chhur3m9kB4TPLWgaj35i+1gEyDdz+vWfdJoE4JOk6QvWnZuzz8z77gFFaaU9OBMxhpHpnErjWZwFKsb4JBR8+GO2wOl3N2ky163A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 20:56:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 20:56:03 +0000
Date: Thu, 25 Jan 2024 15:56:00 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 03/13] sunrpc: pass in the sv_stats struct through
 svc_create*
Message-ID: <ZbLK4BsvReiFpCUo@tissot.1015granger.net>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <ff6afd3ab9a70bf5ab90872497068719f2c1ec03.1706212208.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6afd3ab9a70bf5ab90872497068719f2c1ec03.1706212208.git.josef@toxicpanda.com>
X-ClientProxiedBy: CH5P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d55571-86f1-4c3f-8ed7-08dc1de80ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YrB5OeRux6leFLyRg61uQDJAeqPM6pKpLeadGBXhUAAgD2ZD34dZODbHhFpoqwBYoofNF93ZgA99RiTOHQjhNRIOVBshSfFV93uvEj2y7j9uA/KB0T00IrwNjho+55ZDuwqdSc3sQbwqFv6bP6iZ4Z2qjTqJCgCxXN+ls77XhCSKSPv6PDtjIYVe8h7y0taK66SK/m4LSG7iEXyHFMw3kn8cxaXpddnePrNix0CPWl75HDBYOi4uynJhjEyEhAGDVpXuLeob4IGX44+ndF3j6qqIjKMThdMigmWHcp7CwBEXHZCAASJJrvBvaPG4VuryePnapovZl92NDzFBvXzMtv2KMz+YKUE++iKev5/1TBJKznqk+KDduAJzpGFr2i63AlNbNDloesaMDC9mF3HwX1Azr9ub8wGTgkfluajPT2H8ldtcvoBZ5/Z1hDEIU7AgSCPtWTIl30E/6/bqX9x62EAfq9as1eqd28Dz5nI9GcY49H0QtDZ9Z5q7LMrX5XXCtvDSeRxcUbIbbYRQAoTCE4tYD/02wp0JWGz+iAEH5ezmtAz6wlB0U8TQJb1y8grxDyDAnFF4PJ0/d0z3I5feqyYVtBkXgXH/aHu/KWME11EbiQUIFpkUIqqIhtzb3M4i
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6486002)(38100700002)(2906002)(41300700001)(86362001)(6916009)(66556008)(66476007)(316002)(6506007)(66946007)(478600001)(9686003)(6512007)(5660300002)(4326008)(44832011)(8936002)(8676002)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LVR28/nzcPlLjnRUkxeL/SKlLcdF0qqKiiXUjeK3pkn5odKCGPkEIq4KRZv3?=
 =?us-ascii?Q?CfQuYL/v/NHK7/k5jsykGp/RXAlmx5wDMgUh9sio+Zy9wBxIGiBobAHybD4O?=
 =?us-ascii?Q?Vsp3BTApBK7uuqmov/yhV+VBgq3bSTdX/jCMAfF/AfMZR7DVbUYfZyW66wbD?=
 =?us-ascii?Q?q6CoFSWTeywjue9BxQs603agHbnvSX4IfT6pphNGXM1b79xG4qGlJm1BoM0g?=
 =?us-ascii?Q?tx79manGNIKBVGQazhkBCylQO1yo628vpK5Y/ZVMpJFroDtiVyD9x23eAov8?=
 =?us-ascii?Q?V2b1DVHrEnnz4wEs0ewzQpHu5Y7ZNZcPsAIXAyjqSIHpujr46x5BDDkBdZRf?=
 =?us-ascii?Q?XOVsvLqDdckROK4HkcOg8nJpJHq89LrSZRaCX5/kK4We9hw8e2dS0AKMlYbt?=
 =?us-ascii?Q?/K6aQCTX+Z8c4YJ0WMVfacAY/tOB/GO8I24V26hAB2JNdIXxzZrtiIxx+qCB?=
 =?us-ascii?Q?00IPveMsLT7oAC5KPZ1BbglcIxCUxqvDvFjGg4ckKDPAhrznV0maLCcJ5rVJ?=
 =?us-ascii?Q?zv68ZLu/cvfzusQl2fDgqVJVoLpLpbrI4WQFjt5x6ZUxmYvt0ILNcEVpovB4?=
 =?us-ascii?Q?Eacs4hLxHbS3OEAgwQUw0O5cXakRtAZ7rHSLMVI5stp5C/dQjhgB51SYRMtq?=
 =?us-ascii?Q?D22/QSs2a0OkLgglrB1spQGznbMbwN8HEkmFTYOlm/b1FtKmy4DHSR23NrPM?=
 =?us-ascii?Q?nQE94JHEmYp0idlGv+EfsCMw9ZaX4tTDpBHcg7Xmc5eP/yzQmEsBFPwxLaa1?=
 =?us-ascii?Q?wELQTQiLD6ZmBa46GY8ehbpUgpKsQR863s3YcAF2WY4MbpLQAAFOy1ewm8a6?=
 =?us-ascii?Q?cKJeAZKTeUuMEaleBEkc5sJJEAYQVlP1PKCe6osOWRoy2Cz537XKXg5gbxjS?=
 =?us-ascii?Q?6y8vdlxaCTahckDpMGueFkuVbfyc6htyFedj0u5yucqIcZCPJQAdTg25ZTsF?=
 =?us-ascii?Q?J62MNm/sClm9Y0vr6yD/HzSMNyPtg+T5Xnw/4p+zFFzUx5I6spUBq4JddsFB?=
 =?us-ascii?Q?7T0K9+6EvXSiQe2dLRixYPvt4FNgnOZ4jUcWKXPdzbf0t4ArYBi8N6AdPW4j?=
 =?us-ascii?Q?JyYhzryAZjW4M6tOl3OHqvXbIANkZjH5nNR9zeaDBA8TpDM/LOeKWstzwA0E?=
 =?us-ascii?Q?4Vd1M1RYhwRz9JFZUPtzdCxPvqifNozhlPacJXCS41hwrb3dwepkvN2FGo+4?=
 =?us-ascii?Q?7/BuA8SbvGjKZWfjBmFnd7Jt7wPcTSoBjzE7gm99rsNlp9vw9fBgnn6ZmmzU?=
 =?us-ascii?Q?TjKmYc5JpHGVvEV812lE/SWjXoDFpbYlQo2CvSXdDi6rvg9xjkf13AGQ5tBG?=
 =?us-ascii?Q?TpdJEgH31+tJ5BA5tueh0Zu/3OOUCucYYJsq/D11A0JuCDF2GEfU0UWM/new?=
 =?us-ascii?Q?aIkLNLNrkN+cwYXd2pS6/Wj2oKBeU0X/Knpl34Xk0Ni2W+bBTvX4yd0hQLIz?=
 =?us-ascii?Q?uLhPZG263UjVrWd2QWOBPNt7+7Gkx9zKEqnfqpKuNZ0qFopVgPMnKCqvFfHA?=
 =?us-ascii?Q?BLAOqPNYa0ByN3cXM9VGYI8WO/5O/ngdfwUEUHxHxcMpD0IEB60O5ET9EEpr?=
 =?us-ascii?Q?L94XWyxMPwJx9AK8F84SgGEK7+rl/auJwLd04Fvyv3dGypCAf/fqgchHC+UQ?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0ZPsSJKRrQ7ptqxVBGHWCOZcyV5GG8J2+RjuLdqvfWVyHGtWVFaM3d/cexFu8kYbSiSRxgNh9Xova3o6L0/IDZ6beqg+wlK2/YDdweZxtmrSoBmtb66mCh1ZsI9mi12UkaeGc0FxGJqEQoDY03UxkZg8033yF0JXEB+rB8W3tXa7dl0pbxkxRGWXwEuNSv4oQiRtdM/a/9EwDyskPxLkJq4NGzTUnds/CrF2EORJ3DByFjIDcnSwXJz7PchsTcElV+G+JzJB+ypQJg3Ll5OZulSr02X/ZJFuLX7PrbP3O7nGskqXXKWjpvAP1JXHPOYJHGC04AqpLcPalfJBwJoJcbukmqtUUlscm1kWrWfMoSJqyo13KeR/XZApyY0zk86lRYdFoi4iTrk4YV8NrJ/by63PAfc6/l1pyvd6nBn31CqIaxHoul1M5HyqHlOD6aCYcvInkaxItqOBasxue2o4l2/0pKUTAVjIZMt3cRvs/4AtJv1fjOEk0Db3lLONmYs3tBITwZOoy+u3tGPVF93CEjeMI+fwHqVdmzZUZpX66ohk5IUH4jps2JvOWxWXNJOwL9jwmTiQPgbL/5VSj4nPu98YZX57TbSmBw5yNfacjSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d55571-86f1-4c3f-8ed7-08dc1de80ab0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 20:56:03.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goisURuiysMAKMZE7VrjR0RxA8lERgXNqQLW8ruN9Zio8BYHg2W+wmv7JU0oA6DbfZoaiLHCVe4Oekd//ZzFUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250151
X-Proofpoint-GUID: dx7Eg0xv8DDSUc23gfYbkLk7PnifyOh9
X-Proofpoint-ORIG-GUID: dx7Eg0xv8DDSUc23gfYbkLk7PnifyOh9

On Thu, Jan 25, 2024 at 02:53:13PM -0500, Josef Bacik wrote:
> Since only one service actually reports the rpc stats there's not much
> of a reason to have a pointer to it in the svc_program struct.  Adjust
> the svc_create* functions to take the sv_stats as an argument and pass
> the struct through there as desired instead of getting it from the
> svc_program->pg_stats.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/lockd/svc.c             |  2 +-
>  fs/nfs/callback.c          |  2 +-
>  fs/nfsd/nfssvc.c           |  3 ++-
>  include/linux/sunrpc/svc.h |  8 ++++----
>  net/sunrpc/svc.c           | 17 ++++++++++-------
>  5 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index ab8042a5b895..8fbbfc9aad69 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -337,7 +337,7 @@ static int lockd_get(void)
>  		nlm_timeout = LOCKD_DFLT_TIMEO;
>  	nlmsvc_timeout = nlm_timeout * HZ;
>  
> -	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, lockd);
> +	serv = svc_create(&nlmsvc_program, NULL, LOCKD_BUFSIZE, lockd);
>  	if (!serv) {
>  		printk(KERN_WARNING "lockd_up: create service failed\n");
>  		return -ENOMEM;
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 8adfcd4c8c1a..4d56b4e73525 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -202,7 +202,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
>  	if (minorversion)
>  		return ERR_PTR(-ENOTSUPP);
>  #endif
> -	serv = svc_create(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE,
> +	serv = svc_create(&nfs4_callback_program, NULL, NFS4_CALLBACK_BUFSIZE,
>  			  threadfn);
>  	if (!serv) {
>  		printk(KERN_ERR "nfs_callback_create_svc: create service failed\n");
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index a0b117107e86..d640f893021a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -661,7 +661,8 @@ int nfsd_create_serv(struct net *net)
>  	if (nfsd_max_blksize == 0)
>  		nfsd_max_blksize = nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> -	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize, nfsd);
> +	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
> +				 nfsd_max_blksize, nfsd);
>  	if (serv == NULL)
>  		return -ENOMEM;
>  
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 67cf1c9efd80..2a1447fa5ef2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -402,8 +402,8 @@ struct svc_procedure {
>  int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
>  void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
>  int svc_bind(struct svc_serv *serv, struct net *net);
> -struct svc_serv *svc_create(struct svc_program *, unsigned int,
> -			    int (*threadfn)(void *data));
> +struct svc_serv *svc_create(struct svc_program *, struct svc_stat *,
> +			    unsigned int, int (*threadfn)(void *data));
>  struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
>  					struct svc_pool *pool, int node);
>  bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> @@ -411,8 +411,8 @@ bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
>  void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
>  void		   svc_rqst_free(struct svc_rqst *);
>  void		   svc_exit_thread(struct svc_rqst *);
> -struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
> -				     int (*threadfn)(void *data));
> +struct svc_serv *  svc_create_pooled(struct svc_program *, struct svc_stat *,
> +				     unsigned int, int (*threadfn)(void *data));
>  int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
>  int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
>  void		   svc_process(struct svc_rqst *rqstp);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index d2e6f3d59218..f76ef8a3dd43 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -451,8 +451,8 @@ __svc_init_bc(struct svc_serv *serv)
>   * Create an RPC service
>   */
>  static struct svc_serv *
> -__svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> -	     int (*threadfn)(void *data))
> +__svc_create(struct svc_program *prog, struct svc_stat *stats,
> +	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
>  {
>  	struct svc_serv	*serv;
>  	unsigned int vers;
> @@ -463,7 +463,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
>  		return NULL;
>  	serv->sv_name      = prog->pg_name;
>  	serv->sv_program   = prog;
> -	serv->sv_stats     = prog->pg_stats;
> +	serv->sv_stats     = stats;
>  	if (bufsize > RPCSVC_MAXPAYLOAD)
>  		bufsize = RPCSVC_MAXPAYLOAD;
>  	serv->sv_max_payload = bufsize? bufsize : 4096;
> @@ -521,34 +521,37 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
>  /**
>   * svc_create - Create an RPC service
>   * @prog: the RPC program the new service will handle
> + * @stats: the stats struct if desired
>   * @bufsize: maximum message size for @prog
>   * @threadfn: a function to service RPC requests for @prog
>   *
>   * Returns an instantiated struct svc_serv object or NULL.
>   */

Here's the only minor quibble I have so far:

svc_create's callers don't use stats, so maybe you don't need
to add an @stats argument for this API.

Fwiw, I haven't gotten all the way to the end of the series yet.


> -struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
> -			    int (*threadfn)(void *data))
> +struct svc_serv *svc_create(struct svc_program *prog, struct svc_stat *stats,
> +			    unsigned int bufsize, int (*threadfn)(void *data))
>  {
> -	return __svc_create(prog, bufsize, 1, threadfn);
> +	return __svc_create(prog, stats, bufsize, 1, threadfn);
>  }
>  EXPORT_SYMBOL_GPL(svc_create);
>  
>  /**
>   * svc_create_pooled - Create an RPC service with pooled threads
>   * @prog: the RPC program the new service will handle
> + * @stats: the stats struct if desired
>   * @bufsize: maximum message size for @prog
>   * @threadfn: a function to service RPC requests for @prog
>   *
>   * Returns an instantiated struct svc_serv object or NULL.
>   */
>  struct svc_serv *svc_create_pooled(struct svc_program *prog,
> +				   struct svc_stat *stats,
>  				   unsigned int bufsize,
>  				   int (*threadfn)(void *data))
>  {
>  	struct svc_serv *serv;
>  	unsigned int npools = svc_pool_map_get();
>  
> -	serv = __svc_create(prog, bufsize, npools, threadfn);
> +	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
>  	if (!serv)
>  		goto out_err;
>  	return serv;
> -- 
> 2.43.0
> 
> 

-- 
Chuck Lever

