Return-Path: <linux-nfs+bounces-2129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39B86D81D
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 01:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B63AB21546
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B620365;
	Fri,  1 Mar 2024 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="DBhm9j3Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SA9PR09CU002.outbound.protection.outlook.com (mail-southcentralusazon11022010.outbound.protection.outlook.com [40.93.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38C17E
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251441; cv=fail; b=PxcHj05DLFR9fPzgjdGP8aZui7l5o0z1b8J6H9mFxrCc8xkT0sp8LSWOnmJSRgf8fidd7JjcmHcgl7lkTX6XbH9t0413tepIBBXvImSFQ6+rycc3wz/nE4nB66gwuifw3le+YlQsTsISMWt/NWWd1EFQZF1Mkwfg4has4sTr6Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251441; c=relaxed/simple;
	bh=7LgHxwSk/Cg95+pTLaTNV+I+/u5IwZe4HzVzSHuNlBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/1IVLPmG7KOaWLnBVGYhPv64ssO9IfU/sMcha9zhAMxRUTyvGAFR6GwCR3YQErlEQjBybmUmBbrQ4eXxfOzCSeO1psqmjMms7gOIkdwAamS6cslccCUqTUXc5DjfGP2PbFT1KonxxbQDleG85RDePX3w61Zyi1k22iSvUOHk8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=DBhm9j3Z; arc=fail smtp.client-ip=40.93.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHtNzwXj906urDI9fmX8m7LkPEePVG0gFzP+IL08RiW8diRQkjSaxZhsoWFZASCuzX+yeTvDpStwruUedEeXDnLLnPMCtwsvnYpxU1umFXo2FTyqwpxb/ko64RbUjzIv6VS9X7CC+diS+SGT3QZODS1jExCwU3fhFZed24r28cPNoWunHazLKKoIMxgPfvBqvQZDRV+dueLUrzq//pNTZFZVITPK82Xw10SKd8/9MtaMyxo4ZTnHPxHSiYguUNle+rxBjYXI44/wd6RCZg3/YV02pfu8leTdLkE3ysf4JgPORIzey0B/2v4OPAX2KnDuKmEoHLoJuDB0AQI7xoWSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t04VybzxBJvluZKC3Ikp4m6Hy/xqgod6+t0b6F7ILXo=;
 b=QezWlaK+J0TFv6U4N1Efgl5mKbI2CehoyGhqfL6V9mFYwjujAP/wLLtEoqgSEaerbqrjnoBVLUe+EHq9gUTGPa2/PLGGwhG7re07mRHzLscDWUin77OSABForiinU/723s4ddKXAQPV7NXpGRtwTMDmecxaTvJmJpNosgQAXQtbi7Pxy4xJ4/UexdRMg+Kp9lwb33/oQ34IUaI8WOmE9YhILXKzokXxrRKpnX46FIMxcjwWal3lyMQUT/O4gt6m2vApTmL7Ng0hJo/SISgwD4KTe3bs8U4+Z6HHYqj6kgVr1rnXoZyVeJ1INfq4l0heMmP/NhEG+sbhELZz42hrt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t04VybzxBJvluZKC3Ikp4m6Hy/xqgod6+t0b6F7ILXo=;
 b=DBhm9j3Zo5E0+fq2s/7Df1nlzMyphnUHbMFZVt4UNwh3kaTMtksPz6qSzmA3rxMcB1+Uy2Cs4G+Ypzd26C5ybeLo+sRdQOe8U/0n15STSSxZmjxwc+wTclNSWlKjakZwGKbg5jDTzg8gzJX/hBxI1DZ8STFehO2Ze2247Q4e+ZdAiUV9ENCU/SjXBKWXTBmSwJQrEL6h0OlhyGS0CnVRzZoyJg3A0vZUjE1k2zbDMyM82WNiHypvm3fXsMHT2BrsqCDw6vZPeg1W9WoJ1nwOj784J9VEQR4bjf9zndA55HkPZ8E4jE+jDH3mD/7ZLwGL1+0SFpg7vmoOEEcnGc+DIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from MW4PR09MB9632.namprd09.prod.outlook.com (2603:10b6:303:1f8::17)
 by PH8PR09MB10111.namprd09.prod.outlook.com (2603:10b6:510:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 00:03:55 +0000
Received: from MW4PR09MB9632.namprd09.prod.outlook.com
 ([fe80::8d34:e911:1a99:5242]) by MW4PR09MB9632.namprd09.prod.outlook.com
 ([fe80::8d34:e911:1a99:5242%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 00:03:55 +0000
Message-ID: <1d554aea-326e-458c-a394-9d4458bdc0e0@nwra.com>
Date: Thu, 29 Feb 2024 17:03:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Cannot initiate mount with sec=krb5 as root from EL9 clients
Content-Language: en-US
To: Scott Mayhew <smayhew@redhat.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <8b16410b-6b2b-406e-a669-41abee137932@nwra.com>
 <ZeEYttbCcrqTUO9z@aion>
From: Orion Poplawski <orion@nwra.com>
Organization: NWRA
In-Reply-To: <ZeEYttbCcrqTUO9z@aion>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020600080003060801020901"
X-ClientProxiedBy: CY8PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:930:49::24) To MW4PR09MB9632.namprd09.prod.outlook.com
 (2603:10b6:303:1f8::17)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR09MB9632:EE_|PH8PR09MB10111:EE_
X-MS-Office365-Filtering-Correlation-Id: 773e8329-ec2d-436a-2065-08dc398315cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yPm4qfM7AHQeW7MjS4M8C7e9Z/vAUYy8bqzo+Y3OHXcweIptrCSYUVXiEUb0sDloipGeUUbPe343xW6dduZUXjzjxIBy66zI82jHlbxEw5JDA50ci3AOnM/B92TFwt6VX/Su6IQcPNXh/OOXaqWuO2by9qLjQ7QMrVKQVA46neJzyKRa0nQDzpqTpvC9QtYOmN3PKeyQkWStrIOoBshQGRIUzqFM1zu0zT8NeqLNQvnVdJ23MEpIL09YjfKplWSKSZXEgWSBtkCcwj4YLMJBDAOeaQ+hv2b8vSfbJ6PL4tge4yBEG9kf6TpApeaxzMVW7o7nKsNPplDy/JAyxTKPMrRPaCvp86k4JHtfieiCqDa3y/lxBtj8qZo/GrVoWbznN+qX8B8hpOwIt5ZrPDFw8XrJQ8SydpZgXwr7QtFHVo6zXbklhpYvvhfhXBmv04xUJT/Fv1U8GHwLJYVTD6VAHbS6mrdmzoSAaItkJXf0rtcA1rPMSZaWRiTO3dYD6Tl8X5fd5j8VLzh7fDgAf5phrdGe1uz+NdJXikq+yUO3JMLR1LfU49A29B0l4LzI6SOuFfEdHbLV7limpjiwjpIHOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR09MB9632.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW9nOWpDcU9zWWtubGxhZVIwTnBaSEMxdUpqeFpDeVpwc2FSQkZuOG00UnNz?=
 =?utf-8?B?Z1BxTVhsT0w2N1pXWDludy9pQ1hsaXU0eDRxUGJ5WnFHWmVBVjg2d29vaE9Z?=
 =?utf-8?B?VnZsQjJkOUdZRnJmRjFtSW14US9ITVFjOElnaVY4bkVnMStoOG5uc2hpTFNw?=
 =?utf-8?B?dW9hOVFtVjBpQ3c2a2lDSFpmamlZa25RWjY1aVJoMHdPZk84WVdTQVpDeTh3?=
 =?utf-8?B?TEwwd2taTmQxYUU1ZEt4ZDZQQWJ4azBRVDJ5b2tCV0pxNURFSnAwVGE3TExC?=
 =?utf-8?B?R042Mk93SFFLM01wS0c2eUVTUnN4amZIKytYZGptZGFTT0U4MVpTbzJvTTJU?=
 =?utf-8?B?cWFOUWxNRnpNV2l5TEdIK1hFbzN2L3FtOGlvWjR1a1NVeU1Rd0JRT3U1RXZT?=
 =?utf-8?B?aVMvbVQzTzhMcVNoU28yN3NCdmd5U3lZY3lNbGFzYm1YUzJOMzZMT041VUVk?=
 =?utf-8?B?N3phTm5DdGpveFQ4UWdTS3R2YnduSzZ1clpwNG4vZmNZQVNVa0kzU1dZdjZ1?=
 =?utf-8?B?Tk1SWGlxTVBFaE1yNC9hclQ3RzlsMFNHT2NlWGxOc3BXaStQRjh5M3ZJSUJB?=
 =?utf-8?B?eFJFQkg1cnlMS3Z1OHBOM0tYamxFNldWaVZJcENmcVRUUzZxYWRJRjBKd2dL?=
 =?utf-8?B?am5ORk9SV3NtWXJRaThPTUJNNUpudnFJV0FOWndHa0FOT2NXd1FkcVMycHcr?=
 =?utf-8?B?cFdhemJCa3hyQVY0UVBmaDd6ZGpSeW1LV0k1MmU3MU0xRmhNZHFzTkFTOXhs?=
 =?utf-8?B?bFRJcVRyVVNGYWdkNzZXU3VHOW5kUlRaWHVvckxJSU9qZkRGSE0rWitrSU9F?=
 =?utf-8?B?NVRJNHdiQWRPbTUrb2FydlBLUUVnUHptTm9aNDRzSVM0TEVLaEdLblpSM3JE?=
 =?utf-8?B?ajVuQU82OXM5M2NxOHJZWlRpbDhGQmlBanpLRVRRakt3aDJOMUNkanRXalRM?=
 =?utf-8?B?MlU3cEM0eGl5UE4xLys1VlFOTzlySXhFRmo3Y2xFSnFqWUplWFpFdGl2NDVm?=
 =?utf-8?B?T3lEK0FmdE5iRlpyYWJLeWJJK0N5UU0xVFlPMXBIT3VVYjBBVEQyN3RTSHEz?=
 =?utf-8?B?UTE4UEpiekJZOFJyYVB4Z1dxbS92bFVjbVZMakVXTmM1dmx6SWRKS3JOL0tB?=
 =?utf-8?B?RHk1KzcvaUFyQzRHYUsxY2Y0Z2RVeldQbGtZK2dSM0cxZ3lLbVUreXJHZGtu?=
 =?utf-8?B?a1FjWEFGbWdSYWVDL2Z4MlpvWHI1clE1S2RlQnFlQ2prUzhlYVdnaWlVVXl1?=
 =?utf-8?B?NkhDOVVjVXowLzRBYlVONFBaZk9ZemxYNllTK2xmVXZaOW16bWNWaktDL2N5?=
 =?utf-8?B?RU9SN080WlpDUkg5aUlSdjloT3RBOWFtSE1jbFRVdy9jM2NKVHJxRlRsQVBJ?=
 =?utf-8?B?bk5zb0VhQVhIUWEyWE45S1J3UUpROE5tNS96VEpCT05kbldUTmNNUHdtYkRQ?=
 =?utf-8?B?MGtTVHFKYktWM01UMVYrdloySzdzbmJON1BjSENTb1BIcTgxa0phY0dCMUwv?=
 =?utf-8?B?blhlaGtyZkU3ck5pN2YwK3RIUkx1d3VuTnhERFFUMDFpNTFmam1DVXh1V2Yz?=
 =?utf-8?B?UnhFNlAzWnVydHl4VlU3Y05HeG9BOGNJVnB5QmtOSWtHNW1aWmg3WENHSHRL?=
 =?utf-8?B?dHNad2pnb1dpRzczakNCSWtPVGJmc2dBR2lwdmRXQ0FTd1ZIL0k1MmQvcHl6?=
 =?utf-8?B?ekhJL2VUZXA3M29SdGZ4bDgvZ3dreWlrdUlmcGxKdjIwT1ZUbnhydGlCb0lM?=
 =?utf-8?B?M3l2dW1rVG9kUmlXRUFMaDEwVHJVYk9uRDNvTGttN0hNNHBQaXQ1OHA2UlR4?=
 =?utf-8?B?SFFiVlY2MEZIc0gyWSt0Ylh5RDZCZUVzcmVUbTFxRmIxSGl4UXNBZGR4WENN?=
 =?utf-8?B?SEZpS3Y0b2ZtUVREcElRMWQ0d1JwcmlmemhZVFZxK2U3V3BmaFBHYlZKd1BS?=
 =?utf-8?B?aGdIUXNJcVRWR1RoRk9mRCtSVjhCNEhUTk4xNkhwZUNoVUdyQmM2c1QyZnhs?=
 =?utf-8?B?NC9LQ3RZcEdZb3Eva21NT2h3ekRiZXFjalltVDFTU08yWHRuSWFwS29Tb2dM?=
 =?utf-8?B?Z2JHRThjN01mekVkS2ZCS0ZsT0EzUm5vd1VYN25RZ3RKL2dyZ1BCTjhXc1J6?=
 =?utf-8?Q?x3bECqyyACQcLPIcinEAO+xmh?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773e8329-ec2d-436a-2065-08dc398315cf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR09MB9632.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 00:03:55.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR09MB10111

--------------ms020600080003060801020901
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 16:52, Scott Mayhew wrote:
> On Thu, 29 Feb 2024, Orion Poplawski wrote:
> 
>> We are starting to add some EL9 clients into the mix on our network.  Autofs
>> mounts are working fine when initiated by a regular user, but they are failing
>> when initiated by root.  This works fine from our EL8 clients.
>>
>> Client:
>> kernel 5.14.0-362.18.1.el9_3.x86_64
>> nfs-utils-2.5.4-20.el9.x86_64
>>
>> Keytab name: FILE:/etc/krb5.keytab
>> KVNO Principal
>> ---- --------------------------------------------------------------------------
>>    1 host/client.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
>>    1 host/client.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)
>>
>> Server:
>> kernel 4.18.0-513.18.1.el8_9.x86_64
>> nfs-utils-2.3.3-59.el8.x86_64
>>
>> Keytab name: FILE:/etc/krb5.keytab
>> KVNO Principal
>> ---- --------------------------------------------------------------------------
>>    1 host/server.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
>>    1 host/server.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)
>>    1 nfs/server.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
>>    1 nfs/server.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)
>>
>> Client rpc.gssd:
>>
>> rpc.gssd[778]:
>>                                handle_gssd_upcall(0x7f15a0299840): 'mech=krb5
>> uid=0 enctypes=20,19,26,25,18,17' (nfs/clnt3)
>> rpc.gssd[778]: start_upcall_thread(0x7f15a0299840): created thread id
>> 0x7f159f1fe640
>> rpc.gssd[778]: krb5_use_machine_creds(0x7f159f1fe640): uid 0 tgtname (null)
>> rpc.gssd[778]: No key table entry found for client$@NWRA.COM while getting
>> keytab entry for 'client$@NWRA.COM'
>> rpc.gssd[778]: No key table entry found for CLIENT$@NWRA.COM while getting
>> keytab entry for 'SRV-MRY01$@NWRA.COM'
>> rpc.gssd[778]: No key table entry found for root/client.fqdn@NWRA.COM while
>> getting keytab entry for 'root/client.fqdn@NWRA.COM'
>> rpc.gssd[778]: No key table entry found for nfs/client.fqdn@NWRA.COM while
>> getting keytab entry for 'nfs/client.fqdn@NWRA.COM'
>> rpc.gssd[778]: find_keytab_entry(0x7f159f1fe640): Success getting keytab entry
>> for 'host/client.fqdn@NWRA.COM'
>> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
>> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
>> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
>> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
>> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating tcp client for
>> server server.fqdn
>> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating context with
>> server nfs@server.fqdn
>> rpc.gssd[778]: WARNING: Failed to create krb5 context for user with uid 0 for
>> server nfs@server.fqdn
>> rpc.gssd[778]: WARNING: Failed to create machine krb5 context with cred cache
>> FILE:/tmp/krb5ccmachine_NWRA.COM for server server.fqdn
>> rpc.gssd[778]: WARNING: Machine cache prematurely expired or corrupted trying
>> to recreate cache for server server.fqdn
>> rpc.gssd[778]: No key table entry found for client$@NWRA.COM while getting
>> keytab entry for 'client$@NWRA.COM'
>> rpc.gssd[778]: No key table entry found for CLIENT$@NWRA.COM while getting
>> keytab entry for 'SRV-MRY01$@NWRA.COM'
>> rpc.gssd[778]: No key table entry found for root/client.fqdn@NWRA.COM while
>> getting keytab entry for 'root/client.fqdn@NWRA.COM'
>> rpc.gssd[778]: No key table entry found for nfs/client.fqdn@NWRA.COM while
>> getting keytab entry for 'nfs/client.fqdn@NWRA.COM'
>> rpc.gssd[778]: find_keytab_entry(0x7f159f1fe640): Success getting keytab entry
>> for 'host/client.fqdn@NWRA.COM'
>> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
>> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
>> rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
>> 'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
>> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating tcp client for
>> server server.fqdn
>> rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating context with
>> server nfs@server.fqdn
>> rpc.gssd[778]: WARNING: Failed to create krb5 context for user with uid 0 for
>> server nfs@server.fqdn
>> rpc.gssd[778]: WARNING: Failed to create machine krb5 context with cred cache
>> FILE:/tmp/krb5ccmachine_NWRA.COM for server server.fqdn
>> rpc.gssd[778]: ERROR: Failed to create machine krb5 context with any
>> credentials cache for server server.fqdn
>> rpc.gssd[778]: do_error_downcall(0x7f159f1fe640): uid 0 err -13
>>
>> mount.nfs4: mount(2): Permission denied
>> mount.nfs4: access denied by server while mounting
>>
>> I don't seem to be getting any useful information from rpc.gssd on the server.
>>
>> Please include me in replies.
> 
> I'm pretty sure this is the same issue that would be addressed by the
> patches that I sent to the list yesterday would address:
> https://lore.kernel.org/linux-nfs/20240228222253.1080880-1-smayhew@redhat.com/T/#t
> 
> There's a couple things you could check.
> 
> 1. On the NFS server, increase the rpc debug logging just a little:
> # rpcdebug -m rpc -s auth
> 
> and then after a failure, look for lines like this in the journal:
> Feb 29 18:14:44 rhel8.smayhew.test kernel: svc: svc_authenticate (6)
> Feb 29 18:14:44 rhel8.smayhew.test kernel: gss_kerberos_mech: unsupported krb5 enctype 20
> Feb 29 18:14:44 rhel8.smayhew.test kernel: RPC:       gss_import_sec_context_kerberos: returning -22
> Feb 29 18:14:44 rhel8.smayhew.test kernel: RPC:       gss_delete_sec_context deleting 0000000090f401ca
> 
> 2. On the NFS client, increase the rpc-verbosity in the gssd stanza in
> /etc/nfs.conf (I have mine set to 3 but I think 1 would suffice) and
> then 'systemctl restart rpc-gssd'.
> 
> then after a failure, look for a line like this in the journal:
> Feb 29 18:14:44 rhel9.smayhew.test rpc.gssd[1700]: authgss_refresh: RPC: Unable to receive errno: Connection reset by peer
> 
> If you see both of those, then it's almost certainly the same issue.

