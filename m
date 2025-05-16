Return-Path: <linux-nfs+bounces-11770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E668AB9BA4
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6A3B0A9C
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF88235069;
	Fri, 16 May 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bw3W2eE9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lBFpA9hV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08611361
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747397407; cv=fail; b=a3m1wpEk3VQ+hBgYqpWtOHonImXIow8r3Xp0DRxzRS65uhLG1GwVIAfICMaUddIYZnPw3QjQ+SRQ+IMLY0lApvl8/nfZyh5k1HbfT8DC8emoxHv6TrX/cV+rGWZuMguNwtZ4sjUDXN/1dxO62daOSP3DiYcCMb0m6BVZ5GaXHa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747397407; c=relaxed/simple;
	bh=/MsF0WsbnFV6yuXyXs9ajTkJuZxw0Z+jP2ZQN6CVZX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ql/0ivPUlukV6UX61c4obgA4iCK8KZJwyozhdhDh5FUtcJNo1mKgHn1Od7nGWdXZH9wxRfLxPYdi3oHCVzI21ckGDv35Pw54IEolmHrX3GYVrxywaNOHPeV5diyWREWge/D/czDAN3plm86nCLd9TUuhzAeTXN6jhYfqYMrydFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bw3W2eE9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lBFpA9hV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GAfsrI006759;
	Fri, 16 May 2025 12:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mPu28jlFPQk1LqRhpokpm0KklSi096ICpKWybzgyNSY=; b=
	bw3W2eE9I3fgyFhiVe8dDbd1Qw0MOGHNv2InjDiTLZAYV3cA5VvqDWNC4w0FFVQr
	9BiE7wCyqZ5EDfwcxmWzulGWTW7zRKONLtMtRiioHG8XhPr8hWJmO3ThuSIFpovY
	nLyJ+Ayo/OiDAMQyhVm8NpLihLY6ZyOE3/DIr/CPCB8iz1F31hIwCJz7PNG8FwBq
	XuVlIdCuBAUaSmo9HbIuwx8KH6Di94FrXjQ+flnke040DYdd4HxPWXCi/gmwQe/9
	tavYrPcHcg7Ndmw3D6apL23xWqRnuPGCONcLjOdZSSZBBAOdA8c5NrfVzjo5hPQZ
	zwU0SlYjTu8J3EAaWV9S+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbj17j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 12:09:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GAZaLJ016915;
	Fri, 16 May 2025 12:09:57 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc36109a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 12:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btkQ7xto4xzoaeY9uYVLXO+bqtaiHpZa93EutfHXWOcBU9ga9cimIe1WfqzzCVJjY4tMVpcI7Kt6F2JgHrnOJl85QlTwuw6HuGMrtRFQfpZrJOpl1OApyzzS1qt7mhQvTsCUzgvHLx1FWFm8xGDPldGpMqFoAW2LgHd0CbtrhPhz9H5ZSZf5dupBDPgPXD9qPdukavunqpTBlEOnRbsFWNj3fn/J7CsERXLapK5Y6MspMh6BQ4mWolBl2pYbGi92nzbEFMcyfvNU4Hp9EtHeVxhpcvWPvDAWnAzmBkSoqChKw0ys1qKXSvCZpsNooFvnP05U5PwgjcG1VeTs5zz/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPu28jlFPQk1LqRhpokpm0KklSi096ICpKWybzgyNSY=;
 b=Dv8olmTRMblu/pWw9e3pq+kHNb7qjIrmx46t3XNVjXYCQMvYvVDSZ7VE4SfAUbjZc7bB8gv1z46nMRbqqpyfqoMwgFMVJhUxZfSoRrEPRK2QINi2hdxXJ+2NMLcfQhUI9EQ+ifYRmQ3Ihn15swtb5eUTTtdwZ66NwRaxz+nNxbUlSkYASpNx4FI6qA3yVtU2/L/2SljATBwoWvYSD32M+J3lR6/RFrAz29fMO7Ll7XOowiBbz/iLUcODlrcE8QmnKVYfAp01dYCK0SZOHJhsMuLURvaPJoYUy3W8zz+lk7XMIqnfOvtneYpJbHTEOA3G5JTewVQgmJ3mw5dwZUxjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPu28jlFPQk1LqRhpokpm0KklSi096ICpKWybzgyNSY=;
 b=lBFpA9hVXgbVrkSROduTYxVJQOr92BF+FO67/31OOFkN/Wn+78nG42eIvgIZQbHJ1+28ePbTACHKpomuGffxlcGOwwg9KApCOqkDAtxOhGJ9vnhG1Nltd0ra6KYK1Osp64SGAruCHPhWbDy2gsB4FwczSKu755oSoyTiXKxEh64=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8202.namprd10.prod.outlook.com (2603:10b6:408:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 12:09:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 12:09:49 +0000
Message-ID: <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
Date: Fri, 16 May 2025 08:09:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
References: <> <500d0c27-c332-41b3-803d-488b8f5ca92c@oracle.com>
 <174734547202.62796.2038898324999110968@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174734547202.62796.2038898324999110968@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:610:11a::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: f2de9648-fee5-465e-e7a8-08dd94728e40
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RmF3bGM1MzViVUdMdis2VCs2Rkt1T2xPOHlVS2hLaks0M2JyZmtRYlRxVUNS?=
 =?utf-8?B?OWpmcWtjbE5xQnkrTEZyZWJPbGwyMzBrQXBjaWxTV1MraXRJV21NR3lFRk1L?=
 =?utf-8?B?YkZubWdiVjc2Yzg4bENOd0tkM0RCcnBSY3R2NitGZmViRUo3RjduM2tzNGQw?=
 =?utf-8?B?Mm0zUEhHZERZYzU4OUNEZm9HRDIzSzNqYm5jdG1WajQ1elJDWER2UU5nWHZS?=
 =?utf-8?B?ZUl4RWY3STYzc0FhYi9FMm5CY3YxV2ZtWUpqUVdGdlJOZnB0WmI5alo1OFdn?=
 =?utf-8?B?RXpRTGJUd3BzaWVoaG5pYnIwK2xFWHFwTHJlRGJ0a2ZkSlhwK1hMckh4RVdZ?=
 =?utf-8?B?S0F5Y3MrWTk5REVoT0h2KytSeXljYmhaU1RLOTdUNmNxRVVzQXRlOHBET3hY?=
 =?utf-8?B?TzY2OW83Q3NJakRLMVZEY1dqSEIveFJZVXNqSDRQaGlmZlpDZGdic3YyMlFE?=
 =?utf-8?B?SjJZd05udmdPQk5iMjBON2U5bUk1UWh3SllDbkJSTHdxRFFaM1V6d1IrUVNL?=
 =?utf-8?B?YkNTUWR1K0ZkeEhqbXl5STYxSElHMnA3R3VmRkk1MSsyOURFdmx3N3FPeU1y?=
 =?utf-8?B?RXZ0WXhFR1plaGg5VFpQeVhRbUNuU252MXR4OVZKWkFwK2oyRWMyd1pnYzBF?=
 =?utf-8?B?R25ncjZDN2Z4VWU5SitBaFhZM1RlazV3Q2hJRG11bzhBS2o3dEF2bXBodUtF?=
 =?utf-8?B?Tll1Z3NlZDlibmhRWGczUnFuczhQSUR6VXZ3bks2Y2dGbisrOHp5ZWluZ3Ux?=
 =?utf-8?B?ajQvS3lSNGd4N05BNFVRdHBKRGRqSWloTk5GT0kzd29QT1p2WnVab01kV3F2?=
 =?utf-8?B?MXpieE1URzVLSGFNTWJMdG9xbFQvTjRRdW04SVBjSmxtOXNzdjBUSHRHcmpa?=
 =?utf-8?B?bFZCN2QrTHJUdzFEeDRMMmNsQ0JXOUpiampGSngyUUtIRjlwNFZCeW1RRE5M?=
 =?utf-8?B?RzFRZDJXME9ZQkZJRWJ4UEtveDFBVCt0WkI4a2JCUFFETVZjZGNpODhwcE04?=
 =?utf-8?B?SmZaWDJQd1Y0QWYvRFl2akp2UGVJYjluNFhrNHUyUk1xRzBVQk5WM1hkdEg3?=
 =?utf-8?B?cGdoMEFvZERLOUJzeDg3ZHhlQlE0Sk1zOHhxa0hhUEZNako5Q3ltYnVnVzc2?=
 =?utf-8?B?RzdMcmo0L2tQencydmxlVUpqa2RTMWF6NmNvSzkzdCtHZCtJckJQdlJhT2hn?=
 =?utf-8?B?eUZVMitwbXpDRHYxV0VIVk9MMVA3VEtjWm4yRmRQSEpnK245U2ZyM0d0VDEv?=
 =?utf-8?B?UmduVjJ5U3V0T2FreGRidjVxMGl1UmFJU2lQeUF0UVd6MlJGOHNzL0hpbUtz?=
 =?utf-8?B?eFQrVUtQSkxOSnl0azNJSHphRGNLajQxbjV4bFBJUW1VRDI5dnlnWDR0elVM?=
 =?utf-8?B?ZlEyYzF0TndhSXhPWlFUckpjWTdYaXM2NDNNVmtHeE1HeFNNU1NkalgxMFdQ?=
 =?utf-8?B?TkVyWUoxTnhLdlJ0NnNZZ0ovcjVJL3J6Tk42V1JLK2djYTBZS3FlbDRCMTZZ?=
 =?utf-8?B?cktWeG00WDVBRHdzZldncGFNZy8vYUZRT0dPNWFNSThIbGFjeFlNTmZYekpH?=
 =?utf-8?B?QUpNLzJzUG5vYmo3WWx2WEJGZmZITTlQa2JYVmp4S1VZWFFuVnZQMWRXNUhs?=
 =?utf-8?B?bUh5dmdNQlc2Ym14TjUya0JVVVNWdkJXZUprTlVBQ2NwODZDTUdabGZ4QXow?=
 =?utf-8?B?Q3hYb3N5OHRhVURiOFFxQkdFS1MrZnk3UGxNVHMwRjByWnpYa0dTUTVLcUhy?=
 =?utf-8?B?VnRVQldVdjFHS2M4Tk9WUzlSMnBaS0wyeGJkLzU2OVNsVnIwZlp5QTgrWFYz?=
 =?utf-8?B?R0QxUUxYbWZJd1FKTzlIMDlGellxcmI3eHZ4SHlpMTJpbkY5a2lWNXAxK1J5?=
 =?utf-8?B?YWN1Z0JSUVhpV2diVDZnR3RTMHhrci90RFZiL3dWclVyRDJxeWRUZWxKREJ2?=
 =?utf-8?Q?Sm9vgKw2za8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q3JCRThaWjNDai9XcWtEZGlTc003MEtTd0tINHRtendRUFA1RUszTXNKU01R?=
 =?utf-8?B?ZWNBZFNiNUNqS2x3dzlyVDUyVWVHbzZRQmZNU2wvRWFna3FIWGZSWUQ5MDI5?=
 =?utf-8?B?eFFCbUM3QmRQdTRaZjdMWFFOUGt4OVdDM3NHWjYzbVF2blhQM2FRN1JHZStS?=
 =?utf-8?B?aEZkMlNBbi9FYmZRUUtKVU9ieFhFanhsRjVrdXUzb09SWDdFYU5JSGJYSkYv?=
 =?utf-8?B?S0FvcmlJWUc0ekFOdkQ3Qk9NMTFudWpwVkxXTVN6azVDSzIvUGl4a2FRNXEw?=
 =?utf-8?B?QWpZZURWK2xGTG1VeVpiS0pSWXJLRkx2R2lOeWdOSFRhK3hTMWZtK0hHcDUr?=
 =?utf-8?B?Rk5TR0liMGh5eTdSSzRFT0piNDhUajlBTUU3aFVTamF1d2xzRUhsS1JuQTNY?=
 =?utf-8?B?M2UxaUhDVlJudnR0aEJ5eXYxWXJUeWlpa1BXeFNlUUxGSFZmWkxTOEFESlZN?=
 =?utf-8?B?NFF0amZKSk9qS2diM05EN1lWNHhmRHVNWksxRDQwb2k0REh6bDR2eVNLRllZ?=
 =?utf-8?B?OUUrUDB1eWFBVlNJM0VnVnhJdnZVekxkbkZ6RmdMOERrYzE4YUhTZ0NpUGhS?=
 =?utf-8?B?NTE4MmNYSHMvM0VDdEtJSEFJUjRKM1d6US9MV3FicGRaUVYvSUZpL05LVko5?=
 =?utf-8?B?NTZhclhwa0MrUDdtRlJHZHNMcTlsaE9WQWFZOXl6b2xLSWVpLy93MjY3VTd2?=
 =?utf-8?B?VUM3WjUwWnZBZ2NiZDBYT0FuTHZDSTE1VjNrcWRCVXBDa2RtV0wvRkM4ck9U?=
 =?utf-8?B?cHR3Z3NqK2dzZVB5ckFlWTk4WkZyWHFNS3VDN2FoSDZnMStXWEJFbS9hdG5K?=
 =?utf-8?B?Y2FwSTY5bXRGRFdWUm9qMVF2ZXNhWmorU2VSTVpTdFZjekxRTXM3cE1nUlFS?=
 =?utf-8?B?dkhQeVYyNkxzUmVpY01WQ3FIclVQb28rL3VMUVFGR0U3VEs0SkRnTVlUb1dN?=
 =?utf-8?B?WFJFL09lNHQxM1VSb2ZTd0FWcXhHUkhuOE5naDBUMEpnWWN4YU54Wm5Sem1U?=
 =?utf-8?B?K3Zmd0xkK2lreXRHcjJ5NGhFNWJ6Rk5ucXBVOU13VXhDbGFZVnFZaGphSzEx?=
 =?utf-8?B?VEgvcmlrQ3RJVW9qMDlEZFRmNTZPdXJ6ZzIvRzNpYkRKalBlbm9yQXhqalFH?=
 =?utf-8?B?aG1GNnlGMEFtdzhwMmxESEovQzVkYS9FTGxkcEVkNldUYTZmUlVBVGplaWM2?=
 =?utf-8?B?RWhDWFAxditJZEIrZHJySjMwRUVVcy9jcmNlMEFJbUVpc25yaEhxdVZCaXhh?=
 =?utf-8?B?a0RYNURTQXJJOS9qakZjZ3JhZW5uSzNDL0dGWlJXbjVmRlUxU2JhdXRhUGg1?=
 =?utf-8?B?eGRiMTh2OWVhZG5VcnU5TkJqd3M2NWhVeFhVNW5hUDZsT3ZJM1hqWTc3bXZO?=
 =?utf-8?B?c2Vvck1TQUE5QmRzS3I2czlsQkVnMXcwZmc5R05jajhqR2tqc0ptYlVJYUsy?=
 =?utf-8?B?aWZXOU1sRjRlRThCN09YQW9RRktGVDMydGhUU3lLYVJwbSticlFCZTVaZ0Fq?=
 =?utf-8?B?Nnk5bC9uUlg1ZjRkZm9ONHkwKytwWHdXZEZiZmwwSXJ5NnJ4cVc5N0xUVEh1?=
 =?utf-8?B?eFN4VzVqendBZWtlSEdhanJRTWJpcXlQU2ttTTJvMzIydGFSQ3QyMlJUL1Bs?=
 =?utf-8?B?Z1JxWDNUTlg2Tm9jbGVOYkx4dHRCUjBUTmZteFlyaVFOQ1RQeSs0M29pNkxG?=
 =?utf-8?B?VGF5STFOa0k1bUhFQkpJUDhEY3ZHYmlJK1RnT203TlpwOEdhWlR3QUJ4NnJw?=
 =?utf-8?B?T3YvN2lpK09EcEt3eXBTa2hVcjhaQ0xjMjJHR1FweXBoNXlFb0htQ2pBZkpT?=
 =?utf-8?B?c1JlMWlJa3F4T1krc2JQd203bXFJNkYxUlJMdGVNTnZYbkRmUW1QS0ZGUm84?=
 =?utf-8?B?eEczaDJHUW5jQzNKamdhRit1d0prdVNTTlNUT1V4aml0OTZJUldRcEsyeEEv?=
 =?utf-8?B?NUcvMkdGM0w4YXlocDBjU0tWYWZ1cnBBU1MwR1JCY3VlTWl4OEk4OUtZZEZM?=
 =?utf-8?B?YWJzVWtNZHVUOG1KUEU3cktSUk03eXdwRFg4Nkp3ZHJJUGZjZWlGYUluOVlk?=
 =?utf-8?B?M1hZZko4OGVqQy94UHo5RFNkWHlOTjk1ckNZeUNOSHRNcklxVEZ5c0ptM1hH?=
 =?utf-8?B?M1AxaGYrbjIxdnlnejJ4QUFMNUR6aUNXWVk2SlBiVXdIanY0ZmZVYmpxUHgr?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WkcGIJY1Q7TgSgcpmEKnH/uAtJi/AslKwfIfi9pFrS60ZnvXMwYGFnwB7gHnjE+jC7TbdiFuZPpNyQyGCsXcm3J6GjyUfCYNfeN+aXIY+7o2NDcCBZ/wmjcyAhLG7VR59oiZhnMe1E/f8MWolXr9wrRGAdn3xcPGxBoNGvQ040bVSWYrMw6fJADHaczxrG4vm9THhIxuFMa1MI8dS0FjT9J4ErmEIk3Y8Jymzvbk3It85FrFRBAWJn/t+2PzM09tL9hsxElyTBibvU13DGlL6PXkVxuxUToBChd6ELBmnQ+8eglGMcqK3C/Rx69XrDeGzGUsbn1UNpSrKiTraOy8AFBZm6aY/OMVlHFgnwJYwRbCHXNjfYZ5KCr4boJezLl+wgema3VbBAy7ZpgNAcYA+jo4tZ3okt37ocz12YVhJqKrRVtWCLci4LCmIB303Wy+JcdN1MbmOOprjcKsyYBPxMN7e/QqfQGO4zIaOmjGcs1VDDdCMuFRQGgfRXRBDJ5WugWQh4VfeZIUu0mm16J5Qj5p01iPbdVRXF/qs5SwbxIKX7wpn60NhJCQ6RJPX8IgC8spPNFkMRfLvTGiQu8PXM01yh4kn0Qj+XmHrocnsyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2de9648-fee5-465e-e7a8-08dd94728e40
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 12:09:49.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv6WIC3yqX3Pvhdm/RhKqTtPvLph24E3hcZvp022QQtuPgycNN1l+qSBz8syptZXASKKBqbKRey2tQGjfS2YkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=782 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDExNiBTYWx0ZWRfXyFSMWixklFkM SrNDq7QNS4Yca4Qs+zVDrKZZjKBEOkzuHS5dgWni5perkVdL3t0qwQOguMcAxe5m5/quQIT6UKH 3GcDKnahso2paDn1dlTjLTx3KajPQu6E8Ae+oKW9zyiYZTFTq1s43YoFcRgfEVwRET8+9ZsoNc9
 rnuBQ2w1pfu6HzrXnaR3TA4qEzoWGEsrJkrj9L2AxubHDp8XdlEunZQBfDY8t9UCR/SwmAAVl6b kz4FwoV6w623nl7dc4ZuVMQHnXV1OYStGyugmFW/cFJlJ9qZPhyRlB0XM8PVorbEO3E/lWLLhih jW7GKhOfDvuEbG5Ir0I8UY84uwwfqmv82xiVu8K79hb0H6oyaGfdLEsThw83z7q4QZ1BTbRFUMY
 xXVc9P7G7WDebilWbz3DJq8ki+W/gIyAfXaiOv6h+DkDbmrAztay5lUGuwnADGsXSy7gIbPy
X-Proofpoint-GUID: UCN1DcYswHOMKaSg2iiSa1N_tmgXrTQ8
X-Proofpoint-ORIG-GUID: UCN1DcYswHOMKaSg2iiSa1N_tmgXrTQ8
X-Authority-Analysis: v=2.4 cv=YqwPR5YX c=1 sm=1 tr=0 ts=68272b17 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=w_1NNe2I1gBITwvTQm4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

On 5/15/25 5:44 PM, NeilBrown wrote:
> On Thu, 15 May 2025, Chuck Lever wrote:
>> On 5/14/25 5:47 PM, NeilBrown wrote:
>>> On Wed, 14 May 2025, Chuck Lever wrote:
>>>>
>>>> Sure, but this option, although it's name is "secure", offers very
>>>> little real security. So we are actively promoting a mythological level
>>>> of security here, and that is a Bad Thing (tm).
>>>
>>> "very little" is not zero.  "mythological" is unfair.  There is real
>>> security is certain specific situations.
>>
>> We can argue about "mythological", but it is totally fair to say that
>> calling this mechanism "secure", and its inverse "insecure" is an
>> overreach and a gross misrepresentation. It is relevant only for
>> AUTH_UNIX and only then when there are other active forms of security
>> in place.
>>
>> So I think our fundamental point is that the balance has changed. These
>> days, in most situations, source port checking is not relevant and is
>> actively inconvenient for many common usage scenarios.
>>
>> Before changing the default behavior of NFSD, we can survey other common
>> network storage protocol implementations (iSCSI, NVMe, SMB) to see if
>> those protocols also use this form of authorizing access.
> 
> I don't think it is relevant what other protocols do.  If we were adding
> a new feature, then examining the state of the art would make sense, but
> that is not what is happening here.
> 
> It might make sense to remove AUTH_SYS support in the same way that
> rlogin and rsh have effectively been removed and replaced by ssh.

The point of TLS is to protect the use of AUTH_SYS, because as Martin
points out, Kerberos is challenging to deploy. I don't believe support
for AUTH_SYS is something we can get rid of, and the nfsv4 WG has
recognized this reality with the publication of RFC 9289.

With TLS, not only is the use of cleartext user identity encrypted, but
when mtls is in use, we have client peer authentication, which serves
the same purpose as source port checking, but does so with
cryptography.


> It
> would never have made sense to change rlogind to stop checking the
> source port of the TCP connection (and would never have made sense for
> sshd to check it).
> 
> I cannot ever see any justification for changing defaults to make a
> service less secure.

I do not disagree at all with that general philosophy.

I think where you and I disagree is in how much actual security that
source port checking actually confers.


>> In the meantime, do you object to moving forward with the other two
>> suggestions I made:
>>
>>  - Updating the description of the "secure" export option in exports(5)
>>
>>  - Adding a warning to exportfs when an export has neither "secure" or
>>    "insecure" set and allows access via sec=sys ?
> 
> Those two sound like very sensible changes.

Fair enough. We'll focus on improving the man page text for now.


-- 
Chuck Lever