Thank you!  Yes, I see both of these messages.  I guess this also explains why
I was able to mount from an EL7 server.

> A quick solution would be to do this on your NFS server:
> 
> # echo "mac@Kerberos = -HMAC-SHA2-*" >/usr/share/crypto-policies/policies/modules/NFS.pmod
> # update-crypto-policies --set DEFAULT:NFS
> # systemctl restart gssproxy
> 
> but note that would be turning off the SHA2 enctypes for everything
> krb5-related, not just NFS.  Note you can always revert that later
> simply by:
> 
> # update-crypto-policies --set DEFAULT
> # systemctl restart gssproxy
> 
> Or, you could test the patches I sent to the list yesterday (this would
> be on the client, not the server).  The problem is those patches don't
> apply cleanly to the current version of nfs-utils shipped in EL9.  At a
> quick glance, it looks like nfs-utils would need:
> 
> 49567e7d configure: check for rpc_gss_seccreate
> 15cd5666 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
> 2bfb59c6 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
> 3abf6b52 gssd: switch to using rpc_gss_seccreate()
> f05af7d9 gssd: revert commit 513630d720bd
> 20c07979 gssd: revert commit a5f3b7ccb01c
> 14ee4878 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
> 4b272471 gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
> 75b04a9b gssd: fix handling DNS lookup failure
> f066f87b gssd: enable forcing cred renewal using the keytab
> 
> and you'd also need to patch libtirpc to include:
> 
> 22b1c0c gssapi: fix rpc_gss_seccreate passed in cred

I'll take a look at these more tomorrow.  Since I see you have a @redhat.com
address, I am hoping that these fixes will flow down to EL9 sooner rather than
later.  Is there an open issue I can subscribe to to follow along?


-- 
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/


--------------ms020600080003060801020901
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ClEwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggU0MIIEHKADAgECAhBOGocb/uu4yQAAAABMPXr3MA0GCSqGSIb3DQEB
CwUAMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMw
d3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYD
VQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIg
Q2xpZW50IENBMB4XDTIzMTIxNjIxMTUyNVoXDTI2MTIxNjIxNDUyMlowgbAxCzAJBgNVBAYT
AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdTZWF0dGxlMSYwJAYDVQQKEx1O
b3J0aFdlc3QgUmVzZWFyY2ggQXNzb2NpYXRlczEbMBkGA1UEYRMSTlRSVVMrV0EtNjAwNTcz
MjUxMTUwFgYDVQQDEw9PcmlvbiBQb3BsYXdza2kwGwYJKoZIhvcNAQkBFg5vcmlvbkBud3Jh
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKn5wO5Bjob6bLDahVowly2l
AyCWBHGRq1bSptv7tXpj+Xaci4zpCqRoyqX0Gjpo8BEulUYQK8b7nO7UM3aMLC8H6vyzQ64A
GupPGIKuJg+Qr8jA0ihCVH+duE0bNXfDPTm/8VsXOubmVLPLp0cejxzrEC/RI5l8rdl0sQ+2
QZp9jTlyghB1Rxt2AYVYhVVnRMSJ8RgKp9MLV3qIfHqF1k5MGBIP6rS1afmlGd/yW9IWSB8z
iASPtr/Ml5ObbxtYZG47kCKCS7RF2rI6rGNmK/R6cITRs37dzUfBmagDFV897wAW3tHTyLQM
4vobhmS2UYi8C5voc+I75LYOsvLaXHUCAwEAAaOCAVEwggFNMA4GA1UdDwEB/wQEAwIFoDAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwBBQMBMGoG
CCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYI
KwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkG
A1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLe
a5skMB0GA1UdDgQWBBSZhCz4u7bZ2JjPtNAM8gx3QVEp1zAJBgNVHRMEAjAAMA0GCSqGSIb3
DQEBCwUAA4IBAQA2L6VG0IcimaH24eRr4+L6a/Q51YxInV1pDPt73Lr2uz9CzKWiqWgm6Ioh
O9gSEhDsAYUXED8lkJ3jId9Lo/fDj5M+13S4eChfzFb1VWyA9fBeOE+/zEYrSPQIuRUM324g
PEm8eP/mYaZzHXoA0RJC7jyZlLRdzu/kGqUQDr+81YnkXoyoKc8WeNZnSQSL+LqRvPJCcCTu
JbCdd7C8zYW1dRgh4d9hYooUSsKTsSeDoRkFyqk4ZH0V3PFqa2HiFrdi8h3vpBX44VFddyaa
e+ekomLvvVZWGtJgXWr6VEBo8PTah0fw8BQjCIfFym44D9dulz1YW7E6FRPMSZ7x8X3UMYIE
XzCCBFsCAQEwgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJYIZIAWUDBAIBBQCgggJ1
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMwMTAwMDM1
MlowLwYJKoZIhvcNAQkEMSIEICO1yVU1tbttexaZIx1mDjeH6J/oZhYHO5L8mg0Bwc9pMGwG
CSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgw
gcsGCSsGAQQBgjcQBDGBvTCBujCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3Qs
IEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5
IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZ
RW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIQThqHG/7ruMkAAAAATD169zCBzQYLKoZIhvcN
AQkQAgsxgb2ggbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJKoZIhvcNAQEBBQAEggEA
nXxu8wDqL/uUiCK0iKIioeNrX9XEAsLYmJwlGqujske/U4do4Xj9Lcz88rexpQJD9sYTk/Ir
aPj8HqDL1DFf7RyF7NJNbORUQLoAF8ExvCjNVQfMYwZVCgp0JwU5Gsr+/IHlp5S2D5vgQjpd
1HTMzgFxLBVwEctyov1nidMlu/Ok8wGjeXs7yRHXHSTKtWdj12Xy690nHBo9cIFL9QnaDx9f
d5iXzPY5SqKA8APS2AZAPdHQiD+8qQJsapIHd0y5Q2XcSerz8rESIpx1jYGAZxN2rDsZAQyb
J07KlbEDKW2dcI5zbhQo9D6MEqC59EhM1YUOJNvUy2gk1W86QdtmdQAAAAAAAA==

--------------ms020600080003060801020901--

